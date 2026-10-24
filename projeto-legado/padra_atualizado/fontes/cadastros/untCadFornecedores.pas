 {***************************}
{* qryConCid -> CADCID     *}
{* qryConCtt -> CADCID     *}
{* qryConAti -> CADATI     *}
{************************JB*}
{***************************}
{* qryCadAti -> CADATI     *}
{* qryCadCid -> CADCID     *}
{************************RV*}
unit untCadFornecedores;

interface

uses
  Windows, Classes, Controls, Forms, StdCtrls, untPaiCad, ComCtrls, Buttons,
  ExtCtrls, Mask, RlReport, DBCtrls, DBEditFocus, Menus, EditFocus, DBMemoFocus,
  QColorLabel, Grids, DBGridCitel, DBGrids, MaskEditFocus, untForCtt, Contnrs, DB, UniClientDataSet,
  Uni, AppEvnts, untCadForPre, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls, cxGridCustomView,
  cxGrid, UniDataSetProvider, cxMaskEdit, untMskTelefone, untDBECgcCpf,
  untDBETipoCgcCpf, untLabelRg, untLabelCgcCpf, untCadRepFor,
  BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, MemDS, DBAccess, Provider,
  untTypesSistema, frxClass, frxExportCSVTestabilidade, DirectoryEditFocus,
  untCadFornecedoresNeoGrid, cxContainer, cxTextEdit, cxButtonEdit, untExcel,
  DBComboBoxFocus, ComboBoxFocus, Datasnap.DBClient, cxGridCitel,
  untFornecedorBosh, cxDataControllerConditionalFormattingRulesManagerDialog,
  untFuncoesPedidoSimples, untPercentMinMaxFornecedor, Dialogs,
  untGrupoCompraFornec, cxCheckBox, cxCurrencyEdit, cxGroupBox, cxButtons,
  untPrazoEntregaFornecedor, untFiliasAutonomasFornecedor, untLimiteComprasFornecedor,
  untFrameCentroCustoEditFocus, untFrameDirectoryEditFocus, dxScreenTip,
  dxCustomHint, cxHint, frxExportRTF, frxExportXLS, frxExportHTML, frxExportPDF,
  frxDBSet, untFramePlanoDeContasDBEditFocus, untFramePlanoDeContasMaskEdit, JPEG,
  System.Generics.Collections, System.ImageList, Vcl.ImgList, cxImageList, cxImage,
  dxPDFDocument, dxBarBuiltInMenu, dxCustomPreview, dxPDFViewer, cxDBEdit,
  Vcl.Graphics, dxGDIPlusClasses,
  untCfgWpp, untObservacao;

type
  TfrmCadFornecedores = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label2: TLabel;
    dbeDtaCad: TDBEditFocus;
    dbeNomFor: TDBEditFocus;
    Label3: TLabel;
    dbeNomFan: TDBEditFocus;
    Label4: TLabel;
    dbeEndere: TDBEditFocus;
    Label5: TLabel;
    Label6: TLabel;
    dbeBairro: TDBEditFocus;
    dbeCodCid: TDBEditFocus;
    Label7: TLabel;
    Label9: TLabel;
    dbeNumCep: TDBEditFocus;
    dbeCaiPos: TDBEditFocus;
    Label10: TLabel;
    Label12: TLabel;
    dbeNumIes: TDBEditFocus;
    Label13: TLabel;
    dbeFone01: TDBEditFocus;
    Label14: TLabel;
    dbeFon02: TDBEditFocus;
    dbeNumFax: TDBEditFocus;
    Label15: TLabel;
    dbeContato: TDBEditFocus;
    Label16: TLabel;
    Label17: TLabel;
    dbeEmail: TDBEditFocus;
    dbeHomPag: TDBEditFocus;
    Label18: TLabel;
    Label19: TLabel;
    dbeCodAti: TDBEditFocus;
    Label20: TLabel;
    edtCidade: TEditFocus;
    edtEstado: TEditFocus;
    edtAtividade: TEditFocus;
    pnlFundo: TPanel;
    Label21: TLabel;
    dbeComissao: TDBEditFocus;
    Label47: TLabel;
    dbeNumRg: TDBEditFocus;
    Label23: TLabel;
    dbeObserv: TDBMemoFocus;
    tbsContatos: TTabSheet;
    pnlContatos: TPanel;
    dbgContatos: TDBGridCitel;
    Label24: TLabel;
    edtNomCtt: TEditFocus;
    Label25: TLabel;
    edtEndCtt: TEditFocus;
    Label26: TLabel;
    edtBaiCtt: TEditFocus;
    Label27: TLabel;
    Label28: TLabel;
    edtDesCidCtt: TEditFocus;
    edtCidCtt: TEditFocus;
    Label29: TLabel;
    edtEstadoCtt: TEditFocus;
    Label30: TLabel;
    edtEmaCtt: TEditFocus;
    cdsForCtt: TUniClientDataSet;
    dtsForCtt: TDataSource;
    cdsForCttNOMCTT: TStringField;
    cdsForCttENDCTT: TStringField;
    cdsForCttBAICTT: TStringField;
    cdsForCttNOMCID: TStringField;
    cdsForCttESTCID: TStringField;
    cdsForCttTELCTT: TStringField;
    cdsForCttEMACTT: TStringField;
    cdsForCttCODCID: TStringField;
    lblDesPlaCon: TLabel;
    dbeConCon: TDBEditFocus;
    Label32: TLabel;
    dbe0800__: TDBEditFocus;
    Label37: TLabel;
    dbeStatus: TDBEditFocus;
    ColorLabel2: TColorLabel;
    Label34: TLabel;
    Label35: TLabel;
    cdsForCttCELCTT: TStringField;
    cdsForCttFAXCTT: TStringField;
    edtDepCtt: TEditFocus;
    Label36: TLabel;
    cdsForCttDEPCTT: TStringField;
    Label38: TLabel;
    dbeEndNum: TDBEditFocus;
    Label39: TLabel;
    dbeEndCom: TDBEditFocus;
    Label40: TLabel;
    dbeSimPau: TDBEditFocus;
    dbeNumCel: TDBEditFocus;
    lblCelular: TLabel;
    lblPerFFx: TLabel;
    dbePerFCx: TDBEditFocus;
    dtsTabela: TDataSource;
    tbsPreFor: TTabSheet;
    pnlItens: TPanel;
    dbgItens: TDBGridCitel;
    dtsForCta: TDataSource;
    Label42: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    Label43: TLabel;
    edtPreFor: TEditFocus;
    edtRefere: TEditFocus;
    Label44: TLabel;
    Label45: TLabel;
    dbeUltAlt: TDBEditFocus;
    Label46: TLabel;
    dbeEmail2: TDBEditFocus;
    dbeOpeAlt: TDBEditFocus;
    edtNomOpe: TEditFocus;
    chkCmpCtt: TCheckBox;
    cdsForCttCMPCTT: TStringField;
    mskTelCtt: TMaskEditTelefone;
    mskCelCtt: TMaskEditTelefone;
    mskFaxCtt: TMaskEditTelefone;
    dbeNumCgc: TDBEditCgcCpf;
    dbeCgcCpf: TDBEditTipoCgcCpf;
    tbsCentCust: TTabSheet;
    pnlForCta: TPanel;
    cxgCentCust: TcxGrid;
    cxgForCtaView: TcxGridDBTableView;
    cxgColCodCta: TcxGridDBColumn;
    cxgColDesCta: TcxGridDBColumn;
    cxgForCta: TcxGridLevel;
    dtsForCenCus: TDataSource;
    cdsForCta: TUniClientDataSet;
    qryForCta: TUniQuery;
    dspForCta: TUniDataSetProvider;
    cdsForCtaCTF_CODCTA: TStringField;
    cdsForCtaCTF_CODEMP: TStringField;
    cdsForCtaCTA_DESCTA: TStringField;
    cdsForCtaCTF_CODFOR: TStringField;
    LabelCgcCpf1: TLabelCgcCpf;
    Panel1: TPanel;
    LabelRg1: TLabelRg;
    tbsCompras: TTabSheet;
    pnl1: TPanel;
    lbl3: TLabel;
    dbeCndPag: TDBEditFocus;
    lbl4: TLabel;
    dbeCodTrans: TDBEditFocus;
    edtNomTrans: TEditFocus;
    dbeEmaPed: TDBEditFocus;
    lbl5: TLabel;
    lblVlRed2: TLabel;
    dbeVlRed2: TDBEditFocus;
    lbl2: TColorLabel;
    lbl6: TLabel;
    dbeCarPag: TDBEditFocus;
    lbl7: TLabel;
    dbeDesVis: TDBEditFocus;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    tbsRepresentante: TTabSheet;
    dtsRepFor: TDataSource;
    Label60: TLabel;
    dbeAcoObj: TDBEditFocus;
    ColorLabel1: TColorLabel;
    btnFichaCad: TBitBtnLocked;
    btnAdicionarCtt: TBitBtnLocked;
    btnCancelaCtt: TBitBtnLocked;
    btnAddIte: TBitBtnLocked;
    btnCanIte: TBitBtnLocked;
    btnIncCta: TBitBtnLocked;
    lbl11: TLabel;
    dbeEmail3: TDBEditFocus;
    lbl12: TLabel;
    dbeRevist: TDBEditFocus;
    ColorLabel19: TColorLabel;
    lbl13: TLabel;
    btnAltPar: TBitBtnLocked;
    lblMinOrc: TLabel;
    dbeMinOrc: TDBEditFocus;
    Label61: TLabel;
    dbeDiaEnt: TDBEditFocus;
    lbl14: TLabel;
    dbeZonFra: TDBEditFocus;
    ColorLabel4: TColorLabel;
    tbsForConconEmp: TTabSheet;
    Panel2: TPanel;
    Label62: TLabel;
    Label63: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    edtConcon: TEditFocus;
    grdEmpFor: TDBGridCitel;
    pnlCampos: TPanel;
    btnIncluirCC: TBitBtnLocked;
    btnAlterarCC: TBitBtnLocked;
    btnExcluirCC: TBitBtnLocked;
    btnCancelarCC: TBitBtnLocked;
    dtsEmpFor: TDataSource;
    cdsEmpFor: TUniClientDataSet;
    cdsEmpForCodEmp: TStringField;
    cdsEmpForNomEmp: TStringField;
    cdsEmpForConcon: TStringField;
    cdsEmpForCodigo: TStringField;
    cdsEmpForAUTOINCREM: TStringField;
    dbchkDesmembr: TDBCheckBox;
    tbsNeoGrid: TTabSheet;
    dtsNeoGri: TDataSource;
    pnlTipAbf: TPanel;
    lblAbfTit: TLabel;
    lblAbfDes: TLabel;
    btnAbf: TBitBtnLocked;
    dbeObsCmp: TDBMemoFocus;
    Label64: TLabel;
    cbxMarRev: TComboBoxFocus;
    tbsRetencoes: TTabSheet;
    dtsForRet: TDataSource;
    cdsForRet: TUniClientDataSet;
    dspForRet: TUniDataSetProvider;
    qryForRet: TUniQuery;
    btnGravarCC: TBitBtnLocked;
    cdsForRetAUTOINCREM: TStringField;
    cdsForRetRET_ALIQUO: TFloatField;
    cdsForRetRET_DIAVEN: TIntegerField;
    cdsForRetDESTIP: TStringField;
    cdsForRetDESVEN: TStringField;
    cdsForRetDESEVE: TStringField;
    cdsForRetDESCTA: TStringField;
    cdsForRetDESFOR: TStringField;
    cdsForRetRET_TIPRET: TStringField;
    cdsForRetRET_CODFOR: TStringField;
    cdsForRetRET_CODEVE: TStringField;
    cdsForRetRET_CODCTA: TStringField;
    cdsForRetRET_TIPVEN: TStringField;
    cdsForRetRET_FORRET: TStringField;
    cdsForRetFOR_NOMFOR: TStringField;
    cdsForRetCTA_DESCTA: TStringField;
    cdsForRetEVE_DESEVE: TStringField;
    tbsBosch: TTabSheet;
    dtsCndPagBosh: TDataSource;
    Label259: TLabel;
    dbeConRed: TDBEditFocus;
    ColorLabel3: TColorLabel;
    btnConsultaFit: TBitBtnLocked;
    lblCliFor: TLabel;
    dbeCodCli: TDBEditFocus;
    edtNomCli: TEditFocus;
    dbeMinPed: TDBEditFocus;
    LabelDesMinPed: TLabel;
    grbNivel: TcxGroupBox;
    cmbTipNiv: TComboBoxFocus;
    cxgNivel: TcxGridCitel;
    cxvNivel: TcxGridDBTableViewCitel;
    cxvNivelNIVGIR: TcxGridDBColumn;
    cxvNivelUSANIV: TcxGridDBColumn;
    cxvNivelQTDDIA: TcxGridDBColumn;
    cxvNivelPERCON: TcxGridDBColumn;
    cxgNivelLevel1: TcxGridLevel;
    dtsBcoFor: TDataSource;
    cdsBcoFor: TUniClientDataSet;
    cdsBcoForAUTOINCREM: TStringField;
    cdsBcoForBCF_CODFOR: TStringField;
    cdsBcoForBCF_CODBCO: TStringField;
    cdsBcoForBANCO: TStringField;
    cdsBcoForBCF_NUMAGE: TStringField;
    cdsBcoForBCF_DIGAGE: TStringField;
    cdsBcoForAGENCIA: TStringField;
    cdsBcoForBCF_NUMCTA: TStringField;
    cdsBcoForBCF_DIGCTA: TStringField;
    cdsBcoForCONTA: TStringField;
    cdsBcoForBCF_DIGVER: TStringField;
    cdsBcoForBCF_CAMCEN: TStringField;
    cdsBcoForBCF_COMPDES: TStringField;
    cdsBcoForBCF_NOMTIT: TStringField;
    tbsDadosDeposito: TTabSheet;
    pnlContaBancaria: TPanel;
    grbDadosBancarios: TGroupBox;
    cdsBcoForBCO_NOMBCO: TStringField;
    grbCalMinMax: TGroupBox;
    cxgMinMax: TcxGridCitel;
    cxvMinMax: TcxGridDBTableViewCitel;
    cxvMinMaxNIVABC: TcxGridDBColumn;
    cxvMinMaxNIVXYZ: TcxGridDBColumn;
    cxvMinMaxPERMIN: TcxGridDBColumn;
    cxvMinMaxPERMAX: TcxGridDBColumn;
    cxvMinMaxELECON: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    dbePlaNco: TDBEditFocus;
    edtDesPlaNco: TEditFocus;
    btnPlaNco: TBitBtnLocked;
    tbsPraEnt: TTabSheet;
    pnlComprador: TPanel;
    cxgEmpresas: TcxGrid;
    cxvEmpresas: TcxGridDBTableView;
    cxvEmpresasColumn1: TcxGridDBColumn;
    cxvEmpresasColumn2: TcxGridDBColumn;
    cxvEmpresasPRAENT: TcxGridDBColumn;
    cxvEmpresasVALMIN: TcxGridDBColumn;
    cxgEmpresasLevel1: TcxGridLevel;
    Label97: TLabel;
    dbeCompra: TDBEditFocus;
    edtDesCompra: TEditFocus;
    tsbAutonomas: TTabSheet;
    cxvSatelites: TcxGridDBTableView;
    cxgSatelitesLevel1: TcxGridLevel;
    cxgSatelites: TcxGrid;
    cxvSatelitesCODEMP: TcxGridDBColumn;
    cxvSatelitesNOMEMP: TcxGridDBColumn;
    cxvSatelitesAUTONO: TcxGridDBColumn;
    Panel3: TPanel;
    cxvSatelitesTIPEMP: TcxGridDBColumn;
    Panel4: TPanel;
    btnMarcaTodasAutonoma: TBitBtnLocked;
    btnDesmarcaTodasAutonoma: TBitBtnLocked;
    tbsValorPedido: TTabSheet;
    Panel5: TPanel;
    btnExcluiLimMes: TBitBtnLocked;
    btnImpArq: TBitBtnLocked;
    btnHlpImp: TBitBtnLocked;
    pnlInclusao: TPanel;
    Label72: TLabel;
    Label77: TLabel;
    mskMesAno: TMaskEditFocus;
    edtValMes: TEditFocus;
    btnIncLimPed: TBitBtnLocked;
    cxgLimitePedidos: TcxGrid;
    cxvLimitePedidos: TcxGridDBTableView;
    cxvLimitePedidosCODFOR: TcxGridDBColumn;
    cxvLimitePedidosNOMFOR: TcxGridDBColumn;
    cxvLimitePedidosANOMES: TcxGridDBColumn;
    cxvLimitePedidosColumn1: TcxGridDBColumn;
    cxvLimitePedidosVALLIM: TcxGridDBColumn;
    cxgLimitePedidosLevel1: TcxGridLevel;
    btnHelpLimPedCom: TBitBtnLocked;
    tbsGruCom: TTabSheet;
    pnlGruCom1: TPanel;
    Label71: TLabel;
    btnIncGru: TBitBtnLocked;
    mskCodGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    pnlGruCom2: TPanel;
    btnDelGru: TBitBtnLocked;
    cxgGrupos: TcxGrid;
    cxvGrupos: TcxGridDBTableView;
    cxvGruposCODGRU: TcxGridDBColumn;
    cxvGruposDESGRU: TcxGridDBColumn;
    cxgGruposLevel1: TcxGridLevel;
    btnImpExcel: TBitBtnLocked;
    Label78: TLabel;
    edtNomPor: TEditFocus;
    dbeCodPor: TDBEditFocus;
    Label79: TLabel;
    dbeCodTransRedes: TDBEditFocus;
    edtNomTransRedes: TEditFocus;
    cmbTipFre: TComboBoxFocus;
    Label80: TLabel;
    Label81: TLabel;
    cmbTipFreRedespacho: TComboBoxFocus;    
    btnCadClientes: TBitBtnLocked;    
    btnCadTransportadora: TBitBtnLocked;
    cxvEmpresasDIACOM: TcxGridDBColumn;
    cxHintStyleController1: TcxHintStyleController;
    Tributações: TTabSheet;
    cdsBcoForBCF_CTAPAG: TStringField;
    cdsBcoForBCF_DESPAG: TStringField;
    Label84: TLabel;
    ColorLabel5: TColorLabel;
    dbeAncora: TDBEditFocus;
    rdgBSTXML: TDBRadioGroup;
    btnHelp: TBitBtnLocked;
    cxHintStyleController2: TcxHintStyleController;
    HintControler: TcxHintStyleController;
    frxExpPDF: TfrxPDFExport;
    frxExpHtml: TfrxHTMLExport;
    frxExpXLS: TfrxXLSExport;
    frxReport: TfrxReport;
    frxExpRTF: TfrxRTFExport;
    frxGen: TfrxUserDataSet;
    DtsFicha: TDataSource;
    fraPlanoDeContasCmp: TfraPlanoDeContasDBEditFocus;
    fraPlanoDeContasPl: TfraPlanoDeContasMskEdit;
    fraPlanoDeContasAux: TfraPlanoDeContasDBEditFocus;
    CdsFicha: TUniClientDataSet;
    CdsFichaCODFOR: TStringField;
    CdsFichaNOMFOR: TStringField;
    CdsFichaENDERE: TStringField;
    CdsFichaENDNUM: TStringField;
    CdsFichaDTACAD: TStringField;
    CdsFichaNOMFAN: TStringField;
    CdsFichaC_E_P_: TStringField;
    CdsFichaBAIRRO: TStringField;
    CdsFichaCGCCPF: TStringField;
    CdsFichaC_G_C_: TStringField;
    CdsFichaI_E_S_: TStringField;
    CdsFichaCONTAT: TStringField;
    CdsFichaCAIPOS: TStringField;
    CdsFichaFONE01: TStringField;
    CdsFichaFONE02: TStringField;
    CdsFichaF_A_X_: TStringField;
    CdsFicha_0800_: TStringField;
    CdsFichaEMAIL_: TStringField;
    CdsFichaHOMEPA: TStringField;
    CdsFichaCNDPAG: TStringField;
    CdsFichaCONCON: TStringField;
    CdsFichaCODCTA: TStringField;
    CdsFichaCODTRA: TStringField;
    CdsFichaNUMRG_: TStringField;
    CdsFichaMATREV: TStringField;
    CdsFichaPERCOM: TStringField;
    CdsFichaSTATUS: TStringField;
    CdsFichaNOMCID: TStringField;
    CdsFichaESTADO: TStringField;
    CdsFichaDESATI: TStringField;
    frxDBFichaForn: TfrxDBDataset;
    CdsFichaOBSERV: TStringField;
    cxvEmpresasColumn3: TcxGridDBColumn;
    cxvEmpresasColumn4: TcxGridDBColumn;
    cxvEmpresasColumn5: TcxGridDBColumn;
    cxvEmpresasColumn6: TcxGridDBColumn;
    lblSEMAGEResp: TColorLabel;
    dbeSEMAGE: TDBEditFocus;
    lblSEMAGE: TLabel;
    lblPALREC: TLabel;
    DBEPALREC: TDBEditFocus;
    lblPALREC_SN: TColorLabel;
    grpPixDoFornecedor: TGroupBox;
    pnlCamposPix: TPanel;
    Label88: TLabel;
    cmbTipoDoPix: TComboBoxFocus;
    Label89: TLabel;
    edtCPFCNPJPix: TEditFocus;
    edtChavePix: TEditFocus;
    pnlAcoesPix: TPanel;
    btnIncluirPix: TBitBtnLocked;
    btnAlterarPix: TBitBtnLocked;
    btnExcluirPix: TBitBtnLocked;
    btnCancelarPix: TBitBtnLocked;
    btnGravarPix: TBitBtnLocked;
    dbgChavesPix: TDBGridCitel;
    pnlDadosBancariosGrid: TPanel;
    dbgBcoFor: TDBGridCitel;
    pnlAcoesDD: TPanel;
    btnIncluirDD: TBitBtnLocked;
    btnAlterarDD: TBitBtnLocked;
    btnExcluirDD: TBitBtnLocked;
    btnCancelarDD: TBitBtnLocked;
    btnGravarDD: TBitBtnLocked;
    pnlDadosBancarios: TPanel;
    lblCodBco: TLabel;
    Label73: TLabel;
    lblConCor: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    ColorLabel6: TColorLabel;
    lblNomTit: TLabel;
    edtCodBco: TEditFocus;
    edtNomBco: TEditFocus;
    edtNumAge: TEditFocus;
    edtDigAge: TEditFocus;
    edtNumCta: TEditFocus;
    edtDigCta: TEditFocus;
    edtDigVer: TEditFocus;
    edtCamCen: TEditFocus;
    edtCompDes: TEditFocus;
    edtNomTit: TEditFocus;
    dbchkCtaPag: TDBCheckBox;
    lblConCol: TLabel;
    dbeConCol: TDBEditFocus;
    clrConCol: TColorLabel;
    Label50: TLabel;
    dbeEmpPas: TDBEditFocus;
    ColorLabel7: TColorLabel;
    cblpeicms: TColorLabel;
    DBEPEICMS: TDBEditFocus;
    lblPeiIcms: TLabel;
    clbNotDes: TColorLabel;
    dbeNotDes: TDBEditFocus;
    lblNotDes: TLabel;
    ImageSefaz: TcxImageList;
    pnlPedidoCompraDolar: TPanel;
    dbePedidoCompraDolar: TDBEditFocus;
    ColorLabel9: TColorLabel;
    pnlCompraImportacao: TPanel;
    ColorLabel11: TColorLabel;
    DBEditFocus1: TDBEditFocus;
    cdsForRetNOMPOR: TStringField;
    cdsForRetPOR_NOMPOR: TStringField;
    cdsForRetRET_CODPOR: TStringField;
    tbsGestaoControle: TTabSheet;
    pnlDadosCertificado: TPanel;
    odgCertGestao: TOpenDialog;
    pnlCabecalhoCert: TPanel;
    lblObgGestao: TLabel;
    ColorLabel10: TColorLabel;
    dbeObgCtrlGestao: TDBEditFocus;
    Label87: TLabel;
    lblValCertificado: TLabel;
    dbeValidade: TDBEditFocus;
    dxPDFViewer: TdxPDFViewer;
    pnlCabecalho: TPanel;
    imgCertificado: TImage;
    lblCertVencido: TLabel;
    popMenuCert: TPopupMenu;
    miBuscar: TMenuItem;
    miExportar: TMenuItem;
    miVisualizar: TMenuItem;
    btnOpcoesCert: TCxButton;
    fodExportarCert: TFileOpenDialog;
    lblDesBavBap: TLabel;
    lblPctDav: TLabel;
    dbeDesBav: TDBEditFocus;
    lblPctDap: TLabel;
    dbeDesBap: TDBEditFocus;
    dbeCodCnd: TDBEditFocus;
    btnAbrirPastaCliente: TBitBtnLocked;
    DBRadioGroup1: TDBRadioGroup;
    pnlNeoGrid: TPanel;
    lbl15: TLabel;
    lbl16: TLabel;
    lbl17: TLabel;
    lbl18: TLabel;
    lbl19: TLabel;
    lblINIARQ: TLabel;
    lblExpTigre: TLabel;
    lblExpTigreSN: TColorLabel;
    dbeEanCli: TDBEditFocus;
    fraPatArq: TfraDirectoryEditFocus;
    dbeSeqArq: TDBEditFocus;
    dbeDtaArq: TDBEditFocus;
    cbxLayNeo: TComboBoxFocus;
    DBEINIARQ: TDBEditFocus;
    dbeExpTigre: TDBEditFocus;
    pnlBOSH: TPanel;
    edtDivVen: TComboBoxFocus;
    edtTipPed: TComboBoxFocus;
    btnTabelaCondpagBosch: TBitBtnLocked;
    edtTipEnt: TEditFocus;
    fraDirBosh: TfraDirectoryEditFocus;
    Label67: TLabel;
    Label66: TLabel;
    Label69: TLabel;
    Label68: TLabel;
    pnlImpParaServicos: TPanel;
    grbDadosRetencoes: TGroupBox;
    lblTipo: TLabel;
    lblAliq: TLabel;
    lblForn: TLabel;
    lblPortador: TLabel;
    cmbTipImp: TComboBoxFocus;
    edtAliq: TEditFocus;
    edtDesFor: TEditFocus;
    edtCodFor: TEditFocus;
    rdgVencimento: TRadioGroup;
    edtVencimento: TEditFocus;
    fraCentroCusto: TfraCentroCustoEditFocus;
    fraPlanoDeContasImp: TfraPlanoDeContasMskEdit;
    edtCodPorRet: TEditFocus;
    edtNomPorRet: TEditFocus;
    grdImpostos: TcxGridCitel;
    grdImpostosTableView1: TcxGridDBTableViewCitel;
    grdImpostosDESTIP: TcxGridDBColumn;
    grdImpostosRET_ALIQUO: TcxGridDBColumn;
    grdImpostosDESFOR: TcxGridDBColumn;
    grdImpostosNOMPOR: TcxGridDBColumn;
    grdImpostosDESCTA: TcxGridDBColumn;
    grdImpostosDESEVE: TcxGridDBColumn;
    grdImpostosDESVEN: TcxGridDBColumn;
    grdImpostosRET_DIAVEN: TcxGridDBColumn;
    grdImpostosRET_TIPRET: TcxGridDBColumn;
    grdImpostosLevel1: TcxGridLevel;
    Label65: TLabel;
    pnlBotoesImp: TPanel;
    btnIncluirImp: TBitBtnLocked;
    btnAlterarImp: TBitBtnLocked;
    btnExcluirImp: TBitBtnLocked;
    btnCancelarImp: TBitBtnLocked;
    btnGravarImp: TBitBtnLocked;
    pnlFunrural: TPanel;
    grbFunrural: TGroupBox;
    Label50x: TLabel;
    Label85: TLabel;
    lblEventos: TLabel;
    fraPlanoDeContasFunrural: TfraPlanoDeContasDBEditFocus;
    dbeFunruralFornecedor: TDBEditFocus;
    edtFunruralNomFor: TEditFocus;
    dbeFunruralAliquota: TDBEditFocus;
    rdgFunruralVenc: TDBRadioGroup;
    dbeFunruralDiaVenc: TDBEditFocus;
    dbeCodEve: TDBEditFocus;
    edtDesEve: TEditFocus;
    chkUsaFunrural: TDBCheckBox;
    pnlFundoTribut: TPanel;
    Panel6: TPanel;
    GroupBox1: TGroupBox;
    chkFOR_ADIDCI: TDBCheckBox;
    chkFOR_ADPCIP: TDBCheckBox;
    GroupBox2: TGroupBox;
    Label57: TLabel;
    Label70: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    chkFOR_ADPCPC: TDBCheckBox;
    chkFOR_IFDAPC: TDBCheckBox;
    dbeAlqPis: TDBEditFocus;
    dbeAlqCof: TDBEditFocus;
    chkFOR_ADICPC: TDBCheckBox;
    GroupBox4: TGroupBox;
    chkFOR_ADIDPC: TDBCheckBox;
    chkFOR_FDAICD: TDBCheckBox;
    chkFOR_IDPCID: TDBCheckBox;
    GroupBox3: TGroupBox;
    chkFOR_ADIDST: TDBCheckBox;
    chkFOR_REDPIS: TDBCheckBox;
    GroupBox5: TGroupBox;
    chkFOR_ADIDIC: TDBCheckBox;
    chkFOR_ADPCST: TDBCheckBox;
    Panel7: TPanel;
    Label181: TLabel;
    dbeSuframa: TDBEditFocus;
    pnlFundoRepresentante: TPanel;
    pnlNomRep: TPanel;
    Label8: TLabel;
    dbeRepRazSoc: TDBEditFocus;
    pnlDadosRep: TPanel;
    LabelCgcCpf2: TLabelCgcCpf;
    Label11: TLabel;
    Label22: TLabel;
    Label31: TLabel;
    Label33: TLabel;
    Label48: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label56: TLabel;
    Label59: TLabel;
    Label55: TLabel;
    Label58: TLabel;
    dbeRepCgcCpf: TDBEditTipoCgcCpf;
    dbeRepNumCGC: TDBEditCgcCpf;
    dbeRepNumIES: TDBEditFocus;
    dbeRepFone01: TDBEditFocus;
    dbeRepFax: TDBEditFocus;
    dbeRepNumCel: TDBEditFocus;
    dbeRepCodCid: TDBEditFocus;
    edtRepEst: TEditFocus;
    dbeRepNumCep: TDBEditFocus;
    dbeRepEndere: TDBEditFocus;
    dbeRepNum: TDBEditFocus;
    dbeRepEndCom: TDBEditFocus;
    dbeRepBairro: TDBEditFocus;
    dbeRepEmail: TDBEditFocus;
    dbeRepContat: TDBEditFocus;
    edtRepCidade: TEditFocus;
    Label86: TLabel;
    dbeCODGEF: TDBEditFocus;
    edtDESGEF: TEditFocus;
    imgWppCtt: TImage;
    Panel8: TPanel;
    btnGatWpp: TBitBtnLocked;
    btnObsCmp: TBitBtnLocked;
    Panel9: TPanel;
    Label93: TLabel;
    DBEditFocus2: TDBEditFocus;
    cbxCPRB: TComboBoxFocus;
    lblCPRB: TLabel;
    Label41: TLabel;
    frxAjudaImpCSV: TfrxReport;
    gbpREINF: TGroupBox;
    lblNatRend: TLabel;
    lblTipServ: TLabel;
    edtNatRend: TEditFocus;
    edtTipoServico: TEditFocus;
    dbeCodNatRend: TDBEditFocus;
    dbeCodTipServ: TDBEditFocus;
    edtCndDescri: TEditFocus;
    frxHelp: TfrxReport;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodAtiKeyPress(Sender: TObject; var Key: Char);
    function dbeCodCidChamaCadastro(Key: Word): String;
    function dbeCodAtiChamaCadastro(Key: Word): String;
    function dbeCodTraChamaCadastro(Key: Word): String;
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAdicionarCttClick(Sender: TObject);
    procedure btnCancelaCttClick(Sender: TObject);
    procedure edtCidCttKeyPress(Sender: TObject; var Key: Char);
    procedure dbgContatosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbeCodTransKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCgcCpfExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCidCttKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCidCttEnter(Sender: TObject);
    procedure edtCidCttExit(Sender: TObject);
    procedure dbgContatosEnter(Sender: TObject);
    procedure dbeObservKeyPress(Sender: TObject; var Key: Char);
    procedure btnFichaCadClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbeNumCepKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddIteClick(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnCanIteClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
    procedure btnIncCtaClick(Sender: TObject);
    procedure cxgColCodCtaPropertiesChange(Sender: TObject);
    procedure cdsForCtaBeforeDelete(DataSet: TDataSet);
    procedure cdsForCtaAfterDelete(DataSet: TDataSet);
    procedure dbeRepCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure dbeRepCgcCpfExit(Sender: TObject);
    procedure dbeRepNumCepKeyPress(Sender: TObject; var Key: Char);
    procedure btnAltParClick(Sender: TObject);
    procedure dtsTabelaDataChange(Sender: TObject; Field: TField);
    procedure dtsTabelaStateChange(Sender: TObject);
    procedure btnIncluirCCClick(Sender: TObject);
    procedure btnGravarCCClick(Sender: TObject);
    procedure btnAlterarCCClick(Sender: TObject);
    procedure btnExcluirCCClick(Sender: TObject);
    procedure grdEmpForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure btnCancelarCCClick(Sender: TObject);
    procedure btnAbfClick(Sender: TObject);
    procedure btnIncluirImpClick(Sender: TObject);
    procedure btnCancelarImpClick(Sender: TObject);
    procedure btnAlterarImpClick(Sender: TObject);
    procedure btnGravarImpClick(Sender: TObject);
    procedure btnExcluirImpClick(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure rdgVencimentoClick(Sender: TObject);
    procedure rdgVencimentoExit(Sender: TObject);
    procedure edtVencimentoExit(Sender: TObject);
    procedure grdImpostosTableView1DblClick(Sender: TObject);
    procedure grdImpostosTableView1EditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure grdImpostosRET_ALIQUOGetDataText(Sender: TcxCustomGridTableItem;
      ARecordIndex: Integer; var AText: string);
    procedure cbxLayNeoChange(Sender: TObject);
    procedure edtTipPedChange(Sender: TObject);
    procedure edtDivVenChange(Sender: TObject);
    procedure edtTipEntChange(Sender: TObject);
    procedure btnTabelaCondpagBoschClick(Sender: TObject);
    procedure btnConsultaFitClick(Sender: TObject);
    procedure dbeCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure cmbTipNivChange(Sender: TObject);
    procedure cxvNivelEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure cxvNivelQTDDIAPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cdsBcoForAGENCIAGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cdsBcoForCONTAGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure btnIncluirDDClick(Sender: TObject);
    procedure btnGravarDDClick(Sender: TObject);
    procedure btnAlterarDDClick(Sender: TObject);
    procedure btnCancelarDDClick(Sender: TObject);
    procedure dbgBcoForDblClick(Sender: TObject);
    procedure dbgBcoForKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dtsBcoForStateChange(Sender: TObject);
    procedure cdsBcoForAfterScroll(DataSet: TDataSet);
    procedure cdsBcoForBANCOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure btnExcluirDDClick(Sender: TObject);
    procedure edtCodBcoKeyPress(Sender: TObject; var Key: Char);
    procedure cxvMinMaxEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure pCarregaPlanoContabil(const blnBuscaPorChave: Boolean=False);
    procedure dbePlaNcoKeyPress(Sender: TObject; var Key: Char);
    procedure btnPlaNcoClick(Sender: TObject);
    procedure dbeCompraKeyPress(Sender: TObject; var Key: Char);
    procedure cxvEmpresasPRAENTPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvEmpresasVALMINPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnMarcaTodasAutonomaClick(Sender: TObject);
    procedure btnDesmarcaTodasAutonomaClick(Sender: TObject);
    procedure btnExcluiLimMesClick(Sender: TObject);
    procedure btnImpArqClick(Sender: TObject);
    procedure btnIncLimPedClick(Sender: TObject);
    procedure cxvLimitePedidosColumn1GetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxvLimitePedidosVALLIMPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnIncGruClick(Sender: TObject);
    procedure mskCodGruExit(Sender: TObject);
    procedure mskCodGruKeyPress(Sender: TObject; var Key: Char);
    procedure btnImpExcelClick(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
    procedure edtCodBcoExit(Sender: TObject);
    procedure btnHelpLimPedComClick(Sender: TObject);
    procedure dbeCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodTransRedesKeyPress(Sender: TObject; var Key: Char);
    procedure btnCadClientesClick(Sender: TObject);
    procedure btnCadTransportadoraClick(Sender: TObject);
    procedure cxvEmpresasMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure cxvEmpresasDIACOMPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cdsBcoForCalcFields(DataSet: TDataSet);
    procedure btnHelpMouseLeave(Sender: TObject);
    procedure edtDigVerEnter(Sender: TObject);
    procedure edtDigVerExit(Sender: TObject);
    procedure edtDigVerMouseEnter(Sender: TObject);
    procedure edtDigVerMouseLeave(Sender: TObject);
    procedure edtDigCtaExit(Sender: TObject);
    procedure fraPlanoDeContasAuxdbeCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasCmpdbeCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasPlMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasImpMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure btnIncluirPixClick(Sender: TObject);
    procedure cmbTipoDoPixChange(Sender: TObject);
    procedure btnAlterarPixClick(Sender: TObject);
    procedure btnGravarPixClick(Sender: TObject);
    procedure btnCancelarPixClick(Sender: TObject);
    procedure btnExcluirPixClick(Sender: TObject);
    procedure edtCPFCNPJPixExit(Sender: TObject);
    procedure dbgChavesPixDblClick(Sender: TObject);
    procedure dbgChavesPixKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCPFCNPJPixEnter(Sender: TObject);
    procedure dbeSimPauExit(Sender: TObject);
    procedure DBEPEICMSExit(Sender: TObject);
    procedure chkUsaFunruralClick(Sender: TObject);
    procedure dbeFunruralFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure cmbTipImpSelect(Sender: TObject);
    procedure edtCodPorRetKeyPress(Sender: TObject; var Key: Char);
    procedure tbsGestaoControleEnter(Sender: TObject);
    procedure miBuscarClick(Sender: TObject);
    procedure miVisualizarClick(Sender: TObject);
    procedure miExportarClick(Sender: TObject);
    procedure btnOpcoesCertClick(Sender: TObject);
    procedure dbeCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure btnAbrirPastaClienteClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbeCODGEFKeyPress(Sender: TObject; var Key: Char);
    procedure btnGatWppClick(Sender: TObject);
    procedure btnObsCmpClick(Sender: TObject);
    procedure cbxMarRevChange(Sender: TObject);
    procedure dbeCodNatRendKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodTipServKeyPress(Sender: TObject; var Key: Char);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
    FHintDisplayed2: Boolean;
    FHintDisplayed: Boolean;
    FColumn: TcxGridColumn;
    FcdsNCO : TUniClientDataset;

    IntAbaSel: Integer;
    objNiveis: TNivelGiroCriticidade;

    objMinMax: TPercentMinMaxFornecedor;

    objForPre: TForPre;
    objRepFor: TCadRepFor;

    objFiliasAutonomasFornecedor: TFiliasAutonomasFornecedor;
    objLimite: TLimiteComprasFornecedor;

    objNeoGrid: TCadFornecedoresNeoGrid;
    objFornecedorBosh: TFornecedorBosh;

    strCepAnt: String;
    strRepCepAnt: String;
    strNomAnt: String;
    strCidAnt: String;
    strCgcAnt: String;
    strIesAnt: String;
    strEndAnt: String;
    strNumAnt: String;
    strComAnt: String;
    strBaiAnt: String;

    objForCtt: TForCtt;
    lstContatos: TObjectList;
    blnAltContato: Boolean;
    blnBranco: Boolean;

    qryConCtt: TUniQuery;
    qryConAti: TUniQuery;
    qryConCid: TUniQuery;
    qryConCidRep: TUniQuery;
    qryCadAti: TUniQuery;
    qryCadCid: TUniQuery;
    qryCadCta: TUniQuery;
    qryConFor: TUniQuery;
    qryConCli: TUniQuery;
    qryConBco: TUniQuery;
    qryConCnd : TUniQuery;

    cdsCtaAux: TUniClientDataSet;


    strCodFor : String;
    strCodCta : String;
    strCodEmp : String;
    strNomEmp: String;

    strStatus: string;

    blnDelCta : Boolean;
    blnVinculaCliFor : Boolean;
    blnUTIPCM : Boolean;

    blnUtilizarCrm : Boolean;
    strRegraCRM  : String;
    strCampoCRM  : String;
    strForneCRM  : String;
    strDesCamCRM : String;

    blnInsertDadosBancarios: Boolean;
    blnUtiCon : Boolean;

    objPraEmp: TPrazoEntregaFornecedor;

    FDatasetForPix,
    FDatasetForPixClone: TUniClientDataSet;

    FTipoDocumentoAnterior: String;

    strPlCtaAuxOld,
    strPlCtaCmpOld,
    strPlCtaImpOld : String;
    blnTemDivergenciaSefaz: Boolean;


    Procedure pLimpaTelaLimitePedido;

    procedure pAjustaNumeroPaginas;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pCarregaOperador;
    procedure pCarregaCidade(qryConsulta: TUniQuery; edtCidade, edtEstado: TEdit;
      dbeCidade, dbeCep: TDBEditFocus; Var strCepAnt: String);
    procedure pCarregaCidadeCtt;
    procedure pCarregaAtividade;
    procedure pCarregaGrupoEconomico;
    procedure pCarregaTransportador(blnTransRedespacho: Boolean);
    procedure pLimpaEdits;
    procedure pLimpaEditsContatos;

    procedure pAtribuiTabelas;
    procedure pAfterScroll(DataSet: TDataSet);

    procedure pCarregaComplementosNeoGrid;
    procedure pTrataCarregaMentoCRM;
    procedure pTrataCarregamentoConsulta;
    procedure pCarregaContatos(strCodFor: String);
    procedure pAdicionaContatoCds(objContato: TForCtt);
    procedure pCarregaContatoAlteracao;
    procedure pAtualizaEditsContato(DataSet: TDataSet);
    procedure pCarregaCentroDeCusto(mksCodCta: TMaskEdit; edtDesCta: TEditFocus);
    procedure pCarregaCentroDeCustoDB(dbeCodCta: TDBEditFocus; edtDesCta: TEditFocus);
    procedure pCarregaCentroDeCustoCxg(strCodFor: String);
    procedure pIncluiCentroDeCusto;
    procedure pGravaCentrosDeCusto;
    function fGravaCentrosDeCusto: Boolean;
    function fClienteVinculado(strCodCli : string) : boolean;

    function fExisteConContabil: String;
    procedure pBuscaFornecedor(strCodFor: String = '');
    procedure pCarregaCliente;

    procedure pCarregaTabelaFicha(cdsFichas: TUniClientDataSet);

    {*******************************}
    {          MODULO CRM           }
    {****************************AC*}
    procedure pAplicarRegrasCrm;
    procedure pAplicarRegrasCrmFornecedores;
    procedure pProcuraCampoFornecedorCRM;
    procedure pPesquisaFornecedoresCRM;
    procedure pAplicarRegrasCrmContatos;
    procedure pProcuraCampoContatoCRM;
    function fPodeAlterarCnpj(strCodFor, strNovoCnpj: String): Boolean;

    procedure pGravaAlteracoesParticipante(dtsEstado: TDataSetState; strNomAnt,
      strCidAnt, strCgcAnt, strIesAnt, strEndAnt, strNumAnt, strComAnt,
      strBaiAnt: String);

    procedure pInicializaVariaveis;
    procedure pUpdateCaption;
    procedure pMontaModelosLayoutCoral;
    procedure pCarregaFornecedor;
    procedure pCarregaFornecedorGeral;

    procedure pLimpaCamposEmpFor;
    procedure pCarregaDescrEmpresa;
    procedure pEnviaGravacao;
    procedure pEnviaEdicao;
    procedure pInsereRegEmpFor;
    procedure pEditaRegEmpFor;
    procedure pDeletaRegEmpFor;
    procedure pCarregaGridEmpFor;
    procedure pControlaBotoes;

    function fEmpresaJaDesmembr(strCodEmp: String): Boolean;
    function fCertificadoGestaoInformado: boolean;
    function fValidaCamposCCFORE(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
    procedure pAtualizaTipAbf;
    procedure pCarregaTipoFornecedores;
    procedure pCarregarRetencoes;
    procedure pLimparDadosRetencoes;
    procedure pHabilitarBotoesImp(blnIncAlt: Boolean);
    procedure pGravarDadosRetencoes;
    procedure pEscondeTextIniArquivo();
    procedure pPreparaBosh;

    procedure pCarregarDadosBancarios;
    procedure pLimparDadosBancarios;
    procedure pHabilitarBotoesDD(blnIncAlt: Boolean);
    procedure pGravarDadosBancarios;
    procedure pCarregaBanco;
    procedure pEhContaComDoisDigitos;
    procedure pHabilitaDigVerificador(blnHabilita : Boolean);

    procedure HabilitarBotoesPix(AEmEdicao: Boolean);
    function RetornaTipoChavePix(AIndiceComboBox: Integer): String;

    function ValidaCamposDeDadosBancarios: Boolean;
    function ValidaCamposPix: Boolean;
    function ValidaPixUtilizado: Boolean;

    procedure GravarDadosPix;
    procedure FDatasetForPixOnAfterScroll(DataSet: TDataSet);

    function fGetSQLDadosBancarios: String;
    procedure pCarregaPortador;
    procedure pAtualizaCodCliFornecedor(strCodCli: String);

    procedure pCarregaFornecedorFunrural;
    procedure pCarregaEventoDB(dbeCodEve: TDBEditFocus; edtDesEve: TEditFocus);
    procedure UtilizaCadastroDeCondicaoDePagamento;
    procedure pLimparCertficadoAnterior;
    procedure pCarregaCondicao;
    procedure pMostrarObsCmp;

    procedure pCarregaNaturezaRedimentoReinf;
    procedure pCarregaTipoServicoReinf;

  protected
    blnCarregamentoExterno : Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    procedure pEscapePressed; override;
    procedure pValidaTamCampo;
  public
    { Public declarations }
    strCodForExterno : String;
    fMskCon : TfMskCon;
    pPlanoDeContasPorEmpresa : TpPlanoDeContasPorEmpresa;
    fVerificarPlanoDeContasPorEmpresa : TfVerificarPlanoDeContasPorEmpresa;
    fSemMascaraPlaNco: TfSemMascaraPlaNco;
    fPesqPlanoContabil: TfPesqPlanoContabil;
    fCampoTabelaPlanco: TfCampoTabelaPlanco;
    pGravarPlanoContasAutomatico: TpGravarPlanoContasAutomatico;
    pGravarPlanoContasAutomaticoParaCadaEmpresa: TpGravarPlanoContasAutomaticoParaCadaEmpresa;
    fCriaEstruturaCdsNCO: TfCriaEstruturaCdsNCO;
    pCarregaPlanoDeContasPorEmpresa: TpCarregaPlanoDeContasPorEmpresa;
    pSalvaPlanoDeContasPorEmpresa: TpSalvaPlanoDeContasPorEmpresa;
    fCadastroRapidoCliente: TfCadastroRapidoCliente;
    fCadastroRapidoTransportadora: TfCadastroRapidoTransportadora;
    strCodFornecedorIniciarCadastro: String;
    procedure pSetaParametrosCRM(strNomCampoCRM, strCodForCRM, strNomRegraCRM: String; strDesCampoCRM: String = '');
    procedure pIniciaCadExterno;

    class function fCarregaFornecedorExterno(strCodFor: String; frmFornec: TfrmCadFornecedores = nil): string;

    class function fCadastroRapidoFornecedor(Var strCodFor: String;
                                             strNomFor,
                                             strNomFan,
                                             strEndere,
                                             strBairro,
                                             strCodCid,
                                             strNumCep,
                                             strFone01,
                                             strNumRg,
                                             strEmail,
                                             strStatus,
                                             strNumCgc,
                                             strFon02,
                                             strNumCel,
                                             strHomPag,
                                             strCodCli,
                                             strInsEst,
                                             strCodAti: String;
                                             intCgcCpf: integer): Boolean;
    class function fAlteraCadFor(const strCodForLocal: String): String;
  end;

var
  frmCadFornecedores: TfrmCadFornecedores;

implementation

uses SysUtils, Variants, StrUtils, DateUtils, untFuncoesSimples, untPai,
    untFuncIns2, untPesqAux, untConsultas, untCadCidades,
    untCadCid, untLiberacaoFactory, untFuncoesGenerica, untConstantes, untLogAlteracaoParticipante,
    untCadAltPar, System.Types, untPnlDadosFornecedor, untPanelCxFornecedor,
    untCadAbreviacaoFiscal, untCadPagBosch, untIConsultaCadastroFit, untFuncoesConsulta,
    untILiberacao, untMsgLiberacao, untTipoFreteAtc,
  untImagens, untFuncoesImagem, untGravaArquivoPasta;

{$R *.dfm}

procedure TfrmCadFornecedores.FormCreate(Sender: TObject);
var intTipFre: Integer;
begin
  objPraEmp := TPrazoEntregaFornecedor.Create(Self);
  blnCarregamentoExterno := False;
  cxvEmpresas.DataController.DataSource := objPraEmp.dtsSource;

  objFiliasAutonomasFornecedor := TFiliasAutonomasFornecedor.Create(Self);
  cxvSatelites.DataController.DataSource := objFiliasAutonomasFornecedor.dtsSource;

  objLimite := TLimiteComprasFornecedor.Create(Self);
  cxvLimitePedidos.DataController.DataSource := objLimite.dtsSource;

  strCodFornecedorIniciarCadastro := '';
  blnUtilizarCrm := False;
  strRegraCRM    := '';
  strCampoCRM    := '';
  strForneCRM    := '';
  strDesCamCRM   := '';

  pInicializaVariaveis;

  qryConCid    := fCriaQuery(Self);
  qryConCidRep := fCriaQuery(Self);
  qryConCtt    := fCriaQuery(Self);
  qryConAti    := fCriaQuery(Self);
  qryCadCta    := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryConCli    := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  qryConBco    := fCriarQuery('SELECT * FROM CADBCO WHERE FALSE', Self);
  qryConCnd    := fCriarQuery('SELECT * FROM CADCND WHERE FALSE', Self);

  inherited;

  if fCfgSis('UTIWPP', varBoolean) then
  begin
    lblCelular.Caption := 'Cel/Whatsapp';
    imgWppCtt.Visible := True;
    btnGatWpp.Visible := True;
  End;


  FcdsNCO := Nil ;

  objNiveis := TNivelGiroCriticidade.Create(Self);
  cxvNivel.DataController.DataSource := objNiveis.dtsSource;

  lblConCol.Visible := fCfgSis('CONCOL', varBoolean);
  dbeConCol.Visible := lblConCol.Visible;
  clrConCol.Visible := lblConCol.Visible;

  grbCalMinMax.Visible := fCfgSis('ESPMIN', varBoolean);

  If grbCalMinMax.Visible Then
  Begin
    objMinMax := TPercentMinMaxFornecedor.Create(Self);
    cxvMinMax.DataController.DataSource := objMinMax.dtsSource;
  End
  Else objMinMax := Nil;

  objRepFor := TCadRepFor.Create(Self);
  dtsRepFor.DataSet := objRepFor;

  objForPre := TForPre.Create(Self);
  dtsForCta.DataSet := objForPre.cdsItens;
  edtPreFor.EditFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));

  blnUTIPCM := fCfgSis('UTIPCM', varBoolean);



  strNomeTabela         := 'CADFOR';
  strNomeCampo          := 'FOR_CODFOR';
  qryTabela             := fCriaQuery(Self);
  qryTabela.AfterScroll := pAfterScroll;
  qryTabela.AfterOpen   := pAfterOpen;
  dtsTabela.DataSet     := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  objForCtt := TForCtt.Create;
  blnAltContato := False;

  cdsEmpFor.CreateDataSet;
  cdsBcoFor.CreateDataSet;
  CdsFicha.CreateDataSet;

  cdsForCtt.CreateDataSet;
  cdsForCtt.AfterScroll := pAtualizaEditsContato;
  pgcDados.ActivePageIndex := 0;

  objFornecedorBosh := TFornecedorBosh.Create();
  tbsBosch.TabVisible  := fCfgSis('USBOSC', varBoolean);

  If fCfgSis('USACTF', varBoolean) Then
  Begin
    cdsCtaAux := TUniClientDataSet.Create(Nil);
    fraPlanoDeContasCmp.Visible := False;
  End
  Else
    tbsCentCust.TabVisible := False;

  pAjustaNumeroPaginas;

  objNeoGrid := TCadFornecedoresNeoGrid.Create(Self);
  dtsNeoGri.DataSet := objNeoGrid;
  pMontaModelosLayoutCoral;

  dbeExpTigre.Visible := fCfgSis('AUTDOW', varBoolean);
  lblExpTigre.Visible := fCfgSis('AUTDOW', varBoolean);
  lblExpTigreSN.Visible := fCfgSis('AUTDOW', varBoolean);

  If objConsultaCadastroFit = nil Then
  Begin
    btnConsultaFit.Visible := False;
    dbeNumCgc.Width := 213;
  End;

  blnInsertDadosBancarios := False;

  fMskCon := Nil;
  fSemMascaraPlaNco := Nil;
  fPesqPlanoContabil := Nil;
  fCampoTabelaPlanco := Nil;
  pPlanoDeContasPorEmpresa := Nil;
  fVerificarPlanoDeContasPorEmpresa := Nil ;
  pGravarPlanoContasAutomatico := Nil;
  pGravarPlanoContasAutomaticoParaCadaEmpresa := Nil;
  fCriaEstruturaCdsNCO := Nil;
  pCarregaPlanoDeContasPorEmpresa := Nil;
  pSalvaPlanoDeContasPorEmpresa := Nil;
  fCadastroRapidoCliente := Nil;
  fCadastroRapidoTransportadora := Nil;

  blnUtiCon := fCfgSis('UTICON', varBoolean);

  cmbTipFre.Clear;
  For intTipFre In TiposFrete Do
    cmbTipFre.Items.Add(fDescricaoFrete(IntToStr(intTipFre)));


  cmbTipFreRedespacho.Clear;
  For intTipFre In TiposFrete Do
    cmbTipFreRedespacho.Items.Add(fDescricaoFrete(IntToStr(intTipFre)));

  DBEPALREC.Visible := fCfgSis('CCDPRM', varBoolean) And fUsaRotinaWMS;
  lblPALREC.Visible := DBEPALREC.Visible;
  lblPALREC_SN.Visible := DBEPALREC.Visible;
  blnTemDivergenciaSefaz := False;

  FDatasetForPix := TUniClientDataSet.Create(Nil);

  pnlPedidoCompraDolar.Visible := fCfgSis('COTDOR', varBoolean);
  pnlCompraImportacao.Visible := fCfgSis('PEDIMP', varBoolean);
end;

procedure TfrmCadFornecedores.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(FcdsNCO) then
    FreeAndNil(FcdsNCO) ;
end;

procedure TfrmCadFornecedores.pAjustaNumeroPaginas;
  Var
    intIndice,
    intContador: Integer;
    strNomPag  : String;
Begin
  intContador := 0;

  For intIndice := 0 To pgcDados.PageCount - 1 Do
  Begin

    If pgcDados.Pages[intIndice].TabVisible Then
    Begin
      Inc(intContador);

      strNomPag := pgcDados.Pages[intIndice].Caption;

      Delete(strNomPag, 1, pos('-', strNomPag) - 2);

      If (pgcDados.Pages[intIndice] <> tbsBosch) Then
        strNomPag := '&' + IntToStr(intContador) + strNomPag
      Else
        strNomPag := IntToStr(intContador) + strNomPag;

      pgcDados.Pages[intIndice].Caption := strNomPag;
    End;

  End;
  intPaginasAtivas := intContador;
  pAtribuiTags;
End;

procedure TfrmCadFornecedores.pAplicarRegrasCrm;
begin
  If strRegraCRM = 'Fornecedores' Then
    pAplicarRegrasCrmFornecedores
  Else If strRegraCRM = 'Contatos' Then
    pAplicarRegrasCrmContatos;
end;

procedure TfrmCadFornecedores.pAplicarRegrasCrmContatos;
begin
  btnPesquisaClick(Self);
  btnAlterarClick(Self);
  pProcuraCampoContatoCRM;
end;

procedure TfrmCadFornecedores.pAplicarRegrasCrmFornecedores;
begin
  btnPesquisaClick(Self);
  btnAlterarClick(Self);
  pProcuraCampoFornecedorCRM;
end;

procedure TfrmCadFornecedores.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin

    If FindField('FOR_CODCFO') <> nil Then
      TStringField(FieldByName('FOR_CODCFO')).EditMask :=
        '9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-' +
        '9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-' +
        '9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-' +
        '9999-9999-9999-9999-9999-9999-9999-9999-9999-9999;0;_';

    If FindField('FOR_DTACAD') <> nil Then
      TDateField(FieldByName('FOR_DTACAD')).EditMask := '99/99/9999';

    If FindField('FOR_DTAALT') <> nil Then
      TDateField(FieldByName('FOR_DTAALT')).EditMask := '99/99/9999';

    If FindField('FOR_CERVAL') <> nil Then
      TDateField(FieldByName('FOR_CERVAL')).EditMask := '99/99/9999';


    If FindField('FOR_C_E_P_') <> nil Then
      TStringField(FieldByName('FOR_C_E_P_')).EditMask := '99999-999;0;_';

    If FindField('FOR_FONE01') <> nil Then
      TStringField(FieldByName('FOR_FONE01')).EditMask := fRetMascaraFonePais;

    If FindField('FOR_FONE02') <> nil Then
      TStringField(FieldByName('FOR_FONE02')).EditMask := fRetMascaraFonePais;

    If FindField('FOR_F_A_X_') <> nil Then
      TStringField(FieldByName('FOR_F_A_X_')).EditMask := fRetMascaraFonePais;

    If FindField('FOR_CNDPAG') <> nil Then
      TStringField(FieldByName('FOR_CNDPAG')).EditMask := '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999;0;_';

    If FindField('FOR_PERCOM') <> nil Then
      TFloatField(FieldByName('FOR_PERCOM')).DisplayFormat := '#,##0.00';

    If FindField('FOR_ALQPIS') <> nil Then
      TFloatField(FieldByName('FOR_ALQPIS')).DisplayFormat := '#,##0.0000';

    If FindField('FOR_ALQCOF') <> nil Then
      TFloatField(FieldByName('FOR_ALQCOF')).DisplayFormat := '#,##0.0000';

    If FindField('FOR_PISCOF') <> nil Then
      TFloatField(FieldByName('FOR_PISCOF')).DisplayFormat := '#,##0.00';

    If FindField('FOR_0800__') <> nil Then
      TStringField(FieldByName('FOR_0800__')).EditMask := '9999-9999-9999;0;_';

    If FindField('FOR_NUMCEL') <> nil Then
      TStringField(FieldByName('FOR_NUMCEL')).EditMask := fRetMascaraFonePais;

    If FindField('FOR_PERFCX') <> nil Then
      TFloatField(FieldByName('FOR_PERFCX')).DisplayFormat := '#,##0.00';

    If FindField('FOR_DESVIS') <> nil Then
      TFloatField(FieldByName('FOR_DESVIS')).DisplayFormat := '#,##0.00';

    If FindField('FOR_MINORC') <> nil Then
      TFloatField(FieldByName('FOR_MINORC')).DisplayFormat := '#,##0.00';

    If FindField('FOR_MINPED') <> nil Then
      TFloatField(FieldByName('FOR_MINPED')).DisplayFormat := '#,##0.00';

    If (FindField('FOR_PLANCO') <> Nil) And (Assigned(fMskCon)) Then
      TStringField(FieldByName('FOR_PLANCO')).EditMask := fMskCon;
  End;
end;

procedure TfrmCadFornecedores.pAfterScroll(DataSet: TDataSet);
Begin

  If (dbeCgcCpf.Text = '1') Then
    qryTabela.FieldByName('FOR_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_);

  If (dbeCgcCpf.Text = '2') Then
    qryTabela.FieldByName('FOR_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_P_F_);

  If (dbeRepCgcCpf.Text = '1') Then
    objRepFor.FieldByName('REP_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_);

  If (dbeRepCgcCpf.Text = '2') Then
    objRepFor.FieldByName('REP_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_P_F_);

  objForPre.strCodFor := dbeCodigo.Text;
  objForPre.pCarregarItens;
  pAtualizaTipAbf;
End;

function TfrmCadFornecedores.fPodeAlterarCnpj(strCodFor, strNovoCnpj: String): Boolean;
  Var
    qryCnpjsNFe: TUniQuery;
    dtaBase: TDateTime;
begin
  dtaBase := IncYear(VS_Date, -2);
  qryCnpjsNFe := fCriaQuery(Self);
  qryCnpjsNFe.SQL.Add('SELECT ');
  qryCnpjsNFe.SQL.Add('  DISTINCT SUBSTR(FIS_ACESSO, 07, 14) AS CNPJS ');
  qryCnpjsNFe.SQL.Add('FROM ');
  qryCnpjsNFe.SQL.Add('  CADFIS ');
  qryCnpjsNFe.SQL.Add('WHERE ');
  qryCnpjsNFe.SQL.Add('  FIS_FORCLI = :CODFOR AND ');
  qryCnpjsNFe.SQL.Add('  FIS_TIP_FC = "F" AND ');
  qryCnpjsNFe.SQL.Add('  FIS_DTAENT >= :DTABAS AND ');
  qryCnpjsNFe.SQL.Add('  IFNULL(FIS_ACESSO, "") <> "" ');

  qryCnpjsNFe.ParamByName('CODFOR').AsString := strCodFor;
  qryCnpjsNFe.ParamByName('DTABAS').AsDateTime := dtaBase;
  qryCnpjsNFe.Open;

  If qryCnpjsNFe.IsEmpty Then
  Begin
    Result := True;
  End
  Else
  Begin
    If qryCnpjsNFe.RecordCount = 1 Then
    Begin
      If (qryCnpjsNFe.FieldByName('CNPJS').AsString = strNovoCnpj) Then
      Begin
        Result := True;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Este forneceddor já tem Notas Fiscais Eletrônicas associadas, portanto não é permitido alterar o CNPJ.' + #13#10 +
          'Por favor, cadastre um novo fornecedor.', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      //Deixa o cara alterar, e conforme der problema no SPED arruma um por um.
      Result := True;
    End;
  End;

  FreeAndNil(qryCnpjsNFe);
end;


procedure TfrmCadFornecedores.fraPlanoDeContasAuxdbeCodCtaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************RV*}
  If fPesqCentroCusto(Self, fraPlanoDeContasAux.dbeCodCta, fraPlanoDeContasAux.edtDesCta, Nil, Key, arrCentroCusto) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
    pCarregaCentroDeCustoDB(fraPlanoDeContasAux.dbeCodCta, fraPlanoDeContasAux.edtDesCta);

    If (qryTabela.State In [dsInsert]) or (strPlCtaAuxOld <>  fraPlanoDeContasAux.dbeCodCta.Text) Then
      PlanoDeContasAtivo(fraPlanoDeContasAux.dbeCodCta.Text,True);
  End;
end;

procedure TfrmCadFornecedores.fraPlanoDeContasCmpdbeCodCtaKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContasCmp.dbeCodCta, fraPlanoDeContasCmp.edtDesCta, Nil, Key, arrCentroCusto) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
    pCarregaCentroDeCustoDB(fraPlanoDeContasCmp.dbeCodCta, fraPlanoDeContasCmp.edtDesCta);

    If (qryTabela.State In [dsInsert]) or (strPlCtaCmpOld <>  fraPlanoDeContasCmp.dbeCodCta.Text) Then
      PlanoDeContasAtivo(fraPlanoDeContasCmp.dbeCodCta.Text,True);
  End;

end;

procedure TfrmCadFornecedores.fraPlanoDeContasImpMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrCtaFor : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then Begin
    If fPesqCentroCusto(Self, fraPlanoDeContasImp.MskCodCta, fraPlanoDeContasImp.edtDesCta, nil, Key, arrCtaFor) Then Begin
      fValidaCampos(fraPlanoDeContasImp.MskCodCta, False);
      SelectNext(ActiveControl, True, True);
    End;
  End;

end;

procedure TfrmCadFornecedores.fraPlanoDeContasPlMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrCtaFor : TConsultasArray;

begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    If fPesqCentroCusto(Self, fraPlanoDeContasPl.MskCodCta, fraPlanoDeContasPl.edtDesCta, nil, Key, arrCtaFor) Then
    Begin
      fValidaCampos(fraPlanoDeContasPl.MskCodCta, False);
      SelectNext(ActiveControl, True, True);
    End;
  End;


end;

function TfrmCadFornecedores.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  Var
    strCodCid: String;
    strEndere: String;
    strBairro: String;
    strNomCid: String;
    strEstado: String;
    strRepCodCid: String;
    strRepEndere: String;
    strRepBairro: String;
    strRepNomCid: String;

    blnAtualizar: Boolean;

    intNivIndex: Integer;

    objLiberacao : ILiberacao;

    LCodigoCorreio: String;
begin
  Result := True;
  blnAtualizar := False;

  pnlDadosRep.Enabled := Not fEmptyStr(dbeRepRazSoc.Text);

  Try

    If (inherited fValidaCampos(Sender)) Then
    Begin
      If (Sender = dbeCodigo) Then
      Begin
        If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Código do Fornecedor deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else If blnBuscaPorChave Then
        Begin
          If Not fBuscaPorCamposChave Then
            pLimpaEdits
          Else
          Begin
            pCarregaCidade(qryConCid, edtCidade, edtEstado, dbeCodCid, dbeNumCep, strCepAnt);
            pCarregaAtividade;

            If fCfgSis('USACTF', varBoolean) Then
              pCarregaCentroDeCustoCxg(qryTabela.FieldByName('FOR_CODFOR').AsString)
            Else
              pCarregaCentroDeCustoDB(fraPlanoDeContasCmp.dbeCodCta, fraPlanoDeContasCmp.edtDesCta);

            objRepFor.fCarregaRepresentante(qryTabela.FieldByName('FOR_CODFOR').AsString);

            If Assigned(objMinMax) Then
            Begin
              objMinMax.fCarregaDados(qryTabela.FieldByName('FOR_CODFOR').AsString);
              cxvMinMax.NavigatorButtons.First.Click;
            End;

            pCarregaCidade(qryConCidRep, edtRepCidade, edtRepEst, dbeRepCodCid, dbeRepNumCep, strRepCepAnt);

            objNiveis.fCarregaNivelFornecedor(qryTabela.FieldByName('FOR_CODFOR').AsString, intNivIndex);

            cmbTipNiv.ItemIndex := intNivIndex;

            btnConsultaFit.Visible := (dbeCgcCpf.Text = '1');
          End;
        End;
      End

      Else If (Sender = dbeSEMAGE) And  (dbeSEMAGE.Visible) And (dbeSEMAGE.Text <> '') Then
      Begin
        Result := (Pos(dbeSEMAGE.Text, '_SN') > 0);
        If Not Result Then
          fMensagem('ATENÇÃO', 'O campo "Plano de Recebimento - Fornecedor sem necessidade de agendamento para recebimentos?" S ou N!',['&O K']);
      End

      Else If (Sender = DBEPALREC) And  (DBEPALREC.Visible) And (DBEPALREC.Text <> '') Then
      Begin
        Result := (Pos(DBEPALREC.Text, '_SN') > 0);
        If Not Result Then
          fMensagem('ATENÇÃO', 'Utiliza controle de cobrança por descarregamento de pallet no recebimento?" S ou N!',['&O K']);
        If DBEPALREC.Text = 'S' Then
        Begin
          if fEmptyStr(dbeCodCli.Text) Then
          Begin
            Result := False;
            Sender := DBEPALREC;
            fMensagem('ATENÇÃO', 'É preciso informar o código do fornecedor no cadastro do cliente para utilizar controle de cobrança por descarregamento de pallet no recebimento!',['&O K']);
          End;
        End;
      End

      Else If (Sender = dbeNomFor) Then
      Begin
        If fEmptyStr(dbeNomFor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Nome do Fornecedor deve ser preenchido!', ['&Ok']);
          Result := False;
        End;
      End
      Else if (Sender = fraDirBosh) Then
      Begin
        objFornecedorBosh.PathGeracao := fraDirBosh.edtDirectory.text
      End
      Else If (Sender = dbeCodCid) Then
      Begin
        If Not (fEmptyStr(dbeCodCid.Text)) Then
        Begin
          If fEmptyStr(fRetNomCidade(dbeCodCid.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
            Result := False;
          End
          Else
            pCarregaCidade(qryConCid, edtCidade, edtEstado, dbeCodCid, dbeNumCep, strCepAnt);
        End
        Else
        Begin
          fMensagem('ATENÇÃO!', 'O campo Cidade deve ser preenchido!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeNumCep) Then
      Begin

        If Length(Trim(fTiraCaracEspeciais(dbeNumCep.Text))) < 8 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Cep deve conter 8 digitos.', ['&Ok']);
          Result := False;
        End;

        If (Result) And (fCfgSis('USACEP', varBoolean)) And (edtEstado.Text <> 'EX') Then
        Begin

          If (Not fCadCepDadosCep(dbeNumCep.Text, strCodCid, strEndere, strBairro, strNomCid,
                                                  strEstado, LCodigoCorreio,
                                                  '',{qryConCid.FieldByName('CID_ESTADO').AsString,}
                                                  ''{qryConCid.FieldByName('CID_CODCOR').AsString})) Then
          Begin
            Result := fMensagem('ATENÇÃO!', 'CEP não encontrado!' + #13 + 'Deseja continuar mesmo assim?', ['&Sim', '&Não'],2) = 1;
          End
          Else
          Begin

            If (fEmptyStr(strCodCid)) Then
            Begin

              If Not fVerificaAcessoSistema('frmCadCidades') Then
              Begin
                fMensagem('ATENÇÃO!', fMensagemTravaAcessoCadCid(dbeCodCid.Text, edtCidade.Text), ['&Ok']);

                Result := False;

              End

              Else

              If Not fEmptyStr(fRetNomCidade(dbeCodCid.Text)) Then
              Begin

                If fMensagem('ATENÇÃO!', 'O Código Correios da cidade ' + edtCidade.Text + ' está em branco.' + #13#10 +
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
              If (Copy(strCepAnt, 0, 5) <> Copy(dbeNumCep.Text, 0, 5)) Then
              Begin
                If fTiraCaracEspeciais(strCepAnt) = '' Then
                Begin
                  blnAtualizar := True;
                End
                Else
                If fMensagem('ATENÇÃO!', 'O CEP foi alterado, deseja atualizar o endereço?', ['&Sim', '&Não']) = 1 Then
                Begin
                  blnAtualizar := True;
                End;
              End;

              If fEmptyStr(dbeCodCid.Text) Or (blnAtualizar) Then
              Begin
                dbeCodCid.Field.AsString := strCodCid;
                pCarregaCidade(qryConCid, edtCidade, edtEstado, dbeCodCid, Nil, strCepAnt);
              End;

              If (Not fEmptyStr(strEndere)) And (fEmptyStr(dbeEndere.Text) Or (blnAtualizar)) Then
                dbeEndere.Field.AsString := strEndere;

              If (Not fEmptyStr(strBairro)) And (fEmptyStr(dbeBairro.Text) Or (blnAtualizar)) Then
                dbeBairro.Field.AsString := strBairro;

            End;

          End;

          If (Result) Then
          Begin
            strCepAnt := dbeNumCep.Text;
            If blnAtualizar Then
            Begin
              pSetFocus(dbeEndNum);
              blnMudarFoco := False;
            End;
          End;

        End;

      End

      Else If (Sender = dbeObgCtrlGestao) Then
      Begin
        If (Not (Pos(dbeObgCtrlGestao.Text, 'SN')) > 0) And (tbsGestaoControle.TabVisible) Then
         fMensagem('ATENÇÃO', 'O campo obrigatoriedade de certificado de gestão de qualidade deve ser S ou N!',['&O K'])
        Else
          pnlDadosCertificado.Visible := dbeObgCtrlGestao.Text = 'S';
      End

      Else If (Sender = dbeValidade) Then
      Begin
        If dbeObgCtrlGestao.Text = 'S' Then
        Begin
          If (fEmptyStr(fTiraCaracEspeciais(dbeValidade.Text))) Then
          Begin
            fMensagem('ATENÇÃO', 'É obrigatório informar a data de validade do certificado de gestão!',['&O K']);
            Result := False;
          End
          Else
          Begin
            lblCertVencido.Visible := StrToDate(dbeValidade.Text) < VS_Date;
          End;
        End
      End

      Else If (Sender = dbeEndere) Then
      Begin
        If fEmptyStr(dbeEndere.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Endereço do fornecedor deve ser preenchido!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeCgcCpf) Then
      Begin
        btnConsultaFit.Visible := (dbeCgcCpf.Text = '1');
(*        If (fEmptyStr(dbeCgcCpf.Text)) Or (dbeCgcCpf.Text = '0') Then
        Begin
          fMensagem('ATENÇÃO!', 'O CNPJ / CPF deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else If (dbeCgcCpf.Text <> '1') And (dbeCgcCpf.Text <> '2') Then
        Begin
          Result := False;
        End;*)

        If (dbeCgcCpf.Enabled) and ((fEmptyStr(dbeCgcCpf.Text)) Or (Pos(dbeCgcCpf.Text,'1_2_') <= 0)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O CNPJ / CPF deve ser preenchido!', ['&Ok']);
          Result := False;
        End;

      End

      Else If (Sender = dbeNumCgc) Then
      Begin
        If (fEmptyStr(dbeNumCgc.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O CNPJ / CPF deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          Result := fValidaCampos(dbeCgcCpf, True);
          If Result Then
            Result := fValidaCnpjCpf(dbeCgcCpf.Text, dbeNumCgc.Text, False);

          If (Result) Then
          Begin
            Result := (Not fExisteCnpjCpf('CADFOR','FOR_CODFOR',dbeCodigo.Text,'FOR_C_G_C_',dbeNumCgc.Text,edtEstado.Text));

            If (Not Result) And (fCfgSis('VERCGC') = 'L') Then
            Begin
              objLiberacao := TLiberacaoFactory.fGetLiberacao;
              objLiberacao.Clear;
              objLiberacao.objMsgLibera.pAddTexto('Já existe um outro fornecedor com o CPF ' + dbeNumCgc.Text + ' cadastrado!');

              objLiberacao.strDirAce := 'VEFCPF';
              objLiberacao.strCodOpe := strLoginUsuarioLogado;

              Result := objLiberacao.fLibera;
            End;
          End;

          If (Result) And (Not qryTabela.FieldByName('FOR_C_G_C_').IsNull) And (qryTabela.State = dsEdit) Then
          Begin
            If (strCgcAnt <> dbeNumCgc.Text) Then
            Begin
              Result := fPodeAlterarCnpj(dbeCodigo.Text, dbeNumCgc.Text);
            End;
          End;

          If Not (Result) Then
            Sender := dbeCgcCpf;

        End;
      End

      Else If (Sender = dbeNumIes) Then
      Begin
        If (Not fEmptyStr(dbeNumIes.Text)) And (Not qryConCid.IsEmpty) Then
        Begin
          dbeNumIes.Text := AnsiReplaceStr(dbeNumIes.Text, ',', '.');
          If Not fValidaIES(dbeNumIes.Text, qryConCid.FieldByName('CID_ESTADO').AsString) Then
          Begin
            fMensagem('ATENÇÃO!', dbeNumIes.Text + ' não é uma Inscrição Estadual válida!', ['&Ok']);
            Result := False;
          End
          Else
          Begin
            If qryConCid.FieldByName('CID_ESTADO').AsString = 'RS' Then
            Begin
              dbeNumIes.Text := fRetornaZerosNumIes(dbeNumIes.Text) + dbeNumIes.Text;
            End;
          End;
        End;
      End

      Else If (Sender = dbeCodAti) Then
      Begin
        If (Not fEmptyStr(dbeCodAti.Text)) Then
        Begin
          pCarregaAtividade;
          If qryConAti.FieldByName('ATI_DESATI').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa atividade não está cadastrada!', ['&Ok']);
            Result := False;
          End;
        End
        Else
        Begin
          fMensagem('ATENÇÃO!', 'O campo Atividade deve ser preenchido!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeCODGEF) Then
      Begin
        If fEmptyStr(dbeCODGEF.Text) Then
        Begin
          edtDESGEF.Clear;
        End
        Else
        Begin
          pCarregaGrupoEconomico;
          If fEmptyStr(edtDESGEF.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Grupo Econômico não está cadastrado!', ['&Ok']);
            Result := False;
          End;
        End;
      End

      Else If (Sender = dbeCodTrans) Then
      Begin
        If fEmptyStr(dbeCodTrans.Text) Then
        Begin
          edtNomTrans.Clear;
          dbeCodTrans.Field.Value := Null;
        End
        Else
        Begin
          pCarregaTransportador(False);
          If fEmptyStr(edtNomTrans.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse transportador não está cadastrado!', ['&Ok']);
            Result := False;
          End;
        End;
      End

      Else If (Sender = dbeCodTransRedes) Then
      Begin
        If fEmptyStr(dbeCodTransRedes.Text) Then
        Begin
          edtNomTransRedes.Clear;
          dbeCodTransRedes.Field.Value := Null;
        End
        Else
        Begin
          pCarregaTransportador(True);
          If fEmptyStr(edtNomTransRedes.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse transportador não está cadastrado!', ['&Ok']);
            Result := False;
          End;
        End;
      End


      Else If (sender = dbeRevist) Then
      Begin
        If (Pos(dbeRevist.Text, 'SN') <= 0) Then
        begin
          pgcDados.ActivePage := tbsGeral;
          Result := False;
          pgcDados.ActivePage := tbsGeral;
          fMensagem('ATENÇÃO!', 'O Campo Revista deve ser preenchido com (S)im ou (N)ão!', ['&Ok']);
        End;
      End

      Else If (Sender = dbeCodCnd) And (dbeCodCnd.Visible) Then
      Begin

        If Not fEmptyStr(dbeCodCnd.Text) Then
        Begin
          pCarregaCondicao;
          If qryConCnd.FieldByName('CND_CODIGO').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa condição não está cadastrada!', ['&O k']);
            dbeCndPag.Text:= '';
            edtCndDescri.Clear;
            Result := False;
          End
          Else If (Not fEmpresaTemAcessoCondicaoPagto(qryConCnd.FieldByName('CND_CODIGO').AsString)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar esta condição. Verifique o Cadastro de Condições de Pagamento - Aba "Empresas Acesso".' , ['&O k']);
            dbeCndPag.Text:= '';
            edtCndDescri.Clear;
            Result := False;
          End;

          If Result And (Not fValidaCndPag(dbeCndPag.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&O k']);
            dbeCndPag.Text:= '';
            edtCndDescri.Clear;
            Result := False;
          End;
        End
        Else
          edtCndDescri.Clear;
      End

      Else If (Sender = dbeCndPag) Then
      Begin

        If Not fEmptyStr(Trim(fTiraCaracEspeciais(dbeCndPag.Text))) Then
        Begin
          If Not fValidaCndPag(dbeCndPag.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esta condição de pagamento está incorreta! Verifique.', ['&Ok']);
            Result := False;
          End;

          If Not fEmptyStr(qryConCnd.FieldByName('CND_CNDPAG').AsString) Then
          Begin
            If Trim(dbeCndPag.Text) <> fRetCondicao('', 0, qryConCnd.FieldByName('CND_TIPFOR').AsString, qryConCnd.FieldByName('CND_CNDPAG').AsString, qryConCnd.FieldByName('CND_CNDPAG').AsString) Then
            Begin
              dbeCodCnd.Field.Clear;
              pCarregaCondicao;
            End;

          End;

        End;

      End

      Else If (Sender = dbeFone01) Or (Sender = dbeFon02) Or
              (Sender = dbeNumFax) Or (Sender = dbeNumCel) Or
              (Sender = dbeRepFone01) Or (Sender = dbeRepFax) Or
              (Sender = dbeRepNumCel) Then
      Begin
        If (Not fEmptyStr(TDBEditFocus(Sender).Text)) And
           (Not fValidaTelefone(TDBEditFocus(Sender).Text)) Then
        Begin
          fMensagem('','Informe o telefone corretamente!', ['&Ok']);
          Result := False;
        End
        Else
          TDBEditFocus(Sender).Text := fAcertaMaskTel(TDBEditFocus(Sender).Text);
      End

      Else If (Sender = edtNomCtt) And (blnBuscaPorChave) Then
      Begin
        If (fEmptyStr(edtNomCtt.Text)) And (Not cdsForCtt.IsEmpty) Then
        Begin
          blnMudarFoco := False;
          pnlContatos.Enabled := False;
          dbgContatos.ReadOnly := False;
          pSetFocus(dbgContatos);
          pAtualizaEditsContato(Nil);
        End
        Else
        Begin
          If Not fEmptyStr(edtNomCtt.Text) Then
            objForCtt.strNomCtt := edtNomCtt.Text
          Else
          Begin
            blnMudarFoco := False;
            pSetFocus(btnGravar);
          End;
        End;
      End

      Else If (Sender = edtEndCtt) And (blnBuscaPorChave) Then
      Begin
        objForCtt.strEndCtt := edtEndCtt.Text;
      End

      Else If (Sender = edtBaiCtt) And (blnBuscaPorChave) Then
      Begin
        objForCtt.strBaiCtt := edtBaiCtt.Text;
      End

      Else If (Sender = edtCidCtt) And (blnBuscaPorChave) Then
      Begin
        objForCtt.strCidCtt := edtCidCtt.Text;
        edtDesCidCtt.Text := objForCtt.strNomCid;
        edtEstadoCtt.Text := objForCtt.strEstado;
      End

      Else If ((Sender = mskTelCtt) Or (Sender = mskCelCtt) Or
              (Sender = mskFaxCtt)) And (blnBuscaPorChave) Then
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
            objForCtt.strTelCtt := mskTelCtt.Text
          Else If (Sender = mskCelCtt) Then
            objForCtt.strCelCtt := mskCelCtt.Text
          Else If (Sender = mskFaxCtt) Then
            objForCtt.strFaxCtt := mskFaxCtt.Text;
        End;
      End

      Else If (Sender = edtDepCtt) And (blnBuscaPorChave) Then
      Begin
        objForCtt.strDepCtt := edtDepCtt.Text;
      End

      Else If (Sender = chkCmpCtt) And (blnBuscaPorChave) Then
      Begin
        objForCtt.strCmpCtt := IIF(chkCmpCtt.Checked, 'S', 'N');
      End

      Else If (Sender = edtEmaCtt) And (blnBuscaPorChave) Then
      Begin
        objForCtt.strEmaCtt := edtEmaCtt.Text;
      End

      Else If (Sender = dbeConCon) And (dbeConCon.Visible) Then
      Begin

        If Not fEmptyStr(fExisteConContabil) Then
        Begin
          pgcdados.ActivePage := tbsGeral;
          If fMensagem('', 'Esta Conta Contábil está sendo utilizada por ( ' + fExisteConContabil +
                       ' ). Deseja continuar?', ['&Sim', '&Não']) = 2 Then
            Result := False;

        End;

      End

      Else If (Sender = dbePlaNco) And (dbePlaNco.Visible) Then
      Begin
        pCarregaPlanoContabil(blnBuscaPorChave);
        If (Not fEmptyStr(fSemMascaraPlaNco(dbePlaNco.Text))) And (fEmptyStr(edtDesPlaNco.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Plano contábil inexistente!', ['&OK']);
          Result := False;
        End
        Else If (qryTabela.State In [dsInsert, dsEdit]) Then
        begin
          If fEmptyStr(edtDesPlaNco.Text) Then
            dbePlaNco.Field.Value := Null
          Else if (assigned(fSemMascaraPlaNco)) then
            dbePlaNco.Field.AsString := fSemMascaraPlaNco(dbePlaNco.Text);
        end;
      End

      {************************************}
      {*VALIDA % FRETE(FLUXO CAIXA)       *}
      {**********************************PZ}
      Else If (Sender = dbePerFCx) Then
      Begin

        If Not fEmptyStr(dbePerFCx.Text) Then
        Begin
          If (fStrToFloat(dbePerFCx.Text) < 0) Then
          Begin
            fMensagem('ATENÇÃO','Não é permitido valores negativos!',['&O K']);
            Result := False;
          End;
        End;

      End

      Else If (Sender = fraPlanoDeContasCmp.dbeCodCta) Then
      Begin

        If RightStr(fraPlanoDeContasCmp.dbeCodCta.Text, 3) = '000' Then
        Begin
          fMensagem('ATENÇÃO!', fraPlanoDeContasCmp.dbeCodCta.Text + ' não é um Plano de Contas válido!', ['&Ok']);
          fraPlanoDeContasCmp.dbeCodCta.Clear;
          Result := False;
        End

        Else If Not fEmptyStr(fraPlanoDeContasCmp.dbeCodCta.Text) Then
        Begin
          fraPlanoDeContasCmp.dbeCodCta.Text := fStrZero(fraPlanoDeContasCmp.dbeCodCta.Text,7);

          pCarregaCentroDeCustoDB(fraPlanoDeContasCmp.dbeCodCta, fraPlanoDeContasCmp.edtDesCta);
          If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok']);
            Result := False;
          End
          Else
          Begin
            If fraPlanoDeContasCmp.Visible then
            Begin
              If (qryTabela.State In [dsInsert]) or (strPlCtaCmpOld <>  fraPlanoDeContasCmp.dbeCodCta.Text) Then
                Result := PlanoDeContasAtivo(fraPlanoDeContasCmp.dbeCodCta.Text,True);
            End;
          End;
        End

        Else
        Begin
          fraPlanoDeContasCmp.edtDesCta.Clear;
          fraPlanoDeContasCmp.dbeCodCta.Field.Value := Null;
        End;

      End

      Else If (Sender = dbeCodPor) Then
      Begin
        edtNomPor.Clear;
        If Not fEmptyStr(dbeCodPor.Text) Then
        Begin
          pCarregaPortador;
          If fEmptyStr(edtNomPor.text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
            Result := False;
          End
          {*REQ*145940**********RP*}
          Else If Not fEmpresaTemAcessoPortador(dbeCodPor.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End;
        End

        Else
        Begin
          edtNomPor.Clear;
          dbeCodPor.Field.Value := Null;
        End;

      End

      Else If (Sender = dbeConCol) Then
      Begin

        If dbeConCol.Visible Then
        Begin
          If Pos(dbeConCol.Text, 'S-N') = 0 Then
          Begin
            pgcDados.ActivePage := tbsCompras;
            pMensagemOk('Realizar controle de coleta de compras no fornecedor deve ser (S)im ou (N)ão!');
            Result := False;
          End;
        End;

      End

      Else If (Sender = fraPlanoDeContasAux.dbeCodCta) Then
      Begin

        If RightStr(fraPlanoDeContasAux.dbeCodCta.Text, 3) = '000' Then
        Begin
          fMensagem('ATENÇÃO!', fraPlanoDeContasAux.dbeCodCta.Text + ' não é um Plano de Contas válido!', ['&Ok']);
          fraPlanoDeContasAux.dbeCodCta.Clear;
          Result := False;
        End

        Else If Not fEmptyStr(fraPlanoDeContasAux.dbeCodCta.Text) Then
        Begin
          fraPlanoDeContasAux.dbeCodCta.Text := fStrZero(fraPlanoDeContasAux.dbeCodCta.Text,7);

          pCarregaCentroDeCustoDB(fraPlanoDeContasAux.dbeCodCta, fraPlanoDeContasAux.edtDesCta);
          If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok']);
            Result := False;
          End
          Else
          Begin
            If (qryTabela.State In [dsInsert]) or (strPlCtaAuxOld <>  fraPlanoDeContasAux.dbeCodCta.Text) Then
              Result := PlanoDeContasAtivo(fraPlanoDeContasAux.dbeCodCta.Text,True);
          End;
        End

        Else
          fraPlanoDeContasAux.edtDesCta.Clear;
       (*
        If Result Then
        Begin
          pProximaPagina;
        End; *)

      End

      Else If Sender = dbeSuframa Then
      Begin
        If (Pos(edtEstado.Text, 'AC_AM_AP_RO_RR_') <= 0) Then
        Begin
          dbeSuframa.Field.AsString := '';
        End;
      End

      Else If (Sender = dbeZonFra) Then
      Begin

        If Pos(dbeZonFra.Text, 'S_N_') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe se o fornecedor pertence a zona franca (S/N)!', ['&Ok']);
          Result := False;
        End;

      End

      Else If (Sender = dbeCarPag) Then
      Begin

        If Not fEmptyStr(dbeCarPag.Text) Then
        Begin
          If (fStrToFloat(dbeCarPag.Text) < 0) Then
          Begin
            fMensagem('ATENÇÃO', 'Não é permitido valores negativos!',['&O K']);
            Result := False;
          End;
        End;

      End

      Else If (Sender = dbeDesVis) Then
      Begin

        If Not fEmptyStr(dbeDesVis.Text) Then
        Begin
          If (fStrToFloat(dbeDesVis.Text) < 0) Then
          Begin
            fMensagem('ATENÇÃO', 'Não é permitido valores negativos!',['&O K']);
            Result := False;
          End;
        End;

      End

       Else If (Sender = dbeDesBav) Then
      Begin
        If Not fEmptyStr(dbeDesBav.Text) And (dbeDesBav.Visible) Then
        Begin
          If (fStrToFloat(dbeDesBav.Text) < 0) Then
          Begin
            fMensagem('ATENÇÃO', 'Não é permitido valores negativos!',['&O K']);
            Result := False;
          End;
        End;

      End

       Else If (Sender = dbeDesBap) Then
      Begin
        If Not fEmptyStr(dbeDesBap.Text) And (dbeDesBap.Visible) Then
        Begin
          If (fStrToFloat(dbeDesBap.Text) < 0) Then
          Begin
            fMensagem('ATENÇÃO', 'Não é permitido valores negativos!',['&O K']);
            Result := False;
          End;
        End;

      End

      Else If (sender = dbeAcoObj)  Then
      Begin
        If (Pos(dbeAcoObj.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO', 'O campo acordo de objetivos deve ser S ou N!',['&O K']);
          pgcDados.ActivePage := tbsCompras;
          Result := False;
        End

      End

      Else If (sender = dbeEmpPas)  Then
      Begin
        If (Pos(dbeEmpPas.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO', 'O campo "Selecionar empresa para faturar pedidos gerados pela Pasta de Compras" deve ser S ou N!',['&O K']);
          pgcDados.ActivePage := tbsCompras;
          Result := False;
        End

      End

      Else If (sender = dbeAncora)  Then
      Begin
        If (Pos(dbeAncora.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO', 'O campo utilizar Rede Âncora Services na cotação de pedido de compra deve ser S ou N!',['&O K']);
          pgcDados.ActivePage := tbsCompras;
          Result := False;
        End

      End


      Else If (Sender = dbeAlqPis) Then
      Begin

        If Not fEmptyStr(dbeAlqPis.Text) Then
        Begin
          If (fStrToFloat(dbeAlqPis.Text) < 0) Then
          Begin
            fMensagem('ATENÇÃO', 'A Aliquota de PIS para Compras deve ser maior ou igual a zero!',['&O K']);
            Result := False;
          End;
        End

        Else dbeAlqPis.Text := '0,0000';
      End

      Else If (Sender = dbeAlqCof) Then
      Begin

        If Not fEmptyStr(dbeAlqCof.Text) Then
        Begin
          If (fStrToFloat(dbeAlqCof.Text) < 0) Then
          Begin
            fMensagem('ATENÇÃO', 'A Aliquota de COFINS para Compras deve ser maior ou igual a zero!',['&O K']);
            Result := False;
          End;
        End

        Else dbeAlqCof.Text := '0,0000';

      End

      else If (Sender = dbeDiaEnt) then
      begin
        if StrToIntDef(dbeDiaEnt.Text, -1) < 0 Then
        Begin
          fMensagem('ATENÇÃO', 'A Quantidade de Dias para Entrega deve ser Maior ou Igual a Zero', ['&O K']);
          Result := False;
        End



      End

      Else If (Sender = dbeDiaEnt) Then
      {*****************************************}
      {* VALIDA O CAMPO "SIMPLES"              *}
      {**************************************MV*}
      Else If (Sender = dbeSimPau) THen
      Begin
        Result := (Pos(dbeSimPau.Text, 'SRP') > 0);
        If Not Result Then
         fMensagem('ATENÇÃO', 'O campo regime de tributação deve ser S, R ou P!',['&O K']);
      End

      {*****************************************}
      {* VALIDA O CAMPO ARRED 2A PARC          *}
      {**************************************IV*}
      Else If (Sender = dbeVlRed2) THen
      Begin
        Result := (Pos(dbeVlRed2.Text, 'SN') > 0);
        If Not Result Then
        Begin
          fMensagem('ATENÇÃO', 'O campo arredondar valor à partir da 2a parcela quando Cond. de Pagto. a prazo deve ser S ou N!',['&O K']);
          pgcDados.ActivePage := tbsCompras;
        End;
      End

      {*****************************************}
      {* VALIDA A SITUAÇÃO DO FORNECEDEDOR     *}
      {**************************************JC*}
      Else If (Sender = dbeStatus) Then
      Begin

        If fEmptyStr(dbeStatus.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Situação do Fornecedor deve ser preenchida!', ['&Ok']);
          Result := False;
        End
        Else If (dbeStatus.Text <> 'A') And (dbeStatus.Text <> 'I') Then
          Result := False

      End

      Else If (Sender = dbeNotDes) Then
      Begin

        If Pos(dbeNotDes.Text, 'S_N_') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Fornecedor enquadrado no art. 7º do Anexo XVIII da Parte II da Resolução SEFAZ nº 720/14, incluído pela Resolução SEFAZ nº 13/19 ?" corretamente!', ['&Ok']);
          Result := False;
        End;

      End

      Else If (Sender = edtCodIte) And tbsPreFor.TabVisible Then
      Begin
        If fEmptyStr(edtCodIte.Text) Then
        Begin
          btnCanIte.Click;
          blnMudarFoco := False;
          pSetFocus(dbgItens);
        End
        Else If blnBuscaPorChave Then
          objForPre.strCodIte := edtCodIte.Text;
      End

      Else If (Sender = edtPreFor) And tbsPreFor.TabVisible Then
      Begin
        If blnBuscaPorChave Then
          objForPre.fltValIte := fStrToFloat(edtPreFor.Text);
      End
      {*****************************************}
      {* VALIDA PLANO DE CONTAS DO FORNECEDOR  *}
      {**************************************JU*}
      Else If (Sender = fraPlanoDeContasPl.MskCodCta) Then
      Begin

        If fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContasPl.MskCodCta.Text)) Then
        Begin
          pProximaPagina;
        End;

        If RightStr(fraPlanoDeContasPl.MskCodCta.Text, 3) = '000' Then
        Begin
          fMensagem('ATENÇÃO!', fraPlanoDeContasPl.MskCodCta.Text + ' não é um Plano de Contas válido!', ['&Ok']);
          fraPlanoDeContasPl.MskCodCta.Clear;
          Result := False;
        End
        Else If Not fEmptyStr(fraPlanoDeContasPl.MskCodCta.Text) Then
        Begin
          fraPlanoDeContasPl.MskCodCta.Text := fStrZero(fraPlanoDeContasPl.MskCodCta.Text,7);

          pCarregaCentroDeCusto(fraPlanoDeContasPl.MskCodCta, fraPlanoDeContasPl.edtDesCta);

          If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok']);
            Result := False;
          End
          Else
            Result := PlanoDeContasAtivo(fraPlanoDeContasPl.MskCodCta.Text,True);

        End
        Else
        Begin
          fraPlanoDeContasPl.edtDesCta.Clear;
          fraPlanoDeContasPl.MskCodCta.Clear;
        End;

      End

      Else If (Sender = fraPlanoDeContasImp.MskCodCta) Then
      Begin

        If RightStr(fraPlanoDeContasImp.MskCodCta.Text, 3) = '000' Then
        Begin
          fMensagem('ATENÇÃO!', fraPlanoDeContasImp.MskCodCta.Text + ' não é um Plano de Contas válido!', ['&Ok']);
          fraPlanoDeContasImp.MskCodCta.Clear;
          Result := False;
        End
        Else If Not fEmptyStr(fraPlanoDeContasImp.MskCodCta.Text) Then
        Begin
          fraPlanoDeContasImp.MskCodCta.Text := fStrZero(fraPlanoDeContasImp.MskCodCta.Text,7);

          pCarregaCentroDeCusto(fraPlanoDeContasImp.MskCodCta, fraPlanoDeContasImp.edtDesCta);

          If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok']);
            Result := False;
          End
          Else
          Begin
            if  (cdsForRet.State in [dsInsert]) or (strPlCtaImpOld <> fraPlanoDeContasImp.MskCodCta.Text) then
              Result := PlanoDeContasAtivo(fraPlanoDeContasImp.MskCodCta.Text,True);
          End;

        End
        Else
        Begin
          fraPlanoDeContasImp.edtDesCta.Clear;
          fraPlanoDeContasImp.MskCodCta.Clear;
        End;

      End

      Else If (Sender = dbeFunruralFornecedor) And (chkUsaFunrural.Checked) Then
      Begin
        If fEmptyStr(dbeFunruralFornecedor.Text) Then
        Begin
          pgcDados.ActivePage := tbsRetencoes;
          fMensagem('ATENÇÃO!', 'O Código do Fornecedor para Retenção Funrural deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          pCarregaFornecedorFunrural;

          If (qryConFor.FieldByName('FOR_CODFOR').AsString = qryTabela.FieldByName('FOR_CODFOR').AsString) Then
          Begin
            pgcDados.ActivePage := tbsRetencoes;
            fMensagem('ATENÇÃO!', 'O Fornecedor em edição não pode receber retenções!', ['&Ok']);
            Result := False;
          End Else If qryConFor.FieldByName('FOR_CODFOR').IsNull Then
          Begin
            pgcDados.ActivePage := tbsRetencoes;
            fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&Ok']);
            Result := False;
          End;
        End;
      End

      Else If (Sender = fraPlanoDeContasFunrural.dbeCodCta) Then
      Begin
        If RightStr(fraPlanoDeContasFunrural.dbeCodCta.Text, 3) = '000' Then
        Begin
          fMensagem('ATENÇÃO!', fraPlanoDeContasFunrural.dbeCodCta.Text + ' não é um Plano de Contas válido!', ['&Ok']);
          fraPlanoDeContasFunrural.dbeCodCta.Clear;
          Result := False;
        End
        Else If Not fEmptyStr(fraPlanoDeContasFunrural.dbeCodCta.Text) Then
        Begin
          fraPlanoDeContasFunrural.dbeCodCta.Text := fStrZero(fraPlanoDeContasFunrural.dbeCodCta.Text,7);

          pCarregaCentroDeCustoDB(fraPlanoDeContasFunrural.dbeCodCta, fraPlanoDeContasFunrural.edtDesCta);

          If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
          Begin
            pgcDados.ActivePage := tbsRetencoes;
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok']);
            Result := False;
          End
        End
        Else
        Begin
          fraPlanoDeContasFunrural.edtDesCta.Clear;
          fraPlanoDeContasFunrural.dbeCodCta.Clear;
          fraPlanoDeContasFunrural.dbeCodCta.Field.Value := Null;
        End;

        If fEmptyStr(fraPlanoDeContasFunrural.dbeCodCta.Text) And (chkUsaFunrural.Checked) Then
        Begin
          pgcDados.ActivePage := tbsRetencoes;
          fMensagem('ATENÇÃO!', 'O Plano de Contas para Retenção Funrural deve ser informado!', ['&Ok']);
          Result := False;
        End;

      End

      Else If (Sender = dbeCodEve) Then
      begin
        If Not fEmptyStr(dbeCodEve.Text) Then
        Begin
          pCarregaEventoDB(dbeCodEve, edtDesEve);

          If fEmptyStr(edtDesEve.Text) Then
          Begin
            pgcDados.ActivePage := tbsRetencoes;
            fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&Ok']);
            Result := False;
          End;
        End
        Else
          edtDesEve.Clear;
      end

      Else If (Sender = dbeFunruralAliquota) And (chkUsaFunrural.Checked)  Then
      Begin

        If fEmptyStr(dbeFunruralAliquota.Text) or (fStrToFloat(dbeFunruralAliquota.Text) = 0) Then
        Begin
          pgcDados.ActivePage := tbsRetencoes;
          fMensagem('ATENÇÃO!', 'A Alíquota para Retenção Funrural deve ser informada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If (fStrToFloat(dbeFunruralAliquota.Text) < 0) Then
          Begin
            pgcDados.ActivePage := tbsRetencoes;
            fMensagem('ATENÇÃO', 'A Aliquota para Retenção Funrural deve ser maior que zero!',['&Ok']);
            Result := False;
          End;
        End
      End

      Else If (Sender = rdgFunruralVenc) And (chkUsaFunrural.Checked)  Then
      Begin
        if rdgFunruralVenc.ItemIndex = -1 then
        begin
          pgcDados.ActivePage := tbsRetencoes;
          fMensagem('ATENÇÃO', 'O Tipo de dia de vencimento para Retenção Funrural deve ser informado!',['&Ok']);
          Result := False;
        end;
      End

      Else If (Sender = dbeFunruralDiaVenc) And (chkUsaFunrural.Checked)  Then
      Begin
        if (rdgFunruralVenc.ItemIndex = 0) And ((StrToIntDef(dbeFunruralDiaVenc.Text, 0) = 0)) then
        begin
          pgcDados.ActivePage := tbsRetencoes;
          fMensagem('ATENÇÃO', 'O Dia de Vencimento para Retenção Funrural deve ser informado!',['&Ok']);
          Result := False;
        end;
      End

      Else If (Sender = dbeRepRazSoc) Then
      Begin

        pnlDadosRep.Enabled := Not fEmptyStr(dbeRepRazSoc.Text);

        If Not pnlDadosRep.Enabled Then
          objRepFor.pLimpaCampos;

      End

      Else If (Sender = dbeRepCodCid) Then
      Begin

        If pnlDadosRep.Enabled Then
        Begin

          If Not (fEmptyStr(dbeRepCodCid.Text)) Then
          Begin
            If fEmptyStr(fRetNomCidade(dbeRepCodCid.Text)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
              Result := False;
            End
            Else
              pCarregaCidade(qryConCidRep, edtRepCidade, edtRepEst, dbeRepCodCid, dbeRepNumCep, strRepCepAnt);
          End
          Else
          Begin
            fMensagem('ATENÇÃO!', 'O campo Cidade deve ser preenchido!', ['&Ok']);
            Result := False;
          End;

          If Not Result Then
            pgcDados.ActivePage := tbsRepresentante;
        End;

      End

      Else If (Sender = dbeRepNumCep) Then
      Begin

        If pnlDadosRep.Enabled Then
        Begin

          If Length(Trim(fTiraCaracEspeciais(dbeRepNumCep.Text))) < 8 Then
          Begin
            fMensagem('ATENÇÃO!', 'O Cep deve conter 8 digitos.', ['&Ok']);
            Result := False;
          End;

          If (Result) And (fCfgSis('USACEP', varBoolean)) Then
          Begin

            If (Not fCadCepDadosCep(dbeRepNumCep.Text,
                                    strRepCodCid, strRepEndere, strRepBairro, strRepNomCid,
                                    strEstado, LCodigoCorreio,
                                    qryConCidRep.FieldByName('CID_ESTADO').AsString,
                                    qryConCidRep.FieldByName('CID_CODCOR').AsString)) Then
            Begin
              Result := fMensagem('ATENÇÃO!', 'CEP não encontrado!' + #13 + 'Deseja continuar mesmo assim?', ['&Sim', '&Não'],2) = 1;
            End
            Else
            Begin

              If (fEmptyStr(strRepCodCid)) Then
              Begin

                If Not fVerificaAcessoSistema('frmCadCidades') Then
                Begin
                  fMensagem('ATENÇÃO!', fMensagemTravaAcessoCadCid(dbeRepCodCid.Text, edtRepCidade.Text), ['&Ok']);

                  Result := False;

                End

                Else

                If Not fEmptyStr(fRetNomCidade(dbeRepCodCid.Text)) Then
                Begin

                  If fMensagem('ATENÇÃO!', 'O Código Correios da cidade ' + edtRepCidade.Text + ' está em branco.' + #13#10 +
                               'Deseja que o mesmo seja preenchido automaticamente no Cadastro de Cidades?', ['&Sim', '&Não']) = 1 Then
                  Begin
                    pAtualizaCodigoCorreios(dbeRepCodCid.Text, dbeRepNumCep.Text);
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
                If (Copy(strRepCepAnt, 0, 5) <> Copy(dbeRepNumCep.Text, 0, 5)) Then
                Begin
                  If fTiraCaracEspeciais(strRepCepAnt) = '' Then
                  Begin
                    blnAtualizar := True;
                  End
                  Else
                  If fMensagem('ATENÇÃO!', 'O CEP foi alterado, deseja atualizar o endereço?', ['&Sim', '&Não']) = 1 Then
                  Begin
                    blnAtualizar := True;
                  End;
                End;

                If fEmptyStr(dbeRepCodCid.Text) Or (blnAtualizar) Then
                Begin
                  dbeRepCodCid.Field.AsString := strRepCodCid;
                  pCarregaCidade(qryConCidRep, edtRepCidade, edtRepEst, dbeRepCodCid, Nil, strRepCepAnt);
                End;

                If (Not fEmptyStr(strRepEndere)) And (fEmptyStr(dbeRepEndere.Text) Or (blnAtualizar)) Then
                  dbeRepEndere.Field.AsString := strRepEndere;

                If (Not fEmptyStr(strRepBairro)) And (fEmptyStr(dbeRepBairro.Text) Or (blnAtualizar)) Then
                  dbeRepBairro.Field.AsString := strRepBairro;

              End;

            End;

            If (Result) Then
            Begin
              strRepCepAnt := dbeRepNumCep.Text;
              If blnAtualizar Then
              Begin
                pSetFocus(dbeRepNum);
                blnMudarFoco := False;
              End;
            End;

          End;

          If Not Result Then
            pgcDados.ActivePage := tbsRepresentante;

        End;

      End

      Else If (Sender = dbeRepEndere) Then
      Begin
        If pnlDadosRep.Enabled Then
        Begin
          If fEmptyStr(dbeRepEndere.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'O Endereço do Representante deve ser preenchido!', ['&Ok']);
            Result := False;
          End;
        End;
      End

      Else If (Sender = dbeRepCgcCpf) Then
      Begin

        If pnlDadosRep.Enabled Then
        Begin
          If (fEmptyStr(dbeRepCgcCpf.Text)) Or (dbeRepCgcCpf.Text = '0') Then
          Begin
            fMensagem('ATENÇÃO!', 'O CNPJ / CPF do Representante deve ser preenchido!', ['&Ok']);
            Result := False;
          End
          Else If (dbeRepCgcCpf.Text <> '1') And (dbeRepCgcCpf.Text <> '2') Then
          Begin
            Result := False;
          End;

          If Not Result Then
            pgcDados.ActivePage := tbsRepresentante;

        End;

      End

      Else If (Sender = dbeRepNumCgc) Then
      Begin

        If pnlDadosRep.Enabled Then
        Begin

          If (fEmptyStr(dbeRepNumCgc.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'O CNPJ / CPF do Representante deve ser preenchido!', ['&Ok']);
            Result := False;
          End
          Else
          Begin
            Result := fValidaCampos(dbeRepCgcCpf, True);


            If Result Then
              Result := fValidaCnpjCpf(dbeRepCgcCpf.Text, dbeRepNumCgc.Text, False);

            If Not (Result) Then
              Sender := dbeRepCgcCpf;

          End;

          If Not Result Then
            pgcDados.ActivePage := tbsRepresentante;

        End;

      End

      Else If (Sender = dbeRepNumIes) Then
      Begin

        If pnlDadosRep.Enabled Then
        Begin

          If (Not fEmptyStr(dbeRepNumIes.Text)) And (Not fEmptyStr(edtRepEst.Text)) Then
          Begin
            dbeRepNumIes.Text := AnsiReplaceStr(dbeRepNumIes.Text, ',', '.');
            If Not fValidaIES(dbeRepNumIes.Text, edtRepEst.Text) Then
            Begin
              fMensagem('ATENÇÃO!', dbeRepNumIes.Text + ' não é uma Inscrição Estadual válida!', ['&Ok']);
              Result := False;
            End
            Else
            Begin
              If edtRepEst.Text = 'RS' Then
              Begin
                dbeRepNumIes.Text := fRetornaZerosNumIes(dbeRepNumIes.Text) + dbeRepNumIes.Text;
              End;
            End;
          End;

          If Not Result Then
            pgcDados.ActivePage := tbsRepresentante;

        End;

      End

      Else If Sender = dbeMinOrc Then
      Begin
        If fStrToFloat(dbeMinOrc.Text) < 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Valor mínimo para geração de orçamento de compra precisa ser maior ou igual a zero!', ['&Ok']);
          Result := False;
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
             (strStatus = 'INSERT') Then
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

      Else If Sender = dbeEanCli Then
      Begin

      End

      Else If Sender = dbeSeqArq Then
      Begin

        If fEmptyStr(dbeSeqArq.Text) Then
          dbeSeqArq.Field.Value := 0

        Else if StrToIntDef(dbeSeqArq.Text, 0) < 0 Then
        Begin
          pMensagemOk('O Sequencial do Arquivo deve ser maior ou igual a zero!');
          Result := False;
        End;

      End

      Else If Sender = dbeDtaArq Then
      Begin

        If Not dbeDtaArq.ReadOnly Then
        Begin
          If fEmptyDate(dbeDtaArq.Text) Then
            dbeDtaArq.Field.Clear

          Else if Not fValidaDataStr(dbeDtaArq.Text) Then
          Begin
            pMensagemOk('Data do Sequêncial do Arquivo inválida!');
            Result := False;
          End;
        End;

      End

      Else If Sender =  fraPatArq Then
      Begin

        If (Not fEmptyStr(fraPatArq.edtDirectory.text)) And (Not DirectoryExists(fraPatArq.edtDirectory.text)) Then
        Begin
          fCriaDiretorio(fraPatArq.edtDirectory.text);

          If Not DirectoryExists(fraPatArq.edtDirectory.text) Then
          Begin
            Result := False;
            pMensagemOk('Não foi possível criar a pasta ' + fraPatArq.edtDirectory.text + '!');
          End;

        End;

      End

      Else If (Sender = edtAliq) Then Begin
        If (Not fEmptyStr(edtAliq.Text)) Then Begin
          If (fStrToFloat(edtAliq.Text) > 100) Then Begin
            fMensagem('ATENÇÃO!', 'A Alíquota de Retenção não pode ser maior que 100%', ['&Ok']);
            Result := False;
          End Else If (fStrToFloat(edtAliq.Text) < 0) Then Begin
            fMensagem('ATENÇÃO!', 'A Alíquota de Retenção não pode ser negativa!', ['&Ok']);
            Result := False;
          End;
        End;
      End

      Else If (Sender = edtVencimento) And (rdgVencimento.ItemIndex <= 0) Then Begin
        If (fEmptyStr(edtVencimento.Text)) Then edtVencimento.Text := '0';

        If ((StrToInt(edtVencimento.Text) <= 0) Or (StrToInt(edtVencimento.Text) > 31)) Then Begin
          fMensagem('ATENÇÃO!', 'A Data de Vencimento deve ser um dia entre 01 e 31!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = fraCentroCusto.edtCodEve) Then
      begin
        If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
        Begin
          fraCentroCusto.edtDesEve.Text := fRetNomEventoExiFat(fraCentroCusto.edtCodEve);

          If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then Begin
            fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&OK']);
            Result := False;
          End;
        End Else
          fraCentroCusto.edtDesEve.Clear;
      end

      Else If (Sender = dbeExpTigre) And (dbeExpTigre.Visible) Then
      Begin
        If (Pos(dbeExpTigre.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO', 'O campo "Envio de dados Tigre - XML Nota Fiscal Eletrônica - Exportar dados para a Tigre?" deve ser S ou N!',['&O K']);
          pgcDados.ActivePage := tbsNeoGrid;
          Result := False;
        End
      End

      Else If (Sender = edtCodFor) And (grbDadosRetencoes.Enabled) Then
      Begin
        If fEmptyStr(edtCodFor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Código do Fornecedor deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          pCarregaFornecedor;

          If (qryConFor.FieldByName('FOR_CODFOR').AsString = qryTabela.FieldByName('FOR_CODFOR').AsString) Then Begin
            fMensagem('ATENÇÃO!', 'O Fornecedor em edição não pode receber retenções!', ['&Ok']);
            Result := False;
          End Else If qryConFor.FieldByName('FOR_CODFOR').IsNull Then Begin
            fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&Ok']);
            Result := False;
          End;
        End;
      End

      Else If (Sender = edtCodPorRet) And (edtCodPorRet.Enabled) And (edtCodPorRet.Parent.Enabled) And (grbDadosRetencoes.Enabled)  Then
      Begin
        edtNomPorRet.Clear;
        If Not fEmptyStr(edtCodPorRet.Text) Then
        Begin
          edtNomPorRet.text := fRetNomPortador(edtCodPorRet.Text);

          If fEmptyStr(edtNomPorRet.text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
            Result := False;
          End
          Else If Not fEmpresaTemAcessoPortador(edtCodPorRet.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End
          Else If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtCodPorRet.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&O k']);
              Result := False;
            End;
          End;
        End
        Else If (fCfgSis('CTPOBP', varBoolean)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O código do portador deve ser preenchido!', ['&O k']);
          Result := False;
        End;
      End

      {*****************************************}
      {* VALIDA O CÓDIGO DE CLIENTE            *}
      {**************************************LU*}
      Else If (Sender = dbeCodCli) Then
      Begin
        If Not fEmptyStr(dbeCodCli.Text) Then
        Begin
          If Not fClienteVinculado(dbeCodCli.Text) Then
          Begin
            pCarregaCliente;
            If qryConCli.FieldByName('CLI_CODCLI').IsNull Then
            Begin
              fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&Ok']);
              Result := False;
            End;
          End
          Else
            Result := False;
        End
        Else
        Begin
          edtNomCli.Text := '';
          dbeCodCli.Field.Value := Null;
        End;
      End
      {*****************************************}
      {* VALIDA DADOS PARA DEPÓSITO            *}
      {**************************************FS*}
      Else If (Sender = edtCodBco) And (cdsBcoFor.State in dsEditModes) Then
      Begin
        If fEmptyStr(edtCodBco.Text) Then
        Begin
          fMensagem('', 'O Código do Banco deve ser Informado!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          pCarregaBanco;

          If (qryConBco.FieldByName('BCO_CODBCO').IsNull) Then
          Begin
            fMensagem('', 'Esse Banco não está cadastrado!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else If (Sender = edtNumAge) And (cdsBcoFor.State in dsEditModes) Then
      Begin
        If fEmptyStr(edtNumAge.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Agência deve ser informada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If (edtcodbco.Text = '001') Then
          Begin
            If(Length(edtNumAge.Text) < 4) Then
            Begin
              edtNumAge.Text := fStrZero(edtNumAge.Text,4);
            End;
            If(Length(edtNumAge.Text) > 4) Then
            Begin
              fMensagem('ATENÇÃO!', 'O campo Agência deve ter 4 caracteres!!', ['&Ok']);
              Result := False;
            End;
          End

          Else If (edtcodbco.Text = '104') Then
          Begin
            If(Length(edtNumAge.Text) < 4) Then
            Begin
              edtNumAge.Text := fStrZero(edtNumAge.Text,4);
            End;
            If(Length(edtNumAge.Text) > 4) Then
            Begin
              fMensagem('ATENÇÃO!', 'O campo Agência deve ter 4 caracteres!!', ['&Ok']);
              Result := False;
            End;
          End

          Else If (edtcodbco.Text = '341') Then
          Begin
            If(Length(edtNumAge.Text) < 4) Then
            Begin
              edtNumAge.Text := fStrZero(edtNumAge.Text,4);
            End;
            If(Length(edtNumAge.Text) > 4) Then
            Begin
              fMensagem('ATENÇÃO!', 'O campo Agência deve ter 4 caracteres!!', ['&Ok']);
              Result := False;
            End;
          End

          Else If (edtcodbco.Text = '033') Then
          Begin
            If(Length(edtNumAge.Text) < 4) Then
            Begin
              edtNumAge.Text := fStrZero(edtNumAge.Text,4);
            End;
            If(Length(edtNumAge.Text) > 4) Then
            Begin
              fMensagem('ATENÇÃO!', 'O campo Agência deve ter 4 caracteres!!', ['&Ok']);
              Result := False;
            End;
          End

          Else If (edtcodbco.Text = '237') Then
          Begin
            If(Length(edtNumAge.Text) < 5) Then
            Begin
              edtNumAge.Text := fStrZero(edtNumAge.Text,5);
            End;
            If(Length(edtNumAge.Text) > 5) Then
            Begin
              fMensagem('ATENÇÃO!', 'O campo Agência deve ter 5 caracteres!!', ['&Ok']);
              Result := False;
            End;
          End

          Else If (edtcodbco.Text = '422') Then
          Begin
            If(Length(edtNumAge.Text) < 5) Then
            Begin
              edtNumAge.Text := fStrZero(edtNumAge.Text,5);
            End;
            If(Length(edtNumAge.Text) > 5) Then
            Begin
              fMensagem('ATENÇÃO!', 'O campo Agência deve ter 5 caracteres!!', ['&Ok']);
              Result := False;
            End;
          End

          Else If (edtcodbco.Text = '756') Then
          Begin
            If(Length(edtNumAge.Text) < 4) Then
            Begin
              edtNumAge.Text := fStrZero(edtNumAge.Text,4);
            End;
            If(Length(edtNumAge.Text) > 4) Then
            Begin
              fMensagem('ATENÇÃO!', 'O campo Agência deve ter 4 caracteres!!', ['&Ok']);
              Result := False;
            End;
          End

          Else If (edtcodbco.Text = '021') Then
          Begin
            If(Length(edtNumAge.Text) < 5) Then
            Begin
              edtNumAge.Text := fStrZero(edtNumAge.Text,5);
            End;
            If(Length(edtNumAge.Text) > 5) Then
            Begin
              fMensagem('ATENÇÃO!', 'O campo Agência deve ter 5 caracteres!!', ['&Ok']);
              Result := False;
            End;
          End;
        End;
      End
      Else If (Sender = edtNumCta) And (cdsBcoFor.State in dsEditModes) Then
      Begin
        If fEmptyStr(edtNumCta.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Conta deve ser informada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If (edtcodbco.Text = '001') Then
          Begin
            If(Length(edtNumCta.Text) < 8) Then
            Begin
              edtNumCta.Text := fStrZero(edtNumCta.Text,8);
            End;
            If(Length(edtNumCta.Text) > 8) Then
            Begin
              fMensagem('ATENÇÃO!', 'O campo Conta  deve ter 8 caracteres!!', ['&Ok']);
              Result := False;
            End;
          End

          Else If (edtcodbco.Text = '104') Then
          Begin
            If(Length(edtNumCta.Text) < 9) Then
            Begin
              edtNumCta.Text := fStrZero(edtNumCta.Text, 9);
            End;
            If(Length(edtNumCta.Text) > 9) Then
            Begin
              fMensagem('ATENÇÃO!', 'O campo Conta deve ter 9 caracteres!!', ['&Ok']);
              Result := False;
            End;
          End

          Else If (edtcodbco.Text = '341') Then
          Begin
            If(Length(edtNumCta.Text) < 5) Then
            Begin
              edtNumCta.Text := fStrZero(edtNumCta.Text,5);
            End;
            If(Length(edtNumCta.Text) > 5) Then
            Begin
              fMensagem('ATENÇÃO!', 'O campo Conta deve ter 5 caracteres!!', ['&Ok']);
              Result := False;
            End;
          End

          Else If (edtcodbco.Text = '033') Then
          Begin
            If(Length(edtNumCta.Text) < 10) Then
            Begin
              edtNumCta.Text := fStrZero(edtNumCta.Text,10);
            End;
            If(Length(edtNumCta.Text) > 10) Then
            Begin
              fMensagem('ATENÇÃO!', 'O campo Conta deve ter 10 caracteres!!', ['&Ok']);
              Result := False;
            End;
          End

          Else If (edtcodbco.Text = '237') Then
          Begin
            If(Length(edtNumCta.Text) < 7) Then
            Begin
              edtNumCta.Text := fStrZero(edtNumCta.Text,7);
            End;
            If(Length(edtNumCta.Text) > 7) Then
            Begin
              fMensagem('ATENÇÃO!', 'O campo Conta deve ter 7 caracteres!!', ['&Ok']);
              Result := False;
            End;
          End

          Else If (edtcodbco.Text = '422') Then
          Begin
            If(Length(edtNumCta.Text) < 9) Then
            Begin
              edtNumCta.Text := fStrZero(edtNumCta.Text,9);
            End;
            If(Length(edtNumCta.Text) > 9) Then
            Begin
              fMensagem('ATENÇÃO!', 'O campo Conta deve ter 9 caracteres!!', ['&Ok']);
              Result := False;
            End;
          End

          Else If (edtcodbco.Text = '756') Then
          Begin
            If(Length(edtNumCta.Text) < 8) Then
            Begin
              edtNumCta.Text := fStrZero(edtNumCta.Text,8);
            End;
            If(Length(edtNumCta.Text) > 8) Then
            Begin
              fMensagem('ATENÇÃO!', 'O campo Conta deve ter 8 caracteres!!', ['&Ok']);
              Result := False;
            End;
          End

          Else If (edtcodbco.Text = '021') Then
          Begin
            If(Length(edtNumCta.Text) < 11) Then
            Begin
              edtNumCta.Text := fStrZero(edtNumCta.Text,11);
            End;
            If(Length(edtNumCta.Text) > 11) Then
            Begin
              fMensagem('ATENÇÃO!', 'O campo Conta deve ter 11 caracteres!!', ['&Ok']);
              Result := False;
            End;
          End;
        End;
      End
      Else If (Sender = edtCompDes) And (cdsBcoFor.State in dsEditModes) Then
      Begin
        If Not fEmptyStr(edtCompDes.Text) then
        begin
          If (edtCompDes.Text <> 'CC') And (edtCompDes.Text <> 'PP') then
          begin
            fMensagem('','O campo Código Complementar deve ser CC ou PP!',['&O K']);
            Result := False;
          end
        end;
      End

      {*****************************************}
      {* VALIDA DADOS DA CHAVE PIX             *}
      {**************************************AJ*}
      Else If (Sender = cmbTipoDoPix) Then
      Begin
        If FDataSetForPix.State in dsEditModes Then
        Begin
          If cmbTipoDoPix.ItemIndex < 0 Then
          Begin
            fMensagem('', 'É necessário selecionar o Tipo do Pix!', ['&Ok']);
            pgcDados.TabIndex := 3;
            Result := False;
          End;
        End;
      End
      Else If (Sender = edtCPFCNPJPix) Then
      Begin
        If FDataSetForPix.State in dsEditModes Then
        Begin
          If edtCPFCNPJPix.Visible Then
          Begin
            If Not MatchStr(edtCPFCNPJPix.Text, ['1', '2']) Then
            Begin
              fMensagem('', 'Deve ser selecionado 1 para CNPJ e 2 para CPF para a chave do Pix!', ['&Ok']);
              pgcDados.TabIndex := 3;
              Result := False;
            End;
          End;
        End;
      End
      Else If (Sender = edtChavePix) Then
      Begin
        If FDataSetForPix.State in dsEditModes Then
        Begin
          If fEmptyStr(edtChavePix.Text) Then
          Begin
            fMensagem('','O campo Chave deve ser preenchido!',['&Ok']);
            pgcDados.TabIndex := 3;
            Result := False;
          End
          Else
          Begin
            If FDatasetForPixClone.Locate('PIX_TIPCHV;PIX_CHAVE_', VarArrayOf([RetornaTipoChavePix(cmbTipoDoPix.ItemIndex), edtChavePix.Text]), []) Then
            Begin
              fMensagem('ATENÇÃO', 'Essa chave Pix já está cadastrada para esse fornecedor!', ['&Ok']);
              pgcDados.ActivePage := tbsDadosDeposito;
              Result := False;
            End
            Else If cmbTipoDoPix.ItemIndex In [0, 3] Then
            Begin
              If Length(edtChavePix.Text) < edtChavePix.MaxLength Then
              Begin
                fMensagem('', 'O campo Chave deve possuir ' + edtChavePix.MaxLength.ToString + ' dígitos!', ['&Ok']);
                pgcDados.TabIndex := 3;
                Result := False;
              End
              Else If (edtCPFCNPJPix.Visible) And (Not fValidaCnpjCpf(edtCPFCNPJPix.Text, edtChavePix.Text, False)) Then
              Begin
                pgcDados.TabIndex := 3;
                Result := False;
              End;
            End
            Else If cmbTipoDoPix.ItemIndex = 1 Then
            Begin
              If (Not fValidaTelefone(edtChavePix.Text)) Then
              Begin
                fMensagem('','O campo Chave deve ser preenchido com um número de telefone válido! (<DDD>)<Telefone> Ex.: (11)98888-8888', ['&Ok']);
                pgcDados.TabIndex := 3;
                Result := False;
              End;
            End
            Else
            Begin
              If Not fEmailValido(edtChavePix.Text, False) Then
              Begin
                fMensagem('', 'O campo Chave deve ser preenchido com um email válido!', ['&Ok']);
                pgcDados.TabIndex := 3;
                Result := False;
              End;
            End;
          End;
        End;
      End

      Else If Sender = mskCodGru Then
      Begin

        If fEmptyStr(fTiraCaracEspeciais(mskCodGru.Text)) Then
        Begin

         edtDesGru.Clear;

        End;

      End

      Else If (Sender = dbeCompra) Then
      Begin

        If fEmptyStr(dbeCompra.Text) Then
          edtDesCompra.Clear
        Else
        Begin
          edtDesCompra.Text := fRetNomeOperador(dbeCompra.Text);

          If fEmptyStr(edtDesCompra.Text) Then
          Begin
            Result := False;
            pgcDados.ActivePage := tbsPraEnt;
            pMensagemOk('Comprador não encontrado!');
          End;

        End;

        If blnBuscaPorChave And Result Then
        Begin
          cxvEmpresas.NavigatorButtons.First.Click;
          cxvEmpresasPRAENT.Focused := True;
        End;
      End

      Else If (Sender = mskMesAno) Then
      Begin

        If blnBuscaPorChave Then
        Begin

          If fEmptyDate(mskMesAno.Text) Then
          Begin
            Result := False;
            pMensagemOk('Informe o mês para cadastramento!');
          End

          Else If StrToDateDef('01/' + mskMesAno.Text,0) <= 0 Then
          Begin
            mskMesAno.Clear;
            Result := False;
            pMensagemOk('Mês/Ano inválido!');
          End

          Else mskMesAno.Text := FormatDateTime('MM/YYYY', StrToDate( '01/' + mskMesAno.Text));

        End;

      End

      Else if (Sender = chkFOR_IDPCID) Or (Sender = chkFOR_ADICPC) Then
      Begin
        If chkFOR_IDPCID.Checked and chkFOR_ADICPC.Checked Then
        Begin
          Result := False;
          pMensagemOk('"Incluir desconto de PIS/COFINS na base de cálculo do ICMS Desonerado ?" e ' +
                      '"Aplicar desconto de ICMS Desonerado na base de cálculo do PIS/COFINS ?" não podem ser marcadas em conjunto!');
        End;

      End

      Else If (Sender = edtValMes) Then
      Begin

        If blnBuscaPorChave Then
        Begin

          If fEmptyStr(edtValMes.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'O Valor mensal deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else If fStrToFloat(edtValMes.Text) < 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'O Valor mensal deve ser maior ou igual zero!', ['&O k']);
            Result := False;
          End

          Else edtValMes.Text := FormatFloat(fMskDigitos(2), fStrToFloat(edtValMes.Text));

        End;

      End

      Else If (Sender = dbeCodNatRend) and (gbpREINF.Visible) Then
      Begin
        if not fEmptyStr(dbeCodNatRend.Text) then
          pCarregaNaturezaRedimentoReinf;
      End

      Else If (Sender = dbeCodTipServ) and (gbpREINF.Visible) Then
      Begin
        if not fEmptyStr(dbeCodTipServ.Text) then
          pCarregaTipoServicoReinf;
      End;

    End;

  Except

    On E: ExceptionAutCom Do
    Begin
      Result := False;
      fMensagem('',E.Message, ['&Ok']);
    End;

    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmCadFornecedores.fValidaCampos]');
      Result := False;
    End;

  End;

  edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
  edtRefere.Text := fRetReferenciaProd(edtCodIte.Text);

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadFornecedores.fValidaCamposCCFORE(Sender: TWinControl;
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
           (strStatus = 'INSERT') Then
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

procedure TfrmCadFornecedores.GravarDadosPix;
  Var
    LDataset: TUniQuery;

    LDatasetExclusao: TUniClientDataset;
begin
  LDataSet := fCriaQuery;

  // Para o sistema não gravar o Pix em Branco, ativo o click do botão(se caso o mesmo não foi clicado)
  If (btnGravarPix.Enabled And btnCancelarPix.Enabled) Then
    btnGravarPix.Click;

  //Exclusão
  FDatasetForPix.Filter := 'TIPOACAO=''3'' ';
  If Not FDatasetForPix.IsEmpty Then
  Begin
    LDatasetExclusao := fCriaClientDatSet(FDatasetForPix);
    LDatasetExclusao.Fields.Remove(LDatasetExclusao.FindField('TIPOACAO'));

    LDataset.SQL.Text := 'DELETE FROM FORPIX WHERE AUTOINCREM=:AUTOINC';

    FDatasetForPix.First;
    While Not FDatasetForPix.Eof Do
    Begin
      LDatasetExclusao.Locate('AUTOINCREM', FDatasetForPix.FieldByName('AUTOINCREM').AsString, []);
      fVerificaIntegridade(Self.Name, 'FORPIX', LDatasetExclusao, True);

      LDataset.ParamByName('AUTOINC').AsString := FDatasetForPix.FieldByName('AUTOINCREM').AsString;
      LDataset.ExecSQL;

      FDatasetForPix.Next;
    End;

    FreeAndNil(LDatasetExclusao);
  End;

  //Inclusao
  FDatasetForPix.Filter := 'TIPOACAO=''1'' ';
  If Not FDatasetForPix.IsEmpty Then
  Begin
    LDataset.SQL.Text := Concat('INSERT INTO FORPIX (AUTOINCREM, ',
                                '                    PIX_CODFOR, ',
                                '                    PIX_TIPCHV, ',
                                '                    PIX_CHAVE_) ',
                                '           VALUES (:AUTOINCREM, ',
                                '                   :PIX_CODFOR, ',
                                '                   :PIX_TIPCHV, ',
                                '                   :PIX_CHAVE_) ');

    While Not FDatasetForPix.Eof Do
    Begin
      LDataset.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('FORPIX', VS_strCodEmp);
      LDataset.ParamByName('PIX_CODFOR').AsString := FDatasetForPix.FieldByName('PIX_CODFOR').AsString;
      LDataset.ParamByName('PIX_TIPCHV').AsString := FDatasetForPix.FieldByName('PIX_TIPCHV').AsString;
      LDataset.ParamByName('PIX_CHAVE_').AsString := FDatasetForPix.FieldByName('PIX_CHAVE_').AsString;

      LDataset.ExecSQL;

      FDatasetForPix.Next;
    End;
  End;

  //Alteração
  FDatasetForPix.Filter := 'TIPOACAO=''2'' ';
  If Not FDatasetForPix.IsEmpty Then
  Begin
    LDataset.SQL.Text := Concat('UPDATE FORPIX SET PIX_TIPCHV = :PIX_TIPCHV, ',
                                '                  PIX_CHAVE_ = :PIX_CHAVE_  ',
                                '            WHERE AUTOINCREM = :AUTOINCREM  ');

    While Not FDatasetForPix.Eof Do
    Begin
      LDataset.ParamByName('AUTOINCREM').AsString := FDatasetForPix.FieldByName('AUTOINCREM').AsString;
      LDataset.ParamByName('PIX_TIPCHV').AsString := FDatasetForPix.FieldByName('PIX_TIPCHV').AsString;
      LDataset.ParamByName('PIX_CHAVE_').AsString := FDatasetForPix.FieldByName('PIX_CHAVE_').AsString;

      LDataset.ExecSQL;

      FDatasetForPix.Next;
    End;
  End;

  FreeAndNil(LDataset);

  FDatasetForPix.Filter := 'TIPOACAO <> ''3'' ';
end;

procedure TfrmCadFornecedores.grdEmpForKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmCadFornecedores.grdImpostosRET_ALIQUOGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
Var
  strTipo: String;
begin
  inherited;
  strTipo := VarToStr(grdImpostosTableView1.ViewData.Records[ARecordIndex].Values[grdImpostosRET_TIPRET.Index]);
  If strTipo = '5' Then
    AText := FormatFloat('#,##0.0000', fStrToFloat(AText))
  Else
    AText := FormatFloat('#,##0.00', fStrToFloat(AText));
end;

procedure TfrmCadFornecedores.grdImpostosTableView1DblClick(Sender: TObject);
begin
  inherited;

  btnAlterarImp.Click();
end;

procedure TfrmCadFornecedores.grdImpostosTableView1EditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_RETURN) And (btnAlterarImp.Enabled) Then
    btnAlterarImp.Click();

  If (Key = VK_ESCAPE) And (btnCancelarImp.Enabled) Then
    btnCancelarImp.Click();

  If (Key = VK_DELETE) And (btnExcluirImp.Enabled) Then
    btnExcluirImp.Click();
end;

procedure TfrmCadFornecedores.HabilitarBotoesPix(AEmEdicao: Boolean);
begin
  btnGravarPix.Enabled   := AEmEdicao;
  btnCancelarPix.Enabled := AEmEdicao;
  btnIncluirPix.Enabled  := Not AEmEdicao;
  btnAlterarPix.Enabled  := Not AEmEdicao;
  btnExcluirPix.Enabled  := Not AEmEdicao;

  pnlCamposPix.Enabled := AEmEdicao;
  grbDadosBancarios.Enabled := Not AEmEdicao;
  dbgChavesPix.Enabled := Not AEmEdicao;
end;

procedure TfrmCadFornecedores.tbsGestaoControleEnter(Sender: TObject);
begin
  inherited;
  pnlDadosCertificado.Visible := qryTabela.FieldByName('FOR_OBGCTR').AsString.Equals('S');
end;

procedure TfrmCadFornecedores.UtilizaCadastroDeCondicaoDePagamento;
begin

  If Not fCfgSis('USACND', varBoolean) Then
  Begin
    dbeCodCnd.Visible := False;
    dbeCndPag.Width := 544;
    dbeCndPag.Left := 93;
  End;

end;

procedure TfrmCadFornecedores.pCarregaCondicao;
begin
  pPesquisaCadCnd(qryConCnd, qryConCnd, dbeCodCnd.Text);
  If Not qryConCnd.IsEmpty Then
  Begin
    If (qryTabela.State In [dsInsert, dsEdit]) Then
      dbeCndPag.Field.AsString := fRetCondicao('', 0, qryConCnd.FieldByName('CND_TIPFOR').AsString, qryConCnd.FieldByName('CND_CNDPAG').AsString, qryConCnd.FieldByName('CND_CNDPAG').AsString);
    edtCndDescri.Text := qryConCnd.FieldByName('CND_DESCRI').AsString
  End
  Else
    edtCndDescri.Clear;
end;

procedure TfrmCadFornecedores.miBuscarClick(Sender: TObject);
Var
  strArquivo,
  strArquivoCopy: String;
begin
  inherited;
  If odgCertGestao.Execute Then
  Begin
    Try
      strArquivo := odgCertGestao.FileName;
      strArquivoCopy := ExtractFilePath(ParamStr(0))+ExtractFileName(strArquivo);
      CopyFile(PWChar(strArquivo), PWChar(strArquivoCopy), False);

      TBlobField(qryTabela.FieldByName('FOR_CERB64')).LoadFromFile(strArquivoCopy);
      qryTabela.FieldByName('FOR_CEREXT').AsString := ExtractFileExt(strArquivoCopy);

      DeleteFile(strArquivoCopy);
      fMensagem('','Certificado de gestão carregado com sucesso',['&Ok']);
      miVisualizarClick(Sender);
    Except On
      E:Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmCadFornecedores.lblBuscarCertClick');
      End;
    End;
  End;
end;

procedure TfrmCadFornecedores.miExportarClick(Sender: TObject);
var
  strNomeArq: String;
begin
  inherited;
  strNomeArq := qryTabela.FieldByName('FOR_CODFOR').AsString + '_certificado_gestao' + qryTabela.FieldByName('FOR_CEREXT').AsString;
  If fodExportarCert.Execute Then
  Begin
    TBlobField(qryTabela.FieldByName('FOR_CERB64')).SaveToFile(fodExportarCert.FileName + PathDelim + strNomeArq);
    fMensagem('AVISO', 'Certificado exportado com sucesso em:' + #13 + fodExportarCert.FileName + PathDelim + strNomeArq, ['&Ok']);
  End;
end;

procedure TfrmCadFornecedores.miVisualizarClick(Sender: TObject);
var
  stream: TMemoryStream;
  strExt: String;
  jpg:TJpegImage;
begin
  inherited;
  strExt := qryTabela.FieldByName('FOR_CEREXT').AsString;

  If qryTabela.FieldByName('FOR_CERB64').AsString.isEmpty Then
    Exit;

  If strExt = '.pdf' Then
  Begin
    Try
      stream := TMemoryStream.Create;
      TBlobField(qryTabela.FieldByName('FOR_CERB64')).SaveToStream(stream);

      dxPDFViewer.Visible := True;
      dxPDFViewer.LoadFromStream(stream);
      imgCertificado.Visible := False;
    Finally
      FreeAndNil(stream);
    End;
  End
  Else
  Begin
    jpg := TJpegImage.Create;
    jpg.Assign(TBlobField(qryTabela.FieldByName('FOR_CERB64')));

    imgCertificado.Picture.Bitmap.Assign(jpg);

    jpg.Free;

    dxPDFViewer.Visible := False;
    imgCertificado.Visible := True;
  End;
end;

procedure TfrmCadFornecedores.mskCodGruExit(Sender: TObject);
  Var
    arrGru: TConsultasArray;
begin
  inherited;

  pEdtCodSelectExit(mskCodGru, edtDesGru, arrGru, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);

  If fEmptyStr(mskCodGru.Text) Then
    edtDesGru.Clear;
end;

procedure TfrmCadFornecedores.mskCodGruKeyPress(Sender: TObject; var Key: Char);
  Var
    arrGru: TConsultasArray;
begin
  inherited;

  If fPesqGrupo(Self, mskCodGru, edtDesGru, Nil, Key, arrGru, True) Then
  Begin
    If fValidaCampos(mskCodGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadFornecedores.pCarregaCidade(qryConsulta: TUniQuery; edtCidade,
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

  End;
end;

procedure TfrmCadFornecedores.pCarregaCidadeCtt;
begin
  pPesquisaCadCid(qryCadCid, qryConCtt, edtCidCtt.Text);
  With qryConCtt Do
  Begin
    edtDesCidCtt.Text := FieldByName('CID_NOMCID').AsString;
    edtEstadoCtt.Text := FieldByName('CID_ESTADO').AsString;
  End;
end;

procedure TfrmCadFornecedores.pCarregaAtividade;
begin
  pPesquisaCadAti(qryCadAti, qryConAti, dbeCodAti.Text);
  With qryConAti Do
  Begin
    edtAtividade.Text := FieldByName('ATI_DESATI').AsString;
  End;
end;

procedure TfrmCadFornecedores.pCarregaGrupoEconomico;
begin
  If Not fEmptyStr(dbeCODGEF.Text) Then
    edtDESGEF.Text := fRetNomGrupoEconomico(dbeCODGEF.Text)
  Else
    edtDESGEF.Clear;
end;

procedure TfrmCadFornecedores.pCarregaNaturezaRedimentoReinf;
begin
  if not gbpREINF.Visible then
    Exit;

  edtNatRend.Text := fRetReinfNaturezaDoRendimento(dbeCodNatRend.Text);
end;

procedure TfrmCadFornecedores.pCarregaBanco;
begin
  pPesquisaCadBco(qryConBco, qryConBco, edtCodBco.Text);
  With qryConBco Do
  Begin
    edtNomBco.Text := FieldByName('BCO_NOMBCO').AsString;
    edtCodBco.Text := FieldByName('BCO_CODBCO').AsString;
  End;
end;

{**************************************************}
{ NO BANCO FOR_MATREV É CHAR(1), POR ISSO O CASE.  }
{************************************************LE}
procedure TfrmCadFornecedores.pCarregaTipoFornecedores;
begin
  If fEmptyStr(qryTabela.FieldByName('FOR_MATREV').AsString) Then
    cbxMarRev.ItemIndex := -1
  Else Case qryTabela.FieldByName('FOR_MATREV').AsString[1] Of
         'C': cbxMarRev.ItemIndex := 0;
         'D': cbxMarRev.ItemIndex := 1;
         'I': cbxMarRev.ItemIndex := 2;
         'R': cbxMarRev.ItemIndex := 3;
         'M': cbxMarRev.ItemIndex := 4;
         'Y': cbxMarRev.ItemIndex := 5;
       End;

  cbxMarRev.Enabled := (qryTabela.State In [dsEdit,dsInsert]);
end;

procedure TfrmCadFornecedores.pCarregaTipoServicoReinf;
begin
  if not gbpREINF.Visible then
    Exit;

  edtTipoServico.Text := fRetReinfTipoDeServico(dbeCodTipServ.Text);
end;

procedure TfrmCadFornecedores.pCarregaTransportador(blnTransRedespacho: Boolean);
var
  dbeCodTransLoc : TDbEditFocus;
  edtNomTransLoc : TEditFocus;
begin
  If blnTransRedespacho Then
  begin
    dbeCodTransLoc := dbeCodTransRedes;
    edtNomTransLoc := edtNomTransRedes;
  End
  Else
  Begin
    dbeCodTransLoc := dbeCodTrans;
    edtNomTransLoc := edtNomTrans;
  End;
  If Not fEmptyStr(dbeCodTransLoc.Text) Then
    edtNomTransLoc.Text := fRetNomTransportadora(dbeCodTransLoc.Text)
  Else
    edtnomTransLoc.Clear;
end;

procedure TfrmCadFornecedores.pCarregaPortador;
begin
  If Not fEmptyStr(dbeCodPor.Text) Then
    edtNomPor.text := fRetNomPortador(dbeCodPor.Text)
  Else
    edtNomPor.Clear;
end;

procedure TfrmCadFornecedores.pControlaBotoes;
begin
  edtCodEmp.Enabled := (strStatus = 'INSERT') or (strStatus = 'UPDATE');
  edtConcon.Enabled := (strStatus = 'INSERT') or (strStatus = 'UPDATE');
  grdEmpFor.Enabled := Not ((strStatus = 'INSERT') or (strStatus = 'UPDATE'));

  btnIncluirCC.Enabled := Not((strStatus = 'INSERT') or (strStatus = 'UPDATE'));
  btnGravarCC.Enabled := (strStatus = 'INSERT') or (strStatus = 'UPDATE');
  btnAlterarCC.Enabled := Not((strStatus = 'INSERT') or (strStatus = 'UPDATE'));
  btnExcluirCC.Enabled := Not((strStatus = 'INSERT') or (strStatus = 'UPDATE'));
  btnCancelarCC.Enabled := (strStatus = 'INSERT') or (strStatus = 'UPDATE');
end;

procedure TfrmCadFornecedores.pDeletaRegEmpFor;
  Var
    qryDelete: TUniQuery;
begin
  qryDelete := fCriaQuery(Nil);
  Try
    qryDelete.SQL.Add('DELETE ');
    qryDelete.SQL.Add('FROM ');
    qryDelete.SQL.Add('  CCFORE ');
    qryDelete.SQL.Add('WHERE AUTOINCREM = :AUTOINCREM ');

    qryDelete.ParamByName('AUTOINCREM').AsString := cdsEmpForAUTOINCREM.AsString;
    qryDelete.ExecSQL;
  Finally
    qryDelete.Free;
  End;
end;

procedure TfrmCadFornecedores.pIncluiCentroDeCusto;
Begin
  if fValidaCampos(fraPlanoDeContasPl.MskCodCta, False) = False then
    Exit;

  With cdsForCta Do
  Begin

    If (Not fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContasPl.MskCodCta.Text))) Then
    Begin
      If Not Locate('CTF_CODFOR;CTF_CODCTA;CTF_CODEMP', VarArrayOf([qryTabela.FieldByName('FOR_CODFOR').AsString, fTiraCaracEspeciais(fraPlanoDeContasPl.MskCodCta.Text), VS_strCodEmp]), []) Then
      Begin
        Insert;
        FieldByName('CTF_CODFOR').AsString := qryTabela.FieldByName('FOR_CODFOR').AsString;
        FieldByName('CTF_CODCTA').AsString := fTiraCaracEspeciais(fraPlanoDeContasPl.MskCodCta.Text);
        FieldByName('CTF_CODEMP').AsString := VS_strCodEmp;
        FieldByName('CTA_DESCTA').AsString := fraPlanoDeContasPl.edtDesCta.Text;
        Post;
      End;

      fraPlanoDeContasPl.MskCodCta.Clear;
      fraPlanoDeContasPl.edtDesCta.Clear;

      pSetFocus(fraPlanoDeContasPl.MskCodCta);
    End;

  End;

end;

procedure TfrmCadFornecedores.pIniciaCadExterno;
  var
    onFormShow:  TNotifyEvent;
    onFormClose: TCloseEvent ;
begin
  onFormShow  := Self.OnShow;
  onFormClose := Self.OnClose;
  Self.OnShow := nil;
  Self.OnClose := nil;

  ShowModal;
  Self.OnShow  := onFormShow;
  Self.OnClose := onFormClose;
end;

procedure TfrmCadFornecedores.pInicializaIndices;
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('FOR_CODFOR');
  stlCampos.Add('FOR_NOMFOR');
  stlCampos.Add('FOR_NOMFAN');
  stlCampos.Add('FOR_ENDERE');
  stlCampos.Add('FOR_BAIRRO');
  stlCampos.Add('FOR_CONTAT');
  stlCampos.Add('FOR_C_E_P_');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('FOR_NOMFAN');
  stlCamInd.Add('FOR_NOMFOR');
  stlCamInd.Add('FOR_CODFOR');
  stlCamInd.Add('FOR_C_G_C_');
  stlDesInd.Add('Nome Fantasia');
  stlDesInd.Add('Nome do Fornecedor');
  stlDesInd.Add('Código');
  stlDesInd.Add('CNPJ');

  pAtribuiTabelas;

end;

procedure TfrmCadFornecedores.pInicializaVariaveis;
begin
  strCepAnt    := '';
  strRepCepAnt := '';
  strNomAnt := '';
  strCidAnt := '';
  strCgcAnt := '';
  strIesAnt := '';
  strEndAnt := '';
  strNumAnt := '';
  strComAnt := '';
  strBaiAnt := '';
  strPlCtaAuxOld := '';
  strPlCtaCmpOld := '';
  strPlCtaImpOld := '';
end;

procedure TfrmCadFornecedores.pInsereRegEmpFor;
  Var
    qryInsert: TUniQuery;
begin
  qryInsert := fCriaQuery(Nil);
  Try
    qryInsert.SQL.Add('INSERT INTO CCFORE ');
    qryInsert.SQL.Add('( ');
    qryInsert.SQL.Add('  CCF_CODFOR, ');
    qryInsert.SQL.Add('  CCF_CODEMP, ');
    qryInsert.SQL.Add('  CCF_CONCON, ');
    qryInsert.SQL.Add('  AUTOINCREM ');
    qryInsert.SQL.Add(') ');
    qryInsert.SQL.Add('VALUES (');
    qryInsert.SQL.Add('  :CODFOR, ');
    qryInsert.SQL.Add('  :CODEMP, ');
    qryInsert.SQL.Add('  :CONCON, ');
    qryInsert.SQL.Add('  :AUTOINCREM ');
    qryInsert.SQL.Add(') ');

    qryInsert.ParamByName('CODFOR').AsString := dbeCodigo.Text;
    qryInsert.ParamByName('CODEMP').AsString := cdsEmpForCodEmp.AsString;
    qryInsert.ParamByName('CONCON').AsString := cdsEmpForConcon.AsString;
    qryInsert.ParamByName('AUTOINCREM').AsString := cdsEmpForAUTOINCREM.AsString;
    qryInsert.ExecSQL;
  Finally
    qryInsert.Free;
  End;
end;

procedure TfrmCadFornecedores.FormShow(Sender: TObject);
begin
  inherited;
  tbsPreFor.TabVisible := fCfgSis('PRESPD', varBoolean);
  tbsPraEnt.TabVisible      := blnUTIPCM;
  tsbAutonomas.TabVisible   := blnUTIPCM;
  tbsValorPedido.TabVisible := blnUTIPCM;
  tbsGestaoControle.TabVisible := fCfgSis('CTRQLD', varBoolean);

  dbeDesBav.Visible := fCfgSis('HABCMP', varBoolean);
  dbeDesBap.Visible := dbeDesBav.Visible;
  lblDesBavBap.Visible := dbeDesBav.Visible;
  lblPctDap.Visible := dbeDesBav.Visible;
  lblPctDav.Visible := dbeDesBav.Visible;

  IntAbaSel := 0;
  grbNivel.Enabled     := False;
  grbCalMinMax.Enabled := False;

  gbpREINF.Visible := fCfgSis('UTIREI', varBoolean);

  objRepFor.fCarregaRepresentante(dbeCodigo.Text);

  If Assigned(objMinMax) Then
  Begin
    objMinMax.fCarregaDados(dbeCodigo.Text);
    cxvMinMax.NavigatorButtons.First.Click;
  End;

  if Assigned(fCriaEstruturaCdsNCO) then
    FcdsNCO := fCriaEstruturaCdsNCO(Nil);

  pCarregaOperador;
  pCarregaCidade(qryConCid, edtCidade, edtEstado, dbeCodCid, dbeNumCep, strCepAnt);
  pCarregaCidade(qryConCidRep, edtRepCidade, edtRepEst, dbeRepCodCid, dbeRepNumCep, strRepCepAnt);
  pCarregaCidadeCtt;
  pCarregaAtividade;
  pCarregaGrupoEconomico;
  pCarregaTransportador(False);
  pCarregaTransportador(True);
  pCarregaPortador;
  pCarregaCondicao;
  pCarregarRetencoes();
  pCarregarDadosBancarios;
  pCarregaCliente;

  blnVinculaCliFor  := fCfgSis('CLIFOR', varBoolean);
  lblCliFor.Visible := blnVinculaCliFor;
  dbeCodCli.Visible := blnVinculaCliFor;
  edtNomCli.Visible := blnVinculaCliFor;

  If fCfgSis('USACTF', varBoolean) Then
    pCarregaCentroDeCustoCxg('')
  Else
    pCarregaCentroDeCustoDB(fraPlanoDeContasCmp.dbeCodCta, fraPlanoDeContasCmp.edtDesCta);

  pCarregaCentroDeCustoDB(fraPlanoDeContasAux.dbeCodCta, fraPlanoDeContasAux.edtDesCta);

  pCarregaFornecedorFunrural;
  pCarregaEventoDB(dbeCodEve, edtDesEve);
  pCarregaCentroDeCustoDB(fraPlanoDeContasFunrural.dbeCodCta, fraPlanoDeContasFunrural.edtDesCta);

  pnlForCta.Enabled := False;
  tbsRetencoes.Enabled := False;

  dbeCgcCpf.Visible := (fSetaPais <> opcParaguai);

  If blnUtilizarCrm Then
    pAplicarRegrasCrm;

  If Not fEmptyStr(strCodFornecedorIniciarCadastro) Then Begin
    pBuscaFornecedor(strCodFornecedorIniciarCadastro);
  End;

  If (blnUtiCon) Then
  Begin
    dbePlaNco.Visible := True;
    edtDesPlaNco.Visible := True;
    dbeConCon.Visible := False;
    lblDesPlaCon.Caption := 'Plano Contábil:';
    btnPlaNco.Visible := True;
    btnPlaNco.Enabled := Assigned(pPlanoDeContasPorEmpresa);
  End
  Else
  Begin
    dbePlaNco.Visible := False;
    edtDesPlaNco.Visible := False;
    dbeConCon.Visible := True;
    lblDesPlaCon.Caption := 'Conta Contábil:';
    btnPlaNco.Visible := False;
  End;
  dbeSEMAGE.Visible := fUtilzaShelfLife;
  lblSEMAGE.Visible := dbeSEMAGE.Visible;
  lblSEMAGEResp.Visible := dbeSEMAGE.Visible;

  pSetaCodIte( edtCodIte );
  UtilizaCadastroDeCondicaoDePagamento;


  If blnCarregamentoExterno Then
  Begin
    frmCadFornecedores.qryTabela.sql.Text := 'SELECT * FROM CADFOR WHERE FOR_CODFOR = "' + strCodFor + '"';
    frmCadFornecedores.qryTabela.Open;

    If blnUtilizarCrm Then
      pTrataCarregaMentoCRM
    Else
      pCarregaFornecedorGeral;

    pTrataCarregamentoConsulta;
  End;

end;

procedure TfrmCadFornecedores.btnCadClientesClick(Sender: TObject);
var
  strCodCli: string;

    function fExisteCnpjCpfCliente(Var strCodCli: String; strCodigo, strEstado: String): Boolean;
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
          strSQL := strSQL + '   CLI_CODCLI           ';
          strSQL := strSQL + ' FROM                   ';
          strSQL := strSQL + '   CADCLI               ';
          strSQL := strSQL + ' WHERE                  ';
          strSQL := strSQL + '   CLI_C_G_C_ = :CODIGO ';

          With qryGenTmp Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('CODIGO').AsString := strCodigo;
            Open;

            If Not IsEmpty Then
            Begin
              strCodCli := FieldByName('CLI_CODCLI').AsString;
              fMensagem('ATENÇÃO','Já existe o CNPJ / CPF cadastrado para o Código: ' + #13 +
                                  strCodCli + ' no Cadastro de Clientes!',['&OK']);
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
  if (qryTabela.State in [dsEdit, dsInsert]) and (assigned(fCadastroRapidoCliente)) then
  begin
    If Not fUsaProCodigo('CADCLI') Then
    Begin
      fMensagem('ATENÇÃO!',
                'Para utilizar o "Cadastro Rápido" para o "Cadastro de Clientes" é necessário:'     + #13 +
                'Habilitar a geração de código automático acessando:  "> Útil > Próximos Códigos",' + #13 +
                'localize o arquivo "CADCLI" e habilite a opção "Automático".',
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

    if (qryTabela.IsEmpty) then
    begin
      fMensagem('ATENÇÃO!', 'É necessário escolher um registro!', ['&Ok']);
      Exit;
    end;

    if (fEmptyStr(dbeCodigo.Text)) and (dbeCodigo.Enabled) then
    begin
      fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
      Exit;
    end;

    if (fEmptyStr(dbeNomFor.Text)) then
    begin
      fMensagem('ATENÇÃO!', 'O Nome deve ser preenchido!', ['&Ok']);
      Exit;
    end;

    if (fEmptyStr(dbeCgcCpf.Text)) or (dbeCgcCpf.Text = '0') then
    begin
      fMensagem('ATENÇÃO!', 'O CNPJ / CPF deve ser preenchido!', ['&Ok']);
      Exit;
    end
    else if (not fValidaCnpjCpf(dbeCgcCpf.Text, dbeNumCgc.Text, False, False)) then
    begin
      fMensagem('ATENÇÃO!', 'CNPJ / CPF inválido!', ['&Ok']);
      Exit;
    end;

    if (not fExisteCnpjCpfCliente(strCodCli, dbeNumCgc.Text, edtEstado.Text)) then
    begin
      If (fMensagem('AVISO', 'Confirma a Geração do Cadastro de Clientes?', ['&Sim', '&Não']) = 2) Then
        Exit;

      If fCadastroRapidoCliente(strCodCli,
                                dbeNomFor.Text,
                                dbeNomFan.Text,
                                dbeEndere.Text,
                                '',
                                '',
                                dbeBairro.Text,
                                dbeCodCid.Text,
                                dbeNumCep.Text,
                                dbeFone01.Text,
                                '',
                                dbeNumRg.Text,
                                dbeNumIes.Text,
                                dbeEmail.Text,
                                '',
                                'A',
                                '',
                                StrToInt(dbeCgcCpf.Text),
                                dbeNumCgc.Text,
                                '',
                                '',
                                StrToDateDef(dbeDtaCad.Text,0),
                                0,
                                dbeFon02.Text,
                                dbeHomPag.Text,
                                dbeCodAti.Text) Then

      fMensagem('ATENÇÃO!', 'Geração concluída com sucesso!' + #13 +
                            'Cadastro de Clientes criado com o Código: ' + strCodCli, ['&Ok']);
    end
    else
    begin
      If (fMensagem('AVISO', 'Confirma a Atualização do Cadastro de Clientes?', ['&Sim', '&Não']) = 2) Then
        Exit;

      If fCadastroRapidoCliente(strCodCli,
                                dbeNomFor.Text,
                                dbeNomFor.Text,
                                dbeEndere.Text,
                                '',
                                '',
                                dbeBairro.Text,
                                dbeCodCid.Text,
                                dbeNumCep.Text,
                                dbeFone01.Text,
                                '',
                                dbeNumRg.Text,
                                dbeNumIes.Text,
                                dbeEmail.Text,
                                '',
                                'A',
                                '',
                                StrToInt(dbeCgcCpf.Text),
                                dbeNumCgc.Text,
                                '',
                                '',
                                StrToDateDef(dbeDtaCad.Text,0),
                                0,
                                dbeFon02.Text,
                                dbeHomPag.Text,
                                dbeCodAti.Text) Then

      fMensagem('ATENÇÃO!', 'Atualização concluída com sucesso!', ['&Ok']);
    end;

    if (not fEmptyStr(strCodCli)) then
    begin
      pAtualizaCodCliFornecedor(strCodCli);
  end;

  pCarregaNaturezaRedimentoReinf;
  pCarregaTipoServicoReinf;
end;
end;

procedure TfrmCadFornecedores.btnCadTransportadoraClick(Sender: TObject);
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
  if (qryTabela.State in [dsEdit, dsInsert]) and (assigned(fCadastroRapidoTransportadora)) then
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

    if (fEmptyStr(dbeCodigo.Text)) and (dbeCodigo.Enabled) then
    begin
      fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
      Exit;
    end;

    if (fEmptyStr(dbeNomFor.Text)) then
    begin
      fMensagem('ATENÇÃO!', 'O Nome deve ser preenchido!', ['&Ok']);
      Exit;
    end;

    if (fEmptyStr(dbeCgcCpf.Text)) or (dbeCgcCpf.Text = '0') then
    begin
      fMensagem('ATENÇÃO!', 'O CNPJ / CPF deve ser preenchido!', ['&Ok']);
      Exit;
    end
    else if (not fValidaCnpjCpf(dbeCgcCpf.Text, dbeNumCgc.Text, False, False)) then
    begin
      fMensagem('ATENÇÃO!', 'CNPJ / CPF inválido!', ['&Ok']);
      Exit;
    end;

    if (not fExisteCnpjCpfTransportadora(strCodTra, dbeNumCgc.Text, edtEstado.Text)) then
    begin
      if (fMensagem('AVISO', 'Confirma a Geração do Cadastro de Transportadora?', ['&Sim', '&Não']) = 2) then
        Exit;

      if fCadastroRapidoTransportadora(strCodTra,
                                       dbeNomFor.Text,
                                       dbeNomFan.Text,
                                       dbeEndere.Text,
                                       dbeBairro.Text,
                                       dbeCodCid.Text,
                                       dbeNumCep.Text,
                                       dbeFone01.Text,
                                       dbeEmail.Text,
                                       dbeNumCgc.Text,
                                       dbeFon02.Text,
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

      if fCadastroRapidoTransportadora(strCodTra,
                                       dbeNomFor.Text,
                                       dbeNomFan.Text,
                                       dbeEndere.Text,
                                       dbeBairro.Text,
                                       dbeCodCid.Text,
                                       dbeNumCep.Text,
                                       dbeFone01.Text,
                                       dbeEmail.Text,
                                       dbeNumCgc.Text,
                                       dbeFon02.Text,
                                       dbeNumIes.Text,
                                       dbeHomPag.Text,
                                       StrToInt(dbeCgcCpf.Text)) then

      fMensagem('ATENÇÃO!', 'Atualização concluída com sucesso!', ['&Ok']);
    end;
  end;
end;

procedure TfrmCadFornecedores.btnCancelaClick(Sender: TObject);
begin
  inherited;

  objRepFor.pCancela;
  objRepFor.fCarregaRepresentante(dbeCodigo.Text);

  If Assigned(objMinMax) Then
  Begin
    objMinMax.fCarregaDados(dbeCodigo.Text);
    cxvMinMax.NavigatorButtons.First.Click;
  End;

  pCarregaOperador;
  pCarregaCidade(qryConCid, edtCidade, edtEstado, dbeCodCid, dbeNumCep, strCepAnt);
  pCarregaCidade(qryConCidRep, edtRepCidade, edtRepEst, dbeRepCodCid, dbeRepNumCep, strRepCepAnt);
  pCarregaAtividade;
  pCarregaGrupoEconomico;
  pCarregaTransportador(False);
  pCarregaTransportador(True);
  pCarregaPortador;
  pCarregaCondicao;
  pCarregaCliente;
  pCarregaPlanoContabil;
  if Assigned(pCarregaPlanoDeContasPorEmpresa) then
    pCarregaPlanoDeContasPorEmpresa('FORNCO', dbeCodigo.Text, FcdsNCO);

  edtDesCompra.Text := fRetNomeOperador(dbeCompra.Text);
  objPraEmp.fCarregaDados(qryTabela.FieldByName('FOR_CODFOR').AsString);

  If fCfgSis('USACTF', varBoolean) Then
    pCarregaCentroDeCustoCxg(qryTabela.FieldByName('FOR_CODFOR').AsString)
  Else
    pCarregaCentroDeCustoDB(fraPlanoDeContasCmp.dbeCodCta, fraPlanoDeContasCmp.edtDesCta);

  pCarregaCentroDeCustoDB(fraPlanoDeContasAux.dbeCodCta, fraPlanoDeContasAux.edtDesCta);

  pCarregaFornecedorFunrural;
  pCarregaEventoDB(dbeCodEve, edtDesEve);
  pCarregaCentroDeCustoDB(fraPlanoDeContasFunrural.dbeCodCta, fraPlanoDeContasFunrural.edtDesCta);

  dbgContatos.ReadOnly := True;
  pCarregaContatos(qryTabela.FieldByName('FOR_CODFOR').AsString);

  pnlForCta.Enabled := False;
  tbsRetencoes.Enabled := False;

  pgcDados.ActivePageIndex := 0;

  pCarregaComplementosNeoGrid;

  fraPatArq.Enabled := False;
  cbxLayNeo.Enabled := False;

  grbNivel.Enabled     := False;
  grbCalMinMax.Enabled := False;

  cdsForRet.Cancel();
  If objFornecedorBosh.State in dsEditModes Then
    objFornecedorBosh.pCancelar;

  pCarregarRetencoes();
  pCarregarDadosBancarios;

  pCarregaTipoFornecedores;

  pLimparCertficadoAnterior;

  objFiliasAutonomasFornecedor.fCarregaDados(qryTabela.FieldByName('FOR_CODFOR').AsString);
  objLimite.fCarregaDados(qryTabela.FieldByName('FOR_CODFOR').AsString);

  pPreparaBosh;
  btnConsultaFit.Enabled := False;

  cxvSatelites.OptionsData.Editing := False;
  tbsValorPedido.Enabled := False;

  btnCadClientes.Enabled := False;
  btnCadTransportadora.Enabled := False;

  objForPre.pCarregarItens;

  pCarregaNaturezaRedimentoReinf;
  pCarregaTipoServicoReinf;

  fValidaCampos(dbeCgcCpf);
end;

procedure TfrmCadFornecedores.pCarregaComplementosNeoGrid;
Begin
  objNeoGrid.fCarregaDados(qryTabela.FieldByName('FOR_CODFOR').AsString);

  If objNeoGrid.IsEmpty Then
    fraPatArq.edtDirectory.Clear
  Else
    fraPatArq.edtDirectory.text := objNeoGrid.FieldByName('NEO_PATARQ').AsString;

  If fEmptyStr(objNeoGrid.FieldByName('NEO_LAYNEO').AsString) Then
    cbxLayNeo.ItemIndex := -1
  Else Case objNeoGrid.FieldByName('NEO_LAYNEO').AsString[1] Of
         'C': cbxLayNeo.ItemIndex := 0;
         'D': cbxLayNeo.ItemIndex := 1;
         'E': cbxLayNeo.ItemIndex := 2;
         'B': cbxLayNeo.ItemIndex := 3;
         'G': cbxLayNeo.ItemIndex := 4;
         'F': cbxLayNeo.ItemIndex := 5;
         'N': cbxLayNeo.ItemIndex := 6;
         'S': cbxLayNeo.ItemIndex := 7;
         'H': cbxLayNeo.ItemIndex := 8;
         'I': cbxLayNeo.ItemIndex := 9;
         'A': cbxLayNeo.ItemIndex := 10;
       End;
  pEscondeTextIniArquivo;
End;

procedure TfrmCadFornecedores.pTrataCarregaMentoCRM;
begin
  objRepFor.fCarregaRepresentante(qryTabela.FieldByName('FOR_CODFOR').AsString);

  If Assigned(objMinMax) Then
  Begin
    objMinMax.fCarregaDados(qryTabela.FieldByName('FOR_CODFOR').AsString);
    cxvMinMax.NavigatorButtons.First.Click;
  End;

  pCarregaContatos(qryTabela.FieldByName('FOR_CODFOR').AsString);
  pCarregaOperador;
  pCarregaCidade(qryConCid, edtCidade, edtEstado, dbeCodCid, dbeNumCep, strCepAnt);
  pCarregaCidade(qryConCidRep, edtRepCidade, edtRepEst, dbeRepCodCid, dbeRepNumCep, strRepCepAnt);
  pCarregaAtividade;
  pCarregaGrupoEconomico;
  pCarregaTransportador(False);
  pCarregaTransportador(True);
  pCarregaPortador;
  pCarregaCondicao;
  pCarregaGridEmpFor;
  pCarregaPlanoContabil;
  if Assigned(pCarregaPlanoDeContasPorEmpresa) then
    pCarregaPlanoDeContasPorEmpresa('FORNCO', dbeCodigo.Text, FcdsNCO);

  edtDesCompra.Text := fRetNomeOperador(dbeCompra.Text);
  objPraEmp.fCarregaDados(qryTabela.FieldByName('FOR_CODFOR').AsString);


  If fCfgSis('USACTF', varBoolean) Then
  Begin
    FreeAndNil(cdsCtaAux);
    pCarregaCentroDeCustoCxg(qryTabela.FieldByName('FOR_CODFOR').AsString);
  End
  Else
    pCarregaCentroDeCustoDB(fraPlanoDeContasCmp.dbeCodCta, fraPlanoDeContasCmp.edtDesCta);

  pCarregaCentroDeCustoDB(fraPlanoDeContasAux.dbeCodCta, fraPlanoDeContasAux.edtDesCta);

  pCarregaFornecedorFunrural;
  pCarregaEventoDB(dbeCodEve, edtDesEve);
  pCarregaCentroDeCustoDB(fraPlanoDeContasFunrural.dbeCodCta, fraPlanoDeContasFunrural.edtDesCta);

  pCarregaComplementosNeoGrid;
  pCarregaTipoFornecedores;

  pCarregarRetencoes();
  pCarregarDadosBancarios;
  pCarregaCliente;

  pCarregaNaturezaRedimentoReinf;
  pCarregaTipoServicoReinf;
End;


procedure TfrmCadFornecedores.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrFornec: TConsultasArray;
    objPnlLegenda: TPanelCxFornecedor;
begin
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  chrKey := '/';
  //Utilizado somente pelo frmCRM
  If blnUtilizarCrm Then
  Begin
    pPesquisaFornecedoresCRM;
    pTrataCarregaMentoCRM;
  End
  Else
  Begin
    objPnlLegenda := TPanelCxFornecedor.Create(TfrmPnlDadosFornecedor);

    If fPesqFornecedor(conForCompleta, Self, Nil, Nil, qryTabela, chrKey,
                       arrFornec, True, objPnlLegenda) Then
    Begin
      pCarregaFornecedorGeral;
    End
    Else
    Begin
      If (Assigned(lstContatos)) Then
        lstContatos.Clear;
      cdsForCtt.EmptyDataSet;
    End;
    FreeAndNil(objPnlLegenda);

  End;

  pTrataCarregamentoConsulta;

  fValidaCampos(dbeCgcCpf);
end;

procedure TfrmCadFornecedores.pTrataCarregamentoConsulta;
var intNivIndex: integer;
begin
  objNiveis.fCarregaNivelFornecedor(qryTabela.FieldByName('FOR_CODFOR').AsString, intNivIndex);

  cmbTipFre.ItemIndex := cmbTipFre.Items.IndexOf(fDescricaoFrete(qryTabela.FieldByName('FOR_TIPFRE').AsString));
  cmbTipFreRedespacho.ItemIndex := cmbTipFreRedespacho.Items.IndexOf(fDescricaoFrete(qryTabela.FieldByName('FOR_TIPFRR').AsString));
  cmbTipNiv.ItemIndex := intNivIndex;

  objFiliasAutonomasFornecedor.fCarregaDados(qryTabela.FieldByName('FOR_CODFOR').AsString);
  objLimite.fCarregaDados(qryTabela.FieldByName('FOR_CODFOR').AsString);

  If btnAlterar.Visible And btnAlterar.Enabled Then
    pSetFocus(btnAlterar);

  pPreparaBosh;

  fraPlanoDeContasCmp.dbeCodCta.Field.EditMask := '99.99.999;0;_';
  fraPlanoDeContasAux.dbeCodCta.Field.EditMask := '99.99.999;0;_';
  fraPlanoDeContasFunrural.dbeCodCta.Field.EditMask := '99.99.999;0;_';

  miVisualizar.Click;
  pnlDadosCertificado.Visible := dbeObgCtrlGestao.Text = 'S';

  cbxCPRB.ItemIndex := StrToIntDef(qryTabela.FieldByName('FOR_C_CPRB').AsString, 0);
End;


procedure TfrmCadFornecedores.pCarregaFornecedorGeral;
begin
  objRepFor.fCarregaRepresentante(qryTabela.FieldByName('FOR_CODFOR').AsString);

  If Assigned(objMinMax) Then
  Begin
    objMinMax.fCarregaDados(qryTabela.FieldByName('FOR_CODFOR').AsString);
    cxvMinMax.NavigatorButtons.First.Click;
  End;

  pCarregaContatos(qryTabela.FieldByName('FOR_CODFOR').AsString);
  pCarregaOperador;
  pCarregaCidade(qryConCid, edtCidade, edtEstado, dbeCodCid, dbeNumCep, strCepAnt);
  pCarregaCidade(qryConCidRep, edtRepCidade, edtRepEst, dbeRepCodCid, dbeRepNumCep, strRepCepAnt);
  pCarregaAtividade;
  pCarregaGrupoEconomico;
  pCarregaTransportador(False);
  pCarregaTransportador(True);
  pCarregaPortador;
  pCarregaCondicao;
  pCarregaPlanoContabil;
  if Assigned(pCarregaPlanoDeContasPorEmpresa) then
    pCarregaPlanoDeContasPorEmpresa('FORNCO', dbeCodigo.Text, FcdsNCO);

  edtDesCompra.Text := fRetNomeOperador(dbeCompra.Text);
  objPraEmp.fCarregaDados(qryTabela.FieldByName('FOR_CODFOR').AsString);


  If fCfgSis('USACTF', varBoolean) Then
  Begin
    FreeAndNil(cdsCtaAux);
    pCarregaCentroDeCustoCxg(qryTabela.FieldByName('FOR_CODFOR').AsString);
  End
  Else
    pCarregaCentroDeCustoDB(fraPlanoDeContasCmp.dbeCodCta, fraPlanoDeContasCmp.edtDesCta);

  pCarregaCentroDeCustoDB(fraPlanoDeContasAux.dbeCodCta, fraPlanoDeContasAux.edtDesCta);

  //pCarregaFornecedorFunrural;
  pCarregaEventoDB(dbeCodEve, edtDesEve);
  pCarregaCentroDeCustoDB(fraPlanoDeContasFunrural.dbeCodCta, fraPlanoDeContasFunrural.edtDesCta);

  pCarregaComplementosNeoGrid;
  FreeAndNil(frmPnlDadosFornecedor);

  pCarregaTipoFornecedores;

  pCarregarRetencoes();
  pCarregarDadosBancarios;
  pCarregaCliente;

  strCodForExterno  := dbeCodigo.Text;

  pCarregaNaturezaRedimentoReinf;
  pCarregaTipoServicoReinf;
End;


procedure TfrmCadFornecedores.btnPlaNcoClick(Sender: TObject);
begin
  if Assigned(pPlanoDeContasPorEmpresa) then
    pPlanoDeContasPorEmpresa(dbeCodigo.Text, 'FORNCO', qryTabela.FieldByName('FOR_PLANCO').AsString, qryTabela.State, FcdsNCO, Assigned(FcdsNCO));
end;

procedure TfrmCadFornecedores.btnTabelaCondpagBoschClick(Sender: TObject);
begin
  inherited;
  pCriarForm(TfrmCadPagBosch);
end;

procedure TfrmCadFornecedores.cbxLayNeoChange(Sender: TObject);
begin
  inherited;
  pEscondeTextIniArquivo;
end;

procedure TfrmCadFornecedores.cbxMarRevChange(Sender: TObject);
begin
  inherited;
  //If (qryTabela.State = dsEdit) Then
  //  fValidaCampos(cbxMarRev, False);
end;

procedure TfrmCadFornecedores.cdsBcoForAfterScroll(DataSet: TDataSet);
begin
  inherited;
  If (Not cdsBcoFor.IsEmpty) And Not (cdsBcoFor.State in dsEditModes) And
    Not blnInsertDadosBancarios Then
  Begin
    edtCodBco.Text  := cdsBcoFor.FieldByName('BCF_CODBCO').AsString;
    edtNomBco.Text  := cdsBcoFor.FieldByName('BCO_NOMBCO').AsString;
    edtNumAge.Text  := cdsBcoFor.FieldByName('BCF_NUMAGE').AsString;
    edtDigAge.Text  := cdsBcoFor.FieldByName('BCF_DIGAGE').AsString;
    edtNumCta.Text  := cdsBcoFor.FieldByName('BCF_NUMCTA').AsString;
    edtDigCta.Text  := cdsBcoFor.FieldByName('BCF_DIGCTA').AsString;
    edtDigVer.Text  := cdsBcoFor.FieldByName('BCF_DIGVER').AsString;
    pHabilitaDigVerificador(Not fEmptyStr(edtDigVer.Text));
    edtCamCen.Text  := cdsBcoFor.FieldByName('BCF_CAMCEN').AsString;
    edtCompDes.Text := cdsBcoFor.FieldByName('BCF_COMPDES').AsString;
    edtNomTit.Text  := cdsBcoFor.FieldByName('BCF_NOMTIT').AsString;
    dbchkCtaPag.Checked := (cdsBcoFor.FieldByName('BCF_CTAPAG').AsString = 'S');
  End;
end;

procedure TfrmCadFornecedores.cdsBcoForAGENCIAGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  If (fEmptyStr(cdsBcoFor.FieldByName('BCF_DIGAGE').AsString)) Then
    Text := cdsBcoFor.FieldByName('BCF_NUMAGE').AsString
  Else
    Text := Concat(cdsBcoFor.FieldByName('BCF_NUMAGE').AsString,
                   '-',
                   cdsBcoFor.FieldByName('BCF_DIGAGE').AsString);
end;

procedure TfrmCadFornecedores.cdsBcoForBANCOGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  If Not (fEmptyStr(cdsBcoFor.FieldByName('BCF_CODBCO').AsString)) Then
    Text := Concat(cdsBcoFor.FieldByName('BCF_CODBCO').AsString,
                   '-',
                   cdsBcoFor.FieldByName('BCO_NOMBCO').AsString)
  Else
    Text := '';
end;

procedure TfrmCadFornecedores.cdsBcoForCalcFields(DataSet: TDataSet);
begin
  inherited;
  cdsBcoFor.FieldByName('BCF_DESPAG').AsString := IIF(cdsBcoFor.FieldByName('BCF_CTAPAG').AsString='S','Sim','Não');
end;

procedure TfrmCadFornecedores.cdsBcoForCONTAGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  If (fEmptyStr(cdsBcoFor.FieldByName('BCF_DIGCTA').AsString)) Then
    Text := cdsBcoFor.FieldByName('BCF_NUMCTA').AsString
  Else
    Text := Concat(cdsBcoFor.FieldByName('BCF_NUMCTA').AsString,
                   '-',
                   cdsBcoFor.FieldByName('BCF_DIGCTA').AsString);
end;

procedure TfrmCadFornecedores.cdsForCtaAfterDelete(DataSet: TDataSet);
  Var
    qryDeleta : TUniQuery;

begin
  inherited;
  If qryTabela.State In [dsEdit, dsInsert] Then
  Begin
    If blnDelCta Then
    Begin
      Try
        qryDeleta := fCriaQuery(Nil);

        fStartTransaction;

        With qryDeleta Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(' DELETE FROM CTAFOR WHERE CTF_CODFOR = :CODFOR AND CTF_CODCTA = :CODCTA ');
          ParamByName('CODFOR').AsString := strCodFor;
          ParamByName('CODCTA').AsString := StrCodCta;
          ExecSQL;
        End;

        fCommit;

        FreeAndNil(qryDeleta);
      Except
        On E : Exception Do
        Begin
          fRollBack;
          pMensagensErro(E.Message,'[TfrmCadFornecedores.cdsForCtaAfterDelete');
          FreeAndNil(qryDeleta);
        End;
      End;
    End
    Else
    Begin
      cdsForCta.CancelUpdates;
    End;
  End
  Else
    cdsForCta.CancelUpdates;
end;

procedure TfrmCadFornecedores.cdsForCtaBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  If qryTabela.State In [dsEdit, dsInsert] Then
  Begin
    If fMensagem('', 'Excluir Plano de Contas?', ['&Sim', '&Não'], 2) = 1 Then
    Begin
      strCodFor := cdsForCtaCTF_CODFOR.AsString;
      strCodCta := cdsForCtaCTF_CODCTA.AsString;
      strCodEmp := cdsForCtaCTF_CODEMP.AsString;

      blnDelCta := True;
    End
    Else
    Begin
      blnDelCta := False;
    End;
  End;
end;

procedure TfrmCadFornecedores.chkUsaFunruralClick(Sender: TObject);
begin
  inherited;
  grbFunrural.Enabled := chkUsaFunrural.Checked;
end;

procedure TfrmCadFornecedores.cmbTipImpSelect(Sender: TObject);
begin
  inherited;
  case cmbTipImp.ItemIndex of
    5:
    Begin
      edtAliq.Text := '0,0000';
      edtAliq.EditFormat := '#,##0.0000';
    End;
  Else
    edtAliq.Text := '0,00';
    edtAliq.EditFormat := '#,##0.00';
  End;
end;

procedure TfrmCadFornecedores.cmbTipNivChange(Sender: TObject);
begin
  inherited;

  Case cmbTipNiv.ItemIndex Of
    0: objNiveis.pMontaSemNivel;
    1: objNiveis.pMontaNivelGiro;
    2: objNiveis.pMontaNivelCriticidade;
    3: objNiveis.pMontaNivelAmbos;
  End;

end;

procedure TfrmCadFornecedores.cmbTipoDoPixChange(Sender: TObject);
begin
  inherited;
  edtCPFCNPJPix.Visible := False;
  edtChavePix.Clear;
  edtChavePix.TipoTexto := ttAlfaNumerico;

  Case cmbTipoDoPix.ItemIndex Of
    1: edtChavePix.MaxLength := 15;
    2: edtChavePix.MaxLength := 60;
    3: edtChavePix.MaxLength := 36;
    0:
    Begin
      edtCPFCNPJPix.Visible := True;
      If edtCPFCNPJPix.Text = '' Then
        edtCPFCNPJPix.Text := '1';

      edtChavePix.MaxLength := 14;
      If edtCPFCNPJPix.Text = '2' Then
        edtChavePix.MaxLength := 11;
    End;
  End;

  If cmbTipoDoPix.ItemIndex in [0] Then
    edtChavePix.TipoTexto := ttInteiro;
end;

procedure TfrmCadFornecedores.btnHelpClick(Sender: TObject);
var strHint: String;
P: TPoint;
begin
  inherited;
  If FHintDisplayed2 Then
  Begin
    cxHintStyleController2.HideHint;
    FHintDisplayed2 := False;
  End
  Else
  Begin
    strHint := 'Somar o valor do IPI ao total dos produtos para depois aplicar a redução da Base da ST.' + sLineBreak +
               'Cálculo: ((((VALOR DO IPI + TOTAL DOS PRODUTOS) * PERCENTUAL DA BASE DA ST) / 100) * IVA)' + sLineBreak + sLineBreak +
               'Aplicar a redução da Base da ST somente sobre o total dos produtos. '+ sLineBreak +
               'Cálculo: ((((TOTAL DOS PRODUTOS * PERCENTUAL DA BASE DA ST) / 100) + VALOR DO IPI) * IVA)';

    // Obtém o ponto inferior esquerdo do rdgBSTXML em coordenadas de tela
    P := rdgBSTXML.ClientToScreen(Point(0, rdgBSTXML.Height));

    // Exibe o hint na posição P.X (esquerda do rádio group) e P.Y (logo abaixo da altura dele)
    cxHintStyleController2.ShowHint(P.X, P.Y, 'Calculo: ', strHint);
    FHintDisplayed2 := True;

  End
end;

procedure TfrmCadFornecedores.btnHelpLimPedComClick(Sender: TObject);
begin
  inherited;
  frxAjudaImpCSV.ShowReport();

end;

procedure TfrmCadFornecedores.btnHelpMouseLeave(Sender: TObject);
begin
  inherited;
  cxHintStyleController2.HideHint;
  FHintDisplayed2 := False;
end;

procedure TfrmCadFornecedores.cxgColCodCtaPropertiesChange(Sender: TObject);
begin
  inherited;

  cdsForCta.Post;

end;

procedure TfrmCadFornecedores.cxvEmpresasMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  AHitTest: TcxCustomGridHitTest;
  AHint: string;
  AColumn: TcxGridColumn;
begin
  AHint := '';
  if not Assigned(Sender) then exit;
  if not (Sender is TcxGridSite) then exit;
  //determine the current mouse position
  AHitTest := TcxGridSite(Sender).ViewInfo.GetHitTest(X, Y);
  //hide displayed hint if mouse is not over a grid header
  if (AHitTest.HitTestCode <> htColumnHeader) then
  begin
    FHintDisplayed := False;
    TcxCustomHintStyleController(cxHintStyleController1).HideHint;
    Exit;
  end;

  if (AHitTest.HitTestCode = htColumnHeader) Then
  with TcxGridColumnHeaderHitTest(AHitTest) do
  begin
    {check the current column over which the mouse is placed}
    AColumn := Column;


    If (AHitTest.HitTestCode = htColumnHeader) Then
      if (TcxGridDBColumn(AColumn).DataBinding.FieldName = 'PRA_DIACOM') Then
        AHint := '  O preenchimento desse campo não é obrigatório, portanto quando ele estiver vazio ou zero, o cálculo da Pasta de Compras será baseado ' + #$A#$D +
                 'no campo "Dias para Compra" da tela de Parâmetros de Compras"';
    if (FColumn <> Column) or (not FHintDisplayed) then
    begin
      //redisplay hint window is mouse has been moved to a new cell
      cxHintStyleController1.HideHint;
      {store the current column}
      FColumn := Column;
      {obtain the current cell display text}
      //AHint := cxGrid1DBTableView2.DataController.DisplayTexts[GridRecord.RecordIndex, Item.Index];
      with cxvEmpresas.Site.ClientToScreen(Point(X, Y)) do
      begin
        If AHint <> '' Then
        Begin
          FHintDisplayed := True;
          {show hint}
          cxHintStyleController1.ShowHint(X, Y, '', AHint);
        End;
      end;
    end;
  end;

end;

procedure TfrmCadFornecedores.cxvEmpresasPRAENTPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  If StrToIntDef(DisplayValue, 0) < 0 Then
  Begin
    Error     := True;
    ErrorText := '';

    pMensagemOk('O prazo de entrega deve ser maior ou igual a zero!');
  End
  Else
    objPraEmp.pValidacaoDias(objPraEmp.FieldByname('PRA_DIACOM').AsInteger, IIF(DisplayValue = '', 0, DisplayValue));
end;

procedure TfrmCadFornecedores.cxvEmpresasDIACOMPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  objPraEmp.pValidacaoDias(DisplayValue, objPraEmp.FieldByname('PRA_DIAENT').AsInteger);
end;


procedure TfrmCadFornecedores.cxvEmpresasVALMINPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  If fStrToFloat(DisplayValue) < 0 Then
  Begin
    Error     := True;
    ErrorText := '';

    pMensagemOk('O valor mínimo do pedido de compra deve ser maior ou igual a zero!');
  End;

end;

procedure TfrmCadFornecedores.cxvLimitePedidosColumn1GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;

  AText := RightStr('0' + AText, 2);
end;

procedure TfrmCadFornecedores.cxvLimitePedidosVALLIMPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
  Var
    fltValor: Double;
begin
  inherited;

  fltValor := fStrToFloat(DisplayValue);

  If fltValor < 0 Then
  Begin
    Error := True;
    ErrorText := '';
    pMensagemOk('Informe um valor maior ou igual a zero!');
  End;
end;

procedure TfrmCadFornecedores.btnImpArqClick(Sender: TObject);
begin
  inherited;

  If objLimite.fSalvaDados(qryTabela.FieldByName('FOR_CODFOR').AsString) Then
    pLimpaTelaLimitePedido;

  objLimite.pImportaArqCSV;
  objLimite.fCarregaDados(qryTabela.FieldByName('FOR_CODFOR').AsString);
end;


procedure TfrmCadFornecedores.cxvMinMaxEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  inherited;

  If Key = '-' Then
    Key := #0;

end;

procedure TfrmCadFornecedores.cxvNivelEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
  Var
    intRecNo: Integer;
begin
  inherited;

  Case Key Of
    VK_RETURN: If cxvNivelPERCON.Focused Then
               Begin
                 If objNiveis.State = dsEdit Then
                   objNiveis.Post;

                 intRecNo := objNiveis.RecNo;
                 cxvNivel.NavigatorButtons.Next.Click;

                 cxvNivelUSANIV.Focused := True;
                 Key := 0;

                 If intRecNo = objNiveis.RecNo Then
                   SelectNext(ActiveControl,True,True);
               End;

  End;
end;

procedure TfrmCadFornecedores.cxvNivelQTDDIAPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

  If StrToIntDef(DisplayValue, -1) < 0 Then
  Begin
    ErrorText := '';
    pMensagemOk('A quantidade de dias de compra deve ser maior ou igual a zero!');
  End;

end;

procedure TfrmCadFornecedores.btnImpExcelClick(Sender: TObject);
  Var
    objExcel   : TExcel;
    dlgOpen    : TOpenDialog;
    intConLin  : Integer;
begin
  inherited;
  If (qryTabela.State In [dsEdit, dsInsert]) Then
  Begin
    try
      dlgOpen     := TOpenDialog.Create(Self);
      dlgOpen.Filter := 'Arquivos do Excel|*.xls;*.xlsx';

      If dlgOpen.Execute Then
      Begin

        objExcel := TExcel.fCriarExcel(Self);
        objExcel.AbrirArquivo(dlgOpen.FileName);

        For intConLin := 1 To objExcel.MaximodeLinhas Do
        Begin
          objForPre.strCodIte := objExcel.Ler_Celula(fGetLetraAlfa(01) + IntToStr(intConLin));
          objForPre.strCodIte := RightStr(IIF(fTamCodIte = 5,'00000','0000000')+ Trim(objForPre.strCodIte), fTamCodIte);
          objForPre.fltValIte := fStrToFloat(objExcel.Ler_Celula(fGetLetraAlfa(02) + IntToStr(intConLin)));
          objForPre.pAdicionaItem;
        End;

      End;

    Finally
      FreeAndNil(objExcel);
      FreeAndNil(dlgOpen);
    End;
  End;
end;
procedure TfrmCadFornecedores.btnIncCtaClick(Sender: TObject);
begin
  inherited;

  pIncluiCentroDeCusto;

end;

procedure TfrmCadFornecedores.btnIncGruClick(Sender: TObject);
begin
  inherited;

  mskCodGru.Clear;
  edtDesGru.Clear;

  pSetFocus(mskCodGru);

end;

procedure TfrmCadFornecedores.btnIncLimPedClick(Sender: TObject);
begin
  inherited;

  If fValidaCampos(mskMesAno, True) And
     fValidaCampos(edtValMes, True) And
     objLimite.fIncluiRegistro(qryTabela.FieldByName('FOR_CODFOR').AsString,
                               qryTabela.FieldByName('FOR_NOMFOR').AsString,
                               StrToIntDef(RightStr(mskMesAno.Text, 4), 0),
                               StrToIntDef(LeftStr(mskMesAno.Text, 2), 0),
                               fStrToFloat(edtValMes.Text)) Then
  Begin
    pLimpaTelaLimitePedido;
    pSetFocus(mskMesAno);
  End;

end;

procedure TfrmCadFornecedores.btnIncluirCCClick(Sender: TObject);
begin
  inherited;
  strStatus := 'INSERT';
  pControlaBotoes;
  pSetFocus(edtCodEmp);
end;

procedure TfrmCadFornecedores.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeNomFor, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);
  qryTabela.FieldByName('FOR_PEDDOL').AsString := 'N';
  qryTabela.FieldByName('FOR_PEDIMP').AsString := 'N';
  qryTabela.FieldByName('FOR_CONCOL').AsString := 'N';
  qryTabela.FieldByName('FOR_ADIDPC').AsString := 'N';
  qryTabela.FieldByName('FOR_FDAICD').AsString := 'N';
  qryTabela.FieldByName('FOR_IDPCID').AsString := 'N';
  qryTabela.FieldByName('FOR_ADPCPC').AsString := 'N';
  qryTabela.FieldByName('FOR_IFDAPC').AsString := 'N';
  qryTabela.FieldByName('FOR_ADICPC').AsString := 'N';
  qryTabela.FieldByName('FOR_ADIDST').AsString := 'N';
  qryTabela.FieldByName('FOR_REDPIS').AsString := 'N';
  qryTabela.FieldByName('FOR_ADIDIC').AsString := 'N';
  qryTabela.FieldByName('FOR_ADPCST').AsString := 'N';
  qryTabela.FieldByName('FOR_ADIDCI').AsString := 'N';
  qryTabela.FieldByName('FOR_ADPCIP').AsString := 'N';
  pHabilitaCodigo(dbeCodigo, dbeCodigo, True);
  qryTabela.FieldByName('FOR_DTACAD').AsDateTime := VS_Date;
  qryTabela.FieldByName('FOR_STATUS').AsString := 'A';
  qryTabela.FieldByName('FOR_PERFCX').AsFloat  := 0;
  qryTabela.FieldByName('FOR_MATREV').AsString := 'R';
  qryTabela.FieldByName('FOR_SIMPAU').AsString := 'P';//Lucro Presumido
  qryTabela.FieldByName('FOR_VLRED2').AsString := 'N';
  qryTabela.FieldByName('FOR_ACOOBJ').AsString := 'N';
  qryTabela.FieldByName('FOR_ANCORA').AsString := 'N';
  qryTabela.FieldByName('FOR_REVIST').AsString := 'N';
  qryTabela.FieldByName('FOR_DIAENT').AsInteger:= 0;
  qryTabela.FieldByName('FOR_ZONFRA').AsString := 'N';
  qryTabela.FieldByName('FOR_MINPED').AsFloat  := 0;
  qryTabela.FieldByName('FOR_REDPIS').AsString := 'N';
  qryTabela.FieldByName('FOR_BSTXML').AsInteger := 0;
  qryTabela.FieldByName('FOR_EMPPAS').AsString := 'N';
  qryTabela.FieldByName('FOR_NOTDES').AsString := 'N';

  qryTabela.FieldByName('FOR_ALQPIS').AsString := fCfgsis('ALPISP');
  qryTabela.FieldByName('FOR_ALQCOF').AsString := fCfgsis('ALCOFP');


  If Not fEmptyStr(fCfgSis('CTAFOR')) Then
    qryTabela.FieldByName('FOR_CONCON').AsString := fCfgSis('CTAFOR');

  objPraEmp.fCarregaDados(qryTabela.FieldByName('FOR_CODFOR').AsString);

  pLimpaEdits;
  pLimpaEditsContatos;
  cdsForCtt.EmptyDataSet;
  dbgContatos.ReadOnly := False;
  pSetFocus(dbeStatus);

  cxvSatelites.OptionsData.Editing := True;
  tbsValorPedido.Enabled := True;

  If fCfgSis('USACTF', varBoolean) Then
    cdsCtaAux.EmptyDataSet;

  If (Not Assigned(lstContatos)) Then
    lstContatos := TObjectList.Create(True);

  lstContatos.Clear;

  If Assigned(objForCtt) And (lstContatos.IndexOf(objForCtt) < 0) Then
    FreeAndNil(objForCtt);

  objForCtt := TForCtt.Create;

  pnlForCta.Enabled := True;
  tbsRetencoes.Enabled := True;

  pLimparDadosBancarios;
  cdsBcoFor.EmptyDataSet;
  FDatasetForPix.EmptyDataSet;

  objRepFor.fCarregaRepresentante('');

  If Assigned(objMinMax) Then
  Begin
    objMinMax.fCarregaDados('');
    cxvMinMax.NavigatorButtons.First.Click;
  End;

  pInicializaVariaveis;

  pCarregaComplementosNeoGrid;
  objNeoGrid.pEdita;
  objRepFor.pEdita;

  fraPatArq.Enabled := True;
  cbxLayNeo.Enabled := True;
  pCarregaTipoFornecedores;
  if Assigned(pCarregaPlanoDeContasPorEmpresa) then
    pCarregaPlanoDeContasPorEmpresa('FORNCO', dbeCodigo.Text, FcdsNCO);

  pPreparaBosh;
  btnConsultaFit.Glyph := Nil;
  ImageSefaz.GetBitmap(0, btnConsultaFit.Glyph);
  btnConsultaFit.Hint := 'Consulta Dados Cadastrais do CNPJ.';
  btnConsultaFit.Enabled := dbeCgcCpf.Text = '1';

  btnCadClientes.Enabled := True;
  btnCadTransportadora.Enabled := True;

  lblClifor.Enabled := blnVinculaCliFor;
  dbeCodCli.Enabled := blnVinculaCliFor;
  dbeCodCli.TabStop := blnVinculaCliFor;

  grbNivel.Enabled     := True;
  grbCalMinMax.Enabled := True;

  cmbTipNiv.ItemIndex := 0;
  cmbTipNivChange(Nil);

  objFiliasAutonomasFornecedor.fCarregaDados('');
  objLimite.fCarregaDados('');

  pnlGruCom1.Enabled := True;
  pnlGruCom2.Enabled := True;

  pCarregaNaturezaRedimentoReinf;
  pCarregaTipoServicoReinf;
end;

procedure TfrmCadFornecedores.btnIncluirDDClick(Sender: TObject);
begin
  inherited;
  pLimparDadosBancarios;
  cdsBcoFor.Insert;
  pnlAcoesDD.Enabled := True;
  pSetFocus(edtCodBco);
  blnInsertDadosBancarios := True;
end;

procedure TfrmCadFornecedores.btnIncluirImpClick(Sender: TObject);
begin
  inherited;
  cdsForRet.Insert();
  grbDadosRetencoes.Enabled := True;
  cmbTipImp.Enabled := True;
  pnlBotoesImp.Enabled := True;
  pSetFocus(cmbTipImp);
  pHabilitarBotoesImp(True);
  strPlCtaImpOld := '';
end;

procedure TfrmCadFornecedores.btnIncluirPixClick(Sender: TObject);
begin
  inherited;
  HabilitarBotoesPix(True);

  FDatasetForPixClone := fCriaClientDatSet(FDatasetForPix);

  FDatasetForPix.Last;
  FDatasetForPix.Append;
  FDatasetForPix.FieldByName('TIPOACAO').AsString := '1';
  FDatasetForPix.FieldByName('PIX_CODFOR').AsString := qryTabela.FieldByName('FOR_CODFOR').AsString;

  cmbTipoDoPix.ItemIndex := -1;
  edtCPFCNPJPix.Visible := False;
  edtChavePix.Clear;

  pSetFocus(cmbTipoDoPix);
end;

procedure TfrmCadFornecedores.btnMarcaTodasAutonomaClick(Sender: TObject);
begin
  inherited;

  objFiliasAutonomasFornecedor.pMarcaTodas(True);
end;

procedure TfrmCadFornecedores.btnObsCmpClick(Sender: TObject);
begin
  inherited;
  pMostrarObsCmp;
end;

procedure TFrmCadFornecedores.pMostrarObsCmp;
begin
  Application.CreateForm(TfrmObservacao, frmObservacao);
  Try
    frmObservacao.Caption := 'Observações para compra';
    frmObservacao.memObs.Lines := dbeObsCmp.Lines;
    frmObservacao.lblMensagem.Caption := 'Observações para compra';
    frmObservacao.btnClipBoard.Visible := True;
    frmObservacao.ClientHeight := 600;
    frmObservacao.ClientWidth := 800;
    frmObservacao.ShowModal;
  Finally
    FreeAndNil(frmObservacao);
  End;
end;

procedure TfrmCadFornecedores.btnOpcoesCertClick(Sender: TObject);
begin
  inherited;
  popMenuCert.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TfrmCadFornecedores.btnAlterarCCClick(Sender: TObject);
begin
  If cdsEmpFor.IsEmpty Then
  Begin
     fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
     Exit;
  End;

  strStatus := 'UPDATE';

  pControlaBotoes;

  edtCodEmp.Text := cdsEmpForCodEmp.AsString;
  edtNomEmp.Text := cdsEmpForNomEmp.AsString;
  edtConcon.Text := cdsEmpForConcon.AsString;

  pSetFocus(edtCodEmp);
end;

procedure TfrmCadFornecedores.btnAlterarClick(Sender: TObject);
var
  strDtaSef: string;
begin
  inherited;
  dbgContatos.ReadOnly := False;
  pgcDados.ActivePageIndex := 0;
  pHabilitaCodigo(dbeCodigo, dbeNomFor, False);
  dbeDtaCad.Enabled := False;
  DBEPEICMS.Enabled  := dbeSimPau.text = 'S';
  lblPeiIcms.Enabled := DBEPEICMS.Enabled;
  cblpeicms.Enabled  := lblPeiIcms.Enabled;

  If (blnAlterou) Then
  Begin
    strCepAnt    := qryTabela.FieldByName('FOR_C_E_P_').AsString;
    strRepCepAnt := objRepFor.FieldByName('REP_C_E_P_').AsString;
    strNomAnt := IfNull(qryTabela.FieldByName('FOR_NOMFOR').AsString, '');
    strCidAnt := IfNull(qryTabela.FieldByName('FOR_CODCID').AsString, '');
    strCgcAnt := IfNull(qryTabela.FieldByName('FOR_C_G_C_').AsString, '');
    strIesAnt := IfNull(qryTabela.FieldByName('FOR_I_E_S_').AsString, '');
    strEndAnt := IfNull(qryTabela.FieldByName('FOR_ENDERE').AsString, '');
    strNumAnt := IfNull(qryTabela.FieldByName('FOR_ENDNUM').AsString, '');
    strComAnt := IfNull(qryTabela.FieldByName('FOR_ENDCOM').AsString, '');
    strBaiAnt := IfNull(qryTabela.FieldByName('FOR_BAIRRO').AsString, '');
    strPlCtaAuxOld := IfNull(qryTabela.FieldByName('FOR_CTATRA').AsString, '');
    strPlCtaCmpOld := IfNull(qryTabela.FieldByName('FOR_CODCTA').AsString, '');
    objNeoGrid.pEdita;
    objRepFor.pEdita;

    fraPatArq.Enabled := True;
    cbxLayNeo.Enabled := True;
    btnConsultaFit.Enabled := dbeCgcCpf.Text = '1';

    If Not blnVinculaCliFor Then
    begin
      lblClifor.Enabled := False;
      dbeCodCli.Enabled := False;
      dbeCodCli.TabStop := False;
    end;
  End;

  cxvSatelites.OptionsData.Editing := True;
  tbsValorPedido.Enabled := True;

  pnlForCta.Enabled := True;
  tbsRetencoes.Enabled := True;
  pnlBotoesImp.Enabled := True;
  pnlAcoesDD.Enabled   := True;
  pnlAcoesPix.Enabled  := True;

  grbNivel.Enabled     := True;
  grbCalMinMax.Enabled := True;

  pnlGruCom1.Enabled := True;
  pnlGruCom2.Enabled := True;

  btnCadClientes.Enabled := True;
  btnCadTransportadora.Enabled := True;

  pCarregaTipoFornecedores;
  pPreparaBosh;

  if btnConsultaFit.Enabled then
  begin
    if fTeveConsultaSefaz('CADFOR', 'FOR_DTASEF', qryTabela.FieldByName('AUTOINCREM').AsString, strDtaSef) then
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
  end;

  fValidaCampos(dbeCgcCpf);
end;

procedure TfrmCadFornecedores.pLimparCertficadoAnterior;
begin
  If Assigned(dxPDFViewer) Then
    dxPDFViewer.Visible := False
  Else
  If Assigned(imgCertificado) Then
    imgCertificado.Visible := False;
end;

procedure TfrmCadFornecedores.btnAlterarDDClick(Sender: TObject);
begin
  inherited;
  If (Not cdsBcoFor.IsEmpty) Then
  Begin
    edtCodBco.Text  := cdsBcoFor.FieldByName('BCF_CODBCO').AsString;
    edtNomBco.Text  := cdsBcoFor.FieldByName('BCO_NOMBCO').AsString;
    edtNumAge.Text  := cdsBcoFor.FieldByName('BCF_NUMAGE').AsString;
    edtDigAge.Text  := cdsBcoFor.FieldByName('BCF_DIGAGE').AsString;
    edtNumCta.Text  := cdsBcoFor.FieldByName('BCF_NUMCTA').AsString;
    edtDigCta.Text  := cdsBcoFor.FieldByName('BCF_DIGCTA').AsString;
    edtDigVer.Text  := cdsBcoFor.FieldByName('BCF_DIGVER').AsString;
    pHabilitaDigVerificador(Not fEmptyStr(edtDigVer.Text));
    edtCamCen.Text  := cdsBcoFor.FieldByName('BCF_CAMCEN').AsString;
    edtCompDes.Text := cdsBcoFor.FieldByName('BCF_COMPDES').AsString;
    edtNomTit.Text  := cdsBcoFor.FieldByName('BCF_NOMTIT').AsString;
    dbchkCtaPag.Checked := (cdsBcoFor.FieldByName('BCF_CTAPAG').AsString = 'S');

    cdsBcoFor.Edit;
    pnlAcoesDD.Enabled := True;
    pSetFocus(edtCodBco);
    blnInsertDadosBancarios := False;
  End
  Else
    fMensagem('ATENÇÃO!', 'Não há registro selecionado para alteração!', ['&OK']);
end;

procedure TfrmCadFornecedores.btnAlterarImpClick(Sender: TObject);
begin
  inherited;

  If (Not cdsForRet.IsEmpty) Then Begin
    cmbTipImp.ItemIndex                := cdsForRet.FieldByName('RET_TIPRET').AsInteger;
    cmbTipImpSelect(Sender);
    edtAliq.Text                       := cdsForRet.FieldByName('RET_ALIQUO').AsString;
    edtCodFor.Text                     := cdsForRet.FieldByName('RET_FORRET').AsString;
    edtDesFor.Text                     := cdsForRet.FieldByName('FOR_NOMFOR').AsString;
    fraPlanoDeContasImp.MskCodCta.Text := fStrZero(cdsForRet.FieldByName('RET_CODCTA').AsString, 7);
    fraPlanoDeContasImp.edtDesCta.Text := cdsForRet.FieldByName('CTA_DESCTA').AsString;
    rdgVencimento.ItemIndex            := cdsForRet.FieldByName('RET_TIPVEN').AsInteger;
    edtVencimento.Text                 := cdsForRet.FieldByName('RET_DIAVEN').AsString;
    With fraCentroCusto Do
    Begin
      edtCodEve.Text := cdsForRet.FieldByName('RET_CODEVE').AsString;
      edtDesEve.Text := cdsForRet.FieldByName('EVE_DESEVE').AsString;
    End;

    edtCodPorRet.Text := cdsForRet.FieldByName('RET_CODPOR').AsString;
    edtNomPorRet.Text := cdsForRet.FieldByName('POR_NOMPOR').AsString;

    cmbTipImp.Enabled := False;

    cdsForRet.Edit();

    pHabilitarBotoesImp(True);

    grbDadosRetencoes.Enabled := True;
    pnlBotoesImp.Enabled := True;
    strPlCtaImpOld := IfNull(cdsForRet.FieldByName('RET_CODCTA').AsString,'');

    pSetFocus(cmbTipImp);
  End Else Begin
    fMensagem('ATENÇÃO!', 'Não há registro de Retenção selecionado para alteração!', ['&OK']);
  End;
end;

procedure TfrmCadFornecedores.btnAlterarPixClick(Sender: TObject);
begin
  If FDatasetForPix.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'Você deve selecionar um registro para utilizar essa opção.', ['&Ok']);
    Exit;
  End;

  FDatasetForPixClone := fCriaClientDatSet(FDatasetForPix);

  FDatasetForPix.Edit;
  If Not FDatasetForPix.FieldByName('AUTOINCREM').AsString.IsEmpty Then
  Begin
    FDatasetForPix.FieldByName('TIPOACAO').AsString := '2';

    FDatasetForPixClone.Filter := 'AUTOINCREM<>''' + FDatasetForPix.FieldByName('AUTOINCREM').AsString + '''';
    FDatasetForPixClone.Filtered := True;
  End;

  inherited;
  HabilitarBotoesPix(True);
  pSetFocus(edtChavePix);
end;

procedure TfrmCadFornecedores.btnAltParClick(Sender: TObject);
var
  frmCadAltPar : TfrmCadAltPar;
begin
  inherited;
  If (qryTabela.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário escolher um Fornecedor!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmCadAltPar, frmCadAltPar);
    frmCadAltPar.strTipoPart := 'F';
    frmCadAltPar.strCodPart  := qryTabela.FieldByName('FOR_CODFOR').AsString;
    frmCadAltPar.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  pFreeAndNil(frmCadAltPar);
end;

procedure TfrmCadFornecedores.dbeCodCidKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, dbeCodCid, edtCidade, edtEstado, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(dbeCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFornecedores.dbeCodCliKeyPress(Sender: TObject; var Key: Char);
Var
  arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, dbeCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(dbeCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFornecedores.dbeCodCndKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCnd : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    If fPesqCondicoesPgto(Self, dbeCodCnd, nil, nil, Key, arrCnd) Then
    Begin
      pCarregaCondicao;
      if fValidaCampos(dbeCodCnd, True) then
        SelectNext(ActiveControl, True, True);
    End;
  End;

end;

procedure TfrmCadFornecedores.dbeCodEveKeyPress(Sender: TObject; var Key: Char);
Var
  arrEvento: TConsultasArray;
begin
  inherited;
  If fPesqEventos(Self, dbeCodEve, edtDesEve, Nil, Key, arrEvento, True, True) Then
  Begin
    If fValidaCampos(dbeCodEve, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFornecedores.dbeCODGEFKeyPress(Sender: TObject; var Key: Char);
Var
  arrGrupo: TConsultasArray;
begin
  inherited;
  If fPesqGrupoEcoFornec(Self, dbeCODGEF, edtDESGEF, Nil, Key, arrGrupo) Then
  Begin
    If fValidaCampos(dbeCODGEF, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFornecedores.dbeCodAtiKeyPress(Sender: TObject;
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
    If fValidaCampos(dbeCodAti, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFornecedores.pLimpaCamposEmpFor;
begin
  edtCodEmp.Clear;
  edtNomEmp.Clear;
  edtConcon.Clear;
end;

procedure TfrmCadFornecedores.pLimpaEdits;
begin
  edtNomOpe.Clear;
  edtCidade.Clear;
  edtEstado.Clear;
  edtAtividade.Clear;
  edtNomTrans.Clear;
  edtNomCli.Clear;
  edtCndDescri.Clear;
end;

function TfrmCadFornecedores.dbeCodCidChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadCid(Key);
  pAtribuiTabelas;
end;

function TfrmCadFornecedores.dbeCodAtiChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadAti(Key);
  pAtribuiTabelas;
end;

procedure TfrmCadFornecedores.dbeCodTipServKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;
  if fPesqReinfTipoDoServico(Self, dbeCodTipServ, edtTipoServico, nil, Key, arrSel) then
  begin
    if fValidaCampos(dbeCodTipServ, True) then
      SelectNext(ActiveControl, True, True);
  end;
end;

function TfrmCadFornecedores.dbeCodTraChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadTra(Key);
  pAtribuiTabelas;
end;

procedure TfrmCadFornecedores.pAtribuiTabelas;
begin
  qryCadAti := fCriaQuery(Self);
  qryCadCid := fCriaQuery(Self);

  qryConCid := qryCadCid;
  qryConCtt := qryCadCid;
  qryConAti := qryCadAti;
end;

procedure TfrmCadFornecedores.btnExcluiLimMesClick(Sender: TObject);
begin
  inherited;

  If objLimite.fExcluiRegistro Then
    pLimpaTelaLimitePedido;

end;

Procedure TfrmCadFornecedores.pLimpaTelaLimitePedido;
Begin
  mskMesAno.Clear;
  edtValMes.Clear;
End;

procedure TfrmCadFornecedores.btnExcluirCCClick(Sender: TObject);
begin
  strStatus := 'DELETANDO';

  If cdsEmpFor.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 1 Then
  Begin
    Try
      fStartTransaction;
      pDeletaRegEmpFor;
      fCommit;

      cdsEmpFor.Delete;
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

procedure TfrmCadFornecedores.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFornecedores.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  objRepFor.fCarregaRepresentante(dbeCodigo.Text);

  If Assigned(objMinMax) Then
  Begin
    objMinMax.fCarregaDados(dbeCodigo.Text);
    cxvMinMax.NavigatorButtons.First.Click;
  End;

  pCarregaOperador;
  pCarregaCidade(qryConCid, edtCidade, edtEstado, dbeCodCid, dbeNumCep, strCepAnt);
  pCarregaCidade(qryConCidRep, edtRepCidade, edtRepEst, dbeRepCodCid, dbeRepNumCep, strRepCepAnt);
  pCarregaAtividade;
  pCarregaGrupoEconomico;
  pCarregaTransportador(False);
  pCarregaTransportador(True);
  pCarregaPortador;
  pCarregaCondicao;
  pCarregaPlanoContabil;
  pCarregarDadosBancarios;
  if Assigned(pCarregaPlanoDeContasPorEmpresa) then
    pCarregaPlanoDeContasPorEmpresa('FORNCO', dbeCodigo.Text, FcdsNCO);

  edtDesCompra.Text := fRetNomeOperador(dbeCompra.Text);
  objPraEmp.fCarregaDados(qryTabela.FieldByName('FOR_CODFOR').AsString);

  If fCfgSis('USACTF', varBoolean) Then
    pCarregaCentroDeCustoCxg('')
  Else
    pCarregaCentroDeCustoDB(fraPlanoDeContasCmp.dbeCodCta, fraPlanoDeContasCmp.edtDesCta);

  pCarregaCentroDeCustoDB(fraPlanoDeContasAux.dbeCodCta, fraPlanoDeContasAux.edtDesCta);

  pCarregaFornecedorFunrural;
  pCarregaEventoDB(dbeCodEve, edtDesEve);
  pCarregaCentroDeCustoDB(fraPlanoDeContasFunrural.dbeCodCta, fraPlanoDeContasFunrural.edtDesCta);

  pCarregaContatos(qryTabela.FieldByName('FOR_CODFOR').AsString);
  pgcDados.ActivePageIndex := 0;

  pCarregaNaturezaRedimentoReinf;
  pCarregaTipoServicoReinf;
end;

procedure TfrmCadFornecedores.btnExcluirDDClick(Sender: TObject);
begin
  inherited;
  blnInsertDadosBancarios := False;
  If (Not cdsBcoFor.IsEmpty) Then
  Begin
    If (fMensagem('CONFIRMAÇÃO!', 'Excluir Dados Bancários?', ['&Sim', '&Não'], 2) = 1) Then
      cdsBcoFor.Delete
  End
  Else
    fMensagem('ATENÇÃO!', 'Não há registro selecionado para exclusão!', ['&OK']);
end;

procedure TfrmCadFornecedores.btnExcluirImpClick(Sender: TObject);
begin
  inherited;

  If (Not cdsForRet.IsEmpty) Then Begin
    If (fMensagem('CONFIRMAÇÃO!', 'Excluir Retenção de Imposto?', ['&Sim', '&Não'], 2) = 1) Then Begin
      cdsForRet.Delete();
    End;

    pHabilitarBotoesImp(False);
  End Else Begin
    fMensagem('ATENÇÃO!', 'Não há registro de Retenção selecionado para exclusão!', ['&OK']);
  End;
end;

procedure TfrmCadFornecedores.btnExcluirPixClick(Sender: TObject);
begin
  If FDatasetForPix.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'Deve selecionar um registro para utilizar essa opção.', ['&Ok']);
    Exit;
  End;

  If ValidaPixUtilizado Then
  Begin
    fMensagem('ATENÇÃO', 'Essa chave não pode ser excluída pois já está sendo utilizada.', ['&Ok']);
    Exit;
  End;

  If (fMensagem('CONFIRMAÇÃO!', 'Deseja excluir a chave Pix selecionada?', ['&Sim', '&Não'], 2) = 2) Then
    Exit;

  If Not FDatasetForPix.FieldByName('AUTOINCREM').AsString.IsEmpty Then
  Begin
    FDatasetForPix.Edit;
    FDatasetForPix.FieldByName('TIPOACAO').AsString := '3';
    FDatasetForPix.Post;
  End
  Else
    FDatasetForPix.Delete;

  FDatasetForPixOnAfterScroll(FDatasetForPix);

  HabilitarBotoesPix(False);

  inherited;
end;

procedure TfrmCadFornecedores.pCarregaContatos(strCodFor: String);
  Var
    intContador: Integer;
begin

  lstContatos := TForCtt.fRetContatos(strCodFor);
  cdsForCtt.EmptyDataSet;

  For intContador := 0 To lstContatos.Count -1 Do
  Begin
    blnAltContato := False;

    objForCtt := TForCtt(lstContatos[intContador]);
    pAdicionaContatoCds(objForCtt);

  End;

end;

procedure TfrmCadFornecedores.pCarregaDescrEmpresa;
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

procedure TfrmCadFornecedores.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryConFor, qryConFor, edtCodFor.Text);
  edtDesFor.Text := qryConFor.FieldByName('FOR_NOMFOR').AsString;
end;

class function TfrmCadFornecedores.fCarregaFornecedorExterno(
  strCodFor: String; frmFornec: TfrmCadFornecedores = nil): String;
begin
  If Assigned(frmFornec) then
    frmCadFornecedores  := frmFornec
  Else
    pCriarFormularios(TfrmCadFornecedores, frmCadFornecedores);

  Try
    frmCadFornecedores.strCodFor := strCodFor;
    frmCadFornecedores.blnCarregamentoExterno := True;
    If Assigned(frmFornec) then
      frmCadFornecedores.Showmodal;
    Result := frmCadFornecedores.dbeCodigo.Text;
  Finally
    If not Assigned(frmFornec) Then
      FreeAndNil(frmCadFornecedores);
  End;
end;

procedure TfrmCadFornecedores.pCarregaFornecedorFunrural;
begin
  pPesquisaCadFor(qryConFor, qryConFor, dbeFunruralFornecedor.Text);
  edtFunruralNomFor.Text := qryConFor.FieldByName('FOR_NOMFOR').AsString;
end;

procedure TfrmCadFornecedores.pCarregaGridEmpFor;
  Var
    qryAux, qryAuxEmp: TUniQuery;
begin
  cdsEmpFor.EmptyDataSet;

  qryAux := fCriaQuery(Nil);
  qryAuxEmp := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add('SELECT * FROM CCFORE WHERE CCF_CODFOR = :CODFOR ORDER BY CCF_CODEMP ');
    qryAux.ParamByName('CODFOR').AsString := dbeCodigo.Text;
    qryAux.Open;

    qryAuxEmp.SQL.Add('SELECT EMP_NOMEMP FROM CADEMP WHERE EMP_CODEMP = :CODEMP ');

    qryAux.First;
    While Not qryAux.Eof Do
    Begin
      qryAuxEmp.Close;
      qryAuxEmp.ParamByName('CODEMP').AsString := qryAux.FieldByName('CCF_CODEMP').AsString;
      qryAuxEmp.Open;

      cdsEmpFor.Append;
      cdsEmpForCodEmp.AsString := qryAux.FieldByName('CCF_CODEMP').AsString;;
      cdsEmpForNomEmp.AsString := qryAuxEmp.FieldByName('EMP_NOMEMP').AsString;;
      cdsEmpForConcon.AsString := qryAux.FieldByName('CCF_CONCON').AsString;;
      cdsEmpForCodigo.AsString := qryAux.FieldByName('CCF_CODFOR').AsString;;
      cdsEmpForAUTOINCREM.AsString := qryAux.FieldByName('AUTOINCREM').AsString;
      cdsEmpFor.Post;

      qryAux.Next;
    End;
  Finally
    qryAux.Free;
    qryAuxEmp.Free;
  End;
end;

procedure TfrmCadFornecedores.pCarregaOperador;
begin
  If Not fEmptyStr(dbeOpeAlt.Text) Then
    edtNomOpe.Text := fRetNomeOperador(dbeOpeAlt.Text)
  Else
    edtNomOpe.Clear;
end;

procedure TfrmCadFornecedores.pCarregarDadosBancarios;
  Var
    qryBcoFor: TUniQuery;

    LForPix: TUniQUery;
begin
  qryBcoFor := fCriaQuery();

  Try
    With qryBcoFor Do
    Begin
      cdsBcoFor.EmptyDataSet;
      SQL.Clear;
      SQL.Text := fGetSQLDadosBancarios;
      ParamByName('CODFOR').AsString := qryTabela.FieldByName('FOR_CODFOR').AsString;
      Open;

      While Not Eof Do
      Begin
        cdsBcoFor.AppendRecord([FieldByName('AUTOINCREM').AsString,
                                FieldByName('BCF_CODFOR').AsString,
                                FieldByName('BCF_CODBCO').AsString,
                                FieldByName('BANCO').AsString,
                                FieldByName('BCF_NUMAGE').AsString,
                                FieldByName('BCF_DIGAGE').AsString,
                                FieldByName('AGENCIA').AsString,
                                FieldByName('BCF_NUMCTA').AsString,
                                FieldByName('BCF_DIGCTA').AsString,
                                FieldByName('CONTA').AsString,
                                FieldByName('BCF_DIGVER').AsString,
                                FieldByName('BCF_CAMCEN').AsString,
                                FieldByName('BCF_COMPDES').AsString,
                                FieldByName('BCO_NOMBCO').AsString,
                                FieldByName('BCF_NOMTIT').AsString,
                                FieldByName('BCF_CTAPAG').AsString]);

        Next;
      End;
    End;

    LForPix := fCriarQuery('SELECT *, "0"  AS TIPOACAO FROM FORPIX WHERE PIX_CODFOR="' + qryTabela.FieldByName('FOR_CODFOR').AsString + '"');
    LForPix.Open;

    FDatasetForPix := fCriaClientDatSet(LForPix);
    FDatasetForPix.Open;
    FDatasetForPix.Filter := 'TIPOACAO<>''3'' ';
    FDatasetForPix.Filtered := True;

    FDatasetForPix.AfterScroll := FDatasetForPixOnAfterScroll;
    FDatasetForPix.First;

    dbgChavesPix.DataSource := fCriaDataSource(FDatasetForPix);

    pnlAcoesDD.Enabled := False;
    pnlAcoesPix.Enabled := False;

    HabilitarBotoesPix(False);
  Finally
    cdsBcoFor.First;
    qryBcoFor.Close;
    FreeAndNil(qryBcoFor);

    If Assigned(LForPix) Then
      FreeAndNil(LForPix);
  End;
end;

procedure TfrmCadFornecedores.pCarregarRetencoes;
  Var
    strSQL: String;
begin
  strSQL := 'SELECT ' +
            '  FORRET.AUTOINCREM, ' +
            '  RET_TIPRET, ' +
            '  RET_CODFOR, ' +
            '  RET_CODEVE, ' +
            '  RET_CODPOR, ' +
            '  RET_CODCTA, ' +
            '  RET_ALIQUO, ' +
            '  RET_DIAVEN, ' +
            '  RET_TIPVEN, ' +
            '  RET_FORRET, ' +
            '  FOR_NOMFOR, ' +
            '  CTA_DESCTA, ' +
            '  EVE_DESEVE, ' +
            '  POR_NOMPOR, ' +
            '  CONCAT(EVE_CODEVE, "-", EVE_DESEVE) AS DESEVE, ' +
            '  CONCAT(POR_CODPOR, "-", POR_NOMPOR) AS NOMPOR, ' +
            '  CONCAT(CTA_CODCTA, "-", CTA_DESCTA) AS DESCTA, ' +
            '  CONCAT(FOR_CODFOR, "-", FOR_NOMFOR) AS DESFOR, ' +
            '  CASE RET_TIPRET ' +
            '    WHEN "0" THEN "Retenção de PIS" ' +
            '    WHEN "1" THEN "Retenção de COFINS" ' +
            '    WHEN "2" THEN "Retenção de CSLL" ' +
            '    WHEN "3" THEN "Retenção de IRRF" ' +
            '    WHEN "4" THEN "Retenção de INSS" ' +
            '    WHEN "5" THEN "Retenção de ISS" ' +
            '    WHEN "6" THEN "Retenção de INSS Patronal" ' +
            '    ELSE "" ' +
            '  END AS DESTIP, ' +
            '  IF(RET_TIPVEN = "0", "Dia Fixo", "Último Dia do Mês") AS DESVEN ' +
            'FROM ' +
            '  FORRET ' +
            '  LEFT JOIN CADEVE ON RET_CODEVE = EVE_CODEVE ' +
            '  LEFT JOIN CADPOR ON RET_CODPOR = POR_CODPOR ' +
            '  LEFT JOIN CADCTA ON RET_CODCTA = CTA_CODCTA ' +
            '  LEFT JOIN CADFOR ON RET_FORRET = FOR_CODFOR ' +
            'WHERE RET_CODFOR = :CODFOR';

  qryForRet.Close();
  qryForRet.SQL.Clear();
  qryForRet.SQL.Text := strSQL;

  qryForRet.ParamByName('CODFOR').AsString := qryTabela.FieldByName('FOR_CODFOR').AsString;

  cdsForRet.Close;
  cdsForRet.SetProvider(dspForRet);

  qryForRet.Open;
  pSetaClient(qryForRet);

  cdsForRet.Open;

  If (Not cdsForRet.isEmpty) Then
    grdImpostosTableView1.ApplyBestFit();

  btnGravarImp.Enabled   := False;
  btnCancelarImp.Enabled := False;
  btnIncluirImp.Enabled  := True;
  btnAlterarImp.Enabled  := True;
  btnExcluirImp.Enabled  := True;
  grbDadosRetencoes.Enabled   := False;
  pnlBotoesImp.Enabled := False;
  pnlAcoesDD.Enabled   := False;

  pnlGruCom1.Enabled := False;
  pnlGruCom2.Enabled := False;

  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
end;

procedure TfrmCadFornecedores.btnGatWppClick(Sender: TObject);
var
  frmCfgWpp: TfrmCfgWpp;
begin
  inherited;
  if qryTabela.IsEmpty then
    Exit;

  if fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) then
  begin
    fMensagem('ATENÇÃO', 'Este contato ainda não está cadastrado, '+
                         'clique no botão gravar para efetuar a gravação dos contatos e, após esse procedimento, '+
                         'será possível definir os gatilhos de whatsapp para cada contato!', ['&OK']);
    Exit;
  end;

  pCriarFormularios(TfrmCfgWpp, frmCfgWpp);
  try
    frmCfgWpp.strEntSai  := 'E';
//    frmCfgWpp.strAutIncContato:= qryTabela.FieldByName('AUTOINCREM').AsString;
    frmCfgWpp.pnlInfo.Caption := 'Gatilhos de '+fRetNomeFormatado(qryTabela.FieldByName('AUTOINCREM').AsString);
    frmCfgWpp.ShowModal;
  finally
    pFreeAndNil(frmCfgWpp);
  end;
end;

procedure TfrmCadFornecedores.btnGravarCCClick(Sender: TObject);
begin
  If fValidaCamposCCFORE(edtCodEmp, False) Then
  Begin
    If strStatus = 'INSERT' Then
    Begin
      If Not fEmptyStr(strNomEmp) Then
        pEnviaGravacao
      Else
        fMensagem('', 'Esta empresa não está cadastrada!', ['&OK']);
    End
    Else If strStatus = 'UPDATE' Then
    Begin
      If Not fEmptyStr(strNomEmp) Then
        pEnviaEdicao
      Else
        fMensagem('', 'Esta empresa não está cadastrada!', ['&OK']);
    End;
  End;

  pControlaBotoes;

  pCarregaGridEmpFor;

  pSetFocus(grdEmpFor);
end;

function TfrmCadFornecedores.fCertificadoGestaoInformado:boolean;
begin
  Result := True;

  If ((dbeObgCtrlGestao.Text= 'S') And (fEmptyStr(qryTabela.FieldByName('FOR_CERB64').AsString))) Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário informar o certificado de gestão!',['&O K']);
    Result := False;
  End;

end;

procedure TfrmCadFornecedores.btnGravarClick(Sender: TObject);
  Var
    intContador: Integer;
    dtsEstado: TDataSetState;
    blnConfirma: Boolean;
    blnAlterouUFDoCadastro: Boolean;
begin

  if Assigned(fVerificarPlanoDeContasPorEmpresa) then
  begin
    if not fVerificarPlanoDeContasPorEmpresa(dbeCodigo.Text, 'FORNCO', dbePlaNco.Text, FcdsNCO) then
    begin
      exit ;
    end;
  end;

  IntAbaSel := pgcDados.ActivePageIndex;
  Try
//     blnUsaVerificaCamposPai := False;

    If (btnGravarImp.Enabled) Then Begin
      fMensagem('', 'Os dados de Retenções estão em edição. Por favor, salve as alterações para gravar o Fornecedor.', ['&Ok']);
      pgcDados.ActivePage := tbsRetencoes;
      pSetFocus(btnGravarImp);
      Exit;
    End;

    blnAlterouUFDoCadastro := (fRetEstadoFornecedor(qryTabela.FieldByName('FOR_CODFOR').AsString) <> edtEstado.Text);
    if (blnAlterouUFDoCadastro) And (fCliForFaturamento('F',dbeCodigo.Text)) Then
    begin
      pMensagemOk('Atenção! Não é permitido alterar o estado pois existe movimentações para este Fornecedor.');
      Exit;
    end;

    If Not fCertificadoGestaoInformado Then
      Exit;

    If Not fValidacoesBotaoGravarPai Then
      Exit;

    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

    If Not objNiveis.fValidaDados Then
      Exit;

    If (fEmptyStr(fraPlanoDeContasCmp.dbeCodCta.Text)) And
       (fraPlanoDeContasCmp.Visible) Then
      fraPlanoDeContasCmp.dbeCodCta.Field.Value := Null;

    If (fEmptyStr(fraPlanoDeContasAux.dbeCodCta.Text)) Then
      fraPlanoDeContasAux.dbeCodCta.Field.Value := Null;

    If dbeSimPau.text <> 'S' Then
      DBEPEICMS.Field.AsString := 'N';

    If (fEmptyStr(dbeCodCnd.Text)) And (dbeCodCnd.Visible) Then
      dbeCodCnd.Field.Value := Null;

    If (fEmptyStr(dbeCodTrans.Text)) And (dbeCodTrans.Visible) Then
     dbeCodTrans.Field.Value := Null;

    qryTabela.FieldByName('FOR_DTAALT').AsDateTime := VS_Date;
    qryTabela.FieldByName('FOR_CODOPE').AsString   := strLoginUsuarioLogado;
    qryTabela.FieldByName('FOR_DESMEM').AsString  := IIF(dbchkDesmembr.Checked , 'S', 'N');

    qryTabela.FieldByName('FOR_TIPFRE').AsString := fTipoFrete(cmbTipFre.Text);
    qryTabela.FieldByName('FOR_TIPFRR').AsString := fTipoFrete(cmbTipFreRedespacho.Text);
    Case cbxMarRev.ItemIndex Of
      0 : qryTabela.FieldByName('FOR_MATREV').AsString := 'C';
      1 : qryTabela.FieldByName('FOR_MATREV').AsString := 'D';
      2 : qryTabela.FieldByName('FOR_MATREV').AsString := 'I';
      3 : qryTabela.FieldByName('FOR_MATREV').AsString := 'R';
      4 : qryTabela.FieldByName('FOR_MATREV').AsString := 'M';
      5 : qryTabela.FieldByName('FOR_MATREV').AsString := 'Y';
    End;

    If cbxLayNeo.ItemIndex >= 0 Then
      objNeoGrid.FieldByName('NEO_LAYNEO').AsString := String(TIPOS_LAYOUT_CORAL[cbxLayNeo.ItemIndex])
    Else
      objNeoGrid.FieldByName('NEO_LAYNEO').Value := Null;

    If not (cbxLayNeo.ItemIndex in [5, 6]) Then
      objNeoGrid.FieldByName('NEO_INIARQ').Value := Null;

    qryTabela.FieldByName('FOR_C_CPRB').AsString := IntToStr(cbxCPRB.ItemIndex);

    dtsEstado := qryTabela.State;

    If fTiraCaracEspeciais(dbePlanco.Field.AsString) = '' Then
      dbePlanco.Field.Clear;

    Try
      inherited;
      if Assigned(pGravarPlanoContasAutomatico) then
        pGravarPlanoContasAutomatico(qryTabela, dbePlaNco, 'FOR_PLANCO', dbeNomFor.Text);
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmCadFornecedores.btnGravarClick]');
      End;
    End;

    If (blnGravou) Then
    Begin
      if Assigned(pGravarPlanoContasAutomaticoParaCadaEmpresa) then
        pGravarPlanoContasAutomaticoParaCadaEmpresa(qryTabela, dbePlaNco, 'FOR_PLANCO', dbeNomFor.Text);

      if Assigned(pSalvaPlanoDeContasPorEmpresa) then
        pSalvaPlanoDeContasPorEmpresa('FORNCO', dbeCodigo.Text, FcdsNCO) ;

      objNiveis.pGravaNivelFornecedor(qryTabela.FieldByName('FOR_CODFOR').AsString);

      If Assigned(objMinMax) Then
        If Not objMinMax.fSalvaDados(qryTabela.FieldByName('FOR_CODFOR').AsString) Then
        Begin
          fRollBack;

          Raise Exception.Create('Erro ao gravar dados para cálculo do estoque mínimo e máximo!');
        End;

      pAtualizaTipAbf;
      pGravaAlteracoesParticipante(dtsEstado, strNomAnt, strCidAnt, strCgcAnt,
        strIesAnt, strEndAnt, strNumAnt, strComAnt, strBaiAnt);

      If fCfgSis('USACTF', varBoolean) Then
        pGravaCentrosDeCusto;

      pLimpaEditsContatos;

      TForCtt.pApagarCadCtt(qryTabela.FieldByName('FOR_CODFOR').AsString);
      For intContador := 0 To lstContatos.Count -1 Do
      Begin
        TForCtt(lstContatos[intContador]).strCodFor := qryTabela.FieldByName('FOR_CODFOR').AsString;
        TForCtt(lstContatos[intContador]).pInsereForCtt;
      End;

      objForPre.strCodFor := dbeCodigo.Text;
      objForPre.pGravarItens;

      blnConfirma := objNeoGrid.fSalvaDados(qryTabela.FieldByName('FOR_CODFOR').AsString,
                                    fraPatArq.edtDirectory.text);

      blnConfirma := blnConfirma And objPraEmp.fSalvaDados(qryTabela.FieldByName('FOR_CODFOR').AsString);

      blnConfirma := blnConfirma And objFiliasAutonomasFornecedor.fSalvaDados(qryTabela.FieldByName('FOR_CODFOR').AsString);

      blnConfirma := blnConfirma And objLimite.fSalvaDados(qryTabela.FieldByName('FOR_CODFOR').AsString);


      If blnConfirma Then
      Begin
        If Not objRepFor.fSalvaRepresentante(qryTabela.FieldByName('FOR_CODFOR').AsString) Then
        Begin
          fRollBack;
          If objFornecedorBosh.State in dsEditModes Then
             objFornecedorBosh.pSalvar(dbeCodigo.Text);

          Raise Exception.Create('Erro ao Gravar Representante');
        End;
      End;

      pGravarDadosRetencoes();
      pGravarDadosBancarios;
      GravarDadosPix;

      If objFornecedorBosh.State in dsEditModes Then
        objFornecedorBosh.pSalvar(dbeCodigo.Text);

      If blnConfirma Then
      Begin
        if blnTemDivergenciaSefaz then
          pSalvaDataConsultaSefaz('CADFOR', 'FOR_DTASEF', qryTabela.FieldByName('AUTOINCREM').AsString, fRetDataServidor);

        fCommit;

        grbNivel.Enabled     := False;
        grbCalMinMax.Enabled := False;

      End Else
      Begin
        fRollBack;
      End;

      dbgContatos.ReadOnly     := True;
      pgcDados.ActivePageIndex := 0;

      fraPatArq.Enabled := False;
      cbxLayNeo.Enabled := False;
      blnUsaVerificaCamposPai := True;


      btnCadClientes.Enabled := False;
      btnCadTransportadora.Enabled := False;
    End Else
    Begin
      fRollBack;
      objFornecedorBosh.pCancelar;
    End;

    strCodForExterno := qryTabela.FieldByName('FOR_CODFOR').AsString;

  Except

    On E: ExceptionAutCom Do
    Begin
      fRollBack;
      pCarregaContatos(qryTabela.FieldByName('FOR_CODFOR').AsString);
      pMensagemOk(E.Message);
      btnAlterar.Click;
      pgcDados.ActivePageIndex := 1;
      Exit;
    End;

    On E: Exception Do
    Begin
      fRollBack;
      pCarregaContatos(qryTabela.FieldByName('FOR_CODFOR').AsString);
      pgcDados.ActivePageIndex := IntAbaSel;
      pMensagensErro(E.Message,'[TfrmCadFornecedores.btnGravarClick]');

      btnAlterar.Click;
      pCarregarDadosBancarios;
      objRepFor.pCancela;
      objRepFor.fCarregaRepresentante(dbeCodigo.Text);
      pgcDados.ActivePageIndex := 0;
      Exit;
    End;
  End;

  blnUsaVerificaCamposPai := True;

  pCarregaOperador;
  pCarregaTipoFornecedores;
  pCarregarDadosBancarios;
  pPreparaBosh;
  btnConsultaFit.Enabled := False;

  cxvSatelites.OptionsData.Editing := False;
  tbsValorPedido.Enabled := False;

  pLimparCertficadoAnterior;
end;

procedure TfrmCadFornecedores.btnGravarDDClick(Sender: TObject);
Var
    blnValido: Boolean;
begin
  inherited;
  blnValido := ValidaCamposDeDadosBancarios;

  If Not blnValido Then
    Exit;

  If (blnInsertDadosBancarios) And
    (cdsBcoFor.Locate('BCF_CODFOR;BCF_CODBCO;BCF_NUMAGE;BCF_DIGAGE;BCF_NUMCTA;BCF_DIGCTA;BCF_DIGVER',
                      VarArrayOf([qryTabela.FieldByName('FOR_CODFOR').AsString,
                                  edtCodBco.Text,
                                  edtNumAge.Text,
                                  edtDigAge.Text,
                                  edtNumCta.Text,
                                  edtDigCta.Text,
                                  edtDigVer.Text]), [])) Then
  Begin
    cdsBcoFor.First;
    fMensagem('ATENÇÃO!', 'Os dados bancários informados já estão cadastrados!', ['&Ok']);
    cdsBcoFor.Insert;
    pSetFocus(edtCodBco);
    Exit;
  End;

  If (blnInsertDadosBancarios) Then
    cdsBcoFor.Insert
  Else
    cdsBcoFor.Edit;

  cdsBcoFor.FieldByName('BCF_CODFOR').AsString := qryTabela.FieldByName('FOR_CODFOR').AsString;
  cdsBcoFor.FieldByName('BCF_CODBCO').AsString := edtCodBco.Text;
  cdsBcoFor.FieldByName('BCF_NUMAGE').AsString := edtNumAge.Text;
  cdsBcoFor.FieldByName('BCF_DIGAGE').AsString := edtDigAge.Text;
  cdsBcoFor.FieldByName('BCF_NUMCTA').AsString := edtNumCta.Text;
  cdsBcoFor.FieldByName('BCF_DIGCTA').AsString := edtDigCta.Text;
  cdsBcoFor.FieldByName('BCF_DIGVER').AsString := edtDigVer.Text;
  cdsBcoFor.FieldByName('BCO_NOMBCO').AsString := edtNomBco.Text;
  cdsBcoFor.FieldByName('BCF_CTAPAG').AsString := IIF(dbchkCtaPag.Checked , 'S', 'N');

  If (Not fEmptyStr(edtCamCen.Text)) Then
    cdsBcoFor.FieldByName('BCF_CAMCEN').AsString  := edtCamCen.Text
  Else
    cdsBcoFor.FieldByName('BCF_CAMCEN').Value := Null;

  If (Not fEmptyStr(edtCompDes.Text)) Then
    cdsBcoFor.FieldByName('BCF_COMPDES').AsString  := edtCompDes.Text
  Else
    cdsBcoFor.FieldByName('BCF_COMPDES').Value := Null;

  If (Not fEmptyStr(edtNomTit.Text)) Then
    cdsBcoFor.FieldByName('BCF_NOMTIT').AsString := edtNomTit.Text
  Else
    cdsBcoFor.FieldByName('BCF_NOMTIT').Value := Null;

  cdsBcoFor.Post;
  pLimparDadosBancarios;
  pSetFocus(btnIncluirDD);
end;

procedure TfrmCadFornecedores.btnGravarImpClick(Sender: TObject);
  Var
    blnInc: Boolean;
begin
  inherited;

  If (Not fVerificaCampos()) Then Exit;

  blnInc  := (cdsForRet.State = dsInsert);

  If (Not fEmptyStr(edtCodFor.Text)) Then Begin
    If (cmbTipImp.ItemIndex = -1) Then Begin
      fMensagem('ATENÇÃO!', 'O Tipo de Imposto para Retenção deve ser informado!', ['&Ok']);
      pgcDados.ActivePage := tbsRetencoes;
      pSetFocus(cmbTipImp);
      Exit;
    End Else If (fStrToFloat(edtAliq.Text) = 0) Then Begin
      fMensagem('ATENÇÃO!', 'A Alíquota para Retenção deve ser informada!', ['&Ok']);
      pgcDados.ActivePage := tbsRetencoes;
      pSetFocus(edtAliq);
      Exit;
    End Else If (fEmptyStr(fraPlanoDeContasImp.edtDesCta.Text)) Then Begin
      fMensagem('ATENÇÃO!', 'O Plano de Contas para Retenção deve ser informado!', ['&Ok']);
      pgcDados.ActivePage := tbsRetencoes;
      pSetFocus(fraPlanoDeContasImp.MskCodCta);
      Exit;
    End Else If (Not fEmptyStr(edtVencimento.Text)) And (StrToInt(edtVencimento.Text) = 0) And
      (rdgVencimento.ItemIndex = 0) Then Begin
      fMensagem('ATENÇÃO!', 'O Dia de Vencimento para Retenção deve ser informado!', ['&Ok']);
      pgcDados.ActivePage := tbsRetencoes;
      pSetFocus(edtVencimento);
      Exit;
    End Else If (blnInc) And (cdsForRet.Locate('RET_CODFOR;RET_FORRET;RET_TIPRET',
                       VarArrayOf([qryTabela.FieldByName('FOR_CODFOR').AsString,
                                   edtCodFor.Text,
                                   IntToStr(cmbTipImp.ItemIndex)]), [])) Then Begin
      fMensagem('ATENÇÃO!', 'O Tipo de Retenção está duplicado para o fornecedor informado!', ['&Ok']);
      pgcDados.ActivePage := tbsRetencoes;
      pSetFocus(cmbTipImp);

      {AO EXECUTAR O LOCATE, O POST OCORRE, RETIRANDO O DATASET DO MODO DE INSERÇÃO}
      cdsForRet.Insert();
      Exit;
    End;
  End;

  If (blnInc) Then
    cdsForRet.Insert()
  Else
    cdsForRet.Edit();

  cdsForRet.FieldByName('RET_TIPRET').AsInteger := cmbTipImp.ItemIndex;
  cdsForRet.FieldByName('RET_ALIQUO').AsString  := FormatFloat('#,####0.0000', fStrToFloat(edtAliq.Text));
  cdsForRet.FieldByName('RET_TIPVEN').AsInteger := rdgVencimento.ItemIndex;

  If (Not fEmptyStr(edtVencimento.Text)) Then
    cdsForRet.FieldByName('RET_DIAVEN').AsString  := edtVencimento.Text
  Else
    cdsForRet.FieldByName('RET_DIAVEN').Value := Null;

  If (Not fEmptyStr(qryTabela.FieldByName('FOR_CODFOR').AsString)) Then
    cdsForRet.FieldByName('RET_CODFOR').AsString  := qryTabela.FieldByName('FOR_CODFOR').AsString
  Else
    cdsForRet.FieldByName('RET_CODFOR').Value := Null;

  If (Not fEmptyStr(fraPlanoDeContasImp.edtDesCta.Text)) Then
    cdsForRet.FieldByName('RET_CODCTA').AsString  := fraPlanoDeContasImp.MskCodCta.Text
  Else
    cdsForRet.FieldByName('RET_CODCTA').Value := Null;

  If (Not fEmptyStr(fraCentroCusto.edtCodEve.Text)) Then
    cdsForRet.FieldByName('RET_CODEVE').AsString  := fraCentroCusto.edtCodEve.Text
  Else
    cdsForRet.FieldByName('RET_CODEVE').Value := Null;

  If (Not fEmptyStr(edtCodFor.Text)) Then
    cdsForRet.FieldByName('RET_FORRET').AsString  := edtCodFor.Text
  Else
    cdsForRet.FieldByName('RET_FORRET').Value := Null;

  If (Not fEmptyStr(edtCodPorRet.Text)) Then
    cdsForRet.FieldByName('RET_CODPOR').AsString  := edtCodPorRet.Text
  Else
    cdsForRet.FieldByName('RET_CODPOR').Value := Null;

  If (Not fEmptyStr(edtCodPorRet.Text)) Then
    cdsForRet.FieldByName('NOMPOR').AsString  := edtCodPorRet.Text + '-' + edtNomPorRet.Text;

  If (Not fEmptyStr(fraCentroCusto.edtCodEve.Text)) Then
    cdsForRet.FieldByName('DESEVE').AsString  := fraCentroCusto.edtCodEve.Text    + '-' + fraCentroCusto.edtDesEve.Text;

  If (Not fEmptyStr(fraPlanoDeContasImp.edtDesCta.Text)) Then
    cdsForRet.FieldByName('DESCTA').AsString  := fraPlanoDeContasImp.MskCodCta.Text + '-' + fraPlanoDeContasImp.edtDesCta.Text;

  If (Not fEmptyStr(edtCodFor.Text)) Then
    cdsForRet.FieldByName('DESFOR').AsString  := edtCodFor.Text    + '-' + edtDesFor.Text;

  If (Not fEmptyStr(cmbTipImp.Text)) Then
    cdsForRet.FieldByName('DESTIP').AsString  := cmbTipImp.Text;

  If (Not fEmptyStr(rdgVencimento.Items[rdgVencimento.ItemIndex])) Then
    cdsForRet.FieldByName('DESVEN').AsString  := rdgVencimento.Items[rdgVencimento.ItemIndex];

  cdsForRet.Post();

  pLimparDadosRetencoes();

  pHabilitarBotoesImp(False);

  grdImpostosTableView1.ApplyBestFit();

  grbDadosRetencoes.Enabled := False;

  pgcDados.ActivePage := tbsRetencoes;
  pSetFocus(btnIncluirImp);
end;

procedure TfrmCadFornecedores.btnGravarPixClick(Sender: TObject);
begin
  If Not ValidaCamposPIX Then
    Exit;

  FDatasetForPix.FieldByName('PIX_TIPCHV').AsString := RetornaTipoChavePix(cmbTipoDoPix.ItemIndex);
  FDatasetForPix.FieldByName('PIX_CHAVE_').AsString := edtChavePix.Text;

  FDatasetForPix.Post;

  inherited;
  HabilitarBotoesPix(False);

  FreeAndNil(FDatasetForPixClone);
end;

procedure TfrmCadFornecedores.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' - Produtos / Preços (Help)', frxHelp);
end;

procedure TfrmCadFornecedores.pGravaAlteracoesParticipante(dtsEstado: TDataSetState;
    strNomAnt, strCidAnt, strCgcAnt, strIesAnt, strEndAnt, strNumAnt, strComAnt,
    strBaiAnt: String);
begin
  If dtsEstado = dsEdit Then
  Begin
    pAlteracaoDadosParticipante(caNome, qryTabela.FieldByName('FOR_CODFOR').AsString, 'F',
      qryTabela.FieldByName('FOR_NOMFOR').AsString, strNomAnt);

    pAlteraCidade(qryTabela.FieldByName('FOR_CODFOR').AsString, 'F',
      qryTabela.FieldByName('FOR_CODCID').AsString, strCidAnt);

    pAlteraCnpjOuCpf(qryTabela.FieldByName('FOR_CODFOR').AsString, 'F',
      qryTabela.FieldByName('FOR_C_G_C_').AsString, strCgcAnt);

    pAlteracaoDadosParticipante(caIES, qryTabela.FieldByName('FOR_CODFOR').AsString, 'F',
      qryTabela.FieldByName('FOR_I_E_S_').AsString, strIesAnt);

    pAlteracaoDadosParticipante(caEndereco, qryTabela.FieldByName('FOR_CODFOR').AsString, 'F',
      qryTabela.FieldByName('FOR_ENDERE').AsString, strEndAnt);

    pAlteracaoDadosParticipante(caNumEndereco, qryTabela.FieldByName('FOR_CODFOR').AsString, 'F',
      qryTabela.FieldByName('FOR_ENDNUM').AsString, strNumAnt);

    pAlteracaoDadosParticipante(caComplEndereco, qryTabela.FieldByName('FOR_CODFOR').AsString, 'F',
      qryTabela.FieldByName('FOR_ENDCOM').AsString, strComAnt);

    pAlteracaoDadosParticipante(caBairro, qryTabela.FieldByName('FOR_CODFOR').AsString, 'F',
      qryTabela.FieldByName('FOR_BAIRRO').AsString, strBaiAnt);
  End;
end;

procedure TfrmCadFornecedores.btnConsultaFitClick(Sender: TObject);
var
  dicValoresAtuais, dicResultado: TDicionario;
begin
  inherited;

  if dbeCgcCpf.Text <> '1' then
    Exit;

  If fEmptyStr(dbeNumCgc.Text) Then
  Begin
    fMensagem('Atenção', 'Informe o CNPJ antes de realizar a consulta', ['&Ok']);
    Exit;
  End;

  dicValoresAtuais := TDicionario.Create;
  dicResultado := TDicionario.Create;
  try
    dicValoresAtuais.Limpar;
    dicValoresAtuais.Adicionar(DESC_RAZAO_SOCIAL,  qryTabela.FieldByName('FOR_NOMFOR').AsString);
    dicValoresAtuais.Adicionar(DESC_NOME_FANTASIA, qryTabela.FieldByName('FOR_NOMFAN').AsString);
    dicValoresAtuais.Adicionar(DESC_INSC_EST,      qryTabela.FieldByName('FOR_I_E_S_').AsString);
    dicValoresAtuais.Adicionar(DESC_ENDERECO,      qryTabela.FieldByName('FOR_ENDERE').AsString);
    dicValoresAtuais.Adicionar(DESC_NUMERO,        qryTabela.FieldByName('FOR_ENDNUM').AsString);
    dicValoresAtuais.Adicionar(DESC_COMPLEMENTO,   qryTabela.FieldByName('FOR_ENDCOM').AsString);
    dicValoresAtuais.Adicionar(DESC_BAIRRO,        qryTabela.FieldByName('FOR_BAIRRO').AsString);
    dicValoresAtuais.Adicionar(DESC_CEP,           qryTabela.FieldByName('FOR_C_E_P_').AsString);
    dicValoresAtuais.Adicionar(DESC_IBGE_CIDADE,   fRetornaCodIBGE(qryTabela.FieldByName('FOR_CODCID').AsString));
    dicValoresAtuais.Adicionar(DESC_CNPJ,          qryTabela.FieldByName('FOR_C_G_C_').AsString);

    objConsultaCadastroFit.pConsulta(dicValoresAtuais,
                                     dicResultado,
                                     dbeNumCgc.Text,
                                     False,
                                     blnTemDivergenciaSefaz,
                                     True,
                                     '');

    if dicResultado.Chaves.IndexOf(DESC_RAZAO_SOCIAL) > -1 then
      qryTabela.FieldByName('FOR_NOMFOR').AsString := dicResultado.Retorna(DESC_RAZAO_SOCIAL);
    if dicResultado.Chaves.IndexOf(DESC_NOME_FANTASIA) > -1 then
      qryTabela.FieldByName('FOR_NOMFAN').AsString := dicResultado.Retorna(DESC_NOME_FANTASIA);
    if dicResultado.Chaves.IndexOf(DESC_ENDERECO) > -1 then
      qryTabela.FieldByName('FOR_ENDERE').AsString := dicResultado.Retorna(DESC_ENDERECO);
    if dicResultado.Chaves.IndexOf(DESC_NUMERO) > -1 then
      qryTabela.FieldByName('FOR_ENDNUM').AsString := dicResultado.Retorna(DESC_NUMERO);
    if dicResultado.Chaves.IndexOf(DESC_COMPLEMENTO) > -1 then
      qryTabela.FieldByName('FOR_ENDCOM').AsString := dicResultado.Retorna(DESC_COMPLEMENTO);
    if dicResultado.Chaves.IndexOf(DESC_BAIRRO) > -1 then
      qryTabela.FieldByName('FOR_BAIRRO').AsString := dicResultado.Retorna(DESC_BAIRRO);
    if dicResultado.Chaves.IndexOf(DESC_CEP) > -1 then
    begin
      qryTabela.FieldByName('FOR_C_E_P_').AsString := fTiraCaracEspeciaisPonto(dicResultado.Retorna(DESC_CEP));
      fValidaCampos(dbeNumCep);
    end;
    if dicResultado.Chaves.IndexOf(DESC_IBGE_CIDADE) > -1 then
    begin
      qryTabela.FieldByName('FOR_CODCID').AsString := fRetornaCodCidIBGE(dicResultado.Retorna(DESC_IBGE_CIDADE), True);
      fValidaCampos(dbeCodCid);
    end;
    if dicResultado.Chaves.IndexOf(DESC_INSC_EST) > -1 then
      qryTabela.FieldByName('FOR_I_E_S_').AsString := dicResultado.Retorna(DESC_INSC_EST);
    if dicResultado.Chaves.IndexOf(DESC_CNPJ) > -1 then
      qryTabela.FieldByName('FOR_C_G_C_').AsString := fTiraCaracEspeciaisPonto(dicResultado.Retorna(DESC_CNPJ));

    if not blnTemDivergenciaSefaz then
      pSalvaDataConsultaSefaz('CADFOR', 'FOR_DTASEF', qryTabela.FieldByName('AUTOINCREM').AsString, fRetDataServidor);
  finally
    FreeAndNil(dicValoresAtuais);
    FreeAndNil(dicResultado);
  end;
end;

procedure TfrmCadFornecedores.btnAbfClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaAcessoSistema('frmCadAbrevFiscal') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso para "Cadastro de Abreviação de ICMS"!', ['&Ok']);
    Exit;
  End;

  pCriarForm(TfrmCadAbreviacaoFiscal);
end;

procedure TfrmCadFornecedores.btnAbrirPastaClienteClick(Sender: TObject);
Var
  SPath: String;
begin
  inherited;

  if dbeCodigo.Field.DisplayText = '' Then
    Exit;

  SPath := fCfgSis('FORPAT');
  if fEmptyStr(SPath) then
    SPath := ExtractFilePath(Application.ExeName)+ 'ANEXOS\';

  frmGravaArquivoPasta                 := TfrmGravaArquivoPasta.Create(Self);
  frmGravaArquivoPasta.strCaminhoPasta := SPath + IIF(RightStr(SPath, 1) <> '\', '\', '') +
                                          dbeCodigo.Field.DisplayText;
  frmGravaArquivoPasta.Caption         := 'Pasta ( Anexos do Fornecedor )';
  frmGravaArquivoPasta.blnConsulta     := not (qryTabela.State in DsEditModes);
  frmGravaArquivoPasta.ShowModal;

end;

procedure TfrmCadFornecedores.btnAddIteClick(Sender: TObject);
begin
  inherited;
  If (qryTabela.State In [dsEdit, dsInsert]) And
     fValidaCampos(edtcodite, True) And
     fValidaCampos(edtPreFor, True) Then
  Begin
    objForPre.pAdicionaItem;
    btnCanIte.Click;
  End;
end;

procedure TfrmCadFornecedores.btnAdicionarCttClick(Sender: TObject);
begin
  inherited;
  If (qryTabela.State In [dsEdit, dsInsert]) Then
  Begin
    {*******************************************}
    {* COLOQUEI AQUI PARA VALIDAR O NOME.      *}
    {* SE OLHAR NO VALIDA, VAI ENTENDER PORQUE *}
    {****************************************MV*}
    Try
      objForCtt.strNomCtt := edtNomCtt.Text;
    Except
      On E: ExceptionAutCom Do
      Begin
        pMensagemOk(E.Message);
        If edtNomCtt.Enabled Then
          pSetFocus(edtNomCtt);
        Exit;
      End;

      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmCadFornecedores.btnAdicionarCttClick]');
        If edtNomCtt.Enabled Then
          pSetFocus(edtNomCtt);
        Exit;
      End;
    End;

    If (fValidaPanel(pnlContatos, True)) Then
    Begin
      pAdicionaContatoCds(objForCtt);
      btnCancelaCtt.Click;
      blnAltContato := False;
    End;
  End;
end;

procedure TfrmCadFornecedores.pAdicionaContatoCds(objContato: TForCtt);
begin
  If (blnAltContato) Then Begin
    cdsForCtt.Edit;
  End Else Begin
    cdsForCtt.Append;
    blnAltContato := False;
  End;

  cdsForCtt.FieldByName('NOMCTT').AsString := objContato.strNomCtt;
  cdsForCtt.FieldByName('ENDCTT').AsString := objContato.strEndCtt;
  cdsForCtt.FieldByName('BAICTT').AsString := objContato.strBaiCtt;
  cdsForCtt.FieldByName('CODCID').AsString := objContato.strCidCtt;
  cdsForCtt.FieldByName('NOMCID').AsString := objContato.strNomCid;
  cdsForCtt.FieldByName('ESTCID').AsString := objContato.strEstado;
  cdsForCtt.FieldByName('TELCTT').AsString := objContato.strTelCtt;
  cdsForCtt.FieldByName('CELCTT').AsString := objContato.strCelCtt;
  cdsForCtt.FieldByName('FAXCTT').AsString := objContato.strFaxCtt;
  cdsForCtt.FieldByName('DEPCTT').AsString := objContato.strDepCtt;
  cdsForCtt.FieldByName('CMPCTT').AsString := objContato.strCmpCtt;
  cdsForCtt.FieldByName('EMACTT').AsString := objContato.strEmaCtt;
  cdsForCtt.Post;

  If cdsForCtt.FindField('TELCTT') <> nil Then
    TStringField(cdsForCtt.FieldByName('TELCTT')).EditMask := fRetMascaraFonePais;

  If cdsForCtt.FindField('CELCTT') <> nil Then
    TStringField(cdsForCtt.FieldByName('CELCTT')).EditMask := fRetMascaraFonePais;

  If cdsForCtt.FindField('FAXCTT') <> nil Then
    TStringField(cdsForCtt.FieldByName('FAXCTT')).EditMask := fRetMascaraFonePais;

  objContato.pAjustaCmpCtt(cdsForCtt);

  If (blnAltContato) Then
    lstContatos.Items[cdsForCtt.RecNo-1] := objContato
  Else If (lstContatos.IndexOf(objContato) < 0) Then
    lstContatos.Add(objContato);
  // Gera novo objeto em branco.
  objForCtt := TForCtt.Create;
end;

procedure TfrmCadFornecedores.pCarregaContatoAlteracao;
begin
  If Assigned(objForCtt)  And (lstContatos.IndexOf(objForCtt) < 0) Then
    FreeAndNil(objForCtt);

  objForCtt := TForCtt(lstContatos[cdsForCtt.RecNo-1]);
  pnlContatos.Enabled := True;
  dbgContatos.ReadOnly:= True;
  pSetFocus(edtNomCtt);
  blnAltContato := True;
end;

procedure TfrmCadFornecedores.btnCancelaCttClick(Sender: TObject);
begin
  inherited;
  If (qryTabela.State In [dsEdit, dsInsert]) Then
  Begin
    If (Not blnAltContato) And (lstContatos.IndexOf(objForCtt) < 0) Then
      FreeAndNil(objForCtt);

    objForCtt := TForCtt.Create;

    pLimpaEditsContatos;
    If edtNomCtt.Enabled Then
      pSetFocus(edtNomCtt);
    blnAltContato := False;
  End;
end;

procedure TfrmCadFornecedores.btnCancelarCCClick(Sender: TObject);
begin
  strStatus := 'CANCELANDO';

  pLimpaCamposEmpFor;

  pControlaBotoes;
end;

procedure TfrmCadFornecedores.btnCancelarDDClick(Sender: TObject);
begin
  inherited;
  cdsBcoFor.Cancel;
  pLimparDadosBancarios;
  blnInsertDadosBancarios := False;
end;

procedure TfrmCadFornecedores.btnCancelarImpClick(Sender: TObject);
begin
  inherited;

  cdsForRet.Cancel();
  pLimparDadosRetencoes();
  grbDadosRetencoes.Enabled := False;
  pHabilitarBotoesImp(False);
end;

procedure TfrmCadFornecedores.btnCancelarPixClick(Sender: TObject);
begin
  FDatasetForPix.Cancel;

  inherited;
  HabilitarBotoesPix(False);

  FreeAndNil(FDatasetForPixClone);

  FDatasetForPixOnAfterScroll(FDatasetForPix);
end;

procedure TfrmCadFornecedores.btnCanIteClick(Sender: TObject);
begin
  inherited;
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtRefere.Clear;
  edtPreFor.Text := '0,00';
  pSetFocus(edtCodIte);
end;

procedure TfrmCadFornecedores.btnDesmarcaTodasAutonomaClick(Sender: TObject);
begin
  inherited;

  objFiliasAutonomasFornecedor.pMarcaTodas(False);
end;

procedure TfrmCadFornecedores.edtCidCttKeyPress(Sender: TObject;
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

procedure TfrmCadFornecedores.dbgContatosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_RETURN) Then
  Begin
    If (Not cdsForCtt.IsEmpty) And (qryTabela.State = dsEdit) Then
    Begin
      pCarregaContatoAlteracao;
    End;
  End
  Else If (Key = VK_DELETE) Then
  Begin
    If (Not cdsForCtt.IsEmpty) And (Not dbgContatos.ReadOnly) Then
    Begin
      If fMensagem('ATENÇÃO','Confirma excluir contato "' +
         cdsForCtt.FieldByName('NOMCTT').AsString + '" ?',['','']) = 1 then
      Begin
        lstContatos.Remove(lstContatos[cdsForCtt.RecNo-1]);
        cdsForCtt.Delete;
        btnCancelaCtt.Click;
      End;
    End
    Else
    Begin
      pnlContatos.Enabled := True;
      dbgContatos.ReadOnly := True;
      pLimpaEditsContatos;
    End;
  End
  Else If (Key = VK_ESCAPE) And (qryTabela.State = dsEdit) Then
  Begin
    pnlContatos.Enabled := True;
    dbgContatos.ReadOnly := True;
    btnCancelaCtt.Click;
    pSetFocus(edtNomCtt);
  End;

end;

procedure TfrmCadFornecedores.dtsBcoForStateChange(Sender: TObject);
begin
  inherited;
  pHabilitarBotoesDD(cdsBcoFor.State in dsEditModes);
  pnlDadosBancarios.Enabled := (cdsBcoFor.State in dsEditModes);
end;

procedure TfrmCadFornecedores.dtsTabelaDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  pUpdateCaption;
end;

procedure TfrmCadFornecedores.dtsTabelaStateChange(Sender: TObject);
begin
  inherited;
  pUpdateCaption;
end;

procedure TfrmCadFornecedores.pEditaRegEmpFor;
  Var
    qryUpdate: TUniQuery;
begin
  qryUpdate := fCriaQuery(Nil);
  Try
    qryUpdate.SQL.Add('UPDATE CCFORE ');
    qryUpdate.SQL.Add('SET');
    qryUpdate.SQL.Add('  CCF_CODEMP = :CODEMP, ');
    qryUpdate.SQL.Add('  CCF_CONCON = :CONCON ');
    qryUpdate.SQL.Add('WHERE AUTOINCREM = :AUTOINCREM ');
    qryUpdate.SQL.Add('  AND CCF_CODFOR = :CODFOR ');

    qryUpdate.ParamByName('CODEMP').AsString := cdsEmpForCodEmp.AsString;
    qryUpdate.ParamByName('CONCON').AsString := cdsEmpForConcon.AsString;
    qryUpdate.ParamByName('AUTOINCREM').AsString := cdsEmpForAUTOINCREM.AsString;
    qryUpdate.ParamByName('CODFOR').AsString := cdsEmpForCodigo.AsString;
    qryUpdate.ExecSQL;
  Finally
    qryUpdate.Free;
  End;
end;

procedure TfrmCadFornecedores.pEhContaComDoisDigitos;
  Var
    strDigConta : String;
begin
  If (Length(edtDigCta.Text) > 1) Then
  Begin
    strDigConta := edtDigCta.Text;
    edtDigCta.Text := Copy(strDigConta,1,1);
    edtDigVer.Text := Copy(strDigConta,2,1);
    pHabilitaDigVerificador(True);
  End
  Else If fEmptyStr(edtDigVer.Text) Then
    pHabilitaDigVerificador(False);
end;

procedure TfrmCadFornecedores.pEnviaEdicao;
begin
  cdsEmpFor.Edit;
  cdsEmpForCodEmp.AsString := edtCodEmp.Text;
  cdsEmpForNomEmp.AsString := edtNomEmp.Text;
  cdsEmpForConcon.AsString := edtConcon.Text;
  cdsEmpFor.Post;

  Try
    fStartTransaction;
    pEditaRegEmpFor;
    fCommit;

    strStatus := 'EDITADO';
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFornecedores.btnGravarCCClick]');
    End;
  End;

  pLimpaCamposEmpFor;
end;

procedure TfrmCadFornecedores.pEnviaGravacao;
begin
  cdsEmpFor.Append;
  cdsEmpForCodigo.AsString := dbeCodigo.Text;
  cdsEmpForCodEmp.AsString := edtCodEmp.Text;
  cdsEmpForNomEmp.AsString := edtNomEmp.Text;
  cdsEmpForConcon.AsString := edtConcon.Text;
  cdsEmpForAUTOINCREM.AsString := fRetAutoIncrem('CCFORE', VS_strCodEmp);
  cdsEmpFor.Post;

  Try
    fStartTransaction;
    pInsereRegEmpFor;
    fCommit;

    strStatus := 'GRAVADO';
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFornecedores.btnGravarCCClick]');
    End;
  End;

  pLimpaCamposEmpFor;
end;

procedure TfrmCadFornecedores.pEscapePressed;
begin
  inherited;
end;

procedure TfrmCadFornecedores.pEscondeTextIniArquivo;
  var
    blnEsconde: boolean;
begin
  Case cbxLayNeo.ItemIndex Of
  {N}5,
  {S}6: blnEsconde := False;
  Else
    blnEsconde := True;
  end;
  DBEINIARQ.Visible :=  Not blnEsconde;
  lblINIARQ.Visible :=  Not blnEsconde;
end;

procedure TfrmCadFornecedores.pgcDadosChange(Sender: TObject);
  Var
    strDireitos: String;
begin
  inherited;
  FHintDisplayed2 := False;
  cxHintStyleController2.HideHint;
  If pgcDados.ActivePage = tbsPreFor Then
    btnCanIte.Click;

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

    {* EXCLUSÃO *}
    If Pos('E', strDireitos) > 0 Then
      btnExcluirCC.Visible := True
    Else
      btnExcluirCC.Visible := False;
  End;

  If Not fVerificaAcessoSistema('ALTCCF', strLoginUsuarioLogado) And (pgcDados.ActivePage = tbsForConconEmp) Then
  Begin
    fMensagem('ATENÇÃO', 'Usuário sem acesso a está aba, favor entrar em contato com o responsável!', ['OK']);
    pgcDados.ActivePage := tbsGeral;
    Exit;
  End;

  If (qryTabela.State in [dsInsert, dsEdit]) And (pgcDados.ActivePage = tbsForConconEmp) Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário não estar em edição para acessar esta aba!', ['OK']);
    pgcDados.ActivePage := tbsGeral;
    Exit;
  End;

  If (fEmptyStr(dbeCodigo.Text)) And (pgcDados.ActivePage = tbsForConconEmp) Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário carregar um fornecedor antes de acessar esta aba!', ['OK']);
    pgcDados.ActivePage := tbsGeral;
  End;

  If (pgcDados.ActivePage <> tbsForConconEmp) And (Pos(strStatus, 'INSERT_UPDATE') > 0) Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário cancelar o processo para mudar de aba!', ['OK']);
    pgcDados.ActivePage := tbsForConconEmp;
    Exit;
  End;

  If (pgcDados.ActivePage <> tbsDadosDeposito) And (cdsBcoFor.State in dsEditModes) Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário cancelar o processo para mudar de aba!', ['OK']);
    pgcDados.ActivePage := tbsDadosDeposito;
    Exit;
  End;

  If (Not fEmptyStr(dbeCodigo.Text)) And (pgcDados.ActivePage = tbsForConconEmp) Then
    pCarregaGridEmpFor;

  If pgcDados.ActivePage = tbsGeral Then
    dbeSuframa.Enabled := (Pos(edtEstado.Text, 'AC_AM_AP_RO_RR_') > 0) And (qryTabela.State In [dsEdit, dsInsert]);
end;

procedure TfrmCadFornecedores.pGravaCentrosDeCusto;
begin
  fraPlanoDeContasPl.MskCodCta.Clear;
  fraPlanoDeContasPl.edtDesCta.Clear;

  With cdsForCta Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin

      If Not fGravaCentrosDeCusto Then
        Exit;

      Next;
    End;

    EnableControls;
  End;

  {Carrega o cdsCtaAux para atualizar os Centro de Custos Gravados}
  pCarregaCentroDeCustoCxg(qryTabela.FieldByName('FOR_CODFOR').AsString);


end;

procedure TfrmCadFornecedores.pGravarDadosBancarios;
  Var
    qryBcoFor: TUniQuery;
    qryExec  : TUniQuery;
    strAutInc: string;
  procedure pApagaDD(strAutInc: string);
  begin
    qryExec.SQL.Clear;
    qryExec.SQL.Text := 'DELETE FROM BCOFOR WHERE AUTOINCREM = :AUTINC';
    qryExec.ParamByName('AUTINC').AsString := strAutInc;
    qryExec.ExecSQL;
  end;

  procedure pInsereDD(strCodFor, strCodBco, strNumAge, strDigAge, strNumCta,
    strDigCta, strDigVer, strCamCen, strCompDes, strNomTit, strCtaPag: string; out strAutInc: string);
  begin
    qryExec.SQL.Clear;
    qryExec.SQL.Add('INSERT INTO BCOFOR ( AUTOINCREM');
    qryExec.SQL.Add('                    ,BCF_CODFOR');
    qryExec.SQL.Add('                    ,BCF_CODBCO');
    qryExec.SQL.Add('                    ,BCF_NUMAGE');
    qryExec.SQL.Add('                    ,BCF_DIGAGE');
    qryExec.SQL.Add('                    ,BCF_NUMCTA');
    qryExec.SQL.Add('                    ,BCF_DIGCTA');
    qryExec.SQL.Add('                    ,BCF_DIGVER');
    If Not fEmptyStr(strCamCen) Then
      qryExec.SQL.Add('                  ,BCF_CAMCEN');
    If Not fEmptyStr(strCompDes) Then
      qryExec.SQL.Add('                  ,BCF_COMPDES');
    If Not fEmptyStr(strNomTit) Then
      qryExec.SQL.Add('                  ,BCF_NOMTIT');
    qryExec.SQL.Add('                    ,BCF_CTAPAG');
    qryExec.SQL.Add(' ) VALUES         ( :AUTINC    ');
    qryExec.SQL.Add('                   ,:CODFOR    ');
    qryExec.SQL.Add('                   ,:CODBCO    ');
    qryExec.SQL.Add('                   ,:NUMAGE    ');
    qryExec.SQL.Add('                   ,:DIGAGE    ');
    qryExec.SQL.Add('                   ,:NUMCTA    ');
    qryExec.SQL.Add('                   ,:DIGCTA    ');
    qryExec.SQL.Add('                   ,:DIGVER    ');
    If Not fEmptyStr(strCamCen) Then
      qryExec.SQL.Add('                 ,:CAMCEN    ');
    If Not fEmptyStr(strCompDes) Then
      qryExec.SQL.Add('                 ,:COMPDES   ');
    If Not fEmptyStr(strNomTit) Then
      qryExec.SQL.Add('                 ,:NOMTIT    ');
    qryExec.SQL.Add('                   ,:CTAPAG    ');
    qryExec.SQL.Add(' )                             ');

    strAutInc := fRetAutoIncrem('BCOFOR', VS_strCodEmp);

    qryExec.ParamByName('AUTINC').AsString := strAutInc;
    qryExec.ParamByName('CODFOR').AsString := strCodFor;
    qryExec.ParamByName('CODBCO').AsString := strCodBco;
    qryExec.ParamByName('NUMAGE').AsString := strNumAge;
    qryExec.ParamByName('DIGAGE').AsString := strDigAge;
    qryExec.ParamByName('NUMCTA').AsString := strNumCta;
    qryExec.ParamByName('DIGCTA').AsString := strDigCta;
    qryExec.ParamByName('DIGVER').AsString := strDigVer;
    qryExec.ParamByName('CTAPAG').AsString := strCtaPag;
    If Not fEmptyStr(strCamCen) Then
      qryExec.ParamByName('CAMCEN').AsString  := strCamCen;
    If Not fEmptyStr(strCompDes) Then
      qryExec.ParamByName('COMPDES').AsString  := strCompDes;
    If Not fEmptyStr(strNomTit) Then
      qryExec.ParamByName('NOMTIT').AsString  := strNomTit;
    qryExec.ExecSQL;
  end;

  procedure pAtualizaDD(strAutInc, strCodBco, strNumAge, strDigAge, strNumCta,
    strDigCta, strDigVer, strCamCen, strCompDes, strNomTit, strCtaPag: string);
  begin
    qryExec.SQL.Clear;
    qryExec.SQL.Add('UPDATE BCOFOR SET ');
    qryExec.SQL.Add(' BCF_CODBCO = :CODBCO ');
    qryExec.SQL.Add(',BCF_NUMAGE = :NUMAGE ');
    qryExec.SQL.Add(',BCF_DIGAGE = :DIGAGE ');
    qryExec.SQL.Add(',BCF_NUMCTA = :NUMCTA ');
    qryExec.SQL.Add(',BCF_DIGCTA = :DIGCTA ');
    qryExec.SQL.Add(',BCF_DIGVER = :DIGVER ');
    qryExec.SQL.Add(',BCF_CAMCEN = ' + IIF(Not fEmptyStr(strCamCen), ':CAMCEN ', 'NULL'));
    qryExec.SQL.Add(',BCF_COMPDES = ' + IIF(Not fEmptyStr(strCompDes), ':COMPDES ', 'NULL'));
    qryExec.SQL.Add(',BCF_NOMTIT = ' + IIF(Not fEmptyStr(strNomTit),  ':NOMTIT  ', 'NULL'));
    qryExec.SQL.Add(',BCF_CTAPAG = :CTAPAG ');
    qryExec.SQL.Add('WHERE AUTOINCREM = :AUTINC');

    qryExec.ParamByName('AUTINC').AsString := strAutInc;
    qryExec.ParamByName('CODBCO').AsString := strCodBco;
    qryExec.ParamByName('NUMAGE').AsString := strNumAge;
    qryExec.ParamByName('DIGAGE').AsString := strDigAge;
    qryExec.ParamByName('NUMCTA').AsString := strNumCta;
    qryExec.ParamByName('DIGCTA').AsString := strDigCta;
    qryExec.ParamByName('DIGVER').AsString := strDigVer;
    qryExec.ParamByName('CTAPAG').AsString := strCtaPag;
    If Not fEmptyStr(strCamCen) Then
      qryExec.ParamByName('CAMCEN').AsString  := strCamCen;
    If Not fEmptyStr(strCompDes) Then
      qryExec.ParamByName('COMPDES').AsString  := strCompDes;
    If Not fEmptyStr(strNomTit) Then
      qryExec.ParamByName('NOMTIT').AsString  := strNomTit;
    qryExec.ExecSQL;
  end;
begin
  qryBcoFor := fCriaQuery();
  qryExec   := fCriaQuery();

  Try
    cdsBcoFor.DisableControls;
    qryBcoFor.SQL.Clear;
    qryBcoFor.SQL.Text := fGetSQLDadosBancarios;
    qryBcoFor.ParamByName('CODFOR').AsString := qryTabela.FieldByName('FOR_CODFOR').AsString;
    qryBcoFor.Open;

    While (Not qryBcoFor.Eof) Do
    Begin
      If (Not cdsBcoFor.Locate('AUTOINCREM', qryBcoFor.FieldByName('AUTOINCREM').AsString, [])) Then
        pApagaDD(qryBcoFor.FieldByName('AUTOINCREM').AsString);

      qryBcoFor.Next;
    End;

    cdsBcoFor.First;
    While (Not cdsBcoFor.Eof) Do
    Begin
      Try
        If (fEmptyStr(cdsBcoFor.FieldByName('AUTOINCREM').AsString)) Then
        Begin
          pInsereDD(cdsBcoFor.FieldByName('BCF_CODFOR').AsString,
                    cdsBcoFor.FieldByName('BCF_CODBCO').AsString,
                    cdsBcoFor.FieldByName('BCF_NUMAGE').AsString,
                    cdsBcoFor.FieldByName('BCF_DIGAGE').AsString,
                    cdsBcoFor.FieldByName('BCF_NUMCTA').AsString,
                    cdsBcoFor.FieldByName('BCF_DIGCTA').AsString,
                    cdsBcoFor.FieldByName('BCF_DIGVER').AsString,
                    cdsBcoFor.FieldByName('BCF_CAMCEN').AsString,
                    cdsBcoFor.FieldByName('BCF_COMPDES').AsString,
                    cdsBcoFor.FieldByName('BCF_NOMTIT').AsString,
                    cdsBcoFor.FieldByName('BCF_CTAPAG').AsString,
                    strAutInc);

          cdsBcoFor.Edit;
          cdsBcoFor.FieldByName('AUTOINCREM').AsString := strAutInc;
          cdsBcoFor.Post;
        End
        Else
        Begin
          If (qryBcoFor.Locate('AUTOINCREM', cdsBcoFor.FieldByName('AUTOINCREM').AsString, [])) Then
            pAtualizaDD(cdsBcoFor.FieldByName('AUTOINCREM').AsString,
                        cdsBcoFor.FieldByName('BCF_CODBCO').AsString,
                        cdsBcoFor.FieldByName('BCF_NUMAGE').AsString,
                        cdsBcoFor.FieldByName('BCF_DIGAGE').AsString,
                        cdsBcoFor.FieldByName('BCF_NUMCTA').AsString,
                        cdsBcoFor.FieldByName('BCF_DIGCTA').AsString,
                        cdsBcoFor.FieldByName('BCF_DIGVER').AsString,
                        cdsBcoFor.FieldByName('BCF_CAMCEN').AsString,
                        cdsBcoFor.FieldByName('BCF_COMPDES').AsString,
                        cdsBcoFor.FieldByName('BCF_NOMTIT').AsString,
                        cdsBcoFor.FieldByName('BCF_CTAPAG').AsString);
        End;

        cdsBcoFor.Next;
      Except
        on E: Exception do
          pMensagensErro(E.Message, '[TfrmCadFornecedores.pGravarDadosBancarios]');
      End;
    End;

    pnlAcoesDD.Enabled := False;
  Finally
    cdsBcoFor.EnableControls;
    FreeAndNil(qryExec);
    FreeAndNil(qryBcoFor);
  End;
end;

procedure TfrmCadFornecedores.pGravarDadosRetencoes;
begin
  Try
    cdsForRet.DisableControls();
    qryForRet.DisableControls();

    qryForRet.First();

    While (Not qryForRet.Eof) Do Begin
      If (Not cdsForRet.Locate('AUTOINCREM', qryForRet.FieldByName('AUTOINCREM').AsString, [])) Then Begin
        qryForRet.Delete();
      End;

      qryForRet.Next();
    End;

    cdsForRet.First();

    While (Not cdsForRet.Eof) Do Begin
      If (fEmptyStr(cdsForRet.FieldByName('AUTOINCREM').AsString)) Then Begin
        qryForRet.Insert();
        qryForRet.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FORRET', VS_strCodEmp);

        cdsForRet.Edit();
        cdsForRet.FieldByName('AUTOINCREM').AsString := qryForRet.FieldByName('AUTOINCREM').AsString;
        cdsForRet.Post();
      End Else Begin
        If (qryForRet.Locate('AUTOINCREM', cdsForRet.FieldByName('AUTOINCREM').AsString, [])) Then Begin
          qryForRet.Edit();
        End Else Begin
          cdsForRet.Next();
          Continue;
        End;
      End;

      qryForRet.FieldByName('RET_TIPRET').AsInteger := cdsForRet.FieldByName('RET_TIPRET').AsInteger;
      qryForRet.FieldByName('RET_ALIQUO').AsString  := cdsForRet.FieldByName('RET_ALIQUO').AsString;
      qryForRet.FieldByName('RET_TIPVEN').AsInteger := cdsForRet.FieldByName('RET_TIPVEN').AsInteger;

      If (Not fEmptyStr(cdsForRet.FieldByName('RET_DIAVEN').AsString)) Then
        qryForRet.FieldByName('RET_DIAVEN').AsString := cdsForRet.FieldByName('RET_DIAVEN').AsString
      Else
        qryForRet.FieldByName('RET_DIAVEN').Value := Null;

      If (Not fEmptyStr(cdsForRet.FieldByName('RET_CODFOR').AsString)) Then
        qryForRet.FieldByName('RET_CODFOR').AsString := cdsForRet.FieldByName('RET_CODFOR').AsString
      Else
        qryForRet.FieldByName('RET_CODFOR').Value := Null;

      If (Not fEmptyStr(cdsForRet.FieldByName('RET_CODCTA').AsString)) Then
        qryForRet.FieldByName('RET_CODCTA').AsString := cdsForRet.FieldByName('RET_CODCTA').AsString
      Else
        qryForRet.FieldByName('RET_CODCTA').Value := Null;

      If (Not fEmptyStr(cdsForRet.FieldByName('RET_CODEVE').AsString)) Then
        qryForRet.FieldByName('RET_CODEVE').AsString := cdsForRet.FieldByName('RET_CODEVE').AsString
      Else
        qryForRet.FieldByName('RET_CODEVE').Value := Null;

      If (Not fEmptyStr(cdsForRet.FieldByName('RET_FORRET').AsString)) Then
        qryForRet.FieldByName('RET_FORRET').AsString := cdsForRet.FieldByName('RET_FORRET').AsString
      Else
        qryForRet.FieldByName('RET_FORRET').Value := Null;
      If (Not fEmptyStr(cdsForRet.FieldByName('RET_CODPOR').AsString)) Then
        qryForRet.FieldByName('RET_CODPOR').AsString := cdsForRet.FieldByName('RET_CODPOR').AsString
      Else
        qryForRet.FieldByName('RET_CODPOR').Value := Null;

      If (Not fEmptyStr(edtCodPorRet.Text)) Then
        cdsForRet.FieldByName('NOMPOR').AsString  := edtCodPorRet.Text + '-' + edtNomPorRet.Text;

      qryForRet.Post();

      cdsForRet.Next();
    End;

    pnlBotoesImp.Enabled := False;
  Finally
    cdsForRet.EnableControls();
    qryForRet.EnableControls();
  End;
end;

procedure TfrmCadFornecedores.pHabilitaDigVerificador(blnHabilita: Boolean);
begin
  edtDigVer.Visible := blnHabilita;
  Label74.Visible := blnHabilita;
  If Not blnHabilita Then
    edtDigVer.Clear;
end;

procedure TfrmCadFornecedores.pHabilitarBotoesDD(blnIncAlt: Boolean);
begin
  btnGravarDD.Enabled   := (blnIncAlt);
  btnCancelarDD.Enabled := (blnIncAlt);
  btnIncluirDD.Enabled  := (Not blnIncAlt);
  btnAlterarDD.Enabled  := (Not blnIncAlt);
  btnExcluirDD.Enabled  := (Not blnIncAlt);
end;

procedure TfrmCadFornecedores.pHabilitarBotoesImp(blnIncAlt: Boolean);
begin
  btnGravarImp.Enabled   := (blnIncAlt);
  btnCancelarImp.Enabled := (blnIncAlt);
  btnIncluirImp.Enabled  := (Not blnIncAlt);
  btnAlterarImp.Enabled  := (Not blnIncAlt);
  btnExcluirImp.Enabled  := (Not blnIncAlt);
end;

procedure TfrmCadFornecedores.pAtualizaCodCliFornecedor(strCodCli: String);
var
  strSQL: String;
  qryTmp: TUniQuery;
begin
  fStartTransaction;
  Try
    qryTmp := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + ' UPDATE CADFOR ';
    strSQL := strSQL + '   SET FOR_CODCLI = :CODCLI ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   FOR_CODFOR = :CODFOR ';

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('CODFOR').AsString := dbeCodigo.Text;
      ExecSQL;
    End;

    FreeAndNil(qryTmp);
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[pAtualizaCodCliFornecedor]');
      FreeAndNil(qryTmp);
    End;
  End;
end;

procedure TfrmCadFornecedores.pAtualizaEditsContato(DataSet: TDataSet);
begin

  If (cdsForCtt.IsEmpty) Then
    Exit;

  If cdsForCtt.FindField('TELCTT') <> nil Then
    TStringField(cdsForCtt.FieldByName('TELCTT')).EditMask := fRetMascaraFonePais;

  If cdsForCtt.FindField('CELCTT') <> nil Then
    TStringField(cdsForCtt.FieldByName('CELCTT')).EditMask := fRetMascaraFonePais;

  If cdsForCtt.FindField('FAXCTT') <> nil Then
    TStringField(cdsForCtt.FieldByName('FAXCTT')).EditMask := fRetMascaraFonePais;

  edtNomCtt.Text    := cdsForCtt.FieldByName('NOMCTT').AsString;
  edtEndCtt.Text    := cdsForCtt.FieldByName('ENDCTT').AsString;
  edtBaiCtt.Text    := cdsForCtt.FieldByName('BAICTT').AsString;
  mskTelCtt.Text    := cdsForCtt.FieldByName('TELCTT').AsString;
  mskCelCtt.Text    := cdsForCtt.FieldByName('CELCTT').AsString;
  mskFaxCtt.Text    := cdsForCtt.FieldByName('FAXCTT').AsString;
  edtDepCtt.Text    := cdsForCtt.FieldByName('DEPCTT').AsString;
  edtCidCtt.Text    := cdsForCtt.FieldByName('CODCID').AsString;
  edtDesCidCtt.Text := cdsForCtt.FieldByName('NOMCID').AsString;
  edtEstadoCtt.Text := cdsForCtt.FieldByName('ESTCID').AsString;
  edtEmaCtt.Text    := cdsForCtt.FieldByName('EMACTT').AsString;
  chkCmpCtt.Checked := cdsForCtt.FieldByName('CMPCTT').AsString = 'S';

  blnAltContato := True;
end;

procedure TfrmCadFornecedores.pAtualizaTipAbf;
begin
  If (qryTabela.Active) And (Not qryTabela.FieldByName('FOR_CODFOR').IsNull) Then
  Begin
    lblAbfDes.Caption := fRetDesTipoAbf('F', qryTabela.FieldByName('FOR_CODFOR').AsString);
    lblAbfTit.Visible := True;
    lblAbfDes.Visible := True;
    btnAbf.Visible    := True;
  End
  Else
  Begin
    lblAbfTit.Visible := False;
    lblAbfDes.Visible := False;
    btnAbf.Visible    := False;
  End;
end;

procedure TfrmCadFornecedores.pBuscaFornecedor(strCodFor: String);
  Var
    chrKey: Char;
    arrFor: TConsultasArray;
    objPnlLegenda: TPanelCxFornecedor;

  function fSetaFornecedorInformado: Boolean;
  begin
    Result := False;
    If Not fEmptyStr(strCodFor) Then
    Begin
      pPesquisaCadFor(qryTabela, qryTabela, strCodFor, False);
      Result := True;
    End;
  end;

begin
  chrKey := '/';

  objPnlLegenda := TPanelCxFornecedor.Create(TfrmPnlDadosFornecedor);
  Try
    If fSetaFornecedorInformado Or
       fPesqFornecedor(conForCompleta, Self, Nil, Nil, qryTabela, chrKey, arrFor, True, objPnlLegenda) Then
    Begin
      objRepFor.fCarregaRepresentante(qryTabela.FieldByName('FOR_CODFOR').AsString);

      If Assigned(objMinMax) Then
      Begin
        objMinMax.fCarregaDados(qryTabela.FieldByName('FOR_CODFOR').AsString);
        cxvMinMax.NavigatorButtons.First.Click;
      End;

      pCarregaContatos(qryTabela.FieldByName('FOR_CODFOR').AsString);
      pCarregaOperador;
      pCarregaCidade(qryConCid, edtCidade, edtEstado, dbeCodCid, dbeNumCep, strCepAnt);
      pCarregaCidade(qryConCidRep, edtRepCidade, edtRepEst, dbeRepCodCid, dbeRepNumCep, strRepCepAnt);
      pCarregaAtividade;
      pCarregaGrupoEconomico;
      pCarregaTransportador(False);
      pCarregaTransportador(True);
      pCarregaPortador;
      pCarregaCondicao;
      pCarregaPlanoContabil;

      edtDesCompra.Text := fRetNomeOperador(dbeCompra.Text);
      objPraEmp.fCarregaDados(qryTabela.FieldByName('FOR_CODFOR').AsString);

      If fCfgSis('USACTF', varBoolean) Then
      Begin
        FreeAndNil(cdsCtaAux);
        pCarregaCentroDeCustoCxg(qryTabela.FieldByName('FOR_CODFOR').AsString);
      End
      Else
        pCarregaCentroDeCustoDB(fraPlanoDeContasCmp.dbeCodCta, fraPlanoDeContasCmp.edtDesCta);

      pCarregaCentroDeCustoDB(fraPlanoDeContasAux.dbeCodCta, fraPlanoDeContasAux.edtDesCta);

      pCarregaFornecedorFunrural;
      pCarregaEventoDB(dbeCodEve, edtDesEve);
      pCarregaCentroDeCustoDB(fraPlanoDeContasFunrural.dbeCodCta, fraPlanoDeContasFunrural.edtDesCta);

      pCarregaComplementosNeoGrid;
      pCarregaTipoFornecedores;
      pCarregarDadosBancarios;
      if Assigned(pCarregaPlanoDeContasPorEmpresa) then
        pCarregaPlanoDeContasPorEmpresa('FORNCO', qryTabela.FieldByName('FOR_CODFOR').AsString, FcdsNCO);

      pCarregaNaturezaRedimentoReinf;
      pCarregaTipoServicoReinf;
    End
    Else
    Begin
      If (Assigned(lstContatos)) Then
        lstContatos.Clear;
      cdsForCtt.EmptyDataSet;
    End;
  Finally
    FreeAndNil(frmPnlDadosFornecedor);
    FreeAndNil(objPnlLegenda);
  End;

  objFiliasAutonomasFornecedor.fCarregaDados(qryTabela.FieldByName('FOR_CODFOR').AsString);
  objLimite.fCarregaDados(qryTabela.FieldByName('FOR_CODFOR').AsString);

  If btnAlterar.Visible And btnAlterar.Enabled Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadFornecedores.pLimpaEditsContatos;
begin
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
  chkCmpCtt.Checked := False;
end;

procedure TfrmCadFornecedores.pLimparDadosBancarios;
begin
  edtCodBco.Clear;
  edtNomBco.Clear;
  edtNumAge.Clear;
  edtDigAge.Clear;
  edtNumCta.Clear;
  edtDigCta.Clear;
  edtDigVer.Clear;
  edtCamCen.Clear;
  edtCompDes.Clear;
  edtNomTit.Clear;
  dbchkCtaPag.Checked := False;

  cmbTipoDoPix.ItemIndex := -1;
  cmbTipoDoPix.OnChange(cmbTipoDoPix);
  edtChavePix.Clear;
end;

procedure TfrmCadFornecedores.pLimparDadosRetencoes;
begin
  cmbTipImp.ItemIndex := -1;
  edtAliq.Text := '0,00';
  edtCodFor.Text := '';
  edtDesFor.Text := '';
  fraPlanoDeContasImp.MskCodCta.Clear();
  fraPlanoDeContasImp.edtDesCta.Text := '';
  fraCentroCusto.edtCodEve.Text := '';
  fraCentroCusto.edtDesEve.Text := '';
  edtCodPorRet.Clear;
  edtNomPorRet.Clear;
  rdgVencimento.ItemIndex := 1;
  edtVencimento.Text := '';
  edtVencimento.Enabled := False;
end;

procedure TfrmCadFornecedores.pPesquisaFornecedoresCRM;
begin
  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Add('SELECT SQL_NO_CACHE         ');
  qryTabela.SQL.Add('          *                 ');
  qryTabela.SQL.Add('  FROM CADFOR               ');
  qryTabela.SQL.Add(' WHERE FOR_CODFOR = :CODFOR ');
  qryTabela.ParamByName('CODFOR').AsString := strForneCRM;
  qryTabela.Open;
end;

procedure TfrmCadFornecedores.pProcuraCampoContatoCRM;
var
  Key : Word;
begin
  Key := VK_RETURN;
  pgcDados.ActivePage := tbsContatos;
  cdsForCtt.Locate(strCampoCRM,strDesCamCRM,[]);
  dbgContatosKeyDown(Self,Key,[]);
end;

procedure TfrmCadFornecedores.pProcuraCampoFornecedorCRM;
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

procedure TfrmCadFornecedores.pSetaParametrosCRM(strNomCampoCRM, strCodForCRM,
  strNomRegraCRM: String; strDesCampoCRM: String = '');
begin
  blnUtilizarCrm := True;
  strForneCRM    := strCodForCRM;
  strCampoCRM    := strNomCampoCRM;
  strRegraCRM    := strNomRegraCRM;
  strDesCamCRM   := strDesCampoCRM
end;

procedure TfrmCadFornecedores.pUpdateCaption;
begin
  Self.Caption := 'Cadastro de Fornecedores' + IIF(not fEmptyStr(dbeCodigo.Text), ' - ' + dbeCodigo.Text, '' ) +
                                               IIF(not fEmptyStr(dbeNomFor.Text), ' - ' + dbeNomFor.Text, '' ) ;
end;

procedure TfrmCadFornecedores.pValidaTamCampo;
begin
  If edtCodBco.Text = '001' Then
  Begin
    edtNumAge.TamCampo  := 4;
    edtNumCta.TamCampo  := 8;
    edtNumAge.MaxLength := 4;
    edtNumCta.MaxLength := 8;
  End
  Else If edtCodBco.Text = '104' Then
  Begin
    edtNumAge.TamCampo  := 4;
    edtNumCta.TamCampo  := 9;
    edtNumAge.MaxLength := 4;
    edtNumCta.MaxLength := 9;
  End
  Else If edtCodBco.Text = '341' Then
  Begin
    edtNumAge.TamCampo  := 4;
    edtNumCta.TamCampo  := 5;
    edtNumAge.MaxLength := 4;
    edtNumCta.MaxLength := 5;
  End
  Else If edtCodBco.Text = '033' Then
  Begin
    edtNumAge.TamCampo  := 4;
    edtNumCta.TamCampo  := 10;
    edtNumAge.MaxLength := 4;
    edtNumCta.MaxLength := 10;
  End
  Else If edtCodBco.Text = '237' Then
  Begin
    edtNumAge.TamCampo  := 5;
    edtNumCta.TamCampo  := 7;
    edtNumAge.MaxLength := 5;
    edtNumCta.MaxLength := 7;
  End
  Else If edtCodBco.Text = '422' Then
  Begin
    edtNumAge.TamCampo  := 5;
    edtNumCta.TamCampo  := 9;
    edtNumAge.MaxLength := 5;
    edtNumCta.MaxLength := 9;
  End
  Else If edtCodBco.Text = '756' Then
  Begin
    edtNumAge.TamCampo  := 4;
    edtNumCta.TamCampo  := 8;
    edtNumAge.MaxLength := 4;
    edtNumCta.MaxLength := 8;
  End
  Else If edtCodBco.Text = '021' Then
  Begin
    edtNumAge.TamCampo  := 5;
    edtNumCta.TamCampo  := 11;
    edtNumAge.MaxLength := 5;
    edtNumCta.MaxLength := 11;
  End
  Else
  Begin
    edtNumAge.TamCampo  := 5;
    edtNumCta.TamCampo  := 12;
    edtNumAge.MaxLength := 5;
    edtNumCta.MaxLength := 12;
    edtNumAge.CompZeros := False;
    edtNumCta.CompZeros := False;
  End;
end;

procedure TfrmCadFornecedores.rdgVencimentoClick(Sender: TObject);
begin
  inherited;

  edtVencimento.Enabled := (rdgVencimento.ItemIndex = 0);

  If (Not edtVencimento.Enabled) Then
    edtVencimento.Text := '';
end;

procedure TfrmCadFornecedores.rdgVencimentoExit(Sender: TObject);
begin
  inherited;

  If (rdgVencimento.ItemIndex = 1) Then
    pSetFocus(btnGravarImp);
end;

function TfrmCadFornecedores.RetornaTipoChavePix(AIndiceComboBox: Integer): String;
begin
  Result := 'CNPJ-CPF';
  Case AIndiceComboBox Of
    1: Result := 'CELULAR';
    2: Result := 'EMAIL';
    3: Result := 'ALEATORIA';
  End;
end;



function TfrmCadFornecedores.ValidaCamposDeDadosBancarios: Boolean;
begin
  Result := True;

  If Not fValidaCampos(edtCodBco) Then
    Exit(False);

  If Not fValidaCampos(edtNumAge) Then
    Exit(False);

  If Not fValidaCampos(edtNumCta) Then
    Exit(False);

  If Not fValidaCampos(edtCompDes) Then
    Exit(False);
end;

function TfrmCadFornecedores.ValidaCamposPix: Boolean;
begin
  Result := True;

  If Not fValidaCampos(cmbTipoDoPix) Then
    Exit(False);

  If Not fValidaCampos(edtCPFCNPJPix) Then
    Exit(False);

  If Not fValidaCampos(edtChavePix) Then
    Exit(False);

  If FDatasetForPixClone.Locate('PIX_TIPCHV;PIX_CHAVE_', VarArrayOf([RetornaTipoChavePix(cmbTipoDoPix.ItemIndex), edtChavePix.Text]), []) Then
  Begin
    fMensagem('ATENÇÃO', 'Essa chave Pix já está cadastrada para esse fornecedor!', ['&Ok']);
    pSetFocus(edtChavePix);
    Exit(False);
  End;
end;

function TfrmCadFornecedores.ValidaPixUtilizado: Boolean;
  Var
    LConsulta: TUniQuery;
begin
  If FDatasetForPix.FieldByName('AUTOINCREM').AsString.IsEmpty Then
    Exit(False);

  LConsulta := fCriarQuery('SELECT CTP_FORPIX FROM CADPAG WHERE CTP_FORPIX="' + FDatasetForPix.FieldByName('AUTOINCREM').AsString + '" LIMIT 1');
  LConsulta.Open;

  Result := Not LConsulta.IsEmpty;

  FreeAndNil(LConsulta);
end;

procedure TfrmCadFornecedores.dbeCodTransKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTransp: TConsultasArray;
begin
  inherited;
  {************************************}
  {* NOVA CONSULTA DE TRANSPORTADORAS *}
  {*********************************RV*}
  If fPesqTransportadora(conTraSimples, Self, dbeCodTrans, edtNomTrans, Nil, Key, arrTransp) Then
  Begin
    If fValidaCampos(dbeCodTrans, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFornecedores.dbeCompraKeyPress(Sender: TObject; var Key: Char);
  Var
    arrOperador: TConsultasArray;
begin
  inherited;

  if fPesqOperador(Self,
                   dbeCompra,
                   edtDesCompra,
                   Nil,
                   Key,
                   arrOperador,
                   False, {blnConSim}
                   False, // blnAtivos: Boolean = False;                   {* Somente Operadores Ativos                   *}
                   False, // blnGerentes: Boolean = False;                 {* Somente Operadores Gerentes                 *}
                   False, // blnMecanicos: Boolean = False;                {* Somente Operadores Mecânicos                *}
                   False, // blnVenRepre: Boolean = False;                 {* Somente Vendedor Interno/Representante Externo *}
                   True) Then //blnCompradores
  Begin
    If fValidaCampos(dbeCompra, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadFornecedores.dbeFunruralFornecedorKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrFornec: TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, dbeFunruralFornecedor, Nil, Nil, Key, arrFornec) Then
    If fValidaCampos(dbeFunruralFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadFornecedores.dbeCodTransRedesKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTransp: TConsultasArray;
begin
  inherited;
  If fPesqTransportadora(conTraSimples, Self, dbeCodTransRedes, edtNomTransRedes, Nil, Key, arrTransp) Then
  Begin
    If fValidaCampos(dbeCodTransRedes, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmCadFornecedores.fEmpresaJaDesmembr(strCodEmp: String): Boolean;
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
    strSQL := strSQL + '   CCFORE                    ';
    strSQL := strSQL + ' WHERE                       ';
    strSQL := strSQL + '   CCF_CODEMP = :CODEMP  AND ';
    strSQL := strSQL + '   CCF_CODFOR = :CODFOR      ';

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODFOR').AsString := dbeCodigo.Text;
      Open;
    End;

    Result := qryAux.FieldByName('CONT').AsInteger > 0;
  Finally
    qryAux.Free;
  End;
end;

function TfrmCadFornecedores.fExisteConContabil: String;
  Var
    qryGenFor: TUniQuery;
begin
  Try

    If fEmptyStr(dbeConCon.Text) Then
    Begin
      Result := EmptyStr;
      Exit;
    End;

    qryGenFor := fCriaQuery;

    With qryGenFor Do
    Begin
      SQL.Add('SELECT');
      SQL.Add('  CONCAT(FOR_CODFOR, "-", FOR_NOMFOR) FORNECEDOR');
      SQL.Add('FROM');
      SQL.Add('  CADFOR');
      SQL.Add('WHERE');
      SQL.Add('  FOR_CONCON  = :CONCON AND');
      SQL.Add('  FOR_CODFOR <> :CODFOR    ');
      ParamByName('CONCON').Value := dbeConCon.Text;
      ParamByName('CODFOR').Value := dbeCodigo.Text;
      Open;

      Result := FieldByName('FORNECEDOR').AsString;

    End;

  Finally
    FreeAndNil(qryGenFor);
  End;
end;

function TfrmCadFornecedores.fGetSQLDadosBancarios: String;
begin
  Result := 'SELECT ' +
            '  F.AUTOINCREM,  ' +
            '  F.BCF_CODFOR,  ' +
            '  F.BCF_CODBCO,  ' +
            '  "" AS BANCO,   ' +
            '  F.BCF_NUMAGE,  ' +
            '  F.BCF_DIGAGE,  ' +
            '  "" AS AGENCIA, ' +
            '  F.BCF_NUMCTA,  ' +
            '  F.BCF_DIGCTA,  ' +
            '  "" AS CONTA,   ' +
            '  F.BCF_DIGVER,  ' +
            '  F.BCF_CAMCEN,  ' +
            '  F.BCF_COMPDES, ' +
            '  B.BCO_NOMBCO,  ' +
            '  F.BCF_NOMTIT,  ' +
            '  F.BCF_CTAPAG   ' +
            'FROM ' +
            '  BCOFOR F ' +
            '  LEFT JOIN CADBCO B ON B.BCO_CODBCO = F.BCF_CODBCO ' +
            'WHERE F.BCF_CODFOR = :CODFOR ' +
            'ORDER BY F.AUTOINCREM DESC ';
end;

function TfrmCadFornecedores.fGravaCentrosDeCusto: Boolean;
  Var
    qryCtaFor: TUniQuery;

begin

  Result := True;

  If Not cdsCtaAux.Locate('CTF_CODFOR;CTF_CODCTA;CTF_CODEMP', VarArrayOf([cdsForCtaCTF_CODFOR.AsString, cdsForCtaCTF_CODCTA.AsString, cdsForCtaCTF_CODEMP.AsString]), []) Then
  Begin
    Try
      qryCtaFor := fCriaQuery;

      fStartTransaction;

      With qryCtaFor, SQL Do
      Begin
        Close;
        Clear;
        Add(' INSERT INTO CTAFOR( ');
        Add(' CTF_CODFOR, ');
        Add(' CTF_CODCTA, ');
        Add(' CTF_CODEMP, ');
        Add(' AUTOINCREM) ');
        Add(' VALUES(  ');
        Add(' :CODFOR, ');
        Add(' :CODCTA, ');
        Add(' :CODEMP, ');
        Add(' :AUTINC) ');
        ParamByName('CODFOR').AsString := qryTabela.FieldByName('FOR_CODFOR').AsString;
        ParamByName('CODCTA').AsString := cdsForCtaCTF_CODCTA.AsString;
        ParamByName('CODEMP').AsString := cdsForCtaCTF_CODEMP.AsString;
        ParamByName('AUTINC').AsString := fRetAutoIncrem('CTAFOR', VS_strCodEmp);
        ExecSQL;
      End;

      fCommit;

    Except
      On E: Exception Do
      Begin

        fRollBack;
        pMensagensErro(E.Message, '[TfrmCadFornecedores.fGravaCentrosDeCusto]');
        Result := False;

      End;

    End;

  End;

end;

procedure TfrmCadFornecedores.dbeCgcCpfExit(Sender: TObject);
begin
  inherited;
  If (dbeCgcCpf.Text = '1') Then
    qryTabela.FieldByName('FOR_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
  Else
    qryTabela.FieldByName('FOR_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_P_F_);
  btnConsultaFit.Enabled := (dbeCgcCpf.Text = '1') and ((qryTabela.State = dsEdit) Or (qryTabela.State = dsInsert));
end;

procedure TfrmCadFornecedores.dbeCodNatRendKeyPress(Sender: TObject;
  var Key: Char);
  Var
  arrSel: TConsultasArray;
begin
  inherited;
  if fPesqReinfNaturezaDoRendimento(Self, dbeCodNatRend, edtNatRend, nil, Key, arrSel) then
  begin
    if fValidaCampos(dbeCodNatRend, True) then
      SelectNext(ActiveControl, True, True);
  end
end;

procedure TfrmCadFornecedores.dbeCodPorKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    if fPesqPortador(conSimples, Self, dbeCodPor, edtNomPor, nil, Key, arrSel) then
    Begin
      If fValidaCampos(dbeCodPor, False) Then
        Self.SelectNext(ActiveControl, True, True);
    End;

  End;
end;

procedure TfrmCadFornecedores.pCarregaCentroDeCusto(mksCodCta: TMaskEdit; edtDesCta: TEditFocus);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, IfThen(fEmptyStr(fTiraCaracEspeciais(mksCodCta.Text)), '-1', fTiraCaracEspeciais(mksCodCta.Text)));
  edtDesCta.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;
end;

procedure TfrmCadFornecedores.pCarregaCentroDeCustoCxg(strCodFor: String);
begin
  fraPlanoDeContasPl.MskCodCta.Clear;
  fraPlanoDeContasPl.edtDesCta.Clear;

  With qryForCta, SQL Do
  Begin
    Close;

    Clear;
    Add('SELECT');
    Add('  F.AUTOINCREM, ');
    Add('  F.CTF_CODCTA, ');
    Add('  F.CTF_CODFOR, ');
    Add('  F.CTF_CODEMP, ');
    Add('  C.CTA_DESCTA  ');
    Add('FROM');
    Add('  CTAFOR F');
    Add('  LEFT JOIN CADCTA C ON C.CTA_CODCTA = F.CTF_CODCTA ');
    Add('WHERE ');
    Add('  F.CTF_CODFOR = :CODFOR ');

    ParamByName('CODFOR').AsString := strCodFor;

    cdsForCta.Close;
    cdsForCta.SetProvider(dspForCta);

    Open;
    pSetaClient(qryForCta);

    cdsForCta.Open;
  End;

  If Not Assigned(cdsCtaAux) Then
    cdsCtaAux := TUniClientDataSet.Create(Nil);

  cdsCtaAux.Data := cdsForCta.Data;

  pnlForCta.Enabled := True;
end;

procedure TfrmCadFornecedores.pCarregaCentroDeCustoDB(dbeCodCta: TDBEditFocus;
  edtDesCta: TEditFocus);
begin

  pPesquisaCadCta(qryCadCta, qryCadCta, IfThen(fEmptyStr(dbeCodCta.Text), '-1', dbeCodCta.Text));
  edtDesCta.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;

end;

procedure TfrmCadFornecedores.pCarregaEventoDB(dbeCodEve: TDBEditFocus;
  edtDesEve: TEditFocus);
begin
  edtDesEve.Text := fRetNomEvento(dbeCodEve);
end;

procedure TfrmCadFornecedores.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  qryTabela.AfterScroll := Nil;
  cdsForCtt.AfterScroll := Nil;
  If (Action <> caNone) Then
  Begin
    FreeAndNil(qryCadAti);
    FreeAndNil(qryCadCid);
    FreeAndNil(objFornecedorBosh);

    FreeAndNil(FDatasetForPix);
  End;
  If fCfgSis('USACTF', varBoolean) Then
    FreeAndNil(cdsCtaAux);
end;

procedure TfrmCadFornecedores.edtCidCttKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Not fEmptyStr(fChamaCadCid(Key))) Then
    pAtribuiTabelas;
end;

procedure TfrmCadFornecedores.edtCodBcoExit(Sender: TObject);
begin
  inherited;
  pValidaTamCampo;
end;

procedure TfrmCadFornecedores.edtCodBcoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrBancos: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE BANCOS     *}
  {****************************RV*}
  If fPesqBanco(Self, edtCodBco, edtNomBco, Nil, Key, arrBancos) Then
  Begin
    if fValidaCampos(edtCodBco, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFornecedores.edtCodEmpExit(Sender: TObject);
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

procedure TfrmCadFornecedores.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmpresa : TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpresa) Then
    Begin
      If fValidaCamposCCFORE(edtCodEmp, False) Then
        pSetFocus(edtConCon);
    End;
  End;
end;

procedure TfrmCadFornecedores.edtCodForKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFor, Nil, Nil, Key, arrFornec) Then
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadFornecedores.edtCodIteKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;
  if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
  Begin
    If fValidaCampos(edtCodIte, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFornecedores.edtCodPorRetKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    if fPesqPortador(conSimples, Self, edtCodPorRet, edtNomPorRet, nil , Key, arrSel) then
    Begin
      If fValidaCampos(edtCodPorRet, False) Then
        Self.SelectNext(ActiveControl, True, True);
    End;

  End;
end;

procedure TfrmCadFornecedores.edtCPFCNPJPixEnter(Sender: TObject);
begin
  inherited;
  FTipoDocumentoAnterior := edtCPFCNPJPix.Text;
end;

procedure TfrmCadFornecedores.edtCPFCNPJPixExit(Sender: TObject);
begin
  inherited;
  If FTipoDocumentoAnterior <> edtCPFCNPJPix.Text Then
    cmbTipoDoPix.OnChange(cmbTipoDoPix);
end;

procedure TfrmCadFornecedores.edtVencimentoExit(Sender: TObject);
begin
  inherited;
  pSetFocus(btnGravarImp);
end;

procedure TfrmCadFornecedores.edtCidCttEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'INSERT para fazer um novo cadastro';
end;

procedure TfrmCadFornecedores.edtCidCttExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmCadFornecedores.dbgBcoForDblClick(Sender: TObject);
begin
  inherited;
  If(qryTabela.State in dsEditModes) Then
    btnAlterarDD.Click();
end;

procedure TfrmCadFornecedores.dbgBcoForKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) And
    (btnAlterarDD.Enabled) And
    (qryTabela.State in dsEditModes) Then
    btnAlterarDD.Click();

  If (Key = VK_ESCAPE) And
    (btnCancelarDD.Enabled) And
    (qryTabela.State in dsEditModes) Then
    btnCancelarDD.Click();

  If (Key = VK_DELETE) And
    (btnExcluirDD.Enabled) And
    (qryTabela.State in dsEditModes) Then
    btnExcluirDD.Click();
end;

procedure TfrmCadFornecedores.dbgChavesPixDblClick(Sender: TObject);
begin
  inherited;
  If(qryTabela.State in dsEditModes) Then
    btnAlterarPix.Click();
end;

procedure TfrmCadFornecedores.dbgChavesPixKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) And
    (btnAlterarPix.Enabled) And
    (qryTabela.State in dsEditModes) Then
    btnAlterarPix.Click();

  If (Key = VK_ESCAPE) And
    (btnCancelarPix.Enabled) And
    (qryTabela.State in dsEditModes) Then
    btnCancelarPix.Click();

  If (Key = VK_DELETE) And
    (btnExcluirPix.Enabled) And
    (qryTabela.State in dsEditModes) Then
    btnExcluirPix.Click();
end;

procedure TfrmCadFornecedores.dbgContatosEnter(Sender: TObject);
begin
  inherited;
  If cdsForCtt.RecordCount > 0 Then
    cdsForCtt.First;
end;

procedure TfrmCadFornecedores.dbeObservKeyPress(Sender: TObject;
  var Key: Char);
  Var
    strKey : String;
begin
  inherited;
  strKey := Key;
  strKey := AnsiUpperCase(strKey);
  Key    := strKey[1];
end;

procedure TfrmCadFornecedores.DBEPEICMSExit(Sender: TObject);
begin
  inherited;
  DBEPEICMS.Enabled  := dbeSimPau.text = 'S';
  lblPeiIcms.Enabled := DBEPEICMS.Enabled;
  cblpeicms.Enabled  := lblPeiIcms.Enabled;
end;

procedure TfrmCadFornecedores.dbePlaNcoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fEntraCons(Key) Then
  Begin
    TStringField(qryTabela.FieldByName('FOR_PLANCO')).EditMask := '';
    if assigned(fPesqPlanoContabil) then
    begin
      If fPesqPlanoContabil(Self, dbePlaNco, Nil, Nil, Key, arrSel) Then
      Begin
        If fValidaCampos(dbePlaNco, True) Then
          Self.SelectNext(ActiveControl, True, True);
      End;
    end;
    if (Assigned(fMskCon)) then
      TStringField(qryTabela.FieldByName('FOR_PLANCO')).EditMask := fMskCon;
  End;
end;

procedure TfrmCadFornecedores.dbeRepCgcCpfExit(Sender: TObject);
begin
  inherited;

  If (dbeRepCgcCpf.Text = '1') Then
    objRepFor.FieldByName('REP_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
  Else
    objRepFor.FieldByName('REP_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_P_F_);

end;

procedure TfrmCadFornecedores.dbeRepCodCidKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;
  If fPesqCidade(Self, dbeRepCodCid, edtRepCidade, edtRepEst, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(dbeRepCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFornecedores.dbeRepNumCepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If (fEntraCons(Key)) And (fCfgSis('USACEP', varBoolean)) Then
  Begin
    Key := #0;

    dbeRepNumCep.Text := fConsultarCep(Self,
                          dbeRepNumCep.Text,
                          dbeRepNumCep);
  End;

end;

procedure TfrmCadFornecedores.dbeSimPauExit(Sender: TObject);
begin
  inherited;
  DBEPEICMS.Enabled  := dbeSimPau.text = 'S';
  lblPeiIcms.Enabled := DBEPEICMS.Enabled;
  cblpeicms.Enabled  := lblPeiIcms.Enabled;
end;

procedure TfrmCadFornecedores.btnFichaCadClick(Sender: TObject);
begin
  inherited;
  Try
    If fMensagem('Confirmação', 'Modelo da ficha cadastral:', ['Em branco', 'Preenchida']) = 1 Then
      blnBranco := True
    Else
      blnBranco := False;

    pCarregaTabelaFicha(cdsFicha);
    pPreviewReport(Self.Name, Self.Caption + ' (Ficha cadastral)', frxReport);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCadFornecedores.btnFichaCadClick]');
  End;
end;

procedure TfrmCadFornecedores.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var
    strCodEmp: String;
begin
  inherited;
  If (Key = VK_F8) Then
    btnFichaCad.Click;

  If (Key = VK_F9) Then
    btnCadClientes.Click;

  If (Key = VK_F7) Then
    btnCadTransportadora.Click;

  If (Key In [VK_DELETE, VK_ESCAPE, VK_RETURN]) And
     (dbgItens.Focused) And
     (qryTabela.State In [dsEdit, dsInsert]) Then
  Begin
    If Key = VK_DELETE Then
      objForPre.pApagaItem

    Else If Key = VK_ESCAPE Then
      btnCanIte.Click

    Else If Key = VK_RETURN Then
      pSetFocus(btnGravar);

    Key := 0;
  End;

  If (Key = VK_RETURN) And (ActiveControl Is TDBComboBoxFocus) Then
    SelectNext(ActiveControl, True, True);

  If (Shift = [ssAlt]) And (Key = Ord('2')) Then
  Begin
    If dbeObserv.Focused Then
      pgcDados.ActivePage := tbsContatos;
  End;

  Case Key Of
    16, 76 {L, l}: If ssAlt In Shift Then
                     btnDelGru.Click;
  End;

  Case Key of
    VK_RETURN: If fCheckParent(ActiveControl, cxgEmpresas) Then
               Begin
                 If cxvEmpresasPRAENT.Focused Then
                   cxvEmpresasVALMIN.Focused := True

                 Else If cxvEmpresasVALMIN.Focused Then
                 Begin
                   strCodEmp := objPraEmp.FieldByName('PRA_CODEMP').AsString;
                   cxvEmpresas.NavigatorButtons.Next.Click;

                   If strCodEmp = objPraEmp.FieldByName('PRA_CODEMP').AsString Then
                     pSetFocus(btnGravar);

                   cxvEmpresasPRAENT.Focused := True;
                 End;

               End;

  End;


end;

procedure TfrmCadFornecedores.dbeNumCepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If (fEntraCons(Key)) And (fCfgSis('USACEP', varBoolean)) Then
  Begin
    Key := #0;

    dbeNumCep.Text := fConsultarCep(Self,
                          dbeNumCep.Text,
                          dbeNumCep);
  End;

end;

procedure TfrmCadFornecedores.pMontaModelosLayoutCoral;
  Var
    intContador: Integer;
Begin
  cbxLayNeo.Items.Clear;

  For intContador := Low(TIPOS_LAYOUT_CORAL) To High(TIPOS_LAYOUT_CORAL) Do
  Begin
    cbxLayNeo.Items.Add(String(DESCRICAO_LAYOUT_CORAL[intContador]));
  End;
End;

procedure TfrmCadFornecedores.edtDigCtaExit(Sender: TObject);
begin
  inherited;
  pEhContaComDoisDigitos;
end;

procedure TfrmCadFornecedores.edtDigVerEnter(Sender: TObject);
begin
  inherited;
  HintControler.ShowHint(Self.Left + edtDigVer.Left + 15,
                         Self.Top + 53 + edtDigVer.Top + edtDigVer.Height,
                         'Atenção!',
                         'Para os Bancos que se utilizam de duas posições para o Dígito Verificador do Número'+ #13#10 +
                         'da Conta Corrente, preencher este campo com a 2ª posição deste dígito.');end;

procedure TfrmCadFornecedores.edtDigVerExit(Sender: TObject);
begin
  inherited;
  pHabilitaDigVerificador(Not fEmptyStr(edtDigVer.Text));
  HintControler.HideHint;
end;

procedure TfrmCadFornecedores.edtDigVerMouseEnter(Sender: TObject);
begin
  inherited;
  HintControler.ShowHint(Self.Left + edtDigVer.Left + 15,
                         Self.Top + 53 + edtDigVer.Top + edtDigVer.Height,
                         'Atenção!',
                         'Para os Bancos que se utilizam de duas posições para o Dígito Verificador do Número'+ #13#10 +
                         'da Conta Corrente, preencher este campo com a 2ª posição deste dígito.');
end;

procedure TfrmCadFornecedores.edtDigVerMouseLeave(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;

end;

procedure TfrmCadFornecedores.edtDivVenChange(Sender: TObject);
begin
  inherited;
  case edtDivVen.ItemIndex of
    0: objFornecedorBosh.DivisaoVenda := '01';
    1: objFornecedorBosh.DivisaoVenda := '02';
    2: objFornecedorBosh.DivisaoVenda := '03';
    3: objFornecedorBosh.DivisaoVenda := '04';
    4: objFornecedorBosh.DivisaoVenda := '42';
    5: objFornecedorBosh.DivisaoVenda := '66';
  End;

end;

procedure TfrmCadFornecedores.edtTipEntChange(Sender: TObject);
begin
  inherited;
  objFornecedorBosh.TipoEntrega := edtTipEnt.Text;
end;

procedure TfrmCadFornecedores.edtTipPedChange(Sender: TObject);
begin
  inherited;
  case edtTipPed.ItemIndex of
    0: objFornecedorBosh.TipoPedido := '01';
    1: objFornecedorBosh.TipoPedido := '02';
    2: objFornecedorBosh.TipoPedido := '03';
    3: objFornecedorBosh.TipoPedido := '04';
    4: objFornecedorBosh.TipoPedido := '05';
    5: objFornecedorBosh.TipoPedido := '06';
  End;

end;

procedure TfrmCadFornecedores.pPreparaBosh;
begin
  fraDirBosh.Enabled := btnGravar.Enabled;
  edtDivVen.Enabled := btnGravar.Enabled;
  edtTipPed.Enabled := btnGravar.Enabled;
  edtTipEnt.Enabled := btnGravar.Enabled;

  objFornecedorBosh.blnPermiteEdicao := False;
  objFornecedorBosh.pCarregaFornecedor(dbeCodigo.Text);
  edtTipEnt.Text := objFornecedorBosh.TipoEntrega;
  fraDirBosh.edtDirectory.text := objFornecedorBosh.PathGeracao;
  If objFornecedorBosh.TipoPedido = '01' Then
    edtTipPed.ItemIndex := 0
  Else If objFornecedorBosh.TipoPedido = '02' Then
    edtTipPed.ItemIndex := 1
  Else If objFornecedorBosh.TipoPedido = '03' Then
    edtTipPed.ItemIndex := 2
  Else If objFornecedorBosh.TipoPedido = '04' Then
    edtTipPed.ItemIndex := 3
  Else If objFornecedorBosh.TipoPedido = '05' Then
    edtTipPed.ItemIndex := 4
  Else If objFornecedorBosh.TipoPedido = '06' Then
    edtTipPed.ItemIndex := 5
  Else
    edtTipPed.ItemIndex := -1;

  If objFornecedorBosh.DivisaoVenda ='01' Then
     edtDivVen.ItemIndex := 0
  Else If objFornecedorBosh.DivisaoVenda ='02' Then
     edtDivVen.ItemIndex := 1
  Else If objFornecedorBosh.DivisaoVenda ='03' Then
     edtDivVen.ItemIndex := 2
  Else If objFornecedorBosh.DivisaoVenda ='04' Then
     edtDivVen.ItemIndex := 3
  Else If objFornecedorBosh.DivisaoVenda ='42' Then
     edtDivVen.ItemIndex := 4
  Else If objFornecedorBosh.DivisaoVenda ='66' Then
     edtDivVen.ItemIndex := 5
  Else
     edtDivVen.ItemIndex := -1;
  objFornecedorBosh.blnPermiteEdicao := True;

end;

procedure TfrmCadFornecedores.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, dbeCodCli.Text);
  With qryConCli Do
  Begin
    edtNomCli.Text := FieldByName('CLI_NOMCLI').AsString;
  End;
end;

class function TfrmCadFornecedores.fCadastroRapidoFornecedor(var strCodFor: String;
                                                             strNomFor,
                                                             strNomFan,
                                                             strEndere,
                                                             strBairro,
                                                             strCodCid,
                                                             strNumCep,
                                                             strFone01,
                                                             strNumRg,
                                                             strEmail,
                                                             strStatus,
                                                             strNumCgc,
                                                             strFon02,
                                                             strNumCel,
                                                             strHomPag,
                                                             strCodCli,
                                                             strInsEst,
                                                             strCodAti: String;
                                                             intCgcCpf: integer): Boolean;
var
  qryCadFor: TUniQuery;

  function fProximoCodigo: String;
  begin
    Result := fAtualizaProCod('CADFOR', 'FOR_CODFOR');
  end;

begin
   Result := False;

  fStartTransaction;

  if (fEmptyStr(strCodFor)) then
  begin
    qryCadFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE');
  end
  else
  begin
    qryCadFor := fCriarQuery('SELECT * FROM CADFOR WHERE FOR_CODFOR = ' + QuotedStr(strCodFor));
  end;

  try
    try
      qryCadFor.Open;

      if (fEmptyStr(strCodFor)) then
      begin
        if (fUsaProCodigo('CADFOR')) then
        begin
          strCodFor := fProximoCodigo;
        end;

        qryCadFor.Append;

        qryCadFor.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADFOR', VS_strCodEmp);
        qryCadFor.FieldByName('FOR_CODEMP').AsString := VS_strCodEmp;

        qryCadFor.FieldByName('FOR_DTACAD').AsDateTime := VS_Date;
        qryCadFor.FieldByName('FOR_PERFCX').AsFloat  := 0;
        qryCadFor.FieldByName('FOR_MATREV').AsString := 'R';
        qryCadFor.FieldByName('FOR_SIMPAU').AsString := 'P';
        qryCadFor.FieldByName('FOR_VLRED2').AsString := 'N';
        qryCadFor.FieldByName('FOR_ACOOBJ').AsString := 'N';
        qryCadFor.FieldByName('FOR_ANCORA').AsString := 'N';
        qryCadFor.FieldByName('FOR_REVIST').AsString := 'N';
        qryCadFor.FieldByName('FOR_DIAENT').AsInteger:= 0;
        qryCadFor.FieldByName('FOR_ZONFRA').AsString := 'N';
        qryCadFor.FieldByName('FOR_MINPED').AsFloat  := 0;
        qryCadFor.FieldByName('FOR_REDPIS').AsString := 'N';

        if not fEmptyStr(fCfgSis('CTAFOR')) then
        begin
          qryCadFor.FieldByName('FOR_CONCON').AsString := fCfgSis('CTAFOR');
        end;
      end
      else
      begin
        qryCadFor.Edit;
      end;

      qryCadFor.FieldByName('FOR_CODFOR').AsString  := strCodFor;
      qryCadFor.FieldByName('FOR_NOMFOR').AsString  := strNomFor;
      qryCadFor.FieldByName('FOR_NOMFAN').AsString  := strNomFan;
      qryCadFor.FieldByName('FOR_ENDERE').AsString  := strEndere;
      qryCadFor.FieldByName('FOR_BAIRRO').AsString  := strBairro;
      qryCadFor.FieldByName('FOR_CODCID').AsString  := strCodCid;
      qryCadFor.FieldByName('FOR_C_E_P_').AsString  := fTiraCaracEspeciais(strNumCep);
      qryCadFor.FieldByName('FOR_FONE01').AsString  := fTiraCaracEspeciais(strFone01);
      qryCadFor.FieldByName('FOR_NUMRG_').AsString  := strNumRg;
      qryCadFor.FieldByName('FOR_EMAIL_').AsString  := strEmail;
      qryCadFor.FieldByName('FOR_STATUS').AsString  := strStatus;
      qryCadFor.FieldByName('FOR_C_G_C_').AsString  := strNumCgc;
      qryCadFor.FieldByName('FOR_FONE02').AsString  := fTiraCaracEspeciais(strFon02);
      qryCadFor.FieldByName('FOR_NUMCEL').AsString  := fTiraCaracEspeciais(strNumCel);
      qryCadFor.FieldByName('FOR_HOMEPA').AsString  := strHomPag;
      qryCadFor.FieldByName('FOR_I_E_S_').AsString  := strInsEst;

      if (fEmptyStr(strCodCli)) then
      begin
        qryCadFor.FieldByName('FOR_CODCLI').Clear;
      end
      else
      begin
        qryCadFor.FieldByName('FOR_CODCLI').AsString  := strCodCli;
      end;

      qryCadFor.FieldByName('FOR_CODATI').AsString  := strCodAti;
      qryCadFor.FieldByName('FOR_CGCCPF').AsInteger := intCgcCpf;

      qryCadFor.Post;

      fCommit;

      Result := True;
    except
      on E: Exception do
      begin
        fRollBack;
        pMensagensErro(E.message, '');
      end;
    end;
  finally
    FreeAndNil(qryCadFor);
  end;
end;

function TfrmCadFornecedores.fClienteVinculado(strCodCli : string) : boolean;
Var
  strSQL : string;
  qryCliFor : TUniQuery;
begin
  Result := False;

  qryCliFor := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  FOR_CODFOR, FOR_NOMFOR ';
  strSQL := strSQL + 'FROM CADFOR WHERE FOR_CODCLI = :CODCLI';

  With qryCliFor Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString  := strCodCli;
    Open;

    If RecordCount > 0 Then
    Begin
      If dbeCodigo.Text <> FieldByName('FOR_CODFOR').AsString Then
      Begin
        fMensagem('ATENÇÃO!', 'Este cliente já esta vinculado ao fornecedor:' + #13#10 +
                  FieldByName('FOR_CODFOR').AsString + ' - '+ FieldByName('FOR_NOMFOR').AsString, ['&Ok']);
        Result := True;
      End;
    End;

    Close;
  End;

  FreeAndNil(qryCliFor);
end;

procedure TfrmCadFornecedores.FDatasetForPixOnAfterScroll(DataSet: TDataSet);
begin
  edtChavePix.Clear;
  cmbTipoDoPix.ItemIndex := -1;
  edtCPFCNPJPix.Visible := False;

  If (Dataset.IsEmpty) Then
    Exit;

  If (Dataset.State in dsEditModes) Then
    Exit;

  If Dataset.FieldByName('PIX_TIPCHV').AsString = 'CNPJ-CPF' Then
  Begin
    cmbTipoDoPix.ItemIndex := 0;
    edtCPFCNPJPix.Text := '1';
    If Dataset.FieldByName('PIX_CHAVE_').AsString.Length = 11 Then
      edtCPFCNPJPix.Text := '2';
  End
  Else If Dataset.FieldByName('PIX_TIPCHV').AsString = 'CELULAR' Then
    cmbTipoDoPix.ItemIndex := 1
  Else If Dataset.FieldByName('PIX_TIPCHV').AsString = 'EMAIL' Then
    cmbTipoDoPix.ItemIndex := 2
  Else If Dataset.FieldByName('PIX_TIPCHV').AsString = 'ALEATORIA' Then
    cmbTipoDoPix.ItemIndex := 3;

  cmbTipoDoPix.OnChange(cmbTipoDoPix);

  edtChavePix.Text := Dataset.FieldByName('PIX_CHAVE_').AsString;
end;

procedure TfrmCadFornecedores.pCarregaPlanoContabil(const blnBuscaPorChave: Boolean=False);
begin
  If (edtDesPlaNco.Visible) and (assigned(fSemMascaraPlaNco)) Then
  begin
    if assigned(fCampoTabelaPlanco) then
    begin
      edtDesPlaNco.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePlaNco.Text)], False);
    end
    else
    begin
      edtDesPlaNco.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePlaNco.Text)], False);
    end;
  end;
end;

procedure TfrmCadFornecedores.pCarregaTabelaFicha(cdsFichas: TUniClientDataSet);
var
  qryRelatorio : TUniQuery;
  strSQL : String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   FOR_CODFOR AS CODFOR, ';
  strSQL := strSQL + '   FOR_NOMFOR AS NOMFOR, ';
  strSQL := strSQL + '   FOR_ENDERE AS ENDERE, ';
  strSQL := strSQL + '   FOR_ENDNUM AS ENDNUM, ';
  strSQL := strSQL + '   FOR_DTACAD AS DTACAD, ';
  strSQL := strSQL + '   FOR_NOMFAN AS NOMFAN, ';
  strSQL := strSQL + '   FOR_BAIRRO AS BAIRRO, ';
  strSQL := strSQL + '   FOR_C_E_P_ AS C_E_P_, ';
  strSQL := strSQL + '   FOR_CGCCPF AS CGCCPF, ';
  strSQL := strSQL + '   FOR_C_G_C_ AS C_G_C_, ';
  strSQL := strSQL + '   FOR_I_E_S_ AS I_E_S_, ';
  strSQL := strSQL + '   FOR_CONTAT AS CONTAT, ';
  strSQL := strSQL + '   FOR_CAIPOS AS CAIPOS, ';
  strSQL := strSQL + '   FOR_FONE01 AS FONE01, ';
  strSQL := strSQL + '   FOR_FONE02 AS FONE02, ';
  strSQL := strSQL + '   FOR_F_A_X_ AS F_A_X_, ';
  strSQL := strSQL + '   FOR_0800__ AS _0800_, ';
  strSQL := strSQL + '   FOR_EMAIL_ AS EMAIL_, ';
  strSQL := strSQL + '   FOR_OBSERV AS OBSERV, ';
  strSQL := strSQL + '   FOR_HOMEPA AS HOMEPA, ';
  strSQL := strSQL + '   FOR_CNDPAG AS CNDPAG, ';
  strSQL := strSQL + '   FOR_CONCON AS CONCON, ';
  strSQL := strSQL + '   FOR_CODCTA AS CODCTA, ';
  strSQL := strSQL + '   FOR_CODTRA AS CODTRA, ';
  strSQL := strSQL + '   FOR_NUMRG_ AS NUMRG_, ';
  strSQL := strSQL + '   CASE                  ';
  strSQL := strSQL + '    WHEN FOR_MATREV = ''I'' ';
  strSQL := strSQL + '    THEN ''Indústria''      ';
  strSQL := strSQL + '    WHEN FOR_MATREV = ''C'' ';
  strSQL := strSQL + '    THEN ''Comércio''       ';
  strSQL := strSQL + '    WHEN FOR_MATREV = ''R'' ';
  strSQL := strSQL + '    THEN ''Revenda''        ';
  strSQL := strSQL + '    ELSE FOR_MATREV         ';
  strSQL := strSQL + '   END AS MATREV,           ';
  strSQL := strSQL + '   FOR_PERCOM AS PERCOM, ';
  strSQL := strSQL + '   FOR_STATUS AS STATUS, ';
  strSQL := strSQL + '   CID_NOMCID AS NOMCID, ';
  strSQL := strSQL + '   CID_ESTADO AS ESTADO, ';
  strSQL := strSQL + '   ATI_DESATI AS DESATI  ';
  strSQL := strSQL + ' FROM                    ';
  strSQL := strSQL + '   CADFOR                ';
  strSQL := strSQL + '   INNER JOIN CADCID  ON CADCID.CID_CODCID = CADFOR.FOR_CODCID ';
  strSQL := strSQL + '   INNER JOIN CADATI  ON CADFOR.FOR_CODATI = CADATI.ATI_CODATI ';
  strSQL := strSQL + ' WHERE                   ';
  strSQL := strSQL + '   CADFOR.FOR_CODFOR = :CODFOR ';
  //strSQL := strSQL + '   CADFOR.FOR_CODFOR = '''+qryTabela.FieldByName('FOR_CODFOR').AsString+''' ';

  qryRelatorio := fCriaQuery;
  qryRelatorio.SQL.Clear;
  qryRelatorio.SQL.Add(strSQL);
  qryRelatorio.ParamByName('CODFOR').AsString := qryTabela.FieldByName('FOR_CODFOR').AsString;
  qryRelatorio.Open;

  cdsFicha.EmptyDataSet;

  cdsFicha.FieldByName('FONE01').EditMask   := '';
  cdsFicha.FieldByName('FONE02').EditMask   := '';
  cdsFicha.FieldByName('F_A_X_').EditMask   := '';

  if not blnBranco then
  begin
    cdsFicha.Append;
    cdsFicha.FieldByName('CODFOR').AsString   := qryRelatorio.FieldByName('CODFOR').AsString;
    cdsFicha.FieldByName('NOMFOR').AsString   := qryRelatorio.FieldByName('NOMFOR').AsString;
    cdsFicha.FieldByName('ENDERE').AsString   := qryRelatorio.FieldByName('ENDERE').AsString;
    cdsFicha.FieldByName('ENDNUM').AsString   := qryRelatorio.FieldByName('ENDNUM').AsString;
    cdsFicha.FieldByName('DTACAD').AsString   := qryRelatorio.FieldByName('DTACAD').AsString;
    cdsFicha.FieldByName('NOMFAN').AsString   := qryRelatorio.FieldByName('NOMFAN').AsString;
    cdsFicha.FieldByName('BAIRRO').AsString   := qryRelatorio.FieldByName('BAIRRO').AsString;
    cdsFicha.FieldByName('C_E_P_').AsString   := qryRelatorio.FieldByName('C_E_P_').AsString;
    cdsFicha.FieldByName('CGCCPF').AsString   := qryRelatorio.FieldByName('CGCCPF').AsString;
    cdsFicha.FieldByName('C_G_C_').AsString   := qryRelatorio.FieldByName('C_G_C_').AsString;
    cdsFicha.FieldByName('I_E_S_').AsString   := qryRelatorio.FieldByName('I_E_S_').AsString;
    cdsFicha.FieldByName('CONTAT').AsString   := qryRelatorio.FieldByName('CONTAT').AsString;
    cdsFicha.FieldByName('CAIPOS').AsString   := qryRelatorio.FieldByName('CAIPOS').AsString;
    cdsFicha.FieldByName('FONE01').AsString   := qryRelatorio.FieldByName('FONE01').AsString;
    cdsFicha.FieldByName('FONE02').AsString   := qryRelatorio.FieldByName('FONE02').AsString;
    cdsFicha.FieldByName('F_A_X_').AsString   := qryRelatorio.FieldByName('F_A_X_').AsString;
    cdsFicha.FieldByName('FONE01').EditMask   := fRetMascaraFonePais;
    cdsFicha.FieldByName('FONE02').EditMask   := fRetMascaraFonePais;
    cdsFicha.FieldByName('F_A_X_').EditMask   := fRetMascaraFonePais;
    cdsFicha.FieldByName('_0800_').AsString   := qryRelatorio.FieldByName('_0800_').AsString;
    cdsFicha.FieldByName('EMAIL_').AsString   := qryRelatorio.FieldByName('EMAIL_').AsString;
    cdsFicha.FieldByName('OBSERV').AsString   := qryRelatorio.FieldByName('OBSERV').AsString;
    cdsFicha.FieldByName('HOMEPA').AsString   := qryRelatorio.FieldByName('HOMEPA').AsString;
    cdsFicha.FieldByName('CNDPAG').AsString   := qryRelatorio.FieldByName('CNDPAG').AsString;
    cdsFicha.FieldByName('CONCON').AsString   := qryRelatorio.FieldByName('CONCON').AsString;
    cdsFicha.FieldByName('CODCTA').AsString   := qryRelatorio.FieldByName('CODCTA').AsString;
    cdsFicha.FieldByName('CODTRA').AsString   := qryRelatorio.FieldByName('CODTRA').AsString;
    cdsFicha.FieldByName('NUMRG_').AsString   := qryRelatorio.FieldByName('NUMRG_').AsString;
    cdsFicha.FieldByName('MATREV').AsString   := qryRelatorio.FieldByName('MATREV').AsString;
    cdsFicha.FieldByName('PERCOM').AsString   := qryRelatorio.FieldByName('PERCOM').AsString;
    cdsFicha.FieldByName('STATUS').AsString   := qryRelatorio.FieldByName('STATUS').AsString;
    cdsFicha.FieldByName('NOMCID').AsString   := qryRelatorio.FieldByName('NOMCID').AsString;
    cdsFicha.FieldByName('ESTADO').AsString   := qryRelatorio.FieldByName('ESTADO').AsString;
    cdsFicha.FieldByName('DESATI').AsString   := qryRelatorio.FieldByName('DESATI').AsString;
    cdsFicha.Post;
  end;
end;

class function TfrmCadFornecedores.fAlteraCadFor(const strCodForLocal: String): String;
begin
  If Not fVerificaAcessoSistema('frmCadFornecedores') Then
    Exit;

  pCriarFormularios(TfrmCadFornecedores, frmCadFornecedores);
  Try
    Try
      frmCadFornecedores.strCodFornecedorIniciarCadastro := strCodForLocal;
      frmCadFornecedores.ShowModal;

      Result := frmCadFornecedores.strUltimoCodigo;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  Finally
    pFreeAndNil(frmCadFornecedores);
  End;

end;

end.
