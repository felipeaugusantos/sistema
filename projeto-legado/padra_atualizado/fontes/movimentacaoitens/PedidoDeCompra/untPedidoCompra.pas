{**********************************}
{* qryConFor     -> CADFOR        *}
{* qryConIte     -> CADITE        *}
{* qryConGer     -> ITEGER        *}
{* qryIteCon     -> Consulta Item *}
{*******************************MV*}
unit untPedidoCompra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, DBCtrls,
  DBEditFocus, Grids, DBGridCitel, DBGrids, Mask, MaskEditFocus, EditFocus, Uni,
  UniClientDataSet, DB, Math, StrUtils, UniDataSetProvider, ComObj, cxProgressBar,
  MemoFocus, untFuncoesSimples, BitBtnLockedIncrem,
  DateUtils, untTypesSistema, frxClass, frxExportCSVTestabilidade,
  untFuncoesPedidoSimples, untZClient, untPanelCxItem,
  untPnlDadosItem, untCdsDigMultLoja, DBMemoFocus, untMostraObsFornecedor,
  untCreditosFornecedor, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxCurrencyEdit, cxImageComboBox, System.ImageList, Vcl.ImgList,
  cxColorComboBox, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnPopup,
  untRecuperaPedido, untDuplicatasPedidoCompra, cxDropDownEdit, untPedeEmpOrigem,
  untPreparaTEPedidoCompra, untGravacaoPedido, untRequisicaoPedidoCompra,
  Datasnap.DBClient, UITypes, untMostraLegendasItem, untLegendasItem,
  untFuncoesPedido, untGravando, untLayoutImportacaoPedidoCompra,
  cxGridDBDataDefinitions, cxDataControllerConditionalFormattingRulesManagerDialog, cxCheckBox,untDigData,
  untConfiguraImpressaoPedidoCompra,
  unConsultaVeiculos,    cxGridDBBandedTableView,
  untResumoQuantidadeVendasPerdidas,
  cxLabel, cxGridCitel, MaskUtils,
  untDecideDesconto,
  untCfgGrid,
  ComCtrls;

const
  DESCONTO1 = 0;
  DESCONTO2 = 1;
  DESCONTO3 = 2;
  DESCONTO4 = 3;
  DESCONTO5 = 4;
  DESCONTO6 = 5;

Type
  TarrDescontosFornecedor = array[0..5] of Double;

  TRecDescontoItem = Record
    fltDesAdi: Double;
    intDecUni: Integer;
    arrDesUni: TarrDescontosFornecedor;
    constructor Create(pDesAdi: Double; pDecUni: Integer);
    procedure pInicializar;
    function fCalcularFatorDesconto(ASomaDescontoAdicionaFornec1: Boolean): Double;
    function fCalcularValorDescontado(ASomaDescontoAdicionaFornec1: Boolean; pValorNominal: Double): Double;
    function fCalcularPercentualDesconto(ASomaDescontoAdicionaFornec1: Boolean): Double;
  end;


type
  TRecValidadorCmpMlt = record
  private

    FstrCodIte: String;
    FfltQtdIte,
    FfltMltCom: Double;
    FblnLiberado: Boolean;
    FstrCMPMLT: String;
  public
    constructor Create(pstrCMPMLT: String);
    procedure pInicializar;
    function fLiberado(pstrCodIte: String; pfltQtdIte, pfltMltCom: Double; pblnLibSen: Boolean = True): Boolean;
  end;

type
  TPosicaoRegistro = record
    intRecordIndex,
    intPosition: Integer;
  end;

  TPosicaoRegistroPrt = ^TPosicaoRegistro;

  TMycxGridDBTableView = class (TcxGridDBTableView)
  protected
    function GetDataControllerClass: TcxCustomDataControllerClass; override;
  end;

  TMycxGridDBDataController = class (TcxGridDBDataController)
  Private

     Procedure SetOrdenar(Value: Boolean);
     Function GetOrdenar: Boolean;

  protected

    function CreateDataControllerInfo: TcxCustomDataControllerInfo; override;
  property
    blnOrdenar: Boolean Read GetOrdenar Write SetOrdenar;
  end;

  TMycxCustomDataControllerInfo = class (TcxCustomDataControllerInfo)
  protected
    procedure DoSort; override;
  public
    blnOrdenar: Boolean;
  end;

  TcxGridDBTableView = class (TMycxGridDBTableView);

  TfrmPedidoDeCompra = class(TfrmPai)
    pnlGeral: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblQtdCtn: TLabel;
    lblEdicao: TLabel;
    lblEmpDestino: TLabel;
    Label21: TLabel;
    edtCodFor: TEditFocus;
    mskDtaPed: TMaskEditFocus;
    mskCndPag: TMaskEditFocus;
    edtNomFor: TEditFocus;
    chkPedImp: TCheckBox;
    edtQtdCtn: TEditFocus;
    edtNumPed: TEditFocus;
    edtEmpDestino: TEditFocus;
    edtDesAdi: TEditFocus;
    Panel4: TPanel;
    lblTotIpi: TLabel;
    Label16: TLabel;
    lblTotGer: TLabel;
    lblLitragem: TLabel;
    lblTotSubRod: TLabel;
    dtsItensPedido: TDataSource;
    dbeTotIte: TDBEdit;
    dbeTotSub: TDBEdit;
    dbeTotIpi: TDBEdit;
    lblTotCBS: TLabel;
    lblTotIBS: TLabel;
    lblTotIS: TLabel;
    dbeTotCBS: TDBEdit;
    dbeTotIBS: TDBEdit;
    dbeTotIS: TDBEdit;
    dbeTotLit: TDBEdit;
    Label26: TLabel;
    dbeTotPes: TDBEdit;
    lblDiaCom: TLabel;
    OpenFile: TOpenDialog;
    chkPedInt: TCheckBox;
    Label28: TLabel;
    mskDtaFat: TMaskEditFocus;
    dtsItensGiro: TDataSource;
    dtsItensMlj: TDataSource;
    edtNomCmp: TEditFocus;
    edtCodCmp: TEditFocus;
    chkPgAVis: TCheckBox;
    btnEditarItem: TBitBtnLocked;
    btnPedidosPend: TBitBtnLocked;
    btnEstoque: TBitBtnLocked;
    btnApaga: TBitBtnLocked;
    btnLitragem: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnSimilares: TBitBtnLocked;
    btnGarantiaPend: TBitBtnLocked;
    btnEmbalagem: TBitBtnLocked;
    btnResumoLoja: TBitBtnLocked;
    chkPedBon: TCheckBox;
    btnMaisInf: TBitBtnLocked;
    chkCnvEmb: TCheckBox;
    pnlRedimensiona: TPanel;
    splAplicacao: TSplitter;
    btnLitragemPorUnidade: TBitBtnLocked;
    lblCreFor: TLabel;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    btnDocSalRes: TBitBtnLocked;
    btnTranEst: TBitBtnLocked;
    btnCotAbe: TBitBtnLocked;
    btnImporta: TBitBtnLocked;
    btnInfPedidoDeVendas: TBitBtnLocked;
    btnAltTabPre: TBitBtnLocked;
    popMaisInfo: TPopupMenu;
    mnuFormacaodePrecos: TMenuItem;
    mnuPedidodeComprasGrid: TMenuItem;
    mnuConsultadePedidodeCompras: TMenuItem;
    pnlItensFixo: TPanel;
    pnlItens: TPanel;
    pnlComum: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    btnTodIte: TSpeedButton;
    lblEmpGir: TLabel;
    lblEmbala: TLabel;
    Label15: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    edtCodUni: TEditFocus;
    edtQtdIte: TEditFocus;
    edtUnitar: TEditFocus;
    edtValTot: TEditFocus;
    rdbCodIte: TRadioButton;
    rdbCodFab: TRadioButton;
    edtSigUni: TEditFocus;
    edtDesUni: TEditFocus;
    edtDesUn2: TEditFocus;
    edtUniLiq: TEditFocus;
    mmoEmpGir: TMemoFocus;
    edtEmbala: TEditFocus;
    edtDesUn3: TEditFocus;
    edtDesUn4: TEditFocus;
    edtDesUn5: TEditFocus;
    edtDesUn6: TEditFocus;
    pnlPedNor: TPanel;
    lbl12: TLabel;
    lbl13: TLabel;
    lblPerSub: TLabel;
    lblTotSub: TLabel;
    edtPerIpi: TEditFocus;
    edtTotIpi: TEditFocus;
    edtPerSub: TEditFocus;
    edtTotSub: TEditFocus;
    pnlImportacao: TPanel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lblPerCof: TLabel;
    lbl11: TLabel;
    edtPerImp: TEditFocus;
    edtTotImp: TEditFocus;
    edtPerIpiImp: TEditFocus;
    edtTotIpiImp: TEditFocus;
    edtPerPis: TEditFocus;
    edtTotPis: TEditFocus;
    edtPerCof: TEditFocus;
    edtTotCof: TEditFocus;
    pnlReforma: TPanel;
    lblAlqCbs: TLabel;
    lblValCbs: TLabel;
    lblAlqIbs: TLabel;
    lblValIbs: TLabel;
    lblAlq_Is: TLabel;
    lblVal_Is: TLabel;
    edtAlqCbs: TEditFocus;
    edtValCbs: TEditFocus;
    edtAlqIbs: TEditFocus;
    edtValIbs: TEditFocus;
    edtAlq_Is: TEditFocus;
    edtVal_Is: TEditFocus;
    pnlAdicionar: TPanel;
    btnInsPla: TSpeedButton;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    ComposicaodeCusto: TMenuItem;
    Label17: TLabel;
    Label18: TLabel;
    edtTotFre: TEditFocus;
    edtTotDes: TEditFocus;
    lblDatEnt: TLabel;
    lblDiaEnt: TLabel;
    mskDtaEnt: TMaskEditFocus;
    edtDiaEnt: TEditFocus;
    lblTitDig: TLabel;
    edtCodDig: TEditFocus;
    edtNomDig: TEditFocus;
    mnuCompraAntiga: TMenuItem;
    edtTotGer: TEditFocus;
    pnlGrid: TPanel;
    cxgItens: TcxGrid;
    cxvItens: TcxGridDBTableView;
    cxvItensCORMED: TcxGridDBColumn;
    cxvItensNVLGIR: TcxGridDBColumn;
    cxvItensCODITE: TcxGridDBColumn;
    cxvItensCODFAB: TcxGridDBColumn;
    cxvItensDESITE: TcxGridDBColumn;
    cxvItensDESMAR: TcxGridDBColumn;
    cxvItensQTDITE: TcxGridDBColumn;
    cxvItensSALDIS: TcxGridDBColumn;
    cxvItensSIGUNI: TcxGridDBColumn;
    cxvItensLITROS: TcxGridDBColumn;
    cxvItensUNITAR: TcxGridDBColumn;
    cxvItensTOTITE: TcxGridDBColumn;
    cxvItensPERIPI: TcxGridDBColumn;
    cxvItensTOTIPI: TcxGridDBColumn;
    cxvItensALQCBS: TcxGridDBColumn;
    cxvItensVALCBS: TcxGridDBColumn;
    cxvItensALQIBS: TcxGridDBColumn;
    cxvItensVALIBS: TcxGridDBColumn;
    cxvItensALQ_IS: TcxGridDBColumn;
    cxvItensVAL_IS: TcxGridDBColumn;
    cxvItensTOTSUB: TcxGridDBColumn;
    cxvItensDESUNI: TcxGridDBColumn;
    cxvItensDESUN2: TcxGridDBColumn;
    cxvItensDESUN3: TcxGridDBColumn;
    cxvItensDESUN4: TcxGridDBColumn;
    cxvItensDESUN5: TcxGridDBColumn;
    cxvItensDESUN6: TcxGridDBColumn;
    cxvItensUNILIQ: TcxGridDBColumn;
    cxvItensCLAIPI: TcxGridDBColumn;
    cxvItensCOSDIT: TcxGridDBColumn;
    cxvItensDIAEST: TcxGridDBColumn;
    cxvItensDIASUG: TcxGridDBColumn;
    cxgItensLevel1: TcxGridLevel;
    cxvItensINCIRQ: TcxGridDBColumn;
    btnAltTra: TBitBtnLocked;
    cxvItensDTAENT: TcxGridDBColumn;
    cxvItensQTDTRA: TcxGridDBColumn;
    cxvItensQTDREQ: TcxGridDBColumn;
    cxvItensPERSUB: TcxGridDBColumn;
    cxvItensUNIIMP: TcxGridDBColumn;
    cxvItensTIPABS: TcxGridDBColumn;
    cxvItensVNOLCD: TcxGridDBColumn;
    btnTrocaPedido: TBitBtnLocked;
    btnDtaEnt: TBitBtnLocked;
    mnuCadastrodeProdutos: TMenuItem;
    lblIcmDes: TLabel;
    edtIcmDes: TEditFocus;
    cxvItensVALICM: TcxGridDBColumn;
    lblTotDeson: TLabel;
    dbdTotDeson: TDBEdit;
    lblLegQtdTra: TLabel;
    Label13: TLabel;
    lblDesPis: TLabel;
    edtDesPis: TEditFocus;
    lblTotDesPis: TLabel;
    dbeDESPIS: TDBEdit;
    cxvItensBAINOT: TcxGridDBColumn;
    btnSimGir: TBitBtnLocked;
    lblOcultarDadosGeraisDoPedido: TLabel;
    shpReqCompra: TShape;
    lblRecCompraLegenda1: TLabel;
    lblRecCompraLegenda2: TLabel;
    Label23: TLabel;
    chkSuspOrdem: TCheckBox;
    chkPreDol: TCheckBox;
    mnuEntregasFuturasPendentes: TMenuItem;
    Label24: TLabel;
    edtSubFCP: TEditFocus;
    dbeSubFCP: TDBEdit;
    Label25: TLabel;
    cxvItensQTDALT: TcxGridDBColumn;
    mnuPreparaesdeTEdoPedido: TMenuItem;
    rdgDesPdi: TRadioGroup;
    cxvItensPrinc: TcxGridDBColumn;
    cxvItensCORSIT: TcxGridDBColumn;
    cxvItensDESSIT: TcxGridDBColumn;
    lblLegendas: TLabel;
    cxvItensTEMREQ: TcxGridDBColumn;
    edtPraval: TEditFocus;
    Label19: TLabel;
    cxvItensPRAVAL: TcxGridDBColumn;
    tmrAtualizaRodape: TTimer;
    lblValDar: TLabel;
    edtValDar: TEditFocus;
    cxvItensVALDAR: TcxGridDBColumn;
    cxvItensREFERE: TcxGridDBColumn;
    rdgCodigoFabricaProduto: TRadioGroup;
    Lotesdoitem1: TMenuItem;
    btnQuantidadeVendasPerdidas: TBitBtnLocked;
    cxvItensFORPRI: TcxGridDBColumn;
    cxvItensDEPART: TcxGridDBColumn;
    btnCarregaPedidosVenda: TBitBtnLocked;
    pnlContainerGiroAplica: TPanel;
    pnlAplicacao: TPanel;
    splVeiculos: TSplitter;
    pnlTitAplic: TPanel;
    dbeAplica: TDBMemoFocus;
    cxVeiculoProduto: TcxGrid;
    cxVeiculoProdutoView: TcxGridDBTableView;
    cxVeiculosProdutoDESMAR: TcxGridDBColumn;
    cxVeiculosProdutoDESMOD: TcxGridDBColumn;
    cxVeiculosProdutoANOINI: TcxGridDBColumn;
    cxVeiculosProdutoANOFIN: TcxGridDBColumn;
    cxVeiculosProdutoCOMBUS: TcxGridDBColumn;
    cxVeiculosProdutoVALVUL: TcxGridDBColumn;
    cxVeiculosProdutoCILIND: TcxGridDBColumn;
    cxVeiculosProdutoPOTENC: TcxGridDBColumn;
    cxVeiculoProdutoOBSERV: TcxGridDBColumn;

    Panel1: TPanel;
    btnCfgGri: TBitBtnLocked;
    cxvItensDESGRU: TcxGridDBColumn;
    GroupBox1: TGroupBox;
    lblExiApli: TLabel;
    lblOpcGir: TLabel;
    lblExiGiro: TLabel;
    cxvItensDESSIM: TcxGridDBColumn;
    cxvItensNUMERO: TcxGridDBColumn;
    cxVeiculoProdutoLevel1: TcxGridLevel;
    pnlGiro: TPanel;
    splGiro: TSplitter;
    cxvItensDIFPRE: TcxGridDBColumn;
    cxvItensDTAULT: TcxGridDBColumn;
    chkZeraST: TCheckBox;
    Kardex: TMenuItem;
    mnAbrirKardex: TMenuItem;
    mnConfiguraKardex: TMenuItem;
    chkPagamentoCartaoCredito: TCheckBox;
    mnuRelEmprestimos: TMenuItem;
    lblCodSolicitacaoVinculada: TLabel;
    edtCodSolicitacaoVinculada: TEditFocus;
    mnuVisImg: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure chkPedImpClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnEstoqueClick(Sender: TObject);
    procedure btnPedidosPendClick(Sender: TObject);
    procedure btnApagaClick(Sender: TObject);
    procedure btnEditarItemClick(Sender: TObject);
    procedure rdbCodFabClick(Sender: TObject);
    procedure rdbCodIteClick(Sender: TObject);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtQtdIteExit(Sender: TObject);
    procedure edtQtdIteEnter(Sender: TObject);
    procedure edtDesAdiExit(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnLitragemClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnInsPlaClick(Sender: TObject);
    procedure btnSimilaresClick(Sender: TObject);
    procedure btnGarantiaPendClick(Sender: TObject);
    procedure splAplicacaoCanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure edtCodUniExit(Sender: TObject);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure chkPgAVisClick(Sender: TObject);
    procedure btnEmbalagemClick(Sender: TObject);
    procedure edtDesAdiEnter(Sender: TObject);
    procedure btnResumoLojaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lblExiApliClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnTodIteClick(Sender: TObject);
    procedure chkPedImpEnter(Sender: TObject);
    procedure btnLitragemPorUnidadeClick(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodCmpExit(Sender: TObject);
    procedure lblCreForClick(Sender: TObject);
    procedure cxvItensDblClick(Sender: TObject);
    procedure cxgItensEnter(Sender: TObject);
    procedure cxgItensExit(Sender: TObject);
    procedure btnDocSalResClick(Sender: TObject);
    procedure btnTranEstClick(Sender: TObject);
    procedure btnCotAbeClick(Sender: TObject);
    procedure btnInfPedidoDeVendasClick(Sender: TObject);
    procedure btnAltTabPreClick(Sender: TObject);
    procedure mnuFormacaodePrecosClick(Sender: TObject);
    procedure btnMaisInfClick(Sender: TObject);
    procedure mnuPedidodeComprasGridClick(Sender: TObject);
    procedure mnuConsultadePedidodeComprasClick(Sender: TObject);
    procedure chkPedBonClick(Sender: TObject);
    procedure chkPedIntClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure cxvItensQTDITEPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvItensQTDITEPropertiesEditValueChanged(Sender: TObject);
    procedure ComposicaodeCustoClick(Sender: TObject);
    procedure pMostraComposicaoPrecoCusto(strCodIte: String);
    procedure mskDtaFatEnter(Sender: TObject);
    procedure mskDtaFatExit(Sender: TObject);
    procedure mnuCompraAntigaClick(Sender: TObject);
    procedure cxvItensCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnAltTraClick(Sender: TObject);
    procedure cxvItensInitEdit(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit);
    procedure btnImportaClick(Sender: TObject);
    procedure cxvItensQTDITECustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure edtCodIteKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtPerSubEnter(Sender: TObject);
    procedure btnTrocaPedidoClick(Sender: TObject);
    procedure btnDtaEntClick(Sender: TObject);
    procedure mnuCadastrodeProdutosClick(Sender: TObject);
    procedure btnSimGirClick(Sender: TObject);
    procedure lblOpcGirClick(Sender: TObject);
    procedure lblOcultarDadosGeraisDoPedidoClick(Sender: TObject);
    procedure cxvItensMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure chkSuspOrdemClick(Sender: TObject);
    procedure cxvItensColumnHeaderClick(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
    procedure cxvItensDataControllerCompare(
      ADataController: TcxCustomDataController; ARecordIndex1, ARecordIndex2,
      AItemIndex: Integer; const V1, V2: Variant; var Compare: Integer);
    procedure cxvItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chkPreDolClick(Sender: TObject);
    procedure mnuEntregasFuturasPendentesClick(Sender: TObject);
    procedure mnuPreparaesdeTEdoPedidoClick(Sender: TObject);
    procedure rdgDesPdiClick(Sender: TObject);
    procedure lblLegendasClick(Sender: TObject);
    procedure cxvItensTEMREQGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure tmrAtualizaRodapeTimer(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxvItensCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure rdgCodigoFabricaProdutoClick(Sender: TObject);
    procedure Lotesdoitem1Click(Sender: TObject);
    procedure btnQuantidadeVendasPerdidasClick(Sender: TObject);
    procedure cxvItensUNITARCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvItensUNITARPropertiesEditValueChanged(Sender: TObject);
    procedure cxvItensUNITARPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnCfgGriClick(Sender: TObject);
    procedure lblExiGiroClick(Sender: TObject);
    procedure cxvItensNUMEROGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure btnCarregaPedidosVendaClick(Sender: TObject);
    procedure chkZeraSTClick(Sender: TObject);
    procedure mnAbrirKardexClick(Sender: TObject);
    procedure mnConfiguraKardexClick(Sender: TObject);
    procedure mnuRelEmprestimosClick(Sender: TObject);
    procedure edtCodSolicitacaoVinculadaKeyPress(Sender: TObject; var Key: Char);
    procedure cxvItensTIPABSGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxvItensVNOLCDGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure mnuVisImgClick(Sender: TObject);
    private
    { Private declarations }
      ArrCampoBloqueado:  TArrCamposCfg;
      blnGravando: Boolean;
      blnEnviarEmailAutomatico: Boolean;
      strPedidosCompraGerados: String;
      blnSuspendeEventoPost: Boolean;

      objItens: TCfgGrid;
      fltValFreSalvo : Double;
      fltDesAceSalvo : Double;
      blnApagaOnClose,
      blnNotShow,
      blnCarregandoPedido,
      blnCalculouSub: Boolean;

      blnConCol,
      blnUsaColeta: Boolean;
      qryColeta: TUniQuery;
      strOrdemCompra: String;

      objConsultaVeiculo: TConsutaVeiculos;

      blnEstaNaImportacao,
      blnExibirObs: Boolean;

      strCampoSaldoSub,
      strCampoSaldoAdd: String;

      cdsSaldos: TZClient;

      stlProdutosMarcados: TStringList;

    lstOrdemResgistros: TList;

    strCodCst, strCstOrigem: String;

    strForFil: String;

    objImpressaoRel: TConfiguraImpressaoPedidoCompra;

    frmGravandoConfirmaPedido: TfrmGravando;

    blnAtualizarRodape: Boolean;

    blnALTPNT,
    blnConDel,
    blnEmpVis,
    blnLibPcm: Boolean;

    wrdLastKey: Word;
    fltVlrAlqSubOri: Double;

    blnEntIte,
    blnOriIte,
    blnFazerApenasTransferencias: Boolean;

    strSimPau,
    strTipAbfFor,
    strSubUsu,
    strMaiMax: String;

    objTransfere: TPreparaTEPedidoCompra;

    objItensExcluidos: TRecuperaExcluidos;

    blnSinMul,
    blnSalvouPedido,
    blnImportandoRequisicoesAutomatica,
    blnUsaTmq: Boolean;
    strCodDig: String;

    cdsItensGridRodape: TUniClientDataSet;

    fltTotSubCal,
    fltIcmDesCal:Double;

    fltQtdAnt,
    fltValFreRes,
    fltDesAceRes: Double;

    fltTotIteGer,
    fltValFreGer,
    fltDesAceGer: Double;

    dtaDtaFatAnt: TDateTime;

    fltPisCof: Double;

    strRedPis,
    strFRMPCM,
    strIncMovRcd: String;
    blnCarregandoRequisicoes: Boolean;

    fltQtdReqImport: Double;

    blnManterZerados: Boolean;

    blnFormShow: Boolean;

    blnTemDare,
    blnZonaFranca,
    blnAtivandoItem,
    blnAdicionandoItem: Boolean;

    strCmpMlt: String;

    blnCmpTPr,
    blnCmpTUn,
    blnUtiInd,
    blnPRFEFE,
    blnLimpouItem : Boolean;
    blnExibirPedidoPendente: Boolean;

    fltLimVer,
    fltLimAma: Double;

    strLitGal: String;

    objCreditoFornecedor: TCreditosFornecedor;
    qryConOpe: TUniQuery;

    cdsDigMultLoja: TCdsDigMultLoja;
    cdsItensConf: TZClient;
    blnZerCon: Boolean;

    strCmpOri: String;
    blnLibCmp: Boolean;

    qryBaixad: TUniQuery;
    blnLoadPedido: Boolean;

    blnEntBrf: Boolean;

    strTraFor: String;
    strPrF_AE: String;
    blnMudaTabPre : Boolean;

    fltValTax,
    fltValMar: Double;

    qryIteFor: TUniQuery;
    strCnvEmb: String;

    blnPedImpAnt: Boolean;

    strIncPisIte: String;

    fltPerFCPIte,
    fltSubFCPIte,
    fltBasIcmIte,
    fltAlqIcmIte,
    fltValIcmIte,
    fltBaseSTIte,
    fltDesPisIte,
    fltAlqPis,
    fltAlqCof,
    fltDesVis: Double;   // %Desconto A Vista
    intCarPag: Integer;  // Carência p/ Pagto A Vista

    strCodSitIte,
    strCodSitOrigemIte: String;

    intDecUni: Integer;
    intDecTpc: Integer;
    strUniPcg: String;
    arrUnidade: TConsultasArray;
    qryConIte: TUniQuery;
    qryConGer: TUniQuery;
    qryConFor: TUniQuery;
    qryIteCon: TUniQuery;
    qryDadCom: TUniQuery;
    blnShift : Boolean;
    blnTransforma: Boolean;
    stlAutIncrem: TStringList; //Guarda Autoincrem das PCMGER quando Multloja
    intQtdItensMutiLj: Integer;

    // ver essas variáveis
    {***************************}
    blnAlterando: Boolean;
    strUniOri: String;
    strAutoIncrem: String;
    blnConfDocumento: Boolean;
    strEspOri: String;
    dtaDtaPed: TDateTime;
    horHorPed: TTime;
    blnInseriu: Boolean;
    blnSitPro: Boolean;
    blnCorIpd: Boolean;

    strFinPed: String;
    strPedGer: String;
    blnEnvWap: Boolean;

    intConfirma: Integer;

    cdsItensGiro: TUniClientDataSet;

    strsAplicacao: TStrings;
    strCodForAnt: String;

    fltPerDesAdiOLD: Double;

    objRequisicao: TRequisicaoPedidoCompra;

    cdsConsultaItem: TUniClientDataSet;
    sltItems: TStringList;
    blnUtilizandoCompraItem,
    blnAtualizarPnlDadosItemModoTab: Boolean;
    frmDigData : TfrmDigData;
    ParametrosCalcImpostos: TParametrosCalculoImposto;
    cdsLegendas: TLegendasItem;
    blnPermitirCompradorEscolherCodigoFabrica: Boolean;
    recValidadorCmpMlt: TRecValidadorCmpMlt;
    blnImpostoPedImportacao: Boolean;
    blnImpostoImportaçãoVemDoCadastroProduto: Boolean;
    FPnlGiroHeight : Integer;
    FpnlAplicacaoHeight : integer;
    FblnImportacaoArqAcumulaQtd: Boolean;
    FblnSomaReforma: Boolean;

    procedure pAjustaCamposReforma;
    procedure pCalculaReformaTela;
    function fValidaAlqReforma(edtAlq: TEditFocus; blnBuscaPorChave: Boolean = True): Boolean;

    Function fCalculaTotalEmpresas(strItensPed: String; cdsItensMultiLojas: TUniClientDataSet;
                                   fltDesAceGer, fltValFreGer: Double;
                                   frmGravandoConfirmaPedido: TFrmGravando): Boolean;

    function fGetPositionByRecordIndex(ARecordIndex: Integer): Integer;
    procedure pEnviaEmailAutomatico;

    procedure pSalvaOrdenacao;
    procedure pLiberaOrdenacao;

    function fTrataCodCmp: String;

    Function fAdicionaItemClick: Boolean;

    procedure pDefineTransferencia;

    Procedure pHabilitaDesUni(edtDesUni, edtDesconto: TEditFocus);

    Function fValidaItemExit: Boolean;

    procedure pIncluiNaListaConsulta;

    procedure pRetiraDaListaConsulta(strCodIte: String);

    procedure pAtualizaPCG_DTAENT(AData: TDateTime);

    function fRetDataEntrega: TDateTime;

    Function fEstaNaConsultaTab: Boolean;

    procedure pFechaCompraItem;

    procedure pHabilitaDataPorItem;

    procedure pMostraDadosGerais;

    procedure pCalculaTotalItemQtdGrid(dataSet: TDataSet);

    procedure pCalculaUniImp(dataSet: TDataSet);overload;
    procedure pCalculaUniImp(dataSet: TDataSet; recDescontoItem: TRecDescontoItem);overload;

//    Function fFiltroCompra: String;

    Function fCompraItem(cdsConsulta: TUniClientDataSet; DropControl: TControl; RectLinhaGrid: TRect): Boolean;

    procedure pSetCaptionForm;
    procedure pInsereItemRodapeUmaLoja;

    Procedure pInicializaDtaPed;


    Function fSQLItensPedido(blnRecupera: Boolean): String;

    Procedure pAtualizaQtdMultiloja;

    procedure pImportaRequisicoes(strCodIte: String; blnImportarTodos: Boolean = False);

    Function fImportaRequisicoes(prgProgresso: TCxProgressBar): Boolean;

    Function fSQLItensConf: String;
    Function fRetQtdConferida(strCodIte: String; fltQtdIte: Double): Double;
    Function fVerificaDivergenciasConf: Boolean;

    Procedure pCarregaConfiguracoesGrid;
    Procedure pSalvaConfiguracoesGrid;

    Procedure pInicializaDiaEnt(intDiaFor: Integer);

    procedure pAddConferido(strCodIte, strDesIte: String; fltQtdIte: Double);

    procedure pAjustaTipoPedido(blnPedImp: Boolean);

    procedure pRecalculaDatasEntrega;

    Function fRecalculaDatasEntrega(pgbProgresso: TcxProgressBar): Boolean;

    Function fCalculaTotalEmpresasPrg(prgProgresso: TCxProgressBar): Boolean;

    Procedure pRegravaItensBaixados;
    Procedure pCarregaItensBaixados;
    procedure pInicializaQueries;
    procedure pLiberaQueries;

    Function fPedeDadosImportacao: Boolean;
    procedure pMostraColunasUnitarioLiquido(blnMostrar: Boolean);
    procedure pCarregaFornecedor(blnCarregandoPedido: Boolean; strCnpj: String = '');
    Procedure pAtualizaUnitarioLiquido;
    procedure pAtivaItem;

    Procedure pAjustaSubIcms(strCst, strCstOrigem: String);

    Procedure pMarcaDesmarcaProduto;

    procedure pProximoItem(blnAlterandoAnt, blnLimpaDados: Boolean);

    procedure pAtualizaBotoesTotais(blnAtualizarTotais: Boolean = True);

    Procedure pAtualizaTotalTela;

    function fValidaDiaEnt(blnBuscaPorChave: Boolean): Boolean;
    function fValidaDtaEnt(blnBuscaPorChave: Boolean): Boolean;

//    Function fValidaCabecalho: Boolean;

    Function fValidaEstoqueMaximo: Boolean;

    Function fRetEmpresaDestino: String;

    Function fStrEmpSaldos: String;

    procedure pInsereItemClient(strCodIte: String);
    function fDataEmpty(const strData: String): Boolean;

    Function fVerificaTravaFornecedor(strCodFor: String; blnExcluir: Boolean): Boolean;

    function fTemItensDeOutroResponsavel: Boolean;
    function fRetComprador: String;
    function fLiberaAlteracaoOutroResponsavel(strMotivo, strCodIte: String): Boolean;
    function fVerificaComprador: Boolean;
    function fValidaUnidade(blnBuscaPorChave: Boolean): Boolean;
    Function fVerificaUnitarioZerado: Boolean;

    Function fTemQuantidadeZerada: Boolean;

    function fValidaFornecedor(blnBuscaPorChave: Boolean = True): Boolean;
    function fValidaDataEntrega(blnBuscaPorChave: Boolean = True): Boolean;
    function fValidaComprador(blnBuscaPorChave: Boolean): Boolean;
    procedure pAjustaAutoincremCdsMultiLoja_PREPTE;
    function fValidaDataFaturamento(blnBuscaPorChave: Boolean = True): Boolean;
    function fValidaQtdCtn(blnBuscaPorChave: Boolean = True): Boolean;
    function fValidaCondPagamento(blnBuscaPorChave: Boolean = True): Boolean;
    function fValidaDescontoAdicional(blnBuscaPorChave: Boolean = True): Boolean;
    Function fVeSeRecalculaDesconto: TOpcaoDescontoItemCompra;

    function fValidaItem(blnBuscaPorChave: Boolean = True; blnTraFor: Boolean = True; blnGruCmp: Boolean = True): Boolean;
    function fValidaDescricao(blnBuscaPorChave: Boolean = True): Boolean;
    function fValidaQuantidade(blnBuscaPorChave: Boolean = True): Boolean;

    function fValidaUnitario(blnBuscaPorChave: Boolean = True): Boolean;

    function fValidaDescontoUnitario(edtDesUni,
                                     edtDesUn2,
                                     edtDesUn3,
                                     edtDesUn4,
                                     edtDesUn5,
                                     edtDesUn6: TEditFocus;
                                     blnBuscaPorChave: Boolean = True): Boolean;

    function fValidaPerIpi(edtPerIpi: TEditFocus; blnBuscaPorChave: Boolean = True): Boolean;
    function fValidaPerSub(blnBuscaPorChave: Boolean = True): Boolean;
    function fValidaTotSub(blnBuscaPorChave: Boolean = True; blnRelcalculaAliquota: Boolean = False): Boolean;
    function fValidaIcmDes(blnBuscaPorChave: Boolean = True): Boolean;

    function fValidaPerImp(blnBuscaPorChave: Boolean = True): Boolean;
    function fValidaPerCof(blnBuscaPorChave: Boolean = True): Boolean;
    function fValidaPerPis(blnBuscaPorChave: Boolean = True): Boolean;

    procedure pCarregaIteger(strCodIte: String);
    procedure pCarregaDadosDeCompra(strCodIte, strCodFor, strCodEmp: String; Var blnPrecoFor: Boolean);
    procedure pLePrecoCompraItem(qryDadCom: TUniQuery; strCodIte, strCodFor: String);
    procedure pCarregaItem;
    procedure pHabilitaPrecos(blnHabilita: Boolean);
    procedure pHabilitaUnidade(blnTemTabPreco: Boolean);
    procedure pAtualizaDados(DataSet: TDataSet; blnLerCadastro: Boolean = True; blnForce: Boolean =  False);

    procedure pAferScroll(DataSet: TDataSet);

    procedure pBeforeScroll(DataSet: TDataSet);

    procedure pAfterPost(DataSet: TDataSet);

    procedure pAtualizaGridRodape(blnExpand: Boolean; var ACodIteProcessado: String);
    function fAplicaAliquota: double;

    Function fDigQuantidadeMultilojaPedCom: Boolean;

    Function fAdicionaItem(blnProcessoNormal, blnAferScroll: Boolean): Boolean;

    function fItemCadastrado: Boolean;
    procedure pMostraProdutosPendentes(blnMensagem: Boolean; strCodIte, strDesIte: String; blnQuoted: boolean = True; blnExibeMensagem: Boolean = False);
    function fRetProximoAutIncTmp: String;
    procedure pLimpaDadosItem;
    function fRetQtdCtn: String;
    procedure pImportaPedFornecedor;
    Function fCarregaItensPedido: Boolean;
    Function fCarregaItensPedidoAux(pgbProgresso: TcxProgressBar): Boolean;
    Function fCarregaItensVendas(pgbProgresso: TcxProgressBar): Boolean;


    Function fSQLBuscaRequisicaoPcddetRes: String;

    procedure pMostraLitragemGrupo;
    procedure pMostraEstoqueLojasComGiro;
    procedure pMostraGiroAnalitico;
    procedure pCalculaTotalItem(blnCalTot: Boolean);
    procedure pRecalculaPorcentagemItens(blnAlterandoDescontoAdcional: Boolean = False);
    function fVerificaQuantidadeZero: Boolean;
    function fVerificaDescricaoVazia: Boolean;
    function fAtualizaDtaEntPedido(prgProgresso: TcxProgressBar): Boolean;

    function fConfirmaPedido(pgbStatus: TcxProgressBar): Boolean;
    procedure pTemItensDuplicados(strNumPed, strCodEmp, strEspDoc: string);
    function fRetImposto(strNomCam: String): Double;
    procedure pFiltraQuantidadeZero(blnFiltra: Boolean);

    function fRetSugestao(strCodIte: String): Double;

    Procedure pRateiaFreteDesAce(blnRecalcular: Boolean; fltValFreRat, fltDesAceRat: Double; strBStFrete, strBStDesAce, strBSIpiFrete: String);

    Function fRateiaFreteDesAcePrg(pgbProgresso: TcxProgressBar): Boolean;

    Procedure pRateiaFreteRegistro(Var fltValFreRes, fltDesAceRes: Double;
                                       fltValFreGer, fltDesAceGer, fltTotIteGer: Double;
                                       cdsDados: TUniClientDataSet);

    function fPrecoUnitarioEspecialFornecedor(strCodFor, strCodIte: String): Double;

    procedure pImprimeEtiqueta(strCodFor, strNumDoc, strEspDoc: string);
    procedure pDadosEntrega;
    function fResponsavelGrupoCompras(strCodIte: String): String;

    Function fGetDiaFor: Integer;

    function fRecalcularSubstituicaoTributaria: Boolean;

    Function fRecalcularSubstituicaoTributariaAux(pgbProgresso: TcxProgressBar): Boolean;

    procedure pRecalculaIpiItens;

    Procedure pAtualizaReservados;
    procedure pRetDescontoFornecedor(strCodIte, strCodFor: String; fltEmbala: Double; Var fltUnitar: Double;
       Var recDescontoItem: TRecDescontoItem);
    Procedure pAncoraPainelGiro;
    procedure pCarregarCodPlanoDeContasForn();

    procedure pApagaItem;

    function fValidaPrecoItemFornecedor : Boolean;

    Function fPossuiColeta(strCodIte: String): Boolean;
    Function fPerguntaExclusaoColeta(strCodIte: String): Boolean;
    Function fPerguntaExclusaoColetaMarcados: Boolean;

    Procedure pIniacializaTotaisItem;
    Procedure pIncrementaTotaisPedido;

    Procedure pAtualizaDadosCopiaSeg;
    Procedure pCarregaCapaPedido;
    procedure AposCarregarLinhaPlanilha(Linha: TLinha; CamposLayoutUsados: TCamposLayoutUsados; var PararProcessamento: Boolean);
    procedure pMensagemPedidoCompraLiberar(strCodEmp, strNumPed, strEspDoc, strCodFor : String;
                                           dtaDtaPed, dtaDtaEnt: TDateTime; fltTotGer: Double; blnInclusao: Boolean);
    procedure pEntregasFuturasPendentes;
    function fLiberouItensInativos: Boolean;
    procedure pAjustarRadioGroupCodigoFabricaProduto;
    procedure pAlterarRadioGroupCodigoFabricaProduto(const strTipoCodigoFabricaProduto: String);
    function fRetornaTipoCodigoFabricaProduto: String;
    function fRetornaCodigoFabricaProduto: String;
    function fRetornaSQLCodigoFabricaProduto(const strPrefixoCadIte: String): String;
    procedure pRecalculaCodigoFabricaDoProduto;
    function fRetornaCodigoFabricaItem(const strCodIte: String): String;
    function GetCampoItem(ACampo: String): TField;
    function fValidaConsistenciaPedido(strNumPed, strCodEmp, strEspDoc:String):Boolean;
    function fLiberarLimiteMAximoPedidoCompraVRMXPC: Boolean;
    procedure pCarregarItensLista;
    procedure ProcessaStatusPedidoRequisicaoPedidoCompra(ASeqPCMGER: String);

    procedure pExibirRelPedidoCompraGrid(const strCodIte, strDesIte: String; strExibirFornec: String = '');
    function fObterDescontosItemGrid: TRecDescontoItem;
    procedure pCarregarDescontosItemGrid(Var recDescontoItem: TRecDescontoItem);
    function fObterDescontosItem(blnAterandoDescontoItem: Boolean): TRecDescontoItem;
    procedure pCarregarDescontosItem(Var recDescontoItem: TRecDescontoItem);
    procedure pExibirDescontos(recDescontoItem: TRecDescontoItem);
    function fValidaQtdPCDDETcomPCMDET(out strMsgErr: String): Boolean;
    {function fGetOrdemDoGrid(view: TcxGridDBTableView): String;}

    function fConcatenaObserv(EhPedido : Boolean) : String;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pCarregaDigitador;
    procedure pEscapePressed; override;
    procedure pAjustaDescricaoDosItens;
    Function fAjustaDescricaoDosItensAux(pgbProgresso: TcxProgressBar): Boolean;


  public
    { Public declarations }
    strCodIteProcessadoRodape: String;
    objDuplicatasPedido: TDuplicatasPedidoCompra;

    strCodCta: String;
    recOpcGir   : TRecOpcoesGiro;
    blnAltPedGir: Boolean;

    objCopiaSeg: TRecuperaPedido;

    blnNovoReg: Boolean;
    blnModoHeranca: Boolean;

    strNumPed: String;
    strEspDoc: String;

    blnUsarGiro: Boolean;

    stlArquivos: TStringList;
    strCodEmp: String;

    cdsItensGiroExt: TUniClientDataSet;
    cdsItensPedido: TUniClientDataSet;
    cdsItensMultiLojas: TUniClientDataSet;
    qryGiro: TUniQuery;
    qryPcmGer: TUniQuery;
    qryPcmDet: TUniQuery;
    dspPcmDet: TUniDataSetProvider;

    strEmpUsadaGiro: String;

    strNomEmp,
    strEndEmp,
    strCidEmp: String;
    blnCodFab: Boolean;
    blnImpRef: Boolean;
    blnLocFis: Boolean;
    blnAnalisaITEFOR: Boolean;
    blnExcRes: Boolean;
  end;

var
  frmPedidoDeCompra: TfrmPedidoDeCompra;
const
  cItensDuplicados = 'ITENS DUPLICADOS';
  cFalhaDistribuicaoMltLoja = 'FALHA DISTRIBUICAO MULTILOJAS';

implementation

uses  dxCore, cxVariants, untRodapeFormatado,
      untPesqAux, untImagens,
      untRelEstPedCompraGrid,
      untMostraEstoqueGiroEmp,
      untConstantes,  untPedidoCompraImpr, untDigObservacoes,
      untConsultaItensGiro, untSaldoPedidoCompra,
      untFatMostraLitragGrupo,
      untEntEtiquetas, untConsultas, untFuncIns2,
      untItensOutrosCompradores, untIteBar, untMostraItensTravaFornec,
      untRecalculaSados,  untPedidoCompraResumoLojas, untTipoFreteAtc,
      untFuncoesConsulta, untPnlDadosFornecedor, untPanelCxFornecedor,
      untMostraDivergConf, untEntDigMultiLojasNovo, untTelaGiroUma, untPedidoCompraImportacao,
      untMostrarTotalPorUnidade, untTestabilidade,
      untFatMostraPedSalRes, TypesRel, untFuncoesRel2,
      untInformarPedidoVendaItens, untNotificaAtivacaoTabPreFor,
      untIFuncoes, untPedidoCompraLiberacao, untSelPedidoCompraImpressao,
      untPedidoCompraItem, untCadProdutosCompCusto, untFatConsVendasAntigas,
      untTValidaValorPedidoCompra, untMsgInterna, untFuncoesDllPedido,
      untMostraLimiteEstoqMax, untFuncInsFactory,
      untILiberacao, untMsgLiberacao, untLiberacaoFactory,
      untTypesCRM, untAtualizaOcorrenciasCRM, untIFatEntregaFutura,
      untLiberaPrepTE,
      untTMontaSQLPedidoCompra,
      untTFatEntregaFutura, untFuncoesRel, untBloquearTela,
      untTLog, untSelItensVendasParaPedidoCompra,untDisparaEmailAutEnt, untPnlDadosPedCompra,
      untTLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD, untOpcPdfPedidoCompra,
      untTSituacaoPedidoVenda, untTValidaGravacaoPedidoCompra, untManutencaoEquipamentoInterno,
      untImpostosReformaCompra;

{$R *.dfm}

{ TfrmPedidoDeCompra }

procedure TfrmPedidoDeCompra.pInicializaQueries;
begin
  qryConIte := fCriaQuery(Self);
  qryConGer := fCriaQuery(Self);
  qryConFor := fCriaQuery(Self);
  qryIteCon := fCriaQuery(Self);
  qryDadCom := fCriaQuery(Self);

  qryPcmDet := fCriaQuery(Self);
  dspPcmDet := TUniDataSetProvider.Create(qryPcmDet);
end;

procedure TfrmPedidoDeCompra.pLiberaQueries;
begin
  If Assigned(qryConIte) Then
  Begin
    qryConIte.Close;
    FreeAndNil(qryConIte);
  End;

  If Assigned(qryConGer) Then
  Begin
    qryConGer.Close;
    FreeAndNil(qryConGer);
  End;

  If Assigned(qryConFor) Then
  Begin
    qryConFor.Close;
    FreeAndNil(qryConFor);
  End;

  If Assigned(qryIteCon) Then
  Begin
    qryIteCon.Close;
    FreeAndNil(qryIteCon);
  End;

  If Assigned(dspPcmDet) Then
    FreeAndNil(dspPcmDet);

  If Assigned(qryPcmDet) Then
    FreeAndNil(qryPcmDet);

  If Assigned(cdsItensGiro) Then
    FreeAndNil(cdsItensGiro);

  If Assigned(qryDadCom) Then
    FreeAndNil(qryDadCom);

  If Assigned(objCreditoFornecedor) Then
    FreeAndNil(objCreditoFornecedor);

  If Assigned(qryBaixad) Then
    FreeAndNil(qryBaixad);

  If Assigned(qryIteFor) Then
    FreeAndNil(qryIteFor);
end;

Function TfrmPedidoDeCompra.fSQLItensConf: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   PCD_CODITE AS CODITE, ';
  strSQL := strSQL + '   PCD_DESITE AS DESITE, ';
  strSQL := strSQL + '   PCD_QTDCON AS QTDCON, ';
  strSQL := strSQL + '   PCD_QTDCON AS QTDITE  ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   PCMDET ';
  strSQL := strSQL + ' WHERE FALSE ';
  Result := strSQL;
End;

procedure TfrmPedidoDeCompra.pAddConferido(strCodIte, strDesIte: String; fltQtdIte: Double);
Begin
  With cdsItensConf Do
  Begin
    Insert;
    FieldByName('CODITE').AsString := strCodIte;
    FieldByName('DESITE').AsString := strDesIte;
    FieldByName('QTDCON').AsFloat  := fltQtdIte;
    FieldByName('QTDITE').AsFloat  := 0;
    Post;
  End;
End;

Function TfrmPedidoDeCompra.fRetQtdConferida(strCodIte: String; fltQtdIte: Double): Double;
Begin
  With cdsItensConf Do
  If Locate('CODITE', strCodIte, []) Then
  Begin
    Result := FieldByName('QTDCON').AsFloat;

    If Result > fltQtdIte Then
      Result := fltQtdIte;
  End Else
   Result := 0;
End;

Function TfrmPedidoDeCompra.fVerificaDivergenciasConf: Boolean;
  Var
    strIndexFieldNames: String;
Begin
  If blnZerCon Then
  Begin
    Result := True;
    Exit;
  End;

  With cdsItensConf Do
  Begin
    First;

    Try
      strIndexFieldNames := cdsItensPedido.IndexFieldNames;

      cdsItensPedido.IndexFieldNames := 'ITE_CODITE';

      While Not Eof Do
      Begin
        If cdsItensPedido.FindKey([FieldByName('CODITE').AsString]) Then
        Begin
          Edit;
          FieldByName('QTDITE').AsFloat := cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat;
          Post;
        End;

        Next;
      End;

    Finally

      cdsItensPedido.IndexFieldNames := strIndexFieldNames;
    End;

    Filter   := 'QTDCON > QTDITE';
    Filtered := True;

    Result := IsEmpty;

    If Not Result Then
    Begin
      pCriarFormularios(TfrmMostraDivergConf, frmMostraDivergConf);
      frmMostraDivergConf.cxvItens.DataController.DataSource := dtsSource;

      Result := frmMostraDivergConf.ShowModal = mrOk;

      FreeAndNil(frmMostraDivergConf);
    End;

    Filtered := False;
  End;
End;

procedure TfrmPedidoDeCompra.pHabilitaDataPorItem;
Begin
  lblDiaEnt.Visible  := blnEntIte;
  edtDiaEnt.Visible  := lblDiaEnt.Visible;
  lblDatEnt.Visible  := lblDiaEnt.Visible;
  mskDtaEnt.Visible  := lblDiaEnt.Visible;
  btnDtaEnt.Visible  := lblDiaEnt.Visible;

  mskDtaPed.ReadOnly := lblDiaEnt.Visible;
  mskDtaPed.TabStop  := Not mskDtaPed.ReadOnly;

  If mskDtaPed.ReadOnly Then
     mskDtaPed.Color := $00FFDFB8;

  cxvItensDTAENT.Visible := lblDiaEnt.Visible;
End;

function TMycxGridDBTableView.GetDataControllerClass: TcxCustomDataControllerClass;
begin
  Result := TMycxGridDBDataController;
end;

function TMycxGridDBDataController.CreateDataControllerInfo: TcxCustomDataControllerInfo;
begin
  Result := TMycxCustomDataControllerInfo.Create(Self);
end;

Procedure TMycxGridDBDataController.SetOrdenar(Value: Boolean);
Begin
  If Value <> TMycxCustomDataControllerInfo(DataControllerInfo).blnOrdenar Then
  Begin
    TMycxCustomDataControllerInfo(DataControllerInfo).blnOrdenar := Value;

    If Value Then
      TMycxCustomDataControllerInfo(DataControllerInfo).DoSort;

  End;
End;

Function TMycxGridDBDataController.GetOrdenar: Boolean;
Begin
  Result := TMycxCustomDataControllerInfo(DataControllerInfo).blnOrdenar;
End;

function TfrmPedidoDeCompra.fGetPositionByRecordIndex(ARecordIndex: Integer): Integer;
  Var
    intContador: Integer;
begin
  Result := -1;

  For intContador := 0 To lstOrdemResgistros.Count -1 Do
    If TPosicaoRegistroPrt(lstOrdemResgistros[intContador])^.intRecordIndex = ARecordIndex Then
    Begin
      Result := TPosicaoRegistroPrt(lstOrdemResgistros[intContador])^.intPosition;
      Break;
    End;
end;

procedure TfrmPedidoDeCompra.pLiberaOrdenacao;
  Var
    intContador: Integer;
Begin
  For intContador := 0 To lstOrdemResgistros.Count -1 Do
    Dispose(TPosicaoRegistroPrt(lstOrdemResgistros[intContador]));

  lstOrdemResgistros.Clear;
End;

procedure TfrmPedidoDeCompra.pSalvaOrdenacao;
  Var
    intRecNo,
    intContador: Integer;
    ptrRegistro: TPosicaoRegistroPrt;
begin
  pLiberaOrdenacao;

  If cdsItensPedido.IsEmpty Then
    Exit;

  intRecNo := cdsItensPedido.RecNo;

  With cxvItens.DataController do
  For intContador := 0 To RecordCount - 1 Do
  begin
    New(ptrRegistro);
    ptrRegistro^.intRecordIndex := intContador;
    ptrRegistro^.intPosition := GetRowIndexByRecordIndex(intContador, False);
    lstOrdemResgistros.Add(ptrRegistro);
  end;

  cdsItensPedido.RecNo := intRecNo;
end;

procedure TMycxCustomDataControllerInfo.DoSort;
begin
  inherited;
end;

procedure TfrmPedidoDeCompra.FormCreate(Sender: TObject);
  Var
    strDisplay: String;
    blnTABPRF: Boolean;
begin
  inherited;
  blnSuspendeEventoPost := True;
  blnGravando := False;
  chkZeraST.Visible := fEhEstadoRegraZonaFranca(fCadEmp('ESTADO'));
  blnTABPRF := fCfgSis('TABPRF', varBoolean);
  blnCMPTPR := fCfgSis('CMPTPR', varBoolean);

  cxvItensUNITAR.Options.Editing := Not ((blnTABPRF) And (blnCMPTPR));

  cxvItensREFERE.Visible := False;

  blnCarregandoPedido := False;

  blnEstaNaImportacao := False;
  blnAtualizarRodape := False;

  If fCfgSis('PROVEI', varBoolean) Then
  Begin
    objConsultaVeiculo := TConsutaVeiculos.Create(Self, dtsItensPedido);
    cxVeiculoProdutoView.DataController.DataSource := objConsultaVeiculo.dtsSource;
    pnlAplicacao.Height := 80;
  End Else
    objConsultaVeiculo := Nil;

  splVeiculos.Visible      := Assigned(objConsultaVeiculo);
  cxVeiculoProduto.Visible := Assigned(objConsultaVeiculo);


  strCodCst := '';
  strCstOrigem := '';

  blnNotShow := False;
  blnExibirObs := True;
  blnSitPro := fCfgSis('SITPRO', varBoolean);
  blnCorIpd := fCfgSis('CORIPD', varBoolean);

  blnConCol := fCfgSis('CONCOL', varBoolean);
  If blnConCol Then
  Begin
    qryColeta := fCriaQuery(Self);
    qryColeta.IndexFieldNames := 'CON_CODITE';
  End
  Else qryColeta := Nil;

  strOrdemCompra := '';

  If (blnSitPro and blnCorIpd) Then
  Begin
    lblLegendas.Visible          := True;
    cxvItensTEMREQ.Visible       := True;
    lblRecCompraLegenda1.Visible := False;
    lblRecCompraLegenda2.Visible := False;
    shpReqCompra.Visible         := False;
//    lblLegendas.Left             := shpReqCompra.Left;
  End
  Else
  Begin
    lblLegendas.Visible          := False;
    cxvItensTEMREQ.Visible       := False;
    lblRecCompraLegenda1.Visible := True;
    lblRecCompraLegenda2.Visible := True;
    shpReqCompra.Visible         := True;
  End;

  blnApagaOnClose := False;

  pSetaCodIte(edtCodIte);

  TMycxGridDBDataController(cxvItens.DataController).blnOrdenar := True;
  lstOrdemResgistros := TList.Create;

  stlProdutosMarcados := TStringList.Create;
  stlProdutosMarcados.Duplicates := dupIgnore;
  stlProdutosMarcados.Sorted := True;

  chkPreDol.Visible := fCfgSis('COTDOR', varBoolean);

  cdsItensGridRodape := Nil;

  cdsSaldos := TZClient.Create(Self);

  strRedPis := 'N';
  fltPisCof := 0;

  blnALTPNT := fCfgSis('ALTPNT', varBoolean);

  blnConDel := fCfgSis('CONDEL', varBoolean);

  blnZonaFranca := fEhEstadoRegraZonaFranca(fCadEmp('ESTADO'));

  FblnSomaReforma := fSomarNovosImpostosDaReformaAoValorContabil;
  pAjustaCamposReforma;
  // Rodape de totais em linha corrida (rotulo vermelho, valor preto); os campos do Panel4 seguem como fonte.
  TRodapeFormatado.Create(Self, Panel4, lblTotGer);

  frmSelPedidoCompraImpressao := Nil;

  strIncPisIte := 'N';

  fltBasIcmIte := 0;
  fltAlqIcmIte := 0;
  fltValIcmIte := 0;
  fltBaseSTIte := 0;
  fltDesPisIte := 0;

  strCodSitIte := '';
  strCodSitOrigemIte := '';

  strForFil := fRetForFilialTodos;
  blnLibPcm := fCfgSis('LIBPCM', varBoolean);

  blnEmpVis := fCfgSis('EMPVIS', varBoolean);

  blnSinMul := fCfgSis('TELUMA', varBoolean);

  strSubUsu    := 'N';
  fltTotSubCal := 0;
  fltIcmDesCal := 0;

  frmTelaGiroUma := Nil;
  cdsDigMultLoja := Nil;

  blnEntIte := fCfgSis('ENTITE', VarBoolean);

  blnOriIte := fCfgSis('ORIDIA', VarInteger) = 2;

  blnSalvouPedido := False;

  strCodDig := '';
  edtCodDig.Visible := False;

  strMaiMax := fCfgSis('MAIMAX');

  blnImportandoRequisicoesAutomatica := False;


  objTransfere := TPreparaTEPedidoCompra.Create;
  objTransfere.pCalculaTotalItemQtdGrid := pCalculaTotalItemQtdGrid;

  objDuplicatasPedido := TDuplicatasPedidoCompra.Create;

  qryConOpe:= fCriaQuery;

  fltValFreGer := 0;
  fltDesAceGer := 0;

  blnUsaTmq := fCfgSis('USATMQ', varBoolean);

  strFRMPCM := fCfgSis('FRMPCM');

  strIncMovRcd := '';

  fltQtdReqImport := 0;

  blnCarregandoRequisicoes := False;

  blnAdicionandoItem := False;
  blnAtivandoItem    := False;

  sltItems        := TStringList.Create;
  sltItems.Sorted := True;

  blnUtilizandoCompraItem := False;
  blnAtualizarPnlDadosItemModoTab := False;

  blnManterZerados := False;

  blnFormShow := False;

  strLitGal := fCfgSis('LITGAL');

  blnMudaTabPre := False;

  objCreditoFornecedor := TCreditosFornecedor.Create(Self);

  blnZerCon := fCfgSis('ZERCON', varBoolean);

  fltValTax := 0;
  fltValMar := 0;

  cdsItensConf := TZClient.Create(Self, fSQLItensConf);
  cdsItensConf.fAbreClient(True, 'TfrmPedidoDeCompra.FormCreate');
  cdsItensConf.IndexFieldNames := 'CODITE';

  blnEntBrf := fCfgSis('ENTBRF', varBoolean);

  blnConfDocumento := False;

  blnLoadPedido    := False;

  qryBaixad := fCriaQuery(Self);

  strCmpMlt := fCfgSis('CMPMLT', varString);
  recValidadorCmpMlt.Create(strCmpMlt);

  If fCfgSis('TABPRF', varBoolean) Then
  Begin
    strTraFor := fCfgSis('TRAFOR');
    blnCmpTPr := fCfgSis('CMPTPR', varBoolean);
    blnCmpTUn := fCfgSis('CMPTUN', varBoolean);
  End Else
  Begin
    strTraFor := 'N';
    blnCmpTPr := False;
    blnCmpTUn := False;
  End;

  strPrF_AE := fCfgSis('PRF_AE', varString);

  qryIteFor := fCriaQuery(Self);

  pAjustaTipoPedido(chkPedImp.Checked);

  strCnvEmb            := fCfgSis('CNVEMB');

  lblEmbala.Visible    := strCnvEmb <> 'N';
  edtEmbala.Visible    := strCnvEmb <> 'N';

  intDecUni            := fCfgSis('DECUNI', varInteger);
  intDecTpc            := fCfgSis('DEQTPC', varInteger);
  strUniPcg            := fCfgSis('UNIPCG');
  edtQtdIte.EditFormat := fMskDigitos(intDecTpc);

  strDisplay := '#,##0.' + fStrZero('0', intDecTpc) + ';-0.' + fStrZero('0', intDecTpc);
  TcxCurrencyEditProperties(cxvItensQTDITE.Properties).DecimalPlaces := intDecUni;
  TcxCurrencyEditProperties(cxvItensQTDITE.Properties).DisplayFormat := strDisplay;

  strDisplay := '#,##0.' + fStrZero('0', intDecUni) + ';-0.' + fStrZero('0', intDecUni);
  TcxCurrencyEditProperties(cxvItensUNITAR.Properties).DecimalPlaces := intDecUni;
  TcxCurrencyEditProperties(cxvItensUNITAR.Properties).DisplayFormat := strDisplay;


  blnImpostoPedImportacao := fCfgSis('IMPIMP', varBoolean);
  blnImpostoImportaçãoVemDoCadastroProduto := (fCfgSis('PERIMP', varString) = 'C');

  pInicializaQueries;
  blnNovoReg         := False;
  blnModoHeranca     := False;
  pnlInfo.Caption    := '';
  strAutoIncrem      := '';
  intConfirma        := -1;
  strsAplicacao      := TStringList.Create;
  strCodForAnt       := '';
  blnLimpouItem      := False;
  mnuFormacaodePrecos.Visible := (fCfgSis('CADEST',varString) = 'S') And (fCfgSis('UTIIND',varString) = 'N');
  objRequisicao      := TRequisicaoPedidoCompra.Create();
  objRequisicao.qryColeta := qryColeta;
  blnExibirPedidoPendente := True;
  btnInfPedidoDeVendas.Visible := fCfgSis('UTNUPV', varBoolean);
  mnuConsultadePedidodeCompras.Visible := fVerificaAcessoSistema('VISLIB');
  Kardex.Visible := fVerificaAcessoSistema('MKPPREUNI');
  Kardex.Enabled := Kardex.Visible;
  pCriarFormularios(TfrmSelPedidoCompraImpressao, frmSelPedidoCompraImpressao);

  lblIcmDes.Visible   := blnZonaFranca;
  edtIcmDes.Visible   := blnZonaFranca;
  lblTotDeson.Visible := blnZonaFranca;
  dbdTotDeson.Visible := blnZonaFranca;

  blnPermitirCompradorEscolherCodigoFabrica := fCfgSis('CFPCFF', varBoolean);

  lblDesPis.Visible   := blnZonaFranca;
  edtDesPis.Visible   := blnZonaFranca;

  lblTotDesPis.Visible := blnZonaFranca;
  dbeDESPIS.Visible    := blnZonaFranca;

  stlAutIncrem  := TStringList.Create;
end;

procedure TfrmPedidoDeCompra.FormDestroy(Sender: TObject);
begin
  pLiberaOrdenacao;
  FreeAndNil(lstOrdemResgistros);

  If (Not objCopiaSeg.recPcmger.strAutInc.IsEmpty) And
     ((blnApagaOnClose) Or (fMensagem('ATENÇÃO!', 'Salvar este pedido para ser restaurado mais tarde?', ['&Sim', '&Não']) = 2)) Then
    objCopiaSeg.pApagaCopiaSeguranca;

  FreeAndNil(stlProdutosMarcados);

  If Assigned(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.stlCamposExcel) Then
    FreeAndNil(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.stlCamposExcel);

  cdsItensPedido.AfterScroll := Nil;
  pLiberaQueries;
  FreeAndNil(strsAplicacao);
  FreeAndNil(objRequisicao);

  FreeAndNil(cdsDigMultLoja);

  FreeAndNil(objTransfere);

  cdsItensConf.EmptyDataSet;

  If Assigned(frmSelPedidoCompraImpressao) Then
    FreeAndNil(frmSelPedidoCompraImpressao);

  FreeAndNil(qryConOpe);

  sltItems.Clear;
  FreeAndNil(sltItems);

  FreeAndNil(objDuplicatasPedido);

  FreeAndNil(objRequisicao);

  If Assigned(stlAutIncrem) Then FreeAndNil(stlAutIncrem);

  inherited;

  SetLength(arrCampos, 0);
  SetLength(arrCamposAgg, 0);
end;

procedure TfrmPedidoDeCompra.pEscapePressed;
begin
  Close;
end;

procedure TfrmPedidoDeCompra.pExibirDescontos(
  recDescontoItem: TRecDescontoItem);
begin
  If objCopiaSeg.recPcmger.blnSomaDescontoAdcionalFornecedor1  Then
    edtDesUni.text :=  FloatToStrF(recDescontoItem.arrDesUni[DESCONTO1] +  StrToFloatDef(edtDesAdi.Text, 0), ffNumber, 12, recDescontoItem.intDecUni)
  Else
    edtDesUni.text :=  FloatToStrF(recDescontoItem.arrDesUni[DESCONTO1], ffNumber, 12, recDescontoItem.intDecUni);
  edtDesUn2.text :=  FloatToStrF(recDescontoItem.arrDesUni[DESCONTO2], ffNumber, 12, recDescontoItem.intDecUni);
  edtDesUn3.text :=  FloatToStrF(recDescontoItem.arrDesUni[DESCONTO3], ffNumber, 12, recDescontoItem.intDecUni);
  edtDesUn4.text :=  FloatToStrF(recDescontoItem.arrDesUni[DESCONTO4], ffNumber, 12, recDescontoItem.intDecUni);
  edtDesUn5.text :=  FloatToStrF(recDescontoItem.arrDesUni[DESCONTO5], ffNumber, 12, recDescontoItem.intDecUni);
  edtDesUn6.text :=  FloatToStrF(recDescontoItem.arrDesUni[DESCONTO6], ffNumber, 12, recDescontoItem.intDecUni);
end;

procedure TfrmPedidoDeCompra.pExibirRelPedidoCompraGrid(const strCodIte,
  strDesIte: String; strExibirFornec: String = '');
begin

  If Not fVerificaAcessoSistema('CPPECG', strLoginUsuarioLogado) Then
  begin
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
    Exit;
  end;


 try
    pCriarFormularios(TfrmRelEstPedCompraGrid, frmRelEstPedCompraGrid);
    frmRelEstPedCompraGrid.strCodIte := strCodIte;
    frmRelEstPedCompraGrid.strDesIte := strDesIte;
    frmRelEstPedCompraGrid.strExiFor := strExibirFornec;
    frmRelEstPedCompraGrid.blnOriConsulPro := True;
    frmRelEstPedCompraGrid.blnExibirUnitario:= False;
    frmRelEstPedCompraGrid.ShowModal;
  finally
    FreeAndNil(frmRelEstPedCompraGrid);
  end;
end;

procedure TfrmPedidoDeCompra.FormClose(Sender: TObject;
  var Action: TCloseAction);
  Var
    strMsg: String;
begin
  inherited;

  If Not blnSalvouPedido Then
  Begin
    blnSalvouPedido := False;

    If objCopiaSeg.recPcmger.blnRecuperaPedido Then
    Begin
      strMsg := 'O pedido corrente foi recuperado, porém ainda não foi salvo.' + #13#10 +
                'Ao sair as alterações recuperadas serão perdidas. Deseja prosseguir?';
    End Else
      strMsg := 'Deseja cancelar o documento?';

    If (fMensagem('', strMsg, ['&Sim', '&Não'], 2) = 2) Then
    Begin
      Action := caNone;
      Exit;
    End;

    If Assigned(cdsDigMultLoja) And Assigned(cdsDigMultLoja.objPreparaGerMultiLoja) And cdsDigMultLoja.objPreparaGerMultiLoja.fPossuiDigitados Then
    Begin

      If fPergunta('Há preparações de TE digitadas, deseja salvá-las?') Then
      Begin

        If cdsDigMultLoja.objPreparaGerMultiLoja.fSalvaDigitados(True) Then
        Begin
          cdsDigMultLoja.objPreparaGerMultiLoja.cdsIteLib.EmptyDataSet;
          pMensagemOk('Preparação de Transferência de Estoque gerada com sucesso!');
        End Else
        Begin
          Action := caNone;
          Exit;
        End;

      End

      Else cdsDigMultLoja.objPreparaGerMultiLoja.cdsIteLib.EmptyDataSet;

    End;

  End;

  pSalvaConfiguracoesGrid;

  strNumPed := '';
  strEspDoc := '';
  strEspOri := '';
end;

procedure TfrmPedidoDeCompra.edtCodCmpExit(Sender: TObject);
begin
  inherited;

  If edtCodDig.Visible Then
  Begin
    If fValidaCampos(edtCodCmp) Then
      objCreditoFornecedor.strCodOpe := edtCodCmp.Text;
  End
  Else
     objCreditoFornecedor.strCodOpe := fRetCodVendedor(edtCodCmp.Text);

  lblCreFor.Visible := Not objCreditoFornecedor.IsEmpty;
end;

procedure TfrmPedidoDeCompra.edtCodForExit(Sender: TObject);
begin
  inherited;

  If blnFormShow Then
    Exit;

  If Assigned(cdsDigMultLoja) Then
    cdsDigMultLoja.strCodFor := edtCodFor.Text;

  objCreditoFornecedor.strCodFor := edtCodFor.Text;
  lblCreFor.Visible := Not objCreditoFornecedor.IsEmpty;

  If (not fEmptyStr(edtCodFor.Text)) and blnExibirObs  Then
  Begin
    TfrmMostraObsFornecedor.pMostrarObservacaoFornecedor(edtCodFor.Text);
    blnExibirObs := False;
  End;

  If (blnNovoReg) And (Not fLiberaTravaValidadeCertGestao(edtCodFor.Text)) Then
    pSetFocus(edtCodFor);

end;

procedure TfrmPedidoDeCompra.edtCodForKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
    objPnlLegenda: TPanelCxFornecedor;
begin
  inherited;
  If fEntraCons(Key) Then
  begin
    frmPnlDadosFornecedor := TfrmPnlDadosFornecedor.Create(nil);
    objPnlLegenda := TPanelCxFornecedor.Create(TfrmPnlDadosFornecedor);

    If fPesqFornecedor(conForCompleta, Self, edtCodFor, edtNomFor, qryConFor, Key, arrSel, True, objPnlLegenda) Then
    Begin
      If fValidaCampos(edtCodFor) Then
        SelectNext(ActiveControl, True, True);
    End;

    FreeAndNil(objPnlLegenda);
    pFreeAndNil(frmPnlDadosFornecedor);
  End;
end;

function TfrmPedidoDeCompra.fValidaDataFaturamento(
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  Try

    If fDataEmpty(mskDtaFat.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A data do faturamento deve ser preenchida!', ['&O k']);
      Result := False;
    End;

    objCopiaSeg.dtaDtaFatP := StrToDateDef(mskDtaFat.Text, VS_Date);

  Finally
    If Not Result Then
      pMostraDadosGerais;
  End;

end;

function TfrmPedidoDeCompra.fValidaUnidade(
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If blnBuscaPorChave Then
  Begin
    If fEmptyStr(edtCodUni.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A unidade deve ser preenchida!', ['&O k']);
      Result := False;
    End

    Else If fEmptyStr(fRetSiglaUnidade(edtCodUni.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A unidade não encontrada!', ['&O k']);
      Result := False;
    End;
  End;

end;

function TfrmPedidoDeCompra.fValidaComprador(blnBuscaPorChave: Boolean): Boolean;
  var
    strCodVen: String;
    strCodComprador: String;
Begin
  strCodVen := '';
  edtNomCmp.Text := '';
  If Assigned(objCopiaSeg) Then
    If Not Assigned(objCopiaSeg.onAfterSetID_Restauracao) Then
      objCopiaSeg.onAfterSetID_Restauracao := pAjustaAutoincremCdsMultiLoja_PREPTE;

  If edtCodCmp.Text <> '' Then
  Begin
    strCodComprador := edtCodCmp.Text;
    If edtCodDig.Visible Then
      edtNomCmp.Text := fRetNomVendRep(edtCodCmp.Text)
    Else
    Begin
      strCodVen := fRetCodVendedor(edtCodCmp.Text);
      strCodComprador := strCodVen;
      If not fEmptyStr(strCodVen) Then
        edtNomCmp.Text := fRetNomVendRep(strCodVen);
    End;
  End;

  Result := Not fEmptyStr(edtNomCmp.Text);

  If Result And ((Not fOperadorAtivo(strCodComprador)) Or (Not fVerificaAcessoSistema('frmMenuPedCom', strCodComprador))) Then
  Begin
    If Not fOperadorAtivo(strCodComprador) Then
      pMensagemOk('Comprador inativo!')
    Else
      pMensagemOk('Comprador sem acesso ao pedido de compra!');
    edtNomCmp.Text := '';
    Result := False;
    Exit;
  End;

  Try

    If Result Then
    Begin
      If blnBuscaPorChave And fTemItensDeOutroResponsavel Then
        Result := fLiberaAlteracaoOutroResponsavel('PEDIDO COM ITENS DE OUTRO RESPONSÁVEL PELO GRUPO DE COMPRAS!', '');
    End
    Else
    Begin
      If edtCodDig.Visible Then
        pMensagemOk('Código do comprador inválido!')
      Else
        pMensagemOk('Senha do comprador inválida!');
    End;

    If Result Then
      objCopiaSeg.strCompraP := fTrataCodCmp;

  Finally
    If Not Result Then
      pMostraDadosGerais;
  End;

End;

function TfrmPedidoDeCompra.fValidaDiaEnt(blnBuscaPorChave: Boolean): Boolean;
Begin
  Result := True;

  If edtDiaEnt.Visible Then
  Begin
    mskDtaEnt.Text := DateToStr(StrToDateDef(MskDtaFat.Text, VS_Date) + StrToIntDef(edtDiaEnt.Text, 0));
  End;
End;

Procedure TfrmPedidoDeCompra.pInicializaDiaEnt(intDiaFor: Integer);
Begin
  If fEmptyStr(edtDiaEnt.Text) Then
    edtDiaEnt.Text := IntToStr(intDiaFor);

  mskDtaEnt.Text := DateToStr(StrToDateDef(MskDtaFat.Text, VS_Date) + StrToIntDef(edtDiaEnt.Text, 0));
End;

function TfrmPedidoDeCompra.fValidaDtaEnt(blnBuscaPorChave: Boolean): Boolean;
Begin
  Result := True;

  If (Not blnConfDocumento) Then
  Begin

    If mskDtaEnt.Visible Then
    Begin

      If fDataEmpty(mskDtaEnt.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data de entrega do item deve ser preenchida!', ['&O k']);
        Result := False;
      End

      Else edtDiaEnt.Text := IntToStr(Trunc(StrToDateDef(mskDtaEnt.Text, VS_Date) - StrToDateDef(mskDtaFat.Text, VS_Date)));
    End;

  End;

End;

function TfrmPedidoDeCompra.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
Var
  blnCalculaTotalImp: Boolean;
  begin
  blnMudarFoco := True;

  Result := True;

  If (Sender = edtCodFor) Then
  Begin

    If (Not blnImportandoRequisicoesAutomatica) Or (Not fEmptyStr(edtCodFor.Text)) Then
    Begin

      Result := fValidaFornecedor(blnBuscaPorChave);

      If (Result) And fEmptyStr(strCodCta) And (Not fEmptyStr(edtCodFor.Text)) Then
        pCarregarCodPlanoDeContasForn;


    End;

  End

  Else If (Sender = mskDtaFat) Then
  Begin
    Result := fValidaDataFaturamento(blnBuscaPorChave);
  End

  Else If (Sender = mskDtaPed) Then
  Begin
    Result := fValidaDataEntrega(blnBuscaPorChave);
  End

  Else If (Sender = edtCodCmp) Then
  Begin
    Result := fValidaComprador(blnBuscaPorChave);
  End

  Else If (Sender = edtQtdCtn) Then
  Begin
    Result := fValidaQtdCtn(blnBuscaPorChave);
  End

  Else If (Sender = mskCndPag) Then
  Begin

    If (Not blnImportandoRequisicoesAutomatica) Then
      Result := fValidaCondPagamento(blnBuscaPorChave);

  End

  Else If (Sender = edtDesAdi) Then
  Begin
    Result := fValidaDescontoAdicional(blnBuscaPorChave);
  End

  Else If (Sender = edtCodIte) Then
  Begin

  End

  Else If (Sender = edtDesIte) Then
  Begin
    Result := fValidaDescricao(blnBuscaPorChave);
  End

  Else If (Sender = edtCodUni) Then
  Begin
    Result := fValidaUnidade(blnBuscaPorChave);
  End

  Else If (Sender = edtEmbala) Then
  Begin

    If edtEmbala.Visible Then
    Begin

      If fStrToFloat(edtEmbala.Text) <= 0 Then
      Begin
        pMensagemOk('O campo embalagem deve ser maior que zero!');
        Result := False;
      End;

    End;

  End

  Else If (Sender = edtQtdIte) Then
  Begin
    Result := fValidaQuantidade(blnBuscaPorChave);
  End

  ELse If (Sender = edtUnitar) Then
  Begin
    Result := fValidaUnitario(blnBuscaPorChave);
  End

  ELse If (Sender = edtDesUni) Then
  Begin
    If (strUniPcg[1] = '7') Then
    Begin
      If (fStrToFloat(edtDesUni.Text) > 0)  Then
        Result := fValidaDescontoUnitario(edtDesUni, edtDesUn2, edtDesUn3, edtDesUn4, edtDesUn5, edtDesUn6, blnBuscaPorChave);
    End
    Else
      Result := fValidaDescontoUnitario(edtDesUni, edtDesUn2, edtDesUn3, edtDesUn4, edtDesUn5, edtDesUn6, blnBuscaPorChave);
  End

  ELse If (Sender = edtDesUn2) Then
  Begin
    If (strUniPcg[1] = '7') Then
    Begin
      If (fStrToFloat(edtDesUn2.Text) > 0)  Then
        Result := fValidaDescontoUnitario(edtDesUn2, edtDesUn3, edtDesUn4, edtDesUn5, edtDesUn6, Nil, blnBuscaPorChave)
    End
    Else
      Result := fValidaDescontoUnitario(edtDesUn2, edtDesUn3, edtDesUn4, edtDesUn5, edtDesUn6, Nil, blnBuscaPorChave);
  End

  ELse If (Sender = edtDesUn3) Then
  Begin
    If (strUniPcg[1] = '7') Then
    Begin
      If (fStrToFloat(edtDesUn3.Text) > 0)  Then
        Result := fValidaDescontoUnitario(edtDesUn3, edtDesUn4, edtDesUn5, edtDesUn6, Nil, Nil, blnBuscaPorChave)
    End
    Else
      Result := fValidaDescontoUnitario(edtDesUn3, edtDesUn4, edtDesUn5, edtDesUn6, Nil, Nil, blnBuscaPorChave);
  End

  ELse If (Sender = edtDesUn4) Then
  Begin
    If (strUniPcg[1] = '7') Then
    Begin
      If(fStrToFloat(edtDesUn4.Text) > 0)  Then
        Result := fValidaDescontoUnitario(edtDesUn4, edtDesUn5, edtDesUn6, Nil, Nil, Nil, blnBuscaPorChave)
    End
    Else
      Result := fValidaDescontoUnitario(edtDesUn4, edtDesUn5, edtDesUn6, Nil, Nil, Nil, blnBuscaPorChave);
  End

  ELse If (Sender = edtDesUn5) Then
  Begin
    If (strUniPcg[1] = '7') Then
    Begin
      If (fStrToFloat(edtDesUn5.Text) > 0)  Then
        Result := fValidaDescontoUnitario(edtDesUn5, edtDesUn6, Nil, Nil, Nil, Nil, blnBuscaPorChave)
    End
    Else
      Result := fValidaDescontoUnitario(edtDesUn5, edtDesUn6, Nil, Nil, Nil, Nil, blnBuscaPorChave);
  End

  ELse If (Sender = edtDesUn6) Then
  Begin
    If (strUniPcg[1] = '7') Then
    Begin
      If (fStrToFloat(edtDesUn6.Text) > 0)  Then
        Result := fValidaDescontoUnitario(edtDesUn6, edtDesUn6, Nil, Nil, Nil, Nil, blnBuscaPorChave)
    End
    Else
      Result := fValidaDescontoUnitario(edtDesUn6, Nil, Nil, Nil, Nil, Nil, blnBuscaPorChave);
  End

  Else If (Sender = edtPerIpi) Then
  Begin
    Result := fValidaPerIpi(edtPerIpi, blnBuscaPorChave);
  End
  Else If (Sender = edtPerImp) Then
  Begin
    Result := fValidaPerImp(blnBuscaPorChave);
  End

  Else If (Sender = edtPerIpiImp) Then
  Begin
    Result := fValidaPerIpi(edtPerIpiImp, blnBuscaPorChave);
  End

  Else If (Sender = edtAlqCbs) Or (Sender = edtAlqIbs) Or (Sender = edtAlq_Is) Then
  Begin
    Result := fValidaAlqReforma(TEditFocus(Sender), blnBuscaPorChave);
  End

  Else If (Sender = edtPerPis) Then
  Begin
    Result := fValidaPerPis(blnBuscaPorChave);
  End

  Else If (Sender = edtPerCof) Then
  Begin
    Result := fValidaPerCof(blnBuscaPorChave);
  End

  Else If (Sender = edtPerSub) Then
  Begin
    Result := fValidaPerSub(blnBuscaPorChave);
  End

  Else If (Sender = edtTotSub) Then
  Begin

    Result := fValidaTotSub(blnBuscaPorChave);

  End

  Else If (Sender = edtIcmDes) Then
  Begin

    Result := fValidaIcmDes(blnBuscaPorChave);

  End

  Else If (Sender = edtDiaEnt) Then
  Begin

    Result := fValidaDiaEnt(blnBuscaPorChave);

  End

  Else If (Sender = edtCodDig) And (edtCodDig.Visible) Then
  Begin
    If fEmptyStr(edtCodDig.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Digitador deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else
    Begin
      pCarregaDigitador;
      If qryConOpe.FieldbyName('OPE_CODOPE').IsNull Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse digitador não está cadastrado!', ['&O k']);
        Result := False;
      End;
    End;
    If Not Result Then
    begin
      edtCodDig.Text := '';
      edtNomDig.Text := '';
    end
  End

  Else If (Sender = mskDtaEnt) Then
  Begin

    Result := fValidaDtaEnt(blnBuscaPorChave) And fValidaDiaEnt(blnBuscaPorChave);

  End;

  If (Not Result) Then
  Begin

    If (Sender = edtCodDig) Then
      pMostraDadosGerais;

    If Sender.CanFocus Then
      pSetFocus(Sender)


  End
  Else If blnBuscaPorChave Then
  Begin
    If (Sender <> edtTotSub) And (Sender <> edtIcmDes) And (Sender <> edtSubFCP) Then
    Begin
      blnCalculaTotalImp := chkPedImp.Checked And (
                             (Sender = edtPerImp) Or
                             (Sender = edtPerIpiImp) Or
                             (Sender = edtPerPis) Or
                             (Sender = edtPerCof));

      pCalculaTotalItem((Sender = edtQtdIte) Or
                        (Sender = edtUnitar) Or
                        (Sender = edtDesUni) Or
                        (Sender = edtDesUn2) Or
                        (Sender = edtDesUn3) Or
                        (Sender = edtDesUn4) Or
                        (Sender = edtDesUn5) Or
                        (Sender = edtDesUn6) Or
                        blnCalculaTotalImp);
    End;
  End;
end;

Procedure TfrmPedidoDeCompra.pInicializaDtaPed;
Begin
  If blnEntIte And blnOriIte Then
    mskDtaPed.Text := DateToStr(VS_Date)
  Else
    mskDtaPed.Text := DateToStr(VS_Date + fGetDiaFor);
End;

function TfrmPedidoDeCompra.fValidaFornecedor(blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  Try
    If fEmptyStr(edtCodFor.Text) Then
    Begin
      If blnCarregandoRequisicoes Then
      Begin
        Result := True;
        Exit;
      End;

      fMensagem('ATENÇÃO!', 'O código do fornecedor deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else If qryConFor.IsEmpty Or (qryConFor.FieldByName('FOR_CODFOR').AsString <> edtCodFor.Text) Or
            (strCodForAnt <> edtCodFor.Text) Then
    Begin
      pCarregaFornecedor(False);
      If qryConFor.FieldByName('FOR_CODFOR').IsNull Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse fornecedor não está cadastrado!', ['&O k']);
        Result := False;
      End;
    End;

    If (Result) And (strCodForAnt <> edtCodFor.Text) Then
    Begin
      If blnPRFEFE Then
      Begin
        recOpcGir.strCodTab := 'ITEGER';
        if strPrF_AE = 'E' Then
          Result := TfrmNotificaAtivacaoTabPreFor.fEscolheTabelaAUtilizar(edtCodFor.Text, recOpcGir.strCodTab);
      End;

      pInicializaDtaPed;

      blnCalculouSub := fRecalcularSubstituicaoTributaria;

      If blnPermitirCompradorEscolherCodigoFabrica Then
        pRecalculaCodigoFabricaDoProduto;

      strCodForAnt := edtCodFor.Text;
    End;

    if Result And (strPrF_AE = 'E') Then
    Begin
      pSetCaptionForm;
      If recOpcGir.strCodTab <> 'ITEGER' then
        Self.Caption := Self.Caption + ' - Utilizando Tabela de Preço do Fornecedor: ' +recOpcGir.strCodTab + ' - ' + fRetNomeTabelaPreco(recOpcGir.strCodTab)
      Else
        Self.Caption := Self.Caption + ' - Utilizando Tabela de Preço do Cadastro de Produtos';
    End;

    If Result Then
    begin
      objCopiaSeg.strCodForP := edtCodFor.Text;

      if Not cdsItensPedido.IsEmpty then
        pAtualizaTotalTela;
    end;

  Finally
    If Not Result Then
      pMostraDadosGerais;
  End;
end;

procedure TfrmPedidoDeCompra.pCarregaFornecedor(blnCarregandoPedido: Boolean; strCnpj: String = '');
  Var
    strCndPag: String;
    strSQL: String;
    blnRecalculaItens: Boolean;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CADFOR.*, ';
  strSQL := strSQL + '  CID_ESTADO AS FOR_ESTADO ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFOR, ';
  strSQL := strSQL + '  CADCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FOR_CODCID = CID_CODCID AND ';
  If Not fEmptyStr(strCnpj) then
  Begin
    strSQL := strSQL + '  FOR_C_G_C_ = :C_G_C_ AND ';
  End
  Else
  Begin
    strSQL := strSQL + '  FOR_CODFOR = :CODFOR AND ';
    strSQL := strSQL + '  FOR_C_G_C_ IS NOT NULL AND ';
  End;
  strSQL := strSQL + '  FOR_STATUS = "A" ';

  With qryConFor Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    If Not fEmptyStr(strCnpj) then
      ParamByName('C_G_C_').AsString := strCnpj
    Else
      ParamByName('CODFOR').AsString := edtCodFor.Text;
    Open;

    ParametrosCalcImpostos.Param_Fornecedor.pCarregaConfiguracoes(qryConFor);
    edtNomFor.Text := qryConFor.FieldByName('FOR_NOMFOR').AsString;
    strCndPag      := FieldByName('FOR_CNDPAG').AsString;
    fltDesVis      := FieldByName('FOR_DESVIS').AsFloat;
    intCarPag      := FieldByName('FOR_CARPAG').AsInteger;
    strRedPis      := FieldByName('FOR_REDPIS').AsString;
    fltPisCof      := FieldByName('FOR_PISCOF').AsFloat;
    strSimPau      := FieldByName('FOR_SIMPAU').AsString;
    blnUsaColeta   := (FieldByName('FOR_CONCOL').AsString = 'S') And blnConCol;

    objCopiaSeg.recPcmger.blnUsaColeta := blnUsaColeta;

    blnTemDare     := fEhEmpresaDARE And
                      (Not fEhEstadoRegraZonaFranca(FieldByName('FOR_ESTADO').AsString));

    edtValDar.Visible := blnTemDare;
    lblValDar.Visible := blnTemDare;

    strTipAbfFor := fGetTipoAbfFornecedor(edtCodFor.Text);

    If fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text)) Then
      mskCndPag.Text := strCndPag;

    If ((fStatusCndPag(strCndPag) = A_VISTA) Or chkPgAVis.Checked) And (strCodForAnt <> edtCodFor.Text) And
       (Not blnCarregandoPedido) Then
    Begin
      blnRecalculaItens := fltDesVis <> fStrToFloat(edtDesAdi.Text);
      edtDesAdi.Text    := FloatToStrF(fltDesVis, ffNumber, 12, 2);
      fltPerDesAdiOLD   := fStrToFloat(edtDesAdi.Text);

      If blnRecalculaItens Then
        pRecalculaPorcentagemItens;
    End;

    If Not blnCarregandoPedido Then
    Begin
      chkPedImp.Checked := FieldByName('FOR_PEDIMP').AsString = 'S';
      chkPreDol.Checked := FieldByName('FOR_PEDDOL').AsString = 'S';
    End;
  End;
end;

procedure TfrmPedidoDeCompra.chkPedBonClick(Sender: TObject);
begin
  inherited;

  objCopiaSeg.strPedBonP := IfThen(chkPedBon.Checked, 'S', 'N');
end;

procedure TfrmPedidoDeCompra.chkPedImpClick(Sender: TObject);
begin
  inherited;
  If (chkPedImp.Checked) Then
  Begin
    edtQtdCtn.Text    := '1';
    edtQtdCtn.Visible := True;
    lblQtdCtn.Visible := True;
    rdgDesPdi.Visible   := (fCfgSis('PEDIMP', varBoolean)) And (fCfgSis('PUTDFB', varBoolean));
    rdgDesPdi.ItemIndex := 0;
  End
  Else
  Begin
    edtQtdCtn.Text    := '0';
    edtQtdCtn.Visible := False;
    lblQtdCtn.Visible := False;
    rdgDesPdi.Visible   := False;
    rdgDesPdi.ItemIndex := 0;
  End;
  If blnPedImpAnt <> chkPedImp.Checked Then
    pRecalculaIpiItens;

  pAjustaTipoPedido(chkPedImp.Checked);

  objCopiaSeg.strPedImpP := IfThen(chkPedImp.Checked, 'S', 'N');
  objCopiaSeg.strDesPdiP := IfThen(rdgDesPdi.ItemIndex = 0, 'P','F');
end;

procedure TfrmPedidoDeCompra.chkPedImpEnter(Sender: TObject);
begin
  inherited;
  blnPedImpAnt := chkPedImp.Checked;
end;

procedure TfrmPedidoDeCompra.chkPedIntClick(Sender: TObject);
begin
  inherited;

  objCopiaSeg.strPedIntP := IfThen(chkPedInt.Checked, 'S', 'N');
end;

procedure TfrmPedidoDeCompra.chkPgAVisClick(Sender: TObject);
  Var
    blnRecalculaItens: Boolean;
begin
  inherited;
  If chkPgAVis.Checked Then
  Begin
    If (intCarPag = 0) Then
      mskCndPag.Text := '01000'
    Else
      mskCndPag.Text := '01' + fStrZero(intCarPag, 3);
    mskCndPag.Enabled := False;

    objCopiaSeg.strConPagP := mskCndPag.Text;
  End
  Else
    mskCndPag.Enabled := True;

  If chkPgAVis.Checked Then
  Begin
    blnRecalculaItens := fltDesVis <> fStrToFloat(edtDesAdi.Text);
    edtDesAdi.Text    := FloatToStrF(fltDesVis, ffNumber, 12, 2);
    fltPerDesAdiOLD   := fStrToFloat(edtDesAdi.Text);

    If blnRecalculaItens And (Not blnLoadPedido) Then
      pRecalculaPorcentagemItens;
  End Else
  Begin
    blnRecalculaItens := 0 <> fStrToFloat(edtDesAdi.Text);
    edtDesAdi.Text    := '0,00';
    fltPerDesAdiOLD   := fStrToFloat(edtDesAdi.Text);

    If blnRecalculaItens And (Not blnLoadPedido) Then
      pRecalculaPorcentagemItens;
  End;

end;

procedure TfrmPedidoDeCompra.chkPreDolClick(Sender: TObject);
begin
  inherited;

  objCopiaSeg.intMoedaP := IfThen(chkPreDol.Checked, INT_MOEDA_DOLAR, INT_MOEDA_REAL);
end;

procedure TfrmPedidoDeCompra.chkSuspOrdemClick(Sender: TObject);
begin
  inherited;

  If chkSuspOrdem.Checked Then
    pSalvaOrdenacao;

  TMycxGridDBDataController(cxvItens.DataController).blnOrdenar := Not chkSuspOrdem.Checked;

  cxvItens.DataController.Refresh;

  If Not chkSuspOrdem.Checked Then
    pSalvaOrdenacao;
end;

procedure TfrmPedidoDeCompra.chkZeraSTClick(Sender: TObject);
begin
  inherited;
  If Not chkZeraST.Visible Then
    Exit;
  objCopiaSeg.strZeraSTP := IfThen(chkZeraST.Checked, 'S', 'N');
  blnSuspendeEventoPost := False;
  Try
     fRecalcularSubstituicaoTributaria;
  Finally
    blnSuspendeEventoPost := True;

  End;
  pAtualizaDados(cdsItensPedido, False, True);
end;

procedure TfrmPedidoDeCompra.pMensagemPedidoCompraLiberar(strCodEmp, strNumPed,
  strEspDoc, strCodFor : String; dtaDtaPed, dtaDtaEnt: TDateTime;
  fltTotGer: Double; blnInclusao: Boolean);
Var
  msgMensagem: TMsgInterna;
  qryCadOpe  : TUniQuery;
  stlMensagem: TStringList;
Begin
  qryCadOpe   := fCriaQuery;
  With qryCadOpe, SQL Do
  Begin
    Clear;
    Add('SELECT OPE_CODOPE AS CODOPE FROM CADOPE');
    Add('WHERE LOCATE(:CODEMP, OPE_EMPACE) > 0 AND ');
    Add(' OPE_MSGPDL = "S"');
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;
    If Not IsEmpty Then
    Begin
      msgMensagem := TMsgInterna.Create(Nil);
      stlMensagem := TStringList.Create;
      stlMensagem.Clear;
      stlMensagem.Add('-------------------------------------------------------------------- ');
      stlMensagem.Add('             Liberação de Pedido de Compra                           ');
      stlMensagem.Add('-------------------------------------------------------------------- ');
      stlMensagem.Add('                                                                     ');
      If blnInclusao then
        stlMensagem.Add(' [ Novo pedido de compra incluido ]                                ')
      Else
        stlMensagem.Add(' [ Alteração de pedido de compra ]                                 ');
      stlMensagem.Add('                                                                     ');
      stlMensagem.Add(' Pedido     : '+ strNumPed + ' - ' + strEspDoc + ' - ' + strCodEmp    );
      stlMensagem.Add(' Dt.Pedido  : '+ DateToStr(dtaDtaPed)                                 );
      stlMensagem.Add(' Dt.Entrega : '+ DateToStr(dtaDtaEnt)                                 );
      stlMensagem.Add(' Fornecedor : '+ strCodFor +' - ' + fRetNomFornecedor(strCodFor)      );
      stlMensagem.Add(' Vr.Pedido  : '+ FloatToStrF(fltTotGer,ffFixed, 12, 2)                );
      stlMensagem.Add(' Comprador  : '+ fRetCodVendedor(edtCodCmp.Text)+' - '+edtNomCmp.Text );
      While Not Eof Do
      Begin
        msgMensagem.fEnviaMensagem('LIBERAÇÃO DE PEDIDO DE COMPRA ( ' + strNumPed + ' - ' + strEspDoc + ' )',
                                   stlMensagem.Text, strLoginUsuarioLogado, FieldByName('CODOPE').AsString, 'N', '');
        Next;
      End;
      FreeAndNil(msgMensagem);
      FreeAndNil(stlMensagem);
    End;
    Close;
  End;
  FreeAndNil(qryCadOpe);
end;

procedure TfrmPedidoDeCompra.pMostraColunasUnitarioLiquido(blnMostrar: Boolean);
Begin
  cxvItensDESUNI.Visible := blnMostrar;
  cxvItensDESUN2.Visible := blnMostrar;
  cxvItensDESUN3.Visible := blnMostrar;
  cxvItensDESUN4.Visible := blnMostrar;
  cxvItensDESUN5.Visible := blnMostrar;
  cxvItensDESUN6.Visible := blnMostrar;
  cxvItensUNILIQ.Visible := blnMostrar;

  cxvItensDESUNI.Width := 50;
  cxvItensDESUN2.Width := 50;
  cxvItensDESUN3.Width := 50;
  cxvItensDESUN4.Width := 50;
  cxvItensDESUN5.Width := 50;
  cxvItensDESUN6.Width := 50;
  cxvItensUNILIQ.Width := 90;
End;

procedure TfrmPedidoDeCompra.ComposicaodeCustoClick(Sender: TObject);
begin
  inherited;
  If fEmptyStr(cdsItensPedido.FieldByName('ITE_CODITE').AsString) Then
    Exit;
  If fVerificaAcessoSistema('VISCUS', strLoginUsuarioLogado) Then
    pMostraComposicaoPrecoCusto(cdsItensPedido.FieldByName('ITE_CODITE').AsString)
  Else
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
end;

procedure TfrmPedidoDeCompra.pMostraComposicaoPrecoCusto(strCodIte: String);
var
  frmCadProdutosCompCusto : TfrmCadProdutosCompCusto;
begin
  Try

    pCriarFormularios(TfrmCadProdutosCompCusto, frmCadProdutosCompCusto);
    frmCadprodutosCompCusto.strCodIte := strCodIte;
    frmCadprodutosCompCusto.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pMostraComposicaoPrecoCusto]');
    End;
  End;
  pFreeAndNil(frmCadprodutosCompCusto);
end;

Procedure TfrmPedidoDeCompra.pAjustaSubIcms(strCst, strCstOrigem: String);
Begin
  edtTotSub.Enabled := (Pos(strCst, CST_SUBSTITUICAO) > 0);
  edtIcmDes.Enabled := (strSimPau <> 'S') And ((Pos(strCst, CST_TRIBUTADO) > 0) Or ((Pos(strCst, CST_SUBSTITUICAO) > 0) And (strRedPis = 'S')));
  edtPerSub.Enabled := edtTotSub.Enabled;

  If blnTemDare Then
  Begin
    edtValDar.Enabled := (Pos(strCst, CST_SUBSTITUICAO) > 0) And (Pos(strCstOrigem, CST_SUBSTITUICAO) = 0);
    lblValDar.Enabled := edtValDar.Enabled;

    If edtValDar.Enabled Then
    Begin
      edtTotSub.Enabled := False;
      edtIcmDes.Enabled := False;
      edtPerSub.Enabled := False;
    End;

    If Not edtValDar.Enabled Then
      edtValDar.Text := '0,00';
  End;
End;

procedure TfrmPedidoDeCompra.cxgItensEnter(Sender: TObject);
begin
  inherited;

  If (recOpcGir.strPedMlj <> 'S') And (blnUsarGiro Or blnAltPedGir) Then
  Begin
    pnlInfo.Caption := '[F2] Giro de estoque analítico';
  End;

  pAtualizaDados(Nil);

  cdsItensPedido.AfterScroll := pAferScroll;
  pAferScroll(cdsItensPedido);
end;

procedure TfrmPedidoDeCompra.cxgItensExit(Sender: TObject);
begin
  inherited;

  If recOpcGir.strPedMlj <> 'S' Then
  Begin
    pnlInfo.Caption := '';
  End;

  cdsItensPedido.AfterScroll := Nil;
end;

procedure TfrmPedidoDeCompra.cxvItensCellClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  blnAtualizarRodape := True;
  tmrAtualizaRodape.Enabled := True;
end;

procedure TfrmPedidoDeCompra.cxvItensColumnHeaderClick(Sender: TcxGridTableView;
  AColumn: TcxGridColumn);
begin
  inherited;

  chkSuspOrdem.Checked := False;

  inherited;

  pSalvaOrdenacao;

  // PEGA A ORDENAÇÃO E GUARDA PARA USA NO DoSort;
end;

procedure TfrmPedidoDeCompra.cxvItensCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    indexProd: Integer;
begin
  inherited;

  If Not Assigned(stlProdutosMarcados) Then
    Exit;

  If Not Assigned(cdsItensPedido) Then
    Exit;

  If cdsItensPedido.isEmpty Then
    Exit;

  If stlProdutosMarcados.Find(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensCODITE.Index]), indexProd) Then
  Begin
    ACanvas.Font.Color := clBlack;
    ACanvas.Brush.Color := clYellow;
  End
  Else If ((fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensQTDREQ.Index])) > 0) And (Not (blnSitPro and blnCorIpd))) Then
  Begin
    ACanvas.Font.Color := $000958FF;
  End
  Else If blnSitPro And blnCorIpd Then
  Begin
    If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensDESSIT.Index]) <> '') Then
      ACanvas.Font.Color := StrToIntDef(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensCORSIT.Index]),0);
  End;

  If ACanvas.Font.Color = ACanvas.Brush.Color Then
    ACanvas.Font.Color := clBlue;
end;

procedure TfrmPedidoDeCompra.cxvItensDataControllerCompare(
  ADataController: TcxCustomDataController; ARecordIndex1, ARecordIndex2,
  AItemIndex: Integer; const V1, V2: Variant; var Compare: Integer);
var
   intPosition1, intPosition2: Integer;
begin

  If chkSuspOrdem.Checked then
  Begin

    intPosition1 := fGetPositionByRecordIndex(ARecordIndex1);
    intPosition2 := fGetPositionByRecordIndex(ARecordIndex2);

    If cxvItens.SortedItemCount > 0 Then
    Begin
    If cxvItens.SortedItems[0].SortOrder = soAscending Then
      Compare := VarCompare(intPosition1, intPosition2)
    Else
      Compare := VarCompare(intPosition2, intPosition1);
    End;

  End Else
  Begin

    Compare := VarCompare(V1, V2);

  End;

end;

procedure TfrmPedidoDeCompra.cxvItensDblClick(Sender: TObject);
begin
  inherited;
  pAtivaItem;
end;

procedure TfrmPedidoDeCompra.cxvItensInitEdit(Sender: TcxCustomGridTableView;
  AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit);
begin
  inherited;

  fltQtdAnt := cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat;
end;

procedure TfrmPedidoDeCompra.cxvItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If ((Key In [VK_UP,VK_DOWN]) And (ssShift In Shift)) Then
    pMarcaDesmarcaProduto;

end;

Procedure TfrmPedidoDeCompra.pMarcaDesmarcaProduto;
  Var
    indexProd: Integer;
Begin
  If cdsItensPedido.IsEmpty Then
    Exit;

  If cdsItensPedido.State In dsEditModes Then
    cdsItensPedido.Post;

  If stlProdutosMarcados.Find(cdsItensPedido.FieldByName('ITE_CODITE').AsString, indexProd) Then
    stlProdutosMarcados.Delete(indexProd)
  Else
    stlProdutosMarcados.Add(cdsItensPedido.FieldByName('ITE_CODITE').AsString);
End;

procedure TfrmPedidoDeCompra.cxvItensMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  If (ssCtrl In Shift) Then
  Begin
    pMarcaDesmarcaProduto;
    cxvItens.DataController.Refresh;
  End;

end;

procedure TfrmPedidoDeCompra.cxvItensNUMEROGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  AText := (ARecord.Index + 1).ToString;
end;

procedure TfrmPedidoDeCompra.pCalculaUniImp(dataSet: TDataSet);
  Var
    recDescontoItem: TRecDescontoItem;

Begin
  recDescontoItem := fObterDescontosItem(False);
  pCalculaUniImp(dataSet, recDescontoItem);
End;

procedure TfrmPedidoDeCompra.pCalculaUniImp(dataSet: TDataSet;
  recDescontoItem: TRecDescontoItem);
  Var
    lQtdIte,
    lfltUnitar: Double;
begin
  lQtdIte := dataSet.FieldByName('ITE_QTDITE').AsFloat;
  lfltUnitar := recDescontoItem.fCalcularValorDescontado(objCopiaSeg.recPcmger.blnSomaDescontoAdcionalFornecedor1, dataSet.FieldByName('ITE_UNITAR').AsFloat);

  if lQtdIte > 0 then
  begin
    lfltUnitar := lfltUnitar +
                  RoundTo(((dataSet.FieldByName('ITE_TOTIPI').AsFloat / lQtdIte) +
                           (dataSet.FieldByName('ITE_TOTSUB').AsFloat / lQtdIte) +
                           (dataSet.FieldByName('ITE_SUBFCP').AsFloat / lQtdIte) +
                           (fTotalImpostosReformaItem(dataSet) / lQtdIte)),
                           -recDescontoItem.intDecUni);

  end;

  dataSet.FieldByName('ITE_UNIIMP').AsFloat := lfltUnitar;
end;


procedure TfrmPedidoDeCompra.pCalculaTotalItemQtdGrid(dataSet: TDataSet);
var fltVlrAliquotaSub: Double;
    fltAlqIPI: Double;
    fltBasIPI: Double;
    fltValIpi,
    fltRepFre,
    fltTotDar: Double;
    recDescontoItem: TRecDescontoItem;
begin
  recDescontoItem := fObterDescontosItemGrid;

  With dataSet Do
  Begin
    FieldByName('ITE_UNILIQ').AsFloat :=  RoundTo(RoundTo(recDescontoItem.fCalcularValorDescontado(objCopiaSeg.recPcmger.blnSomaDescontoAdcionalFornecedor1,FieldByName('ITE_UNITAR').AsFloat), -intDecUni), -2);

    FieldByName('ITE_DIFPRE').AsFloat  := Iif(FieldByName('ITE_PREULT').AsFloat = 0, 0,(((FieldByName('ITE_UNITAR').AsFloat - FieldByName('ITE_PREULT').AsFloat) / FieldByName('ITE_PREULT').AsFloat) * 100));

    ParametrosCalcImpostos.pSetaParametros(FieldByName('ITE_CICMDE').AsString,
                                           FieldByName('ITE_CDPIOP').AsString,
                                           FieldByName('ITE_DIDIOP').ASString);

    FieldByName('ITE_TOTITE').AsFloat := RoundTo(RoundTo( FieldByName('ITE_QTDITE').AsFloat *
                                                  recDescontoItem.fCalcularValorDescontado(objCopiaSeg.recPcmger.blnSomaDescontoAdcionalFornecedor1, FieldByName('ITE_UNITAR').AsFloat), -intDecUni), -2);

    fltAlqIpi := FieldByName('ITE_PERIPI').AsFloat;
    If chkPedImp.Checked Then
    Begin
      FieldByName('ITE_VALIMP').AsFloat := RoundTo(FieldByName('ITE_TOTITE').AsFloat * (FieldByName('ITE_ALQIMP').AsFloat / 100), -2);
      fltBasIpi := (FieldByName('ITE_TOTITE').AsFloat + FieldByName('ITE_VALIMP').AsFloat);

      fltRepFre := (FieldByName('ITE_VALFRE').AsFloat*100)/FieldByName('ITE_TOTITE').AsFloat;

      If (objCopiaSeg.recPcmger.strIPIFre = 'S') And (fltRepFre > 0) Then
        fltBasIpi := fltBasIpi + (fltBasIpi * fltRepFre /100);


      FieldByName('ITE_VALPIS').AsFloat := RoundTo(FieldByName('ITE_TOTITE').AsFloat * (FieldByName('ITE_ALQPIS').AsFloat / 100), -2);
      FieldByName('ITE_VALCOF').AsFloat := RoundTo(FieldByName('ITE_TOTITE').AsFloat * (FieldByName('ITE_ALQCOF').AsFloat / 100), -2);
      FieldByName('ITE_TOTSUB').AsFloat := 0;
      FieldByName('ITE_TOTDAR').AsFloat := 0;
      FieldByName('ITE_PERFCP').AsFloat := 0;
      FieldByName('ITE_SUBFCP').AsFloat := 0;


      fltValIpi := RoundTo(fltBasIpi * (fltAlqIpi / 100), -2);
    End
    Else
    Begin
      fltBasIpi := FieldByName('ITE_TOTITE').AsFloat;
      fltRepFre := (FieldByName('ITE_VALFRE').AsFloat*100)/FieldByName('ITE_TOTITE').AsFloat;

      If (objCopiaSeg.recPcmger.strIPIFre = 'S') And (fltRepFre > 0) Then
        fltBasIpi := fltBasIpi + (fltBasIpi * fltRepFre /100);


      If Not fEmptyStr(edtCodFor.Text) Then
      Begin
        fltTotSubCal := RoundTo(fCalcularSubstituicaoProduto(edtCodFor.Text,
                                                       fRetornaAbreviacaoItem(FieldByName('ITE_CODITE').AsString),
                                                       FieldByName('ITE_TOTITE').AsFloat,
                                                       FieldByName('ITE_VALFRE').AsFloat,
                                                       FieldByName('ITE_DESACE').AsFloat,
                                                       strFRMPCM,
                                                       objCopiaSeg.recPcmger.strBStFre,
                                                       objCopiaSeg.recPcmger.strBStAce,
                                                       blnZonaFranca,
                                                       FieldByName('ITE_INCPIS').AsString = 'S',
                                                       strSimPau = 'S',
                                                       blnTemDare,
                                                       fltAlqIpi,
                                                       chkZeraST.Checked,
                                                       fltBasIcmIte,
                                                       fltAlqIcmIte,
                                                       fltValIcmIte,
                                                       fltBaseSTIte,
                                                       fltDesPisIte,
                                                       fltBasIPI,
                                                       fltValIpi,
                                                       fltPerFCPIte,
                                                       fltSubFCPIte,
                                                       fltTotDar,
                                                       strCodSitIte,
                                                       strCodSitOrigemIte,
                                                       fltVlrAliquotaSub,
                                                       ParametrosCalcImpostos,
                                                       strTipAbfFor), -2);
       fltIcmDesCal := 0;
        If ParametrosCalcImpostos.blnCalcularICMSDesonerado Then
          fltIcmDesCal := fltValIcmIte;

        If FieldByName('ITE_SUBUSU').AsString <> 'S' Then
        Begin
          FieldByName('ITE_TOTSUB').AsFloat := fltTotSubCal;
          FieldByName('ITE_PERSUB').AsFloat := fltVlrAliquotaSub;
          If ParametrosCalcImpostos.blnCalcularICMSDesonerado Then
            FieldByName('ITE_VALICM').AsFloat := fltValIcmIte
          else
            FieldByName('ITE_VALICM').AsFloat := 0;

          fltVlrAlqSubOri := fltVlrAliquotaSub;

          FieldByName('ITE_TOTDAR').AsFloat := fltTotDar;
        End;

        FieldByName('ITE_BASICM').AsFloat  := fltBasIcmIte;
        FieldByName('ITE_PERBAS').AsFloat  := 100;
        FieldByName('ITE_ALQICM').AsFloat  := fltAlqIcmIte;
        FieldByName('ITE_DESPIS').AsFloat  := fltDesPisIte;
        FieldByName('ITE_BASSUB').AsFloat  := fltBaseSTIte;
        FieldByName('ITE_CODSIT').AsString := strCodSitIte;
        FieldByName('ITE_SITORI').AsString := strCodSitOrigemIte;
        FieldByName('ITE_PERFCP').AsFloat  := fltPerFCPIte;
        FieldByName('ITE_SUBFCP').AsFloat  := RoundTo(FieldByName('ITE_TOTSUB').AsFloat * fltPerFCPIte / 100, -2);
      End;

    End;


    FieldByName('ITE_TOTIPI').AsFloat := fltValIpi;
    FieldByName('ITE_BASIPI').AsFloat := fltBasipi;

    pCalculaImpostosReformaItem(dataSet, chkPedImp.Checked);


    If fEmptyStr(FieldByName('ITE_TIPOPE').AsString) Then
      FieldByName('ITE_TIPOPE').AsString := STR_COMPRAR;

    pCalculaUniImp(dataSet);

    TCalculaCamposPedido.pCalcFields(DataSet);

    If IIF(recOpcGir.blnMedAju, FieldByName('ITE_AJUSTA').AsFloat, FieldByName('ITE_MEDIA_').AsFloat) > 0 Then
    Begin

      FieldByName('ITE_DIASUG').AsInteger := Trunc(RoundTo((FieldByName('ITE_SALBAS').AsFloat +
                                                    (FieldByName('ITE_QTDITE').AsFloat * FieldByName('ITE_QTDEMB').AsFloat )+
                                                    FieldByName('ITE_QTDTRA').AsFloat) /
                                             (IIF(recOpcGir.blnMedAju, FieldByName('ITE_AJUSTA').AsFloat,
                                                                       FieldByName('ITE_MEDIA_').AsFloat) / 30), -4))
    End Else
    Begin
      FieldByName('ITE_DIASUG').Clear;
    End;

    FieldByName('ITE_LITROS').AsFloat  := FieldByName('ITE_QTDITE').AsFloat * fRetLitrosUnidade(FieldByName('ITE_CODUNI').AsString);

    If Not SameText(strLitGal, 'L') Then
      FieldByName('ITE_LITROS').AsFloat := FieldByName('ITE_LITROS').AsFloat / FLT_LITRO_GALAO;

    FieldByName('ITE_PESOIT').AsFloat  := FieldByName('ITE_QTDITE').AsFloat * FieldByName('ITE_QTDEMB').AsFloat *
                                                           FieldByName('ITE_PESORI').AsFloat;

    cdsItensPedido.BeforePost :=  TCalculaCamposPedido.pCalcFields;
  End;
End;


procedure TfrmPedidoDeCompra.cxvItensQTDITECustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  ACanvas.Brush.Color := clYellow;

  If AViewInfo.Selected Then
    ACanvas.Font.Color := clBlue;

end;

procedure TfrmPedidoDeCompra.cxvItensQTDITEPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;

  If (fCheckParent(ActiveControl, cxgItens) Or (cxgItens.FocusedView.FOCUSED)) And (cdsItensPedido.State = dsEdit) And cxvItensQTDITE.Options.Editing Then
  Begin
    cdsItensPedido.Post;

    pAtualizaQtdMultiloja;

    objCopiaSeg.pAtualizaItem;

    pAtualizaTotalTela;

    If wrdLastKey <> VK_DOWN Then
      cxvItens.NavigatorButtons.Next.Click;
  End;

end;

Procedure TfrmPedidoDeCompra.pAtualizaQtdMultiloja;
  Var
    intIndex,
    intQtdRec,
    intPosRec: Integer;
    strCodEmpCurr,
    strCodEmp: String;
    fltMltCom,
    fltQtdIte,
    fltDifTot,
    fltTotRes: Double;
    stlEmpAlt: TStringList;

    Procedure pAtualizaTotaisMultiLoja;
    Begin
      With cdsItensMultiLojas Do
      Begin
        FieldByName('ITE_TOTITE').AsFloat := RoundTo(FieldByName('ITE_QTDITE').AsFloat *
                                  RoundTo(cdsItensPedido.FieldByName('ITE_UNITAR').AsFloat *
                                    (   (1 - cdsItensPedido.FieldByName('ITE_DESUNI').AsFloat / 100)
                                      * (1 - cdsItensPedido.FieldByName('ITE_DESUN2').AsFloat / 100)
                                      * (1 - cdsItensPedido.FieldByName('ITE_DESUN3').AsFloat / 100)
                                      * (1 - cdsItensPedido.FieldByName('ITE_DESUN4').AsFloat / 100)
                                      * (1 - cdsItensPedido.FieldByName('ITE_DESUN5').AsFloat / 100)
                                      * (1 - cdsItensPedido.FieldByName('ITE_DESUN6').AsFloat / 100) ), -intDecUni), -2);

         FieldByName('ITE_BASIPI').AsFloat  := cdsItensMultiLojas.FieldByName('ITE_TOTITE').AsFloat;
         FieldByName('ITE_TOTIPI').AsFloat  := cdsItensMultiLojas.FieldByName('ITE_BASIPI').AsFloat * cdsItensPedido.FieldByName('ITE_PERIPI').AsFloat / 100;

         FieldByName('ITE_PERFCP').AsFloat  := cdsItensPedido.FieldByName('ITE_PERFCP').AsFloat;
         FieldByName('ITE_PERSUB').AsFloat  := cdsItensPedido.FieldByName('ITE_PERSUB').AsFloat;

         If cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat > 0 Then
         Begin
           FieldByName('ITE_TOTSUB').AsFloat := (cdsItensPedido.FieldByName('ITE_TOTSUB').AsFloat * FieldByName('ITE_QTDITE').AsFloat) /
                                                   cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat;

           FieldByName('ITE_TOTDAR').AsFloat := (cdsItensPedido.FieldByName('ITE_TOTDAR').AsFloat * FieldByName('ITE_QTDITE').AsFloat) /
                                                   cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat;


           FieldByName('ITE_SUBFCP').AsFloat := (cdsItensPedido.FieldByName('ITE_SUBFCP').AsFloat * FieldByName('ITE_QTDITE').AsFloat) /
                                                   cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat
         End Else
         Begin
           FieldByName('ITE_TOTSUB').AsFloat := 0;
           FieldByName('ITE_TOTDAR').AsFloat := 0;
           FieldByName('ITE_SUBFCP').AsFloat := 0;
         End;

         If cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat > 0 Then
           FieldByName('ITE_VALFRE').AsFloat := (cdsItensPedido.FieldByName('ITE_VALFRE').AsFloat * FieldByName('ITE_QTDITE').AsFloat) /
                                                   cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat
         Else
           FieldByName('ITE_VALFRE').AsFloat := 0;

         If cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat > 0 Then
           FieldByName('ITE_DESACE').AsFloat := (cdsItensPedido.FieldByName('ITE_DESACE').AsFloat * FieldByName('ITE_QTDITE').AsFloat) /
                                                   cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat
         Else
           FieldByName('ITE_DESACE').AsFloat := 0;

         pCopiaAliquotasReforma(cdsItensPedido, cdsItensMultiLojas, chkPedImp.Checked);

      End;
    End;

Begin
  If (recOpcGir.strPedMlj = 'S') Then
  With cdsItensMultiLojas Do
  Begin

    Try
      DisableControls;

      AfterPost := Nil;

      If (Not Filtered) Or
         (Pos(cdsItensPedido.FieldByName('ITE_CODITE').AsString, Filter) = 0) Then
      Begin
        Filter   := 'ITE_CODITE = ' + QuotedStr(cdsItensPedido.FieldByName('ITE_CODITE').AsString);
        Filtered := True;
        First;
      End;

      If RoundTo(cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat, -4) = RoundTo(fltQtdAnt, -4) Then
        Exit;

      If RoundTo(fltQtdAnt, -4) = 0 Then
      Begin
        If Not fEmptyStr(recOpcGir.strEmpAgr) Then
          strCodEmp := recOpcGir.strEmpAgr
        Else
          strCodEmp := VS_strCodEmp;

        If Not Locate('ITE_CODEMP;ITE_CODITE', VarArrayOf([strCodEmp, cdsItensPedido.FieldByName('ITE_CODITE').AsString]), []) Then
          First;

        Edit;
        FieldByName('ITE_QTDITE').AsFloat := cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat;

        pAtualizaTotaisMultiLoja;

        Post;

      End Else
      Begin
        fltTotRes := cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat;

        fltDifTot := cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat - fltQtdAnt;

        Filter := 'ITE_CODITE = ' + QuotedStr(cdsItensPedido.FieldByName('ITE_CODITE').AsString) + ' AND ITE_QTDITE > 0';

        intQtdRec := RecordCount;

        First;

        If intQtdRec = 1 Then
        Begin

          Edit;
          FieldByName('ITE_QTDITE').AsFloat := cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat;

          pAtualizaTotaisMultiLoja;

          Post;

        End Else
        Begin

          intPosRec := 0;

          stlEmpAlt := TStringList.Create;

          While Not Eof Do
          Begin

            If Not stlEmpAlt.Find(FieldByName('ITE_CODEMP').AsString, intIndex) Then
            Begin
              strCodEmpCurr := FieldByName('ITE_CODEMP').AsString;

              Inc(intPosRec);

              Edit;

              If intPosRec = intQtdRec Then
              Begin

                FieldByName('ITE_QTDITE').AsFloat := fltTotRes;

              End Else
              Begin
                fltQtdIte := FieldByName('ITE_QTDITE').AsFloat + (FieldByName('ITE_QTDITE').AsFloat / fltQtdAnt) * fltDifTot;

                fltQtdIte  := ceil(fltQtdIte);

                If AnsiIndexText(strCmpMlt,['S','T']) >= 0 Then
                Begin
                  fltMltCom := cdsItensPedido.FieldByName('ITE_MLTCOM').AsFloat;

                  If fltMltCom <= 0 Then
                    fltMltCom := 1;

                  If fltMltCom <> 1 Then
                    fltQtdIte := (Round(fltQtdIte / fltMltCom )) * fltMltCom;
                End;

                If fltQtdIte < fltTotRes Then
                  FieldByName('ITE_QTDITE').AsFloat := fltQtdIte
                Else
                  FieldByName('ITE_QTDITE').AsFloat := fltTotRes;

                fltTotRes := fltTotRes - FieldByName('ITE_QTDITE').AsFloat;
              End;

              stlEmpAlt.Add(FieldByName('ITE_CODEMP').AsString);

              pAtualizaTotaisMultiLoja;

              Post;

              If strCodEmpCurr = FieldByName('ITE_CODEMP').AsString Then
                Next;

            End

            Else Next;
          End;

          FreeAndNil(stlEmpAlt);
        End;

        Filter := 'ITE_CODITE = ' + QuotedStr(cdsItensPedido.FieldByName('ITE_CODITE').AsString);

      End;

    Finally

      AfterPost := cdsDigMultLoja.pAfterPostMultiloja;

      EnableControls;
    End;

  End;

  pRateiaFreteDesAce(fltValFreGer + fltDesAceGer > 0, fltValFreGer, fltDesAceGer,
                     objCopiaSeg.recPcmger.strBStFre, objCopiaSeg.recPcmger.strBStAce,
                     objCopiaSeg.recPcmger.strIpiFre);
End;

procedure TfrmPedidoDeCompra.cxvItensQTDITEPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  Var
    fltQtdReq,
    fltMltCom: Double;
    blnLiberado: Boolean;
begin
  inherited;

  If Not fValidaComprador(False) Then
  Begin
    Keybd_Event(VK_ESCAPE, 0, 0, 0);

    If (cdsItensPedido.State = dsEdit) Then
      cdsItensPedido.Cancel;

    Exit;
  End;

  If cdsItensPedido.FieldByName('ITE_UNITAR').AsFloat = 0 Then
  Begin
    pMensagemOk('Itens com valor unitário zerado não podem ser alteredos no grid!');

    Keybd_Event(VK_ESCAPE, 0, 0, 0);

    If (cdsItensPedido.State = dsEdit) Then
      cdsItensPedido.Cancel;

    Exit;
  End;

  fltMltCom := cdsItensPedido.FieldByName('ITE_MLTCOM').AsFloat;

  If fltMltCom <= 0 Then
   fltMltCom := 1;

  If recOpcGir.strPedMlj = 'S' Then
    fltQtdReq := cdsItensPedido.FieldByName('ITE_QATREQ').AsFloat
  Else
    fltQtdReq := cdsItensPedido.FieldByName('ITE_QTDREQ').AsFloat;

  If fEmptyStr(DisplayValue) Then
  Begin
    pMensagemOk('A quantidade deve ser preenchida!');
    Keybd_Event(VK_ESCAPE, 0, 0, 0);

    If (cdsItensPedido.State = dsEdit) Then
      cdsItensPedido.Cancel;

    Exit;
  End

  Else If (fStrToFloat(DisplayValue) < 0) Then
  Begin
    pMensagemOk('A quantidade deve ser maior ou igual a zero!');
    Keybd_Event(VK_ESCAPE, 0, 0, 0);

    If (cdsItensPedido.State = dsEdit) Then
      cdsItensPedido.Cancel;

    Exit;
  End

  Else If (strCmpMlt <> 'N') And (Frac(RoundTo(fStrToFloat(DisplayValue) / fltMltCom, -4))  <> 0) Then
  Begin

    blnLiberado := recValidadorCmpMlt.fLiberado(cdsItensPedido.FieldByName('ITE_CODITE').AsString, fStrToFloat(DisplayValue), fltMltCom);

    If Not blnLiberado Then
    Begin
      Keybd_Event(VK_ESCAPE, 0, 0, 0);

      If (cdsItensPedido.State = dsEdit) Then
        cdsItensPedido.Cancel;

      Exit;
    End;
  End

  Else If (Not blnALTPNT) And (cdsItensPedido.FieldByName('ITE_BAIPED').AsFloat > 0) Then
  Begin
    pMensagemOk('O sistema está configurado para não permitir alterar produtos já relacionados para a baixa relativa as notas: ' +
                 cdsItensPedido.FieldByName('ITE_BAINOT').AsString + '!');

    Keybd_Event(VK_ESCAPE, 0, 0, 0);

    If (cdsItensPedido.State = dsEdit) Then
      cdsItensPedido.Cancel;

    Exit;
  End

  Else If (cdsItensPedido.FieldByName('ITE_BAIPED').AsFloat >
           RoundTo(fStrToFloat(DisplayValue) * cdsItensPedido.FieldByName('ITE_QTDEMB').AsFloat, -4)) Then
  Begin
    pMensagemOk('A quantidade não pode ser menor que a quantidade já relacionada para a baixa (' +
                 FormatFloat('#,##0.00', cdsItensPedido.FieldByName('ITE_BAIPED').AsFloat) + ') relativa as notas: ' +
                 cdsItensPedido.FieldByName('ITE_BAINOT').AsString + '!');

    Keybd_Event(VK_ESCAPE, 0, 0, 0);

    If (cdsItensPedido.State = dsEdit) Then
      cdsItensPedido.Cancel;

    Exit;
  End

  Else If (Not fEmptyStr(cdsItensPedido.FieldByName('ITE_INCIRQ').AsString)) And
          (fltQtdReq > 0) And
          (RoundTo(fltQtdReq, -4) > RoundTo(fStrToFloat(DisplayValue) * cdsItensPedido.FieldByName('ITE_QTDEMB').AsFloat, -4)) Then
  Begin
     pMensagemOk('A quantidade do item ' + cdsItensPedido.FieldByName('ITE_CODITE').AsString + ' não pode ser menor que ' +
                'a quantidade que atendederá as requisições (' + FormatFloat('#,##0.00', fltQtdReq) +
                ') as quais ela está vinculada!');

    Keybd_Event(VK_ESCAPE, 0, 0, 0);

    If (cdsItensPedido.State = dsEdit) Then
      cdsItensPedido.Cancel;

    Exit;
  End;

  cdsItensPedido.BeforePost := pCalculaTotalItemQtdGrid;
  cdsItensPedido.AfterPost   := pAfterPost;

  pLimpaDadosItem;
end;

procedure TfrmPedidoDeCompra.cxvItensTEMREQGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If fStrToFloat(VarToStr(cxvItens.DataController.Values[ARecord.RecordIndex, cxvItensTEMREQ.Index])) > 0 Then
    AText := 'SIM'
  Else
    AText := 'NÃO';
  Sender.Properties.Alignment.Horz := taCenter;
end;

procedure TfrmPedidoDeCompra.cxvItensUNITARCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If cxvItensUNITAR.Options.Editing Then
  Begin
    ACanvas.Brush.Color := clYellow;

    If AViewInfo.Selected Then
      ACanvas.Font.Color := clBlue;
  End;
end;

procedure TfrmPedidoDeCompra.cxvItensUNITARPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  If fCheckParent(ActiveControl, cxgItens) And (cdsItensPedido.State = dsEdit) And cxvItensUNITAR.Options.Editing Then
  Begin
    cdsItensPedido.Post;

    pAtualizaQtdMultiloja;

    objCopiaSeg.pAtualizaItem;

    pAtualizaTotalTela;

    If wrdLastKey <> VK_DOWN Then
      cxvItens.NavigatorButtons.Next.Click;
  End;
end;

procedure TfrmPedidoDeCompra.cxvItensUNITARPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  cdsItensPedido.BeforePost := pCalculaTotalItemQtdGrid;
  cdsItensPedido.AfterPost   := pAfterPost;
  pLimpaDadosItem;
end;

procedure TfrmPedidoDeCompra.edtCodSolicitacaoVinculadaKeyPress(Sender: TObject; var Key: Char);
Var
  arrPesq: TConsultasArray;
  strStatus: string;
begin
  inherited;
  If Key <> '/' Then
    Key := #0;

  strStatus := QuotedStr(TManutencaoEquipamentoInternoStatusFuncoes.fTSatusParaString(tsAprovada)) + ',' + QuotedStr(TManutencaoEquipamentoInternoStatusFuncoes.fTSatusParaString(tsPedCompra));

  If fPesqSoliManutEquipInterno(Self, edtCodSolicitacaoVinculada, Nil, Key, arrPesq, true, true, strStatus) Then
  Begin
    If fValidaCampos(edtCodSolicitacaoVinculada) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmPedidoDeCompra.fDataEmpty(const strData: String): Boolean;
begin
  Result := fEmptyStr(fTiraCaracEspeciais(strData));
end;

function TfrmPedidoDeCompra.fValidaDataEntrega(
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  Try
    If (Not mskDtaPed.ReadOnly) And fDataEmpty(mskDtaPed.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A data de entrega deve ser preenchida!', ['&O k']);
      Result := False;
    End;

    If Result Then
      objCopiaSeg.dtaDtaEntP := StrToDateDef(mskDtaPed.Text, VS_Date);

  Finally
    If Not Result Then
      pMostraDadosGerais;
  End;

end;

function TfrmPedidoDeCompra.fValidaQtdCtn(
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  Try
    If (Not edtQtdCtn.Visible) Then
      Exit;

    If (fEmptyStr(edtQtdCtn.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade de containers deve ser preenchida!', ['&O k']);
      Result := False;
    End
    Else If (StrToInt(edtQtdCtn.Text) < 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade de containers deve ser maior ou igual à Zero!', ['&O k']);
      Result := False;
    End;

  Finally
    If Not Result Then
      pMostraDadosGerais;
  End;

end;

function TfrmPedidoDeCompra.fValidaQtdPCDDETcomPCMDET(out strMsgErr: String): Boolean;
Var
  qryAux: TUniQuery;
begin
  Result := True;
  strMsgErr := '';

  If (stlAutIncrem.Count = 0) Then
    Exit;

  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Add(' SELECT COUNT(1) AS QTD                         ');
    qryAux.SQL.Add('   FROM PCMGER                                  ');

    {strFinPed = N -> Mantém o pedido de compra como multiloja, sendo assim fica igual ao orçamento pcmdet e pcddet         }
    {strFinPed = S -> Desmembra o multiloja em pedido por loja, sendo assim cada loja terá o seu pedido e não haverá pcddet }
    If SameText(strFinPed, 'S') Then
    Begin
      qryAux.SQL.Add('  INNER JOIN PCMDET ON PCD_NUMPED = PCG_NUMPED  ');
      qryAux.SQL.Add('                   AND PCD_CODEMP = PCG_CODEMP  ');
      qryAux.SQL.Add('                   AND PCD_ESPDOC = PCG_ESPDOC  ');
      qryAux.SQL.Add('                   AND PCD_NUMCTN = PCG_NUMCTN  ');
    End
    Else
    Begin
      qryAux.SQL.Add(' INNER JOIN PCDDET ON PCD_NUMPED = PCG_NUMPED   ');
      qryAux.SQL.Add('                  AND PCD_CODEMP = PCG_CODEMP   ');
      qryAux.SQL.Add('                  AND PCD_ESPDOC = PCG_ESPDOC   ');
    End;

    qryAux.SQL.Add(' WHERE PCMGER.AUTOINCREM IN (' + stlAutIncrem.CommaText + ') ');
    qryAux.Open;

    If qryAux.FieldByName('QTD').AsInteger <> intQtdItensMutiLj Then
    Begin
      Result := False;
      strMsgErr := 'QTD = ' + intToStr(qryAux.FieldByName('QTD').AsInteger) + ' | intQtdItensMutiLj = ' + intToStr(intQtdItensMutiLj) + ' | ';
    End;

  Finally
    FreeAndNil(qryAux);
  End;

end;

function TfrmPedidoDeCompra.fValidaCondPagamento(
  blnBuscaPorChave: Boolean): Boolean;
  Var
   strConPag: String;
begin
  Result := True;

  Try

    If fDataEmpty(mskCndPag.Text) Then
    Begin
      If blnCarregandoRequisicoes Then
      Begin
        Result := True;
        Exit;
      End;

      fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k']);
      Result := False;
    End
    Else If fEmptyStr(Copy(mskCndPag.Text, 1, 2)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Condição de pagamento inválida!', ['&O k']);
      Result := False;
    End
    Else If StrToInt(Copy(mskCndPag.Text, 1, 2)) > 24 Then
    Begin
      fMensagem('', 'Não é permitido mais que 24 parcelas!', ['&O k']);
      Result := False;
    End
    Else If Not fValidaCndPag(mskCndPag.Text, strConPag, StrToDateDef(mskDtaPed.Text, 0)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&O k']);
      Result := False;
    End Else
    Begin
      mskCndPag.Text := strConPag;

      If fEmptyStr(strConPag) Then
        Result := False;

    End;

    If Not chkPgAVis.Checked And (fStatusCndPag(fTiraCaracEspeciais(mskCndPag.Text)) = A_VISTA) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é permitida!', ['&O k']);
      Result := False;
    End;

    If Result Then
      objCopiaSeg.strConPagP := mskCndPag.Text;

  Finally
    If Not Result Then
      pMostraDadosGerais;
  End;

end;

function TfrmPedidoDeCompra.fValidaConsistenciaPedido(strNumPed, strCodEmp,
  strEspDoc: String): Boolean;
var
  qryAux: TUniQuery;
begin
  Try
    Try
      qryAux := fCriaQuery;
      qryAux.SQL.Add('    SELECT                            ');
      qryAux.SQL.Add('      COUNT(1) AS COUNT               ');
      qryAux.SQL.Add('    FROM                              ');
      qryAux.SQL.Add('        PCMDET                        ');
      qryAux.SQL.Add('    WHERE PCD_NUMPED = "'+strNumPed+'"');
      qryAux.SQL.Add('      AND PCD_CODEMP = "'+strCodEmp+'"');
      qryAux.SQL.Add('      AND PCD_ESPDOC = "'+strEspDoc+'"');
      qryAux.Open;

      Result := qryAux.FieldByName('COUNT').AsInteger > 0;
    Finally
      FreeAndNil(qryAux);
    End;

  Except On
    E:Exception Do
    Begin
      Result := False;
    End;
  End;

end;

function TfrmPedidoDeCompra.fValidaDescontoAdicional(
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  Try
    If fEmptyStr(edtDesAdi.Text) Then
    Begin
      edtDesAdi.Text := '0,00';
    End
    Else If (fStrToFloat(edtDesAdi.Text) < 0.0) Or (fStrToFloat(edtDesAdi.Text) > 100.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Desconto Adicional deve ser entre 0 e 100!', ['&O k']);
      Result := False;
    End;

  Finally
    If Not Result Then
      pMostraDadosGerais;
  End;

end;

Function TfrmPedidoDeCompra.fStrEmpSaldos: String;
Begin
  With recOpcGir Do
  If fEmptyStr(strEmpGir) Then
  Begin

    If (strPedMlj = 'N') Then
       Result := QuotedStr(fRetEmpresaDestino)
    Else
      Result := '';

  End Else
  Begin

    If (strPedMlj = 'S') And blnEmpVis And (Not fEmptyStr(recOpcGir.strEmpCal)) Then
      Result := strEmpCal
    Else
      Result := strEmpGir;
  End;
End;

procedure TfrmPedidoDeCompra.pInsereItemClient(strCodIte: String);
  Var
    strEmpSaldos,
    strAutInc: String;
    qryCadGer: TUniQuery;
Begin

  qryCadGer := fCriaQuery;

  With qryCadGer, SQL Do
  Begin
    Add('SELECT');
    Add('  C.ITE_CODGRU,');
    Add('  C.ITE_CODITE,');
    Add('  C.ITE_APLICA,');
    Add('  C.ITE_DIAFOR, ');
    Add('  C.ITE_REFERE,');
    Add('  C.ITE_CODUNI,');
    Add('  C.ITE_CODMAR,');
    Add('  C.ITE_CODFOR,');
    Add('  C.ITE_CODBAR,');
    Add('  C.ITE_CODSIM,');
    Add('  C.ITE_INCPIS,');
    Add('  C.ITE_PESOIT,');

    Add('  ITE_NIVCRI,');

    If recOpcGir.recNivEst.nivEstoque = nivGiroFornecedor then
      Add('  C.ITE_NVLFOR AS ITE_NVLGIR,')
    Else If fCfgSis('TIPGIR') = 'S' Then
      Add('  I.ITE_NIVGIR AS ITE_NVLGIR,')
    Else
      Add('  C.ITE_NVLGIR,');

    Add('  U.UNI_ITEFRA,');

    Add(' F.ITE_CODTAB, ');

    If blnPermitirCompradorEscolherCodigoFabrica Then
    Begin
      If (fRetornaCodigoFabricaProduto = 'P') Then
        Add(fRetornaSQLCodigoFabricaProduto('C'))
      Else
        Add(fRetornaSQLCodigoFabricaProduto('F'));
    End
    Else
    Begin
      If fCfgSis('CODFIT', varBoolean) Then
      Begin
        Add('  C.ITE_CODFAB AS ITE_CODFAB, ');
      End
      Else
      Begin
        If fCfgSis('TABPRF', varBoolean) Then
          Add('    IF(IFNULL(F.ITE_CODFAB,"") = "", C.ITE_CODFAB, F.ITE_CODFAB) AS ITE_CODFAB, ')
        Else
          Add('    IF(IFNULL(F.ITE_CODITF,"") = "", C.ITE_CODFAB, F.ITE_CODITF) AS ITE_CODFAB, ');
      End;
    End;

    Add(' IF(D.ITE_CODITE IS NULL, I.ITE_DESF01, D.ITE_DESF01) AS ITE_DESF01, ');
    Add(' IF(D.ITE_CODITE IS NULL, I.ITE_DESF02, D.ITE_DESF02) AS ITE_DESF02, ');
    Add(' IF(D.ITE_CODITE IS NULL, I.ITE_DESF03, D.ITE_DESF03) AS ITE_DESF03, ');
    Add(' IF(D.ITE_CODITE IS NULL, I.ITE_DESF04, D.ITE_DESF04) AS ITE_DESF04, ');
    Add(' IF(D.ITE_CODITE IS NULL, I.ITE_DESF05, D.ITE_DESF05) AS ITE_DESF05, ');
    Add(' IF(D.ITE_CODITE IS NULL, I.ITE_DESF06, D.ITE_DESF06) AS ITE_DESF06, ');

    Add(' IF(F.ITE_CODITE IS NULL, IF(IFNULL(C.ITE_MLTCOM, 0) <> 0, C.ITE_MLTCOM, 1), ');
    Add('                          IF(IFNULL(F.ITE_MLTCOM, 0) <> 0, F.ITE_MLTCOM, IFNULL(C.ITE_MLTCOM, 1))) AS ITE_MLTCOM, ');

    If (rdgDesPdi.Visible) And (rdgDesPdi.ItemIndex = 1) Then
      Add(' IF(IFNULL(C.ITE_DESFAB, "") = "", C.ITE_DESITE, C.ITE_DESFAB) AS ITE_DESITE, ')
    Else
      Add(' IF((F.ITE_CODITE IS NULL) OR IFNULL(F.ITE_DESFAB, "") = "", C.ITE_DESITE, F.ITE_DESFAB) AS ITE_DESITE, ');

    If blnUtiInd Then
    Begin
      Add(' IF(D.ITE_CODITE IS NULL, I.ITE_PRECOM, D.ITE_PRECOM / IF(IFNULL(F.ITE_CNVCUS, 0) <> 0, F.ITE_CNVCUS, 1)) * ');
      Add(' IF(IF(D.ITE_CODITE IS NULL, I.ITE_PREDOL, D.ITE_PREDOL) = "S", (SELECT MOE_DOLVEN FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1), 1) AS ITE_PRECOM, ');
    End Else
    Begin
      Add(' IF(D.ITE_CODITE IS NULL, I.ITE_PRECOM, D.ITE_PRECOM / IF(IFNULL(F.ITE_CNVCUS, 0) <> 0, F.ITE_CNVCUS, 1)) AS ITE_PRECOM, ');
    End;

    Add(' IF(D.ITE_CODITE IS NULL, I.ITE_PRECUS, D.ITE_PRECUS / IF(IFNULL(F.ITE_CNVCUS, 0) <> 0, F.ITE_CNVCUS, 1)) AS ITE_PRECUS, ');
    Add(' IF(D.ITE_CODITE IS NULL, I.ITE_IPIENT, D.ITE_IPIENT) AS ITE_IPIENT, ');
    Add(' IF(D.ITE_CODITE IS NULL, I.ITE_SUBSTI, D.ITE_SUBSTI) AS ITE_SUBSTI, ');
    Add(' IF(D.ITE_CODITE IS NULL, I.ITE_ACRFIN, D.ITE_ACRFIN) AS ITE_ACRFIN, ');

    Add('  I.ITE_PREULT,');
    Add('  I.ITE_ESTMIN,');
    Add('  I.ITE_ESTMAX,');
    Add('  I.ITE_PMED_V,');

    Add('  I.ITE_MINDIG,');
    Add('  I.ITE_MAXDIG,');

    Add('  I.ITE_PONPED,');

    Add('  I.ITE_ESMIDG,');

    Add('  (SELECT SUM(ED.ITE_SALDOS + IF(IFNULL(C.ITE_CNV_ML, 0) > 0, IFNULL(ED.ITE_SAL_ML, 0) / C.ITE_CNV_ML, 0))');
    Add('     FROM ITEGER ED');
    Add('    WHERE ED.ITE_CODITE = I.ITE_CODITE ');
    Add('      AND ED.ITE_CODEMP IN( :EMPDES ))AS ITE_SALDOS, ');

    Add('  I.ITE_PREVE1,');
    Add('  I.ITE_PREVE2,');
    Add('  I.ITE_PREVE3,');
    Add('  I.ITE_PREVE4,');
    Add('  I.ITE_PREVE5,');
    Add('  I.ITE_PREVE6,');
    Add('  I.ITE_PREVE7,');
    Add('  I.ITE_MARBR1,');
    Add('  I.ITE_MARBR2,');
    Add('  I.ITE_MARBR3,');
    Add('  I.ITE_MARBR4,');
    Add('  I.ITE_MARBR5,');
    Add('  I.ITE_MARBR6,');
    Add('  I.ITE_MARBR7,');
    Add('  I.ITE_LOCFIS,');
    Add('  C.ITE_DESSIM,');
    Add('  G.GRU_DESGRU AS ITE_DESGRU,     ');
    Add('  I.ITE_PONEXP ');
    Add('FROM');
    Add('ITEGER I ');
    Add('INNER JOIN CADITE C ON');
    Add('  I.ITE_CODITE = C.ITE_CODITE     ');

    Add('LEFT JOIN CADUNI U ON');
    Add('  C.ITE_CODUNI = U.UNI_CODUNI     ');


    If fCfgSis('TABPRF', varBoolean) Then
    Begin
      Add('  LEFT JOIN (SELECT * FROM ITEFOR F WHERE  F.ITE_CODFAB IS NOT NULL ');
      Add('                  AND (SELECT COUNT(*) FROM TABPRE                  ');
      Add('                        WHERE F.ITE_CODTAB = TAB_CODTAB AND' + fSqlWhereTabPre(strPrF_AE, recOpcGir.strCodTab) + ') > 0');
      Add('    GROUP BY F.ITE_CODFAB) F ON F.ITE_CODITE = I.ITE_CODITE         ');
      Add('                            AND F.ITE_CODFOR = :CODFOR              ');
    End Else
    Begin
      Add('  LEFT JOIN ITEFOR F ON F.ITE_CODITE = I.ITE_CODITE ');
      Add('                    AND F.ITE_CODFOR = :CODFOR ');
      Add('                    AND F.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF     ');
      Add('                       WHERE FF.ITE_CODITE = I.ITE_CODITE AND ');
      Add('                             FF.ITE_CODFOR = :CODFOR)   ');
    End;

    Add('  LEFT JOIN TABDET D ON D.ITE_CODTAB = F.ITE_CODTAB ');
    Add('                    AND D.ITE_CODITE = F.ITE_CODITE ');
    Add('                    AND D.ITE_CODEMP = I.ITE_CODEMP ');

    Add('  LEFT JOIN CADGRU G ON G.GRU_CODGRU = ITE_CODGRU     ');

    Add('WHERE');
    Add('  I.ITE_CODITE = :CODITE AND ');
    Add('  I.ITE_CODEMP = :CODEMP');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CODFOR').AsString := edtCodFor.Text;

    strEmpSaldos := fStrEmpSaldos;
    ParamByName('EMPDES').AsString := strEmpSaldos;

    Open;
  End;

  strAutInc := fRetProximoAutIncTmp;

  With cdsItensGiro, recOpcGir Do
  Begin
    Insert;

    FieldByName('ITE_INCIRQ').AsString := '';
    FieldByName('ITE_QTDREQ').AsFloat  := 0;
    FieldByName('ITE_QATREQ').AsFloat  := 0;
    FieldByName('ITE_QTDTRA').AsFloat  := 0;
    FieldByName('ITE_TRAINC').AsFloat  := 0;

    FieldByName('ITE_CODEMP').AsString := VS_strCodEmp;
    FieldByName('ITE_ITEFRA').AsString := qryCadGer.FieldByName('UNI_ITEFRA').AsString;
    FieldByName('ITE_CODGRU').AsString := qryCadGer.FieldByName('ITE_CODGRU').AsString;
    FieldByName('ITE_INCPIS').AsString := qryCadGer.FieldByName('ITE_INCPIS').AsString;
    FieldByName('ITE_ESMIDG').AsString := qryCadGer.FieldByName('ITE_ESMIDG').AsString;
    FieldByName('ITE_LOCFIS').AsString := qryCadGer.FieldByName('ITE_LOCFIS').AsString;
    FieldByName('ITE_CODITE').AsString := qryCadGer.FieldByName('ITE_CODITE').AsString;
    FieldByName('ITE_CODTAB').AsString := qryCadGer.FieldByName('ITE_CODTAB').AsString;
    FieldByName('ITE_DESITE').AsString := qryCadGer.FieldByName('ITE_DESITE').AsString;
    FieldByName('ITE_APLICA').AsString := qryCadGer.FieldByName('ITE_APLICA').AsString;
    FieldByName('ITE_DIAFOR').AsInteger:= qryCadGer.FieldByName('ITE_DIAFOR').AsInteger;
    FieldByName('ITE_REFERE').AsString := qryCadGer.FieldByName('ITE_REFERE').AsString;
    FieldByName('ITE_NVLCRI').AsString := qryCadGer.FieldByName('ITE_NIVCRI').AsString;
    FieldByName('ITE_NVLGIR').AsString := qryCadGer.FieldByName('ITE_NVLGIR').AsString;
    FieldByName('ITE_CODUNI').AsString := qryCadGer.FieldByName('ITE_CODUNI').AsString;
    FieldByName('ITE_SIGUNI').AsString := fRetSiglaUnidade(qryCadGer.FieldByName('ITE_CODUNI').AsString);
    FieldByName('ITE_CODMAR').AsString := qryCadGer.FieldByName('ITE_CODMAR').AsString;
    FieldByName('ITE_DESMAR').AsString := fRetNomMarca(qryCadGer.FieldByName('ITE_CODMAR').AsString);
    FieldByName('ITE_CODFOR').AsString := qryCadGer.FieldByName('ITE_CODFOR').AsString;
    FieldByName('ITE_QTDITE').AsFloat  := 0;
    FieldByName('ITE_TOTITE').AsFloat  := 0;

    FieldByName('ITE_BASIPI').AsFloat  := 0;
    FieldByName('ITE_PERIPI').AsFloat  := 0;
    FieldByName('ITE_TOTIPI').AsFloat  := 0;

    FieldByName('ITE_ALQIMP').AsFloat  := 0;
    FieldByName('ITE_VALIMP').AsFloat  := 0;

    FieldByName('ITE_BASSUB').AsFloat  := 0;
    FieldByName('ITE_PERSUB').AsFloat  := 0;
    FieldByName('ITE_TOTSUB').AsFloat  := 0;
    FieldByName('ITE_TOTDAR').AsFloat  := 0;
    FieldByName('ITE_PERFCP').AsFloat  := 0;
    FieldByName('ITE_SUBFCP').AsFloat  := 0;

    FieldByName('ITE_BASICM').AsFloat  := 0;
    FieldByName('ITE_PERBAS').AsFloat  := 100;
    FieldByName('ITE_ALQICM').AsFloat  := 0;
    FieldByName('ITE_VALICM').AsFloat  := 0;
    FieldByName('ITE_DESPIS').AsFloat  := 0;

    FieldByName('ITE_MLTCOM').AsFloat  := qryCadGer.FieldByName('ITE_MLTCOM').AsFloat;

    FieldByName('ITE_DESF01').AsFloat  := qryCadGer.FieldByName('ITE_DESF01').AsFloat;
    FieldByName('ITE_DESF02').AsFloat  := qryCadGer.FieldByName('ITE_DESF02').AsFloat;
    FieldByName('ITE_DESF03').AsFloat  := qryCadGer.FieldByName('ITE_DESF03').AsFloat;
    FieldByName('ITE_DESF04').AsFloat  := qryCadGer.FieldByName('ITE_DESF04').AsFloat;
    FieldByName('ITE_DESF05').AsFloat  := qryCadGer.FieldByName('ITE_DESF05').AsFloat;
    FieldByName('ITE_DESF06').AsFloat  := qryCadGer.FieldByName('ITE_DESF06').AsFloat;
    FieldByName('ITE_PRECUS').AsFloat  := qryCadGer.FieldByName('ITE_PRECUS').AsFloat;
    FieldByName('ITE_PRECOM').AsFloat  := qryCadGer.FieldByName('ITE_PRECOM').AsFloat;
    FieldByName('ITE_PERIPI').AsFloat  := qryCadGer.FieldByName('ITE_IPIENT').AsFloat;
    FieldByName('ITE_PERSUB').AsFloat  := qryCadGer.FieldByName('ITE_SUBSTI').AsFloat;
    FieldByName('ITE_ACRFIN').AsFloat  := qryCadGer.FieldByName('ITE_ACRFIN').AsFloat;

    FieldByName('ITE_PMED_V').AsFloat  := qryCadGer.FieldByName('ITE_PMED_V').AsFloat;

    FieldByName('ITE_PONPED').AsFloat  := qryCadGer.FieldByName('ITE_PONPED').AsFloat;
    FieldByName('ITE_PREVE1').AsFloat  := qryCadGer.FieldByName('ITE_PREVE1').AsFloat;
    FieldByName('ITE_PREVE2').AsFloat  := qryCadGer.FieldByName('ITE_PREVE2').AsFloat;
    FieldByName('ITE_PREVE3').AsFloat  := qryCadGer.FieldByName('ITE_PREVE3').AsFloat;
    FieldByName('ITE_PREVE4').AsFloat  := qryCadGer.FieldByName('ITE_PREVE4').AsFloat;
    FieldByName('ITE_PREVE5').AsFloat  := qryCadGer.FieldByName('ITE_PREVE5').AsFloat;
    FieldByName('ITE_PREVE6').AsFloat  := qryCadGer.FieldByName('ITE_PREVE6').AsFloat;
    FieldByName('ITE_PREVE7').AsFloat  := qryCadGer.FieldByName('ITE_PREVE7').AsFloat;
    FieldByName('ITE_MARBR1').AsFloat  := qryCadGer.FieldByName('ITE_MARBR1').AsFloat;
    FieldByName('ITE_MARBR2').AsFloat  := qryCadGer.FieldByName('ITE_MARBR2').AsFloat;
    FieldByName('ITE_MARBR3').AsFloat  := qryCadGer.FieldByName('ITE_MARBR3').AsFloat;
    FieldByName('ITE_MARBR4').AsFloat  := qryCadGer.FieldByName('ITE_MARBR4').AsFloat;
    FieldByName('ITE_MARBR5').AsFloat  := qryCadGer.FieldByName('ITE_MARBR5').AsFloat;
    FieldByName('ITE_MARBR6').AsFloat  := qryCadGer.FieldByName('ITE_MARBR6').AsFloat;
    FieldByName('ITE_MARBR7').AsFloat  := qryCadGer.FieldByName('ITE_MARBR7').AsFloat;
    FieldByName('ITE_UNITAR').AsFloat  := 0;
    FieldByName('ITE_DESUNI').AsFloat  := 0;
    FieldByName('ITE_DESUN2').AsFloat  := 0;
    FieldByName('ITE_DESUN3').AsFloat  := 0;
    FieldByName('ITE_DESUN4').AsFloat  := 0;
    FieldByName('ITE_DESUN5').AsFloat  := 0;
    FieldByName('ITE_DESUN6').AsFloat  := 0;
    FieldByName('ITE_UNILIQ').AsFloat  := 0;
    FieldByName('ITE_DIFPRE').AsFloat  := 0;
    FieldByName('ITE_UNIORI').AsFloat  := 0;
    FieldByName('ITE_SUGEST').AsFloat  := 0;


    If fEmptyStr(strEmpGir)  Then
    Begin
      FieldByName('ITE_SALDOS').AsFloat  := qryCadGer.FieldByName('ITE_SALDOS').AsFloat;
    End Else
    Begin
      FieldByName('ITE_SALDOS').AsFloat  := fRetornaSaldoItem(FieldByName('ITE_CODITE').AsString,
                                                              IIF(recOpcGir.blnAgrSim, qryCadGer.FieldByName('ITE_CODSIM').AsString, ''),
                                                              strEmpGir);
    End;

    pGetSaldosReservados(cdsSaldos, qryCadGer.FieldByName('ITE_CODITE').AsString, strEmpSaldos,
                         (blnUsarGiro Or blnAltPedGir Or (Assigned(recOpcGir.objSalInt) And recOpcGir.objSalInt.blnEncontrouGiro)),
                         recOpcGir);

    FieldByName('ITE_MINDIG').AsFloat  := cdsSaldos.FieldByName('ITE_MINDIG').AsFloat;
    FieldByName('ITE_MAXDIG').AsFloat  := cdsSaldos.FieldByName('ITE_MAXDIG').AsFloat;
    FieldByName('ITE_ESTMIN').AsFloat  := cdsSaldos.FieldByName('ITE_ESTMIN').AsFloat;
    FieldByName('ITE_ESTMAX').AsFloat  := cdsSaldos.FieldByName('ITE_ESTMAX').AsFloat;
    FieldByName('ITE_QTEF_A').AsFloat  := cdsSaldos.FieldByName('ITE_QTEF_A').AsFloat;
    FieldByName('ITE_QTEF_F').AsFloat  := cdsSaldos.FieldByName('ITE_QTEF_F').AsFloat;
    FieldByName('ITE_QTEF_P').AsFloat  := cdsSaldos.FieldByName('ITE_QTEF_P').AsFloat;
    FieldByName('ITE_QTPD_P').AsFloat  := cdsSaldos.FieldByName('ITE_QTPD_P').AsFloat;
    FieldByName('ITE_SALRES').AsFloat  := cdsSaldos.FieldByName('ITE_SALRES').AsFloat;
    FieldByName('ITE_SALEND').AsFloat  := cdsSaldos.FieldByName('ITE_SALEND').AsFloat;
    FieldByName('ITE_SALTRA').AsFloat  := cdsSaldos.FieldByName('ITE_SALTRA').AsFloat;
    FieldByName('ITE_SALGAR').AsFloat  := cdsSaldos.FieldByName('ITE_SALGAR').AsFloat;
    FieldByName('ITE_SALDIS').AsFloat  := cdsSaldos.FieldByName('ITE_SALDIS').AsFloat;
    FieldByName('ITE_SALEXT').AsFloat  := cdsSaldos.FieldByName('ITE_SALEXT').AsFloat;
    FieldByName('ITE_SALBAS').AsFloat  := cdsSaldos.FieldByName('ITE_SALBAS').AsFloat;
    FieldByName('ITE_SALFIS').AsFloat  := cdsSaldos.FieldByName('ITE_SALFIS').AsFloat;
    FieldByName('ITE_SALCOT').AsFloat  := cdsSaldos.FieldByName('ITE_SALCOT').AsFloat;
    FieldByName('ITE_VENPER').AsFloat  := cdsSaldos.FieldByName('ITE_VENPER').AsFloat;
    FieldByName('ITE_QTDPEN').AsFloat  := cdsSaldos.FieldByName('ITE_QTDPEN').AsFloat;
    FieldByName('ITE_SALREQ').AsFloat  := cdsSaldos.FieldByName('ITE_SALREQ').AsFloat;

    FieldByName('ITE_VENMES').AsFloat  := fRetVendasMesItem(qryCadGer.FieldByName('ITE_CODITE').AsString,
                                                            IIF(recOpcGir.blnAgrSim, qryCadGer.FieldByName('ITE_CODSIM').AsString, ''),
                                                            strEmpSaldos,
                                                            MOnthOf(VS_Date),
                                                            YearOf(VS_Date),
                                                            False);

    FieldByName('ITE_Q_VPME').AsFloat  := fRetVendasMesItem(qryCadGer.FieldByName('ITE_CODITE').AsString,
                                                            IIF(recOpcGir.blnAgrSim, qryCadGer.FieldByName('ITE_CODSIM').AsString, ''),
                                                            strEmpSaldos,
                                                            MOnthOf(VS_Date),
                                                            YearOf(VS_Date),
                                                            True);
    If (blnUsarGiro Or blnAltPedGir) Or (strPedMlj = 'S') Then
      pRetCamposGiro(cdsItensGiro,
                     qryCadGer.FieldByName('ITE_CODITE').AsString,
                     strEmpGir,
                     strMeses,
                     blnConsMesAtu,
                     intMesGir,
                     intMesMos,
                     recNivEst,
                     IIF(recOpcGir.blnAgrSim, qryCadGer.FieldByName('ITE_CODSIM').AsString, ''));

    FieldByName('ITE_CODFAB').AsString := qryCadGer.FieldByName('ITE_CODFAB').AsString;
    FieldByName('ITE_CODBAR').AsString := qryCadGer.FieldByName('ITE_CODBAR').AsString;
    FieldByName('ITE_CODSIM').AsString := qryCadGer.FieldByName('ITE_CODSIM').AsString;
    FieldByName('ITE_PESORI').AsFloat  := qryCadGer.FieldByName('ITE_PESOIT').AsFloat;
    FieldByName('ITE_PESOIT').AsFloat  := qryCadGer.FieldByName('ITE_PESOIT').AsFloat * FieldByName('ITE_QTDITE').AsFloat;
    FieldByName('AUTOINCREM').AsString := strAutInc;
    FieldByName('ITE_DESGRU').AsString := qryCadGer.FieldByName('ITE_DESGRU').AsString;
    FieldByName('ITE_DESSIM').AsString := qryCadGer.FieldByName('ITE_DESSIM').AsString;

    FieldByName('ITE_PONEXP').AsFloat := qryCadGer.FieldByName('ITE_PONEXP').AsFloat;

    Post;
  End;

  FreeAndNil(qryCadGer);
End;

{*****************************************}
{* CARREGA DADOS DOS ITENS OU GIRO PARA  *}
{* MOSTRAR NOS EDITS                     *}
{**************************************MV*}

procedure TfrmPedidoDeCompra.pCarregaIteger(strCodIte: String);
  Var
    strSQL: String;
Begin
  With qryConGer Do
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_CODITE, ';
    strSQL := strSQL + '  ITE_CPRCEN, ';

    strSQL := strSQL + '  IFNULL(ITE_EMPCEN, "' + fCfgSis('EMPMAT') + '") AS ITE_EMPCEN ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '  ITE_CODEMP = :CODEMP ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
  End;
End;

procedure TfrmPedidoDeCompra.pLePrecoCompraItem(qryDadCom: TUniQuery; strCodIte, strCodFor: String);
  Var
    strSQL: String;
Begin
  With qryDadCom Do
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';

    strSQL := strSQL + '  CAST(NULL AS CHAR(6)) AS ITE_CODTAB, ';
    strSQL := strSQL + '  C.ITE_CODITE, ';

    If strCnvEmb <> 'N' Then
      strSQL := strSQL + ' IFNULL((SELECT BAR_EMBALA FROM ITEBAR WHERE BAR_CODITE = :CODITE AND BAR_CODFOR = :CODFOR ORDER BY BAR_COMPRA DESC LIMIT 1), IFNULL(C.ITE_EMBALA, 1)) AS ITE_EMBALA, '
    Else
      strSQL := strSQL + '  1.0000 AS ITE_EMBALA, ';

    strSQL := strSQL + ' IF(F.ITE_CODITE IS NULL, IF(IFNULL(C.ITE_MLTCOM, 0) <> 0, C.ITE_MLTCOM, 1), ';
    strSQL := strSQL + '                          IF(IFNULL(F.ITE_MLTCOM, 0) <> 0, F.ITE_MLTCOM, IFNULL(C.ITE_MLTCOM, 1))) AS ITE_MLTCOM, ';

    strSQL := strSQL + '  G.ITE_DESF01, ';
    strSQL := strSQL + '  G.ITE_DESF02, ';
    strSQL := strSQL + '  G.ITE_DESF03, ';
    strSQL := strSQL + '  G.ITE_DESF04, ';
    strSQL := strSQL + '  G.ITE_DESF05, ';
    strSQL := strSQL + '  G.ITE_DESF06, ';

    If blnUtiInd Then
      strSQL := strSQL + '  G.ITE_PRECOM * IF(G.ITE_PREDOL = "S", (SELECT MOE_DOLVEN FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1), 1) AS ITE_PRECOM, '
    Else
      strSQL := strSQL + '  G.ITE_PRECOM, ';

    strSQL := strSQL + '  G.ITE_PREULT, ';

    strSQL := strSQL + '  G.ITE_PRECUS, ';
    strSQL := strSQL + '  G.ITE_IPIENT, ';
    strSQL := strSQL + '  G.ITE_SUBSTI, ';
    strSQL := strSQL + '  G.ITE_IMPFED, ';
    strSQL := strSQL + '  G.ITE_ACRFIN  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER G ';
    strSQL := strSQL + '  INNER JOIN CADITE C ON C.ITE_CODITE = G.ITE_CODITE  ';

    If fCfgSis('TABPRF', varBoolean) Then
    Begin
      strSQL := strSQL + '  LEFT JOIN (SELECT * FROM ITEFOR F WHERE  F.ITE_CODFAB IS NOT NULL ';
      strSQL := strSQL + '                  AND (SELECT COUNT(*) FROM TABPRE     ';
      strSQL := strSQL + '                       WHERE F.ITE_CODTAB = TAB_CODTAB AND' + fSqlWhereTabPre(strPrF_AE, recOpcGir.strCodTab) + ') > 0 ';
      strSQL := strSQL + '    GROUP BY F.ITE_CODFAB) F ON F.ITE_CODITE = G.ITE_CODITE         ';
      strSQL := strSQL + '                            AND F.ITE_CODFOR = :CODFOR              ';
    End Else
    Begin
      strSQL := strSQL + '  LEFT JOIN ITEFOR F ON F.ITE_CODITE = C.ITE_CODITE AND ';
      strSQL := strSQL + '                        F.ITE_CODFOR = :CODFOR          ';
      strSQL := strSQL + '                  AND F.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF     ';
      strSQL := strSQL + '                       WHERE FF.ITE_CODITE = G.ITE_CODITE AND ';
      strSQL := strSQL + '                             FF.ITE_CODFOR = :CODFOR)   ';
    End;

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  G.ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := strCodIte;

    If Params.FindParam('CODFOR') <> Nil Then
      ParamByName('CODFOR').AsString := strCodFor;

    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
  End;
End;

procedure TfrmPedidoDeCompra.pCarregaDadosDeCompra(strCodIte, strCodFor, strCodEmp: String; Var blnPrecoFor: Boolean);
Begin
  If Not fLePrecoCompraFornecedor(qryDadCom, strCodFor, strCodIte, strCodEmp, fSqlWhereTabPre(strPrF_AE, recOpcGir.strCodTab), chkCnvEmb.Checked) Then
  Begin
    blnPrecoFor := False;
    pLePrecoCompraItem(qryDadCom, strCodIte, strCodFor);
  End Else
  Begin
    blnPrecoFor := True;
  End;
End;

procedure TfrmPedidoDeCompra.pCarregaDigitador;
begin
  strCodDig := '';
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtCodDig.Text, True);
  With qryConOpe Do
  Begin
    strCodDig      := FieldByName('OPE_CODOPE').AsString;
    edtNomDig.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

procedure TfrmPedidoDeCompra.pHabilitaPrecos(blnHabilita: Boolean);
Begin
  If Not blnCmpTpr Then
    Exit;

  edtUnitar.ReadOnly := Not blnHabilita;
  edtUnitar.TabStop  := blnHabilita;

  edtPerIpi.ReadOnly := Not blnHabilita;
  edtPerIpi.TabStop  := blnHabilita;
End;

procedure TfrmPedidoDeCompra.pHabilitaUnidade(blnTemTabPreco: Boolean);
begin
  If Not blnCmpTUn Then
    Exit;
  IF blnTemTabPreco And blnCmpTUn Then
  Begin
    edtCodUni.TabStop  := False;
    edtCodUni.ReadOnly := True;
    edtEmbala.TabStop  := False;
    edtEmbala.ReadOnly := True;
  End;
end;

procedure TfrmPedidoDeCompra.pCarregaItem;
  Var
    fltEmbalaFor,
    fltPreComRat,
    fltPrecoForn,
    fltPrecoAcre: Double;
    blnIteEsp: Boolean;

    intRecNo: Integer;
    blnPodeUtilizar: Boolean;
    fltEmbala: Double;
    blnPrecoFor: Boolean;
    strPerImp: String;
    strFilterBkp: String;
    blnFilteredBkp: Boolean;

  function fTransformSQLInterno(strCampo: String; intTamanho: Integer;
    strChar: String): String;
  Var
    intIndice: Integer;
    intContador: Integer;
  begin
    intIndice := 1;
    Result := 'CONCAT_WS(' + QuotedStr(strChar) + ', ';

    For intContador := 1 To 60 Do
    Begin
      Result := Result + 'SUBSTR(' + strCampo + ', ' + IntToStr(intIndice) + ',' + IntToStr(intTamanho) + ')';

      If intContador < 60 Then
        Result := Result + ',';

      Inc(intIndice, intTamanho);
    End;

    Result := Result + ')';
  end;

  function fTransformSQL(strCampo: String): String;
  begin
    Result := fTransformSQLInterno(strCampo, 4, '_');
  end;

  procedure pCarregaDadosAbfIcm(strCodFor, strCodAbf: String);
  var
    qryAbfTMP: TUniQuery;
  begin
    try
      qryAbfTMP := fCriaQuery(Nil);
      qryAbfTMP.Close;
      qryAbfTMP.SQL.Clear;
      qryAbfTMP.SQL.Add('SELECT ');
      qryAbfTMP.SQL.Add('  ABFICM.* ');
      qryAbfTMP.SQL.Add('FROM ');
      qryAbfTMP.SQL.Add('  ABFICM ');
      qryAbfTMP.SQL.Add('  JOIN CADFOR ON FOR_CODFOR = :CODFOR ');
      qryAbfTMP.SQL.Add('  JOIN CADCID ON CID_CODCID = FOR_CODCID ');
      qryAbfTMP.SQL.Add('WHERE ');
      qryAbfTMP.SQL.Add('  ABF_CODABF = :CODABF AND ');
      qryAbfTMP.SQL.Add('  ABF_ESTADO = CID_ESTADO ');

      qryAbfTMP.ParamByName('CODABF').AsString := strCodAbf;
      qryAbfTMP.ParamByName('CODFOR').AsString := strCodFor;
      qryAbfTMP.Open;

      If Not qryAbfTMP.IsEmpty Then
      Begin
        edtPerImp.Text := FloatToStrF(qryAbfTMP.FieldByName('ABF_ALQIMP' + strTipAbfFor).AsFloat, ffFixed, 12, 2); //imp importacao
        fltAlqIcmIte   := qryAbfTMP.FieldByName('ABF_ALQICM' + strTipAbfFor).AsFloat; //alqicm
        {If cdsItensPedido.State <> dsEdit Then
        Begin
          cdsItensPedido.Edit;
          cdsItensPedido.FieldByName('ITE_ALQICM').AsFloat := qryAbfTMP.FieldByName('ABF_ALQICM' + strTipAbfFor).AsFloat; //alqicm
          cdsItensPedido.Post;
        End;}
      End;
    Finally
      FreeAndNil(qryAbfTMP);
    End;
  end;

  procedure pCarregaPisCofins(strCfop{, AstrCstPis, AstrCstCof}: String);
  var
    qryTblTMP: TUniQuery;
  begin
    Try
      qryTblTMP := fCriaQuery(Nil);
      qryTblTMP.Close;
      qryTblTMP.SQL.Clear;
      qryTblTMP.SQL.Add('SELECT * FROM PISENT WHERE LOCATE(:CLAFIS, ' + fTransformSQL('APC_CFOENT') + ') > 0');
      {qryTblTMP.SQL.Add(' AND APC_CSTENT = ' +fQuotedStr(AstrCstPis));}
      qryTblTMP.SQL.Add('ORDER BY APC_VIGENC DESC, APC_CODAPC ASC');
      qryTblTMP.ParamByName('CLAFIS').AsString := strCfop;
      qryTblTMP.Open;
      If Not qryTblTMP.IsEmpty Then
      Begin
        edtPerPis.Text := FloatToStrF(qryTblTMP.FieldByName('APC_ALQENT').AsFloat, ffFixed, 12, 2);
      End;
      qryTblTMP.Close;
      qryTblTMP.SQL.Clear;
      qryTblTMP.SQL.Add('SELECT * FROM COFENT WHERE LOCATE(:CLAFIS, ' + fTransformSQL('APC_CFOENT') + ') > 0');
      {qryTblTMP.SQL.Add(' AND APC_CSTENT = ' +fQuotedStr(AstrCstCof)) ;}
      qryTblTMP.SQL.Add('ORDER BY APC_VIGENC DESC, APC_CODAPC ASC');
      qryTblTMP.ParamByName('CLAFIS').AsString := strCfop;
      qryTblTMP.Open;
      If Not qryTblTMP.IsEmpty Then
      Begin
        edtPerCof.Text := FloatToStrF(qryTblTMP.FieldByName('APC_ALQENT').AsFloat, ffFixed, 12, 2);
      End;
    Finally
      FreeAndNil(qryTblTMP);
    End;
  end;


begin
  If Assigned(cdsDigMultLoja) Then
    cdsDigMultLoja.strCodFor := edtCodFor.Text;
  fltEmbala := 1;
  pPesquisaCadIte(Nil, qryConIte, edtCodIte.Text, edtCodFor.Text, False, (rdbCodFab.Checked) And (Not blnAlterando),
                 True, True, False, False, False, False, False, False, True, True);

  blnPodeUtilizar := True;

  edtCodIte.Text := qryConIte.FieldByName('ITE_CODITE').AsString;
  strIncPisIte   := qryConIte.FieldByName('ITE_INCPIS').AsString;

  strCodCST := fRetornaCSTFornecedor(edtCodFor.Text, edtCodIte.Text, strCstOrigem);

  pAjustaSubIcms(strCodCST, strCstOrigem);

  ParametrosCalcImpostos.pSetaParametros(qryConIte.FieldByName('ITE_CICMDE').AsString,
                                         qryConIte.FieldByName('ITE_CDPIOP').AsString,
                                         qryConIte.FieldByName('ITE_DIDIOP').AsString);

  {*****************************************}
  {* VERIFICA SE PODE ESCOLHER O PRODUTO.  *}
  {**************************************MV*}
  If (blnUsarGiro) Then
  Begin
    cdsItensGiro.DisableControls;
    intRecNo := cdsItensPedido.RecNo;

    cdsItensGiro.Filtered := False;

    If (Not cdsItensGiro.Locate('ITE_CODITE', edtCodIte.Text, [])) Then
    Begin
      pInsereItemClient(edtCodIte.Text);
      blnPodeUtilizar := cdsItensGiro.Locate('ITE_CODITE', edtCodIte.Text, []);
    End;

    cdsItensPedido.RecNo := intRecNo;
    cdsItensGiro.EnableControls;
  End;

  If (blnPodeUtilizar) Then
  Begin

    blnIteEsp := (Pos('ITEM ESPECIAL', qryConIte.FieldByName('ITE_DESITE').AsString) > 0);
    //Se for multiloja vai carregar o item especial como um item normal
    If blnIteEsp And (recOpcGir.strPedMlj = 'S') Then
      blnIteEsp := False;

    If (Not blnIteEsp) Then
    Begin
      {Garante que o Locate enxergue todos os itens do pedido, mesmo com filtro ativo na grade.}
      strFilterBkp   := cdsItensPedido.Filter;
      blnFilteredBkp := cdsItensPedido.Filtered;
      cdsItensPedido.DisableControls;
      cdsItensPedido.Filtered := False;
      Try
        blnAlterando := cdsItensPedido.Locate('ITE_CODITE', edtCodIte.Text, []);
      Finally
        If blnFilteredBkp Then
        Begin
          cdsItensPedido.Filter   := strFilterBkp;
          cdsItensPedido.Filtered := blnFilteredBkp;
          {Reativar o filtro pode mover o cursor; reposiciona por Locate (nao RecNo, instavel entre filtros).
           Verificar Nota 1 - Req. 456447}
          cdsItensPedido.Locate('ITE_CODITE', edtCodIte.Text, []);
        End;
        cdsItensPedido.EnableControls;
      End;
    End;

    If (edtCodIte.Text <> cdsItensPedido.FieldByName('ITE_CODITE').AsString) Or
       (blnIteEsp) or (blnMudaTabPre)                                        Then
    Begin

      With qryConIte Do
      Begin

        If (Not blnAlterando) Then
        Begin
          strSubUsu := 'N';

          edtDesIte.Text :=FieldByName('ITE_DESITE').AsString;

          strPerImp := '';
          if chkPedImp.Checked And blnImpostoImportaçãoVemDoCadastroProduto then
            strPerImp := FloatToStrF(FieldByName('ITE_PIMPTC').AsFloat, ffFixed, 12, 2);

          If (fCfgSis('REFPED', varBoolean)) Then
          Begin
            If (FindField('ITE_REFERE') <> Nil) Then
            Begin
              edtDesIte.Text := edtDesIte.Text + ' ' + FieldByName('ITE_REFERE').AsString;
            End;
          End;

          If chkCnvEmb.Checked And
             fCarregaTabelaPrecoAtiva(edtCodFor.Text, FieldByName('ITE_CODITE').AsString, qryIteFor, fSqlWhereTabPre(strPrF_AE, recOpcGir.strCodTab)) And
            (qryIteFor.FieldByName('ITE_CNVCUS').AsFloat <> 0) Then
          Begin

            edtCodUni.Text := qryIteFor.FieldByName('ITE_UNICOM').AsString;
            fltEmbala      := qryIteFor.FieldByName('ITE_CNVCUS').AsFloat;

            If Not fEmptyStr(qryIteFor.FieldByName('ITE_DESITE').AsString) Then
              edtDesIte.Text := qryIteFor.FieldByName('ITE_DESITE').AsString;

          End Else
          Begin
            edtCodUni.Text := FieldByName('ITE_CODUNI').AsString;

            If chkCnvEmb.Checked Then
            Begin
              fltEmbalaFor := TIteBar.fRetEmbalagemFornecedor(FieldByName('ITE_CODITE').AsString, edtCodFor.Text);

              If fltEmbalaFor > 0 Then
              Begin
                edtCodUni.Text := FieldByName('ITE_UNICOM').AsString;
                fltEmbala      := fltEmbalaFor;
              End

              Else If (qryConIte.FieldByName('ITE_EMBALA').AsFloat <> 0) And (qryConIte.FieldByName('ITE_EMBALA').AsFloat <> 1) Then
              Begin
                edtCodUni.Text := FieldByName('ITE_UNICOM').AsString;
                fltEmbala      := FieldByName('ITE_EMBALA').AsFloat;
              End;

            End;

          End;

          edtSigUni.Text := fRetSiglaUni(edtCodUni.Text);

          If blnUsarGiro And (recOpcGir.strPedMlj <> 'S') And (Not blnCarregandoRequisicoes) Then
            edtQtdIte.Text := FloatToStrF(fRetSugestao(FieldByName('ITE_CODITE').AsString), ffNumber, 12, intDecTpc);

          edtEmbala.Text := FloatToStrF(fltEmbala, ffNumber, 20, DEC_EMBALAGEM);

          edtPraval.Text := FieldByName('ITE_PRAVAL').AsString;

          If blnOriIte Then
            pInicializaDiaEnt(FieldByName('ITE_DIAFOR').AsInteger)
          Else
            pInicializaDiaEnt(fGetDiaFor);

        End;

        If (rdgDesPdi.Visible) And (rdgDesPdi.ItemIndex = 1) Then
        Begin
          If Not fEmptyStr(FieldByName('ITE_DESFAB').AsString) Then
            edtDesIte.Text := FieldByName('ITE_DESFAB').AsString;
        End;

      End;

      If (Not blnAlterando) Or (blnMudaTabPre) Then
      Begin
        pCarregaIteger(qryConIte.FieldByName('ITE_CODITE').AsString);
        pCarregaDadosDeCompra(qryConIte.FieldByName('ITE_CODITE').AsString, edtCodFor.Text, strCodEmp, blnPrecoFor);
        If blnPrecoFor and (not fCfgSis('TABPRD', varBoolean)) then
        Begin
          fltEmbala := qryDadCom.FieldByName('ITE_EMBALA').AsFloat;
          edtEmbala.Text := FloatToStrF(fltEmbala, ffNumber, 20, DEC_EMBALAGEM);
        End;

        With qryDadCom Do
        Begin
          fltPreComRat := FieldByName('ITE_PRECOM').AsFloat;
          fltPreComRat := fltPreComRat - ( fltPreComRat * (FieldByName('ITE_DESF01').AsFloat  / 100 ) );
          fltPreComRat := fltPreComRat - ( fltPreComRat * (FieldByName('ITE_DESF02').AsFloat  / 100 ) );
          fltPreComRat := fltPreComRat - ( fltPreComRat * (FieldByName('ITE_DESF03').AsFloat  / 100 ) );
          fltPreComRat := fltPreComRat - ( fltPreComRat * (FieldByName('ITE_DESF04').AsFloat  / 100 ) );
          fltPreComRat := fltPreComRat - ( fltPreComRat * (FieldByName('ITE_DESF05').AsFloat  / 100 ) );
          fltPreComRat := fltPreComRat - ( fltPreComRat * (FieldByName('ITE_DESF06').AsFloat  / 100 ) );

          fltPrecoAcre := fltPreComRat + ( fltPreComRat * (FieldByName('ITE_ACRFIN').AsFloat  / 100 ) );

          fltPrecoForn := fPrecoUnitarioEspecialFornecedor(edtCodFor.Text, qryConIte.FieldByName('ITE_CODITE').AsString);

          edtDesUni.Text := FloatToStrF(0, ffNumber, 12, 2);
          edtDesUn2.Text := FloatToStrF(0, ffNumber, 12, 2);
          edtDesUn3.Text := FloatToStrF(0, ffNumber, 12, 2);
          edtDesUn4.Text := FloatToStrF(0, ffNumber, 12, 2);
          edtDesUn5.Text := FloatToStrF(0, ffNumber, 12, 2);
          edtDesUn6.Text := FloatToStrF(0, ffNumber, 12, 2);

          If fEmptyStr(edtDesUni.Text) Then
            edtDesUni.Text := FloatToStrF(0, ffNumber, 12, 2);

          If (fltPrecoForn > 0) Then
          Begin
            edtUnitar.Text := FloatToStrF(fltPrecoForn, ffNumber, 12, intDecUni);
            strUniOri      := FloatToStrF(fltPrecoForn, ffNumber, 12, intDecUni);
          End
          Else
          Case strUniPcg[1] Of
            '1': Begin
                   edtUnitar.Text := FloatToStrF(FieldByName('ITE_PRECOM').AsFloat, ffNumber, 12, intDecUni);
                   strUniOri      := FloatToStrF(FieldByName('ITE_PRECOM').AsFloat, ffNumber, 12, intDecUni);
                 End;
            '2',
            '6': Begin
                   edtUnitar.Text := FloatToStrF(fltPreComRat, ffNumber, 12, intDecUni);
                   strUniOri      := FloatToStrF(fltPreComRat, ffNumber, 12, intDecUni);
                 End;
            '3': Begin
                   edtUnitar.Text := FloatToStrF(FieldByName('ITE_PRECUS').AsFloat, ffNumber, 12, intDecUni);
                   strUniOri      := FloatToStrF(FieldByName('ITE_PRECUS').AsFloat, ffNumber, 12, intDecUni);
                 End;
            '4': Begin
                   edtUnitar.Text := FloatToStrF(fltPrecoAcre, ffNumber, 12, intDecUni);
                   strUniOri      := FloatToStrF(fltPrecoAcre, ffNumber, 12, intDecUni);
                 End;

            '7': Begin
                   edtUnitar.Text := FloatToStrF(FieldByName('ITE_PRECOM').AsFloat, ffNumber, 12, intDecUni);
                   strUniOri      := FloatToStrF(FieldByName('ITE_PRECOM').AsFloat, ffNumber, 12, intDecUni);

                   edtDesUni.Text := FloatToStrF(FieldByName('ITE_DESF01').AsFloat, ffNumber, 12, 2);
                   edtDesUn2.Text := FloatToStrF(FieldByName('ITE_DESF02').AsFloat, ffNumber, 12, 2);
                   edtDesUn3.Text := FloatToStrF(FieldByName('ITE_DESF03').AsFloat, ffNumber, 12, 2);
                   edtDesUn4.Text := FloatToStrF(FieldByName('ITE_DESF04').AsFloat, ffNumber, 12, 2);
                   edtDesUn5.Text := FloatToStrF(FieldByName('ITE_DESF05').AsFloat, ffNumber, 12, 2);
                   edtDesUn6.Text := FloatToStrF(FieldByName('ITE_DESF06').AsFloat, ffNumber, 12, 2);
                 End;

            '8': Begin
                   edtUnitar.Text := FloatToStrF(FieldByName('ITE_PREULT').AsFloat, ffNumber, 12, intDecUni);
                   strUniOri      := FloatToStrF(FieldByName('ITE_PREULT').AsFloat, ffNumber, 12, intDecUni);
                 End;


            Else Begin {If (fCfgSis('UNIPCG') = '5') Then}
                   edtUnitar.Text := '';
                   strUniOri      := '';
                 End;
          End;

          If chkCnvEmb.Checked And (fltEmbala <> 0) And (Not blnPrecoFor) Then
             edtUnitar.Text := FloatToStrF(fStrToFloat(edtUnitar.Text) * fltEmbala, ffNumber, 12, intDecUni)
          Else If chkCnvEmb.Checked And (fltEmbala > 0) And (fCfgSis('TABPRD', varBoolean)) Then
             edtUnitar.Text := FloatToStrF(fStrToFloat(edtUnitar.Text) * fltEmbala, ffNumber, 12, intDecUni);

          edtPerIpi.Text := FloatToStrF(FieldByName('ITE_IPIENT').AsFloat, ffFixed, 15, 4); // ALEXANDRE '0,00';

          If chkPedImp.Checked and blnImpostoPedImportacao Then
          Begin
            edtPerIpiImp.Text := edtPerIpi.Text;//ipi

            If fEmptyStr(strTipAbfFor) Then
              strTipAbfFor := fGetTipoAbfFornecedor(edtCodFor.Text);

            pCarregaDadosAbfIcm(edtCodFor.Text, fRetornaAbreviacaoItem(edtCodIte.Text));

            pCarregaPisCofins(fCfgSis('IMPFIS'){, strCodCST, strCodCST});

            //cdsItensPedido.Edit;
          End;

          if chkPedImp.Checked And blnImpostoImportaçãoVemDoCadastroProduto then
            edtPerImp.Text :=  strPerImp;

          edtPerSub.Text := FloatToStrF(FieldByName('ITE_SUBSTI').AsFloat, ffFixed, 15, 4);

          pHabilitaPrecos(Not (fStrToFloat(edtUnitar.Text) > 0) And (Not fEmptyStr(FieldByName('ITE_CODTAB').AsString)));
          pHabilitaUnidade(FieldByName('ITE_CODTAB').AsString <> '');
        End; {With qryDadCom Do}

      End; {If (Not blnAlterando) Or (blnMudaTabPre) Then }

    End
    Else
    Begin
      edtDesIte.Text := cdsItensPedido.FieldByName('ITE_DESITE').AsString;
      edtCodUni.Text := cdsItensPedido.FieldByName('ITE_CODUNI').AsString;
      edtEmbala.Text := FormatFloat(fMskDigitos(DEC_EMBALAGEM), cdsItensPedido.FieldByName('ITE_QTDEMB').AsFloat);
      edtPraVal.Text := cdsItensPedido.FieldByName('ITE_PRAVAL').AsString;

      edtSigUni.Text := fRetSiglaUni(edtCodUni.Text);
      edtQtdIte.Text := FormatFloat(fMskDigitos(intDecTpc), cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat);
      edtUnitar.Text := FormatFloat(fMskDigitos(intDecUni), cdsItensPedido.FieldByName('ITE_UNITAR').AsFloat);
      edtDesUni.Text := FormatFloat(fMskDigitos(2), cdsItensPedido.FieldByName('ITE_DESUNI').AsFloat);
      If objCopiaSeg.recPcmger.blnSomaDescontoAdcionalFornecedor1  Then
        edtDesUni.text :=  FloatToStrF(cdsItensPedido.FieldByName('ITE_DESUNI').AsFloat + StrToFloatDef(edtDesAdi.Text, 0), ffNumber, 12, intDecUni);

      edtDesUn2.Text := FormatFloat(fMskDigitos(2), cdsItensPedido.FieldByName('ITE_DESUN2').AsFloat);
      edtDesUn3.Text := FormatFloat(fMskDigitos(2), cdsItensPedido.FieldByName('ITE_DESUN3').AsFloat);
      edtDesUn4.Text := FormatFloat(fMskDigitos(2), cdsItensPedido.FieldByName('ITE_DESUN4').AsFloat);
      edtDesUn5.Text := FormatFloat(fMskDigitos(2), cdsItensPedido.FieldByName('ITE_DESUN5').AsFloat);
      edtDesUn6.Text := FormatFloat(fMskDigitos(2), cdsItensPedido.FieldByName('ITE_DESUN6').AsFloat);
      edtUniLiq.Text := FormatFloat(fMskDigitos(intDecUni), cdsItensPedido.FieldByName('ITE_UNILIQ').AsFloat);
      edtPerIpi.Text := FormatFloat('#,####0.0000', cdsItensPedido.FieldByName('ITE_PERIPI').AsFloat);
      edtPerSub.Text := FormatFloat('#,####0.0000', cdsItensPedido.FieldByName('ITE_PERSUB').AsFloat);

      fltVlrAlqSubOri := cdsItensPedido.FieldByName('ITE_PERSUB').AsFloat;

      mskDtaEnt.Text := cdsItensPedido.FieldByName('ITE_DTAENT').AsString;

      If Not cdsItensPedido.FieldByName('ITE_DTAENT').IsNull Then
        edtDiaEnt.Text := IntToStr(Trunc(cdsItensPedido.FieldByName('ITE_DTAENT').AsDateTime - StrToDateDef(mskDtaFat.Text, VS_Date)));

      strCodSitIte       := cdsItensPedido.FieldByName('ITE_CODSIT').AsString;
      strCodSitOrigemIte := cdsItensPedido.FieldByName('ITE_SITORI').AsString;
      strIncPisIte       := cdsItensPedido.FieldByName('ITE_INCPIS').AsString;

      strAutoIncrem  := cdsItensPedido.FieldByName('AUTOINCREM').AsString;

      pHabilitaPrecos(Not (fStrToFloat(edtUnitar.Text) > 0) And (Not fEmptyStr(cdsItensPedido.FieldByName('ITE_CODTAB').AsString)));
      pHabilitaUnidade(cdsItensPedido.FieldByName('ITE_CODTAB').AsString <> '');

      ParametrosCalcImpostos.pSetaParametros(cdsItensPedido.FieldByName('ITE_CICMDE').AsString,
                                             cdsItensPedido.FieldByName('ITE_CDPIOP').AsString,
                                             cdsItensPedido.FieldByName('ITE_DIDIOP').AsString);

      If (cdsItensPedido.FieldByName('ITE_SUBUSU').AsString = 'S') And
         fPergunta('O valor da substituição' + IIF(blnZonaFranca, ' ou ICMS desonerado', '') + ' desse produto foi definido pelo digitador.' + #13#10 +
                   'Deseja recalcular o valor pelos dados cadastrais?', False) Then
      Begin
        strSubUsu := 'N';
        pCalculaTotalItem(True);
      End Else
      Begin
        strSubUsu      := cdsItensPedido.FieldByName('ITE_SUBUSU').AsString;
      End;
    End;

    pAtualizaUnitarioLiquido;
  End;

end;

Procedure TfrmPedidoDeCompra.pAtualizaUnitarioLiquido;
  Var
    lfltUnitar: Double;
    recDescontoItem: TRecDescontoItem;
Begin
  recDescontoItem := fObterDescontosItem(False);

  lfltUnitar := fStrToFloat(edtUnitar.Text);
  edtUniLiq.Text := FormatFloat(fMskDigitos(intDecUni), recDescontoItem.fCalcularValorDescontado(objCopiaSeg.recPcmger.blnSomaDescontoAdcionalFornecedor1, lfltUnitar));
End;

procedure TfrmPedidoDeCompra.pSetCaptionForm;
begin
  If strEspDoc = 'OR' Then
  Begin
    lblEdicao.Caption := 'EDIÇÃO DO ORÇ. Nro.';
    Self.Caption := 'Digitação de Orçamento de Compra';
  End Else
  Begin
    Self.Caption := 'Digitação de Pedido de Compra';
  End;
end;

procedure TfrmPedidoDeCompra.FormShow(Sender: TObject);
var blnValidarDadosbkp: Boolean;
  intContador: Integer;
  strComponente: String;
begin
  inherited;

  mnuPreparaesdeTEdoPedido.Visible := (recOpcGir.strPedMlj = 'S') And (fCfgSis('LIBETE') <> '2');

  mnuRelEmprestimos.Enabled := fVerificaAcessoSistema('mnuRelEmprestimos', strLoginUsuarioLogado);

  blnCalculouSub := False;

  If blnNovoReg Then
  Begin
    objDuplicatasPedido.pCarregaParcelas('')
  End Else
  Begin
    objDuplicatasPedido.pCarregaParcelas(qryPcmGer.FieldByName('AUTOINCREM').AsString);
    objDuplicatasPedido.blnManterValoresPadrao := qryPcmGer.FieldByName('PCG_PARPAD').AsString = 'S';
    objRequisicao.strAutPedCom := qryPcmGer.FieldByName('AUTOINCREM').AsString;
  End;

  blnFormShow := True;

  blnPRFEFE := fCfgSis('PRFEFE', varBoolean);
//  blnUtiInd := fCfgSis('UTIIND', varBoolean);
  blnUtiInd := False;
  mnuCompraAntiga.Visible := fCfgSis('PCGANT') = 'S';

  pCarregaConfiguracoesGrid;

  cxvItensTEMREQ.Visible := (blnSitPro and blnCorIpd);

  fltLimVer := fCfgSis('LIMVER', varDouble);
  fltLimAma := fCfgSis('LIMAMA', varDouble);

  If (fCfgSis('DIGCOT', varBoolean)) Then
  Begin
    edtCodCmp.PasswordChar := #0;
    edtCodCmp.MaxLength    := 3;
    edtCodCmp.TamCampo     := 3;
    edtCodCmp.CompZeros    := True;
    lblTitDig.Visible := True;
    edtCodDig.Visible := True;
    edtNomDig.Visible := True;
  End
  Else
  Begin
    lblTitDig.Visible := False;
    edtCodDig.Visible := False;
    edtNomDig.Visible := False;

  End;


  If strCnvEmb <> 'N' Then
  Begin
    If Not (blnUsarGiro Or blnAltPedGir) Then
      chkCnvEmb.Checked := fCfgSis('CNVSUG', varBoolean);
  End Else
  Begin
    chkCnvEmb.Visible := False;
    chkCnvEmb.Checked := False;
  End;

  If SameText(strLitGal, 'L') Then
    cxvItensLITROS.Caption := 'Lt/Kg'
  Else
    cxvItensLITROS.Caption := 'Galonag.';

  If Not blnUsarGiro Then
  Begin
    If fCfgSis('INCPED') = '1' Then
      cdsItensPedido.IndexFieldNames := 'ITE_DESITE'
    Else
      cdsItensPedido.IndexFieldNames := 'AUTOINCREM';
  End
  Else
  Begin
    If recOpcGir.intOrdem = 0 Then
      cdsItensPedido.IndexFieldNames := 'ITE_DESITE'
    Else
      cdsItensPedido.IndexFieldNames := 'ITE_DESMAR;ITE_DESITE';
  End;

  btnAltTra.Visible      := (recOpcGir.strPedMlj = 'S');
  cxvItensQTDTRA.Visible := btnAltTra.Visible;
  lblLegQtdTra.Visible   := btnAltTra.Visible;

  {******************************************}
  {* QUANDO UTILIZAR ESSE RECURSO, NÃO      *}
  {* ESQUECER DE "LIMPAR" O EVENTO, OU SEJA *}
  {* ATRIBUIR NIL AO EVENTO. VER (*) NO E-  *}
  {* VENTO "OnClose"                        *}
  {* AO FAZE-LO, FAVOR COLOCAR ESSE COMEN-  *}
  {* TARIO                                  *}
  {***************************************MV*}
  cdsItensPedido.AfterPost   := pAfterPost;
  cdsItensPedido.First;

  dtsItensPedido.DataSet := cdsItensPedido;

  If Not fCfgSis('REFCOP', varBoolean) Then
  Begin
    SetLength(ArrCampoBloqueado, 1);
    ArrCampoBloqueado[0].ComponentName := cxvItensREFERE.Name;
  End;

  if (fCfgSis('EXIPCT', varString) = 'S') then
  begin
    cxvItensTIPABS.Visible := True;
    cxvItensVNOLCD.Visible := True;
  end
  else
  begin
    cxvItensTIPABS.Visible := False;
    cxvItensVNOLCD.Visible := False;

    SetLength(ArrCampoBloqueado, Length(ArrCampoBloqueado) + 1);
    ArrCampoBloqueado[High(ArrCampoBloqueado)].ComponentName := cxvItensTIPABS.Name;

    SetLength(ArrCampoBloqueado, Length(ArrCampoBloqueado) + 1);
    ArrCampoBloqueado[High(ArrCampoBloqueado)].ComponentName := cxvItensVNOLCD.Name;
  end;

  For intContador := 0 To cxvItens.ColumnCount -1 Do
  Begin
    strComponente := cxvItens.Columns[intContador].Name;
    If AnsiIndexStr(strComponente,
      [cxvItensCODFAB.Name,
      cxvItensUNILIQ.Name,
      cxvItensREFERE.Name,
      cxvItensFORPRI.Name,
      cxvItensDEPART.Name,
      cxvItensDESGRU.Name,
      cxvItensDESSIM.Name,
      cxvItensDTAULT.Name,
      cxvItensTIPABS.Name,
      cxvItensVNOLCD.Name]) < 0
    Then
    Begin
      SetLength(ArrCampoBloqueado, Length(ArrCampoBloqueado) + 1);
      ArrCampoBloqueado[High(ArrCampoBloqueado)].ComponentName := strComponente;
    End;
  End;

  objItens := TCfgGrid.Create(Self, cxvItens,'Pedido de Compra - Itens', [],'', True, True, ArrCampoBloqueado);
  pMostraColunasUnitarioLiquido(cxvItensUNILIQ.Visible);

  cdsItensGiro := TUniClientDataSet.Create(Self);
  If (blnUsarGiro) Or blnAltPedGir Then
    pCopiaClientDataSet(cdsItensGiroExt, cdsItensGiro);

  If (blnUsarGiro) Or blnAltPedGir Or
     (Assigned(recOpcGir.objSalInt) And recOpcGir.objSalInt.blnEncontrouGiro) Then
    lblDiaCom.Caption := 'Pedido para ' + fDiasPorNivel(recOpcGir.recNivEst) + ' dia(s)'
  Else
    lblDiaCom.Visible := False;

  If blnUsarGiro Then
  Begin
    If Not recOpcGir.blnCarregItensGrid Then
    Begin
      cdsItensPedido.EmptyDataSet;
    End;
  End;

  edtUnitar.EditFormat := fMskDigitos(intDecUni);
  edtUniLiq.EditFormat := fMskDigitos(intDecUni);
  edtDesUni.EditFormat := fMskDigitos(2);
  edtDesUn2.EditFormat := fMskDigitos(2);
  edtDesUn3.EditFormat := fMskDigitos(2);
  edtDesUn4.EditFormat := fMskDigitos(2);
  edtDesUn5.EditFormat := fMskDigitos(2);
  edtDesUn6.EditFormat := fMskDigitos(2);

  strEspOri      := strEspDoc;
  mskDtaPed.Text := DateToStr(VS_Date);
  mskDtaFat.Text := DateToStr(VS_Date);

  dtaDtaPed := VS_Date;
  horHorPed := 0;

  // RECUPERA PEDIDO
  objCopiaSeg.blnZerCon           := blnZerCon;
  objCopiaSeg.cdsItensPedido      := cdsItensPedido;
  objCopiaSeg.cdsItensMultiLojas  := cdsItensMultiLojas;
  objCopiaSeg.fRetQtdConferida    := fRetQtdConferida;
  objCopiaSeg.objSalInt           := recOpcGir.objSalInt;

  pAjustarRadioGroupCodigoFabricaProduto;
  pAlterarRadioGroupCodigoFabricaProduto(qryPcmGer.FieldByName('PCG_TIPFAB').AsString);

  If objCopiaSeg.recPcmger.blnRecuperaPedido Then
  Begin
    pCarregaCapaPedido;

    If blnNovoReg Then
      objCopiaSeg.pAtualizaDadosMultiloja;

    fValidaFornecedor(True);

    mskDtaPed.Text := DateToStr(objCopiaSeg.recPcmger.dtaDtaEnt); // Data de Entrega
  End;

  If (Not blnNovoReg) Or objCopiaSeg.recPcmger.blnRecuperaPedido Then
  Begin
    fCarregaItensPedido;

    If Assigned(objConsultaVeiculo) Then
      objConsultaVeiculo.fCarregaDados(sltItems, True);

    objRequisicao.strEmpSaldos   := fStrEmpSaldos;
    objRequisicao.cdsItensPedido := cdsItensPedido;
    objRequisicao.recOpcGir      := recOpcGir;
    objRequisicao.blnUsarGiro    := blnUsarGiro;

    objRequisicao.fSelecionarRequisicoes(strCodEmp, strNumPed, strEspDoc, '', objCopiaSeg,
                                         blnUsarGiro, recOpcGir, False, False, True);

    edtCodSolicitacaoVinculada.Text := TManutencaoEquipamentoInterno.fRetornaSolicitacaoVinculada(strNumPed, strEspDoc);
  End

  Else If Assigned(objConsultaVeiculo) Then
    objConsultaVeiculo.fCarregaDados(cdsItensPedido);


  If blnNovoReg Then
    strCampoSaldoSub := ''
  Else
    strCampoSaldoSub := fRetCampoAtualizaSaldoPedidoCompra(qryPcmGer.FieldByName('AUTOINCREM').AsString,
                                                           '',
                                                           '',
                                                           blnLibPcm,
                                                           strForFil);

  objItensExcluidos := TRecuperaExcluidos.Create(Self,
                                                 objCopiaSeg.recPcmger.blnRecuperaPedido,
                                                 objCopiaSeg.recPcmger.strAutInc,
                                                 IIF(blnNovoReg, '',  qryPcmGer.FieldByName('PCG_NUMPED').AsString),
                                                 IIF(blnNovoReg, '',  qryPcmGer.FieldByName('PCG_ESPDOC').AsString),
                                                 IIF(blnNovoReg, '',  qryPcmGer.FieldByName('PCG_CODEMP').AsString));

  objItensExcluidos.blnHeranca := blnModoHeranca;

  pAtualizaDados(cdsItensPedido);

  fVerificaTravaFornecedor(recOpcGir.strCodFor, blnUsarGiro);

  If (recOpcGir.strPedMlj = 'S') Then
    edtQtdIte.ReadOnly := True;

  strCmpOri := '';
  blnLibCmp := False;

  If (Not blnNovoReg) Or (blnModoHeranca) Then
  Begin

    If Not objCopiaSeg.recPcmger.blnRecuperaPedido Then
    Begin

      If (Not blnNovoReg) And (fCfgSis('DTAORI') = 'S') Then
      Begin
        dtaDtaPed := qryPcmGer.FieldByName('PCG_DTAPED').AsDateTime;
        horHorPed := qryPcmGer.FieldByName('PCG_HORENT').AsDateTime;
      End;

      chkPreDol.Checked := chkPreDol.Visible And (qryPcmGer.FieldByName('PCG_MOEDA_').AsInteger = INT_MOEDA_DOLAR);

      edtCodFor.Text    := qryPcmGer.FieldByName('PCG_CODFOR').AsString;
      mskDtaPed.Text    := qryPcmGer.FieldByName('PCG_DTAENT').AsString;
      mskDtaFat.Text    := qryPcmGer.FieldByName('PCG_DTAFAT').AsString;

      edtCodCmp.Text    := '';
      If fEmptyStr(qryPcmGer.FieldByName('PCG_CODCMP').AsString) Then
        edtNomCmp.Text   := qryPcmGer.FieldByName('PCG_COMPRA').AsString
      Else
        edtNomCmp.Text   := fRetNomVendRep(qryPcmGer.FieldByName('PCG_CODCMP').AsString);

      mskCndPag.Text    := qryPcmGer.FieldByName('PCG_CONPAG').AsString;
      mskCndPag.EditMask := MASK_CONPAG;
      chkPedImp.Checked := (qryPcmGer.FieldByName('PCG_PEDIMP').AsString = 'S');
      chkPedInt.Checked := (qryPcmGer.FieldByName('PCG_PEDINT').AsString = 'S');
      chkPedBon.Checked := (qryPcmGer.FieldByName('PCG_PEDBON').AsString = 'S');
      chkZeraST.Checked := (qryPcmGer.FieldByName('PCG_ZERAST').AsString = 'S');
      chkPagamentoCartaoCredito.Checked := qryPcmGer.FieldByName('PCG_PAGCCC').AsBoolean;

      If (qryPcmGer.FieldByName('PCG_DESPDI').AsString = 'P') Then
        rdgDesPdi.ItemIndex := 0
      Else
        rdgDesPdi.ItemIndex := 1;

      If (qryPcmGer.FieldByName('PCG_PAGVIS').AsString = 'S') Then
      Begin
        blnLoadPedido     := True;
        chkPgAVis.Checked := True;
        blnLoadPedido     := False;
      End;

    End;

    strCmpOri         := qryPcmGer.FieldByName('PCG_CODCMP').AsString;

    fltValTax         := qryPcmGer.FieldByName('PCG_VALSIS').AsFloat;
    fltValMar         := qryPcmGer.FieldByName('PCG_VALMAR').AsFloat;

    If (Not chkPedImp.Checked) Then
    Begin
      edtQtdCtn.Visible := False;
      lblQtdCtn.Visible := False;
    End;

    edtQtdCtn.Text    := fRetQtdCtn;

    edtNumPed.Text := qryPcmGer.FieldByName('PCG_NUMPED').AsString;
    If Not fEmptyStr(qryPcmGer.FieldByName('PCG_EMPDES').AsString) Then
      edtEmpDestino.Text := qryPcmGer.FieldByName('PCG_EMPDES').AsString
    Else
    Begin
      lblEmpDestino.Visible := False;
      edtEmpDestino.Visible := False;
    End;

    pCarregaFornecedor(True);

    if objCopiaSeg.recPcmger.blnRecuperaPedido Then
      edtDesAdi.Text := FormatFloat('#0.00', objCopiaSeg.recPcmger.fltDesAdi)
    Else
      edtDesAdi.Text    := FormatFloat('#0.00', qryPcmGer.FieldByName('PCG_DESADI').AsFloat);
    fltPerDesAdiOLD   := fStrToFloat(edtDesAdi.Text);

  End
  Else
  Begin
    edtQtdCtn.Text    := '0';
    lblEdicao.Visible := False;
    edtNumPed.Visible := False;

    lblEmpDestino.Visible := False;
    edtEmpDestino.Visible := False;

    edtQtdCtn.Visible := False;
    lblQtdCtn.Visible := False;
  End;

  pSetCaptionForm;

  pLimpaDadosItem;

  pImportaPedFornecedor;

  blnMudarFoco := True;

  {*****************************************}
  {* ATIVA OS CAMPOS DE TOTAIS             *}
  {**************************************MV*}
  cdsItensPedido.AggregatesActive := True;

  btnEstoque.Visible := VS_blnTemFil;

  If (Not fCfgSis('PEDIMP', varBoolean)) Then
  Begin
    chkPedImp.Visible := False;
    chkPedInt.Visible := False;
  End;

  edtDesIte.Enabled := (fCfgSis('DESPRO') = 'S');

  If fCfgSis('USATMQ') = 'N' Then
  Begin
    lblLitragem.Visible         := False;
    dbeTotLit.Visible           := False;
    cxvItensLITROS.Visible      := False;
    btnLitragem.Visible         := False;
  End Else
  Begin
    If SameText(strLitGal, 'L') Then
      lblLitragem.Caption := 'LIT./QUI.:'
    Else
      lblLitragem.Caption := 'GALÕES';
  End;

  If ((Not blnUsarGiro) And (Not blnAltPedGir))Then
    btnTodIte.Visible := False

  Else If blnNovoReg And (Not blnModoHeranca) And ((Not objCopiaSeg.recPcmger.blnRecuperaPedido) Or fEmptyStr(edtCodFor.Text)) Then
  Begin
    If fEmptyStr(recOpcGir.strCodFor) And (Not fEmptyStr(edtNumPed.Text)) Then
      edtCodFor.Text     := fCampoTabela('PCG_CODFOR', 'PCMGER', ['PCG_NUMPED', 'PCG_ESPDOC', 'PCG_CODEMP'], [edtNumPed.Text, strEspDoc, strCodEmp])
    Else
    Begin
      If Not (recOpcGir.strCodFor = '00000000') Then
      Begin
        edtCodFor.Text := recOpcGir.strCodFor;
        edtNomFor.Text := fRetNomFornecedor(recOpcGir.strCodFor);
      End;
    End;
  End;

  if fEmptyStr(recOpcGir.strCodTab) And (recOpcGir.strPedMlj = 'N') And (Not blnAltPedGir) And
     (not fEmptyStr(edtCodFor.Text)) And (strPrF_AE = 'E') And blnPRFEFE Then
    TfrmNotificaAtivacaoTabPreFor.fEscolheTabelaAUtilizar(edtCodFor.Text, recOpcGir.strCodTab);

  strCodForAnt := edtCodFor.Text;

  If blnNovoReg and (not fEmptyStr(edtCodFor.Text) )  Then
  Begin
    pCarregaFornecedor(True);

    If Not objCopiaSeg.recPcmger.blnRecuperaPedido Then
    Begin

      pInicializaDtaPed;

    End;

  End;

  If (Not cxvItens.DataController.DataSource.DataSet.IsEmpty) And
     (Not fEmptyStr(edtCodFor.Text))           And
     (blnUsarGiro)And
     (Not objCopiaSeg.recPcmger.blnRecuperaPedido) Then   // JA FEZ ACIMA SE FOR RECUPERAR PEDIDO
  Begin
    blnCalculouSub := fRecalcularSubstituicaoTributaria;
  End;


  If fEmptystr(recOpcGir.strCodTab) And blnPRFEFE Then
    recOpcGir.strCodTab := 'ITEGER';

  If blnNovoReg And (Not fEmptyStr(recOpcGir.strCodCmp)) Then
  Begin
    edtNomCmp.Text    := fRetNomVendRep(recOpcGir.strCodCmp);
    If edtCodDig.Visible Then
      edtCodCmp.Text    := recOpcGir.strCodCmp
    Else
      edtCodCmp.Text    := fRetSenhaVendedor(recOpcGir.strCodCmp);
    edtCodCmp.Enabled := False;
  End;

  If blnNovoReg And (Not fEmptyStr(recOpcGir.strCodDig)) Then
  Begin
    edtCodDig.Text := fRetSenhaVendedor(recOpcGir.strCodDig);
    edtNomDig.Text    := fRetNomVendRep(recOpcGir.strCodDig);
  End;

  pMascaraCamposGiro(cdsItensPedido, recOpcGir.intMesMos);

  btnResumoLoja.Visible := (recOpcGir.strPedMlj = 'S');

  pAncoraPainelGiro; // Sempre depois de criar a requisição

  cxvItensDIAEST.Visible := (blnUsarGiro Or blnAltPedGir Or
                            (Assigned(cdsDigMultLoja) And Assigned(cdsDigMultLoja.recOpcGir.objSalInt) And cdsDigMultLoja.recOpcGir.objSalInt.blnEncontrouGiro));

  lblOpcGir.Visible := (Assigned(cdsDigMultLoja) And Assigned(cdsDigMultLoja.recOpcGir.objSalInt) And cdsDigMultLoja.recOpcGir.objSalInt.blnEncontrouGiro);
  lblExiGiro.Visible := lblOpcGir.Visible;

  cxvItensDIASUG.Visible := cxvItensDIAEST.Visible;

  splGiro.Visible := (recOpcGir.strPedMlj = 'S') And (Not blnSinMul);

  cxvItensSALDIS.Visible         := (recOpcGir.strPedMlj <> 'S');

  cxvItensQTDITE.Options.Editing := True; {(recOpcGir.strPedMlj <> 'S') Or (Not fEmptyStr(recOpcGir.strEmpAgr))};

  Self.Activate;
  pAjustaTipoPedido(chkPedImp.Checked);

  objCreditoFornecedor.strCodFor := edtCodFor.Text;
  objCreditoFornecedor.strCodOpe := fTrataCodCmp;
  lblCreFor.Visible := Not objCreditoFornecedor.IsEmpty;

  cxvItens.OptionsView.Footer := True;

  If recOpcGir.recNivEst.nivEstoque In [nivGiro, nivAmbos, nivGiroFornecedor] Then
  Begin
    cxvItensNVLGIR.Visible      := False;
    cxvItensNVLGIR.GroupIndex   := 0;
    cxvItensCORMED.Width        := 55;
    chkSuspOrdem.Visible := False;
  End Else
  Begin
  //  cxvItens.OptionsView.Footer := False;
    cxvItensNVLGIR.Visible      := False;
    cxvItensNVLGIR.GroupIndex   := -1;
    cxvItensCORMED.Width        := 55;
  End;

  cxvItensCORMED.Visible := (blnUsarGiro Or blnAltPedGir Or (Assigned(recOpcGir.objSalInt) And recOpcGir.objSalInt.blnEncontrouGiro)) And
                            (recOpcGir.intMesGir >= 6) And (fltLimAma > 0);

  btnSimGir.Visible := (blnUsarGiro Or blnAltPedGir Or (Assigned(recOpcGir.objSalInt) And recOpcGir.objSalInt.blnEncontrouGiro)) And
                        recOpcGir.blnAgrSim;

  If Not btnSimGir.Visible Then
    btnSimGir.Enabled := False;


  If (Not fEmptyStr(recOpcGir.strEmpGir)) And
     (blnUsarGiro Or blnAltPedGir Or (Assigned(recOpcGir.objSalInt) And recOpcGir.objSalInt.blnEncontrouGiro)) Then
  Begin
    lblEmpGir.Visible := True;
    mmoEmpGir.Text    := AnsiReplaceStr(recOpcGir.strEmpGir, '''', ' ');
    mmoEmpGir.Visible := True;
  End;

  cxvItens.NavigatorButtons.First.Click;

//  pAferScroll(cdsItensPedido);

  btnAltTabPre.Visible := (strPrF_AE = 'E') And (Not blnNovoReg) And blnPRFEFE;

  pSetFocus(edtCodFor);

  pAtualizaDadosCopiaSeg;

  objCopiaSeg.blnGravacaoAtiva := True;

  If (blnUsarGiro Or blnAltPedGir) Then
  Begin
    If recOpcGir.blnExiApli <> pnlAplicacao.Visible Then
      lblExiApliClick(Nil);
  End;

  If recOpcGir.blnImpReq And blnNovoReg Then
  Begin

    blnImportandoRequisicoesAutomatica := True;

    Try
      pImportaRequisicoes('', True);
    Finally
      blnImportandoRequisicoesAutomatica := False;
    End;

  End;

  If blnUsarGiro And (recOpcGir.strPedMlj = 'S') And recOpcGir.blnSpoTra And blnNovoReg Then
  Begin

    Try
      If Assigned(cdsDigMultLoja) Then
        cdsDigMultLoja.blnValidarDados := False;

      objTransfere.cdsItensMult := cdsItensMultiLojas;
      objTransfere.cdsItensPed  := cdsItensPedido;
      objTransfere.pCalculaTotalItemQtdGrid := pCalculaTotalItemQtdGrid;
      objTransfere.blnMtlCom := recOpcGir.blnConsMCom;
      objTransfere.blnMediaAjustada := recOpcGir.blnMedAju;
      objTransfere.blnAgrupando := Not fEmptyStr(recOpcGir.strEmpAgr);

      objTransfere.fGeraSpoolTransferencia(recOpcGir);

    Finally

      If Assigned(cdsDigMultLoja) Then
        cdsDigMultLoja.blnValidarDados := True;

    End;

  End;

  // CONVERTE AS EMBALAGENS
  blnValidarDadosbkp := False;
  If Assigned(cdsDigMultLoja) Then
  begin
    blnValidarDadosbkp := cdsDigMultLoja.blnValidarDados;
    cdsDigMultLoja.blnValidarDados := False;
  End;

  pAtualizaReservados;

  If Assigned(cdsDigMultLoja) Then
    cdsDigMultLoja.blnValidarDados := blnValidarDadosbkp;

  If objCopiaSeg.recPcmger.blnRecuperaPedido And (Not blnCalculouSub) Then
    blnCalculouSub := fRecalcularSubstituicaoTributaria;

  If Not fEmptyStr(objRequisicao.strCodItens) Then
    pMostraProdutosPendentes(False, objRequisicao.strCodItens, '', False);

  pAferScroll(cdsItensPedido);

  cxvItens.ViewData.Expand(True);

  blnFormShow := False;

  edtTotFre.Text    := FormatFloat('#,##0.00', fltValFreGer);
  edtTotDes.Text    := FormatFloat('#,##0.00', fltDesAceGer);

  cdsItensPedido.BeforeScroll := pBeforeScroll;

  pAtualizaBotoesTotais;

  If (Assigned(cdsDigMultLoja)) And (Assigned(objCopiaSeg)) Then
     cdsDigMultLoja.objRecuperaPedido := objCopiaSeg;

  cxvItensBAINOT.Visible := Not blnNovoReg;
  If not blnAnalisaITEFOR Then
    cxvItensPrinc.Visible := False
  Else
    cxvItensPrinc.Visible := True;

  If blnConCol And (Not strNumPed.IsEmpty) Then
    TMontaSQLPedidoCompra.fCarregaControleDeColeta(strNumPed,
                                                   strEspDoc,
                                                   strCodEmp,
                                                   objCopiaSeg.recPcmger.intNumCtn,
                                                   qryColeta);

  btnQuantidadeVendasPerdidas.Visible := recOpcGir.blnVenPer;
  pCarregarItensLista;
  btnCarregaPedidosVenda.Visible := fCfgSis('URCPVR', varBoolean) And (recOpcGir.strPedMlj <> 'S');
  FPnlGiroHeight := pnlGiro.Height;
  Application.ProcessMessages;

  If (Not cxvItens.DataController.DataSource.DataSet.IsEmpty) Then
  Begin
    cxvItens.DataController.GotoFirst;

   {ajusta a ordem do cds para fical igual ao do grid
    cdsItensPedido.IndexFieldNames := fGetOrdemDoGrid(cxvItens);
    cdsItensPedido.First;
    cxvItens.DataController.DataSource.DataSet.First;
    }
  End;

end;

Function TfrmPedidoDeCompra.fPossuiColeta(strCodIte: String): Boolean;
Begin
  If Not Assigned(qryColeta) Then
  Begin
    Result := False;
    Exit;
  End;

  If Not qryColeta.Active Then
  Begin
    Result := False;
    Exit;
  End;

  Result := qryColeta.Locate('CON_CODITE', strCodIte, []);
End;

Procedure TfrmPedidoDeCompra.pCarregaCapaPedido;
Begin
  With objCopiaSeg Do
  Begin
    strNumPed      := recPcmger.strNumPed;  // Número do Pedido
    blnSomaDescontoAdcionalFornecedor1      := recPcmger.blnSomaDescontoAdcionalFornecedor1;  // Número do Pedido

    strCodEmp      := recPcmger.strCodEmp;  // Empresa
    strEspDoc      := recPcmger.strEspDoc;  // Espécie (PD / OR)
    edtCodFor.Text := recPcmger.strCodFor;  // Fornecedor

    mskCndPag.Text := recPcmger.strConPag;  // Cond. Pagamento

    chkPgAVis.Checked := recPcmger.strConPag = '01000';

    dtaDtaPed      := recPcmger.dtaDtaPed;  // Data do Pedido

    edtDesAdi.Text := FloatToStr(recPcmger.fltDesAdi);  // Data do Pedido

    mskDtaPed.Text := DateToStr(recPcmger.dtaDtaEnt); // Data de Entrega
    mskDtaFat.Text := DateToStr(recPcmger.dtaDtaFat);

    If edtCodDig.Visible Then
      edtCodCmp.Text := recPcmger.strCompra // Comprador
    Else
      edtCodCmp.Text := fRetSenhaVendedor(recPcmger.strCompra); // Comprador

    edtQtdCtn.Text := IntToStr(recPcmger.intNumCtn); // Número do Container

    chkPedImp.Checked := (recPcmger.strPedImp = 'S'); // Pedido de Importação?
    chkPedInt.Checked := (recPcmger.strPedInt = 'S'); // Pedido Intrepostado?
    chkPedBon.Checked := (recPcmger.strPedBon = 'S'); // Pedido de Bonificação?
    chkZeraST.Checked := (recPcmger.strZeraST = 'S'); // Zera Calculo ST?

    If (recPcmger.strDesPdi = 'P') Then // Descrição do item no pedido de importação
      rdgDesPdi.ItemIndex := 0
    Else
      rdgDesPdi.ItemIndex := 1;

    strCodCta := recPcmger.strCodCta;  // Centro de Custo
    strNomEmp := recPcmger.strNomEnt;  // Nome p/ Entrega
    strEndEmp := recPcmger.strEndEnt;  // Endereço p/ Entrega
    strCidEmp := recPcmger.strCidEnt;  // Cidade p/ Entrega

    pAlterarRadioGroupCodigoFabricaProduto(recPcmger.strTipFab);

    chkPreDol.Checked := chkPreDol.Visible And (recPcmger.intMoeda = INT_MOEDA_DOLAR);
  End;
End;

Procedure TfrmPedidoDeCompra.pAtualizaDadosCopiaSeg;
var  lSomaDescontoAdcionalFornecedor1: Boolean;
Begin
  lSomaDescontoAdcionalFornecedor1 :=  objCopiaSeg.recPcmger.blnSomaDescontoAdcionalFornecedor1;
  With objCopiaSeg Do
  Begin
    pLimpaDados(False);

    recPcmger.strBStFre := 'S'; //
    recPcmger.strBStAce := 'S'; //
    recPcmger.strIPIFre := 'N'; //

    recPcmger.strNumPed := strNumPed;  // Número do Pedido
    objCopiaSeg.recPcmger.blnSomaDescontoAdcionalFornecedor1 := lSomaDescontoAdcionalFornecedor1;  // Número do Pedido
    recPcmger.strCodEmp := strCodEmp;  // Empresa
    recPcmger.strEspDoc := strEspDoc;  // Espécie (PD / OR)
    recPcmger.strCodFor := edtCodFor.Text;  // Fornecedor
    recPcmger.strConPag := mskCndPag.Text;  // Cond. Pagamento

    recPcmger.dtaDtaPed := dtaDtaPed;       // Data do Pedido
    recPcmger.horHorEnt := fTime();            // Hora do Pedido

    recPcmger.dtaDtaEnt := StrToDateDef(mskDtaPed.Text, VS_Date);  // Data de Entrega
    recPcmger.strCompra := fTrataCodCmp;
    recPcmger.fltTotIpi := fStrToFloat(dbeTotIpi.Text);     // Total de IPI
    recPcmger.fltTotSub := fStrToFloat(dbeTotSub.Text);     // Total de SUB
    recPcmger.fltSubFCP := fStrToFloat(dbeSubFCP.Text);     // Total de SUB FCP
    recPcmger.fltTotIte := fStrToFloat(dbeTotIte.Text);     // Total de Itens
    recPcmger.fltTotGer := fStrToFloat(edtTotGer.Text);     // Total de Itens+IPI+SUB + frete + despesas
    recPcmger.fltValCbs := fDoubleAggregate(cdsItensPedido, 'TOT_VALCBS');
    recPcmger.fltValIbs := fDoubleAggregate(cdsItensPedido, 'TOT_VALIBS');
    recPcmger.fltVal_Is := fDoubleAggregate(cdsItensPedido, 'TOT_VAL_IS');

    recPcmger.intNumCtn := 0;         // Número do Container
    recPcmger.strPedImp := IIF(chkPedImp.Checked, 'S', 'N');  // Pedido de Importação?
    recPcmger.strPedInt := IIF(chkPedInt.Checked, 'S', 'N');  // Pedido Intrepostado?
    recPcmger.fltDesAdi := fStrToFloat(edtDesAdi.Text);  // Desconto Adicionsl

    recPcmger.strPedMlj := recOpcGir.strPedMlj; // Pedido Multi Lojas?
    recPcmger.strUsaGir := IIF(blnUsarGiro, 'S', 'N');

    recPcmger.dtaDtaFat := StrToDateDef(mskDtaFat.Text, VS_Date);  // Data de Faturamento
    recPcmger.strCodCta := strCodCta;  // Centro de Custo
    recPcmger.strNomEnt := strNomEmp;  // Nome p/ Entrega
    recPcmger.strEndEnt := strEndEmp;  // Endereço p/ Entrega
    recPcmger.strCidEnt := strCidEmp;  // Cidade p/ Entrega
    recPcmger.recNivEst := recOpcGir.recNivEst; // Nivel de Giro Selecionado A_B_C_

    recPcmger.fltBasCof := fRetImposto('BASCOF');
    recPcmger.fltValCof := fRetImposto('VALCOF');
    recPcmger.fltBasPis := fRetImposto('BASPIS');
    recPcmger.fltValPis := fRetImposto('VALPIS');
    recPcmger.fltBasIcm := fRetImposto('BASICM');
    recPcmger.fltValIcm := fRetImposto('VALICM');
    recPcmger.fltBasIpi := fRetImposto('BASIPI');
    recPcmger.fltBasSub := fRetImposto('BASSUB');
    recPcmger.strPagVis := IIF(chkPgAVis.Checked, 'S', 'N'); // Pagamento A Vista
    recPcmger.strNumCot := '';  // Número da cotação
    recPcmger.strEmpCot := '';  // Empresa da cotação
    recPcmger.strPedBon := IIF(chkPedBon.Checked, 'S', 'N');      // Pedido Bonificação
    recPcmger.strZeraST := IIF(chkZeraST.Checked, 'S', 'N');      // Zera ST
    recPcmger.strDesPdi := IIF(rdgDesPdi.ItemIndex = 0, 'P','F'); // Descrição do item no pedido de importação
    recPcmger.intMesGir := recOpcGir.intMesGir;
    recPcmger.strMesAtu := IfThen(recOpcGir.blnConsMesAtu, 'S', 'N');
    recPcmger.strTipFab := IIF(blnPermitirCompradorEscolherCodigoFabrica, 'F', '');

    If Not blnNovoReg Then
    With qryPcmGer Do
    Begin
      recPcmger.blnSomaDescontoAdcionalFornecedor1 := FieldByName('PCG_ADAFO1').AsString = 'S';  // Número do Pedido
      recPcmger.strCodTra := FieldByName('PCG_CODTRA').AsString; // Transportadora
      recPcmger.strCodTraRedespacho := FieldByName('PCG_CODTRR').AsString; // Transportadora
      recPcmger.strObs001 := FieldByName('PCG_OBS001').AsString; // Observação 1
      recPcmger.strObs002 := FieldByName('PCG_OBS002').AsString; // Observação 2
      recPcmger.strObs003 := FieldByName('PCG_OBS003').AsString; // Observação 3
      recPcmger.strObs004 := FieldByName('PCG_OBS004').AsString; // Observação 4
      recPcmger.strObs005 := FieldByName('PCG_OBS005').AsString; // Observação 5
      recPcmger.strObs006 := FieldByName('PCG_OBS006').AsString; // Observação 6
      recPcmger.strObsPd1 := FieldByName('PCG_OBSPD1').AsString; // Observ PD 1
      recPcmger.strObsPd2 := FieldByName('PCG_OBSPD2').AsString; // Observ PD 2
      recPcmger.strObsPd3 := FieldByName('PCG_OBSPD3').AsString; // Observ PD 3
      recPcmger.strObsPd4 := FieldByName('PCG_OBSPD4').AsString; // Observ PD 4
      recPcmger.strObsPd5 := FieldByName('PCG_OBSPD5').AsString; // Observ PD 5
      recPcmger.strObsPd6 := FieldByName('PCG_OBSPD6').AsString; // Observ PD 6
      recPcmger.strPedVen := FieldByName('PCG_PEDVEN').AsString; // Pedido de venda
      recPcmger.strAtenca := FieldByName('PCG_ATENCA').AsString; // Atenção de
      recPcmger.strTipFre := FieldByName('PCG_TIPFRE').AsString; // Tipo de Frete
      recPcmger.strTipFreRedespacho := FieldByName('PCG_TIPFRR').AsString; // Tipo de Frete
      recPcmger.strEmpDes := FieldByName('PCG_EMPDES').AsString; // Codigof da empresa destino
      recPcmger.fltValFre := FieldByName('PCG_VALFRE').AsFloat;  // Valor do Frete
      recPcmger.fltDesAce := FieldByName('PCG_DESACE').AsFloat;  // Despesas Acessórias

      recPcmger.strBStFre := FieldByName('PCG_BSTFRE').AsString; //
      recPcmger.strIPIFre := FieldByName('PCG_IPIFRE').AsString; //
      recPcmger.strBStAce := FieldByName('PCG_BSTACE').AsString; //

      recPcmger.strCodEve := FieldByName('PCG_CODEVE').AsString; // Código do Evento
      recPcmger.strOrcOri := FieldByName('PCG_ORCORI').AsString; // Número do orçamento que originou o pedido
      recPcmger.fltValSis := FieldByName('PCG_VALSIS').AsFloat;
      recPcmger.fltValMar := FieldByName('PCG_VALMAR').AsFloat;

      recPcmger.strCodCta := FieldByName('PCG_CODCTA').AsString;  // Centro de Custo
      recPcmger.strNomEnt := FieldByName('PCG_NOMENT').AsString;  // Nome p/ Entrega
      recPcmger.strEndEnt := FieldByName('PCG_ENDENT').AsString;  // Endereço p/ Entrega
      recPcmger.strCidEnt := FieldByName('PCG_CIDENT').AsString;  // Cidade p/ Entrega

      recPcmger.strDocOri := FieldByName('PCG_DOCORI').AsString;  // Origem do Documento (Faturamento)
      recPcmger.intNumCtn := FieldByName('PCG_NUMCTN').AsInteger; // Número do Container
      recPcmger.strNumCot := FieldByName('PCG_NUMCOT').AsString;  // Número da cotação
      recPcmger.strEmpCot := FieldByName('PCG_EMPCOT').AsString;  // Empresa da cotação
      recPcmger.strTipFab := FieldByName('PCG_TIPFAB').AsString;  // Tipo Codigo de Fabrica do Produto

    End;

  End;
End;

function TfrmPedidoDeCompra.fValidaItem(blnBuscaPorChave: Boolean = True; blnTraFor: Boolean = True; blnGruCmp: Boolean = True): Boolean;
  Var
    strEmpDes,
    strItem: String;
    strOpeRes: String;
begin
  Result := True;
  strItem := edtCodIte.Text;

  If (Not blnConfDocumento) Then
  Begin

    If fEmptyStr(edtCodIte.Text) Then
    Begin
      If blnBuscaPorChave Then
      Begin
        If cxgItens.CanFocus Then
        Begin
          pSetFocus(cxgItens);
          pAtualizaDados(Nil);
          blnMudarFoco := False;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'O código do item deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End
    Else If blnBuscaPorChave Then
    Begin

      If qryConIte.IsEmpty Or
        (qryConIte.FieldByName('ITE_CODITE').AsString <> edtCodIte.Text) Or
        blnLimpouItem Then
      Begin
        pCarregaItem;
        blnLimpouItem := False;
      End;

      {********************************************************}
      {* ADICIONADO POIS QUANDO SELECIONAVA UM ITEM E EDITAVA *}
      {* COLOCANDO O CODIGO DE OUTRO ITEM JÁ EXISTENTE NO PED.*}
      {* NÃO ERA ATUALIZADO OS DADOS DO ITEM DIG.  DEIXANDO O *}
      {* REGISTRO DUPLICADO SO FICANDO DIFERENTE O CODIGO DO  *}
      {* PRODUTO                                              *}
      {*****************************************************GB*}
      If ((ActiveControl) = edtCodIte) and fItemCadastrado Then
        pCarregaItem;

      If qryConIte.FieldByName('ITE_CODITE').IsNull Then
      Begin
        fMensagem('ATENÇÃO!', 'O item ' + strItem + ' não está cadastrado ou está inativo!', ['&O k']);
        Result := False;
      End

      Else If qryConIte.FieldByName('ITE_ITEATI').AsString <> 'S' Then
      Begin
        fMensagem('ATENÇÃO!', 'O item ' + strItem + ' está inativo!', ['&O k']);
        Result := False;
      End
      Else If qryConIte.FieldByName('ITE_ATICOM').AsString <> 'S' Then
      Begin
        if fCfgSis('ITEINA', varBoolean) then
        begin
          fMensagem('ATENÇÃO!', 'O item ' + strItem + ' não está ativo para compras!', ['&O k']);
          if not fLiberouItensInativos then
          begin
            Result := False;
          end;
        end
        else
        begin
          fMensagem('ATENÇÃO!', 'O item ' + strItem + ' não está ativo para compras!', ['&O k']);
          Result := False;
        end;
      End

      Else If (Not fTemItemPrecoFornecedor(edtCodFor.Text, qryConIte.FieldByName('ITE_CODITE').AsString, strCodEmp,fSqlWhereTabPre(strPrF_AE, recOpcGir.strCodTab), chkCnvEmb.Checked)) And
              (Pos(strTraFor, 'TA') > 0) And fValidaPrecoItemFornecedor Then
      Begin
        If (strTraFor = 'T') Or  blnTraFor Then
          pMensagemOk('Item não cadastrado na Tabela de Preços do Fornecedor!');

        If strTraFor = 'T' Then
          Result := False;
      End;

      If Result And blnGruCmp And (Not (blnLibCmp And blnAlterando)) Then
      Begin

        If Not fVerificaAcessoSistema('GRUCOM', fRetComprador) Then
        Begin

          strOpeRes := fResponsavelGrupoCompras(qryConIte.FieldByName('ITE_CODITE').AsString);

          If (Not fEmptyStr(strOpeRes)) And (strOpeRes <> fRetComprador) Then
          Begin

            Result := fLiberaAlteracaoOutroResponsavel('ITEM DE OUTRO RESPONSAVEL PELO GRUPO DE COMPRAS!', qryConIte.FieldByName('ITE_CODITE').AsString);

          End;

        End;

      End;

      {****************************************************}
      {* VERIFICA SE O PRODUTO É PARA COMPRA CENTRALIZADA *}
      {* QD NAO É PEDIDO MULTILOJAS                       *}
      {**********************************************LU,JB*}
      If ((edtCodIte.Text <> cdsItensPedido.FieldByName('ITE_CODITE').AsString)      Or
         ((Pos('ITEM ESPECIAL', qryConIte.FieldByName('ITE_DESITE').AsString) > 0))) And
         (recOpcGir.strPedMlj = 'N')  And (Not blnAlterando)                                   Then
      Begin
        If qryConGer.IsEmpty Or (qryConGer.FieldByName('ITE_CODITE').AsString <> edtCodIte.Text) Then
          pCarregaIteger(edtCodIte.Text);

        If qryConGer.FieldByName('ITE_CPRCEN').AsString = 'S' Then
        Begin
          strEmpDes := fRetEmpresaDestino;

          If (VS_strCodEmp <> qryConGer.FieldByName('ITE_EMPCEN').AsString) And
             (strEmpDes    <> qryConGer.FieldByName('ITE_EMPCEN').AsString) And
             (Not fLiberaCompraCentralizada(strItem, qryConGer.FieldByName('ITE_EMPCEN').AsString)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Produto ' + strItem + ' com compra centralizada na Loja ' + qryConGer.FieldByName('ITE_EMPCEN').AsString + '!', ['&O k']);
            Result := False;
          End;

        End;

      End;

    End;

  End;
end;

procedure TfrmPedidoDeCompra.pAtualizaGridRodape(blnExpand: Boolean; var ACodIteProcessado: String);
Var
 intRecNoBkp : Integer;
  procedure pSetCaption(ColumCaption : TcxGridDBBandedColumn; strCampo: String);
  begin
     ColumCaption.Caption := AnsiReplaceStr(ColumCaption.Caption, '(*)', '');
     ColumCaption.Caption := IIf(cdsItensPedido.FieldByName(strCampo).AsFloat > 0,
                                 ColumCaption.Caption + fEscreAsteriscoPromocao(recOpcGir),
                                 AnsiReplaceStr(ColumCaption.Caption, '(*)', ''));

  End;
Begin
  If blnEstaNaImportacao Then
    Exit;

  If Assigned(objTransfere) And objTransfere.blnGerandoSpool Then
    Exit;

  With cdsItensPedido Do
  If Assigned(cdsDigMultLoja) And Assigned(cdsDigMultLoja.frmEntDigMultiLojasNovo) And (Not blnSinMul) Then
  Begin

    If recOpcGir.strPedMlj = 'S' Then
    Begin

      If Assigned(cdsItensMultiLojas) Then
      Begin
        If Assigned(cdsDigMultLoja) Then
          cdsDigMultLoja.FDesIte := cdsItensPedido.FieldByName('ITE_DESITE').AsString;

        cdsItensMultiLojas.Filter := 'ITE_CODITE = ' + QuotedStr(FieldByName('ITE_CODITE').AsString);
        If Not cdsItensMultiLojas.Filtered Then
          cdsItensMultiLojas.Filtered := True;
      End;

    End Else If Assigned(cdsDigMultLoja) Then
    Begin
      cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensView.Bands[1].Caption := 'Informações do item ' + FieldByName('ITE_CODITE').AsString + ' - ' +
         FieldByName('ITE_DESITE').AsString;

      cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensView.DataController.Filter.BeginUpdate;
      intRecNoBkp := cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensView.DataController.RecNo;

      Try
        cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensView.DataController.Filter.Root.Clear;

        cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensView.DataController.Filter.Root.AddItem(cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensView.GetColumnByFieldName('ITE_CODITE'),
                foEqual, FieldByName('ITE_CODITE').AsString, FieldByName('ITE_CODITE').AsString);

       Finally
         cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensView.DataController.Filter.EndUpdate;
         cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensView.DataController.Filter.Active := true;
         cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensView.DataController.RecNo := intRecNoBkp;
       End;

    End;


    If Assigned(cdsDigMultLoja) Then
    Begin
      pSetCaption(cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensQ_V_01, 'ITE_Q_VP01');
      pSetCaption(cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensQ_V_02, 'ITE_Q_VP02');
      pSetCaption(cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensQ_V_03, 'ITE_Q_VP03');
      pSetCaption(cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensQ_V_04, 'ITE_Q_VP04');
      pSetCaption(cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensQ_V_05, 'ITE_Q_VP05');
      pSetCaption(cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensQ_V_06, 'ITE_Q_VP06');
      pSetCaption(cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensQ_V_07, 'ITE_Q_VP07');
      pSetCaption(cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensQ_V_08, 'ITE_Q_VP08');
      pSetCaption(cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensQ_V_09, 'ITE_Q_VP09');
      pSetCaption(cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensQ_V_10, 'ITE_Q_VP10');
      pSetCaption(cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensQ_V_11, 'ITE_Q_VP11');
      pSetCaption(cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensQ_V_12, 'ITE_Q_VP12');
      pSetCaption(cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensVENMES, 'ITE_Q_VPME');
      If cdsDigMultLoja.recOpcGir.recNivEst.nivEstoque = nivNenhum Then
      Begin
        cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensMEDIXX.Caption := 'Média ' + IntToStr(cdsDigMultLoja.recOpcGir.recNivEst.intDiaComGer);
        cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensMEDAJU.Caption := 'Média ' + IntToStr(cdsDigMultLoja.recOpcGir.recNivEst.intDiaComGer) + ' Ajustada';
      End

      Else If FieldByName('ITE_NVLGIR').AsString = 'A' Then
      Begin
        cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensMEDIXX.Caption := 'Média ' + IntToStr(cdsDigMultLoja.recOpcGir.recNivEst.intDiaComNvA);
        cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensMEDAJU.Caption := 'Média ' + IntToStr(cdsDigMultLoja.recOpcGir.recNivEst.intDiaComNvA) + ' Ajustada';
      End

      Else If FieldByName('ITE_NVLGIR').AsString = 'B' Then
      Begin
        cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensMEDIXX.Caption := 'Média ' + IntToStr(cdsDigMultLoja.recOpcGir.recNivEst.intDiaComNvB);
        cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensMEDAJU.Caption := 'Média ' + IntToStr(cdsDigMultLoja.recOpcGir.recNivEst.intDiaComNvB) + ' Ajustada';
      End

      Else If FieldByName('ITE_NVLGIR').AsString = 'C' Then
      Begin
        cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensMEDIXX.Caption := 'Média ' + IntToStr(cdsDigMultLoja.recOpcGir.recNivEst.intDiaComNvC);
        cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensMEDAJU.Caption := 'Média ' + IntToStr(cdsDigMultLoja.recOpcGir.recNivEst.intDiaComNvC) + ' Ajustada';
      End;
    End;

    If blnExpand Then
      cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensView.ViewData.Expand(True);
    cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensView.Controller.LeftPos := 0;

  End Else
  Begin

    If Assigned(frmTelaGiroUma) Then
    Begin
      If (Not blnNovoReg) And Assigned(cdsItensGiroExt) And
         (cdsItensGiroExt.FieldByName('ITE_CODITE').AsString <>
          cdsItensPedido.FieldByName('ITE_CODITE').AsString) Then
      Begin
        If Not cdsItensGiroExt.Locate('ITE_CODITE', cdsItensPedido.FieldByName('ITE_CODITE').AsString, []) Then
          pInsereItemRodapeUmaLoja;
      End;

      If Assigned(cdsItensGridRodape) And
         (cdsItensGridRodape.FieldByName('ITE_CODITE').AsString <> cdsItensPedido.FieldByName('ITE_CODITE').AsString) Then
        cdsItensGridRodape.Locate('ITE_CODITE', cdsItensPedido.FieldByName('ITE_CODITE').AsString, []);

      frmTelaGiroUma.pAtualizaDadosUmaLoja(cdsItensPedido.FieldByName('ITE_CODITE').AsString);
    End;

  End;
  ACodIteProcessado := cdsItensPedido.FieldByName('ITE_CODITE').AsString;

End;

procedure TfrmPedidoDeCompra.pAtualizaPCG_DTAENT(AData: TDateTime);
begin
  mskDtaPed.Text := FormatDateTime('DD/MM/YYYY', AData);
end;

procedure TfrmPedidoDeCompra.pInsereItemRodapeUmaLoja;
  Var
    intContador: Integer;
Begin
  With cdsItensGiroExt Do
  Begin
    Insert;

    For intContador := 0 To Fields.Count - 1 Do
      Fields[intContador].Value := cdsItensPedido.Fields[intContador].Value;

    Post;
  End;
End;

procedure TfrmPedidoDeCompra.pAferScroll(DataSet: TDataSet);
Begin
  If Not DataSet.ControlsDisabled Then
  Begin
    blnAtualizarRodape := True;
    pAtualizaDados(DataSet, False);
  End;
End;

procedure TfrmPedidoDeCompra.pBeforeScroll(DataSet: TDataSet);
Begin

  If Assigned(cdsItensMultiLojas) And cdsItensMultiLojas.Active And
    (cdsItensMultiLojas.State = dsEdit) Then
    cdsItensMultiLojas.Cancel;

End;


procedure TfrmPedidoDeCompra.pAfterPost(DataSet: TDataSet);
Begin
  If Not blnCarregandoPedido Then
    pAtualizaGridRodape(True, strCodIteProcessadoRodape);

  pAtualizaTotalTela;
End;

procedure TfrmPedidoDeCompra.pAtualizaDados(DataSet: TDataSet; blnLerCadastro: Boolean = True; blnForce: Boolean =  False);
begin
  If edtCodIte.Text <> cdsItensPedido.FieldByName('ITE_CODITE').AsString Then
  Begin
    fltValFreSalvo := cdsItensPedido.FieldByName('ITE_VALFRE').AsFloat;
    fltDesAceSalvo := cdsItensPedido.FieldByName('ITE_DESACE').AsFloat;
  End;
  btnSimilares.Visible := (Not fEmptyStr(cdsItensPedido.FieldByName('ITE_CODSIM').AsString)) And
                            fCheckParent(ActiveControl, cxgItens);

  btnSimGir.Visible := btnSimGir.Enabled And btnSimilares.Visible;

  If (Not fCheckParent(ActiveControl, cxgItens)) And (Not blnMudaTabPre) And (Not blnAtualizarPnlDadosItemModoTab) Then
  Begin
    If not blnForce Then
    Exit;
  End;

  With cdsItensPedido Do
  Begin
    strSubUsu      := FieldByName('ITE_SUBUSU').AsString;

    edtCodIte.Text := FieldByName('ITE_CODITE').AsString;
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
    edtCodUni.Text := FieldByName('ITE_CODUNI').AsString;
    edtSigUni.Text := FieldByName('ITE_SIGUNI').AsString;

    edtPraVal.Text := FieldByName('ITE_PRAVAL').AsString;
    edtEmbala.Text := FloatToStrF(FieldByName('ITE_QTDEMB').AsFloat, ffFixed, 20, DEC_EMBALAGEM);
    edtQtdIte.Text := FloatToStrF(FieldByName('ITE_QTDITE').AsFloat, ffFixed, 12, intDecTpc);
    edtUnitar.Text := FloatToStrF(FieldByName('ITE_UNITAR').AsFloat, ffFixed, 12, intDecUni);
    edtDesUni.Text := FloatToStrF(FieldByName('ITE_DESUNI').AsFloat, ffFixed, 12, 2);
    If objCopiaSeg.recPcmger.blnSomaDescontoAdcionalFornecedor1  Then
      edtDesUni.text :=  FloatToStrF(cdsItensPedido.FieldByName('ITE_DESUNI').AsFloat + StrToFloatDef(edtDesAdi.Text, 0), ffNumber, 12, intDecUni);

    edtDesUn2.Text := FloatToStrF(FieldByName('ITE_DESUN2').AsFloat, ffFixed, 12, 2);
    edtDesUn3.Text := FloatToStrF(FieldByName('ITE_DESUN3').AsFloat, ffFixed, 12, 2);
    edtDesUn4.Text := FloatToStrF(FieldByName('ITE_DESUN4').AsFloat, ffFixed, 12, 2);
    edtDesUn5.Text := FloatToStrF(FieldByName('ITE_DESUN5').AsFloat, ffFixed, 12, 2);
    edtDesUn6.Text := FloatToStrF(FieldByName('ITE_DESUN6').AsFloat, ffFixed, 12, 2);
    edtUniLiq.Text := FloatToStrF(FieldByName('ITE_UNILIQ').AsFloat, ffFixed, 12, intDecUni);

    If (strUniPcg[1] <> '7') Then
    Begin
      pHabilitaDesUni(edtDesUni, edtDesUn2);
      pHabilitaDesUni(edtDesUn2, edtDesUn3);
      pHabilitaDesUni(edtDesUn3, edtDesUn4);
      pHabilitaDesUni(edtDesUn4, edtDesUn5);
      pHabilitaDesUni(edtDesUn5, edtDesUn6);
    End;

    edtValTot.Text := FloatToStrF(FieldByName('ITE_TOTITE').AsFloat, ffFixed, 12, 2);
    edtPerIpi.Text := FloatToStrF(FieldByName('ITE_PERIPI').AsFloat, ffFixed, 12, 4);
    edtTotIpi.Text := FloatToStrF(cdsItensPedido.FieldByName('ITE_TOTIPI').AsFloat, ffFixed, 12, 2);
    edtPerSub.Text := FloatToStrF(FieldByName('ITE_PERSUB').AsFloat, ffFixed, 12, 4);

    edtAlqCbs.Text := FloatToStrF(FieldByName('ITE_ALQCBS').AsFloat, ffFixed, 12, 2);
    edtAlqIbs.Text := FloatToStrF(FieldByName('ITE_ALQIBS').AsFloat, ffFixed, 12, 2);
    edtAlq_Is.Text := FloatToStrF(FieldByName('ITE_ALQ_IS').AsFloat, ffFixed, 12, 2);
    edtValCbs.Text := FloatToStrF(FieldByName('ITE_VALCBS').AsFloat, ffFixed, 12, 2);
    edtValIbs.Text := FloatToStrF(FieldByName('ITE_VALIBS').AsFloat, ffFixed, 12, 2);
    edtVal_Is.Text := FloatToStrF(FieldByName('ITE_VAL_IS').AsFloat, ffFixed, 12, 2);

    fltVlrAlqSubOri := FieldByName('ITE_PERSUB').AsFloat;

    edtTotSub.Text := FloatToStrF(FieldByName('ITE_TOTSUB').AsFloat, ffFixed, 12, 2);
    edtSubFCP.Text := FloatToStrF(FieldByName('ITE_SUBFCP').AsFloat, ffFixed, 12, 2);

    edtValDar.Text := FloatToStrF(FieldByName('ITE_TOTDAR').AsFloat, ffFixed, 12, 2);

    edtIcmDes.Text := FloatToStrF(FieldByName('ITE_VALICM').AsFloat, ffFixed, 12, 2);
    edtDesPis.Text := FloatToStrF(FieldByName('ITE_DESPIS').AsFloat, ffFixed, 12, 2);

    // DADOS DE IMPORTAÇÃO
    edtPerImp.Text    := FloatToStrF(FieldByName('ITE_ALQIMP').AsFloat, ffFixed, 12, 2);
    edtTotImp.Text    := FloatToStrF(FieldByName('ITE_VALIMP').AsFloat, ffFixed, 12, 2);

    edtPerIpiImp.Text := FloatToStrF(FieldByName('ITE_PERIPI').AsFloat, ffFixed, 12, 2);
    edtTotIpiImp.Text := FloatToStrF(FieldByName('ITE_TOTIPI').AsFloat, ffFixed, 12, 2);

    edtPerPis.Text    := FloatToStrF(FieldByName('ITE_ALQPIS').AsFloat, ffFixed, 12, 2);
    edtTotPis.Text    := FloatToStrF(FieldByName('ITE_VALPIS').AsFloat, ffFixed, 12, 2);

    edtPerCof.Text    := FloatToStrF(FieldByName('ITE_ALQCOF').AsFloat, ffFixed, 12, 2);
    edtTotCof.Text    := FloatToStrF(FieldByName('ITE_VALCOF').AsFloat, ffFixed, 12, 2);

    mskDtaEnt.Text    := cdsItensPedido.FieldByName('ITE_DTAENT').AsString;

    If Not cdsItensPedido.FieldByName('ITE_DTAENT').IsNull Then
      edtDiaEnt.Text := IntToStr(Trunc(cdsItensPedido.FieldByName('ITE_DTAENT').AsDateTime - StrToDateDef(mskDtaFat.Text, VS_Date)));

    fltBasIcmIte   := FieldByName('ITE_BASICM').AsFloat;
    fltAlqIcmIte   := FieldByName('ITE_ALQICM').AsFloat;
    fltValIcmIte   := FieldByName('ITE_VALICM').AsFloat;
    fltBaseSTIte   := FieldByName('ITE_BASSUB').AsFloat;
    fltDesPisIte   := FieldByName('ITE_DESPIS').AsFloat;
    fltPerFCPIte   := FieldByName('ITE_PERFCP').AsFloat;
    fltSubFCPIte   := FieldByName('ITE_SUBFCP').AsFloat;

    strCodSitIte       := FieldByName('ITE_CODSIT').AsString;
    strCodSitOrigemIte := FieldByName('ITE_SITORI').AsString;
    strIncPisIte       := FieldByName('ITE_INCPIS').AsString;

    strAutoIncrem  := FieldByName('AUTOINCREM').AsString;

    If blnLerCadastro Then
    Begin
      If (Not qryConIte.Active) Or (FieldByName('ITE_CODITE').AsString <> qryConIte.FieldByName('ITE_CODITE').AsString) Then
      Begin
        pPesquisaCadIte(Nil, qryConIte, edtCodIte.Text, edtCodFor.Text, False);
        pCarregaIteger(qryConIte.FieldByName('ITE_CODITE').AsString);
      End;
    End;

    pAjustaSubIcms(FieldByName('ITE_CODSIT').AsString, FieldByName('ITE_SITORI').AsString);
  End;

  If  blnAtualizarRodape then
    tmrAtualizaRodape.Enabled := True;


 // RETIREI PQ ESTAVA MUITO LENTO
 // pMascaraCamposGiro(cdsItensPedido, recOpcGir.intMesMos);
end;

function TfrmPedidoDeCompra.fValidaDescricao(blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (Not blnConfDocumento) Then
  Begin
    If fEmptyStr(edtDesIte.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A descrição do item deve ser preenchida!', ['&O k']);
      Result := False;
    End;
  End;
end;

function TfrmPedidoDeCompra.fValidaQuantidade(
  blnBuscaPorChave: Boolean): Boolean;
  Var
    fltQtdReq,
    fltMltCom: Double;
    strQtdIteAnt: String;
    strCodIteAtu: String;
begin
  Result := True;

  If (Not blnConfDocumento) Then
  Begin
    {********************************************}
    {* SE USAR PEDIDO MULTILOJAS, ABRE UMA TELA *}
    {* PARA DIGITAR A QUANTIDADE DE CADA EMPRESA*}
    {*****************************************MV*}
    If (recOpcGir.strPedMlj = 'S') And (blnBuscaPorChave) And (Not blnCarregandoRequisicoes)  Then
    Begin
      strQtdIteAnt := edtQtdIte.Text;

      result := fDigQuantidadeMultilojaPedCom;

      {Qtde multiloja alterada em tela nao grava sozinha; confirma automaticamente o item e retoma o foco.
       Verificar Nota 2 - Req. 456447}
      If Result And (strQtdIteAnt <> edtQtdIte.Text) and blnAlterando Then
      Begin
        strCodIteAtu := cdsItensPedido.FieldByName('ITE_CODITE').AsString;
        btnAdicionar.Click;
        edtCodIte.Text := strCodIteAtu;
        pCarregaItem;
        // Necessário ajustar o foco neste ponto e ajustar a variável global blnMudarFoco posteriormente,
        // para manter o comportamento anterior.
        pSetFocus(edtQtdIte);
        blnMudarFoco := True;
      End;
    End;

    If Result Then
    Begin
      If qryDadCom.Active And (qryDadCom.FieldByName('ITE_CODITE').AsString = edtCodIte.Text) Then
        fltMltCom := qryDadCom.FieldByName('ITE_MLTCOM').AsFloat

      Else If cdsItensPedido.Active And (cdsItensPedido.FieldByName('ITE_CODITE').AsString = edtCodIte.Text) Then
        fltMltCom := cdsItensPedido.FieldByName('ITE_MLTCOM').AsFloat

      Else fltMltCom := 1;

      If fltMltCom <= 0 Then
        fltMltCom := 1;

      If recOpcGir.strPedMlj = 'S' Then
        fltQtdReq := cdsItensPedido.FieldByName('ITE_QATREQ').AsFloat
      Else
        fltQtdReq := cdsItensPedido.FieldByName('ITE_QTDREQ').AsFloat;

      If fEmptyStr(edtQtdIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade deve ser preenchida!', ['&O k']);
        Result := False;
      End

      Else If (fStrToFloat(edtQtdIte.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade deve ser maior ou igual a zero!', ['&O k']);
        Result := False;
      End

      Else If  (strCmpMlt <> 'N') And (Frac(RoundTo(fStrToFloat(edtQtdIte.Text) / fltMltCom, -4))  <> 0) Then
      Begin
        Result := recValidadorCmpMlt.fLiberado(edtCodIte.Text, fStrToFloat(edtQtdIte.Text), fltMltCom, blnAdicionandoItem);
      End

      Else If blnAlterando And (Not blnALTPNT) And (cdsItensPedido.FieldByName('ITE_BAIPED').AsFloat > 0) Then
      Begin
        pMensagemOk('O sistema está configurado para não permitir alterar produtos já relacionados para a baixa relativa as notas: ' +
                     cdsItensPedido.FieldByName('ITE_BAINOT').AsString + '!');

        Result := False;
      End

      Else If blnAlterando And
              (cdsItensPedido.FieldByName('ITE_BAIPED').AsFloat >
                RoundTo(fStrToFloat(edtQtdIte.Text) * IIF(fStrToFloat(edtEmbala.Text) = 0, 1, fStrToFloat(edtEmbala.Text)), -4)) Then
      Begin
        pMensagemOk('A quantidade não pode ser menor que a quantidade já relacionada para a baixa (' +
                     FormatFloat('#,##0.00', cdsItensPedido.FieldByName('ITE_BAIPED').AsFloat) + ') relativa as notas: ' +
                      cdsItensPedido.FieldByName('ITE_BAINOT').AsString + '!');
        Result := False;
      End

      Else If (recOpcGir.strPedMlj = 'N') And blnAlterando And
              (Not fEmptyStr(cdsItensPedido.FieldByName('ITE_INCIRQ').AsString)) And
              (fltQtdReq > 0) And
              (RoundTo(fltQtdReq, -4) > RoundTo(fStrToFloat(edtQtdIte.Text) * IIF(fStrToFloat(edtEmbala.Text) = 0, 1, fStrToFloat(edtEmbala.Text)), -4)) Then
      Begin
        pMensagemOk('A quantidade do item ' + cdsItensPedido.FieldByName('ITE_CODITE').AsString + ' não pode ser menor que ' +
                    'a quantidade que atendederá as requisições (' + FormatFloat('#,##0.00', fltQtdReq) +
                    ') as quais ela está vinculada!');

        Result := False;
      End;

      If (recOpcGir.strPedMlj = 'S') And (blnBuscaPorChave) Then
      Begin
        If Not fEstaNaConsultaTab Then
          Self.Activate;

        pSetFocus(edtQtdIte);
      End;
    End;
  End;
end;

procedure TfrmPedidoDeCompra.pDadosEntrega;
begin
  strNomEmp := qryPcmGer.FieldByName('PCG_NOMENT').AsString;
  strEndEmp := qryPcmGer.FieldByName('PCG_ENDENT').AsString;
  strCidEmp := qryPcmGer.FieldByName('PCG_CIDENT').AsString;

  pDadosEntregaPedido(strNomEmp, strEndEmp, strCidEmp, IIf(fEmptyStr(qryPcmGer.FieldByName('PCG_EMPDES').AsString),
                                                           qryPcmGer.FieldByName('PCG_CODEMP').AsString,
                                                           qryPcmGer.FieldByName('PCG_EMPDES').AsString));
end;

Function TfrmPedidoDeCompra.fDigQuantidadeMultilojaPedCom: Boolean;
Begin
  If (Not qryConIte.Active) Or
     (edtCodIte.Text <> qryConIte.FieldByName('ITE_CODITE').AsString) Then
    pCarregaItem;

    If (edtCodIte.Text = cdsItensPedido.FieldByName('ITE_CODITE').AsString) And
       (cdsItensPedido.FieldByName('ITE_SUBUSU').AsString = 'S') And
       fPergunta('O valor da substituição' + IIF(blnZonaFranca, ' ou ICMS desonerado', '') + ' desse produto foi definido pelo digitador.' + #13#10 +
                 'Deseja recalcular o valor pelos dados cadastrais?', False) Then
    Begin
      strSubUsu := 'N';
    End Else
    Begin
      strSubUsu := cdsItensPedido.FieldByName('ITE_SUBUSU').AsString;
    End;


    Result := cdsDigMultLoja.fDigQuantidadeMultiloja(edtQtdIte,
                                         edtCodIte.Text,
                                         edtDesIte.Text,
                                         edtSigUni.Text,
                                         fStrToFloat(edtEmbala.Text));

  If Assigned(cdsDigMultLoja) And Assigned(cdsDigMultLoja.frmEntDigMultiLojasNovo) Then
    cdsDigMultLoja.frmEntDigMultiLojasNovo.FormResize(Nil);
End;

Procedure TfrmPedidoDeCompra.pAncoraPainelGiro;
Begin
  If recOpcGir.strPedMlj = 'S' Then
    cdsItensGridRodape := cdsItensMultiLojas

  Else If blnNovoReg And objCopiaSeg.recPcmger.blnRecuperaPedido And Assigned(cdsItensGiroExt) Then
    cdsItensGridRodape := cdsItensGiroExt

  Else If blnNovoReg Or (Not Assigned(cdsItensGiroExt)) Then
    cdsItensGridRodape := cdsItensPedido

  Else
    cdsItensGridRodape := cdsItensGiroExt;

  If recOpcGir.strPedMlj = 'S' Then
  With cdsItensMultiLojas Do
  If (Not Filtered) Or
     (Pos(cdsItensPedido.FieldByName('ITE_CODITE').AsString, Filter) = 0) Then
  Begin
    Filter   := 'ITE_CODITE = ' + QuotedStr(cdsItensPedido.FieldByName('ITE_CODITE').AsString);
    Filtered := True;
  End;

  cdsDigMultLoja := TCdsDigMultLoja.Create(Nil,
                                           cdsItensGridRodape,
                                           cdsItensPedido,
                                           recOpcGir,
                                           pnlGiro,
                                           blnUsarGiro Or blnAltPedGir Or (Assigned(recOpcGir.objSalInt) And recOpcGir.objSalInt.blnEncontrouGiro),
                                           pAfterPost,
                                           Nil,   // pAtualizaMesesP: TPrcAtualizaMeses = Nil;
                                           objCopiaSeg.pPcddetAfterPost,
                                           False,
                                           cxvItensQTDITEPropertiesValidate);

  cdsDigMultLoja.strEmpresaDestino := fRetEmpresaDestino;

  cdsDigMultLoja.frmPaiGiro := Self;

  cdsDigMultLoja.pCalculaTotalItemQtdGrid := pCalculaTotalItemQtdGrid;

  cdsDigMultLoja.pDefineTransferencia := pDefineTransferencia;

  If Assigned(objRequisicao) Then
    cdsDigMultLoja.cdsRequisicao := objRequisicao.cdsRequisicao;

  cdsDigMultLoja.pAncora(False, True, Nil);
  FpnlAplicacaoHeight := 59;
  If pnlAplicacao.Visible Then
    FpnlAplicacaoHeight := pnlAplicacao.Height;
  FPnlGiroHeight := 210;
  If pnlGiro.Visible Then
    FPnlGiroHeight:= pnlGiro.Height;

  pAtualizaGridRodape(True, strCodIteProcessadoRodape);
End;

function TfrmPedidoDeCompra.fValidaUnitario(
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (Not blnConfDocumento) Then
  Begin
    If fEmptyStr(edtUnitar.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Valor Unitário deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else
    Begin
      If fStrToFloat(edtUnitar.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor Unitário deve ser maior que Zero!', ['&O k']);
        Result := False;
      End;
    End;
  End;
end;

Procedure TfrmPedidoDeCompra.pHabilitaDesUni(edtDesUni, edtDesconto: TEditFocus);
Begin
  If Assigned(edtDesconto) Then
  Begin
    edtDesconto.Enabled := fStrToFloat(edtDesUni.Text) > 0;

    If (Not edtDesconto.Enabled) Then
      edtDesconto.Text := FloatToStrF(0, ffNumber, 12, 2);
  End;
End;

function TfrmPedidoDeCompra.fValidaDescontoUnitario(edtDesUni,
                                                    edtDesUn2,
                                                    edtDesUn3,
                                                    edtDesUn4,
                                                    edtDesUn5,
                                                    edtDesUn6: TEditFocus;
                                                    blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Not blnConfDocumento) Then
  Begin
    If fEmptyStr(edtDesUni.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Valor do desconto unitário deve ser preenchido!', ['&O k']);
      Result := False;
    End

    Else If fStrToFloat(edtDesUni.Text) < 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Valor do desconto unitário deve ser maior ou igual a zero!', ['&O k']);
      Result := False;
    End

    Else If fStrToFloat(edtDesUni.Text) >= 100 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Valor do desconto deve ser menor que 100%!', ['&O k']);
      Result := False;
    End;

    If (objCopiaSeg.recPcmger.blnSomaDescontoAdcionalFornecedor1) And
       (fStrToFloat(edtDesUni.Text) <  StrToFloatDef(edtDesAdi.Text, 0)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Devido a opção escolhida para o rateio do desconto adicional(Somar no desconto do fornecedor 1), o valor do desconto deve ser maior ou igual ao desconto adicionado!', ['&O k']);
      Result := False;
    End;

    pHabilitaDesUni(edtDesUni, edtDesUn2);
    pHabilitaDesUni(edtDesUni, edtDesUn3);
    pHabilitaDesUni(edtDesUni, edtDesUn4);
    pHabilitaDesUni(edtDesUni, edtDesUn5);
    pHabilitaDesUni(edtDesUni, edtDesUn6);

  End;

end;

function TfrmPedidoDeCompra.fValidaPerIpi(edtPerIpi: TEditFocus;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (Not blnConfDocumento) Then
  Begin
    If fEmptyStr(edtPerIpi.Text) Then
    Begin
      edtPerIpi.Text := '0,0000';
    End
    Else If Not (InRange(fStrToFloat(edtPerIpi.Text), 0, 100)) And
                (blnBuscaPorChave)                             Then
    Begin
      fMensagem('ATENÇÃO!', 'O percentual do IPI deve estar entre 0 e 100!', ['&O k']);
      Result := False;
    End;
  End;
end;

function TfrmPedidoDeCompra.fValidaAlqReforma(edtAlq: TEditFocus;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (Not blnConfDocumento) Then
  Begin
    If fEmptyStr(edtAlq.Text) Then
    Begin
      edtAlq.Text := '0,00';
    End
    Else If (Not TAliquotasReforma.fAliquotaValida(fStrToFloat(edtAlq.Text))) And
            (blnBuscaPorChave)                                                 Then
    Begin
      fMensagem('ATENÇÃO!', 'A alíquota de CBS, IBS e IS deve estar entre 0 e 100!', ['&O k']);
      Result := False;
    End;
  End;
end;

procedure TfrmPedidoDeCompra.pAjustaCamposReforma;
begin
  pnlReforma.Visible := FblnSomaReforma;
  If Not FblnSomaReforma Then
    pnlReforma.Height := 0;

  lblTotCBS.Visible := FblnSomaReforma;
  dbeTotCBS.Visible := FblnSomaReforma;
  lblTotIBS.Visible := FblnSomaReforma;
  dbeTotIBS.Visible := FblnSomaReforma;
  lblTotIS.Visible  := FblnSomaReforma;
  dbeTotIS.Visible  := FblnSomaReforma;

  If FblnSomaReforma Then
    Panel4.Height := 54
  Else
    Panel4.Height := 27;

  If Not FblnSomaReforma Then
  Begin
    cxvItensALQCBS.Visible := False;
    cxvItensVALCBS.Visible := False;
    cxvItensALQIBS.Visible := False;
    cxvItensVALIBS.Visible := False;
    cxvItensALQ_IS.Visible := False;
    cxvItensVAL_IS.Visible := False;
  End;

  cxvItensALQCBS.VisibleForCustomization := FblnSomaReforma;
  cxvItensVALCBS.VisibleForCustomization := FblnSomaReforma;
  cxvItensALQIBS.VisibleForCustomization := FblnSomaReforma;
  cxvItensVALIBS.VisibleForCustomization := FblnSomaReforma;
  cxvItensALQ_IS.VisibleForCustomization := FblnSomaReforma;
  cxvItensVAL_IS.VisibleForCustomization := FblnSomaReforma;
end;

procedure TfrmPedidoDeCompra.pCalculaReformaTela;
  Var
    recBase: TBaseReforma;
    recValores: TValoresReforma;
begin
  If Not FblnSomaReforma Then
    Exit;

  If fEmptyStr(edtAlqCbs.Text) Then
    edtAlqCbs.Text := '0,00';

  If fEmptyStr(edtAlqIbs.Text) Then
    edtAlqIbs.Text := '0,00';

  If fEmptyStr(edtAlq_Is.Text) Then
    edtAlq_Is.Text := '0,00';

  recBase := TBaseReforma.fCriar(fStrToFloat(edtValTot.Text), fltValFreSalvo, fltDesAceSalvo);

  If Not (blnZonaFranca And ParametrosCalcImpostos.blnCalcularICMSDesonerado) Then
    recBase.fltValIcm := RoundTo(fltBasIcmIte * fltAlqIcmIte / 100, -2);

  If chkPedImp.Checked Then
  Begin
    recBase.fltValImp := fStrToFloat(edtTotImp.Text);
    recBase.fltValPis := fStrToFloat(edtTotPis.Text);
    recBase.fltValCof := fStrToFloat(edtTotCof.Text);
  End;

  recValores := TCalculoReformaCompra.fCalcular(recBase,
                                                TAliquotasReforma.fCriar(fStrToFloat(edtAlqCbs.Text),
                                                                         fStrToFloat(edtAlqIbs.Text),
                                                                         fStrToFloat(edtAlq_Is.Text)),
                                                True);

  edtValCbs.Text := FloatToStrF(recValores.fltCbs, ffNumber, 12, 2);
  edtValIbs.Text := FloatToStrF(recValores.fltIbs, ffNumber, 12, 2);
  edtVal_Is.Text := FloatToStrF(recValores.fltIs, ffNumber, 12, 2);
end;

function TfrmPedidoDeCompra.fValidaPerSub(
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Not blnConfDocumento) And edtPerSub.Visible Then
  Begin
    If fEmptyStr(edtPerSub.Text) Then
    Begin
      edtPerSub.Text := '0,0000';
    End
    Else If Not (InRange(fStrToFloat(edtPerSub.Text), 0, 100)) And
                (blnBuscaPorChave)                             Then
    Begin
      fMensagem('ATENÇÃO!', 'O percentual da Substituição deve estar entre 0 e 100!', ['&O k']);
      Result := False;
    End;

    If Result Then
    Begin

      If RoundTo(fltVlrAlqSubOri, -4) <> RoundTo(fStrToFloat(edtPerSub.Text), -4) Then
      Begin
        edtTotSub.Text := FloatToStrF(fAplicaAliquota, ffNumber, 12, 2);
        strSubUsu := 'S';
      End;

    End;
  End;
end;

function TfrmPedidoDeCompra.fValidaTotSub(blnBuscaPorChave: Boolean = True; blnRelcalculaAliquota: Boolean = False): Boolean;
var fltTotIte : Double;
begin
  Result := True;

  If (Not blnConfDocumento) And edtTotSub.Enabled Then
  Begin
    fltTotIte := fStrToFloat(edtValTot.Text);
    If (strFrmPcm = '1') Then
      fltTotIte := fltTotIte + fStrToFloat(edtTotIpi.Text);

    If fEmptyStr(edtTotSub.Text) Then
    Begin
      edtTotSub.Text := '0,00';
    End

    Else If blnBuscaPorChave Then
    Begin

      If (fStrToFloat(edtTotSub.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O total da Substituição deve ser maior ou igual a zero!', ['&O k']);
        Result := False;
      End Else
      Begin

        If RoundTo(fStrToFloat(edtTotSub.Text), -2) = RoundTo(fltTotSubCal, -2) Then
        Begin
          strSubUsu      := 'N';
          If ParametrosCalcImpostos.blnCalcularICMSDesonerado Then
            edtIcmDes.Text := FormatFloat('#0.00', fltIcmDesCal);
        End Else
        Begin
          strSubUsu := 'S';
          edtPerSub.Text := FormatFloat('#0.0000', (fStrToFloat(edtTotSub.Text) / fltTotIte) * 100);
        End;

      End;


    End
    Else If (blnRelcalculaAliquota) Then
      edtPerSub.Text := FormatFloat('#0.0000', (fStrToFloat(edtTotSub.Text) / fltTotIte) * 100);

    If Result Then
      edtSubFCP.Text := FormatFloat(fMskDigitos(2), fStrToFloat(edtTotSub.Text) * fltPerFCPIte / 100);

  End;

end;

function TfrmPedidoDeCompra.fValidaIcmDes(blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Not blnConfDocumento) And edtIcmDes.Enabled Then
  Begin

    If fEmptyStr(edtIcmDes.Text) Then
    Begin
      edtIcmDes.Text := '0,00';
    End

    Else If blnBuscaPorChave Then
    Begin

      If (fStrToFloat(edtIcmDes.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor do ICMS desonerado deve ser maior ou igual a zero!', ['&O k']);
        Result := False;
      End Else
      Begin

        If RoundTo(fStrToFloat(edtIcmDes.Text), -2) <> RoundTo(fltIcmDesCal, -2) Then
          strSubUsu := 'S';

      End;


    End;

  End;

end;

function TfrmPedidoDeCompra.fValidaPrecoItemFornecedor: Boolean;
begin
  Result := ( (strPrF_AE = 'A') or ( (strPrF_AE <> 'A') And (recOpcGir.strCodTab <> 'ITEGER') ) );
end;

Procedure TfrmPedidoDeCompra.pIniacializaTotaisItem;
  Var
    intContador: Integer;
Begin
  With cdsItensPedido Do
  Begin
    FieldByName('ITE_ESTMAX').AsFloat   := 0;
    FieldByName('ITE_PMED_V').AsFloat   := 0;
    FieldByName('ITE_MEDIA_').AsFloat   := 0;
    FieldByName('ITE_DIASAI').AsInteger := 0;

    FieldByName('ITE_AJUSTA').AsFloat := 0;
    FieldByName('ITE_MEDIXX').AsFloat := 0;
    FieldByName('ITE_MEDAJU').AsFloat := 0;
    FieldByName('ITE_SUGEST').AsFloat := 0;
    FieldByName('ITE_ESTMIN').AsFloat := 0;
    FieldByName('ITE_SALDOS').AsFloat := 0;
    FieldByName('ITE_SALDIS').AsFloat := 0;
    FieldByName('ITE_SALEXT').AsFloat := 0;

    FieldByName('ITE_SALBAS').AsFloat := 0;
    FieldByName('ITE_SALFIS').AsFloat := 0;
    FieldByName('ITE_SALGAR').AsFloat := 0;
    FieldByName('ITE_SALRES').AsFloat := 0;
    FieldByName('ITE_SALEND').AsFloat := 0;
    FieldByName('ITE_QTDPEN').AsFloat := 0;
    FieldByName('ITE_SALREQ').AsFloat := 0;
    FieldByName('ITE_QTPD_P').AsFloat := 0;
    FieldByName('ITE_QTEF_A').AsFloat := 0;
    FieldByName('ITE_QTEF_F').AsFloat := 0;
    FieldByName('ITE_QTEF_P').AsFloat := 0;

    FieldByName('ITE_DIAEST').AsFloat := 0;
    FieldByName('ITE_DIASUG').AsFloat := 0;

    For intContador := 1 To 12 Do
    Begin
      If FindField('ITE_Q_V_' + RightStr('0' + IntToStr(intContador), 2)) <> Nil Then
        FieldByName('ITE_Q_V_' + RightStr('0' + IntToStr(intContador), 2)).AsFloat := 0;

      If FindField('ITE_Q_VP' + RightStr('0' + IntToStr(intContador), 2)) <> Nil Then
        FieldByName('ITE_Q_VP' + RightStr('0' + IntToStr(intContador), 2)).AsFloat := 0;
    End;




    FieldByName('ITE_VENMES').AsFloat := 0;
    FieldByName('ITE_Q_VPME').AsFloat := 0;

    FieldByName('ITE_NOMFOR').Clear;
    FieldByName('ITE_DIAUCO').Clear;
    FieldByName('ITE_DTAULT').Clear;
    FieldByName('ITE_PREULT').Clear;
    FieldByName('ITE_QTDUCO').Clear;
    FieldByName('ITE_IMPULT').Clear;

    FieldByName('ITE_DIAUVE').Clear;
    FieldByName('ITE_DTAUVE').Clear;

    FieldByName('ITE_MADTSA').Clear;
    FieldByName('ITE_MAQTSA').Clear;

  End;
End;

Procedure TfrmPedidoDeCompra.pIncrementaTotaisPedido;
  Var
    intContador: Integer;
Begin
  With cdsItensPedido Do
  If (Not (blnEmpVis And (Not fEmptyStr(recOpcGir.strEmpCal)))) Or
     (Pos(cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString, recOpcGir.strEmpCal) > 0) Then
  Begin
    FieldByName('ITE_SUGEST').AsFloat   := FieldByName('ITE_SUGEST').AsFloat   + cdsItensMultiLojas.FieldByName('ITE_SUGEST').AsFloat;
    FieldByName('ITE_ESTMAX').AsFloat   := FieldByName('ITE_ESTMAX').AsFloat   + cdsItensMultiLojas.FieldByName('ITE_ESTMAX').AsFloat;
    FieldByName('ITE_MEDIA_').AsFloat   := FieldByName('ITE_MEDIA_').AsFloat   + cdsItensMultiLojas.FieldByName('ITE_MEDIA_').AsFloat;

    FieldByName('ITE_DIASAI').AsInteger := FieldByName('ITE_DIASAI').AsInteger + cdsItensMultiLojas.FieldByName('ITE_DIASAI').AsInteger;

    FieldByName('ITE_AJUSTA').AsFloat := FieldByName('ITE_AJUSTA').AsFloat + cdsItensMultiLojas.FieldByName('ITE_AJUSTA').AsFloat;
    FieldByName('ITE_MEDIXX').AsFloat := FieldByName('ITE_MEDIXX').AsFloat + cdsItensMultiLojas.FieldByName('ITE_MEDIXX').AsFloat;
    FieldByName('ITE_MEDAJU').AsFloat := FieldByName('ITE_MEDAJU').AsFloat + cdsItensMultiLojas.FieldByName('ITE_MEDAJU').AsFloat;
    FieldByName('ITE_ESTMIN').AsFloat := FieldByName('ITE_ESTMIN').AsFloat + cdsItensMultiLojas.FieldByName('ITE_ESTMIN').AsFloat;
    FieldByName('ITE_SALDOS').AsFloat := FieldByName('ITE_SALDOS').AsFloat + cdsItensMultiLojas.FieldByName('ITE_SALDOS').AsFloat;
    FieldByName('ITE_SALDIS').AsFloat := FieldByName('ITE_SALDIS').AsFloat + cdsItensMultiLojas.FieldByName('ITE_SALDIS').AsFloat;
    FieldByName('ITE_SALEXT').AsFloat := FieldByName('ITE_SALEXT').AsFloat + cdsItensMultiLojas.FieldByName('ITE_SALEXT').AsFloat;

    FieldByName('ITE_SALBAS').AsFloat := FieldByName('ITE_SALBAS').AsFloat + cdsItensMultiLojas.FieldByName('ITE_SALBAS').AsFloat;
    FieldByName('ITE_SALFIS').AsFloat := FieldByName('ITE_SALFIS').AsFloat + cdsItensMultiLojas.FieldByName('ITE_SALFIS').AsFloat;
    FieldByName('ITE_SALGAR').AsFloat := FieldByName('ITE_SALGAR').AsFloat + cdsItensMultiLojas.FieldByName('ITE_SALGAR').AsFloat;
    FieldByName('ITE_SALRES').AsFloat := FieldByName('ITE_SALRES').AsFloat + cdsItensMultiLojas.FieldByName('ITE_SALRES').AsFloat;
    FieldByName('ITE_SALEND').AsFloat := FieldByName('ITE_SALEND').AsFloat + cdsItensMultiLojas.FieldByName('ITE_SALEND').AsFloat;
    FieldByName('ITE_QTDPEN').AsFloat := FieldByName('ITE_QTDPEN').AsFloat + cdsItensMultiLojas.FieldByName('ITE_QTDPEN').AsFloat;
    FieldByName('ITE_SALREQ').AsFloat := FieldByName('ITE_SALREQ').AsFloat + cdsItensMultiLojas.FieldByName('ITE_QTDREQ').AsFloat;
    FieldByName('ITE_QTPD_P').AsFloat := FieldByName('ITE_QTPD_P').AsFloat + cdsItensMultiLojas.FieldByName('ITE_QTPD_P').AsFloat;
    FieldByName('ITE_QTEF_A').AsFloat := FieldByName('ITE_QTEF_A').AsFloat + cdsItensMultiLojas.FieldByName('ITE_QTEF_A').AsFloat;
    FieldByName('ITE_QTEF_F').AsFloat := FieldByName('ITE_QTEF_F').AsFloat + cdsItensMultiLojas.FieldByName('ITE_QTEF_F').AsFloat;
    FieldByName('ITE_QTEF_P').AsFloat := FieldByName('ITE_QTEF_P').AsFloat + cdsItensMultiLojas.FieldByName('ITE_QTEF_P').AsFloat;

    For intContador := 1 To 12 Do
    Begin
      If FindField('ITE_Q_V_' + RightStr('0' + IntToStr(intContador), 2)) <> Nil Then
        FieldByName('ITE_Q_V_' + RightStr('0' + IntToStr(intContador), 2)).AsFloat :=
            FieldByName('ITE_Q_V_' + RightStr('0' + IntToStr(intContador), 2)).AsFloat +
              cdsItensMultiLojas.FieldByName('ITE_Q_V_' + RightStr('0' + IntToStr(intContador), 2)).AsFloat;

      If FindField('ITE_Q_VP' + RightStr('0' + IntToStr(intContador), 2)) <> Nil Then
        FieldByName('ITE_Q_VP' + RightStr('0' + IntToStr(intContador), 2)).AsFloat :=
            FieldByName('ITE_Q_VP' + RightStr('0' + IntToStr(intContador), 2)).AsFloat +
              cdsItensMultiLojas.FieldByName('ITE_Q_VP' + RightStr('0' + IntToStr(intContador), 2)).AsFloat;

    End;

    FieldByName('ITE_VENMES').AsFloat := FieldByName('ITE_VENMES').AsFloat + cdsItensMultiLojas.FieldByName('ITE_VENMES').AsFloat;

    FieldByName('ITE_Q_VPME').AsFloat := FieldByName('ITE_Q_VPME').AsFloat + cdsItensMultiLojas.FieldByName('ITE_Q_VPME').AsFloat;

    If FieldByName('ITE_DTAULT').IsNull Or (cdsItensMultiLojas.FieldByName('ITE_DTAULT').Value > FieldByName('ITE_DTAULT').Value) Then
    Begin
      FieldByName('ITE_NOMFOR').Value := FieldByName('ITE_NOMFOR').Value;
      FieldByName('ITE_DIAUCO').Value := FieldByName('ITE_DIAUCO').Value;
      FieldByName('ITE_DTAULT').Value := FieldByName('ITE_DTAULT').Value;
      FieldByName('ITE_PREULT').Value := FieldByName('ITE_PREULT').Value;
      FieldByName('ITE_IMPULT').Value := FieldByName('ITE_IMPULT').Value;
      FieldByName('ITE_QTDUCO').Value := FieldByName('ITE_QTDUCO').Value;
    End;

    If FieldByName('ITE_DTAUVE').IsNull Or (cdsItensMultiLojas.FieldByName('ITE_DTAUVE').Value > FieldByName('ITE_DTAUVE').Value) Then
    Begin
      FieldByName('ITE_DIAUVE').Value := cdsItensMultiLojas.FieldByName('ITE_DIAUVE').Value;
      FieldByName('ITE_DTAUVE').Value := cdsItensMultiLojas.FieldByName('ITE_DTAUVE').Value;
    End;

    If FieldByName('ITE_MADTSA').IsNull Or (cdsItensMultiLojas.FieldByName('ITE_MADTSA').Value > FieldByName('ITE_MADTSA').Value) Then
    Begin
      FieldByName('ITE_MADTSA').Value := cdsItensMultiLojas.FieldByName('ITE_MADTSA').Value;
      FieldByName('ITE_MAQTSA').Value := cdsItensMultiLojas.FieldByName('ITE_MAQTSA').Value;
    End;

    If IIF(recOpcGir.blnMedAju, FieldByName('ITE_AJUSTA').AsFloat, FieldByName('ITE_MEDIA_').AsFloat) > 0 Then
    Begin
      FieldByName('ITE_DIAEST').AsInteger := Trunc(RoundTo(FieldByName('ITE_SALBAS').AsFloat /
                                                   (IIF(recOpcGir.blnMedAju, FieldByName('ITE_AJUSTA').AsFloat, FieldByName('ITE_MEDIA_').AsFloat) / 30), -4));

      FieldByName('ITE_DIASUG').AsInteger := Trunc(RoundTo((FieldByName('ITE_SALBAS').AsFloat +
                                                  (FieldByName('ITE_QTDITE').AsFloat * FieldByName('ITE_QTDEMB').AsFloat)+
                                                  FieldByName('ITE_QTDTRA').AsFloat) /
                                                    (IIF(recOpcGir.blnMedAju, FieldByName('ITE_AJUSTA').AsFloat, FieldByName('ITE_MEDIA_').AsFloat) / 30), -4));
    End Else
    Begin
      FieldByName('ITE_DIAEST').AsFloat := 0;
      FieldByName('ITE_DIASUG').AsFloat := 0;
    End;

  End;
End;

Function TfrmPedidoDeCompra.fAdicionaItem(blnProcessoNormal, blnAferScroll: Boolean): Boolean;
  Var
    blnItemCadastrado,
    blnESMILJ: Boolean;
    fltQtdMlj: Double;
    qryGenIte: TUniQuery;
    qryGenIteESMIDG: TUniQuery;
    fltTotSubAtu,
    fltTotDarAtu: Double;
    fltFatorDar,
    fltFatorST: Double;
    fltQtdIte: Double;
    fltFatBasIcm,
    fltFatValIcm,
    fltFatDesPis,
    fltFatBasSub,
    fltBasIcm,
    fltAlqIcm,
    fltValIcm,
    fltBaseST,
    fltDesPis,
    fltPerFCP,
    fltSubFCP,
    fltTotDar: Double;

    strCodSit,
    strCodSitOrigem: String;
    intRecNo,
    intContador: Integer;
    pSaveBeforePost: TprcScroll;
    strAutPcd,
    strEmpSaldos,
    strEmpDes,
    strFilterBkp,
    strQtdIteBkp: String;
    strCdsFilterBkp: String;
    blnCdsFilteredBkp: Boolean;

    fltValIPI,
    fltAlqIPI,
    fltBasIPI,
    fltRepFre,
    fltVlrAliquotaSub: Double;
begin
  Result := False;

  strEmpDes := fRetEmpresaDestino;
  strFilterBkp := '';

  {Garante edtDesIte/qryConIte sincronizados com edtCodIte mesmo se Confirma for acionado por atalho (Alt+C).
   Verificar Nota 3 - Req. 456447}
  If (Not qryConIte.Active) Or qryConIte.IsEmpty Or (qryConIte.FieldByName('ITE_CODITE').AsString <> edtCodIte.Text) Then
  Begin
    strQtdIteBkp := edtQtdIte.Text;
    Try
      pCarregaItem;
    Finally
      edtQtdIte.Text := strQtdIteBkp;
    End;
  End;

  If fStrToFloat(edtEmbala.Text) = 0 Then
    edtEmbala.Text := '1';

  blnESMILJ := (Not fCfgSis('ESMILJ', varBoolean)); // N -> Iteger / S -> Cadite

  {**********************************}
  {* PEGA DADOS DOS ITEM            *}
  {*******************************JB*}
  qryGenIte := fCriaQuery;
  qryGenIteESMIDG := fCriaQuery;

  With qryGenIte Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT SQL_NO_CACHE    ');
    SQL.Add('  C.ITE_CODITE,   ');
    SQL.Add('  IF(IFNULL(F.ITE_CLAIPI, "") = "", C.ITE_CLAIPI, F.ITE_CLAIPI) AS ITE_CLAIPI, ');
    SQL.Add('  ITE_PRAVAL, ');
    SQL.Add('  ITE_CODGRU,          ');
    SQL.Add('  ITE_CODMAR,          ');
    SQL.Add('  C.ITE_CODBAR,          ');
    SQL.Add('  C.ITE_REFERE,          ');
    SQL.Add('  ITE_CODSIM,          ');

    SQL.Add('  F.ITE_CODTAB, ');

    SQL.Add(' IF(F.ITE_CODITE IS NULL, IF(IFNULL(C.ITE_MLTCOM, 0) <> 0, C.ITE_MLTCOM, 1), ');
    SQL.Add('                          IF(IFNULL(F.ITE_MLTCOM, 0) <> 0, F.ITE_MLTCOM, IFNULL(C.ITE_MLTCOM, 1))) AS ITE_MLTCOM, ');

    If blnPermitirCompradorEscolherCodigoFabrica Then
    Begin
      If (fRetornaCodigoFabricaProduto = 'P') Then
        SQL.Add(fRetornaSQLCodigoFabricaProduto('C'))
      Else
        SQL.Add(fRetornaSQLCodigoFabricaProduto('F'));
    End
    Else
    Begin
      If fCfgSis('CODFIT', varBoolean) Then
      Begin
        SQL.Add('  C.ITE_CODFAB AS ITE_CODFAB, ');
      End
      Else
      Begin
        If fCfgSis('TABPRF', varBoolean) Then
          SQL.Add('    IF(IFNULL(F.ITE_CODFAB,"") = "", C.ITE_CODFAB, F.ITE_CODFAB) AS ITE_CODFAB, ')
        Else
          SQL.Add('    IF(IFNULL(F.ITE_CODITF,"") = "", C.ITE_CODFAB, F.ITE_CODITF) AS ITE_CODFAB, ');
      End;
    End;

    SQL.Add('  IF(F.ITE_CODITE IS NULL, C.ITE_UNICOM, F.ITE_UNICOM) AS ITE_UNICOM, ');
    SQL.Add('  IF(F.ITE_CODITE IS NULL, IFNULL((SELECT BAR_EMBALA FROM ITEBAR WHERE BAR_CODITE = :CODITE AND BAR_CODFOR = :CODFOR ORDER BY BAR_COMPRA DESC LIMIT 1), C.ITE_EMBALA), IF(F.ITE_CNVCUS IS NULL OR F.ITE_CNVCUS = 0, 1, F.ITE_CNVCUS)) AS ITE_EMBALA,');

    If (rdgDesPdi.Visible) And (rdgDesPdi.ItemIndex = 1) Then
      SQL.Add(' IF(IFNULL(C.ITE_DESFAB, "") = "", C.ITE_DESITE, C.ITE_DESFAB) AS ITE_DESITE, ')
    Else
    SQL.Add('  IF((F.ITE_CODITE IS NULL) OR IFNULL(F.ITE_DESFAB, "") = "", C.ITE_DESITE, F.ITE_DESFAB) AS ITE_DESITE,             ');

    If fCfgSis('MENAPL', varBoolean) Then
      SQL.Add(' CONCAT(IFNULL(ITE_APLICA,""), ' + 'CASE WHEN IFNULL(ITE_APLICA,"") = "" THEN "" ELSE ' + QuotedStr('\r\n') + ' END ' + ', IFNULL(ITE_MSGLV1,""), ' + QuotedStr('\r\n') + ', IFNULL(ITE_MSGLV2,"")) AS ITE_APLICA, ')
    Else
      SQL.Add(' ITE_APLICA,          ');


    SQL.Add('  ITE_PRAVAL,          ');
    SQL.Add('  C.ITE_DIAFOR,          ');
    SQL.Add('  C.ITE_PESOIT,          ');
    SQL.Add('  ITE_LOCFIS,          ');
    SQL.Add('  ITE_INCPIS,          ');
    SQL.Add('  ITE_ESTMIN,          ');
    SQL.Add('  ITE_ESTMAX,          ');
    SQL.Add('  ITE_PMED_V,          ');


    SQL.Add('  I.ITE_ESMIDG,        ');


    SQL.Add('  ITE_MINDIG,          ');
    SQL.Add('  ITE_MAXDIG,          ');

    SQL.Add('  ITE_PONPED,          ');
    SQL.Add('  ITE_SALDOS,          ');

    SQL.Add('  FP.FOR_NOMFOR,        ');
    SQL.Add('  D.DEP_DESCRI,        ');


    If blnAnalisaITEFOR Then
      SQL.Add('  IF(C.ITE_CODFOR = "' + recOpcGir.strCodFor +'", "*", "") AS ITE_PRINCI, ')
    Else
      SQL.Add('   " " AS ITE_PRINCI, ');

    SQL.Add('  ITE_CICMDE, ');
    SQL.Add('  ITE_CDPIOP, ');
    SQL.Add('  ITE_DIDIOP, ');
    SQL.Add('  ITE_NIVCRI, ');
    If recOpcGir.recNivEst.nivEstoque = nivGiroFornecedor then
      SQL.Add('  ITE_NVLFOR AS ITE_NVLGIR,       ')
    Else If fCfgSis('TIPGIR') = 'S' Then
      SQL.Add('  I.ITE_NIVGIR AS ITE_NVLGIR, ')
    Else
      SQL.Add('  C.ITE_NVLGIR, ');

    SQL.Add('  ITE_QTDUVE,          ');
    SQL.Add('  ITE_DTAUVE,          ');

    SQL.Add('  CONCAT(COALESCE(GRU_DRELIN, ''''), '' - '', COALESCE(GRU_DESGRU, '''')) AS ITE_DESGRU,');
    SQL.Add('  ITE_DESSIM,          ');

    If fCfgSis('TIPABF') = '1' Then
      SQL.Add('  C.ITE_CODABF ')
    Else
      SQL.Add('  I.ITE_CODABF ');

    If blnSitPro And blnCorIpd Then
    Begin
      SQL.Add(', SIT_CODIGO, ');
      SQL.Add('  SIT_CORSIT, ');
      SQL.Add('  SIT_DESCRI  ');
    End;

    SQL.Add(', I.ITE_PONEXP ');
    SQL.Add(', I.ITE_PREULT ');
    SQL.Add(', ITE_TIPABS ');
    SQL.Add(', ITE_VNOLCD ');

    SQL.Add('FROM                   ');
    SQL.Add('  CADITE  C            ');
    SQL.Add('  JOIN ITEGER I ON C.ITE_CODITE = I.ITE_CODITE AND ');
    SQL.Add('                   I.ITE_CODEMP = :CODEMP ');
    SQL.Add('  LEFT JOIN CADFOR FP ON C.ITE_CODFOR = FP.FOR_CODFOR ');
    SQL.Add('  LEFT JOIN CADDEP D ON DEP_CODIGO = ITE_CODDEP ');
    SQL.Add('  LEFT JOIN CADGRU ON GRU_CODGRU = ITE_CODGRU     ');

    If fCfgSis('TABPRF', varBoolean) Then
    Begin
      SQL.Add('  LEFT JOIN (SELECT * FROM ITEFOR F WHERE F.ITE_CODFAB IS NOT NULL ');
      SQL.Add('                  AND (SELECT COUNT(*) FROM TABPRE                 ');
      SQL.Add('                        WHERE F.ITE_CODTAB = TAB_CODTAB AND' + fSqlWhereTabPre(strPrF_AE, recOpcGir.strCodTab) + ') > 0');
      SQL.Add('   GROUP BY F.ITE_CODFAB) F ON F.ITE_CODITE = C.ITE_CODITE         ');
      SQL.Add('                           AND F.ITE_CODFOR = :CODFOR              ');
    End Else
    Begin
      SQL.Add('  LEFT JOIN ITEFOR F ON F.ITE_CODITE = C.ITE_CODITE ');
      SQL.Add('                    AND F.ITE_CODFOR = :CODFOR ');
      SQL.Add('                  AND F.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF     ');
      SQL.Add('                       WHERE FF.ITE_CODITE = C.ITE_CODITE AND ');
      SQL.Add('                             FF.ITE_CODFOR = :CODFOR)   ');
    End;

    If blnSitPro And blnCorIpd Then
    Begin
      If fCfgSis('SITEMP') = '1' Then
        SQL.Add(' LEFT JOIN SITPRO ON C.ITE_SITPRO = SIT_CODIGO ')
      Else
        SQL.Add(' LEFT JOIN SITPRO ON I.ITE_SITPRO = SIT_CODIGO ');
    End;

    SQL.Add('WHERE                  ');
    SQL.Add('  C.ITE_CODITE = :CODITE AND ');
    SQL.Add('  I.ITE_CODEMP = :CODEMP ');

    ParamByName('CODITE').Value := edtCodIte.Text;
    ParamByName('CODEMP').Value := strEmpDes;
    ParamByName('CODFOR').Value := edtCodFor.Text;
    Open;

    strIncPisIte := qryGenIte.FieldByName('ITE_INCPIS').AsString;
  End;

  qryGenIteESMIDG.SQL.Clear;
  qryGenIteESMIDG.SQL.Add(fSqlIteESMIDG);
  qryGenIteESMIDG.ParamByName('CODITE').AsString := edtCodIte.Text;
  qryGenIteESMIDG.Open;

  blnInseriu := False;
  fltTotSubAtu := 0.0;
  fltTotDarAtu := 0.0;
  cdsItensPedido.AfterScroll := Nil;
  {Backup de Filter/Filtered feito aqui (so leitura) porque o Finally externo le blnCdsFilteredBkp em todo
   caminho de saida; Filtered so e desligado mais abaixo, junto de fItemCadastrado.
   Verificar Nota 4 - Req. 456447}
  strCdsFilterBkp   := cdsItensPedido.Filter;
  blnCdsFilteredBkp := cdsItensPedido.Filtered;
  cdsItensPedido.DisableControls;
  Try
    Try
      {*****************************************}
      {* REVALIDA OS CAMPOS                    *}
      {**************************************MV*}
      If Not fVerificaCampos Then
      Begin
        {Reabilita temporariamente para pAferScroll atualizar o rodape (senao e no-op pelo DisableControls
         externo). Verificar Nota 5 - Req. 456447}
        cdsItensPedido.EnableControls;
        Try
          pAferScroll(cdsItensPedido);
        Finally
          cdsItensPedido.DisableControls;
        End;
        FreeAndNil(qryGenIte);
        FreeAndNil(qryGenIteESMIDG);
        blnMudarFoco := False;
        blnConfDocumento := False;
        Exit;
      End;

      pCalculaTotalItem(True);

      blnConfDocumento := False;

      If Not fProdutoCadastrado(edtCodIte.Text) Then
      Begin
        {Reabilita temporariamente para pAferScroll atualizar o rodape (senao e no-op pelo DisableControls
         externo). Verificar Nota 5 - Req. 456447}
        cdsItensPedido.EnableControls;
        Try
          pAferScroll(cdsItensPedido);
        Finally
          cdsItensPedido.DisableControls;
        End;
        FreeAndNil(qryGenIte);
        FreeAndNil(qryGenIteESMIDG);
        pSetFocus(edtCodIte);
        blnMudarFoco := False;
        Exit;
      End;

      {Suspende Filtered da checagem de duplicidade (fItemCadastrado) ate o Post, evitando perder o registro
       do Locate se o filtro for reativado no meio do caminho. So desliga aqui, nao antes, para nao mover o
       cursor antes da hora (bug corrigido no Req. 454314). Verificar Nota 6 - Req. 456447}
      cdsItensPedido.Filtered := False;

      blnItemCadastrado := fItemCadastrado;

      If (blnItemCadastrado) Or (blnAlterando) Then
      Begin
        cdsItensPedido.Edit;
      End
      Else
      Begin
        cdsItensPedido.Append;
        cdsItensPedido.FieldByName('ITE_INCIRQ').AsString := '';
        cdsItensPedido.FieldByName('ITE_QTDREQ').AsFloat  := 0;
        cdsItensPedido.FieldByName('ITE_QATREQ').AsFloat  := 0;
        cdsItensPedido.FieldByName('ITE_QTDTRA').AsFloat  := 0;
        cdsItensPedido.FieldByName('ITE_QTDINC').AsFloat  := 0;
        cdsItensPedido.FieldByName('ITE_TRAINC').AsFloat  := 0;

        strCodCST := fRetornaCSTFornecedor(edtCodFor.Text, edtCodIte.Text, strCstOrigem);

        cdsItensPedido.FieldByName('ITE_CODSIT').AsString := strCodCst;
        cdsItensPedido.FieldByName('ITE_SITORI').AsString := strCstOrigem;
      End;

      cdsItensPedido.FieldByName('ITE_SUBUSU').AsString := strSubUsu;

      cdsItensPedido.FieldByName('ITE_FORPRI').AsString := qryGenIte.FieldByName('FOR_NOMFOR').AsString;
      cdsItensPedido.FieldByName('ITE_DEPART').AsString := qryGenIte.FieldByName('DEP_DESCRI').AsString;

      cdsItensPedido.FieldByName('ITE_DIAFOR').AsInteger  := qryGenIte.FieldByName('ITE_DIAFOR').AsInteger;

      If blnOriIte Then
        cdsItensPedido.FieldByName('ITE_DTAENT').AsDateTime := StrToDateDef(mskDtaEnt.Text, StrToDateDef(mskDtaFat.Text, VS_Date) +
                                                                  qryGenIte.FieldByName('ITE_DIAFOR').AsInteger)
      Else
        cdsItensPedido.FieldByName('ITE_DTAENT').AsDateTime := StrToDateDef(mskDtaEnt.Text, StrToDateDef(mskDtaFat.Text, VS_Date) +  fGetDiaFor);

      If fCfgSis('ENTITE', varBoolean) Then
      Begin
        If (cdsItensPedido.State = DsEdit) And
           (cdsItensPedido.FieldByName('ITE_DTAENT').OldValue <> cdsItensPedido.FieldByName('ITE_DTAENT').NewValue) Then
        Begin
          If Not(cdsItensPedido.FieldByName('ITE_DTAENT').IsNull) And (cdsItensPedido.FieldByName('ITE_DTAENT').OldValue <> Null) Then
            cdsItensPedido.FieldByName('ITE_DTAEDT').AsDateTime:= cdsItensPedido.FieldByName('ITE_DTAENT').OldValue;
        End;

      End;

      {**********************************************}
      {* VERIFICA SE O ITEM QUE ESTA SENDO INSERIDO *}
      {* ESTA EM ABERTO EM OUTRO PEDIDO.            *}
      {*******************************************AC*}
      If blnExibirPedidoPendente And (((Not blnItemCadastrado) Or (blnUsarGiro)) And (blnProcessoNormal)) Then
        pMostraProdutosPendentes(False, edtCodIte.Text, edtDesIte.Text);

      If (Not blnItemCadastrado) And (Not blnAlterando) Then
      Begin
        cdsItensPedido.FieldByName('ITE_CODMAR').AsString := qryGenIte.FieldByName('ITE_CODMAR').AsString;
        cdsItensPedido.FieldByName('ITE_DESMAR').AsString := fRetNomMarca(qryGenIte.FieldByName('ITE_CODMAR').AsString);

        cdsItensPedido.FieldByName('ITE_EMBALA').AsFloat  := qryGenIte.FieldByName('ITE_EMBALA').AsFloat;
        cdsItensPedido.FieldByName('ITE_CODGRU').AsString := qryGenIte.FieldByName('ITE_CODGRU').AsString;
        cdsItensPedido.FieldByName('ITE_CONPAG').AsString := fTiraCaracEspeciais(mskCndPag.Text);
        cdsItensPedido.FieldByName('ITE_CODITE').AsString := qryGenIte.FieldByName('ITE_CODITE').AsString;
        cdsItensPedido.FieldByName('ITE_CODTAB').AsString := qryGenIte.FieldByName('ITE_CODTAB').AsString;
        cdsItensPedido.FieldByName('ITE_ITEESP').AsString := IIF(Pos('ITEM ESPECIAL', qryGenIte.FieldByName('ITE_DESITE').AsString) > 0, 'S', 'N');
        cdsItensPedido.FieldByName('AUTOINCREM').AsString := fRetProximoAutIncTmp;
        cdsItensPedido.FieldByName('ITE_UNIORI').AsFloat  := fStrToFloat(strUniOri);
        cdsItensPedido.FieldByName('ITE_MLTCOM').AsFloat  := qryGenIte.FieldByName('ITE_MLTCOM').AsFloat;

        cdsItensPedido.FieldByName('ITE_CODSIM').AsString := qryGenIte.FieldByName('ITE_CODSIM').AsString;


        If fEmptyStr(recOpcGir.strEmpGir)  Then
        Begin
          cdsItensPedido.FieldByName('ITE_SALDOS').AsFloat  := qryGenIte.FieldByName('ITE_SALDOS').AsFloat;

          strEmpSaldos := QuotedStr(strEmpDes);
        End Else
        Begin
          cdsItensPedido.FieldByName('ITE_SALDOS').AsFloat  := fRetornaSaldoItem(qryGenIte.FieldByName('ITE_CODITE').AsString,
                                                                     IIF(recOpcGir.blnAgrSim, cdsItensPedido.FieldByName('ITE_CODSIM').AsString, ''),
                                                                     recOpcGir.strEmpGir);

          strEmpSaldos := recOpcGir.strEmpGir;
        End;

        pGetSaldosReservados(cdsSaldos, qryGenIte.FieldByName('ITE_CODITE').AsString, strEmpSaldos,
                             (blnUsarGiro Or blnAltPedGir Or (Assigned(recOpcGir.objSalInt) And recOpcGir.objSalInt.blnEncontrouGiro)),
                             recOpcGir);


        cdsItensPedido.FieldByName('ITE_PRINCI').AsString := qryGenIte.FieldByName('ITE_PRINCI').AsString;

        cdsItensPedido.FieldByName('ITE_CICMDE').AsString := qryGenIte.FieldByName('ITE_CICMDE').AsString;
        cdsItensPedido.FieldByName('ITE_CDPIOP').AsString := qryGenIte.FieldByName('ITE_CDPIOP').AsString;
        cdsItensPedido.FieldByName('ITE_DIDIOP').AsString := qryGenIte.FieldByName('ITE_DIDIOP').AsString;


        cdsItensPedido.FieldByName('ITE_ESTMIN').AsFloat  := cdsSaldos.FieldByName('ITE_ESTMIN').AsFloat;
        cdsItensPedido.FieldByName('ITE_ESTMAX').AsFloat  := cdsSaldos.FieldByName('ITE_ESTMAX').AsFloat;
        cdsItensPedido.FieldByName('ITE_MINDIG').AsFloat  := cdsSaldos.FieldByName('ITE_MINDIG').AsFloat;
        cdsItensPedido.FieldByName('ITE_MAXDIG').AsFloat  := cdsSaldos.FieldByName('ITE_MAXDIG').AsFloat;
        cdsItensPedido.FieldByName('ITE_QTPD_P').AsFloat  := cdsSaldos.FieldByName('ITE_QTPD_P').AsFloat;
        cdsItensPedido.FieldByName('ITE_QTEF_A').AsFloat  := cdsSaldos.FieldByName('ITE_QTEF_A').AsFloat;
        cdsItensPedido.FieldByName('ITE_QTEF_F').AsFloat  := cdsSaldos.FieldByName('ITE_QTEF_F').AsFloat;
        cdsItensPedido.FieldByName('ITE_QTEF_P').AsFloat  := cdsSaldos.FieldByName('ITE_QTEF_P').AsFloat;
        cdsItensPedido.FieldByName('ITE_SALRES').AsFloat  := cdsSaldos.FieldByName('ITE_SALRES').AsFloat;
        cdsItensPedido.FieldByName('ITE_SALEND').AsFloat  := cdsSaldos.FieldByName('ITE_SALEND').AsFloat;
        cdsItensPedido.FieldByName('ITE_SALTRA').AsFloat  := cdsSaldos.FieldByName('ITE_SALTRA').AsFloat;
        cdsItensPedido.FieldByName('ITE_SALGAR').AsFloat  := cdsSaldos.FieldByName('ITE_SALGAR').AsFloat;
        cdsItensPedido.FieldByName('ITE_SALDIS').AsFloat  := cdsSaldos.FieldByName('ITE_SALDIS').AsFloat;
        cdsItensPedido.FieldByName('ITE_SALEXT').AsFloat  := cdsSaldos.FieldByName('ITE_SALEXT').AsFloat;
        cdsItensPedido.FieldByName('ITE_SALBAS').AsFloat  := cdsSaldos.FieldByName('ITE_SALBAS').AsFloat;
        cdsItensPedido.FieldByName('ITE_SALFIS').AsFloat  := cdsSaldos.FieldByName('ITE_SALFIS').AsFloat;
        cdsItensPedido.FieldByName('ITE_SALCOT').AsFloat  := cdsSaldos.FieldByName('ITE_SALCOT').AsFloat;
        cdsItensPedido.FieldByName('ITE_VENPER').AsFloat  := cdsSaldos.FieldByName('ITE_VENPER').AsFloat;
        cdsItensPedido.FieldByName('ITE_QTDPEN').AsFloat  := cdsSaldos.FieldByName('ITE_QTDPEN').AsFloat;
        cdsItensPedido.FieldByName('ITE_SALREQ').AsFloat  := cdsSaldos.FieldByName('ITE_SALREQ').AsFloat;

        cdsItensPedido.FieldByName('ITE_PMED_V').AsFloat  := qryGenIte.FieldByName('ITE_PMED_V').AsFloat;

        cdsItensPedido.FieldByName('ITE_PONPED').AsFloat  := qryGenIte.FieldByName('ITE_PONPED').AsFloat;

        cdsItensPedido.FieldByName('ITE_QTDUVE').Value    := qryGenIte.FieldByName('ITE_QTDUVE').Value;
        cdsItensPedido.FieldByName('ITE_DTAUVE').Value    := qryGenIte.FieldByName('ITE_DTAUVE').Value;

        If (Not cdsItensPedido.FieldByName('ITE_DTAUVE').IsNull) And (cdsItensPedido.FieldByName('ITE_DTAUVE').AsDateTime > 0) Then
          cdsItensPedido.FieldByName('ITE_DIAUVE').AsInteger  := Trunc(VS_Date - cdsItensPedido.FieldByName('ITE_DTAUVE').AsDateTime);

        If (recOpcGir.strPedMlj <> 'S') And {(Not blnUsarGiro) And (Not blnAltPedGir)} (cdsItensPedido.State = dsInsert) Then
          pCarrregaDadosGiro(cdsItensPedido, strEmpSaldos, IIF(recOpcGir.blnAgrSim, qryGenIte.FieldByName('ITE_CODSIM').AsString, ''));

        cdsItensPedido.FieldByName('ITE_NVLCRI').AsString := qryGenIte.FieldByName('ITE_NIVCRI').AsString;
        cdsItensPedido.FieldByName('ITE_NVLGIR').AsString := qryGenIte.FieldByName('ITE_NVLGIR').AsString;
      End
      Else
        cdsItensPedido.FieldByName('AUTOINCREM').AsString := strAutoIncrem;

      If blnSitPro And blnCorIpd Then
      Begin
        cdsItensPedido.FieldByName('ITE_DESSIT').AsString := qryGenIte.FieldByName('SIT_DESCRI').AsString;
        cdsItensPedido.FieldByName('ITE_CORSIT').AsString := qryGenIte.FieldByName('SIT_CORSIT').AsString;
      End;

      cdsItensPedido.FieldByName('ITE_CODBAR').AsString := qryGenIte.FieldByName('ITE_CODBAR').AsString;
      cdsItensPedido.FieldByName('ITE_CODUNI').AsString := edtCodUni.Text;
      cdsItensPedido.FieldByName('ITE_SIGUNI').AsString := fRetSiglaUnidade(edtCodUni.Text);
      cdsItensPedido.FieldByName('ITE_CLAIPI').AsString := qryGenIte.FieldByName('ITE_CLAIPI').AsString;
      cdsItensPedido.FieldByName('ITE_PRAVAL').AsString := qryGenIte.FieldByName('ITE_PRAVAL').AsString;
      cdsItensPedido.FieldByName('ITE_LOCFIS').AsString := qryGenIte.FieldByName('ITE_LOCFIS').AsString;
      cdsItensPedido.FieldByName('ITE_INCPIS').AsString := qryGenIte.FieldByName('ITE_INCPIS').AsString;
      cdsItensPedido.FieldByName('ITE_ESMIDG').AsString := qryGenIte.FieldByName('ITE_ESMIDG').AsString;
      cdsItensPedido.FieldByName('ITE_CODMAR').AsString := qryGenIte.FieldByName('ITE_CODMAR').AsString;
      cdsItensPedido.FieldByName('ITE_CODFAB').AsString := qryGenIte.FieldByName('ITE_CODFAB').AsString;
      cdsItensPedido.FieldByName('ITE_REFERE').AsString := qryGenIte.FieldByName('ITE_REFERE').AsString;
      cdsItensPedido.FieldByName('ITE_DESITE').AsString := edtDesIte.Text;
      cdsItensPedido.FieldByName('ITE_APLICA').AsString := qryGenIte.FieldByName('ITE_APLICA').AsString;
      cdsItensPedido.FieldByName('ITE_DIAFOR').AsInteger:= qryGenIte.FieldByName('ITE_DIAFOR').AsInteger;
      cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat  := fStrToFloat(edtQtdIte.Text);
      cdsItensPedido.FieldByName('ITE_QTDEMB').AsFloat  := fStrToFloat(edtEmbala.Text);
      cdsItensPedido.FieldByName('ITE_UNITAR').AsFloat  := fStrToFloat(edtUnitar.Text);
      If objCopiaSeg.recPcmger.blnSomaDescontoAdcionalFornecedor1 Then
        cdsItensPedido.FieldByName('ITE_DESUNI').AsFloat  := fStrToFloat(edtDesUni.Text) - fStrToFloat(edtDesAdi.Text)
      Else
        cdsItensPedido.FieldByName('ITE_DESUNI').AsFloat  := fStrToFloat(edtDesUni.Text);
      cdsItensPedido.FieldByName('ITE_DESUN2').AsFloat  := fStrToFloat(edtDesUn2.Text);
      cdsItensPedido.FieldByName('ITE_DESUN3').AsFloat  := fStrToFloat(edtDesUn3.Text);
      cdsItensPedido.FieldByName('ITE_DESUN4').AsFloat  := fStrToFloat(edtDesUn4.Text);
      cdsItensPedido.FieldByName('ITE_DESUN5').AsFloat  := fStrToFloat(edtDesUn5.Text);
      cdsItensPedido.FieldByName('ITE_DESUN6').AsFloat  := fStrToFloat(edtDesUn6.Text);
      cdsItensPedido.FieldByName('ITE_UNILIQ').AsFloat  := fStrToFloat(edtUniLiq.Text);
      cdsItensPedido.FieldByName('ITE_DIFPRE').AsFloat  := Iif(qryGenIte.FieldByName('ITE_PREULT').AsFloat = 0, 0,(((cdsItensPedido.FieldByName('ITE_UNITAR').AsFloat - qryGenIte.FieldByName('ITE_PREULT').AsFloat) / qryGenIte.FieldByName('ITE_PREULT').AsFloat) * 100));

      cdsItensPedido.FieldByName('ITE_PONEXP').AsFloat  := qryGenIte.FieldByName('ITE_PONEXP').AsFloat;

      If btnInfPedidoDeVendas.Visible Then
      Begin
        cdsItensPedido.FieldByName('ITE_EMPPED').Value    := VS_StrCodEmp;
        cdsItensPedido.FieldByName('ITE_ESPPVE').Value    := 'PD';
      End;

      If (recOpcGir.strPedMlj = 'S') Or (Not blnProcessoNormal) Then
        edtValTot.Text := FloatToStrF(fStrToFloat(edtQtdIte.Text) *
                  RoundTo(fStrToFloat(edtUnitar.Text) *
                          (   (1 - fStrToFloat(edtDesUni.Text) / 100)
                            * (1 - fStrToFloat(edtDesUn2.Text) / 100)
                            * (1 - fStrToFloat(edtDesUn3.Text) / 100)
                            * (1 - fStrToFloat(edtDesUn4.Text) / 100)
                            * (1 - fStrToFloat(edtDesUn5.Text) / 100)
                            * (1 - fStrToFloat(edtDesUn6.Text) / 100)), -intDecUni), ffFixed, 12, 2);

      // PARA NAO ESTRAGAR O ARREDONDAMENTO, QUANDO DIGITA COM MAIS DECIMAIS QUE O CADASTRADO PARA AS QTDADE CASAS DECIMAIS
      cdsItensPedido.FieldByName('ITE_TOTITE').AsFloat  := fStrToFloat(edtValTot.Text);


      If chkPedImp.Checked Then
      Begin
        cdsItensPedido.FieldByName('ITE_ALQIMP').AsFloat  := fStrToFloat(edtPerImp.Text);
        cdsItensPedido.FieldByName('ITE_VALIMP').AsFloat  := fStrToFloat(edtTotImp.Text);

        cdsItensPedido.FieldByName('ITE_BASPIS').AsFloat  := cdsItensPedido.FieldByName('ITE_TOTITE').AsFloat;
        cdsItensPedido.FieldByName('ITE_BASCOF').AsFloat  := cdsItensPedido.FieldByName('ITE_TOTITE').AsFloat;

        cdsItensPedido.FieldByName('ITE_ALQPIS').AsFloat  := fStrToFloat(edtPerPis.Text);
        cdsItensPedido.FieldByName('ITE_ALQCOF').AsFloat  := fStrToFloat(edtPerCof.Text);
        cdsItensPedido.FieldByName('ITE_VALPIS').AsFloat  := fStrToFloat(edtTotPis.Text);
        cdsItensPedido.FieldByName('ITE_VALCOF').AsFloat  := fStrToFloat(edtTotCof.Text);

        fltBasIPI := fStrToFloat(edtValTot.Text) + fStrToFloat(edtTotImp.Text);
        fltAlqIPI := fStrToFloat(edtPerIpiImp.Text);

      End Else
      Begin
        fltAlqPis := fAliquotaPisCofinsProduto(cdsItensPedido.FieldByName('ITE_CODITE').AsString, True);
        fltAlqCof := fAliquotaPisCofinsProduto(cdsItensPedido.FieldByName('ITE_CODITE').AsString, False);
        If (cdsItensPedido.FieldByName('ITE_INCPIS').AsString = 'S') And (fltAlqPis > 0) Then
        Begin
          cdsItensPedido.FieldByName('ITE_BASPIS').AsFloat  := cdsItensPedido.FieldByName('ITE_TOTITE').AsFloat;
          cdsItensPedido.FieldByName('ITE_ALQPIS').AsFloat  := fltAlqPis;
          cdsItensPedido.FieldByName('ITE_VALPIS').AsFloat  := RoundTo((cdsItensPedido.FieldByName('ITE_TOTITE').AsFloat * fltAlqPis) /100, -2);
          cdsItensPedido.FieldByName('ITE_BASCOF').AsFloat  := cdsItensPedido.FieldByName('ITE_TOTITE').AsFloat;
          cdsItensPedido.FieldByName('ITE_ALQCOF').AsFloat  := fltAlqCof;
          cdsItensPedido.FieldByName('ITE_VALCOF').AsFloat  := RoundTo((cdsItensPedido.FieldByName('ITE_TOTITE').AsFloat * fltAlqCof) /100, -2);
        End Else
        Begin
          cdsItensPedido.FieldByName('ITE_BASPIS').AsFloat  := 0;
          cdsItensPedido.FieldByName('ITE_ALQPIS').AsFloat  := 0;
          cdsItensPedido.FieldByName('ITE_VALPIS').AsFloat  := 0;
          cdsItensPedido.FieldByName('ITE_BASCOF').AsFloat  := 0;
          cdsItensPedido.FieldByName('ITE_ALQCOF').AsFloat  := 0;
          cdsItensPedido.FieldByName('ITE_VALCOF').AsFloat  := 0;
        End;

        fltBasIPI  := IIF(fStrToFloat(edtPerIpi.Text) > 0, fStrToFloat(edtValTot.Text), 0 );

        fltRepFre := (fltValFreSalvo*100)/fStrToFloat(edtValTot.Text);
        If (objCopiaSeg.recPcmger.strIPIFre = 'S') And (fltRepFre > 0) Then
          fltBasIpi := fltBasIpi + (fltBasIpi * fltRepFre /100);
        fltAlqIPI  := fStrToFloat(edtPerIpi.Text);
      End;
      fltValIPI := RoundTo(fltBasIPI * (fltAlqIPI/100), -2);

      If (recOpcGir.strPedMlj = 'S') Or (Not blnProcessoNormal) Then
        edtTotIPI.Text := FloatToStrF(cdsItensPedido.FieldByName('ITE_TOTIPI').AsFloat, ffFixed, 12, 2);

      cdsItensPedido.FieldByName('ITE_PERSUB').AsFloat  := fStrToFloat(edtPerSub.Text);
      If (Not blnProcessoNormal) Then
        cdsItensPedido.FieldByName('ITE_TOTSUB').AsFloat  := fStrToFloat(edtTotSub.Text);

      ParametrosCalcImpostos.pSetaParametros(cdsItensPedido.FieldByName('ITE_CICMDE').AsString,
                                             cdsItensPedido.FieldByName('ITE_CDPIOP').AsString,
                                             cdsItensPedido.FieldByName('ITE_DIDIOP').AsString);

      If Not ((blnSinMul And  (recOpcGir.strPedMlj = 'S'))) Then
        pCarregaUltimaCompraGeral(cdsItensPedido, edtCodIte.Text, IIF(fEmptyStr(recOpcGir.strEmpGir), strEmpDes, recOpcGir.strEmpGir));

      If (Not blnProcessoNormal) Then
      Begin
        fltTotSubCal := fCalcularSubstituicaoProduto(edtCodFor.Text,                                      // strCodFor,
                                                     fRetornaAbreviacaoItem(edtCodIte.Text),              // strCodAbf: String;
                                                     fStrToFloat(edtValTot.Text),                         // fltTotIte,
                                                     fltValFreSalvo,
                                                     fltDesAceSalvo ,
                                                     strFRMPCM,                                           // strFrmPcm,
                                                     objCopiaSeg.recPcmger.strBStFre,                     // strBStFre,
                                                     objCopiaSeg.recPcmger.strBStAce,                     // strBStAce: String;
                                                     blnZonaFranca,                                       // blnZonaFranca,
                                                     qryGenIte.FieldByName('ITE_INCPIS').AsString = 'S',  // blnIncPis,
                                                     strSimPau = 'S',                                     // blnFornecSimples: Boolean;
                                                     blnTemDare,
                                                     fltAlqIPI,                                           // fltAlqIPI: Double;
                                                     chkZeraST.Checked,
                                                     fltBasIcm,                                           // fltBasIcm,
                                                     fltAlqIcm,                                           // fltAlqIcm,
                                                     fltValIcm,                                           // fltValIcm,
                                                     fltBaseST,                                           // fltBaseST,
                                                     fltDesPis,                                           // fltDesPis,
                                                     fltBasIpi,                                           // fltBasIPI,
                                                     fltValIpi,                                           // fltValIPI,
                                                     fltPerFCP,                                           // fltPerFCP,
                                                     fltSubFCP,                                           // fltSubFCP: Double;
                                                     fltTotDar,                                           // fltTotDar
                                                     strCodSit,                                           // strCodSit: String;
                                                     strCodSitOrigem,                                     // strCodSitOrigem: String;
                                                     fltVlrAliquotaSub,                                   // fltAliquotaSub: Double;
                                                     ParametrosCalcImpostos,                              // ParametrosImpostos: TParametrosCalculoImposto;
                                                     strTipAbfFor);                                       // strTipAbfFor: String = '';

        fltIcmDesCal := 0;
        If ParametrosCalcImpostos.blnCalcularICMSDesonerado Then
          fltIcmDesCal := fltValIcm;


        If cdsItensPedido.FieldByName('ITE_SUBUSU').AsString = 'S' Then
        Begin
          edtTotSub.Text := FloatToStrF(cdsItensPedido.FieldByName('ITE_TOTSUB').AsFloat, ffFixed, 12, 2);
          If ParametrosCalcImpostos.blnCalcularICMSDesonerado Then
            edtIcmDes.Text := FloatToStrF(cdsItensPedido.FieldByName('ITE_VALICM').AsFloat, ffFixed, 12, 2)
          Else
            edtIcmDes.Text := '0,00';

          edtValDar.Text := FloatToStrF(cdsItensPedido.FieldByName('ITE_TOTDAR').AsFloat, ffFixed, 12, 2);
        End Else
        Begin
          edtTotSub.Text := FloatToStrF(fltTotSubCal, ffFixed, 12, 2);
          If ParametrosCalcImpostos.blnCalcularICMSDesonerado Then
             edtIcmDes.Text := FloatToStrF(fltIcmDesCal, ffFixed, 12, 2)
          Else
             edtIcmDes.Text := '0,00';
          cdsItensPedido.FieldByName('ITE_VALICM').AsFloat  := fltValIcm;

          edtValDar.Text := FloatToStrF(fltTotDar, ffFixed, 12, 2);
        End;

        cdsItensPedido.FieldByName('ITE_PERFCP').AsFloat  := fltPerFCP;
        cdsItensPedido.FieldByName('ITE_SUBFCP').AsFloat  := RoundTo(cdsItensPedido.FieldByName('ITE_TOTSUB').AsFloat * fltPerFCP / 100, -2);
        edtSubFCP.Text := FloatToStrF(cdsItensPedido.FieldByName('ITE_SUBFCP').AsFloat, ffFixed, 12, 2);

        edtPerSub.Text := FloatToStrF(fltVlrAliquotaSub, ffFixed, 12, 4);
        edtDesPis.Text := FloatToStrF(fltDesPis, ffFixed, 12, 2);

        cdsItensPedido.FieldByName('ITE_BASICM').AsFloat  := fltBasIcm;
        cdsItensPedido.FieldByName('ITE_PERBAS').AsFloat  := 100;
        cdsItensPedido.FieldByName('ITE_ALQICM').AsFloat  := fltAlqIcm;
        cdsItensPedido.FieldByName('ITE_BASSUB').AsFloat  := fltBaseST;
        cdsItensPedido.FieldByName('ITE_DESPIS').AsFloat  := fltDesPis;

        cdsItensPedido.FieldByName('ITE_CODSIT').AsString := strCodSit;
        cdsItensPedido.FieldByName('ITE_SITORI').AsString := strCodSitOrigem;
      End Else {If (Not blnProcessoNormal) Then}
      Begin
        cdsItensPedido.FieldByName('ITE_BASICM').AsFloat  := fltBasIcmIte;
        cdsItensPedido.FieldByName('ITE_PERBAS').AsFloat  := 100;
        cdsItensPedido.FieldByName('ITE_ALQICM').AsFloat  := fltAlqIcmIte;
        cdsItensPedido.FieldByName('ITE_VALICM').AsFloat  := fltValIcmIte;
        cdsItensPedido.FieldByName('ITE_BASSUB').AsFloat  := fltBaseSTIte;
        cdsItensPedido.FieldByName('ITE_DESPIS').AsFloat  := fltDesPisIte;
        cdsItensPedido.FieldByName('ITE_PERFCP').AsFloat  := fltPerFCPIte;

        cdsItensPedido.FieldByName('ITE_CODSIT').AsString := strCodSitIte;
        cdsItensPedido.FieldByName('ITE_SITORI').AsString := strCodSitOrigemIte;
      End;

      cdsItensPedido.FieldByName('ITE_PERIPI').AsFloat := fltAlqIPI;
      cdsItensPedido.FieldByName('ITE_BASIPI').AsFloat := fltBasIPI;
      cdsItensPedido.FieldByName('ITE_TOTIPI').AsFloat := fltValIPI;


      cdsItensPedido.FieldByName('ITE_TOTSUB').AsFloat  := fStrToFloat(edtTotSub.Text);
      cdsItensPedido.FieldByName('ITE_TOTDAR').AsFloat  := fStrToFloat(edtValDar.Text);
      cdsItensPedido.FieldByName('ITE_SUBFCP').AsFloat  := fStrToFloat(edtSubFCP.Text);

      If edtIcmDes.Visible Then
        cdsItensPedido.FieldByName('ITE_VALICM').AsFloat := fStrToFloat(edtIcmDes.Text);

      If edtDesPis.Visible Then
        cdsItensPedido.FieldByName('ITE_DESPIS').AsFloat := fStrToFloat(edtDesPis.Text);

      // Regra desligada: campos ocultos, preserva a aliquota ja gravada no item
      If FblnSomaReforma Then
      Begin
        cdsItensPedido.FieldByName('ITE_ALQCBS').AsFloat := fStrToFloat(edtAlqCbs.Text);
        cdsItensPedido.FieldByName('ITE_ALQIBS').AsFloat := fStrToFloat(edtAlqIbs.Text);
        cdsItensPedido.FieldByName('ITE_ALQ_IS').AsFloat := fStrToFloat(edtAlq_Is.Text);
      End;
      pCalculaImpostosReformaItem(cdsItensPedido, chkPedImp.Checked);

      cdsItensPedido.FieldByName('ITE_LITROS').AsFloat  := fStrToFloat(edtQtdIte.Text) * fRetLitrosUnidade(cdsItensPedido.FieldByName('ITE_CODUNI').AsString);

      If Not SameText(strLitGal, 'L') Then
        cdsItensPedido.FieldByName('ITE_LITROS').AsFloat := cdsItensPedido.FieldByName('ITE_LITROS').AsFloat / FLT_LITRO_GALAO;

      cdsItensPedido.FieldByName('ITE_PESORI').AsFloat  := qryGenIte.FieldByName('ITE_PESOIT').AsFloat;
      cdsItensPedido.FieldByName('ITE_PESOIT').AsFloat  := fStrToFloat(edtQtdIte.Text) * cdsItensPedido.FieldByName('ITE_QTDEMB').AsFloat * qryGenIte.FieldByName('ITE_PESOIT').AsFloat;

      If (blnUsarGiro Or blnAltPedGir) And (Not (blnItemCadastrado Or blnAlterando)) And
          cdsItensGiro.Locate('ITE_CODITE', cdsItensPedido.FieldByName('ITE_CODITE').AsString, []) Then
      Begin
        cdsItensPedido.FieldByName('ITE_ESTMIN').AsFloat := cdsItensGiro.FieldByName('ITE_ESTMIN').AsFloat;
        cdsItensPedido.FieldByName('ITE_ESTMAX').AsFloat := cdsItensGiro.FieldByName('ITE_ESTMAX').AsFloat;

        cdsItensPedido.FieldByName('ITE_MINDIG').AsFloat := cdsItensGiro.FieldByName('ITE_MINDIG').AsFloat;
        cdsItensPedido.FieldByName('ITE_MAXDIG').AsFloat := cdsItensGiro.FieldByName('ITE_MAXDIG').AsFloat;

        cdsItensPedido.FieldByName('ITE_PONPED').AsFloat := cdsItensGiro.FieldByName('ITE_PONPED').AsFloat;
        cdsItensPedido.FieldByName('ITE_SALDOS').AsFloat := cdsItensGiro.FieldByName('ITE_SALDOS').AsFloat;
        cdsItensPedido.FieldByName('ITE_SALRES').AsFloat := cdsItensGiro.FieldByName('ITE_SALRES').AsFloat;
        cdsItensPedido.FieldByName('ITE_SALEND').AsFloat := cdsItensGiro.FieldByName('ITE_SALEND').AsFloat;
        cdsItensPedido.FieldByName('ITE_SALGAR').AsFloat := cdsItensGiro.FieldByName('ITE_SALGAR').AsFloat;
        cdsItensPedido.FieldByName('ITE_SALDIS').AsFloat := cdsItensGiro.FieldByName('ITE_SALDIS').AsFloat;
        cdsItensPedido.FieldByName('ITE_SALEXT').AsFloat := cdsItensGiro.FieldByName('ITE_SALEXT').AsFloat;
        cdsItensPedido.FieldByName('ITE_SALBAS').AsFloat := cdsItensGiro.FieldByName('ITE_SALBAS').AsFloat;
        cdsItensPedido.FieldByName('ITE_SALFIS').AsFloat := cdsItensGiro.FieldByName('ITE_SALFIS').AsFloat;

        cdsItensPedido.FieldByName('ITE_VENMES').AsFloat := cdsItensGiro.FieldByName('ITE_VENMES').AsFloat;
        cdsItensPedido.FieldByName('ITE_Q_VPME').AsFloat := cdsItensGiro.FieldByName('ITE_Q_VPME').AsFloat;
        cdsItensPedido.FieldByName('ITE_QTDPEN').AsFloat := cdsItensGiro.FieldByName('ITE_QTDPEN').AsFloat;
        cdsItensPedido.FieldByName('ITE_SALREQ').AsFloat := cdsItensGiro.FieldByName('ITE_SALREQ').AsFloat;
        cdsItensPedido.FieldByName('ITE_QTPD_P').AsFloat := cdsItensGiro.FieldByName('ITE_QTPD_P').AsFloat;
        cdsItensPedido.FieldByName('ITE_QTEF_A').AsFloat := cdsItensGiro.FieldByName('ITE_QTEF_A').AsFloat;
        cdsItensPedido.FieldByName('ITE_QTEF_F').AsFloat := cdsItensGiro.FieldByName('ITE_QTEF_F').AsFloat;
        cdsItensPedido.FieldByName('ITE_QTEF_P').AsFloat := cdsItensGiro.FieldByName('ITE_QTEF_P').AsFloat;

        cdsItensPedido.FieldByName('ITE_MEDIA_').AsFloat := cdsItensGiro.FieldByName('ITE_MEDIA_').AsFloat;

        cdsItensPedido.FieldByName('ITE_DIASAI').Value   := cdsItensGiro.FieldByName('ITE_DIASAI').Value;

        cdsItensPedido.FieldByName('ITE_AJUSTA').AsFloat := cdsItensGiro.FieldByName('ITE_AJUSTA').AsFloat;
        cdsItensPedido.FieldByName('ITE_MEDIXX').AsFloat := cdsItensGiro.FieldByName('ITE_MEDIXX').AsFloat;
        cdsItensPedido.FieldByName('ITE_MEDAJU').AsFloat := cdsItensGiro.FieldByName('ITE_MEDAJU').AsFloat;
        cdsItensPedido.FieldByName('ITE_PMED_V').AsFloat := cdsItensGiro.FieldByName('ITE_PMED_V').AsFloat;

        For intContador := 1 To recOpcGir.intMesMos Do
        Begin
          cdsItensPedido.FieldByName('ITE_Q_V_' + fStrZero(IntToStr(intContador), 2)).Value :=
            cdsItensGiro.FieldByName('ITE_Q_V_' + fStrZero(IntToStr(intContador), 2)).Value;

          cdsItensPedido.FieldByName('ITE_Q_VP' + fStrZero(IntToStr(intContador), 2)).Value :=
            cdsItensGiro.FieldByName('ITE_Q_VP' + fStrZero(IntToStr(intContador), 2)).Value;

          cdsItensPedido.FieldByName('ITE_MQSA' + fStrZero(IntToStr(intContador), 2)).Value :=
            cdsItensGiro.FieldByName('ITE_MQSA' + fStrZero(IntToStr(intContador), 2)).Value;

          cdsItensPedido.FieldByName('ITE_MDSA' + fStrZero(IntToStr(intContador), 2)).Value :=
            cdsItensGiro.FieldByName('ITE_MDSA' + fStrZero(IntToStr(intContador), 2)).Value;
        End;

      End;

      If Assigned(cdsDigMultLoja) And (recOpcGir.strPedMlj = 'S') Then
      Begin
        cdsItensPedido.FieldByName('ITE_DIASUG').AsFloat := cdsDigMultLoja.intDiaSug
      End Else
      Begin

        If IIF(recOpcGir.blnMedAju,
               (Not cdsItensPedido.FieldByName('ITE_AJUSTA').IsNull) And (cdsItensPedido.FieldByName('ITE_AJUSTA').AsFloat > 0),
               (Not cdsItensPedido.FieldByName('ITE_MEDIA_').IsNull) And (cdsItensPedido.FieldByName('ITE_MEDIA_').AsFloat > 0)) Then
        Begin
          cdsItensPedido.FieldByName('ITE_DIASUG').AsInteger := Trunc(RoundTo((cdsItensPedido.FieldByName('ITE_SALBAS').AsFloat +
                                                                      ( cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat * cdsItensPedido.FieldByName('ITE_QTDEMB').AsFloat) +
                                                                       cdsItensPedido.FieldByName('ITE_QTDTRA').AsFloat) /
                                                                        (IIF(recOpcGir.blnMedAju,
                                                                               cdsItensPedido.FieldByName('ITE_AJUSTA').AsFloat,
                                                                               cdsItensPedido.FieldByName('ITE_MEDIA_').AsFloat) / 30), -4));


          If (Not blnNovoReg) And Assigned(cdsItensGiroExt) And (cdsItensGiroExt <> cdsItensPedido) And
           ((cdsItensGiroExt.FieldByName('ITE_CODITE').AsString = cdsItensPedido.FieldByName('ITE_CODITE').AsString) Or
            cdsItensGiroExt.Locate('ITE_CODITE', cdsItensPedido.FieldByName('ITE_CODITE').AsString, [])) Then
          Begin
            cdsItensGiroExt.Edit;
            cdsItensGiroExt.FieldByName('ITE_QTDITE').AsFloat   := cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat;
            cdsItensGiroExt.FieldByName('ITE_DIASUG').AsInteger := cdsItensPedido.FieldByName('ITE_DIASUG').AsInteger;
            cdsItensGiroExt.Post;

            If (blnItemCadastrado) Or (blnAlterando) Then
            Begin
              If (cdsItensPedido.State <> dsEdit) Then
                cdsItensPedido.Edit;
            End;
          End;

        End Else
        Begin
          cdsItensPedido.FieldByName('ITE_DIASUG').Clear;
        End;

      End;

      cdsItensPedido.FieldByName('ITE_TOTGER').AsFloat := cdsItensPedido.FieldByName('ITE_TOTITE').AsFloat +
                                                          cdsItensPedido.FieldByName('ITE_TOTIPI').AsFloat +
                                                          cdsItensPedido.FieldByName('ITE_TOTSUB').AsFloat +
                                                          cdsItensPedido.FieldByName('ITE_SUBFCP').AsFloat +
                                                          fTotalImpostosReformaItem(cdsItensPedido);

      pCalculaUniImp(cdsItensPedido);

      If cdsItensPedido.FieldByName('ITE_QTDREQ').IsNull Then
        cdsItensPedido.FieldByName('ITE_QTDREQ').AsFloat := 0;

      If cdsItensPedido.FieldByName('ITE_QATREQ').IsNull Then
        cdsItensPedido.FieldByName('ITE_QATREQ').AsFloat := 0;

      If cdsItensPedido.FieldByName('ITE_QTDTRA').IsNull Then
        cdsItensPedido.FieldByName('ITE_QTDTRA').AsFloat := 0;

      If blnCarregandoRequisicoes Then
      Begin

        If fEmptyStr(cdsItensPedido.FieldByName('ITE_INCIRQ').AsString) Then
        Begin

          cdsItensPedido.FieldByName('ITE_INCIRQ').AsString := strIncMovRcd;
        End

        Else If (Pos(strIncMovRcd, cdsItensPedido.FieldByName('ITE_INCIRQ').AsString) = 0) Then
        Begin
          cdsItensPedido.FieldByName('ITE_INCIRQ').AsString :=
             cdsItensPedido.FieldByName('ITE_INCIRQ').AsString + ',' + strIncMovRcd;

        End;

        If cdsItensPedido.State = dsInsert Then
          cdsItensPedido.FieldByName('ITE_CRIREQ').AsString := 'S';

        cdsItensPedido.FieldByName('ITE_QTDREQ').AsFloat := cdsItensPedido.FieldByName('ITE_QTDREQ').AsFloat + fltQtdReqImport;
        cdsItensPedido.FieldByName('ITE_QATREQ').AsFloat := cdsItensPedido.FieldByName('ITE_QATREQ').AsFloat + fltQtdReqImport;
      End;

      If fEmptyStr(cdsItensPedido.FieldByName('ITE_TIPOPE').AsString) Then
        cdsItensPedido.FieldByName('ITE_TIPOPE').AsString := STR_COMPRAR;

      If (cdsItensPedido.FieldByName('ITE_GRAVAD').AsString <> 'S') And
         objItensExcluidos.fRetAutoincrem(cdsItensPedido.FieldByName('ITE_CODITE').AsString,
                                          strAutPcd) Then
      Begin
        cdsItensPedido.FieldByName('AUTOINCREM').AsString := strAutPcd;
        cdsItensPedido.FieldByName('ITE_GRAVAD').AsString := 'S';
      End;

      If blnImportandoRequisicoesAutomatica Then
        cdsItensPedido.FieldByName('ITE_QTDINC').AsFloat := cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat;

      cdsItensPedido.FieldByName('ITE_DESGRU').AsString := qryGenIte.FieldByName('ITE_DESGRU').AsString;
      cdsItensPedido.FieldByName('ITE_DESSIM').AsString := qryGenIte.FieldByName('ITE_DESSIM').AsString;
      cdsItensPedido.FieldByName('ITE_TIPABS').AsString := qryGenIte.FieldByName('ITE_TIPABS').AsString;
      cdsItensPedido.FieldByName('ITE_VNOLCD').AsString := qryGenIte.FieldByName('ITE_VNOLCD').AsString;
      cdsItensPedido.Post;

      If Not blnCarregandoRequisicoes Then
        pRateiaFreteDesAce(fltValFreGer + fltDesAceGer > 0, fltValFreGer, fltDesAceGer,
                           objCopiaSeg.recPcmger.strBStFre,
                           objCopiaSeg.recPcmger.strBStAce,
                           objCopiaSeg.recPcmger.strIpiFre);

      pIncluiNaListaConsulta;

      blnInseriu := True;

      {**********************************************}
      {* ATUALIZA DADOS PARA PEDIDO MULTILOJAS      *}
      {*******************************************MV*}
      If (recOpcGir.strPedMlj = 'S') And (Not blnCarregandoRequisicoes) Then
      Begin
        cdsItensMultiLojas.DisableControls;

        pSaveBeforePost := cdsItensMultiLojas.BeforePost;
        cdsItensMultiLojas.BeforePost := Nil;

        If Not SameText(cdsItensMultiLojas.Filter, 'ITE_CODITE = ' + QuotedStr(edtCodIte.Text)) Then
        Begin
          cdsItensMultiLojas.Filter   := 'ITE_CODITE = ' + QuotedStr(edtCodIte.Text);
          cdsItensMultiLojas.Filtered := True;
        End;

        If cdsItensMultiLojas.IsEmpty Then
        Begin
          cdsDigMultLoja.pVeSeIncluiItemMultiLoja(edtCodIte.Text);

          If (cdsItensMultiLojas.recordcount > 0) Then {Item Inserido}
          Begin
            strFilterBkp := cdsItensMultiLojas.Filter;
            Try
              pAtualizaQtdMultiloja;
              objCopiaSeg.pAtualizaItem;
              pAtualizaTotalTela;
            Finally
               If cdsItensMultiLojas.Filter <> strFilterBkp Then
               Begin
                 cdsItensMultiLojas.Filter := strFilterBkp;
                 cdsItensMultiLojas.Filtered := True;
               End;
              cdsItensMultiLojas.DisableControls;
            End;
          End;
        End;
        intRecNo := cdsItensMultiLojas.RecNo;

        cdsItensMultiLojas.First;

        fltQtdIte := cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat;
        If fltQtdite <= 0 Then
          fltQtdIte := 1;

        fltFatorST   := cdsItensPedido.FieldByName('ITE_TOTSUB').AsFloat / fltQtdIte;
        fltFatorDar  := cdsItensPedido.FieldByName('ITE_TOTDAR').AsFloat / fltQtdIte;
        fltFatBasIcm := cdsItensPedido.FieldByName('ITE_BASICM').AsFloat / fltQtdIte;
        fltFatValIcm := cdsItensPedido.FieldByName('ITE_VALICM').AsFloat / fltQtdIte;
        fltFatDesPis := cdsItensPedido.FieldByName('ITE_DESPIS').AsFloat / fltQtdIte;
        fltFatBasSub := cdsItensPedido.FieldByName('ITE_BASSUB').AsFloat / fltQtdIte;

        If blnSinMul Then
        Begin
          cdsItensPedido.Edit;
          pIniacializaTotaisItem;
          pCarregaUltimaCompraGeral(cdsItensPedido, edtCodIte.Text, recOpcGir.strEmpGir);
        End;

        While (Not cdsItensMultiLojas.Eof) {And (cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat > 0)} Do
        Begin

          fltQtdMlj := cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat;
          cdsItensMultiLojas.Edit;
          cdsItensMultiLojas.FieldByName('ITE_QTDEMB').AsFloat  := cdsItensPedido.FieldByName('ITE_QTDEMB').AsFloat;
          cdsItensMultiLojas.FieldByName('ITE_EMBALA').AsFloat  := cdsItensPedido.FieldByName('ITE_EMBALA').AsFloat;
          cdsItensMultiLojas.FieldByName('AUTOINCREM').AsString := cdsItensPedido.FieldByName('AUTOINCREM').AsString;
          cdsItensMultiLojas.FieldByName('ITE_SIGUNI').AsString := cdsItensPedido.FieldByName('ITE_SIGUNI').AsString;
          cdsItensMultiLojas.FieldByName('ITE_CODGRU').AsString := qryGenIte.FieldByName('ITE_CODGRU').AsString;
          cdsItensMultiLojas.FieldByName('ITE_INCPIS').AsString := qryGenIte.FieldByName('ITE_INCPIS').AsString;
          If blnESMILJ Then
          Begin
            If qryGenIteESMIDG.Locate('CODEMP',cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString, []) Then
              cdsItensMultiLojas.FieldByName('ITE_ESMIDG').AsString := qryGenIteESMIDG.FieldByName('ITE_ESMIDG').AsString;
          End
          Else
            If fCfgSis('ESMILJ', varString, cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString) = 'S' then
              cdsItensMultiLojas.FieldByName('ITE_ESMIDG').AsString := qryGenIte.FieldByName('ITE_ESMIDG').AsString;
          cdsItensMultiLojas.FieldByName('ITE_DESITE').AsString := edtDesIte.Text;
          cdsItensMultiLojas.FieldByName('ITE_APLICA').AsString := qryGenIte.FieldByName('ITE_APLICA').AsString;
          cdsItensMultiLojas.FieldByName('ITE_DIAFOR').AsInteger:= qryGenIte.FieldByName('ITE_DIAFOR').AsInteger;
          cdsItensMultiLojas.FieldByName('ITE_UNITAR').AsFloat  := fStrToFloat(edtUnitar.Text);
          If objCopiaSeg.recPcmger.blnSomaDescontoAdcionalFornecedor1 Then
            cdsItensMultiLojas.FieldByName('ITE_DESUNI').AsFloat  := fStrToFloat(edtDesUni.Text) - fStrToFloat(edtDesAdi.Text)
          Else
            cdsItensMultiLojas.FieldByName('ITE_DESUNI').AsFloat  := fStrToFloat(edtDesUni.Text);
          cdsItensMultiLojas.FieldByName('ITE_DESUN2').AsFloat  := fStrToFloat(edtDesUn2.Text);
          cdsItensMultiLojas.FieldByName('ITE_DESUN3').AsFloat  := fStrToFloat(edtDesUn3.Text);
          cdsItensMultiLojas.FieldByName('ITE_DESUN4').AsFloat  := fStrToFloat(edtDesUn4.Text);
          cdsItensMultiLojas.FieldByName('ITE_DESUN5').AsFloat  := fStrToFloat(edtDesUn5.Text);
          cdsItensMultiLojas.FieldByName('ITE_DESUN6').AsFloat  := fStrToFloat(edtDesUn6.Text);

          cdsItensMultiLojas.FieldByName('ITE_UNILIQ').AsFloat  := fStrToFloat(edtUniLiq.Text);

          cdsItensMultiLojas.FieldByName('ITE_TOTITE').AsFloat  :=
            fltQtdMlj * RoundTo(fStrToFloat(edtUnitar.Text) *
                           ( (1 - fStrToFloat(edtDesUni.Text) / 100)
                           * (1 - fStrToFloat(edtDesUn2.Text) / 100)
                           * (1 - fStrToFloat(edtDesUn3.Text) / 100)
                           * (1 - fStrToFloat(edtDesUn4.Text) / 100)
                           * (1 - fStrToFloat(edtDesUn5.Text) / 100)
                           * (1 - fStrToFloat(edtDesUn6.Text) / 100) ), -intDecUni);

          cdsItensMultiLojas.FieldByName('ITE_PERIPI').AsFloat  := fStrToFloat(edtPerIpi.Text);
          If chkPedImp.Checked Then
          Begin
            cdsItensMultiLojas.FieldByName('ITE_ALQIMP').AsFloat  := cdsItensMultiLojas.FieldByName('ITE_ALQIMP').AsFloat;
            cdsItensMultiLojas.FieldByName('ITE_VALIMP').AsFloat  := cdsItensMultiLojas.FieldByName('ITE_VALIMP').AsFloat;

            cdsItensMultiLojas.FieldByName('ITE_BASIPI').AsFloat  := cdsItensMultiLojas.FieldByName('ITE_TOTITE').AsFloat + cdsItensMultiLojas.FieldByName('ITE_VALIMP').AsFloat;
            cdsItensMultiLojas.FieldByName('ITE_TOTIPI').AsFloat  := cdsItensMultiLojas.FieldByName('ITE_BASIPI').AsFloat * (fStrToFloat(edtPerIpi.Text) / 100);
          End Else
          Begin
            cdsItensMultiLojas.FieldByName('ITE_BASIPI').AsFloat  := cdsItensMultiLojas.FieldByName('ITE_TOTITE').AsFloat;
            cdsItensMultiLojas.FieldByName('ITE_TOTIPI').AsFloat  := cdsItensMultiLojas.FieldByName('ITE_BASIPI').AsFloat * (fStrToFloat(edtPerIpi.Text) / 100);
          End;

          cdsItensMultiLojas.FieldByName('ITE_PERSUB').AsFloat  := fStrToFloat(edtPerSub.Text);

          cdsItensMultiLojas.FieldByName('ITE_TOTSUB').AsFloat  := RoundTo(fltFatorST * cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat, -2);

          cdsItensMultiLojas.FieldByName('ITE_TOTDAR').AsFloat  := RoundTo(fltFatorDar * cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat, -2);

          cdsItensMultiLojas.FieldByName('ITE_PERFCP').AsFloat  := cdsItensPedido.FieldByName('ITE_PERFCP').AsFloat;
          cdsItensMultiLojas.FieldByName('ITE_SUBFCP').AsFloat  := RoundTo(cdsItensMultiLojas.FieldByName('ITE_TOTSUB').AsFloat *
                                                                           cdsItensMultiLojas.FieldByName('ITE_PERFCP').AsFloat / 100, -2);

          cdsItensMultiLojas.FieldByName('ITE_BASICM').AsFloat  := RoundTo(fltFatBasIcm * cdsItensMultiLojas.FieldByName('ITE_BASICM').AsFloat, -2);

          cdsItensMultiLojas.FieldByName('ITE_ALQICM').AsFloat  := fltAlqIcm;

          cdsItensMultiLojas.FieldByName('ITE_VALICM').AsFloat  := RoundTo(fltFatValIcm * cdsItensMultiLojas.FieldByName('ITE_VALICM').AsFloat, -2);

          cdsItensMultiLojas.FieldByName('ITE_DESPIS').AsFloat  := RoundTo(fltFatDesPis * cdsItensMultiLojas.FieldByName('ITE_DESPIS').AsFloat, -2);

          cdsItensMultiLojas.FieldByName('ITE_BASSUB').AsFloat  := RoundTo(fltFatBasSub * cdsItensMultiLojas.FieldByName('ITE_BASSUB').AsFloat, -2);

          pCopiaAliquotasReforma(cdsItensPedido, cdsItensMultiLojas, chkPedImp.Checked);

          fltTotSubAtu := fltTotSubAtu + cdsItensMultiLojas.FieldByName('ITE_TOTSUB').AsFloat;

          fltTotDarAtu := fltTotDarAtu + cdsItensMultiLojas.FieldByName('ITE_TOTDAR').AsFloat;

          cdsItensMultiLojas.FieldByName('ITE_DTAENT').Value    := cdsItensPedido.FieldByName('ITE_DTAENT').Value;

          If Not(cdsItensPedido.FieldByName('ITE_DTAEDT').IsNull) Then
            cdsItensMultiLojas.FieldByName('ITE_DTAEDT').Value    := cdsItensPedido.FieldByName('ITE_DTAEDT').Value;

          TCalculaCamposPedido.pCalcFields(cdsItensMultiLojas);

          cdsItensMultiLojas.Post;

          If blnSinMul Then
            pIncrementaTotaisPedido;

          cdsItensMultiLojas.Next;
        End;

        If blnSinMul Then
          cdsItensPedido.Post;

        If (cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat > 0) Then
        Begin
          If (cdsItensPedido.FieldByName('ITE_TOTSUB').AsFloat > fltTotSubAtu) Then
          Begin
            cdsItensMultiLojas.Edit;

            cdsItensMultiLojas.FieldByName('ITE_TOTSUB').AsFloat :=
              cdsItensMultiLojas.FieldByName('ITE_TOTSUB').AsFloat +
              (cdsItensPedido.FieldByName('ITE_TOTSUB').AsFloat - fltTotSubAtu);

            TCalculaCamposPedido.pCalcFields(cdsItensMultiLojas);

            cdsItensMultiLojas.Post;
          End
          Else If (fltTotSubAtu > cdsItensPedido.FieldByName('ITE_TOTSUB').AsFloat) Then
          Begin
            cdsItensMultiLojas.Edit;

            cdsItensMultiLojas.FieldByName('ITE_TOTSUB').AsFloat :=
              cdsItensMultiLojas.FieldByName('ITE_TOTSUB').AsFloat -
              (fltTotSubAtu - cdsItensPedido.FieldByName('ITE_TOTSUB').AsFloat);

            TCalculaCamposPedido.pCalcFields(cdsItensMultiLojas);

            cdsItensMultiLojas.Post;
          End;

          If (cdsItensPedido.FieldByName('ITE_TOTDAR').AsFloat > fltTotDarAtu) Then
          Begin
            cdsItensMultiLojas.Edit;

            cdsItensMultiLojas.FieldByName('ITE_TOTDAR').AsFloat :=
              cdsItensMultiLojas.FieldByName('ITE_TOTDAR').AsFloat +
              (cdsItensPedido.FieldByName('ITE_TOTDAR').AsFloat - fltTotDarAtu);

            TCalculaCamposPedido.pCalcFields(cdsItensMultiLojas);

            cdsItensMultiLojas.Post;
          End
          Else If (fltTotDarAtu > cdsItensPedido.FieldByName('ITE_TOTDAR').AsFloat) Then
          Begin
            cdsItensMultiLojas.Edit;

            cdsItensMultiLojas.FieldByName('ITE_TOTDAR').AsFloat :=
              cdsItensMultiLojas.FieldByName('ITE_TOTDAR').AsFloat -
              (fltTotDarAtu - cdsItensPedido.FieldByName('ITE_TOTDAR').AsFloat);

            TCalculaCamposPedido.pCalcFields(cdsItensMultiLojas);

            cdsItensMultiLojas.Post;
          End;

        End;

        cdsItensMultiLojas.BeforePost := pSaveBeforePost;

        If (intRecNo > 0) And (intRecNo <=  cdsItensMultiLojas.RecordCount) Then
          cdsItensMultiLojas.RecNo := intRecNo;

        cdsItensMultiLojas.EnableControls;
      End;

      strUniOri := '';

      pLimpaDadosItem;
      If (blnProcessoNormal) Then
        pSetFocus(edtCodIte);

      Result := True;

    Except
      On E: Exception Do
      Begin
        blnInseriu := False;
        pMensagensErro(E.Message, '[fAdicionaItem]');
      End;
    End;
  Finally
    If blnCdsFilteredBkp Then
    Begin
      cdsItensPedido.Filter   := strCdsFilterBkp;
      cdsItensPedido.Filtered := blnCdsFilteredBkp;
    End;
    cdsItensPedido.EnableControls;
  End;

  If fCheckParent(ActiveControl, cxgItens) Then
    cdsItensPedido.AfterScroll := pAferScroll;

  If blnAferScroll Then
    pAferScroll(cdsItensPedido);

  FreeAndNil(qryGenIte);
  FreeAndNil(qryGenIteESMIDG);

  If Assigned(cdsItensPedido) And
    (Not cdsItensPedido.IsEmpty) And
    (Assigned(objConsultaVeiculo)) Then
    objConsultaVeiculo.fIncluiDadosItem(cdsItensPedido.FieldByName('ITE_CODITE').AsString);
end;

procedure TfrmPedidoDeCompra.pAtualizaBotoesTotais(blnAtualizarTotais: Boolean = True);
begin
  If blnUsaTmq Then
    btnLitragem.Visible := cdsItensPedido.RecordCount > 0;

  btnEmbalagem.Visible    := cdsItensPedido.RecordCount > 0;
  btnApaga.Visible   := cdsItensPedido.RecordCount > 0;
  btnEstoque.Visible := cdsItensPedido.RecordCount > 0;
  btnPedidosPend.Visible  := cdsItensPedido.RecordCount > 0;
  btnGarantiaPend.Visible := cdsItensPedido.RecordCount > 0;

  if blnAtualizarTotais then
    pAtualizaTotalTela;
end;

Procedure TfrmPedidoDeCompra.pAtualizaTotalTela;
Begin
  edtTotGer.Text := FormatFloat('#,##0.00', fltValFreGer + fltDesAceGer + fDoubleAggregate(cdsItensPedido, 'TOT_TOTGER'));

  if blnEntIte then
    pAtualizaPCG_DTAENT(fRetDataEntrega);
End;

function TfrmPedidoDeCompra.fItemCadastrado: Boolean;
  Var
    strFilterBkp: String;
    blnFilteredBkp: Boolean;
    blnItemEspecial: Boolean;
begin
  Result := False;

  blnItemEspecial := fIsItemEspecial(edtCodIte.Text) And (Not(recOpcGir.strPedMlj = 'S'));

  {Garante que o Locate enxergue todos os itens do pedido, mesmo com filtro ativo na grade.}
  strFilterBkp   := cdsItensPedido.Filter;
  blnFilteredBkp := cdsItensPedido.Filtered;
  cdsItensPedido.DisableControls;
  cdsItensPedido.Filtered := False;
  Try
    If blnItemEspecial Then
    Begin
      Result := cdsItensPedido.Locate('ITE_CODITE;ITE_DESITE', varArrayOf([edtCodIte.Text, edtDesIte.Text]), []);
      Exit;
    End;

    If (cdsItensPedido.Locate('ITE_CODITE', edtCodIte.Text, [])) Then
    Begin
      Result := (cdsItensPedido.FieldByName('ITE_ITEESP').AsString = 'N');
    End;
  Finally
    If blnFilteredBkp Then
    Begin
      cdsItensPedido.Filter   := strFilterBkp;
      cdsItensPedido.Filtered := blnFilteredBkp;
      {Reativar o filtro pode mover o cursor; reposiciona por Locate (nao RecNo) usando a mesma chave
       composta do item especial, senao pode cair em outro item especial com codigo igual e descricao
       diferente. Verificar Nota 7 - Req. 456447}
      If blnItemEspecial Then
        cdsItensPedido.Locate('ITE_CODITE;ITE_DESITE', varArrayOf([edtCodIte.Text, edtDesIte.Text]), [])
      Else
        cdsItensPedido.Locate('ITE_CODITE', edtCodIte.Text, []);
    End;
    cdsItensPedido.EnableControls;
  End;

end;

procedure TfrmPedidoDeCompra.pMostraProdutosPendentes(blnMensagem: Boolean; strCodIte, strDesIte: String; blnQuoted: boolean = True; blnExibeMensagem: Boolean = False);
begin

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(136, 6199, [],
                        ['LSTITE','CODEMP'],
                        [IfThen(blnQuoted, QuotedStr(strCodIte), strCodIte),
                        IfThen(recOpcGir.strPedMlj <> 'S',fStrEmpSaldos,'')],
                        nil,
                        nil,
                        True,
                        blnExibeMensagem);
  End;

end;

procedure TfrmPedidoDeCompra.btnAdicionarClick(Sender: TObject);
Begin
  inherited;

  If fAdicionaItemClick Then
  Begin
    fltValFreSalvo := 0;
    fltDesAceSalvo := 0;
  End;

End;

Function TfrmPedidoDeCompra.fAdicionaItemClick: Boolean;
  Var
    blnAlterandoAnt: Boolean;
begin
  Result := False;

  Try

    blnAdicionandoItem := True;

    If not fValidaUnidade(True) Then
      Exit;

    blnAlterandoAnt := blnAlterando;

    Result := fAdicionaItem(True, True);

    If Not blnCarregandoRequisicoes Then
    Begin
      If (Not Result) And (recOpcGir.strPedMlj = 'S') Then
      Begin
        pVoltaQtdTmpMultiLojas(edtCodIte.Text, cdsItensMultiLojas);
        btnCancelaItem.Click;
      End;

      pFechaCompraItem;

      If Result Then
        pProximoItem(blnAlterandoAnt, False);

      pAtualizaBotoesTotais;
    End;

  Finally

    blnAdicionandoItem := False;
    pAtualizaGridRodape(True, strCodIteProcessadoRodape);

  End;
end;

procedure TfrmPedidoDeCompra.pProximoItem(blnAlterandoAnt, blnLimpaDados: Boolean);
Begin

  if blnInseriu then
  Begin
    objCopiaSeg.pAtualizaItem;

    If (blnAlterandoAnt) and (blnUsarGiro) Then
    Begin
      cxvItens.NavigatorButtons.Next.Click;
      pSetFocus(cxgItens);
    End

    Else
    Begin
      If blnLimpaDados Then
        pLimpaDadosItem;

      If edtCodIte.CanFocus Then
         pSetFocus(edtCodIte);
    End;
  End;

End;


procedure TfrmPedidoDeCompra.btnCancelaItemClick(Sender: TObject);
  Var
    blnAlterandoAnt: Boolean;
begin
  inherited;
  fltValFreSalvo := 0;
  fltDesAceSalvo := 0;

  blnAlterandoAnt := blnAlterando;
  pLimpaDadosItem;
  If (blnAlterandoAnt) Then
  Begin
    If cxgItens.CanFocus Then
      pSetFocus(cxgItens);
  End
  Else
    If edtCodIte.CanFocus Then
      pSetFocus(edtCodIte);

  pAtualizaBotoesTotais;

  pFechaCompraItem;
end;

procedure TfrmPedidoDeCompra.btnCarregaPedidosVendaClick(Sender: TObject);
var frmCarregandoItensVenda: TfrmGravando;
begin
  If fEmptyStr(edtCodFor.Text) Then
  Begin
    pMensagemOk('O Código do Fornecedor deve ser preenchido!');
    pSetFocus(edtCodFor);
    Exit;
  End;
  If fEmptyStr(edtCodCmp.Text) Then
  Begin
    pMensagemOk('O Código do Comprador deve ser preenchido!');
    pSetFocus(edtCodCmp);
    Exit;
  End;
  pCriarFormularios(TfrmGravando, frmCarregandoItensVenda);
  Try
    frmCarregandoItensVenda.lblGravando.Caption := 'Carregando Itens';
    frmCarregandoItensVenda.fExecutarAcao := fCarregaItensVendas;
    frmCarregandoItensVenda.ShowModal;
  Finally
    pFreeAndNil(frmCarregandoItensVenda);
  End;
end;

Function TfrmPedidoDeCompra.fCarregaItensVendas(pgbProgresso: TcxProgressBar): Boolean;
var blnInseriu: Boolean;
    frmSelItensVendasParaPedidoCompra: TfrmSelItensVendasParaPedidoCompra;
Begin
  inherited;
  Result := True;
  frmSelItensVendasParaPedidoCompra := TfrmSelItensVendasParaPedidoCompra.fSelecionaItens;
  Try
    If frmSelItensVendasParaPedidoCompra.blnConfirma Then
    Begin
      pgbProgresso.Properties.Max := frmSelItensVendasParaPedidoCompra.cdsItens.RecordCount;
      frmSelItensVendasParaPedidoCompra.cdsItens.First;
      while not frmSelItensVendasParaPedidoCompra.cdsItens.Eof Do
      begin
        edtCodIte.Text := frmSelItensVendasParaPedidoCompra.cdsItens.FieldByName('DET_CODITE').AsString;
        blnInseriu := fValidaItem(True, True, False);

        If blnInseriu Then
        Begin
          If blnAlterando And (frmSelItensVendasParaPedidoCompra.cdsItens.Locate('ITE_CODITE',edtCodIte.Text, [])) Then
            edtQtdIte.Text := FloatToStr(frmSelItensVendasParaPedidoCompra.cdsItens.FieldByName('ITE_QTDITE').AsFloat +
                                         frmSelItensVendasParaPedidoCompra.cdsItens.FieldByName('DET_QTDITE').AsFloat)
          Else
            edtQtdIte.Text := frmSelItensVendasParaPedidoCompra.cdsItens.FieldByName('DET_QTDITE').AsString;

          fValidaCampos(edtQtdIte);
          fAdicionaItem(False, False);
        End;


        frmSelItensVendasParaPedidoCompra.cdsItens.Next;
        pgbProgresso.Position := frmSelItensVendasParaPedidoCompra.cdsItens.RecNo;
        Application.ProcessMessages;
      End;
    End;
  Finally
    FreeAndNil(frmSelItensVendasParaPedidoCompra);
  End;

End;

function TfrmPedidoDeCompra.fObterDescontosItemGrid: TRecDescontoItem;
begin
  Result.Create(fStrToFloat(edtDesAdi.Text), intDecUni);
  if cdsItensPedido.IsEmpty then
    Exit;
  pCarregarDescontosItemGrid(Result);
  If strUniPcg <> '7' Then
    Result.fltDesAdi := 0;
end;

procedure TfrmPedidoDeCompra.pCarregarDescontosItemGrid(
  var recDescontoItem: TRecDescontoItem);
begin
  recDescontoItem.arrDesUni[DESCONTO1] := cdsItensPedido.FieldByName('ITE_DESUNI').AsFloat;
  recDescontoItem.arrDesUni[DESCONTO2] := cdsItensPedido.FieldByName('ITE_DESUN2').AsFloat;
  recDescontoItem.arrDesUni[DESCONTO3] := cdsItensPedido.FieldByName('ITE_DESUN3').AsFloat;
  recDescontoItem.arrDesUni[DESCONTO4] := cdsItensPedido.FieldByName('ITE_DESUN4').AsFloat;
  recDescontoItem.arrDesUni[DESCONTO5] := cdsItensPedido.FieldByName('ITE_DESUN5').AsFloat;
  recDescontoItem.arrDesUni[DESCONTO6] := cdsItensPedido.FieldByName('ITE_DESUN6').AsFloat;
end;

function TfrmPedidoDeCompra.fObterDescontosItem(blnAterandoDescontoItem: Boolean): TRecDescontoItem;
begin
  Result.Create(fStrToFloat(edtDesAdi.Text), intDecUni);
  pCarregarDescontosItem(Result);
  If (strUniPcg <> '7')  Then
  begin
    If blnAterandoDescontoItem Then
      Result.arrDesUni[DESCONTO1] := Result.fltDesAdi;
    Result.fltDesAdi := 0;
  End;
end;

procedure TfrmPedidoDeCompra.pCarregarDescontosItem(
  var recDescontoItem: TRecDescontoItem);
begin
  If objCopiaSeg.recPcmger.blnSomaDescontoAdcionalFornecedor1  Then
    recDescontoItem.arrDesUni[DESCONTO1] :=  (fStrToFloat(edtDesUni.Text) -  fStrToFloat(edtDesAdi.Text)) - (fltPerDesAdiOLD - fStrToFloat(edtDesAdi.Text))
  Else
    recDescontoItem.arrDesUni[DESCONTO1] := fStrToFloat(edtDesUni.Text);
  recDescontoItem.arrDesUni[DESCONTO2] := fStrToFloat(edtDesUn2.Text);
  recDescontoItem.arrDesUni[DESCONTO3] := fStrToFloat(edtDesUn3.Text);
  recDescontoItem.arrDesUni[DESCONTO4] := fStrToFloat(edtDesUn4.Text);
  recDescontoItem.arrDesUni[DESCONTO5] := fStrToFloat(edtDesUn5.Text);
  recDescontoItem.arrDesUni[DESCONTO6] := fStrToFloat(edtDesUn6.Text);
end;

procedure TfrmPedidoDeCompra.btnCfgGriClick(Sender: TObject);
begin
  inherited;
  objItens.pConfiguraColunas;
  pMostraColunasUnitarioLiquido(cxvItensUNILIQ.Visible);
end;

function TfrmPedidoDeCompra.fRetProximoAutIncTmp: String;
  Var
    strAutInc: String;
begin
  strAutInc := LeftStr(cdsItensPedido.AggFields.FieldByName('MAX_AUTOINCREM').AsString, 17);
  If (Not fEmptyStr(strAutInc)) Then
  Begin
    Result := fStrZero(IntToStr(Succ(StrToInt64(strAutInc))), 17) + VS_strCodEmp;
  End
  Else
    Result := fStrZero(1, 17) + VS_strCodEmp;
end;

function TfrmPedidoDeCompra.fPrecoUnitarioEspecialFornecedor(strCodFor,
  strCodIte: String): Double;
begin
  Result := fCampoTabela('FPR_VALITE',
                         'FORPRE',
                         ['FPR_CODFOR', 'FPR_CODITE'],
                         [strCodFor, strCodIte]);
end;

procedure TfrmPedidoDeCompra.pLimpaDadosItem;
begin
  strSubUsu := 'N';

  edtCodIte.Clear;
  edtDesIte.Clear;
  edtCodUni.Clear;
  edtEmbala.Clear;
  edtPraVal.Clear;

  edtSigUni.Clear;
  edtQtdIte.Clear;
  edtUnitar.Clear;
  edtDesUni.Clear;
  edtDesUn2.Clear;
  edtDesUn3.Clear;
  edtDesUn4.Clear;
  edtDesUn5.Clear;
  edtDesUn6.Clear;
  edtValTot.Clear;
  edtPerIpi.Clear;
  edtTotIpi.Clear;
  edtPerSub.Clear;
  edtTotSub.Clear;
  edtSubFCP.Clear;
  edtIcmDes.Clear;
  edtUniLiq.Clear;
  blnMudarFoco := False;
  blnAlterando := False;
  strAutoIncrem := '';
  pAtualizaBotoesTotais(False);
  blnLimpouItem := True;

  edtPerImp.Clear;
  edtTotImp.Clear;
  edtPerIpiImp.Clear;
  edtTotIpiImp.Clear;
  edtAlqCbs.Clear;
  edtAlqIbs.Clear;
  edtAlq_Is.Clear;
  edtValCbs.Clear;
  edtValIbs.Clear;
  edtVal_Is.Clear;
  edtPerCof.Clear;
  edtTotCof.Clear;
  edtPerPis.Clear;
  edtTotPis.Clear;

  edtDiaEnt.Clear;
  mskDtaEnt.Clear;
end;

procedure TfrmPedidoDeCompra.pApagaItem;
  Var
    strCodIte: string;
    strMsg: String;
begin

  If Not cdsItensPedido.IsEmpty then
  Begin

    If (Not fEmptyStr(cdsItensPedido.FieldByName('ITE_INCIRQ').AsString)) And
       (RoundTo(cdsItensPedido.FieldByName('ITE_QTDREQ').AsFloat, -2) > 0)  Then
    Begin
      strMsg := 'Há requisições vinculadas a esse produto, desmarque a requisição em "[F12] Import./Consult. Requisição" para poder excluir o produto!';
      If fEmptyStr(edtCodCmp.Text) Then
        strMsg := strMsg + ' (Lembrando que para isso a senha do comprador deve ser informada)';
      pMensagemOk(strMsg);
      Exit;
    End;

    If cdsItensPedido.FieldByName('ITE_BAIPED').AsFloat > 0 Then
    Begin
      pMensagemOk('Esse produto não pode ser excluido pois há notas (' + cdsItensPedido.FieldByName('ITE_BAINOT').AsString +
                  ') relacionadas a ele para serem efetivadas!');
      Exit;
    End;

    strCodIte := cdsItensPedido.FieldByName('ITE_CODITE').AsString;

    objCopiaSeg.pMarcaExcluido;

    If (cdsItensPedido.FieldByName('ITE_GRAVAD').AsString = 'S') Then
      objItensExcluidos.pSalvaAutoincrem(cdsItensPedido.FieldByName('ITE_CODITE').AsString,
                                         cdsItensPedido.FieldByName('ITE_DESITE').AsString,
                                         cdsItensPedido.FieldByName('AUTOINCREM').AsString);

    cxvItens.DataController.DeleteFocused;

    objTransfere.pExcluiItem(strCodIte, '', objCopiaSeg.recPcmger.strAutInc);

    pRetiraDaListaConsulta(strCodIte);

    pZeraMultiLojas(strCodIte, cdsItensMultiLojas, True);
    pSetFocus(cxgItens);
    If cdsItensPedido.RecordCount <= 0 Then
    Begin
      pLimpaDadosItem;
    End;
    pPesquisaCadIte(Nil, qryConIte, '', '', False);
    pCarregaIteger('');

    pRateiaFreteDesAce(fltValFreGer + fltDesAceGer > 0, fltValFreGer, fltDesAceGer,
                       objCopiaSeg.recPcmger.strBStFre,
                       objCopiaSeg.recPcmger.strBStAce,
                       objCopiaSeg.recPcmger.strIpiFre);
  End;

End;


function TfrmPedidoDeCompra.fRetQtdCtn: String;
  Var
    strSQL   : String;
    qryGenGer: TUniQuery;

begin
  Try

    qryGenGer := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PCMGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PCG_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCG_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  PCG_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  PCG_NUMCTN > 0 ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMPED').AsString := qryPcmGer.FieldByName('PCG_NUMPED').AsString;
      ParamByName('ESPDOC').AsString := qryPcmGer.FieldByName('PCG_ESPDOC').AsString;
      ParamByName('CODEMP').AsString := qryPcmGer.FieldByName('PCG_CODEMP').AsString;
      Open;
      Result := Fields[0].AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenGer);
  End;

end;

procedure TfrmPedidoDeCompra.pImportaPedFornecedor;
  Var
    intContador: Integer;
    stlArqTxt: TStringList;
    strLinha: String;
    intLinha: Integer;

    strCgcFor: String;
    strCodFab: String;
    fltQtdIte: Double;
    fltValUni: Double;
    fltValIpi: Double;
    fltAlqIpi: Double;
    strArqOld: String;
    intPos: Integer;

    qryCadEmp: TUniQuery;

    procedure pGravaDadosDataSet(cdsDataSet: TUniClientDataSet; fltQtdIte,
      fltValUni, fltAlqIpi, fltValIpi: Double; strCodEmp: String);
      Var
        intContador: Integer;
        strCodIte: String;
    begin

      strCodIte := qryConIte.FieldByName('ITE_CODITE').AsString;

      If (Not cdsDataSet.Locate('ITE_CODITE;ITE_CODEMP',
        VarArrayOf([strCodIte, strCodEmp]), [])) Then
      Begin

        cdsDataSet.Append;
        For intContador := 0 To cdsDataSet.FieldCount -1 Do
        Begin
          If cdsDataSet.Fields[intContador].DataType = ftFloat Then
            cdsDataSet.Fields[intContador].AsFloat := 0.0;
        End;

        cdsDataSet.FieldByName('ITE_INCIRQ').AsString := '';
        cdsDataSet.FieldByName('ITE_QTDREQ').AsFloat  := 0;
        cdsDataSet.FieldByName('ITE_QTDTRA').AsFloat  := 0;
        cdsDataSet.FieldByName('ITE_QATREQ').AsFloat  := 0;
        cdsDataSet.FieldByName('ITE_TRAINC').AsFloat  := 0;

      End
      Else
      Begin

        cdsDataSet.Edit;

      End;

      cdsDataSet.FieldByName('ITE_CODITE').AsString := qryConIte.FieldByName('ITE_CODITE').AsString;
      cdsDataSet.FieldByName('ITE_CODGRU').AsString := qryConIte.FieldByName('ITE_CODGRU').AsString;
      cdsDataSet.FieldByName('ITE_CODMAR').AsString := qryConIte.FieldByName('ITE_CODMAR').AsString;
      cdsDataSet.FieldByName('ITE_CONPAG').AsString := mskCndPag.Text;
      cdsDataSet.FieldByName('ITE_DESITE').AsString := qryConIte.FieldByName('ITE_DESITE').AsString + ' ' +
                                                        qryConIte.FieldByName('ITE_REFERE').AsString;

      cdsDataSet.FieldByName('ITE_APLICA').AsString := qryConIte.FieldByName('ITE_APLICA').AsString;
      cdsDataSet.FieldByName('ITE_DIAFOR').AsInteger:= qryConIte.FieldByName('ITE_DIAFOR').AsInteger;

      cdsDataSet.FieldByName('ITE_QTDITE').AsFloat  := cdsDataSet.FieldByName('ITE_QTDITE').AsFloat + fltQtdIte;

      cdsDataSet.FieldByName('ITE_UNITAR').AsFloat  := fltValUni;

      cdsDataSet.FieldByName('ITE_TOTITE').AsFloat  := cdsDataSet.FieldByName('ITE_TOTITE').AsFloat +
                                                          fltQtdIte * fltValUni;

      cdsDataSet.FieldByName('ITE_BASIPI').AsFloat  := IIF(fltAlqIpi > 0, cdsDataSet.FieldByName('ITE_TOTITE').AsFloat, 0);
      cdsDataSet.FieldByName('ITE_PERIPI').AsFloat  := fltAlqIpi;
      cdsDataSet.FieldByName('ITE_TOTIPI').AsFloat  := cdsDataSet.FieldByName('ITE_TOTIPI').AsFloat + fltValIpi;

      cdsDataSet.FieldByName('ITE_PERSUB').AsFloat  := 0.0;
      cdsDataSet.FieldByName('ITE_TOTSUB').AsFloat  := 0.0;
      cdsDataSet.FieldByName('ITE_TOTDAR').AsFloat  := 0.0;

      cdsDataSet.FieldByName('ITE_PERFCP').AsFloat  := 0.0;
      cdsDataSet.FieldByName('ITE_SUBFCP').AsFloat  := 0.0;

      cdsDataSet.FieldByName('ITE_CODUNI').AsString := qryConIte.FieldByName('ITE_CODUNI').AsString;

      cdsDataSet.FieldByName('ITE_LITROS').AsFloat  := cdsDataSet.FieldByName('ITE_LITROS').AsFloat +
        (fltQtdIte * fRetLitrosUnidade(cdsDataSet.FieldByName('ITE_CODUNI').AsString)) / IIF(SameText(strLitGal, 'L'), 1, FLT_LITRO_GALAO);

      cdsDataSet.FieldByName('ITE_PESORI').AsFloat  := qryConIte.FieldByName('ITE_PESOIT').AsFloat;

      cdsDataSet.FieldByName('ITE_PESOIT').AsFloat  := cdsDataSet.FieldByName('ITE_PESOIT').AsFloat * cdsDataSet.FieldByName('ITE_QTDITE').AsFloat
                                                                       * cdsDataSet.FieldByName('ITE_QTDEMB').AsFloat;
      cdsDataSet.FieldByName('ITE_CODFAB').AsString := strCodFab;
      cdsDataSet.FieldByName('ITE_PEDTXT').AsString := 'SUV';

      cdsDataSet.FieldByName('ITE_CODEMP').AsString := strCodEmp;
      cdsDataSet.FieldByName('ITE_DESEMP').AsString := fRetNomeEmpresa(strCodEmp);
      cdsDataSet.FieldByName('ITE_FANEMP').AsString := fRetFantasiaEmpresa(strCodEmp);

      cdsDataSet.FieldByName('ITE_DESM01').AsString := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -1));
      cdsDataSet.FieldByName('ITE_DESM02').AsString := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -2));
      cdsDataSet.FieldByName('ITE_DESM03').AsString := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -3));

      pCalculaImpostosReformaItem(cdsDataSet, chkPedImp.Checked);

      cdsDataSet.Post;

      objCopiaSeg.pAtualizaItem;
    end;

begin

  If (Not Assigned(stlArquivos)) Then
    Exit;

  stlArqTxt := TStringList.Create;

  For intContador := 0 To stlArquivos.Count -1 Do
  Begin
    stlArqTxt.LoadFromFile(stlArquivos[intContador]);

    {*******************************************}
    {* LOCALIZA O FORNECEDOR                   *}
    {****************************************MV*}
    strCgcFor := Copy(stlArqTxt[0], 55, 14);
    pCarregaFornecedor(False, strCgcFor);
    edtCodFor.Text := qryConFor.FieldByName('FOR_CODFOR').AsString;
    mskDtaPed.Text := DateToStr(VS_Date);
    mskDtaFat.Text := DateToStr(VS_Date);
    mskCndPag.Text := '01000';

    intLinha := 2;
    strLinha := stlArqTxt[intLinha];

    While (LeftStr(strLinha, 3) = 'AE2') Do
    Begin

      strCodFab := Trim(Copy(strLinha, 019, 12));
      pPesquisaCadIte(Nil, qryConIte, strCodFab, edtCodFor.Text, False, True);
      If (Not qryConIte.IsEmpty) Then
      Begin
        fltQtdIte := fStrToFloat(Copy(strLinha, 081, 10)) / 1000;
        fltValUni := fStrToFloat(Copy(strLinha, 105, 13)) / 100;
        fltValIpi := fStrToFloat(Copy(strLinha, 120, 13)) / 100;
        fltAlqIpi := fStrToFloat(Copy(strLinha, 103, 02));

        pGravaDadosDataSet(cdsItensPedido, fltQtdIte, fltValUni, fltAlqIpi,
          fltValIpi, strCodEmp);

        If (fCfgSis('PEDMLJ') = 'S') Then
        Begin

          qryCadEmp := fCriaQuery(Self);
          qryCadEmp.SQL.Add('SELECT * FROM CADEMP');
          qryCadEmp.Open;

          While (Not qryCadEmp.Eof) Do
          Begin

            If (qryCadEmp.FieldByName('EMP_CODEMP').AsString = strCodEmp) Then
            Begin
              pGravaDadosDataSet(cdsItensMultiLojas, fltQtdIte, fltValUni, fltAlqIpi,
                fltValIpi, strCodEmp);
            End
            Else
            Begin
              pGravaDadosDataSet(cdsItensMultiLojas, 0.0, 0.0, 0.0, 0.0,
                qryCadEmp.FieldByName('EMP_CODEMP').AsString);
            End;

            qryCadEmp.Next;
          End;

          FreeAndNil(qryCadEmp);

        End;

      End;

      Inc(intLinha);
      If intLinha <= (stlArqTxt.Count -1) Then
        strLinha := stlArqTxt[intLinha]
      Else
        Break;
    End;

    strArqOld := stlArquivos[intContador];
    intPos := Pos('.', strArqOld);
    If (intPos > 0) Then
      strArqOld := Copy(strArqOld, 1, intPos-1) + '.old';
    DeleteFile(strArqOld);
    RenameFile(stlArquivos[intContador], strArqOld);

    pLimpaDadosItem;

    pRateiaFreteDesAce(fltValFreGer + fltDesAceGer > 0, fltValFreGer, fltDesAceGer,
                       objCopiaSeg.recPcmger.strBStFre, objCopiaSeg.recPcmger.strBStAce,
                       objCopiaSeg.recPcmger.strIpiFre);
  End;

  If Not fEmptyStr(edtCodFor.Text) then
  Begin
    fValidaCampos(edtCodFor);
  End;

end;

procedure TfrmPedidoDeCompra.pImprimeEtiqueta(strCodFor, strNumDoc, strEspDoc: string);
begin
  TfrmEntEtiquetas.pImpEtiPedidoDeCompra(strNumDoc, strEspDoc, strCodFor);
end;

Function TfrmPedidoDeCompra.fCarregaItensPedido: Boolean;
Begin
  Try
    blnCarregandoPedido := True;
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Carregando pedido...';
    frmGravando.fExecutarAcao := fCarregaItensPedidoAux;
    frmGravando.ShowModal;

    Result := frmGravando.blnConfirma;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TRecSadoReservado.fCarregaItensPedido]');
    End;
  End;

  blnCarregandoPedido := False;
  pFreeAndNil(frmGravando);
End;

Function TfrmPedidoDeCompra.fSQLItensPedido(blnRecupera: Boolean): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';

  If blnRecupera Then
    strSQL := strSQL + '  EXCLUIDO, '
  Else
    strSQL := strSQL + '  "N" AS EXCLUIDO, ';

  strSQL := strSQL + '  PCD_CODITE AS ITE_CODITE, ';
  strSQL := strSQL + '  IF(PCD_SUBUSU NOT IN ("N", "S"), "N", PCD_SUBUSU) AS ITE_SUBUSU, ';

  strSQL := strSQL + '  I.ITE_CODGRU, ';
  strSQL := strSQL + '  PCD_CONPAG AS ITE_CNDPAG, ';
  strSQL := strSQL + '  PCD_DESITE AS ITE_DESITE, ';

  If fCfgSis('MENAPL', varBoolean) Then
    strSQL := strSQL + ' CONCAT(IFNULL(I.ITE_APLICA,""), ' + 'CASE WHEN IFNULL(I.ITE_APLICA,"") = "" THEN "" ELSE ' + QuotedStr('\r\n') + ' END ' + ', IFNULL(I.ITE_MSGLV1,""), ' + QuotedStr('\r\n') + ', IFNULL(I.ITE_MSGLV2,"")) AS ITE_APLICA, '
  Else
    strSQL := strSQL + '  I.ITE_APLICA, ';


  strSQL := strSQL + '  I.ITE_DIAFOR, ';
  strSQL := strSQL + '  (PCD_QTDITE - PCD_QTDBAI) AS ITE_QTDITE, ';

  // QUANTIDADE QUE VAI SER BAIXADA NA EFETIVAÇÃO DO MOVIMENTO FISCAL
  strSQL := strSQL + '  IF(LENGTH(PD.AUTOINCREM) = 20,    ';
  strSQL := strSQL + '  IFNULL((SELECT SUM(BAI_QTDPED) FROM BAIPED                   ';
  strSQL := strSQL + '    INNER JOIN MOVDET M ON M.AUTOINCREM = BAI_AUTDET                      ';
  strSQL := strSQL + '    WHERE BAI_AUTPED = PD.AUTOINCREM AND M.DET_DTAENT IS NULL),           ';
  strSQL := strSQL + ' (SELECT IFNULL(SUM(DEF_QTDITE), 0) FROM DEFBAI WHERE DEF_AUTPCD = PD.AUTOINCREM ';
  strSQL := strSQL + '  AND (SELECT M.DET_DTAENT FROM MOVDET M ';
  strSQL := strSQL + '       INNER JOIN MOVTRI T ON T.DET_SEQGER = M.AUTOINCREM ';
  strSQL := strSQL + '       WHERE T.DET_AUTELE = DEF_AUTELE LIMIT 1) IS NULL )), 0) AS ITE_BAIPED, ';

  // NOTAS RELACIONADAS AO ITEM ESPERANDO EFETIVAÇÃO DO MOVIMENTO FISCAL
  strSQL := strSQL + '  IF(LENGTH(PD.AUTOINCREM) = 20,    ';
  strSQL := strSQL + '  IFNULL((SELECT GROUP_CONCAT(CONCAT(M.DET_ESPDOC, "-", M.DET_NUMDOC, "-", M.DET_CODEMP)) FROM BAIPED ';
  strSQL := strSQL + '    INNER JOIN MOVDET M ON M.AUTOINCREM = BAI_AUTDET                              ';
  strSQL := strSQL + '    WHERE BAI_AUTPED = PD.AUTOINCREM AND M.DET_DTAENT IS NULL), ';

  strSQL := strSQL + '  (SELECT GROUP_CONCAT(DISTINCT CONCAT("NF-", B08_NNF, "-", GER_CODEMP)) FROM DEFBAI ';
  strSQL := strSQL + '   INNER JOIN GERELE ON GERELE.AUTOINCREM = DEF_GERELE ';
  strSQL := strSQL + '   WHERE DEF_AUTPCD = PD.AUTOINCREM ';
  strSQL := strSQL + '         AND (SELECT M.DET_DTAENT FROM MOVDET M ';
  strSQL := strSQL + '              INNER JOIN MOVTRI T ON T.DET_SEQGER = M.AUTOINCREM ';
  strSQL := strSQL + '              WHERE T.DET_AUTELE = DEF_AUTELE LIMIT 1) IS NULL)), "") AS ITE_BAINOT, ';

  strSQL := strSQL + '  PCD_UNITAR AS ITE_UNITAR, ';
  strSQL := strSQL + '  IFNULL(PCD_DESUNI, 0) AS ITE_DESUNI, ';
  strSQL := strSQL + '  IFNULL(PCD_DESUN2, 0) AS ITE_DESUN2, ';
  strSQL := strSQL + '  IFNULL(PCD_DESUN3, 0) AS ITE_DESUN3, ';
  strSQL := strSQL + '  IFNULL(PCD_DESUN4, 0) AS ITE_DESUN4, ';
  strSQL := strSQL + '  IFNULL(PCD_DESUN5, 0) AS ITE_DESUN5, ';
  strSQL := strSQL + '  IFNULL(PCD_DESUN6, 0) AS ITE_DESUN6, ';

  strSQL := strSQL + '  PCD_EMBALA, ';

  If fCfgSis('UNIPCG') = '7' Then
  Begin
    strSQL := strSQL + '  (ROUND(PCD_UNITAR * ';
    strSQL := strSQL + '      (  (1 - (IF(PCG_ADAFO1  = "S", IFNULL(PCD_DESUNI, 0) + IFNULL(PCG_DESADI, 0), IFNULL(PCD_DESUNI, 0))) / 100)  ';
    strSQL := strSQL + '       * (1 - IFNULL(PCD_DESUN2, 0) / 100) ';
    strSQL := strSQL + '       * (1 - IFNULL(PCD_DESUN3, 0) / 100) ';
    strSQL := strSQL + '       * (1 - IFNULL(PCD_DESUN4, 0) / 100) ';
    strSQL := strSQL + '       * (1 - IFNULL(PCD_DESUN5, 0) / 100) ';
    strSQL := strSQL + '       * (1 - IFNULL(PCD_DESUN6, 0) / 100) ';
    strSQL := strSQL + '       * (1 - (IF(PCG_ADAFO1  = "S", 0, IFNULL(PCG_DESADI, 0))) / 100)  ';
    strSQL := strSQL + '       ), :DECUNI)) AS ITE_UNILIQ, ';
 
    strSQL := strSQL + '  ((PCD_QTDITE - PCD_QTDBAI) * ROUND(PCD_UNITAR * ';
    strSQL := strSQL + '      (  (1 - (IF(PCG_ADAFO1  = "S", IFNULL(PCD_DESUNI, 0) + IFNULL(PCG_DESADI, 0), IFNULL(PCD_DESUNI, 0))) / 100)  ';
    strSQL := strSQL + '       * (1 - IFNULL(PCD_DESUN2, 0)/ 100) ';
    strSQL := strSQL + '       * (1 - IFNULL(PCD_DESUN3, 0)/ 100) ';
    strSQL := strSQL + '       * (1 - IFNULL(PCD_DESUN4, 0)/ 100) ';
    strSQL := strSQL + '       * (1 - IFNULL(PCD_DESUN5, 0)/ 100) ';
    strSQL := strSQL + '       * (1 - IFNULL(PCD_DESUN6, 0)/ 100) ';
    strSQL := strSQL + '       * (1 - (IF(PCG_ADAFO1  = "S", 0, IFNULL(PCG_DESADI, 0))) / 100)  ';
    strSQL := strSQL + '      ), :DECUNI)) AS ITE_TOTITE, ';
  End
  Else
  Begin
    strSQL := strSQL + '  (ROUND(PCD_UNITAR * ';
    strSQL := strSQL + '      (  (1 - (IF(PCG_ADAFO1  = "S", IFNULL(PCD_DESUNI, 0) + IFNULL(PCG_DESADI, 0), IFNULL(PCD_DESUNI, 0))) / 100)  ';
    strSQL := strSQL + '       * (1 - IFNULL(PCD_DESUN2, 0) / 100) ';
    strSQL := strSQL + '       * (1 - IFNULL(PCD_DESUN3, 0) / 100) ';
    strSQL := strSQL + '       * (1 - IFNULL(PCD_DESUN4, 0) / 100) ';
    strSQL := strSQL + '       * (1 - IFNULL(PCD_DESUN5, 0) / 100) ';
    strSQL := strSQL + '       * (1 - IFNULL(PCD_DESUN6, 0) / 100) ';
    strSQL := strSQL + '       ), :DECUNI)) AS ITE_UNILIQ, ';
 
    strSQL := strSQL + '  ((PCD_QTDITE - PCD_QTDBAI) * ROUND(PCD_UNITAR * ';
    strSQL := strSQL + '      (  (1 - (IF(PCG_ADAFO1  = "S", IFNULL(PCD_DESUNI, 0) + IFNULL(PCG_DESADI, 0), IFNULL(PCD_DESUNI, 0))) / 100)  ';
    strSQL := strSQL + '       * (1 - IFNULL(PCD_DESUN2, 0)/ 100) ';
    strSQL := strSQL + '       * (1 - IFNULL(PCD_DESUN3, 0)/ 100) ';
    strSQL := strSQL + '       * (1 - IFNULL(PCD_DESUN4, 0)/ 100) ';
    strSQL := strSQL + '       * (1 - IFNULL(PCD_DESUN5, 0)/ 100) ';
    strSQL := strSQL + '       * (1 - IFNULL(PCD_DESUN6, 0)/ 100) ';
    strSQL := strSQL + '      ), :DECUNI)) AS ITE_TOTITE, ';
  End;

  strSQL := strSQL + '   IF(IFNULL(PCD_UNITAR, 0) = 0, 0, (((PCD_UNITAR - G.ITE_PREULT) / G.ITE_PREULT) * 100)) AS ITE_DIFPRE, ';

  strSQL := strSQL + '  IFNULL(PCD_BASICM,0) AS ITE_BASICM, ';
  strSQL := strSQL + '  100.00 AS ITE_PERBAS, ';
  strSQL := strSQL + '  IFNULL(PCD_ALQICM,0) AS ITE_ALQICM, ';

  strSQL := strSQL + '  (PCD_VALICM / PCD_QTDITE) * (PCD_QTDITE - PCD_QTDBAI) AS ITE_VALICM, ';
  strSQL := strSQL + '  (PCD_DESPIS / PCD_QTDITE) * (PCD_QTDITE - PCD_QTDBAI) AS ITE_DESPIS, ';

  strSQL := strSQL + '  IFNULL(PCD_BASIPI,0) AS ITE_BASIPI, ';
  strSQL := strSQL + '  IFNULL(PCD_PERIPI,0) AS ITE_PERIPI, ';
  strSQL := strSQL + '  IFNULL(PCD_TOTIPI,0) AS ITE_TOTIPI, ';

  strSQL := strSQL + '  IFNULL(PCD_ALQCBS,0) AS ITE_ALQCBS, ';
  strSQL := strSQL + '  IFNULL(PCD_ALQIBS,0) AS ITE_ALQIBS, ';
  strSQL := strSQL + '  IFNULL(PCD_ALQ_IS,0) AS ITE_ALQ_IS, ';

  strSQL := strSQL + '  IFNULL(PCD_BASSUB,0) AS ITE_BASSUB, ';
  strSQL := strSQL + '  IFNULL(PCD_PERSUB,0) AS ITE_PERSUB, ';
  strSQL := strSQL + '  IFNULL(PCD_PERFCP,0) AS ITE_PERFCP, ';

  strSQL := strSQL + '  IFNULL(PCD_TOTSUB,0) - IFNULL(PCD_SUBBAI,0) AS ITE_TOTSUB, ';
  strSQL := strSQL + '  IFNULL(PCD_TOTDAR,0) - IFNULL(PCD_DARBAI, 0) AS ITE_TOTDAR, ';
  strSQL := strSQL + '  IFNULL(PCD_SUBFCP,0) - IFNULL(PCD_FCPBAI,0) AS ITE_SUBFCP, ';

  strSQL := strSQL + '  PCD_BASCOF AS ITE_BASCOF, ';
  strSQL := strSQL + '  PCD_ALQCOF AS ITE_ALQCOF, ';
  strSQL := strSQL + '  PCD_VALCOF AS ITE_VALCOF, ';

  strSQL := strSQL + '  PCD_VALFRE AS ITE_VALFRE, ';
  strSQL := strSQL + '  PCD_DESACE AS ITE_DESACE, ';

  strSQL := strSQL + '  PCD_BASPIS AS ITE_BASPIS, ';
  strSQL := strSQL + '  PCD_ALQPIS AS ITE_ALQPIS, ';
  strSQL := strSQL + '  PCD_VALPIS AS ITE_VALPIS, ';

  strSQL := strSQL + '  PCD_ALQIMP AS ITE_ALQIMP, ';
  strSQL := strSQL + '  PCD_VALIMP AS ITE_VALIMP, ';

  strSQL := strSQL + '  PCD_QTDBAI AS ITE_QTDBAI, ';
  strSQL := strSQL + '  PCD_TOTBAI AS ITE_TOTBAI, ';
  strSQL := strSQL + '  PCD_IPIBAI AS ITE_IPIBAI, ';
  strSQL := strSQL + '  PCD_SUBBAI AS ITE_SUBBAI, ';
  strSQL := strSQL + '  PCD_DARBAI AS ITE_DARBAI, ';
  strSQL := strSQL + '  PCD_DARBAI AS ITE_DARBAI, ';
  If fCfgSis('UNIPCG') = '7' Then
  Begin
    strSQL := strSQL + '  PCD_UNITAR * (1 - (IF(PCG_ADAFO1  = "S", IFNULL(PCD_DESUNI, 0) + IFNULL(PCG_DESADI, 0), IFNULL(PCD_DESUNI, 0))) / 100)  ';
    strSQL := strSQL + '  * (1 - PCD_DESUN2 / 100) ';
    strSQL := strSQL + '  * (1 - PCD_DESUN3 / 100) ';
    strSQL := strSQL + '  * (1 - PCD_DESUN4 / 100) ';
    strSQL := strSQL + '  * (1 - PCD_DESUN5 / 100) ';
    strSQL := strSQL + '  * (1 - PCD_DESUN6 / 100) ';
    strSQL := strSQL + '  * (1 - (IF(PCG_ADAFO1  = "S", 0, IFNULL(PCG_DESADI, 0))) / 100)  + IF(IFNULL(PCD_QTDITE, 0) = 0, 0, (IFNULL(PCD_TOTIPI,0) / PCD_QTDITE ) + (IFNULL(PCD_TOTSUB, 0) / PCD_QTDITE))' + fSQLUnitarioImpostosReforma('PCD') + ' AS ITE_UNIIMP, ';
  End
  Else
  Begin
    strSQL := strSQL + '  PCD_UNITAR * (1 - PCD_DESUNI / 100) ';
    strSQL := strSQL + '  * (1 - PCD_DESUN2 / 100) ';
    strSQL := strSQL + '  * (1 - PCD_DESUN3 / 100) ';
    strSQL := strSQL + '  * (1 - PCD_DESUN4 / 100) ';
    strSQL := strSQL + '  * (1 - PCD_DESUN5 / 100) ';
    strSQL := strSQL + '  * (1 - PCD_DESUN6 / 100)  + IF(IFNULL(PCD_QTDITE, 0) = 0, 0, (IFNULL(PCD_TOTIPI,0) / PCD_QTDITE ) + (IFNULL(PCD_TOTSUB, 0) / PCD_QTDITE))' + fSQLUnitarioImpostosReforma('PCD') + ' AS ITE_UNIIMP, ';
  End;
  strSQL := strSQL + '  PCD_DTAPED AS DTAPED, ';
  strSQL := strSQL + '  PCD_DTAENT AS DTAENT, ';

  strSQL := strSQL + '  PCD_CODUNI AS ITE_CODUNI, ';
  strSQL := strSQL + '  UNI_SIGUNI AS ITE_SIGUNI, ';

  strSQL := strSQL + '  F.ITE_CODTAB, ';

  If blnPermitirCompradorEscolherCodigoFabrica Then
  Begin
    If (fRetornaCodigoFabricaProduto = 'P') Then
      strSQL := strSQL + fRetornaSQLCodigoFabricaProduto('I')
    Else
      strSQL := strSQL + fRetornaSQLCodigoFabricaProduto('F');
  End
  Else
  Begin
    If fCfgSis('CODFIT', varBoolean) Then
    Begin
      strSQL := strSQL + '  I.ITE_CODFAB AS ITE_CODFAB, ';
    End
    Else
    Begin
      If fCfgSis('TABPRF', varBoolean) Then
        strSQL := strSQL + '    IF(IFNULL(F.ITE_CODFAB,"") = "", I.ITE_CODFAB, F.ITE_CODFAB) AS ITE_CODFAB, '
      Else
        strSQL := strSQL + '    IF(IFNULL(F.ITE_CODITF,"") = "", I.ITE_CODFAB, F.ITE_CODITF) AS ITE_CODFAB, ';
    End;
  End;

  strSQL := strSQL + '  IF(IFNULL(F.ITE_CLAIPI, "") = "", I.ITE_CLAIPI, F.ITE_CLAIPI) AS ITE_CLAIPI, ';

  strSQl := strSQL + ' ITE_PRAVAL, ';


  strSQL := strSQL + ' IF(F.ITE_CODITE IS NULL, IF(IFNULL(I.ITE_MLTCOM, 0) <> 0, I.ITE_MLTCOM, 1), ';
  strSQL := strSQL + '                          IF(IFNULL(F.ITE_MLTCOM, 0) <> 0, F.ITE_MLTCOM, IFNULL(I.ITE_MLTCOM, 1))) AS ITE_MLTCOM, ';

  If recOpcGir.recNivEst.nivEstoque = nivGiroFornecedor then
    strSQL := strSQL + '  I.ITE_NVLFOR AS ITE_NVLGIR, '
  Else If fCfgSis('TIPGIR') = 'S' Then
    strSQL := strSQL + '  G.ITE_NIVGIR AS ITE_NVLGIR, '
  Else
    strSQL := strSQL + '  I.ITE_NVLGIR, ';

  If fCfgSis('TIPCRI') = 'S' Then
    strSQL := strSQL + '  G.ITE_NIVCRI AS ITE_NVLCRI, '
  Else
    strSQL := strSQL + '  I.ITE_NVLCRI, ';

  strSQL := strSQL + '  G.ITE_DTAUVE, ';
  strSQL := strSQL + '  G.ITE_PREUVE, ';
  strSQL := strSQL + '  G.ITE_QTDUVE, ';

  strSQL := strSQL + '  G.ITE_ESTMIN, ';
  strSQL := strSQL + '  G.ITE_ESTMAX, ';
  strSQL := strSQL + '  G.ITE_PMED_V, ';

  strSQL := strSQL + '  G.ITE_MINDIG, ';
  strSQL := strSQL + '  G.ITE_MAXDIG, ';

  strSQL := strSQL + '  G.ITE_PONPED, ';
  strSQL := strSQL + '  G.ITE_SALDOS, ';

  strSQL := strSQL + '  G.ITE_PREULT, ';
  strSQL := strSQL + '  G.ITE_IMPULT, ';
  strSQL := strSQL + '  G.ITE_QTDUCO, ';
  strSQL := strSQL + '  G.ITE_FORULT, ';
  strSQL := strSQL + '  UF.FOR_NOMFOR AS ITE_NOMFOR, ';
  strSQL := strSQL + '  G.ITE_DTAULT, ';

  strSQL := strSQL + '  G.ITE_PONEXP, ';

  strSQL := strSQL + '  I.ITE_CODMAR, ';
  strSQL := strSQL + '  I.ITE_CODBAR, ';
  strSQL := strSQL + '    MAR_DESMAR, ';
  strSQL := strSQL + '  I.ITE_CODSIM, ';
  strSQL := strSQL + '  I.ITE_INCPIS, ';
  strSQL := strSQL + '  G.ITE_ESMIDG, ';

  strSQL := strSQL + '  G.ITE_CICMDE, ';
  strSQL := strSQL + '  G.ITE_CDPIOP, ';
  strSQL := strSQL + '  G.ITE_DIDIOP, ';
  strSQL := strSQL + '  CONCAT(COALESCE(GRU_DRELIN, ''''), '' - '', COALESCE(GRU_DESGRU, '''')) AS ITE_DESGRU,';
  strSQL := strSQL + '  I.ITE_DESSIM, ';
  strSQL := strSQL + ' IF(I.ITE_CODFOR = "' + recOpcGir.strCodFor +'", "*", "") AS ITE_PRINCI, ';


  strSQL := strSQL + ' PCD_QTDINC, ';
  strSQL := strSQL + ' PCD_TRAINC, ';

  strSQL := strSQL + '  PD.AUTOINCREM AS "AUTINCPCD", ';

  If blnRecupera Then
  Begin
    strSQL := strSQL + '  "S" AS RECUPERADO, ';

    strSQL := strSQL + '  IFNULL((SELECT ORI.AUTOINCREM FROM PCMDET ORI WHERE ORI.PCD_CODITE = I.ITE_CODITE  ';
    strSQL := strSQL + '                                                  AND ORI.PCD_CODEMP = PD.PCD_CODEMP ';
    strSQL := strSQL + '                                                  AND ORI.PCD_NUMPED = PD.PCD_NUMPED ';
    strSQL := strSQL + '                                                  AND ORI.PCD_ESPDOC = PD.PCD_ESPDOC LIMIT 1), PD.AUTOINCREM) AS "AUTOINCREM", ';

    strSQL := strSQL + '  IF((SELECT COUNT(*) FROM PCMDET ORI WHERE ORI.PCD_CODITE = I.ITE_CODITE  ';
    strSQL := strSQL + '                                        AND ORI.PCD_CODEMP = PD.PCD_CODEMP ';
    strSQL := strSQL + '                                        AND ORI.PCD_NUMPED = PD.PCD_NUMPED ';
    strSQL := strSQL + '                                        AND ORI.PCD_ESPDOC = PD.PCD_ESPDOC) > 0, "S", "N") AS ITE_GRAVAD, '
  End Else
  Begin
    strSQL := strSQL + '  "N" AS RECUPERADO, ';

    strSQL := strSQL + '  PD.AUTOINCREM AS "AUTOINCREM", ';
    strSQL := strSQL + '  "S"           AS ITE_GRAVAD,   ';
  End;

  strSQL := strSQL +  fSQLEmbala('I', 'F', 'PCD_CODFOR', False) +   ' AS ITE_EMBALA, ';

  If fCfgSis('TIPABF') = '1' Then
    strSQL := strSQL + ' I.ITE_CODABF, '
  Else
    strSQL := strSQL + ' G.ITE_CODABF, ';

  strSQL := strSQL + ' I.ITE_REFERE, ';

  strSQL := strSQL + '  I.ITE_PESOIT AS ITE_PESORI, ';

  strSQL := strSQL + '  (IF(PCD_QTDITE - PCD_QTDBAI > 0, PCD_QTDITE - PCD_QTDBAI, 0) * UNI_PESLIT / :LITGAL) AS ITE_LITROS, ';
  strSQL := strSQL + '  (IF(PCD_QTDITE - PCD_QTDBAI > 0, PCD_QTDITE - PCD_QTDBAI, 0) * I.ITE_PESOIT * ' + fSQLEmbalagemPedido + ') AS ITE_PESOIT, ';

  strSQL := strSQL + '  IF(LOCATE("ITEM ESPECIAL", ITE_DESITE) > 0, "S", "N") AS ITE_ITEESP, ';
  strSQL := strSQL + '  "   " AS ITE_PEDTXT, ';
  strSQL := strSQL + '  PCD_CODACA AS ITE_CODACA, ';
  strSQL := strSQL + '  PCD_EMPACA AS ITE_EMPACA, ';
  strSQL := strSQL + '  PCD_PROACA AS ITE_PROACA, ';
  strSQL := strSQL + '  G.ITE_CPRCEN AS ITE_CPRCEN, ';
  strSQL := strSQL + '  IFNULL(G.ITE_EMPCEN, "' + fCfgSis('EMPMAT') + '") AS ITE_EMPCEN, ';

  strSQL := strSQL + '  G.ITE_LOCFIS AS ITE_LOCFIS, ';
  strSQL := strSQL + '  PCD_QTDCON   AS ITE_QTDCON, ';
  strSQL := strSQL + '  PCD_SEQFDO   AS ITE_SEQFDO, ';

  strSQL := strSQL + fGetCodSitFornecedorSQL       + ' AS ITE_CODSIT, ';
  strSQL := strSQL + fGetCodSitOrigemFornecedorSQL + ' AS ITE_SITORI, ';

  // Carrega os autoincremento da tabela PCMIRQ, (ligação com as requisições de compra)
  If blnRecupera Then
  Begin
    strSQL := strSQL + '  IFNULL((SELECT GROUP_CONCAT(DISTINCT PCM_SEQREQ) ';
    strSQL := strSQL + '  FROM ';
    strSQL := strSQL + '    PCMIRQ_RES ';
    strSQL := strSQL + '  INNER JOIN MOVRCD M ON M.AUTOINCREM = PCM_SEQREQ ';
    strSQL := strSQL + '  WHERE ';
    strSQL := strSQL + '     PCM_SEQDET = PD.AUTOINCREM), "") AS ITE_INCIRQ, ';

    strSQL := strSQL + '  IFNULL((SELECT SUM(RCD_QTDITE) ';
    strSQL := strSQL + '          FROM ';
    strSQL := strSQL + '            MOVRCD M ';
    strSQL := strSQL + '          INNER JOIN PCMIRQ_RES ON M.AUTOINCREM = PCM_SEQREQ ';
    strSQL := strSQL + '          WHERE ';
    strSQL := strSQL + '            PCM_SEQDET = PD.AUTOINCREM), 0.00) - ';

    strSQL := strSQL + '  IFNULL((SELECT SUM(BAI_QTDREQ) ';
    strSQL := strSQL + '          FROM ';
    strSQL := strSQL + '            BAIREQ  ';
    strSQL := strSQL + '          WHERE ';
    strSQL := strSQL + '            BAI_AUTPED = PD.AUTOINCREM), 0.00) AS ITE_QTDREQ, ';

  End Else
  Begin
    strSQL := strSQL + '  IFNULL((SELECT GROUP_CONCAT(DISTINCT PCM_SEQREQ) ';
    strSQL := strSQL + '   FROM ';
    strSQL := strSQL + '   PCMIRQ ';
    strSQL := strSQL + '   WHERE ';
    strSQL := strSQL + '     PCM_SEQDET = PD.AUTOINCREM), "") AS ITE_INCIRQ, ';

    strSQL := strSQL + '  IFNULL((SELECT SUM(RCD_QTDITE) ';
    strSQL := strSQL + '          FROM ';
    strSQL := strSQL + '            MOVRCD ';
    strSQL := strSQL + '          WHERE ';
    strSQL := strSQL + '            RCD_SEQPCD = PD.AUTOINCREM), 0.00) - ';

    strSQL := strSQL + '  IFNULL((SELECT SUM(BAI_QTDREQ) ';
    strSQL := strSQL + '          FROM ';
    strSQL := strSQL + '            BAIREQ  ';
    strSQL := strSQL + '          WHERE ';
    strSQL := strSQL + '            BAI_AUTPED = PD.AUTOINCREM), 0.00) AS ITE_QTDREQ, ';
  End;

  {****************************************************}
  {* CASO NAO POSSUA PRECO ESPECIAL PARA O FORNECEDOR *}
  {* IRA PEGAR O PRECO DE SUGESTAO DA CONFIGURACAO    *}
  {*************************************************JC*}
  strSQL := strSQL + '  IFNULL( ( SELECT              ';
  strSQL := strSQL + '              FPR_VALITE        ';
  strSQL := strSQL + '            FROM                ';
  strSQL := strSQL + '              FORPRE            ';
  strSQL := strSQL + '            WHERE               ';
  strSQL := strSQL + '              FPR_CODFOR = PCD_CODFOR AND ';
  strSQL := strSQL + '              FPR_CODITE = PCD_CODITE ),   ';

  {******************************************}
  {* SE NAO ESTIVER CONFIGURADO O "UNIPCG"  *}
  {* ENTAO SERÁ UTILIZADO O VALOR DE COMPRA *}
  {* CONFIGURACAO UNIPCG = 1                *}
  {***************************************AN*}
  Case strUniPcg[1] Of
     '2',
     '6',
     '7': Begin
            strSQL := strSQL + ' IF(D.ITE_CODITE IS NULL, G.ITE_PRECOM, D.ITE_PRECOM / IF(IFNULL(F.ITE_CNVCUS, 0) <> 0, F.ITE_CNVCUS, 1)) * ';
            strSQL := strSQL + ' ( 1 - (IF(D.ITE_CODITE IS NULL, G.ITE_DESF01, D.ITE_DESF01) / 100) ) * ';
            strSQL := strSQL + ' ( 1 - (IF(D.ITE_CODITE IS NULL, G.ITE_DESF02, D.ITE_DESF02) / 100) ) * ';
            strSQL := strSQL + ' ( 1 - (IF(D.ITE_CODITE IS NULL, G.ITE_DESF03, D.ITE_DESF03) / 100) ) * ';
            strSQL := strSQL + ' ( 1 - (IF(D.ITE_CODITE IS NULL, G.ITE_DESF04, D.ITE_DESF04) / 100) ) * ';
            strSQL := strSQL + ' ( 1 - (IF(D.ITE_CODITE IS NULL, G.ITE_DESF05, D.ITE_DESF05) / 100) ) * ';
            strSQL := strSQL + ' ( 1 - (IF(D.ITE_CODITE IS NULL, G.ITE_DESF06, D.ITE_DESF06) / 100) ) ';
          End;

     '3': Begin
            strSQL := strSQL + ' IF(D.ITE_CODITE IS NULL, G.ITE_PRECUS, D.ITE_PRECUS)  ';
          End;

     '4': Begin
            strSQL := strSQL + ' IF(D.ITE_CODITE IS NULL, G.ITE_PRECOM, D.ITE_PRECOM / IF(IFNULL(F.ITE_CNVCUS, 0) <> 0, F.ITE_CNVCUS, 1)) * ';
            strSQL := strSQL + ' ( 1 - (IF(D.ITE_CODITE IS NULL, G.ITE_DESF01, D.ITE_DESF01) / 100) ) * ';
            strSQL := strSQL + ' ( 1 - (IF(D.ITE_CODITE IS NULL, G.ITE_DESF02, D.ITE_DESF02) / 100) ) * ';
            strSQL := strSQL + ' ( 1 - (IF(D.ITE_CODITE IS NULL, G.ITE_DESF03, D.ITE_DESF03) / 100) ) * ';
            strSQL := strSQL + ' ( 1 - (IF(D.ITE_CODITE IS NULL, G.ITE_DESF04, D.ITE_DESF04) / 100) ) * ';
            strSQL := strSQL + ' ( 1 - (IF(D.ITE_CODITE IS NULL, G.ITE_DESF05, D.ITE_DESF05) / 100) ) * ';
            strSQL := strSQL + ' ( 1 - (IF(D.ITE_CODITE IS NULL, G.ITE_DESF06, D.ITE_DESF06) / 100) ) * ';
            strSQL := strSQL + ' ( 1 + (IF(D.ITE_CODITE IS NULL, G.ITE_ACRFIN, D.ITE_ACRFIN) / 100) ) ';
          End;

     '8': Begin
            strSQL := strSQL + ' G.ITE_PREULT ';
          End;

     Else Begin
            { QUANDO UNIPCG = ' ' OU = 1 }
            strSQL := strSQL + ' IF(D.ITE_CODITE IS NULL, G.ITE_PRECOM, D.ITE_PRECOM)  ';
          End;

  End;

  If blnUtiInd Then
     strSQL := strSQL + ' * IF(IF(D.ITE_CODITE IS NULL, G.ITE_PREDOL, D.ITE_PREDOL) = "S", (SELECT MOE_DOLVEN FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1), 1) ';

  strSQL := strSQL + ' ) AS ITE_UNIORI, ';

  strSQL := strSQL + '  FP.FOR_NOMFOR ITE_FORPRI, ';
  strSQL := strSQL + '  DP.DEP_DESCRI ITE_DEPART ';

  If blnSitPro  And blnCorIpd Then
  Begin
    strSQL := strSQL + ', SIT_CODIGO, ';
    strSQL := strSQL + '  SIT_CORSIT, ';
    strSQL := strSQL + '  SIT_DESCRI  ';
  End;

  strSQL := strSQL + ', ITE_TIPABS ';
  strSQL := strSQL + ', ITE_VNOLCD ';

  strSQL := strSQL + 'FROM ';

  If blnRecupera Then
    strSQL := strSQL + '  PCMDET_RES PD '
  Else
    strSQL := strSQL + '  PCMDET PD ';

  If blnRecupera Then
    strSQL := strSQL + '  INNER JOIN PCMGER_RES PCG ON PCG.AUTOINCREM = PD.PCD_SEQGER '
  Else
  Begin
    strSQL := strSQL + '  INNER JOIN PCMGER PCG  ON PCG.PCG_NUMPED = PD.PCD_NUMPED ';
    strSQL := strSQL + '                        AND PCG.PCG_CODEMP = PD.PCD_CODEMP ';
    strSQL := strSQL + '                        AND PCG.PCG_ESPDOC = PD.PCD_ESPDOC ';
    strSQL := strSQL + '                        AND PCG.PCG_NUMCTN = 0 ';
  End;
  strSQL := strSQL + '  LEFT JOIN CADUNI ON PCD_CODUNI = UNI_CODUNI ';

  strSQL := strSQL + '  INNER JOIN CADITE I ON PCD_CODITE = I.ITE_CODITE ';

  strSQL := strSQL + '  LEFT JOIN CADMAR ON MAR_CODMAR = I.ITE_CODMAR    ';
  strSQL := strSQL + '  LEFT JOIN CADGRU ON GRU_CODGRU = ITE_CODGRU      ';


  strSQL := strSQL + '  JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE AND ';
  strSQL := strSQL + '                   G.ITE_CODEMP = :EMPDES          ';

  If fCfgSis('TABPRF', varBoolean) Then
  Begin
    strSQL := strSQL + '  LEFT JOIN (SELECT * FROM ITEFOR F WHERE F.ITE_CODFAB IS NOT NULL ';
    strSQL := strSQL + '                  AND (SELECT COUNT(*) FROM TABPRE     ';
    strSQL := strSQL + '                       WHERE F.ITE_CODTAB = TAB_CODTAB AND' + fSqlWhereTabPre(strPrF_AE, recOpcGir.strCodTab) + ') > 0 ';
    strSQL := strSQL + '   GROUP BY F.ITE_CODFAB) F ON F.ITE_CODITE = I.ITE_CODITE         ';
    strSQL := strSQL + '                           AND F.ITE_CODFOR = PCD_CODFOR              ';
  End Else
  Begin
    strSQL := strSQL + '  LEFT JOIN ITEFOR F ON F.ITE_CODITE = I.ITE_CODITE AND ';
    strSQL := strSQL + '                        F.ITE_CODFOR = PCD_CODFOR       ';
    strSQL := strSQL + '                  AND F.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF     ';
    strSQL := strSQL + '                       WHERE FF.ITE_CODITE = I.ITE_CODITE AND ';
    strSQL := strSQL + '                             FF.ITE_CODFOR = PCD_CODFOR)   ';
  End;

  strSQL := strSQL + '  LEFT JOIN TABDET D ON D.ITE_CODTAB = F.ITE_CODTAB ';
  strSQL := strSQL + '                    AND D.ITE_CODITE = F.ITE_CODITE ';
  strSQL := strSQL + '                    AND D.ITE_CODEMP = G.ITE_CODEMP ';

  strSQL := strSQL + '  LEFT JOIN CADFOR UF ON UF.FOR_CODFOR = G.ITE_FORULT ';

  strSQL := strSQL + '  LEFT JOIN CADFOR CF ON CF.FOR_CODFOR = PCD_CODFOR ';

  strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = CF.FOR_CODCID     ';
  strSQL := strSQL + '  LEFT JOIN ABFICM ON ABF_CODABF = ' + IfThen(fCfgSis('TIPABF') = '1', 'I', 'G') + '.ITE_CODABF AND ';
  strSQL := strSQL + '                      ABF_ESTADO = CID_ESTADO     ';

  If blnSitPro And blnCorIpd Then
  Begin
    If fCfgSis('SITEMP') = '1' Then
      strSQL := strSQL + ' LEFT JOIN SITPRO ON I.ITE_SITPRO = SIT_CODIGO '
    Else
      strSQL := strSQL + ' LEFT JOIN SITPRO ON G.ITE_SITPRO = SIT_CODIGO ';
  End;

  strSQL := strSQL +'  LEFT JOIN CADFOR FP ON FP.FOR_CODFOR = I.ITE_CODFOR ';
  strSQL := strSQL +'  LEFT JOIN CADDEP DP ON DP.DEP_CODIGO = I.ITE_CODDEP ';

  strSQL := strSQL + 'WHERE ';

  If blnRecupera Then
  Begin

    strSQL := strSQL + '  PCD_SEQGER = ' + objCopiaSeg.recPcmger.strAutInc;

    If Not blnNovoReg Then
      strSQL := strSQL + '  AND EXCLUIDO <> "S" ';

  End Else
  Begin

    strSQL := strSQL + '  PCD_BAIXAD = 0 AND ';
    strSQL := strSQL + '  PCD_NUMCTN = 0 AND ';
    strSQL := strSQL + '  PCD_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCD_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  PCD_ESPDOC = :ESPDOC ';

    If objCopiaSeg.recPcmger.blnRecuperaPedido Then
    Begin
      strSQL := strSQL + ' AND (SELECT COUNT(*) FROM PCMDET_RES R ';
      strSQL := strSQL + '      WHERE R.PCD_CODITE = PD.PCD_CODITE ';
      strSQL := strSQL + '        AND R.PCD_DESITE = PD.PCD_DESITE';
      strSQL := strSQL + '        AND R.PCD_SEQGER = ' + QuotedStr(objCopiaSeg.recPcmger.strAutInc) + ') = 0 ';
    End;

  End;

  Result := strSQL;
End;

Function TfrmPedidoDeCompra.fSQLBuscaRequisicaoPcddetRes: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT        ';
  strSQL := strSQL + '   PCD_INCIRQ  ';
  strSQL := strSQL + ' FROM          ';
  strSQL := strSQL + '   PCDDET_RES               ';
  strSQL := strSQL + ' WHERE                      ';
  strSQL := strSQL + '      PCD_SEQPCG = :SEQPCG  ';
  strSQL := strSQL + '  AND PCD_CODITE = :CODITE  ';
  strSQL := strSQL + '  AND PCD_EMPDES = :CODEMP  ';

  Result := strSQL;
End;

Function TfrmPedidoDeCompra.fCarregaItensPedidoAux(pgbProgresso: TcxProgressBar): Boolean;
  Var
    strEmpSaldos,
    strIndexSave,
    strEmpDes,
    strSQL: String;

    qryPcddetRes: TUniQuery;

    pBeforePostMultLoja: TDataSetNotifyEvent;
    lStrNumPed: String;
begin
  Try
    qryPcddetRes := fCriaQuery;
    qryPcddetRes.SQL.Text := fSQLBuscaRequisicaoPcddetRes;

    pgbProgresso.Properties.Max := 0;
    pgbProgresso.Position := 0;
    Application.ProcessMessages;
    lStrNumPed := '';

    With qryPcmDet Do
    Begin
      strSQL := '';

      If Not blnNovoReg Then
        strSQL := fSQLItensPedido(False);

      If objCopiaSeg.recPcmger.blnRecuperaPedido Then
      Begin

        If Not blnNovoReg Then
          strSQL := strSQL + ' UNION ';

        strSQL := strSQL + fSQLItensPedido(True);

      End;

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Params.FindParam('NUMPED') <> Nil Then
      begin
        ParamByName('NUMPED').AsString := qryPcmGer.FieldByName('PCG_NUMPED').AsString;
        lStrNumPed := qryPcmGer.FieldByName('PCG_NUMPED').AsString;
      End;


      If Params.FindParam('CODEMP') <> Nil Then
        ParamByName('CODEMP').AsString := qryPcmGer.FieldByName('PCG_CODEMP').AsString;

      If Params.FindParam('ESPDOC') <> Nil Then
        ParamByName('ESPDOC').AsString := qryPcmGer.FieldByName('PCG_ESPDOC').AsString;

      ParamByName('DECUNI').AsInteger := intDecUni;

      strEmpDes := fRetEmpresaDestino;

      ParamByName('EMPDES').AsString := strEmpDes;

      If SameText(strLitGal, 'L') Then
        ParamByName('LITGAL').AsFloat := 1
      Else
        ParamByName('LITGAL').AsFloat := FLT_LITRO_GALAO;

    End;

    qryPcmDet.Open;

    If Not blnNovoReg Then
      cdsItensPedido.EmptyDataSet;

    If Not objCopiaSeg.recPcmger.blnRecuperaPedido Then
      recOpcGir.strPedMlj := qryPcmGer.FieldByName('PCG_PEDMLJ').AsString;

    If (recOpcGir.strPedMlj = 'S') And Assigned(cdsItensMultiLojas) Then
    Begin
      strIndexSave := cdsItensMultiLojas.IndexFieldNames;

      If (fltLimAma > 0) Then
        cdsItensMultiLojas.IndexFieldNames := 'ITE_CODITE';
    End;

    cdsItensPedido.DisableControls;
    cdsItensPedido.First;

    pgbProgresso.Properties.Max := qryPcmDet.RecordCount;
    Application.ProcessMessages;

    {*****************************************}
    {* ATUALIZA O TOTAL DE IMPOSTOS          *}
    {**************************************MV*}
    While (Not qryPcmDet.Eof) Do
    Begin

      If objCopiaSeg.recPcmger.blnRecuperaPedido Then
      Begin

        If blnNovoReg And cdsItensPedido.Locate('ITE_CODITE', qryPcmDet.FieldByName('ITE_CODITE').AsString, []) Then
        Begin

          If qryPcmDet.FieldByName('EXCLUIDO').AsString = 'S' Then
          Begin

            pRetiraDaListaConsulta(qryPcmDet.FieldByName('ITE_CODITE').AsString);

            cdsItensPedido.Delete;

            qryPcmDet.Next;
            pgbProgresso.Position := pgbProgresso.Position + 1;
            Application.ProcessMessages;
            Continue;

          End Else
          Begin

            cdsItensPedido.Edit;

          End;

        End Else
        Begin

          If qryPcmDet.FieldByName('EXCLUIDO').AsString = 'S' Then
          Begin

            qryPcmDet.Next;
            pgbProgresso.Position := pgbProgresso.Position + 1;
            Application.ProcessMessages;
            Continue;

          End Else
          Begin

            cdsItensPedido.Append;
            cdsItensPedido.FieldByName('ITE_INCIRQ').AsString := '';
            cdsItensPedido.FieldByName('ITE_QTDREQ').AsFloat  := 0;
            cdsItensPedido.FieldByName('ITE_QATREQ').AsFloat  := 0;
            cdsItensPedido.FieldByName('ITE_QTDTRA').AsFloat  := 0;
            cdsItensPedido.FieldByName('ITE_TRAINC').AsFloat  := 0;
          End;

        End;

      End Else
      Begin

        cdsItensPedido.Append;
        cdsItensPedido.FieldByName('ITE_INCIRQ').AsString := '';
        cdsItensPedido.FieldByName('ITE_QTDREQ').AsFloat  := 0;
        cdsItensPedido.FieldByName('ITE_QATREQ').AsFloat  := 0;
        cdsItensPedido.FieldByName('ITE_QTDTRA').AsFloat  := 0;
        cdsItensPedido.FieldByName('ITE_TRAINC').AsFloat  := 0;

      End;

      If (Not objCopiaSeg.recPcmger.blnRecuperaPedido) or (cdsItensPedido.State =  dsInsert) Then
        cdsItensPedido.FieldByName('ITE_PONEXP').AsFloat := fCarregaPontoExposicao(qryPcmDet.FieldByName('ITE_CODITE').AsString,
                                                                                   recOpcGir.strEmpGir);

      cdsItensPedido.FieldByName('ITE_GRAVAD').AsString   := qryPcmDet.FieldByName('ITE_GRAVAD').AsString;

      cdsItensPedido.FieldByName('ITE_BAIPED').AsFloat    := qryPcmDet.FieldByName('ITE_BAIPED').AsFloat;
      cdsItensPedido.FieldByName('ITE_BAINOT').AsString   := qryPcmDet.FieldByName('ITE_BAINOT').AsString;

      cdsItensPedido.FieldByName('ITE_QTDEMB').AsFloat    := qryPcmDet.FieldByName('PCD_EMBALA').AsFloat;
      cdsItensPedido.FieldByName('ITE_EMBALA').AsFloat    := qryPcmDet.FieldByName('ITE_EMBALA').AsFloat;
      cdsItensPedido.FieldByName('ITE_CODITE').AsString   := qryPcmDet.FieldByName('ITE_CODITE').AsString;
      cdsItensPedido.FieldByName('ITE_SUBUSU').AsString   := qryPcmDet.FieldByName('ITE_SUBUSU').AsString;
      cdsItensPedido.FieldByName('ITE_PRINCI').AsString   := qryPcmDet.FieldByName('ITE_PRINCI').AsString;

      cdsItensPedido.FieldByName('ITE_CICMDE').AsString   := qryPcmDet.FieldByName('ITE_CICMDE').AsString;
      cdsItensPedido.FieldByName('ITE_CDPIOP').AsString   := qryPcmDet.FieldByName('ITE_CDPIOP').AsString;
      cdsItensPedido.FieldByName('ITE_DIDIOP').AsString   := qryPcmDet.FieldByName('ITE_DIDIOP').AsString;

      cdsItensPedido.FieldByName('ITE_CODTAB').AsString   := qryPcmDet.FieldByName('ITE_CODTAB').AsString;
      cdsItensPedido.FieldByName('ITE_CODGRU').AsString   := qryPcmDet.FieldByName('ITE_CODGRU').AsString;
      cdsItensPedido.FieldByName('ITE_CNDPAG').AsString   := qryPcmDet.FieldByName('ITE_CNDPAG').AsString;
      cdsItensPedido.FieldByName('ITE_DESITE').AsString   := qryPcmDet.FieldByName('ITE_DESITE').AsString;
      cdsItensPedido.FieldByName('ITE_APLICA').AsString   := qryPcmDet.FieldByName('ITE_APLICA').AsString;
      cdsItensPedido.FieldByName('ITE_DIAFOR').AsInteger  := qryPcmDet.FieldByName('ITE_DIAFOR').AsInteger;
      cdsItensPedido.FieldByName('ITE_REFERE').AsString   := qryPcmDet.FieldByName('ITE_REFERE').AsString;

      cdsItensPedido.FieldByName('ITE_LOCFIS').AsString   := qryPcmDet.FieldByName('ITE_LOCFIS').AsString;
      cdsItensPedido.FieldByName('ITE_INCPIS').AsString   := qryPcmDet.FieldByName('ITE_INCPIS').AsString;
      cdsItensPedido.FieldByName('ITE_ESMIDG').AsString   := qryPcmDet.FieldByName('ITE_ESMIDG').AsString;
      cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat    := qryPcmDet.FieldByName('ITE_QTDITE').AsFloat;

      If objCopiaSeg.recPcmger.blnRecuperaPedido or (not fEmptyStr(lStrNumPed)) Then
        cdsItensPedido.FieldByName('ITE_QTDINC').AsFloat    := qryPcmDet.FieldByName('PCD_QTDINC').AsFloat
      Else
        cdsItensPedido.FieldByName('ITE_QTDINC').AsFloat    := qryPcmDet.FieldByName('ITE_QTDITE').AsFloat;

      cdsItensPedido.FieldByName('ITE_QTDTRA').AsFloat    := qryPcmDet.FieldByName('PCD_TRAINC').AsFloat;

      cdsItensPedido.FieldByName('ITE_QTDCON').AsFloat    := qryPcmDet.FieldByName('ITE_QTDCON').AsFloat;
      cdsItensPedido.FieldByName('ITE_UNITAR').AsFloat    := qryPcmDet.FieldByName('ITE_UNITAR').AsFloat;
      cdsItensPedido.FieldByName('ITE_DESUNI').AsFloat    := qryPcmDet.FieldByName('ITE_DESUNI').AsFloat;
      cdsItensPedido.FieldByName('ITE_DESUN2').AsFloat    := qryPcmDet.FieldByName('ITE_DESUN2').AsFloat;
      cdsItensPedido.FieldByName('ITE_DESUN3').AsFloat    := qryPcmDet.FieldByName('ITE_DESUN3').AsFloat;
      cdsItensPedido.FieldByName('ITE_DESUN4').AsFloat    := qryPcmDet.FieldByName('ITE_DESUN4').AsFloat;
      cdsItensPedido.FieldByName('ITE_DESUN5').AsFloat    := qryPcmDet.FieldByName('ITE_DESUN5').AsFloat;
      cdsItensPedido.FieldByName('ITE_DESUN6').AsFloat    := qryPcmDet.FieldByName('ITE_DESUN6').AsFloat;

      cdsItensPedido.FieldByName('ITE_TOTITE').AsFloat    := qryPcmDet.FieldByName('ITE_TOTITE').AsFloat;
      cdsItensPedido.FieldByName('ITE_UNILIQ').AsFloat    := qryPcmDet.FieldByName('ITE_UNILIQ').AsFloat;
      cdsItensPedido.FieldByName('ITE_DIFPRE').AsFloat    := qryPcmDet.FieldByName('ITE_DIFPRE').AsFloat;

      cdsItensPedido.FieldByName('ITE_PERIPI').AsFloat    := qryPcmDet.FieldByName('ITE_PERIPI').AsFloat;

      If (qryPcmGer.FieldByName('PCG_PEDIMP').AsString = 'S') Then
      Begin
        cdsItensPedido.FieldByName('ITE_ALQIMP').AsFloat    := qryPcmDet.FieldByName('ITE_ALQIMP').AsFloat;
        cdsItensPedido.FieldByName('ITE_VALIMP').AsFloat    := qryPcmDet.FieldByName('ITE_VALIMP').AsFloat;

        cdsItensPedido.FieldByName('ITE_ALQPIS').AsFloat    := qryPcmDet.FieldByName('ITE_ALQPIS').AsFloat;
        cdsItensPedido.FieldByName('ITE_BASPIS').AsFloat    := qryPcmDet.FieldByName('ITE_BASPIS').AsFloat;
        cdsItensPedido.FieldByName('ITE_VALPIS').AsFloat    := qryPcmDet.FieldByName('ITE_VALPIS').AsFloat;

        cdsItensPedido.FieldByName('ITE_ALQCOF').AsFloat    := qryPcmDet.FieldByName('ITE_ALQCOF').AsFloat;
        cdsItensPedido.FieldByName('ITE_BASCOF').AsFloat    := qryPcmDet.FieldByName('ITE_BASCOF').AsFloat;
        cdsItensPedido.FieldByName('ITE_VALCOF').AsFloat    := qryPcmDet.FieldByName('ITE_VALCOF').AsFloat;

        cdsItensPedido.FieldByName('ITE_BASIPI').AsFloat    := qryPcmDet.FieldByName('ITE_TOTITE').AsFloat + qryPcmDet.FieldByName('ITE_VALIMP').AsFloat;
        cdsItensPedido.FieldByName('ITE_TOTIPI').AsFloat    := qryPcmDet.FieldByName('ITE_TOTIPI').AsFloat;
      End
      Else
      Begin
        fltAlqPis := fAliquotaPisCofinsProduto(qryPcmDet.FieldByName('ITE_CODITE').AsString, True);
        fltAlqCof := fAliquotaPisCofinsProduto(qryPcmDet.FieldByName('ITE_CODITE').AsString, False);
        cdsItensPedido.FieldByName('ITE_BASPIS').AsFloat    := qryPcmDet.FieldByName('ITE_BASPIS').AsFloat;
        cdsItensPedido.FieldByName('ITE_VALPIS').AsFloat    := RoundTo((fltAlqPis * qryPcmDet.FieldByName('ITE_BASPIS').AsFloat) / 100, -2);

        cdsItensPedido.FieldByName('ITE_BASCOF').AsFloat    := qryPcmDet.FieldByName('ITE_BASCOF').AsFloat;
        cdsItensPedido.FieldByName('ITE_VALCOF').AsFloat    := RoundTo((fltAlqCof * qryPcmDet.FieldByName('ITE_BASCOF').AsFloat) / 100, -2);

        cdsItensPedido.FieldByName('ITE_BASIPI').AsFloat    := qryPcmDet.FieldByName('ITE_BASIPI').AsFloat;
        cdsItensPedido.FieldByName('ITE_TOTIPI').AsFloat :=
          RoundTo(cdsItensPedido.FieldByName('ITE_BASIPI').AsFloat *
                cdsItensPedido.FieldByName('ITE_PERIPI').AsFloat / 100, -2);
      End;
      cdsItensPedido.FieldByName('ITE_BASSUB').AsFloat    := qryPcmDet.FieldByName('ITE_BASSUB').AsFloat;
      cdsItensPedido.FieldByName('ITE_PERSUB').AsFloat    := qryPcmDet.FieldByName('ITE_PERSUB').AsFloat;
      cdsItensPedido.FieldByName('ITE_TOTSUB').AsFloat    := qryPcmDet.FieldByName('ITE_TOTSUB').AsFloat;
      cdsItensPedido.FieldByName('ITE_TOTDAR').AsFloat    := qryPcmDet.FieldByName('ITE_TOTDAR').AsFloat;

      cdsItensPedido.FieldByName('ITE_PERFCP').AsFloat    := qryPcmDet.FieldByName('ITE_PERFCP').AsFloat;
      cdsItensPedido.FieldByName('ITE_SUBFCP').AsFloat    := qryPcmDet.FieldByName('ITE_SUBFCP').AsFloat;

      cdsItensPedido.FieldByName('ITE_UNIIMP').AsFloat    := qryPcmDet.FieldByName('ITE_UNIIMP').AsFloat;

      cdsItensPedido.FieldByName('ITE_BASICM').AsFloat    := qryPcmDet.FieldByName('ITE_BASICM').AsFloat;
      cdsItensPedido.FieldByName('ITE_PERBAS').AsFloat    := qryPcmDet.FieldByName('ITE_PERBAS').AsFloat;
      cdsItensPedido.FieldByName('ITE_ALQICM').AsFloat    := qryPcmDet.FieldByName('ITE_ALQICM').AsFloat;
      cdsItensPedido.FieldByName('ITE_VALICM').AsFloat    := qryPcmDet.FieldByName('ITE_VALICM').AsFloat;
      cdsItensPedido.FieldByName('ITE_DESPIS').AsFloat    := qryPcmDet.FieldByName('ITE_DESPIS').AsFloat;

      cdsItensPedido.FieldByName('ITE_QTDBAI').AsFloat    := qryPcmDet.FieldByName('ITE_QTDBAI').AsFloat;
      cdsItensPedido.FieldByName('ITE_TOTBAI').AsFloat    := qryPcmDet.FieldByName('ITE_TOTBAI').AsFloat;
      cdsItensPedido.FieldByName('ITE_IPIBAI').AsFloat    := qryPcmDet.FieldByName('ITE_IPIBAI').AsFloat;
      cdsItensPedido.FieldByName('ITE_SUBBAI').AsFloat    := qryPcmDet.FieldByName('ITE_SUBBAI').AsFloat;
      cdsItensPedido.FieldByName('ITE_DARBAI').AsFloat    := qryPcmDet.FieldByName('ITE_DARBAI').AsFloat;

      cdsItensPedido.FieldByName('ITE_VALFRE').AsFloat    := qryPcmDet.FieldByName('ITE_VALFRE').AsFloat;
      cdsItensPedido.FieldByName('ITE_DESACE').AsFloat    := qryPcmDet.FieldByName('ITE_DESACE').AsFloat;

      cdsItensPedido.FieldByName('ITE_DTAPED').AsDateTime := qryPcmDet.FieldByName('DTAPED').AsDateTime;
      cdsItensPedido.FieldByName('ITE_DTAENT').AsDateTime := qryPcmDet.FieldByName('DTAENT').AsDateTime;
      cdsItensPedido.FieldByName('AUTOINCREM').AsString   := qryPcmDet.FieldByName('AUTOINCREM').AsString;

      cdsItensPedido.FieldByName('ITE_CODUNI').AsString   := qryPcmDet.FieldByName('ITE_CODUNI').AsString;
      cdsItensPedido.FieldByName('ITE_SIGUNI').AsString   := qryPcmDet.FieldByName('ITE_SIGUNI').AsString;

      cdsItensPedido.FieldByName('ITE_CODFAB').AsString   := qryPcmDet.FieldByName('ITE_CODFAB').AsString;
      cdsItensPedido.FieldByName('ITE_CODMAR').AsString   := qryPcmDet.FieldByName('ITE_CODMAR').AsString;
      cdsItensPedido.FieldByName('ITE_DESMAR').AsString   := qryPcmDet.FieldByName('MAR_DESMAR').AsString;
      cdsItensPedido.FieldByName('ITE_CODBAR').AsString   := qryPcmDet.FieldByName('ITE_CODBAR').AsString;
      cdsItensPedido.FieldByName('ITE_CODSIM').AsString   := qryPcmDet.FieldByName('ITE_CODSIM').AsString;
      cdsItensPedido.FieldByName('ITE_LITROS').AsFloat    := qryPcmDet.FieldByName('ITE_LITROS').AsFloat;
      cdsItensPedido.FieldByName('ITE_PESOIT').AsFloat    := qryPcmDet.FieldByName('ITE_PESOIT').AsFloat;
      cdsItensPedido.FieldByName('ITE_PESORI').AsFloat    := qryPcmDet.FieldByName('ITE_PESORI').AsFloat;
      cdsItensPedido.FieldByName('ITE_ITEESP').AsString   := qryPcmDet.FieldByName('ITE_ITEESP').AsString;
      cdsItensPedido.FieldByName('ITE_PEDTXT').AsString   := qryPcmDet.FieldByName('ITE_PEDTXT').AsString;
      cdsItensPedido.FieldByName('ITE_CODACA').AsString   := qryPcmDet.FieldByName('ITE_CODACA').AsString;
      cdsItensPedido.FieldByName('ITE_EMPACA').AsString   := qryPcmDet.FieldByName('ITE_EMPACA').AsString;
      cdsItensPedido.FieldByName('ITE_PROACA').AsString   := qryPcmDet.FieldByName('ITE_PROACA').AsString;
      cdsItensPedido.FieldByName('ITE_CLAIPI').AsString   := qryPcmDet.FieldByName('ITE_CLAIPI').AsString;
      cdsItensPedido.FieldByName('ITE_PRAVAL').AsString   := qryPcmDet.FieldByName('ITE_PRAVAL').AsString;
      cdsItensPedido.FieldByName('ITE_CODSIT').AsString   := qryPcmDet.FieldByName('ITE_CODSIT').AsString;
      cdsItensPedido.FieldByName('ITE_SITORI').AsString   := qryPcmDet.FieldByName('ITE_SITORI').AsString;
      cdsItensPedido.FieldByName('ITE_UNIORI').AsFloat    := qryPcmDet.FieldByName('ITE_UNIORI').AsFloat;
      cdsItensPedido.FieldByName('ITE_MLTCOM').AsFloat    := qryPcmDet.FieldByName('ITE_MLTCOM').AsFloat;

      // FICO COM AS INFORMAÇÕES DA ÚLTIMA PASSADA QUE É O RECUPERADO SE HOUVER
      cdsItensPedido.FieldByName('ITE_INCIRQ').AsString   := qryPcmDet.FieldByName('ITE_INCIRQ').AsString;
      cdsItensPedido.FieldByName('ITE_QTDREQ').AsFloat    := qryPcmDet.FieldByName('ITE_QTDREQ').AsFloat;
      cdsItensPedido.FieldByName('ITE_QATREQ').AsFloat    := qryPcmDet.FieldByName('ITE_QTDREQ').AsFloat;

      If qryPcmDet.FieldByName('RECUPERADO').AsString = 'S' Then
        cdsItensPedido.FieldByName('ITE_AUTRES').AsString := qryPcmDet.FieldByName('AUTINCPCD').AsString;

      If blnSitPro And blnCorIpd Then
      Begin
        cdsItensPedido.FieldByName('ITE_DESSIT').AsString := qryPcmDet.FieldByName('SIT_DESCRI').AsString;
        cdsItensPedido.FieldByName('ITE_CORSIT').AsString := qryPcmDet.FieldByName('SIT_CORSIT').AsString;
      End;

      pCarregaUltimaCompraGeral(cdsItensPedido, cdsItensPedido.FieldByName('ITE_CODITE').AsString, recOpcGir.strEmpGir);

      If (Not cdsItensPedido.FieldByName('ITE_DTAULT').IsNull) And (cdsItensPedido.FieldByName('ITE_DTAULT').AsDateTime > 0) Then
        cdsItensPedido.FieldByName('ITE_DIAUCO').AsInteger  := Trunc(VS_Date - cdsItensPedido.FieldByName('ITE_DTAULT').AsDateTime);

      cdsItensPedido.FieldByName('ITE_PREUVE').Value := qryPcmDet.FieldByName('ITE_PREUVE').Value;
      cdsItensPedido.FieldByName('ITE_QTDUVE').Value := qryPcmDet.FieldByName('ITE_QTDUVE').Value;
      cdsItensPedido.FieldByName('ITE_DTAUVE').Value := qryPcmDet.FieldByName('ITE_DTAUVE').Value;

      If (Not cdsItensPedido.FieldByName('ITE_DTAUVE').IsNull) And (cdsItensPedido.FieldByName('ITE_DTAUVE').AsDateTime > 0) Then
        cdsItensPedido.FieldByName('ITE_DIAUVE').AsInteger  := Trunc(VS_Date - cdsItensPedido.FieldByName('ITE_DTAUVE').AsDateTime);

      If (Not blnZerCon) And (cdsItensPedido.FieldByName('ITE_QTDCON').AsFloat > 0) Then
        pAddConferido(cdsItensPedido.FieldByName('ITE_CODITE').AsString,
                      cdsItensPedido.FieldByName('ITE_DESITE').AsString,
                      cdsItensPedido.FieldByName('ITE_QTDCON').AsFloat);

      cdsItensPedido.FieldByName('ITE_ALQCBS').AsFloat    := qryPcmDet.FieldByName('ITE_ALQCBS').AsFloat;
      cdsItensPedido.FieldByName('ITE_ALQIBS').AsFloat    := qryPcmDet.FieldByName('ITE_ALQIBS').AsFloat;
      cdsItensPedido.FieldByName('ITE_ALQ_IS').AsFloat    := qryPcmDet.FieldByName('ITE_ALQ_IS').AsFloat;
      pCalculaImpostosReformaItem(cdsItensPedido, qryPcmGer.FieldByName('PCG_PEDIMP').AsString = 'S');

      cdsItensPedido.FieldByName('ITE_TOTGER').AsFloat := cdsItensPedido.FieldByName('ITE_TOTITE').AsFloat +
                                                          cdsItensPedido.FieldByName('ITE_TOTIPI').AsFloat +
                                                          cdsItensPedido.FieldByName('ITE_TOTSUB').AsFloat +
                                                          cdsItensPedido.FieldByName('ITE_SUBFCP').AsFloat +
                                                          fTotalImpostosReformaItem(cdsItensPedido);

      cdsItensPedido.FieldByName('ITE_NVLGIR').AsString := qryPcmDet.FieldByName('ITE_NVLGIR').AsString;
      cdsItensPedido.FieldByName('ITE_NVLCRI').AsString := qryPcmDet.FieldByName('ITE_NVLCRI').AsString;
      cdsItensPedido.FieldByName('ITE_PMED_V').Value    := qryPcmDet.FieldByName('ITE_PMED_V').Value;

      cdsItensPedido.FieldByName('ITE_PONPED').Value    := qryPcmDet.FieldByName('ITE_PONPED').Value;
      cdsItensPedido.FieldByName('ITE_SEQFDO').Value    := qryPcmDet.FieldByName('ITE_SEQFDO').Value;

      If fEmptyStr(recOpcGir.strEmpGir) Then
      Begin
        cdsItensPedido.FieldByName('ITE_SALDOS').AsFloat  := qryPcmDet.FieldByName('ITE_SALDOS').AsFloat;

        strEmpSaldos := QuotedStr(strEmpDes);
      End Else
      Begin
        cdsItensPedido.FieldByName('ITE_SALDOS').AsFloat  := fRetornaSaldoItem(cdsItensPedido.FieldByName('ITE_CODITE').AsString,
                                                                IIF(recOpcGir.blnAgrSim, cdsItensPedido.FieldByName('ITE_CODSIM').AsString, ''),
                                                                recOpcGir.strEmpGir);

        strEmpSaldos := recOpcGir.strEmpGir;
      End;

      pGetSaldosReservados(cdsSaldos, cdsItensPedido.FieldByName('ITE_CODITE').AsString, strEmpSaldos,
                            (blnUsarGiro Or blnAltPedGir Or (Assigned(recOpcGir.objSalInt) And recOpcGir.objSalInt.blnEncontrouGiro)),
                             recOpcGir);

      cdsItensPedido.FieldByName('ITE_ESTMIN').Value    := cdsSaldos.FieldByName('ITE_ESTMIN').Value;
      cdsItensPedido.FieldByName('ITE_ESTMAX').Value    := cdsSaldos.FieldByName('ITE_ESTMAX').Value;
      cdsItensPedido.FieldByName('ITE_MINDIG').Value    := cdsSaldos.FieldByName('ITE_MINDIG').Value;
      cdsItensPedido.FieldByName('ITE_MAXDIG').Value    := cdsSaldos.FieldByName('ITE_MAXDIG').Value;
      cdsItensPedido.FieldByName('ITE_QTPD_P').AsFloat  := cdsSaldos.FieldByName('ITE_QTPD_P').AsFloat;
      cdsItensPedido.FieldByName('ITE_QTEF_A').AsFloat  := cdsSaldos.FieldByName('ITE_QTEF_A').AsFloat;
      cdsItensPedido.FieldByName('ITE_QTEF_F').AsFloat  := cdsSaldos.FieldByName('ITE_QTEF_F').AsFloat;
      cdsItensPedido.FieldByName('ITE_QTEF_P').AsFloat  := cdsSaldos.FieldByName('ITE_QTEF_P').AsFloat;
      cdsItensPedido.FieldByName('ITE_SALRES').AsFloat  := cdsSaldos.FieldByName('ITE_SALRES').AsFloat;
      cdsItensPedido.FieldByName('ITE_SALEND').AsFloat  := cdsSaldos.FieldByName('ITE_SALEND').AsFloat;
      cdsItensPedido.FieldByName('ITE_SALTRA').AsFloat  := cdsSaldos.FieldByName('ITE_SALTRA').AsFloat;
      cdsItensPedido.FieldByName('ITE_SALGAR').AsFloat  := cdsSaldos.FieldByName('ITE_SALGAR').AsFloat;
      cdsItensPedido.FieldByName('ITE_SALDIS').AsFloat  := cdsSaldos.FieldByName('ITE_SALDIS').AsFloat;
      cdsItensPedido.FieldByName('ITE_SALEXT').AsFloat  := cdsSaldos.FieldByName('ITE_SALEXT').AsFloat;
      cdsItensPedido.FieldByName('ITE_SALBAS').AsFloat  := cdsSaldos.FieldByName('ITE_SALBAS').AsFloat;
      cdsItensPedido.FieldByName('ITE_SALFIS').AsFloat  := cdsSaldos.FieldByName('ITE_SALFIS').AsFloat;
      cdsItensPedido.FieldByName('ITE_SALCOT').AsFloat  := cdsSaldos.FieldByName('ITE_SALCOT').AsFloat;
      cdsItensPedido.FieldByName('ITE_VENPER').AsFloat  := cdsSaldos.FieldByName('ITE_VENPER').AsFloat;
      cdsItensPedido.FieldByName('ITE_QTDPEN').AsFloat  := cdsSaldos.FieldByName('ITE_QTDPEN').AsFloat;
      cdsItensPedido.FieldByName('ITE_SALREQ').AsFloat  := cdsSaldos.FieldByName('ITE_SALREQ').AsFloat;

      If (recOpcGir.strPedMlj <> 'S') And (Not blnUsarGiro) And (Not blnAltPedGir) Then
        pCarrregaDadosGiro(cdsItensPedido, strEmpSaldos, IIF(recOpcGir.blnAgrSim, qryPcmDet.FieldByName('ITE_CODSIM').AsString, ''));

      If recOpcGir.strPedMlj = 'S' Then
      Begin

        If Assigned(cdsItensMultiLojas) Then
        Begin
          pBeforePostMultLoja := cdsItensMultiLojas.BeforePost;
          cdsItensMultiLojas.BeforePost := Nil;

         // If (fltLimAma > 0) Or blnSinMul Then
          Begin

            If (cdsItensMultiLojas.IndexFieldNames <> 'ITE_CODITE') And
              (cdsItensMultiLojas.IndexFieldNames <> 'ITE_CODITE;ITE_CODEMP') Then
                cdsItensMultiLojas.IndexFieldNames := 'ITE_CODITE';

            pIniacializaTotaisItem;

            cdsItensMultiLojas.First;
            cdsItensMultiLojas.Locate('ITE_CODITE', cdsItensPedido.FieldByName('ITE_CODITE').AsString, []);

            pIniacializaTotaisItem;
            pCarregaUltimaCompraGeral(cdsItensPedido, cdsItensPedido.FieldByName('ITE_CODITE').AsString, recOpcGir.strEmpGir);

            While (Not cdsItensMultiLojas.Eof) And
                  (cdsItensPedido.FieldByName('ITE_CODITE').AsString = cdsItensMultiLojas.FieldByName('ITE_CODITE').AsString) Do
            Begin
              pIncrementaTotaisPedido;

              cdsItensMultiLojas.Edit;

              If (qryPcmDet.FieldByName('RECUPERADO').AsString = 'S') And
                 (Not qryPcmDet.FieldByName('ITE_INCIRQ').AsString.IsEmpty) Then
              Begin
                qryPcddetRes.Close;
                qryPcddetRes.ParamByName('CODEMP').AsString := cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString;
                qryPcddetRes.ParamByName('CODITE').AsString := cdsItensMultiLojas.FieldByName('ITE_CODITE').AsString;
                qryPcddetRes.ParamByName('SEQPCG').AsString := objCopiaSeg.recPcmger.strAutInc;
                qryPcddetRes.Open;

                If Not qryPcddetRes.IsEmpty Then
                  cdsItensMultiLojas.FieldByName('ITE_INCIRQ').AsString := qryPcddetRes.FieldByName('PCD_INCIRQ').AsString;
              End;

              cdsItensMultiLojas.FieldByName('ITE_QTDEMB').Value := cdsItensPedido.FieldByName('ITE_QTDEMB').Value;
              cdsItensMultiLojas.Post;

              cdsItensMultiLojas.Next;
            End;

          End;

          cdsItensMultiLojas.BeforePost := pBeforePostMultLoja;
        End; {If Assigned(cdsItensMultiLojas) Then}

      End Else
      Begin

        If (Not blnNovoReg) And Assigned(cdsItensGiroExt) And
           ((cdsItensGiroExt.FieldByName('ITE_CODITE').AsString = cdsItensPedido.FieldByName('ITE_CODITE').AsString) Or
            cdsItensGiroExt.Locate('ITE_CODITE', cdsItensPedido.FieldByName('ITE_CODITE').AsString, [])) Then
        Begin
          cdsItensPedido.FieldByName('ITE_DIAEST').Value := cdsItensGiroExt.FieldByName('ITE_DIAEST').Value;
          cdsItensPedido.FieldByName('ITE_MEDIA_').Value := cdsItensGiroExt.FieldByName('ITE_MEDIA_').Value;

          cdsItensPedido.FieldByName('ITE_DIASAI').Value := cdsItensGiroExt.FieldByName('ITE_DIASAI').Value;

          cdsItensPedido.FieldByName('ITE_AJUSTA').Value := cdsItensGiroExt.FieldByName('ITE_AJUSTA').Value;
          cdsItensPedido.FieldByName('ITE_MEDAJU').Value := cdsItensGiroExt.FieldByName('ITE_MEDAJU').Value;
          cdsItensPedido.FieldByName('ITE_MEDIXX').Value := cdsItensGiroExt.FieldByName('ITE_MEDIXX').Value;

          If IIF(recOpcGir.blnMedAju,
                  (Not cdsItensPedido.FieldByName('ITE_AJUSTA').IsNull) And (cdsItensPedido.FieldByName('ITE_AJUSTA').AsFloat > 0),
                  (Not cdsItensPedido.FieldByName('ITE_MEDIA_').IsNull) And (cdsItensPedido.FieldByName('ITE_MEDIA_').AsFloat > 0)) Then

          Begin
            cdsItensPedido.FieldByName('ITE_DIASUG').AsInteger := Trunc(RoundTo((cdsItensPedido.FieldByName('ITE_SALBAS').AsFloat +
                                                                         (cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat * cdsItensPedido.FieldByName('ITE_QTDEMB').AsFloat) +
                                                                         cdsItensPedido.FieldByName('ITE_QTDTRA').AsFloat) /
                                                                           (IIF(recOpcGir.blnMedAju,
                                                                                 cdsItensPedido.FieldByName('ITE_AJUSTA').AsFloat,
                                                                                 cdsItensPedido.FieldByName('ITE_MEDIA_').AsFloat) / 30), -4));
          End Else
          Begin
            cdsItensPedido.FieldByName('ITE_DIASUG').Clear;
          End;

        End;

      End;

      pAcertaCorPedido(cdsItensPedido, fltLimAma, fltLimVer);

      cdsItensPedido.FieldByName('ITE_TIPOPE').AsString := STR_COMPRAR;
      cdsItensPedido.FieldByName('ITE_DESGRU').Value := qryPcmDet.FieldByName('ITE_DESGRU').Value;
      cdsItensPedido.FieldByName('ITE_DESSIM').Value := qryPcmDet.FieldByName('ITE_DESSIM').Value;
      cdsItensPedido.FieldByName('ITE_FORPRI').AsString := qryPcmDet.FieldByName('ITE_FORPRI').AsString;
      cdsItensPedido.FieldByName('ITE_DEPART').AsString := qryPcmDet.FieldByName('ITE_DEPART').AsString;
      cdsItensPedido.FieldByName('ITE_TIPABS').AsString := qryPcmDet.FieldByName('ITE_TIPABS').AsString;
      cdsItensPedido.FieldByName('ITE_VNOLCD').AsString := qryPcmDet.FieldByName('ITE_VNOLCD').AsString;
      cdsItensPedido.Post;

      pIncluiNaListaConsulta;

      qryPcmDet.Next;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    If (recOpcGir.strPedMlj = 'S') And Assigned(cdsItensMultiLojas) Then
    Begin
      cdsItensMultiLojas.IndexFieldNames := strIndexSave;
    End;

    cdsItensPedido.First;
    cdsItensPedido.EnableControls;

    cdsItensPedido.AggregatesActive := True;

    If objCopiaSeg.recPcmger.blnRecuperaPedido Then
    Begin
      fltValFreGer := objCopiaSeg.recPcmger.fltValFre;
      fltDesAceGer := objCopiaSeg.recPcmger.fltDesAce;
    End Else
    Begin
      fltValFreGer := fDoubleAggregate(cdsItensPedido, 'TOT_VALFRE');
      fltDesAceGer := fDoubleAggregate(cdsItensPedido, 'TOT_DESACE');
    End;

    FreeAndNil(qryPcddetRes);
     If objCopiaSeg.recPcmger.blnRecuperaPedido Then
     Begin
       objTransfere.cdsItensMult := cdsItensMultiLojas;
       objTransfere.cdsItensPed  := cdsItensPedido;
       objTransfere.pCarregaRES(objCopiaSeg.recPcmger.strAutInc);
     End;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmPedidoDeCompra.fCarregaItensPedidoAux]');
    End;
  End;

end;

procedure TfrmPedidoDeCompra.pMostraLitragemGrupo;
begin

  Screen.Cursor := crHourGlass;
  pnlInfo.Caption := 'Aguarde, calculando litros/kilos...';
  cdsItensPedido.AfterScroll := Nil;

  pReaplicaMascara(cdsItensPedido);

  pnlInfo.Caption := '';
  Screen.Cursor := crDefault;

  Try
    pCriarFormularios(TfrmFatMostraLitragGrupo, frmFatMostraLitragGrupo);

    frmFatMostraLitragGrupo.cdsItensPedido := cdsItensPedido;
    frmFatMostraLitragGrupo.blnUsarGiro    := blnUsarGiro;
    frmFatMostraLitragGrupo.intOrdem       := recOpcGir.intOrdem;

    frmFatMostraLitragGrupo.lblSaldo.Caption := dbeTotLit.Text;
    frmFatMostraLitragGrupo.lblTotal.Caption := dbeTotIte.Text;

    frmFatMostraLitragGrupo.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmPedidoDeCompra.pMostraLitragemGrupo]');
    End;
  End;

  pAferScroll(cdsItensPedido);
  pFreeAndNil(frmFatMostraLitragGrupo);
end;

procedure TfrmPedidoDeCompra.btnEstoqueClick(Sender: TObject);
begin
  inherited;

  If InterlockedIncrement(intConfirma) = 0 Then
  Begin

    Try
      If (btnEstoque.Visible) And (Not cdsItensPedido.IsEmpty) Then
      Begin
        pMostraEstoqueLojasComGiro;
        pSetFocus(cxgItens);
      End;
      InterlockedDecrement(intConfirma);
    Except
      InterlockedDecrement(intConfirma);
    End;

  End
  Else
    InterlockedDecrement(intConfirma);

end;

procedure TfrmPedidoDeCompra.btnExcluirClick(Sender: TObject);
begin
  inherited;

  btnApaga.Click;
end;

Procedure TfrmPedidoDeCompra.pMostraEstoqueLojasComGiro;
  Var
    strSQL     : String;
    intContador: Integer;
    intQtdMes  : Integer;

    wrdDia, wrdMes, wrdAno: Word;

    qryEmpresa : TUniQuery;
    strEmpresa : String;

    qryAux: TZClient;
    dtsAux: TDataSource;
begin

  If (recOpcGir.intMesGir = 0) Then
    intQtdMes := 3
  Else
    intQtdMes := recOpcGir.intMesGir;

  qryEmpresa := fCriaQuery(Self);

  qryAux     := TZClient.Create(Self);
  dtsAux     := qryAux.dtsSource;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  EMP_CODEMP AS CODEMP ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADEMP ';
  strSQL := strSQL + 'ORDER BY EMP_CODEMP ';

  qryEmpresa.Close;
  qryEmpresa.SQL.Clear;
  qryEmpresa.SQL.Add(strSQL);
  qryEmpresa.Open;

  strSQL := '';

  While Not qryEmpresa.Eof Do
  Begin
    strEmpresa := QuotedStr(qryEmpresa.fieldbyname('CODEMP').AsString);

    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  G.ITE_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  E.EMP_NOMEMP AS NOMEMP, ';
    strSQL := strSQL + '  I.ITE_CODITE AS CODIGO, ';
    strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';

    // SALDO FISICO
    strSQL := strSQL + '  (SELECT ';
    strSQL := strSQL + '     IFNULL(SUM(ITEGER.ITE_SALDOS + IF(IFNULL(ITE_CNV_ML, 0) > 0, IFNULL(ITE_SAL_ML, 0) / ITE_CNV_ML, 0)),0) ';
    strSQL := strSQL + '   FROM ';
    strSQL := strSQL + '     ITEGER ';
    strSQL := strSQL + '   WHERE ';
    strSQL := strSQL + '     ITEGER.ITE_CODITE = I.ITE_CODITE AND ';
    strSQL := strSQL + '     ITEGER.ITE_CODEMP = ' + strEmpresa + ') ';

    If fUsaQtdPendenteEntregaFutura Then
      strSQL := strSQL + ' + ' + fGetSQLSomaCamposEntregaFutura('G', True);

    strSQL := strSQL + ' AS SALDOS, ';

    // SALDO DISPONIVEL
    strSQL := strSQL + fSQLSaldoDisponivel('G', True, False, True) + ' AS SALDIS, ';

    //Entrega Futura
    strSQL := strSQL + ' 0.000 AS ENTFUT, ';

    // MEDIA
    DecodeDate(VS_date, wrdAno, wrdMes, wrdDia);
    Dec(wrdMes);
    strSQL := strSQL + '  (( ';
    For intContador := 1 To intQtdMes Do
    Begin
      If (wrdMes = 0) Then
      Begin
        wrdMes := 12;
        Dec(wrdAno);
      End;

      strSQL := strSQL + '  SUM(IFNULL((SELECT GIR_QSAI' + fStrZero(wrdMes, 2) + ' FROM GIRITE WHERE GIR_CODITE = G.ITE_CODITE AND GIR_CODEMP = G.ITE_CODEMP AND GIR_CODEMP = ' + strEmpresa + ' AND GIR_A_N_O_ = ' + fStrZero(wrdAno, 4) + '),0)) + ';

      Dec(wrdMes);
    End;
    strSQL := copy(strSQL,1,length(strSQL)-2);
    strSQL := strSQL + '  ) / ' + IntToStr(intQtdMes) + ') AS MEDIA, ';

    // GIRO DO MES ATUAL
    DecodeDate(VS_date, wrdAno, wrdMes, wrdDia);
    strSQL := strSQL + '  SUM(IFNULL((SELECT GIR_QSAI' + fStrZero(wrdMes, 2) + ' FROM GIRITE WHERE GIR_CODITE = G.ITE_CODITE AND GIR_CODEMP = G.ITE_CODEMP AND GIR_CODEMP = ' + strEmpresa + ' AND GIR_A_N_O_ = ' + fStrZero(wrdAno, 4) + '),0)) AS MESATU, ';

    // GIRO
    DecodeDate(VS_date, wrdAno, wrdMes, wrdDia);
    Dec(wrdMes);
    For intContador := 1 To intQtdMes Do
    Begin
      If (wrdMes = 0) Then
      Begin
        wrdMes := 12;
        Dec(wrdAno);
      End;

      strSQL := strSQL + '  SUM(IFNULL((SELECT GIR_QSAI' + fStrZero(wrdMes, 2) + ' FROM GIRITE WHERE GIR_CODITE = G.ITE_CODITE AND GIR_CODEMP = G.ITE_CODEMP AND GIR_CODEMP = ' + strEmpresa + ' AND GIR_A_N_O_ = ' + fStrZero(wrdAno, 4) + '),0)) AS MES' + fStrZero(IntToStr(intContador), 3) + ' , ';

      Dec(wrdMes);
    End;
    strSQL := copy(strSQL,1,length(strSQL)-2);

    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  ITEGER G, ';
    strSQL := strSQL + '  CADEMP E ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';
    strSQL := strSQL + '  G.ITE_CODEMP = E.EMP_CODEMP AND ';
    strSQL := strSQL + '  I.ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '  G.ITE_CODEMP = ' + strEmpresa + ' ' ;
    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  CODIGO, DESITE ';

    qryEmpresa.Next;

    If Not qryEmpresa.Eof Then
      strSQL := strSQL + '  UNION ALL  ';
  End;

  strSQL := strSQL + ' ORDER BY ';
  strSQL := strSQL + '   CODEMP ';


  With qryAux Do
  Begin
    Close;
    qryQuery.SQL.Clear;
    qryQuery.SQL.Add(strSQL);
    qryQuery.ParamByName('CODITE').AsString := cdsItensPedido.FieldByName('ITE_CODITE').AsString;

    fAbreClient;

    (FieldByName('SALDOS') As TFloatField).DisplayFormat := '#,##0.000';
    (FieldByName('SALDIS') As TFloatField).DisplayFormat := '#,##0.000';
    (FieldByName('MEDIA')  As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ENTFUT')  As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('MESATU')  As TFloatField).DisplayFormat := '#,##0.00';

    For intContador := 1 To intQtdMes Do
    Begin
      (FieldByName('MES' + fStrZero(IntToStr(intContador), 3) ) As TFloatField).DisplayFormat := '#,##0.00';
    End;

    While Not Eof Do
    Begin
      Edit;
      FieldByName('ENTFUT').AsFloat := TEntregaFutura.New(
                                         TParamEF.New()
                                           .CodIte(FieldByName('CODIGO').AsString)
                                           .CodEmp(FieldByName('CODEMP').AsString)
                                           .Faturamento(True)
                                         ).Total();
      Post;

      Next;
    End;

    First;

    Try
      pCriarFormularios(TfrmMostraEstoqueGiroEmp, frmMostraEstoqueGiroEmp);
      frmMostraEstoqueGiroEmp.cxvEstoque.DataController.DataSource := dtsAux;
      frmMostraEstoqueGiroEmp.strCodIte := cdsItenspedido.FieldByName('ITE_CODITE').AsString;
      frmMostraEstoqueGiroEmp.edtItem.Text := cdsItensPedido.FieldByName('ITE_CODITE').AsString + ' - ' +
                                              cdsItensPedido.FieldByName('ITE_DESITE').AsString;

      {*********************************************}
      {* ALTERANDO O NOME DAS COLUNAS DO GRID      *}
      {******************************************LU*}
      frmMostraEstoqueGiroEmp.cxvEstoqueMES001.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -1));
      frmMostraEstoqueGiroEmp.cxvEstoqueMES002.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -2));
      frmMostraEstoqueGiroEmp.cxvEstoqueMES003.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -3));
      frmMostraEstoqueGiroEmp.lblQtdM04.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -4));
      frmMostraEstoqueGiroEmp.lblQtdM05.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -5));
      frmMostraEstoqueGiroEmp.lblQtdM06.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -6));
      frmMostraEstoqueGiroEmp.lblQtdM07.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -7));
      frmMostraEstoqueGiroEmp.lblQtdM08.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -8));
      frmMostraEstoqueGiroEmp.lblQtdM09.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -9));
      frmMostraEstoqueGiroEmp.lblQtdM10.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -10));
      frmMostraEstoqueGiroEmp.lblQtdM11.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -11));
      frmMostraEstoqueGiroEmp.lblQtdM12.Caption := FormatDateTime('mm/yyyy', IncMonth(VS_Date, -12));
      frmMostraEstoqueGiroEmp.btnPreparacaoTE.Visible := fVerificaAcessoSistema('frmPreparaGerTE', strLoginUsuarioLogado);

      frmMostraEstoqueGiroEmp.pnlGiroMeses.Visible := intQtdMes > 3;

      If intQtdMes = 6 Then
      Begin
        frmMostraEstoqueGiroEmp.lblQtdM04.Visible := True;
        frmMostraEstoqueGiroEmp.lblQtdM05.Visible := True;
        frmMostraEstoqueGiroEmp.lblQtdM06.Visible := True;

        frmMostraEstoqueGiroEmp.dbeQtdM04.Visible := True;
        frmMostraEstoqueGiroEmp.dbeQtdM05.Visible := True;
        frmMostraEstoqueGiroEmp.dbeQtdM06.Visible := True;
        frmMostraEstoqueGiroEmp.dbeQtdM04.DataSource := dtsAux;
        frmMostraEstoqueGiroEmp.dbeQtdM05.DataSource := dtsAux;
        frmMostraEstoqueGiroEmp.dbeQtdM06.DataSource := dtsAux;
      End
      Else If intQtdMes = 12 Then
      Begin
        frmMostraEstoqueGiroEmp.lblQtdM04.Visible := True;
        frmMostraEstoqueGiroEmp.lblQtdM05.Visible := True;
        frmMostraEstoqueGiroEmp.lblQtdM06.Visible := True;
        frmMostraEstoqueGiroEmp.lblQtdM07.Visible := True;
        frmMostraEstoqueGiroEmp.lblQtdM08.Visible := True;
        frmMostraEstoqueGiroEmp.lblQtdM09.Visible := True;
        frmMostraEstoqueGiroEmp.lblQtdM10.Visible := True;
        frmMostraEstoqueGiroEmp.lblQtdM11.Visible := True;
        frmMostraEstoqueGiroEmp.lblQtdM12.Visible := True;

        frmMostraEstoqueGiroEmp.dbeQtdM04.Visible := True;
        frmMostraEstoqueGiroEmp.dbeQtdM05.Visible := True;
        frmMostraEstoqueGiroEmp.dbeQtdM06.Visible := True;
        frmMostraEstoqueGiroEmp.dbeQtdM07.Visible := True;
        frmMostraEstoqueGiroEmp.dbeQtdM08.Visible := True;
        frmMostraEstoqueGiroEmp.dbeQtdM09.Visible := True;
        frmMostraEstoqueGiroEmp.dbeQtdM10.Visible := True;
        frmMostraEstoqueGiroEmp.dbeQtdM11.Visible := True;
        frmMostraEstoqueGiroEmp.dbeQtdM12.Visible := True;
        frmMostraEstoqueGiroEmp.dbeQtdM04.DataSource := dtsAux;
        frmMostraEstoqueGiroEmp.dbeQtdM05.DataSource := dtsAux;
        frmMostraEstoqueGiroEmp.dbeQtdM06.DataSource := dtsAux;
        frmMostraEstoqueGiroEmp.dbeQtdM07.DataSource := dtsAux;
        frmMostraEstoqueGiroEmp.dbeQtdM08.DataSource := dtsAux;
        frmMostraEstoqueGiroEmp.dbeQtdM09.DataSource := dtsAux;
        frmMostraEstoqueGiroEmp.dbeQtdM10.DataSource := dtsAux;
        frmMostraEstoqueGiroEmp.dbeQtdM11.DataSource := dtsAux;
        frmMostraEstoqueGiroEmp.dbeQtdM12.DataSource := dtsAux;
      End;

      frmMostraEstoqueGiroEmp.showModal;


    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmPedidoDeCompra.pMostraEstoqueLojasComGiro]');
      End;
    End;

    pFreeAndNil(frmMostraEstoqueGiroEmp);
    Close;

  End;

  FreeAndNil(qryAux);
end;

procedure TfrmPedidoDeCompra.btnPedidosPendClick(Sender: TObject);
begin
  inherited;

  If (Not btnPedidosPend.Visible) Then
    Exit;

  If InterlockedIncrement(intConfirma) = 0 Then
  Begin

    Try

      pMostraProdutosPendentes(True,
                               cdsItensPedido.FieldByName('ITE_CODITE').AsString,
                               cdsItensPedido.FieldByName('ITE_DESITE').AsString,
                               True,
                               True);
      InterlockedDecrement(intConfirma);
    Except
      InterlockedDecrement(intConfirma);
    End;

  End
  Else
    InterlockedDecrement(intConfirma);

end;

procedure TfrmPedidoDeCompra.btnQuantidadeVendasPerdidasClick(Sender: TObject);
Var
  strMeses: string;
begin
  strMeses := fMesesGiro(cdsDigMultLoja.recOpcGir, cdsDigMultLoja.recOpcGir.intMesGir);

  TfrmResumoQuantidadeVendasPerdidas
    .fNovo
    .fCodIte(cdsDigMultLoja.cdsDadosRodapeUma.FieldByName('ITE_CODITE').AsString)
    .fCodSim(IIF(cdsDigMultLoja.recOpcGir.blnAgrSim, cdsDigMultLoja.cdsDadosRodapeUma.FieldByName('ITE_CODSIM').AsString,''))
    .fDesIte(cdsDigMultLoja.cdsDadosRodapeUma.FieldByName('ITE_DESITE').AsString)
    .fUniIte(cdsDigMultLoja.cdsDadosRodapeUma.FieldByName('ITE_UNICOM').AsString)
    .fCodEmp(recOpcGir.strEmpGir.Replace('''''','"'))
    .fMeses(strMeses)
    .fShowModal
    .Free;
end;

Function TfrmPedidoDeCompra.fCalculaTotalEmpresasPrg(prgProgresso: TCxProgressBar): Boolean;
  Var
    strItensPed: String;
Begin
  strItensPed := fRetItensPed(cdsItensPedido);

  Result := fCalculaTotalEmpresas(strItensPed, cdsItensMultiLojas, fltDesAceGer, fltValFreGer, frmGravandoConfirmaPedido);
End;

procedure TfrmPedidoDeCompra.btnResumoLojaClick(Sender: TObject);
var frmGravandoConfirmaPedidoInterno: TfrmGravando;
begin
  inherited;

  If Not btnResumoLoja.Visible Then
    Exit;

  if Assigned(cdsItensMultiLojas) And (Not cdsItensMultiLojas.IsEmpty) then
  Begin

    Try
      cdsDigMultLoja.blnValidarDados := False;

      cdsItensPedido.DisableControls;
      cdsItensPedido.AfterScroll := Nil;

      cdsDigMultLoja.desvinculaCDS;
      If blnNotShow Then
      Begin
        TfrmGravando.fExecuta(fCalculaTotalEmpresasPrg, frmGravandoConfirmaPedidoInterno, 'Calculando total por empresas...', True);
      End
      Else
      Begin
        TfrmGravando.fExecuta(fCalculaTotalEmpresasPrg, frmGravandoConfirmaPedido, 'Calculando total por empresas...', True);
        TfrmPedidoCompraResumoLojas.pExibeResumo(cdsDigMultLoja, cdsItensMultiLojas, cdsItensPedido, edtCodFor.Text);
      End
    Finally
       cdsItensPedido.EnableControls;
       cdsItensPedido.AfterScroll := pAferScroll;
       pAferScroll(cdsItensPedido);
       cdsDigMultLoja.vinculaCDS;
       cdsDigMultLoja.blnValidarDados := True;
       cdsDigMultLoja.GridExpand;
    End;
  End;
end;

procedure TfrmPedidoDeCompra.btnAltTabPreClick(Sender: TObject);
  Var
    intRecNo : Integer;
begin
	intRecNo := 0;

  inherited;

  If Not btnAltTabPre.Visible Then
    Exit;

  if fVerificaPedidoBaixadoOuBaixaParcial(strNumPed, strEspDoc, strCodEmp) Then
  Begin
    pMensagemOk('O Pedido já contém baixas, não será possível trocar a tabela de preços!');
    Exit;
  End;

  {*  Troca os preços dos produtos *}
  if TfrmNotificaAtivacaoTabPreFor.fEscolheTabelaAUtilizar(edtCodFor.Text, recOpcGir.strCodTab) Then
  Begin

    pSetCaptionForm;
    If recOpcGir.strCodTab <> 'ITEGER' then
      Self.Caption := Self.Caption + ' - Utilizando Tabela de Preço do Fornecedor: ' + recOpcGir.strCodTab + ' - ' + fRetNomeTabelaPreco(recOpcGir.strCodTab)
    Else
      Self.Caption := Self.Caption + ' - Utilizando Tabela de Preço do Cadastro de Produtos';

    With cdsItensPedido Do
    Begin
      try
        blnMudaTabPre := True;
        Screen.Cursor := crHourGlass;
        DisableControls;
        intRecNo := RecNo;

        First;
        While Not Eof Do
        Begin
          pAtualizaDados(Nil);
          pCarregaItem;
          fValidaCampos(edtCodIte, True);
          btnAdicionar.Click;

          Next;
        End;


      Finally
        blnMudaTabPre := False;
        Screen.Cursor := crDefault;
        RecNo := intRecNo;
        EnableControls;
      End;

    End;


  End;

end;

procedure TfrmPedidoDeCompra.btnAltTraClick(Sender: TObject);
Begin
  inherited;

  pDefineTransferencia;
End;

procedure TfrmPedidoDeCompra.pDefineTransferencia;
  Var
    strCodEmp: String;
    ConfirmouAlt: Boolean;

begin
   ConfirmouAlt := False;
  If cdsItensPedido.IsEmpty Then
    Exit;

  If cdsItensPedido.FieldByName('ITE_CODITE').AsString <> cdsItensMultiLojas.FieldByName('ITE_CODITE').AsString Then
    pAferScroll(cdsItensPedido);

  strCodEmp := cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString;

  Try
    pCriarFormularios(TfrmPedeEmpOrigem, frmPedeEmpOrigem);

    If Assigned(cdsDigMultLoja) And Assigned(cdsDigMultLoja.frmEntDigMultiLojasNovo) Then
    Begin
      frmPedeEmpOrigem.lblQtdSug.Visible := cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensSUGEST.Visible;
      frmPedeEmpOrigem.edtQtdSug.Visible := cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensSUGEST.Visible;
    End;

    frmPedeEmpOrigem.cdsItensPedido := cdsItensPedido;

    If cdsItensPedido.FieldByName('ITE_QTDEMB').AsFloat <> 1 Then
      frmPedeEmpOrigem.lblEmbalagem.Caption := 'embal. ' + FormatFloat(fMskDigitos(DEC_EMBALAGEM), cdsItensPedido.FieldByName('ITE_QTDEMB').AsFloat);

    With frmPedeEmpOrigem, cdsItensMultiLojas Do
    Begin
      edtCodEmp.Text := FieldByName('ITE_CODEMP').AsString;
      edtNomEmp.Text := FieldByName('ITE_DESEMP').AsString;

      edtCodIte.Text := cdsItensPedido.FieldByName('ITE_CODITE').AsString;
      edtDesIte.Text := cdsItensPedido.FieldByName('ITE_DESITE').AsString;

      edtQtdSug.Text := FormatFloat(fMskDigitos(intDecTpc), FieldByName('ITE_SUGEST').AsFloat);

      edtQtdReq.Text := FormatFloat(fMskDigitos(intDecTpc), FieldByName('ITE_QTDREQ').AsFloat);
      edtQtdIte.Text := FormatFloat(fMskDigitos(intDecTpc), FieldByName('ITE_QTDITE').AsFloat);
      edtQtdTra.Text := FormatFloat(fMskDigitos(intDecTpc), FieldByName('ITE_QTDTRA').AsFloat);

      edtQtdTot.Text := FormatFloat(fMskDigitos(intDecTpc), FieldByName('ITE_QTDITE').AsFloat * cdsItensPedido.FieldByName('ITE_QTDEMB').AsFloat + FieldByName('ITE_QTDTRA').AsFloat);
    End;

    objTransfere.cdsItensMult := cdsItensMultiLojas;
    objTransfere.cdsItensPed  := cdsItensPedido;

    objTransfere.pInicializaItem(cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString);

    frmPedeEmpOrigem.cxvEmpresas.DataController.DataSource := objTransfere.cdsItens.dtsSource;
    frmPedeEmpOrigem.objTransfere := objTransfere;

    ConfirmouAlt := frmPedeEmpOrigem.ShowModal = mrOk;


  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmPedidoDeCompra.btnAltTraClick]');
    End;

  End;

  If ConfirmouAlt Then
  Begin
    TRecuperaPedido(cdsDigMultLoja.recOpcGir.objRecupera).pSalvaDefinicaoTransferencia(objTransfere.cdsItens);

    TRecuperaPedido(cdsDigMultLoja.recOpcGir.objRecupera).pAtualizaItem;

  End;


  pFreeAndNil(frmPedeEmpOrigem);

  pAtualizaTotalTela;

  pSetFocus(cdsDigMultLoja.frmEntDigMultiLojasNovo);

  cdsItensMultiLojas.Locate('ITE_CODEMP', strCodEmp, []);
end;

Function TfrmPedidoDeCompra.fPerguntaExclusaoColeta(strCodIte: String): Boolean;
Begin
  If fPossuiColeta(strCodIte) Then
    Result := fPergunta('O produto ' + strCodIte + ' possui Controle de Coleta. Confirma a exclusão?')
  Else
    Result := fPergunta('Confirma a exclusão do produto ' + strCodIte + '?');
End;

Function TfrmPedidoDeCompra.fPerguntaExclusaoColetaMarcados: Boolean;
  Var
    intContador: Integer;
    stlComColeta: TStringList;
Begin
  stlComColeta := TStringList.Create;

  For intContador := 0 To stlProdutosMarcados.Count - 1 Do
    If fPossuiColeta(stlProdutosMarcados[intContador]) Then
      stlComColeta.Add(stlProdutosMarcados[intContador]);

  If stlComColeta.Count > 0 Then
    Result := fPergunta('Há ' + IntToStr(stlComColeta.Count) + ' produtos marcados que possuem Controle de Coleta. Confirma a exclusão?')
  Else
    Result := fPergunta('Há ' + IntToStr(stlProdutosMarcados.Count) + ' marcados para exclusão. Confirma a exclusão dos selecionados?');

  FreeAndNil(stlComColeta);
End;

procedure TfrmPedidoDeCompra.btnApagaClick(Sender: TObject);
  Var
    intContador: Integer;
    indexProd: Integer;
    blnAgrupado: Boolean;
    strCodIte: String;

  procedure  pLocalizaProximoValido(PosIni: integer);
   var i: integer;
  begin
    indexProd := 0;
    for i := (PosIni + 1) to cxvItens.DataController.RecordCount Do
    Begin
      If not stlProdutosMarcados.Find(VarToStr(cxvItens.DataController.GetValue(cxvItens.DataController.GetRowInfo(i).RecordIndex, cxvItensCODITE.Index)), indexProd) Then
      Begin
        strCodIte :=  VarToStr(cxvItens.DataController.GetValue(cxvItens.DataController.GetRowInfo(i).RecordIndex, cxvItensCODITE.Index));
        Exit;
      End;
    End;
  End;

  procedure  pLocalizaAnteriorValido(PosIni: integer);
   var i: integer;
  begin
    indexProd := 0;
    for i := (PosIni  - 1) downto 0 Do
    Begin

      If Not stlProdutosMarcados.Find(VarToStr(cxvItens.DataController.GetValue(cxvItens.DataController.GetRowInfo(i).RecordIndex, cxvItensCODITE.Index)), indexProd) Then
      Begin
        strCodIte :=  VarToStr(cxvItens.DataController.GetValue(cxvItens.DataController.GetRowInfo(i).RecordIndex, cxvItensCODITE.Index));
        Exit;
      End;
    End;
  End;

begin
  inherited;

  If cdsItensPedido.IsEmpty Then
    Exit;

  If InterlockedIncrement(intConfirma) = 0 Then
  Begin
    blnAgrupado := False;
    Try
      If (stlProdutosMarcados.Count > 0) Then
      Begin
        strCodIte := '';
        If cxvItensNVLGIR.GroupIndex > -1 Then
        Begin
          If cxvItens.DataController.RecordCount > stlProdutosMarcados.Count Then
          Begin
            indexProd := 0;
            If stlProdutosMarcados.Find(VarToStr(cxvItens.DataController.GetValue(cxvItens.DataController.FocusedRecordIndex, cxvItensCODITE.Index)), indexProd) Then
            begin
              pLocalizaProximoValido(cxvItens.DataController.FocusedRowIndex);
              If (strCodIte = '') Then
                pLocalizaAnteriorValido(cxvItens.DataController.FocusedRowIndex);
            End
            Else
            begin
              strCodIte :=  VarToStr(cxvItens.DataController.GetValue(cxvItens.DataController.FocusedRecordIndex, cxvItensCODITE.Index));
            End;
            blnAgrupado := True;
            cxvItensNVLGIR.GroupIndex := -1;
          End;
        End;

        If fPerguntaExclusaoColetaMarcados Then
        Begin

          cdsItensPedido.AfterScroll := Nil;

          For intContador := 0 To stlProdutosMarcados.Count - 1 Do
          If cdsItensPedido.Locate('ITE_CODITE', stlProdutosMarcados[intContador], []) Then
            pApagaItem;

          pFechaCompraItem;
          cdsItensPedido.AfterScroll := pAferScroll;
          pAferScroll(cdsItensPedido);
          pAtualizaGridRodape(False, strCodIteProcessadoRodape);

        End;

        stlProdutosMarcados.Clear;
        cxvItens.DataController.Refresh;

        If blnAgrupado Then
        Begin
          cxvItensNVLGIR.GroupIndex := 0;
          cxvItens.DataController.Groups.FullExpand;
          cdsItensPedido.Locate('ITE_CODITE', strCodIte, []);
        End;

      End

      Else If (Not blnConDel) Or
              fPerguntaExclusaoColeta(cdsItensPedido.FieldByName('ITE_CODITE').AsString) Then
      Begin
        cdsItensPedido.AfterScroll := Nil;

        pApagaItem;

        pFechaCompraItem;

        cdsItensPedido.AfterScroll := pAferScroll;
        pAferScroll(cdsItensPedido);
        pAtualizaGridRodape(False, strCodIteProcessadoRodape);
      End;

      InterlockedDecrement(intConfirma);
    Except
      InterlockedDecrement(intConfirma);
    End;

  End
  Else
    InterlockedDecrement(intConfirma);

  pAtualizaBotoesTotais;
  pAtualizaGridRodape(True, strCodIteProcessadoRodape);

  Application.ProcessMessages;
end;

procedure TfrmPedidoDeCompra.btnEditarItemClick(Sender: TObject);
begin
  inherited;

  If (Not btnEditarItem.Visible) Then
    Exit;

  If InterlockedIncrement(intConfirma) = 0 Then
  Begin

    Try

      pSetFocus(edtCodIte);
      pAtualizaDados(Nil);
      blnAlterando := True;

      InterlockedDecrement(intConfirma);
    Except
      InterlockedDecrement(intConfirma);
    End;

  End
  Else
    InterlockedDecrement(intConfirma);

end;

procedure TfrmPedidoDeCompra.btnEmbalagemClick(Sender: TObject);
Var
   objIteBar: TIteBar;
   ftlQtdConvertida: Double;
   fltQtdEmbalagem:  Double;
   fltMltCom:  Double;
begin
  inherited;
  If not btnEmbalagem.Visible Then
    Exit;

  btnCancelaItem.Click;

  Try
    Try
      objIteBar := TIteBar.Create(opcConsulta,
                                  Nil,
                                  Nil,
                                  Nil,
                                  Nil,
                                  Nil,
                                  cdsItensPedido.FieldByName('ITE_CODITE').AsString,
                                  True);

      If objIteBar.fltQtdIte > 0 Then
      Begin
        fltQtdEmbalagem := objIteBar.fltQtdIte;
        fltQtdAnt := cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat;
        fltMltCom := cdsItensPedido.FieldByName('ITE_MLTCOM').AsFloat;

        ftlQtdConvertida := (ceil(fltQtdAnt / fltQtdEmbalagem )) * fltQtdEmbalagem;

        If fltMltCom <> 1 Then
          ftlQtdConvertida := (ceil(ftlQtdConvertida / fltMltCom )) * fltMltCom;

        cdsItensPedido.Edit;
        cdsItensPedido.FieldByName('ITE_UNITAR').AsFloat := cdsItensPedido.FieldByName('ITE_UNITAR').AsFloat / cdsItensPedido.FieldByName('ITE_QTDEMB').AsFloat;
        cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat := ftlQtdConvertida;
        cdsItensPedido.FieldByName('ITE_QTDEMB').AsFloat := 1;
        pCalculaTotalItemQtdGrid(cdsItensPedido);
        cdsItensPedido.Post;
        pAtualizaQtdMultiloja;
        objCopiaSeg.pAtualizaItem;
      End;

      FreeAndNil(objIteBar);
    Except
      On E: Exception Do
      Begin
        FreeAndNil(objIteBar);
        pMensagensErro(E.Message, '[btnEmbalagemClick]')
      End;
    End;
  Finally
    pSetFocus(edtUnitar);
  End;
end;

procedure TfrmPedidoDeCompra.pCalculaTotalItem(blnCalTot: Boolean);
  Var
    strValTot: String;
    fltrepFre: Double;
    fltVlrAliquotaSub: Double;
    fltAlqIPI,
    fltBasIPI,
    fltValIPI,
    fltTotDar,
    lfltUnitar: Double;
    recDescontoItem: TRecDescontoItem;

begin

  If fEmptyStr(edtQtdIte.Text) Then
    edtQtdIte.Text := FormatFloat(fMskDigitos(intDecTpc), 0);

  If fEmptyStr(edtUnitar.Text) Then
    edtUnitar.Text := '0,'+fStrZero('', intDecUni);

  If fEmptyStr(edtDesUni.Text) Then
    edtDesUni.Text := '0,'+fStrZero('', 2);

  If fEmptyStr(edtDesUn2.Text) Then
    edtDesUn2.Text := '0,'+fStrZero('', 2);

  If fEmptyStr(edtDesUn3.Text) Then
    edtDesUn3.Text := '0,'+fStrZero('', 2);

  If fEmptyStr(edtDesUn4.Text) Then
    edtDesUn4.Text := '0,'+fStrZero('', 2);

  If fEmptyStr(edtDesUn5.Text) Then
    edtDesUn5.Text := '0,'+fStrZero('', 2);

  If fEmptyStr(edtDesUn6.Text) Then
    edtDesUn6.Text := '0,'+fStrZero('', 2);

  If fEmptyStr(edtPerIpi.Text) Then
    edtPerIpi.Text := '0,0000';

  If fEmptyStr(edtPerSub.Text) Then
    edtPerSub.Text := '0,0000';

  If fEmptyStr(edtPerImp.Text) Then
    edtPerImp.Text := '0,00';

  If fEmptyStr(edtPerIpIImp.Text) Then
    edtPerIpiImp.Text := '0,00';

  If fEmptyStr(edtPerCof.Text) Then
    edtPerCof.Text := '0,00';

  If fEmptyStr(edtPerPis.Text) Then
    edtPerPis.Text := '0,00';

  strValTot := edtValTot.Text;



  If blnCalTot Then
  begin
    recDescontoItem := fObterDescontosItem(False);

    lfltUnitar := recDescontoItem.fCalcularValorDescontado(objCopiaSeg.recPcmger.blnSomaDescontoAdcionalFornecedor1, fStrToFloat(edtUnitar.Text));

    edtValTot.Text := FloatToStrF(fStrToFloat(edtQtdIte.Text) * lfltUnitar, ffNumber, 12, 2);
  end;

  fltRepFre := (fltValFreSalvo*100)/fStrToFloat(edtValTot.Text);

  fltBasIpi := fStrToFloat(edtValTot.Text, 2);
  If (objCopiaSeg.recPcmger.strIPIFre = 'S') And (fltRepFre > 0) Then
   fltBasIpi := fltBasIpi + (fltBasIpi * fltRepFre /100);
  edtTotIpi.Text := FloatToStrF(fltBasIpi * (fStrToFloat(edtPerIpi.Text) / 100), ffNumber, 12, 2);
  fltAlqIPI :=  fStrToFloat(edtPerIpi.Text , 2);
  If chkPedImp.Checked Then
  Begin
    edtTotImp.Text    := FloatToStrF(fStrToFloat(edtValTot.Text) * (fStrToFloat(edtPerImp.Text) / 100), ffNumber, 12, 2);
    edtTotIpiImp.Text := FloatToStrF((fStrToFloat(edtValTot.Text) + fStrToFloat(edtTotImp.Text)) * (fStrToFloat(edtPerIpiImp.Text) / 100), ffNumber, 12, 2);
    edtTotPis.Text    := FloatToStrF(fStrToFloat(edtValTot.Text) * (fStrToFloat(edtPerPis.Text) / 100), ffNumber, 12, 2);
    edtTotCof.Text    := FloatToStrF(fStrToFloat(edtValTot.Text) * (fStrToFloat(edtPerCof.Text) / 100), ffNumber, 12, 2);

    edtTotSub.Text := '0,00';
    edtIcmDes.Text := '0,00';
  End
  Else
  Begin
//    edtTotIpi.Text := FloatToStrF(fStrToFloat(edtValTot.Text) * (fStrToFloat(edtPerIpi.Text) / 100), ffNumber, 12, 2);

    fltTotSubCal := fCalcularSubstituicaoProduto(edtCodFor.Text,                             // strCodFor,
                                                fRetornaAbreviacaoItem(edtCodIte.Text),      // strCodAbf: String;
                                                fStrToFloat(edtValTot.Text),                 // fltTotIte,
                                                fltValFreSalvo,
                                                fltDesAceSalvo ,
                                                strFRMPCM,                                   // strFrmPcm,
                                                objCopiaSeg.recPcmger.strBStFre,             // strBStFre,
                                                objCopiaSeg.recPcmger.strBStAce,             // strBStAce: String;
                                                blnZonaFranca,                               // blnZonaFranca,
                                                strIncPisIte = 'S',                          // blnIncPis,
                                                strSimPau = 'S',                             // blnFornecSimples: Boolean;
                                                blnTemDare,
                                                fltAlqIPI,                                             // fltAlqIPI: Double;
                                                chkZeraST.Checked,
                                                fltBasIcmIte,                                // fltBasIcm,
                                                fltAlqIcmIte,                                // fltAlqIcm,
                                                fltValIcmIte,                                // fltValIcm,
                                                fltBaseSTIte,                                // fltBaseST,
                                                fltDesPisIte,                                // fltDesPis,
                                                fltBasIpi,                                   // fltBasIPI,
                                                fltValIpi,                                   // fltValIPI,
                                                fltPerFCPIte,                                // fltPerFCP,
                                                fltSubFCPIte,                                // fltSubFCP: Double;
                                                fltTotDar,                                   // fltTotDar: Double;
                                                strCodSitIte,                                // strCodSit: String;
                                                strCodSitOrigemIte,                          // strCodSitOrigem: String;
                                                fltVlrAliquotaSub,                           // fltAliquotaSub: Double;
                                                ParametrosCalcImpostos,                      // ParametrosImpostos: TParametrosCalculoImposto;
                                                strTipAbfFor);                               // strTipAbfFor: String = '';
    fltIcmDesCal := 0;
    If ParametrosCalcImpostos.blnCalcularICMSDesonerado Then
      fltIcmDesCal := fltValIcmIte;

    If (strSubUsu <> 'S') Then
    Begin
      edtTotSub.Text  := FloatToStrF(fltTotSubCal, ffNumber, 12, 2);
      edtPerSub.Text  := FloatToStrF(fltVlrAliquotaSub, ffNumber, 12, 4);
      fltVlrAlqSubOri := fltVlrAliquotaSub;
      If ParametrosCalcImpostos.blnCalcularICMSDesonerado Then
        edtIcmDes.Text  := FloatToStrF(fltValIcmIte, ffNumber, 12, 2)
      Else
        edtIcmDes.Text  := '0,00';

      edtValDar.Text  := FloatToStrF(fltTotDar, ffNumber, 12, 2);
    End;

    edtSubFCP.Text    := FloatToStrF(RoundTo(fStrToFloat(edtTotSub.Text) * fltPerFCPIte / 100, -2), ffNumber, 12, 2);

    edtDesPis.Text    := FloatToStrF(fltDesPisIte, ffNumber, 12, 2);
    edtTotIpi.Text := FloatToStrF(fltValIpi, ffNumber, 12, 2);

    If (strSubUsu = 'S') Then
       fValidaTotSub(False, True) ;
  End;

  pCalculaReformaTela;

  pAtualizaUnitarioLiquido;
end;

procedure TfrmPedidoDeCompra.pAtivaItem;
 Var
    intRecNo: Integer;
    blnResult: Boolean;
Begin
  Try
    blnAtivandoItem := True;

    If (recOpcGir.strPedMlj = 'S') And (Not cdsItensPedido.IsEmpty) Then
    Begin
      intRecNo := cxvItens.DataController.DataSource.DataSet.RecNo;

      blnAlterando := True;
      pAtualizaDados(nil);

      If fDigQuantidadeMultilojaPedCom Then
      Begin
        blnResult := fAdicionaItem(False, True);

        If Not blnResult Then
        Begin
          pVoltaQtdTmpMultiLojas(edtCodIte.Text, cdsItensMultiLojas);
          btnCancelaItem.Click;
        End;

      End Else
        blnResult := False;

      pSetFocus(cxgItens);

      If blnResult Then
      begin
        If (intRecNo > 0) And (cxvItens.DataController.DataSource.DataSet.RecordCount >= intRecNo) Then
          cxvItens.DataController.DataSource.DataSet.RecNo := intRecNo;

        pAtualizaDados(cxvItens.DataController.DataSource.DataSet, False);

        blnMudarFoco := True;

        pProximoItem(True, True);
      End;

    End
    Else
    Begin
      pSetFocus(edtCodIte);
      pAtualizaDados(Nil);
      blnAlterando := True;
    End;

  Finally
    blnAtivandoItem := False;
  End;

  pAtualizaTotalTela;
End;

procedure TfrmPedidoDeCompra.pMostraGiroAnalitico;
Var
  strEmpDes: String;
  blnEmpDes: Boolean;
begin
  If edtEmpDestino.Visible Then
  Begin
    blnEmpDes := True;
    strEmpDes := edtEmpDestino.Text;
  End
  Else
    blnEmpDes := False;

  If (recOpcGir.strPedMlj <> 'S') And (blnUsarGiro Or blnAltPedGir) Then
  Begin

   pCalculaGiroAnalitico(recOpcGir.dtaDataBaseGir,
                         cdsItensPedido.FieldByName('ITE_CODITE').AsString,
                         (IIF(blnEmpDes,strEmpDes,strCodEmp)),
                         recOpcGir.intMesGir,
                         '2');

  End;

end;

procedure TfrmPedidoDeCompra.rdbCodFabClick(Sender: TObject);
begin
  inherited;
  edtCodIte.TipoTexto := EditFocus.TControlTipoTexto(ttAlfanumerico);
  edtCodIte.MaxLength := 25;
  edtCodIte.TamCampo  := 25;
  edtCodIte.CompZeros := False;
  btnCancelaItem.Click;
end;

procedure TfrmPedidoDeCompra.rdbCodIteClick(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodIte);
  btnCancelaItem.Click;
end;

procedure TfrmPedidoDeCompra.rdgCodigoFabricaProdutoClick(Sender: TObject);
begin
  inherited;

  objCopiaSeg.strTipFabP := fRetornaCodigoFabricaProduto;

  pRecalculaCodigoFabricaDoProduto;
end;

procedure TfrmPedidoDeCompra.rdgDesPdiClick(Sender: TObject);
var strDes: string;
begin
  inherited;
  strDes := IfThen(rdgDesPdi.ItemIndex = 0, 'P','F');
  If strDes <> objCopiaSeg.strDesPdiP  Then
  Begin
    objCopiaSeg.strDesPdiP := strDes;
    pAjustaDescricaoDosItens;
  End;
end;

procedure TfrmPedidoDeCompra.edtCodIteExit(Sender: TObject);
begin
  inherited;

  If Not btnCancelaItem.Focused Then
    fValidaItemExit;
End;

Function TfrmPedidoDeCompra.fValidaItemExit: Boolean;
begin
  Result := True;

  If (fEmptyStr(edtCodIte.Text)) Then
  Begin
    If cxgItens.CanFocus Then
    Begin
      pSetFocus(cxgItens);
      pAtualizaDados(Nil);
    End;
    Exit;
  End;

  If Not fValidaItem(True, True, True) Then
  Begin
    Result := False;
    pSetFocus(edtCodIte);
    Exit;
  End;

  {********************************************************}
  {* VERIFICA PERMISSAO PARA ALTERAR DESCRICAO DO PRODUTO *}
  {*****************************************************LU*}
  If (fCfgSis('DESPRO') = 'S') Then
    edtDesIte.Enabled := True
  Else
  Begin
    If (Pos('ITEM ESPECIAL', trim(edtDesIte.Text)) = 0) Then
    Begin
      edtDesIte.Enabled := False;
      If edtCodUni.CanFocus And edtCodUni.TabStop Then
        pSetFocus(edtCodUni)
      Else
        pSetFocus(edtQtdIte);
    End
    Else
    Begin
      edtDesIte.Enabled := True;
      pSetFocus(edtDesIte);
    End;
  End;
end;

procedure TfrmPedidoDeCompra.edtQtdIteExit(Sender: TObject);
begin
  inherited;
  If (recOpcGir.strPedMlj = 'S') Then
  Begin
    pnlInfo.Caption := '';
  End;
end;

procedure TfrmPedidoDeCompra.mnuEntregasFuturasPendentesClick(Sender: TObject);
begin
  TfrmBloquearTela.fExecutarOperacao(pEntregasFuturasPendentes);
end;

procedure TfrmPedidoDeCompra.pEntregasFuturasPendentes;
begin
  inherited;

  If cdsItensPedido.IsEmpty Then
     Exit;

  If Not Assigned(prcExecutaRelatorio) Then
    Exit;

  prcExecutaRelatorio(37, 0,
                     [],
                     ['CODITE'],
                     [cdsItensPedido.FieldByName('ITE_CODITE').AsString],
                      mnuEntregasFuturasPendentes,
                     ['CODITE'],
                     True);

end;

procedure TfrmPedidoDeCompra.edtQtdIteEnter(Sender: TObject);
begin
  inherited;
  btnApaga.Visible     := False;
  btnEstoque.Visible   := False;

  If Not blnAlterando Then
  begin
    If recOpcGir.strPedMlj = 'S' Then
      blnAlterando := (cdsItensPedido.FieldByName('ITE_CODITE').AsString = edtCodIte.Text)
    Else
      blnAlterando := (cdsItensPedido.FieldByName('ITE_CODITE').AsString = edtCodIte.Text) and (cdsItensPedido.FieldByName('ITE_DESITE').AsString = edtDesIte.Text);
  End;

  If (recOpcGir.strPedMlj = 'S') Then
  Begin
    pnlInfo.Caption := 'Pressione [ENTER] para digitar a quantidade';
  End;
end;

procedure TfrmPedidoDeCompra.edtDesAdiEnter(Sender: TObject);
begin
  inherited;
  fltPerDesAdiOLD := fStrToFloat(edtDesAdi.Text);
end;

procedure TfrmPedidoDeCompra.edtDesAdiExit(Sender: TObject);
  Var
    fltPerDesAdiNEW: Double;
begin
  inherited;
   fltPerDesAdiNEW := fStrToFloat(edtDesAdi.Text);
  {********************************************}
  {* RECALCULA PORCENTAGEM ITENS JA INSERIDOS *}
  {* SE A PORCENTAGEM FOR ALTERADA.           *}
  {*****************************************AC*}
    objCopiaSeg.fltDesAdi := fltPerDesAdiNEW;
  If (fltPerDesAdiOLD <> fltPerDesAdiNEW) And (Not cdsItensPedido.IsEmpty) Then
    pRecalculaPorcentagemItens(True);
end;

procedure TfrmPedidoDeCompra.edtPerSubEnter(Sender: TObject);
begin
  inherited;
  fltVlrAlqSubOri := fStrToFloat(edtPerSub.Text);
end;

Function TfrmPedidoDeCompra.fVeSeRecalculaDesconto: TOpcaoDescontoItemCompra;
Begin
  pCriarFormularios(TfrmDecideDesconto, frmDecideDesconto);
  frmDecideDesconto.ShowModal;
  Result := frmDecideDesconto.ocDescontoItemCompra;
  pFreeAndNil(frmDecideDesconto);
End;

procedure TfrmPedidoDeCompra.lblCreForClick(Sender: TObject);
begin
  inherited;

  objCreditoFornecedor.pMostraCreditos;
end;

procedure TfrmPedidoDeCompra.lblExiApliClick(Sender: TObject);
var calcHeight: integer;
begin
  inherited;

  If pnlAplicacao.Visible Then
  Begin
    If (Not pnlAplicacao.Visible) And (Not pnlGiro.Visible) Then
      pnlContainerGiroAplica.Visible := False;
    pnlAplicacao.Visible := False;
    splGiro.Visible := False;
    lblExiApli.Caption  := 'Exibir Aplicação do Produto';
  End
  Else
  Begin
    If (Not pnlAplicacao.Visible) And (Not pnlGiro.Visible) Then
      pnlContainerGiroAplica.Visible := True;

    splAplicacao.Visible := True;
    splGiro.Visible := True;
    pnlAplicacao.Visible := True;
    pnlAplicacao.Height := fpnlAplicacaoHeight;
    splAplicacao.Top     := pnlAplicacao.Top;
    lblExiApli.Caption   := 'Ocultar Aplicação do Produto';
  End;



  calcHeight := 0;
  If pnlAplicacao.Visible Then
    calcHeight :=  fpnlAplicacaoHeight;

  If pnlAplicacao.Visible And pnlGiro.Visible Then
    calcHeight :=  calcHeight + FPnlGiroHeight + splGiro.Height;

  If (Not pnlAplicacao.Visible) And pnlGiro.Visible Then
    calcHeight :=  FPnlGiroHeight;

  pnlContainerGiroAplica.Height := calcHeight;

  splGiro.Top := pnlGiro.Top;

end;

procedure TfrmPedidoDeCompra.lblLegendasClick(Sender: TObject);
begin
  Try
    cdsLegendas := TLegendasItem.Create(Self, True);
    TfrmMostraLegendasItem.pMostraLegendas(cdsLegendas);
    cdsLegendas.fAbreClient(True,'');
  Finally
    FreeAndNil(cdsLegendas);
  End;
end;

procedure TfrmPedidoDeCompra.lblOcultarDadosGeraisDoPedidoClick(
  Sender: TObject);
begin
  inherited;

  If pnlGeral.Visible Then
  Begin
    pnlGeral.Visible := False;
    lblOcultarDadosGeraisDoPedido.Caption := 'Mostrar dados gerais do pedido';
  End Else
  Begin
    pnlGeral.Visible := True;
    pnlGeral.Top := 0;
    lblOcultarDadosGeraisDoPedido.Caption := 'Ocultar dados gerais do pedido';
  End;

end;

procedure TfrmPedidoDeCompra.pMostraDadosGerais;
Begin
  If Not pnlGeral.Visible Then
    lblOcultarDadosGeraisDoPedidoClick(Nil);
End;

procedure TfrmPedidoDeCompra.lblOpcGirClick(Sender: TObject);
begin
  inherited;

  fChamaCalculoGiro(recOpcGir,
                    True,  // blnCarregandoPedido,
                    True,  // blnShow
                    True); // blnConsulta
end;

procedure TfrmPedidoDeCompra.Lotesdoitem1Click(Sender: TObject);
begin
  inherited;

  If Not fVerificaAcessoSistema('CPLOTI', strLoginUsuarioLogado) Then
  Begin
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
    Exit;
  End;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(320, 12128, [12129,12130,12131,12132],
                      ['CODITE', 'FILLOJ'],
                      [GetCampoItem('ITE_CODITE').AsString, 'N'],
                      Sender,
                      ['CODITE'],
                      True);
  End;
end;

function TfrmPedidoDeCompra.GetCampoItem(ACampo: String): TField;
begin
  Result := dtsItensPedido.DataSet.FindField(ACampo);

  If Result = nil Then
    Result := dtsItensPedido.DataSet.FindField('ITE_'+ ACampo);

  If Result = nil Then
  Begin
    If Pos('_', ACampo) > 0 Then
      System.Delete(ACampo, 1, Pos('_', ACampo));
    Result := dtsItensPedido.DataSet.FindField(ACampo);
  End;
end;

procedure TfrmPedidoDeCompra.lblExiGiroClick(Sender: TObject);
var calcHeight: integer;
begin
  inherited;
  pnlGiro.Visible := Not pnlGiro.Visible;
  pnlContainerGiroAplica.Visible := (pnlAplicacao.Visible) Or (pnlGiro.Visible);


  If pnlGiro.Visible Then
  begin
    lblExiGiro.Caption   := 'Ocultar Informações de Giro';
    pnlGiro.Height := FPnlGiroHeight;
  end
  Else
  begin
    lblExiGiro.Caption  := 'Exibir Informações de Giro';
  end;
  calcHeight := 0;
  If pnlAplicacao.Visible Then
    calcHeight :=  fpnlAplicacaoHeight;

  If pnlAplicacao.Visible And pnlGiro.Visible Then
    calcHeight :=  calcHeight + FPnlGiroHeight + splGiro.Height;

  If (Not pnlAplicacao.Visible) And pnlGiro.Visible Then
    calcHeight :=  FPnlGiroHeight;

  pnlContainerGiroAplica.Height := calcHeight;


end;

procedure TfrmPedidoDeCompra.mnAbrirKardexClick(Sender: TObject);
begin
  If dtsItensPedido.Dataset.IsEmpty Then
     Exit;

  If Assigned(prcExecutaRelatorio) Then
     prcExecutaRelatorio(34, 2951, [2951,2958],
                        ['CODEMP','CODITE'],
                        [VS_STRCODEMP,dtsItensPedido.Dataset.FieldByName('ITE_CODITE').AsString],
                        Sender, Nil, True, True, 'frmRelEstKardex');
end;

procedure TfrmPedidoDeCompra.mnConfiguraKardexClick(Sender: TObject);
begin
  inherited;
  If dtsItensPedido.Dataset.IsEmpty Then
     Exit;

  If Assigned(prcExecutaRelatorio) Then
     prcExecutaRelatorio(34, 2951, [2951,2958],
                        ['CODEMP','CODITE'],
                        [VS_STRCODEMP,dtsItensPedido.Dataset.FieldByName('ITE_CODITE').AsString],
                        Sender, Nil, False, True, 'frmRelEstKardex');

end;

procedure TfrmPedidoDeCompra.mnuCadastrodeProdutosClick(Sender: TObject);
  Var
    strCodIte: String;
begin
  inherited;

  If cdsItensPedido.IsEmpty Then
    strCodIte := ''
  Else
    strCodIte := cdsItensPedido.FieldByName('ITE_CODITE').AsString;

  prcCadProdutos(strCodIte);
end;

procedure TfrmPedidoDeCompra.mnuCompraAntigaClick(Sender: TObject);
begin
  inherited;
  If Not mnuCompraAntiga.Visible Then
    Exit;
  pCriarFormularios(TfrmFatConsVendasAntigas, frmFatConsVendasAntigas);
  Try
    frmFatConsVendasAntigas.pSetarParaConsultaDeCompra;
    If not fEmptyStr(cdsItensPedido.FieldByName('ITE_CODITE').AsString) Then
      frmFatConsVendasAntigas.edtProdutos.Text := cdsItensPedido.FieldByName('ITE_CODITE').AsString;
    frmFatConsVendasAntigas.ShowModal;
  Finally
    FreeAndNil(frmFatConsVendasAntigas);
  End;
end;

procedure TfrmPedidoDeCompra.mnuConsultadePedidodeComprasClick(Sender: TObject);
  Var
    frmPedidoCompraLiberacao: TfrmPedidoCompraLiberacao;
begin
  If Not mnuConsultadePedidodeCompras.Visible Then
    Exit;
  pCriarFormularios(TfrmPedidoCompraLiberacao, frmPedidoCompraLiberacao);
  Try
    frmPedidoCompraLiberacao.pImprimePedidoCompra := untFuncoesPedido.pImprimePedidoCompra;
    frmPedidoCompraLiberacao.ShowModalConsultaPedidoCompra;
  Finally
    pFreeAndNil(frmPedidoCompraLiberacao);
  End;
end;

procedure TfrmPedidoDeCompra.mnuFormacaodePrecosClick(Sender: TObject);
begin
  If mnuFormacaodePrecos.Visible Then
    prcAbreTelaPrecos(cdsItensPedido.FieldByName('ITE_CODITE').AsString);
end;

procedure TfrmPedidoDeCompra.mnuPedidodeComprasGridClick(Sender: TObject);
begin
  inherited;

  If cdsItensPedido.IsEmpty Then
    Exit;

  pExibirRelPedidoCompraGrid(cdsItensPedido.FieldByName('ITE_CODITE').AsString,
                             cdsItensPedido.FieldByName('ITE_DESITE').AsString)

end;

procedure TfrmPedidoDeCompra.mnuPreparaesdeTEdoPedidoClick(Sender: TObject);
begin
  inherited;

  If Not mnuPreparaesdeTEdoPedido.Visible Then
    Exit;

  If Assigned(cdsDigMultLoja) And Assigned(cdsDigMultLoja.objPreparaGerMultiLoja) Then
  Begin
    pCriarFormularios(TfrmLiberaPrepTE, frmLiberaPrepTE);

    frmLiberaPrepTE.oblPrepTe := cdsDigMultLoja.objPreparaGerMultiLoja;
    frmLiberaPrepTE.ShowModal;

    pFreeAndNil(frmLiberaPrepTE);
  End

end;

procedure TfrmPedidoDeCompra.mnuRelEmprestimosClick(Sender: TObject);
begin
  inherited;
  If dtsItensPedido.Dataset.IsEmpty Then
     Exit;

  If Assigned(prcExecutaRelatorio) Then
              prcExecutaRelatorio(12, 1325, [1325,1327],
                                  ['CODITE'],
                                  [dtsItensPedido.Dataset.FieldByName('ITE_CODITE').AsString],
                                  Sender);
end;

procedure TfrmPedidoDeCompra.mnuVisImgClick(Sender: TObject);
begin
  inherited;

  If dtsItensPedido.Dataset.IsEmpty Then
     Exit;

  TfrmImagens.pAbrirImagens(tiProduto, dtsItensPedido.Dataset.FieldByName('ITE_CODITE').AsString, (cdsItensPedido.State <> dsEdit), '', '', True);
end;

procedure TfrmPedidoDeCompra.mskDtaFatEnter(Sender: TObject);
begin
  inherited;

  dtaDtaFatAnt := StrToDateDef(mskDtaFat.Text, VS_Date);
end;

procedure TfrmPedidoDeCompra.mskDtaFatExit(Sender: TObject);
begin
  inherited;

  If (Not cdsItensPedido.IsEmpty) And
     (dtaDtaFatAnt <> StrToDateDef(mskDtaFat.Text, VS_Date)) And  mskDtaPed.ReadOnly Then
       If fPergunta('Deseja recalcular as datas de entrega dos itens?') Then
         pRecalculaDatasEntrega
       Else
         btnCancelaItem.Click;
end;

function TfrmPedidoDeCompra.fAplicaAliquota: double;
  var fltTotIte: Double;
Begin
  fltTotIte := fStrToFloat(edtValTot.Text);

  If (strFrmPcm = '1') Then
    fltTotIte := fltTotIte + fStrToFloat(edtTotIpi.Text);

  Result := (fltTotIte * fStrToFloat(edtPerSub.Text)) / 100;
End;

Function TfrmPedidoDeCompra.fRecalculaDatasEntrega(pgbProgresso: TcxProgressBar): Boolean;
Begin
  Result := True;

  With cdsItensPedido Do
  Begin
    Try
      pgbProgresso.Properties.Max := RecordCount;

      First;

      While Not Eof Do
      Begin
        Edit;

        FieldByName('ITE_DTAENT').AsDateTime := StrToDateDef(mskDtaFat.Text, VS_Date) + FieldByName('ITE_DTAENT').AsDateTime - dtaDtaFatAnt;

        Post;

        Next;

        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;

      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmPedidoDeCompra.fRecalculaDatasEntrega]');
      End;
    End;

    btnCancelaItem.Click;

    EnableControls;
  End;

End;

procedure TfrmPedidoDeCompra.pRecalculaCodigoFabricaDoProduto;
var
  intRecNo: Integer;
  strCodFab: String;
begin
  If cdsItensPedido.IsEmpty Then
    Exit;

  If fEmptyStr(edtCodFor.Text) Then
    Exit;

  intRecNo := cdsItensPedido.RecNo;

  Try
    cdsItensPedido.AfterScroll := Nil;
    cdsItensPedido.DisableControls;

    cdsItensPedido.First;
    While Not cdsItensPedido.Eof Do
    Begin
      strCodFab := fRetornaCodigoFabricaItem(cdsItensPedido.FieldByName('ITE_CODITE').AsString);

      cdsItensPedido.Edit;
      cdsItensPedido.FieldByName('ITE_CODFAB').AsString := strCodFab;
      cdsItensPedido.Post;

      cdsItensPedido.Next;
    End;
  Finally
    pAferScroll(cdsItensPedido);
    cdsItensPedido.EnableControls;
  End;

  cdsItensPedido.RecNo := intRecNo;
end;

procedure TfrmPedidoDeCompra.pRecalculaDatasEntrega;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);

    With frmGravando Do
    Begin
      lblGravando.Caption := 'Recalculando datas de entrega, aguarde...';

      fExecutarAcao := fRecalculaDatasEntrega;

      ShowModal;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmPedidoDeCompra.pRecalculaDatasEntrega]');
    End;
  End;

  pFreeAndNil(frmGravando);
End;

procedure TfrmPedidoDeCompra.pRetDescontoFornecedor(strCodIte, strCodFor: String; fltEmbala: Double; Var fltUnitar: Double;
  Var recDescontoItem: TRecDescontoItem);
  Var
    qryDescon: TUniQuery;
Begin
  fltUnitar    := 0;
  qryDescon := fCriaQuery;

  With qryDescon, SQL Do
  Begin
    Add('SELECT SQL_NO_CACHE ');
    Add('  IF(D.ITE_CODITE IS NULL, I.ITE_DESF01, D.ITE_DESF01) AS ITE_DESF01, ');
    Add('  IF(D.ITE_CODITE IS NULL, I.ITE_DESF02, D.ITE_DESF02) AS ITE_DESF02, ');
    Add('  IF(D.ITE_CODITE IS NULL, I.ITE_DESF03, D.ITE_DESF03) AS ITE_DESF03, ');
    Add('  IF(D.ITE_CODITE IS NULL, I.ITE_DESF04, D.ITE_DESF04) AS ITE_DESF04, ');
    Add('  IF(D.ITE_CODITE IS NULL, I.ITE_DESF05, D.ITE_DESF05) AS ITE_DESF05, ');
    Add('  IF(D.ITE_CODITE IS NULL, I.ITE_DESF06, D.ITE_DESF06) AS ITE_DESF06, ');

    If blnUtiInd Then
    Begin
      Add(' IF(D.ITE_CODITE IS NULL, I.ITE_PRECOM, D.ITE_PRECOM / IF(IFNULL(F.ITE_CNVCUS, 0) <> 0, F.ITE_CNVCUS, 1)) * ');
      Add(' IF(IF(D.ITE_CODITE IS NULL, I.ITE_PREDOL, D.ITE_PREDOL) = "S", (SELECT MOE_DOLVEN FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1), 1) AS ITE_PRECOM ');
    End Else
    Begin
      Add(' IF(D.ITE_CODITE IS NULL, I.ITE_PRECOM, D.ITE_PRECOM / IF(IFNULL(F.ITE_CNVCUS, 0) <> 0, F.ITE_CNVCUS, 1)) AS ITE_PRECOM ');
    End;

    Add('FROM');
    Add('ITEGER I ');

    Add('LEFT JOIN ITEFOR F ON F.ITE_CODITE = I.ITE_CODITE AND');
    Add('                      F.ITE_CODFOR = :CODFOR AND     ');
    Add('                      (SELECT COUNT(*) FROM TABPRE   ');
    Add('                       WHERE F.ITE_CODTAB = TAB_CODTAB AND' + fSqlWhereTabPre(strPrF_AE, recOpcGir.strCodTab) + ') > 0');

    Add('  LEFT JOIN TABDET D ON D.ITE_CODTAB = F.ITE_CODTAB ');
    Add('                    AND D.ITE_CODITE = F.ITE_CODITE ');
    Add('                    AND D.ITE_CODEMP = I.ITE_CODEMP ');

    Add('WHERE');
    Add('  I.ITE_CODITE = :CODITE AND ');
    Add('  I.ITE_CODEMP = :CODEMP');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CODFOR').AsString := strCodFor;

    Open;

    If Not IsEmpty Then
    Begin
      fltUnitar    := FieldByName('ITE_PRECOM').AsFloat;

      If fltEmbala = 0 Then
        fltEmbala := 1;

      fltUnitar    := fltUnitar * fltEmbala;

      recDescontoItem.arrDesUni[DESCONTO1] := FieldByName('ITE_DESF01').AsFloat;
      recDescontoItem.arrDesUni[DESCONTO2] := FieldByName('ITE_DESF02').AsFloat;
      recDescontoItem.arrDesUni[DESCONTO3] := FieldByName('ITE_DESF03').AsFloat;
      recDescontoItem.arrDesUni[DESCONTO4] := FieldByName('ITE_DESF04').AsFloat;
      recDescontoItem.arrDesUni[DESCONTO5] := FieldByName('ITE_DESF05').AsFloat;
      recDescontoItem.arrDesUni[DESCONTO6] := FieldByName('ITE_DESF06').AsFloat;
    End;
  End;

  FreeAndNil(qryDescon);
End;

procedure TfrmPedidoDeCompra.pRecalculaPorcentagemItens(blnAlterandoDescontoAdcional: Boolean = False);
  Var
    strCodSit,
    strCodSitOrigem,
    strUnitario: String;
    qryAtualiza: TUniQuery;
    fltDesAdi,
    fltBasIcm,
    fltAlqIcm,
    fltValIcm,
    fltBaseST,
    fltDesPis,
    fltPerFCP,
    fltSubFCP,
    fltTotDar,
    fltTotIteDes: Double;
    intRecNo: Integer;

    fltVlrAliquotaSub,
    fltUnitar: Double;
    qryTrib: TUniQuery;
    fltBasIpi,
    fltAlqIPI,
    fltRepFre,
    fltValIPI: Double;
    recDescontoItem,
    recDescontoItemCursor: TRecDescontoItem;
    ocOpcaoDescontoItemCompra: TOpcaoDescontoItemCompra;
begin
  ocOpcaoDescontoItemCompra := TOpcaoDescontoItemCompra.odDigitadoAdicionais;//padrão manter aquilo que foi digitado
  qryTrib := fCriaQuery;

  Try

    Try
      qryAtualiza := fCriaQuery(Self);

      intRecNo    := cdsItensPedido.RecNo;

      recDescontoItemCursor := fObterDescontosItem(True);
      objCopiaSeg.recPcmger.blnSomaDescontoAdcionalFornecedor1 := False;

      If (strUniPcg <> '7') then
      begin
        recDescontoItemCursor.fltDesAdi := recDescontoItemCursor.arrDesUni[DESCONTO1];
        recDescontoItemCursor.arrDesUni[DESCONTO1] := 0;
      End;

      if (strUniPcg = '7') then
      Begin
        ocOpcaoDescontoItemCompra := fVeSeRecalculaDesconto;
        objCopiaSeg.blnSomaDescontoAdcionalFornecedor1 := (ocOpcaoDescontoItemCompra = odSomaAdcionaisDescForne01);
      End;

      With cdsItensPedido Do
      Begin
        AfterScroll := Nil;

        DisableControls;

        fltDesAdi := fStrToFloat(edtDesAdi.Text);

        First;

        While Not Eof Do
        Begin
         ParametrosCalcImpostos.pSetaParametros(FieldByName('ITE_CICMDE').AsString,
                                                 FieldByName('ITE_CDPIOP').AsString,
                                                 FieldByName('ITE_DIDIOP').AsString);

          recDescontoItem.Create(fltDesAdi, intDecUni);

          case ocOpcaoDescontoItemCompra of
             odFornecedorEAdicionais:
             begin
               pRetDescontoFornecedor(FieldByName('ITE_CODITE').AsString, edtCodFor.Text,
                                      FieldByName('ITE_EMBALA').AsFloat,
                                      fltUnitar, recDescontoItem);

             end;

             odDigitadoAdicionais,
             odSomaAdcionaisDescForne01:
             begin
               fltUnitar    := FieldByName('ITE_UNITAR').AsFloat;
               if intRecNo = cdsItensPedido.RecNo then
                 recDescontoItem := recDescontoItemCursor
               else
                 pCarregarDescontosItemGrid(recDescontoItem);
             end;

             odSomenteAdicionais:
             begin
               fltUnitar    := FieldByName('ITE_UNITAR').AsFloat;
             end;
          end;

          pExibirDescontos(recDescontoItem);

          If strUniPcg <> '7' Then
          begin
            recDescontoItem.arrDesUni[DESCONTO1] := recDescontoItem.fltDesAdi;
            recDescontoItem.fltDesAdi := 0;
          End;

          fValidaDescontoUnitario(edtDesUni, edtDesUn2, edtDesUn3, edtDesUn4, edtDesUn5, edtDesUn6, False);

          strUnitario := FloatToStrF(recDescontoItem.fCalcularValorDescontado(objCopiaSeg.recPcmger.blnSomaDescontoAdcionalFornecedor1, fltUnitar),
                                     ffNumber,
                                     12,
                                     intDecUni);

          fltTotIteDes := (FieldByName('ITE_QTDITE').AsFloat * fStrToFloat(strUnitario));


          Edit;

          FieldByName('ITE_UNITAR').AsFloat  := fltUnitar;

          FieldByName('ITE_DESUNI').AsFloat  :=  recDescontoItem.arrDesUni[DESCONTO1];
          FieldByName('ITE_DESUN2').AsFloat  :=  recDescontoItem.arrDesUni[DESCONTO2];
          FieldByName('ITE_DESUN3').AsFloat  :=  recDescontoItem.arrDesUni[DESCONTO3];
          FieldByName('ITE_DESUN4').AsFloat  :=  recDescontoItem.arrDesUni[DESCONTO4];
          FieldByName('ITE_DESUN5').AsFloat  :=  recDescontoItem.arrDesUni[DESCONTO5];
          FieldByName('ITE_DESUN6').AsFloat  :=  recDescontoItem.arrDesUni[DESCONTO6];


          FieldByName('ITE_UNILIQ').AsFloat  := fStrToFloat(strUnitario);
          FieldByName('ITE_TOTITE').AsFloat  := fltTotIteDes;

          fltBasIpi :=  fltTotIteDes;
          fltRepFre := (fltValFreSalvo*100)/fltTotIteDes;
          If (objCopiaSeg.recPcmger.strIPIFre = 'S') And (fltRepFre > 0) And (fltBasIpi > 0) Then
            fltBasIpi := fltBasIpi + (fltBasIpi * fltRepFre /100);

          fltAlqIPI :=  FieldByName('ITE_PERIPI').AsFloat;
          fltValIPI :=  (fltBasIpi * (FieldByName('ITE_PERIPI').AsFloat / 100));


          fltTotSubCal := fCalcularSubstituicaoProduto(edtCodFor.Text,                                               // strCodFor,
                                                       fRetornaAbreviacaoItem(FieldByName('ITE_CODITE').AsString),   // strCodAbf: String;
                                                       fltTotIteDes,                                                 // fltTotIte,
                                                       fltValFreSalvo,
                                                       fltDesAceSalvo ,
                                                       strFRMPCM,                                                    // strFrmPcm,
                                                       objCopiaSeg.recPcmger.strBStFre,                              // strBStFre,
                                                       objCopiaSeg.recPcmger.strBStAce,                              // strBStAce: String;
                                                       blnZonaFranca,                                                // blnZonaFranca,
                                                       FieldByName('ITE_INCPIS').AsString = 'S',                     // blnIncPis,
                                                       strSimPau = 'S',                                              // blnFornecSimples: Boolean;
                                                       blnTemDare,
                                                       fltAlqIPI,                                                    // fltAlqIPI: Double;
                                                       chkZeraST.Checked,
                                                       fltBasIcm,                                                    // Var fltBasIcm,
                                                       fltAlqIcm,                                                    // fltAlqIcm,
                                                       fltValIcm,                                                    // fltValIcm,
                                                       fltBaseST,                                                    // fltBaseST,
                                                       fltDesPis,                                                    // fltDesPis,
                                                       fltBasIPI,                                                    // fltBasIPI,
                                                       fltValIPI,                                                    // fltValIPI,
                                                       fltPerFCP,                                                    // fltPerFCP,
                                                       fltSubFCP,                                                    // fltSubFCP: Double;
                                                       fltTotDar,                                                    // fltTotDar
                                                       strCodSit,                                                    // strCodSit: String;
                                                       strCodSitOrigem,                                              // strCodSitOrigem: String;
                                                       fltVlrAliquotaSub,                                            // fltAliquotaSub: Double;
                                                       ParametrosCalcImpostos,                                       // ParametrosImpostos: TParametrosCalculoImposto;
                                                       strTipAbfFor,                                                 // strTipAbfFor: String = '';
                                                       qryTrib);                                                     // qryDadosAbf: TUniQuery = Nil): Double;

         fltIcmDesCal := 0;
         If ParametrosCalcImpostos.blnCalcularICMSDesonerado Then
           fltIcmDesCal := fltValIcm;

          If FieldByName('ITE_SUBUSU').AsString <> 'S' Then
          Begin
            FieldByName('ITE_TOTSUB').AsFloat  := fltTotSubCal;
            FieldByName('ITE_PERSUB').AsFloat  := fltVlrAliquotaSub;
            If ParametrosCalcImpostos.blnCalcularICMSDesonerado Then
               FieldByName('ITE_VALICM').AsFloat  := fltValICM
             Else
             FieldByName('ITE_VALICM').AsFloat  := 0;

            FieldByName('ITE_TOTDAR').AsFloat  := fltTotDar;
          End;

          FieldByName('ITE_BASIPI').AsFloat  := fltBasIPI;
          FieldByName('ITE_TOTIPI').AsFloat  := fltValIPI;

          FieldByName('ITE_BASICM').AsFloat  := fltBasICM;
          FieldByName('ITE_PERBAS').AsFloat  := 100;
          FieldByName('ITE_ALQICM').AsFloat  := fltAlqICM;
          FieldByName('ITE_BASSUB').AsFloat  := fltBaseST;
          FieldByName('ITE_DESPIS').AsFloat  := fltDesPis;

          FieldByName('ITE_PERFCP').AsFloat  := fltPerFCP;
          FieldByName('ITE_SUBFCP').AsFloat  := RoundTo(FieldByName('ITE_TOTSUB').AsFloat * fltPerFCP / 100, -2);

          FieldByName('ITE_CODSIT').AsString := strCodSit;
          FieldByName('ITE_SITORI').AsString := strCodSitOrigem;
          pCalculaImpostosReformaItem(cdsItensPedido, chkPedImp.Checked);
          pCalculaUniImp(cdsItensPedido, recDescontoItem);
          Post;

          If Not blnFormShow Then
            objCopiaSeg.pAtualizaItem;


          Next;

        End;

        pRateiaFreteDesAce(fltValFreGer + fltDesAceGer > 0, fltValFreGer, fltDesAceGer,
                           objCopiaSeg.recPcmger.strBStFre,
                           objCopiaSeg.recPcmger.strBStAce,
                           objCopiaSeg.recPcmger.strIpiFre);


        pAferScroll(cdsItensPedido);
        EnableControls;


      End;

    Finally
      FreeAndNil(qryAtualiza);
    End;


    cdsItensPedido.RecNo := intRecNo;
    recDescontoItem := fObterDescontosItemGrid;
    pExibirDescontos(recDescontoItem);

    pLimpaDadosItem;

    If (Not blnAlterando) And (Not cdsItensPedido.FieldByName('ITE_CODITE').IsNull) Then
    Begin
      edtCodIte.Text := cdsItensPedido.FieldByName('ITE_CODITE').AsString;
      pCarregaItem;
    End;

    pSetFocus(edtCodIte);
    pCalculaTotalItem(True);
  Finally
    FreeAndNil(qryTrib)
  End;
end;

Function TfrmPedidoDeCompra.fRecalcularSubstituicaoTributaria: Boolean;
  var pBeforePost: TDataSetNotifyEvent;
      intRecNoBkp: Integer;
Begin
  If (Not cdsItensPedido.active) then
    Exit(False);

  If cdsItensPedido.IsEmpty Then
    Exit(False);

  cdsItensPedido.AfterScroll := Nil;
  pBeforePost := cdsItensPedido.BeforePost;

  If blnSuspendeEventoPost Then
  Begin
  cdsItensPedido.AfterPost   := Nil;
  cdsItensPedido.BeforePost  := Nil;
  end;

  intRecNoBkp := cdsItensPedido.RecNo;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Calculando substituição tributária...';
    frmGravando.fExecutarAcao := fRecalcularSubstituicaoTributariaAux;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmPedidoDeCompra.fRecalcularSubstituicaoTributaria]');
    End;
  End;

  pFreeAndNil(frmGravando);
  cdsItensPedido.AfterScroll := pAferScroll;
  pAferScroll(cdsItensPedido);
  If blnSuspendeEventoPost Then
  Begin
  cdsItensPedido.AfterPost   := pAfterPost;
  cdsItensPedido.BeforePost  := pBeforePost;
  End;
  cdsItensPedido.RecNo := intRecNoBkp;
End;

Function TfrmPedidoDeCompra.fGetDiaFor: Integer;
Begin
  If qryConFor.IsEmpty Then
    Result := fCampoTabela('FOR_DIAENT', 'CADFOR', ['FOR_CODFOR'], [edtCodFor.Text])
  Else
    Result := qryConFor.FieldByName('FOR_DIAENT').AsInteger;
End;

{function TfrmPedidoDeCompra.fGetOrdemDoGrid(
  view: TcxGridDBTableView): String;
Var
    intCont: Integer;
    strFieldName: String;
begin
  If view.SortedItemCount > 0 Then
  Begin
    Result := '';
    For intCont := 0 To view.SortedItemCount - 1 Do
    Begin
      strFieldName := view.SortedItems[intCont].DataBinding.FilterFieldName.Trim.Replace(' ','');
      If cdsItensPedido.FindField(strFieldName) <> nil Then
        Result := Result + ' ' +
           strFieldName +
          IfThen(view.SortedItems[intCont].SortOrder = soDescending, ' DESC');
    End;
  End;
end;}

Function TfrmPedidoDeCompra.fRecalcularSubstituicaoTributariaAux(pgbProgresso: TcxProgressBar): Boolean;
  Var
    strFrmPcm,
    strIndex,
    strIndexMult,
    strTipAbfFor,
    strTipAbf,
    strCodSit,
    strCodSitOrigem,
    strCodAbf: String;
    fltVlrAliquotaSub,
    fltFatorST,
    fltFatorDar: Double;
    fltFatBasIcm,
    fltFatValIcm,
    fltFatBasSub,
    fltFatDesPis,

    fltTotSubAtu,
    fltTotDarAtu: Double;
    fltBasIcm,
    fltAlqIcm,
    fltValIcm,
    fltBaseST,
    fltDesPis,
    fltPerFCP,
    fltSubFCP,
    fltBasIPI,
    fltAlqIPI,
    fltValIPI,
    fltQtdIte,
    fltTotDar: Double;

    qryDadosAbf: TUniQuery;

    intRecNo,
    intDiaFor: Integer;
begin
  Result := True;

  If chkPedImp.Checked  Then
    Exit;

  If fEmptyStr(edtCodFor.Text) Then
    Exit;

  qryDadosAbf  := fCriaQuery(Nil);

  strIndex     := cdsItensPedido.IndexFieldNames;

  If Assigned(cdsDigMultLoja) Then
  Begin
    cdsDigMultLoja.desvinculaCDS;
    cdsDigMultLoja.blnValidarDados := False;
  End;

  Try
    If Assigned(cdsItensMultiLojas) Then
    Begin
      strIndexMult := cdsItensMultiLojas.IndexFieldNames;
      cdsItensMultiLojas.Filtered := False;
    End;

    Try

      pgbProgresso.Properties.Max := cdsItensPedido.RecordCount;
      Application.ProcessMessages;

      strTipAbf    := fCfgSis('TIPABF');
      strFrmPcm    := fCfgSis('FRMPCM');
      strTipAbfFor := fGetTipoAbfFornecedor(edtCodFor.Text);

      intDiaFor := fGetDiaFor;

      cdsItensPedido.DisableControls;
      cdsItensPedido.IndexFieldNames := 'ITE_CODABF';

      cdsItensPedido.First;

      If Assigned(cdsItensMultiLojas) Then
      Begin
        cdsItensMultiLojas.DisableControls;
        cdsItensMultiLojas.IndexFieldNames := 'ITE_CODITE';
      End;

      While (Not cdsItensPedido.Eof) Do
      Begin
        ParametrosCalcImpostos.pSetaParametros(cdsItensPedido.FieldByName('ITE_CICMDE').AsString,
                                               cdsItensPedido.FieldByName('ITE_CDPIOP').AsString,
                                               cdsItensPedido.FieldByName('ITE_DIDIOP').AsString);


        If fEmptyStr(cdsItensPedido.FieldByName('ITE_CODABF').AsString) Then
          strCodAbf := fRetornaAbreviacaoItem(cdsItensPedido.FieldByName('ITE_CODITE').AsString, strTipAbf)
        Else
          strCodAbf := cdsItensPedido.FieldByName('ITE_CODABF').AsString;

        cdsItensPedido.Edit;

        If cdsItensPedido.FieldByName('ITE_DTAENT').IsNull Then
        Begin
          If blnOriIte Then
            cdsItensPedido.FieldByName('ITE_DTAENT').AsDateTime := StrToDateDef(mskDtaFat.Text, VS_Date) +
                                                                      cdsItensPedido.FieldByName('ITE_DIAFOR').AsInteger
          Else
            cdsItensPedido.FieldByName('ITE_DTAENT').AsDateTime := StrToDateDef(mskDtaFat.Text, VS_Date) + intDiaFor;
        End;

        fltBasIPI := cdsItensPedido.FieldByName('ITE_TOTITE').AsFloat;

        If cdsItensPedido.FieldByName('ITE_BASIPI').AsFloat > 0 Then
          fltAlqIPI := (cdsItensPedido.FieldByName('ITE_TOTIPI').AsFloat * 100) / cdsItensPedido.FieldByName('ITE_BASIPI').AsFloat
        Else
          fltAlqIPI := 0;

        fltValIPI := cdsItensPedido.FieldByName('ITE_TOTIPI').AsFloat;

        fltTotSubCal := fCalcularSubstituicaoProduto(edtCodFor.Text,                                   //  strCodFor,
                                         strCodAbf,                                                    //  strCodAbf: String;
                                         cdsItensPedido.FieldByName('ITE_TOTITE').AsFloat,             //  fltTotIte,
                                         cdsItensPedido.FieldByName('ITE_VALFRE').AsFloat,             //  fltTotFre,
                                         cdsItensPedido.FieldByName('ITE_DESACE').AsFloat,             //  fltTotAce: Double;
                                         strFrmPcm,                                                    //  strFrmPcm,
                                         objCopiaSeg.recPcmger.strBStFre,                              //  strBStFre,
                                         objCopiaSeg.recPcmger.strBStAce,                              //  strBStAce: String;
                                         blnZonaFranca,                                                //  blnZonaFranca,
                                         cdsItensPedido.FieldByName('ITE_INCPIS').AsString = 'S',      //  blnIncPis,
                                         strSimPau = 'S',                                              //  blnFornecSimples: Boolean;
                                         blnTemDare,
                                         fltAlqIPI,                                                    //  fltAlqIPI: Double;
                                         chkZeraST.Checked,
                                         fltBasIcm,                                                    //  fltBasIcm,
                                         fltAlqICM,                                                    //  fltAlqIcm,
                                         fltValIcm,                                                    //  fltValIcm,
                                         fltBaseST,                                                    //  fltBaseST,
                                         fltDesPis,                                                    //  fltDesPis,
                                         fltBasIPI,                                                    //  fltBasIPI,
                                         fltValIPI,                                                    //  fltValIPI,
                                         fltPerFCP,                                                    //  fltPerFCP,
                                         fltSubFCP,                                                    //  fltSubFCP: Double;
                                         fltTotDar,                                                    //  fltTotDat
                                         strCodSit,                                                    //  strCodSit: String;
                                         strCodSitOrigem,                                              //  strCodSitOrigem: String;
                                         fltVlrAliquotaSub,                                            //  fltAliquotaSub: Double;
                                         ParametrosCalcImpostos,                                       //  ParametrosImpostos: TParametrosCalculoImposto;
                                         strTipAbfFor,                                                 //  strTipAbfFor: String = '';
                                         qryDadosAbf);                                                 //  qryDadosAbf: TUniQuery = Nil): Double;

        fltIcmDesCal := 0;
        If ParametrosCalcImpostos.blnCalcularICMSDesonerado Then
          fltIcmDesCal := fltValIcm;

        If cdsItensPedido.FieldByName('ITE_SUBUSU').AsString <> 'S' Then
        Begin
          cdsItensPedido.FieldByName('ITE_TOTSUB').AsFloat := fltTotSubCal;
          cdsItensPedido.FieldByName('ITE_PERSUB').AsFloat := fltVlrAliquotaSub;
          If ParametrosCalcImpostos.blnCalcularICMSDesonerado Then
            cdsItensPedido.FieldByName('ITE_VALICM').AsFloat := fltValIcm;
          fltVlrAlqSubOri := fltVlrAliquotaSub;

          cdsItensPedido.FieldByName('ITE_TOTDAR').AsFloat := fltTotDar;
        End;
        cdsItensPedido.FieldByName('ITE_BASIPI').AsFloat := fltBasipi;
        cdsItensPedido.FieldByName('ITE_TOTIPI').AsFloat := fltValIpi;
        cdsItensPedido.FieldByName('ITE_BASICM').AsFloat  := fltBasIcm;
        cdsItensPedido.FieldByName('ITE_PERBAS').AsFloat  := 100;
        cdsItensPedido.FieldByName('ITE_ALQICM').AsFloat  := fltAlqIcm;
        cdsItensPedido.FieldByName('ITE_BASSUB').AsFloat  := fltBaseST;
        cdsItensPedido.FieldByName('ITE_DESPIS').AsFloat  := fltDesPis;

        cdsItensPedido.FieldByName('ITE_PERFCP').AsFloat  := fltPerFCP;
        cdsItensPedido.FieldByName('ITE_SUBFCP').AsFloat  := RoundTo(cdsItensPedido.FieldByName('ITE_TOTSUB').AsFloat * fltPerFCP / 100, -2);

        cdsItensPedido.FieldByName('ITE_CODSIT').AsString := strCodSit;
        cdsItensPedido.FieldByName('ITE_SITORI').AsString := strCodSitOrigem;

        pCalculaImpostosReformaItem(cdsItensPedido, chkPedImp.Checked);

        pCalculaUniImp(cdsItensPedido);

        cdsItensPedido.Post;

        pIncluiNaListaConsulta  ;

        If Not cdsItensMultiLojas.IsEmpty Then
        Begin
          cdsItensMultiLojas.First;
          cdsItensMultiLojas.FindKey([cdsItensPedido.FieldByName('ITE_CODITE').AsString]);


         // cdsItensMultiLojas.Filter   := 'ITE_CODITE = ' + QuotedStr(cdsItensPedido.FieldByName('ITE_CODITE').AsString);
         // cdsItensMultiLojas.Filtered := True;
         // cdsItensMultiLojas.First;

          fltTotSubAtu := 0;
          fltTotDarAtu := 0;
          fltQtdIte    := cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat;

          If fltQtdIte <= 0 Then
            fltQtdIte := 1;

          fltFatorST   := cdsItensPedido.FieldByName('ITE_TOTSUB').AsFloat / fltQtdIte;
          fltFatorDar  := cdsItensPedido.FieldByName('ITE_TOTDAR').AsFloat / fltQtdIte;
          fltFatBasIcm := cdsItensPedido.FieldByName('ITE_BASICM').AsFloat / fltQtdIte;
          fltFatValIcm := cdsItensPedido.FieldByName('ITE_VALICM').AsFloat / fltQtdIte;
          fltFatBasSub := cdsItensPedido.FieldByName('ITE_BASSUB').AsFloat / fltQtdIte;
          fltFatDesPis := cdsItensPedido.FieldByName('ITE_DESPIS').AsFloat / fltQtdIte;

          intRecNo := -1;

          While (Not cdsItensMultiLojas.Eof) And
                (cdsItensMultiLojas.FieldByName('ITE_CODITE').AsString = cdsItensPedido.FieldByName('ITE_CODITE').AsString) Do
          Begin
            cdsItensMultiLojas.Edit;

            cdsItensMultiLojas.FieldByName('ITE_TOTSUB').AsFloat :=
                                        RoundTo(fltFatorST * cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat, -2);

            cdsItensMultiLojas.FieldByName('ITE_TOTDAR').AsFloat :=
                                        RoundTo(fltFatorDar * cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat, -2);

            cdsItensMultiLojas.FieldByName('ITE_PERFCP').AsFloat := cdsItensPedido.FieldByName('ITE_PERFCP').AsFloat;

            cdsItensMultiLojas.FieldByName('ITE_SUBFCP').AsFloat :=
                                        RoundTo(cdsItensMultiLojas.FieldByName('ITE_TOTSUB').AsFloat * cdsItensMultiLojas.FieldByName('ITE_PERFCP').AsFloat / 100, -2);

            cdsItensMultiLojas.FieldByName('ITE_BASSUB').AsFloat :=
                                        RoundTo(fltFatBasSub * cdsItensMultiLojas.FieldByName('ITE_BASSUB').AsFloat, -2);

            cdsItensMultiLojas.FieldByName('ITE_BASICM').AsFloat  :=
                                        RoundTo(fltFatBasIcm * cdsItensMultiLojas.FieldByName('ITE_BASICM').AsFloat, -2);

            cdsItensMultiLojas.FieldByName('ITE_ALQICM').AsFloat  := fltAlqIcm;

            cdsItensMultiLojas.FieldByName('ITE_VALICM').AsFloat  := RoundTo(fltFatValIcm * cdsItensMultiLojas.FieldByName('ITE_VALICM').AsFloat, -2);

            cdsItensMultiLojas.FieldByName('ITE_DESPIS').AsFloat  := RoundTo(fltFatDesPis * cdsItensMultiLojas.FieldByName('ITE_DESPIS').AsFloat, -2);

            pCopiaAliquotasReforma(cdsItensPedido, cdsItensMultiLojas, chkPedImp.Checked);

            cdsItensMultiLojas.Post;

            intRecNo := cdsItensMultiLojas.RecNo;

            fltTotSubAtu := fltTotSubAtu + cdsItensMultiLojas.FieldByName('ITE_TOTSUB').AsFloat;

            fltTotDarAtu := fltTotDarAtu + cdsItensMultiLojas.FieldByName('ITE_TOTDAR').AsFloat;

            cdsItensMultiLojas.Next;
          End; {While...}

          If (intRecNo > 0) And (cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat > 0) Then
          Begin

            If (cdsItensPedido.FieldByName('ITE_TOTSUB').AsFloat > fltTotSubAtu) Then
            Begin
              cdsItensMultiLojas.RecNo := intRecNo;
              cdsItensMultiLojas.Edit;

              cdsItensMultiLojas.FieldByName('ITE_TOTSUB').AsFloat :=
                 cdsItensMultiLojas.FieldByName('ITE_TOTSUB').AsFloat +
                 (cdsItensPedido.FieldByName('ITE_TOTSUB').AsFloat - fltTotSubAtu);

              cdsItensMultiLojas.Post;
            End
            Else If (fltTotSubAtu > cdsItensPedido.FieldByName('ITE_TOTSUB').AsFloat) Then
            Begin
              cdsItensMultiLojas.RecNo := intRecNo;
              cdsItensMultiLojas.Edit;

              cdsItensMultiLojas.FieldByName('ITE_TOTSUB').AsFloat :=
                cdsItensMultiLojas.FieldByName('ITE_TOTSUB').AsFloat -
                (fltTotSubAtu - cdsItensPedido.FieldByName('ITE_TOTSUB').AsFloat);

              cdsItensMultiLojas.Post;
            End;

            If (cdsItensPedido.FieldByName('ITE_TOTDAR').AsFloat > fltTotDarAtu) Then
            Begin
              cdsItensMultiLojas.RecNo := intRecNo;
              cdsItensMultiLojas.Edit;

              cdsItensMultiLojas.FieldByName('ITE_TOTDAR').AsFloat :=
                 cdsItensMultiLojas.FieldByName('ITE_TOTDAR').AsFloat +
                 (cdsItensPedido.FieldByName('ITE_TOTDAR').AsFloat - fltTotDarAtu);

              cdsItensMultiLojas.Post;
            End
            Else If (fltTotDarAtu > cdsItensPedido.FieldByName('ITE_TOTDAR').AsFloat) Then
            Begin
              cdsItensMultiLojas.RecNo := intRecNo;
              cdsItensMultiLojas.Edit;

              cdsItensMultiLojas.FieldByName('ITE_TOTDAR').AsFloat :=
                cdsItensMultiLojas.FieldByName('ITE_TOTDAR').AsFloat -
                (fltTotDarAtu - cdsItensPedido.FieldByName('ITE_TOTDAR').AsFloat);

              cdsItensMultiLojas.Post;
            End;

          End;

        End;

        cdsItensPedido.Next;

        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;
      End;

      If Assigned(cdsItensMultiLojas) Then
        cdsItensMultiLojas.EnableControls;

      Result := True;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmPedidoDeCompra.fRecalcularSubstituicaoTributaria]');
      End;
    End;
  Finally
    FreeAndNil(qryDadosAbf);

    If Assigned(cdsItensMultiLojas) Then
    Begin
      cdsItensMultiLojas.IndexFieldNames := strIndexMult;
    End;

    If Assigned(cdsDigMultLoja) Then
    Begin
      cdsDigMultLoja.vinculaCDS;
      cdsDigMultLoja.blnValidarDados := True;
    End;

  End;

  cdsItensMultiLojas.Filtered := False;

  cdsItensPedido.IndexFieldNames := strIndex;
  cdsItensPedido.EnableControls;
end;

Function TfrmPedidoDeCompra.fVerificaUnitarioZerado: Boolean;
  Var
    blnFiltered: Boolean;
    strFilter  : String;
Begin
  With cdsItensPedido Do
  Begin
    DisableControls;
    blnFiltered := Filtered;
    strFilter   := Filter;

    Filter   := 'ITE_QTDITE > 0 AND ITE_UNITAR = 0';

    Filtered := True;

    Result := IsEmpty;

    Filtered := blnFiltered;
    Filter   := strFilter;
    EnableControls;
  End;
End;

Function TfrmPedidoDeCompra.fTemQuantidadeZerada: Boolean;
  Var
    blnFiltered: Boolean;
    strFilter  : String;
Begin
  With cdsItensPedido Do
  Begin
    DisableControls;
    blnFiltered := Filtered;
    strFilter   := Filter;

    Try
      Filter   := 'ITE_QTDITE = 0';
      Filtered := True;

      Result := Not IsEmpty;

    Finally
      Filtered := blnFiltered;
      Filter   := strFilter;
      EnableControls;
    End;
  End;
End;

function TfrmPedidoDeCompra.fTrataCodCmp: String;
begin
  If edtCodDig.Visible Then
    Exit(edtCodCmp.Text)
  Else Exit(fRetCodVendedor(edtCodCmp.Text));
end;

Function TfrmPedidoDeCompra.fVerificaTravaFornecedor(strCodFor: String; blnExcluir: Boolean): Boolean;
  Var
    cdsIteTra: TZClient;

    Function fSQLItensTrava: String;
    Begin
      Result := '';
      Result := Result + ' SELECT        ';
      Result := Result + '   ITE_CODITE AS CODITE, ';
      Result := Result + '   ITE_DESITE AS DESITE  ';
      Result := Result + ' FROM          ';
      Result := Result + '   CADITE      ';
      Result := Result + ' WHERE         ';
      Result := Result + '   FALSE       ';
    End;

Begin
  Result := True;

  If fEmptyStr(strCodFor) Then
    Exit;

  if not fValidaPrecoItemFornecedor Then
    Exit;

  If Pos(strTraFor, 'TA') > 0 Then
  Begin
    cdsIteTra := TZClient.Create(Self, fSQLItensTrava);

    cdsIteTra.fAbreClient(True, 'TfrmPedidoDeCompra.fVerificaTravaFornecedor');

    With cdsItensPedido Do
    Begin
      DisableControls;
      First;
      While Not Eof Do
      Begin

        If Not fTemItemPrecoFornecedor(strCodFor, FieldByName('ITE_CODITE').AsString, strCodEmp,fSqlWhereTabPre(strPrF_AE, recOpcGir.strCodTab), recOpcGir.blnEmbala) Then
        Begin
          cdsIteTra.Insert;
          cdsIteTra.FieldByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
          cdsIteTra.FieldByName('DESITE').AsString := FieldByName('ITE_DESITE').AsString;
          cdsIteTra.Post;
        End;

        If (strTraFor = 'T') And blnExcluir Then
        Begin
          pRetiraDaListaConsulta(FieldByName('ITE_CODITE').AsString);
          cdsItensPedido.Delete;
        End Else
          Next;
      End;

      EnableControls;
    End;

    If (Not cdsIteTra.IsEmpty) Then
    Begin
      pCriarFormularios(TfrmMostraItensTravaFornec, frmMostraItensTravaFornec);

      frmMostraItensTravaFornec.cxgItensView.DataController.DataSource := cdsIteTra.dtsSource;

      If blnExcluir Then
      Begin
        If (strTraFor = 'T') Then
          frmMostraItensTravaFornec.mmoNaoEntraPedido.Visible := True
        Else
          frmMostraItensTravaFornec.mmoEntraPedido.Visible    := True;
      End;

      frmMostraItensTravaFornec.ShowModal;
      pFreeAndNil(frmMostraItensTravaFornec);

      If (strTraFor = 'T') Then
        Result :=  False;
    End;

    FreeAndNil(cdsIteTra);
  End;
End;

(*
Function TfrmPedidoDeCompra.fValidaCabecalho: Boolean;
Begin
  Try
    blnConfDocumento := True;

    Result := fVerificaCampos;

  Finally
    blnConfDocumento := False;
  End;
End;
*)

Function TfrmPedidoDeCompra.fRetEmpresaDestino: String;
Begin
  If blnNovoReg Then
  Begin
    Result := VS_strCodEmp;
  End Else
  Begin
    Result := qryPcmGer.FieldByName('PCG_EMPDES').AsString;

    If fEmptyStr(Result) Then
      Result := qryPcmGer.FieldByName('PCG_CODEMP').AsString;

    If fEmptyStr(Result) Then
      Result := VS_strCodEmp;
  End;
End;

Function TfrmPedidoDeCompra.fValidaEstoqueMaximo: Boolean;
  Var
    strEmpDes: String;
    cdsItens: TZClient;
    cdsPedido: TUniClientDataSet;
    objLiberacao : ILiberacao;
    objTabela : TRegistroMsgLiberaTabela;
	  objLinha  : TLinhaMsgLibera;
    strBkpFilter: string;
    blnBkpFiltered : Boolean;


    Function fSQLItens: String;
      Var
        strSQL: String;
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   I.ITE_CODEMP AS CODEMP, ';
      strSQL := strSQL + '   I.ITE_CODITE AS CODITE, ';
      strSQL := strSQL + '   I.ITE_DESITE AS DESITE, ';
      strSQL := strSQL + '     UNI_SIGUNI AS SIGUNI, ';
      strSQL := strSQL + '   0.00         AS QTDCOM, ';
      strSQL := strSQL + '   0.00         AS QTDREQ, ';
      strSQL := strSQL + '   ITE_SALDOS   AS SALDIS, ';
      strSQL := strSQL + '   ITE_ESTMAX   AS ESTMAX, ';
      strSQL := strSQL + '   0.00         AS QTDEXC  ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   CADITE I ';
      strSQL := strSQL + ' LEFT JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE ';
      strSQL := strSQL + ' LEFT JOIN CADUNI   ON   ITE_CODUNI = UNI_CODUNI   ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   FALSE ';

      Result := strSQL;
    End;

Begin
  Result := True;

  If strMaiMax = 'N' then
    Exit;

  cdsItens := Nil;

  If (recOpcGir.strPedMlj = 'S') Then
  Begin
    cdsPedido := cdsItensMultiLojas;
  End Else
  begin
    strEmpDes := fRetEmpresaDestino;
    cdsPedido := cdsItensPedido;
  End;

  Try
    With cdsPedido Do
    Begin
      DisableControls;

      strBkpFilter := cdsPedido.Filter;
      blnBkpFiltered := cdsPedido.Filtered;
      Try

        Filter   := '(ITE_QTDITE > 0) AND ((ITE_QTDITE + ITE_SALBAS - ITE_QTDREQ) > ITE_ESTMAX)';

        Filtered := True;

        If Not IsEmpty Then
        Begin
          cdsItens := TZClient.Create(Nil, fSQLItens);
          cdsItens.fLeDados('TfrmPedidoDeCompra.fValidaEstoqueMaximo');
          cdsItens.pAlinhaCampoCentro('CODITE');
          cdsItens.pAlinhaCampoCentro('CODEMP');
          cdsItens.pAlinhaCampoCentro('SIGUNI');

          objLiberacao := TLiberacaoFactory.fGetLiberacao;
          objLiberacao.Clear;

          objLiberacao.objMsgLibera.pAddTexto('QUANTIDADE COMPRADA EXCEDE O ESTOQUE MÁXIMO');
          objLiberacao.objMsgLibera.pAddSeparador(125);
          objLiberacao.objMsgLibera.pAddTexto('Este pedido de compra possui produtos com quantidade de compra que deixará o saldo de estoque maior que o estoque máximo.');
          objLiberacao.objMsgLibera.pAddTexto('Será necessário senha de liberação para prosseguir.');

          objTabela := TRegistroMsgLiberaTabela.Create;

          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlCabecalho;
          objLinha.pAddColuna(''  , 'COD.'          , 7  , alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'DESCRIÇÃO'     , 31 , alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'UN'            , 4  , alCentro   , teAutcom);
          objLinha.pAddColuna(''  , 'EMP'           , 4  , alCentro   , teAutcom);
          objLinha.pAddColuna(''  , 'QT.PD.COMPRA'  , 12 , alDireita  , teAutcom);
          objLinha.pAddColuna(''  , 'QT.REQUISIÇÃO' , 12 , alDireita  , teAutcom);
          objLinha.pAddColuna(''  , 'SALDO DISP.'   , 12 , alDireita  , teAutcom);
          objLinha.pAddColuna(''  , 'EST.MÁXIMO'    , 12 , alDireita  , teAutcom);
          objLinha.pAddColuna(''  , 'QTD.EXCEDENTE' , 12 , alDireita  , teAutcom);
          objTabela.lstLinhas.Add(objLinha);

          First;

          While Not Eof do
          Begin
            cdsItens.Append;

            If (recOpcGir.strPedMlj = 'S') Then
              cdsItens.FieldByName('CODEMP').AsString := FieldByName('ITE_CODEMP').AsString
            Else
              cdsItens.FieldByName('CODEMP').AsString := strEmpDes;

            cdsItens.FieldByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
            cdsItens.FieldByName('DESITE').AsString := FieldByName('ITE_DESITE').AsString;
            cdsItens.FieldByName('SIGUNI').AsString := FieldByName('ITE_SIGUNI').AsString;
            cdsItens.FieldByName('QTDCOM').AsFloat  := FieldByName('ITE_QTDITE').AsFloat;
            cdsItens.FieldByName('QTDREQ').AsFloat  := FieldByName('ITE_QTDREQ').AsFloat;
            cdsItens.FieldByName('SALDIS').AsFloat  := FieldByName('ITE_SALBAS').AsFloat;
            cdsItens.FieldByName('ESTMAX').AsFloat  := FieldByName('ITE_ESTMAX').AsFloat;
            cdsItens.FieldByName('QTDEXC').AsFloat  := (FieldByName('ITE_QTDITE').AsFloat + FieldByName('ITE_SALBAS').AsFloat - FieldByName('ITE_QTDREQ').AsFloat) - FieldByName('ITE_ESTMAX').AsFloat;
            cdsItens.Post;
          Next;
        End;

        cdsItens.IndexFieldNames := 'CODITE';

        cdsItens.First;

        While Not cdsItens.Eof do
        Begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna('COD.'          , cdsItens.FieldByName('CODITE').AsString                         , 7  , alEsquerda );
          objLinha.pAddColuna('DESCRIÇÃO'     , cdsItens.FieldByName('DESITE').AsString                         , 31 , alEsquerda );
          objLinha.pAddColuna('UN'            , cdsItens.FieldByName('SIGUNI').AsString                         , 6  , alCentro   );
          objLinha.pAddColuna('EMP'           , cdsItens.FieldByName('CODEMP').AsString                         , 4  , alCentro   );
          objLinha.pAddColuna('QT.PD.COMPRA'  , FormatFloat('#,##0.00', cdsItens.FieldByName('QTDCOM').AsFloat) , 12 , alDireita  );
          objLinha.pAddColuna('QT.REQUISIÇÃO' , FormatFloat('#,##0.00', cdsItens.FieldByName('QTDREQ').AsFloat) , 12 , alDireita  );
          objLinha.pAddColuna('SALDO DISP.'   , FormatFloat('#,##0.00', cdsItens.FieldByName('SALDIS').AsFloat) , 12 , alDireita  );
          objLinha.pAddColuna('EST.MÁXIMO'    , FormatFloat('#,##0.00', cdsItens.FieldByName('ESTMAX').AsFloat) , 12 , alDireita  );
          objLinha.pAddColuna('QTD.EXCEDENTE' , FormatFloat('#,##0.00', cdsItens.FieldByName('QTDEXC').AsFloat) , 12 , alDireita  );
          objTabela.lstLinhas.Add(objLinha);

          cdsItens.Next;
        End;

        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

        End; {If Not IsEmpty Then}
      Finally
        cdsPedido.Filter := strBkpFilter;
        cdsPedido.Filtered := blnBkpFiltered;
      End;
    End;

    If Assigned(cdsItens) Then
    Begin

      If strMaiMax = 'A' Then
      Begin
        pCriarFormularios(TfrmMostraLimiteEstoqMax, frmMostraLimiteEstoqMax);

        frmMostraLimiteEstoqMax.cxvItens.DataController.DataSource := cdsItens.dtsSource;
        frmMostraLimiteEstoqMax.cxvItens.NavigatorButtons.First.Click;

        frmMostraLimiteEstoqMax.ShowModal;

        FreeAndNil(frmMostraLimiteEstoqMax);
      End Else
      Begin

        objLiberacao.strDirAce := 'MAIMAX';
        objLiberacao.strMsgSen := 'QUANTIDADE COMPRADA EXCEDE O ESTOQUE MÁXIMO';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.blnSempreVariavelUsuario := True;

        Result := objLiberacao.fLibera;

      End;

    End;

  Finally
    cdsPedido.EnableControls;
  End;
End;

procedure TfrmPedidoDeCompra.btnConfirmaClick(Sender: TObject);
  Var
    blnPedLib: Boolean;
    strPedOrc: String;
    strNomeFila: String;
    strTipImp: String;
    blnResult: Boolean;
    blnDeuMsgTE: Boolean;
    strCondPagBosh: string;
    strPath: string;
    pSaveBeforePost: TprcScroll;
    strLog: TStringList;
begin
  inherited;
  blnEnviarEmailAutomatico := False;
  blnGravando := True;
  blnTransforma := False;

  objCopiaSeg.blnGravar := False;

  intQtdItensMutiLj := 0;
  stlAutIncrem.Clear;

  Try

    If InterlockedIncrement(intConfirma) = 0 Then
    Begin
      blnFazerApenasTransferencias := False;

      Try
        TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodFor := edtCodFor.Text;
        TfraOpcPdfPedidoCompra.RecOpcaoImpressao.intOpcao := 0;
        blnConfDocumento := True;

        {*****************************************}
        {* REVALIDA OS CAMPOS                    *}
        {**************************************MV*}
        {*****************************************}
        {* CASO NÃO TENHA ITENS, NÃO FAZ NADA    *}
        {**************************************MV*}
        If (Not fVerificaCampos) Or (cdsItensPedido.IsEmpty) Then
        Begin
          blnConfDocumento    := False;
          btnConfirma.Enabled := True;
        End

        Else If (Not fVerificaDescricaoVazia) Then
        Begin
          blnConfDocumento    := False;
          btnConfirma.Enabled := True;
        End

        Else If (Not fVerificaQuantidadeZero) Then
        Begin
          blnConfDocumento    := False;
          btnConfirma.Enabled := True;
        End

        Else If Not fVerificaUnitarioZerado Then
        Begin
          blnConfDocumento    := False;
          btnConfirma.Enabled := True;

          fMensagem('', 'Há itens com quantidade diferente de zero e valor unitário zerado. Verifique.', ['&O k']);
        End

        Else If Not fVerificaComprador Then
        Begin
          blnConfDocumento    := False;
          btnConfirma.Enabled := True;
        End

        Else If Not fValidaEstoqueMaximo Then
        Begin
          blnConfDocumento    := False;
          btnConfirma.Enabled := True;
        End

        Else If Not fVerificaTravaFornecedor(edtCodFor.Text, False) Then
        Begin
          blnConfDocumento    := False;
          btnConfirma.Enabled := True;
        End

        Else If Not fVerificaDivergenciasConf Then
        Begin
          blnConfDocumento    := False;
          btnConfirma.Enabled := True;
        End

        Else
        Begin
          blnConfDocumento := False;

          {********************************************}
          {* VERIFICA SE A TRAVA DE VALOR MÁXIMO PARA *}
          {* GRAVAÇÃO DE PEDIDOS DE COMPRA ESTÁ ATIVA *}
          {*****************************************RV*}
          If (fCfgSis('VRMXPC', varDouble) > 0) And (fDoubleAggregate(cdsItensPedido, 'TOT_TOTGER') > fCfgSis('VRMXPC', varDouble)) Then
          Begin
            If Not fLiberarLimiteMAximoPedidoCompraVRMXPC Then
            Begin
              InterlockedDecrement(intConfirma);
              Exit;
            End;
          End;


          If (recOpcGir.strPedMlj = 'S') And
              Assigned(cdsItensMultiLojas) Then
          Begin
            Try
              cdsItensMultiLojas.Filtered := False;
              strLog := TStringList.Create;
              If (fCfgSis('VALPDD') = 'S') Then
              begin
                TValidadorPedidoCompra.pInicia(cdsItensPedido, cdsItensMultiLojas);
                If (Not TValidadorPedidoCompra.ValidadorPedidoCompra.fValidaQuantidadeDistribuida(strLog)) then
                begin
                  TValidadorPedidoCompra.ValidadorPedidoCompra.pGravaLog(tlvpdcDivengenciaDistribuicao);
                  TfrmLog.pShowLog('Falhas encontradas', strLog);
                  InterlockedDecrement(intConfirma);
                  Exit;
                End;

              End;

              cdsItensMultiLojas.Filter := 'ITE_QTDITE > 0';
              cdsItensMultiLojas.Filtered := True;

              intQtdItensMutiLj := cdsItensMultiLojas.RecordCount;
            Finally
              cdsItensMultiLojas.Filter := '';
              cdsItensMultiLojas.Filtered := False;
              FreeAndNIl(strLog)
            End;
          End;

          If strEspOri = 'OR' Then
          Begin
            If fMensagem('', 'Gravar como: ', ['&Orçamento', '&Pedido']) = 2 Then
            Begin
              strEspDoc     := 'PD';
              blnNovoReg    := True;

              if fCfgSis('DATPED') = 'N' Then
              begin
                mskDtaFat.Text := DateToStr(VS_Date);
                dtaDtaPed := VS_Date;
                horHorPed := fTime();
              End;

              blnTransforma := True;


            End
            Else
            Begin
              blnNovoReg := (Not edtNumPed.Visible);
              strEspDoc  := 'OR';
            End;
          End;

          If strEspDoc = 'PD' Then
            strPedOrc := 'Pedido de compra'
          Else
            strPedOrc := 'Orçamento';
          blnResult := fPedeDadosImportacao;

          If blnResult Then
          Begin
            pSaveBeforePost := Nil;

            If (recOpcGir.strPedMlj = 'S') And Assigned(cdsItensMultiLojas) Then
            Begin
              pSaveBeforePost := cdsItensMultiLojas.BeforePost;
              cdsItensMultiLojas.BeforePost := Nil;
            End;

            Try
              pCriarFormularios(TfrmGravando, frmGravandoConfirmaPedido);
              frmGravandoConfirmaPedido.strChave := 'PEDCOM';
              frmGravandoConfirmaPedido.fExecutarAcao := fConfirmaPedido;
              frmGravandoConfirmaPedido.ShowModal;
              blnResult := frmGravandoConfirmaPedido.blnConfirma
            Except
              On E: Exception Do
              Begin
                blnResult := False;
                pMensagensErro(E.Message,'[btnConfirma - frmGravando]');
              End;
            End;
            pFreeAndNil(frmGravandoConfirmaPedido);

            If (recOpcGir.strPedMlj = 'S') And Assigned(cdsItensMultiLojas) Then
            Begin
              cdsItensMultiLojas.BeforePost := pSaveBeforePost;
            End;
          End;

          If blnResult Then
          Begin
            blnDeuMsgTE := False;

            If strFinPed = 'N' Then
            Begin

              If Not fEmptyStr(strNumPed) Then
                fMensagem('', strPedOrc + ' gravado com sucesso!' + #13#10 + strPedOrc + ' número: ' + strNumPed, ['&O k'])

              Else If objTransfere.blnGerouTransferencia Then
              Begin
                pMensagemOk('Preparação de Transferência de Estoque gerada com sucesso!');
                blnDeuMsgTE := True;
              End;

            End Else
            Begin

              If Not fEmptyStr(strPedGer) Then
              Begin

                If strEspDoc = 'PD' Then
                  fMensagem('', 'Pedidos de Compra gravados com sucesso!' + #13#10 + 'Pedidos de Compra gerados: ' + #13#10 + strPedGer, ['&O k'])
                Else
                  fMensagem('', 'Orçamentos gravados com sucesso!' + #13#10 + 'Orçamentos gerados: ' + #13#10 + strPedGer, ['&O k']);

              End

              Else If objTransfere.blnGerouTransferencia Then
              Begin
                blnDeuMsgTE := True;
                pMensagemOk('Preparação de Transferência de Estoque gerada com sucesso!');
              End;

            End;

            If (Not blnDeuMsgTE) And (Assigned(cdsDigMultLoja) And Assigned(cdsDigMultLoja.objPreparaGerMultiLoja) And
                cdsDigMultLoja.objPreparaGerMultiLoja.blnGerouTEAculumados) Then
              pMensagemOk('Preparação de Transferência de Estoque gerada com sucesso!');

            blnPedLib := True;

            If (strEspDoc = 'PD')                                And
               (fCfgSis('LIBPCM', varBoolean))                   And
               (Not fCfgSis('LIBIMP', varBoolean))               And
               (Not fPedidoCompraLiberado(strNumPed, strCodEmp)) Then
            Begin
              blnPedLib := False;
            End;

            {***********************************************************}
            {* IMPRIME PEDIDO DE COMPRA                                *}
            {* SOMENTE SE OPÇÃO SE A FINALIZAÇÃO DO PEDIDO FOR SIMPLES *}
            {* OU SEJA, NÃO FOR GERADO UM PEDIDO PARA CADA LOJA        *}
            {********************************************************LU*}
            If blnPedLib And (Not blnFazerApenasTransferencias) Then
            Begin
              TfraOpcPdfPedidoCompra.RecOpcaoImpressao.intQtdVias := 1;
              TfraOpcPdfPedidoCompra.RecOpcaoImpressao.intQtdOrd := 1;
              Try
                pCriarFormularios(TfrmPedidoCompraImpr, frmPedidoCompraImpr);
                {*********************************************}
                {* CASO USE TINTA DE MAQUINA, NÃO PERGUNTA   *}
                {* SE EXPORTA PARA SUVINIL/CORAL. IMPRESSORA *}
                {* DIRETO.                                   *}
                {******************************************MV*}
                If (fCfgSis('USATMQ') = 'N') Then
                Begin
                  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.intOpcao := 1;
                End;

                objImpressaoRel := TConfiguraImpressaoPedidoCompra.Create(Self, True);
                frmPedidoCompraImpr.objImpressaoRel := objImpressaoRel;


                frmPedidoCompraImpr.ShowModal;


              Except
                On E: Exception Do
                Begin
                  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnImprime := False;
                  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre := False;
                  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnMltCmp := False;
                  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnOrdDig := False;
                  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnImpOrd := False;
                  pMensagensErro(E.Message, '[frmPedidoDeCompra.btnConfirmaClick]');
                End;
              End;

              pFreeAndNil(frmPedidoCompraImpr);

              frmSelPedidoCompraImpressao.strEspDoc := strEspDoc;
              frmSelPedidoCompraImpressao.strCodEmp := strCodEmp;
              TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc := strEspDoc;
              TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodEmp := strCodEmp;
              TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strNumPed := strNumPed;

              If (TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnImprime) Then
              Begin
                If frmSelPedidoCompraImpressao.RecordCount > 1 Then
                Begin
                  frmSelPedidoCompraImpressao.strEspDoc := strEspDoc;
                  frmSelPedidoCompraImpressao.strCodEmp := strCodEmp;
                  frmSelPedidoCompraImpressao.strPath   := strPath;
                  frmSelPedidoCompraImpressao.blnNovoReg:= Not blnNovoReg;
                  frmSelPedidoCompraImpressao.strCondPagBosh := strCondPagBosh;

                  frmSelPedidoCompraImpressao.objImpressaoRel := objImpressaoRel;

                  frmSelPedidoCompraImpressao.Showmodal;
                End
                Else
                Begin

                  objImpressaoRel.fImprimeRelatorio(strEspDoc,
                                                    strCodEmp,
                                                    strNumPed);

                  If Not objImpressaoRel.blnImpressaoRel Then
                    pImprimirPedido(TfraOpcPdfPedidoCompra.RecOpcaoImpressao,
                                    strNumPed,
                                    strEspDoc,
                                    strCodEmp,
                                    strPath,
                                    strNomeFila,
                                    strTipImp,
                                    Not blnNovoReg,
                                    strCondPagBosh,
                                    False,
                                    True,
                                    True,
                                    blnExcRes);
                End;

              End;

              FreeAndNil(objImpressaoRel);

              If (TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnImpOrd) Then
                pImprimirOrdemCarregamento(strNumPed, strEspDoc, strCodEmp, TfraOpcPdfPedidoCompra.RecOpcaoImpressao.intQtdOrd, False, TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnOrdDig);

              If fCfgSis('PEDETI', varBoolean) Then
                pImprimeEtiqueta(edtCodFor.Text, strNumPed, strEspDoc);

            End;

            if edtCodSolicitacaoVinculada.Visible then
              if not TManutencaoEquipamentoInterno.fVinculaSolicitacao(edtCodSolicitacaoVinculada.Text, strNumPed, strEspDoc) then
                pMensagemOk('Erro ao gravar vinculo com solicitação de manutenção de equipamento interno');

            if blnEnvWap then
            begin
              TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strOrigemPedido := 'S';
              funDisparaSMSWhatsappPedidoCompra(strPedidosCompraGerados,
                                                strCodEmp,
                                                strEspDoc,
                                                staIncluindo,
                                                TfraOpcPdfPedidoCompra.RecOpcaoImpressao,
                                                true);
            end;

            blnSalvouPedido := True;

            If blnResult and blnEnviarEmailAutomatico Then
              pEnviaEmailAutomatico;
            Self.Close;
            Exit;

          End;

        End;

        InterlockedDecrement(intConfirma);

      Except
        On E:Exception Do
        Begin
          InterlockedDecrement(intConfirma);
          pMensagensErro(E.Message, '[TfrmPedidoDeCompra.btnConfirmaClick]');
        End;
      End;

    End
    Else
      InterlockedDecrement(intConfirma);

  Finally
    objCopiaSeg.blnGravar := True;
    blnGravando := False;
    TValidadorPedidoCompra.LimparDaMemoria;

  End;


end;

procedure TfrmPedidoDeCompra.pEnviaEmailAutomatico;
var  strParam: String;
begin
  If strEspdoc = 'PD' Then
  Begin
    strParam := 'DISP_EMAIL_PEDIDO_COMPRA' + ' ' +
                strLoginUsuarioLogado + ' ' +
                IIf(opcIncluscaoEmail.fAnexaPDF, 'S', 'N') + ' ' +
                IIf(opcIncluscaoEmail.fAnexaXLS, 'S', 'N') + ' ' +
                edtCodFor.Text + ' ' +
                strEspdoc + ' ' +
                strPedidosCompraGerados;
    pChamaAutComModoImportacao('', strParam, 0);
  End;

End;

procedure TfrmPedidoDeCompra.btnCotAbeClick(Sender: TObject);
begin
  inherited;

  If Not cdsItensPedido.IsEmpty Then
  begin

    If Assigned(prcExecutaRelatorio) Then
    begin
      prcExecutaRelatorio(107, 5831, [],
                          ['CODITE'],
                          [cdsItensPedido.FieldByName('ITE_CODITE').AsString],
                          Sender,
                          nil,
                          True);
    End;

  end;

end;

procedure TfrmPedidoDeCompra.btnDocSalResClick(Sender: TObject);
  Var
    strCodEmp: String;
begin
  inherited;
  If cdsItensPedido.IsEmpty Then
    Exit;

  If fEmptyStr(recOpcGir.strEmpGir) Then
  Begin

    If recOpcGir.strPedMlj = 'S' Then
      strCodEmp := fRetListaEmpresas
    Else
      strCodEmp := VS_strCodEmp;

  End
  Else
    strCodEmp := fRetiraQuotedLista(recOpcGir.strEmpGir);

  TfrmFatMostraPedSalRes.pExibeDocsSaldosReservado(cdsItensPedido.FieldByName('ITE_CODITE').AsString, strCodEmp, Nil, True);
end;

procedure TfrmPedidoDeCompra.btnDtaEntClick(Sender: TObject);
  Var
    frmGravando: TfrmGravando;
begin
  inherited;
  pCriarFormularios(TfrmDigData, frmDigData);

  frmDigData.lblData.Caption := 'Data de Entrega';

  If frmDigData.ShowModal = mrOk Then
  Begin
    mskDtaPed.Text := FormatDateTime('DD/MM/YYYY', StrToDateDef(frmDigData.dtmData.Text, VS_DATE));
    TfrmGravando.fExecuta(fAtualizaDtaEntPedido, frmGravando, 'Atualizando data de entrega...');
  End;

  pFreeAndNil(frmDigData);
end;

function TfrmPedidoDeCompra.fAtualizaDtaEntPedido(prgProgresso: TcxProgressBar): Boolean;
Var
  bkpAfterScroll,
  bkpBeforeScroll,
  bkpAfterPost,
  bkpBeforePost: TDataSetNotifyEvent;
Begin
  With cdsItensPedido Do
  Begin
    DisableControls;

    bkpAfterScroll :=  cdsItensPedido.AfterScroll;
    bkpBeforeScroll := cdsItensPedido.BeforeScroll;
    bkpAfterPost :=    cdsItensPedido.AfterPost;
    bkpBeforePost :=   cdsItensPedido.BeforePost;

    cdsItensPedido.AfterScroll := nil;
    cdsItensPedido.BeforeScroll := nil;
    cdsItensPedido.AfterPost := nil;
    cdsItensPedido.BeforePost := nil;

    IndexName := cdsItensPedido.IndexName;
    cdsItensPedido.IndexName := '';

    Try
      First;

      prgProgresso.Properties.Max := RecordCount;

      While Not Eof Do
      Begin
        Edit;
        cdsItensPedido.FieldByName('ITE_DTAENT').AsDateTime := StrToDateDef(frmDigData.dtmData.Text, VS_DATE);

        If (cdsItensPedido.FieldByName('ITE_DTAENT').OldValue <> Null) And (cdsItensPedido.FieldByName('ITE_DTAENT').NewValue <> Null) Then
        Begin
          If Not(cdsItensPedido.FieldByName('ITE_DTAENT').IsNull) And
            (cdsItensPedido.FieldByName('ITE_DTAENT').OldValue <> cdsItensPedido.FieldByName('ITE_DTAENT').NewValue) Then
            cdsItensPedido.FieldByName('ITE_DTAEDT').AsDateTime:= cdsItensPedido.FieldByName('ITE_DTAENT').OldValue;
        End;

        cdsItensPedido.Post;
        Next;
        prgProgresso.Position := prgProgresso.Position + 1;
        Application.ProcessMessages;
      End;

    Finally
      cdsItensPedido.AfterScroll := bkpAfterScroll;
      cdsItensPedido.BeforeScroll := bkpBeforeScroll;
      cdsItensPedido.AfterPost := bkpAfterPost;
      cdsItensPedido.BeforePost := bkpBeforePost;

      pAferScroll(cdsItensPedido);
      cdsItensPedido.IndexName := IndexName;
      EnableControls;
    End;

    Result := True;
  End;

End;

function TfrmPedidoDeCompra.fVerificaDescricaoVazia: Boolean;
  Var
    blnFiltered: Boolean;
    strFilter  : String;
Begin
  With cdsItensPedido Do
  Begin
    DisableControls;
    blnFiltered := Filtered;
    strFilter   := Filter;

    Try
      Filter   := '(ITE_DESITE = ' + QuotedStr('') + ') OR (ITE_DESITE IS NULL) ';
      Filtered := True;

      Result := IsEmpty;

      If Not Result Then
        pMensagemOk('Há itens com a descrição em branco, código ' + FieldByName('ITE_CODITE').AsString + '!');

    Finally
      Filtered := blnFiltered;
      Filter   := strFilter;
      EnableControls;
    End;
  End;
End;

{*****************************************}
{* VERIFICA SE TODAS OS PRODUTOS ESTÃO   *}
{* ZERADOS.                              *}
{**************************************MV*}
function TfrmPedidoDeCompra.fVerificaQuantidadeZero: Boolean;
begin
  blnManterZerados := False;

  If fTemQuantidadeZerada Then
  Begin

     If fPergunta('Há itens com quantidade zerada, deseja mantê-los no pedido?') Then
     Begin

       blnManterZerados := True;

       Result := True;

     End Else
     Begin

       Result := (fDoubleAggregate(cdsItensPedido, 'TOT_TOTGER') > 0);

       If Not Result Then
       Begin

         If objTransfere.fTemTransferencia Then
         Begin

           Result := fPergunta('Há apenas itens para serem transferidos (TE), nemhum pedido de compra será gerado. Deseja prosseguir?');

           If Result Then
             blnFazerApenasTransferencias := True;

         End

         Else fMensagem('', 'Todos os itens estão com a quantidade zerada! Verifique.', ['&O k']);
       End;


     End;

  End

  Else Result := True;
end;


function TfrmPedidoDeCompra.fRetImposto(strNomCam: String): Double;
Begin
  Result := fDoubleAggregate(TUniClientDataSet(dtsItensPedido.DataSet), 'TOT_' + strNomCam);
End;

function TfrmPedidoDeCompra.fRetornaCodigoFabricaItem(const strCodIte: String): String;
var
  qryGenIte: TUniQuery;
begin
  Try
    qryGenIte := fCriaQuery;
    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT SQL_NO_CACHE    ');

      If blnPermitirCompradorEscolherCodigoFabrica Then
      Begin
         SQL.Add(fRetornaSQLCodigoFabricaProduto('C'));
      End
      Else
      Begin
        If fCfgSis('CODFIT', varBoolean) Then
        Begin
          SQL.Add('  C.ITE_CODFAB AS ITE_CODFAB, ');
        End
        Else
        Begin
          If fCfgSis('TABPRF', varBoolean) Then
            SQL.Add('    IF(IFNULL(F.ITE_CODFAB,"") = "", C.ITE_CODFAB, F.ITE_CODFAB) AS ITE_CODFAB, ')
          Else
            SQL.Add('    IF(IFNULL(F.ITE_CODITF,"") = "", C.ITE_CODFAB, F.ITE_CODITF) AS ITE_CODFAB, ');
        End;
      End;

      SQL.Add(' C.ITE_CODITE ');

      SQL.Add('FROM                   ');
      SQL.Add('  CADITE  C            ');
      SQL.Add('  JOIN ITEGER I ON C.ITE_CODITE = I.ITE_CODITE AND ');
      SQL.Add('                   I.ITE_CODEMP = :CODEMP ');

      SQL.Add('  LEFT JOIN ITEFOR F ON F.ITE_CODITE = C.ITE_CODITE ');
      SQL.Add('                    AND F.ITE_CODFOR = :CODFOR ');

      If fCfgSis('TABPRF', varBoolean) Then
      Begin
        SQL.Add('                  AND (SELECT COUNT(*) FROM TABPRE     ');
        SQL.Add('                        WHERE F.ITE_CODTAB = TAB_CODTAB AND' + fSqlWhereTabPre(strPrF_AE, recOpcGir.strCodTab) + ') > 0');
      End Else
      Begin
        SQL.Add('                  AND F.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF     ');
        SQL.Add('                       WHERE FF.ITE_CODITE = C.ITE_CODITE AND ');
        SQL.Add('                             FF.ITE_CODFOR = :CODFOR)   ');
      End;

      SQL.Add('WHERE                  ');
      SQL.Add('  C.ITE_CODITE = :CODITE AND ');
      SQL.Add('  I.ITE_CODEMP = :CODEMP ');

      ParamByName('CODITE').Value := strCodIte;
      ParamByName('CODEMP').Value := fRetEmpresaDestino;
      ParamByName('CODFOR').Value := edtCodFor.Text;
      Open;

      Result := FieldByName('ITE_CODFAB').AsString;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
end;

function TfrmPedidoDeCompra.fRetornaCodigoFabricaProduto: String;
begin
  Case rdgCodigoFabricaProduto.ItemIndex Of
    0: Result := 'P';
    1: Result := 'F';
  End;
end;

function TfrmPedidoDeCompra.fRetornaSQLCodigoFabricaProduto(const strPrefixoCadIte: String): String;
begin
  Result := '';
  Case rdgCodigoFabricaProduto.ItemIndex Of
      0 : Result := ' ' + strPrefixoCadIte + '.ITE_CODFAB AS ITE_CODFAB, ';
      1 :  Begin
             If fCfgSis('TABPRF', varBoolean) Then
               Result := '  F.ITE_CODFAB AS ITE_CODFAB, '
             Else
               Result := '  F.ITE_CODITF AS ITE_CODFAB, ';
           End;
  End;
end;

function TfrmPedidoDeCompra.fRetornaTipoCodigoFabricaProduto: String;
begin
  Result := '';

  If Not blnPermitirCompradorEscolherCodigoFabrica Then
    Exit;

  Result := fRetornaCodigoFabricaProduto;
end;

Procedure TfrmPedidoDeCompra.pCarregaItensBaixados;
Begin
  With qryBaixad, SQL Do
  Begin
    Clear;
    Add('SELECT * FROM PCMDET');
    Add('WHERE ');
    Add(' PCD_NUMPED = :NUMPED AND ');
    Add(' PCD_CODEMP = :CODEMP AND ');
    Add(' PCD_ESPDOC = :ESPDOC AND ');
    Add(' PCD_NUMCTN = 0       AND ');
    Add(' IFNULL(PCD_QTDBAI, 0) > 0');

    Close;

    ParamByName('NUMPED').AsString  := qryPcmGer.FieldByName('PCG_NUMPED').AsString;
    ParamByName('CODEMP').AsString  := qryPcmGer.FieldByName('PCG_CODEMP').AsString;
    ParamByName('ESPDOC').AsString  := qryPcmGer.FieldByName('PCG_ESPDOC').AsString;

    Open;
  End;
End;

procedure TfrmPedidoDeCompra.pCarregarCodPlanoDeContasForn();
  Var
    arrCta: TConsultasArray;
    chrKey: Char;
    qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT ');
    qryConsulta.SQL.Add('  CADFOR.FOR_CODCTA ');
    qryConsulta.SQL.Add('FROM ');
    qryConsulta.SQL.Add('  CADFOR ');
    qryConsulta.SQL.Add('WHERE ');
    qryConsulta.SQL.Add('  FOR_CODFOR = :CODFOR AND ');
    qryConsulta.SQL.Add('  FOR_STATUS = "A" ');
    qryConsulta.ParamByName('CODFOR').AsString := edtCodFor.Text;
    qryConsulta.Open;

    If Not fCfgSis('USACTF', varBoolean) Then
      strCodCta      := qryConsulta.FieldByName('FOR_CODCTA').AsString
    Else
    Begin
      If fEmptyStr(strCodCta) Then
      Begin
        qryConsulta.SQL.Clear;
        qryConsulta.SQL.Add('SELECT COUNT(1) AS QTD ');
        qryConsulta.SQL.Add('FROM CTAFOR  ');
        qryConsulta.SQL.Add('WHERE ');
        qryConsulta.SQL.Add('CTF_CODFOR = :CODFOR  ');
        qryConsulta.paramByName('CODFOR').AsString := edtCodFor.Text;
        qryConsulta.Open;
        If qryConsulta.FieldByName('QTD').AsInteger = 0 Then
        Begin
          fMensagem('', 'Não há Plano de Contas Vinculado ao Fornecedor. Será preciso cadastrar.', ['&O K']);
          Exit;
        End;
        qryConsulta.SQL.Clear;

        fMensagem('', 'Selecione um Plano de Contas!', ['&O K']);

        qryConsulta.SQL.Text := 'SELECT * FROM CADCTA WHERE FALSE';

        chrKey := '/';

        If fPesqCentroCusto(Self, Nil, Nil, qryConsulta, chrKey, arrCta, True, True, edtCodFor.Text) Then
          strCodCta := qryConsulta.FieldByName('CTA_CODCTA').AsString
        Else
          strCodCta := '';
      End;
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
End;



Procedure TfrmPedidoDeCompra.pRegravaItensBaixados;
  Var
    qryPcmdet: TUniQuery;
    fltIcmUni,
    fltPisUni: Double;
Begin
  If Not qryBaixad.Active Then
    Exit;

  With qryBaixad, SQL Do
  Begin

    If Not IsEmpty Then
    Begin
      strCampoSaldoSub := fRetCampoAtualizaSaldoPedidoCompra(qryPcmGer.FieldByName('AUTOINCREM').AsString,
                                                             '',
                                                             '',
                                                             blnLibPcm,
                                                             strForFil);

      qryPcmdet := fCriaQuery(Self);

      qryPcmdet.SQL.Add('SELECT * FROM PCMDET WHERE ');
      qryPcmdet.SQL.Add('  PCD_NUMCTN = 0       AND   ');
      qryPcmdet.SQL.Add('  PCD_NUMPED = :NUMPED AND   ');
      qryPcmdet.SQL.Add('  PCD_CODEMP = :CODEMP AND   ');
      qryPcmdet.SQL.Add('  PCD_ESPDOC = :ESPPED       ');

      qryPcmdet.ParamByName('NUMPED').AsString := strNumPed;
      qryPcmdet.ParamByName('CODEMP').AsString := strCodEmp;
      qryPcmdet.ParamByName('ESPPED').AsString := strEspDoc;

      qryPcmdet.Open;
      qryPcmdet.IndexFieldNames := 'PCD_CODITE';

      First;
      While Not Eof Do
      Begin

        If qryPcmdet.Locate('PCD_CODITE', FieldByName('PCD_CODITE').AsString, []) Then
        Begin  // RETORNA A QUANTIDADE BAIXADA PARCIALMENTE

          // O ITEM ESTÁ EM ABERTO
          //     - ESTAVA BAIXADO ANTES E FOI REINCLUIDO OU ESTAVA PARCIALMENTE BAIXADO
          // OS QUE PERMANECEM TOTALMENTE BAIXADOS NÃO PRECISAM DE ALTERAÇÃO
          If (qryPcmdet.FieldByName('PCD_BAIXAD').AsString = '0') Then
          Begin

            qryPcmdet.Edit;

            qryPcmdet.FieldByName('PCD_QTDBAI').AsFloat := FieldByName('PCD_QTDBAI').AsFloat;
            qryPcmdet.FieldByName('PCD_TOTBAI').AsFloat := FieldByName('PCD_TOTBAI').AsFloat;
            qryPcmdet.FieldByName('PCD_IPIBAI').AsFloat := FieldByName('PCD_IPIBAI').AsFloat;
            qryPcmdet.FieldByName('PCD_SUBBAI').AsFloat := FieldByName('PCD_SUBBAI').AsFloat;

            qryPcmdet.FieldByName('PCD_FREBAI').AsFloat := FieldByName('PCD_FREBAI').AsFloat;
            qryPcmdet.FieldByName('PCD_ACEBAI').AsFloat := FieldByName('PCD_ACEBAI').AsFloat;

            fltIcmUni := qryPcmdet.FieldByName('PCD_VALICM').AsFloat / qryPcmdet.FieldByName('PCD_QTDITE').AsFloat;
            fltPisUni := qryPcmdet.FieldByName('PCD_DESPIS').AsFloat / qryPcmdet.FieldByName('PCD_QTDITE').AsFloat;

            qryPcmdet.FieldByName('PCD_QTDITE').AsFloat := qryPcmdet.FieldByName('PCD_QTDITE').AsFloat + FieldByName('PCD_QTDBAI').AsFloat;

            qryPcmdet.FieldByName('PCD_VALICM').AsFloat := fltIcmUni * qryPcmdet.FieldByName('PCD_QTDITE').AsFloat;
            qryPcmdet.FieldByName('PCD_DESPIS').AsFloat := fltPisUni * qryPcmdet.FieldByName('PCD_QTDITE').AsFloat;

            qryPcmdet.FieldByName('PCD_TOTITE').AsFloat := qryPcmdet.FieldByName('PCD_TOTITE').AsFloat + FieldByName('PCD_TOTBAI').AsFloat;
            qryPcmdet.FieldByName('PCD_TOTIPI').AsFloat := qryPcmdet.FieldByName('PCD_TOTIPI').AsFloat + FieldByName('PCD_IPIBAI').AsFloat;
            qryPcmdet.FieldByName('PCD_TOTSUB').AsFloat := qryPcmdet.FieldByName('PCD_TOTSUB').AsFloat + FieldByName('PCD_SUBBAI').AsFloat;

            If (qryPcmdet.FieldByName('PCD_ESPDOC').AsString = 'PD') Then
              pEstornaSaldoItemPedidoCompra(qryPcmdet.FieldByName('AUTOINCREM').AsString, strCampoSaldoSub, intDecTpc);

            qryPcmdet.Post;

            If (qryPcmdet.FieldByName('PCD_ESPDOC').AsString = 'PD') Then
              pAtualizaSaldoItemPedidoCompra(qryPcmdet.FieldByName('AUTOINCREM').AsString, strCampoSaldoAdd, intDecTpc);

          End;

        End;

        Next;
      End;

      FreeAndNil(qryPcmdet);
    End;

  End;
End;

Procedure TfrmPedidoDeCompra.pRateiaFreteRegistro(Var fltValFreRes, fltDesAceRes: Double;
                                                      fltValFreGer, fltDesAceGer, fltTotIteGer: Double;
                                                      cdsDados: TUniClientDataSet);
  Var
//    fltFreAceAnt,

    fltBasIcm,
    fltAlqIcm,
    fltValIcm,
    fltBaseST,
    fltDesPis,
    fltPerFCP,
    fltSubFCP,
    fltRepFre,
    fltTotDar: Double;

    strCodSit,
    strCodSitOrigem: String;
    fltBasIpi,
    fltAlqIPI,
    fltValIPI,
    fltVlrAliquotaSub: Double;
Begin
  With cdsDados Do
  Begin
//    fltFreAceAnt := FieldByName('ITE_VALFRE').AsFloat + FieldByName('ITE_DESACE').AsFloat;

    Edit;

    If (fltValFreRes > 0) And (fltValFreGer > 0) Then
    Begin

      If RoundTo(FieldByName('ITE_TOTITE').AsFloat * (fltValFreGer / fltTotIteGer), -2) > fltValFreRes Then
        FieldByName('ITE_VALFRE').AsFloat := fltValFreRes
      Else
        FieldByName('ITE_VALFRE').AsFloat := RoundTo(FieldByName('ITE_TOTITE').AsFloat * (fltValFreGer / fltTotIteGer), -2);

    End
    Else FieldByName('ITE_VALFRE').AsFloat := 0;

    If (fltDesAceRes > 0) And (fltDesAceGer > 0) Then
    Begin

      If RoundTo(FieldByName('ITE_TOTITE').AsFloat * (fltDesAceGer / fltTotIteGer), -2) > fltDesAceRes Then
        FieldByName('ITE_DESACE').AsFloat := fltDesAceRes
      Else
        FieldByName('ITE_DESACE').AsFloat := RoundTo(FieldByName('ITE_TOTITE').AsFloat * (fltDesAceGer / fltTotIteGer), -2);

    End
    Else FieldByName('ITE_DESACE').AsFloat := 0;

   { If (RoundTo(fltFreAceAnt, -2) <>  RoundTo(FieldByName('ITE_VALFRE').AsFloat + FieldByName('ITE_DESACE').AsFloat, -2)) Or
       (RecordCount = 1) Then }
    Begin
      ParametrosCalcImpostos.pSetaParametros(FieldByName('ITE_CICMDE').AsString,
                                             FieldByName('ITE_CDPIOP').AsString,
                                             FieldByName('ITE_DIDIOP').AsString);


      fltRepFre := (cdsDados.FieldByName('ITE_VALFRE').AsFloat*100)/cdsDados.FieldByName('ITE_TOTITE').AsFloat;

      fltBasIpi := IIF(FieldByName('ITE_PERIPI').AsFloat > 0, FieldByName('ITE_TOTITE').AsFloat, 0);

      If (objCopiaSeg.recPcmger.strIPIFre = 'S') And (fltRepFre > 0) And (fltBasIpi > 0) Then
       fltBasIpi := fltBasIpi + (fltBasIpi * fltRepFre /100);

      fltAlqIPI :=  FieldByName('ITE_PERIPI').AsFloat;
      fltValIPI :=  (FieldByName('ITE_TOTITE').AsFloat * (FieldByName('ITE_PERIPI').AsFloat / 100));


      fltTotSubCal := RoundTo(fCalcularSubstituicaoProduto(edtCodFor.Text,                                                 //strCodFor,
                                                           fRetornaAbreviacaoItem(FieldByName('ITE_CODITE').AsString),     //strCodAbf: String;
                                                           FieldByName('ITE_TOTITE').AsFloat,                              //fltTotIte,
                                                           FieldByName('ITE_VALFRE').AsFloat,                              //fltTotFre,
                                                           FieldByName('ITE_DESACE').AsFloat,                              //fltTotAce: Double;
                                                           strFRMPCM,                                                      //strFrmPcm,
                                                           objCopiaSeg.recPcmger.strBStFre,                                //strBStFre,
                                                           objCopiaSeg.recPcmger.strBStAce,                                //strBStAce: String;
                                                           blnZonaFranca,                                                  //blnZonaFranca,
                                                           FieldByName('ITE_INCPIS').AsString = 'S',                       //blnIncPis,
                                                           strSimPau = 'S',                                                //blnFornecSimples: Boolean;
                                                           blnTemDare,
                                                           fltAlqIPI,                                                      //fltAlqIPI: Double;
                                                           chkZeraST.Checked,
                                                           fltBasIcm,                                                      //fltBasIcm,
                                                           fltAlqIcm,                                                      //fltAlqIcm,
                                                           fltValIcm,                                                      //fltValIcm,
                                                           fltBaseST,                                                      //fltBaseST,
                                                           fltDesPis,                                                      //fltDesPis,
                                                           fltBasIPI,                                                       //fltBasIPI,
                                                           fltValIPI,                                                       //fltValIPI,
                                                           fltPerFCP,                                                      //fltPerFCP,
                                                           fltTotDar,                                                      //fltTotDar
                                                           fltSubFCP,                                                      //fltSubFCP: Double;
                                                           strCodSit,                                                      //Var strCodSit: String;
                                                           strCodSitOrigem,                                                //Var strCodSitOrigem: String;
                                                           fltVlrAliquotaSub,                                              //var fltAliquotaSub: Double;
                                                           ParametrosCalcImpostos,                                         //ParametrosImpostos: TParametrosCalculoImposto;
                                                           strTipAbfFor), -2);                                             //strTipAbfFor: String = '';


      fltIcmDesCal := 0;
      If ParametrosCalcImpostos.blnCalcularICMSDesonerado Then
        fltIcmDesCal := fltValIcm;

      If FieldByName('ITE_SUBUSU').AsString <> 'S' Then
      Begin
        FieldByName('ITE_TOTSUB').AsFloat := fltTotSubCal;
        If ParametrosCalcImpostos.blnCalcularICMSDesonerado Then
          FieldByName('ITE_VALICM').AsFloat := fltValIcm
        Else
          FieldByName('ITE_VALICM').AsFloat := 0;

        FieldByName('ITE_PERSUB').AsFloat := fltVlrAliquotaSub;

        FieldByName('ITE_TOTDAR').AsFloat := fltTotDar;
      End;

      FieldByName('ITE_BASIPI').AsFloat := fltBasipi;
      FieldByName('ITE_PERIPI').AsFloat := fltAlqIPI;
      FieldByName('ITE_TOTIPI').AsFloat := fltValIpi;

      FieldByName('ITE_BASICM').AsFloat  := fltBasIcm;
      FieldByName('ITE_ALQICM').AsFloat  := fltAlqIcm;
      FieldByName('ITE_BASSUB').AsFloat  := fltBaseST;
      FieldByName('ITE_DESPIS').AsFloat  := fltDesPis;

      FieldByName('ITE_PERFCP').AsFloat  := fltPerFCP;
      FieldByName('ITE_SUBFCP').AsFloat  := RoundTo(cdsItensPedido.FieldByName('ITE_TOTSUB').AsFloat * fltPerFCP / 100, -2);

      FieldByName('ITE_CODSIT').AsString := strCodSit;
      FieldByName('ITE_SITORI').AsString := strCodSitOrigem;

      pCalculaImpostosReformaItem(cdsDados, chkPedImp.Checked);

      pCalculaUniImp(cdsDados);
    End;

    Post;
  End;
End;

Function TfrmPedidoDeCompra.fRateiaFreteDesAcePrg(pgbProgresso: TcxProgressBar): Boolean;
  Var
    fltValFreRes,
    fltDesAceRes,
    fltTotIteGer: Double;
    pBeforePost: TDataSetNotifyEvent;
Begin
  cdsItensPedido.AfterPost   := Nil;
  pBeforePost := cdsItensPedido.BeforePost;
  cdsItensPedido.BeforePost  := Nil;

  With cdsItensPedido Do
  Begin
  //  Filter   := fFiltroCompra;
  //  Filtered := True;

    Try

      fltTotIteGer := fDoubleAggregate(cdsItensPedido, 'TOT_TOTITE');

      First;

      fltValFreRes := fltValFreGer;
      fltDesAceRes := fltDesAceGer;

      pgbProgresso.Properties.Max := RecordCount;

      While Not Eof Do
      Begin
        pRateiaFreteRegistro(fltValFreRes, fltDesAceRes,
                             fltValFreGer, fltDesAceGer, fltTotIteGer,
                             cdsItensPedido);

        fltValFreRes := RoundTo(fltValFreRes - FieldByName('ITE_VALFRE').AsFloat, -2);
        fltDesAceRes := RoundTo(fltDesAceRes - FieldByName('ITE_DESACE').AsFloat, -2);

        Next;

        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;
      End;

    Finally

      Filtered := False;
      Filter   := '';

    End;

  End;

  cdsItensPedido.AfterPost   := pAfterPost;
  cdsItensPedido.BeforePost  := pBeforePost;

  Result := True;
End;

Procedure TfrmPedidoDeCompra.pRateiaFreteDesAce(blnRecalcular: Boolean; fltValFreRat, fltDesAceRat: Double; strBStFrete, strBStDesAce, strBSIpiFrete: String);
  Var
    frmGravando: TfrmGravando;
    intRecNo: Integer;
Begin
  If blnRecalcular Then
  Begin
    objCopiaSeg.recPcmger.fltValFre := fltValFreRat;
    objCopiaSeg.recPcmger.fltDesAce := fltDesAceRat;

    objCopiaSeg.recPcmger.strBStFre := strBStFrete;
    objCopiaSeg.recPcmger.strBStAce := strBStDesAce;
    objCopiaSeg.recPcmger.strIpiFre := strBSIpiFrete;

    fltValFreGer := fltValFreRat;
    fltDesAceGer := fltDesAceRat;

    cdsItensPedido.DisableControls;
    intRecNo := cdsItensPedido.RecNo;

    Try
      pCriarFormularios(TfrmGravando, frmGravando);

      frmGravando.lblGravando.Caption := 'Calculando frete e despesas por item...';
      frmGravando.fExecutarAcao := fRateiaFreteDesAcePrg;

      frmGravando.ShowModal;

      FreeAndNil(frmGravando);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[pRateiaFreteDesAce]');
      End;
    End;

    cdsItensPedido.RecNo := intRecNo;

    cdsItensPedido.EnableControls;

    pAferScroll(cdsItensPedido);

    pAtualizaTotalTela;
  End;
End;

function TfrmPedidoDeCompra.fConcatenaObserv(EhPedido : Boolean) : String;
var
  i : Integer;
  strNomeCmp : String;
begin
  Result := '';
  strNomeCmp := IIF(EhPedido, 'PCG_OBSPD', 'PCG_OBS00');
  for i := 1 to 6 do
  begin
    If not fEmptyStr(qryPcmGer.FieldByName(strNomeCmp + inttostr(i)).AsString) Then
      Result := Result + qryPcmGer.FieldByName(strNomeCmp + inttostr(i)).AsString;
  end;
end;

function TfrmPedidoDeCompra.fConfirmaPedido(pgbStatus: TcxProgressBar): Boolean;
  Var
    stlObserv: TStringList;
    strPedOri: String;
    intContador: Integer;
    qryTransp: TUniQuery;
    strSQL: String;

    strCodTra: String;
    strCodTraRedespacho: String;
    strObs001: String;
    strObs002: String;
    strObs003: String;
    strObs004: String;
    strObs005: String;
    strObs006: String;
    strTipFre: String;
    strTipFreRedespacho: String;
    fltValFre: Double;
    fltDesAce: Double;

    strObsPd1: String;
    strObsPd2: String;
    strObsPd3: String;
    strObsPd4: String;
    strObsPd5: String;
    strObsPd6: String;
    strPedVen: String;

    strAtenca: String;
    strCodEve: String;
    strOrcOri: String;

    strAutIncPcmDet: string;
    strAutIncPcmDetBkp: String;
    strAutIncPcdDet: string;
    qryCadEmp: TUniQuery;

    strItensPed: String;
    strEmpDes: String;

    strNomEmpLoj,
    strEndEmpLoj,
    strCidEmpLoj: String;

    blnRecalcularFrete,
    blnEndLoj: Boolean;
    SQL: TStringList;

    fltQtdIte: Double;
    intQtdMult: Integer;
    objValidaValorPedidoCompra: TValidaValorPedidoCompra;

    afsAfterPostMult: TDataSetNotifyEvent;

    strMsgErro: String;

    strNumPok: String;

    qryGravacao: TUniQuery;
    blnGerouPedido: Boolean;
    blnGerouApenasTransferencia: Boolean;

    intQtdConCol: Integer;
    strLogErro: TStringList;

    procedure pStepBy(intQtd: Integer = 1);
    begin
      If Assigned(pgbStatus) Then
      Begin
        pgbStatus.Position := pgbStatus.Position + intQtd;
      End;
    end;

begin
  blnEndLoj := False;
  strPedOri := '';
  strPedGer := '';
  fltValFre := 0.0;
  fltDesAce := 0.0;
  intQtdConCol := 0;
  horHorPed := fTime();
  SQL := TStringList.Create;

  If Assigned(cdsItensMultiLojas) Then
  Begin
    afsAfterPostMult := cdsItensMultiLojas.AfterPost;
    cdsItensMultiLojas.AfterPost := Nil;
  End;

  blnGerouPedido := False;
  blnGerouApenasTransferencia := False;

  Try
    pnlInfo.Caption := 'Aguarde, gravando pedido de compras...';
    Screen.Cursor := crHourGlass;

    If blnFazerApenasTransferencias Then
    Begin

      Result := True;
      blnGerouApenasTransferencia := True;

    End Else
    Begin
      pDadosEntrega;
      //DMELHORAR -> VER SE DA PRA MELHORAR ESSA PARTE DA TELA
      If strEspDoc = 'PD' Then
      Begin

        {*****************************************}
        {* CHAMA TELA DE OBSERVAÇÕES             *}
        {**************************************LU*}
        Try
          pCriarFormularios(TfrmDigObservacoes, frmDigObservacoes);

          qryTransp := fCriaQuery(Self);

          strSQL := '';
          strSQL := strSQL + ' SELECT ';
          strSQL := strSQL + '   TRA_CODTRA AS CODTRA, ';
          strSQL := strSQL + '   TRA_NOMTRA AS NOMTRA, ';
          strSQL := strSQL + '   CONCAT(TRA_ENDERE, " - ", IFNULL(TRA_BAIRRO, "")) AS ENDERE, ';
          strSQL := strSQL + '   CONCAT(CID_NOMCID, " - ", CID_ESTADO, " - Fone: ", IFNULL(TRA_FONE01, "")) AS NOMCID ';
          strSQL := strSQL + ' FROM ';
          strSQL := strSQL + '   CADTRA ';
          strSQL := strSQL + '   LEFT JOIN CADCID ON TRA_CODCID = CID_CODCID ';
          strSQL := strSQL + ' WHERE ';
          strSQL := strSQL + '   TRA_CODTRA = :CODTRA ';
          strSQL := strSQL + ' UNION ALL ';
          strSQL := strSQL + ' SELECT ';
          strSQL := strSQL + '   TRA_CODTRA AS CODTRA, ';
          strSQL := strSQL + '   TRA_NOMTRA AS NOMTRA, ';
          strSQL := strSQL + '   CONCAT(TRA_ENDERE, " - ", IFNULL(TRA_BAIRRO, "")) AS ENDERE, ';
          strSQL := strSQL + '   CONCAT(CID_NOMCID, " - ", CID_ESTADO, " - Fone: ", IFNULL(TRA_FONE01, "")) AS NOMCID ';
          strSQL := strSQL + ' FROM ';
          strSQL := strSQL + '   CADTRA ';
          strSQL := strSQL + '   LEFT JOIN CADCID ON TRA_CODCID = CID_CODCID ';
          strSQL := strSQL + ' WHERE ';
          strSQL := strSQL + '   TRA_CODTRA = :CODTRR ';

          With qryTransp Do
          Begin
            close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('CODTRA').AsString := qryPcmGer.FieldByName('PCG_CODTRA').AsString;
            ParamByName('CODTRR').AsString := qryPcmGer.FieldByName('PCG_CODTRR').AsString;
            Open;

            While not qryTransp.EoF do
            Begin
              If qryTransp.FieldByName('CODTRA').AsString = qryPcmGer.FieldByName('PCG_CODTRA').AsString Then
              Begin
                frmDigObservacoes.edtCodTra.Text := FieldbyName('CODTRA').AsString;
                frmDigObservacoes.edtNomTra.Text := FieldbyName('NOMTRA').AsString;
                frmDigObservacoes.edtEndere.Text := FieldbyName('ENDERE').AsString;
                frmDigObservacoes.edtCidade.Text := FieldbyName('NOMCID').AsString;
                {*****************************}
                {* SUGESTÃO DE TIPO DE FRETE *}
                {**************************RV*}
                If fEmptyStr(qryPcmGer.FieldByName('PCG_TIPFRE').AsString) Then
                  frmDigObservacoes.cmbTipFre.ItemIndex := frmDigObservacoes.cmbTipFre.Items.IndexOf(fDescricaoFrete(fCfgSis('FREPDC')))
                Else
                  frmDigObservacoes.cmbTipFre.ItemIndex := frmDigObservacoes.cmbTipFre.Items.IndexOf(fDescricaoFrete(qryPcmGer.FieldByName('PCG_TIPFRE').AsString));
              End
              Else
              Begin
                frmDigObservacoes.edtCodTraRedespacho.Text := FieldbyName('CODTRA').AsString;
                frmDigObservacoes.edtNomTraRedespacho.Text := FieldbyName('NOMTRA').AsString;
                frmDigObservacoes.edtEndereRedespacho.Text := FieldbyName('ENDERE').AsString;
                frmDigObservacoes.edtCidadeRedespacho.Text := FieldbyName('NOMCID').AsString;

                frmDigObservacoes.cmbTipFreRedespacho.ItemIndex := frmDigObservacoes.cmbTipFreRedespacho.
                                                                   Items.IndexOf(fDescricaoFrete(qryPcmGer.FieldByName('PCG_TIPFRR').AsString));
              End;
              qryTransp.Next;
            End;

            If qryTransp.IsEmpty And
               (Not fEmptyStr(edtNumPed.Text)) Then
             Begin
               If (fEmptyStr(qryPcmGer.FieldByName('PCG_CODTRA').AsString)) And (Not fEmptyStr(qryPcmGer.FieldByName('PCG_TIPFRE').AsString))  Then
               Begin
                 frmDigObservacoes.cmbTipFre.ItemIndex := frmDigObservacoes.cmbTipFre.Items.IndexOf(fDescricaoFrete(qryPcmGer.FieldByName('PCG_TIPFRE').AsString));
                 frmDigObservacoes.strTipFre := fTipoFrete(frmDigObservacoes.cmbTipFre.Text);
               End;

               If (fEmptyStr(qryPcmGer.FieldByName('PCG_CODTRR').AsString)) And (Not fEmptyStr(qryPcmGer.FieldByName('PCG_TIPFRR').AsString))  Then
               Begin
                 frmDigObservacoes.cmbTipFreRedespacho.ItemIndex := frmDigObservacoes.cmbTipFreRedespacho.Items.IndexOf(fDescricaoFrete(qryPcmGer.FieldByName('PCG_TIPFRR').AsString));
                 frmDigObservacoes.strTipFreRedespacho := fTipoFrete(frmDigObservacoes.cmbTipFreRedespacho.Text);
               End;
             End;

          End;

          FreeAndNil(qryTransp);

          frmDigObservacoes.fltTotPed := fDoubleAggregate(cdsItensPedido, 'TOT_TOTGER');
          frmDigObservacoes.fltTotIte := fStrToFloat(dbeTotIte.Text);

          frmDigObservacoes.edtNomEmp.Text := strNomEmp;
          frmDigObservacoes.edtEndEmp.Text := strEndEmp;
          frmDigObservacoes.edtCidEmp.Text := strCidEmp;



          If (recOpcGir.strPedMlj = 'S') And (fCfgSis('METPED') = '1') And (cdsDigMultLoja.cdsTotalEmpresas.IsEmpty) Then
          begin
            blnNotShow:= True;
            btnResumoLoja.Click;
            blnNotShow := False;
            frmDigObservacoes.cdsTotalEmpresas := cdsDigMultLoja.cdsTotalEmpresas;
            pnlInfo.Caption := 'Aguarde, gravando pedido de compras...';
          End;

          If fEmptyStr(frmDigObservacoes.edtCodTra.Text) And fEmptyStr(edtNumPed.Text) Then
          Begin

            {*************************************************************}
            {* VERIFICA SE O FORNECEDOR POSSUI TRANSPORTADORA CADASTRADA *}
            {**********************************************************LU*}
            qryTransp := fCriaQuery(Self);

            strSQL := '';
            strSQL := strSQL + '   SELECT ';
            strSQL := strSQL + '     FOR_CODTRA AS CODTRA,';
            strSQL := strSQL + '     TRA_NOMTRA AS NOMTRA,';
            strSQL := strSQL + '     CONCAT(TRA_ENDERE, " - ", IFNULL(TRA_BAIRRO, "")) AS ENDERE,';
            strSQL := strSQL + '     CONCAT(CID_NOMCID, " - ", CID_ESTADO, " - Fone: ", IFNULL(TRA_FONE01, "")) AS NOMCID,';
            strSQL := strSQL + '     FOR_TIPFRE AS TIPFRE,';
            strSQL := strSQL + '     "TRANS" AS FRETE';
            strSQL := strSQL + '   FROM';
            strSQL := strSQL + '     CADFOR';
            strSQL := strSQL + '     LEFT JOIN CADTRA ON FOR_CODTRA = TRA_CODTRA';
            strSQL := strSQL + '     LEFT JOIN CADCID ON TRA_CODCID = CID_CODCID';
            strSQL := strSQL + '   WHERE ';
            strSQL := strSQL + '     FOR_CODFOR = :CODFOR';
            strSQL := strSQL + ' UNION ALL';
            strSQL := strSQL + '   SELECT';
            strSQL := strSQL + '     FOR_TRARED AS CODTRA,';
            strSQL := strSQL + '     TRA_NOMTRA AS NOMTRA,';
            strSQL := strSQL + '     CONCAT(TRA_ENDERE, " - ", IFNULL(TRA_BAIRRO, "")) AS ENDERE,';
            strSQL := strSQL + '     CONCAT(CID_NOMCID, " - ", CID_ESTADO, " - Fone: ", IFNULL(TRA_FONE01, "")) AS NOMCID,';
            strSQL := strSQL + '     FOR_TIPFRR AS TIPFRE,';
            strSQL := strSQL + '     "REDES" AS FRETE';
            strSQL := strSQL + '   FROM';
            strSQL := strSQL + '     CADFOR';
            strSQL := strSQL + '     LEFT JOIN CADTRA ON FOR_TRARED = TRA_CODTRA';
            strSQL := strSQL + '     LEFT JOIN CADCID ON TRA_CODCID = CID_CODCID';
            strSQL := strSQL + '   WHERE';
            strSQL := strSQL + '     FOR_CODFOR =  :CODFOR';

            With qryTransp Do
            Begin
              close;
              SQL.Clear;
              SQL.Add(strSQL);
              ParamByName('CODFOR').AsString := edtCodFor.Text;
              Open;

              While Not qryTransp.Eof Do
              Begin
                If (qryTransp.Fieldbyname('FRETE').AsString = 'TRANS') Then
                begin
                  frmDigObservacoes.edtCodTra.Text := qryTransp.Fieldbyname('CODTRA').AsString;
                  frmDigObservacoes.edtNomTra.Text := qryTransp.Fieldbyname('NOMTRA').AsString;
                  frmDigObservacoes.edtEndere.Text := qryTransp.Fieldbyname('ENDERE').AsString;
                  frmDigObservacoes.edtCidade.Text := qryTransp.Fieldbyname('NOMCID').AsString;
                  If fEmptyStr(qryTransp.FieldByName('TIPFRE').AsString) Then
                    frmDigObservacoes.cmbTipFre.ItemIndex := frmDigObservacoes.cmbTipFre.Items.IndexOf(fDescricaoFrete(fCfgSis('FREPDC')))
                  Else
                    frmDigObservacoes.cmbTipFre.ItemIndex := frmDigObservacoes.cmbTipFre.Items.IndexOf(fDescricaoFrete(qryTransp.FieldByName('TIPFRE').AsString));

                  frmDigObservacoes.strTipFre := fTipoFrete(frmDigObservacoes.cmbTipFre.Text);
                End
                Else
                Begin
                  frmDigObservacoes.edtCodTraRedespacho.Text := qryTransp.Fieldbyname('CODTRA').AsString;
                  frmDigObservacoes.edtNomTraRedespacho.Text := qryTransp.Fieldbyname('NOMTRA').AsString;
                  frmDigObservacoes.edtEndereRedespacho.Text := qryTransp.Fieldbyname('ENDERE').AsString;
                  frmDigObservacoes.edtCidadeRedespacho.Text := qryTransp.Fieldbyname('NOMCID').AsString;
                  frmDigObservacoes.cmbTipFreRedespacho.ItemIndex := frmDigObservacoes.cmbTipFre.Items.IndexOf(fDescricaoFrete(qryTransp.FieldByName('TIPFRE').AsString));
                  frmDigObservacoes.strTipFreRedespacho := fTipoFrete(frmDigObservacoes.cmbTipFreRedespacho.Text);
                End;
                qryTransp.Next;
              End;
            End;

            If qryTransp.IsEmpty And (not fEmptyStr(qryPcmGer.FieldByName('PCG_TIPFRE').AsString)) And (not fEmptyStr(edtNumPed.Text)) Then
            begin
              frmDigObservacoes.cmbTipFre.ItemIndex := frmDigObservacoes.cmbTipFre.Items.IndexOf(fDescricaoFrete(qryPcmGer.FieldByName('PCG_TIPFRE').AsString));
              frmDigObservacoes.cmbTipFreRedespacho.ItemIndex := frmDigObservacoes.cmbTipFreRedespacho.Items.IndexOf(fDescricaoFrete(qryPcmGer.FieldByName('PCG_TIPFRR').AsString));
            End;

            FreeAndNil(qryTransp);

          End;

          If fEmptyStr(edtNumPed.Text) Then
          Begin
            stlObserv := fCarregaObservPedido;
            frmDigObservacoes.memObserv.Lines := stlObserv;
            frmDigObservacoes.edtAtenca.Text  :=
              fCampoTabela('FOR_NOMCTT', 'FORCTT', ['FOR_CODFOR', 'FOR_CMPCTT'], [edtCodFor.Text, 'S']);

            FreeAndNil(stlObserv);
          End Else
          Begin
            frmDigObservacoes.edtOrdemCompra.Text := qryPcmGer.FieldByName('PCG_ORDCON').AsString;

            frmDigObservacoes.memObserv.Lines.Add(fConcatenaObserv(True));

            frmDigObservacoes.edtAtenca.Text  := qryPcmGer.FieldByName('PCG_ATENCA').AsString;

            If (Not fEmptyStr(qryPcmGer.FieldByName('PCG_NUMPOK').AsString)) Then
              frmDigObservacoes.memObserv.Lines.Add(fConcatenaObserv(False));
          End;

          frmDigObservacoes.edtPedVen.Text  := qryPcmGer.FieldByName('PCG_PEDVEN').AsString;


          frmDigObservacoes.fraCentroCusto.edtCodEve.Text := qryPcmGer.FieldByName('PCG_CODEVE').AsString;

          If (Not fEmptyStr(qryPcmGer.FieldByName('PCG_CODEVE').AsString)) Then
            frmDigObservacoes.fraCentroCusto.edtDesEve.Text := fRetNomEvento(qryPcmGer.FieldByName('PCG_CODEVE').AsString);

          If Not fEmptyStr(qryPcmGer.FieldByName('PCG_CODCTA').AsString) Then
            frmDigObservacoes.fraPlanoDeContas.MskCodCta.Text := qryPcmGer.FieldByName('PCG_CODCTA').AsString
          Else
            frmDigObservacoes.fraPlanoDeContas.MskCodCta.Text := strCodCta;

          If Not fEmptyStr(frmDigObservacoes.fraPlanoDeContas.MskCodCta.Text) Then
            frmDigObservacoes.fraPlanoDeContas.edtDesCta.Text := fRetDescCentroCusto(frmDigObservacoes.fraPlanoDeContas.MskCodCta.Text);

          frmDigObservacoes.edtValFre.Text := FloatToStrF(fltValFreGer, ffNumber, 15, 2);
          frmDigObservacoes.edtDesAce.Text := FloatToStrF(fltDesAceGer, ffNumber, 15, 2);


          If edtCodDig.Visible Then
          Begin
            If fValidaCampos(edtCodCmp) Then
              frmDigObservacoes.strCodComprador := edtCodCmp.Text;
          End
          Else
             frmDigObservacoes.strCodComprador := fRetCodVendedor(edtCodCmp.Text);

          {*****************************************************************}
          {* CASO NÃO SEJA MULTILOJA INIBI A OPÇÃO - FINALIZACAO DO PEDIDO *}
          {**************************************************************LU*}
          If (recOpcGir.strPedMlj = 'N') Then
          Begin
            frmDigObservacoes.gpbFinalPed.Visible := False;
          End Else
          Begin
            If (fDoubleAggregate(cdsItensPedido, 'TOT_TOTGER') = 0  ) And blnManterZerados Then
            Begin
               frmDigObservacoes.rdgOpcMultiLojas.ItemIndex := 0;
               frmDigObservacoes.rdgOpcMultiLojas.Enabled := False;
            End
            Else If fPedidoSoUmaLoja(cdsItensMultiLojas) And (fCfgSis('DESPED', varInteger) = 1) Then
              frmDigObservacoes.rdgOpcMultiLojas.ItemIndex := 1;
          End;

          frmDigObservacoes.gpbOrdemCompra.Visible := blnUsaColeta;

          frmDigObservacoes.strCodFor := edtCodFor.Text;

          frmDigObservacoes.strConPag := mskCndPag.Text;
          frmDigObservacoes.dtaDtaEnt := StrToDate(mskDtaPed.Text);
          frmDigObservacoes.strNumPed := strNumPed;
          frmDigObservacoes.strEspDoc := strEspDoc;
          frmDigObservacoes.strEmpPed := strCodEmp;

          frmDigObservacoes.fltTotGer := fDoubleAggregate(cdsItensPedido, 'TOT_TOTGER'); // Total de Itens+IPI+SUB - Não está somado frete e desp. ace.
          frmDigObservacoes.strPedMlj := recOpcGir.strPedMlj;
          frmDigObservacoes.cdsItensPedido     := cdsItensPedido;
          frmDigObservacoes.cdsItensMultiLojas := cdsItensMultiLojas;
          If chkPedImp.Checked Then
          Begin
            frmDigObservacoes.cmbTipFre.Text   := 'Sem Frete';
            frmDigObservacoes.pnlFrete.Visible := False;
          End;

          frmDigObservacoes.objDuplicatasPedido := objDuplicatasPedido;
          frmDigObservacoes.pRateiaFreteDesAce  := pRateiaFreteDesAce;

          frmDigObservacoes.chkCalStFrete.Checked  := objCopiaSeg.recPcmger.strBStFre = 'S';
          frmDigObservacoes.chkCalStDesAce.Checked := objCopiaSeg.recPcmger.strBStAce = 'S';
          frmDigObservacoes.chkCalIpiFrete.Checked := objCopiaSeg.recPcmger.strIpiFre = 'S';

          frmDigObservacoes.chkEnvEmailAutomatico.Visible := egPedidoCompra.fIsActive;
          frmDigObservacoes.chkEnvEmailAutomatico.Checked := frmDigObservacoes.chkEnvEmailAutomatico.Visible;

          frmDigObservacoes.ShowModal;

          strOrdemCompra := frmDigObservacoes.edtOrdemCompra.Text;

          objCopiaSeg.recPcmger.strBStFre := IIF(frmDigObservacoes.chkCalStFrete.Checked, 'S', 'N');
          objCopiaSeg.recPcmger.strBStAce := IIF(frmDigObservacoes.chkCalStDesAce.Checked, 'S', 'N');
          objCopiaSeg.recPcmger.strIpiFre := IIF(frmDigObservacoes.chkCalIpiFrete.Checked, 'S', 'N');

          Result := frmDigObservacoes.blnConfirma;

          If Result Then
            blnEnviarEmailAutomatico := frmDigObservacoes.chkEnvEmailAutomatico.Checked;


          blnEndLoj   := frmDigObservacoes.rdgEndEnt.ItemIndex = 1;
          strCodTra   := frmDigObservacoes.strCodTra;
          strCodTraRedespacho := frmDigObservacoes.strCodTraRedespacho;
          strNomEmp   := frmDigObservacoes.edtNomEmp.Text;
          strEndEmp   := frmDigObservacoes.edtEndEmp.Text;
          strCidEmp   := frmDigObservacoes.edtCidEmp.Text;
          strObs001   := '';
          strObs002   := '';
          strObs003   := '';
          strObs004   := '';
          strObs005   := '';
          strObs006   := '';
          strTipFre   := frmDigObservacoes.strTipFre;
          strTipFreRedespacho := frmDigObservacoes.strTipFreRedespacho;
          fltValFre   := frmDigObservacoes.fltValFre;
          fltDesAce   := frmDigObservacoes.fltDesAce;

          strObsPd1   := frmDigObservacoes.strObserv1;
          strObsPd2   := frmDigObservacoes.strObserv2;
          strObsPd3   := frmDigObservacoes.strObserv3;
          strObsPd4   := frmDigObservacoes.strObserv4;
          strObsPd5   := frmDigObservacoes.strObserv5;
          strObsPd6   := frmDigObservacoes.strObserv6;

          strPedVen   := frmDigObservacoes.edtPedVen.Text;

          strAtenca   := frmDigObservacoes.strAtenca;
          strCodEve   := frmDigObservacoes.strCodEve;
          strCodCta   := fTiraCaracEspeciais(frmDigObservacoes.strCodCta);

          strFinPed   := frmDigObservacoes.strFinPed;
          If fEmptyStr(strFinPed) then
            strFinPed := 'N';

          mskCndPag.Text := frmDigObservacoes.strConPag;
          blnEnvWap := frmDigObservacoes.blnEnviarWhatsapp;
        Except
          On E: Exception Do
          Begin
            Result := False;
            blnApagaOnClose := False;
            pMensagensErro(E.Message, '[frmPedidoDeCompra.fConfirmaPedido]');
          End;
        End;

        pFreeAndNil(frmDigObservacoes);

      End
      Else
      Begin

        Try
          pCriarFormularios(TfrmDigObservacoes, frmDigObservacoes);

          frmDigObservacoes.gpbOrdemCompra.Visible := blnUsaColeta;

          strSQL := '';
          strSQL := strSQL + ' SELECT ';
          strSQL := strSQL + '   TRA_CODTRA AS CODTRA, ';
          strSQL := strSQL + '   TRA_NOMTRA AS NOMTRA, ';
          strSQL := strSQL + '   CONCAT(TRA_ENDERE, " - ", TRA_BAIRRO) AS ENDERE, ';
          strSQL := strSQL + '   CONCAT(CID_NOMCID, " - ", CID_ESTADO, " - Fone: ", TRA_FONE01) AS NOMCID ';
          strSQL := strSQL + ' FROM ';
          strSQL := strSQL + '   CADTRA ';
          strSQL := strSQL + '   LEFT JOIN CADCID ON TRA_CODCID = CID_CODCID ';
          strSQL := strSQL + ' WHERE ';
          strSQL := strSQL + '   TRA_CODTRA = :CODTRA ';
          qryTransp := fCriaQuery(Self);
          With qryTransp Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('CODTRA').AsString := qryPcmGer.FieldByName('PCG_CODTRA').AsString;
            Open;

            frmDigObservacoes.edtCodTra.Text := FieldbyName('CODTRA').AsString;
            frmDigObservacoes.edtNomTra.Text := FieldbyName('NOMTRA').AsString;
            frmDigObservacoes.edtEndere.Text := FieldbyName('ENDERE').AsString;
            frmDigObservacoes.edtCidade.Text := FieldbyName('NOMCID').AsString;
          End;

          If qryTransp.IsEmpty Then
          Begin
            strSQL := '';
            strSQL := strSQL + '   SELECT ';
            strSQL := strSQL + '     FOR_CODTRA AS CODTRA,';
            strSQL := strSQL + '     TRA_NOMTRA AS NOMTRA,';
            strSQL := strSQL + '     CONCAT(TRA_ENDERE, " - ", IFNULL(TRA_BAIRRO, "")) AS ENDERE,';
            strSQL := strSQL + '     CONCAT(CID_NOMCID, " - ", CID_ESTADO, " - Fone: ", IFNULL(TRA_FONE01, "")) AS NOMCID,';
            strSQL := strSQL + '     FOR_TIPFRE AS TIPFRE,';
            strSQL := strSQL + '     "TRANS" AS FRETE';
            strSQL := strSQL + '   FROM';
            strSQL := strSQL + '     CADFOR';
            strSQL := strSQL + '     LEFT JOIN CADTRA ON FOR_CODTRA = TRA_CODTRA';
            strSQL := strSQL + '     LEFT JOIN CADCID ON TRA_CODCID = CID_CODCID';
            strSQL := strSQL + '   WHERE ';
            strSQL := strSQL + '     FOR_CODFOR = :CODFOR';
            strSQL := strSQL + ' UNION ALL';
            strSQL := strSQL + '   SELECT';
            strSQL := strSQL + '     FOR_TRARED AS CODTRA,';
            strSQL := strSQL + '     TRA_NOMTRA AS NOMTRA,';
            strSQL := strSQL + '     CONCAT(TRA_ENDERE, " - ", IFNULL(TRA_BAIRRO, "")) AS ENDERE,';
            strSQL := strSQL + '     CONCAT(CID_NOMCID, " - ", CID_ESTADO, " - Fone: ", IFNULL(TRA_FONE01, "")) AS NOMCID,';
            strSQL := strSQL + '     FOR_TIPFRR AS TIPFRE,';
            strSQL := strSQL + '     "REDES" AS FRETE';
            strSQL := strSQL + '   FROM';
            strSQL := strSQL + '     CADFOR';
            strSQL := strSQL + '     LEFT JOIN CADTRA ON FOR_TRARED = TRA_CODTRA';
            strSQL := strSQL + '     LEFT JOIN CADCID ON TRA_CODCID = CID_CODCID';
            strSQL := strSQL + '   WHERE';
            strSQL := strSQL + '     FOR_CODFOR =  :CODFOR';

            With qryTransp Do
            Begin
              close;
              SQL.Clear;
              SQL.Add(strSQL);
              ParamByName('CODFOR').AsString := edtCodFor.Text;
              Open;

              While Not qryTransp.Eof Do
              Begin
                If (qryTransp.Fieldbyname('FRETE').AsString = 'TRANS') Then
                begin
                  frmDigObservacoes.edtCodTra.Text := qryTransp.Fieldbyname('CODTRA').AsString;
                  frmDigObservacoes.edtNomTra.Text := qryTransp.Fieldbyname('NOMTRA').AsString;
                  frmDigObservacoes.edtEndere.Text := qryTransp.Fieldbyname('ENDERE').AsString;
                  frmDigObservacoes.edtCidade.Text := qryTransp.Fieldbyname('NOMCID').AsString;
                  If fEmptyStr(qryTransp.FieldByName('TIPFRE').AsString) Then
                  Begin
                    If fEmptyStr(qryPcmGer.FieldByName('PCG_TIPFRE').AsString) Then
                      frmDigObservacoes.cmbTipFre.ItemIndex := frmDigObservacoes.cmbTipFre.Items.IndexOf(fDescricaoFrete(fCfgSis('FREPDC')))
                    Else
                      frmDigObservacoes.cmbTipFre.ItemIndex := frmDigObservacoes.cmbTipFre.Items.IndexOf(fDescricaoFrete(qryPcmGer.FieldByName('PCG_TIPFRE').AsString))
                  End
                  Else
                    frmDigObservacoes.cmbTipFre.ItemIndex := frmDigObservacoes.cmbTipFre.Items.IndexOf(fDescricaoFrete(qryTransp.FieldByName('TIPFRE').AsString));

                  frmDigObservacoes.strTipFre := fTipoFrete(frmDigObservacoes.cmbTipFre.Text);
                End
                Else
                Begin
                  frmDigObservacoes.edtCodTraRedespacho.Text := qryTransp.Fieldbyname('CODTRA').AsString;
                  frmDigObservacoes.edtNomTraRedespacho.Text := qryTransp.Fieldbyname('NOMTRA').AsString;
                  frmDigObservacoes.edtEndereRedespacho.Text := qryTransp.Fieldbyname('ENDERE').AsString;
                  frmDigObservacoes.edtCidadeRedespacho.Text := qryTransp.Fieldbyname('NOMCID').AsString;
                  If fEmptyStr(qryTransp.FieldByName('TIPFRE').AsString) Then
                  Begin
                    If fEmptyStr(qryPcmGer.FieldByName('PCG_TIPFRR').AsString) Then
                      frmDigObservacoes.cmbTipFreRedespacho.ItemIndex := frmDigObservacoes.cmbTipFreRedespacho.Items.IndexOf(fDescricaoFrete(fCfgSis('FREPDC')))
                    Else
                      frmDigObservacoes.cmbTipFreRedespacho.ItemIndex := frmDigObservacoes.cmbTipFreRedespacho.Items.IndexOf(fDescricaoFrete(qryPcmGer.FieldByName('PCG_TIPFRR').AsString))
                  End
                  Else
                    frmDigObservacoes.cmbTipFreRedespacho.ItemIndex := frmDigObservacoes.cmbTipFreRedespacho.Items.IndexOf(fDescricaoFrete(qryTransp.FieldByName('TIPFRE').AsString));
                  frmDigObservacoes.strTipFreRedespacho := fTipoFrete(frmDigObservacoes.cmbTipFreRedespacho.Text);
                End;
                qryTransp.Next;
              End;
            End;
          End;
          FreeAndNil(qryTransp);

          frmDigObservacoes.strCodFor := edtCodFor.Text;

          frmDigObservacoes.edtNomEmp.Text := strNomEmp;
          frmDigObservacoes.edtEndEmp.Text := strEndEmp;
          frmDigObservacoes.edtCidEmp.Text := strCidEmp;

          frmDigObservacoes.fltTotPed := fDoubleAggregate(cdsItensPedido, 'TOT_TOTGER');
          frmDigObservacoes.fltTotIte := fStrToFloat(dbeTotIte.Text);

          If fEmptyStr(edtNumPed.Text) Then
          Begin
            stlObserv := fCarregaObservPedido;

            frmDigObservacoes.memObserv.Lines := stlObserv;

            frmDigObservacoes.edtAtenca.Text  :=
              fCampoTabela('FOR_NOMCTT', 'FORCTT', ['FOR_CODFOR', 'FOR_CMPCTT'], [edtCodFor.Text, 'S']);

            FreeAndNil(stlObserv);
          End Else
          Begin
            frmDigObservacoes.edtOrdemCompra.Text := qryPcmGer.FieldByName('PCG_ORDCON').AsString;

            frmDigObservacoes.memObserv.Lines.Add(fConcatenaObserv(False));

            frmDigObservacoes.edtAtenca.Text  := qryPcmGer.FieldByName('PCG_ATENCA').AsString;
          End;

          frmDigObservacoes.edtPedVen.Text  := '';
          {*****************************}
          {* SUGESTÃO DE TIPO DE FRETE *}
          {**************************RV*}
          If fEmptyStr(qryPcmGer.FieldByName('PCG_TIPFRE').AsString) Then
            frmDigObservacoes.cmbTipFre.ItemIndex := frmDigObservacoes.cmbTipFre.Items.IndexOf(fDescricaoFrete(fCfgSis('FREPDC')))
          Else
            frmDigObservacoes.cmbTipFre.ItemIndex := frmDigObservacoes.cmbTipFre.Items.IndexOf(fDescricaoFrete(qryPcmGer.FieldByName('PCG_TIPFRE').AsString));

    //      frmDigObservacoes.edtValFre.Text := FloatToStrF(qryPcmGer.FieldByName('PCG_VALFRE').AsFloat,ffNumber,15,2);

          frmDigObservacoes.edtValFre.Text := FloatToStrF(fltValFreGer, ffNumber, 15, 2);
          frmDigObservacoes.edtDesAce.Text := FloatToStrF(fltDesAceGer, ffNumber, 15, 2);

          frmDigObservacoes.pnlPedidoVenda.Visible := False;

          frmDigObservacoes.fraCentroCusto.edtCodEve.Text := qryPcmGer.FieldByName('PCG_CODEVE').AsString;

          If (Not fEmptyStr(qryPcmGer.FieldByName('PCG_CODEVE').AsString)) Then
            frmDigObservacoes.fraCentroCusto.edtDesEve.Text := fRetNomEvento(qryPcmGer.FieldByName('PCG_CODEVE').AsString);

          frmDigObservacoes.fraPlanoDeContas.MskCodCta.Text := qryPcmGer.FieldByName('PCG_CODCTA').AsString;

          If (Not fEmptyStr(qryPcmGer.FieldByName('PCG_CODCTA').AsString)) Then
            frmDigObservacoes.fraPlanoDeContas.edtDesCta.Text := fRetDescCentroCusto(qryPcmGer.FieldByName('PCG_CODCTA').AsString);

          {*****************************************************************}
          {* CASO NÃO SEJA MULTILOJA INIBI A OPÇÃO - FINALIZACAO DO PEDIDO *}
          {**************************************************************LU*}
          If (recOpcGir.strPedMlj = 'N') Then
          Begin
            frmDigObservacoes.gpbFinalPed.Visible := False;
          End;

          frmDigObservacoes.strConPag := mskCndPag.Text;
          frmDigObservacoes.dtaDtaEnt := StrToDate(mskDtaPed.Text);
          frmDigObservacoes.strNumPed := strNumPed;
          frmDigObservacoes.fltTotGer := fDoubleAggregate(cdsItensPedido, 'TOT_TOTGER'); // Total de Itens+IPI+SUB - Não está somado frete e desp. ace.
          frmDigObservacoes.strPedMlj := recOpcGir.strPedMlj;
          frmDigObservacoes.strEspDoc := strEspDoc;
          frmDigObservacoes.cdsItensPedido     := cdsItensPedido;
          frmDigObservacoes.cdsItensMultiLojas := cdsItensMultiLojas;

          frmDigObservacoes.objDuplicatasPedido := objDuplicatasPedido;
          frmDigObservacoes.pRateiaFreteDesAce  := pRateiaFreteDesAce;

          frmDigObservacoes.chkCalStFrete.Checked  := objCopiaSeg.recPcmger.strBStFre = 'S';
          frmDigObservacoes.chkCalStDesAce.Checked := objCopiaSeg.recPcmger.strBStAce = 'S';

          frmDigObservacoes.ShowModal;

          strOrdemCompra := frmDigObservacoes.edtOrdemCompra.Text;

          objCopiaSeg.recPcmger.strBStFre := IIF(frmDigObservacoes.chkCalStFrete.Checked, 'S', 'N');
          objCopiaSeg.recPcmger.strBStAce := IIF(frmDigObservacoes.chkCalStDesAce.Checked, 'S', 'N');
          objCopiaSeg.recPcmger.strIpiFre := IIF(frmDigObservacoes.chkCalIpiFrete.Checked, 'S', 'N');

          Result := frmDigObservacoes.blnConfirma;




          blnEndLoj   := frmDigObservacoes.rdgEndEnt.ItemIndex = 1;
          strCodTra   := frmDigObservacoes.strCodTra;
          strCodTraRedespacho := frmDigObservacoes.strCodTraRedespacho;
          strNomEmp   := frmDigObservacoes.edtNomEmp.Text;
          strEndEmp   := frmDigObservacoes.edtEndEmp.Text;
          strCidEmp   := frmDigObservacoes.edtCidEmp.Text;
          strTipFre   := frmDigObservacoes.strTipFre;
          strTipFreRedespacho   := frmDigObservacoes.strTipFreRedespacho;
          fltValFre   := frmDigObservacoes.fltValFre;

          strObs001   := frmDigObservacoes.strObserv1;
          strObs002   := frmDigObservacoes.strObserv2;
          strObs003   := frmDigObservacoes.strObserv3;
          strObs004   := frmDigObservacoes.strObserv4;
          strObs005   := frmDigObservacoes.strObserv5;
          strObs006   := frmDigObservacoes.strObserv6;

          strPedVen   := '';

          strAtenca   := frmDigObservacoes.strAtenca;
          strCodEve   := frmDigObservacoes.strCodEve;
          strCodCta   := fTiraCaracEspeciais(frmDigObservacoes.strCodCta);

          strFinPed   := frmDigObservacoes.strFinPed;
          If fEmptyStr(strFinPed) then
            strFinPed := 'N';

          mskCndPag.Text := frmDigObservacoes.strConPag;
          blnEnvWap := frmDigObservacoes.blnEnviarWhatsapp;
        Except
          On E: Exception Do
          Begin
            Result := False;
            pMensagensErro(E.Message, '[frmPedidoDeCompra.fConfirmaPedido_1]');
          End;
        End;

        pFreeAndNil(frmDigObservacoes);

      End;

    End;

    If Result Then
    Begin
      {$Region  'Prepra calculo pedido'}
      If Not blnFazerApenasTransferencias Then
      Begin
        blnRecalcularFrete := (fltValFreGer <> fltValFre) Or (fltDesAceGer <> fltDesAce);

        fltValFreGer := fltValFre;
        fltDesAceGer := fltDesAce;

        edtTotFre.Text    := FormatFloat('#,##0.00', fltValFreGer);
        edtTotDes.Text    := FormatFloat('#,##0.00', fltDesAceGer);

        If Assigned(pgbStatus) Then
        Begin
          intQtdMult := StrToIntDef(edtQtdCtn.Text, 1);

          If intQtdMult = 0 Then
            intQtdMult := 1;

          pgbStatus.Properties.Max := cdsItensPedido.RecordCount * intQtdMult + 8;
        End;

        pStepBy;
        Application.ProcessMessages;

        {******************************************}
        {* INICIA A TRANSAÇÃO E PEGA O SEQUENCIAL *}
        {***************************************MV*}
        cdsItensPedido.DisableControls;
        cdsItensPedido.AfterScroll := Nil;
        Self.Enabled := False;
        cxgItens.Enabled := False;

        Try
          If Assigned(cdsDigMultLoja) Then
          Begin
            cdsDigMultLoja.desvinculaCDS;

            If strFinPed = 'S' Then
            Begin
              fltValFreRes := fltValFreGer;
              fltDesAceRes := fltDesAceGer;
              fltTotIteGer := fDoubleAggregate(cdsItensPedido, 'TOT_TOTITE');

              If recOpcGir.strPedMlj = 'S' Then
                pAjustaMultiLoja(cdsItensPedido, cdsItensMultiLojas, chkPedImp.Checked);

              strItensPed := fRetItensPed(cdsItensPedido);
              fCalculaTotalEmpresas(strItensPed, cdsItensMultiLojas, fltDesAceGer, fltValFreGer, frmGravandoConfirmaPedido);
            End;

          End;

          objValidaValorPedidoCompra := TValidaValorPedidoCompra.Create(cdsItensMultiLojas, cdsItensPedido,
                                         nil, edtCodFor.Text, fltDesAceGer, fltValFreGer,
                                        strFinPed = 'S', cdsDigMultLoja.cdsTotalEmpresas);//Desmembrando Pedido);

          //Deu Algum erro que impossibilitou o teste
          If objValidaValorPedidoCompra.blnErroAoExecutar Then
          Begin
            Result := False;
            cdsItensPedido.EnableControls;
            Self.Enabled := True;
            cxgItens.Enabled := True;

            If Assigned(cdsDigMultLoja) Then
              cdsDigMultLoja.vinculaCDS;

            Exit;
          End;

          If objValidaValorPedidoCompra.blnExistePedidosComValoresInferiores then
          Begin
            Result := objValidaValorPedidoCompra.fPedeSenhaLiberarTrava;
            If Not Result Then
            Begin
              cdsItensPedido.EnableControls;
              Self.Enabled := True;
              cxgItens.Enabled := True;

              If Assigned(cdsDigMultLoja) Then
                cdsDigMultLoja.vinculaCDS;

              Exit;
            End;
          End;

        Finally
          FreeAndNil(objValidaValorPedidoCompra);
        End;

      End;
      {$endregion}

      qryGravacao := fCriaQuery;

      fStartTransaction;

      Try

        If Not objTransfere.fGeraTransferencia Then
          Raise Exception.Create('Erro ao gerar transferências!');

        // SEMPRE NA GRAVAÇÃO VAI PASSAR O PEDIDO PARA NÃO LIBERADO
        strCampoSaldoAdd := fRetCampoAtualizaSaldoPedidoCompra(IIF( blnLibPcm, False, True), edtCodFor.Text, strForFil);

        {$Region 'Gera Pedido'}
        If Not blnFazerApenasTransferencias Then
        Begin
          objItensExcluidos.fApagaExcluidos(cdsItensPedido, blnManterZerados);

          {*****************************************}
          {* DELETA REGISTROS COM QUANTIDADE ZERO  *}
          {**************************************MV*}
          pFiltraQuantidadeZero(Not blnManterZerados);

          {*****************************************}
          {* SE ESTIVER TRANSFORMANDO DE ORÇAMENTO *}
          {* PARA PEDIDO, DELETA O ORÇAMENTO ATUAL *}
          {**************************************MV*}
          strOrcOri := '';
          If blnTransforma Then
            strOrcOri := Concat(edtNumPed.Text, strEspOri, strCodEmp);

          If (strFinPed = 'N') Then
          Begin

            If (blnNovoReg) Or (blnModoHeranca) Then
            Begin
              If strEspDoc = 'PD' Then
                strNumPed := fSeqPedidoCompra(False, strCodEmp)
              Else
                strNumPed := fSeqOrcamento(False, strCodEmp);
            End;

          End;

          If Not blnNovoReg Then
          Begin
            pCarregaItensBaixados;

            (*
            If (strFinPed = 'N') Then
            Begin
              objRequisicao.fAtualizarVinculoRequisicoes(recOpcGir.strValKey, True);
              pDeletaPcmDet(strNumPed, strEspDoc, strCodEmp);
            End;
            *)

            If StrToIntDef(fRetQtdCtn, 0) > 0 Then
              pDeletaPedidosContainer(strNumPed, strEspDoc, strCodEmp);

            If (strFinPed = 'N') Then
            Begin
              pApagaPcdDet(strNumPed, strCodEmp, strEspDoc);
            End;

          End;

          pStepBy;
          Application.ProcessMessages;

          strNumPok := qryPcmGer.FieldByName('PCG_NUMPOK').AsString;

          {***********************************************}
          {* GRAVA PEDIDO ÚNICO, MESMO QD FOR MULTILOJAS *}
          {********************************************LU*}
          {$Region 'GRAVA PEDIDO ÚNICO, MESMO QD FOR MULTILOJAS'}
          If (strFinPed = 'N') Then
          Begin

            {*********************************************}
            {* FAZ A GRAVAÇÃO DA QUANTIDADE DE CONTAINERS*}
            {******************************************MV*}
            For intContador := 0 To IIf(StrToInt(edtQtdCtn.Text) = 1 , 0, StrToInt(edtQtdCtn.Text)) Do
            Begin

              If horHorPed = 0 Then
                horHorPed := fTime();

              {*******************************************}
              {* QUANDO GRAVA PEDIDOS CONTAINER, OS MES- *}
              {* MOS SÃO -> SEMPRE <- APAGADOS, PORTANTO *}
              {* SEMPRE REGRAVADOS                       *}
              {****************************************MV*}
              If (blnNovoReg) Or (blnModoHeranca) Or (intContador > 0) Then
              Begin
                {*****************************************}
                {* VERIFICA A NECESSIDADE DE GRAVAR O    *}
                {* CAMPO EMPDES.                         *}
                {**************************************MV*}
                strEmpDes := '';
                If (qryPcmGer.Active) Then
                  strEmpDes := qryPcmGer.FieldByName('PCG_EMPDES').AsString;

                {*****************************************}
                {* GRAVA A TABELA GERAL                  *}
                {**************************************MV*}
                strPedidosCompraGerados := strPedidosCompraGerados + IIf(strPedidosCompraGerados = '' , '', '|') + strNumPed+';'+strCodEmp;

                With recOpcGir, recNivEst do
                pGravaPcmGer(objCopiaSeg.recPcmger.blnSomaDescontoAdcionalFornecedor1,
                             Nil,
                             objDuplicatasPedido,
                             strNumPed,                               // Número do Pedido
                             strCodEmp,                               // Empresa
                             strEspDoc,                               // Espécie (PD / OR)
                             edtCodFor.Text,                          // Fornecedor
                             strCodTra,                               // Transportadora
                             strCodTraRedespacho,                     // Transportadora Redespacho
                             mskCndPag.Text,                          // Cond. Pagamento
                             dtaDtaPed,                               // Data do Pedido
                             horHorPed,                               // Hora do Pedido
                             StrToDateDef(mskDtaPed.Text, VS_Date),   // Data de Entrega
                             fTrataCodCmp,                            // Comprador
                             fStrToFloat(dbeTotIpi.Text),             // Total de IPI
                             fStrToFloat(dbeTotSub.Text),             // Total de SUB
                             fDoubleAggregate(cdsItensPedido, 'TOT_TOTDAR'),
                             fStrToFloat(dbeSubFCP.Text),             // Total de SUB FCP
                             fStrToFloat(dbeTotIte.Text),             // Total de Itens
                             fDoubleAggregate(cdsItensPedido, 'TOT_TOTGER') + fltValFre + fltDesAce, // Total de Itens+IPI+SUB
                             strObs001,                               // Observação 1
                             strObs002,                               // Observação 2
                             strObs003,                               // Observação 3
                             strObs004,                               // Observação 4
                             strObs005,                               // Observação 5
                             strObsPd1,                               // Observ PD 1
                             strObsPd2,                               // Observ PD 2
                             strObsPd3,                               // Observ PD 3
                             strPedVen,                               // Pedido de venda
                             strAtenca,                               // Atenção de
                             strTipFre,                               // Tipo de Frete
                             strTipFreRedespacho,                     // Tipo de Frete Redespacho
                             '',                                      // Origem do Documento (Faturamento)
                             intContador,                             // Número do Container
                             IIF(chkPedImp.Checked, 'S', 'N'),        // Pedido de Importação?
                             IIF(chkPedInt.Checked, 'S', 'N'),        // Pedido Intrepostado?
                             strEmpDes,                               // Codigo da empresa destino
                             fStrToFloat(edtDesAdi.Text),             // Desconto Adicionsl
                             strPedMlj,                               // Pedido Multi Lojas?
                             fltValFre,                               // Valor do Frete
                             fltDesAce,                               // Despesas Acessórias
                             StrToDateDef(mskDtaFat.Text, VS_Date),   // Data de Faturamento
                             strCodEve,                               // Código do Evento
                             strCodCta,                               // Centro de Custo
                             strNomEmp,                               // Nome p/ Entrega
                             strEndEmp,                               // Endereço p/ Entrega
                             strCidEmp,                               // Cidade p/ Entrega
                             strNiveis,                               // Nivel de Giro Selecionado A_B_C_
                             nivEstoque,                              // Usa Nivel de Giro
                             intDiaComGer,                            // Dias Compra Geral
                             intDiaComNvA,                            // Dias Compra Nivel A
                             intDiaComNvB,                            // Dias Compra Nivel B
                             intDiaComNvC,                            // Dias Compra Nivel C
                             fRetImposto('BASCOF'),
                             fRetImposto('VALCOF'),
                             fRetImposto('BASPIS'),
                             fRetImposto('VALPIS'),
                             fRetImposto('BASICM'),
                             fRetImposto('VALICM'),
                             fRetImposto('BASIPI'),
                             fRetImposto('BASSUB'),
                             IIF(chkPgAVis.Checked, 'S', 'N'),        // Pagamento A Vista
                             '',                                      // Número da cotação
                             '',                                      // Empresa da cotação
                             IIF(chkPedBon.Checked, 'S', 'N'),        // Pedido Bonificação
                             IIF(chkZeraST.Checked, 'S', 'N'),        // Zera Subst Tribut
                             IIF(rdgDesPdi.ItemIndex = 0, 'P','F'),   // Descrição do item no pedido de importação
                             intMesGir,
                             IIF(blnConsMesAtu, 'S', 'N'),
                             strOrcOri,                               // Número do orçamento que originou o pedido
                             fltValTax,
                             fltValMar,                               // Número do orçamento que originou o pedido
                             fRetImposto('DESPIS'),
                             recOpcGir.strValKey,
                             IIF(blnUsaGiro, 'S', 'N'),
                             False,
                             strCodDig,
                             strNumPok,
                             IIF(chkPreDol.Checked, INT_MOEDA_DOLAR, INT_MOEDA_REAL),
                             'N', // strPreOrc: String = 'N'
                             objCopiaSeg.recPcmger.strBStFre,
                             objCopiaSeg.recPcmger.strBStAce,
                             strOrdemCompra,
                             fRetornaTipoCodigoFabricaProduto,  //Código de fábrica do produto;
                             strObsPd4,
                             strObsPd5,
                             strObsPd6,
                             objCopiaSeg.recPcmger.strIPIFre,
                             chkPagamentoCartaoCredito.Checked,
                             strObs006,                               // Observação 6 (Orçamento)
                             fDoubleAggregate(cdsItensPedido, 'TOT_VALCBS'),
                             fDoubleAggregate(cdsItensPedido, 'TOT_VALIBS'),
                             fDoubleAggregate(cdsItensPedido, 'TOT_VAL_IS'));

                If Assigned(recOpcGir.objSalInt) And (Not fEmptyStr(recOpcGir.strValKey)) And blnNovoReg Then
                Begin
                  If Not recOpcGir.objSalInt.fSalvaDados(recOpcGir.strValKey) Then
                    Raise Exception.Create('Erro ao gravar filtros do giro de estoque!');
                End;

                If (Not fEmptyStr(recOpcGir.strValKey)) Then
                  stlAutIncrem.Add(recOpcGir.strValKey);

                //Mensagem de Liberação de Pedido de Compra
                If blnLibPcm Then
                  pMensagemPedidoCompraLiberar(strCodEmp,                                                              //Empresa
                                               strNumPed,                                                              //Pedido
                                               strEspDoc,                                                              //Espécie
                                               edtCodFor.Text,                                                         //Fornecedor
                                               dtaDtaPed,                                                              //Data do Pedido
                                               StrToDateDef(mskDtaPed.Text, VS_Date),                                  //Data de Entrega
                                               fDoubleAggregate(cdsItensPedido, 'TOT_TOTGER') + fltValFre + fltDesAce, // Total de Itens+IPI+SUB = TOTGER
                                               True);                                                                  // Inclusão ou Alteração
              End
              Else
              Begin
                {*****************************************}
                {* ATUALIZA A TABELA GERAL               *}
                {**************************************MV*}
                 strPedidosCompraGerados := strPedidosCompraGerados + IIf(strPedidosCompraGerados = '' , '', '|') + strNumPed+';'+strCodEmp;

                pAtualizaPcmGer(objCopiaSeg.recPcmger.blnSomaDescontoAdcionalFornecedor1,
                                Nil,
                                objDuplicatasPedido,
                                strNumPed,                               // Número do Pedido
                                strCodEmp,                               // Empresa
                                strEspDoc,                               // Espécie
                                edtCodFor.Text,                          // Fornecedor
                                strCodTra,                               // Transportadora
                                strCodTraRedespacho,                     // Redespacho
                                mskCndPag.Text,                          // Condição de Pagamento
                                dtaDtaPed,                               // Data do Pedido
                                horHorPed,                               // Hora do Pedido
                                StrToDateDef(mskDtaPed.Text, VS_Date),   // Data de Entrega
                                fTrataCodCmp,                            // Comprador
                                fStrToFloat(dbeTotIpi.Text),             // Total de IPI
                                fStrToFloat(dbeTotSub.Text),             // Total de SUB
                                fDoubleAggregate(cdsItensPedido, 'TOT_TOTDAR'),
                                fStrToFloat(dbeSubFCP.Text),             // Total de SUB FCP
                                fStrToFloat(dbeTotIte.Text),             // Total de Itens
                                fDoubleAggregate(cdsItensPedido, 'TOT_TOTGER') + fltValFre + fltDesAce, // Total de Itens+IPI+SUB
                                strObs001,                               // Observação 1
                                strObs002,                               // Observação 2
                                strObs003,                               // Observação 3
                                strObs004,                               // Observação 4
                                strObs005,                               // Observação 5
                                strObsPd1,                               // Observ PD 1
                                strObsPd2,                               // Observ PD 2
                                strObsPd3,                               // Observ PD 3
                                strPedVen,                               // Pedido de venda
                                strAtenca,                               // Atenção de
                                strTipFre,                               // Tipo de Frete
                                strTipFreRedespacho,                     // Tipo de Frete
                                fStrToFloat(edtDesAdi.Text),             // Desconto Adicional
                                fltValFre,                               // Valor do Frete
                                fltDesAce,                               // Despesas Acessórias
                                IIF(chkPedImp.Checked, 'S', 'N'),        // Pedido de Importação?
                                IIF(chkPedInt.Checked, 'S', 'N'),        // Pedido Intrepostado
                                StrToDateDef(mskDtaFat.Text, VS_Date),   // Data de Faturamento
                                strCodEve,                               // Código do Evento
                                strCodCta,                               // Centro de Custo
                                strNomEmp,                               // Nome p/ Entrega
                                strEndEmp,                               // Endereço p/ Entrega
                                strCidEmp,                               // Cidade p/ Entrega
                                fRetImposto('BASCOF'),
                                fRetImposto('VALCOF'),
                                fRetImposto('BASPIS'),
                                fRetImposto('VALPIS'),
                                fRetImposto('BASICM'),
                                fRetImposto('VALICM'),
                                fRetImposto('BASIPI'),
                                fRetImposto('BASSUB'),
                                IIF(chkPgAVis.Checked, 'S', 'N'),       // Pagamento A Vista
                                IIF(chkPedBon.Checked, 'S', 'N'),       // Pedido Bonificação
                                IIF(chkZeraST.Checked, 'S', 'N'),       // Zera Subst
                                IIF(rdgDesPdi.ItemIndex = 0, 'P','F'),  // Descrição do item no pedido de importação
                                fltValTax,
                                fltValMar,
                                fRetImposto('DESPIS'),
                                False,
                                qryPcmGer.FieldByName('AUTOINCREM').AsString,
                                strCodDig,
                                IIF(chkPreDol.Checked, INT_MOEDA_DOLAR, INT_MOEDA_REAL),
                                objCopiaSeg.recPcmger.strBStFre,
                                objCopiaSeg.recPcmger.strBStAce,
                                strOrdemCompra,
                                fRetornaTipoCodigoFabricaProduto, //Código de fábrica do produto);
                                strObsPd4,
                                strObsPd5,
                                strObsPd6,
                                objCopiaSeg.recPcmger.strIPIFre,
                                chkPagamentoCartaoCredito.Checked,
                                strObs006,                               // Observação 6 (Orçamento)
                                fDoubleAggregate(cdsItensPedido, 'TOT_VALCBS'),
                                fDoubleAggregate(cdsItensPedido, 'TOT_VALIBS'),
                                fDoubleAggregate(cdsItensPedido, 'TOT_VAL_IS'));

                //Mensagem de Liberação de Pedido de Compra
                If blnLibPcm Then
                  pMensagemPedidoCompraLiberar(strCodEmp,                                                              //Empresa
                                               strNumPed,                                                              //Pedido
                                               strEspDoc,                                                              //Espécie
                                               edtCodFor.Text,                                                         //Fornecedor
                                               dtaDtaPed,                                                              //Data do Pedido
                                               StrToDateDef(mskDtaPed.Text, VS_Date),                                  //Data de Entrega
                                               fDoubleAggregate(cdsItensPedido, 'TOT_TOTGER') + fltValFre + fltDesAce, // Total de Itens+IPI+SUB = TOTGER
                                               False);
              End;
            End;

            pStepBy;
            Application.ProcessMessages;

            {*******************************************}
            {* REALIZA GRAVAÇÃO DO PCMDET DOS CONTAI-  *}
            {* NER                                     *}
            {****************************************MV*}

            For intContador := 0 To IIf(StrToInt(edtQtdCtn.Text) = 1 , 0, StrToInt(edtQtdCtn.Text)) Do
            Begin

              With cdsItensPedido Do
              Begin

                {*****************************************}
                {* GRAVA O ARQUIVO DETALHADO             *}
                {**************************************MV*}
                First;
                strAutIncPcmDet :=  fRetAutoIncrem('PCMDET', VS_strCodEmp, cdsItensPedido.RecordCount);
                strAutIncPcmDetBkp := strAutIncPcmDet;

                If (recOpcGir.strPedMlj = 'S') Then
                Begin
                  cdsItensMultiLojas.Filtered := False;
                  cdsItensMultiLojas.Filter   := 'ITE_QTDITE > 0';
                  cdsItensMultiLojas.Filtered := True;

                  strAutIncPcdDet :=  fRetAutoIncrem('PCDDET', VS_strCodEmp, cdsItensMultiLojas.RecordCount);
                 // cdsItensMultiLojas.Filtered := False;

                  cdsItensMultiLojas.IndexFieldNames := 'ITE_CODITE';
                End;

                While Not Eof Do
                Begin
                   Application.ProcessMessages;

                   If blnZerCon Then
                     fltQtdIte := 0
                   Else
                     fltQtdIte := fRetQtdConferida(FieldByName('ITE_CODITE').AsString, FieldByName('ITE_QTDITE').AsFloat);  // Conferencia de entrada

                   SQL.Add(fGravaPcmDet(intQtdConCol,
                               qryColeta,
                               blnUsaColeta And (strEspDoc = 'PD') And (recOpcGir.strPedMlj = 'N'),  // VAI GRAVAR AS COLETAS SOMENTE QUANDO DESMENBRAR O PEDIDO
                               strEmpDes,
                               strCampoSaldoSub,
                               strCampoSaldoAdd,
                               intDecTpc,
                               strNumPed,                                // Número do Pedido
                               strCodEmp,                                // Empresa
                               strEspDoc,                                // Espécie (PD / OR)
                               edtCodFor.Text,                           // Fornecedor
                               FieldByName('ITE_CODITE').AsString,       // Código Item
                               FieldByName('ITE_CODUNI').AsString,       // Código da Unidade
                               IfThen(mskDtaEnt.Visible, FieldByName('ITE_DTAENT').AsDateTime, StrToDateDef(mskDtaPed.Text, VS_Date)),  // Data Entrega
                               horHorPed,                                // Hora do Pedido
                               dtaDtaPed,                                // Data do Pedido
                               mskCndPag.Text,                           // Cond. Pagamento
                               FieldByName('ITE_DESITE').AsString,       // Descrição Item
                               FieldByName('ITE_QTDITE').AsFloat,        // Quantidade
                               FieldByName('ITE_UNITAR').AsFloat,        // Preço Unitario
                               FieldByName('ITE_DESUNI').AsFloat,        // % Desconto Unitario
                               FieldByName('ITE_DESUN2').AsFloat,        // % Desconto Unitario
                               FieldByName('ITE_DESUN3').AsFloat,        // % Desconto Unitario
                               FieldByName('ITE_DESUN4').AsFloat,        // % Desconto Unitario
                               FieldByName('ITE_DESUN5').AsFloat,        // % Desconto Unitario
                               FieldByName('ITE_DESUN6').AsFloat,        // % Desconto Unitario

                               FieldByName('ITE_TOTITE').AsFloat,        // Total Itens S
                               FieldByName('ITE_PERIPI').AsFloat,        // Percentual IPI
                               FieldByName('ITE_TOTIPI').AsFloat,        // Total IPI

                               FieldByName('ITE_PERSUB').AsFloat,        // Percentual SUB
                               FieldByName('ITE_TOTSUB').AsFloat,        // Total SUB
                               FieldByName('ITE_TOTDAR').AsFloat,        // Total DARE

                               FieldByName('ITE_PERFCP').AsFloat,        // Percentual SUB FCP
                               FieldByName('ITE_SUBFCP').AsFloat,        // Total SUB FCP

                               0,                                        // Quantidade Baixa
                               0,                                        // Total Baixado
                               0,                                        // IPI Baixado
                               0,                                        // SUB Baixado
                               0,                                        // DARE Baixado
                               0,                                        // SUB FCP Baixado
                               0,                                        // fltFreBai
                               0,                                        // fltAceBai
                               FieldByName('ITE_VALFRE').AsFloat,        // fltValFre
                               FieldByName('ITE_DESACE').AsFloat,        // fltDesAce
                               0,                                        // Baixado?
                               '',                                       // Origem do Documento (Faturamento)
                               intContador,                              // Número do Container
                               IIF(chkPedImp.Checked, 'S', 'N'),         // Pedido de Importação?
                               IIF(chkPedInt.Checked, 'S', 'N'),         // Pedido Intrepostado
                               FieldByName('ITE_PEDTXT').AsString,       // Proveninete de Importação?
                               FieldByName('ITE_QTDINC').AsFloat,       // Proveninete de Importação?
                               FieldByName('ITE_TRAINC').AsFloat,       // Proveninete de Importação?
                               strAutIncPcmDet,                          // Auto Incremento
                               FieldByName('ITE_CODACA').AsString,       // Código do produto acabado
                               FieldByName('ITE_EMPACA').AsString,       // Empresa do produto acabado
                               FieldByName('ITE_PROACA').AsString,       // Produto acabado? (S/N)
                               fltQtdIte,
                               FieldByName('ITE_BASSUB').AsFloat,
                               FieldByName('ITE_BASIPI').AsFloat,
                               FieldByName('ITE_BASICM').AsFloat,
                               FieldByName('ITE_PERBAS').AsFloat,
                               FieldByName('ITE_ALQICM').AsFloat,
                               FieldByName('ITE_VALICM').AsFloat,
                               FieldByName('ITE_INCPIS').AsString = 'S',
                               FieldByName('ITE_INCIRQ').AsString,
                               FieldByName('ITE_ALQPIS').AsFloat,
                               FieldByName('ITE_ALQCOF').AsFloat,
                               FieldByName('ITE_ALQIMP').AsFloat,
                               FieldByName('ITE_VALIMP').AsFloat,
                               FieldByName('ITE_VALSIS').AsFloat,
                               FieldByName('ITE_VALMAR').AsFloat,
                               FieldByName('ITE_SEQFDO').AsString,
                               FieldByName('ITE_QTDEMB').AsFloat,
                               FieldByName('ITE_ALQPIS').AsFloat,
                               FieldByName('ITE_ALQCOF').AsFloat,
                               FieldByName('ITE_SUBUSU').AsString,
                               FieldByName('ITE_DESPIS').AsFloat,
                               False,                                                                                  //   blnTabRestaura: Boolean = False;
                               '',                                                                                     //   strSeqGer: String = '';
                               (FieldByName('ITE_GRAVAD').AsString <> 'S') Or (intContador > 0) Or blnTransforma Or blnModoHeranca,  //   blnInsere: Boolean = True;
                               FieldByName('AUTOINCREM').AsString,                     //   strAutoin: String = ''): string;
                               False, -1,
                               FieldByName('ITE_DTAEDT').AsDateTime,
                               FieldByName('ITE_UNILIQ').AsFloat,
                               FieldByName('ITE_ALQCBS').AsFloat,
                               FieldByName('ITE_ALQIBS').AsFloat,
                               FieldByName('ITE_ALQ_IS').AsFloat,
                               FieldByName('ITE_VALCBS').AsFloat,
                               FieldByName('ITE_VALIBS').AsFloat,
                               FieldByName('ITE_VAL_IS').AsFloat));

                  If (recOpcGir.strPedMlj = 'S') Then
                    SQL.Add(fGravarPcdDet(strAutIncPcdDet,
                                          strNumPed,
                                          strEspDoc,
                                          strCodEmp,
                                          cdsItensPedido.FieldByName('ITE_CODITE').AsString,
                                          strAutIncPcmDet,
                                          cdsItensMultiLojas,
                                          False,   // blnTabRestaura: Boolean = False;
                                          '',      // strAutPcg: String = '';
                                          False,   //  blnGerarAutoincrem: Boolean = False;
                                          False)); // Filtra


                  Next;
                  pIncrementaAutoIncrem(strAutIncPcmDetBkp);
                  strAutIncPcmDet := strAutIncPcmDetBkp;

                  SQL.Text := TMontaSQLPedidoCompra.fAjustaAutoIncControleDeColeta(intQtdConCol, SQL.Text);

                  If (cdsItensPedido.RecNo mod 500) = 0 Then
                  Begin
                    fExecutaScript(SQL.Text, qryGravacao, False);
                    qryGravacao.SQL.Clear;
                    SQL.Clear;
                  End;

                  blnGerouPedido := True;

                  pStepBy;
                End; {While Not Eof Do}

                If SQL.Count > 0 Then
                Begin
                  fExecutaScript(SQL.Text, qryGravacao, False);
                  qryGravacao.SQL.Clear;
                  SQL.Clear;
                End;

              End;

            End;

            pStepBy;
            ProcessaStatusPedidoRequisicaoPedidoCompra(recOpcGir.strValKey);

            pTemItensDuplicados(strNumPed, strCodEmp, strEspDoc);
            // Req 172112 não conseguimos identificar motivo da falha, então estamos baixando o PD, caso ele fique sem pcmdet
            fExecutaScript('UPDATE PCMGER ' +
                           ' LEFT JOIN PCMDET ON PCD_NUMPED = PCMGER.PCG_NUMPED AND ' +
                           '              PCD_ESPDOC = PCMGER.PCG_ESPDOC AND ' +
                           '               PCD_CODEMP = PCMGER.PCG_CODEMP ' +
                           '       SET PCG_BAIXAD = IF(PCMDET.PCD_CODITE IS NULL, 1, PCG_BAIXAD) ' +
                           '     WHERE PCG_NUMPED = "' + strNumPed + '"' +
                           '       AND PCG_CODEMP = "' + strCodEmp + '"' +
                           '       AND PCG_ESPDOC = "' + strEspDoc + '"' , qryGravacao, False)
          End  {$ENDRegion}
          Else
          {$REGION 'GRAVAÇÃO DO PEDIDO MULTI-LOJA  - DESMENBRANDO PEDIDO'}
          Begin // GRAVAÇÃO DO PEDIDO MULTI-LOJA  - DESMENBRANDO PEDIDO
           {
            fltValFreRes := fltValFreGer;
            fltDesAceRes := fltDesAceGer;
            fltTotIteGer := fDoubleAggregate(cdsItensPedido, 'TOT_TOTITE');

            If recOpcGir.strPedMlj = 'S' Then
              pAjustaMultiLoja(cdsItensPedido, cdsItensMultiLojas, chkPedImp.Checked);
           }
            If Not blnUsarGiro Then
            Begin
              If fCfgSis('INCPED') = '1' Then
              Begin
                cdsItensPedido.IndexFieldNames := 'ITE_DESITE';
                cdsItensMultiLojas.IndexFieldNames := 'ITE_DESITE';
              End
              Else
              Begin
                cdsItensPedido.IndexFieldNames := 'AUTOINCREM';
                cdsItensMultiLojas.IndexFieldNames := 'AUTOINCREM';
              End;
            End
            Else
            Begin
              If recOpcGir.intOrdem = 0 Then
              Begin
                cdsItensPedido.IndexFieldNames := 'ITE_DESITE';
                cdsItensMultiLojas.IndexFieldNames := 'ITE_DESITE';
              End
              Else
              Begin
                cdsItensPedido.IndexFieldNames := 'ITE_DESMAR;ITE_DESITE';
                cdsItensMultiLojas.IndexFieldNames := 'ITE_DESMAR;ITE_DESITE';
              End;
            End;

            cdsItensMultiLojas.AggregatesActive := True;

            qryCadEmp := fCriaQuery(Self);

            pAbreEmpresas(qryCadEmp, recOpcGir.strEmpGir);

            strPedOri := '';

            pStepBy;
            pStepBy;

            Application.ProcessMessages;

            While (Not qryCadEmp.Eof) Do
            Begin

              If blnEndLoj Then
              Begin
                strNomEmpLoj := qryCadEmp.FieldByName('NOMENT').AsString;  // Nome p/ Entrega
                strEndEmpLoj := qryCadEmp.FieldByName('ENDENT').AsString;  // Endereço p/ Entrega
                strCidEmpLoj := qryCadEmp.FieldByName('NOMCID').AsString;  // Cidade p/ Entrega
              End Else
              Begin
                strNomEmpLoj := strNomEmp;  // Nome p/ Entrega
                strEndEmpLoj := strEndEmp;  // Endereço p/ Entrega
                strCidEmpLoj := strCidEmp;  // Cidade p/ Entrega
              End;

              frmGravandoConfirmaPedido.lblGravando.Caption := 'Verificando produtos para empresa ' + qryCadEmp.FieldByName('EMP_CODEMP').AsString + '...';
              Application.ProcessMessages;

             // If fTemPedidoEmpresa(cdsItensMultiLojas, qryCadEmp, strItensPed) Then
              If cdsDigMultLoja.cdsTotalEmpresas.FindKey([qryCadEmp.FieldByName('EMP_CODEMP').AsString]) Then
              Begin
                frmGravandoConfirmaPedido.lblGravando.Caption := 'Salvando produtos para empresa ' + qryCadEmp.FieldByName('EMP_CODEMP').AsString + '...';
                Application.ProcessMessages;

                cdsItensMultiLojas.Filtered := False;
                cdsItensMultiLojas.Filter   := 'ITE_CODEMP = ' + QuotedStr(qryCadEmp.FieldByName('EMP_CODEMP').AsString) +
                                                 ' AND ITE_QTDITE > 0  AND ITE_CODITE IN (' + strItensPed + ') ';
                cdsItensMultiLojas.Filtered := True;
                cdsItensMultiLojas.First;

                pgbStatus.Position := 0;
                pgbStatus.Properties.Max := cdsItensMultiLojas.RecordCount;
                Application.ProcessMessages;

                If fEmptyStr(strPedOri) And (Not fEmptyStr(edtNumPed.Text)) Then
                Begin
                  strPedOri := edtNumPed.Text;
                  strNumPed := edtNumPed.Text;

                  objRequisicao.fAtualizarVinculoRequisicoes((recOpcGir.strPedMlj = 'S'), recOpcGir.strValKey, True);

                  pApagaPcdDet(strNumPed, strCodEmp, strEspOri);
                  pDeletaPcmDet(strNumPed, strEspOri, strCodEmp);
                  pDeletaPedOrcCompra(strNumPed, strCodEmp, strEspOri, blnGerouApenasTransferencia, blnTransforma, intQtdItensMutiLj, strFinPed);
                  If blnNovoReg And (strEspDoc = 'PD') Then
                  Begin
                    strNumPed := fSeqPedidoCompra;
                    strPedOri := strNumPed;
                  End;
                End
                Else
                Begin

                  If (strEspDoc = 'OR') Then
                    strNumPed := fSeqOrcamento
                  Else
                    strNumPed := fSeqPedidoCompra;

                  If fEmptyStr(strPedOri) Then
                    strPedOri := strNumPed;

                End;

                If (Not fEmptyStr(strPedGer)) Then
                  strPedGer := strPedGer + ' - ';

                strPedGer := strPedGer + strNumPed;

                strPedidosCompraGerados := strPedidosCompraGerados +  IIf(strPedidosCompraGerados = '' , '', '|') + strNumPed+';'+strCodEmp;

                With recOpcGir, recNivEst Do
                pGravaPcmGer(objCopiaSeg.recPcmger.blnSomaDescontoAdcionalFornecedor1,
                             Nil,
                             objDuplicatasPedido,
                             strNumPed,
                             strCodEmp,
                             strEspDoc,
                             edtCodFor.Text,
                             strCodTra,
                             strCodTraRedespacho,
                             mskCndPag.Text,
                             dtaDtaPed,
                             horHorPed,
                             StrToDateDef(mskDtaPed.Text, VS_Date),
                             fTrataCodCmp,
                             cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTIPI').AsFloat,
                             cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTSUB').AsFloat,
                             cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTDAR').AsFloat,
                             cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_SUBFCP').AsFloat,
                             cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTITE').AsFloat,
                             cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTGER').AsFloat +  cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALFRE').AsFloat + cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_DESACE').AsFloat,
                             strObs001,
                             strObs002,
                             strObs003,
                             strObs004,
                             strObs005,
                             strObsPd1,
                             strObsPd2,
                             strObsPd3,
                             strPedVen,
                             strAtenca,
                             strTipFre,
                             strTipFreRedespacho,
                             strPedOri + 'PD' + strCodEmp,
                             0,
                             IIF(chkPedImp.Checked, 'S', 'N'),
                             IIF(chkPedInt.Checked, 'S', 'N'),
                             cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString,
                             fStrToFloat(edtDesAdi.Text),
                             'N',
                             cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALFRE').AsFloat,
                             cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_DESACE').AsFloat,
                             StrToDateDef(mskDtaFat.Text, VS_Date), // Data de Faturamento
                             strCodEve,                   // Código do Evento
                             strCodCta,                   // Centro de Custo
                             strNomEmpLoj,                // Nome p/ Entrega
                             strEndEmpLoj,                // Endereço p/ Entrega
                             strCidEmpLoj,                // Cidade p/ Entrega
                             strNiveis,                   // Nivel de Giro Selecionado A_B_C_
                             nivEstoque,                  // Usa Nivel de Giro
                             intDiaComGer,                // Dias Compra Geral
                             intDiaComNvA,                // Dias Compra Nivel A
                             intDiaComNvB,                // Dias Compra Nivel B
                             intDiaComNvC,                // Dias Compra Nivel C
                             cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_BASCOF').AsFloat,
                             cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALCOF').AsFloat,
                             cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_BASPIS').AsFloat,
                             cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALPIS').AsFloat,
                             cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_BASICM').AsFloat,
                             cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALICM').AsFloat,
                             cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_BASIPI').AsFloat,
                             cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_BASSUB').AsFloat,
                             IIF(chkPgAVis.Checked, 'S', 'N'),
                             '',                          // Número da cotação
                             '',                          // Empresa da cotação
                             IIF(chkPedBon.Checked, 'S', 'N'),
                             IIF(chkZeraST.Checked, 'S', 'N'),
                             'P',                         // Descrição do item no pedido de importação
                             intMesGir,
                             IIF(blnConsMesAtu, 'S', 'N'),
                             strOrcOri,                              // Número do orçamento que originou o pedido
                             fltValTax,
                             fltValMar,
                             cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_DESPIS').AsFloat,
                             recOpcGir.strValKey,
                             IIF(blnUsaGiro, 'S', 'N'),
                             False,
                             strCodDig,
                             strNumPok,
                             IIF(chkPreDol.Checked, INT_MOEDA_DOLAR, INT_MOEDA_REAL),
                             'N', // strPreOrc: String = 'N'
                             objCopiaSeg.recPcmger.strBStFre,
                             objCopiaSeg.recPcmger.strBStAce,
                             strOrdemCompra,
                             fRetornaTipoCodigoFabricaProduto, //Código de fábrica do produto;
                             strObsPd4,
                             strObsPd5,
                             strObsPd6,
                             'N',
                             False,
                             strObs006,                               // Observação 6 (Orçamento)
                             cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALCBS').AsFloat,
                             cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALIBS').AsFloat,
                             cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VAL_IS').AsFloat);

                If recOpcGir.strPedMlj = 'S' Then
                Begin
                  frmSelPedidoCompraImpressao.strFornecedor := edtCodFor.Text;
                  frmSelPedidoCompraImpressao.fInserirPedidoGerado(qryCadEmp.FieldByName('EMP_CODEMP').AsString , strNumPed);
                End;

                If (Not fEmptyStr(recOpcGir.strValKey)) Then
                  stlAutIncrem.Add(recOpcGir.strValKey);

                If Assigned(recOpcGir.objSalInt) And (Not fEmptyStr(recOpcGir.strValKey)) And recOpcGir.objSalInt.blnEncontrouGiro Then
                Begin
                  If Not recOpcGir.objSalInt.fSalvaDadosDesmembrado(recOpcGir.strValKey, 'frmDigGiroEstoque', cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString) Then
                    Raise Exception.Create('Erro ao gravar filtros do giro de estoque!');
                End;

                //Mensagem de Liberação de Pedido de Compra
                If blnLibPcm Then
                  pMensagemPedidoCompraLiberar(strCodEmp,                                                              //Empresa
                                               strNumPed,                                                              //Pedido
                                               strEspDoc,                                                              //Espécie
                                               edtCodFor.Text,                                                         //Fornecedor
                                               dtaDtaPed,                                                              //Data do Pedido
                                               StrToDateDef(mskDtaPed.Text, VS_Date),                                  //Data de Entrega
                                               cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTGER').AsFloat +
                                                  cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALFRE').AsFloat +
                                                  cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_DESACE').AsFloat, // Total de Itens+IPI+SUB = TOTGER
                                               True);

                cdsItensMultiLojas.First;

                strAutIncPcmDet :=  fRetAutoIncrem('PCMDET', VS_strCodEmp, cdsItensMultiLojas.RecordCount);
                strAutIncPcmDetBkp := strAutIncPcmDet;

                While (Not cdsItensMultiLojas.Eof) Do
                Begin
                  If Assigned(TValidadorPedidoCompra.ValidadorPedidoCompra) then
                   TValidadorPedidoCompra.ValidadorPedidoCompra.pAddGeracaoItemMultiloja(cdsItensMultiLojas.FieldByName('ITE_CODITE').AsString,
                                                                                       cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString,
                                                                                       cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat);

                  SQL.Add(fGravaPcmDet(intQtdConCol,
                               qryColeta,
                               blnUsaColeta And (strEspDoc = 'PD'),
                               cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString,
                               strCampoSaldoSub,
                               strCampoSaldoAdd,
                               intDecTpc,
                               strNumPed,
                               strCodEmp,
                               strEspDoc,
                               edtCodFor.Text,
                               cdsItensMultiLojas.FieldByName('ITE_CODITE').AsString,

                               IIF(fEmptyStr(cdsItensMultiLojas.FieldByName('ITE_CODUNI').AsString),
                                      fRetUnidadeItem(cdsItensMultiLojas.FieldByName('ITE_CODITE').AsString),
                                   cdsItensMultiLojas.FieldByName('ITE_CODUNI').AsString),

                               IfThen(mskDtaEnt.Visible, cdsItensMultiLojas.FieldByName('ITE_DTAENT').AsDateTime, strToDateDef(mskDtaPed.Text, VS_Date)),

                               horHorPed,
                               dtaDtaPed,
                               mskCndPag.Text,
                               cdsItensMultiLojas.FieldByName('ITE_DESITE').AsString,
                               cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_UNITAR').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_DESUNI').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_DESUN2').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_DESUN3').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_DESUN4').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_DESUN5').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_DESUN6').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_TOTITE').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_PERIPI').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_TOTIPI').AsFloat,

                               cdsItensMultiLojas.FieldByName('ITE_PERSUB').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_TOTSUB').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_TOTDAR').AsFloat,

                               cdsItensMultiLojas.FieldByName('ITE_PERFCP').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_SUBFCP').AsFloat,

                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,                                                    // fltFreBai
                               0,                                                    // fltAceBai
                               cdsItensMultiLojas.FieldByName('ITE_VALFRE').AsFloat, // fltValFre
                               cdsItensMultiLojas.FieldByName('ITE_DESACE').AsFloat, // fltDesAce
                               0,
                               strPedOri + 'PD' + strCodEmp,
                               0,
                               IIF(chkPedImp.Checked, 'S', 'N'),
                               IIF(chkPedInt.Checked, 'S', 'N'),
                               '',
                               cdsItensMultiLojas.FieldByName('ITE_QTDINC').AsFloat,       // Proveninete de Importação?
                               cdsItensMultiLojas.FieldByName('ITE_TRAINC').AsFloat,       // Proveninete de Importação?

                               strAutIncPcmDet,
                               '',
                               '',
                               'N',
                               0,
                               cdsItensMultiLojas.FieldByName('ITE_BASSUB').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_BASIPI').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_BASICM').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_PERBAS').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_ALQICM').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_VALICM').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_INCPIS').AsString = 'S',
                               cdsItensMultiLojas.FieldByName('ITE_INCIRQ').AsString,
                               cdsItensMultiLojas.FieldByName('ITE_ALQPIS').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_ALQCOF').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_ALQIMP').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_VALIMP').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_VALSIS').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_VALMAR').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_SEQFDO').AsString,
                               cdsItensMultiLojas.FieldByName('ITE_QTDEMB').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_ALQPIS').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_ALQCOF').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_SUBUSU').AsString,
                               cdsItensMultiLojas.FieldByName('ITE_DESPIS').AsFloat,
                               False,
                               '',
                               True,
                               '',
                               False,
                               -1,
                               cdsItensMultiLojas.FieldByName('ITE_DTAEDT').AsDateTime,
                               0,                                       // fltUniLiq
                               cdsItensMultiLojas.FieldByName('ITE_ALQCBS').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_ALQIBS').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_ALQ_IS').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_VALCBS').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_VALIBS').AsFloat,
                               cdsItensMultiLojas.FieldByName('ITE_VAL_IS').AsFloat));

                  pIncrementaAutoIncrem(strAutIncPcmDetBkp);
                  strAutIncPcmDet := strAutIncPcmDetBkp;

                  SQL.Text := TMontaSQLPedidoCompra.fAjustaAutoIncControleDeColeta(intQtdConCol, SQL.Text);

                  If (cdsItensMultiLojas.RecNo mod 500) = 0 Then
                  Begin
                    fExecutaScript(SQL.Text, qryGravacao, False);
                    qryGravacao.SQL.Clear;
                    SQL.Clear;
                  End;

                  blnGerouPedido := True;

                  cdsItensMultiLojas.Next;

                  pStepBy;
                  Application.ProcessMessages;
                End; {While (Not cdsItensMultiLojas.Eof) Do}

                If SQL.Count > 0 Then
                Begin
                  fExecutaScript(SQL.Text, qryGravacao, False);
                  qryGravacao.SQL.Clear;
                  SQL.Clear;
                End;

                ProcessaStatusPedidoRequisicaoPedidoCompra(recOpcGir.strValKey);

                If fltValFreGer + fltDesAceGer > 0 Then
                  pAtualizaTotaisPedido(recOpcGir.strValKey,
                                        cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALFRE').AsFloat,
                                        cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_DESACE').AsFloat,
                                        cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTSUB').AsFloat,
                                        cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_SUBFCP').AsFloat,
                                        cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTITE').AsFloat,
                                        cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTIPI').AsFloat,
                                        cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALICM').AsFloat,
                                        True,
                                        cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALCBS').AsFloat,
                                        cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALIBS').AsFloat,
                                        cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VAL_IS').AsFloat);

                objDuplicatasPedido.pAtualizaDuplicatasProporcional(recOpcGir.strValKey,
                                                                    mskCndPag.Text,
                                                                    edtCodFor.Text,
                                 cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTGER').AsFloat +
                                 cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALFRE').AsFloat +
                                 cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_DESACE').AsFloat,
                                 cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTITE').AsFloat -
                                 IIF(blnZonaFranca, cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALICM').AsFloat, 0),
                                 dtaDtaPed);

              End; {If fTemPedidoEmpresa(cdsItensMultiLojas, qryCadEmp, strItensPed) Then}

              qryCadEmp.Next;
            End;

            FreeAndNil(qryCadEmp);
          End;
          {$ENDREGION}
          If (Not blnNovoReg) And (Not blnModoHeranca) Then
            pRegravaItensBaixados;

          pGeraLogLiberacao(strNumPed, strEspDoc, strCodEmp);

          Result := Result And objRequisicao.fAtualizarVinculoRequisicoes((recOpcGir.strPedMlj = 'S'), recOpcGir.strValKey);
        End; {If Not blnFazerApenasTransferencias Then}
        {$endregion}

        If Result Then
        Begin
          objRequisicao.pAssociaPedidoCompraRequisicoes;

          If blnTransforma Then
          Begin
            If (Not blnGerouPedido) And (Not blnGerouApenasTransferencia) Then
              Raise exception.create('Falha ao gerar pedido!');
            //Quando desmembra o ja chamou a pDeletaPedOrcCompra, feito esse if para não deletar novamente;
            If Not fEmptyStr(fCampoTabela('AUTOINCREM', 'PCMGER', ['PCG_NUMPED', 'PCG_CODEMP', 'PCG_ESPDOC'],
                                                 [edtNumPed.Text, strCodEmp, 'OR'])) Then
              pDeletaPedOrcCompra(edtNumPed.Text, strCodEmp, 'OR', blnGerouApenasTransferencia, blnTransforma, intQtdItensMutiLj, strFinPed);
            edtNumPed.Clear;
          End;


          objCopiaSeg.pApagaCopiaSeguranca;

          {Gera histórico ocorrência caso o pedido
           tenha atendido alguma requisição de compra}
          If (VS_strHabilitarCRM) Then
          Begin
            TUpdateOccurrenceCRM.New()
              .NumDoc(strNumPed)
              .EspDoc(strEspDoc)
              .CodEmp(strCodEmp)
              .AcaFat(afcCompraEfetuada)
              .strNomFrm('[TPreNota.fConfirma]')
              .pRun();

            If Not blnNovoReg Then
              objRequisicao.pGeraOcorrenciasDesvinculo;
          End;

        End;

        If Not blnNovoReg Then
          Result := Result And
                    objRequisicao.fNegaRequisicoesMotivoNaoVaiComprar(objRequisicao.cdsRequisicao, False) And
                    objRequisicao.fNegaRequisicoesMotivoPossuiEstoque(objRequisicao.cdsRequisicao, False);

        If Assigned(cdsDigMultLoja) And Assigned(cdsDigMultLoja.objPreparaGerMultiLoja) Then
          Result := Result And cdsDigMultLoja.objPreparaGerMultiLoja.fSalvaDigitados(False);

        If Not fValidaConsistenciaPedido(strNumPed, strCodEmp, strEspDoc) Then
        Begin
          Result := False;
          Raise Exception.Create('Dados inconsistentes ao gerar pedido, abortando gravação!');
        End;

        {Validação para saber ser gravou a quantidade de (PCCDET.QTDITE > 0)  igual a PCMDET ao Transformar o Orçamento em Pedido}
        If (blnTransforma) And (Not fValidaQtdPCDDETcomPCMDET(strMsgErro)) Then
        Begin
          Result := False;
          Raise Exception.Create(strMsgErro + ' Dados inconsistentes ao gerar pedido, abortando gravação! [fValidaQtdPCDDETcomPCMDET]' );
        End;
        If strFinPed = 'S' then
        Begin
          If Assigned(TValidadorPedidoCompra.ValidadorPedidoCompra) then
          begin
            strLogErro := TStringList.Create;
            Try
              If (blnTransforma) and (Not TValidadorPedidoCompra.ValidadorPedidoCompra.fValidaQuantidadeGerada(strLogErro)) Then
              Begin
                fRollBack;
                TfrmLog.pShowLog('Falhas encontradas', strLogErro);
                TValidadorPedidoCompra.ValidadorPedidoCompra.pGravaLog(tlvpdcDivergenciaGeracao);
                edtNumPed.Text := strPedOri;
                raise Exception.Create(cFalhaDistribuicaoMltLoja);

              End;
            finally
              FreeAndNil(strLogErro);
            End;
          End;
        End;

         //log alteração data
        If Result Then
        Begin
          If (TRecuperaExcluidos.fPcmDetFicouVazio(strNumPed, strEspDoc, strCodEmp)) Then
          begin
            Result := False;
            raise Exception.Create('Neste processo o pedido de compra, ficou sem itens. O processo será cancelado!');
          End;
          fCommit;

          blnApagaOnClose:= Result;

          objCopiaSeg.pLimpaDados;
        End
        Else
          fRollBack;

        TTestabilidade.fGetTestabilidade.NumeroDocumento  := strNumPed;
        TTestabilidade.fGetTestabilidade.EspecieDocumento := strEspDoc;
        TTestabilidade.fGetTestabilidade.EmpresaDocumento := strCodEmp;

        pStepBy;
        Application.ProcessMessages;

      Except
        On E: Exception Do
        Begin
          blnApagaOnClose := False;

          If (E.Message <> cItensDuplicados) and  (E.Message <> cFalhaDistribuicaoMltLoja) Then
            fRollBack;
          If Assigned(cdsDigMultLoja) Then
             cdsDigMultLoja.vinculaCDS;
          If (E.Message <> cItensDuplicados) and  (E.Message <> cFalhaDistribuicaoMltLoja) Then
            pMensagensErro(E.Message, '[fConfirmaPedido]');
          Result := False;


        End;
      End;

    End;

  Finally
    If Assigned(cdsItensMultiLojas) Then
      cdsItensMultiLojas.AfterPost := afsAfterPostMult;

    FreeAndNil(qryGravacao);
    FreeAndNil(SQL);
  End;

  pnlInfo.Caption := '';
  Screen.Cursor := crDefault;
  cxgItens.Enabled := True;
  Self.Enabled := True;

  cdsItensPedido.Filtered := False;

  If Assigned(cdsItensMultiLojas) Then
    cdsItensMultiLojas.IndexFieldNames := 'ITE_CODITE;ITE_CODEMP';

  If Not blnUsarGiro Then
  Begin
    If fCfgSis('INCPED') = '1' Then
      cdsItensPedido.IndexFieldNames := 'ITE_DESITE'
    Else
      cdsItensPedido.IndexFieldNames := 'AUTOINCREM';
  End
  Else
  Begin
    If recOpcGir.intOrdem = 0 Then
      cdsItensPedido.IndexFieldNames := 'ITE_DESITE'
    Else
      cdsItensPedido.IndexFieldNames := 'ITE_DESMAR;ITE_DESITE';
  End;

  cdsItensPedido.EnableControls;
  pAferScroll(cdsItensPedido);
end;

Procedure TfrmPedidoDeCompra.pSalvaConfiguracoesGrid;
  Var
    qryCfgPdc: TUniQuery;
    strArqTemp: String;
    intPos: Integer;
Begin
  Try
    intPos := 1;

  qryCfgPdc := fCriaQuery;

  With qryCfgPdc, SQL Do
  Begin
    Clear;
    Add('SELECT * FROM CFGPCM');
    Add('WHERE CFG_CODOPE = :CODOPE');
    Add('  AND IFNULL(CFG_NOMGRI, "") =  "" ');

      intPos := 2;

    ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

      intPos := 3;

    Open;

    If IsEmpty Then
    Begin
        intPos := 4;

      qryCfgPdc.Insert;
      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CFGPCM', VS_strCodEmp);
    End Else
    Begin
        intPos := 5;

      Edit;
    End;

      intPos := 6;

      strArqTemp := TCdsDigMultLoja.fCriarArquivoTemporario('', TCdsDigMultLoja.fGetPathTempOpcoesLocais);

      intPos := 7;

      cxvItens.StoreToIniFile(strArqTemp, True, [gsoUseFilter, gsoUseSummary]);

      intPos := 8;

    FieldByName('CFG_CFGGRI').AsString := TCdsDigMultLoja.fArquivoParaString(strArqTemp);

      intPos := 9;

    FieldByName('CFG_CODOPE').AsString := strLoginUsuarioLogado;

      intPos := 10;

    Post;

      intPos := 11;

    DeleteFile(PChar(strArqTemp));

  End;

    intPos := 12;
  FreeAndNil(qryCfgPdc);

  Except
    On E: Exception Do
    Begin
     // pMensagensErro(E.Message, '[TfrmPedidoDeCompra.pSalvaConfiguracoesGrid]');
      pGravarErro(True,
                  '[fValidarConfiguracaoPath] - ' + E.Message,
                  'Linha ' + intPos.ToString + #13#10 +
                  GetComputerNetName + #13#10 + fRetornaStack);
End;
  End;
End;

Procedure TfrmPedidoDeCompra.pCarregaConfiguracoesGrid;
  Var
    qryCfgPdc: TUniQuery;
    strArqTemp: String;
Begin
  qryCfgPdc := fCriaQuery;

  With qryCfgPdc, SQL Do
  Begin
    Clear;
    Add('SELECT * FROM CFGPCM');
    Add('WHERE CFG_CODOPE = :CODOPE');
    Add('  AND IFNULL(CFG_NOMGRI, "") =  "" ');

    ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

    Open;

    If Not IsEmpty Then
    Begin
      strArqTemp := TCdsDigMultLoja.fCriarArquivoTemporario('', TCdsDigMultLoja.fGetPathTempOpcoesLocais);

      If TCdsDigMultLoja.fEscreverNoArquivo(strArqTemp, FieldByName('CFG_CFGGRI').AsString) Then
      Begin
        cxvItens.RestoreFromIniFile(strArqTemp);
        DeleteFile(PChar(strArqTemp));
      End;

    End;

  End;

  pHabilitaDataPorItem;

  FreeAndNil(qryCfgPdc);

  cxvItensVALICM.Visible := blnZonaFranca;

  // A configuracao restaurada do grid nao pode reexibir as colunas com a regra desligada
  pAjustaCamposReforma;
End;

procedure TfrmPedidoDeCompra.pFiltraQuantidadeZero(blnFiltra: Boolean);
begin
  cdsItensPedido.Filtered := False;
  cdsItensPedido.Filter   := IIF(blnFiltra, 'ITE_QTDITE > 0', '');
  cdsItensPedido.Filtered := blnFiltra;
end;

procedure TfrmPedidoDeCompra.btnLitragemClick(Sender: TObject);
begin
  inherited;

  If InterlockedIncrement(intConfirma) = 0 Then
  Begin

    Try
      If (btnLitragem.Visible) And (Not cdsItensPedido.IsEmpty) Then
      Begin
        pMostraLitragemGrupo;
        pSetFocus(ActiveControl);
      End;

      InterlockedDecrement(intConfirma);
    Except
      InterlockedDecrement(intConfirma);
    End;

  End
  Else
    InterlockedDecrement(intConfirma);

end;

procedure TfrmPedidoDeCompra.btnLitragemPorUnidadeClick(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crHourGlass;
  pnlInfo.Caption := 'Aguarde, calculando litros/kilos por Unidade...';
  cdsItensPedido.AfterScroll := Nil;
  pnlInfo.Caption := '';
  Screen.Cursor := crDefault;
  pCriarFormularios(TfrmMostrarTotalPorUnidade, frmMostrarTotalPorUnidade);
  Try
    Try
      frmMostrarTotalPorUnidade.cdsItensPedido := cdsItensPedido;
      frmMostrarTotalPorUnidade.showModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmMostrarTotalPorUnidade.pMostraLitragemGrupo]');
      End;
    End;
  Finally
    pFreeAndNil(frmMostrarTotalPorUnidade);
    Screen.Cursor := crDefault;
    pAferScroll(cdsItensPedido);
  End;
end;

procedure TfrmPedidoDeCompra.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key <> 37 Then
    wrdLastKey := Key;

  blnShift := ssShift	in Shift;

  If Not Self.Enabled Then
    Exit;

  Case Key Of
    80 {P} : If ssCtrl In Shift Then
               mnuCadastrodeProdutos.Click;

    68 {D} : If ssCtrl In Shift Then
               mnuPreparaesdeTEdoPedido.Click;

    70 {F} : If ssCtrl In Shift Then
               mnuEntregasFuturasPendentes.Click;

    Ord('L'): If ssCtrl In Shift Then
               Lotesdoitem1.Click;

    VK_INSERT: If (edtCodFor.Focused) And fVerificaAcessoSistema('frmCadFornecedores') Then
               Begin
                 edtCodFor.Text := fChamaCadFor(Key, edtCodFor.Text);
                 key := 0;
               End;
  End;

  If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
    key := 0;
  End;

  Case Key Of
    VK_F2: Begin

             If (ssAlt in Shift) Then
               btnResumoLoja.Click
             Else
               pMostraGiroAnalitico;

             Key := 0;
           End;

    VK_F3: Begin
             If (ssCtrl in Shift) Then
               btnMaisInf.Click

             Else If (ssAlt	in Shift) Then
               btnAltTabPre.Click
             Else
               mnuFormacaodePrecos.Click;

             Key := 0;
           End;

    VK_F4: Begin

             If (ssCtrl in Shift) Then
               btnTrocaPedido.Click
             Else
               btnGarantiaPend.Click;

             Key := 0;

           End;

    VK_F5: Begin
             If (ssAlt	in Shift) Then
               btnLitragemPorUnidade.Click
             Else
               btnLitragem.Click;

             Key := 0;
           End;

    VK_F6: begin
             If ssAlt in Shift Then
             Begin
               mnuConsultadePedidodeCompras.Click;
               key := 0;
             End
             Else If Not (ssShift In Shift) Then
             Begin
               btnEstoque.Click;
               key := 0;
             End;

           End;

    VK_F7: Begin
             If (ssAlt	in Shift) Then
               btnEmbalagem.Click
             Else
              btnPedidosPend.Click;

              key := 0;
            End;

    VK_F8: Begin
             If ssCtrl In Shift Then
             Begin
               btnTranEst.Click;
               key := 0;
             End
             Else If (ssAlt In Shift) Then
             Begin
               ComposicaodeCustoClick(Nil);
               key := 0;
             End Else
             Begin
               btnEditarItem.Click;
               key := 0;
             End;

           End;

   VK_F9:  Begin
             If ssAlt In Shift Then
               btnCotAbe.Click
             Else If ssCtrl In Shift Then
               btnSimGir.Click
             Else
               btnSimilares.Click;

            key := 0;
           End;

   VK_F11: Begin
             If (ssAlt in Shift)  Then
               btnDocSalRes.Click
             Else
                mnuPedidodeComprasGrid.Click;

             key := 0;
           End;

   VK_F12: Begin
             If (ssAlt in Shift) Then
               btnInfPedidoDeVendas.Click
             Else
               btnImporta.Click;

             key := 0;
           End;
  End;

  If fCheckParent(ActiveControl, cxgItens) Then
  Begin
    Case Key Of
      VK_Escape: Begin
                  pSetFocus(edtCodIte);
                  pLimpaDadosItem;
                  pCalculaTotalItem(True);
                  blnMudarFoco := True;
                End;

      VK_Return: If (Not blnAdicionandoItem) And
                    (Not blnAtivandoItem) And
                    (cdsItensPedido.State <> dsEdit) Then
                  Begin
                    pAtivaItem;
                  End;

      VK_Delete: btnApaga.Click;
    End;
  End;

  //Alt + "C"
  If (key = 67) and (ssCtrl	in Shift) Then
  Begin
    mnuCompraAntigaClick(Sender);
    key := 0;
  End;

end;

procedure TfrmPedidoDeCompra.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If blnAtualizarRodape Then
    tmrAtualizaRodape.Enabled := True;

end;

procedure TfrmPedidoDeCompra.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
    bkmRegistro: TBookmark;
    stlCamposIte,
    stlCamIndIte,
    stlDesIndIte: TStringList;
    intContador: Integer;
    objfrmPnl: TPanelCxItem;
begin
  inherited;

  If fEntraCons(Key) And (Not fEstaNaConsultaTab) Then
  Begin

    If ((Not blnUsarGiro) And (Not blnAltPedGir)) Or blnShift Then
    Begin
      Try
        objfrmPnl := TPanelCxItem.New();

        objFrmPnl.strNomForm := Self.Name;
        objFrmPnl.recParametros.strCodCli  := '';
        objFrmPnl.strCodVen  := '';
        objFrmPnl.strCodDig  := '';
        objFrmPnl.intPraMedio:= 0;
        objFrmPnl.recParametros.strTabPre  := '1';
        objFrmPnl.blnExibirVrUnitarioPedCompraGrid := True;

        objFrmPnl.sltLista    := sltItems;
        objFrmPnl.fncTeclaTab := fCompraItem;


        If fPesqItem(conIteCompleta,
                     Self,
                     edtCodIte,
                     edtDesIte,
                     qryIteCon,
                     Key,
                     arrSel,
                     True,
                     objfrmPnl,
                     'Consulta de Itens - Pedido de Compra',
                     '1',
                     '',
                     0,
                     False,
                     False,
                     0,
                     cdrCodIte,
                     '',
                     True,
                     '',
                     '',
                     True,
                     False,
                     True,
                     IIF(fVerificaAcessoSistema('GRUCOM', fRetComprador), '', fTrataCodCmp)) Then
        Begin

          If rdbCodIte.Checked Then
            edtCodIte.Text := qryIteCon.FieldByName('ITE_CODITE').AsString
          Else
            edtCodIte.Text := qryIteCon.FieldByName('ITE_CODFAB').AsString;

          If (fValidaCampos(edtCodIte, True)) Then
          Begin
            pSetFocus(edtCodIte);
            SelectNext(ActiveControl, True, True);
          End;
          blnMudarFoco := True;

        End;

        Key := #0;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[frmPedidoDeCompra.edtCodIteKeyPress]');
        End;
      End;


      Key := #0;
    End
    Else
    Begin
      stlCamposIte := TStringList.Create;
      stlCamIndIte := TStringList.Create;
      stlDesIndIte := TStringList.Create;

      Key := #0;

      stlCamposIte.Add('ITE_DESITE');
      stlCamposIte.Add('ITE_REFERE');
      stlCamposIte.Add('ITE_CODITE');
      stlCamposIte.Add('ITE_REFERE');
      stlCamposIte.Add('ITE_CODGRU');
      stlCamposIte.Add('ITE_LOCFIS');
      stlCamposIte.Add('ITE_DESMAR');
      stlCamposIte.Add('ITE_DESITE');
      stlCamposIte.Add('ITE_CODFAB');
      stlCamposIte.Add('ITE_DESFAB');

      For intContador := 1 To recOpcGir.intMesGir Do
      Begin
        stlCamposIte.Add('ITE_Q_V_' + fStrZero(IntToStr(intContador), 2));
        stlCamposIte.Add('ITE_Q_VP' + fStrZero(IntToStr(intContador), 2));
        stlCamposIte.Add('ITE_DESM' + fStrZero(IntToStr(intContador), 2));
      End;

      stlCamposIte.Add('ITE_MLTCOM');
      stlCamposIte.Add('ITE_SUGEST');
      stlCamposIte.Add('ITE_SALFIS');
      stlCamposIte.Add('ITE_QTDPEN');
      stlCamposIte.Add('ITE_SALREQ');
      stlCamposIte.Add('ITE_PRECUS');
      stlCamposIte.Add('ITE_PREVE1');
      stlCamposIte.Add('ITE_PREVE2');
      stlCamposIte.Add('ITE_PREVE3');
      stlCamposIte.Add('ITE_PREVE4');
      stlCamposIte.Add('ITE_PREVE5');
      stlCamposIte.Add('ITE_PREVE6');
      stlCamposIte.Add('ITE_PREVE7');
      stlCamposIte.Add('ITE_MARBR1');
      stlCamposIte.Add('ITE_MARBR2');
      stlCamposIte.Add('ITE_MARBR3');
      stlCamposIte.Add('ITE_MARBR4');
      stlCamposIte.Add('ITE_MARBR5');
      stlCamposIte.Add('ITE_MARBR6');
      stlCamposIte.Add('ITE_MARBR7');
      stlCamposIte.Add('ITE_VENMES');
      stlCamposIte.Add('ITE_Q_VPME');
      stlCamposIte.Add('ITE_LITROS');
      stlCamposIte.Add('ITE_PESOIT');
      stlCamposIte.Add('TAB');


      stlCamIndIte.Add('ITE_DESITE+ITE_REFERE');
      stlCamIndIte.Add('ITE_CODITE');
      stlCamIndIte.Add('ITE_REFERE');
      stlCamIndIte.Add('ITE_CODGRU');
      stlCamIndIte.Add('ITE_DESMAR+ITE_DESITE');
      stlCamIndIte.Add('ITE_CODFAB');
      stlCamIndIte.Add('ITE_DESFAB');
      stlCamIndIte.Add('ITE_LOCFIS');


      {*****************************************}
      {* CHAMA A TELA DE CONSULTA ESPECÍFICA   *}
      {* PARA A CONSULTA COM GIRO              *}
      {**************************************MV*}

      Try
        pCriarFormularios(TfrmConsultaItensGiro, frmConsultaItensGiro);
        frmConsultaItensGiro.intQtdMes := recOpcGir.intMesGir;
        frmConsultaItensGiro.dtaDataBaseGir := recOpcGir.dtaDataBaseGir;
        frmConsultaItensGiro.blnConsMesAtu := recOpcGir.blnConsMesAtu;
        frmConsultaItensGiro.sltItems := sltItems;
        bkmRegistro := fConsultaClientDataSet(Self,
                                              cdsItensGiro,
                                              'TMP_CONSULTA',
                                              stlCamposIte,
                                              stlCamIndIte,
                                              'Consulta de Itens com Giro',
                                              frmConsultaItensGiro);
        If Assigned(bkmRegistro) Then
        Begin
          cdsItensGiro.GotoBookmark(bkmRegistro);
          edtCodIte.Text := cdsItensGiro.FieldByName('ITE_CODITE').AsString;
          If (fValidaCampos(edtCodIte, True)) Then
            SelectNext(ActiveControl, True, True);
        End;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[frmPedidoDeCompra.edtCodIteKeyPress]');
        End;
      End;

      pFreeAndNil(frmConsultaItensGiro);
      cdsItensGiro.AfterScroll := Nil;

      FreeAndNil(stlCamposIte);
      FreeAndNil(stlCamIndIte);
      FreeAndNil(stlDesIndIte);
    End;

  End;
end;

procedure TfrmPedidoDeCompra.edtCodIteKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If fIsInsert(Key) Then
  Begin
    edtCodIte.Text := fChamaCadIte(Key);
  End;

end;

procedure TfrmPedidoDeCompra.edtCodUniExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodUni,edtSigUni, arrUnidade,Nil, fRetSiglaUni, 'da unidade');

end;

procedure TfrmPedidoDeCompra.edtCodUniKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If edtCodUni.ReadOnly Then
    Exit;

  If fPesqUnidade(Self, edtCodUni, nil, nil, nil, Key, arrUnidade) Then
  Begin
    If fValidaCampos(edtCodUni, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmPedidoDeCompra.fRetSugestao(strCodIte: String): Double;
begin

  cdsItensGiro.Filter := 'ITE_CODITE = ' + QuotedStr(strCodIte);
  cdsItensGiro.Filtered := False;
  cdsItensGiro.Filtered := True;

  Result := 0;
  While (Not cdsItensGiro.Eof) Do
  Begin
    Result := Result + cdsItensGiro.FieldByName('ITE_QTDITE').AsFloat;
    cdsItensGiro.Next;
  End;

  cdsItensGiro.Filtered := False;
  cdsItensGiro.Filter   := '';
end;

procedure TfrmPedidoDeCompra.btnMaisInfClick(Sender: TObject);
begin
  inherited;
  popMaisInfo.Popup(Self.Left + btnMaisInf.Left, Self.Top + pnlBotoes.Top);
End;

procedure TfrmPedidoDeCompra.btnTodIteClick(Sender: TObject);
  Var
    Key: Char;
begin
  inherited;

  blnShift := TRUE;
  Key := '?';
  edtCodIteKeyPress(edtCodIte,Key);

end;

procedure TfrmPedidoDeCompra.btnTranEstClick(Sender: TObject);
begin
  inherited;

  If Not cdsItensPedido.IsEmpty Then
  BEGIN

    If Assigned(prcExecutaRelatorio) Then
    begin
      prcExecutaRelatorio(106, 5813, [],
                          ['CODITE'],
                          [cdsItensPedido.FieldByName('ITE_CODITE').AsString],
                          Sender,
                          nil,
                          True);
    End;

  END;

end;

procedure TfrmPedidoDeCompra.btnTrocaPedidoClick(Sender: TObject);
begin
  inherited;

  If cdsItensPedido.IsEmpty Then
    Exit;

  pImportaRequisicoes(cdsItensPedido.FieldByName('ITE_CODITE').AsString);
end;

procedure TfrmPedidoDeCompra.splAplicacaoCanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  inherited;
  Accept := pnlAplicacao.Height > 1;
end;

procedure TfrmPedidoDeCompra.tmrAtualizaRodapeTimer(Sender: TObject);
begin
  inherited;
  If blnGravando Then
  begin
    blnAtualizarRodape := False;
    Exit;
  End;

  If blnAtualizarRodape Then
  Begin
    blnAtualizarRodape := False;
    tmrAtualizaRodape.Enabled := False;
    pAtualizaGridRodape(False, strCodIteProcessadoRodape);
    If strCodIteProcessadoRodape <> cdsItensPedido.FieldByName('ITE_CODITE').AsString then
    Begin
      blnAtualizarRodape := True;
      tmrAtualizaRodape.Enabled := True;
    End
  End;
end;

Function TfrmPedidoDeCompra.fImportaRequisicoes(prgProgresso: TCxProgressBar): Boolean;
  Var
    blnAchouReq: Boolean;
    blnAtendidaPorTransferencia: Boolean;
    blnBckExibirPedidoPendente: Boolean;
    blnBckExecutarDigMultLoja: Boolean;

    sltNaoMultiplos: TStringList;

    prcAfterPost: TprcScroll;

    fltResto,
    fltQtd,
    fltMltCom2: Double;
    strReqAnt: String;

  Function fPodeRequisitarItem: Boolean;
  Begin
    Result := True;

    If (Not cdsItensPedido.IsEmpty) And SameText(cdsItensPedido.FieldByName('ITE_TIPOPE').AsString, STR_TRANSFERIR) Then
    Begin
      Result := False;
      pMensagemOk('O item ' + objRequisicao.cdsRequisicao.FieldByName('CODITE').AsString + ' está marcado para transferência e não será marcado para requisição!');
    End;

  End;

  Procedure pFiltraMultiLoja;
    Var
      strFiltro: String;
  Begin
    strFiltro := 'ITE_CODITE = ' +  QuotedStr(cdsItensPedido.FieldByName('ITE_CODITE').AsString);

    If strFiltro <> cdsItensMultiLojas.Filter Then
      cdsItensMultiLojas.Filter := strFiltro;

    If Not cdsItensMultiLojas.Filtered Then
      cdsItensMultiLojas.Filtered := True;

    cdsDigMultLoja.pVeSeIncluiItemMultiLoja(cdsItensPedido.FieldByName('ITE_CODITE').AsString);
  End;

  Procedure pAdicionarItemMultiLoja;
    Var
      blnAdiciona: Boolean;
      fltMltCom2, fltQtd, fltResto: Double;
  Begin
    blnAdiciona := False;

    pFiltraMultiLoja;

    If cdsItensMultiLojas.Locate('ITE_CODITE;ITE_CODEMP',
                                  VarArrayOf([objRequisicao.cdsRequisicao.FieldByName('CODITE').AsString,
                                              objRequisicao.cdsRequisicao.FieldByName('CODEMP').AsString]), []) Then
      blnAdiciona := True

    Else If (Not fEmptyStr(recOpcGir.strEmpAgr)) And
       cdsItensMultiLojas.Locate('ITE_CODITE;ITE_CODEMP',
                                  VarArrayOf([objRequisicao.cdsRequisicao.FieldByName('CODITE').AsString,
                                              recOpcGir.strEmpAgr]), []) Then
      blnAdiciona := True

    Else If cdsItensMultiLojas.Locate('ITE_CODITE;ITE_CODEMP',
                                  VarArrayOf([objRequisicao.cdsRequisicao.FieldByName('CODITE').AsString,
                                              VS_strCodEmp]), []) Then
      blnAdiciona := True

    Else If Not cdsItensMultiLojas.IsEmpty Then
    Begin
      cdsItensMultiLojas.First;
      blnAdiciona := True
    End;

    If blnAdiciona Then
    Begin
      cdsItensMultiLojas.Edit;
      If blnUsarGiro           And
         recOpcGir.blnImpReq   And
         recOpcGir.blnConsMCom And
         ((strCmpMlt <> 'N') And (strCmpMlt <> 'A'))   Then
        cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat := cdsItensMultiLojas.FieldByName('ITE_SUGESTORI').AsFloat +
                                                                  objRequisicao.cdsRequisicao.FieldByName('QTDITE').AsFloat / cdsItensPedido.FieldByName('ITE_QTDEMB').AsFloat
      Else
        cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat := cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat +
                                                                  objRequisicao.cdsRequisicao.FieldByName('QTDITE').AsFloat / cdsItensPedido.FieldByName('ITE_QTDEMB').AsFloat;

      If (strCmpMlt <> 'N') And (strCmpMlt <> 'A') Then
      Begin
        fltMltCom2 := 0;

        If (cdsItensMultiLojas.FindField('ITE_MLTCOM') <> nil) Then
          fltMltCom2 := cdsItensMultiLojas.FieldByName('ITE_MLTCOM').AsFloat;

        If fltMltCom2 <= 0 Then
          fltMltCom2 := 1;

        fltQtd := Trunc(cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat / fltMltCom2);

        fltResto := RoundTo(cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat - fltQtd * fltMltCom2, -4);

        If fltResto > 0 Then
          cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat := fStrToFloat(FormatFloat(fMskDigitos(intDecTpc), (fltQtd + 1) * fltMltCom2));
      End;
      cdsItensMultiLojas.FieldByName('ITE_UNITAR').AsFloat := cdsItensPedido.FieldByName('ITE_UNITAR').AsFloat;

      pCalculaTotalItemQtdGrid(cdsItensMultiLojas);

      If fEmptyStr(cdsItensMultiLojas.FieldByName('ITE_INCIRQ').AsString) Then
      Begin
        cdsItensMultiLojas.FieldByName('ITE_INCIRQ').AsString := objRequisicao.cdsRequisicao.FieldByName('AUTOINCREM').AsString;
      End

      Else If (Pos(strIncMovRcd, cdsItensMultiLojas.FieldByName('ITE_INCIRQ').AsString) = 0) Then
      Begin
        cdsItensMultiLojas.FieldByName('ITE_INCIRQ').AsString :=
           cdsItensMultiLojas.FieldByName('ITE_INCIRQ').AsString + ',' + objRequisicao.cdsRequisicao.FieldByName('AUTOINCREM').AsString;

      End;

      cdsItensMultiLojas.FieldByName('ITE_QTDREQ').AsFloat  := cdsItensMultiLojas.FieldByName('ITE_QTDREQ').AsFloat +
                                                                 objRequisicao.cdsRequisicao.FieldByName('QTDITE').AsFloat;

      cdsItensMultiLojas.Post;

      objRequisicao.cdsRequisicao.Edit;
      objRequisicao.cdsRequisicao.FieldByName('EMPDES').AsString := cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString;
      objRequisicao.cdsRequisicao.Post;
    End;

  End;

  Procedure pRetiraVinculoMultiloja(Var blnAtendidaPorTransferencia: Boolean);
    Var
      blnAchou: Boolean;
      fltQAtReq,
      fltQtdReq,
      fltQtdTra,
      fltQtdIte: Double;
  Begin
    blnAtendidaPorTransferencia := False;

    pFiltraMultiLoja;

    If cdsItensMultiLojas.Locate('ITE_CODEMP;ITE_CODITE', VarArrayOf([objRequisicao.cdsRequisicao.FieldByName('EMPDES').AsString,
                                                                        cdsItensPedido.FieldByName('ITE_CODITE').AsString]), []) Then
    Begin
      cdsItensMultiLojas.Edit;
      cdsItensMultiLojas.FieldByName('ITE_INCIRQ').AsString := objRequisicao.fRetiraVinculoItem(cdsItensMultiLojas.FieldByName('ITE_INCIRQ').AsString,
                                                                    objRequisicao.cdsRequisicao.FieldByName('AUTOINCREM').AsString, blnAchou);

      If blnAchou Then
      Begin
        // REQUISIÇÃO LIGADA A TRANSFERÊNCIA
        If cdsItensMultiLojas.FieldByName('ITE_ATEREQ').AsString = 'T' Then
        Begin

          blnAtendidaPorTransferencia := True;

          cdsItensMultiLojas.FieldByName('ITE_QTDTRA').AsFloat  := 0;

          objTransfere.pExcluiItem(cdsItensMultiLojas.FieldByName('ITE_CODITE').AsString,
                                   cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString);

        End Else
        // REQUISIÇÃO LIGADA AO PEDIDO
        Begin
          cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat  := cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat -
                                                                      objRequisicao.cdsRequisicao.FieldByName('QTDITE').AsFloat / cdsItensPedido.FieldByName('ITE_QTDEMB').AsFloat;

          If cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat < 0 then
            cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat  := 0;
        End;

        cdsItensMultiLojas.FieldByName('ITE_QTDREQ').AsFloat  := cdsItensMultiLojas.FieldByName('ITE_QTDREQ').AsFloat -
                                                                    objRequisicao.cdsRequisicao.FieldByName('QTDITE').AsFloat;

        If cdsItensMultiLojas.FieldByName('ITE_QTDREQ').AsFloat < 0 then
          cdsItensMultiLojas.FieldByName('ITE_QTDREQ').AsFloat  := 0;
      End;


      pCalculaTotalItemQtdGrid(cdsItensMultiLojas);

      cdsItensMultiLojas.Post;

      fltQtdIte := 0;
      fltQtdTra := 0;
      fltQtdReq := 0;
      fltQAtReq := 0;

      cdsItensMultiLojas.First;
      While Not cdsItensMultiLojas.Eof Do
      Begin
        fltQtdIte := fltQtdIte + cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat;
        fltQtdTra := fltQtdTra + cdsItensMultiLojas.FieldByName('ITE_QTDTRA').AsFloat;
        fltQtdReq := fltQtdReq + cdsItensMultiLojas.FieldByName('ITE_QTDREQ').AsFloat;

        If cdsItensMultiLojas.FieldByName('ITE_ATEREQ').AsString <> 'T' Then
          fltQAtReq := fltQAtReq + cdsItensMultiLojas.FieldByName('ITE_QTDREQ').AsFloat;

        cdsItensMultiLojas.Next;
      End;

      cdsItensPedido.Edit;
      cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat := fltQtdIte;
      cdsItensPedido.FieldByName('ITE_QTDTRA').AsFloat := fltQtdTra;
      cdsItensPedido.FieldByName('ITE_QTDREQ').AsFloat := fltQtdReq;
      cdsItensPedido.FieldByName('ITE_QATREQ').AsFloat := fltQAtReq;
      cdsItensPedido.Post;

    End;
  End;

  Function fValidaEmbalagem: Boolean;
    Var
      fltMltCom: Double;
  Begin
    Result := True;

    If ((strCmpMlt = 'N') Or (strCmpMlt = 'A')) Then
      Exit;

    If cdsItensPedido.IsEmpty Then
      Exit;

    If (cdsItensPedido.FieldByName('ITE_CODITE').AsString  <> objRequisicao.cdsRequisicao.FieldByName('CODITE').AsString) Then
      Exit;

    fltMltCom := cdsItensPedido.FieldByName('ITE_MLTCOM').AsFloat;
    If fltMltCom <= 0 Then
      fltMltCom := 1;

    Result := (Frac(RoundTo((objRequisicao.cdsRequisicao.FieldByName('QTDITE').AsFloat / cdsItensPedido.FieldByName('ITE_QTDEMB').AsFloat)
                  / fltMltCom, -4)) = 0);

    If (Not Result) Then
      sltNaoMultiplos.Add(cdsItensPedido.FieldByName('ITE_CODITE').AsString);
  End;

Begin
  Result := True;

  blnBckExibirPedidoPendente := blnExibirPedidoPendente;
  blnBckExecutarDigMultLoja  := cdsDigMultLoja.blnExecutarDigMultLoja;

  sltNaoMultiplos := TStringList.Create;
  sltNaoMultiplos.Sorted := True;
  sltNaoMultiplos.Duplicates := dupIgnore;

  cdsItensPedido.DisableControls;

  objRequisicao.strCodItens := '';

  prcAfterPost := Nil;

  If (recOpcGir.strPedMlj = 'S') And Assigned(cdsItensMultiLojas) Then
  Begin
    prcAfterPost := cdsItensMultiLojas.AfterPost;
    cdsItensMultiLojas.AfterPost := Nil;
  End;

  Try
     btnCancelaItem.Click;

     blnExibirPedidoPendente    := False;
     cdsDigMultLoja.blnExecutarDigMultLoja  := False;

     prgProgresso.Properties.Max := objRequisicao.cdsRequisicao.RecordCount;

     (*************************************************)
     (*  Adiciona os items selecionados na Requisição *)
     (* Executando processo como se estivesse fazendo *)
     (* manual                                        *)
     (*************************************************)
     objRequisicao.cdsRequisicao.First;
     While Not objRequisicao.cdsRequisicao.Eof Do
     Begin
       strReqAnt := objRequisicao.cdsRequisicao.FieldByName('AUTOINCREM').AsString;

       blnCarregandoRequisicoes := True;


        //Verifica se esta marcado e não estava marcado antes
       If (objRequisicao.cdsRequisicao.FieldByName('MARDES').AsString = '1') And
          (objRequisicao.cdsRequisicao.FieldByName('MARANT').AsString = '0') Then
       Begin
         pLimpaDadosItem;

         edtEmbala.Text := FloatToStrF(1, ffNumber, 20, DEC_EMBALAGEM);

         {Produto}
         edtCodIte.Text := objRequisicao.cdsRequisicao.FieldByName('CODITE').AsString;

         strIncMovRcd   := objRequisicao.cdsRequisicao.FieldByName('AUTOINCREM').AsString;

         // POSICIONA NO ITE DA REQUISICAO
         If Not (fValidaItem(True, True, True) And
                fValidaCampos(edtCodIte)       And
                fPodeRequisitarItem            {And fValidaEmbalagem}) Then
         Begin
           objRequisicao.pDesmarcaRequisicao;
           btnCancelaItem.Click;
         End

         // SE AINDA NÃO ESTÁ VINCULADO A ESSA REQUISIÇÃO
         Else If (Pos(strIncMovRcd, cdsItensPedido.FieldByName('ITE_INCIRQ').AsString) = 0) Then
         begin
           edtCodUni.Text := objRequisicao.cdsRequisicao.FieldByName('CODUNI').AsString;
           pEdtCodSelectExit(edtCodUni,edtSigUni, arrUnidade,Nil, fRetSiglaUni, 'da unidade');

           If Not fValidaCampos(edtCodUni) Then
             objRequisicao.pDesmarcaRequisicao

           Else If (Not cdsItensPedido.Locate('ITE_CODITE', objRequisicao.cdsRequisicao.FieldByName('CODITE').AsString, [])) Or
                   (Pos(strIncMovRcd, cdsItensPedido.FieldByName('ITE_INCIRQ').AsString) = 0) Then
           Begin
             If fStrToFloat(edtEmbala.Text) = 0 Then
               edtEmbala.Text := FloatToStrF(1, ffNumber, 20, DEC_EMBALAGEM);

             {Quantidade}
             If blnUsarGiro           And
                cdsItensPedido.Active And
                recOpcGir.blnImpReq   And
                recOpcGir.blnConsMCom And
               ((strCmpMlt <> 'N') And (strCmpMlt <> 'A')) Then
               edtQtdIte.Text := FormatFloat(fMskDigitos(intDecTpc), cdsItensPedido.FieldByName('ITE_SUGESTORI').AsFloat + objRequisicao.cdsRequisicao.FieldByName('QTDITE').AsFloat /
                                             fStrToFloat(edtEmbala.Text))
             Else
               edtQtdIte.Text := FormatFloat(fMskDigitos(intDecTpc), fStrToFloat(edtQtdIte.Text) + objRequisicao.cdsRequisicao.FieldByName('QTDITE').AsFloat /
                                             fStrToFloat(edtEmbala.Text));

             fltQtdReqImport := objRequisicao.cdsRequisicao.FieldByName('QTDITE').AsFloat;

             If (strCmpMlt <> 'N') And (strCmpMlt <> 'A') Then
             Begin
               If qryDadCom.Active And (qryDadCom.FieldByName('ITE_CODITE').AsString = edtCodIte.Text) Then
                 fltMltCom2 := qryDadCom.FieldByName('ITE_MLTCOM').AsFloat

               Else If cdsItensPedido.Active And (cdsItensPedido.FieldByName('ITE_CODITE').AsString = edtCodIte.Text) Then
                 fltMltCom2 := cdsItensPedido.FieldByName('ITE_MLTCOM').AsFloat

               Else fltMltCom2 := 1;

               If fltMltCom2 <= 0 Then
                 fltMltCom2 := 1;


               fltQtd := Trunc(fStrToFloat(edtQtdIte.Text) / fltMltCom2);

               fltResto := RoundTo(fStrToFloat(edtQtdIte.Text) - fltQtd * fltMltCom2, -4);

               If fltResto > 0 Then
                 edtQtdIte.text := FormatFloat(fMskDigitos(intDecTpc), (fltQtd + 1) * fltMltCom2);
             End;

             If fValidaCampos(edtQtdIte) And fAdicionaItemClick Then
             begin
               If recOpcGir.strPedMlj = 'S' Then
                 pAdicionarItemMultiLoja;

               objRequisicao.strCodItens := objRequisicao.strCodItens + '"' + objRequisicao.cdsRequisicao.FieldByName('CODITE').AsString + '"' + ',';

               objRequisicao.cdsRequisicao.Edit;
               objRequisicao.cdsRequisicao.FieldByName('MARANT').AsInteger := 1;
               objRequisicao.cdsRequisicao.Post;

             End Else
             Begin

               objRequisicao.pDesmarcaRequisicao;

               btnCancelaItem.Click;
             End;

             objCopiaSeg.pAtualizaItem;
           End;

         End;

       End

            //  Verifica se estava marcado e foi desmarcado
       Else If (objRequisicao.cdsRequisicao.FieldByName('MARDES').AsString = '0') And
               (objRequisicao.cdsRequisicao.FieldByName('MARANT').AsString = '1') Then
       Begin

         If cdsItensPedido.Locate('ITE_CODITE', objRequisicao.cdsRequisicao.FieldByName('CODITE').AsString, []) And
            (Pos(objRequisicao.cdsRequisicao.FieldByName('AUTOINCREM').AsString, cdsItensPedido.FieldByName('ITE_INCIRQ').AsString) > 0) Then
         Begin
           If recOpcGir.strPedMlj = 'S' Then
             pRetiraVinculoMultiloja(blnAtendidaPorTransferencia)
           Else
             blnAtendidaPorTransferencia := False;

           // APENAS RETIRA O VÍNCULO DO PEDIDO
           cdsItensPedido.Edit;
           cdsItensPedido.FieldByName('ITE_INCIRQ').AsString := objRequisicao.fRetiraVinculoItem(cdsItensPedido.FieldByName('ITE_INCIRQ').AsString,
                                                                  objRequisicao.cdsRequisicao.FieldByName('AUTOINCREM').AsString, blnAchouReq);

           If blnAchouReq Then
           Begin

             // JA ACERTOU EM  pRetiraVinculoMultiloja(blnAtendidaPorTransferencia)
             If (recOpcGir.strPedMlj <> 'S') And (Not blnAtendidaPorTransferencia) Then
             Begin
               cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat  := cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat -
                                                                      objRequisicao.cdsRequisicao.FieldByName('QTDITE').AsFloat / cdsItensPedido.FieldByName('ITE_QTDEMB').AsFloat;

               If cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat < 0 Then
                 cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat := 0;

               cdsItensPedido.FieldByName('ITE_QTDREQ').AsFloat  := cdsItensPedido.FieldByName('ITE_QTDREQ').AsFloat -
                                                                    objRequisicao.cdsRequisicao.FieldByName('QTDITE').AsFloat / cdsItensPedido.FieldByName('ITE_QTDEMB').AsFloat;

               If cdsItensPedido.FieldByName('ITE_QTDREQ').AsFloat < 0 then
                 cdsItensPedido.FieldByName('ITE_QTDREQ').AsFloat  := 0;
             End;

           End;

           pCalculaTotalItemQtdGrid(cdsItensPedido);
           cdsItensPedido.Post;

           objCopiaSeg.pAtualizaItem;

           If (cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat = 0) And
              (cdsItensPedido.FieldByName('ITE_QTDTRA').AsFloat = 0) And
              (cdsItensPedido.FieldByName('ITE_CRIREQ').AsString = 'S') Then
             pApagaItem;
         End;

         objRequisicao.pDesmarcaRequisicao;
       End;

       If blnNovoReg Or fEmptyStr(objRequisicao.cdsRequisicao.FieldByName('SEQPCD').AsString) Then
       Begin
         If objRequisicao.fAssociaPedidoCompra Then
           objRequisicao.cdsRequisicao.Delete;
       End;

       If objRequisicao.cdsRequisicao.FieldByName('AUTDET_CONF').AsString <> objRequisicao.cdsRequisicao.FieldByName('AUTDET').AsString Then
       Begin
         objRequisicao.cdsRequisicao.Edit;
         objRequisicao.cdsRequisicao.FieldByName('AUTDET_CONF').Value := objRequisicao.cdsRequisicao.FieldByName('AUTDET').Value;
         objRequisicao.cdsRequisicao.Post;
       End;

       prgProgresso.Position := prgProgresso.Position + 1;
       Application.ProcessMessages;

       If strReqAnt = objRequisicao.cdsRequisicao.FieldByName('AUTOINCREM').AsString Then
         objRequisicao.cdsRequisicao.Next;
     End;

     //Cortar a Ultima "," da var strCodItens
     objRequisicao.strCodItens := LeftStr(objRequisicao.strCodItens, Length(objRequisicao.strCodItens) -1);

     If blnNovoReg Then
       Result := objRequisicao.fNegaRequisicoesMotivoNaoVaiComprar(objRequisicao.cdsRequisicao) And
                 objRequisicao.fNegaRequisicoesMotivoPossuiEstoque(objRequisicao.cdsRequisicao);

  Finally
    cdsItensPedido.EnableControls;
    blnExibirPedidoPendente := blnBckExibirPedidoPendente;
    cdsDigMultLoja.blnExecutarDigMultLoja := blnBckExecutarDigMultLoja;
    blnCarregandoRequisicoes := False;
    strIncMovRcd := '';
    fltQtdReqImport := 0;

    pRateiaFreteDesAce(fltValFreGer + fltDesAceGer > 0, fltValFreGer, fltDesAceGer,
                       objCopiaSeg.recPcmger.strBStFre, objCopiaSeg.recPcmger.strBStAce,
                       objCopiaSeg.recPcmger.strIpiFre);

    pAtualizaBotoesTotais;
    pAferScroll(cdsItensPedido);
    pAtualizaGridRodape(False, strCodIteProcessadoRodape);

    If (recOpcGir.strPedMlj = 'S') And Assigned(cdsItensMultiLojas) Then
      cdsItensMultiLojas.AfterPost := prcAfterPost;

    If sltNaoMultiplos.Count > 0 Then
      pMensagemOk('Há requisicões não importadas porque suas quantidades não são múltiplos da embalagens. Produto(s): ' + sltNaoMultiplos.CommaText);

    FreeAndNil(sltNaoMultiplos);
  End;

End;

procedure TfrmPedidoDeCompra.pImportaRequisicoes(strCodIte: String; blnImportarTodos: Boolean = False);
begin
  If Not btnImporta.Visible Then
    Exit;

  If Assigned(cdsDigMultLoja) Then
    cdsDigMultLoja.blnValidarDados := False;

  If edtCodDig.Visible Then
  Begin
    objRequisicao.strCodCmp := edtCodCmp.Text
  End Else
  Begin
    objRequisicao.strCodCmp := fRetCodVendedor(edtCodCmp.Text);
  End;

  If fEmptyStr(fRetNomVendRep(objRequisicao.strCodCmp)) Then
    objRequisicao.strCodCmp := '';

  objRequisicao.strEmpSaldos   := fStrEmpSaldos;
  objRequisicao.cdsItensPedido := cdsItensPedido;
  objRequisicao.recOpcGir      := recOpcGir;
  objRequisicao.blnUsarGiro    := blnUsarGiro;

  If Not blnNovoReg Then
    objRequisicao.strDocOri := qryPcmGer.FieldByName('PCG_DOCORI').AsString;

  If objRequisicao.fSelecionarRequisicoes(strCodEmp, strNumPed, strEspDoc, strCodIte,
                                          objCopiaSeg, blnUsarGiro, recOpcGir, True,
                                          blnImportarTodos) Then
  Begin

    Try
      pCriarFormularios(TfrmGravando, frmGravando);

      frmGravando.lblGravando.Caption := 'Importando requisições, aguarde...';

      frmGravando.fExecutarAcao := fImportaRequisicoes;

      frmGravando.ShowModal;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmPedidoDeCompra.pImportaRequisicoes]');
      End;
    End;

    pFreeAndNil(frmGravando);

  End;

  If Assigned(cdsDigMultLoja) Then
    cdsDigMultLoja.blnValidarDados := True;
end;

procedure TfrmPedidoDeCompra.btnImportaClick(Sender: TObject);
begin
  inherited;

  pImportaRequisicoes('');
end;

procedure TfrmPedidoDeCompra.btnInfPedidoDeVendasClick(Sender: TObject);
begin
  //Abrir tela que permite a informação dos pedidos de venda.
  If (btnInfPedidoDeVendas.Visible) And (Not cdsItensPedido.IsEmpty) Then
    TfrmInformarPedidoVendaItens.fRelacionaItemPedidoVenda(cdsItensPedido);
end;

procedure TfrmPedidoDeCompra.btnInsPlaClick(Sender: TObject);
var objImportaPlanilhaPedidoCompra : TImportaPlanilhaPedidoCompra;
Begin
  objImportaPlanilhaPedidoCompra := TImportaPlanilhaPedidoCompra.Create;
  cdsItensPedido.AfterScroll := Nil;
  blnEstaNaImportacao := True;

  Try
    objImportaPlanilhaPedidoCompra.AposCarregarDadosDaLinha := AposCarregarLinhaPlanilha;
    If objImportaPlanilhaPedidoCompra.fSelecionaArquivo(FblnImportacaoArqAcumulaQtd) Then
      objImportaPlanilhaPedidoCompra.pProcessaArquivo;
  Finally
    blnEstaNaImportacao := False;
    cdsItensPedido.AfterScroll := pAferScroll;
    pAferScroll(cdsItensPedido);
    FreeAndNil(objImportaPlanilhaPedidoCompra);
  End;
End;

procedure TfrmPedidoDeCompra.AposCarregarLinhaPlanilha(Linha: TLinha; CamposLayoutUsados: TCamposLayoutUsados; var PararProcessamento: Boolean);
begin

  If Linha.fltQuantidade <= 0 Then
    Exit;

  Try
    If CamposLayoutUsados.blnCodigoItem Then
      edtCodIte.Text := Linha.strCodigoItem
    Else
      Exit;

    blnInseriu := fValidaItem(True, True, False);

    If blnInseriu Then
    Begin
      If CamposLayoutUsados.blnQuantidade Then
      Begin
        If FblnImportacaoArqAcumulaQtd And (cdsItensPedido.Locate('ITE_CODITE',edtCodIte.Text, [])) Then
          edtQtdIte.Text := FloatToStr(cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat + Linha.fltQuantidade)
        Else
          edtQtdIte.Text := FloatToStr(Linha.fltQuantidade);
      End
      Else
        edtQtdIte.Text := '0';
      If fStrToFloat(edtQtdIte.Text) = 0 Then
      Begin
        fMensagem('','A quantidade do item ' + Linha.strCodigoItem + ' não pode ser zero!', ['&OK']);
        blnInseriu := False;
      End;

      If CamposLayoutUsados.blnVrUnitario Then
        edtUnitar.Text := FloatToStr(Linha.fltVrUnitario);
      If fStrToFloat(edtUnitar.Text) = 0 Then
      Begin
        fMensagem('','O unitário do item ' + Linha.strCodigoItem + ' não pode ser zero!', ['&OK']);
        blnInseriu := False;
      End;

      If blnInseriu Then
      Begin

        If CamposLayoutUsados.blnDescricao And (Linha.strDescricao <> '') Then
          edtDesIte.Text := Linha.strDescricao;

        If CamposLayoutUsados.blnUnidade And (Linha.strUnidade <> '') Then
          edtCodUni.Text := Linha.strUnidade;

        If CamposLayoutUsados.blnEmbalagem And (Linha.fltEmbalagem > 0)  Then
          edtEmbala.Text := FloatToStr(Linha.fltEmbalagem);

        If CamposLayoutUsados.blnDes01 Then
          edtDesUni.Text := FloatToStr(Linha.fltDes01);
        If CamposLayoutUsados.blnDes02 Then
          edtDesUn2.Text := FloatToStr(Linha.fltDes02);
        If CamposLayoutUsados.blnDes03 Then
          edtDesUn3.Text := FloatToStr(Linha.fltDes03);
        If CamposLayoutUsados.blndes04 Then
          edtDesUn4.Text := FloatToStr(Linha.fltdes04);
        If CamposLayoutUsados.blnDes05 Then
          edtDesUn5.Text := FloatToStr(Linha.fltDes05);
        If CamposLayoutUsados.blnDes06 Then
          edtDesUn6.Text := FloatToStr(Linha.fltDes06);
        If CamposLayoutUsados.blnAlqIPI Then
          edtPerIpi.Text := FloatToStr(Linha.flAlqIPI);
        If CamposLayoutUsados.blnValIPI Then
          edtTotIpi.Text := FloatToStr(Linha.fltValIPI);
        If CamposLayoutUsados.blnAlqImpostoImportacao Then
          edtPerImp.Text := FloatToStr(Linha.fltAlqImpostoImportacao);
        If CamposLayoutUsados.blnValImpostoImportacao Then
          edtTotImp.Text := FloatToStr(Linha.fltValImpostoImportacao);
        If CamposLayoutUsados.blnAqlIPIImportacao Then
          edtPerIpiImp.Text := FloatToStr(Linha.fltAqlIPIImportacao);
        If CamposLayoutUsados.blnValIPIImportacao Then
          edtTotIpiImp.Text := FloatToStr(Linha.fltValIPIImportacao);
        If CamposLayoutUsados.blnAlqPIS Then
          edtPerPis.Text := FloatToStr(Linha.fltAlqPIS);
        If CamposLayoutUsados.blnValPIS Then
          edtTotPis.Text := FloatToStr(Linha.fltValPIS);
        If CamposLayoutUsados.blnAqlCOFINS Then
          edtPerCof.Text := FloatToStr(Linha.fltAqlCOFINS);
        If CamposLayoutUsados.blnValCOFINS Then
          edtTotCof.Text := FloatToStr(Linha.fltValCOFINS);
        If CamposLayoutUsados.blnAlqCbs And TAliquotasReforma.fAliquotaValida(Linha.fltAlqCbs) Then
          edtAlqCbs.Text := FloatToStr(Linha.fltAlqCbs);
        If CamposLayoutUsados.blnAlqIbs And TAliquotasReforma.fAliquotaValida(Linha.fltAlqIbs) Then
          edtAlqIbs.Text := FloatToStr(Linha.fltAlqIbs);
        If CamposLayoutUsados.blnAlq_Is And TAliquotasReforma.fAliquotaValida(Linha.fltAlq_Is) Then
          edtAlq_Is.Text := FloatToStr(Linha.fltAlq_Is);

        fValidaCampos(edtQtdIte);

        If (Linha.fltAqlSub > 0) Or (Linha.fltValSub > 0) Then
        Begin
          If CamposLayoutUsados.blnAqlSub Then
            edtPerSub.Text := FloatToStr(Linha.fltAqlSub);
          If CamposLayoutUsados.blnValSub Then
            edtTotSub.Text := FloatToStr(Linha.fltValSub);
          If (Linha.fltAqlSub > 0) then
            fValidaCampos(edtPerSub);
          If (Linha.fltValSub > 0) Then
            fValidaCampos(edtTotSub);
          strSubUsu := 'S';
        End;


        fAdicionaItem(False, False);
      End;

    End;
    If Not blnInseriu Then
    Begin
      If fMensagem('','O item anterior não foi inserido, deseja continuar?', ['','']) = 2 Then
         PararProcessamento := True;
    End;
  Finally
    pAtualizaTotalTela;
    Application.ProcessMessages;
  end;

end;



{
procedure TfrmPedidoDeCompra.btnInsPlaClick(Sender: TObject);
 Var
    Excel  : Variant;
    strArq : String;
    intCont: Integer;
begin
  inherited;

  Try
    btnInsPla.Enabled := False;

    If OpenFile.Execute Then
    Begin
      strArq := OpenFile.FileName;

      Excel := CreateOleObject('Excel.Application');
      Excel.Visible       := False;
      Excel.DisplayAlerts := False;
      Excel.WorkBooks.Open(Filename := strArq);

      intCont := 5;
      While True Do
      Begin
        Application.ProcessMessages;

        If fEmptyStr(Excel.Range['B' + IntToStr(intCont)].Value) Then
          Break;

        pWaitWindow(Self,'Aguarde inserindo itens',1);
        btnCancelaItem.Click;
        edtCodIte.Text := fStrZero(VarToStr(Excel.Range['B' + IntToStr(intCont)].Value), 5);
        blnInseriu := fValidaItem(True, True, False);

        If blnInseriu Then
        Begin

          edtQtdIte.Text := Excel.Range['F' + IntToStr(intCont)].Value;
          If fStrToFloat(edtQtdIte.Text) = 0 Then
          Begin
            fMensagem('','A quantidade do item ' + fStrZero(VarToStr(Excel.Range['B' + IntToStr(intCont)].Value), 5) + ' não pode ser zero!', ['&OK']);
            blnInseriu := False;
          End;

          If blnInseriu Then
          Begin
            edtUnitar.Text := Excel.Range['H' + IntToStr(intCont)].Value;
            If fStrToFloat(edtUnitar.Text) = 0 Then
            Begin
              fMensagem('','O unitário do item ' + fStrZero(VarToStr(Excel.Range['B' + IntToStr(intCont)].Value), 5) + ' não pode ser zero!', ['&OK']);
              blnInseriu := False;
            End
            Else
            Begin
              edtPerIpi.Text := '0,0000';
              edtPerSub.Text := '0,0000';
              fAdicionaItem(False);
            End;
          End;

        End;

        If Not blnInseriu Then
        Begin
          If fMensagem('','O item anterior não foi inserido, deseja continuar?', ['','']) = 2 Then
            Break;
        End;

        Inc(intCont);
      End;

      Excel.Quit;

    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[btnInsPlaClick]');
  End;

  btnInsPla.Enabled := True;

end;
}

procedure TfrmPedidoDeCompra.btnSairClick(Sender: TObject);
begin
//  inherited;

  pEscapePressed;
end;

procedure TfrmPedidoDeCompra.btnSimGirClick(Sender: TObject);
var
  strEmpresas : String;
begin
  inherited;

  If Not btnSimGir.Visible Then
    Exit;

  If cdsItensPedido.IsEmpty Then
    Exit;

  If fEmptyStr(cdsItensPedido.FieldByName('ITE_CODSIM').AsString) Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
  begin

    If Not recOpcGir.strEmpCal.IsEmpty Then
      strEmpresas := recOpcGir.strEmpCal
    Else
      strEmpresas := recOpcGir.strEmpGir;

    prcExecutaRelatorio(63, 5036, [],
                          ['CODSIM','CODEMP'],
                          [cdsItensPedido.FieldByName('ITE_CODSIM').AsString, strEmpresas],
                          Sender,
                          nil,
                          True);
  End;

end;

procedure TfrmPedidoDeCompra.btnSimilaresClick(Sender: TObject);
var
  strEmpresas : String;
begin
  inherited;

  If btnSimilares.Visible Then
  Begin

    If Not recOpcGir.strEmpCal.IsEmpty Then
      strEmpresas := recOpcGir.strEmpCal
    Else
      strEmpresas := recOpcGir.strEmpGir;

    If Assigned(prcExecutaRelatorio) Then
    begin
      prcExecutaRelatorio(414, 5036, [],
                          ['CODSIM','CODEMP'],
                          [cdsItensPedido.FieldByName('ITE_CODSIM').AsString, strEmpresas],
                          Sender,
                          nil,
                          True);
    End;

    pSetFocus(ActiveControl);
  End;

end;

procedure TfrmPedidoDeCompra.btnGarantiaPendClick(Sender: TObject);
begin

  inherited;

  If (Not btnGarantiaPend.Visible) Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(160, 7216, [7217],
                        ['CODITE','CODEMP'],
                        [cdsItensPedido.FieldByName('ITE_CODITE').AsString,
                        VS_strCodEmp],
                        Sender,
                        nil,
                        True);
  End;

end;

function TfrmPedidoDeCompra.fResponsavelGrupoCompras(strCodIte: String): String;
  var
    qryItem: TUniQuery;
begin
  qryItem := fCriaQuery(Self);

  With qryItem,SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT SQL_NO_CACHE ');
    Add('  GRU_OPERES        ');
    Add('FROM CADITE         ');
    Add('  INNER JOIN GRU_COMPRA ON ITE_GRUCMP = GRU_CODIGO ');
    Add('WHERE ');
    Add('ITE_CODITE = :CODITE ');

    ParamByName('CODITE').AsString := strCodIte;

    Open;

    Result := FieldByName('GRU_OPERES').AsString;
  End;

  FreeAndNil(qryItem);
end;

function TfrmPedidoDeCompra.fVerificaComprador: Boolean;
  Var
    cdsItens: TUniClientDataSet;
    qryItens: TUniQuery;
    strCodCmp: String;
    strFilter,
    strTamanhoDescricao: String;
    blnFilter: Boolean;

  Procedure pIncluiItem;
  Begin
    With qryItens, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT');
      Add('  GRU_OPERES  ');
      Add('FROM CADITE   ');
      Add('INNER JOIN GRU_COMPRA ON GRU_CODIGO = ITE_GRUCMP');
      Add('WHERE');
      Add('  ITE_CODITE = :CODITE AND          ');
      Add('  IFNULL(GRU_OPERES, "") <> "" AND  ');
      Add('  IFNULL(GRU_OPERES, "") <> :CODOPE ');

      ParamByName('CODITE').AsString := cdsItensPedido.FieldByName('ITE_CODITE').AsString;
      ParamByName('CODOPE').AsString := strCodCmp;

      Open;

      If (Not IsEmpty) Then
      Begin
        cdsItens.Insert;
        cdsItens.FieldByName('CODITE').AsString := cdsItensPedido.FieldByName('ITE_CODITE').AsString;
        cdsItens.FieldByName('DESITE').AsString := cdsItensPedido.FieldByName('ITE_DESITE').AsString;
        cdsItens.FieldByName('CODOPE').AsString := FieldByName('GRU_OPERES').AsString;
        cdsItens.Post;
      End;
    End;
  End;

Begin

  Try
    strTamanhoDescricao := fRetFieldCharLength('PCMDET','PCD_DESITE');
    If fEmptyStr(strTamanhoDescricao) Then
      Abort;
  Except
     strTamanhoDescricao := '70';
  End;

  If blnLibCmp Then
  Begin
    Result := True;
    Exit;
  End;

  strCodCmp := fTrataCodCmp;

  If fVerificaAcessoSistema('GRUCOM', strCodCmp) Then
  Begin
    Result := True;
    Exit;
  End;

  qryItens  := fCriaQuery(Self);
  cdsItens  := TUniClientDataSet.Create(Self);
  With cdsItens, FieldDefs Do
  Begin
    With AddFieldDef Do Begin Name := 'CODITE'; DataType := ftString; Required := False; End;
    With AddFieldDef Do Begin Name := 'DESITE'; DataType := ftString; Required := False; Size := strToInt(strTamanhoDescricao); End;
    With AddFieldDef Do Begin Name := 'CODOPE'; DataType := ftString; Required := False; End;

    CreateDataSet;
    Open;
  End;

  With cdsItensPedido Do
  Begin
    strFilter := Filter;
    blnFilter := Filtered;

    DisableControls;
    Filter   := 'ITE_QTDITE > 0';
    Filtered := True;
    First;

    While Not Eof Do
    Begin
      pIncluiItem;
      Next;
    End;

    Filter   := strFilter;
    Filtered := blnFilter;

    EnableControls;
  End;

  Result := cdsItens.IsEmpty;

  If Not Result Then
  Begin
    Try
      pCriarFormularios(TfrmItensOutrosCompradores, frmItensOutrosCompradores);
      frmItensOutrosCompradores.dtsItens.DataSet := cdsItens;
      frmItensOutrosCompradores.ShowModal;
      FreeAndNil(frmItensOutrosCompradores);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fVerificaComprador]');
      End;
    End;
  End;

  cdsItens.EmptyDataSet;
  FreeAndNil(cdsItens);
  FreeAndNil(qryItens);

  If Not Result Then
    Result := fLiberaAlteracaoOutroResponsavel('PEDIDO COM ITENS DE OUTRO RESPONSÁVEL PELO GRUPO DE COMPRAS!', '');
End;

Procedure TfrmPedidoDeCompra.pAtualizaReservados;
  Var
    objSalRes: TRecSadoReservado;
Begin
  If (blnUsarGiro Or blnAltPedGir Or (Assigned(cdsItensMultiLojas) And (Not cdsItensMultiLojas.IsEmpty))) And recOpcGir.blnEmbala Then
  Begin
    objSalRes := TRecSadoReservado.Create;

    If Assigned(cdsItensMultiLojas) And (recOpcGir.strPedMlj = 'S') Then
    Begin
      objSalRes.cdsItens          := cdsItensMultiLojas;
      objSalRes.cdsItensSintetico := cdsItensPedido;
    End Else
    Begin
      If recOpcGir.blnCarregItensGrid Then
        objSalRes.cdsItens := cdsItensPedido
      Else
        objSalRes.cdsItens := cdsItensGiro;
    End;

    objSalRes.pAtualizaReservados(recOpcGir.blnEmbala);

    FreeAndNil(objSalRes);
  End;
End;

function TfrmPedidoDeCompra.fRetComprador: String;
Begin
  Result := IIF(blnLibCmp And (Not  fEmptyStr(strCmpOri)), strCmpOri, fTrataCodCmp);
End;

function TfrmPedidoDeCompra.fRetDataEntrega: TDateTime;
var
  intRecNO: Integer;
  strFilter: String;
  blnFiltered: Boolean;
  blnDisabled: Boolean;
  dtEntrega: TDateTime;
  blnInserindo: Boolean;
Begin
  dtEntrega := fNow;

  intRecNO := cdsItensPedido.RecNO;
  strFilter := cdsItensPedido.Filter;
  blnFiltered := cdsItensPedido.Filtered;
  blnDisabled := cdsItensPedido.ControlsDisabled;
  blnInserindo := cdsItensPedido.State = dsInsert;

  If Not blnDisabled Then
    cdsItensPedido.DisableControls;
  Try
    cdsItensPedido.Filter := 'ITE_QTDITE > 0 AND ITE_DTAENT <> NULL';
    cdsItensPedido.Filtered := True;

    if cdsItensPedido.RecordCount > 0 then
    begin
      cdsItensPedido.IndexDefs.Add('dataEntregaDesc', 'ITE_DTAENT', [ixDescending]);
      cdsItensPedido.IndexName := 'dataEntregaDesc';

      if fCfgSis('TDEIPC') = '2' then
        cdsItensPedido.Last
      else
        cdsItensPedido.First;

      dtEntrega := cdsItensPedido.FieldByName('ITE_DTAENT').AsDateTime;

      cdsItensPedido.IndexDefs.Delete(cdsItensPedido.IndexDefs.IndexOf('dataEntregaDesc'));
    end;
  Finally
    Result := dtEntrega;

    cdsItensPedido.Filter := strFilter;
    cdsItensPedido.Filtered := blnFiltered;
    If (intRecNO > -1) And (cdsItensPedido.RecNO <> intRecNO) Then
      cdsItensPedido.RecNO := intRecNO;

    If blnInserindo Then
      cdsItensPedido.Edit;

    If Not blnDisabled Then
      cdsItensPedido.EnableControls;
  End;
End;

function TfrmPedidoDeCompra.fTemItensDeOutroResponsavel: Boolean;
  Var
    strCodCom,
    strOpeRes: String;
Begin
  If blnLibCmp Then
  Begin
    Result := True;
    Exit;
  End;

  strCodCom := fTrataCodCmp;

  If fVerificaAcessoSistema('GRUCOM', strCodCom) Then
  Begin
    Result := False;
    Exit;
  End;

  Result := False;
  With cdsItensPedido Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      strOpeRes := fResponsavelGrupoCompras(FieldByName('ITE_CODITE').AsString);

      If (Not fEmptyStr(strOpeRes)) And (strOpeRes <> strCodCom) Then
      Begin
        Result := True;
        Break;
      End;

      Next;
    End;
    EnableControls;
  End;
End;

function TfrmPedidoDeCompra.fLiberaAlteracaoOutroResponsavel(strMotivo, strCodIte: String): Boolean;
Var
  strSenha           : String;
  strCodigoLiberacao : String;
Begin
  Result := False;
  pMensagemOk('Produto ' + strCodIte + ' de outro responsável pelo grupo de compras!');

  If ffrmSenha(strSenha) and (not fEmptyStr(strSenha)) Then
  Begin
    Result := fVerificaAcessoSistema('LIBRES', fRetCodVendedor(strSenha));

    If Result Then
    Begin
      blnLibCmp := True;

      strCodigoLiberacao := fCodigoLiberacaoLogLib('LIBRES');
      pGeraMatrizLiberacao(fRetCodVendedor(strSenha),
                           fRetCodVendedor(strSenha),
                           strMotivo,
                           'LIBRES',
                           strCodigoLiberacao,
                           strCodIte,
                           0,
                           '',
                           '',
                           False,
                           '',
                           0,
                           0,
                           0,
                           'Liberar itens de outro responsável pelo Grupo de Compras');

    End Else
      pMensagemOk('Operador sem direito de acesso a essa operação!');
  End;
End;

function TfrmPedidoDeCompra.fLiberouItensInativos: Boolean;
var
  objLiberacao : ILiberacao;
begin
  objLiberacao := TLiberacaoFactory.fGetLiberacao;
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddSeparador(113);
  objLiberacao.objMsgLibera.pAddTexto('Permitir pedido de compra e entrada de mercadorias com itens inativos para compra.');

  objLiberacao.objMsgLibera.pAddTextoCaption('Operador Logado' , strLoginUsuarioLogado + ' - ' + fRetNomeOperador(strLoginUsuarioLogado)            , 23);
  objLiberacao.objMsgLibera.pAddSeparador(113);

  objLiberacao.strDirAce := 'ITEINA';
  objLiberacao.strMsgSen := 'Permitir pedido de compra e entrada de mercadorias com itens inativos para compra.';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  Result := objLiberacao.fLibera;
end;

function TfrmPedidoDeCompra.fLiberarLimiteMAximoPedidoCompraVRMXPC: Boolean;
var
  objLiberacao : ILiberacao;
begin
  Result := False;
  objLiberacao := TLiberacaoFactory.fGetLiberacao;
  objLiberacao.Clear;

  objLiberacao.objMsgLibera.pAddTexto('Limite Máximo para Pedido de Compras ultrapassado!');
  objLiberacao.objMsgLibera.pAddSeparador(125);

  If edtNumPed.Visible Then
  Begin
    objLiberacao.objMsgLibera.pAddTextoCaption('Nro. Pedido',edtNumPed.text,15);
  End;

  objLiberacao.objMsgLibera.pAddTextoCaption('Fornecedor:', edtCodFor.Text + ' - ' + edtNomFor.Text, 15 );
  objLiberacao.objMsgLibera.pAddTextoCaption('Comprador:' , edtCodCmp.Text + ' - ' + edtNomCmp.Text, 15 );

  If edtCodDig.Visible Then
  Begin
	  objLiberacao.objMsgLibera.pAddTextoCaption('Digitador', edtCodDig.Text + ' - ' + edtNomDig.Text, 15 );
  End;

  objLiberacao.objMsgLibera.pAddTextoCaption('Data Entrega' , mskDtaPed.Text , 15 );
  objLiberacao.objMsgLibera.pAddTextoCaption('Data Faturam.', mskDtaFat.Text , 15 );
  objLiberacao.objMsgLibera.pAddTextoCaption('Cnd. Pgto'    , FormatMaskText('(99)999.999.999.999.999.999.999.999.999.999.999.999;0;_', mskCndPag.Text), 15 );
  objLiberacao.objMsgLibera.pAddSeparador(125);

  If chkPedImp.Checked Then
	  objLiberacao.objMsgLibera.pAddTextoCaption('Pedido de Importação', 'Marcado', 21 );

  If chkPedInt.Checked Then
	  objLiberacao.objMsgLibera.pAddTextoCaption('Pedido Entrepostado',  'Marcado', 21 );

  If chkPedBon.Checked Then
	  objLiberacao.objMsgLibera.pAddTextoCaption('Pedido de Bonificação','Marcado', 21 );

  If chkPedImp.Checked Or chkPedInt.Checked Or chkPedBon.Checked  Then
    objLiberacao.objMsgLibera.pAddSeparador(125);

  objLiberacao.objMsgLibera.pAddTextoCaption('Valor Pedido', FormatFloat( '#,##0.00' ,fDoubleAggregate(cdsItensPedido, 'TOT_TOTGER')), 15 );


  objLiberacao.objMsgRemota.pAddSeparador(125);
  objLiberacao.objMsgRemota.pAddTexto('Limite Máximo para Pedido de Compras ultrapassado', alCentro, teAmbos, '', 125);
  objLiberacao.objMsgRemota.pAddSeparador(125);
	objLiberacao.objMsgRemota.pAddTextoCaption('Valor Pedido de Compra', FormatFloat( '#,##0.00' ,fDoubleAggregate(cdsItensPedido, 'TOT_TOTGER')), 25 );
  objLiberacao.objMsgRemota.pAddTextoCaption('Valor Máximo', FormatFloat( '#,##0.00' ,fCfgSis('VRMXPC', varDouble))                  , 25 );

	objLiberacao.objMsgRemota.pAddSeparador(125);
 	objLiberacao.objMsgRemota.pAddSeparador(125);
	objLiberacao.objMsgRemota.pAddTextoCaption('','Valor máximo definido na configuração [CFG_VRMXPC - Valor máximo para gerar um Pedido de Compra]',0);
 	objLiberacao.objMsgRemota.pAddSeparador(125);

  objLiberacao.strDirAce := 'LIBPDC';
  objLiberacao.strMsgSen := 'Pedido de Compra';
  objLiberacao.blnMosMen := True;
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  If objLiberacao.fLibera Then
    Result := True;

end;

function TfrmPedidoDeCompra.fPedeDadosImportacao: Boolean;
begin
  If Not chkPedImp.Checked Then
  Begin
    Result := True;
    Exit;
  End;

  pCriarFormularios(TfrmPedidoCompraImportacao, frmPedidoCompraImportacao);
  frmPedidoCompraImportacao.intDecUni := intDecUni;

  With frmPedidoCompraImportacao Do
  Begin
    edtValTax.Text := FormatFloat('#,##0.00', fltValTax);
    edtMarMer.Text := FormatFloat('#,##0.00', fltValMar);

    cdsItens := cdsItensPedido;
    dtsItens.DataSet := cdsItensPedido;
    Result   := ShowModal = mrOk;

    If Result Then
    Begin
      fltValTax := fStrToFloat(edtValTax.Text);
      fltValMar := fStrToFloat(edtMarMer.Text);
    End;
  End;

  pFreeAndNil(frmPedidoCompraImportacao);
end;

procedure TfrmPedidoDeCompra.pRecalculaIpiItens;
begin
  With cdsItensPedido Do
  Begin
    DisableControls;
    First;
    While (Not Eof) Do
    Begin
      Edit;

      If chkPedImp.Checked Then
      Begin
        FieldByName('ITE_BASIPI').AsFloat  := FieldByName('ITE_TOTITE').AsFloat + FieldByName('ITE_VALIMP').AsFloat;
        FieldByName('ITE_VALPIS').AsFloat  := RoundTo((FieldByName('ITE_TOTITE').AsFloat * FieldByName('ITE_ALQPIS').AsFloat) /100, -2);
        FieldByName('ITE_VALCOF').AsFloat  := RoundTo((FieldByName('ITE_TOTITE').AsFloat * FieldByName('ITE_ALQCOF').AsFloat) /100, -2);
      End Else
      Begin
        FieldByName('ITE_BASIPI').AsFloat := FieldByName('ITE_TOTITE').AsFloat;

        fltAlqPis := fAliquotaPisCofinsProduto(FieldByName('ITE_CODITE').AsString, True);
        fltAlqCof := fAliquotaPisCofinsProduto(FieldByName('ITE_CODITE').AsString, False);

        If (FieldByName('ITE_INCPIS').AsString = 'S') And (fltAlqPis > 0) Then
        Begin
          FieldByName('ITE_BASPIS').AsFloat  := FieldByName('ITE_TOTITE').AsFloat;
          FieldByName('ITE_ALQPIS').AsFloat  := fltAlqPis;
          FieldByName('ITE_VALPIS').AsFloat  := RoundTo((FieldByName('ITE_TOTITE').AsFloat * fltAlqPis) /100, -2);

          FieldByName('ITE_BASCOF').AsFloat  := FieldByName('ITE_TOTITE').AsFloat;
          FieldByName('ITE_ALQCOF').AsFloat  := fltAlqCof;
          FieldByName('ITE_VALCOF').AsFloat  := RoundTo((FieldByName('ITE_TOTITE').AsFloat * fltAlqCof) /100, -2);
        End Else
        Begin
          FieldByName('ITE_ALQPIS').AsFloat  := 0;
          FieldByName('ITE_ALQCOF').AsFloat  := 0;
          FieldByName('ITE_BASPIS').AsFloat  := 0;
          FieldByName('ITE_BASCOF').AsFloat  := 0;
          FieldByName('ITE_VALPIS').AsFloat  := 0;
          FieldByName('ITE_VALCOF').AsFloat  := 0;
        End;
      End;

      FieldByName('ITE_TOTIPI').AsFloat := (FieldByName('ITE_BASIPI').AsFloat * (FieldByName('ITE_PERIPI').AsFloat / 100));

      pCalculaImpostosReformaItem(cdsItensPedido, chkPedImp.Checked);

      Next;
    End;

    EnableControls;
  End;
End;

procedure TfrmPedidoDeCompra.pAjustaTipoPedido(blnPedImp: Boolean);
Begin
  If blnPedImp Then
  Begin

    intDecUni := fCfgSis('DECIMP', varInteger);

    lblTotSub.Visible    := False;
    edtTotSub.Visible    := False;
    edtPerSub.Visible    := edtTotSub.Visible;
    lblPerSub.Visible    := edtTotSub.Visible;

    edtIcmDes.Visible    := False;
    lblIcmDes.Visible    := False;

    lblDesPis.Visible    := False;
    edtDesPis.Visible    := False;

    lblTotSubRod.Visible := False;
    dbeTotSub.Visible    := False;
    dbeSubFCP.Visible    := False;

    cxvItensTOTSUB.Visible := False;

    pnlPedNor.Visible     := False;
    pnlImportacao.Visible := True;
    // alTop alinha pelo Top: o painel da reforma fica abaixo do de importacao
    pnlReforma.Top := pnlImportacao.Top + pnlImportacao.Height;

    pnlItensFixo.ClientHeight := pnlComum.Height + pnlImportacao.Height + pnlReforma.Height + pnlAdicionar.Height;
  End Else
  Begin
    intDecUni := fCfgSis('DECUNI', varInteger);

    lblTotSub.Visible    := True;
    edtTotSub.Visible    := True;
    edtPerSub.Visible    := edtTotSub.Visible;
    lblPerSub.Visible    := edtTotSub.Visible;
    lblTotSubRod.Visible := True;
    dbeTotSub.Visible    := True;
    dbeSubFCP.Visible    := True;

    edtIcmDes.Visible   := blnZonaFranca;
    lblIcmDes.Visible   := blnZonaFranca;

    lblDesPis.Visible    := blnZonaFranca;
    edtDesPis.Visible    := blnZonaFranca;

    cxvItensTOTSUB.Visible := True;

    pnlPedNor.Visible     := True;
    pnlImportacao.Visible := False;

    pnlItensFixo.ClientHeight := pnlComum.Height + pnlPedNor.Height + pnlReforma.Height + pnlAdicionar.Height;
  End;

  edtUnitar.EditFormat := fMskDigitos(intDecUni);
  edtUniLiq.EditFormat := fMskDigitos(intDecUni);
End;

procedure TfrmPedidoDeCompra.pAlterarRadioGroupCodigoFabricaProduto(
  const strTipoCodigoFabricaProduto: String);
begin
  If Not blnPermitirCompradorEscolherCodigoFabrica Then
    Exit;

  If fEmptyStr(strTipoCodigoFabricaProduto) Then
  Begin
    rdgCodigoFabricaProduto.ItemIndex := 1;
    Exit;
  End;

  Case AnsiIndexStr(UpperCase(strTipoCodigoFabricaProduto), ['P', 'F']) of
      0 : rdgCodigoFabricaProduto.ItemIndex := Integer(cfPrincipalProduto);
      1 : rdgCodigoFabricaProduto.ItemIndex := Integer(cfFornedorPedidoCompra);
  End;
end;

function TfrmPedidoDeCompra.fValidaPerImp(blnBuscaPorChave: Boolean = True): Boolean;
Begin
  Result := True;

  If Not pnlImportacao.Visible Then
    Exit;

  If (Not blnConfDocumento) Then
  Begin
    If fEmptyStr(edtPerImp.Text) Then
    Begin
      edtPerImp.Text := '0,00';
    End
    Else If Not (InRange(fStrToFloat(edtPerImp.Text), 0, 100)) And
                (blnBuscaPorChave)                             Then
    Begin
      fMensagem('ATENÇÃO!', 'O percentual do Imposto de Importação deve estar entre 0 e 100!', ['&O k']);
      Result := False;
    End;
  End;

End;

function TfrmPedidoDeCompra.fValidaPerCof(blnBuscaPorChave: Boolean = True): Boolean;
Begin
  Result := True;

  If Not pnlImportacao.Visible Then
    Exit;

  If (Not blnConfDocumento) Then
  Begin
    If fEmptyStr(edtPerCof.Text) Then
    Begin
      edtPerCof.Text := '0,00';
    End
    Else If Not (InRange(fStrToFloat(edtPerCof.Text), 0, 100)) And
                (blnBuscaPorChave)                             Then
    Begin
      fMensagem('ATENÇÃO!', 'O percentual de Cofins deve estar entre 0 e 100!', ['&O k']);
      Result := False;
    End;
  End;
End;

function TfrmPedidoDeCompra.fValidaPerPis(blnBuscaPorChave: Boolean = True): Boolean;
Begin
  Result := True;

  If Not pnlImportacao.Visible Then
    Exit;

  If (Not blnConfDocumento) Then
  Begin
    If fEmptyStr(edtPerPis.Text) Then
    Begin
      edtPerPis.Text := '0,00';
    End
    Else If Not (InRange(fStrToFloat(edtPerPis.Text), 0, 100)) And
                (blnBuscaPorChave)                             Then
    Begin
      fMensagem('ATENÇÃO!', 'O percentual de PIS deve estar entre 0 e 100!', ['&O k']);
      Result := False;
    End;
  End;
End;

Function TfrmPedidoDeCompra.fEstaNaConsultaTab: Boolean;
Begin
  Result := Assigned(frmPedidoCompraItem);
End;

procedure TfrmPedidoDeCompra.pFechaCompraItem;
Begin
  If fEstaNaConsultaTab Then
   frmPedidoCompraItem.Close;
End;

procedure TfrmPedidoDeCompra.pIncluiNaListaConsulta;
  Var
    intRecNo: Integer;
    intIndice: Integer;
    strCodIte: String;
Begin
  If (Not Assigned(cdsItensPedido)) Or cdsItensPedido.IsEmpty Then
    Exit;

  strCodIte := cdsItensPedido.FieldByName('ITE_CODITE').AsString;
  If Not sltItems.Find(QuotedStr(strCodIte), intIndice) Then
    sltItems.Add(QuotedStr(strCodIte));

  If Assigned(cdsConsultaItem) And (Not cdsConsultaItem.IsEmpty) Then
  Begin
    With cdsConsultaItem Do
    Begin
      intRecNo := RecNo;
      If Locate('ITE_CODITE', strCodIte, []) Then
      Begin
        Edit;
        FieldByName('VENDIDO').AsInteger := 1;
        Post;
      End;
      RecNo := intRecNo;
    End;
  End;
End;

procedure TfrmPedidoDeCompra.pRetiraDaListaConsulta(strCodIte: String);
  Var
    intIndice: Integer;
Begin
  If sltItems.Find(QuotedStr(strCodIte), intIndice) Then
    sltItems.Delete(intIndice);

  If Assigned(cdsConsultaItem) And (Not cdsConsultaItem.IsEmpty) And
     (cdsConsultaItem.FieldByName('ITE_CODITE').AsString = strCodIte) Then
  Begin
    cdsConsultaItem.Edit;
    cdsConsultaItem.FieldByName('VENDIDO').Clear;
    cdsConsultaItem.Post;
  End;
End;


Function TfrmPedidoDeCompra.fCompraItem(cdsConsulta: TUniClientDataSet; DropControl: TControl; RectLinhaGrid: TRect): Boolean;
  Var
    blnSavCodFab: Boolean;
Begin
  Result := False;
  btnCancelaItem.Click;
  btnExcluir.Visible := False;
  blnSavCodFab := rdbCodFab.Checked;

  rdbCodIte.Visible := False;
  rdbCodFab.Visible := False;

  blnAtualizarPnlDadosItemModoTab := False;
  blnUtilizandoCompraItem := True;
  Try
    Try
      If cdsConsulta.IsEmpty Then
      Begin
        Exit;
      End;

      rdbCodIte.Checked := True;

      btnInsPla.Visible := False;

      cdsConsultaItem := cdsConsulta;

      edtCodIte.Text := cdsConsulta.FieldByName('ITE_CODITE').AsString;

      If cdsItensPedido.Locate('ITE_CODITE', edtCodIte.Text, []) Then
      Begin
        btnExcluir.Visible := True;
        blnAtualizarPnlDadosItemModoTab := True;
        pAtualizaDados(Nil);
        blnAtualizarPnlDadosItemModoTab := False;
      End;

      If fValidaItemExit Then
      Begin

        pCriarFormularios(TfrmPedidoCompraItem, frmPedidoCompraItem);

        frmPedidoCompraItem.dtsItensPedido.DataSet := dtsItensPedido.DataSet;
        frmPedidoCompraItem.winControl := ActiveControl;

        pnlItens.Parent := frmPedidoCompraItem;
        pnlItens.TabOrder := 0;
        pnlItens.BevelOuter := bvNone;
        frmPedidoCompraItem.fValidaCamposPedido := fValidaCampos;

        If mmoEmpGir.Visible Then
          frmPedidoCompraItem.Width := mmoEmpGir.Left + mmoEmpGir.Width + 15
        Else
          frmPedidoCompraItem.Width := edtValTot.Left + edtValTot.Width + 15;

        frmPedidoCompraItem.ClientHeight := pnlItensFixo.Height + frmPedidoCompraItem.pnlTotPed.Height + frmPedidoCompraItem.pnlStatus.Height;

        edtCodIte.ReadOnly := True;
        edtCodIte.TabStop  := False;

        frmPedidoCompraItem.ShowModal;

        pnlItens.BevelOuter := bvRaised;

        edtCodIte.ReadOnly := False;
        edtCodIte.TabStop  := True;

        pnlItens.Parent := pnlItensFixo;
        pFreeAndNil(frmPedidoCompraItem);

        Result := True;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmPedidoDeCompra.fCompraItem]');
      End;
    End;

  Finally

    cdsConsultaItem := Nil;

    btnInsPla.Visible  := True;
    btnExcluir.Visible := False;
    blnAtualizarPnlDadosItemModoTab := False;
    blnUtilizandoCompraItem := False;

    btnCancelaItem.Click;

    rdbCodIte.Visible := True;
    rdbCodFab.Visible := True;

    If blnSavCodFab Then
      rdbCodFab.Checked := True;

  End;

End;

procedure TfrmPedidoDeCompra.pTemItensDuplicados(strNumPed, strCodEmp, strEspDoc: string);
var qryConsulta: TUniQuery;
    frmLog: TfrmLog;
begin
 qryConsulta := fCriaQuery;
 try
   qryConsulta.SQL.Add('SELECT COUNT(1) AS QTD, CONCAT(PCD_CODITE, "-", PCD_DESITE) AS ITEM');
   qryConsulta.SQL.Add('  FROM PCMDET');
   qryConsulta.SQL.Add(' WHERE PCD_NUMPED = "'+strNumPed+'"');
   qryConsulta.SQL.Add('   AND PCD_CODEMP = "'+strCodEmp+'"');
   qryConsulta.SQL.Add('   AND PCD_ESPDOC = "'+strEspDoc+'"');
   qryConsulta.SQL.Add('   AND IFNULL(PCD_BAIXAD,0)  = 0');
   qryConsulta.SQL.Add('   AND PCD_NUMCTN = 0');
   qryConsulta.SQL.Add(' GROUP BY ITEM');
   qryConsulta.SQL.Add('HAVING QTD > 1');
   qryConsulta.Open;
   If qryConsulta.RecordCount > 0 Then
   Begin
     fRollBack();
     pCriarFormularios(TfrmLog, frmLog);
     frmLog.pAddLinha('Os itens encontrados nesta lista estão duplicados:');
     While Not qryConsulta.Eof Do
     Begin
       frmLog.pAddLinha(qryConsulta.FieldByName('ITEM').AsString);
       qryConsulta.Next;
     End;
     frmLog.Caption := 'inconsistência de dados.';
     frmLog.ShowModal;
     raise Exception.Create(cItensDuplicados);
   End;

 Finally
   FreeAndNil(qryConsulta);
 End;
end;

Function TfrmPedidoDeCompra.fCalculaTotalEmpresas(strItensPed: String; cdsItensMultiLojas: TUniClientDataSet;
           fltDesAceGer, fltValFreGer: Double;
           frmGravandoConfirmaPedido: TFrmGravando): Boolean;
  Var
    strUltEmp,
    strFieldNames: String;
    blnEstadoZonaFranca: Boolean;
    fltValFreRes, fltDesAceRes, fltTotIte, fltLitros, fltPesBruto: Double;
    aftPostMult: TDataSetNotifyEvent;

    Procedure pCalculaTotaisAfetadosPorFrete;
    Begin
      pRateiaFreteRegistro(fltValFreRes, fltDesAceRes,
                           fltValFreGer, fltDesAceGer,
                           cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTITE').AsFloat,
                           cdsItensMultiLojas);

      cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALFRE').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALFRE').AsFloat +
                                                             cdsItensMultiLojas.FieldByName('ITE_VALFRE').AsFloat;

      cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_DESACE').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_DESACE').AsFloat +
                                                             cdsItensMultiLojas.FieldByName('ITE_DESACE').AsFloat;

      cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTSUB').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTSUB').AsFloat +
                                                             cdsItensMultiLojas.FieldByName('ITE_TOTSUB').AsFloat;

      cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_SUBFCP').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_SUBFCP').AsFloat +
                                                             cdsItensMultiLojas.FieldByName('ITE_SUBFCP').AsFloat;

      cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_BASSUB').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_BASSUB').AsFloat +
                                                             cdsItensMultiLojas.FieldByName('ITE_BASSUB').AsFloat;

      cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_DESPIS').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_DESPIS').AsFloat +
                                                             cdsItensMultiLojas.FieldByName('ITE_DESPIS').AsFloat;

      cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_BASICM').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_BASICM').AsFloat +
                                                             cdsItensMultiLojas.FieldByName('ITE_BASICM').AsFloat;

      cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALICM').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALICM').AsFloat +
                                                             cdsItensMultiLojas.FieldByName('ITE_VALICM').AsFloat;

      cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALCBS').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALCBS').AsFloat +
                                                             cdsItensMultiLojas.FieldByName('ITE_VALCBS').AsFloat;

      cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALIBS').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALIBS').AsFloat +
                                                             cdsItensMultiLojas.FieldByName('ITE_VALIBS').AsFloat;

      cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VAL_IS').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VAL_IS').AsFloat +
                                                             cdsItensMultiLojas.FieldByName('ITE_VAL_IS').AsFloat;

      cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTGER').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTGER').AsFloat
                                                           + cdsItensMultiLojas.FieldByName('ITE_TOTITE').AsFloat
                                                           + cdsItensMultiLojas.FieldByName('ITE_TOTSUB').AsFloat
                                                           + cdsItensMultiLojas.FieldByName('ITE_TOTIPI').AsFloat
                                                           + fTotalImpostosReformaItem(cdsItensMultiLojas)
                                                           - IIF(blnEstadoZonaFranca,
                                                               (cdsItensMultiLojas.FieldByName('ITE_VALICM').AsFloat +
                                                                cdsItensMultiLojas.FieldByName('ITE_DESPIS').AsFloat), 0);
    End; {pCalculaTotaisAfetadosPorFrete;}

Begin
  cdsDigMultLoja.cdsTotalEmpresas.EmptyDataSet;

  fltValFreRes := fltValFreGer;
  fltDesAceRes := fltDesAceGer;

  blnEstadoZonaFranca := fEhEstadoRegraZonaFranca(fCadEmp('ESTADO'));

  aftPostMult := cdsItensMultiLojas.AfterPost;

  cdsItensMultiLojas.AfterPost := Nil;

  With cdsItensMultiLojas Do
  Try
    strFieldNames := IndexFieldNames;
    Filter   := 'ITE_QTDITE > 0 AND ITE_CODITE IN (' + strItensPed + ')';
    IndexFieldNames := 'ITE_CODEMP';
    Filtered := True;

    frmGravandoConfirmaPedido.lblGravando.Caption := 'Totalizando empresas...';
    frmGravandoConfirmaPedido.pgbStatus.Properties.Max := RecordCount;
    frmGravandoConfirmaPedido.pgbStatus.Position := 0;

    First;
    While Not Eof Do
    Begin
      If cdsDigMultLoja.cdsTotalEmpresas.IsEmpty Or
         (cdsDigMultLoja.cdsTotalEmpresas.FieldByName('CODEMP').AsString <> cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString) Then
      Begin

        If Not cdsDigMultLoja.cdsTotalEmpresas.FindKey([cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString]) Then
        Begin
          cdsDigMultLoja.cdsTotalEmpresas.Insert;
          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('CODEMP').AsString := cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString;
          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTIPI').AsFloat := 0;
          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTSUB').AsFloat := 0;
          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTITE').AsFloat := 0;
          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTGER').AsFloat := 0;
          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_BASCOF').AsFloat := 0;
          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALCOF').AsFloat := 0;
          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_BASPIS').AsFloat := 0;
          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALPIS').AsFloat := 0;
          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_BASICM').AsFloat := 0;
          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALICM').AsFloat := 0;
          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_BASIPI').AsFloat := 0;
          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_BASSUB').AsFloat := 0;
          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_DESPIS').AsFloat := 0;
          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALFRE').AsFloat := 0;
          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_DESACE').AsFloat := 0;
          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_SUBFCP').AsFloat := 0;
          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALCBS').AsFloat := 0;
          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALIBS').AsFloat := 0;
          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VAL_IS').AsFloat := 0;

          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_RATFRE').AsFloat := 0;
          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_RATACE').AsFloat := 0;

          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_LITROS').AsFloat := 0;
          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_PESLIT').AsFloat := 0;


          cdsDigMultLoja.cdsTotalEmpresas.Post;
        End;

      End;

      cdsDigMultLoja.cdsTotalEmpresas.Edit;

      cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTIPI').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTIPI').AsFloat +
                                                             cdsItensMultiLojas.FieldByName('ITE_TOTIPI').AsFloat;

      cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTITE').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTITE').AsFloat +
                                                             cdsItensMultiLojas.FieldByName('ITE_TOTITE').AsFloat;

      cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_BASCOF').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_BASCOF').AsFloat +
                                                             cdsItensMultiLojas.FieldByName('ITE_BASCOF').AsFloat;

      cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALCOF').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALCOF').AsFloat +
                                                             cdsItensMultiLojas.FieldByName('ITE_VALCOF').AsFloat;

      cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_BASPIS').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_BASPIS').AsFloat +
                                                             cdsItensMultiLojas.FieldByName('ITE_BASPIS').AsFloat;

      cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALPIS').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALPIS').AsFloat +
                                                             cdsItensMultiLojas.FieldByName('ITE_VALPIS').AsFloat;

      cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_BASIPI').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_BASIPI').AsFloat +
                                                             cdsItensMultiLojas.FieldByName('ITE_BASIPI').AsFloat;

      fltLitros := cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat *
                   fRetLitrosUnidade(cdsItensMultiLojas.FieldByName('ITE_CODUNI').AsString);

      If SameText(strLitGal, 'G') Then
        fltLitros := (fltLitros/ FLT_LITRO_GALAO);

      cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_LITROS').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_LITROS').AsFloat + fltLitros;


      fltPesBruto:= cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat *
                  fRetPesBru(cdsItensMultiLojas.FieldByName('ITE_CODITE').AsString);

      cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_PESLIT').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_PESLIT').AsFloat + fltPesBruto;


      If fltValFreGer + fltDesAceGer = 0 Then
        pCalculaTotaisAfetadosPorFrete;

      cdsDigMultLoja.cdsTotalEmpresas.Post;

      Next;

      frmGravandoConfirmaPedido.pgbStatus.Position := frmGravandoConfirmaPedido.pgbStatus.Position + 1;
      Application.ProcessMessages;
    End;

    If fltValFreGer + fltDesAceGer > 0 Then
    Begin
      frmGravandoConfirmaPedido.lblGravando.Caption := 'Calculando frete / despesas acessórias por produto...';
      frmGravandoConfirmaPedido.pgbStatus.Properties.Max := RecordCount;
      frmGravandoConfirmaPedido.pgbStatus.Position := 0;

      fltTotIte := 0;
      cdsDigMultLoja.cdsTotalEmpresas.First;
      While Not cdsDigMultLoja.cdsTotalEmpresas.Eof Do
      Begin
        fltTotIte := fltTotIte + cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTITE').AsFloat;
        strUltEmp := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('CODEMP').AsString;
        cdsDigMultLoja.cdsTotalEmpresas.Next;
      End;

      cdsDigMultLoja.cdsTotalEmpresas.First;
      While Not cdsDigMultLoja.cdsTotalEmpresas.Eof Do
      Begin
        cdsDigMultLoja.cdsTotalEmpresas.Edit;

        If strUltEmp = cdsDigMultLoja.cdsTotalEmpresas.FieldByName('CODEMP').AsString Then
        Begin
          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_RATFRE').AsFloat := fltValFreRes;
          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_RATACE').AsFloat := fltDesAceRes;
        End Else
        Begin
          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_RATFRE').AsFloat := RoundTo(fltValFreGer *
                   cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTITE').AsFloat / fltTotIte, -2);

          cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_RATACE').AsFloat := RoundTo(fltDesAceGer *
                   cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTITE').AsFloat / fltTotIte, -2);
        End;

        fltValFreRes := fltValFreRes - cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_RATFRE').AsFloat;
        fltDesAceRes := fltDesAceRes - cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_RATACE').AsFloat;

        If fltValFreRes  < 0 Then
          fltValFreRes := 0;

        If fltDesAceRes  < 0 Then
          fltDesAceRes := 0;

        cdsDigMultLoja.cdsTotalEmpresas.Post;

        cdsDigMultLoja.cdsTotalEmpresas.Next;
      End;

      strUltEmp := '';

      First;
      While Not Eof Do
      Begin

        If (cdsDigMultLoja.cdsTotalEmpresas.FieldByName('CODEMP').AsString = cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString) Or
            cdsDigMultLoja.cdsTotalEmpresas.FindKey([cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString]) Then
        Begin
          If strUltEmp <> cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString Then
          Begin
            fltValFreRes := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_RATFRE').AsFloat;
            fltValFreGer := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_RATFRE').AsFloat;
            fltDesAceRes := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_RATACE').AsFloat;
            fltDesAceGer := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_RATACE').AsFloat;

            strUltEmp := cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString;
          End;

          cdsDigMultLoja.cdsTotalEmpresas.Edit;

          pCalculaTotaisAfetadosPorFrete;

          cdsDigMultLoja.cdsTotalEmpresas.Post;
        End;

        Next;

        frmGravandoConfirmaPedido.pgbStatus.Position := frmGravandoConfirmaPedido.pgbStatus.Position + 1;
        Application.ProcessMessages;
      End;

    End;

  Finally
    cdsItensMultiLojas.AfterPost := aftPostMult;
    Filtered := False;
    IndexFieldNames := strFieldNames;
  End;

  Result := True;
End;

Function TfrmPedidoDeCompra.fAjustaDescricaoDosItensAux(pgbProgresso: TcxProgressBar): Boolean;
  var
    qryConsulta: TUniQuery;
    blnTabPrf: Boolean;
    pBeforePost: TDataSetNotifyEvent;
    strIndexName: String;
begin
  blnTabPrf := fCfgSis('TABPRF', varBoolean);
  qryConsulta := fCriaQuery;
  pBeforePost := cdsItensPedido.BeforePost;
  Try
    cdsItensPedido.DisableControls;
    strIndexName := cdsItensPedido.IndexFieldNames;
    cdsItensPedido.IndexFieldNames := '';
    cdsItensPedido.AfterScroll := Nil;
    cdsItensPedido.AfterPost   := Nil;
    cdsItensPedido.BeforePost  := Nil;
    pgbProgresso.Properties.Max := cdsItensPedido.RecordCount -1;
    pgbProgresso.Position := 0;
    Application.ProcessMessages;
    cdsItensPedido.First;
    qryConsulta.SQL.Add('SELECT');
    If (rdgDesPdi.Visible) And (rdgDesPdi.ItemIndex = 1) Then
      qryConsulta.SQL.Add(' IF(IFNULL(C.ITE_DESFAB, "") = "", C.ITE_DESITE, C.ITE_DESFAB) AS ITE_DESITE ')
    Else
      qryConsulta.SQL.Add(' IF((F.ITE_CODITE IS NULL) OR IFNULL(F.ITE_DESFAB, "") = "", C.ITE_DESITE, F.ITE_DESFAB) AS ITE_DESITE ');
    qryConsulta.SQL.Add('FROM CADITE C ');
    If blnTabPrf Then
    Begin
      qryConsulta.SQL.Add('  LEFT JOIN (SELECT * FROM ITEFOR F WHERE  F.ITE_CODFAB IS NOT NULL ');
      qryConsulta.SQL.Add('                  AND (SELECT COUNT(*) FROM TABPRE                  ');
      qryConsulta.SQL.Add('                        WHERE F.ITE_CODTAB = TAB_CODTAB AND' + fSqlWhereTabPre(strPrF_AE, recOpcGir.strCodTab) + ') > 0');
      qryConsulta.SQL.Add('    GROUP BY F.ITE_CODFAB) F ON F.ITE_CODITE = C.ITE_CODITE         ');
      qryConsulta.SQL.Add('                            AND F.ITE_CODFOR = "' + edtCodFor.Text + '"');
    End Else
    Begin
      qryConsulta.SQL.Add('  LEFT JOIN ITEFOR F ON F.ITE_CODITE = C.ITE_CODITE ');
      qryConsulta.SQL.Add('                    AND F.ITE_CODFOR = "' + edtCodFor.Text + '"');
      qryConsulta.SQL.Add('                  AND F.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF     ');
      qryConsulta.SQL.Add('                       WHERE FF.ITE_CODITE = C.ITE_CODITE AND ');
      qryConsulta.SQL.Add('                             FF.ITE_CODFOR = "' + edtCodFor.Text + '")');
    End;
    qryConsulta.SQL.Add('WHERE');
    qryConsulta.SQL.Add('  C.ITE_CODITE = :CODITE ');
    While not cdsItensPedido.Eof do
    begin
      qryConsulta.Close;
      qryConsulta.ParamByName('CODITE').AsString := cdsItensPedido.FieldByName('ITE_CODITE').AsString;
      qryConsulta.Open;
      cdsItensPedido.Edit;
      cdsItensPedido.FieldByName('ITE_DESITE').AsString := qryConsulta.FieldByName('ITE_DESITE').AsString;
      cdsItensPedido.Post;
      cdsItensPedido.Next;
      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;
    Result := True;
  Finally
    cdsItensPedido.EnableControls;
    cdsItensPedido.IndexFieldNames := strIndexName;

    cdsItensPedido.AfterScroll := pAferScroll;
    pAferScroll(cdsItensPedido);
    cdsItensPedido.AfterPost   := pAfterPost;
    cdsItensPedido.BeforePost  := pBeforePost;
    FreeAndNil(qryConsulta);
  End;
End;

procedure TfrmPedidoDeCompra.pAjustaAutoincremCdsMultiLoja_PREPTE;
begin
  If Assigned(frmPedidoDeCompra) Then
    If fCfgSis('LIBETE') <> '2' Then
    Try
      If Assigned(frmPedidoDeCompra.CdsDigMultLoja) Then
        If Assigned(TCdsDigMultLoja(frmPedidoDeCompra.CdsDigMultLoja).recOpcGir.objRecupera) Then
          If TRecuperaPedido(TCdsDigMultLoja(frmPedidoDeCompra.CdsDigMultLoja).recOpcGir.objRecupera).recPcmger.strPedMlj = 'S' Then
        Begin
            frmPedidoDeCompra.cdsDigMultLoja.objPreparaGerMultiLoja.AutincPedidoCompra := frmPedidoDeCompra.objCopiaSeg.recPcmger.strAutInc;
            frmPedidoDeCompra.cdsDigMultLoja.objPreparaGerMultiLoja.pAtualizaAutoincremPedido;
        End;
    Except
      pMensagensErro('Falha ao atualizar ID para as tranferências previamente programadas.', '[TfrmPedidoDeCompra.pAjustaAutoincremCdsMultiLoja_PREPTE]');
    End;
end;

procedure TfrmPedidoDeCompra.pAjustaDescricaoDosItens;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Alterando Decrição dos Itens do Pedido.';
    frmGravando.fExecutarAcao := fAjustaDescricaoDosItensAux;
    frmGravando.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmPedidoDeCompra.pAjustaDescricaoDosItens]');
    End;
  End;
  pFreeAndNil(frmGravando);
End;

procedure TfrmPedidoDeCompra.pAjustarRadioGroupCodigoFabricaProduto;
begin
  rdgCodigoFabricaProduto.Visible := blnPermitirCompradorEscolherCodigoFabrica;

  If rdgCodigoFabricaProduto.Visible Then
    Exit;

  pnlGeral.Height := pnlGeral.Height - rdgCodigoFabricaProduto.Height;
end;

procedure TfrmPedidoDeCompra.pCarregarItensLista;
Begin
  Try
    cdsItensPedido.First;
    While Not cdsItensPedido.Eof Do
    Begin
      pIncluiNaListaConsulta;
      cdsItensPedido.Next;
    End;
  Finally
    cdsItensPedido.First;
  End;
End;

procedure TfrmPedidoDeCompra.ProcessaStatusPedidoRequisicaoPedidoCompra(ASeqPCMGER: String);
  Var
    qryRequis: TUniQuery;
begin
  qryRequis := fCriaQuery;
  try
    qryRequis.Sql.Add('SELECT DISTINCT FATGOR.FGO_NUMDOC, FATGOR.FGO_ESPDOC, FATGOR.FGO_CODEMP, FATGOR.FGO_CODCLI FROM  PCMGER');
    qryRequis.Sql.Add('  INNER JOIN PCMDET ON PCD_NUMPED = PCG_NUMPED');
    qryRequis.Sql.Add('                   AND PCD_CODEMP = PCG_CODEMP');
    qryRequis.Sql.Add('                   AND PCD_ESPDOC = PCG_ESPDOC');
    qryRequis.Sql.Add('                   AND PCD_NUMCTN = PCG_NUMCTN');
    qryRequis.Sql.Add(' INNER JOIN MOVRCD ON RCD_SEQPCD = PCMDET.AUTOINCREM');
    qryRequis.Sql.Add(' INNER JOIN FATGOR ON FGO_NUMDOC = RCD_DOCPDV AND FGO_CODEMP =  RCD_EMPPDV AND FGO_ESPDOC = RCD_ESPPDV');
    qryRequis.Sql.Add(' WHERE PCMGER.AUTOINCREM = "'+ASeqPCMGER+'"');

    qryRequis.Open;

    while not qryRequis.Eof do
    Begin
      TUpdateStatus.New(TParamStatus.New()
                              .NumDoc(qryRequis.FieldByName('FGO_NUMDOC').AsString)
                              .EspDoc(qryRequis.FieldByName('FGO_ESPDOC').AsString)
                              .CodEmp(qryRequis.FieldByName('FGO_CODEMP').AsString)
                              .CodCli(qryRequis.FieldByName('FGO_CODCLI').AsString)).pExecute();
      qryRequis.Next;
    End;
  finally
    FreeAndNil(qryRequis)
  End;
end;


{ TRecValidadorCmpMlt }

constructor TRecValidadorCmpMlt.Create(pstrCMPMLT: String);
begin
  Self.FstrCMPMLT := pstrCMPMLT;
  Self.pInicializar;
end;

function TRecValidadorCmpMlt.fLiberado(pstrCodIte: String; pfltQtdIte, pfltMltCom: Double; pblnLibSen: Boolean = True): Boolean;
  Var
    lblnAlterado: Boolean;
begin
  If AnsiIndexText(Self.FstrCmpMlt,['S','T','A']) = -1 Then
    Exit(True);

  lblnAlterado := (pstrCodite <> Self.FstrCodIte) or (pfltQtdIte <> Self.FfltQtdIte) or (pfltMltCom <> Self.ffltMltCom);

  if lblnAlterado then
  begin
    Self.pInicializar;
    Self.FstrCodIte := pstrCodIte;
    Self.FfltQtdIte := pfltQtdIte;
    Self.FfltMltCom := pfltMltCom;
  end;

  Result := Self.FblnLiberado and (Not lblnAlterado);

  if Result then
    Exit;

  If pfltMltCom <= 0 Then
   Self.ffltMltCom := 1
  else
    Self.ffltmltcom := pfltMltCom;

  If (AnsiIndexText(Self.FstrCmpMlt,['S','T']) >= 0) AND lblnAlterado Then
    pMensagemOk('Quantidade permitida somente em múltiplos de compra (' + FormatFloat('#0.00', Self.ffltMltCom)  + ')!');

  If (Self.FstrCmpMlt = 'T') Then
  begin
    if pblnLibSen then
    begin
      Self.FblnLiberado := fLiberaQuantidadeMultiplos(pstrCodIte);
      Result := Self.FblnLiberado;
    end
    else
      Result := True;
  end
  else If (Self.FstrCmpMlt = 'A') Then
  begin
    Self.FblnLiberado := True;
    Result := True;
    if lblnAlterado then
      pMensagemOk('Quantidade esta fora do múltiplos de compra (' + FormatFloat('#0.00', Self.ffltMltCom)  + ')!');
  end;

  if Not Result then
    Self.pInicializar;
end;

procedure TRecValidadorCmpMlt.pInicializar;
begin
  Self.FstrCodIte := EmptyStr;
  Self.FfltQtdIte := 0.0000;
  Self.FfltMltCom := 0.0000;
  Self.FblnLiberado := False;
end;

{ TRecDescontoItem }

constructor TRecDescontoItem.Create(pDesAdi: Double; pDecUni: Integer);
begin
  Self.pInicializar;
  Self.fltDesAdi := pDesAdi;
  Self.intDecUni := pDecUni;
end;

function TRecDescontoItem.fCalcularFatorDesconto(ASomaDescontoAdicionaFornec1: Boolean): Double;
  Var
    fltPercentualDesconto: Double;
begin
  fltPercentualDesconto := Self.fCalcularPercentualDesconto(ASomaDescontoAdicionaFornec1);
  Result := (1 - (fltPercentualDesconto/100));
end;

function TRecDescontoItem.fCalcularPercentualDesconto(ASomaDescontoAdicionaFornec1: Boolean): Double;
begin
  If ASomaDescontoAdicionaFornec1 Then
    Result := ((1 - (Self.arrDesUni[DESCONTO1] + Self.fltDesAdi)/100) *
               (1 - Self.arrDesUni[DESCONTO2]/100) *
               (1 - Self.arrDesUni[DESCONTO3]/100) *
               (1 - Self.arrDesUni[DESCONTO4]/100) *
               (1 - Self.arrDesUni[DESCONTO5]/100) *
               (1 - Self.arrDesUni[DESCONTO6]/100))
  Else
    Result := ((1 - Self.arrDesUni[DESCONTO1]/100) *
               (1 - Self.arrDesUni[DESCONTO2]/100) *
               (1 - Self.arrDesUni[DESCONTO3]/100) *
               (1 - Self.arrDesUni[DESCONTO4]/100) *
               (1 - Self.arrDesUni[DESCONTO5]/100) *
               (1 - Self.arrDesUni[DESCONTO6]/100) *
               (1 - Self.fltDesAdi/100));

  Result := (1 - Result) * 100;
  Result := RoundTo(Result, -intDecUni);
end;

function TRecDescontoItem.fCalcularValorDescontado(ASomaDescontoAdicionaFornec1: Boolean; pValorNominal: Double): Double;
  Var
    lFator: Double;
begin
  lFator := Self.fCalcularFatorDesconto(ASomaDescontoAdicionaFornec1);
  Result := pValorNominal * lFator;
end;



procedure TRecDescontoItem.pInicializar;
begin
  Self.fltDesAdi := 0;
  Self.intDecUni := 2;
  Self.arrDesUni[DESCONTO1] := 0;
  Self.arrDesUni[DESCONTO2] := 0;
  Self.arrDesUni[DESCONTO3] := 0;
  Self.arrDesUni[DESCONTO4] := 0;
  Self.arrDesUni[DESCONTO5] := 0;
  Self.arrDesUni[DESCONTO6] := 0;
end;

procedure TfrmPedidoDeCompra.cxvItensTIPABSGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If (AText = 'C') Then
    AText := 'Compra fábrica'
  Else If (AText = 'T') Then
    AText := 'Transferência'
  Else If (AText = 'A') Then
    AText := 'Ambos';
end;

procedure TfrmPedidoDeCompra.cxvItensVNOLCDGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  if AText = 'S' then
    AText := 'Sim'
  else if AText = 'N' then
    AText := 'Não';
end;

end.


