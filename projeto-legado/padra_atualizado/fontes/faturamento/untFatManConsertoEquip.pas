unit untFatManConsertoEquip;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, untDisparaEmailAut,
  Dialogs, untPaiSimples, Grids, DBGridCitel, DBGrids, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, MemoFocus, EditFocus, untConsertoEquipamento,
  Uni, DB, frxClass, frxDBSet, UniClientDataSet, StrUtils, ComboBoxFocus,
  BitBtnLockedIncrem, untFuncoesGenerica,untEnderecoEntrega, MaskUtils,
  frxExportCSVTestabilidade, Vcl.Mask, MaskEditFocus, dxGDIPlusClasses,
  System.ImageList, Vcl.ImgList, QColorLabel, TypesRel, untFuncoesEtiquetas, untFuncFat,
  dxScreenTip, cxClasses, dxCustomHint, cxHint, untEditorFastImpressao, untFatVendas,
  untTypesSistema, untPanelCxItem, Faturamento.Classes.TEmitirPedido, cxProgressBar, untFuncFatTypes,
  untLiberacao, untPnlDadosCliente , untPanelCxClientes, untFuncoesRel, untFuncoesRel2,
  untMskTelefone, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, Vcl.DBCtrls, DBLookupComboBoxFocus,
  cxImageList, ClipBrd, Math, untConsertoEquipMeqMer, untFuncFatImp, untExcel, untMostraDebCtrChq2,
  cxImage, cxCheckBox, cxButtons;

type
  TfrmFatManConsertoEquip = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    pnlButtons: TPanel;
    btnFechar: TBitBtnLocked;
    pnlTotal: TPanel;
    btnImprimir: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    btnAprovada: TBitBtnLocked;
    btnRealizada: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    btnObservacao: TBitBtnLocked;
    btnTermoDev: TBitBtnLocked;
    btnAlteracao: TBitBtnLocked;
    chkAg_Mon: TCheckBox;
    btnManutencao: TBitBtnLocked;
    btnEndEnt: TBitBtnLocked;
    btnHisSta: TBitBtnLocked;
    pnlTabs: TPanel;
    pgcTabs: TPageControl;
    tbsProdutos: TTabSheet;
    tbsServicos: TTabSheet;
    dbgGrid: TDBGridCitel;
    pnlItens: TPanel;
    dtsIteEqu: TDataSource;
    dbgServico: TDBGridCitel;
    pnlServicos: TPanel;
    Label17: TLabel;
    lblValSer: TLabel;
    Label20: TLabel;
    edtCodSe1: TEditFocus;
    edtDesSe1: TEditFocus;
    edtValSe1: TEditFocus;
    btnCancelaSe1: TBitBtnLocked;
    btnAdicionarSe1: TBitBtnLocked;
    edtCodTecSe1: TEditFocus;
    edtDesTecSe1: TEditFocus;
    dtsServico: TDataSource;
    tbsDefeitos: TTabSheet;
    dtsDefeito: TDataSource;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lblEntreg: TLabel;
    lblCodCnd: TLabel;
    lblConPag: TLabel;
    lblForPag: TLabel;
    lblTotPro: TLabel;
    lblTotSer: TLabel;
    lblTotGer: TLabel;
    btnReprovar: TBitBtnLocked;
    btnAddObsTec: TBitBtnLocked;
    btnImpEti: TBitBtnLocked;
    pgbProgresso: TProgressBar;
    btnDevCli: TBitBtnLocked;
    btnConsultaCatalogos: TBitBtnLocked;
    chkBrindeSer: TCheckBox;
    pgcServicos: TPageControl;
    tbsServicosItens: TTabSheet;
    tbsServicosDiscriminacao: TTabSheet;
    edtDisSer: TMemoFocus;
    dbgGridDfe: TDBGridCitel;
    pnlDefeitos: TPanel;
    Label34: TLabel;
    btnCancelaDfe: TBitBtnLocked;
    btnAdicionarDfe: TBitBtnLocked;
    edtCodDfe: TEditFocus;
    edtDesDfe: TEditFocus;
    btnCancelarOS: TBitBtnLocked;
    btnPedCompraItens: TBitBtnLocked;
    btnImpSeparacao: TBitBtnLocked;
    btnImpPed: TBitBtnLocked;
    pnlRealizada: TPanel;
    lblStaRealizada: TLabel;
    cmbStaRealizada: TComboBoxFocus;
    lblRetiradoPor: TLabel;
    edtRetiradoPor: TEditFocus;
    btnDesEsp: TBitBtnLocked;
    lblTotDes: TLabel;
    btnSalRes: TBitBtnLocked;
    lblST: TLabel;
    lblIPI: TLabel;
    lblTotIPI: TLabel;
    lblTotST: TLabel;
    lblTotRef: TLabel;
    lblRef: TLabel;
    btnImpostos: TBitBtnLocked;
    tbsDocsRelacionados: TTabSheet;
    grbDocEntrada: TGroupBox;
    grbDocSaida: TGroupBox;
    edtNumDocEnt: TEditFocus;
    edtEspDocEnt: TEditFocus;
    edtEmpDocEnt: TEditFocus;
    edtChaveNfeEnt: TEditFocus;
    mskDtaDocEnt: TMaskEditFocus;
    lblNumDocEntr: TLabel;
    lblEspDocEnt: TLabel;
    lblEmpDocEnt: TLabel;
    Label25: TLabel;
    Label31: TLabel;
    Panel1: TPanel;
    blnRealizarEntrada: TBitBtnLocked;
    btnVincularEntrada: TBitBtnLocked;
    btnRemoverEntrada: TBitBtnLocked;
    lblEquip: TLabel;
    lnlNumDocSai: TLabel;
    lblEspDocSai: TLabel;
    lblEmpDocSai: TLabel;
    lblDtaDocSai: TLabel;
    edtNumDocSai: TEditFocus;
    edtEspDocSai: TEditFocus;
    edtEmpDocSai: TEditFocus;
    mskDtaDocSai: TMaskEditFocus;
    Panel2: TPanel;
    btnRealizarSaida: TBitBtnLocked;
    btnVincularSaida: TBitBtnLocked;
    btnRemoverSaida: TBitBtnLocked;
    Label24: TLabel;
    edtSerDocEnt: TEditFocus;
    lblSerDocSai: TLabel;
    edtSerDocSai: TEditFocus;
    cmbEquEnt: TComboBoxFocus;
    lblFre: TLabel;
    lblTotFre: TLabel;
    btnReativar: TBitBtnLocked;
    pnlMostraPrecoServ: TPanel;
    FlwPnlButtons: TFlowPanel;
    Panel3: TPanel;
    btnUltimasVendas: TBitBtnLocked;
    btnComunicacaoInterna: TBitBtnLocked;
    btnConsultarCliente: TBitBtnLocked;
    btnImpItensServicos: TBitBtnLocked;
    tbsAcessorios: TTabSheet;
    pnlAcessorios: TPanel;
    lblAcessorio: TLabel;
    btnCancelaAce: TBitBtnLocked;
    btnAdicionarAce: TBitBtnLocked;
    edtCodAce: TEditFocus;
    edtDesAce: TEditFocus;
    dbgGridAce: TDBGridCitel;
    dtsAcessorios: TDataSource;
    pnlGrpBox: TPanel;
    gbDadGerOS: TGroupBox;
    pnlVendedor: TPanel;
    Label3: TLabel;
    Label11: TLabel;
    edtSenVen: TEditFocus;
    edtNomVen: TEditFocus;
    edtCodTec: TEditFocus;
    edtDesTec: TEditFocus;
    pnlRevRetEnt: TPanel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    edtRevend: TEditFocus;
    edtConRet: TEditFocus;
    edtDeiPor: TEditFocus;
    chkVenPre: TCheckBox;
    pnlCliente: TPanel;
    pnlNumeroOS: TPanel;
    lblMargem: TLabel;
    lblEmpresa: TLabel;
    lblStatus: TLabel;
    lblNovaOrdem: TLabel;
    lblProtoc: TLabel;
    edtNumero: TEditFocus;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    edtProtoc: TEditFocus;
    pnlCndPag: TPanel;
    lblCndPag: TLabel;
    Label14: TLabel;
    edtCodCnd: TEditFocus;
    mskCndPag: TMaskEditFocus;
    edtDesCndPag: TEditFocus;
    edtForPag: TEditFocus;
    edtDesForPag: TEditFocus;
    pnlRepDig: TPanel;
    lblCodRep: TLabel;
    lblDigita: TLabel;
    edtCodRep: TEditFocus;
    edtDesRep: TEditFocus;
    edtSenDig: TEditFocus;
    edtNomDig: TEditFocus;
    gbDadEqu: TGroupBox;
    pnlBotton: TPanel;
    lblObserv: TLabel;
    Label13: TLabel;
    Label18: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    lblGarant: TLabel;
    lblNroDoc: TLabel;
    lblDatEnt: TLabel;
    lblLocFis: TLabel;
    Label23: TLabel;
    Label41: TLabel;
    lblNOSAnt: TLabel;
    lblDtEAnt: TLabel;
    lblEstPrd: TLabel;
    edtObs: TMemoFocus;
    edtDesMar: TEditFocus;
    edtCodEqu: TEditFocus;
    edtDesEqu: TEditFocus;
    edtVoltag: TEditFocus;
    edtNSerie: TEditFocus;
    edtNFComp: TEditFocus;
    mskDtNFco: TMaskEditFocus;
    cbGarant: TComboBoxFocus;
    edtLocFis: TEditFocus;
    edtNumPat: TEditFocus;
    edtDadFab: TEditFocus;
    cbEstPrd: TComboBoxFocus;
    btnApontHoras: TBitBtnLocked;
    tbsApontamentos: TTabSheet;
    dbgGridApo: TDBGridCitel;
    dtsApontamentos: TDataSource;
    edtTmpGar: TEditFocus;
    lblTmpGar: TLabel;
    tbsHistEquipamento: TTabSheet;
    trvHisEqu: TTreeView;
    lblNOSFab: TLabel;
    edtNOSFab: TEditFocus;
    pnlTipBriSer: TPanel;
    lblTipBriSer: TLabel;
    clbTipBriSer: TColorLabel;
    edtTipBriSer: TEditFocus;
    edtNOSAnt: TEditFocus;
    mskDtEAnt: TMaskEditFocus;
    btnConfirmarVarias: TBitBtnLocked;
    btnGridMostraOS: TBitBtnLocked;
    btnAltCondPagto: TBitBtnLocked;
    btnAltTecServicos: TBitBtnLocked;
    chkCobAPaSer: TCheckBox;
    lblQtdSer: TLabel;
    edtQtdSe1: TEditFocus;
    btnOrdMaoObrCli: TBitBtnLocked;
    mskDtNFRe: TMaskEditFocus;
    lblDtNFRe: TLabel;
    edtNFReme: TEditFocus;
    lblNFReme: TLabel;
    btnAlteraItens: TBitBtnLocked;
    btnMostraMargem: TBitBtnLocked;
    pnlEmpSer: TPanel;
    Label1: TLabel;
    edtEmpSer: TEditFocus;
    edtDesEmpser: TEditFocus;
    lblInfoEmpSer: TLabel;
    pnlExiDados: TPanel;
    lblExiDados: TLabel;
    pnlBottomItens: TPanel;
    pnlDadosItem: TPanel;
    Label33: TLabel;
    lbl2: TLabel;
    imgPecPen: TImage;
    imgPecDis: TImage;
    Label16: TLabel;
    lblCodFab: TLabel;
    lblSaldos: TLabel;
    lblDesSaldos: TLabel;
    imgSalInd: TImage;
    lblSalInd: TLabel;
    Label35: TLabel;
    lbl_LocFis: TLabel;
    Label36: TLabel;
    lbl_LocSup: TLabel;
    imgCopCFB: TImage;
    lblSal_OS: TLabel;
    lblDesSal_OS: TLabel;
    imgSaldos: TImage;
    pnlInfoItens: TPanel;
    pnlMostraPrecoProd: TPanel;
    pnlAg_Pec: TPanel;
    edtQtdAce: TEditFocus;
    lblQtdAce: TLabel;
    mskDtRAnt: TMaskEditFocus;
    lblDtRAnt: TLabel;
    lblLegTotPro: TLabel;
    lblLegTotSer: TLabel;
    lblLegTotDes: TLabel;
    lblLegTotGer: TLabel;
    edtObsGer: TMemoFocus;
    edtObsNFS: TMemoFocus;
    lblObsGer: TLabel;
    lblObsNFS: TLabel;
    btnBrindeTotalServ: TBitBtnLocked;
    btnCancAprovacao: TBitBtnLocked;
    pnlLegendas: TFlowPanel;
    pnlLegInativoCmp: TPanel;
    shpInativoCmp: TShape;
    lblLegInativoCmp: TLabel;
    pnlLegItemEsp: TPanel;
    shpItemEsp: TShape;
    lblLegItemEsp: TLabel;
    pnlImgEqu: TPanel;
    lblErrImg: TLabel;
    imgEqu: TcxImage;
    chkAutDescarte: TcxCheckBox;
    edtCodLoc: TEditFocus;
    edtDesLoc: TEditFocus;
    pnlCodCli: TPanel;
    lblCliFor: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    lblTabPreco: TLabel;
    cbTabPreco: TComboBoxFocus;
    pnlFazenda: TPanel;
    pnlDadosCliente: TPanel;
    lblFone01: TLabel;
    edtFone01: TEditFocus;
    lblCelula: TLabel;
    edtCelula: TEditFocus;
    lblEmail: TLabel;
    edtEmail_: TEditFocus;
    lblDtaInc: TLabel;
    mskDtaInc: TMaskEditFocus;
    chkPrtAtd: TCheckBox;
    edtDiaEnt: TEditFocus;
    mskEntreg: TMaskEditFocus;
    lblPreEnt: TLabel;
    mskCntTel: TMaskEditTelefone;
    Label39: TLabel;
    edtCntCli: TEditFocus;
    Label37: TLabel;
    edtFazenda: TEditFocus;
    lblFazenda: TLabel;
    btnAlterarFazenda: TcxButton;
    pnlItensTop: TPanel;
    rdbCodIte: TRadioButton;
    rdbCodFab: TRadioButton;
    edtCodIte: TEditFocus;
    Label5: TLabel;
    edtDesIte: TEditFocus;
    Label26: TLabel;
    edtUnidad: TEditFocus;
    lblTabPrecoItem: TLabel;
    cbTabPrecoItem: TComboBoxFocus;
    pnlEmpIte: TPanel;
    lblEmpIte: TLabel;
    edtEmpIte: TEditFocus;
    edtDesEmpIte: TEditFocus;
    pnlItensBottom: TPanel;
    pnlDestino: TPanel;
    cmbEntRet: TComboBoxFocus;
    lblEntRet: TLabel;
    pnlLocRet: TPanel;
    lblLocRet: TLabel;
    cmbLocRet: TComboBoxFocus;
    pnlItensValores: TPanel;
    Label9: TLabel;
    edtQtdIte: TEditFocus;
    edtUnitar: TEditFocus;
    Label12: TLabel;
    btnCancelaItem: TBitBtnLocked;
    btnAdicionar: TBitBtnLocked;
    Label15: TLabel;
    edtTotIte: TEditFocus;
    chkBrindePro: TCheckBox;
    pnlTipBriPrd: TPanel;
    lblTipBriPrd: TLabel;
    clbTipBriPrd: TColorLabel;
    edtTipBriPrd: TEditFocus;
    chkCobAPa: TCheckBox;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtSenVenExit(Sender: TObject);
    procedure dbgGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAprovadaClick(Sender: TObject);
    procedure btnRealizadaClick(Sender: TObject);
    procedure edtObsExit(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtNumeroKeyPress(Sender: TObject; var Key: Char);
    procedure edtObsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgGridColEnter(Sender: TObject);
    procedure edtNumeroEnter(Sender: TObject);
    procedure edtNumeroExit(Sender: TObject);
    procedure btnObservacaoClick(Sender: TObject);
    procedure dbgGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtCodTecKeyPress(Sender: TObject; var Key: Char);
    procedure cbTabPrecoExit(Sender: TObject);
    procedure edtUnidadKeyPress(Sender: TObject; var Key: Char);
    procedure FormPaint(Sender: TObject);
    procedure btnAlteracaoClick(Sender: TObject);
    procedure chkAg_MonClick(Sender: TObject);
    procedure btnManutencaoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rdbCodFabClick(Sender: TObject);
    procedure rdbCodIteClick(Sender: TObject);
    function fMostraItensSimilares(strCodIte: String): Boolean;
    procedure btnEndEntClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnHisStaClick(Sender: TObject);
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCndExit(Sender: TObject);
    procedure edtForPagKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodSe1KeyPress(Sender: TObject; var Key: Char);
    procedure edtDesSe1KeyPress(Sender: TObject; var Key: Char);
    procedure edtDesSe1Change(Sender: TObject);
    procedure edtCodTecSe1KeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaSe1Click(Sender: TObject);
    procedure btnAdicionarSe1Click(Sender: TObject);
    procedure dbgServicoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodEquKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDfeKeyPress(Sender: TObject; var Key: Char);
    procedure dbgGridDfeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAdicionarDfeClick(Sender: TObject);
    procedure btnCancelaDfeClick(Sender: TObject);
    procedure edtNFCompKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEquEnter(Sender: TObject);
    procedure edtCodEquExit(Sender: TObject);
    procedure cbTabPrecoKeyPress(Sender: TObject; var Key: Char);
    procedure cbGarantChange(Sender: TObject);
    procedure btnReprovarClick(Sender: TObject);
    procedure btnAddObsTecClick(Sender: TObject);
    procedure btnImpEtiClick(Sender: TObject);
    procedure btnDevCliClick(Sender: TObject);
    procedure edtCodCliEnter(Sender: TObject);
    procedure btnConsultaCatalogosClick(Sender: TObject);
    procedure chkBrindeProClick(Sender: TObject);
    procedure chkBrindeSerClick(Sender: TObject);
    procedure dbgServicoDrawColumnCell(Sender: TObject; const [Ref] Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtCodRepKeyPress(Sender: TObject; var Key: Char);
    procedure cbTabPrecoItemKeyPress(Sender: TObject; var Key: Char);
    procedure cbTabPrecoItemExit(Sender: TObject);
    procedure pgcTabsChanging(Sender: TObject; var AllowChange: Boolean);
    procedure dbgServicoDblClick(Sender: TObject);
    procedure dbgGridDblClick(Sender: TObject);
    procedure btnCancelarOSClick(Sender: TObject);
    procedure lblDigNotaEntConsMouseEnter(Sender: TObject);
    procedure lblDigNotaEntConsMouseLeave(Sender: TObject);
    procedure btnPedCompraItensClick(Sender: TObject);
    procedure btnImpSeparacaoClick(Sender: TObject);
    procedure btnImpPedClick(Sender: TObject);
    procedure btnDesEspClick(Sender: TObject);
    procedure btnSalResClick(Sender: TObject);
    procedure btnImpostosClick(Sender: TObject);
    procedure blnRealizarEntradaClick(Sender: TObject);
    procedure btnVincularEntradaClick(Sender: TObject);
    procedure btnRemoverEntradaClick(Sender: TObject);
    procedure btnRealizarSaidaClick(Sender: TObject);
    procedure btnVincularSaidaClick(Sender: TObject);
    procedure btnRemoverSaidaClick(Sender: TObject);
    procedure cmbEquEntChange(Sender: TObject);
    procedure cmbEquEntExit(Sender: TObject);
    procedure edtCodCndEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtLocFisKeyPress(Sender: TObject; var Key: Char);
    procedure chkVenPreClick(Sender: TObject);
    procedure chkVenPreEnter(Sender: TObject);
    procedure chkVenPreExit(Sender: TObject);
    procedure btnReativarClick(Sender: TObject);
    procedure btnUltimasVendasClick(Sender: TObject);
    procedure edtCodTecSe1Exit(Sender: TObject);
    procedure btnComunicacaoInternaClick(Sender: TObject);
    procedure btnConsultarClienteClick(Sender: TObject);
    procedure btnImpItensServicosClick(Sender: TObject);
    procedure btnCancelaAceClick(Sender: TObject);
    procedure dbgGridAceKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodAceKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarAceClick(Sender: TObject);
    procedure cbEstPrdExit(Sender: TObject);
    procedure btnApontHorasClick(Sender: TObject);
    procedure trvHisEquCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure edtSenVenKeyPress(Sender: TObject; var Key: Char);
    procedure chkPrtAtdClick(Sender: TObject);
    procedure edtNOSAntExit(Sender: TObject);
    procedure btnConfirmarVariasClick(Sender: TObject);
    procedure dbgGridCellClick(Column: TColumn);
    procedure dbgGridMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnGridMostraOSClick(Sender: TObject);
    procedure btnAltCondPagtoClick(Sender: TObject);
    procedure btnAltTecServicosClick(Sender: TObject);
    procedure btnOrdMaoObrCliClick(Sender: TObject);
    procedure edtNFRemeKeyPress(Sender: TObject; var Key: Char);
    procedure btnAlteraItensClick(Sender: TObject);
    procedure btnMostraMargemClick(Sender: TObject);
    procedure edtEmpIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpSerKeyPress(Sender: TObject; var Key: Char);
    procedure lblExiDadosClick(Sender: TObject);
    procedure dbgGridAceDblClick(Sender: TObject);
    procedure edtDiaEntExit(Sender: TObject);
    procedure btnBrindeTotalServClick(Sender: TObject);
    procedure btnCancAprovacaoClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure imgEquDblClick(Sender: TObject);
    procedure chkAutDescarteClick(Sender: TObject);
    procedure edtCodLocEnter(Sender: TObject);
    procedure edtCodLocExit(Sender: TObject);
    procedure edtCodLocKeyPress(Sender: TObject; var Key: Char);
    procedure btnAlterarFazendaClick(Sender: TObject);
    procedure cmbLocRetChange(Sender: TObject);
    procedure cmbEntRetChange(Sender: TObject);
  private

    blnEntrouVenPre: Boolean;

    strValidaEqu: String;
    objConEqu: TConEqu; // cria um objeto da Classe TConEqu - untConsertoEquipamento
    qryCadIte: TUniQuery;
    qryEquGer: TUniQuery;
    qryConUni: TUniQuery;
    qryFatgor: TUniQuery;
    qryConCnd: TUniQuery;
    qryCadEqu: TUniQuery;
    qryConOpe: TUniQuery;
    qryCadCli: TUniQuery;
    blnFecharForm: Boolean;
    blnAprovada  : Boolean;
    intDecimal   : Integer;
    intDecQtde   : Integer;
    strCcnAnt    : String;
    strConPagAnt : String;
    strFpgAnt    : String;
    blnCarItem   : Boolean;

    objEndEnt    : TEnderecoEntrega;

    intSemaforoPesquisa: Integer;

    arrMatItensIni: TMatrizFechamento;

    blnBuscarCodFab,
    blnOsGeradaPorPD: Boolean;

    FPais: TPais;

    fatVenda : TFatVenda;

    strCodSerOld: String;
    fltValSerOld: Double;
    fltValOri: Double;

    stlCodIteImportado: TStringList;
    stlCodSerImportado: TStringList;

    objMeqMerEnt,
    objMeqMerSai: TMeqMer;

    cdsConsultaDfe : TUniClientDataSet;
    cdsConsultaItem: TUniClientDataSet;
    cdsConsultaServ: TUniClientDataSet;
    cdsConsultaAce : TUniClientDataSet;

    sltDfe  : TStringList;
    sltServ : TStringList;
    sltItems: TStringList;
    sltAce  : TStringList;

    blnVerificaLimiteCredito : Boolean;

    strVERLME : String;

    objEmitirPedido: TEmitirPedido;

    blnIniOrc :Boolean;
    blnFinOrc :Boolean;
    blnIniMan :Boolean;
    blnFinMan :Boolean;
    blnTrCliRecPre: Boolean;

    stlManEquAltLck: TStringList;
    blnCadLoc: Boolean;

    objLiberacao : TLiberacao;

    strCodCliPreCadastro: String;

    AlterarClientePagtoObsDescOSRealizada: Boolean;
    InformarNFEntSaiAlterarObsOSRealizadaReprovada: Boolean;

    strMultiTabPreAnt: string;
    strMultiTabPreAtu: string;
    strCndPgtoAnt: string;
    strCndPgtoAtu: string;

    blnAprovando: Boolean;
    blnAprovacao: Boolean;

    pgbStatus: TcxProgressBar;

    FblnSenhaIncorreta: Boolean;
    FblnManterPrecos: Boolean;

    strTabEqu: String;
    strSugEqu: String;
    strCodEmpOSAnt: String;
    strTERROS: String;
    strCOSAnt: String;
    blnAlterarCondicao: Boolean;
    blnMarLuc: Boolean;
    blnAltAcessorio: Boolean;
    strNomArqExcel: String;
    blnTemItemEsp: Boolean;
    blnTemItemInativoCmp: Boolean;
    blnUsaDig: Boolean;
    blnNovaOrdemServico: Boolean;
    FblnGravandoOS: Boolean;

    Function fPodeAlterarOS: Boolean;
    function fRetNomVendedor(strSenOpe: String): String;
    function fDataPrevisao: Boolean;
    function fDigDadosConsumidor: Boolean;
    procedure pCarregaItem(blnBuscaPorChave,
                           blnAtualizaEdits:Boolean;
                           blnRepesquisa: Boolean = False;
                           fltQtdItemEstrutura: Double = 0;
                           fltPreSub: Double = 1);
    procedure pLimpaDadosItem;
    procedure pLimpaTela;
    procedure pCalculaTotIte;
    function  fRetTotIte : Real;
    procedure pCarregaItemAlteracao;
    procedure pEnviarOSEmail(strArquivo: string; blnPDF: Boolean = True);
    procedure pEnviarOSWhatsapp(strArquivo: string);
    procedure pStatus;
    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pAtualizaTotais;

    procedure pMostraObsCliente(strCodCli: String);
    procedure pClienteRespGarantia;

    function fDigPrecoCusto: Double;
    procedure pSetaTabelaPreco(strTabPre: String);

    function fVerificaLimiteCreditoCliente(strCodCli: String): Boolean;
    function fDebitoCliente(strCodCli: String): Double;

    function fedtCodIteKeyPressGer(Sender: TObject; var Key: Char; strCodFab: String = ''): Boolean;

    procedure pCarregaEnderecoEntrega(strTabela, strAutInc: String; blnAltEnd: Boolean = False);
    procedure pOSToEndereco;
    procedure pEnderecoToOS;

    function fPedeEnderecoEntrega: Boolean;

    Function fValidaUnitario(fltUniDig: Double; blnPedeSenha: Boolean = True): Boolean;
    Function fVerificaVrMinimoInterna(blnPedeSenha: Boolean = True): Boolean;
    Function fRetornaUnitarioTrava(fltUniDig,
                                   fltUniOri,
                                   fltQtdIte: Double;
                                   strCodIte,
                                   strTabPre: String): Double;
    procedure pCarregaCondicao(APermiteAlterarTabPre: Boolean = True);
    procedure pCarregaForPag;
    procedure pCarregaEquipamento;
    function fRetTaxJur(strCodCnd: String = ''; strConPag: String = ''): Double;
    function fRetPerDes(strCodCnd: String = ''): Double;

    function fAbreManutencaoComTelaProgressBar: Boolean;
    function fExecutarAcaoAbreManutencao(pgbProgresso: TcxProgressBar): Boolean;
    function fAbreManutencao(strCodEmpP : String): Boolean;

    procedure pLimpaDadosServico;
    function fCarregaServico(edtCodSer, edtDesSer: TEditFocus; blnBuscaPorChave: Boolean): Boolean;
    function fValidaValorSer(edtValor: TEdit): Boolean;
    procedure pCarregaServicoAlteracao;

    Function fRetOpcaoEmGarantia(strOpcao:String = ''): String;

    procedure pImportaProdutosServicos(strNum_OS: String);

    procedure pAdicionaItem;
    procedure pCarregaEstrutura(strCodIte:String; fltQtdIte:Double; fltTotIte: Double = 0);

    Function fRetDataNFCompra(strNumDoc, strCodCli, strCodEmp: String): TDatetime;

    Procedure pCarregaVendedor;
    Procedure pCarregaDigitador;
    procedure pCarregaRepres;
    procedure pCarregaCliente;
    procedure pCarregarNomeCliente;
    procedure pVerificaAlterarVendedor(strCodVendedor, strCodRepres: String);

    procedure pClonaDadosNF(objClone: TMeqMer);
    procedure pCarregaDadosNFEntSai;

    procedure pEntradaNF;
    procedure pEntradaNF_XML(blnConsultaNFe: Boolean);
    procedure pVincularEntradaNF;

    procedure pMostraUltimasVendas(blnPrecoServico: boolean);

    procedure pSaidaNF;
    procedure pVincularSaidaNF;
    function  fVerificarTabPre: String;
    function  fVendeItem(cdsConsulta: TUniClientDataSet; DropControl: TControl; RectLinhaGrid: TRect): Boolean;
    function  fInserirDefeito(cdsConsulta: TUniClientDataSet; DropControl: TControl; RectLinhaGrid: TRect): Boolean;
    function  fInserirServico(cdsConsulta: TUniClientDataSet; DropControl: TControl; RectLinhaGrid: TRect): Boolean;
    function  fInserirAcessorio(cdsConsulta: TUniClientDataSet; DropControl: TControl; RectLinhaGrid: TRect): Boolean;
    function  pConsultaItem(strDescri : String = ''; strCodBar : String = ''; strCodFab : String = ''): Boolean;
    procedure pIncluiNaListaConsulta(strCampo, strCampoConsulta: String; stlLista: TStringList; cdsDados, cdsConsulta: TUniClientDataSet);
    procedure pRetiraDaListaConsulta(strCodigo, strCampo, strCampoConsulta: String; stlLista: TStringList; cdsDados, cdsConsulta: TUniClientDataSet);
    procedure pCarregarListasConsulta();
    procedure pAlterarServico;
    procedure pCarregarProduto;
    procedure pCarregarDefeito;
    procedure pCarregarAcessorio;
    procedure pExcluirDefeito;
    procedure pExcluirProduto;
    procedure pExcluirServico;
    procedure pExcluirAcessorio;
    procedure pExcluirKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function  fInicializarObjFrmPnlItem: TPanelCxItem;
    function  fVerificarPedFat_OsRealizada: Boolean;
    procedure pHabilitarCamposRealizada(blnHabilitar: Boolean);
    procedure pHabilitarEdicaoCamposRealizadaReprovada;
    procedure pImprimePedidoSeparacao(blnImpPed, blnImpSep, blnVerificaAltSep: Boolean);
    procedure pEnviarEmailPedOS;
    function  fTravaLimiteCredito(blnIgnorarCndPag: Boolean = False): Boolean;
    function  fTravaOSSemProdServ: Boolean;
    procedure pCalcPorDes;
    function  fInicializarFatVenda(const blnLazyLoading: boolean = False): Boolean; overload;
    function  fInicializarFatVenda(pgbProgresso: TcxProgressBar): Boolean; overload;
    procedure pInicializarFatVenda;
    procedure pAtualizarTribEquGer;
    procedure pAtualizarTribItensEquDet;
    procedure pLimparDadosTribEquGer;
    procedure pCarregarItensNotaEntradaXML;
    function  fRealizarVincularDocFiscal: Boolean;
    Function  fPodeRemoverVinculaNFSaidaOS: Boolean;
    function  fValidarExpedicao: Boolean;
    procedure pMostrarMensagemValidacaoExpedicao;
    function  fOSFoiReprovadaAgMontagem: Boolean;
    function  fRepAgMontage: Boolean;
    function  fConfirmaDadosOS(blnAprovando: Boolean = False): Boolean;
    procedure pDefinirStatusAnt;
    procedure pAplicarDescontoServicos(fltValDes: Double = 0);
    function  fTravaERegistraStlManEquLck(strNumOse, strCodEmp: String): Boolean;
    procedure pDestravaELimpaStlManEquLck;
    function  fRetornaChaveLckManEqu(strNumOse, strCodEmp: String): String;
    procedure pPodeAlterarDigitador;
    procedure pPodeAlterarTecnico;
    procedure pHabilitarCamposAlterarTecnicoServico(blnHabilitar: Boolean);
    function fProcessarRequisicaoCompra: Boolean;
    function fRequisicaoCompraVinculada: Boolean;
    function fCondicaoPagamentoFinal: Boolean;
    function fAlterouCndFpg: Boolean;
    function fRecalcular: Boolean;
    function fValidaDescServico: Boolean;
    procedure pImprimirEtiqueta(strNumero: string);
    procedure pCarregaOSAnterior; // carrega numero OS anterior
    procedure pVerificaOSAntExit(Sender: TObject);
    procedure pCarregaEstProduto;
    procedure pShowFluxoProcesso;
    procedure RedimensionaDesEmp(blnNovaOS: Boolean);
    procedure RedimensionaRevendaRetornarDeixadoPor;
    function fAlteraPedidoVenda: Boolean;
    function fAlteraCadCli(const strCodCli: String): String;
    procedure pVerificaProntoAtendimento;

    function fObterLotePrincipalGarantia(const strCodEqu: String): String;
    procedure pVerificaTabPre;
    procedure pCarregaComboTabPre(cbComboTab: TComboBoxFocus; strTabela: String);
    procedure pExcluirReqCompra;
    function  fTravaDebitosAtraso(blnDevCli: Boolean = False): Boolean;
    procedure pLimparProdutosServicosImportados;
    procedure pImprimir(intQtdImp, intDestino: Integer; tpArquivo: TTipoArquivo; strEspecie: string; var StrPDFRet: string;
      var blnOK: Boolean; strCodLay: String = ''; strTipImpr: String = 'I');
    procedure pImprimirTermoResponsabilidade(intQtdImp: Integer; tpArquivo: TTipoArquivo; var strTpLayout: String; blnOK: Boolean);
    function fValidarCodRel(strCodLay: String): Boolean;
    function fValidaConfirmar: Boolean;
    function fVerificarPedFat_AltCodPagto: Boolean;
    function fVerificaAdiantamento: Boolean;
    function fVerificaPDFaturado: TTipoFatuPDConEqu;
    function fValidaItensServAParte: Boolean;
    function fValidaRealizaManAgPecas: Boolean;
    procedure pValidaItensSemLote(strNumDoc, strEmpPed: String);
    procedure pAtualizaDadosMargemLucro(cdsItens: TUniClientDataSet);
    procedure pCalculaPrecoCusto(dtsDados: TDataSet;
                                 fltUnitar,
                                 fltPreCus: Double;
                                 blnIteEsp: Boolean;
                                 blnIteVid: Boolean;
                                 fltIcmSai: Double);
    function fValidaSaldoInsuficiente: Boolean;
    procedure pControlaDigitacaoValoresFracionados(strCodUni: String);
    function fVerificaPedidoReprovacao(var blnDeletaPD: Boolean): Boolean;
    function fRetNumFatPD(strNumDoc, strEspDoc, strCodEmp: String): String;
    procedure pMostraDocumentosGerados;
    procedure pSetarEmpresaItem(strCodEmp: String);
    procedure pShowNegociacao;
    procedure pAlterarAcessorio;
    procedure pCarregaAcessorioAlteracao;
    procedure pCalculaDataPrevisao(blnAprovando: Boolean = False);
    procedure pBaixaOcorrenciasCRM;
    function fAtualizaDataFimManutencao: Boolean;
    function fAguardandoPecas: Boolean;
    procedure pExibeValores;
    procedure pImprimirOrdemExecucao(intQtdImp: Integer; tpArquivo: TTipoArquivo);
    function fValidaImpSepAprFluxo: Boolean;
    procedure pAdicionaServico;
    function fPermiteHabilitarDocsFiscaisRef: boolean;
    procedure pAlteraStatusAprovadaParaOrcamento;
    function fPerguntaOrcamentoRealizado: Boolean;
    function fEhFluxoDadosOS: Boolean;
    function fNovaOSFluxo: Boolean;
    function fCampoDigitadorHabilitado: Boolean;
    procedure pCancelaEntregaEquip;
    function fEhAnaliseTecnica: Boolean;
    function fGeraExcel(pgbProgresso: TcxProgressBar): Boolean; overload;
    procedure pImprimirFluxo;
    function fValidaTravaFluxoEnviarCliente: Boolean;
    function fValidaImpressoOSPreco(strEsp: string; var strCodLay: String): Boolean;
    function fTemProdutoOuServicoInformado: Boolean;
    procedure pCarregaDadosOSAnterior;
    procedure pAtualizaCamposOSAnterior;
    procedure pHabilitaPainelLegendas;
    procedure pHabilitaPnlLegendaItemEsp;
    procedure pHabilitaPnlLegendaInativoCmp;
    function fEhEtapaOrcamento: Boolean;
    procedure pAjustaAlturaPanelBotoes;
    function fPermiteEditarGarantia: Boolean;
    function fVerificaAcessoriosInclusao: Boolean;
    procedure pHabilitaNFCompraAnaliseTec;
    function fValidaDocumentoEntrada: Boolean;
    procedure pCarregaImagem;
    procedure pLimpaImagem;
    function fValidaRealizaManAgSeparacao: Boolean;
    function fSituacaoCancelarManutencao: String;
    function fEnviarWhatsappBaixaOS: Boolean;
    procedure pMostraContaCorrente;
    function fInclusaoOrdemServico: Boolean;
    function fPermiteGerarExcel: Boolean;
    procedure pAtualizaEmpFaturamentoSemSaldo;
    function fInformarLocFisicaEquipamento: String;
    function fSelecionarFazendaCliente(ACodCli: String; AAltFazenda: Boolean = False): Boolean;
    procedure pExibirDadosFazenda(AExibir: Boolean);
    function fSaidaImpressao: String;
    function fValidaTravasEnviarCliente: Boolean;
    procedure pHabilitaLocRet;
    procedure pSolicitaEquipamentoNFEntrada;
    function fPodeMarcarAgMontagemSemSaldo: Boolean;
    procedure pAvisoAgMontagemSemSaldo;
    function fCarregarTodosItensNotaSaida: Boolean;
    function fValidaHouveFaturamentoParcial(var ANumFat: String; const ANumDoc, ACodEmp: String): Boolean;
  protected
    procedure pLimparDadosCarregados;
    procedure pHabilitaChkVendaPresencial;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pEscapePressed; override;
    function fValidarRegraUFVendaPresencial : Boolean;
    procedure pAlteraTelaRotinaTecnico;
    function fTravaTermoDevolucao: Boolean;
  public
    { Public declarations }
    strNomeArquivo    : String;
    blnRotinaTecnico  : Boolean;
    blnFluxoProcesso  : Boolean;
    blnFlxProcessoTec : Boolean;
    blnOSCancelada    : Boolean;
    strFlxNovaCancelar: String;
    tpProcessoFlx     : TTipoProcessosFlxConEqu;
    tpImpressaoFlx    : TTipoImpressaoFlxConEqu;
    tpDocsFiscaisFlx  : TTipoDocsFiscaisFlxConEqu;

    blnNegociacao     : Boolean;
    FstrAprPor        : String;
    FstrOsPdCl        : String;
    FstrSubSta        : String;
    FstrCodDig        : String;
    FstrSenDig        : String;
    FstrCliGar        : String;
    FstrEmpFatSemSaldo: String;
    cdsIteNeg         : TUniClientDataSet;
    FcdsDocGerNeg     : TUniClientDataSet;
    objFatVendaImpNeg : TFatVendaImp;
  end;


Const
 arrSubStatusAberto: Array [1..3] Of String = ('ORÇAMENTO','AGUARDANDO PEÇAS','AGUARDANDO CLIENTE');
 arrSubStatusReprov: Array [1..3] Of String = ('DEVOLVIDA AO CLIENTE','ARMAZENADA','SAIR');
 arrSubStatusAprova: Array [1..3] Of String = ('APROVADO CLIENTE','APROVADO GARANTIA','APROVADO CORTESIA');
 arrSubStatusAltMot: Array [1..2] Of String = ('APROVADO CLIENTE','APROVADO GARANTIA');
 arrSubStatusReprovAgMontagem: Array [1..4] Of String = ('AGUARDANDO MONTAGEM','DEVOLVIDA AO CLIENTE','ARMAZENADA','SAIR');
 arrSubStatusManutencao: Array [1..2] Of String = ('MANUTENÇÃO COMPLETA','AGUARDANDO ITENS');

implementation

uses  untFuncoesSimples, untConsultas, untPanelCxNFCompra, untPnlDadosNFCompra,
      untPesqAux, untPai, untFuncIns, untFuncIns2,
      untObservacao, untFatMostraProdSimilar,
      untFatObsOrdemServico, untDigEmail, untFuncoes, untDigInfBrinde,
      untFatMostraObsCliente, untFatDadosCliConsumidor, untFatDigPrecoCusto,
      untParCalculaPrecoCusto, untDigCliente, untCfgRel,
      untConstantes, untFuncoesAuxiliares, untTConfiguracao,
      untTermoResponsabilidadeHelper, untImpOrdemServico,
      untPnlDadosItem, untDigMotivoReprovacao,
      untPanelCxLegendaConsertoEquip, untPnlLegendaConsertoEquip,
      untFatManConsertoObsTecnicas, untInputDialog, untConsultaFatCatalogo,
      untEntMercadorias, untSelecionarNota, untConsertoEquipAprovacao,
      untFatVendaItem, untPanelCxDefeito, untPnlDadosDefeito, untPanelCxServico,
      untPnlDadosServico, untTEnvioEmail, untFatDigPedidoCompraItens,
      untGravando, untReimpressao, Faturamento.Classes.TValidarVenda,
      untFatManEquipDigDesconto, untFatMostraItensFechamento,
      untEntImportacaoNotaEletronica, untFatDigMensagemOS,
      untIFatReservaSaldo, untTFatReservaSaldo,
      untIFatEntregaFutura, untTFatEntregaFutura, untFatSelecaoTabelaPreco, untCadPro,
      untFatRequisicaoCompras, untMsgLiberacao, untFatManConsertoComunicacaoInterna,
      untCadClientes, untDigCndPagamento, untPanelCxAcessorio, untPnlDadosAcessorio,
      untConsertoEquipFinalizacao, untFatManApontamentoHoras, Faturamento.Classes.TAlterarPedido,
      untCadLote, untFatGeracaoMultiplasOS, untAdiantamentoCliente,
      untFatManReservaEstoque, untFatManConsertoAlteraTecnico, untFatManConEquExibeSaldo,
      untFatManDigOrdemMaoObraCli, untFatManAlteraItensBrinde, untFatAltLoteItem,
      untFatMostraMargemNovo, Faturamento.Classes.DuplicataAtraso, untFatPedidosImpr,
      untAtualizaOcorrenciasCRM, untConsertoEquipGeraExcel, untConsertoEquipImpr,
      untImagens, untFuncoesImagem, untFatManFinalizaManutencao, untFatGor,
      untInformarLocFisConsertoEquip;

{$R *.dfm}

function TfrmFatManConsertoEquip.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    edtTemp: TEditFocus;
    strCliTabPre: String;
    strConPag   : String;
    fltValAlt   : Double;
    dtaEquGer   : TDateTime;
    blnManterPrecos: Boolean;
    intIndice   : Integer;
    fltAliqIss  : Double;
    fltRedIss   : Double;

  function fMSG_SenhaManterPrecos(): Boolean;
  Begin

    Result := True;

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Senha para Manter os Preços da Ordem de Serviço Quando Trocar a Condição de Pagamento');
    objLiberacao.objMsgLibera.pAddSeparador(75);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cnd.Pagto Anterior'        , fFormataCondPag(strCcnAnt)                                         , 24);
    objLiberacao.objMsgLibera.pAddTextoCaption('Forma de Pagto Anterior'   , strFpgAnt + ' - ' + fRetDesFpg(strFpgAnt)                          , 24);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cnd.Pagto'                 , fFormataCondPag(strConPag)                                         , 24);
    objLiberacao.objMsgLibera.pAddTextoCaption('Forma de Pagto'            , edtForPag.Text + ' - ' + edtDesForPag.Text                         , 24);
    objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor'                  , objConEqu.strCodVen + ' - ' + fRetNomeOperador(objConEqu.strCodVen), 24);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor do Documento'        , FormatFloat('#,##0.00', objConEqu.fltVlrPro)                       , 24);

    objLiberacao.strDirAce := 'SENEQU';
    objLiberacao.strSenLib := fCfgSis('SENEQU');
    objLiberacao.strMsgSen := 'Senha para manter os preços da venda quando trocar a condição de pagamento';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCliente := edtCodCli.Text + '-' + edtNomCli.Text;
    objLiberacao.strCpfCnpj := objConEqu.strCliCgc;

    If Not objLiberacao.fLibera Then
    Begin
      Result := False;
    End;

  End;

begin
  Result    := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA CLIENTE                        *}
    {**************************************LU*}
    If (Sender = edtCodCli) Then
    Begin
      If fEmptyStr(edtCodCli.Text) Then
      Begin
        fMensagem('', 'O cliente deve ser preenchido!' , ['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtCodCli.Text := fPadL(edtCodCli.Text, edtCodCli.TamCampo, '0');

        If fEmptyStr(edtNomCli.Text) Or ((edtCodCli.Text <> objConEqu.strCodCli)) Then
        Begin
          objConEqu.blnVenPre := False;
          pCarregarNomeCliente;
        End;

        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('AVISO', 'Cliente não encontrado!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If (edtCodCli.Text <> objConEqu.strCodCli) Then
          Begin
            blnTrCliRecPre := True;
            blnVerificaLimiteCredito := True;

            If (Not fEmptyStr(objConEqu.strCodCli)) And (Not fEmptyStr(objConEqu.strNumero)) Then
            Begin
              If (Not objConEqu.fPodeAlterarClienteOrdemServico) Then
              Begin
                edtCodCli.Text := objConEqu.strCodCli;
                pCarregarNomeCliente;
                Result := False;
              End
              Else
              Begin
                pCarregarNomeCliente;

                if (objConEqu.strStatus <> 'E') and (objConEqu.strStatus <> 'F') and (objConEqu.strGarant <> 'N') then
                  pClienteRespGarantia;

                btnImprimir.Enabled := False;
              End;
            End;

            If Result and (Not fRetStatusCliente(edtCodCli.Text)) Then
            Begin
              objLiberacao.Clear;
              objLiberacao.objMsgLibera.pAddTexto('A T E N C A O - Esse cliente está com atividade suspensa!');

              objLiberacao.strDirAce := 'ATISUS';
              objLiberacao.strCodOpe := strLoginUsuarioLogado;
              objLiberacao.strMsgSen := 'Esse cliente está com atividade suspensa';
              objLiberacao.strCliente := edtCodCli.Text;
              objLiberacao.strSenFvu := fCfgSis('EQUFVU');

              if not objLiberacao.fLibera then
              begin
                edtCodCli.Text := objConEqu.strCodCli;
                pCarregarNomeCliente;
                Result := False;
              end;
            End;

            if Result then
            begin
              pCarregaCliente;

              if fCfgSis('CADFAZ', varBoolean) then
              begin
                Result := fSelecionarFazendaCliente(edtCodCli.Text);
                pExibirDadosFazenda(Result);
              end;
            end;

            if Result then
            begin
              pMostraObsCliente(edtCodCli.Text);

              If fRetDebitoCliente(edtCodCli.Text) <> 0 Then
                fExecutarModal(pMostraContaCorrente, 'Aguarde, buscando débitos do cliente...', '');

              If (Not fEmptyStr(objConEqu.strCodCli)) Then
              Begin
                pAtualizaEmpFaturamentoSemSaldo;
                objConEqu.strCodCli := edtCodCli.Text;

                If (Not fCfgSis('CLRCPR', varBoolean)) Then
                  pInicializarFatVenda();
              End
              Else
              Begin
                objConEqu.strCodCli := edtCodCli.Text;
              End;

              // MESMO QUANDO FOR CONSUMIDOR,
              // DEVE RETORNAR TABELA DE PREÇO DO CADASTRO
              {If fClienteConsumidor(fRetNomCliente(edtCodCli.Text), False, True) Then
                strCliTabPre := '1'
              Else}

              If (objConEqu.strOperac = 'I') Or (Not fCfgSis('CLRCPR', varBoolean)) Then
              Begin
                strCliTabPre := fRetTabPrecoCliente(edtCodCli.Text);

                If fEmptyStr(strCliTabPre) And fCfgSis('HIETAB', VarBoolean) Then
                  strCliTabPre := fCampoTabela('OPE_TABPRE', 'CADOPE', ['OPE_CODOPE'], [objConEqu.strCodVen], False);

                if (strSugEqu <> '0') then
                  pSetaTabelaPreco(strSugEqu)
                else
                  pSetaTabelaPreco(strCliTabPre);

                objConEqu.pRecalculaPrecos(cbTabPreco.Text);
              End;

              If fEmptyStr(objConEqu.strCliNom) Then
                objConEqu.pCarregarCliente(Nil, edtCodCli.Text, True);

              Result := fDigDadosConsumidor;

              If Result And Not fEmptyStr(strCodCliPreCadastro) Then
              Begin
                edtCodCli.Text := strCodCliPreCadastro;
                strCodCliPreCadastro := '';
                fValidaCampos(edtCodCli, blnBuscaPorChave);
                Exit;
              End;

              pCarregarNomeCliente;

              If Not Result Then
                fMensagem('','Informe os dados do cliente Consumidor corretamente!',['&OK']);

              pCarregaEnderecoEntrega('','', True);

              If (Not fEmptyStr(qryCadCli.FieldByName('CND_CODCND').AsString)) Then
              Begin
                strCcnAnt      := qryCadCli.FieldByName('CND_CODCND').AsString;
                edtCodCnd.Text := strCcnAnt;

                pCarregaCondicao();

                If (Not fEmptyStr(qryCadCli.FieldByName('CND_CNDPAG').AsString)) Then
                Begin
                  strFpgAnt      := qryCadCli.FieldByName('CND_CNDPAG').AsString;
                  edtForPag.Text := strFpgAnt;

                  pCarregaForPag();
                End;
              End
              else if (qryCadCli.FieldByName('CLI_CGCCPF').AsInteger = 1) and (not fEmptyStr(fCfgSis('OSCNDJ', varString))) then
              begin
                strCcnAnt      := fCfgSis('OSCNDJ', varString);
                edtCodCnd.Text := strCcnAnt;

                pCarregaCondicao();
              end
              else if (qryCadCli.FieldByName('CLI_CGCCPF').AsInteger = 2) and (not fEmptyStr(fCfgSis('OSCNDF', varString))) then
              begin
                strCcnAnt      := fCfgSis('OSCNDF', varString);
                edtCodCnd.Text := strCcnAnt;

                pCarregaCondicao();
              end;

              pAtualizaTotais;
            End;

            blnTrCliRecPre := False;
          End;

        End;

      End;
    End

    Else If (Sender = edtDesIte) And blnBuscaPorChave Then
    Begin

      If fEmptyStr(edtDesIte.Text) Then
      Begin
        fMensagem('','A descrição do item deve ser preenchida!',['&OK']);
        Result := False;
      End
      Else
      Begin

        If (blnBuscaPorChave) Then
        Begin
          If (fCfgSis('CUSESP', varBoolean))                                          And
             (Pos('ITEM ESPECIAL', qryCadIte.FieldByName('ITE_DESITE').AsString) > 0) Then
          Begin
            objConEqu.fltTotCus := fDigPrecoCusto;
            objConEqu.fltUniVis := fCalculaPrecoVenda(1, objConEqu.fltTotCus, 0.0, fCfgSis('MMIIES', varDouble), 0.0, 0.0, 0.0, 0.0);
            objConEqu.fltUniOri := objConEqu.fltUniVis;
            objConEqu.fltUnitar := objConEqu.fltUniVis;
            objConEqu.fltTaxJur := 0;
            objConEqu.fltPerDes := 0;
            edtUnitar.Text      := FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), objConEqu.fltUnitar);
          End;
        End;

        objConEqu.strDesite := edtDesIte.Text;
        objConEqu.strUnidad := edtUnidad.Text;
      End;

    End

    Else If (Sender = edtUnidad) And blnBuscaPorChave Then
    Begin

      If (Not fEmptyStr(edtCodIte.Text)) Then
      Begin
        If fEmptyStr(edtUnidad.Text) Then
        Begin
          fMensagem('','A unidade do item deve ser preenchida!',['&OK']);
          Result := False;
        End
        Else If (not edtUnidad.ReadOnly) And (fEmptyStr(fRetCodUnidadePorSig(edtUnidad.Text))) Then
        Begin
          fMensagem('','Essa unidade não está cadastrada!',['&Ok']);
          Result := False;
        End
        Else
        Begin
          objConEqu.strDesIte := edtDesIte.Text;
          objConEqu.strUnidad := edtUnidad.Text;
        End;
      End;

    End

    else if (Sender = cmbLocRet) and (pnlLocRet.Visible) then
    begin
      if (Result) And (cmbLocRet.Visible) And (cmbLocRet.Enabled) Then
      begin
        if (cmbLocRet.ItemIndex = IDX_VAZIO) and (not fEmptyStr(edtCodIte.Text)) then
        begin
          fMensagem('ATENÇÃO!', 'O Campo Local Retira deve ser informado!', ['&O k']);
          Result := False;
        end;
      end;
    end

    Else If (Sender = edtProtoc) Then
    Begin
      If (edtProtoc.Visible) And (edtProtoc.Enabled) Then
      Begin
        If (fEmptyStr(edtProtoc.Text)) Then
        Begin
          fMensagem('','O número de protocolo deve ser preenchido!',['&Ok']);
          Result := False;
        End;
      End;
    End

    {***************************************}
    {* VALIDA A TABELA DE PRECOS           *}
    {************************************LU*}
    Else If (Sender = cbTabPreco) Then
    Begin

      // NÃO ALTERAR A TABELA DE PREÇO JÁ TRAZIDA DO CADASTRO,
      // MESMO QUANDO FOR CONSUMIDOR.
      {If fClienteConsumidor(fRetNomCliente(edtCodCli.Text), False, True) Then
        cbTabPreco.ItemIndex := 0;}

      If (cbTabPreco.Visible) Then
      Begin
        If fEmptyStr(cbTabPreco.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Escolha uma Tabela de Preços!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If Pos(cbTabPreco.Text, '1234567') <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Tabela de Preços incorreta!', ['&O k']);
            Result := False;
          End
          Else if cbTabPreco.Items.IndexOf(cbTabPreco.Text) = -1 then
          Begin
            fMensagem('ATENÇÃO!', 'Tabela de Preços não configurada para utilização!', ['&O k']);
            Result := False;
          End
          Else If  (cbTabPreco.Text <> objConEqu.strTabPre) Then
          Begin
            pLimpaDadosItem;
            objConEqu.fltTaxJur := fRetTaxJur;
            objConEqu.fltPerDes := fRetPerDes;
            ObjConEqu.pRecalculaPrecos(cbTabPreco.Text);

            pInicializarFatVenda();
            pAtualizaTotais();

          End;
        End;
      End;
    End

    Else If (Sender = cbTabPrecoItem) Then
    Begin

      If (cbTabPrecoItem.Visible) Then
      Begin

        If (fEmptyStr(cbTabPrecoItem.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Escolha uma Tabela de Preços!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If (Pos(cbTabPrecoItem.Text, '1234567') <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Tabela de Preços incorreta!', ['&Ok']);
            Result := False;
          End
          Else if cbTabPrecoItem.Items.IndexOf(cbTabPrecoItem.Text) = -1 then
          Begin
            fMensagem('ATENÇÃO!', 'Tabela de Preços não configurada para utilização!', ['&O k']);
            Result := False;
          End
          Else
          If (Not fEmptyStr(objConEqu.strTabPreIte)) And (cbTabPrecoItem.Text <> objConEqu.strTabPreIte) Then
          Begin
            pCarregaItem(True, False);

            {Req: 112023 - Recalcular somente se carregou para alterar}
            If objConEqu.strOperac = 'G' Then
            Begin
              intIndice := objConEqu.cdsIteEqu.RecNo;
              try
                objConEqu.pRecalculaPrecos(cbTabPrecoItem.Text, objConEqu.strCodIte);
              finally
                objConEqu.cdsIteEqu.RecNo := intIndice;
              end;
            End;

            pAtualizaTotais;
          End;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA O NUMERO DA ORDEM DE SERVICO   *}
    {**************************************LU*}
    Else If (Sender = edtNumero) Then
    Begin
      If (blnRotinaTecnico) And (fEmptyStr(edtNumero.Text)) Then
      Begin
        fMensagem('','O número deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else If (Not edtCodEmp.Visible) Or blnRotinaTecnico Then
      Begin
        If Not fEmptyStr(edtNumero.Text) And (blnBuscaPorChave) Then
        Begin

          If (InterlockedIncrement(intSemaforoPesquisa) = 0) Then
          Begin
            try
              Result := fAbreManutencaoComTelaProgressBar;
            finally
              InterlockedDecrement(intSemaforoPesquisa);
            end;
          End;

          If (Result) and (not blnFluxoProcesso) and (not blnNegociacao) and (fCampoDigitadorHabilitado) Then
          begin
            edtSenDig.Clear;
            edtNomDig.Clear;
          end;

          blnMudarFoco := False;
        End
        Else If (objConEqu.strStatus = '') Then
          objConEqu.strStatus := 'E';

      End;
    End

    Else If (Sender = edtCodEmp) And (edtCodEmp.Visible) And ((not blnRotinaTecnico) or (blnFluxoProcesso)) Then
    Begin
      edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
      If fEmptyStr(edtDesEmp.Text) Then
      Begin
        fMensagem('','O código da empresa informado não é válido!', ['&OK']);
        Result := False;
      End

      Else If Not fEmptyStr(edtNumero.Text) And (blnBuscaPorChave) Then
      Begin
        Result := fAbreManutencao(edtCodEmp.Text);
        blnMudarFoco := False;

        If (Result) and (not blnFluxoProcesso) and (not blnNegociacao) and (fCampoDigitadorHabilitado) Then
        begin
          edtSenDig.Clear;
          edtNomDig.Clear;
        end;
      End
      Else If (objConEqu.strStatus = '') Then
        objConEqu.strStatus := 'E';
    End

    {************************}
    {* VALIDA O OPERADOR    *}
    {*********************LU*}
    Else If Sender = edtSenVen Then
    Begin
      If fEmptyStr(edtSenVen.Text) Then
      Begin
        fMensagem('', 'O Vendedor deve ser preenchido!' , ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaVendedor;

        If fEmptyStr(edtNomVen.Text) Then
        Begin
          fMensagem('AVISO', 'Vendedor não encontrado!', ['&Ok']);
          Result := False;
        End
        Else If qryConOpe.FieldByName('OPE_STATUS').AsString <> 'A' Then
        Begin
          fMensagem('ATENÇÃO!', 'Vendedor está inativo!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtNFComp) Then
    Begin

      If ((cbGarant.ItemIndex = 2) Or (cbGarant.ItemIndex = 1)) Then
      Begin
        If fEmptyStr(edtNFComp.Text) Then
        Begin
          fMensagem('AVISO', 'Para equipamentos em garantia é obrigatório informar a NF de Compra', ['&Ok']);
          Result := False;
        End
        Else If blnBuscaPorChave or ( (not blnBuscaPorChave) and (Length(edtNFComp.Text) < 12) ) then
        Begin
          dtaEquGer := fRetDataNFCompra(edtNFComp.Text, edtCodCli.Text, IIF( edtCodEmp.Visible, edtCodEmp.Text, VS_strCodEmp ));
          if dtaEquGer = 0 then
          begin
            if fCfgSis('OSVENF', varBoolean) then
            begin
              if fMensagem('AVISO', 'Nota fiscal de compra inexistente.'+#13+
                           'Confirma a informação?', ['&Sim', '&Não']) = 2 then
              begin
                edtNFComp.clear;
                mskDtNFco.text := '';
                if not blnBuscaPorChave then
                  result := False;
              end;
            end;
          end
          else
            mskDtNFco.Text := DateToStr(dtaEquGer);
        End
        Else If (not blnBuscaPorChave) and (not fEmptyStr(edtNFComp.Text)) and (StrToDateDef(mskDtNFco.Text, 0) = 0) Then
        Begin
          fMensagem('AVISO', 'É obrigatório informar a Data de emissão da NF de Compra', ['&Ok']);
          Result := False;
        End;

      End;

      If (cbGarant.ItemIndex = 3) And (blnBuscaPorChave) Then
      Begin
        If (Not fEmptyStr(edtNFComp.Text)) Then
          dtaEquGer := fCampoTabela('EQU_DTAENT','EQUGER',['EQU_NUMOSE','EQU_CODCLI','EQU_CODEMP'],[edtNFComp.Text, edtCodCli.Text, strCodEmpOSAnt])
        Else
          dtaEquGer := 0;

        mskDtNFco.Text := IfThen(dtaEquGer = 0, '', DateToStr(dtaEquGer));

        If Not fEmptyStr(fTiraCaracEspeciais(mskDtNFco.Text)) Then
        Begin
          If fMensagem('AVISO', 'Deseja carregar os produtos/serviços da Ordem de Serviço anterior?', ['&Sim', '&Não']) = 1 Then
            pImportaProdutosServicos(edtNFComp.Text);
        End
        Else
          pLimparProdutosServicosImportados;
      End;

    End

    Else If (Sender = mskEntreg) And (mskEntreg.Enabled) And (mskEntreg.Visible) Then
    Begin
      If (Not fEmptyDate(mskEntreg.Text)) Then
      Begin
        If StrToDateDef(mskEntreg.Text, 0) <= StrToDate('31/12/1899') Then
        Begin
          fMensagem('AVISO', 'Previsão Entrega inválida!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtDiaEnt) And (edtDiaEnt.Enabled) And (edtDiaEnt.Visible) Then
    Begin
      If fEmptyStr(edtDiaEnt.Text) Then
      Begin
        fMensagem('', 'Informe o número de dias úteis para entrega!', ['&O k']);
        Result := False;
      End
      Else If fStrToFloat(edtDiaEnt.Text) < 0 Then
      Begin
        fMensagem('', 'O número de dias úteis para entrega deve ser maior que Zero!', ['&O k']);
        Result := False;
      End;

      If (Result) And (Frac(fStrToFloat(edtDiaEnt.Text)) <> 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitido informar valor fracionado no número de dias úteis para entrega!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = cbGarant) Then
    Begin
      If fEmptyStr(cbGarant.Text) Or ((cbGarant.ItemIndex < 0) Or (cbGarant.ItemIndex > 3)) Then
      Begin
        fMensagem('AVISO', 'Selecione uma opção válida no campo "Em Garantia?"', ['&Ok']);
        Result := False;
      End;
      cbGarantChange(cbGarant);
    End

    Else If (Sender = edtCodTec) and (edtCodTec.Visible) Then
    Begin
      if fEmptyStr(edtCodTec.Text) and (fEhAnaliseTecnica) and (fCfgSis('OCDTEC', varBoolean)) then
      begin
        fMensagem('AVISO', 'O técnico deve ser preenchido!', ['&Ok']);
        Result := False;
      end
      Else If Not fEmptyStr(edtCodTec.Text) Then
      Begin
        edtDesTec.Text := fRetNomeOperador(edtCodTec.Text);

        If fEmptyStr(edtDesTec.Text) Then
        Begin
          fMensagem('AVISO', 'Técnico não encontrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DA MARCA              *}
    {**************************************MV*}
    Else If (Sender = edtCodEqu) Then
    Begin
      If fEmptyStr(edtCodEqu.Text) Then
      Begin
        fMensagem('', 'O Equipamento deve ser preenchido!' , ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaEquipamento;
        If qryCadEqu.FieldByName('EQU_CODIGO').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Equipamento não encontrado!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If edtCodIte.Enabled Then pnlItens.Enabled := True;
          If edtCodSe1.Enabled Then pnlServicos.Enabled := True;
          If edtCodDfe.Enabled Then pnlDefeitos.Enabled := True;
          If edtCodAce.Enabled Then pnlAcessorios.Enabled := True;
          If (not blnRotinaTecnico) Then
          Begin
            pnlMostraPrecoServ.visible := pnlServicos.enabled;
            pnlMostraPrecoProd.visible := pnlItens.enabled;
          End;
          grbDocEntrada.Enabled := True;
          grbDocSaida.Enabled   := True;

           fObterLotePrincipalGarantia(edtCodEqu.Text);
        End;
      End;
    End

    {*****************************************}
    {* VALIDA LOCALIZAÇÃO FÍSICA             *}
    {**************************************DH*}
    else if (Sender = edtCodLoc) and edtCodLoc.Visible then
    begin
      if (not fEmptyStr(edtCodLoc.Text)) then
      begin
        edtDesLoc.Text := fRetDescLocFisicaOS(edtCodLoc.Text);
        objConEqu.strLocFisEqu := edtCodLoc.Text;

        if fEmptyStr(edtDesLoc.Text) then
        begin
          objConEqu.strLocFisEqu := '';
          Result := False;
          fMensagem('Aviso', 'Localização não encontrada para a empresa atual!', ['&Ok']);
        end;
      end;
    end

    {*****************************************}
    {* VALIDA O ITEM                         *}
    {**************************************LU*}
    Else If (Sender = edtCodIte) Then
    Begin

      If fEmptyStr(edtCodIte.Text) Then
      Begin
        If blnBuscaPorChave Then
        Begin
          blnMudarFoco := False;
          pSetFocus(dbgGrid);
        End
        Else
          btnCancelaItem.Click;

      End
      Else
      Begin

        pPesquisaCadSem(qryCadIte, qryCadIte, edtCodIte.Text, '', False,
                        blnBuscarCodFab And rdbCodFab.Checked, '', False, not objConEqu.blnMulLoj);

        If (btnAdicionar.Tag = 0) And (blnBuscaPorChave) Then
        Begin
          pCarregaItem(blnBuscaPorChave, True, True);

          If (fMostraItensSimilares(qryCadIte.FieldByName('ITE_CODITE').AsString)) Then
          Begin
            blnBuscarCodFab := False;
            pPesquisaCadSem(qryCadIte, qryCadIte, edtCodIte.Text, '', False,
                            blnBuscarCodFab And rdbCodFab.Checked, '', False, not objConEqu.blnMulLoj);
            pCarregaItem(True, True);
            blnBuscarCodFab := rdbCodFab.checked;
          End;
        End;

        If (qryCadIte.FieldByName('ITE_CODITE').IsNull) Then
        Begin
          pLimpaDadosItem;
          fMensagem('', 'Esse item não está cadastrado!', ['&OK']);
          Result := False;
        End
        Else If qryCadIte.FieldByName('ITE_ITEATI').AsString <> 'S' Then
        Begin
          pLimpaDadosItem;
          fMensagem('', 'Esse item está Inativo!', ['&OK']);
          Result := False;
        End
        Else If (qryCadIte.FieldByName('ITE_CODITE').AsString = fCfgSis('ITESER')) Or
                (qryCadIte.FieldByName('ITE_CODITE').AsString = fCfgSis('SERTER')) Then
        Begin
          fMensagem('', 'Não é permitido vender um item de Serviço!', ['&OK']);
          Result := False;
        End
        Else If blnBuscaPorChave Then
        Begin
          If Not Result Then
            btnCancelaItem.Click;
        End;

      End;

    End

    {*****************************************}
    {* VALIDA A QUANTIDADE                   *}
    {**************************************LU*}
    Else If (Sender = edtQtdIte) And (Not fEmptyStr(edtCodIte.Text)) Then
    Begin
      If (edtQtdIte.ReadOnly) Then
      Begin
        Result := False;
      End
      Else If fEmptyStr(edtQtdIte.Text) Then
      Begin
        fMensagem('', 'A Quantidade deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If fStrToFloat(edtQtdIte.Text) <= 0 Then
      Begin
        fMensagem('', 'A Quantidade deve ser maior que Zero!', ['&O k']);
        Result := False;
      End;

      If (Result) And
         ((Frac(fStrToFloat(edtQtdIte.Text)) <> 0) And Assigned(edtQtdIte.OnKeyPress)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitido informar valor fracionado para esse item!', ['&O k']);
        Result := False;
      End;

      If Result And (btnAdicionar.Tag = 0) And (blnBuscaPorChave) Then
        pCarregaItem(blnBuscaPorChave, False, True);
    End

    {*****************************************}
    {* VALIDA VALOR UNITARIO                 *}
    {**************************************LU*}
    Else If (Sender = edtUnitar) And (Not fEmptyStr(edtCodIte.Text)) Then
    Begin

      If Not (edtUnitar.ReadOnly) Then
      Begin

        If fEmptyStr(edtUnitar.Text) Then
        Begin
          fMensagem('', 'O Valor Unitário deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else If (fStrToFloat(edtUnitar.Text) <= 0) And Not (chkBrindePro.Visible And chkBrindePro.Checked) Then
        Begin
          fMensagem('', 'O Valor Unitário deve ser maior que Zero!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          if blnBuscaPorChave then
            if Not fValidaUnitario(fStrToFloat(edtUnitar.Text)) Then
              Result := False;
        End;

      End;

      pCalculaTotIte;

    End

    Else If (Sender = edtCodCnd) And ((pnlCndPag.Visible) or blnBuscaPorChave) Then
    Begin

      If fEmptyStr(edtCodCnd.Text) And fEmptyStr(strCcnAnt) Then
      Begin
        fMensagem('ATENÇÃO!', 'A condição deve ser preenchida!', ['&O k']);
        Result := False;
      End

      Else If Result And (fCfgSis('USACND', varBoolean)) And (Not fEmpresaTemAcessoCondicaoPagto(edtCodCnd.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar esta condição. Verifique o Cadastro de Condições de Pagamento - Aba "Empresas Acesso".' , ['&O k']);
        Result := False;
      End

      Else If Not fCondicaoPagamentoClienteOk('PD', edtCodCnd.Text, 'C', edtCodCli.Text) Then
      Begin
        Result := False;
      End;

      If fAlterouCndFpg Then
      Begin
        blnVerificaLimiteCredito := True;

        if fCfgSis('EQUCND', varString) = 'I' then
          pCarregaCondicao;

        If qryConCnd.FieldByName('CND_CODIGO').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa condição não está cadastrada!', ['&O k']);
          Result := False;
        End;

        If (Result) Then
        Begin

          If fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k']);
            Result := False;
          End
          Else If Not fValidaCndPag(mskCndPag.Text, strConPag, VS_Date) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa condição de pagamento ' + fFormataCondPag(mskCndPag.Text) + ' ' +
                                  'não é valida!' + #13#10 +
                                  'Verifique se informou todas as parcelas e se as mesmas estão em ordem progressiva, ' +
                                  'exemplos válidos: (01)000, (01)030, (03)030.060.090', ['&O k']);
            Result := False;
          End
          Else If fEmptyStr(mskCndPag.Text) Then
          Begin
            Result := False;
          End;

          {*****************************************}
          {* CASO A CONDIÇÃO ESTEJA OK             *}
          {**************************************MV*}
          If (Result) And fRecalcular Then
          Begin
            blnManterPrecos := False;
            If (fCfgSis('CNDVEN') = 'I') And (fCfgSis('EQUMPO', varBoolean)) And (dbgGrid.DataSource.DataSet.RecordCount > 0) Then
            Begin

              If (fMensagem('AVISO!', 'Deseja manter os preços originais?', ['&Sim', '&Não'], 2) = 1) Then
              Begin

                blnManterPrecos := True;
                FblnSenhaIncorreta := False;

                If (Not (fEmptyStr(fCfgSis('SENEQU')))) Then
                Begin

                  Result := fMSG_SenhaManterPrecos;
                  blnManterPrecos := Result;

                  If Not(Result) Then
                  begin
                    FblnSenhaIncorreta := True;
                    fMensagem('','Senha incorreta!',['&OK']);
                  end;

                End;

              End;

              FblnManterPrecos := blnManterPrecos;
            End;

            mskCndPag.Text := strConPag;
            strFpgAnt      := edtForPag.Text;
            objConEqu.fltTaxJur := fRetTaxJur;
            objConEqu.fltPerDes := fRetPerDes;

            objConEqu.pRecalculaPrecos(cbTabPreco.Text, '', ((Not fEmptyStr(strCcnAnt)) And (strCcnAnt <> edtCodCnd.Text)), blnManterPrecos);

            pCalcPorDes;
            pInicializarFatVenda();
            pAtualizaTotais();

          End;
          strCcnAnt := edtCodCnd.Text;
          strConPagAnt := mskCndPag.Text;
        End;
      End;
    End
    Else If (Sender = mskCndPag) And ((pnlCndPag.Visible) or blnBuscaPorChave) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If StrToIntDef(Copy(mskCndPag.Text, 1, 2), 0 ) > 24 Then
      Begin
        fMensagem('', 'Não é permitido mais que 24 parcelas!', ['&O k']);
        Result := False;
      End
      Else If (qryConCnd.FieldByName('CND_PRZMED').AsFloat > 0) And (fCalcMediaPagto(mskCndPag.Text) > qryConCnd.FieldByName('CND_PRZMED').AsFloat ) And (mskCndPag.Text <> '01999') Then
      Begin
        fMensagem('', 'O prazo médio da condição de pagamento ultrapassou o ' +
                      'prazo permitido: ' + FloatToStrF(qryConCnd.FieldByName('CND_PRZMED').AsFloat, ffFixed, 12, 2 ), ['&O k']);
        Result := False;
      End
      Else
      Begin

        {*********************************************************************}
        {* VALIDAÇÃO DA COND. PAGTO PARA FORA SEMANA, DEZENA, QUINZENA E MES *}
        {******************************************************************LU*}
        If Pos(copy(mskCndPag.Text, 1, 2), 'FS_FD_FQ_FM') > 0 Then
        Begin
          mskCndPag.Text := fValidaCndPagFora(mskCndPag.Text);
          fValidaCampos(mskCndPag, False);
        End
        Else
        Begin

          If (copy(mskCndPag.Text, 1, 1) = 'F') Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If Not fValidaCndPag(mskCndPag.Text, strConPag, VS_Date) Then
            Begin
              fMensagem('ATENÇÃO!', 'Essa condição de pagamento ' + fFormataCondPag(mskCndPag.Text) + ' ' +
                                    'não é valida!' + #13#10 +
                                    'Verifique se informou todas as parcelas e se as mesmas estão em ordem progressiva, ' +
                                    'exemplos válidos: (01)000, (01)030, (03)030.060.090', ['&O k']);
              Result := False;
            End
            Else
            Begin
              If fEmptyStr(edtCodCnd.Text) Then
                Result := False;
            End;

            If Result Then
            Begin

              mskCndPag.Text := strConPag;

              {Req.: 111081 - Verifica se alterou máscara da condição de pagamento para recalcular}
              If (mskCndPag.Enabled) Then
              Begin
                If (strConPagAnt <> mskCndPag.Text) Then
                Begin
                  If fRecalcular Then
                  Begin

                    if (fCfgSis('EQUCND', varString) = 'I') then
                    begin
                      blnManterPrecos := False;
                      If (fCfgSis('CNDVEN') = 'I') And (fCfgSis('EQUMPO', varBoolean)) And (dbgGrid.DataSource.DataSet.RecordCount > 0) Then
                      Begin
                        If (fMensagem('AVISO!', 'Deseja manter os preços originais?', ['&Sim', '&Não'], 2) = 1) Then
                        Begin
                          blnManterPrecos := True;
                          FblnSenhaIncorreta := False;
                          If (Not (fEmptyStr(fCfgSis('SENEQU')))) Then
                          Begin
                            Result := fMSG_SenhaManterPrecos;
                            blnManterPrecos := Result;

                            If Not(Result) Then
                            begin
                              FblnSenhaIncorreta := True;
                              fMensagem('','Senha incorreta!',['&OK']);
                            end;
                          End;
                        End;
                      End;
                    end
                    else
                      blnManterPrecos := FblnManterPrecos;

                    objConEqu.fltTaxJur := fRetTaxJur;
                    objConEqu.fltPerDes := fRetPerDes;

                    objConEqu.pRecalculaPrecos(cbTabPreco.Text, '', True, blnManterPrecos);

                    pInicializarFatVenda();
                    pAtualizaTotais();

                  End;
                End;
              End;

              strConPagAnt := strConPag;

            End;

          End;

        End;

      End;

    End

    Else If (Sender = edtForPag) And ((pnlCndPag.Visible) or blnBuscaPorChave) Then
    Begin

      If fEmptyStr(edtForPag.Text) And fEmptyStr(strFpgAnt) Then
      Begin
        fMensagem('','O campo forma de pagamento deve ser preenchido!',['&OK']);
        Result := False;
      End

      Else If (edtForPag.Text = '009') Then
      Begin
        fMensagem('ATENÇÃO!', 'Esta condição não pode ser utilizada em Conserto de Equipamentos!', ['&O k']);
        Result := False;
      End

      Else If fRetornaStatusCadastro(edtForPag.Text, 'FPG', 'CADFPG', 'FPG_CODIGO') <> 'A' Then
      Begin
        fMensagem('ATENÇÃO!', 'Esta forma de pagamento não pode ser utilizada pois está inativa!', ['&O k']);
        Result := False;
      End

      Else
      Begin
        pCarregaForPag;

        If fEmptyStr(edtDesForPag.Text) Then
        Begin
          fMensagem('','Forma de pagamento não encontrada!',['&OK']);
          Result := False;
        End;

      End;

      If (fStatusCndPag(mskCndPag.Text) = A_VISTA) And
         (Pos(edtForPag.Text,'008_010_') > 0)      And
         (mskCndPag.Text <> '01999')               Then
      Begin
        fMensagem('','A forma de pagamento deve ser a vista!',['&OK']);
        Result := False;
      End;

      If (Result) And (Not fEmptyStr(edtForPag.Text)) And (Not fEmptyStr(mskCndPag.Text)) Then
      Begin
        If Pos(edtForPag.Text,'001_006_' + IIF(fCfgSis('PRACHC',varBoolean),'','002_007_')) > 0 Then
        Begin
          If (fStatusCndPag(mskCndPag.Text) <> A_VISTA) And (mskCndPag.Text <> '01999') Then
          Begin
            fMensagem('','A condição de pagamento deve ser a vista!',['&OK']);
            Result := False;
          End;
        End;
      End;

    End

    Else If (Sender = edtCodSe1) Then
    Begin
      If (pgcTabs.ActivePage = tbsServicos) Then
      Begin
        If Not fEmptyStr(edtCodSe1.Text) Then
        Begin
          blnMudarFoco := True;
          edtTemp := TEditFocus(fComponentByName(pnlServicos, 'edtDesSe' + RightStr(Sender.Name, 1)));
          Result := fCarregaServico(TEditFocus(Sender), edtTemp, blnBuscaPorChave);

          If (Not Result) Then
          Begin
            fMensagem('AVISO', 'Serviço não "Cadastrado/Ativo"!', ['&Ok']);
            Result := False;
          End
          Else If (edtCodSe1.Enabled) And (Not fEmptyStr(edtCodTecSe1.Text)) And (objConEqu.fServicoJaInclusoGrid(edtCodSe1.Text, edtCodTecSe1.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Serviço já foi adicionado para o mesmo técnico e não pode ser duplicado!', ['&Ok']);
            btnCancelaSe1.Click;
            Result := False;
          End
          Else If Not objConEqu.cdsSerEqu.isEmpty Then
          Begin
            If fCfgSis('ISSSER', varBoolean) Then
            Begin
              fltAliqIss := fCampoTabela('SER_ALQISS','CADSER', ['SER_CODSER'], [edtCodSe1.Text]);
              fltRedIss  := fCampoTabela('SER_REDISS','CADSER', ['SER_CODSER'], [edtCodSe1.Text]);
              objConEqu.cdsSerEqu.First;
              If fltAliqIss <> fCampoTabela('SER_ALQISS','CADSER', ['SER_CODSER'], [objConEqu.cdsSerEqu.FieldByName('CODSER').AsString]) Then
              Begin
                fMensagem('AVISO', 'A alíquota de ISS dos serviços devem ser todas iguais!', ['&Ok']);
                Result := False;
              End;
              If Result And (fltRedIss <> fCampoTabela('SER_REDISS','CADSER', ['SER_CODSER'], [objConEqu.cdsSerEqu.FieldByName('CODSER').AsString])) Then
              Begin
                fMensagem('AVISO', 'A redução de ISS dos serviços devem ser todas iguais!', ['&Ok']);
                Result := False;
              End;
            End;
          End;

          if Result and (not fEmptyStr(edtCodTec.Text)) and (fEmptyStr(edtCodTecSe1.Text)) then
          begin
            edtCodTecSe1.Text := edtCodTec.Text;
            edtDesTecSe1.Text := edtDesTec.Text;
          end;
        End
        Else
        Begin
          If blnBuscaPorChave Then
          Begin
            blnMudarFoco := False;
            pSetFocus(dbgServico);
          End
          Else
            btnCancelaSe1.Click;
        End;
      End;
    End

    else if (Sender = edtDesSe1) then
    begin
      if (pgcTabs.ActivePage = tbsServicos) and (not fEmptyStr(edtCodSe1.Text)) then
      begin
        if fEmptyStr(edtDesSe1.Text) then
        begin
          fMensagem('AVISO', 'Informe a descrição do serviço!', ['&Ok']);
          Result := False;
        end
      end;
    end

    else if (Sender = edtQtdSe1) then
    begin
      if (pgcTabs.ActivePage = tbsServicos) and (edtQtdSe1.Visible) then
      begin
        if (fEmptyStr(edtQtdSe1.Text)) then
        begin
          fMensagem('ATENÇÃO!', 'A quantidade deve ser preenchida!', ['&Ok']);
          Result := False;
        end

        else if (fStrToFloat(edtQtdSe1.Text) <= 0.0) then
        begin
          if fEmptyStr(edtCodSe1.Text) then
            edtQtdSe1.Text := '0,00'
          else
          begin
            fMensagem('ATENÇÃO!', 'A quantidade deve ser maior que Zero!', ['&Ok']);
            Result := False;
          end;
        end
      end
    end

    Else If (Sender = edtValSe1) Then
    Begin

      If (pgcTabs.ActivePage = tbsServicos) Then
      Begin
        If (fStrToFloat(edtValSe1.Text) <> 0) Then
        Begin
          edtTemp := TEditFocus(fComponentByName(pnlServicos, 'edtValSe' + RightStr(Sender.Name, 1)));
          If (edtTemp.Enabled) Then
            Result := fValidaValorSer(edtTemp);

          If Not fCfgSis('ALTSER', varBoolean) Then
          Begin
            fltValAlt := fFormataFloat(fStrToFloat(edtValSe1.Text), 2);

            If (Result) And (fFormataFloat(fltValSerOld, 2) <> fFormataFloat(fltValAlt, 2)) And (fFormataFloat(fltValOri, 2) <> fFormataFloat(fltValAlt, 2)) Then
            Begin
              objLiberacao.Clear;

              objLiberacao.objMsgLibera.pAddTexto('Alteração de Valor do Serviço.');
              objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'        , objConEqu.strCodCli + '-' + fRetNomCliente(objConEqu.strCodCli), 14);
              objLiberacao.objMsgLibera.pAddTextoCaption('Equipamento'    , fRetNomEquipamentoOS(objConEqu.strCodEqu)                      , 14);
              objLiberacao.objMsgLibera.pAddTextoCaption('Serviço'        , edtCodSe1.Text + '-' + edtDesSe1.Text                          , 14);
              objLiberacao.objMsgLibera.pAddTextoCaption('Valor Original' , FormatFloat('#,##0.00', fltValOri)                             , 14);
              objLiberacao.objMsgLibera.pAddTextoCaption('Valor Alterado' , FormatFloat('#,##0.00', fltValAlt)                             , 14) ;

              objLiberacao.strDirAce := 'SENSER';
              objLiberacao.strSenLib := '';
              objLiberacao.strMsgSen := 'Digitação de Serviço';
              objLiberacao.strCodOpe := fRetCodVendedor(edtSenVen.Text);
              objLiberacao.strCodDig := strLoginUsuarioLogado;

              Result := objLiberacao.fLibera;

              If Result Then
                fltValSerOld := fltValAlt;

            End
            Else
              fltValSerOld := fltValAlt;
          End;
        End;
      End;
    End

    Else If Sender = edtCodTecSe1 Then
    Begin
      If (pgcTabs.ActivePage = tbsServicos) And (Not fEmptyStr(edtCodSe1.Text)) Then
      Begin
        If fEmptyStr(edtCodTecSe1.Text) Then
        Begin
          fMensagem('', 'O Técnico deve ser preenchido!' , ['&Ok']);
          Result := False;
        End
        Else
        Begin
          edtDesTecSe1.Text := fRetNomeOperador(edtCodTecSe1.Text);
          If fEmptyStr(edtDesTecSe1.Text) Then
          Begin
            fMensagem('AVISO', 'Técnico não encontrado!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If Sender = edtCodAce Then
    Begin
      If (pgcTabs.ActivePage = tbsAcessorios) Then
      Begin
        If Not fEmptyStr(edtCodAce.Text) Then
        Begin
          edtDesAce.Text := fRetNomAcessorioOs(edtCodAce.Text);
          If fEmptyStr(edtDesAce.Text) Then
          Begin
            fMensagem('AVISO', 'Acessório não encontrado!', ['&Ok']);
            Result := False;
          End
          Else If (edtCodAce.Enabled) And (objConEqu.fAcessorioJaInclusoGrid(edtCodAce.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Acessório já foi adicionado e não pode ser duplicado!', ['&Ok']);
            btnCancelaAce.Click;
            Result := False;
          End;
        End;
      End;
    End

    else if (Sender = edtQtdAce) and (not fEmptyStr(edtCodAce.Text)) then
    begin
      if (edtQtdAce.ReadOnly) then
        Result := False
      else if fEmptyStr(edtQtdAce.Text) then
      begin
        fMensagem('', 'A Quantidade deve ser preenchida!', ['&O k']);
        Result := False;
      end
      else if fStrToFloat(edtQtdAce.Text) <= 0 then
      begin
        fMensagem('', 'A Quantidade deve ser maior que Zero!', ['&O k']);
        Result := False;
      end;

      if (Result) and (Frac(fStrToFloat(edtQtdAce.Text)) <> 0) then
      begin
        fMensagem('ATENÇÃO!', 'Não é permitido informar valor fracionado para Acessórios!', ['&O k']);
        Result := False;
      end;
    end

    Else If Sender = edtCodDfe Then
    Begin
      If (pgcTabs.ActivePage = tbsDefeitos) Then
      Begin
        If Not fEmptyStr(edtCodDfe.Text) Then
        Begin
          edtDesDfe.Text := fRetNomDefeitoOs(edtCodDfe.Text);
          If fEmptyStr(edtDesDfe.Text) Then
          Begin
            fMensagem('AVISO', 'Defeito não encontrado!', ['&Ok']);
            Result := False;
          End
          Else If (edtCodDfe.Enabled) And (objConEqu.fDefeitoJaInclusoGrid(edtCodDfe.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Defeito já foi adicionado e não pode ser duplicado!', ['&Ok']);
            btnCancelaDfe.Click;
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = edtSenDig) And (edtSenDig.Visible) Then
    Begin
      If fEmptyStr(edtSenDig.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O digitador deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaDigitador;

        If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse digitador não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else If qryConOpe.FieldByName('OPE_STATUS').AsString <> 'A' Then
        Begin
          fMensagem('ATENÇÃO!', 'Digitador está inativo!', ['&Ok']);
          Result := False;
        End;

        If (fCfgSis('DIGVEN', varBoolean)) And (fClienteConsumidor(edtCodCli.Text)) Then
        Begin
          edtSenVen.Text := edtSenDig.Text;
          pCarregaVendedor;
        End;

        If SameText(edtSenVen.Text, fCfgSis('VENDIG')) Then
        Begin
          edtSenVen.Text := edtSenDig.Text;
          pCarregaVendedor;
        End;
      End;
    End

    Else If (Sender = edtCodRep) And (edtCodRep.Enabled) Then
    Begin
      If fEmptyStr(edtCodRep.Text) Then
      Begin
        edtDesRep.Clear();

        objConEqu.strCodRep := '';
        objConEqu.strCodVe2 := '';
      End
      Else
      Begin
        pCarregaRepres;

        If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse vendedor não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else If qryConOpe.FieldByName('OPE_STATUS').AsString <> 'A' Then
        Begin
          fMensagem('ATENÇÃO!', 'Vendedor 2 está inativo!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtDisSer) And (Not edtDisSer.ReadOnly) And
            (tbsServicos.TabVisible) And (tbsServicosDiscriminacao.TabVisible) Then
    Begin
      If (fEmptyStr(edtDisSer.Text)) And
         (fUsaDiscriminacaoServico) And
         (Not objConEqu.cdsSerEqu.IsEmpty) And
         (Not Assigned(frmFatVendaItem)) And
         (fCfgSis('EMPSER', varString) = 'CITEL') And
         (fCfgSis('DSERCI', varBoolean)) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário informar a discriminação do serviço!', ['&OK']);

        pgcTabs.ActivePage := tbsServicos;
        pgcServicos.ActivePage := tbsServicosDiscriminacao;

        Result := False;
      End;
    End

    Else If (Sender = cmbStaRealizada) And (objConEqu.strStatus = 'R') And (cmbStaRealizada.Visible) And (not blnFluxoProcesso) Then
    Begin
      If (cmbStaRealizada.ItemIndex = -1)  Then
      Begin
        fMensagem('ATENÇÃO!', 'Não foi informado a situação de realizada da OS!', ['&OK']);
        Result := False;
      End
      Else If (cmbStaRealizada.ItemIndex > -1)  Then
      Begin
        pDefinirStatusAnt();

        If (cmbStaRealizada.ItemIndex = 0) Then
          objConEqu.strSubSta := 'C'
        Else If (cmbStaRealizada.ItemIndex = 1) Then
          objConEqu.strSubSta := 'A';

        If (objConEqu.strSubSta = 'A') Then
        Begin
          edtRetiradoPor.Text := '';
          objConEqu.strReaPor := '';
        End;
      End;
    End

    Else If (Sender = edtRetiradoPor) And (objConEqu.strStatus = 'R') And (edtRetiradoPor.Visible) Then
    Begin
      If (cmbStaRealizada.ItemIndex = 0) And (fEmptyStr(edtRetiradoPor.Text))  Then
      Begin
        fMensagem('ATENÇÃO!', 'Não foi informado quem retirou o equipamento. Operação cancelada!', ['&OK']);
        Result := False;
      End
      Else If (cmbStaRealizada.ItemIndex = 1) And (Not fEmptyStr(edtRetiradoPor.Text))  Then
      Begin
        fMensagem('ATENÇÃO!', 'Situação de realizada da OS informada é Armazenada, campo Retirado Por não deve ser informado!', ['&OK']);
        Result := False;

        edtRetiradoPor.Text := '';
        objConEqu.strReaPor := '';
      End
      Else If (cmbStaRealizada.ItemIndex > -1) And (Not fEmptyStr(edtRetiradoPor.Text))  Then
      Begin
        objConEqu.strReaPor := edtRetiradoPor.Text;
      End;
    End

    Else If (Sender = cmbEquEnt) And (Assigned(objMeqMerEnt)) And (Not fEmptyStr(objMeqMerEnt.strChaveAcesso)) And (cmbEquEnt.Items.Count > 0) Then
    Begin
      If (cmbEquEnt.ItemIndex = -1) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não foi informado o equipamento em manutenção relacionado a NF de entrada!', ['&OK']);
        pgcTabs.ActivePage := tbsDocsRelacionados;
        cmbEquEnt.DroppedDown := True;
        Result := False;
      End;
    End

    Else If (fCfgSis('NSROBG', varBoolean)) And (Sender = edtNSerie) Then
    Begin
      If (fEmptyStr(edtNSerie.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Número de Série deve ser informado!', ['&OK']);
        Result := False;
      End;
    End

    Else If (fCfgSis('NPATOB', varBoolean)) And (Sender = edtNumPat) Then
    Begin
      If (fEmptyStr(edtNumPat.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Número de Patrimônio deve ser informado!', ['&OK']);
        Result := False;
      End;
    End

    Else If (edtLocFis.Visible) And (Sender = edtLocFis) Then
    Begin
      If (Not fEmptyStr(edtLocFis.Text)) Then
        objConEqu.strLocFisEqu := edtLocFis.Text
      Else
        objConEqu.strLocFisEqu := '';
    End

    Else If (Sender = cbEstPrd) And (cbEstPrd.Visible) Then
    Begin
      If (fEmptyStr(cbEstPrd.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Estado do Produto deve ser informado!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtTipBriPrd) And pnlTipBriPrd.Visible Then
    Begin
      If (edtTipBriPrd.Text <> 'G') and (edtTipBriPrd.Text <> 'C') Then
      Begin
        fMensagem('','O Tipo de Brinde deve ser G ou C!', ['&Ok']);
        Result := False;
      end;
    End

    Else If (Sender = edtTipBriSer) And pnlTipBriSer.Visible Then
    Begin
      If (edtTipBriSer.Text <> 'G') and (edtTipBriSer.Text <> 'C') Then
      Begin
        fMensagem('','O Tipo de Brinde deve ser G ou C!', ['&Ok']);
        Result := False;
      end;
    End

    Else If (Sender = edtNFReme) Then
    Begin
      if (fEmptyStr(edtNFReme.Text)) and (StrToDateDef(mskDtNFRe.Text, 0) > 0) then
        mskDtNFRe.Clear
      else if (not blnBuscaPorChave) and (not fEmptyStr(edtNFReme.Text)) and (StrToDateDef(mskDtNFRe.Text, 0) = 0) then
      begin
        fMensagem('AVISO', 'É obrigatório informar a Data de emissão da NF de Remessa.', ['&Ok']);
        Result := False;
      end;
    End
    Else If (Sender = edtEmpIte) and (pnlEmpIte.Visible) And (Not fEmptyStr(edtCodIte.Text)) Then
    Begin
      edtEmpIte.Text := fStrZero(edtEmpIte.Text, 3);

      if fCfgSis('NOMEMP') = '2' then
        edtDesEmpIte.Text := fRetFantasiaEmpresa(edtEmpIte.Text)
      else
        edtDesEmpIte.Text := fRetNomeEmpresaSelec(edtEmpIte.Text);

      If fEmptyStr(edtEmpIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o Código da Empresa para o Item!', ['&Ok']);
        Result := False;
      End
      Else If fEmptyStr(edtDesEmpIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa não encontrada!', ['&Ok']);
        Result := False;
      End
      Else If (fCfgSis('ACEMPI', varBoolean)) And (Pos(edtEmpIte.Text, strEmpAcessoUsuarioLogado) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
        Result := False;
      End;

      If Result And blnBuscaPorChave And (Not fCfgSis('EXILIS', varBoolean)) Then
      Begin
        If (Not fEmptyStr(edtCodIte.Text)) And (Not objEmitirPedido.objFatVenda.fImprimeListaItem(edtEmpIte.Text, edtCodIte.Text)) Then
          Result := False;
      End;

      If Result And
        blnBuscaPorChave And
        (Not fCfgSis('IMPLST', varBoolean)) And
        (fCampoTabela('ITE_IMPLIS', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [edtCodIte.Text, edtEmpIte.Text]) = 'N') then
      begin
        pMensagemOk('O item está bloqueado para venda nesta empresa.' + #10#13 +
                    'Verifique o campo "Imprime Lista" aba "Complementos" no Cadastro de Produtos!');
        Result := False;
      end;
    End
    Else If (Sender = edtEmpSer) and (pnlEmpSer.Visible) Then
    Begin
      edtEmpSer.Text := fStrZero(edtEmpSer.Text, 3);

      if fCfgSis('NOMEMP') = '2' then
        edtDesEmpSer.Text := fRetFantasiaEmpresa(edtEmpSer.Text)
      else
        edtDesEmpSer.Text := fRetNomeEmpresaSelec(edtEmpSer.Text);

      If fEmptyStr(edtEmpSer.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o Código da Empresa para o Serviço!', ['&Ok']);
        Result := False;
      End
      Else If fEmptyStr(edtDesEmpSer.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa não encontrada!', ['&Ok']);
        Result := False;
      End
      Else If (fCfgSis('ACEMPI', varBoolean)) And (Pos(edtEmpSer.Text, strEmpAcessoUsuarioLogado) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
        Result := False;
      End;
    End;

    If (Result) And (edtCodRep.Visible) Then
    Begin
      pVerificaAlterarVendedor(qryCadCli.FieldByName('CLI_CODVEN').AsString,
                               qryCadCli.FieldByName('CLI_CODREP').AsString);
    End;
  End;

  If Not (Result) Then
    pSetFocus(Sender);

end;

function TfrmFatManConsertoEquip.fValidaConfirmar: Boolean;
var
  blnConfirma: Boolean;
begin
  Result := False;

  if (not fVerificaCampos) or (fTravaLimiteCredito) or (fTravaOSSemProdServ) then
    Exit;

  If (not blnRotinaTecnico) and (Not fValidaCampos(cbEstPrd)) then
    Exit;

  objConEqu.strCodCli := edtCodCli.Text;
  objConEqu.strTabPre := cbTabPreco.Text;
  objConEqu.strCodTec := edtCodTec.Text;

  if edtCodEmp.Visible Then
    objConEqu.strCodEmp := edtCodEmp.Text
  Else
    objConEqu.strCodEmp := VS_strCodEmp;

  objConEqu.strCodEqu := edtCodEqu.Text;
  objConEqu.strDescri := edtObs.Text;
  objConEqu.strObsGer := edtObsGer.Text;
  objConEqu.strObsNFS := edtObsNFS.Text;
  objConEqu.strDisSer := edtDisSer.Text;
  objConEqu.strNSerie := edtNSerie.Text;
  objConEqu.strGarant := fRetOpcaoEmGarantia;
  objConEqu.strNFComp := edtNFComp.Text;
  objConEqu.strNFReme := edtNFReme.Text;

  If StrToDateDef(mskDtNFco.Text, 0) <> 0 Then
    objConEqu.dtaDtNFCo := StrToDate(mskDtNFco.Text)
  else
    objConEqu.dtaDtNFCo := 0;

  If StrToDateDef(mskDtNFRe.Text, 0) <> 0 Then
    objConEqu.dtaDtNFRe := StrToDate(mskDtNFRe.Text)
  else
    objConEqu.dtaDtNFRe := 0;

  objConEqu.strRevend := edtRevend.Text;
  objConEqu.strConRet := edtConRet.Text;
  objConEqu.strDeiPor := edtDeiPor.Text;

  If StrToDateDef(mskEntreg.Text, 0) <> 0 Then
    objConEqu.dtaEntreg := StrToDate(mskEntreg.Text);

  if (not fEmptyStr(edtDiaEnt.Text)) then
    objConEqu.intDiaEnt := StrToInt(edtDiaEnt.Text)
  else
    objConEqu.intDiaEnt := 0;

  if (fCfgSis('USCNFP', varBoolean)) and (fCfgSis('EQUCND', varString) = 'F') then
  begin
    if not fCondicaoPagamentoFinal then
      Exit;
  end;

  objConEqu.strCodCnd := edtCodCnd.Text;
  objConEqu.strCodFpg := edtForPag.Text;
  objConEqu.strConPag := mskCndPag.Text;

  objConEqu.strProtoc := edtProtoc.Text;
  objConEqu.strCntCli := edtCntCli.Text;
  objConEqu.strCntTel := fTiraCaracEspeciais(mskCntTel.Text);
  objConEqu.strNumPat := edtNumPat.Text;
  objConEqu.strDadFab := edtDadFab.Text;
  objConEqu.strNOSFab := edtNOSFab.Text;
  objConEqu.strNOSAnt := edtNOSAnt.Text;

  if StrToDateDef(mskDtEAnt.Text, 0) <> 0 then
    objConEqu.dtaDtEAnt := StrToDate(mskDtEAnt.Text);

  if StrToDateDef(mskDtRAnt.Text, 0) <> 0 then
    objConEqu.dtaDtRAnt := StrToDate(mskDtRAnt.Text);

  if cbEstPrd.Visible then
    objConEqu.strCodEpr := fCampoTabela('EPR_CODEPR', 'CADEPR', ['EPR_DESCRI'], [cbEstPrd.Text]);

  if (not fEmptyStr(edtTmpGar.Text)) then
    objConEqu.intTmpGar := StrToInt(edtTmpGar.Text)
  else
    objConEqu.intTmpGar := 0;

  if pnlEmpSer.Visible then
    objConEqu.strEmpSer := edtEmpSer.Text
  else
    objConEqu.strEmpSer := objConEqu.strCodEmp;

  blnConfirma := fPedeEnderecoEntrega;

  pInicializarFatVenda;
  blnConfirma := (blnConfirma) And (fConfirmaDadosOS());

  if fCfgSis('TRVPOS') = '2' then
    blnConfirma := (blnConfirma) And (fVerificaVrMinimoInterna);

    Result := blnConfirma;
end;

function TfrmFatManConsertoEquip.fValidarCodRel(strCodLay: String): Boolean;
var
  strCod: string;
begin
  Result := False;

  if (fEmptyStr(strCodLay)) then
    Exit;

  strCod := fCampoTabela('LAY_CODLAY','LAYETI', ['LAY_CODLAY', 'LAY_TIPLAY'], [strCodLay, '89'], False);

  if (fEmptyStr(strCod)) then
    Exit;

  Result := True;
end;

function TfrmFatManConsertoEquip.fValidaRealizaManAgPecas: Boolean;
begin
  Result := True;

  if (not blnFluxoProcesso)  then
    Exit;

  if (not (tpProcessoFlx in [tprRealizarMan, tprManutencao])) then
    Exit;

  if (objConEqu.strFlxSit <> 'AP') then
    Exit;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Permitir seguir o fluxo e realizar a manutenção de OS que está com a situação Ag. Peças');
  objLiberacao.objMsgLibera.pAddTextoCaption('OS'      , objConEqu.strNumero            , 7);
  objLiberacao.objMsgLibera.pAddTextoCaption('Cliente' , objConEqu.strCodCli + ' - ' + fRetNomCliente(objConEqu.strCodCli), 7);

  objLiberacao.strDirAce := 'FXRMAP';
  objLiberacao.strMsgSen := 'Permitir seguir o fluxo e realizar a manutenção de OS que está com a situação Ag. Peças';
  objLiberacao.blnMosMen := True;
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;

  objLiberacao.pInformaNumDocEspDocCodEmp(
                    objConequ.strNumero,
                    'OS',
                    objConEqu.strCodEmp);

  if (not objLiberacao.fLibera) then
    Result := False;
end;

function TfrmFatManConsertoEquip.fValidaRealizaManAgSeparacao: Boolean;
begin
  Result := True;

  if (not blnFluxoProcesso)  then
    Exit;

  if (not (tpProcessoFlx in [tprRealizarMan, tprManutencao])) then
    Exit;

  if (objConEqu.strFlxSit <> 'AS') then
    Exit;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Permitir seguir o fluxo e realizar a manutenção de OS que está com a situação Ag. Separação');
  objLiberacao.objMsgLibera.pAddTextoCaption('OS'      , objConEqu.strNumero            , 7);
  objLiberacao.objMsgLibera.pAddTextoCaption('Cliente' , objConEqu.strCodCli + ' - ' + fRetNomCliente(objConEqu.strCodCli), 7);

  objLiberacao.strDirAce := 'FXRMAS';
  objLiberacao.strMsgSen := 'Permitir seguir o fluxo e realizar a manutenção de OS que está com a situação Ag. Separação';
  objLiberacao.blnMosMen := True;
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;

  if (not objLiberacao.fLibera) then
    Result := False;
end;

function TfrmFatManConsertoEquip.fValidarExpedicao: Boolean;
begin
  Result :=  (fCfgSis('EQUEXP', varBoolean)) And (fCfgSis('TIPEXP', varString) = '4') And
             (fHaProdutosNoPedido(objConEqu.strNumPed, objConEqu.strEmpPed))          And
             (objConEqu.fProdutosNaoExpedidos(objConEqu.strNumPed, objConEqu.strEmpPed, objConEqu.strCodCli));
end;

function TfrmFatManConsertoEquip.fValidarRegraUFVendaPresencial: Boolean;
var
  strEmpUF : String;

  function fTemItensRetira : Boolean;
  var
    cdsDados : TUniClientDataSet;
  begin
    if objConEqu.cdsIteEqu.IsEmpty then
      Result := True
    else
    begin
      cdsDados := TUniClientDataSet.Create(Self);
      pCloneDataSet(cdsDados, objConEqu.cdsIteEqu);

      cdsDados.Filtered := False;
      cdsDados.Filter   := 'ENTRET = ' + QuotedStr('R');
      cdsDados.Filtered := True;

      Result := Not cdsDados.IsEmpty;

      FreeAndNil(cdsDados);
    end;
  end;
begin

  Result := True;

  If Assigned(objConEqu) And Assigned(objConEqu.cdsIteEqu) And Assigned(objEndEnt) Then
  Begin

    If fEmptyStr(objEndEnt.recEndere.strEstEnt) Then
      pCarregaEnderecoEntrega('','', True);

    strEmpUF := fCadEmp('ESTADO');

    If (chkVenPre.Checked) And
       (Not fEmptyStr(objEndEnt.recEndere.strEstEnt)) And
       (Not fTemItensRetira) And
       (objEndEnt.recEndere.strEstEnt <> strEmpUF) Then
    Begin

      fMensagem('ATENÇÃO!', 'Não é permitido venda presencial com uf de destino diferente da uf da origem! Favor verificar o endereço de entrega.' + sLineBreak +
                            'UF Destino: ' + objEndEnt.recEndere.strEstEnt + sLineBreak +
                            'UF Origem : ' + strEmpUF, ['&Ok']);
      Result := False;

    End;

  End;

end;

function TfrmFatManConsertoEquip.fValidaSaldoInsuficiente: Boolean;
var
  fltSaldo,
  fltSaldoIte,
  fltSalResTot: Double;
begin
  Result := True;

  if fCfgSis('LPSSCE', varBoolean) then
  begin
    fltSaldo := objConEqu.fRetornaSaldoDisponivel(objConEqu.strCodIte, objConEqu.strEmpIte, fltSaldoIte, fltSalResTot);

    if (fltSaldo <= 0) or (fFormataFloat(fStrToFloat(edtQtdIte.Text), intDecQtde) > fFormataFloat(fltSaldo, intDecQtde)) then
    begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Liberar inclusão de produtos sem saldo de estoque no conserto de equipamentos');
      objLiberacao.objMsgLibera.pAddTexto('O Item abaixo não possui saldo de estoque:');
      objLiberacao.objMsgLibera.pAddSeparador(75);
      objLiberacao.objMsgLibera.pAddTextoCaption('Código'      , objConEqu.strCodIte, 11);
      objLiberacao.objMsgLibera.pAddTextoCaption('Descrição'   , objConEqu.strDesIte, 11);
      objLiberacao.objMsgLibera.pAddTextoCaption('Qtde Pedido' , FormatFloat(fMskDigitos(intDecQtde), fStrToFloat(edtQtdIte.Text)), 11);
      objLiberacao.objMsgLibera.pAddTextoCaption('Saldo'       , FormatFloat(fMskDigitos(intDecQtde), fltSaldo), 11);

      objLiberacao.strDirAce := 'LPSSCE';
      objLiberacao.strMsgSen := 'Liberar inclusão de produtos sem saldo de estoque no conserto de equipamentos';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCliente := edtCodCli.Text + '-' + edtNomCli.Text;
      objLiberacao.strCpfCnpj := objConEqu.strCliCgc;

      if not objLiberacao.fLibera then
        Result := False;
    end;
  end;
end;

function TfrmFatManConsertoEquip.fValidaTravaFluxoEnviarCliente: Boolean;
begin
  Result := False;

  if blnFluxoProcesso and (tpProcessoFlx = tprEnviarCliente) then
  begin
    blnVerificaLimiteCredito := True;

    if fTravaLimiteCredito(True) then
      Exit;

    if fTravaDebitosAtraso then
      Exit;

  end;

  Result := True;
end;

function TfrmFatManConsertoEquip.fValidaTravasEnviarCliente: Boolean;
begin
  Result := False;

  if (blnFluxoProcesso) and (tpProcessoFlx = tprEnviarCliente) then
  begin
    blnVerificaLimiteCredito := True;

    if fTravaLimiteCredito(True) then
      Exit;

    if fTravaDebitosAtraso then
      Exit;
  end;

  Result := True;
end;

function TfrmFatManConsertoEquip.fValidaDescServico: Boolean;
var
  fltDesMax,
  fltValSer: Double;
  qryCadSer,
  qrySerEqu: TUniQuery;
  objLinha : TLinhaMsgLibera;
  objTabela: TRegistroMsgLiberaTabela;
begin
  Result := True;

  Try
    If (fCfgSis('ALTSER', VarBoolean)) Then
    Begin
      qryCadSer := fCriaQuery;
      qryCadSer.SQL.Add('SELECT *');
      qryCadSer.SQL.Add('  FROM CADSER ');
      qryCadSer.SQL.Add('  LEFT JOIN TIPSER ON TPS_CODIGO = SER_TIPSER');
      qryCadSer.SQL.Add('  WHERE SER_CODSER = ' + QuotedStr(edtCodSe1.Text));
      qryCadSer.Open;

      if (qryCadSer.IsEmpty) then
        Exit;

      fltValSer := qryCadSer.FieldByName('SER_VALSER').AsFloat;
      fltDesMax := qryCadSer.FieldByName('SER_DESMAX').AsFloat;

      if (fCfgSis('VSEREQ', varBoolean)) then
      begin
        qrySerEqu := fCriaQuery;
        qrySerEqu.SQL.Add('SELECT EQS_VALSER, EQS_DESMAX ');
        qrySerEqu.SQL.Add('FROM SEREQU ');
        qrySerEqu.SQL.Add('WHERE EQS_CODSER = :CODSER ');
        qrySerEqu.SQL.Add('    AND EQS_CODEQU = :CODEQU ');
        qrySerEqu.ParamByName('CODSER').AsString := edtCodSe1.Text;
        qrySerEqu.ParamByName('CODEQU').AsString := edtCodEqu.Text;
        qrySerEqu.Open;

        if (not qrySerEqu.IsEmpty) then
        begin
          fltValSer := qrySerEqu.FieldByName('EQS_VALSER').AsFloat;
          fltDesMax := qrySerEqu.FieldByName('EQS_DESMAX').AsFloat;
        end;
      end;

      If (not chkBrindeSer.Checked) and (fStrToFloat(edtValSe1.Text) < ((100 - fltDesMax) / 100) * fltValSer) Then
      Begin
        objLiberacao.Clear;
        If (fCfgSis('SENFVU',varString) = 'F') Then
        Begin
          objLiberacao.objMsgLibera.pAddTexto('Desconto informado é maior que o permitido. Serviço bloqueado:');
          objLiberacao.objMsgLibera.pAddTexto('    * ' + edtCodSe1.Text + '-' + edtDesSe1.Text);
        End
        Else
        Begin
          objLiberacao.objMsgLibera.pAddTexto('DESCONTO MÁXIMO DE SERVIÇO ULTRAPASSADO ');

          objTabela := TRegistroMsgLiberaTabela.Create;

          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlCabecalho;
          objLinha.pAddColuna(''  , 'SERVIÇO'    , 19 , alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'DESC.PRAT.%', 11 , alDireita  , teAutcom);
          objLinha.pAddColuna(''  , 'DESC.MÁXI.%', 11 , alDireita  , teAutcom);
          objLinha.pAddColuna(''  , 'VALOR BRUTO', 11 , alDireita  , teAutcom);
          objLinha.pAddColuna(''  , 'VALOR DESC.', 11 , alDireita  , teAutcom);
          objLinha.pAddColuna(''  , 'VALOR LÍQUI', 11 , alDireita  , teAutcom);
          objTabela.lstLinhas.Add(objLinha);

          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna('SERVIÇO'    , edtCodSe1.Text + '-' + edtDesSe1.Text                                   , 19 , alEsquerda);
          objLinha.pAddColuna('DESC.PRAT.%', FloatToStrF(IIF(fStrToFloat(edtValSe1.Text) > 0, (1 - (fStrToFloat(edtValSe1.Text) / fltValSer)) * 100, 100), ffFixed, 10,2), 11 , alDireita );
          objLinha.pAddColuna('DESC.MÁXI.%', FloatToStrF(fltDesMax, ffFixed, 10,2)                                                            , 11 , alDireita );
          objLinha.pAddColuna('VALOR BRUTO', FloatToStrF(fltValSer, ffFixed, 10,2)                                                         , 11 , alDireita );
          objLinha.pAddColuna('VALOR DESC.', FloatToStrF(fltValSer - fStrToFloat(edtValSe1.Text), ffFixed, 10,2), 11 , alDireita );
          objLinha.pAddColuna('VALOR LÍQUI', FloatToStrF(fStrToFloat(edtValSe1.Text), ffFixed, 10,2)                                                         , 11 , alDireita );
          objTabela.lstLinhas.Add(objLinha);
          objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
        End;

        objLiberacao.strDirAce := 'DEMXSE';
        objLiberacao.strSenLib := fCfgSis('SENDMX');
        objLiberacao.strMsgSen := 'Desconto Máximo Ultrapassado';
        objLiberacao.blnMosMen := True;
        objLiberacao.strCodOpe := fRetCodVendedor(edtSenVen.Text);
        objLiberacao.strCodDig := strLoginUsuarioLogado;

        Result := objLiberacao.fLibera;
      End;
    End;
  Finally
    If Assigned(qryCadSer) Then FreeAndNil(qryCadSer);
  End;
end;

function TfrmFatManConsertoEquip.fValidaDocumentoEntrada: Boolean;
begin
  Result := True;

  if (fCampoTabela('CLI_OSNFEN', 'CADCLI', ['CLI_CODCLI'], [objConEqu.strCodCli], False) <> 'S') then
    Exit;

  if (objConEqu.strOperac <> 'I') then
    Exit;

  if Assigned(ObjMeqMerEnt) then
    Exit;

  fMensagem('ATENÇÃO!', 'É necessário informar o documento de entrada!', ['&OK']);
  pgcTabs.ActivePage := tbsDocsRelacionados;
  Result := False;
end;

function TfrmFatManConsertoEquip.fValidaHouveFaturamentoParcial(
  var ANumFat: String; const ANumDoc, ACodEmp: String): Boolean;
var
  LQry: TUniQuery;
begin
  if fEmptyStr(ANumDoc) then
    Exit(False);

  LQry := fCriaQuery;

  try
    LQry.SQL.Add('SELECT GROUP_CONCAT(DISTINCT FDO_NUMFAT, "-", FDO_TIPFAT, "-", FDO_EMPFAT) NUMFAT ');
    LQry.SQL.Add('FROM FATDOR ');
    LQry.SQL.Add('WHERE FDO_JAFATU = 1 ');
    LQry.SQL.Add('  AND FDO_NUMDOC = :NUMDOC ');
    LQry.SQL.Add('  AND FDO_ESPDOC = "PD" ');
    LQry.SQL.Add('  AND FDO_CODEMP = :CODEMP ');
    LQry.ParamByName('NUMDOC').AsString := ANumDoc;
    LQry.ParamByName('CODEMP').AsString := ACodEmp;
    LQry.Open;

    Result := (not fEmptyStr(LQry.FieldByName('NUMFAT').AsString));

    if Result then
      ANumFat := LQry.FieldByName('NUMFAT').AsString;
  finally
    FreeAndNil(LQry);
  end;
end;

function TfrmFatManConsertoEquip.fValidaImpressoOSPreco(strEsp: string;
  var strCodLay: String): Boolean;
begin
  Result := True;

  if (fCfgSis('IMOSSP', varBoolean)) and (strEsp = 'OS') then
  begin
    if (fGetMenu('Imprimir Relatório', ['Com Preço', 'Sem Preço'], 1) = 2) then
    begin
      strCodLay := fCfgSis('OSSPRE', varString);

      if not fValidarCodRel(strCodLay) then
      begin
        fMensagem('Atenção', 'Não foi encontrado o Layout para ordem de serviço sem preço. Verifique a configuração: CFG_OSSPRE!', ['&Ok']);
        Result := False;
      end;
    end;
  end;
end;

function TfrmFatManConsertoEquip.fValidaImpSepAprFluxo: Boolean;
begin
  Result := True;

  if (not blnFluxoProcesso) then
    Exit;

  if (tpProcessoFlx <> tprAprovar) then
    Exit;

  if (not fCfgSis('ISEPOS', varBoolean)) then
    Result := False;
end;

function TfrmFatManConsertoEquip.fValidaItensServAParte: Boolean;
begin
  Result := True;

  if (objConEqu.strGarant = 'N') then
    Exit;

  if (objConEqu.cdsIteEqu.RecordCount = 0) and (objConEqu.cdsSerEqu.RecordCount = 0) then
    Exit;

  if objConEqu.cdsIteEqu.Locate('COBAPA', 'N', []) then
    Exit;

  if objConEqu.cdsSerEqu.Locate('COBAPA', 'N', []) then
    Exit;

  Result := False;

  fMensagem('ATENÇÃO!', 'Não é permitido cobrar à parte todos os itens e serviços!', ['&Ok']);
end;

function TfrmFatManConsertoEquip.fValidaUnitario(fltUniDig: Double; blnPedeSenha: Boolean = True): Boolean;
  Var
    qryIte      : TUniQuery;
    fltPreTra   : Double;
    blnTraIteTmp: Boolean;

    function fDescontoMaximoItem: Double;
    begin
      If fCfgSis('ITETBP', VarBoolean) Then
        Result := fCampoTabela('ITE_DESMAX',
                               'ITETBP',
                              ['ITE_CODITE', 'ITE_CODEMP', 'ITE_TABPRE'],
                              [objConEqu.strCodIte, VS_strCodEmp, objConEqu.strTabPre])
      Else If fCfgSis('DMVFQV', VarBoolean) Then
        Result := GetDesMaxFaixaQtde(objConEqu.strCodIte,
                                     VS_strCodEmp,
                                     objConEqu.fltQtdIte)
      Else
        Result := fCampoTabela('ITE_DESMAX',
                               'ITEGER',
                              ['ITE_CODITE', 'ITE_CODEMP'],
                              [objConEqu.strCodIte, VS_strCodEmp]);
    End;

    function fRetornaVrDesconto(fltValUni, fltDesCon: Double): Double;
    Begin
      Result := fltDesCon;

      If (fCfgSis('TIPDES') = '%') Then
        Result := fFormataFloat((fltValUni * fltDesCon) / 100, 04);
    End;

begin
  Result       := True;
  blnTraIteTmp := False;

  If chkBrindePro.Visible And chkBrindePro.Checked Then
    Exit;

  If (fCfgSis('TRVPOS') = '2') Then
    Exit;

  fltPreTra := fRetornaUnitarioTrava(fltUniDig,
                                     objConEqu.fltUniOri,
                                     objConEqu.fltQtdIte,
                                     objConEqu.strCodIte,
                                     objConEqu.strTabPre);

  If (fFormataFloat(fltUniDig, intDecimal) < fFormataFloat(fltPreTra, intDecimal)) Then
    blnTraIteTmp := True;

  If blnTraIteTmp Then
  Begin
    objLiberacao.Clear;

    objLiberacao.objMsgLibera.pAddTexto('Valor Unitário Menor que o Preço de Mínimo.');
    objLiberacao.objMsgLibera.pAddTextoCaption('Produto'     , objConEqu.strDesIte                                               , 12);
    objLiberacao.objMsgLibera.pAddTextoCaption('Marca'       , fRetNomMarcaItem(objConEqu.strCodIte)                             , 12);
    objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade'  , FormatFloat(fMskDigitos(intDecQtde), fStrToFloat(edtQtdIte.Text)) , 12);
    objLiberacao.objMsgLibera.pAddTextoCaption('Pr.Tabela'   , FormatFloat('#,####0.0000', objConEqu.fltUniOri)                  , 12);
    objLiberacao.objMsgLibera.pAddTextoCaption('Pr.Digitado' , FormatFloat('#,####0.0000', fltUniDig)                            , 12);

    objLiberacao.strDirAce := 'OSMIN';
    objLiberacao.strSenLib := fCfgSis('SENLBD');
    objLiberacao.strMsgSen := 'Trava de Preço';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := fRetCodVendedor(edtSenVen.Text);
    objLiberacao.strCodDig := strLoginUsuarioLogado;
    objLiberacao.strCodIte := objConEqu.strCodIte;

    If Not (blnPedeSenha And objLiberacao.fLibera) Then
    Begin
      Result := False;
      Exit;
    End;
  End;

  FreeAndNil(qryIte);
end;

function TfrmFatManConsertoEquip.fValidaValorSer(edtValor: TEdit): Boolean;
begin
  Result := True;

  If (fEmptyStr(edtValor.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'O valor deve ser preenchido!', ['&Ok']);
    Result := False;
  End

  Else If (fStrToFloat(edtValor.Text) <= 0.0) And Not (chkBrindeSer.Visible And chkBrindeSer.Checked) Then
  Begin
    fMensagem('ATENÇÃO!', 'O valor deve ser maior que Zero!', ['&Ok']);
    Result := False;
  End;
end;

{*****************************************}
{* VERIFICA DEBITOS DO CLIENTE           *}
{* - CADREC / CADCHQ                     *}
{**************************************IV*}
function TfrmFatManConsertoEquip.fDebitoCliente(strCodCli: String): Double;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;
    fltTotDeb: Double;
begin
  qryGenTmp := fCriaQuery(Self);
  fltTotDeb := 0.0;

  If fCfgSis('CHQCCO', varBoolean) Then
  Begin

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCHQ ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CHQ_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  ((CHQ_DTADEP IS NULL) OR ((CHQ_DTADP2 IS NULL) AND (CHQ_DTADEV IS NOT NULL))) AND ';
    strSQL := strSQL + '  CHQ_INCCTR = "N" ';

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      Open;

      While Not Eof Do
      Begin
        fltTotDeb := fltTotDeb + FieldByName('CHQ_VALCHQ').AsFloat;
        Next;
      End;

      Close;
    End;

  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADREC ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  CTR_DTAREC IS NULL   AND ';
  strSQL := strSQL + '  CTR_VALDUP > 0           ';

  With qryGenTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := strCodCli;
    Open;

    While Not Eof Do
    Begin
      fltTotDeb := fltTotDeb + FieldByName('CTR_VALDUP').AsFloat;
      Next;
    End;

    Close;
  End;

  Result := fltTotDeb;

  FreeAndNil(qryGenTmp);

end;

procedure TfrmFatManConsertoEquip.pDestravaELimpaStlManEquLck;
  Var
    intAux: Integer;
Begin
  For intAux := 0 To stlManEquAltLck.Count - 1 Do
    fLock_Unlock(stlManEquAltLck[intAux], False, False);

  stlManEquAltLck.Clear;
End;

function TfrmFatManConsertoEquip.fVendeItem(cdsConsulta: TUniClientDataSet;
  DropControl: TControl; RectLinhaGrid: TRect): Boolean;
Begin
  Try
    Result := False;
    blnBuscarCodFab := False;

    Try
      If cdsConsulta.IsEmpty Then
        Exit;

      cdsConsultaItem := cdsConsulta;
      edtCodIte.Text  := cdsConsulta.FieldByName('ITE_CODITE').AsString;

      If objConEqu.cdsIteEqu.Locate('CODITE', edtCodIte.Text, []) Then
      Begin
        pCarregarProduto();
        pAtualizaDados(nil);
        pAtualizaTotais;
      End;

      If fValidaCampos(edtCodIte, True) Then
      Begin
        SelectNext(ActiveControl, True, True);

        pCriarFormularios(TfrmFatVendaItem, frmFatVendaItem);
        pnlItens.Parent := frmFatVendaItem;
        pnlItens.BevelOuter := bvNone;
        frmFatVendaItem.fValidaCamposVenda := fValidaCampos;

        frmFatVendaItem.Width        := 1366;
        frmFatVendaItem.ClientHeight := pnlItens.Height + frmFatVendaItem.pnlStatus.Height;

        edtCodIte.ReadOnly := True;
        edtCodIte.TabStop  := False;

        If (Not edtCodIte.Enabled) Then
          frmFatVendaItem.OnKeyDown := pExcluirKeyDown;

        frmFatVendaItem.ShowModal;

        pnlItens.BevelOuter := bvRaised;

        edtCodIte.ReadOnly := False;
        edtCodIte.TabStop  := True;

        pnlItens.Parent := tbsProdutos;
        btnCancelaItem.Click();

        pFreeAndNil(frmFatVendaItem);

        Result := True;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmFatManConsertoEquip.fVendeItem]');
      End;
    End;
  Finally
    If cdsConsultaItem <> Nil Then
      cdsConsultaItem := Nil;
  End;
end;

function TfrmFatManConsertoEquip.fVerificaAcessoriosInclusao: Boolean;
begin
  Result := True;

  if (not fCfgSis('OSACOB', varBoolean)) then
    Exit;

  if (objConEqu.strOperac <> 'I') then
    Exit;

  if (not objConEqu.cdsAceEqu.IsEmpty) then
    Exit;

  fMensagem('ATENÇÃO!', 'É necessário informar pelo menos um acessório!', ['&OK']);
  pgcTabs.ActivePage := tbsAcessorios;
  Result := False;
end;

function TfrmFatManConsertoEquip.fVerificaAdiantamento: Boolean;
var
  fltAdt: Double;
  qryFGOEQU: TUniQuery;
begin
  Result := False;

  qryFGOEQU := fCriaQuery(Self);

  try
    qryFGOEQU.Close;
    qryFGOEQU.SQL.Text := SELECT_PD_EQUGOR;
    qryFGOEQU.ParamByName('SEQEQU').AsString := objConEqu.strAutInc;
    qryFGOEQU.Open;

    if (not qryFGOEQU.IsEmpty) then
    begin
      while not qryFGOEQU.Eof do
      begin
        fltAdt := TAdiantamento.fGetTotaisAdiantamento(qryFGOEQU.FieldByName('NUMDOC').AsString, 'PD', qryFGOEQU.FieldByName('CODEMP').AsString).fltValLan;

        if (fltAdt > 0) then
        begin
          fMensagem('ATENÇÃO!', 'O pedido da OS "' + qryFGOEQU.FieldByName('NUMDOC').AsString + '-PD-' + qryFGOEQU.FieldByName('CODEMP').AsString
            + '" possui adiantamento e por isso, a condição de pagamento não pode ser alterada', ['&OK']);
          Result := True;
          Exit;
        end;

        qryFGOEQU.Next;
      end;
    end
    else
    begin
      fltAdt := TAdiantamento.fGetTotaisAdiantamento(objConEqu.strNumPed, 'PD', objConEqu.strEmpPed).fltValLan;

      if (fltAdt > 0) then
      begin
        fMensagem('ATENÇÃO!', 'O pedido da OS "' + objConEqu.strNumPed + '-PD-' + objConEqu.strEmpPed + '" possui adiantamento e por isso,'
          + ' a condição de pagamento não pode ser alterada', ['&OK']);
        Result := True;
      end;
    end;
  finally
    FreeAndNil(qryFGOEQU);
  end;
end;

function TfrmFatManConsertoEquip.fVerificaLimiteCreditoCliente(strCodCli: String): Boolean;

  function fGetSql: String;
  Begin
    Result := '';
    Result := Result + ' SELECT ';
    Result := Result + '   IFNULL(SUM(CTR_VALDUP),0) AS SOMA ';
    Result := Result + ' FROM CADREC ';
    Result := Result + ' WHERE ';
    Result := Result + '   CTR_DTAREC IS NULL AND ';
    Result := Result + '   CTR_VALDUP < 0     AND ';
    Result := Result + '   CTR_CODCLI = :CODCLI ';
  End;

  Var
    qryAux: TUniQuery;
    fltAbe: Double;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add(fGetSql);
  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.Open;

  fltAbe := Abs(qryAux.FieldByName('SOMA').AsFloat);
  qryAux.Close;

  qryAux.SQL.Clear;
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add(' CLI_LIMCRE ');
  qryAux.SQL.Add('FROM CADCLI ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add(' CLI_CODCLI = :CODCLI ');
  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.Open;

  Result := (qryAux.FieldByName('CLI_LIMCRE').AsFloat - fDebitoCliente(strCodCli) + fltAbe) > 0;

  FreeANdNil(qryAux);
End;

function TfrmFatManConsertoEquip.fVerificaPDFaturado: TTipoFatuPDConEqu;
var
  blnJaFatu,
  blnJaBaix,
  blnImp,
  blnSepImp,
  blnBaixado,
  blnFaturado: Boolean;
  strCodVen,
  LNumFat: String;
  qryFGOEQU: TUniQuery;
begin
  blnBaixado := False;
  blnFaturado := False;

  qryFGOEQU := fCriaQuery(Self);

  try
    qryFGOEQU.Close;
    qryFGOEQU.SQL.Text := SELECT_PD_EQUGOR;
    qryFGOEQU.ParamByName('SEQEQU').AsString := objConEqu.strAutInc;
    qryFGOEQU.Open;

    if (not qryFGOEQU.IsEmpty) then
    begin
      while not qryFGOEQU.Eof do
      begin
        fDocumentoFatExiste(qryFatgor,
                            qryFGOEQU.FieldByName('NUMDOC').AsString,
                            'PD',
                            qryFGOEQU.FieldByName('CODEMP').AsString,
                            blnJaFatu, blnJaBaix, blnImp, strCodVen, blnSepImp);

        blnJaFatu := blnJaFatu or fValidaHouveFaturamentoParcial(LNumFat, qryFGOEQU.FieldByName('NUMDOC').AsString, qryFGOEQU.FieldByName('CODEMP').AsString);

        if blnJaFatu then
        begin
          if (not fEmptyStr(qryFatgor.FieldByName('FGO_MOTBAI').AsString)) then
            blnBaixado := True
          else
            blnFaturado := True;
        end;

        qryFGOEQU.Next;
      end;
    end
    else
    begin
      fDocumentoFatExiste(qryFatgor,
                          objConEqu.strNumPed,
                          'PD',
                          objConEqu.strEmpPed,
                          blnJaFatu, blnJaBaix, blnImp, strCodVen, blnSepImp);

      blnJaFatu := blnJaFatu or fValidaHouveFaturamentoParcial(LNumFat, objConEqu.strNumPed, objConEqu.strEmpPed);

      if blnJaFatu then
      begin
        if (not fEmptyStr(qryFatgor.FieldByName('FGO_MOTBAI').AsString)) then
          blnBaixado := True
        else
          blnFaturado := True;
      end;
    end;

    if blnFaturado then
      Result := tpFaturado
    else if blnBaixado then
      Result := tpBaixado
    else
      Result := tpNaoFaturado;
  finally
    FreeAndNil(qryFGOEQU);
  end;
end;

function TfrmFatManConsertoEquip.fVerificaPedidoReprovacao(var blnDeletaPD: Boolean): Boolean;
var
  strNumFat,
  strPedidos: String;
  intCount  : Integer;
  qryFGOEQU : TUniQuery;
begin
  Result := False;
  strPedidos := '';

  qryFGOEQU := fCriaQuery(Self);

  try
    qryFGOEQU.Close;
    qryFGOEQU.SQL.Text := SELECT_PD_EQUGOR;
    qryFGOEQU.ParamByName('SEQEQU').AsString := objConEqu.strAutInc;
    qryFGOEQU.Open;

    if (not qryFGOEQU.IsEmpty) then
    begin
      intCount := qryFGOEQU.RecordCount;

      while not qryFGOEQU.Eof do
      begin
        strNumFat := fRetNumFatPD(qryFGOEQU.FieldByName('NUMDOC').AsString, 'PD', qryFGOEQU.FieldByName('CODEMP').AsString);

        If Not fEmptyStr(strNumFat) Then
        Begin
          fMensagem('', 'Esta O.S. gerou o Pedido ' + qryFGOEQU.FieldByName('NUMDOC').AsString + '-PD-' + qryFGOEQU.FieldByName('CODEMP').AsString + ', quando APROVADA.' + #13 +
                        'Este pedido já foi faturado no documento ' + strNumFat + '.' + #13 +
                        'Desta forma, esta O.S. não pode ser REPROVADA.', ['&OK']);
          Result := True;
          Exit;
        End
        Else
        Begin
          if (qryFGOEQU.RecNo = intCount) and (intCount > 1) then
            strPedidos := strPedidos + ' e ' + strNumFat
          else
            strPedidos := strPedidos + ', ' + strNumFat;
        End;

        qryFGOEQU.Next;
      end;

      strPedidos := Copy(strPedidos, 3, length(strPedidos));

      if (fMensagem('', 'Esta O.S. gerou o(s) Pedido(s) ' + strPedidos + ', quando APROVADA.' + #13 +
                         IIF(intCount = 1, 'Como o mesmo ainda não foi faturado, a REPROVAÇÃO cancelará o PD.',
                                          'Como os mesmos ainda não foram faturados, a REPROVAÇÃO cancelará o PD.') + #13 + #13 +
                         'Confirma Status REPROVADO para Ordem de Serviço?', ['&Sim', '&Não']) = 1) then
        blnDeletaPD := True
      else
        Result := True;
    end
    else
    begin
      strNumFat := fRetNumFatPD(objConEqu.strNumPed, 'PD', objConEqu.strEmpPed);

      If Not fEmptyStr(strNumFat) Then
      Begin
        fMensagem('', 'Esta O.S. gerou o Pedido ' + objConEqu.strNumPed + '-PD-' + objConEqu.strEmpPed + ', quando APROVADA.' + #13 +
                      'Este pedido já foi faturado no documento ' + strNumFat + '.' + #13 +
                      'Desta forma, esta O.S. não pode ser REPROVADA.', ['&OK']);
        Result := True;
      End
      Else
      Begin
        If (fMensagem('', 'Esta O.S. gerou o Pedido ' + objConEqu.strNumPed + '-PD-' + objConEqu.strEmpPed + ', quando APROVADA.' + #13 +
                          'Como o mesmo ainda não foi faturado, a REPROVAÇÃO cancelará o PD.' + #13 + #13 +
                          'Confirma Status REPROVADO para Ordem de Serviço?', ['&Sim', '&Não']) = 1) Then
          blnDeletaPD := True
        Else
          Result := True;
      End;
    end;
  finally
    FreeAndNil(qryFGOEQU);
  end;
end;

function TfrmFatManConsertoEquip.fVerificaVrMinimoInterna(blnPedeSenha: Boolean): Boolean;
  Var
    fltPreTra      : Double;
    fltPreTraUni   : Double;
    fltValMin      : Double;
    fltTotGer      : Double;
    fltDesConcedido: Double;
    fltPerDesConced: Double;
    fltDesMaximoPer: Double;
    fltMinCus      : Double;
    cdsDados       : TUniClientDataSet;
    fltPreTab      : Double;
    blnValorMenorQueMinimo: Boolean;
Begin
  Result    := True;
  fltValMin := 0;
  fltTotGer := 0;
  fltMinCus := 0;
  fltPreTab := 0;
  fltPreTra := 0;

  cdsDados := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsDados, objConEqu.cdsIteEqu);

  If objConEqu.cdsIteEqu.Filtered Then
  Begin
    cdsDados.Filter   := objConEqu.cdsIteEqu.Filter;
    cdsDados.Filtered := True;
  End;

  With cdsDados Do
  Begin
    First;

    While (Not Eof) Do
    Begin

      If (FieldByName('BRINDE').AsString <> 'S') And
         (Not fEhItemServico(FieldByName('CODITE').AsString)) Then
      Begin
        fltPreTraUni := fFormataFloat(fRetornaUnitarioTrava(FieldByName('UNITAR').AsFloat,
                                                            FieldByName('UNIORI').AsFloat,
                                                            FieldByName('QTDITE').AsFloat,
                                                            FieldByName('CODITE').AsString,
                                                            cbTabPreco.Text), intDecimal);

        fltPreTra := fltPreTra + fltPreTraUni;
        fltPreTab := fltPreTab + fFormataFloat((FieldByName('UNIORI').AsFloat * FieldByName('QTDITE').AsFloat), intDecimal);
        fltValMin := fltValMin + fFormataFloat((fltPreTraUni * FieldByName('QTDITE').AsFloat), intDecimal);
        fltTotGer := fltTotGer + fFormataFloat((FieldByName('VLRCON').AsFloat), intDecimal);
        fltMinCus := fltMinCus + fFormataFloat((FieldByName('TOTCUS').AsFloat), intDecimal);
      End;

      Next;
    End;

    blnValorMenorQueMinimo := (fFormataFloat(fltTotGer, 2) < fFormataFloat(fltValMin, 2));

    If Not blnPedeSenha Then
      Result := Not blnValorMenorQueMinimo;

    If blnValorMenorQueMinimo And blnPedeSenha Then
    Begin
      fltDesConcedido := fltPreTab - fltTotGer;
      fltPerDesConced := (fltDesConcedido / fltPreTab) * 100;
      fltDesMaximoPer := (fltPreTab - fltValMin);

      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Valor da Venda Menor que o Valor Mínimo.');
      objLiberacao.objMsgLibera.pAddTextoCaption('Preço de Tabela'           , FormatFloat('#,##0.00', fltPreTab)             , 25);

      objLiberacao.objMsgLibera.pAddTextoCaption('Desconto Máximo Permitido' , FormatFloat('#,##0.00', fltDesMaximoPer)       , 25);
      objLiberacao.objMsgLibera.pAddTextoCaption('Desconto Concedido'        , FormatFloat('#,##0.00', fltDesConcedido)       , 25);
      objLiberacao.objMsgLibera.pAddTextoCaption('% Desconto Concedido'      , FormatFloat('#,##0.00', fltPerDesConced) + '%' , 25);

      If (VS_strTRVEPR = '2') Then
      Begin
        objLiberacao.objMsgLibera.pAddTextoCaption('Valor do documento'      , FormatFloat('#,##0.00', fltTotGer)             , 25);
        objLiberacao.objMsgLibera.pAddTextoCaption('Valor mínimo permitido'  , FormatFloat('#,##0.00', fltValMin)             , 25);
      End;

      objLiberacao.strDirAce := 'OSMIN';
      objLiberacao.strSenLib := fCfgSis('SENLBD');
      objLiberacao.strMsgSen := 'Trava de Preço';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := fRetCodVendedor(edtSenVen.Text);
      objLiberacao.strCodDig := strLoginUsuarioLogado;
      objLiberacao.strCodIte := objConEqu.strCodIte;

      If (Not objLiberacao.fLibera) Then
      Begin
        Result := False;
      End;
    End;
  End;
end;

procedure TfrmFatManConsertoEquip.imgEquDblClick(Sender: TObject);
var
  blnIncluirImagens: Boolean;
begin
  inherited;

  if (fInclusaoOrdemServico) then
  begin
    fMensagem('', 'Salve a Ordem de Serviço antes de cadastrar a imagem!', ['&Ok']);
    Exit;
  end;

  if (fEmptyStr(objConEqu.strAutInc)) then
  begin
    fMensagem('', 'Selecione uma um Ordem de Serviço para continuar!', ['&Ok']);
    Exit;
  end;

  blnIncluirImagens := (objConEqu.strOperac = 'A') and btnConfirmar.Visible and btnConfirmar.Enabled;

  TfrmImagens.pAbrirImagens(tiConsertoEquip, objConEqu.strAutInc, (not blnIncluirImagens));
  pCarregaImagem;
end;

function TfrmFatManConsertoEquip.fVerificarPedFat_AltCodPagto: Boolean;
var
  blnJaFatu,
  blnJaBaix,
  blnImp,
  blnSepImp: Boolean;
  strCodVen,
  strMessage,
  LNumFat: String;
  qryFGOEQU: TUniQuery;
begin
  Result := True;

  qryFGOEQU := fCriaQuery(Self);

  try
    qryFGOEQU.Close;
    qryFGOEQU.SQL.Text := SELECT_PD_EQUGOR;
    qryFGOEQU.ParamByName('SEQEQU').AsString := objConEqu.strAutInc;
    qryFGOEQU.Open;

    if (not qryFGOEQU.IsEmpty) then
    begin
      strMessage := '';

      while not qryFGOEQU.Eof do
      begin
        fDocumentoFatExiste(qryFatgor,
                            qryFGOEQU.FieldByName('NUMDOC').AsString,
                            'PD',
                            qryFGOEQU.FieldByName('CODEMP').AsString,
                            blnJaFatu, blnJaBaix, blnImp, strCodVen, blnSepImp);

        blnJaFatu := blnJaFatu or fValidaHouveFaturamentoParcial(LNumFat, qryFGOEQU.FieldByName('NUMDOC').AsString, qryFGOEQU.FieldByName('CODEMP').AsString);

        if blnJaFatu then
        begin
          if (fEmptyStr(strMessage)) then
            strMessage := 'O pedido "' + qryFGOEQU.FieldByName('NUMDOC').AsString + '-PD-'
              + qryFGOEQU.FieldByName('CODEMP').AsString + '" já foi faturado no documento '
              + qryFatgor.FieldByName('FGO_NUMFAT').AsString + '-' + qryFatgor.FieldByName('FGO_TIPFAT').AsString + '-' + qryFatgor.FieldByName('FGO_EMPFAT').AsString
          else
            strMessage := strMessage + ' e o pedido "' + qryFGOEQU.FieldByName('NUMDOC').AsString + '-PD-'
              + qryFGOEQU.FieldByName('CODEMP').AsString + '" já foi faturado no documento '
              + qryFatgor.FieldByName('FGO_NUMFAT').AsString + '-' + qryFatgor.FieldByName('FGO_TIPFAT').AsString + '-' + qryFatgor.FieldByName('FGO_EMPFAT').AsString;

          Result := False;
        end;

        qryFGOEQU.Next;
      end;

      if (not Result) then
      begin
        fMensagem('ATENÇÃO!',strMessage + ' e por isso, a condição de pagamento não pode ser alterada', ['&OK']);
      end;
    end
    else
    begin
      fDocumentoFatExiste(qryFatgor,
                          objConEqu.strNumPed,
                          'PD',
                          objConEqu.strEmpPed,
                          blnJaFatu, blnJaBaix, blnImp, strCodVen, blnSepImp);

      blnJaFatu := blnJaFatu or fValidaHouveFaturamentoParcial(LNumFat, objConEqu.strNumPed, objConEqu.strEmpPed);

      if blnJaFatu then
      begin
        fMensagem('ATENÇÃO!','O pedido da OS ' + objConEqu.strNumPed + '-PD-' + objConEqu.strEmpPed + ' já foi faturado no documento '
            + qryFatgor.FieldByName('FGO_NUMFAT').AsString + '-' + qryFatgor.FieldByName('FGO_TIPFAT').AsString + '-' + qryFatgor.FieldByName('FGO_EMPFAT').AsString
            + ' e por isso, a condição de pagamento não pode ser alterada', ['&OK']);

        Result := False;
      end;
    end;
  finally
    FreeAndNil(qryFGOEQU);
  end;
end;

function TfrmFatManConsertoEquip.fVerificarPedFat_OsRealizada: Boolean;
Var
  blnOk,
  blnJaBaix,
  blnImp,
  blnSepImp,
  blnPedEncontrado: Boolean;
  strCodVen,
  strMessage,
  LNumFat: String;
  qryFGOEQU: TUniQuery;
begin
  Result := True;
  blnPedEncontrado := False;

  qryFGOEQU := fCriaQuery(Self);

  try
    qryFGOEQU.Close;
    qryFGOEQU.SQL.Text := SELECT_PD_EQUGOR;
    qryFGOEQU.ParamByName('SEQEQU').AsString := objConEqu.strAutInc;
    qryFGOEQU.Open;

    if (not qryFGOEQU.IsEmpty) then
    begin
      strMessage := '';

      while not qryFGOEQU.Eof do
      begin
        if fDocumentoFatExiste(qryFatgor, qryFGOEQU.FieldByName('NUMDOC').AsString, 'PD', qryFGOEQU.FieldByName('CODEMP').AsString, blnOk, blnJaBaix, blnImp, strCodVen, blnSepImp) Then
        Begin
          blnPedEncontrado := True;
          {Baixado via F10 "Pesquisa"!}
          If (blnOk) And (Not fEmptyStr(qryFatgor.FieldByName('FGO_MOTBAI').AsString)) Then
          Begin
            fMensagem('ATENÇÃO!','O Pedido "' + qryFGOEQU.FieldByName('NUMDOC').AsString + '-PD-'
              + qryFGOEQU.FieldByName('CODEMP').AsString + '" gerado desta O.S. foi baixado e não será mais entregue.' + #13#10 +
                                 qryFatgor.FieldByName('FGO_MOTBAI').AsString + #13#10 +
                                 'Motivo: ' + fRetDescOcorrencia(qryFatgor.FieldByName('FGO_CODOCO').AsString) + #13#10 +
                                 'Não será permitida alteração desta ordem de serviço.', ['&OK']);
            Result := False;
            Exit;
          End
          Else If (blnOk) And (fEmptyStr(qryFatgor.FieldByName('FGO_MOTBAI').AsString)) Then {Já Faturado!}
          Begin
            If InformarNFEntSaiAlterarObsOSRealizadaReprovada Then
              strMessage := 'Pedido de Venda gerado desta O.S. Já foi faturado.' + #13#10 +
                             'Documento: ' + qryFatgor.FieldByName('FGO_NUMFAT').AsString + '-' +
                                             qryFatgor.FieldByName('FGO_TIPFAT').AsString + '-' +
                                             qryFatgor.FieldByName('FGO_EMPFAT').AsString + #13#10 +
                             'Data: ' + qryFatgor.FieldByName('FGO_DTAFAT').AsString      + #13#10 +
                             'Somente algumas informações poderão ser alteradas.'
            else
            begin
              fMensagem('ATENÇÃO!','Pedido de Venda gerado desta O.S. Já foi faturado.' + #13#10 +
                                   'Documento: ' + qryFatgor.FieldByName('FGO_NUMFAT').AsString + '-' +
                                                   qryFatgor.FieldByName('FGO_TIPFAT').AsString + '-' +
                                                   qryFatgor.FieldByName('FGO_EMPFAT').AsString + #13#10 +
                                   'Data: ' + qryFatgor.FieldByName('FGO_DTAFAT').AsString      + #13#10 +
                                   'Não será permitida alteração desta ordem de serviço.', ['&OK']);
              Result := False;
              Exit;
            end;
          end
          else if fValidaHouveFaturamentoParcial(LNumFat, qryFGOEQU.FieldByName('NUMDOC').AsString, qryFGOEQU.FieldByName('CODEMP').AsString) then
          begin
            if InformarNFEntSaiAlterarObsOSRealizadaReprovada and (Pos(objConEqu.strStatus, 'R_N_') > 0) then
              strMessage := 'Pedido de Venda gerado desta O.S. possui faturamento parcial.' + #13#10 +
                            'Documento(s): ' + LNumFat + #13#10 +
                            'Somente algumas informações poderão ser alteradas.'
            else
            begin
              fMensagem('ATENÇÃO!','Pedido de Venda gerado desta O.S. possui faturamento parcial.' + #13#10 +
                                   'Documento(s): ' + LNumFat + #13#10 +
                                   'Não será permitida alteração desta ordem de serviço.', ['&OK']);
              Result := False;
              Exit;
            end;
          end;
        end;

        qryFGOEQU.Next;
      End;

      if (not fEmptyStr(strMessage)) then
        fMensagem('ATENÇÃO!', strMessage, ['&OK']);
    end
    else
    begin
      If fDocumentoFatExiste(qryFatgor, objConEqu.strNumPed, 'PD', objConEqu.strEmpPed, blnOk, blnJaBaix, blnImp, strCodVen, blnSepImp) Then
      Begin
        blnPedEncontrado := True;
        {Baixado via F10 "Pesquisa"!}
        If (blnOk) And (Not fEmptyStr(qryFatgor.FieldByName('FGO_MOTBAI').AsString)) Then
        Begin
          fMensagem('ATENÇÃO!','Pedido de Venda gerado desta O.S. foi baixado e não será mais entregue.' + #13#10 +
                               qryFatgor.FieldByName('FGO_MOTBAI').AsString + #13#10 +
                               'Motivo: ' + fRetDescOcorrencia(qryFatgor.FieldByName('FGO_CODOCO').AsString) + #13#10 +
                               'Não será permitida alteração desta ordem de serviço.', ['&OK']);
          Result := False;
        End
        Else If (blnOk) And (fEmptyStr(qryFatgor.FieldByName('FGO_MOTBAI').AsString)) Then {Já Faturado!}
        Begin
          If InformarNFEntSaiAlterarObsOSRealizadaReprovada Then
            fMensagem('ATENÇÃO!','Pedido de Venda gerado desta O.S. Já foi faturado.' + #13#10 +
                                 'Documento: ' + qryFatgor.FieldByName('FGO_NUMFAT').AsString + '-' +
                                                 qryFatgor.FieldByName('FGO_TIPFAT').AsString + '-' +
                                                 qryFatgor.FieldByName('FGO_EMPFAT').AsString + #13#10 +
                                 'Data: ' + qryFatgor.FieldByName('FGO_DTAFAT').AsString      + #13#10 +
                                 'Somente algumas informações poderão ser alteradas.', ['&OK'])
          else
          begin
            fMensagem('ATENÇÃO!','Pedido de Venda gerado desta O.S. Já foi faturado.' + #13#10 +
                                 'Documento: ' + qryFatgor.FieldByName('FGO_NUMFAT').AsString + '-' +
                                                 qryFatgor.FieldByName('FGO_TIPFAT').AsString + '-' +
                                                 qryFatgor.FieldByName('FGO_EMPFAT').AsString + #13#10 +
                                 'Data: ' + qryFatgor.FieldByName('FGO_DTAFAT').AsString      + #13#10 +
                                 'Não será permitida alteração desta ordem de serviço.', ['&OK']);
            Result := False;
          end;
        End
        else if fValidaHouveFaturamentoParcial(LNumFat, objConEqu.strNumPed, objConEqu.strEmpPed) then
        begin
          if InformarNFEntSaiAlterarObsOSRealizadaReprovada and (Pos(objConEqu.strStatus, 'R_N_') > 0) then
            fMensagem('ATENÇÃO!','Pedido de Venda gerado desta O.S. possui faturamento parcial.' + #13#10 +
                          'Documento(s): ' + LNumFat + #13#10 +
                          'Somente algumas informações poderão ser alteradas.', ['&OK'])
          else
          begin
            fMensagem('ATENÇÃO!','Pedido de Venda gerado desta O.S. possui faturamento parcial.' + #13#10 +
                                 'Documento(s): ' + LNumFat + #13#10 +
                                 'Não será permitida alteração desta ordem de serviço.', ['&OK']);
            Result := False;
          end;
        end;
      End;
    end;
  finally
    FreeAndNil(qryFGOEQU);
  end;

  if not blnPedEncontrado then
  begin
    If (objConEqu.strStatus = 'R') Then
    Begin
      If (fCfgSis('EQUREA', varString) = '2') Then
        fMensagem('ATENÇÃO!','Ordem de Serviço realizada e encerrada. Somente algumas informações poderão ser alteradas.', ['&OK'])
      Else
      Begin
        fMensagem('ATENÇÃO!','Ordem de Serviço realizada e encerrada, nenhuma alteração poderá ser realizada!', ['&OK']);
        Result := False;
      End;
    End
    Else If (objConEqu.strStatus = 'N') Then
    Begin
      If InformarNFEntSaiAlterarObsOSRealizadaReprovada Then
        fMensagem('ATENÇÃO!','Ordem de Serviço está reprovada. Somente algumas informações poderão ser alteradas.', ['&OK'])
      Else
      Begin
        fMensagem('ATENÇÃO!','Ordem de Serviço está reprovada, nenhuma alteração poderá ser realizada!', ['&OK']);
        Result := False;
      End;
    End;
  end;
end;

function TfrmFatManConsertoEquip.fVerificarTabPre: String;
begin
  If (Not cbTabPrecoItem.Visible) Then
    Result := fCfgSis('CTBOS' + cbTabPreco.Text, varString)
  Else
    Result := 'VE' + cbTabPrecoItem.Text;

  If Result = 'CUS' then
    Result := 'VE' + cbTabPreco.Text;

  objConEqu.strTabPreIte := Copy(Result, Length(Result), 1);
end;

procedure TfrmFatManConsertoEquip.lblDigNotaEntConsMouseEnter(Sender: TObject);
begin
  inherited;

  TLabel(Sender).Font.Style := [fsBold, fsUnderline];
end;

procedure TfrmFatManConsertoEquip.lblDigNotaEntConsMouseLeave(Sender: TObject);
begin
  inherited;

  TLabel(Sender).Font.Style := [fsBold];
end;

procedure TfrmFatManConsertoEquip.lblExiDadosClick(Sender: TObject);
begin
  inherited;

  if pnlTopo.Visible then
  begin
    pnlTopo.Visible := False;
    lblExiDados.Caption  := 'Exibir "Dados Gerais da Ordem de Serviço" e "Dados do Equipamento"';
  end
  else
  begin
    pnlTopo.Visible := True;
    lblExiDados.Caption   := 'Ocultar "Dados Gerais da Ordem de Serviço" e "Dados do Equipamento"';
  end;
end;

procedure TfrmFatManConsertoEquip.edtCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
    objfrmPnl : TPanelCxClientes;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  Try
    Try
      objfrmPnl := TPanelCxClientes.Create(TfrmPnlDadosCliente);
      objfrmPnl.strNomForm := self.name;
      If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes,true,objfrmPnl) Then
      Begin
        If fValidaCampos(edtCodCli, True) Then
          SelectNext(ActiveControl, True, True);
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[pCodCliKeyPress]');
    End;
  Finally
    FreeAndNil(objfrmPnl);
  End;
end;

procedure TfrmFatManConsertoEquip.edtCodCndEnter(Sender: TObject);
begin
  inherited;

  If (Not fEmptyStr(edtCodCnd.Text)) And (strCcnAnt <> edtCodCnd.Text) Then
    strCcnAnt := edtCodCnd.Text;
end;

procedure TfrmFatManConsertoEquip.edtCodCndExit(Sender: TObject);
begin
  inherited;

  If ((edtCodCnd.Text <> strCcnAnt) Or (strFpgAnt <> edtForPag.Text)) Then
    pCarregaCondicao;

  If (mskCndPag.Enabled) Then
  Begin
    SelectNext(ActiveControl, True, True)
  End
  Else
    SelectNext(edtCodCnd, True, True);
end;

procedure TfrmFatManConsertoEquip.pCarregaAcessorioAlteracao;
begin
  if (not objConEqu.cdsAceEqu.Active) or (objConEqu.cdsAceEqu.IsEmpty) then
    Exit;

  edtCodAce.Text    := objConEqu.cdsAceEqu.FieldByName('CODACE').AsString;
  edtDesAce.Text    := objConEqu.cdsAceEqu.FieldByName('DESACE').AsString;
  edtQtdAce.Text    := FormatFloat(fMskDigitos(intDecQtde), objConEqu.cdsAceEqu.FieldByName('QTDACE').AsFloat);

  objConEqu.strCodAce := objConEqu.cdsAceEqu.FieldByName('CODACE').AsString;
  objConEqu.strDesAce := objConEqu.cdsAceEqu.FieldByName('DESACE').AsString;
  objConEqu.fltQtdAce := objConEqu.cdsAceEqu.FieldByName('QTDACE').AsFloat;
  edtCodAce.Enabled   := False;
end;

procedure TfrmFatManConsertoEquip.pCarregaCliente;
begin
  pPesquisaCadCli(qryCadCli, qryCadCli, edtCodCli.Text);

  If (Not fEmptyStr(objConEqu.strNumero)) Then Exit();

  With qryCadCli Do
  Begin
    objConEqu.strCodVen := FieldByName('CLI_CODVEN').AsString;

    If (edtCodRep.Visible) Then
      objConEqu.strCodRep := FieldByName('CLI_CODREP').AsString;


    If (Not fEmptyStr(objConEqu.strCodVen)) Then
    Begin
      If (Not blnUsaDig) Then
        edtSenVen.Text := fRetSenhaVendedor(objConEqu.strCodVen)
      Else
        edtSenVen.Text := objConEqu.strCodVen;

      pCarregaVendedor;
    End;

    If (Not fEmptyStr(objConEqu.strCodVe2)) Then
    Begin
      edtCodRep.Text := objConEqu.strCodVe2;
      pCarregaRepres;
    End;
  End;
end;

procedure TfrmFatManConsertoEquip.pCarregaComboTabPre(cbComboTab: TComboBoxFocus; strTabela: String);
var
  intCont: Integer;
begin
  for intCont := 1 to 7 do
  begin
    if (strTabela[intCont] = 'S') then
      cbComboTab.Items.Add(IntToStr(intCont));
  end;
end;

procedure TfrmFatManConsertoEquip.pCarregaCondicao(APermiteAlterarTabPre: Boolean = True);
  Var
    strMultTabPreco,
    strTabPre : String;
    intIndice: integer;
    strCodCid: string;
    frmFatSelecaoTabelaPreco: TfrmFatSelecaoTabelaPreco;
begin
  If not Assigned(qryConCnd) Then
    Exit;

  pPesquisaCadCnd(qryConCnd, qryConCnd, edtCodCnd.Text);
  If ( Not qryConCnd.IsEmpty ) Then
  Begin
    strCodCid := fRetCidCliente(edtCodCli.Text);

    With qryConCnd Do
    Begin

      If ( FieldByName('CND_TIPFOR').AsString = 'OUTROS' ) Then
      Begin

        mskCndPag.Enabled     := True;
        mskCndPag.Color       := clWindow;
        mskCndPag.NormalColor := clWindow;

        If (fEmptyStr(objConEqu.strConPag)) Or (edtCodCnd.Text <> objConEqu.strCodCnd) Then
          mskCndPag.Text := FieldByName('CND_CNDPAG').AsString
        Else
          mskCndPag.Text := objConEqu.strConPag;
      End
      Else
      Begin

        mskCndPag.Enabled     := False;
        mskCndPag.Color       := $00FFDFB8;
        mskCndPag.NormalColor := $00FFDFB8;
        mskCndPag.Text        := fRetCondicao('',
                                              0,
                                              FieldByName('CND_CODIGO').AsString,
                                              FieldByName('CND_TIPFOR').AsString,
                                              FieldByName('CND_CNDPAG').AsString,
                                              0,
                                              '',
                                              strCodCid);
      End;

      mskCndPag.Text := fRetCondicaoDiaFixoCliente('', 0, edtCodCli.Text, mskCndPag.Text, 0, '', strCodCid);

      If Not fEmptyStr(FieldByName('CND_CODFPG').AsString) Then
      Begin
        edtForPag.Text     := FieldByName('CND_CODFPG').AsString;
        edtForPag.ReadOnly := True;
        pCarregaForPag;
      End
      Else
        edtForPag.ReadOnly := False;

      strMultTabPreco := fDevolveTabelaPreco(FieldbyName('CND_PRETAB').AsString);

      If (fCfgSis('TBPCND', varBoolean)) And
         (Not fEmptyStr(Trim(StringReplace(FieldbyName('CND_PRETAB').AsString,'N','',[rfReplaceAll, rfIgnoreCase])))) And
         ((Pos(cbTabPreco.Text, strMultTabPreco) <= 0) Or (strCcnAnt <> edtCodCnd.Text)) And
         ((fCfgSis('OSTCND', varBoolean)) Or (blnTrCliRecPre And (Not fCfgSis('CLRCPR', varBoolean)))) Then
      begin
        if Length(strMultTabPreco) > 1 then
        begin
          try
            pCriarFormularios(TfrmFatSelecaoTabelaPreco,frmFatSelecaoTabelaPreco);
            frmFatSelecaoTabelaPreco.cbbTabPre.Clear;
            frmFatSelecaoTabelaPreco.cbbTabPre.Items.Add('');
            for intIndice := 1 to Length(strMultTabPreco) do
            begin
              frmFatSelecaoTabelaPreco.cbbTabPre.Items.Add(strMultTabPreco[intIndice]);
            end;
            frmFatSelecaoTabelaPreco.cbbTabPre.ItemIndex := 0;
            frmFatSelecaoTabelaPreco.ShowModal;
            if frmFatSelecaoTabelaPreco.ModalResult = mrOk then
            begin
              strMultTabPreco := frmFatSelecaoTabelaPreco.cbbTabPre.Text;
            end;
          finally
            pFreeAndNil(frmFatSelecaoTabelaPreco);
          end;
        end;

        strTabPre := strMultTabPreco;
        strMultiTabPreAtu := strMultTabPreco;
        strCndPgtoAtu := edtCodCnd.Text;

        If (cbTabPreco.Items.IndexOf(strTabPre) < 0) And (Not fEmptyStr(strTabPre)) Then
          cbTabPreco.Items.Add(strTabPre);

        if APermiteAlterarTabPre then
          cbTabPreco.Text := strTabPre;

        if (strCndPgtoAnt <> strCndPgtoAtu) or ((strCndPgtoAnt = strCndPgtoAtu) and (strMultiTabPreAnt <> strMultiTabPreAtu)) then
        begin
          strCndPgtoAnt := strCndPgtoAtu;
          strMultiTabPreAnt := strMultiTabPreAtu;
          objConEqu.pRecalculaPrecos(cbTabPreco.Text);
        end;
      End;

      edtDesCndPag.Text  := FieldByName('CND_DESCRI').AsString;
    End;
  End
  Else
    edtDesCndPag.Clear;
End;

procedure TfrmFatManConsertoEquip.pCarregaDadosNFEntSai;

  procedure pHabilitarCampos(AHabilitar: Boolean);
  begin
    edtNumDocEnt.Enabled := AHabilitar;
    edtEspDocEnt.Enabled := AHabilitar;
    edtSerDocEnt.Enabled := AHabilitar;
    edtEmpDocEnt.Enabled := AHabilitar;
    mskDtaDocEnt.Enabled := AHabilitar;
    cmbEquEnt.Enabled         := AHabilitar And (cmbEquEnt.Items.Count > 0);
    btnRemoverEntrada.Enabled := AHabilitar;

    edtNumDocSai.Enabled := AHabilitar;
    edtEspDocSai.Enabled := AHabilitar;
    edtSerDocSai.Enabled := AHabilitar;
    edtEmpDocSai.Enabled := AHabilitar;
    mskDtaDocSai.Enabled := AHabilitar;
    btnRemoverSaida.Enabled := AHabilitar;
  end;

begin
  pHabilitarCampos(False);

  If Assigned(objMeqMerEnt) Then
  Begin
    edtNumDocEnt.Text := objMeqMerEnt.strNumDoc;
    edtSerDocEnt.Text := objMeqMerEnt.strSerie_;
    edtEspDocEnt.Text := objMeqMerEnt.strEspDoc;
    edtEmpDocEnt.Text := objMeqMerEnt.strEmpGer;
    mskDtaDocEnt.Text := FormatDateTime('dd/mm/yyyy', objMeqMerEnt.dtaDtaGer);
    edtChaveNfeEnt.Text := objMeqMerEnt.strChaveAcesso;
    cmbEquEnt.ItemIndex := -1;

    pCarregarItensNotaEntradaXML();

    pHabilitarCampos(True);
  End
  Else
  Begin
    edtNumDocEnt.Text := '';
    edtEspDocEnt.Text := '';
    edtSerDocEnt.Text := '';
    edtEmpDocEnt.Text := '';
    mskDtaDocEnt.Text := '  /  /    ';
    edtChaveNfeEnt.Text := '';
    cmbEquEnt.ItemIndex := -1;
  End;

  If Assigned(objMeqMerSai) Then
  Begin
    edtNumDocSai.Text := objMeqMerSai.strNumDoc;
    edtSerDocSai.Text := objMeqMerSai.strSerie_;
    edtEspDocSai.Text := objMeqMerSai.strEspDoc;
    edtEmpDocSai.Text := objMeqMerSai.strEmpGer;
    mskDtaDocSai.Text := FormatDateTime('dd/mm/yyyy', objMeqMerSai.dtaDtaGer);

    pHabilitarCampos(True);
  End
  Else
  Begin
    edtNumDocSai.Text := '';
    edtSerDocSai.Text := '';
    edtEspDocSai.Text := '';
    edtEmpDocSai.Text := '';
    mskDtaDocSai.Text := '  /  /    ';
  End;
end;

procedure TfrmFatManConsertoEquip.pCarregaDadosOSAnterior;
begin
  If (fEmptyStr(edtCodCli.Text)) or (fEmptyStr(edtCodEqu.Text)) Then
    Exit;

  objConEqu.strNOSAnt := '';
  objConEqu.dtaDtEAnt := 0;
  objConEqu.dtaDtRAnt := 0;

  objConEqu.fCarregaDadosOSAnterior(edtNOSAnt.Text, edtCodEqu.Text);
  pAtualizaCamposOSAnterior;
end;

procedure TfrmFatManConsertoEquip.pCarregaDigitador;
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtSenDig.Text, True);

  With qryConOpe Do
  Begin
    edtNomDig.Text := FieldByName('OPE_NOMOPE').AsString;

    If (edtSenDig.Visible) Then
      objConEqu.strCodDig := FieldByName('OPE_CODOPE').AsString;
  End;
end;

procedure TfrmFatManConsertoEquip.pCarregaForPag;
begin
  If Not fEmptyStr(edtForPag.Text) Then
  Begin
    edtDesForPag.Text := fRetDesFpg(edtForPag.Text);
  End
  Else
  Begin
    edtDesForPag.Text := '';
  End;
end;

procedure TfrmFatManConsertoEquip.edtCodCndKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCnd: TConsultasArray;
    strCndCli: String;
begin
  If (fCfgSis('TRACND', varBoolean)) Then
    strCndCli := edtCodCli.Text
  Else
    strCndCli := EmptyStr;

  {*******************************}
  {* NOVA CONSULTA DE COND. PGTO *}
  {****************************RV*}
  If edtCodCnd.Enabled And (Not edtCodCnd.ReadOnly) Then
  Begin
    If fPesqCondicoesPgto(Self, edtCodCnd, edtDesCndPag, Nil, Key, arrCnd, True, False,
                          IIF(fCfgSis('PFLCLI', varBoolean), conCndPerfil, conCndSimples),
                          0, 0, strCndCli, True) Then
    Begin
      pCarregaCondicao;

      If fValidaCampos(edtCodCnd, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;

end;

procedure TfrmFatManConsertoEquip.edtCodDfeKeyPress(Sender: TObject; var Key: Char);
  Var
    arrDfe   : TConsultasArray;
    objfrmPnl: TPanelCxDefeito;
    sltDfesAntesPesquisa: TStringList;

  function fDfeAddPorTabPelaPrimeiraVez: Boolean;
     Var
       strCodDfe: String;
  begin
    strCodDfe := QuotedStr(objConEqu.cdsDfeEqu.FieldByName('CODDFE').AsString);
    Result := (Not fEstaNaLista(sltDfesAntesPesquisa, strCodDfe)) And
              (fEstaNaLista(sltDfe, strCodDfe));
  end;

  Function fStrTituloConsulta: String;
  Begin
    Result := 'Consulta de Defeitos - Conserto de Equipamentos.';
  end;
begin
  inherited;

  {*****************************}
  {* NOVA CONSULTA DE DEFEITOS *}
  {**************************MM*}
  Try
    objfrmPnl := TPanelCxDefeito.Create(TfrmPnlDadosDefeito);
    sltDfesAntesPesquisa := TStringList.Create;

    sltDfesAntesPesquisa.Text := sltDfe.Text;
    objFrmPnl.sltLista        := sltDfe;
    objFrmPnl.fncTeclaTab     := fInserirDefeito;
    objFrmPnl.strNomForm      := Self.Name;

    If fPesqDefeito(Self, edtCodDfe, edtDesDfe, Nil, Key, arrDfe, True, objFrmPnl) Then
    Begin
      If fDfeAddPorTabPelaPrimeiraVez Then
      Begin
        btnCancelaDfe.Click;
      End
      Else
      Begin
        If fValidaCampos(edtCodDfe, True) Then
          SelectNext(ActiveControl, True, True);
      End;
    End;
  Finally
    FreeAndNil(objFrmPnl);
    FreeAndNil(sltDfesAntesPesquisa);
  End;
end;

function TfrmFatManConsertoEquip.fRetDataNFCompra(strNumDoc,
  strCodCli, strCodEmp: String): TDatetime;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  GER_DTAENT ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_ESPDOC IN ("NF","IF") AND ';
    strSQL := strSQL + '  GER_TIP_FC = "C"          AND ';
    strSQL := strSQL + '  GER_ORIDOC = "V"          AND ';
    strSQL := strSQL + '  GER_NUMDOC = :NUMDOC      AND ';
    strSQL := strSQL + '  GER_CODEMP = :CODEMP      AND ';
    strSQL := strSQL + '  GER_CODCLI = :CODCLI          ';

    strSQL := strSQL + 'UNION ALL ';

    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  GER_DTAENT ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  NOTGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_ESPDOC IN ("NF","IF") AND ';
    strSQL := strSQL + '  GER_TIP_FC = "C"          AND ';
    strSQL := strSQL + '  GER_ORIDOC = "V"          AND ';
    strSQL := strSQL + '  GER_NUMDOC = :NUMDOC      AND ';
    strSQL := strSQL + '  GER_CODEMP = :CODEMP      AND ';
    strSQL := strSQL + '  GER_CODCLI = :CODCLI          ';

    strSQL := strSQL + 'ORDER BY GER_DTAENT ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      If Not IsEmpty Then
        Result := fieldbyname('GER_DTAENT').AsDatetime
      Else
        Result := 0;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

end;

function TfrmFatManConsertoEquip.fRetNomVendedor(strSenOpe: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin
  {* CARACTERE FORA DE STR_CHAR_SENHA E CRIPTOGRAFADO PELO fCrypt COMO 'A' *}
  If Not fSenhaPermitida(strSenOpe) Then
  Begin
    Result := '';
    objConEqu.strCodVen := '';
    Exit;
  End;

  qryGen := fCriaQuery;

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADOPE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  BINARY OPE_SENOPE = :FILTRO ';

    strSenOpe := fCrypt(strSenOpe);

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('FILTRO').AsString := strSenOpe;
      Open;
    End;

    Result := qryGen.fieldbyname('OPE_NOMOPE').AsString;
    objConEqu.strCodVen := qryGen.fieldbyname('OPE_CODOPE').AsString;

  Finally
    FreeAndNil(qryGen);
  End;

end;

function TfrmFatManConsertoEquip.fRetNumFatPD(strNumDoc, strEspDoc, strCodEmp: String): String;
var
  qryGen: TUniQuery;
begin
  Result := '';
  qryGen := fCriaQuery(Self);

  try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT ');
    qryGen.SQL.Add('  IF(IFNULL(FGO_NUMFAT,"") = "", "", CONCAT(FGO_NUMFAT,"-",FGO_TIPFAT,"-",FGO_CODEMP)) AS NUMFAT ');
    qryGen.SQL.Add('FROM ');
    qryGen.SQL.Add('  FATGOR ');
    qryGen.SQL.Add('WHERE ');
    qryGen.SQL.Add('  FGO_NUMDOC = :NUMDOC AND ');
    qryGen.SQL.Add('  FGO_ESPDOC = :ESPDOC AND ');
    qryGen.SQL.Add('  FGO_CODEMP = :CODEMP ');
    qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
    qryGen.ParamByName('ESPDOC').AsString := strEspDoc;
    qryGen.ParamByName('CODEMP').AsString := strCodEmp;
    qryGen.Open;

    if not qryGen.IsEmpty then
      Result := qryGen.FieldByName('NUMFAT').AsString;

    qryGen.Close;
  finally
    FreeAndNil(qryGen);
  end;
end;

function TfrmFatManConsertoEquip.fRetOpcaoEmGarantia(strOpcao:String = ''): String;
begin
  If fEmptyStr(strOpcao) Then
  Begin
    Case cbGarant.ItemIndex Of
     0: Result := 'N'; // Não
     1: Result := 'L'; // Garantia Loja
     2: Result := 'F'; // Garantias Fábrica
     3: Result := 'R'; // Retorno de Garantia
    End;
  End
  Else
  Begin
    Result := '-1';

    Case strOpcao[1] Of
     'N': Result := '0'; // Não
     'L': Result := '1'; // Garantia Loja
     'F': Result := '2'; // Garantias Fábrica
     'R': Result := '3'; // Retorno de Garantia
    End;
  End;
end;

function TfrmFatManConsertoEquip.fRetornaChaveLckManEqu(strNumOse, strCodEmp: String): String;
begin
   Result := 'MANEQU_' + strNumOse + '_' + strCodEmp;
end;

function TfrmFatManConsertoEquip.fRetornaUnitarioTrava(fltUniDig,
                                                       fltUniOri,
                                                       fltQtdIte: Double;
                                                       strCodIte,
                                                       strTabPre: String): Double;
  Var
    qryIte     : TUniQuery;

    fltTraFat,
    fltPreTra : Double;

    function fDescontoMaximoItem: Double;
    begin
      If fCfgSis('ITETBP', VarBoolean) Then
        Result := fCampoTabela('ITE_DESMAX',
                               'ITETBP',
                              ['ITE_CODITE', 'ITE_CODEMP', 'ITE_TABPRE'],
                              [strCodIte, VS_strCodEmp, strTabPre])

      Else If fCfgSis('DMVFQV', VarBoolean) Then
        Result := GetDesMaxFaixaQtde(strCodIte,
                                     VS_strCodEmp,
                                     fltQtdIte)
      Else
        Result := fCampoTabela('ITE_DESMAX',
                               'ITEGER',
                              ['ITE_CODITE', 'ITE_CODEMP'],
                              [strCodIte, VS_strCodEmp]);

    End;

    function fRetornaVrDesconto(fltValUni, fltDesCon: Double): Double;
    Begin
      Result := fltDesCon;

      If (fCfgSis('TIPDES') = '%') Then
        Result := fFormataFloat((fltValUni * fltDesCon) / 100, 04);
    End;

begin
  fltTraFat    := 0.00;
  fltPreTra    := 0.00;
  qryIte       := fCriaQuery;

  If (fCfgSis('TRDEOS') = '1') Then
  Begin

    If fEmptyStr(strTabPre) Then
      strTabPre := '1'; //PADRAO

    If (strToInt(strTabPre) In [1..Length(VS_STRTABPRC)]) Then
      fltTraFat := fCfgSis('TFTOS' + strTabPre, varDouble);

    fltPreTra := fltUniOri * fltTraFat;

  End
  Else If (fCfgSis('TRDEOS') = '2') Then
  Begin

    fltPreTra := fFormataFloat(fltUniOri, intDecimal) -
                 fRetornaVrDesconto(fFormataFloat(fltUniOri, intDecimal), fDescontoMaximoItem);

  End;

  Result := fFormataFloat(fltPreTra, intDecimal);

  FreeAndNil(qryIte);
end;

procedure TfrmFatManConsertoEquip.edtCodIteKeyPress(Sender: TObject; var Key: Char);
var
  strFabLoc: String;
begin
  inherited;

  {**********************************************************************}
  {* FORÇA O PREENCHIMENTO DO CLIENTE PARA INDICAÇÃO DA TABELA DE PREÇO *}
  {*******************************************************************VA*}
  If fValidaCampos(edtCodCli, True) Then
  Begin
    If fEntraCons(Key) Then
    Begin
      Key := #0;
      blnBuscarCodFab := False;

      strFabLoc := '';

      If (rdbCodFab.Visible And rdbCodFab.Checked) Then
        strFabLoc := edtCodIte.Text;

      pConsultaItem('', '', strFabLoc);

      blnBuscarCodFab := rdbCodFab.Visible And rdbCodFab.Checked;
    End;
  End
  Else
  Begin
    Key := #0;
  End;
end;

procedure TfrmFatManConsertoEquip.edtCodLocEnter(Sender: TObject);
begin
  inherited;

  if (not blnRotinaTecnico) then
    pnlInfo.Caption := 'INSERT para fazer um novo cadastro';
end;

procedure TfrmFatManConsertoEquip.edtCodLocExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmFatManConsertoEquip.edtCodLocKeyPress(Sender: TObject;var Key: Char);
var
  LLoc: TConsultasArray;
begin
  inherited;
  {************************************}
  {* CONSULTA DE LOCALIZAÇÕES FÍSICAS *}
  {*********************************DH*}
  if fPesqLocFisConsertoEquip(Self, edtCodLoc, edtDesLoc, nil, Key, LLoc) then
  begin
    if fValidaCampos(edtCodLoc, True) then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmFatManConsertoEquip.edtCodRepKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  inherited;
  if fEntraCons(Key) then
  begin
    If (Not edtCodRep.ReadOnly) And
       (fPesqOperador(Self, edtCodRep, edtDesRep, qryConOpe, Key, arrSel)) Then
    Begin
      If fValidaCampos(edtCodRep, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end;
end;

procedure TfrmFatManConsertoEquip.FormActivate(Sender: TObject);
begin
  inherited;
  pAjustaAlturaPanelBotoes;
  pSetFocus(edtNumero);
end;

procedure TfrmFatManConsertoEquip.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (Action <> CaNone) And (Assigned(stlManEquAltLck)) Then
  Begin
    pDestravaELimpaStlManEquLck();
    FreeAndNil(stlManEquAltLck);
  End;
end;

procedure TfrmFatManConsertoEquip.FormCreate(Sender: TObject);
  Var
    strSQL: String;
begin
  inherited;
  blnAprovando := False;
  intSemaforoPesquisa := -1;
  FblnGravandoOS := False;

  AlterarClientePagtoObsDescOSRealizada := fCfgSis('ALRPRZ', varBoolean);
  InformarNFEntSaiAlterarObsOSRealizadaReprovada := fCfgSis('OSRENF', varBoolean);

  objLiberacao := TLiberacao.Create;
  blnVerificaLimiteCredito := False;

  strVERLME := fCfgSis('VERLME');

  edtCodEmp.Visible  := fCfgSis('MAOSEM', varBoolean);
  edtDesEmp.Visible  := fCfgSis('MAOSEM', varBoolean);
  lblEmpresa.Visible := fCfgSis('MAOSEM', varBoolean);

  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
  qryCadCli := fCriarQuery('SELECT CADCLI.*, CLICND.CND_CODCND, CLICND.CND_CNDPAG FROM CADCLI LEFT JOIN CLICND ON CLI_CODCLI = CND_CODCLI AND CND_SUGEST = "S" WHERE FALSE', Self);

  chkBrindePro.Visible := fCfgSis('USABRI', varBoolean);
  chkBrindeSer.Visible := fCfgSis('USABRI', varBoolean);
  btnAlteraItens.Visible     := fCfgSis('USABRI', varBoolean);
  btnBrindeTotalServ.Visible := fCfgSis('USABRI', varBoolean);

  fFindColumnByName(dbgGrid   , 'BRINDE').Visible := chkBrindePro.Visible;
  fFindColumnByName(dbgGrid   , 'TIPBRI').Visible := chkBrindePro.Visible;
  fFindColumnByName(dbgServico, 'BRINDE').Visible := chkBrindeSer.Visible;
  fFindColumnByName(dbgServico, 'TIPBRI').Visible := chkBrindeSer.Visible;

  pnlAg_Pec.Visible  := False;
  pnlMostraPrecoProd.visible := false;
  pnlMostraPrecoServ.visible := false;

  pgcServicos.ActivePageIndex := 0;
  tbsServicosDiscriminacao.TabVisible := fUsaDiscriminacaoServico;

  If Not edtCodEmp.Visible Then
  Begin
    lblNovaOrdem.Left := lblEmpresa.Left;

    if edtProtoc.Visible then
    begin
      lblProtoc.Left := 519;
      edtProtoc.Left := 568;
    end;
  End
  Else
  Begin
    edtCodEmp.Text := VS_strCodEmp;
    edtDesEmp.Text := fRetNomeEmpresaSelec(VS_strCodEmp);
  End;

  FPais := fSetaPais;

  blnFecharForm := False;
  objConEqu := TConEqu.Create(Nil);
  qryFatgor := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + ' SELECT';
  strSQL := strSQL + '   CADITE.*, UNI_SIGUNI ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADITE ';
  strSQL := strSQL + '   LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ';
  strSQL := strSQL + ' WHERE FALSE ';

  qryCadIte := fCriarQuery(strSQL, Self);
  pSetaQueryCadIte(qryCadIte);

  qryCadEqu := fCriarQuery('SELECT * FROM CADEQU WHERE FALSE', Self);

  qryConUni := fCriaQuery(Self);
  qryEquGer := fCriaQuery(Self);

  With qryEquGer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT * FROM EQUGER WHERE FALSE ');
  End;

  If fEmptyStr(fCfgSis('CLARGA')) Then
  Begin
    fMensagem('ATENÇÃO!', 'A classificação de remessa para Garantia / Conserto [ CFG_CLARGA ] deve ser configurada corretamente.', ['&Ok']);
    blnFecharForm := True;
  End;

  btnAlteracao.Visible := False;
  blnAprovada          := False;

  intDecimal := fCfgSis('DECUNI', varInteger);
  intDecQtde := fCfgSis('DECQTD', varInteger);
  blnUsaDig  := fCfgSis('USADIG', varBoolean);

  edtUnitar.EditFormat := fMskDigitos(intDecimal);
  edtQtdIte.EditFormat := fMskDigitos(intDecQtde);
  edtQtdAce.EditFormat := fMskDigitos(intDecQtde);
  edtQtdAce.Text := FormatFloat(fMskDigitos(intDecQtde), 1);
  blnAltAcessorio := False;
  blnNovaOrdemServico := True;

  objEndEnt  := TEnderecoEntrega.Create(Self);

  If (fCfgSis('USCNFP', varBoolean)) Then
  Begin
    qryConCnd := fCriaQuery(Self);
    pnlCndPag.Visible := (fCfgSis('EQUCND', varString) = 'I');
  End
  Else
    pnlCndPag.Visible := False;

  blnOsGeradaPorPD := False;
  pgcTabs.ActivePage := tbsAcessorios;

  lblCodFab.Caption := EmptyStr;
  lblSaldos.Caption := EmptyStr;
  lblSal_OS.Caption := EmptyStr;
  lblEntreg.Caption := EmptyStr;
  lblCodCnd.Caption := EmptyStr;
  lblConPag.Caption := EmptyStr;
  lblForPag.Caption := EmptyStr;
  lblTotPro.Caption := EmptyStr;
  lblTotSer.Caption := EmptyStr;
  lblTotGer.Caption := EmptyStr;
  lblTotDes.Caption := EmptyStr;
  lblTotST.Caption  := EmptyStr;
  lblTotRef.Caption := EmptyStr;
  lblTotIPI.Caption := EmptyStr;
  lblTotFre.Caption := EmptyStr;
  lbl_LocFis.Caption := EmptyStr;
  lbl_LocSup.Caption := EmptyStr;

  edtValSe1.ReadOnly := Not fCfgSis('ALTSER',varBoolean);
  If edtValSe1.ReadOnly Then
    edtValSe1.Color := edtDesTecSe1.Color
  Else
    edtValSe1.Color := edtCodSe1.Color;

  stlCodIteImportado := TStringList.Create;
  stlCodSerImportado := TStringList.Create;

  If fCfgSis('EQUPER', varString) = '2' Then

    fatVenda := TFatVenda.CreateInstance('CP');

  edtNFComp.TamCampo  := fTamDocCadRec;
  edtNFComp.MaxLength := fTamDocCadRec;

  edtNFReme.TamCampo  := fTamDocCadRec;
  edtNFReme.MaxLength := fTamDocCadRec;

  pnlRepDig.Visible := (fCfgSis('REPVEN', varBoolean) Or blnUsaDig);

  edtSenVen.ReadOnly := (Not fCfgSis('ALTVEN', varBoolean));

  lblCodRep.Visible := fCfgSis('REPVEN', varBoolean);
  edtCodRep.Visible := fCfgSis('REPVEN', varBoolean);
  edtDesRep.Visible := fCfgSis('REPVEN', varBoolean);

  lblDigita.Visible := blnUsaDig;
  edtSenDig.Visible := blnUsaDig;
  edtNomDig.Visible := blnUsaDig;

  If (Not pnlRepDig.Visible) Then
  Begin
    if pnlCndPag.Visible then
    begin
      pnlGrpBox.Height  := pnlGrpBox.Height - pnlRepDig.Height;
      pnlTopo.Height    := pnlTopo.Height   - pnlRepDig.Height;
    end;
  End
  Else
  Begin
    If ( (Not edtCodRep.Visible) And (edtSenDig.Visible) ) Then
    Begin
      lblDigita.Left  := lblCodRep.Left + (lblCodRep.Width - lblDigita.Width);
      edtSenDig.Left  := edtCodRep.Left;
      edtNomDig.Left  := edtDesRep.Left;
      edtNomDig.Width := 550;
    End;

    If (edtCodRep.Visible) Then
      edtCodRep.ReadOnly := (Not fCfgSis('ALTVE2', varBoolean));

    If (edtSenDig.Visible) Then
    Begin
      edtSenVen.PasswordChar := #0;
      edtSenVen.MaxLength    := 3;
      edtSenVen.TamCampo     := 3;
      edtSenVen.CompZeros    := True;
    End;
  End;

  objMeqMerEnt := Nil;
  objMeqMerSai := Nil;

  sltItems        := TStringList.Create;
  sltItems.Sorted := True;

  sltDfe          := TStringList.Create;
  sltDfe.Sorted   := True;

  sltServ         := TStringList.Create;
  sltserv.Sorted  := True;

  sltAce          := TStringList.Create;
  sltAce.Sorted   := True;

  blnTrCliRecPre := False;

  stlManEquAltLck := TStringList.Create;

  blnCadLoc := fCfgSis('CADLOC', varBoolean);

  {Reativar OS}
  If fVerificaAcessoSistema('REATIV', strLoginUsuarioLogado) Then
    btnReativar.Enabled := True
  Else
    btnReativar.Enabled := False;

  strMultiTabPreAnt := EmptyStr;
  strMultiTabPreAtu := EmptyStr;
  strCndPgtoAnt     := EmptyStr;
  strCndPgtoAtu     := EmptyStr;
  mskCndPag.EditMask := MASK_CONPAG;

  lblProtoc.Visible := fCfgSis('PROSER', varBoolean);
  edtProtoc.Visible := lblProtoc.Visible;
  blnRotinaTecnico := False;

  if (not lblProtoc.Visible) and (edtCodEmp.Visible) then
  begin
    edtDesEmp.Width := 447;
    lblNovaOrdem.Left := 540;
  end;

  RedimensionaRevendaRetornarDeixadoPor;

  btnImpItensServicos.Visible := fCfgSis('CNDFAI', varBoolean);

  edtNSerie.OnExit := pVerificaOSAntExit;
  edtNumPat.OnExit := pVerificaOSAntExit;
  edtDadFab.OnExit := pVerificaOSAntExit;

  lblEstPrd.Visible := fCfgSis('ESTPRD', varBoolean);
  cbEstPrd.Visible := lblEstPrd.Visible;
  blnAlterarCondicao := False;
  blnOSCancelada := False;

  edtQtdSe1.Visible := fCfgSis('QTDSER', varBoolean);
  lblQtdSer.Visible := edtQtdSe1.Visible;

  if (not edtQtdSe1.Visible) then
  begin
    lblValSer.Left    := lblValSer.Left - 108;
    edtValSe1.Left    := edtValSe1.Left - 108;
    chkBrindeSer.Left := chkBrindeSer.Left - 108;
    pnlTipBriSer.Left := pnlTipBriSer.Left - 108;
    chkCobAPaSer.Left := chkCobAPaSer.Left - 108;
    fFindColumnByName(dbgServico, 'QTDSER').Visible := False;
  end;

  lblSaldos.Visible := (Copy(fCfgSis('CEMOSS', varString), 1, 1) = 'S');
  lblDesSaldos.Visible := lblSaldos.Visible;

  lblSal_OS.Visible := (Copy(fCfgSis('CEMOSS', varString), 2, 1) = 'S');
  lblDesSal_OS.Visible := lblSal_OS.Visible;

  fFindColumnByName(dbgGrid, 'AGUARD').Visible := (Copy(fCfgSis('CELEGS', varString), 1, 1) = 'S');
  fFindColumnByName(dbgGrid, 'SALDIS').Visible := (Copy(fCfgSis('CELEGS', varString), 2, 1) = 'S');

  blnMarLuc := False;

  edtLocFis.Visible := (not fCfgSis('ULCFCE', varBoolean));
  edtCodLoc.Visible := (not edtLocFis.Visible);
  edtDesLoc.Visible := edtCodLoc.Visible;

  pExibirDadosFazenda(False);

  if not fCfgSis('MLPSOS', varBoolean) then
  begin
    pnlEmpIte.Visible := False;
    pnlEmpSer.Visible := False;

    edtDesIte.Width := 1008;
    Label26.Left := 1159;
    edtUnidad.Left := 1212;
    lblTabPrecoItem.Left := 1256;
    cbTabPrecoItem.Left := 1307;

    fFindColumnByName(dbgGrid, 'EMPITE').Visible := False;
  end
  else
  begin
    edtEmpIte.Text := VS_strCodEmp;
    edtEmpSer.Text := VS_strCodEmp;

    if fCfgSis('NOMEMP') = '2' then
    begin
      edtDesEmpIte.Text := fRetFantasiaEmpresa(edtEmpIte.Text);
      edtDesEmpSer.Text := fRetFantasiaEmpresa(edtEmpSer.Text);
    end
    else
    begin
      edtDesEmpIte.Text := fRetNomeEmpresaSelec(edtEmpIte.Text);
      edtDesEmpSer.Text := fRetNomeEmpresaSelec(edtEmpSer.Text);
    end;
  end;

  blnNegociacao := False;

  if (fCfgSis('CTRPEN', varInteger) = 2) then
  begin
    lblPreEnt.Caption := 'Dias Úteis para Entrega:';
    mskEntreg.Visible := False;
    edtDiaEnt.Visible := True;
  end;

  pCarregaLocalRetira(cmbLocRet.Items);
end;

procedure TfrmFatManConsertoEquip.FormDestroy(Sender: TObject);
begin

  If Assigned(objEmitirPedido) Then
    FreeAndNil(objEmitirPedido);

  If Assigned(objConEqu) Then
  Begin
    objConEqu.cdsIteEqu.AfterScroll := Nil;

    dtsIteEqu.DataSet       := Nil;
    dbgGrid.DataSource      := Nil;

    dtsServico.DataSet      := Nil;
    dbgServico.DataSource   := Nil;

    dtsDefeito.DataSet      := Nil;
    dbgGridDfe.DataSource   := Nil;

    dtsAcessorios.DataSet   := Nil;
    dbgGridAce.DataSource   := Nil;

    dtsApontamentos.DataSet := Nil;
    dbgGridApo.DataSource   := Nil;

    FreeAndNil(objConEqu);
  End;

  If Assigned(qryFatgor) Then
    FreeAndNil(qryFatgor);

  If Assigned(objEndEnt) Then
    FreeAndNil(objEndEnt);

  If Assigned(qryConCnd) Then
    FreeAndNil(qryConCnd);

  If Assigned(stlCodIteImportado) Then
    FreeAndNil(stlCodIteImportado);

  If Assigned(stlCodSerImportado) Then
    FreeAndNil(stlCodSerImportado);

  FreeAndNil(qryConOpe);
  FreeAndNil(qryCadCli);

  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  If fCfgSis('EQUPER', varString) = '2' Then
  begin
    If Assigned(fatVenda) Then
      FreeAndNil(fatVenda);
  end;

  inherited;

  sltItems.Clear;
  FreeAndNil(sltItems);

  sltDfe.Clear;
  FreeAndNil(sltDfe);

  sltServ.Clear;
  FreeAndNil(sltServ);

  sltAce.Clear;
  FreeAndNil(sltAce);
end;

procedure TfrmFatManConsertoEquip.pLimpaDadosItem;
var
  LContador: Integer;
  edtTemp: TEdit;
  lblTemp: TLabel;
begin
  for LContador := 0 to Pred(pnlItensTop.ControlCount) do
  begin
    if (pnlItensTop.Controls[LContador] is TEdit) then
    begin
      edtTemp := (pnlItensTop.Controls[LContador] as TEdit);
      edtTemp.Clear;
    end
    else if (pnlItensTop.Controls[LContador] is TLabel) then
    begin
      lblTemp := (pnlItensTop.Controls[LContador] as TLabel);

      if (lblTemp.Tag = 99) then
        lblTemp.Caption := '';
    end;
  end;

  for LContador := 0 to Pred(pnlItensValores.ControlCount) do
  begin
    if (pnlItensValores.Controls[LContador] is TEdit) then
    begin
      edtTemp := (pnlItensValores.Controls[LContador] as TEdit);
      edtTemp.Clear;
    end
    else if (pnlItensValores.Controls[LContador] is TLabel) then
    begin
      lblTemp := (pnlItensValores.Controls[LContador] as TLabel);

      if (lblTemp.Tag = 99) then
        lblTemp.Caption := '';
    end;
  end;

  chkBrindePro.Checked := False;
  chkCobAPa.Checked    := False;

  {Valor Default Entrega/Retira}
  If cmbEntRet.Enabled Then
  Begin
    If fCfgSis('SUJROM', VarString) = 'S' Then
      cmbEntRet.ItemIndex := IDX_ENTREGA
    Else
      cmbEntRet.ItemIndex := IDX_RETIRA;
  End;

  cmbLocRet.ItemIndex := -1;
  pHabilitaLocRet;

  objConEqu.pLimpaValoresItens;
end;

procedure TfrmFatManConsertoEquip.pLimpaDadosServico;
begin
  chkBrindeSer.Checked := False;
  chkCobAPaSer.Checked := False;
  edtValSe1.Text := '0,00';
  edtQtdSe1.Text := '0,00';
  edtDesSe1.Clear;
  edtCodSe1.Clear;
  edtCodTecSe1.Clear;
  edtDesTecSe1.Clear;
  pSetFocus(edtCodSe1);
end;

procedure TfrmFatManConsertoEquip.pLimpaImagem;
begin
  imgEqu.Picture := Nil;
  imgEqu.Visible := False;
  lblErrImg.Visible := False;
end;

procedure TfrmFatManConsertoEquip.pLimpaTela;
begin
  Self.Caption := 'Manutenção de Ordem de Serviços - Conserto de Equipamentos';
  blnIniOrc := False;
  blnFinOrc := False;
  blnIniMan := False;
  blnFinMan := False;
  blnNovaOrdemServico := True;

  pnlTopo.Enabled   := True;
  pnlCndPag.Enabled := True;
  pnlBotton.Enabled := True;
  pnlRepDig.Enabled := True;
  edtDisSer.ReadOnly := False;
  pnlVendedor.Enabled := True;
  pnlTotal.Enabled  := True;
  dbgGrid.Enabled   := True;
  dbgServico.Enabled:= True;
  dbgGridDfe.Enabled:= True;
  dbgGridAce.Enabled:= True;
  dbgGridApo.Enabled:= True;
  pnlBotoes.Enabled := True;
  pnlNumeroOS.Enabled := True;
  pnlRealizada.Enabled := True;
  edtCodRep.Enabled := True;

  objEndEnt.recEndere.strCodCli := '';
  objEndEnt.recEndere.strIncrem := '';
  objEndEnt.recEndere.strEndEnt := '';
  objEndEnt.recEndere.strBaiEnt := '';
  objEndEnt.recEndere.strCepEnt := '';
  objEndEnt.recEndere.strCodCid := '';
  objEndEnt.recEndere.strCidEnt := '';
  objEndEnt.recEndere.strNomCid := '';
  objEndEnt.recEndere.strTelEnt := '';

  objConEqu.cdsIteEqu.EmptyDataSet;
  objConEqu.cdsSerEqu.EmptyDataSet;
  objConEqu.cdsDfeEqu.EmptyDataSet;
  objConEqu.cdsAceEqu.EmptyDataSet;
  objConEqu.cdsApoEqu.EmptyDataSet;

  objConEqu.dtaIniOrc := 0;
  objConEqu.hraIniOrc := 0;
  objConEqu.dtaFinOrc := 0;
  objConEqu.opeIniOrc := '';

  objConEqu.strAutInc := '';
  objConEqu.strObserv := '';
  objConEqu.strCodCli := '';
  objConEqu.strCliNom := '';
  objConEqu.strCliEnd := '';
  objConEqu.strCliBai := '';
  objConEqu.strCliCep := '';
  objConEqu.strCodCid := '';
  objConEqu.strCliCid := '';
  objConEqu.strCliEst := '';
  objConEqu.strCliTel := '';
  objConEqu.intCgcCpf := 0;
  objConEqu.strCliCgc := '';
  objConEqu.strCliIes := '';
  objConEqu.strCli_Rg := '';
  objConEqu.strNumero := '';
  objConEqu.strCodVen := '';
  objConEqu.strDescri := '';
  objConEqu.strDisSer := '';
  objConEqu.strNSerie := '';
  objConEqu.strAcesso := '';
  objConEqu.strGarant := '';
  objConEqu.strNFComp := '';
  objConEqu.dtaDtNFCo := 0;
  objConEqu.strRevend := '';
  objConEqu.strConRet := '';
  objConEqu.strDeiPor := '';
  objConEqu.dtaEntreg := 0;
  objConEqu.strMarEqu := '';
  objConEqu.strStatus := '';
  objConEqu.strSubSta := '';
  objConEqu.strOperac := 'I';
  objConEqu.strTemPed := 'N';
  objConEqu.fltVlrCon := 0;
  objConEqu.fltVlrPro := 0;
  objConEqu.fltVlrSer := 0;
  objConEqu.fltTotRet := 0;
  objConEqu.fltTotIPI := 0;
  objConEqu.blnAg_Mon := False;
  objConEqu.strEntGer := '';
  objConEqu.strCodCnd := '';
  objConEqu.strCodFpg := '';
  objConEqu.strConPag := '';
  objConEqu.strCodVe2 := '';
  objConEqu.strCodDig := '';
  objConEqu.strCodRep := '';
  objConEqu.strTabPreIte := '';
  objConEqu.strRetPor := '';
  objConEqu.strOsPdCl := '';
  objConEqu.fltDesEsp := 0;
  objConEqu.fltPorDes := 0;
  objConEqu.fltValDes := 0;
  objConEqu.fltDesEspIte := 0;
  objConEqu.strNumPed := '';
  objConEqu.strCodTra := '';
  objConEqu.fltValFre := 0;
  objConEqu.strEspTra := '';
  objConEqu.strLocFisEqu := '';
  objConEqu.strTipFre := '';
  objConEqu.intQtdTra := 0;
  objConEqu.dteDtLbEx := 0;
  objConEqu.dteHrLbEx := 0;
  objConEqu.dteDtBxSe := 0;
  objConEqu.dteHrBxSe := 0;
  objConEqu.strOpBxSe := '';
  objConEqu.strStaAnt := '';
  objConEqu.strProtoc := '';
  objConEqu.strCntCli := '';
  objConEqu.strCntTel := '';
  objConEqu.strNumPat := '';
  objConEqu.strDadFab := '';
  objConEqu.strCodEpr := '';
  objConEqu.fltDesEspSer := 0;
  objConEqu.blnPermiteAltDig := False;
  objConEqu.blnPermiteAltTec := False;
  objConEqu.fltTaxJur := 0;
  objConEqu.fltPerDes := 0;
  objConEqu.strNOSAnt := '';
  objConEqu.dtaDtEAnt := 0;
  objConEqu.dtaDtRAnt := 0;
  objConEqu.strNOSFab := '';
  objConEqu.intTmpGar := 0;
  objConEqu.blnPrtAtd := False;
  objConEqu.intSeqIte := 1;
  objConEqu.blnVenPre := False;
  objConEqu.strCodAce := EmptyStr;
  objConEqu.strDesAce := EmptyStr;
  objConEqu.strDesAce := EmptyStr;
  objConEqu.fltQtdAce := 1;
  objConEqu.strDigRet := EmptyStr;
  objConEqu.strFlxFas := EmptyStr;
  objConEqu.strFlxSit := EmptyStr;
  objConEqu.strFlxCom := EmptyStr;
  objConEqu.strEmpFatSemSaldo := EmptyStr;
  objConEqu.strOri_PD := 'N';
  objConEqu.strCodFaz := '';

  chkVenPre.Visible   := False;
  chkVenPre.Checked   := False;

  chkAg_Mon.Visible   := False;
  pnlAg_Pec.Visible   := False;
  pnlMostraPrecoProd.visible := false;
  pnlMostraPrecoServ.visible := false;

  edtNumero.Clear;
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtFone01.Clear;
  edtCelula.Clear;
  edtEmail_.Clear;
  edtSenVen.Clear;
  edtCodRep.Clear;
  edtSenDig.Clear;
  edtDesRep.Clear;
  edtNomDig.Clear;
  edtNomVen.Clear;
  edtCodTec.Clear;
  edtDesTec.Clear;
  edtCodEqu.Clear;
  edtDesEqu.Clear;
  edtDesMar.Clear;
  edtVoltag.Clear;
  edtObs.Clear;
  edtObsGer.Clear;
  edtObsNFS.Clear;
  edtDisSer.Clear;
  edtNSerie.Clear;
  cbGarant.ItemIndex := -1;
  edtNFComp.Clear;
  edtNFReme.Clear;
  mskDtNFco.Clear;
  mskDtNFRe.Clear;
  edtRevend.Clear;
  edtConRet.Clear;
  edtDeiPor.Clear;
  mskEntreg.Clear;
  edtDiaEnt.Text := '0';
  edtCntCli.Clear;
  mskCntTel.Clear;
  edtNumPat.Clear;
  edtDadFab.Clear;
  mskDtaInc.Clear;
  lblNOSFab.Visible := False;
  edtNOSFab.Visible := False;
  cbEstPrd.ItemIndex := -1;
  lblCodFab.Caption := EmptyStr;
  lblSaldos.Caption := EmptyStr;
  lblSal_OS.Caption := EmptyStr;
  lblEntreg.Caption := EmptyStr;
  lblCodCnd.Caption := EmptyStr;
  lblConPag.Caption := EmptyStr;
  lblForPag.Caption := EmptyStr;
  lblTotPro.Caption := EmptyStr;
  lblTotSer.Caption := EmptyStr;
  lblTotGer.Caption := EmptyStr;
  lblTotDes.Caption := EmptyStr;
  lblTotST.Caption  := EmptyStr;
  lblTotRef.Caption := EmptyStr;
  lblTotIPI.Caption := EmptyStr;
  lblTotFre.Caption := EmptyStr;
  if (strSugEqu <> '0') then
    cbTabPreco.ItemIndex := cbTabPreco.Items.IndexOf(strSugEqu)
  else
    cbTabPreco.ItemIndex := 0;
  edtCodCnd.Clear;
  mskCndPag.Clear;
  edtDesCndPag.Clear;
  edtForPag.Clear;
  edtDesForPag.Clear;
  edtLocFis.Clear;
  edtProtoc.Clear;
  edtNOSAnt.Clear;
  mskDtEAnt.Clear;
  mskDtRAnt.Clear;
  edtTmpGar.Clear;
  chkAutDescarte.Clear;
  edtCodLoc.Clear;
  edtDesLoc.Clear;
  edtFazenda.Clear;

  edtEmpSer.Text := VS_strCodEmp;

  if fCfgSis('NOMEMP') = '2' then
    edtDesEmpSer.Text := fRetFantasiaEmpresa(edtEmpSer.Text)
  else
    edtDesEmpSer.Text := fRetNomeEmpresaSelec(edtEmpSer.Text);

  edtCodEqu.Enabled  := True;
  edtDesEqu.Enabled  := True;
  edtDesMar.Enabled  := True;
  edtVoltag.Enabled  := True;
  edtNSerie.Enabled  := True;
  cbGarant.Enabled   := True;
  edtNFComp.Enabled  := True;
  mskDtNFco.Enabled  := True;
  edtNFReme.Enabled  := True;
  mskDtNFRe.Enabled  := True;
  edtRevend.Enabled  := True;
  edtConRet.Enabled  := True;
  edtDeiPor.Enabled  := True;
  mskEntreg.Enabled  := mskEntreg.Visible;
  edtDiaEnt.Enabled  := edtDiaEnt.Visible;
  edtCntCli.Enabled  := True;
  mskCntTel.Enabled  := True;
  edtNumPat.Enabled  := True;
  edtDadFab.Enabled  := True;
  cbEstPrd.Enabled   := True;
  edtTmpGar.Enabled  := False;
  edtNOSAnt.Enabled  := True;
  mskDtEAnt.Enabled  := True;
  mskDtRAnt.Enabled  := True;
  chkPrtAtd.Visible   := False;
  chkPrtAtd.Checked   := False;

  chkAutDescarte.Enabled  := True;
  chkAutDescarte.Checked  := False;

  dbgGrid.Enabled    := True;
  dbgGridDfe.Enabled := True;
  dbgServico.Enabled := True;
  dbgGridAce.Enabled := True;
  dbgGridApo.Enabled := True;

  {* ITENS *}
  pLimpaDadosItem;
  edtCodIte.Enabled := True;
  edtDesIte.Enabled := True;
  edtUnitar.Enabled := True;
  pnlItens.Enabled  := False;

  {* SERVIÇOS *}
  pLimpaDadosServico;
  edtCodSe1.Enabled     := True;
  edtDesSe1.Enabled     := True;
  edtCodTecSe1.Enabled  := True;
  edtValSe1.Enabled     := True;
  edtQtdSe1.Enabled     := True;
  pnlServicos.Enabled   := False;

  {* DEFEITOS *}
  pnlDefeitos.Enabled   := False;

  {* ACESSÓRIOS *}
  edtCodAce.Enabled       := True;
  pnlAcessorios.Enabled   := False;
  edtDesAce.Clear;
  edtCodAce.Clear;
  edtQtdAce.Text := FormatFloat(fMskDigitos(intDecQtde), 1);
  blnAltAcessorio     := False;

  {* DOCS. FISCAIS REFERENCIADOS *}
  grbDocEntrada.Enabled := False;
  grbDocSaida.Enabled   := False;

  btnConfirmar.Enabled  := True;
  btnApontHoras.Enabled := False;
  btnAprovada.Enabled   := False;
  btnReprovar.Enabled   := False;
  btnManutencao.Enabled := False;
  btnRealizada.Enabled  := False;
  btnCancelar.Enabled   := False;
  btnImprimir.Enabled    := False;
  btnHisSta.Enabled     := False;
  btnAddObsTec.Enabled  := False;
  btnComunicacaoInterna.Enabled := False;
  btnConsultarCliente.Enabled := False;
  btnImpItensServicos.Enabled := False;
  btnImpEti.Enabled     := False;
  btnImpSeparacao.Visible := False;
  btnImpPed.Visible       := False;

  btnTermoDev.Enabled   := False;
  btnObservacao.Enabled := False;
  btnAlteracao.Visible  := False;

  edtNumero.Enabled  := True;
  edtCodEmp.Enabled  := True;
  edtCodCli.Enabled  := True;
  edtCodTec.Enabled  := True;
  cbTabPreco.Enabled := True;

  pnlTopo.Enabled   := True;
  pnlCndPag.Enabled := True;

  edtCodCnd.Enabled := True;
  mskCndPag.Enabled := True;
  pnlRepDig.Enabled := True;
  edtDesCndPag.Enabled := True;
  edtForPag.Enabled    := True;
  edtDesForPag.Enabled := True;
  edtCodEqu.Enabled    := True;
  edtLocFis.Enabled    := edtLocFis.Visible;
  edtDesEqu.Enabled    := True;
  edtSenDig.Enabled    := True;
  edtDisSer.Enabled    := False;

  lblST.Visible  := False;
  lblIPI.Visible := False;

  strValidaEqu := 'N';
  pSetFocus(edtNumero);
  strValidaEqu := 'S';

  lblStatus.Caption := '';
  blnAprovada       := False;

  btnDevCli.Visible := False;
  btnDevCli.Enabled := False;

  edtProtoc.Enabled := True;

  btnAlteraItens.Enabled := False;
  btnBrindeTotalServ.Enabled := False;

  strFpgAnt    := '';
  strCCnAnt    := '';
  strConPagAnt := '';

  If Assigned(objMeqMerEnt) Then
    FreeAndNil(objMeqMerEnt);

  If Assigned(objMeqMerSai) Then
    FreeAndNil(objMeqMerSai);

  If (qryCadCli.Active) Then
    qryCadCli.Close();

  btnCancelarOS.Visible := False;
  btnDesEsp.Visible     := True;
  btnMostraMargem.Enabled := True;
  btnCancAprovacao.Enabled := False;

  pCarregaDadosNFEntSai;

  pHabilitarCamposRealizada(False);

  blnVerificaLimiteCredito := False;

  edtChaveNfeEnt.Text := '';
  cmbEquEnt.Text := '';

  chkCobAPa.Visible    := False;
  chkCobAPaSer.Visible := False;
  fFindColumnByName(dbgGrid   , 'COBAPA').Visible := chkCobAPa.Visible;
  fFindColumnByName(dbgServico, 'COBAPA').Visible := chkCobAPaSer.Visible;

  If stlManEquAltLck.Count > 0  Then
    pDestravaELimpaStlManEquLck();

  strMultiTabPreAnt := EmptyStr;
  strMultiTabPreAtu := EmptyStr;
  strCndPgtoAnt     := EmptyStr;
  strCndPgtoAtu     := EmptyStr;
  pExibeValores;
  pAlteraTelaRotinaTecnico;
  pLimpaImagem;

  if Assigned(qryConCnd) then
    qryConCnd.Close;

  FblnSenhaIncorreta := False;
  FblnManterPrecos := False;

  edtCodLoc.Enabled := edtCodLoc.Visible;
  edtDesLoc.Enabled := edtDesLoc.Visible;

  pExibirDadosFazenda(False);

  RedimensionaRevendaRetornarDeixadoPor;

  trvHisEqu.Items.Clear;

  if (objConEqu.cdsMovRcd.Active) then
    objConEqu.cdsMovRcd.EmptyDataSet;

  pHabilitaPainelLegendas;
end;

procedure TfrmFatManConsertoEquip.pCalculaDataPrevisao(blnAprovando: Boolean = False);
var
  strCodCid,
  strSQL: String;
  dtaDtApr: TDateTime;
  qryAux: TUniQuery;
begin
  mskEntreg.Clear;

  if ((objConEqu.strStatus = 'E') or (objConEqu.strStatus = 'F')) and (not blnAprovando) then
    Exit;

  qryAux := fCriaQuery;

  try
    if (not blnAprovando) then
    begin
      strSQL := '';
      strSQL := strSQL + ' SELECT LOG_DTALOG DTAAPR ';
      strSQL := strSQL + ' FROM LOGSTA ';
      strSQL := strSQL + ' WHERE LOG_NUMOSE = :NUMOSE ';
      strSQL := strSQL + '   AND LOG_CODEMP = :CODEMP ';
      strSQL := strSQL + '   AND LOG_STAATU IN ("AB", "AC", "AG") ';
      strSQL := strSQL + '   AND LOG_DTALOG = (SELECT MAX(LOG_DTALOG) ';
      strSQL := strSQL + '                     FROM LOGSTA LG ';
      strSQL := strSQL + '                     WHERE LG.LOG_NUMOSE = LOGSTA.LOG_NUMOSE ';
      strSQL := strSQL + '                       AND LG.LOG_CODEMP = LOGSTA.LOG_CODEMP ';
      strSQL := strSQL + '                       AND LG.LOG_STAATU IN ("AB", "AC", "AG")) ';
      strSQL := strSQL + ' LIMIT 1 ';

      qryAux.SQL.Text := strSQL;
      qryAux.ParamByName('NUMOSE').AsString := objConEqu.strNumero;
      qryAux.ParamByName('CODEMP').AsString := objConEqu.strCodEmp;
      qryAux.Open;

      if (qryAux.IsEmpty) then
        Exit;

      dtaDtApr := qryAux.FieldByName('DTAAPR').AsDateTime;
    end
    else
      dtaDtApr := VS_Date;

    strCodCid := fCampoTabela('EMP_CODCID', 'CADEMP', ['EMP_CODEMP'], [objConEqu.strEmpApr]);

    mskEntreg.Text := DateToStr(fAcertaDataParaDiaUteis(dtaDtApr, IIF(not fEmptyStr(edtDiaEnt.Text), StrToInt(edtDiaEnt.Text), 0), False, strCodCid));

    lblEntreg.Caption := mskEntreg.Text;

    if (StrToDateDef(mskEntreg.Text, 0) <> 0) then
      objConEqu.dtaEntreg := StrToDate(mskEntreg.Text);
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TfrmFatManConsertoEquip.pCalculaPrecoCusto(dtsDados: TDataSet;
  fltUnitar, fltPreCus: Double; blnIteEsp, blnIteVid: Boolean;
  fltIcmSai: Double);
var
  calcCustoReal: TCalcCustoReal;
  strCodSit,
  strCodAbf: String;
Begin
  With dtsDados Do
  Begin
    If (objEmitirPedido.objFatVenda.strIdePro = 'NOR') And (Not blnIteEsp) And (Not blnIteVid) Then
      objEmitirPedido.objFatVenda.fltPreCus := fltPreCus;

    If (objEmitirPedido.objFatVenda.fltPreCus = 0) And blnIteEsp Then
      objEmitirPedido.objFatVenda.fltPreCus := fltPreCus;

    If (objEmitirPedido.objFatVenda.strIdePro = 'NOR') And (Not blnIteVid) Then
    Begin
      calcCustoReal := TCalcCustoReal.Create;
      calcCustoReal.fltUnitar := fltUnitar;
      calcCustoReal.fltPreCus := fltPreCus;
      calcCustoReal.fltOutVal := FieldByName('ITE_OUTVAL').AsFloat;
      calcCustoReal.fltIcmSai := fltIcmSai;
      calcCustoReal.fltImpFed := FieldByName('ITE_IMPFED').AsFloat;
      calcCustoReal.fltDesOpe := FieldByName('ITE_DESOPE').AsFloat + objEmitirPedido.objFatVenda.fltDesOpeCli;

      strCodSit := '';
      strCodAbf := objEmitirPedido.objFatVenda.fGetCodAbf(FieldByName('ITE_CODITE').AsString, VS_strCodEmp);
      If (Not fEmptyStr(objEmitirPedido.objFatVenda.GetTipAbf)) And (objEmitirPedido.objFatVenda.fBuscaAbfIcm(FieldByName('ITE_CODITE').AsString, VS_strCodEmp, strCodAbf, objEmitirPedido.objFatVenda.fTrocaUFEndEntrega)) Then
        strCodSit := objEmitirPedido.objFatVenda.cdsAbfIcm.FieldByName('ABF_CODSIT' + objEmitirPedido.objFatVenda.GetTipAbf).AsString;

      calcCustoReal.fltDifal := objEmitirPedido.objFatVenda.fGetAlqDifal(FieldByName('ITE_CODITE').AsString, VS_strCodEmp, strCodAbf, strCodSit);

      calcCustoReal.fltFcp   := objEmitirPedido.objFatVenda.fGetAlqFcpIcms(FieldByName('ITE_CODITE').AsString, VS_strCodEmp, strCodAbf, strCodSit, fltIcmSai, fltUnitar);

      objEmitirPedido.objFatVenda.fltPreCu2 := objEmitirPedido.objFatVenda.fRetornaPrecoCusto(Preco_de_Custo_Real, FieldByName('ITE_CODITE').AsString, VS_strCodEmp, fltPreCus, '', calcCustoReal, blnIteEsp);

      FreeAndNil(calcCustoReal);
    End;
  End;
end;

procedure TfrmFatManConsertoEquip.pCalculaTotIte;
Begin
  edtUnitar.Text := FormatFloat(fMskDigitos(intDecimal), fStrToFloat(edtUnitar.text));
  edtTotIte.Text :=  FloatToStrF((fStrToFloat(edtQtdIte.text) * fStrToFloat(edtUnitar.text)), ffFixed, 12, 2);
  objConEqu.fltQtdIte := fStrToFloat(edtQtdIte.Text);
  objConEqu.fltTotIte := fStrToFloat(edtTotIte.Text);
  objConEqu.fltUnitar := fStrToFloat(edtUnitar.Text);
End;

procedure TfrmFatManConsertoEquip.pCancelaEntregaEquip;
var
  strStatus: String;
begin
  if (objConEqu.strFlxCom <> 'ER') then
  begin
    pMensagemOk(Format('O equipamento da O.S %s ainda não foi retirado.!', [objConEqu.strNumero]));
    Exit;
  end;

  if (fMensagem('', Format('Deseja cancelar a entrega do equipamento da OS %s?', [objConEqu.strNumero]), ['&Sim', '&Não']) = 2) then
    Exit;

  case (AnsiIndexStr(objConEqu.strFlxSit, ['FA', 'ON', 'AF', 'NF', 'OB'])) of
    0:
      begin
        objConEqu.strFlxFas := 'F';
        objConEqu.strFlxSit := 'FA';
        objConEqu.strFlxCom := 'AR';
        strStatus := 'R';
      end;
    1:
      begin
        objConEqu.strFlxFas := 'O';
        objConEqu.strFlxSit := 'ON';
        objConEqu.strFlxCom := 'AR';
        strStatus := 'N';
      end;
    2:
      begin
        objConEqu.strFlxFas := 'M';
        objConEqu.strFlxSit := 'AR';
        objConEqu.strFlxCom := 'AF';
        strStatus := 'R';
      end;
    3:
      begin
        objConEqu.strFlxFas := 'F';
        objConEqu.strFlxSit := 'NF';
        objConEqu.strFlxCom := 'AR';
        strStatus := 'R';
      end;
    4:
      begin
        objConEqu.strFlxFas := 'R';
        objConEqu.strFlxSit := 'OB';
        objConEqu.strFlxCom := 'AR';
        strStatus := 'N';
      end;
  end;

  objConEqu.pAlteraStatusDados(strStatus, 'A');
  objConEqu.pGravarLogFlx(blnFLuxoProcesso);

  pMensagemOk('Cancelamento efetuado com sucesso.');
end;

procedure TfrmFatManConsertoEquip.btnCancelaDfeClick(Sender: TObject);
begin
  inherited;
  edtDesDfe.Clear;
  edtCodDfe.Clear;
  pSetFocus(edtCodDfe);
end;

procedure TfrmFatManConsertoEquip.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimpaDadosItem;
  edtCodIte.Enabled := True;
  edtDesIte.Enabled := True;
  edtUnitar.Enabled := True;

  If (rdbCodFab.Checked) Then
    rdbCodFabClick(rdbCodFab)
  Else
    rdbCodIteClick(rdbCodIte);

  pSetaTabelaPreco(objConEqu.strTabPre);

  edtEmpIte.Text := VS_strCodEmp;

  if fCfgSis('NOMEMP') = '2' then
    edtDesEmpIte.Text := fRetFantasiaEmpresa(edtEmpIte.Text)
  else
    edtDesEmpIte.Text := fRetNomeEmpresaSelec(edtEmpIte.Text);

  pSetFocus(edtCodIte);
  pHabilitaPainelLegendas;
end;

procedure TfrmFatManConsertoEquip.btnCancelaSe1Click(Sender: TObject);
begin
  inherited;
  pLimpaDadosServico;
  edtCodSe1.Enabled    := True;
  edtDesSe1.Enabled    := True;
  edtCodTecSe1.Enabled := True;
  edtValSe1.Enabled    := True;
  edtQtdSe1.Enabled    := True;
  pSetFocus(edtCodSe1);
end;

procedure TfrmFatManConsertoEquip.blnRealizarEntradaClick(Sender: TObject);
  Var
    intOpcao: Integer;
    strMsgTmp: String;
  Const
    IDX_ENTRADA_XML = 1;
    IDX_ENT_XML_IMP = 2;
    IDX_ENTRADA_MANUAL = 3;
begin
  inherited;

  strMsgTmp := '';

  If fEmptyStr(fCfgSis('ITECON', VarString)) Or fEmptyStr(fCfgSis('CLACON', VarString)) Then
  Begin
    If fEmptyStr(fCfgSis('ITECON', VarString)) Then
      strMsgTmp := 'CFG_ITECON';

    If fEmptyStr(fCfgSis('CLACON', VarString)) Then
    Begin
      If fEmptyStr(strMsgTmp) Then
        strMsgTmp := 'A configuração CFG_CLACON está'
      Else
        strMsgTmp := 'As configurações ' + strMsgTmp + ', CFG_CLACON estão';
    End
    Else
    Begin
      If Not fEmptyStr(strMsgTmp) Then
        strMsgTmp := 'A configuração ' + strMsgTmp + ' está';
    End;

    fMensagem('', strMsgTmp + ' em branco. Configure-a(s) corretamente para prosseguir com este processo!' , ['&Ok']);
    Exit;
  End;

  If (Assigned(objMeqMerEnt)) And (Not fEmptyStr(objMeqMerEnt.strAutGer)) Then
  Begin
    fMensagem('ATENÇÃO', 'Nota de Entrada já vinculada à Ordem de Serviço.' + #13#10 +
                         'Remova o vínculo da Nota de Entrada atual.' , ['&OK']);
    Exit;
  End;

  If fEmptyStr(edtCodCli.Text) Then
  Begin
    fMensagem('', 'Defina um cliente para prosseguir com este processo!' , ['&Ok']);
    Exit;
  End;

  intOpcao := fGetMenu('Realizar a digitação da entrada por:',
    ['Via Importação do XML da NF-e',
     'XML da NF-e já Importado',
     'Digitação Manual da NF de Entrada',
     'Sair'], 1);

  If (intOpcao = IDX_ENTRADA_MANUAL) Then
    pEntradaNF()
  Else If (intOpcao = IDX_ENT_XML_IMP) Or (intOpcao = IDX_ENTRADA_XML) Then
    pEntradaNF_XML(intOpcao = IDX_ENT_XML_IMP)
  Else
    fMensagem('ALERTA', 'Digitação da entrada foi cancelada!' , ['&OK']);
end;

procedure TfrmFatManConsertoEquip.btnAddObsTecClick(Sender: TObject);
var
  strCodEmp: String;
begin
  inherited;

  If fEmptyStr(edtNumero.Text) Then
    Exit;

  If edtCodEmp.Visible Then
  Begin
    strCodEmp := edtCodEmp.Text;
  End
  Else
  Begin
    strCodEmp := VS_strCodEmp;
  End;

  if not fValidaCampos(edtSenDig, True) then
    Exit;

  Try
    pCriarFormularios(TfrmFatManConsertoObsTecnicas, frmFatManConsertoObsTecnicas);
    frmFatManConsertoObsTecnicas.strSeqGer := fCampoTabela('AUTOINCREM',
                                                           'EQUGER',
                                                          ['EQU_NUMOSE', 'EQU_CODEMP'],
                                                          [objConEqu.strNumero, strCodEmp]);

    If fCfgSis('CALTOS') = 'S' Then
    Begin
      frmFatManConsertoObsTecnicas.blnConfOrc       := btnConfirmar.Enabled;
      frmFatManConsertoObsTecnicas.blnConfMan       := (not btnManutencao.Enabled);
      frmFatManConsertoObsTecnicas.strStatus        := objConEqu.strStatus;

      frmFatManConsertoObsTecnicas.blnTemProdServ :=
        (dbgGrid.DataSource.DataSet.RecordCount > 0) Or
        (dbgServico.DataSource.DataSet.RecordCount > 0);
    End
    Else
    Begin
      frmFatManConsertoObsTecnicas.blnConfOrc     := True;
      frmFatManConsertoObsTecnicas.blnConfMan     := True;
      frmFatManConsertoObsTecnicas.strStatus      := objConEqu.strStatus;;
      frmFatManConsertoObsTecnicas.blnTemProdServ := True;
    End;

    frmFatManConsertoObsTecnicas.blnFluxoProcesso := blnFluxoProcesso;
    frmFatManConsertoObsTecnicas.tpProcessoFlx    := tpProcessoFlx;
    frmFatManConsertoObsTecnicas.objConEquOS      := objConEqu;

    frmFatManConsertoObsTecnicas.ShowModal;

    blnIniOrc := frmFatManConsertoObsTecnicas.blnIniOrc AND (fCfgSis('CALTOS') = 'S');
    blnFinOrc := frmFatManConsertoObsTecnicas.blnFinOrc AND (fCfgSis('CALTOS') = 'S');
    blnIniMan := frmFatManConsertoObsTecnicas.blnIniMan AND (fCfgSis('CALTOS') = 'S');
    blnFinMan := frmFatManConsertoObsTecnicas.blnFinMan AND (fCfgSis('CALTOS') = 'S');

    IF blnFinOrc AND (fCfgSis('CALTOS') = 'S') Then
      btnConfirmar.Click;

    IF blnFinMan AND (fCfgSis('CALTOS') = 'S') Then
      btnRealizada.Click;

    IF blnIniMan AND (Not btnConfirmar.Enabled) AND (fCfgSis('CALTOS') = 'S') Then
      btnRealizada.Enabled := True;

  Finally
    pFreeAndNil(frmFatManConsertoObsTecnicas);
  End;
end;

procedure TfrmFatManConsertoEquip.btnAdicionarAceClick(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodAce.Text) Then
    Exit;

  If Not fVerificaCampos Then
    Exit;

  Try
    objConEqu.strCodAce := edtCodAce.Text;
    objConEqu.strDesAce := edtDesAce.Text;
    objConEqu.fltQtdAce := fStrToFloat(edtQtdAce.Text);
    objConEqu.cdsAceEqu.DisableControls;

    if (not blnAltAcessorio) or
       (objConEqu.cdsAceEqu.IsEmpty) then
    begin
      objConEqu.pIncluiAcessorioGrid;
      pIncluiNaListaConsulta('CODACE', 'ACE_CODACE', sltAce, objConEqu.cdsAceEqu, cdsConsultaAce);
    end
    else
      objConEqu.pAlteraAcessorioGrid;

    objConEqu.cdsAceEqu.EnableControls;

    objConEqu.strCodAce := EmptyStr;
    objConEqu.strDesAce := EmptyStr;
    objConEqu.strDesAce := EmptyStr;
    objConEqu.fltQtdAce := 1;

    dbgGridAce.Enabled := True;
    dbgGridAce.Refresh;

    btnCancelaAce.Click;

    If (Assigned(frmFatVendaItem)) Then frmFatVendaItem.Close();
  Except
    On e:exception do
    Begin
      pMensagensErro(E.Message, 'btnAdicionarAceClick - untFatDigSerConsertoEquip');
    End;
  End;
end;

procedure TfrmFatManConsertoEquip.btnAdicionarClick(Sender: TObject);
  Var
    strCodPar, strTipBri: String;
begin
  inherited;

  blnBuscarCodFab := False;

  If (Not fVerificaCampos) Or fEmptyStr(edtCodIte.Text) Then
  Begin
    If (rdbCodFab.Checked) Then
      rdbCodFabClick(rdbCodFab)
    Else
      rdbCodIteClick(rdbCodIte);
    Exit;
  End;

  if (not fValidaCampos(edtUnidad)) then
    Exit;

  if (not fValidaCampos(edtEmpIte)) then
    Exit;

  If chkBrindePro.Visible And chkBrindePro.Checked Then
  Begin
    strCodPar := objConEqu.strCodPar;
    strTipBri := objConEqu.strTipBri;

    If Not fPedeDadosBrinde(chkBrindePro.Checked, strCodPar, strTipBri) Then
      Exit;

    if (pnlTipBriPrd.Visible) then
    begin
      objConEqu.strBrinde := 'S';
      objConEqu.strCodPar := '';
      objConEqu.strTipBri := edtTipBriPrd.Text;
    end
    else
    begin
      objConEqu.strBrinde := 'S';
      objConEqu.strCodPar := strCodPar;
      objConEqu.strTipBri := strTipBri;
    end;
  End
  Else
  Begin
    chkBrindePro.Checked := False;
    objConEqu.strBrinde  := 'N';
    objConEqu.strCodPar  := '';
    objConEqu.strTipBri  := '';
  End;

  if (chkCobAPa.Visible) and (chkCobAPa.Checked) then
    objConEqu.strCobAPaIte := 'S'
  else
    objConEqu.strCobAPaIte := 'N';

  If (chkBrindePro.Visible And chkBrindePro.Checked) Then
  Begin
    edtUnitar.Text := '0,00';
    pCalculaTotIte;
  End;

  If fCfgSis('CUSESP', varBoolean) Then
  Begin

    If (objConEqu.fltTotCus <= 0) Then
    Begin
      fMensagem('', 'A Esse produto está com o preço de custo Zerado!' + #13#10 +
                    'Favor corrigir.', ['&Ok']);
      If (rdbCodFab.Checked) Then
        rdbCodFabClick(rdbCodFab)
      Else
        rdbCodIteClick(rdbCodIte);
      Exit;
    End;

  End
  Else
  Begin
    If fCfgSis('MMIIES', varDouble) <= 0 Then
    Begin
      fMensagem('', 'A Margem mínima para item especial está Zerada!' + #13#10 +
                    'Favor corrigir.', ['&Ok']);
      If (rdbCodFab.Checked) Then
        rdbCodFabClick(rdbCodFab)
      Else
        rdbCodIteClick(rdbCodIte);
      Exit;
    End;
  End;

  {***********************************************************************}
  {* SE FOR ITEM ESTRUTURA, VERIFICA SE DEVE CARREGAR OS SUBITENS OU NÃO *}
  {********************************************************************MM*}

   blnCarItem := False;

  If fItemEstrutura(edtCodIte.Text) Then
  Begin
    If fCfgSis('CAREST', varString) = 'S' Then
    Begin
      If fMensagem('', 'Carregar os itens da estrutura?', ['&S i m', '&N ã o']) = 1 Then
      begin
        blnCarItem := True;
        pCarregaEstrutura(edtCodIte.Text, fStrToFloat(edtQtdIte.Text))
      end
      Else
      begin
        pAdicionaItem;
      end;
    End
    Else If fCfgSis('CAREST', varString) = 'N' Then
    Begin
      pAdicionaItem;
    End
    Else If fCfgSis('CAREST', varString) = 'P' Then
    Begin
      pCarregaEstrutura(edtCodIte.Text, fStrToFloat(edtQtdIte.Text), fStrToFloat(edtTotIte.Text));
    End;
  End
  Else
  Begin
    pAdicionaItem;
  End;

  blnCarItem := False;

  If (Assigned(frmFatVendaItem)) Then
    frmFatVendaItem.Close();
end;

procedure TfrmFatManConsertoEquip.FormShow(Sender: TObject);
begin
  inherited;
  objConEqu.strOperac := 'I';
  objConEqu.strStatus := 'E';
  objConEqu.strTemPed := 'N';

  dtsIteEqu.DataSet       := objConEqu.cdsIteEqu;
  objConEqu.cdsIteEqu.AfterScroll := pAtualizaDados;
  dbgGrid.DataSource      := dtsIteEqu;

  dtsServico.DataSet      := objConEqu.cdsSerEqu;
  dbgServico.DataSource   := dtsServico;

  dtsDefeito.DataSet      := objConEqu.cdsDfeEqu;
  dbgGridDfe.DataSource   := dtsDefeito;

  dtsAcessorios.DataSet   := objConEqu.cdsAceEqu;
  dbgGridAce.DataSource   := dtsAcessorios;

  dtsApontamentos.DataSet := objConEqu.cdsApoEqu;
  dbgGridApo.DataSource   := dtsApontamentos;

  strValidaEqu := 'S';

  {*************************************************}
  {* BLOQUEIA / LIBERA ALTERAÇÃO DO VALOR UNITÁRIO *}
  {**********************************************MM*}
  If fCfgSis('ALVAUN', varBoolean) Then
    edtUnitar.ReadOnly := False
  Else
    edtUnitar.ReadOnly := True;

  {************************************************}
  {* CASO USE TABELA DE PREÇO NA ORDEM DE SERVICO *}
  {*********************************************JC*}
  If Not fCfgSis('TBPOSE', varBoolean) Then
  Begin
    lblTabPreco.Visible := False;
    cbTabPreco.Visible  := False;
    edtNomCli.Width     := 530;
  End;

  If (fCfgSis('FABMOS') = 'N') Then
  Begin
    rdbCodIte.Visible := False;
    rdbCodFab.Visible := False;
  End
  Else
  Begin
    rdbCodIte.Checked := False;
    rdbCodFab.Checked := True;
  End;

  If (rdbCodFab.Checked) Then
    rdbCodFabClick(rdbCodFab)
  Else
    rdbCodIteClick(rdbCodIte);

  pVerificaTabPre;
  pSetFocus(edtNumero);

  btnConsultaCatalogos.Visible := (fCfgSis('CATPRE', varString) = 'S');

  if (btnConsultaCatalogos.Visible) and ((blnFluxoProcesso) and (not (tpProcessoFlx in [tprDefPrdSer, tprOrcamento]))) then
    btnConsultaCatalogos.Visible := False;

  pHabilitarCamposRealizada(False);

  btnUltimasVendas.Enabled := True;
  pAlteraTelaRotinaTecnico;

  If fCfgSis('SUJROM', VarString) = 'S' Then
    cmbEntRet.ItemIndex := IDX_ENTREGA
  Else
    cmbEntRet.ItemIndex := IDX_RETIRA;

  If cbEstPrd.Visible Then
    pCarregaEstProduto;

  strTERROS := fCfgSis('TERROS', varString);
  strCOSAnt := fCfgSis('COSANT', varString);
  pVerificaProntoAtendimento;

  objConEqu.blnOSCancelada := blnOSCancelada;

  pHabilitaLocRet;

  if blnFluxoProcesso then
    pShowFluxoProcesso;

  if blnNegociacao then
    pShowNegociacao;

  btnMostraMargem.Visible := fVerificaAcessoSistema('VIMLF4');
  btnMostraMargem.Caption := '[Shift+F4] ' + IIF(fMargem_ou_Markup = 'MARGEM','Margem','Markup') + '/Lucro';

  SetWindowLong(trvHisEqu.Handle, GWL_STYLE, GetWindowLong(trvHisEqu.Handle,GWL_STYLE) or $80);
End;

procedure TfrmFatManConsertoEquip.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  strCodTmp: String;
begin
  inherited;

  If fIsInsert(Key) Then
  Begin
    If edtCodEqu.Focused Then
    Begin
      objConEqu.strCodEqu := '';
      edtCodEqu.Text := fChamaCadEqu(Key);
    End
    Else If edtCodDfe.Focused Then
    Begin
      objConEqu.strCodDfe := '';
      edtCodDfe.Text := fChamaCadDfe(Key);
    End
    Else If edtCodAce.Focused Then
    Begin
      objConEqu.strCodAce := '';
      edtCodAce.Text := fChamaCadAcessorio(Key);
    End
    Else If edtCodCli.Focused Then
    Begin
      If objConEqu.fVerificaAcessoSistemaOS('frmCadClientes', 'Acesso ao cadastro de clientes pela rotina de Manutenção de Equipamentos.', '') Then
      Begin
        objConEqu.strCodCli := '';

        if fEmptyStr(edtCodCli.Text) or
           (fClienteConsumidor(fRetNomCliente(fStrZero(edtCodCli.Text, 8)))) or
           fEmptyStr(fCampoTabela('CLI_CODCLI', 'CADCLI', ['CLI_CODCLI'], [fStrZero(edtCodCli.Text, 8)])) then
          strCodTmp := fChamaCadCli(Key)
        else
          strCodTmp := fAlteraCadCli(fStrZero(edtCodCli.Text, 8));

        if (not fEmptyStr(strCodTmp)) then
        begin
          edtCodCli.Text := strCodTmp;
          edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
        end;
      End;
    End
    else if edtCodLoc.Focused then
    begin
      objConEqu.strLocFis := '';
      edtCodLoc.Text := fChamaCadLocFisicaConsertoEquip(Key);
    end;
  End;

  If (Shift = [ssCtrl]) And (char(Key) = 'P') Then
  Begin
    pgcTabs.ActivePage := tbsProdutos;
    If edtCodIte.Enabled Then pSetFocus(edtCodIte);
  End;

  If (Shift = [ssCtrl]) And (char(Key) = 'S') Then
  Begin
    pgcTabs.ActivePage := tbsServicos;
    If edtCodSe1.Enabled Then pSetFocus(edtCodSe1);
  End;

  If (Shift = [ssCtrl]) And (char(Key) = 'D') Then
  Begin
    pgcTabs.ActivePage := tbsDefeitos;
    If edtCodDfe.Enabled Then pSetFocus(edtCodDfe);
  End;

  If (Shift = [ssCtrl]) And (char(Key) = 'F') Then
  Begin
    pgcTabs.ActivePage := tbsDocsRelacionados;
  End;

  If (Shift = [ssCtrl]) And (char(Key) = 'A') Then
  Begin
    pgcTabs.ActivePage := tbsAcessorios;
    If edtCodAce.Enabled Then pSetFocus(edtCodAce);
  End;

  If (Shift = [ssCtrl]) And (char(Key) = 'H') Then
    pgcTabs.ActivePage := tbsApontamentos;

  If (Shift = [ssCtrl]) And (char(Key) = 'E') Then
    pgcTabs.ActivePage := tbsHistEquipamento;

  If (Shift = [ssAlt]) And (Key = VK_F2) Then
  Begin
    If (btnEndEnt.Enabled) And (btnEndEnt.Visible) Then
      btnEndEnt.Click;
  End
  Else If (Shift = [ssCtrl]) And (Key = VK_F2) Then
  Begin
    If (btnAltCondPagto.Enabled) And (btnAltCondPagto.Visible) Then
      btnAltCondPagto.Click;
  End
  Else If (Key = VK_F2) Then
  Begin
    If btnAlteracao.Visible  Then btnAlteracao.Click;
  End;

  If (Shift = [ssAlt]) And (Key = VK_F3) Then
  Begin
    If (btnHisSta.Enabled) And (btnHisSta.Visible) Then
      btnHisSta.Click;
  End
  Else If (Shift = [ssCtrl]) And (Key = VK_F3) Then
  Begin
    If (btnAltTecServicos.Enabled) And (btnAltTecServicos.Visible) Then
      btnAltTecServicos.Click;
  End
  Else If (Key = VK_F3) Then
  Begin
    If (btnDevCli.Enabled) And (btnDevCli.Visible) Then
      btnDevCli.Click;
  End;

  If (Shift = [ssCtrl]) And (Key = VK_F5) Then
  Begin
    If (btnImpostos.Enabled) And (btnImpostos.Visible) Then
    Begin
      btnImpostos.Click;
    End;
  End
  Else If (Shift = [ssAlt]) And (Key = VK_F5) Then
  Begin
    If (btnReprovar.Enabled) And (btnReprovar.Visible) Then
      btnReprovar.Click;
  End
  Else If (Key = VK_F5) Then
  Begin
    If (btnObservacao.Enabled) And (btnObservacao.Visible) Then
      btnObservacao.Click;
  End;

  If (Shift = [ssShift]) And (Key = VK_F6) Then
  Begin
    If (btnComunicacaoInterna.Enabled) And (btnComunicacaoInterna.Visible) Then
      btnComunicacaoInterna.Click;
  End
  Else If (Shift = [ssAlt]) And (Key = VK_F6) Then
  Begin
    If (btnAddObsTec.Enabled) And (btnAddObsTec.Visible) Then
      btnAddObsTec.Click;
  End
  Else If (Shift = [ssCtrl]) And (Key = VK_F6) Then
  Begin
    If (btnAlteraItens.Enabled) And (btnAlteraItens.Visible) Then
      btnAlteraItens.Click;
  End
  Else If (Key = VK_F6) Then
  Begin
    If (btnImprimir.Enabled) And (btnImprimir.Visible)    Then
      btnImprimir.Click;
  End;

  If (Shift = [ssAlt]) And (Key = VK_F7) Then
  Begin
    If (btnImpEti.Enabled) And (btnImpEti.Visible) Then
      btnImpEti.Click;
  End
  Else If (Shift = [ssCtrl]) And (Key = VK_F7) Then
  Begin
    If (btnSalRes.Enabled) And (btnSalRes.Visible) Then
      btnSalRes.Click;
  End
  Else If (Shift = [ssShift]) And (Key = VK_F7) Then
  begin
    case (pgcTabs.ActivePageIndex) of
      1 : pMostraUltimasVendas(false);
      2 : pMostraUltimasVendas(true);
    end;
  End
  Else If (Key = VK_F7) Then
  Begin
    If (btnCancelar.Enabled) And (btnCancelar.Visible) Then
      btnCancelar.Click;
  End;

  If (Key = VK_F10) Then
  Begin
    If (Shift = [ssAlt]) Then
    Begin
      If (btnApontHoras.Visible) And (btnApontHoras.Enabled) Then
        btnApontHoras.Click();
    End
    Else if (Shift = [ssCtrl]) then
    begin
      if (btnConfirmarVarias.Enabled) And (btnConfirmarVarias.Visible) then
        btnConfirmarVarias.Click;
    end
    Else
    Begin
      If btnConfirmar.Enabled Then
        btnConfirmar.Click;
    End;
  End;

  If (Key = VK_F11) Then
  Begin
    If (Shift = [ssAlt]) Then
    Begin
      If (btnImpPed.Visible) And (btnImpPed.Visible) Then
        btnImpPed.Click();
    End
    Else
    Begin
      If (btnManutencao.Enabled) And (btnManutencao.Visible) Then
        btnManutencao.Click;
    End;
  End;

  If (Shift = [ssAlt]) And (Key = VK_F8) Then
  Begin
    If (btnCancelarOS.Visible) And (btnCancelarOS.Visible)  Then
      btnCancelarOS.Click;
  End
  Else If (Shift = [ssCtrl]) And (Key = VK_F8) Then
  Begin
    If (btnImpItensServicos.Enabled) And (btnImpItensServicos.Visible) Then
      btnImpItensServicos.Click;
  End
  Else If (Shift = [ssShift]) And (Key = VK_F8) Then
  Begin
    If (btnUltimasVendas.Visible) And (btnUltimasVendas.Visible)  Then
      btnUltimasVendas.Click();
  End
  Else If (Key = VK_F8) Then
  Begin
    If (btnRealizada.Enabled) And (btnRealizada.Visible)  Then
      btnRealizada.Click;
  End;

  {Reativar OS}
  If (Key = VK_F1) Then
  Begin
    If (btnReativar.Enabled) And (btnReativar.Visible) Then
      btnReativar.Click;
  End;

  If (Shift = [ssCtrl]) And (Key = VK_F4) Then
  Begin
    If btnDesEsp.Visible  Then btnDesEsp.Click;
  End
  Else If (Shift = [ssShift]) And (Key = VK_F4) Then Begin
    If (btnMostraMargem.Visible) and (btnMostraMargem.Enabled) Then
    btnMostraMargem.Click;
  End
  Else If (Key = VK_F4) Then
  Begin
    If (btnTermoDev.Enabled) And (btnTermoDev.Visible)   Then
      btnTermoDev.Click;
  End;

  If (Shift = [ssAlt]) And (Key = VK_F9) Then
  Begin
    If (btnConsultaCatalogos.Enabled) And (btnConsultaCatalogos.Visible)  Then
      btnConsultaCatalogos.Click;
  End
  Else If (Shift = [ssCtrl]) And (Key = VK_F9) Then
  Begin
    If (btnBrindeTotalServ.Enabled) And (btnBrindeTotalServ.Visible)  Then
      btnBrindeTotalServ.Click;
  End
  Else If (Shift = [ssShift]) And (Key = VK_F9) Then
  Begin
    If (btnCancAprovacao.Enabled) And (btnCancAprovacao.Visible)  Then
      btnCancAprovacao.Click;
  End
  Else If (Key = VK_F9) Then
  Begin
    If (btnAprovada.Enabled) And (btnAprovada.Visible)   Then
      btnAprovada.Click;
  End;

  If (Key = VK_F12) Then
  Begin
    If (Shift = [ssAlt]) Then
    Begin
      If (btnImpSeparacao.Visible) Then
        btnImpSeparacao.Click();
    End
    Else if (Shift = [ssCtrl]) then
    Begin
      if (btnOrdMaoObrCli.Enabled) And (btnOrdMaoObrCli.Visible) then
        btnOrdMaoObrCli.Click();
    End
    Else
    Begin
      If (btnPedCompraItens.Enabled) And (btnPedCompraItens.Visible) Then
        btnPedCompraItens.Click();
    End;
  End;

end;

procedure TfrmFatManConsertoEquip.btnComunicacaoInternaClick(Sender: TObject);
var
  frmFatManConsertoComunicacaoInterna: TfrmFatManConsertoComunicacaoInterna;
begin
  inherited;
  pCriarFormularios(TfrmFatManConsertoComunicacaoInterna, frmFatManConsertoComunicacaoInterna);
  try
    frmFatManConsertoComunicacaoInterna.ObjConEqu := objConEqu;
    frmFatManConsertoComunicacaoInterna.ShowModal;
  finally
    pFreeAndNil(frmFatManConsertoComunicacaoInterna);
  end;
end;

procedure TfrmFatManConsertoEquip.btnConfirmarClick(Sender: TObject);
  Var
    blnConfirma,
    blnGravou : Boolean;
    intSubStatus: Integer;
    blnAlterado: Boolean;
    blnConfOrc :Boolean;
    intQtdImp: Integer;
    blnImpOK : Boolean;
    strTpLayout: String;
    blnModeloAtivado: Boolean;
begin
  if not btnConfirmar.Visible then
    Exit;


  inherited;


  if fEhFluxoDadosOS and (not blnAlterarCondicao) and (tpImpressaoFlx = fpConsultar) then
  begin
    objConEqu.strNOSFab := edtNOSFab.Text;
    if objConEqu.fGravarNOSFab then
      fMensagem('AVISO', 'Ordem de serviço gravada com sucesso!', ['&OK']);
    Exit;
  end;

  FblnGravandoOS := True;
  try
    Try
      If (blnRotinaTecnico) Then
      Begin
        If Not fValidaCampos(edtNumero, False) Then
        Begin
          Exit;
        End;
      End;

      if (not fValidaItensServAParte) then
        Exit;

      blnAprovada := False;
      blnGravou   := False;
      btnCancelaItem.Click;

      if (not fVerificaAcessoriosInclusao) then
        Exit;

      if (not fValidaDocumentoEntrada) then
        Exit;

      blnConfirma := fValidaConfirmar;

      if blnConfirma and (not fValidaRealizaManAgPecas) then
        Exit;

      if blnConfirma and (not fValidaRealizaManAgSeparacao) then
        Exit;

      blnAlterado := objConEqu.fPodeModificarItensServicosDefeitos();

      If (Not blnAlterado) Then
        Exit;

      If (objConEqu.strStatus = 'A') Then
      Begin
        If (Not objConEqu.fPodeIncluirItemEspecial()) Then
          Exit;

        If (Not fEmptyStr(objConEqu.strNumPed)) And (objConEqu.fValidarEstoqueInsuficiente()) Then
          Exit;
      End;

      If blnConfirma Then
      Begin
        blnConfOrc := blnFinOrc AND (fCfgSis('CALTOS') = 'S');

        If not blnConfOrc Then
          blnConfOrc := (fMensagem('AVISO', 'Confirma gravação da ordem de serviço?', ['&Sim', '&Não']) = 1);

        If blnConfOrc Then
        Begin
          if fRequisicaoCompraVinculada then
            fProcessarRequisicaoCompra;

          pDefinirStatusAnt();

          If ((objConEqu.strStatus = 'E') And (fTemProdutoOuServicoInformado) And (Not fNovaOSFluxo)) Or
             (fEhAnaliseTecnica) Or (fEhEtapaOrcamento) Then
          Begin
            if (not blnFluxoProcesso) or ((blnFluxoProcesso) and (tpProcessoFlx <> tprDefPrdSer)) then
            begin
              blnConfOrc := blnFinOrc AND (fCfgSis('CALTOS') = 'S');

              if fPerguntaOrcamentoRealizado then
                If (not blnConfOrc) And
                   ((not ((fCfgSis('CALTOS') = 'S') and (objConEqu.strAutInc = ''))) or (fEhEtapaOrcamento))
                Then
                  blnConfOrc := (fMensagem('', 'Orçamento Realizado?' + #13#10 + '(Já foram inclusos todos os itens e serviços)', ['&Sim', '&Não'], 2 ) = 1);

              If blnConfOrc Then
              Begin
                objConEqu.strStatus := 'F';

                If (fCfgSis('CALTOS') = 'S') and (not blnFluxoProcesso) Then
                Begin
                  If (objConEqu.dtaIniOrc = 0) Or (objConEqu.hraIniOrc = 0) Or (fEmptyStr(objConEqu.opeIniOrc)) Then
                  Begin
                    fMensagem('AVISO', 'Ordem de serviço não teve o Orçamento Iniciado no [ALT+F6], portanto ' +
                      'não poderá ser finalizado o orçamento pelo [F10]. Verifique!', ['&OK']);

                    objConEqu.strStatus := 'E';
                  End
                  Else
                    objConEqu.pAtualizaInicioFimOperacoes(2, (not blnFinOrc));
                End;

                if (objConEqu.strStatus = 'F') then
                begin
                  objConEqu.strFlxFas := 'O';
                  objConEqu.strFlxSit := 'OR';

                  if objConEqu.fVerificaEstoqueItens then
                    objConEqu.strFlxCom := 'PF'
                  else
                    objConEqu.strFlxCom := 'AE';
                end;
              End;

              If (objConEqu.strStatus = 'E') Then
              Begin
                if (not blnFluxoProcesso) then
                begin
                  With objConEqu Do
                  Begin
                    intSubStatus := IIF(strSubSta = 'O', 1, IIF(strSubSta = 'P', 2, IIF(strSubSta = 'C', 3, 1)));
                    intSubStatus := fGetMenu('Status Aberto', arrSubStatusAberto, intSubStatus);

                    Case intSubStatus Of
                      1: strSubSta := 'O';
                      2: strSubSta := 'P';
                      3: strSubSta := 'C';
                    End;
                  End;

                  if (objConEqu.strFlxFas <> 'O') and (objConEqu.strFlxCom <> 'AO') then
                  begin
                    objConEqu.strFlxFas := 'T';
                    objConEqu.strFlxSit := 'TA';
                    objConEqu.strFlxCom := 'AT';
                  end;
                end;
              End;
            end;

            if fEhAnaliseTecnica then
            begin
              if fMensagem('', 'Deseja finalizar a análise técnica?', ['&Sim', '&Não'], 2 ) = 1 then
              begin
                objConEqu.strFlxFas := 'T';
                objConEqu.strFlxSit := 'TC';
                objConEqu.strFlxCom := 'AO';
              end
              else
              begin
                objConEqu.strFlxFas := 'T';
                objConEqu.strFlxSit := 'TA';
                objConEqu.strFlxCom := 'AT';
              end;
            end;
          End
          Else
          Begin
            if (fInclusaoOrdemServico) then
            begin
              objConEqu.strFlxFas := 'A';
              objConEqu.strFlxSit := 'OI';
              objConEqu.strFlxCom := 'AT';
            end;

            //SE NÃO HOUVER NENHUM PRODUTO OU SERVIÇO NA O.S., GRAVAR COMO ORÇAMENTO DIRETO
            If (objConEqu.strStatus <> 'A') And
               (objConEqu.strStatus <> 'R') And
               (objConEqu.strStatus <> 'N') And
               (objConEqu.strStatus <> 'M') And
               (objConEqu.cdsIteEqu.RecordCount = 0) And
               (objConEqu.cdsSerEqu.RecordCount = 0) Then
            Begin
              objConEqu.strStatus := 'E';
              objConEqu.strSubSta := 'O';
              objConEqu.strPrevis := DateToStr(Trunc(fNow()));

              if fEhAnaliseTecnica then
              begin
                objConEqu.strFlxFas := 'T';
                objConEqu.strFlxSit := 'TA';
                objConEqu.strFlxCom := 'AT';
              end;
            End;
          End;

          objConEqu.fltVlrCon := objConEqu.fltVlrPro + objConEqu.fltVlrSer +
                                 objConEqu.fltTotIpi + objConEqu.fltTotRet +
                                 IIF(fSomarNovosImpostosDaReformaAoValorContabil, objConEqu.fltTotCbs + objConEqu.fltTotIbs + objConEqu.fltTotIs, 0);

          objConEqu.strDtaEnt := DateToStr(VS_Date);
          objConEqu.strHorEnt := TimeToStr(fTime());

          If (objConEqu.strOperac = 'A') Then
          Begin
            if not fValidaCampos(edtSenDig, True) then
              Exit;

            objConEqu.pAlteraStatusDados(objConEqu.strStatus,
                                         objConEqu.strSubSta,
                                         '',
                                         blnAlterado,
                                         objConEqu.strRetPor,
                                         objConEqu.strOsPdCl,
                                         objConEqu.strReaPor,
                                         objConEqu.strReaTel);

            If (Not objConEqu.StatusDadosAlterado) Then
              Exit;
          End;

          If (objConEqu.strStatus = 'E') And
             ((objConEqu.cdsIteEqu.RecordCount > 0) Or (objConEqu.cdsSerEqu.RecordCount > 0)) Then
          Begin
            If fDataPrevisao And objConEqu.fGravaEquGer Then
            Begin
              fMensagem('', 'Ordem de Serviço Nº ' + objConEqu.strNumero + ' gravada com sucesso!', ['&O k']);
              strValidaEqu := 'N';
              blnGravou := True;
              if (not blnRotinaTecnico) and (not blnFluxoProcesso) then
              begin
                If (fMensagem('', 'Imprimir?', ['&Sim', '&Não']) = 1) Then
                  btnImprimir.Click;
              end
              else if (blnFluxoProcesso) and (fInclusaoOrdemServico) and (fCfgSis('TERCEQ', varBoolean)) and (Copy(strTERROS, 2, 1) = 'S') then
              begin
                if (fMensagem('', 'Imprimir Termo de Responsabilidade?', ['&Sim', '&Não']) = 1) then
                begin
                  intQtdImp := fGetMenu('Qtd. Vias', ['1 Via', '2 Vias', '3 Vias', '4 Vias'], 1);
                  blnImpOK := True;
                  pImprimirTermoResponsabilidade(intQtdImp, tpaNormal, strTpLayout, blnImpOK);

                  if (not blnImpOK) then
                    pMensagemOk('Layout ' + strTpLayout + ' não está configurado.');
                end;
              end;

              if (fCfgSis('IETQOS', varBoolean)) and (fInclusaoOrdemServico) then
              begin
                If (fMensagem('', 'Imprimir a etiqueta de identicação do equipamento?', ['&Sim', '&Não']) = 1) Then
                  pImprimirEtiqueta(objConEqu.strNumero);
              end;

              if blnFluxoProcesso then
                Close;
            End;
          End
          Else
          Begin
            If objConEqu.fGravaEquGer Then
            Begin
              fMensagem('', 'Ordem de Serviço Nº ' + objConEqu.strNumero + ' gravada com sucesso!', ['&O k']);
              strValidaEqu := 'N';
              blnGravou := True;
              if not blnFluxoProcesso then
              begin
                If (fMensagem('', 'Imprimir?', ['&Sim', '&Não']) = 1) Then
                  btnImprimir.Click;
              end
              else if (blnFluxoProcesso) and (fInclusaoOrdemServico) and (fCfgSis('TERCEQ', varBoolean)) and (Copy(strTERROS, 2, 1) = 'S') then
              begin
                if (fMensagem('', 'Imprimir Termo de Responsabilidade?', ['&Sim', '&Não']) = 1) then
                begin
                  intQtdImp := fGetMenu('Qtd. Vias', ['1 Via', '2 Vias', '3 Vias', '4 Vias'], 1);
                  blnImpOK := True;
                  pImprimirTermoResponsabilidade(intQtdImp, tpaNormal, strTpLayout, blnImpOK);

                  if (not blnImpOK) then
                    pMensagemOk('Layout ' + strTpLayout + ' não está configurado.');
                end;
              end;

              if (fCfgSis('IETQOS', varBoolean)) and (fInclusaoOrdemServico) then
              begin
                If (fMensagem('', 'Imprimir a etiqueta de identicação do equipamento?', ['&Sim', '&Não']) = 1) Then
                  pImprimirEtiqueta(objConEqu.strNumero);
              end;

              if (fInclusaoOrdemServico) then
                fDisparaSMSWhatsappAutOS(objConEqu.strNumero, objConEqu.strCodEmp, objConEqu.strCodCli, staIncluindo, blnModeloAtivado, True);

              if blnFluxoProcesso then
                Close;
            End;
          End;

          If Assigned(objMeqMerEnt) And (objConEqu.strOperac = 'I') Then
          Begin
            objMeqMerEnt.strAutEqu := objConEqu.strAutInc;
            objMeqMerEnt.strEmpEqu := objConEqu.strCodEmp;
            objMeqMerEnt.strNumOse := objConEqu.strNumero;

            TConEqu.fVinculaOSemNotaFiscal(objMeqMerEnt);
          End;

          If Assigned(objMeqMerSai) And (objConEqu.strOperac = 'I') Then
          Begin
            objMeqMerSai.strAutEqu := objConEqu.strAutInc;
            objMeqMerSai.strEmpEqu := objConEqu.strCodEmp;
            objMeqMerSai.strNumOse := objConEqu.strNumero;

            TConEqu.fVinculaOSemNotaFiscal(objMeqMerSai);
          End;

          If (objConEqu.strStatus = 'A') And (Not blnAlterado) Then
          Begin
            blnAprovada := True;
            If (objConEqu.strTemPed = 'S') Then
            Begin
              btnAprovada.Click;
            End;
          End;

          If blnGravou Then
          Begin
            objConEqu.pGravarLogSta(strLoginUsuarioLogado,
                                    objConEqu.strStaAnt,
                                    objConEqu.strStatus + objConEqu.strSubSta,
                                    objConEqu.strNumero,
                                    objConEqu.strCodDig);

            objConEqu.pGravarLogFlx(blnFLuxoProcesso);

            pGeraLogLiberacao(objConequ.strNumero, 'OS', objConEqu.strCodEmp);

            If (objConEqu.strOperac = 'A') And (blnAlterado) And
               (Not fEmptyStr(objConEqu.strNumPed)) And
               (objConEqu.strStatus <> 'N') Then
            Begin
              if (objConEqu.cdsDocGer.RecordCount > 1) then
                pMostraDocumentosGerados
              else
                pImprimePedidoSeparacao(True, True, True);

              pEnviarEmailPedOS();
            End;

            pLimpaTela;
          End;
        End;

      End
      Else
        btnCancelaItem.Click;

    Except
      On e:exception do
      Begin
        pMensagensErro(e.Message, 'btnConfirmarClick - untFatManConsertoEquip');
      End;
    End;
  finally
    FblnGravandoOS := False;
  end;
end;

procedure TfrmFatManConsertoEquip.btnConfirmarVariasClick(Sender: TObject);
var
  blnConfirma : Boolean;
  strOSGeradas: String;
  intPos      : Integer;
  frmFatGeracaoMultiplasOS: TfrmFatGeracaoMultiplasOS;
begin
  inherited;

  try
    if not btnConfirmarVarias.Visible then
      Exit;

    strOSGeradas := '';

    if not fValidaConfirmar then
      Exit;

    try
      pCriarFormularios(TfrmFatGeracaoMultiplasOS, frmFatGeracaoMultiplasOS);
      frmFatGeracaoMultiplasOS.objConEqu := objConEqu;
      frmFatGeracaoMultiplasOS.strMarca  := edtDesMar.Text;
      frmFatGeracaoMultiplasOS.ShowModal();

      blnConfirma := frmFatGeracaoMultiplasOS.blnConfirma;
    finally
      pFreeAndNil(frmFatGeracaoMultiplasOS);
    end;

    if (not blnConfirma) then
      Exit;

    objConEqu.cdsGerMOS.First;
    pDefinirStatusAnt();
    objConEqu.strFlxFas := 'A';
    objConEqu.strFlxSit := 'OI';
    objConEqu.strFlxCom := 'AT';

    while not objConEqu.cdsGerMOS.Eof do
    begin
      objConEqu.strNSerie := objConEqu.cdsGerMOS.FieldByName('NSERIE').AsString;
      objConEqu.strNumPat := objConEqu.cdsGerMOS.FieldByName('NUMPAT').AsString;
      objConEqu.strNumero := '';
      objConEqu.fltVlrCon := objConEqu.fltVlrPro + objConEqu.fltVlrSer +
                             objConEqu.fltTotIpi + objConEqu.fltTotRet +
                             IIF(fSomarNovosImpostosDaReformaAoValorContabil, objConEqu.fltTotCbs + objConEqu.fltTotIbs + objConEqu.fltTotIs, 0);

      objConEqu.strDtaEnt := DateToStr(VS_Date);
      objConEqu.strHorEnt := TimeToStr(fTime());

      if objConEqu.fGravaEquGer then
      begin
        strOSGeradas := strOSGeradas + ', ' + objConEqu.strNumero;

        objConEqu.pGravarLogSta(strLoginUsuarioLogado,
                                  objConEqu.strStaAnt,
                                  objConEqu.strStatus + objConEqu.strSubSta,
                                  objConEqu.strNumero,
                                  objConEqu.strCodDig);

        objConEqu.pGravarLogFlx(blnFLuxoProcesso);

        pGeraLogLiberacao(objConequ.strNumero, 'OS', objConEqu.strCodEmp);
      end
      else
        Break;

      objConEqu.cdsGerMOS.Next;
    end;

    if (not fEmptyStr(strOSGeradas)) then
    begin
      intPos := strOSGeradas.LastIndexOf(',');
      fMensagem('', 'Ordens de Serviço Nº ' + Copy(strOSGeradas, 3, intPos) + ' e ' + Copy(strOSGeradas, intPos + 3, 7) + ' gravadas com sucesso!', ['&O k']);
      Close;
    end;
  Except
    On e:exception do
    Begin
      pMensagensErro(e.Message, 'btnConfirmarVariasClick - untFatManConsertoEquip');
    End;
  End;
end;

procedure TfrmFatManConsertoEquip.btnEndEntClick(Sender: TObject);
begin
  inherited;
  If Not (fClienteConsumidor(fRetNomCliente(objConEqu.strCodCli), False, True)) then
  Begin
    If Not fEmptyStr(objEndEnt.recEndere.strIncrem) And
       Not fEmptyStr(objConEqu.strCodCli) Then
    Begin
      pOSToEndereco;
      objEndEnt.fAlteraEnderecoEntrega(True, objConEqu.strCodCli, True, True, True, True, btnConfirmar.Enabled);
      pEnderecoToOS;
    end;
  End;
end;

procedure TfrmFatManConsertoEquip.btnHisStaClick(Sender: TObject);
begin

  inherited;

  if fEmptyStr(edtNumero.Text) Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(181, 7446, [],
                        ['USADIG','NUMOSE','CODEMP'],
                        [IfThen(blnUsaDig,'S','N'),
                        edtNumero.Text,
                        IfThen(edtCodEmp.Visible,edtCodEmp.Text,VS_strCodEmp)],
                        Sender,
                        nil,
                        True);
  End;

End;

procedure TfrmFatManConsertoEquip.btnGridMostraOSClick(Sender: TObject);
begin
  inherited;

  if fEmptyStr(edtCodEqu.Text) Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(316, 10574, [],
                        ['CODEQU','CODEMP','CODCLI'],
                        [edtCodEqu.Text,
                        IfThen(edtCodEmp.Visible,edtCodEmp.Text,VS_strCodEmp),
                        edtCodCli.Text],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmFatManConsertoEquip.btnCancAprovacaoClick(Sender: TObject);
begin
  inherited;

  try
    if (not btnCancAprovacao.Enabled) then
      Exit;

    if (not fVerificaCampos()) then
      Exit;

    if (not (fVerificaPDFaturado in [tpBaixado, tpNaoFaturado])) then
    begin
      fMensagem('ATENÇÃO!','Não é possível cancelar a aprovação da O.S pois o pedido de Venda gerado desta O.S. Já foi faturado.', ['&Ok']);
      Exit;
    end;

    if (fMensagem('', 'Ao cancelar a aprovação, o pedido vinculado a esta O.S também será cancelado. Deseja continuar?', ['&Sim', '&Não']) = 2) then
      Exit;

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Liberação para cancelamento da Aprovação da Ordem de Serviço');
    objLiberacao.objMsgLibera.pAddSeparador(75);
    objLiberacao.objMsgLibera.pAddTextoCaption('OS'     , objConEqu.strNumero                                            , 7);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente', objConEqu.strCodCli + '-' + fRetNomCliente(objConEqu.strCodCli), 7);

    objLiberacao.strDirAce := 'OSCAPR';
    objLiberacao.blnManterCompatibilidadeSenCfg := not fEmptyStr(objLiberacao.strSenLib);
    objLiberacao.strMsgSen := 'Liberação para cancelamento da Aprovação da Ordem de Serviço';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    objLiberacao.pInformaNumDocEspDocCodEmp(
                      objConequ.strNumero,
                      'OS',
                      objConEqu.strCodEmp);

    if not objLiberacao.fLibera then
      Exit;

    pAlteraStatusAprovadaParaOrcamento;
    objConEqu.pGravarLogFlx(blnFLuxoProcesso);

    fMensagem('ATENÇÃO!','Cancelamento da Aprovação efetuado com sucesso.', ['&Ok']);
    pLimpaTela;
  except
    on E: Exception do
      pMensagensErro(e.Message, 'btnCancAprovacaoClick - untFatManConsertoEquip');
  end;
end;

procedure TfrmFatManConsertoEquip.btnCancelaAceClick(Sender: TObject);
begin
  inherited;
  blnAltAcessorio := False;
  edtDesAce.Clear;
  edtCodAce.Clear;
  edtQtdAce.Text := FormatFloat(fMskDigitos(intDecQtde), 1);
  edtCodAce.Enabled := True;
  pSetFocus(edtCodAce);
end;

procedure TfrmFatManConsertoEquip.edtCodAceKeyPress(Sender: TObject; var Key: Char);
var
  arrAce   : TConsultasArray;
  objfrmPnl: TPanelCxAcessorio;
  sltAcesAntesPesquisa: TStringList;

  function fAceAddPorTabPelaPrimeiraVez: Boolean;
     Var
       strCodAce: String;
  begin
    strCodAce := QuotedStr(objConEqu.cdsAceEqu.FieldByName('CODACE').AsString);
    Result := (Not fEstaNaLista(sltAcesAntesPesquisa, strCodAce)) And
              (fEstaNaLista(sltAce, strCodAce));
  end;
begin
  inherited;

  {*******************************}
  {* NOVA CONSULTA DE ACESSÓRIOS *}
  {****************************DH*}
  Try
    objfrmPnl := TPanelCxAcessorio.Create(TfrmPnlDadosAcessorio);
    sltAcesAntesPesquisa := TStringList.Create;

    sltAcesAntesPesquisa.Text := sltAce.Text;
    objFrmPnl.sltLista        := sltAce;
    objFrmPnl.fncTeclaTab     := fInserirAcessorio;
    objFrmPnl.strNomForm      := Self.Name;

    If fPesqAcessorios(Self, edtCodAce, edtDesAce, Nil, Key, arrAce, True, objFrmPnl) Then
    Begin
      If fAceAddPorTabPelaPrimeiraVez Then
      Begin
        btnCancelaAce.Click;
      End
      Else
      Begin
        If fValidaCampos(edtCodAce, True) Then
          SelectNext(ActiveControl, True, True);
      End;
    End;
  Finally
    FreeAndNil(objFrmPnl);
    FreeAndNil(sltAcesAntesPesquisa);
  End;
end;

procedure TfrmFatManConsertoEquip.edtCodCliEnter(Sender: TObject);
begin
  inherited;
  If (not blnRotinaTecnico) Then
  Begin
    pnlInfo.Caption := 'INSERT para fazer um novo cadastro';
  End;
end;

procedure TfrmFatManConsertoEquip.edtCodCliExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtCodCli.Text) Then
  Begin
    If (fValidaCampos(edtCodCli, True)) Then
    Begin
      pCarregaCliente;
      fInicializarFatVenda;
    End;
  End
  Else
  Begin
    edtNomCli.Clear;
    edtFone01.Clear;
    edtCelula.Clear;
    edtEmail_.Clear;

    objConEqu.strCodCli:='';
    objConEqu.strCliNom:='';
  End;
  pnlInfo.Caption := '';
end;

procedure TfrmFatManConsertoEquip.edtSenVenExit(Sender: TObject);
begin
  inherited;

  If (Not fEmptyStr(edtSenVen.Text)) Then
  Begin
    If (Not edtSenDig.Visible) Then
    Begin
      edtNomVen.Text := fRetNomVendedor(edtSenVen.Text);
    End
    Else
    Begin
      edtNomVen.Text := fRetNomVendRep(edtSenVen.Text);
    End;
  End;
end;

procedure TfrmFatManConsertoEquip.edtSenVenKeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;

  if (not blnUsaDig) Then
    Exit;

  if fEntraCons(Key) then
  begin
    if (Not edtSenVen.ReadOnly) And
     (fPesqOperador(Self, edtSenVen, edtNomVen, qryConOpe, Key, arrSel)) then
    begin
        If fValidaCampos(edtSenVen, True) Then
          SelectNext(ActiveControl, True, True);
    end;
  end;
end;

procedure TfrmFatManConsertoEquip.dbgGridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
  var
    strStaAtu: String;
begin
  inherited;
  Case Key Of
    VK_DELETE : pExcluirProduto();

    VK_RETURN : pCarregarProduto();

    VK_ESCAPE : pEscapePressed;

    VK_F3 :
    Begin
      If (pnlAg_pec.Visible) And (Not objConEqu.cdsIteEqu.IsEmpty) And (objConEqu.strOperac = 'A') Then
      Begin
        WIth objConEqu.cdsIteEqu Do
        Begin
          strStaAtu := Fieldbyname('AGUARD').AsString;

          objConEqu.pAlteraStatusPeca(Fieldbyname('CODITE').AsString, IfThen(strStaAtu = 'N', 'S', 'N'));

          Edit;
          FieldByName('AGUARD').AsString := IfThen(strStaAtu = 'N', 'S', 'N');
          Post;

          If strStaAtu = 'N' Then
          Begin
            chkAg_Mon.Checked := False;
            objConEqu.blnAg_Mon := chkAg_Mon.Checked;
            objConEqu.pAlteraStatusAguardandoMontagem;
          End;
        End;

        dbgGrid.Refresh;
        pAtualizaDados(Nil);
      End;
    End;
  End;

  if (Shift = [ssCtrl]) And (char(Key) = 'C') then
  begin
    if (dbgGrid.SelectedField.FieldName = 'CODFAB') or (dbgGrid.SelectedField.FieldName = 'REFERE') then
      Clipboard.AsText := dbgGrid.SelectedField.Value;
  end;
end;

procedure TfrmFatManConsertoEquip.dbgGridMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  intPosCOPCFB,
  intPosCOPREF,
  intPosABRSAL: Integer;
begin
  inherited;

  intPosCOPCFB := fFindColumnByName(dbgGrid, 'COPCFB').Index + 1;
  intPosCOPREF := fFindColumnByName(dbgGrid, 'COPREF').Index + 1;
  intPosABRSAL := fFindColumnByName(dbgGrid, 'ABRSAL').Index + 1;

  if (dbgGrid.MouseCoord(X, Y).X in [intPosCOPCFB]) then
  begin
    dbgGrid.ShowHint := True;
    dbgGrid.Hint := 'Copiar código de fábrica';
  end
  else
  if (dbgGrid.MouseCoord(X, Y).X in [intPosCOPREF]) then
  begin
    dbgGrid.ShowHint := True;
    dbgGrid.Hint := 'Copiar referência';
  end
  else if (dbgGrid.MouseCoord(X, Y).X in [intPosABRSAL]) then
  begin
    dbgGrid.ShowHint := True;
    dbgGrid.Hint := 'Exibir Estoque do Item';
  end
  else
    dbgGrid.ShowHint := False;
end;

procedure TfrmFatManConsertoEquip.dbgGridAceDblClick(Sender: TObject);
begin
  inherited;
  pAlterarAcessorio;
end;

procedure TfrmFatManConsertoEquip.dbgGridAceKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_DELETE : pExcluirAcessorio();
    VK_RETURN : pAlterarAcessorio;
    VK_ESCAPE : pEscapePressed;
  End;
end;

procedure TfrmFatManConsertoEquip.dbgGridDblClick(Sender: TObject);
begin
  inherited;

  pCarregarProduto();
end;

procedure TfrmFatManConsertoEquip.dbgGridDfeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_DELETE : pExcluirDefeito();

    VK_ESCAPE : pEscapePressed;
  End;
end;

procedure TfrmFatManConsertoEquip.dbgServicoDblClick(Sender: TObject);
begin
  inherited;

  pAlterarServico();
end;

procedure TfrmFatManConsertoEquip.dbgServicoDrawColumnCell(Sender: TObject;
  const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  If (Column.FieldName = 'BRINDE') Then
  Begin
    dbgServico.Canvas.Font.Color  := clBlack;

    If (Column.Field.AsString = 'S') Then
    Begin
      dbgServico.Canvas.Brush.Color := clYellow;
      dbgServico.Canvas.FillRect(Rect);
      dbgServico.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'SIM');
    End
    Else
    Begin
      dbgServico.Canvas.Brush.Color := clWhite;
      dbgServico.Canvas.FillRect(Rect);
      dbgServico.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'NAO');
    End;
  End;

  if (Column.FieldName = 'COBAPA') Then
  begin
    dbgServico.Canvas.Font.Color  := clBlack;
    dbgServico.Canvas.FillRect(Rect);

    if (Column.Field.AsString = 'S') then
      dbgServico.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'SIM')
    else if (Column.Field.AsString = 'N') then
      dbgServico.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'NÃO');
  end;;

  if (Column.FieldName = 'TIPBRI') Then
  begin
    dbgServico.Canvas.Font.Color  := clBlack;
    dbgServico.Canvas.FillRect(Rect);

    if (Column.Field.AsString = 'G') then
      dbgServico.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'Garantia')
    else if (Column.Field.AsString = 'C') then
      dbgServico.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'Cortesia')
    else if (Column.Field.AsString = 'R') then
      dbgServico.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'Revisão')
    else if (Column.Field.AsString = 'M') then
      dbgServico.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'Montagem')
    else if (Column.Field.AsString = 'L') then
      dbgServico.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'Locação');
  end;
end;

procedure TfrmFatManConsertoEquip.dbgServicoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_DELETE : pExcluirServico();

    VK_RETURN : pAlterarServico();

    VK_ESCAPE : pEscapePressed;
  End;
end;

procedure TfrmFatManConsertoEquip.pCarregaEnderecoEntrega(strTabela,
  strAutInc: String; blnAltEnd: Boolean);
  Var
    qryEntCli: TUniQuery;
Begin
  qryEntCli := fCriaQuery(Self);
  With qryEntCli Do
  Begin
    SQL.Text := objEndEnt.fCarregaEnderecoEntrega(strTabela);

    ParamByName('CODCLI').AsString := edtCodCli.Text;

    If Params.FindParam('AUTINC') <> Nil Then
      ParamByName('AUTINC').AsString := strAutInc;

    Open;

    If IsEmpty Then
    Begin
      If blnAltEnd Then
      Begin
        FillChar(objEndEnt.recEndere, SizeOf(objEndEnt.recEndere), #0);
      End;

    End
    Else
    Begin
      If blnAltEnd Then
      Begin
        With objEndEnt.recEndere Do
        Begin
          strCodCli := edtCodCli.Text;
          strCliAnt := edtCodCli.Text;
          strIncrem := FieldByName('AUTOINCREM').AsString;
          strEndEnt := FieldByName('ETC_ENDENT').AsString;
          strBaiEnt := FieldByName('ETC_BAIENT').AsString;
          strCepEnt := FieldByName('ETC_CEPENT').AsString;
          strCidEnt := FieldByName('ETC_CIDENT').AsString;
          strCodCid := FieldByName('ETC_CIDENT').AsString;
          strNomCid := fRetNomCidade(FieldByName('ETC_CIDENT').AsString, 0);          
          strEstEnt := fRetNomCidade(FieldByName('ETC_CIDENT').AsString, 1);
          strTelEnt := FieldByName('ETC_TELENT').AsString;
          strRefEnt := FieldByName('ETC_REFENT').AsString;
          strCobIss := FieldByName('ETC_COBISS').AsString;          
          strCodObr := FieldByName('ETC_CODOBR').AsString;
          strCodArt := FieldByName('ETC_CODART').AsString;
          strCodCno := FieldByName('ETC_CODCNO').AsString;
          strInsImo := FieldByName('ETC_INSIMO').AsString;
          strCodCib := FieldByName('ETC_CODCIB').AsString;
        End;

      End;
    End;

  End;
  FreeAndNil(qryEntCli);

end;

procedure TfrmFatManConsertoEquip.pCarregaEquipamento;
begin
  pPesquisaCadEqu(qryCadEqu, qryCadEqu, edtCodEqu.Text);
  With qryCadEqu Do
  Begin
    edtDesEqu.Text := FieldByName('EQU_DESCRI').AsString;
    edtDesMar.Text := fRetNomMarca(FieldByName('EQU_CODMAR').AsString);
    edtVoltag.Text := FieldByName('EQU_VOLTAG').AsString;
  End;
end;

procedure TfrmFatManConsertoEquip.pCarregaEstProduto;
const
  strSQL: String = 'SELECT EPR_CODEPR, EPR_DESCRI FROM CADEPR ORDER BY EPR_DESCRI';
var
  qryEstPrd: TUniQuery;
begin
  qryEstPrd := fCriaQuery;
  try
    qryEstPrd.Close;
    qryEstPrd.SQL.Text := strSQL;
    qryEstPrd.Open;

    cbEstPrd.Items.Clear;

    while not qryEstPrd.Eof do
    begin
      cbEstPrd.Items.Add(qryEstPrd.FieldByName('EPR_DESCRI').AsString);

      qryEstPrd.Next;
    end;
  finally
    FreeAndNil(qryEstPrd);
  end;
end;

procedure TfrmFatManConsertoEquip.pCarregaEstrutura(strCodIte:String; fltQtdIte:Double; fltTotIte: Double = 0);
var
  intItem: Integer;
  objItensEstrutura: TItensEstrutura;
  subItem: TSubItemEstrutura;
begin
  objItensEstrutura := TItensEstrutura.Create;

  try
    try
      if objEmitirPedido.objFatVenda.fCalculaPrecoEstrutura(False,
                                                            Preco_de_Venda,
                                                            strCodIte,
                                                            IIF(pnlEmpIte.Visible and (not fEmptyStr(edtEmpIte.Text)), edtEmpIte.Text, VS_strCodEmp),
                                                            'S',
                                                            IIF(cbTabPrecoItem.Visible, cbTabPrecoItem.Text, ''),
                                                            0,
                                                            fltQtdIte,
                                                            objItensEstrutura) > 0 then
      begin
        if fltTotIte > 0 then
          objItensEstrutura.pAcertarPrecos(fltTotIte);

        pgbProgresso.Max := objItensEstrutura.ItemsCount;

        for intItem := 0 to objItensEstrutura.ItemsCount -1 do
        begin
          subItem := objItensEstrutura[intItem];

          pgbProgresso.Position := Succ(intItem);

          edtCodIte.Text := subItem.strCodigo;
          edtQtdIte.Text := FloatToStr(subItem.fltQtdTot);

          pPesquisaCadSem(qryCadIte, qryCadIte, edtCodIte.Text, '');
          pCarregaItem(False, False, True, subItem.fltQtdTot);
          edtUnitar.Text := FloatToStrF(subItem.fltPreVen, ffFixed, 12, fCfgSis('DECUNI', varInteger));

          if (not fVerificaCampos) then
            Exit
          else
            pAdicionaItem;

          pLimpaDadosItem;
        end
      end;
    except
      on e:exception do
      begin
        pMensagensErro(e.Message, 'pCarregaEstrutura');
      end;
    end;
  finally
    FreeAndNil(objItensEstrutura);
  end;
end;

procedure TfrmFatManConsertoEquip.pCarregaImagem;
begin
  if (Not fEmptyStr(objConEqu.strAutInc)) Then
  Begin
    imgEqu.Picture := nil;
    Application.ProcessMessages;

    Case fCarregaImagemConsertoEquip(objConEqu.strAutInc, imgEqu.Picture) of
      riOk   :
      Begin
        imgEqu.Visible := True;
        lblErrImg.Visible := False;
      End;
      riErro :
      Begin
        imgEqu.Visible := False;
        lblErrImg.Visible := True;
      End;
      riNulo :
      Begin
        imgEqu.Visible := False;
        lblErrImg.Visible := False;
      End;
    End;
  End
  Else
    imgEqu.Picture := nil;

  Application.ProcessMessages;
end;

procedure TfrmFatManConsertoEquip.pCarregaItem(blnBuscaPorChave,
                                               blnAtualizaEdits:Boolean;
                                               blnRepesquisa: Boolean = False;
                                               fltQtdItemEstrutura: Double = 0;
                                               fltPreSub: Double = 1);
Var
  strSQL            : String;
  strCodIte         : String;
  chkey             : char;
  qryIteger         : TUniQuery;
  fltSalRes         : Double;
  blnItemEspecial   : Boolean;
  strCamTbl         : String;
  fltValPromocAtual : Double;
  blnAplicarTaxaJuros : Boolean;

  fltDesF07: Double;
  fltPreCus: Double;
  fltComVar: Double;
  fltComAta: Double;
  fltComDis: Double;
  fltQtdDis: Double;
  blnParticiona: Boolean;
  blnPromo: Boolean;
  strComPro: String;
  strCodPro: String;
begin
  If (blnRepesquisa And ((rdbCodFab.Checked) And (qryCadIte.RecordCount > 1))) Then
  Begin
    chkey     := '/';
    strCodIte := edtCodIte.Text;
    edtCodIte.Clear;

    utcRegistros.fRetRegistro(self.Name + 'CADITE');
    utcRegistros.pLimparCampos;

    If Not fedtCodIteKeyPressGer(edtCodIte,chKey,strCodIte) Then
    Begin
      pSetFocus(edtCodIte);
      Exit;
    End;

    utcRegistros.pLimparCampos;
  End;

  If (qryCadIte.IsEmpty) Or
    ((qryCadIte.Active) And (edtCodIte.Text <> qryCadIte.FieldByName('ITE_CODITE').AsString)) Then
    pPesquisaCadSem(qryCadIte, qryCadIte, edtCodIte.Text, '', False,
                        blnBuscarCodFab And rdbCodFab.Checked, '', False, not objConEqu.blnMulLoj);

  blnItemEspecial:= (Pos('ITEM ESPECIAL', qryCadIte.FieldByName('ITE_DESITE').AsString) > 0);

  If (blnItemEspecial) Then
  Begin
    edtDesIte.ReadOnly := False;
    edtDesIte.TabStop  := TRUE;
    edtUnidad.ReadOnly := False;
    edtUnidad.TabStop  := TRUE;
  End
  Else
  Begin
    edtDesIte.ReadOnly := True;
    edtDesIte.TabStop  := FALSE;
    edtUnidad.ReadOnly := True;
    edtUnidad.TabStop  := FALSE;
  End;

  edtCodIte.Text := qryCadIte.FieldByName('ITE_CODITE').AsString;
  edtUnidad.Text := qryCadIte.FieldByName('UNI_SIGUNI').AsString;

  if blnAtualizaEdits then
    edtDesIte.Text := qryCadIte.FieldByName('ITE_DESITE').AsString;

  pControlaDigitacaoValoresFracionados(qryCadIte.FieldByName('ITE_CODUNI').AsString);

  If (fltQtdItemEstrutura > 0) Then
  Begin
    edtQtdIte.Text     := FormatFloat(edtQtdIte.EditFormat, fltQtdItemEstrutura);
    edtTotIte.Text     := '0,00';
  End;

  objConEqu.strCodIte := edtCodIte.Text;

  case cmbEntRet.ItemIndex of
    IDX_RETIRA: objConEqu.strEntRet := 'R';
    IDX_ENTREGA: objConEqu.strEntRet := 'E';
  end;

  if pnlLocRet.Visible then
    objConEqu.strLocRet := fRetSiglaLocalRetira(cmbLocRet.Text);

  if blnAtualizaEdits then
    objConEqu.strDesite := qryCadIte.FieldByName('ITE_DESITE').AsString;

  objConEqu.strDesMar := fRetNomeMarca(qryCadIte.FieldByName('ITE_CODMAR').AsString);
  objConEqu.strRefere := qryCadIte.FieldByName('ITE_REFERE').AsString;
  objConEqu.strUnidad := qryCadIte.FieldByName('UNI_SIGUNI').AsString;
  objConEqu.strCodUni := qryCadIte.FieldByName('ITE_CODUNI').AsString;
  objConEqu.strLocFis := fRetNomLocFisicaByIte(qryCadIte.FieldByName('ITE_CODITE').AsString);
  objConEqu.blnIteEsp := blnItemEspecial;

  qryIteger := fCriaQuery;

  Try
    strCamTbl := fVerificarTabPre();

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   ITE_PRECUS, ';
    strSQL := strSQL + '   ITE_PRE' + strCamTbl + ' AS ITE_PREVEN, ';
    strSQL := strSQL + '   ITE_SALDOS  ';
    strSQL := strSQL + ' FROM ITEGER ';
    strSQL := strSQL + ' WHERE ITE_CODITE = :CODITE ';
    strSQL := strSQL + '   AND ITE_CODEMP = :CODEMP ';

    qryIteger.Close;
    qryIteger.SQL.Clear;
    qryIteger.SQL.Add(strSQL);
    qryIteger.ParamByName('CODITE').AsString := qryCadIte.FieldByName('ITE_CODITE').AsString;
    qryIteger.ParamByName('CODEMP').AsString := IIF(pnlEmpIte.Visible and (not fEmptyStr(edtEmpIte.Text)), edtEmpIte.Text, VS_strCodEmp);
    qryIteger.Open;

    {Promoção}
    if (fRetornaPrecosPromocao(qryCadIte.FieldByName('ITE_CODITE').AsString,
                               edtCodCli.Text,
                               VS_Date,
                               IIF(fStrToFloat(edtQtdIte.Text) > 0, fStrToFloat(edtQtdIte.Text), 1),
                               0,
                               0,
                               0,
                               fltPreCus,
                               fltValPromocAtual,
                               fltComVar,
                               fltComAta,
                               fltComDis,
                               fltQtdDis,
                               fltDesF07,
                               strComPro,
                               strCodPro,
                               blnParticiona,
                               blnPromo,
                               objConEqu.strTabPreIte,
                               '',
                               '',
                               '',
                               True,

                               False,
                               '-1',
                               False,
                               False,
                               '',
                               '',
                               '',
                               '',
                               nil,
                               False)) then
    begin
      If (fltPreCus <= 0) Then
        fltPreCus := qryIteger.FieldByName('ITE_PRECUS').AsFloat;

      objConEqu.fltUniVis := fltValPromocAtual;
      objConEqu.fltTotCus := fltPreCus;
      objConEqu.strPromoc := 'S';
    end
    Else
      objConEqu.strPromoc := 'N';

    if (not qryIteger.IsEmpty) then
    Begin
      if (objConEqu.strPromoc = 'N') then
      begin
        if (qryIteger.FieldByName('ITE_PREVEN').AsFloat <= 0) then
        begin
          fMensagem('', 'Esse produto está com o preço de venda Zerado!' + #13#10 + 'Favor corrigir.', ['&Ok']);
          Exit;
        end;

        objConEqu.fltUniVis := IIF(fCfgSis('RATEST', varString) = 'C', fFormataFloatInterna(qryIteger.FieldByName('ITE_PREVEN').AsFloat * fltPreSub, 2), qryIteger.FieldByName('ITE_PREVEN').AsFloat);
        objConEqu.fltTotCus := qryIteger.FieldByName('ITE_PRECUS').asFloat;
        objConEqu.strPromoc := 'N';
      end;

      objConEqu.fltTaxJur := fRetTaxJur;
      objConEqu.fltPerDes := fRetPerDes;

      objConEqu.fltUniOri := objConEqu.fltUniVis + ( objConEqu.fltUniVis * fRetTaxJur / 100);
      objConEqu.fltUnitar := objConEqu.fltUniOri - (objConEqu.fltUniOri * objConEqu.fltPerDes / 100);
      edtUnitar.Text := FormatFloat(fMskDigitos(intDecimal), objConEqu.fltUnitar);

      fltSalRes := TSaldoReservado.New(
                     TReservaParametros.New()
                       .EmpresaItem(IIF(pnlEmpIte.Visible and (not fEmptyStr(edtEmpIte.Text)), edtEmpIte.Text, VS_strCodEmp))
                       .CodigoItem(objConEqu.strCodIte)
                       .CodEmpresa(VS_strCodEmp)
                       .NumeroDocumento(objConEqu.strNumPed)
                       .TipoFiltroDocumento(IIF(fEmptyStr(objConEqu.strNumPed), tfdTodos, tfdIgnorarDocumento))
                     ).fGetQuantidade();

      objConEqu.fltSaldos    := qryIteger.FieldByName('ITE_SALDOS').AsFloat - fltSalRes;

      If fUsaQtdPendenteEntregaFutura Then
        objConEqu.fltSaldos := objConEqu.fltSaldos + TEntregaFutura.New(
                                                       TParamEF.New()
                                                         .CodIte(qryCadIte.FieldByName('ITE_CODITE').AsString)
                                                         .CodEmp(IIF(pnlEmpIte.Visible and (not fEmptyStr(edtEmpIte.Text)), edtEmpIte.Text, VS_strCodEmp))
                                                         .Faturamento(True)
                                                       ).Total();

      objConEqu.fltSal_OS    := objConEqu.fltSaldos;
    End;

    if (not fItemEstrutura(edtCodIte.Text)) then
      Exit;

    {
      CFG_EQUPER = 1 - Valor original do produto
      CFG_EQUPER = 2 - Soma os itens estrutura do produto
      **  P - NÃO (Carrega Sempre Sub-Produtos)  **
    }
    If fCfgSis('CAREST', varString) <> 'P' Then
    Begin
      if (not blnCarItem) and (fCfgSis('EQUPER', varString) = '2') Then
      Begin
        blnAplicarTaxaJuros := (fatVenda.fAplicaTaxaJuros And fAplicarTaxaJurosPrecoSugestao);
        edtUnitar.Text := FormatFloat(fMskDigitos(0),
                                      fatVenda.fCalculaPrecoEstrutura(blnAplicarTaxaJuros,
                                                                      Preco_de_Venda,
                                                                      edtCodIte.Text,
                                                                      IIF(pnlEmpIte.Visible and (not fEmptyStr(edtEmpIte.Text)), edtEmpIte.Text, VS_strCodEmp),
                                                                      'S',
                                                                      IIF(cbTabPreco.Visible,cbTabPreco.Text,''),
                                                                      0));
        //Preço unitario sugerido sem juros
        fatVenda.fltUniVis := fStrToFloat(edtUnitar.Text);
        fatVenda.fltTaxJur := 0.00;

        If blnAplicarTaxaJuros Then
        Begin
          fatVenda.fltTaxJur := fatVenda.fGetTaxVprItem(edtCodIte.Text);
          edtUnitar.Text := FormatFloat(fMskDigitos(fatVenda.VS_intDecUni), fatVenda.fltUniVis + fFormataFloat(fatVenda.fltUniVis * (fatVenda.fGetTaxVprItem(edtCodIte.Text) / 100.0), 04));
        End;
      End;
    End
    Else if (fCfgSis('EQUPER', varString) = '2') and
            (fatVenda.stlItensNaoEhEstrutura.IndexOf(edtCodIte.Text) = -1) and
            (fItemEstrutura(edtCodIte.Text)) then
    begin
      blnAplicarTaxaJuros := (fatVenda.fAplicaTaxaJuros And fAplicarTaxaJurosPrecoSugestao);
      edtUnitar.Text := FormatFloat(fMskDigitos(fatVenda.VS_intDecUni),
                                    fatVenda.fCalculaPrecoEstrutura(blnAplicarTaxaJuros,
                                                                    Preco_de_Venda,
                                                                    edtCodIte.Text,
                                                                    IIF(pnlEmpIte.Visible and (not fEmptyStr(edtEmpIte.Text)), edtEmpIte.Text, VS_strCodEmp),
                                                                    'S',
                                                                    IIF(cbTabPrecoItem.Visible,cbTabPrecoItem.Text,IIF(cbTabPreco.Visible,cbTabPreco.Text,'')),
                                                                    fStrToFloat('0')));
      //Preço unitario sugerido sem juros
      fatVenda.fltUniVis := fStrToFloat(edtUnitar.Text);
      fatVenda.fltTaxJur := 0.00;

      If blnAplicarTaxaJuros Then
      Begin
        fatVenda.fltTaxJur := fatVenda.fGetTaxVprItem(edtCodIte.Text);
        edtUnitar.Text := FormatFloat(fMskDigitos(fatVenda.VS_intDecUni), fatVenda.fltUniVis + fFormataFloat(fatVenda.fltUniVis * (fatVenda.fGetTaxVprItem(edtCodIte.Text) / 100.0), 04));
      End;
    end;
  Finally
    FreeAndNil(qryIteger);
  End;
end;

function TfrmFatManConsertoEquip.fRetPerDes(strCodCnd: String = ''):Double;
var
  qryConCndLocal: TUniQuery;
begin
  Result := 0.0;

  if fEmptyStr(strCodCnd) then
  begin
    If Not Assigned(qryConCnd) Then
      Exit;

    If Not(qryConCnd.Active) Then
      Exit;

    qryConCndLocal := qryConCnd;
  end
  else
  begin
    qryConCndLocal := fCriaQuery;
    pPesquisaCadCnd(qryConCndLocal, qryConCndLocal, strCodCnd);
  end;

  Result := IIF(qryConCndLocal.FieldByName('CND_ABADES').AsString = 'S', qryConCndLocal.FieldByName('CND_DESMAX').AsFloat, 0);

  if not fEmptyStr(strCodCnd) then
    FreeAndNil(qryConCndLocal);
end;

function TfrmFatManConsertoEquip.fRetTaxJur(strCodCnd: String = ''; strConPag: String = ''):Double;
var
  qryConCndLocal: TUniQuery;
  fltMediaPagto: Double;
Begin
    Result := 0.0;

  if fEmptyStr(strCodCnd) then
  begin
    If Not Assigned(qryConCnd) Then
      Exit;

    If Not(qryConCnd.Active) Then
      Exit;

    qryConCndLocal := qryConCnd;
  end
  else
  begin
    qryConCndLocal := fCriaQuery;
    pPesquisaCadCnd(qryConCndLocal, qryConCndLocal, strCodCnd);
  end;

  fltMediaPagto := fCalcMediaPagto(IIF(fEmptyStr(strConPag), mskCndPag.Text, strConPag));

  If qryConCndLocal.FieldByName('CND_TXJURO').AsFloat > 0 Then
     Result := fFormataFloat((qryConCndLocal.FieldByName('CND_TXJURO').AsFloat / 30) * fltMediaPagto ,2)
  Else If fCalcMediaPagto(mskCndPag.Text) > fCfgSis('DIATAX', varInteger) Then
  Begin
    If fCfgSis('TAXAPL') = 'I' Then
      Result := fFormataFloat((fCfgSis('TAXJUR', varDouble) / 30) * fltMediaPagto ,2)
    Else
      Result := fFormataFloat((fCfgSis('TAXJUR', varDouble) / 30) * (fltMediaPagto - fCfgSis('DIATAX', varInteger)) ,2);
  End;

  if not fEmptyStr(strCodCnd) then
    FreeAndNil(qryConCndLocal);
End;

function TfrmFatManConsertoEquip.fRetTotIte: Real;
var
  fltTotal : Real;
begin

  fltTotal := 0;

  try

    objConEqu.cdsIteEqu.DisableControls;

    objConEqu.cdsIteEqu.First;
    while not objConEqu.cdsIteEqu.Eof do
    begin
      fltTotal := fltTotal + objConEqu.cdsIteEqu.fieldbyname('TOTITE').AsFloat;
      objConEqu.cdsIteEqu.Next;
    end;

  finally
    objConEqu.cdsIteEqu.EnableControls;
  end;

  Result := fltTotal;

end;

function TfrmFatManConsertoEquip.fSaidaImpressao: String;
begin
  Result := 'I';

  if (fMensagem('', 'Saída', ['&Video', '&Imprimir']) = 1) then
    Result := 'V';
end;

function TfrmFatManConsertoEquip.fSelecionarFazendaCliente(ACodCli: String; AAltFazenda: Boolean = False): Boolean;
begin
  if (not fEmptyStr(objConEqu.objFazenda.strCodCli)) and (objConEqu.objFazenda.strCodCli <> ACodCli) then
    objConEqu.strCodFaz := '';

  objConEqu.objFazenda.strCodCli := ACodCli;

  if objConEqu.objFazenda.fClientePossuiFazendas and fCfgSis('CADFAZ', varBoolean) then
  begin
    if (not fEmptyStr(objConEqu.strCodFaz)) and (not AAltFazenda) Then
    begin
      objConEqu.objFazenda.strCodFaz := objConEqu.strCodFaz;
      objConEqu.objFazenda.pCarregarDadosFazenda;

      Result := (not fEmptyStr(objConEqu.objFazenda.strNomFaz));
    end
    else
      Result := objConEqu.objFazenda.fSelecionarFazenda;

    if Result then
      objConEqu.strCodFaz := objConEqu.objFazenda.strCodFaz
    else
    begin
      objConEqu.strCodFaz := '';
      objConEqu.objFazenda.pLimparDadosFazenda;
    end;
  end
  else
  begin
    Result := True;
    objConEqu.objFazenda.pLimparDadosFazenda;
  end;
end;

function TfrmFatManConsertoEquip.fSituacaoCancelarManutencao: String;
begin
  Result := 'EM';

  if fAguardandoPecas then
    Result := 'AP'
  else if fCfgSis('FLXSEP', varBoolean) and (fEmptyStr(objConEqu.strOpBxSe)) and (objConEqu.cdsIteEqu.RecordCount > 0) then
    Result := 'AS';
end;

function TfrmFatManConsertoEquip.fTemProdutoOuServicoInformado: Boolean;
begin
  Result := True;

  If (objConEqu.cdsIteEqu.RecordCount > 0) Then
    Exit;

  If (objConEqu.cdsSerEqu.RecordCount > 0) Then
    Exit;

  Result := False;
end;

function TfrmFatManConsertoEquip.fTravaDebitosAtraso(blnDevCli: Boolean = False): Boolean;
var
  blnVerificarTrava: Boolean;
begin
  Result := False;

  if (blnDevCli) and (fCfgSis('ATMEEQ', varString) = 'N') then
    Exit;

  blnVerificarTrava := (objEmitirPedido.objFatVenda.fCfgSisTraMax('PD') <> 'N') or
    ((blnDevCli) and (fCfgSis('ATMEEQ', varString) <> 'N'));

  If (Not objEmitirPedido.objFatVenda.blnCliFil) And
     (blnVerificarTrava) And
     (Not fClienteConsumidor(fRetNomCliente(edtCodCli.Text), True, True)) And
     (Not objEmitirPedido.objFatVenda.fDebitoCliente('', '', 4)) Then
  begin
    objLiberacao.Clear;

    If fCfgSis('CLIATR', varBoolean) Then
    Begin
      If (fCfgSis('TRFTCR', varString) = '2') And (fCampoTabela('CLI_CODRED', 'CADCLI', ['CLI_CODCLI'], [edtCodCli.Text]) <> '') Then
        objLiberacao.objMsgLibera.pAddTexto('A rede de lojas desse cliente possui débito(s) em atraso!')
      Else If objEmitirPedido.objFatVenda.fRetAtrasoMaxCliente(edtCodCli.Text) > 0 Then
      begin
        objLiberacao.objMsgLibera.pAddTexto('Esse cliente possui débito(s) em atraso há mais de ' + IntToStr(objEmitirPedido.objFatVenda.fRetAtrasoMaxCliente(edtCodCli.Text)) + ' dias!');
        TDuplicataAtrasoFaturamento.fCarregaMensagemLiberacao(edtCodCli.Text, objLiberacao.objMsgLibera);
      end
      Else
        objLiberacao.objMsgLibera.pAddTexto('Este cliente possui débitos em atraso!');
    End
    Else
    Begin
      If (fCfgSis('TRFTCR', varString) = '2') And (fCampoTabela('CLI_CODRED', 'CADCLI', ['CLI_CODCLI'], [edtCodCli.Text]) <> '') Then
        objLiberacao.objMsgLibera.pAddTexto('A rede de lojas desse cliente possui débito(s) em atraso!')
      Else If fCfgSis('ATRMAX', varInteger) > 0 Then
      begin
        objLiberacao.objMsgLibera.pAddTexto('Esse cliente possui débito(s) em atraso há mais de ' + IntToStr(fCfgSis('ATRMAX', varInteger)) + ' dias!');
        TDuplicataAtrasoFaturamento.fCarregaMensagemLiberacao(edtCodCli.Text, objLiberacao.objMsgLibera);
      end
      Else
        objLiberacao.objMsgLibera.pAddTexto('Este cliente possui débitos em atraso!');
    End;

    objLiberacao.strDirAce := 'DEATR';

    if (not blnDevCli) then
      objLiberacao.blnTraTel := (objEmitirPedido.objFatVenda.fCfgSisTraMax('PD') = 'T')
    else
      objLiberacao.blnTraTel := (fCfgSis('ATMEEQ', varString) = 'T');

    objLiberacao.strSenLib := fCfgSis('SENMAX');
    objLiberacao.strMsgSen := 'Débito em Atraso';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCliente := (edtCodCli.Text + '-' + fRetNomCliente(edtCodCli.Text));

    objLiberacao.pInformaNumDocEspDocCodEmp(
                      objConequ.strNumero,
                      'OS',
                      objConEqu.strCodEmp);

    If Not (objEmitirPedido.objFatVenda.fFatMensagemLiberacao(objLiberacao)) Then
      Result := True;
  end;
end;

function TfrmFatManConsertoEquip.fTravaERegistraStlManEquLck(strNumOse, strCodEmp: String): Boolean;
  Var
    strAux: String;
begin
  Result := False;

  if blnNegociacao then
    Exit;

  strAux := fRetornaChaveLckManEqu(strNumOse, strCodEmp);

  If Not fLock_Unlock(strAux, True, False) Then
  Begin
    fMensagem('Atenção', 'Esta O.S. está sendo alterada em outra estação - ' + fGetHostLock(strAux) +'.' +
                        #13 + 'Aguarde a liberação da O.S. para dar continuidade!', ['&OK']);

    Result := True;
  End
  Else
    stlManEquAltLck.Add(strAux);
end;

function TfrmFatManConsertoEquip.fTravaLimiteCredito(blnIgnorarCndPag: Boolean = False): Boolean;
begin
  Result := False;

  If (blnVerificaLimiteCredito) And
     (fFormataFloat(objConEqu.fltVlrCon, 2) > 0) And
     (fCfgSis('TRALCS', varBoolean)) And (strVERLME <> 'N') And
     (Not fClienteConsumidor(fRetNomCliente(edtCodCli.Text), True, True)) And
     (blnIgnorarCndPag or ((pnlCndPag.Visible) And (fStatusCndPag(mskCndPag.Text) = A_PRAZO))) And
     (Not fVerificaLimiteCreditoCliente(edtCodCli.Text)) Then
  Begin
    If (strVERLME = 'T') Then
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('A T E N C A O - Esse cliente está com limite de crédito negativo!');

      objLiberacao.strDirAce := 'LIMCR';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strMsgSen := 'Esse cliente está com limite de crédito negativo';
      objLiberacao.strCliente := edtCodCli.Text + ' - ' + edtNomCli.Text;
      objLiberacao.strSenFvu := fCfgSis('EQUFVU');

      objLiberacao.pInformaNumDocEspDocCodEmp(
                        objConequ.strNumero,
                        'OS',
                        objConEqu.strCodEmp);

      if (Not objLiberacao.fLibera) then
        Result := True;
    End
    Else If (strVERLME = 'A') Then
    Begin
      fMensagem('A T E N C A O', 'Esse cliente está com limite de crédito negativo!', ['&OK']);
    End;

    If Not Result Then
      blnVerificaLimiteCredito := False;
  End;
end;

function TfrmFatManConsertoEquip.fTravaOSSemProdServ: Boolean;
  Var
    strStatus: String;
begin
  Result := ( (objConEqu.strStatus = 'A') Or (objConEqu.strStatus = 'M') Or (objConEqu.strStatus = 'R') ) And
            ( (objConEqu.cdsIteEqu.RecordCount = 0) And (objConEqu.cdsSerEqu.RecordCount = 0) );

  If (objConEqu.strStatus = 'A') Then
    strStatus := QuotedStr('Aprovada')
  Else If (objConEqu.strStatus = 'M') Then
    strStatus := QuotedStr('Em Manutenção')
  Else If (objConEqu.strStatus = 'R') Then
    strStatus := QuotedStr('Realizada');

  If (Result) Then
    fMensagem('ATENÇÃO!', 'O.S. com status ' + strStatus + ' deve possuir ao menos 1 produto ou 1 serviço. Verifique!' , ['&Ok']);
end;

function TfrmFatManConsertoEquip.fTravaTermoDevolucao: Boolean;
begin
  Result := True;

  if (not blnFluxoProcesso) then
    Exit;

  if (objConEqu.strFlxFas <> 'A') and (objConEqu.strFlxFas <> 'T') then
    Exit;

  if (fMensagem('', 'A OS ainda não tem orçamento realizado. Deseja realmente continuar com a impressão do Termo de Devolução?', ['&Sim', '&Não']) = 2) then
    Exit(False);

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Impressão de Termo de Devolução antes de Realizar o Orçamento.');
  objLiberacao.objMsgLibera.pAddTextoCaption('OS'     , objConEqu.strNumero + '-' + objConEqu.strCodEmp                , 7);
  objLiberacao.objMsgLibera.pAddTextoCaption('Cliente', objConEqu.strCodCli + '-' + fRetNomCliente(objConEqu.strCodCli), 7);

  objLiberacao.strDirAce := 'FXITDO';
  objLiberacao.strMsgSen := 'Impressão de Termo de Devolução antes de Realizar o Orçamento';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;

  objLiberacao.pInformaNumDocEspDocCodEmp(
                    objConequ.strNumero,
                    'OS',
                    objConEqu.strCodEmp);

  if (Not objLiberacao.fLibera) then
    Exit(False);
end;

procedure TfrmFatManConsertoEquip.pCarregaItemAlteracao;
Begin

  If (Not objConEqu.cdsIteEqu.Active) Or (objConEqu.cdsIteEqu.IsEmpty) Then
    Exit;

  edtCodIte.Text := objConEqu.cdsIteEqu.fieldbyname('CODITE').AsString;

  If (objConEqu.cdsIteEqu.Fieldbyname('ENTRET').AsString = 'E') Then
    cmbEntRet.ItemIndex := IDX_ENTREGA
  Else If (objConEqu.cdsIteEqu.Fieldbyname('ENTRET').AsString = 'R') Then
    cmbEntRet.ItemIndex := IDX_RETIRA;

  pHabilitaLocRet;

  if (not fEmptyStr(objConEqu.cdsIteEqu.Fieldbyname('LOCRET').AsString)) then
    cmbLocRet.ItemIndex := fRetIndexLocalRetira(objConEqu.cdsIteEqu.Fieldbyname('LOCRET').AsString, cmbLocRet.Items);

  edtDesIte.Text := objConEqu.cdsIteEqu.fieldbyname('DESITE').AsString;
  edtUnidad.Text := objConEqu.cdsIteEqu.fieldbyname('UNIDAD').AsString;
  edtQtdIte.Text := FormatFloat(fMskDigitos(intDecQtde), objConEqu.cdsIteEqu.fieldbyname('QTDITE').AsFloat);
  edtUnitar.Text := FormatFloat(fMskDigitos(intDecimal), objConEqu.cdsIteEqu.fieldbyname('UNITAR').AsFloat);
  edtTotIte.Text := FormatFloat(fMskDigitos(intDecimal), objConEqu.cdsIteEqu.fieldbyname('TOTITE').AsFloat);
  edtEmpIte.Text := objConEqu.cdsIteEqu.fieldbyname('EMPITE').AsString;

  if fCfgSis('NOMEMP') = '2' then
    edtDesEmpIte.Text := fRetFantasiaEmpresa(edtEmpIte.Text)
  else
    edtDesEmpIte.Text := fRetNomeEmpresaSelec(edtEmpIte.Text);

  If (Not fEmptyStr(objConEqu.cdsIteEqu.Fieldbyname('TABPRE').AsString)) Then
    cbTabPrecoItem.ItemIndex := cbTabPrecoItem.Items.IndexOf(objConEqu.cdsIteEqu.Fieldbyname('TABPRE').AsString)
  Else
  begin
    if (strSugEqu <> '0') then
      cbTabPrecoItem.ItemIndex := cbTabPrecoItem.Items.IndexOf(strSugEqu)
    else
      cbTabPrecoItem.ItemIndex := 0;
  end;

  objConEqu.strCodIte := objConEqu.cdsIteEqu.Fieldbyname('CODITE').AsString;
  objConEqu.strEntRet := objConEqu.cdsIteEqu.Fieldbyname('ENTRET').AsString;
  objConEqu.strLocRet := objConEqu.cdsIteEqu.Fieldbyname('LOCRET').AsString;
  objConEqu.strDesIte := objConEqu.cdsIteEqu.Fieldbyname('DESITE').AsString;
  objConEqu.strUnidad := objConEqu.cdsIteEqu.Fieldbyname('UNIDAD').AsString;
  objConEqu.strCodUni := objConEqu.cdsIteEqu.Fieldbyname('CODUNI').AsString;
  objConEqu.strRefere := objConEqu.cdsIteEqu.Fieldbyname('REFERE').AsString;
  objConEqu.strCodFab := objConEqu.cdsIteEqu.Fieldbyname('CODFAB').AsString;
  objConEqu.fltUniOri := objConEqu.cdsIteEqu.Fieldbyname('UNIORI').AsFloat;
  objConEqu.fltUniVis := objConEqu.cdsIteEqu.Fieldbyname('UNIVIS').AsFloat;
  objConEqu.fltTaxJur := objConEqu.cdsIteEqu.Fieldbyname('TAXJUR').AsFloat;
  objConEqu.fltPerDes := objConEqu.cdsIteEqu.Fieldbyname('PERDES').AsFloat;
  objConEqu.fltTotCus := objConEqu.cdsIteEqu.Fieldbyname('TOTCUS').AsFloat/objConEqu.cdsIteEqu.fieldbyname('QTDITE').AsFloat;
  objConEqu.fltSaldos := objConEqu.cdsIteEqu.Fieldbyname('SALDOS').AsFloat;
  objConEqu.fltSal_OS := objConEqu.cdsIteEqu.Fieldbyname('SAL_OS').AsFloat;

  objConEqu.strBrinde := objConEqu.cdsIteEqu.Fieldbyname('BRINDE').AsString;
  objConEqu.strCodPar := objConEqu.cdsIteEqu.Fieldbyname('CODPAR').AsString;
  objConEqu.strTipBri := objConEqu.cdsIteEqu.Fieldbyname('TIPBRI').AsString;
  objConEqu.strCobAPaIte := objConEqu.cdsIteEqu.Fieldbyname('COBAPA').AsString;
  objConEqu.strEmpIte := objConEqu.cdsIteEqu.Fieldbyname('EMPITE').AsString;
  objConEqu.strPromoc := objConEqu.cdsIteEqu.FieldByName('PROMOC').AsString;

  If (Not fEmptyStr(objConEqu.cdsIteEqu.Fieldbyname('TABPRE').AsString)) Then
    objConEqu.strTabPreIte := objConEqu.cdsIteEqu.Fieldbyname('TABPRE').AsString;

  chkBrindePro.Checked := objConEqu.cdsIteEqu.FieldByName('BRINDE').AsString = 'S';
  chkCobAPa.Checked    := objConEqu.cdsIteEqu.FieldByName('COBAPA').AsString = 'S';

  objConEqu.strAtiCom := objConEqu.cdsIteEqu.FieldByName('EMPITE').AsString;
  objConEqu.blnIteEsp := objConEqu.cdsIteEqu.FieldByName('ITEESP').AsString = 'S';

  edtCodIte.Enabled := False;

  If fIsItemEspecial(objConEqu.cdsIteEqu.fieldbyname('CODITE').AsString) Then
  Begin
    edtDesIte.ReadOnly := False;
    edtDesIte.TabStop  := TRUE;
    edtUnidad.ReadOnly := False;
    edtUnidad.TabStop  := TRUE;
  End
  Else
  Begin
    edtDesIte.ReadOnly := True;
    edtDesIte.TabStop  := FALSE;
    edtUnidad.ReadOnly := True;
    edtUnidad.TabStop  := FALSE;
  End;

  pControlaDigitacaoValoresFracionados(objConEqu.strCodUni);
End;


procedure TfrmFatManConsertoEquip.pCarregaOSAnterior;
var
  blnEncont: Boolean;
  strNOSAnt: String;
  dtaDtEAnt,
  dtaDtRAnt: TDateTime;
begin
  If (fEmptyStr(edtCodCli.Text)) or (fEmptyStr(edtCodEqu.Text)) Then
    Exit;

  strNOSAnt := objConEqu.strNOSAnt;
  dtaDtEAnt := objConEqu.dtaDtEAnt;
  dtaDtRAnt := objConEqu.dtaDtRAnt;

  objConEqu.strNOSAnt := '';
  objConEqu.dtaDtEAnt := 0;
  objConEqu.dtaDtRAnt := 0;

  blnEncont := False;

  if (not fEmptyStr(edtNSerie.Text)) and (Copy(strCOSAnt, 1, 1) = 'S') then
    blnEncont := objConEqu.fCarregaOSAnt(edtCodEqu.Text, 'NSERIE', edtNSerie.Text, edtNumero.Text);

  if (not blnEncont) and (not fEmptyStr(edtNumPat.Text)) and (Copy(strCOSAnt, 2, 1) = 'S') then
    blnEncont := objConEqu.fCarregaOSAnt(edtCodEqu.Text, 'NUMPAT', edtNumPat.Text, edtNumero.Text);

  if (not blnEncont) and (not fEmptyStr(edtDadFab.Text)) and (Copy(strCOSAnt, 3, 1) = 'S') then
    objConEqu.fCarregaOSAnt(edtCodEqu.Text, 'DADFAB', edtDadFab.Text, edtNumero.Text);

  if (not fEmptyStr(edtNumero.Text)) and (fEmptyStr(objConEqu.strNOSAnt)) then
  begin
    objConEqu.strNOSAnt := strNOSAnt;
    objConEqu.dtaDtEAnt := dtaDtEAnt;
    objConEqu.dtaDtRAnt := dtaDtRAnt;
  end;

  pAtualizaCamposOSAnterior;
end;

procedure TfrmFatManConsertoEquip.pCarregarAcessorio;
begin
  objConEqu.strUltOpe := objConEqu.strOperac;
  objConEqu.strOperac := 'G';

  edtCodAce.Enabled := False;
  edtDesAce.Enabled := False;
  edtQtdAce.Enabled := False;

  btnCancelaAce.Enabled   := False;
  btnAdicionarAce.Enabled := False;

  edtCodAce.Text := objConEqu.cdsAceEqu.FieldByName('CODACE').AsString;
  edtDesAce.Text := objConEqu.cdsAceEqu.FieldByName('DESACE').AsString;
  edtQtdAce.Text := FormatFloat(fMskDigitos(intDecQtde), objConEqu.cdsAceEqu.fieldbyname('QTDACE').AsFloat);

  pSetFocus(edtCodAce);
end;

procedure TfrmFatManConsertoEquip.pCarregarDefeito;
begin
  objConEqu.strUltOpe := objConEqu.strOperac;
  objConEqu.strOperac := 'G';

  edtCodDfe.Enabled := False;
  edtDesDfe.Enabled := False;

  btnCancelaDfe.Enabled   := False;
  btnAdicionarDfe.Enabled := False;

  edtCodDfe.Text := objConEqu.cdsDfeEqu.FieldByName('CODDFE').AsString;
  edtDesDfe.Text := objConEqu.cdsDfeEqu.FieldByName('DESDFE').AsString;

  pSetFocus(edtCodDfe);
end;

procedure TfrmFatManConsertoEquip.pCarregaRepres;
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtCodRep.Text);

  With qryConOpe Do
  Begin
    edtDesRep.Text := FieldByName('OPE_NOMOPE').AsString;

    If (edtCodRep.Visible) Then
      objConEqu.strCodVe2 := FieldByName('OPE_CODOPE').AsString;
  End;
end;

procedure TfrmFatManConsertoEquip.pCarregarItensNotaEntradaXML;
  Var
    i: Integer;
    qryMovDet: TUniQuery;
    arrItensEnt: TItensNotaEntradaRemessa;
begin
  If (Not Assigned(objMeqMerEnt)) Then
    objMeqMerEnt := TConEqu.fRetDadosMeqMer('', objConEqu.strCodEmp, objConEqu.strNumero, 'E');

  objMeqMerEnt.intIdxIteSel := -1;
  SetLength(arrItensEnt, 0);

  If (Not fEmptyStr(objMeqMerEnt.strChaveAcesso)) Then
  Begin
    Try
      qryMovDet := fCriaQuery(Self);

      qryMovDet.Close();
      qryMovDet.SQL.Clear();
      qryMovDet.SQL.Text := 'SELECT DISTINCT ' +
                            '  MOVDET.AUTOINCREM AS AUTINC, ' +
                            '  CONCAT( ' +
                            '    MOVDET.DET_DESCRI, ' +
                            '    " (QTDE.: ", ' +
                            '    CAST(FORMAT(MOVDET.DET_QTDITE, 2) AS CHAR), ' +
                            '    ") (NCM: ", ' +
                            '    IFNULL(DETELE.I05_NCM, ""), ' +
                            '    ")" ' +
                            '  ) AS DESCRI, ' +
                            '  IFNULL(DETELE.I05_NCM, "") AS NCMITE ' +
                            'FROM ' +
                            '  MOVDET ' +
                            '  LEFT JOIN GERELE ' +
                            '    ON GER_DOCENT = DET_NUMDOC ' +
                            '    AND GER_ESPENT = DET_ESPDOC ' +
                            '    AND GER_EMPENT = DET_CODEMP ' +
                            '  LEFT JOIN DETELE ' +                        {Req.: 104849, amarração entre descrições!}
                            '    ON DETELE.DET_SEQGER = GERELE.AUTOINCREM AND LOCATE(MOVDET.DET_DESCRI, DETELE.I04_XPROD ) ' +
                            'WHERE MOVDET.DET_SEQGER = :SEQGER ' +
                            'GROUP BY MOVDET.AUTOINCREM ' +
                            'ORDER BY MOVDET.DET_DESCRI ';
      qryMovDet.ParamByName('SEQGER').AsString := objMeqMerEnt.strAutGer;
      qryMovDet.Open();

      If (Not qryMovDet.IsEmpty) Then
      Begin
        SetLength(arrItensEnt, qryMovDet.RecordCount);
        qryMovDet.First();

        While (Not qryMovDet.Eof) Do
        Begin
          arrItensEnt[qryMovDet.RecNo - 1].intIndex  := qryMovDet.RecNo - 1;
          arrItensEnt[qryMovDet.RecNo - 1].strAutInc := qryMovDet.FieldByName('AUTINC').AsString;
          arrItensEnt[qryMovDet.RecNo - 1].strDescri := qryMovDet.FieldByName('DESCRI').AsString;
          arrItensEnt[qryMovDet.RecNo - 1].strNcmIte := qryMovDet.FieldByName('NCMITE').AsString;

          If (arrItensEnt[qryMovDet.RecNo - 1].strAutInc = objMeqMerEnt.strAutDet) Then
            objMeqMerEnt.intIdxIteSel := arrItensEnt[qryMovDet.RecNo - 1].intIndex;

          qryMovDet.Next();
        End;

        cmbEquEnt.Clear();

        For i := 0 To Length(arrItensEnt) - 1 Do
          cmbEquEnt.Items.Add(arrItensEnt[i].strDescri);

        cmbEquEnt.ItemIndex := objMeqMerEnt.intIdxIteSel;

        objMeqMerEnt.arrItensEnt := arrItensEnt;
      End;
    Finally
      FreeAndNil(qryMovDet);
    End;
  End;
end;

procedure TfrmFatManConsertoEquip.pCarregarListasConsulta;
begin
  sltDfe.Clear();

  If (Assigned(objConEqu.cdsDfeEqu)) And (Not objConEqu.cdsDfeEqu.isEmpty) Then
  Begin
    objConEqu.cdsDfeEqu.First();

    While (Not objConEqu.cdsDfeEqu.Eof) Do
    Begin
      pIncluiNaListaConsulta('CODDFE', 'DFE_CODIGO', sltDfe, objConEqu.cdsDfeEqu, cdsConsultaDfe);
      objConEqu.cdsDfeEqu.Next();
    End;
  End;

  sltItems.Clear();

  If (Assigned(objConEqu.cdsIteEqu)) And (Not objConEqu.cdsIteEqu.isEmpty) Then
  Begin
    objConEqu.cdsIteEqu.First();

    While (Not objConEqu.cdsIteEqu.Eof) Do
    Begin
      pIncluiNaListaConsulta('CODITE', 'ITE_CODITE', sltItems, objConEqu.cdsIteEqu, cdsConsultaItem);
      objConEqu.cdsIteEqu.Next();
    End;
  End;

  sltServ.Clear();

  If (Assigned(objConEqu.cdsSerEqu)) And (Not objConEqu.cdsSerEqu.isEmpty) Then
  Begin
    objConEqu.cdsSerEqu.First();

    While (Not objConEqu.cdsSerEqu.Eof) Do
    Begin
      pIncluiNaListaConsulta('CODSER', 'SER_CODSER', sltServ, objConEqu.cdsSerEqu, cdsConsultaServ);
      objConEqu.cdsSerEqu.Next();
    End;
  End;

  sltAce.Clear();

  If (Assigned(objConEqu.cdsAceEqu)) And (Not objConEqu.cdsAceEqu.isEmpty) Then
  Begin
    objConEqu.cdsAceEqu.First();

    While (Not objConEqu.cdsAceEqu.Eof) Do
    Begin
      pIncluiNaListaConsulta('CODACE', 'ACE_CODACE', sltAce, objConEqu.cdsAceEqu, cdsConsultaAce);
      objConEqu.cdsAceEqu.Next();
    End;
  End;
end;

procedure TfrmFatManConsertoEquip.pCarregarNomeCliente;
var
  qryCli: TUniQuery;
begin
  edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
  If Not fEmptyStr(objConEqu.strCliNom) And fClienteConsumidor(fRetNomCliente(edtCodCli.Text), False, True) Then
    edtNomCli.Text := objConEqu.strCliNom;

  qryCli := fCriaQuery();
  try
    qryCli.SQL.Add('SELECT CLI_FONE01, CLI_EMAIL_, CLI_CELULA');
    qryCli.SQL.Add('FROM CADCLI');
    qryCli.SQL.Add('WHERE CLI_CODCLI = :CODCLI');
    qryCli.ParamByName('CODCLI').AsString := edtCodCli.Text;
    qryCli.Open;

    edtFone01.Text := fFormataFone(qryCli.FieldByName('CLI_FONE01').AsString);
    edtCelula.Text := fFormataFone(qryCli.FieldByName('CLI_CELULA').AsString);
    edtEmail_.Text  := qryCli.FieldByName('CLI_EMAIL_').AsString;
  finally
    FreeAndNil(qryCli);
  end;

end;

procedure TfrmFatManConsertoEquip.pCarregarProduto;
begin
  objConEqu.strUltOpe := objConEqu.strOperac;
  objConEqu.strOperac := 'G';
  pCarregaItemAlteracao;

  If edtDesIte.CanFocus Then
    pSetFocus(edtDesIte)
  Else
    pSetFocus(edtQtdIte);
end;

procedure TfrmFatManConsertoEquip.pCarregaServicoAlteracao;
begin
  If (Not objConEqu.cdsSerEqu.Active) Or
     (objConEqu.cdsSerEqu.IsEmpty)    Then
  Begin
    Exit;
  End;

  strCodSerOld := objConEqu.cdsSerEqu.fieldbyname('CODSER').AsString;
  fltValSerOld := objConEqu.cdsSerEqu.fieldbyname('VALSER').AsFloat;

  edtCodSe1.Text    := objConEqu.cdsSerEqu.fieldbyname('CODSER').AsString;
  edtDesSe1.Text    := objConEqu.cdsSerEqu.fieldbyname('DESSER').AsString;
  edtCodTecSe1.Text := objConEqu.cdsSerEqu.fieldbyname('TECSER').AsString;
  edtDesTecSe1.Text := fRetNomeOperador(objConEqu.cdsSerEqu.fieldbyname('TECSER').AsString);
  edtValSe1.Text    := objConEqu.cdsSerEqu.fieldbyname('VALUNI').AsString;
  edtQtdSe1.Text    := objConEqu.cdsSerEqu.fieldbyname('QTDSER').AsString;

  objConEqu.strCodSer := objConEqu.cdsSerEqu.fieldbyname('CODSER').AsString;
  objConEqu.strDesSer := objConEqu.cdsSerEqu.fieldbyname('DESSER').AsString;
  objConEqu.fltValSer := objConEqu.cdsSerEqu.fieldbyname('VALSER').AsFloat;
  objConEqu.fltPorDes := objConEqu.cdsSerEqu.fieldbyname('PORDES').AsFloat;
  objConEqu.fltValUni := objConEqu.cdsSerEqu.fieldbyname('VALUNI').AsFloat;
  objConEqu.strTecSer := objConEqu.cdsSerEqu.fieldbyname('TECSER').AsString;
  objConEqu.fltQtdSer := objConEqu.cdsSerEqu.fieldbyname('QTDSER').AsFloat;

  objConEqu.strBrinde := objConEqu.cdsSerEqu.Fieldbyname('BRINDE').AsString;
  objConEqu.strCodPar := objConEqu.cdsSerEqu.Fieldbyname('CODPAR').AsString;
  objConEqu.strTipBri := objConEqu.cdsSerEqu.Fieldbyname('TIPBRI').AsString;
  objConEqu.strCobAPaSer := objConEqu.cdsSerEqu.Fieldbyname('COBAPA').AsString;

  chkBrindeSer.Checked := objConEqu.cdsSerEqu.FieldByName('BRINDE').AsString = 'S';
  chkCobAPaSer.Checked := objConEqu.cdsSerEqu.FieldByName('COBAPA').AsString = 'S';

  objConEqu.fltDesEspSer := objConEqu.cdsSerEqu.fieldbyname('DESESP').AsFloat;

  edtCodSe1.Enabled := False;
end;

procedure TfrmFatManConsertoEquip.pCarregaVendedor;
  Var
    blnBuscarPorSenha: Boolean;
begin
  blnBuscarPorSenha := (Not blnUsaDig);

  pPesquisaCadOpe(qryConOpe, qryConOpe, edtSenVen.Text, blnBuscarPorSenha);

  With qryConOpe Do
  Begin
    edtNomVen.Text := FieldByName('OPE_NOMOPE').AsString;
    objConEqu.strCodVen := FieldByName('OPE_CODOPE').AsString;
  End;
end;

procedure TfrmFatManConsertoEquip.btnApontHorasClick(Sender: TObject);
var
  frmFatManApontamentoHoras: TfrmFatManApontamentoHoras;
begin
  inherited;

  if (not fEmptyStr(edtNumero.Text)) and (btnApontHoras.Visible) and (btnApontHoras.Enabled) Then
  begin
    try
      pCriarFormularios(TfrmFatManApontamentoHoras, frmFatManApontamentoHoras);
      frmFatManApontamentoHoras.objConEquOS := objConEqu;
      frmFatManApontamentoHoras.ShowModal;
    finally
      pFreeAndNil(frmFatManApontamentoHoras);
    end;

    objConEqu.pCarregaApontamentos;
    objConEqu.pCarregaGridApo;
  end;
end;

procedure TfrmFatManConsertoEquip.btnAprovadaClick(Sender: TObject);
Var
  strCodMre,
  strTmpOperac : String;
  intSubStatus : Integer;
  blnSair      : Boolean;
  strNegNro    : String;
  blnGarResSal : Boolean;
  blnAprovar   : Boolean;
  frmFatManReservaEstoque: TfrmFatManReservaEstoque;
  frmConsertoEquipAprovacao: TfrmConsertoEquipAprovacao;

  function fRetTextoMensagem: String;
  begin
    If (fCfgSis('BONPED', varBoolean)) Then
      Result := 'Confirma Status ' + arrSubStatusAprova[intSubStatus] + ' para Ordem de Serviço?'
    Else
      Result := 'Confirma Status ' + arrSubStatusAltMot[intSubStatus] + ' para Ordem de Serviço?';
  end;

begin

  inherited;

  FblnGravandoOS := True;
  try
    Try
      objConEqu.blnResSal := True;
      blnGarResSal        := False;
      blnAprovacao        := True;
      blnAprovar          := blnNegociacao;

      If (Not fVerificarPedFat_OsRealizada()) Then
        Exit;

      If (objConEqu.strStatus = 'A') And (Not fPodeAlterarOS) Then
        Exit;

      If (Not objConEqu.fPodeIncluirItemEspecial()) Then
        Exit;

      If (Not fVerificaCampos()) Then
        Exit;

      If (not blnFluxoProcesso) and (not blnNegociacao) and (Not fValidaCampos(cbEstPrd)) then
        Exit;

      If (objConEqu.fValidarEstoqueInsuficiente()) Then
        Exit;

      If (Not objConEqu.fVerificaValidade()) Then
        Exit;

      If (Not objConEqu.fVerificaLoteItens(VS_strCodEmp)) Then
        Exit;

      If (Not fInicializarFatVenda()) Then
      Begin
        fMensagem('ATENÇÃO', 'Houve um problema na geração dos dados de impostos, verifique. Operação cancelada!', ['&OK']);
        Exit;
      End;

      If chkVenPre.Checked Then
        If Not fValidarRegraUFVendaPresencial() Then
          Exit;

      strNegNro := objConEqu.fVerificaExisteNegociacao;

      if (not fEmptyStr(strNegNro)) then
      begin
        fMensagem('ATENÇÃO', 'Existe uma negociação em aberto para esta OS. Portanto, é preciso primeiro finalizar a negociação ou excluir a OS dela para depois aprovar. ' +
                  ' Número da negociação: ' + strNegNro, ['&Ok']);
        Exit;
      end;

      With objConEqu Do
      Begin
        pDefinirStatusAnt();

        If Not blnAprovada Then
        Begin

          blnSair := False;

          if (not blnNegociacao) then
          begin
            Try
              pCriarFormularios(TfrmConsertoEquipAprovacao, frmConsertoEquipAprovacao);
              frmConsertoEquipAprovacao.blnAprova   := (Not (strStatus = 'A'));
              frmConsertoEquipAprovacao.strAprPor   := strRetPor;
              frmConsertoEquipAprovacao.strNumPed   := strOsPdCl;
              frmConsertoEquipAprovacao.strGarant   := objConEqu.strGarant;
              frmConsertoEquipAprovacao.objfatVenda := objEmitirPedido.objFatVenda;
              frmConsertoEquipAprovacao.blnFluPro   := blnFluxoProcesso;
              frmConsertoEquipAprovacao.blnTipAprEsp:= blnFluxoProcesso and (not fCfgSis('PETAPR', varBoolean));
              frmConsertoEquipAprovacao.objConEqu   := objConEqu;
              frmConsertoEquipAprovacao.strCodCli   := edtCodCli.Text;
              frmConsertoEquipAprovacao.ShowModal();

              strRetPor := frmConsertoEquipAprovacao.strAprPor;
              strOsPdCl := frmConsertoEquipAprovacao.strNumPed;
              intSubStatus := frmConsertoEquipAprovacao.intTipApr;

              If fCfgSis('FATSSA', varBoolean) Then
                strEmpFatSemSaldo := frmConsertoEquipAprovacao.edtCodEmpFat.Text;

              Case intSubStatus Of
                1: strSubSta := 'C';
                2: strSubSta := 'G';
                3: strSubSta := 'B';
                Else blnSair := True;
              End;

              strTipApr := strSubSta;

              if (blnFluxoProcesso) and blnUsaDig and (not blnSair) then
              begin
                strCodDig      := frmConsertoEquipAprovacao.strCodOpe;
                edtSenDig.Text := frmConsertoEquipAprovacao.strSenDig;
              end;
            Finally
              FreeAndNil(frmConsertoEquipAprovacao);
            End;
          end
          else
          begin
            strRetPor := FstrAprPor;
            strOsPdCl := FstrOsPdCl;
            strSubSta := FstrSubSta;

            If fCfgSis('FATSSA', varBoolean) Then
              strEmpFatSemSaldo := FstrEmpFatSemSaldo;

            if (blnUsaDig) then
            begin
              strCodDig      := FstrCodDig;
              edtSenDig.Text := FstrSenDig;
            end;

            cdsIteNeg.Filtered := False;
            cdsIteNeg.Filter   := 'SEQGER=' + QuotedStr(strAutInc);
            cdsIteNeg.Filtered := True;

            cdsIteNeg.First;

            while not cdsIteNeg.Eof do
            begin
              if cdsIteEqu.Locate('AUTINC', cdsIteNeg.FieldByName('AUTINC').AsString, []) then
              begin
                cdsIteEqu.Edit;
                cdsIteEqu.FieldByName('NUMCMP').AsString  := cdsIteNeg.FieldByName('NUMCMP').AsString;
                cdsIteEqu.FieldByName('NITCMP').AsInteger := cdsIteNeg.FieldByName('NITCMP').AsInteger;
                cdsIteEqu.FieldByName('DTACMP').AsDateTime:= cdsIteNeg.FieldByName('DTACMP').AsDateTime;
                cdsIteEqu.Post;
              end;

              cdsIteNeg.Next;
            end;
          end;

          if not blnSair then
            blnSair := (Not fConfirmaDadosOS(True));

          If (Not blnSair) and (fCfgSis('NROPRO') <> '1') Then
          Begin
            If fPedeProfissional(objEmitirPedido.objFatVenda) Then
            begin
              if fCfgSis('NROPRO') = '2' then
                objConEqu.CodigoProfissional := objEmitirPedido.objFatVenda.strCodDiv
              else
              begin
                if not objEmitirPedido.objFatVenda.cdsProfiss.IsEmpty then
                  pCloneDataSet(objConEqu.cdsListaCodigoProfissionais, objEmitirPedido.objFatVenda.cdsProfiss);
              end;
            end
            Else
              blnSair := True;
          End;

          If Not blnSair Then
          Begin
            if (not blnNegociacao) then
              blnAprovar := (fMensagem('', fRetTextoMensagem(), ['&Sim', '&Não']) = 1);

            if blnAprovar then
            Begin
              pCalculaDataPrevisao(True);

              If (strSubSta = 'G') Then
              Begin
                if (not blnNegociacao) then
                  pClienteRespGarantia
                else
                  objConEqu.strCliGar := FstrCliGar;

                if (blnFluxoProcesso) and (fCfgSis('FXRESS', varBoolean)) and (objConEqu.strGarant = 'F') and (fCfgSis('CTLEST', varInteger) = 2) and (objConEqu.cdsIteEqu.RecordCount > 0) then
                begin
                  blnGarResSal := True;

                  if (fMensagem('', 'Deseja reservar o saldo dos itens da OS ' + objConEqu.strNumero + '?', ['&Sim', '&Não']) = 1) then
                  begin
                    try
                      pCriarFormularios(TfrmFatManReservaEstoque, frmFatManReservaEstoque);
                      frmFatManReservaEstoque.objConEqu := objConEqu;
                      frmFatManReservaEstoque.ShowModal();
                    finally
                      pFreeAndNil(frmFatManReservaEstoque);
                    end;
                  end
                  else
                    objConEqu.blnResSal := False;
                end;
              End
              Else
              Begin
                objConEqu.strCliGar := '';
              End;

              // PARA APAGAR O PEDIDO ANTES DE INCLUIR OUTRO SE JA FOI APROCADO ANTES
              If strStatus = 'A' Then
                strOperac := 'A';

              if not fValidaCampos(edtSenDig, True) then
                Exit;

              if not fProcessarRequisicaoCompra then
                Exit;

              objConEqu.strFlxFas := 'M';
              objConEqu.strFlxSit := 'EM';

              if (blnGarResSal) and ((not objConEqu.fVerificaEstoqueItensArmazem) or (not objConEqu.blnResSal)) then
                objConEqu.strFlxSit := 'AP'
              else if objConEqu.fVerificaEstoqueItens then
                objConEqu.strFlxSit := 'AP'
              else if (fCfgSis('FLXSEP', varBoolean)) and (objConEqu.cdsIteEqu.RecordCount > 0) then
                objConEqu.strFlxSit := 'AS';

              objConEqu.strFlxCom := 'AM';

              pAlteraStatusDados('A', strSubSta, strCodMre, True, strRetPor, strOsPdCl, strReaPor, strReaTel);
              strStatus := 'A';
              pStatus;

              If Not fEmptyStr(strNumPed) Then
              Begin
                pInicializarFatVenda();
                pAtualizaTotais();

                strTmpOperac := strOperac;
                strOperac := 'A';
                objConEqu.fGravaEquGer;
                strOperac := strTmpOperac;
              End;

              If (strSubSta <> 'N') and (not blnNegociacao) Then
              Begin
                {*****************************************************************************}
                {* COMENTADO, POIS PEDE PARA PREENCHER A DATA E NÃO GRAVA EM LUGAR NENHUM ?? *}
                {**************************************************************************RN*}
                //fDataPrevisao;
                If Not fEmptyStr(strNumPed) Then
                Begin
                  if (objConEqu.cdsDocGer.RecordCount > 1) then
                    pMostraDocumentosGerados
                  else
                  begin
                    fMensagem('', 'Pedido Nº ' + strNumPed + ' gravado com sucesso!', ['&OK']);
                    pImprimePedidoSeparacao(True, True, False);
                  end;
                End;

                if (fCfgSis('OSIMOE', varBoolean)) then
                  if (fMensagem('', 'Deseja imprimir a Ordem de Execução de Serviço?', ['&Sim', '&Não']) = 1) then
                    pImprimirOrdemExecucao(1, tpaNormal);

                fMensagem('','Aprovação efetuada com sucesso!', ['&OK']);

                pEnviarEmailPedOS();
              End;

              pGravarLogSta(strLoginUsuarioLogado,
                            strStaAnt,
                            strStatus + strSubSta,
                            strNumero,
                            strCodDig);

              pGravarLogFlx(blnFLuxoProcesso);

              btnManutencao.Enabled := True;
              btnRealizada.Enabled  := True;
            End;

          End;

        End
        Else
        Begin
          if not fValidaCampos(edtSenDig, True) then
            Exit;

          pAlteraStatusDados('A', strSubSta);

          pGravarLogSta(strLoginUsuarioLogado,
                        strStaAnt,
                        'A' + strSubSta,
                        strNumero,
                        strCodDig);

          pGravarLogFlx(blnFLuxoProcesso);
        End;

      End;

    Except
      On e:exception do
      Begin
        pMensagensErro(e.Message, 'btnRealizadaClick - untFatManConsertoEquip');
      End;
    End;
  finally
    FblnGravandoOS := False;
  end;

  pLimpaTela;
end;

procedure TfrmFatManConsertoEquip.btnBrindeTotalServClick(Sender: TObject);
var
  blnBrinde,
  blnLibera: Boolean;
  strCodPar,
  strTipBri: String;
  cdsDados: TUniClientDataSet;
  frmFatManAlteraItensBrinde: TfrmFatManAlteraItensBrinde;
begin
  inherited;

  if objConEqu.cdsSerEqu.IsEmpty then
    Exit;

  if (not fVerificaCampos) then
    Exit;

  blnLibera := True;

  cdsDados := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsDados, objConEqu.cdsSerEqu);
  cdsDados.IndexFieldNames := objConEqu.cdsSerEqu.IndexFieldNames;

  pCriarFormularios(TfrmFatManAlteraItensBrinde, frmFatManAlteraItensBrinde);

  try
    frmFatManAlteraItensBrinde.blnServic := True;
    frmFatManAlteraItensBrinde.dtsGrid.DataSet := cdsDados;

    if (frmFatManAlteraItensBrinde.ShowModal = mrOk) then
    begin
      blnBrinde := frmFatManAlteraItensBrinde.blnBrinde;
      strCodPar := frmFatManAlteraItensBrinde.strCodPar;
      strTipBri := frmFatManAlteraItensBrinde.strTipBri;

      cdsDados.Filtered := False;
      cdsDados.Filter   := 'MARDES=1';
      cdsDados.Filtered := True;

      if blnBrinde then
      begin
        if blnUsaDig and (pnlRepDig.Visible) and (not fEmptyStr(edtSenDig.Text)) then
          blnLibera := objConEqu.fVerificaAcessoSistemaOS('frmFatVendas - BR', 'Liberado direito de acesso para vendedor conceder brinde na ordem de serviço.', fRetCodVendedor(edtSenDig.Text))
        else
          blnLibera := objConEqu.fVerificaAcessoSistemaOS('frmFatVendas - BR', 'Liberado direito de acesso para vendedor conceder brinde na ordem de serviço.', fRetCodVendedor(edtSenVen.Text));

        if not blnLibera then
        begin
          cdsDados.First;

          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto('Emitir Brinde de Serviço');

          while not cdsDados.Eof do
          begin
            objLiberacao.objMsgLibera.pAddSeparador(65);
            objLiberacao.objMsgLibera.pAddTextoCaption('Produto'    , cdsDados.FieldByName('CODSER').AsString + ' - ' + cdsDados.FieldByName('DESSER').AsString, 10);
            objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade' , cdsDados.FieldByName('QTDSER').AsString , 10);

            cdsDados.Next;
          end;

          objLiberacao.objMsgLibera.pAddQuebra;
          objLiberacao.strDirAce := 'frmFatVendas - BR';
          objLiberacao.strMsgSen := 'Emitir Brinde de Serviço';
          objLiberacao.strCodOpe := fRetCodVendedor(edtSenVen.Text);
          objLiberacao.strCodDig := strLoginUsuarioLogado;
          objLiberacao.strCliente := edtCodCli.Text + '-' + edtNomCli.Text;

          blnLibera := objLiberacao.fLibera;
        end;
      end;

      if not blnLibera then
        Exit;

      cdsDados.First;

      while not cdsDados.Eof do
      begin
        objConEqu.cdsSerEqu.Locate('CODSER', cdsDados.FieldByName('CODSER').AsString, []);

        if (cdsDados.FieldByName('BRINDE').AsString = IIF(blnBrinde, 'S', 'N')) and (not blnBrinde) then
        begin
          cdsDados.Next;
          Continue;
        end;

        pAlterarServico();

        if blnBrinde then
        begin
          objConEqu.strBrinde := 'S';
          objConEqu.strCodPar := strCodPar;
          objConEqu.strTipBri := strTipBri;

          edtValSe1.Text := '0,00';
//          pCalculaTotIte;
        end
        else
        begin
          objConEqu.strBrinde := 'N';
          objConEqu.strCodPar := '';
          objConEqu.strTipBri := '';

          edtValSe1.Text := FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), fRetornaValorServico(edtCodSe1.Text));

//          pCalculaTotIte;
        end;

        pAdicionaServico;

        cdsDados.Next;
      end;
    end;
  finally
    pFreeAndNil(frmFatManAlteraItensBrinde);
    FreeAndNil(cdsDados);

    if (Assigned(frmFatVendaItem)) then
      frmFatVendaItem.Close();
  end;
end;

procedure TfrmFatManConsertoEquip.btnRealizadaClick(Sender: TObject);
Var
  intSubStatus : Integer;
  blnSair : Boolean;
  strSubStaAnt : String;
  blnConfMan,
  blnAtualizaPed:Boolean;
  tpFaturamento: TTipoFatuPDConEqu;
  blnModeloAtivado: Boolean;
begin
  inherited;

  blnAtualizaPed := False;

  FblnGravandoOS := True;
  try
    Try
      if (not fValidaRealizaManAgPecas) then
        Exit;

      if (not fValidaRealizaManAgSeparacao) then
        Exit;

      If (fCfgSis('VALEXP', varString) = '2') And (fValidarExpedicao()) Then
      Begin
        pMostrarMensagemValidacaoExpedicao();
      End
      Else If (objConEqu.strStatus = 'N') and (not blnFluxoProcesso) Then
      Begin
        fMensagem('', 'Não é possível realizar esta ordem de serviço pois a mesma não foi aprovada!', ['&Ok']);
      End
      Else If (Assigned(objMeqMerEnt)) And (Not fEmptyStr(objMeqMerEnt.strAutGer)) And
              (Assigned(objMeqMerSai)) And (fEmptyStr(objMeqMerSai.strAutGer)) Then
      Begin
        fMensagem('ATENÇÃO', 'Para Realizar a Ordem de Serviço é preciso realizar a emissão da Nota de Saída ' +
          'de remessa de equipamento para conserto. Operação cancelada!', ['&OK']);
      End
      Else
      Begin
        blnConfMan := blnFinMan AND (fCfgSis('CALTOS') = 'S');

        If not blnConfMan Then
        begin
          if (blnFluxoProcesso) then
          begin
            if(tpProcessoFlx = tprArmazenar) then
              blnConfMan := (fMensagem('', 'Confirma o armazenamento do equipamento?', ['&Sim', '&Não']) = 1)
            else if (tpProcessoFlx = tprManutencao) then
              blnConfMan := (fMensagem('', 'Confirma a finalização da manutenção?', ['&Sim', '&Não']) = 1)
          end
          else
            blnConfMan := (fMensagem('', 'Confirma Realização da Ordem de Serviço?', ['&Sim', '&Não']) = 1);
        end;

        If blnConfMan Then
        Begin
          blnSair := False;

          if blnFluxoProcesso then
          begin
            case tpProcessoFlx of
            tprManutencao:
              begin
                objConEqu.strSubSta := '';
                objConEqu.strFlxFas := 'M';
                objConEqu.strFlxSit := 'MF';
                objConEqu.strFlxCom := 'AA';
              end;
            tprArmazenar:
              begin
                objConEqu.dtaDtaArm := VS_Date;

                if objConEqu.strStatus = 'N' then
                begin
                  if (objConEqu.strFlxSit <> 'OB') then
                  begin
                    objConEqu.strFlxFas := 'O';
                    objConEqu.strFlxSit := 'ON';
                  end;

                  objConEqu.strFlxCom := 'AR';
                end
                else
                begin
                  tpFaturamento := fVerificaPDFaturado;

                  case tpFaturamento of
                    tpFaturado:
                      begin
                        objConEqu.strFlxFas := 'F';
                        objConEqu.strFlxSit := 'FA';
                        objConEqu.strFlxCom := 'AR';
                      end;
                    tpBaixado:
                      begin
                        objConEqu.strFlxFas := 'F';
                        objConEqu.strFlxSit := 'NF';
                        objConEqu.strFlxCom := 'AR';
                      end;
                    tpNaoFaturado:
                      begin
                        if (objConEqu.cdsIteEqu.RecordCount = 0) and (objConEqu.cdsSerEqu.RecordCount = 0) and (fEmptyStr(objConEqu.strNumPed)) then
                        begin
                          objConEqu.strFlxFas := 'F';
                          objConEqu.strFlxSit := 'NF';
                          objConEqu.strFlxCom := 'AR';
                        end
                        else
                        begin
                          objConEqu.strFlxFas := 'M';
                          objConEqu.strFlxSit := 'AR';
                          objConEqu.strFlxCom := 'AF';
                          blnAtualizaPed := True;
                        end;
                      end;
                  end;
                end;

                objConEqu.strSubSta := 'A';
                objConEqu.strLocFisEqu := fInformarLocFisicaEquipamento;

                If (fEmptyStr(objConEqu.strLocFisEqu)) Then
                Begin
                  fMensagem('', 'Não foi informada a Localidade Física do equipamento. Operação cancelada!', ['&OK']);
                  Exit;
                End;

                if (objConEqu.strGarant <> 'N') and (not fEmptyStr(objConEqu.strNumPed)) and (fCfgSis('FXALCG', varBoolean)) and (blnAtualizaPed) then
                begin
                  if not fAlteraPedidoVenda then
                    Exit;
                end;
              end;
            end;
          end
          Else If (fCfgSis('EQUREA', varString) = '1') Then
          Begin

            intSubStatus := fGetMenu('Status Realizada', arrSubStatusReprov, 1);
            strSubStaAnt := objConEqu.strSubSta;

            Case intSubStatus Of
              1: objConEqu.strSubSta := 'C';
              2: objConEqu.strSubSta := 'A';
            Else
              blnSair := True;
            End;

            If Not blnSair Then
            Begin
              If (intSubStatus = 1) Then
              Begin
                objConEqu.strReaPor := fInputDialog('', 'Retirado Por:', objConEqu.strReaPor);

                If (fEmptyStr(objConEqu.strReaPor)) Then
                Begin
                  fMensagem('', 'Não foi informado quem retirou o equipamento. Operação cancelada!', ['&OK']);
                  Exit;
                End;
              End;
            End;
          End
          Else If (fCfgSis('EQUREA', varString) = '2') Then
          Begin
            objConEqu.strSubStaAnt := objConEqu.strSubSta;
            objConEqu.strSubSta    := '';
          End
          Else
          Begin
            objConEqu.strSubStaAnt := objConEqu.strSubSta;
            objConEqu.strSubSta    := 'A';
          End;

          If (Not blnSair) Then
          Begin
            if not fValidaCampos(edtSenDig, True) then
              Exit;

            if not blnFluxoProcesso then
            begin
              if objConEqu.strSubSta = 'C' then
              begin
                objConEqu.strFlxFas := 'F';
                objConEqu.strFlxSit := 'FA';
                objConEqu.strFlxCom := 'ER';
              end
              else if objConEqu.strSubSta = 'A' then
              begin
                objConEqu.strFlxFas := 'M';
                objConEqu.strFlxSit := 'AR';
                objConEqu.strFlxCom := 'AF';
              end
              else
              begin
                objConEqu.strFlxFas := 'M';
                objConEqu.strFlxSit := 'MF';
                objConEqu.strFlxCom := 'AA';
              end;
            end;

            With objConEqu Do
            Begin
              If (not blnFinMan) And (fCfgSis('CALTOS') = 'S') and ((not blnFluxoProcesso) or (tpProcessoFlx = tprManutencao)) Then
              begin
                if (not fAtualizaDataFimManutencao) then
                  Exit;
              end;

              if objConEqu.strStatus = 'N' then
                pAlteraStatusDados('N', strSubSta, '', False, objConEqu.strRetPor, objConEqu.strOsPdCl, objConEqu.strReaPor, objConEqu.strReaTel, objConEqu.dtaSitDtr)
              else
                pAlteraStatusDados('R', strSubSta, '', False, objConEqu.strRetPor, objConEqu.strOsPdCl, objConEqu.strReaPor, objConEqu.strReaTel, objConEqu.dtaSitDtr);

              pGravarLogSta(strLoginUsuarioLogado,
                            strStatus + strSubStaAnt,
                            'R' + strSubSta,
                            strNumero,
                            strCodDig);

              pGravarLogFlx(blnFLuxoProcesso);
            End;

            pGeraLogLiberacao(objConequ.strNumero, 'OS', objConEqu.strCodEmp);
            fMensagem('', 'Concluído com sucesso!', ['&OK']);

            if fEnviarWhatsappBaixaOS then
              fDisparaSMSWhatsappAutOS(objConEqu.strNumero, objConEqu.strCodEmp, objConEqu.strCodCli, staBaixando, blnModeloAtivado, True);

            pLimpaTela;
          End;
        End;
      End;

    Except
      On E: Exception do
        pMensagensErro(e.Message, 'btnRealizadaClick - untFatManConsertoEquip');
    End;
  finally
    FblnGravandoOS := False;
  end;
end;

procedure TfrmFatManConsertoEquip.btnRealizarSaidaClick(Sender: TObject);
  Var
    strMsgTmp: String;
begin
  inherited;

  strMsgTmp := '';

  If fEmptyStr(fCfgSis('ITECON', VarString)) Or fEmptyStr(fCfgSis('CLASAI', VarString)) Then
  Begin
    If fEmptyStr(fCfgSis('ITECON', VarString)) Then
      strMsgTmp := 'CFG_ITECON';

    If fEmptyStr(fCfgSis('CLASAI', VarString)) Then
    Begin
      If fEmptyStr(strMsgTmp) Then
        strMsgTmp := 'A configuração CFG_CLASAI está'
      Else
        strMsgTmp := 'As configurações ' + strMsgTmp + ', CFG_CLASAI estão';
    End
    Else
    Begin
      If Not fEmptyStr(strMsgTmp) Then
        strMsgTmp := 'A configuração ' + strMsgTmp + ' está';
    End;

    fMensagem('', strMsgTmp + ' em branco. Configure-a(s) corretamente para prosseguir com este processo!' , ['&Ok']);
    Exit;
  End;

  If (fRealizarVincularDocFiscal()) Then
  Begin
    fMensagem('ATENÇÃO', 'Ordem de Serviço deve estar Aprovada ou Em Manutenção para realizar a saída! ' +
                         'Operação cancelada!' , ['&OK']);
    Exit;
  End;

  If fEmptyStr(edtCodCli.Text) Then
  Begin
    fMensagem('', 'Defina um cliente para prosseguir com este processo!' , ['&Ok']);
    Exit;
  End;

  If (Assigned(objMeqMerSai)) And (Not fEmptyStr(objMeqMerSai.strAutGer)) Then
  Begin
    fMensagem('ATENÇÃO', 'Nota de Saída já vinculada à Ordem de Serviço.' + #13#10 +
                         'Remova o vínculo da Nota de Saída atual.' , ['&OK']);
    Exit;
  End;

  pSaidaNF;
end;

procedure TfrmFatManConsertoEquip.btnReativarClick(Sender: TObject);
Var
  blnDeletaPD  : Boolean;
begin

  inherited;

  If fEmptyStr(edtNumero.Text) Then
    Exit;

  If (Not btnReativar.Enabled) Then
    Exit;

  If (objConEqu.strStatus <> 'N') Then
  Begin
    fMensagem('ATENÇÃO!','Ordem de Serviço NÃO ESTÁ REPROVADA. Só é possível reativar uma OS REPROVADA!.', ['&OK']);
    Exit;
  End;

  Try

    With objConEqu Do
    Begin

      blnDeletaPD := False;

      If (fMensagem('', 'Confirma REATIVAÇÃO para Ordem de Serviço?', ['&Sim', '&Não']) = 1) Then
      Begin

        if not fValidaCampos(edtSenDig, True) then
          Exit;

        objConEqu.strFlxFas := 'O';
        objConEqu.strFlxSit := 'OR';
        objConEqu.strFlxCom := 'RC';

        pAlteraStatusDados('F', {Orçamento Realizado}
                           '',
                           '',
                           blnDeletaPD,
                           strRetPor,
                           strOsPdCl,
                           strReaPor,
                           strReaTel,
                           0,
                           '',
                           False,
                           False,
                           True);

        pGravarLogSta(strLoginUsuarioLogado,
                      'N', {  De: Reprovado}
                      'F', {Para: Orçamento Realizado}
                      strNumero,
                      strCodDig);

        pGravarLogFlx(blnFLuxoProcesso);

        strStatus := 'A';
        pStatus;

        fMensagem('','Reativação efetuada com sucesso!', ['&OK']);

      End;

    End;

  Except
    On e:exception do
    Begin
      pMensagensErro(e.Message, 'btnReativarClick - untFatManConsertoEquip');
    End;
  End;

  pLimpaTela;

end;

procedure TfrmFatManConsertoEquip.btnRemoverEntradaClick(Sender: TObject);

  function fGetMensagemTrava: String;
  begin
    Result := 'Para remover o vínculo da Nota Fiscal de entrada é preciso remover o ' + #13#10 +
              'vínculo da Nota Fiscal de saída. Operação cancelada!';
  end;

begin
  inherited;

  If (Not fEmptyStr(objConEqu.strNumero)) And            //OS JÁ FOI GRAVADA
     (Assigned(objMeqMerSai)) And                        //OBJETO DE REF. DO DOC DE SAÍDA ESTÁ INSTANCIADO
     (Not fEmptyStr(objMeqMerSai.strNumDoc)) Then
  Begin  //DOCUMENTO DE SAÍDA FOI VINCULADO
    fMensagem('ATENÇÃO', fGetMensagemTrava(), ['&OK']);
    Exit;
  End;

  If Not fEmptyStr(objConEqu.strNumero) Then
    TConEqu.fDesvinculaOSemNotaFiscal(objMeqMerEnt);

  FreeAndNil(objMeqMerEnt);
  pCarregaDadosNFEntSai;
end;

procedure TfrmFatManConsertoEquip.btnRemoverSaidaClick(Sender: TObject);
  Var
    blnPermitir: Boolean;

  function fGetMensagemTrava: String;
  begin
    Result := 'Para remover o vínculo da Nota Fiscal de saída é preciso realizar o ' + #13#10 +
              'cancelamento do documento. Operação cancelada!';
  end;

begin
  inherited;

  If (Not Assigned(objMeqMerSai)) Then
    Exit;

  blnPermitir := fPodeRemoverVinculaNFSaidaOS();

  If (blnPermitir) Then
  Begin
    If Not fEmptyStr(objConEqu.strNumero) Then
      TConEqu.fDesvinculaOSemNotaFiscal(objMeqMerSai);

    FreeAndNil(objMeqMerSai);
    pCarregaDadosNFEntSai;
  End
  Else
  Begin
    fMensagem('ATENÇÃO', fGetMensagemTrava(), ['&OK']);
  End;
end;

procedure TfrmFatManConsertoEquip.btnReprovarClick(Sender: TObject);
  Var
    strCodMre: String;
    blnSair,
    blnDeletaPD,
    blnRepAgMong: Boolean;
    intSubStatus: Integer;
    strNegNro   : String;
    frmDigMotivoReprovacao: TfrmDigMotivoReprovacao;
begin
  inherited;

  FblnGravandoOS := True;
  try
    Try
      If (Not btnReprovar.Enabled) Then
        Exit;

      If (Assigned(objMeqMerEnt)) And (Not fEmptyStr(objMeqMerEnt.strAutGer)) And
         (Assigned(objMeqMerSai)) And (fEmptyStr(objMeqMerSai.strAutGer)) Then
      Begin
        fMensagem('ATENÇÃO', 'Para Reprovar a Ordem de Serviço é preciso realizar a emissão da Nota de Saída ' +
          'de remessa de equipamento para conserto. Operação cancelada!', ['&OK']);
        Exit;
      End;

      strNegNro := objConEqu.fVerificaExisteNegociacao;

      if (not fEmptyStr(strNegNro)) then
      begin
        fMensagem('ATENÇÃO', 'Existe uma negociação em aberto para esta OS. Portanto, é preciso primeiro finalizar a negociação ou excluir a OS dela para depois reprovar. ' +
                  ' Número da negociação: ' + strNegNro, ['&Ok']);
        Exit;
      end;

      blnSair     := False;
      blnDeletaPD := False;
      blnRepAgMong:= False;

      With objConEqu Do
      Begin
        Try
          pCriarFormularios(TfrmDigMotivoReprovacao, frmDigMotivoReprovacao);
          frmDigMotivoReprovacao.blnFluPro := blnFluxoProcesso;

          If frmDigMotivoReprovacao.ShowModal = mrOk Then
          begin
            strCodMre := frmDigMotivoReprovacao.edtCodMre.Text;
            strRetPor := frmDigMotivoReprovacao.edtRepPor.Text;

            if (blnFluxoProcesso and blnUsaDig) then
            begin
              strCodDig      := frmDigMotivoReprovacao.strCodOpe;
              edtSenDig.Text := frmDigMotivoReprovacao.strSenDig;
            end;
          end
          Else
          Begin
            strCodMre := '';
            blnSair   := True;
          End;
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '');
          End;
        End;

        pFreeAndNil(frmDigMotivoReprovacao);

        If Not blnSair Then
        Begin
          strStatus    := 'N';

          if not blnFluxoProcesso then
          begin
            If (fCfgSis('EQUREP', varBoolean)) Then
            Begin
              If (fOSFoiReprovadaAgMontagem()) Then
                intSubStatus := fGetMenu('Status Reprovação', arrSubStatusReprov, 1)
              Else
              Begin
                intSubStatus := fGetMenu('Status Reprovação', arrSubStatusReprovAgMontagem, 1);
                blnRepAgMong := True;
              End;
            End
            Else
              intSubStatus := fGetMenu('Status Reprovação', arrSubStatusReprov, 1);

            If (Not blnRepAgMong) Then
            Begin
              Case intSubStatus Of
                1: strSubSta := 'C';
                2: strSubSta := 'A';
                else blnSair := True;
              End;
            End
            Else
            Begin
              Case intSubStatus Of
                1: strSubSta := 'M';
                2: strSubSta := 'C';
                3: strSubSta := 'A';
                else blnSair := True;
              End;
            End;
          end
          else
            objConEqu.strSubSta := '';
        End;

        {***********************************************}
        {* SE TIVER PD VINCULADO AO CONSERTO DE EQUIP. *}
        {********************************************MM*}
        If Not blnSair Then
        Begin
          If Not fEmptyStr(strNumPed) Then
            blnSair := fVerificaPedidoReprovacao(blnDeletaPD);
        End;

        If Not blnSair Then
        Begin
          If (blnDeletaPD) Or (fMensagem('', 'Confirma Status REPROVADO para Ordem de Serviço?', ['&Sim', '&Não']) = 1) Then
          Begin
            // PARA APAGAR O PEDIDO ANTES DE INCLUIR OUTRO SE JA FOI APROVADO ANTES
            If strStatus = 'A' Then
              strOperac := 'A';

            if not fValidaCampos(edtSenDig, True) then
              Exit;

            objConEqu.strFlxFas := 'O';
            objConEqu.strFlxSit := 'ON';
            objConEqu.strFlxCom := 'AA';

            pBaixaOcorrenciasCRM;
            pAlteraStatusDados(strStatus, strSubSta, strCodMre, blnDeletaPD, strRetPor, strOsPdCl, strReaPor, strReaTel);

            pGravarLogSta(strLoginUsuarioLogado,
                          strStaAnt,
                          strStatus + strSubSta,
                          strNumero,
                          strCodDig);

            pGravarLogFlx(blnFLuxoProcesso);

            strStatus := 'A';
            pStatus;

            btnManutencao.Enabled := True;
            btnRealizada.Enabled  := True;
            btnCancelar.Enabled   := False;
          End;

        End;

      End;

    Except
      On e:exception do
      Begin
        pMensagensErro(e.Message, 'btnRealizadaClick - untFatManConsertoEquip');
      End;
    End;
  finally
    FblnGravandoOS := False;
  end;

  pLimpaTela;
end;

procedure TfrmFatManConsertoEquip.btnSalResClick(Sender: TObject);
begin
  inherited;

  If Not objConEqu.fVerificaAcessoSistemaOS('CPSARE', 'Liberado acesso à consulta ao saldo reservado.', strLoginUsuarioLogado) Then
  begin
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
    Exit;
  end;

  If (fEmptyStr(objConEqu.cdsIteEqu.FieldByName('CODITE').AsString)) Then
  begin
    fMensagem('', 'Selecione um produto para realizar esta operação.', ['&Ok']);
    Exit;
  end;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(208, 7626, [],
                        ['CODITE','ESPDOC','CODEMP'],
                        [objConEqu.cdsIteEqu.FieldByName('CODITE').AsString,
                        'PD',
                        IfThen(fEmptyStr(objConEqu.strCodEmp),VS_strCodEmp,objConEqu.strCodEmp)],
                        Sender,
                        nil,
                        True);

  End;

end;

procedure TfrmFatManConsertoEquip.btnUltimasVendasClick(Sender: TObject);
var
  strExbRed: String;
begin
  inherited;

  if fEmptyStr(objConEqu.strCodCli) then
    Exit;

  if not fEmptyStr(objConEqu.cdsIteEqu.fieldbyname('CODITE').AsString) then
  begin

    strExbRed := IfThen(fEmptyStr(fCampoTabela('CLI_CODRED', 'CADCLI', ['CLI_CODCLI'], [objConEqu.strCodCli])), 'Não', 'Sim');

    if (strExbRed = 'Sim') and (fMensagem('','Exibir movimento para toda a rede de lojas do cliente?', ['','']) = 2) then
      strExbRed := 'Não';

    if Assigned(prcExecutaRelatorio) then
      prcExecutaRelatorio(35, 3066, [3066], ['EXBRED', 'CODCLI', 'CODITE'], [strExbRed, objConEqu.strCodCli, objConEqu.cdsIteEqu.fieldbyname('CODITE').AsString], Sender, Nil, True);
  end
  else
    pMensagemOk('Selecione um item para consulta!');
end;

procedure TfrmFatManConsertoEquip.btnVincularEntradaClick(Sender: TObject);
begin
  inherited;

  If (Assigned(objMeqMerEnt)) And (Not fEmptyStr(objMeqMerEnt.strAutGer)) Then
  Begin
    fMensagem('ATENÇÃO', 'Nota de Entrada já vinculada à Ordem de Serviço.' + #13#10 +
                         'Remova o vínculo da Nota de Entrada atual.' , ['&OK']);
    Exit;
  End;

  If fEmptyStr(edtCodCli.Text) Then
  Begin
    fMensagem('', 'Defina um cliente para prosseguir com este processo!' , ['&Ok']);
    Exit;
  End;

  pVincularEntradaNF;
end;

procedure TfrmFatManConsertoEquip.btnVincularSaidaClick(Sender: TObject);
begin
  inherited;

  If (fRealizarVincularDocFiscal()) Then
  Begin
    fMensagem('ATENÇÃO', 'Ordem de Serviço deve estar Aprovada ou Em Manutenção para realizar a saída! ' +
                         'Operação cancelada!' , ['&OK']);
    Exit;
  End;

  If (Assigned(objMeqMerSai)) And (Not fEmptyStr(objMeqMerSai.strAutGer)) Then
  Begin
    fMensagem('ATENÇÃO', 'Nota de Saída já vinculada à Ordem de Serviço.' + #13#10 +
                         'Remova o vínculo da Nota de Saída atual.', ['&OK']);
    Exit;
  End;

  If fEmptyStr(edtCodCli.Text) Then
  Begin
    fMensagem('', 'Defina um cliente para prosseguir com este processo!' , ['&Ok']);
    Exit;
  End;

  pVincularSaidaNF;
end;

procedure TfrmFatManConsertoEquip.btnConsultaCatalogosClick(Sender: TObject);
var
  frmConsultaFatCatalogo: TfrmConsultaFatCatalogo;
begin
  inherited;

  If (Not objConEqu.fVerificaAcessoSistemaOS('frmConsultaFatCatalogo', 'Liberado acesso à rotinas de Consulta de Catálogos.', strLoginUsuarioLogado)) Then
  Begin
    fMensagem('ATENÇÃO', 'Usuário sem permissão para rotina de Consulta de Catálogos!' , ['&Ok']);
    Exit;
  End;

  pCriarFormularios(TfrmConsultaFatCatalogo, frmConsultaFatCatalogo);
  Try
    frmConsultaFatCatalogo.blnFlxProcessoTec := blnFlxProcessoTec;
    frmConsultaFatCatalogo.ShowModal;
  Finally
    pFreeAndNil(frmConsultaFatCatalogo);
  End;
end;

procedure TfrmFatManConsertoEquip.btnConsultarClienteClick(Sender: TObject);
begin
  inherited;
  If fVerificaAcessoSistema('frmCadClientes', strLoginUsuarioLogado) Then
  Begin
    pCriarFormularios(TfrmCadClientes, frmCadClientes);
    Try
      frmCadClientes.strCodClienteIniciarCadastro := edtCodCli.Text;
      frmCadClientes.ShowModal;
    Finally
      pFreeAndNil(frmCadClientes);
    End;
  End
  Else
    fMensagem('','Sem permissão para Cadastro de Clientes!',['&Ok']);
end;

procedure TfrmFatManConsertoEquip.btnDesEspClick(Sender: TObject);
var
  intOpcDesconto: Integer;
begin
  inherited;

  If (Not btnConfirmar.Enabled) Then
  Begin
    fMensagem('ATENÇÃO', 'O.S. não está em modo de inclusão ou alteração!' , ['&Ok']);
    Exit;
  End;

  If fCfgSis('EQUDES', varInteger) = 3 then //perguntar
  begin
    intOpcDesconto := fMensagem(
      'ATENÇÃO',
      'Aplicar Desconto Especial sobre',
      ['Produtos e Serviços', 'Somente sobre Produtos', 'Somente sobre Serviços'],
      1,      // intFocoBotao: Integer = 1;
      True,   // blnSaiComEsc: Boolean = False;
      1,      // intEstFon: Integer = 1;
      190,    // intWidBut: Integer = 0;
      False,  // blnAutosize: Boolean = False;
      0,      // intSomarTop: Integer=0;
      False,  // blnObrigaEsc: Boolean = False;
      False,  // blnOcultPainelBtn: Boolean = False;
      True,   // blnBtnSemImg : Boolean = False;
      0,      // intHeightOpc: Integer = 0;
      600,    // intFormWidth : Integer = 0;
      -1);    // intQtdLinha: Integer = -1;
    intOpcDesconto := intOpcDesconto - 1;
  end
  else
    intOpcDesconto := fCfgSis('EQUDES', varInteger);

  If (intOpcDesconto in [DESC_PRODSERV, DESC_PROD]) and (objConEqu.cdsIteEqu.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO', 'Informe produtos para conceder desconto!' , ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmFatManEquipDigDesconto, frmFatManEquipDigDesconto);

    Try
      objConEqu.fltVlrProOri := fRetTotIte;
      objConEqu.fltVlrSerOri := objConEqu.fltVlrSer + objConEqu.fltDesEspSer;

      frmFatManEquipDigDesconto.intOpcDesconto := intOpcDesconto;
      frmFatManEquipDigDesconto.fltVlrPro := objConEqu.fltVlrProOri; {objConEqu.fltVlrPro + objConEqu.fltDesEsp}
      frmFatManEquipDigDesconto.fltVlrSer := objConEqu.fltVlrSerOri;
      frmFatManEquipDigDesconto.fltPorDes := objConEqu.fltPorDes;
      frmFatManEquipDigDesconto.fltValDes := objConEqu.fltValDes;

      If (frmFatManEquipDigDesconto.ShowModal = mrOk) Then
      Begin
        if intOpcDesconto in [DESC_PRODSERV, DESC_SERV] then
        begin
          objConEqu.fltPorDes := frmFatManEquipDigDesconto.fltPorDes;
          if intOpcDesconto = DESC_SERV then
            objConEqu.fltValDes := frmFatManEquipDigDesconto.fltValDes
          else
            objConEqu.fltValDes := fFormataFloat(frmFatManEquipDigDesconto.fltValDes * (objConEqu.fltVlrSerOri / (objConEqu.fltVlrProOri + objConEqu.fltVlrSerOri)), 2);
          objConEqu.fltDesEsp := frmFatManEquipDigDesconto.fltDesEsp;
        end
        else
        begin
          objConEqu.fltPorDes := 0;
          objConEqu.fltValDes := 0;
          objConEqu.fltDesEsp := 0;
        end;

        pAplicarDescontoServicos(objConEqu.fltValDes);

        if intOpcDesconto in [DESC_PRODSERV, DESC_PROD] then
        begin
          objConEqu.fltPorDes := frmFatManEquipDigDesconto.fltPorDes;
          if intOpcDesconto = DESC_PROD then
          begin
            objConEqu.fltValDes := frmFatManEquipDigDesconto.fltValDes;
            objConEqu.fltDesEsp := frmFatManEquipDigDesconto.fltDesEsp;
          end
          else
          begin
            objConEqu.fltValDes := fFormataFloat(frmFatManEquipDigDesconto.fltValDes * (objConEqu.fltVlrProOri / (objConEqu.fltVlrProOri + objConEqu.fltVlrSerOri)), 2);
            objConEqu.fltDesEsp := fFormataFloat(frmFatManEquipDigDesconto.fltDesEsp - (frmFatManEquipDigDesconto.fltValDes * (objConEqu.fltVlrSerOri / (objConEqu.fltVlrProOri + objConEqu.fltVlrSerOri))), 2);
          end;
        end
        else
        begin
          objConEqu.fltPorDes := 0;
          objConEqu.fltValDes := 0;
          objConEqu.fltDesEsp := 0;
        end;

        pInicializarFatVenda();
        pAtualizaTotais();

        objConEqu.fltPorDes := frmFatManEquipDigDesconto.fltPorDes;

        case intOpcDesconto of
          DESC_PROD:
            begin
              objConEqu.fltValDes := frmFatManEquipDigDesconto.fltValDes;
              objConEqu.fltDesEsp := frmFatManEquipDigDesconto.fltDesEsp;
            end;
          DESC_SERV:
            begin
              objConEqu.fltValDes := 0;
              objConEqu.fltDesEsp := 0;
            end;
          DESC_PRODSERV:
            begin
              objConEqu.fltValDes := fFormataFloat(frmFatManEquipDigDesconto.fltValDes * (objConEqu.fltVlrProOri / (objConEqu.fltVlrProOri + objConEqu.fltVlrSerOri)), 2);
              objConEqu.fltDesEsp := fFormataFloat(frmFatManEquipDigDesconto.fltDesEsp - (frmFatManEquipDigDesconto.fltValDes * (objConEqu.fltVlrSerOri / (objConEqu.fltVlrProOri + objConEqu.fltVlrSerOri))), 2);
            end;
        end;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmFatManConsertoEquip.btnDesEspClick]');
    End;
  Finally
    FreeAndNil(frmFatManEquipDigDesconto);
  End;
end;

procedure TfrmFatManConsertoEquip.btnDevCliClick(Sender: TObject);
  Var
    blnLiberado: boolean;
    strRetirado, strRetiradoAnt: String;
    frmConsertoEquipFinalizacao: TfrmConsertoEquipFinalizacao;
    tpFaturamento: TTipoFatuPDConEqu;

  function fRetornaSubSta: String;
  begin
    If (fRepAgMontage()) Then
    Begin
      If (objConEqu.strSubSta = 'C') Then
        Result := 'A'
      Else
        Result := 'C';
    End
    Else
    Begin
      Result := 'C';
    End;
  end;
begin
  inherited;

  blnLiberado := False;

  If ((btnDevCli.Visible) And (btnDevCli.Enabled)) or (blnFluxoProcesso) Then
  Begin
    if not fValidaCampos(edtSenDig, True) then
      Exit;

    strRetiradoAnt := objConEqu.strReaPor;

    if (blnFluxoProcesso) then
    begin
      if fTravaDebitosAtraso(True) then
        Exit;

      if (objConEqu.strFlxCom = 'AF') and (objConEqu.strGarant = 'N') and (fVerificaPDFaturado = tpNaoFaturado) then
      begin
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddTexto('Permitir realizar a entrega do equipamento no fluxo mesmo que a OS esteja aguardando faturamento');
        objLiberacao.objMsgLibera.pAddSeparador(75);
        objLiberacao.objMsgLibera.pAddTextoCaption('OS'      , objConEqu.strNumero                                                    , 7);
        objLiberacao.objMsgLibera.pAddTextoCaption('Empresa' , objConEqu.strCodEmp + ' - ' + fRetNomeEmpresaSelec(objConEqu.strCodEmp), 7);
        objLiberacao.objMsgLibera.pAddTextoCaption('Cliente' , objConEqu.strCodCli + '-' + fRetNomCliente(objConEqu.strCodCli)        , 7);

        objLiberacao.strDirAce := 'FXREAF';
        objLiberacao.strMsgSen := 'Permitir realizar a entrega do equipamento no fluxo mesmo que a OS esteja aguardando faturamento';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;

        objLiberacao.pInformaNumDocEspDocCodEmp(
                          objConEqu.strNumero,
                          'OS',
                          objConEqu.strCodEmp);

        If objLiberacao.fLibera Then
          blnLiberado := True
        Else
          Exit;
      end;

      Try
        pCriarFormularios(TfrmConsertoEquipFinalizacao, frmConsertoEquipFinalizacao);
        frmConsertoEquipFinalizacao.strReaPor := strRetiradoAnt;
        frmConsertoEquipFinalizacao.strReatel := objConEqu.strReaTel;
        frmConsertoEquipFinalizacao.dtaSitDtr := objConEqu.dtaSitDtr;
        frmConsertoEquipFinalizacao.strRea_RG := objConEqu.strRea_RG;
        frmConsertoEquipFinalizacao.strLocFis := objConEqu.strLocFisEqu;
        frmConsertoEquipFinalizacao.ShowModal();

        strRetirado := frmConsertoEquipFinalizacao.strReaPor;
        objConEqu.strReaTel := frmConsertoEquipFinalizacao.strReaTel;
        objConEqu.dtaSitDtr := frmConsertoEquipFinalizacao.dtaSitDtr;
        objConEqu.strRea_RG := frmConsertoEquipFinalizacao.strRea_RG;
        objConEqu.strDigRet := frmConsertoEquipFinalizacao.strDigRet;

        objConEqu.strLocFisEqu := '';

        If (fEmptyStr(strRetirado)) Then
        Begin
          fMensagem('', 'Não foi informado quem retirou o equipamento. Operação cancelada!', ['&OK']);
          Exit;
        End;

        If (fEmptyStr(objConEqu.strRea_RG)) and (fCfgSis('ORGRET', varBoolean)) Then
        Begin
          fMensagem('', 'Não foi informado o RG de quem retirou o equipamento. Operação cancelada!', ['&OK']);
          Exit;
        End;

        If (objConEqu.dtaSitDtr = 0) Then
        Begin
          fMensagem('', 'Não foi informada a data de retirada do equipamento. Operação cancelada!', ['&OK']);
          Exit;
        End;
      Finally
        pFreeAndNil(frmConsertoEquipFinalizacao);
      End;
    end
    else
    begin
      strRetirado := fInputDialog('',
                                  'Retirado Por:',
                                  strRetiradoAnt);

      If (fEmptyStr(strRetirado)) And ( (objConEqu.strSubSta = 'A') Or (objConEqu.strSubSta = 'M') ) Then
      Begin
        fMensagem('', 'Não foi informado quem retirou o equipamento. Operação cancelada!', ['&OK']);
        Exit;
      End;

      if (not blnUsaDig) then
        objConEqu.strDigRet := strLoginUsuarioLogado
      else
        objConEqu.strDigRet := objConEqu.strCodDig;
    end;

    If (objConEqu.strStatus = 'R') Then
    begin
      objConEqu.strReaPor := strRetirado;
      objConEqu.strFlxFas := 'R';
      
      tpFaturamento := fVerificaPDFaturado;

      case tpFaturamento of
        tpFaturado: objConEqu.strFlxSit := 'FA';
        tpBaixado: objConEqu.strFlxSit := 'NF';
        tpNaoFaturado: objConEqu.strFlxSit := 'AF';
      end;

      if (objConEqu.cdsIteEqu.RecordCount = 0) and (objConEqu.cdsIteEqu.RecordCount = 0) and (fEmptyStr(objConEqu.strNumPed)) then
        objConEqu.strFlxSit := 'NF';

      objConEqu.strFlxCom := 'ER';
    end
    Else
    begin
      objConEqu.strReaPor := strRetirado;

      if (objConEqu.strFlxSit <> 'OB') then
      begin
        objConEqu.strFlxFas := 'R';
        objConEqu.strFlxSit := 'ON';
      end;

      objConEqu.strFlxCom := 'ER';
    end;

    pDefinirStatusAnt();

    objConEqu.pAlteraStatusDados(objConEqu.strStatus, fRetornaSubSta(), '', False, objConEqu.strRetPor,
      objConEqu.strOsPdCl, objConEqu.strReaPor, objConEqu.strReaTel, objConEqu.dtaSitDtr, objConEqu.strRea_RG);

    objConEqu.pGravarLogSta(strLoginUsuarioLogado,
                            objConEqu.strStaAnt,
                            objConEqu.strStatus + fRetornaSubSta(),
                            objConEqu.strNumero,
                            objConEqu.strCodDig);

    objConEqu.pGravarLogFlx(blnFLuxoProcesso);

    if blnLiberado then
      pGeraLogLiberacao(objConEqu.strNumPed, 'PD', objConEqu.strEmpPed);

    if fCfgSis('FITDRE', varBoolean) then
      btnTermoDev.Click;

    fMensagem('', 'Concluído com sucesso!', ['&OK']);

    pLimpaTela;
  End;
end;

procedure TfrmFatManConsertoEquip.edtObsExit(Sender: TObject);
begin
  inherited;
  If strValidaEqu = 'S' Then
    fValidaCampos(edtObs, True);
end;

procedure TfrmFatManConsertoEquip.btnCancelarClick(Sender: TObject);
  Var
    blnImp,
    blnJafatu,
    blnJaBaix,
    blnSepImp : Boolean;
    strCodVen : String;
    strNegNro,
    LNumFat: String;
    qryFGOEQU: TUniQuery;
begin
  inherited;

  FblnGravandoOS := True;
  try
    Try
      If objConEqu.strTemPed = 'S' Then
      Begin
        qryFGOEQU := fCriaQuery(Self);

        try
          qryFGOEQU.Close;
          qryFGOEQU.SQL.Text := SELECT_PD_EQUGOR;
          qryFGOEQU.ParamByName('SEQEQU').AsString := objConEqu.strAutInc;
          qryFGOEQU.Open;

          if (not qryFGOEQU.IsEmpty) then
          begin
            while not qryFGOEQU.Eof do
            begin
              fDocumentoFatExiste(qryFatgor,
                                  qryFGOEQU.FieldByName('NUMDOC').AsString,
                                  'PD',
                                  qryFGOEQU.FieldByName('CODEMP').AsString,
                                  blnJaFatu, blnJaBaix, blnImp, strCodVen, blnSepImp);

              blnJaFatu := blnJaFatu or fValidaHouveFaturamentoParcial(LNumFat, qryFGOEQU.FieldByName('NUMDOC').AsString, qryFGOEQU.FieldByName('CODEMP').AsString);

              if blnJaFatu then
              begin
                fMensagem('ATENÇÃO!', 'Não é possível cancelar a Ordem de Serviço!' +
                  #13#10 + 'Existe um Pedido de Venda faturado para ela.' +
                  #13#10 + 'Pedido: ' + qryFGOEQU.FieldByName('NUMDOC').AsString + '-PD-' + qryFGOEQU.FieldByName('CODEMP').AsString + '.' , ['&OK']);
                Exit;
              end;

              qryFGOEQU.Next;
            end;
          end
          else
          begin
            fDocumentoFatExiste(qryFatgor,
                                objConEqu.strNumPed,
                                'PD',
                                objConEqu.strEmpPed,
                                blnJaFatu, blnJaBaix, blnImp, strCodVen, blnSepImp);

            blnJaFatu := blnJaFatu or fValidaHouveFaturamentoParcial(LNumFat, objConEqu.strNumPed, objConEqu.strEmpPed);

            if blnJaFatu then
            begin
              fMensagem('ATENÇÃO!', 'Não é possível cancelar a Ordem de Serviço!' +
                #13#10 + 'Existe um Pedido de Venda faturado para ela.' +
                #13#10 + 'Pedido: ' + objConEqu.strNumPed + '-PD-' + objConEqu.strEmpPed + '.' , ['&OK']);
              Exit;
            end;
          end;
        finally
          FreeAndNil(qryFGOEQU);
        end;
      End;

      If (
           (Assigned(objMeqMerEnt)) And (fEmptyStr(objMeqMerEnt.strAutGer))
         ) Or
         (
           (Assigned(objMeqMerSai)) And (fEmptyStr(objMeqMerSai.strAutGer))
         ) Then
      Begin
        fMensagem('ATENÇÃO', 'Para Cancelar a Ordem de Serviço é preciso remover o vínculo das Notas de Entrada e Saída ' +
          'de remessa de equipamento para conserto. Operação cancelada!', ['&OK']);
        Exit;
      End;

      strNegNro := objConEqu.fVerificaExisteNegociacao;

      if (not fEmptyStr(strNegNro)) then
      begin
        fMensagem('ATENÇÃO', 'A ordem de serviço ' + edtNumero.Text + ' possui negociação em aberto e não pode ser cancelada. ' +
                  'Número da negociação: ' + strNegNro + '. Remova a mesma da negociação e depois, efetue o cancelamento.' , ['&Ok']);
        Exit;
      end;

      If (fMensagem('', 'Confirma o Cancelamento da Ordem de Serviço?', ['&Sim', '&Não']) = 1) Then
      Begin
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddTexto('Liberação para cancelamento de Ordem de Serviço');
        objLiberacao.objMsgLibera.pAddSeparador(75);
        objLiberacao.objMsgLibera.pAddTextoCaption('OS'     , objConEqu.strNumero                                            , 7);
        objLiberacao.objMsgLibera.pAddTextoCaption('Cliente', objConEqu.strCodCli + '-' + fRetNomCliente(objConEqu.strCodCli), 7);

        objLiberacao.strDirAce := 'SENCOS';
        objLiberacao.strSenLib := fCfgSis('SENCOS');
        objLiberacao.blnManterCompatibilidadeSenCfg := not fEmptyStr(objLiberacao.strSenLib);
        objLiberacao.strMsgSen := 'Liberação para cancelamento de Ordem de Serviço';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;

        objLiberacao.pInformaNumDocEspDocCodEmp(
                          objConequ.strNumero,
                          'OS',
                          objConEqu.strCodEmp);

        if objLiberacao.fLibera then
        begin
          if (not objConEqu.fCancelaOrdServico(Self.Name)) then
            Exit;

          objConEqu.strFlxFas := 'C';
          objConEqu.strFlxSit := 'CA';
          objConEqu.strFlxCom := 'CA';

          objConEqu.pGravarLogFlx(blnFLuxoProcesso);

          fMensagem('AVISO', 'Ordem de Serviço cancelada com sucesso!' , ['&Ok']);
          pLimpaTela;
        end;
      end;
    Except
      On e:exception do
      Begin
        pMensagensErro(e.Message, 'btnCancelarClick - untFatManConsertoEquip');
      End;
    End;
  finally
    FblnGravandoOS := False;
  end;
end;

procedure TfrmFatManConsertoEquip.btnCancelarOSClick(Sender: TObject);
  Var
    blnImp,
    blnJafatu,
    blnJaBaix,
    blnSepImp : Boolean;
    strCodVen,
    LNumFat: String;
    qryFGOEQU: TUniQuery;
begin
  inherited;

  If (Not objConEqu.fPodeCancelarOrdemServicoRealizada()) Then
    Exit;

  qryFGOEQU := fCriaQuery(Self);

  try
    qryFGOEQU.Close;
    qryFGOEQU.SQL.Text := SELECT_PD_EQUGOR;
    qryFGOEQU.ParamByName('SEQEQU').AsString := objConEqu.strAutInc;
    qryFGOEQU.Open;

    if (not qryFGOEQU.IsEmpty) then
    begin
      while not qryFGOEQU.Eof do
      begin
        fDocumentoFatExiste(qryFatgor,
                            qryFGOEQU.FieldByName('NUMDOC').AsString,
                            'PD',
                            qryFGOEQU.FieldByName('CODEMP').AsString,
                            blnJaFatu, blnJaBaix, blnImp, strCodVen, blnSepImp);

        blnJaFatu := blnJaFatu or fValidaHouveFaturamentoParcial(LNumFat, qryFGOEQU.FieldByName('NUMDOC').AsString, qryFGOEQU.FieldByName('CODEMP').AsString);

        if blnJaFatu then
        begin
          fMensagem('ALERTA', 'Pedido da OS foi faturado. Operação cancelada!', ['&OK']);
          pLimpaTela;
          Exit;
        end;

        qryFGOEQU.Next;
      end;
    end
    else
    begin
      fDocumentoFatExiste(qryFatgor,
                          objConEqu.strNumPed,
                          'PD',
                          objConEqu.strEmpPed,
                          blnJaFatu, blnJaBaix, blnImp, strCodVen, blnSepImp);

      blnJaFatu := blnJaFatu or fValidaHouveFaturamentoParcial(LNumFat, objConEqu.strNumPed, objConEqu.strEmpPed);

      if blnJaFatu then
      begin
        fMensagem('ALERTA', 'Pedido da OS foi faturado. Operação cancelada!', ['&OK']);
        pLimpaTela;
        Exit;
      end;
    end;
  finally
    FreeAndNil(qryFGOEQU);
  end;

  If (fMensagem('AVISO', 'Deseja realmente cancelar a realização da OS?', ['&Sim', '&Não']) = 1) Then 
  Begin

    pDefinirStatusAnt();
    objConEqu.strStatus := 'A';
    objConEqu.strReaPor := '';

    if not fValidaCampos(edtSenDig, True) then
      Exit;

    objConEqu.strFlxFas := 'M';
    objConEqu.strFlxSit := 'EM';
    objConEqu.strFlxCom := 'AM';
    objConEqu.strDigRet := EmptyStr;

    objConEqu.pAlteraStatusDados(objConEqu.strStatus,
                                 objConEqu.strSubSta,
                                 '',
                                 True,
                                 objConEqu.strRetPor,
                                 objConEqu.strOsPdCl,
                                 objConEqu.strReaPor,
                                 objConEqu.strReaTel,
                                 0,
                                 '',
                                 False,
                                 blnFluxoProcesso);

    fMensagem('CONFIRMAÇÃO', 'Realização da Ordem de Serviço Nº ' + objConEqu.strNumero + ' cancelada com sucesso!', ['&Ok']);

    If (fMensagem('', 'Imprimir?', ['&Sim', '&Não']) = 1) Then
      btnImprimir.Click;

    objConEqu.pGravarLogSta(strLoginUsuarioLogado,
                            objConEqu.strStaAnt,
                            objConEqu.strStatus + objConEqu.strSubSta,
                            objConEqu.strNumero,
                            objConEqu.strCodDig);

    objConEqu.pGravarLogFlx(blnFLuxoProcesso);

    pLimpaTela;
  End;
end;

procedure TfrmFatManConsertoEquip.btnImpEtiClick(Sender: TObject);
begin
  inherited;

  if fEmptyStr(edtNumero.Text) Then
    Exit;

  If fMensagem('AVISO', 'Imprime etiqueta?', ['&Sim', '&Não']) = 2 Then
    Exit;

  pImprimirEtiqueta(edtNumero.Text);
end;


procedure TfrmFatManConsertoEquip.btnImpItensServicosClick(Sender: TObject);
begin
  inherited;

  if Assigned(prcExecutaRelatorio) then
    prcExecutaRelatorio(159, 7179, [7179], ['NUMOSE','CODEMP', 'EXBCOM'], [objConEqu.strNumero, objConEqu.strCodEmp, IIF(fVerificaAcessoSistema('ECORCE', strLoginUsuarioLogado), 'SIM', 'NÃO')], Sender, Nil, True);

end;

procedure TfrmFatManConsertoEquip.btnImpostosClick(Sender: TObject);
Var
  frmFatMostraItens: TfrmFatMostraItensFechamento;
begin

  inherited;

  if not fEmptyStr(edtCodCli.Text) Then
  begin

    pInicializarFatVenda();

    If (Assigned(objEmitirPedido)) Then
    begin
      objEmitirPedido.objFatVenda.strTipPed := 'A';
      try
        pCriarFormularios(TfrmFatMostraItensFechamento, frmFatMostraItens);
        frmFatMostraItens.blnExibirAcrescimoDesconto := False;
        frmFatMostraItens.fatVenda := objEmitirPedido.objFatVenda;
        frmFatMostraItens.ShowModal;
      finally
        FreeAndNil(frmFatMostraItens);
      end;
    end;

  end;

end;

procedure TfrmFatManConsertoEquip.btnImpPedClick(Sender: TObject);
var
  blnDeletouItens: Boolean;
  strEmpLog: String;
  qryFGOEQU: TUniQuery;
  qryFatGor: TUniQuery;
  fatVenda : TFatVenda;
begin
  strEmpLog := VS_strCodEmp;

  qryFGOEQU := fCriaQuery(Self);
  qryFatGor := fCriaQuery(Self);

  qryFatGor.SQL.Clear;
  qryFatGor.SQL.Add(fSelectFromFatgorLeftAuxiliares(False));
  qryFatGor.SQL.Add('WHERE ');
  qryFatGor.SQL.Add('  F.FGO_NUMDOC = :NUMDOC AND ');
  qryFatGor.SQL.Add('  F.FGO_ESPDOC = :ESPDOC AND ');
  qryFatGor.SQL.Add('  F.FGO_CODEMP = :CODEMP ');

  try
    qryFGOEQU.Close;
    qryFGOEQU.SQL.Text := SELECT_PD_EQUGOR;
    qryFGOEQU.ParamByName('SEQEQU').AsString := objConEqu.strAutInc;
    qryFGOEQU.Open;

    if (qryFGOEQU.RecordCount > 1) then
    begin
      objConEqu.cdsDocGer.EmptyDataSet;
      fatVenda := TFatVenda.CreateInstance('PD');

      if not Assigned(objConEqu.objFatVendaImp) then
        objConEqu.objFatVendaImp := TFatVendaImp.Create;

      while not qryFGOEQU.Eof do
      begin
        qryFatGor.Close;
        qryFatGor.ParamByName('NUMDOC').AsString := qryFGOEQU.FieldByName('NUMDOC').AsString;
        qryFatGor.ParamByName('ESPDOC').AsString := 'PD';
        qryFatGor.ParamByName('CODEMP').AsString := qryFGOEQU.FieldByName('CODEMP').AsString;
        qryFatGor.Open;

        pSetaEmpresaLogada(qryFGOEQU.FieldByName('CODEMP').AsString);
        pSetarEmpresaItem(VS_strCodEmp);

        fatVenda.strNumOrc := qryFGOEQU.FieldByName('NUMDOC').AsString;
        fatVenda.strEspOrc := 'PD';
        fatVenda.strEmpOri := qryFGOEQU.FieldByName('CODEMP').AsString;

        fatVenda.strNumDoc := qryFGOEQU.FieldByName('NUMDOC').AsString;
        fatVenda.strEspDoc := 'PD';
        fatVenda.strEmpDoc := qryFGOEQU.FieldByName('CODEMP').AsString;

        fatVenda.blnVerEstOrc := False;
        untFuncFat.pCarregarClientePedidoOrcamento(fatVenda);

        fatVenda.pCarregaPedidoOrcamento(qryFatGor, blnDeletouItens);
        objConEqu.pAdicionaDocumentoParaImpressao(fatVenda, strEmpLog, qryFGOEQU.FieldByName('EMPITE').AsString);

        qryFGOEQU.Next;
      end;

      pSetaEmpresaLogada(strEmpLog);
      pSetarEmpresaItem(VS_strCodEmp);

      pMostraDocumentosGerados;
    end
    else
      pImprimePedidoSeparacao(True, False, False);
  finally
    if (VS_strCodEmp = strEmpLog) then
    begin
      pSetaEmpresaLogada(strEmpLog);
      pSetarEmpresaItem(VS_strCodEmp);
    end;

    if Assigned(fatVenda) then
      FreeAndNil(fatVenda);

    FreeAndNil(qryFatGor);
    FreeAndNil(qryFGOEQU);
  end;
end;

procedure TfrmFatManConsertoEquip.pImprimir(intQtdImp, intDestino: Integer; tpArquivo: TTipoArquivo; strEspecie: string; var StrPDFRet: string;
  var blnOK: Boolean; strCodLay: String = ''; strTipImpr: String = 'I');
var
  objImpressao: TEditorFastImpressao;
  LVisPDF: Boolean;
Begin
  LVisPDF := (intDestino = 1) and (fCfgSis('CEQIMP', varBoolean)) and (strEspecie <> 'OS');

  objImpressao := TEditorFastImpressao.Create(Nil);
  try
    With objImpressao Do
    Begin
      recDocume.strNumDoc := objConEqu.strNumero;

      if (edtCodEmp.Visible) then
        recDocume.strCodEmp := edtCodEmp.Text
      else
        recDocume.strCodEmp := VS_strCodEmp;

      recDocume.strEspDoc := strEspecie;

      case AnsiIndexStr(strEspecie, ['OS', 'OSTR', 'OSTD', 'OSOE']) of
        0: tpeTipoEtiqueta := tpeOrdemServico;
        1: tpeTipoEtiqueta := tpeOrdemServicoTermoResp;
        2: tpeTipoEtiqueta := tpeOrdemServicoTermoDev;
        3: tpeTipoEtiqueta := tpeOrdemServicoOrdExecucao;
      end;

      if not fEmptyStr(strCodLay) then
        recDocume.strCodLay := strCodLay;

      recDocume.intQtdImp := intQtdImp;
      recDocume.blnReimpr := False;
      recDocume.blnDocCan := False;
      recDocume.blnQtdOri := False;
      recDocume.blnConfir := False;
      recDocume.blnDocSep := False;
      recDocume.blnImpExpedicao := False;
      recDocume.blnFilEmp := False;
      recDocume.blnImpFil := False;
      recDocume.blnSepFut := False;
      recDocume.blnEnt_CD := False;
      recDocume.blnSimples               := False;
      recDocume.blnSempreEntr            := False;
      recDocume.blnNaoSelImp             := (intDestino = 2) or (strTipImpr = 'V');
      recDocume.blnVisPDF                := LVisPDF or (strTipImpr = 'V');
      recDocume.blnRequisicao            := False;
      recDocume.blnLocFisEmpEmi          := False;
      recDocume.blnAgruparItensSeparacao := False;
      recDocume.strCodCli := edtCodCli.Text;
      blnOk := fImprimeDocumento(tpArquivo, '', '');
      if tpArquivo = tpaPDF Then
        StrPDFRet := strArqPDF;
    End;
  Finally
    FreeAndNil(objImpressao);
  End;
End;

procedure TfrmFatManConsertoEquip.btnImprimirClick(Sender: TObject);
var
  blnOk,
  blnOkImp: Boolean;
  strEsp,
  strPDF,
  strTpLayout,
  strCodLay,
  strTipImpr: string;
  intQtdImp,
  intDestino: Integer;
begin
  inherited;

  intQtdImp := 1;
  strCodLay := '';
  strTipImpr := 'I';

  blnOK := False;

  strTpLayout := 'Ordem de Serviço';
  strEsp := 'OS';

  if (Sender <> btnImprimir) then
  begin
    strTpLayout := 'Termo de Devolução';
    strEsp := 'OSTD';

    if not fTravaTermoDevolucao then
      Exit;
  end;

  if (not fValidaTravasEnviarCliente) then
    Exit;

  intDestino := fMensagem('SELECIONE', 'Imprimir ' + strTpLayout + ' para:', ['&Imprimir', '&E-mail', '&Ambas']);

  if (IntDestino in [1, 3]) Then
  Begin
    if (not fValidaImpressoOSPreco(strEsp, strCodLay)) then
      Exit;

    if (strEsp = 'OS') then
      strTipImpr := fSaidaImpressao;

    if (strTipImpr <> 'V') then
      intQtdImp := fGetMenu('Qtd. Vias', ['1 Via', '2 Vias', '3 Vias', '4 Vias'], 1);

    pImprimir(intQtdImp, 1, tpaNormal, strEsp, strPDF, blnOK, strCodLay, strTipImpr);

    if (intDestino = 3) then
    begin
      pImprimir(intQtdImp, 2, tpaPDF, strEsp, strPDF, blnOkImp);
      If blnOkImp Then
        pEnviarOSEmail(strPDF);
    end;

    If (blnOk) and (fCfgSis('TERCEQ', varBoolean)) and (Copy(strTERROS, 1, 1) = 'S') Then
      pImprimirTermoResponsabilidade(intQtdImp, tpaNormal, strTpLayout, blnOK);
  End
  Else if IntDestino = 2 Then
  Begin
    pImprimir(intQtdImp, intDestino, tpaPDF, strEsp, strPDF, blnOK);
    If blnOk Then
      pEnviarOSEmail(strPDF);
  End;

  If Not blnOk Then
    pMensagemOk('Layout ' + strTpLayout + ' não está configurado.')
  else if (blnFluxoProcesso) and (tpProcessoFlx = tprEnviarCliente) then
  begin
    objConEqu.strFlxFas := 'O';
    objConEqu.strFlxSit := 'OR';
    objConEqu.strFlxCom := 'AC';
    objConEqu.pAlteraStatusDados(objConEqu.strStatus, objConEqu.strSubSta);
    objConEqu.pGravarLogFlx(blnFLuxoProcesso);
  end;
end;

procedure TfrmFatManConsertoEquip.btnImpSeparacaoClick(Sender: TObject);
begin
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Reimpressão de Separação.');

  objLiberacao.strDirAce := 'REISEP';
  objLiberacao.strSenLib := fCfgSis('REISEP');
  objLiberacao.strMsgSen := 'Reimpressão de Separação.';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;
  objLiberacao.blnUsarSenhaFixa := False;
  objLiberacao.blnSempreVariavelUsuario := True;


  If (Not objLiberacao.fLibera) Then
    Exit;

  pImprimePedidoSeparacao(False, True, False);
end;

procedure TfrmFatManConsertoEquip.btnManutencaoClick(Sender: TObject);
var
  blnConfIniMan :Boolean;
  iStatus: integer;
begin
  inherited;

  iStatus := 0;

  Try

    If Not objConEqu.fVerificaAcessoSistemaOS('ALTMAN', 'Liberado direito de acesso à manutenção de O.S.!', strLoginUsuarioLogado) Then
    Begin
      fMensagem('', 'Operador não tem direito de acesso à manutenção de O.S.!', ['&O k']);
      Exit;
    End;

    If (Assigned(objMeqMerEnt)) And (Not fEmptyStr(objMeqMerEnt.strAutGer)) And
       (Assigned(objMeqMerSai)) And (fEmptyStr(objMeqMerSai.strAutGer)) Then
    Begin
      fMensagem('ATENÇÃO', 'Para Reprovar a Ordem de Serviço é preciso realizar a emissão da Nota de Saída ' +
        'de remessa de equipamento para conserto. Operação cancelada!', ['&OK']);
      Exit;
    End;

    If (objConEqu.strStatus = 'N') And (objConEqu.strSubSta <> 'M') Then
    Begin
      fMensagem('', 'Não é possível alterar o status desta ordem de serviço pois a mesma não foi aprovada!', ['&Ok']);
    End
    Else If (fCfgSis('VALEXP', varString) = '1') And (fValidarExpedicao()) Then
    Begin
      pMostrarMensagemValidacaoExpedicao();
    End
    Else
    Begin
      blnConfIniMan := blnIniMan AND (fCfgSis('CALTOS') = 'S');

      If not blnConfIniMan Then
      begin
        iStatus := fGetMenu('', arrSubStatusManutencao, iStatus);
        blnConfIniMan := (fMensagem('', 'Confirma Manutenção?', ['&Sim', '&Não']) = 1);
      end;

      If blnConfIniMan Then
      Begin
        if not fValidaCampos(edtSenDig, True) then
          Exit;

        With objConEqu Do
        Begin

          pDefinirStatusAnt();

          Case iStatus Of
            1: strSubSta := 'C';
            2: strSubSta := 'A';
          End;

          strFlxFas := 'M';

          if strSubSta = 'C' then
          begin
            strFlxSit := 'MF';
            strFlxCom := 'AA';
          end
          else
          begin
            strFlxSit := 'AP';
            strFlxCom := 'AM';
          end;

          pAlteraStatusDados('M', strSubSta, '', False, strRetPor, strOsPdCl, strReaPor, strReaTel);

          pGravarLogSta(strLoginUsuarioLogado,
                        strStaAnt,
                        'M' + strSubSta,
                        strNumero,
                        strCodDig);

          pGravarLogFlx(blnFLuxoProcesso);
        End;

        fMensagem('', 'Concluído com sucesso!', ['&OK']);
        pLimpaTela;
      End;
    End;

  Except
    On e:exception do
      pMensagensErro(e.Message, 'btnRealizadaClick - untFatManConsertoEquip');
  End;
  
end;

procedure TfrmFatManConsertoEquip.btnMostraMargemClick(Sender: TObject);
var
  strOperador: String;
  frmMosMar : TfrmFatMostraMargemNovo;
  fltLimCre : Double;
  blnUtilizaVendaMadeira,
  blnUtilizaVendaVidro,
  blnUtilizaVendaMetroLinear,
  blnUsaUniLiq: Boolean;
begin
  if (fStrToFloat(lblTotPro.Caption) <= 0.0) then
    Exit;

  if (not fVerificaCampos) then
    Exit;

  btnCancelaItem.Click;

  blnUtilizaVendaMadeira := fCfgSis('VENMAD', varBoolean);
  blnUtilizaVendaVidro   := fCfgSis('VENVID', varBoolean);
  blnUtilizaVendaMetroLinear := fCfgSis('VENMTL', varBoolean);
  blnUsaUniLiq := (fAplicarTaxaJurosPrecoDigitado Or
            ((fCfgSis('EDIUNL', varBoolean)) And
             (Not blnUtilizaVendaMadeira) And
             (Not blnUtilizaVendaVidro) And
             (Not blnUtilizaVendaMetroLinear)));

  try
    blnMarLuc := True;
    pInicializarFatVenda;

    {*****************************************}
    {* TRATAMENTO DE SENHA FIXA, VARIAVEL OU *}
    {* POR USUÁRIO                           *}
    {**************************************WI*}
    if (not fEmptyStr(fCfgSis('SENMAR'))) then
    begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Visualizar Margem de Lucro');

      objLiberacao.strDirAce := 'MRGLU';
      objLiberacao.strSenLib := fCfgSis('SENMAR');
      objLiberacao.strMsgSen := 'Margem de Lucro';
      objLiberacao.strCodOpe := objEmitirPedido.objFatVenda.strCodVen;
      objLiberacao.strCodDig := objEmitirPedido.objFatVenda.strCodDig;
      objLiberacao.strCliente := edtCodCli.Text + '-' + edtNomCli.Text;
      objLiberacao.strCpfCnpj := objEmitirPedido.objFatVenda.strCliCgc;

      if (not objEmitirPedido.objFatVenda.fFatMensagemLiberacao(objLiberacao)) then
        Exit;
    end;

    cdsVenda.Filtered := False;
    cdsVenda.Filter   := 'ITE_CODITE <> ' + QuotedStr(fCfgSis('ITESER', varString));
    cdsVenda.Filtered := True;

    try
      objEmitirPedido.objFatVenda.blnRestringirElementosMargem := True;

      fltLimCre := 0;

      if (not objEmitirPedido.objFatVenda.fDocumentoParaFornecedor) then
        fltLimCre := fCampoTabela('CLI_LIMCRE', 'CADCLI', ['CLI_CODCLI'], [objEmitirPedido.objFatVenda.strCodCli], False);

      frmMosMar := TfrmFatMostraMargemNovo.Create(Self,
                                                  objEmitirPedido.objFatVenda,
                                                  Nil,
                                                  strOperador,
                                                  cbTabPrecoItem.Visible,
                                                  fltLimCre,
                                                  False,
                                                  False,
                                                  Nil,
                                                  Nil,
  //                                                IIF(blnFatDigDesconto, fatVenda.fltDesEsp, fltDesEspTmp),
                                                  objEmitirPedido.objFatVenda.fltDesEsp,
                                                  strCcnAnt,
                                                  False,
                                                  '',
                                                  blnUsaUniLiq);

      frmMosMar.blnConEqu := True;
      frmMosMar.ShowModal;

      if (frmMosMar.ModalResult = mrOk) then
      begin
        pAtualizaDadosMargemLucro(frmMosMar.cdsItens);
        objEmitirPedido.objFatVenda.fltDesEspF4 := frmMosMar.fGetDesEsp;
        objEmitirPedido.objFatVenda.blnAbriuF4 := True;
        objEmitirPedido.objFatVenda.FfltMarLuc := frmMosMar.fltTotMargem;
      end;
    except
      on E: Exception do
      begin
        cdsVenda.EnableControls;
        pMensagensErro(E.Message, '[pMostraMargem]');
      end;
    end;
  finally
    blnMarLuc := False;
    cdsVenda.Filtered := False;
    cdsVenda.Filter   := '';
    cdsVenda.Filtered := True;
    pFreeAndNil(frmMosMar);
  end;
end;

procedure TfrmFatManConsertoEquip.pEscapePressed;
begin
  if FblnGravandoOS then
    Exit;

  If dbgGrid.Focused Or dbgGridDfe.Focused Or dbgServico.Focused Or dbgGridAce.Focused Or dbgGridApo.Focused Then
  Begin
    If objConEqu.strStatus = 'E' Then
      btnCancelaItem.Click
    Else
    begin
      if fEhFluxoDadosOS then
        Close
      else
        pLimpaTela;
    end;
  End
  Else If (Assigned(ActiveControl)) And
          (((ActiveControl.Parent = pnlTopo) And (ActiveControl <> edtNumero)) Or
           ((ActiveControl.Parent = pnlBotton) And (ActiveControl <> edtNumero)) Or
           ((ActiveControl.Parent = pnlVendedor) And (ActiveControl <> edtNumero)) Or
           ((ActiveControl.Parent = pnlCliente) And (ActiveControl <> edtNumero)) Or
           ((ActiveControl.Parent = pnlCndPag) And (ActiveControl <> edtNumero)) Or
           (pnlBotoes.Focused) Or
           ((ActiveControl.Parent = pnlButtons) Or (ActiveControl.Parent = FlwPnlButtons)) ) Then
  Begin
    If fMensagem('ATENÇÃO!', 'Deseja abortar a operação?', ['&Sim', '&Não']) = 1 Then
      pLimpaTela;
  End
  Else If (Assigned(ActiveControl))
    And ((ActiveControl.Parent = pnlDefeitos)
     Or  (ActiveControl.Parent = pnlItens)
     Or  (ActiveControl.Parent = pnlServicos)
     Or  (ActiveControl.Parent = pnlAcessorios)) Then
  Begin

    If (ActiveControl.Parent = pnlItens) Then
      btnCancelaItem.Click()
    Else If (ActiveControl.Parent = pnlDefeitos) Then
      btnCancelaDfe.Click()
    Else If (ActiveControl.Parent = pnlServicos) Then
      btnCancelaSe1.Click()
    Else If (ActiveControl.Parent = pnlAcessorios) Then
      btnCancelaAce.Click();

    If (Not edtCodCli.ReadOnly) And (edtCodCli.Enabled) Then
      pSetFocus(edtCodCli);
  End
  Else If (Assigned(ActiveControl)) And ((ActiveControl.Parent = pnlTopo) Or(ActiveControl.Parent = pnlNumeroOS))And (edtNumero.Focused) Then
    Inherited;
end;

procedure TfrmFatManConsertoEquip.pExcluirAcessorio;
begin
  If btnConfirmar.Enabled Then
  Begin
    If (objConEqu.fPodeExcluirItensServicosDefeitos) And
       (Not objConEqu.cdsAceEqu.IsEmpty)    And
       (fMensagem('AVISO', 'Confirma a exclusão do acessório?', ['&Sim', '&Não']) = 1) Then
    Begin
      pRetiraDaListaConsulta(objConEqu.cdsAceEqu.FieldByName('CODACE').AsString,
                             'CODACE',
                             'ACE_CODACE',
                             sltAce,
                             objConEqu.cdsAceEqu,
                             cdsConsultaAce);
      objConEqu.cdsAceEqu.Delete;
      btnCancelaAce.Click();

      edtCodAce.Enabled := True;
      edtDesAce.Enabled := True;
      edtQtdAce.Enabled := True;
      btnCancelaAce.Enabled   := True;
      btnAdicionarAce.Enabled := True;
    End;
  End;
end;

procedure TfrmFatManConsertoEquip.pExcluirDefeito;
begin
  If btnConfirmar.Enabled Then
  Begin
    If (objConEqu.fPodeExcluirItensServicosDefeitos) And
       (Not objConEqu.cdsDfeEqu.IsEmpty)    And
       (fMensagem('AVISO', 'Confirma a exclusão do defeito?', ['&Sim', '&Não']) = 1) Then
    Begin
      pRetiraDaListaConsulta(objConEqu.cdsDfeEqu.FieldByName('CODDFE').AsString,
                             'CODDFE',
                             'DFE_CODIGO',
                             sltDfe,
                             objConEqu.cdsDfeEqu,
                             cdsConsultaDfe);
      objConEqu.cdsDfeEqu.Delete;
      btnCancelaDfe.Click();

      edtCodDfe.Enabled := True;
      edtDesDfe.Enabled := True;
      btnCancelaDfe.Enabled   := True;
      btnAdicionarDfe.Enabled := True;
    End;
  End;
end;

procedure TfrmFatManConsertoEquip.pExcluirKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);

  Var
    strCodSerAtu: String;

  function fPossuiServicoDuplicado(strCodSer: String): Boolean;
  begin
    Try
      objConEqu.cdsSerEqu.DisableControls;
      objConEqu.cdsSerEqu.Filtered := False;
      objConEqu.cdsSerEqu.Filter   := 'CODSER = ' + strCodSer;
      objConEqu.cdsSerEqu.Filtered := True;

      Result := (objConEqu.cdsSerEqu.RecordCount > 1);
    Finally
      objConEqu.cdsSerEqu.Filtered := False;
      objConEqu.cdsSerEqu.Filter   := '';
      objConEqu.cdsSerEqu.EnableControls;

      objConEqu.cdsSerEqu.Locate('CODSER', strCodSerAtu, []);
    End;
  end;

begin
  If (Key = VK_DELETE) Then
  Begin
    If (pnlDefeitos.Parent = frmFatVendaItem) Then
      pExcluirDefeito()
    Else If (pnlItens.Parent = frmFatVendaItem) Then
      pExcluirProduto()
    Else If (pnlAcessorios.Parent = frmFatVendaItem) Then
      pExcluirAcessorio()
    Else If (pnlServicos.Parent = frmFatVendaItem) Then
    Begin
      strCodSerAtu := objConEqu.cdsSerEqu.FieldByName('CODSER').AsString;

      If (fPossuiServicoDuplicado(strCodSerAtu)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Existe mais de 1 registro para o serviço selecionado para exclusão. Operação cancelada!', ['&OK']);
        btnCancelaSe1.Click;
      End
      Else
      Begin
        pExcluirServico();
      End;
    End;

    frmFatVendaItem.Close();
  End
  Else If (Key = VK_ESCAPE) Then
    frmFatVendaItem.Close()
  Else
    frmFatVendaItem.FormKeyDown(Sender, Key, Shift);
end;

procedure TfrmFatManConsertoEquip.pCalcPorDes;
var fltDesEsp,
    fltPorDes,
    fltValDes,
    fltVlrPro: Double;
begin
  if objConEqu.fltPorDes <> 0 then
  begin
    fltPorDes := objConEqu.fltPorDes;
    fltVlrPro := objConEqu.fltVlrPro + objConEqu.fltDesEsp;
    fltDesEsp := (fltPorDes / 100) * fltVlrPro;
    fltValDes := objConEqu.fltValDes;

    objConEqu.fltDesEsp := (fltDesEsp + fltValDes);
  end;

end;

procedure TfrmFatManConsertoEquip.pExcluirProduto;
begin
  If (pnlItens.Enabled)                    And
     (objConEqu.fPodeExcluirItensServicosDefeitos) And
     (Not objConEqu.cdsIteEqu.IsEmpty)     And
     (fMensagem('AVISO', 'Confirma a exclusão do item?', ['&Sim', '&Não']) = 1) Then
  Begin
    objConEqu.fltVlrPro := objConEqu.fltVlrPro - (objConEqu.cdsIteEqu.fieldbyname('TOTITE').AsFloat - objConEqu.cdsIteEqu.fieldbyname('DESESP').AsFloat);
    objConEqu.fltVlrCon := objConEqu.fltVlrCon - objConEqu.cdsIteEqu.fieldbyname('VLRCON').AsFloat;
    pRetiraDaListaConsulta(objConEqu.cdsIteEqu.FieldByName('CODITE').AsString,
                           'CODITE',
                           'ITE_CODITE',
                           sltItems,
                           objConEqu.cdsIteEqu,
                           cdsConsultaItem);

    objConEqu.cdsIteEqu.Delete;

    If (objConEqu.cdsIteEqu.IsEmpty) Then
    begin
      objConEqu.fltDesEsp := 0;
      objConEqu.fltPorDes := 0;
      objConEqu.fltValDes := 0;
    end;

    pAplicarDescontoServicos();
    pCalcPorDes;
    pInicializarFatVenda();
    pAtualizaTotais;
    btnCancelaItem.Click();

    objConEqu.fAtualizaSaldos;
  End;
end;

procedure TfrmFatManConsertoEquip.pExcluirReqCompra;
var
  qryReq,
  qryFGOEQU: TUniQuery;
begin
  qryReq    := fCriaQuery;
  qryFGOEQU := fCriaQuery(Self);

  try
    qryReq.SQL.Text :=
      'SELECT DISTINCT RCD_CODIGO, RCD_CODEMP ' +
      'FROM MOVRCD ' +
      'WHERE RCD_SEQCOT IS NULL   ' +
      '  AND RCD_SEQPCD IS NULL   ' +
      '  AND RCD_DOCPDV = :DOCPDV ' +
      '  AND RCD_ESPPDV = :ESPPDV ' +
      '  AND RCD_EMPPDV = :EMPPDV ';

    qryFGOEQU.Close;
    qryFGOEQU.SQL.Text := SELECT_PD_EQUGOR;
    qryFGOEQU.ParamByName('SEQEQU').AsString := objConEqu.strAutInc;
    qryFGOEQU.Open;

    if (not qryFGOEQU.IsEmpty) then
    begin
      while not qryFGOEQU.Eof do
      begin
        qryReq.Close;
        qryReq.ParamByName('DOCPDV').AsString := qryFGOEQU.FieldByName('NUMDOC').AsString;
        qryReq.ParamByName('ESPPDV').AsString := 'PD';
        qryReq.ParamByName('EMPPDV').AsString := qryFGOEQU.FieldByName('CODEMP').AsString;
        qryReq.Open;

        while not qryReq.Eof do
        begin
          pExcluiRequisicaoCompra(qryReq.FieldByName('RCD_CODIGO').AsString, qryReq.FieldByName('RCD_CODEMP').AsString, Self.Name);
          qryReq.Next;
        end;

        qryFGOEQU.Next;
      end;
    end
    else
    begin
      qryReq.Close;
      qryReq.ParamByName('DOCPDV').AsString := objConEqu.strNumPed;
      qryReq.ParamByName('ESPPDV').AsString := 'PD';
      qryReq.ParamByName('EMPPDV').AsString := objConEqu.strEmpPed;
      qryReq.Open;

      while not qryReq.Eof do
      begin
        pExcluiRequisicaoCompra(qryReq.FieldByName('RCD_CODIGO').AsString, qryReq.FieldByName('RCD_CODEMP').AsString, Self.Name);
        qryReq.Next;
      end;
    end;
  finally
    FreeAndNil(qryFGOEQU);
    FreeAndNil(qryReq);
  end;
end;

procedure TfrmFatManConsertoEquip.pExcluirServico;
begin
  If (btnConfirmar.Enabled) And (Not objConEqu.blnPermiteAltTec) Then
  Begin
    If (objConEqu.fPodeExcluirItensServicosDefeitos) And
       (Not objConEqu.cdsSerEqu.IsEmpty)    And
       (fMensagem('AVISO', 'Confirma a exclusão do serviço?', ['&Sim', '&Não']) = 1) Then
    Begin
      objConEqu.fltVlrCon := objConEqu.fltVlrCon - objConEqu.cdsSerEqu.fieldbyname('VALSER').AsFloat;
      objConEqu.fltVlrSer := objConEqu.fltVlrSer - objConEqu.cdsSerEqu.fieldbyname('VALSER').AsFloat;
      objConEqu.fltDesEspSer := objConEqu.fltDesEspSer - objConEqu.cdsSerEqu.fieldbyname('DESESP').AsFloat;

      pRetiraDaListaConsulta(objConEqu.cdsSerEqu.FieldByName('CODSER').AsString, 'CODSER', 'SER_CODSER', sltServ, objConEqu.cdsSerEqu, cdsConsultaServ);
      objConEqu.cdsSerEqu.Delete;

      lblTotGer.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltVlrCon);
      lblTotPro.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltVlrPro);
      lblTotSer.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltVlrSer);
      lblTotDes.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltDesEsp + objConEqu.fltDesEspSer);
      lblTotST.Caption  := FormatFloat(fMskDigitos(2), objConEqu.fltTotRet);
      lblTotIPI.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltTotIPI);
      lblTotRef.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltTotCbs + objConEqu.fltTotIbs + objConEqu.fltTotIs);

      btnCancelaSe1.Click();

      strCodSerOld := '';

      Application.ProcessMessages;
    End;
  End;
end;

procedure TfrmFatManConsertoEquip.pExibeValores;
var
  blnVisible: Boolean;
begin
  if blnRotinaTecnico then
    Exit;

  if fVerificaAcessoSistema('EXVACE', strLoginUsuarioLogado) then
    Exit;

  if (objConEqu.strFlxFas = 'A') or (objConEqu.strFlxFas = 'T') then
    blnVisible := False
  else
    blnVisible := True;

  Label12.Visible := blnVisible;
  edtUnitar.Visible := blnVisible;
  Label15.Visible := blnVisible;
  edtTotIte.Visible := blnVisible;
  chkBrindePro.Visible := blnVisible and fCfgSis('USABRI', varBoolean);
  lblTabPrecoItem.Visible := blnVisible and (fCfgSis('TABITE', varBoolean)) And (fCfgSis('TBPOSE', varBoolean));
  cbTabPrecoItem.Visible := lblTabPrecoItem.Visible;
  fFindColumnByName(dbgGrid, 'TABPRE').Visible := lblTabPrecoItem.Visible;
  fFindColumnByName(dbgGrid, 'UNITAR').Visible := blnVisible;
  fFindColumnByName(dbgGrid, 'VLRCON').Visible := blnVisible;
  fFindColumnByName(dbgGrid, 'VALIPI').Visible := blnVisible;
  fFindColumnByName(dbgGrid, 'VALRET').Visible := blnVisible;
  fFindColumnByName(dbgGrid, 'VALCBS').Visible := blnVisible and fSomarNovosImpostosDaReformaAoValorContabil;
  fFindColumnByName(dbgGrid, 'VALIBS').Visible := fFindColumnByName(dbgGrid, 'VALCBS').Visible;
  fFindColumnByName(dbgGrid, 'VAL_IS').Visible := fFindColumnByName(dbgGrid, 'VALCBS').Visible;
  fFindColumnByName(dbgGrid, 'BRINDE').Visible := chkBrindePro.Visible;
  fFindColumnByName(dbgGrid, 'TIPBRI').Visible := chkBrindePro.Visible;
  fFindColumnByName(dbgGrid, 'PROMOC').Visible := blnVisible;
  pnlMostraPrecoProd.Visible := blnVisible;
  pnlAg_Pec.Visible := blnVisible;
  pnlDadosItem.Visible := blnVisible;

  lblValSer.Visible := blnVisible;
  edtValSe1.Visible := blnVisible;
  chkBrindeSer.Visible := blnVisible and fCfgSis('USABRI', varBoolean);
  fFindColumnByName(dbgServico, 'VALUNI').Visible := blnVisible;
  fFindColumnByName(dbgServico, 'DESESP').Visible := blnVisible;
  fFindColumnByName(dbgServico, 'VALSER').Visible := blnVisible;
  fFindColumnByName(dbgServico, 'BRINDE').Visible := chkBrindeSer.Visible;
  fFindColumnByName(dbgServico, 'TIPBRI').Visible := chkBrindeSer.Visible;

//  pnlTotal.Visible := blnVisible;
  lblLegTotPro.Visible := blnVisible;
  lblLegTotSer.Visible := blnVisible;
  lblLegTotDes.Visible := blnVisible;
  lblLegTotGer.Visible := blnVisible;
  lblTotPro.Visible := blnVisible;
  lblTotSer.Visible := blnVisible;
  lblTotDes.Visible := blnVisible;
  lblTotGer.Visible := blnVisible;

  lblTotST.Visible  := blnVisible and (objConEqu.fltTotRet > 0);
  lblTotIPI.Visible := blnVisible and (objConEqu.fltTotIpi > 0);
  lblTotFre.Visible := blnVisible and (objConEqu.fltValFre > 0);
  lblTotRef.Visible := blnVisible and fSomarNovosImpostosDaReformaAoValorContabil and (objConEqu.fltTotCbs + objConEqu.fltTotIbs + objConEqu.fltTotIs > 0);

  lblST.Visible  := lblTotST.Visible;
  lblIPI.Visible := lblTotIPI.Visible;
  lblFre.Visible := lblTotFre.Visible;
  lblRef.Visible := lblTotRef.Visible;
end;

procedure TfrmFatManConsertoEquip.pExibirDadosFazenda(AExibir: Boolean);
begin
  AExibir := AExibir and Assigned(objConEqu.objFazenda) and (not fEmptyStr(objConEqu.objFazenda.strCodFaz));

  if (not AExibir) then
  begin
    if pnlFazenda.Visible then
    begin
      pnlCliente.Height := pnlCliente.Height - pnlFazenda.Height;
      pnlGrpBox.Height  := pnlGrpBox.Height  - pnlFazenda.Height;
      pnlTopo.Height    := pnlTopo.Height    - pnlFazenda.Height;
    end;

    pnlFazenda.Visible := False;
    edtFazenda.Clear;
  end
  else
  begin
    if (not pnlFazenda.Visible) then
    begin
      pnlFazenda.Visible := True;

      pnlTopo.Height    := pnlTopo.Height    + pnlFazenda.Height;
      pnlGrpBox.Height  := pnlGrpBox.Height  + pnlFazenda.Height;
      pnlCliente.Height := pnlCliente.Height + pnlFazenda.Height;
    end;

    edtFazenda.Text := 'FAZENDA: ' + objConEqu.objFazenda.strCodFaz  + ' - ' +
                                     objConEqu.objFazenda.strNomFaz  + ' - ' +
                                Trim(objConEqu.objFazenda.strEndere  + ' '   +
                                     objConEqu.objFazenda.strEndNum  + ' '   +
                                     objConEqu.objFazenda.strEndCom) + ' - ' +
                                     objConEqu.objFazenda.strBairro  + ' - ' +
                                     objConEqu.objFazenda.strNomCid  + ' - ' +
                                     objConEqu.objFazenda.strEstado  ;
  end;
end;

procedure TfrmFatManConsertoEquip.pgcTabsChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
  If pgcTabs.ActivePage = tbsServicos Then
    pgcServicos.ActivePageIndex := 0;
  If (not blnRotinaTecnico) Then
  Begin
    pnlMostraPrecoProd.visible := pnlItens.enabled;
    pnlMostraPrecoServ.visible := pnlServicos.enabled;
  End;
end;

procedure TfrmFatManConsertoEquip.pHabilitaChkVendaPresencial;
var
  blnEhPresencialPelaAbreviacao: Boolean;
begin

  If Not Assigned(objEmitirPedido.objFatVenda) Then
    Exit;

  If (objEmitirPedido.objFatVenda.fAtendeRegrasDifal(True) Or objConEqu.blnVenPre) Then
  Begin
    blnEhPresencialPelaAbreviacao := ((objEmitirPedido.objFatVenda.GetTipAbf = '_SAI_NCO') And (fCfgSis('DIFVNP', VarBoolean))) Or
                                     ((objEmitirPedido.objFatVenda.GetTipAbf = '_SAI_CCO') And (fCfgSis('DIFVNC', VarBoolean))) Or
                                     ((objEmitirPedido.objFatVenda.GetTipAbf = '_SAI_PRU') And (fCfgSis('DIFPRU', VarBoolean)));

    chkVenPre.Visible := True;
    chkVenPre.Enabled := True;
    chkVenPre.Checked := IIF((dtsIteEqu.DataSet.RecordCount = 0) and (dtsServico.DataSet.RecordCount = 0), blnEhPresencialPelaAbreviacao, objConEqu.blnVenPre);
  End
  Else
  Begin
    chkVenPre.Visible := False;
    chkVenPre.Enabled := False;
    chkVenPre.Checked := False;
  End;

  chkVenPreClick(chkVenPre);
  RedimensionaRevendaRetornarDeixadoPor;
end;

procedure TfrmFatManConsertoEquip.pHabilitaLocRet;
begin
  pnlLocRet.Visible := cmbEntRet.Visible and fCfgSis('LOCRET', VarBoolean) and (cmbEntRet.ItemIndex = IDX_RETIRA);
  cmbLocRet.Enabled := pnlLocRet.Visible;

  if pnlLocRet.Visible and fCfgSis('LOCRET', varBoolean) and fCfgSis('EQUEXP', varBoolean) then
  begin
    cmbLocRet.Enabled := True;

    if (not objConEqu.cdsIteEqu.IsEmpty) then
    begin
      cmbLocRet.Enabled := False;
      cmbLocRet.ItemIndex := fRetIndexLocalRetira(objConEqu.cdsIteEqu.Fieldbyname('LOCRET').AsString, cmbLocRet.Items);
    end;
  end;
end;

procedure TfrmFatManConsertoEquip.pHabilitaNFCompraAnaliseTec;
begin
  if (not blnFluxoProcesso) then
    Exit;

  if (tpProcessoFlx <> tprDefPrdSer) then
    Exit;

  edtNFComp.Enabled := cbGarant.ItemIndex > 0;
  mskDtNFCo.Enabled := edtNFComp.Enabled;
end;

procedure TfrmFatManConsertoEquip.pHabilitaPainelLegendas;
begin
  blnTemItemEsp := False;
  blnTemItemInativoCmp := False;

  pHabilitaPnlLegendaItemEsp;
  pHabilitaPnlLegendaInativoCmp;

  pnlLegItemEsp.Visible := blnTemItemEsp;
  pnlLegInativoCmp.Visible := blnTemItemInativoCmp;
end;

procedure TfrmFatManConsertoEquip.pHabilitaPnlLegendaInativoCmp;
var
  cdsDados: TUniClientDataSet;
begin
  if objConEqu.cdsIteEqu.IsEmpty then
    Exit;

  cdsDados := TUniClientDataSet.Create(Self);

  try
    pCloneDataSet(cdsDados, objConEqu.cdsIteEqu);

    cdsDados.First;
    while not cdsDados.Eof do
    begin
      blnTemItemInativoCmp := cdsDados.FieldByName('ATICOM').AsString = 'N';

      if blnTemItemInativoCmp then
        Break;

      cdsDados.Next;
    end;
  finally
    FreeAndNil(cdsDados);
  end;
end;

procedure TfrmFatManConsertoEquip.pHabilitaPnlLegendaItemEsp;
var
  cdsDados: TUniClientDataSet;
begin
  if objConEqu.cdsIteEqu.IsEmpty then
    Exit;

  cdsDados := TUniClientDataSet.Create(Self);

  try
    pCloneDataSet(cdsDados, objConEqu.cdsIteEqu);

    cdsDados.First;
    while not cdsDados.Eof do
    begin
      blnTemItemEsp := cdsDados.FieldByName('ITEESP').AsString = 'S';

      if blnTemItemEsp then
        Break;

      cdsDados.Next;
    end;
  finally
    FreeAndNil(cdsDados);
  end;
end;

procedure TfrmFatManConsertoEquip.pHabilitarCamposAlterarTecnicoServico(blnHabilitar: Boolean);
begin
  pnlServicos.Enabled  := blnHabilitar;
  edtCodSe1.Enabled    := False;
  edtDesSe1.Enabled    := False;
  edtCodTecSe1.Enabled := blnHabilitar;
  edtDesTecSe1.Enabled := False;
  edtValSe1.Enabled    := False;
  edtQtdSe1.Enabled    := False;
  chkBrindeSer.Enabled := False;
  chkCobAPaSer.Enabled := False;
end;

procedure TfrmFatManConsertoEquip.pHabilitarCamposRealizada(blnHabilitar: Boolean);
var
  LAlturaFaz: Integer;
begin
  LAlturaFaz := IIF(pnlFazenda.Visible, pnlFazenda.Height, 0);

  pnlGrpBox.Height := 260 + LAlturaFaz;

  If (blnHabilitar) Then
  Begin
    pnlRealizada.Visible    := True;
    cmbStaRealizada.Visible := True;
    edtRetiradoPor.Visible  := True;
    lblStaRealizada.Visible := True;
    lblRetiradoPor.Visible  := True;
    pnlTopo.Height          := 290 + LAlturaFaz;
  End
  Else
  Begin
    pnlRealizada.Visible      := False;
    pnlTopo.Height            := 266 + LAlturaFaz;
    cmbStaRealizada.ItemIndex := -1;
    edtRetiradoPor.Text       := '';
    cmbStaRealizada.Visible   := False;
    edtRetiradoPor.Visible    := False;
    lblStaRealizada.Visible   := False;
    lblRetiradoPor.Visible    := False;
  End;
end;

procedure TfrmFatManConsertoEquip.pHabilitarEdicaoCamposRealizadaReprovada;

  function fEnabledRealizada: Boolean;
  begin
    Result := (objConEqu.strStatus = 'R');
  end;

  function fEnabledRealizadaNaoFaturada: Boolean;
  begin
    Result := (objConEqu.strStatus = 'R') And (AlterarClientePagtoObsDescOSRealizada) and (not objConEqu.fPedidoJaFaturado());
  end;

  function fEnabledReprovada: Boolean;
  begin
    Result := (objConEqu.strStatus = 'N');
  end;
var
  JaFaturado : Boolean;
begin
  JaFaturado := objConEqu.fPedidoJaFaturado();

  If (objConEqu.strStatus = 'R') and ((not blnFluxoProcesso) or (blnFluxoProcesso and ((tpProcessoFlx <> tprDadosOS) or (tpImpressaoFlx = fpEditar)))) Then
  Begin
    pnlTopo.Enabled   := True;
    pnlCndPag.Enabled := True;

    edtCodCnd.Enabled    := fEnabledRealizadaNaoFaturada();
    mskCndPag.Enabled    := fEnabledRealizadaNaoFaturada();
    edtCodCli.Enabled    := fEnabledRealizadaNaoFaturada();

    edtObs.Enabled    := fEnabledRealizada();
    edtObsGer.Enabled := edtObs.Enabled;
    edtObsNFS.Enabled := edtObs.Enabled;

    if (not AlterarClientePagtoObsDescOSRealizada) and (not InformarNFEntSaiAlterarObsOSRealizadaReprovada) then
    begin
      edtObs.Enabled    := False;
      edtObsGer.Enabled := False;
      edtObsNFS.Enabled := False;
    end;

    pnlBotton.Enabled := fEnabledRealizada() or (blnFluxoProcesso and (tpProcessoFlx in [tprDefPrdSer, tprRealizarMan]));

    edtDesCndPag.Enabled := False;
    edtForPag.Enabled    := False;
    edtDesForPag.Enabled := False;

    edtRetiradoPor.Enabled  := True;
    cmbStaRealizada.Enabled := True;

    edtDisSer.ReadOnly := (objConEqu.fPedidoJaFaturado());
    edtDisSer.Enabled  := (Not edtDisSer.ReadOnly);

    If ( (Not InformarNFEntSaiAlterarObsOSRealizadaReprovada) And (fCfgSis('EQUREA', varString) = '2') ) Then
    Begin
      pnlRealizada.Visible := True;
    End;
  End
  Else
  Begin
    edtCodCli.Enabled    := fEhFluxoDadosOS and (tpImpressaoFlx = fpEditar);
    edtCodCnd.Enabled    := fEhFluxoDadosOS and (tpImpressaoFlx = fpEditar);
    mskCndPag.Enabled    := fEhFluxoDadosOS and (tpImpressaoFlx = fpEditar);
    edtDesCndPag.Enabled := False;
    edtForPag.Enabled    := False;
    edtDesForPag.Enabled := False;
    edtCodEqu.Enabled    := False;
    edtDesEqu.Enabled    := False;
    edtDesMar.Enabled    := False;
    edtVoltag.Enabled    := False;

    edtObs.Enabled    := fEnabledReprovada();
    edtObsGer.Enabled := edtObs.Enabled;
    edtObsNFS.Enabled := edtObs.Enabled;
    pnlBotton.Enabled := fEnabledReprovada() or ((blnFluxoProcesso) and (tpProcessoFlx in [tprDadosOS, tprDefPrdSer, tprRealizarMan]));
    pnlTopo.Enabled   := fEnabledReprovada() or (blnFluxoProcesso);
  End;

  edtNOSFab.Enabled  := edtNOSFab.Visible and blnFluxoProcesso and (not (tpProcessoFlx in [tprDefPrdSer, tprRealizarMan]));
  pnlRepDig.Enabled  := False;
  edtCodEqu.Enabled  := False;

  If (Not ((objConEqu.strStatus = 'N') And (InformarNFEntSaiAlterarObsOSRealizadaReprovada))) and
    ((not blnFluxoProcesso) or (fEhFluxoDadosOS and (tpImpressaoFlx <> fpEditar))) Then
  begin
    edtLocFis.Enabled := False;
    edtCodLoc.Enabled := False;
    edtDesLoc.Enabled := False;
  end;

  cbGarant.Enabled   := fPermiteEditarGarantia;

  if blnFluxoProcesso and ((tpProcessoFlx <> tprDadosOS) or ((tpProcessoFlx = tprDadosOS) and (tpImpressaoFlx <> fpEditar))) then
  begin
    edtDesEqu.Enabled  := False;
    edtDesMar.Enabled  := False;
    edtVoltag.Enabled  := False;
    edtNSerie.Enabled  := False;
    edtNFComp.Enabled  := False;
    mskDtNFco.Enabled  := False;
    edtNFReme.Enabled  := False;
    mskDtNFRe.Enabled  := False;
    edtRevend.Enabled  := False;
    edtConRet.Enabled  := False;
    edtDeiPor.Enabled  := False;
    mskEntreg.Enabled  := False;
    edtDiaEnt.Enabled  := False;
    edtCntCli.Enabled  := False;
    mskCntTel.Enabled  := False;
    edtNumPat.Enabled  := False;
    edtDadFab.Enabled  := False;
    edtTmpGar.Enabled  := False;
    edtNOSAnt.Enabled  := False;
    mskDtEAnt.Enabled  := False;
    mskDtRAnt.Enabled  := False;
    cbEstPrd.Enabled   := cbEstPrd.Visible and (fVerificaAcessoSistema('AEPCET'));
  end;

  If blnFluxoProcesso Then
    chkAutDescarte.Enabled := (Not ((tpProcessoFlx = tprDadosOS) And (tpImpressaoFlx = fpConsultar)))
  Else
    chkAutDescarte.Enabled := True;

  if (not blnFluxoProcesso) then
  begin
    dbgGrid.Enabled    := False;
    dbgGridDfe.Enabled := False;
    dbgServico.Enabled := False;
    dbgGridAce.Enabled := False;
    dbgGridApo.Enabled := False;
  end;

  if fEhFluxoDadosOS then
  begin
    edtObs.Enabled    := (tpImpressaoFlx = fpEditar);
    edtObsGer.Enabled := edtObs.Enabled;
    edtObsNFS.Enabled := edtObs.Enabled;
  end;

  btnConfirmar.Visible := (not blnOSCancelada);

  if fPermiteHabilitarDocsFiscaisRef then
  begin
    grbDocEntrada.Enabled := InformarNFEntSaiAlterarObsOSRealizadaReprovada;
    grbDocSaida.Enabled   := InformarNFEntSaiAlterarObsOSRealizadaReprovada;
  end;

  btnConfirmar.Enabled  := True;

  If (objConEqu.blnPermiteAltDig) or (blnFluxoProcesso and
    ((tpProcessoFlx in [tprDocsFiscais, tprDefPrdSer, tprOrcamento, tprRealizarMan]) or ((tpProcessoFlx = tprDadosOS) and (tpImpressaoFlx = fpEditar)))) Then
  Begin
    edtSenDig.Text := '';
    edtNomDig.Text := '';

    pnlRepDig.Enabled := True;
    edtCodRep.Enabled := False;
    edtSenDig.Enabled := True;
  End;

  If (objConEqu.blnPermiteAltTec) Then
  Begin
    pnlVendedor.Enabled := True;
    edtSenVen.Enabled := False;
    edtCodTec.Enabled := True;

    dbgServico.Enabled := True;
  End;

  edtProtoc.Enabled := False;

  objConEqu.strOperac := 'A';
  cbTabPreco.Enabled  := (not fEnabledReprovada) and (not jaFaturado) and (not InformarNFEntSaiAlterarObsOSRealizadaReprovada);

  if (not blnFluxoProcesso) or ((tpProcessoFlx <> tprDadosOS) or (tpImpressaoFlx = fpEditar)) then
    btnDesEsp.Visible   := (not fEnabledReprovada) and (not jaFaturado) and (AlterarClientePagtoObsDescOSRealizada);
  btnMostraMargem.Enabled := (not fEnabledReprovada) and (not jaFaturado);
  pAlteraTelaRotinaTecnico;
end;

procedure TfrmFatManConsertoEquip.pImportaProdutosServicos(strNum_OS: String);
var
  qryAux: TUniQuery;
begin
  Try
    pLimparProdutosServicosImportados;

    stlCodIteImportado.Clear;
    stlCodSerImportado.Clear;

    qryAux := fCriaQuery(Self);

    {*** IMPORTAÇÃO PRODUTOS ***}
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT EQUDET.*, UNI_SIGUNI FROM EQUDET     ');
    qryAux.SQL.Add('LEFT JOIN CADUNI ON EQU_UNIDAD = UNI_CODUNI ');
    qryAux.SQL.Add('WHERE EQU_NUMOSE = :NUMOSE   ');
    qryAux.SQL.Add('    AND EQU_CODEMP = :CODEMP ');
    qryAux.SQL.Add('ORDER BY EQU_CODITE          ');
    qryAux.ParamByName('NUMOSE').AsString := strNum_OS;
    qryAux.ParamByName('CODEMP').AsString := strCodEmpOSAnt;
    qryAux.Open;

    qryAux.First;

    While Not qryAux.Eof Do
    Begin
      objConEqu.strCodIte := qryAux.FieldByName('EQU_CODITE').AsString;
      objConEqu.strEntRet := qryAux.FieldByName('EQU_ENTRET').AsString;
      objConEqu.strLocRet := qryAux.FieldByName('EQU_LOCRET').AsString;
      objConEqu.strDesite := qryAux.FieldByName('EQU_DESCRI').AsString;
      objConEqu.strRefere := qryAux.FieldByName('EQU_REFERE').AsString;
      objConEqu.strUnidad := qryAux.FieldByName('UNI_SIGUNI').AsString;
      objConEqu.strCodUni := qryAux.FieldByName('EQU_UNIDAD').AsString;
      objConEqu.fltQtdIte := qryAux.FieldByName('EQU_QTDITE').AsFloat;
      objConEqu.fltUnitar := qryAux.FieldByName('EQU_UNITAR').AsFloat;
      objConEqu.fltUniOri := qryAux.FieldByName('EQU_UNIORI').AsFloat;
      objConEqu.fltUniVis := qryAux.FieldByName('EQU_UNIVIS').AsFloat;
      objConEqu.fltTaxJur := qryAux.FieldByName('EQU_TAXJUR').AsFloat;
      objConEqu.fltPerDes := qryAux.FieldByName('EQU_PERDES').AsFloat;
      objConEqu.fltTotCus := qryAux.FieldByName('EQU_TOTCUS').AsFloat;
      objConEqu.fltTotIte := qryAux.FieldByName('EQU_TOTITE').AsFloat;
      objConEqu.strAguard := qryAux.FieldByName('EQU_AGUARD').AsString;
      objConEqu.strTabPreIte := qryAux.FieldByName('EQU_TABPRE').AsString;

      objConEqu.cdsIteEqu.Last;
      objConEqu.cdsIteEqu.DisableControls;
      objConEqu.pAdicionaItem('I');
      objConEqu.cdsIteEqu.EnableControls;

      stlCodIteImportado.Add(objConEqu.strCodIte);

      qryAux.Next;
    End;

    {*** IMPORTAÇÃO SERVIÇOS ***}
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT * FROM EQUSER         ');
    qryAux.SQL.Add('WHERE EQU_NUMOSE = :NUMOSE   ');
    qryAux.SQL.Add('    AND EQU_CODEMP = :CODEMP ');
    qryAux.SQL.Add('ORDER BY EQU_CODSER          ');
    qryAux.ParamByName('NUMOSE').AsString := strNum_OS;
    qryAux.ParamByName('CODEMP').AsString := strCodEmpOSAnt;
    qryAux.Open;

    qryAux.First;

    While Not qryAux.Eof Do
    Begin
      objConEqu.strCodSer := qryAux.FieldByName('EQU_CODSER').AsString;
      objConEqu.strDesSer := qryAux.FieldByName('EQU_DESSER').AsString;
      objConEqu.strTecSer := qryAux.FieldByName('EQU_TECSER').AsString;
      objConEqu.strBrinde := qryAux.FieldByName('EQU_BRINDE').AsString;
      objConEqu.strCodPar := qryAux.FieldByName('EQU_CODPAR').AsString;
      objConEqu.strTipBri := qryAux.FieldByName('EQU_TIPBRI').AsString;
      objConEqu.fltPorDes := qryAux.FieldByName('EQU_PORDES').AsFloat;
      objConEqu.fltValUni := qryAux.FieldByName('EQU_VALUNI').AsFloat;
      objConEqu.fltValSer := qryAux.FieldByName('EQU_VALSER').AsFloat;
      objConEqu.fltQtdSer := qryAux.FieldByName('EQU_QTDSER').AsFloat;

      objConEqu.cdsSerEqu.Last;
      objConEqu.cdsSerEqu.DisableControls;
      objConEqu.pIncluiServicoGrid;
      objConEqu.cdsSerEqu.EnableControls;

      stlCodSerImportado.Add(objConEqu.strCodSer);

      qryAux.Next;
    End;
  Except
    On e:exception do
      pMensagensErro(e.Message, 'pImportaProdutosServicos');
  End;

  If (not blnFluxoProcesso) Then
  begin
    if (Not objConEqu.cdsIteEqu.IsEmpty) then
      pgcTabs.ActivePage := tbsProdutos
    else if (Not objConEqu.cdsSerEqu.IsEmpty) then
      pgcTabs.ActivePage := tbsServicos;
  end;
end;

procedure TfrmFatManConsertoEquip.pImprimePedidoSeparacao(blnImpPed, blnImpSep, blnVerificaAltSep: Boolean);
  Var
    imImpSep : TDadosImprimePdOrSep;
    imImpPdOr: TDadosImprimePdOrSep;
    arrMatItens: TMatrizFechamento;
    objFatVendaImp: TFatVendaImp;
    dadosImpressao: TDadosImpressaoVenda;
    arrMatItensExcluidos: TMatrizFechamento;
    arrMatItensNovos: TMatrizFechamento;
    cdsLogItensSep: TUniClientDataSet;

  procedure pAdicionaItemExcluido(i: Integer; fltQtde: Double = -1);
  var
    j: Integer;
  Begin
    j := length(arrMatItensExcluidos) + 1;
    SetLength(arrMatItensExcluidos, j);

    arrMatItensExcluidos[j-1].strCodIte := arrMatItensIni[i].strCodIte;
    arrMatItensExcluidos[j-1].strEntRet := arrMatItensIni[i].strEntRet;
    arrMatItensExcluidos[j-1].strLocRet := arrMatItensIni[i].strLocRet;
    arrMatItensExcluidos[j-1].strBrinde := arrMatItensIni[i].strBrinde;
    arrMatItensExcluidos[j-1].fltQtdIte := IIF(fltQtde > -1, fltQtde, arrMatItensIni[i].fltQtdIte);
    arrMatItensExcluidos[j-1].strDesIte := arrMatItensIni[i].strDesIte;
    arrMatItensExcluidos[j-1].strUnidad := arrMatItensIni[i].strUnidad;
    arrMatItensExcluidos[j-1].strAutoincrementoGravacao := arrMatItensIni[i].strAutoincrementoGravacao;
    arrMatItensExcluidos[j-1].strEmpIte := arrMatItensIni[i].strEmpIte;

  End;

  procedure pAdicionaItemNovo(i: Integer; fltQtde: Double = -1);
  var
    j: Integer;
  Begin
    j := length(arrMatItensNovos) + 1;
    SetLength(arrMatItensNovos, j);

    arrMatItensNovos[j-1].strCodIte := arrMatItens[i].strCodIte;
    arrMatItensNovos[j-1].strEntRet := arrMatItens[i].strEntRet;
    arrMatItensNovos[j-1].strLocRet := arrMatItens[i].strLocRet;
    arrMatItensNovos[j-1].strBrinde := arrMatItens[i].strBrinde;
    arrMatItensNovos[j-1].fltQtdIte := IIF(fltQtde > -1, fltQtde,arrMatItens[i].fltQtdIte);
    arrMatItensNovos[j-1].strDesIte := arrMatItens[i].strDesIte;
    arrMatItensNovos[j-1].strUnidad := arrMatItens[i].strUnidad;
    arrMatItensNovos[j-1].strAutoincrementoGravacao := arrMatItens[i].strAutoincrementoGravacao;
    arrMatItensNovos[j-1].strEmpIte := arrMatItens[i].strEmpIte;

  End;

  procedure pComparaItens;
    var
      i: Integer;
      j: Integer;
      blnExcluido: Boolean;
      blnAdicionado: Boolean;
  Begin
    If Length(arrMatItens) > 0 Then
    Begin
      For i := Low(arrMatItensIni) To High(arrMatItensIni) Do
      Begin
        blnExcluido   := True;
        For j := Low(arrMatItens) To High(arrMatItens) Do
        Begin
          If arrMatItens[j].strAutoincrementoGravacao = arrMatItensIni[i].strAutoincrementoGravacao Then
          Begin
            blnExcluido := False;

            If arrMatItens[j].fltQtdIte > arrMatItensIni[i].fltQtdIte Then
              pAdicionaItemNovo(j, arrMatItens[j].fltQtdIte - arrMatItensIni[i].fltQtdIte);

            If arrMatItens[j].fltQtdIte < arrMatItensIni[i].fltQtdIte Then
              pAdicionaItemExcluido(j, arrMatItensIni[i].fltQtdIte - arrMatItens[j].fltQtdIte);

            break;
          End;
        End;
        If blnExcluido Then
          pAdicionaItemExcluido(i);
      End;

      For i := Low(arrMatItens) To High(arrMatItens) Do
      Begin
        blnAdicionado := True;
        For j := Low(arrMatItensIni) To High(arrMatitensIni) Do
        Begin

          If arrMatItens[i].strAutoincrementoGravacao = arrMatItensIni[j].strAutoincrementoGravacao Then
          Begin
            blnAdicionado := False;
            break;
          End;

        End;

        If blnAdicionado Then
          pAdicionaItemNovo(i);
      End;

    End;
  End;

  procedure pCriacdsLogItensSep;
  begin
    If Assigned(cdsLogItensSep) Then
      cdsLogItensSep.EmptyDataSet
    Else
      cdsLogItensSep := fCriaTemporaria(Self);
  end;


  procedure pCriarArrMatItens;
    Var
      i: Integer;
  begin
    objConEqu.cdsIteEqu.DisableControls();
    objConEqu.cdsIteEqu.First();

    i := 0;
    SetLength(arrMatItens, objConEqu.cdsIteEqu.RecordCount);

    While (Not objConEqu.cdsIteEqu.Eof) Do
    Begin
      arrMatItens[i].strCodIte := objConEqu.cdsIteEqu.FieldByName('CODITE').AsString;
      arrMatItens[i].strEntRet := objConEqu.cdsIteEqu.FieldByName('ENTRET').AsString;
      arrMatItens[i].strLocRet := objConEqu.cdsIteEqu.FieldByName('LOCRET').AsString;
      arrMatItens[i].strBrinde := objConEqu.cdsIteEqu.FieldByName('BRINDE').AsString;
      arrMatItens[i].fltQtdIte := objConEqu.cdsIteEqu.FieldByName('QTDITE').AsFloat;
      arrMatItens[i].strDesIte := objConEqu.cdsIteEqu.FieldByName('DESITE').AsString;
      arrMatItens[i].strUnidad := objConEqu.cdsIteEqu.FieldByName('UNIDAD').AsString;
      arrMatItens[i].strAutoincrementoGravacao := objConEqu.cdsIteEqu.FieldByName('INCORI').AsString;
      arrMatItens[i].strEmpIte := objConEqu.strCodEmp;

      objConEqu.cdsIteEqu.Next();
      i := i + 1;
    End;

    objConEqu.cdsIteEqu.EnableControls()
  end;

  procedure pInsereItensSep(strTipo: String = 'I');
    var
      i: Integer;
      arrMatItensTmp: TMatrizFechamento;
  Begin

    If strTipo = 'E' Then
      arrMatItensTmp := arrMatItensExcluidos
    Else
      arrMatItensTmp := arrMatItensNovos;

    For i := Low(arrMatItensTmp) To High(arrMatItensTmp) Do
    Begin
      cdsLogItensSep.Append;
      cdsLogItensSep.FieldByName('AUTOINCREM').AsString := '0';
      cdsLogItensSep.FieldByName('ITE_CODITE').AsString := arrMatItensTmp[i].strCodIte;
      cdsLogItensSep.FieldByName('ITE_DESITE').AsString := arrMatItensTmp[i].strDesIte;
      cdsLogItensSep.FieldByName('ITE_QTDITE').AsFloat  := arrMatItensTmp[i].fltQtdIte;
      If strTipo = 'E' Then
        cdsLogItensSep.FieldByName('ITE_QTDANT').AsFloat  := arrMatItensTmp[i].fltQtdIte;
      cdsLogItensSep.FieldByName('ITE_STALOG').AsString := strTipo;
      cdsLogItensSep.FieldByName('ITE_DESUNI').AsString := arrMatItensTmp[i].strUnidad;
      cdsLogItensSep.FieldByName('ITE_EMPITE').AsString := arrMatItensTmp[i].strEmpIte;
      cdsLogItensSep.Post;
    End;
  End;

begin
  objFatVendaImp := TFatVendaImp.Create;

  Try
    dadosImpressao.strOpcDoc := 'PD';
    dadosImpressao.strNumDoc := objConEqu.strNumPed;
    dadosImpressao.strEspDoc := 'PD';

    If (fEmptyStr(objConEqu.strCliGar)) Then
      dadosImpressao.strCodCli := objConEqu.strCodCli
    Else
      dadosImpressao.strCodCli := objConEqu.strCliGar;

    dadosImpressao.strEmpDoc := objConEqu.strCodEmp;

    dadosImpressao.fltTotGer := objConEqu.fltVlrCon;

    If (objConEqu.fltVlrCon = 0) Then
      dadosImpressao.blnPedOrcBrinde := True;

    imImpPdOr := TDadosImprimePdOrSep.Create;

    If (blnImpPed) Then
      imImpPdOr.imImpDoc := imPerguntaSeImprime
    Else
      imImpPdOr.imImpDoc := imNaoImprime;

    imImpSep := TDadosImprimePdOrSep.Create;

    blnImpSep := blnImpSep and fValidaImpSepAprFluxo;

    dadosImpressao.blnImprimeSep := blnImpSep;

    pCriarArrMatItens();
    If blnVerificaAltSep Then
    Begin
      pComparaItens;
      dadosImpressao.blnItensDiferentes := (length(arrMatItensExcluidos) > 0) Or (length(arrMatItensNovos) > 0);
      pCriacdsLogItensSep;
    End;

    If (length(arrMatItensNovos) > 0) Then
    Begin
      pInsereItensSep;
      dadosImpressao.strMensNovo := 'ITENS ADICIONADOS';
    End;

    If (length(arrMatItensExcluidos) > 0) Then
    Begin
      pInsereItensSep('E');
      dadosImpressao.strMensExcluido := 'ITENS EXCLUÍDOS';
    End;

    If dadosImpressao.blnItensDiferentes Then
      dadosImpressao.cdsLogSep := cdsLogItensSep;

    If assigned(dadosImpressao.cdsLogSep) Then
      dadosImpressao.cdsLogSep.Open;

    dadosImpressao.arrMatItens := arrMatItens;

    If (blnImpSep) Then
    Begin
      imImpSep.imImpDoc  := imPerguntaSeImprime;
      imImpSep.intQtdVia := 1;
    End
    Else
    Begin
      imImpSep.imImpDoc := imNaoImprime;
    End;

    objFatVendaImp.Add(dadosImpressao);
    objFatVendaImp.pImprimeDocumento(objFatVendaImp[0], imImpPdOr, imImpSep);
  Finally
    FreeAndNil(objFatVendaImp);
    SetLength(arrMatItens, 0);
  End;
end;

procedure TfrmFatManConsertoEquip.pImprimirEtiqueta(strNumero: string);
Var
    prmDllEtq: TParamDllEtiquetas;
    blnImpEti: Boolean;
    strTipImp: String;
begin
  strTipImp := fCfgSis('ETIQOS', varString);

  Try
//    pFreeLibraryEtiquetas;

    blnImpEti := True;

    prmDllEtq := TParamDllEtiquetas.Create;

    If strTipImp = 'L' Then
      prmDllEtq.tpeTipEtq := tpeOrdemServicoLaser

    Else If strTipImp = 'A' Then
      prmDllEtq.tpeTipEtq := tpeOrdemServicoArgox

    Else If strTipImp = 'Z' Then
      prmDllEtq.tpeTipEtq := tpeOrdemServicoZebra;

    prmDllEtq.strCodEmp := ShortString(String(VS_strCodEmp));
    prmDllEtq.strNumDoc := ShortString(strNumero);
    prmDllEtq.blnImpEti := blnImpEti;

    fImprimeEtiqueta(prmDllEtq);
  Finally
    FreeAndNil(prmDllEtq);
  End;
end;

procedure TfrmFatManConsertoEquip.pImprimirFluxo;
var
  blnPDF,
  blnExcel,
  blnImpr,
  blnEmail,
  blnOk,
  blnWhatsapp: Boolean;
  strEsp,
  strPDF,
  strTpLayout,
  strCodLay,
  strArquivosAnexo,
  strTipImpr: string;
  intQtdImp: Integer;
  frmConsertoEquipImpr: TfrmConsertoEquipImpr;
begin
  inherited;
  strNomArqExcel := '';

  pCriarFormularios(TfrmConsertoEquipImpr, frmConsertoEquipImpr);

  try
    frmConsertoEquipImpr.ShowModal;

    if (not frmConsertoEquipImpr.blnConfirma) then
      Exit;

    blnPDF   := frmConsertoEquipImpr.blnPDF;
    blnExcel := frmConsertoEquipImpr.blnExcel;
    blnImpr  := frmConsertoEquipImpr.blnImpr;
    blnEmail := frmConsertoEquipImpr.blnEmail;
    blnWhatsapp := frmConsertoEquipImpr.blnWhatsapp;
  finally
    pFreeAndNil(frmConsertoEquipImpr);
  end;

  if blnExcel and (not fPermiteGerarExcel) then
    Exit;

  intQtdImp := 1;
  strCodLay := '';

  blnOK := False;
  strTpLayout := 'Ordem de Serviço';
  strEsp := 'OS';

  if not fValidaTravaFluxoEnviarCliente then
    Exit;

  if (blnExcel) then
    if (not fChamaTelaGravando(fGeraExcel, 'Gerando planilha...')) then
      Exit;

  if (blnImpr) Then
  Begin
    if (not fValidaImpressoOSPreco(strEsp, strCodLay)) then
      Exit;

    strTipImpr := fSaidaImpressao;

    if (strTipImpr <> 'V') then
      intQtdImp := fGetMenu('Qtd. Vias', ['1 Via', '2 Vias', '3 Vias', '4 Vias'], 1);

    pImprimir(intQtdImp, 1, tpaNormal, strEsp, strPDF, blnOK, strCodLay, strTipImpr);

    if (blnOk) and (fCfgSis('TERCEQ', varBoolean)) and (Copy(strTERROS, 1, 1) = 'S') then
      pImprimirTermoResponsabilidade(intQtdImp, tpaNormal, strTpLayout, blnOK);
  end;

  if (blnEmail) or (blnWhatsapp) then
  begin
    if blnPDF then
    begin
      pImprimir(intQtdImp, 2, tpaPDF, strEsp, strPDF, blnOK);

      if blnOk then
        strArquivosAnexo := strPDF;
    end;

    if blnExcel and (not fEmptyStr(strNomArqExcel)) Then
      strArquivosAnexo := IIF((not fEmptyStr(strArquivosAnexo)), strArquivosAnexo + IIF(blnEmail, ';', ','), '') + strNomArqExcel;

    if blnEmail then
      pEnviarOSEmail(strArquivosAnexo, blnPDF)
    else if blnWhatsapp then
      pEnviarOSWhatsapp(strArquivosAnexo);
  end;

  if blnExcel and (not fEmptyStr(strNomArqExcel)) Then
    fMensagem('','Arquivo ' + strNomArqExcel + ' gerado com sucesso!', ['&Ok'], 1, False, 1, 0, False, 0, False, False, False, 0, 650);

  if (not blnOk) and blnPDF then
    pMensagemOk('Layout ' + strTpLayout + ' não está configurado.')
  else if (tpProcessoFlx = tprEnviarCliente) then
  begin
    objConEqu.strFlxFas := 'O';
    objConEqu.strFlxSit := 'OR';
    objConEqu.strFlxCom := 'AC';
    objConEqu.pAlteraStatusDados(objConEqu.strStatus, objConEqu.strSubSta);
    objConEqu.pGravarLogFlx(blnFLuxoProcesso);
  end;
end;

procedure TfrmFatManConsertoEquip.pImprimirOrdemExecucao(intQtdImp: Integer; tpArquivo: TTipoArquivo);
var
  strPDF: String;
  blnOK : Boolean;
begin
  blnOK := False;

  pImprimir(intQtdImp, 1, tpArquivo, 'OSOE', strPDF, blnOK);

  if (not blnOk) then
    pMensagemOk('Layout Ordem de Execução de Serviço não está configurado.');
end;

procedure TfrmFatManConsertoEquip.pImprimirTermoResponsabilidade(intQtdImp: Integer; tpArquivo: TTipoArquivo; var strTpLayout: String; blnOK: Boolean);
var
  strPDF: String;
begin
  if TTermoResposabilidade.fExisteArqModTermoResponsabilidade then
    TTermoResposabilidade.fGeraTermoResponsabilidade(objConEqu.strNumero,
                                                    objConEqu.strCodEmp,
                                                    StrToDate(objConEqu.strDtaEnt),
                                                    '',
                                                    0,
                                                    Self)
  else
  begin
    pImprimir(intQtdImp, 1, tpaNormal, 'OSTR', strPDF, blnOK);

    if not blnOk Then
      strTpLayout := 'Termo de Responsabilidade';
  end;
end;

procedure TfrmFatManConsertoEquip.pIncluiNaListaConsulta(strCampo, strCampoConsulta: String; stlLista: TStringList; cdsDados, cdsConsulta: TUniClientDataSet);
  Var
    intRecNo: Integer;
    intIndice: Integer;
    strCodigo: String;
Begin
  If (Not Assigned(cdsDados)) Or (cdsDados.IsEmpty) Then
    Exit;

  strCodigo := cdsDados.FieldByName(strCampo).AsString;
  If Not stlLista.Find(QuotedStr(strCodigo), intIndice) Then
    stlLista.Add(QuotedStr(strCodigo));

  If Assigned(cdsConsulta) And (Not cdsConsulta.IsEmpty) Then
  Begin
    With cdsConsulta Do
    Begin
      intRecNo := RecNo;
      If Locate(strCampoConsulta, strCodigo, []) Then
      Begin
        Edit;
        FieldByName('VENDIDO').AsInteger := 1;
        Post;
      End;
      RecNo := intRecNo;
    End;
  End;
end;

function TfrmFatManConsertoEquip.fInicializarObjFrmPnlItem: TPanelCxItem;
begin
  Result := TPanelCxItem.New();

  Result.sltLista           := sltItems;
  Result.strNomForm         := Self.Name;
  Result.recParametros.strCodCli := objConEqu.strCodCli;
  Result.recParametros.strTabPre := objConEqu.strTabPre;
  Result.strCodVen          := objConEqu.strCodVen;
  Result.strCodDig          := objConEqu.strCodDig;
  Result.procVendasPerdidas := nil;
  Result.blnFaturamento     := True;
  Result.strSenVen          := edtSenVen.Text;
  Result.strEmprCD          := '';
  Result.blnPedCorte        := False;
  Result.strOpcDoc          := '';
  Result.strEmpIte          := objConEqu.strCodEmp;
  Result.strEmpSal          := objConEqu.strCodEmp;
  Result.blnExiSalDisCD     := False;
  Result.procRelVendasPerdidas := nil;

  If pnlCndPag.Visible Then
    Result.intPraMedio := fFloatToInt(fCalcMediaPagto(mskCndPag.Text))
  Else
    Result.intPraMedio := 0;

  Result.fncTeclaTab := fVendeItem;
end;

procedure TfrmFatManConsertoEquip.edtNumeroKeyPress(Sender: TObject;
  var Key: Char);
  Var
    strStatus,
    strSubsta,
    strSituac,
    strFone  : String;
    arrSel   : TConsultasArray;
    intOpcoes: Integer;
    objfrmPnl: TPanelCxConsertoEquip;
    dtaOS    : TDatetime;

    function fFone: String;
    begin
      Result := ' IF(IFNULL(EQU_NOMCON, "") <> "", EQU_TELCON, CLI_FONE01) '
    end;

begin
  inherited;

  strStatus := SELECT_STATUS_OS;
  strSubsta := SELECT_SUBSTA_OS;
  strSituac := SELECT_SITUAC_OS;
  strFone   := fFone;

  If fEntraCons(Key) Then
  Begin
    If (blnRotinaTecnico) Then
    Begin
      intOpcoes := 1;
    End
    Else
    Begin
      intOpcoes := fMensagem('','Selecione o status da ordem de serviço:', ['Abertas', 'Baixadas', 'Todas'], 3);
    End;

    objfrmPnl := TPanelCxConsertoEquip.Create(TfrmPnlLegendaConsertoEquip);

    If fPesqOrdServ(Self,
                    edtNumero,
                    qryEquGer,
                    Key,
                    arrSel,
                    dtaOS,
                    strStatus,
                    strFone,
                    True,
                    'Consulta de Ordens de Serviço' + IIF(blnRotinaTecnico, ' - Tecnico', ''),
                    intOpcoes,
                    strSubsta,
                    strSituac,
                    objfrmPnl,
                    '',
                    '',
                    False,
                    blnRotinaTecnico) Then
    Begin
      If edtCodEmp.Visible Then
      Begin
        edtCodEmp.Text := qryEquGer.FieldByName('EQU_CODEMP').AsString;
        fValidaCampos(edtCodEmp, True);
      End;

      objConEqu.strRetPor := '';
      objConEqu.strOsPdCl := '';

      fValidaCampos(edtNumero, True);
    End;
  End;

end;

procedure TfrmFatManConsertoEquip.edtObsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: pEscapePressed;
  End;

end;

procedure TfrmFatManConsertoEquip.edtForPagKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrForma: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) And (Not edtForPag.ReadOnly) Then
  Begin
    {***********************************}
    {* NOVA CONSULTA DE FORMA DE PAGTO *}
    {********************************RV*}
    If fPesqFormaPgto(conFpgBaiAvi, Self, edtForPag, edtDesForPag, Nil, Key, arrForma) Then
    Begin
      If (fValidaCampos(edtForPag, True)) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
    pCarregaForPag;
  End;
end;

procedure TfrmFatManConsertoEquip.edtLocFisKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If blnCadLoc And fPesqLocFisica(Self, edtLocFis, Nil, Nil, Key, arrSel) And fValidaCampos(edtLocFis, True) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmFatManConsertoEquip.dbgGridCellClick(Column: TColumn);
var
  frmFatManConEquExibeSaldo: TfrmFatManConEquExibeSaldo;
begin
  inherited;

  if (Column.FieldName = 'COPCFB') and (Column.Field.AsString = 'S') then
    Clipboard.AsText := objConEqu.cdsIteEqu.FieldByName('CODFAB').AsString;

  if (Column.FieldName = 'COPREF') and (Column.Field.AsString = 'S') then
    Clipboard.AsText := objConEqu.cdsIteEqu.FieldByName('REFERE').AsString;

  if (Column.FieldName = 'ABRSAL') and (Column.Field.AsString = 'S') then
  begin
    try
      pCriarFormularios(TfrmFatManConEquExibeSaldo, frmFatManConEquExibeSaldo);
      frmFatManConEquExibeSaldo.objConEqu := objConEqu;
      frmFatManConEquExibeSaldo.ShowModal;
    finally
      pFreeAndNil(frmFatManConEquExibeSaldo);
    end;
  end;
end;

procedure TfrmFatManConsertoEquip.dbgGridColEnter(Sender: TObject);
begin
  inherited;
  pLimpaDadosItem;
end;

procedure TfrmFatManConsertoEquip.edtNFCompKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
    strStatus,
    strSubsta,
    strSituac,
    strFone: String;
    dtaNFComp: TDatetime;
    objfrmPnl: TPanelCxNFCompra;
    qryOSAnt: TUniQuery;

    function fFone: String;
    begin
      Result := ' IF(IFNULL(EQU_NOMCON, "") <> "", EQU_TELCON, CLI_FONE01) '
    end;
begin
  inherited;

  if Not CharInSet(key, ['0'..'9','/','?',#8]) then
    key := #0;

  If fEntraCons(Key) Then
  Begin
    If (lblNroDoc.Caption = 'NF Compra:') Then
    Begin
      objfrmPnl := TPanelCxNFCompra.Create(TfrmPnlDadosNFCompra);
      If fPesqNFCompra(Self, edtNFComp, nil, Key, arrSel, VS_strCodEmp, dtaNFComp, True, objfrmPnl, 'Consulta de NF de Compra', edtCodCli.Text) Then
      Begin
        If fValidaCampos(edtNFComp, True) Then
        Begin
          mskDtNFco.Text := DateToStr(dtaNFComp);
          self.SelectNext(ActiveControl, True, True);
        End;
      End;
      FreeAndNil(objfrmPnl);
    End
    Else
    Begin
      strStatus := SELECT_STATUS_OS;
      strSubsta := SELECT_SUBSTA_OS;
      strSituac := SELECT_SITUAC_OS;
      strFone   := fFone;

      qryOSAnt := fCriaQuery;

      try
        If fPesqOrdServ(Self, edtNFComp, qryOSAnt, Key, arrSel, dtaNFComp, strStatus, strFone, True, 'Consulta de Ordens de Serviço', 3, strSubsta, strSituac, Nil, edtCodCli.Text, edtNumero.Text, False, False) Then
        Begin
          strCodEmpOSAnt := qryOSAnt.FieldByName('EQU_CODEMP').AsString;

          If fValidaCampos(edtNFComp, True) Then
          Begin
            mskDtNFco.Text := DateToStr(dtaNFComp);
            self.SelectNext(ActiveControl, True, True);
            edtCodEqu.Text := qryOSAnt.FieldByName('EQU_CODEQU').AsString;
            fValidaCampos(edtCodEqu, True);
          End;
        End;
      finally
        FreeAndNil(qryOSAnt);
      end;
    End;
  End;
end;

procedure TfrmFatManConsertoEquip.edtNFRemeKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel   : TConsultasArray;
  dtaNFReme: TDatetime;
begin
  inherited;

  if not CharInSet(key, ['0'..'9','/','?',#8]) then
    key := #0;

  if fEntraCons(Key) then
  begin
    if fPesqNFCompra(Self, edtNFReme, nil, Key, arrSel, VS_strCodEmp, dtaNFReme, True, {objfrmPnl} nil, 'Consulta de NF de Remessa', edtCodCli.Text) then
    begin
      if fValidaCampos(edtNFReme, True) then
      begin
        mskDtNFRe.Text := DateToStr(dtaNFReme);
        self.SelectNext(ActiveControl, True, True);
      end;
    end;
  end;
end;

procedure TfrmFatManConsertoEquip.edtNOSAntExit(Sender: TObject);
begin
  inherited;
  if fEmptyStr(edtNOSAnt.Text) then
  begin
    mskDtEAnt.Clear;
    mskDtRAnt.Clear;

    objConEqu.strNOSAnt := '';
    objConEqu.dtaDtEAnt := 0;
    objConEqu.dtaDtRAnt := 0;
  end
  else if (edtNOSAnt.Text) <> objConEqu.strNOSAnt then
    pCarregaDadosOSAnterior;
end;

procedure TfrmFatManConsertoEquip.edtNumeroEnter(Sender: TObject);
begin
  inherited;
  If (not blnRotinaTecnico) Then
  Begin
    pnlInfo.Caption       := 'Passar em branco para novo registro.';
  End;
  if edtCodEmp.Visible then
    RedimensionaDesEmp(False);

  pnlInfo.Font.Color    := clBlue;
  lblNovaOrdem.Visible  := False;
  btnObservacao.Enabled := False;
  btnHisSta.Enabled     := False;
  btnImpEti.Enabled     := False;
  mskDtaInc.Clear;
end;

procedure TfrmFatManConsertoEquip.edtNumeroExit(Sender: TObject);
begin
  inherited;

  pnlInfo.Caption := '';
  pnlInfo.Font.Color := clBlack;

  If blnRotinaTecnico Then
  Begin
    pSetFocus(edtSenDig);
    Exit;
  End;

  If fEmptyStr(edtNumero.Text) Then
  Begin
    if edtCodEmp.Visible then
      RedimensionaDesEmp(True);
    lblNovaOrdem.Visible  := True;
    edtDisSer.Enabled     := True;
    btnObservacao.Enabled := False;
    btnHisSta.Enabled     := False;
    btnImpEti.Enabled     := False;
    cbGarant.ItemIndex    := 0;
    cbGarantChange(cbGarant);
    mskDtaInc.Text := DateToStr(Date);
  End
  Else
  Begin
    if edtCodEmp.Visible then
      RedimensionaDesEmp(False);
    btnObservacao.Enabled := True;
    btnHisSta.Enabled     := True;
    btnImpEti.Enabled     := True;

    if (StrToDateDef(objConEqu.strDtaEnt, 0) <> 0) and (not fEmptyStr(objConEqu.strNumero)) then
      mskDtaInc.Text := objConEqu.strDtaEnt
    else
      mskDtaInc.Clear;
  End;
end;

procedure TfrmFatManConsertoEquip.btnObservacaoClick(Sender: TObject);
begin
  inherited;

  {*****************************************}
  {* SE ESTIVER TUDO EM BRANCO, SAI        *}
  {**************************************MV*}

  If (fEmptyStr(objConEqu.strNumero)) Then
    Exit;

  Try
    pCriarFormularios(TfrmFatObsOrdemServico, frmFatObsOrdemServico);
    frmFatObsOrdemServico.strCodCli := objConEqu.strCodCli;
    frmFatObsOrdemServico.strCodEmp := objConEqu.strCodEmp;
    frmFatObsOrdemServico.strNumOse := objConEqu.strNumero;
    frmFatObsOrdemServico.memObserv.Texto := objConEqu.strObserv;
    frmFatObsOrdemServico.showModal;
    objConEqu.strObserv := frmFatObsOrdemServico.memObserv.Text;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[pMostraObsCliente]');
  End;

  pFreeAndNil(frmFatObsOrdemServico);

end;

procedure TfrmFatManConsertoEquip.btnOrdMaoObrCliClick(Sender: TObject);
var
  frmFatManDigOrdemMaoObraCli: TfrmFatManDigOrdemMaoObraCli;
  cdsDados: TUniClientDataSet;
begin
  try
    try
      cdsDados := TUniClientDataSet.Create(Self);
      pCloneDataSet(cdsDados, objConEqu.cdsSerEqu);

      pCriarFormularios(TfrmFatManDigOrdemMaoObraCli, frmFatManDigOrdemMaoObraCli);
      frmFatManDigOrdemMaoObraCli.cdsDados.Data := cdsDados.Data;

      If (frmFatManDigOrdemMaoObraCli.ShowModal = mrOK) Then
      Begin
        frmFatManDigOrdemMaoObraCli.cdsDados.First;

        While Not frmFatManDigOrdemMaoObraCli.cdsDados.Eof Do
        Begin
          If objConEqu.cdsSerEqu.Locate('CODSER', frmFatManDigOrdemMaoObraCli.cdsDados.FieldByName('CODSER').AsString, []) Then
          Begin
            objConEqu.cdsSerEqu.Edit;
            objConEqu.cdsSerEqu.FieldByName('MAOCLI').AsString := frmFatManDigOrdemMaoObraCli.cdsDados.FieldByName('MAOCLI').AsString;
            objConEqu.cdsSerEqu.Post;
          End;

          frmFatManDigOrdemMaoObraCli.cdsDados.Next;
        End;
      End;
    except
      On E: Exception Do
        pMensagensErro(E.Message, 'TfrmFatManConsertoEquip.btnOrdMaoObrCliClick');
    end;
  finally
    pFreeAndNil(frmFatManDigOrdemMaoObraCli);
    FreeAndNil(cdsDados);
  end;
end;

procedure TfrmFatManConsertoEquip.btnPedCompraItensClick(Sender: TObject);
  Var
    cdsVenda: TUniClientDataSet;
begin
  Try
    cdsVenda := fCriaTemporaria(Self);

    objConEqu.cdsIteEqu.DisableControls();
    objConEqu.cdsIteEqu.First();

    While (Not objConEqu.cdsIteEqu.Eof) Do
    Begin
      cdsVenda.Append();

      cdsVenda.FieldByName('AUTOINCREM').AsInteger := objConEqu.cdsIteEqu.FieldByName('SEQITE').AsInteger;
      cdsVenda.FieldByName('ITE_CODITE').AsString := objConEqu.cdsIteEqu.FieldByName('CODITE').AsString;
      cdsVenda.FieldByName('ITE_DESITE').AsString := objConEqu.cdsIteEqu.FieldByName('DESITE').AsString;
      cdsVenda.FieldByName('ITE_CODUNI').AsString := objConEqu.cdsIteEqu.FieldByName('UNIDAD').AsString;
      cdsVenda.FieldByName('ITE_QTDITE').AsFloat  := objConEqu.cdsIteEqu.FieldByName('QTDITE').AsFloat;
      cdsVenda.FieldByName('ITE_UNITAR').AsFloat  := objConEqu.cdsIteEqu.FieldByName('UNITAR').AsFloat;
      cdsVenda.FieldByName('ITE_TOTITE').AsFloat  := objConEqu.cdsIteEqu.FieldByName('TOTITE').AsFloat;
      cdsVenda.FieldByName('ITE_NUMCMP').AsString := objConEqu.cdsIteEqu.FieldByName('NUMCMP').AsString;
      cdsVenda.FieldByName('ITE_NITCMP').AsString := objConEqu.cdsIteEqu.FieldByName('NITCMP').AsString;

      if (objConEqu.cdsIteEqu.FieldByName('DTACMP').AsDateTime <> 0) then
        cdsVenda.FieldByName('ITE_DTACMP').AsDateTime := objConEqu.cdsIteEqu.FieldByName('DTACMP').AsDateTime;

      cdsVenda.Post();
      objConEqu.cdsIteEqu.Next();
    End;

    objConEqu.cdsIteEqu.EnableControls();

    pCriarFormularios(TfrmFatDigPedidoCompraItens, frmFatDigPedidoCompraItens);
    frmFatDigPedidoCompraItens.cdsDados.Data := cdsVenda.Data;
    frmFatDigPedidoCompraItens.strCodCli     := objConEqu.strCodCli;
    frmFatDigPedidoCompraItens.strCodVen     := objConEqu.strCodVen;
    frmFatDigPedidoCompraItens.strNumDoc     := objConEqu.strNumPed;
    frmFatDigPedidoCompraItens.strEspDoc     := 'PD';
    frmFatDigPedidoCompraItens.strCodEmp     := objConEqu.strEmpPed;

    If (frmFatDigPedidoCompraItens.ShowModal = mrOK) Then
    Begin
      With frmFatDigPedidoCompraItens.cdsDados Do
      Begin
        First;

        While Not Eof Do
        Begin
          If objConEqu.cdsIteEqu.Locate('CODITE;SEQITE', VarArrayOf([FieldByName('ITE_CODITE').AsString, FieldByName('AUTOINCREM').AsString]), []) Then
          Begin
            objConEqu.cdsIteEqu.Edit();
            objConEqu.cdsIteEqu.FieldByName('NUMCMP').AsString := FieldByName('ITE_NUMCMP').AsString;
            objConEqu.cdsIteEqu.FieldByName('NITCMP').AsString := FieldByName('ITE_NITCMP').AsString;
            objConEqu.cdsIteEqu.FieldByName('DTACMP').AsDateTime := FieldByName('ITE_DTACMP').AsDateTime;
            objConEqu.cdsIteEqu.Post();
          End;

          Next();
        End;
      End;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, 'TfrmFatManConsertoEquip.btnPedCompraItensClick');
  End;

  pFreeAndNil(frmFatDigPedidoCompraItens);
  pFreeAndNil(cdsVenda);
end;

procedure TfrmFatManConsertoEquip.pEnderecoToOS;
begin
  If Not fEmptyStr(objEndEnt.recEndere.strIncrem) Then
    objConEqu.strEntGer := objEndEnt.recEndere.strIncrem;
//  objConEqu.strCliEnd := objEndEnt.recEndere.strEndEnt;
//  objConEqu.strCliBai := objEndEnt.recEndere.strBaiEnt;
//  objConEqu.strCliCep := fTiraCaracEspeciais(objEndEnt.recEndere.strCepEnt);
//  objConEqu.strCodCid := objEndEnt.recEndere.strCidEnt;
//  objConEqu.strCliCid := fRetNomCidade(objEndEnt.recEndere.strCidEnt,0);
//  objConEqu.strCliEst := fRetNomCidade(objEndEnt.recEndere.strCidEnt,1);
//  objConEqu.strCliTel := objEndEnt.recEndere.strTelEnt;
end;

procedure TfrmFatManConsertoEquip.pEntradaNF;
  Var
    frmEntMercadorias : TfrmEntMercadorias;
begin
  try
    try
      pCriarFormularios(TfrmEntMercadorias, frmEntMercadorias);
      frmEntMercadorias.blnSemInc      := False;
      frmEntMercadorias.strCodFor      := edtCodCli.Text;
      frmEntMercadorias.blnConEqu      := True;
      frmEntMercadorias.edtEspDoc.Text := 'NF';
      frmEntMercadorias.ShowModal;

      If frmEntMercadorias.blnConfirma Then
      Begin
        If Not Assigned(objMeqMerEnt) Then
          objMeqMerEnt := TMeqMer.Create;

        pClonaDadosNF(frmEntMercadorias.objMeqMer);
        objMeqMerEnt.strAutEqu := objConEqu.strAutInc;
        objMeqMerEnt.strEmpEqu := objConEqu.strCodEmp;
        objMeqMerEnt.strNumOse := objConEqu.strNumero;

        If objConEqu.strOperac = 'A' Then
          TConEqu.fVinculaOSemNotaFiscal(objMeqMerEnt);

        pCarregaDadosNFEntSai;
        pSolicitaEquipamentoNFEntrada;
      End;
    except
      on E: Exception Do
        pMensagensErro(E.Message, '[TfrmFatManConsertoEquip.pEntradaNF]');
    end;
  finally
    pFreeAndNil(frmEntMercadorias);
  end;
end;

procedure TfrmFatManConsertoEquip.pEntradaNF_XML(blnConsultaNFe: Boolean);
  Var
    recNotEle: TRecInfoNotaEletronica;
    blnEncontrouEntrada: Boolean;
    qryGerEle: TUniQuery;
    chrKey: Char;
    arrDigNota: TConsultasArray;
    frmEntMercadorias : TfrmEntMercadorias;

  function fGetAutoincremGerEle: String;
  begin
    Result := fCampoTabela('AUTOINCREM',
                           'GERELE',
                           ['PR07_CHNFE'],
                           [recNotEle.str_Chave]);
  end;
begin
  blnEncontrouEntrada := False;

  If (Not blnConsultaNFe) Then
  Begin
    recNotEle := TfrmEntImportacaoNotaEletronica.fImportar(xmlConsertoEquipamento, edtCodCli.Text, True);
    recNotEle.strAutInc := fGetAutoincremGerEle();

    blnEncontrouEntrada := (Not fEmptyStr(recNotEle.str_Chave))
                       And (Not fEmptyStr(recNotEle.strAutInc));
  End
  Else
  Begin
    Try
      qryGerEle := fCriaQuery(Self);

      chrKey := '/';

      If (fPesqGereleDigPedido(Self, Nil, qryGerEle, recNotEle, chrKey, arrDigNota, True, xmlConsertoEquipamento)) Then
      Begin
        blnEncontrouEntrada := (Not fEmptyStr(recNotEle.str_Chave))
                           And (Not fEmptyStr(recNotEle.strAutInc));
      End;

    Finally
      FreeAndNil(qryGerEle);
    End;
  End;

  If (Not blnEncontrouEntrada) Then Exit;

  Try
    pCriarFormularios(TfrmEntMercadorias, frmEntMercadorias);

    Try
      frmEntMercadorias.blnSemInc      := False;
      frmEntMercadorias.strCodFor      := edtCodCli.Text;
      frmEntMercadorias.blnConEqu      := True;
      frmEntMercadorias.edtEspDoc.Text := 'NF';
      frmEntMercadorias.recNotEle      := recNotEle;
      frmEntMercadorias.ShowModal;

      If frmEntMercadorias.blnConfirma Then
      Begin
        If Not Assigned(objMeqMerEnt) Then
          objMeqMerEnt := TMeqMer.Create;

        pClonaDadosNF(frmEntMercadorias.objMeqMer);
        objMeqMerEnt.strAutEqu := objConEqu.strAutInc;
        objMeqMerEnt.strEmpEqu := objConEqu.strCodEmp;
        objMeqMerEnt.strNumOse := objConEqu.strNumero;
        objMeqMerEnt.strChaveAcesso := recNotEle.str_Chave;

        If objConEqu.strOperac = 'A' Then
          TConEqu.fVinculaOSemNotaFiscal(objMeqMerEnt);

        pCarregaDadosNFEntSai;
        pSolicitaEquipamentoNFEntrada;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmFatManConsertoEquip.pEntradaNF_XML]');
    End;
  Finally
    FreeAndNil(frmEntMercadorias);
  End;
end;

procedure TfrmFatManConsertoEquip.pEnviarEmailPedOS;
  var
    objParametrosEnvio: TParametrosEnvio;
begin
  If (fCfgSis('FATEMA', varBoolean)) Then
  Begin
    If (fMensagem('CONFIRMAÇÃO', 'Deseja enviar e-mail do pedido vinculado a esta O.S.?', ['&Sim', '&Não'], 2) = 1) Then
    Begin
      pSetDefaultParametrosEnvio(objParametrosEnvio);

      EnviarEmailPedOrc(Self,
                        strLoginUsuarioLogado,
                        fCampoTabela('AUTOINCREM',
                                     'FATGOR',
                                     ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'],
                                     [objConEqu.strNumPed, 'PD', objConEqu.strEmpPed]),
                        objConEqu.strNumPed,
                        'PD',
                        objConEqu.strEmpPed,
                        objConEqu.strCodCli,
                        objParametrosEnvio);
    End;
  End;
end;

procedure TfrmFatManConsertoEquip.pEnviarOSEmail(strArquivo: string; blnPDF: Boolean = True);

  Var
    strArqHtml          : String;
    strTexto            : String;
    strAssunto          : String;
    strDestinatario     : String;
    strEmailDestinatario: String;
    strTipExp: String;
    blnConfirma: Boolean;
    qryTmp: TUniQuery;
    arrArquivos, arrDestinatarios : TStringArray;

    EnvioEmail: TEmaAut;
    strCorpoEmail: TStringArray;
begin
  qryTmp := fCriaQuery;
  try
    try
      pPesquisaCadCli(Nil,qryTmp,objConEqu.strCodCli);

      strAssunto := '';
      strDestinatario      := qryTmp.FieldByName('CLI_NOMCLI').AsString;
      strEmailDestinatario := qryTmp.FieldByName('CLI_EMAIL_').AsString;

      pCriarFormularios(TfrmDigEmail, frmDigEmail);
      Try
        frmDigEmail.edtEmail.Text   := strEmailDestinatario;
        frmDigEmail.edtContato.Text := strDestinatario;
        blnConfirma := (frmDigEmail.ShowModal = mrOk);

        If (blnConfirma) Then
        Begin
          strDestinatario      := frmDigEmail.edtContato.Text;
          strEmailDestinatario := frmDigEmail.edtEmail.Text;
          strTipExp            := 'P';
        End;
      finally
        pFreeAndNil(frmDigEmail);
      end;
    Except
      On E: Exception Do
      Begin
        blnConfirma := False;
        pMensagensErro(E.Message, '[TfrmFatManConsertoEquip.pEnviarOSEmail]');
      End;
    End;
  finally
    FreeAndNil(qryTmp);
  end;

  If (Not blnConfirma) Then
    Exit;

  strArqHtml := strArquivo;
  If (Not fEmptyStr(strArqHtml)) Then
  Begin
    EnvioEmail := TEmaAut.Create(Nil);
    try
      EnvioEmail.FCodigo := '001';
      EnvioEmail.FCodGru := '012';
      EnvioEmail.FNumeOS := objConEqu.strNumero;

      EnvioEmail.FCidCli := fRetNomCidade(fRetCodCidByCliente(objConEqu.strCodCli));
      EnvioEmail.FNomCli := strDestinatario;
      EnvioEmail.FPriCli := fRetPrimeiraPalavra(strDestinatario);

      strAssunto    := EnvioEmail.fGetAssuntoMensagem;
      strCorpoEmail := EnvioEmail.fGetCorpoMensagem;

      if (EnvioEmail.FAssunt <> '') and (EnvioEmail.FAssunt <> '(Sem Assunto)') then
        strAssunto := fRetNomeEmpresa + ' - ' + EnvioEmail.FAssunt
      else
        strAssunto := 'Ordem de Serviço Nº: ' + objConEqu.strNumero + ' - ' + fRetNomeEmpresa;

      pCriarArrayAnexosEDestinatarios(strArqHtml, strEmailDestinatario, arrDestinatarios, arrArquivos);

      strTexto := strTexto +  (strCorpoEmail).ToString(strTexto, False);
      if blnPDF then
      begin
        strTexto := strTexto + #13#10 + #13#10;
        strTexto := strTexto + 'Caso não possua o programa Acrobat Reader para visualizar o arquivo anexo, ';
        strTexto := strTexto + 'acesse o link e faça o download: <a href="https://www.adobe.com">www.adobe.com</a>';
      end;

      TEnvioEmail.EnviarEmail(Self, strLoginUsuarioLogado, strAssunto, arrDestinatarios, [], [], TEnvioEmail.ContruirArrayMensagem(strTexto), arrArquivos);

      SetForegroundWindow(Handle);
    finally
      FreeAndNil(EnvioEmail);
    end;
  End
  Else if blnPDF then
    fMensagem('', 'Não foi possível exportar o arquivo PDF !', ['&Ok']);
End;

procedure TfrmFatManConsertoEquip.pEnviarOSWhatsapp(strArquivo: string);
var
  blnModeloAtivado: Boolean;
  strMsg: String;
  recArquivos : TArray<TRecArquivosGatilhos>;
begin
  strMsg := EmptyStr;

  if not fEmptyStr(strArquivo) then
  begin
    SetLength(recArquivos, 1);
    recArquivos[0] := TRecArquivosGatilhos.Create('ORDEM DE SERVIÇO_'+objConEqu.strNumero+'-OS',
                                                  strArquivo,
                                                  EmptyStr);
  end;

  if fDisparaSMSWhatsappAutOS(objConEqu.strNumero, objConEqu.strCodEmp, objConEqu.strCodCli, staImprimindoOS, blnModeloAtivado, True, recArquivos) then
    strMsg := 'Whatsapp enviado com sucesso!'
  else
    strMsg := IIF(not blnModeloAtivado,
                 'Whatsapp não enviado!'+sLineBreak+'Ative o gatilho "Imprimir/Enviar Ordem de Serviço para o cliente" do grupo "Conserto de Equipamentos" nas configurações do sistema(CFG_GATWPP).',
                 'Whatsapp não enviado! Verifique se as configurações do Whatsapp estão preenchidas corretamente.');

  fMensagem('', strMsg , ['&Ok']);
end;

procedure TfrmFatManConsertoEquip.dbgGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  LTexto: String;
begin
  inherited;

  If Column.FieldName = 'AGUARD' Then
  begin
    If Column.Field.AsString = 'S' Then
      dbgGrid.Canvas.Draw(Rect.Left+1, Rect.Top+1, imgPecPen.Picture.Graphic)
    Else If Column.Field.AsString = 'N' Then
      dbgGrid.Canvas.Draw(Rect.Left+1, Rect.Top+1, imgPecDis.Picture.Graphic)
    Else If Column.Field.AsString = 'I' Then
      dbgGrid.Canvas.Draw(Rect.Left+1, Rect.Top+1, imgSalInd.Picture.Graphic);
  End;

  If Column.FieldName = 'SALDIS' Then
  begin
    If Column.Field.AsString = 'S' Then
      dbgGrid.Canvas.Draw(Rect.Left+1, Rect.Top+1, imgPecPen.Picture.Graphic)
    Else If Column.Field.AsString = 'N' Then
      dbgGrid.Canvas.Draw(Rect.Left+1, Rect.Top+1, imgPecDis.Picture.Graphic)
    Else If Column.Field.AsString = 'I' Then
      dbgGrid.Canvas.Draw(Rect.Left+1, Rect.Top+1, imgSalInd.Picture.Graphic);
  End;

  If (Column.FieldName = 'BRINDE') Then
  Begin
    dbgGrid.Canvas.Font.Color  := clBlack;

    If (Column.Field.AsString = 'S') Then
    Begin
      dbgGrid.Canvas.Brush.Color := clYellow;
      dbgGrid.Canvas.FillRect(Rect);
      dbgGrid.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'SIM');
    End
    Else
    Begin
      dbgGrid.Canvas.Brush.Color := clWhite;
      dbgGrid.Canvas.FillRect(Rect);
      dbgGrid.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'NAO');
    End;
  End;

  If (Column.FieldName = 'PROMOC') Then
  Begin

    dbgGrid.Canvas.Font.Color  := clBlack;

    If (Column.Field.AsString = 'S') Then
    Begin
      dbgGrid.Canvas.Brush.Color := clSkyBlue;
      dbgGrid.Canvas.FillRect(Rect);
      dbgGrid.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'PROMO');
    End
    Else If (Column.Field.AsString = 'N') Then
    Begin
      dbgGrid.Canvas.FillRect(Rect);
      dbgGrid.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'NORMAL');
    End;

  End;

  if (Column.FieldName = 'COBAPA') then
  begin
    dbgGrid.Canvas.Font.Color  := clBlack;
    dbgGrid.Canvas.FillRect(Rect);

    if (Column.Field.AsString = 'S') then
      dbgGrid.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'SIM')
    else if (Column.Field.AsString = 'N') then
      dbgGrid.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'NÃO');
  end;

  If Column.FieldName = 'COPCFB' Then
  begin
    If Column.Field.AsString = 'S' Then
      dbgGrid.Canvas.Draw(Rect.Left+1, Rect.Top+1, imgCopCFB.Picture.Graphic);
  End;

  If Column.FieldName = 'COPREF' Then
  begin
    If Column.Field.AsString = 'S' Then
      dbgGrid.Canvas.Draw(Rect.Left+1, Rect.Top+1, imgCopCFB.Picture.Graphic);
  End;

  if (Column.FieldName = 'TIPBRI') Then
  begin
    dbgGrid.Canvas.Font.Color  := clBlack;
    dbgGrid.Canvas.FillRect(Rect);

    if (Column.Field.AsString = 'G') then
      dbgGrid.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'Garantia')
    else if (Column.Field.AsString = 'C') then
      dbgGrid.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'Cortesia')
    else if (Column.Field.AsString = 'R') then
      dbgGrid.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'Revisão')
    else if (Column.Field.AsString = 'M') then
      dbgGrid.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'Montagem')
    else if (Column.Field.AsString = 'L') then
      dbgGrid.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, 'Locação');
  end;

  If Column.FieldName = 'ABRSAL' Then
  begin
    If Column.Field.AsString = 'S' Then
      dbgGrid.Canvas.Draw(Rect.Left+1, Rect.Top+1, imgSaldos.Picture.Graphic);
  End;

  if (not objConEqu.cdsIteEqu.IsEmpty) then
  begin
    dbgGrid.Canvas.Font.Color  := clBlack;

    if (objConEqu.cdsIteEqu.FieldByName('ITEESP').AsString = 'S') then
    begin
      dbgGrid.Canvas.Font.Color := clGreen;
      dbgGrid.DefaultDrawColumnCell(Rect,DataCol,Column,State);
    end
    else if (objConEqu.cdsIteEqu.FieldByName('ATICOM').AsString = 'N') then
    begin
      dbgGrid.Canvas.Font.Color := clWebDarkOrange;
      dbgGrid.DefaultDrawColumnCell(Rect,DataCol,Column,State);
    end;
  end;

  if (Column.FieldName = 'ENTRET') then
  begin
    LTexto := Column.Field.AsString;

    case AnsiIndexStr(Column.Field.DataSet.FieldByName('LOCRET').AsString, ['C', 'E', 'B', 'B2']) of
      0: LTexto := 'R.C';
      1: LTexto := 'R.E';
      2: LTexto := 'R.B';
      3: LTexto := 'R.B2';
    end;

    dbgGrid.Canvas.FillRect(Rect);
    dbgGrid.Canvas.TextOut(Rect.Left + 3, Rect.Top + 2, LTexto);
  end;
End;

procedure TfrmFatManConsertoEquip.pStatus;
begin
  With objConEqu, lblStatus Do
  Begin
    Caption := fTitStatus;
    chkAg_Mon.Checked := objConEqu.blnAg_Mon;
    chkAg_Mon.Visible := (strStatus = 'A') And (strSubSta <> 'N') And (Not cdsIteEqu.IsEmpty);
    If (not blnRotinaTecnico) Then
    Begin
      pnlAg_Pec.Visible := (strStatus = 'A') And (strSubSta <> 'N') And (Not cdsIteEqu.IsEmpty) And (objConEqu.strOperac = 'A');
      pnlMostraPrecoProd.visible := (Not cdsIteEqu.IsEmpty);
      pnlMostraPrecoServ.visible := (Not cdsIteEqu.IsEmpty);
    End;

    if fEhFluxoDadosOS then
      Exit;

    btnDevCli.Visible := (Not fEmptyStr(strStatus)) And (Not fEmptyStr(strSubSta)) And
                         (
                           (
                             ( (strStatus[1] = 'N') Or (strStatus[1] = 'R') ) And (fCfgSis('EQUREA', varString) = '1')
                           ) Or (fRepAgMontage())
                         );

    If (btnDevCli.Visible) And (fRepAgMontage()) Then
    Begin
      If (strSubSta[1] = 'A') Then
        btnDevCli.Caption := '[ F3 ] Devolver ao Cliente'
      Else If (strSubSta[1] = 'C') Then
        btnDevCli.Caption := '[ F3 ] Armazenar'
    End;

    btnDevCli.Enabled := btnDevCli.Visible;
  End;
end;

procedure TfrmFatManConsertoEquip.pValidaItensSemLote(strNumDoc, strEmpPed: String);
var
  LSQL,
  LCodVen,
  LNumFat: String;
  LImp,
  LJafatu,
  LJaBaix,
  LSepImp: Boolean;
  LQry: TUniQuery;
  frmFatAltLoteItem: TfrmFatAltLoteItem;
begin
  if (not fDocumentoFatExiste(qryFatgor, strNumDoc, 'PD', strEmpPed, LJafatu, LJaBaix, LImp, LCodVen, LSepImp)) then
    Exit;

  LJafatu := LJafatu or fValidaHouveFaturamentoParcial(LNumFat, strNumDoc, strEmpPed);

  if LJafatu then
    Exit;

  LQry := fCriaQuery;

  LSQL := '';
  LSQL := LSQL + ' SELECT FDO_CODITE ';
  LSQL := LSQL + ' FROM FATDOR ';
  LSQL := LSQL + ' WHERE FDO_NUMDOC = :NUMDOC ';
  LSQL := LSQL + '     AND FDO_ESPDOC = "PD" ';
  LSQL := LSQL + '     AND FDO_CODEMP = :CODEMP ';
  LSQL := LSQL + '     AND FDO_NUMLOT IS NULL ';
  LSQL := LSQL + '     AND FDO_CODITE <> :ITESER ';
  LSQL := LSQL + '     AND FDO_CODITE <> :SERTER ';

  try
    LQry.SQL.Text := LSQL;
    LQry.ParamByName('NUMDOC').AsString := strNumDoc;
    LQry.ParamByName('CODEMP').AsString := strEmpPed;
    LQry.ParamByName('ITESER').AsString := fCfgSis('ITESER', varString);
    LQry.ParamByName('SERTER').AsString := fCfgSis('SERTER', varString);
    LQry.Open;

    if LQry.IsEmpty then
      Exit;

    while not LQry.Eof do
    begin
      if untFuncoesSimples.fExisteLote(LQry.FieldByName('FDO_CODITE').AsString, strEmpPed) then
      begin
        try
          pCriarFormularios(TfrmFatAltLoteItem, frmFatAltLoteItem);
          frmFatAltLoteItem.blnConEqu := True;
          frmFatAltLoteItem.strNumDoc := strNumDoc;
          frmFatAltLoteItem.strEspDoc := 'PD';
          frmFatAltLoteItem.strCodEmp := strEmpPed;
          frmFatAltLoteItem.ShowModal;
        finally
          pFreeAndNil(frmFatAltLoteItem);
        end;

        Exit;
      end;

      LQry.Next;
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

procedure TfrmFatManConsertoEquip.pVerificaAlterarVendedor(strCodVendedor, strCodRepres: String);
begin
  If (Not fCfgSis('ALTVEN', varBoolean)) Then
  Begin
    If (fCfgSis('VENESP') <> strCodVendedor) Then
    Begin
      edtSenVen.ReadOnly := True;

      objConEqu.strCodVen := strCodVendedor;

      If (Not blnUsaDig) Then
        edtSenVen.Text := fRetSenhaVendedor(strCodVendedor)
      Else
        edtSenVen.Text := strCodVendedor;
    End;
  End;

  If (Not fCfgSis('ALTVE2', varBoolean)) Then
  Begin
    If (fCfgSis('VENESP') <> strCodVendedor) Then
    Begin
      edtCodRep.ReadOnly := True;
    End;
  End;
end;

procedure TfrmFatManConsertoEquip.pVerificaOSAntExit(Sender: TObject);
begin
  pCarregaOSAnterior;

  if (not fEmptyStr(edtCodEqu.Text)) and (not fEmptyStr(edtNSerie.Text)) then
    trvHisEqu.LoadFromStream(TStringStream.Create(objConEqu.fCarregaHistoricoEquip(edtNumero.Text, edtCodCli.Text, edtCodEqu.Text, edtNSerie.Text)));
end;

procedure TfrmFatManConsertoEquip.pVerificaProntoAtendimento;
begin
  if not blnFluxoProcesso then
  begin
    chkPrtAtd.Visible := False;
    lblPreEnt.Left    := 501;
    mskEntreg.Left    := 588;
    edtDiaEnt.Left    := 620;
  end
  else
    chkPrtAtd.Visible := True;
end;

procedure TfrmFatManConsertoEquip.pVerificaTabPre;
begin
  cbTabPreco.Clear;

  strTabEqu := fCfgSis('TABEQU', varString);
  strSugEqu := fCfgSis('SUGEQU', varString);

  if (strTabEqu <> 'NNNNNNN') then
  begin
    pCarregaComboTabPre(cbTabPreco, strTabEqu);

    if (strSugEqu <> '0') then
      cbTabPreco.ItemIndex := cbTabPreco.Items.IndexOf(strSugEqu);
  end
  else
    pCarregaComboTabPre(cbTabPreco, VS_strTabVen);

  If (fCfgSis('TABITE', varBoolean)) And (fCfgSis('TBPOSE', varBoolean)) Then
  Begin
    cbTabPrecoItem.Visible     := True;
    lblTabPrecoItem.Visible    := True;
    fFindColumnByName(dbgGrid, 'TABPRE').Visible := True; //TABPRE

    cbTabPrecoItem.Clear;

    if (strTabEqu <> 'NNNNNNN') then
    begin
      pCarregaComboTabPre(cbTabPrecoItem, strTabEqu);

      if (strSugEqu <> '0') then
        cbTabPrecoItem.ItemIndex := cbTabPrecoItem.Items.IndexOf(strSugEqu);
    end
    else
      pCarregaComboTabPre(cbTabPrecoItem, VS_strTabVen);
  End
  Else
  Begin
    cbTabPrecoItem.Visible     := False;
    lblTabPrecoItem.Visible    := False;
    fFindColumnByName(dbgGrid, 'TABPRE').Visible := False; //TABPRE
  End;
end;

procedure TfrmFatManConsertoEquip.pVincularEntradaNF;
  Var
    frmSelecionarNota: TfrmSelecionarNota;
begin
  try
    try
      pCriarFormularios(TfrmSelecionarNota, frmSelecionarNota);
      frmSelecionarNota.tnTipoNota     := tnEntrada;
      frmSelecionarNota.edtCodEmp.Text := VS_strCodEmp;
      frmSelecionarNota.edtDesEmp.Text := fRetNomeEmpresaSelec(frmSelecionarNota.edtCodEmp.Text);
      frmSelecionarNota.strCodCli      := objConEqu.strCodCli;
      frmSelecionarNota.ShowModal;

      If frmSelecionarNota.blnConfirma Then
      Begin
        If Not Assigned(objMeqMerEnt) Then
          objMeqMerEnt := TMeqMer.Create;

        objMeqMerEnt.strAutEqu := objConEqu.strAutInc;
        objMeqMerEnt.strEmpEqu := objConEqu.strCodEmp;
        objMeqMerEnt.strNumOse := objConEqu.strNumero;
        objMeqMerEnt.strAutGer := frmSelecionarNota.strSeqGer;
        objMeqMerEnt.strNumDoc := frmSelecionarNota.edtNumDoc.Text;
        objMeqMerEnt.strEspDoc := frmSelecionarNota.edtEspDoc.Text;
        objMeqMerEnt.strEmpGer := frmSelecionarNota.edtCodEmp.Text;
        objMeqMerEnt.strSerie_ := frmSelecionarNota.edtSerie_.Text;
        objMeqMerEnt.strCodCli := objConEqu.strCodCli;
        objMeqMerEnt.strTipOpe := 'E';
        objMeqMerEnt.dtaDtaGer := frmSelecionarNota.dtaDtaGer;
        objMeqMerEnt.strChaveAcesso := frmSelecionarNota.strAcesso;

        {Req.: 106823 - Foi validado a operação "G" conforme desenvolvimento do
         requisito 49693.}
        If (objConEqu.strOperac = 'A') Or ((objConEqu.strOperac = 'G') And (objConEqu.strUltOpe = 'A')) Then
          TConEqu.fVinculaOSemNotaFiscal(objMeqMerEnt);

        pCarregaDadosNFEntSai;
        pSolicitaEquipamentoNFEntrada;
      End;
    except
      on E: Exception Do
        pMensagensErro(E.Message, '[TfrmFatManConsertoEquip.pVincularEntradaNF]');
    end;
  finally
    pFreeAndNil(frmSelecionarNota);
  end;
end;

procedure TfrmFatManConsertoEquip.pVincularSaidaNF;
  Var
    frmSelecionarNota: TfrmSelecionarNota;
begin
  Try
    pCriarFormularios(TfrmSelecionarNota, frmSelecionarNota);
    frmSelecionarNota.tnTipoNota     := tnSaida;
    frmSelecionarNota.edtCodEmp.Text := VS_strCodEmp;
    frmSelecionarNota.edtDesEmp.Text := fRetNomeEmpresaSelec(frmSelecionarNota.edtCodEmp.Text);
    frmSelecionarNota.ShowModal;

    If frmSelecionarNota.blnConfirma Then
    Begin
      If Not Assigned(objMeqMerSai) Then
        objMeqMerSai := TMeqMer.Create;

      objMeqMerSai.strAutEqu := objConEqu.strAutInc;
      objMeqMerSai.strEmpEqu := objConEqu.strCodEmp;
      objMeqMerSai.strNumOse := objConEqu.strNumero;
      objMeqMerSai.strAutGer := frmSelecionarNota.strSeqGer;
      objMeqMerSai.strNumDoc := frmSelecionarNota.edtNumDoc.Text;
      objMeqMerSai.strEspDoc := frmSelecionarNota.edtEspDoc.Text;
      objMeqMerSai.strEmpGer := frmSelecionarNota.edtCodEmp.Text;
      objMeqMerSai.strSerie_ := frmSelecionarNota.edtSerie_.Text;
      objMeqMerSai.strCodCli := objConEqu.strCodCli;
      objMeqMerSai.strTipOpe := 'S';
      objMeqMerSai.dtaDtaGer := frmSelecionarNota.dtaDtaGer;

      {Req.: 106823 - Foi validado a operação "G" conforme desenvolvimento do
       requisito 49693.}
      If (objConEqu.strOperac = 'A') Or ((objConEqu.strOperac = 'G') And (objConEqu.strUltOpe = 'A')) Then
        TConEqu.fVinculaOSemNotaFiscal(objMeqMerSai);

      pCarregaDadosNFEntSai;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmFatManConsertoEquip.pVincularSaidaNF]');
  End;
  pFreeAndNil(frmSelecionarNota);
end;

procedure TfrmFatManConsertoEquip.rdbCodFabClick(Sender: TObject);
begin
  inherited;
  edtCodIte.TipoTexto := EditFocus.TControlTipoTexto(ttAlfanumerico);
  edtCodIte.MaxLength := 25;
  edtCodIte.TamCampo  := 25;
  edtCodIte.CompZeros := False;
  blnBuscarCodFab     := True;
end;

procedure TfrmFatManConsertoEquip.rdbCodIteClick(Sender: TObject);
var
  intTamCodIte: Integer;
begin
  inherited;
  intTamCodIte := fTamCodIte;
  edtCodIte.TipoTexto := EditFocus.TControlTipoTexto(ttNumerico);
  edtCodIte.MaxLength := intTamCodIte;
  edtCodIte.TamCampo  := intTamCodIte;
  edtCodIte.CompZeros := True;
  blnBuscarCodFab     := False;
end;

procedure TfrmFatManConsertoEquip.RedimensionaDesEmp(blnNovaOS: Boolean);
begin
  if blnNovaOS then
  begin
    if not edtProtoc.Visible then
      edtDesEmp.Width       := 290
    else
      edtDesEmp.Width       := 151;
  end
  else
  begin
    if not edtProtoc.Visible then
      edtDesEmp.Width       := 447
    else
      edtDesEmp.Width       := 290;
  end;
end;

procedure TfrmFatManConsertoEquip.RedimensionaRevendaRetornarDeixadoPor;
begin
  if chkVenPre.Visible then
    edtDeiPor.Width := 104
  else
    edtDeiPor.Width := 228;
end;

procedure TfrmFatManConsertoEquip.trvHisEquCustomDrawItem(
  Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  inherited;

  if (Node.Index mod 2) = 0 then
    Sender.Canvas.Brush.Color := cl3DLight
  else
    Sender.Canvas.Brush.Color := clWhite;
end;

procedure TfrmFatManConsertoEquip.pAdicionaItem;
  Var
    cpcParams: TParCalculaPrecoCusto;
    strTriTos   : String;
begin
  Try
    cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);

    If (Not fCfgSis('CUSESP', varBoolean))                                      And
       (Pos('ITEM ESPECIAL', qryCadIte.FieldByName('ITE_DESITE').AsString) > 0) Then
    Begin
      objConEqu.fltTotCus := cpcParams.fCalculaPrecoCusto(fStrToFloat(edtUnitar.Text), fCfgSis('MMIIES', varDouble));
      objConEqu.fltUniOri := fStrToFloat(edtUnitar.Text);
      objConEqu.fltUniVis := fStrToFloat(edtUnitar.Text);
      objConEqu.fltUnitar := fStrToFloat(edtUnitar.Text);
      objConEqu.fltTaxJur := 0;
      objConEqu.fltPerDes := 0;
      objConEqu.strUnidad := edtUnidad.Text;
      objConEqu.strCodUni := fRetCodUnidadePorSig(edtUnidad.Text);
    End;

    if (pnlEmpIte.Visible) then
      objConEqu.strEmpIte := edtEmpIte.Text
    else
      objConEqu.strEmpIte := IIF(fEmptyStr(objConEqu.strCodEmp), VS_strCodEmp, objConEqu.strCodEmp);

    objConEqu.strAtiCom := qryCadIte.FieldByName('ITE_ATICOM').AsString;

    If (objConEqu.strOperac <> 'G') Or
       (objConEqu.cdsIteEqu.IsEmpty) Or
       (objConEqu.cdsIteEqu.FieldByName('CODITE').AsInteger <> StrToInt(edtCodIte.Text)) Then
    Begin
      If objConEqu.fItemJaInclusoGrid(edtCodIte.Text) Then
      Begin
        strTriTos := fCfgSis('TRITOS', varString);

        If (strTriTos = 'A') Then
        Begin
          fMensagem('AVISO!', 'O item ' + edtCodIte.Text + ' já foi incluído nessa OS.', ['&Ok']);
        End
        Else If (strTriTos = 'T') Then
        Begin
          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto('Item ' + edtCodIte.Text + ' - ' +  LeftStr(edtDesIte.Text,50) + ' repetido no Conserto de Equipamentos');

          objLiberacao.strDirAce := 'SEITOS';
          objLiberacao.strSenLib := fCfgSis('SEITOS');
          objLiberacao.strMsgSen := 'Item repetido no Conserto de Equipamentos';
          objLiberacao.strCodOpe := objConEqu.strCodVen;
          objLiberacao.strCodDig := objConEqu.strCodDig;
          objLiberacao.strCliente := edtCodCli.Text + '-' + edtNomCli.Text;

          objLiberacao.pInformaNumDocEspDocCodEmp(
                            objConEqu.strNumero,
                            'OS',
                            objConEqu.strCodEmp);

          If (Not objLiberacao.fLibera) Then
          Begin
            btnCancelaItem.Click();
            Exit;
          End;
        End;
      End;

      if (not fValidaSaldoInsuficiente) then
      begin
        btnCancelaItem.Click;
        Exit;
      end;

      If (cmbEntRet.ItemIndex = IDX_ENTREGA) Then
        objConEqu.strEntRet := 'E'
      Else If (cmbEntRet.ItemIndex = IDX_RETIRA) Then
        objConEqu.strEntRet := 'R';

      if pnlLocRet.Visible then
        objConEqu.strLocRet := fRetSiglaLocalRetira(cmbLocRet.Text);

      objConEqu.cdsIteEqu.DisableControls;
      objConEqu.pAdicionaItem('I');
      objConEqu.cdsIteEqu.EnableControls;

      objConEqu.fltVlrPro := objConEqu.fltVlrPro + objConEqu.fltTotIte;

      objConEqu.intSeqIte := objConEqu.intSeqIte + 1;
      pCalcPorDes;
      pInicializarFatVenda();

      objConEqu.fltVlrCon := objConEqu.fltVlrPro + objConEqu.fltVlrSer +
                             objConEqu.fltTotIpi + objConEqu.fltTotRet +
                             IIF(fSomarNovosImpostosDaReformaAoValorContabil, objConEqu.fltTotCbs + objConEqu.fltTotIbs + objConEqu.fltTotIs, 0);

    End
    Else
    Begin
      if (fFormataFloat(fStrToFloat(edtQtdIte.Text), intDecQtde) <> objConEqu.cdsIteEqu.FieldByName('QTDITE').AsFloat) then
      begin
        if (not fValidaSaldoInsuficiente) then
        begin
          btnCancelaItem.Click;
          Exit;
        end;
      end;

      objConEqu.fltVlrPro := objConEqu.fltVlrPro - objConEqu.cdsIteEqu.FieldByName('TOTITE').AsFloat;
      objConEqu.fltVlrCon := objConEqu.fltVlrCon - objConEqu.cdsIteEqu.FieldByName('VLRCON').AsFloat;

      If (cmbEntRet.ItemIndex = IDX_ENTREGA) Then
        objConEqu.strEntRet := 'E'
      Else If (cmbEntRet.ItemIndex = IDX_RETIRA) Then
        objConEqu.strEntRet := 'R';

      if pnlLocRet.Visible then
        objConEqu.strLocRet := fRetSiglaLocalRetira(cmbLocRet.Text);

      objConEqu.cdsIteEqu.DisableControls;
      objConEqu.pAlteraItemGrid;
      objConEqu.cdsIteEqu.EnableControls;

      objConEqu.fltVlrPro := objConEqu.fltVlrPro + fStrToFloat(edtTotIte.text);

      pCalcPorDes;
      pInicializarFatVenda();

      objConEqu.fltVlrCon := objConEqu.fltVlrPro + objConEqu.fltVlrSer +
                             objConEqu.fltTotIpi + objConEqu.fltTotRet +
                             IIF(fSomarNovosImpostosDaReformaAoValorContabil, objConEqu.fltTotCbs + objConEqu.fltTotIbs + objConEqu.fltTotIs, 0);

      objConEqu.strOperac := objConEqu.strUltOpe;

      edtCodIte.Enabled := True;
      edtDesIte.Enabled := True;
      edtUnitar.Enabled := True;
      //edtUnidad.Enabled := True;
    End;

    objConEqu.pLimpaValoresItens;
    pIncluiNaListaConsulta('CODITE', 'ITE_CODITE', sltItems, objConEqu.cdsIteEqu, cdsConsultaItem);

    pAtualizaTotais;

    dbgGrid.Enabled := True;
    dbgGrid.Refresh;

    pAtualizaDados(Nil);

    btnCancelaItem.Click;

    objConEqu.fAtualizaSaldos;

  Except
    On E: Exception do
    Begin
      pMensagensErro(E.Message, 'btnAdicionarClick - untFatManConsertoEquip');
    End;
  End;

  FreeAndNil(cpcParams);
end;

procedure TfrmFatManConsertoEquip.pAdicionaServico;
var
  strCodSerAlt, strCodTecAlt: String;
begin
  try
    objConEqu.strCodSer := edtCodSe1.Text;
    objConEqu.strDesSer := edtDesSe1.Text;

    if edtQtdSe1.Visible then
    begin
      objConEqu.fltQtdSer := fStrToFloat(edtQtdSe1.text);
      objConEqu.fltValSer := fStrToFloat(edtQtdSe1.text) * fStrToFloat(edtValSe1.text);
    end
    else
    begin
      objConEqu.fltQtdSer := 1;
      objConEqu.fltValSer := fStrToFloat(edtValSe1.text);
    end;

    objConEqu.strTecSer := edtCodTecSe1.Text;

    strCodSerAlt := objConEqu.cdsSerEqu.FieldByName('CODSER').AsString;
    strCodTecAlt := objConEqu.cdsSerEqu.FieldByName('TECSER').AsString;

    If (Not objConEqu.fServicoJaInclusoGrid(edtCodSe1.Text, edtCodTecSe1.Text)) And (Not objConEqu.blnPermiteAltTec) Then
    Begin
      objConEqu.fltValUni := fStrToFloat(edtValSe1.Text);
      objConEqu.cdsSerEqu.DisableControls;
      objConEqu.pIncluiServicoGrid;
      objConEqu.cdsSerEqu.EnableControls;
      strCodSerOld := '';
    End
    Else
    Begin
      objConEqu.cdsSerEqu.Locate('CODSER;TECSER', VarArrayOf([strCodSerAlt, strCodTecAlt]), []);

      objConEqu.fltVlrSer := objConEqu.fltVlrSer - objConEqu.cdsSerEqu.FieldByName('VALSER').AsFloat;
      objConEqu.fltVlrCon := objConEqu.fltVlrCon - objConEqu.cdsSerEqu.FieldByName('VALSER').AsFloat;
      objConEqu.fltValUni := fStrToFloat(edtValSe1.text);

      objConEqu.cdsSerEqu.DisableControls;
      objConEqu.pAlteraServicoGrid;
      objConEqu.cdsSerEqu.EnableControls;
      strCodSerOld := '';
    End;

    objConEqu.fltVlrSer := objConEqu.fltVlrSer + objConEqu.fltValSer;
    objConEqu.fltVlrCon := objConEqu.fltVlrCon + objConEqu.fltValSer;

    objConEqu.strCodSer := EmptyStr;
    objConEqu.strDesSer := EmptyStr;
    objConEqu.fltValSer := 0;

    dbgServico.Enabled := True;
    dbgServico.Refresh;

    pIncluiNaListaConsulta('CODSER', 'SER_CODSER', sltServ, objConEqu.cdsSerEqu, cdsConsultaServ);
    btnCancelaSe1.Click;
  except
    on E: Exception do
    begin
      pMensagensErro(E.Message, 'btnAdicionarClick - untFatManConsertoEquip');
    end;
  end;

  pAplicarDescontoServicos();

  lblTotGer.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltVlrCon);
  lblTotPro.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltVlrPro);
  lblTotSer.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltVlrSer);
  lblTotDes.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltDesEsp + objConEqu.fltDesEspSer);
  lblTotST.Caption  := FormatFloat(fMskDigitos(2), objConEqu.fltTotRet);
  lblTotIPI.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltTotIPI);
  lblTotFre.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltValFre);
  lblTotRef.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltTotCbs + objConEqu.fltTotIbs + objConEqu.fltTotIs);

  edtCodSe1.Enabled := True;

  If (Assigned(frmFatVendaItem)) Then frmFatVendaItem.Close();
end;

procedure TfrmFatManConsertoEquip.pAjustaAlturaPanelBotoes;
begin
  FlwPnlButtons.AutoSize := True;
  FlwPnlButtons.AutoSize := False;

  pnlButtons.Height := FlwPnlButtons.Height + 30;

  btnFechar.Left := Self.Width - 93;
  btnFechar.Top := pnlButtons.Height - 26;

  chkAg_Mon.Left := Self.Width - 231;
  chkAg_Mon.Top := pnlButtons.Height - 26;
end;

function TfrmFatManConsertoEquip.fAlteraCadCli(const strCodCli: String): String;
begin
  pCriarFormularios(TfrmCadClientes, frmCadClientes);
  try
    try
      frmCadClientes.strCodClienteIniciarCadastro := strCodCli;
      frmCadClientes.ShowModal;
      Result := frmCadClientes.strUltimoCodigo;
    except
      on E: Exception do
        pMensagensErro(E.Message, '');
    end;
  finally
    pFreeAndNil(frmCadClientes);
  end;
end;

function TfrmFatManConsertoEquip.fAlteraPedidoVenda: Boolean;
var
  strCodPrd,
  strCodCli,
  strSQL,
  strEmpLog: String;
  qryAux,
  qryFatGor,
  qryEquOS: TUniQuery;
  objAltPed: TAlterarPedido;
begin
  Result := False;
  strEmpLog := VS_strCodEmp;

  strCodPrd := fCampoTabela('EQU_CODITE', 'CADEQU', ['EQU_CODIGO'], [objConEqu.strCodEqu]);

  if fEmptyStr(strCodPrd) then
  begin
    fMensagem('AVISO!', 'O Equipamento ' + fRetNomEquipamentoOS(objConEqu.strCodEqu) + ' não possui um produto vinculado.' + #13 +
              'Favor cadastrar em "Principal > Manutenção de Cadastros > Auxiliares > Conserto de Equipamentos > Equipamentos".', ['&Ok']);
    Exit;
  end;

  qryAux := fCriaQuery;

  try
    strSQL := '';
    strSQL := strSQL + ' SELECT FOR_CODCLI CODCLI ';
    strSQL := strSQL + ' FROM CADITE ';
    strSQL := strSQL + ' INNER JOIN CADFOR ON CADITE.ITE_CODFOR = CADFOR.FOR_CODFOR ';
    strSQL := strSQL + ' WHERE ITE_CODITE = :CODITE ';

    qryAux.SQL.Text := strSQL;
    qryAux.ParamByName('CODITE').AsString := strCodPrd;
    qryAux.Open;

    if fEmptyStr(qryAux.FieldByName('CODCLI').AsString) then
    begin
      Result := True;
      Exit;
    end;

    strCodCli := qryAux.FieldByName('CODCLI').AsString;
  finally
    FreeAndNil(qryAux);
  end;

  if (objConEqu.strCliGar <> strCodCli) then
    if fMensagem('AVISO', 'O Cliente do Pedido será alterado.' + #13 +
                          'Cliente atual: ' + objConEqu.strCliGar + '-' + fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'], [objConEqu.strCliGar], False) + #13 +
                          'Novo Cliente: ' + strCodCli + '-' + fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) + #13 +
                          'Deseja continuar?', ['&Sim', '&Não']) = 2 then
      Exit;

  objConEqu.strCliGar := strCodCli;

  objAltPed := TAlterarPedido.Create(Self);
  qryFatGor := fCriaQuery;
  qryEquOS := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT EQU_NUMOSE, IF(FGO_SEQFGO IS NULL, EQU_NUMPED, FGO_NUMDOC) NUMDOC, ';
  strSQL := strSQL + ' IF(FGO_SEQFGO IS NULL, EQU_EMPPED, FGO_CODEMP) CODEMP, FGO_GARANT GARANT, FGO_ITEPED ITEPED, ';
  strSQL := strSQL + ' (SELECT FDO_EMPITE FROM FATDOR WHERE FDO_SEQGER = FATGOR.AUTOINCREM LIMIT 1) EMPITE ';
  strSQL := strSQL + ' FROM EQUGER ';
  strSQL := strSQL + ' LEFT JOIN EQUGOR ON EQUGER.AUTOINCREM = EQUGOR.FGO_SEQEQU AND EQUGOR.FGO_GARANT NOT IN ("C", "N") ';
  strSQL := strSQL + ' LEFT JOIN FATGOR ON EQUGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
  strSQL := strSQL + ' WHERE EQU_NUMOSE = :NUMOSE AND EQU_CODEMP = :CODEMP ';

  qryEquOS.SQL.Text := strSQL;
  qryEquOS.ParamByName('NUMOSE').AsString := objConEqu.strNumero;
  qryEquOS.ParamByName('CODEMP').AsString := objConEqu.strCodEmp;
  qryEquOS.Open;

  try
    strSQL := '';
    strSQL := strSQL + ' SELECT     ';
    strSQL := strSQL + '  *        ';
    strSQL := strSQL + ' FROM       ';
    strSQL := strSQL + '  FATGOR F ';
    strSQL := strSQL + '  LEFT JOIN EXTGOR E ON E.FGO_SEQFGO = F.AUTOINCREM ';
    strSQL := strSQL + '  LEFT JOIN SERGOR S ON S.FGO_SEQFGO = F.AUTOINCREM ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '  F.FGO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  F.FGO_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  F.FGO_CODEMP = :CODEMP ';
    qryFatGor.SQL.Text := strSQL;

    while not qryEquOS.Eof do
    begin
      if objConEqu.blnMulLoj then
      begin
        pSetaEmpresaLogada(qryEquOS.FieldByName('CODEMP').AsString);
        pSetarEmpresaItem(VS_strCodEmp);
      end;

      pValidaItensSemLote(qryEquOS.FieldByName('NUMDOC').AsString, qryEquOS.FieldByName('CODEMP').AsString);

      if fValidaUtilizarPedido(qryEquOS.FieldByName('NUMDOC').AsString, 'PD', qryEquOS.FieldByName('CODEMP').AsString, 'PD', qryFatGor) then
      begin
        objAltPed.strNumPed := qryEquOS.FieldByName('NUMDOC').AsString;
        objAltPed.strEspPed := 'PD';
        objAltPed.strEmpPed := qryEquOS.FieldByName('CODEMP').AsString;

        objAltPed.blnRecalculaPrecos := True;

        if not objAltPed.fCarregarPedido then
        begin
          fMensagem('AVISO!', 'Não foi possível carregar o pedido. Operação cancelada.', ['&Ok']);
          Exit;
        end;

        objAltPed.objVenda.strCodCli := strCodCli;

        if objConEqu.blnMulLoj and (qryEquOS.FieldByName('CODEMP').AsString <> qryEquOS.FieldByName('EMPITE').AsString) then
        begin
          objAltPed.objVenda.strEmp_CD := qryEquOS.FieldByName('EMPITE').AsString;
          objAltPed.objVenda.blnEnt_CD := True;
        end;

        if not objAltPed.fCalculaTotalPedido then
        begin
          fMensagem('AVISO!', 'Erro ao calcular total do pedido. Operação cancelada.', ['&Ok']);
          Exit;
        end;

        if not objAltPed.fGravarPedido then
        begin
          fMensagem('AVISO!', 'Erro ao gravar pedido. Operação cancelada.', ['&Ok']);
          Exit;
        end;

        if (not qryEquOS.FieldByName('ITEPED').IsNull) then
          objConEqu.pGravarDesmembramento(objAltPed.objVenda.strAutIncFatGor, objConEqu.strAutInc,
            qryEquOS.FieldByName('GARANT').AsString, qryEquOS.FieldByName('ITEPED').AsString, objConEqu.blnMulLoj);
      end;

      qryEquOS.Next;
    end;
  finally
    pSetaEmpresaLogada(strEmpLog);
    pSetarEmpresaItem(strEmpLog);
    pLiberaBloqueioPedido(qryFatGor);
    FreeAndNil(objAltPed);
    FreeAndNil(qryFatGor);
    FreeAndNil(qryEquOS);
  end;

  Result := True;
end;

procedure TfrmFatManConsertoEquip.pAlterarAcessorio;
begin
  objConEqu.strUltOpe := objConEqu.strOperac;
  blnAltAcessorio := True;
  pCarregaAcessorioAlteracao;

  if edtDesAce.CanFocus then
    pSetFocus(edtDesAce)
  else
    pSetFocus(edtQtdAce);
end;

procedure TfrmFatManConsertoEquip.pAlterarServico;
begin
  objConEqu.strUltOpe := objConEqu.strOperac;
  objConEqu.strOperac := 'G';
  pCarregaServicoAlteracao;

  If (objConEqu.blnPermiteAltTec) Then
    pHabilitarCamposAlterarTecnicoServico(objConEqu.blnPermiteAltTec);

  If (Not objConEqu.blnPermiteAltTec) Then
    pSetFocus(edtDesSe1)
  Else
    pSetFocus(edtCodTecSe1);
end;

procedure TfrmFatManConsertoEquip.pAlteraStatusAprovadaParaOrcamento;
begin
  objConEqu.strFlxFas := 'O';
  objConEqu.strFlxSit := 'OR';
  objConEqu.strFlxCom := 'AC';

  pBaixaOcorrenciasCRM;
  objConEqu.pAlteraStatusDados('F', 'O', '', True, '', '', '', '', 0, '', True);
end;

procedure TfrmFatManConsertoEquip.pAlteraTelaRotinaTecnico;
begin
  if not blnRotinaTecnico then
    Exit;

  Self.Caption := 'Manutenção de Ordem de Serviços - Tecnico';

  edtCodEmp.Enabled := False;
  edtProtoc.Enabled := False;
  pnlCliente.Visible:= False;
  pnlCndPag.Visible := False;
  edtSenVen.Enabled := False;
  chkVenPre.Visible := False;
  edtCodRep.Enabled := False;
  edtCodEqu.Enabled := False;
  edtDesMar.Enabled := False;
  edtVoltag.Enabled := False;
  edtObs.Enabled    := False;
  edtObsGer.Enabled := False;
  edtObsNFS.Enabled := False;
  edtNSerie.Enabled := False;
  cbGarant.Enabled := (blnFluxoProcesso and (objConEqu.strStatus = 'E'));
  edtTmpGar.Enabled := (blnFluxoProcesso and cbGarant.Enabled and (cbGarant.ItemIndex > 0));
  pnlRevRetEnt.Visible := False;
  edtCntCli.Enabled := False;
  mskCntTel.Enabled := False;
  edtNumPat.Enabled := False;
  edtDadFab.Enabled := False;
  edtNOSAnt.Enabled := False;
  mskDtEAnt.Enabled := False;
  mskDtRAnt.Enabled := False;
  cbEstPrd.Enabled  := cbEstPrd.Visible and (fVerificaAcessoSistema('AEPCET')) and (not fEmptyStr(objConEqu.strNumero));
  edtLocFis.Enabled := (edtLocFis.Visible and (not fEmptyStr(objConEqu.strNumero)));
  edtCodLoc.Enabled := (edtCodLoc.Visible and (not fEmptyStr(objConEqu.strNumero)));
  edtDesLoc.Enabled := (edtDesLoc.Visible and (not fEmptyStr(objConEqu.strNumero)));
  pnlRealizada.Visible := False;

  pHabilitaNFCompraAnaliseTec;

  If Not edtCodEmp.Visible Then
  Begin
    lblProtoc.Left := 142;
    edtProtoc.Left := 190;
  End;

  if (not blnFluxoProcesso) then
  begin
    rdbCodIte.Checked := True;
    rdbCodFab.Visible := False;
    rdbCodIte.Visible := False;
  end;

  Label12.Visible := False;
  edtUnitar.Visible := False;
  Label15.Visible := False;
  edtTotIte.Visible := False;
  chkBrindePro.Visible := False;
  lblEntRet.Visible := False;
  cmbEntRet.Visible := False;
  pnlLocRet.Visible := False;
  lblTabPrecoItem.Visible := False;
  cbTabPrecoItem.Visible := False;
  btnAlteraItens.Visible := False;
  btnBrindeTotalServ.Visible := False;
  fFindColumnByName(dbgGrid, 'ENTRET').Visible := False;
  fFindColumnByName(dbgGrid, 'CODFAB').Visible := False;
  fFindColumnByName(dbgGrid, 'COPCFB').Visible := False;
  fFindColumnByName(dbgGrid, 'TABPRE').Visible := False;
  fFindColumnByName(dbgGrid, 'UNITAR').Visible := False;
  fFindColumnByName(dbgGrid, 'VLRCON').Visible := False;
  fFindColumnByName(dbgGrid, 'VALIPI').Visible := False;
  fFindColumnByName(dbgGrid, 'VALRET').Visible := False;
  fFindColumnByName(dbgGrid, 'VALCBS').Visible := False;
  fFindColumnByName(dbgGrid, 'VALIBS').Visible := False;
  fFindColumnByName(dbgGrid, 'VAL_IS').Visible := False;
  fFindColumnByName(dbgGrid, 'AGUARD').Visible := (Copy(fCfgSis('CELEGS', varString), 1, 1) = 'S') and (fVerificaAcessoSistema('FXESAL', strLoginUsuarioLogado)) and fEhAnaliseTecnica;
  fFindColumnByName(dbgGrid, 'SALDIS').Visible := False;
  fFindColumnByName(dbgGrid, 'BRINDE').Visible := False;
  fFindColumnByName(dbgGrid, 'TIPBRI').Visible := False;
  fFindColumnByName(dbgGrid, 'PROMOC').Visible := False;
  fFindColumnByName(dbgGrid, 'ABRSAL').Visible := False;
  pnlMostraPrecoProd.Visible := False;
  pnlAg_Pec.Visible := False;
  pnlDadosItem.Visible := False;

  lblValSer.Visible := False;
  edtValSe1.Visible := False;
  chkBrindeSer.Visible := False;
  fFindColumnByName(dbgServico, 'VALUNI').Visible := False;
  fFindColumnByName(dbgServico, 'DESESP').Visible := False;
  fFindColumnByName(dbgServico, 'VALSER').Visible := False;
  fFindColumnByName(dbgServico, 'BRINDE').Visible := False;
  fFindColumnByName(dbgServico, 'TIPBRI').Visible := False;
  fFindColumnByName(dbgServico, 'TECSER').Visible := False;
  fFindColumnByName(dbgServico, 'CODDES').Visible := True;
  tbsDocsRelacionados.TabVisible := False;

  pnlTotal.Visible := False;

  btnRealizada.Visible := False;
  btnImprimir.Visible := False;
  btnTermoDev.Visible := False;
  btnAlteracao.Visible := False;
  btnEndEnt.Visible := False;
  btnImpSeparacao.Visible := False;
  btnDesEsp.Visible := False;
  btnReprovar.Visible := False;
  btnAprovada.Visible := False;
  btnCancelar.Visible := False;
  btnManutencao.Visible := False;
  btnHisSta.Visible := False;
  btnImpPed.Visible := False;
  btnImpostos.Visible := False;
  btnDevCli.Visible := False;
  btnImpEti.Visible := False;
  if not blnFluxoProcesso then
  begin
    btnConsultaCatalogos.Visible := False;
    btnSalRes.Visible := False;
    btnObservacao.Visible := False;
    lblNOSFab.Visible := False;
    edtNOSFab.Visible := False;
  end
  else
    btnObservacao.Enabled := True;
  btnCancelarOS.Visible := False;
  btnPedCompraItens.Visible := False;
  btnOrdMaoObrCli.Visible := False;
  btnReativar.Visible := False;
  btnUltimasVendas.Visible := False;
  chkAg_Mon.Visible := False;

  chkCobApa.Left := Label12.Left;

  if edtQtdSe1.Visible then
    chkCobApaSer.Left := lblValSer.Left
  else
    chkCobApaSer.Left := edtCodTecSe1.Left;

  RedimensionaRevendaRetornarDeixadoPor;
end;

procedure TfrmFatManConsertoEquip.pAplicarDescontoServicos(fltValDes: Double = 0);
  Var
    fltTotSer, fltVlrDesSer: Double;
begin
  Try
    objConEqu.cdsSerEqu.DisableControls();
    objConEqu.cdsSerEqu.First();

    objConEqu.fltDesEspSer := 0;
    fltTotSer := 0;

    objConEqu.fltVlrCon := objConEqu.fltVlrCon - objConEqu.fltVlrSer;

    While (Not objConEqu.cdsSerEqu.Eof) Do
    Begin
      fltVlrDesSer := 0;

      If (objConEqu.cdsSerEqu.FieldByName('BRINDE').AsString = 'S') Then
      Begin
        objConEqu.cdsSerEqu.Next();
        Continue;
      End;

      objConEqu.cdsSerEqu.Edit();
      objConEqu.cdsSerEqu.FieldByName('PORDES').AsFloat := 0;
      objConEqu.cdsSerEqu.FieldByName('DESESP').AsFloat := 0;

      If (objConEqu.fltPorDes > 0) Then
      Begin
        fltVlrDesSer := fltVlrDesSer + (objConEqu.cdsSerEqu.FieldByName('VALUNI').AsFloat * objConEqu.cdsSerEqu.FieldByName('QTDSER').AsFloat) * (objConEqu.fltPorDes / 100);

        objConEqu.cdsSerEqu.FieldByName('PORDES').AsFloat := objConEqu.fltPorDes;
        objConEqu.cdsSerEqu.FieldByName('DESESP').AsFloat := (objConEqu.cdsSerEqu.FieldByName('VALUNI').AsFloat * objConEqu.cdsSerEqu.FieldByName('QTDSER').AsFloat) * (objConEqu.fltPorDes / 100);
      End;

      if (fltValDes > 0) then
      begin
        fltVlrDesSer := fltVlrDesSer + ((objConEqu.cdsSerEqu.FieldByName('VALUNI').AsFloat * objConEqu.cdsSerEqu.FieldByName('QTDSER').AsFloat) / objConEqu.fltVlrSerOri) * fltValDes;

        objConEqu.cdsSerEqu.FieldByName('PORDES').AsFloat := (fltVlrDesSer / objConEqu.fltVlrSerOri) * 100;
        objConEqu.cdsSerEqu.FieldByName('DESESP').AsFloat := fltVlrDesSer;
      end;

      objConEqu.fltDesEspSer := objConEqu.fltDesEspSer + fltVlrDesSer;

      objConEqu.cdsSerEqu.FieldByName('VALSER').AsFloat := (objConEqu.cdsSerEqu.FieldByName('VALUNI').AsFloat * objConEqu.cdsSerEqu.FieldByName('QTDSER').AsFloat) - fltVlrDesSer;

      fltTotSer := fltTotSer + objConEqu.cdsSerEqu.FieldByName('VALSER').AsFloat;

      objConEqu.cdsSerEqu.Post();
      objConEqu.cdsSerEqu.Next();
    End;

    objConEqu.fltVlrSer := fltTotSer;
    objConEqu.fltVlrCon := objConEqu.fltVlrCon + objConEqu.fltVlrSer;
  Finally
    objConEqu.cdsSerEqu.EnableControls();
  End;
end;

procedure TfrmFatManConsertoEquip.pAtualizaCamposOSAnterior;
begin
  edtNOSAnt.Text := objConEqu.strNOSAnt;

  if (objConEqu.dtaDtEAnt <> 0) then
    mskDtEAnt.Text := DateToStr(objConEqu.dtaDtEAnt)
  else
    mskDtEAnt.Text := '';

  if (objConEqu.dtaDtRAnt <> 0) then
    mskDtRAnt.Text := DateToStr(objConEqu.dtaDtRAnt)
  else
    mskDtRAnt.Text := '';
end;

procedure TfrmFatManConsertoEquip.pAtualizaDados(DataSet: TDataSet);
Begin
  With objConEqu.cdsIteEqu do
  Begin
    lblCodFab.Caption := FieldByName('CODFAB').AsString;
    lblSaldos.Caption := FormatFloat(fMskDigitos(intDecQtde), FieldByName('SALDOS').AsFloat);
    lblSal_OS.Caption := FormatFloat(fMskDigitos(intDecQtde), FieldByName('SAL_OS').AsFloat);

    lbl_LocFis.Caption := FieldByName('LOCFIS').AsString;
    lbl_LocSup.Caption := FieldByName('LOCSUP').AsString;
  End;
End;

procedure TfrmFatManConsertoEquip.pAtualizaDadosMargemLucro(
  cdsItens: TUniClientDataSet);
var
  blnAltIte: Boolean;
  prcScrollVenda: TprcScroll;
  prcScrollItens: TprcScroll;
begin
  blnAltIte := False;

  try
    pDisableControls(cdsVenda, prcScrollVenda);
    pDisableControls(cdsItens, prcScrollItens);

    cdsItens.First;

    while not cdsItens.Eof do
    begin
      if fEmptyStr(cdsItens.FieldByName('ITE_CODITE').AsString) then
        Break;

      if (RoundTo(cdsItens.FieldByName('ITE_PREINI').AsFloat, -2) <> RoundTo(cdsItens.FieldByName('ITE_UNITAR').AsFloat, -2)) and
         cdsVenda.Locate('AUTOINCREM', cdsItens.FieldByName('AUTOINCREM').AsInteger, []) and
         objConEqu.cdsIteEqu.Locate('SEQITE', cdsItens.FieldByName('AUTOINCREM').AsInteger, []) then
      begin
        objConEqu.strUltOpe := objConEqu.strOperac;
        objConEqu.strOperac := 'G';
        pCarregaItemAlteracao;
        blnAltIte := True;

        If (fEmptyStr(objConEqu.strTabPreIte)) Then fVerificarTabPre();

        edtUnitar.Text := FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)),
          cdsItens.FieldByName('ITE_UNITAR').AsFloat);
        pCalculaTotIte;
        pAdicionaItem;

        cdsVenda.Edit;

        cdsVenda.FieldByName('ITE_UNITAR').AsFloat := cdsItens.FieldByName('ITE_UNITAR').AsFloat;
        cdsVenda.FieldByName('ITE_UNIDIG').AsFloat := cdsItens.FieldByName('ITE_UNITAR').AsFloat;
        cdsVenda.FieldByName('ITE_DESCON').AsFloat := 0;
        cdsVenda.FieldByName('ITE_TOTITE').AsFloat := cdsItens.FieldByName('ITE_TOTITE').AsFloat;

        if (objEmitirPedido.objFatVenda.strIdePro = 'NOR') And (Pos('ITEM ESPECIAL', cdsVenda.FieldByName('ITE_DESORI').AsString) <= 0) and
           (not fEhItemVendaVidro(cdsVenda.FieldByName('ITE_CODITE').AsString)) then
        begin
          pCalculaPrecoCusto(cdsVenda, cdsVenda.FieldByName('ITE_UNITAR').AsFloat,
                             cdsVenda.FieldByName('ITE_CUSITE').AsFloat,
                             (Pos('ITEM ESPECIAL', cdsVenda.FieldByName('ITE_DESORI').AsString) > 0),
                             fEhItemVendaVidro(cdsVenda.FieldByName('ITE_CODITE').AsString),
                             cdsVenda.FieldByName('ITE_ICMSAI').AsFloat);

          cdsVenda.FieldByName('ITE_PRECUS').AsFloat := objEmitirPedido.objFatVenda.fltPreCus;
          cdsVenda.FieldByName('ITE_PRECU2').AsFloat := objEmitirPedido.objFatVenda.fltPreCu2;
        end;

        if fEmptyStr(cdsVenda.FieldByName('ITE_TABPRE').AsString) Or (cdsVenda.FieldByName('ITE_PREVE' + cdsVenda.FieldByName('ITE_TABPRE').AsString).AsFloat = 0) then
          cdsVenda.FieldByName('ITE_PRETAB').AsFloat := cdsVenda.FieldByName('ITE_UNIORI').AsFloat
        else
          cdsVenda.FieldByName('ITE_PRETAB').AsFloat := cdsVenda.FieldByName('ITE_PREVE' + cdsVenda.FieldByName('ITE_TABPRE').AsString).AsFloat +
                                          fFormataFloat(cdsVenda.FieldByName('ITE_PREVE' + cdsVenda.FieldByName('ITE_TABPRE').AsString).AsFloat *
                                                       (cdsVenda.FieldByName('ITE_TAXJUR').AsFloat / 100.0), objEmitirPedido.objFatVenda.VS_intDecUni);

        cdsVenda.FieldByName('ITE_PRETAB').AsFloat := fFormataFloat(cdsVenda.FieldByName('ITE_PRETAB').AsFloat, objEmitirPedido.objFatVenda.VS_intDecUni);

        if fCfgSis('PRETAB', varBoolean) then
        begin
          if cdsVenda.FieldByName('ITE_PRETAB').AsFloat <> 0 then
            cdsVenda.FieldByName('ITE_VARTAB').AsFloat := ((cdsVenda.FieldByName('ITE_UNITAR').AsFloat / cdsVenda.FieldByName('ITE_PRETAB').AsFloat) - 1) * 100;
        end
        else
        begin
          if cdsVenda.FieldByName('ITE_UNIORI').AsFloat <> 0 then
            cdsVenda.FieldByName('ITE_VARTAB').AsFloat := ((cdsVenda.FieldByName('ITE_UNITAR').AsFloat / cdsVenda.FieldByName('ITE_UNIORI').AsFloat) - 1) * 100;
        end;

        if (objEmitirPedido.objFatVenda.fltVlCtVn > 0) And fItemUtilizaPrecoEmDolar(cdsVenda.FieldByName('ITE_CODITE').AsString) then
          cdsVenda.FieldByName('ITE_UNIDOL').AsFloat := cdsVenda.FieldByName('ITE_UNITAR').AsFloat / objEmitirPedido.objFatVenda.fltVlCtVn;

        cdsVenda.Post;

        objEmitirPedido.objFatVenda.pCalculaTotGerProdutoSelecionado(cdsVenda);
      end;

      cdsItens.Next;
    end;

    if blnAltIte then
    begin
      objConEqu.fAtualizaSaldos;
      dbgGrid.Refresh;
    end;
  finally
    pEnableControls(cdsVenda, prcScrollVenda);
    pEnableControls(cdsItens, prcScrollItens);
  end;
end;

procedure TfrmFatManConsertoEquip.pAtualizaEmpFaturamentoSemSaldo;
begin
  if (objConEqu.strCodCli = edtCodCli.Text) then
    Exit;

  if (fEmptyStr(objConEqu.strNumPed)) then
    Exit;

  if fRetCgcCpf(edtCodCli.Text).Length > 11 then
    objConEqu.strEmpFatSemSaldo := fCfgSis('SSAEPJ')
  else
    objConEqu.strEmpFatSemSaldo := fCfgSis('SSAEPF');
end;

function TfrmFatManConsertoEquip.fAtualizaDataFimManutencao: Boolean;
var
  dtaFinMan: TDateTime;
  strDigMan: String;
  blnInformarDigitadorOuDataMan: Boolean;
  frmFatManFinalizaManutencao: TfrmFatManFinalizaManutencao;
begin
  Result := True;

  blnInformarDigitadorOuDataMan := blnFluxoProcesso and (fCfgSis('FXDTFM', varBoolean) or
    (blnUsaDig and fCfgSis('FXSDFM', varBoolean)));

  if blnInformarDigitadorOuDataMan then
  begin
    pCriarFormularios(TfrmFatManFinalizaManutencao, frmFatManFinalizaManutencao);
    try
      frmFatManFinalizaManutencao.ShowModal;

      if (frmFatManFinalizaManutencao.ModalResult <> mrOk) then
        Exit(False);

      dtaFinMan := frmFatManFinalizaManutencao.dtaFinMan;
      strDigMan := frmFatManFinalizaManutencao.strDigMan;
      objConEqu.strCodDig := strDigMan;
    finally
      pFreeAndNil(frmFatManFinalizaManutencao);
    end;

    objConEqu.pAtualizaInicioFimOperacoes(4, True, dtaFinMan, strDigMan);
  end
  else
    objConEqu.pAtualizaInicioFimOperacoes(4, True);
end;

procedure TfrmFatManConsertoEquip.pAtualizaTotais;
begin
  lblTotPro.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltVlrPro);
  lblTotSer.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltVlrSer);
  lblTotGer.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltVlrCon);
  lblTotDes.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltDesEsp + objConEqu.fltDesEspSer);
  lblTotST.Caption  := FormatFloat(fMskDigitos(2), objConEqu.fltTotRet);
  lblTotIPI.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltTotIpi);
  lblTotFre.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltValFre);
  lblTotRef.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltTotCbs + objConEqu.fltTotIbs + objConEqu.fltTotIs);

  lblTotST.Visible  := (objConEqu.fltTotRet > 0);
  lblTotIPI.Visible := (objConEqu.fltTotIpi > 0);
  lblTotFre.Visible := (objConEqu.fltValFre > 0);
  lblTotRef.Visible := fSomarNovosImpostosDaReformaAoValorContabil and (objConEqu.fltTotCbs + objConEqu.fltTotIbs + objConEqu.fltTotIs > 0);

  lblST.Visible  := lblTotST.Visible;
  lblIPI.Visible := lblTotIPI.Visible;
  lblFre.Visible := lblTotFre.Visible;
  lblRef.Visible := lblTotRef.Visible;

  If fCfgSis('TR1DES', varBoolean) Then
    cmbEntRet.Enabled := (objConEqu.cdsIteEqu.IsEmpty);

  pHabilitaLocRet;
end;

procedure TfrmFatManConsertoEquip.pAvisoAgMontagemSemSaldo;
begin
  chkAg_Mon.Checked := False;
  fMensagem('', 'Para marcar esta O.S. como AGUARDANDO MONTAGEM' + #13 +
                'é necessário que todas as peças estejam disponíveis!', ['&Ok']);
end;

procedure TfrmFatManConsertoEquip.pBaixaOcorrenciasCRM;
var
  qryFGOEQU: TUniQuery;
  objAtuCrm: TAtuOcoCrm;
begin
  if (not fCfgSis('UTICRM', varBoolean)) then
    Exit;

  objAtuCrm := TAtuOcoCrm.Create(Nil);
  qryFGOEQU := fCriaQuery(Self);

  try
    qryFGOEQU.Close;
    qryFGOEQU.SQL.Text := SELECT_PD_EQUGOR;
    qryFGOEQU.ParamByName('SEQEQU').AsString := objConEqu.strAutInc;
    qryFGOEQU.Open;

    if (not qryFGOEQU.IsEmpty) then
    begin
      while not qryFGOEQU.Eof do
      begin
        objAtuCrm.pCarregaOcorrenciaCliente(qryFGOEQU.FieldByName('CODEMP').AsString, 'PD',
          qryFGOEQU.FieldByName('NUMDOC').AsString, qryFGOEQU.FieldByName('CODCLI').AsString);
        objAtuCrm.pFinalizaOcorrencia('Baixa realizada pela rotina de Conserto de Equipamentos.');

        qryFGOEQU.Next;
      end;
    end
    else if (not fEmptyStr(objConEqu.strNumPed)) then
    begin
      objAtuCrm.pCarregaOcorrenciaCliente(objConEqu.strEmpPed, 'PD', objConEqu.strNumPed,
        IIF((objConEqu.strGarant <> 'N') and (not fEmptyStr(objConEqu.strCliGar)), objConEqu.strCliGar, objConEqu.strCodCli));
      objAtuCrm.pFinalizaOcorrencia('Baixa realizada pela rotina de Conserto de Equipamentos.');
    end;
  finally
    FreeAndNil(qryFGOEQU);
    FreeAndNil(objAtuCrm);
  end;
end;

procedure TfrmFatManConsertoEquip.edtCodTecKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryCons: TUniQuery;
    arrSel : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    qryCons := fCriaQuery(Nil);

    if fPesqOperador(Self, edtCodTec, edtDesTec, qryCons, Key, arrSel) then
    
    Begin
      If (fValidaCampos(edtCodTec, True)) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
    FreeAndNil(qryCons);
    
  End;

end;

procedure TfrmFatManConsertoEquip.edtCodTecSe1Exit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtCodTecSe1.Text) Then
  Begin
    If (fValidaCampos(edtCodTecSe1, True)) Then
    Begin
      edtDesTecSe1.Text := fRetNomeOperador(edtCodTecSe1.Text);
    End;
  End;
end;

procedure TfrmFatManConsertoEquip.edtCodTecSe1KeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryCons: TUniQuery;
    arrSel : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    qryCons := fCriaQuery(Nil);

    if fPesqOperador(Self, edtCodTecSe1, edtDesTecSe1, qryCons, Key, arrSel) then
    Begin
      If (fValidaCampos(edtCodTecSe1, True)) Then
        Self.SelectNext(ActiveControl, True, True);
    End;

    FreeAndNil(qryCons);
  End;

end;

procedure TfrmFatManConsertoEquip.edtDesSe1Change(Sender: TObject);
begin
  inherited;
  edtDesSe1.Text := fTiraCaracEspeciais(edtDesSe1.Text);
end;

procedure TfrmFatManConsertoEquip.edtDesSe1KeyPress(Sender: TObject;
  var Key: Char);
  Var
    strTmp: String;
begin
  inherited;
  strTmp := String(Key);

  strTmp := fTiraCaracNota(strTmp);
  If (strTmp = '') Then
    Key := #0
  Else
    Key := strTmp[1];

  If (Key = 'Ç') Or (Key = 'ç') Then
    Key := 'C';
end;

procedure TfrmFatManConsertoEquip.edtDiaEntExit(Sender: TObject);
begin
  inherited;

  if (fCfgSis('CTRPEN', varInteger) = 2) then
    pCalculaDataPrevisao;
end;

procedure TfrmFatManConsertoEquip.edtEmpIteKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel : TConsultasArray;
begin
  inherited;

  if fPesqEmpresa(conEmpSimples, Self, edtEmpIte, edtDesEmpIte, nil, Key, arrSel) then
  begin
    if fValidaCampos(edtEmpIte, True) then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmFatManConsertoEquip.edtEmpSerKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel : TConsultasArray;
begin
  inherited;

  if fPesqEmpresa(conEmpSimples, Self, edtEmpSer, edtDesEmpSer, nil, Key, arrSel) then
  begin
    if fValidaCampos(edtEmpSer, True) then
      SelectNext(ActiveControl, True, True);
  end;
end;

function TfrmFatManConsertoEquip.fDataPrevisao: Boolean;
  var
    dtaPrevis: TDateTime;
begin
  Result := True;
  With objConEqu Do
  Begin
    If (Not fEmptyStr(objConEqu.strStatus)) And
       CharInSet(strStatus[1], ['E','F','A'])      Then
    Begin
      dtaPrevis := IIF(StrToDate(strPrevis) = 0, VS_Date, StrToDate(strPrevis));

      Result := ffrmData(dtaPrevis,'', 'PREVISAO ENTREGA DO ' + IIF(strStatus = 'A','EQUIPAMENTO','ORCAMENTO'), VS_Date);

      If Result Then
        strPrevis := DateToStr(dtaPrevis);
    End;
  End;
end;

procedure TfrmFatManConsertoEquip.edtCodSe1KeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
    objfrmPnl: TPanelCxServico;
    sltServsAntesPesquisa: TStringList;

  function fServAddPorTabPelaPrimeiraVez: Boolean;
     Var
       strCodServ: String;
  begin
    strCodServ := QuotedStr(objConEqu.cdsSerEqu.FieldByName('CODSER').AsString);
    Result     := (Not fEstaNaLista(sltServsAntesPesquisa, strCodServ)) And
                    (fEstaNaLista(sltServ, strCodServ));
  end;

  Function fStrTituloConsulta: String;
  Begin
    Result := 'Consulta de Serviços - Conserto de Equipamentos.';
  end;

begin
  inherited;

  Try
    objfrmPnl := TPanelCxServico.Create(TfrmPnlDadosServico);
    sltServsAntesPesquisa := TStringList.Create;

    sltServsAntesPesquisa.Text := sltServ.Text;
    objFrmPnl.sltLista         := sltServ;
    objFrmPnl.fncTeclaTab      := fInserirServico;

    If fPesqServicos(Self, edtCodSe1, edtDesSe1, nil, Key, arrSel, True, False, objFrmPnl, False) Then
    Begin
      If fServAddPorTabPelaPrimeiraVez Then
      Begin
        btnCancelaSe1.Click;
      End
      Else
      Begin
        If fValidaCampos(edtCodSe1, True) Then
          SelectNext(ActiveControl, True, True);
      End;
    End;
  Finally
    FreeAndNil(objFrmPnl);
    FreeAndNil(sltServsAntesPesquisa);
  End;
end;

procedure TfrmFatManConsertoEquip.pMostraContaCorrente;
begin
  TfrmMostraDebCtrChq2.pMostraContaCorrente(edtCodCli.Text, 'A');
end;

procedure TfrmFatManConsertoEquip.pMostraDocumentosGerados;
var
  intIndex: Integer;
  imImpPdOr,
  imImpSep: TDadosImprimePdOrSep;
  cdsLogItensSep,
  cdsDados: TUniClientDataSet;
Begin
  pCriarFormularios(TfrmFatPedidosImpr, frmFatPedidosImpr);

  try
    try
      With frmFatPedidosImpr Do
      Begin
        blnImprime := True;
        blnSepara  := blnImprime and objConEqu.cdsDocGer.Locate('IMPSEP', True, []);
        blnMostraPreco := fCfgSis('ORCSPR', varBoolean, VS_strCodEmp);
        blnConEqu  := True;
        dtsDocumentos.DataSet := objConEqu.cdsDocGer;

        objConEqu.cdsDocGer.BeforePost := objConEqu.pCdsDocGerBeforePost;

        If ShowModal = mrOk Then
        Begin
          If (Not objConEqu.cdsDocGer.IsEmpty) And blnImprime Then
          Begin
            objConEqu.cdsDocGer.First;

            While Not objConEqu.cdsDocGer.Eof Do
            Begin
              For intIndex := 0 To Pred(objConEqu.objFatVendaImp.ItemsCount) Do
              Begin
                If (objConEqu.objFatVendaImp.Items[intIndex].strNumDoc = objConEqu.cdsDocGer.FieldByName('NUMDOC').AsString) And
                   (objConEqu.objFatVendaImp.Items[intIndex].strEspDoc = objConEqu.cdsDocGer.FieldByName('ESPDOC').AsString) And
                   (objConEqu.objFatVendaImp.Items[intIndex].strEmpDoc = objConEqu.cdsDocGer.FieldByName('CODEMP').AsString) Then
                Begin
                  objConEqu.objFatVendaImp.blnPDORMultiLoja := True;

                  {***************************************************************}
                  {* ESSAS VARIAVEIS DEFINIE SE IRÁ OU NÃO IMPRIMIR O PD/OR/SEP  *}
                  {* OBS: POR DEFAULT A FUNÇÃO pImprimeDocumento, JÁ VEM SETADO  *}
                  {* imPerguntaSeImprime. AQUI NESTE CASO NÃO PRECISA PERGUNTAR, *}
                  {* OU IMPRIME SE ESTIVER CONFIGURADO OU NÃO IMPRIME NADA.      *}
                  {************************************************************FC*}
                  imImpPdOr := TDadosImprimePdOrSep.Create;
                  imImpPdOr.imImpDoc := imNaoImprime;
                  imImpPdOr.intQtdVia := 0;

                  imImpSep := TDadosImprimePdOrSep.Create;
                  imImpSep.imImpDoc := imNaoImprime;
                  imImpSep.intQtdVia := 0;

                  If objConEqu.cdsDocGer.FieldByName('IMPRIM').AsBoolean And
                     (objConEqu.cdsDocGer.FieldByName('QTDVIA').AsInteger > 0) Then
                  Begin
                    imImpPdOr.imImpDoc := imImprimeSemPergutar;
                    imImpPdOr.intQtdVia := objConEqu.cdsDocGer.FieldByName('QTDVIA').AsInteger;
                  End;

                  If objConEqu.cdsDocGer.FieldByName('IMPSEP').AsBoolean And
                     (objConEqu.cdsDocGer.FieldByName('SEPVIA').AsInteger > 0) Then
                  Begin
                    imImpSep.imImpDoc := imImprimeSemPergutar;
                    imImpSep.intQtdVia := objConEqu.cdsDocGer.FieldByName('SEPVIA').AsInteger;
                  End;

                  if Assigned(cdsDados) then
                    cdsDados.EmptyDataSet
                  else
                    cdsDados := TUniClientDataSet.Create(Self);

                  pCloneDataSet(cdsDados, objConEqu.cdsIteEqu);
                  cdsDados.Filtered := False;
                  cdsDados.Filter   := 'EMPITE=' + QuotedStr(objConEqu.cdsDocGer.FieldByName('EMPITE').AsString);
                  cdsDados.Filtered := True;

                  if Assigned(cdsLogItensSep) then
                    cdsLogItensSep.EmptyDataSet
                  else
                    cdsLogItensSep := fCriaTemporaria(Self);

                  while not cdsDados.Eof do
                  begin
                    cdsLogItensSep.Append;
                    cdsLogItensSep.FieldByName('AUTOINCREM').AsString := '0';
                    cdsLogItensSep.FieldByName('ITE_CODITE').AsString := cdsDados.FieldByName('CODITE').AsString;
                    cdsLogItensSep.FieldByName('ITE_DESITE').AsString := cdsDados.FieldByName('DESITE').AsString;
                    cdsLogItensSep.FieldByName('ITE_QTDITE').AsFloat  := cdsDados.FieldByName('QTDITE').AsFloat;
                    cdsLogItensSep.FieldByName('ITE_STALOG').AsString := 'I';
                    cdsLogItensSep.FieldByName('ITE_DESUNI').AsString := cdsDados.FieldByName('UNIDAD').AsString;
                    cdsLogItensSep.Post;

                    cdsDados.Next;
                  end;

                  objConEqu.objFatVendaImp.pSetCdsLogSep(intIndex, cdsLogItensSep);

                  If (Not ((imImpPdOr.imImpDoc = imNaoImprime) And (imImpSep.imImpDoc = imNaoImprime))) Then
                    objConEqu.objFatVendaImp.pImprimeDocumento(objConEqu.objFatVendaImp.Items[intIndex], imImpPdOr, imImpSep);

                  FreeAndNil(imImpPdOr);
                  FreeAndNil(imImpSep);

                  If Not objConEqu.cdsDocGer.FieldByName('PRDAMO').AsBoolean Then
                    Break;
                End;
              End;

              Application.ProcessMessages;
              objConEqu.cdsDocGer.Next;
            End;
          End;
        End;

        objConEqu.cdsDocGer.BeforePost := nil;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[pMostraDocumentosGerados]');
      End;
    End;
  finally
    if Assigned(cdsLogItensSep) then
      FreeAndNil(cdsLogItensSep);

    if Assigned(cdsDados) then
      FreeAndNil(cdsDados);

    pFreeAndNil(frmFatPedidosImpr);
  end;
end;

procedure TfrmFatManConsertoEquip.pMostraObsCliente(strCodCli: String);
  Var
    qryCliObs: TUniQuery;
    strCliObs: String;
begin

  qryCliObs := fCriaQuery(Nil);

  With qryCliObs Do
  Begin
    SQL.Add('SELECT SQL_NO_CACHE CLI_OBSERV FROM CADCLI WHERE CLI_CODCLI =:CODCLI ');
    ParamByName('CODCLI').AsString := strCodCli;
    Open;
    strCliObs := FieldByName('CLI_OBSERV').AsString;
  End;

  FreeAndNil(qryCliObs);

  If (fEmptyStr(strCliObs)) Then
    Exit;

  Try
    pCriarFormularios(TfrmFatMostraObsCliente, frmFatMostraObsCliente);
    frmFatMostraObsCliente.memObserv.Texto := strCliObs;
    frmFatMostraObsCliente.strCodCli := strCodCli;
    frmFatMostraObsCliente.showModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[pMostraObsCliente]');
  End;

  pFreeAndNil(frmFatMostraObsCliente);

end;

procedure TfrmFatManConsertoEquip.pMostrarMensagemValidacaoExpedicao;
begin
  fMensagem('', 'O pedido gerado por esta ordem de serviço ainda não teve'+#13+
                  'seus itens liberados pela expedição.'+#13+
                  'Favor verificar com o departamento responsável!', ['&Ok']);
end;

procedure TfrmFatManConsertoEquip.pMostraUltimasVendas(blnPrecoServico: boolean);
Var
  strCodRedeLojasCliente: String;
begin

  strCodRedeLojasCliente := fCampoTabela('CLI_CODRED', 'CADCLI', ['CLI_CODCLI'], [edtCodCli.Text]);

  if not fEmptyStr(edtCodSe1.text+edtCodIte.text) then
  begin

    If Not fEmptyStr(strCodRedeLojasCliente) And
      (fMensagem('','Exibir movimento para toda a rede de lojas do cliente?', ['','']) = 2) Then
    Begin
      strCodRedeLojasCliente := '';
    End;

    if blnPrecoServico then
    begin

      If Assigned(prcExecutaRelatorio) Then
      begin
        prcExecutaRelatorio(213, 7660, [],
                            ['CODEMP','CODSER','CODCLI','REDLOJ'],
                            [IfThen(fEmptyStr(objConEqu.strCodEmp),VS_strCodEmp,objConEqu.strCodEmp),
                            IfThen(fEmptyStr(edtCodSe1.text),objConEqu.cdsSerEqu.fieldbyname('CODSER').AsString,edtCodSe1.text),
                            edtCodCli.text,
                            strCodRedeLojasCliente],
                            nil,
                            nil,
                            True);
      End;

    end
    else
    begin

      If Assigned(prcExecutaRelatorio) Then
      begin
        prcExecutaRelatorio(212, 7659, [],
                            ['CODITE','CODCLI','REDLOJ'],
                            [IfThen(fEmptyStr(edtCodIte.text),objConEqu.cdsIteEqu.FieldByName('CODITE').AsString,edtCodIte.text),
                            edtCodCli.text,
                            strCodRedeLojasCliente],
                            nil,
                            nil,
                            True);
      End;

    end;

  end;

end;

procedure TfrmFatManConsertoEquip.pOSToEndereco;
begin
  if (edtCodCli.Text <> objConEqu.strCodCliAnt) then
    objConEqu.strEntGer := '';

  If Not fEmptyStr(objConEqu.strEntGer) Then
    objEndEnt.recEndere.strIncrem := objConEqu.strEntGer;

  If Not fEmptyStr(objConEqu.strCodCli) Then
    objEndEnt.recEndere.strCodCli := objConEqu.strCodCli;
end;

function TfrmFatManConsertoEquip.fRealizarVincularDocFiscal: Boolean;
begin
  Result := (objConEqu.strStatus <> 'A') And (objConEqu.strStatus <> 'M') And
     (Not ((InformarNFEntSaiAlterarObsOSRealizadaReprovada) And (objConEqu.strStatus = 'R'))) And
     (Not ((InformarNFEntSaiAlterarObsOSRealizadaReprovada) And (objConEqu.strStatus = 'N')));
end;

function TfrmFatManConsertoEquip.fRepAgMontage: Boolean;
begin
  Result := (Not fEmptyStr(objConEqu.strStatus)) And (Not fEmptyStr(objConEqu.strSubSta)) And
            (objConEqu.strStatus[1] = 'N') And ( (objConEqu.strSubSta[1] = 'A') Or (objConEqu.strSubSta[1] = 'C') ) And (fCfgSis('EQUREP', varBoolean));
end;

function TfrmFatManConsertoEquip.fRequisicaoCompraVinculada: Boolean;
begin
  Result := False;
  if not qryFatgor.Active then
    Exit;

  if qryFatgor.IsEmpty then
    Exit;

  if not Assigned(qryFatgor.FieldByName('FGO_INRQCP')) then
    Exit;

  if fEmptyStr(qryFatgor.FieldByName('FGO_INRQCP').AsString) then
    Exit;

  Result := True;
end;

procedure TfrmFatManConsertoEquip.pRetiraDaListaConsulta(strCodigo, strCampo, strCampoConsulta: String; stlLista: TStringList; cdsDados, cdsConsulta: TUniClientDataSet);


  function fEstaRepetido:Boolean;
    Var
      cdsTemp: TUniClientDataSet;
  begin
    Result := False;

    cdsTemp := objConEqu.fCopiarFieldsDataSet(cdsDados);

    Try
      pCloneDataSet(cdsTemp, cdsDados);
      With cdsTemp Do
      Begin
        Active := False;
        Filter := strCampo + ' = ' + QuotedStr(strCodigo);
        Filtered := True;
        Active := True;

        If Not IsEmpty Then
          Result := RecordCount > 1;
      End;

    Finally
      FreeAndNil(cdsTemp)
    End;
  End;

  Var
    intIndice: Integer;
Begin
  If fEstaRepetido Then
    Exit;

  If stlLista.Find(QuotedStr(strCodigo), intIndice) Then
    stlLista.Delete(intIndice);

  If Assigned(cdsConsulta) And (Not cdsConsulta.IsEmpty) And
     (cdsConsulta.FieldByName(strCampoConsulta).AsString = strCodigo) Then
  Begin
    cdsConsulta.Edit;
    cdsConsulta.FieldByName('VENDIDO').Clear;
    cdsConsulta.Post;
  End;
end;

function TfrmFatManConsertoEquip.fDigDadosConsumidor: Boolean;
begin

  With objConEqu Do
  Begin
    strCodCliPreCadastro := '';

    If Not fClienteConsumidor(fRetNomCliente(strCodCli), False, True) Then
    Begin
      Result    := True;
      strCliNom := '';
      strCliEnd := '';
      strCliBai := '';
      strCliCep := '';
      strCodCid := '';
      strCliCid := '';
      strCliEst := '';
      strCliTel := '';
      intCgcCpf := 0;
      strCliCgc := '';
      strCliIes := '';
      strCli_Rg := '';
      strCodAti := '';
      dtaNasCon := 0;
    End
    Else
    Begin

      Try
        pCriarFormularios(TfrmFatDadosCliConsumidor, frmFatDadosCliConsumidor);

        strCliEst := fRetUFCliente(strCodCli);
        strCodAti := fRetornaAtividadeCliente(strCodCli);

        frmFatDadosCliConsumidor.strCodCli      := strCodCli;           // - Código
        frmFatDadosCliConsumidor.edtNomCli.Text := strCliNom;           // - Nome
        frmFatDadosCliConsumidor.edtEndere.Text := strCliEnd;           // - Endereco
        frmFatDadosCliConsumidor.edtBairro.Text := strCliBai;           // - Bairro
        frmFatDadosCliConsumidor.mskNumCep.Text := strCliCep;           // - Cep
        frmFatDadosCliConsumidor.edtCodCid.Text := strCodCid;           // - Cod. Cidade
        frmFatDadosCliConsumidor.edtNomCid.Text := strCliCid;           // - Cidade
        frmFatDadosCliConsumidor.edtEstado.Text := strCliEst;           // - Estado
        frmFatDadosCliConsumidor.mskTelCon.Text := strCliTel;           // - Telefone
        frmFatDadosCliConsumidor.edtCgcCpf.Text := IntToStr(intCgcCpf); // - CGC/CPF
        frmFatDadosCliConsumidor.mskNumCgc.Text := strCliCgc;           // - CNPJ
        frmFatDadosCliConsumidor.edtInsEst.Text := strCliIes;           // - Ins.Estadual
        frmFatDadosCliConsumidor.edtRgCli.Text  := strCli_Rg;           // - Rg
        frmFatDadosCliConsumidor.strEstado      := strCliEst;           // - Estado
        frmFatDadosCliConsumidor.edtEmail_.Text := strCliEma;           // - Email para NFe

        If (fCfgSis('PRECAD', varBoolean)) Then
        Begin
          frmFatDadosCliConsumidor.blnUtilizarPreCadastroConsumidor := True;
          frmFatDadosCliConsumidor.edtCodAtividade.Text := strCodAti;     // - Estado
          frmFatDadosCliConsumidor.edtNomAtividade.Text := fRetAtividade(strCodAti); // - Descrição Atividade
        End;

        frmFatDadosCliConsumidor.blnNasCon := fCfgSis('NASCON', VarBoolean);

        If dtaNasCon > 0 Then
          frmFatDadosCliConsumidor.mskDtaNas.Text := DateToStr(dtaNasCon);

        frmFatDadosCliConsumidor.showModal;

        Result := frmFatDadosCliConsumidor.blnConfirma;

        If frmFatDadosCliConsumidor.blnConfirma Then
        Begin
          strCodCliPreCadastro := frmFatDadosCliConsumidor.strCodCliPreCadastro;

          If fEmptyStr(strCodCliPreCadastro) Then
          Begin
            strCliNom := frmFatDadosCliConsumidor.edtNomCli.Text; // - Nome
            strCliEnd := frmFatDadosCliConsumidor.edtEndere.Text; // - Endereco
            strCliBai := frmFatDadosCliConsumidor.edtBairro.Text; // - Bairro
            strCliCep := frmFatDadosCliConsumidor.mskNumCep.Text; // - Cep
            strCodCid := frmFatDadosCliConsumidor.edtCodCid.Text; // - Cód. Cidade
            strCliCid := frmFatDadosCliConsumidor.edtNomCid.Text; // - Cidade
            strCliEst := frmFatDadosCliConsumidor.edtEstado.Text; // - Estado
            strCliTel := frmFatDadosCliConsumidor.mskTelCon.Text; // - Telefone
            strCliCgc := frmFatDadosCliConsumidor.mskNumCgc.Text; // - CNPJ
            strCli_Rg := frmFatDadosCliConsumidor.edtRgCli.Text;  // - RG
            strCliEma := frmFatDadosCliConsumidor.edtEmail_.Text; // - Email

            If fEmptyStr(frmFatDadosCliConsumidor.edtCgcCpf.Text) Then
              intCgcCpf := 0
            Else
              intCgcCpf := StrToInt(frmFatDadosCliConsumidor.edtCgcCpf.Text); // - CGC/CPF

            strCliIes := frmFatDadosCliConsumidor.edtInsEst.Text;             // - Ins.Estadual
            If (fCfgSis('PRECAD', varBoolean)) Then
              strCodAti := frmFatDadosCliConsumidor.edtCodAtividade.Text;

            dtaNasCon := strToDateDef(frmFatDadosCliConsumidor.mskDtaNas.Text, 0);
          End;

        End;

      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, '[frmFatDadosCliConsumidor]');
        End;
      End;

      pFreeAndNil(frmFatDadosCliConsumidor);

    End;

  End;

end;

procedure TfrmFatManConsertoEquip.cbGarantChange(Sender: TObject);
begin
  inherited;
  Case cbGarant.ItemIndex Of
   0,1,2:
   Begin
     lblNroDoc.Caption := 'NF Compra:';
     lblDatEnt.Caption := 'Emissão NF Compra:';
   End;
   3:
   Begin
     lblNroDoc.Caption := 'OS Anterior:';
     lblDatEnt.Caption := 'Dt. Emissão OS:';
   End;
  End;

  if (cbGarant.ItemIndex > 0) then
    edtTmpGar.Enabled := True
  else
  begin
    edtTmpGar.Enabled := False;
    edtTmpGar.Text    := '0';
  end;

  if (cbGarant.ItemIndex <> 0) then
  begin
    lblNOSFab.Visible := True;
    edtNOSFab.Visible := True;
  end
  else
  begin
    lblNOSFab.Visible := False;
    edtNOSFab.Visible := False;
    edtNOSFab.Clear;
  end;

  if cbGarant.Text <> 'Não' then
  begin
    if (not blnRotinaTecnico) then
    begin
      if (not chkBrindePro.Visible) then
        chkCobAPa.Left := chkBrindePro.Left
      else
        chkCobAPa.Left := pnlTipBriPrd.Left;

      if (not chkBrindeSer.Visible) then
        chkCobAPaSer.Left := chkBrindeSer.Left
      else
        chkCobAPaSer.Left := pnlTipBriSer.Left;
    end;

    chkCobAPa.Visible    := fCfgSis('OSGCAP', varBoolean);
    chkCobAPaSer.Visible := fCfgSis('OSGCAP', varBoolean);
  end
  else
  begin
    chkCobAPa.Visible    := False;
    chkCobAPaSer.Visible := False;
  end;

  fFindColumnByName(dbgGrid   , 'COBAPA').Visible := chkCobAPa.Visible;
  fFindColumnByName(dbgServico, 'COBAPA').Visible := chkCobAPaSer.Visible;

  pHabilitaNFCompraAnaliseTec;
end;

procedure TfrmFatManConsertoEquip.cbTabPrecoExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(cbTabPreco, True);
end;

procedure TfrmFatManConsertoEquip.cbTabPrecoItemExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(cbTabPrecoItem, True);
end;

procedure TfrmFatManConsertoEquip.cbTabPrecoItemKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If Not CharInSet(key, ['0'..'9','/','?',#8]) then
    key := #0;
end;

procedure TfrmFatManConsertoEquip.cbTabPrecoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If Not CharInSet(key, ['0'..'9','/','?',#8]) then
    key := #0;
end;

procedure TfrmFatManConsertoEquip.cbEstPrdExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(cbEstPrd, True);
end;

procedure TfrmFatManConsertoEquip.chkAg_MonClick(Sender: TObject);

  function fTemPecaEmFalta: Boolean;
  begin
    Result := False;
    objConEqu.cdsIteEqu.First;

    while not objConEqu.cdsIteEqu.Eof do
    begin
      if (objConEqu.cdsIteEqu.FieldByName('AGUARD').AsString = 'S') then
      begin
        Result := True;
        Exit;
      end;

      objConEqu.cdsIteEqu.Next;
    end;
  end;

begin
  inherited;

  if  (chkAg_Mon.Checked = objConEqu.blnAg_Mon) then
    Exit;

  if (chkAg_Mon.Checked) and (fTemPecaEmFalta) then
    if (not fPodeMarcarAgMontagemSemSaldo) then
      Exit;

  objConEqu.blnAg_Mon := chkAg_Mon.Checked;

  If (chkAg_Mon.Focused) And (chkAg_Mon.Visible) Then
    objConEqu.pAlteraStatusAguardandoMontagem;
end;

procedure TfrmFatManConsertoEquip.chkAutDescarteClick(Sender: TObject);
begin
  inherited;

  objConEqu.blnAutorizaDescarte := chkAutDescarte.Checked;
end;

procedure TfrmFatManConsertoEquip.chkBrindeProClick(Sender: TObject);
Var
  strPromoc : String;

  function fVendedorTemPermissaoEmitirBrinde: Boolean;
  begin
    If blnUsaDig And (pnlRepDig.Visible) And (Not fEmptyStr(edtSenDig.Text)) Then
      Result := objConEqu.fVerificaAcessoSistemaOS('frmFatVendas - BR', 'Liberado direito de acesso para vendedor conceder brinde na ordem de serviço.', fRetCodVendedor(edtSenDig.Text))
    Else
      Result := objConEqu.fVerificaAcessoSistemaOS('frmFatVendas - BR', 'Liberado direito de acesso para vendedor conceder brinde na ordem de serviço.', fRetCodVendedor(edtSenVen.Text));

    If Not Result Then
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Emitir Brinde de Produto');
      objLiberacao.objMsgLibera.pAddSeparador(65);
      objLiberacao.objMsgLibera.pAddTextoCaption('Produto'    , edtCodIte.Text + ' - ' + edtDesIte.Text , 10);
      objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade' , edtQtdIte.Text                          , 10);
      objLiberacao.objMsgLibera.pAddQuebra;

      objLiberacao.strDirAce := 'frmFatVendas - BR';
      objLiberacao.strMsgSen := 'Emitir Brinde de Produto';
      objLiberacao.strCodOpe := fRetCodVendedor(edtSenVen.Text);
      objLiberacao.strCodDig := strLoginUsuarioLogado;
      objLiberacao.strCliente := edtCodCli.Text + '-' + edtNomCli.Text;

      Result := objLiberacao.fLibera;

    End;
  end;

begin
  inherited;
  If Not chkBrindePro.Visible Then
  Begin
    chkBrindePro.Checked := False;
    Exit;
  End;

  If chkBrindePro.Checked And chkBrindePro.Focused And Not fVendedorTemPermissaoEmitirBrinde Then
  Begin
    chkBrindePro.Checked := False;
  End;

  If Not chkBrindePro.Checked And (fStrToFloat(edtUnitar.Text) = 0) Then
  Begin
    If (fEmptyStr(objConEqu.strTabPreIte)) Then fVerificarTabPre();

    edtUnitar.Text := FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)),
      objConEqu.fRetPreVen(edtCodIte.Text,
                           IIF(cbTabPrecoItem.Visible, objConEqu.strTabPreIte, objConEqu.strTabPre),
                           strPromoc));
    pCalculaTotIte;
  End;

  if (chkBrindePro.Checked) and (not fCfgSis('USAPAR', varBoolean)) then
  begin
    pnlTipBriPrd.Visible := True;
    edtTipBriPrd.Text    := 'G';
    chkCobAPa.Left       := chkCobAPa.Left + 232;
  end
  else
  begin
    pnlTipBriPrd.Visible := False;

    if (not fCfgSis('USAPAR', varBoolean)) then
      chkCobAPa.Left       := chkCobAPa.Left - 232;
  end;
end;

procedure TfrmFatManConsertoEquip.chkBrindeSerClick(Sender: TObject);

  function fVendedorTemPermissaoEmitirBrinde: Boolean;
  begin
    If blnUsaDig And (pnlRepDig.Visible) And (Not fEmptyStr(edtSenDig.Text)) Then
      Result := objConEqu.fVerificaAcessoSistemaOS('frmFatVendas - BR', 'Liberado direito de acesso para vendedor conceder brinde na ordem de serviço.', fRetCodVendedor(edtSenDig.Text))
    Else
      Result := objConEqu.fVerificaAcessoSistemaOS('frmFatVendas - BR', 'Liberado direito de acesso para vendedor conceder brinde na ordem de serviço.', fRetCodVendedor(edtSenVen.Text));

    If Not Result Then
    Begin

      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Emitir Brinde de Serviço');
      objLiberacao.objMsgLibera.pAddSeparador(65);
      objLiberacao.objMsgLibera.pAddTextoCaption('Serviço' , edtCodSe1.Text + ' - ' + edtDesSe1.Text);
      objLiberacao.objMsgLibera.pAddQuebra;

      objLiberacao.strDirAce := 'frmFatVendas - BR';
      objLiberacao.strMsgSen := 'Emitir Brinde de Serviço';
      objLiberacao.strCodOpe := fRetCodVendedor(edtSenVen.Text);
      objLiberacao.strCodDig := strLoginUsuarioLogado;
      objLiberacao.strCliente := edtCodCli.Text + '-' + edtNomCli.Text;

      Result := objLiberacao.fLibera;

    End;
  end;

begin
  inherited;
  If Not chkBrindeSer.Visible Then
  Begin
    chkBrindeSer.Checked := False;
    Exit;
  End;

  If chkBrindeSer.Checked And chkBrindeSer.Focused And Not fVendedorTemPermissaoEmitirBrinde Then
  Begin
    chkBrindeSer.Checked := False;
  End;

  If Not chkBrindeSer.Checked And (fStrToFloat(edtValSe1.Text) = 0) Then
  Begin
    edtValSe1.Text := FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)),
                                  fRetornaValorServico(edtCodSe1.Text));
  End;

  if (chkBrindeSer.Checked) and (not fCfgSis('USAPAR', varBoolean)) then
  begin
    pnlTipBriSer.Visible := True;
    edtTipBriSer.Text    := 'G';
    chkCobAPaSer.Left    := chkCobAPaSer.Left + 232;
  end
  else
  begin
    pnlTipBriSer.Visible := False;

    if (not fCfgSis('USAPAR', varBoolean)) then
      chkCobAPaSer.Left    := chkCobAPaSer.Left - 232;
  end;
end;

procedure TfrmFatManConsertoEquip.chkPrtAtdClick(Sender: TObject);
begin
  inherited;
  objConEqu.blnPrtAtd := chkPrtAtd.Checked;
end;

procedure TfrmFatManConsertoEquip.chkVenPreClick(Sender: TObject);
Var
  blnVendaPresencialAnt,
  blnAcessoParaAlterarVendaPresencial : Boolean;
begin

  inherited;

  If Assigned(objEmitirPedido) And Assigned(objEmitirPedido.objFatVenda) Then
  Begin

    blnAcessoParaAlterarVendaPresencial := fVerificaAcessoSistema('ALTVPR', strLoginUsuarioLogado);

    If (Not blnAcessoParaAlterarVendaPresencial) And (chkVenPre.Visible) And (blnEntrouVenPre) Then
    Begin

      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Liberação para alterar o campo venda presencial!');

      objLiberacao.strDirAce  := 'ALTVPR';
      objLiberacao.strMsgSen  := 'Sem direito de acesso para alterar o campo venda presencial!';
      objLiberacao.strCodOpe  := objConEqu.strCodVen;
      objLiberacao.strCodDig  := objConEqu.strCodDig;

      If Not objEmitirPedido.objFatVenda.fFatMensagemLiberacao(objLiberacao) Then
        Exit;

    End;

    blnVendaPresencialAnt := objConEqu.blnVenPre;
    objConEqu.blnVenPre   := chkVenPre.Checked;

    If Assigned(objEmitirPedido) And Assigned(objEmitirPedido.objFatVenda) Then
      objEmitirPedido.objFatVenda.blnVendaPresencial := chkVenPre.Checked;

    If (dtsIteEqu.DataSet.RecordCount > 0) And (objConEqu.blnVenPre <> blnVendaPresencialAnt) Then
    Begin
      fInicializarFatVenda;
      objConEqu.pRecalculaPrecos(cbTabPreco.Text);
      pAtualizaTotais();
    End;

  End;

end;

procedure TfrmFatManConsertoEquip.chkVenPreEnter(Sender: TObject);
begin
  inherited;
  blnEntrouVenPre := True;
end;

procedure TfrmFatManConsertoEquip.chkVenPreExit(Sender: TObject);
begin
  inherited;
  blnEntrouVenPre := False;
end;

procedure TfrmFatManConsertoEquip.cmbEntRetChange(Sender: TObject);
begin
  inherited;
  pHabilitaLocRet;
end;

procedure TfrmFatManConsertoEquip.cmbEquEntChange(Sender: TObject);
  Var
    blnConfirma: Boolean;
    strConEqu: String;

  procedure pMensagemItemEmUso(intIdx: Integer);
  begin
    if fCfgSis('ENTEQU', varString) = 'A' then
      fMensagem('ATENÇÃO', 'Equipamento selecionado está vinculado ao número máximo de O.S. possíveis e não poderá, portanto, ser vinculado na O.S. em edição!', ['&OK'])
    else
      fMensagem('ATENÇÃO', 'Equipamento selecionado está vinculado à O.S. ' + strConEqu + ', portanto, não poderá ser vinculado na O.S. em edição!', ['&OK']);
    cmbEquEnt.ItemIndex := intIdx;
  end;

  procedure pMensagemItemSaidaVinculada(intIdx: Integer);
  begin
    fMensagem('ATENÇÃO', 'Uma NF de saída já foi vinculada à O.S., portanto, ' +
      'para alterar o ' + #13#10 + 'equipamento da NF de entrada é preciso remover a NF ' +
      'de saída atual! ' + #13#10 + 'Obs.: Verifique a necessidade de cancelamento ' +
      'da nota de saída já vinculada.', ['&OK']);
    cmbEquEnt.ItemIndex := intIdx;
  end;
begin
  inherited;

  blnConfirma := False;

  If (objMeqMerEnt.intIdxIteSel <> -1) And (objMeqMerEnt.intIdxIteSel <> cmbEquEnt.ItemIndex) Then
  Begin
    If fMensagem('ALERTA', 'Deseja alterar o equipamento da NF-e de entrada de remessa de equipamento para conserto?', ['&Sim', '&Não']) = 1 Then
    Begin
      If (Assigned(objMeqMerSai)) And (Not fEmptyStr(objMeqMerSai.strAutGer)) Then
      Begin
        //valida se já existe uma nota de saída vinculada, se houver não deixa alterar o item
        pMensagemItemSaidaVinculada(objMeqMerEnt.intIdxIteSel);
      End
      Else If (TConEqu.fItemEquipNotaEntrEmUso(objMeqMerEnt.strAutDet, strConEqu)) Then
      Begin
        //validar se o item já não está em uso em outra OS
        pMensagemItemEmUso(objMeqMerEnt.intIdxIteSel);
      End
      Else
        blnConfirma := True;
    End
    Else
      cmbEquEnt.ItemIndex := objMeqMerEnt.intIdxIteSel;
  End
  Else If (objMeqMerEnt.intIdxIteSel = -1) And (cmbEquEnt.ItemIndex >= 0) Then
  Begin
    If (TConEqu.fItemEquipNotaEntrEmUso(objMeqMerEnt.arrItensEnt[cmbEquEnt.ItemIndex].strAutInc, strConEqu)) Then
    Begin
      pMensagemItemEmUso(-1);
    End
    Else
    Begin
      objMeqMerEnt.intIdxIteSel := cmbEquEnt.ItemIndex;
      objMeqMerEnt.strAutDet    := objMeqMerEnt.arrItensEnt[objMeqMerEnt.intIdxIteSel].strAutInc;
      objMeqMerEnt.strNCMEqu    := objMeqMerEnt.arrItensEnt[objMeqMerEnt.intIdxIteSel].strNcmIte;

      blnConfirma := True;
    End;
  End;

  If (blnConfirma) Then
  Begin
    //atualizar o registro de relacionamento da nota de entrada
    If (TConEqu.fAtualizarDadosVinculoNotaEntrada(objMeqMerEnt)) Then
      fMensagem('CONFIRMAÇÃO', 'Equipamento alterado com sucesso!', ['&OK']);
  End;
end;

procedure TfrmFatManConsertoEquip.cmbEquEntExit(Sender: TObject);
begin
  inherited;

  If (cmbEquEnt.ItemIndex = -1) Then cmbEquEnt.Text := '';
end;

procedure TfrmFatManConsertoEquip.cmbLocRetChange(Sender: TObject);
begin
  inherited;

  if cmbLocRet.Focused then
    fValidaCampos(cmbLocRet, True);
end;

function TfrmFatManConsertoEquip.fDigPrecoCusto: Double;
  Var
    frmFatDigPrecoCusto : TfrmFatDigPrecoCusto;
begin

  Result := 0.0;

  Try
    pCriarFormularios(TfrmFatDigPrecoCusto, frmFatDigPrecoCusto);

    While Not frmFatDigPrecoCusto.blnConfirma Do
    Begin

      If (btnAdicionar.Tag > 0) Then
        frmFatDigPrecoCusto.edtPreCus.Text := FloatToStrF(objConEqu.fltTotCus, ffFixed, 12, 4);

      frmFatDigPrecoCusto.showModal;

      If frmFatDigPrecoCusto.blnConfirma Then
        Result := fStrToFloat(frmFatDigPrecoCusto.edtPreCus.Text);

    End;

  Except
    On E: Exception Do
    Begin
      Result := 0.0;
      pMensagensErro(E.Message, '[TfrmFatManConsertoEquip.fDigPrecoCusto]');
    End;
  End;

  pFreeAndNil(frmFatDigPrecoCusto);

end;

function TfrmFatManConsertoEquip.fedtCodIteKeyPressGer(Sender: TObject;
  var Key: Char; strCodFab: String): Boolean;
  Var
    arrSel: TConsultasArray;
    objfrmPnl: TPanelCxItem;
    sltItensAntesPesquisa: TStringList;

    function fItemAddPorTabPelaPrimeiraVez: Boolean;
       Var
         strCodIte: String;
    begin
      strCodIte := QuotedStr(objConEqu.cdsIteEqu.FieldByName('CODITE').AsString);
      Result := (Not fEstaNaLista(sltItensAntesPesquisa, strCodIte)) And
                (fEstaNaLista(sltItems, strCodIte));
    end;

    Function fStrTituloConsulta: String;
    Begin
      Result := 'Consulta de Itens Semelhantes - Conserto de Equipamentos.';
    end;

begin
  Result := false;

  If (fEntraCons(Key))                                                       And
     (Not edtCodIte.ReadOnly)                                                And
     ( (fEmptyStr(edtCodIte.Text)) or (edtCodIte.SelText = edtCodIte.Text) ) Then
  Begin

    Try
      sltItensAntesPesquisa      := TStringList.Create;
      sltItensAntesPesquisa.Text := sltItems.Text;

      objfrmPnl := fInicializarObjFrmPnlItem();

      If fPesqItem(conIteSemelhantes,
                   Self,
                   edtCodIte,
                   edtDesIte,
                   qryCadIte,
                   Key,
                   arrSel,
                   True,
                   objfrmPnl,
                   fStrTituloConsulta,
                   IIF(cbTabPreco.Visible, cbTabPreco.Text, ''),
                   '',
                   0,
                   False,
                   False,
                   -1,  // SEGUE A CONFIGURAÇÃO DE ATIVOS
                   cdrCodIte,
                   '',
                   False,
                   '',
                   '',
                   True,
                   False,
                   True,
                   '',
                   False,
                   False,
                   False,
                   False,
                   False,
                   False,
                   False,
                   False,
                   '',
                   -1,
                   True,
                   strCodFab) Then
      Begin
        If fItemAddPorTabPelaPrimeiraVez Then
        Begin
          btnCancelaItem.Click;
        End
        Else
        Begin
          If (rdbCodIte.Checked) Or (fEmptyStr(qryCadIte.FieldByName('ITE_CODFAB').AsString)) Or
             (Not fEmptyStr(strCodFab)) Then
          Begin
            edtCodIte.Text := qryCadIte.FieldByName('ITE_CODITE').AsString;
            blnBuscarCodFab := False;
          End
          Else
            edtCodIte.Text := qryCadIte.FieldByName('ITE_CODFAB').AsString;

          pCarregaItem(True, True);
          If fEmptyStr(strCodFab) Then
            SelectNext(ActiveControl, True, True);
        End;
      End
      Else
      Begin
        btnCancelaItem.Click;
      End;
    Finally
      FreeAndNil(objfrmPnl);
      FreeAndNil(sltItensAntesPesquisa);
    End;
  End;
end;

function TfrmFatManConsertoEquip.fInserirAcessorio(cdsConsulta: TUniClientDataSet;
  DropControl: TControl; RectLinhaGrid: TRect): Boolean;
begin
  Try
    Result := False;

    Try
      If cdsConsulta.IsEmpty Then
        Exit;

      cdsConsultaAce := cdsConsulta;
      edtCodAce.Text := cdsConsulta.FieldByName('ACE_CODACE').AsString;

      If objConEqu.cdsAceEqu.Locate('CODACE', edtCodAce.Text, []) Then
        pCarregarAcessorio();

      If fValidaCampos(edtCodAce, True) Then
      Begin
        SelectNext(ActiveControl, True, True);

        pCriarFormularios(TfrmFatVendaItem, frmFatVendaItem);
        pnlAcessorios.Parent     := frmFatVendaItem;
        pnlAcessorios.BevelOuter := bvNone;
        frmFatVendaItem.fValidaCamposVenda := fValidaCampos;
        frmFatVendaItem.Caption := 'Complete as informações do Acessório';

        frmFatVendaItem.Width        := pnlAcessorios.Width;
        frmFatVendaItem.ClientHeight := pnlAcessorios.Height + frmFatVendaItem.pnlStatus.Height;

        edtCodAce.ReadOnly := True;
        edtCodAce.TabStop  := False;

        If (Not edtCodAce.Enabled) Then
          frmFatVendaItem.OnKeyDown := pExcluirKeyDown;

        frmFatVendaItem.ShowModal;

        pnlAcessorios.BevelOuter := bvRaised;

        edtCodAce.ReadOnly := False;
        edtCodAce.TabStop  := True;

        edtCodAce.Enabled := True;
        edtDesAce.Enabled := True;
        edtQtdAce.Enabled := True;
        btnCancelaAce.Enabled   := True;
        btnAdicionarAce.Enabled := True;

        pnlAcessorios.Parent := tbsAcessorios;
        btnCancelaAce.Click();
        pFreeAndNil(frmFatVendaItem);

        Result := True;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmFatManConsertoEquip.fInserirAcessorio]');
      End;
    End;
  Finally
    If cdsConsultaAce <> Nil Then
      cdsConsultaAce := Nil;
  End;
end;

function TfrmFatManConsertoEquip.fInserirDefeito(cdsConsulta: TUniClientDataSet;
  DropControl: TControl; RectLinhaGrid: TRect): Boolean;
begin
  Try
    Result := False;

    Try
      If cdsConsulta.IsEmpty Then
        Exit;

      cdsConsultaDfe := cdsConsulta;
      edtCodDfe.Text := cdsConsulta.FieldByName('DFE_CODIGO').AsString;

      If objConEqu.cdsDfeEqu.Locate('CODDFE', edtCodDfe.Text, []) Then
        pCarregarDefeito();

      If fValidaCampos(edtCodDfe, True) Then
      Begin
        SelectNext(ActiveControl, True, True);

        pCriarFormularios(TfrmFatVendaItem, frmFatVendaItem);
        pnlDefeitos.Parent     := frmFatVendaItem;
        pnlDefeitos.BevelOuter := bvNone;
        frmFatVendaItem.fValidaCamposVenda := fValidaCampos;
        frmFatVendaItem.Caption := 'Complete as informações do defeito';

        frmFatVendaItem.Width        := pnlDefeitos.Width;
        frmFatVendaItem.ClientHeight := pnlDefeitos.Height + frmFatVendaItem.pnlStatus.Height;

        edtCodDfe.ReadOnly := True;
        edtCodDfe.TabStop  := False;

        If (Not edtCodDfe.Enabled) Then
          frmFatVendaItem.OnKeyDown := pExcluirKeyDown;

        frmFatVendaItem.ShowModal;

        pnlDefeitos.BevelOuter := bvRaised;

        edtCodDfe.ReadOnly := False;
        edtCodDfe.TabStop  := True;

        edtCodDfe.Enabled := True;
        edtDesDfe.Enabled := True;
        btnCancelaDfe.Enabled   := True;
        btnAdicionarDfe.Enabled := True;

        pnlDefeitos.Parent := tbsDefeitos;
        btnCancelaDfe.Click();
        pFreeAndNil(frmFatVendaItem);

        Result := True;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmFatManConsertoEquip.fInserirDefeito]');
      End;
    End;
  Finally
    If cdsConsultaDfe <> Nil Then
      cdsConsultaDfe := Nil;
  End;
end;

function TfrmFatManConsertoEquip.fInserirServico(cdsConsulta: TUniClientDataSet;
  DropControl: TControl; RectLinhaGrid: TRect): Boolean;
begin
  Try
    Result := False;

    Try
      If cdsConsulta.IsEmpty Then
        Exit;

      cdsConsultaServ := cdsConsulta;
      edtCodSe1.Text  := cdsConsulta.FieldByName('SER_CODSER').AsString;

      If objConEqu.cdsSerEqu.Locate('CODSER', edtCodSe1.Text, []) Then
      Begin
        pAlterarServico();
        pAtualizaTotais;
      End;

      If fValidaCampos(edtCodSe1, True) Then
      Begin
        SelectNext(ActiveControl, True, True);

        pCriarFormularios(TfrmFatVendaItem, frmFatVendaItem);
        pnlServicos.Parent     := frmFatVendaItem;
        pnlServicos.BevelOuter := bvNone;
        frmFatVendaItem.fValidaCamposVenda := fValidaCampos;
        frmFatVendaItem.Caption := 'Complete as informações do serviço';

        frmFatVendaItem.Width        := pnlServicos.Width;
        frmFatVendaItem.ClientHeight := pnlServicos.Height + frmFatVendaItem.pnlStatus.Height;
        
        edtCodSe1.ReadOnly := True;
        edtCodSe1.TabStop  := False;

        If (Not edtCodSe1.Enabled) Then
          frmFatVendaItem.OnKeyDown := pExcluirKeyDown;

        frmFatVendaItem.ShowModal;

        pnlServicos.BevelOuter := bvRaised;

        edtCodSe1.ReadOnly := False;
        edtCodSe1.TabStop  := True;

        pnlServicos.Parent := tbsServicos;
        btnCancelaSe1.Click();
        pFreeAndNil(frmFatVendaItem);

        Result := True;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmFatManConsertoEquip.fInserirServico]');
      End;
    End;
  Finally
    If cdsConsultaServ <> Nil Then
      cdsConsultaServ := Nil;
  End;
end;

function TfrmFatManConsertoEquip.fInformarLocFisicaEquipamento: String;
var
  LInfoLocFis: TfrmInformarLocFisConsertoEquip;
begin
  pCriarFormularios(TfrmInformarLocFisConsertoEquip, LInfoLocFis);

  try
    LInfoLocFis.ShowModal;

    Result := LInfoLocFis.strLocFis;
  finally
    pFreeAndNil(LInfoLocFis);
  end;
end;

function TfrmFatManConsertoEquip.fMostraItensSimilares(
  strCodIte: String): Boolean;
Var
  blnEnterSim : Boolean;
  strCodIteSim: String;
  strCodSim: String;
  strDesIte: String;
  strAutInc: String;
  strCodFab: String;
  qryGen: TUniQuery;

Begin
  Result := False;

  Try
    qryGen := fCriaQuery(Self);

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT ITE_CODSIM, ITE_CODITE, ITE_DESITE ');
      SQL.Add(' FROM CADITE ');
      SQL.Add(' WHERE ITE_CODITE = :CODITE ');
      ParamByName('CODITE').AsString := strCodIte;
      Open;

      strCodSim := fieldbyname('ITE_CODSIM').AsString;
      strDesIte := fieldbyname('ITE_DESITE').AsString;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

  If Not fEmptyStr(strCodSim) Then
  Begin
    TfrmFatMostraProdSimilar.fMostraSimilar(strCodSim,
                                            strCodIte,
                                            strDesIte,
                                            cbTabPreco.Text,
                                            blnEnterSim,
                                            strAutInc,
                                            strCodFab,
                                            strCodIteSim,
                                            False,
                                            False,
                                            True);

    If blnEnterSim Then
    Begin
      Result := True;
      edtCodIte.Text := strCodIteSim;
    End;

  End;

end;

function TfrmFatManConsertoEquip.fNovaOSFluxo: Boolean;
begin
  Result := False;

  if (not blnFluxoProcesso) then
    Exit;

  if (strFlxNovaCancelar <> 'N') then
    Exit;

  Result := True;
end;

procedure TfrmFatManConsertoEquip.edtUnidadKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqUnidade(Self, edtUnidad, nil, nil, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtUnidad, True) Then
    Begin
      objConEqu.strUnidad := edtUnidad.Text;
      Self.SelectNext(ActiveControl, True, True);
    End;
  End;

end;

procedure TfrmFatManConsertoEquip.pClienteRespGarantia;
begin
  //não estrou com try/except pois a função chamadora já faz.
  pCriarFormularios(TfrmDigCliente, frmDigCliente);
  frmDigCliente.strCodCli := objConEqu.strCliGar;

  If frmDigCliente.ShowModal = mrOk Then
    objConEqu.strCliGar := frmDigCliente.edtCodCli.Text;

  pFreeAndNil(frmDigCliente);
end;

procedure TfrmFatManConsertoEquip.pClonaDadosNF(objClone: TMeqMer);
begin
  If objClone.strTipOpe = 'E' Then
  Begin
    objMeqMerEnt.strAutGer := objClone.strAutGer;
    objMeqMerEnt.strNumDoc := objClone.strNumDoc;
    objMeqMerEnt.strEspDoc := objClone.strEspDoc;
    objMeqMerEnt.strSerie_ := objClone.strSerie_;
    objMeqMerEnt.strCodCli := objClone.strCodCli;
    objMeqMerEnt.strEmpGer := objClone.strEmpGer;
    objMeqMerEnt.strTipOpe := objClone.strTipOpe;
    objMeqMerEnt.dtaDtaGer := objClone.dtaDtaGer;
    objMeqMerEnt.strChaveAcesso := objClone.strChaveAcesso;
  End
  Else
  Begin
    objMeqMerSai.strAutGer := objClone.strAutGer;
    objMeqMerSai.strNumDoc := objClone.strNumDoc;
    objMeqMerSai.strEspDoc := objClone.strEspDoc;
    objMeqMerSai.strSerie_ := objClone.strSerie_;
    objMeqMerSai.strCodCli := objClone.strCodCli;
    objMeqMerSai.strEmpGer := objClone.strEmpGer;
    objMeqMerSai.strTipOpe := objClone.strTipOpe;
    objMeqMerSai.dtaDtaGer := objClone.dtaDtaGer;
    objMeqMerSai.strChaveAcesso := objClone.strChaveAcesso;
  End;
end;

procedure TfrmFatManConsertoEquip.FormPaint(Sender: TObject);
begin
  inherited;
  If blnFecharForm Then
    Close;
end;

procedure TfrmFatManConsertoEquip.FormResize(Sender: TObject);
begin
  inherited;
  pAjustaAlturaPanelBotoes;
end;

procedure TfrmFatManConsertoEquip.pSaidaNF;
var
  LCarregarTodosItens: Boolean;
begin
  LCarregarTodosItens := fCarregarTodosItensNotaSaida;

  Try
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Acesso ao módulo Outras Saídas');

    objLiberacao.strDirAce := 'OUTSA';
    objLiberacao.strSenLib := fCfgSis('SENNFO');
    objLiberacao.strMsgSen := 'Outras Saídas';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    If (Not objLiberacao.fLibera) Then
      Exit;

    pCriarFormularios(TfrmFatVendas, frmFatVendas);

    If Not frmFatVendas.blnFecharForm Then
    Begin
      frmFatVendas.strOpcDoc       := 'OU';
      frmFatVendas.strTitulo       := 'Outras Saídas';
      frmFatVendas.blnApenasPrazo  := False;
      frmFatVendas.blnApenasVista  := False;
      frmFatVendas.blnDevBaiEntFut := False;
      frmFatVendas.blnConEqu       := True;
      frmFatVendas.strCodCliDef    := edtCodCli.Text;
      frmFatVendas.edtCodCli.Text  := edtCodCli.Text;
      frmFatVendas.strNumSerie     := edtNSerie.Text;
      frmFatVendas.blnCarTodosItensNotaSaida := LCarregarTodosItens;
      
      If (Assigned(objMeqMerEnt)) Then
      begin
        frmFatVendas.strAutincIteRemessa := objMeqMerEnt.strAutDet;

        if LCarregarTodosItens then
          frmFatVendas.strAutincGerRemessa := objMeqMerEnt.strAutGer;
      end;

      frmFatVendas.ShowModal;

      If frmFatVendas.blnConfirma Then
      Begin
        If Not Assigned(objMeqMerSai) Then
          objMeqMerSai := TMeqMer.Create;

        pClonaDadosNF(frmFatVendas.objMeqMer);
        objMeqMerSai.strAutEqu := objConEqu.strAutInc;
        objMeqMerSai.strEmpEqu := objConEqu.strCodEmp;
        objMeqMerSai.strNumOse := objConEqu.strNumero;

        If objConEqu.strOperac = 'A' Then
          TConEqu.fVinculaOSemNotaFiscal(objMeqMerSai);

        pCarregaDadosNFEntSai;
      End;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmFatManConsertoEquip.pSaidaNF]');
  End;

  pFreeAndNil(frmFatVendas);
  Application.ProcessMessages;
end;

procedure TfrmFatManConsertoEquip.pSetarEmpresaItem(strCodEmp: String);
begin
  objEmitirPedido.objFatVenda.pCarregaCfgSis;
  objEmitirPedido.objFatVenda.pAtualizaClassTransferencias;
end;

procedure TfrmFatManConsertoEquip.pSetaTabelaPreco(strTabPre: String);
begin
  cbTabPreco.ItemIndex := cbTabPreco.Items.IndexOf(IIF(fEmptyStr(strTabPre),'1',strTabPre));
  If cbTabPreco.ItemIndex = -1 Then
    cbTabPreco.ItemIndex := 0;

  cbTabPrecoItem.ItemIndex := cbTabPreco.ItemIndex;
end;

procedure TfrmFatManConsertoEquip.pShowFluxoProcesso;
var
  strTpLayout: String;
  blnOK,
  blnCarregouOS: Boolean;
  intIntMan,
  intIntOrc: Integer;
begin
  edtNumeroExit(Nil);

  if strFlxNovaCancelar = 'N' then
  begin
    if edtProtoc.Visible then
      pSetFocus(edtProtoc)
    else
      pSetFocus(edtCodCli);

    btnConfirmarVarias.Visible := fCfgSis('FXMUOS', varBoolean);
  end
  else if strFlxNovaCancelar = 'C' then
  begin
    if (edtCodEmp.Visible) then
      blnCarregouOS := fValidaCampos(edtCodEmp, True)
    else
      blnCarregouOS := fValidaCampos(edtNumero, True);

    if (blnCarregouOS) then
      btnCancelar.Click;

    PostMessage(Self.Handle, WM_CLOSE, 0, 0);
  end
  else
  begin
    if (edtCodEmp.Visible) then
      blnCarregouOS := fValidaCampos(edtCodEmp, True)
    else
      blnCarregouOS := fValidaCampos(edtNumero, True);

    if (not blnCarregouOS) then
    begin
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      Exit;
    end;

    case tpProcessoFlx of
      tprDadosOS:
        begin
          pHabilitarEdicaoCamposRealizadaReprovada;
          case tpImpressaoFlx of
            fpImprimir: pImprimirFluxo;
            fpEtiqueta: btnImpEti.Click;
            fpTermoDev: btnTermoDev.Click;
            fpTermoResp:
              begin
                blnOK := False;
                pImprimirTermoResponsabilidade(1, tpaNormal, strTpLayout, blnOK);

                if (not blnOK) and (not fEmptyStr(strTpLayout)) then
                  pMensagemOk('Layout ' + strTpLayout + ' não está configurado.');
              end;
            fpOrdExecucao: pImprimirOrdemExecucao(1, tpaNormal);
          end;

          btnAltCondPagto.Visible := (not blnOSCancelada) and (tpImpressaoFlx = fpEditar);
          btnAltCondPagto.Enabled := fVerificaAcessoSistema('FXALCP', strLoginUsuarioLogado);
          btnConfirmar.Visible    := (not blnOSCancelada) and ((tpImpressaoFlx = fpEditar) or (edtNOSFab.Visible));
        end;
      tprDocsFiscais:
        begin
          case tpDocsFiscaisFlx of
            tpEntrada: grbDocSaida.Visible := False;
            tpSaida: grbDocEntrada.Visible := False;
          end;
         if objConEqu.strStatus <> 'E' then
           btnAlteracao.Click;
        end;
      tprDefPrdSer:
        begin
         if objConEqu.strStatus <> 'E' then
           btnAlteracao.Click;
        end;
      tprEnviarCliente: pImprimirFluxo;
      tprInterromperOrc:
        begin
          if (fMensagem('', 'Deseja interromper o orçamento?', ['&Sim', '&Não']) = 1) then
          begin
            intIntOrc := fGetMenu('Selecione a etapa', ['Realizar Análise Técnica', 'Realizar Orçamento'], 1);

            case intIntOrc of
              1:
                begin
                  objConEqu.strFlxFas := 'T';
                  objConEqu.strFlxSit := 'OA';
                  objConEqu.strFlxCom := 'OI';

                  if (fCfgSis('CTRPEN', varInteger) = 2) then
                    objConEqu.dtaEntreg := 0;
                end;
              2:
                begin
                  objConEqu.strFlxFas := 'T';
                  objConEqu.strFlxSit := 'TC';
                  objConEqu.strFlxCom := 'AO';
                end;
            end;

            objConEqu.pAlteraStatusDados('E', 'O', '', True, '', '', '', '', 0, '', True);
            objConEqu.pGravarLogFlx(blnFLuxoProcesso);
          end;
        end;
      tprAprovar: btnAprovada.Click;
      tprReprovar: btnReprovar.Click;
      tprCancelarRep: btnReativar.Click;
      tprInterromperMan:
        begin
          if (fMensagem('', 'Deseja interromper a manutenção?', ['&Sim', '&Não']) = 1) then
          begin
            intIntMan := fGetMenu('Selecione a etapa', ['Realizar Análise Técnica', 'Realizar Orçamento', 'Aprovar'], 1);

            objConEqu.strTipApr := '';

            case intIntMan of
              1:
                begin
                  objConEqu.strFlxFas := 'T';
                  objConEqu.strFlxSit := 'OA';
                  objConEqu.strFlxCom := 'MI';

                  if (fCfgSis('CTRPEN', varInteger) = 2) then
                    objConEqu.dtaEntreg := 0;

                  pBaixaOcorrenciasCRM;
                  objConEqu.pAlteraStatusDados('E', 'O', '', True, '', '', '', '', 0, '', True);
                end;
              2:
                begin
                  objConEqu.strFlxFas := 'T';
                  objConEqu.strFlxSit := 'TC';
                  objConEqu.strFlxCom := 'AO';

                  pBaixaOcorrenciasCRM;
                  objConEqu.pAlteraStatusDados('E', 'O', '', True, '', '', '', '', 0, '', True);
                end;
              3: pAlteraStatusAprovadaParaOrcamento;
            end;

            objConEqu.pGravarLogFlx(blnFLuxoProcesso);
            pExcluirReqCompra;
          end;
        end;
      tprRealizarMan: btnAltTecServicos.Visible := objConEqu.cdsSerEqu.RecordCount > 0;
      tprManutencao: btnRealizada.Click;
      tprCancelarMan:
        begin
          if (fMensagem('', 'Deseja cancelar a manutenção?', ['&Sim', '&Não']) = 1) then
          begin
            objConEqu.strOperac := 'A';
            objConEqu.dtaFinMan := 0;
            objConEqu.strFlxFas := 'M';
            objConEqu.strFlxSit := fSituacaoCancelarManutencao;
            objConEqu.strFlxCom := 'AM';

            objConEqu.pAlteraStatusDados('A', '', '', False, '', '', '', '', 0, '', False, True);
            objConEqu.pGravarLogFlx(blnFluxoProcesso);
          end;
        end;
      tprApontamento: btnApontHoras.Click;
      tprArmazenar: btnRealizada.Click;
      tprCancelarArm:
        begin
          if (fMensagem('', 'Deseja cancelar o armazenamento?', ['&Sim', '&Não']) = 1) then
          begin
            objConEqu.strLocFisEqu := '';
            objConEqu.dtaDtaArm := 0;
            objConEqu.dtaDtTxAr := 0;

            if (objConEqu.strFlxSit = 'ON') or (objConEqu.strFlxSit = 'OB') then
            begin
              objConEqu.strFlxCom := 'AA';
              objConEqu.pAlteraStatusDados('N', '');
            end
            else if objConEqu.strFlxSit = 'FA' then
            begin
              objConEqu.strFlxCom := 'AA';
              objConEqu.pAlteraStatusDados('R', 'C');
            end
            else
            begin
              objConEqu.strFlxSit := 'MF';
              objConEqu.strFlxCom := 'AA';
              objConEqu.pAlteraStatusDados('M', 'C');
            end;

            objConEqu.pGravarLogFlx(blnFluxoProcesso);
          end;
        end;
      tprRetirar: btnDevCli.Click;
      tprBaixarOSDes:
        begin
          if (fMensagem('', 'Esta operação irá baixar a ordem de serviço por desistência do cliente. Confirma esta operação?', ['&Sim', '&Não']) = 1) then
          begin
            objConEqu.strFlxFas := 'R';
            objConEqu.strFlxSit := 'OB';
            objConEqu.strFlxCom := 'AA';
            objConEqu.pAlteraStatusDados('N', '');

            objConEqu.pGravarLogFlx(blnFLuxoProcesso);
          end;
        end;
      tprCancEntregaEquip: pCancelaEntregaEquip;
      tprComunicacoesInternas: btnComunicacaoInterna.Click;
    end;

    if (not (tpProcessoFlx in [tprDocsFiscais, tprDefPrdSer, tprOrcamento, tprRealizarMan])) then
    begin
      if (tpProcessoFlx = tprDadosOS) and (tpImpressaoFlx in [fpConsultar, fpEditar]) then
         Exit;
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
    end
    else if (not fEhEtapaOrcamento) then
      pHabilitarEdicaoCamposRealizadaReprovada;
  end;
end;

procedure TfrmFatManConsertoEquip.pShowNegociacao;
var
  blnCarregouOS: Boolean;
begin
  edtNumeroExit(Nil);

  if (edtCodEmp.Visible) then
    blnCarregouOS := fValidaCampos(edtCodEmp, True)
  else
    blnCarregouOS := fValidaCampos(edtNumero, True);

  if (not blnCarregouOS) then
  begin
    PostMessage(Self.Handle, WM_CLOSE, 0, 0);
    Exit;
  end;

  objConEqu.blnNegociacao := True;
  objConEqu.cdsDocGerNeg  := FcdsDocGerNeg;
  objConEqu.objFatVendaImpNeg := objFatVendaImpNeg;

  btnAprovada.Click;
  PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmFatManConsertoEquip.pSolicitaEquipamentoNFEntrada;
begin
  if (objMeqMerEnt.intIdxIteSel >= 0) then
    Exit;

  pMensagemOk('Informe o equipamento em manutenção relacionado a NF de entrada!');
  pgcTabs.ActivePage := tbsDocsRelacionados;
  cmbEquEnt.DroppedDown := True;
end;

function TfrmFatManConsertoEquip.fOSFoiReprovadaAgMontagem: Boolean;
begin
  Result := (fCfgSis('EQUREP', varBoolean)) And
            (fCampoTabela('IF(COUNT(*) > 0, "SIM", "NAO")',
                          'LOGSTA',
                          ['LOG_NUMOSE', 'LOG_CODEMP', 'LOG_STAANT'],
                          [objConEqu.strNumero, objConEqu.strCodEmp, 'NM']) = 'SIM');
end;

function TfrmFatManConsertoEquip.fPedeEnderecoEntrega: Boolean;
begin
  Result := True;
  
  if (Not fClienteConsumidor(fRetNomCliente(edtCodCli.Text), True, True)) And
     ((fInclusaoOrdemServico) or (edtCodCli.Text <> objConEqu.strCodCliAnt)) Then
  Begin
    pOSToEndereco;
    Result := objEndEnt.fAlteraEnderecoEntrega(False, objConEqu.strCodCli, True, True, False, True, btnConfirmar.Enabled);
    pEnderecoToOS;
  End;
end;

function TfrmFatManConsertoEquip.fPerguntaOrcamentoRealizado: Boolean;
begin
  Result := True;

  if (not blnFluxoProcesso) then
    Exit;

  if (not (tpProcessoFlx in [tprDadosOS, tprDocsFiscais, tprRealizarMan])) then
    Exit;

  Result := False;
end;

function TfrmFatManConsertoEquip.fPermiteEditarGarantia: Boolean;
begin
  Result := False;

  if (not blnFluxoProcesso) then
    Exit;

  if (objConEqu.strStatus <> 'E') and (objConEqu.strStatus <> 'F') then
    Exit;

  Result := True;
end;

function TfrmFatManConsertoEquip.fPermiteGerarExcel: Boolean;
begin
  Result := True;

  if (fVerificaAcessoSistema('OSGEXC')) then
    Exit;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Permitir gerar Excel da Ordem de Serviço');
  objLiberacao.objMsgLibera.pAddSeparador(50);
  objLiberacao.objMsgLibera.pAddTextoCaption('Ordem de Serviço', objConEqu.strNumero + '-' + objConEqu.strCodEmp, 16);

  objLiberacao.strDirAce := 'OSGEXC';
  objLiberacao.strMsgSen := 'Permitir gerar Excel da Ordem de Serviço';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCliente := edtCodCli.Text + '-' + edtNomCli.Text;
  objLiberacao.strCpfCnpj := objConEqu.strCliCgc;

  Result := objLiberacao.fLibera;
end;

function TfrmFatManConsertoEquip.fPermiteHabilitarDocsFiscaisRef: boolean;
begin
  Result := True;

  if (not blnFluxoProcesso) then
    Exit;

  if (not fEhFluxoDadosOS) then
    Exit;

  Result := False
end;

procedure TfrmFatManConsertoEquip.pPodeAlterarDigitador;
  Var
    blnConfirma: Boolean;
Begin
  blnConfirma := False;


  if (InformarNFEntSaiAlterarObsOSRealizadaReprovada) or ((objConEqu.strStatus <> 'N') and (not objConEqu.fPedidoJaFaturado())) then
  begin
    If (fCfgSis('EQUFVU') = 'V') Then
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('A T E N C A O - Alteração de Digitador de O.S. que não esteja em aberto.');
      objLiberacao.objMsgLibera.pAddTexto('                Somente mediante uma confirmação de senha...');

      objLiberacao.strDirAce := 'OSALDG';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strMsgSen := 'Alteração de Digitador de O.S. em Manutenção de Equipamentos';
      objLiberacao.strCliente := edtCodCli.Text;
      objLiberacao.strSenFvu := fCfgSis('EQUFVU');

      If objLiberacao.fLibera Then
      Begin
        blnConfirma := True;
      End;

    End
    Else
    Begin

      If Not objConEqu.fVerificaAcessoSistemaOS('OSALDG', 'Liberado direito de acesso à alteração de digitador de O.S.!', '') Then
      Begin
        fMensagem('', 'Operador não tem direito de acesso à alteração do digitador de O.S.. Sendo assim, o campo ficará desabilitado e não poderá ser alterado!', ['&O k']);
        blnConfirma := False;
      End
      Else
      Begin
        blnConfirma := True;
      End;

    End;
  end;
  objConEqu.blnPermiteAltDig := blnConfirma;
End;

procedure TfrmFatManConsertoEquip.pPodeAlterarTecnico;
  var
    blnConfirma: Boolean;
Begin
  blnConfirma := False;

  if (InformarNFEntSaiAlterarObsOSRealizadaReprovada) or ((objConEqu.strStatus <> 'N') and (not objConEqu.fPedidoJaFaturado())) then
  begin
    If (fCfgSis('EQUFVU') = 'V') Then
    Begin

      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('A T E N C A O - Alteração de Técnico de O.S. que não esteja em aberto.');
      objLiberacao.objMsgLibera.pAddTexto('                Somente mediante uma confirmação de senha...');

      objLiberacao.strDirAce := 'OSALTC';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strMsgSen := 'Alteração de Técnico de O.S. em Manutenção de Equipamentos';
      objLiberacao.strCliente := edtCodCli.Text;
      objLiberacao.strSenFvu := fCfgSis('EQUFVU');

      If objLiberacao.fLibera Then
      Begin
        blnConfirma := True;
      End;

    End
    Else
    Begin

      If Not objConEqu.fVerificaAcessoSistemaOS('OSALTC', 'Liberado direito de acesso à alteração de técnico de O.S.!', '') Then
      Begin
        fMensagem('', 'Operador não tem direito de acesso à alteração do técnico de O.S.. Sendo assim, o campo ficará desabilitado e não poderá ser alterado!', ['&O k']);
        blnConfirma := False;
      End
      Else
      Begin
        blnConfirma := True;
      End;

    End;
  end;
  objConEqu.blnPermiteAltTec := blnConfirma;
End;

Function TfrmFatManConsertoEquip.fPodeAlterarOS: Boolean;
var
  qryMovRcd: TUniQuery;
Begin
  Result := False;

  If (fCfgSis('EQUFVU') = 'V') Then
  Begin

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('A T E N C A O - Alteração de O.S. que não esteja em aberto.');
    objLiberacao.objMsgLibera.pAddTexto('                Somente mediante uma confirmação de senha...');

    objLiberacao.strDirAce := 'ALTMEQ';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strMsgSen := 'Alteração de O.S. em Manutenção de Equipamentos';
    objLiberacao.strCliente := edtCodCli.Text;
    objLiberacao.strSenFvu := fCfgSis('EQUFVU');

    If objLiberacao.fLibera Then
    Begin
      Result := True;
    End;

    pCarregarListasConsulta();
  End
  Else
  Begin

    If Not objConEqu.fVerificaAcessoSistemaOS('ALTMEQ', 'Liberado direito de acesso à alteração de O.S.!', '') Then
    Begin
      fMensagem('', 'Operador não tem direito de acesso à alteração de O.S.!', ['&O k']);
      Result := False;
    End
    Else
      Result := True;
  End;

  if Result and fRequisicaoCompraVinculada then
  begin

    qryMovRcd := fCriaQuery(Self);
    Try
      qryMovRcd.SQL.Clear;
      qryMovRcd.SQL.Add(' SELECT RCD_CODITE, RCD_DESITE, RCD_QTDITE ');
      qryMovRcd.SQL.Add('   FROM MOVRCD ');
      qryMovRcd.SQL.Add('  INNER JOIN MOVRCG ON RCD_CODIGO = RCG_CODIGO');
      qryMovRcd.SQL.Add('  WHERE MOVRCG.AUTOINCREM = :AUTOINCREM ');
      qryMovRcd.SQL.Add('    AND RCD_REQNEG <> "S"    ');
      qryMovRcd.ParamByName('AUTOINCREM').AsString := qryFatgor.FieldByName('FGO_INRQCP').AsString;
      qryMovRcd.Open;

      if not qryMovRcd.IsEmpty then
      begin
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddTexto('<<<  PEDIDO DE VENDA COM REQUISIÇÃO DE COMPRA VINCULADA  >>>', alCentro, teAutcom, '', 109);
        objLiberacao.objMsgLibera.pAddSeparador(109);
        objLiberacao.objMsgLibera.pAddTextoCaption('Pedido'     ,  qryFatGor.FieldByName('FGO_NUMDOC').AsString + '-' +
                                                                   qryFatGor.FieldByName('FGO_ESPDOC').AsString + '-' +
                                                                   qryFatGor.FieldByName('FGO_CODEMP').AsString                                                                         , 11);

        objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'   ,   qryFatGor.FieldByName('FGO_CODCLI').AsString + '-' +
                                                                   fRetNomCliente(qryFatGor.FieldByName('FGO_CODCLI').AsString)                                                         , 11);

        objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor'   ,  qryFatGor.FieldByName('FGO_CODVEN').AsString + '-' + fRetNomeOperador(qryFatGor.FieldByName('FGO_CODVEN').AsString)  , 11);

        objLiberacao.objMsgLibera.pAddTextoCaption('Cond.Pagto' ,  fFormataCondPag(qryFatGor.FieldByName('FGO_CONPAG').AsString)                                                        , 11);

        objLiberacao.objMsgLibera.pAddTextoCaption('Forma Pagto',  qryFatGor.FieldByName('FGO_CODFPG').AsString + '-' + fRetDescFpg(qryFatGor.FieldByName('FGO_CODFPG').AsString)       , 11);

        objLiberacao.objMsgLibera.pAddSeparador(109);
        objLiberacao.objMsgLibera.pAddTexto('** Ao liberar essa trava a requisição será gerada novamente com base no estoque atual dos itens desse pedido!');
        objLiberacao.objMsgLibera.pAddSeparador(109);

        qryMovRcd.First;
        While Not qryMovRcd.Eof Do
        Begin
          objLiberacao.objMsgLibera.pAddTexto('Produto: ' + qryMovRcd.FieldByName('RCD_CODITE').AsString + '-' + qryMovRcd.FieldByName('RCD_DESITE').AsString);
          objLiberacao.objMsgLibera.pAddTexto('Quantidade da Requisição: ' + FormatFloat('#,##0.00', qryMovRcd.FieldByName('RCD_QTDITE').AsFloat));
          objLiberacao.objMsgLibera.pAddSeparador(109);

          qryMovRcd.Next;
        End;
        qryMovRcd.Close;

        objLiberacao.strDirAce := 'SLRQPV';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.blnSempreVariavelUsuario := True;
        objLiberacao.pInformaNumDocEspDocCodEmp(qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                                qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                                qryFatGor.FieldByName('FGO_CODEMP').AsString);
        Result := objLiberacao.fLibera;
      end;
    finally
      FreeAndNil(qryMovRcd);
    end;
  end;
End;

function TfrmFatManConsertoEquip.fPodeMarcarAgMontagemSemSaldo: Boolean;
var
  fltSaldo,
  fltSaldoIte,
  fltSalResTot: Double;
  objTabela: TRegistroMsgLiberaTabela;
  objLinha : TLinhaMsgLibera;
begin
  Result := False;

  if (not fCfgSis('OSAMSD', varBoolean)) then
  begin
    pAvisoAgMontagemSemSaldo;
    Exit;
  end;

  objConEqu.cdsIteEqu.First;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Permitir marcar O.S. como AGUARDANDO MONTAGEM que tenha Produtos sem Saldo Disponível:');
  objLiberacao.objMsgLibera.pAddTextoCaption('Ordem de Serviço', objConEqu.strNumero + '-' + objConEqu.strCodEmp                , 16);
  objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'         , objConEqu.strCodCli + '-' + fRetNomCliente(objConEqu.strCodCli), 16);
  objLiberacao.objMsgLibera.pAddQuebra;

  objTabela := TRegistroMsgLiberaTabela.Create;
  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna('', 'ITEM'       , fTamCodIte, alEsquerda, teAutcom);
  objLinha.pAddColuna('', 'DESCRIÇÃO'  , 50, alEsquerda, teAutcom);
  objLinha.pAddColuna('', 'QTDE'       , 10, alDireita , teAutcom);
  objLinha.pAddColuna('', 'SALDO'      , 10, alDireita , teAutcom);
  objLinha.pAddColuna('', 'SALDO DISP.', 10, alDireita , teAutcom);
  objTabela.lstLinhas.Add(objLinha);

  while not objConEqu.cdsIteEqu.Eof do
  begin
    fltSaldo := objConEqu.fRetornaSaldoDisponivel(objConEqu.cdsIteEqu.FieldByName('CODITE').AsString,
                                                  objConEqu.cdsIteEqu.FieldByName('EMPITE').AsString,
                                                  fltSaldoIte,
                                                  fltSalResTot);

    if (fltSaldo >= objConEqu.cdsIteEqu.FieldByName('QTDITE').AsFloat) then
    begin
      objConEqu.cdsIteEqu.Next;
      Continue;
    end;

    if (objConEqu.recSaldos.fltEstFis < objConEqu.cdsIteEqu.FieldByName('QTDITE').AsFloat) then
    begin
      pAvisoAgMontagemSemSaldo;
      Exit;
    end;

    objLinha := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.pAddColuna('ITEM'       , objConEqu.cdsIteEqu.FieldByName('CODITE').AsString                                     , fTamCodIte, alEsquerda);
    objLinha.pAddColuna('DESCRIÇÃO'  , objConEqu.cdsIteEqu.FieldByName('DESITE').AsString                                     , 50, alEsquerda);
    objLinha.pAddColuna('QTDE'       , FloatToStrf(objConEqu.cdsIteEqu.FieldByName('QTDITE').AsFloat, ffFixed, 11, intDecQtde), 10, alDireita);
    objLinha.pAddColuna('SALDO'      , FloatToStrf(objConEqu.recSaldos.fltEstFis, ffFixed, 11, intDecQtde)                    , 10, alDireita);
    objLinha.pAddColuna('SALDO DISP.', FloatToStrf(fltSaldo, ffFixed, 11, intDecQtde)                                         , 10, alDireita);
    objTabela.lstLinhas.Add(objLinha);

    objConEqu.cdsIteEqu.Next;
  end;

  objConEqu.cdsIteEqu.First;

  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
  objLiberacao.strDirAce := 'POSAMS';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strMsgSen := 'Permitir marcar O.S. como AGUARDANDO MONTAGEM que tenha Produtos sem Saldo Disponível';
  Result := objLiberacao.fLibera;
end;

function TfrmFatManConsertoEquip.fPodeRemoverVinculaNFSaidaOS: Boolean;
Begin
  Result := False;

  If (fCfgSis('EQUFVU') = 'V') Then
  Begin

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('A T E N Ç Ã O - Remover Vínculo de Nota Fiscal de Saída de Remessa de Conserto de Equipamento de uma O.S.');
    objLiberacao.objMsgLibera.pAddTexto('                Somente mediante uma confirmação de senha...');
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTextoCaption('Ordem de Serviço', objConEqu.strNumero + '-' + objConEqu.strCodEmp                                      , 16);

    If (Not fEmptyStr(edtDesEqu.Text)) Then
      objLiberacao.objMsgLibera.pAddTextoCaption('Equipamento'   , edtDesEqu.Text                                                                       , 16);

    objLiberacao.objMsgLibera.pAddTextoCaption('Documento'       , objMeqMerSai.strNumDoc + '/' + objMeqMerSai.strSerie_ + '-' + objMeqMerSai.strEspDoc , 16);
    objLiberacao.objMsgLibera.pAddTextoCaption('Empresa'         , objMeqMerSai.strEmpGer                                                               , 16);
    objLiberacao.objMsgLibera.pAddTextoCaption('Emissão'         , FormatDateTime('dd/mm/yyyy', objMeqMerSai.dtaDtaGer)                                 , 16);
    objLiberacao.objMsgLibera.pAddQuebra;


    objLiberacao.strDirAce := 'RVNFOS';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strMsgSen := 'Remover Vínculo de Nota Fiscal de Saída de Remessa de Conserto de Equipamento de uma O.S.';
    objLiberacao.strCliente := edtCodCli.Text;
    objLiberacao.strSenFvu := fCfgSis('EQUFVU');

    objLiberacao.pInformaNumDocEspDocCodEmp(
                      objMeqMerSai.strNumDoc,
                      objMeqMerSai.strEspDoc,
                      objMeqMerSai.strEmpGer);

    If objLiberacao.fLibera Then
    Begin
      Result := True;
    End;
  End
  Else
  Begin

    If Not objConEqu.fVerificaAcessoSistemaOS('RVNFOS', 'Liberado direito de acesso à remoção de vínculo de Nota Fiscal de Saída de Remessa de Conserto de Equipamento!', '') Then
    Begin
      fMensagem('', 'Operador não tem direito de acesso à remoção de vínculo de Nota Fiscal de Saída ' +
        'de Remessa de Conserto de Equipamento!', ['&OK']);
      Result := False;
    End
    Else
      Result := True;

  End;

End;

procedure TfrmFatManConsertoEquip.btnAdicionarDfeClick(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodDfe.Text) Then
    Exit;

  If Not fVerificaCampos Then
    Exit;

  Try

    objConEqu.strCodDfe := edtCodDfe.Text;
    objConEqu.strDesDfe := edtDesDfe.Text;
    objConEqu.cdsDfeEqu.DisableControls;
    objConEqu.pIncluiDefeitoGrid;
    pIncluiNaListaConsulta('CODDFE', 'DFE_CODIGO', sltDfe, objConEqu.cdsDfeEqu, cdsConsultaDfe);
    objConEqu.cdsDfeEqu.EnableControls;

    objConEqu.strCodDfe := EmptyStr;
    objConEqu.strDesDfe := EmptyStr;

    dbgGridDfe.Enabled := True;
    dbgGridDfe.Refresh;

    btnCancelaDfe.Click;

    If (Assigned(frmFatVendaItem)) Then frmFatVendaItem.Close();
  Except
    On e:exception do
    Begin
      pMensagensErro(E.Message, 'btnAdicionarDfeClick - untFatDigSerConsertoEquip');
    End;
  End;

end;

procedure TfrmFatManConsertoEquip.btnAdicionarSe1Click(Sender: TObject);
  Var
    strCodPar, strTipBri, strCodSerAlt, strCodTecAlt: String;
begin
  inherited;

  If fEmptyStr(edtCodSe1.Text) Then
    Exit;

  if( not fValidaCampos(edtDesSe1)) then
    Exit;

  If Not fValidaCampos(edtCodTec, true) Then
    Exit;

  If Not fValidaCampos(edtSenDig, true) Then
    Exit;

  If Not fValidaCampos(edtCodTecSe1, true) Then
    Exit;

  If Not fValidaCampos(edtQtdSe1, true) Then
    Exit;

  if not fValidaCampos(edtTipBriSer, true) then
    Exit;

  If chkBrindeSer.Visible And chkBrindeSer.Checked Then
  Begin
    strCodPar := objConEqu.strCodPar;
    strTipBri := objConEqu.strTipBri;

    If Not fPedeDadosBrinde(chkBrindeSer.Checked, strCodPar, strTipBri) Then
      Exit;

    if (pnlTipBriSer.Visible) then
    begin
      objConEqu.strBrinde := 'S';
      objConEqu.strCodPar := '';
      objConEqu.strTipBri := edtTipBriSer.Text;
    end
    else
    begin
      objConEqu.strBrinde := 'S';
      objConEqu.strCodPar := strCodPar;
      objConEqu.strTipBri := strTipBri;
    end;
  End
  Else
  Begin
    chkBrindeSer.Checked := False;
    objConEqu.strBrinde  := 'N';
    objConEqu.strCodPar  := '';
    objConEqu.strTipBri  := '';
  End;

  If (chkBrindeSer.Visible And chkBrindeSer.Checked) Then
  Begin
    edtValSe1.Text := '0,00';
  End;

  if (chkCobAPaSer.Visible And chkCobAPaSer.Checked) Then
    objConEqu.strCobAPaSer := 'S'
  else
    objConEqu.strCobAPaSer := 'N';

  Try

    If objConEqu.cdsSerEqu.RecordCount < fCfgSis('LINSER', varInteger) Then
    Begin
      if not fValidaDescServico then
        Exit;

      objConEqu.strCodSer := edtCodSe1.Text;
      objConEqu.strDesSer := edtDesSe1.Text;

      if edtQtdSe1.Visible then
      begin
        objConEqu.fltQtdSer := fStrToFloat(edtQtdSe1.text);
        objConEqu.fltValSer := fStrToFloat(edtQtdSe1.text) * fStrToFloat(edtValSe1.text);
      end
      else
      begin
        objConEqu.fltQtdSer := 1;
        objConEqu.fltValSer := fStrToFloat(edtValSe1.text);
      end;

      objConEqu.strTecSer := edtCodTecSe1.Text;

      strCodSerAlt := objConEqu.cdsSerEqu.FieldByName('CODSER').AsString;
      strCodTecAlt := objConEqu.cdsSerEqu.FieldByName('TECSER').AsString;

      If (Not objConEqu.fServicoJaInclusoGrid(edtCodSe1.Text, edtCodTecSe1.Text)) And (Not objConEqu.blnPermiteAltTec) Then
      Begin
        objConEqu.fltValUni := fStrToFloat(edtValSe1.Text);
        objConEqu.cdsSerEqu.DisableControls;
        objConEqu.pIncluiServicoGrid;
        objConEqu.cdsSerEqu.EnableControls;
        strCodSerOld := '';
      End
      Else
      Begin
        objConEqu.cdsSerEqu.Locate('CODSER;TECSER', VarArrayOf([strCodSerAlt, strCodTecAlt]), []);

        objConEqu.fltVlrSer := objConEqu.fltVlrSer - objConEqu.cdsSerEqu.FieldByName('VALSER').AsFloat;
        objConEqu.fltVlrCon := objConEqu.fltVlrCon - objConEqu.cdsSerEqu.FieldByName('VALSER').AsFloat;
        objConEqu.fltValUni := fStrToFloat(edtValSe1.text);

        objConEqu.cdsSerEqu.DisableControls;
        objConEqu.pAlteraServicoGrid;
        objConEqu.cdsSerEqu.EnableControls;
        strCodSerOld := '';
      End;

      objConEqu.fltVlrSer := objConEqu.fltVlrSer + objConEqu.fltValSer;
      objConEqu.fltVlrCon := objConEqu.fltVlrCon + objConEqu.fltValSer;

      objConEqu.strCodSer := EmptyStr;
      objConEqu.strDesSer := EmptyStr;
      objConEqu.fltValSer := 0;

      dbgServico.Enabled := True;
      dbgServico.Refresh;

      pIncluiNaListaConsulta('CODSER', 'SER_CODSER', sltServ, objConEqu.cdsSerEqu, cdsConsultaServ);
      btnCancelaSe1.Click;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Número máximo de itens de serviço excedido!', ['&O k']);
    End;

  Except
    On e:exception do
    Begin
      pMensagensErro(E.Message, 'btnAdicionarClick - untFatDigSerConsertoEquip');
    End;
  End;

  pAplicarDescontoServicos();

  lblTotGer.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltVlrCon);
  lblTotPro.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltVlrPro);
  lblTotSer.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltVlrSer);
  lblTotDes.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltDesEsp + objConEqu.fltDesEspSer);
  lblTotST.Caption  := FormatFloat(fMskDigitos(2), objConEqu.fltTotRet);
  lblTotIPI.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltTotIPI);
  lblTotFre.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltValFre);
  lblTotRef.Caption := FormatFloat(fMskDigitos(2), objConEqu.fltTotCbs + objConEqu.fltTotIbs + objConEqu.fltTotIs);

  edtCodSe1.Enabled := True;

  If (Assigned(frmFatVendaItem)) Then frmFatVendaItem.Close();

  If (objConEqu.blnPermiteAltTec) Then
    pHabilitarCamposAlterarTecnicoServico(False);

  Application.ProcessMessages;
end;

procedure TfrmFatManConsertoEquip.btnAltCondPagtoClick(Sender: TObject);
begin
  inherited;

  if (not fVerificaAcessoSistema('FXALCP', strLoginUsuarioLogado)) then
  begin
    fMensagem('Atenção', 'Usuário sem permissão para alterar a condição de pagamento ao consultar a OS no fluxo!', ['&OK']);
    Exit;
  end;

  if (not fVerificarPedFat_AltCodPagto) then
    Exit;

  if fVerificaAdiantamento then
    Exit;

  pnlCndPag.Enabled := True;
  edtCodCnd.Enabled := True;
  mskCndPag.Enabled := True;
  edtForPag.Enabled := True;
  edtForPag.ReadOnly := False;
  gbDadGerOS.Enabled := True;
  pnlVendedor.Enabled := False;
  blnAlterarCondicao := True;
  pSetFocus(edtCodCnd);
end;

procedure TfrmFatManConsertoEquip.btnAlteracaoClick(Sender: TObject);
  procedure pCriarArrMatItensInicial;
    Var
      i: Integer;
  begin
    objConEqu.cdsIteEqu.DisableControls();
    objConEqu.cdsIteEqu.First();

    i := 0;
    SetLength(arrMatItensIni, objConEqu.cdsIteEqu.RecordCount);

    While (Not objConEqu.cdsIteEqu.Eof) Do
    Begin
      arrMatItensIni[i].strCodIte := objConEqu.cdsIteEqu.FieldByName('CODITE').AsString;
      arrMatItensIni[i].strEntRet := 'R';
      arrMatItensIni[i].strBrinde := objConEqu.cdsIteEqu.FieldByName('BRINDE').AsString;
      arrMatItensIni[i].fltQtdIte := objConEqu.cdsIteEqu.FieldByName('QTDITE').AsFloat;
      arrMatItensIni[i].strDesIte := objConEqu.cdsIteEqu.FieldByName('DESITE').AsString;
      arrMatItensIni[i].strUnidad := objConEqu.cdsIteEqu.FieldByName('UNIDAD').AsString;
      arrMatItensIni[i].strAutoincrementoGravacao := objConEqu.cdsIteEqu.FieldByName('AUTINC').AsString;

      objConEqu.cdsIteEqu.Next();
      i := i + 1;
    End;

    objConEqu.cdsIteEqu.EnableControls();
  end;
begin
  inherited;

  If (Not btnAlteracao.Enabled) Then Exit;

  If (Not fVerificarPedFat_OsRealizada()) Then Exit;

  If fPodeAlterarOS Then
  Begin
    pCriarArrMatItensInicial;
    If (objConEqu.strStatus <> 'R') And (objConEqu.strStatus <> 'N') Then
    Begin
      blnVerificaLimiteCredito := True;

      edtCodCli.Enabled    := True;
      edtCodRep.Enabled    := True;
      pnlRealizada.Enabled := True;
      pnlCndPag.Enabled    := True;
      pnlBotton.Enabled    := True;
      edtDisSer.ReadOnly   := False;
      pnlVendedor.Enabled  := True;
      pnlRepDig.Enabled    := True;
      pnlItens.Enabled     := True;
      pnlServicos.Enabled  := True;
      pnlDefeitos.Enabled  := True;
      pnlAcessorios.Enabled:= True;
      pnlTotal.Enabled     := True;
      btnConfirmar.Enabled := True;
      cbTabPreco.Enabled   := True;
      objConEqu.strOperac  := 'A';

      btnRealizada.Enabled := False;
      btnAprovada.Enabled  := False;
      btnReprovar.Enabled  := False;
      btnAlteracao.Enabled := False;
      btnAlteraItens.Enabled := True;
      btnBrindeTotalServ.Enabled := True;
      btnMostraMargem.Enabled := True;

      btnPedCompraItens.Enabled  := (objConEqu.strTemPed = 'S');
      btnOrdMaoObrCli.Enabled    := (objConEqu.strTemPed = 'S');
      grbDocEntrada.Enabled := True;
      grbDocSaida.Enabled   := True;
      edtDisSer.Enabled     := True;

      if (not fEhFluxoDadosOS) then
      begin
        btnImpSeparacao.Visible := (objConEqu.strTemPed = 'S') And (fCfgSis('PEDSEP', varBoolean)) And (objConEqu.strStatus <> 'N');
        btnImpPed.Visible       := (objConEqu.strTemPed = 'S') And (objConEqu.strStatus <> 'N');
      end;

      If (Not blnUsaDig) Then
      Begin
        If (fCfgSis('ALTVEN', varBoolean)) Then
        Begin
          edtSenVen.Text := '';
          edtNomVen.Text := '';
          pSetFocus(edtSenVen);
        End;
      End
      Else
      Begin
        edtSenDig.Text := '';
        edtNomDig.Text := '';
        pSetFocus(edtSenDig);
      End;
    End
    Else
    Begin
      If blnUsaDig Then
        pPodeAlterarDigitador();

      pPodeAlterarTecnico();

      pHabilitarEdicaoCamposRealizadaReprovada();
      pSetFocus(cmbStaRealizada);
    End;
  End
  Else if blnFluxoProcesso then
    PostMessage(Self.Handle, WM_CLOSE, 0, 0);

  pStatus;
end;

procedure TfrmFatManConsertoEquip.btnAlteraItensClick(Sender: TObject);
var
  blnBrinde,
  blnLibera: Boolean;
  strCodPar,
  strTipBri,
  strPromoc: String;
  cdsDados: TUniClientDataSet;
  frmFatManAlteraItensBrinde: TfrmFatManAlteraItensBrinde;
begin
  inherited;

  if objConEqu.cdsIteEqu.IsEmpty then
    Exit;

  if (not fVerificaCampos) then
    Exit;

  blnLibera := True;

  cdsDados := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsDados, objConEqu.cdsIteEqu);
  cdsDados.IndexFieldNames := objConEqu.cdsIteEqu.IndexFieldNames;

  pCriarFormularios(TfrmFatManAlteraItensBrinde, frmFatManAlteraItensBrinde);

  try
    frmFatManAlteraItensBrinde.dtsGrid.DataSet := cdsDados;

    if (frmFatManAlteraItensBrinde.ShowModal = mrOk) then
    begin
      blnBrinde := frmFatManAlteraItensBrinde.blnBrinde;
      strCodPar := frmFatManAlteraItensBrinde.strCodPar;
      strTipBri := frmFatManAlteraItensBrinde.strTipBri;

      cdsDados.Filtered := False;
      cdsDados.Filter   := 'MARDES=1';
      cdsDados.Filtered := True;

      if blnBrinde then
      begin
        if blnUsaDig and (pnlRepDig.Visible) and (not fEmptyStr(edtSenDig.Text)) then
          blnLibera := objConEqu.fVerificaAcessoSistemaOS('frmFatVendas - BR', 'Liberado direito de acesso para vendedor conceder brinde na ordem de serviço.', fRetCodVendedor(edtSenDig.Text))
        else
          blnLibera := objConEqu.fVerificaAcessoSistemaOS('frmFatVendas - BR', 'Liberado direito de acesso para vendedor conceder brinde na ordem de serviço.', fRetCodVendedor(edtSenVen.Text));

        if not blnLibera then
        begin
          cdsDados.First;

          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto('Emitir Brinde de Produto');

          while not cdsDados.Eof do
          begin
            objLiberacao.objMsgLibera.pAddSeparador(65);
            objLiberacao.objMsgLibera.pAddTextoCaption('Produto'    , cdsDados.FieldByName('CODITE').AsString + ' - ' + cdsDados.FieldByName('DESITE').AsString, 10);
            objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade' , cdsDados.FieldByName('QTDITE').AsString , 10);

            cdsDados.Next;
          end;

          objLiberacao.objMsgLibera.pAddQuebra;
          objLiberacao.strDirAce := 'frmFatVendas - BR';
          objLiberacao.strMsgSen := 'Emitir Brinde de Produto';
          objLiberacao.strCodOpe := fRetCodVendedor(edtSenVen.Text);
          objLiberacao.strCodDig := strLoginUsuarioLogado;
          objLiberacao.strCliente := edtCodCli.Text + '-' + edtNomCli.Text;

          blnLibera := objLiberacao.fLibera;
        end;
      end;

      if not blnLibera then
        Exit;

      cdsDados.First;

      while not cdsDados.Eof do
      begin
        objConEqu.cdsIteEqu.Locate('CODITE', cdsDados.FieldByName('CODITE').AsString, []);

        if (cdsDados.FieldByName('BRINDE').AsString = IIF(blnBrinde, 'S', 'N')) and (not blnBrinde) then
        begin
          cdsDados.Next;
          Continue;
        end;

        pCarregarProduto();

        if blnBrinde then
        begin
          objConEqu.strBrinde := 'S';
          objConEqu.strCodPar := strCodPar;
          objConEqu.strTipBri := strTipBri;

          edtUnitar.Text := '0,00';
          pCalculaTotIte;
        end
        else
        begin
          objConEqu.strBrinde := 'N';
          objConEqu.strCodPar := '';
          objConEqu.strTipBri := '';

          If (fEmptyStr(objConEqu.strTabPreIte)) Then fVerificarTabPre();

          edtUnitar.Text := FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)),
            objConEqu.fRetPreVen(edtCodIte.Text, IIF(cbTabPrecoItem.Visible, objConEqu.strTabPreIte, objConEqu.strTabPre), strPromoc));
          pCalculaTotIte;
        end;

        pAdicionaItem;

        cdsDados.Next;
      end;
    end;
  finally
    pFreeAndNil(frmFatManAlteraItensBrinde);
    FreeAndNil(cdsDados);

    if (Assigned(frmFatVendaItem)) then
      frmFatVendaItem.Close();
  end;
end;

procedure TfrmFatManConsertoEquip.btnAlterarFazendaClick(Sender: TObject);
var
  LSelFazenda: Boolean;
begin
  inherited;

  if (not fCfgSis('CADFAZ', varBoolean)) then
    Exit;

  LSelFazenda := fSelecionarFazendaCliente(edtCodCli.Text, True);
  pExibirDadosFazenda(LSelFazenda);
end;

procedure TfrmFatManConsertoEquip.btnAltTecServicosClick(Sender: TObject);
var
  frmFatManConsertoAlteraTecnico: TfrmFatManConsertoAlteraTecnico;
begin
  inherited;

  pCriarFormularios(TfrmFatManConsertoAlteraTecnico, frmFatManConsertoAlteraTecnico);

  try
    frmFatManConsertoAlteraTecnico.objConEqu    := objConEqu;
    frmFatManConsertoAlteraTecnico.objLiberacao := objLiberacao;
    frmFatManConsertoAlteraTecnico.ShowModal();
  finally
    pFreeAndNil(frmFatManConsertoAlteraTecnico);
  end;
end;

procedure TfrmFatManConsertoEquip.edtCodEmpExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtNumero.Text) Then
  Begin
    edtCodEmp.Text        := VS_strCodEmp;
    fValidaCampos(edtCodEmp, True);

    RedimensionaDesEmp(True);
    lblNovaOrdem.Visible  := True;
    btnObservacao.Enabled := False;
    btnHisSta.Enabled     := False;
    btnImpEti.Enabled     := False;
    mskDtaInc.Text        := DateToStr(Date);
  End
  Else
  Begin
    RedimensionaDesEmp(False);
    btnObservacao.Enabled := True;
    btnHisSta.Enabled     := True;
    btnImpEti.Enabled     := True;

    if (StrToDateDef(objConEqu.strDtaEnt, 0) <> 0) and (not fEmptyStr(objConEqu.strNumero)) then
      mskDtaInc.Text := objConEqu.strDtaEnt
    else
      mskDtaInc.Clear;
  End;
end;

procedure TfrmFatManConsertoEquip.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrSel) Then
  Begin
    if fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFatManConsertoEquip.edtCodEquEnter(Sender: TObject);
begin
  inherited;
  If (not blnRotinaTecnico) Then
    pnlInfo.Caption := 'INSERT para fazer um novo cadastro';
end;

procedure TfrmFatManConsertoEquip.edtCodEquExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmFatManConsertoEquip.edtCodEquKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEqu: TConsultasArray;
begin
  inherited;

  {*********************************}
  {* NOVA CONSULTA DE EQUIPAMENTOS *}
  {******************************RV*}
  If fPesqEquipamento(Self, edtCodEqu, edtDesEqu, Nil, Key, arrEqu) Then
  Begin
    If fValidaCampos(edtCodEqu, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmFatManConsertoEquip.fAbreManutencao(strCodEmpP : String) : Boolean;
var
  blnImp,
  blnJafatu,
  blnJaBaix,
  blnSepImp,
  LSelFazenda: Boolean;
  strCodVen,
  LNumFat: String;
  intEtapa: integer;
const
  MAX_PROGRESSO = 10;
begin
  Result := True;

  If(fTravaERegistraStlManEquLck(edtNumero.Text, strCodEmpP)) Then
    Exit;

  If objConEqu.fVerificaOrdServExiste(edtNumero.Text, strCodEmpP, blnRotinaTecnico) Then
  Begin

    pInformacao('Aguarde, Inicializando Ordem de Serviço...', pgbStatus);
    pProgresso(fInc(intEtapa), MAX_PROGRESSO, pgbStatus);
    {Executa "fInicializarFatVenda" aqui para validar regra de "Venda Presencial?"}
    fInicializarFatVenda(True);

    If (objConEqu.strTemPed = 'S') And  (Not fCfgSis('GER_OS', varBoolean)) And (objConEqu.strEmpApr <> VS_strCodEmp) Then
    Begin
      Result := False;
      pLimpaTela;
      fMensagem('', 'Essa ordem de serviço já foi aprovada na empresa ' + objConEqu.strEmpApr + ' - ' + fRetNomeEmpresaSelec(objConEqu.strEmpApr) + #13 +
                     ' ela só pode ser alterada através da empresa aprovada!', ['&OK']);
      pSetFocus(edtNumero);
      Exit;
    End;

    pInformacao('Aguarde, Verificando Operações...', pgbStatus);
    pProgresso(fInc(intEtapa), MAX_PROGRESSO, pgbStatus);
    objConEqu.pVerificaOperacoes(blnIniOrc, blnFinOrc, blnIniMan, blnFinMan);
    blnIniOrc := False;
    blnFinOrc := False;
    blnFinMan := False;

    objMeqMerEnt := TConEqu.fRetDadosMeqMer('', objConEqu.strCodEmp, objConEqu.strNumero, 'E');
    objMeqMerSai := TConEqu.fRetDadosMeqMer('', objConEqu.strCodEmp, objConEqu.strNumero, 'S');
    pCarregaDadosNFEntSai;

    pInformacao('Aguarde, Carregando Dados do Cliente...', pgbStatus);
    pProgresso(fInc(intEtapa), MAX_PROGRESSO, pgbStatus);
    edtCodCli.Text := objConEqu.strCodCli;
    pCarregarNomeCliente;
    pSetaTabelaPreco(objConEqu.strTabPre);

    LSelFazenda := fSelecionarFazendaCliente(objConEqu.strCodCli);
    pExibirDadosFazenda(LSelFazenda);

    If (edtCodRep.Visible) Then
    Begin
      pPesquisaCadCli(qryCadCli, qryCadCli, edtCodCli.Text);
      objConEqu.strCodRep := qryCadCli.FieldByName('CLI_CODREP').AsString;
    End;

    If (Not edtSenDig.Visible) Then
      edtSenVen.Text := fRetSenhaVendedor(objConEqu.strCodVen)
    Else
      edtSenVen.Text := objConEqu.strCodVen;

    edtNomVen.Text := fRetNomVendRep(objConEqu.strCodVen);

    edtCodRep.Text := objConEqu.strCodVe2;
    edtDesRep.Text := fRetNomVendRep(objConEqu.strCodVe2);

    edtSenDig.Text := fRetSenhaVendedor(objConEqu.strCodDig);
    edtNomDig.Text := fRetNomVendRep(objConEqu.strCodDig);

    edtCodTec.Text := objConEqu.strCodTec;
    edtDesTec.Text := fRetNomeOperador(objConEqu.strCodTec);
    edtCodEqu.Text := objConEqu.strCodEqu;

    if edtLocFis.Visible then
      edtLocFis.Text := objConEqu.strLocFisEqu
    else
    begin
      edtCodLoc.Text := objConEqu.strLocFisEqu;
      edtDesLoc.Text := fRetDescLocFisicaOS(objConEqu.strLocFisEqu);
    end;

    chkAutDescarte.Checked := objConEqu.blnAutorizaDescarte;

    pInformacao('Aguarde, Carregando Dados do Equipamentos...', pgbStatus);
    pProgresso(fInc(intEtapa), MAX_PROGRESSO, pgbStatus);
    pCarregaEquipamento;

    edtObs.Text    := objConEqu.strDescri;
    edtObsGer.Text := objConEqu.strObsGer;
    edtObsNFS.Text := objConEqu.strObsNFS;
    edtDisSer.Text := objConEqu.strDisSer;
    edtNSerie.Text := objConEqu.strNSerie;
    cbGarant.ItemIndex := StrToInt(fRetOpcaoEmGarantia(objConEqu.strGarant));
    cbGarantChange(cbGarant);
    edtRevend.Text := objConEqu.strRevend;
    edtConRet.Text := objConEqu.strConRet;
    edtDeiPor.Text := objConEqu.strDeiPor;
    edtNFComp.Text := objConEqu.strNFComp;
    edtNFReme.Text := objConEqu.strNFReme;
    edtEmpSer.Text := objConEqu.strEmpSer;

    if fCfgSis('NOMEMP') = '2' then
      edtDesEmpSer.Text := fRetFantasiaEmpresa(edtEmpSer.Text)
    else
      edtDesEmpSer.Text := fRetNomeEmpresaSelec(edtEmpSer.Text);

    if (not fEmptyStr(edtCodEqu.Text)) and (not fEmptyStr(edtNSerie.Text)) then
      trvHisEqu.LoadFromStream(TStringStream.Create(objConEqu.fCarregaHistoricoEquip(edtNumero.Text, edtCodCli.Text, edtCodEqu.Text, edtNSerie.Text)));

    If objConEqu.dtaDtNFCo <> 0 Then
      mskDtNFco.Text := DateToStr(objConEqu.dtaDtNFCo);

    If objConEqu.dtaDtNFRe <> 0 Then
      mskDtNFRe.Text := DateToStr(objConEqu.dtaDtNFRe);

    If objConEqu.dtaEntreg <> 0 Then
      mskEntreg.Text := DateToStr(objConEqu.dtaEntreg);

    edtDiaEnt.Text := IntToStr(objConEqu.intDiaEnt);

    edtNumero.Enabled := False;
    edtCodEmp.Enabled := False;
    edtCodCli.Enabled := (objConEqu.strStatus <> 'R');
    edtCodCnd.Text := objConEqu.strCodCnd;
    strConPagAnt   := objConEqu.strConPag;
    mskCndPag.Text := objConEqu.strConPag;
    edtForPag.Text := objConEqu.strCodFpg;

    edtProtoc.Text := objConEqu.strProtoc;
    edtCntCli.Text := objConEqu.strCntCli;
    mskCntTel.Text := objConEqu.strCntTel;
    edtNumPat.Text := objConEqu.strNumPat;
    edtDadFab.Text := objConEqu.strDadFab;
    edtNOSAnt.Text := objConEqu.strNOSAnt;

    if (objConEqu.dtaDtEAnt <> 0) then
      mskDtEAnt.Text := DateToStr(objConEqu.dtaDtEAnt);

    if (objConEqu.dtaDtRAnt <> 0) then
      mskDtRAnt.Text := DateToStr(objConEqu.dtaDtRAnt);

    if StrToDateDef(objConEqu.strDtaEnt, 0) <> 0 then
      mskDtaInc.Text := objConEqu.strDtaEnt;

    chkPrtAtd.Checked := objConEqu.blnPrtAtd;

    lblNOSFab.Visible := cbGarant.ItemIndex <> 0;
    edtNOSFab.Visible := lblNOSFab.Visible;
    edtNOSFab.Text    := objConEqu.strNOSFab;

    if cbEstPrd.Visible then
      cbEstPrd.ItemIndex := cbEstPrd.Items.IndexOf(fCampoTabela('EPR_DESCRI', 'CADEPR', ['EPR_CODEPR'], [objConEqu.strCodEpr]));

    edtTmpGar.Text := IntToStr(objConEqu.intTmpGar);

    pInformacao('Aguarde, Carregando Condições de Pagamento...', pgbStatus);
    pProgresso(fInc(intEtapa), MAX_PROGRESSO, pgbStatus);
    pCarregaCondicao(False);

    pInformacao('Aguarde, Carregando Formas de Pagamento...', pgbStatus);
    pProgresso(fInc(intEtapa), MAX_PROGRESSO, pgbStatus);
    pCarregaForPag;

    strCcnAnt := edtCodCnd.Text;
    strFpgAnt := edtForPag.Text;

    if (fCfgSis('CTRPEN', varInteger) = 2) then
      pCalculaDataPrevisao;

    lblEntreg.Caption := mskEntreg.Text;
    lblCodCnd.Caption := edtCodCnd.Text + ' - ' + edtDesCndPag.Text;
    lblConPag.Caption := fFormataCondPag(mskCndPag.Text);
    lblForPag.Caption := edtForPag.Text + ' - ' + edtDesForPag.Text;

    If (objConEqu.strStatus <> 'N') And (objConEqu.strStatus <> 'E') Then
      btnReprovar.Enabled  := True;

    {Req: 125319 - Manutenção - Aguardando Itens}
    If (objConEqu.strStatus = 'M') And (objConEqu.strSubSta = 'A') Then
      btnManutencao.Enabled := True;

    If objConEqu.strStatus = 'E' Then
    Begin
      blnVerificaLimiteCredito := True;
      btnAlteracao.Visible  := False;
      objConEqu.strOperac   := 'A';
      blnMudarFoco          := False;
      if (not fEhFluxoDadosOS) then
      begin
        pnlItens.Enabled      := True;
        pnlServicos.Enabled   := True;
        pnlDefeitos.Enabled   := True;
        pnlAcessorios.Enabled := True;
        grbDocEntrada.Enabled := True;
        grbDocSaida.Enabled   := True;
        btnAlteraItens.Enabled:= True;
        btnBrindeTotalServ.Enabled:= True;
      end;
      btnImprimir.Enabled   := (Not fEmptyStr(objConEqu.strNumero));
      edtDisSer.Enabled     := True;
      pSetFocus(edtCodCli);
    End
    Else
    Begin
      edtNomVen.Text := fRetNomVendRep(objConEqu.strCodVen);
      edtDesRep.Text := fRetNomVendRep(objConEqu.strCodVe2);
      pnlNumeroOS.Enabled   := False;
      edtCodCli.Enabled     := False;
      cbTabPreco.Enabled    := False;
      pnlCndPag.Enabled     := False;

      if (not blnFluxoProcesso) or (blnFluxoProcesso and (tpProcessoFlx <> tprRealizarMan)) then
        pnlVendedor.Enabled   := False;

      pnlRealizada.Enabled  := False;
      edtCodRep.Enabled     := False;
      edtDisSer.Enabled     := False;
      pnlItens.Enabled      := False;
      pnlServicos.Enabled   := False;
      pnlDefeitos.Enabled   := False;
      pnlAcessorios.Enabled := False;
      pnlBotton.Enabled     := blnFluxoProcesso;

      if fPermiteHabilitarDocsFiscaisRef then
      begin
        grbDocEntrada.Enabled := False;
        grbDocSaida.Enabled   := False;
      end;

      pnlTotal.Enabled      := False;
      btnConfirmar.Enabled  := False;
      btnApontHoras.Enabled := False;
      btnAlteraItens.Enabled:= False;
      btnBrindeTotalServ.Enabled:= False;
      btnMostraMargem.Enabled := False;
      btnCancAprovacao.Visible := (not blnFLuxoProcesso);
      btnCancAprovacao.Enabled := (objConEqu.strTemPed = 'S') and (objConEqu.strStatus <> 'R');

      if (not fEhFluxoDadosOS) then
        btnAlteracao.Visible := True;

      If (objConEqu.strStatus <> 'R')  // REALIZADA
        And (objConEqu.strStatus <> 'N') Then // REPROVADA
        btnAprovada.Enabled  := True;

      If (objConEqu.strStatus = 'A') Then
      Begin
        btnManutencao.Enabled := True;

        If (fCfgSis('CALTOS') = 'N') Then
          btnRealizada.Enabled  := True

        Else
          btnRealizada.Enabled  := not (fCfgSis('CALTOS') = 'S');
      End
      Else If (objConEqu.strStatus = 'N') And (objConEqu.strSubSta = 'M') Then
      Begin
        btnManutencao.Enabled := True;
      End
      Else If (objConEqu.strStatus = 'M') Then
      Begin
        If (fCfgSis('CALTOS') = 'N') Then
          btnRealizada.Enabled := True
        Else
          btnRealizada.Enabled  := (fCfgSis('CALTOS') = 'N') OR blnIniMan;

        If (fOSFoiReprovadaAgMontagem()) Then
        Begin
          btnRealizada.Enabled := False;
          btnAlteracao.Enabled := False;
          btnAprovada.Enabled  := False;
          btnCancelar.Enabled  := False;
        End
      End;

      btnImprimir.Enabled  := True;
      btnHisSta.Enabled   := True;
      btnTermoDev.Enabled := True;
      Case pgcTabs.ActivePageIndex Of
        0: pSetFocus(dbgGridAce);
        1: pSetFocus(dbgGridDfe);
        2: pSetFocus(dbgGrid);
        3: pSetFocus(dbgServico);
        4: pSetFocus(dbgGridApo);
      End;
      objConEqu.cdsIteEqu.First;
    End;

    btnCancelar.Enabled := (objConEqu.strStatus <> 'N') And (Not fOSFoiReprovadaAgMontagem());

    btnAddObsTec.Enabled := True;
    btnComunicacaoInterna.Enabled := True;
    btnConsultarCliente.Enabled := True;

    btnImpItensServicos.Enabled := fCfgSis('CNDFAI', varBoolean);

    if btnAprovada.Enabled then
    begin
      pSetFocus(edtSenDig);
    end;

    pInformacao('Aguarde, Verificando Status...', pgbStatus);
    pProgresso(fInc(intEtapa), MAX_PROGRESSO, pgbStatus);
    pStatus;

    If (Not fEmptyStr(objConEqu.strStatus)) And CharInSet(objConEqu.strStatus[1], ['E','F']) Then
    Begin
      pMostraObsCliente(edtCodCli.Text);
      pCarregarNomeCliente;
      fDigDadosConsumidor;
      pCarregarNomeCliente;
    End;

    {*****************************}
    {* BUSCA ENDEREÇO DE ENTREGA *}
    {**************************MM*}
    pInformacao('Aguarde, Buscando Endereço de Entrega...', pgbStatus);
    pProgresso(fInc(intEtapa), MAX_PROGRESSO, pgbStatus);
    objEndEnt.pRetEnderecoEntrega(objConEqu.strEntGer,objConEqu.strCodCli);

    blnOsGeradaPorPd := Not fEmptyStr(objConEqu.strNumPed);

    If fCfgSis('GER_OS', varBoolean) And blnOsGeradaPorPd Then
    Begin
      btnAlteracao.Visible := False;
    End;

    pInformacao('Aguarde, Verificando Existencia do Documento...', pgbStatus);
    pProgresso(fInc(intEtapa), MAX_PROGRESSO, pgbStatus);
    fDocumentoFatExiste(qryFatgor,
                        objConEqu.strNumPed,
                        'PD',
                        objConEqu.strEmpPed,
                        blnJafatu,
                        blnJaBaix,
                        blnImp,
                        strCodVen,
                        blnSepImp);

    blnJaFatu := blnJaFatu or fValidaHouveFaturamentoParcial(LNumFat, objConEqu.strNumPed, objConEqu.strEmpPed);

    if (not fEhFluxoDadosOS) then
    begin
      btnCancelarOS.Visible := (objConEqu.strStatus = 'R') And (Not blnJafatu);
      btnDesEsp.Visible     := (objConEqu.strStatus <> 'N') And (objConEqu.strStatus <> 'R') And (Not blnJafatu);
    end;

    btnApontHoras.Enabled := (objConEqu.strStatus <> 'N') And (objConEqu.strStatus <> 'R') And (Not blnJafatu);

    if (btnDesEsp.Visible) and (blnFluxoProcesso) and (tpProcessoFlx <> tprOrcamento) then
      btnDesEsp.Visible := False;

    If (objConEqu.strStatus <> 'R') Then
    Begin
      pHabilitarCamposRealizada(False);
    End
    Else
    Begin
      If (fCfgSis('EQUREA', varString) = '2') Then
      Begin
        pHabilitarCamposRealizada(True);

        edtRetiradoPor.Text := objConEqu.strReaPor;

        If (Not fEmptyStr(objConEqu.strReaPor)) Or (objConEqu.strSubSta = 'A') Then
        Begin
          If (objConEqu.strSubSta = 'C') Then
            cmbStaRealizada.ItemIndex := 0
          Else If (objConEqu.strSubSta = 'A') Then
            cmbStaRealizada.ItemIndex := 1
          Else
            cmbStaRealizada.ItemIndex := -1;
        End;

        objConEqu.strSubStaAnt := objConEqu.strSubSta;
      End;
    End;

    if (not fEhFluxoDadosOS) then
    begin
      btnPedCompraItens.Visible := (objConEqu.strTemPed = 'S');
      btnPedCompraItens.Enabled := False;
      btnOrdMaoObrCli.Visible   := (objConEqu.strTemPed = 'S');
      btnOrdMaoObrCli.Enabled   := False;
      btnImpSeparacao.Visible := (objConEqu.strTemPed = 'S') And (fCfgSis('PEDSEP', varBoolean)) And (objConEqu.strStatus <> 'N');
      btnImpPed.Visible       := (objConEqu.strTemPed = 'S') And (objConEqu.strStatus <> 'N');
    end;

    if fEhFluxoDadosOS and (tpImpressaoFlx = fpEditar) then
    begin
      btnOrdMaoObrCli.Visible   := (objConEqu.strTemPed = 'S');
      btnOrdMaoObrCli.Enabled   := True;
      btnPedCompraItens.Visible := (objConEqu.strTemPed = 'S');
      btnPedCompraItens.Enabled := True;
    end;

    pAtualizaTotais;
    pHabilitaPainelLegendas;

    If (Not fOSFoiReprovadaAgMontagem()) Then
      btnAlteracao.Enabled    := True;

    Self.Caption := 'Manutenção de Ordem de Serviços - Cliente: ' + edtNomCli.Text + ' - Equip.: ' + edtDesEqu.Text +
      IIF(not fEmptyStr(edtDesMar.Text), ' - Marca: ' + edtDesMar.Text, '') + IIF(not fEmptyStr(edtVoltag.Text), ' - Volt.: ' + edtVoltag.Text, '');

    blnNovaOrdemServico := False;
  End
  Else
  Begin
    If stlManEquAltLck.Count > 0  Then
      pDestravaELimpaStlManEquLck();

    fMensagem('AVISO', 'Ordem de Serviço não encontrada!', ['&Ok']);
    Result := False;
  End;

  pInformacao('Aguarde, Ajustando Tela para Rotina Tecnica...', pgbStatus);
  pProgresso(fInc(intEtapa), MAX_PROGRESSO, pgbStatus);
  pExibeValores;
  pCarregaImagem;
  pAlteraTelaRotinaTecnico;

  if ((blnFluxoProcesso)
    and (tpProcessoFlx in [tprDocsFiscais, tprDefPrdSer, tprOrcamento, tprRealizarMan]))
    and (edtSenDig.Visible) then
  begin
    edtSenDig.Clear;
    edtNomDig.Clear;
    pSetFocus(edtSenDig);
  end;
End;

function TfrmFatManConsertoEquip.fCampoDigitadorHabilitado: Boolean;
begin
  Result := False;

  if (not pnlTopo.Enabled) then
    Exit;

  if (not gbDadGerOS.Enabled) then
    Exit;

  if (not pnlRepDig.Enabled) then
    Exit;

  if (not edtSenDig.Enabled) then
    Exit;

  if (edtSenDig.ReadOnly) then
    Exit;

  Result := True;
end;

function TfrmFatManConsertoEquip.fCarregarTodosItensNotaSaida: Boolean;
begin
  Result := False;

  if (not fCfgSis('PCTINE', varBoolean)) then
    Exit;

  if (fCfgSis('ENTEQU', varString) <> 'A') then
    Exit;

  Result := (fMensagem('ATENÇÃO!', 'Deseja carregar todos os equipamentos da Nota de Entrada vinculada a Ordem de Serviço?', ['&Sim', '&Não']) = 1);
end;

function TfrmFatManConsertoEquip.fCarregaServico(edtCodSer, edtDesSer: TEditFocus; blnBuscaPorChave: Boolean): Boolean;
  Var
    strSQL         : String;
    edtValSer      : TEdit;
    intContador    : Integer;
    blnConfirmaServ: Boolean;
    fltValSer      : Double;
    qryGenSer      : TUniQuery;
begin
  fltValSer := 0;
  qryGenSer := fCriaQuery(Self);

  blnConfirmaServ := True;

  If (RightStr(edtCodSer.Name, 1) = '1') Then
  Begin

    If (fEmptyStr(edtCodSer.Text)) Then
    Begin
      blnConfirmaServ := True;
      For intContador := 2 To 6 Do
      Begin
        edtValSer := TEdit(fComponentByName(pnlServicos, 'edtValSe' + IntToStr(intContador)));
        If (Not fEmptyStr(edtValSer.Text)) And (fStrToFloat(edtValSer.Text) > 0)Then
        Begin
          blnConfirmaServ := False;
          Break;
        End;
      End;
    End;

  End;

  If (Not blnConfirmaServ) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário digitar o primeiro serviço!', ['&Ok']);
    Result := False;
    Exit;
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  SER_DESSER, ';
  strSQL := strSQL + '  SER_VALSER ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADSER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  SER_CODSER = :CODSER AND (SER_ATIVO_ = "S") ';

  With qryGenSer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODSER').AsString := edtCodSer.Text;
    Open;

    edtValSer := TEdit(fComponentByName(pnlServicos, 'edtValSe' + RightStr(edtCodSer.Name, 1)));

    edtDesSer.Enabled     := False;
    edtDesSer.TabStop     := False;
    edtDesSer.ReadOnly    := True;
    edtDesSer.NormalColor := $00FFDFB8;

    If (Not IsEmpty) Then
    Begin
      if (fCfgSis('VSEREQ', varBoolean)) then
        fltValSer := fCampoTabela('EQS_VALSER', 'SEREQU', ['EQS_CODEQU', 'EQS_CODSER'], [edtCodEqu.Text, edtCodSer.Text], False);

      if (fltValSer <= 0) then
        fltValSer := FieldByName('SER_VALSER').AsFloat;

      If (fCfgSis('EDISER') = 'S') Then
      Begin
        edtDesSer.Enabled     := True;
        edtDesSer.TabStop     := True;
        edtDesSer.ReadOnly    := False;
        edtDesSer.NormalColor := clWindow;
      End;

      edtValSer.Enabled := True;

      If strCodSerOld <> edtCodSer.Text Then
      Begin
        edtValSer.Text      := FloatToStrF(fltValSer, ffFixed, 12, 2);
        fltValOri           := fltValSer;
      End;

      If (fEmptyStr(edtDesSer.Text)) Or (Not edtDesSer.Enabled)Then
        edtDesSer.Text  := FieldByName('SER_DESSER').AsString;

      Result := True;
    End
    Else
    Begin
      edtDesSer.Clear;
      edtValSer.Enabled := False;
      edtValSer.Text    := '0,00';

      If (fEmptyStr(edtCodSer.Text)) Then
      Begin
        blnMudarFoco := False;

        If (edtCodSer = edtCodSe1) Then
        Begin
          btnSair.Click;
          Result := False;
        End
        Else
          Result := True;
      End
      Else
      Begin
        Result := False;
      End;
    End;

    Close;
  End;

  strCodSerOld := edtCodSer.Text;
  fltValSerOld := fStrToFloat(edtValSer.Text);

  FreeAndNil(qryGenSer);
end;

function TfrmFatManConsertoEquip.fCondicaoPagamentoFinal: Boolean;
var
  frmDigCndPagamento: TfrmDigCndPagamento;
begin
  pCriarFormularios(TfrmDigCndPagamento, frmDigCndPagamento);
  Try
    frmDigCndPagamento.Caption := Self.Caption;

    strCcnAnt := objConEqu.strCodCnd;
    strFpgAnt := objConEqu.strCodFpg;
    strConPagAnt := objConEqu.strConPag;

    frmDigCndPagamento.fraDigCndPagamento.edtCodCnd.Text := objConEqu.strCodCnd;
    frmDigCndPagamento.fraDigCndPagamento.strCcnAnt      := objConEqu.strCodCnd;

    If Not fEmptyStr(objConEqu.strCodCnd) Then
      frmDigCndPagamento.fraDigCndPagamento.pCarregaCondicao;

    frmDigCndPagamento.fraDigCndPagamento.edtForPag.Text := objConEqu.strCodFpg;
    frmDigCndPagamento.fraDigCndPagamento.edtDesForPag.Text := fRetDesFpg(objConEqu.strCodFpg);

    frmDigCndPagamento.fraDigCndPagamento.mskCndPag.Text := objConEqu.strConPag;
    frmDigCndPagamento.fraDigCndPagamento.strCndPag      := objConEqu.strConPag;

    frmDigCndPagamento.ShowModal;

    Result := frmDigCndPagamento.fraDigCndPagamento.blnConfirma;

    if Result then
    begin
      edtCodCnd.Text := frmDigCndPagamento.fraDigCndPagamento.edtCodCnd.Text;
      pCarregaCondicao;
      edtForPag.Text := frmDigCndPagamento.fraDigCndPagamento.edtForPag.Text;
      mskCndPag.Text := frmDigCndPagamento.fraDigCndPagamento.strCndPag;

      Result := Result and fValidaCampos(edtCodCnd, True);
      Result := Result and fValidaCampos(edtForPag, True);
      Result := Result and fValidaCampos(mskCndPag, True); // Tem q validar por ultimo devido ao FblnManterPrecos

      if (not Result) and FblnSenhaIncorreta then
      begin
        objConEqu.strCodCnd := edtCodCnd.Text;
        objConEqu.strCodFpg := edtForPag.Text;
        objConEqu.strConPag := mskCndPag.Text;
      end;

    end;

  Finally
    pFreeAndNil(frmDigCndPagamento);
  End;
end;

function TfrmFatManConsertoEquip.fConfirmaDadosOS(blnAprovando: Boolean): Boolean;
begin
  If ( (objConEqu.cdsIteEqu.RecordCount = 0) And (objConEqu.cdsSerEqu.RecordCount = 0) ) Or
     ( (objConEqu.strStatus <> 'A') And (objConEqu.strStatus <> 'R') And (Not blnAprovando) ) Then
  Begin
    Result := True;
    Exit;
  End;

  if (objConEqu.strStatus = 'N') or (objConEqu.fPedidoJaFaturado) and  (InformarNFEntSaiAlterarObsOSRealizadaReprovada) then
  begin
    Result := True;
    Exit;
  end;

  if objConEqu.fTemItensEntrega then
  begin
    Try
      pCriarFormularios(TfrmFatDigMensagemOS, frmFatDigMensagemOS);
      frmFatDigMensagemOS.strCodTra := objConEqu.strCodTra;

      If (Not Assigned(objEmitirPedido)) Or (Not Assigned(objEmitirPedido.objFatVenda)) Then
        fInicializarFatVenda();

      objEmitirPedido.objFatVenda.strCodTra := objConEqu.strCodTra;
      objEmitirPedido.objFatVenda.strTipFre := IIF(not fEmptyStr(objConEqu.strTipFre), objConEqu.strTipFre, fCfgSis('TIPFRE'));
      objEmitirPedido.objFatVenda.strEspTra := objConEqu.strEspTra;
      objEmitirPedido.objFatVenda.fltValFre := objConEqu.fltValFre;
      objEmitirPedido.objFatVenda.fltFreDig := objConEqu.fltValFre;
      objEmitirPedido.objFatVenda.intQtdTra := objConEqu.intQtdTra;

      frmFatDigMensagemOS.fatVenda  := objEmitirPedido.objFatVenda;
      frmFatDigMensagemOS.ShowModal();

      Result := frmFatDigMensagemOS.blnConfirma;

      If (Result) Then
      Begin
        objConEqu.strCodTra := objEmitirPedido.objFatVenda.strCodTra;
        objConEqu.strTipFre := objEmitirPedido.objFatVenda.strTipFre;
        objConEqu.strEspTra := objEmitirPedido.objFatVenda.strEspTra;
        objConEqu.fltValFre := objEmitirPedido.objFatVenda.fltValFre;
        objConEqu.intQtdTra := objEmitirPedido.objFatVenda.intQtdTra;
      End;
    Finally
      FreeAndNil(frmFatDigMensagemOS);
    End;
  end
  Else
    Result := True;

  if (Result) then
  begin
    if fCfgSis('SLRCON', varBoolean) then
      Self.blnAprovando := True;
    try

      Try
        Result := fInicializarFatVenda();

        If Result Then
          pAtualizaTotais();

      Except
        Result := False;
        Raise;
      End;

    finally
      if fCfgSis('SLRCON', varBoolean) then
        Self.blnAprovando := False;
    end;
  end;
end;

function TfrmFatManConsertoEquip.pConsultaItem(strDescri, strCodBar, strCodFab: String): Boolean;
  Var
    objfrmPnl: TPanelCxItem;
    chrKey: Char;
    arrSel: TConsultasArray;
    sltItensAntesPesquisa: TStringList;

    function fItemAddPorTabPelaPrimeiraVez: Boolean;
       Var
         strCodIte: String;
    begin
      strCodIte := QuotedStr(objConEqu.cdsIteEqu.FieldByName('CODITE').AsString);
      Result := (Not fEstaNaLista(sltItensAntesPesquisa, strCodIte)) And
                (fEstaNaLista(sltItems, strCodIte));
    end;

    Function fStrTituloConsulta: String;
    Begin
      Result := 'Consulta de Itens - Conserto de Equipamentos.';
    end;

Begin
  Result := False;

  Try
    sltItensAntesPesquisa      := TStringList.Create;
    sltItensAntesPesquisa.Text := sltItems.Text;

    objfrmPnl := fInicializarObjFrmPnlItem();

    Try
      chrKey := '?';

      If fPesqItem(conIteSimples,
                  Self,
                  edtCodIte,
                  edtDesIte,
                  objConEqu.qryEquDet,
                  chrKey,
                  arrSel,
                  True,
                  objFrmPnl,
                  fStrTituloConsulta,
                  objConEqu.strTabPre,
                  objConEqu.strConPag,
                  0,      //objConEqu.fltTaxVpr
                  False,  //objConEqu.blnEmpFat
                  False,  //blnExiPar
                  0,
                  cdrCodIte,
                  '',     // strAplica: String
                  False,
                  objConEqu.strCodCli,
                  objConEqu.strCodVen,
                  True,   // blnMostrarPrecos
                  False,  // blnTablet
                  True,   // blnConsiderarExiLis
                  '',     // Codigo do Comprador
                  False,  // blnDepMatPriIndustrial
                  False,  // blnDepProAcaIndustrial
                  False,  // blnDepProEmbIndustrial
                  False,  // blnDepProGraIndustrial
                  False,  // blnVeioF11
                  False,  // blnSomenteAgrotoxico
                  False,  // blnMostrarItensDeServico
                  False,  // blnExibeColunaSaldoCD
                  '',     //fatVenda.strEmp_CD
                  0,      //fatVenda.fltDescFidelidade
                  True,   // blnFaturamento
                  strCodFab,
                  True,   // blnMostraSaldo
                  '',     // strFiltros
                  objConEqu.strCodEmp,
                  '',
                  strDescri,
                  strCodBar,
                  '',
                  True,
                  False) Then
      Begin
        If fItemAddPorTabPelaPrimeiraVez Then
        Begin
          btnCancelaItem.Click;
        End
        Else
        Begin
          Result := Not objConEqu.qryEquDet.IsEmpty;

          If (rdbCodIte.Checked) Or (not blnBuscarCodFab) Then
            edtCodIte.Text := objConEqu.qryEquDet.FieldByName('ITE_CODITE').AsString
          Else
            edtCodIte.Text := objConEqu.qryEquDet.FieldByName('ITE_CODFAB').AsString;

          If fValidaCampos(edtCodIte, True) Then
            SelectNext(ActiveControl, True, True);
        End;
      End
      Else
      Begin
        btnCancelaItem.Click;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmFatManConsertoEquip.fConsultaProdutosNova]');
      End;
    End;
  Finally
    FreeAndNil(objfrmPnl);
    FreeAndNil(sltItensAntesPesquisa);
  End;
end;

procedure TfrmFatManConsertoEquip.pControlaDigitacaoValoresFracionados(
  strCodUni: String);
begin
  if not fEmptyStr(strCodUni) then
  begin
    if fItemNaoFracionavel('PD',
                           strCodUni,
                           False,
                           Nil) then
      edtQtdIte.OnKeyPress := TProcEventos.pTravaValorFracionadoOnKeyPress
    else
      edtQtdIte.OnKeyPress := Nil;
  end;
end;

procedure TfrmFatManConsertoEquip.pDefinirStatusAnt;
begin
  If (fEmptyStr(objConEqu.strStaAnt)) Then
    objConEqu.strStaAnt := objConEqu.strStatus + objConEqu.strSubSta;
end;

function TfrmFatManConsertoEquip.fInicializarFatVenda(const blnLazyLoading: boolean = False): Boolean;
Var
  dadosItem      : TDadosProduto;
  dadosPedido    : TDadosPedido;
  strInfAdiTinta : String;
  strEmpAnt      : String;
  prcScroll      : TprcScroll;

  fltSaldoAtual: Double;
  strSemEst: String;
  blnPedSen: Boolean;
  blnSemEst: Boolean;

  procedure pAtualizarValoresIssFatVenda;
  begin
    //define a alíquota de ISS
    objEmitirPedido.objFatVenda.pDefineAliquotaIss();

    //atualiza os valores de ISS no record de serviços da fatVenda
    objEmitirPedido.objFatVenda.FRecSer.fltBasIss :=
      objConEqu.fltVlrSer * (1 - (objEmitirPedido.objFatVenda.fltRedIss / 100));

    objEmitirPedido.objFatVenda.FRecSer.fltValIss :=
      fCalculaValorIss(objEmitirPedido.objFatVenda.FRecSer.fltBasIss, objEmitirPedido.objFatVenda.fltPerIss);

    objEmitirPedido.objFatVenda.FRecSer.fltPerIss := objEmitirPedido.objFatVenda.fltPerIss;

    objEmitirPedido.objFatVenda.FRecSer.fltRedIss := objEmitirPedido.objFatVenda.fltRedIss;

    //atualiza os valores totais de ISS da fatVenda
    objEmitirPedido.objFatVenda.fltTotSer := objConEqu.fltVlrSer;

    objEmitirPedido.objFatVenda.fltBasIss :=
      objEmitirPedido.objFatVenda.fltTotSer * (1 - (objEmitirPedido.objFatVenda.fltRedIss / 100));

    objEmitirPedido.objFatVenda.fltValIss :=
      objEmitirPedido.objFatVenda.fltBasIss * (objEmitirPedido.objFatVenda.fltPerIss / 100);

    objEmitirPedido.objFatVenda.fltPerIss := objEmitirPedido.objFatVenda.fltPerIss;

    objEmitirPedido.objFatVenda.fltRedIss := objEmitirPedido.objFatVenda.fltRedIss;
  end;

  procedure pLimparValoresIpiST;
  begin
    objConEqu.fltValIpi := 0;
    objConEqu.fltValRet := 0;
    objConEqu.fltTotIpi := 0;
    objConEqu.fltTotRet := 0;
    objConEqu.fltValCbs := 0;
    objConEqu.fltValIbs := 0;
    objConEqu.fltVal_Is := 0;
    objConEqu.fltTotCbs := 0;
    objConEqu.fltTotIbs := 0;
    objConEqu.fltTotIs  := 0;
    pLimparDadosTribEquGer();
  end;

begin

  FillChar(dadosItem, SizeOf(dadosItem), #0);
  FillChar(dadosPedido, SizeOf(dadosPedido), #0);

  {Manter apenas 1 objeto em memória}
  If Not Assigned(objEmitirPedido) Then
    objEmitirPedido := TEmitirPedido.Create(Self);

  objEmitirPedido.blnCriaTmp := not fInTransaction();

  If (objConEqu.cdsIteEqu.RecordCount = 0) And (objConEqu.cdsSerEqu.RecordCount = 0) Then
  Begin

    Result := True;
    pLimparValoresIpiST();

    If Not fEmptyStr(objConEqu.strCodCli) Then
    Begin

      dadosPedido.strCodCli := objConEqu.strCodCli;
      Result := objEmitirPedido.fIniciarPedido(dadosPedido);

      {Após carregar o cliente na FatVenda, verifica se o checkbox
       "Venda Presencial?" será habilitado!}
      If (Result) Then
        pHabilitaChkVendaPresencial;

    End;

    Exit

  End;

  Try

    {Limpa "objEmitirPedido"}
    pLimparDadosCarregados;

    Try

      pDisableControls(objConEqu.cdsIteEqu, prcScroll);
      objConEqu.cdsIteEqu.First;

      pLimparValoresIpiST();

      strEmpAnt := VS_strCodEmp;

      dadosPedido.blnSfaPag    := False;
      dadosPedido.strEmpLogSfa := strEmpAnt;

      With dadosPedido Do
      Begin

        strCodCli := objConEqu.strCodCli;
        strCodVen := objConEqu.strCodVen;

        If blnUsaDig Then
          strCodDig := objConEqu.strCodDig
        Else
          strCodDig := strLoginUsuarioLogado;

        sfaStsPagto := sspBranco;
        strConPag := objConEqu.strConPag;
        strCodCnd := objConEqu.strCodCnd;
        strCodFpg := objConEqu.strCodFpg;
        fltDesEsp := objConEqu.fltDesEsp;
        strMen001 := '';
        strMen002 := '';
        strMenExp := '';
        strTipPed := IIF( (objConEqu.strSubSta = 'B'), 'B', 'A');
        strTipOpe := IIF( (objConEqu.strSubSta = 'B'), 'B', 'V' );
        strTipFre := '';
        strTabPre := objConEqu.strTabPre;
        strTipFin := 'P';
        strEntFat := 'S';
        strNumPok := '';
        dtaGraPed := VS_Date;
        dtaPreVis := VS_Date;
        dtaDtaOri := VS_Date;
        fltValFre := 0;
        strCodTra := '';
        dtaHorImp := 0;
        dtaDtaTra := 0;
        dtaHorTra := 0;
        strAutEnt := objConEqu.strEntGer;
        strEmp_CD := '';
        blnEnt_CD := False;
        dadosPedido.strCodTra := objConEqu.strCodTra;
        dadosPedido.intQtdTra := objConEqu.intQtdTra;
        dadosPedido.strEspTra := objConEqu.strEspTra;
        dadosPedido.fltValFre := objConEqu.fltValFre;
        dadosPedido.strTipFre := objConEqu.strTipFre;
        dadosPedido.blnVenPre := objConEqu.blnVenPre;
      End;

      Result := objEmitirPedido.fIniciarPedido(dadosPedido);

      If Result Then
      Begin
        objEmitirPedido.objFatVenda.blnConEqu := blnMarLuc;

        {Após carregar o cliente na FatVenda, verifica se o checkbox
         "Venda Presencial?" será habilitado!}
        pHabilitaChkVendaPresencial;
        if blnLazyLoading then
          Exit;

        objConEqu.cdsIteEqu.First;
        Result := (objConEqu.cdsIteEqu.RecordCount > 0) Or (objConEqu.cdsSerEqu.RecordCount > 0);

        While (Not objConEqu.cdsIteEqu.Eof) And (Result) Do
        Begin
          dadosItem.strNumLot := objConEqu.fRetArmazemPrincipal(VS_strCodEmp, objConEqu.cdsIteEqu.FieldByName('CODITE').AsString);
          dadosItem.strCodIte := objConEqu.cdsIteEqu.FieldByName('CODITE').AsString;
          dadosItem.strIdePro := 'NOR';
          dadosItem.strDesIte := objConEqu.cdsIteEqu.FieldByName('DESITE').AsString;
          dadosItem.fltQtdIte := objConEqu.cdsIteEqu.FieldByName('QTDITE').AsFloat;
          dadosItem.fltUnitar := objConEqu.cdsIteEqu.FieldByName('UNITAR').AsFloat;
          dadosItem.fltUniOri := objConEqu.cdsIteEqu.FieldByName('UNIORI').AsFloat;
          dadosItem.strEntRet := objConEqu.cdsIteEqu.FieldByName('ENTRET').AsString;
          dadosItem.strLocRet := objConEqu.cdsIteEqu.FieldByName('LOCRET').AsString;
          dadosItem.strMd5Key := '';
          dadosItem.strPromoc := 'N';
          dadosItem.blnBxSbIt := False;
          dadosItem.strTabIte := objConEqu.cdsIteEqu.FieldByName('TABPRE').AsString;
          dadosItem.strBrinde := objConEqu.cdsIteEqu.FieldByName('BRINDE').AsString;
          dadosItem.strEmpIte := IIF(objConEqu.blnMulLoj, objConEqu.cdsIteEqu.FieldByName('EMPITE').AsString, '');
          strInfAdiTinta := '';
          dadosItem.intSeqIte := objConEqu.cdsIteEqu.FieldByName('SEQITE').AsInteger;

          if blnAprovando then
          begin
            fltSaldoAtual := fRetornaSaldoDisponivel(
              dadosItem.strCodIte,
              False,
              True,
              dadosItem.strNumLot,
              False,
              VS_strCodEmp);

            objEmitirPedido.objfatVenda.strIdePro := dadosItem.strIdePro;

            objEmitirPedido.objfatVenda.fVerificaQtdEstoque(
              IIF(objConEqu.blnMulLoj, objConEqu.cdsIteEqu.FieldByName('EMPITE').AsString, VS_strCodEmp), // dadosItem.strEmpIte,
              objEmitirPedido.objFatVenda.strOpcDoc,
              'S',
              objEmitirPedido.objFatVenda.strNumOrc,
              '',
              dadosItem.strCodIte,
              '',//dadosItem.strCodAca,
              '',//dadosItem.strEmpAca,
              dadosItem.strDesIte,
              '',//strIteRet,
              '',//strIteFut,
              '',//strMotFut,
              dadosItem.fltQtdIte,
              0,
              0,
              fltSaldoAtual,
              False,
              strSemEst,
              False,
              blnPedSen,
              blnSemEst,
              dadosItem.recForTin,
              False,
              dadosItem.strNumLot,
              blnAprovacao);

            dadosItem.strSemEst := strSemEst;
          end;
          Result := Result And objEmitirPedido.fInserirProduto(dadosItem);

          objConEqu.cdsIteEqu.Edit();
          objConEqu.cdsIteEqu.FieldByName('CLTRIB').AsString := 'N';
          objConEqu.cdsIteEqu.Post();

          objConEqu.cdsIteEqu.Next;

        End;

        With dadosItem Do
        Begin
          strNumLot := '';
          strCodIte := fCfgSis('ITESER', varString);
          strIdePro := 'NOR';
          strDesIte := fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [fCfgSis('ITESER', varString)]);
          fltQtdIte := 1;
          fltUnitar := objConEqu.fltVlrSer;
          fltUniOri := objConEqu.fltVlrSer;
          strMd5Key := '';
          strPromoc := 'N';
          blnBxSbIt := False;
          strTabIte := objConEqu.cdsIteEqu.FieldByName('TABPRE').AsString;
          strEmpIte := IIF(objConEqu.blnMulLoj, objConEqu.strEmpSer, VS_strCodEmp);
          strInfAdiTinta := '';
        End;

        Result := Result And objEmitirPedido.fInserirProduto(dadosItem);

        //adicionar item de serviço
        objConEqu.pAtualizarDadosServicosFatVenda(objEmitirPedido.objFatVenda.FRecSer);
        pAtualizarValoresIssFatVenda();

        If Result Then
        Begin

          Result := objEmitirPedido.fCalcularTotais And
                    objEmitirPedido.fValidarPedido;

          If Result Then
          Begin

            If (objConEqu.strSubSta = 'B') Then
              objEmitirPedido.objFatVenda.strOpcDoc := 'BR';

            objEmitirPedido.objFatVenda.pCalculaTotGerInterna();
            objEmitirPedido.objFatVenda.pAtualizaTemporariaItens(cdsVenda);
            objEmitirPedido.objFatVenda.pAtualizarReformaTributariaNoCdsVenda;

            {Recupera dados calculados}
            pAtualizarTribEquGer();
            pAtualizarTribItensEquDet();

          End;

        End;

      End;

    Finally
      pEnableControls(objConEqu.cdsIteEqu, prcScroll);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TConEqu.fInicializarFatVenda');
    End;
  End;

end;

function TfrmFatManConsertoEquip.fInclusaoOrdemServico: Boolean;
begin
  Result := True;

  if lblNovaOrdem.Visible then
    Exit;

  if blnNovaOrdemServico then
    Exit;

  Result := False;
end;

function TfrmFatManConsertoEquip.fInicializarFatVenda(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := fInicializarFatVenda();
end;

procedure TfrmFatManConsertoEquip.pInicializarFatVenda;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    Try
      frmGravando.pgbStatus.Visible   := False;
      frmGravando.lblGravando.Caption := 'Calculando impostos do(s) produto(s)...';
      frmGravando.fExecutarAcao := fInicializarFatVenda;
      frmGravando.showModal;
      Self.Repaint();
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmFatManConsertoEquip.pInicializarFatVenda]');
        raise;
      End;
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmFatManConsertoEquip.pAtualizarTribEquGer;
  Var
    recTribEquGer: TTribEquGer;
begin
  If (Assigned(objEmitirPedido)) And (Assigned(objEmitirPedido.objFatVenda)) Then
  Begin
    recTribEquGer.fltBasSim := objEmitirPedido.objFatVenda.fltBasSim;
    recTribEquGer.fltBasIpi := objEmitirPedido.objFatVenda.fltBasIpi;
    recTribEquGer.fltAlqIpi := objEmitirPedido.objFatVenda.fltAlqIpi;
    recTribEquGer.fltTotIpi := objEmitirPedido.objFatVenda.fltTotIpi;
    recTribEquGer.fltBasIcm := objEmitirPedido.objFatVenda.fltBasIcm;
    recTribEquGer.fltAlqIcm := objEmitirPedido.objFatVenda.fltAlqIcm;
    recTribEquGer.fltTotIcm := objEmitirPedido.objFatVenda.fltTotIcm;
    recTribEquGer.fltTotRet := objEmitirPedido.objFatVenda.fltTotRet;
    recTribEquGer.fltTotCbs := objEmitirPedido.objFatVenda.fltTotCBS;
    recTribEquGer.fltTotIbs := objEmitirPedido.objFatVenda.fltTotIBS;
    recTribEquGer.fltTotIs  := objEmitirPedido.objFatVenda.fltTotIS;
    recTribEquGer.fltAlqRet := objEmitirPedido.objFatVenda.fltAlqRet;
    recTribEquGer.fltBasRet := objEmitirPedido.objFatVenda.fltBasRet;
    recTribEquGer.fltPerIss := objEmitirPedido.objFatVenda.fltPerIss;
    recTribEquGer.fltValIss := objEmitirPedido.objFatVenda.fltValIss;
    recTribEquGer.fltBasIss := objEmitirPedido.objFatVenda.fltBasIss;
    recTribEquGer.fltRedIss := objEmitirPedido.objFatVenda.fltRedIss;

    objConEqu.pAdicionarDadosFiscaisTotais(recTribEquGer);
  End;
end;

procedure TfrmFatManConsertoEquip.pAtualizarTribItensEquDet;
  Var
    recItem: TTribEquDet;
    prcScroll: TprcScroll;
begin
  If (Assigned(objEmitirPedido)) And (Assigned(objEmitirPedido.objFatVenda)) And
     ((cdsVenda <> nil)) And (cdsVenda.RecordCount > 0) Then
     Begin
    Try
      pDisableControls(cdsVenda, prcScroll);
      cdsVenda.First();

      objConEqu.fltTotIpi := 0;
      objConEqu.fltTotRet := 0;
      objConEqu.fltTotCbs := 0;
      objConEqu.fltTotIbs := 0;
      objConEqu.fltTotIs  := 0;
      objConEqu.fltVlrCon := 0;
      objConEqu.fltVlrPro := 0;

      While (Not cdsVenda.Eof) Do
      Begin
        If (fCfgSis('ITESER', varString) = cdsVenda.FieldByName('ITE_CODITE').AsString) Or
           (fCfgSis('SERTER', varString) = cdsVenda.FieldByName('ITE_CODITE').AsString) Then
        Begin
          cdsVenda.Next();
          Continue;
        End;

        recItem.strCodIte := cdsVenda.FieldByName('ITE_CODITE').AsString;

        If (cdsVenda.FieldByName('ITE_BRINDE').AsString = 'S') Then
        Begin
          recItem.strClaFis := objEmitirPedido.objFatVenda.arrMatItens[cdsVenda.RecNo - 1].strClaFis;
          recItem.strCodFis := objEmitirPedido.objFatVenda.arrMatItens[cdsVenda.RecNo - 1].strCodFis;
        End
        Else
        Begin
          recItem.strClaFis := cdsVenda.FieldByName('ITE_CLAFIS').AsString;
          recItem.strCodFis := cdsVenda.FieldByName('ABF_CODFIS').AsString;
        End;

        recItem.strIncPis := cdsVenda.FieldByName('ITE_INCPIS').AsString;
        recItem.fltValIpi := cdsVenda.FieldByName('ITE_VALIPI').AsFloat;
        recItem.fltAlqIpi := cdsVenda.FieldByName('ITE_ALQIPI').AsFloat;
        recItem.fltBasIpi := cdsVenda.FieldByName('ITE_BASIPI').AsFloat;
        recItem.fltValIcm := cdsVenda.FieldByName('ITE_VALICM').AsFloat;
        recItem.fltAlqIcm := cdsVenda.FieldByName('ITE_ALQICM').AsFloat;
        recItem.fltBasIcm := cdsVenda.FieldByName('ITE_BASICM').AsFloat;
        recItem.fltValRet := cdsVenda.FieldByName('ITE_VALRET').AsFloat;
        recItem.fltAlqRet := cdsVenda.FieldByName('ITE_ALQRET').AsFloat;
        recItem.fltBasRet := cdsVenda.FieldByName('ITE_BASRET').AsFloat;
        recItem.fltValCbs := cdsVenda.FieldByName('ITE_VALCBS').AsFloat;
        recItem.fltValIbs := cdsVenda.FieldByName('ITE_VALIBS').AsFloat;
        recItem.fltVal_Is := cdsVenda.FieldByName('ITE_VAL_IS').AsFloat;
        recItem.fltPerBas := cdsVenda.FieldByName('ITE_PERBAS').AsFloat;
        recItem.fltPerRed := cdsVenda.FieldByName('ITE_PERRED').AsFloat;
        recItem.fltVlrCon := (cdsVenda.FieldByName('ITE_TOTITE').AsFloat - cdsVenda.FieldByName('ITE_DESESP').AsFloat) +
                             cdsVenda.FieldByName('ITE_VALFRE').AsFloat +
                             cdsVenda.FieldByName('ITE_VALIPI').AsFloat +
                             cdsVenda.FieldByName('ITE_VALRET').AsFloat +
                             cdsVenda.FieldByName('ITE_DESACE').AsFloat;

        If fSomarNovosImpostosDaReformaAoValorContabil Then
          recItem.fltVlrCon := recItem.fltVlrCon + recItem.fltValCbs + recItem.fltValIbs + recItem.fltVal_Is;

        recItem.fltDesEsp := cdsVenda.FieldByName('ITE_DESESP').AsFloat;

        objConEqu.pAdicionarDadosFiscaisItem(recItem);

        objConEqu.fltTotIpi := objConEqu.fltTotIpi + objConEqu.fltValIpi;
        objConEqu.fltTotRet := objConEqu.fltTotRet + objConEqu.fltValRet;
        objConEqu.fltTotCbs := objConEqu.fltTotCbs + objConEqu.fltValCbs;
        objConEqu.fltTotIbs := objConEqu.fltTotIbs + objConEqu.fltValIbs;
        objConEqu.fltTotIs  := objConEqu.fltTotIs  + objConEqu.fltVal_Is;
        objConEqu.fltVlrCon := objConEqu.fltVlrCon + recItem.fltVlrCon;

        //objConEqu.fltVlrPro := objConEqu.fltVlrPro + recItem.fltVlrCon;
        objConEqu.fltVlrPro := objConEqu.fltVlrPro + (cdsVenda.FieldByName('ITE_TOTITE').AsFloat - cdsVenda.FieldByName('ITE_DESESP').AsFloat);

        cdsVenda.Next();
      End;

      objConEqu.fltVlrCon := objConEqu.fltVlrCon + objConEqu.fltVlrSer;
    Finally
      pEnableControls(cdsVenda, prcScroll);
    End;
  End;
end;

procedure TfrmFatManConsertoEquip.pLimparDadosCarregados;
begin

  If (Assigned(objEmitirPedido)) Then
  Begin

    {Limpa client da venda "Compartilhado via untFuncFat"}
    If (cdsVenda <> nil) Then
      cdsVenda.EmptyDataSet;

    If Assigned(objEmitirPedido.objFatVenda) Then
    Begin

      {Limpa array de produtos}
      SetLength(objEmitirPedido.objFatVenda.arrMatItens, 0);

      {Limpa record de serviços}
      FillChar(objEmitirPedido.objFatVenda.FRecSer, SizeOf(objEmitirPedido.objFatVenda.FRecSer), #0);

    End;

  End;

end;

procedure TfrmFatManConsertoEquip.pLimparDadosTribEquGer;
begin
  objConEqu.pLimparDadosFiscaisTotais();
end;

procedure TfrmFatManConsertoEquip.pLimparProdutosServicosImportados;
var
  intCont: Integer;
begin
  if stlCodIteImportado.Count <> 0 then
  begin
    for intCont := 0 to stlCodIteImportado.Count -1 do
    begin
      if objConEqu.cdsIteEqu.Locate('CODITE', stlCodIteImportado[intCont], []) then
        objConEqu.cdsIteEqu.Delete;
    end;
  end;

  if stlCodSerImportado.Count <> 0 then
  begin
    for intCont := 0 to stlCodSerImportado.Count -1 do
    begin
      if objConEqu.cdsSerEqu.Locate('CODSER', stlCodSerImportado[intCont], []) then
        objConEqu.cdsSerEqu.Delete;
    end;
  end;
end;

function TfrmFatManConsertoEquip.fProcessarRequisicaoCompra: Boolean;
Var
  cdsVendasSemEstoq : TUniClientDataSet;
  frmFatRequisicaoCompras : TfrmFatRequisicaoCompras;
  objLinha : TLinhaMsgLibera;
  objTabela: TRegistroMsgLiberaTabela;
begin

  Result := True;
  if not fCfgSis('SLRCON', varBoolean) then
    Exit;

  Try

    cdsVendasSemEstoq := TUniClientDataSet.Create(Self);
    pCriarFormularios(TfrmFatRequisicaoCompras, frmFatRequisicaoCompras);

    Try

      cdsVendasSemEstoq.Data       := cdsVenda.Data;
      cdsVendasSemEstoq.LogChanges := False;
      cdsVendasSemEstoq.Filtered   := False;
      cdsVendasSemEstoq.Filter     := ' (ITE_OPCABS <> ' + IntToStr(Integer(oaSolicitTransf)) + ') ';
      cdsVendasSemEstoq.Filtered   := True;

      While cdsVendasSemEstoq.Locate('ITE_PODALT', False, []) Do
        cdsVendasSemEstoq.Delete;

      While cdsVendasSemEstoq.Locate('ITE_CODITE', fCfgSis('ITESER'), []) Do
        cdsVendasSemEstoq.Delete;

      While cdsVendasSemEstoq.Locate('ITE_CODITE', fCfgSis('SERTER'), []) Do
        cdsVendasSemEstoq.Delete;

      While cdsVendasSemEstoq.Locate('ITE_CODITE', fCfgSis('ITEFRE'), []) Do
        cdsVendasSemEstoq.Delete;

      While cdsVendasSemEstoq.Locate('ITE_CODITE', fCfgSis('ITEBOM'), []) Do
        cdsVendasSemEstoq.Delete;

      While cdsVendasSemEstoq.Locate('ITE_CODITE', fCfgSis('ITETAX'), []) Do
        cdsVendasSemEstoq.Delete;

      If (Not cdsVendasSemEstoq.IsEmpty) Then
      Begin
        frmFatRequisicaoCompras.strCodUsu                  := IIF(blnUsaDig, objConEqu.strCodDig, objConEqu.strCodVen);
        frmFatRequisicaoCompras.edtCodigo.ReadOnly         := True;
        frmFatRequisicaoCompras.edtCodCli.Text             := objConEqu.strCodCli;
        frmFatRequisicaoCompras.edtCodCli.ReadOnly         := True;
        frmFatRequisicaoCompras.edtNomCli.Text             := objConEqu.strCliNom;
        frmFatRequisicaoCompras.edtSenVen.Text             := fRetSenhaVendedor(objConEqu.strCodVen);
        frmFatRequisicaoCompras.edtNomVen.Text             := fRetNomVendRep(objConEqu.strCodVen);
        frmFatRequisicaoCompras.edtCodIte.ReadOnly         := True;
        frmFatRequisicaoCompras.blnVaiGravarComFaturamento := True;
        frmFatRequisicaoCompras.cdsVenda                   := cdsVendasSemEstoq;
        if fRequisicaoCompraVinculada then
          frmFatRequisicaoCompras.strCodigo                  := fCampoTabela('RCG_CODIGO', 'MOVRCG', ['AUTOINCREM'], [qryFatgor.FieldByName('FGO_INRQCP').AsString]);
        frmFatRequisicaoCompras.strNumOrc                  := objConEqu.strNumPed;
        frmFatRequisicaoCompras.strCodVen                  := objConEqu.strCodVen;
        frmFatRequisicaoCompras.strCodCnd                  := objConEqu.strCodCnd;
        frmFatRequisicaoCompras.strCodFpg                  := objConEqu.strCodFpg;

        if (not objConEqu.blnResSal) then
          frmFatRequisicaoCompras.blnReqTudo := True;

        frmFatRequisicaoCompras.blnConEqu := True;
        frmFatRequisicaoCompras.ShowModal();

        Result := frmFatRequisicaoCompras.blnConfirma;

        If Result Then
        begin
          pCloneDataSet(objConEqu.cdsMovRcd, frmFatRequisicaoCompras.cdsConsulta);
          if fRequisicaoCompraVinculada then
            objConEqu.strInRqCp := qryFatgor.FieldByName('FGO_INRQCP').AsString
          else
            objConEqu.strInRqCp := '';
        end
        Else If Not objEmitirPedido.objFatVenda.cdsMovRcd.isEmpty then
        Begin
          Try
            objEmitirPedido.objFatVenda.cdsMovRcd.Filtered := False;
            objEmitirPedido.objFatVenda.cdsMovRcd.Filter   := 'RCD_SEQCOT = '''' AND RCD_SEQPCD = ''''';
            objEmitirPedido.objFatVenda.cdsMovRcd.Filtered := True;

            While Not objEmitirPedido.objFatVenda.cdsMovRcd.IsEmpty Do
              objEmitirPedido.objFatVenda.cdsMovRcd.Delete;

          Finally
            objEmitirPedido.objFatVenda.cdsMovRcd.Filtered := False;
            objEmitirPedido.objFatVenda.cdsMovRcd.Filter   := '';
          End;
        End;

        if (not Result) and (fCfgSis('LBSRCP',varBoolean)) then
        begin
          objTabela := TRegistroMsgLiberaTabela.Create;
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlCabecalho;
          objLinha.pAddColuna('', 'ITEM'      , fTamCodIte , alEsquerda, teAutcom);
          objLinha.pAddColuna('', 'DESCRIÇÃO' , 50, alEsquerda, teAutcom);
          objLinha.pAddColuna('', 'QUANTIDADE', 10, alDireita , teAutcom);
          objTabela.lstLinhas.Add(objLinha);

          cdsVendasSemEstoq.First;
          while not cdsVendasSemEstoq.Eof do
          begin
            objLinha  := TLinhaMsgLibera.Create;
            objLinha.enuTipoLinha := tlValor;
            objLinha.pAddColuna('ITEM'      , cdsVendasSemEstoq.FieldByName('ITE_CODITE').AsString                                                        , fTamCodIte , alEsquerda );
            objLinha.pAddColuna('DESCRIÇÃO' , cdsVendasSemEstoq.FieldByName('ITE_DESITE').AsString                                                        , 50, alEsquerda );
            objLinha.pAddColuna('QUANTIDADE', FloatToStrf(cdsVendasSemEstoq.FieldByName('ITE_QTDITE').AsFloat, ffFixed, 11, fCfgSis('DECQTD', varInteger)), 10, alDireita  );
            objTabela.lstLinhas.Add(objLinha);
            cdsVendasSemEstoq.Next;
          end;

          objLiberacao.Clear;
          objLiberacao.strDirAce := 'SLRQCE';
          objLiberacao.strMsgSen := 'Liberação da requisição de compra para produtos sem saldo de estoque - Conserto de Equipamentos';
          objLiberacao.strCodOpe := strLoginUsuarioLogado;
          objLiberacao.strCliente := edtCodCli.Text + '-' + edtNomCli.Text;
          objLiberacao.strCpfCnpj := objConEqu.strCliCgc;
          objLiberacao.objMsgLibera.pAddTexto('APROVAÇÃO DE ORDEM DE SERVIÇO SEM REQUISIÇÃO DE COMPRA. ');
          objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
          objLiberacao.objMsgLibera.pAddQuebra(teAmbos);
          Result := objEmitirPedido.objFatVenda.fFatMensagemLiberacao(objLiberacao);
        end;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmFatManConsertoEquip.fProcessarRequisicaoCompra]');
    End;
  Finally
    pFreeAndNil(frmFatRequisicaoCompras);
    pFreeAndNil(cdsVendasSemEstoq);
  End;

end;

function TfrmFatManConsertoEquip.fEhAnaliseTecnica: Boolean;
begin
  Result := False;

  if (not blnFluxoProcesso) then
    Exit;

  if (tpProcessoFlx <> tprDefPrdSer) then
    Exit;

  Result := True;
end;

function TfrmFatManConsertoEquip.fEhEtapaOrcamento: Boolean;
begin
  Result := False;

  if (not blnFluxoProcesso) then
    Exit;

  if (tpProcessoFlx <> tprOrcamento) then
    Exit;

  Result := True;
end;

function TfrmFatManConsertoEquip.fEhFluxoDadosOS: Boolean;
begin
  Result := False;

  if (not blnFluxoProcesso) then
    Exit;

  if (tpProcessoFlx <> tprDadosOS) then
    Exit;

  Result := True;
end;

function TfrmFatManConsertoEquip.fEnviarWhatsappBaixaOS: Boolean;
begin
  Result := True;

  if (not blnFluxoProcesso) then
    Exit;

  if (tpProcessoFlx = tprArmazenar) then
    Exit;

  if (objConEqu.strStatus = 'R') then
    Exit;

  Result := False;
end;

function TfrmFatManConsertoEquip.fExecutarAcaoAbreManutencao(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := fAbreManutencao(VS_strCodEmp);
end;

function TfrmFatManConsertoEquip.fAbreManutencaoComTelaProgressBar: Boolean;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    pgbStatus := frmGravando.pgbStatus;
    frmGravando.pgbStatus.Visible   := False;
    frmGravando.lblGravando.Caption := 'Aguarde, Carregando Ordem de Serviço...';
    frmGravando.fExecutarAcao := fExecutarAcaoAbreManutencao;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;
  Finally
    FreeAndNil(frmGravando);
  End;
end;

function TfrmFatManConsertoEquip.fAguardandoPecas: Boolean;
var
  strCodRcd, strEmpRcd: String;
  blnLiberouTrava: Boolean;
  qryFGOEQU: TUniQuery;
begin
  Result := False;

  qryFGOEQU := fCriaQuery(Self);

  try
    qryFGOEQU.Close;
    qryFGOEQU.SQL.Text := SELECT_PD_EQUGOR;
    qryFGOEQU.ParamByName('SEQEQU').AsString := objConEqu.strAutInc;
    qryFGOEQU.Open;

    if (not qryFGOEQU.IsEmpty) then
    begin
      while not qryFGOEQU.Eof do
      begin
        if (TConEqu.VerificaPedidoComRequisicaoEmAbertoComPedidoDeCompra(qryFGOEQU.FieldByName('NUMDOC').AsString, 'PD',
            qryFGOEQU.FieldByName('CODEMP').AsString, strCodRcd, strEmpRcd, blnLiberouTrava, False)) or
          (TConEqu.VerificaPedidoComRequisicaoEmAbertoSemPedidoDeCompra(qryFGOEQU.FieldByName('NUMDOC').AsString, 'PD',
            qryFGOEQU.FieldByName('CODEMP').AsString, strCodRcd, strEmpRcd)) then
        begin
          Result := True;
          Exit;
        end;

        qryFGOEQU.Next;
      end;
    end
    else
      Result := (TConEqu.VerificaPedidoComRequisicaoEmAbertoComPedidoDeCompra(objConEqu.strNumPed, 'PD', objConEqu.strEmpPed, strCodRcd, strEmpRcd, blnLiberouTrava, False)) or
        (TConEqu.VerificaPedidoComRequisicaoEmAbertoSemPedidoDeCompra(objConEqu.strNumPed, 'PD', objConEqu.strEmpPed, strCodRcd, strEmpRcd));
  finally
    FreeAndNil(qryFGOEQU);
  end;
end;

function TfrmFatManConsertoEquip.fAlterouCndFpg: Boolean;
begin
  if fCfgSis('EQUCND', varString) = 'I' then
    Result := ((edtCodCnd.Text <> strCcnAnt) And (strCcnAnt <> '')) Or ((strFpgAnt <> edtForPag.Text) And (strFpgAnt <> ''))
  else
    Result := (edtCodCnd.Text <> strCcnAnt) Or (strFpgAnt <> edtForPag.Text);
end;

function TfrmFatManConsertoEquip.fRecalcular: Boolean;
begin
  if fCfgSis('EQUCND', varString) = 'I' then
    Result := fCfgSis('OSTCND', varBoolean)
  else
  begin
    if (strCcnAnt = '') then
      Result := ((fRetTaxJur <> 0) or (fRetPerDes <> 0))
    else
      Result := ((fRetTaxJur <> fRetTaxJur(strCcnAnt, strConPagAnt)) or (fRetPerDes <> fRetPerDes(strCcnAnt)));
  end;
end;

function TfrmFatManConsertoEquip.fObterLotePrincipalGarantia(const strCodEqu: String): String;
Var
 LobjCadLot : TCadLot;
 strCodIte: String;
begin
  LobjCadLot := NIL;
  if Not fUsaRotinaWMS then
    Exit(EmptyStr);
 
  strCodIte := qryCadEqu.FieldByName('EQU_CODITE').AsString;
  Try
    LobjCadLot := TCadLot.Create(Self);
    if LobjCadLot.fExisteLotePrincipalGarantia(strCodIte, VS_strCodEmp)  then
    begin
      Result := LObjCadLot.fRetArmazemPrincipalGarantia(strCodIte);
    end
    else begin
      if LObjCadLot.fGeraLotePrincipalGarantiaWMS(strCodIte, VS_StrCodEmp) then
        Result := fObterLotePrincipalGarantia(strCodEqu);
    end;
  Finally
    LobjCadLot.Free;
  End;
end;

function TfrmFatManConsertoEquip.fGeraExcel(pgbProgresso: TcxProgressBar): Boolean;
var
  objGeraExcelOS: TGeraExcelOS;
begin
  inherited;
  objGeraExcelOS := TGeraExcelOS.Create(pgbProgresso);

  try
    objGeraExcelOS.objConEqu := objConEqu;
    strNomArqExcel := objGeraExcelOS.fGeraExcel;
    Result := (not fEmptyStr(strNomArqExcel));
  finally
    FreeAndNil(objGeraExcelOS);
  end;
end;

End.
