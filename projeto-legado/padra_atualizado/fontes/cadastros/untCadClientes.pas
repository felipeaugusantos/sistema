{***************************}
{* qryConAti -> CADATI     *}
{* qryConCid -> CADCID     *}
{* qryConCiC -> CADCID(COB)*}
{* qryConCiE -> CADCID(ENT)*}
{* qryConClg ->            *}
{* qryConPor -> CADPOR     *}
{* qryConDiv -> CADDIV     *}
{************************JB*}
{***************************}
{* qryTipClg -> TIPCLG     *}
{* qryCadAti -> CADATI     *}
{* qryCadCid -> CADCID     *}
{* qryCadFic -> CADFIC     *}
{* qryInfCre -> CLI_INFCRE *}
{************************RV*}
unit untCadClientes;

interface

uses
  Windows, Classes, Controls, Forms, StdCtrls, untPaiCad, untPaiSimples, ComCtrls, Buttons,
  ExtCtrls, Mask, untCliVei, DBCtrls, DBEditFocus, Uni, EditFocus, DB, untZClient,
  untCliPro, QColorLabel, Menus, DBMemoFocus, untRedeLojas, DBComboBoxFocus,
  AppEvnts, untCliCtt, Grids, DBGridCitel, DBGrids, MaskEditFocus, UniClientDataSet, Contnrs,
  untCadCliEndEntrega,untConsultaSCPCBoaVistaSophus, untCadCliFazendas, UniDataSetProvider, untTypesSistema,
  ComboBoxFocus, untOrdemPageControl, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxCheckBox, untCliRco, MemoFocus, untHelperCitel,
  CheckLst, BitBtnLockedIncrem, untMskTelefone, cxHint, cxProgressBar, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, dxScreenTip, dxCustomHint, MemDS, DBAccess,
  Provider, ImgList, frxClass, frxExportCSVTestabilidade, System.ImageList,
  Datasnap.DBClient, cxGridCitel, untLogAltCadCli, untFuncoesGenerica,
  cxCalendar, cxTimeEdit, DBLookupComboBoxFocus, untLiberacao, untImagens, untFuncoesImagem,
  cxDataControllerConditionalFormattingRulesManagerDialog, untMskC_G_C_, untExcel, Dialogs,
  untLabelRg, untLabelCgcCpf, untLabelCgc, Winapi.Messages, cxContainer, cxImage, DateUtils,
  cxGridBandedTableView, cxGridDBBandedTableView, untConsultaEndereco,
  cxImageList, dxGDIPlusClasses, untMostraDebCtrChq2, untFrameClienteResumo,
  untConsultaSerasaPowerCurve, Navegador.Interfaces, Navegador.Classes.TNavegador, Navegador.View.Help,
  Math, untConsultaSerasaExperian, untDBECgcCpf, untDBETipoCgcCpf;
Type
 TSituacaoTributariaIPI = (sitIPITributado, sitIPIIsento, sitIPIImune, sitIPISuspenso, sitIPINaoTributado);

type
  TfrmCadClientes = class(TfrmPaiCad)
    tbsObservacoes: TTabSheet;
    tbsCbrEnt: TTabSheet;
    tbsQuadSoc: TTabSheet;
    tbsRefBan: TTabSheet;
    tbsRefCom: TTabSheet;
    tbsCrediario: TTabSheet;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    dbeNomBc1: TDBEditFocus;
    dbeAgeBc1: TDBEditFocus;
    Label88: TLabel;
    Label89: TLabel;
    dbeTelBc1: TDBEditFocus;
    Label90: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    dbeNomBc2: TDBEditFocus;
    dbeAgeBc2: TDBEditFocus;
    Label93: TLabel;
    Label94: TLabel;
    dbeTelBc2: TDBEditFocus;
    Label95: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    dbeNomBc3: TDBEditFocus;
    dbeAgeBc3: TDBEditFocus;
    Label98: TLabel;
    Label99: TLabel;
    dbeTelBc3: TDBEditFocus;
    Label100: TLabel;
    Label117: TLabel;
    dbeNomPai: TDBEditFocus;
    Label118: TLabel;
    dbeNomMae: TDBEditFocus;
    Label119: TLabel;
    dbeConjug: TDBEditFocus;
    Label120: TLabel;
    dbeNasCon: TDBEditFocus;
    Label121: TLabel;
    dbeProfis: TDBEditFocus;
    Label122: TLabel;
    dbeTrabal: TDBEditFocus;
    Label123: TLabel;
    dbeEndSer: TDBEditFocus;
    Label124: TLabel;
    Label125: TLabel;
    dbeTemSer: TDBEditFocus;
    Label126: TLabel;
    dbeTelSer: TDBEditFocus;
    Label127: TLabel;
    dbeSalari: TDBEditFocus;
    Label128: TLabel;
    dbeOutRen: TDBEditFocus;
    Label129: TLabel;
    dbeVrAlug: TDBEditFocus;
    Label130: TLabel;
    dbeC_Prof: TDBEditFocus;
    Label131: TLabel;
    Label132: TLabel;
    dbeEndIm1: TDBEditFocus;
    dbeValIm1: TDBEditFocus;
    Label133: TLabel;
    Label134: TLabel;
    dbeEndIm2: TDBEditFocus;
    dbeValIm2: TDBEditFocus;
    Label135: TLabel;
    Label136: TLabel;
    dbeVeicul: TDBEditFocus;
    dbeValVei: TDBEditFocus;
    Label137: TLabel;
    Label138: TLabel;
    Label164: TLabel;
    Label173: TLabel;
    Panel2: TPanel;
    Label29: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label44: TLabel;
    dbeUltCom: TDBEditFocus;
    Label30: TLabel;
    Label46: TLabel;
    dbeVlrUco: TDBEditFocus;
    Label32: TLabel;
    dbeVrmCom: TDBEditFocus;
    dbeDtmCom: TDBEditFocus;
    Label33: TLabel;
    dbeDouCom: TDBEditFocus;
    Label34: TLabel;
    dbeDomCom: TDBEditFocus;
    pnlFundo1: TPanel;
    pnlForPag: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LabelRg: TLabelRG;
    Label12: TLabelCgcCpf;
    Label10: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label36: TLabel;
    Label38: TLabel;
    Label40: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label37: TLabel;
    ColorLabel1: TColorLabel;
    ColorLabel2: TColorLabel;
    Label27: TLabel;
    clbPrcVenda: TColorLabel;
    dbeCodCli: TDBEditFocus;
    dbeDtaCad: TDBEditFocus;
    dbeNomCli: TDBEditFocus;
    dbeFanSob: TDBEditFocus;
    dbeEndere: TDBEditFocus;
    dbeBairro: TDBEditFocus;
    dbeNumCep: TDBEditFocus;
    dbeNumRg: TDBEditFocus;
    dbeCgcCpf: TDBEditTipoCgcCpf;
    dbeNuCpnj: TDBEditCgcCpf;
    dbeNumIes: TDBEditFocus;
    dbeNumImp: TDBEditFocus;
    dbeFone01: TDBEditFocus;
    dbeRamal1: TDBEditFocus;
    dbeFone02: TDBEditFocus;
    dbeRama2: TDBEditFocus;
    dbeNumFax: TDBEditFocus;
    dbeRama3: TDBEditFocus;
    dbeNumCel: TDBEditFocus;
    dbeDtaNas: TDBEditFocus;
    dbeCaiPos: TDBEditFocus;
    dbeContat: TDBEditFocus;
    dbeEmail: TDBEditFocus;
    dbeHomPag: TDBEditFocus;
    dbeConsum: TDBEditFocus;
    dbeCodVen: TDBEditFocus;
    dbeCodRep: TDBEditFocus;
    dbeCodAti: TDBEditFocus;
    dbeLimCre: TDBEditFocus;
    dbeUltAlt: TDBEditFocus;
    dbeCodCid: TDBEditFocus;
    dbeStatus: TDBEditFocus;
    edtNomCid: TEditFocus;
    edtEstado: TEditFocus;
    edtVendedor: TEditFocus;
    edtAtividade: TEditFocus;
    edtRepresentante: TEditFocus;
    dbeTabPre: TDBEditFocus;
    lblForPag: TLabel;
    dbeCodFpg: TDBEditFocus;
    edtDesFpg: TEditFocus;
    pnlTipCli: TPanel;
    Label35: TLabel;
    Label41: TLabel;
    dbeTipCli: TDBEditFocus;
    edtDesTpc: TEditFocus;
    Label45: TLabel;
    pnlCadPor: TPanel;
    Label50: TLabel;
    dbeCodPor: TDBEditFocus;
    edtDesPor: TEditFocus;
    tbsGeral2: TTabSheet;
    Panel3: TPanel;
    Bevel1: TBevel;
    tbsContato: TTabSheet;
    dtsCliCtt: TDataSource;
    cdsCliCtt: TUniClientDataSet;
    cdsCliCttAUTCTT: TStringField;
    cdsCliCttCPFCTT: TStringField;
    cdsCliCttRG_CTT: TStringField;
    cdsCliCttNOMCTT: TStringField;
    cdsCliCttENDCTT: TStringField;
    cdsCliCttBAICTT: TStringField;
    cdsCliCttNOMCID: TStringField;
    cdsCliCttESTCID: TStringField;
    cdsCliCttTELCTT: TStringField;
    cdsCliCttCELCTT: TStringField;
    cdsCliCttFAXCTT: TStringField;
    cdsCliCttDEPCTT: TStringField;
    cdsCliCttEMACTT: TStringField;
    cdsCliCttCODCID: TStringField;
    Label185: TLabel;
    dbeFicNCom01: TDBEditFocus;
    Label186: TLabel;
    Label187: TLabel;
    dbeFicNCom02: TDBEditFocus;
    Label188: TLabel;
    dbeFicNCom03: TDBEditFocus;
    Label189: TLabel;
    dbeEndNum: TDBEditFocus;
    Label190: TLabel;
    dbeEndCom: TDBEditFocus;
    Label192: TLabel;
    dbeEmailNfe2: TDBEditFocus;
    dbeConBc1: TDBMemoFocus;
    dbeConBc2: TDBMemoFocus;
    dbeConBc3: TDBMemoFocus;
    pnlCompGrp1: TPanel;
    lblDesCon: TLabel;
    lblPerDes: TLabel;
    dbeDescon: TDBEditFocus;
    pnlCompGrp3: TPanel;
    lblEmpRCF: TLabel;
    dbeCodEmpRCF: TDBEditFocus;
    edtDesEmpRCF: TEditFocus;
    pnlCompGrp4: TPanel;
    Bevel2: TBevel;
    dbePlaNco: TDBEditFocus;
    lblDesPlaCon: TLabel;
    Label156: TLabel;
    Label148: TLabel;
    edtCodEmpresa: TDBEditFocus;
    dbcCategoria: TDBComboBoxFocus;
    edtDesEmpresa: TEditFocus;
    Label198: TLabel;
    dbeSupGer: TDBEditFocus;
    edtSupGer: TEditFocus;
    Label199: TLabel;
    dbeSupReg: TDBEditFocus;
    edtSupReg: TEditFocus;
    Label200: TLabel;
    dbeEmailNFe: TDBEditFocus;
    tbsEntregas: TTabSheet;
    pnlEntregas: TPanel;
    tbsClienteProduto: TTabSheet;
    dtsCliPro: TDataSource;
    pnlProdutos: TPanel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    edtCod_NF: TEditFocus;
    pnl2: TPanel;
    lbl1: TLabel;
    dtsTabela: TDataSource;
    edtTotRen: TEditFocus;
    dtsCadFic: TDataSource;
    edtCadCac: TDBEditFocus;
    edtDesCadCac: TEditFocus;
    Label57: TLabel;
    spbFone2: TSpeedButton;
    spbFone1: TSpeedButton;
    spbCel: TSpeedButton;
    tbsDadosFiscais: TTabSheet;
    lblRegiao: TLabel;
    Label58: TLabel;
    dbeCodReg: TDBEditFocus;
    edtDesReg: TEditFocus;
    dbeCodRed: TDBEditFocus;
    edtDesRed: TEditFocus;
    pnlPeMIFF: TPanel;
    lblPermFF: TLabel;
    clbPermFF: TColorLabel;
    dbePermFF: TDBEditFocus;
    gbCluFid: TGroupBox;
    Label158: TLabel;
    ColorLabel18: TColorLabel;
    Label163: TLabel;
    dbeCluFid: TDBEditFocus;
    dbeDtaFid: TDBEditFocus;
    pnlObserv: TPanel;
    Label47: TLabel;
    dbeObserv: TDBMemoFocus;
    lblPerEmp: TLabel;
    dbePeEmp: TDBEditFocus;
    dbePeEmp_S_N_: TColorLabel;
    pnlMsgDirAlqRet: TPanel;
    grbConsulta: TGroupBox;
    Label150: TLabel;
    pnlConsulta: TPanel;
    Label151: TLabel;
    Label152: TLabel;
    Label153: TLabel;
    Label154: TLabel;
    dbeDtaCon: TDBEditFocus;
    dbeQrdPro: TDBEditFocus;
    dbeCheDev: TDBEditFocus;
    dbeObsCon: TDBMemoFocus;
    Label60: TLabel;
    cbxRgEst: TComboBoxFocus;
    edtRgExp: TEditFocus;
    lblEstadoEmissor: TLabel;
    edtEstEmiCpf: TEditFocus;
    dtsInfCre: TDataSource;
    Label63: TLabel;
    cbxSexo: TComboBoxFocus;
    Label64: TLabel;
    cbxEscolaridade: TComboBoxFocus;
    dbeReside: TDBEditFocus;
    Label65: TLabel;
    cbxEstCiv: TComboBoxFocus;
    cbxMoradia: TComboBoxFocus;
    Label147: TLabel;
    dbeAvalis: TDBEditFocus;
    edtDesAvalis: TEditFocus;
    dbcVisa__: TDBCheckBox;
    dbcMaster: TDBCheckBox;
    dbcHiperc: TDBCheckBox;
    dbcAmeric: TDBCheckBox;
    dbcDiners: TDBCheckBox;
    Label149: TLabel;
    Label157: TLabel;
    DBEditFocus4: TDBEditFocus;
    Label202: TLabel;
    dbeNacion: TDBEditFocus;
    edtDesNacion: TEditFocus;
    Label203: TLabel;
    dbeNatura: TDBEditFocus;
    edtDesNatura: TEditFocus;
    Label204: TLabel;
    dbeMsgPed: TDBEditFocus;
    mnuOpcoesPageControl: TPopupMenu;
    mnuAtivarMododeOrdenacao: TMenuItem;
    Label205: TLabel;
    dbeMotOut: TDBEditFocus;
    pnlPerCom: TPanel;
    Label207: TLabel;
    dbePerCom: TDBEditFocus;
    Label208: TLabel;
    dbeOpeAlt: TDBEditFocus;
    edtNomOpe: TEditFocus;
    lbl5: TLabel;
    tbsCliCnd: TTabSheet;
    pnlCodCnd: TPanel;
    pnlConPag: TPanel;
    lblCndPag: TLabel;
    edtCodCnd: TEditFocus;
    Label210: TLabel;
    mskConPag: TMaskEditFocus;
    edtDesCnd: TEditFocus;
    cdsCliCnd: TUniClientDataSet;
    dtsCliCnd: TDataSource;
    cdsCliCndAUTOINCREM: TStringField;
    cdsCliCndCND_CODCLI: TStringField;
    cdsCliCndCND_CODCND: TStringField;
    cdsCliCndCND_SUGEST: TStringField;
    cdsCliCndCND_DESCRI: TStringField;
    cxgCliCndView: TcxGridDBTableView;
    cxgCliCnd: TcxGridLevel;
    cxgConPag: TcxGrid;
    cxgColCodCnd: TcxGridDBColumn;
    cxgColDescri: TcxGridDBColumn;
    cxgColCndPag: TcxGridDBColumn;
    cxgColSugest: TcxGridDBColumn;
    cdsCliCndCND_CNDPAG: TStringField;
    lbl6: TLabel;
    dbeCodDcr: TDBEditFocus;
    lbl7: TLabel;
    dbeNEXTEL: TDBEditFocus;
    spbNex: TSpeedButton;
    dtsCliRco: TDataSource;
    cdsCliRco: TUniClientDataSet;
    cdsCliRcoCODCLI: TStringField;
    cdsCliRcoEMPRCO: TStringField;
    cdsCliRcoCGCCPF: TStringField;
    cdsCliRcoCGCEMP: TStringField;
    cdsCliRcoTELEMP: TStringField;
    cdsCliRcoCONEMP: TMemoField;
    cdsCliRcoEMAIL_: TStringField;
    cdsCliRcoDTACON: TDateTimeField;
    cdsCliRcoNOMINF: TStringField;
    cdsCliRcoDTAPCO: TDateTimeField;
    cdsCliRcoVALPCO: TFloatField;
    cdsCliRcoDTAMCO: TDateTimeField;
    cdsCliRcoVALMCO: TFloatField;
    cdsCliRcoDTAUCO: TDateTimeField;
    cdsCliRcoVALUCO: TFloatField;
    cdsCliRcoCODOPE: TStringField;
    cdsCliRcoCODEMP: TStringField;
    pnlRefComerciais: TPanel;
    Label103: TLabel;
    Label105: TLabel;
    Label104: TLabel;
    Label106: TLabel;
    Label182: TLabel;
    edtEmpRco: TEditFocus;
    edtCgcCpf: TEditFocus;
    mmConEmp: TMemoFocus;
    edtEmaEmp: TEditFocus;
    edtCgcEmp: TMaskEditFocus;
    Label101: TLabel;
    edtDtaCon: TMaskEditFocus;
    Label102: TLabel;
    Label107: TLabel;
    edtNomInf: TEditFocus;
    Label108: TLabel;
    edtPriCom: TMaskEditFocus;
    Label109: TLabel;
    Label110: TLabel;
    edtMaiCom: TMaskEditFocus;
    edtVMaCom: TEditFocus;
    Label111: TLabel;
    edtUltCom: TMaskEditFocus;
    Label112: TLabel;
    edtVUlCom: TEditFocus;
    Label113: TLabel;
    Panel4: TPanel;
    Label114: TLabel;
    dbgCliRco: TDBGridCitel;
    Label115: TLabel;
    edtCodOpe: TEditFocus;
    edtDesCodOpe: TEditFocus;
    cdsCliRcoDESOPE: TStringField;
    edtVPrCom: TEditFocus;
    Label183: TLabel;
    cdsCliCttCGOCTT: TStringField;
    cdsCliCttNOMCGO: TStringField;
    cdsCliCttDPTCTT: TStringField;
    cdsCliCttNOMDPT: TStringField;
    cdsCliCttTFUCTT: TStringField;
    cdsCliCttNOMTFU: TStringField;
    cdsCliCttHOBCTT: TStringField;
    cdsCliCttNOMHOB: TStringField;
    cdsCliCttESCCTT: TStringField;
    cdsCliCttNOMESC: TStringField;
    cdsCliCttGMUCTT: TStringField;
    cdsCliCttNOMGMU: TStringField;
    cdsCliCttECICTT: TStringField;
    cdsCliCttNOMECI: TStringField;
    cdsCliCttNASCTT: TDateField;
    cdsCliCttTEMEMP: TStringField;
    cdsCliCttTEMSEG: TStringField;
    cdsCliCttQTDFIL: TIntegerField;
    cdsCliCttCERCTT: TMemoField;
    pnlCompGrp2: TPanel;
    gpbServico: TGroupBox;
    lbl10: TLabel;
    lbl11: TLabel;
    dbeCodObr: TDBEditFocus;
    dbeCodART: TDBEditFocus;
    dbeCodSub: TDBEditFocus;
    lbl12: TLabel;
    edtDesSub: TEditFocus;
    btnObsCli: TBitBtnLocked;
    btnHisDeb: TBitBtnLocked;
    btnResFin: TBitBtnLocked;
    btnVenCli: TBitBtnLocked;
    btnContratos: TBitBtnLocked;
    btnFichaCli: TBitBtnLocked;
    btnInfCobr: TBitBtnLocked;
    btnLogAlter: TBitBtnLocked;
    btnTeleatendimento: TBitBtnLocked;
    btnCadDiv: TBitBtnLocked;
    btnConSCPC: TBitBtnLocked;
    btnAdicionarRco: TBitBtnLocked;
    btnCancelaRco: TBitBtnLocked;
    btnAdicionarProd: TBitBtnLocked;
    btnCancelaProd: TBitBtnLocked;
    btnIncCnd: TBitBtnLocked;
    ColorLabel7: TColorLabel;
    pnlDiaFix: TPanel;
    gpbDiaMes: TGroupBox;
    lstDiaMes: TCheckListBox;
    gpbDiaFix: TGroupBox;
    lstDiaFix: TCheckListBox;
    cdsCliCttOBSCTT: TStringField;
    pnlAtrMax: TPanel;
    lblAtrMax: TLabel;
    dbeAtrMax: TDBEditFocus;
    lbl15: TLabel;
    dbeRevist: TDBEditFocus;
    ColorLabel28: TColorLabel;
    Label52: TLabel;
    dbeCodPor2: TDBEditFocus;
    edtDesPor2: TEditFocus;
    edtTelEmp: TMaskEditTelefone;
    chkIESUni: TDBCheckBox;
    HintControler: TcxHintStyleController;
    btnAltPar: TBitBtnLocked;
    tbsCliVei: TTabSheet;
    pnlCliVei: TPanel;
    btnAddVei: TBitBtnLocked;
    btnCanVei: TBitBtnLocked;
    pnl3: TPanel;
    lbl20: TLabel;
    dbgCliVei: TDBGridCitel;
    dtsCliVei: TDataSource;
    cdsCliVei: TUniClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    cdsCliVeiANOVEI: TStringField;
    cdsCliVeiVEIATI: TStringField;
    lbl16: TLabel;
    mskPlaVei: TMaskEditFocus;
    lbl18: TLabel;
    edtModVei: TEditFocus;
    lbl19: TLabel;
    edtMarVei: TEditFocus;
    lbl21: TLabel;
    edtCorVei: TEditFocus;
    lbl22: TLabel;
    edtAnoVei: TEditFocus;
    lbl23: TLabel;
    ColorLabel30: TColorLabel;
    edtVeiAti: TEditFocus;
    dbeFabDes: TDBEditFocus;
    lblFabDes: TLabel;
    dbgProdutos: TcxGrid;
    dbgProdutosDBTableView1: TcxGridDBTableView;
    dbgProdutosLevel1: TcxGridLevel;
    dbgProdutosCODPRO: TcxGridDBColumn;
    dbgProdutosNOMPRO: TcxGridDBColumn;
    dbgProdutosUNIDAD: TcxGridDBColumn;
    dbgProdutosCOD_NF: TcxGridDBColumn;
    Panel5: TPanel;
    Label222: TLabel;
    btnAbrirPastaCredito: TBitBtnLocked;
    tbsConVis: TTabSheet;
    rdgDiaVis: TGroupBox;
    chkSeg: TCheckBox;
    chkTer: TCheckBox;
    chkQua: TCheckBox;
    chkSab: TCheckBox;
    chkSex: TCheckBox;
    chkQui: TCheckBox;
    rdgPerVis: TGroupBox;
    rdbSemanal: TRadioButton;
    rdbQuinzenal: TRadioButton;
    rdbMensal: TRadioButton;
    chkProRur: TDBCheckBox;
    chkMicEmp: TDBCheckBox;
    tbsCliDiv: TTabSheet;
    pnlCodDiv: TPanel;
    Label224: TLabel;
    edtCodDiv: TEditFocus;
    edtNomDiv: TEditFocus;
    btnIncDiv: TBitBtnLocked;
    cxgCliDiv: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    qryCliDiv: TUniQuery;
    dtsCliDiv: TDataSource;
    cdsCliDiv: TUniClientDataSet;
    dspCliDiv: TUniDataSetProvider;
    cdsCliDivDIV_CODCLI: TStringField;
    cdsCliDivDIV_SUGEST: TStringField;
    cdsCliDivDIV_NOMDIV: TStringField;
    cdsCliDivDIV_NOMATI: TStringField;
    cxGridDBColumn1: TcxGridDBColumn;
    cdsCliDivDIV_CODDIV: TStringField;
    pnlInfDeletar: TPanel;
    Label225: TLabel;
    pnlComPro: TPanel;
    Label226: TLabel;
    Label227: TLabel;
    dbeComPro: TDBEditFocus;
    tbsCliConconEmp: TTabSheet;
    Panel7: TPanel;
    Label228: TLabel;
    Label229: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    edtConcon: TEditFocus;
    pnlCampos: TPanel;
    btnIncluirCC: TBitBtnLocked;
    btnGravarCC: TBitBtnLocked;
    btnAlterarCC: TBitBtnLocked;
    btnExcluirCC: TBitBtnLocked;
    btnCancelarCC: TBitBtnLocked;
    tbsFazendas: TTabSheet;
    pnlFazendas: TPanel;
    grdEmpCli: TDBGridCitel;
    dtsEmpCli: TDataSource;
    cdsEmpCli: TUniClientDataSet;
    cdsEmpCliCodEmp: TStringField;
    cdsEmpCliNomEmp: TStringField;
    cdsEmpCliConcon: TStringField;
    cdsEmpCliCodigo: TStringField;
    cdsEmpCliAUTOINCREM: TStringField;
    dbchkDesmembr: TDBCheckBox;
    tbsBairroAtende: TTabSheet;
    dbgCliBat: TDBGridCitel;
    Panel8: TPanel;
    Label234: TLabel;
    dbgProdutosCODBAR: TcxGridDBColumn;
    lblBar_CP: TLabel;
    edtBar_CP: TEditFocus;
    lblBar_CP_Legenda: TLabel;
    pnlTipAbf: TPanel;
    lblAbfTit: TLabel;
    lblAbfDes: TLabel;
    btnAbf: TBitBtnLocked;
    lblMarca: TLabel;
    dbeMarca: TDBEditFocus;
    cdsCliCttAUTOINCREM: TStringField;
    lblTipAti: TLabel;
    dbcTipAti: TDBComboBoxFocus;
    lblCorres: TLabel;
    dbeCorres: TDBEditFocus;
    edtCorres: TEditFocus;
    Label247: TLabel;
    dbgProdutosDES_NF: TcxGridDBColumn;
    edtDes_NF: TEditFocus;
    tbsIntVen: TTabSheet;
    Panel9: TPanel;
    Label250: TLabel;
    Label251: TLabel;
    edtCrmFor: TEditFocus;
    edtDesFor: TEditFocus;
    btnAddCrmFor: TBitBtnLocked;
    cxgCliFor: TcxGridCitel;
    cxgCliForTableView: TcxGridDBTableViewCitel;
    cxgCliForTableViewColumn1: TcxGridDBColumn;
    cxgCliForTableViewColumn2: TcxGridDBColumn;
    cxgCliForLevel: TcxGridLevel;
    grbMedCom: TGroupBox;
    edtVal3Me: TEditFocus;
    edtMar3Me: TEditFocus;
    Label252: TLabel;
    lblMar03M: TLabel;
    Label254: TLabel;
    Bevel3: TBevel;
    edtVal6Me: TEditFocus;
    edtMar6Me: TEditFocus;
    Label255: TLabel;
    lblMar06M: TLabel;
    Label257: TLabel;
    Bevel4: TBevel;
    edtVal12M: TEditFocus;
    edtMar12M: TEditFocus;
    Label258: TLabel;
    lblMar12M: TLabel;
    Label260: TLabel;
    btnCalcCompraMensal: TBitBtnLocked;
    btnCliVen: TBitBtnLocked;
    tshEmbarcacoes: TTabSheet;
    grbEmbarcacoes: TGroupBox;
    grdCadEmb: TcxGridCitel;
    grdCadEmbDados: TcxGridDBTableViewCitel;
    grdCadEmbLvl1: TcxGridLevel;
    lblEmbarcacao: TLabel;
    edtCodEmb: TEditFocus;
    edtDesEmb: TEditFocus;
    dtsCadEmb: TDataSource;
    grdCadEmbDadosEMB_CODEMB: TcxGridDBColumn;
    grdCadEmbDadosEMB_NOMEMB: TcxGridDBColumn;
    grdCadEmbDadosEMB_NUMIMO: TcxGridDBColumn;
    grdCadEmbDadosEMB_INSCRI: TcxGridDBColumn;
    grdCadEmbDadosEMB_INDEMB: TcxGridDBColumn;
    grdCadEmbDadosEMB_PORTOI: TcxGridDBColumn;
    grdCadEmbDadosEMB_PORTE_: TcxGridDBColumn;
    grdCadEmbDadosEMB_COMPRI: TcxGridDBColumn;
    grdCadEmbDadosEMB_ARQBRU: TcxGridDBColumn;
    grdCadEmbDadosEMB_OBSERV: TcxGridDBColumn;
    cdsCadEmb: TUniClientDataSet;
    cdsCadEmbAUTOINCREM: TStringField;
    cdsCadEmbEMB_CODEMB: TStringField;
    cdsCadEmbEMB_NUMIMO: TStringField;
    cdsCadEmbEMB_INSCRI: TStringField;
    cdsCadEmbEMB_NOMEMB: TStringField;
    cdsCadEmbEMB_INDEMB: TStringField;
    cdsCadEmbEMB_PORTOI: TStringField;
    cdsCadEmbEMB_LOCEMB: TStringField;
    cdsCadEmbEMB_PORTE_: TStringField;
    cdsCadEmbEMB_COMPRI: TFloatField;
    cdsCadEmbEMB_ARQBRU: TIntegerField;
    cdsCadEmbEMB_OBSERV: TStringField;
    btnGravarEmb: TBitBtnLocked;
    chkCpfDev: TCheckBox;
    dbeCpfDev: TDBEditCgcCpf;
    pgDadosFiscais: TPageControl;
    TabGeral: TTabSheet;
    TabOrgPublico: TTabSheet;
    lblLatitu: TLabel;
    dbeLatitu: TDBEditFocus;
    dbeLongit: TDBEditFocus;
    lblLongit: TLabel;
    lblRaio__: TLabel;
    dbeRaio__: TDBEditFocus;
    spbDicaAbas: TSpeedButton;
    spbFax: TSpeedButton;
    imglStatus: TImageList;
    btnHeranca: TBitBtnLocked;
    TabConstrutora: TTabSheet;
    btnConsultaFit: TBitBtnLocked;
    cdsCadEmbCLIEMB_AUTINC: TStringField;
    cdsCliRcoCNPJ_CPF: TStringField;
    cdsCliRcoAUTINC: TStringField;
    shpDesPro: TShape;
    grbDadosCobranca: TGroupBox;
    Label48: TLabel;
    Label49: TLabel;
    Label51: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label167: TLabel;
    Label168: TLabel;
    Label28: TLabel;
    ColorLabel27: TColorLabel;
    lbl24: TLabel;
    clb3: TColorLabel;
    lblPerDPo: TLabel;
    lblPercn2: TLabel;
    lblQtdDAV: TLabel;
    Label263: TLabel;
    dbeEndCob: TDBEditFocus;
    dbeCidCob: TDBEditFocus;
    dbeCepCob: TDBEditFocus;
    dbeBaiCob: TDBEditFocus;
    dbeConCob: TDBEditFocus;
    dbeTelCob: TDBEditFocus;
    edtCidCob: TEditFocus;
    edtEstCob: TEditFocus;
    dbeEMCOB1: TDBEditFocus;
    dbeEMCOB2: TDBEditFocus;
    dbeEnvBol: TDBEditFocus;
    dbeBolImp: TDBEditFocus;
    dbePerDPo: TDBEditFocus;
    dbeQtdDAV: TDBEditFocus;
    dbeDtCoCb: TDBEditFocus;
    tbsDatasControle: TTabSheet;
    gpbCtrFat: TGroupBox;
    gpbCtrEnt: TGroupBox;
    gpb: TGroupBox;
    GroupBox5: TGroupBox;
    lstDiaMesPerEnt: TCheckListBox;
    GroupBox6: TGroupBox;
    lstDiaSemPerFat: TCheckListBox;
    gpbPagFixMes: TGroupBox;
    lstDiaMesPerFat: TCheckListBox;
    cxgDiaSemEntLevel: TcxGridLevel;
    cxgDiaSemEnt: TcxGridCitel;
    cdsDtaPerEnt: TUniClientDataSet;
    dtsDtaPerEnt: TDataSource;
    cdsDtaPerEntMARCAD: TBooleanField;
    cdsDtaPerEntSEMANA: TStringField;
    cdsDtaPerEntHRAINI: TTimeField;
    cdsDtaPerEntHRAFIN: TTimeField;
    cdsDtaPerEntHRAIN2: TTimeField;
    cdsDtaPerEntHRAFI2: TTimeField;
    cdsDtaPerEntHRAIN3: TTimeField;
    cdsDtaPerEntHRAFI3: TTimeField;
    cdsDtaPerEntDAYOFW: TIntegerField;
    cxgDiaSemEntView: TcxGridDBBandedTableViewCitel;
    cxgDiaSemEntViewColumn1: TcxGridDBBandedColumn;
    cxgDiaSemEntViewColumn2: TcxGridDBBandedColumn;
    cxgDiaSemEntViewColumn3: TcxGridDBBandedColumn;
    cxgDiaSemEntViewColumn4: TcxGridDBBandedColumn;
    cxgDiaSemEntViewColumn5: TcxGridDBBandedColumn;
    cxgDiaSemEntViewColumn6: TcxGridDBBandedColumn;
    cxgDiaSemEntViewColumn7: TcxGridDBBandedColumn;
    cxgDiaSemEntViewColumn8: TcxGridDBBandedColumn;
    pnlGrupoRisco: TPanel;
    Label264: TLabel;
    shpGrupoRisco: TShape;
    cbxGrupoRisco: TDBLookupComboBoxFocus;
    pnlDadosContatos: TPanel;
    pnlContatos: TPanel;
    Label169: TLabel;
    Label170: TLabel;
    Label171: TLabel;
    Label172: TLabel;
    Label174: TLabel;
    Label175: TLabel;
    Label176: TLabel;
    Label178: TLabel;
    Label179: TLabel;
    Label180: TLabel;
    Label184: TLabel;
    Label211: TLabel;
    Label212: TLabel;
    Label213: TLabel;
    Label214: TLabel;
    Label215: TLabel;
    Label216: TLabel;
    lblTempEmp: TLabel;
    Label218: TLabel;
    Label219: TLabel;
    Label220: TLabel;
    Label221: TLabel;
    lbl14: TLabel;
    edtNomCtt: TEditFocus;
    edtEndCtt: TEditFocus;
    edtBaiCtt: TEditFocus;
    edtDesCidCtt: TEditFocus;
    edtCidCtt: TEditFocus;
    edtEstadoCtt: TEditFocus;
    edtEmaCtt: TEditFocus;
    edtDepCtt: TEditFocus;
    edtNasCtt: TMaskEditFocus;
    edtCgoCtt: TEditFocus;
    edtDesCgoCtt: TEditFocus;
    edtDptCtt: TEditFocus;
    edtDesDptCtt: TEditFocus;
    edtTfuCtt: TEditFocus;
    edtDesTfuCtt: TEditFocus;
    edtHobCtt: TEditFocus;
    edtDesHobCtt: TEditFocus;
    edtEscCtt: TEditFocus;
    edtDesEscCtt: TEditFocus;
    edtDesGmuCtt: TEditFocus;
    edtGmuCtt: TEditFocus;
    edtEciCtt: TEditFocus;
    edtDesEciCtt: TEditFocus;
    edtTemSeg: TEditFocus;
    edtTemEmp: TEditFocus;
    edtQtdFil: TEditFocus;
    mmCerCtt: TMemoFocus;
    btnAdicionarCtt: TBitBtnLocked;
    btnCancelaCtt: TBitBtnLocked;
    edtObsCtt: TEditFocus;
    mskTelCtt: TMaskEditTelefone;
    mskCelCtt: TMaskEditTelefone;
    mskFaxCtt: TMaskEditTelefone;
    Panel1: TPanel;
    Label177: TLabel;
    dbgContatos: TDBGridCitel;
    pnlAutCtt: TPanel;
    LabelCgcCpf1: TLabel;
    lblRG: TLabelRg;
    edtRg_Ctt: TEditFocus;
    mskCpfCtt: TMaskEditC_G_C_;
    chkAutCtt: TCheckBox;
    GroupBox4: TGroupBox;
    Label265: TLabel;
    dbePriCom: TDBEditFocus;
    pnlTopoBairrosAtendidos: TPanel;
    Label230: TLabel;
    Label231: TLabel;
    Label232: TLabel;
    Label233: TLabel;
    edtNomCidBat: TEditFocus;
    edtEstadoBat: TEditFocus;
    edtCodBai: TEditFocus;
    edtDescri: TEditFocus;
    edtCodCidBat: TEditFocus;
    btnAdicionaBat: TBitBtnLocked;
    btnCancelBat: TBitBtnLocked;
    pnlInteligenciaDeVendas: TPanel;
    Label209: TLabel;
    Label248: TLabel;
    Label249: TLabel;
    dbeCrmFre: TDBEditFocus;
    edtDesFre: TEditFocus;
    dbeCrmPor: TDBEditFocus;
    edtDesCrmPor: TEditFocus;
    dbeCrmFai: TDBEditFocus;
    edtDesFai: TEditFocus;
    lblPermFV: TLabel;
    dbePermFV: TDBEditFocus;
    clbPermFV: TColorLabel;
    cdsCadSco: TUniClientDataSet;
    cdsCadScoAUTOINCREM: TStringField;
    cdsCadScoSCO_CODCLI: TStringField;
    cdsCadScoSCO_NOMSCO: TStringField;
    cdsCadScoSCO_PF_PJ_: TStringField;
    cdsCadScoSCO_CPFCNP: TStringField;
    cdsCadScoSCO_NUM_RG: TStringField;
    cdsCadScoSCO_DTANAS: TDateField;
    cdsCadScoSCO_ESTCIV: TStringField;
    pnlTopoQuadSco: TPanel;
    dbgQuadSoc: TDBGridCitel;
    lblNomSocio: TLabel;
    edtNomSco: TEditFocus;
    LabelRg1: TLabelRg;
    edtRGSco: TEditFocus;
    mskDataNascimento: TMaskEditFocus;
    lblDataNascimentoSocio: TLabel;
    lblParticipacaoSocio: TLabel;
    edtParticipacaoSco: TEditFocus;
    edtCnpjCpfSco: TMaskEditFocus;
    edtOpcCnpjCpfSco: TEditFocus;
    lblCNPJ_CPF_Socio: TLabel;
    btnConfirmaQuadSoc: TBitBtnLocked;
    btnCancelarQuadSoc: TBitBtnLocked;
    pnlTopoQuadScoCapSoc: TPanel;
    Label191: TLabel;
    dbeCapSoc: TDBEditFocus;
    dtsCadSco: TDataSource;
    cdsCadScoSCO_PER_PS: TFloatField;
    ColorLabel4: TColorLabel;
    edtEstadoCivil: TEditFocus;
    lblEstadoCivil: TLabel;
    cmbTipoPesquisa: TComboBoxFocus;
    edtDesPlaNco: TEditFocus;
    dbeConCon: TDBEditFocus;
    pnlPerEntFut: TPanel;
    gpbVMINFC: TGroupBox;
    Label245: TLabel;
    Label246: TLabel;
    dbeVLMINE: TDBEditFocus;
    dbeVLMINR: TDBEditFocus;
    pnlImgCli: TPanel;
    lblErrImg: TLabel;
    imgCli: TcxImage;
    btnHerancaCliPro: TBitBtnLocked;
    btnImpExcel: TBitBtnLocked;
    btnPlaNco: TBitBtnLocked;
    lblNire: TLabel;
    dbeNire: TDBEditFocus;
    lblRemOut: TLabel;
    dbeRemOut: TDBEditFocus;
    cllRemOut: TColorLabel;
    lblCarExc: TLabel;
    dbeCarExc: TDBEditFocus;
    clbCarExc: TColorLabel;
    Label67: TLabel;
    dbeBolPar: TDBEditFocus;
    ColorLabel6: TColorLabel;
    lblQtdDiasRestantesConsultaCredito: TLabel;
    lblValLim: TLabel;
    dbeValLim: TDBEditFocus;
    dbeDTDEPS: TDBEditFocus;
    lblDtDEPS: TLabel;
    btnCadFor: TBitBtnLocked;
    btnCadTransportadora: TBitBtnLocked;
    tbsQualificacao: TTabSheet;
    pnlQualificacao: TPanel;
    lblQualificacao: TLabel;
    edtCodQua: TEditFocus;
    edtDesQua: TEditFocus;
    lblAguardandoSN: TColorLabel;
    lblPrevisaoSN: TColorLabel;
    lblFaltaSN: TColorLabel;
    lblAguardando: TColorLabel;
    lblPrevisao: TColorLabel;
    lblFalta: TColorLabel;
    dbePerAgu: TDBEditFocus;
    dbePerPre: TDBEditFocus;
    dbePerFal: TDBEditFocus;
    cxGridQuaCli: TcxGrid;
    grdQuaCli: TcxGridDBTableView;
    cxGridLevelQuaCli: TcxGridLevel;
    dtsCadQualificacao: TDataSource;
    cdsCadQualificacao: TUniClientDataSet;
    StringField6: TStringField;
    StringField7: TStringField;
    cdsCadQualificacaoQUA_DESQUA: TBlobField;
    memoObservacao: TMemoFocus;
    cdsCadQualificacaoCLI_QUACER: TStringField;
    grdQuaCliQUA_CODQUA: TcxGridDBColumn;
    grdQuaCliQUA_DESQUA: TcxGridDBColumn;
    grdQuaCliQUA_CERQUA: TcxGridDBColumn;
    grdQuaCliQUA_OBSQUA: TcxGridDBColumn;
    cdsCadQualificacaoQUA_CODCLI: TStringField;
    cdsCadQualificacaoAUTINC: TStringField;
    cdsCadQualificacaoQUA_OBSQUA: TBlobField;
    btnIncluirQuaCli: TBitBtnLocked;
    lblObsQua: TLabel;
    chkCertificado: TcxCheckBox;
    btnCanQuaCli: TBitBtnLocked;
    tbsDepartamentoCliente: TTabSheet;
    cxgCliDep: TcxGrid;
    cxvCliDep: TcxGridDBTableView;
    cxgDEP_CODDEP: TcxGridDBColumn;
    cxgDEP_DESCRI: TcxGridDBColumn;
    cxlCliDep: TcxGridLevel;
    pnlCliDep: TPanel;
    lblCliDep: TLabel;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    btnIncDep: TBitBtnLocked;
    pnlLegendaGrdCliDep: TPanel;
    lblLegendaGrdCliDep: TLabel;
    cdsCliDep: TUniClientDataSet;
    cdsCliDepAUTOINCREM: TStringField;
    cdsCliDepDEP_CODDEP: TStringField;
    cdsCliDepDEP_DESCRI: TStringField;
    qryCliDep: TUniQuery;
    dtsCliDep: TDataSource;
    dspCliDep: TUniDataSetProvider;
    cdsCliDepDEP_CODCLI: TStringField;
    lblPesFit: TLabel;
    dbePesFit: TDBEditFocus;
    ColorLabel21: TColorLabel;
    dbeBolSen: TDBEditFocus;
    Label71: TLabel;
    tbsPrioridadeSaidaEstoque: TTabSheet;
    Panel10: TPanel;
    Panel11: TPanel;
    lblEmpresaPrioridade: TLabel;
    edtCodEmpPrioridade: TEditFocus;
    edtDesEmpPrioridade: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    grdEmpresaPrioridadeDBTableView: TcxGridDBTableView;
    grdEmpresaPrioridadeLevel1: TcxGridLevel;
    grdEmpresaPrioridade: TcxGrid;
    cdsEmpresaPrioridade: TUniClientDataSet;
    dtsEmpresaPrioridade: TDataSource;
    cdsEmpresaPrioridadeAUTINC: TStringField;
    cdsEmpresaPrioridadeCODCLI: TStringField;
    cdsEmpresaPrioridadeCODEMP: TStringField;
    cdsEmpresaPrioridadeNOMEMP: TStringField;
    grdEmpresaPrioridadeDBTableViewColumn1: TcxGridDBColumn;
    grdEmpresaPrioridadeDBTableViewColumn2: TcxGridDBColumn;
    grdEmpresaPrioridadeDBTableViewColumn3: TcxGridDBColumn;
    grdEmpresaPrioridadeDBTableViewColumn4: TcxGridDBColumn;
    lblCategoria : TLabel;
    dbeCrmCat    : TDBEditFocus;
    edtDesCat    : TEditFocus;
    btnConsultarEndereco: TBitBtnLocked;
    edtDesUni: TEditFocus;
    edtCodUni: TEditFocus;
    lblQntCaracteresEnd: TLabel;
    dbeObrPDC: TDBEditFocus;
    lblObrPDC: TColorLabel;
    lblObrPDCSN: TColorLabel;
    dbeMsgPe2: TDBEditFocus;
    btnAbrirPastaCliente: TBitBtnLocked;
    ImageSefaz: TcxImageList;
    TabIcms: TTabSheet;
    TabSt: TTabSheet;
    TabIpi: TTabSheet;
    TabPisCofins: TTabSheet;
    TabIrpj: TTabSheet;
    TabIss: TTabSheet;
    TabBeneficios: TTabSheet;
    Label166: TLabel;
    dbeCoDeAc: TDBEditFocus;
    ColorLabel9: TColorLabel;
    lblTaxEnt: TLabel;
    dbeTaxEnt: TDBEditFocus;
    clbTaxEnt: TColorLabel;
    lblDesOpe: TLabel;
    dbeDesOpe: TDBEditFocus;
    lblDesOpePer: TLabel;
    lblImpLau: TLabel;
    dbeImpLau: TDBEditFocus;
    cllImpLau: TColorLabel;
    lblEtiDes: TLabel;
    dbeEtiDes: TDBEditFocus;
    cllEtiDes: TColorLabel;
    cllCliMon: TColorLabel;
    dbeCliMon: TDBEditFocus;
    lblCliMon: TLabel;
    btnObsClientes: TBitBtnLocked;
    btnForMarNaoPermitidos: TBitBtnLocked;
    btnCliOutroVendedor: TBitBtnLocked;
    grbLGPD: TGroupBox;
    lblLeiLGPD: TColorLabel;
    dbeLeiLGP: TDBEditFocus;
    lblLeiLGPDSN: TColorLabel;
    ColorLabel33: TColorLabel;
    dbeTerAce: TDBEditFocus;
    ColorLabel34: TColorLabel;
    btnArquivosAceiteLGPD: TBitBtnLocked;
    lblStatusLGPD: TLabel;
    dbeObs_Fc: TDBMemoFocus;
    TabRegimeEspecial: TTabSheet;
    lblQtdDiasRestantesConsulta: TLabel;
    tbsEcommerce: TTabSheet;
    clbObgPdl: TColorLabel;
    lblObrigarPedidoRotinaLiberacaoEcommerce: TLabel;
    lblPermiteAltercaoViaEcommerce: TLabel;
    clbAltEco: TColorLabel;
    lblExportarParaEcommerce: TLabel;
    clbExpEco: TColorLabel;
    dbeObgPdl: TDBEditFocus;
    dbeAltEco: TDBEditFocus;
    dbeExpEco: TDBEditFocus;
    pnlDadosGerais: TPanel;
    Label39: TLabel;
    ColorLabel10: TColorLabel;
    Label181: TLabel;
    lbl13: TLabel;
    clb2: TColorLabel;
    lblInd: TLabel;
    clbInd: TColorLabel;
    lblIndCom: TColorLabel;
    Label142: TLabel;
    ColorLabel11: TColorLabel;
    lbl25: TLabel;
    Label116: TLabel;
    Label201: TLabel;
    clbDesZon: TColorLabel;
    lblDesZon: TLabel;
    lblMsgAtoDDF: TLabel;
    clbExpInd: TColorLabel;
    lblExpInd: TLabel;
    dbeZonFra: TDBEditFocus;
    dbeSuframa: TDBEditFocus;
    dbeRegTri: TDBEditFocus;
    dbeIndust: TDBEditFocus;
    dbcIndCom: TDBComboBoxFocus;
    dbeSegSoc: TDBEditFocus;
    dbeCodIba: TDBEditFocus;
    dbeCNAE: TDBEditFocus;
    dbeTare__: TDBEditFocus;
    grbNotaEspecial: TGroupBox;
    lblFtNfEs: TLabel;
    lbl8: TLabel;
    clb1: TColorLabel;
    lblTipFatPed: TLabel;
    lblTipFat: TColorLabel;
    dbeFtNfEs: TDBEditFocus;
    dbeTFtNEs: TDBEditFocus;
    dbeTipFat: TDBEditFocus;
    dbeDesZon: TDBEditFocus;
    dbmMsgAtoDDF: TDBMemoFocus;
    edtDesCna: TEditFocus;
    dbeExpInd: TDBEditFocus;
    pnlOrgaoPublico: TPanel;
    Label31: TLabel;
    ColorLabel3: TColorLabel;
    Label140: TLabel;
    ColorLabel12: TColorLabel;
    Label143: TLabel;
    ColorLabel15: TColorLabel;
    Label236: TLabel;
    ColorLabel31: TColorLabel;
    Label68: TLabel;
    ColorLabel17: TColorLabel;
    Label72: TLabel;
    ColorLabel23: TColorLabel;
    dbeOrgPub: TDBEditFocus;
    dbeOrPuRD: TDBEditFocus;
    dbeCalIcm: TDBEditFocus;
    dbeDesPis: TDBEditFocus;
    gbAlqRet: TGroupBox;
    Label237: TLabel;
    Label238: TLabel;
    Label239: TLabel;
    Label240: TLabel;
    Label241: TLabel;
    Label242: TLabel;
    Label243: TLabel;
    Label244: TLabel;
    sbAlqRet: TSpeedButton;
    dbeAlqCsl: TDBEditFocus;
    dbeAlqCof: TDBEditFocus;
    dbeAlqPis: TDBEditFocus;
    dbeAlqIrf: TDBEditFocus;
    dbeOrgPubDifal: TDBEditFocus;
    dbeMotDes: TDBEditFocus;
    pnlRegrasFiscais: TPanel;
    Label262: TLabel;
    ColorLabel32: TColorLabel;
    dbeRegFis: TDBEditFocus;
    pnlICMS: TPanel;
    Label197: TLabel;
    ColorLabel24: TColorLabel;
    Label206: TLabel;
    ColorLabel26: TColorLabel;
    dbeDiferi: TDBEditFocus;
    dbeRedIcm: TDBEditFocus;
    pnlST: TPanel;
    dbeStReEs: TDBEditFocus;
    dbePrStRe: TDBEditFocus;
    lblRecali: TLabel;
    dbeDif_ST: TDBEditFocus;
    GroupBox7: TGroupBox;
    Label223: TLabel;
    lblIvaEspInfo: TLabel;
    Label195: TLabel;
    Label261: TLabel;
    dbeIvaEsp: TDBEditFocus;
    dbeIvaNac: TDBEditFocus;
    dbeIvaSim: TDBEditFocus;
    dbeRecali: TDBEditFocus;
    dbeSibIcm: TDBEditFocus;
    grbCEDEM: TGroupBox;
    Label256: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    dbeIvaEspCEDEM: TDBEditFocus;
    dbeIvaNacCEDEM: TDBEditFocus;
    dbeIvaSimCEDEM: TDBEditFocus;
    lbl26: TLabel;
    lbl27: TColorLabel;
    lblDif_ST: TLabel;
    clbDif_ST: TColorLabel;
    lblSibIcm: TLabel;
    cllRecali: TColorLabel;
    lbl28: TLabel;
    ColorLabel25: TColorLabel;
    pnlIPI: TPanel;
    Label59: TLabel;
    Label196: TLabel;
    Label194: TLabel;
    ColorLabel20: TColorLabel;
    Label266: TLabel;
    lblMsgRetImposto: TLabel;
    dbeEnqIPI: TDBEditFocus;
    cbxTributacaoIPI: TDBComboBoxFocus;
    dbeIseIpi: TDBEditFocus;
    dbeMensagemIPI: TDBMemoFocus;
    dbeDescEnqIPI: TEditFocus;
    pnlPISCOFINS: TPanel;
    Label141: TLabel;
    ColorLabel13: TColorLabel;
    lbl17: TLabel;
    Label193: TLabel;
    ColorLabel19: TColorLabel;
    ColorLabel29: TColorLabel;
    Label267: TLabel;
    Label268: TLabel;
    lblMsgRetImposto1: TLabel;
    dbeRetPCo: TDBEditFocus;
    dbeDif_PC: TDBEditFocus;
    dbeCDesPI: TDBEditFocus;
    cbxTributacaoPisCofins: TDBComboBoxFocus;
    dbeMensagemPisCofins: TDBMemoFocus;
    pnlIRPJ: TPanel;
    ColorLabel14: TColorLabel;
    Label144: TLabel;
    lblMsgRetImposto2: TLabel;
    dbeRetIrf: TDBEditFocus;
    pnlISS: TPanel;
    dbeAlqIss: TDBEditFocus;
    lblCobIss: TColorLabel;
    dbeRedISS: TDBEditFocus;
    rdgCobIss: TDBRadioGroup;
    dbeRetIss: TDBEditFocus;
    clbRedISS: TLabel;
    lblRedISS: TLabel;
    Label61: TLabel;
    Label145: TLabel;
    Label139: TLabel;
    ColorLabel16: TColorLabel;
    pnlBeneficios: TPanel;
    Label253: TLabel;
    ColorLabel22: TColorLabel;
    Label66: TLabel;
    ColorLabel5: TColorLabel;
    lblRECAP_: TLabel;
    lblRECAP__S_N: TColorLabel;
    lblNotDes: TLabel;
    clbNotDes: TColorLabel;
    dbeBenRei: TDBEditFocus;
    dbeIcmRei: TDBEditFocus;
    GroupBox8: TGroupBox;
    Label235: TLabel;
    dbeDefit_: TDBEditFocus;
    rdgTipLim: TDBRadioGroup;
    pnlAtoDeclaratorioDF: TPanel;
    lblAtoDDF: TLabel;
    clbAtoDDF: TColorLabel;
    dbeAtoDDF: TDBEditFocus;
    dbeRECAP_: TDBEditFocus;
    btnRECAP: TBitBtnLocked;
    dbeNotDes: TDBEditFocus;
    pnlregimeEspecial: TPanel;
    lblRegDes: TLabel;
    clbRegDes: TColorLabel;
    dbeRegDes: TDBEditFocus;
    cdsCliCttCLI_IDCIDE: TStringField;
    lblNaturezaServico: TLabel;
    dbeNaturezaServico: TDBEditFocus;
    imgWpp: TImage;
    imgWppCtt: TImage;
    btnGatWpp: TBitBtnLocked;
    pnlCliCluFid: TPanel;
    lblCliFid: TLabel;
    dbeCliFid: TDBEditFocus;
    edtCliFid: TEditFocus;
    btnLimiteAlpe: TBitBtnLocked;
    lblLimiteAlpe: TLabel;
    pnlTipoCreditoBV: TPanel;
    Label73: TLabel;
    cmpTipoCreditoBV: TComboBoxFocus;
    cllOSNFEn: TColorLabel;
    dbeOSNFEn: TDBEditFocus;
    lblOSNFEn: TLabel;
    ColorLabel35: TColorLabel;
    Label74: TLabel;
    dbeProper: TDBEditFocus;
    chkUtiAlp: TDBCheckBox;
    Label75: TLabel;
    dbeValSuf: TDBEditFocus;
    TabBeneficiosDescontos: TTabSheet;
    fraClienteResumo: TfraClienteResumo;
    lblRamFon: TLabel;
    lblRamFax: TLabel;
    edtRamFon: TEditFocus;
    edtRamFax: TEditFocus;
    cdsCliCttCLI_RAMFON: TStringField;
    cdsCliCttCLI_RAMFAX: TStringField;
    pnlProdutoSerasa: TPanel;
    Label76: TLabel;
    cbProdutoSerasa: TComboBoxFocus;
    btnConsultaSerasaPowerCurve: TBitBtnLocked;
    TabBenCst: TTabSheet;
    pnlBeneficioFiscal: TPanel;
    clbBenCst: TColorLabel;
    lblBenCst: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    dbeBenCst: TDBEditFocus;
    edtBenCodCst: TEditFocus;
    edtBenCodBen: TEditFocus;
    BtnAdicionaBeneficio: TBitBtnLocked;
    BtnCancelaBeneficio: TBitBtnLocked;
    cdsCliBen: TUniClientDataSet;
    cdsCliBenBEN_CODCLI: TStringField;
    cdsCliBenBEN_CODCST: TStringField;
    cdsCliBenBEN_CODBEN: TStringField;
    dtsCliBen: TDataSource;
    DBGridCliBen: TDBGridCitel;
    dbeLayCFF: TDBEditFocus;
    cllLayCFF: TColorLabel;
    lblLayCFF: TLabel;
    lblAgruparDocAppTaEntregue: TLabel;
    dbeAgruparDocAppTaEntregue: TDBEditFocus;
    cllAgruparDocAppTaEntregue: TColorLabel;
    pnlOrientacoes: TPanel;
    lblOrientacoes: TLabel;
    memOrientacoes: TDBMemoFocus;
    pnlPermut: TPanel;
    lbl9: TLabel;
    dbePermut: TDBEditFocus;
    ColorLabel8: TColorLabel;
    pnlLimitaContratoLocacao: TPanel;
    lblLimiteLocacaoCtr: TLabel;
    dbeLimCtr: TDBEditFocus;
    btnLimCre: TBitBtnLocked;
    spdHelpLimCre: TSpeedButton;
    lblPerfin: TLabel;
    dbePerfin: TDBEditFocus;
    frxHelpLimCred: TfrxReport;
    lblNatRec: TLabel;
    dbeNatRec: TDBEditFocus;
    pnlIgnoraTravaMargemCondPag: TPanel;
    lblIgtVmk: TLabel;
    dbeIgtVmk: TDBEditFocus;
    cllIgtVmk: TColorLabel;
    pnlTipoConsultaPOA: TPanel;
    Label79: TLabel;
    lblTipoConsulta: TLabel;
    cmpConsultaPOA: TComboBoxFocus;
    cmpTipoConsultaPOA: TComboBoxFocus;
    lblDestino: TLabel;
    cbbDestino: TComboBoxFocus;
    lblIDEstrangeiro: TLabel;
    dbeIDEstrangeiro: TDBEditFocus;
    popVazio: TPopupMenu;
    chkRecWpp: TDBCheckBox;
    lblTributacaoPisCofinsVendaPresencial: TLabel;
    cbxTributacaoPisCofinsVendaPresencial: TDBComboBoxFocus;
    frxHelpEmailCobranca: TfrxReport;
    btnHlpEmailCob: TSpeedButton;
    lblOrgFde: TLabel;
    dbeOrgFde: TDBEditFocus;
    clrOrgFde: TColorLabel;
    lblEntGov: TLabel;
    dbeEntGov: TDBEditFocus;
    clrEntGov: TColorLabel;
    rdgTpOpEg: TDBRadioGroup;
    BtnConsultaSerasaExperian: TBitBtnLocked;
    Label165: TLabel;
    dbeCodCNO: TDBEditFocus;
    pnlNeocredit: TPanel;
    Label301: TLabel;
    edtUltimaConsultaNeocredit: TEditFocus;
    Label300: TLabel;
    edtStatusConsultaNeocredit: TEditFocus;
    lblCodCIB: TLabel;
    dbeCodCIB: TDBEditFocus;
    lblInsImo: TLabel;
    dbeInsImo: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodRepKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCidCobKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    function dbeCodVenChamaCadastro(Key: Word): String;
    function dbeCodAtiChamaCadastro(Key: Word): String;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnHisDebClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    function dbeCodCndChamaCadastro(Key: Word): String;
    procedure btnResFinClick(Sender: TObject);
    procedure dbeCodFpgKeyPress(Sender: TObject; var Key: Char);
    function dbeCodFpgChamaCadastro(Key: Word): String;
    procedure dbeTipCliKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure btnVenCliClick(Sender: TObject);
    procedure dbeStatusEnter(Sender: TObject);
    procedure btnContratosClick(Sender: TObject);
    procedure dbeCodRedKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodRedExit(Sender: TObject);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaEmpresa;
    procedure pCarregaEmpresaRCF;
    procedure dbeCliFidKeyPress(Sender: TObject; var Key: Char);
    procedure btnInfCobrClick(Sender: TObject);
    procedure btnLogAlterClick(Sender: TObject);
    procedure dbeCgcCpfExit(Sender: TObject);
    procedure dbeCodEmpRCFExit(Sender: TObject);
    procedure btnAdicionarCttClick(Sender: TObject);
    procedure btnCancelaCttClick(Sender: TObject);
    procedure dbgContatosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCidCttKeyPress(Sender: TObject; var Key: Char);
    procedure edtCidCttKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCidCttExit(Sender: TObject);
    procedure edtCidCttKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgContatosEnter(Sender: TObject);
    procedure dbeObservKeyPress(Sender: TObject; var Key: Char);
    procedure dbeNumCepKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCepCobKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure btnFichaCliClick(Sender: TObject);
    procedure dbeSupGerKeyPress(Sender: TObject; var Key: Char);
    procedure dbeSupRegKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaProdClick(Sender: TObject);
    procedure btnAdicionarProdClick(Sender: TObject);
    procedure dbgProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pCalculaTotalRenda(Sender: TObject);
    procedure dbeCgCpS1Exit(Sender: TObject);
    procedure btnTeleatendimentoClick(Sender: TObject);
    procedure btnAbrirPastaClienteClick(Sender: TObject);
    procedure btnAbrirPastaCreditoClick(Sender: TObject);
    procedure edtCadCacKeyPress(Sender: TObject; var Key: Char);
    procedure edtCadCacExit(Sender: TObject);
    procedure spbFone1Click(Sender: TObject);
    procedure edtRgExpKeyPress(Sender: TObject; var Key: Char);
    procedure dbeNuCpnjExit(Sender: TObject);
    procedure dbeResideKeyPress(Sender: TObject; var Key: Char);
    procedure dbeAvalisKeyPress(Sender: TObject; var Key: Char);
    procedure dbeNacionKeyPress(Sender: TObject; var Key: Char);
    procedure dbeNaturaKeyPress(Sender: TObject; var Key: Char);
    procedure btnConSCPCClick(Sender: TObject);
    procedure pgcDadosMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mnuAtivarMododeOrdenacaoClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
    procedure pnlBotoesEnter(Sender: TObject);
    procedure btnObsCliClick(Sender: TObject);
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure cdsCliCndAfterPost(DataSet: TDataSet);
    procedure btnIncCndClick(Sender: TObject);
    procedure cxgColSugestPropertiesChange(Sender: TObject);
    procedure btnCadDivClick(Sender: TObject);
    procedure dbeFtNfEsEnter(Sender: TObject);
    procedure dbeFtNfEsExit(Sender: TObject);
    procedure mmConEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCgcCpfExit(Sender: TObject);
    procedure dbgCliRcoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgCliRcoEnter(Sender: TObject);
    procedure btnAdicionarRcoClick(Sender: TObject);
    procedure edtCodOpeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOpeExit(Sender: TObject);
    procedure btnCancelaRcoClick(Sender: TObject);
    procedure edtVPrComExit(Sender: TObject);
    procedure dbeConBc1KeyPress(Sender: TObject; var Key: Char);
    procedure dbeCNAEKeyPress(Sender: TObject; var Key: Char);
    procedure edtCgoCttKeyPress(Sender: TObject; var Key: Char);
    procedure edtDptCttKeyPress(Sender: TObject; var Key: Char);
    procedure edtTfuCttKeyPress(Sender: TObject; var Key: Char);
    procedure edtHobCttKeyPress(Sender: TObject; var Key: Char);
    procedure edtEscCttKeyPress(Sender: TObject; var Key: Char);
    procedure edtGmuCttKeyPress(Sender: TObject; var Key: Char);
    procedure edtEciCttKeyPress(Sender: TObject; var Key: Char);
    procedure mmCerCttKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodSubKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure cxgCliCndViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lstDiaMesClickCheck(Sender: TObject);
    procedure lstDiaFixClickCheck(Sender: TObject);
    procedure dbeCodPor2KeyPress(Sender: TObject; var Key: Char);
    procedure dbeDouComKeyPress(Sender: TObject; var Key: Char);
    procedure dbeDesOpeEnter(Sender: TObject);
    procedure dbeDesOpeExit(Sender: TObject);
    function dbeCodRedChamaCadastro(Key: Word): string;
    procedure btnAltParClick(Sender: TObject);
    procedure btnAddVeiClick(Sender: TObject);
    procedure dbgCliVeiEnter(Sender: TObject);
    procedure dbgCliVeiKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCanVeiClick(Sender: TObject);
    procedure mskPlaVeiKeyPress(Sender: TObject; var Key: Char);
    procedure tbsEntregasShow(Sender: TObject);
    procedure dbeNomCliChange(Sender: TObject);
    procedure dtsTabelaDataChange(Sender: TObject; Field: TField);
    procedure dtsTabelaStateChange(Sender: TObject);
    function dbeCodPorChamaCadastro(Key: Word): string;
    function dbeCodPor2ChamaCadastro(Key: Word): string;
    function dbeCodRegChamaCadastro(Key: Word): string;
    function dbeCodSubChamaCadastro(Key: Word): string;
    function dbeCodDivChamaCadastro(Key: Word): string;
    function edtCadCacChamaCadastro(Key: Word): string;
    function edtCodEmpresaChamaCadastro(Key: Word): string;
    function dbeCliFidChamaCadastro(Key: Word): string;
    procedure edtCidCttEnter(Sender: TObject);
    procedure edtCodOpeEnter(Sender: TObject);
    procedure edtCodOpeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    function dbeNaturaChamaCadastro(Key: Word): string;
    function dbeAvalisChamaCadastro(Key: Word): string;
    procedure edtCodCndExit(Sender: TObject);
    procedure edtCodCndEnter(Sender: TObject);
    procedure edtCodCndKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbeNaturaExit(Sender: TObject);
    procedure dbeNaturaEnter(Sender: TObject);
    function dbeCodCidChamaCadastro(Key: Word): string;
    function dbeCidCobChamaCadastro(Key: Word): string;
    procedure dbeIvaEspEnter(Sender: TObject);
    procedure dbeIvaEspExit(Sender: TObject);
    function dbeTipCliChamaCadastro(Key: Word): string;
    procedure edtCodDivKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncDivClick(Sender: TObject);
    procedure cdsCliDivAfterPost(DataSet: TDataSet);
    procedure cxGridDBColumn4PropertiesChange(Sender: TObject);
    procedure tbsEntregasHide(Sender: TObject);
    procedure tbsFazendasHide(Sender: TObject);
    procedure btnIncluirCCClick(Sender: TObject);
    procedure btnGravarCCClick(Sender: TObject);
    procedure btnAlterarCCClick(Sender: TObject);
    procedure btnExcluirCCClick(Sender: TObject);
    procedure btnCancelarCCClick(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure grdEmpCliKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelBatClick(Sender: TObject);
    procedure btnAdicionaBatClick(Sender: TObject);
    procedure dbgCliBatKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodBaiKeyPress(Sender: TObject; var Key: Char);
    procedure dbgCliBatKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCod_NFEnter(Sender: TObject);
    procedure edtCod_NFExit(Sender: TObject);
    procedure btnAbfClick(Sender: TObject);
    procedure dbeNumIesExit(Sender: TObject);
    procedure chkProRurExit(Sender: TObject);
    procedure dbeCorresKeyPress(Sender: TObject; var Key: Char);
    procedure sbAlqRetClick(Sender: TObject);
    procedure edtDes_NFEnter(Sender: TObject);
    procedure edtDes_NFExit(Sender: TObject);
    procedure dbeCrmFreKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCrmPorKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCrmFaiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCrmForKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure btnAddCrmForClick(Sender: TObject);
    procedure cxgCliForTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCalcCompraMensalClick(Sender: TObject);
    procedure btnCliVenClick(Sender: TObject);
    procedure edtCodEmbKeyPress(Sender: TObject; var Key: Char);
    procedure grdCadEmbDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tshEmbarcacoesShow(Sender: TObject);
    procedure btnGravarEmbClick(Sender: TObject);
    procedure chkCpfDevClick(Sender: TObject);
    procedure spbDicaAbasClick(Sender: TObject);
    procedure btnHerancaClick(Sender: TObject);
    procedure btnConsultaFitClick(Sender: TObject);
    procedure cdsDtaPerEntBeforePost(DataSet: TDataSet);
    procedure cbxGrupoRiscoClick(Sender: TObject);
    procedure cbxTributacaoPisCofinsChange(Sender: TObject);
    procedure cbxTributacaoIPIChange(Sender: TObject);
    procedure edtOpcCnpjCpfScoExit(Sender: TObject);
    procedure btnConfirmaQuadSocClick(Sender: TObject);
    procedure btnCancelarQuadSocClick(Sender: TObject);
    procedure dbgQuadSocKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbTipoPesquisaChange(Sender: TObject);
    procedure dbePlaNcoKeyPress(Sender: TObject; var Key: Char);
    procedure dbeEnqIPIKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaImagem;
    procedure pLimpaImagem;
    procedure imgCliDblClick(Sender: TObject);
    procedure btnHerancaCliProClick(Sender: TObject);
    procedure btnImpExcelClick(Sender: TObject);
    procedure btnPlaNcoClick(Sender: TObject);
    procedure ApplicationEventsDeactivate(Sender: TObject);
    procedure edtCodQuaKeyPress(Sender: TObject; var Key: Char);
    procedure grdQuaCliKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodQuaExit(Sender: TObject);
    procedure btnIncluirQuaCliClick(Sender: TObject);
    procedure chkCertificadoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCanQuaCliClick(Sender: TObject);
    procedure grdQuaCliCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnCadForClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnCadTransportadoraClick(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncDepClick(Sender: TObject);
    procedure pDefineAlteracaoEndereco;
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure cxgDiaSemEntViewKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure edtCodEmpPrioridadeKeyPress(Sender: TObject; var Key: Char);
    procedure grdEmpresaPrioridadeDBTableViewKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure dbeCrmCatKeyPress(Sender: TObject; var Key: Char);
    procedure btnConsultarEnderecoClick(Sender: TObject);
    procedure dbeRECAP_Change(Sender: TObject);
    procedure btnRECAPClick(Sender: TObject);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure dbeEndereChange(Sender: TObject);
    procedure dbeEndNumChange(Sender: TObject);
    procedure dbeEndComChange(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure pCarregaEnquadramentoIPI;
    procedure pCarregaDescricaoCNAE;
    function dbeCNAEChamaCadastro(Key: Word): string;
    procedure btnObsClientesClick(Sender: TObject);
    procedure btnForMarNaoPermitidosClick(Sender: TObject);
    procedure btnCliOutroVendedorClick(Sender: TObject);
    procedure btnArquivosAceiteLGPDClick(Sender: TObject);
    procedure dbeLeiLGPChange(Sender: TObject);
    procedure dbeObs_FcKeyPress(Sender: TObject; var Key: Char);
    procedure dbeTFtNEsEnter(Sender: TObject);
    procedure pgcDadosMouseLeave(Sender: TObject);
    procedure pgcDadosMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnGatWppClick(Sender: TObject);
    procedure btnLimiteAlpeClick(Sender: TObject);
    procedure btnConsultaSerasaPowerCurveClick(Sender: TObject);
    procedure BtnAdicionaBeneficioClick(Sender: TObject);
    procedure BtnCancelaBeneficioClick(Sender: TObject);
    procedure DBGridCliBenKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnLimCreClick(Sender: TObject);
    procedure spdHelpLimCreClick(Sender: TObject);
    procedure dbeNatRecEnter(Sender: TObject);
    procedure dbeNatRecKeyPress(Sender: TObject; var Key: Char);
    procedure dbeIgtVmkEnter(Sender: TObject);
    procedure cmpConsultaPOAChange(Sender: TObject);
    procedure dbeIDEstrangeiroKeyPress(Sender: TObject; var Key: Char);
    procedure btnHlpEmailCobClick(Sender: TObject);
    procedure BtnConsultaSerasaExperianClick(Sender: TObject);

  strict private
    procedure AbrirCadastroVendedoresDoCliente;
    function fValidarFalhaCadastralDeMultiplosDescontosNaNota: boolean;
  private
    { Private declarations }
    FcdsNCO : TUniClientDataset;

    objLiberacao  : TLiberacao;

    blnCanalAcessoLibera : Boolean;
    blnUTDTFE : Boolean;
    blnDesPro : Boolean;
    blnLimCredAut: Boolean;

    cdsCliFor : TZClient;
    cdsCliPro: TUniClientDataSet;
    dspCliPro: TUniDataSetProvider;

    FCliEndEntrega: TfrmCadCliEndEntrega;
    FCliFazendas  : TfrmCadCliFazendas;

    blnAlteraBeneficio : Boolean;

    objPageControlOrder: TPageControlOrder;

    blnLibNum: Boolean;
    blnLibPor: Boolean;
    blnLibPo2: Boolean;

    strCanalAnt,
    strVenInc,
    strRepInc    : String;
    objCliCtt    : TCliCtt;
    lstContatos  : TObjectList;
    blnAltContato: Boolean;
    blnCadastroModificado: Boolean;
    strTabPreAnt : String;

    blnCliPro    : Boolean;
    blnCliProHer : Boolean;
    blnCliDep    : Boolean;
    objCliPro    : TCliPro;

    blnAltProduto: Boolean;

    objCliVei    : TCliVei;
    lstVeiculos  : TObjectList;
    blnAltVeiculo: Boolean;

   {******************************}
   { REFERENCIAS COMERCIAIS       }
   {***************************AC*}
    objCliRco     : TCliRco;
    blnAltRefComer: Boolean;

    blnAltQuaCli  : Boolean;
    arrQualificacao,
    arrCodDep : TConsultasArray;

    qryConCid: TUniQuery;
    qryConCiC: TUniQuery;
    qryConCiE: TUniQuery;
    qryConClg: TUniQuery;
    qryConPor: TUniQuery;
    qryConAti: TUniQuery;
    qryConOpe: TUniQuery;
    qryConCtt: TUniQuery;
    qryConPro: TUniQuery;
    qryConRco: TUniQuery;

    qryTipClg: TUniQuery;
    qryCadAti: TUniQuery;
    qryCadCid: TUniQuery;
    qryCadFic: TUniQuery;
    qryInfCre: TUniQuery;
    qryResumo: TUniQuery;

    fltLimCreAnt: Double;
    strOrgPubAnt: String;
    strCodVenAnt: String;
    strCodRepAnt: String;
    strStatus   : String;
    strTipCliAnt: String;
    strCodFpgAnt: String;
    strNuCnpjAnt: String;
    strConConAnt: String;
    strAltAtiAnt: String;
    strCodPorAnt1: String;
    strCodPorAnt2: String;
    strZonFraAnt: String;
    strNomEmp: String;


    blnRefCom: Boolean;
    blnCobEnt: Boolean;
    blnCrediario: Boolean;

    blnVendAlt: Boolean;

    objRedeLojas: TRedeLojas;

    qryCliFid: TUniQuery;

    strVrfTpr: String;

    strLimCre: String;
    strStaCli: String;
    strTipCli: String;
    intAtrMax: Integer;

    strCodVen: String;
    strCodRep: String;

    strStatusContaContabil: String;
    strCodGrupoRisco: String;

    strCepAnt: String;
    strCepCobAnt: String;
    strCepEntAnt: String;
    strNomAnt: String;
    strCidAnt: String;
    strCgcAnt: String;
    strIesAnt: String;
    strIESUAnt : String;
    strSufAnt: String;
    strEndAnt: String;
    strNumAnt: String;
    strComAnt: String;
    strBaiAnt: String;
    strEnvBol: String;
    strBolImp: String;

    cdsCliVendedores: TUniClientDataSet;
    dspCliVendedores: TUniDataSetProvider;

    // Esse parametro somente será recebido pelo frmCRM
    blnUtilizarCrm: Boolean;
    blnArqCliCrm: Boolean;
    strCampoCRM: String;
    strRegraCRM: String;
    strDesCamCRM: String;
    blnEditaCliCrm: Boolean; // Esse parametro é usado somente pelo cadastro de compromissos
    // Essa procedure somente será recebido pelo frmCRM

    blnAceF8 : Boolean;
    blnAltFtNfEs: Boolean;
    strOpeLibLimCre : String;

    blnCliBat : Boolean;
    qryCliBat : TUniQuery;
    dtsCliBat : TDataSource;
    cdsCliBat : TUniClientDataSet;

    qryGruRis : TUniQuery;
    dtsGruRis : TDataSource;

    strAltCidade: String;
    strAltInsEstadual: String;
    strAltCgcCpf    : String;

    intDesPonAnt : Integer;

    cdsCliVendedoresMar: TUniClientDataSet;
    dspCliVendedoresMar: TUniDataSetProvider;

    cdsCliFNP: TUniClientDataSet;
    dspCliFNP: TUniDataSetProvider;
    cdsCliMNP: TUniClientDataSet;
    dspCliMNP: TUniDataSetProvider;

    cdsClaRECAP: TUniClientDataSet;

    strOpeAlt: Array[0..3] of String;

    {Aba - Quadro Societário}
    blnAltSocio : Boolean;

    blnUtiCon : Boolean;
    blnTemDivergenciaSefaz: Boolean;

    objConsulta  : TConsultaEndereco;

    blnBloquCpfCnpj: Boolean;
    FTipoConsCli : TTipoConsCli;
    blnPreencherClubeFidelidadeComProprioCliente: Boolean;

    blnVerificarCgcCPF: Boolean;
    blnLiberouTravaCgcCPF: Boolean;
    strCliFidAnt : String;
    fltVlrLimCtrAnt : Double;

    procedure ConsultaSerasaPowerCurve;
    procedure ConsultaSerasaExperian;
    {Logs}
    procedure pAddTabelasLog;
    function fRetornarCodRegiao(strCEP : String) : String;
    procedure ConsultaSCPCBoaVistaSophus;

    function fSomaCaracteresEndereco: integer;

    function fValidaAcessoAltCanalAcesso: boolean;

    procedure pIncluiCondicaoPagamento;
    procedure pGravaCondicaoPagamento;
    procedure pCarregaCondicaoPagamento(strCodCli: String);

    procedure pIncluiCliDepProd;
    procedure pGravaCliDepProd;
    procedure pCarregaCliDepProd(strCodCli: String);

    procedure pCriaCadCliEndEntrega;
    procedure pCriaCadCliFazendas;

    procedure pConsultarEnderecoGoogleMaps;

    procedure pAtualizaEnderecoEntrega(blnGravar: Boolean = False);
    procedure pAtualizaFazendas(blnGravar: Boolean = False);
    procedure pCarregaOperador;
    procedure pCarregaDadosAdicionais;
    procedure pHabilitaBotoesAdicionais;
    procedure pCarregaCidade(qryConsulta: TUniQuery; edtCidade, edtEstado: TEdit;
      dbeCidade, dbeCep: TDBEditFocus; Var strCepAnt: String);
    procedure pCarregaRepr_Vend(strCodigo: String; edtDescricao: TEditFocus);
    procedure pCarregaAtividade;
//    procedure pCarregaCondicao;
    procedure pCarregaFormaPag;
    procedure pAtualizaCadFic(strCodCli : String);
    procedure pAtualizaInfCre;
    procedure pCarregaPortador(intOpc : Integer);
    procedure pCarregaCliFid;
    procedure pCarregaRegiao;
    procedure pCarregaSubRegiao;
    procedure pCarregaCanalAcesso;
    function UtilizaConsultaSerasaPowerCurve:Boolean;
    function UtilizaConsultaSerasaExperian: Boolean;
    procedure pCarregaRedeLojas;
    procedure pInicializaCampos;
    procedure pInicializaValoresPadrao;
    procedure pLimpaEdits;
    procedure pAtribuiTabelas;
    procedure pQueryCadFicAfterOpen(DataSet: TDataSet);
    procedure pQueryInfCreAfterOpen(DataSet: TDataSet);
    procedure pQueryCadFicAfterScroll(DataSet: TDataSet);
    procedure pQueryInfCreAfterScroll(DataSet: TDataSet);
    procedure pQueryCadCliAfterScroll(DataSet: TDataSet);
    procedure pQueryCadFicBeforePost(DataSet: TDataSet);
    procedure pCarregaItem;
    procedure pAtribuiMascaraCgcRefComerciais;
    function fCarregaCNAE(strCodCna: String; var strTipCna: String): String;
    procedure pCarregaInteligenciaDeVenda;
    function UtilizaConsultaBoaVistaAcertaEssencialPositivo:Boolean;
    function UtilizaSCPC_POA: Boolean;

    procedure pAtualizaEnderecoPadraoEntrega;

    Function fTemCondicaoSugerida: Boolean;
    function fExisteConContabil: String;

    function fRetDescricaoTipoCli(strCodTip: String): String;

    function fValidaEstadoCivil(strEstCiv: String): Boolean;

    {Aba - Quadro Societário}
    procedure pLimpaEditsQuadroSocietario;
    procedure pCarregaSocios(strCodCli: String; blnHeranca : Boolean = False);
    procedure pHabilitarAbaSocios(blnHabilitar : Boolean);
    procedure pAtualizaEditsSocio;

    {*************************}
    { ABA - CONTATO           }
    {**********************JB*}
    procedure pCarregaContatos(strCodCli: String; blnAutoIncNULL : Boolean = False);
    procedure pAdicionaContatoCds(objContato: TCliCtt);
    procedure pCarregaContatoAlteracao;
    procedure pAtualizaEditsContato(DataSet: TDataSet);
    procedure pLimpaEditsContatos;
    procedure pCarregaCidadeCtt;

    {*******************************}
    { ABA - REFERENCIAS COMERCIAIS  }
    {****************************AC*}
    procedure pCarregaRefComerciais(strCodCli: String; blnAutoIncNULL : Boolean = False);
    procedure pAdicionaRefComerciaisCds(objRefComer: TCliRco);
    procedure pCarregaRefComerciaisAlteracao;
    procedure pAtualizaEditsRefComerciais(DataSet: TDataSet);
    procedure pLimpaEditsRefComerciais;
    procedure pCarregaOperadorRco;

    {****************************************}
    {* ABA - RELACIONAMENTO CLIENTE-PRODUTO *}
    {*************************************RV*}
    procedure pCarregaProdutos(strCodCli: String);
    procedure pAdicionaProdutosCds(objProduto: TCliPro);
    procedure pCarregaProdutosAlteracao;
    procedure pAtualizaEditsProdutos(DataSet: TDataSet);
    procedure pLimpaEditsProdutos;
    procedure pLimpaDadosProdutos;
    function  fProdutoJaInserido(strCodPro: String; blnAltera: Boolean): Boolean;

    {******************}
    {* ABA - VEICULOS *}
    {***************RV*}
    procedure pCarregaVeiculos(strCodCli: String);
    procedure pAdicionaVeiculosCds(objVeiculo: TCliVei);
    procedure pCarregaVeiculosAlteracao;
    procedure pAtualizaEditsVeiculos(DataSet: TDataSet);
    procedure pLimpaEditsVeiculos;

    {***********************}
    {* ABA - DADOS FISCAIS *}
    {********************DH*}
    procedure pCriaClientClaRECAP;
    procedure pCarregaClaRECAP;
    procedure pGravaClassificacoesRECAP;
    procedure pHabilitaCampoAtoDeclaratorioDF;

    {***********************}
    {* ABA - PROFISSIONAIS *}
    {********************MM*}
    procedure pIncluiProfissional;
    procedure pRetNomeProfissional;
    procedure pCarregaProfissional(strCodCli: String);
    procedure pGravaProfissional;

    procedure pVerificaDireitosDadosRetencao;
    procedure pVerificaDireitosDadosPrincipais;
    procedure pVerificaDireitosBotoes;
    procedure pStatusTelefone(btnTel: TSpeedButton; blnClick: Boolean = False);
    procedure pEstadoEmissaoCPF;
    procedure pBuscaCliente(strCodCliente: String = '');
    procedure pMontaTitulosPageControl;
    procedure pAjustaAbaContatos;
    procedure pAjustaBotoesAbaContatos;

    {*******************************}
    {          MODULO CRM           }
    {****************************AC*}
    procedure pAplicarRegrasCrm;
    procedure pProcuraCampoClienteCRM;
    procedure pProcuraCampoContatoCRM;
    procedure pProcuraBotaoArqAnexClienteCRM;
    procedure pAplicarRegrasCrmClientes;
    procedure pAplicarRegrasCrmContatos;
    procedure pAplicarRegrasCrmEnderecos;
    function fRetCampoComDireito(dbeCampo: TDBEdit): TDBEdit;

    procedure pGravaDiaFixo;
    procedure pCarregaDiaFixo;
    procedure pGravaDiaFixoMes;
    procedure pCarregaDiaFixoMes;
    procedure pHabilitaDiaFixo;
    procedure pGravaDiaVisitas;
    procedure pCarregaDiaVisitas;

    procedure pCarregaDiaSemFat;
    procedure pCarregaDiaSemEnt;
    procedure pCarregaQuaCli;
    procedure pGravaDiaSemFat;
    procedure pGravaDiaSemEnt;
    procedure pGravaHraSemEnt;
    procedure pGravaDiaFixoMesEntFat;
    procedure pCarregaDiaFixoEntFat;
    procedure pHabilitaControleData;

    procedure pGravaAlteracoesParticipante(dtsEstado: TDataSetState;
      strNomAnt, strCidAnt, strCgcAnt,
      strIesAnt, strSufAnt, strEndAnt,
      strNumAnt, strComAnt, strBaiAnt: String);

    procedure pUpdateCaption;

    procedure pLimpaCamposEmpCli;
    procedure pCarregaDescrEmpresa;
    procedure pEnviaGravacao;
    procedure pEnviaEdicao;
    procedure pInsereRegEmpCli;

    {Quando utilizado o recurso de Herança}
    procedure pInsereRegEmpCli_Heranca;

    procedure pEditaRegEmpCli;
    procedure pDeletaRegEmpCli;
    procedure pCarregaGridEmpCli;
    procedure pControlaBotoes;

    function fEmpresaJaDesmembr(strCodEmp: String): Boolean;
    function fValidaCamposCCCLIE(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
    procedure pAtualizaTipAbf;

    procedure pAjustaIesUni;
    procedure pAjustarTelaCadastroContato;
    function  fGravarContatosCliente: Boolean;
    procedure pCadastroFoiAlterado(Field: TField);
    function fFieldAlterado(Field: TField): Boolean;
    procedure pDefinirDataSourceDataChange;
    procedure pDataSourceDataChange(Sender: TObject; Field: TField);
    procedure pCarregaCliVendedores(strCodCli: String);
    function fRetornaSqlCliVendedores:string ;
    procedure pExcluiVendAnteriores(strCodCli: String);
    procedure pLimparEditsEmbarcacoes;
    procedure pCarregarEmbarcacoes(strCodCli : String);
    procedure pDeletarEmbarcacoes(strCodCli: String);
    procedure pAdicionarEmbarcacoes(strCodEmb: String);
    procedure pGravarQualificacao;
    function  fSalvarEmbarcacoesCliente: Boolean;
    function  fSalvarCadCliEmb(strCodCli, strAutInc : String; strCliEmb_AutInc: String = ''): Boolean;
    procedure pCarregaGrupoRisco();
    function  fAtualizaGrupoRiscoNaRede(strCodGru: String; intAtrMax: Integer; strCodRed: String): Boolean;
    procedure VerificarDiasRestantesConsultaCredito;
    procedure VerificarDiasRestantesConsultaCobranca;
    procedure pHabilitaCampoSibIcm;
    function fPisCofinsDaCidadeSuspensa(strCodCid: string): Boolean;
    procedure pHabilitaCampoSituacaoPisCofins;
    function fBuscaSituacaoPisCofinsCidade(strCodCid: string): string;
    function CalculaTamanhoMensagem(AText: String): Integer;

    {***********************************************************************************}
    {* ABA - EMPRESAS QUE O CLIENTE NÃO PODE COMPRAR NA PRIORIDADE DE SAÍDA DO ESTOQUE *}
    {***********************************************************************************}
    procedure pDeletaEmpresaPrioridade;
    procedure pGravaEmpresaPrioridade;
    procedure pCarregaEmpresaPrioridade;
    procedure pCarregaResumo(ACodCli, ACodAbf: String);

    procedure pCarregaCliForMarNaoPermitidos(strCodCli: String);
    function fRetornaSqlCliFornecedorNaoPermitido: String;
    function fRetornaSqlCliMarcaNaoPermitida: String;
    function fGravaForMarNaoPermitidos: Boolean;
    function fLimpaForMarNaoPermitidos(strCodCli: String): Boolean;
    procedure pInformarClienteOutroVendedor;
    procedure pCarregarCliente;
    procedure pEnviaContatoCitelDesk;

    function fFieldsIntegracaoConteleFoiAlterado: Boolean;
    function fVendedoresF4Alterados: Boolean;
    function fEhNecessarioIntegrarContele: Boolean;
    procedure pGravaintegracaoContele;
    procedure pCarregaCategoriaCrm;
    procedure pCarregaFornecedorCrm;
    procedure pCarregaFrequenciaCrm;
    procedure pCarregaFaixaCrm;
    procedure pCarregaPorteCrm;
  protected

    blnPodeDig : Boolean;

    blnJahLiberouFormaPagto,
    blnJahLiberouPortador,
    blnJahLiberouPortador2,
    blnSCPCAutomatico : Boolean;

    function fEhClienteForaDoEstado: Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pOrgaoPublicoForaDoEstado;
    procedure pInicializaIndices; override;
    procedure pProximaPagina; override;
    procedure pPaginaAnterior;
    procedure pOnStateChange; override;
    function fGravaProdRelacionados(pgbProgresso: TcxProgressBar): Boolean;
    function fValidaPortadores:Boolean;

    function fCarregaProdRelacionados(pgbProgresso: TcxProgressBar): Boolean;
    function fRetornaProdRelacionado(pgbProgresso: TcxProgressBar): Boolean;
    function fExecutaAntesDoDelete: Boolean; override;
  private

    arrCnd : TConsultasArray;
    FPais  : TPais;
    fltFatValAnt : Double;
    strFatTipAnt : String;
    blnAQCLUFI: Boolean;
    strBaiCobLib: String;
    strBairroLib: String;
    strIgtVmkAnt : String;

    function fValidarPendenciasParaInativar: Boolean;
    procedure pInfoStatusGravacao(strInformacao: String; pgbProgresso: TcxProgressBar);
    procedure pStepStatusGravacao(pgbProgresso: TcxProgressBar);

    function fCriacdsCliBat: TUniClientDataSet;
    procedure pCarregaBairroAtende(strCodCli : String);
    procedure cdsCliBatAfterPost(DataSet: TDataSet);
    procedure pSalvaCliBat;
    procedure pQryTabelaAfterOpen(DataSet : TDataSet);
    procedure pTipAtiSetText(Field : TField; Const Text : String);
    procedure pTipAtiGetText(Field : TField; Var Text : String; DisplayText : Boolean);
    procedure pIndComSetText(Field : TField; Const Text : String);
    procedure pIndComGetText(Field : TField; Var Text : String; DisplayText : Boolean);
    procedure pDesoMTSetText(Field : TField; Const Text : String);
    procedure pDesoMTGetText(Field : TField; Var Text : String; DisplayText : Boolean);
    function fSQLCliFor : String;
    function fGravaFornecedor: Boolean;
    function fGravaFornecedorProgresso(cxProgressBar: TcxProgressBar): Boolean;
    procedure pHabilitaConsultaSCPC;
    function fSelecionadoSCPC: Boolean;
    procedure pCarregaCondicaoPagamentoCFG(strCodAti: string);

    function fGetPagAtivas: Integer;
    procedure pCarregaTributacao(NomeDoCampo: String);
    procedure pAtualizaTributacao(NomeDoCampo: String);
    procedure pCarregaPlanoContabil(const blnBuscaPorChave: Boolean=False);

    function fValidaCndCli(const strCodCnd: String): Boolean;
    function fExibeMensagemValidaCndCli(const strCnd: String): Boolean;
    function fUsaCamposIvaEsp: Boolean;
    procedure pExibeCamposAbreviacao(blnExibir: Boolean);
    procedure pCarregaBeneficios(strCodCli: String);
    procedure pDeletaBeneficios(strCodCli: String);
    function fGravaBeneficios(strCodCli: String): Boolean;
    procedure pHabilitarAbaBeneficios(blnHabilitar: Boolean);
    procedure pAtualizaEditBeneficio;
    procedure pLimpaEditBeneficio;
    procedure pHabilitaCampo(Sender: TEditFocus);
    procedure pDesabilitaCampo(Sender: TEditFocus);
    function fValidaDireitoDeAcessoParaAlteracaoDeBairro(strCodCli, strNomCli, strCEP,
      strBaiDig: String; Var strBaiLib: String): Boolean;
    function fValidarPermissaoParaAlteracaoDeBairro(strCodCli, strCEP,
      strBaiDig: String; var strBaiSug: String): Boolean;
    function fLiberaAltLimContratoLocacao(fltVlrAnt, fltVlrAtu: Double): Boolean;
    function fClienteComBoaQualidadeNoSerasa: Boolean;
    function fDataDeConsultaValida: Boolean;
    procedure pAtribuiLimiteDeCreditoAuto;
    function fLiberaAlteracaoDeLimiteDeCredito(blnExibeAtual: Boolean): Boolean;
    function fProsseguirComAtualizacaoDeLimiteDeCredito: Boolean;
    procedure pAtualizaLimiteDeCreditoAuto;
    procedure pHabilitaBotaoLimiteDeCredito(blnHabilita: Boolean);
    function fRetValorLimCredAut: Double;
    procedure pHabilitaSCPC_CDLPOA;
    function fValidouIDEstrangeiro(const blnBuscaPorChave : Boolean): Boolean;
    procedure pAlterarStatusCpfCnpj;
    function fPreencheuIDEstrangeiro: Boolean;
    function fVerificaSocioJaCadastrado(strCPFCNPJ: String; strCodCli: String): Boolean;
    procedure pMostrarContaCorrente(strParam: String);
    function fGravaVendedor: Boolean;
    function fGravaVendedorProgresso(cxProgressBar: TcxProgressBar): Boolean;
  public

    LogAltCadCli  : TLogAltCadCli;

    strCodClienteIniciarCadastro: String;
    strPermiCadCid: String;
    blnCadContato: Boolean;
    strCodCliCtt : String;
    strCliCRM  : String;
    blnEnviaContatoCitelDesk: Boolean;

    procedure pSetaParametrosCRM(strNomCampoCRM, strCodCliCRM, strNomRegraCRM, strDesCampoCRM: String; blnArqCliAnexCRM: Boolean; blnEditarClienteCRM: Boolean = True);
    procedure pPesquisaClienteCRM(const strCodCli: String = '');

    procedure pConfiguracoesIniciaisCampos;

    class procedure pSetaCamposDefaultCliente(qryCadCli: TUniQuery);
    class function fCadastroRapidoCliente(Var strCodCli: String;
                                          strNomCli,
                                          strFanSob,
                                          strEndere,
                                          strEndNum,
                                          strEndCom,
                                          strBairro,
                                          strCodCid,
                                          strCep,
                                          strFone01,
                                          strCelula,
                                          strNum_Rg,
                                          strI_E_S_,
                                          strEmail,
                                          strEmNfe,
                                          strStatus,
                                          strContat: String;
                                          intCgcCpf: Integer;
                                          strC_G_C_,
                                          strCodRep,
                                          strCodVen: String;
                                          dta_DtaCad: TDate = 0;
                                          dta_DtaNas: TDate = 0;
                                          str_Fone02: String = '';
                                          str_HomePa: String = '';
                                          str_CodAti: String = '';
                                          strEmail2 : String = '';
                                          strNumFax : String = '';
                                          strObserva: String = '';
                                          strRgExp  : String = '';
                                          blnCadCliCon: Boolean = False;
                                          strCRMFre : String = '';
                                          strCRMPor : String = '';
                                          strCRMFai : String = '';
                                          strCRMCat : String = '';
                                          strCodReg : String = '';
                                          strCodCac : String = ''): Boolean;

    class function fGeraLogLimiteStatusCliente(strCodCli: String;
                                               dtaDtaAlt: Tdate;
                                               dtaHrAlt: TTime;
                                               strOperad: String;
                                               strCampoAlt: String;
                                               strInforAntC: String;
                                               strInforNovC: String;
                                               fltInforAntN: Double;
                                               fltInforNovN: Double;
                                               blnIniciaTransacao:Boolean=True;
                                               blnEhRotinaAutomat:Boolean=False): Boolean;

    class procedure pCarregaCondicaoPagamentoRapidoCFG(strCodAti: string; strCodCli: string; qryCliCnd: TUniQuery);
    class procedure pCarregaProfissionalCFG(const strCodCli: string);

    class function fAlteraCadCli(const strCodCliLocal: String): String;

  end;

const
  ARR_SEXO: Array[0..1] Of Array[0..1] of String = (('MASCULINO', 'M'),
                                                    ('FEMININO',  'F'));

  ARR_MORADIA: Array[0..1] Of Array[0..1] of String = (('PRÓPRIA', 'P'),
                                                       ('ALUGADA', 'A'));

  ARR_ESTADOCIVIL: Array[0..3] Of Array[0..1] of String = (('CASADO(A)',   'C'),
                                                           ('SOLTEIRO(A)', 'S'),
                                                           ('MARITAL',     'M'),
                                                           ('OUTROS',      'O'));

  ARR_ESCOLARIDADE: Array[0..7] Of Array[0..1] of String = (('ANALFABETO',               'ANA'),
                                                            ('PRIMEIRO GRAU INCOMPLETO', 'PGI'),
                                                            ('PRIMEIRO GRAU COMPLETO',   'PGC'),
                                                            ('SEGUNDO GRAU INCOMPLETO',  'SGI'),
                                                            ('SEGUNDO GRAU COMPLETO',    'SGC'),
                                                            ('SUPERIOR INCOMPLETO',      'SI' ),
                                                            ('SUPERIOR COMPLETO',        'SC' ),
                                                            ('POS GRADUACAO',            'PG' ));
var
  frmCadClientes: TfrmCadClientes;

implementation

uses SysUtils, Variants, Graphics, StrUtils, untFuncoes, untPai,untConsultas,
  untFuncIns, untFuncIns2, untPesqAux, untResFinanceiro, untConstantes, untFuncoesSimples, untCadContratos, TypesRel,
  untFuncoesAuxiliares, untInfCobranca, untFuncoesRel, untFuncoesRel2,
  untFuncFat, untCadCidades,  untEmiFichaCad, untCadCliVen, untCadCid,
  untAtendimento, untGravaArquivoPasta, untConsultaSCPC, untFatMostraObsCliente,
  untCadDiversos, untConfirmacaoMemo, untLogAlteracaoParticipante, untCadAltPar,
  untGravando, System.Types, untRelFatVendasCliente, untCadAbreviacaoFiscal,
  untMediaMensalCompra, untCadCliVenMar, untFuncoesConsulta, untHerancaCliente,
  untIConsultaCadastroFit, untCliSco, Contabilidade.Consultas, Contabilidade.Funcoes,
  untCadFornecedores, untCadTransportadoras, untDocumento, untIDocumento,
  untCadCliClassificacaoIPINCM, untPnlDadosCliente, untPanelCxClientes,
  untInputDialog, untObservacao, untCadCliForMar, untFatDigCnpj,
  ArquivosBanco.View, ArquivosBanco.AceiteLGPD, untQualiZapAddOrEditContact,
  untCfgWpp, untAlpePaymentProductsArrangements, untMensagemExplicativa,
  Neocredit.Classe;

{$R *.dfm}

procedure TfrmCadClientes.pCarregaEmpresa;
Begin
  If Not (fEmptyStr(edtCodEmpresa.Text)) Then
    edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text)
  Else
    edtDesEmpresa.Text := '';
End;

procedure TfrmCadClientes.pCarregaEmpresaPrioridade;
var
  qryCarregaPrioridade: TUniQuery;
begin
  qryCarregaPrioridade := fCriaQuery;

  try
    qryCarregaPrioridade.Close;
    qryCarregaPrioridade.SQL.Clear;
    qryCarregaPrioridade.SQL.Add('SELECT * FROM EXEMSA');
    qryCarregaPrioridade.SQL.Add('WHERE MSA_CODCLI = :CODCLI');
    qryCarregaPrioridade.ParamByName('CODCLI').AsString := dbeCodCli.Text;
    qryCarregaPrioridade.Open;

    if not qryCarregaPrioridade.IsEmpty then
    begin
      cdsEmpresaPrioridade.EmptyDataSet;

      while not qryCarregaPrioridade.Eof do
      begin
        cdsEmpresaPrioridade.Append;
        cdsEmpresaPrioridadeAUTINC.AsString := qryCarregaPrioridade.FieldByName('AUTOINCREM').AsString;
        cdsEmpresaPrioridadeCODCLI.AsString := qryCarregaPrioridade.FieldByName('MSA_CODCLI').AsString;
        cdsEmpresaPrioridadeCODEMP.AsString := qryCarregaPrioridade.FieldByName('MSA_CODEMP').AsString;
        cdsEmpresaPrioridadeNOMEMP.AsString := fRetNomeEmpresa(qryCarregaPrioridade.FieldByName('MSA_CODEMP').AsString);
        cdsEmpresaPrioridade.Post;

        qryCarregaPrioridade.Next;
      end;
    end
    Else
      cdsEmpresaPrioridade.EmptyDataSet;
  finally
    FreeAndNil(qryCarregaPrioridade);
  end;
end;

procedure TfrmCadClientes.pCarregaEmpresaRCF;
Begin
  If Not (fEmptyStr(dbeCodEmpRCF.Text)) Then
    edtDesEmpRCF.Text := fRetNomeEmpresa(dbeCodEmpRCF.Text)
  Else
    edtDesEmpRCF.Text := '';
End;

procedure TfrmCadClientes.pCriaCadCliEndEntrega;
Begin
  pCriarFormularios(TfrmCadCliEndEntrega, FCliEndEntrega);
  FCliEndEntrega.blnOrigemCadCli := True;
  FCliEndEntrega.Align := alClient;
  FCliEndEntrega.strEspDoc := 'NF';
  FCliEndEntrega.blnDockPanel := True;
  FCliEndEntrega.Dock(pnlEntregas, pnlEntregas.BoundsRect);
  FCliEndEntrega.fValidaDireitoDeAcessoAltBairro := fValidaDireitoDeAcessoParaAlteracaoDeBairro;
  FCliEndEntrega.show;
End;

procedure TfrmCadClientes.pCriaCadCliFazendas;
Begin
  If (fCfgSis('CADFAZ') = 'N') Then
    Exit;

  pCriarFormularios(TfrmCadCliFazendas, FCliFazendas);
  FCliFazendas.Align := alClient;
  FCliFazendas.blnDockPanel := True;
  FCliFazendas.Dock(pnlFazendas, pnlFazendas.BoundsRect);
  FCliFazendas.show;
End;

procedure TfrmCadClientes.pCriaClientClaRECAP;
begin
  cdsClaRECAP := TUniClientDataSet.Create(Self);
  cdsClaRECAP.FieldDefs.Add('AUTINC', ftString,  20);
  cdsClaRECAP.FieldDefs.Add('CODNCM', ftString,   8);
  cdsClaRECAP.FieldDefs.Add('DESCRI', ftString, 300);
  cdsClaRECAP.FieldDefs.Add('DESCOM', ftString, 300);
  cdsClaRECAP.FieldDefs.Add('OPERAC', ftString,   1);
  cdsClaRECAP.CreateDataSet;
end;

procedure TfrmCadClientes.pDataSourceDataChange(Sender: TObject; Field: TField);
begin
  pCadastroFoiAlterado(Field);
end;

procedure TfrmCadClientes.pDefinirDataSourceDataChange;
  Var
    i, j, k: Integer;
begin
  Try
    For i := 0 To Self.ComponentCount - 1 Do Begin
      If (Self.Components[i] Is TDataSource) Then Begin
        If (Assigned(TDataSource(Self.Components[i]).DataSet)) Then
          TDataSource(Self.Components[i]).OnDataChange := pDataSourceDataChange;
      End Else If (Self.Components[i] Is TPanel) Then Begin
        For j := 0 To TPanel(Self.Components[i]).ControlCount - 1 Do Begin
          If (TPanel(Self.Components[i]).Controls[j] Is TForm) Then Begin
            For k := 0 To TForm(TPanel(Self.Components[i]).Controls[j]).ComponentCount - 1 Do Begin
              If (TForm(TPanel(Self.Components[i]).Controls[j]).Components[k] Is TDataSource) Then Begin
                If (Assigned(TDataSource(TForm(TPanel(Self.Components[i]).Controls[j]).Components[k]).DataSet)) Then
                  TDataSource(TDataSource(TForm(TPanel(Self.Components[i]).Controls[j]).Components[k])).OnDataChange := pDataSourceDataChange;
              End;
            End;
          End;
        End;
      End
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TfrmCadClientes.pDefinirDataSourceDataChange]');
  End;
end;

procedure TfrmCadClientes.pDeletaEmpresaPrioridade;
var
  qryDelEmpPrioridade: TUniQuery;
begin
  qryDelEmpPrioridade := fCriaQuery;

  try
    qryDelEmpPrioridade.Close;
    qryDelEmpPrioridade.SQL.Clear;
    qryDelEmpPrioridade.SQL.Add('DELETE FROM EXEMSA');
    qryDelEmpPrioridade.SQL.Add('WHERE MSA_CODCLI = :CODCLI');
    qryDelEmpPrioridade.ParamByName('CODCLI').AsString := dbeCodCli.Text;
    qryDelEmpPrioridade.ExecSQL;
  finally
    FreeAndNil(qryDelEmpPrioridade);
  end;
end;

procedure TfrmCadClientes.pDeletaRegEmpCli;
  Var
    qryDelete: TUniQuery;
begin
  qryDelete := fCriaQuery(Nil);
  Try
    qryDelete.SQL.Add('DELETE ');
    qryDelete.SQL.Add('FROM ');
    qryDelete.SQL.Add('  CCCLIE ');
    qryDelete.SQL.Add('WHERE AUTOINCREM = :AUTOINCREM ');

    qryDelete.ParamByName('AUTOINCREM').AsString := cdsEmpCliAUTOINCREM.AsString;
    qryDelete.ExecSQL;
  Finally
    qryDelete.Free;
  End;
end;

procedure TfrmCadClientes.pDeletarEmbarcacoes(strCodCli: String);
  Var
    qryTemp: TUniQuery;
begin
  Try
    qryTemp := fCriaQuery(nil);

    Try
      qryTemp.Close();
      qryTemp.SQL.Clear();
      qryTemp.SQL.Text := 'DELETE FROM CLIEMB WHERE EMB_CODCLI = :CODCLI';
      qryTemp.ParamByName('CODCLI').AsString := strCodCli;
      qryTemp.ExecSQL();
    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[TfrmCadClientes.pDeletarEmbarcacoes]');
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

procedure TfrmCadClientes.pDesoMTGetText(Field: TField; var Text: String;
  DisplayText: Boolean);
begin
  If Field.AsString = '3' Then
    Text := 'Uso na agropecuária'
  Else If Field.AsString = '9' Then
    Text := 'Outros'
  Else If Field.AsString = '12' Then
    Text := 'Órgão de fomento e desenvolvimento agropecuário';
end;

procedure TfrmCadClientes.pDesoMTSetText(Field: TField; const Text: String);
begin
  If Text = 'Uso na agropecuária' Then
    Field.AsString := '3'
  Else If Text = 'Outros' Then
    Field.AsString := '9'
  Else If Text = 'Órgão de fomento e desenvolvimento agropecuário' Then
    Field.AsString := '12';
end;

function TfrmCadClientes.fCriacdsCliBat : TUniClientDataSet;
Begin
  Result := TUniClientDataSet.Create(Self);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'AUTOINCREM';
    DataType := ftString;
    Size     := 20;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'BAT_CODCLI';
    DataType := ftString;
    Size     := 8;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'BAT_CODBAI';
    DataType := ftString;
    Size     := 8;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'BAI_DESCRI';
    DataType := ftString;
    Size     := 100;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'BAI_CODCID';
    DataType := ftString;
    Size     := 5;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CID_NOMCID';
    DataType := ftString;
    Size     := 40;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CID_ESTADO';
    DataType := ftString;
    Size     := 2;
    Required := False;
  End;

  Result.CreateDataSet;

End;

procedure TfrmCadClientes.pDefineAlteracaoEndereco;
begin

  If Not fVerificaAcessoSistema('CLIEND') Then
  Begin
    dbeEndere.Enabled    := False;
    dbeEndere.ReadOnly   := True;
  End;

  If Not fVerificaAcessoSistema('CLINUM') Then
  Begin
    dbeEndNum.Enabled     := False;
    dbeEndNum.ReadOnly    := True;
  End;

  If Not fVerificaAcessoSistema('CLICEP') Then
  Begin
    dbeNumCep.Enabled  := False;
    dbeNumCep.ReadOnly := True;
  End;

  If Not fVerificaAcessoSistema('CLICOM') Then
  Begin
    dbeEndCom.Enabled    := False;
    dbeEndCom.ReadOnly   := True;
  End;

  If Not fVerificaAcessoSistema('CLICID') Then
  Begin
    dbeCodCid.Enabled     := False;
    dbeCodCid.ReadOnly    := True;
  End;

  If Not fVerificaAcessoSistema('CLI_IE') Then
  Begin
    dbeNumIes.Enabled   := False;
    dbeNumIes.ReadOnly  := True;
  End;

  If Not fVerificaAcessoSistema('CLIMUN') Then
  Begin
    dbeNumImp.Enabled      := False;
    dbeNumImp.ReadOnly     := True;
  End;

  If Not fVerificaAcessoSistema('CLI_PR') Then
  Begin
    chkProRur.Enabled      := False;
    chkProRur.ReadOnly     := True;
  End;

  If Not fVerificaAcessoSistema('CLINCI') Then
  Begin
    chkIESUni.Enabled         := False;
    chkIESUni.ReadOnly        := True;
  End;

  If Not fVerificaAcessoSistema('CLINRE') Then
  Begin
    dbeNire.Enabled     := False;
    dbeNire.ReadOnly    := True;
  End;

  If Not fVerificaAcessoSistema('CLIMEI') Then
  Begin
    chkMicEmp.Enabled  := False;
    chkMicEmp.ReadOnly := True;
  End;

end;

procedure TfrmCadClientes.pCarregaBairroAtende(strCodCli : String);
  Var
    strSQL  : String;
    intIndex: Integer;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE                          ';
  strSQL := strSQL + ' CLIBAT.AUTOINCREM,                           ';
  strSQL := strSQL + '        BAT_CODCLI,                           ';
  strSQL := strSQL + '        BAT_CODBAI,                           ';
  strSQL := strSQL + '        BAI_DESCRI,                           ';
  strSQL := strSQL + '        BAI_CODCID,                           ';
  strSQL := strSQL + '        CID_NOMCID,                           ';
  strSQL := strSQL + '        CID_ESTADO                            ';
  strSQL := strSQL + ' FROM CLIBAT                                  ';
  strSQL := strSQL + ' INNER JOIN CADBAI ON BAI_CODBAI = BAT_CODBAI ';
  strSQL := strSQL + ' INNER JOIN CADCID ON CID_CODCID = BAI_CODCID ';
  strSQL := strSQL + ' WHERE BAT_CODCLI = :CODCLI                   ';

  With qryCliBat, SQL Do
  Begin
    Close;
    Clear;
    Add( strSQL );
    ParamByName('CODCLI').AsString := strCodCli;
    Open;

    cdsCliBat.EmptyDataSet;
    While Not Eof Do
    Begin
      cdsCliBat.Insert;
      For intIndex := 0 To qryCliBat.Fields.Count -1 Do
        cdsCliBat.FieldByName(qryCliBat.Fields[intIndex].FieldName).Value := qryCliBat.Fields[intIndex].Value;
      cdsCliBat.Post;

      Next;
    End;

  End;

  cdsCliBat.Tag := 0;

End;

procedure TfrmCadClientes.cbxGrupoRiscoClick(Sender: TObject);
begin
  inherited;
  If qryTabela.State in [dsInsert, dsEdit] Then
    qryTabela.FieldByName('CLI_ATRMAX').AsInteger := qryGruRis.FieldByName('GRR_ATRMAX').AsInteger;
end;


procedure TfrmCadClientes.cbxTributacaoPisCofinsChange(Sender: TObject);
begin
  If Copy(cbxTributacaoPisCofins.Text,1,1) = 'T' Then
  Begin
    dbeMensagemPisCofins.Enabled := False;
    dbeMensagemPisCofins.Text    := '';
  End
  Else
    dbeMensagemPisCofins.Enabled := True;
end;

procedure TfrmCadClientes.cbxTributacaoIPIChange(Sender: TObject);
begin
  If (Copy(cbxTributacaoIPI.Text,1,1) = 'T') Or (Copy(cbxTributacaoIPI.Text,1,1) = 'N') Then
  Begin
    dbeEnqIPI.Text := IIF(Copy(cbxTributacaoIPI.Text,1,1) = 'N', '999', '');
    dbeEnqIPI.Enabled := False;
    dbeMensagemIPI.Enabled := IIF(Copy(cbxTributacaoIPI.Text,1,1) = 'N', True, False);
    dbeMensagemIPI.Text := IIF(Copy(cbxTributacaoIPI.Text,1,1) = 'N', dbeMensagemIPI.Text, '');
  End
  Else
  Begin
    dbeEnqIPI.Enabled := True;
    dbeMensagemIPI.Enabled := True;
  End;
end;

procedure TfrmCadClientes.cdsCliBatAfterPost(DataSet : TDataSet);
Begin
  DataSet.Tag := Succ(DataSet.Tag);
End;

procedure TfrmCadClientes.pSalvaCliBat;
Var
  qryDados : TUniQuery;
Begin

  If (cdsCliBat.Tag = 0) Then
    Exit;

  Try

    qryDados := fCriaQuery(Self);
    With qryDados, SQL Do
    Begin
      Close;
      Clear;
      Add(' DELETE FROM CLIBAT WHERE BAT_CODCLI = :CODCLI ');

      ParamByName('CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;

      ExecSQL;

      Close;
      Clear;
      Add(' INSERT INTO CLIBAT (    ');
      Add('             AUTOINCREM, ');
      Add('             BAT_CODCLI, ');
      Add('             BAT_CODBAI) ');
      Add('      VALUES(   :AUTINC, ');
      Add('                :CODCLI, ');
      Add('                :CODBAI) ');

      cdsCliBat.DisableControls;
      cdsCliBat.First;
      While Not cdsCliBat.Eof Do
      Begin

        if (cdsCliBat.FieldByName('AUTOINCREM').AsString <> '') then
          ParamByName('AUTINC').AsString := cdsCliBat.FieldByName('AUTOINCREM').AsString
        else
          ParamByName('AUTINC').AsString := fRetAutoIncrem('CLIBAT', VS_strCodEmp);

        ParamByName('CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
        ParamByName('CODBAI').AsString := cdsCliBat.FieldByName('BAT_CODBAI').AsString;

        ExecSql;

        cdsCliBat.Next;
      End;

    End;

  Finally
    cdsCliBat.Tag := 0;
    cdsCliBat.EnableControls;
    FreeAndNil(qryDados);
  End;

End;

procedure TfrmCadClientes.FormCreate(Sender: TObject);
begin
  inherited;

  TfrmGravando.fExecutarModal(pConfiguracoesIniciaisCampos, 'Aguarde... Configurando campos do cadastro de clientes','');
end;

procedure TfrmCadClientes.FormDestroy(Sender: TObject);
begin
  If VS_strHabilitarCRM Then
    FreeAndNil(cdsCliFor);

  If (Assigned(objLiberacao)) Then
    FreeAndNil(objLiberacao);

  If (Assigned(objConsulta)) Then
    FreeAndNil(objConsulta);

  If (Assigned(cdsClaRECAP)) Then
    FreeAndNil(cdsClaRECAP);

  If Assigned(FcdsNCO) Then
    FreeAndNil(FcdsNCO);

  inherited;
end;

function TfrmCadClientes.fRetDescricaoTipoCli(strCodTip: String): String;
  Var
    strSQL   : String;
    qryGenClg: TUniQuery;
begin
  Try
    qryGenClg := fCriaQuery(Self);

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
end;

function TfrmCadClientes.fRetornaProdRelacionado(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := objCliPro.fRetProdutos(qryTabela.FieldByName('CLI_CODCLI').AsString, cdsCliPro, dspCliPro, pgbProgresso);
end;

function TfrmCadClientes.fRetornarCodRegiao(strCEP: String): String;
Var
  qryAux : TUniQuery;
begin
  Result := '';
  Try
    qryAux := fCriaQuery;
    qryAux.SQL.Text :=
      'SELECT VIN_CODREG '+
      '  FROM VINREG '+
      ' WHERE VIN_C_E_P_ = :C_E_P_';
    qryAux.Close;
    qryAux.ParamByName('C_E_P_').AsString := strCEP;
    qryAux.Open;

    Result := qryAux.fieldByName('VIN_CODREG').AsString;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmCadClientes.fRetornaSqlCliFornecedorNaoPermitido: String;
var
  LstrSQL: string ;
begin
  LstrSQL := '';
  LstrSQL := LstrSQL + 'SELECT SQL_NO_CACHE ';
  LstrSQL := LstrSQL + '  FNP_CODCLI,  ';
  LstrSQL := LstrSQL + '  FNP_CODFOR,  ';
  LstrSQL := LstrSQL + '  FOR_NOMFOR   ';
  LstrSQL := LstrSQL + 'FROM ';
  LstrSQL := LstrSQL + '  CLIFNP ';
  LstrSQL := LstrSQL + '  INNER JOIN CADFOR ON FOR_CODFOR = FNP_CODFOR ';
  LstrSQL := LstrSQL + 'WHERE ';
  LstrSQL := LstrSQL + '  FNP_CODCLI = :CODCLI ';

  result := LstrSQL ;
end;

function TfrmCadClientes.fRetornaSqlCliMarcaNaoPermitida: String;
var
  LstrSQL: string ;
begin
  LstrSQL := '';
  LstrSQL := LstrSQL + 'SELECT SQL_NO_CACHE ';
  LstrSQL := LstrSQL + '  MNP_CODCLI,  ';
  LstrSQL := LstrSQL + '  MNP_CODMAR,  ';
  LstrSQL := LstrSQL + '  MAR_DESMAR   ';
  LstrSQL := LstrSQL + 'FROM ';
  LstrSQL := LstrSQL + '  CLIMNP ';
  LstrSQL := LstrSQL + '  INNER JOIN CADMAR ON MAR_CODMAR = MNP_CODMAR ';
  LstrSQL := LstrSQL + 'WHERE ';
  LstrSQL := LstrSQL + '  MNP_CODCLI = :CODCLI ';

  result := LstrSQL ;

end;

function TfrmCadClientes.fRetornaSqlCliVendedores: string;
var
  LstrSQL: string ;
begin
  LstrSQL := '';
  LstrSQL := LstrSQL + 'SELECT SQL_NO_CACHE ';
  LstrSQL := LstrSQL + '  CVE_CODCLI,  ';
  LstrSQL := LstrSQL + '  CVE_CODVEN,  ';
  LstrSQL := LstrSQL + '  OPE_NOMOPE,  ';
  LstrSQL := LstrSQL + '  CVE_CODMAR,  ';
  LstrSQL := LstrSQL + '  CVE_CODFOR,  ';
  LstrSQL := LstrSQL + '  CVE_DTVGIN,  ';
  LstrSQL := LstrSQL + '  CVE_DTVGFN,  ';
  LstrSQL := LstrSQL + '  MAR_DESMAR,  ';
  LstrSQL := LstrSQL + '  FOR_NOMFOR,  ';
  LstrSQL := LstrSQL + '  V.AUTOINCREM ';
  LstrSQL := LstrSQL + 'FROM ';
  LstrSQL := LstrSQL + '  CLIVEN V ';
  LstrSQL := LstrSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = CVE_CODVEN ';
  LstrSQL := LstrSQL + '   LEFT JOIN CADMAR ON MAR_CODMAR = CVE_CODMAR ';
  LstrSQL := LstrSQL + '   LEFT JOIN CADFOR ON FOR_CODFOR = CVE_CODFOR ';
  LstrSQL := LstrSQL + 'WHERE ';
  LstrSQL := LstrSQL + '  CVE_CODCLI = :CODCLI ';

  result := LstrSQL ;
end;

function TfrmCadClientes.fEhClienteForaDoEstado: Boolean;
begin
  Result := False;

  If fEmptyStr(edtEstado.Text) Then
    Exit;

  If fDentroDoEstado(edtEstado.Text, VS_strCodEmp) Then
    Exit;

  Result := True;
end;

procedure TfrmCadClientes.pOrgaoPublicoForaDoEstado;
begin
  lblOrgFde.Visible := False;
  dbeOrgFde.Visible := False;
  clrOrgFde.Visible := False;

  If fEhClienteForaDoEstado Then
  Begin
    lblOrgFde.Visible := True;
    dbeOrgFde.Visible := True;
    clrOrgFde.Visible := True;
  End;
end;

function TfrmCadClientes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strCodCid   : String;
    strEndere   : String;
    strBairro   : String;
    strNomCid   : String;
    strEstado   : String;
    strEstadoCob: String;
    strCidCob   : String;
    strEndCob   : String;
    strBaiCob   : String;
    strNomCidCob: String;
    strTipCna   : String;
    strMensCompl: String;
    strReprAtual: String;
    strReprAnt  : String;

    LCodigosCidades,
    LCodigoCorreio: String;

    blnAtualizar: Boolean;
    blnAtualizarCob: Boolean;
    strCndTmp : String;
    objDadosNFe: TValidacaoDadosNFe;

    strCodRegiao : String;
    blnPermiteAlterarVendedorRepresentante : Boolean;
    strOperador : String;
begin

  Result := True;
  blnAtualizar := False;
  blnAtualizarCob := False;
  strMensCompl := '';

  Try

    If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Begin
      {*****************************************}
      {* VALIDA O CÓDIGO DO CLIENTE            *}
      {**************************************MV*}
      If (Sender = dbeCodCli) Then
      Begin
        If (fEmptyStr(dbeCodCli.Text)) And (dbeCodCli.Enabled) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Código do Cliente deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else If (dbeCodCli.Enabled) And (Length(dbeCodCli.Text) < VS_intTamCodCli) Then
        Begin
          dbeCodCli.Field.AsString := fStrZero(dbeCodCli.Text, VS_intTamCodCli);
        End
        Else If blnBuscaPorChave Then
        Begin
          If Not fBuscaPorCamposChave Then
            pLimparCampos
          Else
          Begin
            pCarregaDadosAdicionais;
            blnLibNum := False;
            blnLibPor := False;
            blnLibPo2 := False;

            btnConsultaFit.Visible := (dbeCgcCpf.Text = '1');
          End;
        End;

      End

      {*****************************************}
      {* VALIDA A SITUAÇÃO DO CLIENTE          *}
      {**************************************RL*}
      Else If (Sender = dbeStatus) Then
      Begin
        If fEmptyStr(dbeStatus.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Situação do Cliente deve ser preenchida!', ['&Ok']);
          Result := False;
        End
        Else If (dbeStatus.Text <> 'A') And (dbeStatus.Text <> 'I') Then
          Result := False
        Else
        Begin

          If (((qryTabela.State = dsEdit  ) And (strStatus         <> dbeStatus.Text))  Or
              ((qryTabela.State = dsInsert) And (fCfgSis('STCLNV') <> dbeStatus.Text))) And
               (Not fEmptyStr( fCfgSis('SENSIT') ) )                                    Then
          Begin
            If dbeStatus.Text = 'I' Then
            Begin
              {***********************************************}
              {* VALIDA PENDENCIAS ANTES DE INATIVAR CLIENTE *}
              {********************************************AL*}
              Result := fValidarPendenciasParaInativar;
              If Not Result Then
                Exit;
            End;

            objLiberacao.Clear;
            objLiberacao.strDirAce    := 'STACLI';
            objLiberacao.strSenLib    := fCfgSis('SENSIT');
            objLiberacao.strMsgSen    := 'Status do Cliente';
            objLiberacao.strCodOpe    := strLoginUsuarioLogado;
            objLiberacao.strCodDig    := strLoginUsuarioLogado;
            objLiberacao.strCliente   := (dbeCodCli.Text + '-' + dbeNomCli.Text);
            objLiberacao.strCpfCnpj   := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
            objLiberacao.objMsgLibera.pAddTexto('Troca de status do cliente.');

            If objLiberacao.fLibera then
            begin
              if Assigned(LogAltCadCli) then
                LogAltCadCli.LogVar.AddOrSetValue(TDBEditFocus(Sender).DataField, objLiberacao.strOperador);

              strStatus := dbeStatus.Text;
              pSetFocus(dbeStatus);
              strOpeAlt[2] := objLiberacao.strOperador;

              pGeraLogLiberacao('', '', '');
            End
            Else
            Begin
              dbeStatus.Field.AsString := strStatus;
              blnMudarFoco             := False;
              pSetFocus(dbeStatus);
            End;

          End;

        End;
      End

      Else if (Sender = dbeTemSer) Then
      Begin
        if (dbeTemSer.Text <> '  /  /    ') then
        begin
          if not fValidaDataStr(dbeTemSer.Text)Then
          Begin
            pgcDados.ActivePage := tbsCrediario;

            fMensagem('ATENÇÃO!', 'A data do campo Data de Admissão não é válida!',['&OK']);
            Result := False;
          End;
        End;
      End

      {*****************************************}
      {* VALIDA O NOME / RAZÃO SOCIAL          *}
      {**************************************MV*}
      Else If (Sender = dbeNomCli) Then
      Begin
        If fEmptyStr(dbeNomCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Nome do Cliente deve ser preenchido!', ['&Ok']);
          Result := False;
        End;
      End

      {*****************************************}
      {* VALIDA O ENDEREÇO                     *}
      {**************************************MV*}
      Else If (Sender = dbeEndere) Then
      Begin
        If fEmptyStr(dbeEndere.Text) Then
        Begin
          If Not fVerificaAcessoSistema('CLIEND') Then
            strMensCompl := 'Esse usuário não tem direito para alterar o campo ENDEREÇO.';
          fMensagem('ATENÇÃO!', 'O Endereço do Cliente deve ser preenchido! '+strMensCompl, ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If (Result) And
             (dbeEndere.Text <> '') Then
          Begin
            dbeEndere.Text := fRemoverEspacosQuebrasETabs(dbeEndere.Text);
          End;

          objDadosNFe := TValidacaoDadosNFe.Create(nil);
          objDadosNFe.strEndere := dbeEndere.Text;
          objDadosNFe.strEspDoc := 'NF';
          objDadosNFe.ovOrigem  := ovCadCli;
          objDadosNFe.blnCliCons := False;
          objDadosNFe.blnSomenteItensRetira := False;

          Result := fValidaDadosClienteNFe(objDadosNFe);

          FreeAndNil(objDadosNFe);
        End;
      End

      Else If (Sender = dbeEndNum) Then
      Begin
        If fEmptyStr(dbeEndNum.Text) And (Not blnLibNum) And (Not fEmptyStr(fCfgSis('SENNUM')))Then
        Begin
          objLiberacao.Clear;
          objLiberacao.strDirAce    := 'NUMBRA';
          objLiberacao.strSenLib    := fCfgSis('SENNUM');
          objLiberacao.strMsgSen    := 'Número do endereço em branco';
          objLiberacao.strCodOpe    := strLoginUsuarioLogado;
          objLiberacao.strCodDig    := strLoginUsuarioLogado;
          objLiberacao.strCliente   := (dbeCodCli.Text + '-' + dbeNomCli.Text);
          objLiberacao.strCpfCnpj   := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
          objLiberacao.objMsgLibera.pAddTexto('Número do endereço do cliente em branco.');

          blnLibNum := objLiberacao.fLibera;

          if blnLibNum and Assigned(LogAltCadCli) then
              LogAltCadCli.LogVar.AddOrSetValue(TDBEditFocus(Sender).DataField, objLiberacao.strOperador);

          Result := blnLibNum;
        End;
      End

      Else If (Sender = dbeBairro) Then
      Begin
        If fEmptyStr(dbeBairro.Text) Then
        Begin
          If Not fVerificaAcessoSistema('CLIBAI') Then
            strMensCompl := 'Esse usuário não tem direito para alterar o campo BAIRRO.';
          fMensagem('ATENÇÃO!', 'Informe o bairro do cliente! '+strMensCompl, ['&Ok']);
          Result := False;
        End
        Else
        Begin
          objDadosNFe := TValidacaoDadosNFe.Create(nil);
          objDadosNFe.strBairro := dbeBairro.Text;
          objDadosNFe.strEspDoc := 'NF';
          objDadosNFe.ovOrigem  := ovCadCli;
          objDadosNFe.blnCliCons := False;
          objDadosNFe.blnSomenteItensRetira := False;

          Result := fValidaDadosClienteNFe(objDadosNFe);

          If (Result) And (strBairroLib <> dbeBairro.Text) Then
            Result := fValidaDireitoDeAcessoParaAlteracaoDeBairro(dbeCodCli.Text, dbeNomCli.Text, dbeNumCep.Text, dbeBairro.Text, strBairroLib);

          FreeAndNil(objDadosNFe);
        End;
      End
      Else If (Sender = dbeEndCom) Then
      Begin
        if fCfgSis('ENDSTR', varBoolean) then
        begin
          if fSomaCaracteresEndereco > 55 then
          begin
            fMensagem('ATENÇÃO!', 'O Sefaz autoriza notas fiscais com apenas 60 caracteres no endereço de entrega considerando 55 para os campos '+
                                  '"Endereço, Número e Complemento" e 5 caracteres para os separadores. Ajuste o tamanho dos campos para 55 caracteres e efetue '+
                                  'a gravação do cadastro. CFG_ENDSTR', ['&Ok']);
            Sender := dbeEndere;
            Result := False;
          end;
        end;
      End

      {*****************************************}
      {* VALIDA O CÓDIGO DA CIDADE             *}
      {**************************************MV*}
      Else If (Sender = dbeCodCid) Then
      Begin
        If fEmptyStr(dbeCodCid.Text) Then
        Begin
          If Not fVerificaAcessoSistema('CLICID') Then
            strMensCompl := 'Esse usuário não tem direito para alterar o campo CIDADE.';
          fMensagem('ATENÇÃO!', 'O Código da Cidade deve ser preenchido! '+strMensCompl, ['&Ok']);
          Result := False;
        End
        Else
        Begin
          pCarregaCidade(qryConCid, edtNomCid, edtEstado, dbeCodCid, dbeNumCep, strCepAnt);
          If qryConCid.FieldByName('CID_CODCID').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
            Result := False;
          End;
        End;

        If ((Result) And (qryTabela.State = dsEdit) And (strAltCidade <> dbeCodCid.Text) And
            Not fEmptyStr(fRetNomCidade(strAltCidade)))  Then
        Begin
          objLiberacao.Clear;
          objLiberacao.strDirAce    := 'ALTCCID';
          objLiberacao.strSenLib    := fCfgSis('SENNUM');
          objLiberacao.strMsgSen    := 'Cidade do Cliente';
          objLiberacao.strCodOpe    := strLoginUsuarioLogado;
          objLiberacao.strCodDig    := strLoginUsuarioLogado;
          objLiberacao.strCliente   := (dbeCodCli.Text + '-' + dbeNomCli.Text);
          objLiberacao.strCpfCnpj   := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
          objLiberacao.objMsgLibera.pAddTexto('Troca de Cidade no Cadastro de Cliente.');
          objLiberacao.objMsgLibera.pAddTextoCaption('Cidade Anterior', strAltCidade   + ' - ' + fRetNomCidade(strAltCidade)   + '-' + fRetNomCidade(strAltCidade, 1), 15);
          objLiberacao.objMsgLibera.pAddTextoCaption('Cidade Atual'   , dbeCodCid.Text + ' - ' + fRetNomCidade(dbeCodCid.Text) + '-' + fRetNomCidade(dbeCodCid.Text, 1), 15);

          If objLiberacao.fLibera Then
          Begin
            if Assigned(LogAltCadCli) then
              LogAltCadCli.LogVar.AddOrSetValue(TDBEditFocus(Sender).DataField, objLiberacao.strOperador);

            strAltCidade := dbeCodCid.Text;
            pSetFocus(dbeStatus);
          End
          Else
          Begin
            dbeCodCid.Field.AsString := strAltCidade;
            blnMudarFoco             := False;
            pCarregaCidade(qryConCid, edtNomCid, edtEstado, dbeCodCid, Nil, strCepAnt);
            Result := False;
            pSetFocus(dbeStatus);
          End;
        End;

        If (Result) Then
        Begin
          pHabilitaCampoSituacaoPisCofins;
        End;
      End

      Else If (Sender = dbeNumCep) Then
      Begin
        If Not fVerificaAcessoSistema('CLICEP') Then
          strMensCompl := 'Esse usuário não tem direito para alterar o campo CEP.';

        If Length(Trim(fTiraCaracEspeciais(dbeNumCep.Text))) < 8 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Cep deve conter 8 digitos. '+strMensCompl, ['&Ok']);
          Result := False;
        End;

        If (Result) And (fCfgSis('USACEP', varBoolean)) And (edtEstado.Text <> 'EX') Then
        Begin

          If (Not fCadCepDadosCep(dbeNumCep.Text, strCodCid, strEndere, strBairro, strNomCid, strEstado, LCodigoCorreio,
                                                  '' {qryConCid.FieldByName('CID_ESTADO').AsString},
                                                  '' {qryConCid.FieldByName('CID_CODCOR').AsString})) Then
          Begin
            if (fCfgSis('INVCEP', varInteger) = 1) then
            Begin
              If fEmptyStr(strMensCompl) Then
                Result := fMensagem('ATENÇÃO!', 'CEP não encontrado!' + #13 + 'Deseja continuar mesmo assim?', ['&Sim', '&Não'],2) = 1
              Else
              Begin
                fMensagem('ATENÇÃO!', 'CEP não encontrado!. '+strMensCompl, ['&Ok']);
                Result := False;
              End;
            End
            Else
            Begin
              fMensagem('ATENÇÃO!', 'CEP não encontrado! Verifique o cadastro de cidades e depois tente novamente.', ['&Ok']);
              Result := False;
            End;
          End
          Else
          Begin

            If (fEmptyStr(strCodCid)) Then
            Begin

              If Not fVerificaAcessoSistema(strPermiCadCid) Then
              Begin
                fMensagem('ATENÇÃO!', fMensagemTravaAcessoCadCid(dbeCodCid.Text, edtNomCid.Text), ['&Ok']);

                Result := False;

              End

              Else

              If Not fEmptyStr(fRetNomCidade(dbeCodCid.Text)) Then
              Begin

                If fMensagem('ATENÇÃO!', 'O Código Correios da cidade ' + edtNomCid.Text + ' está em branco.' + #13#10 +
                             'Deseja que o mesmo seja preenchido automaticamente no Cadastro de Cidades?', ['&Sim', '&Não']) = 1 Then
                Begin
                  pAtualizaCodigoCorreios(dbeCodCid.Text, dbeNumCep.Text);
                End

                Else Result := False;

              End Else

              Begin
                fMensagem('ATENÇÃO!', 'Esse CEP não tem nenhum endereço associado no cadastro do AutCom.' + #13#10 +
                                      'Será aberto o Cadastro de Cidades para o preenchimento do Código Correios.', ['&Ok']);
                pCriarForm(TfrmCadCidades);

                Result := False;
              End;
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

              If fEmptyStr(dbeCodCid.Text) Or ((blnAtualizar) And (Not fEmptyStr(strCodCid))) Then
              Begin
                dbeCodCid.Field.AsString := strCodCid;
                pCarregaCidade(qryConCid, edtNomCid, edtEstado, dbeCodCid, Nil, strCepAnt);
              End;

              If fEmptyStr(dbeEndere.Text) Or (blnAtualizar) Then
                dbeEndere.Field.AsString := strEndere;

              If fEmptyStr(dbeBairro.Text) Or (blnAtualizar) Then
                dbeBairro.Field.AsString := strBairro;

              {***********************************}
              {* CASO O CEP NÃO POSSUIR ENDERECO *}
              {********************************JB*}
              If (Not fEmptyStr(strNomCid)) And (fEmptyStr(dbeEndere.Field.AsString)) Then
              Begin
                dbeEndere.Field.AsString := fTiraCaracEspeciais(strNomCid);
                strEndere                := dbeEndere.Field.AsString;
              End;

              If (strCodCid <> dbeCodCid.Text) And (Not fEmptyStr(strCodCid)) Then
              Begin
                LCodigosCidades := untCadCid.RetornaCodigosDeCidadesComOMesmoCodCor(strCodCid, strEstado, LCodigoCorreio);

                If Pos(dbeCodCid.Text + '_', LCodigosCidades) = 0 Then
                Begin
                  Result := False;
                  pMensagemOk('O CEP informado não pertence a cidade de ' + fRetNomCidade(dbeCodCid.Text) + '!');
                End;
              End;

            End;

          End;

          If (Result) Then
          Begin
            If ((fTiraCaracEspeciais(strCepAnt) <> fTiraCaracEspeciais(dbeNumCep.Text)) Or (fEmptyStr(dbeCodReg.text))) Then
            Begin
              if fCfgSis('CEPREG', varBoolean)  then
              begin
                strCodRegiao := fRetornarCodRegiao(dbeNumCep.Text);

                if Not fEmptyStr(strCodRegiao) then
                begin
                  dbeCodReg.Field.AsString := strCodRegiao;
                  dbeCodReg.Enabled := false;
                  edtDesReg.Text := fRetNomRegiao(dbeCodReg.Text)
                end
                Else
                Begin
                  dbeCodReg.Field.Clear;
                  edtDesReg.Clear;
                  dbeCodReg.Enabled := true;
                End;
              End;
            End;

            strCepAnt := dbeNumCep.Text;

            If blnAtualizar Then
            Begin
              pSetFocus(dbeEndNum);
              blnMudarFoco := False;
            End;
          End;

        End;

      End

      {*************************************************}
      {* VALIDA A DATA DE NASCIMENTO CONF CONFIGURACAO *}
      {**********************************************IV*}
      Else If (Sender = dbeDtaNas) Then
      Begin

        If (fEmptyStr(fTiraCaracEspeciais(dbeDtaNas.Text))) Then
        Begin

          If (Not fEmptyStr(IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text))) Then
          Begin
            If (fCfgSis('DTANSC', varBoolean)) And (Length(fTiraCaracEspeciais(IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text))) = 11) Then
            Begin
              fMensagem('ATENÇÃO!', 'A Data de Nascimento deve ser informada quando for Pessoa Física!', ['&Ok']);
              Result := False;
            End;


            If (fCfgSis('DTAFND', varBoolean)) And (Length(fTiraCaracEspeciais(IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text))) = 14) Then
            Begin
              fMensagem('ATENÇÃO!', 'A Data de Fundação deve ser informada quando for Pessoa Jurídica!', ['&Ok']);
              Result := False;
            End;
          End;

        End;

        If Result Then
        Begin

          If (fEmptyStr(fTiraCaracEspeciais(dbeDtaNas.Text))) Then
          Begin
            dbeDtaNas.Field.Value := Null;
          End;

        End;

      End

      Else If (Sender = dbeValSuf) And (dbeValSuf.Enabled) Then
      Begin

        If (fCfgSis('OBVLSU', varBoolean)) And (Not fEmptyStr(dbeSuframa.text)) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(dbeValSuf.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'É obrigatório informar a data de validade Suframa conforme definido na CFG_OBVLSU.', ['&Ok']);
            Result := False;
          End;
        End;

        If Result Then
        Begin
          If (fEmptyStr(fTiraCaracEspeciais(dbeValSuf.Text))) Then
          Begin
            dbeValSuf.Field.Value := Null;
          End;
        End;

      End

      {*****************************************}
      {* VALIDA O CAMPO CNPJ / CPF             *}
      {**************************************MV*}
      Else If Sender = dbeCgcCpf Then
      Begin
        btnConsultaFit.Visible := (dbeCgcCpf.Text = '1');

        If (dbeCgcCpf.Enabled) Then
        Begin
          If (fEmptyStr(dbeCgcCpf.Text)) Or (dbeCgcCpf.Text = '0') Then
          Begin
            fMensagem('ATENÇÃO!', 'O CNPJ / CPF deve ser preenchido!', ['&Ok']);
            Result := False;
          End
          Else
          Begin
            If (dbeCgcCpf.Text <> '1') And (dbeCgcCpf.Text <> '2') Then
              Result := False;
          End;

          If (strAltCgcCpf <> dbeCgcCpf.Text) Then
            If Assigned(LogAltCadCli) Then
              LogAltCadCli.LogVar.AddOrSetValue(TDBEditFocus(Sender).DataField, strLoginUsuarioLogado);

          strAltCgcCpf := dbeCgcCpf.Text;
        End;
      End

      {*****************************************}
      {* VALIDA CNPJ / CPF                     *}
      {**************************************MV*}
      Else If ((Sender = dbeNuCpnj) And dbeNuCpnj.Enabled And dbeNuCpnj.Visible) Or
              ((Sender = dbeCpfDev) And dbeCpfDev.Enabled And dbeCpfDev.Visible) Then
      Begin
        If fEmptyStr(TDBEditFocus(Sender).Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O CNPJ / CPF deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else If (strNuCnpjAnt <> TDBEditFocus(Sender).Text) Or (blnVerificarCgcCPF)  Then
        Begin
          blnVerificarCgcCPF := False;

          Result := fValidaCampos(dbeCgcCpf, True);
          If (Result) Then
            Result := fValidaCnpjCpf(dbeCgcCpf.Text, TDBEditFocus(Sender).Text, False, True);

          If (Result) And (Not fClienteConsumidor(dbeNomCli.Text)) Then
          Begin
            If fCfgSis('CPFSDV', VarBoolean) Then
            Begin
              Result := (Not fExisteCnpjCpf('CADCLI','CLI_CODCLI',dbeCodCli.Text,'CLI_C_G_C_',TDBEditFocus(Sender).Text,edtEstado.Text)) And
                        (Not fExisteCnpjCpf('CADCLI','CLI_CODCLI',dbeCodCli.Text,'CLI_CPFDEV',TDBEditFocus(Sender).Text,edtEstado.Text));
            End
            Else
              Result := (Not fExisteCnpjCpf('CADCLI','CLI_CODCLI',dbeCodCli.Text,'CLI_C_G_C_',TDBEditFocus(Sender).Text,edtEstado.Text));

            If (Not Result) And (fCfgSis('VERCGC') = 'L') Then
            Begin
              objLiberacao.Clear;
              objLiberacao.strDirAce    := 'VERCPF';
              objLiberacao.strCodOpe    := strLoginUsuarioLogado;
              objLiberacao.objMsgLibera.pAddTexto('Já existe um outro cliente com o CPF ' + TDBEditFocus(Sender).Text + ' cadastrado!');

              Result := objLiberacao.fLibera;
              if Result and Assigned(LogAltCadCli) then
                LogAltCadCli.LogVar.AddOrSetValue(TDBEditFocus(Sender).DataField, objLiberacao.strOperador);

              blnLiberouTravaCgcCPF := Result;
            End;
          End;

          If Not Result Then
            Sender := dbeCgcCpf
          Else
            strNuCnpjAnt := TDBEditFocus(Sender).Text;
        End;
      End

      Else If (Sender = dbeNumRg) And (dbeCgcCpf.Text = '2') And
              (fCfgSis('CLOBRG', varBoolean)) And (fEmptyStr(dbeNumRg.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O RG deve ser preenchido!', ['&Ok']);
        Result := False;
      End

      Else If ((Sender = dbeEmail) Or (Sender = dbeEmailNfe2) Or (Sender = dbeEmailNFe)) Then Begin

        If (Not (fContarString(';', TDBEditFocus(Sender).Text) In [fContarString('@', TDBEditFocus(Sender).Text), fContarString('@', TDBEditFocus(Sender).Text) - 1])) Then Begin
          If (Sender = dbeEmail) Then
            fMensagem('ATENÇÃO!', 'Foram informados mais de 1 endereço de e-mail no campo ' +
              QuotedStr('E-Mail - 1') + ', separe-os com ' + QuotedStr(';') + ' (ponto e vírgula) e certifique-se' +
              ' de que o caracter ' + QuotedStr('@') + ' foi informado corretamente em cada um deles!', ['&Ok'])
          Else If (Sender = dbeEmailNfe2) Then
            fMensagem('ATENÇÃO!', 'Foram informados mais de 1 endereço de e-mail no campo ' +
              QuotedStr('E-Mail NFe 2') + ', separe-os com ' + QuotedStr(';') + ' (ponto e vírgula) e certifique-se' +
              ' de que o caracter ' + QuotedStr('@') + ' foi informado corretamente em cada um deles!', ['&Ok'])
          Else If (Sender = dbeEmailNFe) Then
            fMensagem('ATENÇÃO!', 'Foram informados mais de 1 endereço de e-mail no campo ' +
              QuotedStr('E-Mail NFe') + ', separe-os com ' + QuotedStr(';') + ' (ponto e vírgula) e certifique-se' +
              ' de que o caracter ' + QuotedStr('@') + ' foi informado corretamente em cada um deles!', ['&Ok']);

          Result := False;
        End;

        If (Result) And
           (TDBEditFocus(Sender).Text <> '') Then
        Begin
          TDBEditFocus(Sender).Text := fRemoverEspacosQuebrasETabs(TDBEditFocus(Sender).Text);
        End;

        If (Result) And (Sender = dbeEmail) Then Begin
          Result := fEmailValido(dbeEmail.Text, True, 'E-Mail - 1', True);
        End;

        If (Result) And (Sender = dbeEmailNFe) Then Begin
          Result := fEmailValido(dbeEmailNFe.Text);
          If Result Then Begin
            objDadosNFe := TValidacaoDadosNFe.Create(nil);
            objDadosNFe.strEmaNfe   := dbeEmailNFe.Text;
            objDadosNFe.tcTipoCampo := tcEmail1;
            objDadosNFe.strEspDoc   := 'NF';
            objDadosNFe.ovOrigem    := ovCadCli;
            objDadosNFe.blnCliCons  := False;
            objDadosNFe.blnSomenteItensRetira := False;

            Result := fValidaDadosClienteNFe(objDadosNFe);

            FreeAndNil(objDadosNFe);
          End;
        End;

        If (Result) And (Sender = dbeEmailNfe2) Then Begin
          Result := fEmailValido(dbeEmailNfe2.Text, True, 'E-mail 2', True);
          If Result And (Not fEmptyStr(dbeEmailNfe2.Text)) Then Begin
            objDadosNFe := TValidacaoDadosNFe.Create(nil);
            objDadosNFe.strEmaNfe   := dbeEmailNfe2.Text;
            objDadosNFe.tcTipoCampo := tcEmail2;
            objDadosNFe.strEspDoc   := 'NF';
            objDadosNFe.ovOrigem    := ovCadCli;
            objDadosNFe.blnCliCons  := False;
            objDadosNFe.blnSomenteItensRetira := False;

            Result := fValidaDadosClienteNFe(objDadosNFe);

            FreeAndNil(objDadosNFe);
          End;
        End;

        If (Result) And
          (Not fEmptyStr(Trim(TDBEditFocus(Sender).Text))) And
          (Copy(Trim(TDBEditFocus(Sender).Text), Length(Trim(TDBEditFocus(Sender).Text)), 1) <> ';') Then
          TDBEditFocus(Sender).Text := Trim(TDBEditFocus(Sender).Text) + ';';
      End

      Else If (tbsCbrEnt.TabVisible) and ((Sender = dbeEMCOB1) Or (Sender = dbeEMCOB2)) Then
      Begin

        If (Sender = dbeEMCOB1) Then
        Begin
          If (Not (fContarString(';', TDBEditFocus(Sender).Text) In [fContarString('@', TDBEditFocus(Sender).Text), fContarString('@', TDBEditFocus(Sender).Text) - 1])) Then
          Begin
            fMensagem('ATENÇÃO!', 'Foram informados mais de 1 endereço de e-mail no campo E-Mail Cobrança 1, separe-os com ; (ponto e vírgula) e certifique-se' +
                      ' de que o caracter @ foi informado corretamente em cada um deles!', ['&Ok']);

            Result := False;
          End;

          If (Result) And
             (dbeEMCOB1.Text <> '') Then
          Begin
            dbeEMCOB1.Text := fRemoverEspacosQuebrasETabs(dbeEMCOB1.Text);
          End;

          If Result Then
          Begin
            Result := fEmailValido(TDBEditFocus(Sender).Text, True, 'E-Mail Cobrança 1', True,False);
          End;

        End

        Else If (Sender = dbeEMCOB2) Then
        Begin
          If (Not (fContarString(';', TDBEditFocus(Sender).Text) In [fContarString('@', TDBEditFocus(Sender).Text), fContarString('@', TDBEditFocus(Sender).Text) - 1])) Then
          Begin
            fMensagem('ATENÇÃO!', 'Foram informados mais de 1 endereço de e-mail no campo E-Mail Cobrança 2, separe-os com ; (ponto e vírgula) e certifique-se' +
                      ' de que o caracter @ foi informado corretamente em cada um deles!', ['&Ok']);

            Result := False;
          End;

          If (Result) And
             (dbeEMCOB2.Text <> '') Then
          Begin
            dbeEMCOB2.Text := fRemoverEspacosQuebrasETabs(dbeEMCOB2.Text);
          End;

          If Result Then
          Begin
            Result := fEmailValido(TDBEditFocus(Sender).Text, True, 'E-Mail Cobrança 2', True,False);
          End;
        End;

      End

      {*****************************************}
      {* VALIDA INSCRIÇÃO ESTADUAL             *}
      {**************************************MV*}
      Else If (Sender = dbeNumIes) Then
      Begin
        If (Not fEmptyStr(dbeNumIes.Text))    And
           (Not fEmptyStr(edtEstado.Text)) Then
        Begin
          If Not fVerificaAcessoSistema('CLI_IE') Then
            strMensCompl := ' Esse usuário não tem direito para alterar o campo Inscrição Estadual.';

          dbeNumIes.Text := AnsiReplaceStr(dbeNumIes.Text, ',', '.');
          If Not fValidaIES(dbeNumIes.Text, edtEstado.Text) Then
          Begin
            fMensagem('ATENÇÃO', dbeNumIes.Text + ' não é uma Inscrição Estadual válida!'+strMensCompl, ['&Ok']);
            Result := False;
          End
          Else
          Begin
            If edtEstado.Text = 'RS' Then
            Begin
              dbeNumIes.Text := fRetornaZerosNumIes(dbeNumIes.Text) + dbeNumIes.Text;
            End;
          End;
        End
        Else
        Begin
          dbeNumIes.Clear;
        End;

        If ((Result) And (qryTabela.State = dsEdit) And (strAltInsEstadual <> dbeNumIes.Text)) Then
        Begin
          objLiberacao.Clear;
          objLiberacao.strDirAce    := 'ALTCIE';
          objLiberacao.strMsgSen    := 'Inscrição Estadual do Cliente';
          objLiberacao.strCodOpe    := strLoginUsuarioLogado;
          objLiberacao.strCodDig    := strLoginUsuarioLogado;
          objLiberacao.strCliente   := (dbeCodCli.Text + '-' + dbeNomCli.Text);
          objLiberacao.strCpfCnpj   := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
          objLiberacao.objMsgLibera.pAddTexto('Troca de Inscrição Estadual no Cadastro de Cliente');
          objLiberacao.objMsgLibera.pAddTextoCaption('Inscrição Estadual Anterior', strAltInsEstadual , 28);
          objLiberacao.objMsgLibera.pAddTextoCaption('Inscrição Estadual Atual'   , dbeNumIes.Text    , 28);

          If objLiberacao.fLibera Then
          Begin
            if Assigned(LogAltCadCli) then
              LogAltCadCli.LogVar.AddOrSetValue(TDBEditFocus(Sender).DataField, objLiberacao.strOperador);

            strAltInsEstadual := dbeNumIes.Text;
            pSetFocus(dbeStatus);
          End
          Else
          Begin
            dbeNumIes.Field.AsString := strAltInsEstadual;
            blnMudarFoco             := False;
            pSetFocus(dbeStatus);
          End;

        End;

        If Result and blnBuscaPorChave Then
        Begin
          pAjustaIesUni;
        End;


      End

      {*****************************************}
      {* VALIDA CONSUMIDOR FINAL               *}
      {**************************************MV*}
      Else If (Sender = dbeConsum) Then
      Begin
        If fEmptyStr(dbeConsum.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo Consumidor Final deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else If (dbeConsum.Text <> 'S') And (dbeConsum.Text <> 'N') Then
        Begin
          Result := False;
        End;

        If Result Then
        Begin
          dbeDesPis.Enabled := ((dbeZonFra.Text = 'S') And (dbeConsum.Text = 'N')) Or
                               (dbeOrgPub.Text = 'S');

          If Not dbeDesPis.Enabled Then
            dbeDesPis.Field.AsString := 'N';
        End;
      End

      Else If (Sender = dbeBenCst) And dbeBenCst.Visible Then
      Begin
        If fEmptyStr(dbeBenCst.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "'+lblBenCst.Caption+'" deve ser preenchido!', ['&Ok']);
          Result := False;
        End

        Else If Pos(dbeBenCst.Text,'S_N_') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "'+lblBenCst.Caption+'" deve ser Sim ou Não!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeOrgPubDifal) And (dbeOrgPubDifal.Enabled) Then
      Begin
        If fEmptyStr(dbeOrgPubDifal.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "Gera Difal para Órgão Público" deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else If Pos(dbeOrgPubDifal.Text,'S_N_') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "Gera Difal para Órgão Público", ' +
                                'deve ser "S" ou "N"!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeOrgFde) And (dbeOrgFde.Visible) Then
      Begin
        If fEmptyStr(dbeOrgFde.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "Orgão Público fora do Estado" deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else If Pos(dbeOrgFde.Text,'S_N_') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "Orgão Público fora do Estado", ' +
                                'deve ser "S" ou "N"!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeEntGov) And (dbeEntGov.Visible) Then
      Begin
        If (Not fEmptyStr(dbeEntGov.Text)) And (Pos(dbeEntGov.Text,'U_E_D_M_') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "'+lblEntGov.Caption+'" deve ser U, E, D, M ou em branco!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeMotDes) And (dbeMotDes.Enabled) And (dbeOrgPub.Text = 'S') Then
      Begin
        If fEmptyStr(dbeMotDes.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "Motivo da Desoneração" deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else If Pos(dbeMotDes.Text,'8_9_') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "Motivo da Desoneração", ' +
                                'deve ser "8" ou "9"!', ['&Ok']);
          Result := False;
        End;
      End
      {*****************************************}
      {* VALIDA ORGÃO PÚBLICO                  *}
      {**************************************JB*}
      Else If (Sender = dbeOrgPub) And (dbeOrgPub.Enabled) Then
      Begin
        If fEmptyStr(dbeOrgPub.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo Orgão Público deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else If (dbeOrgPub.Text <> 'S') And (dbeOrgPub.Text <> 'N') Then
        Begin
          Result := False;
        End
        Else If ((qryTabela.State in [dsEdit,dsInsert]) And (Trim(strOrgPubAnt) <> Trim(dbeOrgPub.Text))) Then
        Begin
          if (Not fEmptyStr(fCfgSis('SENOGP'))) then
          begin
            objLiberacao.Clear;
            objLiberacao.strDirAce    := 'ALTOGP';
            objLiberacao.strSenLib    := fCfgSis('SENOGP');
            objLiberacao.strMsgSen    := 'Orgão Público';
            objLiberacao.strCodOpe    := strLoginUsuarioLogado;
            objLiberacao.strCodDig    := strLoginUsuarioLogado;
            objLiberacao.strCliente   := (dbeCodCli.Text + '-' + dbeNomCli.Text);
            objLiberacao.strCpfCnpj   := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
            objLiberacao.objMsgLibera.pAddTexto('Alteração de Orgão Público no Cadastro de Cliente.');
            objLiberacao.objMsgLibera.pAddTextoCaption('Orgão Público Anterior', Trim(strOrgPubAnt)   , 22);
            objLiberacao.objMsgLibera.pAddTextoCaption('Orgão Público Atual'   , Trim(dbeOrgPub.Text) , 22);

            If objLiberacao.fLibera Then
            Begin
              if Assigned(LogAltCadCli) then
                LogAltCadCli.LogVar.AddOrSetValue(TDBEditFocus(Sender).DataField, objLiberacao.strOperador);

              strOrgPubAnt := dbeOrgPub.Text;
              pSetFocus(dbeOrgPub);
              blnMudarFoco := True;
            End
            Else
            Begin
              dbeOrgPub.Field.AsString := strOrgPubAnt;
              Result := False;
              blnMudarFoco := False;
              pSetFocus(dbeOrgPub);
            End;
          end
          else
            strOrgPubAnt := dbeOrgPub.Text;

          if Result and (qryTabela.State = dsInsert) then
            dbeMotDes.Field.AsString := IIF((dbeOrgPub.Text = 'S'), '8', '');
        End;

        If (Result) And (dbeOrgPub.Text = 'N') Then
        Begin
          dbeOrPuRD.Enabled := False;
          dbeOrPuRD.Field.AsString := '';
          dbeCalIcm.Enabled := False;
          dbeCalIcm.Field.AsString := '';
          dbeDesPis.Enabled := False;
          dbeDesPis.Field.AsString := 'N';

          dbeEntGov.Enabled := False;
          dbeEntGov.Field.AsString := '';
          rdgTpOpEg.Enabled := False;
          rdgTpOpEg.Field.AsString := '0';
        End
        Else
        Begin
          dbeOrPuRD.Enabled := True;
          dbeCalIcm.Enabled := True;

          dbeEntGov.Enabled := (dbeOrgPub.Text = 'S');
          rdgTpOpEg.Enabled := dbeEntGov.Enabled;
          If (rdgTpOpEg.Enabled) And (rdgTpOpEg.Field.AsString = '') Then
            If (qryTabela.State in [dsEdit,dsInsert]) Then
              rdgTpOpEg.Field.AsString := '0';

          dbeDesPis.Enabled := ((dbeZonFra.Text = 'S') And (dbeConsum.Text = 'N')) Or
                               (dbeOrgPub.Text = 'S');
        End;
      End
      Else If (Sender = dbeAlqCsl) Then
      Begin
        If fEmptyStr(dbeAlqCsl.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Defina o campo "Alíquota CSLL"!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If fStrToFloat(dbeAlqCsl.Text) < 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'O campo "Alíquota CSLL" deve ser maior ou igual a zero!', ['&Ok']);
            Result := False;
          End;
        End;
      End

      Else If (Sender = dbeAlqCof) Then
      Begin
        If fEmptyStr(dbeAlqCof.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Defina o campo "Alíquota Cofins"!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If fStrToFloat(dbeAlqCof.Text) < 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'O campo "Alíquota Cofins" deve ser maior ou igual a zero!', ['&Ok']);
            Result := False;
          End;
        End;
      End

      Else If (Sender = dbeAlqPis) Then
      Begin
        If fEmptyStr(dbeAlqPis.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Defina o campo "Alíquota Pis"!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If fStrToFloat(dbeAlqPis.Text) < 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'O campo "Alíquota Pis" deve ser maior ou igual a zero!', ['&Ok']);
            Result := False;
          End;
        End;
      End

      Else If (Sender = dbeAlqIrf) Then
      Begin
        If fEmptyStr(dbeAlqIrf.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Defina o campo "Alíquota IRPJ"!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If fStrToFloat(dbeAlqIrf.Text) < 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'O campo "Alíquota IRPJ" deve ser maior ou igual a zero!', ['&Ok']);
            Result := False;
          End;
        End;
      End

      {Else If (Sender = dbcCategoria) Then
      Begin
  //      If (blnBuscaPorChave) And (Not edtCodEmpresa.Visible) Then
  //        pProximaPagina;
      End}

      Else If (Sender = dbePeEmp) And dbePeEmp.Visible Then
      Begin
        If fEmptyStr(dbePeEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo Permite Empréstimo deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else If Pos(dbePeEmp.Text,'S_N_') <= 0 Then
        Begin
          Result := False;
        End;
      End

      Else If (Sender = dbeBolPar) Then
      Begin
        If Pos(dbeBolPar.Text,'S_N_') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "Na impressão de boletos, exibe a parcela no número do documento para vendas à vista", ' +
                                'deve ser preenchido com "S" ou "N"!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeBolSen) Then
      Begin
        If Pos(dbeBolSen.Text,'S_N_') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "Utilizar senha ao abrir pdf de boleto bancário no email", ' +
                                'deve ser preenchido com "S" ou "N"!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeProPer) Then
      Begin
        If Pos(dbeProPer.Text,'S_N_') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "Utilizar protesto personalizado por cliente", ' +
                                'deve ser preenchido com "S" ou "N"!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeSibIcm) Then
      Begin
        If fEmptyStr(dbeSibIcm.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "' + lblSibIcm.Caption + '" deve ser preenchido!', ['&OK']);
          Result := False;
        End
        Else If Pos(dbeSibIcm.Text,'S_N_') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "' + lblSibIcm.Caption + '" deve ser (S)im ou (N)ão!', ['&OK']);
          Result := False;
        End;
      end


      Else If (Sender = dbeRecali) Then
      Begin
        If Pos(dbeRecali.Text,'S_N_') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "' + lblRecali.Caption + '" deve ser (S)im ou (N)ão!', ['&OK']);
          Result := False;
        End;
      end

      Else If (Sender = dbeRECAP_) Then
      Begin
        If fEmptyStr(dbeRECAP_.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "' + lblRECAP_.Caption + '" deve ser preenchido!', ['&OK']);
          Result := False;
        End
        Else If Pos(dbeRECAP_.Text,'S_N_') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "' + lblRECAP_.Caption + '" deve ser (S)im ou (N)ão!', ['&OK']);
          Result := False;
        End;

        If (blnBuscaPorChave) And (Result) And (dbeRECAP_.Text = 'N') Then
          pProximaPagina;
      end

      Else If (Sender = dbeRegDes) And (TabRegimeEspecial.TabVisible) Then
      Begin
        If fEmptyStr(dbeRegDes.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "Permitir desmembrar pedidos do Regime Especial" deve ser preenchido!', ['&OK']);
          Result := False;
        End
        Else If Pos(dbeRegDes.Text, 'S_N_') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "Permitir desmembrar pedidos do Regime Especial" deve ser (S)im ou (N)ão!', ['&OK']);
          Result := False;
        End;
      End

      Else If (Sender = dbeLayCFF) And (dbeLayCFF.Visible) Then
      Begin
        If fEmptyStr(dbeLayCFF.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "' + lblLayCFF.Caption + '" deve ser preenchido!', ['&OK']);
          Result := False;
        End
        Else If Pos(dbeLayCFF.Text, 'S_N_') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "' + lblLayCFF.Caption + '" deve ser (S)im ou (N)ão!', ['&OK']);
          Result := False;
        End;
      End

      Else If (Sender = dbeIgtVmk) And (pnlIgnoraTravaMargemCondPag.Visible) Then
      Begin
        If fEmptyStr(dbeIgtVmk.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "' + lblIgtVmk.Caption + '" deve ser preenchido!', ['&OK']);
          Result := False;
        End
        Else If (Not MatchStr(dbeIgtVmk.Text, ['S','N'])) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "' + lblIgtVmk.Caption + '" deve ser (S)im ou (N)ão!', ['&OK']);
          Result := False;
        End;

        If (Result) And
           (strIgtVmkAnt <> dbeIgtVmk.Text) And
           (qryTabela.State = dsEdit) Then
        Begin
          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto('Permissão para alteração do Ignorar trava de Margem/Markup Mínimo e Máximo da Cond.Pag.');
          objLiberacao.objMsgLibera.pAddSeparador(100);
          objLiberacao.objMsgLibera.pAddTextoCaption('Tipo Informado', dbeIgtVmk.Text);
          objLiberacao.objMsgLibera.pAddTextoCaption('Tipo Anterior', strIgtVmkAnt) ;
          objLiberacao.strDirAce  := 'ALTIGTVMK';
          objLiberacao.strMsgSen  := 'Liberacao de Alteração do Ignorar trava de Margem/Markup Mínimo e Máximo da Cond.Pag.';
          objLiberacao.blnMosMen  := True;
          objLiberacao.strCodOpe  := strLoginUsuarioLogado;
          objLiberacao.strCodDig  := strLoginUsuarioLogado;
          objLiberacao.strCliente := (dbeCodCli.Text + '-' + dbeNomCli.Text);;
          objLiberacao.blnUsarSenhaFixa         := False;
          objLiberacao.blnSempreVariavelUsuario := True;

          Result := objLiberacao.fLibera;

          If (Not Result) Then
            dbeIgtVmk.Text := strIgtVmkAnt
          Else
            strIgtVmkAnt:= dbeIgtVmk.Text;
        End;
      End

      {*****************************************}
      {* VALIDA ZONA FRANCA                    *}
      {**************************************AF*}
      Else If (Sender = dbeZonFra) And dbeZonFra.Visible Then
      Begin

        If fEmptyStr(dbeZonFra.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo Zona Franca deve ser preenchido!', ['&Ok']);
          Result := False;
        End

        Else If Pos(dbeZonFra.Text,'S_N_') <= 0 Then
        Begin
          Result := False;
        End

        Else If (((qryTabela.State = dsEdit  ) And (strZonFraAnt <> dbeZonFra.Text))  Or
                 ((qryTabela.State = dsInsert) And (strZonFraAnt <> dbeZonFra.Text))) And
                  (Not fEmptyStr( fCfgSis('SENZOF') ) )                               Then
        Begin
          objLiberacao.Clear;
          objLiberacao.strDirAce    := 'ALTZOF';
          objLiberacao.strSenLib    := fCfgSis('SENZOF');
          objLiberacao.strMsgSen    := 'Zona Franca';
          objLiberacao.strCodOpe    := strLoginUsuarioLogado;
          objLiberacao.strCodDig    := strLoginUsuarioLogado;
          objLiberacao.strCliente   := (dbeCodCli.Text + '-' + dbeNomCli.Text);
          objLiberacao.strCpfCnpj   := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
          objLiberacao.objMsgLibera.pAddTexto('Troca de Zona Franca no Cadastro de Cliente.');
          objLiberacao.objMsgLibera.pAddTextoCaption('Zona Franca Anterior', strZonFraAnt   , 20);
          objLiberacao.objMsgLibera.pAddTextoCaption('Zona Franca Atual'   , dbeZonFra.Text , 20);

          If objLiberacao.fLibera Then
          Begin
            if Assigned(LogAltCadCli) then
              LogAltCadCli.LogVar.AddOrSetValue(TDBEditFocus(Sender).DataField, objLiberacao.strOperador);

            strZonFraAnt := dbeZonFra.Text;
            pSetFocus(dbeZonFra);
            blnMudarFoco := True;
          End
          Else
          Begin
            dbeZonFra.Text := strZonFraAnt;
            blnMudarFoco := False;
            Result := False;
          End;

        End;

        If Result Then
        Begin
          dbeDesPis.Enabled := ((dbeZonFra.Text = 'S') And (dbeConsum.Text = 'N')) Or
                               (dbeOrgPub.Text = 'S');

          If Not dbeDesPis.Enabled Then
            dbeDesPis.Field.AsString := 'N';
        End;

        If Result Then
        Begin
          dbeDesZon.Enabled := (dbeZonFra.Text = 'S');
        End;
      End

      Else If (Sender = dbeDesZon) And dbeDesZon.Visible Then
      Begin
        If fEmptyStr(dbeDesZon.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "'+lblDesZon.Caption+'" deve ser preenchido!', ['&Ok']);
          Result := False;
        End

        Else If Pos(dbeDesZon.Text,'S_N_') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "'+lblDesZon.Caption+'" deve ser Sim ou Não!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeIvaEsp) Then
      Begin
        dbeIvaEsp.Enabled := (fUsaCamposIvaEsp) And Not fEmptyStr(dbeNumIES.Text);

        If fEmptyStr(dbeIvaEsp.Text) Or (Not dbeIvaEsp.Enabled) Then
        Begin
          dbeIvaEsp.Field.AsFloat := 0.0000;
        End
        Else If Not fValidaEscala(dbeIvaEsp.Text, 0, 3) Then
        Begin
          fMensagem('ATENÇÃO!', 'Fator de I.V.A. (Produtos Importados) deve estar entre 0,0000 e 3,0000!', ['&Ok']);
          Result := False;
        End;
        pHabilitaCampoSibIcm;
      End

      Else If (Sender = dbeIvaEspCEDEM) Then
      Begin
        dbeIvaEspCEDEM.Enabled := (fUsaCamposIvaEsp) And Not fEmptyStr(dbeNumIES.Text);

        If fEmptyStr(dbeIvaEspCEDEM.Text) Or (Not dbeIvaEspCEDEM.Enabled) Then
        Begin
          dbeIvaEspCEDEM.Field.AsFloat := 0.0000;
        End
        Else If Not fValidaEscala(dbeIvaEspCEDEM.Text, 0, 3) Then
        Begin
          fMensagem('ATENÇÃO!', 'Fator de I.V.A. (Produtos Importados) do CEDEM deve estar entre 0,0000 e 3,0000!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeIvaNac) Then
      Begin
        dbeIvaNac.Enabled := (fUsaCamposIvaEsp) And Not fEmptyStr(dbeNumIES.Text);

        If fEmptyStr(dbeIvaNac.Text) Or (Not dbeIvaNac.Enabled) Then
        Begin
          dbeIvaNac.Field.AsFloat := 0.0000;
        End
        Else If Not fValidaEscala(dbeIvaNac.Text, 0, 3) Then
        Begin
          fMensagem('ATENÇÃO!', 'Fator de I.V.A. (Produtos Nacionais) deve estar entre 0,0000 e 3,0000!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeIvaNacCEDEM) Then
      Begin
        dbeIvaNacCEDEM.Enabled := (fUsaCamposIvaEsp) And Not fEmptyStr(dbeNumIES.Text);

        If fEmptyStr(dbeIvaNacCEDEM.Text) Or (Not dbeIvaNacCEDEM.Enabled) Then
        Begin
          dbeIvaNacCEDEM.Field.AsFloat := 0.0000;
        End
        Else If Not fValidaEscala(dbeIvaNacCEDEM.Text, 0, 3) Then
        Begin
          fMensagem('ATENÇÃO!', 'Fator de I.V.A. (Produtos Nacionais) do CEDEM deve estar entre 0,0000 e 3,0000!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeIvaSim) Then
      Begin
        dbeIvaSim.Enabled := (fUsaCamposIvaEsp) And Not fEmptyStr(dbeNumIES.Text);

        If fEmptyStr(dbeIvaSim.Text) Or (Not dbeIvaSim.Enabled) Then
        Begin
          dbeIvaSim.Field.AsFloat := 0.0000;
        End
        Else If fStrToFloat(dbeIvaSim.Text) < 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Percentual de carga média (CNAE Simplificado) deve ser maior que zero!', ['&Ok']);
          Result := False;
        End
        Else If fStrToFloat(dbeIvaSim.Text) > 0 Then
        Begin
          dbeIvaEsp.Field.AsFloat := 0.0000;
          dbeIvaNac.Field.AsFloat := 0.0000;
        End;
      End

      Else If (Sender = dbeIvaSimCEDEM) Then
      Begin
        dbeIvaSimCEDEM.Enabled := (fUsaCamposIvaEsp) And Not fEmptyStr(dbeNumIES.Text);

        If fEmptyStr(dbeIvaSimCEDEM.Text) Or (Not dbeIvaSimCEDEM.Enabled) Then
        Begin
          dbeIvaSimCEDEM.Field.AsFloat := 0.0000;
        End
        Else If fStrToFloat(dbeIvaSimCEDEM.Text) < 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Percentual de carga média (CNAE Simplificado) do CEDEM deve ser maior que zero!', ['&Ok']);
          Result := False;
        End
        Else If fStrToFloat(dbeIvaSimCEDEM.Text) > 0 Then
        Begin
          dbeIvaEspCEDEM.Field.AsFloat := 0.0000;
          dbeIvaNacCEDEM.Field.AsFloat := 0.0000;
        End;
      End

      Else If (sender = dbeRedIcm) And (dbeRedIcm.Enabled) Then
      Begin
        If Not fValidaEscala(dbeRedIcm.Text, 0, 100) Then
        Begin
          fMensagem('', 'O percentual de redução de ICMS deve estar entre 0 e 100!', ['&Ok']);
          Result := False;
        End;
      End

      {*****************************************}
      {* VALIDA O CAMPO "SIMPLES"              *}
      {**************************************MV*}
      Else If (Sender = dbeRegTri) THen
      Begin
        Result := (Pos(dbeRegTri.Text, 'SRP') > 0);
        If Not Result Then
         fMensagem('ATENÇÃO', 'O campo regime de tributação deve ser S, R ou P!',['&O K']);
      End

      Else If Sender = dbeSuframa Then
      Begin
        If (Pos(edtEstado.Text, 'AC_AM_AP_RO_RR_') <= 0) Then
        Begin
          dbeSuframa.Field.AsString := '';
        End;
      End

      {*******************************************}
      {* VALIDA O PERCENTUAL DESCONTO PONTUALID. *}
      {****************************************IV*}
      Else If (Sender = dbePerDPo) And (dbePerDPo.Visible) Then
      Begin
        If fEmptyStr(dbePerDPo.Text) Then
        Begin
          dbePerDPo.Field.AsFloat := 0.0;
        End
        Else If ( Not ( fStrToFloat(dbePerDPo.Text) >= 0 ) ) Then
        Begin
          fMensagem('', 'O Percentual de Desconto Pontualidade deve ser maior ou igual a zero !', ['&Ok']);
          Result := False;
        End;
      End

      {*******************************************}
      {* VALIDA A QTD DIAS ANTECIP P/ DESC.PONT. *}
      {****************************************IV*}
      Else If (Sender = dbeQtdDAV) And (dbeQtdDAV.Visible) Then
      Begin
        If fEmptyStr(dbeQtdDAV.Text) Then
        Begin
          dbeQtdDAV.Field.AsInteger := 0;
        End
        Else If ( Not ( StrToInt(dbeQtdDAV.Text) >= 0 ) ) Then
        Begin
          fMensagem('', 'A Qtde de Dias de Antecipação deve ser maior ou igual a zero !', ['&Ok']);
          Result := False;
        End
        Else If (((qryTabela.State = dsEdit  ) And (IntToStr(intDesPonAnt) <> dbeQtdDAV.Text))  Or
                 ((qryTabela.State = dsInsert) And (IntToStr(intDesPonAnt) <> dbeQtdDAV.Text))) Then
        Begin
          objLiberacao.Clear;
          objLiberacao.strDirAce    := 'ACQDDP';
          objLiberacao.strSenLib    := '';
          objLiberacao.strMsgSen    := 'Alteração da Qtde de Dias de Antecipação do Vencimento para Concessão do Desconto Pontualidade';
          objLiberacao.strCodOpe    := strLoginUsuarioLogado;
          objLiberacao.objMsgLibera.pAddTexto('Alteração da Qtde de Dias de Antecipação do Vencimento para Concessão do Desconto Pontualidade');
          objLiberacao.objMsgLibera.pAddTextoCaption('Qtde Dias Digitado', dbeQtdDAV.Text);
          objLiberacao.objMsgLibera.pAddTextoCaption('Qtde Dias Anterior', IntToStr(intDesPonAnt));

          If (Not objLiberacao.fLibera) Then
          Begin
            dbeQtdDAV.Field.AsInteger := intDesPonAnt;
            blnMudarFoco := False;
            pSetFocus(dbeQtdDAV);
          End
          Else
          Begin
            intDesPonAnt := StrToInt(dbeQtdDAV.Text);
            pSetFocus(dbeQtdDAV);
            blnMudarFoco := True;
          End;
        End;
      End

      Else If (Sender = dbeFtNfEs) And grbNotaEspecial.Visible Then
      Begin
        If Not fValidaEscala(dbeFtNfEs.Text, 0, 1) Then
        Begin
          fMensagem('','O fator para nota especial deve estar enter 0 e 1, verifique!', ['&Ok']);
          Result := False;
        End;

        {TRATAR A LIBERAÇÃO PARA A DIMINUIÇÃO DO FATOR - KM}
        If (Result) And (fCfgSis('FATNSP',varBoolean)) Then
        Begin
          If (fltFatValAnt > fStrToFloat(dbeFtNfEs.Text)) And (Not fEmptyStr(dbeFtNfEs.Text)) Then
          Begin
            Try
              objLiberacao := TLiberacao.Create;

              objLiberacao.objMsgLibera.pAddTexto('Permissão para diminuir o fator de nota especial');
              objLiberacao.objMsgLibera.pAddSeparador(100);
              objLiberacao.objMsgLibera.pAddTextoCaption('Fator Digitado', FloatToStrF(StrToFloat(dbeFtNfEs.Text),ffNumber, 12, 3));
              objLiberacao.objMsgLibera.pAddTextoCaption('Fator Anterior', FloatToStrF(fltFatValAnt, ffNumber, 12, 3));
              objLiberacao.strDirAce  := 'DIMFNE';
              objLiberacao.strSenLib  := fCfgSis('SENLBD');
              objLiberacao.strMsgSen  := 'Liberacao de Diminuição do Fator de Nota Especial';
              objLiberacao.blnMosMen  := True;
              objLiberacao.strCodOpe  := strLoginUsuarioLogado;
              objLiberacao.strCodDig  := strLoginUsuarioLogado;
              objLiberacao.strCliente := (dbeCodCli.Text + '-' + dbeNomCli.Text);;
              objLiberacao.strCpfCnpj := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
              objLiberacao.blnUsarSenhaFixa         := False;
              objLiberacao.blnSempreVariavelUsuario := True;
            Finally
              If objLiberacao.fLibera Then
              Begin
                if (fltFatValAnt <> fStrToFloat(dbeFtNfEs.Text)) then
                begin
                  if (fltFatValAnt = 0) And (fStrToFloat(dbeFtNfEs.Text) > 0) Then
                    dtsTabela.DataSet.FieldByName('CLI_TIPFAT').AsString := 'B'
                  else if (fltFatValAnt > 0) and (fStrToFloat(dbeFtNfEs.Text) = 0) then
                    dtsTabela.DataSet.FieldByName('CLI_TIPFAT').AsString := 'A';
                end;
                if Assigned(LogAltCadCli) then
                  LogAltCadCli.LogVar.AddOrSetValue(TDBEditFocus(Sender).DataField, objLiberacao.strOperador);

                fltFatValAnt   := fStrToFloat(dbeFtNfEs.Text);
                pSetFocus(dbeFtNfEs);
                blnMudarFoco := True;
              End
              Else
              Begin
                dbeFtNfEs.Field.AsString := FloatToStrF(fltFatValAnt, ffNumber, 12, 3);
                Result := False;
                blnMudarFoco := False;
                pSetFocus(dbeFtNfEs);
              End;
              FreeAndNil(objLiberacao);
            End;
          End
          Else
          Begin
            if (fltFatValAnt <> fStrToFloat(dbeFtNfEs.Text)) then
            begin
              if (fltFatValAnt = 0) And (fStrToFloat(dbeFtNfEs.Text) > 0) Then
                dtsTabela.DataSet.FieldByName('CLI_TIPFAT').AsString := 'B'
              else if (fltFatValAnt > 0) and (fStrToFloat(dbeFtNfEs.Text) = 0) then
                dtsTabela.DataSet.FieldByName('CLI_TIPFAT').AsString := 'A';
            end;
          End;
        End
        Else If (Result) And (Not fCfgSis('FATNSP',varBoolean)) Then
        Begin
          if (fltFatValAnt <> fStrToFloat(dbeFtNfEs.Text)) then
          begin
            if (fltFatValAnt = 0) And (fStrToFloat(dbeFtNfEs.Text) > 0) Then
              dtsTabela.DataSet.FieldByName('CLI_TIPFAT').AsString := 'B'
            else if (fltFatValAnt > 0) and (fStrToFloat(dbeFtNfEs.Text) = 0) then
              dtsTabela.DataSet.FieldByName('CLI_TIPFAT').AsString := 'A';
          end;
        End;
      End

      Else If (Sender = dbeTFtNEs) And grbNotaEspecial.Visible Then
      Begin
        If Pos(dbeTFtNEs.Text, 'V_Q_') <= 0 Then
        Begin
          fMensagem('','O tipo de fator para nota especial deve ser (V)alor ou (Q)uantidade, verifique!', ['&Ok']);
          Result := False;
        End;

        If (fCfgSis('TFANSP',varBoolean)) And (Result) And
           (strFatTipAnt <> dbeTFtNEs.Text) And (Not fEmptyStr(dbeTFtNEs.Text)) Then
        Begin

          objLiberacao := TLiberacao.Create;

          Try
            objLiberacao.objMsgLibera.pAddTexto('Permissão para alterar o tipo do fator de nota especial');
            objLiberacao.objMsgLibera.pAddSeparador(100);
            objLiberacao.objMsgLibera.pAddTextoCaption('Tipo Informado', dbeTFtNEs.Text);
            objLiberacao.objMsgLibera.pAddTextoCaption('Tipo Anterior', strFatTipAnt) ;
            objLiberacao.strDirAce  := 'TFANSP';
            objLiberacao.strSenLib  := fCfgSis('SENLBD');
            objLiberacao.strMsgSen  := 'Liberacao de Alteração do Tipo do Fator de Nota Especial';
            objLiberacao.blnMosMen  := True;
            objLiberacao.strCodOpe  := strLoginUsuarioLogado;
            objLiberacao.strCodDig  := strLoginUsuarioLogado;
            objLiberacao.strCliente := (dbeCodCli.Text + '-' + dbeNomCli.Text);;
            objLiberacao.strCpfCnpj := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
            objLiberacao.blnUsarSenhaFixa         := False;
            objLiberacao.blnSempreVariavelUsuario := True;

            Result := objLiberacao.fLibera;

            If (not Result) then
              dbeTFtNEs.Text := strFatTipAnt
            Else
              strFatTipAnt   := dbeTFtNEs.Text;
          Finally
            FreeAndNil(objLiberacao);
          End;
        End;
      End

      Else If (Sender = dbeTipFat) And (grbNotaEspecial.Visible) Then
      Begin
        If Pos(dbeTipFat.Text, 'A_B_') <= 0 Then
        Begin
          fMensagem('','O tipo de faturamento para o pedido deve ser (A) Nota Fiscal ou (B) FF, verifique!', ['&Ok']);
          Result := False;
        End;
      End

      {*****************************************}
      {* VALIDA O CÓDIGO DO VENDEDOR           *}
      {**************************************MV*}
      Else If (Sender = dbeCodVen) Then
      Begin
        If Not fEmptyStr(dbeCodVen.Text) Then
        Begin
          pCarregaRepr_Vend(dbeCodVen.Text, edtVendedor);
          If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse vendedor não está cadastrado!', ['&Ok']);
            Result := False;
          End

          Else If ((qryTabela.State = dsEdit) And (strCodVenAnt <> dbeCodVen.Text)) Or
                  ((qryTabela.State = dsInsert) And (strVenInc <> dbeCodVen.Text) And (Not fEmptyStr(strVenInc))) Then
          Begin
            blnPermiteAlterarVendedorRepresentante := True;
            strOperador := strLoginUsuarioLogado;

            If (Not fPermitirAlterarVendedorERepresentante) Then
            Begin
              objLiberacao.Clear;
              objLiberacao.strDirAce    := 'ALTVCL';
              objLiberacao.strSenLib    := fCfgSis('SENVEN');
              objLiberacao.strMsgSen    := 'Vendedor';
              objLiberacao.strCodOpe    := strLoginUsuarioLogado;
              objLiberacao.strCodDig    := strLoginUsuarioLogado;
              objLiberacao.strCliente   := (dbeCodCli.Text + '-' + dbeNomCli.Text);
              objLiberacao.strCpfCnpj   := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
              objLiberacao.objMsgLibera.pAddTexto('Troca de Vendedor no Cadastro de Cliente.');
              objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor Anterior', strCodVenAnt   + '-' + fRetNomVendRep(strCodVenAnt)  , 17);
              objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor Atual'   , dbeCodVen.Text + '-' + fRetNomVendRep(dbeCodVen.Text), 17);

              blnPermiteAlterarVendedorRepresentante := objLiberacao.fLibera;
              strOperador := objLiberacao.strOperador;
            End;

            If blnPermiteAlterarVendedorRepresentante Then
            Begin
              if Assigned(LogAltCadCli) then
                LogAltCadCli.LogVar.AddOrSetValue(TDBEditFocus(Sender).DataField, strOperador);

              strCodVenAnt := dbeCodVen.Text;
              pSetFocus(dbeCodVen);
              blnMudarFoco := True;
              blnVendAlt   := True;
              strVenInc    := dbeCodVen.Text;
              strOpeAlt[0] := strOperador;
            End
            Else
            Begin
              If qryTabela.State = dsInsert Then
                dbeCodVen.Text := strVenInc
              Else
                dbeCodVen.Text := strCodVenAnt;
              blnMudarFoco := False;
              Result := False;
            End;

          End;

        End
        Else
        Begin
          fMensagem('ATENÇÃO!', 'O código do vendedor deve ser preenchido!', ['&Ok']);
          Result := False;
        End;
      End

      {*****************************************}
      {* VALIDA O ENQUADRAMENTO DO IPI         *}
      {**************************************CH*}
      Else If (Sender = dbeEnqIPI) Then
      Begin

        dbeDescEnqIPI.Text := fRetDescricaoEnquadramentoIPI(dbeEnqIPI.Text);

        If Not fEmptyStr(dbeEnqIPI.Text) Then
        Begin
          If (Not fEnquadramentoIPIExiste(dbeEnqIPI.Text, Copy(cbxTributacaoIPI.Text,1,1))) Then
          Begin
            fMensagem('ATENÇÃO!', 'Enquadramento de IPI não localizado para a situação selecionada!', ['&Ok']);
            Result := False;
          End;
        End;

        If (fEmptyStr(dbeEnqIPI.Text)) And ((Copy(cbxTributacaoIPI.Text,1,1) = 'I') Or (Copy(cbxTributacaoIPI.Text,1,1) = 'M') Or (Copy(cbxTributacaoIPI.Text,1,1) = 'S')) Then
        Begin
          fMensagem('', 'É necessário informar o código de enquadramento de IPI para a situação de IPI escolhida.', ['&Ok']);
          Result := False;
        End;

      End

      {*****************************************}
      {* VALIDA O CÓDIGO DO REPRESENTANTE      *}
      {**************************************MV*}
      Else If (Sender = dbeCodRep) Then
      Begin
        If (Not fEmptyStr(dbeCodRep.Text)) Then
        Begin
          pCarregaRepr_Vend(dbeCodRep.Text, edtRepresentante);

          If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse representante não está cadastrado!', ['&Ok']);
            Result := False;
          End
        End;

        If (Result) And ((qryTabela.State = dsEdit) And (strCodRepAnt <> dbeCodRep.Text)) Or
          ((qryTabela.State = dsInsert) And (strRepInc <> dbeCodRep.Text) And (Not fEmptyStr(strRepInc))) Then
        Begin
          blnPermiteAlterarVendedorRepresentante := True;
          strOperador := strLoginUsuarioLogado;

          If (Not fPermitirAlterarVendedorERepresentante) Then
          Begin
            strReprAtual := dbeCodRep.Text + '-' + fRetNomVendRep(dbeCodRep.Text);
            strReprAnt := strCodRepAnt + '-' + fRetNomVendRep(strCodRepAnt);

            objLiberacao.Clear;
            objLiberacao.strDirAce    := 'ALTVCL';
            objLiberacao.strSenLib    := fCfgSis('SENVEN');
            objLiberacao.strMsgSen    := 'Representante';
            objLiberacao.strCodOpe    := strLoginUsuarioLogado;
            objLiberacao.strCodDig    := strLoginUsuarioLogado;
            objLiberacao.strCliente   := (dbeCodCli.Text + '-' + dbeNomCli.Text);
            objLiberacao.strCpfCnpj   := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
            objLiberacao.objMsgLibera.pAddTexto('Troca de Representante no Cadastro de Cliente.');
            objLiberacao.objMsgLibera.pAddTextoCaption('Representante Anterior', IIF(fEmptyStr(strCodRepAnt), 'Vazio', strReprAnt), 22);
            objLiberacao.objMsgLibera.pAddTextoCaption('Representante Atual', IIF(fEmptyStr(dbeCodRep.Text), 'Vazio', strReprAtual), 22);

            blnPermiteAlterarVendedorRepresentante := objLiberacao.fLibera;
            strOperador := objLiberacao.strOperador;
          End;

          If blnPermiteAlterarVendedorRepresentante Then
          Begin
            if Assigned(LogAltCadCli) then
              LogAltCadCli.LogVar.AddOrSetValue(TDBEditFocus(Sender).DataField, strOperador);

            strCodRepAnt := dbeCodRep.Text;
            strRepInc    := dbeCodRep.Text;
            pSetFocus(dbeCodRep);
            blnMudarFoco := True;
            strOpeAlt[1] := strOperador;
          End
          Else
          Begin
            If qryTabela.State = dsInsert Then
              dbeCodRep.Field.Value := strRepInc
            Else
              dbeCodRep.Field.Value := strCodRepAnt;

            blnMudarFoco := False;
            Result := False;
          End;
        End;

        If (Result) And (fEmptyStr(dbeCodRep.Text)) Then
        Begin
          dbeCodRep.Field.Clear;
          edtRepresentante.Clear;
        End;
      End

      Else If (Sender = dbeSupReg) Then
      Begin

        if (fCfgSis('OBSRCC', varBoolean)) and (fEmptyStr(dbeSupReg.Text)) then
        begin
          fMensagem('ATENÇÃO!', 'O sistema está configurado para tornar obrigatório informar o Supervisor Regional no Cadastro de Clientes - CFG_OBSRCC.' + #13 +
                                'Informe o Supervisor Regional e depois, grave novamente o cadastro.', ['&Ok']);
          Result := False;
        end
        else If Not fEmptyStr(dbeSupReg.Text) Then
        Begin
          edtSupReg.Text := fRetNomVendRep(dbeSupReg.Text);
          If fEmptyStr(edtSupReg.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Supervisor Regional não encontrado!', ['&Ok']);
            Result := False;
          End;
        End

        Else edtSupReg.Clear;

      End

      Else If (Sender = dbeSupGer) Then
      Begin

        If Not fEmptyStr(dbeSupGer.Text) Then
        Begin
          edtSupGer.Text := fRetNomVendRep(dbeSupGer.Text);
          If fEmptyStr(edtSupGer.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Supervisor Geral não encontrado!', ['&Ok']);
            Result := False;
          End;
        End

        Else edtSupGer.Clear;

      End
      {*****************************************}
      {* VALIDA O CÓDIGO DA ATIVIDADE          *}
      {**************************************MV*}
      Else If (Sender = dbeCodAti) Then
      Begin
        If Not fEmptyStr(dbeCodAti.Text) Then
        Begin
          pCarregaAtividade;
          If qryConAti.FieldByName('ATI_CODATI').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa atividade não está cadastrada!', ['&Ok']);
            Result := False;
          End

          Else If (qryTabela.State = dsEdit  )       And
                  (strAltAtiAnt <> dbeCodAti.Text)   And
                  (Not fEmptyStr( fCfgSis('SENTAT')))Then
          Begin
            objLiberacao.Clear;
            objLiberacao.strDirAce    := 'ALTATI';
            objLiberacao.strSenLib    := fCfgSis('SENTAT');
            objLiberacao.strMsgSen    := 'Atividade';
            objLiberacao.strCodOpe    := strLoginUsuarioLogado;
            objLiberacao.strCodDig    := strLoginUsuarioLogado;
            objLiberacao.strCliente   := (dbeCodCli.Text + '-' + dbeNomCli.Text);
            objLiberacao.strCpfCnpj   := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
            objLiberacao.objMsgLibera.pAddTexto('Troca de atividades no Cadastro de Cliente.');
            objLiberacao.objMsgLibera.pAddTextoCaption('Atividades Anterior', strAltAtiAnt   + '-' + fRetNomAtividade(strAltAtiAnt)  , 20);
            objLiberacao.objMsgLibera.pAddTextoCaption('Atividades Atual'   , dbeCodAti.Text + '-' + fRetNomAtividade(dbeCodAti.Text), 20);

            If objLiberacao.fLibera Then
            Begin
              if Assigned(LogAltCadCli) then
                LogAltCadCli.LogVar.AddOrSetValue(TDBEditFocus(Sender).DataField, objLiberacao.strOperador);

              strAltAtiAnt := dbeCodAti.Text;
              pSetFocus(dbeCodAti);
              blnMudarFoco := True;
            End
            Else
            Begin
              dbeCodAti.Field.AsString := strAltAtiAnt;
              Result := False;
              blnMudarFoco := False;
              pSetFocus(dbeCodAti);
            End;

          End;

          If Result Then
          Begin

            {Apenas cliente de atividade construtora}
            If fCfgSis('REGFIS', varString) = '1' Then
              TabConstrutora.TabVisible := fAtividadeConstrutora(dbeCodAti.Text)
            Else
            {Para todos os clientes}
            If fCfgSis('REGFIS', varString) = '2' Then
              TabConstrutora.TabVisible := True;

          End;

          If (Result) And (qryTabela.State in [dsInsert]) Then
          Begin
            if (fCfgSis('USACND', VarBoolean)) then
            Begin
              pCarregaCondicaoPagamentoCFG(dbeCodAti.Text);
            End;

          End;

        End
        Else
        Begin
          fMensagem('ATENÇÃO!', 'O código da atividade deve ser preenchido!', ['&Ok']);
          Result := False;
        End;

      End

      Else If (Sender = dbeRegFis) And (TabConstrutora.TabVisible) Then
      Begin
        If fEmptyStr(dbeRegFis.Text) Or ((Not fEmptyStr(dbeRegFis.Text)) And (Pos(dbeRegFis.Text,'1_2_') <= 0)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Campo com valor inválido:'+#13+'Calcular as regras fiscais ( CFOP e impostos ) considerando', ['&Ok']);
          Result := False;
        End;
      End

      {*****************************************}
      {* VALIDA A TABELA DE PRECO              *}
      {**************************************MA*}
      Else If (Sender = dbeTabPre) Then
      Begin
        If Not fEmptyStr(dbeTabPre.Text) Then
        Begin

          If Pos( dbeTabPre.Text, strVrfTpr ) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'A Tabela de ' + clbPrcVenda.Caption + '!', ['&Ok']);
            Result := False;
          End

          Else If (((qryTabela.State = dsEdit  ) And (strTabPreAnt <> dbeTabPre.Text))  Or
                   ((qryTabela.State = dsInsert) And (strTabPreAnt <> dbeTabPre.Text))) And
                  (fCfgSis('SENTTP', varString) = 'S') Then
          Begin
            objLiberacao.Clear;
            objLiberacao.strDirAce    := 'CLIPRE';
            objLiberacao.strSenLib    := fCfgSis('SENTPC');
            objLiberacao.strMsgSen    := 'Tabela de Preço do Cliente';
            objLiberacao.strCodOpe    := strLoginUsuarioLogado;
            objLiberacao.strCodDig    := strLoginUsuarioLogado;
            objLiberacao.strCliente   := (dbeCodCli.Text + '-' + dbeNomCli.Text);
            objLiberacao.strCpfCnpj   := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
            objLiberacao.objMsgLibera.pAddTexto('Troca de tabela de preço no Cadastro de Cliente.');
            objLiberacao.objMsgLibera.pAddTextoCaption(strTabPreAnt  , 'Tabela de Preço Anterior', 24);
            objLiberacao.objMsgLibera.pAddTextoCaption(dbeTabPre.Text, 'Tabela de Preço Atual'   , 24);

            If objLiberacao.fLibera Then
            Begin
              if Assigned(LogAltCadCli) then
                LogAltCadCli.LogVar.AddOrSetValue(TDBEditFocus(Sender).DataField, objLiberacao.strOperador);

              strTabPreAnt := dbeTabPre.Text;
              pSetFocus(dbeTabPre);
              blnMudarFoco := True;
            End
            Else
            Begin
              dbeTabPre.Field.AsString := strTabPreAnt;
              Result := False;
              blnMudarFoco := False;
              pSetFocus(dbeTabPre);
            End;

          End;

        End
        Else
        Begin
          If (Not fCfgSis('TPRFAT', varBoolean)) Then
          Begin
            fMensagem('ATENÇÃO!', 'A Tabela de Preço deve ser preenchida!', ['&Ok']);
            Result := False;
          End;
        End

      End

      {*****************************************}
      {* VALIDA O LIMITE DE CREDITO            *}
      {**************************************MV*}
      Else If (Sender = dbeLimCre) Then
      Begin
        If (blnLimCredAut) And (fStrToFloat(dbeLimCre.Text) <> fRetValorLimCredAut) And (fStrToFloat(dbeLimCre.Text) > fLimiteCreditoCliente(dbeCodCli.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Sistema configurado para calcular aumento de Limite de Crédito automaticamente - [CFG_CREAUT]. Utilizar o botão [ATUALIZAR LIMITE CRÉDITO]', ['&Ok']);
          dbeLimCre.Field.AsFloat := fltLimCreAnt;
          Result := False;
        End
        Else If (fEmptyStr(dbeLimCre.Text)) Or (fStrToFloat(dbeLimCre.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Limite de Crédito deve ser maior ou igual Zero!', ['&Ok']);
          Result := False;
        End
        Else If fStrToFloat(dbeLimCre.Text) > MAX_VALMON Then
        Begin
          fMensagem('ATENÇÃO!', 'O Limite de Crédito deve estar entre 0 e 999999,99!', ['&Ok']);
          Result := False;
        End
        Else If (qryTabela.State = dsInsert) And (fStrToFloat(dbeLimCre.Text) > fCfgSis('LIMCRE', varDouble)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Limite de Crédito para inclusão de clientes não deve ultrapassar ' +
                                FloatToStrF(fCfgSis('LIMCRE', varDouble), ffFixed, 12, 2) + '!', ['&Ok']);
          Result := False;
        End
        Else If (fCfgSis('LMCROP', VarBoolean)) And
                (FloatToStrF(fltLimCreAnt, ffFixed, 15, 2) <> FloatToStrF(fStrToFloat(dbeLimCre.Text), ffFixed, 15, 2)) And
                (fStrToFloat(dbeLimCre.Text) > fLimCredOperador('', dbeCodCli.Text)) Then
        Begin
          if fCfgSis('LMCRTR', VarString) = '1' then
          begin
            fMensagem('ATENÇÃO!', 'O valor do limite de crédito informado ultrapassa o limite permitido para o operador!', ['&Ok']);
            Result := False;
          end
          else
          begin
            strOpeLibLimCre := strLoginUsuarioLogado;

            objLiberacao.Clear;
            objLiberacao.strDirAce    := 'LCRCLIOPE';
            objLiberacao.strSenLib    := fCfgSis('SENCRE');
            objLiberacao.strMsgSen    := 'Limite de Crédito';
            objLiberacao.strCodOpe    := strLoginUsuarioLogado;
            objLiberacao.strCodDig    := strLoginUsuarioLogado;
            objLiberacao.objMsgLibera.pAddTexto('Alteração de limite de crédito maior que alçada do operador ');
            objLiberacao.objMsgLibera.pAddQuebra();
            objLiberacao.objMsgLibera.pAddTextoCaption('Cliente' , (dbeCodCli.Text + '-' + dbeNomCli.Text)                                              , 25);
            objLiberacao.objMsgLibera.pAddTextoCaption('CPF/CNPJ' , fFormataCpfCgc(IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text), fSetaPais), 25);
            objLiberacao.objMsgLibera.pAddQuebra();
            objLiberacao.objMsgLibera.pAddTextoCaption('Limite de Crédito Atual', fPadL(FloatToStrF(fltLimCreAnt, ffFixed, 15, 2), 15)                  , 25);
            objLiberacao.objMsgLibera.pAddTextoCaption('Novo Limite de Crédito' , fPadL(FloatToStrF(fStrToFloat(dbeLimCre.Text), ffFixed, 15, 2), 15)   , 25);

            If objLiberacao.fLibera Then
            Begin
              if Assigned(LogAltCadCli) then
                LogAltCadCli.LogVar.AddOrSetValue(TDBEditFocus(Sender).DataField, objLiberacao.strOperador);

              strOpeLibLimCre := objLiberacao.strOperador;
              fltLimCreAnt := fStrToFloat(dbeLimCre.Text);
              pSetFocus(dbeLimCre);
              blnMudarFoco := True;
            End
            Else
            Begin
              dbeLimCre.Field.AsFloat := fltLimCreAnt;
              blnMudarFoco := False;
              pSetFocus(dbeLimCre);
            End;
          end;
        End
        Else If (((qryTabela.State = dsEdit  ) And (FloatToStrF(fltLimCreAnt, ffFixed, 15, 2) <> FloatToStrF(fStrToFloat(dbeLimCre.Text), ffFixed, 15, 2)))  Or
                 ((qryTabela.State = dsInsert) And (FloatToStrF(fltLimCreAnt, ffFixed, 15, 2) <> FloatToStrF(fStrToFloat(dbeLimCre.Text), ffFixed, 15, 2)))) Then
        Begin
          strOpeLibLimCre := strLoginUsuarioLogado;

          If (fLiberaAlteracaoDeLimiteDeCredito(True)) Then
          Begin
            if Assigned(LogAltCadCli) then
              LogAltCadCli.LogVar.AddOrSetValue(TDBEditFocus(Sender).DataField, objLiberacao.strOperador);

            strOpeLibLimCre := objLiberacao.strOperador;
            fltLimCreAnt := fStrToFloat(dbeLimCre.Text);
            pSetFocus(dbeLimCre);
            blnMudarFoco := True;
          End
          Else
          Begin
            dbeLimCre.Field.AsFloat := fltLimCreAnt;
            blnMudarFoco := False;
            pSetFocus(dbeLimCre);
          End;
        End;
      End

      {*****************************************}
      {* VALIDA A CIDADE DE COBRANÇA           *}
      {**************************************MV*}
      Else If (Sender = dbeCidCob) Then
      Begin
        If Not fEmptyStr(dbeCidCob.Text) Then
        Begin
          pCarregaCidade(qryConCiC, edtCidCob, edtEstCob, dbeCidCob, dbeCepCob, strCepCobAnt);
          If qryConCiC.FieldByName('CID_CODCID').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
            Result := False;
          End;
        End
        Else If (Not fEmptyStr(dbeEndCob.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A cidade de cobrança deve ser preenchida, pois ' +
                                'o endereço de cobrança foi preenchido!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          dbeCidCob.Clear;
          edtEstCob.Clear;
        End;
      End

      Else If (Sender = dbeCapSoc) Then
      Begin
        If (Not fEmptyStr(dbeCapSoc.Text)) Then
        Begin
          If (fStrToFloat(dbeCapSoc.Text) < 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'O Capital Social deve ser maior ou igual Zero!', ['&Ok']);
            Result := False;
          End;
        End
        Else
        Begin
          dbeCapSoc.Field.AsFloat := 0.0;
        End;
      End

      {Valida CPF-CNPJ Sócios}
      Else If (Sender = edtOpcCnpjCpfSco) Then
      Begin
        If (fEmptyStr(edtOpcCnpjCpfSco.Text)) Or (edtOpcCnpjCpfSco.Text = '0') Then
        Begin
          edtOpcCnpjCpfSco.Clear;
          edtCnpjCpfSco.Clear;
        End
        Else If (edtOpcCnpjCpfSco.Text <> '1') And (edtOpcCnpjCpfSco.Text <> '2') Then
        Begin
          Result := False;
        End;
      End

      Else If (Sender = edtCnpjCpfSco) Then
      Begin
        If fEmptyStr(edtCnpjCpfSco.Text) Then
        Begin
          edtOpcCnpjCpfSco.Clear;
        End
        Else
        Begin
          Result := fValidaCnpjCpf(edtOpcCnpjCpfSco.Text, edtCnpjCpfSco.Text);

          If (Result) Then
            Result := (Not fExisteCnpjCpf('CLISCO',
                                          'SCO_CODCLI',
                                          dbeCodCli.Text,
                                          'SCO_CPFCNP',
                                          edtCnpjCpfSco.Text,
                                          '',
                                          IfThen(qryTabela.State in [dsInsert], VS_strCodEmp, qryTabela.FieldByName('CLI_CODEMP').AsString)));

        End;

      End

      {Valida Estado Civil Sócios}
      Else If (Sender = edtEstadoCivil) Then
      Begin
        Result := fValidaEstadoCivil(edtEstadoCivil.Text);
      End

      {*****************************************}
      {* VALIDA O CAMPO CNPJ / CPF             *}
      {**************************************MV*}
      Else If (Sender = edtCgcCpf) Then
      Begin
        If (fEmptyStr(edtCgcCpf.Text)) Or (edtCgcCpf.Text = '0') Then
        Begin
          edtCgcCpf.Clear;
          edtCgcCpf.Clear;
        End
        Else If (edtCgcCpf.Text <> '1') And (edtCgcCpf.Text <> '2') Then
        Begin
          Result := False;
        End
        Else
        Begin
          objCliRco.strCgcCpf := edtCgcCpf.Text;
        End;

      End

      {*****************************************}
      {* VALIDA O VALOR DO CNPJ / CPF          *}
      {**************************************MV*}
      Else If (Sender = edtCgcEmp) Then
      Begin
        If fEmptyStr(edtCgcEmp.Text) Then
        Begin
          edtCgcCpf.Clear;
        End
        Else
        Begin
          Result := fValidaCnpjCpf(edtCgcCpf.Text, edtCgcEmp.Text);

          If (Result) Then
            objCliRco.strCgcEmp := edtCgcEmp.Text;
        End;
      End

      {*****************************************}
      {* VALIDA TELEFONE DO BANCO 3, PARA IR  *}
      {* PARA A PRÓXIMA PAGINA                 *}
      {**************************************MV*}


      Else If (Sender = dbeTelBc3) Then
      Begin
        If blnBuscaPorChave Then
          pProximaPagina;
      End

      {*****************************************}
      {* VALIDA O SALARIO                      *}
      {**************************************MV*}
      Else If (Sender = dbeSalari) Then
      Begin
        If Not fEmptyStr(dbeSalari.Text) Then
        Begin
          If fStrToFloat(dbeSalari.Text) > MAX_VALMON Then
          Begin
            fMensagem('ATENÇÃO!', 'O Salário deve estar entre 0 e 999999,99!', ['&Ok']);
            Result := False;
          End;
        End;
      End

      {*****************************************}
      {* VALIDA CAMPO OUTRAS RENDAS            *}
      {**************************************MV*}
      Else If (Sender = dbeOutRen) Then
      Begin
        If Not fEmptyStr(dbeOutRen.Text) Then
        Begin
          If fStrToFloat(dbeOutRen.Text) > MAX_VALMON Then
          Begin
            fMensagem('ATENÇÃO!', 'O campo Outras Rendas deve estar entre 0 e 999999,99!', ['&Ok']);
            Result := False;
          End;
        End;
      End

      {*****************************************}
      {* VALIDA VALOR DO ALUGUEL               *}
      {**************************************MV*}
      Else If (Sender = dbeVrAlug) Then
      Begin
        If Not fEmptyStr(dbeVrAlug.Text) Then
        Begin
          If fStrToFloat(dbeVrAlug.Text) > MAX_VALMON Then
          Begin
            fMensagem('ATENÇÃO!', 'O Valor do Aluguel deve estar entre 0 e 999999,99!', ['&Ok']);
            Result := False;
          End;
        End;
      End

      {*****************************************}
      {* VALIDA A CONDICAO DE PAGAMENTO        *}
      {**************************************MA*}
      Else If (Sender = mskConPag) Then
      Begin

        If pnlConPag.Visible And blnBuscaPorChave Then
        Begin

          If Not fEmptyStr(fTiraCaracEspeciais(mskConPag.Text)) Then
          Begin

            strCndTmp := LeftStr(mskConPag.Text, 2);

            If (Pos(' ', strCndTmp) > 0) Or (Not fValidaCndPag(mskConPag.Text)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&Ok']);
              Result := False;
            End

            Else
            Begin
              blnMudarFoco := False;
              pIncluiCondicaoPagamento;
            End;

          End Else
          Begin

            blnMudarFoco := False;
            pSetFocus(cxgConPag);

          End;

        End;
      End

      {*****************************************}
      {* VALIDA O CODIGO DA COND.DE PAGAMENTO  *}
      {**************************************MA*}
      Else If (Sender = edtCodCnd) Then
      Begin

        If pnlCodCnd.Visible And blnBuscaPorChave Then
        Begin

          If fEmptyStr(edtCodCnd.Text) Then
          Begin
            edtCodCnd.clear;
            edtDesCnd.Clear;
            Result := True;
            blnMudarFoco := False;
            pSetFocus(cxgConPag);
          End
          Else
          Begin

            If (edtCodCnd.Text <> '000') Then
              edtDesCnd.Text := fRetDesConPag(edtCodCnd.Text);

            If fEmptyStr(edtDesCnd.Text) Then
            Begin
              fMensagem('ATENÇÃO!', 'Essa condição não está cadastrada!', ['&Ok']);
              Result := False;
            End;

          End;

        End;
      End

      {*****************************************}
      {* VALIDA O CODIGO DO DEPART PRODUTO     *}
      {*****************************************}
      Else If (Sender = edtCodDep) And (tbsDepartamentoCliente.Visible) Then
      Begin
        If fEmptyStr(edtCodDep.Text) Then
        Begin
          edtCodDep.clear;
          edtDesDep.Clear;
          Result := True;
          blnMudarFoco := False;
          pSetFocus(cxgCliDep);
        End
        Else
        Begin
          If (edtCodDep.Text <> '000') Then
            edtDesDep.Text := fRetDescDepartamento(edtCodDep.Text);

          If fEmptyStr(edtDesDep.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Departamento não cadastrado!', ['&Ok']);
            Result := False;
          End;

        End;
      End

      Else If (Sender = lstDiaFix) Then
      Begin
        blnMudarFoco := False;
        pSetFocus(btnGravar);
      End

      {***********************************}
      { VALIDA CONTATO                    }
      {********************************JB*}
      Else If (Sender = chkAutCtt) And (blnBuscaPorChave) And pnlAutCtt.Visible Then
      Begin
        objCliCtt.blnAutCtt := chkAutCtt.Checked;
      End
      Else If (Sender = mskCpfCtt) And (blnBuscaPorChave) And pnlAutCtt.Visible Then
      Begin
        objCliCtt.strCpfCtt := mskCpfCtt.Text;
      End
      Else If (Sender = edtRg_Ctt) And (blnBuscaPorChave) And pnlAutCtt.Visible Then
      Begin
        objCliCtt.strRg_Ctt := edtRg_Ctt.Text;
      End
      Else If (Sender = edtNomCtt) And (blnBuscaPorChave) Then
      Begin
        If Not fEmptyStr(edtNomCtt.Text) Then
          objCliCtt.strNomCtt := edtNomCtt.Text
        Else If Not pnlAutCtt.Visible Then
          pProximaPagina;
      End

      Else If (Sender = edtEndCtt) And (blnBuscaPorChave) Then
      Begin
        objCliCtt.strEndCtt := edtEndCtt.Text;
      End

      Else If (Sender = edtBaiCtt) And (blnBuscaPorChave) Then
      Begin
        objCliCtt.strBaiCtt := edtBaiCtt.Text;
      End

      Else If (Sender = edtCidCtt) And (blnBuscaPorChave) Then
      Begin
        objCliCtt.strCidCtt := edtCidCtt.Text;
        edtDesCidCtt.Text := objCliCtt.strNomCid;
        edtEstadoCtt.Text := objCliCtt.strEstado;
      End

      Else If ((Sender = mskTelCtt) Or (Sender = mskCelCtt) Or
               (Sender = mskFaxCtt) Or (Sender = edtTelEmp)) And
              (blnBuscaPorChave) Then
      Begin

        If (Not fEmptyStr(TMaskEditTelefone(Sender).Text)) And
           (Not fValidaTelefone(TMaskEditTelefone(Sender).Text)) Then
        Begin
          fMensagem('','Informe o telefone corretamente!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          TMaskEditTelefone(Sender).Text := fAcertaMaskTel(TMaskEditTelefone(Sender).Text);

          If (Sender = mskTelCtt) Then
            objCliCtt.strTelCtt := mskTelCtt.Text
          Else If (Sender = mskCelCtt) Then
            objCliCtt.strCelCtt := mskCelCtt.Text
          Else If (Sender = mskFaxCtt) Then
            objCliCtt.strFaxCtt := mskFaxCtt.Text
          Else If (Sender = edtTelEmp) Then
            objCliRco.strTelEmp := edtTelEmp.Text;
        End;

      End

      Else If (Sender = edtRamFon) And (blnBuscaPorChave) Then
      Begin
        objCliCtt.strRamFon := edtRamFon.Text;
      End

      Else If (Sender = edtRamFax) And (blnBuscaPorChave) Then
      Begin
        objCliCtt.strRamFax := edtRamFax.Text;
      End

      Else If (Sender = edtDepCtt) And (blnBuscaPorChave) Then
      Begin
        objCliCtt.strDepCtt := edtDepCtt.Text;
      End

      Else If (Sender = edtEmaCtt) And (blnBuscaPorChave) Then
      Begin
        objCliCtt.strEmaCtt := edtEmaCtt.Text;
      End

      Else If (Sender = edtCgoCtt) And (blnBuscaPorChave) Then
      Begin
        objCliCtt.strCgoCtt := edtCgoCtt.Text;
        edtDesCgoCtt.Text := objCliCtt.strNomCgo;
      End

      Else If (Sender = edtDptCtt) And (blnBuscaPorChave) Then
      Begin
        objCliCtt.strDptCtt := edtDptCtt.Text;
        edtDesDptCtt.Text := objCliCtt.strNomDpt;
      End

      Else If (Sender = edtTfuCtt) And (blnBuscaPorChave) Then
      Begin
        objCliCtt.strTfuCtt := edtTfuCtt.Text;
        edtDesTfuCtt.Text := objCliCtt.strNomTfu;
      End

      Else If (Sender = edtHobCtt) And (blnBuscaPorChave) Then
      Begin
        objCliCtt.strHobCtt := edtHobCtt.Text;
        edtDesHobCtt.Text := objCliCtt.strNomHob;
      End

      Else If (Sender = edtEscCtt) And (blnBuscaPorChave) Then
      Begin
        objCliCtt.strEscCtt := edtEscCtt.Text;
        edtDesEscCtt.Text := objCliCtt.strNomEsc;
      End

      Else If (Sender = edtGmuCtt) And (blnBuscaPorChave) Then
      Begin
        objCliCtt.strGmuCtt := edtGmuCtt.Text;
        edtDesGmuCtt.Text := objCliCtt.strNomGmu;
      End

      Else If (Sender = edtEciCtt) And (blnBuscaPorChave) Then
      Begin
        objCliCtt.strEciCtt := edtEciCtt.Text;
        edtDesEciCtt.Text := objCliCtt.strNomEci;
      End

      Else If (Sender = mmCerCtt) And (blnBuscaPorChave) Then
      Begin
        objCliCtt.strCerCtt := mmCerCtt.Text;
      End

      Else If (Sender = edtObsCtt) And (blnBuscaPorChave) Then
      Begin
        objCliCtt.strObsCtt := edtObsCtt.Text;
      End

      Else If (Sender = edtNasCtt) And (blnBuscaPorChave) Then
      Begin
        if (edtNasCtt.Text <> '  /  /    ') then
          objCliCtt.dtNasCtt := StrToDateTime(edtNasCtt.Text);
      End

      Else If (Sender = edtTemEmp) And (blnBuscaPorChave) Then
      Begin
        objCliCtt.strTemEmp := edtTemEmp.Text;
      End

      Else If (Sender = edtTemSeg) And (blnBuscaPorChave) Then
      Begin
        objCliCtt.strTemSeg := edtTemSeg.Text;
      End

      Else If (Sender = edtQtdFil) And (blnBuscaPorChave) Then
      Begin
        if (edtQtdFil.Text > '0') then
          objCliCtt.intQtdFil := StrToInt(edtQtdFil.Text);
      End

      {***********************************}
      { VALIDA REFERENCIAS COMERCIAIS     }
      {********************************AC*}
      Else If (Sender = edtEmpRco) And (blnBuscaPorChave) Then
      Begin
        If Not fEmptyStr(edtEmpRco.Text) Then
          objCliRco.strNomEmp:= edtEmpRco.Text
        Else
          pProximaPagina;
      End

      Else If (Sender = edtNomInf) And (blnBuscaPorChave) Then
      Begin
        objCliRco.strNomInf := edtNomInf.Text;
      End

      Else If (Sender = mmConEmp) And (blnBuscaPorChave) Then
      Begin
        objCliRco.strConEmp := mmConEmp.Text;
      End

      Else If (Sender = edtEmaEmp) And (blnBuscaPorChave) Then
      Begin
        objCliRco.strEmaEmp := edtEmaEmp.Text;
      End

      Else If (Sender = edtCodOpe) And (blnBuscaPorChave) Then
      Begin
        objCliRco.strCodOpe := edtCodOpe.Text;
        edtDesCodOpe.Text := objCliRco.strDesOpe;
      End

      Else If (Sender = edtDtaCon) And (blnBuscaPorChave) Then
      Begin
        if (edtDtaCon.Text <> '  /  /    ') then
          objCliRco.strDtaCon := StrToDateTime(edtDtaCon.Text);
      End

      Else If (Sender = edtPriCom) And (blnBuscaPorChave) Then
      Begin
        if (edtPriCom.Text <> '  /  /    ') then
          objCliRco.strDtaPco := StrToDateTime(edtPriCom.Text);
      End

      Else If (Sender = edtVPrCom) And (blnBuscaPorChave) Then
      Begin
        objCliRco.strValPco := fStrToFloat(AnsiReplaceStr(edtVPrCom.Text,'.',''));
      End

      Else If (Sender = edtMaiCom) And (blnBuscaPorChave) Then
      Begin
        if (edtMaiCom.Text <> '  /  /    ') then
          objCliRco.strDtaMco := StrToDateTime(edtMaiCom.Text);
      End

      Else If (Sender = edtVMaCom) And (blnBuscaPorChave) Then
      Begin
        objCliRco.strValMco := fStrToFloat(AnsiReplaceStr(edtVMaCom.Text,'.',''));
      End

      Else If (Sender = edtUltCom) And (blnBuscaPorChave) Then
      Begin
        if (edtUltCom.Text <> '  /  /    ') then
          objCliRco.strDtaUco := StrToDateTime(edtUltCom.Text);
      End

      Else If (Sender = edtVUlCom) And (blnBuscaPorChave) Then
      Begin
        objCliRco.strValUco := fStrToFloat(AnsiReplaceStr(edtVUlCom.Text,'.',''));
      End

      {*****************************************}
      {* VALIDA O CODIGO DA CONDICAO DA FORMA  *}
      {* DE PAGAMENTO                          *}
      {**************************************MA*}
      Else If (Sender = dbeCodFpg) And (pnlForPag.Visible) Then
      Begin

        If fEmptyStr(dbeCodFpg.Text) Then
        Begin
          edtDesFpg.Text := '';
          Result := True;
        End
        Else
        Begin
          pCarregaFormaPag;
          If fEmptyStr(edtDesFpg.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa forma não está cadastrada!', ['&Ok']);
            Result := False;
          End

          Else If (((qryTabela.State = dsEdit  ) And (strCodFpgAnt <> dbeCodFpg.Text))  Or
                   ((qryTabela.State = dsInsert) And (EmptyStr     <> dbeCodFpg.Text))) And
                    (Not fEmptyStr(fCfgSis('SENTFP')) And (Not blnJahLiberouFormaPagto)) Then
          Begin

            objLiberacao.Clear;
            objLiberacao.strDirAce    := 'ALTFPG';
            objLiberacao.strSenLib    := fCfgSis('SENTFP');
            objLiberacao.strMsgSen    := 'Forma de Pagamento';
            objLiberacao.strCodOpe    := strLoginUsuarioLogado;
            objLiberacao.strCodDig    := strLoginUsuarioLogado;
            objLiberacao.strCliente   := (dbeCodCli.Text + '-' + dbeNomCli.Text);
            objLiberacao.strCpfCnpj   := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
            objLiberacao.objMsgLibera.pAddTexto('Troca de forma de pagamento no Cadastro de Cliente.');
            objLiberacao.objMsgLibera.pAddTextoCaption('Forma de Pagamento Anterior', strCodFpgAnt   + '-' + fRetDescFpg(strCodFpgAnt)  , 27);
            objLiberacao.objMsgLibera.pAddTextoCaption('Forma de Pagamento Atual'   , dbeCodFpg.Text + '-' + fRetDescFpg(dbeCodFpg.Text), 27);

            If objLiberacao.fLibera Then
            Begin
              if Assigned(LogAltCadCli) then
                LogAltCadCli.LogVar.AddOrSetValue(TDBEditFocus(Sender).DataField, objLiberacao.strOperador);

              strCodFpgAnt := dbeCodFpg.Text;
              pSetFocus(dbeCodFpg);
              blnMudarFoco := True;
              blnJahLiberouFormaPagto := True;
            End
            Else
            Begin
              dbeCodFpg.Field.AsString := strCodFpgAnt;
              Result := False;
              blnMudarFoco := False;
              pSetFocus(dbeCodFpg);
              blnJahLiberouFormaPagto := False;
            End;

          End;

        End;

      End

      Else If (Sender = dbeTipCli) And (pnlTipCli.Visible) Then
      Begin

        If (fEmptyStr(dbeTipCli.Text)) Then
        Begin
          If (Not fCfgSis('TPCBRC', varBoolean)) Then
          Begin
            fMensagem('ATENÇÃO!', 'O tipo de cliente deve ser preenchido!', ['&Ok']);
            Result := False;
          End
          Else
            edtDesTpc.Clear;
        End
        Else
        Begin
          edtDesTpc.Text := fRetDescricaoTipoCli(dbeTipCli.Text);
          If (fEmptyStr(edtDesTpc.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse tipo de cliente não está cadastrado!', ['&Ok']);
            Result := False;
          End

          Else If (((qryTabela.State = dsEdit  ) And (strTipCliAnt <> dbeTipCli.Text))  Or
                   ((qryTabela.State = dsInsert) And (strTipCliAnt <> dbeTipCli.Text))) And
                  (Not fEmptyStr( fCfgSis('SENTCL') ) )                                 Then
          Begin

            objLiberacao.Clear;
            objLiberacao.strDirAce    := 'ALTTPC';
            objLiberacao.strSenLib    := fCfgSis('SENTCL');
            objLiberacao.strMsgSen    := 'Tipo de Cliente';
            objLiberacao.strCodOpe    := strLoginUsuarioLogado;
            objLiberacao.strCodDig    := strLoginUsuarioLogado;
            objLiberacao.strCliente   := (dbeCodCli.Text + '-' + dbeNomCli.Text);
            objLiberacao.strCpfCnpj   := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
            objLiberacao.objMsgLibera.pAddTexto('Troca de tipo de cliente no Cadastro de Cliente.');
            objLiberacao.objMsgLibera.pAddTextoCaption('Tipo de Cliente Anterior', strTipCliAnt   + '-' + fRetDescricaoTipoCli(strTipCliAnt)  , 24);
            objLiberacao.objMsgLibera.pAddTextoCaption('Tipo de Cliente Atual'   , dbeTipCli.Text + '-' + fRetDescricaoTipoCli(dbeTipCli.Text), 24);

            If objLiberacao.fLibera Then
            Begin
              if Assigned(LogAltCadCli) then
                LogAltCadCli.LogVar.AddOrSetValue(TDBEditFocus(Sender).DataField, objLiberacao.strOperador);

              strTipCliAnt := dbeTipCli.Text;
              pSetFocus(dbeTipCli);
              blnMudarFoco := True;
              strOpeAlt[3] :=  objLiberacao.strOperador;
            End
            Else
            Begin
              dbeTipCli.Field.AsString := strTipCliAnt;
              Result := False;
              blnMudarFoco := False;
              pSetFocus(dbeTipCli);
            End;

          End;

        End;

      End

      Else If (Sender = dbeCodPor) Then
      Begin

        If (fEmptyStr(dbeCodPor.Text)) Then
        Begin
          If (Not blnLibPor) And (Not fEmptyStr(fCfgSis('SENPOR')))Then
          Begin
            objLiberacao.Clear;
            objLiberacao.strDirAce    := 'CLIPOR';
            objLiberacao.strSenLib    := fCfgSis('SENPOR');
            objLiberacao.strMsgSen    := 'Portador (1) em branco';
            objLiberacao.strCodOpe    := strLoginUsuarioLogado;
            objLiberacao.strCodDig    := strLoginUsuarioLogado;
            objLiberacao.strCliente   := (dbeCodCli.Text + '-' + dbeNomCli.Text);
            objLiberacao.strCpfCnpj   := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
            objLiberacao.objMsgLibera.pAddTexto('Portador (1) em branco.');

            blnLibPor := objLiberacao.fLibera;
            If blnLibPor Then
            Begin
              if Assigned(LogAltCadCli) then
                LogAltCadCli.LogVar.AddOrSetValue(TDBEditFocus(Sender).DataField, objLiberacao.strOperador);

              strCodPorAnt1 := dbeCodPor.Text;
              blnMudarFoco := True;
              edtDesPor.Clear;
            End
            Else
            Begin
              dbeCodPor.Field.AsString := strCodPorAnt1;
              blnMudarFoco := False;
              pSetFocus(dbeCodPor);
            End;
          End
          else
            edtDesPor.Clear;
        End
        Else
        Begin
          pCarregaPortador(1);
          If (qryConPor.FieldByName('POR_CODPOR').IsNull) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!', ['&Ok']);
            Result := False;
          End

          {*REQ*145940**********RP*}
          Else If Not fEmpresaTemAcessoPortador(dbeCodPor.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End

          Else If (((qryTabela.State = dsEdit  ) And (strCodPorAnt1 <> dbeCodPor.Text))  Or
                   ((qryTabela.State = dsInsert) And (EmptyStr     <> dbeCodPor.Text))) And
                  (Not fEmptyStr(fCfgSis('SENTPO'))) And (Not blnJahLiberouPortador) Then
          Begin

            objLiberacao.Clear;
            objLiberacao.strDirAce    := 'ALTPOR';
            objLiberacao.strSenLib    := fCfgSis('SENTPO');
            objLiberacao.strMsgSen    := 'Portador';
            objLiberacao.strCodOpe    := strLoginUsuarioLogado;
            objLiberacao.strCodDig    := strLoginUsuarioLogado;
            objLiberacao.strCliente   := (dbeCodCli.Text + '-' + dbeNomCli.Text);
            objLiberacao.strCpfCnpj   := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
            objLiberacao.objMsgLibera.pAddTexto('Troca de portador 1 no Cadastro de Cliente.');
            objLiberacao.objMsgLibera.pAddTextoCaption('Portador 1 Anterior', strCodPorAnt1  + '-' + fRetNomPortador(strCodPorAnt1) , 19);
            objLiberacao.objMsgLibera.pAddTextoCaption('Portador 1 Atual'   , dbeCodPor.Text + '-' + fRetNomPortador(dbeCodPor.Text), 19);

            If objLiberacao.fLibera Then
            Begin
              if Assigned(LogAltCadCli) then
                LogAltCadCli.LogVar.AddOrSetValue(TDBEditFocus(Sender).DataField, objLiberacao.strOperador);

              strCodPorAnt1 := dbeCodPor.Text;
              pSetFocus(dbeCodPor);
              blnMudarFoco := True;
              blnJahLiberouPortador := True;
            End
            Else
            Begin
              dbeCodPor.Field.AsString := strCodPorAnt1;
              Result := False;
              blnMudarFoco := False;
              pSetFocus(dbeCodPor);
              blnJahLiberouPortador := False;
            End;

          End

        End;

      End

      Else If (Sender = dbeCodPor2) Then
      Begin
        Result := fValidaPortadores;
        If Result Then
        Begin
          If (fEmptyStr(dbeCodPor2.Text)) Then
          Begin
            If (Not blnLibPo2) And (Not fEmptyStr(fCfgSis('SENPO2')))Then
            Begin
              objLiberacao.Clear;
              objLiberacao.strDirAce    := 'CLIPO2';
              objLiberacao.strSenLib    := fCfgSis('SENPO2');
              objLiberacao.strMsgSen    := 'Portador (2) em branco';
              objLiberacao.strCodOpe    := strLoginUsuarioLogado;
              objLiberacao.strCodDig    := strLoginUsuarioLogado;
              objLiberacao.strCliente   := (dbeCodCli.Text + '-' + dbeNomCli.Text);
              objLiberacao.strCpfCnpj   := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
              objLiberacao.objMsgLibera.pAddTexto('Portador (2) em branco.');

              blnLibPo2 := objLiberacao.fLibera;
              If blnLibPo2 Then
              Begin
                if Assigned(LogAltCadCli) then
                  LogAltCadCli.LogVar.AddOrSetValue(TDBEditFocus(Sender).DataField, objLiberacao.strOperador);

                strCodPorAnt2 := dbeCodPor2.Text;
                blnMudarFoco := True;
                edtDesPor2.Clear;
                If blnBuscaPorChave Then
                  pProximaPagina;
              End
              Else
              Begin
                dbeCodPor2.Field.AsString := strCodPorAnt2;
                blnMudarFoco := False;
                pSetFocus(dbeCodPor2);
              End;
            End
            else
            begin
              edtDesPor2.Clear;
              If blnBuscaPorChave Then
                pProximaPagina;
            end;
          End
          Else
          Begin
            pCarregaPortador(2);
            If (qryConPor.FieldByName('POR_CODPOR').IsNull) Then
            Begin
              fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!', ['&Ok']);
              Result := False;
            End

            {*REQ*145940**********RP*}
            Else If Not fEmpresaTemAcessoPortador(dbeCodPor2.Text) Then
            Begin
              fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
              Result := False;
            End

            Else If (((qryTabela.State = dsEdit  ) And (strCodPorAnt2 <> dbeCodPor2.Text))  Or
                     ((qryTabela.State = dsInsert) And (EmptyStr      <> dbeCodPor2.Text))) And
                    (Not fEmptyStr( fCfgSis('SENTPO') ) ) And (Not blnJahLiberouPortador2)  Then
            Begin

              objLiberacao.Clear;
              objLiberacao.strDirAce    := 'ALTPOR';
              objLiberacao.strSenLib    := fCfgSis('SENTPO');
              objLiberacao.strMsgSen    := 'Portador';
              objLiberacao.strCodOpe    := strLoginUsuarioLogado;
              objLiberacao.strCodDig    := strLoginUsuarioLogado;
              objLiberacao.strCliente   := (dbeCodCli.Text + '-' + dbeNomCli.Text);
              objLiberacao.strCpfCnpj   := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
              objLiberacao.objMsgLibera.pAddTexto('Troca de portador 2 no Cadastro de Cliente.');
              objLiberacao.objMsgLibera.pAddTextoCaption('Portador 2 Anterior', strCodPorAnt2   + '-' + fRetNomPortador(strCodPorAnt2)  , 19);
              objLiberacao.objMsgLibera.pAddTextoCaption('Portador 2 Atual'   , dbeCodPor2.Text + '-' + fRetNomPortador(dbeCodPor2.Text), 19);

              If objLiberacao.fLibera Then
              Begin
                if Assigned(LogAltCadCli) then
                  LogAltCadCli.LogVar.AddOrSetValue(TDBEditFocus(Sender).DataField, objLiberacao.strOperador);

                strCodPorAnt2 := dbeCodPor2.Text;
                pSetFocus(dbeCodPor2);
                blnMudarFoco := True;
                blnJahLiberouPortador2 := True;
              End
              Else
              Begin
                dbeCodPor2.Field.AsString := strCodPorAnt2;
                Result := False;
                blnMudarFoco := False;
                pSetFocus(dbeCodPor2);
                blnJahLiberouPortador2 := False;
              End;

              If blnBuscaPorChave Then
                pProximaPagina;
            End

            Else If blnBuscaPorChave Then
            Begin
              pProximaPagina;
            End;
          End;

        End;

      End

      Else If (Sender = dbeRetPCo) And (dbeRetPCo.Enabled) Then
      Begin
        If (Pos(dbeRetPco.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Retém Pis e Cofins" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeOrPuRD) And (dbeOrPuRD.Enabled) Then
      Begin
        If (Pos(dbeOrPuRD.Text, 'RD') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Tipo de Desconto" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeCalIcm) And (dbeCalIcm.Enabled) Then
      Begin
        If (Pos(dbeCalIcm.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Calcula Desconto Icms" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (sender = dbeDesPis) And (dbeDesPis.Enabled) Then
      Begin
        dbeDesPis.Enabled := ((dbeZonFra.Text = 'S') And (dbeConsum.Text = 'N')) Or
                             (dbeOrgPub.Text = 'S');

        If fEmptyStr(dbeDesPis.Text) And (dbeDesPis.Enabled) Then
        Begin
          fMensagem('ATENÇÃO!', 'Defina o campo "Aplicar desconto de PIS/COFINS?"', ['&Ok']);
          Result := False;
        End
        Else If (Pos(dbeDesPis.Text, 'SN') <= 0) And (dbeDesPis.Enabled) Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo "Aplicar desconto de PIS/COFINS?" de ser S ou N!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (sender = dbeCDesPI) And (dbeCDesPI.Enabled) Then
      Begin
        If (Pos(dbeCDesPI.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Calcula desconto de PIS/COFINS/IRPJ/CSLL" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (sender = dbeIseIpi) And (dbeIseIpi.Enabled) Then
      Begin
        If (Pos(dbeIseIpi.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Isenção de IPI?" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (sender = dbeDiferi) And (dbeDiferi.Enabled) Then
      Begin
        If (Pos(dbeDiferi.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Utilizar diferimento de ICMS?" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (sender = dbeDif_ST) And (dbeDif_ST.Visible And dbeDif_ST.Enabled) Then
      Begin
        If (Pos(dbeDif_ST.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Utilizar diferimento de ST?" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (sender = dbeDif_PC) And (dbeDif_PC.Visible And dbeDif_PC.Enabled) Then
      Begin
        If (Pos(dbeDif_PC.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Utilizar diferimento PIS/COFINS?" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeAlqIss) And (dbeAlqIss.Enabled) Then
      Begin

        If (fEmptyStr(dbeAlqIss.Text)) Then
          dbeAlqIss.Field.AsFloat := 0.0;

        If (fStrToFloat(dbeAlqIss.Text) < 0.0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A alíquota de ISS deve ser maior ou igual a Zero!', ['&Ok']);
          Result := False;
        End;

        dbeRedIss.Enabled := (fStrToFloat(dbeAlqIss.Text) > 0.0);

        If Not dbeRedIss.Enabled Then
          dbeRedIss.Field.AsFloat := 0.0;
      End

      Else If (Sender = dbeRedIss) And (dbeRedIss.Enabled) And (dbeRedIss.Visible) Then
      Begin

        If (fEmptyStr(dbeRedIss.Text)) Then
          dbeRedIss.Field.AsFloat := 0.0;

        If (fStrToFloat(dbeRedIss.Text) < 0.0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O percentual de Redução da Base de ISS deve ser maior ou igual a Zero!', ['&Ok']);
          Result := False;
        End
        Else If (fStrToFloat(dbeRedIss.Text) > 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O percentual de Redução da Base de ISS não deve ser maior que 100!', ['&Ok']);
          Result := False;
        End;

      End

      Else If (Sender = dbeDescon) And (dbeDescon.Enabled) And (dbeDescon.Visible) Then
      Begin

        If (fEmptyStr(dbeDescon.Text)) Then
          dbeDescon.Field.AsFloat := 0.0;

        If (fStrToFloat(dbeDescon.Text) < 0.0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Desconto deve ser maior ou igual a Zero!', ['&Ok']);
          Result := False;
        End;

      End

      Else If (Sender = dbeDesOpe) And (dbeDesOpe.Visible) Then
      Begin

        If (fEmptyStr(dbeDesOpe.Text)) Then
          dbeDesOpe.Field.AsFloat := 0.0;

        If (fStrToFloat(dbeDesOpe.Text) < 0.0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo "Despesas Operacionais Complementar" deve ser maior ou igual a Zero!', ['&Ok']);
          Result := False;
        End;

      End

      Else If (Sender = dbePerCom) And (pnlPerCom.Visible) Then
      Begin

        If (fEmptyStr(dbePerCom.Text)) Then
          dbePerCom.Field.AsFloat := 0.0;

        If (fStrToFloat(dbePerCom.Text) < 0.0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O percentual de comissão do cliente deve ser maior ou igual à Zero!', ['&Ok']);
          Result := False;
        End;

      End

      Else If (Sender = dbeComPro) And (pnlComPro.Visible) Then
      Begin

        If (fEmptyStr(dbeComPro.Text)) Then
          dbeComPro.Field.AsFloat := 0.0;

        If (fStrToFloat(dbeComPro.Text) < 0.0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O percentual de comissão do profissional indicado na venda deve ser maior ou igual à Zero!', ['&Ok']);
          Result := False;
        End;

      End

      Else If (Sender = dbeAtrMax) Then
      Begin

        If (fEmptyStr(dbeAtrMax.Text)) Then
          dbeAtrMax.Field.AsFloat := 0.0;

        If (fStrToFloat(dbeAtrMax.Text) < 0.0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O numero de dias para atraso máximo deve ser maior ou igual a Zero!', ['&Ok']);
          Result := False;
        End;

      End

      Else If (Sender = dbeSegSoc) And (dbeSegSoc.Enabled) Then
      Begin
        If (Pos(dbeSegSoc.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Seguridade Social" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeExpInd) Then
      Begin
        If (Pos(dbeExpInd.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Exportação Indireta" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (sender = dbeRetIrf) And (dbeRetIrf.Enabled) Then
      Begin
        If (Pos(dbeRetIrf.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Retém IRPJ" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (sender = dbeRetIss) And (dbeRetIss.Enabled) Then
      Begin
        If (Pos(dbeRetIss.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Retém ISS" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (sender = dbeBenRei) And (dbeBenRei.Enabled) Then
      Begin
        If (Pos(dbeBenRei.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Benefício REIDI?" corretamente!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If (dbeBenRei.Text = 'S') Then
          Begin
            dbeNatRec.ReadOnly := False;
          End
          Else
          Begin
            dbeNatRec.ReadOnly := True;
            If (qryTabela.State In [dsInsert, dsEdit]) Then
              dbeNatRec.Field.AsString := '';
        End;
        End;
      End

      Else If (sender = dbeNatRec) Then
      Begin
        dbeNatRec.ReadOnly := Not (dbeBenRei.Text = 'S');
        If (dbeBenRei.Text = 'S') And (fEmptyStr(dbeNatRec.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Natureza de Receita PIS/COFINS" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (sender = dbeIcmRei) And (dbeIcmRei.Enabled) Then
      Begin
        If (Pos(dbeIcmRei.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Deduzir ICMS do Benefício REIDI?" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (sender = dbeNotDes) And (dbeNotDes.Enabled) Then
      Begin
        If (Pos(dbeNotDes.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Cliente enquadrado no art. 7º do Anexo XVIII da Parte II da Resolução SEFAZ nº 720/14, incluído pela Resolução SEFAZ nº 13/19 ?" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (sender = dbePermFF) And (pnlPeMIFF.Visible) Then
      Begin
        If (Pos(dbePermFF.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Permitir FF (A Prazo)" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (sender = dbePermFV) And (pnlPeMIFF.Visible) Then
      Begin
        If (Pos(dbePermFV.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Permitir FF (À Vista)" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (sender = dbeRevist) Then
      Begin
        If (Pos(dbeRevist.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Revista" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeCluFid) Then
      Begin
        Result := (Pos(dbeCluFid.Text, 'SN') > 0);
        If (Result) Then
        Begin
          If (dbeCluFid.Text = 'N') Then
          Begin
            blnPreencherClubeFidelidadeComProprioCliente := False;
            dbeDtaFid.Enabled     := False;
            dbeDtaFid.Field.Value := Null;
            pnlCliCluFid.Enabled  := False;
            dbeCliFid.Field.Value := Null;
            edtCliFid.Clear;
          End
          Else
          Begin
            pnlCliCluFid.Enabled := blnAQCLUFI;
            dbeDtaFid.Enabled     := True;
            If dbeDtaFid.Field.Value = Null Then
              dbeDtaFid.Field.Value := VS_Date;
          End;
        End;
      End

      Else If (Sender = dbePerAgu) Then
      Begin
        If (Pos(dbePerAgu.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Permitir Entrega Futura com Status Aguardando o Cliente?" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbePerPre) Then
      Begin
        If (Pos(dbePerPre.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Permitir Entrega Futura com Status Previsão de Entrega?" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbePerFal) And blnBuscaPorChave Then
      Begin
        If (Pos(dbePerFal.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Permitir Entrega Futura com Status Falta de Produto?" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeAgruparDocAppTaEntregue) Then
      Begin
        If (fCfgSis('MATDIS', varBoolean)) And (Pos(dbeAgruparDocAppTaEntregue.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Agrupar documentos no App Tá Entregue?" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeImpLau) Then
      Begin
        If (Pos(dbeImpLau.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Cliente necessita de impressão de laudo?" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeEtiDes) Then
      Begin
        If (Pos(dbeEtiDes.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Cliente necessita de etiqueta de despacho?" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeObrPDC) And (dbeObrPDC.Enabled) Then
      Begin
        If fEmptyStr(dbeObrPDC.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "Tornar obrigatório o operador digitar o Pedido de Compra dos itens no faturamento?" deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else If Pos(dbeObrPDC.Text,'SN') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "Tornar obrigatório o operador digitar o Pedido de Compra dos itens no faturamento?", ' +
                                'deve ser "S" ou "N"!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeLeiLGP) And (dbeLeiLGP.Enabled) Then
      Begin
        If fEmptyStr(dbeLeiLGP.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "Liberação para a Lei LGPD?" deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else If Pos(dbeLeiLGP.Text,'SN') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "Liberação para a Lei LGPD?", ' +
                                'deve ser "S" ou "N"!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeTerAce) And (dbeTerAce.Enabled) Then
      Begin
        If fEmptyStr(dbeTerAce.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "Termo Aceito?" deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else If Pos(dbeTerAce.Text,'SN') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Campo "Termo Aceito?", ' +
                                'deve ser "S" ou "N"!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeCliFid) And (dbeCluFid.Text = 'S') Then
      Begin

        If (fEmptyStr(dbeCliFid.Text)) Then
        Begin
          edtCliFid.Clear;
          If (Not blnPreencherClubeFidelidadeComProprioCliente) Then
          Begin
            If (fCfgSis('CLFDPR') = 'S') And
               (pnlCliCluFid.Enabled) And
               fPergunta('Preencher o "Clube Fidelidade - Cliente para Creditar" com o próprio cliente?') Then
            Begin
              If qryTabela.State = dsInsert Then
                blnPreencherClubeFidelidadeComProprioCliente := True
              Else
              Begin
                qryTabela.FieldByName('CLI_CLIFID').AsString := dbeCodCli.Text;
                pCarregaCliFid;
              End;
            End
            Else
            Begin
              fMensagem('ATENÇÃO!', 'O Cliente Fidelidade deve ser preenchido!', ['&Ok']);
              Result := False;
            End;
          End;
        End
        Else
        Begin
          pCarregaCliFid;
          If (qryCliFid.IsEmpty) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&Ok']);
            Result := False;
          End;
        End;

        If (Not SameText(dbeCodCli.Text, dbeCliFid.Text)) And
           (Not SameText(strCliFidAnt , dbeCliFid.Text))  And
           (Not fVerificaAcessoSistema('PERMCLIDIFCLUBFIDEL', strLoginUsuarioLogado)) And
           (Not fEmptyStr(dbeCliFid.Text)) Then
        Begin
            objLiberacao.Clear;
            objLiberacao.strDirAce    := 'PERMCLIDIFCLUBFIDEL';
            objLiberacao.strCodOpe    := strLoginUsuarioLogado;
            objLiberacao.strCodDig    := strLoginUsuarioLogado;
            objLiberacao.objMsgLibera.pAddTexto('Está sendo informado um cliente diferente do cliente da venda, no cadastramento de Clube Fidelidade.');
            objLiberacao.objMsgLibera.pAddQuebra();
            objLiberacao.objMsgLibera.pAddTexto('Cliente para Venda');
            objLiberacao.objMsgLibera.pAddTextoCaption('Cliente:', dbeCodCli.Text + '-' + dbeNomCli.Text, 8);
            objLiberacao.objMsgLibera.pAddTextoCaption('Cidade:', dbeCodCid.Text + '-' + edtNomCid.Text, 8);
            objLiberacao.objMsgLibera.pAddTextoCaption('CNPJ/CPF:', fFormataCpfCgc(IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text), FPais), 8);

            objLiberacao.objMsgLibera.pAddQuebra();
            objLiberacao.objMsgLibera.pAddTexto('Cliente para Crédito do Clube Fidelidade:');
            objLiberacao.objMsgLibera.pAddTextoCaption('Cliente:', dbeCliFid.Text + '-' + edtCliFid.Text, 8);
            objLiberacao.objMsgLibera.pAddTextoCaption('Cidade:', fRetCidCliente(dbeCliFid.Text)+'-'+ fRetCidade(fRetCidCliente(dbeCliFid.Text)), 8);
            objLiberacao.objMsgLibera.pAddTextoCaption('CNPJ/CPF:', fFormataCpfCgc(fRetCgcCpf(dbeCliFid.Text), FPais), 8);

            If (Not objLiberacao.fLibera) then
              qryTabela.FieldByName('CLI_CLIFID').AsString := strCliFidAnt
            Else
              strCliFidAnt := dbeCliFid.Text;
        End
        Else
          strCliFidAnt := dbeCliFid.Text;

      End

      Else If (Sender = dbeCorres) And dbeCorres.Visible then
      Begin

        edtCorres.Text := fRetNomCliente(dbeCorres.Text);

        If (Not fEmptyStr(dbeCorres.Text)) Then
        Begin

          If fEmptyStr(edtCorres.Text) Then
          begin
            fMensagem('','Cliente não está cadastrado!', ['&Ok']);
            Result := False;
          end
          else If dbeCorres.Text = dbeCodCli.Text Then
          begin
            fMensagem('','Cliente correspondente não pode ser o próprio!', ['&Ok']);
            Result := False;
          end;

        End;

      End

      Else If (Sender = dbeAvalis) Then
      Begin
        If (fEmptyStr(dbeAvalis.Text)) Then
        Begin
          edtDesAvalis.Text := '';
        End
        Else
        Begin
          edtDesAvalis.Text := fRetNomCliente(dbeAvalis.Text);
          If fEmptyStr(edtDesAvalis.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Avalista não está cadastrado!', ['&Ok']);
            Result := False;
          End;
        End;
      End

      Else If (Sender = dbeNacion) Then
      Begin
        If (fEmptyStr(dbeNacion.Text)) Then
          edtDesNacion.Clear
        Else
        Begin
          edtDesNacion.Text := fRetNomePais(dbeNacion.Text);
          If fEmptyStr(edtDesNacion.Text) Then
            Result := fMensagem('', 'O código do país informado não é válido', ['OK']) = -1;
        End;
      End

      Else If (Sender = dbeNatura) Then
      Begin
        If (fEmptyStr(dbeNatura.Text)) Then
          edtDesNatura.Clear
        Else
        Begin
          edtDesNatura.Text := fRetNomCidadeSemOpc(dbeNatura.Text);
          If fEmptyStr(edtDesNatura.Text) Then
            Result := fMensagem('', 'O código da cidade informado não é válido', ['OK']) = -1;
        End;
      End

      Else If (Sender = dbeCodReg) Then
      Begin
        If Not fEmptyStr(dbeCodReg.Text) Then
        Begin
          pCarregaRegiao;
          If (fEmptyStr(edtDesReg.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Região não cadastrada!', ['&Ok']);
            Result := False;
          End;
        End
        Else If fCfgSis('REGCLO', VarBoolean) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Região do cliente deve ser informada!', ['&Ok']);
          Result := False;
        End
        Else
          edtDesReg.Text := EmptyStr;
      End

      Else If (Sender = dbeCodSub) Then
      Begin
        If Not fEmptyStr(dbeCodSub.Text) Then
        Begin
          pCarregaSubRegiao;
          If (fEmptyStr(edtDesSub.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Sub-Região não cadastrada!', ['&Ok']);
            Result := False;
          End;
        End
        Else If fCfgSis('SUBCLO', VarBoolean) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Sub-Região do cliente deve ser informada!', ['&Ok']);
          Result := False;
        End
        Else
          edtDesSub.Text := EmptyStr;
      End

      Else If (Sender = edtCodDiv) Then
      Begin
        If pnlCodDiv.Visible And blnBuscaPorChave Then
        Begin
          If Not fEmptyStr(edtCodDiv.Text) Then
          Begin
            pRetNomeProfissional;
            If (fEmptyStr(edtNomDiv.Text)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Profissional não cadastrado ou Inativo!', ['&Ok']);
              Result := False;
            End;
          End
          Else
            edtNomDiv.Text := EmptyStr;
        End;
      End

      Else If (Sender = cmbTipoPesquisa) Then
      Begin
        If fSelecionadoSCPC then
          pHabilitaConsultaSCPC;

         btnConsultaSerasaPowerCurve.Enabled := UtilizaConsultaSerasaPowerCurve;
         btnConsultaSerasaExperian.Enabled   := UtilizaConsultaSerasaExperian;
         cbProdutoSerasa.Enabled := (cmbTipoPesquisa.ItemIndex = 1);

        If blnBuscaPorChave and (not dbeDtaCon.Enabled) Then
          pProximaPagina;

      End Else If (Sender = dbeDtCoCb) Then
      Begin
        VerificarDiasRestantesConsultaCobranca;
      End
      Else If (Sender = dbeDtaCon) Then
      Begin
        If fSelecionadoSCPC And fEmptyStr(fTiraCaracEspeciais(dbeDtaCon.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe a Data da Consulta!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          VerificarDiasRestantesConsultaCredito;
        End;
      End

      Else If (Sender = dbeConCon) And (dbeConCon.Visible)  Then
      Begin
        If strConConAnt <> dbeConCon.Text Then
        Begin
          If Not fEmptyStr(fExisteConContabil) Then
          Begin
            If fMensagem('', 'Esta Conta Contábil está sendo utilizada por ( ' + fExisteConContabil +
                         ' ). Deseja continuar?', ['&Sim', '&Não']) = 2 Then
              Result := False;
          End;
        End;

        If Result Then
          strConConAnt := dbeConCon.Text;
      End

      Else If (Sender = dbePlaNco) And (dbePlaNco.Visible) Then
      Begin
        pCarregaPlanoContabil(blnBuscaPorChave);
        If (Not fEmptyStr(dbePlaNco.Text)) And (fEmptyStr(edtDesPlaNco.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Plano contábil inexistente!', ['&OK']);
          Result := False;
        End
        Else If (qryTabela.State In [dsInsert, dsEdit]) Then
        begin
          If fEmptyStr(edtDesPlaNco.Text) Then
            dbePlaNco.Field.Value := Null
          Else
            dbePlaNco.Field.AsString := fSemMascaraPlaNco(dbePlaNco.Text);
        end;
      End

      Else If (Sender = dbeCepCob) Then
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(dbeCepCob.Text))) Then
        Begin
          If Length(Trim(fTiraCaracEspeciais(dbeCepCob.Text))) < 8 Then
          Begin
            fMensagem('ATENÇÃO!', 'O Cep deve ser vazio ou com 8 digitos.', ['&Ok']);
            Result := False;
          End;
        End;

        If (Result) And (Not fEmptyStr(dbeCepCob.Text)) And (fCfgSis('USACEP', varBoolean)) And (edtEstCob.Text <> 'EX') Then
        Begin

          If (Not fCadCepDadosCep(dbeCepCob.Text, strCidCob, strEndCob, strBaiCob, strNomCidCob, strEstadoCob, LCodigoCorreio,
                                                  ''{qryConCiC.FieldByName('CID_ESTADO').AsString},
                                                  ''{qryConCiC.FieldByName('CID_CODCOR').AsString})) Then
          Begin
            Result := fMensagem('ATENÇÃO!', 'CEP não encontrado!' + #13 + 'Deseja continuar mesmo assim?', ['&Sim', '&Não'],2) = 1;
          End
          Else
          Begin

            If (fEmptyStr(strCidCob)) Then
            Begin

              If Not fVerificaAcessoSistema(strPermiCadCid) Then
              Begin
                fMensagem('ATENÇÃO!', fMensagemTravaAcessoCadCid(dbeCidCob.Text, edtCidCob.Text), ['&Ok']);

                Result := False;

              End

              Else

              If Not fEmptyStr(fRetNomCidade(dbeCidCob.Text)) Then
              Begin

                If fMensagem('ATENÇÃO!', 'O Código Correios da cidade ' + edtCidCob.Text + ' está em branco.' + #13#10 +
                             'Deseja que o mesmo seja preenchido automaticamente no Cadastro de Cidades?', ['&Sim', '&Não']) = 1 Then
                Begin
                  pAtualizaCodigoCorreios(dbeCidCob.Text, dbeCepCob.Text);
                End

                Else Result := False;

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
            Else If (Not fEmptyStr(strNomCidCob)) And (fEmptyStr(dbeEndCob.Field.AsString)) Then
              dbeEndCob.Field.AsString := strNomCidCob;

            If Result Then
            Begin
              blnAtualizarCob := False;
              If (strCepCobAnt <> dbeCepCob.Text) Then
              Begin
                If fTiraCaracEspeciais(strCepCobAnt) = '' Then
                Begin
                  blnAtualizarCob := True;
                End
                Else
                If fMensagem('ATENÇÃO!', 'O CEP foi alterado, deseja atualizar o endereço?', ['&Sim', '&Não']) = 1 Then
                Begin
                  blnAtualizarCob := True;
                End

              End;

              If fEmptyStr(dbeCidCob.Text) Or (blnAtualizarCob And (Not fEmptyStr(strCidCob))) Then
              Begin
                dbeCidCob.Field.AsString := strCidCob;
                pCarregaCidade(qryConCiC, edtCidCob, edtEstCob, dbeCidCob, Nil, strCepCobAnt);
              End;

              If fEmptyStr(dbeEndCob.Text) Or (blnAtualizarCob) Then
                dbeEndCob.Field.AsString := strEndCob;

              If fEmptyStr(dbeBaiCob.Text) Or (blnAtualizarCob) Then
                dbeBaiCob.Field.AsString := strBaiCob;

              If (strCidCob <> dbeCidCob.Text) And (Not fEmptyStr(strCidCob)) Then
              Begin
                LCodigosCidades := untCadCid.RetornaCodigosDeCidadesComOMesmoCodCor(strCidCob, strEstadoCob, LCodigoCorreio);

                If Pos(dbeCidCob.Text + '_', LCodigosCidades) = 0 Then
                Begin
                  Result := False;
                  pMensagemOk('O CEP informado não pertence a cidade de ' + fRetNomCidade(dbeCidCob.Text) + '!');
                End;
              End;

            End;

          End;

          If (Result) Then
          Begin
            strCepCobAnt := dbeCepCob.Text;
            If blnAtualizarCob Then
            Begin
              pSetFocus(dbeEndCob);
              blnMudarFoco := False;
            End;
          End;

        End;
      End
      Else If (Sender = dbeBaiCob) Then
      Begin
        If (strBaiCobLib <> dbeBaiCob.Text) Then
          Result := fValidaDireitoDeAcessoParaAlteracaoDeBairro(dbeCodCli.Text, dbeNomCli.Text, dbeCepCob.Text, dbeBaiCob.Text, strBaiCobLib);
      End
      {*******************}
      {* VALIDA PRODUTOS *}
      {****************RV*}
      Else If (Sender = edtCodIte) And (blnBuscaPorChave) Then
      Begin
        If Not fEmptyStr(edtCodIte.Text) Then
        Begin
          objCliPro.strCodPro := edtCodIte.Text;
          pCarregaItem;
          If fEmptyStr(edtDesIte.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
            Result := False;
          End;
        End
        Else
          pProximaPagina;

      End
      {*****************************************}
      {* VALIDA O CÓDIGO DA UNIDADE            *}
      {**************************************MV*}
      Else If (Sender = edtCodUni) And (blnBuscaPorChave) Then
      Begin
        If fEmptyStr(edtCodUni.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Unidade deve ser preenchida!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          edtDesUni.Text := fRetNomUnidade(edtCodUni.Text);
          If fEmptyStr(edtDesUni.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa Unidade não está cadastrada!', ['&Ok']);
            Result := False;
          End
          Else
          Begin
            objCliPro.strCodUni := edtCodUni.Text;
            objCliPro.strDesUni := edtDesUni.Text;
            objCliPro.strUnidad := fRetSiglaUni(objCliPro.strCodUni);
          End;
        End;
      End
      Else If (Sender = edtCod_NF) And (blnBuscaPorChave) Then
      Begin
        If fEmptyStr(edtCod_NF.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe o Código de Impressão NF!', ['&Ok']);
          Result := False;
        End
        Else
          objCliPro.strCod_NF := edtCod_NF.Text;
      End

      Else If (Sender = edtDes_NF) And (blnBuscaPorChave) Then
      Begin
        objCliPro.strDes_NF := edtDes_NF.Text;
      End

      Else If (Sender = edtBar_CP) And (blnBuscaPorChave) And (edtBar_CP.Visible) Then
      Begin
        If (fCfgSis('TIPBAR', varInteger) = 1) And fCfgSis('VALBAR', varBoolean) And (Not fValidaEan13(edtBar_CP.Text)) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO!',  'Código de barras ' + edtBar_CP.Text + ' não é um código de barras válido, verifique o digito verificador!', ['&Ok']);
        End
        Else
          objCliPro.strCodBar := edtBar_CP.Text;
      End

      {*******************}
      {* VALIDA PRODUTOS *}
      {****************RV*}
      Else If (Sender = mskPlaVei) And (blnBuscaPorChave) Then
      Begin

        If fVeiculoInativo(mskPlaVei.Text) Then
        Begin
          mskPlaVei.Text := '';
          fMensagem('','Este veículo está inativo.',['&O k']);
          Result := False;
        End
        Else
        Begin
          If Not fEmptyStr(mskPlaVei.Text) Then
          Begin

            If fEmptyStr(fRetornaDescricaoVeic(mskPlaVei.Text)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Esse veículo não está cadastrado!', ['&Ok']);
              Result := False;
              mskPlaVei.Text := fChamaCadVei(VK_INSERT, mskPlaVei.Text);
            End
            Else
            Begin
              objCliVei.strPlaVei := mskPlaVei.Text;

              edtAnoVei.Text := objCliVei.strAnoVei;
              edtModVei.Text := objCliVei.strModVei;
              edtMarVei.Text := objCliVei.strMarVei;
              edtCorVei.Text := objCliVei.strCorVei;
            End;

          End
          Else
          Begin
            pLimpaEditsVeiculos;
            pProximaPagina;
          End;
        End;
      End
      Else If (Sender = edtVeiAti) And edtVeiAti.Visible And (blnBuscaPorChave) Then
      Begin
        If Pos(edtVeiAti.Text, 'S_N_') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'No campo veículo ativo deve ser informado (S)im ou (N)ão!', ['&Ok']);
          Result := False;
        End
        Else
          objCliVei.strVeiAti := edtVeiAti.Text;
      End

      Else If (Sender = dbeTaxEnt) And dbeTaxEnt.Visible Then
      Begin
        If Pos(dbeTaxEnt.Text, 'S_N_') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'No campo cobrar taxa de entrega deve ser informado (S)im ou (N)ão!', ['&Ok']);
          Result := False;
        End;
      End

      {************************************}
      {* VALIDA ENVIO DE BOLETO POR EMAIL *}
      {*********************************JU*}
      Else If (Sender = dbeEnvBol) Then
      Begin

        If Pos(dbeEnvBol.Text, 'S_N') <= 0 Then
        Begin

          fMensagem('', 'Você deve informar se envia boleto por e-mail (S ou N)!', ['&O k']);
          dbeEnvBol.Clear;

          Result := False;

        End
        Else
        Begin

          If (dbeEnvBol.Text = 'S') And
             (fEmptyStr(dbeEMCOB1.Text)) And
             (fEmptyStr(dbeEMCOB2.Text)) Then
          Begin
            fMensagem('', 'Para enviar boleto por e-mail você deve preencher pelo menos um e-mail de cobrança!', ['&O k']);
            Result := False;
          End;

        End;
      End

      {************************************}
      {* VALIDA ENVIO DE BOLETO POR EMAIL *}
      {*********************************JU*}
      Else If (Sender = dbeBolImp) Then
      Begin

        If Pos(dbeBolImp.Text, 'E_B_') <= 0 Then
        Begin
          fMensagem('', 'Informe se o boleto vai ser impresso pela (E)mpresa ou pelo (B)anco!', ['&O k']);
          Result := False;
        End;

        If (Result) And (Not grbConsulta.Enabled) And (blnBuscaPorChave) Then
          pProximaPagina;
      End

      Else If (Sender = dbeVLMINE) Then
      Begin
        If (fEmptyStr(dbeVLMINE.Text)) Then
          dbeVLMINE.Field.AsFloat := 0.0;

        If (fStrToFloat(dbeVLMINE.Text) < 0.0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo "Valor mínimo para emitir Nota Fiscal: Entrega" deve ser maior ou igual a Zero!', ['&OK']);
          Result := False;
        End;
      End

      Else If (Sender = dbeVLMINR) Then
      Begin
        If (fEmptyStr(dbeVLMINR.Text)) Then
          dbeVLMINR.Field.AsFloat := 0.0;

        If (fStrToFloat(dbeVLMINR.Text) < 0.0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo "Valor mínimo para emitir Nota Fiscal: Retira" deve ser maior ou igual a Zero!', ['&OK']);
          Result := False;
        End;
      End;

    End;

    If (Sender = dbeCoDeAc) And (dbeCoDeAc.Enabled) Then
    Begin
      If (Pos(dbeCoDeAc.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Cobrar Despesas Acessórias deve ser S ou N!', ['&Ok']);
        Result := False;
      End;
    End;

    If (Sender = dbeFone01) Or (Sender = dbeFone02) Or
       (Sender = dbeNumFax) Or (Sender = dbeNumCel) Or
       (Sender = dbeTelCob) Or (Sender = dbeTelBc1) Or
       (Sender = dbeTelBc2) Or (Sender = dbeTelBc3) Or
       (Sender = dbeTelSer) Then
    Begin
      If (Sender = dbeFone01) Then
      Begin
        If (fCfgSis('TELOBG', varBoolean)) And
           (fEmptyStr(dbeFone01.Text)) Then
        Begin
          fMensagem('','Informe o Telefone 1!', ['&Ok']);
          Result := False;
        End
        Else
        If (Not fEmptyStr(dbeFone01.Text)) And
           (fCfgSis('VLTECL', varBoolean)) And
           (Not fValidaTelefone(dbeFone01.Text))
           Then
        Begin
          fMensagem('', dbeFone01.Text + ' não é um Número de Telefone válido!!', ['&Ok']);
          Result := False;
        End;
      End;

      If (Sender = dbeFone02) Then
      Begin
        If (Not fEmptyStr(dbeFone02.Text)) And
           (fCfgSis('VLTECL', varBoolean)) And
           (Not fValidaTelefone(dbeFone02.Text)) Then
        Begin
          fMensagem('', dbeFone02.Text + ' não é um Número de Telefone válido!!', ['&Ok']);
          Result := False;
        End;
      End;

      If (fCfgSis('CELOBG',varBoolean)) And
         (Sender = dbeNumCel) And
         (fEmptyStr(dbeNumCel.Text)) Then
      Begin
        fMensagem('','Informe o Celular!', ['&Ok']);
        Result := False;
      End;

      If (tbsCrediario.Visible) And (TDBEditFocus(Sender).Visible) And
         (Not fEmptyStr(TDBEditFocus(Sender).Text)) And
         (Not fValidaTelefone(TDBEditFocus(Sender).Text)) Then
      Begin
        fMensagem('','Informe o telefone corretamente!', ['&Ok']);
        Result := False;
      End
      Else
        TDBEditFocus(Sender).Text := fAcertaMaskTel(TDBEditFocus(Sender).Text);
    End;

    If (fCfgSis('EMAOBG',varBoolean)) And
   (Sender = dbeEmail) And
   (fEmptyStr(dbeEmail.Text)) Then
    Begin
      fMensagem('','Informe o Email 1!', ['&Ok']);
      Result := False;
    End;

    If (Sender = edtRgExp) And edtRgExp.Enabled Then
    Begin
      cbxRgEst.Enabled := True;
      If (fEmptyStr(edtRgExp.Text)) Then
      Begin
        cbxRgEst.Enabled   := False;
        cbxRgEst.ItemIndex := -1;
      End;
    End;

    If (Sender = cbxRgEst) And cbxRgEst.Enabled And (Not fEmptyStr(edtRgExp.Text)) Then
    Begin
      Result := Not fEmptyStr(cbxRgEst.Text);
      If Not Result Then
        fMensagem('','Informe o estado de expedição!', ['&Ok']);
    End;

    {*******************************}
    {*NOVO CAMPO - CANAL DE ACESSO *}
    {**25/02/2011-09:28**********DP*}
    If (Sender = edtCadCac) Then
    Begin
      If Not fEmptyStr(edtCadCac.Text) Then
      Begin
        pCarregaCanalAcesso;
        If (fEmptyStr(edtDesCadCac.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Canal de Acesso não cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        if fCfgSis('CLOBCA', varBoolean) Then
        Begin
          fMensagem('ATENÇÃO!', 'Canal de Acesso deve ser preenchido!', ['&Ok']);
          Result := False;
        End;
        edtDesCadCac.Text := EmptyStr;
      End;
      if not blnCanalAcessoLibera then
      begin
        if (Not fVerificaAcessoSistema('ALTCANALACESSO')) and (strCanalAnt <> edtCadCac.Text) then
        begin
          if not fValidaAcessoAltCanalAcesso then
            Result := False
          else
          begin
            strCanalAnt := edtCadCac.Text;
            blnCanalAcessoLibera := false;
          end;
        end;
      end;
    End
    Else If (Sender = dbeCNAE) Then
    Begin
      If Not fEmptyStr(dbeCNAE.Text) Then
      Begin
        If (fEmptyStr(fCarregaCNAE(dbeCNAE.Text, strTipCna))) Then
        Begin
          fMensagem('ATENÇÃO!', 'Código CNAE não cadastrado!', ['&Ok']);
          Result := False;
        End
        Else
        If (strTipCna<>'SC') Then
        Begin
          fMensagem('ATENÇÃO!', 'Código CNAE é do tipo ('+strTipCna+') e não do tipo SubClasse(SC). Por esse motivo não pode ser usado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeIndust) And dbeIndust.Visible Then
    Begin
      If Pos(dbeIndust.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'No campo Indústria deve ser informado (S)im ou (N)ão!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = dbePermut) And pnlPermut.Visible Then
    Begin
      If fEmptyStr(dbePermut.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo Permuta para isenção do pagamento de comissão de venda deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (Pos(dbePermut.Text,'S_N_') <= 0) Then
      Begin
        Result := False;
      End;
    End

    Else If (Sender = dbeOSNFEn) And dbeOSNFEn.Visible Then
    Begin
      If fEmptyStr(dbeOSNFEn.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo "Obrigar nota de entrada emitida pelo cliente para conserto de equipamentos?" deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (Pos(dbeOSNFEn.Text,'S_N_') <= 0) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'No campo "Obrigar nota de entrada emitida pelo cliente para conserto de equipamentos?" deve ser informado (S)im ou (N)ão!', ['&Ok']);
      End;
    End

    Else If (Sender = dbeCarExc) And dbeCarExc.Visible Then
    Begin
      If fEmptyStr(dbeCarExc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo "Cliente com controle de carga e entrega exclusiva" deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (Pos(dbeCarExc.Text,'S_N_') <= 0) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'No campo "Cliente com controle de carga e entrega exclusiva" deve ser informado (S)im ou (N)ão!', ['&Ok']);
      End;
    End

    Else If (Sender = chkSeg) Or (Sender = chkTer) Or (Sender = chkQua) Or
            (Sender = chkQui) Or (Sender = chkSex) Or (Sender = chkSab) Then
    Begin
      If (Not chkSeg.Checked) And (Not chkTer.Checked) And (Not chkQua.Checked) And
         (Not chkQui.Checked) And (Not chkSex.Checked) And (Not chkSab.Checked) Then
      Begin
        rdbSemanal.Checked   := False;
        rdbQuinzenal.Checked := False;
        rdbMensal.Checked    := False;

        qryTabela.FieldByName('CLI_PERDVI').AsString := '';
      End;
    End

    Else If (Sender = rdbSemanal) Or
            (Sender = rdbQuinzenal) Or
            (Sender = rdbMensal) Then
    Begin
      If (chkSeg.Checked) Or (chkTer.Checked) Or (chkQua.Checked) Or
         (chkQui.Checked) Or (chkSex.Checked) Or (chkSab.Checked) Then
      Begin
        If (Not rdbSemanal.Checked) And
           (Not rdbQuinzenal.Checked) And
           (Not rdbMensal.Checked) Then
        Begin
          fMensagem('ATENÇÃO!', 'Selecione a Periodicidade das Visitas!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeStReEs) Then
    Begin
      If (Pos(dbeStReEs.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Preencha o campo "Sujeito passivo por ST atribuida por regime especial?" corretamente!', ['&Ok']);
        Result := False
      End
      Else
      Begin
        dbePrStRe.Enabled := (dbeStReEs.Text = 'S');

        If (Not dbePrStRe.Enabled) Then
          dbePrStRe.Text := '';
      End;
    End

    Else
    If (Sender = edtCodBai)  Then
    Begin
      If (not fEmptyStr(edtCodBai.Text)) Then
      Begin
        edtDescri.Text    := fRetNomBairro(edtCodBai.Text, opcDescri);

        If fEmptyStr(edtDescri.Text) Then
        Begin
          fMensagem('','Bairro não Cadastrado!', ['&OK']);
          Result := False;
        End;

        If Result Then
        Begin
          edtCodCidBat.Text := fRetNomBairro(edtCodBai.Text, opcCodCid);
          edtNomCidBat.Text := fRetNomBairro(edtCodBai.Text, opcNomCid);
          edtEstadoBat.Text := fRetNomBairro(edtCodBai.Text, opcEstado);
        End;

      End
      Else
      Begin
        blnMudarFoco := False;
        pSetFocus(dbgCliBat);
      End;

    End

    Else If (Not (qrytabela.State in [dsInsert, dsEdit])) And (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Empresa deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaDescrEmpresa;

        If (Not (qrytabela.State in [dsInsert, dsEdit])) And fEmptyStr(strNomEmp) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
          Result := False;
        End
        Else
        If (fEmpresaJaDesmembr(edtCodEmp.Text)) And
           (Not (qrytabela.State in [dsInsert, dsEdit])) And
           (strStatusContaContabil = 'INSERT') Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa já está incluida no desmembramento!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtConCon) And (Not (qrytabela.State in [dsInsert, dsEdit])) Then
    Begin
      If fEmptyStr(edtConCon.Text) Then
      Begin
        fMensagem('', 'Conta Contábil deve ser preechido!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (pnlEntregas.Visible) And (Sender = pnlEntregas) And Assigned(FCliEndEntrega) And (blnBuscaPorChave) Then
    Begin
      If FCliEndEntrega.cdsConsulta.State In [dsEdit, dsInsert] Then
      Begin
        fMensagem('', 'O endereço de entrega está em edição. Por favor salve as alterações para gravar o cliente.', ['&Ok']);
        pgcDados.ActivePage := tbsEntregas;
        pSetFocus(FCliEndEntrega.btnGravar);
        Result := False;
      End
      Else
      Begin
        pAtualizaEnderecoPadraoEntrega;
        Result := FCliEndEntrega.fValidaTransportadora;
      End;
    End

    Else
    If (Sender = dbeCrmFre) Then
    Begin
      pCarregaFrequenciaCrm;
      If fEmptyStr(edtDesFre.Text) And (Not fEmptyStr(dbeCrmFre.Text)) Then
      Begin
        Result := False;
        fMensagem('', 'O Código de Frenquência digitado não existe!', ['&OK']);
      End;
    End

    Else
    If (Sender = dbeCrmPor) Then
    Begin
      pCarregaPorteCrm;
      If fEmptyStr(edtDesCrmPor.Text) And (Not fEmptyStr(dbeCrmPor.Text)) Then
      Begin
        Result := False;
        fMensagem('', 'O Código de Porte digitado não existe!', ['&OK']);
      End;
    End

    Else
    If (Sender = dbeCrmFai) Then
    Begin
      pCarregaFaixaCrm;
      If fEmptyStr(edtDesFai.Text) And (Not fEmptyStr(dbeCrmFai.Text)) Then
      Begin
        Result := False;
        fMensagem('', 'O Código da Faixa de Faturamento Estimado digitado não existe!', ['&OK']);
      End;
    End

    Else
    If (Sender = dbeCrmCat) Then
    Begin
      pCarregaCategoriaCrm;
      If fEmptyStr(edtDesCat.Text) And (Not fEmptyStr(dbeCrmCat.Text))  Then
      Begin
        Result := False;
        fMensagem('', 'O Código da Categoria digitado não existe!', ['&OK']);
      End;
    End

    Else
    If (Sender = edtCrmFor) Then
    Begin
      pCarregaFornecedorCrm;
      If fEmptyStr(edtDesFor.Text) And (Not fEmptyStr(edtCrmFor.Text)) Then
      Begin
        Result := False;
        fMensagem('', 'O Código do Fornecedor Atual digitado não existe!', ['&OK']);
      End;
    End

    Else If (Sender = edtCodEmb) And (tshEmbarcacoes.TabVisible) Then Begin
      If (Not fEmptyStr(edtCodEmb.Text)) Then Begin
        edtDesEmb.Text := fRetNomEmbarcacao(edtCodEmb.Text);

        If (fEmptyStr(edtDesEmb.Text)) Then Begin
          fMensagem('ATENÇÃO!', 'Código de embarcação não é válido. Verifique!', ['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodQua) And (tbsQualificacao.TabVisible) Then
    Begin
      If (Not fEmptyStr(edtCodQua.Text)) Then
      Begin
        edtDesQua.Text := fRetDesQua(edtCodQua.Text);

        If (fEmptyStr(edtDesQua.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Código de Qualificação não é válido. Verifique!', ['&OK']);
          Result := False;
        End;
      End;
    End

    Else if (Sender = dbeLatitu) or (Sender = dbeLongit) or (Sender = dbeRaio__) then
    Begin
      if fCfgSis('USALAT', varBoolean) then
      begin
        if fCfgSis('REQLAT', varBoolean) then
        begin
          if (Sender = dbeLatitu) and fEmptyStr(dbeLatitu.Text) then
          begin
            fMensagem('ATENÇÃO!', 'A Latitude deve ser informada! Verifique!', ['&OK']);
            Result := False;
          end;

          if (Sender = dbeLongit) and fEmptyStr(dbeLongit.Text) then
          begin
            fMensagem('ATENÇÃO!', 'A Longitude deve ser informada! Verifique!', ['&OK']);
            Result := False;
          end;

          if (Sender = dbeRaio__) and fEmptyStr(dbeRaio__.Text) then
          begin
            fMensagem('ATENÇÃO!', 'O Raio deve ser informado! Verifique!', ['&OK']);
            Result := False;
          end;
        end;
      end
    End
    Else If (Sender = cbxTributacaoIPI) Then
    Begin
      If (Copy(cbxTributacaoIPI.Text,1,1) = 'T')  Or (Copy(cbxTributacaoIPI.Text,1,1) = 'N') Then
      Begin
        dbeEnqIPI.Text := IIF(Copy(cbxTributacaoIPI.Text,1,1) = 'N', '999', '');
        dbeEnqIPI.Enabled := False;
        dbeMensagemIPI.Enabled := IIF(Copy(cbxTributacaoIPI.Text,1,1) = 'N', True, False);
        dbeMensagemIPI.Text := IIF(Copy(cbxTributacaoIPI.Text,1,1) = 'N', dbeMensagemIPI.Text, '');
      End
      Else
      Begin
        dbeEnqIPI.Enabled := True;
        dbeMensagemIPI.Enabled := True;
      End;
    End
    Else If (Sender = cbxTributacaoPisCofins) Then
    Begin
      If Copy(cbxTributacaoPisCofins.Text,1,1) = 'T' Then
      Begin
        dbeMensagemPisCofins.Enabled := False;
        dbeMensagemPisCofins.Text    := '';
      End
      Else
        dbeMensagemPisCofins.Enabled := True;
    End

    Else If (Sender = dbeAtoDDF) Then
    Begin
      If pnlAtoDeclaratorioDF.Visible Then
      Begin
        If (Pos(dbeAtoDDF.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo Decreto 34063/12 para o estado DF deve ser S ou N!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          dbmMsgAtoDDF.Enabled := (dbeAtoDDF.Text = 'S');
          If Not dbmMsgAtoDDF.Enabled Then
            dbmMsgAtoDDF.Field.Clear;
        End;
      End
      Else
      Begin
        dbeAtoDDF.Field.AsString := 'N';
        dbmMsgAtoDDF.Field.Clear;
      End;
    End

    Else If (Sender = dbmMsgAtoDDF) And pnlAtoDeclaratorioDF.Visible Then
    Begin
      If (dbeAtoDDF.Text = 'S') And fEmptyStr(dbmMsgAtoDDF.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O ato declaratório do decreto 34063/12 para o estado DF está ativado.' + sLineBreak +
                  'Sendo assim, é preciso preencher a mensagem a ser incluída nos dados adicionais da NFe', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeAltEco) And tbsEcommerce.tabVisible Then
    Begin
      If (Pos(dbeAltEco.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Preencha o campo "Permite alterações cadastrais via E-Commerce?" corretamente!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeExpEco) And tbsEcommerce.tabVisible Then
    Begin
      If (Pos(dbeExpEco.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Preencha o campo "Exportar para E-Commerce?" corretamente!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeObgPdl) And tbsEcommerce.tabVisible Then
    Begin
      If (Pos(dbeObgPdl.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Preencha o campo "Obrigar pedido passar pela rotina de liberação mesmo que não tenha nenhuma trava?" corretamente!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeLimCtr) And (pnlLimitaContratoLocacao.Visible) Then
    Begin

      If (fEmptyStr(dbeLimCtr.Text)) Then
        dbeLimCtr.Field.AsFloat := 0.0;

      If (fStrToFloat(dbeLimCtr.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor de limite para contrato de locação deve ser maior ou igual à Zero!', ['&Ok']);
        Result := False;
      End;

      If (fStrToFloat(dbeLimCtr.Text) > 0.0) And (Not(SameValue(fltVlrLimCtrAnt, fStrToFloat(dbeLimCtr.Text)) ))  Then
        Result := fLiberaAltLimContratoLocacao(fltVlrLimCtrAnt, fStrToFloat(dbeLimCtr.Text));

      If Result Then
        fltVlrLimCtrAnt := fStrToFloat(dbeLimCtr.Text)
      Else
        dbeLimCtr.Text := FormatFloat('###,#0.00', fltVlrLimCtrAnt);

    End

    Else If (Sender = dbeIDEstrangeiro) And (dbeIDEstrangeiro.Visible) Then
    Begin
      Result := fValidouIDEstrangeiro(blnBuscaPorChave);
      pAlterarStatusCpfCnpj;
    End;

    pOrgaoPublicoForaDoEstado;

  Except
    On E: ExceptionAutCom Do
    Begin
      fMensagem('', E.Message, ['&Ok']);
      Result := False;
    End;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmCadClientes.fValidaCampos]');
      Result := False;
    End;
  End;

  If (Not Result) And (Sender <> pnlEntregas) Then
  Begin
    pFindAndActivePage(Sender);
    pSetFocus(Sender);
  End;

end;

function TfrmCadClientes.fValidaCamposCCCLIE(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    {*****************************************}
    {* VALIDA O CÓD. DA EMPRESA              *}
    {**************************************JU*}
    If (Sender = edtCodEmp) And edtCodEmp.Enabled Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Empresa deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaDescrEmpresa;

        If fEmptyStr(strNomEmp) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
          Result := False;
        End
        Else
        If (fEmpresaJaDesmembr(edtCodEmp.Text)) And
           (strStatusContaContabil = 'INSERT') Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa já está incluida no desmembramento!', ['&O k']);
          Result := False;
        End;
      End;
    End
    {*****************************************}
    {* VALIDA O CONTA CONTÁBIL               *}
    {**************************************JU*}
    Else If (Sender = edtConCon) Then
    Begin
      If fEmptyStr(edtConCon.Text) Then
      Begin
        fMensagem('', 'Conta Contábil deve ser preechido!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadClientes.fValidaCndCli(const strCodCnd: String): Boolean;
var
  qrySelect: TUniQuery;
  strMsg: String;

  function GetSQLTipoClienteCondicao(ACodCnd: String = ''): String;
    Var
      LSQL: string;
  begin
    LSQL := '';
    LSQL := LSQL + ' SELECT AUTOINCREM FROM TIPCND ';
    LSQL := LSQL + ' WHERE TCN_CODTIP = :CODTIP ';

    If Not fEmptyStr(ACodCnd) Then
      LSQL := LSQL + ' AND TCN_CODCND = :CODCND ';

    Result := LSQL;
  end;
begin
  strTipCli := qryTabela.FieldByName('CLI_TIPCLI').AsString;

  if not fCfgSis('USATPC', varBoolean) then
    Exit(True);

  if fEmptyStr(strTipCli) then
    Exit(True);

  qrySelect := fCriaQuery;
  try
    qrySelect.SQL.Text := GetSQLTipoClienteCondicao;
    qrySelect.ParamByName('CODTIP').AsString := strTipCli;

    qrySelect.Open;

    If qrySelect.IsEmpty Then
      Exit(True);

    if fEmptyStr(strCodCnd) then
    begin
      strMsg := '';
      cdsCliCnd.DisableControls;
      try
        cdsCliCnd.First;
        while not cdsCliCnd.Eof do
        begin
          qrySelect.Close;
          qrySelect.SQL.Text := GetSQLTipoClienteCondicao(cdsCliCnd.FieldByName('CND_CODCND').AsString);
          qrySelect.ParamByName('CODTIP').AsString := strTipCli;
          qrySelect.ParamByName('CODCND').AsString := cdsCliCnd.FieldByName('CND_CODCND').AsString;

          qrySelect.Open;

          if qrySelect.IsEmpty then
            strMsg := strMsg + iif(fEmptyStr(strMsg), '', ', ') + cdsCliCnd.FieldByName('CND_CODCND').AsString + '-' + fRetDesConPag(cdsCliCnd.FieldByName('CND_CODCND').AsString);

          cdsCliCnd.Next;
        end;

        if not fEmptyStr(strMsg) then
          Result := fExibeMensagemValidaCndCli(strMsg)
        else
          Exit(True);
      finally
        cdsCliCnd.EnableControls;
      end;
    end
    else
    begin
      qrySelect.Close;
      qrySelect.SQL.Text := GetSQLTipoClienteCondicao(strCodCnd);
      qrySelect.ParamByName('CODTIP').AsString := strTipCli;
      qrySelect.ParamByName('CODCND').AsString := strCodCnd;

      qrySelect.Open;

      if qrySelect.IsEmpty then
        Result := fExibeMensagemValidaCndCli(strCodCnd + '-' + fRetDesConPag(strCodCnd))
      else
        Exit(True);
    end;
  finally
    FreeAndNil(qrySelect);
  end;
end;

function TfrmCadClientes.fExecutaAntesDoDelete: Boolean;
begin
  Result := True;
  If dbeCliFid.Text = dbeCodCli.Text Then
  Begin
    qryTabela.Edit;
    qryTabela.FieldByName('CLI_CLIFID').Clear;
    qryTabela.Post;
  End;
end;

function TfrmCadClientes.fExibeMensagemValidaCndCli(const strCnd: String): Boolean;
var
  strTexto: String;
  strMensagem: String;
  intContador: Integer;
  LMsg : String;
begin
  if fCfgSis('CNDCLI', varBoolean) then
  begin
    objLiberacao.Clear;
    objLiberacao.strDirAce    := 'CNDSEN';
    objLiberacao.strSenLib    := fCfgSis('CNDSEN');
    objLiberacao.strMsgSen    := 'Condição de pagamento não permitida conforme o tipo do cliente';
    objLiberacao.strCodOpe    := strLoginUsuarioLogado;
    objLiberacao.strCodDig    := strLoginUsuarioLogado;
    objLiberacao.strCliente   := (dbeCodCli.Text + '-' + dbeNomCli.Text);
    objLiberacao.strCpfCnpj   := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
    objLiberacao.objMsgLibera.pAddTexto('Condição de pagamento não permitida conforme o tipo do cliente');

    strMensagem := 'Condição de Pagamento: ' + strCnd;

    if strMensagem.Length < 140 then
      objLiberacao.objMsgLibera.pAddTexto(strMensagem)
    else
    begin
      strTexto := strMensagem;
      intContador := 0;
      while not fEmptyStr(strTexto) do
      begin
        strTexto := Copy(strMensagem, (intContador * 140) + 1, 140);
        if not fEmptyStr(strTexto) then
          objLiberacao.objMsgLibera.pAddTexto(strTexto);
        inc(intContador);
      end;
    end;
    objLiberacao.objMsgLibera.pAddTexto('Tipo de Cliente: ' + strTipCli + '-'+ fRetDescricaoTipoCli(strTipCli));

    Result := objLiberacao.fLibera;
  end
  else
  begin
    LMsg := 'Condição de pagamento não permitida conforme o tipo do cliente' + sLineBreak +
            'Condição de Pagamento: ' + strCnd + sLineBreak +
            'Tipo de Cliente: ' + strTipCli + '-'+ fRetDescricaoTipoCli(strTipCli);
    pMensagemOk(LMsg,0,CalculaTamanhoMensagem(LMsg));
    Result := False;
  end;
end;



procedure TfrmCadClientes.pCalculaTotalRenda(Sender: TObject);
begin
  inherited;
  edtTotRen.Text := FloatToStrF(fStrToFloat(dbeSalari.Text) + fStrToFloat(dbeOutRen.Text), ffNumber, 12, 2);
end;

procedure TfrmCadClientes.pCarregaAtividade;
begin
  pPesquisaCadAti(qryCadAti, qryConAti, dbeCodAti.Text);
  With qryConAti Do
  Begin
    edtAtividade.Text := FieldByName('ATI_DESATI').AsString;
  End;
end;

{*****************}
{*CANAL DE ACESSO*}
{**************DP*}
procedure TfrmCadClientes.pCarregaCanalAcesso;
begin
  If Not fEmptyStr(edtCadCac.Text) Then
    edtDesCadCac.Text := fRetNomCanalAcesso(edtCadCac.Text)
  Else
    edtDesCadCac.Text := EmptyStr;
End;

procedure TfrmCadClientes.pCarregaCategoriaCrm;
begin
  edtDesCat.Clear;
  If Not fEmptyStr(dbeCrmCat.Text) Then
    edtDesCat.Text := fRetDesCrmCat(dbeCrmCat.Text);
end;

procedure TfrmCadClientes.pCarregaCidade(qryConsulta: TUniQuery; edtCidade,
  edtEstado: TEdit; dbeCidade, dbeCep: TDBEditFocus; Var strCepAnt: String);
begin
  pPesquisaCadCid(qryCadCid, qryConsulta, dbeCidade.Text);
  With qryConsulta Do
  Begin
    edtCidade.Text := FieldByName('CID_NOMCID').AsString;
    edtEstado.Text := FieldByName('CID_ESTADO').AsString;

    If (Assigned(dbeCep)) And (dbeCep.Field <> Nil) And (dbeCep.Field.IsNull) Then
    Begin
      dbeCep.Text := FieldByName('CID_C_E_P_').AsString;
      strCepAnt   := FieldByName('CID_C_E_P_').AsString;
    End;

    if (qryTabela.State in [dsInsert, dsEdit]) and (not fEmptyStr(dbeCodCid.Text)) and (not fEmptyStr(edtCidade.Text)) then
    begin
      Case AnsiIndexStr(UpperCase(fBuscaSituacaoPisCofinsCidade(dbeCodCid.Text)), ['T', 'I','S', 'D', 'Z']) of
        0 : cbxTributacaoPisCofins.ItemIndex := Integer(sitPisCofinsTributado);
        1 : cbxTributacaoPisCofins.ItemIndex := Integer(sitPisCofinsIsento);
        2 : cbxTributacaoPisCofins.ItemIndex := Integer(sitPisCofinsSuspenso);
        3 : cbxTributacaoPisCofins.ItemIndex := Integer(sitPisCofinsDiferido);
        4 : cbxTributacaoPisCofins.ItemIndex := Integer(sitPisCofinsTributadoAliquotaZero);
      end;
      cbxTributacaoPisCofinsChange(Self);
    end;
  End;
end;

procedure TfrmCadClientes.pCarregaDadosAdicionais;
begin
  pCarregaOperador;
  pCarregaCidade(qryConCid, edtNomCid, edtEstado, dbeCodCid, dbeNumCep, strCepAnt);
  pCarregaRepr_Vend(dbeCodVen.Text, edtVendedor);
  pCarregaRepr_Vend(dbeCodRep.Text, edtRepresentante);
  pCarregaAtividade;
  pCarregaCidade(qryConCiC, edtCidCob, edtEstCob, dbeCidCob, dbeCepCob, strCepCobAnt);
  pCarregaPortador(1);
  pCarregaPortador(2);
  pCarregaCliFid;
  pCarregaRegiao;
  pCarregaSubRegiao;
  pCarregaCanalAcesso;
  pCarregaRedeLojas;
  pCarregaEmpresa;
  pCarregaEmpresaRCF;
  pCarregaPlanoContabil;
  pCarregaEnquadramentoIPI;
  pCarregaDescricaoCNAE;

  pCarregaImagem;

  If ( fCfgSis('USAFPG', varBoolean) ) Then
    pCarregaFormaPag;

  edtDesTpc.Text := fRetDescricaoTipoCli(dbeTipCli.Text);
  edtCorres.Text := fRetNomCliente(dbeCorres.Text);

  pAtualizaCadFic(qryTabela.FieldByName('CLI_CODCLI').AsString);

  pAtualizaInfCre;

  pHabilitaBotoesAdicionais;

  {********************************************}
  {* VARIÁVEL PARA TRAT. DE VENDEDOR ALTERADO *}
  {*****************************************IV*}
  blnVendAlt := False;

  edtCodEmpresaExit(Self);

  edtSupGer.Text := fRetNomVendRep(dbeSupGer.Text);
  edtSupReg.Text := fRetNomVendRep(dbeSupReg.Text);

  pHabilitaConsultaSCPC;
  btnConsultaSerasaPowerCurve.Enabled := UtilizaConsultaSerasaPowerCurve;
  btnConsultaSerasaExperian.Enabled   := UtilizaConsultaSerasaExperian;
  cbProdutoSerasa.Enabled := (cmbTipoPesquisa.ItemIndex = 1);

  pCarregaCondicaoPagamento(qryTabela.FieldByName('CLI_CODCLI').AsString);
  pCarregaCliDepProd(qryTabela.FieldByName('CLI_CODCLI').AsString);
  pCarregaProfissional(qryTabela.FieldByName('CLI_CODCLI').AsString);
  pCarregaDiaFixo;
  pCarregaDiaFixoMes;
  pCarregaDiaVisitas;
  pCarregaDiaFixoEntFat;
  pCarregaDiaSemFat;
  pCarregaDiaSemEnt;
  pCarregaQuaCli;

  {Apenas cliente de atividade construtora}
  If fCfgSis('REGFIS', varString) = '1' Then
    TabConstrutora.TabVisible := fAtividadeConstrutora(qryTabela.FieldByName('CLI_CODATI').AsString)
  Else
  {Para todos os clientes}
  If fCfgSis('REGFIS', varString) = '2' Then
    TabConstrutora.TabVisible := True;

  blnPreencherClubeFidelidadeComProprioCliente := False;

  If pnlNeocredit.Visible Then
  Begin
    edtUltimaConsultaNeocredit.Clear;

    If qryTabela.FieldByName('CLI_UDTNEO').AsDateTime <> 0 Then
      edtUltimaConsultaNeocredit.Text := FormatDateTime('dd/mm/yyyy', qryTabela.FieldByName('CLI_UDTNEO').AsDateTime);

    edtStatusConsultaNeocredit.Text := TLibNeocredit.RetornaDescricaoStatus(qryTabela.FieldByName('CLI_STANEO').AsString);
  End;
end;

procedure TfrmCadClientes.pCarregaDescrEmpresa;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  EMP_NOMEMP ');
    qryAux.SQL.Add('FROM');
    qryAux.SQL.Add('  CADEMP ');
    qryAux.SQL.Add('WHERE EMP_CODEMP = :CODEMP');

    qryAux.ParamByName('CODEMP').AsString := edtCodEmp.Text;
    qryAux.Open;

    strNomEmp := qryAux.FieldByName('EMP_NOMEMP').AsString;
    edtNomEmp.Text := strNomEmp;
  Finally
    qryAux.Free;
  End;
end;

procedure TfrmCadClientes.pCarregaDescricaoCNAE;
var
  strTipCna: String;
begin
  if (not fEmptyStr(dbeCNAE.Text)) then
    dbeCNAE.Text := fCarregaCNAE(dbeCNAE.Text, strTipCna);
end;

procedure TfrmCadClientes.pCarregaRepr_Vend(strCodigo: String; edtDescricao: TEditFocus);
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, strCodigo);
  With qryConOpe Do
  Begin
    edtDescricao.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

procedure TfrmCadClientes.pCarregaSocios(strCodCli: String; blnHeranca : Boolean = False);
var
  qryAux : TUniQuery;
begin

  cdsCadSco.EmptyDataSet;
  pLimpaEditsQuadroSocietario;

  If Not fEmptyStr(strCodCli) Then
  Begin

    qryAux := fCriaQuery(Self);

    Try

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT * FROM CLISCO WHERE SCO_CODCLI = ' + QuotedStr(strCodCli));
      qryAux.Open;

      If Not qryAux.IsEmpty Then
      Begin

        qryAux.First;
        While Not qryAux.Eof Do
        Begin

          cdsCadSco.Append;

          If Not blnHeranca Then
            cdsCadScoAUTOINCREM.AsString := qryAux.FieldByName('AUTOINCREM').AsString
          Else
            cdsCadScoAUTOINCREM.Clear;

          cdsCadScoSCO_CODCLI.AsString   := qryAux.FieldByName('SCO_CODCLI').AsString;
          cdsCadScoSCO_NOMSCO.AsString   := qryAux.FieldByName('SCO_NOMSCO').AsString;
          cdsCadScoSCO_PF_PJ_.AsString   := qryAux.FieldByName('SCO_PF_PJ_').AsString;
          cdsCadScoSCO_CPFCNP.AsString   := qryAux.FieldByName('SCO_CPFCNP').AsString;
          cdsCadScoSCO_NUM_RG.AsString   := qryAux.FieldByName('SCO_NUM_RG').AsString;

          If Not qryAux.FieldByName('SCO_DTANAS').IsNull Then
            cdsCadScoSCO_DTANAS.AsDateTime := qryAux.FieldByName('SCO_DTANAS').AsDateTime;

          cdsCadScoSCO_ESTCIV.AsString   := qryAux.FieldByName('SCO_ESTCIV').AsString;
          cdsCadScoSCO_PER_PS.AsFloat    := qryAux.FieldByName('SCO_PER_PS').AsFloat;
          cdsCadSco.Post;

          qryAux.Next;

        End;

      End;

    Finally
      FreeAndNil(qryAux);
    End;

  End;

end;

procedure TfrmCadClientes.pCarregaSubRegiao;
begin
  If Not fEmptyStr(dbeCodSub.Text) Then
    edtDesSub.Text := fRetNomSubRegiao(dbeCodSub.Text)
  Else
    edtDesSub.Text := EmptyStr;
end;

procedure TfrmCadClientes.pCarregaFaixaCrm;
begin
  edtDesFai.Clear;
  If Not fEmptyStr(dbeCrmFai.Text) Then
    edtDesFai.Text := fRetDesCrmFai(dbeCrmFai.Text);
end;

procedure TfrmCadClientes.pCarregaFormaPag;
begin
  If Not fEmptyStr(dbeCodFpg.Text) Then
    edtDesFpg.Text := fRetDesFpg(dbeCodFpg.Text)
  Else
    edtDesFpg.Clear;
end;

procedure TfrmCadClientes.pCarregaFornecedorCrm;
begin
  edtDesFor.Clear;
  If Not fEmptyStr(edtCrmFor.Text) Then
    edtDesFor.Text := fRetDesCrmFor(edtCrmFor.Text);
end;

procedure TfrmCadClientes.pCarregaFrequenciaCrm;
begin
  edtDesFre.Clear;
  If Not fEmptyStr(dbeCrmFre.Text) Then
    edtDesFre.Text := fRetDesCrmFre(dbeCrmFre.Text);
end;

procedure TfrmCadClientes.pCarregaGridEmpCli;
  Var
    qryAux, qryAuxEmp: TUniQuery;
begin
  cdsEmpCli.EmptyDataSet;

  qryAux := fCriaQuery(Nil);
  qryAuxEmp := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add('SELECT * FROM CCCLIE WHERE CCC_CODCLI = :CODCLI ORDER BY CCC_CODEMP ');
    qryAux.ParamByName('CODCLI').AsString := dbeCodCli.Text;
    qryAux.Open;

    qryAuxEmp.SQL.Add('SELECT EMP_NOMEMP FROM CADEMP WHERE EMP_CODEMP = :CODEMP ');

    qryAux.First;
    While Not qryAux.Eof Do
    Begin
      qryAuxEmp.Close;
      qryAuxEmp.ParamByName('CODEMP').AsString := qryAux.FieldByName('CCC_CODEMP').AsString;
      qryAuxEmp.Open;

      cdsEmpCli.Append;
      cdsEmpCliCodEmp.AsString := qryAux.FieldByName('CCC_CODEMP').AsString;
      cdsEmpCliNomEmp.AsString := qryAuxEmp.FieldByName('EMP_NOMEMP').AsString;
      cdsEmpCliConcon.AsString := qryAux.FieldByName('CCC_CONCON').AsString;
      cdsEmpCliCodigo.AsString := qryAux.FieldByName('CCC_CODCLI').AsString;
      cdsEmpCliAUTOINCREM.AsString := qryAux.FieldByName('AUTOINCREM').AsString;
      cdsEmpCli.Post;

      qryAux.Next;
    End;
  Finally
    qryAux.Free;
    qryAuxEmp.Free;
  End;
end;

procedure TfrmCadClientes.pCarregaGrupoRisco;                                                                   
Var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT                            ';
  strSQL := strSQL + '  GRR_CODIGO,                     ';
  strSQL := strSQL + '  GRR_DESCRI,                     ';
  strSQL := strSQL + '  GRR_ATRMAX                      ';
  strSQL := strSQL + 'FROM                              ';
  strSQL := strSQL + '  GRURIS G                        ';
  strSQL := strSQL + 'LEFT JOIN GRROPE O                ';
  strSQL := strSQL + '  ON O.GRO_SEQGRR = G.AUTOINCREM  ';
  strSQL := strSQL + '  AND O.GRO_CODOPE = :CODOPE      ';
  strSQL := strSQL + 'LEFT JOIN OPEGPO P                ';
  strSQL := strSQL + '  ON P.OPE_CODOPE = :CODOPE       ';
  strSQL := strSQL + 'LEFT JOIN GRRGRU U                ';
  strSQL := strSQL + '  ON U.GRG_SEQGRR = G.AUTOINCREM  ';
  strSQL := strSQL + '  AND U.GRG_CODGPO = P.GPO_CODGPO ';
  strSQL := strSQL + 'LEFT JOIN CADCLI C                ';
  strSQL := strSQL + '  ON C.CLI_CODGRR = G.GRR_CODIGO  ';
  strSQL := strSQL + '  AND C.CLI_CODCLI = :CODCLI      ';
  If Not fEhAdministrador(strLoginUsuarioLogado) Then
  Begin
    strSQL := strSQL + 'WHERE O.GRO_CODOPE IS NOT NULL    ';
    strSQL := strSQL + '  OR U.GRG_CODGPO IS NOT NULL     ';
    strSQL := strSQL + '  OR C.CLI_CODCLI IS NOT NULL     ';
  End;

  With qryGruRis Do
  Begin
    SQL.Text := strSQL;
    ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    ParamByName('CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
    Open;
  End;
end;

procedure TfrmCadClientes.pCarregaItem;
begin
  pPesquisaCadIte(qryConPro, qryConPro, edtCodIte.Text, '');
  With qryConPro Do
  Begin
    edtDesIte.Text      := FieldByName('ITE_DESITE').AsString;
    if (not blnAltProduto) and fEmptyStr(edtCodUni.Text) then
    begin
      edtCodUni.Text      := FieldByName('ITE_CODUNI').AsString;
      edtDesUni.Text      := fRetNomUnidade(FieldByName('ITE_CODUNI').AsString);
    end;
    objCliPro.strNomPro := edtDesIte.Text;
  End;
end;

procedure TfrmCadClientes.pCarregaOperador;
begin
  If Not fEmptyStr(dbeOpeAlt.Text) Then
    edtNomOpe.Text := fRetNomeOperador(dbeOpeAlt.Text)
  Else
    edtNomOpe.Clear;
end;

procedure TfrmCadClientes.pCarregaOperadorRco;
begin
  pPesquisaCadOpe(Nil, qryConRco, edtCodOpe.Text);
  With qryConRco Do
  Begin
    edtDesCodOpe.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

procedure TfrmCadClientes.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CLI_NOMCLI');
  stlCampos.Add('CLI_CODCLI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CLI_NOMCLI+CLI_ENDERE+CID_NOMCID');
  stlCamInd.Add('CLI_FANSOB+CLI_ENDERE+CID_NOMCID');
  stlCamInd.Add('CID_NOMCID+CLI_ENDERE+CLI_ENDNUM');
  stlCamInd.Add('CID_NOMCID');
  stlCamInd.Add('ATI_DESATI');
  stlCamInd.Add('CLI_CODCLI');
  stlCamInd.Add('CLI_C_G_C_');
  stlCamInd.Add('CLI_I_E_S_');
  stlCamInd.Add('OPE_NOMOPE');
  stlCamInd.Add('CLI_CODRED');
  stlCamInd.Add('RED_DESRED');
  stlCamInd.Add('CLI_NOMCLI+CLI_DTACAD');

  stlDesInd.Add('Nome / Endereço / Cidade');
  stlDesInd.Add('Fantasia / Endereço / Cidade');
  stlDesInd.Add('Cidade / Endereço / Numero');
  stlDesInd.Add('Cidade');
  stlDesInd.Add('Atividade');
  stlDesInd.Add('Código');
  stlDesInd.Add('CNPJ - CPF');
  stlDesInd.Add('Inscrição Estadual');
  stlDesInd.Add('Vendedor');
  stlDesInd.Add('Cód. Rede de Lojas');
  stlDesInd.Add('Rede de Lojas');
  stlDesInd.Add('Nome / Dt. Cadastro');

  pAtribuiTabelas;
end;

procedure TfrmCadClientes.btnIncluirCCClick(Sender: TObject);
begin
  inherited;

  strStatusContaContabil := 'INSERT';
  pControlaBotoes;
  pSetFocus(edtCodEmp);
end;

procedure TfrmCadClientes.btnIncluirClick(Sender: TObject);
var
  strClienteProfissional : string;
begin
  inherited;

  if Assigned(LogAltCadCli) then
    LogAltCadCli.LogVar.Clear;

  strCodVen := '';
  strCodRep := '';
  strBaiCobLib := '';
  strBairroLib := '';
  strStaCli := '';
  intAtrMax := 0;
  strCodGrupoRisco  := '';
  memOrientacoes.Text := '';
  strAltCgcCpf      := '';

  blnLibNum    := False;
  blnLibPor    := False;
  blnLibPo2    := False;

  strTabPreAnt := fCfgSis('TABPAD');

  qryCadFic.Insert;

  If blnCrediario Then
    qryInfCre.Insert;

  pInicializaValoresPadrao;
  pInicializaCampos;
  pLimpaImagem;
  pLimpaEdits;
  pLimpaEditsContatos;
  pLimpaEditsProdutos;
  pLimpaEditsVeiculos;
  pLimpaEditsRefComerciais;
  qryResumo.Close;

  btnCadFor.Enabled := True;
  btnCadTransportadora.Enabled := True;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodCli, dbeStatus, False)
  Else
    pHabilitaCodigo(dbeCodCli, dbeCodCli, True);

  If btnVenCli.Enabled Then
    btnVenCli.Enabled := False;

  If btnObsCli.Enabled Then
    btnObsCli.Enabled := False;

  If (fCfgSis('EMPGER', varBoolean)) Then
    dbeCodEmpRCF.Enabled := True
  Else
    dbeCodEmpRCF.Enabled := False;

  btnHeranca.Enabled := True;

  pHabilitaBotaoLimiteDeCredito(not blnLimCredAut);

  {******************************}
  { ROTINAS P\ ABA CONTATO       }
  {***************************JB*}
  cdsCliCtt.EmptyDataSet;
  dbgContatos.ReadOnly := False;
  pnlContatos.Enabled  := True;
  pnlAutCtt.Enabled    := True;
  grbLGPD.Enabled      := True;

  pHabilitarAbaSocios(True);
  pHabilitarAbaBeneficios(True);

  If Assigned(cdsCliVendedores) And cdsCliVendedores.Active Then
    cdsCliVendedores.EmptyDataSet;

  {Quadro Societário}
  If Assigned(cdsCadSco) And cdsCadSco.Active Then
    cdsCadSco.EmptyDataSet;

  If Assigned(cdsCliBen) And cdsCliBen.Active Then
    cdsCliBen.EmptyDataSet;

  If (Not Assigned(lstContatos)) Then
    lstContatos := TObjectList.Create(True);

  lstContatos.Clear;
  If (Assigned(objCliCtt)) Then
    FreeAndNil(objCliCtt);

  objCliCtt := TCliCtt.Create(Self);

  {******************************}
  { REFERENCIAS COMERCIAIS       }
  {***************************AC*}
  cdsCliRco.EmptyDataSet;
  dbgCliRco.ReadOnly := False;
  pnlRefComerciais.Enabled  := True;

  pnlQualificacao.Enabled := True;
  cxGridQuaCli.Enabled    := True;

  dbeValLim.Enabled := False;
  dbeDtDEPS.Enabled := False;

  If (Assigned(objCliRco)) Then
    FreeAndNil(objCliRco);

  objCliRco := TCliRco.Create(Self);

  {*************************************************}
  {* ROTINAS P\ ABA RELACIONAMENTO CLIENTE-PRODUTO *}
  {**********************************************RV*}
  If (blnCliPro) Then
  Begin
    pLimpaDadosProdutos;
    objCliPro.fRetProdutos('', cdsCliPro, dspCliPro, Nil);
  End;

  pnlProdutos.Enabled  := True;

  {***************************}
  {* ROTINAS P\ ABA VEICULOS *}
  {************************RV*}
  cdsCliVei.EmptyDataSet;
  dbgCliVei.ReadOnly := False;
  pnlCliVei.Enabled  := True;

  If (Not Assigned(lstVeiculos)) Then
    lstVeiculos := TObjectList.Create(True);

  lstVeiculos.Clear;
  If (Assigned(objCliVei)) Then
    FreeAndNil(objCliVei);

  objCliVei := TCliVei.Create(Self);

  pVerificaDireitosDadosRetencao;

  {***********************}
  {* PERMITE MI/FF (S/N) *}
  {********************RV*}
  If Not fVerificaAcessoSistema('PER_FF', strLoginUsuarioLogado) Then
    pnlPeMIFF.Enabled := False
  Else
    pnlPeMIFF.Enabled := True;

  dbeCoDeAc.Enabled := fVerificaAcessoSistema('ALTCODEAC', strLoginUsuarioLogado);
  dbeObserv.Enabled := fVerificaAcessoSistema('ALTOBS', strLoginUsuarioLogado);
  grbConsulta.Enabled := fVerificaAcessoSistema('ALTCCR', strLoginUsuarioLogado);

  dbeConsum.Enabled := fVerificaAcessoSistema('ALTECF', strLoginUsuarioLogado);

  edtVendedor.Text      := fRetNomVendRep(strVenInc);
  edtRepresentante.Text := fRetNomVendRep(strRepInc);

  dbePrStRe.Enabled := False;

  pCarregaCondicaoPagamento('');
  pCarregaCliDepProd('');
  pCarregaProfissional('');
  pCarregaDiaFixo;
  pCarregaDiaFixoMes;
  pCarregaDiaFixoEntFat;
  pCarregaDiaSemFat;
  pCarregaDiaSemEnt;
  pCarregaDiaVisitas;
  pHabilitaDiaFixo;
  pHabilitaControleData;
  pCarregaBairroAtende(qryTabela.FieldByName('CLI_CODCLI').AsString);
  pCarregaCidade(qryConCid, edtNomCid, edtEstado, dbeCodCid, dbeNumCep, strCepAnt);
  pCarregaPlanoDeContasPorEmpresa('CLINCO', dbeCodCli.Text, FcdsNCO);
  pOrgaoPublicoForaDoEstado;

  qryTabela.FieldByName('CLI_TIPATI').AsString := 'A';
  qryTabela.FieldByName('CLI_TIPLIM').AsString := 'D'; //Tipo Liminar DEFIT (Padrão)
  qryTabela.FieldByName('CLI_IESUNI').AsString := 'S';
  qryTabela.FieldByName('CLI_IVANAC').AsFloat  := 0;
  qryTabela.FieldByName('CLI_CEDNAC').AsFloat  := 0;
  qryTabela.FieldByName('CLI_DESPIS').AsString := 'N';
  qryTabela.FieldByName('CLI_BOLPAR').AsString := 'S';
  qryTabela.FieldByName('CLI_CALICM').AsString := 'N';
  qryTabela.FieldByName('CLI_BOLSEN').AsString := 'N';
  qryTabela.FieldByName('CLI_PROPER').AsString := 'N';
  qryTabela.FieldByName('CLI_LEILGP').AsString := 'N';
  qryTabela.FieldByName('CLI_TERACE').AsString := 'N';
  qryTabela.FieldByName('CLI_OBRPDC').AsString := 'N';
  qryTabela.FieldByName('CLI_REGDES').AsString := 'S';

  qryTabela.FieldByName('CLI_ALQPIS').AsFloat  := 0;
  qryTabela.FieldByName('CLI_ALQCOF').AsFloat  := 0;
  qryTabela.FieldByName('CLI_ALQIRF').AsFloat  := 0;
  qryTabela.FieldByName('CLI_ALQCSL').AsFloat  := 0;

  qryTabela.FieldByName('CLI_ALTECO').AsString := 'S';
  qryTabela.FieldByName('CLI_EXPECO').AsString := 'N';
  qryTabela.FieldByName('CLI_OBGPDL').AsString := 'N';

  If (fCfgSis('ENVBNC', varBoolean)) Then
    qryTabela.FieldByName('CLI_ENVBOL').AsString := 'S'
  Else
  qryTabela.FieldByName('CLI_ENVBOL').AsString := 'N';


  qryTabela.FieldByName('CLI_DTCOCB').AsDateTime  := Trunc(fNow());

  If Not fEmptyStr(fCfgSis('CTACLI')) Then
    qryTabela.FieldByName('CLI_CONCON').AsString := fCfgSis('CTACLI');

  qryTabela.FieldByName('CLI_INTCON').AsString := fCfgSis('APICON');

  dbeStReEs.Enabled := fVerificaAcessoSistema('CLASPS', strLoginUsuarioLogado);

  If Assigned(cdsCliVendedoresMar) And cdsCliVendedoresMar.Active Then
    cdsCliVendedoresMar.EmptyDataSet;

  If Assigned(cdsCliFNP) And cdsCliFNP.Active Then
    cdsCliFNP.EmptyDataSet;

  If Assigned(cdsCliMNP) And cdsCliMNP.Active Then
    cdsCliMNP.EmptyDataSet;

  btnConsultaFit.Glyph := Nil;
  ImageSefaz.GetBitmap(0, btnConsultaFit.Glyph);
  btnConsultaFit.Hint := 'Consulta Dados Cadastrais do CNPJ.';
  btnConsultaFit.Enabled := (dbeCgcCpf.Enabled);

  {Logs}
  pAddTabelasLog;

  {Carrega Condição de Pagamento}
  If tbsCliCnd.TabVisible Then
  Begin

    If fCfgSis('PAGATI') <> '' Then
    Begin

      If Not fCfgSis('USACND', VarBoolean) Then
      Begin
        mskConPag.Text := fCfgSis('PAGATI');
        fValidaCampos(mskConPag);
      End;
    End;

  End;

  {******************************}
  { ROTINAS P\ ABA PROFISSIONAIS }
  {******************************}
  strClienteProfissional := fCfgSis('PNVCLI');
  if not fEmptyStr(strClienteProfissional) then
  begin
    edtCodDiv.Text := strClienteProfissional;
    if fValidaCampos(edtCodDiv, True) then
      pIncluiProfissional;
  end;

  pAtualizaTributacao('CLI_SITP_C');
  pAtualizaTributacao('CLI_SITPCP');
  pAtualizaTributacao('CLI_SITIPI');

  dbeRetPCo.Enabled := not lblMsgRetImposto.Visible;
  dbeRetIrf.Enabled := not lblMsgRetImposto.Visible;
  dbeCDesPI.Enabled := not lblMsgRetImposto.Visible;
  dbeNire.Enabled := False;

  If Not fEmptyStr(fCfgSis('CLIFPG')) Then
  Begin
    qryTabela.FieldByName('CLI_CODFPG').AsString := fCfgSis('CLIFPG');
    pCarregaFormaPag;
  End;

  pDefineAlteracaoEndereco;

  cdsClaRECAP.EmptyDataSet;

  if cdsCadQualificacao.Active then
    cdsCadQualificacao.EmptyDataSet;

  pOrgaoPublicoForaDoEstado;
  pCarregaCliForMarNaoPermitidos('');
  qryTabela.FieldByName('CLI_BOLSEN').AsString := fCfgSis('SUGSEN');

  blnLiberouTravaCgcCPF := False;

  qryTabela.FieldByName('CLI_STANEO').AsString := '00';

  If pnlNeocredit.Visible Then
  Begin
    edtUltimaConsultaNeocredit.Clear;
    edtStatusConsultaNeocredit.Clear;
  End;
end;

procedure TfrmCadClientes.btnIncluirQuaCliClick(Sender: TObject);
var
  qryQualificacao : TUniQuery;
  strQualificacao: String;
  strLocate: String;
begin
  inherited;

  If fEmptyStr(edtCodQua.Text) Then
    Exit;

  strLocate := fStrLocate(edtCodQua, arrQualificacao, 'QUA_CODQUA', 'CODQUA');
  qryQualificacao := fCriarQuery('SELECT * FROM CADQUA WHERE TRUE ' + strLocate, Self);
  pSetaParam(edtCodQua.Text, arrQualificacao, strQualificacao, 'CODQUA', qryQualificacao);
  qryQualificacao.Open;

  If Not qryQualificacao.isEmpty Then
  Begin
    qryQualificacao.First;
    While Not qryQualificacao.Eof Do
    Begin
      If blnAltQuaCli Then
      Begin
        cdsCadQualificacao.Edit;
        cdsCadQualificacao.FieldByName('QUA_CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
        cdsCadQualificacao.FieldByName('QUA_CODQUA').AsString := edtCodQua.Text;
        cdsCadQualificacao.FieldByName('QUA_DESQUA').AsString := edtDesQua.Text;
        cdsCadQualificacao.FieldByName('QUA_OBSQUA').AsString := memoObservacao.Text;
        cdsCadQualificacao.FieldByName('QUA_CERQUA').AsString := iif(chkCertificado.checked, 'S', 'N');
        cdsCadQualificacao.Post;
      End
      Else
      If Not cdsCadQualificacao.Locate('AUTINC',qryQualificacao.FieldByName('AUTOINCREM').AsString, []) Then
      Begin
        cdsCadQualificacao.Append;
        cdsCadQualificacao.FieldByName('QUA_CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
        cdsCadQualificacao.FieldByName('AUTINC').AsString := qryQualificacao.FieldByName('AUTOINCREM').AsString;;
        cdsCadQualificacao.FieldByName('QUA_CODQUA').AsString := qryQualificacao.FieldByName('QUA_CODQUA').AsString;
        cdsCadQualificacao.FieldByName('QUA_DESQUA').AsString := qryQualificacao.FieldByName('QUA_DESQUA').AsString;
        cdsCadQualificacao.FieldByName('QUA_OBSQUA').AsString := memoObservacao.Text;
        cdsCadQualificacao.FieldByName('QUA_CERQUA').AsString := iif(chkCertificado.checked, 'S', 'N');
        cdsCadQualificacao.Post;
      End;
      qryQualificacao.Next;
    End;
    blnAltQuaCli := False;
    SetLength(arrQualificacao, 0);
    edtCodQua.Clear;
    edtDesQua.Clear;
    memoObservacao.Text := '';
    chkCertificado.Checked := False;
    cxGridQuaCli.Enabled := True;
    pSetFocus(edtCodQua);
  End;

  FreeAndNil(qryQualificacao);

end;

procedure TfrmCadClientes.btnGatWppClick(Sender: TObject);
var
  frmCfgWpp: TfrmCfgWpp;
begin
  inherited;
  if cdsCliCtt.IsEmpty then
    Exit;

  if fEmptyStr(cdsCliCtt.FieldByName('AUTOINCREM').AsString) then
  begin
    fMensagem('ATENÇÃO', 'Este contato ainda não está cadastrado, '+
                         'clique no botão gravar para efetuar a gravação dos contatos e, após esse procedimento, '+
                         'será possível definir os gatilhos de whatsapp para cada contato!', ['&OK']);
    Exit;
  end;

  pCriarFormularios(TfrmCfgWpp, frmCfgWpp);
  try
    frmCfgWpp.fCodigoGrupo('024');
    frmCfgWpp.strAutIncContato := cdsCliCtt.FieldByName('AUTOINCREM').AsString;
    frmCfgWpp.pnlInfo.Caption := 'Gatilhos de '+fRetNomeFormatado(cdsCliCtt.FieldByName('CLI_NOMCTT').AsString);
    frmCfgWpp.ShowModal;
  finally
    pFreeAndNil(frmCfgWpp);
  end;
end;

procedure TfrmCadClientes.btnGravarCCClick(Sender: TObject);
begin
  If fValidaCamposCCCLIE(edtCodEmp, False) Then
  Begin
    If strStatusContaContabil = 'INSERT' Then
    Begin
      If Not fEmptyStr(strNomEmp) Then
        pEnviaGravacao
      Else
        fMensagem('', 'Esta empresa não está cadastrada!', ['&OK']);
    End
    Else If strStatusContaContabil = 'UPDATE' Then
    Begin
      If Not fEmptyStr(strNomEmp) Then
        pEnviaEdicao
      Else
        fMensagem('', 'Esta empresa não está cadastrada!', ['&OK']);
    End;
  End;

  pControlaBotoes;

  pCarregaGridEmpCli;

  pSetFocus(grdEmpCli);
end;

procedure TfrmCadClientes.pGravaintegracaoContele;
var
  qryIntCon: TUniQuery;
begin
  if qryTabela.State = dsInsert then
    Exit;

  qryIntCon := fCriaQuery(Self);
  try
    qryIntCon.Close;
    qryIntCon.SQL.Text :=
    ' UPDATE '+
    '   CADCLI '+
    ' SET '+
    '   CLI_INTCON = "S" '+
    ' WHERE '+
    '   AUTOINCREM = :AUTINC ';

    qryIntCon.ParamByName('AUTINC').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryIntCon.ExecSQL;
  finally
    FreeAndNil(qryIntCon);
  end;
end;

procedure TfrmCadClientes.btnGravarClick(Sender: TObject);
Var
  intContador    : Integer;
  strCampo       : String;
  dtsEstado      : TDataSetState;
  strInforAntC   : String;
  strInforNovC   : String;
  fltInforAntN   : Double;
  fltInforNovN   : Double;
  blnGravouDados : Boolean;
  blnInsert      : Boolean;
  Obj            : TCliRco;
  objCliSco      : TCliSco;
  blnAtuRedeLoj  : Boolean;
  intDiaMes      : Integer;
  blnAlterouUFDoCadastro   : Boolean;
  blnIntegrarContele: Boolean;
begin

  blnGravouDados := False;
  blnAlterouUFDoCadastro := (fRetEstadoCliente(qryTabela.FieldByName('CLI_CODCLI').AsString) <> edtEstado.Text);
  if (blnAlterouUFDoCadastro) And (fCliForFaturamento('C',dbeCodCli.Text)) and (fCfgSis('PEALUF') = 'N') Then
  begin
    pMensagemOk('Atenção! Não é permitido alterar o estado pois existe movimentações para este Cliente.');
    Exit;
  end;

  if (dbeCgcCpf.Text = '1') and (not fVerificaAcessoSistema('ALTPJU', strLoginUsuarioLogado)) then
  begin
    pMensagemOk('Usuário sem permissão para incluir ou alterar cliente do tipo pessoa jurídica!');
    Exit;
  end;

  if (dbeCgcCpf.Text = '2') and (not fVerificaAcessoSistema('ALTPFI', strLoginUsuarioLogado)) then
  begin
    pMensagemOk('Usuário sem permissão para incluir ou alterar cliente do tipo pessoa física!');
    Exit;
  end;

  if (fCfgSis('OBPRCC', varBoolean)) and (cdsCliDiv.IsEmpty) then
  begin
    pMensagemOk('ATENÇÃO! O sistema está configurado para tornar obrigatório informar Profissional no Cadastro de Clientes - CFG_OBPRCC?.' + #13 +
                'Informe pelo menos um profissional e depois, grave novamente o cadastro.');
    pSetFocus(edtCodDiv);
    Exit;
  end;

  If (fCfgSis('CFOBSI', varBoolean)) And (dbeConsum.Text <> 'S') Then
  Begin
    If (dbeCgcCpf.Text = '2')  Or ((dbeCgcCpf.Text = '1') And (fEmptyStr(dbeNumIes.Text))) Then
    Begin
      pMensagemOk('ATENÇÃO! O Campo Consumidor Final deve ser "Sim"!');
      pSetFocus(dbeConsum);
      Exit;
    End;
  End;

  if not fVerificarPlanoDeContasPorEmpresa(dbeCodCli.Text, 'CLINCO', dbePlaNco.Text, FcdsNCO) then
  begin
    exit ;
  end;

  Self.Enabled := False;
  Try
    blnChangeEnabledButton := False;

    blnIntegrarContele := fEhNecessarioIntegrarContele;

    pCarregaCidade(qryConCid, edtNomCid, edtEstado, dbeCodCid, dbeNumCep, strCepAnt);

    fltInforAntN := 0;
    fltInforNovN := 0;

    strCampo    := '';
    dtsEstado   := qryTabela.State;

    If (dtsEstado = dsInsert) Then
      qryTabela.FieldByName('CLI_OPECAD').AsString   := strLoginUsuarioLogado;

    qryTabela.FieldByName('CLI_DESMEM').AsString  := IfThen(dbchkDesmembr.Checked , 'S', 'N');

    If fEmptyStr(qryTabela.FieldByName('CLI_CRMFRE').AsString) Then
      qryTabela.FieldByName('CLI_CRMFRE').Clear;

    If fEmptyStr(qryTabela.FieldByName('CLI_CRMFAI').AsString) Then
      qryTabela.FieldByName('CLI_CRMFAI').Clear;

    If fEmptyStr(qryTabela.FieldByName('CLI_CRMPOR').AsString) Then
      qryTabela.FieldByName('CLI_CRMPOR').Clear;

    If fEmptyStr(qryTabela.FieldByName('CLI_CRMCAT').AsString) Then
      qryTabela.FieldByName('CLI_CRMCAT').Clear;

    If (fEmptyStr(dbeUltCom.Text)) Then
      qryTabela.FieldByName('CLI_ULTCOM').AsVariant := Null;

    If (fEmptyStr(dbePriCom.Text)) Then
      qryTabela.FieldByName('CLI_PRICOM').AsVariant := Null;

    If (fEmptyStr(dbeDtaNas.Text)) Then
      qryTabela.FieldByName('CLI_NASCIM').AsVariant := Null;

    If (fEmptyStr(dbeDtmCom.Text)) Then
      qryTabela.FieldByName('CLI_DTMCOM').AsVariant := Null;

    If Not (qryInfCre.State In [dsInsert, dsEdit]) Then
      qryInfCre.Edit;

    If (fEmptyStr(dbeNasCon.Text)) Then
      If blnCrediario Then
      qryInfCre.FieldByName('CLI_NASCON').AsVariant := Null;

    If (fEmptyStr(VS_strCodEmp)) Then
      qryTabela.FieldByName('CLI_CODEMP').AsVariant := Null;

    If (fEmptyStr(dbeCodFpg.Text)) Then
      qryTabela.FieldByName('CLI_CODFPG').AsVariant := Null;

    If (fEmptyStr(dbeCorres.Text)) Then
      qryTabela.FieldByName('CLI_CORRES').AsVariant := Null;

    {********************************}
    {* CANAL DE ACESSO, DEIXAR NULO *}
    {**28/02/2011-11:57***********DP*}
    If (fEmptyStr(edtCadCac.Text)) Then
      qryTabela.FieldByName('CLI_CODCAC').AsVariant := Null;

    If fEmptyStr(dbeCidCob.Text) Then
      dbeCidCob.Field.Value := Null;

    If fEmptyStr(dbeCodPor.Text) Then
      dbeCodPor.Field.Value := Null;

    If fEmptyStr(dbeSupGer.Text) Then
      dbeSupGer.Field.Value := Null;

    If fEmptyStr(dbeSupReg.Text) Then
      dbeSupReg.Field.Value := Null;

    If fEmptyStr(dbeCodReg.Text) Then
      dbeCodReg.Field.Value := Null;

    If fEmptyStr(dbeCodSub.Text) Then
      dbeCodSub.Field.Value := Null;

    If fEmptyStr(edtRgExp.Text) Then
      qryTabela.FieldByName('CLI_RG_EXP').Clear
    Else
      qryTabela.FieldByName('CLI_RG_EXP').AsString := edtRgExp.Text + '-' + cbxRgEst.Text;

    If cmbTipoPesquisa.ItemIndex > 0 then
      qryTabela.FieldByName('CLI_CODCON').AsString := cmbTipoPesquisa.ItemIndex.ToString()
    Else
      qryTabela.FieldByName('CLI_CODCON').Value := Null;

    If cmpTipoCreditoBV.ItemIndex > 0 then
      qryTabela.FieldByName('CLI_TIPCBV').AsString := cmpTipoCreditoBV.ItemIndex.ToString()
    Else
      qryTabela.FieldByName('CLI_TIPCBV').Value := Null;

    If cbProdutoSerasa.ItemIndex > 0 then
      qryTabela.FieldByName('CLI_PROSER').AsString := cbProdutoSerasa.ItemIndex.ToString()
    Else
      qryTabela.FieldByName('CLI_PROSER').Value := Null;

    qryTabela.FieldByName('CLI_ENTRET').AsInteger := cbbDestino.ItemIndex;


    If blnCrediario Then
    Begin
      qryInfCre.FieldByName('CLI_SEXO__').Clear;

      If cbxSexo.ItemIndex > -1 Then
        qryInfCre.FieldByName('CLI_SEXO__').AsString := ARR_SEXO[cbxSexo.ItemIndex][1];

      qryInfCre.FieldByName('CLI_CASAPR').Clear;

      If cbxMoradia.ItemIndex > -1 Then
        qryInfCre.FieldByName('CLI_CASAPR').AsString := ARR_MORADIA[cbxMoradia.ItemIndex][1];

      qryInfCre.FieldByName('CLI_ESTCIV').Clear;

      If cbxEstCiv.ItemIndex > -1 Then
        qryInfCre.FieldByName('CLI_ESTCIV').AsString := ARR_ESTADOCIVIL[cbxEstCiv.ItemIndex][1];

      qryInfCre.FieldByName('CLI_ESCOLA').Clear;

      If cbxEscolaridade.ItemIndex > -1 Then
        qryInfCre.FieldByName('CLI_ESCOLA').AsString := ARR_ESCOLARIDADE[cbxEscolaridade.ItemIndex][1];

      If fEmptyStr(dbeAvalis.Text) Then
        qryInfCre.FieldByName('CLI_AVALIS').Value := Null;

      If fEmptyStr(dbeNacion.Text) Then
        qryInfCre.FieldByName('CLI_NACION').Value := Null;

      If fEmptyStr(dbeNatura.Text) Then
        qryInfCre.FieldByName('CLI_NATURA').Value := Null;
    End;

    If (fEmptyStr(dbeEnqIPI.Text)) Then
      qryTabela.FieldByName('CLI_ENQIPI').Value := Null;

    if (Not fCfgSis('MLTCND', varBoolean)) And (fQtdeChecados(lstDiaMes) <> 0) And  (fQtdeChecados(lstDiaFix) <> 0) then
    begin
      For intDiaMes := 0 To 30 Do
        lstDiaMes.Checked[intDiaMes] := False;
    end;

    If (fEmptyStr(dbeCalIcm.Text)) Then
      qryTabela.FieldByName('CLI_CALICM').AsString := 'N';

    If (fEmptyStr(dbeMotDes.Text)) and (dbeOrgPub.Text = 'N') Then
      qryTabela.FieldByName('CLI_MOTDES').AsString := '9';

    pGravaDiaFixo;
    pGravaDiaFixoMes;
    pGravaDiaVisitas;
    pGravarPlanoContasAutomatico(qryTabela, dbePlaNco, 'CLI_PLANCO', dbeNomCli.Text);
    pGravaDiaSemFat;
    pGravaDiaSemEnt;
    pGravaDiaFixoMesEntFat;

    If (blnCadastroModificado) Then Begin
      qryTabela.FieldByName('CLI_DTAALT').AsDateTime := VS_Date + fTime();
      qryTabela.FieldByName('CLI_CODOPE').AsString   := strLoginUsuarioLogado;
    End;

    if not fValidarFalhaCadastralDeMultiplosDescontosNaNota then
      exit;
	
    If Not fTemCondicaoSugerida Then
    Begin
      pSetFocus(tbsCliCnd);
      pSetFocus(cxgConPag);

      pMensagemOk('Informe a condição de pagamento que será sugerida no faturamento!');
      Exit;
    End;

    blnVerificarCgcCPF := (fCfgSis('VERCGC') <> 'L') or (not blnLiberouTravaCgcCPF);

    {Req: 94765
     A função "fVerificaCampos" deve ser executada antes de "fValidaCampos(pnlEntregas, True)",
     pois lá é executada "pAtualizaEnderecoPadraoEntrega" e se algum campo estiver "vazio"
     pode ser gerado uma instrução de update setando campos obrigatórios para NULL da tabela "ENTCLI",
     e gravando esses comandos na "LOGGER" pode gerar falhas na replicação. Um exemplo da falha era
     apagar por exemplo o código da cidade do cliente!.
    }
    If (Not fValidacoesBotaoGravarPai) Then
      Exit;

    If Not fValidaCampos(pnlEntregas, True) Then
    Begin
      pgcDados.ActivePage := tbsEntregas;
      Exit;
    End;

    pHabilitaCampoAtoDeclaratorioDF;

    If Not fValidaCampos(pnlFazendas, True) Then
    Begin
      pgcDados.ActivePage := tbsFazendas;
      Exit;
    End;

    if not fValidaCndCli('') then
      Exit;

    blnAtuRedeLoj := False;
    If (pnlGrupoRisco.Visible) And
       (strCodGrupoRisco <> qryTabela.FieldByName('CLI_CODGRR').AsString) And
       (Not qryTabela.FieldByName('CLI_CODRED').IsNull) Then
    Begin
      If fMensagem('Atenção', 'Você alterou o grupo de risco do cliente e este cliente ' +
                              'pertence a uma rede de lojas. Este mesmo grupo de risco ' +
                              'será aplicado a todos os clientes da rede. Deseja continuar?',
                   ['&Sim', '%Não']) = 1 Then
        blnAtuRedeLoj := True
      Else
        Exit;
    End;

    btnAdicionar.Enabled := False;
    grdEmpresaPrioridade.Enabled := False;
    grbLGPD.Enabled := False;

    {NÃO ALTERAR A POSIÇÃO DESSA LINHA}
    blnInsert := (qryTabela.State in ([dsInsert]));

    If (blnInsert) And (blnLimCredAut) Then
      pAtribuiLimiteDeCreditoAuto;

    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

    If fTiraCaracEspeciais(dbePlanco.Field.AsString) = '' Then
      dbePlanco.Field.Clear;

    cdsClaRECAP.Filtered := False;
    cdsClaRECAP.Filter   := 'OPERAC<>''D''';
    cdsClaRECAP.Filtered := True;

    if (qryTabela.FieldByName('CLI_RECAP_').AsString = 'S') and (cdsClaRecap.IsEmpty) then
    begin
      fMensagem('ATENÇÃO!', 'Para ativar o Benefício Fiscal RECAP é preciso definir o NCM dos produtos através ' +
                            'do botão "Definir Classificação de IPI / NCM - RECAP" antes de gravar o cadastro.', ['&Ok']);
      pSetFocus(dbeRECAP_);
      Exit;
    end;

    Try
      inherited;
      blnGravouDados := blnGravou;

      If blnGravou Then
      Begin
        If blnPreencherClubeFidelidadeComProprioCliente Then
        Begin
          qryTabela.Edit;
          qryTabela.FieldByName('CLI_CLIFID').AsString := dbeCodCli.Text;
          qryTabela.Post;
          pCarregaCliFid;
        End;

        pSalvaPlanoDeContasPorEmpresa('CLINCO', dbeCodCli.Text, FcdsNCO) ;
        pGravarPlanoContasAutomaticoParaCadaEmpresa(qryTabela, dbePlaNco, 'CLI_PLANCO', dbeNomCli.Text);

        If VS_strHabilitarCRM Then
          fGravaFornecedor;

        pGravaHraSemEnt;
        pGravarQualificacao;
        pAtualizaTipAbf;
        pAtualizaEnderecoEntrega(True);
        pAtualizaFazendas(True);

        pGravaCondicaoPagamento;
        pGravaCliDepProd;

        pGravaProfissional;
        pGravaClassificacoesRECAP;

        if (tbsPrioridadeSaidaEstoque.Visible) then
        begin
          pGravaEmpresaPrioridade;
        end;

        pInsereRegEmpCli_Heranca;

        pGravaAlteracoesParticipante(dtsEstado, strNomAnt, strCidAnt, strCgcAnt,
          strIesAnt, strSufAnt, strEndAnt, strNumAnt, strComAnt, strBaiAnt);

        pSalvaCliBat;

        {***********************************}
        { GRAVA DADOS DA ABA CONTATO        }
        {********************************JB*}
        If (Assigned(lstContatos)) Then
          blnGravouDados := fGravarContatosCliente();

        {Grava dados da aba "Quadro Societário"}
        If (blnGravouDados) Then
        Begin

          pLimpaEditsQuadroSocietario;

          Try

            TCliSco.pApagarCadSco(qryTabela.FieldByName('CLI_CODCLI').AsString);

            If Not cdsCadSco.IsEmpty Then
            Begin

              cdsCadSco.First;

              While Not cdsCadSco.Eof Do
              Begin

                objCliSco := TCliSco.Create(Self);

                If (Not fEmptyStr(cdsCadScoAUTOINCREM.AsString)) Then
                  objCliSco.strAutoincrem := cdsCadScoAUTOINCREM.AsString
                Else
                  objCliSco.strAutoincrem := '';

                objCliSco.strCodCli := qryTabela.FieldByName('CLI_CODCLI').AsString;
                objCliSco.strNomSco := cdsCadScoSCO_NOMSCO.AsString;

                If Not fEmptyStr(cdsCadScoSCO_PF_PJ_.AsString) Then
                  objCliSco.strPF_PJ_ := cdsCadScoSCO_PF_PJ_.AsString;

                If Not fEmptyStr(cdsCadScoSCO_CPFCNP.AsString) Then
                  objCliSco.strCpfCnp := cdsCadScoSCO_CPFCNP.AsString;

                If Not fEmptyStr(cdsCadScoSCO_NUM_RG.AsString) Then
                  objCliSco.strNum_RG := cdsCadScoSCO_NUM_RG.AsString;

                If fDataValida(cdsCadScoSCO_DTANAS.AsDateTime) Then
                  objCliSco.dtaDtaNas := cdsCadScoSCO_DTANAS.AsDateTime;

                If Not fEmptyStr(cdsCadScoSCO_ESTCIV.AsString) Then
                  objCliSco.strEstCiv := cdsCadScoSCO_ESTCIV.AsString;

                If (cdsCadScoSCO_PER_PS.AsFloat > 0) Then
                  objCliSco.fltPer_Ps := cdsCadScoSCO_PER_PS.AsFloat;

                Try

                  objCliSco.pGravarCliSco;

                  If fEmptyStr(cdsCadScoAUTOINCREM.AsString) Then
                  Begin
                    cdsCadSco.Edit;
                    cdsCadScoAUTOINCREM.AsString := objCliSco.strAutoincrem;
                    cdsCadSco.Post;
                  End;

                Finally
                  FreeAndNil(objCliSco);
                End;

                cdsCadSco.Next;

              End;

            End;

          Except
            On E: Exception Do
            Begin
              blnGravouDados := False;
              fRollBack;
              pCarregaSocios(qryTabela.FieldByName('CLI_CODCLI').AsString);
              pMensagensErro(E.Message,'[TfrmCadClientes.btnGravarClick]');
            End;
          End;
        End;

        {*************************************}
        { GRAVA DADOS DA ABA BENEFÍCIO FISCAL }
        {**********************************BZ*}
        If (blnGravouDados) Then
        Begin
          blnGravouDados := fGravaBeneficios(qryTabela.FieldByName('CLI_CODCLI').AsString);
        End;

        {*******************************************}
        { GRAVA DADOS DA ABA REFERENCIAS COMERCIAIS }
        {****************************************AC*}
        If (blnGravouDados) Then
        Begin
          Try

            pLimpaEditsRefComerciais;
            TCliRco.pApagarCadRco(qryTabela.FieldByName('CLI_CODCLI').AsString);

            if not cdsCliRco.IsEmpty then
            begin

              cdsCliRco.First;
              while not cdsCliRco.Eof do
              begin

                Obj := TCliRco.Create(Self);

                {}
                if (not fEmptyStr(cdsCliRco.FieldByName('AUTINC').AsString)) then
                  Obj.strAutInc := cdsCliRco.FieldByName('AUTINC').AsString
                else
                  Obj.strAutInc := '';

                Obj.strCodCli := qryTabela.FieldByName('CLI_CODCLI').AsString;
                Obj.strNomEmp := cdsCliRco.FieldByName('EMPRCO').AsString;
                Obj.strCgcCpf := cdsCliRco.FieldByName('CGCCPF').AsString;
                Obj.strCgcEmp := cdsCliRco.FieldByName('CGCEMP').AsString;
                Obj.strTelEmp := cdsCliRco.FieldByName('TELEMP').AsString;
                Obj.strConEmp := cdsCliRco.FieldByName('CONEMP').AsString;
                Obj.strEmaEmp := cdsCliRco.FieldByName('EMAIL_').AsString;
                Obj.strDtaCon := cdsCliRco.FieldByName('DTACON').AsDateTime;
                Obj.strNomInf := cdsCliRco.FieldByName('NOMINF').AsString;
                Obj.strDtaPco := cdsCliRco.FieldByName('DTAPCO').AsDateTime;
                Obj.strValPco := cdsCliRco.FieldByName('VALPCO').AsFloat;
                Obj.strDtaMco := cdsCliRco.FieldByName('DTAMCO').AsDateTime;
                Obj.strValMco := cdsCliRco.FieldByName('VALMCO').AsFloat;
                Obj.strDtaUco := cdsCliRco.FieldByName('DTAUCO').AsDateTime;
                Obj.strValUco := cdsCliRco.FieldByName('VALUCO').AsFloat;
                Obj.strCodOpe := cdsCliRco.FieldByName('CODOPE').AsString;

                try

                  Obj.pInsereCliRco;

                  {Ao inserir novo registro, alimenta autoinc no retorno
                   para evitar geração de autoinc novo e "confundir logs"}
                  if (fEmptyStr(cdsCliRco.FieldByName('AUTINC').AsString)) then
                  begin
                    cdsCliRco.Edit;
                    cdsCliRco.FieldByName('AUTINC').AsString := Obj.strAutInc;
                    cdsCliRco.Post;
                  end;

                finally
                  FreeAndNil(Obj);
                end;

                cdsCliRco.Next;

              end;

            end;

            dbgCliRco.ReadOnly        := True;
            pnlRefComerciais.Enabled  := False;
            pnlQualificacao.Enabled   := False;
            cxGridQuaCli.Enabled      := False;

          Except
            On E: Exception Do
            Begin
              blnGravouDados := False;
              fRollBack;
              pCarregaRefComerciais(qryTabela.FieldByName('CLI_CODCLI').AsString);
              pMensagensErro(E.Message,'[TfrmCadClientes.btnGravarClick]');
            End;
          End;
        End;

        If blnVendAlt And blnGravouDados Then
        Begin

          {***************************************}
          { ALTERA VEND. DO CLIENTE NO TELEATEND. }
          {************************************IV*}
          Try

            blnGravouDados := fExecutaSQL( ' UPDATE AGETEL SET AGE_CODVEN = "'  + qryTabela.FieldByName('CLI_CODVEN').AsString +
                                           '" WHERE AGE_CODCLI = "' + qryTabela.FieldByName('CLI_CODCLI').AsString +
                                           '" AND AGE_DTABAI IS NULL' );
          Except
            On E: Exception Do
            Begin
              blnGravouDados := False;
              fRollBack;
              pMensagensErro(E.Message,'[TfrmCadClientes.btnGravarClick]');
            End;
          End;

        End;

        {*****************************************************}
        {* GRAVA DADOS DA ABA RELACIONAMENTO CLIENTE-PRODUTO *}
        {**************************************************RV*}
        If (blnCliPro) And blnGravouDados Then
        Begin
          Try
            pCriarFormularios(TfrmGravando,frmGravando);
            frmGravando.strChave := 'PRODUTOS RELACIONADOS';
            frmGravando.fExecutarAcao := fGravaProdRelacionados;
            frmGravando.ShowModal;
            blnGravouDados := frmGravando.blnConfirma;
          Finally
            pFreeAndNil(frmGravando);
          End;
        End;

        {*****************************************************}
        {* GRAVA DADOS DA ABA RELACIONAMENTO CLIENTE-PRODUTO *}
        {**************************************************RV*}
        If (Assigned(lstVeiculos)) And blnGravouDados Then
        Begin
          Try
            pLimpaEditsVeiculos;
            TCliVei.pApagarCliVei(qryTabela.FieldByName('CLI_CODCLI').AsString);
            For intContador := 0 To lstVeiculos.Count -1 Do
            Begin
              TCliVei(lstVeiculos[intContador]).strCodCli := qryTabela.FieldByName('CLI_CODCLI').AsString;
              TCliVei(lstVeiculos[intContador]).pInsereCliVei;
            End;
            dbgCliVei.ReadOnly := True;
            pnlCliVei.Enabled  := False;

          Except
            On E: Exception Do
            Begin
              blnGravouDados := False;
              fRollBack;
              pCarregaVeiculos(qryTabela.FieldByName('CLI_CODCLI').AsString);
              pMensagensErro(E.Message,'[TfrmCadClientes.btnGravarClick]');
            End;
          End;
        End;

        With cdsCliVendedoresMar Do
        Begin

          If (Not IsEmpty) And blnGravouDados Then
          Begin

            Try
              If Not fGravaVendedor Then
                blnGravouDados := False;
            Except
              On E: Exception Do
              Begin
                blnGravouDados := False;
                pMensagensErro(E.Message,'[TfrmCadClientes.btnGravarClick]');
              End;
            End;

          End Else Begin
            pExcluiVendAnteriores(qryTabela.FieldByName('CLI_CODCLI').AsString);
          End;

        End;

        If blnGravouDados Then
        Begin
          Try
            blnGravouDados := fGravaForMarNaoPermitidos;
          Except
            On E: Exception Do
            Begin
              blnGravouDados := False;
              fRollBack;
              pMensagensErro(E.Message,'[TfrmCadClientes.btnGravarClick]');
            End;
          End;
        end;

        If ((strLimCre <> FloatToStr(qryTabela.FieldByName('CLI_LIMCRE').AsFloat)) Or
            (strTipCli <> qryTabela.FieldByName('CLI_TIPCLI').AsString)) And (dtsEstado = dsEdit) And blnGravouDados Then
        Begin

          For intContador := 1 To IIF(pnlTipCli.Visible, 2, 1) Do
          Begin

            If intContador = 1 Then
            Begin
              If (strLimCre <> FloatToStr(qryTabela.FieldByName('CLI_LIMCRE').AsFloat)) Then
                strCampo := 'CLI_LIMCRE'
              Else
                strCampo := '';
            End
            Else
            Begin
              If (strTipCli <> qryTabela.FieldByName('CLI_TIPCLI').AsString) Then
                strCampo := 'CLI_TIPCLI'
              Else
                strCampo := '';
            End;

            Case intContador Of
              1: Begin
                strInforAntC := '';
                strInforNovC := '';
                fltInforAntN := fStrToFloat(strLimCre);
                fltInforNovN := qryTabela.FieldByName('CLI_LIMCRE').AsFloat;
              End;
              2: Begin
                strInforAntC := strTipCli;
                strInforNovC := qryTabela.FieldByName('CLI_TIPCLI').AsString;
                fltInforAntN := 0;
                fltInforNovN := 0;
              End;
            End;

            If strCampo <> '' Then
              blnGravouDados := fGeraLogLimiteStatusCliente(qryTabela.FieldByName('CLI_CODCLI').AsString,
                                                            VS_Date,
                                                            fTime(),
                                                            IfThen(intContador = 1, strOpeLibLimCre,
                                                                   IIF(fEmptyStr(strOpeAlt[3]), strLoginUsuarioLogado, strOpeAlt[3])),
                                                            strCampo,
                                                            strInforAntC,
                                                            strInforNovC,
                                                            fltInforAntN,
                                                            fltInforNovN,
                                                            False);
          End;

        End;

        If ((strCodVen <> qryTabela.FieldByName('CLI_CODVEN').AsString)  Or
            (strStaCli <> qryTabela.FieldByName('CLI_STATUS').AsString)  Or
            (intAtrMax <> qryTabela.FieldByName('CLI_ATRMAX').AsInteger) Or
            (strCodRep <> qryTabela.FieldByName('CLI_CODREP').AsString)) And
            blnGravouDados Then
        Begin

          For intContador := 1 To 4 Do
          Begin

            If (intContador = 1) Then
            Begin
              If (strCodVen <> qryTabela.FieldByName('CLI_CODVEN').AsString) Then
                strCampo := 'CLI_CODVEN'
              Else
                strCampo := '';
            End
            Else If (intContador = 2) Then
            Begin
              If (strCodRep <> qryTabela.FieldByName('CLI_CODREP').AsString) Then
                strCampo := 'CLI_CODREP'
              Else
                strCampo := '';
            End
            Else If intContador = 3 Then
            Begin
              If (strStaCli <> qryTabela.FieldByName('CLI_STATUS').AsString) Then
                strCampo := 'CLI_STATUS'
              Else
                strCampo := '';
            End
            Else If intContador = 4 Then
            Begin
              If (intAtrMax <> qryTabela.FieldByName('CLI_ATRMAX').AsInteger) Then
                strCampo := 'CLI_ATRMAX'
              Else
                strCampo := '';
            End;

            Case intContador Of
              1: Begin
                strInforAntC := strCodVen;
                strInforNovC := qryTabela.FieldByName('CLI_CODVEN').AsString;
                fltInforAntN := 0;
                fltInforNovN := 0;
              End;
              2: Begin
                strInforAntC := strCodRep;
                strInforNovC := qryTabela.FieldByName('CLI_CODREP').AsString;
                fltInforAntN := 0;
                fltInforNovN := 0;
              End;
              3: Begin
                strInforAntC := strStaCli;
                strInforNovC := qryTabela.FieldByName('CLI_STATUS').AsString;
                fltInforAntN := 0;
                fltInforNovN := 0;
              End;
              4: Begin
                strInforAntC := '';
                strInforNovC := '';
                fltInforAntN := intAtrMax;
                fltInforNovN := qryTabela.FieldByName('CLI_ATRMAX').AsInteger;
              End;
            End;

            If (strCampo <> '') Then
              blnGravouDados := fGeraLogLimiteStatusCliente(qryTabela.FieldByName('CLI_CODCLI').AsString,
                                                            VS_Date,
                                                            fTime(),
                                                            IIF(fEmptyStr(strOpeAlt[intContador - 1]), strLoginUsuarioLogado, strOpeAlt[intContador - 1]),
                                                            strCampo,
                                                            strInforAntC,
                                                            strInforNovC,
                                                            fltInforAntN,
                                                            fltInforNovN,
                                                            False);
            strOpeAlt[intContador - 1] := '';
          End;

        End;

        If blnGravouDados Then
        Begin
          Try
            If (qryCadFic.State = dsInactive) Or (qryCadFic.State = dsBrowse) Then
            Begin
              qryCadFic.Active := True;
              qryCadFic.Edit;
            End;

            qryCadFic.FieldByName('FIC_CODCLI').AsString := dbeCodCli.Text;

            If (Not fEmptyStr(qryCadFic.FieldByName('FIC_CODCLI').AsString)) Then
              qryCadFic.Post
            Else
              qryCadFic.Cancel;
          Except
            On E: Exception Do
            Begin
              blnGravouDados := False;
              fRollBack;
              pMensagensErro(E.Message,'[TfrmCadClientes.btnGravarClick]');
            End;
          End;
        End;

        If blnCrediario And blnGravouDados Then
        Begin
          If (qryInfCre.State = dsInactive) Or (qryInfCre.State = dsBrowse) Then
          Begin
            qryInfCre.Active := True;
            qryInfCre.Edit;
          End;

          qryInfCre.FieldByName('CLI_CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;

          If (dbeNasCon.Text = '  /  /    ') Or fEmptyStr(dbeNasCon.Text) Then
            qryInfCre.FieldByName('CLI_NASCON').AsVariant := Null;

          If (dbeTemSer.Text = '  /  /    ') Or fEmptyStr(dbeTemSer.Text) Then
            qryInfCre.FieldByName('CLI_TEMSER').AsVariant := Null;

          qryInfCre.Post;
        End;

        If (tshEmbarcacoes.TabVisible) And (blnGravouDados) Then Begin
          blnGravouDados := fSalvarEmbarcacoesCliente();
        End;

        If blnGravouDados And blnAtuRedeLoj Then
        Begin
          blnGravouDados := fAtualizaGrupoRiscoNaRede(qryTabela.FieldByName('CLI_CODGRR').AsString,
                                                      qryTabela.FieldByName('CLI_ATRMAX').AsInteger,
                                                      qryTabela.FieldByName('CLI_CODRED').AsString);
        End;

        {Gravar Logs}
        if (blnGravouDados) then
          if Assigned(LogAltCadCli) then
          begin
            if (blnInsert) then
              LogAltCadCli.pProcessarLogs(' = ' + QuotedStr(qryTabela.FieldByName('CLI_CODCLI').AsString))
            else
              LogAltCadCli.pProcessarLogs;
          end;

        pgcDados.ActivePageIndex := 0;

        lstDiaFix.Enabled := False;
        lstDiaMes.Enabled := False;

        lstDiaSemPerFat.Enabled := False;
        lstDiaMesPerFat.Enabled := False;
        lstDiaMesPerEnt.Enabled := False;
        cxgDiaSemEnt.Enabled := False;

        blnGravou := False;

        If blnGravouDados Then
        Begin
          if blnTemDivergenciaSefaz then
            pSalvaDataConsultaSefaz('CADCLI', 'CLI_DTASEF', qryTabela.FieldByName('AUTOINCREM').AsString, fRetDataServidor);

          fCommit;
          blnJahLiberouFormaPagto := False;
          blnJahLiberouPortador   := False;
          blnJahLiberouPortador2  := False;
        End
        Else
          fRollBack;

        btnCadFor.Enabled := False;
        btnCadTransportadora.Enabled := False;

        If (blnCadContato) Then
          btnSair.Click();

        blnCadastroModificado := False;

        If fCfgSis('UTILGP', varBoolean) And (dbeLeiLGP.Text = 'N') Then
        Begin
          If fMensagem('ATENÇÃO!', 'Enviar Termo de Consentimento (LGPD)?', ['&Sim', '&Não'],2) = 1 Then
          Begin
            btnFichaCliClick(Nil);

            If fMensagem('ATENÇÃO!', 'Deseja alterar a liberação para lei LGPD?', ['&Sim', '&Não'],2) = 1 Then
            Begin
              btnAlterarClick(Self);
              pgcDados.ActivePage := tbsGeral2;
              pSetFocus(dbeLeiLGP);
            End;
          End;
        End;

        if blnIntegrarContele then
          pGravaIntegracaoContele;
      End
      Else
        fRollBack;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message,'[TfrmCadClientes.btnGravarClick]');
      End;
    End;

  Finally
    blnChangeEnabledButton := True;
    pOnStateChange;

    pCarregaContatos(qryTabela.FieldByName('CLI_CODCLI').AsString);
    pCarregaResumo(qryTabela.FieldByName('CLI_CODCLI').AsString, fRetDesTipoAbf('C', qryTabela.FieldByName('CLI_CODCLI').AsString));

    if (blnGravouDados) and (blnEnviaContatoCitelDesk) then
      TfrmGravando.fExecutarModal(pEnviaContatoCitelDesk, 'Enviando contato - Whatsapp...', '');

    btnHeranca.Enabled := False;

    pHabilitaBotoesAdicionais;
    pCarregaOperador;
    pCarregaEmpresaPrioridade;
    pOrgaoPublicoForaDoEstado;

    pAtualizaTributacao('CLI_SITP_C');
    pAtualizaTributacao('CLI_SITPCP');
    pAtualizaTributacao('CLI_SITIPI');
    btnConsultaFit.Enabled := False;
    blnPreencherClubeFidelidadeComProprioCliente := False;
    Self.Enabled := True;
  End;
end;

procedure TfrmCadClientes.btnGravarEmbClick(Sender: TObject);
begin
  inherited;

  If ( fMensagem('CONFIRMAÇÃO!', 'Deseja vincular a embarcação ' +
      QuotedStr(edtCodEmb.Text + '-' + edtDesEmb.Text) + ' ao cadastro do cliente?', ['&Sim', '&Não'], 1) = 1 ) Then Begin

    pAdicionarEmbarcacoes(edtCodEmb.Text);

    pLimparEditsEmbarcacoes();
  End;
end;

procedure TfrmCadClientes.pGravaAlteracoesParticipante(dtsEstado: TDataSetState;
    strNomAnt, strCidAnt, strCgcAnt, strIesAnt, strSufAnt, strEndAnt,
    strNumAnt, strComAnt, strBaiAnt: String);
begin
  If dtsEstado = dsEdit Then
  Begin
    pAlteracaoDadosParticipante(caNome, qryTabela.FieldByName('CLI_CODCLI').AsString, 'C',
      qryTabela.FieldByName('CLI_NOMCLI').AsString, strNomAnt);

    pAlteraCidade(qryTabela.FieldByName('CLI_CODCLI').AsString, 'C',
      qryTabela.FieldByName('CLI_CODCID').AsString, strCidAnt);

    pAlteraCnpjOuCpf(qryTabela.FieldByName('CLI_CODCLI').AsString, 'C',
      qryTabela.FieldByName('CLI_C_G_C_').AsString, strCgcAnt);

    pAlteracaoDadosParticipante(caIES, qryTabela.FieldByName('CLI_CODCLI').AsString, 'C',
      qryTabela.FieldByName('CLI_I_E_S_').AsString, strIesAnt);

    pAlteracaoDadosParticipante(caSuframa, qryTabela.FieldByName('CLI_CODCLI').AsString, 'C',
      qryTabela.FieldByName('CLI_SUFRAM').AsString, strSufAnt);

    pAlteracaoDadosParticipante(caEndereco, qryTabela.FieldByName('CLI_CODCLI').AsString, 'C',
      qryTabela.FieldByName('CLI_ENDERE').AsString, strEndAnt);

    pAlteracaoDadosParticipante(caNumEndereco, qryTabela.FieldByName('CLI_CODCLI').AsString, 'C',
      qryTabela.FieldByName('CLI_ENDNUM').AsString, strNumAnt);

    pAlteracaoDadosParticipante(caComplEndereco, qryTabela.FieldByName('CLI_CODCLI').AsString, 'C',
      qryTabela.FieldByName('CLI_ENDCOM').AsString, strComAnt);

    pAlteracaoDadosParticipante(caBairro, qryTabela.FieldByName('CLI_CODCLI').AsString, 'C',
      qryTabela.FieldByName('CLI_BAIRRO').AsString, strBaiAnt);
  End;
end;

procedure TfrmCadClientes.btnAlterarCCClick(Sender: TObject);
begin
  If cdsEmpCli.IsEmpty Then
  Begin
     fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
     Exit;
  End;

  strStatusContaContabil := 'UPDATE';

  pControlaBotoes;

  edtCodEmp.Text := cdsEmpCliCodEmp.AsString;
  edtNomEmp.Text := cdsEmpCliNomEmp.AsString;
  edtConcon.Text := cdsEmpCliConcon.AsString;

  pSetFocus(edtCodEmp);
end;

procedure TfrmCadClientes.btnAlterarClick(Sender: TObject);
var
  strDtaSef: string;
begin
  inherited;

  pAtualizaEnderecoEntrega;
  pAtualizaFazendas;

//  edtCndPag.Enabled := False;
//  edtDesFpg.Enabled := False;

  pVerificaDireitosDadosPrincipais;
  pVerificaDireitosDadosRetencao;

  blnCanalAcessoLibera    := False;
  btnAdicionar.Enabled := True;
  grdEmpresaPrioridade.Enabled := True;
  grbLGPD.Enabled := True;
  dbeLeiLGPChange(dbeLeiLGP);
  pHabilitaBotaoLimiteDeCredito(True);

  If (blnAlterou) Then
  Begin
    if Assigned(LogAltCadCli) then
      LogAltCadCli.LogVar.Clear;

    fltLimCreAnt := qryTabela.FieldByName('CLI_LIMCRE').AsFloat;
    intDesPonAnt := qryTabela.FieldByName('CLI_QTDDAV').AsInteger;
    strStatus    := qryTabela.FieldByName('CLI_STATUS').AsString;

    If fEmptyStr(qryTabela.FieldByName('CLI_C_G_C_').AsString) Then
      strNuCnpjAnt := qryTabela.FieldByName('CLI_CPFDEV').AsString
    Else
      strNuCnpjAnt := qryTabela.FieldByName('CLI_C_G_C_').AsString;

    strConConAnt := qryTabela.FieldByName('CLI_CONCON').AsString;
    strTipCliAnt := qryTabela.FieldByName('CLI_TIPCLI').AsString;
    strCodFpgAnt := qryTabela.FieldByName('CLI_CODFPG').AsString;
    strTabPreAnt := qryTabela.FieldByName('CLI_TABPRE').AsString;
    strAltAtiAnt := qryTabela.FieldbyName('CLI_CODATI').AsString;
    strCodPorAnt1:= qryTabela.FieldByName('CLI_CODPOR').AsString;
    strCodPorAnt2:= qryTabela.FieldByName('CLI_CODPO2').AsString;

    strZonFraAnt := qryTabela.FieldByName('CLI_ZONFRA').AsString;
    strCodVenAnt := qryTabela.FieldByName('CLI_CODVEN').AsString;
    strCodRepAnt := qryTabela.FieldByName('CLI_CODREP').AsString;
    strOrgPubAnt := qryTabela.FieldByName('CLI_ORGPUB').AsString;
    strCepAnt    := qryTabela.FieldByName('CLI_C_E_P_').AsString;
    strCepCobAnt := qryTabela.FieldByName('CLI_CEPCOB').AsString;
    strCepEntAnt := qryTabela.FieldByName('CLI_CEPENT').AsString;

    strNomAnt := IfNull(qryTabela.FieldByName('CLI_NOMCLI').AsString, '');
    strCidAnt := IfNull(qryTabela.FieldByName('CLI_CODCID').AsString, '');
    strCgcAnt := IfNull(qryTabela.FieldByName('CLI_C_G_C_').AsString, '');
    strIesAnt := IfNull(qryTabela.FieldByName('CLI_I_E_S_').AsString, '');
    strIESUAnt:= IfNull(qryTabela.FieldByName('CLI_IESUNI').AsString, '');
    strSufAnt := IfNull(qryTabela.FieldByName('CLI_SUFRAM').AsString, '');
    strEndAnt := IfNull(qryTabela.FieldByName('CLI_ENDERE').AsString, '');
    strNumAnt := IfNull(qryTabela.FieldByName('CLI_ENDNUM').AsString, '');
    strComAnt := IfNull(qryTabela.FieldByName('CLI_ENDCOM').AsString, '');
    strBaiAnt := IfNull(qryTabela.FieldByName('CLI_BAIRRO').AsString, '');

    strBairroLib := IfNull(qryTabela.FieldByName('CLI_BAIRRO').AsString, '');
    strBaiCobLib := IfNull(qryTabela.FieldByName('CLI_BAICOB').AsString, '');

    strAltCidade      := IfNull(qryTabela.FieldByName('CLI_CODCID').AsString,'');
    strAltInsEstadual := IfNull(qryTabela.FieldByName('CLI_I_E_S_').AsString,'');
    strAltCgcCpf      := IfNull(qryTabela.FieldByName('CLI_CGCCPF').AsString,'');
    strCodGrupoRisco  := qryTabela.FieldByName('CLI_CODGRR').AsString;
    strCanalAnt := qryTabela.FieldByName('CLI_CODCAC').AsString;
    strCliFidAnt := IfNull(qryTabela.FieldByName('CLI_CLIFID').AsString,'');
    strIgtVmkAnt := qryTabela.FieldByName('CLI_IGTVMK').AsString;

    pAjustaIesUni;

    qryCadFic.Edit;

    If blnCrediario Then
      qryInfCre.Edit;

    pgcDados.ActivePageIndex := 0;
    pHabilitaCodigo(dbeCodCli, fRetCampoComDireito(dbeNomCli), False);

    {**********************************************}
    {* USO PARA GERAÇÃO DO LOG DE LIMITE E STATUS *}
    {* DO CLIENTE                                 *}
    {*******************************************AC*}
    strLimCre := FloatToStr(fltLimCreAnt);
    strStaCli := strStatus;
    strTipCli := strTipCliAnt;
    intAtrMax := qryTabela.FieldByName('CLI_ATRMAX').AsInteger;

    strCodVen := strCodVenAnt;
    strCodRep := strCodRepAnt;

    pLimpaEditsContatos;
    dbgContatos.ReadOnly := False;
    pnlContatos.Enabled  := True;
    pnlAutCtt.Enabled    := True;

    pHabilitarAbaSocios(True);
    pHabilitarAbaBeneficios(True);

    pLimpaEditsProdutos;
    pnlProdutos.Enabled  := True;

    pLimpaEditsVeiculos;
    dbgCliVei.ReadOnly := False;
    pnlCliVei.Enabled  := True;

    pLimpaEditsRefComerciais;
    dbgCliRco.ReadOnly := False;
    pnlRefComerciais.Enabled  := True;
    pHabilitaDiaFixo;
    pHabilitaControleData;

    blnAlterou := False;
    btnConsultaFit.Enabled := (dbeCgcCpf.Enabled);
  End;

  If (fCfgSis('EMPGER', varBoolean)) Then
    dbeCodEmpRCF.Enabled := True
  Else
    dbeCodEmpRCF.Enabled := False;

    btnCadFor.Enabled := True;
  btnCadTransportadora.Enabled := True;

  pnlQualificacao.Enabled := fCfgSis('USAQUA', varBoolean);
  cxGridQuaCli.Enabled    := pnlQualificacao.Enabled;

  {***********************}
  {* PERMITE MI/FF (S/N) *}
  {********************RV*}
  If Not fVerificaAcessoSistema('PER_FF', strLoginUsuarioLogado) Then
    pnlPeMIFF.Enabled := False
  Else
    pnlPeMIFF.Enabled := True;

  dbeCoDeAc.Enabled := fVerificaAcessoSistema('ALTCODEAC', strLoginUsuarioLogado);
  dbeObserv.Enabled := fVerificaAcessoSistema('ALTOBS', strLoginUsuarioLogado);
  grbConsulta.Enabled := fVerificaAcessoSistema('ALTCCR', strLoginUsuarioLogado);

  dbeConsum.Enabled := fVerificaAcessoSistema('ALTECF', strLoginUsuarioLogado);

  btnAbrirPastaCliente.Enabled := fVerificaAcessoSistema('BTNARQCAD');
  dbeLeiLGP.Enabled := fVerificaAcessoSistema('ALTLEILGPD');
  dbeTerAce.Enabled := fVerificaAcessoSistema('ALTTERACE');
  dbePerAgu.Enabled := fVerificaAcessoSistema('ALTPERENTFUTAC');
  dbePerPre.Enabled := fVerificaAcessoSistema('ALTPERENTFUTPE');
  dbePerFal.Enabled := fVerificaAcessoSistema('ALTPERENTFUTFP');
  btnArquivosAceiteLGPD.Enabled := fVerificaAcessoSistema('BTNARQACE');
  dbeObrPDC.Enabled := fVerificaAcessoSistema('ALTOBROPE');

  dbeValLim.Enabled := False;
  dbeDtDEPS.Enabled := False;

  blnLibNum := False;
  blnLibPor := False;
  blnLibPo2 := False;

  dbeCgcCpfExit(Nil);
  cmbTipoPesquisaChange(Nil);

  dbeFtNfEs.Enabled := not dbeFtNfEs.ReadOnly;
  dbeTFtNEs.Enabled := not dbeTFtNEs.ReadOnly;
  dbeTipFat.Enabled := not dbeTipFat.ReadOnly;

  dbeStReEs.Enabled := fVerificaAcessoSistema('CLASPS', strLoginUsuarioLogado);

  {Logs}
  pAddTabelasLog;

  pAtualizaTributacao('CLI_SITP_C');
  pAtualizaTributacao('CLI_SITPCP');
  pAtualizaTributacao('CLI_SITIPI');

  dbeRetPCo.Enabled := not lblMsgRetImposto.Visible;
  dbeRetIrf.Enabled := not lblMsgRetImposto.Visible;
  dbeCDesPI.Enabled := not lblMsgRetImposto.Visible;

  if btnConsultaFit.Enabled then
  begin
    If (dbeCgcCpf.Text = '1') Then
    Begin
      if fTeveConsultaSefaz('CADCLI', 'CLI_DTASEF', qryTabela.FieldByName('AUTOINCREM').AsString, strDtaSef) then
      begin
        btnConsultaFit.Glyph := Nil;
        ImageSefaz.GetBitmap(1, btnConsultaFit.Glyph);
        btnConsultaFit.Hint := 'Consulta Dados Cadastrais do CNPJ.' + sLineBreak + 'Última consulta realizada em '+strDtaSef+'.';
      end
      else
      begin
        btnConsultaFit.Glyph := Nil;
        ImageSefaz.GetBitmap(0, btnConsultaFit.Glyph);
        btnConsultaFit.Hint := 'Consulta Dados Cadastrais do CNPJ.';
      end;
    End
    Else
    Begin
      btnConsultaFit.Glyph := Nil;
      ImageSefaz.GetBitmap(0, btnConsultaFit.Glyph);
      btnConsultaFit.Hint := 'Consulta Dados Cadastrais do CPF.';
    End;
  end;

  If (dbeIDEstrangeiro.Visible) Then
    pSetFocus(dbeIDEstrangeiro)
  Else
    pSetFocus(dbeCgcCpf);

  fValidaCampos(dbeCgcCpf);
end;

procedure TfrmCadClientes.btnCadDivClick(Sender: TObject);
  Var
    strCodDiv: String;

    function fExisteCnpjCpfDiverso(Var strCodDiv: String; strCodigo, strEstado: String): Boolean;
      Var
        strSQL   : String;
        qryGenTmp: TUniQuery;
    Begin
      Try
        Result := False;
        If (strEstado = 'EX') Then
          Exit;
        qryGenTmp := fCriaQuery;
        If Not fEmptyStr(strCodigo) Then
        Begin

          strSQL := '';
          strSQL := strSQL + ' SELECT                 ';
          strSQL := strSQL + '   DIV_CODDIV           ';
          strSQL := strSQL + ' FROM                   ';
          strSQL := strSQL + '   CADDIV               ';
          strSQL := strSQL + ' WHERE                  ';
          strSQL := strSQL + '   DIV_C_G_C_ = :CODIGO ';

          With qryGenTmp Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('CODIGO').AsString := strCodigo;
            Open;

            If Not IsEmpty Then
            Begin
              strCodDiv := FieldByName('DIV_CODDIV').AsString;
              fMensagem('ATENÇÃO','Já existe o CNPJ / CPF cadastrado para o Código: ' + #13 +
                                  strCodDiv + ' no Cadastro de Diversos!',['&OK']);
              Result := True;
            End;
            Close;
          End;
        End;
      Finally
        FreeAndNil(qryGenTmp);
      End;
    End;

begin
  inherited;
  strCodDiv := '';

  If (Not btnCadDiv.Enabled) Then
    Exit;

  If Not fUsaProCodigo('CADDIV') Then
  Begin
    fMensagem('ATENÇÃO!',
              'Para utilizar o "Cadastro Rápido" para o "Cadastro de Diversos" é necessário:'     + #13 +
              'Habilitar a geração de código automático acessando:  "> Útil > Próximos Códigos",' + #13 +
              'localize o arquivo "CADDIV" e habilite a opção "Automático".',
              ['&Ok'],
              1,
              False,
              1,
              0,
              False,
              0,
              False,
              False,
              False,
              0,
              500);
    Exit;
  End;

  If Not fVerificaAcessoSistema('GERDIV') Then
  Begin
    fMensagem('', 'Operador não tem direito para "Gerar Cadastro de Diversos"!', ['&Ok']);
    Exit;
  End;

  If (qryTabela.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário escolher um Cliente!', ['&Ok']);
    Exit;
  End;

  If (fEmptyStr(dbeCodCli.Text)) And (dbeCodCli.Enabled) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Código do Cliente deve ser preenchido!', ['&Ok']);
    Exit;
  End;

  If fEmptyStr(dbeNomCli.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Nome do Cliente deve ser preenchido!', ['&Ok']);
    Exit;
  End;

  If fEmptyStr(dbeCodAti.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'A Atividade do Cliente deve ser preenchida!', ['&OK']);
    Exit;
  End;

  If (fEmptyStr(dbeCgcCpf.Text)) Or (dbeCgcCpf.Text = '0') Then
  Begin
    fMensagem('ATENÇÃO!', 'O CNPJ / CPF deve ser preenchido!', ['&Ok']);
    Exit;
  End
  Else If Not fValidaCnpjCpf(dbeCgcCpf.Text, IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text), False, True) Then
  Begin
    fMensagem('ATENÇÃO!', 'CNPJ / CPF inválido!', ['&Ok']);
    Exit;
  End;

  If (Not fExisteCnpjCpfDiverso(strCodDiv, IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text), edtEstado.Text)) Then
  Begin
    If (fMensagem('AVISO', 'Confirma a Geração do Cadastro de Diversos?', ['&Sim', '&Não']) = 2) Then
      Exit;

    If TfrmCadDiversos.fCadastroRapidoDiverso(strCodDiv,
                                              dbeNomCli.Text,
                                              dbeEndere.Text,
                                              dbeBairro.Text,
                                              dbeCodCid.Text,
                                              dbeNumCep.Text,
                                              dbeFone01.Text,
                                              dbeNumRg.Text,
                                              dbeCodCli.Text,
                                              dbeEmail.Text,
                                              dbeCodAti.Text,
                                              StrToInt(dbeCgcCpf.Text),
                                              IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text),
                                              dbeNumIes.Text,
                                              'A',
                                              IIF(fCfgSis('REGDAT') = '1', StrToDateDef(dbeDtaCad.text,0), VS_Date),
                                              StrToDateDef(dbeDtaNas.text,0),
                                              dbeFone02.text,
                                              dbeNumCel.text,
                                              dbeHomPag.text,
                                              fCfgSis('DIVPCO', VarDouble),
                                              fCfgSis('DIVPCP', VarDouble),
                                              dbeNomCli.Text,
                                              dbeEndNum.Text,
                                              dbeObserv.Text,
                                              dbeNumFax.Text) Then
    fMensagem('ATENÇÃO!', 'Geração concluída com sucesso!' + #13 +
                          'Cadastro de Diversos criado com o Código: ' + strCodDiv, ['&Ok']);
  End
  Else
  Begin
    If (fMensagem('AVISO', 'Confirma a Atualização do Cadastro de Diversos?', ['&Sim', '&Não']) = 2) Then
      Exit;

    If TfrmCadDiversos.fCadastroRapidoDiverso(strCodDiv,
                                              dbeNomCli.Text,
                                              dbeEndere.Text,
                                              dbeBairro.Text,
                                              dbeCodCid.Text,
                                              dbeNumCep.Text,
                                              dbeFone01.Text,
                                              dbeNumRg.Text,
                                              dbeCodCli.Text,
                                              dbeEmail.Text,
                                              dbeCodAti.Text,
                                              StrToInt(dbeCgcCpf.Text),
                                              IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text),
                                              dbeNumIes.Text,
                                              'A',
                                              IIF(fCfgSis('REGDAT') = '1', StrToDateDef(dbeDtaCad.text,0), VS_Date),
                                              StrToDateDef(dbeDtaNas.text,0),
                                              dbeFone02.text,
                                              dbeNumCel.text,
                                              dbeHomPag.text,
                                              0,
                                              0,
                                              dbeNomCli.Text,
                                              dbeEndNum.Text,
                                              dbeObserv.Text,
                                              dbeNumFax.Text) Then
    fMensagem('ATENÇÃO!', 'Atualização concluída com sucesso!', ['&Ok']);
  End;
end;

procedure TfrmCadClientes.btnCadForClick(Sender: TObject);
var
  strCodFor: string;

    function fExisteCnpjCpfFornecedor(Var strCodFor: String; strCodigo, strEstado: String): Boolean;
      Var
        strSQL   : String;
        qryGenTmp: TUniQuery;
    Begin
      Try
        Result := False;
        If (strEstado = 'EX') Then
          Exit;
        qryGenTmp := fCriaQuery;
        If Not fEmptyStr(strCodigo) Then
        Begin

          strSQL := '';
          strSQL := strSQL + ' SELECT                 ';
          strSQL := strSQL + '   FOR_CODFOR           ';
          strSQL := strSQL + ' FROM                   ';
          strSQL := strSQL + '   CADFOR               ';
          strSQL := strSQL + ' WHERE                  ';
          strSQL := strSQL + '   FOR_C_G_C_ = :CODIGO ';

          qryGenTmp.Close;
          qryGenTmp.SQL.Clear;
          qryGenTmp.SQL.Add(strSQL);
          qryGenTmp.ParamByName('CODIGO').AsString := strCodigo;
          qryGenTmp.Open;

          If Not qryGenTmp.IsEmpty Then
          Begin
            strCodFor := qryGenTmp.FieldByName('FOR_CODFOR').AsString;
            fMensagem('ATENÇÃO','Já existe o CNPJ / CPF cadastrado para o Código: ' + #13 +
                                strCodFor + ' no Cadastro de Fornecedor!',['&OK']);
            Result := True;
          End;
        End;
      Finally
        FreeAndNil(qryGenTmp);
      End;
    End;
begin
  inherited;
  if qryTabela.State in [dsEdit, dsInsert] then
  begin
    If Not fVerificaAcessoSistema('frmCadFornecedores') Then
    Begin
      fMensagem('ATENÇÃO!', 'Usuário sem acesso!', ['&Ok']);
      Exit;
    End;

    If Not fUsaProCodigo('CADFOR') Then
    Begin
      fMensagem('ATENÇÃO!',
                'Para utilizar o "Cadastro Rápido" para o "Cadastro de Fornecedore" é necessário:'     + #13 +
                'Habilitar a geração de código automático acessando:  "> Útil > Próximos Códigos",' + #13 +
                'localize o arquivo "CADFOR" e habilite a opção "Automático".',
                ['&Ok'],
                1,
                False,
                1,
                0,
                False,
                0,
                False,
                False,
                False,
                0,
                500);
      Exit;
    End;

    if (qryTabela.IsEmpty) then
    begin
      fMensagem('ATENÇÃO!', 'É necessário escolher um registro!', ['&Ok']);
      Exit;
    end;

    if (fEmptyStr(dbeCodCli.Text)) and (dbeCodCli.Enabled) then
    begin
      fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
      Exit;
    end;

    if (fEmptyStr(dbeNomCli.Text)) then
    begin
      fMensagem('ATENÇÃO!', 'O Nome deve ser preenchido!', ['&Ok']);
      Exit;
    end;

    if (fEmptyStr(dbeCodAti.Text)) then
    begin
      fMensagem('ATENÇÃO!', 'A atividade deve ser preenchida!', ['&Ok']);
      Exit;
    end;

    if (fEmptyStr(dbeCgcCpf.Text)) or (dbeCgcCpf.Text = '0') then
    begin
      fMensagem('ATENÇÃO!', 'O CNPJ / CPF deve ser preenchido!', ['&Ok']);
      Exit;
    end
    else if (not fValidaCnpjCpf(dbeCgcCpf.Text, IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text), False, False)) then
    begin
      fMensagem('ATENÇÃO!', 'CNPJ / CPF inválido!', ['&Ok']);
      Exit;
    end;

    if (not fExisteCnpjCpfFornecedor(strCodFor, IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text), edtEstado.Text)) then
    begin
      if (fMensagem('AVISO', 'Confirma a Geração do Cadastro de Fornecedores?', ['&Sim', '&Não']) = 2) then
        Exit;

      if TfrmCadFornecedores.fCadastroRapidoFornecedor(strCodFor,
                                                       dbeNomCli.Text,
                                                       dbeFanSob.Text,
                                                       dbeEndere.Text,
                                                       dbeBairro.Text,
                                                       dbeCodCid.Text,
                                                       dbeNumCep.Text,
                                                       dbeFone01.Text,
                                                       dbeNumRg.Text,
                                                       dbeEmail.Text,
                                                       'A',
                                                       IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text),
                                                       dbeFone02.Text,
                                                       dbeNumCel.Text,
                                                       dbeHomPag.Text,
                                                       dbeCodCli.Text,
                                                       dbeNumIes.Text,
                                                       dbeCodAti.Text,
                                                       StrToInt(dbeCgcCpf.Text)) then

      fMensagem('ATENÇÃO!', 'Geração concluída com sucesso!' + #13 +
                            'Cadastro de Fornecedor criado com o Código: ' + strCodFor, ['&Ok']);

    end
    else
    begin
      If (fMensagem('AVISO', 'Confirma a Atualização do Cadastro de Fornecedores?', ['&Sim', '&Não']) = 2) Then
        Exit;

      if TfrmCadFornecedores.fCadastroRapidoFornecedor(strCodFor,
                                                       dbeNomCli.Text,
                                                       dbeFanSob.Text,
                                                       dbeEndere.Text,
                                                       dbeBairro.Text,
                                                       dbeCodCid.Text,
                                                       dbeNumCep.Text,
                                                       dbeFone01.Text,
                                                       dbeNumRg.Text,
                                                       dbeEmail.Text,
                                                       'A',
                                                       IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text),
                                                       dbeFone02.Text,
                                                       dbeNumCel.Text,
                                                       dbeHomPag.Text,
                                                       dbeCodCli.Text,
                                                       dbeNumIes.Text,
                                                       dbeCodAti.Text,
                                                       StrToInt(dbeCgcCpf.Text)) then

      fMensagem('ATENÇÃO!', 'Atualização concluída com sucesso!', ['&Ok']);
    end;
  end;
end;

procedure TfrmCadClientes.btnCadTransportadoraClick(Sender: TObject);
var
  strCodTra: string;

    function fExisteCnpjCpfTransportadora(Var strCodTra: String; strCodigo, strEstado: String): Boolean;
      Var
        strSQL   : String;
        qryGenTmp: TUniQuery;
    Begin
      Try
        Result := False;
        If (strEstado = 'EX') Then
          Exit;
        qryGenTmp := fCriaQuery;
        If Not fEmptyStr(strCodigo) Then
        Begin

          strSQL := '';
          strSQL := strSQL + ' SELECT                 ';
          strSQL := strSQL + '   TRA_CODTRA           ';
          strSQL := strSQL + ' FROM                   ';
          strSQL := strSQL + '   CADTRA               ';
          strSQL := strSQL + ' WHERE                  ';
          strSQL := strSQL + '   TRA_C_G_C_ = :CODIGO ';

          qryGenTmp.Close;
          qryGenTmp.SQL.Clear;
          qryGenTmp.SQL.Add(strSQL);
          qryGenTmp.ParamByName('CODIGO').AsString := strCodigo;
          qryGenTmp.Open;

          If Not qryGenTmp.IsEmpty Then
          Begin
            strCodTra := qryGenTmp.FieldByName('TRA_CODTRA').AsString;
            fMensagem('ATENÇÃO','Já existe o CNPJ / CPF cadastrado para o Código: ' + #13 +
                                strCodTra + ' no Cadastro de Transportadora!',['&OK']);
            Result := True;
          End;
        End;
      Finally
        FreeAndNil(qryGenTmp);
      End;
    End;
begin
  inherited;
  If Not fVerificaAcessoSistema('frmCadTransportadoras') Then
  Begin
    fMensagem('ATENÇÃO!', 'Usuário sem acesso!', ['&Ok']);
    Exit;
  End;

  if qryTabela.State in [dsEdit, dsInsert] then
  begin
    If Not fUsaProCodigo('CADTRA') Then
    Begin
      fMensagem('ATENÇÃO!',
                'Para utilizar o "Cadastro Rápido" para o "Cadastro de Transportadoras" é necessário:'     + #13 +
                'Habilitar a geração de código automático acessando:  "> Útil > Próximos Códigos",' + #13 +
                'localize o arquivo "CADTRA" e habilite a opção "Automático".',
                ['&Ok'],
                1,
                False,
                1,
                0,
                False,
                0,
                False,
                False,
                False,
                0,
                500);
      Exit;
    End;

    if (qryTabela.IsEmpty) then
    begin
      fMensagem('ATENÇÃO!', 'É necessário escolher um registro!', ['&Ok']);
      Exit;
    end;

    if (fEmptyStr(dbeCodCli.Text)) and (dbeCodCli.Enabled) then
    begin
      fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
      Exit;
    end;

    if (fEmptyStr(dbeNomCli.Text)) then
    begin
      fMensagem('ATENÇÃO!', 'O Nome deve ser preenchido!', ['&Ok']);
      Exit;
    end;

    if (fEmptyStr(dbeCgcCpf.Text)) or (dbeCgcCpf.Text = '0') then
    begin
      fMensagem('ATENÇÃO!', 'O CNPJ / CPF deve ser preenchido!', ['&Ok']);
      Exit;
    end
    else if (not fValidaCnpjCpf(dbeCgcCpf.Text, IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text), False, False)) then
    begin
      fMensagem('ATENÇÃO!', 'CNPJ / CPF inválido!', ['&Ok']);
      Exit;
    end;

    if (not fExisteCnpjCpfTransportadora(strCodTra, IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text), edtEstado.Text)) then
    begin
      if (fMensagem('AVISO', 'Confirma a Geração do Cadastro de Transportadora?', ['&Sim', '&Não']) = 2) then
        Exit;

      if TfrmCadTransportadoras.fCadastroRapidoTransportadora(strCodTra,
                                                              dbeNomCli.Text,
                                                              dbeFanSob.Text,
                                                              dbeEndere.Text,
                                                              dbeBairro.Text,
                                                              dbeCodCid.Text,
                                                              dbeNumCep.Text,
                                                              dbeFone01.Text,
                                                              dbeEmail.Text,
                                                              IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text),
                                                              dbeFone02.Text,
                                                              dbeNumIes.Text,
                                                              dbeHomPag.Text,
                                                              StrToInt(dbeCgcCpf.Text)) then

      fMensagem('ATENÇÃO!', 'Geração concluída com sucesso!' + #13 +
                            'Cadastro de Transportadora criado com o Código: ' + strCodTra, ['&Ok']);
    end
    else
    begin
      If (fMensagem('AVISO', 'Confirma a Atualização do Cadastro de Transportadora?', ['&Sim', '&Não']) = 2) Then
        Exit;

      if TfrmCadTransportadoras.fCadastroRapidoTransportadora(strCodTra,
                                                              dbeNomCli.Text,
                                                              dbeFanSob.Text,
                                                              dbeEndere.Text,
                                                              dbeBairro.Text,
                                                              dbeCodCid.Text,
                                                              dbeNumCep.Text,
                                                              dbeFone01.Text,
                                                              dbeEmail.Text,
                                                              IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text),
                                                              dbeFone02.Text,
                                                              dbeNumIes.Text,
                                                              dbeHomPag.Text,
                                                              StrToInt(dbeCgcCpf.Text)) then

      fMensagem('ATENÇÃO!', 'Atualização concluída com sucesso!', ['&Ok']);
    end;
  end;
end;

procedure TfrmCadClientes.btnCancelaClick(Sender: TObject);
begin
  inherited;

  FCliEndEntrega.pCancelaAlteracoes;
  memOrientacoes.Text := '';
  pAtualizaEnderecoEntrega;
  pHabilitaBotaoLimiteDeCredito(False);

  If Assigned(FCliFazendas) Then
    FCliFazendas.pCancelaAlteracoes;
  pAtualizaFazendas;

  qryCadFic.Cancel;

  If blnCrediario Then
    qryInfCre.Cancel;

  imgCli.visible := true;
  pCarregaDadosAdicionais;

  {******************************}
  { ROTINAS P\ ABA CONTATO       }
  {***************************JB*}
  btnCancelaCtt.Click;
  dbgContatos.ReadOnly := True;
  pnlContatos.Enabled  := False;
  pnlAutCtt.Enabled    := False;
  pCarregaContatos(qryTabela.FieldByName('CLI_CODCLI').AsString);
  pOrgaoPublicoForaDoEstado;

  pHabilitarAbaSocios(False);
  pCarregaSocios(qryTabela.FieldByName('CLI_CODCLI').AsString);

  pHabilitarAbaBeneficios(False);
  pCarregaBeneficios(qryTabela.FieldByName('CLI_CODCLI').AsString);

  {***************************************}
  { ROTINAS P\ ABA REFERENCIAS COMERCIAIS }
  {************************************AC*}
  dbgCliRco.ReadOnly := True;
  pnlRefComerciais.Enabled  := False;
  lstDiaFix.Enabled := False;
  lstDiaMes.Enabled := False;

  lstDiaSemPerFat.Enabled := False;
  lstDiaMesPerFat.Enabled := False;
  lstDiaMesPerEnt.Enabled := False;
  cxgDiaSemEnt.Enabled := False;

  blnAltRefComer := False;
  pCarregaRefComerciais(qryTabela.FieldByName('CLI_CODCLI').AsString);
  pLimpaEditsRefComerciais;

  {*************************************************}
  {* ROTINAS P\ ABA RELACIONAMENTO CLIENTE-PRODUTO *}
  {**********************************************RV*}
  pnlProdutos.Enabled  := False;
  pCarregaProdutos(qryTabela.FieldByName('CLI_CODCLI').AsString);

  {***************************}
  {* ROTINAS P\ ABA VEICULOS *}
  {************************RV*}
  dbgCliVei.ReadOnly := True;
  pnlCliVei.Enabled  := False;
  pCarregaVeiculos(qryTabela.FieldByName('CLI_CODCLI').AsString);

  edtTotRen.Clear;

  pQueryCadCliAfterScroll(qryTabela);
  pQueryCadFicAfterScroll(qryCadFic);

  pCarregaBairroAtende(qryTabela.FieldByName('CLI_CODCLI').AsString);

  pCarregarEmbarcacoes(qryTabela.FieldByName('CLI_CODCLI').AsString);

  pCarregaPlanoDeContasPorEmpresa('CLINCO', dbeCodCli.Text, FcdsNCO);

  pCarregaResumo(qryTabela.FieldByName('CLI_CODCLI').AsString, fRetDesTipoAbf('C', qryTabela.FieldByName('CLI_CODCLI').AsString));

  pOrgaoPublicoForaDoEstado;

  If blnCrediario Then
    pQueryInfCreAfterScroll(qryInfCre);

  blnCadastroModificado := False;

  If (blnCadContato) Then
    btnSair.Click();

  pLimparEditsEmbarcacoes();
  pHabilitaCampoAtoDeclaratorioDF;

  btnHeranca.Enabled := False;
  btnConsultaFit.Enabled := False;

  pnlQualificacao.Enabled := False;
  cxGridQuaCli.Enabled    := False;

  {Limpar Dados Temporários}
  if Assigned(LogAltCadCli) then
    LogAltCadCli.pClearDataSets;

  If fCfgSis('USAQUA', varBoolean) Then
    btnCanQuaCli.Click();

  pAtualizaTributacao('CLI_SITP_C');
  pAtualizaTributacao('CLI_SITPCP');
  pAtualizaTributacao('CLI_SITIPI');
  VerificarDiasRestantesConsultaCredito;
  VerificarDiasRestantesConsultaCobranca;

  btnCadFor.Enabled := False;
  btnCadTransportadora.Enabled := False;
  blnCliProHer := False;
  btnAdicionar.Enabled := False;
  grdEmpresaPrioridade.Enabled := False;
  pCarregaEmpresaPrioridade;
  grbLGPD.Enabled := False;
  strBaiCobLib := '';
  strBairroLib := '';

  fValidaCampos(dbeCgcCpf);
end;

procedure TfrmCadClientes.pInicializaCampos;
begin
  pSetaCamposDefaultCliente(qryTabela);
  strTipCliAnt := qryTabela.FieldByName('CLI_TIPCLI').AsString;
  strStatus    := qryTabela.FieldByName('CLI_STATUS').AsString;
  strTabPreAnt := qryTabela.FieldByName('CLI_TABPRE').AsString;
  fltLimCreAnt := qryTabela.FieldByName('CLI_LIMCRE').AsFloat;
  strVenInc    := qryTabela.FieldByName('CLI_CODVEN').AsString;
  strRepInc    := qryTabela.FieldByName('CLI_CODREP').AsString;
  strEnvBol    := qryTabela.FieldByName('CLI_ENVBOL').AsString;
  strBolImp    := qryTabela.FieldByName('CLI_BOLIMP').AsString;
  intDesPonAnt := qryTabela.FieldByName('CLI_QTDDAV').AsInteger;
  strCliFidAnt := qryTabela.FieldByName('CLI_CLIFID').AsString;
end;

procedure TfrmCadClientes.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  inherited;
  If (Msg.Charcode = VK_TAB) And (dbeObsCon.Focused Or dbeObs_Fc.Focused) Then
    pProximaPagina;
end;

procedure TfrmCadClientes.FormShow(Sender: TObject);
  Var
    intCon: Integer;
    DespesasOperacionaisComplementar : TDespesasOperacionaisComplementar;
begin
  //blnUsaVerificaCamposPai := False;

  btnConsultaSerasaPowerCurve.Enabled := UtilizaConsultaSerasaPowerCurve;
  btnConsultaSerasaExperian.Enabled   := UtilizaConsultaSerasaExperian;
  cbProdutoSerasa.Enabled := (cmbTipoPesquisa.ItemIndex = 1);

  pAtualizaCadFic(qryTabela.FieldByName('CLI_CODCLI').AsString);

  pAtualizaInfCre;

  pnlMsgDirAlqRet.Visible := False;

  inherited;

  pVerificaDireitosBotoes;

  lblCorres.Visible := fCfgSis('CORRES', varBoolean);
  edtCorres.Visible := lblCorres.Visible;
  dbeCorres.Visible := lblCorres.Visible;

  lblTaxEnt.Visible := fCfgSis('TAXENT', varBoolean);
  clbTaxEnt.Visible := lblTaxEnt.Visible;
  dbeTaxEnt.Visible := lblTaxEnt.Visible;

  lblDif_ST.Visible := fCfgSis('EMPDIS', varBoolean);
  clbDif_ST.Visible := lblDif_ST.Visible;
  dbeDif_ST.Visible := lblDif_ST.Visible;

  pnlPermut.Visible := fCfgSis('PERMUT', varBoolean);

  DespesasOperacionaisComplementar.SetValue(fCfgSis('CLIDOP', varString));
  dbeDesOpe.Visible := (DespesasOperacionaisComplementar <> docNaoUtilizar);
  lblDesOpe.Visible := dbeDesOpe.Visible;
  lblDesOpePer.Visible := dbeDesOpe.Visible;

  lblValLim.Visible := fCfgSis('USADEP', varBoolean);
  dbeValLim.Visible := lblValLim.Visible;
  lblDtDEPS.Visible := lblValLim.Visible;
  dbeDtDEPS.Visible := lblValLim.Visible;

  gpbVMINFC.Visible := fCfgSis('VMINFC', varBoolean);

  If Not (fCfgSis('USACCR', VarBoolean) And MatchStr(fCfgSis('TPNFCR'),[PRESTCON,SECOL])) Then
  Begin
    rdgCobIss.Visible := False;
    lblCobIss.Visible := False;
  End;

  cbxRgEst.Items.Clear;

  For intCon := 0 To Length(ESTADOS) -1 Do
    cbxRgEst.Items.Add(String(ESTADOS[intCon]));

  {****************************************************}
  {* PARAGUAI NAO DIFERENCIA PESSOA FISICA/JURIDICA    *}
  {* Oculta o seletor 1-CNPJ/2-CPF e realinha o campo  *}
  {* CLI_C_G_C_ para ocupar a area do seletor.         *}
  {****************************************************}
  dbeCgcCpf.Visible := (FPais <> opcParaguai);

  If (Not dbeCgcCpf.Visible) Then
  Begin
    dbeNuCpnj.Left  := dbeCgcCpf.Left;
    dbeNuCpnj.Width := dbeNuCpnj.Width + dbeCgcCpf.Width;
    dbeCpfDev.Left  := dbeCgcCpf.Left;
    dbeCpfDev.Width := dbeCpfDev.Width + dbeCgcCpf.Width;
  End;

  pgcDados.ActivePageIndex := 0;

  pCarregaDadosAdicionais;

  {*****************************************}
  {* VERIFICA SE USA CADASTRO DE CONDICAO  *}
  {* DE PAGAMENTO                          *}
  {**************************************LA*}
  If (fCfgSis('USACND', varBoolean)) Then
  Begin
    pnlCodCnd.Visible    := True;
    pnlConPag.Visible    := False;
    cxgColCodCnd.Visible := True;
    cxgColDescri.Visible := True;
    cxgColCndPag.Visible := False;
    cdsCliCnd.IndexFieldNames := 'CND_CODCND';
  End
  Else
  Begin
    pnlCodCnd.Visible := False;
    pnlConPag.Visible := True;
    cxgColCodCnd.Visible := False;
    cxgColDescri.Visible := False;
    cxgColCndPag.Visible := True;
    cdsCliCnd.IndexFieldNames := 'CND_CNDPAG';
  End;

  {**************************************}
  {* VERIFICA SE USA CADASTRO DE FORMA  *}
  {* DE PAGAMENTO                       *}
  {***********************************MA*}
  If (fCfgSis('USAFPG', varBoolean)) Then
    pnlForPag.Enabled := True
  Else
    pnlForPag.Enabled := False;

  {*******************************************}
  {* VERIFICA SE USA O TIPO DE CLIENTE       *}
  {****************************************MV*}
  pnlTipCli.Visible := fCfgSis('USATPC', varBoolean);

  {***********************************************************}
  {* CASO UTILIZE PERCENTUAL DE COMISSAO DO CLIENTE/VENDEDOR *}
  {********************************************************JC*}
  pnlPerCom.Visible := (fCfgSis('OPCCOM') = 'CV');

  {*****************************************************************************}
  {* CASO UTILIZE ORIGEM DA COMISSAO DO PROFISSIONAL PELO CADASTRO DE CLIENTES *}
  {* OU ESTEJA CONFIGURADO PARA INFORMAR A ORIGEM DA COMISSAO NO CADASTRO DE   *}
  {* PROFISSIONAIS (DIVERSOS), HABILITA O CAMPO DE PERCENTUAL DE COMISSAO...   *}
  {**************************************************************************JC*}
  pnlComPro.Visible := ((fCfgSis('ORIPRO') = '4') Or (fCfgSis('TIPCOM') = 'P')) And (fCfgSis('TCOPRO') <> '4');
  pnlComPro.Enabled := fVerificaAcessoSistema('ALTCOM', strLoginUsuarioLogado);

  dbeFabDes.Visible := fCfgSis('USAAVE', varBoolean);
  lblFabDes.Visible := fCfgSis('USAAVE', varBoolean);

  If (Not fCfgSis('USASER', varBoolean)) Then
  begin
    btnContratos.Enabled := False;
    gpbServico.Visible   := False;
  End;

  If (fCfgSis('IDEEMP', varBoolean)) then
  begin
    Label148.Visible      := True;
    edtCodEmpresa.Visible := True;
    edtDesEmpresa.Visible := True;
  end
  else begin
    Label148.Visible      := False;
    edtCodEmpresa.Visible := False;
    edtDesEmpresa.Visible := False;
  end;

  If fCfgSis('CLIDES') = 'N' Then
  Begin
    lblDesCon.Visible := False;
    dbeDescon.Visible := False;
    lblPerDes.Visible := False;
    shpDesPro.Visible := False;
  End;

  {*************************************}
  { HAB SOMENTE AS TABS CONFORME A CFG  }
  {**********************************JB*}
  strVrfTpr := EmptyStr;
  clbPrcVenda.Caption := EmptyStr;

  For intCon:= 1 To Length(Trim(VS_strTabVen)) Do
  Begin
    strVrfTpr := strVrfTpr + IfThen(SameText(VS_strTabVen[intCon], 'S'), IntToStr(intCon), '');
    If (VS_strTabVen[intCon] = 'S') Then
    Begin
      If intCon <> Length(Trim(VS_strTabVen)) Then
        clbPrcVenda.Caption := clbPrcVenda.Caption + ' (' + IntToStr(intCon) + ')'
      Else
        clbPrcVenda.Caption := clbPrcVenda.Caption + ' ou (' + IntToStr(intCon) + ')'
    End;
  End;
  clbPrcVenda.Caption := 'Preço de Venda ' + clbPrcVenda.Caption;
  clbPrcVenda.AutoSize := FALSE;
  clbPrcVenda.AutoSize := TRUE;

  {*******************************************}
  {* VARIÁVEIS PARA GERAÇÃO DO LOG           *}
  {****************************************AC*}
  strLimCre := '';
  strStaCli := '';
  strTipCli := '';
  intAtrMax := 0;

  strCodVen := '';
  strCodRep := '';

  pnlAtrMax.Visible := fCfgSis('CLIATR', varBoolean);
  pnlGrupoRisco.Visible := pnlAtrMax.Visible And fCfgSis('GRRSCL', varBoolean);
  If pnlGrupoRisco.Visible Then
  Begin
    pVerdeVermelho(cbxGrupoRisco, shpGrupoRisco, fVerificaAcessoSistema('GRURIS'), False, False);
    pCarregaGrupoRisco();
  End;

  If pnlAtrMax.Visible Then
  Begin
    If (pnlGrupoRisco.Visible) Or
       (Not fVerificaAcessoSistema('PEATMA', strLoginUsuarioLogado)) Then
    Begin
      lblAtrMax.Enabled := False;
      dbeAtrMax.Enabled := False;
      pnlAtrMax.Enabled := False;
    End
    Else
    Begin
      lblAtrMax.Enabled := True;
      dbeAtrMax.Enabled := True;
      pnlAtrMax.Enabled := True;
    End;
  End;

  {**********************************}
  {* MOSTRA\OCULTA PERMITIR MI\FF...*}
  {*******************************JB*}
  pnlPeMIFF.Visible := (fPermiteEmissaoEspecie('FF')) And (fCfgSis('PEMIFF') = '2');

  lblPerEmp.Visible := fPermiteEmissaoEspecie('EP');
  dbePeEmp.Visible := lblPerEmp.Visible;
  dbePeEmp_S_N_.Visible := lblPerEmp.Visible;

  {*********************************************}
  {* MOSTRA\OCULTA GRUPO EMPRESA RESPONSAVEL...*}
  {******************************************JB*}
  pnlCompGrp3.Visible := fCfgSis('CFFRES', varBoolean);

  objPageControlOrder.pLoadPageOrder(ExtractFilePath(Application.ExeName) + '\PageOrderCadClientes'+strLoginUsuarioLogado);

  pCarregaCidadeCtt;
  pCarregaOperadorRco;
  pgcDados.ActivePageIndex := 0;

  If Not fEmptyStr(strCodClienteIniciarCadastro) Then
  Begin
    pBuscaCliente(strCodClienteIniciarCadastro);
//    If Not qryTabela.IsEmpty Then
//      btnAlterar.Click;
  End;

  grbNotaEspecial.Visible := fCfgSis('FTNFES', varBoolean);

  If blnUtilizarCrm Then
    pAplicarRegrasCrm;

  If fEmptyStr(strPermiCadCid) Then
    strPermiCadCid := 'frmCadCidades';

  If Assigned(FCliEndEntrega) Then
    FCliEndEntrega.strPermiCadCid := strPermiCadCid;

  blnAltFtNfEs := fVerificaAcessoSistema('ALT_FTNFES', strLoginUsuarioLogado);
  cdsCliDiv.IndexFieldNames := 'DIV_CODDIV';

  pDefinirDataSourceDataChange();

  {Permissão para incluir e excluir profissionais}
  if not fVerificaAcessoSistema('CLPROF', strLoginUsuarioLogado) then
  begin
    pnlCodDiv.Visible     := False;
    pnlInfDeletar.Visible := False;
    cxGridDBTableView1.OptionsData.Deleting := False;
    cxGridDBTableView1.OptionsData.Editing  := False;
  end
  else
  begin
    pnlCodDiv.Visible     := True;
    pnlInfDeletar.Visible := True;
    cxGridDBTableView1.OptionsData.Deleting := True;
    cxGridDBTableView1.OptionsData.Editing  := True;
  end;

  //esse método deve ser executado sempre por último
  //altera visualização das abas de acordo com parâmetro da tela
  pAjustarTelaCadastroContato();

  {Altera anchors que herdou do "PaiCad"}
  btnSair.Anchors := [akLeft, akTop];

  If (blnUtiCon) Then
  Begin
    dbePlaNco.Visible := True;
    edtDesPlaNco.Visible := True;
    dbeConCon.Visible := False;
    lblDesPlaCon.Caption := 'Plano Contábil:';
    btnPlaNco.Visible := True;
  End
  Else
  Begin
    dbePlaNco.Visible := False;
    edtDesPlaNco.Visible := False;
    dbeConCon.Visible := True;
    lblDesPlaCon.Caption := 'Conta Contábil:';
    btnPlaNco.Visible := False;
  End;

  btnAdicionar.Enabled := False;
  grdEmpresaPrioridade.Enabled := False;
  grbLGPD.Enabled := False;

  pSetaCodIte( edtCodIte );

  lblImpLau.Visible := fCfgSis('LAUDES', varBoolean);
  dbeImpLau.Visible := lblImpLau.Visible;
  cllImpLau.Visible := lblImpLau.Visible;
  lblEtiDes.Visible := lblImpLau.Visible;
  dbeEtiDes.Visible := lblImpLau.Visible;
  cllEtiDes.Visible := lblImpLau.Visible;

  lblCliMon.Visible := fCfgSis('CADMON', varBoolean);
  dbeCliMon.Visible := lblCliMon.Visible;
  cllCliMon.Visible := lblCliMon.Visible;

  If fCfgSis('TPDCEX') = '2' Then
  Begin
    lblTipFatPed.Visible := False;
    dbeTipFat.Visible := False;
    lblTipFat.Visible := False;
  End;

  btnConsultarEndereco.Enabled := True;

  pgDadosFiscais.ActivePage := TabGeral;

  FTipoConsCli := fStrToTipoConsCli( fCfgSis('CNSCCA', varString) );
  btnCliOutroVendedor.Visible := (FTipoConsCli = tpLibCliVenLog);


  blnAQCLUFI := fVerificaAcessoSistema('AQCLUFI', strLoginUsuarioLogado);

  pnlCliCluFid.Enabled := blnAQCLUFI;

  pMontaTitulosPageControl;

  if fCfgSis('UTIWPP', varBoolean) then
  begin
    Label20.Caption := 'Cel/Whatsapp:';
    imgWpp.Visible := True;

    Label178.Caption := 'Cel/Whatsapp:';
    imgWppCtt.Visible := True;

    btnGatWpp.Visible := True;
  end;

  lblLimiteAlpe.Visible := fCfgSis('ALPKNK', varBoolean);
  btnLimiteAlpe.Visible := fCfgSis('ALPKNK', varBoolean);
  chkUtiAlp.Visible := fCfgSis('ALPKNK', varBoolean);

  lblAgruparDocAppTaEntregue.Visible := fCfgSis('MATDIS', varBoolean);
  dbeAgruparDocAppTaEntregue.Visible := lblAgruparDocAppTaEntregue.Visible;
  cllAgruparDocAppTaEntregue.Visible := lblAgruparDocAppTaEntregue.Visible;

  pnlLimitaContratoLocacao.Visible := fCfgSis('LOCEQU', varBoolean) And fCfgSis('LIMCTR', varBoolean);
  pnlCompGrp2.Visible := pnlPermut.Visible Or pnlLimitaContratoLocacao.Visible;

  chkRecWpp.Visible := ((fCfgSis('UTIWPP', varBoolean)) and (fCfgSis('WHACLI', varBoolean)));
  pnlNeocredit.Visible := (fCfgSis('NEOCHB') = 'S');
End;

function TfrmCadClientes.dbeCodCidChamaCadastro(Key: Word): string;
begin
  inherited;
  If fVerificaAcessoSistema(strPermiCadCid) Then
  Begin
    If fChamaCadCid(Key) <> Null Then
      pAtribuiTabelas;
  End;
end;

procedure TfrmCadClientes.dbeCodCidKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, dbeCodCid, edtNomCid, edtEstado, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(dbeCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.dbeCodAtiKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrAtiv: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  If fPesqAtividade(Self, dbeCodAti, edtAtividade, Nil, Key, arrAtiv) Then
  Begin
    if fValidaCampos(dbeCodAti, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.dbeCodVenKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrVen: TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, dbeCodVen, nil, qryConOpe, Key, arrVen) then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.dbeConBc1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If (Key = #13) And (fEmptyStr(TDBMemoFocus(Sender).Text))Then
  Begin
    Key := #0;
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.dbeCorresKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  Try
    If fPesqCliente(conCliSimples, Self, dbeCorres, edtCorres, nil, Key, arrSel) Then
    Begin
      If (fValidaCampos(dbeCorres)) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmCadClientes.dbeCorresKeyPress]');
    End;
  End;

end;

procedure TfrmCadClientes.dbeCrmCatKeyPress(Sender: TObject; var Key: Char);
Var
  arrFre: TConsultasArray;
begin
  inherited;
  If fPesqCategoriaCRM(Self, dbeCrmCat, edtDesCat, nil, Key, arrFre) Then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.dbeCrmFaiKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFai: TConsultasArray;
begin
  inherited;
  If fPesqFaixaFaturamentoCRM(Self, dbeCrmFai, edtDesFai, Nil, Key, arrFai) Then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.dbeCrmFreKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFre: TConsultasArray;
begin
  inherited;
  if fPesqFrequenciaCRM(Self, dbeCrmFre, edtDesFre, nil, Key, arrFre) then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.dbeCrmPorKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFre: TConsultasArray;
begin
  inherited;
  if fPesqPorteCRM(Self, dbeCrmPor, edtDesCrmPor, nil, Key, arrFre) then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.dbeDesOpeEnter(Sender: TObject);
begin
  inherited;
  pgcDados.ShowHint := False;
  HintControler.ShowHint(Self.Left + dbeDesOpe.Left + dbeDesOpe.Width,
                         50 + Self.Top + dbeDesOpe.Top + dbeDesOpe.Height,
                         '',
                         'O valor do campo "Despesas Operacionais Complementar" ' + #13#10 +
                         'será somado ao valor das despesas operacionais do produto ' + #13#10 +
                         'no cálculo do preço de custo dos documentos de venda!');
end;

procedure TfrmCadClientes.dbeDesOpeExit(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
  pgcDados.ShowHint := True;
end;

procedure TfrmCadClientes.dbeDouComKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {****************************************************************}
  {* RETIRADO DO ONEXIT POIS ESTAVA AFETANDO A MUDANÇA DE PÁGINAS *}
  {*************************************************************PZ*}
  If (Key = #13) Then
    pProximaPagina;
end;

procedure TfrmCadClientes.dbeEndComChange(Sender: TObject);
begin
  inherited;
  fSomaCaracteresEndereco
end;

procedure TfrmCadClientes.dbeEndereChange(Sender: TObject);
begin
  inherited;
  fSomaCaracteresEndereco
end;

procedure TfrmCadClientes.dbeEndNumChange(Sender: TObject);
begin
  inherited;
  fSomaCaracteresEndereco
end;

procedure TfrmCadClientes.dbeEnqIPIKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqEnquadramentoIPI(Self, dbeEnqIPI, nil, nil, Key, arrSel, True, Copy(cbxTributacaoIPI.Text,1,1)) Then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.dbeCodRepKeyPress(Sender: TObject; var Key: Char);
  Var
    arrRep: TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, dbeCodRep, nil, qryConOpe, Key, arrRep) then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadClientes.dbeCodSubChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadSubReg(Key);
  pAtribuiTabelas;
end;

procedure TfrmCadClientes.dbeCodSubKeyPress(Sender: TObject; var Key: Char);
Var
  arrSubReg: TConsultasArray;
begin
  inherited;
  If fPesqSubRegiao(Self, dbeCodSub, edtDesSub, Nil, Key, arrSubReg) Then
  Begin
    If fValidaCampos(dbeCodSub, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.edtCodUniKeyPress(Sender: TObject; var Key: Char);
var
  chrKey: Char;
  arrUnidades: TConsultasArray;
begin
  inherited;
  chrKey := Key;
  if fPesqUnidade(Self, edtCodUni, edtDesUni, Nil, Nil, chrKey, arrUnidades) then
  begin
    If fValidaCampos(edtCodUni, True) Then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmCadClientes.pLimpaCamposEmpCli;
begin
  edtCodEmp.Clear;
  edtNomEmp.Clear;
  edtConcon.Clear;
end;

procedure TfrmCadClientes.pLimpaDadosProdutos;
begin
  If (assigned(cdsCliPro)) And (cdsCliPro.Active) Then
    cdsCliPro.EmptyDataSet;
end;

procedure TfrmCadClientes.pLimpaEdits;
begin
  edtNomOpe.Clear;
  edtNomCid.Clear;
  edtEstado.Clear;
  edtVendedor.Clear;
  edtRepresentante.Clear;
  edtAtividade.Clear;
  edtCidCob.Clear;
  edtEstCob.Clear;
  edtDesReg.Clear;
  edtDesSub.Clear;
  dbeDescEnqIPI.Clear;
  edtCliFid.Clear;
end;

function TfrmCadClientes.dbeCidCobChamaCadastro(Key: Word): string;
begin
  inherited;
  If fVerificaAcessoSistema(strPermiCadCid) Then
  Begin
    If fChamaCadCid(Key) <> Null Then
      pAtribuiTabelas;
  End;
end;

procedure TfrmCadClientes.dbeCidCobKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, dbeCidCob, edtCidCob, edtEstCob, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(dbeCidCob, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.pAtualizaCadFic(strCodCli : String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFIC ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FIC_CODCLI = :CODCLI ';

  With qryCadFic Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := strCodCli;
    Open;
  End;

end;

procedure TfrmCadClientes.pAtualizaInfCre;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CLI_INFCRE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';

  With qryInfCre Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
    Open;
  End;
end;

procedure TfrmCadClientes.pAtualizaTipAbf;
  Var
    strCodCli: String;
    strIndust: String;
    strProRur: String;
begin
  If (qryTabela.Active) And (Not qryTabela.FieldByName('CLI_CODCLI').IsNull) Then
  Begin
    strCodCli := qryTabela.FieldByName('CLI_CODCLI').AsString;
    strIndust := qryTabela.FieldByName('CLI_INDUST').AsString;
    strProRur := qryTabela.FieldByName('CLI_PRORUR').AsString;

    lblAbfDes.Caption := fRetDesTipoAbf('C', strCodCli, strIndust, strProRur);
    pExibeCamposAbreviacao(True);
  End
  Else
    pExibeCamposAbreviacao(False);
end;

procedure TfrmCadClientes.btnExcluirCCClick(Sender: TObject);
begin
  strStatusContaContabil := 'DELETANDO';

  If cdsEmpCli.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 1 Then
  Begin
    Try
      fStartTransaction;
      pDeletaRegEmpCli;
      fCommit;

      cdsEmpCli.Delete;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmCadFornecedores.btnExcluirCCClick]');
      End;
    End;
  End;

  pControlaBotoes;
end;

procedure TfrmCadClientes.btnExcluirClick(Sender: TObject);
begin

  try
    {Logs}
    pAddTabelasLog;
    Try
      blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
      inherited;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmCadClientes.btnExcluirClick]');
      End;
    End;
  finally
    if Assigned(LogAltCadCli) then
      LogAltCadCli.pProcessarLogs;
  end;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pCarregaDadosAdicionais;
  pOrgaoPublicoForaDoEstado;
  pCarregaContatos(qryTabela.FieldByName('CLI_CODCLI').AsString);
  pCarregaProdutos(qryTabela.FieldByName('CLI_CODCLI').AsString);
  pCarregaVeiculos(qryTabela.FieldByName('CLI_CODCLI').AsString);
  pCarregaRefComerciais(qryTabela.FieldByName('CLI_CODCLI').AsString);
  btnFichaCli.Enabled := Not qryTabela.IsEmpty;
  pCarregaBairroAtende(qryTabela.FieldByName('CLI_CODCLI').AsString);
  pCarregaPlanoDeContasPorEmpresa('CLINCO', dbeCodCli.Text, FcdsNCO);
  pCarregaResumo(qryTabela.FieldByName('CLI_CODCLI').AsString, fRetDesTipoAbf('C', qryTabela.FieldByName('CLI_CODCLI').AsString));
  blnCadastroModificado := False;
end;

function TfrmCadClientes.fValidaEstadoCivil(strEstCiv: String): Boolean;
begin
  Result := False;
  If fEmptyStr(strEstCiv) Then
    Result := True
  Else
  Begin
    If CharInSet(strEstCiv[1], ['S','C','M','O']) Then
      Result := True;
  End;
end;

function TfrmCadClientes.fValidaPortadores: Boolean;
begin
  Result := True;// Liberado no Requisito: 63657
  {****************************************************************************}
  {* ACEITA GRAVAR:                                                           *}
  {*   (A) PORTADOR1 PRENCHIDO E PORTADOR2 VAZIO   OU                         *}
  {*   (B) PORTADOR1 VAZIO E PORTADOR2 VAZIO       OU                         *}
  {*   (C) PORTADOR1 PREENCHIDO E PORTADOR2 PREENCHIDO                        *}
  {*************************************************************************RN*
  Result := ((Not fEmptyStr(dbeCodPor.Text)) And (fEmptyStr(dbeCodPor2.Text))) Or
            ((fEmptyStr(dbeCodPor.Text)) And (fEmptyStr(dbeCodPor2.Text))) Or
            (((Not fEmptyStr(dbeCodPor.Text)) And (Not fEmptyStr(dbeCodPor2.Text))));

  If (Not Result) Then
    fMensagem('ATENÇÃO!', 'Para informar o Portador (2) é obrigatório informar o Portador (1)', ['&OK']);}
end;

function TfrmCadClientes.fValidarPendenciasParaInativar: Boolean;
  Var
    qryVal: TUniQuery;
    stlMsg: TStringList;
begin
  qryVal := fCriaQuery;
  stlMsg := TStringList.Create;
  Try
    With qryVal, SQL Do
    Begin
      Add('SELECT');
      Add('  FGO_NUMDOC, FGO_CODEMP, FGO_CODVEN, FGO_DTAENT, FGO_VLRCON');
      Add('FROM');
      Add('  FATGOR');
      Add('WHERE');
      Add('  FGO_CODCLI = :CODCLI AND');
      Add('  FGO_ESPDOC = :ESPDOC AND');
      Add('  FGO_JAFATU = 0 ');

      ParamByName('CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
      ParamByName('ESPDOC').AsString := 'OR';
      Open;

      If RecordCount > 0 Then
      Begin
        stlMsg.Add('------------------ ORÇAMENTOS EM ABERTO --------------------');
        stlMsg.Add('| DTA.EMISSÃO |      DOCUMENTO      | VEN |      VALOR     |');
        stlMsg.Add('------------------------------------------------------------');
        While Not Eof Do
        Begin
          stlMsg.Add('|  ' + FormatDateTime('dd/mm/yyyy', FieldByName('FGO_DTAENT').AsDateTime) +
                     ' | ' + fPadL(FieldByName('FGO_NUMDOC').AsString, 12) +'-OR-'+ FieldByName('FGO_CODEMP').AsString +
                     ' | ' + FieldByName('FGO_CODVEN').AsString +
                     ' | ' + fPadL(FormatFloat('#,##0.00', FieldByName('FGO_VLRCON').AsFloat), 14) + ' |');
          Next;
        End;
        stlMsg.Add('------------------------------------------------------');
        stlMsg.Add('');
        stlMsg.Add('');
      End;

      Close;
      ParamByName('ESPDOC').AsString := 'PD';
      Open;

      If RecordCount > 0 Then
      Begin
        stlMsg.Add('-------------------- PEDIDOS EM ABERTO ---------------------');
        stlMsg.Add('| DTA.EMISSÃO |      DOCUMENTO      | VEN |      VALOR     |');
        stlMsg.Add('------------------------------------------------------------');
        While Not Eof Do
        Begin
          stlMsg.Add('|  ' + FormatDateTime('dd/mm/yyyy', FieldByName('FGO_DTAENT').AsDateTime) +
                     ' | ' + fPadL(FieldByName('FGO_NUMDOC').AsString, 12) +'-PD-'+ FieldByName('FGO_CODEMP').AsString +
                     ' | ' + FieldByName('FGO_CODVEN').AsString +
                     ' | ' + fPadL(FormatFloat('#,##0.00', FieldByName('FGO_VLRCON').AsFloat), 14) + ' |');
          Next;
        End;
        stlMsg.Add('------------------------------------------------------');
        stlMsg.Add('');
        stlMsg.Add('');
      End;

      Close;
      
      Clear;
      Add('SELECT');
      Add('  CTR_DTACAD,');
      Add('  CTR_DTAVEN,');
      Add('  CTR_NUMDUP,');
      Add('  CTR_ESPDOC,');
      Add('  CTR_CODEMP,');
      Add('  CTR_CODVEN,');
      Add('  CTR_VALDUP');
      Add('FROM');
      Add('  CADREC ');
      Add('WHERE');
      Add('  CTR_CODCLI = :CODCLI AND');
      Add('  CTR_DTAREC IS NULL');

      ParamByName('CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
      Open;

      If RecordCount > 0 Then
      Begin
        stlMsg.Add('------------------- CONTAS A RECEBER EM ABERTO -----------------------------');
        stlMsg.Add('| DT.CADASTRO | DT.VENCIMENTO | DOCUMENTO           | VEN |      VALOR     |');
        stlMsg.Add('----------------------------------------------------------------------------');
        While Not Eof Do
        Begin
          stlMsg.Add('| '   + FormatDateTime('dd/mm/yyyy', FieldByName('CTR_DTACAD').AsDateTime) +
                     '  |  '+ FormatDateTime('dd/mm/yyyy', FieldByName('CTR_DTAVEN').AsDateTime) +
                     '   | '+ FieldByName('CTR_NUMDUP').AsString +'-'+ FieldByName('CTR_ESPDOC').AsString +'-'+ FieldByName('CTR_CODEMP').AsString +
                     ' | '  + FieldByName('CTR_CODVEN').AsString +
                     ' | '  + fPadL(FormatFloat('#,##0.00', FieldByName('CTR_VALDUP').AsFloat), 14) +' |');
          Next;
        End;
        stlMsg.Add('----------------------------------------------------------------------------');
        stlMsg.Add('');
      End;

      If stlMsg.Count = 0 Then
        Result := True
      Else
      Begin
        pCriarFormularios(TfrmConfirmacaoMemo, frmConfirmacaoMemo);
        Result := frmConfirmacaoMemo.fConfirma('Pendências do Cliente', 'Cliente possui pendências, deseja realmente inativar?', stlMsg.Text);
        pFreeAndNil(frmConfirmacaoMemo);
      End
    End;
  Finally
    FreeAndNil(qryVal);
    FreeAndNil(stlMsg);
  End;
end;

procedure TfrmCadClientes.grdCadEmbDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_DELETE) Then Begin
    If (btnGravar.Enabled) And
       (Not cdsCadEmb.IsEmpty) And
       (Not fEmptyStr(cdsCadEmb.FieldByName('AUTOINCREM').AsString)) Then Begin

      If ( fMensagem('CONFIRMAÇÃO!', 'Deseja remover o vínculo da embarcação ' +
         QuotedStr(cdsCadEmb.FieldByName('EMB_CODEMB').AsString + '-' + cdsCadEmb.FieldByName('EMB_NOMEMB').AsString) +
           ' com o cadastro do cliente?', ['&Sim', '&Não'], 1) = 1 ) Then Begin
        cdsCadEmb.Delete();
        grdCadEmbDados.ApplyBestFit();
        pSetFocus(edtCodEmb);
      End Else Begin
        pSetFocus(edtCodEmb);
      End;

      Key := 0;
    End;
  End;
end;

procedure TfrmCadClientes.grdQuaCliCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If (pnlQualificacao.Enabled) And (Not cdsCadQualificacao.IsEmpty) Then
  Begin
    edtCodQua.Text := cdsCadQualificacao.FieldByName('QUA_CODQUA').AsString;
    edtDesQua.Text := cdsCadQualificacao.FieldByName('QUA_DESQUA').AsString;
    chkCertificado.checked := cdsCadQualificacao.FieldByName('QUA_CERQUA').AsString = 'S';
    memoObservacao.Texto := cdsCadQualificacao.FieldByName('QUA_OBSQUA').AsString;
    blnAltQuaCli := True;
    SetLength(arrQualificacao, 0);
    cxGridQuaCli.Enabled := False;
    pSetFocus(memoObservacao);
  End;
end;

procedure TfrmCadClientes.grdQuaCliKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_DELETE) And (pnlQualificacao.Enabled) Then
  Begin
    If (btnGravar.Enabled) And
       (Not cdsCadQualificacao.IsEmpty) Then
    Begin
      If ( fMensagem('CONFIRMAÇÃO!', 'Deseja remover o vínculo da Qualificação ' +
         QuotedStr(cdsCadQualificacao.FieldByName('QUA_CODQUA').AsString) +
           ' com o cadastro do cliente?', ['&Sim', '&Não'], 1) = 1 ) Then
      Begin
        cdsCadQualificacao.Delete();
        pSetFocus(edtCodQua);
      End
      Else
      Begin
        pSetFocus(edtCodQua);
      End;

      Key := 0;
    End;
  End
  Else
  If (Key = VK_RETURN) And (pnlQualificacao.Enabled) And (Not cdsCadQualificacao.IsEmpty) Then
  Begin
    edtCodQua.Text := cdsCadQualificacao.FieldByName('QUA_CODQUA').AsString;
    edtDesQua.Text := cdsCadQualificacao.FieldByName('QUA_DESQUA').AsString;
    chkCertificado.checked := cdsCadQualificacao.FieldByName('QUA_CERQUA').AsString = 'S';
    memoObservacao.Texto := cdsCadQualificacao.FieldByName('QUA_OBSQUA').AsString;
    blnAltQuaCli := True;
    SetLength(arrQualificacao, 0);
    cxGridQuaCli.Enabled := False;
    pSetFocus(memoObservacao);
    Key := 0;
  End;
end;

procedure TfrmCadClientes.grdEmpCliKeyPress(Sender: TObject; var Key: Char);
  Var
    strDireitos: String;
begin
  inherited;
  If fValidarDirEspecificos(strDireitos, strLoginUsuarioLogado, strNomeForm) Then
  Begin
    If (Pos('A', strDireitos) > 0) And (Key = #13) Then
      btnAlterarCCClick(Sender);
  End;
end;

procedure TfrmCadClientes.grdEmpresaPrioridadeDBTableViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (key = VK_DELETE) and (cdsEmpresaPrioridade.Active) and (cdsEmpresaPrioridade.RecordCount > 0) and (cdsEmpresaPrioridade.RecNo > 0) then
  begin
    if fMensagem('ATENÇÃO!', 'Deseja excluir o registro selecionado?', ['&Sim', '&Não'],2) = 1 then
    begin
      cdsEmpresaPrioridade.Delete;
    end;
  end;
end;

procedure TfrmCadClientes.imgCliDblClick(Sender: TObject);
begin
  inherited;

  If qryTabela.State = dsInsert Then
  Begin
    fMensagem('', 'Salve o cliente antes de cadastrar a imagem!', ['&Ok']);
    Exit;
  End;

  If qryTabela.isEmpty Then
  Begin
    fMensagem('', 'Selecione um cliente para continuar!', ['&Ok']);
    Exit;
  End;

  if qryTabela.Active then
  begin
    TfrmImagens.pAbrirImagens(tiCliente, qryTabela.FieldByName('CLI_CODCLI').AsString, (qryTabela.State <> dsEdit));
    pCarregaImagem;
  end;
end;

procedure TfrmCadClientes.pCarregaImagem;
Begin
  if (qryTabela.Active) And (Not fEmptyStr(qryTabela.FieldByName('CLI_CODCLI').AsString)) Then
  Begin
    imgCli.Picture := nil;
    Application.ProcessMessages;

    Case fCarregaImagemCliente(qryTabela.FieldByName('CLI_CODCLI').AsString, imgCli.Picture) of
      riOk   :
      Begin
        imgCli.Visible := True;
        lblErrImg.Visible := False;
      End;
      riErro :
      Begin
        imgCli.Visible := False;
        lblErrImg.Visible := True;
      End;
      riNulo :
      Begin
        imgCli.Visible := False;
        lblErrImg.Visible := False;
      End;
    End;
  End
  Else
    imgCli.Picture := nil;

  Application.ProcessMessages;
End;


procedure TfrmCadClientes.lstDiaFixClickCheck(Sender: TObject);
begin
  inherited;
  pHabilitaDiaFixo;
end;

procedure TfrmCadClientes.lstDiaMesClickCheck(Sender: TObject);
begin
  inherited;
  pHabilitaDiaFixo;
end;

procedure TfrmCadClientes.mmCerCttKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If (Key = #13) And (fEmptyStr(TMemoFocus(Sender).Text))Then
  Begin
    Key := #0;
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.mmConEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If (Key = #13) And (fEmptyStr(TMemoFocus(Sender).Text))Then
  Begin
    Key := #0;
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.mnuAtivarMododeOrdenacaoClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmOrdemPageControl, frmOrdemPageControl);
    frmOrdemPageControl.objPageControlOrder := objPageControlOrder;
    frmOrdemPageControl.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  pFreeAndNil(frmOrdemPageControl);
end;

procedure TfrmCadClientes.mskPlaVeiKeyPress(Sender: TObject; var Key: Char);
  Var
    arrVei: TConsultasArray;
begin
  inherited;
  {*****************************}
  {* NOVA CONSULTA DE VEICULOS *}
  {**************************MM*}
  If fPesqVeiculos(Self, mskPlaVei, nil, Nil, Key, arrVei, True, False,  ' VEI_STATUS = "A" ') Then
  Begin
    If fValidaCampos(mskPlaVei, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.btnPesquisaClick(Sender: TObject);
Var
  chrKey    : Char;
  arrSel    : TConsultasArray;
  objfrmPnl : TPanelCxClientes;
begin
  //Utilizado somente pelo frmCRM
  If blnUtilizarCrm Then
  Begin
    pPesquisaClienteCRM;
  End
  Else
  Begin
    chrKey    := '?';
    objfrmPnl := nil;

    try
      objfrmPnl := TPanelCxClientes.Create(TfrmPnlDadosCliente);
      objfrmPnl.blnApenasLegenda := (fCfgSis('IMGCLI') = 'N');
      objfrmPnl.strNomForm := self.name;

      fPesqCliente(conCliCompleta, Self, Nil, Nil, qryTabela, chrKey, arrSel, True, objfrmPnl,
        False, '', '', True, '', '', tfvCadCliente);

    finally
      if Assigned(objfrmPnl) then
        FreeAndNil(objfrmPnl);
    end;
  End;

  pCarregarCliente;
  pCarregaPlanoDeContasPorEmpresa('CLINCO', dbeCodCli.Text, FcdsNCO);
  pOrgaoPublicoForaDoEstado;

  fValidaCampos(dbeCgcCpf);
end;

procedure TfrmCadClientes.btnPlaNcoClick(Sender: TObject);
begin
  inherited;
  pPlanoDeContasPorEmpresa(dbeCodCli.Text, 'CLINCO', qryTabela.FieldByName('CLI_PLANCO').AsString, qryTabela.State, FcdsNCO, True);
end;

function TfrmCadClientes.dbeCodVenChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadOpe(Key);
  pAtribuiTabelas;
end;

function TfrmCadClientes.dbeCodAtiChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadAti(Key);
  pAtribuiTabelas;
end;

procedure TfrmCadClientes.FormActivate(Sender: TObject);
begin
  inherited;
  If blnArqCliCrm Then
  Begin
    pProcuraBotaoArqAnexClienteCRM;
    btnCancelaClick(Sender);
    pSetFocus(btnSair);
  End;
end;

procedure TfrmCadClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If (Not blnCadContato) Then
    inherited;

  If Action <> caNone Then
  Begin

    if Assigned(LogAltCadCli) then
      FreeAndNil(LogAltCadCli);

    SetLength(arrCamposChave, 0);

    FreeAndNil(objRedeLojas);
    FreeAndNil(FCliEndEntrega);

    If Assigned(FCliFazendas) Then
      FreeAndNil(FCliFazendas);

    qryTabela.AfterScroll := Nil;
    qryTabela.AfterOpen   := Nil;
    dtsTabela.DataSet     := Nil;

    FreeAndNil(cdsCliVendedores);
    FreeAndNil(dspCliVendedores);

    FreeAndNil(qryTabela);
    FreeAndNil(qryCadFic);

    FreeAndNil(qryInfCre);

    FreeAndNil(qryTipClg);
    FreeAndNil(qryCadAti);
    FreeAndNil(qryCadCid);
    FreeAndNil(qryResumo);

    If Assigned(objCliPro) Then
      FreeAndNil(objCliPro);

    FreeAndNil(dspCliPro);
    FreeAndNil(cdsCliPro);

    If Assigned(objCliVei) Then
      FreeAndNil(objCliVei);

    If Assigned(lstVeiculos) Then
      FreeAndNil(lstVeiculos);

    If Assigned(lstContatos) Then
      FreeAndNil(lstContatos);

    If fVerificaAcessoSistema('ORDABA', strLoginUsuarioLogado) Then
    Begin
      Try
        objPageControlOrder.pSavePageOrder(ExtractFilePath(Application.ExeName) + '\PageOrderCadClientes'+strLoginUsuarioLogado);
      Except
        On E: EFCreateError do
          pMensagemOk('Não foi possível salvar o posicionamento das guias para o usuário.');
        On E: Exception do
          pMensagensErro(E.Message, '[TfrmCadClientes.FormClose]');
      End;
    End;

    FreeAndNil(cdsCliVendedoresMar);
    FreeAndNil(dspCliVendedoresMar);

    FreeAndNil(cdsCliFNP);
    FreeAndNil(dspCliFNP);
    FreeAndNil(cdsCliMNP);
    FreeAndNil(dspCliMNP);
  End;
end;

procedure TfrmCadClientes.pAtribuiMascaraCgcRefComerciais;
begin
  If edtCgcCpf.Text = '1' Then
    edtCgcEmp.EditMask := fRetMascaraC_G_C_(FPais, C_G_C_)
  Else
  If edtCgcCpf.Text = '2' Then
    edtCgcEmp.EditMask := fRetMascaraC_G_C_(FPais, C_P_F_)
  Else
    edtCgcEmp.EditMask := '';

  Application.ProcessMessages;
end;

procedure TfrmCadClientes.pAtribuiTabelas;
begin
  qryConAti := qryCadAti;
  qryConCid := qryCadCid;
  qryConCiC := qryCadCid;
  qryConCiE := qryCadCid;
  qryConClg := qryTipClg;
end;

procedure TfrmCadClientes.btnHerancaClick(Sender: TObject);
var
  i      : Integer;
  qryAux : TUniQuery;
  strSQL : String;
begin

  inherited;

  Try

    pCriarFormularios(TfrmHerancaCliente, frmHerancaCliente);
    frmHerancaCliente.ShowModal;

    If frmHerancaCliente.blnConfirma Then
    Begin

      if not frmHerancaCliente.qryGenCli.IsEmpty then
      begin

        {Realiza cópia GERAL dos dados do cliente}
        for i := 0 to frmHerancaCliente.qryGenCli.FieldCount -1 do
        begin
          if (qryTabela.FindField(frmHerancaCliente.qryGenCli.Fields[i].FieldName) <> nil) then
          begin
            qryTabela.FindField(frmHerancaCliente.qryGenCli.Fields[i].FieldName).Value :=
            frmHerancaCliente.qryGenCli.Fields[i].Value;
          end;
        end;

        {APAGA - Código do cliente}
        qryTabela.FieldByName('CLI_CODCLI').Clear;

        {APAGA - Informações de ùltima e maior compra}
        qryTabela.FieldByName('CLI_DOUCOM').Clear;
        qryTabela.FieldByName('CLI_ULTCOM').Clear;
        qryTabela.FieldByName('CLI_VRUCOM').Clear;

        qryTabela.FieldByName('CLI_DOMCOM').Clear;
        qryTabela.FieldByName('CLI_DTMCOM').Clear;
        qryTabela.FieldByName('CLI_VRMCOM').Clear;

        {APAGA - Informações de Primeira compra}
        qryTabela.FieldByName('CLI_PRICOM').Clear;

        {APAGA - Última alteração, operador e atualiza data de cadastro}
        qryTabela.FieldByName('CLI_DTACAD').AsDateTime := VS_Date;
        qryTabela.FieldByName('CLI_DTAALT').Clear;
        qryTabela.FieldByName('CLI_CODOPE').Clear;

        If (blnLimCredAut) Then
          qryTabela.FieldByName('CLI_LIMCRE').AsFloat := 0;

        {Realiza cópia das demais TABELAS}

        {Contatos}
        pCarregaContatos(frmHerancaCliente.strCodCliente, True);

        {Endereços de Entrega}
        qryAux := fCriaQuery();

        try

          strSQL := '';
          strSQL := strSQL + ' SELECT    ';
          strSQL := strSQL + '  ENTCLI.* ';
          strSQL := strSQL + ' FROM      ';
          strSQL := strSQL + '   ENTCLI  ';
          strSQL := strSQL + ' WHERE     ';
          strSQL := strSQL + '   ETC_CODCLI = :CODCLI ';

          qryAux.Close;
          qryAux.SQL.Clear;
          qryAux.SQL.Add(strSQL);
          qryAux.ParamByName('CODCLI').AsString := frmHerancaCliente.strCodCliente;
          qryAux.Open;

          if not qryAux.IsEmpty then
          begin

            qryAux.First;

            while not qryAux.Eof do
            begin

              FCliEndEntrega.cdsConsulta.Append;

              for i := 0 to qryAux.FieldCount -1 do
              begin
                if (FCliEndEntrega.cdsConsulta.FindField(qryAux.Fields[i].FieldName) <> nil) then
                begin
                  if (qryAux.Fields[i].FieldName <> 'ETC_CODCLI') and
                     (qryAux.Fields[i].FieldName <> 'AUTOINCREM') then
                    FCliEndEntrega.cdsConsulta.FindField(qryAux.Fields[i].FieldName).Value := qryAux.Fields[i].Value;
                end;
              end;

              FCliEndEntrega.cdsConsultaETC_CODCLI.AsString := '';
              FCliEndEntrega.cdsConsultaAUTOINCREM.AsString := '';

              FCliEndEntrega.cdsConsulta.Post;

              qryAux.Next;

            end;

          end;

        finally
          FreeAndNil(qryAux);
        end;

        {Quadro Societário (Somente campo: Capital Social), Ref. Bancárias}
        qryAux := fCriaQuery();

        try

          strSQL := '';
          strSQL := strSQL + 'SELECT ';
          strSQL := strSQL + '  * ';
          strSQL := strSQL + 'FROM ';
          strSQL := strSQL + '  CADFIC ';
          strSQL := strSQL + 'WHERE ';
          strSQL := strSQL + '  FIC_CODCLI = :CODCLI ';

          qryAux.Close;
          qryAux.SQL.Clear;
          qryAux.SQL.Add(strSQL);
          qryAux.ParamByName('CODCLI').AsString := frmHerancaCliente.strCodCliente;
          qryAux.Open;

          if not qryAux.IsEmpty then
          begin
            if not (qryCadFic.State IN [dsEdit, dsInsert]) then
              qryCadFic.Append;

            for i := 0 to qryAux.FieldCount -1 do
            begin
              if (qryCadFic.FindField(qryAux.Fields[i].FieldName) <> nil) then
              begin
                if qryAux.Fields[i].FieldName <> 'FIC_CODCLI' then
                  qryCadFic.FindField(qryAux.Fields[i].FieldName).Value := qryAux.Fields[i].Value;
              end;
            end;
          end;

        finally
          FreeAndNil(qryAux);
        end;

        {Ref. Comerciais}
        pCarregaRefComerciais(frmHerancaCliente.strCodCliente, True);

        {Informações de Crediário}
        qryAux := fCriaQuery();

        try

          strSQL := '';
          strSQL := strSQL + 'SELECT ';
          strSQL := strSQL + '  * ';
          strSQL := strSQL + 'FROM ';
          strSQL := strSQL + '  CLI_INFCRE ';
          strSQL := strSQL + 'WHERE ';
          strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';

          qryAux.Close;
          qryAux.SQL.Clear;
          qryAux.SQL.Add(strSQL);
          qryAux.ParamByName('CODCLI').AsString := frmHerancaCliente.strCodCliente;
          qryAux.Open;

          if not qryAux.IsEmpty then
          begin

            if not ( qryInfCre.State IN [dsEdit, dsInsert]) then
              qryInfCre.Append;

            for i := 0 to qryAux.FieldCount -1 do
            begin
              if (qryInfCre.FindField(qryAux.Fields[i].FieldName) <> nil) then
              begin
                if qryAux.Fields[i].FieldName <> 'CLI_CODCLI' then
                  qryInfCre.FindField(qryAux.Fields[i].FieldName).Value := qryAux.Fields[i].Value;
              end;
            end;

            pQueryInfCreAfterScroll(Nil);
          end;

        finally
          FreeAndNil(qryAux);
        end;

        {Relacionamento Cliente-Produto}
        if fCfgSis('CLIPRO') = 'S' then
          objCliPro.fRetProdutos(frmHerancaCliente.strCodCliente, cdsCliPro, dspCliPro, nil);

        {Veículos}
        If (fCfgSis('CLIVEI') = 'S') Then
          pCarregaVeiculos(frmHerancaCliente.strCodCliente);

        {Condições de Pagamento}
        qryAux := fCriaQuery();

        try

          strSQL := '';
          strSQL := strSQL + 'SELECT ';
          strSQL := strSQL + '  C.*, ';
          strSQL := strSQL + '  (SELECT D.CND_DESCRI FROM CADCND D WHERE C.CND_CODCND = D.CND_CODIGO) AS CND_DESCRI ';
          strSQL := strSQL + 'FROM ';
          strSQL := strSQL + '  CLICND C ';
          strSQL := strSQL + 'WHERE ';
          strSQL := strSQL + '  C.CND_CODCLI = :CODCLI AND ';

          If fCfgSis('USACND', varBoolean) Then
            strSQL := strSQL + '  C.CND_CODCND IS NOT NULL '
          Else
            strSQL := strSQL + '  IFNULL(C.CND_CNDPAG, " ") <> " " ';

          qryAux.Close;
          qryAux.SQL.Clear;
          qryAux.SQL.Add(strSQL);
          qryAux.ParamByName('CODCLI').AsString := frmHerancaCliente.strCodCliente;
          qryAux.Open;

          if not qryAux.IsEmpty then
          begin

            qryAux.First;

            while not qryAux.Eof do
            begin

              cdsCliCnd.Append;
              cdsCliCndAUTOINCREM.AsString := '';
              cdsCliCndCND_CODCLI.AsString := '';
              cdsCliCndCND_CODCND.AsString := qryAux.FieldByName('CND_CODCND').AsString;
              cdsCliCndCND_SUGEST.AsString := qryAux.FieldByName('CND_SUGEST').AsString;
              cdsCliCndCND_DESCRI.AsString := qryAux.FieldByName('CND_DESCRI').AsString;
              cdsCliCndCND_CNDPAG.AsString := qryAux.FieldByName('CND_CNDPAG').AsString;
              cdsCliCnd.Post;

              qryAux.Next;

            end;

          end;

        finally
          FreeAndNil(qryAux);
        end;

        {Profissionais}
        qryAux := fCriaQuery();

        try

          strSQL := '';
          strSQL := strSQL + 'SELECT ';
          strSQL := strSQL + '  C.*, ';
          strSQL := strSQL + '  (SELECT DIV_NOMDIV FROM CADDIV WHERE DIV_CODDIV = C.DIV_CODDIV) AS DIV_NOMDIV, ';
          strSQL := strSQL + '  (SELECT CONCAT(A.ATI_CODATI,"-",A.ATI_DESATI) AS ATIVID ';
          strSQL := strSQL + '  FROM CADATI A INNER JOIN CADDIV D ON A.ATI_CODATI = D.DIV_CODATI ';
          strSQL := strSQL + '  WHERE D.DIV_CODDIV = C.DIV_CODDIV) AS DIV_NOMATI ';
          strSQL := strSQL + 'FROM ';
          strSQL := strSQL + '  CLIDIV C ';
          strSQL := strSQL + 'WHERE';
          strSQL := strSQL + '  C.DIV_CODCLI = :CODCLI ';

          qryAux.Close;
          qryAux.SQL.Clear;
          qryAux.SQL.Add(strSQL);
          qryAux.ParamByName('CODCLI').AsString := frmHerancaCliente.strCodCliente;
          qryAux.Open;

          if not qryAux.IsEmpty then
          begin

            qryAux.First;

            while not qryAux.Eof do
            begin

              cdsCliDiv.Append;
              cdsCliDivDIV_CODCLI.AsString := '';
              cdsCliDivDIV_SUGEST.AsString := qryAux.FieldByName('DIV_SUGEST').AsString;
              cdsCliDivDIV_NOMDIV.AsString := qryAux.FieldByName('DIV_NOMDIV').AsString;
              cdsCliDivDIV_NOMATI.AsString := qryAux.FieldByName('DIV_NOMATI').AsString;
              cdsCliDivDIV_CODDIV.AsString := qryAux.FieldByName('DIV_CODDIV').AsString;
              cdsCliDiv.Post;

              qryAux.Next;

            end;

          end;

        finally
          FreeAndNil(qryAux);
        end;

        {Conta Contábil/Empresa}
        qryAux := fCriaQuery();

        try

          strSQL := '';
          strSQL := strSQL + 'SELECT ';
          strSQL := strSQL + '  CCCLIE.*, ';
          strSQL := strSQL + '  CADEMP.EMP_NOMEMP ';
          strSQL := strSQL + 'FROM ';
          strSQL := strSQL + '  CCCLIE ';
          strSQL := strSQL + '  INNER JOIN CADEMP ON (CADEMP.EMP_CODEMP = CCCLIE.CCC_CODEMP) ';
          strSQL := strSQL + 'WHERE ';
          strSQL := strSQL + '  CCCLIE.CCC_CODCLI = :CODCLI ';

          qryAux.Close;
          qryAux.SQL.Clear;
          qryAux.SQL.Add(strSQL);
          qryAux.ParamByName('CODCLI').AsString := frmHerancaCliente.strCodCliente;
          qryAux.Open;

          if not qryAux.IsEmpty then
          begin

            qryAux.First;

            while not qryAux.Eof do
            begin

              cdsEmpCli.Append;
              cdsEmpCliCodEmp.AsString     := qryAux.FieldByName('CCC_CODEMP').AsString;
              cdsEmpCliNomEmp.AsString     := qryAux.FieldByName('EMP_NOMEMP').AsString;
              cdsEmpCliConcon.AsString     := qryAux.FieldByName('CCC_CONCON').AsString;
              cdsEmpCliCodigo.AsString     := '';
              cdsEmpCliAUTOINCREM.AsString := '';
              cdsEmpCli.Post;

              qryAux.Next;

            end;

          end;

        finally
          FreeAndNil(qryAux);
        end;

        {Bairros Atendidos}
        if fCfgSis('CLIBAT', varBoolean) then
        begin
          pCarregaBairroAtende(frmHerancaCliente.strCodCliente);
          cdsCliBat.Tag := -1;
        end;

        {Fazendas}
        If (fCfgSis('CADFAZ') = 'S') Then
        begin

          qryAux := fCriaQuery();

          try

            strSQL := '';
            strSQL := strSQL + ' SELECT     ';
            strSQL := strSQL + '   CADFAZ.* ';
            strSQL := strSQL + ' FROM       ';
            strSQL := strSQL + '   CADFAZ   ';
            strSQL := strSQL + ' WHERE      ';
            strSQL := strSQL + '   FAZ_CODCLI = :CODCLI ';

            qryAux.Close;
            qryAux.SQL.Clear;
            qryAux.SQL.Add(strSQL);
            qryAux.ParamByName('CODCLI').AsString := frmHerancaCliente.strCodCliente;
            qryAux.Open;

            if not qryAux.IsEmpty then
            begin

              qryAux.First;

              while not qryAux.Eof do
              begin

                FCliFazendas.cdsConsulta.Append;

                for i := 0 to qryAux.FieldCount -1 do
                begin
                  if (FCliFazendas.cdsConsulta.FindField(qryAux.Fields[i].FieldName) <> nil) then
                  begin
                    if (qryAux.Fields[i].FieldName <> 'FAZ_CODCLI') and
                       (qryAux.Fields[i].FieldName <> 'AUTOINCREM') and
                       (qryAux.Fields[i].FieldName <> 'FAZ_CODFAZ') then
                      FCliFazendas.cdsConsulta.FindField(qryAux.Fields[i].FieldName).Value := qryAux.Fields[i].Value;
                  end;
                end;

                FCliFazendas.cdsConsultaFAZ_CODCLI.AsString := '';
                FCliFazendas.cdsConsultaFAZ_CODFAZ.AsString := fAtualizaProCod('CADFAZ', 'FAZ_CODFAZ'); {Unique}
                FCliFazendas.cdsConsultaAUTOINCREM.AsString := fRetAutoIncrem('CADFAZ', VS_strCodEmp);

                FCliFazendas.cdsConsulta.Post;

                qryAux.Next;

              end;

            end;

          finally
            FreeAndNil(qryAux);
          end;

        end;

        {Inteligência de Vendas}
        if (VS_strHabilitarCRM) then
        begin
          cdsCliFor.qryQuery.Close;
          cdsCliFor.qryQuery.ParamByName('CODPRO').AsString := frmHerancaCliente.strCodCliente;
          cdsCliFor.fAbreClient(True, 'btnHerancaClick');
        end;

        {Embarcações}
        if fCfgSis('CADEMB', varBoolean) then
        begin
          pCarregarEmbarcacoes(frmHerancaCliente.strCodCliente);
        end;

        {Quadro Societário (Nova tabela: CLISCO)}
        pCarregaSocios(frmHerancaCliente.strCodCliente, True);

      end;

    End;

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmCadClientes.btnHerancaClick]');
    End;

  End;

  if frmHerancaCliente.qryGenCli.Active then
    frmHerancaCliente.qryGenCli.Close;

  pFreeAndNil(frmHerancaCliente);
  pSetFocus(dbeNumCep);

end;

procedure TfrmCadClientes.btnHisDebClick(Sender: TObject);
begin
  inherited;
  pMostrarContaCorrente(dbeCodCli.Text);
end;

procedure TfrmCadClientes.btnHlpEmailCobClick(Sender: TObject);
begin
  inherited;
  frxHelpEmailCobranca.DotMatrixReport           := False;
  frxHelpEmailCobranca.PrintOptions.PrintMode    := pmScale;
  frxHelpEmailCobranca.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelpEmailCobranca);
end;

procedure TfrmCadClientes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Not Self.Enabled Then
    Exit;

  If (pgcDados.ActivePage = tbsEntregas) And pnlEntregas.Enabled And
     (Key <> VK_DELETE) And (Key in [VK_F2, VK_F3, VK_F5]) Then
  Begin
    Exit;
  End
  Else If (pgcDados.ActivePage = tbsFazendas) And pnlFazendas.Enabled And
          (Key <> VK_DELETE) And (Key in [VK_F2, VK_F3, VK_F5]) Then
  Begin
    Exit;
  End
  Else
    inherited;

  If (Shift = [ssAlt]) And (Key = VK_F3) And (btnForMarNaoPermitidos.Enabled) Then
    btnForMarNaoPermitidos.Click

  Else If (Key = VK_F2) And btnObsCli.Enabled Then
    btnObsCli.Click

  Else If (Key = VK_F6) And btnHisDeb.Enabled Then
    btnHisDeb.Click

  Else If (Key = VK_F7) And btnResFin.Enabled Then
    btnResFin.Click

  Else If (Key = VK_F9) And btnVenCli.Enabled Then
    btnVenCli.Click

  Else If (Key = VK_F5) And btnContratos.Enabled  Then
    btnContratos.Click

  Else If (Key = VK_F3) And (btnTeleatendimento.Enabled) Then
    btnTeleatendimento.Click

  Else If (Key = VK_F8) And (btnFichaCli.Enabled) Then
    btnFichaCliClick(Sender)

  Else If (Key = VK_F10) And (btnInfCobr.Enabled) Then
    btnInfCobr.Click

  Else If (Key = VK_F11) And btnLogAlter.Enabled Then
    btnLogAlter.Click

  Else If (Key = VK_ESCAPE) Then
  Begin
    If (blnCadContato) Then
      btnCancela.Click
    Else If (Not dbgCliBat.Focused) Then
      btnSair.Click
  End

  Else If (Key = VK_F4) And (btnCliVen.Visible) Then
    AbrirCadastroVendedoresDoCliente

  Else If (Key = VK_RETURN) And (pgcDados.ActivePage = tbsObservacoes) Then
    pProximaPagina

  Else If (Shift = [ssAlt]) And (Key = VK_RIGHT) Then
    pProximaPagina

  Else If (Shift = [ssAlt]) And (Key = VK_LEFT) Then
    pPaginaAnterior;

  If (Key = VK_INSERT) And (edtCodEmb.Focused) Then Begin
    edtCodEmb.Text := fChamaCadEmbarcacoes(Key);
  End;
end;

procedure TfrmCadClientes.FormResize(Sender: TObject);
begin
  inherited;
  btnSair.Left := FlwBotoes.Width - btnSair.Width - 11;
  btnSair.Top := FlwBotoes.Height - btnSair.Height;
end;

function TfrmCadClientes.dbeCodCndChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadCnd(Key);
  pAtribuiTabelas;
end;

procedure TfrmCadClientes.btnRECAPClick(Sender: TObject);
var
  frmCadCliClassificacaoIPINCM: TfrmCadCliClassificacaoIPINCM;
begin
  inherited;

  try
    pCriarFormularios(TfrmCadCliClassificacaoIPINCM, frmCadCliClassificacaoIPINCM);
    frmCadCliClassificacaoIPINCM.cdsRECAP.Data := cdsClaRECAP.Data;
    frmCadCliClassificacaoIPINCM.ShowModal;

    if (frmCadCliClassificacaoIPINCM.blnConfirma) then
      cdsClaRECAP.Data := frmCadCliClassificacaoIPINCM.cdsRECAP.Data;
  finally
    pFreeAndNil(frmCadCliClassificacaoIPINCM);
  end;
end;

procedure TfrmCadClientes.btnResFinClick(Sender: TObject);
begin
  inherited;
  Try
    if qryTabela.State = dsEdit then
    begin
      fMensagem('ATENÇÃO!', 'Conclua a edição atual antes de acessar a funcionalidade.', ['&Ok']);
      Exit;
    end
    else if qryTabela.State = dsInsert then
    begin
      fMensagem('ATENÇÃO!', 'Selecione um cliente para continuar.', ['&Ok']);
      Exit;
    end;


    If Not fEmptyStr(dbeCodCli.Text) Then
    Begin
      if not (qryTabela.State in [dsInsert, dsEdit]) then
        pAddTabelasLog;

      pCriarFormularios(TfrmResFinanceiro,frmResFinanceiro);
      frmResFinanceiro.strCodCli := dbeCodCli.Text;
      frmResFinanceiro.pSetaAjusteData( fMensagem('Ajuste de Datas',
                                         'Ajusta vencimentos considerando Sábado/Domingo/Feriados?',
                                         ['&Sim','&Não'],2) = 1 );
      If Not fEmptyStr(dbeCodRed.Text) Then
        frmResFinanceiro.chkRedLoj.Enabled := True;
      frmResFinanceiro.blnPermiteEditarArquivosDeConsultaDeCredito := True;
      frmResFinanceiro.ShowModal;
      qryTabela.Refresh;
      blnChkRed := False;
      pFreeAndNil(frmResFinanceiro);
      pAtribuiTabelas;

      if not (qryTabela.State in [dsInsert, dsEdit]) then
        LogAltCadCli.pProcessarLogs;
    End
    Else
      fMensagem('ATENÇÃO!', 'É necessário escolher um Cliente!', ['&Ok']);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmCadClientes.btnResFinClick]');
    End;
  End;
end;

procedure TfrmCadClientes.btnTeleatendimentoClick(Sender: TObject);
  Var
    frmAtendimento : TfrmAtendimento;
begin
  inherited;
  Try

    pCriarFormularios(TfrmAtendimento,frmAtendimento);

    If Not fEmptyStr(dbeCodCli.Text) Then
      frmAtendimento.strCodCli := dbeCodCli.Text;

    frmAtendimento.ShowModal;
    pFreeAndNil(frmAtendimento);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmCadClientes.btnTeleatendimentoClick]');
    End;
  End;
end;

procedure TfrmCadClientes.dbeCodFpgKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrForma: TConsultasArray;
begin
  inherited;
  {***********************************}
  {* NOVA CONSULTA DE FORMA DE PAGTO *}
  {********************************RV*}
  If fPesqFormaPgto(conFpgSimples, Self, dbeCodFpg, edtDesFpg, Nil, Key, arrForma) Then
  Begin
    If fValidaCampos(dbeCodFpg, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadClientes.dbeCodFpgChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadFpg(Key);
  pAtribuiTabelas;
end;

procedure TfrmCadClientes.dbeTFtNEsEnter(Sender: TObject);
begin
  inherited;
  strFatTipAnt := dbeTFtNEs.Text;
end;

function TfrmCadClientes.dbeTipCliChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaTipCli(Key);
  pAtribuiTabelas;
end;

procedure TfrmCadClientes.dbeTipCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin

  If fPesqTipoCliente(Self, dbeTipCli, edtDesTpc, nil, Key, arrSel) Then
  Begin
    If (fValidaCampos(dbeTipCli, True)) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadClientes.pCarregaPortador(intOpc : Integer);
begin
  If ( intOpc = 1 ) Then
  Begin
    pPesquisaCadPor(Nil, qryConPor, dbeCodPor.Text);
    With qryConPor Do
    Begin
      edtDesPor.Text := FieldByName('POR_NOMPOR').AsString;
    End;
  End
  Else
  If ( intOpc = 2 ) Then
  Begin
    pPesquisaCadPor(Nil, qryConPor, dbeCodPor2.Text);
    With qryConPor Do
    Begin
      edtDesPor2.Text := FieldByName('POR_NOMPOR').AsString;
    End;
  End;
end;

procedure TfrmCadClientes.pCarregaPorteCrm;
begin
  edtDesCrmPor.Clear;
  If Not fEmptyStr(dbeCrmPor.Text) Then
    edtDesCrmPor.Text := fRetDesCrmPor(dbeCrmPor.Text);
end;

function TfrmCadClientes.dbeCodPor2ChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadPor(Key);
  pAtribuiTabelas;
end;

procedure TfrmCadClientes.dbeCodPor2KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  if fPesqPortador(conSimples, Self, dbeCodPor2, edtDesPor2, qryConPor, Key, arrSel) then
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);

end;

function TfrmCadClientes.dbeCodPorChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadPor(Key);
  pAtribuiTabelas;
end;

procedure TfrmCadClientes.dbeCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  if fPesqPortador(conSimples, Self, dbeCodPor, edtDesPor, qryConPor, Key, arrSel) then
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);

end;

procedure TfrmCadClientes.btnVenCliClick(Sender: TObject);
begin
  inherited;
  If (btnVenCli.Visible) And (btnVenCli.Enabled) Then
  Begin
    If Not fVerificaAcessoSistema('ACEF9_') Then
    Begin
      fMensagem('', 'Operador não tem direito de acesso em Vendas p/ Clientes!', ['&O k']);
      Exit;
    End;

    Try
      pCriarFormularios(TfrmRelFatVendasCliente,frmRelFatVendasCliente);
      frmRelFatVendasCliente.blnFaturamento := True;
      frmRelFatVendasCliente.blnSomenteVendas := fCfgSis('CCSOVE', varBoolean);
      frmRelFatVendasCliente.blnSenha := False;
      frmRelFatVendasCliente.edtCodCliente.Text := dbeCodCli.Text;
      frmRelFatVendasCliente.edtDesCliente.Text := dbeNomCli.Text;
      frmRelFatVendasCliente.blnCliCons := fClienteConsumidor(dbeNomCli.Text, False, True);
      frmRelFatVendasCliente.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[btnVenCliClick]');
    End;
    pFreeAndNil(frmRelFatVendasCliente);
  End;
end;

function TfrmCadClientes.CalculaTamanhoMensagem(AText: String): Integer;
  Var
    LMaxCaracter : Integer;
    LHeight : Integer;
    LQuantidadeCaracterAtual : Integer;
begin
  Try
    LHeight := 200;
    LMaxCaracter := 380;
    LQuantidadeCaracterAtual := Length(AText);

    If (LQuantidadeCaracterAtual <= 380) Then Exit(0);

    Result := Round((LQuantidadeCaracterAtual *  LHeight) / LMaxCaracter);
  Except
   On E : Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

end;


procedure TfrmCadClientes.cdsCliCndAfterPost(DataSet: TDataSet);
  Var
    intRecNo: Integer;
begin
  inherited;

  With DataSet do
  Begin
    If FieldByName('CND_SUGEST').AsString = 'S' Then
    Begin
      DisableControls;
      intRecNo := RecNo;
      First;
      While Not Eof Do
      Begin
        If (intRecNo <> RecNo) And (FieldByName('CND_SUGEST').AsString = 'S') Then
        Begin
          Edit;
          FieldByName('CND_SUGEST').AsString := 'N';
          Post;
        End;
        Next;
      End;
      RecNo := intRecNo;
      EnableControls;
    End;
  End;
end;

procedure TfrmCadClientes.cdsCliDivAfterPost(DataSet: TDataSet);
  Var
    intRecNo: Integer;
begin
  inherited;

  With DataSet do
  Begin
    If FieldByName('DIV_SUGEST').AsString = 'S' Then
    Begin
      DisableControls;
      intRecNo := RecNo;
      First;
      While Not Eof Do
      Begin
        If (intRecNo <> RecNo) And (FieldByName('DIV_SUGEST').AsString = 'S') Then
        Begin
          Edit;
          FieldByName('DIV_SUGEST').AsString := 'N';
          Post;
        End;
        Next;
      End;
      RecNo := intRecNo;
      EnableControls;
    End;
  End;
end;

procedure TfrmCadClientes.cdsDtaPerEntBeforePost(DataSet: TDataSet);
begin
  inherited;
  If (Not DataSet.FieldByName('MARCAD').AsBoolean) Then
  Begin
    DataSet.FieldByName('HRAINI').Value := Null;
    DataSet.FieldByName('HRAFIN').Value := Null;
    DataSet.FieldByName('HRAIN2').Value := Null;
    DataSet.FieldByName('HRAFI2').Value := Null;
    DataSet.FieldByName('HRAIN3').Value := Null;
    DataSet.FieldByName('HRAFI3').Value := Null;
  End

  Else If ((Not DataSet.FieldByName('HRAINI').IsNull) And
           (DataSet.FieldByName('HRAFIN').IsNull)) Or
          ((Not DataSet.FieldByName('HRAFIN').IsNull) And
           (DataSet.FieldByName('HRAINI').IsNull)) Then
  Begin
    DataSet.FieldByName('HRAINI').Value := Null;
    DataSet.FieldByName('HRAFIN').Value := Null;
  End

  Else If ((Not DataSet.FieldByName('HRAIN2').IsNull) And
           (DataSet.FieldByName('HRAFI2').IsNull)) Or
          ((Not DataSet.FieldByName('HRAFI2').IsNull) And
           (DataSet.FieldByName('HRAIN2').IsNull)) Then
  Begin
    DataSet.FieldByName('HRAIN2').Value := Null;
    DataSet.FieldByName('HRAFI2').Value := Null;
  End

  Else If ((Not DataSet.FieldByName('HRAIN3').IsNull) And
           (DataSet.FieldByName('HRAFI3').IsNull)) Or
          ((Not DataSet.FieldByName('HRAFI3').IsNull) And
           (DataSet.FieldByName('HRAIN3').IsNull)) Then
  Begin
    DataSet.FieldByName('HRAIN3').Value := Null;
    DataSet.FieldByName('HRAFI3').Value := Null;
  End

  Else If (pgcDados.ActivePage = tbsDatasControle) And
          (Not DataSet.FieldByName('HRAINI').IsNull) And
          (Not DataSet.FieldByName('HRAFIN').IsNull) And
          (DataSet.FieldByName('HRAINI').AsDateTime > DataSet.FieldByName('HRAFIN').AsDateTime) Then
  Begin
    fMensagem('','A hora inicial 1 deve ser menor que a hora final 1!',['&OK']);
    DataSet.FieldByName('HRAINI').Value := Null;
    DataSet.FieldByName('HRAFIN').Value := Null;
  End

  Else If (pgcDados.ActivePage = tbsDatasControle) And
          (Not DataSet.FieldByName('HRAIN2').IsNull) And
          (Not DataSet.FieldByName('HRAFI2').IsNull) And
          (DataSet.FieldByName('HRAIN2').AsDateTime > DataSet.FieldByName('HRAFI2').AsDateTime) Then
  Begin
    fMensagem('','A hora inicial 2 deve ser menor que a hora final 2!',['&OK']);
    DataSet.FieldByName('HRAIN2').Value := Null;
    DataSet.FieldByName('HRAFI2').Value := Null;
  End

  Else If (pgcDados.ActivePage = tbsDatasControle) And
          (Not DataSet.FieldByName('HRAIN3').IsNull) And
          (Not DataSet.FieldByName('HRAFI3').IsNull) And
          (DataSet.FieldByName('HRAIN3').AsDateTime > DataSet.FieldByName('HRAFI3').AsDateTime) Then
  Begin
    fMensagem('','A hora inicial 3 deve ser menor que a hora final 3!',['&OK']);
    DataSet.FieldByName('HRAIN3').Value := Null;
    DataSet.FieldByName('HRAFI3').Value := Null;
  End;
end;

procedure TfrmCadClientes.chkCertificadoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadClientes.chkCpfDevClick(Sender: TObject);
begin
  inherited;
  If fCfgSis('CPFSDV', VarBoolean) Then
  Begin
    dbeCpfDev.Visible := chkCpfDev.Visible And chkCpfDev.Checked;
    dbeNuCpnj.Visible := Not dbeCpfDev.Visible;

    If qryTabela.State in [dsEdit, dsInsert] Then
    Begin
      If dbeCpfDev.Visible Then
      Begin
        If qryTabela.State in [dsEdit, dsInsert] Then
        Begin
          dbeCpfDev.Field.Value := dbeNuCpnj.Field.Value;
          dbeNuCpnj.Field.Clear;
        End;

        pSetFocus(dbeCpfDev);
      End
      Else
      Begin
        If qryTabela.State in [dsEdit, dsInsert] Then
        Begin
          dbeNuCpnj.Field.Value := dbeCpfDev.Field.Value;
          dbeCpfDev.Field.Clear;
        End;

        pSetFocus(dbeNuCpnj);
      End;
    End;
  End;
end;

procedure TfrmCadClientes.chkProRurExit(Sender: TObject);
begin
  inherited;
  If (Assigned(qryTabela)) And (qryTabela.state in [dsInsert, dsEdit]) Then
    pAjustaIesUni;
end;

procedure TfrmCadClientes.cmbTipoPesquisaChange(Sender: TObject);
begin
  inherited;
  pHabilitaConsultaSCPC;
  btnConsultaSerasaPowerCurve.Enabled := UtilizaConsultaSerasaPowerCurve;
  btnConsultaSerasaExperian.Enabled   := UtilizaConsultaSerasaExperian;
  cbProdutoSerasa.Enabled := (cmbTipoPesquisa.ItemIndex = 1);

  If (cmbTipoPesquisa.ItemIndex <= 0) And (pgcDados.ActivePage = tbsCbrEnt) Then
    pProximaPagina;
end;

procedure TfrmCadClientes.cmpConsultaPOAChange(Sender: TObject);
 Var
     strDoc : String;
begin
  inherited;
  strDoc := qryTabela.FieldByName('CLI_C_G_C_').AsString;

  If femptyStr(strDoc) Then
     Exit;

  lbltipoConsulta.visible := False;
  cmpTipoConsultaPOA.visible  := False;

  If strDoc.Length = 11 Then
  Begin
     If cmpConsultaPOA.Text = 'Familia Positivo' Then
     Begin
       lbltipoConsulta.visible := True;
       cmpTipoConsultaPOA.visible  := True;
     End;

  End;

end;

procedure TfrmCadClientes.ConsultaSerasaPowerCurve;
  Var
    LConsultaSerasaPowerCurve: TConsultaSerasaPowerCurve;
    LAtualizar : Boolean;
    LDocumento: String;
    LDecisao:String;
begin

  Try
    Try

      If Not fVerificaAcessoSistema('CONSULTASPC') Then
      Begin
        objLiberacao.Clear;
        objLiberacao.strDirAce    := 'CONSULTASPC';
        objLiberacao.strMsgSen    := 'Consulta Serasa Power Curve';
        objLiberacao.strCodOpe    := strLoginUsuarioLogado;
        objLiberacao.strCodDig    := strLoginUsuarioLogado;
        objLiberacao.strCliente   := (dbeCodCli.Text + '-' + dbeNomCli.Text);
        objLiberacao.strCpfCnpj   := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
        objLiberacao.objMsgLibera.pAddTexto('Permissão para realizar consulta no Serasa Power Curve');

        If Not objLiberacao.fLibera  Then
        Begin
          fMensagem('ATENÇÃO!', 'Operador sem permissão para realizar consulta no Serasa Power Curve!', ['&Ok']);
          Exit;
        End;
      End;


      LConsultaSerasaPowerCurve := TConsultaSerasaPowerCurve.Create;
      LDocumento := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);

      LAtualizar := LConsultaSerasaPowerCurve.RealizarConsulta(LDocumento,dbeDtaNas.Text,LDecisao);

      If LAtualizar Then
      Begin
        LConsultaSerasaPowerCurve.SavePDF(fPastaConsultaCreditos(dbeCodCli.Field.DisplayText));

        dbeDtaCon.Field.AsDateTime := VS_Date;
        dbeQrdPro.Field.AsInteger  := LConsultaSerasaPowerCurve.QuantidadeProtesto;
        dbeCheDev.Field.AsInteger  := LConsultaSerasaPowerCurve.QuantidadeChequeDevolvido;
      End;


    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmCadClientes.ConsultaSerasaPowerCurve]');
      End;
    End;

  Finally
    If Assigned(LConsultaSerasaPowerCurve) Then
      FreeAndNil(LConsultaSerasaPowerCurve);
  End;

end;

procedure TfrmCadClientes.ConsultaSCPCBoaVistaSophus;
  Var
    LConsultaSCPCBoaVistaSophus: TConsultaSCPCBoaVistaSophus;
    LAtualizar: Boolean;
    LDocumento,
    LSolicitante: String;
begin

  Try
    Try

      If Not fVerificaAcessoSistema('CONSULTASCPCSOPHUS') Then
      Begin
        objLiberacao.Clear;
        objLiberacao.strDirAce    := 'CONSULTASCPCSOPHUS';
        objLiberacao.strMsgSen    := 'Consulta SCPC Boa Vista - Sophus';
        objLiberacao.strCodOpe    := strLoginUsuarioLogado;
        objLiberacao.strCodDig    := strLoginUsuarioLogado;
        objLiberacao.strCliente   := (dbeCodCli.Text + '-' + dbeNomCli.Text);
        objLiberacao.strCpfCnpj   := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
        objLiberacao.objMsgLibera.pAddTexto('Permissão para realizar consulta ao SCPC Boa Vista - Sophus');

        If Not objLiberacao.fLibera  Then
        Begin
          fMensagem('ATENÇÃO!', 'Operador sem permissão para realizar consulta ao SCPC Boa Vista - Sophus!', ['&Ok']);
          Exit;
        End;
      End;


      LConsultaSCPCBoaVistaSophus := TConsultaSCPCBoaVistaSophus.Create;
      LDocumento := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
      LSolicitante := strLoginUsuarioLogado + '-' + fTiraCaracEspeciaisPonto(fRetNomeOperador(strLoginUsuarioLogado));

      LAtualizar := LConsultaSCPCBoaVistaSophus.RealizarConsulta(LDocumento, LSolicitante);

      If LAtualizar Then
      Begin
        LConsultaSCPCBoaVistaSophus.SaveHTML(fPastaConsultaCreditos(dbeCodCli.Field.DisplayText));

        dbeDtaCon.Field.AsDateTime := VS_Date;
       // dbeQrdPro.Field.AsInteger  := LConsultaSCPCBoaVistaSophus.QuantidadeProtesto;
       // dbeCheDev.Field.AsInteger  := LConsultaSCPCBoaVistaSophus.QuantidadeChequeDevolvido;

        LConsultaSCPCBoaVistaSophus.ExibirRelatorio;
      End;


    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmCadClientes.ConsultaSerasaPowerCurve]');
      End;
    End;

  Finally
    If Assigned(LConsultaSCPCBoaVistaSophus) Then
      FreeAndNil(LConsultaSCPCBoaVistaSophus);
  End;

end;

procedure TfrmCadClientes.cxgCliCndViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
    Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadClientes.cxgCliForTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_DELETE Then
  Begin
    If cdsCliFor.Active And (cdsCliFor.RecordCount > 0) And (qryTabela.State in dsEditModes) And
       (fMensagem('', 'Deseja Remover o Forncedor Selecionado?', ['&Sim', '&Não'], 2) = 1) Then
      cdsCliFor.Delete;
  End;
end;

procedure TfrmCadClientes.cxgColSugestPropertiesChange(Sender: TObject);
begin
  inherited;

  cdsCliCnd.Post;
end;

procedure TfrmCadClientes.cxgDiaSemEntViewKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
   If (Key = #13) Then
  Begin
    If (cxgDiaSemEntViewColumn1.Focused) Then
      cxgDiaSemEntViewColumn2.Focused:= True
    Else
    If (cxgDiaSemEntViewColumn2.Focused) Then
      cxgDiaSemEntViewColumn3.Focused:= True
    Else
    If (cxgDiaSemEntViewColumn3.Focused) Then
      cxgDiaSemEntViewColumn4.Focused:= True
    Else
    If (cxgDiaSemEntViewColumn4.Focused) Then
      cxgDiaSemEntViewColumn5.Focused:= True
    Else
    If (cxgDiaSemEntViewColumn5.Focused) Then
      cxgDiaSemEntViewColumn6.Focused:= True
    Else
    If (cxgDiaSemEntViewColumn6.Focused) Then
      cxgDiaSemEntViewColumn7.Focused:= True
    Else
    If (cxgDiaSemEntViewColumn7.Focused) Then
      cxgDiaSemEntViewColumn8.Focused:= True
    Else
    If (cxgDiaSemEntViewColumn8.Focused) Then
    Begin
      If (cdsDtaPerEnt.FieldByName('SEMANA').AsString <> 'sábado') Then
      Begin
        cdsDtaPerEnt.Next;
        cxgDiaSemEntViewColumn3.Focused:= True;
      End
      Else
      Begin
        If btnGravar.Enabled Then
          pSetFocus(btnGravar)
        Else
        If btnAlterar.Enabled Then
          pSetFocus(btnAlterar);
      End;
    End;
  End;
end;

procedure TfrmCadClientes.cxGridDBColumn4PropertiesChange(Sender: TObject);
begin
  inherited;
  cdsCliDiv.Post;
end;

procedure TfrmCadClientes.dbeStatusEnter(Sender: TObject);
  Var
    strSenha: String;
begin
  inherited;

  If Not fEmptyStr(fCfgSis('SENSIT')) And (qryTabela.State = dsEdit) Then
    If ffrmSenha(strSenha) Then
    Begin
      If strSenha <> fCfgSis('SENSIT') Then
      Begin
        fMensagem('', 'Senha incorreta !', ['&O K']);
        SelectNext(ActiveControl, True, True);
        Exit;
      End;
    End
    Else
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadClientes.btnAdicionarProdClick(Sender: TObject);
begin
  inherited;
  Try
    If Not fEmptyStr(edtCodIte.Text) Then
      objCliPro.strCodPro := edtCodIte.Text
    Else
    Begin
      fMensagem('ATENÇÃO', 'Favor escolher um produto antes de confirmar!', ['&Ok']);
      Exit;
    End;
  Except
    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'');
      If edtCodIte.Enabled Then
        pSetFocus(edtCodIte);
      Exit;
    End;
  End;

  If (fValidaPanel(pnlProdutos, True)) Then
  Begin
    pAdicionaProdutosCds(objCliPro);
    btnCancelaProd.Click;
    blnAltProduto := False;
  End;
end;

procedure TfrmCadClientes.btnCancelarQuadSocClick(Sender: TObject);
begin
  inherited;
  pLimpaEditsQuadroSocietario;
  blnAltSocio := False;
  pSetFocus(edtNomSco);
end;

procedure TfrmCadClientes.pMostrarContaCorrente(strParam: String);
  Var
    objDocumento: IDocumento;
begin
  inherited;

  If fEmptyStr(strParam) Then
    Exit;

  objDocumento := TDocumento.Create;
  TfrmMostraDebCtrChq2.pMostraContaCorrente(strParam,
                       '',
                       False,
                       False,
                       False,
                       '',
                       objDocumento,
                       True);
  pAtribuiTabelas;
end;

function TfrmCadClientes.fVerificaSocioJaCadastrado(strCPFCNPJ: String; strCodCli: String) : Boolean;
  Var
    qryGen : TUniQuery;
    frmMensagemExplicativa : TfrmMensagemExplicativa;
begin
  Result := False;

  If fEmptyStr(strCPFCNPJ) Then
    Exit;

  qryGen := fCriaQuery;
  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT ');
    qryGen.SQL.Add('  CLI_CODCLI, CLI_NOMCLI, CLI_C_G_C_, CLI_ENDERE, ');
    qryGen.SQL.Add('  CLI_ENDNUM, CLI_BAIRRO, CID_NOMCID, CID_ESTADO ');
    qryGen.SQL.Add(' FROM CLISCO ');
    qryGen.SQL.Add(' INNER JOIN CADCLI ON CLI_CODCLI = SCO_CODCLI ');
    qryGen.SQL.Add(' INNER JOIN CADCID ON CID_CODCID = CLI_CODCID ');
    qryGen.SQL.Add(' WHERE SCO_CPFCNP = :CPFCNP ');
    qryGen.SQL.Add('   AND SCO_CODCLI <> :CODCLI ');
    qryGen.ParamByName('CPFCNP').AsString := strCPFCNPJ;
    qryGen.ParamByName('CODCLI').AsString := strCodCli;
    qryGen.Open;

    If qryGen.IsEmpty Then
      Exit(False);

    pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
    frmMensagemExplicativa.Caption := 'Aviso';

    qryGen.First;
    While Not qryGen.Eof Do
    Begin
      frmMensagemExplicativa.mmoInstru.Lines.Add('CNPJ/CPF JÁ CADASTRADO NO QUADRO SOCIETÁRIO DO CLIENTE: ' + qryGen.FieldByName('CLI_NOMCLI').AsString);
      frmMensagemExplicativa.mmoInstru.Lines.Add('');
      frmMensagemExplicativa.mmoInstru.Lines.Add('Razão Social: ' + qryGen.FieldByName('CLI_NOMCLI').AsString);
      frmMensagemExplicativa.mmoInstru.Lines.Add('CPF/CNPJ do cliente: ' + fFormataCpfCgc(qryGen.FieldByName('CLI_C_G_C_').AsString, fSetaPais));
      frmMensagemExplicativa.mmoInstru.Lines.Add('Endereço: ' + qryGen.FieldByName('CLI_ENDERE').AsString +', '+ qryGen.FieldByName('CLI_ENDNUM').AsString + ' - ' + qryGen.FieldByName('CLI_BAIRRO').AsString);
      frmMensagemExplicativa.mmoInstru.Lines.Add(qryGen.FieldByName('CID_NOMCID').AsString + ' - ' + qryGen.FieldByName('CID_ESTADO').AsString);

      If (qryGen.RecordCount > 1) Then
        frmMensagemExplicativa.mmoInstru.Lines.Add(StringOfChar('-', 40));

      qryGen.Next;
    End;

    frmMensagemExplicativa.strParam      := qryGen.FieldByName('CLI_CODCLI').AsString;
    frmMensagemExplicativa.prcAcaoBtnAux := pMostrarContaCorrente;
    frmMensagemExplicativa.pMostrarBotaoAuxiliar('C/C Cliente');
    frmMensagemExplicativa.ShowModal;
  Finally
    FreeAndNil(qryGen);

    If Assigned(frmMensagemExplicativa) Then
      pFreeAndNil(frmMensagemExplicativa);
  End;
end;

procedure TfrmCadClientes.btnConfirmaQuadSocClick(Sender: TObject);
begin

  inherited;

  Try

    If Assigned(cdsCadSco) And (cdsCadSco.Active) Then
    Begin

      If fEmptyStr(edtNomSco.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Nome do Sócio deve ser preenchido!', ['&Ok']);
        Exit;
      End;

      fVerificaSocioJaCadastrado(edtCnpjCpfSco.Text, dbeCodCli.Text);

      If (blnAltSocio) Then
        cdsCadSco.Edit
      Else
        cdsCadSco.Append;

      cdsCadScoSCO_NOMSCO.AsString := edtNomSco.Text;

      If (edtOpcCnpjCpfSco.Text <> '') Then
        cdsCadScoSCO_PF_PJ_.AsString := edtOpcCnpjCpfSco.Text
      Else
        cdsCadScoSCO_PF_PJ_.Clear;

      If (edtCnpjCpfSco.Text <> '') Then
        cdsCadScoSCO_CPFCNP.AsString := edtCnpjCpfSco.Text
      Else
        cdsCadScoSCO_CPFCNP.Clear;

      If (edtRGSco.Text <> '') Then
        cdsCadScoSCO_NUM_RG.AsString := edtRGSco.Text
      Else
        cdsCadScoSCO_NUM_RG.Clear;

      If (mskDataNascimento.Text <> '  /  /    ') Then
        cdsCadScoSCO_DTANAS.AsDateTime := StrToDateTime(mskDataNascimento.Text)
      Else
        cdsCadScoSCO_DTANAS.AsString := '';

      If (edtParticipacaoSco.Text <> '') Then
        cdsCadScoSCO_PER_PS.AsString := edtParticipacaoSco.Text
      Else
        cdsCadScoSCO_PER_PS.Clear;

      If Not fEmptyStr(edtEstadoCivil.Text) Then
        cdsCadScoSCO_ESTCIV.AsString := edtEstadoCivil.Text;

      cdsCadSco.Post;

      pLimpaEditsQuadroSocietario;
      blnAltSocio := False;
      pSetFocus(edtNomSco);

    End;

  Except
    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmCadClientes.btnConfirmaQuadSocClick]');
      pSetFocus(edtNomSco);
    End;
  End;

end;

procedure TfrmCadClientes.btnConSCPCClick(Sender: TObject);
var
    objConsultaSCPC: TConsultaSCPC;

  function fRealizarConsulta: Boolean;
    Var
      LDocumento : String;
  begin

    If fCfgSis('CPFSDV', VarBoolean) And chkCpfDev.Visible And chkCpfDev.Checked Then
    Begin

      LDocumento := qryTabela.FieldByName('CLI_CPFDEV').AsString;

      If pnlTipoCreditoBV.Visible Then
        LDocumento := LDocumento + cmbTipoPesquisa.ItemIndex.ToString();

      Result := objConsultaSCPC.fRealizarConsulta(LDocumento,
                                                  qryTabela.FieldByName('CLI_NOMCLI').AsString,
                                                  edtNomCid.Text, edtEstado.Text, blnSCPCAutomatico);



    End
    Else
    Begin

      LDocumento := qryTabela.FieldByName('CLI_C_G_C_').AsString;

      If pnlTipoCreditoBV.Visible Then
        LDocumento := LDocumento + cmpTipoCreditoBV.ItemIndex.ToString();

      If pnlTipoConsultaPOA.visible Then
      Begin
        Result := objConsultaSCPC.fRealizarConsulta(LDocumento,
                                                    qryTabela.FieldByName('CLI_NOMCLI').AsString,
                                                    edtNomCid.Text, edtEstado.Text, blnSCPCAutomatico,
                                                    cmpConsultaPOA.Text, IIF(cmpTipoConsultaPOA.visible, copy(cmpTipoConsultaPOA.Text,1,3), '') );
      End
      Else
      Begin
        Result := objConsultaSCPC.fRealizarConsulta(LDocumento,
                                                    qryTabela.FieldByName('CLI_NOMCLI').AsString,
                                                    edtNomCid.Text, edtEstado.Text, blnSCPCAutomatico);
      End;

    End;
  end;

begin
  inherited;

  If (fCfgSis('CNSCPC') = 'S') Then
  Begin
    ConsultaSCPCBoaVistaSophus;
    Exit;
  End;


  If (fCfgSis('CNSCPC') = 'E') And (Not fEmptyStr(fCfgSis('LOGBVE'))) And (Not fEmptyStr(fCfgSis('SENBVE'))) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.strDirAce    := 'LOGINBVES';
    objLiberacao.strMsgSen    := 'Login Boa Vista';
    objLiberacao.strCodOpe    := strLoginUsuarioLogado;
    objLiberacao.strCodDig    := strLoginUsuarioLogado;
    objLiberacao.strCliente   := (dbeCodCli.Text + '-' + dbeNomCli.Text);
    objLiberacao.strCpfCnpj   := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
    objLiberacao.objMsgLibera.pAddTexto('Consulta Automática ao SCPC Boa Vista.');

    blnSCPCAutomatico := objLiberacao.fLibera;

    If Not blnSCPCAutomatico Then
      Exit;
  End;

  If (btnConSCPC.Enabled) And (qryTabela.State In [dsEdit, dsInsert]) Then
  Begin
    Try
      Screen.Cursor := crHourGlass;
      pnlInfo.Caption := 'Aguarde, realizando consulta...';
      Application.ProcessMessages;

      objConsultaSCPC := TConsultaSCPC.fGetInstance(Self);

      If fRealizarConsulta Then
      Begin
        cmbTipoPesquisa.ItemIndex := 6;
        If (Not fEmptyStr(dbeObsCon.Field.AsString)) And ( (fCfgSis('CNSCPC') = 'A') Or  (fCfgSis('CNSCPC') = 'B') ) Then
          dbeObsCon.Field.AsString := objConsultaSCPC.strRelatorio + #13#10 +
                                      '-------------------------------------------------------------' + #13#10 +
                                      '      CONSULTA ANTERIOR - DATA: ' + dbeDtaCon.Text + #13#10 +
                                      '-------------------------------------------------------------' + #13#10 +
                                      dbeObsCon.Field.AsString
        Else
          dbeObsCon.Field.AsString := objConsultaSCPC.strRelatorio;

        dbeDtaCon.Field.AsDateTime := VS_Date;

        dbeQrdPro.Field.AsInteger  := objConsultaSCPC.intQtdProtestos;
        dbeCheDev.Field.AsInteger  := objConsultaSCPC.intQtdCheques;

        objConsultaSCPC.pSaveToFile(fPastaConsultaCreditos(dbeCodCli.Field.DisplayText) +
                                    '\scpc' + FormatDateTime('YYYYDDMM', VS_Date) +

                                    FormatDateTime('hhmmss', fTime()) + '.txt');
        pMensagemOk('Consulta realizada com sucesso!');
      End
      Else
        If Not fEmptyStr(objConsultaSCPC.strMsqErro) Then
          pMensagemOk(objConsultaSCPC.strMsqErro);

    Except
      On E: ExceptionAutCom Do
        pMensagemOk(E.Message);

      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;

    FreeAndNil(objConsultaSCPC);

    pnlInfo.Caption := '';
    Screen.Cursor := crDefault;

  end
  else
  begin
    fMensagem('ATENÇÃO!','Não é permitido realizar a consulta!', ['&O K']);
    Exit;
  end;

end;

procedure TfrmCadClientes.btnConsultaFitClick(Sender: TObject);
var
  dicValoresAtuais, dicResultado: TDicionario;
begin
  inherited;

  If not dbeCgcCpf.Enabled Then
    Exit;

  If fEmptyStr(dbeCgcCpf.Text) Then
    Exit;

  If not fValidaCnpjCpf(dbeCgcCpf.Text, dbeNuCpnj.Text) Then
    Exit;

  if dbeCgcCpf.Text <> '1' then
    Exit;

  If fEmptyStr(dbeNuCpnj.Text) Then
  Begin
    fMensagem('Atenção', 'Informe o CNPJ antes de realizar a consulta', ['&Ok']);
    Exit;
  End;

  dicValoresAtuais := TDicionario.Create;
  dicResultado := TDicionario.Create;
  try
    dicValoresAtuais.Limpar;
    dicValoresAtuais.Adicionar(DESC_RAZAO_SOCIAL,  qryTabela.FieldByName('CLI_NOMCLI').AsString);
    dicValoresAtuais.Adicionar(DESC_NOME_FANTASIA, qryTabela.FieldByName('CLI_FANSOB').AsString);
    dicValoresAtuais.Adicionar(DESC_INSC_EST,      qryTabela.FieldByName('CLI_I_E_S_').AsString);
    dicValoresAtuais.Adicionar(DESC_ENDERECO,      qryTabela.FieldByName('CLI_ENDERE').AsString);
    dicValoresAtuais.Adicionar(DESC_NUMERO,        qryTabela.FieldByName('CLI_ENDNUM').AsString);
    dicValoresAtuais.Adicionar(DESC_COMPLEMENTO,   qryTabela.FieldByName('CLI_ENDCOM').AsString);
    dicValoresAtuais.Adicionar(DESC_BAIRRO,        qryTabela.FieldByName('CLI_BAIRRO').AsString);
    dicValoresAtuais.Adicionar(DESC_CEP,           qryTabela.FieldByName('CLI_C_E_P_').AsString);
    dicValoresAtuais.Adicionar(DESC_IBGE_CIDADE,   fRetornaCodIBGE(qryTabela.FieldByName('CLI_CODCID').AsString));
    dicValoresAtuais.Adicionar(DESC_CNPJ,          qryTabela.FieldByName('CLI_C_G_C_').AsString);
    dicValoresAtuais.Adicionar(DESC_CNAE,          qryTabela.FieldByName('CLI_CODCNA').AsString);
    dicValoresAtuais.Adicionar(DESC_DATA_ABERTURA, qryTabela.FieldByName('CLI_NASCIM').AsString);

    objConsultaCadastroFit.pConsulta(dicValoresAtuais,
                                     dicResultado,
                                     fTiraCaracEspeciaisPonto(dbeNuCpnj.Text),
                                     True,
                                     blnTemDivergenciaSefaz,
                                     True);

    SelectNext(ActiveControl, True, True);

    if dicResultado.Chaves.IndexOf(DESC_RAZAO_SOCIAL) > -1 then
      qryTabela.FieldByName('CLI_NOMCLI').AsString := dicResultado.Retorna(DESC_RAZAO_SOCIAL);
    if dicResultado.Chaves.IndexOf(DESC_NOME_FANTASIA) > -1 then
      qryTabela.FieldByName('CLI_FANSOB').AsString := dicResultado.Retorna(DESC_NOME_FANTASIA);
    if dicResultado.Chaves.IndexOf(DESC_ENDERECO) > -1 then
      qryTabela.FieldByName('CLI_ENDERE').AsString := dicResultado.Retorna(DESC_ENDERECO);
    if dicResultado.Chaves.IndexOf(DESC_NUMERO) > -1 then
      qryTabela.FieldByName('CLI_ENDNUM').AsString := dicResultado.Retorna(DESC_NUMERO);
    if dicResultado.Chaves.IndexOf(DESC_COMPLEMENTO) > -1 then
      qryTabela.FieldByName('CLI_ENDCOM').AsString := dicResultado.Retorna(DESC_COMPLEMENTO);
    if dicResultado.Chaves.IndexOf(DESC_BAIRRO) > -1 then
      qryTabela.FieldByName('CLI_BAIRRO').AsString := dicResultado.Retorna(DESC_BAIRRO);
    if dicResultado.Chaves.IndexOf(DESC_CEP) > -1 then
    begin
      qryTabela.FieldByName('CLI_C_E_P_').AsString := fTiraCaracEspeciaisPonto(dicResultado.Retorna(DESC_CEP));
      fValidaCampos(dbeNumCep);
    end;
    if dicResultado.Chaves.IndexOf(DESC_IBGE_CIDADE) > -1 then
    begin
      qryTabela.FieldByName('CLI_CODCID').AsString := fRetornaCodCidIBGE(dicResultado.Retorna(DESC_IBGE_CIDADE), True);
      fValidaCampos(dbeCodCid);
    end;
    if dicResultado.Chaves.IndexOf(DESC_INSC_EST) > -1 then
    begin
      qryTabela.FieldByName('CLI_I_E_S_').AsString := dicResultado.Retorna(DESC_INSC_EST);
      fValidaCampos(dbeNumIes);
    end;
    if dicResultado.Chaves.IndexOf(DESC_CNPJ) > -1 then
      qryTabela.FieldByName('CLI_C_G_C_').AsString := fTiraCaracEspeciaisPonto(dicResultado.Retorna(DESC_CNPJ));
    if dicResultado.Chaves.IndexOf(DESC_CNAE) > -1 then
    begin
      qryTabela.FieldByName('CLI_CODCNA').AsString := dicResultado.Retorna(DESC_CNAE);
      fValidaCampos(dbeCNAE);
    end;

    if dicResultado.Chaves.IndexOf(DESC_DATA_ABERTURA) > -1 then
    begin
      qryTabela.FieldByName('CLI_NASCIM').AsString := dicResultado.Retorna(DESC_DATA_ABERTURA);
      fValidaCampos(dbeDtaNas);
    end;

    if not blnTemDivergenciaSefaz then
      pSalvaDataConsultaSefaz('CADCLI', 'CLI_DTASEF', qryTabela.FieldByName('AUTOINCREM').AsString, fRetDataServidor);
  finally
    FreeAndNil(dicValoresAtuais);
    FreeAndNil(dicResultado);
  end;
end;

procedure TfrmCadClientes.btnConsultarEnderecoClick(Sender: TObject);
begin
  inherited;
  pConsultarEnderecoGoogleMaps;
end;

procedure TfrmCadClientes.btnConsultaSerasaPowerCurveClick(Sender: TObject);
begin
  inherited;
  ConsultaSerasaPowerCurve;
end;

procedure TfrmCadClientes.btnContratosClick(Sender: TObject);
var
  frmCadContratos: TfrmCadContratos;
begin
  inherited;
  If (Not btnContratos.Enabled) Then
    Exit;

  If (qryTabela.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário escolher um cliente!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmCadContratos, frmCadContratos);
    frmCadContratos.strCodCli := qryTabela.FieldByName('CLI_CODCLI').AsString;
    frmCadContratos.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmCadClientes.btnContratosClick]');
    End;
  End;
  pFreeAndNil(frmCadContratos);

  pAtribuiTabelas;
end;

procedure TfrmCadClientes.dbeCodRedKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrRede: TConsultasArray;
begin
  inherited;
  {**********************************}
  {* NOVA CONSULTA DE REDE DE LOJAS *}
  {*******************************RV*}
  If fPesqRedeLojas(Self, dbeCodRed, edtDesRed, Nil, Key, arrRede) Then
  Begin
    If fValidaCampos(dbeCodRed, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadClientes.dbeCodRedChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadRed(Key);
  pAtribuiTabelas;
end;

procedure TfrmCadClientes.dbeCodRedExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(dbeCodRed.Text) Then
  Begin
    If objRedeLojas = nil Then
      objRedeLojas := TRedeLojas.Create(Self);

    if objRedeLojas.fCarregaCadRed(dbeCodRed.Text) Then
      edtDesRed.Text := objRedeLojas.strDesRed
    Else
    Begin
      dbeCodRed.Field.Value := Null;
      edtDesRed.Clear;
      fMensagem('', 'Rede de Loja não encontrada !', ['&Ok']);
    End;
  End
  Else
  Begin
    dbeCodRed.Field.Value := Null;
    edtDesRed.Clear;
  End;
end;

procedure TfrmCadClientes.pQueryCadCliAfterScroll(DataSet: TDataSet);
  Var
    strRgExp: String;
Begin
  If Not fEmptyStr(dbeCodRed.Text) Then
  Begin
    If objRedeLojas.fCarregaCadRed(dbeCodRed.Text) Then
      edtDesRed.Text := objRedeLojas.strDesRed
    Else
      edtDesRed.Clear;
  End;

  dbeCgcCpfExit(Nil);
  cmbTipoPesquisaChange(Nil);

  pAtualizaEnderecoEntrega;
  pAtualizaFazendas;

  pStatusTelefone(spbFone1);
  pStatusTelefone(spbFone2);
  pStatusTelefone(spbFax);
  pStatusTelefone(spbCel);
  pStatusTelefone(spbNex);

  strRgExp := qryTabela.FieldByName('CLI_RG_EXP').AsString;

  edtRgExp.Text := MidStr(strRgExp, 1, Pos('-', strRgExp) -1);
  cbxRgEst.ItemIndex := cbxRgEst.Items.IndexOf(MidStr(strRgExp, Pos('-', strRgExp) + 1, 2));
  cmbTipoPesquisa.ItemIndex := StrToIntDef(qryTabela.FieldByName('CLI_CODCON').AsString, 0);
  cmpTipoCreditoBV.ItemIndex := StrToIntDef(qryTabela.FieldByName('CLI_TIPCBV').AsString, 0);
  cbProdutoSerasa.ItemIndex := StrToIntDef(qryTabela.FieldByName('CLI_PROSER').AsString, 0);

  cbbDestino.ItemIndex := qryTabela.FieldByName('CLI_ENTRET').AsInteger;

  pEstadoEmissaoCPF;

  pAtualizaTipAbf;
End;

procedure TfrmCadClientes.pQueryCadFicAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    TStringField(FieldByName('FIC_TELBC1')).EditMask := fRetMascaraFonePais;
    TStringField(FieldByName('FIC_TELBC2')).EditMask := fRetMascaraFonePais;
    TStringField(FieldByName('FIC_TELBC3')).EditMask := fRetMascaraFonePais;
    TStringField(FieldByName('FIC_TELEM1')).EditMask := fRetMascaraFonePais;
    TStringField(FieldByName('FIC_TELEM2')).EditMask := fRetMascaraFonePais;
    TStringField(FieldByName('FIC_TELEM3')).EditMask := fRetMascaraFonePais;

    TFloatField(FieldByName('FIC_VALPS1')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('FIC_VALPS2')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('FIC_VALPS3')).DisplayFormat := '#,##0.00';

    TDateField(FieldByName('FIC_DTANS1')).EditMask := '99/99/9999';
    TDateField(FieldByName('FIC_DTANS2')).EditMask := '99/99/9999';
    TDateField(FieldByName('FIC_DTANS3')).EditMask := '99/99/9999';
  End;
end;

procedure TfrmCadClientes.pQueryInfCreAfterOpen(DataSet: TDataSet);
  Var
    intIndex: Integer;
begin
  With DataSet Do
  Begin
    For intIndex := 0 To Fields.Count-1 Do
      Case Fields[intIndex].DataType Of
        ftFloat, ftCurrency, ftBCD: TFloatField(Fields[intIndex]).DisplayFormat := '#,##0.00';
        ftDate: TDateField(Fields[intIndex]).EditMask := '99/99/9999';
      End;

    TStringField(FieldByName('CLI_TEMSER')).EditMask := '99/99/9999';
    TStringField(FieldByName('CLI_TELSER')).EditMask := fRetMascaraFonePais;

    FieldByName('CLI_NOMPAI').DisplayLabel := 'Nome Pai';
    FieldByName('CLI_NOMMAE').DisplayLabel := 'Nome Mãe';
    FieldByName('CLI_ESTCIV').DisplayLabel := 'Estado Civil';
    FieldByName('CLI_CONJUG').DisplayLabel := 'Conjuge';
    FieldByName('CLI_NASCON').DisplayLabel := 'Nasc. Conjuge';
    FieldByName('CLI_PROFIS').DisplayLabel := 'Profissão';
    FieldByName('CLI_TRABAL').DisplayLabel := 'Trabalho';
    FieldByName('CLI_TEMSER').DisplayLabel := 'Data de Admissão';
    FieldByName('CLI_ENDSER').DisplayLabel := 'End. Serviço';
    FieldByName('CLI_TELSER').DisplayLabel := 'Tel. Serviço';
    FieldByName('CLI_SALARI').DisplayLabel := 'Salário';
    FieldByName('CLI_OUTREN').DisplayLabel := 'Outra Renda';
  End;
end;

procedure TfrmCadClientes.pQueryCadFicAfterScroll(DataSet: TDataSet);
  Var
    intIndex: Integer;
begin
  For intIndex := 1 To 3 Do
  Begin
    {********************************************}
    {             QUADRO SOCIETÁRIO              }
    {*****************************************AN*}
    If DataSet.FieldByName('FIC_CGCPS' + IntToStr(intIndex)).AsString = '1' Then
      DataSet.FieldByName('FIC_CGCSC' + IntToStr(intIndex)).EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
    Else
    If DataSet.FieldByName('FIC_CGCPS' + IntToStr(intIndex)).AsString = '2' Then
      DataSet.FieldByName('FIC_CGCSC' + IntToStr(intIndex)).EditMask := '999.999.999-99;0;'
    Else
      DataSet.FieldByName('FIC_CGCSC' + IntToStr(intIndex)).EditMask := '';

    {********************************************}
    {            REFERENCIAS COMERCIAIS          }
    {*****************************************AN*}
    If DataSet.FieldByName('FIC_CGCPF' + IntToStr(intIndex)).AsString = '1' Then
      DataSet.FieldByName('FIC_CGCEM' + IntToStr(intIndex)).EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
    Else
    If DataSet.FieldByName('FIC_CGCPF' + IntToStr(intIndex)).AsString = '2' Then
      DataSet.FieldByName('FIC_CGCEM' + IntToStr(intIndex)).EditMask := '999.999.999-99;0;'
    Else
      DataSet.FieldByName('FIC_CGCEM' + IntToStr(intIndex)).EditMask := '';
  End;
end;

procedure TfrmCadClientes.pQueryCadFicBeforePost(DataSet: TDataSet);
begin
  If fEmptyStr(DataSet.FieldByName('FIC_CODCLI').AsString) Then
    DataSet.FieldByName('FIC_CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
end;

procedure TfrmCadClientes.pQueryInfCreAfterScroll(DataSet: TDataSet);
  Var
    intIndex: Integer;
begin

  cbxEstCiv.ItemIndex := -1;

  for intIndex := 0 To Length(ARR_ESTADOCIVIL) -1 Do
    If qryInfCre.FieldByName('CLI_ESTCIV').AsString = ARR_ESTADOCIVIL[intIndex][1] Then
      cbxEstCiv.ItemIndex := intIndex;

  cbxMoradia.ItemIndex := -1;

  for intIndex := 0 To Length(ARR_MORADIA) -1 Do
    If qryInfCre.FieldByName('CLI_CASAPR').AsString = ARR_MORADIA[intIndex][1] Then
      cbxMoradia.ItemIndex := intIndex;

  cbxSexo.ItemIndex := -1;

  for intIndex := 0 To Length(ARR_SEXO) -1 Do
    If qryInfCre.FieldByName('CLI_SEXO__').AsString = ARR_SEXO[intIndex][1] Then
      cbxSexo.ItemIndex := intIndex;

  cbxEscolaridade.ItemIndex := -1;

  for intIndex := 0 To Length(ARR_ESCOLARIDADE) -1 Do
    If qryInfCre.FieldByName('CLI_ESCOLA').AsString = ARR_ESCOLARIDADE[intIndex][1] Then
      cbxEscolaridade.ItemIndex := intIndex;

  edtDesAvalis.Text := fRetNomCliente(dbeAvalis.Text);
  edtDesNacion.Text := fRetNomePais(dbeNacion.Text);
  edtDesNatura.Text := fRetNomCidadeSemOpc(dbeNatura.Text);  

end;

procedure TfrmCadClientes.edtCodBaiKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqBairro(Self, edtCodBai, nil, nil, Key, arrSel) then
  Begin
    fValidaCampos(edtCodBai, False);
  End;

end;

procedure TfrmCadClientes.edtCodCndEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'INSERT para fazer um novo cadastro';
end;

procedure TfrmCadClientes.edtCodCndExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmCadClientes.edtCodCndKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE COND. PGTO *}
  {****************************RV*}
  If fPesqCondicoesPgto(Self, edtCodCnd, edtDesCnd, Nil, Key, arrCnd, False) Then
  Begin
    If fValidaCampos(edtCodCnd, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.edtCodCndKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If fIsInsert(Key) Then
  Begin
    If fChamaCadPag(Key) <> Null Then
      pAtribuiTabelas;
  End;
end;

procedure TfrmCadClientes.edtCodDepKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrCodDep, False) Then
  Begin
    If fValidaCampos(edtCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.edtCodDivKeyPress(Sender: TObject; var Key: Char);
Var
  arrDiversos : TConsultasArray;
begin
  inherited;
  If fPesqDiversos(Self, edtCodDiv, edtNomDiv, Nil, Key, arrDiversos, True, True) Then
  Begin
    If fValidaCampos(edtCodDiv, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.edtCodEmbKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCadEmb: TConsultasArray;
begin
  inherited;

  If fPesqCadastroEmbarcacoes(Self, edtCodEmb, edtDesEmb, Nil, Key, arrCadEmb) Then Begin
    If fValidaCampos(edtCodEmb, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.edtCodEmpExit(Sender: TObject);
  Var
    qryAux: TUniQuery;
    strSql: String;
begin
  If Not fEmptyStr(edtCodEmp.Text) Then
  Begin
    qryAux := fCriaQuery;
    Try
      strSql := 'SELECT EMP_CODEMP, EMP_NOMEMP FROM CADEMP WHERE EMP_CODEMP = :CODEMP';

      qryAux.SQL.Text := strSql;
      qryAux.ParamByName('CODEMP').AsString := edtCodEmp.Text;
      qryAux.Open;

      edtCodEmp.Text := qryAux.FieldByName('EMP_CODEMP').AsString;
      edtNomEmp.Text := qryAux.FieldByName('EMP_NOMEMP').AsString;
    Finally
      qryAux.Free;
    End;
  End
  Else
    edtNomEmp.Clear;
end;

procedure TfrmCadClientes.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmpresa : TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpresa) Then
    Begin
    fValidaCamposCCCLIE(edtCodEmp, False)
//        pSetFocus(edtConCon)
    End;
  End;
end;

procedure TfrmCadClientes.edtCodEmpPrioridadeKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpPrioridade, edtDesEmpPrioridade, Nil, Key, arrEmp) Then
  Begin
    SelectNext(ActiveControl, True, True);
  End
  Else if Key = #13 then
  begin
    if (Length(edtCodEmpPrioridade.Text) < 3) and (not fEmptyStr(edtCodEmpPrioridade.Text)) then
    begin
      edtCodEmpPrioridade.Text := fStrZero(edtCodEmpPrioridade.Text, 3);
    end;

    edtDesEmpPrioridade.Text := fRetNomeEmpresa(edtCodEmpPrioridade.Text);

    if fEmptyStr(edtDesEmpPrioridade.Text) then
    begin
      fMensagem('','Empresa não encontrada!', ['&Ok']);
      edtDesEmpPrioridade.Clear;
    end
    else
    begin
      pSetFocus(btnAdicionar);
    end;

  end;
end;

function TfrmCadClientes.edtCodEmpresaChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadEmp(Key);
  pAtribuiTabelas;
end;

procedure TfrmCadClientes.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodEmpresa.Text) Then
    edtDesEmpresa.Clear
  Else
  Begin
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

    If fEmptyStr(edtDesEmpresa.Text) Then
    Begin
      fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
      edtCodEmpresa.Clear;
      pSetFocus(edtCodEmpresa);
    End;
  End;
end;

procedure TfrmCadClientes.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, TDBEditFocus(Sender), Nil, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.edtCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, qryConPro, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
    Begin
      If (fValidaCampos(edtCodIte, True)) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadClientes.edtCodOpeEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'INSERT para fazer um novo cadastro';
end;

procedure TfrmCadClientes.edtCodOpeExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmCadClientes.edtCodOpeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmCadClientes.edtCodOpeKeyPress(Sender: TObject; var Key: Char);
  Var
    arrOperador: TConsultasArray;
begin
  inherited;
  {*****************************}
  {* NOVA CONSULTA DE OPERADOR *}
  {**************************AC*}
  If fPesqOperador(Self, edtCodOpe, edtDesCodOpe, Nil, Key, arrOperador) Then
  Begin
    If fValidaCampos(edtCodOpe, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.edtCodOpeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If fIsInsert(Key) Then
  Begin
    If fChamaCadOpe(Key) <> Null Then
      pAtribuiTabelas;
  End;
end;

procedure TfrmCadClientes.edtCodQuaExit(Sender: TObject);
begin
  inherited;

  If Not fValidaCampos(edtCodEmb, True) Then
    Exit;
end;

procedure TfrmCadClientes.edtCodQuaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  if fPesqQualificacao(Self, edtCodQua, edtDesQua, Nil, Key, arrQualificacao, blnAltQuaCli) then
  begin
    SelectNext(ActiveControl, True, True);
  end;

end;

procedure TfrmCadClientes.edtCod_NFEnter(Sender: TObject);
begin
  inherited;
  pgcDados.ShowHint := False;
  HintControler.ShowHint(Self.Left + edtCod_NF.Left + edtCod_NF.Width,
                         50 + Self.Top + pnlProdutos.Top + edtCod_NF.Top + edtCod_NF.Height,
                         '',
                         'Código Impressão NF');
end;

procedure TfrmCadClientes.edtCod_NFExit(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
  pgcDados.ShowHint := True;
end;

procedure TfrmCadClientes.edtCrmForKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFor: TConsultasArray;
begin
  inherited;
  if fPesqFornecedorAtualCRM(Self, edtCrmFor, edtDesFor, nil, Key, arrFor) then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.edtDes_NFEnter(Sender: TObject);
begin
  inherited;
  pgcDados.ShowHint := False;
  HintControler.ShowHint(Self.Left + edtDes_NF.Left + edtDes_NF.Width,
                         50 + Self.Top + pnlProdutos.Top + edtDes_NF.Top + edtDes_NF.Height,
                         '',
                         'Descrição Impressão NF');
end;

procedure TfrmCadClientes.edtDes_NFExit(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
  pgcDados.ShowHint := True;
end;

procedure TfrmCadClientes.edtDptCttKeyPress(Sender: TObject; var Key: Char);
  Var
    arrDepartamentos: TConsultasArray;
begin
  inherited;
  {**********************************}
  {* NOVA CONSULTA DE DEPARTAMENTOS *}
  {*******************************AC*}
  If fPesqDepartamentosCliCon(Self, edtDptCtt, edtDesDptCtt, Nil, Key, arrDepartamentos) Then
  Begin
    If fValidaCampos(edtDptCtt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.edtEciCttKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEstadoCivil: TConsultasArray;
begin
  inherited;
  {*************************************}
  {* NOVA CONSULTA DE ESTADO CIVIL     *}
  {**********************************AC*}
  If fPesqEstadosCivisCliCon(Self, edtEciCtt, edtDesEciCtt, Nil, Key, arrEstadoCivil) Then
  Begin
    If fValidaCampos(edtEciCtt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.edtEscCttKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEscolaridade: TConsultasArray;
begin
  inherited;
  {*************************************}
  {* NOVA CONSULTA DE ESCOLARIDADES    *}
  {**********************************AC*}
  If fPesqEscolaridadesCliCon(Self, edtEscCtt, edtDesEscCtt, Nil, Key, arrEscolaridade) Then
  Begin
    If fValidaCampos(edtEscCtt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.edtGmuCttKeyPress(Sender: TObject; var Key: Char);
  Var
    arrGostoMusical: TConsultasArray;
begin
  inherited;
  {*************************************}
  {* NOVA CONSULTA DE GOSTO MUSICAL    *}
  {**********************************AC*}
  If fPesqGostosMusicaisCliCon(Self, edtGmuCtt, edtDesGmuCtt, Nil, Key, arrGostoMusical) Then
  Begin
    If fValidaCampos(edtGmuCtt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.edtHobCttKeyPress(Sender: TObject; var Key: Char);
  Var
    arrHobby: TConsultasArray;
begin
  inherited;
  {*************************************}
  {* NOVA CONSULTA DE HOBBY            *}
  {**********************************AC*}
  If fPesqHobbysCliCon(Self, edtHobCtt, edtDesHobCtt, Nil, Key, arrHobby) Then
  Begin
    If fValidaCampos(edtHobCtt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.edtOpcCnpjCpfScoExit(Sender: TObject);
begin

  inherited;

  If edtOpcCnpjCpfSco.Text = '1' Then
    edtCnpjCpfSco.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
  Else
  If edtOpcCnpjCpfSco.Text = '2' Then
    edtCnpjCpfSco.EditMask := '999.999.999-99;0;'
  Else
    edtCnpjCpfSco.EditMask := '';

end;

procedure TfrmCadClientes.edtRgExpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If Not CharInSet(Key, ['a'..'z', 'A'..'Z', '0'..'9', #8]) Then
    Key := #0;
end;

procedure TfrmCadClientes.edtTfuCttKeyPress(Sender: TObject; var Key: Char);
  Var
    arrTimeFut: TConsultasArray;
begin
  inherited;
  {*************************************}
  {* NOVA CONSULTA DE TIMES DE FUTEBOL *}
  {**********************************AC*}
  If fPesqTimesFutebolCliCon(Self, edtTfuCtt, edtDesTfuCtt, Nil, Key, arrTimeFut) Then
  Begin
    If fValidaCampos(edtTfuCtt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.edtVPrComExit(Sender: TObject);
begin
  inherited;

    
  
end;

//procedure TfrmCadClientes.pNextPageCli;
//Begin
//  pProximaPagina;
//
//  If (blnCobEnt) Then
//  Begin
//    If dbeCidCob.CanFocus Then
//      pSetFocus(dbeCidCob);
//  End
//  Else If (blnRefCom) Then
//  Begin
//    If dbeNomSc1.CanFocus Then
//      pSetFocus(dbeNomSc1)
//  End
//  Else If (blnCrediario) Then
//    pSetFocus(dbeNomPai);
//End;

procedure TfrmCadClientes.pnlBotoesEnter(Sender: TObject);
begin
  inherited;
//  ShowMessage('entrei');
end;

procedure TfrmCadClientes.pOnStateChange;
begin
  If (Not qryTabela.Active) Then
    Exit;

  inherited;
  With qryTabela Do
  Begin
    btnFichaCli.Enabled := blnAceF8 And (State = dsBrowse) And (RecordCount > 0);
    dbeFtNfEs.ReadOnly  := not ((blnAltFtNfEs And (State = dsEdit) And (RecordCount > 0)) or (State = dsInsert));
    dbeTFtNEs.ReadOnly  := not ((blnAltFtNfEs And (State = dsEdit) And (RecordCount > 0)) or (State = dsInsert));
    dbeTipFat.ReadOnly  := not ((blnAltFtNfEs And (State = dsEdit) And (RecordCount > 0)) or (State = dsInsert));
  End;

  edtCodBai.Enabled      := (qryTabela.State in DsEditModes);
  dbgCliBat.Enabled      := (qryTabela.State in DsEditModes);
  pnlCompGrp1.Enabled    := (qryTabela.State in DsEditModes);
  cbxRgEst.Enabled       := (qryTabela.State in DsEditModes);
//  spbFax.Enabled         := (qryTabela.State in DsEditModes);

  If fVerificaAcessoSistema('CLASPS', strLoginUsuarioLogado) Then
    dbeStReEs.Enabled    := (qryTabela.State in DsEditModes);

  pnlEntregas.Enabled       := (qryTabela.State in DsEditModes);
  pHabilitaConsultaSCPC;
  btnConsultaSerasaPowerCurve.Enabled := UtilizaConsultaSerasaPowerCurve;
  btnConsultaSerasaExperian.Enabled   := UtilizaConsultaSerasaExperian;
  cbProdutoSerasa.Enabled := (cmbTipoPesquisa.ItemIndex = 1);

//  tbsGeral2.Enabled         := (qryTabela.State in DsEditModes);
  tbsContato.Enabled        := (qryTabela.State in DsEditModes);
  tbsEntregas.Enabled       := (qryTabela.State in DsEditModes);
  tbsCbrEnt.Enabled         := (qryTabela.State in DsEditModes);
  tbsObservacoes.Enabled    := (qryTabela.State in DsEditModes);
  tbsDadosFiscais.Enabled   := (qryTabela.State in DsEditModes);
  tbsQuadSoc.Enabled        := (qryTabela.State in DsEditModes);
  tbsRefBan.Enabled         := (qryTabela.State in DsEditModes);
  tbsRefCom.Enabled         := (qryTabela.State in DsEditModes);
  tbsCrediario.Enabled      := (qryTabela.State in DsEditModes);
  tbsClienteProduto.Enabled := (qryTabela.State in DsEditModes);
  tbsCliVei.Enabled         := (qryTabela.State in DsEditModes);
  tbsCliCnd.Enabled         := (qryTabela.State in DsEditModes);
  tbsConVis.Enabled         := (qryTabela.State in DsEditModes);
  tbsCliDiv.Enabled         := (qryTabela.State in DsEditModes);

  {Alterado para dsBrowse pois não era possível incluir dados na aba!}
  tbsCliConConEmp.Enabled   := (qryTabela.State = dsBrowse) And Not qryTabela.IsEmpty;

  tbsBairroAtende.Enabled   := (qryTabela.State in DsEditModes);
  tbsFazendas.Enabled       := (qryTabela.State in DsEditModes);
  tbsIntVen.Enabled         := (qryTabela.State in DsEditModes);
  tshEmbarcacoes.Enabled    := (qryTabela.State in DsEditModes);
  tbsEcommerce.Enabled      := (qryTabela.State in DsEditModes);
end;

procedure TfrmCadClientes.pPaginaAnterior;
begin
  pgcDados.SelectNextPage(False);
end;

procedure TfrmCadClientes.pPesquisaClienteCRM(const strCodCli: String = '');
begin
  If Not fEmptyStr(strCodCli) Then
    strCliCRM := strCodCli;

  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Add('SELECT SQL_NO_CACHE         ');
  qryTabela.SQL.Add('          *                 ');
  qryTabela.SQL.Add('  FROM CADCLI               ');
  qryTabela.SQL.Add(' WHERE CLI_CODCLI = :CODCLI ');
  qryTabela.ParamByName('CODCLI').AsString := strCliCRM;
  qryTabela.Open;
end;

procedure TfrmCadClientes.pCarregaDiaSemEnt;

  const
    ArrSemana : Array[1..7] of String = ('domingo', 'segunda-feira', 'terça-feira', 'quarta-feira',
                                         'quinta-feira', 'sexta-feira', 'sábado');

  Var
    qryCliHse : TUniQuery;
    strDias : String;
    intCnt : Integer;

  procedure pSetarHorarioSemana;
  begin
    If (Not qryCliHse.IsEmpty) And (qryCliHse.Locate('HSE_DAYOFW', cdsDtaPerEnt.FieldByName('DAYOFW').AsInteger, [])) Then
    Begin
      cdsDtaPerEnt.FieldByName('HRAINI').Value := qryCliHse.FieldByName('HSE_HRAINI').Value;
      cdsDtaPerEnt.FieldByName('HRAFIN').Value := qryCliHse.FieldByName('HSE_HRAFIN').Value;
      cdsDtaPerEnt.FieldByName('HRAIN2').Value := qryCliHse.FieldByName('HSE_HRAIN2').Value;
      cdsDtaPerEnt.FieldByName('HRAFI2').Value := qryCliHse.FieldByName('HSE_HRAFI2').Value;
      cdsDtaPerEnt.FieldByName('HRAIN3').Value := qryCliHse.FieldByName('HSE_HRAIN3').Value;
      cdsDtaPerEnt.FieldByName('HRAFI3').Value := qryCliHse.FieldByName('HSE_HRAFI3').Value;
    End;
  end;

begin
  If (Not blnUTDTFE) Then
    Exit;

  cdsDtaPerEnt.EmptyDataSet;

  strDias := fPadR(qryTabela.FieldByName('CLI_DSENTR').AsString, lstDiaSemPerFat.Items.Count, 'N');

  If (Not fEmptyStr(strDias)) And (Length(strDias) = 7) Then
  Begin
    qryCliHse := fCriaQuery(Self);
    Try
      qryCliHse.SQL.Text := 'SELECT * FROM CLIHSE WHERE HSE_CODCLI = ' + QuotedStr(qryTabela.FieldByName('CLI_CODCLI').AsString) + ' ORDER BY HSE_DAYOFW ';
      qryCliHse.Open;

      For intCnt := 1 To 7 Do
      Begin
        cdsDtaPerEnt.Append;
        cdsDtaPerEnt.FieldByName('SEMANA').AsString := ArrSemana[intCnt];
        cdsDtaPerEnt.FieldByName('MARCAD').AsBoolean := (strDias[intCnt] = 'S');
        cdsDtaPerEnt.FieldByName('DAYOFW').AsInteger := intCnt;
        pSetarHorarioSemana;
        cdsDtaPerEnt.Post;
      End;

      qryCliHse.Close;
    Finally
      FreeAndNil(qryCliHse);
    End;
  End;
end;

procedure TfrmCadClientes.pProcuraBotaoArqAnexClienteCRM;
var
  intCont: Integer;
  intTabs: Integer;
begin
  For intCont := 0 To Self.ComponentCount - 1 Do
  Begin
    If Self.Components[intCont] is TBitBtnLocked Then
    Begin
      If (Self.Components[intCont] as TBitBtnLocked).Name = strDesCamCRM Then
      Begin
        For intTabs := 0 to pgcDados.PageCount - 1 Do
        Begin
          pgcDados.ActivePageIndex := intTabs;
          If TBitBtnLocked(Self.Components[intCont]).CanFocus Then
          Begin
            If TBitBtnLocked(Self.Components[intCont]).Enabled And TBitBtnLocked(Self.Components[intCont]).Visible Then
            Begin
              pSetFocus(TBitBtnLocked(Self.Components[intCont]));
              TBitBtnLocked(Self.Components[intCont]).Click;
              blnArqCliCrm := False;
            End;
            Exit;
          End
          Else if (intTabs = pgcDados.PageCount - 1) then
          Begin
            pgcDados.ActivePageIndex := 0;
            fMensagem('Informação !','Esse botão no momento, encontra-se indisponível para alteração !',['&Ok']);
          End;
        End;
      End;
    End;
  End;
end;

procedure TfrmCadClientes.pProcuraCampoClienteCRM;
var
  intCont: Integer;
  intTabs: Integer;
begin
  For intCont := 0 To Self.ComponentCount - 1 Do
  Begin
    If Self.Components[intCont] is TDBEditFocus Then
    Begin
      If (Self.Components[intCont] as TDBEditFocus).DataField = strCampoCRM Then
      Begin
        For intTabs := 0 to pgcDados.PageCount - 1 Do
        Begin
          pgcDados.ActivePageIndex := intTabs;
          If TDBEditFocus(Self.Components[intCont]).CanFocus Then
          Begin
            If TDBEditFocus(Self.Components[intCont]).Enabled And TDBEditFocus(Self.Components[intCont]).Visible Then
            Begin
              pSetFocus(TDBEditFocus(Self.Components[intCont]));
              TDBEditFocus(Self.Components[intCont]).SelectAll;
            End;
            Exit;
          End
          Else if (intTabs = pgcDados.PageCount - 1) then
          Begin
            pgcDados.ActivePageIndex := 0;
            fMensagem('Informação !','Esse campo no momento, encontra-se indisponível para alteração !',['&Ok']);
          End;
        End;
      End;
    End;
  End;
end;

procedure TfrmCadClientes.pProcuraCampoContatoCRM;
var
  Key : Word;
begin
  Key := VK_RETURN;
  pgcDados.ActivePage := tbsContato;
  cdsCliCtt.Locate(strCampoCRM,strDesCamCRM,[]);
  dbgContatosKeyDown(Self,Key,[]);
end;

procedure TfrmCadClientes.pProximaPagina;
begin
  Try
    tbsCliConconEmp.TabStop := False;

    If pgcDados.ActivePage.Tag < intPaginasAtivas Then
      inherited

    Else If btnGravar.Enabled And btnGravar.CanFocus Then
    Begin
      blnMudarFoco := False;
      pSetFocus(btnGravar);
    End;

  Finally
    tbsCliConconEmp.TabStop := True;
  End;
end;

procedure TfrmCadClientes.pCarregaClaRECAP;
var
  strSQL: String;
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;

  try
    strSQL := '';
    strSQL := strSQL + ' SELECT CRECAP.AUTOINCREM AUTINC, RCP_CODNCM CODNCM, NCM_DESCRI DESCRI, NCM_CODEXC CODEXC ';
    strSQL := strSQL + ' FROM CRECAP ';
    strSQL := strSQL + ' INNER JOIN CADNCM ON CRECAP.RCP_CODNCM = CADNCM.NCM_CODNCM ';
    strSQL := strSQL + ' WHERE RCP_SEQCLI = :SEQCLI ';

    qryAux.SQL.Text := strSQL;
    qryAux.ParamByName('SEQCLI').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryAux.Open;

    cdsClaRECAP.EmptyDataSet;

    while not qryAux.Eof do
    begin
      cdsClaRECAP.Insert;
      cdsClaRECAP.FieldByName('AUTINC').AsString := qryAux.FieldByName('AUTINC').AsString;
      cdsClaRECAP.FieldByName('CODNCM').AsString := qryAux.FieldByName('CODNCM').AsString;
      cdsClaRECAP.FieldByName('DESCRI').AsString := qryAux.FieldByName('DESCRI').AsString;
      cdsClaRECAP.FieldByName('DESCOM').AsString := fRetDescricaoNcm(qryAux.FieldByName('CODNCM').AsString, qryAux.FieldByName('CODEXC').AsString);
      cdsClaRECAP.FieldByName('OPERAC').AsString := '';
      cdsClaRECAP.Post;

      qryAux.Next;
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TfrmCadClientes.pCarregaCliDepProd(strCodCli: String);
begin
  edtCodDep.Clear;
  edtDesDep.Clear;
  With qryCliDep, SQL Do
  Begin
    Close;

    Clear;
    Add('SELECT');
    Add('  D.AUTOINCREM,');
    Add('  D.DEP_CODCLI,');
    Add('  D.DEP_CODDEP,');
    Add('  (SELECT DE.DEP_DESCRI FROM CADDEP DE WHERE DE.DEP_CODIGO = D.DEP_CODDEP) AS DEP_DESCRI');
    Add('FROM');
    Add('  CLIDEP D');
    Add('WHERE');
    Add('  D.DEP_CODCLI = :CODCLI ');

    ParamByName('CODCLI').AsString := strCodCli;

    cdsCliDep.Close;
    cdsCliDep.SetProvider(dspCliDep);

    Open;
    pSetaClient(qryCliDep);

    cdsCliDep.Open;
  End;
end;

procedure TfrmCadClientes.pCarregaCliFid;
begin
  pPesquisaCadCli(qryTabela, qryCliFid, dbeCliFid.Text);
  edtCliFid.Text := qryCliFid.FieldByName('CLI_NOMCLI').AsString;  
end;

procedure TfrmCadClientes.pCarregaCliForMarNaoPermitidos(strCodCli: String);
Var
  strSQL: String;
  qryDados: TUniQuery;
begin
  If Not (fCfgSis('UTIFMP', varBoolean)) Then
    Exit;

  qryDados := fCriaQuery;
  try
    dspCliFNP.DataSet := qryDados;

    strSQL := fRetornaSqlCliFornecedorNaoPermitido;

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('CODCLI').AsString := strCodCli;
    qryDados.Open;

    pSetaClient(qryDados);

    cdsCliFNP.Close;
    cdsCliFNP.SetProvider(dspCliFNP);
    cdsCliFNP.Open;
    cdsCliFNP.SetProvider(nil);
  finally
    FreeAndNil(qryDados);
  end;

  qryDados := fCriaQuery;
  try
    dspCliMNP.DataSet := qryDados;

    strSQL := fRetornaSqlCliMarcaNaoPermitida;

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('CODCLI').AsString := strCodCli;
    qryDados.Open;

    pSetaClient(qryDados);

    cdsCliMNP.Close;
    cdsCliMNP.SetProvider(dspCliMNP);
    cdsCliMNP.Open;
    cdsCliMNP.SetProvider(nil);
  finally
    FreeAndNil(qryDados);
  end;
end;

procedure TfrmCadClientes.pCarregaCliVendedores(strCodCli: String);
  Var
    strSQL: String;
    qryVen: TUniQuery;
begin
  qryVen := fCriaQuery;
  dspCliVendedores.DataSet := qryVen;

  strSQL := fRetornaSqlCliVendedores ;

  With qryVen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := strCodCli;
    Open;
  End;

  pSetaClient(qryVen);

  cdsCliVendedoresMar.Close;
  cdsCliVendedoresMar.SetProvider(dspCliVendedores);
  cdsCliVendedoresMar.Open;
  cdsCliVendedoresMar.SetProvider(nil);

  FreeAndNil(qryVen);
end;

function TfrmCadClientes.dbeCliFidChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadCli(Key);
  pAtribuiTabelas;
end;

procedure TfrmCadClientes.dbeCliFidKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  Try
    If fPesqCliente(conCliSimples, Self, dbeCliFid, edtCliFid, nil, Key, arrSel) Then
    Begin
      If (fValidaCampos(dbeCliFid)) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmCadClientes.dbeCliFidKeyPress]');
    End;
  End;

end;

function TfrmCadClientes.dbeCNAEChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadCNAE(Key);
  pAtribuiTabelas;
end;

procedure TfrmCadClientes.dbeCNAEKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
    qryCadCNA: TUniQuery;
begin
  inherited;

  try
    qryCadCNA := fCriaQuery(nil);

    if fPesqCNAE(conSimples, Self, dbeCNAE, edtDesCna, qryCadCNA, Key, arrSel) then
      If fValidaCampos(TDBEditFocus(Sender), True) Then
        SelectNext(ActiveControl, True, True);
  finally
    FreeAndNil(qryCadCNA);
  end;

end;

procedure TfrmCadClientes.pCarregaProdutos(strCodCli: String);
begin
  If (Not blnCliPro) Then
    Exit;

  Try
    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.strChave := 'PRODUTOS RELACIONADOS';
    frmGravando.lblGravando.Caption := 'Aguarde enquanto carrega os produtos relacionados';
    frmGravando.fExecutarAcao := fCarregaProdRelacionados;
    frmGravando.ShowModal;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmCadClientes.pCarregaVeiculos(strCodCli: String);
  Var
    intContador: Integer;
begin
  pLimpaEditsVeiculos;

  If Assigned(lstVeiculos) Then
    FreeAndNil(lstVeiculos);

  lstVeiculos := TCliVei.fRetVeiculos(strCodCli);
  cdsCliVei.EmptyDataSet;
  For intContador := 0 To lstVeiculos.Count -1 Do
  Begin
    objCliVei := TCliVei(lstVeiculos[intContador]);
    pAdicionaVeiculosCds(objCliVei);
  End;
end;

procedure TfrmCadClientes.pCarregaProdutosAlteracao;
begin
  pAtualizaEditsProdutos(cdsCliPro);
  pSetFocus(edtCodIte);
  blnAltProduto := True;
end;

procedure TfrmCadClientes.pCarregaProfissional(strCodCli: String);
begin
  edtCodDiv.Clear;
  edtNomDiv.Clear;

  With qryCliDiv, SQL Do
  Begin
    Close;

    Clear;
    Add('SELECT ');
    Add('  C.*, ');
    Add(' (SELECT DIV_NOMDIV FROM CADDIV WHERE DIV_CODDIV = C.DIV_CODDIV) AS DIV_NOMDIV, ');
    Add(' (SELECT CONCAT(A.ATI_CODATI,"-",A.ATI_DESATI) AS ATIVID ');
    Add('  FROM   CADATI A INNER JOIN CADDIV D ON A.ATI_CODATI = D.DIV_CODATI ');
    Add('  WHERE  D.DIV_CODDIV = C.DIV_CODDIV) AS DIV_NOMATI ');
    Add('FROM ');
    Add('  CLIDIV C ');
    Add('WHERE');
    Add('  C.DIV_CODCLI = :CODCLI ');
    ParamByName('CODCLI').AsString := strCodCli;

    cdsCliDiv.Close;
    cdsCliDiv.SetProvider(dspCliDiv);

    Open;
    pSetaClient(qryCliDiv);

    cdsCliDiv.Open;
  End;
end;

class procedure TfrmCadClientes.pCarregaProfissionalCFG(
  const strCodCli: string);
var
  qryCliDiv: TUniQuery;
begin
  qryCliDiv := fCriaQuery;

  try
    try
      qryCliDiv := fCriarQuery('SELECT * FROM CLIDIV WHERE FALSE');
      qryCliDiv.Open();

      qryCliDiv.Append;
      qryCliDiv.FieldByName('DIV_CODCLI').AsString := strCodCli;
      qryCliDiv.FieldByName('DIV_CODDIV').AsString := fCfgSis('PNVCLI');
      qryCliDiv.FieldByName('DIV_SUGEST').AsString := 'S';
      qryCliDiv.Post;
    finally
      FreeAndNil(qryCliDiv);
    end;
  except
    raise;
  end;
end;

procedure TfrmCadClientes.pCarregaQuaCli;
var
  qryQuaCli: TUniQuery;
begin
  qryQuaCli := fCriaQuery(Self);
  cdsCadQualificacao.EmptyDataSet;
  Try
    qryQuaCli.SQL.Text := 'SELECT QUACLI.*, CADQUA.QUA_DESQUA, CADQUA.AUTOINCREM AUTINC, CADQUA.QUA_CODQUA CODQUA FROM QUACLI '+
                          ' JOIN CADQUA ON CADQUA.AUTOINCREM = QUACLI.QUA_CODQUA'+
                          ' WHERE QUA_CODCLI = '+ QuotedStr(qryTabela.FieldByName('CLI_CODCLI').AsString);
    qryQuaCli.Open;

    qryQuaCli.First;

    While Not qryQuaCli.Eof Do
    Begin
      cdsCadQualificacao.Append;
      cdsCadQualificacao.FieldByName('AUTOINCREM').AsString := qryQuaCli.FieldByName('AUTOINCREM').AsString;
      cdsCadQualificacao.FieldByName('QUA_CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
      cdsCadQualificacao.FieldByName('QUA_CODQUA').AsString := qryQuaCli.FieldByName('CODQUA').AsString;
      cdsCadQualificacao.FieldByName('AUTINC').AsString     := qryQuaCli.FieldByName('AUTINC').AsString;
      cdsCadQualificacao.FieldByName('QUA_DESQUA').AsString := qryQuaCli.FieldByName('QUA_DESQUA').AsString;
      cdsCadQualificacao.FieldByName('QUA_CERQUA').AsString := qryQuaCli.FieldByName('QUA_CERQUA').AsString;
      cdsCadQualificacao.FieldByName('QUA_OBSQUA').AsString := qryQuaCli.FieldByName('QUA_OBSQUA').AsString;
      cdsCadQualificacao.Post;
      qryQuaCli.Next;
    End;
  Finally
    FreeAndNil(qryQuaCli);
  End;
end;

procedure TfrmCadClientes.pCarregarCliente;
begin
  If Not qryTabela.IsEmpty Then
  Begin
    pCarregaSocios(qryTabela.FieldByName('CLI_CODCLI').AsString);
    pCarregaBeneficios(qryTabela.FieldByName('CLI_CODCLI').AsString);
    pCarregaContatos(qryTabela.FieldByName('CLI_CODCLI').AsString);
    pCarregaProdutos(qryTabela.FieldByName('CLI_CODCLI').AsString);
    pCarregaVeiculos(qryTabela.FieldByName('CLI_CODCLI').AsString);
    pCarregaRefComerciais(qryTabela.FieldByName('CLI_CODCLI').AsString);
    pCarregaCliVendedores(qryTabela.FieldByName('CLI_CODCLI').AsString);
    pCarregaCliForMarNaoPermitidos(qryTabela.FieldByName('CLI_CODCLI').AsString);
    pLimpaEditsRefComerciais;
    pCalculaTotalRenda(nil);
    pCarregaGridEmpCli;
    pCarregaInteligenciaDeVenda;
    pCarregarEmbarcacoes(qryTabela.FieldByName('CLI_CODCLI').AsString);
    VerificarDiasRestantesConsultaCredito;
    VerificarDiasRestantesConsultaCobranca;
    pCarregaClaRECAP;
    pCarregaResumo(qryTabela.FieldByName('CLI_CODCLI').AsString, fRetDesTipoAbf('C', qryTabela.FieldByName('CLI_CODCLI').AsString));

    if (fUtilizaEmpresaPrioridade) then
    Begin
      pCarregaEmpresaPrioridade;
    End;

    fltVlrLimCtrAnt := qryTabela.FieldByName('CLI_LIMCTR').AsFloat;
  End
  Else
  Begin

    If (Assigned(lstContatos)) Then
      lstContatos.Clear;
    cdsCliCtt.EmptyDataSet;

    pLimpaDadosProdutos;

    If (Assigned(lstVeiculos)) Then
      lstVeiculos.Clear;
    cdsCliVei.EmptyDataSet;

    If Assigned(cdsCliVendedores) And cdsCliVendedores.Active Then
      cdsCliVendedores.EmptyDataSet;

    If Assigned(cdsCliVendedoresMar) And cdsCliVendedoresMar.Active Then
      cdsCliVendedoresMar.EmptyDataSet;

    If Assigned(cdsCliFNP) And cdsCliFNP.Active Then
      cdsCliFNP.EmptyDataSet;

    If Assigned(cdsCliMNP) And cdsCliMNP.Active Then
      cdsCliMNP.EmptyDataSet;

    cdsCliRco.EmptyDataSet;

  End;

  pCarregaBairroAtende(qryTabela.FieldByName('CLI_CODCLI').AsString);
  pCarregaDadosAdicionais;

  If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
    pSetFocus(btnAlterar);

  pgcDados.ActivePageIndex := 0;

  pVerificaDireitosDadosPrincipais;
  pVerificaDireitosDadosRetencao;

  If qryTabela.Active Then
  Begin
    pSetaQueryCadCli(qryTabela);
    pOnStateChange;
  End;

  blnCadastroModificado := False;
  pAtualizaTributacao('CLI_SITP_C');
  pAtualizaTributacao('CLI_SITPCP');
  pAtualizaTributacao('CLI_SITIPI');
  blnLiberouTravaCgcCPF := False;
end;

procedure TfrmCadClientes.pGravaProfissional;
Begin
  edtCodDiv.Clear;
  edtNomDiv.Clear;

  With cdsCliDiv Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      Edit;
      FieldByName('DIV_CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
      Post;
      Next;
    End;

    ApplyUpdates(0);
    EnableControls;
  End;
end;

procedure TfrmCadClientes.pGravarQualificacao;
var
  qryQuaCli: TUniQuery;
  strAutInc: String;
begin
  qryQuaCli := fCriaQuery(Self);
  Try
    Try
      qryQuaCli.SQL.Text := 'DELETE FROM QUACLI WHERE QUA_CODCLI = '+ QuotedStr(qryTabela.FieldByName('CLI_CODCLI').AsString);
      qryQuaCli.ExecSql;

      qryQuaCli.SQL.Text := 'INSERT INTO QUACLI '+
                            ' (AUTOINCREM, '+
                            '  QUA_CODQUA, '+
                            '  QUA_CODCLI, '+
                            '  QUA_OBSQUA, '+
                            '  QUA_CERQUA) VALUES '+
                            ' (:AUTOINCREM, '+
                            '  :QUA_CODQUA, '+
                            '  :QUA_CODCLI, '+
                            '  :QUA_OBSQUA, '+
                            '  :QUA_CERQUA) ';

      cdsCadQualificacao.First;
      While Not cdsCadQualificacao.Eof Do
      Begin
        If fEmptyStr(cdsCadQualificacao.FieldByName('AUTOINCREM').AsString) Then
          strAutInc := fRetAutoIncrem('QUACLI', VS_strCodEmp)
        Else
          strAutInc := cdsCadQualificacao.FieldByName('AUTOINCREM').AsString;
        qryQuaCli.ParamByName('AUTOINCREM').AsString := strAutInc;
        qryQuaCli.ParamByName('QUA_CODQUA').AsString := cdsCadQualificacao.FieldByName('AUTINC').AsString;
        qryQuaCli.ParamByName('QUA_CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
        qryQuaCli.ParamByName('QUA_OBSQUA').AsString := cdsCadQualificacao.FieldByName('QUA_OBSQUA').AsString;
        qryQuaCli.ParamByName('QUA_CERQUA').AsString := cdsCadQualificacao.FieldByName('QUA_CERQUA').AsString;
        qryQuaCli.ExecSQL;
        cdsCadQualificacao.Next;
      End;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message,'[TfrmCadClientes.pGravarQualificacao]');
      End;
    End;
  Finally
    FreeAndNil(qryQuaCli);
  End;
end;

function TfrmCadClientes.fGravarContatosCliente: Boolean;
  Var
    intContador: Integer;
begin
  Try
    If blnAltContato Then
      btnAdicionarCttClick(btnAdicionarCtt);

    pLimpaEditsContatos;

    For intContador := 0 To lstContatos.Count -1 Do
    Begin
      TCliCtt(lstContatos[intContador]).strCodCli := qryTabela.FieldByName('CLI_CODCLI').AsString;

      If (TCliCtt(lstContatos[intContador]).blnExcluir) Then
        TCliCtt(lstContatos[intContador]).pExcluirCliCtt()
      Else
        TCliCtt(lstContatos[intContador]).pInsereCliCtt();

      strCodCliCtt := TCliCtt(lstContatos[intContador]).strAutoincrem;
    End;


    dbgContatos.ReadOnly := True;
    pnlContatos.Enabled  := False;
    pnlAutCtt.Enabled    := False;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      strCodCliCtt := '';
      fRollBack;
      pCarregaContatos(qryTabela.FieldByName('CLI_CODCLI').AsString);
      pMensagensErro(E.Message,'[TfrmCadClientes.fGravarContatosCliente]');
    End;
  End;
end;

procedure TfrmCadClientes.pCarregaVeiculosAlteracao;
begin
  If (Assigned(objCliVei)) Then
    FreeAndNil(objCliVei);

  objCliVei := TCliVei(lstVeiculos[cdsCliVei.RecNo-1]);
  pSetFocus(mskPlaVei);
  blnAltVeiculo := True;
end;

procedure TfrmCadClientes.pConfiguracoesIniciaisCampos;
  var
    intCont: Integer;
begin
  {Se resolução disponível for inferior à (1024 x 768), maximiza tela!}
  If (Screen.Width < 1024) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
  Begin
    Self.Position := poDesigned;
    Self.WindowState := wsMaximized;
  End;

  FcdsNCO := fCriaEstruturaCdsNCO(Nil);
  objLiberacao := TLiberacao.create;
  blnCanalAcessoLibera    := False;
  blnJahLiberouFormaPagto := False;
  blnJahLiberouPortador   := False;
  blnJahLiberouPortador2  := False;
  blnSCPCAutomatico       := False;
  blnCliProHer            := False;
  blnUTDTFE := fCfgSis('UTDTFE', varBoolean);
  blnCliPro := fCfgSis('CLIPRO', varBoolean);
  blnCliDep := fCfgSis('CLIDEP', varBoolean);
  blnUtiCon := fCfgSis('UTICON', varBoolean);
  blnDesPro := fVerificaAcessoSistema('DESPRO');
  blnLimCredAut := fCfgSis('CREAUT', varBoolean);
  pHabilitaBotaoLimiteDeCredito(False);
  pVerdeVermelho(dbeDescon, shpDesPro, blnDesPro, False, False);

  FPais := fSetaPais;

  LogAltCadCli := TLogAltCadCli.Create(Self);

  blnValidaDataMuitoAntiga := False;

  blnAlteraBeneficio := False;

  blnCadContato    := False;
  lblMarca.Visible := fCfgSis('CLIMAR', varBoolean);
  dbeMarca.Visible := fCfgSis('CLIMAR', varBoolean);

  lblIndCom.Visible := fCfgSis('INDCOM', varBoolean);
  dbcIndCom.Visible := fCfgSis('INDCOM', varBoolean);

  lblLatitu.Visible := fCfgSis('USALAT', varBoolean);
  dbeLatitu.Visible := fCfgSis('USALAT', varBoolean);

  lblLongit.Visible := fCfgSis('USALAT', varBoolean);
  dbeLongit.Visible := fCfgSis('USALAT', varBoolean);

  lblRaio__.Visible := fCfgSis('USALAT', varBoolean);
  dbeRaio__.Visible := fCfgSis('USALAT', varBoolean);

  lblPerfin.Visible := blnLimCredAut;
  dbePerfin.Visible := blnLimCredAut;

  lblIDEstrangeiro.Visible := (fCfgSis('TAGEST', varString) = 'S');
  dbeIDEstrangeiro.Visible := lblIDEstrangeiro.Visible;

  blnCliBat := fCfgSis('CLIBAT', varBoolean);

  If Not (fCfgSis('DESPON', varBoolean) And (fCfgSis('TDEPON') = '2')) Then
  Begin
    lblPerDPo.Visible := False;
    dbePerDPo.Visible := False;
    lblPercn2.Visible := False;
    lblQtdDAV.Visible := False;
    dbeQtdDAV.Visible := False;
  End;

  qryCliBat := fCriaQuery(Self);
  cdsCliBat := fCriacdsCliBat;
  dtsCliBat := fCriaDataSource(cdsCliBat);

  cdsCliBat.AfterPost := cdsCliBatAfterPost;

  If blnCliBat Then
    dbgCliBat.DataSource := dtsCliBat;

  qryGruRis := fCriaQuery(Self);
  dtsGruRis := fCriaDataSource(qryGruRis);
  cbxGrupoRisco.ListSource := dtsGruRis;

  strStatusContaContabil := '';

  pInicializaValoresPadrao;

  strOpeLibLimCre := strLoginUsuarioLogado;
  strCodClienteIniciarCadastro := '';

  cdsCliPro := TUniClientDataSet.Create(Self);
  dspCliPro := TUniDataSetProvider.Create(Self);
  dtsCliPro.DataSet := cdsCliPro;

  cdsCliPro.AfterScroll := pAtualizaEditsProdutos;

  //Variaveis usados somente pelo frmCRM
  blnUtilizarCrm := False;
  blnArqCliCrm   := False;
  blnEditaCliCrm := False;
  strCliCRM      := '';
  strCampoCRM    := '';
  strRegraCRM    := '';
  strDesCamCRM   := '';

  strBaiCobLib := '';
  strBairroLib := '';

  pCriaCadCliEndEntrega;
  pCriaCadCliFazendas;

  strNomeTabela         := 'CADCLI';
  strNomeCampo          := 'CLI_CODCLI';

  qryTabela             := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  pSetaQueryCadCli(qryTabela);
  qryTabela.AfterScroll := pQueryCadCliAfterScroll;
  dtsTabela.DataSet     := qryTabela;

  qryCadFic             := fCriarQuery('SELECT * FROM CADFIC WHERE FALSE', Self);
  qryCadFic.AfterScroll := pQueryCadFicAfterScroll;
  qryCadFic.AfterOpen   := pQueryCadFicAfterOpen;
  qryCadFic.BeforePost  := pQueryCadFicBeforePost;
  dtsCadFic.DataSet     := qryCadFic;

  qryInfCre             := fCriarQuery('SELECT * FROM CLI_INFCRE WHERE FALSE', Self);
  qryInfCre.AfterScroll := pQueryInfCreAfterScroll;
  qryInfCre.AfterOpen   := pQueryInfCreAfterOpen;
  dtsInfCre.DataSet     := qryInfCre;

  qryCliFid := fCriaQuery(Self);
  qryConPor := fCriaQuery(Self);
  qryConPro := fCriaQuery(Self);
  qryConCtt := fCriaQuery(Self);
  qryCadAti := fCriaQuery(Self);
  qryCadCid := fCriaQuery(Self);
  qryConRco := fCriaQuery(Self);
  qryResumo := fCriaQuery(Self);

  qryTipClg := fCriarQuery('SELECT * FROM TIPCLG WHERE FALSE', Self);
  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodCli;

  objCliVei := TCliVei.Create(Self);

  blnAltVeiculo := False;

  dbgCliVei.ReadOnly := True;
  pnlCliVei.Enabled  := False;

  cdsCliVei.CreateDataSet;
  cdsCliVei.AfterScroll := pAtualizaEditsVeiculos;

  cdsDtaPerEnt.CreateDataSet;

  tbsGeral2.TabVisible       :=                  fVerificaAcessoSistema('CLCOMP'); { VISUALIZAR ABA 2-COMPLEMENTOS                    }
  tbsContato.TabVisible      :=                  fVerificaAcessoSistema('CLICON'); { VISUALIZAR ABA 3-CONTATOS                        }
  tbsEntregas.TabVisible     :=                  fVerificaAcessoSistema('CLENET'); { VISUALIZAR ABA 4-ENDEREÇOS DE ENTREGA            }
  tbsCbrEnt.TabVisible       := blnCobEnt    And fVerificaAcessoSistema('CLCOBR'); { VISUALIZAR ABA 5-DADOS DE COBRANÇA               }
  tbsObservacoes.TabVisible  :=                  fVerificaAcessoSistema('CLINFC'); { VISUALIZAR ABA 6-INFORMACOES DE COMPRA           }
  tbsDadosFiscais.TabVisible :=                  fVerificaAcessoSistema('CLDADF'); { VISUALIZAR ABA 7-DADOS FISCAIS                   }
  tbsQuadSoc.TabVisible      := blnRefCom    And fVerificaAcessoSistema('CLQDSO'); { VISUALIZAR ABA 8-QUADRO SOCIETÁRIO               }
  tbsRefBan.TabVisible       := blnRefCom    And fVerificaAcessoSistema('CLRFBA'); { VISUALIZAR ABA 9-REFERÊNCIAS BANCÁRIAS           }
  tbsRefCom.TabVisible       := blnRefCom    And fVerificaAcessoSistema('CLRFCM'); { VISUALIZAR ABA 10-REFERÊNCIAS COMERCIAIS         }
  tbsCrediario.TabVisible    := blnCrediario And fVerificaAcessoSistema('CLINCR'); { VISUALIZAR ABA 11-INFORMAÇÕES DE CREDIÁRIO       }
  tbsQualificacao.TabVisible := fCfgSis('USAQUA', varBoolean);

  {***********************************************************************************************************************************}
  {*                                                                               { VISUALIZAR ABA 12-RELACIONAMENTO CLIENTE-PRODUTO }
  {********************************************************************************************************************************RV*}
  If (blnCliPro) And fVerificaAcessoSistema('CLRLCP') Then
  Begin
    lblBar_CP.Visible := fCfgSis('APRBAR', varBoolean);
    edtBar_CP.Visible := fCfgSis('APRBAR', varBoolean);
    dbgProdutosCODBAR.Visible := fCfgSis('APRBAR', varBoolean);
    tbsClienteProduto.TabVisible := True;
  End
  Else
    tbsClienteProduto.TabVisible := False;
  tbsCliVei.TabVisible       := (fCfgSis('CLIVEI') = 'S')       And fVerificaAcessoSistema('CLVEIC'); { VISUALIZAR ABA 13-VEICULOS               }
  tbsCliCnd.TabVisible       :=                                     fVerificaAcessoSistema('CLCNDP'); { VISUALIZAR ABA 14-CONDIÇOES DE PAGAMENTO }
  tbsConVis.TabVisible       := (fCfgSis('CONVIS', varBoolean)) And fVerificaAcessoSistema('CLIVIS'); { VISUALIZAR ABA 15-VISITAS                }
  tbsCliDiv.TabVisible       := (Not (fCfgSis('NROPRO') = '1')) And fVerificaAcessoSistema('CLIPRO'); { VISUALIZAR ABA 16-PROFISSIONAIS          }
  tbsCliConconEmp.TabVisible :=                                     fVerificaAcessoSistema('CLCONT'); { VISUALIZAR ABA 17-CONTA CONTABIL/EMPRESA }
  tbsBairroAtende.TabVisible := blnCliBat                       And fVerificaAcessoSistema('CLBRAT'); { VISUALIZAR ABA 18-BAIRROS ATENDIDOS      }
  tbsFazendas.TabVisible     := (fCfgSis('CADFAZ') = 'S')       And fVerificaAcessoSistema('CLIFAZ'); { VISUALIZAR ABA 18-FAZENDAS               }
  {**********************************************************************************************************************************************}
  {*                                                                                                  { VISUALIAR ABA 19-INTELIGENCIA DE VENDA   }
  {**********************************************************************************************************************************************}
  If VS_strHabilitarCRM Then
  Begin
    cdsCliFor := TZClient.Create(Self, fSQLCliFor);
    cxgCliForTableView.DataController.DataSource := cdsCliFor.dtsSource;
    tbsIntVen.TabVisible := fVerificaAcessoSistema('CLINVN');

    grbMedCom.Visible := fVerificaAcessoSistema('MEDCOM');
    btnCalcCompraMensal.Visible := fVerificaAcessoSistema('MEDCOM');
  End
  Else
  Begin
    tbsIntVen.TabVisible        := False;
    grbMedCom.Visible           := False;
    btnCalcCompraMensal.Visible := False;
  End;
  tshEmbarcacoes.TabVisible  := fCfgSis('CADEMB', varBoolean)   And fVerificaAcessoSistema('CLEMBA'); { VISUALIZAR ABA 20-EMBARCAÇÕES            }
  tbsDatasControle.TabVisible:= blnUTDTFE                       And fVerificaAcessoSistema('CLDTCT'); { VISUALIZAR ABA 21-DATAS DE CONTROLE      }
  tbsDepartamentoCliente.TabVisible := blnCliDep                and fVerificaAcessoSistema('CLRLCP'); { VISUALIZAR ABA 23-REL. CLIENTE DEP PROD  }
  tbsPrioridadeSaidaEstoque.TabVisible := fUtilizaEmpresaPrioridade;
  tbsEcommerce.TabVisible              := fCfgSis('EXIECO') = 'S';                                    { VISUALIZAR ABA 25-E-COMMERCE           }
  TabRegimeEspecial.TabVisible := fAlgumaEmpresaUtilizaRegimeEspecial;

  objCliPro := TCliPro.Create(Self);

  blnAltProduto := False;

  pnlProdutos.Enabled  := False;

  pAtribuiTags;

  objCliCtt := TCliCtt.Create(Self);
  blnAltContato := False;

  dbgContatos.ReadOnly := True;
  pnlTopoQuadSco.Enabled  := False;
  pnlAutCtt.Enabled    := False;

  cdsCliCtt.CreateDataSet;

  pnlAutCtt.Visible := fCfgSis('AUTCTT', VarBoolean) Or
                       (fCfgSis('LOCEQU', varBoolean) And fCfgSis('RESLOC', varBoolean));
  chkAutCtt.Visible := fCfgSis('AUTCTT', VarBoolean);

  blnAltSocio := False;

  fFindColumnByName(dbgContatos, 'CLI_AUTCTT').Visible := pnlAutCtt.Visible;
  fFindColumnByName(dbgContatos, 'CLI_CPFCTT').Visible := pnlAutCtt.Visible;
  fFindColumnByName(dbgContatos, 'CLI_RG_CTT').Visible := pnlAutCtt.Visible;

  pAjustaAbaContatos;
  pAjustaBotoesAbaContatos;

  {******************************}
  { REFERENCIAS COMERCIAIS       }
  {***************************AC*}
  objCliRco := TCliRco.Create(Self);
  blnAltRefComer := False;

  blnAltQuaCli   := False;
  setLength(arrQualificacao, 0);

  dbgCliRco.ReadOnly := True;
  pnlRefComerciais.Enabled  := False;
  pnlQualificacao.Enabled   := False;
  cxGridQuaCli.Enabled      := False;
  lstDiaFix.Enabled := False;
  lstDiaMes.Enabled := False;

  lstDiaSemPerFat.Enabled := False;
  lstDiaMesPerFat.Enabled := False;
  lstDiaMesPerEnt.Enabled := False;
  cxgDiaSemEnt.Enabled := False;

  lstDiaFix.OnKeyDown := pOnKeyDownEdits;
  lstDiaMes.OnKeyDown := pOnKeyDownEdits;

  lstDiaSemPerFat.OnKeyDown := pOnKeyDownEdits;
  lstDiaMesPerFat.OnKeyDown := pOnKeyDownEdits;
  lstDiaMesPerEnt.OnKeyDown := pOnKeyDownEdits;

  cdsCliRco.CreateDataSet;
  cdsCliRco.AfterScroll := pAtualizaEditsRefComerciais;
  pLimpaEditsRefComerciais;

  cdsCliVendedores := TUniClientDataSet.Create(Self);
  dspCliVendedores := TUniDataSetProvider.Create(Self);

  objRedeLojas := TRedeLojas.Create(Self);

  pAtribuiTabelas;

  cbxSexo.Items.Clear;

  For intCont := 0 To Length(ARR_SEXO) -1 Do
    cbxSexo.Items.Add(ARR_SEXO[intCont][0]);

  cbxMoradia.Items.Clear;

  For intCont := 0 To Length(ARR_MORADIA) -1 Do
    cbxMoradia.Items.Add(ARR_MORADIA[intCont][0]);

  cbxEstCiv.Items.Clear;

  For intCont := 0 To Length(ARR_ESTADOCIVIL) -1 Do
    cbxEstCiv.Items.Add(ARR_ESTADOCIVIL[intCont][0]);

  cbxEscolaridade.Items.Clear;

  For intCont := 0 To Length(ARR_ESCOLARIDADE) -1 Do
    cbxEscolaridade.Items.Add(ARR_ESCOLARIDADE[intCont][0]);

  objPageControlOrder := TPageControlOrder.Create(Self);
  objPageControlOrder.PageControl := pgcDados;
  objPageControlOrder.ReadOnlyFirstIndex := True;

  pPreencheCombo(TCustomComboBox(dbcCategoria),  arrCtgCli);

  cdsEmpCli.CreateDataSet;

  qryTabela.AfterOpen  := pQryTabelaAfterOpen;

  dbcTipAti.Visible   := (fCfgSis('OPCCOM', varString) = 'TA');
  lblTipAti.Visible   := (fCfgSis('OPCCOM', varString) = 'TA');

  If (fCfgSis('MARMKP', varInteger) = 1) Or
     (fCfgSis('MARMKP', varInteger) = 5) Then
  Begin
    lblMar03M.Caption := 'Margem:';
    lblMar06M.Caption := 'Margem:';
    lblMar12M.Caption := 'Margem:';
  End
  Else
  Begin
    lblMar03M.Caption := 'Markup:';
    lblMar06M.Caption := 'Markup:';
    lblMar12M.Caption := 'Markup:';
  End;

  blnCadastroModificado := False;

  cdsCliVendedoresMar := TUniClientDataSet.Create(Self);
  dspCliVendedoresMar := TUniDataSetProvider.Create(Self);

  cdsCliFNP := TUniClientDataSet.Create(Self);
  dspCliFNP := TUniDataSetProvider.Create(Self);
  cdsCliMNP := TUniClientDataSet.Create(Self);
  dspCliMNP := TUniDataSetProvider.Create(Self);


  intPaginasAtivas := fGetPagAtivas;

  pCarregaTributacao('CLI_SITP_C');
  pAtualizaTributacao('CLI_SITP_C');

  pCarregaTributacao('CLI_SITPCP');
  pAtualizaTributacao('CLI_SITPCP');

  SendMessage(cbxTributacaoPisCofins.Handle, CB_SETDROPPEDWIDTH, 200, 0);
  SendMessage(cbxTributacaoPisCofinsVendaPresencial.Handle, CB_SETDROPPEDWIDTH, 200, 0);

  pCarregaTributacao('CLI_SITIPI');
  pAtualizaTributacao('CLI_SITIPI');
  SendMessage(cbxTributacaoIPI.Handle, CB_SETDROPPEDWIDTH, 200, 0);

  cdsCadEmb.CreateDataSet();
  cdsCadQualificacao.CreateDataSet();

  cdsCadSco.CreateDataSet;
  cdsCadSco.EmptyDataSet;

  cdsCliBen.CreateDataSet;
  cdsCliBen.EmptyDataSet;

  lblMsgRetImposto.Visible := (fCfgSis('SIMPAU', varBoolean) and fCfgSis('RETIMP', varBoolean));
  lblMsgRetImposto1.Visible := lblMsgRetImposto.Visible;
  lblMsgRetImposto2.Visible := lblMsgRetImposto.Visible;

  lblCarExc.Visible := fCfgSis('CAREXC', varBoolean);
  dbeCarExc.Visible := lblCarExc.Visible;
  clbCarExc.Visible := lblCarExc.Visible;

  lblRemOut.Visible := fCfgSis('VENOUT', varBoolean);
  dbeRemOut.Visible := lblRemOut.Visible;
  cllRemOut.Visible := lblRemOut.Visible;

  lblOSNFEn.Visible := fCfgSis('CONEQU', varBoolean);
  dbeOSNFEn.Visible := lblOSNFEn.Visible;
  cllOSNFEn.Visible := lblOSNFEn.Visible;

  mskConPag.EditMask := MASK_CONPAG;

  cdsEmpresaPrioridade.CreateDataSet;

  pDefineAlteracaoEndereco;

  tbsCliConconEmp.TabStop := True;

  objConsulta := TConsultaEndereco.Create(Self);

  pCriaClientClaRECAP;

  pOrgaoPublicoForaDoEstado;

  fltFatValAnt := 0.00;
  strFatTipAnt := '';

  dbeLayCFF.Visible := ((fCfgSis('LAYCFF', varBoolean)) And (Not fEmptyStr(fCfgSis('CLACFF', varString))));
  lblLayCFF.Visible := dbeLayCFF.Visible;
  cllLayCFF.Visible := dbeLayCFF.Visible;

  cbbDestino.Visible := fCfgSis('REENCC', varBoolean);
  lblDestino.Visible := cbbDestino.Visible;

  pnlIgnoraTravaMargemCondPag.Visible := fCfgSis('PFLCLI', varBoolean) And
                                         fCfgSis('IGTVMK', varBoolean);

  blnTemDivergenciaSefaz := False;

  btnForMarNaoPermitidos.Visible := fCfgSis('UTIFMP', varBoolean);

  blnEnviaContatoCitelDesk := fCfgSis('ENVCTT', varBoolean);

  blnVerificarCgcCPF := False;
  blnLiberouTravaCgcCPF := False;

  fltVlrLimCtrAnt := 0.00;
  strIgtVmkAnt := EmptyStr;

  If FPais = opcBrasil Then
    lblEstadoEmissor.Caption := 'Estado Emis. CPF:'
  Else
    lblEstadoEmissor.Caption := 'Estado Emis. RUC:';

end;

procedure TfrmCadClientes.pConsultarEnderecoGoogleMaps;
var
  LPanel: TPanel;
  LForm: TfrmPaiSimples;
  LHelp: TfrmNavegadorViewHelp;
  LNavegador: TNavegador;
begin
  If Not objConsulta.fRetUrlConsultaEnderecoGoogleMaps(dbeEndere.Text, dbeEndNum.Text, dbeBairro.Text, edtNomCid.Text, edtEstado.Text) Then
  Begin
    fMensagem('ATENÇÃO!', ObjConsulta.MensagemRetorno, ['&Ok']);
    Exit;
  End;

  pCriarFormularios(TfrmPaiSimples, LForm);
  try
    LPanel := TPanel.Create(LForm);
    LPanel.Parent := LForm;
    LPanel.Align := alClient;
    LForm.Position := poMainFormCenter;
    LForm.Width := Floor(Self.Width * 0.95);
    LForm.Height := Floor(Self.Height * 0.95);
    LForm.Caption := 'Consultar Endereço no Google MAPS';
    LForm.Name := 'frmEnderecoGoogleMaps';
    LForm.pnlNomeForm.Caption := 'frmEnderecoGoogleMaps';
    pCriarFormularios(TfrmNavegadorViewHelp, LHelp);
    try
      LHelp.Align := alClient;
      LHelp.Dock(LPanel, LPanel.BoundsRect);
      LHelp.Show;
      Screen.Cursor := crHourGlass;
      try
        LNavegador := TNavegador.New;
        LNavegador.setParent(LPanel);
        LNavegador.Navigate(objConsulta.UrlConsulta);
      finally
        Screen.Cursor := crDefault;
      end;
      LForm.ShowModal;
    finally
      pFreeAndNil(LHelp);
    end;
  finally
    pFreeAndNil(LForm);
  end;
end;

procedure TfrmCadClientes.pControlaBotoes;
begin
  edtCodEmp.Enabled := (strStatusContaContabil = 'INSERT') or (strStatusContaContabil = 'UPDATE');
  edtConcon.Enabled := (strStatusContaContabil = 'INSERT') or (strStatusContaContabil = 'UPDATE');

  grdEmpCli.Enabled := Not ((strStatusContaContabil = 'INSERT') or (strStatusContaContabil = 'UPDATE'));

  btnIncluirCC.Enabled := Not((strStatusContaContabil = 'INSERT') or (strStatusContaContabil = 'UPDATE'));
  btnGravarCC.Enabled := (strStatusContaContabil = 'INSERT') or (strStatusContaContabil = 'UPDATE');
  btnAlterarCC.Enabled := Not((strStatusContaContabil = 'INSERT') or (strStatusContaContabil = 'UPDATE'));
  btnExcluirCC.Enabled := Not((strStatusContaContabil = 'INSERT') or (strStatusContaContabil = 'UPDATE'));
  btnCancelarCC.Enabled := (strStatusContaContabil = 'INSERT') or (strStatusContaContabil = 'UPDATE');
end;

procedure TfrmCadClientes.pRetNomeProfissional;
Begin
  If Not fEmptyStr(edtCodDiv.Text) Then
    edtNomDiv.Text := fRetNomProfissional(edtCodDiv.Text, True)
  Else
    edtNomDiv.Text := EmptyStr;
End;

procedure TfrmCadClientes.pCarregaRedeLojas;
var
  objRedeLojas : TRedeLojas;
begin

  If Not fEmptyStr(dbeCodRed.Text) Then
  Begin
    objRedeLojas := TRedeLojas.Create(Self);
    Try
      If objRedeLojas.fCarregaCadRed(dbeCodRed.Text) Then
        edtDesRed.Text := objRedeLojas.strDesRed
      Else
        edtDesRed.Text := EmptyStr;
    Finally
      FreeAndNil(objRedeLojas);
    End;
  End
  Else
  Begin
    edtDesRed.Text := EmptyStr;
  End;

end;

procedure TfrmCadClientes.pCarregaRefComerciais(strCodCli: String; blnAutoIncNULL : Boolean = False);
Var
  qryAux : TUniQuery;
  Obj    : TCliRco;
begin

  pLimpaEditsRefComerciais;
  cdsCliRco.EmptyDataSet;

  try

    qryAux := fCriaQuery(Self);
    qryAux.SQL.Add('SELECT        ');
    qryAux.SQL.Add('  CLI_CODCLI, ');
    qryAux.SQL.Add('  AUTOINCREM  ');
    qryAux.SQL.Add('FROM          ');
    qryAux.SQL.Add('  CLIRCO      ');
    qryAux.SQL.Add(' WHERE        ');
    qryAux.SQL.Add('CLI_CODCLI = :CODCLI');
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.Open;

    if not qryAux.IsEmpty then
    begin

      qryAux.First;
      while not qryAux.Eof do
      begin

        Obj := TCliRco.Create(Self,
                              qryAux.FieldByName('CLI_CODCLI').AsString,
                              qryAux.FieldByName('AUTOINCREM').AsString,
                              blnAutoIncNULL);

        try
          pAdicionaRefComerciaisCds(Obj);
        finally
          FreeAndNil(Obj);
        end;

        qryAux.Next;

      end;

    end;

  finally
    FreeAndNil(qryAux);
  end;

end;

procedure TfrmCadClientes.pCarregaRefComerciaisAlteracao;
begin

  objCliRco := TCliRco.Create(Self,
                              cdsCliRco.FieldByName('CODCLI').AsString,
                              cdsCliRco.FieldByName('AUTINC').AsString);

  pSetFocus(edtEmpRco);
  blnAltRefComer := True;
end;

procedure TfrmCadClientes.pCarregaRegiao;
Begin
  If Not fEmptyStr(dbeCodReg.Text) Then
    edtDesReg.Text := fRetNomRegiao(dbeCodReg.Text)
  Else
    edtDesReg.Text := EmptyStr;
End;

procedure TfrmCadClientes.pCarregarEmbarcacoes(strCodCli : String);
  Var
    strSQL: String;
    qryTemp: TUniQuery;
begin
  If (Not tshEmbarcacoes.TabVisible) Then Exit;

  Try
    strSQL := 'SELECT ';
    strSQL := strSQL + '  G.AUTOINCREM, ';
    strSQL := strSQL + '  D.AUTOINCREM AS AUTINC, ';
    strSQL := strSQL + '  G.EMB_CODEMB, ';
    strSQL := strSQL + '  G.EMB_NUMIMO, ';
    strSQL := strSQL + '  G.EMB_INSCRI, ';
    strSQL := strSQL + '  G.EMB_NOMEMB, ';
    strSQL := strSQL + '  G.EMB_INDEMB, ';
    strSQL := strSQL + '  G.EMB_PORTOI, ';
    strSQL := strSQL + '  G.EMB_LOCEMB, ';
    strSQL := strSQL + '  IF( ';
    strSQL := strSQL + '    G.EMB_PORTE_ = "0", ';
    strSQL := strSQL + '    "PEQUENO", ';
    strSQL := strSQL + '    IF( ';
    strSQL := strSQL + '      G.EMB_PORTE_ = "1", ';
    strSQL := strSQL + '      "MÉDIO", ';
    strSQL := strSQL + '      IF( ';
    strSQL := strSQL + '        G.EMB_PORTE_ = "2", ';
    strSQL := strSQL + '        "GRANDE", ';
    strSQL := strSQL + '        "NÃO INFORMADO" ';
    strSQL := strSQL + '      ) ';
    strSQL := strSQL + '    ) ';
    strSQL := strSQL + '  ) AS EMB_PORTE_, ';
    strSQL := strSQL + '  G.EMB_COMPRI, ';
    strSQL := strSQL + '  G.EMB_ARQBRU, ';
    strSQL := strSQL + '  G.EMB_OBSERV ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMB G ';
    strSQL := strSQL + '  INNER JOIN CLIEMB D ';
    strSQL := strSQL + '    ON G.AUTOINCREM = D.EMB_CODEMB ';
    strSQL := strSQL + 'WHERE D.EMB_CODCLI = :CODCLI ';
    strSQL := strSQL + 'ORDER BY G.EMB_NOMEMB ';

    qryTemp := fCriaQuery(Nil);

    Try
      qryTemp.Close();
      qryTemp.SQL.Clear();
      qryTemp.SQL.Text := strSQL;
      qryTemp.ParamByName('CODCLI').AsString := strCodCli;
      qryTemp.Open();
      qryTemp.First();

      cdsCadEmb.EmptyDataSet();
      TFloatField(cdsCadEmb.FieldByName('EMB_COMPRI')).DisplayFormat := '#,##0.00';

      While (Not qryTemp.Eof) Do Begin
        cdsCadEmb.Append();

        cdsCadEmb.FieldByName('CLIEMB_AUTINC').AsString  := qryTemp.FieldByName('AUTINC').AsString;

        cdsCadEmb.FieldByName('AUTOINCREM').AsString  := qryTemp.FieldByName('AUTOINCREM').AsString;
        cdsCadEmb.FieldByName('EMB_CODEMB').AsString  := qryTemp.FieldByName('EMB_CODEMB').AsString;
        cdsCadEmb.FieldByName('EMB_NOMEMB').AsString  := qryTemp.FieldByName('EMB_NOMEMB').AsString;
        cdsCadEmb.FieldByName('EMB_NUMIMO').AsString  := qryTemp.FieldByName('EMB_NUMIMO').AsString;
        cdsCadEmb.FieldByName('EMB_INSCRI').AsString  := qryTemp.FieldByName('EMB_INSCRI').AsString;
        cdsCadEmb.FieldByName('EMB_INDEMB').AsString  := qryTemp.FieldByName('EMB_INDEMB').AsString;
        cdsCadEmb.FieldByName('EMB_PORTOI').AsString  := qryTemp.FieldByName('EMB_PORTOI').AsString;
        cdsCadEmb.FieldByName('EMB_PORTE_').AsString  := qryTemp.FieldByName('EMB_PORTE_').AsString;
        cdsCadEmb.FieldByName('EMB_COMPRI').AsFloat   := qryTemp.FieldByName('EMB_COMPRI').AsFloat;
        cdsCadEmb.FieldByName('EMB_ARQBRU').AsInteger := qryTemp.FieldByName('EMB_ARQBRU').AsInteger;
        cdsCadEmb.FieldByName('EMB_OBSERV').AsString  := qryTemp.FieldByName('EMB_OBSERV').AsString;

        cdsCadEmb.Post();

        qryTemp.Next();
      End;

      dtsCadEmb.DataSet := cdsCadEmb;

      grdCadEmbDados.ApplyBestFit();
    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[TfrmCadClientes.pCarregarEmbarcacoes]');
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

procedure TfrmCadClientes.btnInfCobrClick(Sender: TObject);
  Var
    frmInfCobranca : TfrmInfCobranca;
begin
  inherited;
  If (Not qryTabela.IsEmpty) Then
  Begin
    Try
      pCriarFormularios(TfrmInfCobranca, frmInfCobranca);
      frmInfCobranca.edtCodCli.Text := qryTabela.FieldByName('CLI_CODCLI').AsString;
      frmInfCobranca.edtNomCli.Text := qryTabela.FieldByName('CLI_NOMCLI').AsString;
      frmInfCobranca.blnFiltraCli := True;
      frmInfCobranca.ShowModal;

    Finally
      pFreeAndNil(frmInfCobranca);
    End;
  End;
end;

class function TfrmCadClientes.fGeraLogLimiteStatusCliente(strCodCli: String;
                                                           dtaDtaAlt: Tdate;
                                                           dtaHrAlt: TTime;
                                                           strOperad: String;
                                                           strCampoAlt: String;
                                                           strInforAntC: String;
                                                           strInforNovC: String;
                                                           fltInforAntN: Double;
                                                           fltInforNovN: Double;
                                                           blnIniciaTransacao:Boolean=True;
                                                           blnEhRotinaAutomat:Boolean=False): Boolean;
  Var
    qryGravaLog: TUniQuery;
    strSQL: String;
begin
  If blnIniciaTransacao Then
    fStartTransaction;

  Result := True;

  qryGravaLog := fCriaQuery;
  Try
    Try
      strSQL := '';
      strSQL := strSQL + ' INSERT INTO LOGCLI ( ';
      strSQL := strSQL + '   AUTOINCREM, ';
      strSQL := strSQL + '   CLI_CODCLI, ';
      strSQL := strSQL + '   CLI_DTAALT, ';
      strSQL := strSQL + '   CLI_HRAALT, ';
      strSQL := strSQL + '   CLI_OPEALT, ';
      strSQL := strSQL + '   CLI_CPOALT, ';
      strSQL := strSQL + '   CLI_INFANC, ';
      strSQL := strSQL + '   CLI_INFNOC, ';
      strSQL := strSQL + '   CLI_INFANN, ';
      strSQL := strSQL + '   CLI_INFNON, ';
      strSQL := strSQL + '   CLI_AUTOMA, ';
      strSQL := strSQL + '   CLI_OPELOG )';
      strSQL := strSQL + ' VALUES ( ';
      strSQL := strSQL + '   :AUTOIN, ';
      strSQL := strSQL + '   :CODCLI, ';
      strSQL := strSQL + '   :DTAALT, ';
      strSQL := strSQL + '   :HRAALT, ';
      strSQL := strSQL + '   :OPEALT, ';
      strSQL := strSQL + '   :CPOALT, ';
      strSQL := strSQL + '   :INFANC, ';
      strSQL := strSQL + '   :INFNOC, ';
      strSQL := strSQL + '   :INFANN, ';
      strSQL := strSQL + '   :INFNON, ';
      strSQL := strSQL + '   :AUTOMA, ';
      strSQL := strSQL + '   :OPELOG) ';

      With qryGravaLog Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('AUTOIN').AsString := fRetAutoIncrem('LOGCLI', VS_strCodEmp);
        ParamByName('CODCLI').AsString := strCodCli;
        ParamByName('DTAALT').AsDate   := dtaDtaAlt;
        ParamByName('HRAALT').AsTime   := dtaHrAlt;
        ParamByName('OPEALT').AsString := strOperad;
        ParamByName('CPOALT').AsString := strCampoAlt;
        ParamByName('INFANC').AsString := strInforAntC;
        ParamByName('INFNOC').AsString := strInforNovC;
        ParamByName('INFANN').AsFloat  := fltInforAntN;
        ParamByName('INFNON').AsFloat  := fltInforNovN;
        ParamByName('AUTOMA').AsString := IfThen(blnEhRotinaAutomat,'S','N');
        ParamByName('OPELOG').AsString := strLoginUsuarioLogado;

        ExecSQL;
        Close;

      End;

      If blnIniciaTransacao Then
        fCommit;

    Except
      On E : Exception do
      Begin
        If blnIniciaTransacao Then
        Begin
          fRollBack;
          Result := False;
          pMensagensErro(E.Message, '[Erro ao Gravar o Log]');
        End
        Else
          Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(qryGravaLog);
  End;
end;

function TfrmCadClientes.fGetPagAtivas: Integer;
  Var
    intCnt : Integer;
begin
  Result := 0;
  For intCnt := 0 to pgcDados.PageCount - 1 Do
  Begin
    If pgcDados.Pages[intCnt].TabVisible Then
      Result := Result + 1;
  End;
end;

procedure TfrmCadClientes.btnLogAlterClick(Sender: TObject);
begin
  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(65, 5115, [],
                        ['CODCLI'],
                        [qryTabela.FieldByName('CLI_CODCLI').AsString],
                        Sender,
                        ['CODCLI'],
                        False);
  End;

end;

procedure TfrmCadClientes.btnImpExcelClick(Sender: TObject);
  Var
    objExcel   : TExcel;
    dlgOpen    : TOpenDialog;
    intConLin  : Integer;
begin
  inherited;
  try
    dlgOpen     := TOpenDialog.Create(Self);
    dlgOpen.Filter := 'Arquivos do Excel|*.xls;*.xlsx';

    If dlgOpen.Execute Then
    Begin

      objExcel := TExcel.fCriarExcel(Self);
      objExcel.AbrirArquivo(dlgOpen.FileName);

      For intConLin := 1 To objExcel.MaximodeLinhas Do
      Begin
        objCliPro.strCodPro := objExcel.Ler_Celula(fGetLetraAlfa(01) + IntToStr(intConLin));
        objCliPro.strCodPro := RightStr('00000000000000000000000' + Trim(objCliPro.strCodPro), fTamCodIte);;
        objCliPro.strNomPro := fCampoTabela('ITE_DESITE','CADITE',['ITE_CODITE'],[objCliPro.strCodPro]);
        objCliPro.strCodUni := fCampoTabela('ITE_CODUNI','CADITE',['ITE_CODITE'],[objCliPro.strCodPro], False);
        objCliPro.strUnidad := fCampoTabela('UNI_DESUNI','CADUNI',['UNI_CODUNI'],[objCliPro.strCodUni], False);

        objCliPro.strCod_NF := objExcel.Ler_Celula(fGetLetraAlfa(02) + IntToStr(intConLin));
        objCliPro.strDes_NF := objExcel.Ler_Celula(fGetLetraAlfa(03) + IntToStr(intConLin));
        objCliPro.strCodBar := objExcel.Ler_Celula(fGetLetraAlfa(04) + IntToStr(intConLin));

        pAdicionaProdutosCds(objCliPro);
      End;

    End;

  Finally
    FreeAndNil(objExcel);
    FreeAndNil(dlgOpen);
  End;

end;

procedure TfrmCadClientes.btnIncCndClick(Sender: TObject);
var
  qryCndPag  : TUniQuery;
  strSQL,
  strCondCnd : String;
  blnVazio   : Boolean;
begin

  inherited;

  If Not fValidaCampos(edtCodCnd, True) Then
    Exit;

  If Not fEmptyStr(edtCodCnd.Text) Then
  Begin

    If (edtCodCnd.Text <> '000') Then
      pIncluiCondicaoPagamento
    Else
    Begin

      strSQL := '';

      qryCndPag := fCriaQuery(Self);

      Try

        {Multiseleção}
        With qryCndPag Do
        Begin

          strSQL := strSQL + 'SELECT   ';
          strSQL := strSQL + '  C.CND_CODIGO, ';
          strSQL := strSQL + '  C.CND_DESCRI  ';
          strSQL := strSQL + 'FROM ';
          strSQL := strSQL + '  CADCND AS C ';
          strSQL := strSQL + 'WHERE 1=1     ';
          strSQL := strSQL + fStrLocate(edtCodCnd, arrCnd, 'C.CND_CODIGO', 'CODCND');
          strSQL := strSQL + 'ORDER BY       ';
          strSQL := strSQL + '  C.CND_CODIGO ';

          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          pSetaParam(edtCodCnd.Text, arrCnd, strCondCnd, 'CODCND', qryCndPag);
          Open;

          If Not IsEmpty Then
          Begin

            First;

            While Not Eof Do
            Begin

              blnVazio := cdsCliCnd.IsEmpty;

              If Not cdsCliCnd.Locate('CND_CODCND', FieldByName('CND_CODIGO').AsString, []) Then
              Begin
                cdsCliCnd.Insert;
                cdsCliCnd.FieldByName('CND_CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
                cdsCliCnd.FieldByName('CND_CODCND').AsString := FieldByName('CND_CODIGO').AsString;
                cdsCliCnd.FieldByName('CND_DESCRI').AsString := FieldByName('CND_DESCRI').AsString;
                cdsCliCnd.FieldByName('CND_SUGEST').AsString := IfThen(blnVazio, 'S', 'N');
                cdsCliCnd.Post;
              End;

              Next;

            End;

            edtCodCnd.Clear;
            edtDesCnd.Clear;

            pSetFocus(edtCodCnd);

          End;

        End;

      Finally
        FreeAndNil(qryCndPag);
      End;

    End;

  End
  Else
    fMensagem('ATENÇÃO', 'Favor escolher uma condição de pagamento antes de adicionar!', ['&Ok']);
end;

procedure TfrmCadClientes.btnIncDepClick(Sender: TObject);
var
  qryCliDep  : TUniQuery;
  strSQL,
  strCodDep : String;
begin
  inherited;
  If Not fEmptyStr(edtCodDep.Text) Then
  Begin
    If (edtCodDep.Text <> '000') Then
      pIncluiCliDepProd
    Else
    Begin
      strSQL := '';
      qryCliDep := fCriaQuery(Self);
      Try
        {Multiseleção}
        With qryCliDep Do
        Begin
          strSQL := strSQL + 'SELECT   ';
          strSQL := strSQL + '  D.DEP_CODIGO, ';
          strSQL := strSQL + '  D.DEP_DESCRI  ';
          strSQL := strSQL + 'FROM ';
          strSQL := strSQL + '  CADDEP AS D ';
          strSQL := strSQL + 'WHERE 1=1     ';
          strSQL := strSQL + fStrLocate(edtCodDep, arrCodDep, 'D.DEP_CODIGO', 'CODDEP');
          strSQL := strSQL + 'ORDER BY       ';
          strSQL := strSQL + '  D.DEP_CODIGO ';

          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          pSetaParam(edtCodDep.Text, arrCodDep, strCodDep, 'CODDEP', qryCliDep);
          Open;

          If Not IsEmpty Then
          Begin

            First;

            While Not Eof Do
            Begin
              If Not cdsCliDep.Locate('DEP_CODDEP', FieldByName('DEP_CODIGO').AsString, []) Then
              Begin
                cdsCliDep.Insert;
                cdsCliDep.FieldByName('DEP_CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
                cdsCliDep.FieldByName('DEP_CODDEP').AsString := FieldByName('DEP_CODIGO').AsString;
                cdsCliDep.FieldByName('DEP_DESCRI').AsString := FieldByName('DEP_DESCRI').AsString;

                cdsCliDep.Post;
              End;

              Next;

            End;
            edtCodDep.Clear;
            edtDesDep.Clear;
            pSetFocus(edtCodDep);
          End;
        End;

      Finally
        FreeAndNil(qryCliDep);
      End;

    End;

  End
  Else
    fMensagem('ATENÇÃO', 'Favor escolher um departamento antes de adicionar!', ['&Ok']);
end;

procedure TfrmCadClientes.btnIncDivClick(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtCodDiv.Text) Then
    pIncluiProfissional
  Else
    fMensagem('ATENÇÃO', 'Favor escolher um profissional antes de adicionar!', ['&Ok']);
end;

procedure TfrmCadClientes.btnObsCliClick(Sender: TObject);
  Var
    qryQuery: TUniQuery;
begin
  inherited;
  If (btnObsCli.Visible) And (btnObsCli.Enabled) Then
  Begin
    If Not fVerificaAcessoSistema('ACEF2_') Then
    Begin
      fMensagem('', 'Operador não tem direito para "F2 - Observação"!', ['&Ok']);
      Exit;
    End;

    Try
      qryQuery := fCriaQuery(Self);
      With qryQuery Do
      Begin
        SQL.Clear;
        SQL.Add(' SELECT ');
        SQL.Add('   CLI_OBSERV ');
        SQL.Add(' FROM CADCLI ');
        SQL.Add(' WHERE CLI_CODCLI = :CODCLI ');
        ParamByName('CODCLI').AsString := dbeCodCli.Text;
        Open;

        Try
          pCriarFormularios(TfrmFatMostraObsCliente, frmFatMostraObsCliente);
          frmFatMostraObsCliente.memObserv.Texto := FieldByName('CLI_OBSERV').AsString;
          frmFatMostraObsCliente.strCodCli       := dbeCodCli.Text;
          frmFatMostraObsCliente.ShowModal;
        Except
          On E: Exception Do
            pMensagensErro(E.Message, '');
        End;
        pFreeAndNil(frmFatMostraObsCliente);
        
      End;
    Finally
      FreeAndNil(qryQuery);
    End;
  End;
end;

procedure TfrmCadClientes.btnObsClientesClick(Sender: TObject);
begin
  inherited;

  TfrmObservacao.fObservacao('Observação Clientes', AnsiReplaceStr(dbeObserv.Field.AsString, STRING_QUEBRA, STRING_ENTER), 0, tpimNormal, 0, False,
    'Observações - Cliente (' +
    dbeCodCli.Field.DisplayText +
    ' - ' +
    dbeNomCli.Field.DisplayText);

end;

function TfrmCadClientes.dbeCodDivChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadDiv(Key);
  pAtribuiTabelas;
end;

function TfrmCadClientes.fEmpresaJaDesmembr(strCodEmp: String): Boolean;
  Var
    qryAux: TUniQuery;
    strSQL: String;
begin
  qryAux := fCriaQuery(Nil);
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT                      ';
    strSQL := strSQL + '   COUNT(*) AS CONT          ';
    strSQL := strSQL + ' FROM                        ';
    strSQL := strSQL + '   CCCLIE                    ';
    strSQL := strSQL + ' WHERE                       ';
    strSQL := strSQL + '   CCC_CODEMP = :CODEMP  AND ';
    strSQL := strSQL + '   CCC_CODCLI = :CODCLI      ';

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := dbeCodCli.Text;
      Open;
    End;

    Result := qryAux.FieldByName('CONT').AsInteger > 0;
  Finally
    qryAux.Free;
  End;
end;

function TfrmCadClientes.fExisteConContabil: String;
  Var
    qryGenCli: TUniQuery;
begin
  Try

    If fEmptyStr(dbeConCon.Text) Then
    Begin
      Result := EmptyStr;
      Exit;
    End;

    qryGenCli := fCriaQuery;

    With qryGenCli Do
    Begin
      SQL.Add('SELECT');
      SQL.Add('  CONCAT(CLI_CODCLI, "-", CLI_NOMCLI) CLIENTE');
      SQL.Add('FROM');
      SQL.Add('  CADCLI');
      SQL.Add('WHERE');
      SQL.Add('  CLI_CONCON  = :CONCON AND');
      SQL.Add('  CLI_CODCLI <> :CODCLI    ');
      ParamByName('CONCON').Value := dbeConCon.Text;
      ParamByName('CODCLI').Value := dbeCodCli.Text;
      Open;

      Result := FieldByName('CLIENTE').AsString;

    End;

  Finally
    FreeAndNil(qryGenCli);
  End;

end;

function TfrmCadClientes.fFieldAlterado(Field: TField): Boolean;
begin
  Result := False;

  If (Not Assigned(Field)) Then
    Exit;

  Try
    If (Field.DataType <> ftMemo) And
       (Field.OldValue <> Field.NewValue) And
       (Field.FieldName <> 'CLI_DTAALT') And
       (Field.FieldName <> 'CLI_CODOPE') Then Begin

      If (Field.DataType = ftString) And
         (
           (
             (Field.OldValue = '') And
             (Field.NewValue = Null)
           )
             Or
           (
             (Field.OldValue = Null) And
             (Field.NewValue = '')
           )
         ) Then
        Result := False
      Else Begin
        Result := True;
        Exit;
      End;

    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TfrmCadClientes.fFieldAlterado]');
  End;
end;

function TfrmCadClientes.fFieldsIntegracaoConteleFoiAlterado: Boolean;
const
  arrFields: TArray<String> = ['CLI_CODCLI',
                               'CLI_NOMCLI',
                               'CLI_C_G_C_',
                               'CLI_ENDERE',
                               'CLI_ENDNUM',
                               'CLI_C_E_P_',
                               'CLI_BAIRRO',
                               'CLI_CODCID',
                               'CLI_FONE01',
                               'CLI_FONE02',
                               'CLI_EMAIL_',
                               'CLI_CONTAT',
                               'CLI_CODCAC',
                               'CLI_CODVEN'];
var
  intContador: Integer;
begin
  Result := False;

  if not fCfgSis('APICON', varBoolean) then
    Exit;

  for intContador:=0 to Length(arrFields)-1 do
  begin
    if (fCfgSis('MLTOPE', varBoolean)) and (arrFields[intContador] = 'CLI_CODVEN') then
      Continue;

    if fValorFieldAlterado(qryTabela.FieldByName(arrFields[intContador])) then
    begin
      Result := True;
      Break;
    end;
  end;
end;

procedure TfrmCadClientes.dbeCgcCpfExit(Sender: TObject);
  Var
    blnTemAcesso: Boolean;
begin
  inherited;
  If (dbeCgcCpf.Text = '1') Then
  Begin
    qryTabela.FieldByName('CLI_C_G_C_').EditMask := fRetMascaraC_G_C_(FPais, C_G_C_);

    If fCfgSis('CPFSDV', VarBoolean) Then
    Begin
      chkCpfDev.Visible := False;
      dbeCpfDev.Visible := False;
      dbeNuCpnj.Visible := True;

      If qryTabela.State in [dsEdit, dsInsert] Then
        dbeCpfDev.Field.Clear;
    End;

    edtRgExp.Clear;
    cbxRgEst.ItemIndex := -1;

    If qryTabela.State in [dsEdit, dsInsert] Then
      dbeNumRg.Field.Clear;
  End
  Else
  Begin
    qryTabela.FieldByName('CLI_C_G_C_').EditMask := fRetMascaraC_G_C_(FPais, C_P_F_);

    If fCfgSis('CPFSDV', VarBoolean) Then
    Begin
      chkCpfDev.Visible := True;

      chkCpfDev.Checked := Not fEmptyStr(qryTabela.FieldByName('CLI_CPFDEV').AsString);
      dbeCpfDev.Visible := Not fEmptyStr(qryTabela.FieldByName('CLI_CPFDEV').AsString);
      dbeNuCpnj.Visible :=     fEmptyStr(qryTabela.FieldByName('CLI_CPFDEV').AsString);

      If qryTabela.State in [dsEdit, dsInsert] Then
      Begin
        If dbeCpfDev.Visible Then
          dbeNuCpnj.Field.Clear
        Else
          dbeCpfDev.Field.Clear;

        dbeOSNFEn.Field.Text := 'N';
      End;
    End;

  End;

  edtRgExp.Enabled  := Not ((qryTabela.State = dsBrowse) Or (dbeCgcCpf.Text = '1'));
  cbxRgEst.Enabled  := Not ((qryTabela.State = dsBrowse) Or (dbeCgcCpf.Text = '1'));
  dbeNumRg.Enabled  := Not ((qryTabela.State = dsBrowse) Or (dbeCgcCpf.Text = '1'));
  dbeNire.Enabled   := (not(qryTabela.State = dsBrowse)) and (dbeCgcCpf.Text = '1');

  blnTemAcesso := fVerificaAcessoSistema('ALTCGC', strLoginUsuarioLogado);

  dbeCgcCpf.Enabled := ((blnTemAcesso And (qryTabela.State = dsEdit)) Or (qryTabela.State = dsInsert)) And (Not fPreencheuIDEstrangeiro);
  chkCpfDev.Enabled := (blnTemAcesso And (qryTabela.State = dsEdit)) Or (qryTabela.State = dsInsert);
  dbeCpfDev.Enabled := (blnTemAcesso And (qryTabela.State = dsEdit)) Or (qryTabela.State = dsInsert);
  dbeNuCpnj.Enabled := ((blnTemAcesso And (qryTabela.State = dsEdit)) Or (qryTabela.State = dsInsert)) And (Not fPreencheuIDEstrangeiro);
  btnConsultaFit.Enabled := (dbeCgcCpf.Enabled) And ((qryTabela.State = dsEdit) Or (qryTabela.State = dsInsert));
  dbeOSNFEn.Enabled := dbeOSNFEn.Visible And (dbeCgcCpf.Text = '1');
end;

procedure TfrmCadClientes.dbeCgCpS1Exit(Sender: TObject);
begin
  inherited;
  pQueryCadFicAfterScroll(qryCadFic);
end;

procedure TfrmCadClientes.dbeCodEmpRCFExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(dbeCodEmpRCF.Text) Then
  Begin
    edtDesEmpRCF.Clear;
//    pSetFocus(dbeOrgPub);
  End Else
  Begin
    edtDesEmpRCF.Text := fRetNomeEmpresaSelec(dbeCodEmpRCF.Text);

    If fEmptyStr(edtDesEmpRCF.Text)  Then
    Begin
      fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
      dbeCodEmpRCF.Clear;
      pSetFocus(dbeCodEmpRCF);
    End
//    Else
//      pSetFocus(dbeOrgPub);
  End;
end;

procedure TfrmCadClientes.pAjustaAbaContatos;
var
  blnHabilitar: Boolean;
begin
  blnHabilitar := (Not VS_strHabilitarCRM);

  If fCfgSis('LOCEQU', varBoolean) And fCfgSis('RESLOC', varBoolean) Then
  Begin
    LabelCgcCpf1.Visible := True;
    mskCpfCtt.Visible := True;
    lblRG.Visible := True;
    edtRg_Ctt.Visible := True;
    edtCgoCtt.Visible := True;
    edtDesCgoCtt.Visible := True;
  End
  Else
  Begin
    edtCgoCtt.Visible    := blnHabilitar;
    edtDesCgoCtt.Visible := blnHabilitar;
  End;

  edtDptCtt.Visible    := blnHabilitar;
  edtDesDptCtt.Visible := blnHabilitar;
  edtTfuCtt.Visible    := blnHabilitar;
  edtDesTfuCtt.Visible := blnHabilitar;
  edtHobCtt.Visible    := blnHabilitar;
  edtDesHobCtt.Visible := blnHabilitar;
  edtEscCtt.Visible    := blnHabilitar;
  edtDesEscCtt.Visible := blnHabilitar;
  edtGmuCtt.Visible    := blnHabilitar;
  edtDesGmuCtt.Visible := blnHabilitar;
  edtEciCtt.Visible    := blnHabilitar;
  edtDesEciCtt.Visible := blnHabilitar;
  mmCerCtt.Visible     := blnHabilitar;
  edtTemEmp.Visible    := blnHabilitar;
  lblTempEmp.Visible   := blnHabilitar;
  edtTemSeg.Visible    := blnHabilitar;
  edtQtdFil.Visible    := blnHabilitar;
  If Not blnHabilitar Then
    pnlContatos.Height   := 140 + IIF(edtCgoCtt.Visible, edtCgoCtt.Height + 3, 0);
  fFindColumnByName(dbgContatos, 'CLI_NOMCGO').Visible := blnHabilitar;  //Desc. Cargo
  fFindColumnByName(dbgContatos, 'CLI_NOMDPT').Visible := blnHabilitar;  //Desc. Departamento
  fFindColumnByName(dbgContatos, 'CLI_NOMTFU').Visible := blnHabilitar;
  fFindColumnByName(dbgContatos, 'CLI_NOMHOB').Visible := blnHabilitar;  //Desc. Hobby
  fFindColumnByName(dbgContatos, 'CLI_NOMESC').Visible := blnHabilitar;  //Desc. Escolaridade
  fFindColumnByName(dbgContatos, 'CLI_NOMGMU').Visible := blnHabilitar;  //Desc. Gosto Musical
  fFindColumnByName(dbgContatos, 'CLI_NOMECI').Visible := blnHabilitar;  //Desc. Estado Civil
  fFindColumnByName(dbgContatos, 'CLI_TEMEMP').Visible := blnHabilitar;  //Tempo de Empresa
  fFindColumnByName(dbgContatos, 'CLI_TEMSEG').Visible := blnHabilitar;  //Tempo de Segmento
  fFindColumnByName(dbgContatos, 'CLI_QTDFIL').Visible := blnHabilitar;  //Quant. de Filhos
end;

procedure TfrmCadClientes.pAjustaBotoesAbaContatos;
var
  blnHabilitar: Boolean;
begin
  blnHabilitar := VS_strHabilitarCRM;
  If Not blnHabilitar Then
  Begin
    btnAdicionarCtt.Top := edtQtdFil.Top + edtQtdFil.Height;
    btnCancelaCtt.Top   := btnAdicionarCtt.Top + btnAdicionarCtt.Height;
  End;
  Label180.Visible    := blnHabilitar;
  edtDepCtt.Visible   := blnHabilitar;
  fFindColumnByName(dbgContatos, 'CLI_DEPCTT').Visible := blnHabilitar;  //Departamento
end;


procedure TfrmCadClientes.ApplicationEventsDeactivate(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
end;

procedure TfrmCadClientes.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  inherited;
  If (dbeNumCep.Focused) Then
  Begin
    Case Msg.Message Of
      WM_KEYDOWN:
      Begin
        If (Msg.wParam = VK_TAB) Then
          Msg.wParam :=  VK_RETURN
      End;
    End;
  End;
end;

procedure TfrmCadClientes.btnLimCreClick(Sender: TObject);
begin
  inherited;
  If (fProsseguirComAtualizacaoDeLimiteDeCredito) Then
    pAtualizaLimiteDeCreditoAuto;
end;

procedure TfrmCadClientes.btnLimiteAlpeClick(Sender: TObject);
var
  fltLimiteTotal,
  fltLimiteUtilizado,
  fltLimiteDisponivel,
  fltTotalDebito: Double;

  blnStopSupply: Boolean;

  strMsg: String;
begin
  fltLimiteTotal := 0.0;
  fltLimiteUtilizado := 0.0;
  fltLimiteDisponivel := 0.0;
  fltTotalDebito := 0.0;

  if fEmptyStr(dbeNuCpnj.Text) then
    Exit;

  if not TControllerPaymentProductsArrangements.fConsultaAlpeLimiteBoleto(dbeNuCpnj.Text,
                                                                          fltLimiteTotal,
                                                                          fltLimiteUtilizado,
                                                                          fltLimiteDisponivel,
                                                                          blnStopSupply,
                                                                          strMsg) then
  begin
    if blnStopSupply then
      fMensagem('', 'StopSupply: '+strMsg, ['&Ok']);

    Exit;
  end;

  if fCfgSis('PDALLM', varBoolean) and (not fEmptyStr(dbeCodCli.Text)) then
    fltTotalDebito := fRetTotalPedidoVendaAberto(dbeCodCli.Text, '', True);

  fltLimiteUtilizado := fltLimiteUtilizado + fltTotalDebito;
  fltLimiteDisponivel := fltLimiteDisponivel - fltTotalDebito;

  fMensagem('', 'Limites Alpe:'+#13#10+#13#10+
                  'Limite Total: '+Format('%m', [fltLimiteTotal])+#13#10+
                  'Limite Utilizado: '+Format('%m', [fltLimiteUtilizado])+#13#10+
                  'Limite Disponível: '+Format('%m', [fltLimiteDisponivel]), ['&Ok']);
end;

procedure TfrmCadClientes.btnCanQuaCliClick(Sender: TObject);
begin
  inherited;

  blnAltQuaCli := False;
  SetLength(arrQualificacao, 0);
  edtCodQua.Clear;
  edtDesQua.Clear;
  memoObservacao.Text := '';
  chkCertificado.Checked := False;
  cxGridQuaCli.Enabled := True;
  pSetFocus(edtCodQua);
end;

procedure TfrmCadClientes.btnHerancaCliProClick(Sender: TObject);
begin
  inherited;
  pCriarFormularios(TfrmHerancaCliente, frmHerancaCliente);
  frmHerancaCliente.ShowModal;

  If frmHerancaCliente.blnConfirma Then
  Begin
    if not frmHerancaCliente.qryGenCli.IsEmpty then
    begin
      {Relacionamento Cliente-Produto}
      if fCfgSis('CLIPRO') = 'S' then
      Begin
        objCliPro.fRetProdutos(frmHerancaCliente.strCodCliente, cdsCliPro, dspCliPro, nil);
        blnCliProHer := True;
      End;
    end;
  End;
end;

procedure TfrmCadClientes.btnCalcCompraMensalClick(Sender: TObject);
  Var
    Result : TMediaCompraResult;
begin
  inherited;
  Result := fMediaDeCompra(qryTabela.FieldByName('CLI_CODCLI').AsString);

  edtVal3Me.Text := FormatFloat('#,##0.00', Result[0][0]);
  edtMar3Me.Text := FormatFloat('#,##0.00', Result[0][1]);

  edtVal6Me.Text := FormatFloat('#,##0.00', Result[1][0]);
  edtMar6Me.Text := FormatFloat('#,##0.00', Result[1][1]);

  edtVal12M.Text := FormatFloat('#,##0.00', Result[2][0]);
  edtMar12M.Text := FormatFloat('#,##0.00', Result[2][1]);

end;

procedure TfrmCadClientes.btnAbfClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaAcessoSistema('frmCadAbrevFiscal') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso para "Cadastro de Abreviação de ICMS"!', ['&Ok']);
    Exit;
  End;

  pCriarForm(TfrmCadAbreviacaoFiscal);
end;

procedure TfrmCadClientes.btnAltParClick(Sender: TObject);
var
 frmCadAltPar : TfrmCadAltPar;
begin
  inherited;
  If (qryTabela.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário escolher um Cliente!', ['&Ok']);
    Exit;
  End;
  
  Try
    pCriarFormularios(TfrmCadAltPar, frmCadAltPar);
    frmCadAltPar.strTipoPart := 'C';
    frmCadAltPar.strCodPart  := qryTabela.FieldByName('CLI_CODCLI').AsString;
    frmCadAltPar.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  pFreeAndNil(frmCadAltPar);
end;

procedure TfrmCadClientes.btnArquivosAceiteLGPDClick(Sender: TObject);
begin
  inherited;

  if dbeCodCli.Field.DisplayText = '' Then
    Exit;

  TfrmArquivosBanco.pShowArquivos(
    TArquivosBancoAceiteLDPG.New
      .fValorFK(qryTabela.FieldByName('CLI_CODCLI').AsString));

  dbeLeiLGPChange(dbeLeiLGP);
end;

procedure TfrmCadClientes.btnAbrirPastaClienteClick(Sender: TObject);
Var
  SPath: String;
begin
  inherited;

  if dbeCodCli.Field.DisplayText = '' Then
    Exit;

  SPath := fCfgSis('CLIPAT');
  if fEmptyStr(SPath) then
    SPath := ExtractFilePath(Application.ExeName)+ 'ANEXOS\';

  frmGravaArquivoPasta                 := TfrmGravaArquivoPasta.Create(Self);
  frmGravaArquivoPasta.strCaminhoPasta := SPath + IIF(RightStr(SPath, 1) <> '\', '\', '') +
                                          dbeCodCli.Field.DisplayText;
  frmGravaArquivoPasta.Caption         := 'Pasta ( Anexos do Cliente )';
  frmGravaArquivoPasta.blnConsulta     := not (qryTabela.State in DsEditModes);
  frmGravaArquivoPasta.ShowModal;

end;

procedure TfrmCadClientes.btnAbrirPastaCreditoClick(Sender: TObject);
  Var
    LfrmGravaArquivoPasta: TfrmGravaArquivoPasta;
begin
  inherited;

  if dbeCodCli.Field.DisplayText = '' Then
    Exit;

  If Not (qryTabela.State In [dsEdit, dsInsert]) Then
    Exit;

  Try
    Try
      pCriarFormularios(TfrmGravaArquivoPasta, LfrmGravaArquivoPasta);
      LfrmGravaArquivoPasta.strCaminhoPasta := fPastaConsultaCreditos(dbeCodCli.Field.DisplayText);
      LfrmGravaArquivoPasta.Caption         := 'Pasta ( Consulta de Créditos )';
      LfrmGravaArquivoPasta.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  Finally
    pFreeAndNil(LfrmGravaArquivoPasta);
  End;

end;

procedure TfrmCadClientes.btnAddCrmForClick(Sender: TObject);
begin
  inherited;
  If (Not fValidaCampos(edtCrmFor, True)) Or (fEmptyStr(edtCrmFor.Text)) Then
    Exit;

  Try
    If cdsCliFor.Locate('CLF_CRMFOR', edtCrmFor.Text, []) Then
    Begin
      fMensagem('', 'Este Fornecedor já foi Incluído!', ['&Ok']);
      edtCrmFor.Clear;
      edtDesFor.Clear;
      Exit;
    End;

    cdsCliFor.Append;
    cdsCliFor.FieldByName('CLF_CRMFOR').AsString := edtCrmFor.Text;
    cdsCliFor.FieldByName('CRF_NOMFOR').AsString := edtDesFor.Text;
    cdsCliFor.Post;

    edtCrmFor.Clear;
    edtDesFor.Clear;
  Finally
    pSetFocus(edtCrmFor);
  End;
end;

procedure TfrmCadClientes.btnAddVeiClick(Sender: TObject);
begin
  inherited;
  Try
    If Not fEmptyStr(mskPlaVei.Text) Then
    Begin
      objCliVei.strPlaVei := mskPlaVei.Text;
      objCliVei.strVeiAti := edtVeiAti.Text;
    End
    Else
    Begin
      fMensagem('ATENÇÃO', 'Favor escolher uma placa antes de adicionar!', ['&Ok']);
      Exit;
    End;
  Except
    On E: ExceptionAutCom Do
    Begin
			pMensagemOk(E.Message);
      pSetFocus(mskPlaVei);
      Exit;
    End;

    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'');
      pSetFocus(mskPlaVei);
      Exit;
    End;
  End;

  If (fValidaPanel(pnlCliVei, True)) Then
  Begin
    pAdicionaVeiculosCds(objCliVei);
    btnCanVei.Click;
    blnAltVeiculo := False;
  End;
end;

procedure TfrmCadClientes.btnAdicionaBatClick(Sender: TObject);
begin
  inherited;
  if not edtCodBai.Enabled Then Exit;

  If fEmptyStr(edtCodBai.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'Favor escolher um bairro antes de adicionar!', ['&Ok']);
    Exit;
  End;

  if not fValidaCampos(edtCodBai, False) Then Exit;

  If Not cdsCliBat.Locate('BAT_CODBAI', edtCodBai.Text, []) Then
  Begin
    cdsCliBat.Insert;

    cdsCliBat.FieldByName( 'AUTOINCREM' ).AsString := '';
    cdsCliBat.FieldByName( 'BAT_CODCLI' ).AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
    cdsCliBat.FieldByName( 'BAT_CODBAI' ).AsString := edtCodBai.Text;
    cdsCliBat.FieldByName( 'BAI_DESCRI' ).AsString := edtDescri.Text;
    cdsCliBat.FieldByName( 'BAI_CODCID' ).AsString := edtCodCidBat.Text;
    cdsCliBat.FieldByName( 'CID_NOMCID' ).AsString := edtNomCidBat.Text;
    cdsCliBat.FieldByName( 'CID_ESTADO' ).AsString := edtEstadoBat.Text;

    cdsCliBat.Post;
  End;

  edtDescri.Clear;
  edtCodCidBat.Clear;
  edtNomCidBat.Clear;
  edtEstadoBat.Clear;
  edtCodBai.Clear;

  pSetFocus(edtCodBai);
end;

procedure TfrmCadClientes.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  if fEmptyStr(edtDesEmpPrioridade.Text) then
  begin
    fMensagem('','Informe a empresa!', ['&Ok']);
    pSetFocus(edtCodEmpPrioridade);
    Exit;
  end;

  if cdsEmpresaPrioridade.Locate('CODCLI;CODEMP', VarArrayOf([dbeCodCli.Text, edtCodEmpPrioridade.Text]), []) then
  begin
    fMensagem('','Empresa já adicionada!', ['&Ok']);
    edtCodEmpPrioridade.Clear;
    edtDesEmpPrioridade.Clear;
    pSetFocus(edtCodEmpPrioridade);
    Exit;
  end;

  cdsEmpresaPrioridade.Append;
  cdsEmpresaPrioridadeAUTINC.AsString := fRetAutoIncrem('CADEPS', VS_strCodEmp);
  cdsEmpresaPrioridadeCODCLI.AsString := dbeCodCli.Text;
  cdsEmpresaPrioridadeCODEMP.AsString := edtCodEmpPrioridade.Text;
  cdsEmpresaPrioridadeNOMEMP.AsString := edtDesEmpPrioridade.Text;
  cdsEmpresaPrioridade.Post;

  edtCodEmpPrioridade.Clear;
  edtDesEmpPrioridade.Clear;

  pSetFocus(edtCodEmpPrioridade);
end;

procedure TfrmCadClientes.btnAdicionarCttClick(Sender: TObject);
begin
  inherited;
  {*******************************************}
  {* COLOQUEI AQUI PARA VALIDAR O NOME.      *}
  {* SE OLHAR NO VALIDA, VAI ENTENDER PORQUE *}
  {****************************************JB*}
  Try
    objCliCtt.strNomCtt := edtNomCtt.Text;
  Except
    On E: ExceptionAutcom Do
    Begin
      pMensagemOk(E.Message);
      pSetFocus(edtNomCtt);
      Exit;
    End;

    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmCadClientes.btnAdicionarCttClick]');
      pSetFocus(edtNomCtt);
      Exit;
    End;
  End;

  If fValidaPanel(pnlAutCtt, True) And fValidaPanel(pnlContatos, True) Then
  Begin
    pAdicionaContatoCds(objCliCtt);
    btnCancelaCtt.Click;
    blnAltContato := False;
  End;

end;

procedure TfrmCadClientes.btnAdicionarRcoClick(Sender: TObject);
begin
  inherited;
  {*******************************************}
  {* COLOQUEI AQUI PARA VALIDAR O NOME.      *}
  {* SE OLHAR NO VALIDA, VAI ENTENDER PORQUE *}
  {****************************************AC*}
  Try
    objCliRco.strNomEmp := edtEmpRco.Text;
  Except
    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmCadClientes.btnAdicionarRcoClick]');
      pSetFocus(edtEmpRco);
      Exit;
    End;
  End;

  If fEmptyStr(edtEmpRco.Text) Then
  Begin
    pMensagemOk('A Empresa deve ser preenchida!');
    pSetFocus(edtEmpRco);
    Exit;
  End;

  If (fValidaPanel(pnlRefComerciais, True)) Then
  Begin
    pAdicionaRefComerciaisCds(objCliRco);
    btnCancelaRco.Click;
    blnAltRefComer := False;
  End;
end;

procedure TfrmCadClientes.btnCancelaCttClick(Sender: TObject);
begin
  inherited;
  pLimpaEditsContatos;

  If pnlAutCtt.Visible Then
    pSetFocus(chkAutCtt)
  Else
    pSetFocus(edtNomCtt);

  blnAltContato := False;
end;

procedure TfrmCadClientes.btnCancelaProdClick(Sender: TObject);
begin
  inherited;
  pLimpaEditsProdutos;
  pSetFocus(edtCodIte);
  blnAltProduto := False;
end;

procedure TfrmCadClientes.btnCancelarCCClick(Sender: TObject);
begin
  strStatusContaContabil := 'CANCELANDO';

  pLimpaCamposEmpCli;

  pControlaBotoes;
end;

procedure TfrmCadClientes.btnCancelaRcoClick(Sender: TObject);
begin
  inherited;
  pLimpaEditsRefComerciais;
  pSetFocus(edtEmpRco);
  blnAltRefComer := False;
end;

procedure TfrmCadClientes.btnCancelBatClick(Sender: TObject);
begin
  inherited;
  edtDescri.Clear;
  edtCodCidBat.Clear;
  edtNomCidBat.Clear;
  edtEstadoBat.Clear;
  edtCodBai.Clear;

  pSetFocus(edtCodBai);

end;

procedure TfrmCadClientes.btnCanVeiClick(Sender: TObject);
begin
  inherited;

  pLimpaEditsVeiculos;
  pSetFocus(mskPlaVei);
  blnAltVeiculo := False;
end;

procedure TfrmCadClientes.pInformarClienteOutroVendedor;
var
  frmFatDigCnpj: TfrmFatDigCnpj;
  strCodVen: String;
  blnTrava: Boolean;
  strCodCliTmp: String;
  blnLiberado: Boolean;
  objLiberacao: TLiberacao;
begin
  inherited;

  objLiberacao := TLiberacao.Create;
  pCriarFormularios(TfrmFatDigCnpj, frmFatDigCnpj);
  blnLiberado := False;
  Try

    repeat
      blnBloquCpfCnpj := btnCliOutroVendedor.Visible;

      frmFatDigCnpj.blnProspecto := False;
      frmFatDigCnpj.blnPermiteBranco := True;
      frmFatDigCnpj.blnFocarNumCpf := True;
      frmFatDigCnpj.blnListarClientes := True;
      frmFatDigCnpj.ShowModal;
      If (frmFatDigCnpj.ModalResult = MrOk) Then
      Begin
        strCodCliTmp := frmFatDigCnpj.strCodCli;

        If (fEmptyStr(frmFatDigCnpj.edtCgcCpf.Text)) Then
        Begin
          fMensagem('', 'O cnpj/cpf do cliente precisa ser informado!', ['&Ok']);
          Exit;
        End;

        blnTrava := fTravaCampoOutroVendedor(strCodCliTmp, strCodVen);

        If blnTrava Then
        Begin
          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto('Permitir visualizar o cadastro de cliente de outro vendedor');
          objLiberacao.objMsgLibera.pAddTextoCaption('Cliente', strCodCliTmp + ' - ' + fRetNomCliente(strCodCliTmp));
          objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor cadastrado', strCodVen + '  - ' + fRetNomVendRep(strCodVen));
          objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor atual'     , strLoginUsuarioLogado + '  - ' + fRetNomVendRep(strLoginUsuarioLogado));

          objLiberacao.strDirAce := 'CNSCCA';
          objLiberacao.strMsgSen := 'Cadastro de cliente - Permitir visualizar cliente de outro vendedor';
          objLiberacao.strCodOpe := strLoginUsuarioLogado;
          objLiberacao.strCodDig := strLoginUsuarioLogado;

          blnLiberado := objLiberacao.fLibera;
        End
        Else
        Begin
          blnLiberado := True;
        End;
      End;

    Until blnLiberado or (frmFatDigCnpj.ModalResult <> MrOk);

    If blnLiberado And (frmFatDigCnpj.ModalResult = MrOk) Then
    Begin
      blnBloquCpfCnpj := False;
      pPesquisaClienteCRM(strCodCliTmp);
      pCarregarCliente;
    End;

  Finally
    pFreeAndNil(frmFatDigCnpj);
    FreeAndNil(objLiberacao);
  End;
end;

procedure TfrmCadClientes.btnCliOutroVendedorClick(Sender: TObject);
begin
  inherited;

  pInformarClienteOutroVendedor;
end;

procedure TfrmCadClientes.btnCliVenClick(Sender: TObject);
begin
  inherited;
  AbrirCadastroVendedoresDoCliente;
end;

procedure TfrmCadClientes.pCarregaContatos(strCodCli: String; blnAutoIncNULL : Boolean = False);
  Var
    intContador: Integer;
begin

  pLimpaEditsContatos;

  If Assigned(lstContatos) Then
    FreeAndNil(lstContatos);

  lstContatos := TCliCtt.fRetContatos(strCodCli, blnAutoIncNULL);
  cdsCliCtt.EmptyDataSet;

  For intContador := 0 To lstContatos.Count -1 Do
  Begin
    objCliCtt := TCliCtt(lstContatos[intContador]);
    pAdicionaContatoCds(objCliCtt);
  End;

end;

procedure TfrmCadClientes.pAddTabelasLog;
begin

  {Logs}
  if (not qryTabela.FieldByName('CLI_CODCLI').IsNull) and (qryTabela.FieldByName('CLI_CODCLI').AsString <> '') then
  begin

    {Cliente}
    LogAltCadCli.pLogAdd('CADCLI', ['AUTOINCREM'], 'CLI_CODCLI = ' + QuotedStr(qryTabela.FieldByName('CLI_CODCLI').AsString), pSetaDisplayLabelCadCli);

    {Contato}
    if tbsContato.TabVisible then
      LogAltCadCli.pLogAdd('CLICTT', ['AUTOINCREM'], 'CLI_CODCLI = ' + QuotedStr(qryTabela.FieldByName('CLI_CODCLI').AsString), pSetaDisplayLabelCadCli_Contatos);

    {End. Entrega}
    if tbsEntregas.TabVisible then
      LogAltCadCli.pLogAdd('ENTCLI', ['AUTOINCREM'], 'ETC_CODCLI = ' + QuotedStr(qryTabela.FieldByName('CLI_CODCLI').AsString), pSetaDisplayLabelCadCli_EndEntrega);

    {Quadro Societário}
    if tbsQuadSoc.TabVisible then
      LogAltCadCli.pLogAdd('CADFIC', ['FIC_CODCLI'], 'FIC_CODCLI = ' + QuotedStr(qryTabela.FieldByName('CLI_CODCLI').AsString), pSetaDisplayLabelCadCli_QuadSoc);

    {Quadro Societário II *** Foi normalizado o cadastro de sócios ***}
    if tbsQuadSoc.TabVisible then
      LogAltCadCli.pLogAdd('CLISCO', ['AUTOINCREM'], 'SCO_CODCLI = ' + QuotedStr(qryTabela.FieldByName('CLI_CODCLI').AsString), pSetaDisplayLabelCadCli_QuadSocII);

    {Ref. Comerciais}
    if tbsRefCom.TabVisible then
      LogAltCadCli.pLogAdd('CLIRCO', ['AUTOINCREM'], 'CLI_CODCLI = ' + QuotedStr(qryTabela.FieldByName('CLI_CODCLI').AsString), pSetaDisplayLabelCadCli_RefComerciais);

    {Inf. Crediário}
    if tbsCrediario.TabVisible then
      LogAltCadCli.pLogAdd('CLI_INFCRE', ['CLI_CODCLI'], 'CLI_CODCLI = ' + QuotedStr(qryTabela.FieldByName('CLI_CODCLI').AsString), pSetaDisplayLabelCadCli_InfCrediario);

    {Relacionamento Cliente Produto}
    if tbsClienteProduto.TabVisible then
      LogAltCadCli.pLogAdd('CLIPRO', ['AUTOINCREM'], 'CLI_CODCLI = ' + QuotedStr(qryTabela.FieldByName('CLI_CODCLI').AsString), pSetaDisplayLabelCadCli_RelClienteProduto);

    {Veículos}
    if tbsCliVei.TabVisible then
      LogAltCadCli.pLogAdd('CLIVEI', ['AUTOINCREM'], 'CLI_CODCLI = ' + QuotedStr(qryTabela.FieldByName('CLI_CODCLI').AsString), pSetaDisplayLabelCadCli_Veiculos);

    {Condição de Pagamento}
    if tbsCliCnd.TabVisible then
      LogAltCadCli.pLogAdd('CLICND', ['AUTOINCREM'], 'CND_CODCLI = ' + QuotedStr(qryTabela.FieldByName('CLI_CODCLI').AsString), pSetaDisplayLabelCadCli_CondPagto);

    {Profissionais}
    if tbsCliDiv.TabVisible then
      LogAltCadCli.pLogAdd('CLIDIV', ['DIV_CODCLI', 'DIV_CODDIV'], 'DIV_CODCLI = ' + QuotedStr(qryTabela.FieldByName('CLI_CODCLI').AsString), pSetaDisplayLabelCadCli_Profissionais);

    {Conta Contábil/Empresa}
    if tbsCliConconEmp.TabVisible then
      LogAltCadCli.pLogAdd('CCCLIE', ['AUTOINCREM'], 'CCC_CODCLI = ' + QuotedStr(qryTabela.FieldByName('CLI_CODCLI').AsString), pSetaDisplayLabelCadCli_ContaContabilEmp);

    {Bairros Atendidos}
    if tbsBairroAtende.TabVisible then
      LogAltCadCli.pLogAdd('CLIBAT', ['AUTOINCREM'], 'BAT_CODCLI = ' + QuotedStr(qryTabela.FieldByName('CLI_CODCLI').AsString), pSetaDisplayLabelCadCli_BairrosAtend);

    {Fazendas}
    if tbsFazendas.TabVisible then
      LogAltCadCli.pLogAdd('CADFAZ', ['AUTOINCREM'], 'FAZ_CODCLI = ' + QuotedStr(qryTabela.FieldByName('CLI_CODCLI').AsString), pSetaDisplayLabelCadCli_Fazendas);

    {Inteligência de Vendas}
    if tbsIntVen.TabVisible then
      LogAltCadCli.pLogAdd('CLIFOR', ['CLF_CODCLI', 'CLF_CRMFOR'], 'CLF_CODCLI = ' + QuotedStr(qryTabela.FieldByName('CLI_CODCLI').AsString), pSetaDisplayLabelCadCli_InteligenciaVendas);

    {Embarcações}
    if tshEmbarcacoes.TabVisible then
      LogAltCadCli.pLogAdd('CLIEMB', ['AUTOINCREM'], 'EMB_CODCLI = ' + QuotedStr(qryTabela.FieldByName('CLI_CODCLI').AsString), pSetaDisplayLabelCadCli_Embarcacoes);

  end
  else
  begin

    LogAltCadCli.pLogAdd('CADCLI', ['AUTOINCREM'], '', pSetaDisplayLabelCadCli);

    if tbsContato.TabVisible then
      LogAltCadCli.pLogAdd('CLICTT', ['AUTOINCREM'], '', pSetaDisplayLabelCadCli_Contatos);

    if tbsEntregas.TabVisible then
      LogAltCadCli.pLogAdd('ENTCLI', ['AUTOINCREM'], '', pSetaDisplayLabelCadCli_EndEntrega);

    if tbsQuadSoc.TabVisible then
      LogAltCadCli.pLogAdd('CADFIC', ['FIC_CODCLI'], '', pSetaDisplayLabelCadCli_QuadSoc);

    if tbsQuadSoc.TabVisible then
      LogAltCadCli.pLogAdd('CLISCO', ['AUTOINCREM'], '', pSetaDisplayLabelCadCli_QuadSocII);

    if tbsRefCom.TabVisible then
      LogAltCadCli.pLogAdd('CLIRCO', ['AUTOINCREM'], '', pSetaDisplayLabelCadCli_RefComerciais);

    if tbsCrediario.TabVisible then
      LogAltCadCli.pLogAdd('CLI_INFCRE', ['CLI_CODCLI'], '', pSetaDisplayLabelCadCli_InfCrediario);

    if tbsClienteProduto.TabVisible then
      LogAltCadCli.pLogAdd('CLIPRO', ['AUTOINCREM'], '', pSetaDisplayLabelCadCli_RelClienteProduto);

    if tbsCliVei.TabVisible then
      LogAltCadCli.pLogAdd('CLIVEI', ['AUTOINCREM'], '', pSetaDisplayLabelCadCli_Veiculos);

    if tbsCliCnd.TabVisible then
      LogAltCadCli.pLogAdd('CLICND', ['AUTOINCREM'], '', pSetaDisplayLabelCadCli_CondPagto);

    if tbsCliDiv.TabVisible then
      LogAltCadCli.pLogAdd('CLIDIV', ['DIV_CODCLI', 'DIV_CODDIV'], '', pSetaDisplayLabelCadCli_Profissionais);

    if tbsCliConconEmp.TabVisible then
      LogAltCadCli.pLogAdd('CCCLIE', ['AUTOINCREM'], '', pSetaDisplayLabelCadCli_ContaContabilEmp);

    if tbsBairroAtende.TabVisible then
      LogAltCadCli.pLogAdd('CLIBAT', ['AUTOINCREM'], '', pSetaDisplayLabelCadCli_BairrosAtend);

    if tbsFazendas.TabVisible then
      LogAltCadCli.pLogAdd('CADFAZ', ['AUTOINCREM'], '', pSetaDisplayLabelCadCli_Fazendas);

    if tbsIntVen.TabVisible then
      LogAltCadCli.pLogAdd('CLIFOR', ['CLF_CODCLI', 'CLF_CRMFOR'], '', pSetaDisplayLabelCadCli_InteligenciaVendas);

    if tshEmbarcacoes.TabVisible then
      LogAltCadCli.pLogAdd('CLIEMB', ['AUTOINCREM'], '', pSetaDisplayLabelCadCli_Embarcacoes);

  end;

end;

procedure TfrmCadClientes.pAdicionaContatoCds(objContato: TCliCtt);
begin

  With cdsCliCtt Do
  Begin

    If (blnAltContato) Then
      Edit
    Else
      Append;

    TStringField(FieldByName('CLI_CPFCTT')).EditMask := '999.999.999-99;0;';
    TStringField(FieldByName('CLI_TELCTT')).EditMask := fRetMascaraFonePais;
    TStringField(FieldByName('CLI_CELCTT')).EditMask := fRetMascaraFonePais;
    TStringField(FieldByName('CLI_FAXCTT')).EditMask := fRetMascaraFonePais;

    FieldByName('CLI_AUTCTT').AsString := IIF(objContato.blnAutCtt, 'S', 'N');
    FieldByName('CLI_CPFCTT').AsString := objContato.strCpfCtt;
    FieldByName('CLI_RG_CTT').AsString := objContato.strRg_Ctt;
    FieldByName('CLI_NOMCTT').AsString := objContato.strNomCtt;
    FieldByName('CLI_ENDCTT').AsString := objContato.strEndCtt;
    FieldByName('CLI_BAICTT').AsString := objContato.strBaiCtt;
    FieldByName('CLI_CODCID').AsString := objContato.strCidCtt;
    FieldByName('CLI_NOMCID').AsString := objContato.strNomCid;
    FieldByName('CLI_ESTCID').AsString := objContato.strEstado;
    FieldByName('CLI_TELCTT').AsString := objContato.strTelCtt;
    FieldByName('CLI_CELCTT').AsString := objContato.strCelCtt;
    FieldByName('CLI_FAXCTT').AsString := objContato.strFaxCtt;
    FieldByName('CLI_DEPCTT').AsString := objContato.strDepCtt;
    FieldByName('CLI_EMACTT').AsString := objContato.strEmaCtt;

    FieldByName('CLI_CGOCTT').AsString := objContato.strCgoCtt;
    FieldByName('CLI_NOMCGO').AsString := objContato.strNomCgo;
    FieldByName('CLI_DPTCTT').AsString := objContato.strDptCtt;
    FieldByName('CLI_NOMDPT').AsString := objContato.strNomDpt;
    FieldByName('CLI_TFUCTT').AsString := objContato.strTfuCtt;
    FieldByName('CLI_NOMTFU').AsString := objContato.strNomTfu;
    FieldByName('CLI_HOBCTT').AsString := objContato.strHobCtt;
    FieldByName('CLI_NOMHOB').AsString := objContato.strNomHob;
    FieldByName('CLI_ESCCTT').AsString := objContato.strEscCtt;
    FieldByName('CLI_NOMESC').AsString := objContato.strNomEsc;
    FieldByName('CLI_GMUCTT').AsString := objContato.strGmuCtt;
    FieldByName('CLI_NOMGMU').AsString := objContato.strNomGmu;
    FieldByName('CLI_ECICTT').AsString := objContato.strEciCtt;
    FieldByName('CLI_NOMECI').AsString := objContato.strNomEci;
    If (objContato.dtNasCtt > 0) Then
      FieldByName('CLI_NASCTT').AsDateTime := objContato.dtNasCtt
    Else
      FieldByName('CLI_NASCTT').IsNull;
    FieldByName('CLI_TEMEMP').AsString := objContato.strTemEmp;
    FieldByName('CLI_TEMSEG').AsString := objContato.strTemSeg;
    FieldByName('CLI_QTDFIL').AsInteger := objContato.intQtdFil;
    FieldByName('CLI_CERCTT').AsString := objContato.strCerCtt;
    FieldByName('CLI_OBSCTT').AsString := objContato.strObsCtt;
    FieldByName('CLI_IDCIDE').AsExtended := objContato.extIdCiDe;
    FieldByName('AUTOINCREM').AsString := objContato.strAutoincrem;
    FieldByName('CLI_RAMFON').AsString := objContato.strRamFon;
    FieldByName('CLI_RAMFAX').AsString := objContato.strRamFax;

    Post;

    If (blnAltContato) Then
      lstContatos.Items[RecNo-1] := objContato
    Else If (lstContatos.IndexOf(objContato) < 0) Then
      lstContatos.Add(objContato);

    // Gera novo objeto em branco.
    objCliCtt := TCliCtt.Create(Self);

  End;

end;

procedure TfrmCadClientes.pAdicionaProdutosCds(objProduto: TCliPro);
begin

  Try

    With cdsCliPro Do
    Begin

      If (fProdutoJaInserido(objProduto.strCodPro, blnAltProduto))  Then
      Begin
        fMensagem('ATENÇÃO!', 'O Produto: ' + objProduto.strCodPro + '-' + objProduto.strNomPro + ' produto já foi incluído!', ['&Ok']);
        Exit;
      End;

      If (blnAltProduto) Then
        Edit
      Else
        Append;

      FieldByName('CODCLI').AsString := objProduto.strCodCli;
      FieldByName('CODPRO').AsString := objProduto.strCodPro;
      FieldByName('NOMPRO').AsString := objProduto.strNomPro;
      FieldByName('CODUNI').AsString := objProduto.strCodUni;
      FieldByName('DESUNI').AsString := objProduto.strDesUni;
      FieldByName('UNIDAD').AsString := objProduto.strUnidad;
      FieldByName('COD_NF').AsString := objProduto.strCod_NF;
      FieldByName('CODBAR').AsString := objProduto.strCodBar;

      If (Not fEmptyStr(objProduto.strDes_NF)) Then
        FieldByName('DES_NF').AsString := objProduto.strDes_NF
      Else
        FieldByName('DES_NF').Value    := Null;

      Post;

    End;

  Finally

  End;
end;

procedure TfrmCadClientes.pAdicionaVeiculosCds(objVeiculo: TCliVei);
begin
  With cdsCliVei Do
  Begin
    If (blnAltVeiculo) Then
      Edit
    Else
    Begin
      DisableControls;
      Filtered := False;
      Filter   := 'PLAVEI = ' + QuotedStr(objVeiculo.strPlaVei);
      Filtered := True;
      If (RecordCount > 0) Then
      Begin
        Filtered := False;
        EnableControls;
        fMensagem('ATENÇÃO!', 'Este veículo já foi inserido!', ['&Ok']);
        Exit;
      End;
      Filtered := False;
      EnableControls;
      Append;
    End;

    FieldByName('CODCLI').AsString := objVeiculo.strCodCli;
    FieldByName('PLAVEI').AsString := objVeiculo.strPlaVei;
    FieldByName('DESMOD').AsString := objVeiculo.strModVei;
    FieldByName('DESMAR').AsString := objVeiculo.strMarVei;
    FieldByName('DESCOR').AsString := objVeiculo.strCorVei;
    FieldByName('ANOVEI').AsString := objVeiculo.strAnoVei;
    FieldByName('VEIATI').AsString := IfThen(objVeiculo.strVeiAti = 'S','Sim', 'Não');
    Post;

    If (blnAltProduto) Then
      lstVeiculos.Items[RecNo-1] := objVeiculo
    Else If (lstVeiculos.IndexOf(objVeiculo) < 0) Then
      lstVeiculos.Add(objVeiculo);

    objCliVei := TCliVei.Create(Self);
  End;
end;

procedure TfrmCadClientes.pAjustaIesUni;
begin
  {Req.: 95790}
  If (qryTabela.FieldByName('CLI_PRORUR').AsString = 'S') Then
  Begin
    qryTabela.FieldByName('CLI_IESUNI').AsString := 'N';
    Exit;
  End;

  if fEmptyStr(qryTabela.FieldByName('CLI_IESUNI').AsString) then
    qryTabela.FieldByName('CLI_IESUNI').AsString := 'N';

  If (not fEmptyStr(dbeNumIes.Text)) And (dbeNumIes.Text = strIesAnt) Then
    Exit;

  If fEmptyStr(dbeNumIes.Text) Then
    qryTabela.FieldByName('CLI_IESUNI').AsString := 'S'
  Else
    qryTabela.FieldByName('CLI_IESUNI').AsString := 'N';

end;

procedure TfrmCadClientes.pAjustarTelaCadastroContato;
  Var
    i, j, k: Integer;
begin
  If (blnCadContato) Then
  Begin
    If (fEmptyStr(strCodClienteIniciarCadastro)) Then
    Begin
      blnCadContato := False;
    End
    Else
    Begin
      If (Not fVerificaAcessoSistema('ALTCNT', strLoginUsuarioLogado)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Operador não tem direito de acesso para alterar contatos de Clientes!', ['&Ok']);
        btnSair.Click();
      End
      Else Begin
        For i := 0 To Self.ComponentCount - 1 Do
        Begin
          If (Self.Components[i] Is TTabSheet) Then
          Begin
            If (Self.Components[i] <> tbsContato) Then
            Begin
              For j := 0 To TTabSheet(Self.Components[i]).ControlCount - 1 Do
              Begin
                If (TTabSheet(Self.Components[i]).Controls[j] Is TPanel) Then
                Begin
                  For k := 0 To TPanel(TTabSheet(Self.Components[i]).Controls[j]).ControlCount - 1 Do
                  Begin
                    TWinControl(TPanel(TTabSheet(Self.Components[i]).Controls[j]).Controls[k]).Tag := 0;
                  End;
                End;
              End;

              TTabSheet(Self.Components[i]).TabVisible := False;
            End;
          End;

          If (Self.Components[i] Is TBitBtnLocked) Then
          Begin
            If (Self.Components[i] <> btnGravar)
              And (Self.Components[i] <> btnSair)
              And (Self.Components[i] <> btnCancela)
              And (Self.Components[i] <> btnCancelaCtt)
              And (Self.Components[i] <> btnAdicionarCtt) Then
            Begin
              TBitBtnLocked(Self.Components[i]).Enabled := False;
            End;
          End;
        End;

        btnAlterar.Click();
        tbsContato.Caption := '&1 - Contatos';
        tbsContato.Show();
      End;
    End;
  End;
end;

procedure TfrmCadClientes.pAdicionaRefComerciaisCds(objRefComer: TCliRco);
  Var
    bkpAfterScroll : TDataSetNotifyEvent;
begin
  bkpAfterScroll := cdsCliRco.AfterScroll;
  Try
    cdsCliRco.AfterScroll := Nil;
    With cdsCliRco Do
    Begin

      If (blnAltRefComer) Then
        Edit
      Else
        Append;

      if (FieldByName('AUTINC').IsNull) then
        FieldByName('AUTINC').AsString := objRefComer.strAutInc;

      FieldByName('CODCLI').AsString   := objRefComer.strCodCli;
      FieldByName('EMPRCO').AsString   := objRefComer.strNomEmp;
      FieldByName('CGCCPF').AsString   := objRefComer.strCgcCpf;
      FieldByName('CGCEMP').AsString   := objRefComer.strCgcEmp;

      {CNPJ/CPF Formatado}
      FieldByName('CNPJ_CPF').AsString := fFormataCpfCgc(objRefComer.strCgcEmp, FPais);

      FieldByName('TELEMP').AsString   := objRefComer.strTelEmp;
      FieldByName('CONEMP').AsString   := objRefComer.strConEmp;
      FieldByName('EMAIL_').AsString   := objRefComer.strEmaEmp;

      if objRefComer.strDtaCon > 0 then
        FieldByName('DTACON').AsDateTime := objRefComer.strDtaCon
      else
        FieldByName('DTACON').IsNull;

      FieldByName('NOMINF').AsString   := objRefComer.strNomInf;

      if objRefComer.strDtaPco > 0 then
        FieldByName('DTAPCO').AsDateTime := objRefComer.strDtaPco
      else
        FieldByName('DTAPCO').IsNull;

      FieldByName('VALPCO').AsFloat    := objRefComer.strValPco;

      if objRefComer.strDtaMco > 0 then
        FieldByName('DTAMCO').AsDateTime := objRefComer.strDtaMco
      else
        FieldByName('DTAMCO').IsNull;

      FieldByName('VALMCO').AsFloat    := objRefComer.strValMco;

      if objRefComer.strDtaUco > 0 then
        FieldByName('DTAUCO').AsDateTime := objRefComer.strDtaUco
      else
        FieldByName('DTAUCO').IsNull;

      FieldByName('VALUCO').AsFloat    := objRefComer.strValUco;
      FieldByName('CODOPE').AsString   := objRefComer.strCodOpe;
      FieldByName('DESOPE').AsString   := objRefComer.strDesOpe;
      FieldByName('CODEMP').AsString   := VS_strCodEmp;
      Post;

      // Gera novo objeto em branco.
      objCliRco := TCliRco.Create(Self);

    End;
  Finally
    cdsCliRco.AfterScroll := bkpAfterScroll;
  End;
end;

procedure TfrmCadClientes.pAdicionarEmbarcacoes(strCodEmb: String);
  Var
    strSQL: String;
    qryTemp: TUniQuery;

  function fEmbarcacaoJaVinculadaCliente: Boolean;
  begin
    Result := False;

    Try
      cdsCadEmb.DisableControls();

      If (cdsCadEmb.Locate('EMB_CODEMB', strCodEmb, [])) Then Begin
        Result := True;
      End;
    Finally
      cdsCadEmb.EnableControls();
    End;
  end;

begin

  If (fEmbarcacaoJaVinculadaCliente()) Then Begin
    fMensagem('ATENÇÃO!', 'Embarcação informada já está vinculada ao cliente!', ['&Ok']);
    grdCadEmbDados.ApplyBestFit();
    Exit;
  End;

  strSQL := 'SELECT ';
  strSQL := strSQL + '  AUTOINCREM, ';
  strSQL := strSQL + '  EMB_CODEMB, ';
  strSQL := strSQL + '  EMB_NOMEMB, ';
  strSQL := strSQL + '  EMB_NUMIMO, ';
  strSQL := strSQL + '  EMB_INSCRI, ';
  strSQL := strSQL + '  EMB_INDEMB, ';
  strSQL := strSQL + '  EMB_PORTOI, ';
  strSQL := strSQL + '  EMB_PORTE_, ';
  strSQL := strSQL + '  EMB_COMPRI, ';
  strSQL := strSQL + '  EMB_ARQBRU, ';
  strSQL := strSQL + '  EMB_OBSERV ';
  strSQL := strSQL + 'FROM CADEMB ';
  strSQL := strSQL + 'WHERE EMB_CODEMB = :CODEMB ';

  Try
    cdsCadEmb.DisableControls();

    qryTemp := fCriaQuery(nil);

    Try
      qryTemp.Close();
      qryTemp.SQL.Clear();
      qryTemp.SQL.Text := strSQL;
      qryTemp.ParamByName('CODEMB').AsString := strCodEmb;
      qryTemp.Open();
      qryTemp.First();

      TFloatField(cdsCadEmb.FieldByName('EMB_COMPRI')).DisplayFormat := '#,##0.00';

      If (Not qryTemp.IsEmpty) Then Begin
        cdsCadEmb.Append();

        cdsCadEmb.FieldByName('AUTOINCREM').AsString := qryTemp.FieldByName('AUTOINCREM').AsString;
        cdsCadEmb.FieldByName('EMB_CODEMB').AsString := qryTemp.FieldByName('EMB_CODEMB').AsString;
        cdsCadEmb.FieldByName('EMB_NOMEMB').AsString := qryTemp.FieldByName('EMB_NOMEMB').AsString;
        cdsCadEmb.FieldByName('EMB_NUMIMO').AsString := qryTemp.FieldByName('EMB_NUMIMO').AsString;
        cdsCadEmb.FieldByName('EMB_INSCRI').AsString := qryTemp.FieldByName('EMB_INSCRI').AsString;
        cdsCadEmb.FieldByName('EMB_INDEMB').AsString := qryTemp.FieldByName('EMB_INDEMB').AsString;
        cdsCadEmb.FieldByName('EMB_PORTOI').AsString := qryTemp.FieldByName('EMB_PORTOI').AsString;
        cdsCadEmb.FieldByName('EMB_COMPRI').AsString := qryTemp.FieldByName('EMB_COMPRI').AsString;
        cdsCadEmb.FieldByName('EMB_ARQBRU').AsString := qryTemp.FieldByName('EMB_ARQBRU').AsString;
        cdsCadEmb.FieldByName('EMB_OBSERV').AsString := qryTemp.FieldByName('EMB_OBSERV').AsString;

        If (qryTemp.FieldByName('EMB_PORTE_').AsInteger = 0) Then
          cdsCadEmb.FieldByName('EMB_PORTE_').AsString := 'PEQUENO'
        Else If (qryTemp.FieldByName('EMB_PORTE_').AsInteger = 1) Then
          cdsCadEmb.FieldByName('EMB_PORTE_').AsString := 'MÉDIO'
        Else If (qryTemp.FieldByName('EMB_PORTE_').AsInteger = 2) Then
          cdsCadEmb.FieldByName('EMB_PORTE_').AsString := 'GRANDE';

        cdsCadEmb.Post();
      End;

      grdCadEmbDados.ApplyBestFit();
    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[TfrmCadClientes.pDeletarEmbarcacoes]');
    End;
  Finally
    cdsCadEmb.EnableControls();
    FreeAndNil(qryTemp);
  End;
end;

procedure TfrmCadClientes.pAplicarRegrasCrm;
begin
  If strRegraCRM = 'Clientes' Then
    pAplicarRegrasCrmClientes
  Else If strRegraCRM = 'Contatos' Then
    pAplicarRegrasCrmContatos
  Else If strRegraCRM = 'Enderecos' Then
    pAplicarRegrasCrmEnderecos;
end;

procedure TfrmCadClientes.pAplicarRegrasCrmClientes;
begin
  btnPesquisaClick(Self);
  If (blnEditaCliCrm) And (btnAlterar.Enabled) And (btnAlterar.Visible) Then
  begin
    btnAlterarClick(Self);
    If Not blnArqCliCrm Then
      pProcuraCampoClienteCRM;
  end;
{  Else
    pProcuraBotaoArqAnexClienteCRM;}
end;

procedure TfrmCadClientes.pAplicarRegrasCrmContatos;
begin
  btnPesquisaClick(Self);
  btnAlterarClick(Self);
  pProcuraCampoContatoCRM;
end;

procedure TfrmCadClientes.pAplicarRegrasCrmEnderecos;
begin
  btnPesquisaClick(Self);
  btnAlterarClick(Self);
  pgcDados.ActivePage := tbsEntregas;
end;

procedure TfrmCadClientes.pSetaParametrosCRM(strNomCampoCRM, strCodCliCRM, strNomRegraCRM, strDesCampoCRM: String; blnArqCliAnexCRM: Boolean; blnEditarClienteCRM: Boolean = True);
begin
  blnUtilizarCrm := True;
  strCliCRM      := strCodCliCRM;
  strCampoCRM    := strNomCampoCRM;
  strRegraCRM    := strNomRegraCRM;
  strDesCamCRM   := strDesCampoCRM;
  blnArqCliCrm   := blnArqCliAnexCRM;
  blnEditaCliCrm := blnEditarClienteCRM;
end;

procedure TfrmCadClientes.pCarregaContatoAlteracao;
begin
  If (Assigned(objCliCtt)) Then
    FreeAndNil(objCliCtt);

  objCliCtt := TCliCtt(lstContatos[cdsCliCtt.RecNo-1]);

  If pnlAutCtt.Visible Then
    pSetFocus(chkAutCtt)
  Else
    pSetFocus(edtNomCtt);

  blnAltContato := True;
end;

procedure TfrmCadClientes.pAtualizaEditsContato(DataSet: TDataSet);
begin
  With cdsCliCtt Do
  Begin

    If (IsEmpty) Then
      Exit;

    If FindField('CLI_TELCTT') <> nil Then
      TStringField(FieldByName('CLI_TELCTT')).EditMask := fRetMascaraFonePais;

    If FindField('CLI_CELCTT') <> nil Then
      TStringField(FieldByName('CLI_CELCTT')).EditMask := fRetMascaraFonePais;

    If FindField('CLI_FAXCTT') <> nil Then
      TStringField(FieldByName('CLI_FAXCTT')).EditMask := fRetMascaraFonePais;

    chkAutCtt.Checked := FieldByName('CLI_AUTCTT').AsString = 'S';
    mskCpfCtt.Text    := FieldByName('CLI_CPFCTT').AsString;
    edtRg_Ctt.Text    := FieldByName('CLI_RG_CTT').AsString;
    edtNomCtt.Text    := FieldByName('CLI_NOMCTT').AsString;
    edtEndCtt.Text    := FieldByName('CLI_ENDCTT').AsString;
    edtBaiCtt.Text    := FieldByName('CLI_BAICTT').AsString;
    mskTelCtt.Text    := FieldByName('CLI_TELCTT').AsString;
    mskCelCtt.Text    := FieldByName('CLI_CELCTT').AsString;
    mskFaxCtt.Text    := FieldByName('CLI_FAXCTT').AsString;
    edtDepCtt.Text    := FieldByName('CLI_DEPCTT').AsString;
    edtCidCtt.Text    := FieldByName('CLI_CODCID').AsString;
    edtNasCtt.Text    := IfThen((FieldByName('CLI_NASCTT').AsDateTime = 0) or (FieldByName('CLI_NASCTT').AsDateTime = -1)  ,'',DateToStr(FieldByName('CLI_NASCTT').AsDateTime));
    edtDesCidCtt.Text := FieldByName('CLI_NOMCID').AsString;
    edtEstadoCtt.Text := FieldByName('CLI_ESTCID').AsString;
    edtEmaCtt.Text    := FieldByName('CLI_EMACTT').AsString;

    edtCgoCtt.Text    := FieldByName('CLI_CGOCTT').AsString;
    edtDesCgoCtt.Text := FieldByName('CLI_NOMCGO').AsString;
    edtDptCtt.Text    := FieldByName('CLI_DPTCTT').AsString;
    edtDesDptCtt.Text := FieldByName('CLI_NOMDPT').AsString;
    edtTfuCtt.Text    := FieldByName('CLI_TFUCTT').AsString;
    edtDesTfuCtt.Text := FieldByName('CLI_NOMTFU').AsString;
    edtHobCtt.Text    := FieldByName('CLI_HOBCTT').AsString;
    edtDesHobCtt.Text := FieldByName('CLI_NOMHOB').AsString;
    edtEscCtt.Text    := FieldByName('CLI_ESCCTT').AsString;
    edtDesEscCtt.Text := FieldByName('CLI_NOMESC').AsString;
    edtGmuCtt.Text    := FieldByName('CLI_GMUCTT').AsString;
    edtDesGmuCtt.Text := FieldByName('CLI_NOMGMU').AsString;
    edtEciCtt.Text    := FieldByName('CLI_ECICTT').AsString;
    edtDesEciCtt.Text := FieldByName('CLI_NOMECI').AsString;
    edtTemEmp.Text    := FieldByName('CLI_TEMEMP').AsString;
    edtTemSeg.Text    := FieldByName('CLI_TEMSEG').AsString;
    edtQtdFil.Text    := IntToStr(FieldByName('CLI_QTDFIL').AsInteger);
    mmCerCtt.Text     := FieldByName('CLI_CERCTT').AsString;
    edtObsCtt.Text    := FieldByName('CLI_OBSCTT').AsString;
    edtRamFon.Text    := FieldByName('CLI_RAMFON').AsString;
    edtRamFax.Text    := FieldByName('CLI_RAMFAX').AsString;
  End;
end;

procedure TfrmCadClientes.pAtualizaEditsProdutos(DataSet: TDataSet);
begin
  With cdsCliPro Do
  Begin
    If (IsEmpty) Then
      Exit;

    edtCodIte.Text := FieldByName('CODPRO').AsString;
    edtDesIte.Text := FieldByName('NOMPRO').AsString;
    edtCodUni.Text := FieldByName('CODUNI').AsString;
    edtDesUni.Text := FieldByName('DESUNI').AsString;
    edtCod_NF.Text := FieldByName('COD_NF').AsString;
    edtDes_NF.Text := FieldByName('DES_NF').AsString;
    edtBar_CP.Text := FieldByName('CODBAR').AsString;
  End;
end;

procedure TfrmCadClientes.pAtualizaEditsVeiculos(DataSet: TDataSet);
begin
  With cdsCliVei Do
  Begin
    If (IsEmpty) Then
      Exit;

    mskPlaVei.Text := FieldByName('PLAVEI').AsString;
    edtModVei.Text := FieldByName('DESMOD').AsString;
    edtMarVei.Text := FieldByName('DESMAR').AsString;
    edtCorVei.Text := FieldByName('DESCOR').AsString;
    edtAnoVei.Text := FieldByName('ANOVEI').AsString;
    edtVeiAti.Text := LeftStr(FieldByName('VEIATI').AsString,1);                
  End;
end;

procedure TfrmCadClientes.pAtualizaEditsRefComerciais(DataSet: TDataSet);
begin
  With cdsCliRco Do
  Begin

    If (IsEmpty) Then
      Exit;

    If FindField('TELEMP') <> nil Then
      TStringField(FieldByName('TELEMP')).EditMask := fRetMascaraFonePais;

    edtEmpRco.Text := FieldByName('EMPRCO').AsString;

    edtCgcCpf.Text := FieldByName('CGCCPF').AsString;
    edtCgcEmp.Text := FieldByName('CGCEMP').AsString;

    {Formata CNPJ/CPF}
    edtCgcCpfExit(Self);

    edtTelEmp.Text := FieldByName('TELEMP').AsString;
    mmConEmp.Text  := FieldByName('CONEMP').AsString;
    edtEmaEmp.Text := FieldByName('EMAIL_').AsString;
    edtDtaCon.Text := IfThen(FieldByName('DTACON').AsDateTime = 0,'',DateTimeToStr(FieldByName('DTACON').AsDateTime));
    edtNomInf.Text := FieldByName('NOMINF').AsString;
    edtPriCom.Text := IfThen(FieldByName('DTAPCO').AsDateTime = 0,'',DateTimeToStr(FieldByName('DTAPCO').AsDateTime));
    edtVPrCom.Text := FormatFloat('###,#0.00',FieldByName('VALPCO').AsFloat);
    edtMaiCom.Text := IfThen(FieldByName('DTAMCO').AsDateTime = 0,'',DateTimeToStr(FieldByName('DTAMCO').AsDateTime));
    edtVMaCom.Text := FormatFloat('###,#0.00',FieldByName('VALMCO').AsFloat);
    edtUltCom.Text := IfThen(FieldByName('DTAUCO').AsDateTime = 0,'',DateTimeToStr(FieldByName('DTAUCO').AsDateTime));
    edtVUlCom.Text := FormatFloat('###,#0.00',FieldByName('VALUCO').AsFloat);
    edtCodOpe.Text := FieldByName('CODOPE').AsString;
    edtDesCodOpe.Text := FieldByName('DESOPE').AsString;
  End;
end;

procedure TfrmCadClientes.pAtualizaEditsSocio;
begin

  If Assigned(cdsCadSco) And (cdsCadSco.Active) And (cdsCadSco.RecordCount > 0) Then
  Begin

    edtNomSco.Text := cdsCadScoSCO_NOMSCO.AsString;

    If Not fEmptyStr(cdsCadScoSCO_PF_PJ_.AsString) Then
      edtOpcCnpjCpfSco.Text := cdsCadScoSCO_PF_PJ_.AsString
    Else
      edtOpcCnpjCpfSco.Clear;

    If Not fEmptyStr(cdsCadScoSCO_CPFCNP.AsString) Then
      edtCnpjCpfSco.Text := cdsCadScoSCO_CPFCNP.AsString
    Else
      edtCnpjCpfSco.Clear;

    If Not fEmptyStr(cdsCadScoSCO_NUM_RG.AsString) Then
      edtRGSco.Text := cdsCadScoSCO_NUM_RG.AsString
    Else
      edtRGSco.Clear;

    If (cdsCadScoSCO_DTANAS.AsDateTime > 0) Then
      mskDataNascimento.Text := cdsCadScoSCO_DTANAS.AsString
    Else
      mskDataNascimento.Clear;

    If (cdsCadScoSCO_PER_PS.AsFloat > 0) Then
      edtParticipacaoSco.Text := FormatFloat('#,##0.00', cdsCadScoSCO_PER_PS.AsFloat)
    Else
      edtParticipacaoSco.Clear;

    If Not fEmptyStr(cdsCadScoSCO_ESTCIV.AsString) Then
      edtEstadoCivil.Text := cdsCadScoSCO_ESTCIV.AsString;

  End;

end;

procedure TfrmCadClientes.pLimpaEditsContatos;
begin
  chkAutCtt.Checked := True;
  mskCpfCtt.Clear;
  edtRg_Ctt.Clear;
  edtNomCtt.Clear;
  edtEndCtt.Clear;
  edtBaiCtt.Clear;
  mskTelCtt.Clear;
  mskCelCtt.Clear;
  mskFaxCtt.Clear;
  edtDepCtt.Clear;
  edtCidCtt.Clear;
  edtDesCidCtt.Clear;
  edtEstadoCtt.Clear;
  edtEmaCtt.Clear;

  edtCgoCtt.Clear;
  edtDesCgoCtt.Clear;
  edtDptCtt.Clear;
  edtDesDptCtt.Clear;
  edtTfuCtt.Clear;
  edtDesTfuCtt.Clear;
  edtHobCtt.Clear;
  edtDesHobCtt.Clear;
  edtEscCtt.Clear;
  edtDesEscCtt.Clear;
  edtGmuCtt.Clear;
  edtDesGmuCtt.Clear;
  edtEciCtt.Clear;
  edtDesEciCtt.Clear;
  mmCerCtt.Clear;
  edtObsCtt.Clear;
  edtNasCtt.Clear;
  edtTemSeg.Clear;
  edtTemEmp.Clear;
  edtQtdFil.Clear;
  edtRamFon.Clear;
  edtRamFax.Clear;
end;

procedure TfrmCadClientes.pLimpaEditsProdutos;
begin
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtCodUni.Clear;
  edtDesUni.Clear;
  edtCod_NF.Clear;
  edtDes_NF.Clear;
  edtBar_CP.Clear;
end;

procedure TfrmCadClientes.pLimpaEditsQuadroSocietario;
begin
  edtNomSco.Clear;
  edtOpcCnpjCpfSco.Clear;
  edtCnpjCpfSco.Clear;
  edtRGSco.Clear;
  mskDataNascimento.Clear;
  edtParticipacaoSco.Clear;
  edtEstadoCivil.Clear;
end;

procedure TfrmCadClientes.pLimpaEditsVeiculos;
begin
  mskPlaVei.Clear;
  edtCorVei.Clear;
  edtModVei.Clear;
  edtMarVei.Clear;
  edtAnoVei.Clear;
  edtVeiAti.Text := 'S';
end;

procedure TfrmCadClientes.pLimpaImagem;
begin
  imgCli.Picture := Nil;
  imgCli.Visible := False;
  lblErrImg.Visible := False;
end;

procedure TfrmCadClientes.pLimparEditsEmbarcacoes;
begin
  edtCodEmb.Text := '';
  edtDesEmb.Text := '';
  pSetFocus(edtCodEmb);
end;

procedure TfrmCadClientes.pLimpaEditsRefComerciais;
begin
  edtEmpRco.Clear;
  edtCgcCpf.Clear;
  edtCgcEmp.Clear;
  edtNomInf.Clear;
  mmConEmp.Clear;
  edtEmaEmp.Clear;
  edtDtaCon.Clear;
  edtPriCom.Clear;
  edtVPrCom.Clear;
  edtMaiCom.Clear;
  edtVMaCom.Clear;
  edtUltCom.Clear;
  edtVUlCom.Clear;
  edtTelEmp.Clear;
  edtCodOpe.Clear;
  edtDesCodOpe.Clear;
end;

procedure TfrmCadClientes.pCarregaCidadeCtt;
begin
  pPesquisaCadCid(Nil, qryConCtt, edtCidCtt.Text);
  With qryConCtt Do
  Begin
    edtDesCidCtt.Text := FieldByName('CID_NOMCID').AsString;
    edtEstadoCtt.Text := FieldByName('CID_ESTADO').AsString;
  End;
end;

procedure TfrmCadClientes.dbgContatosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
  Var
    i: Integer;
begin
  inherited;
  If (Key = VK_RETURN) And (pnlContatos.Enabled) Then
  Begin
    If (Not fVerificaAcessoSistema('ALTCNT', strLoginUsuarioLogado)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Operador não tem direito de acesso para alterar contatos de Clientes!', ['&Ok']);
      Exit;
    End;

    If (Not cdsCliCtt.IsEmpty) And ((qryTabela.State = dsEdit) Or (qryTabela.State = dsInsert)) Then
    Begin
      pAtualizaEditsContato(Nil);
      pCarregaContatoAlteracao;
    End;
  End
  Else If (Key = VK_DELETE) And (pnlContatos.Enabled) Then
  Begin
    If (Not cdsCliCtt.IsEmpty) And (Not dbgContatos.ReadOnly) Then
    Begin
      If (Not fVerificaAcessoSistema('EXCCNT', strLoginUsuarioLogado)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Operador não tem direito de acesso para excluir contatos de Clientes!', ['&Ok']);
        Exit;
      End;

      If fMensagem('ATENÇÃO','Confirma excluir contato "' +
         cdsCliCtt.FieldByName('CLI_NOMCTT').AsString + '" ?',['','']) = 1 then
      Begin
        For i := 0 To lstContatos.Count - 1 Do
          If (TCliCtt(lstContatos[i]).strAutoincrem = cdsCliCtt.FieldByName('AUTOINCREM').AsString) Then Begin
            TCliCtt(lstContatos[i]).blnExcluir := True;
            Break;
          End;

        cdsCliCtt.Delete;
      End;
    End
    Else
    Begin
      pnlContatos.Enabled  := True;
      pnlAutCtt.Enabled    := True;
      dbgContatos.ReadOnly := True;
      pLimpaEditsContatos;
    End;
  End
  Else If (Key = VK_ESCAPE) And (qryTabela.State = dsEdit) And (pnlContatos.Enabled) Then
  Begin
    pnlContatos.Enabled  := True;
    pnlAutCtt.Enabled    := True;
    dbgContatos.ReadOnly := True;
    btnCancelaCtt.Click;

    If pnlAutCtt.Visible Then
      pSetFocus(chkAutCtt)
    Else
      pSetFocus(edtNomCtt);
  End;
end;

procedure TfrmCadClientes.dbgProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) And (pnlProdutos.Enabled) Then
  Begin
    If (Not cdsCliPro.IsEmpty) And ((qryTabela.State = dsEdit) Or (qryTabela.State = dsInsert)) Then
    Begin
      If cdsCliPro.RecordCount = 1 Then
        pAtualizaEditsProdutos(Nil);

      pCarregaProdutosAlteracao;
    End;
  End
  Else If (Key = VK_DELETE) And (pnlProdutos.Enabled) Then
  Begin
    If (Not cdsCliPro.IsEmpty) Then
    Begin
      If fMensagem('ATENÇÃO','Confirma excluir produto "' +
         cdsCliPro.FieldByName('NOMPRO').AsString + '" ?',['','']) = 1 then
      Begin
        cdsCliPro.Delete;
      End;
    End
    Else
    Begin
      pnlProdutos.Enabled  := True;
      pLimpaEditsProdutos;
    End;
  End
  Else If (Key = VK_ESCAPE) And (qryTabela.State = dsEdit) And (pnlContatos.Enabled) Then
  Begin
    pnlContatos.Enabled  := True;
    pnlAutCtt.Enabled    := True;
    dbgContatos.ReadOnly := True;
    btnCancelaCtt.Click;

    If pnlAutCtt.Visible Then
      pSetFocus(chkAutCtt)
    Else
      pSetFocus(edtNomCtt);
  End;
end;

procedure TfrmCadClientes.dbgQuadSocKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  inherited;

  If (Key = VK_RETURN) And (pnlTopoQuadSco.Enabled) Then
  Begin
    If (Not cdsCadSco.IsEmpty) And ((qryTabela.State = dsEdit) Or (qryTabela.State = dsInsert)) Then
      If cdsCadSco.RecordCount >= 1 Then
      Begin
        pAtualizaEditsSocio;
        pSetFocus(edtNomSco);
        blnAltSocio := True;
      End;
  End
  Else If (Key = VK_DELETE) And (pnlTopoQuadSco.Enabled) Then
  Begin

    If (Not cdsCadSco.IsEmpty) And (Not dbgQuadSoc.ReadOnly) Then
      If fMensagem('ATENÇÃO','Confirma excluir sócio "' + cdsCadSco.FieldByName('SCO_NOMSCO').AsString + '" ?',['','']) = 1 then
        cdsCadSco.Delete;

  End
  Else If (Key = VK_ESCAPE) And (qryTabela.State = dsEdit) And (pnlTopoQuadSco.Enabled) Then
  Begin
    btnCancelarQuadSoc.Click;
    pSetFocus(edtNomSco);
  End;

end;

procedure TfrmCadClientes.dtsTabelaDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  pUpdateCaption;
end;

procedure TfrmCadClientes.dtsTabelaStateChange(Sender: TObject);
begin
  inherited;
  pUpdateCaption;

  edtCodEmb.Enabled := qryTabela.State in dsEditModes;
  edtDesEmb.Enabled := qryTabela.State in dsEditModes;
  btnGravarEmb.Enabled := qryTabela.State in dsEditModes;
end;

procedure TfrmCadClientes.edtCidCttKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, edtCidCtt, edtDesCidCtt, edtEstadoCtt, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(edtCidCtt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.edtCidCttKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If fVerificaAcessoSistema(strPermiCadCid) Then
  Begin
    If fChamaCadCid(Key) <> Null Then
      pAtribuiTabelas;
  End;
end;

function TfrmCadClientes.edtCadCacChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadAce(Key);
  pAtribuiTabelas;
end;

procedure TfrmCadClientes.edtCadCacExit(Sender: TObject);
begin
  inherited;

  if fValidaCampos(edtCadCac, True) then
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmCadClientes.edtCadCacKeyPress(Sender: TObject; var Key: Char);
Var
  arrCanal : TConsultasArray;
begin
  inherited;
  {************************************}
  {* NOVA CONSULTA DE CANAL DE ACESSO *}
  {*********************************DP*}
  If fPesqCanalAcesso(Self, edtCadCac, edtDesCadCac, Nil, Key, arrCanal) Then
  Begin
    if fValidaCampos(edtCadCac, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.edtCgcCpfExit(Sender: TObject);
begin
  inherited;
  pAtribuiMascaraCgcRefComerciais;
end;

procedure TfrmCadClientes.edtCgoCttKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCargos: TConsultasArray;
begin
  inherited;
  {*****************************}
  {* NOVA CONSULTA DE CARGOS   *}
  {**************************AC*}
  If fPesqCargosCliCon(Self, edtCgoCtt, edtDesCgoCtt, Nil, Key, arrCargos) Then
  Begin
    If fValidaCampos(edtCgoCtt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.edtCidCttEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'INSERT para fazer um novo cadastro';
end;

procedure TfrmCadClientes.edtCidCttExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmCadClientes.edtCidCttKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmCadClientes.dbgCliBatKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) Then
  Begin
    If (not (qryTabela.State In dsEditModes)) Or (cdsCliBat.RecordCount < 1) Then Exit;

    If fMensagem('','Deseja deletar o Bairro Selecionado?', ['&Sim', '&Não']) = 1 Then
    Begin
      cdsCliBat.Delete;
      cdsCliBat.Tag := Succ(cdsCliBat.Tag);
    End;
  End;
end;

procedure TfrmCadClientes.dbgCliBatKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
    pSetFocus(edtCodBai);

end;

procedure TfrmCadClientes.dbgCliRcoEnter(Sender: TObject);
begin
  inherited;
  If cdsCliRco.RecordCount > 0 Then
    cdsCliRco.First;
end;

procedure TfrmCadClientes.dbgCliRcoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  inherited;

  If (Key = VK_RETURN) And (pnlContatos.Enabled) Then
  Begin
    If (Not cdsCliRco.IsEmpty) And ((qryTabela.State = dsEdit) Or (qryTabela.State = dsInsert)) Then
    Begin
      If cdsCliRco.RecordCount = 1 Then
        pAtualizaEditsRefComerciais(Nil);

      pCarregaRefComerciaisAlteracao;
    End;
  End
  Else If (Key = VK_DELETE) And (pnlRefComerciais.Enabled) Then
  Begin
    If (Not cdsCliRco.IsEmpty) And (Not dbgCliRco.ReadOnly) Then
    Begin
      If fMensagem('ATENÇÃO','Confirma excluir referencia comercial "' +
         cdsCliRco.FieldByName('EMPRCO').AsString + '" ?',['','']) = 1 then
      Begin
        cdsCliRco.Delete;
      End;
    End
    Else
    Begin
      pnlRefComerciais.Enabled := True;
      dbgCliRco.ReadOnly       := True;
      pLimpaEditsRefComerciais;
    End;
  End
  Else If (Key = VK_ESCAPE) And (qryTabela.State = dsEdit) And (pnlRefComerciais.Enabled) Then
  Begin
    pnlRefComerciais.Enabled := True;
    dbgCliRco.ReadOnly       := True;
    btnCancelaRco.Click;
    pSetFocus(edtEmpRco);
  End;
end;

procedure TfrmCadClientes.dbgCliVeiEnter(Sender: TObject);
begin
  inherited;
  If cdsCliVei.RecordCount > 0 Then
    cdsCliVei.First;
end;

procedure TfrmCadClientes.dbgCliVeiKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) And (pnlCliVei.Enabled) Then
  Begin
    If (Not cdsCliVei.IsEmpty) And ((qryTabela.State = dsEdit) Or (qryTabela.State = dsInsert)) Then
    Begin
      If cdsCliVei.RecordCount = 1 Then
        pAtualizaEditsVeiculos(Nil);

      pCarregaVeiculosAlteracao;
    End;
  End
  Else If (Key = VK_DELETE) And (pnlCliVei.Enabled) Then
  Begin
    If (Not cdsCliVei.IsEmpty) And (Not dbgCliVei.ReadOnly) Then
    Begin
      If fMensagem('ATENÇÃO','Confirma excluir veículo "' +
         cdsCliVei.FieldByName('PLAVEI').AsString + '" ?',['','']) = 1 then
      Begin
        lstVeiculos.Remove(lstVeiculos[cdsCliVei.RecNo-1]);
        cdsCliVei.Delete;
      End;
    End
    Else
    Begin
      pnlCliVei.Enabled  := True;
      dbgCliVei.ReadOnly := True;
      pLimpaEditsVeiculos;
    End;
  End
  Else If (Key = VK_ESCAPE) And (qryTabela.State = dsEdit) And (pnlCliVei.Enabled) Then
  Begin
    dbgCliVei.ReadOnly := True;
    btnCanVei.Click;
    pSetFocus(mskPlaVei);
  End;
end;

procedure TfrmCadClientes.dbgContatosEnter(Sender: TObject);
begin
  inherited;
  If cdsCliCtt.RecordCount > 0 Then
    cdsCliCtt.First;
end;


procedure TfrmCadClientes.dbeObservKeyPress(Sender: TObject;
  var Key: Char);
  Var
    strKey : String;
begin
  inherited;
  strKey := Key;
  strKey := AnsiUpperCase(strKey);
  Key    := strKey[1];
end;

procedure TfrmCadClientes.dbeObs_FcKeyPress(Sender: TObject; var Key: Char);
  Var
    strKey : String;
begin
  inherited;
  strKey := Key;
  strKey := AnsiUpperCase(strKey);
  Key    := strKey[1];
end;

procedure TfrmCadClientes.dbePlaNcoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fEntraCons(Key) Then
  Begin
    TStringField(qryTabela.FieldByName('CLI_PLANCO')).EditMask := '';
    If fPesqPlanoContabil(Self, dbePlaNco, Nil, Nil, Key, arrSel) Then
    Begin
      If fValidaCampos(dbePlaNco, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
    TStringField(qryTabela.FieldByName('CLI_PLANCO')).EditMask := fMskCon;
  End;
end;

procedure TfrmCadClientes.dbeResideKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If CharInSet(Key, ['-']) Then
    Key := #0;
end;

procedure TfrmCadClientes.dbeNuCpnjExit(Sender: TObject);
begin
  inherited;
  pEstadoEmissaoCPF;
end;

procedure TfrmCadClientes.dbeNumCepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If (fEntraCons(Key)) And (fCfgSis('USACEP', varBoolean)) Then
  Begin
    Key := #0;

    dbeNumCep.Text := fConsultarCep(Self, dbeNumCep.Text, dbeNumCep);
  End;

end;

procedure TfrmCadClientes.dbeNumIesExit(Sender: TObject);
begin
  inherited;
  pAjustaIesUni;
end;

function TfrmCadClientes.dbeAvalisChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadCli(Key);
  pAtribuiTabelas;
end;

procedure TfrmCadClientes.dbeAvalisKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, dbeAvalis, edtDesAvalis, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(dbeAvalis, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.dbeRECAP_Change(Sender: TObject);
begin
  inherited;

  if dbeRECAP_.Text = 'S' then
    btnRECAP.Enabled := True
  else
    btnRECAP.Enabled := False;
end;

procedure TfrmCadClientes.dbeCepCobKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) And (fCfgSis('USACEP', varBoolean)) Then
  Begin
    dbeCepCob.Clear;

    dbeCepCob.Text := fConsultarCep(Self, dbeCepCob.Text, dbeCepCob);
  End;
end;

procedure TfrmCadClientes.pVerificaDireitosDadosRetencao;
begin

  pnlMsgDirAlqRet.Visible := False;

  If Not fVerificaAcessoSistema('ALTRET', strLoginUsuarioLogado) Then
  Begin
    dbeRetPCo.Enabled := False;
    dbeRetIrf.Enabled := False;
    dbeSegSoc.Enabled := False;
    dbeCoDeAc.Enabled := False;
    dbeIseIpi.Enabled := False;
    rdgCobIss.Enabled := False;
    dbeAlqIss.Enabled := False;
    dbeRetIss.Enabled := False;
    dbeRedISS.Enabled := False;
    dbeBenRei.Enabled := False;
    cbxTributacaoIPI.Enabled := False;
    dbeMensagemIPI.Enabled := False;
    dbeEnqIPI.Enabled := False;
    dbeIcmRei.Enabled := False;

    pnlMsgDirAlqRet.Visible := True;
  End;

end;

procedure TfrmCadClientes.sbAlqRetClick(Sender: TObject);
begin
  inherited;
  pMensagemSonora(Concat('Quando as alíquotas de retenção forem informadas por cliente, ',
                         'as alíquotas de retenção das configurações do sistema serão ',
                         'desconsideradas. ',
                         'Este recurso deve ser utilizado somente quando o cliente ',
                         'pratica alíquotas de retenção diferentes das alíquotas de ',
                         'retenção cadastradas nas configurações do sistema. ',
                         'Segue alíquotas de retenção cadastradas nas configurações do ',
                         'sistema, para referência: ',
                         '-----------------------------------------------------------', sLineBreak,
                         'DE SERVIÇOS (CFG_ALQPIS,CFG_ALQCOF,CFG_ALQCSL,CFG_ALQIRF): ', sLineBreak,
                         'Pis: ' + FormatFloat('#,##0.00', fCfgSis('ALQPIS', VarDouble)) + '%' +
                         '  Cofins: ' + FormatFloat('#,##0.00', fCfgSis('ALQCOF', VarDouble)) + '%' +
                         '  CSLL: '   + FormatFloat('#,##0.00', fCfgSis('ALQCSL', VarDouble)) + '%' +
                         '  IRPJ: '   + FormatFloat('#,##0.00', fCfgSis('ALQIRF', VarDouble)) + '%', sLineBreak,
                         sLineBreak,
                         '-----------------------------------------------------------', sLineBreak,
                         'DE PRODUTOS (CFG_ALPISP,CFG_ALCOFP,CFG_ALCSLP,CFG_ALIRFP): ', sLineBreak,
                         'Pis: ' + FormatFloat('#,##0.00', fCfgSis('ALPISP', VarDouble)) + '%' +
                         '  Cofins: ' + FormatFloat('#,##0.00', fCfgSis('ALCOFP', VarDouble)) + '%' +
                         '  CSLL: '   + FormatFloat('#,##0.00', fCfgSis('ALCSLP', VarDouble)) + '%' +
                         '  IRPJ: '   + FormatFloat('#,##0.00', fCfgSis('ALIRFP', VarDouble)) + '%', sLineBreak,
                         '-----------------------------------------------------------', sLineBreak), False, 16, 780);
end;

procedure TfrmCadClientes.spbDicaAbasClick(Sender: TObject);
begin

  inherited;
  fMensagem('Dica: Navegação entre as abas', 'Utilize ALT + [Seta para a esquerda] ou [Seta para a direita] para navegar entre as abas.', ['&Ok']);

end;

procedure TfrmCadClientes.spbFone1Click(Sender: TObject);
begin
  inherited;
  pStatusTelefone(TSpeedButton(Sender), True);
end;

procedure TfrmCadClientes.spdHelpLimCreClick(Sender: TObject);
begin
  inherited;
  frxHelpLimCred.ShowReport();
end;

procedure TfrmCadClientes.tbsEntregasHide(Sender: TObject);
begin
  inherited;
  If FCliEndEntrega.cdsConsulta.State <> dsBrowse Then
    FCliEndEntrega.btnCancela.Click;
end;

procedure TfrmCadClientes.tbsEntregasShow(Sender: TObject);
begin
  inherited;
  With qryTabela Do
    FCliEndEntrega.pAtualizaEnderecoPadrao(FieldByName('CLI_CODCLI').AsString,
                                           FieldByName('CLI_CODCID').AsString,
                                           FieldByName('CLI_ENDERE').AsString,                                           
                                           FieldByName('CLI_ENDNUM').AsString,
                                           FieldByName('CLI_ENDCOM').AsString,
                                           FieldByName('CLI_BAIRRO').AsString,
                                           FieldByName('CLI_C_E_P_').AsString,
                                           FieldByName('CLI_COBISS').AsString,
                                           FieldByName('CLI_CODOBR').AsString,
                                           FieldByName('CLI_CODART').AsString,
                                           FieldByName('CLI_CODCNO').AsString,
                                           FieldByName('CLI_FONE01').AsString,
                                           FieldByName('CLI_CODREG').AsString,
                                           FieldByName('CLI_CONTAT').AsString,
                                           FieldByName('CLI_INSIMO').AsString,
                                           FieldByName('CLI_CODCIB').AsString);

end;

procedure TfrmCadClientes.tbsFazendasHide(Sender: TObject);
begin
  inherited;
  if Assigned(FCliFazendas) and Assigned(FCliFazendas.cdsConsulta) then
  begin
    If FCliFazendas.cdsConsulta.State <> dsBrowse Then
      FCliFazendas.btnCancela.Click;
  end;
end;

procedure TfrmCadClientes.tshEmbarcacoesShow(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodEmb);
end;

function TfrmCadClientes.UtilizaConsultaBoaVistaAcertaEssencialPositivo: Boolean;
begin
  Result := True;

  If Not Trim(dbeCgcCpf.Text).Equals('2') Then
    Exit(False);

  If Not btnConSCPC.Visible Then
    Exit(False);

  If Not (fCfgSis('CNSCPC') = 'E') Then
    Exit(False);

  If Not (fCfgSis('INTBOV') = 'ES') Then
    Exit(False);
end;

function TfrmCadClientes.UtilizaSCPC_POA: Boolean;
begin
  Result := True;

  If Not (fCfgSis('CNSCPC') = 'R') Then
    Exit(False);

end;

function TfrmCadClientes.UtilizaConsultaSerasaPowerCurve: Boolean;
begin
  Result := True;

 If Not fCfgSis('USAPCC', varBoolean) Then
   Exit(False);

  If cmbTipoPesquisa.ItemIndex <> 1 Then // serasa
    Exit(False);

  If cbProdutoSerasa.ItemIndex <> 1 Then // PowerCurve
    Exit(False);
end;

procedure TfrmCadClientes.VerificarDiasRestantesConsultaCredito;
  Var
    IntQTEXCC : Integer;
begin
  IntQTEXCC := fCfgSis('QTEXCC', varInteger);
  if Not fEmptyStr(fTiraCaracEspeciais(dbeDtaCon.Text)) then
  begin
    If DaysBetween((StrToDateTimeDef(dbeDtaCon.Text, 0) + IntQTEXCC), VS_Date) = 0 Then
    begin
      lblQtdDiasRestantesConsultaCredito.Caption := 'Último dia para consulta.';
    end
    else
    If DaysBetween((StrToDateTimeDef(dbeDtaCon.Text, 0) + IntQTEXCC), VS_Date) > 0 Then
    begin
      if ((StrToDate(dbeDtaCon.Text) + IntQTEXCC) > VS_Date) then
        lblQtdDiasRestantesConsultaCredito.Caption := IntToStr(DaysBetween((StrToDateTimeDef(dbeDtaCon.Text, 0) + IntQTEXCC), VS_Date)) + ' Dia(s) restante(s) para expirar'
      else
        lblQtdDiasRestantesConsultaCredito.Caption := 'Consulta expirada.';
    end;

    lblQtdDiasRestantesConsultaCredito.Visible := True;
  end
  else
    lblQtdDiasRestantesConsultaCredito.Visible := False;
end;

procedure TfrmCadClientes.VerificarDiasRestantesConsultaCobranca;
  Var
    IntTVCLQD : Integer;
begin
  IntTVCLQD := fCfgSis('TVCLQD', varInteger);
  if Not fEmptyStr(fTiraCaracEspeciais(dbeDtCoCb.Text)) then
  begin
    If DaysBetween((StrToDateTimeDef(dbeDtCoCb.Text, 0) + IntTVCLQD), VS_Date) = 0 Then
    begin
      lblQtdDiasRestantesConsulta.Caption := 'Último dia para consulta.';
    end
    else
    If DaysBetween((StrToDateTimeDef(dbeDtCoCb.Text, 0) + IntTVCLQD), VS_Date) > 0 Then
    begin
      if ((StrToDate(dbeDtCoCb.Text) + IntTVCLQD) > VS_Date) then
        lblQtdDiasRestantesConsulta.Caption := IntToStr(DaysBetween((StrToDateTimeDef(dbeDtCoCb.Text, 0) + IntTVCLQD), VS_Date)) + ' Dia(s) restante(s) para expirar'
      else
        lblQtdDiasRestantesConsulta.Caption := 'Consulta expirada.';
    end;

    lblQtdDiasRestantesConsulta.Visible := True;
  end
  else
    lblQtdDiasRestantesConsulta.Visible := False;
end;

procedure TfrmCadClientes.pCadastroFoiAlterado(Field: TField);
begin
  If (Not Assigned(dtsTabela.DataSet)) Then
    Exit;

  If (dtsTabela.DataSet.State = dsInsert) Then
    blnCadastroModificado := True;

  If (dtsTabela.DataSet.State <> dsEdit) Then
    Exit;

  If (blnCadastroModificado) Then
    Exit;

  blnCadastroModificado := (fFieldAlterado(Field));
end;

procedure TfrmCadClientes.pVerificaDireitosBotoes;
begin
  If Not fVerificaAcessoSistema('ACEF2_', strLoginUsuarioLogado) Then
    btnObsCli.Enabled := False
  Else
    btnObsCli.Enabled := True;

  If Not fVerificaAcessoSistema('ACEF3_', strLoginUsuarioLogado) Then
    btnTeleatendimento.Enabled := False
  Else
    btnTeleatendimento.Enabled := True;

  If Not fVerificaAcessoSistema('ACEF5_', strLoginUsuarioLogado) Then
    btnContratos.Enabled := False
  Else
    btnContratos.Enabled := True;

  btnCliVen.Visible :=
    fVerificaAcessoSistema('ACEF4_', strLoginUsuarioLogado) and
    fCfgSis('MLTOPE', varBoolean);

  If Not fVerificaAcessoSistema('ACEF6_', strLoginUsuarioLogado) Then
    btnHisDeb.Enabled := False
  Else
    btnHisDeb.Enabled := True;

  If Not fVerificaAcessoSistema('ACEF7_', strLoginUsuarioLogado) Then
    btnResFin.Enabled := False
  Else
    btnResFin.Enabled := True;

  blnAceF8 := fVerificaAcessoSistema('ACEF8_', strLoginUsuarioLogado);

  If Not fVerificaAcessoSistema('ACEF9_', strLoginUsuarioLogado) Then
    btnVenCli.Enabled := False
  Else
    btnVenCli.Enabled := True;

  If Not fVerificaAcessoSistema('ACEF10', strLoginUsuarioLogado) Then
    btnInfCobr.Enabled := False
  Else
    btnInfCobr.Enabled := True;

  If Not fVerificaAcessoSistema('ACEF11', strLoginUsuarioLogado) Then
    btnLogAlter.Enabled := False
  Else
    btnLogAlter.Enabled := True;

  If Not fVerificaAcessoSistema('GERDIV', strLoginUsuarioLogado) Then
    btnCadDiv.Enabled := False
  Else
    btnCadDiv.Enabled := True;

  If Not fVerificaAcessoSistema('ACESPED', strLoginUsuarioLogado) Then
    btnAltPar.Enabled := False
  Else
    btnAltPar.Enabled := True;

end;

procedure TfrmCadClientes.pVerificaDireitosDadosPrincipais;
begin
  If (qryTabela.State = dsEdit) Then
  Begin
    If Not fVerificaAcessoSistema('ALTRZS', strLoginUsuarioLogado) Then
      dbeNomCli.Enabled := False
    Else dbeNomCli.Enabled := True;

    If Not fVerificaAcessoSistema('ALTNOF', strLoginUsuarioLogado) Then
      dbeFanSob.Enabled := False
    Else dbeFanSob.Enabled := True;

    If Not fVerificaAcessoSistema('ALTCGC', strLoginUsuarioLogado) Then
    Begin
      dbeCgcCpf.Enabled := False;
      dbeNuCpnj.Enabled := False;
      chkCpfDev.Enabled := False;
      dbeCpfDev.Enabled := False;
    End
    Else
    Begin
      dbeCgcCpf.Enabled := (Not fPreencheuIDEstrangeiro);
      dbeNuCpnj.Enabled := (Not fPreencheuIDEstrangeiro);
      chkCpfDev.Enabled := True;
      dbeCpfDev.Enabled := True;
    End;

    If Not fVerificaAcessoSistema('ALTFN1', strLoginUsuarioLogado) Then
      dbeFone01.Enabled := False
    Else
      dbeFone01.Enabled := True;

    If Not fVerificaAcessoSistema('ALTFN2', strLoginUsuarioLogado) Then
      dbeFone02.Enabled := False
    Else
      dbeFone02.Enabled := True;

    If Not fVerificaAcessoSistema('ALTFAX', strLoginUsuarioLogado) Then
      dbeNumFax.Enabled := False
    Else
      dbeNumFax.Enabled := True;

    If Not fVerificaAcessoSistema('ALTRAM', strLoginUsuarioLogado) Then
    Begin
      dbeRamal1.Enabled := False;
      dbeRama2.Enabled  := False;
      dbeRama3.Enabled  := False;
    End
    Else
    Begin
      dbeRamal1.Enabled := True;
      dbeRama2.Enabled  := True;
      dbeRama3.Enabled  := True;
    End;

    If Not fVerificaAcessoSistema('ALTRED', strLoginUsuarioLogado) Then
      dbeRedIcm.Enabled := False
    Else
      dbeRedIcm.Enabled := True;

    If Not fVerificaAcessoSistema('ALTCEL', strLoginUsuarioLogado) Then
      dbeNumCel.Enabled := False
    Else
      dbeNumCel.Enabled := True;

    If Not fVerificaAcessoSistema('ALTCON', strLoginUsuarioLogado) Then
      dbeContat.Enabled := False
    Else
      dbeContat.Enabled := True;

    If Not fVerificaAcessoSistema('ALTEM1', strLoginUsuarioLogado) Then
      dbeEmail.Enabled := False
    Else
      dbeEmail.Enabled := True;

    If Not fVerificaAcessoSistema('ALTEM3', strLoginUsuarioLogado) Then
      dbeEmailNfe.Enabled := False
    Else
      dbeEmailNfe.Enabled := True;

    If Not fVerificaAcessoSistema('ALTEM2', strLoginUsuarioLogado) Then
      dbeEmailNfe2.Enabled := False
    Else
      dbeEmailNfe2.Enabled := True;

    If (edtCodCnd.Visible) Then
    Begin
      If Not fVerificaAcessoSistema('CNPCLI', strLoginUsuarioLogado) Then
        edtCodCnd.Enabled := False
      Else
        edtCodCnd.Enabled := True;

      cxgConPag.Enabled := edtCodCnd.Enabled;
    End;

    If (mskConPag.Visible) Then
    Begin
      If Not fVerificaAcessoSistema('CNPCLI', strLoginUsuarioLogado) Then
        mskConPag.Enabled := False
      Else
        mskConPag.Enabled := True;

      cxgConPag.Enabled := mskConPag.Enabled;        
    End;

    If (dbeCodFpg.Visible) Then
    Begin
      If Not fVerificaAcessoSistema('ALTFPG', strLoginUsuarioLogado) Then
        dbeCodFpg.Enabled := False
      Else
        dbeCodFpg.Enabled := True;
    End;

    If (dbeDiferi.Visible) Then
    Begin
      If Not fVerificaAcessoSistema('DIFCLI', strLoginUsuarioLogado) Then
        dbeDiferi.Enabled := False
      Else
        dbeDiferi.Enabled := True;
    End;

    If (dbeDif_ST.Visible) Then
    Begin
      If Not fVerificaAcessoSistema('DIF_ST', strLoginUsuarioLogado) Then
        dbeDif_ST.Enabled := False
      Else
        dbeDif_ST.Enabled := True;
    End;

    If (dbeDif_PC.Visible) Then
    Begin
      If Not fVerificaAcessoSistema('DIF_PC', strLoginUsuarioLogado) Then
        dbeDif_PC.Enabled := False
      Else
        dbeDif_PC.Enabled := True;
    End;

    If (pnlPermut.Visible) Then
    Begin
      If Not fVerificaAcessoSistema('PERCLI', strLoginUsuarioLogado) Then
        dbePermut.Enabled := False
      Else
        dbePermut.Enabled := True;
    End;
  End;

end;

function TfrmCadClientes.dbeCodRegChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadReg(Key);
  pAtribuiTabelas;
end;

procedure TfrmCadClientes.dbeCodRegKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrRegiao : TConsultasArray;
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE REGIOES *}
  {*************************DP*}
  If fPesqRegiao(Self, dbeCodReg, edtDesReg, Nil, Key, arrRegiao) Then
  Begin
    if fValidaCampos(dbeCodReg, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.btnFichaCliClick(Sender: TObject);
var
  frmEmiFichaCad: TfrmEmiFichaCad;
begin
  inherited;

  Try
    pCriarFormularios(TfrmEmiFichaCad,frmEmiFichaCad);

    If Not fEmptyStr(dbeCodCli.Text) Then
      frmEmiFichaCad.strCodCli := qryTabela.FieldByName('CLI_CODCLI').AsString;

    frmEmiFichaCad.blnAba_Geral            := tbsGeral.TabVisible;
    frmEmiFichaCad.blnResumoFinanceiro     := btnResFin.Enabled;
    frmEmiFichaCad.blnAba_Contatos         := tbsContato.TabVisible;
    frmEmiFichaCad.blnAba_EntregaCobranca  := tbsEntregas.TabVisible;
    frmEmiFichaCad.blnAba_QuadroSocietario := tbsQuadSoc.TabVisible;
    frmEmiFichaCad.blnAba_RefBancaria      := tbsRefBan.TabVisible;
    frmEmiFichaCad.blnAba_RefComercial     := tbsRefCom.TabVisible;
    frmEmiFichaCad.blnAba_InfCrediario     := tbsCrediario.TabVisible;

    frmEmiFichaCad.rdgModelo.ItemIndex := IIF(fEmptyStr(strCliCRM), 0, 1);

    frmEmiFichaCad.ShowModal;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmCadClientes.btnFichaCliClick]');
    End;
  End;
  pFreeAndNil(frmEmiFichaCad);
  pAtribuiTabelas;
end;

procedure TfrmCadClientes.btnForMarNaoPermitidosClick(Sender: TObject);
var
  frmCadCliForMar: TfrmCadCliForMar;
begin
  inherited;

  if (not btnForMarNaoPermitidos.Enabled) or (Not btnForMarNaoPermitidos.Visible) Then
    Exit;

  If (qryTabela.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário escolher um cliente!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmCadCliForMar, frmCadCliForMar);
    Try
      frmCadCliForMar.edtCodCli.Text := dbeCodCli.Text;
      frmCadCliForMar.edtNomCli.Text := dbeNomCli.Text;
      frmCadCliForMar.cdsCliFNP.Data := cdsCliFNP.Data;
      frmCadCliForMar.cdsCliMNP.Data := cdsCliMNP.Data;

      If (qryTabela.State = dsBrowse) Then
        frmCadCliForMar.pDesativarControles
      Else
        pSetFocus(frmCadCliForMar.edtCodFor);

      If frmCadCliForMar.ShowModal = mrOk Then
      Begin
        cdsCliFNP.EmptyDataSet;
        cdsCliMNP.EmptyDataSet;
        cdsCliFNP.Data := frmCadCliForMar.cdsCliFNP.Data;
        cdsCliMNP.Data := frmCadCliForMar.cdsCliMNP.Data;
      End;
    Finally
      pFreeAndNil(frmCadCliForMar);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmCadClientes.btnForMarNaoPermitidosClick]');
    End;
  End;
end;

procedure TfrmCadClientes.dbeFtNfEsEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := dbeFtNfEs.Hint;
  If (Not fEmptyStr(dbeFtNfEs.Text)) Then
    fltFatValAnt := fStrToFloat(dbeFtNfEs.Text)
  Else
    fltFatValAnt := 0.000;
end;

procedure TfrmCadClientes.dbeFtNfEsExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := EmptyStr;
end;

procedure TfrmCadClientes.dbeIDEstrangeiroKeyPress(Sender: TObject;
  var Key: Char);
  Const
    CARACTERES_PERMITIDOS = [':', '.', '+', '-', '/', '(', ')', '0'..'9', 'A'..'Z', 'a'..'z', #8, #13];
begin
  inherited;
  If (Not (dbeIDEstrangeiro.DataSource.DataSet.State In [dsInsert, dsEdit])) Then
    Exit;
  If (CharInSet(Key, CARACTERES_PERMITIDOS)) Then
    Exit;
  Key := #0;
  pMensagemOK('Caracter não permitido!' + sLineBreak + 'Conjuntos permitidos: [A..Z], [a..z], [0..9] e [:.+-/()]');
end;

procedure TfrmCadClientes.dbeIgtVmkEnter(Sender: TObject);
begin
  inherited;
  strIgtVmkAnt := dbeIgtVmk.Text;
end;

procedure TfrmCadClientes.dbeIvaEspEnter(Sender: TObject);
begin
  inherited;
  lblIvaEspInfo.Visible := True;
end;

procedure TfrmCadClientes.dbeIvaEspExit(Sender: TObject);
begin
  inherited;
  lblIvaEspInfo.Visible := False;
end;

procedure TfrmCadClientes.dbeLeiLGPChange(Sender: TObject);
begin
  inherited;
  dbeTerAce.Enabled := dbeLeiLGP.Text = 'S';
  btnArquivosAceiteLGPD.Enabled := dbeLeiLGP.Text = 'S';
  If dbeLeiLGP.Text = 'S' Then
  Begin
    If not fEmptyStr(fCampoTabela('AUTOINCREM','ARQACE',['ACE_CODCLI'],[qryTabela.FieldByName('CLI_CODCLI').AsString])) Then
      lblStatusLGPD.Caption := 'Arquivos Anexados'
    Else
      lblStatusLGPD.Caption := 'Termo Enviado';
  End
  Else
    lblStatusLGPD.Caption := '';
end;

procedure TfrmCadClientes.dbeNacionKeyPress(Sender: TObject; var Key: Char);
  Var
    qryGen: TUniQuery;
    arrSel: TConsultasArray;

begin
  inherited;

  qryGen := fCriaQuery(Self);

  If fPesqPaises(Self, dbeNacion, qryGen, Key, arrSel) Then
  Begin
    If fValidaCampos(dbeNacion, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;

  FreeAndNil(qryGen);

end;

procedure TfrmCadClientes.dbeNatRecEnter(Sender: TObject);
begin
  inherited;
  dbeNatRec.ReadOnly := Not (dbeBenRei.Text = 'S');
end;

procedure TfrmCadClientes.dbeNatRecKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If Not CharInSet(Key, ['0'..'9', #8, #9]) Then
    Key := #0
end;

function TfrmCadClientes.dbeNaturaChamaCadastro(Key: Word): string;
begin
  inherited;

  If fVerificaAcessoSistema(strPermiCadCid) Then
  Begin
    If fChamaCadCid(Key) <> Null Then
      pAtribuiTabelas;
  End;
end;

procedure TfrmCadClientes.dbeNaturaEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'INSERT para fazer um novo cadastro';
end;

procedure TfrmCadClientes.dbeNaturaExit(Sender: TObject);
begin
  inherited;

  pnlInfo.Caption := '';
end;

procedure TfrmCadClientes.dbeNaturaKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, dbeNatura, edtDesNatura, Nil, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(dbeNatura, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.dbeNomCliChange(Sender: TObject);
begin
  inherited;

end;

{**********************************}
{* INICIALIZA VALORES PADRÃO      *}
{*******************************JB*}
procedure TfrmCadClientes.pInicializaValoresPadrao;
Begin
  If (pnlTipCli.Visible And (Not fEmptyStr(fCfgSis('TCLNOV')))) Then
    strTipCliAnt := fCfgSis('TCLNOV');

  strCodFpgAnt := '';
  strNuCnpjAnt := '';
  strConConAnt := '';
  strTabPreAnt := fCfgSis('TABPAD');
  strAltAtiAnt := '999';
  strCodPorAnt1 := '';
  strCodPorAnt2 := '';
  strZonFraAnt := 'N';
  fltLimCreAnt := 0;
  intDesPonAnt := 0;
  strOrgPubAnt := 'N';
  strStatus    := '';
  blnRefCom    := fCfgSis('REFCOM', varBoolean);
  blnCobEnt    := fCfgSis('TELCBR', varBoolean);
  blnCrediario := fCfgSis('INFCRE', varBoolean);
  strCodVenAnt := '';
  strCodRepAnt := '';
  strCepAnt    := '';
  strCepCobAnt := '';
  strCepEntAnt := '';
  strEnvBol    := 'N';
  strBolImp    := 'E';
  
  strNomAnt := '';
  strCanalAnt:= '';
  strCidAnt := '';
  strCgcAnt := '';
  strIesAnt := '';
  strIESUAnt:= '';
  strSufAnt := '';
  strEndAnt := '';
  strNumAnt := '';
  strComAnt := '';
  strBaiAnt := '';
  strCliFidAnt := '';

End;

procedure TfrmCadClientes.pInsereRegEmpCli;
  Var
    qryInsert: TUniQuery;
begin
  qryInsert := fCriaQuery(Nil);
  Try
    qryInsert.SQL.Add('INSERT INTO CCCLIE ');
    qryInsert.SQL.Add('( ');
    qryInsert.SQL.Add('  CCC_CODCLI, ');
    qryInsert.SQL.Add('  CCC_CODEMP, ');
    qryInsert.SQL.Add('  CCC_CONCON, ');
    qryInsert.SQL.Add('  AUTOINCREM ');
    qryInsert.SQL.Add(') ');
    qryInsert.SQL.Add('VALUES (');
    qryInsert.SQL.Add('  :CODCLI, ');
    qryInsert.SQL.Add('  :CODEMP, ');
    qryInsert.SQL.Add('  :CONCON, ');
    qryInsert.SQL.Add('  :AUTOINCREM ');
    qryInsert.SQL.Add(') ');

    qryInsert.ParamByName('CODCLI').AsString := dbeCodCli.Text;
    qryInsert.ParamByName('CODEMP').AsString := cdsEmpCliCodEmp.AsString;
    qryInsert.ParamByName('CONCON').AsString := cdsEmpCliConcon.AsString;
    qryInsert.ParamByName('AUTOINCREM').AsString := cdsEmpCliAUTOINCREM.AsString;
    qryInsert.ExecSQL;
  Finally
    qryInsert.Free;
  End;
end;

procedure TfrmCadClientes.pInsereRegEmpCli_Heranca;
Var
  qryInsert: TUniQuery;
begin

  if not cdsEmpCli.IsEmpty then
  begin

    try

      cdsEmpCli.DisableControls;

      cdsEmpCli.First;
      while not cdsEmpCli.Eof do
      begin

        if (cdsEmpCliCodigo.AsString = '') and (cdsEmpCliAUTOINCREM.AsString = '') then
        begin

          qryInsert := fCriaQuery(Nil);

          {Gravação}
          Try

            qryInsert.SQL.Add('INSERT INTO CCCLIE ');
            qryInsert.SQL.Add('( ');
            qryInsert.SQL.Add('  CCC_CODCLI, ');
            qryInsert.SQL.Add('  CCC_CODEMP, ');
            qryInsert.SQL.Add('  CCC_CONCON, ');
            qryInsert.SQL.Add('  AUTOINCREM ');
            qryInsert.SQL.Add(') ');
            qryInsert.SQL.Add('VALUES (');
            qryInsert.SQL.Add('  :CODCLI, ');
            qryInsert.SQL.Add('  :CODEMP, ');
            qryInsert.SQL.Add('  :CONCON, ');
            qryInsert.SQL.Add('  :AUTOINCREM ');
            qryInsert.SQL.Add(') ');

            qryInsert.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CCCLIE', VS_strCodEmp);
            qryInsert.ParamByName('CODCLI').AsString     := qryTabela.FieldByName('CLI_CODCLI').AsString;
            qryInsert.ParamByName('CODEMP').AsString     := cdsEmpCliCodEmp.AsString;
            qryInsert.ParamByName('CONCON').AsString     := cdsEmpCliConcon.AsString;
            qryInsert.ExecSQL;

          Finally
            qryInsert.Free;
          End;

        end;

        cdsEmpCli.Next;

      end;

    finally
      cdsEmpCli.EnableControls;
    end;

  end;

end;

procedure TfrmCadClientes.dbeSupGerKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSge: TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, dbeSupGer, nil, qryConOpe, Key, arrSge) then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.dbeSupRegKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSre: TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, dbeSupReg, nil, qryConOpe, Key, arrSre) then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadClientes.pAtualizaEnderecoEntrega(blnGravar: Boolean = False);
begin
  FCliEndEntrega.recEndEnt.strCodCli := qryTabela.FieldByName('CLI_CODCLI').AsString;
  FCliEndEntrega.recEndEnt.strNomCli := qryTabela.FieldByName('CLI_NOMCLI').AsString;
  FCliEndEntrega.pSetaVisibilidadeDadosCNPJEntrega;
  If blnGravar Then
  Begin
    FCliEndEntrega.fGravarEnderecosEntregaCliente;
    FCliEndEntrega.pAtualizaEnderecoPadrao(qryTabela);
  End;
  FCliEndEntrega.pIniciaPesquisa;
  pnlEntregas.Enabled := qryTabela.State In [dsEdit,dsInsert];
end;

procedure TfrmCadClientes.pAtualizaEnderecoPadraoEntrega;
begin
  With qryTabela Do
    FCliEndEntrega.pAtualizaEnderecoPadrao(FieldByName('CLI_CODCLI').AsString,
                                           FieldByName('CLI_CODCID').AsString,
                                           FieldByName('CLI_ENDERE').AsString,
                                           FieldByName('CLI_ENDNUM').AsString,
                                           FieldByName('CLI_ENDCOM').AsString,
                                           FieldByName('CLI_BAIRRO').AsString,
                                           FieldByName('CLI_C_E_P_').AsString,
                                           FieldByName('CLI_COBISS').AsString,
                                           FieldByName('CLI_CODOBR').AsString,
                                           FieldByName('CLI_CODART').AsString,
                                           FieldByName('CLI_CODCNO').AsString,
                                           FieldByName('CLI_FONE01').AsString,
                                           FieldByName('CLI_CODREG').AsString,
                                           FieldByName('CLI_CONTAT').AsString,
                                           FieldByName('CLI_INSIMO').AsString,
                                           FieldByName('CLI_CODCIB').AsString);
end;

procedure TfrmCadClientes.pAtualizaFazendas(blnGravar: Boolean = False);
begin
  If (fCfgSis('CADFAZ') = 'N') Then
    Exit;

  FCliFazendas.strCodCli := qryTabela.FieldByName('CLI_CODCLI').AsString;
  If blnGravar Then
  Begin
    FCliFazendas.pGravarFazendasCliente;
  End;
  FCliFazendas.pIniciaPesquisa;
  pnlFazendas.Enabled := qryTabela.State In [dsEdit,dsInsert];
end;

function TfrmCadClientes.fCarregaCNAE(strCodCna: String; var strTipCna: String): String;
  Var
    strSQL   : String;
    qryCadCna: TUniQuery;

Begin
  Try

    qryCadCna := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCNA ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CNA_CODCNA = :CODCNA ';

    With qryCadCna Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL + ' AND CNA_TIPCNA = "SC"');
      ParamByName('CODCNA').AsString := strCodCna;
      Open;

      If IsEmpty Then
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODCNA').AsString := strCodCna;
        Open;
      End;

      If Not IsEmpty Then
      Begin
        Result    := FieldByName('CNA_CODCNA').AsString;
        strTipCna := FieldByName('CNA_TIPCNA').AsString;
        edtDesCna.Text := FieldByName('CNA_NOMCNA').AsString;
      End
      Else
        Result := '';

      Close;
    End;

  Finally
    FreeAndNil(qryCadCna);
  End;
end;

function TfrmCadClientes.fCarregaProdRelacionados(pgbProgresso: TcxProgressBar): Boolean;
  Var
    frmAguarde: TfrmGravando;
begin

  Try
    pLimpaEditsProdutos;
    pLimpaDadosProdutos;

    Try
      pCriarFormularios(TfrmGravando, frmAguarde);
      frmAguarde.fExecutarAcao := fRetornaProdRelacionado;
      frmAguarde.ShowModal;
    Finally
      pFreeAndNil(frmAguarde);
    End;
    Result := True;
  Finally
    cdsCliPro.EnableControls;
  End;

end;

procedure TfrmCadClientes.pgcDadosChange(Sender: TObject);
  Var
    strDireitos: String;
  procedure pSetFocusLoc(Sender: TWinControl);
  begin
    If (qryTabela.State In [dsEdit, dsInsert]) Then
      pSetFocus(Sender);
  end;

begin
  inherited;
  pMontaTitulosPageControl;

//If pgcDados.ActivePage = tbsGeral          Then pSetFocusLoc();
  If pgcDados.ActivePage = tbsGeral2         Then pSetFocusLoc(dbeDescon);
  If pgcDados.ActivePage = tbsContato        Then If pnlAutCtt.Visible Then pSetFocus(chkAutCtt) Else pSetFocus(edtNomCtt);
  If pgcDados.ActivePage = tbsEntregas Then
  Begin
    If Assigned(FCliEndEntrega) Then
    Begin
      FCliEndEntrega.pSetaDadosClienteNovo((qryTabela.State = dsInsert) And (dbeCgcCpf.Text = '1'), fRetSomenteNumeros(dbeNuCpnj.Text), edtEstado.Text);
      FCliEndEntrega.pSetaVisibilidadeDadosCNPJEntrega;
    End;
  End;
  If pgcDados.ActivePage = tbsCbrEnt         Then pSetFocusLoc(dbeCepCob);
  If pgcDados.ActivePage = tbsObservacoes    Then pSetFocusLoc(dbeDouCom);
  If pgcDados.ActivePage = tbsDadosFiscais   Then pSetFocusLoc(dbeRetPCo);
  If pgcDados.ActivePage = tbsQuadSoc        Then pSetFocusLoc(dbeCapSoc);
  If pgcDados.ActivePage = tbsRefBan         Then pSetFocusLoc(dbeNomBc1);
  If pgcDados.ActivePage = tbsRefCom         Then pSetFocusLoc(edtEmpRco);//pSetFocusLoc(dbeNomEm1);
  If pgcDados.ActivePage = tbsCrediario      Then pSetFocusLoc(dbeNomPai);
  If pgcDados.ActivePage = tbsClienteProduto Then pSetFocusLoc(edtCodIte);
  If pgcDados.ActivePage = tbsCliVei         Then pSetFocusLoc(mskPlaVei);
  If pgcDados.ActivePage = tbsCliDiv         Then pSetFocusLoc(edtCodDiv);
  If pgcDados.ActivePage = tbsEcommerce      Then pSetFocusLoc(dbeAltEco);

  If pgcDados.ActivePage = tbsCliCnd Then
  Begin
    If (btnGravar.Enabled) And (Not fVerificaAcessoSistema('CNPCLI', strLoginUsuarioLogado)) Then
      fMensagem('ATENÇÃO!', 'Sem permissão de acesso para a aba Condições de Pagamento!', ['&Ok']);
  End;

  If pgcDados.ActivePage = tbsDadosFiscais Then
  Begin
    dbeIvaEsp.Enabled  := (fUsaCamposIvaEsp) And Not fEmptyStr(dbeNumIES.Text) And (qryTabela.State In [dsEdit, dsInsert]);
    dbeIvaNac.Enabled  := (fUsaCamposIvaEsp) And Not fEmptyStr(dbeNumIES.Text) And (qryTabela.State In [dsEdit, dsInsert]);
    dbeIvaSim.Enabled  := (fUsaCamposIvaEsp) And Not fEmptyStr(dbeNumIES.Text) And (qryTabela.State In [dsEdit, dsInsert]);
    dbeIvaEspCEDEM.Enabled  := (fUsaCamposIvaEsp) And Not fEmptyStr(dbeNumIES.Text) And (qryTabela.State In [dsEdit, dsInsert]);
    dbeIvaNacCEDEM.Enabled  := (fUsaCamposIvaEsp) And Not fEmptyStr(dbeNumIES.Text) And (qryTabela.State In [dsEdit, dsInsert]);
    dbeIvaSimCEDEM.Enabled  := (fUsaCamposIvaEsp) And Not fEmptyStr(dbeNumIES.Text) And (qryTabela.State In [dsEdit, dsInsert]);
    dbeTare__.Enabled  := (edtEstado.Text = 'GO') And Not fEmptyStr(dbeNumIES.Text) And (qryTabela.State In [dsEdit, dsInsert]);
    dbeDefit_.Enabled  := (edtEstado.Text = 'DF') And Not fEmptyStr(dbeNumIES.Text) And (qryTabela.State In [dsEdit, dsInsert]);
    rdgTipLim.Enabled  := (edtEstado.Text = 'DF') And Not fEmptyStr(dbeNumIES.Text) And (qryTabela.State In [dsEdit, dsInsert]);
    dbeSuframa.Enabled := (Pos(edtEstado.Text, 'AC_AM_AP_RO_RR_') > 0)              And (qryTabela.State In [dsEdit, dsInsert]);
    dbeValSuf.Enabled  :=  dbeSuframa.Enabled;
    dbeDesPis.Enabled  := (((dbeZonFra.Text = 'S') And (dbeConsum.Text = 'N')) Or
                          (dbeOrgPub.Text = 'S')) And (qryTabela.State In [dsEdit, dsInsert]);
    dbeDesZon.Enabled  := (dbeZonFra.Text = 'S');

    dbeEntGov.Enabled := (dbeOrgPub.Text = 'S') And (qryTabela.State In [dsEdit, dsInsert]);
    rdgTpOpEg.Enabled := dbeEntGov.Enabled;

    pHabilitaCampoSibIcm;
    pHabilitaCampoSituacaoPisCofins;
    pAtualizaTributacao('CLI_SITP_C');
    pAtualizaTributacao('CLI_SITPCP');
    pAtualizaTributacao('CLI_SITIPI');
    pHabilitaCampoAtoDeclaratorioDF;
  End;

  If fValidarDirEspecificos(strDireitos, strLoginUsuarioLogado, strNomeForm) Then
  Begin
    {* INSERÇÃO *}
    If Pos('I', strDireitos) > 0 Then
      btnIncluirCC.Visible := True
    Else
      btnIncluirCC.Visible := False;

    {* ALTERAÇÃO *}
    If Pos('A', strDireitos) > 0 Then
      btnAlterarCC.Visible := True
    Else
      btnAlterarCC.Visible := False;

    {* EXCLUIR *}
    If Pos('E', strDireitos) > 0 Then
      btnExcluirCC.Visible := True
    Else
      btnExcluirCC.Visible := False;
  End;

  If Not fVerificaAcessoSistema('ALTCCT', strLoginUsuarioLogado) And (pgcDados.ActivePage = tbsCliConconEmp) And tbsCliConconEmp.TabStop Then
  Begin
    fMensagem('ATENÇÃO', 'Usuário sem acesso a esta aba, favor entrar em contato com o responsável!', ['OK']);
    pgcDados.ActivePage := tbsGeral;
    Exit;
  End;

  If (qryTabela.State in [dsInsert, dsEdit]) And (pgcDados.ActivePage = tbsCliConconEmp) And tbsCliConconEmp.TabStop Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário não estar em edição para acessar esta aba!', ['OK']);
    pProximaPagina;
    Exit;
  End;

  If (fEmptyStr(dbeCodCli.Text)) And (pgcDados.ActivePage = tbsCliConconEmp) And tbsCliConconEmp.TabStop Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário carregar um cliente antes de acessar esta aba!', ['OK']);
    pgcDados.ActivePage := tbsGeral;
    Exit;
  End;

  If (pgcDados.ActivePage <> tbsCliConconEmp) And (Pos(strStatusContaContabil, 'INSERT_UPDATE') > 0) Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário cancelar o processo para mudar de aba!', ['OK']);
    pgcDados.ActivePage := tbsCliConconEmp;
    Exit;
  End;
end;

procedure TfrmCadClientes.pgcDadosMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  If (Button = mbRight) And
     (pgcDados.ActivePageIndex > 0) And
     fVerificaAcessoSistema('ORDABA', strLoginUsuarioLogado) Then
  Begin
    mnuOpcoesPageControl.Popup(Self.Left + X, Self.Top + Y);
  End;
end;

procedure TfrmCadClientes.pgcDadosMouseLeave(Sender: TObject);
begin
  inherited;
  pgcDados.Hint := '';
  pgcDados.ShowHint := false;
end;

procedure TfrmCadClientes.pgcDadosMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  tabindex : integer;
begin
  inherited;

  tabindex := pgcDados.IndexOfTabAt(X, Y);
  Try
    If tabindex >= 0 Then
    Begin
      If pgcDados.hint <> pgcDados.Pages[tabindex].hint Then
      Begin
        Application.CancelHint;
        pgcDados.hint := pgcDados.Pages[tabindex].hint;
        pgcDados.ShowHint := True;
      End;
    End;
  Except
  End;
end;

procedure TfrmCadClientes.pStatusTelefone(btnTel: TSpeedButton; blnClick: Boolean = False);
Var
  strCampo: String;
  imgStatus: TBitmap;
begin
  strCampo := btnTel.Hint;

  btnTel.Tag := qryTabela.FieldByName('CLI_' + strCampo).AsInteger;

  If (qryTabela.State in [dsEdit, dsInsert]) Then
  Begin
    If blnClick Then
    Begin
      btnTel.Tag := btnTel.Tag + 1;

      If btnTel.Tag > imglStatus.Count -1 Then
        btnTel.Tag := 0;
    End;

    qryTabela.FieldByName('CLI_' + strCampo).AsInteger := btnTel.Tag;
  End;

  imgStatus := btnTel.Glyph;

  imglStatus.GetBitmap(btnTel.Tag, imgStatus);

  btnTel.Glyph.Assign(imgStatus);

end;

procedure TfrmCadClientes.pUpdateCaption;
begin
  Self.Caption := 'Cadastro de Clientes' + IfThen(not fEmptyStr(dbeCodCli.Text), ' - ' + dbeCodCli.Text, '' ) +
                                           IfThen(not fEmptyStr(dbeNomCli.Text), ' - ' + dbeNomCli.Text, '' ) ;

end;

class procedure TfrmCadClientes.pSetaCamposDefaultCliente(qryCadCli: TUniQuery);
begin
  If (fCfgSis('USATPC', varBoolean) And (Not fEmptyStr(fCfgSis('TCLNOV')))) Then
    qryCadCli.FieldByName('CLI_TIPCLI').AsString := fCfgSis('TCLNOV');

  qryCadCli.FieldByName('CLI_STATUS').AsString   := fCfgSis('STCLNV');

  qryCadCli.FieldByName('CLI_BENCST').AsString   := 'N';
  qryCadCli.FieldByName('CLI_SIBICM').AsString   := 'S';
  qryCadCli.FieldByName('CLI_ZONFRA').AsString   := 'N';
  qryCadCli.FieldByName('CLI_DESZON').AsString   := 'N';
  qryCadCli.FieldByName('CLI_ORGPUB').AsString   := 'N';
  qryCadCli.FieldByName('CLI_ORPUDF').AsString   := 'N';
  qryCadCli.FieldByName('CLI_ORGFDE').AsString   := 'N';
  qryCadCli.FieldByName('CLI_TPOPEG').AsString   := '0';
  qryCadCli.FieldByName('CLI_DTACAD').AsDateTime := VS_Date;
  qryCadCli.FieldByName('CLI_TABPRE').AsString   := fCfgSis('TABPAD');

  If (fCfgSis('CREAUT', varBoolean)) Then
    qryCadCli.FieldByName('CLI_LIMCRE').AsFloat := 0
  Else
    qryCadCli.FieldByName('CLI_LIMCRE').AsFloat := fCfgSis('LIMCRN', varDouble);

  qryCadCli.FieldByName('CLI_PEREMP').AsString := 'N';
  qryCadCli.FieldByName('CLI_CAREXC').AsString   := 'N';

  qryCadCli.FieldByName('CLI_PERAGU').AsString := 'S';
  qryCadCli.FieldByName('CLI_PERPRE').AsString := 'S';
  qryCadCli.FieldByName('CLI_PERFAL').AsString := 'S';

  qryCadCli.FieldByName('CLI_CONSUM').AsString := IIF(fCfgSis('CLICON') = 'E','', fCfgSis('CLICON'));
  qryCadCli.FieldByName('CLI_RETPCO').AsString := fCfgSis('RTPICO');
  qryCadCli.FieldByName('CLI_INDCOM').AsString := 'C';

  qryCadCli.FieldByName('CLI_RETIRF').AsString := 'N';
  qryCadCli.FieldByName('CLI_RETISS').AsString := 'N';
  qryCadCli.FieldByName('CLI_BENREI').AsString := 'N';
  qryCadCli.FieldByName('CLI_ICMREI').AsString := 'N';
  qryCadCli.FieldByName('CLI_SEGSOC').AsString := 'N';
  qryCadCli.FieldByName('CLI_CLUFID').AsString := fCfgSis('CLFDSG');

  qryCadCli.FieldByName('CLI_DESCON').AsFloat  := 0.0;
  qryCadCli.FieldByName('CLI_DESOPE').AsFloat  := 0.0;
  qryCadCli.FieldByName('CLI_CDESPI').AsString := 'N';
  qryCadCli.FieldByName('CLI_ISEIPI').AsString := 'N';
  qryCadCli.FieldByName('CLI_SITIPI').AsString := 'T';
  qryCadCli.FieldByName('CLI_MENIPI').Value    := Null;
  qryCadCli.FieldByName('CLI_CODATI').Value    := Null;
  qryCadCli.FieldByName('CLI_DIFERI').AsString := 'N';
  qryCadCli.FieldByName('CLI_DIF_ST').AsString := 'N';
  qryCadCli.FieldByName('CLI_DIF_PC').AsString := 'N';
  qryCadCli.FieldByName('CLI_REDICM').AsFloat  := 0.0;
  qryCadCli.FieldByName('CLI_IVAESP').AsFloat  := 0.0;    
  qryCadCli.FieldByName('CLI_IVANAC').AsFloat  := 0.0;
  qryCadCli.FieldByName('CLI_IVASIM').AsFloat  := 0.0;
  qryCadCli.FieldByName('CLI_CEDESP').AsFloat  := 0.0;
  qryCadCli.FieldByName('CLI_CEDNAC').AsFloat  := 0.0;
  qryCadCli.FieldByName('CLI_CEDSIM').AsFloat  := 0.0;

  If fEmptyStr(qryCadCli.FieldByName('CLI_CODVEN').AsString) Then
    qryCadCli.FieldByName('CLI_CODVEN').AsString := fCfgSis('VENNOV');

  If fEmptyStr(qryCadCli.FieldByName('CLI_CODREP').AsString) Then
    qryCadCli.FieldByName('CLI_CODREP').AsString := fCfgSis('REPNOV');

  qryCadCli.FieldByName('CLI_PERMFF').AsString := fCfgSis('FFPRAZ');
  qryCadCli.FieldByName('CLI_PERMFV').AsString := fCfgSis('FFPERM');

  qryCadCli.FieldByName('CLI_ID_FO1').AsInteger := 0;
  qryCadCli.FieldByName('CLI_ID_FO2').AsInteger := 0;
  qryCadCli.FieldByName('CLI_ID_FAX').AsInteger := 0;
  qryCadCli.FieldByName('CLI_ID_CEL').AsInteger := 0;

  If fEmptyStr(qryCadCli.FieldByName('CLI_CODVEN').AsString) Then
    qryCadCli.FieldByName('CLI_CODVEN').Value := Null;

  If fEmptyStr(qryCadCli.FieldByName('CLI_CODREP').AsString) Then
    qryCadCli.FieldByName('CLI_CODREP').Value := Null;

  qryCadCli.FieldByName('CLI_QTDDAV').AsInteger:= 0;
  qryCadCli.FieldByName('CLI_PERDPO').AsFloat  := 0.0;
  qryCadCli.FieldByName('CLI_PERCOM').AsFloat  := 0.0;
  qryCadCli.FieldByName('CLI_COMPRO').AsFloat  := 0.0;

  If (fCfgSis('ENVBNC', varBoolean)) Then
    qryCadCli.FieldByName('CLI_ENVBOL').AsString := 'S'
  Else
  qryCadCli.FieldByName('CLI_ENVBOL').AsString := 'N';

  qryCadCli.FieldByName('CLI_BOLIMP').AsString := 'E';
  qryCadCli.FieldByName('CLI_PERMUT').AsString := 'N';
  qryCadCli.FieldByName('CLI_IESUNI').AsString := 'N';
  qryCadCli.FieldByName('CLI_MICEMP').AsString := 'N';
  qryCadCli.FieldByName('CLI_PRORUR').AsString := 'N';
  qryCadCli.FieldByName('CLI_TFTNES').AsString := fCfgSis('SUGFNE');
  qryCadCli.FieldByName('CLI_TIPFAT').AsString := 'A';
  qryCadCli.FieldByName('CLI_REGTRI').AsString := 'P';
  qryCadCli.FieldByName('CLI_REVIST').AsString := 'N';
  qryCadCli.FieldByName('CLI_STREES').AsString := 'N';
  qryCadCli.FieldByName('CLI_TAXENT').AsString := 'N';
  qryCadCli.FieldByName('CLI_INDUST').AsString := 'N';
  qryCadCli.FieldByName('CLI_COBISS').AsString := 'T';
  qryCadCli.FieldByName('CLI_REDISS').AsFloat  := 0.0;
  qryCadCli.FieldByName('CLI_PEBADF').AsFloat  := 0.0;
  qryCadCli.FieldByName('CLI_DIFLST').AsString := 'N';
  qryCadCli.FieldByName('CLI_DIFOPR').AsString := 'N';
  qryCadCli.FieldByName('CLI_REGFIS').AsString := '1';
  qryCadCli.FieldByName('CLI_RECAP_').AsString := 'N';
  qryCadCli.FieldByName('CLI_ATODDF').AsString := 'N';
  qryCadCli.FieldByName('CLI_NOTDES').AsString := 'N';
  qryCadCli.FieldByName('CLI_CLIMON').AsString := 'N';
  qryCadCli.FieldByName('CLI_RECALI').AsString := 'N';
  qryCadCli.FieldByName('CLI_LAYCFF').AsString := 'N';
  qryCadCli.FieldByName('CLI_IGTVMK').AsString := 'N';

  If (fCfgSis('UTDTFE', varBoolean)) Then
  Begin
    qryCadCli.FieldByName('CLI_DMFATU').AsString := '01020304050607080910111213141516171819202122232425262728293031';
    qryCadCli.FieldByName('CLI_DMENTR').AsString := '01020304050607080910111213141516171819202122232425262728293031';
    qryCadCli.FieldByName('CLI_DSFATU').AsString := 'SSSSSSS';
    qryCadCli.FieldByName('CLI_DSENTR').AsString := 'SSSSSSS';
  End;

  qryCadCli.FieldByName('CLI_SITIPI').AsString := 'T';
  qryCadCli.FieldByName('CLI_EXPIND').AsString := 'N';

  qryCadCli.FieldByName('CLI_IMPLAU').AsString := 'N';
  qryCadCli.FieldByName('CLI_ETIDES').AsString := 'N';

  qryCadCli.FieldByName('CLI_DESOST').AsString := 'N';
  qryCadCli.FieldByName('CLI_DESOMT').AsString := '9';
  qryCadCli.FieldByName('CLI_CODEAC').AsString := fCfgSis('CDACLI', varString);

  qryCadCli.FieldByName('CLI_OSNFEN').AsString   := 'N';
  qryCadCli.FieldByName('CLI_AGRUDOC').AsString := 'S';
  qryCadCli.FieldByName('CLI_ENTRET').AsInteger := -1;

  qryCadCli.FieldByName('CLI_RECWPP').AsString := 'S';
end;

function TfrmCadClientes.fAtualizaGrupoRiscoNaRede(strCodGru: String;
  intAtrMax: Integer; strCodRed: String): Boolean;
var
  strSQL: String;
  qryAux: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'UPDATE CADCLI               ';
  strSQL := strSQL + '  SET CLI_CODGRR = :CODGRR, ';
  strSQL := strSQL + '  CLI_ATRMAX = :ATRMAX      ';
  strSQL := strSQL + 'WHERE CLI_CODRED = :CODRED  ';

  qryAux := fCriaQuery();
  Try
    With qryAux Do
    Begin
      SQL.Text := strSQL;
      ParamByName('CODGRR').AsString  := strCodGru;
      ParamByName('ATRMAX').AsInteger := intAtrMax;
      ParamByName('CODRED').AsString  := strCodRed;

      ExecSQL;
    End;
    Result := True;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmCadClientes.fBuscaSituacaoPisCofinsCidade(
  strCodCid: string): string;
var
  qryConsulta: TUniQuery;
begin
  Result := EmptyStr;

  qryConsulta := fCriaQuery;

  try
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT CID_SITP_C');
    qryConsulta.SQL.Add('FROM CADCID');
    qryConsulta.SQL.Add('WHERE CID_CODCID = :CODCID');
    qryConsulta.SQL.Add('AND CID_LIMJUD = "S"');

    qryConsulta.ParamByName('CODCID').AsString := strCodCid;

    qryConsulta.Open;

    if (not qryConsulta.IsEmpty) and (not fEmptyStr(qryConsulta.FieldByName('CID_SITP_C').AsString)) then
    begin
      Result := qryConsulta.FieldByName('CID_SITP_C').AsString;
    end;
  finally
    FreeAndNil(qryConsulta);
  end;
end;

class function TfrmCadClientes.fCadastroRapidoCliente(Var strCodCli: String;
                                                      strNomCli,
                                                      strFanSob,
                                                      strEndere,
                                                      strEndNum,
                                                      strEndCom,
                                                      strBairro,
                                                      strCodCid,
                                                      strCep,
                                                      strFone01,
                                                      strCelula,
                                                      strNum_Rg,
                                                      strI_E_S_,
                                                      strEmail,
                                                      strEmNfe,
                                                      strStatus,
                                                      strContat: String;
                                                      intCgcCpf: Integer;
                                                      strC_G_C_,
                                                      strCodRep,
                                                      strCodVen: String;
                                                      dta_DtaCad: TDate = 0;
                                                      dta_DtaNas: TDate = 0;
                                                      str_Fone02: String = '';
                                                      str_HomePa: String = '';
                                                      str_CodAti: String = '';
                                                      strEmail2 : String = '';
                                                      strNumFax : String = '';
                                                      strObserva: String = '';
                                                      strRgExp  : String = '';
                                                      blnCadCliCon: Boolean = False;
                                                      strCRMFre : String = '';
                                                      strCRMPor : String = '';
                                                      strCRMFai : String = '';
                                                      strCRMCat : String = '';
                                                      strCodReg : String = '';
                                                      strCodCac : String = ''): Boolean;
  Var
    qryCadCli: TUniQuery;
    qryEntCli: TUniQuery;
    qryCliCnd: TUniQuery;
    strCodTra: String;
    blnNovoCliente : Boolean;

  function fProximoCodigo: String;
  begin
    Result := fAtualizaProCod('CADCLI', 'CLI_CODCLI');
  end;

  function fGetCodCliente: String;
  begin
    Result := fInputDialog('Pré-cadastro consumidor', 'Informe o Código do cliente:', '', fRetTamCampo('CADCLI'), 250, ttNumerico, True);
    If fEmptyStr(Result) Then
    Begin
      If fPergunta('O código do cliente não foi informado. Dessa forma, o pré-cadastro do consumidor não será realizado. Deseja prosseguir?') Then
        Exit;
      Result := fGetCodCliente;
    End
    Else
    Begin
      Result := fPadL(Result, fRetTamCampo('CADCLI'), '0');
      If Not fEmptyStr(fCampoTabela('CLI_CODCLI', 'CADCLI', ['CLI_CODCLI'], [Result])) Then
      Begin
        pMensagemOk('Código '+ Result +' já utilizado, favor informar outro.');
        Result := fGetCodCliente;
      End;
    End;
  end;

begin
  Result := False;

  If fEmptyStr(strCodVen) Then Begin
    If (Not blnCadCliCon) Then Begin
      strCodVen := fCfgSis('VENNOV');
    End Else Begin
      If (fCfgSis('VENCON', varString) = '1') Then
        strCodVen := fCfgSis('VENNOV')
      Else
        strCodVen := strLoginUsuarioLogado;
    End;
  End;

  If fEmptyStr(strCodRep) Then Begin
    If (Not blnCadCliCon) Then Begin
      strCodRep := fCfgSis('REPNOV');
    End Else Begin
      If (fCfgSis('REPCON', varString) = '1') Then
        strCodRep := fCfgSis('REPNOV')
      Else
        strCodRep := strLoginUsuarioLogado;
    End;
  End;

  strCodTra := fCfgSis('TRASUG');

  If fEmptyStr(fRetNomVendRep(strCodVen)) Then
  Begin
    fMensagem('','Favor preencher corretamente nas configurações do sistema: "Vendedor para novos clientes".',['&OK']);
    strCodCli := '';
    Exit;
  End;

  If fEmptyStr(fRetNomVendRep(strCodRep)) Then
  Begin
    fMensagem('','Favor preencher corretamente nas configurações do sistema: "Representante para novos clientes".',['&OK']);
    strCodCli := '';
    Exit;
  End;

  blnNovoCliente := False;

  If fEmptyStr(strCodCli) Then
  Begin
    If fUsaProCodigo('CADCLI') Then
      strCodCli := fProximoCodigo
    Else
      strCodCli := fGetCodCliente;

    If fEmptyStr(strCodCli) Then
      Exit;

    blnNovoCliente := True;
  End;

  fStartTransaction;
  Try
    If blnNovoCliente Then
    Begin
      qryCadCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE');
      qryEntCli := fCriarQuery('SELECT * FROM ENTCLI WHERE FALSE');
      qryCliCnd := fCriarQuery('SELECT * FROM CLICND WHERE FALSE');
    End
    Else
    Begin
      qryCadCli := fCriarQuery('SELECT * FROM CADCLI WHERE CLI_CODCLI = ' + QuotedStr(strCodCli));
      qryEntCli := fCriarQuery('SELECT * FROM ENTCLI WHERE ETC_CODCLI = ' + QuotedStr(strCodCli) + ' ORDER BY ETC_SEQIND ASC LIMIT 1 ');
      qryCliCnd := fCriarQuery('SELECT * FROM CLICND WHERE CND_CODCLI = ' + QuotedStr(strCodCli));
    End;

    qryCadCli.Open;
    qryEntCli.Open;
    qryCliCnd.Open;

    If blnNovoCliente Then
    Begin
      qryCadCli.Append;

      qryCadCli.FieldByName('CLI_CODVEN').AsString := strCodVen;
      qryCadCli.FieldByName('CLI_CODREP').AsString := strCodRep;
      qryCadCli.FieldByName('CLI_DTAALT').AsDateTime := VS_Date + fTime();
      qryCadCli.FieldByName('CLI_CODOPE').AsString   := strLoginUsuarioLogado;
      qryCadCli.FieldByName('CLI_OPECAD').AsString   := strLoginUsuarioLogado;

      pSetaCamposDefaultCliente(qryCadCli);
      qryCadCli.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('CADCLI', VS_strCodEmp);
      qryCadCli.FieldByName('CLI_CODEMP').AsString   := VS_strCodEmp;

      qryEntCli.Append;
      qryEntCli.FieldByName('AUTOINCREM').Value := fRetAutoIncrem('ENTCLI', VS_strCodEmp);
      qryEntCli.FieldByName('ETC_SEQIND').Value := 0;
      qryEntCli.FieldByName('ETC_SEQVIS').Value := 0;
      qryEntCli.FieldByName('ETC_ENDFAT').Value := 'S';
      qryEntCli.FieldByName('ETC_CODCLI').Value := strCodCli;
    End
    Else
    Begin
      qryCadCli.Edit;
      qryEntCli.Edit;
    End;

    qryCadCli.FieldByName('CLI_CODCLI').AsString  := strCodCli;
    qryCadCli.FieldByName('CLI_NOMCLI').AsString  := strNomCli;
    qryCadCli.FieldByName('CLI_FANSOB').AsString  := strNomCli;
    qryCadCli.FieldByName('CLI_ENDERE').AsString  := strEndere;
    qryCadCli.FieldByName('CLI_ENDNUM').AsString  := strEndNum;
    qryCadCli.FieldByName('CLI_ENDCOM').AsString  := strEndCom;
    qryCadCli.FieldByName('CLI_BAIRRO').AsString  := strBairro;
    qryCadCli.FieldByName('CLI_CODCID').AsString  := strCodCid;
    qryCadCli.FieldByName('CLI_C_E_P_').AsString  := fTiraCaracEspeciais(strCep);
    qryCadCli.FieldByName('CLI_FONE01').AsString  := fTiraCaracEspeciais(strFone01);
    qryCadCli.FieldByName('CLI_NUMR_G').AsString  := strNum_Rg;
    qryCadCli.FieldByName('CLI_RG_EXP').AsString  := strRgExp;
    qryCadCli.FieldByName('CLI_I_E_S_').AsString  := strI_E_S_;
    qryCadCli.FieldByName('CLI_EMAIL_').AsString  := strEmail;
    qryCadCli.FieldByName('CLI_EMAIL2').AsString  := strEmail2;
    qryCadCli.FieldByName('CLI_CGCCPF').AsInteger := intCgcCpf;

    IF intCgcCpf = 2 Then
      qryCadCli.FieldByName('CLI_IESUNI').AsString := 'S';
    qryCadCli.FieldByName('CLI_C_G_C_').AsString  := strC_G_C_;

    If Not fEmptyStr(strStatus) Then
      qryCadCli.FieldByName('CLI_STATUS').AsString  := strStatus;

    If Not fEmptyStr(strEmNfe) Then
      qryCadCli.FieldByName('CLI_EMAIL3').AsString  := strEmNfe;

    If Not fEmptyStr(strContat) Then
      qryCadCli.FieldByName('CLI_CONTAT').AsString  := strContat;

    If Not fEmptyStr(strFanSob) Then
      qryCadCli.FieldByName('CLI_FANSOB').AsString  := strFanSob;

    If Not fEmptyStr(strCelula) Then
      qryCadCli.FieldByName('CLI_CELULA').AsString  := fTiraCaracEspeciais(strCelula);

    qryCadCli.FieldByName('CLI_DTACAD').AsDateTime:= dta_DtaCad;
    qryCadCli.FieldByName('CLI_NASCIM').AsDateTime:= dta_DtaNas;
    qryCadCli.FieldByName('CLI_FONE02').AsString  := str_Fone02;
    qryCadCli.FieldByName('CLI_HOMEPA').AsString  := str_HomePa;

    if qryCadCli.FieldByName('CLI_DTACAD').AsDateTime <= 0 then
      qryCadCli.FieldByName('CLI_DTACAD').AsDateTime := fNow();

    if qryCadCli.FieldByName('CLI_NASCIM').AsDateTime <= 0 Then
      qryCadCli.FieldByName('CLI_NASCIM').Clear;

    if not fEmptyStr(str_CodAti) then
      qryCadCli.FieldByName('CLI_CODATI').AsString := str_CodAti;

    If Not fEmptyStr(strCodCac) then
      qryCadCli.FieldByName('CLI_CODCAC').AsString := strCodCac;

    If Not fEmptyStr(fCfgSis('CTACLI')) Then
      qryCadCli.FieldByName('CLI_CONCON').AsString := fCfgSis('CTACLI');

    qryCadCli.FieldByName('CLI_F_A_X_').AsString := strNumFax;
    qryCadCli.FieldByName('CLI_OBSERV').AsString := strObserva;

    qryCadCli.FieldByName('CLI_CRMFRE').Clear;
    If Not fEmptyStr(strCRMFre) Then
      qryCadCli.FieldByName('CLI_CRMFRE').AsString := strCRMFre;

    qryCadCli.FieldByName('CLI_CRMPOR').Clear;
    If Not fEmptyStr(strCRMPor) Then
      qryCadCli.FieldByName('CLI_CRMPOR').AsString := strCRMPor;

    qryCadCli.FieldByName('CLI_CRMFAI').Clear;
    If Not fEmptyStr(strCRMFai) Then
      qryCadCli.FieldByName('CLI_CRMFAI').AsString := strCRMFai;

    qryCadCli.FieldByName('CLI_CRMCAT').Clear;
    If Not fEmptyStr(strCRMCat) Then
      qryCadCli.FieldByName('CLI_CRMCAT').AsString := strCRMCat;

    if not fEmptyStr(strCodReg) then
      qryCadCli.FieldByName('CLI_CODREG').AsString := strCodReg;

    qryCadCli.Post;

    qryEntCli.FieldByName('ETC_CIDENT').AsString := strCodCid;
    qryEntCli.FieldByName('ETC_ENDENT').AsString := strEndere+IIF(fEmptyStr(strEndNum), '', ', '+strEndNum);
    qryEntCli.FieldByName('ETC_BAIENT').AsString := strBairro;
    qryEntCli.FieldByName('ETC_CEPENT').AsString := fTiraCaracEspeciais(strCep);
    qryEntCli.FieldByName('ETC_TELENT').AsString := fTiraCaracEspeciais(strFone01);
    qryEntCli.FieldByName('ETC_CONENT').AsString := strEndCom;

    If Not fEmptyStr(strCodTra) then
      qryEntCli.FieldByName('ETC_CODTRA').AsString := strCodTra;

    If Not fEmptyStr(strCodReg) then
      qryEntCli.FieldByName('ETC_CODREG').AsString := strCodReg;

    qryEntCli.Post;

    If (blnNovoCliente) And (fCfgSis('USACND', VarBoolean)) Then
      pCarregaCondicaoPagamentoRapidoCFG(str_CodAti, strCodCli, qryCliCnd);

    If (blnNovoCliente) And (fCfgSis('PNVCLI') <> '') and (fCfgSis('PRECAD') = 'S') Then
      pCarregaProfissionalCFG(strCodCli);

    FreeAndNil(qryEntCli);
    FreeAndNil(qryCadCli);
    FreeAndNil(qryCliCnd);

    Result := True;
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.message, '');
    End;
  End;
end;

procedure TfrmCadClientes.pEditaRegEmpCli;
  Var
    qryUpdate: TUniQuery;
begin
  qryUpdate := fCriaQuery(Nil);
  Try
    qryUpdate.SQL.Add('UPDATE CCCLIE');
    qryUpdate.SQL.Add('SET');
    qryUpdate.SQL.Add('  CCC_CODEMP = :CODEMP, ');
    qryUpdate.SQL.Add('  CCC_CONCON = :CONCON ');
    qryUpdate.SQL.Add('WHERE AUTOINCREM = :AUTOINCREM ');
    qryUpdate.SQL.Add('  AND CCC_CODCLI = :CODCLI ');

    qryUpdate.ParamByName('CODEMP').AsString := cdsEmpCliCodEmp.AsString;
    qryUpdate.ParamByName('CONCON').AsString := cdsEmpCliConcon.AsString;
    qryUpdate.ParamByName('AUTOINCREM').AsString := cdsEmpCliAUTOINCREM.AsString;
    qryUpdate.ParamByName('CODCLI').AsString := cdsEmpCliCodigo.AsString;
    qryUpdate.ExecSQL;
  Finally
    qryUpdate.Free;
  End;
end;

procedure TfrmCadClientes.pEnviaContatoCitelDesk;
const
  TABELA_CADCLI = 'CADCLI';
  TABELA_CLICTT = 'CLICTT';
var
  cdsContatos: TUniClientDataSet;
begin
  try
    cdsContatos := TControllerAddOrEditContact.fCriaCdsContatos;
    try
      cdsContatos.Append;
      cdsContatos.FieldByName('TABELA').AsString := TABELA_CADCLI;
      cdsContatos.FieldByName('MARDES').AsString := 'M';
      cdsContatos.FieldByName('AUTOINCREM').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      cdsContatos.FieldByName('CTT_ENDERE').AsString := qryTabela.FieldByName('CLI_ENDERE').AsString;
      cdsContatos.FieldByName('CTT_NOMCID').AsString := edtNomCid.Text;
      cdsContatos.FieldByName('CTT_ESTADO').AsString := edtEstado.Text;
      cdsContatos.FieldByName('CTT_PAIS__').AsString := fRetNomePaisCidade(dbeCodCid.Text);

      if fEmptyStr(cdsContatos.FieldByName('CTT_PAIS__').AsString) then
        cdsContatos.FieldByName('CTT_PAIS__').AsString := 'BRASIL';

      cdsContatos.FieldByName('CTT_CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
      cdsContatos.FieldByName('CTT_NOMCTT').AsString := qryTabela.FieldByName('CLI_NOMCLI').AsString;
      cdsContatos.FieldByName('CTT_DOCUME').AsString := qryTabela.FieldByName('CLI_C_G_C_').AsString;
      cdsContatos.FieldByName('CTT_CELULA').AsString := qryTabela.FieldByName('CLI_CELULA').AsString;
      cdsContatos.FieldByName('CTT_EMAIL_').AsString := qryTabela.FieldByName('CLI_EMAIL_').AsString;
      cdsContatos.FieldByName('CTT_IDEAGE').AsExtended := fRetIdCitelDeskOperador(qryTabela.FieldByName('CLI_CODVEN').AsString);
      cdsContatos.FieldByName('CTT_IDCIDE').AsExtended := fRetIdCitelDeskCliente(qryTabela.FieldByName('CLI_CODCLI').AsString);
      cdsContatos.Post;

      cdsCliCtt.First;
      while not cdsCliCtt.Eof do
      begin
        cdsContatos.Append;
        cdsContatos.FieldByName('TABELA').AsString := TABELA_CLICTT;
        cdsContatos.FieldByName('MARDES').AsString := 'M';
        cdsContatos.FieldByName('AUTOINCREM').AsString := cdsCliCtt.FieldByName('AUTOINCREM').AsString;
        cdsContatos.FieldByName('CTT_ENDERE').AsString := cdsCliCtt.FieldByName('CLI_ENDCTT').AsString;
        cdsContatos.FieldByName('CTT_NOMCID').AsString := cdsCliCtt.FieldByName('CLI_NOMCID').AsString;
        cdsContatos.FieldByName('CTT_ESTADO').AsString := cdsCliCtt.FieldByName('CLI_ESTCID').AsString;
        cdsContatos.FieldByName('CTT_PAIS__').AsString := fRetNomePaisCidade(cdsCliCtt.FieldByName('CLI_CODCID').AsString);

        if fEmptyStr(cdsContatos.FieldByName('CTT_PAIS__').AsString) then
          cdsContatos.FieldByName('CTT_PAIS__').AsString := 'BRASIL';

        cdsContatos.FieldByName('CTT_CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
        cdsContatos.FieldByName('CTT_NOMCTT').AsString := cdsCliCtt.FieldByName('CLI_NOMCTT').AsString;
        cdsContatos.FieldByName('CTT_DOCUME').AsString := cdsCliCtt.FieldByName('CLI_CPFCTT').AsString;
        cdsContatos.FieldByName('CTT_CELULA').AsString := cdsCliCtt.FieldByName('CLI_CELCTT').AsString;
        cdsContatos.FieldByName('CTT_EMAIL_').AsString := cdsCliCtt.FieldByName('CLI_EMACTT').AsString;
        cdsContatos.FieldByName('CTT_IDEAGE').AsExtended := fRetIdCitelDeskOperador(qryTabela.FieldByName('CLI_CODVEN').AsString);
        cdsContatos.FieldByName('CTT_IDCIDE').AsExtended := fRetIdCitelDeskContatoCliente(cdsCliCtt.FieldByName('AUTOINCREM').AsString);
        cdsContatos.Post;

        cdsCliCtt.Next;
      end;

      cdsContatos.Filtered := False;
      cdsContatos.Filter := 'MARDES = '+QuotedStr('M');
      cdsContatos.Filtered := True;

      TControllerAddOrEditContact.pAddOrEditContact(cdsContatos);

    finally
      cdsContatos.Filtered := False;
      cdsContatos.Filter := EmptyStr;

      FreeAndNil(cdsContatos);
    end;
  except
    on E: Exception do
      pMensagensErro(E.Message,'[TfrmCadClientes.pEnviaContatoCitelDesk]');
  end;
end;

procedure TfrmCadClientes.pEnviaEdicao;
begin
  cdsEmpCli.Edit;
  cdsEmpCliCodEmp.AsString := edtCodEmp.Text;
  cdsEmpCliNomEmp.AsString := edtNomEmp.Text;
  cdsEmpCliConcon.AsString := edtConcon.Text;
  cdsEmpCli.Post;

  Try
    fStartTransaction;
    pEditaRegEmpCli;
    fCommit;

    strStatusContaContabil := 'EDITADO';
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFornecedores.btnGravarCCClick]');
    End;
  End;

  pLimpaCamposEmpCli;
end;

procedure TfrmCadClientes.pEnviaGravacao;
begin
  cdsEmpCli.Append;
  cdsEmpCliCodigo.AsString := dbeCodCli.Text;
  cdsEmpCliCodEmp.AsString := edtCodEmp.Text;
  cdsEmpCliNomEmp.AsString := edtNomEmp.Text;
  cdsEmpCliConcon.AsString := edtConcon.Text;
  cdsEmpCliAUTOINCREM.AsString := fRetAutoIncrem('CCCLIE', VS_strCodEmp);
  cdsEmpCli.Post;

  Try
    fStartTransaction;
    pInsereRegEmpCli;
    fCommit;

    strStatusContaContabil := 'GRAVADO';
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFornecedores.btnGravarCCClick]');
    End;
  End;

  pLimpaCamposEmpCli;
end;

procedure TfrmCadClientes.pEstadoEmissaoCPF;
  var
    chrDigEst: Char;
begin
  edtEstEmiCpf.Clear;

  If (dbeCgcCpf.Text = '2') And fValidaCPF(IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text)) Then
  Begin
    If dbeCpfDev.Visible Then
      chrDigEst := dbeCpfDev.Text[9]
    Else
      chrDigEst := dbeNuCpnj.Text[9];


    Case chrDigEst Of
      '0' : edtEstEmiCpf.Text := fRetNomeEstado('RS');
      '1' : edtEstEmiCpf.Text := 'DF/GO/MT/MS/TO';
      '2' : edtEstEmiCpf.Text := 'AC/AP/AM/RO/RR/PA';
      '3' : edtEstEmiCpf.Text := 'CE/PI/MA';
      '4' : edtEstEmiCpf.Text := 'AL/PB/PE/RN';
      '5' : edtEstEmiCpf.Text := 'BA/SE';
      '6' : edtEstEmiCpf.Text := fRetNomeEstado('MG');
      '7' : edtEstEmiCpf.Text := 'ES/RJ';
      '8' : edtEstEmiCpf.Text := fRetNomeEstado('SP');
      '9' : edtEstEmiCpf.Text := 'PR/SC';
    End;
  End;

end;

procedure TfrmCadClientes.pExcluiVendAnteriores(strCodCli: String);
  Var
    strSQL: String;
    qryDel: TUniQuery;
begin

  Try

    qryDel := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'DELETE   ';
    strSQL := strSQL + ' FROM    ';
    strSQL := strSQL + '  CLIVEN ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  CVE_CODCLI = :CODCLI ';

    With qryDel Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      ExecSQL;
    End;

    FreeAndNil(qryDel);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadClientes.pExcluiVendAnteriores]');
    End;
  End;
end;

function TfrmCadClientes.fPisCofinsDaCidadeSuspensa(strCodCid: string): Boolean;
var
  qryCidade: TUniQuery;
begin
  Result := False;

  if (fEmptyStr(strCodCid)) then
  begin
    Exit;
  end;

  qryCidade := fCriaQuery;

  try
    qryCidade.Close;
    qryCidade.SQL.Clear;
    qryCidade.SQL.Add('SELECT CID_LIMJUD');
    qryCidade.SQL.Add('FROM CADCID');
    qryCidade.SQL.Add('WHERE CID_CODCID = :CODCID');
    qryCidade.ParamByName('CODCID').AsString := strCodCid;
    qryCidade.Open;

    if (not qryCidade.IsEmpty) and (qryCidade.FieldByName('CID_LIMJUD').AsString = 'S') then
    begin
      Result := True;
    end;
  finally
    FreeAndNil(qryCidade);
  end;
end;

function TfrmCadClientes.fProdutoJaInserido(strCodPro: String; blnAltera: Boolean): Boolean;
Var
  cdsProTmp: TUniClientDataSet;
begin

  Result := False;

  Try
    cdsProTmp := TUniClientDataSet.Create(Self);
    cdsProTmp.Data := cdsCliPro.Data;

    If (cdsProTmp.Locate('CODPRO', strCodPro, [])) Then
    Begin
      If (Not blnAltera) Or ((cdsProTmp.RecNo) <> (cdsCliPro.RecNo)) Then
        Result := True;
    End;

  Finally
    FreeAndNil(cdsProTmp);
  End;

end;

procedure TfrmCadClientes.pBuscaCliente(strCodCliente: String = '');
  Var
    chrKey: Char;
    arrClientes: TConsultasArray;

  function fSetaClienteInformado: Boolean;
  begin
    Result := False;
    If Not fEmptyStr(strCodCliente) Then
    Begin
      pPesquisaCadCli(qryTabela, qryTabela, strCodCliente, False);
      Result := True;
    End;
  end;

begin
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  chrKey := '/';

  If fSetaClienteInformado Or
     fPesqCliente(conCliSimples, Self, Nil, Nil, qryTabela, chrKey, arrClientes) Then
  Begin
    If Not qryTabela.IsEmpty Then
    Begin
      pCarregaContatos(qryTabela.FieldByName('CLI_CODCLI').AsString);
      pCarregaProdutos(qryTabela.FieldByName('CLI_CODCLI').AsString);
      pCarregaVeiculos(qryTabela.FieldByName('CLI_CODCLI').AsString);
      pCarregaRefComerciais(qryTabela.FieldByName('CLI_CODCLI').AsString);
      pCarregaCliVendedores(qryTabela.FieldByName('CLI_CODCLI').AsString);
      pCarregaCliForMarNaoPermitidos(qryTabela.FieldByName('CLI_CODCLI').AsString);
      pCarregaSocios(qryTabela.FieldByName('CLI_CODCLI').AsString);
      pCarregaBeneficios(qryTabela.FieldByName('CLI_CODCLI').AsString);
      pCalculaTotalRenda(nil);
      pCarregaPlanoDeContasPorEmpresa('CLINCO', qryTabela.FieldByName('CLI_CODCLI').AsString, FcdsNCO);
    End
    Else
    Begin
      If (Assigned(lstContatos)) Then
        lstContatos.Clear;
      cdsCliCtt.EmptyDataSet;

      pLimpaDadosProdutos;

      If (Assigned(lstVeiculos)) Then
        lstVeiculos.Clear;
      cdsCliVei.EmptyDataSet;

      If Assigned(cdsCliVendedores) And cdsCliVendedores.Active Then
        cdsCliVendedores.EmptyDataSet;

      If Assigned(cdsCliVendedoresMar) And cdsCliVendedoresMar.Active Then
        cdsCliVendedoresMar.EmptyDataSet;

      If Assigned(cdsCliFNP) And cdsCliFNP.Active Then
        cdsCliFNP.EmptyDataSet;

      If Assigned(cdsCliMNP) And cdsCliMNP.Active Then
        cdsCliMNP.EmptyDataSet;

      cdsCliRco.EmptyDataSet;

    End;

    pCarregaDadosAdicionais;
    pCarregaCategoriaCrm;
    pCarregaFornecedorCrm;
    pCarregaFrequenciaCrm;
    pCarregaFaixaCrm;
    pCarregaPorteCrm;
    pOrgaoPublicoForaDoEstado;

    pgcDados.ActivePageIndex := 0;

    pVerificaDireitosDadosPrincipais;
    pVerificaDireitosDadosRetencao;

    If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
      pSetFocus(btnAlterar);
  End;

  If blnCrediario Then
    pQueryInfCreAfterScroll(Nil);
end;

procedure TfrmCadClientes.pMontaTitulosPageControl;
  Var
    strCaption: String;
    intIndex  : Integer;
    intPosSep : Integer;
begin
  pAtribuiTags;

  For intIndex := 0 To pgcDados.PageCount -1 Do
  Begin
    strCaption := pgcDados.Pages[intIndex].Caption;
    intPosSep  := Pos('-', strCaption);

    strCaption := IntToStr(pgcDados.Pages[intIndex].Tag) + ' ' +
                  MidStr(strCaption, intPosSep, 255);

    pgcDados.Pages[intIndex].Caption := strCaption;
  End;
End;

procedure TfrmCadClientes.pIncluiCliDepProd;
Begin
  With cdsCliDep Do
  Begin
    If (Not fEmptyStr(edtCodDep.Text)) And fValidaCampos(edtCodDep, True) Then
    Begin
      If Not Locate('DEP_CODDEP', edtCodDep.Text, []) Then
      Begin
        Insert;
        FieldByName('DEP_CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
        FieldByName('DEP_CODDEP').AsString := edtCodDep.Text;
        FieldByName('DEP_DESCRI').AsString := edtDesDep.Text;
        Post;
      End;
      edtCodDep.Clear;
      edtDesDep.Clear;
      pSetFocus(edtCodDep);
    End
  end;
End;

procedure TfrmCadClientes.pIncluiCondicaoPagamento;
  Var
    blnVazio: Boolean;
Begin
  With cdsCliCnd Do
  Begin
    blnVazio := IsEmpty;
    If pnlCodCnd.Visible Then
    Begin
      If (Not fEmptyStr(edtCodCnd.Text)) And fValidaCampos(edtCodCnd, True) Then
      Begin

        If Not Locate('CND_CODCND', edtCodCnd.Text, []) Then
        Begin
          if not fValidaCndCli(edtCodCnd.Text) then
            Exit;

          Insert;
          FieldByName('CND_CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
          FieldByName('CND_CODCND').AsString := edtCodCnd.Text;
          FieldByName('CND_DESCRI').AsString := edtDesCnd.Text;
          FieldByName('CND_SUGEST').AsString := IfThen(blnVazio, 'S', 'N');
          Post;
        End;

        edtCodCnd.Clear;
        edtDesCnd.Clear;

        pSetFocus(edtCodCnd);
      End
    End Else
    Begin

      If (Not fEmptyStr(fTiraCaracEspeciais(mskConPag.Text))) Then
      Begin

        If Not Locate('CND_CNDPAG', fTiraCaracEspeciais(mskConPag.Text), []) Then
        Begin
          Insert;
          FieldByName('CND_CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
          FieldByName('CND_CNDPAG').AsString := fTiraCaracEspeciais(mskConPag.Text);
          FieldByName('CND_SUGEST').AsString := IfThen(blnVazio, 'S', 'N');
          Post;
        End;

        mskConPag.Clear;
        pSetFocus(mskConPag);
      End;

    End;
  End;

End;

procedure TfrmCadClientes.pIncluiProfissional;
  Var
    blnVazio: Boolean;

  Function fRetAtividadeDoProfissional(strCodDiv:String): String;
    Var
      qryAux: TUniQuery;
  Begin
    Result := EmptyStr;
    Try
      qryAux := fCriaQuery(Self);

      With qryAux Do
      Begin
        SQL.Clear;
        SQL.Add('SELECT ');
        SQL.Add('  CONCAT(A.ATI_CODATI,"-",A.ATI_DESATI) AS ATIVID ');
        SQL.Add('FROM   ');
        SQL.Add('  CADDIV D INNER JOIN CADATI A ON D.DIV_CODATI = A.ATI_CODATI ');
        SQL.Add('WHERE  ');
        SQL.Add('  D.DIV_CODDIV = :CODDIV ');
        ParamByName('CODDIV').AsString := strCodDiv;
        Open;

        If Not IsEmpty Then
          Result := FieldByName('ATIVID').AsString;
      End;

    Finally
      FreeAndNil(qryAux);
    End;
  End;

Begin
  With cdsCliDiv Do
  Begin
    blnVazio := IsEmpty;
    If pnlCodDiv.Visible Then
    Begin
      If (Not fEmptyStr(edtCodDiv.Text)) And fValidaCampos(edtCodDiv, True) Then
      Begin

        If Not Locate('DIV_CODDIV', edtCodDiv.Text, []) Then
        Begin
          Insert;
          FieldByName('DIV_CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
          FieldByName('DIV_CODDIV').AsString := edtCodDiv.Text;
          FieldByName('DIV_NOMDIV').AsString := edtNomDiv.Text;
          FieldByName('DIV_NOMATI').AsString := fRetAtividadeDoProfissional(edtCodDiv.Text);
          FieldByName('DIV_SUGEST').AsString := IfThen(blnVazio, 'S', 'N');
          Post;
        End;

        edtCodDiv.Clear;
        edtNomDiv.Clear;

        pSetFocus(edtCodDiv);
      End
    End;
  End;
End;

procedure TfrmCadClientes.pIndComGetText(Field: TField; var Text: String;
  DisplayText: Boolean);
begin
  If Field.AsString = 'I' Then
    Text := 'Industrialização'
  Else If Field.AsString = 'C' Then
    Text := 'Comercialização';
end;

procedure TfrmCadClientes.pIndComSetText(Field: TField; const Text: String);
begin
  If Text = 'Industrialização' Then
    Field.AsString := 'I'
  Else If Text = 'Comercialização' Then
    Field.AsString := 'C';
end;

procedure TFrmCadClientes.pCarregaDiaFixo;
  Var
    intDiaFix: Integer;
    strDiaFix: String;
begin
  strDiaFix := fPadR(qryTabela.FieldByName('CLI_DIAFIX').AsString,
                     lstDiaFix.Items.Count, 'N');

  For intDiaFix := 0 To lstDiaFix.Items.Count -1 Do
    lstDiaFix.Checked[intDiaFix] := (strDiaFix[Succ(intDiaFix)] = 'S');
end;

procedure TFrmCadClientes.pCarregaDiaSemFat;
  Var
    intDiaFix: Integer;
    strDiaFixFat: String;
begin
  If (Not blnUTDTFE) Then
    Exit;

  strDiaFixFat := fPadR(qryTabela.FieldByName('CLI_DSFATU').AsString, lstDiaSemPerFat.Items.Count, 'N');
  For intDiaFix := 0 To lstDiaSemPerFat.Items.Count -1 Do
    lstDiaSemPerFat.Checked[intDiaFix] := (strDiaFixFat[Succ(intDiaFix)] = 'S');
end;

procedure TfrmCadClientes.pCarregaDiaFixoEntFat;
  Var
    intIndex: Integer;
    strDiaMesEnt: String;
    strDiaMesFat: String;
begin
  If (Not blnUTDTFE) Then
    Exit;

  strDiaMesEnt := fTransform(qryTabela.FieldByName('CLI_DMENTR').AsString, 2);
  strDiaMesFat := fTransform(qryTabela.FieldByName('CLI_DMFATU').AsString, 2);

  For intIndex := 0 To 30 Do
  Begin
    lstDiaMesPerFat.Checked[intIndex] := Pos(lstDiaMesPerFat.Items[intIndex], strDiaMesFat) > 0;
    lstDiaMesPerEnt.Checked[intIndex] := Pos(lstDiaMesPerEnt.Items[intIndex], strDiaMesEnt) > 0;
  End;
end;

procedure TfrmCadClientes.pHabilitaControleData;
begin
  If (Not blnUTDTFE) Then
    Exit;

  lstDiaSemPerFat.Enabled := True;
  cxgDiaSemEnt.Enabled := True;
  lstDiaMesPerFat.Enabled := True;
  lstDiaMesPerEnt.Enabled := True;
end;

procedure TfrmCadClientes.pCarregaDiaFixoMes;
  Var
    intIndex: Integer;
    strDiaMes: String;
begin
  strDiaMes := fTransform(qryTabela.FieldByName('CLI_DIAMES').AsString, 2);

  For intIndex := 0 To 30 Do
    lstDiaMes.Checked[intIndex] := Pos(lstDiaMes.Items[intIndex], strDiaMes) > 0;
end;

procedure TfrmCadClientes.pCarregaDiaVisitas;
begin
  chkSeg.Checked := Copy(qryTabela.FieldByName('CLI_DIAVIS').AsString,1,1) = 'S';
  chkTer.Checked := Copy(qryTabela.FieldByName('CLI_DIAVIS').AsString,2,1) = 'S';
  chkQua.Checked := Copy(qryTabela.FieldByName('CLI_DIAVIS').AsString,3,1) = 'S';
  chkQui.Checked := Copy(qryTabela.FieldByName('CLI_DIAVIS').AsString,4,1) = 'S';
  chkSex.Checked := Copy(qryTabela.FieldByName('CLI_DIAVIS').AsString,5,1) = 'S';
  chkSab.Checked := Copy(qryTabela.FieldByName('CLI_DIAVIS').AsString,6,1) = 'S';

  If qryTabela.FieldByName('CLI_PERDVI').AsString = 'S' Then
    rdbSemanal.Checked := True
  Else If qryTabela.FieldByName('CLI_PERDVI').AsString = 'Q' Then
    rdbQuinzenal.Checked := True
  Else If qryTabela.FieldByName('CLI_PERDVI').AsString = 'M' Then
    rdbMensal.Checked := True;        
end;

procedure TFrmCadClientes.pGravaDiaFixo;
  Var
    intDiaFix: Integer;
    strDiaFix: String;
begin
  strDiaFix := '';
  For intDiaFix := 0 To lstDiaFix.Items.Count -1 Do
    strDiaFix := strDiaFix + IfThen(lstDiaFix.Checked[intDiaFix], 'S', 'N');
  qryTabela.FieldByName('CLI_DIAFIX').AsString := strDiaFix;
end;

procedure TFrmCadClientes.pGravaDiaSemFat;
  Var
    intDiaFix: Integer;
    strDiaFixFat: String;
begin
  If (Not blnUTDTFE) Then
    Exit;

  strDiaFixFat := '';
  For intDiaFix := 0 To lstDiaSemPerFat.Items.Count -1 Do
    strDiaFixFat := strDiaFixFat + IfThen(lstDiaSemPerFat.Checked[intDiaFix], 'S', 'N');
  qryTabela.FieldByName('CLI_DSFATU').AsString := strDiaFixFat;
end;

procedure TFrmCadClientes.pGravaHraSemEnt;
  Var
    qryCliHse : TUniQuery;
begin
  If (Not blnUTDTFE) Then
    Exit;

  qryCliHse := fCriaQuery(Self);
  Try
    qryCliHse.SQL.Text := 'DELETE FROM CLIHSE WHERE HSE_CODCLI = ' + QuotedStr(qryTabela.FieldByName('CLI_CODCLI').AsString);
    qryCliHse.ExecSQL;

    qryCliHse.SQL.Text := 'SELECT * FROM CLIHSE WHERE FALSE';
    qryCliHse.Open;

    cdsDtaPerEnt.First;
    While Not cdsDtaPerEnt.Eof Do
    Begin
      If ((Not cdsDtaPerEnt.FieldByName('HRAINI').IsNull) And (Not cdsDtaPerEnt.FieldByName('HRAFIN').IsNull)) Or
         ((Not cdsDtaPerEnt.FieldByName('HRAIN2').IsNull) And (Not cdsDtaPerEnt.FieldByName('HRAFI2').IsNull)) Or
         ((Not cdsDtaPerEnt.FieldByName('HRAIN3').IsNull) And (Not cdsDtaPerEnt.FieldByName('HRAFI3').IsNull)) Then
      Begin
        qryCliHse.Append;
        qryCliHse.FieldByName('HSE_CODCLI').AsString  := qryTabela.FieldByName('CLI_CODCLI').AsString;
        qryCliHse.FieldByName('HSE_SEMANA').AsString  := cdsDtaPerEnt.FieldByName('SEMANA').AsString;
        qryCliHse.FieldByName('HSE_HRAINI').Value     := cdsDtaPerEnt.FieldByName('HRAINI').Value;
        qryCliHse.FieldByName('HSE_HRAFIN').Value     := cdsDtaPerEnt.FieldByName('HRAFIN').Value;
        qryCliHse.FieldByName('HSE_HRAIN2').Value     := cdsDtaPerEnt.FieldByName('HRAIN2').Value;
        qryCliHse.FieldByName('HSE_HRAFI2').Value     := cdsDtaPerEnt.FieldByName('HRAFI2').Value;
        qryCliHse.FieldByName('HSE_HRAIN3').Value     := cdsDtaPerEnt.FieldByName('HRAIN3').Value;
        qryCliHse.FieldByName('HSE_HRAFI3').Value     := cdsDtaPerEnt.FieldByName('HRAFI3').Value;
        qryCliHse.FieldByName('HSE_DAYOFW').AsInteger := cdsDtaPerEnt.FieldByName('DAYOFW').AsInteger;
        qryCliHse.Post;
      End;
      cdsDtaPerEnt.Next;
    End;
  Finally
    FreeAndNil(qryCliHse);
  End;
end;

procedure TFrmCadClientes.pGravaDiaSemEnt;
  Var
    strDiaFixEnt : String;
begin
  If (Not blnUTDTFE) Then
    Exit;

  strDiaFixEnt := '';
  cdsDtaPerEnt.First;
  While Not cdsDtaPerEnt.Eof Do
  Begin
    strDiaFixEnt := strDiaFixEnt + IIF(cdsDtaPerEnt.FieldByName('MARCAD').AsBoolean, 'S', 'N');
    cdsDtaPerEnt.Next;
  End;
  qryTabela.FieldByName('CLI_DSENTR').AsString := strDiaFixEnt;
end;

procedure TfrmCadClientes.pGravaDiaFixoMes;
  Var
    intIndex: Integer;
    strDiaMes: String;
begin
  strDiaMes := '';

  For intIndex := 0 To 30 Do
    If lstDiaMes.Checked[intIndex] Then
      strDiaMes := strDiaMes + lstDiaMes.Items[intIndex];

  qryTabela.FieldByName('CLI_DIAMES').AsString := strDiaMes;
end;

procedure TfrmCadClientes.pGravaDiaFixoMesEntFat;
  Var
    intIndex: Integer;
    strDiaMesFat: String;
    strDiaMesEnt: String;
begin
  If (Not blnUTDTFE) Then
    Exit;

  strDiaMesFat := '';
  strDiaMesEnt := '';

  For intIndex := 0 To 30 Do
  Begin
    If lstDiaMesPerFat.Checked[intIndex] Then
      strDiaMesFat := strDiaMesFat + lstDiaMesPerFat.Items[intIndex];

    If lstDiaMesPerEnt.Checked[intIndex] Then
      strDiaMesEnt := strDiaMesEnt + lstDiaMesPerEnt.Items[intIndex];
  End;

  qryTabela.FieldByName('CLI_DMFATU').AsString := strDiaMesFat;
  qryTabela.FieldByName('CLI_DMENTR').AsString := strDiaMesEnt;
end;

procedure TfrmCadClientes.pGravaDiaVisitas;
  Var
    strDiaSem: String;
begin
  strDiaSem := IfThen(chkSeg.Checked,'S','N') +
               IfThen(chkTer.Checked,'S','N') +
               IfThen(chkQua.Checked,'S','N') +
               IfThen(chkQui.Checked,'S','N') +
               IfThen(chkSex.Checked,'S','N') +
               IfThen(chkSab.Checked,'S','N') ;

  qryTabela.FieldByName('CLI_DIAVIS').AsString := strDiaSem;
  qryTabela.FieldByName('CLI_PERDVI').AsString := IfThen(rdbSemanal.Checked, 'S',
                                                  IfThen(rdbQuinzenal.Checked, 'Q',
                                                  IfThen(rdbMensal.Checked, 'M', '')));
end;

procedure TfrmCadClientes.pGravaEmpresaPrioridade;
var
  qryGravaEmpPrioridade: TUniQuery;
begin
  if (cdsEmpresaPrioridade.Active) then
  begin
    qryGravaEmpPrioridade := fCriaQuery;

    try
      pDeletaEmpresaPrioridade;

      if cdsEmpresaPrioridade.RecordCount > 0 then
      begin

        cdsEmpresaPrioridade.First;

        qryGravaEmpPrioridade.Close;
        qryGravaEmpPrioridade.SQL.Add('INSERT INTO EXEMSA(AUTOINCREM, MSA_CODEMP, MSA_CODCLI)');
        qryGravaEmpPrioridade.SQL.Add('VALUES(:AUTINC, :CODEMP, :CODCLI)');

        while not cdsEmpresaPrioridade.Eof do
        begin
          qryGravaEmpPrioridade.Close;
          qryGravaEmpPrioridade.ParamByName('AUTINC').AsString := cdsEmpresaPrioridadeAUTINC.AsString;
          qryGravaEmpPrioridade.ParamByName('CODEMP').AsString := cdsEmpresaPrioridadeCODEMP.AsString;
          qryGravaEmpPrioridade.ParamByName('CODCLI').AsString := cdsEmpresaPrioridadeCODCLI.AsString;
          qryGravaEmpPrioridade.Execute;
          cdsEmpresaPrioridade.Next;
        end;
      end;

    finally
      FreeAndNil(qryGravaEmpPrioridade);
    end;
  end;
end;

function TfrmCadClientes.fGravaProdRelacionados(pgbProgresso: TcxProgressBar): Boolean;
begin
  {*****************************************************}
  {* GRAVA DADOS DA ABA RELACIONAMENTO CLIENTE-PRODUTO *}
  {**************************************************RV*}
  If (blnCliPro) Then
  Begin
    Try

      pLimpaEditsProdutos;
      TCliPro.pApagarCadPro(qryTabela.FieldByName('CLI_CODCLI').AsString);
      pgbProgresso.Properties.Max := cdsCliPro.RecordCount;

      cdsCliPro.DisableControls;
      cdsCliPro.First;

      While Not cdsCliPro.Eof Do
      Begin
        pInfoStatusGravacao('Gravando produtos relacionados ' + IntToStr(cdsCliPro.RecNo) + ' de ' + IntToStr(cdsCliPro.RecordCount), pgbProgresso);
        pStepStatusGravacao(pgbProgresso);

        objCliPro.strAutInc := '';
        objCliPro.strCodCli := qryTabela.FieldByName('CLI_CODCLI').AsString;
        objCliPro.strCodPro := cdsCliPro.FieldByName('CODPRO').AsString;
        objCliPro.strCodUni := cdsCliPro.FieldByName('CODUNI').AsString;
        objCliPro.strDesUni := cdsCliPro.FieldByName('DESUNI').AsString;
        objCliPro.strUnidad := cdsCliPro.FieldByName('UNIDAD').AsString;
        objCliPro.strNomPro := cdsCliPro.FieldByName('NOMPRO').AsString;
        If (Not fEmptyStr(cdsCliPro.FieldByName('COD_NF').AsString)) Then
          objCliPro.strCod_NF := cdsCliPro.FieldByName('COD_NF').AsString;
        objCliPro.strDes_NF := cdsCliPro.FieldByName('DES_NF').AsString;
        objCliPro.strCodBar := cdsCliPro.FieldByName('CODBAR').AsString;

        objCliPro.pInsereCliPro;
        cdsCliPro.Next;
      End;

      If blnCliProHer Then
      Begin
        objCliPro.fRetProdutos(qryTabela.FieldByName('CLI_CODCLI').AsString, cdsCliPro, dspCliPro, nil);
        blnCliProHer := False;
      End;

      cdsCliPro.EnableControls;
      pnlProdutos.Enabled  := False;
      Result := True;

    Except
      On E: Exception Do
      Begin
        Result := False;
        fRollBack;
        pCarregaProdutos(qryTabela.FieldByName('CLI_CODCLI').AsString);
        pMensagensErro(E.Message,'[TfrmCadClientes.btnGravarClick]');
      End;
    End;

  End
  Else
    Result := True;
end;

procedure TfrmCadClientes.pHabilitaBotoesAdicionais;
begin
  btnCadDiv.Enabled := False;
  btnVenCli.Enabled := False;
  btnObsCli.Enabled := False;

  If (qryTabela.Active) And (Not qryTabela.FieldByName('CLI_CODCLI').IsNull) Then
  Begin
    btnCadDiv.Enabled := fVerificaAcessoSistema('GERDIV', strLoginUsuarioLogado);
    btnVenCli.Enabled := fVerificaAcessoSistema('ACEF9_', strLoginUsuarioLogado);
    btnObsCli.Enabled := fVerificaAcessoSistema('ACEF2_', strLoginUsuarioLogado);
  End;
end;

procedure TfrmCadClientes.pHabilitaCampoAtoDeclaratorioDF;
begin
  pnlAtoDeclaratorioDF.Visible := fExisteAlgumaEmpresaNoEstado('DF') And
      ((edtEstado.Text = 'DF') Or FCliEndEntrega.fExisteAlgumEnderecoNoEstado('DF'));

  If pnlAtoDeclaratorioDF.Visible Then
    dbmMsgAtoDDF.Enabled := (dbeAtoDDF.Text = 'S') And (qryTabela.State in [dsInsert, dsEdit]);

  lblAtoDDF.Visible := pnlAtoDeclaratorioDF.Visible;
  clbAtoDDF.Visible := pnlAtoDeclaratorioDF.Visible;
  lblMsgAtoDDF.Visible := pnlAtoDeclaratorioDF.Visible;
  dbeAtoDDF.Visible := pnlAtoDeclaratorioDF.Visible;
  dbmMsgAtoDDF.Visible := pnlAtoDeclaratorioDF.Visible;
end;

procedure TfrmCadClientes.pHabilitaCampoSibIcm;
begin
  if (qryTabela.State In [dsEdit, dsInsert]) then
    dbeSibIcm.Enabled := (dbeIvaEsp.Enabled) and (dbeIvaEsp.Field.AsFloat >0);
end;

procedure TfrmCadClientes.pHabilitaCampoSituacaoPisCofins;
begin
  if (qryTabela.State In [dsEdit, dsInsert]) then
  begin
    cbxTributacaoPisCofins.Enabled := not fPisCofinsDaCidadeSuspensa(dbeCodCid.Text);
  end;
end;

procedure TfrmCadClientes.pHabilitaConsultaSCPC;
begin
  dbeDtaCon.Enabled := fSelecionadoSCPC And (qryTabela.State in [dsInsert, dsEdit]);
  dbeQrdPro.Enabled := fSelecionadoSCPC And (qryTabela.State in [dsInsert, dsEdit]);
  dbeCheDev.Enabled := fSelecionadoSCPC And (qryTabela.State in [dsInsert, dsEdit]);
  dbePerfin.Enabled := fSelecionadoSCPC And (qryTabela.State in [dsInsert, dsEdit]);
  btnAbrirPastaCredito.Enabled := fSelecionadoSCPC And (qryTabela.State in [dsInsert, dsEdit]);
  btnConSCPC.Enabled := (cmbTipoPesquisa.ItemIndex = 6) And (qryTabela.State in [dsInsert, dsEdit]);
  dbeObsCon.ReadOnly := (cmbTipoPesquisa.ItemIndex <= 0) Or (Not (qryTabela.State in [dsInsert, dsEdit]));
  pnlTipoCreditoBV.Visible := UtilizaConsultaBoaVistaAcertaEssencialPositivo;

  pnlTipoConsultaPOA.Visible := (cmbTipoPesquisa.ItemIndex = 6) And UtilizaSCPC_POA;

  pHabilitaSCPC_CDLPOA;

end;

procedure TfrmCadClientes.pHabilitaSCPC_CDLPOA;
Var
    strDocto : String;
Begin

  If pnlTipoConsultaPOA.Visible Then
  Begin

     strDocto := qryTabela.FieldByName('CLI_C_G_C_').AsString;

     If strDocto <> '' Then
     Begin
        If strDocto.Length > 11 Then
        Begin
           cmpConsultaPOA.Items.clear;
           cmpConsultaPOA.Items.Add('Define Risco Positivo');
           cmpConsultaPOA.Items.Add('Define Negócio Positivo');
           cmpConsultaPOA.Items.Add('Define Limite Positivo');
        End
        Else
        Begin
           cmpConsultaPOA.Items.clear;
           cmpConsultaPOA.Items.Add('Familia Positivo');
           //cmpConsultaPOA.Items.Add('Rede Positivo');
        End;
        cmpConsultaPOA.ItemIndex := 0;
        cmpConsultaPOAChange(cmpConsultaPOA);
     End;

  End;

End;

procedure TfrmCadClientes.pHabilitaDiaFixo;
begin
  if fCfgSis('MLTCND', varBoolean) then
  begin
    lstDiaFix.Enabled := True;
    lstDiaMes.Enabled := True;
  end
  else
  begin
    if (fQtdeChecados(lstDiaMes) <> 0) And  (fQtdeChecados(lstDiaFix) <> 0) then
    begin
      lstDiaFix.Enabled := True;
      lstDiaMes.Enabled := True;
    end
    Else
    Begin
      lstDiaFix.Enabled := fQtdeChecados(lstDiaMes) = 0;
      lstDiaMes.Enabled := fQtdeChecados(lstDiaFix) = 0;
    End;
  end;
end;

procedure TfrmCadClientes.pHabilitarAbaSocios(blnHabilitar: Boolean);
begin
  pnlTopoQuadSco.Enabled := blnHabilitar;
  dbgQuadSoc.ReadOnly    := Not blnHabilitar;
end;

procedure TfrmCadClientes.pGravaClassificacoesRECAP;
var
  strSQL,
  strAutInc: String;
  qryAux,
  qryDelete: TUniQuery;
begin
  qryAux    := fCriaQuery;
  qryDelete := fCriaQuery;

  try
    cdsClaRECAP.Filtered := False;
    cdsClaRECAP.Filter   := 'OPERAC=''D''';
    cdsClaRECAP.Filtered := True;

    cdsClaRECAP.First;

    strSQL := 'DELETE FROM CRECAP WHERE AUTOINCREM = :AUTINC';

    qryAux.SQL.Text := strSQL;
    qryDelete.SQL.Text := 'SELECT * FROM CRECAP WHERE AUTOINCREM = :AUTINC';

    while not cdsClaRECAP.Eof do
    begin
      qryDelete.Close;
      qryDelete.ParamByName('AUTINC').AsString := cdsClaRECAP.FieldByName('AUTINC').AsString;
      qryDelete.Open;
      fVerificaIntegridade(Self.Name, 'CRECAP', qryDelete, True);

      qryAux.Close;
      qryAux.ParamByName('AUTINC').AsString := cdsClaRECAP.FieldByName('AUTINC').AsString;
      qryAux.ExecSQL;

      cdsClaRECAP.Delete;
    end;

    cdsClaRECAP.Filtered := False;
    cdsClaRECAP.Filter   := 'OPERAC=''I''';
    cdsClaRECAP.Filtered := True;

    cdsClaRECAP.First;

    strSQL := '';
    strSQL := strSQL + ' INSERT INTO CRECAP ( ';
    strSQL := strSQL + '     AUTOINCREM, ';
    strSQL := strSQL + '     RCP_SEQCLI, ';
    strSQL := strSQL + '     RCP_CODNCM) ';
    strSQL := strSQL + ' VALUES ( ';
    strSQL := strSQL + '     :AUTINC, ';
    strSQL := strSQL + '     :SEQCLI, ';
    strSQL := strSQL + '     :CODNCM) ';

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Text := strSQL;

    while not cdsClaRECAP.Eof do
    begin
      if (fEmptyStr(cdsClaRECAP.FieldByName('AUTINC').AsString)) then
      begin
        strAutInc := fRetAutoIncrem('CRECAP', VS_strCodEmp);

        qryAux.Close;
        qryAux.ParamByName('AUTINC').AsString := strAutInc;
        qryAux.ParamByName('SEQCLI').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
        qryAux.ParamByName('CODNCM').AsString := cdsClaRECAP.FieldByName('CODNCM').AsString;
        qryAux.ExecSQL;

        cdsClaRECAP.Edit;
        cdsClaRECAP.FieldByName('AUTINC').AsString := strAutInc;
        cdsClaRECAP.Post;
      end;

      cdsClaRECAP.Next;
    end;
  finally
    FreeAndNil(qryAux);
    FreeAndNil(qryDelete);
  end;
end;

procedure TfrmCadClientes.pGravaCliDepProd;
begin
  edtCodDep.Clear;
  edtDesDep.Clear;

  With cdsCliDep Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      Edit;

      FieldByName('DEP_CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
      If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CLIDEP', VS_strCodEmp);

      Post;
      Next;
    End;

    ApplyUpdates(0);

    EnableControls;
  End;
end;

procedure TfrmCadClientes.pGravaCondicaoPagamento;
  Var
    qryCliCnd: TUniQuery;
Begin
  edtCodCnd.Clear;
  edtDesCnd.Clear;
  mskConPag.Clear;

  qryCliCnd := fCriaQuery;
  Try
    Try
      qryCliCnd.SQL.Text := 'DELETE FROM CLICND WHERE CND_CODCLI = ' + QuotedStr(qryTabela.FieldByName('CLI_CODCLI').AsString);
      qryCliCnd.ExecSQL;

      qryCliCnd.SQL.Clear;
      qryCliCnd.SQL.Add('INSERT INTO CLICND(');
      qryCliCnd.SQL.Add('  AUTOINCREM,');
      qryCliCnd.SQL.Add('  CND_CODCLI,');
      qryCliCnd.SQL.Add('  CND_CODCND,');
      qryCliCnd.SQL.Add('  CND_CNDPAG,');
      qryCliCnd.SQL.Add('  CND_SUGEST)');
      qryCliCnd.SQL.Add('VALUES(');
      qryCliCnd.SQL.Add('  :AUTOIN,');
      qryCliCnd.SQL.Add('  :CODCLI,');
      qryCliCnd.SQL.Add('  :CODCND,');
      qryCliCnd.SQL.Add('  :CNDPAG,');
      qryCliCnd.SQL.Add('  :SUGEST)');

      cdsCliCnd.DisableControls;
      cdsCliCnd.First;
      While Not cdsCliCnd.Eof Do
      Begin
        If fEmptyStr(cdsCliCndCND_CODCND.AsString) And fEmptyStr(cdsCliCndCND_CNDPAG.AsString) Then
        Begin
          cdsCliCnd.Next;
          Continue;
        End;

        If fEmptyStr(cdsCliCndAUTOINCREM.AsString) Then
        Begin
          cdsCliCnd.Edit;
          cdsCliCndAUTOINCREM.AsString := fRetAutoIncrem('CLICND', VS_strCodEmp);
          cdsCliCnd.Post;
        End;

        qryCliCnd.Close;
        qryCliCnd.ParamByName('AUTOIN').AsString := cdsCliCndAUTOINCREM.AsString;
        qryCliCnd.ParamByName('CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
        If Not fEmptyStr(cdsCliCndCND_CODCND.AsString) Then
          qryCliCnd.ParamByName('CODCND').AsString := cdsCliCndCND_CODCND.AsString
        Else
          qryCliCnd.ParamByName('CODCND').Clear;
        If Not fEmptyStr(cdsCliCndCND_CNDPAG.AsString) Then
          qryCliCnd.ParamByName('CNDPAG').AsString := cdsCliCndCND_CNDPAG.AsString
        Else
          qryCliCnd.ParamByName('CNDPAG').Clear;
        qryCliCnd.ParamByName('SUGEST').AsString := cdsCliCndCND_SUGEST.AsString;
        qryCliCnd.ExecSQL;

        cdsCliCnd.Next;
      End;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmCadClientes.pGravaCondicaoPagamento]');
      End;
    End;
  Finally
    cdsCliCnd.EnableControls;
    FreeAndNil(qryCliCnd);
  End;
End;

procedure TfrmCadClientes.pCarregaCondicaoPagamento(strCodCli: String);
  Var
    qryCliCnd: TUniQuery;
Begin
  edtCodCnd.Clear;
  edtDesCnd.Clear;
  mskConPag.Clear;

  qryCliCnd := fCriaQuery;

  With qryCliCnd, SQL Do
  Begin
    Close;

    Clear;
    Add('SELECT');
    Add('  C.AUTOINCREM,');
    Add('  C.CND_CODCLI,');
    Add('  C.CND_CODCND,');
    Add('  C.CND_CNDPAG,');
    Add('  C.CND_SUGEST,');
    Add('  (SELECT D.CND_DESCRI FROM CADCND D WHERE C.CND_CODCND = D.CND_CODIGO) AS CND_DESCRI');
    Add('FROM');
    Add('  CLICND C');
    Add('WHERE');
    Add('  C.CND_CODCLI = :CODCLI AND');

    If fCfgSis('USACND', varBoolean) Then
      Add('  C.CND_CODCND IS NOT NULL')
    Else
      Add('  IFNULL(C.CND_CNDPAG, " ") <> " "');

    ParamByName('CODCLI').AsString := strCodCli;

    Open;

    If Not cdsCliCnd.Active Then
      cdsCliCnd.CreateDataSet;
    cdsCliCnd.EmptyDataSet;

    First;
    While Not Eof Do
    Begin
      cdsCliCnd.Insert;
      cdsCliCndAUTOINCREM.AsString := FieldByName('AUTOINCREM').AsString;
      cdsCliCndCND_CODCLI.AsString := FieldByName('CND_CODCLI').AsString;
      cdsCliCndCND_CODCND.AsString := FieldByName('CND_CODCND').AsString;
      cdsCliCndCND_CNDPAG.AsString := FieldByName('CND_CNDPAG').AsString;
      cdsCliCndCND_SUGEST.AsString := FieldByName('CND_SUGEST').AsString;
      cdsCliCndCND_DESCRI.AsString := FieldByName('CND_DESCRI').AsString;
      cdsCliCnd.Post;

      Next;
    End;
  End;

  FreeAndNil(qryCliCnd);
End;

procedure TfrmCadClientes.pCarregaCondicaoPagamentoCFG(strCodAti: string);
var
  qryCondicao: TUniQuery;
begin
  qryCondicao := fCriaQuery;

  try
    qryCondicao.Close;
    qryCondicao.SQL.Clear;
    qryCondicao.SQL.Add('SELECT * FROM CNDCFG WHERE CFG_CODATI = :CODATI AND CFG_CODEMP = :CODEMP ORDER BY CFG_SUGEST DESC');
    qryCondicao.ParamByName('CODATI').AsString := strCodAti;
    qryCondicao.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCondicao.Open;

    //Se não houver cadastro de atividade pega as condições de pagamento de TODAS.
    if qryCondicao.IsEmpty then
    begin
      qryCondicao.Close;
      qryCondicao.ParamByName('CODATI').AsString := '000';
      qryCondicao.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryCondicao.Open;
    end;


    while not qryCondicao.Eof do
    begin
      if not cdsCliCnd.Locate('CND_CODCND', qryCondicao.FieldByName('CFG_CODCND').AsString, []) then
      begin
        cdsCliCnd.Insert;
        cdsCliCnd.FieldByName('CND_CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
        cdsCliCnd.FieldByName('CND_CODCND').AsString := qryCondicao.FieldByName('CFG_CODCND').AsString;
        cdsCliCnd.FieldByName('CND_DESCRI').AsString := qryCondicao.FieldByName('CFG_DESCND').AsString;
        cdsCliCnd.FieldByName('CND_SUGEST').AsString := IIF(qryCondicao.FieldByName('CFG_SUGEST').AsBoolean, 'S', 'N');
        cdsCliCnd.Post;
      end;

      qryCondicao.Next;
    end;
  finally
    FreeAndNil(qryCondicao);
  end;
end;

class procedure TfrmCadClientes.pCarregaCondicaoPagamentoRapidoCFG(strCodAti,
  strCodCli: string; qryCliCnd: TUniQuery);
var
  qryCondicao: TUniQuery;
begin
  qryCondicao := fCriaQuery;

  try
    qryCondicao.Close;
    qryCondicao.SQL.Clear;
    qryCondicao.SQL.Add('SELECT * FROM CNDCFG WHERE CFG_CODATI = :CODATI AND CFG_CODEMP = :CODEMP ORDER BY CFG_SUGEST DESC');
    qryCondicao.ParamByName('CODATI').AsString := strCodAti;
    qryCondicao.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCondicao.Open;

    //Se não houver cadastro de atividade pega as condições de pagamento de TODAS.
    if qryCondicao.IsEmpty then
    begin
      qryCondicao.Close;
      qryCondicao.ParamByName('CODATI').AsString := '000';
      qryCondicao.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryCondicao.Open;
    end;


    while not qryCondicao.Eof do
    begin
      qryCliCnd.Append;
      qryCliCnd.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CLICND', VS_strCodEmp);
      qryCliCnd.FieldByName('CND_CODCLI').AsString := strCodCli;
      qryCliCnd.FieldByName('CND_CODCND').AsString := qryCondicao.FieldByName('CFG_CODCND').AsString;
      qryCliCnd.FieldByName('CND_CNDPAG').AsString := fCampoTabela('CND_CNDPAG', 'CADCND', ['CND_CODIGO'], [qryCondicao.FieldByName('CFG_CODCND').AsString], False);
      qryCliCnd.FieldByName('CND_SUGEST').AsString := IIF(qryCondicao.FieldByName('CFG_SUGEST').AsBoolean, 'S', 'N');
      qryCliCnd.Post;

      qryCondicao.Next;
    end;
  finally
    FreeAndNil(qryCondicao);
  end;
end;
Function TfrmCadClientes.fTemCondicaoSugerida: Boolean;
Begin
  With cdsCliCnd do
  Begin
    If IsEmpty Then
    Begin
      Result := True;
      Exit;
    End;

    If (RecordCount = 1) And (FieldByName('CND_SUGEST').AsString <> 'S') Then
    Begin
      Edit;
      FieldByName('CND_SUGEST').AsString := 'S';
      Post;
      Result := True;
      Exit;
    End;

    DisableControls;
    Result := Locate('CND_SUGEST', 'S', []);
    EnableControls;
  End;
End;

function TfrmCadClientes.fRetCampoComDireito(dbeCampo: TDBEdit): TDBEdit;
begin
  {***********************************************************}
  { FOI FEITA ESTA VERIFICAÇÃO POR CAUSA DO DIREITO DE ACESSO }
  {********************************************************PE*}
  If (dbeCampo = dbeNomCli) And (Not dbeCampo.Enabled) Then
     dbeCampo := dbeFanSob;

  If (dbeCampo = dbeFanSob) And (Not dbeCampo.Enabled) Then
     dbeCampo := dbeCodCid;

  Result := dbeCampo;
end;


procedure TfrmCadClientes.pInfoStatusGravacao(strInformacao: String; pgbProgresso: TcxProgressBar);
begin
  If Assigned(pgbProgresso) And (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strInformacao;
    Application.ProcessMessages;
  End;
End;

procedure TfrmCadClientes.pStepStatusGravacao(pgbProgresso: TcxProgressBar);
Begin
  If Assigned(pgbProgresso) Then
  Begin
    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
  End;
End;

procedure TfrmCadClientes.pQryTabelaAfterOpen(DataSet: TDataSet);
begin
  qryTabela.FieldByName('CLI_TIPATI').OnSetText := pTipAtiSetText;
  qryTabela.FieldByName('CLI_TIPATI').OnGetText := pTipAtiGetText;
  qryTabela.FieldByName('CLI_INDCOM').OnSetText := pIndComSetText;
  qryTabela.FieldByName('CLI_INDCOM').OnGetText := pIndComGetText;
  qryTabela.FieldByName('CLI_DESOMT').OnSetText := pDesoMTSetText;
  qryTabela.FieldByName('CLI_DESOMT').OnGetText := pDesoMTGetText;

  qryTabela.FieldByName('CLI_C_G_C_').EditMask := fRetMascaraC_G_C_(FPais, C_G_C_);

  qryTabela.FieldByName('CLI_CPFDEV').EditMask := fRetMascaraC_G_C_(FPais, C_P_F_);
  TStringField(qryTabela.FieldByName('CLI_PLANCO')).EditMask := fMskCon;

  If VS_strHabilitarCRM Then
  Begin
    cdsCliFor.qryQuery.Close;
    cdsCliFor.qryQuery.ParamByName('CODPRO').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
    cdsCliFor.fAbreClient(True, 'pAfterOpenTabela');
  End;

  If pnlGrupoRisco.Visible Then
    pCarregaGrupoRisco();
end;

procedure TfrmCadClientes.pTipAtiGetText(Field: TField; var Text: String; DisplayText: Boolean);
begin
  If Field.AsString = 'A' Then
    Text := 'Atacado'
  Else If Field.AsString = 'V' Then
    Text := 'Varejo'
  Else If Field.AsString = 'S' Then
    Text := 'SM';
end;

procedure TfrmCadClientes.pTipAtiSetText(Field: TField; const Text: String);
begin
  If Text = 'Atacado' Then
    Field.AsString := 'A'
  Else If Text = 'Varejo' Then
    Field.AsString := 'V'
  Else If Text = 'SM' Then
    Field.AsString := 'S';
end;

function TfrmCadClientes.fGravaForMarNaoPermitidos: Boolean;
var
  qryExec: TUniQuery;
begin
  If Not (fCfgSis('UTIFMP', varBoolean)) Then
    Exit(True);

  Result := fLimpaForMarNaoPermitidos(dbeCodCli.Text);

  if Not Result then
    Exit;

  qryExec := fCriaQuery;
  try
    qryExec.Close;
    qryExec.SQL.Text := 'SELECT * FROM CLIFNP WHERE FALSE';
    qryExec.Open;

    cdsCliFNP.First;
    While Not cdsCliFNP.Eof Do
    Begin
      qryExec.Append;
      qryExec.FieldByName('FNP_CODCLI').AsString := cdsCliFNP.FieldByName('FNP_CODCLI').AsString;
      qryExec.FieldByName('FNP_CODFOR').AsString := cdsCliFNP.FieldByName('FNP_CODFOR').AsString;
      qryExec.Post;

      cdsCliFNP.Next;
    End;

    qryExec.Close;
    qryExec.SQL.Text := 'SELECT * FROM CLIMNP WHERE FALSE';
    qryExec.Open;

    cdsCliMNP.First;
    While Not cdsCliMNP.Eof Do
    Begin
      qryExec.Append;
      qryExec.FieldByName('MNP_CODCLI').AsString := cdsCliMNP.FieldByName('MNP_CODCLI').AsString;
      qryExec.FieldByName('MNP_CODMAR').AsString := cdsCliMNP.FieldByName('MNP_CODMAR').AsString;
      qryExec.Post;

      cdsCliMNP.Next;
    End;

    Result := True;
  finally
    FreeAndNil(qryExec);
  end;
end;

function TfrmCadClientes.fLiberaAltLimContratoLocacao(fltVlrAnt,
  fltVlrAtu: Double): Boolean;
var
  objLib: TLiberacao;
Begin
  objLib := TLiberacao.Create;
  Try
    objLib.Clear;
    objLib.strDirAce    := 'ALTLIM';
    objLib.strCodOpe    := strLoginUsuarioLogado;
    objLib.strCodDig    := strLoginUsuarioLogado;
    objLib.strCliente   := (dbeCodCli.Text + '-' + dbeNomCli.Text);
    objLib.strCpfCnpj   := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
    objLib.objMsgLibera.pAddTexto('Troca de Limite de Contrato de Locação.');
    objLib.objMsgLibera.pAddTexto('Limite Anterior: ' + FormatFloat('###,#0.00', fltVlrAnt));
    objLib.objMsgLibera.pAddTexto('Limite Atual...: ' + FormatFloat('###,#0.00', fltVlrAtu));
    objLib.objMsgLibera.pAddTexto('');

    Result := objLib.fLibera;
  Finally
    FreeAndNil(objLib);
  End;
End;

function TfrmCadClientes.fLimpaForMarNaoPermitidos(strCodCli: String): Boolean;
Var
  strSQLFNP, strSQLMNP: String;
  qryDel: TUniQuery;
begin
  Try
    strSQLFNP := '';
    strSQLFNP := strSQLFNP + 'DELETE FROM CLIFNP ';
    strSQLFNP := strSQLFNP + 'WHERE FNP_CODCLI = :CODCLI ';

    strSQLMNP := '';
    strSQLMNP := strSQLMNP + 'DELETE FROM CLIMNP ';
    strSQLMNP := strSQLMNP + 'WHERE MNP_CODCLI = :CODCLI ';

    qryDel := fCriaQuery;
    try
      qryDel.Close;
      qryDel.SQL.Clear;
      qryDel.SQL.Add(strSQLFNP);
      qryDel.ParamByName('CODCLI').AsString := strCodCli;
      qryDel.ExecSQL;

      qryDel.Close;
      qryDel.SQL.Clear;
      qryDel.SQL.Add(strSQLMNP);
      qryDel.ParamByName('CODCLI').AsString := strCodCli;
      qryDel.ExecSQL;

      Result := True;
    finally
      FreeAndNil(qryDel);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadClientes.fLimpaForMarNaoPermitidos]');
      Result := False;
    End;
  End;
end;


function TfrmCadClientes.fGravaFornecedor: Boolean;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fGravaFornecedorProgresso;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;
  Finally
    FreeAndNil(frmGravando);
  End;
end;

function TfrmCadClientes.fGravaFornecedorProgresso(cxProgressBar: TcxProgressBar): Boolean;
  Var
    qryInsert : TUniQuery;
begin
  Try
    Result := True;
    cdsCliFor.DisableControls;
    cdsCliFor.First;

    qryInsert := fCriaQuery;
    With qryInsert, SQL Do
    Begin
      Close;
      Clear;
      Add('DELETE FROM CLIFOR WHERE CLF_CODCLI = :CODPRO');
      ParamByName('CODPRO').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
      Try
        ExecSQL;
      Except
        On E : Exception Do
        Begin
          pMensagensErro(E.Message, 'TfrmCadClientes.fGravaFornecedorProgresso');
          Result := False;
          Exit;
        End;
      End;

      cxProgressBar.pSetMax(cdsCliFor.RecordCount);

      Close;
      Clear;
      Add(' INSERT INTO CLIFOR (CLF_CODCLI, CLF_CRMFOR) ');
      Add('             VALUES (:CODCLI, :CRMFOR)       ');

      ParamByName('CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;

      While Not cdsCliFor.Eof Do
      Begin
        ParamByName('CRMFOR').AsString := cdsCliFor.FieldByName('CLF_CRMFOR').AsString;

        Try
          ExecSQL;
        Except
          On E : Exception Do
          Begin
            pMensagensErro(E.Message, 'TfrmCadClientes.fGravaFornecedorProgresso');
            Result := False;
            Exit;
          End;
        End;

        cdsCliFor.Next;

        cxProgressBar.pStep;
        Application.ProcessMessages;
      End;

    End;

  Finally
    cdsCliFor.EnableControls;
    FreeAndNil(qryInsert);
  End;

end;

function TfrmCadClientes.fSQLCliFor: String;
begin
  Result := '';
  Result := Result + ' SELECT CLF_CODCLI,                           ';
  Result := Result + '        CLF_CRMFOR,                           ';
  Result := Result + '        CRF_NOMFOR                            ';
  Result := Result + ' FROM CLIFOR                                  ';
  Result := Result + ' INNER JOIN CRMFOR ON CRF_CODIGO = CLF_CRMFOR ';
  Result := Result + ' WHERE CLF_CODCLI = :CODPRO                   ';
end;

procedure TfrmCadClientes.pCarregaInteligenciaDeVenda;
Begin

  edtDesFre.Text   := fRetDesCrmFre(dbeCrmFre.Text);
  edtDesCrmPor.Text:= fRetDesCrmPor(dbeCrmPor.Text);
  edtDesFai.Text   := fRetDesCrmFai(dbeCrmFai.Text);
  edtDesCat.Text   := fRetDesCrmCat(dbeCrmCat.Text);

  edtDesFor.Clear;
  edtCrmFor.Clear;

  edtVal3Me.Text := '0.00';
  edtMar3Me.Text := '0.00';

  edtVal6Me.Text := '0.00';
  edtMar6Me.Text := '0.00';

  edtVal12M.Text := '0.00';
  edtMar12M.Text := '0.00';

End;

function TfrmCadClientes.fSalvarCadCliEmb(strCodCli, strAutInc : String; strCliEmb_AutInc: String = ''): Boolean;
  Var
    qryTemp: TUniQuery;
begin
  Result := True;

  Try
    qryTemp := fCriaQuery(nil);

    Try
      qryTemp.Close();
      qryTemp.SQL.Clear();
      qryTemp.SQL.Text := 'INSERT INTO CLIEMB (AUTOINCREM, EMB_CODCLI, EMB_CODEMB) VALUES ' +
                            '(:AUTINC, :CODCLI, :CODEMB)';

      if (strCliEmb_AutInc <> '') then
        qryTemp.ParamByName('AUTINC').AsString := strCliEmb_AutInc
      else
        qryTemp.ParamByName('AUTINC').AsString := fRetAutoIncrem('CLIEMB', VS_strCodEmp);

      qryTemp.ParamByName('CODCLI').AsString := strCodCli;
      qryTemp.ParamByName('CODEMB').AsString := strAutInc;
      qryTemp.ExecSQL();
    Except
      On E: Exception Do Begin
        Result := False;
        pMensagensErro(E.Message,'[TfrmCadClientes.fSalvarCadCliEmb]');
      End;
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

function TfrmCadClientes.fSalvarEmbarcacoesCliente: Boolean;
begin
  Result := True;

  Try
    pDeletarEmbarcacoes(qryTabela.FieldByName('CLI_CODCLI').AsString);

    Try
      cdsCadEmb.DisableControls();
      cdsCadEmb.First();

      While (Not cdsCadEmb.Eof) Do
      Begin
        fSalvarCadCliEmb(qryTabela.FieldByName('CLI_CODCLI').AsString,
                         cdsCadEmb.FieldByName('AUTOINCREM').AsString,
                         cdsCadEmbCLIEMB_AUTINC.AsString);

        cdsCadEmb.Next();
      End;
    Finally
      cdsCadEmb.EnableControls();
    End;
  Except
    On E: Exception Do Begin
      Result := False;
      pMensagensErro(E.Message,'[TfrmCadClientes.fSalvarEmbarcacoesCliente]');
    End;
  End;
end;

function TfrmCadClientes.fSelecionadoSCPC: Boolean;
begin
  Result := ((cmbTipoPesquisa.ItemIndex > 0) And (cmbTipoPesquisa.ItemIndex < 7)) Or (cmbTipoPesquisa.ItemIndex = 8);
end;

function TfrmCadClientes.fSomaCaracteresEndereco: integer;
begin
  result := length(dbeEndere.Text + dbeEndNum.Text + dbeEndCom.Text);
  lblQntCaracteresEnd.Caption := 'Total de caracteres do end. de entrega para Nfe: ' + IntToStr(result);
end;

procedure TfrmCadClientes.pCarregaTributacao(NomeDoCampo: String);
var
  i: integer;
begin
  Try
    If (NomeDoCampo='CLI_SITP_C') Then
    Begin
      lbl17.Visible        := False;
      dbeDif_PC.Visible    := False;
      ColorLabel29.Visible := False;
      cbxTributacaoPisCofins.Items.Clear;
      For i := 0 To Length(arr_SITUACAOTRIBUTARIAPISCOFINS)-1 do
        cbxTributacaoPisCofins.Items.Add(arr_SITUACAOTRIBUTARIAPISCOFINS[i][0]+'  - '+arr_SITUACAOTRIBUTARIAPISCOFINS[i][1]);
    End;
    If (NomeDoCampo='CLI_SITPCP') Then
    Begin
      cbxTributacaoPisCofinsVendaPresencial.Items.Clear;
      For i := 0 To Length(arr_SITUACAOTRIBUTARIAPISCOFINS)-1 do
        cbxTributacaoPisCofinsVendaPresencial.Items.Add(arr_SITUACAOTRIBUTARIAPISCOFINS[i][0]+'  - '+arr_SITUACAOTRIBUTARIAPISCOFINS[i][1]);
    End;
    If (NomeDoCampo='CLI_SITIPI') Then
    Begin
      Label194.Visible     := False;
      ColorLabel20.Visible := False;
      dbeIseIPI.Visible    := False;
      cbxTributacaoIPI.Items.Clear;
      For i := 0 To Length(arr_SITUACAOTRIBUTARIAIPI)-1 do
        cbxTributacaoIPI.Items.Add(arr_SITUACAOTRIBUTARIAIPI[i][0]+'  - '+arr_SITUACAOTRIBUTARIAIPI[i][1]);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCarregaTributacao]');
    End;
  End;
end;

procedure TfrmCadClientes.pAtualizaTributacao(NomeDoCampo: String);
begin
  Try
    If (NomeDoCampo='CLI_SITIPI') Then
    Begin
      Case AnsiIndexStr(UpperCase(qryTabela.FieldByName('CLI_SITIPI').Text), ['T', 'I','M', 'S', 'N']) of
        0 : cbxTributacaoIPI.ItemIndex := Integer(sitIPITributado);
        1 : cbxTributacaoIPI.ItemIndex := Integer(sitIPIIsento);
        2 : cbxTributacaoIPI.ItemIndex := Integer(sitIPIImune);
        3 : cbxTributacaoIPI.ItemIndex := Integer(sitIPISuspenso);
        4 : cbxTributacaoIPI.ItemIndex := Integer(sitIPINaoTributado);
      end;
      cbxTributacaoIPIChange(Self);
    End;
    If (NomeDoCampo='CLI_SITP_C') Then
    Begin
      Case AnsiIndexStr(UpperCase(qryTabela.FieldByName('CLI_SITP_C').Text), ['T', 'I','S', 'D', 'Z']) of
        0 : cbxTributacaoPisCofins.ItemIndex := Integer(sitPisCofinsTributado);
        1 : cbxTributacaoPisCofins.ItemIndex := Integer(sitPisCofinsIsento);
        2 : cbxTributacaoPisCofins.ItemIndex := Integer(sitPisCofinsSuspenso);
        3 : cbxTributacaoPisCofins.ItemIndex := Integer(sitPisCofinsDiferido);
        4 : cbxTributacaoPisCofins.ItemIndex := Integer(sitPisCofinsTributadoAliquotaZero);
      end;
      cbxTributacaoPisCofinsChange(Self);
    End;
    If (NomeDoCampo='CLI_SITPCP') Then
    Begin
      Case AnsiIndexStr(UpperCase(qryTabela.FieldByName('CLI_SITPCP').Text), ['T', 'I','S', 'D', 'Z']) of
        0 : cbxTributacaoPisCofinsVendaPresencial.ItemIndex := Integer(sitPisCofinsTributado);
        1 : cbxTributacaoPisCofinsVendaPresencial.ItemIndex := Integer(sitPisCofinsIsento);
        2 : cbxTributacaoPisCofinsVendaPresencial.ItemIndex := Integer(sitPisCofinsSuspenso);
        3 : cbxTributacaoPisCofinsVendaPresencial.ItemIndex := Integer(sitPisCofinsDiferido);
        4 : cbxTributacaoPisCofinsVendaPresencial.ItemIndex := Integer(sitPisCofinsTributadoAliquotaZero);
      end;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pAtualizaTributacao]');
    End;
  End;
end;

procedure TfrmCadClientes.pCarregaPlanoContabil(const blnBuscaPorChave: Boolean=False);
begin
  If (edtDesPlaNco.Visible) Then
  begin
    edtDesPlaNco.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePlaNco.Text)], False) + ' - ' + fCampoTabelaPlanco('NCO_CONRED', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePlaNco.Text)], False);
  end;

  If edtDesPlaNco.Text = ' - ' Then
    edtDesPlaNco.Text := '';
end;

procedure TfrmCadClientes.AbrirCadastroVendedoresDoCliente;
var
  frmCadCliVenMar: TfrmCadCliVenMar;
begin
  inherited;

  If (qryTabela.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário escolher um cliente!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmCadCliVenMar, frmCadCliVenMar);
    frmCadCliVenMar.edtCodCli.Text := dbeCodCli.Text;
    frmCadCliVenMar.edtNomCli.Text := dbeNomCli.Text;
    frmCadCliVenMar.cdsCliVen.Data := cdsCliVendedoresMar.Data;

    If (qryTabela.State = dsBrowse) Then
    Begin
      pSetFocus(frmCadCliVenMar.btnSair);
      frmCadCliVenMar.btnAdicionar.Enabled   := False;
      frmCadCliVenMar.btnCancelaItem.Enabled := False;
      frmCadCliVenMar.pnlCabecalho.Enabled   := False;
      frmCadCliVenMar.btnConfirma.Enabled    := False;
      frmCadCliVenMar.btnLimparTodosRegs.Enabled := False;
    End
    Else
    Begin
      pSetFocus(frmCadCliVenMar.edtCodVen);
      frmCadCliVenMar.btnAdicionar.Enabled   := True;
      frmCadCliVenMar.btnCancelaItem.Enabled := True;
      frmCadCliVenMar.pnlCabecalho.Enabled   := True;
      frmCadCliVenMar.btnConfirma.Enabled    := True;
      frmCadCliVenMar.btnLimparTodosRegs.Enabled := True;
    End;

    If frmCadCliVenMar.ShowModal = mrOk Then
    Begin
      cdsCliVendedoresMar.EmptyDataSet;
      cdsCliVendedoresMar.Data := frmCadCliVenMar.cdsCliVen.Data;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmCadClientes.btnCliVenClick]');
    End;
  End;
  pFreeAndNil(frmCadCliVenMar);
end;

function TfrmCadClientes.fValidarFalhaCadastralDeMultiplosDescontosNaNota: boolean;
const
  strSIM = 'S';
var
  objParametros: TFalhaCadastralDeMultiplosDescontosNaNota.TParametros;

  procedure pFocarCampoZonaFranca;
  begin
    pgcDados.ActivePage := tbsDadosFiscais;
    pgDadosFiscais.ActivePage := TabGeral;
    pSetFocus(dbeZonFra);
  end;

begin
  objParametros := TFalhaCadastralDeMultiplosDescontosNaNota.TParametros.Create;
  try
    objParametros.CadastroCliente.DadosGerais.ZonaFranca := CompareText(dbeZonFra.Text, strSIM) = 0;
    objParametros.CadastroCliente.DadosGerais.BeneficioREIDI := CompareText(dbeBenRei.Text, strSIM) = 0;
    objParametros.CadastroCliente.OrgaoPublico.CalculaDescontoIcms := CompareText(dbeCalIcm.Text, strSIM) = 0;
    result := TFalhaCadastralDeMultiplosDescontosNaNota.Validar(objParametros);
    if not result then
      pFocarCampoZonaFranca;
  finally
    if Assigned(objParametros) then
      FreeAndNil(objParametros);
  end;
end;

class function TfrmCadClientes.fAlteraCadCli(const strCodCliLocal: String): String;
begin
  If Not fVerificaAcessoSistema('frmCadClientes') Then
    Exit;

  pCriarFormularios(TfrmCadClientes, frmCadClientes);
  Try
    Try
      frmCadClientes.strCodClienteIniciarCadastro := strCodCliLocal;
      frmCadClientes.ShowModal;
      Result := frmCadClientes.strUltimoCodigo;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  Finally
    pFreeAndNil(frmCadClientes);
  End;
end;


function TfrmCadClientes.fUsaCamposIvaEsp: Boolean;
begin
  Result := Pos(edtEstado.Text,'MT_CE_') > 0;
end;

function TfrmCadClientes.fValidaAcessoAltCanalAcesso: boolean;
begin
  objLiberacao.Clear;
  objLiberacao.strDirAce    := 'ALTCANALACESSO';
  objLiberacao.strMsgSen    := 'Alteração de Canal de Acesso no Cadastro de Cliente.';
  objLiberacao.strCodOpe    := strLoginUsuarioLogado;
  objLiberacao.objMsgLibera.pAddTextoCaption('Canal de Acesso Anterior: ', IIF(strCanalAnt = '', '(Vazio)',  strCanalAnt + ' - ' + fRetNomCanalAcesso(strCanalAnt)), 24);
  objLiberacao.objMsgLibera.pAddTextoCaption('Canal de Acesso Atual: ', IIF(edtCadCac.text = '', '(Vazio)', edtCadCac.text + ' - ' + fRetNomCanalAcesso(edtCadCac.text))  , 24);
  blnCanalAcessoLibera := objLiberacao.fLibera;
  result := blnCanalAcessoLibera;
end;

procedure TfrmCadClientes.pCarregaEnquadramentoIPI;
begin
  If Not fEmptyStr(dbeEnqIPI.Text) Then
    dbeDescEnqIPI.Text := fRetDescricaoEnquadramentoIPI(dbeEnqIPI.Text)
  Else
    dbeDescEnqIPI.Text := EmptyStr;
end;

procedure TfrmCadClientes.pCarregaResumo(ACodCli, ACodAbf: String);
begin
  fraClienteResumo.DataSource.DataSet := qryResumo;

  qryResumo.Close;
  qryResumo.SQL.Text := fSQLResumoDeBeneficiosDoCliente;
  qryResumo.ParamByName('CODCLI').AsString := ACodCli;
  qryResumo.ParamByName('CODABF').AsString := ACodAbf;
  qryResumo.Open;

  If qryResumo.RecordCount > 0 Then
    fraClienteResumo.pHabilitarDesabilitarInformacoesResumoBeneficios;
end;

procedure TfrmCadClientes.pExibeCamposAbreviacao(blnExibir: Boolean);
begin
  lblAbfTit.Visible := blnExibir;
  lblAbfDes.Visible := blnExibir;
  btnAbf.Visible    := blnExibir;
end;

procedure TfrmCadClientes.pCarregaBeneficios(strCodCli: String);
var
  qryAux : TUniQuery;
begin

  If Assigned(cdsCliBen) And (cdsCliBen.Active) Then
  Begin
    cdsCliBen.EmptyDataSet;

    pLimpaEditBeneficio;

    If fEmptyStr(strCodCli) Then
      Exit;

    qryAux := fCriaQuery(Self);

    Try

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT * FROM CLIBEN WHERE BEN_CODCLI = :CODCLI');
      qryAux.ParamByName('CODCLI').AsString := strCodCli;
      qryAux.Open;

      If Not qryAux.IsEmpty Then
      Begin

        qryAux.First;
        While Not qryAux.Eof Do
        Begin

          cdsCliBen.Append;
          cdsCliBen.FieldByName('BEN_CODCLI').AsString   := qryAux.FieldByName('BEN_CODCLI').AsString;
          cdsCliBen.FieldByName('BEN_CODCST').AsString   := qryAux.FieldByName('BEN_CODCST').AsString;
          cdsCliBen.FieldByName('BEN_CODBEN').AsString   := qryAux.FieldByName('BEN_CODBEN').AsString;
          cdsCliBen.Post;

          qryAux.Next;

        End;

      End;

    Finally
      FreeAndNil(qryAux);
    End;
  End;

end;

procedure TfrmCadClientes.pDeletaBeneficios(strCodCli: String);
var
  qryAux : TUniQuery;
begin
  If fEmptyStr(strCodCli) Then
    Exit;

  qryAux := fCriaQuery(Self);

  Try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('DELETE FROM CLIBEN WHERE BEN_CODCLI = :CODCLI');
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ExecSQL;

  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmCadClientes.fGravaBeneficios(strCodCli: String): Boolean;
var
  qryAux : TUniQuery;
begin
  Result := True;

  If fEmptyStr(strCodCli) Then
    Exit;

  pDeletaBeneficios(strCodCli);

  qryAux := fCriaQuery(Self);

  Try

    Try

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT * FROM CLIBEN WHERE FALSE');
      qryAux.Open;

      If Not cdsCliBen.IsEmpty Then
      Begin

        cdsCliBen.First;
        While Not cdsCliBen.Eof Do
        Begin

          qryAux.Append;
          qryAux.FieldByName('BEN_CODCLI').AsString   := cdsCliBen.FieldByName('BEN_CODCLI').AsString;
          qryAux.FieldByName('BEN_CODCST').AsString   := cdsCliBen.FieldByName('BEN_CODCST').AsString;
          qryAux.FieldByName('BEN_CODBEN').AsString   := cdsCliBen.FieldByName('BEN_CODBEN').AsString;
          qryAux.Post;

          cdsCliBen.Next;

        End;

      End;

    Finally
      FreeAndNil(qryAux);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pCarregaBeneficios(strCodCli);
      pMensagensErro(E.Message,'[TfrmCadClientes.pGravaBeneficios]');
    End;
  End;

end;

procedure TfrmCadClientes.pHabilitarAbaBeneficios(blnHabilitar: Boolean);
begin
  pnlBeneficioFiscal.Enabled := blnHabilitar;
  DBGridCliBen.ReadOnly      := Not blnHabilitar;
  pLimpaEditBeneficio;
end;

procedure TfrmCadClientes.pAtualizaEditBeneficio;
begin
  If Assigned(cdsCliBen) And (cdsCliBen.Active) And (cdsCliBen.RecordCount > 0) Then
  Begin
    edtBenCodCst.Text     := cdsCliBen.FieldByName('BEN_CODCST').AsString;
    edtBenCodBen.Text     := cdsCliBen.FieldByName('BEN_CODBEN').AsString;
  End;
end;

procedure TfrmCadClientes.pLimpaEditBeneficio;
begin
  edtBenCodCst.Clear;
  edtBenCodBen.Clear;
  pHabilitaCampo(edtBenCodCst);
end;

procedure TfrmCadClientes.BtnAdicionaBeneficioClick(Sender: TObject);
begin
  inherited;

  If Assigned(cdsCliBen) And (cdsCliBen.Active) Then
  Begin

    If fEmptyStr(edtBenCodCst.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Situação Tributária deve ser preenchida!', ['&Ok']);
      Exit;
    End;

    If fEmptyStr(edtBenCodBen.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código do Benefício deve ser preenchido!', ['&Ok']);
      Exit;
    End;

    If (Length(edtBenCodCst.Text) < 3) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Situaçao Tributária deve ser preenchida com 3 caracteres!', ['&Ok']);
      Exit;
    End;

    If (Not blnAlteraBeneficio) Then
    Begin
      If cdsCliBen.Locate('BEN_CODCST', edtBenCodCst.Text, []) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Situação Tributária '+edtBenCodCst.Text+' já foi cadastrada!', ['&Ok']);
        Exit;
      End;
    End;

    If blnAlteraBeneficio Then
      cdsCliBen.Edit
    Else
      cdsCliBen.Append;

    cdsCliBen.FieldByName('BEN_CODCLI').AsString   := qryTabela.FieldByName('CLI_CODCLI').AsString;
    cdsCliBen.FieldByName('BEN_CODCST').AsString   := edtBenCodCst.Text;
    cdsCliBen.FieldByName('BEN_CODBEN').AsString   := edtBenCodBen.Text;
    cdsCliBen.Post;

    BtnCancelaBeneficio.Click;

  End;

end;

procedure TfrmCadClientes.BtnCancelaBeneficioClick(Sender: TObject);
begin
  inherited;

  pLimpaEditBeneficio;
  blnAlteraBeneficio := False;
  pSetFocus(edtBenCodCst);
end;

procedure TfrmCadClientes.DBGridCliBenKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  inherited;

  If (Key = VK_RETURN) And (pnlBeneficioFiscal.Enabled) Then
  Begin
    If (Not cdsCliBen.IsEmpty) And ((qryTabela.State = dsEdit) Or (qryTabela.State = dsInsert)) Then
      If cdsCliBen.RecordCount >= 1 Then
      Begin
        pAtualizaEditBeneficio;
        pDesabilitaCampo(edtBenCodCst);
        pSetFocus(edtBenCodBen);
        blnAlteraBeneficio := True;
      End;
  End
  Else If (Key = VK_DELETE) And (pnlBeneficioFiscal.Enabled) Then
  Begin

    If (Not cdsCliBen.IsEmpty) And (Not DBGridCliBen.ReadOnly) Then
      If fMensagem('ATENÇÃO','Confirma exclusão da CST "' + cdsCliBen.FieldByName('BEN_CODCST').AsString + '" ?',['','']) = 1 then
        cdsCliBen.Delete;

  End
  Else If (Key = VK_ESCAPE) And (qryTabela.State = dsEdit) And (pnlBeneficioFiscal.Enabled) Then
  Begin
    BtnCancelaBeneficio.Click;
  End;

end;

procedure TfrmCadClientes.pHabilitaCampo(Sender: TEditFocus);
begin
  Sender.ReadOnly    := False;
  Sender.TabStop     := True;
  Sender.Color       := clWindow;
  Sender.NormalColor := clWindow;
end;

procedure TfrmCadClientes.pDesabilitaCampo(Sender: TEditFocus);
begin
  Sender.ReadOnly    := True;
  Sender.TabStop     := False;
  Sender.Color       := $00FFDFB8;
  Sender.NormalColor := $00FFDFB8;
end;

function TfrmCadClientes.fValidarPermissaoParaAlteracaoDeBairro(strCodCli, strCEP,
  strBaiDig: String; Var strBaiSug: String): Boolean;
  Var
    strCodCid: String;
    strEndere: String;
    strNomCid: String;
    strEstado: String;
    strCodCor: String;
begin
  Result := False;

  If (Not fCfgSis('USACEP', varBoolean)) Then
    Exit;

  If (Not fCadCepDadosCep(strCEP, strCodCid, strEndere, strBaiSug, strNomCid, strEstado, strCodCor, '', '')) Then
    Exit;

  If (fEmptyStr(strBaiSug)) Or (strBaiSug = strBaiDig) Then
    Exit;

  Result := True;
end;

function TfrmCadClientes.fVendedoresF4Alterados: Boolean;
var
  qryCliVen: TUniQuery;
begin
  qryCliVen := fCriaQuery(Self);
  try
    qryCliVen.Close;
    qryCliVen.SQL.Text :=
    ' SELECT '+
    '   AUTOINCREM '+
    ' FROM '+
    '   CLIVEN '+
    ' WHERE '+
    '   CVE_CODCLI = :CODCLI ';

    qryCliVen.ParamByName('CODCLI').AsString := qryTabela.FieldByName('CLI_CODCLI').AsString;
    qryCliVen.Open;

    Result := (cdsCliVendedoresMar.RecordCount <> qryCliVen.RecordCount);
  finally
    FreeAndNil(qryCliVen);
  end;

end;

function TfrmCadClientes.fEhNecessarioIntegrarContele: Boolean;
begin
  Result := False;

  if not fCfgSis('APICON', varBoolean) then
    Exit;

  if qryTabela.State = dsInsert then
    Exit(True);

  if fFieldsIntegracaoConteleFoiAlterado then
    Exit(True);

  if fVendedoresF4Alterados then
    Exit(True);
end;

procedure TfrmCadClientes.pAlterarStatusCpfCnpj;
begin
  If fPreencheuIDEstrangeiro Then
  Begin
    dbeCgcCpf.Text := EmptyStr;
    dbeCgcCpf.Enabled := False;
    dbeNuCpnj.Text := EmptyStr;
    dbeNuCpnj.Enabled := False;
  End
  Else
  Begin
    dbeCgcCpf.Enabled := ((qryTabela.State = dsInsert) Or (fVerificaAcessoSistema('ALTCGC', strLoginUsuarioLogado) And (qryTabela.State = dsEdit)));
    dbeNuCpnj.Enabled := dbeCgcCpf.Enabled;
  End;
end;

function TfrmCadClientes.fValidouIDEstrangeiro(const blnBuscaPorChave : Boolean): Boolean;
begin
  Result := True;

  If fEmptyStr(dbeIDEstrangeiro.Text) Then
    Exit;

  If Length(dbeIDEstrangeiro.Text) < 5 Then
  Begin
    Result := False;
    pMensagemOk('ID Estrangeiro deve conter 5 caracteres no mínimo!');
    Exit;
  End;

  If Length(dbeIDEstrangeiro.Text) > 20 Then
  Begin
    Result := False;
    pMensagemOk('ID Estrangeiro deve conter 20 caracteres no máximo!');
    Exit;
  End;

  If (Not blnBuscaPorChave) And (edtEstado.Text <> 'EX') Then
  Begin
    Result := False;
    pMensagemOk('Id Estrangeiro é permitido somente com UF "EX"');
    Exit;
  End;
end;

function TfrmCadClientes.fPreencheuIDEstrangeiro: Boolean;
begin
  Result := False;
  If (fCfgSis('TAGEST', varString) = 'N') Then
    Exit;
  Result := (Not fEmptyStr(dbeIDEstrangeiro.Text));
end;

function TfrmCadClientes.fValidaDireitoDeAcessoParaAlteracaoDeBairro(strCodCli,
   strNomCli, strCEP, strBaiDig: String; Var strBaiLib: String): Boolean;
  Var
    strBaiSug: String;
begin
  Result := True;

  If (Not fValidarPermissaoParaAlteracaoDeBairro(strCodCli, strCEP, strBaiDig, strBaiSug)) Then
    Exit;

  If (Not fVerificaAcessoSistema('CLIBAI', strLoginUsuarioLogado)) Then
  begin
    objLiberacao.Clear;
    objLiberacao.objMsgRemota.strDirAce := 'CLIBAI';

    objLiberacao.objMsgLibera.pAddTexto('Alteração de Bairro no Cadastro de Clientes');
    objLiberacao.objMsgLibera.pAddQuebra;

    If (fEmptyStr(strCodCli)) Or (fEmptyStr(strNomCli)) Then
      objLiberacao.objMsgLibera.pAddTexto('Novo Cadastro')
    Else
      objLiberacao.objMsgLibera.pAddTexto('Cliente: ' + strCodCli + '-' + strNomCli);

    objLiberacao.objMsgLibera.pAddTexto('CEP: '+ fFormataCEP(strCEP));
    objLiberacao.objMsgLibera.pAddTexto('Bairro Sugestão: '+ strBaiSug);
    objLiberacao.objMsgLibera.pAddTexto('Bairro Digitado: '+ strBaiDig);

    objLiberacao.strDirAce  := 'CLIBAI';
    objLiberacao.strSenLib  := fCfgSis('SENLBD');
    objLiberacao.strMsgSen  := 'Alteração de Bairro no Cadastro de Clientes';
    objLiberacao.strCodOpe  := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;

    If (Result) Then
      strBaiLib := strBaiDig;
  End;
end;

function TfrmCadClientes.fLiberaAlteracaoDeLimiteDeCredito(blnExibeAtual: Boolean): Boolean;
begin
  objLiberacao.Clear;
  objLiberacao.strDirAce    := 'LCRCLI';
  objLiberacao.strSenLib    := fCfgSis('SENCRE');
  objLiberacao.strMsgSen    := 'Limite de Crédito';
  objLiberacao.strCodOpe    := strLoginUsuarioLogado;
  objLiberacao.strCodDig    := strLoginUsuarioLogado;
  objLiberacao.strCliente   := (dbeCodCli.Text + '-' + dbeNomCli.Text);
  objLiberacao.strCpfCnpj   := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
  objLiberacao.objMsgLibera.pAddTexto('Troca de limite de crédito.');
  objLiberacao.objMsgLibera.pAddTextoCaption('Limite Anterior', fPadL(FloatToStrF(fltLimCreAnt, ffFixed, 15, 2), 15), 15);

  If (blnExibeAtual) Then
    objLiberacao.objMsgLibera.pAddTextoCaption('Limite Atual', fPadL(FloatToStrF(fStrToFloat(dbeLimCre.Text), ffFixed, 15, 2), 15), 15)
  Else If (blnLimCredAut) Then
    objLiberacao.objMsgLibera.pAddTexto('Atualização automática através do botão "Atualizar Limite de Crédito"');

  Result := objLiberacao.fLibera;
end;

function TfrmCadClientes.fProsseguirComAtualizacaoDeLimiteDeCredito: Boolean;
begin
  Result := False;

  If (fMensagem('ATENÇÃO!', 'Atualizar Limite de Crédito?', ['&Sim', '&Não']) = 2) Then
    Exit;

  If (Not fLiberaAlteracaoDeLimiteDeCredito(False)) Then
    Exit;

  Result := True;
end;

function TfrmCadClientes.fDataDeConsultaValida: Boolean;
begin
  Result := False;

  If (fEmptyStr(fTiraCaracEspeciais(dbeDtaCon.Text))) Then
    Exit;

  If ((StrToDate(dbeDtaCon.Text) + fCfgSis('QTEXCC', varInteger)) < VS_Date) Then
    Exit;

  Result := True;
end;

function TfrmCadClientes.fClienteComBoaQualidadeNoSerasa: Boolean;
begin
  Result := False;

  If (dbeQrdPro.Field.AsInteger > 0) Then
    Exit;

  If (dbeCheDev.Field.AsInteger > 0) Then
    Exit;

  If (dbePerfin.Field.AsInteger > 0) Then
    Exit;

  Result := True;
end;

procedure TfrmCadClientes.pAtribuiLimiteDeCreditoAuto;
  Var
    blnConsultaValida: Boolean;
    blnBoaQualidade: Boolean;
begin
  blnConsultaValida := fDataDeConsultaValida;
  blnBoaQualidade := fClienteComBoaQualidadeNoSerasa;

  If (blnConsultaValida) And (blnBoaQualidade) Then
    qryTabela.FieldByName('CLI_LIMCRE').AsFloat := fCfgSis('LIMCRN', varDouble);

  fltLimCreAnt := qryTabela.FieldByName('CLI_LIMCRE').AsFloat;
end;

procedure TfrmCadClientes.pAtualizaLimiteDeCreditoAuto;
  Var
    fltLimCreAut: Double;
begin
  fltLimCreAut := fRetValorLimCredAut;

  If (fltLimCreAut > 0) Then
    qryTabela.FieldByName('CLI_LIMCRE').AsFloat := fltLimCreAut;
end;

function TfrmCadClientes.fRetValorLimCredAut: Double;
  Var
    blnConsultaValida: Boolean;
    blnBoaQualidade: Boolean;
    fltMediaAtrasos: Double;
    fltVlrAcumulado: Double;
    fltLimSugerido: Double;
    fltLimAtualCli: Double;
    intMesesCadCli: Integer;
    intMesesVenda: Integer;
begin
  blnConsultaValida := fDataDeConsultaValida;
  blnBoaQualidade := fClienteComBoaQualidadeNoSerasa;
  fltLimAtualCli := qryTabela.FieldByName('CLI_LIMCRE').AsFloat;

  fltMediaAtrasos := fBuscaMediaDeAtraso(dbeCodCli.Text, '', False, fCfgSis('AJUDTA', varBoolean));
  fltMediaAtrasos := fFormataFloat(fltMediaAtrasos, 2);
  intMesesVenda := fCfgSis('MESCRE', varInteger);
  intMesesCadCli := MonthsBetween(Vs_date, qryTabela.FieldByName('CLI_DTACAD').AsDateTime);

  fltVlrAcumulado := fRetValorAcumuladoNoPeriodo(dbeCodCli.Text, IncMonth(Vs_date, - intMesesVenda));
  fltLimSugerido := fltVlrAcumulado / intMesesVenda;
  fltLimSugerido := fFormataFloat(fltLimSugerido, 2);

  If (blnConsultaValida) And (blnBoaQualidade) And (fltMediaAtrasos <= fCfgSis('MEDCRE', varDouble)) Then
  Begin
    If (intMesesCadCli > intMesesVenda) Or (fltLimSugerido > fltLimAtualCli) Then
    Begin
      Result := fltLimSugerido;
    End
    Else If (intMesesCadCli < intMesesVenda) And (fltLimSugerido < fltLimAtualCli) Then
    Begin
      Result := fltLimSugerido + fltLimAtualCli;
    End
    Else
      Result := fltLimAtualCli;
  End
  Else
    Result := fLimiteCreditoCliente(dbeCodCli.Text);
end;

procedure TfrmCadClientes.pHabilitaBotaoLimiteDeCredito(blnHabilita: Boolean);
begin
  btnLimCre.Visible := blnLimCredAut;
  btnLimCre.Enabled := blnHabilita;
  spdHelpLimCre.Visible := blnLimCredAut;
  spdHelpLimCre.Enabled := blnHabilita;
  dbeLimCre.Enabled := blnHabilita;
end;

function TfrmCadClientes.fGravaVendedor: Boolean;
begin
  Try
    Try
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.fExecutarAcao := fGravaVendedorProgresso;
      frmGravando.ShowModal;
      Result := frmGravando.blnConfirma;
    Except
      On E: Exception Do
      Begin
        Result := False;
        Raise;
      End;
    End;
  Finally
    FreeAndNil(frmGravando);
  End;
end;

function TfrmCadClientes.fGravaVendedorProgresso(cxProgressBar: TcxProgressBar): Boolean;
Var
  qryInsere: TUniQuery;
  blnInsMarca: Boolean;
  blnInsForn: Boolean;
begin
  Result := True;

  Try
    Try
      qryInsere := fCriaQuery;

      pExcluiVendAnteriores(qryTabela.FieldByName('CLI_CODCLI').AsString);

      cdsCliVendedoresMar.First;

      cxProgressBar.pSetMax(cdsCliVendedoresMar.RecordCount);

      While Not cdsCliVendedoresMar.Eof Do
      Begin
        blnInsMarca := Not fEmptyStr(cdsCliVendedoresMar.FieldByName('CVE_CODMAR').AsString);
        blnInsForn  := Not fEmptyStr(cdsCliVendedoresMar.FieldByName('CVE_CODFOR').AsString);

        qryInsere.Close;
        qryInsere.SQL.Clear;
        qryInsere.SQL.Add('INSERT INTO CLIVEN  ');
        qryInsere.SQL.Add('(                   ');
        qryInsere.SQL.Add('  CVE_CODCLI,       ');
        qryInsere.SQL.Add('  CVE_CODVEN,       ');
        qryInsere.SQL.Add('  CVE_DTVGIN,       ');
        qryInsere.SQL.Add('  CVE_DTVGFN,       ');

        If blnInsMarca Then
          qryInsere.SQL.Add('  CVE_CODMAR,     ');
        If blnInsForn Then
          qryInsere.SQL.Add('  CVE_CODFOR,     ');

        qryInsere.SQL.Add('  AUTOINCREM        ');
        qryInsere.SQL.Add(') VALUES (          ');
        qryInsere.SQL.Add('  :CODCLI,          ');
        qryInsere.SQL.Add('  :CODVEN,          ');
        qryInsere.SQL.Add('  :DTVGIN,          ');
        qryInsere.SQL.Add('  :DTVGFN,          ');

        If blnInsMarca Then
          qryInsere.SQL.Add('  :CODMAR,        ');
        If blnInsForn Then
          qryInsere.SQL.Add('  :CODFOR,        ');

        qryInsere.SQL.Add('  :AUTINC )         ');

        qryInsere.ParamByName('CODCLI').AsString   := cdsCliVendedoresMar.FieldByName('CVE_CODCLI').AsString;
        qryInsere.ParamByName('CODVEN').AsString   := cdsCliVendedoresMar.FieldByName('CVE_CODVEN').AsString;

        If (cdsCliVendedoresMar.FieldByName('CVE_DTVGIN').AsDateTime > 0) Then
          qryInsere.ParamByName('DTVGIN').AsDateTime := cdsCliVendedoresMar.FieldByName('CVE_DTVGIN').AsDateTime
        Else
          qryInsere.ParamByName('DTVGIN').Value := null;

        If (cdsCliVendedoresMar.FieldByName('CVE_DTVGFN').AsDateTime > 0) Then
          qryInsere.ParamByName('DTVGFN').AsDateTime := cdsCliVendedoresMar.FieldByName('CVE_DTVGFN').AsDateTime
        Else
          qryInsere.ParamByName('DTVGFN').Value := null;

        If blnInsMarca Then Begin
          If (Not fEmptyStr(cdsCliVendedoresMar.FieldByName('CVE_CODMAR').AsString)) Then
            qryInsere.ParamByName('CODMAR').AsString := cdsCliVendedoresMar.FieldByName('CVE_CODMAR').AsString
          Else
            qryInsere.ParamByName('CODMAR').Value := null;
        End;
        If blnInsForn Then
        Begin
          If (Not fEmptyStr(cdsCliVendedoresMar.FieldByName('CVE_CODFOR').AsString)) Then
            qryInsere.ParamByName('CODFOR').AsString := cdsCliVendedoresMar.FieldByName('CVE_CODFOR').AsString
          Else
            qryInsere.ParamByName('CODFOR').Value := null;
        End;

        If Length(cdsCliVendedoresMar.FieldByName('AUTOINCREM').AsString) < 10 Then
          qryInsere.ParamByName('AUTINC').AsString := fRetAutoIncrem('CLIVEN', VS_strCodEmp)
        Else qryInsere.ParamByName('AUTINC').AsString := cdsCliVendedoresMar.FieldByName('AUTOINCREM').AsString;

        qryInsere.ExecSQL;
        qryInsere.Close;

        cdsCliVendedoresMar.Next;

        pInformacao(
          'Aguarde... Gravando vendedores ' +
          IntToStr(cdsCliVendedoresMar.RecNo) + ' de ' +
          IntToStr(cdsCliVendedoresMar.RecordCount),
          cxProgressBar
        );

        cxProgressBar.pStep;
        Application.ProcessMessages;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        fRollBack;
        pMensagensErro(E.Message,'[TfrmCadClientes.fGravaVendedorProgresso]');
        Raise;
      End;
    End;
  Finally
    FreeAndNil(qryInsere);
  End;
end;

procedure TfrmCadClientes.BtnConsultaSerasaExperianClick(Sender: TObject);
begin
  inherited;
  ConsultaSerasaExperian;
end;

procedure TfrmCadClientes.ConsultaSerasaExperian;
  Var
    LConsultaSerasaExperian: TConsultaSerasaExperian;
    LAtualizar : Boolean;
    LDocumento: String;
    LDecisao:String;
begin

  Try
    Try

      If Not fVerificaAcessoSistema('CONSULTASPC') Then
      Begin
        objLiberacao.Clear;
        objLiberacao.strDirAce    := 'CONSULTASPC';
        objLiberacao.strMsgSen    := 'Consulta Serasa Experian';
        objLiberacao.strCodOpe    := strLoginUsuarioLogado;
        objLiberacao.strCodDig    := strLoginUsuarioLogado;
        objLiberacao.strCliente   := (dbeCodCli.Text + '-' + dbeNomCli.Text);
        objLiberacao.strCpfCnpj   := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);
        objLiberacao.objMsgLibera.pAddTexto('Permissão para realizar consulta no Serasa Experian');

        If Not objLiberacao.fLibera  Then
        Begin
          fMensagem('ATENÇÃO!', 'Operador sem permissão para realizar consulta no Serasa Experian!', ['&Ok']);
          Exit;
        End;
      End;


      LConsultaSerasaExperian := TConsultaSerasaExperian.Create;
      LDocumento := IfThen(dbeCpfDev.Visible, dbeCpfDev.Text, dbeNuCpnj.Text);

      LAtualizar := LConsultaSerasaExperian.RealizarConsulta(LDocumento,LDecisao);

      If LAtualizar Then
      Begin
        LConsultaSerasaExperian.SavePDF(fPastaConsultaCreditos(dbeCodCli.Field.DisplayText));

        dbeDtaCon.Field.AsDateTime := VS_Date;
        dbeQrdPro.Field.AsInteger  := LConsultaSerasaExperian.QuantidadeProtesto;
        dbeCheDev.Field.AsInteger  := LConsultaSerasaExperian.QuantidadeChequeDevolvido;

      End;


    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmCadClientes.ConsultaSerasaExperian]');
      End;
    End;

  Finally
    If Assigned(LConsultaSerasaExperian) Then
      FreeAndNil(LConsultaSerasaExperian);
  End;

end;

function TfrmCadClientes.UtilizaConsultaSerasaExperian: Boolean;
begin
  Result := True;

  If fEmptyStr(fCfgSis('CIDEXP', varString)) Then
     Exit(False);

  If fEmptyStr(fCfgSis('CSCEXP', varString)) Then
     Exit(False);

  If cmbTipoPesquisa.ItemIndex <> 1 Then // serasa
     Exit(False);

  If cbProdutoSerasa.ItemIndex <> 2 Then // Serasa Experian
     Exit(False);
end;

end.
