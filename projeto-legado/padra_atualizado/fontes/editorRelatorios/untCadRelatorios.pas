unit untCadRelatorios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, EditFocus, DBComboBoxFocus, DBMemoFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxDropDownEdit, untRelatorio, Printers, cxCheckBox,
  cxCurrencyEdit, untConsultasRel, cxGridBandedTableView,
  cxProgressBar, untFuncEditorRel,
  cxGridDBBandedTableView, Datasnap.DBClient, UniClientDataSet, AdvMenus,
  ComboBoxFocus, Math, cxButtons, cxDBLookupComboBox,
  BCEditor.Editor.Base, BCEditor.Editor, cxContainer, cxCheckListBox,
  cxDBCheckListBox, Vcl.CheckLst, cxTextEdit, cxMaskEdit, cxSpinEdit, cxDBEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog, MemoFocus,
  untGravando, Vcl.Samples.Spin, cxColorComboBox, cxDBColorComboBox,
  cxLookupEdit, cxDBLookupEdit, untRotinasGrid, cxButtonEdit, fs_synmemo, Uni;

type
  TfrmCadRelatorios = class(TfrmPaiCad)
    dtsCadRel: TDataSource;
    tbsSQL: TTabSheet;
    btnExecutar: TBitBtnLocked;
    tbsParametros: TTabSheet;
    Panel1: TPanel;
    cxvParams: TcxGridDBTableView;
    cxgParamsLevel1: TcxGridLevel;
    cxgParams: TcxGrid;
    Panel2: TPanel;
    cxvParamsNOMPAR: TcxGridDBColumn;
    cxvParamsDESPAR: TcxGridDBColumn;
    cxvParamsTIPPAR: TcxGridDBColumn;
    tbsCampos: TTabSheet;
    pnlRodape: TPanel;
    Panel5: TPanel;
    cxgCampos: TcxGrid;
    cxvCampos: TcxGridDBTableView;
    cxgCamposNOMCAM: TcxGridDBColumn;
    cxgCamposDESCAM: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    cxgCamposLARGUR: TcxGridDBColumn;
    cxvCamposTOTALI: TcxGridDBColumn;
    cxvCamposQUEBRA: TcxGridDBColumn;
    cxvCamposLARGURAREAL: TcxGridDBColumn;
    cxvParamsPESQUI: TcxGridDBColumn;
    pnlRodapeFiltros: TPanel;
    btnAltFil: TBitBtnLocked;
    cxvParamsTIPFAC: TcxGridDBColumn;
    cxvCamposLISQUE: TcxGridDBColumn;
    cxvCamposMASCAR: TcxGridDBColumn;
    btnTesteExe: TBitBtnLocked;
    btnIncMen: TBitBtnLocked;
    btnSalvaBackup: TBitBtnLocked;
    pnlGeral: TPanel;
    cxvCamposLISTAR: TcxGridDBColumn;
    Panel6: TPanel;
    tbsComplementos: TTabSheet;
    cxStyleRepository: TcxStyleRepository;
    cxStyle2: TcxStyle;
    cxvCamposFUNCAO: TcxGridDBColumn;
    pnlDetalheTotais: TPanel;
    cxvCamposLINQUE: TcxGridDBColumn;
    cbxTipTot: TComboBoxFocus;
    Label6: TLabel;
    cxvCamposPOSORD: TcxGridDBColumn;
    pnlGridLargura: TPanel;
    cxgLargura: TcxGrid;
    cxvLinhas: TcxGridDBBandedTableView;
    cxvLinhasColumn1: TcxGridDBBandedColumn;
    cxvLinhasColumn2: TcxGridDBBandedColumn;
    cxvLinhasColumn3: TcxGridDBBandedColumn;
    cxvLinhasColumn4: TcxGridDBBandedColumn;
    cxvLinhasColumn5: TcxGridDBBandedColumn;
    cxvLinhasColumn6: TcxGridDBBandedColumn;
    cxvLinhasColumn7: TcxGridDBBandedColumn;
    cxvLinhasColumn8: TcxGridDBBandedColumn;
    cxvLinhasColumn9: TcxGridDBBandedColumn;
    cxvLinhasColumn10: TcxGridDBBandedColumn;
    cxgLarguraLevel1: TcxGridLevel;
    pnlInterGrafica: TPanel;
    pnlTitGraf: TPanel;
    scrLinhas: TScrollBox;
    imgFundo: TImage;
    cxvCamposColumn1: TcxGridDBColumn;
    btnAjuda: TBitBtnLocked;
    Label8: TLabel;
    dbeTexTot: TDBEditFocus;
    tbsGrupoFiltros: TTabSheet;
    GroupBox3: TGroupBox;
    btnOrdBai: TBitBtnLocked;
    btnOrdCim: TBitBtnLocked;
    cxvParamsCODGRU: TcxGridDBColumn;
    cxvParamsORDENA: TcxGridDBColumn;
    cxvGruposPar: TcxGridDBTableView;
    cxgGruposParLevel1: TcxGridLevel;
    cxgGruposPar: TcxGrid;
    cxvGruposParColumn1: TcxGridDBColumn;
    pnlGruposPar: TPanel;
    btnExcluiGrupos: TBitBtnLocked;
    edtNovGru: TEditFocus;
    Label9: TLabel;
    dtsGruPar: TDataSource;
    cxStyle3: TcxStyle;
    pnlMsgRod: TPanel;
    Panel11: TPanel;
    dbeMsgRod: TDBMemoFocus;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    grbFiltroComp: TGroupBox;
    grbCSV: TGroupBox;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    Panel12: TPanel;
    pnlJato: TPanel;
    grbJato: TGroupBox;
    Label4: TLabel;
    dbeTipFol: TDBComboBoxFocus;
    rdgOrient: TRadioGroup;
    pnlMatricial: TPanel;
    grbMatricial: TGroupBox;
    Label5: TLabel;
    dbeQtdCol: TDBComboBoxFocus;
    dbeAltMod: TDBCheckBox;
    pnlMsgDados: TPanel;
    Panel14: TPanel;
    dbeMsgDad: TDBMemoFocus;
    tbsGruCam: TTabSheet;
    pnlGruCam: TPanel;
    Label10: TLabel;
    btnExcGruCam: TBitBtnLocked;
    edtGruCam: TEditFocus;
    cxgGruposCam: TcxGrid;
    cxvGruposCam: TcxGridDBTableView;
    cxvGruposNOMGRU: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    cxStyle4: TcxStyle;
    cxStyle1: TcxStyle;
    cxvCamposGRUCAM: TcxGridDBColumn;
    btnAltCam: TBitBtnLocked;
    Panel13: TPanel;
    Shape1: TShape;
    Label7: TLabel;
    cbxTitQue: TComboBoxFocus;
    lblTitQue: TLabel;
    cbxFilPri: TComboBoxFocus;
    Label12: TLabel;
    cxvGruposTIPBAN: TcxGridDBColumn;
    dtsTipBan: TDataSource;
    tbsSQLFil: TTabSheet;
    Panel16: TPanel;
    tbsCompFiltroCab: TTabSheet;
    chkInfHei: TDBCheckBox;
    lblPapHei: TLabel;
    dbePapHei: TDBEditFocus;
    Label13: TLabel;
    btnCadTem: TBitBtnLocked;
    Label14: TLabel;
    bceDefSQL: TBCEditor;
    bceSQLFil: TBCEditor;
    Panel18: TPanel;
    cklDestin: TCheckListBox;
    cbxHorizo: TComboBoxFocus;
    dbeMaxCol: TcxDBSpinEdit;
    lblMaxCol: TLabel;
    DBCheckBox8: TDBCheckBox;
    Label20: TLabel;
    dbeDesCmp: TDBMemoFocus;
    tbsHistorico: TTabSheet;
    Panel19: TPanel;
    Label21: TLabel;
    edtTitHis: TEditFocus;
    Label22: TLabel;
    edtDesHis: TMemoFocus;
    Label23: TLabel;
    cxgHisto: TcxGrid;
    cxvHisto: TcxGridDBTableView;
    cxvHistoColumn3: TcxGridDBColumn;
    cxvHistoColumn4: TcxGridDBColumn;
    cxvHistoColumn1: TcxGridDBColumn;
    cxGridLevel3: TcxGridLevel;
    btnIncHis: TBitBtnLocked;
    btnAltHis: TBitBtnLocked;
    btnDelHis: TBitBtnLocked;
    btnCanHis: TBitBtnLocked;
    btnGraHis: TBitBtnLocked;
    btnInsereLoteGrupo: TBitBtnLocked;
    btnCamAut: TBitBtnLocked;
    Label24: TLabel;
    dbeFatSca: TDBEditFocus;
    dbeSplit: TDBCheckBox;
    tmrRolagem: TTimer;
    grbZebra: TGroupBox;
    Label25: TLabel;
    edtZooIni: TSpinEdit;
    Label26: TLabel;
    dbeArquiv: TDBEditFocus;
    Label27: TLabel;
    btnAjudaCampos: TBitBtnLocked;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    lbl8: TLabel;
    edtCodCom: TEditFocus;
    edtDesCom: TEditFocus;
    btnIncCom: TBitBtnLocked;
    cxgRelat: TcxGrid;
    cxvRelat: TcxGridDBTableView;
    cxvRelatCODREL: TcxGridDBColumn;
    cxvRelatDESCRI: TcxGridDBColumn;
    cxvRelatDESCMP: TcxGridDBColumn;
    cxvRelatORDENA: TcxGridDBColumn;
    cxvRelatNOVPAG: TcxGridDBColumn;
    cxgRelatLevel1: TcxGridLevel;
    pnlRodapeComplementares: TPanel;
    btnDelCom: TBitBtnLocked;
    Splitter1: TSplitter;
    Panel22: TPanel;
    Panel23: TPanel;
    Panel24: TPanel;
    Label28: TLabel;
    edtCodChi: TEditFocus;
    edtDesChi: TEditFocus;
    btnIncChi: TBitBtnLocked;
    cxgChirel: TcxGrid;
    cxvChirel: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxvChirelNomCam: TcxGridDBColumn;
    cxvChirelCamLig: TcxGridDBColumn;
    cxgChirelLevel1: TcxGridLevel;
    Panel25: TPanel;
    btnDelChi: TBitBtnLocked;
    dbeCSVCAQ: TDBCheckBox;
    dbeCSVCAR: TDBCheckBox;
    dbeCSVDAS: TDBCheckBox;
    cxvCamposCNDVIS: TcxGridDBColumn;
    pnlComplementos: TPanel;
    pnlCompCabecalho: TPanel;
    Panel17: TPanel;
    Label17: TLabel;
    Label19: TLabel;
    dbeComCab: TDBMemoFocus;
    pnlCompTelaFiltro: TPanel;
    Panel26: TPanel;
    Label16: TLabel;
    Label18: TLabel;
    dbeCOMFIL: TDBMemoFocus;
    Splitter2: TSplitter;
    pnlDirRel: TPanel;
    Panel15: TPanel;
    Panel27: TPanel;
    Label29: TLabel;
    edtCodDir: TEditFocus;
    edtNomDir: TEditFocus;
    btnIncDir: TBitBtnLocked;
    cxgDirRel: TcxGrid;
    cxvDirRel: TcxGridDBTableView;
    cxGridDBCODDIR: TcxGridDBColumn;
    cxGridDBNOMDIR: TcxGridDBColumn;
    cxGridLevel4: TcxGridLevel;
    Panel28: TPanel;
    btnDelDir: TBitBtnLocked;
    dbeReiZeb: TDBCheckBox;
    dbeSELIHE: TDBCheckBox;
    pnlTXT: TPanel;
    pnlRodapeGeral: TPanel;
    GroupBox5: TGroupBox;
    Label30: TLabel;
    debQTDCOLTXT: TDBEditFocus;
    dbeIMPMEI: TDBCheckBox;
    btnRepFon: TBitBtnLocked;
    btnDelFon: TBitBtnLocked;
    pnlRelPai: TPanel;
    Label11: TLabel;
    dbeCodPai: TDBEditFocus;
    edtDesCodPai: TEditFocus;
    dbePreLim: TDBCheckBox;
    dbeQBRCOM: TDBCheckBox;
    dbeQBRFIL: TDBCheckBox;
    DBCheckBox10: TDBCheckBox;
    bdeGraDir: TDBCheckBox;
    dbeFilCnd: TDBEditFocus;
    dbeCOMPVZ: TDBCheckBox;
    Label32: TLabel;
    dbeCodVal: TDBEditFocus;
    edtDesCodVal: TEditFocus;
    Panel20: TPanel;
    GroupBox1: TGroupBox;
    Label31: TLabel;
    DBEditFocus1: TDBEditFocus;
    Label33: TLabel;
    DBEditFocus2: TDBEditFocus;
    Label34: TLabel;
    DBEditFocus3: TDBEditFocus;
    Label35: TLabel;
    DBEditFocus4: TDBEditFocus;
    Label36: TLabel;
    DBEditFocus5: TDBEditFocus;
    Label37: TLabel;
    DBEditFocus6: TDBEditFocus;
    Label39: TLabel;
    DBEditFocus7: TDBEditFocus;
    btnInventario: TBitBtnLocked;
    btnLote: TBitBtnLocked;
    btnSalInv: TBitBtnLocked;
    btnCtr: TBitBtnLocked;
    btnEstExt: TBitBtnLocked;
    tbsGrafico: TTabSheet;
    Panel29: TPanel;
    GroupBox2: TGroupBox;
    Label44: TLabel;
    Label45: TLabel;
    GroupBox4: TGroupBox;
    Label40: TLabel;
    dbeFntCam: TDBEditFocus;
    btnSetaFonte: TBitBtnLocked;
    Label48: TLabel;
    DBEditFocus15: TDBEditFocus;
    btnSetFonteLegenda: TBitBtnLocked;
    Label49: TLabel;
    btnSetaCorLegendaFundo: TcxDBColorComboBox;
    GroupBox6: TGroupBox;
    Label42: TLabel;
    DBEditFocus9: TDBEditFocus;
    Label50: TLabel;
    DBEditFocus16: TDBEditFocus;
    btnFonteEixoY: TBitBtnLocked;
    GroupBox7: TGroupBox;
    Label51: TLabel;
    Label52: TLabel;
    DBEditFocus17: TDBEditFocus;
    DBEditFocus18: TDBEditFocus;
    btnFonteEixoX: TBitBtnLocked;
    GroupBox8: TGroupBox;
    dbeVarCor: TDBCheckBox;
    DBCheckBox11: TDBCheckBox;
    DBCheckBox12: TDBCheckBox;
    Label43: TLabel;
    cmbMolGra: TComboBoxFocus;
    btnLimpaFonte: TBitBtnLocked;
    btnLimpaFonteLegenda: TBitBtnLocked;
    btnLimpaFonteEixoY: TBitBtnLocked;
    btnLimpaFonteEixoX: TBitBtnLocked;
    cmbPosTit: TComboBoxFocus;
    Label47: TLabel;
    cmbPosLeg: TComboBoxFocus;
    cmbAliTit: TComboBoxFocus;
    Label46: TLabel;
    cmbAliLeg: TComboBoxFocus;
    GroupBox9: TGroupBox;
    Label41: TLabel;
    cmbValCap: TComboBoxFocus;
    GroupBox11: TGroupBox;
    Label54: TLabel;
    cmbLinCap: TComboBoxFocus;
    Label53: TLabel;
    cmbLinSty: TComboBoxFocus;
    DBEditFocus8: TDBEditFocus;
    Label55: TLabel;
    Label56: TLabel;
    cmbMarSty: TComboBoxFocus;
    Label57: TLabel;
    DBEditFocus10: TDBEditFocus;
    GroupBox10: TGroupBox;
    Label58: TLabel;
    DBEditFocus11: TDBEditFocus;
    bntCorMoldura: TcxDBColorComboBox;
    Label59: TLabel;
    Label60: TLabel;
    DBEditFocus12: TDBEditFocus;
    DBCheckBox13: TDBCheckBox;
    Label61: TLabel;
    dbeFonCap: TDBEditFocus;
    btnSetaFonteCaptions: TBitBtnLocked;
    btnLimpaFonteCaptions: TBitBtnLocked;
    GroupBox12: TGroupBox;
    Label62: TLabel;
    Label63: TLabel;
    cmbPieCap: TComboBoxFocus;
    dbeSITCAP: TDBEditFocus;
    btnFonteTitutoSerieTorta: TBitBtnLocked;
    btnLimpaFonteTitutoSerieTorta: TBitBtnLocked;
    Label64: TLabel;
    btnSetaCorFundoTituloSerie: TcxDBColorComboBox;
    DBCheckBox14: TDBCheckBox;
    DBCheckBox15: TDBCheckBox;
    Label65: TLabel;
    DBEditFocus13: TDBEditFocus;
    GroupBox13: TGroupBox;
    DBCheckBox16: TDBCheckBox;
    DBCheckBox17: TDBCheckBox;
    DBCheckBox18: TDBCheckBox;
    btnLayGra: TBitBtnLocked;
    Label68: TLabel;
    dbeTemRef: TDBEditFocus;
    Label69: TLabel;
    DBEditFocus20: TDBEditFocus;
    GroupBox14: TGroupBox;
    Label66: TLabel;
    Label67: TLabel;
    DBEditFocus14: TDBEditFocus;
    dbeLINGRA: TDBEditFocus;
    edtNumGra: TEdit;
    dbeInfCol: TDBCheckBox;
    cxvColunasPorLinha: TcxGridDBTableView;
    cxgColunasPorLinhaLevel1: TcxGridLevel;
    cxgColunasPorLinha: TcxGrid;
    cxvColunasPorLinhaNROLIN: TcxGridDBColumn;
    cxvColunasPorLinhaQTDCOL: TcxGridDBColumn;
    DBCheckBox19: TDBCheckBox;
    chkConInd: TDBCheckBox;
    dbeCamAut: TDBCheckBox;
    cxvCamposSUBGRU: TcxGridDBColumn;
    dbeSTRHED: TDBCheckBox;
    cxvParamsGATPER: TcxGridDBColumn;
    cxvParamsPARFIN: TcxGridDBColumn;
    tbsRodape: TTabSheet;
    pnlConfRodapeCabec: TPanel;
    pnlConfRodape: TPanel;
    bdeLAYROD: TDBRadioGroup;
    pnlTituloRodapeGrid: TPanel;
    pnlDadosRodapeGrid: TPanel;
    Panel33: TPanel;
    btnExcluiRodape: TBitBtnLocked;
    GroupBox15: TGroupBox;
    btnIncRod: TBitBtnLocked;
    btnDecRod: TBitBtnLocked;
    cxvRodapeGrid: TcxGridDBTableView;
    cxgRodapeGridLevel1: TcxGridLevel;
    cxgRodapeGrid: TcxGrid;
    cxvRodapeGridColumn1: TcxGridDBColumn;
    cxvRodapeGridDESCAM: TcxGridDBColumn;
    cxvRodapeGridLARGUR: TcxGridDBColumn;
    cxvRodapeGridNOVROD: TcxGridDBColumn;
    cxvRodapeGridColumn5: TcxGridDBColumn;
    dbeALIROD: TDBRadioGroup;
    pnlDadosComumRodapeGrid: TPanel;
    Label70: TLabel;
    btnIncRodape: TBitBtnLocked;
    cxlCampos: TcxLookupComboBox;
    pnlRodapeDetalhado: TPanel;
    Label71: TLabel;
    cxvRodapeGridColumn2: TcxGridDBColumn;
    cxvRodapeGridPOSREL: TcxGridDBColumn;
    cxvRodapeGridREFROD: TcxGridDBColumn;
    cxlCampoReferenciaRodape: TcxLookupComboBox;
    rdgPOSREL: TRadioGroup;
    GroupBox16: TGroupBox;
    BitBtnLocked1: TBitBtnLocked;
    BitBtnLocked2: TBitBtnLocked;
    tbsDashboard: TTabSheet;
    dbeCorZeb: TcxDBColorComboBox;
    grbModelo: TGroupBox;
    Label3: TLabel;
    dbeCodMod: TDBEditFocus;
    edtModDes: TEditFocus;
    DBCheckBox4: TDBCheckBox;
    dbeOMITOT: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    dbeExDtHr: TDBCheckBox;
    dbeEXLIBR: TDBCheckBox;
    dbeNLTITB: TDBCheckBox;
    dbeGRUVER: TDBCheckBox;
    chkApePri: TCheckBox;
    DBCheckBox21: TDBCheckBox;
    DBCheckBox23: TDBCheckBox;
    Panel30: TPanel;
    dbePasSai: TDBCheckBox;
    dbeGatInf: TDBCheckBox;
    DBCheckBox22: TDBCheckBox;
    pnlDashboard: TPanel;
    Label15: TLabel;
    DBCheckBox24: TDBCheckBox;
    tbsRotinas: TTabSheet;
    cxStyle5: TcxStyle;
    pnlRotinas: TPanel;
    pnlBotoesGrid: TPanel;
    cxgBotGrid: TcxGrid;
    cxvBotGrid: TcxGridDBBandedTableView;
    cxvBotGridCAMROT: TcxGridDBBandedColumn;
    cxvBotGridDESROT: TcxGridDBBandedColumn;
    cxvBotGridColumn1: TcxGridDBBandedColumn;
    cxvBotGridColumnTeclaAtalho: TcxGridDBBandedColumn;
    cxgBotGridLevel1: TcxGridLevel;
    pnlInlcuiRotina: TPanel;
    btnIncRotGrid: TBitBtnLocked;
    cxlRotinaGrid: TcxLookupComboBox;
    pnlExcluiRotina: TPanel;
    btnExcluiBotaoGrid: TBitBtnLocked;
    Panel31: TPanel;
    Panel32: TPanel;
    lblCodRelGrid: TLabel;
    edtCodRelGrid: TEditFocus;
    edtCodRelGridDes: TEditFocus;
    lblRotinaGrid: TLabel;
    cxvBotGridColumn4: TcxGridDBBandedColumn;
    cxvBotGridColumn5: TcxGridDBBandedColumn;
    Panel34: TPanel;
    edtTitBotGrid: TEditFocus;
    Label79: TLabel;
    GroupBox20: TGroupBox;
    btnIncBotGrid: TBitBtnLocked;
    btnDecBotGrid: TBitBtnLocked;
    pnlBotoesTelaFiltros: TPanel;
    cxgBotFil: TcxGrid;
    cxvBotFil: TcxGridDBBandedTableView;
    cxGridDBBandedColumn1: TcxGridDBBandedColumn;
    cxvBotFilDESROT: TcxGridDBBandedColumn;
    cxvBotFilTeclaAtalho: TcxGridDBBandedColumn;
    cxvCodFilTITBOT: TcxGridDBBandedColumn;
    cxvCodFiEXEDIR: TcxGridDBBandedColumn;
    cxvCodFilCOPPAI: TcxGridDBBandedColumn;
    cxGridLevel6: TcxGridLevel;
    Panel35: TPanel;
    lblRotinaFil: TLabel;
    btnIncRotFil: TBitBtnLocked;
    cxlRotinaFil: TcxLookupComboBox;
    Panel36: TPanel;
    btnExcluiBotaoFil: TBitBtnLocked;
    GroupBox21: TGroupBox;
    btnIncBotFiltro: TBitBtnLocked;
    btnDecBotFiltro: TBitBtnLocked;
    Panel37: TPanel;
    Panel38: TPanel;
    lblCodRelFil: TLabel;
    edtCodRelFil: TEditFocus;
    edtCodRelFilDes: TEditFocus;
    Panel39: TPanel;
    Label81: TLabel;
    edtTitBotFil: TEditFocus;
    chkCopValFil: TCheckBox;
    chkExeDirFil: TCheckBox;
    Label75: TLabel;
    cmbTipChaFil: TComboBoxFocus;
    chkCopValGrid: TCheckBox;
    chkExeDirGrid: TCheckBox;
    Label82: TLabel;
    cmbTipChaGrid: TComboBoxFocus;
    cxvBotFilCODREL: TcxGridDBBandedColumn;
    cxvBotGridColumn2: TcxGridDBBandedColumn;
    cxvBotFilMAPPAR: TcxGridDBBandedColumn;
    cxvBotGridMAPPAR: TcxGridDBBandedColumn;
    cxvBotFilORDBOT: TcxGridDBBandedColumn;
    cxvBotGridColumn3: TcxGridDBBandedColumn;
    cxvBotGridCampoRotina: TcxGridDBBandedColumn;
    tbsScriptBeforePost: TTabSheet;
    pnlValidacao: TPanel;
    Panel4: TPanel;
    stmSCRBEF: TfsSyntaxMemo;
    frxAjudaBeforePost: TfrxReport;
    cxvBotGridFecSai: TcxGridDBBandedColumn;
    chkFecSaiGrid: TCheckBox;
    btnAjudaBeforePost: TBitBtnLocked;
    btnCompila: TBitBtnLocked;
    grpConfgsGrid: TGroupBox;
    DBCheckBox25: TDBCheckBox;
    pnlXML: TPanel;
    GroupBox23: TGroupBox;
    DBCheckBox28: TDBCheckBox;
    pnlArqSai: TPanel;
    grbArqSai: TGroupBox;
    lblEncArq: TLabel;
    dbeEncArq: TDBComboBoxFocus;
    chkSanArq: TDBCheckBox;
    tbsXML: TTabSheet;
    Label76: TLabel;
    DBEditFocus19: TDBEditFocus;
    Panel10: TPanel;
    Panel21: TPanel;
    DBMemoFocus1: TDBMemoFocus;
    Label77: TLabel;
    DBEditFocus21: TDBEditFocus;
    tbsExcel: TTabSheet;
    Label74: TLabel;
    cbxTotIni: TComboBoxFocus;
    DBCheckBox26: TDBCheckBox;
    GroupBox19: TGroupBox;
    Label78: TLabel;
    dbeFonTco: TDBEditFocus;
    btnFonTco: TBitBtnLocked;
    btnLimparFonTco: TBitBtnLocked;
    Label80: TLabel;
    dbeFunTco: TcxDBColorComboBox;
    Label83: TLabel;
    DBEditFocus22: TDBEditFocus;
    DBCheckBox27: TDBCheckBox;
    DBCheckBox29: TDBCheckBox;
    rdgPGRCPE: TRadioGroup;
    cxvParamsCNDVIS: TcxGridDBColumn;
    btnRepExp: TBitBtnLocked;
    dbeFr3per: TDBCheckBox;
    DBCheckBox9: TDBCheckBox;
    DBEditFocus23: TDBEditFocus;
    DBEditFocus24: TDBEditFocus;
    btnEstEnt: TBitBtnLocked;
    btnEstEnv: TBitBtnLocked;
    Label84: TLabel;
    Label85: TLabel;
    btnPreCus: TBitBtnLocked;
    grpExportArqPdf: TGroupBox;
    DBCheckBox30: TDBCheckBox;
    DBCheckBox31: TDBCheckBox;
    dbeSEMDAD: TDBCheckBox;
    Label87: TLabel;
    edtAtaRelGrid: TEdit;
    edtAtaRelFil: TEdit;
    Label88: TLabel;
    lblNumCol: TLabel;
    edtNumCol: TSpinEdit;
    Label89: TLabel;
    dbeFilImp: TDBEditFocus;
    dbeCASQUE: TDBCheckBox;
    btnPaginaInicial: TBitBtnLocked;
    Label90: TLabel;
    DBEditFocus25: TDBEditFocus;
    btnDestino: TBitBtnLocked;
    dbeExpAut: TDBCheckBox;
    dbeExcGri: TDBCheckBox;
    cbxTitPos: TComboBoxFocus;
    tbsWhatsApp: TTabSheet;
    grbGatilho: TGroupBox;
    dbeCAMIDT: TDBMemoFocus;
    Panel40: TPanel;
    Label91: TLabel;
    Label92: TLabel;
    dbeWIDDIS: TDBEditFocus;
    dbeWIDTEM: TDBEditFocus;
    Panel42: TPanel;
    edtDescCadFil: TEditFocus;
    Panel41: TPanel;
    GroupBox17: TGroupBox;
    Label73: TLabel;
    dbeLinGraDash: TDBEditFocus;
    cxGrid1: TcxGrid;
    cxvColunasPorLinhaDashboard: TcxGridDBTableView;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    cxvColunasPorLinhaDashboardPROPOR: TcxGridDBColumn;
    cxGridLevel5: TcxGridLevel;
    grpDashWeb: TGroupBox;
    Label86: TLabel;
    DBCheckBox32: TDBCheckBox;
    dbeTempoRefreshWEB: TDBEditFocus;
    GroupBox18: TGroupBox;
    Label72: TLabel;
    Label93: TLabel;
    dbeICOGRA: TDBEditFocus;
    btnIcoGra: TBitBtnLocked;
    dbeSTYLID: TDBEditFocus;
    Panel43: TPanel;
    Panel44: TPanel;
    DBMemoFocus2: TDBMemoFocus;
    lblMarEsq: TLabel;
    edtMarEsq: TSpinEdit;
    lblMarDir: TLabel;
    edtMarDir: TSpinEdit;
    dbeFilLat: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure rdgOrientClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbeCodModKeyPress(Sender: TObject; var Key: Char);
    procedure btnExecutarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
    procedure btnAltFilClick(Sender: TObject);
    procedure cxvCamposEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure btnTesteExeClick(Sender: TObject);
    procedure btnIncMenClick(Sender: TObject);
    procedure btnSalvaBackupClick(Sender: TObject);
    procedure edtCodComKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodComExit(Sender: TObject);
    procedure btnIncComClick(Sender: TObject);
    procedure btnDelComClick(Sender: TObject);
    procedure cxvRelatEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure btnAltCamClick(Sender: TObject);
    procedure cxvCamposFUNCAOPropertiesChange(Sender: TObject);
    procedure dbeCodModExit(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure cxvCamposQUEBRAPropertiesChange(Sender: TObject);
    procedure cbxTipTotClick(Sender: TObject);
    procedure cxvCamposQUEBRACustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgCamposLARGURPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnAjudaClick(Sender: TObject);
    procedure cxvParamsTIPFACPropertiesCloseUp(Sender: TObject);
    procedure cxvCamposTOTALIPropertiesCloseUp(Sender: TObject);
    procedure cxvCamposLISTARPropertiesCloseUp(Sender: TObject);
    procedure cxvCamposLISQUEPropertiesCloseUp(Sender: TObject);
    procedure cxvCamposLINQUEPropertiesCloseUp(Sender: TObject);
    procedure btnOrdCimClick(Sender: TObject);
    procedure btnOrdBaiClick(Sender: TObject);
    procedure btnExcluiGruposClick(Sender: TObject);
    procedure cbxTitQueChange(Sender: TObject);
    procedure cbxFilPriChange(Sender: TObject);
    procedure dbeCOMFILExit(Sender: TObject);
    procedure chkInfHeiClick(Sender: TObject);
    procedure btnCadTemClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bceDefSQLExit(Sender: TObject);
    procedure bceDefSQLKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bceSQLFilExit(Sender: TObject);
    procedure bceSQLFilKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cklDestinClickCheck(Sender: TObject);
    procedure cbxHorizoChange(Sender: TObject);
    procedure tbsCompFiltroCabResize(Sender: TObject);
    procedure btnDelHisClick(Sender: TObject);
    procedure cxvHistoEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure btnAltHisClick(Sender: TObject);
    procedure btnGraHisClick(Sender: TObject);
    procedure btnIncHisClick(Sender: TObject);
    procedure btnCanHisClick(Sender: TObject);
    procedure cxvHistoCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnInsereLoteGrupoClick(Sender: TObject);
    procedure dbeTipFolClick(Sender: TObject);
    procedure dbeCamAutClick(Sender: TObject);
    procedure btnCamAutClick(Sender: TObject);
    procedure tmrRolagemTimer(Sender: TObject);
    procedure edtZooIniExit(Sender: TObject);
    procedure btnAjudaCamposClick(Sender: TObject);
    procedure edtCodChiExit(Sender: TObject);
    procedure edtCodChiKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncChiClick(Sender: TObject);
    procedure cxvChirelEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure btnDelChiClick(Sender: TObject);
    procedure cxvChirelNomCamPropertiesCloseUp(Sender: TObject);
    procedure cxvCamposCNDVISCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnIncDirClick(Sender: TObject);
    procedure edtCodDirExit(Sender: TObject);
    procedure edtCodDirKeyPress(Sender: TObject; var Key: Char);
    procedure cxvDirRelEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure btnDelDirClick(Sender: TObject);
    procedure btnRepFonClick(Sender: TObject);
    procedure btnDelFonClick(Sender: TObject);
    procedure dbeCodPaiKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodValKeyPress(Sender: TObject; var Key: Char);
    procedure btnInventarioClick(Sender: TObject);
    procedure btnLoteClick(Sender: TObject);
    procedure btnSalInvClick(Sender: TObject);
    procedure btnCtrClick(Sender: TObject);
    procedure btnEstExtClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSetaFonteClick(Sender: TObject);
    procedure btnSetFonteLegendaClick(Sender: TObject);
    procedure btnFonteEixoYClick(Sender: TObject);
    procedure btnFonteEixoXClick(Sender: TObject);
    procedure btnLimpaFonteClick(Sender: TObject);
    procedure btnLimpaFonteLegendaClick(Sender: TObject);
    procedure btnLimpaFonteEixoYClick(Sender: TObject);
    procedure btnLimpaFonteEixoXClick(Sender: TObject);
    procedure btnSetaFonteCaptionsClick(Sender: TObject);
    procedure btnLimpaFonteCaptionsClick(Sender: TObject);
    procedure btnFonteTitutoSerieTortaClick(Sender: TObject);
    procedure btnLimpaFonteTitutoSerieTortaClick(Sender: TObject);
    procedure btnLayGraClick(Sender: TObject);
    procedure dbeGatInfClick(Sender: TObject);
    procedure DBEditFocus14KeyPress(Sender: TObject; var Key: Char);
    procedure dbeLINGRAKeyPress(Sender: TObject; var Key: Char);
    procedure dbeInfColClick(Sender: TObject);
    procedure dbeLINGRAExit(Sender: TObject);
    procedure chkConIndClick(Sender: TObject);
    procedure btnIncRodapeClick(Sender: TObject);
    procedure btnExcluiRodapeClick(Sender: TObject);
    procedure cxvRodapeGridLARGURPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnDecRodClick(Sender: TObject);
    procedure btnIncRodClick(Sender: TObject);
    procedure dbeALIRODChange(Sender: TObject);
    procedure cxvRodapeGridCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure BitBtnLocked2Click(Sender: TObject);
    procedure BitBtnLocked1Click(Sender: TObject);
    procedure dbeLinGraDashExit(Sender: TObject);
    procedure cxvColunasPorLinhaDashboardPROPORPropertiesValidate(
      Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure btnIcoGraClick(Sender: TObject);
    procedure cbxTotIniChange(Sender: TObject);
    procedure btnExcluiBotaoGridClick(Sender: TObject);
    procedure btnIncRotGridClick(Sender: TObject);
    procedure edtCodRelGridKeyPress(Sender: TObject; var Key: Char);
    procedure cmbTipChaFilChange(Sender: TObject);
    procedure cmbTipChaGridChange(Sender: TObject);
    procedure btnExcluiBotaoFilClick(Sender: TObject);
    procedure btnIncRotFilClick(Sender: TObject);
    procedure edtCodRelFilKeyPress(Sender: TObject; var Key: Char);
    procedure cxvBotFilMAPPARPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxvBotGridMAPPARPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnDecBotFiltroClick(Sender: TObject);
    procedure btnIncBotFiltroClick(Sender: TObject);
    procedure btnDecBotGridClick(Sender: TObject);
    procedure btnIncBotGridClick(Sender: TObject);
    procedure cxvBotGridCampoRotinaPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnAjudaBeforePostClick(Sender: TObject);
    procedure btnCompilaClick(Sender: TObject);
    procedure cxvBotGridFecSaiPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnFonTcoClick(Sender: TObject);
    procedure btnLimparFonTcoClick(Sender: TObject);
    procedure rdgPGRCPEClick(Sender: TObject);
    procedure dbePasSaiClick(Sender: TObject);
    procedure cxvParamsCNDVISCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnRepExpClick(Sender: TObject);
    procedure dbeFr3perClick(Sender: TObject);
    procedure pVerificaFR3Personalizado;
    procedure btnEstEntClick(Sender: TObject);
    procedure btnEstEnvClick(Sender: TObject);
    procedure btnPreCusClick(Sender: TObject);
    procedure edtAtaRelGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtAtaRelFilKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtNumColExit(Sender: TObject);
    procedure btnPaginaInicialClick(Sender: TObject);
    procedure btnDestinoClick(Sender: TObject);
    procedure cbxTitPosChange(Sender: TObject);
    procedure dbeWIDDISKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarEsqExit(Sender: TObject);
    procedure edtMarDirExit(Sender: TObject);
  private
    { Private declarations }
    objRelatorio: TRelatorio;

    FGravandoAtualizaSQL,
    FGravandoEditorToTabela,
    FGravando: TfrmGravando;

    blnCancelouPeloClose,
    blnPodeAlterarPadrao,
    blnNoBotaoIncluir,
    blnDestinoDashboard: Boolean;

    procedure pSetaDestinos;
    procedure pDestinosToCampo;
    procedure pCampoToDestino;

    Procedure pAjustaSplit;

    Function fValidaTipoChamadaFiltro: Boolean;
    Function fValidaTipoChamadaGrid: Boolean;

    procedure pLimpaDadosBotaoFiltro;
    procedure pLimpaDadosBotaoGrid;

    procedure pHabilitaTela(blnHabilita: Boolean);
    procedure pAfterPostCampos(dataSet: TDataSet);
    procedure pAfterScrollCampos(dataSet: TDataSet);

    procedure  pAfterPostParams(dataSet: TDataSet);

    procedure pAjustaModelo;

    procedure pInicializaQTDCOLTXT;

    Function fCarregaDadosPrg(prgProgresso: TcxProgressBar): Boolean;
    procedure pCarregaDados;

    Procedure pCarregaDadosGrafico;
    Procedure pSalvaDadosGrafico;

    Function fAtualizaSQLPrg(prgProgresso: TcxProgressBar): Boolean;
    procedure pAtualizaSQL;

    Function fAtualizaLarguraMaxima: Boolean;
    Procedure pCarregaDadosCadRel;
    procedure pAcertaAlturaPaineis;
    procedure pHabilitaPaginas(blnHabilita: Boolean);

    Function fEditorToTabelaPrg(prgProgresso: TcxProgressBar): Boolean;
    procedure pEditorToTabela;

    Procedure pInciaRelatorio;

    procedure pFiltraGrupo;

    procedure pAjustaInfHei;

    procedure pAjustaTipoChamadaFil;
    procedure pAjustaTipoChamadaGrid;

    Function fGeraFrx(blnGravar: Boolean = False): Boolean;
    procedure pOperacaoHistorico(strOperacao: string);
    procedure pAjustaTipFol;

    Function fMaisDeUmDestino: Boolean;
    Function fMarcouTipoGrafico: Boolean;
    Function fTemComplementoNaoGrafico: Boolean;
    Function fEhRelatorioGrafico(strCodRel: String): Boolean;

    Function fTiraLinhasComentario(strSQL: String): String;

    Function fGetCursorPosX: Word;

    procedure pAjustaDestino;

    procedure pAjustaDestinoMarcado(desDestino: TDestinoRel);

    Function fArquivoTXTMarcado: Boolean;
    Function fArquivoXMLMarcado: Boolean;

    Function fDestinoMarcado(desDestino: TDestinoRel): Boolean;

    procedure pAjustaNumeroPaginas;

    procedure pAjustaTipoAlinhamentoRodape;
    procedure pCarrregaCampoRodape;

    Function fTemDestinoGraficoDashboard: Boolean;

    Function fCompilaScript(blnDarMensagem: Boolean): Boolean;
    Function fVerificaSeRelatorioEstaNosGatilhos: Boolean;

    procedure pAjustaConfiguracoesWhatsapp;
  public
    { Public declarations }

    objRelMenu: TRelatorio;

    frmFormMenu: TForm;
    mnuAutcom: TAdvMainMenu;

  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples, untConsultas, untTypesSistema,
  StrUtils, untInterfaceRelatorio, untGeraFr3, untAjudaVariaveis,
  untPrincipal, untFuncoes, untCadTemplates, untFuncoesHash,
  untFuncoesGenerica,
  untDefinePosicaoGrafico, untZClient,
  untAjudaCampos, untSelIcon,
  untMapeiaParametrosEdicao,
  untCamposRotina,
  untPascalScriptRelatorio,
  untGraficosDashboard;

procedure TfrmCadRelatorios.btnTesteExeClick(Sender: TObject);
begin
  inherited;

  TRelatorio.pExecutaRelatorio(dbeCodigo.Text);
end;

procedure TfrmCadRelatorios.bceDefSQLExit(Sender: TObject);
begin
  inherited;

  If btnCancela.focused Then
    Exit;

  If btnAjuda.focused Then
    Exit;

  If btnCadTem.focused Then
    Exit;

  If btnCamAut.focused Then
    Exit;

  If btnGravar.focused Then
    Exit;

  If btnExecutar.focused Then
    Exit;

  If objRelatorio.objInterface.blnCarregarCamposAuto Then
    pAtualizaSQL;

  If objRelatorio.objInterface.blnSQLErro Then
  Begin
    pSetFocus(bceDEFSQL);
  End;

end;

procedure TfrmCadRelatorios.bceDefSQLKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
Var
  strTexto: String;
begin
  inherited;

  If (Shift = [ssCtrl]) Then
  Begin
    Case Key Of
      VK_F7: Begin
                strTexto := TInterfaceRelatorio.fGetSimbolAtCursor(bceDEFSQL);

                if objRelatorio.objInterface.cdsParams.Locate('PAR_NOMPAR', strTexto, []) then
                begin
                  objRelatorio.objInterface.pPedeDadosInterface;
                end
             End;

      VK_F8: Begin
                strTexto := TInterfaceRelatorio.fGetSimbolAtCursor(bceDEFSQL);

                if objRelatorio.objInterface.cdsCampos.Locate('CAM_NOMCAM', strTexto, []) then
                  objRelatorio.objInterface.pPedeDadosCampo(blnDestinoDashboard)
             End;

    End;
  End
  Else If (ssAlt In Shift) And (Key = 193) Then
  begin
    TInterfaceRelatorio.fGetTemplateSQLToMemo(Self, bceDEFSQL);

    Key := 0;
  end
  Else
  Begin
    Case Key Of
      VK_F6: TInterfaceRelatorio.pMostraTemplateMemo(bceDEFSQL);
    End;
  End;

end;

procedure TfrmCadRelatorios.bceSQLFilExit(Sender: TObject);
begin
  inherited;

  If btnCancela.focused Then
    Exit;

  If objRelatorio.objInterface.blnCarregarCamposAuto Then
    pEditorToTabela;

  objRelatorio.objInterface.strSQLFil := AnsiReplaceStr(qryTabela.FieldByName('REL_SQLFIL').AsString, '<<csq>>', #13#10);

  If objRelatorio.objInterface.blnSQLErro Then
  Begin
    pSetFocus(bceSQLFil);
  End;
end;

procedure TfrmCadRelatorios.bceSQLFilKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F6: TInterfaceRelatorio.pMostraTemplateMemo(bceSQLFil);
  End;

  If (ssAlt In Shift) And (Key = 193) Then
  begin
    TInterfaceRelatorio.fGetTemplateSQLToMemo(Self, bceSQLFil);

    Key := 0;
  end

end;

procedure TfrmCadRelatorios.BitBtnLocked1Click(Sender: TObject);
begin
  inherited;
  objRelatorio.objInterface.pIncOrdemComplementar(cxvRelat);
end;

procedure TfrmCadRelatorios.BitBtnLocked2Click(Sender: TObject);
begin
  inherited;
  objRelatorio.objInterface.pDecOrdemComplementar(cxvRelat);
end;

procedure TfrmCadRelatorios.btnAjudaBeforePostClick(Sender: TObject);
begin
  inherited;
  pPreviewReport(Self.Name, Self.Caption, frxAjudaBeforePost);
end;

procedure TfrmCadRelatorios.btnIncRodapeClick(Sender: TObject);
begin
  inherited;

  If Assigned(objRelatorio) And (Not VarToStr(cxlCampos.EditValue).IsEmpty) Then
    objRelatorio.objInterface.pIncluiCampoRodape(VarToStr(cxlCampos.EditValue), VarToStr(cxlCampoReferenciaRodape.EditValue), rdgPOSREL.ItemIndex);

  cxlCampos.ClearSelection;
  cxlCampoReferenciaRodape.ClearSelection;
end;

procedure TfrmCadRelatorios.btnIncRodClick(Sender: TObject);
begin
  inherited;
  objRelatorio.objInterface.pIncOrdemRodape(cxvRodapeGrid);
end;

procedure TfrmCadRelatorios.btnLimpaFonteTitutoSerieTortaClick(Sender: TObject);
begin
  inherited;
  dtsCadRel.dataSet.FieldByName('REL_SITCAT').Clear;
end;

procedure TfrmCadRelatorios.btnLimparFonTcoClick(Sender: TObject);
begin
  inherited;
  dtsCadRel.dataSet.FieldByName('REL_FONTCO').Clear;
end;

procedure TfrmCadRelatorios.btnSetFonteLegendaClick(Sender: TObject);
var
  fntDialog: TFontDialog;
begin
  inherited;

  fntDialog := TFontDialog.Create(nil);
  try
    if not fEmptyStr(dtsCadRel.dataSet.FieldByName('REL_FONLEG').AsString) then
      fntDialog.Font :=  TInterfaceRelatorio.StrToFont(dtsCadRel.dataSet.FieldByName('REL_FONLEG').AsString);
    if fntDialog.Execute then
      dtsCadRel.dataSet.FieldByName('REL_FONLEG').AsString :=  TInterfaceRelatorio.FontToStr(fntDialog.Font);
  finally
    FreeAndNil(fntDialog);
  end;
end;

procedure TfrmCadRelatorios.btnFonteEixoYClick(Sender: TObject);
var
  fntDialog: TFontDialog;
begin
  inherited;

  fntDialog := TFontDialog.Create(nil);
  try
    if not fEmptyStr(dtsCadRel.dataSet.FieldByName('REL_VALFON').AsString) then
      fntDialog.Font :=  TInterfaceRelatorio.StrToFont(dtsCadRel.dataSet.FieldByName('REL_VALFON').AsString);
    if fntDialog.Execute then
      dtsCadRel.dataSet.FieldByName('REL_VALFON').AsString :=  TInterfaceRelatorio.FontToStr(fntDialog.Font);
  finally
    FreeAndNil(fntDialog);
  end;
end;

procedure TfrmCadRelatorios.btnFonTcoClick(Sender: TObject);
var
  fntDialog: TFontDialog;
begin
  inherited;

  fntDialog := TFontDialog.Create(nil);
  try
    if not fEmptyStr(dtsCadRel.dataSet.FieldByName('REL_FONTCO').AsString) then
      fntDialog.Font :=  TInterfaceRelatorio.StrToFont(dtsCadRel.dataSet.FieldByName('REL_FONTCO').AsString);
    if fntDialog.Execute then
      dtsCadRel.dataSet.FieldByName('REL_FONTCO').AsString :=  TInterfaceRelatorio.FontToStr(fntDialog.Font);
  finally
    FreeAndNil(fntDialog);
  end;
end;

procedure TfrmCadRelatorios.btnFonteEixoXClick(Sender: TObject);
var
  fntDialog: TFontDialog;
begin
  inherited;

  fntDialog := TFontDialog.Create(nil);
  try
    if not fEmptyStr(dtsCadRel.dataSet.FieldByName('REL_CATFON').AsString) then
      fntDialog.Font :=  TInterfaceRelatorio.StrToFont(dtsCadRel.dataSet.FieldByName('REL_CATFON').AsString);
    if fntDialog.Execute then
      dtsCadRel.dataSet.FieldByName('REL_CATFON').AsString :=  TInterfaceRelatorio.FontToStr(fntDialog.Font);
  finally
    FreeAndNil(fntDialog);
  end;

end;

procedure TfrmCadRelatorios.btnLimpaFonteLegendaClick(Sender: TObject);
begin
  inherited;

  dtsCadRel.dataSet.FieldByName('REL_FONLEG').Clear;
end;

procedure TfrmCadRelatorios.btnLimpaFonteEixoYClick(Sender: TObject);
begin
  inherited;

  dtsCadRel.dataSet.FieldByName('REL_VALFON').Clear;
end;

procedure TfrmCadRelatorios.btnLimpaFonteEixoXClick(Sender: TObject);
begin
  inherited;

  dtsCadRel.dataSet.FieldByName('REL_CATFON').Clear;
end;

procedure TfrmCadRelatorios.btnSetaFonteCaptionsClick(Sender: TObject);
var
  fntDialog: TFontDialog;
begin
  inherited;

  fntDialog := TFontDialog.Create(nil);
  try
    if not fEmptyStr(dtsCadRel.dataSet.FieldByName('REL_FONCAP').AsString) then
      fntDialog.Font :=  TInterfaceRelatorio.StrToFont(dtsCadRel.dataSet.FieldByName('REL_FONCAP').AsString);
    if fntDialog.Execute then
      dtsCadRel.dataSet.FieldByName('REL_FONCAP').AsString :=  TInterfaceRelatorio.FontToStr(fntDialog.Font);
  finally
    FreeAndNil(fntDialog);
  end;
end;

procedure TfrmCadRelatorios.btnLimpaFonteCaptionsClick(Sender: TObject);
begin
  inherited;
  dtsCadRel.dataSet.FieldByName('REL_FONCAP').Clear;
end;

procedure TfrmCadRelatorios.btnFonteTitutoSerieTortaClick(Sender: TObject);
var
  fntDialog: TFontDialog;
begin
  inherited;

  fntDialog := TFontDialog.Create(nil);
  try
    if not fEmptyStr(dtsCadRel.dataSet.FieldByName('REL_SITCAP').AsString) then
      fntDialog.Font :=  TInterfaceRelatorio.StrToFont(dtsCadRel.dataSet.FieldByName('REL_SITCAP').AsString);
    if fntDialog.Execute then
      dtsCadRel.dataSet.FieldByName('REL_SITCAP').AsString :=  TInterfaceRelatorio.FontToStr(fntDialog.Font);
  finally
    FreeAndNil(fntDialog);
  end;
end;

procedure TfrmCadRelatorios.dbeCodValKeyPress(Sender: TObject; var Key: Char);
  Var
    arrRelatorios: TConsultasArray;
begin
  inherited;

  If fPesqRelatorio(Self, dbeCodVal, edtDesCodVal, Nil, False, '', Key, arrRelatorios) And
     fValidaCampos(dbeCodVal) Then
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmCadRelatorios.btnInsereLoteGrupoClick(Sender: TObject);
begin
  inherited;
  if objRelatorio.objInterface.fInsereLoteNovoGrupo then
    pSetFocus(edtNovGru);
end;

procedure TfrmCadRelatorios.btnInventarioClick(Sender: TObject);
begin
  inherited;

  objRelatorio.objInterface.pPedeDadosParametrosAutomaticos('INVENTARIO');
end;

procedure TfrmCadRelatorios.btnLayGraClick(Sender: TObject);
  Var
    frmDefinePosicaoGrafico: TfrmDefinePosicaoGrafico;
begin
  inherited;

  Try
    pCriarFormularios(TfrmDefinePosicaoGrafico, frmDefinePosicaoGrafico);

    frmDefinePosicaoGrafico.objGeraFr3 := objRelatorio.objGeraFr3;
    frmDefinePosicaoGrafico.intMoldura := qryTabela.FieldByName('REL_WIDMOL').AsInteger;
    frmDefinePosicaoGrafico.intLinhas  := qryTabela.FieldByName('REL_LINGRA').AsInteger;
    frmDefinePosicaoGrafico.intColunas := qryTabela.FieldByName('REL_COLGRA').AsInteger;
    frmDefinePosicaoGrafico.intGraficos := strtointDef(edtNumGra.Text, 1);

    If frmDefinePosicaoGrafico.ShowModal = mrOk Then ;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TInterfaceRelatorio.btnLayGraClick]');
    End;
  End;

  pFreeAndNil(frmDefinePosicaoGrafico);
end;

procedure TfrmCadRelatorios.btnLimpaFonteClick(Sender: TObject);
begin
  inherited;

  dtsCadRel.dataSet.FieldByName('REL_FONTIT').Clear;
end;

procedure TfrmCadRelatorios.btnLoteClick(Sender: TObject);
begin
  inherited;

  objRelatorio.objInterface.pPedeDadosParametrosAutomaticos('LOTES');
end;

procedure TfrmCadRelatorios.btnAjudaCamposClick(Sender: TObject);
begin
  inherited;
  pCriarForm(TfrmAjudaCampos);
end;

procedure TfrmCadRelatorios.btnAjudaClick(Sender: TObject);
begin
  inherited;

  pCriarForm(TfrmAjudaVariaveis);

  pSetFocus(bceDEFSQL);
end;

procedure TfrmCadRelatorios.btnAltCamClick(Sender: TObject);
begin
  inherited;

  objRelatorio.objInterface.pPedeDadosCampo(blnDestinoDashboard);
end;

procedure TfrmCadRelatorios.btnAltHisClick(Sender: TObject);
begin
  inherited;

  if (not cxvHisto.DataController.DataSource.DataSet.IsEmpty) then
    if not fEmptyStr(edtTitHis.Text) then
      pOperacaoHistorico('alterar');
end;

procedure TfrmCadRelatorios.btnAlterarClick(Sender: TObject);
begin
  If Not Assigned(objRelatorio) Then
    Exit;

  If (Not blnPodeAlterarPadrao) And
     SameText(qryTabela.FieldByName('REL_PADRAO').AsString, 'S') Then
  Begin
    pMensagemOk('Esse é um relatório padrão e não pode ser alterado.' +#13#10 +
                'É possível criar um novo relatório a partir desse' + #13#10 +
                'cliclando em "Duplicar Relatório".');
    Exit;
  End;

  inherited;


  If qryTabela.State = dsEdit Then
  Begin
    pHabilitaCodigo(dbeCodigo, dbeDescri, False);

    If objRelatorio.objInterface.blnCarregarCamposAuto Then
      pCarregaDados;

    pHabilitaPaginas(objRelatorio.objGeraFr3.blnCarregouPagina);

    pHabilitaTela(True);

    pAjustaSplit;

    cbxHorizoChange(Nil);

    objRelatorio.objRotinasFiltro.blnPaiEmEdicao := True;
    objRelatorio.objRotinasGrid.blnPaiEmEdicao := True;

    pVerificaFR3Personalizado;
  End;
end;

procedure TfrmCadRelatorios.pHabilitaTela(blnHabilita: Boolean);
Begin
  grbJato.Enabled         := blnHabilita;
  rdgPGRCPE.Enabled       := blnHabilita;

  cxvParams.OptionsData.Editing := blnHabilita;

  cxvCampos.OptionsData.Editing := blnHabilita;

  btnAltFil.Enabled       := blnHabilita;
  btnAltCam.Enabled       := blnHabilita;
  btnDelCom.Enabled       := blnHabilita;
  btnDelChi.Enabled       := blnHabilita;
  btnDelDir.Enabled       := blnHabilita;
  cbxTipTot.Enabled       := blnHabilita;
  cbxTitQue.Enabled       := blnHabilita;
  cbxTotIni.Enabled       := blnHabilita;
  cbxFilPri.Enabled       := blnHabilita;
  cbxTitPos.Enabled       := blnHabilita;

  cxvGruposPar.OptionsData.Editing := blnHabilita;
  cxvGruposCam.OptionsData.Editing := blnHabilita;

  pnlGruposPar.Enabled    := blnHabilita;
  pnlGruCam.Enabled       := blnHabilita;
  pnlInterGrafica.Enabled := blnHabilita;

  bceDefSQL.ReadOnly := Not blnHabilita;
  bceSQLFil.ReadOnly := Not blnHabilita;

  cklDestin.Enabled       := blnHabilita;
  cbxHorizo.Enabled       := blnHabilita;
  dbeMaxCol.Enabled       := blnHabilita;
  btnRepFon.Enabled       := blnHabilita;
  btnRepExp.Enabled       := blnHabilita;
  btnDelFon.Enabled       := blnHabilita;

  btnIncHis.Enabled       := blnHabilita;
  btnAltHis.Enabled       := blnHabilita;
  btnDelHis.Enabled       := blnHabilita;
  cxgHisto.Enabled        := blnHabilita;

  btnCanHis.Enabled       := False;
  btnGraHis.Enabled       := False;
  edtTitHis.Enabled       := False;
  edtDesHis.Enabled       := False;

  edtZooIni.Enabled       := blnHabilita;
  dbeCorZeb.Enabled       := blnHabilita;
  chkApePri.Enabled       := blnHabilita;
  edtNumCol.Enabled       := blnHabilita;

  edtMarEsq.Enabled       := blnHabilita;
  edtMarDir.Enabled       := blnHabilita;

  edtTitHis.Text := '';
  edtDesHis.Lines.Clear;
  btnInsereLoteGrupo.Enabled := blnHabilita;

  btnSetaFonte.Enabled := blnHabilita;
  btnLimpaFonte.Enabled := blnHabilita;
  btnSetFonteLegenda.Enabled := blnHabilita;
  btnLimpaFonteLegenda.Enabled := blnHabilita;
  btnSetaCorLegendaFundo.Enabled := blnHabilita;
  btnFonteEixoY.Enabled := blnHabilita;
  btnLimpaFonteEixoY.Enabled := blnHabilita;
  btnFonteEixoX.Enabled := blnHabilita;
  btnLimpaFonteEixoX.Enabled := blnHabilita;
  btnFonteTitutoSerieTorta.Enabled := blnHabilita;
  btnLimpaFonteTitutoSerieTorta.Enabled := blnHabilita;
  btnSetaCorFundoTituloSerie.Enabled := blnHabilita;
  bntCorMoldura.Enabled := blnHabilita;
  btnSetaFonteCaptions.Enabled := blnHabilita;
  btnLimpaFonteCaptions.Enabled := blnHabilita;

  cxgColunasPorLinha.Enabled := blnHabilita;

  pnlConfRodapeCabec.Enabled := blnHabilita;

  pnlRodapeFiltros.Enabled := blnHabilita;
  pnlRodapeComplementares.Enabled := blnHabilita;

  pnlDashboard.Enabled := blnHabilita;

  pnlRotinas.Enabled := blnHabilita;

  stmSCRBEF.ReadOnly := Not blnHabilita;

  if blnHabilita then
    pAjustaTipFol;
End;

procedure TfrmCadRelatorios.btnAltFilClick(Sender: TObject);
begin
  inherited;

  objRelatorio.objInterface.pPedeDadosInterface;
end;

procedure TfrmCadRelatorios.btnCadTemClick(Sender: TObject);
begin
  inherited;

  pCriarForm(TfrmCadTemplates);

  pSetFocus(bceDEFSQL);
end;

procedure TfrmCadRelatorios.btnCamAutClick(Sender: TObject);
begin
  inherited;

  pAtualizaSQL;

  objRelatorio.objInterface.pAtualizaCamposParametros;
end;

procedure TfrmCadRelatorios.btnCancelaClick(Sender: TObject);
begin
  If (Not blnCancelouNaBuscaPorChave) And (Not blnCancelouPeloClose) And (Not fPergunta('Deseja cancelar a edição do relatório?')) Then
    Exit;

  inherited;

  pCarregaDados;

  pHabilitaTela(False);

  objRelatorio.objRotinasFiltro.blnPaiEmEdicao := False;
  objRelatorio.objRotinasGrid.blnPaiEmEdicao := False;
end;

procedure TfrmCadRelatorios.btnCanHisClick(Sender: TObject);
begin
  inherited;

  if btnIncHis.Tag = 1 then
  begin
    edtTitHis.Clear;
    edtDesHis.Clear;
  end
  else
  begin
    edtTitHis.Text := cxvHisto.DataController.DataSource.DataSet.FieldByName('HIS_TITULO').AsString;
    edtDesHis.Text := AnsiReplaceStr(cxvHisto.DataController.DataSource.DataSet.FieldByName('HIS_DESCRI').AsString, '<<csq>>', #13#10);
  end;

  pOperacaoHistorico('cancelar');
end;

procedure TfrmCadRelatorios.btnCompilaClick(Sender: TObject);
begin
  inherited;

  fCompilaScript(True);
end;

Function TfrmCadRelatorios.fCompilaScript(blnDarMensagem: Boolean): Boolean;
Var
    intLinhaErro, intColunaErro: Integer;
begin
  Result := True;

  If fEmptyStr(stmSCRBEF.Lines.Text) Then
    Exit;

  If TPascalScriptRelatorio.fCompila(stmSCRBEF.Lines.Text, tscBeforePost, intLinhaErro, intColunaErro) Then
  Begin
    If blnDarMensagem Then
      pMensagemOk('Script compilado com sucesso!')
  End Else
  Begin
    Result := False;
    pgcDados.ActivePage := tbsScriptBeforePost;
    pSetFocus(stmSCRBEF);
    stmSCRBEF.SetPos(intColunaErro,  intLinhaErro);
  End;
end;

procedure TfrmCadRelatorios.btnCtrClick(Sender: TObject);
begin
  inherited;

  objRelatorio.objInterface.pPedeDadosParametrosAutomaticos('CTR_');
end;

procedure TfrmCadRelatorios.btnDecBotFiltroClick(Sender: TObject);
begin
  inherited;
  objRelatorio.objRotinasFiltro.pDecOrdemRotina(cxvBotFil);
end;

procedure TfrmCadRelatorios.btnDecBotGridClick(Sender: TObject);
begin
  inherited;
  objRelatorio.objRotinasGrid.pDecOrdemRotina(cxvBotGrid);
end;

procedure TfrmCadRelatorios.btnDecRodClick(Sender: TObject);
begin
  inherited;
  objRelatorio.objInterface.pDecOrdemRodape(cxvRodapeGrid);
end;

procedure TfrmCadRelatorios.btnDelChiClick(Sender: TObject);
begin
  inherited;

  If Not btnDelChi.Enabled Then
    Exit;

  objRelatorio.objInterface.fExcluiChild;
end;

procedure TfrmCadRelatorios.btnDelComClick(Sender: TObject);
begin
  inherited;

  If Not btnDelCom.Enabled Then
    Exit;

  objRelatorio.objInterface.fExcluiComplemento;
end;

procedure TfrmCadRelatorios.btnDelDirClick(Sender: TObject);
begin
  inherited;

  If Not btnDelDir.Enabled Then
    Exit;

  objRelatorio.objInterface.fExcluiDirAcesso;
end;

procedure TfrmCadRelatorios.btnDelHisClick(Sender: TObject);
begin
  inherited;
  If Not btnDelHis.Enabled Then
    Exit;

  if not fEmptyStr(edtTitHis.Text) then
    if objRelatorio.objInterface.fExcluiHistorico then
    begin
      edtTitHis.Clear;
      edtDesHis.Clear;
    end;
end;

procedure TfrmCadRelatorios.btnDestinoClick(Sender: TObject);
begin
  inherited;

  objRelatorio.objInterface.pPedeDadosParametrosAutomaticos('DESTINO_REL');
end;

procedure TfrmCadRelatorios.pAtualizaSQL;
Begin
  TfrmGravando.fExecuta(fAtualizaSQLPrg, FGravandoAtualizaSQL, '', False);
End;

Function TfrmCadRelatorios.fAtualizaSQLPrg(prgProgresso: TcxProgressBar): Boolean;
  Var
    blnSQLErro: Boolean;
Begin
  Result := True;

  pEditorToTabela;

  pSalvaDadosGrafico;

  FGravandoAtualizaSQL.lblGravando.Caption := 'Atualizando modelo...';
  Application.ProcessMessages;
  objRelatorio.objGeraFr3.strCodMod   := dbeCodMod.Text;

  FGravandoAtualizaSQL.lblGravando.Caption := 'Atualizando SQL...';
  Application.ProcessMessages;

  objRelatorio.objInterface.pSetaEditavel;

  If qryTabela.State In dsEditModes Then
    qryTabela.FieldByName('REL_SCRBEF').AsString := AnsiReplaceStr(stmSCRBEF.Lines.Text, #13#10, '<<csq>>');

  objRelatorio.objInterface.strCodPai := qryTabela.FieldByName('REL_CODPAI').AsString;

  objRelatorio.objInterface.strSQL    := Concat(objRelatorio.objInterface.recDadosPai.strSQLDEF, #13#10, qryTabela.FieldByName('REL_SQLDEF').AsString);

  If objRelatorio.objInterface.strSQL.IsEmpty Then
    objRelatorio.objInterface.strSQL := Concat(objRelatorio.objInterface.recDadosPai.strDEFSQL, #13#10, AnsiReplaceStr(qryTabela.FieldByName('REL_DEFSQL').AsString, '<<csq>>', #13#10));

  blnSQLErro := objRelatorio.objInterface.blnSQLErro;

  FGravandoAtualizaSQL.lblGravando.Caption := 'Atualizando SQL Filtros...';
  Application.ProcessMessages;
  objRelatorio.objInterface.strSQLFil := AnsiReplaceStr(qryTabela.FieldByName('REL_SQLFIL').AsString, '<<csq>>', #13#10);

  If Not objRelatorio.objInterface.blnSQLErro Then
    objRelatorio.objInterface.blnSQLErro := blnSQLErro;

  FGravandoAtualizaSQL.lblGravando.Caption := 'Atualizando complementos de filtros...';
  Application.ProcessMessages;
  objRelatorio.objInterface.strComFilComplementos := qryTabela.FieldByName('REL_COMFIL').AsString;

  FGravandoAtualizaSQL.lblGravando.Caption := 'Atualizando SQL do fr3...';
  Application.ProcessMessages;
  objRelatorio.objGeraFr3.strSQL := objRelatorio.objInterface.strSQL;

  FGravandoAtualizaSQL.lblGravando.Caption := 'Atualizando parâmetros excluidos...';
  Application.ProcessMessages;
  objRelatorio.objInterface.pLimpaParametrosExcluidos;
End;

procedure TfrmCadRelatorios.btnEstEntClick(Sender: TObject);
begin
  inherited;

  objRelatorio.objInterface.pPedeDadosParametrosAutomaticos('RECEBIDO_TERCEIROS');
end;

procedure TfrmCadRelatorios.btnEstEnvClick(Sender: TObject);
begin
  inherited;

  objRelatorio.objInterface.pPedeDadosParametrosAutomaticos('ENVIADO_TERCEIROS');
end;

procedure TfrmCadRelatorios.btnEstExtClick(Sender: TObject);
begin
  inherited;

  objRelatorio.objInterface.pPedeDadosParametrosAutomaticos('ESTOQUE_EXTERNO');
end;

procedure TfrmCadRelatorios.btnExcluiGruposClick(Sender: TObject);
begin
  inherited;

  objRelatorio.objInterface.pExcluiGrupoParametro;
end;

procedure TfrmCadRelatorios.btnExcluirClick(Sender: TObject);
begin

  If Not Assigned(objRelatorio) Then
    Exit;

  If (Not blnPodeAlterarPadrao) And
     SameText(qryTabela.FieldByName('REL_PADRAO').AsString, 'S') Then
  Begin
    pMensagemOk('Esse é um relatório padrão e não pode excluído!');
    Exit;
  End;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadRelatorios.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pCarregaDados;
end;

procedure TfrmCadRelatorios.btnExcluiRodapeClick(Sender: TObject);
begin
  inherited;

  If Assigned(objRelatorio) Then
    objRelatorio.objInterface.pExcluiCampoRodape;
end;

procedure TfrmCadRelatorios.btnExcluiBotaoFilClick(Sender: TObject);
begin
  inherited;
  objRelatorio.objRotinasFiltro.fApagaRotinasRelatorio;
end;

procedure TfrmCadRelatorios.btnExcluiBotaoGridClick(Sender: TObject);
begin
  inherited;

  objRelatorio.objRotinasGrid.fApagaRotinasRelatorio;
end;

procedure TfrmCadRelatorios.btnExecutarClick(Sender: TObject);
  Var
    blnCarregarCamposAuto: Boolean;
begin
  inherited;

  If Not Assigned(objRelatorio) Then
    Exit;

  blnCarregarCamposAuto := objRelatorio.objInterface.blnCarregarCamposAuto;

  objRelatorio.objInterface.blnCarregarCamposAuto := True;

  Try
    If qryTabela.IsEmpty Then
    Begin
      pMensagemOk('Carregue um relatório para executar!');
      Exit;
    End;

    If fEmptyStr(bceDEFSQL.Text) Then
    Begin
      pMensagemOk('Informe a instrução SQL para o relatório!');
      Exit;
    End;

    pAtualizaSQL;

    If fGeraFrx Then
    Begin
      objRelatorio.objInterface.blnApenasPrincipal := chkApePri.Checked;
      objRelatorio.objInterface.arrCadRel[0] := qryTabela;
      objRelatorio.objInterface.strTitulo    := qryTabela.FieldByName('REL_DESCRI').AsString;
      objRelatorio.objInterface.strSubTitulo := qryTabela.FieldByName('REL_SUBTIT').AsString;
      objRelatorio.objInterface.pPedeDados;
    End;

  Finally
    objRelatorio.objInterface.blnCarregarCamposAuto := blnCarregarCamposAuto;
  End;
end;

Function TfrmCadRelatorios.fGeraFrx(blnGravar: Boolean = False): Boolean;
Begin
  With objRelatorio, objGeraFr3, qryTabela Do
  Begin
    Result := False;

    If Not fAtualizaPapel(qryTabela) Then
      Exit;

    pAtualizaSQL;

    If objRelatorio.objInterface.blnSQLErro Then
    Begin
      Result := False;
      pgcDados.ActivePage := tbsSQL;
      Exit;
    End;

    cdsParams  := objInterface.cdsParams;
    cdsParamsAut := objInterface.cdsParametrosAutomaticos;
    cdsCamposG := objInterface.cdsCampos;
    cdsComple  := objInterface.cdsComplementos;
    arrCadRel  := objInterface.arrCadRel;

    objGeraFr3.objInterfaceGera := objInterface;

    If Not objInterface.fLargurasOk Then
      Exit;

    Result := ((Not blnGravar) And objInterface.fPrecisaRefazerFr3) Or
    fGerarFr3(objInterface.fMontaListaRel, objInterface.objConsulta, False, objInterface.fRetColunasDados);
  End;
End;

procedure TfrmCadRelatorios.btnGraHisClick(Sender: TObject);
begin
  inherited;

  if (fEmptyStr(edtTitHis.Text)) or (fEmptyStr(edtDesHis.Text)) then
    pMensagemOk('Campos Título do histórico e Descrição são de preenchimento obrigatório!')
  else
  begin
    if btnIncHis.Tag = 1 then
    begin
      objRelatorio.objInterface.fIncluiHistorico(edtTitHis.Text, edtDesHis.Text, qryTabela.FieldByName('REL_CHAVE_').AsString);
      edtTitHis.Clear;
      edtDesHis.Clear;
    end
    else
      objRelatorio.objInterface.fAlteraHistorico(edtTitHis.Text, edtDesHis.Text);

    pOperacaoHistorico('gravar');
  end;
end;

Function TfrmCadRelatorios.fTemComplementoNaoGrafico: Boolean;
  Var
    blnTemGrafico,
    blnTemNaoGraFico: Boolean;
Begin
  Result := False;

  If Not  Assigned(objRelatorio.objInterface.cdsComplementos) Then
    Exit;

  blnTemGrafico := TInterfaceRelatorio.fDestinoToTipo(qryTabela.FieldByName('REL_DESTIN').AsString) In (SET_GRAFICO + [desGrid]);

  blnTemNaoGrafico := Not blnTemGrafico;

  objRelatorio.objInterface.cdsComplementos.First;

  While Not objRelatorio.objInterface.cdsComplementos.Eof Do
  Begin
    If fEhRelatorioGrafico(objRelatorio.objInterface.cdsComplementos.FieldByName('REL_COMPLE').AsString) Then
      blnTemGrafico := True
    Else
      blnTemNaoGrafico := True;

    objRelatorio.objInterface.cdsComplementos.Next;
  End;

  Result := blnTemGrafico And blnTemNaoGrafico;
End;

procedure TfrmCadRelatorios.btnGravarClick(Sender: TObject);
  Var
    blnMudouDescricao: Boolean;
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  If fMarcouTipoGrafico And
     fMaisDeUmDestino And
     Assigned(objRelatorio.objInterface.cdsComplementos) And
     (objRelatorio.objInterface.cdsComplementos.RecordCount > 0) Then
  Begin
    pMensagemOk('Relatórios gráficos com complemento só podem ter um Destino de Saída marcado!');
    Exit;
  End;

  If fTemComplementoNaoGrafico Then
  Begin
    pMensagemOk('Relatórios gráficos/grid somente podem ter com complementos gráficos ou grid!');
    Exit;
  End;

  If Not objRelatorio.objInterface.fValidaOrdemCamposRodape Then
    Exit;

  If Not objRelatorio.objInterface.fValidaParametroFinal Then
    Exit;

  If Not objRelatorio.objInterface.fVerificaCamposTemplate(dbeCAMIDT.Text) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    objRelatorio.objInterface.blnCarregarCamposAuto := True;

    Try
      pAtualizaSQL;

      pDestinosToCampo;

      pSalvaDadosGrafico;

      pEditorToTabela;

      If Not Assigned(objRelatorio) Then
        Exit;

      If Not objRelatorio.objInterface.fValidaColunhasPorLinha Then
        Exit;

      If fEmptyStr(qryTabela.FieldByName('REL_CODMOD').AsString) Then
      Begin
        pgcDados.ActivePage := tbsGeral;
        pSetFocus(dbeCodMod);
        pMensagemOk('Informe o modelo do relatário!');
        Exit;
      End;

      If fEmptyStr(qryTabela.FieldByName('REL_DEFSQL').AsString) Then
      Begin
        If tbsSQL.TabVisible Then
        Begin
          pgcDados.ActivePage := tbsSQL;
          pMensagemOk('Informe a instrução SQL!');
        End Else
        begin
          pgcDados.ActivePage := tbsGeral;
          pMensagemOk('Defina as informações do relatório!');
        End;

        Exit;
      End;

      If objRelatorio.objInterface.blnSQLErro Then
      Begin
        pgcDados.ActivePage := tbsSQL;
        pMensagemOk('Instrução SQL inválida!');
        Exit;
      End;

      If Not objRelatorio.objInterface.fVerificaParametrosFuncoes Then
      Begin
        pgcDados.ActivePage := tbsCampos;
        pMensagemOk('Informe os parâmetros para a função!');
        btnAltCam.Click;
        Exit;
      End;

      If Not objRelatorio.objRotinasFiltro.fValidaMapeamento Then
      Begin
        pgcDados.ActivePage := tbsRotinas;
        TfrmMapeiaParametrosEdicao.pCarregaParametrosBotao(objRelatorio.objRotinasFiltro);
        Exit;
      End;

      If Not objRelatorio.objRotinasGrid.fValidaMapeamento Then
      Begin
        pgcDados.ActivePage := tbsRotinas;
        TfrmMapeiaParametrosEdicao.pCarregaParametrosBotao(objRelatorio.objRotinasGrid);
        Exit;
      End;

      If Not objRelatorio.objRotinasGrid.fValidaCamposDasRotinas(objRelatorio.objInterface.cdsCampos) Then
      Begin
        pgcDados.ActivePage := tbsRotinas;
        TfrmCamposRotina.pMostraCamposRotina(objRelatorio.objRotinasGrid);
        Exit;
      End;

      If Not objRelatorio.objInterface.objConsultasGrid.fValidaParametros(objRelatorio.objInterface.cdsCampos, objRelatorio.objInterface.cdsParams) Then
      Begin
        Exit;
      End;

      If Not fCompilaScript(False) Then
        Exit;

      qryTabela.FieldByName('REL_SCRBEF').AsString := AnsiReplaceStr(stmSCRBEF.Lines.Text, #13#10, '<<csq>>');

      If fEmptyStr(qryTabela.FieldByName('REL_CODPAI').AsString) Then
        qryTabela.FieldByName('REL_CODPAI').Clear;

      If fEmptyStr(qryTabela.FieldByName('REL_WIDDIS').AsString) Then
        qryTabela.FieldByName('REL_WIDDIS').Clear;

      qryTabela.FieldByName('REL_DTAALT').AsDateTime := VS_Date;
      qryTabela.FieldByName('REL_HORALT').AsDateTime := fTime();
      qryTabela.FieldByName('REL_TIPTOT').AsInteger  := cbxTipTot.ItemIndex;
      qryTabela.FieldByName('REL_ZOOINI').AsInteger  := edtZooIni.Value;
      qryTabela.FieldByName('REL_NUMCOL').AsInteger  := edtNumCol.Value;

      qryTabela.FieldByName('REL_MARESQ').AsInteger  := edtMarEsq.Value;
      qryTabela.FieldByName('REL_MARDIR').AsInteger  := edtMarDir.Value;

      qryTabela.FieldByName('REL_MD5NEW').AsString :=
        fRetHashString(qryTabela.FieldByName('REL_RELFR3').AsString +
                       qryTabela.FieldByName('REL_ALTTEL').AsString +
                       qryTabela.FieldByName('REL_CODMOD').AsString +
                       qryTabela.FieldByName('REL_DEFSQL').AsString +
                       qryTabela.FieldByName('REL_DESCRI').AsString +
                       qryTabela.FieldByName('REL_HEAWID').AsString +
                       qryTabela.FieldByName('REL_LARTEL').AsString +
                       qryTabela.FieldByName('REL_QTDCOL').AsString +
                       qryTabela.FieldByName('REL_VALWID').AsString +
                       qryTabela.FieldByName('REL_DTAALT').AsString +
                       qryTabela.FieldByName('REL_HORALT').AsString);

      If {fGeraFrx(True) And} objRelatorio.objGeraFr3.fSaveReport(qryTabela) Then
      Begin
        blnMudouDescricao := (qryTabela.State = dsEdit) And
                             (Not SameText(qryTabela.FieldByName('REL_DESCRI').AsString,
                                           qryTabela.FieldByName('REL_DESCRI').OldValue));

        inherited;

        If blnGravou And
           objRelatorio.objInterface.fSalvaParametros(qryTabela.FieldByName('AUTOINCREM').AsString) And
           objRelatorio.objInterface.fSalvaParametrosAutomaticos(qryTabela.FieldByName('AUTOINCREM').AsString) And
           objRelatorio.objInterface.fSalvaParametrosGatilho(qryTabela.FieldByName('AUTOINCREM').AsString) And
           objRelatorio.objInterface.fSalvaCampos(qryTabela.FieldByName('AUTOINCREM').AsString) And
           objRelatorio.objInterface.fSalvaComplementos(qryTabela.FieldByName('AUTOINCREM').AsString) and
           objRelatorio.objInterface.fSalvaChilds(qryTabela.FieldByName('AUTOINCREM').AsString) and
           objRelatorio.objInterface.fSalvaHistoricos(qryTabela.FieldByName('REL_CHAVE_').AsString) and
           objRelatorio.objRotinasFiltro.fSalvaRotinasRelatorio(qryTabela.FieldByName('AUTOINCREM').AsString) And
           objRelatorio.objRotinasGrid.fSalvaRotinasRelatorio(qryTabela.FieldByName('AUTOINCREM').AsString) And
           objRelatorio.objInterface.fSalvaDirAcesso(qryTabela.FieldByName('AUTOINCREM').AsString) Then
        Begin
          fCommit;

          objRelatorio.pGravaRelVrs(qryTabela.FieldByName('REL_CODREL').AsString, qryTabela.FieldByName('REL_VERREL').AsString);
          objRelatorio.pGravaMD5Comp(qryTabela.FieldByName('AUTOINCREM').AsString);

          if objRelatorio.fLimpaFiltrosNaoUtilizados(qryTabela.FieldByName('REL_CODREL').AsString) then
            objRelatorio.objInterface.cdsGruposParams.Refresh;

          If blnMudouDescricao Then
            objRelatorio.fRealocaMenu(qryTabela.FieldByName('REL_CODREL').AsString, frmFormMenu, mnuAutcom);

          pHabilitaTela(False);

          objRelatorio.objRotinasFiltro.blnPaiEmEdicao := False;
          objRelatorio.objRotinasGrid.blnPaiEmEdicao := False;
        End Else
        Begin
          fRollBack;
        End;

        pgcDados.ActivePageIndex := 0;

      End;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, 'TfrmCadRelatorios.btnGravarClick');
      End;
    End;

  Finally
    If Assigned(objRelatorio) And Assigned(objRelatorio.objInterface) Then
      objRelatorio.objInterface.blnCarregarCamposAuto := dbeCamAut.Checked;
  End;

end;

procedure TfrmCadRelatorios.btnIcoGraClick(Sender: TObject);
  Var
    strIcone: String;
begin
  inherited;

  strIcone :=  TfrmSelIcon.Execute('https://dashboard.citelsoftware.com.br/icons.html');

  If strIcone.StartsWith('.') Then
    Delete(strIcone, 1, 1);

  qryTabela.FieldByName('REL_ICOGRA').AsString := strIcone;
end;

procedure TfrmCadRelatorios.btnIncBotFiltroClick(Sender: TObject);
begin
  inherited;
  objRelatorio.objRotinasFiltro.pIncOrdemRotina(cxvBotFil);
end;

procedure TfrmCadRelatorios.btnIncBotGridClick(Sender: TObject);
begin
  inherited;
  objRelatorio.objRotinasGrid.pIncOrdemRotina(cxvBotGrid);
end;

procedure TfrmCadRelatorios.btnIncChiClick(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtCodChi.Text) Then
    objRelatorio.objInterface.fIncluiChild(edtCodChi.Text, qryTabela.FieldByName('AUTOINCREM').AsString);

  edtCodChi.Clear;
  edtDesChi.Clear;
end;

Function TfrmCadRelatorios.fMarcouTipoGrafico: Boolean;
  Var
    intContador: Integer;
Begin
  Result := False;

  For intContador := 0 To cklDestin.Items.Count - 1 Do
   If cklDestin.Checked[intContador] And
      (TInterfaceRelatorio.fDestinoToTipo(cklDestin.Items[intContador]) In [desGraficoColunas,
                                                                            desGraficoLinha,
                                                                            desGraficoBarras,
                                                                            desGraficoTorta,
                                                                            desGraficoArea,
                                                                            desGraficoColunasEmpilhado,
                                                                            desGraficoBarrasEmpilhado,
                                                                            desGraficoAreaEmpilhado]) Then
  Begin
    Result := True;
    Break;
  End;
End;

Function TfrmCadRelatorios.fMaisDeUmDestino: Boolean;
  Var
    intContador,
    intMarcados: Integer;
Begin
  intMarcados := 0;

  For intContador := 0 To cklDestin.Items.Count - 1 Do
   If cklDestin.Checked[intContador] Then
     Inc(intMarcados);

  Result := intMarcados > 1;
End;

Function TfrmCadRelatorios.fEhRelatorioGrafico(strCodRel: String): Boolean;
  Var
    strBusca: String;
Begin
  If Length(strCodRel) = 20 Then
    strBusca := 'AUTOINCREM'
  Else
    strBusca := 'REL_CODREL';

  Result :=  TInterfaceRelatorio.fDestinoToTipo(
                 fCampoTabela('REL_DESTIN', 'CADREL', [strBusca], [strCodrel])
                ) In [desGraficoColunas,
                      desGraficoLinha,
                      desGraficoBarras,
                      desGraficoTorta,
                      desGraficoArea,
                      desGraficoColunasEmpilhado,
                      desGrid];
End;

procedure TfrmCadRelatorios.btnIncComClick(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtCodCom.Text) Then
    objRelatorio.objInterface.fIncluiComplemento(edtCodCom.Text, qryTabela.FieldByName('AUTOINCREM').AsString);

  edtCodCom.Clear;
  edtDesCom.Clear;
  pSetFocus(edtCodCom);
end;

procedure TfrmCadRelatorios.btnIncDirClick(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtCodDir.Text) Then
    objRelatorio.objInterface.fIncluiDirAcesso(edtCodDir.Text, qryTabela.FieldByName('AUTOINCREM').AsString);

  edtCodDir.Clear;
  edtNomDir.Clear;
end;

procedure TfrmCadRelatorios.btnIncHisClick(Sender: TObject);
begin
  inherited;

  if fEmptyStr(qryTabela.FieldByName('REL_CHAVE_').AsString) then
    pMensagemOk('Relatório não possui chave! Reserve uma chave para incluir um histórico.')
  else
  begin
    pOperacaoHistorico('incluir');
    edtTitHis.Clear;
    edtDesHis.Clear;
  end;
end;

procedure TfrmCadRelatorios.pHabilitaPaginas(blnHabilita: Boolean);
  Var
    intContador: Integer;
Begin

  if dbeFr3per.Checked then
    blnHabilita := False;

  For intContador := 1 To pgcDados.PageCount - 1 Do
    pgcDados.Pages[intContador].TabVisible := blnHabilita;

  tbsGruCam.TabVisible := blnHabilita And (Not fArquivoTXTMarcado);

  tbsGrafico.TabVisible := blnHabilita And (Not blnDestinoDashboard);

  if dbeFr3per.Checked then
  begin
    tbsSQL.TabVisible := True;
    tbsGrupoFiltros.TabVisible := True;
    tbsSQLFil.TabVisible := True;
    tbsCompFiltroCab.TabVisible := True;
    tbsParametros.TabVisible := True;
    tbsHistorico.TabVisible := True;
  end;

  pAjustaNumeroPaginas;
End;

procedure TfrmCadRelatorios.pOperacaoHistorico(strOperacao: string);
begin
  edtTitHis.Enabled := IIF(AnsiMatchStr(strOperacao, ['incluir', 'alterar']), True, False);
  edtDesHis.Enabled := IIF(AnsiMatchStr(strOperacao, ['incluir', 'alterar']), True, False);
  btnCanHis.Enabled := IIF(AnsiMatchStr(strOperacao, ['incluir', 'alterar']), True, False);
  btnGraHis.Enabled := IIF(AnsiMatchStr(strOperacao, ['incluir', 'alterar']), True, False);

  btnIncHis.Enabled := IIF(AnsiMatchStr(strOperacao, ['incluir', 'alterar']), False, True);
  btnAltHis.Enabled := IIF(AnsiMatchStr(strOperacao, ['incluir', 'alterar']), False, True);
  btnDelHis.Enabled := IIF(AnsiMatchStr(strOperacao, ['incluir', 'alterar']), False, True);
  cxgHisto.Enabled  := IIF(AnsiMatchStr(strOperacao, ['incluir', 'alterar']), False, True);

  btnIncHis.Tag := IIF(strOperacao = 'incluir', 1, 0);
  btnAltHis.Tag := IIF(strOperacao = 'alterar', 1, 0);
end;

procedure TfrmCadRelatorios.btnIncluirClick(Sender: TObject);
begin
  blnNoBotaoIncluir := True;

  inherited;
  pInciaRelatorio;

  pgcDados.ActivePageIndex := 0;

  pHabilitaPaginas(False);

  pHabilitaTela(True);

  dbeTipFol.ItemIndex := 0;
  rdgOrient.ItemIndex := 0;
  rdgPGRCPE.ItemIndex := 2;

  qryTabela.FieldByName('REL_EXCGRI').AsString  := 'S';
  qryTabela.FieldByName('REL_INFCOL').AsString  := 'N';
  qryTabela.FieldByName('REL_PADRAO').AsString  := 'N';
  qryTabela.FieldByName('REL_CAMAUT').AsString  := 'S';
  qryTabela.FieldByName('REL_PASSAI').AsString  := 'N';
  qryTabela.FieldByName('REL_ENCARQ').AsString  := 'UTF-8';
  qryTabela.FieldByName('REL_SANARQ').AsString  := 'N';
  qryTabela.FieldByName('REL_GRADIR').AsString  := 'N';
  qryTabela.FieldByName('REL_HORIZO').AsString  := 'N';
  qryTabela.FieldByName('REL_INFHEI').AsString  := 'N';
  qryTabela.FieldByName('REL_REIZEB').AsString  := 'N';
  qryTabela.FieldByName('REL_EXLIBR').AsString  := 'N';
  qryTabela.FieldByName('REL_FILINF').AsString  := 'N';
  qryTabela.FieldByName('REL_OMIPAR').AsString  := 'N';
  qryTabela.FieldByName('REL_PGRCPE').AsString  := 'N';
  qryTabela.FieldByName('REL_QBRCOM').AsString  := 'N';
  qryTabela.FieldByName('REL_QBRFIL').AsString  := 'N';
  qryTabela.FieldByName('REL_COMPVZ').AsString  := 'N';
  qryTabela.FieldByName('REL_CONIND').AsString  := 'S';
  qryTabela.FieldByName('REL_GATINF').AsString  := 'N';
  qryTabela.FieldByName('REL_STRHED').AsString  := 'N';
  qryTabela.FieldByName('REL_FILLAT').AsString  := 'N';
  qryTabela.FieldByName('REL_PEDIMA').AsString  := 'N';
  qryTabela.FieldByName('REL_CONSAI').AsString  := 'N';
  qryTabela.FieldByName('REL_EXIPAG').AsString  := 'S';
  qryTabela.FieldByName('REL_TOTINI').AsString  := '2';
  cbxTotIni.ItemIndex := 2;

  qryTabela.FieldByName('REL_ALTMOD').AsString  := 'N';
  qryTabela.FieldByName('REL_SELIHE').AsString  := 'S';
  qryTabela.FieldByName('REL_ORIENT').AsString  := 'R';
  qryTabela.FieldByName('REL_TIPFOL').AsString  := 'A4';
  qryTabela.FieldByName('REL_TITQUE').AsString  := 'S';
  qryTabela.FieldByName('REL_ULTQUE').AsString  := 'N';
  qryTabela.FieldByName('REL_FILPRI').AsString  := 'S';
  qryTabela.FieldByName('REL_QTDCOL').AsInteger := StrToIntDef(dbeQtdCol.Items[3], 136);
  qryTabela.FieldByName('REL_TIPTOT').AsInteger := 0;

  qryTabela.FieldByName('REL_ASSDIG').AsString  := 'N';
  qryTabela.FieldByName('REL_XMLPAF').AsString  := 'N';
  qryTabela.FieldByName('REL_TITPOS').AsString  := 'N';
  qryTabela.FieldByName('REL_OMIREG').AsString  := 'N';
  qryTabela.FieldByName('REL_CSVTIT').AsString  := 'S';
  qryTabela.FieldByName('REL_CSVCOL').AsString  := 'S';
  qryTabela.FieldByName('REL_CSVASP').AsString  := 'S';
  qryTabela.FieldByName('REL_CSVDAS').AsString  := 'S';
  qryTabela.FieldByName('REL_CSVCAQ').AsString  := 'S';
  qryTabela.FieldByName('REL_CSVCAR').AsString  := 'N';
  qryTabela.FieldByName('REL_NLTITB').AsString  := 'N';
  qryTabela.FieldByName('REL_GRUVER').AsString  := 'S';
  qryTabela.FieldByName('REL_IMPMEI').AsString  := 'N';
  qryTabela.FieldByName('REL_COMMAT').AsString  := 'N';
  qryTabela.FieldByName('REL_OMITOT').AsString  := 'N';
  qryTabela.FieldByName('REL_PAGINI').AsString  := 'N';
  qryTabela.FieldByName('REL_VERREL').AsString  := '48.2.30.0';
  qryTabela.FieldByName('REL_RELREL').AsString  := '2.30.0.0';

  qryTabela.FieldByName('REL_ZOOINI').AsInteger  := 0;
  qryTabela.FieldByName('REL_CORZEB').AsInteger  := 13158600;
  qryTabela.FieldByName('REL_EXDTHR').AsString  := 'S';
  qryTabela.FieldByName('REL_NUMCOL').AsInteger  := 1;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  pCarregaDados;

  edtModDes.Clear;

  pAjustaModelo;

  pAjustaSplit;

  cbxHorizoChange(Nil);

  objRelatorio.objRotinasFiltro.blnPaiEmEdicao := True;
  objRelatorio.objRotinasGrid.blnPaiEmEdicao := True;

  blnNoBotaoIncluir := False;
end;

Function TfrmCadRelatorios.fValidaTipoChamadaGrid: Boolean;
Begin
  Result := False;

  If fEmptyStr(edtTitBotGrid.Text) Then
  Begin
    pMensagemOk('Informe um título para o botão!');
    pSetFocus(edtTitBotGrid);
    Exit;
  End;

  If cmbTipChaGrid.ItemIndex < 0 Then
  Begin
    pMensagemOk('Informe o tipo de chamada!');
    pSetFocus(cmbTipChaGrid);
    Exit;
  End;

  If cmbTipChaGrid.ItemIndex = 0 Then
  Begin
    If Not fValidaCampos(edtCodRelGrid) Then
      Exit;

  End Else
  Begin
    If VarToString(cxlRotinaGrid.EditValue).IsEmpty Then
    Begin
      pMensagemOk('Informe a rotina a ser chamada!');
      pSetFocus(cmbTipChaGrid);
      Exit;
    End;

  End;

  Result := True;
End;

function TfrmCadRelatorios.fVerificaSeRelatorioEstaNosGatilhos: Boolean;
var
  qrySQL : TUniQuery;
begin
  Result := False;

  If not Assigned(qryTabela) Then
    exit;

  If qryTabela.IsEmpty Then
    exit;

  if fEmptyStr(dbeCodigo.Text) then
    exit;

  qrySQL := fCriaQuery;

  try
    qrySQL.Close;
    qrySQL.SQL.Text := 'SELECT * FROM GATINF WHERE GAT_CODREL = :CODREL ';
    qrySQL.ParamByName('CODREL').AsString := dbeCodigo.Text;
    qrySQL.Open;

    Result := not qrySQL.IsEmpty;

    qrySQL.Close;

  finally
    FreeAndNil(qrySQL);
  end;

end;

Function TfrmCadRelatorios.fValidaTipoChamadaFiltro: Boolean;
Begin
  Result := False;

  If fEmptyStr(edtTitBotFil.Text) Then
  Begin
    pMensagemOk('Informe um título para o botão!');
    pSetFocus(edtTitBotFil);
    Exit;
  End;

  If cmbTipChaFil.ItemIndex < 0 Then
  Begin
    pMensagemOk('Informe o tipo de chamada!');
    pSetFocus(cmbTipChaFil);
    Exit;
  End;

  If cmbTipChaFil.ItemIndex = 0 Then
  Begin
    If Not fValidaCampos(edtCodRelFil) Then
      Exit;

  End Else
  Begin
    If VarToString(cxlRotinaFil.EditValue).IsEmpty Then
    Begin
      pMensagemOk('Informe a rotina a ser chamada!');
      pSetFocus(cmbTipChaFil);
      Exit;
    End;

  End;

  Result := True;
End;

procedure TfrmCadRelatorios.btnIncRotFilClick(Sender: TObject);
begin
  inherited;

  If Not fValidaTipoChamadaFiltro Then
    Exit;

  If objRelatorio.objRotinasFiltro.fIncluiRotinaRelatorio(edtCodRelFil.Text,
                                                          edtCodRelFilDes.Text,
                                                          IIF(cmbTipChaFil.ItemIndex = 1, cxlRotinaFil.EditValue, ''),
                                                          edtTitBotFil.Text,
                                                          cmbTipChaFil.ItemIndex,
                                                          chkCopValFil.Checked,
                                                          chkExeDirFil.Checked,
                                                          False,
                                                          edtAtaRelFil.Text) Then
  Begin
    pLimpaDadosBotaoFiltro;
    pSetFocus(edtCodRelFil);
  End;
end;

procedure TfrmCadRelatorios.btnIncRotGridClick(Sender: TObject);
begin
  inherited;

  If Not fValidaTipoChamadaGrid Then
    Exit;

  If objRelatorio.objRotinasGrid.fIncluiRotinaRelatorio(edtCodRelGrid.Text,
                                                        edtCodRelGridDes.Text,
                                                        IIF(cmbTipChaGrid.ItemIndex = 1, cxlRotinaGrid.EditValue, ''),
                                                        edtTitBotGrid.Text,
                                                        cmbTipChaGrid.ItemIndex,
                                                        chkCopValGrid.Checked,
                                                        chkExeDirGrid.Checked,
                                                        chkFecSaiGrid.Checked,
                                                        edtAtaRelGrid.Text) Then
  Begin
    pLimpaDadosBotaoGrid;
    pSetFocus(edtCodRelGrid);
  End;
end;

procedure TfrmCadRelatorios.pLimpaDadosBotaoGrid;
Begin
  edtCodRelGrid.Clear;
  edtCodRelGridDes.Clear;
  cxlRotinaGrid.ItemIndex := -1;
  cxlRotinaGrid.EditValue := Null;
  edtTitBotGrid.Clear;
  cmbTipChaGrid.ItemIndex := -1;
  chkCopValGrid.Checked := False;
  chkExeDirGrid.Checked := False;
  edtAtaRelGrid.Clear;
End;

procedure TfrmCadRelatorios.pLimpaDadosBotaoFiltro;
Begin
  edtCodRelFil.Clear;
  edtCodRelFilDes.Clear;
  cxlRotinaFil.ItemIndex := -1;
  cxlRotinaFil.EditValue := Null;
  edtTitBotFil.Clear;
  cmbTipChaFil.ItemIndex := -1;
  chkCopValFil.Checked := False;
  chkExeDirFil.Checked := False;
  edtAtaRelFil.Clear;
End;

procedure TfrmCadRelatorios.btnIncMenClick(Sender: TObject);
begin
  inherited;

  If qryTabela.IsEmpty Then
  Begin
    pMensagemOk('Carregue um relatório para a inclusão!');
    Exit;
  End;

  If qryTabela.State In dsEditModes Then
  Begin
    pMensagemOk('Salve o relatório para poder inclui-lo no menu!');
    Exit;
  End;

  If objRelMenu.fInsereRelatorioMenu(qryTabela.FieldByName('REL_CODREL').AsString,
                                     qryTabela.FieldByName('REL_DESCRI').AsString) Then
    pMensagemOk('Relatório incluido com sucesso!');
end;

procedure TfrmCadRelatorios.btnOrdBaiClick(Sender: TObject);
begin
  inherited;

  objRelatorio.objInterface.pIncOrdemFiltro(cxvParams)
end;

procedure TfrmCadRelatorios.btnOrdCimClick(Sender: TObject);
begin
  inherited;

  objRelatorio.objInterface.pDecOrdemFiltro(cxvParams);
end;

procedure TfrmCadRelatorios.btnPaginaInicialClick(Sender: TObject);
begin
  inherited;

  objRelatorio.objInterface.pPedeDadosParametrosAutomaticos(STR_PAGINA_INICIAL);
end;

procedure TfrmCadRelatorios.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrRelatorios: TConsultasArray;
begin
  chrKey := '/';

  If fPesqRelatorio(Self, Nil, Nil, qryTabela, False, '', chrKey, arrRelatorios) Then
  Begin
    pInciaRelatorio;
    pCarregaDados;
    pAjustaModelo;
    pHabilitaPaginas(True);
    pAjustaConfiguracoesWhatsapp;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadRelatorios.btnPreCusClick(Sender: TObject);
begin
  inherited;

  objRelatorio.objInterface.pPedeDadosParametrosAutomaticos(STR_PRECUS);
end;

procedure TfrmCadRelatorios.btnRepExpClick(Sender: TObject);
begin
  inherited;
  objRelatorio.objInterface.pReplicaExpImpOutrosFiltros;
end;

procedure TfrmCadRelatorios.btnRepFonClick(Sender: TObject);
begin
  inherited;
  objRelatorio.objInterface.pReplicaFonteOutrosCampos;
end;

procedure TfrmCadRelatorios.btnDelFonClick(Sender: TObject);
begin
  inherited;
  objRelatorio.objInterface.pLimpaFonteTodosCampos;
end;

procedure TfrmCadRelatorios.btnSalInvClick(Sender: TObject);
begin
  inherited;

  objRelatorio.objInterface.pPedeDadosParametrosAutomaticos('SALINV');
end;

procedure TfrmCadRelatorios.btnSalvaBackupClick(Sender: TObject);
begin
  inherited;

  If Not btnSalvaBackup.Enabled Then
    Exit;

  If qryTabela.IsEmpty Then
  Begin
    pMensagemOk('Carregue um relatório para a fazer o backup!');
    Exit;
  End;

  If qryTabela.State In dsEditModes Then
  Begin
    pMensagemOk('Salve o relatório para poder fazer o backup!');
    Exit;
  End;

  If Not Assigned(objRelatorio) Then
    Exit;

  objRelatorio.fSalvaBackup(qryTabela.FieldByName('REL_CODREL').AsString);
end;

procedure TfrmCadRelatorios.btnSetaFonteClick(Sender: TObject);
var
  fntDialog: TFontDialog;
begin
  inherited;

  fntDialog := TFontDialog.Create(nil);
  try
    if not fEmptyStr(dtsCadRel.dataSet.FieldByName('REL_FONTIT').AsString) then
      fntDialog.Font :=  TInterfaceRelatorio.StrToFont(dtsCadRel.dataSet.FieldByName('REL_FONTIT').AsString);
    if fntDialog.Execute then
      dtsCadRel.dataSet.FieldByName('REL_FONTIT').AsString :=  TInterfaceRelatorio.FontToStr(fntDialog.Font);
  finally
    FreeAndNil(fntDialog);
  end;
end;

procedure TfrmCadRelatorios.cbxFilPriChange(Sender: TObject);
begin
  inherited;

  If (qryTabela.State In dsEditModes) Then
  Begin
    Case cbxFilPri.ItemIndex Of
      0: qryTabela.FieldByName('REL_FILPRI').AsString := 'S';
      1: qryTabela.FieldByName('REL_FILPRI').AsString := 'N';
      2: qryTabela.FieldByName('REL_FILPRI').AsString := 'X';
    End;

    dbeFilCnd.Enabled := cbxFilPri.ItemIndex <> 2;
  End;

end;

procedure TfrmCadRelatorios.cbxHorizoChange(Sender: TObject);
begin
  inherited;

  If (qryTabela.State In dsEditModes) Then
  Case cbxHorizo.ItemIndex Of
    0: qryTabela.FieldByName('REL_HORIZO').AsString := 'N';

    1: If (qryTabela.State In dsEditModes) And (Not objRelatorio.objInterface.fPodeHorizontalizar(False)) Then
       Begin
         pMensagemOk('Para poder inverter a consulta, todas as colunas tem que ter o mesmo tipo de dado!');

         cbxHorizo.ItemIndex := 0;
         qryTabela.FieldByName('REL_HORIZO').AsString := 'N';
       End

       Else qryTabela.FieldByName('REL_HORIZO').AsString := 'S';

    2: If (qryTabela.State In dsEditModes) And (Not objRelatorio.objInterface.fPodeHorizontalizar(True)) Then
       Begin
         pMensagemOk('Para poder inverter a consulta, todas as colunas, exceto a primeira, tem que ter o mesmo tipo de dado!');

         cbxHorizo.ItemIndex := 0;
         qryTabela.FieldByName('REL_HORIZO').AsString := 'N';
       End

       Else qryTabela.FieldByName('REL_HORIZO').AsString := 'I';
  End;

   If (qryTabela.State In dsEditModes) And (cbxHorizo.ItemIndex = 2) And
      (qryTabela.FieldByName('REL_MAXCOL').AsInteger = 0) Then
     qryTabela.FieldByName('REL_MAXCOL').AsInteger := 2;

  lblMaxCol.Enabled := cbxHorizo.ItemIndex = 2;
  dbeMaxCol.Enabled := cbxHorizo.ItemIndex = 2;
end;

procedure TfrmCadRelatorios.cbxTipTotClick(Sender: TObject);
begin
  inherited;

  If qryTabela.State In dsEditModes Then
    qryTabela.FieldByName('REL_TIPTOT').AsInteger := cbxTipTot.ItemIndex;
end;

procedure TfrmCadRelatorios.cbxTitQueChange(Sender: TObject);
begin
  inherited;

  If (qryTabela.State In dsEditModes) Then
  Begin
    qryTabela.FieldByName('REL_ULTQUE').AsString := 'N';
    Case cbxTitQue.ItemIndex Of
      0: qryTabela.FieldByName('REL_TITQUE').AsString := 'S';
      1: qryTabela.FieldByName('REL_TITQUE').AsString := 'N';
      2: qryTabela.FieldByName('REL_TITQUE').AsString := 'D';
      3: qryTabela.FieldByName('REL_TITQUE').AsString := '3';
      4: Begin
           qryTabela.FieldByName('REL_TITQUE').AsString := 'S';
           qryTabela.FieldByName('REL_ULTQUE').AsString := 'S';
         End;
    End;
  End;

end;

procedure TfrmCadRelatorios.chkConIndClick(Sender: TObject);
begin
  inherited;

  If Assigned(objRelatorio) And Assigned(objRelatorio.objInterface) Then
    objRelatorio.objInterface.pRefazConexaoRelatorio(chkConInd.Checked);
end;

procedure TfrmCadRelatorios.chkInfHeiClick(Sender: TObject);
begin
  inherited;

  pAjustaInfHei;
end;

procedure TfrmCadRelatorios.cklDestinClickCheck(Sender: TObject);
begin
  inherited;

  pAjustaDestino;
  pDestinosToCampo;
  pAjustaModelo;
end;

procedure TfrmCadRelatorios.cmbTipChaFilChange(Sender: TObject);
begin
  inherited;

  pAjustaTipoChamadaFil;
end;

procedure TfrmCadRelatorios.cmbTipChaGridChange(Sender: TObject);
begin
  inherited;
  pAjustaTipoChamadaGrid;
end;

procedure TfrmCadRelatorios.cbxTitPosChange(Sender: TObject);
begin
  inherited;

  If (qryTabela.State In dsEditModes) Then
  Begin
    Case cbXTitPos.ItemIndex Of
      0: qryTabela.FieldByName('REL_TITPOS').AsString := 'N';
      1: qryTabela.FieldByName('REL_TITPOS').AsString := 'S';
      2: qryTabela.FieldByName('REL_TITPOS').AsString := 'A';
    End;
  End;
end;

procedure TfrmCadRelatorios.pAjustaTipoChamadaFil;
Begin
  lblCodRelFil.Enabled := cmbTipChaFil.ItemIndex = 0;
  edtCodRelFil.Enabled := cmbTipChaFil.ItemIndex = 0;
  If Not edtCodRelFil.Enabled Then
  Begin
    edtCodRelFil.Clear;
    edtCodRelFilDes.Clear;
  End;

  chkCopValFil.Enabled := cmbTipChaFil.ItemIndex = 0;
  chkExeDirFil.Enabled := cmbTipChaFil.ItemIndex = 0;
  lblRotinaFil.Enabled := cmbTipChaFil.ItemIndex = 1;
  cxlRotinaFil.Enabled := cmbTipChaFil.ItemIndex = 1;
End;

procedure TfrmCadRelatorios.pAjustaTipoChamadaGrid;
Begin
  lblCodRelGrid.Enabled := cmbTipChaGrid.ItemIndex = 0;
  edtCodRelGrid.Enabled := cmbTipChaGrid.ItemIndex = 0;
  If Not edtCodRelGrid.Enabled Then
  Begin
    edtCodRelGrid.Clear;
    edtCodRelGridDes.Clear;
  End;

  chkCopValGrid.Enabled := cmbTipChaGrid.ItemIndex = 0;
  chkExeDirGrid.Enabled := cmbTipChaGrid.ItemIndex = 0;
  lblRotinaGrid.Enabled := cmbTipChaGrid.ItemIndex = 1;
  cxlRotinaGrid.Enabled := cmbTipChaGrid.ItemIndex = 1;
  chkFecSaiGrid.Enabled := cmbTipChaGrid.ItemIndex = 1;
End;

procedure TfrmCadRelatorios.cbxTotIniChange(Sender: TObject);
begin
  inherited;

  If (qryTabela.State In dsEditModes) Then
  Case cbxTotIni.ItemIndex Of
    0:    qryTabela.FieldByName('REL_TOTINI').AsString := '0';
    1:    qryTabela.FieldByName('REL_TOTINI').AsString := '1';
    Else  qryTabela.FieldByName('REL_TOTINI').AsString := '2';
  End;

end;

Function TfrmCadRelatorios.fDestinoMarcado(desDestino: TDestinoRel): Boolean;
  Var
    intContador: Integer;
Begin
  Result := False;

  For intContador := 0 To cklDestin.Count - 1 Do
    If SameText(cklDestin.Items[intContador], String(ArrDestino[desDestino])) And cklDestin.Checked[intContador] Then
    Begin
      Result := True;
      Break;
    End;
End;

Function TfrmCadRelatorios.fArquivoTXTMarcado: Boolean;
Begin
  Result := fDestinoMarcado(desTXT);
End;

Function TfrmCadRelatorios.fArquivoXMLMarcado: Boolean;
Begin
  Result := fDestinoMarcado(desXML);
End;

procedure TfrmCadRelatorios.pAjustaDestinoMarcado(desDestino: TDestinoRel);
  Var
    intContador: Integer;
Begin
  If fDestinoMarcado(desDestino) Then
    For intContador := 0 To cklDestin.Count - 1 Do
      If Not SameText(cklDestin.Items[intContador], String(ArrDestino[desDestino])) Then
        cklDestin.Checked[intContador] := False;
End;

procedure TfrmCadRelatorios.pAjustaDestino;
Begin
  pAjustaDestinoMarcado(desTxt);
  pAjustaDestinoMarcado(desValidacao);
End;

procedure TfrmCadRelatorios.pAjustaInfHei;
Begin
  lblPapHei.Enabled := chkInfHei.Checked;
  dbePapHei.Enabled := chkInfHei.Checked;

  If (Not chkInfHei.Checked) And (qryTabela.State In dsEditModes) Then
    qryTabela.FieldByName('REL_PAPHEI').AsFloat := 0;
End;

procedure TfrmCadRelatorios.cxgCamposLARGURPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    Var
      fltValor: Double;
begin
  inherited;

  If qryTabela.FieldByName('REL_TIPIMP').AsString = 'J' Then
  Begin
    fltValor := RoundTo(fStrToFloat(DisplayValue), -2);

    If RoundTo(fltValor, -2) < RoundTo(0.30, -2) Then
    Begin
      Error := True;
      ErrorText := '';
      pMensagemOk('A Largura deve ser maior o igual a 0.3 cm!')
    End;

  End Else
  Begin
    fltValor := RoundTo(fStrToFloat(DisplayValue), -2);

    If RoundTo(fltValor, -2) < RoundTo(1.00, -2) Then
    Begin
      Error := True;
      ErrorText := '';
      pMensagemOk('A Largura deve ser maior o igual a uma coluna!')
    End;

  End;

end;

procedure TfrmCadRelatorios.cxvBotFilMAPPARPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  TfrmMapeiaParametrosEdicao.pCarregaParametrosBotao(objRelatorio.objRotinasFiltro);
end;

procedure TfrmCadRelatorios.cxvBotGridCampoRotinaPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;

  TfrmCamposRotina.pMostraCamposRotina(objRelatorio.objRotinasGrid);
end;

procedure TfrmCadRelatorios.cxvBotGridFecSaiPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

  If Not fEmptyStr(objRelatorio.objRotinasGrid.cdsRotinasRelatorio.FieldByName('ROT_SEQREL').AsString) Then
  Begin
    Error := True;
    ErrorText := '';
    If objRelatorio.objRotinasGrid.cdsRotinasRelatorio.state = dsEdit Then
      objRelatorio.objRotinasGrid.cdsRotinasRelatorio.Cancel;
  End;
end;

procedure TfrmCadRelatorios.cxvBotGridMAPPARPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  TfrmMapeiaParametrosEdicao.pCarregaParametrosBotao(objRelatorio.objRotinasGrid);
end;

procedure TfrmCadRelatorios.cxvCamposCNDVISCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If Not objRelatorio.objInterface.cdsCampos.IsEmpty Then
  Begin
    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvCamposCNDVIS.Index]) = 'Sim' Then
    begin
      ACanvas.Brush.Color := clGreen;
      ACanvas.Font.Color := clWhite;
      ACanvas.Font.Style := [fsBold];
    end;
  End;
end;

procedure TfrmCadRelatorios.cxvCamposEditKeyDown(Sender: TcxCustomGridTableView;
  AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If objRelatorio.objInterface.cdsCampos.State = dsEdit Then
                 objRelatorio.objInterface.cdsCampos.Post;
  End;
end;

procedure TfrmCadRelatorios.cxvCamposFUNCAOPropertiesChange(Sender: TObject);
begin
  inherited;

  With objRelatorio.objInterface, cdsCampos Do
  Begin

    If fEmptyStr(FieldByName('CAM_FUNCAO').AsString) Then
    Begin
      If State = dsEdit Then
        FieldByName('CAM_PARAME').AsString := '';
    End

    Else pPedeDadosCampo(blnDestinoDashboard);

  End;

end;

procedure TfrmCadRelatorios.cxvCamposLINQUEPropertiesCloseUp(Sender: TObject);
begin
  inherited;

    If objRelatorio.objInterface.cdsCampos.State = dsEdit Then
    objRelatorio.objInterface.cdsCampos.Post;

end;

procedure TfrmCadRelatorios.cxvCamposLISQUEPropertiesCloseUp(Sender: TObject);
begin
  inherited;

  If objRelatorio.objInterface.cdsCampos.State = dsEdit Then
    objRelatorio.objInterface.cdsCampos.Post;
end;

procedure TfrmCadRelatorios.cxvCamposLISTARPropertiesCloseUp(Sender: TObject);
begin
  inherited;

  If objRelatorio.objInterface.cdsCampos.State = dsEdit Then
    objRelatorio.objInterface.cdsCampos.Post;

  fAtualizaLarguraMaxima;
end;

procedure TfrmCadRelatorios.cxvCamposQUEBRACustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;


  If Not objRelatorio.objInterface.cdsCampos.IsEmpty Then
  Begin
    If StrToIntDef(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvCamposPOSORD.Index]), -1) > -1 Then
      ACanvas.Brush.Color := clYellow;
  End;

end;

procedure TfrmCadRelatorios.cxvCamposQUEBRAPropertiesChange(Sender: TObject);
begin
  inherited;

  if (objRelatorio.objInterface.fVerificaDashboarQuebra(blnDestinoDashboard)) then
    If objRelatorio.objInterface.cdsCampos.State = dsEdit Then
    Begin
      If objRelatorio.objInterface.cdsCampos.FieldByName('CAM_QUEBRA').AsString = 'S' Then
        objRelatorio.objInterface.cdsCampos.FieldByName('CAM_REATOT').AsString := 'S';

      objRelatorio.objInterface.cdsCampos.Post;
    End;

end;

procedure TfrmCadRelatorios.cxvCamposTOTALIPropertiesCloseUp(Sender: TObject);
begin
  inherited;

  With objRelatorio.objInterface, cdsCampos Do
  Begin
    If State = dsEdit Then
      cdsCampos.Post;

    If (Not SameText(strTipoSomaAnterior, FieldByName('CAM_TOTALI').AsString)) And
       SameText(STR_DEF_FORMULA, FieldByName('CAM_TOTALI').AsString) And
       (qryTabela.State In dsEditModes) Then
      btnAltCam.Click;
  End;
end;

procedure TfrmCadRelatorios.cxvChirelEditKeyDown(Sender: TcxCustomGridTableView;
  AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_DELETE: btnDelChi.Click;
  End;
end;

procedure TfrmCadRelatorios.cxvChirelNomCamPropertiesCloseUp(Sender: TObject);
begin
  inherited;

  If objRelatorio.objInterface.cdsChilds.State = dsEdit Then
    objRelatorio.objInterface.cdsChilds.Post;
end;

function CountPos(const subtext: string; Text: string): Integer;
begin
  if (Length(subtext) = 0) or (Length(Text) = 0) or (Pos(subtext, Text) = 0)
  then
    Result := 0
  else
    Result := (Length(Text) - Length(StringReplace(Text, subtext, '',
      [rfReplaceAll]))) div Length(subtext);
end;

procedure TfrmCadRelatorios.cxvColunasPorLinhaDashboardPROPORPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
    Var
      strValor: String;
begin
  inherited;

  strValor := DisplayValue;

  If (Not strValor.IsEmpty) And
     (Length(strValor.Split(['-'])) <> objRelatorio.objInterface.cdsColunasPorLinha.FieldByName('QTDCOL').AsInteger) Then
  Begin
    Error := True;
    ErrorText := '';
    pMensagemOk('A proporção deve obedecer o número de colunas!');
  End;

end;

procedure TfrmCadRelatorios.cxvDirRelEditKeyDown(Sender: TcxCustomGridTableView;
  AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_DELETE: btnDelDir.Click;
  End;
end;

procedure TfrmCadRelatorios.cxvHistoCellClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  if not cxvHisto.DataController.DataSource.DataSet.IsEmpty then
  begin
    edtTitHis.Text := cxvHisto.DataController.DataSource.DataSet.FieldByName('HIS_TITULO').AsString;
    edtDesHis.Lines.Clear;
    edtDesHis.Lines.Add(AnsiReplaceStr(cxvHisto.DataController.DataSource.DataSet.FieldByName('HIS_DESCRI').AsString, '<<csq>>', #13#10));
  end;
end;

procedure TfrmCadRelatorios.cxvHistoEditKeyDown(Sender: TcxCustomGridTableView;
  AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_DELETE: btnDelHis.Click;
  End;
end;

procedure TfrmCadRelatorios.cxvParamsCNDVISCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If Not objRelatorio.objInterface.cdsParams.IsEmpty Then
  Begin
    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvParamsCNDVIS.Index]) = 'Sim' Then
    begin
      ACanvas.Brush.Color := clGreen;
      ACanvas.Font.Color := clWhite;
      ACanvas.Font.Style := [fsBold];
    end;
  End;
end;

procedure TfrmCadRelatorios.cxvParamsTIPFACPropertiesCloseUp(Sender: TObject);
begin
  inherited;

  If Not (qryTabela.State In dsEditModes) Then
    Exit;

  With objRelatorio.objInterface Do
  Begin
    pAjustaTipoDeInterface;

    If cdsParams.State = dsEdit Then
      cdsParams.Post;
  End;

end;

procedure TfrmCadRelatorios.cxvRelatEditKeyDown(Sender: TcxCustomGridTableView;
  AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_DELETE: btnDelCom.Click;
  End;
end;

procedure TfrmCadRelatorios.cxvRodapeGridCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  pCarrregaCampoRodape;
end;

procedure TfrmCadRelatorios.pCarrregaCampoRodape;
Begin
  If Not Assigned(objRelatorio) Then
    Exit;

  If objRelatorio.objInterface.cdsCamposRodape.IsEmpty Then
    Exit;

  cxlCampos.EditValue := objRelatorio.objInterface.cdsCamposRodape.FieldByName('CAM_NOMCAM').AsString;
  rdgPOSREL.ItemIndex := objRelatorio.objInterface.cdsCamposRodape.FieldByName('CAM_POSREL').AsInteger;
  cxlCampoReferenciaRodape.EditValue := objRelatorio.objInterface.cdsCamposRodape.FieldByName('CAM_REFROD').AsString;
End;

procedure TfrmCadRelatorios.cxvRodapeGridLARGURPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
  Var
    fltValor: Double;
begin
  inherited;

  fltValor := RoundTo(fStrToFloat(DisplayValue), -2);

  If RoundTo(fltValor, -2) < 0 Then
  Begin
    Error := True;
    ErrorText := '';
    pMensagemOk('A Largura deve ser maior o igual a zero!')
  End;

end;

procedure TfrmCadRelatorios.dbeALIRODChange(Sender: TObject);
begin
  inherited;

  pAjustaTipoAlinhamentoRodape;
end;

procedure TfrmCadRelatorios.pAjustaTipoAlinhamentoRodape;
Begin
  cxvRodapeGridNOVROD.Visible := dbeALIROD.ItemIndex = 0;
  cxvRodapeGridPOSREL.Visible := dbeALIROD.ItemIndex = 1;
  cxvRodapeGridREFROD.Visible := dbeALIROD.ItemIndex = 1;
  pnlRodapeDetalhado.Visible  := dbeALIROD.ItemIndex = 1;
  pnlDadosRodapeGrid.ClientHeight := pnlDadosComumRodapeGrid.Height +
                                     IIF(pnlRodapeDetalhado.Visible, pnlRodapeDetalhado.Height, 0);
End;

procedure TfrmCadRelatorios.dbeCamAutClick(Sender: TObject);
begin
  inherited;

  If Assigned(objRelatorio) And Assigned(objRelatorio.objInterface) Then
    objRelatorio.objInterface.blnCarregarCamposAuto := dbeCamAut.Checked;

end;

procedure TfrmCadRelatorios.dbeCodModExit(Sender: TObject);
begin
  inherited;

  fValidaCampos(dbeCodMod);
end;

procedure TfrmCadRelatorios.dbeCodModKeyPress(Sender: TObject; var Key: Char);
  Var
    arrModelo: TConsultasArray;
begin
  inherited;

  If fPesqModeloRelatorio(Self, dbeCodMod, edtModDes, Nil, False, '', Key, arrModelo) And
     fValidaCampos(dbeCodMod) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadRelatorios.dbeCodPaiKeyPress(Sender: TObject; var Key: Char);
  Var
    arrRelatorios: TConsultasArray;
begin
  inherited;

  If fPesqRelatorio(Self, dbeCodPai, edtDesCodPai, Nil, False,
                    qryTabela.FieldByName('REL_TIPIMP').AsString, Key, arrRelatorios) And
     fValidaCampos(dbeCodPai) Then
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmCadRelatorios.dbeCOMFILExit(Sender: TObject);
begin
  inherited;

  If qryTabela.State In dsEditModes Then
    qryTabela.FieldByName('REL_COMFIL').AsString := objRelatorio.objInterface.fTiraEspacosMemo(qryTabela.FieldByName('REL_COMFIL').AsString);

  objRelatorio.objInterface.strComFilComplementos := qryTabela.FieldByName('REL_COMFIL').AsString;
end;

procedure TfrmCadRelatorios.DBEditFocus14KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If Key = '-' Then
    Key := #0;
end;

procedure TfrmCadRelatorios.dbeLinGraDashExit(Sender: TObject);
begin
  inherited;

  objRelatorio.objInterface.pAjustColunhasPorLinha(StrToIntDef(dbeLinGraDash.Text, 0));
end;

procedure TfrmCadRelatorios.dbeLINGRAExit(Sender: TObject);
begin
  inherited;

  objRelatorio.objInterface.pAjustColunhasPorLinha(StrToIntDef(dbeLINGRA.Text, 0));
end;

procedure TfrmCadRelatorios.dbeLINGRAKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If Key = '-' Then
    Key := #0;
end;

procedure TfrmCadRelatorios.dbePasSaiClick(Sender: TObject);
begin
  inherited;
  If (qryTabela.State in dsEditModes) Then
    fValidaCampos(dbePasSai, True);
end;

procedure TfrmCadRelatorios.dbeFr3perClick(Sender: TObject);
begin
  pVerificaFR3Personalizado;
end;

procedure TfrmCadRelatorios.dbeGatInfClick(Sender: TObject);
begin
  inherited;
  If (qryTabela.State in dsEditModes) Then
    fValidaCampos(dbeGatInf, True);
end;

procedure TfrmCadRelatorios.dbeInfColClick(Sender: TObject);
begin
  inherited;

  If Not qryTabela.Active Then
    Exit;

  If blnNoBotaoIncluir Then
    Exit;

  If dbeInfCol.Checked And
     (qryTabela.FieldByName('REL_LINGRA').AsInteger <= 0) Then
  Begin
    dbeInfCol.Checked := False;
    pMensagemOk('Informe o número de linhas do gráfico!');
    pSetFocus(dbeLinGra);
  End;

  If Assigned(objRelatorio) And
     Assigned(objRelatorio.objInterface) And
     Assigned(objRelatorio.objInterface.cdsColunasPorLinha) Then
   cxvColunasPorLinha.OptionsData.Editing := dbeInfCol.Checked;
end;

procedure TfrmCadRelatorios.dbeTipFolClick(Sender: TObject);
begin
  inherited;
  pAjustaTipFol;
end;

procedure TfrmCadRelatorios.dbeWIDDISKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFila: TConsultasArray;
begin
  inherited;

  If fPesqFilaWpp(Self, dbeWIDDIS, edtDescCadFil, Nil, Key, arrFila) And
     fValidaCampos(dbeWIDDIS) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadRelatorios.pAjustaTipFol;
begin
  if qryTabela.State in dsEditModes then
  begin
    if dbeTipFol.Text = 'T40' then
    begin
      rdgOrient.ItemIndex := 0;
      chkInfHei.Checked   := False;
      qryTabela.FieldByName('REL_PAPHEI').AsFloat := 0;
    end;

    rdgOrient.Enabled := dbeTipFol.Text <> 'T40';
    chkInfHei.Enabled := dbeTipFol.Text <> 'T40';
    dbePapHei.Enabled := (dbeTipFol.Text <> 'T40') and (chkInfHei.Checked);
  end;
end;

procedure TfrmCadRelatorios.edtCodChiExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodChi.Text) Then
  Begin
    edtDesChi.Clear;
  End Else
  Begin
    edtDesChi.Text := fRetNomeRelatorio(edtCodChi.Text);

    If fEmptyStr(edtDesChi.Text) Then
    Begin
      pMensagemOk('Relatório ' + edtCodChi.Text + ' não encontrado!');
      edtCodChi.Clear;
      edtDesChi.Clear;
    End

    Else If SameText(qryTabela.FieldByName('REL_CODREL').AsString, edtCodChi.Text) Then
    Begin
      pMensagemOk('O relatório não pode ser filho (child) de si mesmo!');
      edtCodChi.Clear;
      edtDesChi.Clear;
    End

    Else If Not SameText(qryTabela.FieldByName('REL_TIPIMP').AsString,
                         fCampoTabela('REL_TIPIMP', 'CADREL', ['REL_CODREL'], [edtCodChi.Text])) Then
    Begin
      pMensagemOk('Os relatórios devem ter o mesmo tipo de impressão (Jato ou matricial)!');
      edtCodChi.Clear;
      edtDesChi.Clear;
    End

  End;
end;

procedure TfrmCadRelatorios.edtCodChiKeyPress(Sender: TObject; var Key: Char);
  Var
    arrRelatorios: TConsultasArray;
begin
  inherited;

  If fPesqRelatorio(Self, edtCodChi, edtDesChi, Nil, False,
                    qryTabela.FieldByName('REL_TIPIMP').AsString, Key, arrRelatorios) Then
  Begin
    pSetFocus(btnIncChi);
  End;
end;

procedure TfrmCadRelatorios.edtCodComExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodCom.Text) Then
  Begin
    edtDesCom.Clear;
  End Else
  Begin
    edtDesCom.Text := fRetNomeRelatorio(edtCodCom.Text);

    If fEmptyStr(edtDesCom.Text) Then
    Begin
      pMensagemOk('Relatório ' + edtCodCom.Text + ' não encontrado!');
      edtCodCom.Clear;
      edtDesCom.Clear;
    End

    Else If SameText(qryTabela.FieldByName('REL_CODREL').AsString, edtCodCom.Text) Then
    Begin
      pMensagemOk('O relatório não pode ser complemento de si mesmo!');
      edtCodCom.Clear;
      edtDesCom.Clear;
    End

    Else If Not SameText(qryTabela.FieldByName('REL_TIPIMP').AsString,
                         fCampoTabela('REL_TIPIMP', 'CADREL', ['REL_CODREL'], [edtCodCom.Text])) Then
    Begin
      pMensagemOk('Os relatórios devem ter o mesmo tipo de impressão (Jato ou matricial)!');
      edtCodCom.Clear;
      edtDesCom.Clear;
    End

  End;
end;

procedure TfrmCadRelatorios.edtCodComKeyPress(Sender: TObject; var Key: Char);
  Var
    arrRelatorios: TConsultasArray;
begin
  inherited;

  If fPesqRelatorio(Self, edtCodCom, edtDesCom, Nil, False,
                    qryTabela.FieldByName('REL_TIPIMP').AsString, Key, arrRelatorios) Then
  Begin
    pSetFocus(btnIncCom);
  End;
end;

procedure TfrmCadRelatorios.edtCodDirExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodDir.Text) Then
  Begin
    edtNomDir.Clear;
  End Else
  Begin
    edtNomDir.Text := fCampoTabela('DIR_NOMDIR', 'CADDIR', ['DIR_CODDIR'], [edtCodDir.Text]);

    If fEmptyStr(edtNomDir.Text) Then
    Begin
      pMensagemOk('Direito de Acesso ' + edtCodDir.Text + ' não encontrado!');
      edtCodDir.Clear;
      edtNomDir.Clear;
    End;

  End;
end;

procedure TfrmCadRelatorios.edtCodDirKeyPress(Sender: TObject; var Key: Char);
Var
  arrDirAcesso: TConsultasArray;
begin
  inherited;

  If fPesqDireitosVerdeVermelho(Self, edtCodDir, edtNomDir, Nil, Key, arrDirAcesso) Then
  Begin
    pSetFocus(btnIncDir);
  End;
end;

procedure TfrmCadRelatorios.edtCodRelFilKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrRelatorios: TConsultasArray;
begin
  inherited;

  If fPesqRelatorio(Self, edtCodRelFil, edtCodRelFilDes, Nil, False, '', Key, arrRelatorios) And
     fValidaCampos(edtCodRelFil) Then
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmCadRelatorios.edtCodRelGridKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrRelatorios: TConsultasArray;
begin
  inherited;

  If fPesqRelatorio(Self, edtCodRelGrid, edtCodRelGridDes, Nil, False, '', Key, arrRelatorios) And
     fValidaCampos(edtCodRelGrid) Then
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmCadRelatorios.edtMarDirExit(Sender: TObject);
begin
  inherited;
  If qryTabela.State In dsEditModes Then
  Begin
    qryTabela.FieldByName('REL_MARDIR').AsInteger  := edtMarDir.Value;
    objRelatorio.objInterface.pMoldura(Not fArquivoTXTMarcado);
  End;
end;

procedure TfrmCadRelatorios.edtMarEsqExit(Sender: TObject);
begin
  inherited;
  If qryTabela.State In dsEditModes Then
  Begin
    qryTabela.FieldByName('REL_MARESQ').AsInteger  := edtMarEsq.Value;
    objRelatorio.objInterface.pMoldura(Not fArquivoTXTMarcado);
  End;
end;

procedure TfrmCadRelatorios.edtNumColExit(Sender: TObject);
begin
  inherited;
  If qryTabela.State In dsEditModes Then
  Begin
    qryTabela.FieldByName('REL_NUMCOL').AsInteger  := edtNumCol.Value;
    objRelatorio.objInterface.pMoldura(Not fArquivoTXTMarcado);
  End;
end;

procedure TfrmCadRelatorios.edtAtaRelFilKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  edtAtaRelFil.Text := objRelatorio.objRotinasGrid.fRetornaStringAtalhoTeclado(Key, Shift);
end;

procedure TfrmCadRelatorios.edtAtaRelGridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  edtAtaRelGrid.Text := objRelatorio.objRotinasGrid.fRetornaStringAtalhoTeclado(Key, Shift);
end;

procedure TfrmCadRelatorios.edtZooIniExit(Sender: TObject);
begin
  inherited;
  If qryTabela.State In dsEditModes Then
    qryTabela.FieldByName('REL_ZOOINI').AsInteger  := edtZooIni.Value;
end;

procedure TfrmCadRelatorios.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  blnCancelouPeloClose := True;

  Try
    inherited;
  Finally
    blnCancelouPeloClose := False;
  End;

  If Assigned(objRelatorio) And Assigned(objRelatorio.objInterface) Then
    objRelatorio.objInterface.pSetaTRANSACTIONISOLATION;
end;

procedure TfrmCadRelatorios.FormCreate(Sender: TObject);
begin
  inherited;

  blnNoBotaoIncluir := False;
  blnCancelouPeloClose := False;

  pSetaDestinos;

  blnPodeAlterarPadrao := SameText(fArqIni(0, 'GERAL', 'PODE_ALTERAR_RELATORIO_PADRAO', ''), 'S');

  scrLinhas.VertScrollBar.Position := 0;
  scrLinhas.HorzScrollBar.Position := 0;

  objRelMenu := Nil;

  pgcDados.ActivePageIndex := 0;

  dbeTipFol.Items.Text := fRetTiposPapel;
  dbeQtdCol.Items.Text := TGeraFR3.fRetColunasMatricial;
  dbeQtdCol.ItemIndex  := 3;
  dbeEncArq.Items.Text := 'UTF-8'#13#10'UTF-8 BOM'#13#10'ANSI'#13#10'UTF-16'#13#10'Base64';

  strNomeTabela         := 'CADREL';
  strNomeCampo          := 'REL_CODREL';

  qryTabela             := fCriaQuery(Self);
  dtsCadRel.DataSet     := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0]     := dbeCodigo;

  TcxCustomComboBoxProperties(cxvCamposTOTALI.Properties).Items.Text := TInterfaceRelatorio.fRetDescricaoTotalizadores;
  TcxCustomComboBoxProperties(cxvCamposMASCAR.Properties).Items.Text := TInterfaceRelatorio.fRetDescricaoMascara;
  TcxCustomComboBoxProperties(cxvCamposFUNCAO.Properties).Items.Text := TInterfaceRelatorio.fRetDescricaoFuncoes;

  TcxCustomComboBoxProperties(cxvParamsTIPPAR.Properties).Items.Text := TInterfaceRelatorio.fRetDescricaoParametros;
  TcxCustomComboBoxProperties(cxvParamsTIPFAC.Properties).Items.Text := TInterfaceRelatorio.fRetDescricaoInterface;
  TcxCustomComboBoxProperties(cxvParamsPESQUI.Properties).Items.Text := TConsultasRel.fRetDescPesquisas;

  objRelatorio := Nil;

  mnuAutcom := Nil;
  frmFormMenu := Nil;

  TInterfaceRelatorio.pAjustaEditorSQL(bceDefSQL);
  TInterfaceRelatorio.pAjustaEditorSQL(bceSQLFil);

  pHabilitaTela(False);
end;

procedure TfrmCadRelatorios.pSetaDestinos;
  Var
    desIndice: TDestinoRel;
Begin
  For desIndice := Low(ArrDestino) To High(ArrDestino) Do
    If (ArrDestino[desIndice] <> 'Trace') And (ArrDestino[desIndice] <> 'DesignReport') Then
      cklDestin.Items.Add(String(ArrDestino[desIndice]));
End;

procedure TfrmCadRelatorios.pDestinosToCampo;
  Var
    intContador: Integer;
    stlLista: TStringList;
Begin
  If qryTabela.State In dsEditModes Then
  Begin
    stlLista := TStringList.Create;

    For intContador := 0 To cklDestin.Items.Count - 1 Do
      If cklDestin.Checked[intContador] Then
        stlLista.Add(cklDestin.Items[intContador]);

    qryTabela.FieldByName('REL_DESTIN').AsString := stlLista.Text;

    FreeAndNil(stlLista);
  End;

End;

procedure TfrmCadRelatorios.pCampoToDestino;
  Var
    intContador,
    intContador2: Integer;
    stlLista: TStringList;
    desIndice: TDestinoRel;
Begin
  For intContador := 0 To cklDestin.Items.Count - 1 Do
    cklDestin.Checked[intContador] := False;

  stlLista := TStringList.Create;

  stlLista.Text := Trim(qryTabela.FieldByName('REL_DESTIN').AsString);

  If fEmptyStr(stlLista.Text) Then
    For desIndice := Low(ArrDestino) To High(ArrDestino) Do
      If (desIndice In [desVideo, desImpressora, desPDF, desCSV]) Then
        stlLista.Add(String(ArrDestino[desIndice]));

  For intContador2 := 0 To stlLista.Count - 1 Do
    For intContador := 0 To cklDestin.Items.Count - 1 Do
      If SameText(cklDestin.Items[intContador], stlLista[intContador2]) Then
        cklDestin.Checked[intContador] := True;

  FreeAndNil(stlLista);
End;

procedure TfrmCadRelatorios.pInciaRelatorio;
Begin
  If Assigned(objRelatorio) Then
    FreeAndNil(objRelatorio);

  objRelatorio := TRelatorio.Create(Self, False, SameText(qryTabela.FieldByName('REL_CONIND').AsString, 'S'), Nil);

  objRelatorio.objInterface.arrCadRel[0] := qryTabela;

  objRelatorio.objInterface.objConsultasGrid.fCarregaListaConsultas;

  cxvColunasPorLinha.DataController.DataSource := objRelatorio.objInterface.cdsColunasPorLinha.dtsSource;
  cxvColunasPorLinhaDashboard.DataController.DataSource := objRelatorio.objInterface.cdsColunasPorLinha.dtsSource;

  cxvGruposPar.DataController.DataSource := objRelatorio.objInterface.cdsGruposParams.dtsSource;
  cxvGruposCam.DataController.DataSource := objRelatorio.objInterface.cdsGruposParams.dtsSource;

  cxvParams.DataController.DataSource    := objRelatorio.objInterface.cdsParams.dtsSource;
  cxvCampos.DataController.DataSource    := objRelatorio.objInterface.cdsCampos.dtsSource;
  cxvLinhas.DataController.DataSource    := objRelatorio.objInterface.cdsLinhas.dtsSource;
  cxvRelat.DataController.DataSource     := objRelatorio.objInterface.cdsComplementos.dtsSource;
  cxvChirel.DataController.DataSource    := objRelatorio.objInterface.cdsChilds.dtsSource;
  cxvHisto.DataController.DataSource     := objRelatorio.objInterface.cdsHistoricos.dtsSource;
  cxvDirRel.DataController.DataSource    := objRelatorio.objInterface.cdsDirAcesso.dtsSource;

  cxvBotFil.DataController.DataSource  := objRelatorio.objRotinasFiltro.cdsRotinasRelatorio.dtsSource;
  cxvBotGrid.DataController.DataSource := objRelatorio.objRotinasGrid.cdsRotinasRelatorio.dtsSource;
  cxlRotinaFil.Properties.ListSource  := objRelatorio.objRotinasFiltro.dtsSource;
  cxlRotinaGrid.Properties.ListSource := objRelatorio.objRotinasGrid.dtsSource;

  cxlCampos.Properties.ListSource                := objRelatorio.objInterface.cdsCampos.dtsSource;
  cxlCampoReferenciaRodape.Properties.ListSource := objRelatorio.objInterface.cdsCamposRodape.dtsSource;
  cxvRodapeGrid.DataController.DataSource        := objRelatorio.objInterface.cdsCamposRodape.dtsSource;

  objRelatorio.objInterface.cdsCampos.AfterPost   := pAfterPostCampos;
  objRelatorio.objInterface.cdsCampos.AfterScroll := pAfterScrollCampos;

  objRelatorio.objInterface.cdsParams.AfterPost   := pAfterPostParams;

  objRelatorio.objInterface.imgFundo     := imgFundo;
  objRelatorio.objInterface.scrLinhas    := scrLinhas;
  objRelatorio.objInterface.frmRelatorio := Self;

  objRelatorio.objInterface.pCarregaSistemaVerdeVermelho;

  dtsGruPar.DataSet := objRelatorio.objInterface.cdsGruposParams;

  dtsTipBan.DataSet := objRelatorio.objInterface.cdsTiposBanda;

  objRelatorio.objInterface.fCarregaProporcao;
  TcxLookupComboBoxProperties(cxvColunasPorLinhaDashboardPROPOR.Properties).ListSource := objRelatorio.objInterface.cdsProporcaoPorLinha.dtsSource;
End;

procedure TfrmCadRelatorios.FormDestroy(Sender: TObject);
begin

  FreeAndNil(stlCampos);
  FreeAndNil(stlCamInd);
  FreeAndNil(stlDesInd);

  If Assigned(objRelatorio) Then
    FreeAndNil(objRelatorio);

  inherited;
end;

procedure TfrmCadRelatorios.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F5: btnCadTem.Click;
    VK_F9: btnCamAut.Click;
  End;
end;

Function TfrmCadRelatorios.fGetCursorPosX: Word;
  Var
    ponto: TPoint;
Begin
  ponto := Self.ClientOrigin;
  ponto.X := mouse.CursorPos.X - ponto.X;

  If ponto.X > Self.Width Then
    ponto.X := -1;

  Result := ponto.X;
End;

procedure TfrmCadRelatorios.FormShow(Sender: TObject);
begin
  inherited;

  pHabilitaPaginas(False);

  If btnIncluir.Enabled Then
    pSetFocus(btnIncluir);

  btnIncMen.Visible := Assigned(objRelMenu);

  dbeGatInf.Visible := fCfgSis('GATINF', varBoolean);

  grpDashWeb.Visible := False;

  If (Not Assigned(mnuAutcom)) And Assigned(frmPrincipal) Then
  Begin
    mnuAutcom   := frmPrincipal.mnuAutcomK;
    frmFormMenu := frmPrincipal;
  End;
end;

Procedure TfrmCadRelatorios.pAjustaSplit;
Begin
  dbeSplit.Enabled := ((rdgOrient.ItemIndex = 0) And (fStrToFloat(dbeFatSca.Text) > 1));

  If Not dbeSplit.Enabled Then
    dbeSplit.Checked := False;
End;

function TfrmCadRelatorios.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = dbeCodigo) Then
    Begin

      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Relatório deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Nome do Relatório deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeCodMod) Then
    Begin

      If grbModelo.Enabled Then
      Begin
        If fEmptyStr(dbeCodMod.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Modelo do Relatório deve ser preenchido!', ['&Ok']);
          Result := False;
        End Else
        Begin
          edtModDes.Text := fCampoTabela('MOD_DESCRI', 'CADMOD', ['MOD_CODMOD'], [dbeCodMod.Text]);

          If fEmptyStr(edtModDes.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Código do Modelo não encontrado!', ['&Ok']);
            Result := False;
          End Else
          Begin
            If qryTabela.State In dsEditModes Then
              qryTabela.FieldByName('REL_TIPIMP').AsString := fCampoTabela('MOD_TIPIMP', 'CADMOD', ['MOD_CODMOD'], [dbeCodMod.Text]);

            pAjustaModelo;

          End;

        End;

        pHabilitaPaginas(Result);

      End;
    End

    Else If (Sender = dbePapHei) Then
    Begin

      If pnlJato.Visible And dbePapHei.Enabled And (fStrToFloat(dbePapHei.Text) <= 0) And (dbeTipFol.Text <> 'T40') Then
      Begin
        pMensagemOk('Informe a altura da página do relatório!');
        Result := False;
      End;

    End

    Else If (Sender = dbeGatInf) And dbeGatInf.Visible Then
    Begin
      If dbeGatInf.Checked
        And (Not qryTabela.FieldByName('REL_DESTIN').AsString.Contains('PDF')
            and ((Not qryTabela.FieldByName('REL_DESTIN').AsString.Contains('Dashboard')))) Then
      Begin
        pMensagemOk('Um relatório somente pode ser utilizado nos "Gatilhos de Informação" '+
          'quando possuir como um dos destinos a opção "PDF" ou "Gráficos Web"!');
        dbeGatInf.Field.AsString := 'N';
        Result := False;
      End
      Else If dbeGatInf.Checked And (qryTabela.FieldByName('REL_PASSAI').AsString = 'S') Then
      Begin
        pMensagemOk('Um relatório somente pode ser utilizado nos "Gatilhos de Informação" '+
          'quando possuir a opção "Pedir pasta de saída (CSV/PDF/TXT/XML)" desmarcada!');
        dbeGatInf.Field.AsString := 'N';
        Result := False;
      End
      Else If dbeGatInf.Checked And (qryTabela.FieldByName('REL_CODPAI').AsString <> '') Then
      Begin
        pMensagemOk('Um relatório somente pode ser utilizado nos "Gatilhos de Informação" '+
          'quando não possuir a opção "Relatório Pai" preenchida!');
        dbeGatInf.Field.AsString := 'N';
        Result := False;
      End
      Else If not dbeGatInf.Checked and fVerificaSeRelatorioEstaNosGatilhos Then
      Begin
        pMensagemOk('O relatório já esta sendo utilizado nos "Gatilhos de Informação". ' + #10#13 +
          'Primeiro o remova do cadastro de Gatilhos de Informação!');
        dbeGatInf.Field.AsString := 'S';
        Result := False;
      End;
      {Else If dbeGatInf.Checked And (Not objRelatorio.objInterface.cdsParams.Locate('PAR_NOMPAR', 'DTAINI', [])) Then
      Begin
        pMensagemOk('Um relatório somente pode ser utilizado nos "Gatilhos de Informação" '+
          'quando possuir o filtro de "Data Inicial - DTAINI"!');
        dbeGatInf.Field.AsString := 'N';
        Result := False;
      End
      Else If dbeGatInf.Checked And (Not objRelatorio.objInterface.cdsParams.Locate('PAR_NOMPAR', 'DTAFIN', [])) Then
      Begin
        pMensagemOk('Um relatório somente pode ser utilizado nos "Gatilhos de Informação" '+
          'quando possuir o filtro de "Data Final - DTAFIN"!');
        dbeGatInf.Field.AsString := 'N';
        Result := False;
      End}
    End

    Else If (Sender = dbeFatSca) Then
    Begin

      If pnlJato.Visible Then
      Begin
        If (fStrToFloat(dbeFatSca.Text) < 1) Then
          dbeFatSca.Text := '1';

        If (fStrToFloat(dbeFatSca.Text) > 6) Then
        Begin
          pMensagemOk('O fator de ampliação deve estar entre 1 e 6!');
          Result := False;
        End;

        pAjustaSplit;
      End;

    End

    Else If (Sender = edtNovGru) Or (Sender = edtGruCam)  Then
    Begin

      If blnBuscaPorChave Then
      Begin

        If Not fEmptyStr(TEditFocus(Sender).Text) Then
        Begin
          objRelatorio.objInterface.pInsereNovoGrupo(TEditFocus(Sender).Text, (Sender = edtNovGru), False);
          TEditFocus(Sender).Clear;
          blnMudarFoco := False;
        End;

      End;
    End

    Else If (Sender = debQTDCOLTXT) Then
    Begin

      If pnlTXT.Visible Then
      Begin

        If StrToIntDef(debQTDCOLTXT.Text, -1) <= 0 Then
        Begin
          pMensagemOk('Informe a quantidadde máxima de colunas para o relatório TXT !');
          Result := False;
        End;

      End;

    End

    Else If (Sender = dbeCodVal) Then
    Begin

      If pnlTXT.Visible Then
      Begin

        If fEmptyStr(dbeCodVal.Text) Then
        Begin
          edtDesCodVal.Clear;
        End Else
        Begin

          edtDesCodVal.Text := fRetNomeRelatorio(dbeCodVal.Text);

          If fEmptyStr(edtDesCodVal.Text) Then
          Begin
            pMensagemOk('Relatório de validação não encontrado!');
            Result := False;
          End;

        End;

      End;

    End

    Else If (Sender = edtCodRelFil) Then
    Begin

      If fEmptyStr(edtCodRelFil.Text) Then
      Begin
        edtCodRelFilDes.Clear;
      End Else
      Begin

        edtCodRelFilDes.Text := fRetNomeRelatorio(edtCodRelFil.Text);

        If fEmptyStr(edtCodRelFilDes.Text) Then
        Begin
          pMensagemOk('Relatório não encontrado!');
          Result := False;
        End;

      End;

    End

    Else If (Sender = edtCodRelGrid) Then
    Begin

      If fEmptyStr(edtCodRelGrid.Text) Then
      Begin
        edtCodRelGridDes.Clear;
      End Else
      Begin

        edtCodRelGridDes.Text := fRetNomeRelatorio(edtCodRelGrid.Text);

        If fEmptyStr(edtCodRelGridDes.Text) Then
        Begin
          pMensagemOk('Relatório não encontrado!');
          Result := False;
        End;

      End;

    End

    Else If (Sender = dbeCodPai) Then
    Begin

      If fEmptyStr(dbeCodPai.Text) Then
      Begin
        edtDesCodPai.Clear;
      End Else
      Begin

        edtDesCodPai.Text := fRetNomeRelatorio(dbeCodPai.Text);

        If fEmptyStr(edtDesCodPai.Text) Then
        Begin
          pMensagemOk('Relatório pai não encontrado!');
          Result := False;
        End;

      End;

    End

    Else If (Sender = dbePasSai) Then
    Begin
      If dbePasSai.Checked And (qryTabela.FieldByName('REL_GATINF').AsString = 'S') Then
      Begin
        pMensagemOk('Relatórios já utilizados como "Gatilho de Informação" não devem '+
          'possuir a opção "Pedir pasta de saída (CSV/PDF/TXT/XML)" habilitado!');
        dbePasSai.Field.AsString := 'N';
        Result := False;
      End
    End

    Else If (Sender = dbeWIDDIS) Then
    Begin
      If fEmptyStr(dbeWIDDIS.Text) Then
      Begin
        edtDescCadFil.Clear;
      End Else
      Begin
        edtDescCadFil.Text := fCampoTabela('FIL_DESFIL', 'CADFIL', ['FIL_IDFILA'], [dbeWIDDIS.Text]);

        If fEmptyStr(edtDescCadFil.Text) Then
        Begin
          pMensagemOk('ID de Disparo do Whatsapp não cadastrado!');
          Result := False;
        End;
      End;

      pAjustaConfiguracoesWhatsapp;
    End

    Else If (Sender = dbeWIDTEM) Then
    Begin

      If fEmptyStr(dbeWIDTEM.Text) Then
      Begin

        If fEmptyStr(dbeWIDDIS.Text) Then
        Begin

          If fCampoTabela('FIL_APIOFI', 'CADFIL', ['FIL_IDFILA'], [fRetFilaEnvioWhatsAppOperador(fCfgSis('GATOPE'))]) = 'S' Then
          Begin
            pMensagemOk('A fila cadastrada para o operador (CFG_GATOPE) é uma fila oficial portanto o ID do Template deve ser informado!');
            pgcDados.ActivePage := tbsWhatsApp;
            Result := False;
          End;

        End

        Else If fCampoTabela('FIL_APIOFI', 'CADFIL', ['FIL_IDFILA'], [dbeWIDDIS.Text]) = 'S' Then
        Begin
          pMensagemOk('ID de Disparo do Whatsapp é uma fila oficial portanto o ID do Template deve ser informado!');
          pgcDados.ActivePage := tbsWhatsApp;
          Result := False;
        End;

      End;

    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadRelatorios.pAjustaConfiguracoesWhatsapp;
var
  blnFilaOficial: Boolean;
begin
  if not fEmptyStr(dbeWIDDIS.Text) then
    blnFilaOficial := fCampoTabela('FIL_APIOFI', 'CADFIL', ['FIL_IDFILA'], [dbeWIDDIS.Text]) = 'S'
  else
    blnFilaOficial := fCampoTabela('FIL_APIOFI', 'CADFIL', ['FIL_IDFILA'], [fRetFilaEnvioWhatsAppOperador(fCfgSis('GATOPE'))]) = 'S';

  dbeWIDTEM.Visible := blnFilaOficial;
  Label92.Visible := blnFilaOficial;
  Panel42.Visible := blnFilaOficial;
  dbeCAMIDT.Visible := blnFilaOficial;

  if not blnFilaOficial then
  begin
    dbeWIDTEM.Clear;
    dbeCAMIDT.Clear;
  end;
end;

procedure TfrmCadRelatorios.pAcertaAlturaPaineis;
Begin
  pnlInterGrafica.Height := pnlTitGraf.Height + scrLinhas.Height;
  pnlRodape.Height := pnlInterGrafica.Height + pnlGridLargura.Height;
End;

procedure TfrmCadRelatorios.pEditorToTabela;
Begin
  TfrmGravando.fExecuta(fEditorToTabelaPrg, FGravandoEditorToTabela, '', False);
End;

Function TfrmCadRelatorios.fTiraLinhasComentario(strSQL: String): String;
  Var
    stlSQL: TStringList;
    strLinha: String;
    intContador: Integer;
Begin
  stlSQL := TStringList.Create;
  stlSQL.Text := strSQL;

  intContador := 0;

  While intContador < stlSQL.Count Do
  Begin
    strLinha := Trim(stlSQL[intContador]);

    If AnsiStartsStr('-- ', strLinha) Then
      stlSQL.Delete(intContador)
    Else
      Inc(intContador);

  End;

  Result := stlSQL.Text;

  FreeAndNil(stlSQL);
End;

Function TfrmCadRelatorios.fEditorToTabelaPrg(prgProgresso: TcxProgressBar): Boolean;
Begin
  Result := True;

  With qryTabela Do
  If State In dsEditModes Then
  Begin
    FGravandoEditorToTabela.lblGravando.Caption := 'Salvando SQL sem mudança de linha e TAB';
    Application.ProcessMessages;
    FieldByName('REL_SQLDEF').AsString := fTiraLinhasComentario(AnsiReplaceStr(bceDefSQL.Text, #9, ' '));

    FGravandoEditorToTabela.lblGravando.Caption := 'Replace REL_DEFSQL #13#10 para <<csq>>';
    Application.ProcessMessages;
    FieldByName('REL_DEFSQL').AsString := AnsiReplaceStr(bceDefSQL.Text, #13#10, '<<csq>>');

    FGravandoEditorToTabela.lblGravando.Caption := 'Replace REL_SQLFIL #13#10 para <<csq>>';
    Application.ProcessMessages;
    FieldByName('REL_SQLFIL').AsString := AnsiReplaceStr(bceSQLFil.Text, #13#10, '<<csq>>');

    FGravandoEditorToTabela.lblGravando.Caption := 'Replace REL_VALSQL #13#10 para <<csq>>';
    Application.ProcessMessages;
  End;
End;

procedure TfrmCadRelatorios.pCarregaDadosCadRel;
  Var
    strTipImp: String;
Begin
  bceDefSQL.Text := AnsiReplaceStr(qryTabela.FieldByName('REL_DEFSQL').AsString, '<<csq>>', #13#10);
  bceSQLFil.Text := AnsiReplaceStr(qryTabela.FieldByName('REL_SQLFIL').AsString, '<<csq>>', #13#10);
  dbeDesCmp.Text := AnsiReplaceStr(qryTabela.FieldByName('REL_DESCMP').AsString, '<<csq>>', #13#10);

  stmSCRBEF.Lines.Text := AnsiReplaceStr(qryTabela.FieldByName('REL_SCRBEF').AsString, '<<csq>>', #13#10);

  cbxTipTot.ItemIndex := StrToIntDef(qryTabela.FieldByName('REL_TIPTOT').AsString, 0);

  edtZooIni.Value    := qryTabela.FieldByName('REL_ZOOINI').AsInteger;
  edtNumCol.Value    := qryTabela.FieldByName('REL_NUMCOL').AsInteger;

  edtMarEsq.Value    := qryTabela.FieldByName('REL_MARESQ').AsInteger;
  edtMarDir.Value    := qryTabela.FieldByName('REL_MARDIR').AsInteger;

  If qryTabela.FieldByName('REL_ORIENT').AsString = 'R' Then
    rdgOrient.ItemIndex := 0
  Else
    rdgOrient.ItemIndex := 1;

  Case AnsiIndexStr(qryTabela.FieldByName('REL_PGRCPE').AsString, ['S', 'D']) of
    0: rdgPGRCPE.ItemIndex := 0;
    1: rdgPGRCPE.ItemIndex := 1;
  Else
    rdgPGRCPE.ItemIndex := 2;
  End;

  edtModDes.Text := fCampoTabela('MOD_DESCRI', 'CADMOD', ['MOD_CODMOD'], [dbeCodMod.Text]);

  edtDescCadFil.Text := fCampoTabela('FIL_DESFIL', 'CADFIL', ['FIL_IDFILA'], [dbeWIDDIS.Text]);

  strTipImp := fCampoTabela('MOD_TIPIMP', 'CADMOD', ['MOD_CODMOD'], [dbeCodMod.Text]);

  If qryTabela.State In dsEditModes Then
    qryTabela.FieldByName('REL_TIPIMP').AsString := strTipImp;

  If pnlInterGrafica.Visible Then
    pnlRodape.Height := pnlInterGrafica.Height + pnlGridLargura.Height
  Else
    pnlRodape.Height := pnlGridLargura.Height;

  objRelatorio.objInterface.strIdentRel := 'Relatorio' + dbeCodMod.Text;

  If (qryTabela.FieldByName('REL_FILIMP').AsString <> '') Then
    objRelatorio.objInterface.strIdentRel := qryTabela.FieldByName('REL_FILIMP').AsString;

  pAtualizaSQL;

  pAjustaModelo;

  objRelatorio.objInterface.pMoldura(Not fArquivoTXTMarcado);
  pAcertaAlturaPaineis;

  fAtualizaLarguraMaxima;

  objRelatorio.objInterface.pCriaComponentes;
End;

procedure TfrmCadRelatorios.pAjustaModelo;
  Var
    blnModTXT, blnModPer: Boolean;
Begin
  blnModTXT := fArquivoTXTMarcado;
  blnModPer := dbeFr3per.Checked;

  blnDestinoDashboard := fTemDestinoGraficoDashboard;

  If blnModTXT Then
  Begin
    pnlMatricial.Visible := False;
    pnlJato.Visible      := False;
    pInicializaQTDCOLTXT;

    If qryTabela.State In dsEditModes Then
    Begin
      qryTabela.FieldByName('REL_CODMOD').AsString := '500002';
      qryTabela.FieldByName('REL_TIPIMP').AsString := 'M';
    End;

    If Assigned(objRelatorio.objGeraFr3) Then
      objRelatorio.objGeraFr3.strTipImp := 'M';

    If Assigned(objRelatorio.objInterface) Then
      objRelatorio.objInterface.pMoldura(False);

    pHabilitaPaginas(True);

  End Else
  Begin
    pnlJato.Visible      := SameText(qryTabela.FieldByName('REL_TIPIMP').AsString, 'J');
    pnlMatricial.Visible := SameText(qryTabela.FieldByName('REL_TIPIMP').AsString, 'M');
  End;

  pnlTXT.Visible := blnModTXT;

  pnlXML.Visible := fArquivoXMLMarcado;

  pnlArqSai.Visible := fDestinoMarcado(desArquivoSaida);

  grbModelo.Visible       := ((Not blnModTXT) And (Not blnModPer));
  grbFiltroComp.Visible   := ((Not blnModTXT) And (Not blnModPer));
  grbCSV.Visible          := ((Not blnModTXT) And (Not blnModPer));
  grbZebra.Visible        := ((Not blnModTXT) And (Not blnModPer));
  dbeEXLIBR.Visible       := ((Not blnModTXT) And (Not blnModPer));
  lblNumCol.Visible       := ((Not blnModTXT) And (Not blnModPer));
  edtNumCol.Visible       := ((Not blnModTXT) And (Not blnModPer));
  grpExportArqPdf.Visible := ((Not blnModTXT) And (Not blnModPer));

  lblMarEsq.Visible       := ((Not blnModTXT) And (Not blnModPer));
  edtMarEsq.Visible       := ((Not blnModTXT) And (Not blnModPer));
  lblMarDir.Visible       := ((Not blnModTXT) And (Not blnModPer));
  edtMarDir.Visible       := ((Not blnModTXT) And (Not blnModPer));

  grpConfgsGrid.Visible   := ((Not blnModTXT) And (Not blnModPer));
  grbJato.Visible       := Not blnModPer;

  lblTitQue.Visible        := ((Not blnModTXT) And (Not blnModPer));
  cbxTitQue.Visible        := ((Not blnModTXT) And (Not blnModPer));
  pnlDetalheTotais.Visible := ((Not blnModTXT) And (Not blnModPer));

  pAjustaNumeroPaginas;


  tbsGrafico.TabVisible := Not blnDestinoDashboard;
  tbsDashboard.TabVisible := blnDestinoDashboard;
End;

procedure TfrmCadRelatorios.pAjustaNumeroPaginas;
  Var
    intContador,
    intPagVisible: Integer;
    strTitulo: String;
Begin
  intPagVisible := 0;

  For intContador := 0 To pgcDados.PageCount - 1 Do
  Begin
    strTitulo := pgcDados.Pages[intContador].Caption;

    If Pos(' - ', strTitulo) > 0 Then
      System.Delete(strTitulo, 1, Pos(' - ', strTitulo) + 2);

    If pgcDados.Pages[intContador].TabVisible Then
    Begin
      Inc(intPagVisible);

      pgcDados.Pages[intContador].Caption := IntToStr(intPagVisible) + ' - ' + strTitulo;
    End Else
    Begin
      pgcDados.Pages[intContador].Caption := strTitulo;
    End;

  End;
End;

procedure TfrmCadRelatorios.pInicializaQTDCOLTXT;
Begin
  If qryTabela.FieldByName('REL_QTDCOL').AsInteger = 0 Then
  Begin
    If qryTabela.State In dsEditModes Then
      qryTabela.FieldByName('REL_QTDCOL').AsInteger := 100;
  End
End;

procedure TfrmCadRelatorios.pCarregaDados;
Begin
  TfrmGravando.fExecuta(fCarregaDadosPrg, FGravando, '', False);
End;

Function TfrmCadRelatorios.fCarregaDadosPrg(prgProgresso: TcxProgressBar): Boolean;
Begin
  Result := True;

  If Not Assigned(objRelatorio) Then
    Exit;

  pCampoToDestino;

  With objRelatorio, objGeraFr3 Do
  Begin
    blnCarregouPagina := False;

    objInterface.blnCarregarCamposAuto := qryTabela.FieldByName('REL_CAMAUT').AsString <> 'N';

    FGravando.lblGravando.Caption := 'Carregando parâmetros...';
    Application.ProcessMessages;
    objInterface.fCarregaParametros(qryTabela.FieldByName('AUTOINCREM').AsString,
                                    qryTabela.FieldByName('REL_COMFIL').AsString);

    FGravando.lblGravando.Caption := 'Carregando campos...';
    Application.ProcessMessages;
    objInterface.fCarregaCampos(qryTabela.FieldByName('AUTOINCREM').AsString);
    objInterface.fCarregaCamposRodape(qryTabela.FieldByName('AUTOINCREM').AsString);

    FGravando.lblGravando.Caption := 'Carregando complementos...';
    Application.ProcessMessages;
    objInterface.fCarregaComplementos(qryTabela.FieldByName('AUTOINCREM').AsString);
    objInterface.fCarregaChilds(qryTabela.FieldByName('AUTOINCREM').AsString);

    FGravando.lblGravando.Caption := 'Carregando históricos...';
    Application.ProcessMessages;
    objInterface.fCarregaHistoricos(qryTabela.FieldByName('REL_CHAVE_').AsString);

    FGravando.lblGravando.Caption := 'Carregando direitos de acesso...';
    Application.ProcessMessages;
    objInterface.fCarregaDirAcesso(qryTabela.FieldByName('AUTOINCREM').AsString);

    TcxComboBoxProperties(cxvCamposLISQUE.Properties).Items.Text := objInterface.fRetQuebras(True);
    TcxComboBoxProperties(cxvChirelNomCam.Properties).Items.Text := objInterface.fRetQuebras(True);

    objRotinasFiltro.fCarregaRotinasRelatorio(qryTabela.FieldByName('AUTOINCREM').AsString);
    objRotinasGrid.fCarregaRotinasRelatorio(qryTabela.FieldByName('AUTOINCREM').AsString);

    FGravando.lblGravando.Caption := 'Carregando registro dados...';
    Application.ProcessMessages;
    pCarregaDadosCadRel;

    objInterface.pCompCarregaComplementosChilds;

    If Not fEmptyStr(qryTabela.FieldByName('REL_TITQUE').AsString) Then
    Case qryTabela.FieldByName('REL_TITQUE').AsString[1] Of
      'S': cbxTitQue.ItemIndex := IIF(qryTabela.FieldByName('REL_ULTQUE').AsString = 'N', 0, 4);
      'N': cbxTitQue.ItemIndex := 1;
      'D': cbxTitQue.ItemIndex := 2;
      '3': cbxTitQue.ItemIndex := 3;
      Else cbxTitQue.ItemIndex := 0;
    End;

    If Not fEmptyStr(qryTabela.FieldByName('REL_TOTINI').AsString) Then
    Case qryTabela.FieldByName('REL_TOTINI').AsString[1] Of
      '0': cbxTotIni.ItemIndex := 0;
      '1': cbxTotIni.ItemIndex := 1;
      Else cbxTotIni.ItemIndex := 2;
    End;

    If Not fEmptyStr(qryTabela.FieldByName('REL_FILPRI').AsString) Then
    Case qryTabela.FieldByName('REL_FILPRI').AsString[1] Of
      'S': cbxFilPri.ItemIndex := 0;
      'N': cbxFilPri.ItemIndex := 1;
      'X': cbxFilPri.ItemIndex := 2;
      Else cbxFilPri.ItemIndex := 0;
    End;

    If Not fEmptyStr(qryTabela.FieldByName('REL_TITPOS').AsString) Then
    Case qryTabela.FieldByName('REL_TITPOS').AsString[1] Of
      'S': cbxTitPos.ItemIndex := 1;
      'N': cbxTipTot.ItemIndex := 0;
      'A': cbxTitPos.ItemIndex := 2;
      Else cbxTitPos.ItemIndex := 0;
    End;

    If Not fEmptyStr(qryTabela.FieldByName('REL_HORIZO').AsString) Then
    Begin

      Case qryTabela.FieldByName('REL_HORIZO').AsString[1] Of
        'N': cbxHorizo.ItemIndex := 0;
        'S': cbxHorizo.ItemIndex := 1;
        'I': cbxHorizo.ItemIndex := 2;
        Else cbxHorizo.ItemIndex := 0;
      End;

    End Else cbxHorizo.ItemIndex := 0;

    FGravando.lblGravando.Caption := 'Ajustando tela...';
    Application.ProcessMessages;

    pAjustaInfHei;

    TFloatField(qryTabela.FieldByName('REL_PAPHEI')).DisplayFormat := fMskDigitos(2);
  End;

  edtDesCodPai.Text := fRetNomeRelatorio(dbeCodPai.Text);
  edtDesCodVal.Text := fRetNomeRelatorio(dbeCodVal.Text);

  FGravando.lblGravando.Caption := 'Filtrando grupos...';
  Application.ProcessMessages;
  pFiltraGrupo;

  pCarregaDadosGrafico;

  pAjustaTipoAlinhamentoRodape;
End;

Procedure TfrmCadRelatorios.pCarregaDadosGrafico;
Begin

  If Not fEmptyStr(qryTabela.FieldByName('REL_MOLGRA').AsString) Then
  Case qryTabela.FieldByName('REL_MOLGRA').AsString[1] Of
    'R': cmbMolGra.ItemIndex := 1;
    Else cmbMolGra.ItemIndex := 0;
  End;

  cmbValCap.ItemIndex := qryTabela.FieldByName('REL_VALCAP').AsInteger;
  cmbLinCap.ItemIndex := qryTabela.FieldByName('REL_LINCAP').AsInteger;
  cmbPieCap.ItemIndex := qryTabela.FieldByName('REL_PIECAP').AsInteger;
  cmbLinSty.ItemIndex := qryTabela.FieldByName('REL_LINSTY').AsInteger;
  cmbMarSty.ItemIndex := qryTabela.FieldByName('REL_MARSTY').AsInteger;
  cmbPosTit.ItemIndex := qryTabela.FieldByName('REL_POSTIT').AsInteger;
  cmbPosLeg.ItemIndex := qryTabela.FieldByName('REL_POSLEG').AsInteger;
  cmbAliTit.ItemIndex := qryTabela.FieldByName('REL_ALITIT').AsInteger;
  cmbAliLeg.ItemIndex := qryTabela.FieldByName('REL_ALILEG').AsInteger;

  objRelatorio.objInterface.fCarregaColunhasPorLinha;

  If Assigned(objRelatorio) And
     Assigned(objRelatorio.objInterface) And
     Assigned(objRelatorio.objInterface.cdsColunasPorLinha) Then
   cxvColunasPorLinha.OptionsData.Editing := dbeInfCol.Checked;
End;

Procedure TfrmCadRelatorios.pSalvaDadosGrafico;
Begin
  If Not (qryTabela.State In dsEditModes) Then
    Exit;

  If Not fEmptyStr(qryTabela.FieldByName('REL_MOLGRA').AsString) Then
  Case cmbMolGra.ItemIndex Of
    0  : qryTabela.FieldByName('REL_MOLGRA').AsString := 'A';
    Else qryTabela.FieldByName('REL_MOLGRA').AsString := 'R';
  End;

  qryTabela.FieldByName('REL_VALCAP').AsInteger := cmbValCap.ItemIndex;
  qryTabela.FieldByName('REL_LINCAP').AsInteger := cmbLinCap.ItemIndex;
  qryTabela.FieldByName('REL_PIECAP').AsInteger := cmbPieCap.ItemIndex;
  qryTabela.FieldByName('REL_POSTIT').AsInteger := cmbPosTit.ItemIndex;
  qryTabela.FieldByName('REL_POSLEG').AsInteger := cmbPosLeg.ItemIndex;
  qryTabela.FieldByName('REL_ALITIT').AsInteger := cmbAliTit.ItemIndex;
  qryTabela.FieldByName('REL_ALILEG').AsInteger := cmbAliLeg.ItemIndex;
  qryTabela.FieldByName('REL_LINSTY').AsInteger := cmbLinSty.ItemIndex;
  qryTabela.FieldByName('REL_MARSTY').AsInteger := cmbMarSty.ItemIndex;

  objRelatorio.objInterface.pSalvaColunhasPorLinha;
End;

procedure TfrmCadRelatorios.pAfterScrollCampos(dataSet: TDataSet);
Begin
  With dataSet Do
  Begin
    If DataSet.ControlsDisabled Then
      Exit;

    cxvCamposLINQUE.Options.Editing := Not fEmptyStr(FieldByName('CAM_LISQUE').AsString);
    cxvCamposLISQUE.Options.Editing := fEmptyStr(FieldByName('CAM_TOTALI').AsString);
    cxvCamposQUEBRA.Options.Editing := objRelatorio.objInterface.fPodeQuebrar(FieldByName('CAM_NOMCAM').AsString);

  End;
End;

procedure TfrmCadRelatorios.pAfterPostCampos(dataSet: TDataSet);
  Var
    intRecNo: Integer;
Begin
  Try
    objRelatorio.objInterface.pCopiaCampoRodape(TZClient(dataSet), objRelatorio.objInterface.cdsCamposRodape);

    cxvCampos.DataController.DataModeController.SyncMode := False;

    With dataSet Do
    Begin
      intRecNo := RecNo;
      objRelatorio.objInterface.cdsCampos.AfterPost := Nil;

      objRelatorio.objInterface.pAtualizaLarguraCampo;

      objRelatorio.objInterface.pAjustaQuebras;

      TcxComboBoxProperties(cxvCamposLISQUE.Properties).Items.Text := objRelatorio.objInterface.fRetQuebras(True);

      objRelatorio.objInterface.cdsCampos.AfterPost := pAfterPostCampos;

      fAtualizaLarguraMaxima;

      RecNo := intRecNo;
     End;

    cxvCampos.DataController.DataModeController.SyncMode := True;

   Except
     On E: Exception Do
     Begin
       objRelatorio.objInterface.cdsCampos.AfterPost := pAfterPostCampos;
       pMensagensErro(E.Message, 'TfrmCadRelatorios.pAfterPostCampos');
     End;
   End;

  pAfterScrollCampos(dataSet);
End;

procedure TfrmCadRelatorios.pAfterPostParams(dataSet: TDataSet);
Begin
  With dataSet, objRelatorio.objInterface Do
  Begin
    If (Not SameText(strTipFacAnterior, cdsParams.FieldByName('PAR_TIPFAC').AsString)) And
       (Not fParametroBasico(cdsParams.FieldByName('PAR_TIPFAC').AsString)) Then
     pPedeDadosInterface;
  End;
End;

Function TfrmCadRelatorios.fAtualizaLarguraMaxima: Boolean;
  Var
    intContador,
    intRecNo: Integer;
Begin
  Result := False;

  With objRelatorio, objGeraFr3, qryTabela Do
  If Not fAtualizaPapel(qryTabela) Then
    Exit;

  intRecNo := objRelatorio.objInterface.cdsCampos.RecNo;

  If SameText(qryTabela.FieldbyName('REL_TIPIMP').AsString, 'J') Then
  Begin
    cxgCamposLARGUR.Caption := 'Largura (cm)';
    TcxCurrencyEditProperties(cxgCamposLARGUR.Properties).DisplayFormat := '0.00;-0.00';
  End Else
  Begin
    cxgCamposLARGUR.Caption := 'Quant. Colunas';
    TcxCurrencyEditProperties(cxgCamposLARGUR.Properties).DisplayFormat := '0;-0';
  End;

  For intContador := 0 To cxvLinhas.ColumnCount - 1 Do
    If SameText(qryTabela.FieldbyName('REL_TIPIMP').AsString, 'J') Then
      TcxCurrencyEditProperties(cxvLinhas.Columns[intContador].Properties).DisplayFormat := '0.00;-0.00'
    Else
      TcxCurrencyEditProperties(cxvLinhas.Columns[intContador].Properties).DisplayFormat := '0;-0';

  objRelatorio.objInterface.pCarregaLargura;

  With objRelatorio, objInterface, cdsLinhas Do
  Begin

    Edit;

    For intContador := 1 To MAX_LINHAS_DETALHE Do
    Begin
      FieldByName('LARMA' + IntToStr(intContador)).AsFloat := objGeraFr3.fGetMaxLarCam(objInterface.fGetQtdCamListados(intContador));
      FieldByName('LARCO' + IntToStr(intContador)).AsFloat := objInterface.fGetLarguraUsada(intContador);
    End;

    Post;
  End;

  objRelatorio.objInterface.pMoldura(Not fArquivoTXTMarcado);
  pAcertaAlturaPaineis;

  If intRecNo > 0 Then
    objRelatorio.objInterface.cdsCampos.RecNo := intRecNo;

  Result := True;
End;

procedure TfrmCadRelatorios.pFiltraGrupo;
Begin
  If (pgcDados.ActivePage = tbsGruCam) Or
     (pgcDados.ActivePage = tbsCampos) Then
    objRelatorio.objInterface.pFiltraGrupoParametro('1')

  Else If (pgcDados.ActivePage = tbsGrupoFiltros) Or
          (pgcDados.ActivePage = tbsParametros)  Then
    objRelatorio.objInterface.pFiltraGrupoParametro('0');
End;

procedure TfrmCadRelatorios.pgcDadosChange(Sender: TObject);
begin
  inherited;

  pFiltraGrupo;

  If ((pgcDados.ActivePage = tbsParametros) Or
      (pgcDados.ActivePage = tbsCampos) Or
      (pgcDados.ActivePage = tbsRotinas)) And
     (qryTabela.State In [dsEdit, dsInsert]) Then
  Begin
    If objRelatorio.objInterface.blnCarregarCamposAuto Then
      pAtualizaSQL;

    If objRelatorio.objInterface.blnSQLErro Then
    Begin
      pgcDados.ActivePage := tbsSQL;
      Exit;
    End;
  End;

  If (pgcDados.ActivePage = tbsParametros) Then
    cxvParams.NavigatorButtons.First.Click;

  If (pgcDados.ActivePage = tbsCampos) Then
  Begin
    fAtualizaLarguraMaxima;
    cxvCampos.NavigatorButtons.First.Click;
  End;
end;

procedure TfrmCadRelatorios.rdgOrientClick(Sender: TObject);
begin
  inherited;

  If qryTabela.State In [dsEdit, dsInsert] Then
  Begin
    If rdgOrient.ItemIndex = 0 Then
      qryTabela.FieldByName('REL_ORIENT').AsString := 'R'
    Else
      qryTabela.FieldByName('REL_ORIENT').AsString := 'P';

    pAjustaSplit;
  End;
end;

procedure TfrmCadRelatorios.rdgPGRCPEClick(Sender: TObject);
begin
  inherited;

  If qryTabela.State In [dsEdit, dsInsert] Then
  Begin
    Case rdgPGRCPE.ItemIndex Of
      0: qryTabela.FieldByName('REL_PGRCPE').AsString := 'S';
      1: qryTabela.FieldByName('REL_PGRCPE').AsString := 'D';
    Else
      qryTabela.FieldByName('REL_PGRCPE').AsString := 'N';
    End;
  End;
end;

procedure TfrmCadRelatorios.tbsCompFiltroCabResize(Sender: TObject);
begin
  inherited;
  pnlCompTelaFiltro.Width := tbsCompFiltroCab.Width div 2;
end;

procedure TfrmCadRelatorios.tmrRolagemTimer(Sender: TObject);
begin
  inherited;

  tmrRolagem.Enabled := False;

  If fGetCursorPosX >= 0.95 * Self.Width Then
  Begin

    If scrLinhas.HorzScrollBar.Position < scrLinhas.Width Then
      scrLinhas.HorzScrollBar.Position  := scrLinhas.HorzScrollBar.Position + 20;

  End

  Else If fGetCursorPosX < 0.05 * Self.Width Then
  Begin

    If scrLinhas.HorzScrollBar.Position >= 20 Then
      scrLinhas.HorzScrollBar.Position := scrLinhas.HorzScrollBar.Position - 20;

  End;

  tmrRolagem.Enabled := True;
end;

procedure TfrmCadRelatorios.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
end;

Function TfrmCadRelatorios.fTemDestinoGraficoDashboard: Boolean;
  Var
    intContador: Integer;
Begin
  Result := False;

  For intContador := 0 To cklDestin.Items.Count - 1 Do
    If cklDestin.Checked[intContador] And (TInterfaceRelatorio.fDestinoToTipo(cklDestin.Items[intContador]) In SET_GRAFICO_DASH) Then
    Begin
      Result := True;
      Exit;
    End;
End;

procedure TfrmCadRelatorios.pVerificaFR3Personalizado;
var
  blnFr3Per: Boolean;
  intContador: Integer;
Begin
  blnFr3Per := dbeFr3per.Checked;

  if (qryTabela.State in dsEditModes) then
    if blnFr3Per and (objRelatorio.objInterface.fExisteComplementos) and (objRelatorio.objInterface.fExisteChild) then
      if not fPergunta('Mudar para FR3 Personalizado irá remover todos os complementaries e childs, ' + #13#10 +
                       'gostaria de continuar?') Then
      Begin
        dbeFr3per.Checked := False;
        Exit;
      End;

  if (blnFr3Per) then
  begin
    if Assigned(objRelatorio) then
    Begin
      objRelatorio.objInterface.fExcluiTodosComplementos;
      objRelatorio.objInterface.fExcluiTodasChild;
    End;

    For intContador := 0 To cklDestin.Count - 1 Do
      cklDestin.Checked[intContador] := (Pos(cklDestin.Items[intContador], 'Vídeo_Impressora_PDF_') > 0);
  end;

  pHabilitaPaginas(True);
  pAjustaModelo;

  grbModelo.Enabled := not blnFr3Per;
  cklDestin.Enabled := (not blnFr3Per) And (qryTabela.State In dsEditModes);
End;

end.
