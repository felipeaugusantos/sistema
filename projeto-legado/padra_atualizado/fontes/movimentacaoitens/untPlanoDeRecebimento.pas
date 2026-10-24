unit untPlanoDeRecebimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Vcl.Mask, MaskEditFocus, cxGraphics, Uni, untHelperCitel,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, StrUtils, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCitel, cxClasses, cxGridLevel, cxGrid, untZClient, dxGDIPlusClasses,
  cxButtonEdit, System.ImageList, Vcl.ImgList, cxProgressBar, Datasnap.DBClient,
  UniClientDataSet, Vcl.Grids, Vcl.DBGrids, cxImageComboBox,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxImageList, System.Math,
  cxCalc, untTLock, cxDropDownEdit, cxCheckBox, untDigQuantidade, cxCurrencyEdit,
  cxTextEdit, untItensSemMapPlanoDeRecebimento, System.UITypes, untTSugestaoLocalizacaoFisica,
  untMensagemExplicativa;

type
  TcxPainterAccess = class(TcxGridTableDataCellPainter);
  TcxViewInfoAcess = class(TcxGridTableDataCellViewInfo);
  TTipoValidacaoItem = (tvAmbos, tvAtiCom, tvIteAti);
  TfrmPlanoDeRecebimento = class(TfrmPaiConfirma)
    cdsLocSug: TUniClientDataSet;
    cdsLocSugCHAVE: TStringField;
    cdsLocSugLOCFIS: TStringField;
    cdsLocSugDTAVAL: TDateField;
    cdsLocSugQTDITE: TFloatField;
    cdsLocSugQTDVEN: TFloatField;
    dtsLocSug: TDataSource;
    lblPesquisa: TLabel;
    cdsLocSugENDERE: TStringField;
    cxImageList1: TcxImageList;
    popReimpressao: TPopupMenu;
    ReimprimirEtiqueta1: TMenuItem;
    cdsLocSugAUTINC: TStringField;
    cxImageList2: TcxImageList;
    btnImprimir: TBitBtnLocked;
    btnDesmembra: TBitBtnLocked;
    cdsLocSugBUFVEN: TStringField;
    cdsLocSugFISPIC: TStringField;
    btnAlterar: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    cdsLocSugEXCESS: TBooleanField;
    cdsLocSugSELECE: TBooleanField;
    btnImprimirMaisEtiqID: TBitBtnLocked;
    cdsLocSugABPICK: TStringField;
    dtsEtiquetas: TDataSource;
    pnlContainer: TPanel;
    pnlTopo: TPanel;
    lbl1: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    lblConferido: TLabel;
    edtPlaca_: TMaskEditFocus;
    edtIdeDig: TEditFocus;
    edtDtaRec: TEditFocus;
    edtCodOpe: TEditFocus;
    edtNomOpe: TEditFocus;
    edtNomMot: TEditFocus;
    edtConferido: TEditFocus;
    pnlGridsPlano: TPanel;
    sptSplitter: TSplitter;
    pnlEtiquetasID: TPanel;
    cxgEtiqueta: TcxGridCitel;
    cxgEtiquetaTableView: TcxGridDBTableViewCitel;
    cxgEtiquetaTableViewCHAVE: TcxGridDBColumn;
    cxgEtiquetaTableViewCODBAR: TcxGridDBColumn;
    cxgEtiquetaTableViewCODITE: TcxGridDBColumn;
    cxgEtiquetaTableViewDESITE: TcxGridDBColumn;
    cxgEtiquetaTableViewCODUN: TcxGridDBColumn;
    cxgEtiquetaTableViewQTDITE: TcxGridDBColumn;
    cxgEtiquetaTableViewSTATUS: TcxGridDBColumn;
    cxgEtiquetaTableViewID: TcxGridDBColumn;
    cxgEtiquetaTableViewLOCFIS: TcxGridDBColumn;
    cxgEtiquetaLevel1: TcxGridLevel;
    pnlTituloEtiquetas: TPanel;
    lblTituloPainelEtiquetas: TLabel;
    pnlLegendas: TPanel;
    chkGerCob: TCheckBox;
    pnlLegendaConferencia: TPanel;
    pnlCtrlModCub: TPanel;
    btnCubAut: TBitBtnLocked;
    btnCubMan: TBitBtnLocked;
    chkRepModCubTodos: TCheckBox;
    btnCubReset: TBitBtnLocked;
    btnProcCub: TBitBtnLocked;
    cdsLocSugPICKNG: TStringField;
    pnlGridSuperior: TPanel;
    Splitter1: TSplitter;
    cxgItens: TcxGridCitel;
    cxgItensTableView: TcxGridDBTableViewCitel;
    cxgItensTableViewMODCUB: TcxGridDBColumn;
    cxgItensTableViewCONFER: TcxGridDBColumn;
    cxgItensTableViewLEGEND: TcxGridDBColumn;
    cxgItensTableViewCODITE: TcxGridDBColumn;
    cxgItensTableViewDESITE: TcxGridDBColumn;
    cxgItensTableViewQTDITE: TcxGridDBColumn;
    cxgItensTableViewQTDUNI: TcxGridDBColumn;
    cxgItensTableViewQTDCON: TcxGridDBColumn;
    cxgItensTableViewQTDEND: TcxGridDBColumn;
    cxgItensTableViewNIVGIR: TcxGridDBColumn;
    cxgItensTableViewCLASSE: TcxGridDBColumn;
    cxgItensTableViewCXCAMA: TcxGridDBColumn;
    cxgItensTableViewQTCAMA: TcxGridDBColumn;
    cxgItensTableViewQTDETI: TcxGridDBColumn;
    cxgItensTableViewIMPETI: TcxGridDBColumn;
    cxgItensTableViewEXCEDE: TcxGridDBColumn;
    cxgItensTableViewQTDITE_POR_ETIQUETA: TcxGridDBColumn;
    cxgItensTableViewSELECE: TcxGridDBColumn;
    cxgItensLevel: TcxGridLevel;
    pnlGridsPlanoSuge: TPanel;
    cxgSugestao: TcxGridCitel;
    cxgSugestaoTableView: TcxGridDBTableViewCitel;
    cxgSugestaoTableViewEndere: TcxGridDBColumn;
    cxgSugestaoTableViewABPICK: TcxGridDBColumn;
    cxgSugestaoTableViewSELECE: TcxGridDBColumn;
    cxgSugestaoTableViewLocFis: TcxGridDBColumn;
    cxgSugestaoTableViewDtaVal: TcxGridDBColumn;
    cxgSugestaoTableViewQtdIte: TcxGridDBColumn;
    cxgSugestaoTableViewQtdVen: TcxGridDBColumn;
    cxgSugestaoTableViewBufVen: TcxGridDBColumn;
    cxgSugestaoTableViewFISPIC: TcxGridDBColumn;
    cxgSugestaoTableViewEXCESS: TcxGridDBColumn;
    cxgSugestaoLevel1: TcxGridLevel;
    pnlLegendaLocalSeparacao: TFlowPanel;
    pnlEnderecado: TPanel;
    Label7: TLabel;
    imgEndere: TImage;
    Panel1: TPanel;
    imgNaoEnd: TImage;
    Label6: TLabel;
    pnlEndPar: TPanel;
    imgSepPar: TImage;
    lblSepPar: TLabel;
    pnlLocalizacao: TPanel;
    shpMsgDtaVal: TShape;
    lblMsgDtaVal: TLabel;
    Panel4: TPanel;
    shpMsgLocExc: TShape;
    lblMsgLocExc: TLabel;
    pnlAbastecer: TPanel;
    lblLegAbPick: TLabel;
    shpAbPick: TShape;
    Panel2: TPanel;
    chkAllPick: TCheckBox;
    cdsLocSugCODITE: TStringField;
    Image1: TImage;
    Label8: TLabel;
    Image2: TImage;
    Label9: TLabel;
    Image3: TImage;
    Label10: TLabel;
    lblLegNaoLocalizado: TLabel;
    shpRed: TShape;
    Label4: TLabel;
    shpImpresso: TShape;
    cxgEtiquetaTableViewQTDEMB: TcxGridDBColumn;
    cdsLocSugQTDEMB: TFloatField;
    pnlBotoesEtiquetas: TPanel;
    lblLegIDFechada: TLabel;
    shpIDFechada: TShape;
    shpLegEtiqFechada: TShape;
    lblLegEtiqEnderecada: TLabel;
    btnLimparEtiqueta: TBitBtnLocked;
    btnTirarProduto: TBitBtnLocked;
    btnSugerirLocFisica: TBitBtnLocked;
    btnReimprimirEtiqueta: TBitBtnLocked;
    btnAtualizarEtiqueta: TBitBtnLocked;
    btnLimparLocFisica: TBitBtnLocked;
    cxgSugestaoTableViewCODITE: TcxGridDBColumn;
    cxgSugestaoTableViewDESITE: TcxGridDBColumn;
    cdsLocSugDESITE: TStringField;
    Bevel2: TBevel;
    pnlPlanoJaFinalizado: TPanel;
    lblPlanoFinalizado: TLabel;
    cxgEtiquetaTableViewNIVGIR: TcxGridDBColumn;
    cxgItensTableViewCODUNI: TcxGridDBColumn;
    cxgItensTableViewABPICK: TcxGridDBColumn;
    cdsLocSugLOCTIPO: TStringField;
    cxgSugestaoTableViewLOCTIPO: TcxGridDBColumn;
    lblAtualizarSugestoes: TLabel;
    lblExpandirRecolherEtiquetasID: TLabel;
    cxgItensTableViewEMBREC: TcxGridDBColumn;
    cxgSugestaoTableEMBREC: TcxGridDBColumn;
    cdsLocSugEMBREC: TFloatField;
    cdsLocSugSEQUEN: TIntegerField;
    shpClaPic: TShape;
    lblClaPic: TLabel;
    shpPicExc: TShape;
    lblPicExc: TLabel;
    cxgItensTableViewCLA_CHEEXC: TcxGridDBColumn;
    Image4: TImage;
    Label11: TLabel;
    cdsLocSugTOTSUG: TAggregateField;
    
    procedure FormCreate(Sender: TObject);
    procedure cxgItensTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
    function fLocalizacaPiking(AStrLocFis: String): Boolean;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtPlaca_KeyPress(Sender: TObject; var Key: Char);
    procedure edtIdeDigKeyPress(Sender: TObject; var Key: Char);
    procedure btnDesmembraClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxgSugestaoTableViewKeyPress(Sender: TObject; var Key: Char);
    procedure cxgSugestaoEnter(Sender: TObject);
    procedure cxgSugestaoExit(Sender: TObject);
    procedure ReimprimirEtiqueta1Click(Sender: TObject);
    function fRetTabelaPreco(strCodCli, strCodVen: String): String;
    procedure pDefineAliquotaIss(strCodCli, strCodCid, strCodSer: String; var fltPerIss: Double; var fltRedIss: Double);

    procedure cxgItensTableViewQTDCONPropertiesEditValueChanged(
      Sender: TObject);
    procedure cxgItensTableViewEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure btnImprimirClick(Sender: TObject);
    procedure cxgSugestaoTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure cxgItensTableViewEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure cxgItensTableViewFocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxgItensTableViewEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCubAutClick(Sender: TObject);
    procedure btnCubManClick(Sender: TObject);
    procedure btnCubResetClick(Sender: TObject);
    procedure btnProcCubClick(Sender: TObject);
    procedure cxgItensTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgItensTableViewMODCUBGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure btnImprimirMaisEtiqIDClick(Sender: TObject);
    procedure cxgItensTableViewABPICKGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxgSugestaoTableViewABPICKGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cdsLocSugBeforePost(DataSet: TDataSet);
    procedure cxgSugestaoTableViewLocFisCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgSugestaoTableViewABPICKCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnAtualizarEtiquetaClick(Sender: TObject);
    procedure btnReimprimirEtiquetaClick(Sender: TObject);
    procedure btnLimparEtiquetaClick(Sender: TObject);
    procedure btnTirarProdutoClick(Sender: TObject);
    procedure btnSugerirLocFisicaClick(Sender: TObject);
    procedure cxgEtiquetaTableViewFocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxgEtiquetaTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnLimparLocFisicaClick(Sender: TObject);
    procedure cxgEtiquetaTableViewKeyPress(Sender: TObject; var Key: Char);
    procedure cdsLocSugAfterPost(DataSet: TDataSet);
    procedure chkAllPickClick(Sender: TObject);
    procedure cxgSugestaoTableViewCanFocusRecord(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; var AAllow: Boolean);
   procedure cdsSugestAfterScroll(DataSet: TDataSet);
    procedure Splitter1Moved(Sender: TObject);
    procedure cxgItensTableViewQTDCONCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgEtiquetaTableViewCanFocusRecord(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; var AAllow: Boolean);
    procedure sptSplitterMoved(Sender: TObject);
    procedure lblAtualizarSugestoesClick(Sender: TObject);
    procedure lblExpandirRecolherEtiquetasIDClick(Sender: TObject);


  private
    FFalha: String;
    blnSugestaoViaBanco: Boolean;
    intESTFLJ : integer;
    cdsItens : TZClient;
    blnSuprimirMsgEtiquetasID: Boolean;
    blnSugerirPicking: Boolean;
    qryDigVal,
    qryEtique,
    qryItensCubAutSemSug,
    qryTotalPalet,
    qryLocFis,
    qryClasse: TUniQuery;
    FqryConsulta: TUniQuery;
    blnTemImpressao,
    blnAlterando: Boolean;
    blnPlanoJaConfirmado: Boolean;
    blnModCub: Boolean;
    blnPriPik: Boolean;
    blnClaPic: Boolean;
    blnColVal : Boolean;
    blnProcessandoCubagem: Boolean;
    stlLocSel : TStringList;
    stlLocSelSemPicking : TStringList;
    stlLocExcSelecionados: TStringList;
    objLock   : TLock;
    objSugLoc: TSugestaoLocalizacaoFisica;
    blnSugereLocalizacao : Boolean;
    FBlnReabrindoPlanoPelaConfirmacao: Boolean;
    intNumSelecParaCubagem: Integer;
    strItensSemPaletsCadastrado: String;
    strIdeDig: String;
    strIdeDigBkp: String;
    strAdcSeqGer: String;
    qryPicking: TUniQuery;
    blnTodasModCubPreenchidas,
    blnRestaurouDaAgeilo,
    blnTemCubagemAutomatica,
    blnTemCubagemManual,
    blnCarregandoPlano,
    blnConfirmacaoPelaImpressao,
    blnApenasRecarregaAgeilo,
    blnAgrupado: Boolean;
    blnNotasDeTransfApenasManual: Boolean;
    blnvalidouSeConverte: Boolean;
    blnValidaSeConverte: Boolean;
    FTipoValidaItem: TTipoValidacaoItem;
    blnImprimeEtqAntesConfer: Boolean;
    blnTrvSug: Boolean;
    blnEtqCon: Boolean;
    procedure pReplicarValorClasse(AClasse: String);
    procedure pSetarModoCubagem(ABlnAutomatica, ABlnTodos, ABlnResetar: Boolean);
    procedure pProcessarCubagem;
    procedure pSelecionarParaCubagem;
    procedure pImprimirEtiquetasPadrao;
    procedure pImprimirEtiquetasCubagemAutomaticaOuManual(AStrModCub: String; ABlnDefinirQtd: Boolean = False; AtualizaDados: Boolean = True);
    function fCriaCdsEtiquetasID(AIntNumEtiquetasID: Integer; AStrID: String = ''; AStrLocFis: String = ''): TUniClientDataSet;
    procedure pSalvarEtiquetasID(ACdsEtiquetas: TUniClientDataSet);
    function fProcessarEtiquetasIDAux(pgbProgresso: TCxProgressBar): Boolean;
    procedure pProcessarEtiquetasID;
    function fGetSQLEtiquetasID: String;
    function fRetSumAgeilo(AField: String): String;

    procedure pReImprimirEtiquetaID(AStrID: String; ABlnDefinirQtd: Boolean = False; AStrLocFis: String = '');
    procedure pAtualizarLocFisicaEtiquetaID(AStrLocFis: String);
    function fTemEtiquetaSendoBipada: Boolean;
    function fQtdItensDistintosEtiquetaID(AStrID: String): Integer;
    function fPodeExibirPainelCtrModCub: Boolean;
    function fSugerirLocFisicaEtiquetaID: String;
    function fGetLocFisicaVazia: String;
    procedure pAtualizarLocFisEtiquetaID(AStrLocFis: String);
    function fLocExcJaSelecionada(AStrChave: String): Boolean;
    procedure pHabilitarBotoes(ABlnHabilitar: Boolean = True);
    procedure pLimparPreRessuprimento;
    function fPossuiEtiquetasIDEnderecadas: Boolean;
    function fTemQueGravarParaImprimir: Boolean;
    procedure pAtualizarSugestoes;
    procedure pAjustarPaineis;
    procedure pCarregaDefinicoesCubagem(var qtdCubagemManual: integer;
                                        var qtdCubagemAutomatica: integer;
                                        var qtdSemCubagem: integer;
                                        var qtdTotalReg: integer;
                                        var qtdRegComPiking: integer;
                                        blnFiltraSugestaoPiking: Boolean = False);
    function fGetItensPlano: String;
    function fValidaMapeamentoDeLocalizacoes: Boolean;
    function fGetQtdItensSemCubagem: Integer;
    function fGetSQLQuantidades(ABlnABPICK: Boolean): String;
    function fHaItensSemMapeamento: Boolean;
    function fAjustarPaineisAux(pgbProgresso: TCxProgressBar): Boolean;
    function fRetClasseCheiaOuVaiExceder: String;
    function fGetSQLClasseClaPic(ABblnAbPick: Boolean): String;
    function fGetSQLDET_QTDITE(ABlnAbPick: Boolean): String;
    function fTemItemCubAutomaticaSemSugestao: Boolean;
    procedure pMostraItensCubAutomaticaSemSugestao;
    function fPlanoMultIdeDig: Boolean;
    function fCampoExiste(ATabela, ACampo: String): Boolean;
    function fValidarCamposCadIte(var strFalha: String): Boolean;

    const WM_GO_TO_CONSULTA = WM_APP + 501;

    function fGetSQL : String;
    function fGetSQLTriEmbala: String;
    function fMostraItens(strCodigo: String; AblnCarregandoPlano: Boolean; AblnAtualizandoPlano: Boolean = False; AblnVindoDoMapeamento: Boolean = False):Boolean;
    function fTemCubagemManual: Boolean;

    procedure pGetQtdeMaxPallet(strCodIte, strSigla: String; var intCxCama, intQtCama, intQtdTot : Integer);
    procedure pOnDataChangeClasse(Field : TField);
    procedure pBeforePost(DataSet: TDataSet);
    procedure pResetTela;
    function fEfetivaMovFiscal(cxProgressBar: TcxProgressBar): Boolean;
    function fVerificaItensConfiguradosPalets(strSeq: String; var strErro: string): Boolean;
    procedure pGeraTotalPalet(strSeqGer: string);
    function fGeraCobrancaDePalett(var strErro: String): Boolean;
    function fCalculaSugestaoLocalizacaoFisicas(cxProgressBar: TcxProgressBar): Boolean;
    procedure pFiltraSugestaoCds(DataSet: TDataSet);
    procedure pAfterPostItens(DataSet: TDataSet);
    function fValidaLocalSelecionado(strLocFis : String): Boolean;
    function fValidaClassedeLocalOuLocalizacaoFisica: Boolean;
    function fTodoPlanoEnderecado(strIdeDig: String): Boolean;
    function fPossuiEnderecamento(strIdeDig: String): Boolean;
    procedure pCancelarPlano(strDigIde: String);
    procedure pAtualizarPlano;
    function fQtdeEtiquetas: Boolean;
    function fGetClasseDeLocalDoLote(strCodIteP, strNumLotP: String): String;
    function fPreencheClasseDeLocalParaProdutosComLoteDefinidosNaEntradaSimplificada: Boolean;
    procedure pPopularComboBoxClasses(strCodIte: String);
    function fQuantidadePickin(strCodIte: String = ''; saiAoEncontrar: Boolean = false; blnRemoveFilter: Boolean = False): Double;
    function fTemSugestao: Boolean;
    function fPlanoComEtiquetaPickingJaEnderecada(AStrIdeDig: String): Boolean;
    function fPossuiDevolucaoCompra: Boolean;
    function fAtualizaEstoque(strCodIte: String; fltQtdIte: Double; strEntSai, strNumLot, strEspecie: String; blnFutLot: Boolean = False): Boolean;
    procedure pEstornaPedidoCompra(strAutIncMovDet: String; strNumDoc, strEspDoc, strCodEmp, strCodFor, strSerDoc, AstrPEDCOM, AstrEMPCOM, strCODITE: String; fltQTDITE: Double; Var AstlPedCom, AAstlPedComAux: TStringList);
    function fVerificaSeFicarSaldoNegativoItens(AstrDigIde: String; out strMensagemItensSaldoNegativo: String): Boolean;
  protected
    procedure msgAbreConsulta(var Msg: TMessage); message WM_GO_TO_CONSULTA;
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean) : Boolean; Override;
  published
    function fValidacampoExterno(Sender : TWinControl; blnBuscaPorChave : Boolean): Boolean;
  public
    blnConfirmacaoAutomatica: Boolean;
    property strFalha: String read FFalha;
    property tipValItem: TTipoValidacaoItem read FTipoValidaItem Write FTipoValidaItem;
    function fValidaAgeite(Aidedig: string): Boolean;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, untConsultas, TypesRel,
  untFuncoesEtiquetas, untGravando, {untEfetivaMovimentoFiscal,}
  untPlanoDeRecebimentoDesmembra, untEfetivaMovimentoFiscal,
  untPanelCxClasseLocal, untPnlDadosClasseLocal, untLiberacao, untCadLote,
  untCadLoteItens, untCadClasseLocFis, untFatGor, untAtualizaOcorrenciasCRM, untFuncoesCRM, untTypesCRM, untFuncoes,
  untTLog, untConstantes, untModulo, untDefineBaixaPedido,
  untSaldoPedidoCompra;

{ TfrmPlanoDeRecebimento }

procedure TfrmPlanoDeRecebimento.btnAlterarClick(Sender: TObject);
begin
  inherited;
  btnConfirma.Enabled := True;

  btnAlterar.Enabled  := False;
  blnAlterando := True;

  if cxgItensTableViewCLASSE.Visible then
    cxgItensTableViewCLASSE.Options.Editing := True;

  if cxgItensTableViewQTDCON.Visible then
    cxgItensTableViewQTDCON.Options.Editing := True;

  if blnModcub Then
  Begin
    btnConfirma.Enabled := blnTodasModCubPreenchidas;
    btnImprimirMaisEtiqID.Enabled := blnAlterando And blnTemCubagemManual;
  End;

  pSetFocus(cxgItens);
  btnConfirma.Caption := '&Atualizar';

  pHabilitarBotoes;
end;

procedure TfrmPlanoDeRecebimento.pHabilitarBotoes(ABlnHabilitar: Boolean = True);
begin
  btnCubMan.Enabled := ABlnHabilitar;
  btnCubAut.Enabled := ABlnHabilitar;
  btnCubReset.Enabled := ABlnHabilitar;
  btnProcCub.Enabled := ABlnHabilitar;
end;

procedure TfrmPlanoDeRecebimento.btnAtualizarEtiquetaClick(Sender: TObject);
begin
  inherited;
  pProcessarEtiquetasID;
  pAtualizarSugestoes;
end;

procedure TfrmPlanoDeRecebimento.pAtualizarSugestoes;
var
  blnChecked: Boolean;
begin
  blnChecked := chkAllPick.Checked;
  chkAllPick.Checked := False;
  Try
    pCriarFormularios(TfrmGravando, frmGravando);

    blnApenasRecarregaAgeilo := cdsItens.FieldByName('MOVEFE').AsString = 'S';
    cdsLocSug.EmptyDataSet;

    frmGravando.fExecutarAcao := fCalculaSugestaoLocalizacaoFisicas;
    frmGravando.ShowModal;
  Finally
    blnApenasRecarregaAgeilo := False;
    chkAllPick.Checked := blnChecked;
    FreeAndNil(frmGravando);
  End;
end;

procedure TfrmPlanoDeRecebimento.btnCancelaClick(Sender: TObject);
begin
  inherited;
  If (blnAlterando Or pnlPlanoJaFinalizado.Visible) And (Not FBlnReabrindoPlanoPelaConfirmacao) Then
  Begin
    blnAlterando := False;
    pResetTela;
    Exit;
  End
  Else
  If fMensagem('', 'Confirma o cancelamento deste plano de recebimento?', ['&Sim', '&Não']) = 1 Then
    pCancelarPlano(strIdeDig);
end;

function TfrmPlanoDeRecebimento.fTemSugestao: Boolean;
  var blnFilter: Boolean;
      strFilter: string;
Begin
  blnFilter := cdsLocSug.Filtered;
  strFilter := cdsLocSug.Filter;
  cdsLocSug.DisableControls;
  Try
    cdsLocSug.Filtered := False;
    result := Not cdsLocSug.IsEmpty;
  Finally
    cdsLocSug.Filtered := False;
    cdsLocSug.Filter := strFilter;
    cdsLocSug.Filtered := blnFilter;
    cdsLocSug.EnableControls;
  End;

End;

procedure TfrmPlanoDeRecebimento.btnConfirmaClick(Sender: TObject);
  Var
    qryInsert     : TUniQuery;
    qryAgeIlo     : TUniQuery;
    strAutoincrem : String;
    intSequen     : Integer;
    objCadLot     : TCadLot;
    fltQtdPicking : Double;
    strIdeDigLocal: String;
    strPlacaLoca  : String;
    blnItemSemSugestao: Boolean;
    blnItemSugestaoParcial: Boolean;
begin
  FFalha := '';
  blnItemSemSugestao := False;
  blnItemSugestaoParcial := False;

  If Not blnConfirmacaoAutomatica then
  Begin
    //chkAllPick.Checked := False;

    //inherited;
    strItensSemPaletsCadastrado := '';
    strIdeDigLocal := edtIdeDig.Text;
    strPlacaLoca := edtPlaca_.Text;
    If not blnConfirmacaoPelaImpressao Then
    Begin
      If (blnModCub And blnTemCubagemAutomatica) And (Not fTemSugestao) Then
      Begin
        fMensagem('', 'É necessário processar a cubagem automática antes de prosseguir!', ['&Ok']);
        Exit;
      End;
    End;

    If blnAlterando Then
    Begin
      If fMensagem('', 'Confirma atualização do Plano de Recebimento?', ['&Sim', '&Não']) = 1 Then
      Begin


        pAtualizarPlano;
        pResetTela;
        cdsLocSug.EmptyDataSet;
        edtIdeDig.Text := strIdeDigLocal;
        edtPlaca_.Text := strPlacaLoca;
        fMostraItens(IIF(strIdeDigLocal ='', strPlacaLoca, strIdeDigLocal),  True, True);
        If pnlEtiquetasID.Visible Then
          pSetFocus(cxgEtiqueta)
        Else
          pSetFocus(cxgItens);

        Exit;
      End
      Else
      Begin
        Exit;
      End;
    End;

  End;

  If Not blnConfirmacaoAutomatica then
    If not blnConfirmacaoPelaImpressao Then
      If not fValidaClassedeLocalOuLocalizacaoFisica Then
        Exit;

  If Not blnConfirmacaoAutomatica then
    If not fQtdeEtiquetas Then
      Exit;

  If Not fValidarCamposCadIte(FFalha) Then
    Exit;

  strAutoincrem := cdsItens.FieldByName('AUTINC').AsString;

  If (cdsItens.FieldByName('MOVEFE').AsString = 'N') Then
  Begin
    If Not blnConfirmacaoAutomatica Then
      If not blnConfirmacaoPelaImpressao Then
        If fMensagem('', 'Confirma o Planejamento de Recebimento?', ['&Sim', '&Não']) = 2 Then
          Exit;

    Try
       cdsItens.DisableControls;

       cdsItens.Filtered := False;
       cdsItens.Filter := 'EXCEDENTE = ' + QuotedStr('N');
       cdsItens.Filtered := True;
       cdsItens.First;

       If cdsItens.IsEmpty And blnConfirmacaoAutomatica Then
       begin
         FFalha := 'Não foi possível localizar os itens para confirmar o plano.';
         Exit;
       End;

      qryInsert := fCriaQuery;
      qryAgeIlo := fCriaQuery;

      cdsLocSug.AfterScroll := nil;

      If Not blnConfirmacaoAutomatica Then
        fStartTransaction;

      Try

        With qryInsert, SQL Do
        Begin
          Close;
          Clear;
          If not blnConfirmacaoPelaImpressao Then
          Begin
            Add(' DELETE FROM AGEITE WHERE AIT_SEQGER = :SEQGER ');

            ParamByName('SEQGER').AsString := strAutoincrem;
            ExecSQL;
          End;

          Close;
          Clear;
          Add(' INSERT INTO AGEITE (AUTOINCREM, ');
          Add('                     AIT_SEQGER, ');
          Add('                     AIT_CODITE, ');
          Add('                     AIT_CLASSE, ');
          Add('                     AIT_QTDITE, ');
          Add('                     AIT_QTDTOT, ');
          Add('                     AIT_QTDETI, ');
          Add('                     AIT_IMPETI, ');
          Add('                     AIT_APEPIC, ');
          Add('                     AIT_MODCUB, ');
          Add('                     AIT_QTDPIK, ');
          Add('                     AIT_TOTEND, ');

          If Pos('ENTRADA SIMPLIFICADA', cdsItens.FieldByName('NOMMOT').AsString) > 0 Then
          Begin
            Add('                     AIT_NUMLOT, AIT_LOCFIS, ');
          End;

          Add('                     AIT_QTDEND) ');
          Add('             VALUES (:AUTINC,    ');
          Add('                     :SEQGER,    ');
          Add('                     :CODITE,    ');
          Add('                     :CLASSE,    ');
          Add('                     :QTDITE,    ');
          Add('                     :QTDTOT,    ');
          Add('                     :QTDETI,    ');
          Add('                     :IMPETI,    ');
          Add('                     :APEPIC,    ');
          Add('                     :MODCUB,    ');
          Add('                     :QTDPIK, ');
          Add('                     :TOTEND, ');

          If Pos('ENTRADA SIMPLIFICADA', cdsItens.FieldByName('NOMMOT').AsString) > 0 Then
          Begin
            Add('                     :NUMLOT, :LOCFIS, ');
          End;

          Add('                     :QTDEND)    ');
        End;

        If (blnSugereLocalizacao) Then
        Begin
          With qryAgeIlo, SQL Do
          Begin
            Close;
            Clear;
            Add(' INSERT INTO AGEILO(AUTOINCREM, AIL_SEQITE, AIL_QTDITE, AIL_LOCFIS, AIL_DTAVEN, AIL_QTDVEN, AIL_SEQUEN, AIL_ENDERE, AIL_PICKNG, AIL_IMPRES) ');
            Add(' VALUES(:AUTINC, :SEQITE, :QTDITE, :LOCFIS, :DTAVEN, :QTDVEN, :SEQUEN, :ENDERE, :PICKNG, :IMPRES) ');
          End
        End;

        Try
          intSequen := 0;
          While Not cdsItens.Eof Do
          Begin
            If fIsItemEspecial(cdsItens.FieldByName('CODITE').AsString) Then
            Begin
              cdsItens.Next;
              Continue;
            End;
            fltQtdPicking := 0;

            qryInsert.ParamByName('AUTINC').AsString := fRetAutoIncrem('AGEITE', VS_strCodEmp);
            qryInsert.ParamByName('SEQGER').AsString := cdsItens.FieldByName('AUTINC').AsString;
            qryInsert.ParamByName('CODITE').AsString := cdsItens.FieldByName('CODITE').AsString;
            If blnConfirmacaoAutomatica then
              qryInsert.ParamByName('CLASSE').AsString := fCfgSis('CLAPLA')
            Else
            Begin
              qryInsert.ParamByName('CLASSE').AsString := cdsItens.FieldByName('CLASSE').AsString;
 
              If fEmptyStr(qryInsert.ParamByName('CLASSE').AsString) Then
                qryInsert.ParamByName('CLASSE').Clear;
              if blnModCub And (cdsItens.FieldByName('MODCUB').AsString <>  'M') then
                fltQtdPicking := fQuantidadePickin(cdsItens.FieldByName('CODITE').AsString);
            End;


            qryInsert.ParamByName('QTDPIK').AsFloat  := fltQtdPicking;
            qryInsert.ParamByName('TOTEND').AsFloat := cdsItens.FieldByName('DET_QTDITE_TOT').AsFloat;

            qryInsert.ParamByName('QTDITE').AsFloat  := cdsItens.FieldByName('QTDITE').AsFloat;
            qryInsert.ParamByName('QTDTOT').AsFloat  := cdsItens.FieldByName('DET_QTDITE').AsFloat;
            qryInsert.ParamByName('QTDETI').AsFloat  := cdsItens.FieldByName('QTDETI').AsFloat;
            qryInsert.ParamByName('IMPETI').AsString := cdsItens.FieldByName('IMPETI').AsString;
            qryInsert.ParamByName('MODCUB').AsString := cdsItens.FieldByName('MODCUB').AsString;

            If cdsItens.FieldByName('NUMLOT').AsString <> 'GARANTIA' Then
              qryInsert.ParamByName('QTDEND').AsFloat := cdsItens.FieldByName('DET_QTDITE').AsFloat - cdsItens.FieldByName('QTDNOR').AsFloat
            Else
              qryInsert.ParamByName('QTDEND').AsFloat := cdsItens.FieldByName('DET_QTDITE').AsFloat;

            If Pos('ENTRADA SIMPLIFICADA', cdsItens.FieldByName('NOMMOT').AsString) > 0 Then
            Begin
              if cdsItens.FieldByName('NUMLOT').AsString <> 'A DEFINIR' Then
              Begin
                objCadLot := TCadLot.Create(Self);
                qryInsert.ParamByName('NUMLOT').AsString := cdsItens.FieldByName('NUMLOT').AsString;
                qryInsert.ParamByName('LOCFIS').AsString := objCadLot.fLocalizacaoFisicaLote(cdsItens.FieldByName('CODITE').AsString, VS_strCodEmp, cdsItens.FieldByName('NUMLOT').AsString);
                FreeAndNil(objCadLot);
              End
              Else
              Begin
                qryInsert.ParamByName('NUMLOT').Clear;
                qryInsert.ParamByName('LOCFIS').Clear;
              End;
            End;
            qryInsert.ParamByName('APEPIC').AsString := '';
            qryInsert.ExecSQL;

            If qryInsert.RowsAffected = 0 Then
            Begin
              fRollback;
              FFalha := 'Falha ao gravar item ' + cdsItens.FieldByName('CODITE').AsString + ' do plano de recebimento!' + #13#10 + 'Entre em contato com a Citel!';
              If Not blnConfirmacaoAutomatica Then
              begin
                fRollBack;
                fMensagem('', FFalha,['&Ok']);
              End;
              Exit;
            End;

            If blnSugereLocalizacao Then
            Begin
              cdsLocSug.Filtered := False;
              If blnSugestaoViaBanco Then
                cdsLocSug.Filter := 'CHAVE = ' + QuotedStr(cdsItens.FieldByName('CHAVE').AsString) + ' AND SELECE = TRUE'
              Else
                cdsLocSug.Filter := 'CHAVE = ' + QuotedStr(cdsItens.FieldByName('CHAVE').AsString);
              cdsLocSug.Filtered := True;
              cdsLocSug.First;

              If ((Not blnModCub) And (cdsLocSug.IsEmpty)) And (cdsItens.FieldByName('QTDCON').AsFloat > 0) And (cdsItens.FieldByName('EXCEDENTE').AsString = 'N') Then
                blnItemSemSugestao := True;

              If ((blnTrvSug) And (Not cdsLocSug.IsEmpty)) And ((cdsItens.FieldByName('QTDCON').AsFloat > 0) And (cdsItens.FieldByName('QTDCON').AsFloat <> (StrToFloatDef(cdsLocSugTOTSUG.AsString,0)))) Then
                blnItemSugestaoParcial := True;

              If (Not blnModcub) Or ((blnModcub) And ((cdsItens.FieldByName('MODCUB').AsString = 'A') Or (blnConfirmacaoPelaImpressao)))  Then
              Begin
                While Not cdsLocSug.Eof Do
                Begin
                  If (blnConfirmacaoPelaImpressao And ((cdsLocSug.FieldByName('ABPICK').AsString = 'N') or (fltQtdPicking = 0))) Then
                  Begin
                    cdsLocSug.Next;
                    Continue;
                  End;

                  If blnModcub And (cdsItens.FieldByName('MODCUB').AsString <> 'A') and (Not fLocalizacaPiking(cdsLocSug.FieldByName('LOCFIS').AsString)) Then
                  Begin
                    cdsLocSug.Next;
                    Continue;
                  End;

                  Inc(intSequen);
                  qryAgeIlo.ParamByName('AUTINC').AsString   := fRetAutoIncrem('AGEILO', VS_strCodEmp);
                  qryAgeIlo.ParamByName('SEQITE').AsString   := qryInsert.ParamByName('AUTINC').AsString;
                  If (blnConfirmacaoPelaImpressao And (cdsLocSug.FieldByName('ABPICK').AsString = 'S')) Then
                  Begin
                    qryAgeIlo.ParamByName('QTDITE').AsFloat    := fltQtdPicking;
                    qryAgeIlo.ParamByName('PICKNG').AsString   := 'S';
                    qryAgeIlo.ParamByName('IMPRES').AsString   := 'S';
                  End
                  Else
                  Begin
                    qryAgeIlo.ParamByName('QTDITE').AsFloat    := cdsLocSug.FieldByName('QTDITE').AsFloat;
                    qryAgeIlo.ParamByName('PICKNG').AsString   := cdsLocSug.FieldByName('PICKNG').AsString;
                    qryAgeIlo.ParamByName('IMPRES').AsString   := 'N';
                  End;
                  qryAgeIlo.ParamByName('LOCFIS').AsString   := cdsLocSug.FieldByName('LOCFIS').AsString;
                  qryAgeIlo.ParamByName('DTAVEN').AsDateTime := cdsLocSug.FieldByName('DTAVAL').AsDateTime;
                  qryAgeIlo.ParamByName('QTDVEN').AsFloat    := cdsLocSug.FieldByName('QTDVEN').AsFloat;
                  qryAgeIlo.ParamByName('ENDERE').AsString   := cdsLocSug.FieldByName('ENDERE').AsString;
                  qryAgeIlo.ParamByName('SEQUEN').AsInteger  := intSequen;
                  qryAgeIlo.ExecSQL;
                  cdsLocSug.Next;
                End;
              End;
            End;

            cdsItens.Next;
          End;

        Finally
          cdsItens.EnableControls;
        End;

        Try
          pCriarFormularios(TfrmGravando, frmGravando);
          frmGravando.lblGravando.Caption := 'Efetivando movimento fiscal, Aguarde...';
          frmGravando.fExecutarAcao := fEfetivaMovFiscal;
          frmGravando.pgbStatus.Visible := False;
          frmGravando.ShowModal;
          If (Not frmGravando.blnConfirma) Then
          Begin
            fRollBack;
            If strItensSemPaletsCadastrado <> '' Then
            Begin
              FFalha := 'O(s) Produto(s) ' +  #$A#$D + strItensSemPaletsCadastrado + 'não possui os dados necessários informados na aba "Controle de Pallet do produto ' + #$A#$D +
                        'por Fornecedor" em seu cadastro para geração de cobrança de descarregamento por pallet. Sendo assim, não será possível gerar ' + #$A#$D +
                        'o pedido de venda. Se for preciso, ajuste os dados no cadastro e refaça esta operação.';
            End
            Else
              FFalha := 'Não foi possível efetivar o plano de recebimento, tente novamente!';

            If Not blnConfirmacaoAutomatica Then
            begin
              fRollBack;
              fMensagem('', FFalha, ['&Ok']);
            End;

            objLock.fLock_Unlock('PLANO_RECEBIMENTO_' + cdsItens.FieldByName('AUTINC').AsString, False, False);
            objLock.fLock_Unlock('CUBALT_PLANO_RECEBIMENTO_' + cdsItens.FieldByName('AUTINC').AsString, False, False);
            Exit;
          End;

        Finally
          If Not blnConfirmacaoAutomatica Then
            FreeAndNil(frmGravando);
        End;

        If TRAVA_PLANO_RECEBIMENTO_SEM_SUGESTAO And blnModCub And fTemItemCubAutomaticaSemSugestao Then
        begin
          fRollback;
          pMostraItensCubAutomaticaSemSugestao;
          Exit;
        End
        Else If blnItemSemSugestao Then
        Begin
          fRollBack;
          fMensagem('', 'Existem itens no plano sem sugestão de localização física!',['&Ok']);
          Exit;
        End
        Else If blnItemSugestaoParcial Then
        Begin
          fRollBack;
          fMensagem('', 'Existem itens no plano com sugestão de localização física parcial!', ['&Ok']);
          Exit;
        End
        Else
        If Not blnConfirmacaoAutomatica Then
          fCommit;

        If Not blnConfirmacaoAutomatica Then
          fMensagem('', 'Plano de Recebimento Gravado com Sucesso!', ['&Ok']);

        edtIdeDig.Text := strIdeDigLocal;
        edtPlaca_.Text := strPlacaLoca;
        strIdeDigBkp := '';
        If (Not blnConfirmacaoPelaImpressao) And (blnModCub) Then
          fMostraItens(IIF(strIdeDigLocal ='', strPlacaLoca, strIdeDigLocal),  True);
        If pnlEtiquetasID.Visible Then
          pSetFocus(cxgEtiqueta)
        Else
          pSetFocus(cxgItens);

      Except
        On E: Exception Do
        Begin
          FFalha := e.message;
          If Not blnConfirmacaoAutomatica Then
          begin
			fRollBack;             
			pMensagensErro(E.Message, 'TfrmPlanoDeRecebimento.btnConfirmaClick');             
          End;
          strAutoincrem := '';
          objLock.fLock_Unlock('PLANO_RECEBIMENTO_' + cdsItens.FieldByName('AUTINC').AsString, False, False);
          objLock.fLock_Unlock('CUBALT_PLANO_RECEBIMENTO_' + cdsItens.FieldByName('AUTINC').AsString, False, False);
        End;
      End;

      objLock.fLock_Unlock('PLANO_RECEBIMENTO_' + cdsItens.FieldByName('AUTINC').AsString, False, False);
      objLock.fLock_Unlock('CUBALT_PLANO_RECEBIMENTO_' + cdsItens.FieldByName('AUTINC').AsString, False, False);

      if blnTemImpressao And (fMensagem('', 'Deseja imprimir etiquetas?' , ['&Sim', '&Não']) = 1) then
        btnImprimir.Click;

    Finally
      FreeAndNil(qryAgeIlo);
      FreeAndNil(qryInsert);
      If Not blnModCub Then
        pResetTela;
    End;

  End
  Else
  Begin
    fMensagem('', 'Não é possível confirmar este plano, já foi efetivado movimento fiscal!' , ['&Ok'])
  End;

end;

procedure TfrmPlanoDeRecebimento.btnCubAutClick(Sender: TObject);
begin
  inherited;
  pSetarModoCubagem(True, chkRepModCubTodos.Checked, False);
end;

procedure TfrmPlanoDeRecebimento.btnCubManClick(Sender: TObject);
begin
  inherited;
  pSetarModoCubagem(False, chkRepModCubTodos.Checked, False);
end;

procedure TfrmPlanoDeRecebimento.btnCubResetClick(Sender: TObject);
begin
  inherited;

  pSetarModoCubagem(False, True, True);
  btnImprimir.Enabled := False;
end;

procedure TfrmPlanoDeRecebimento.btnSugerirLocFisicaClick(Sender: TObject);
var
  strLocFis: String;
  intIndexLinha: Integer;
begin
  inherited;

  If Pos('ID_PLANO', qryEtique.FieldByName('CHAVE').AsString) = 0 Then
    Exit;

  intIndexLinha := cxgEtiquetaTableView.ViewData.Records[cxgEtiquetaTableView.Controller.FocusedRecordIndex].Index;

  If fQtdItensDistintosEtiquetaID(qryEtique.FieldByName('ID').AsString) = 1 Then
    strLocFis := fSugerirLocFisicaEtiquetaID
  Else
    strLocFis := fGetLocFisicaVazia;

  pAtualizarLocFisEtiquetaID(strLocFis);

  cxgEtiquetaTableView.ViewData.Expand(True);
  blnAgrupado := False;

  pSetFocus(cxgEtiqueta);
  cxgEtiquetaTableView.ViewData.Records[intIndexLinha].Focused := True;
end;

procedure TfrmPlanoDeRecebimento.pAtualizarLocFisEtiquetaID(AStrLocFis: String);
var
  qryUpd: TUniQuery;
begin
  Try
    qryUpd := fCriaQuery;
    qryUpd.SQL.Add(' UPDATE ETIREC SET ETI_LOCFIS = :LOCFIS ');
    qryUpd.SQL.Add(' WHERE AUTOINCREM = :AUTINC');
    qryUpd.ParamByName('LOCFIS').AsString := AStrLocFis;
    qryUpd.ParamByName('AUTINC').AsString := qryEtique.FieldByName('REC_AUTINC').AsString;
    Try
      fStartTransaction;
      qryUpd.ExecSQL;
      fCommit;
    Except On
      E:Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, 'TfrmPlanoDeRecebimento.pAtualizarLocFisEtiquetaID');
      End;
    End;
  Finally
    FreeAndNil(qryUpd);
    pProcessarEtiquetasID;
  End;
end;

function TfrmPlanoDeRecebimento.fGetLocFisicaVazia: String;
var
  qryCons: TUniQuery;
begin
  Try
    qryCons := fCriaQuery;
    qryCons.SQL.Clear;
    qryCons.SQL.Add(' SELECT LOC_CODLOC FROM                                             ');
    qryCons.SQL.Add('  ( SELECT                                                          ');
    qryCons.SQL.Add('    LOC_CODLOC, LOC_R_U_A_ , LOC_PREDIO, LOC_ANDAR_, LOC_APARTA,    ');
    qryCons.SQL.Add('    SUM(IFNULL(LOT_SALDOS, 0)) AS SOMA_LOT_SALDOS,                  ');
    qryCons.SQL.Add('    SUM(IFNULL(LOT_SAL_ML, 0)) AS SOMA_SAL_ML,                      ');
    qryCons.SQL.Add('    (SELECT COUNT(1) FROM ETIREC WHERE ETI_LOCFIS = LOC_CODLOC)     ');
    qryCons.SQL.Add('    AS CNT_EM_ETIREC,                                               ');
    qryCons.SQL.Add('    (SELECT COUNT(1) FROM AGEILO WHERE AIL_LOCFIS = LOC_CODLOC)     ');
    qryCons.SQL.Add('    AS CNT_EM_AGEILO                                                ');
    qryCons.SQL.Add('    FROM                                                            ');
    qryCons.SQL.Add('      CADLOC                                                        ');
    qryCons.SQL.Add('      LEFT JOIN CADLOT                                              ');
    qryCons.SQL.Add('        ON LOT_LOCFIS = LOC_CODLOC                                  ');
    qryCons.SQL.Add('       AND LOT_CODEMP = LOC_CODEMP                                  ');
    qryCons.SQL.Add('    WHERE IFNULL(LOT_NUMLOT, "") NOT IN ("A DEFINIR", "GARANTIA")   ');
    qryCons.SQL.Add('      AND LOC_CODEMP = :CODEMP                                      ');
    qryCons.SQL.Add('      AND LOC_ATIVO_ = "S"                                          ');
    If Not blnNotasDeTransfApenasManual Then
      qryCons.SQL.Add('      AND LOC_PICKIN <> "S"                                       ');
    qryCons.SQL.Add('      AND IFNULL(LOC_CODLOC, "") <> ""                              ');
    qryCons.SQL.Add('    GROUP BY LOC_CODLOC ) LOCALIZACOES                              ');
    qryCons.SQL.Add('  WHERE SOMA_SAL_ML = 0 AND SOMA_LOT_SALDOS = 0                     ');
    qryCons.SQL.Add('                        AND CNT_EM_ETIREC = 0                       ');
    qryCons.SQL.Add('                        AND CNT_EM_AGEILO = 0                       ');
    qryCons.SQL.Add('  ORDER BY LOC_R_U_A_,                                              ');
    qryCons.SQL.Add('           LOC_PREDIO,                                              ');
    qryCons.SQL.Add('           LOC_ANDAR_,                                              ');
    qryCons.SQL.Add('           LOC_APARTA                                               ');
    qryCons.SQL.Add('  LIMIT 1                                                           ');

    qryCons.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCons.Open;

    Result := qryCons.FieldByName('LOC_CODLOC').AsString;
    If fEmptyStr(Result) Then
      fMensagem('', 'Não foram encontradas localizações físicas vazias', ['&Ok']);
  Finally
    FreeAndNil(qryCons);
  End;
end;

procedure TfrmPlanoDeRecebimento.btnDesmembraClick(Sender: TObject);
  var
    qryInsert,
    qryConsulta : TUniQuery;
    strAutInc : String;
    strIdeDig : String;
    strIdenti : String;
begin
  inherited;
  If fMensagem('', 'Deseja desmembrar os documentos?', ['&Sim', '&Não'], 2) = 2 Then
    Exit;

  Try
    pCriarFormularios(TfrmPlanoDeRecebimentoDesmembra, frmPlanoDeRecebimentoDesmembra);
    frmPlanoDeRecebimentoDesmembra.strAutInc := cdsItens.FieldByName('AUTINC').AsString;
    frmPlanoDeRecebimentoDesmembra.ShowModal;

    If (frmPlanoDeRecebimentoDesmembra.ModalResult = mrOk) Then
    Begin
      Try
        Try

          qryConsulta := fCriaQuery;
          qryConsulta.SQL.Text := 'SELECT * FROM AGEREC WHERE AUTOINCREM = :AUTINC';
          qryConsulta.ParamByName('AUTINC').AsString := cdsItens.FieldByName('AUTINC').AsString;
          qryConsulta.Open;

          strIdenti := qryConsulta.FieldByName('ARC_IDENTI').Value;
          if not fInputQueryTipo('Desmembrar documento', 'Digite uma nova identificação', strIdenti, ttAlfanumerico ) Then
            Exit;

          fStartTransaction;

          qryInsert   := fCriaQuery;
          qryInsert.SQL.Add('INSERT INTO AGEREC (    ');
          qryInsert.SQL.Add('            ARC_CODIGO, ');
          qryInsert.SQL.Add('            ARC_CODTRA, ');
          qryInsert.SQL.Add('            ARC_DTAENT, ');
          qryInsert.SQL.Add('            ARC_DTAREC, ');
          qryInsert.SQL.Add('            ARC_DTDOCA, ');
          qryInsert.SQL.Add('            ARC_HRAENT, ');
          qryInsert.SQL.Add('            ARC_HRAREC, ');
          qryInsert.SQL.Add('            ARC_HRDOCA, ');
          qryInsert.SQL.Add('            ARC_IDDOCA, ');
          qryInsert.SQL.Add('            ARC_IDEDIG, ');
          qryInsert.SQL.Add('            ARC_NOMMOT, ');
          qryInsert.SQL.Add('            ARC_OPDOCA, ');
          qryInsert.SQL.Add('            ARC_OPEREC, ');
          qryInsert.SQL.Add('            ARC_PLACA_, ');
          qryInsert.SQL.Add('            ARC_STATUS, ');
          qryInsert.SQL.Add('            AUTOINCREM, ');
          qryInsert.SQL.Add('            ARC_MOVEFE, ');
          qryInsert.SQL.Add('            ARC_IDENTI, ');
          qryInsert.SQL.Add('            ARC_DESPAL, ');
          qryInsert.SQL.Add('            ARC_CODEMP, ');
          qryInsert.SQL.Add('            ARC_PARCAN ');
          qryInsert.SQL.Add(' ) VALUES(              ');
          qryInsert.SQL.Add('            :CODIGO,    ');
          qryInsert.SQL.Add('            :CODTRA,    ');
          qryInsert.SQL.Add('            :DTAENT,    ');
          qryInsert.SQL.Add('            :DTAREC,    ');
          qryInsert.SQL.Add('            :DTDOCA,    ');
          qryInsert.SQL.Add('            :HRAENT,    ');
          qryInsert.SQL.Add('            :HRAREC,    ');
          qryInsert.SQL.Add('            :HRDOCA,    ');
          qryInsert.SQL.Add('            :IDDOCA,    ');
          qryInsert.SQL.Add('            :IDEDIG,    ');
          qryInsert.SQL.Add('            :NOMMOT,    ');
          qryInsert.SQL.Add('            :OPDOCA,    ');
          qryInsert.SQL.Add('            :OPEREC,    ');
          qryInsert.SQL.Add('            :PLACA_,    ');
          qryInsert.SQL.Add('            :STATUS,    ');
          qryInsert.SQL.Add('            :AUTINC,    ');
          qryInsert.SQL.Add('            :MOVEFE,    ');
          qryInsert.SQL.Add('            :IDENTI,    ');
          qryInsert.SQL.Add('            :DESPAL,    ');
          qryInsert.SQL.Add('            :CODEMP,    ');
          qryInsert.SQL.Add('            :PARCAN)    ');

          strAutInc := fRetAutoIncrem('AGEREC', VS_strCodEmp);
          strIdeDig := fAtualizaProCod('DIGELE', 'ARC_IDEDIG', 'AGEREC');

          qryInsert.ParamByName('CODIGO').Value := fAtualizaProCod('AGEREC', 'ARC_CODIGO');
          qryInsert.ParamByName('IDEDIG').Value := strIdeDig;
          qryInsert.ParamByName('AUTINC').Value := strAutInc;

          qryInsert.ParamByName('DESPAL').Value := qryConsulta.FieldByName('ARC_DESPAL').Value;
          qryInsert.ParamByName('CODTRA').Value := qryConsulta.FieldByName('ARC_CODTRA').Value;
          qryInsert.ParamByName('DTAENT').Value := qryConsulta.FieldByName('ARC_DTAENT').Value;
          qryInsert.ParamByName('DTAREC').Value := qryConsulta.FieldByName('ARC_DTAREC').Value;
          qryInsert.ParamByName('DTDOCA').Value := qryConsulta.FieldByName('ARC_DTDOCA').Value;
          qryInsert.ParamByName('HRAENT').Value := qryConsulta.FieldByName('ARC_HRAENT').Value;
          qryInsert.ParamByName('HRAREC').Value := qryConsulta.FieldByName('ARC_HRAREC').Value;
          qryInsert.ParamByName('HRDOCA').Value := qryConsulta.FieldByName('ARC_HRDOCA').Value;
          qryInsert.ParamByName('IDDOCA').Value := qryConsulta.FieldByName('ARC_IDDOCA').Value;
          qryInsert.ParamByName('NOMMOT').Value := qryConsulta.FieldByName('ARC_NOMMOT').Value;
          qryInsert.ParamByName('OPDOCA').Value := qryConsulta.FieldByName('ARC_OPDOCA').Value;
          qryInsert.ParamByName('OPEREC').Value := qryConsulta.FieldByName('ARC_OPEREC').Value;
          qryInsert.ParamByName('PLACA_').Value := qryConsulta.FieldByName('ARC_PLACA_').Value;
          qryInsert.ParamByName('STATUS').Value := qryConsulta.FieldByName('ARC_STATUS').Value;

          qryInsert.ParamByName('MOVEFE').Value := qryConsulta.FieldByName('ARC_MOVEFE').Value;
          qryInsert.ParamByName('IDENTI').Value := strIdenti;
          qryInsert.ParamByName('CODEMP').Value := qryConsulta.FieldByName('ARC_CODEMP').Value;
          qryInsert.ParamByName('PARCAN').Value := 'N';
          qryInsert.ExecSQL;

          frmPlanoDeRecebimentoDesmembra.getDados.First;
          While Not frmPlanoDeRecebimentoDesmembra.getDados.Eof Do
          Begin
            If (frmPlanoDeRecebimentoDesmembra.getDados.FieldByName('MARCA').AsString = 'S') Then
            Begin
              qryInsert.Close;
              qryInsert.SQL.Clear;
              qryInsert.SQL.Add(' UPDATE AGEDOC SET ADC_SEQGER = :SEQGER ');
              qryInsert.SQL.Add(' WHERE ADC_SEQGER = :SEQOLD             ');
              qryInsert.SQL.Add('   AND ADC_CODEMP = :CODEMP             ');
              qryInsert.SQL.Add('   AND ADC_CODFOR = :CODFOR             ');
              qryInsert.SQL.Add('   AND ADC_ESPDOC = :ESPDOC             ');
              qryInsert.SQL.Add('   AND ADC_NUMDOC = :NUMDOC             ');
              qryInsert.SQL.Add('   AND ADC_SERIE_ = :SERIE_             ');

              qryInsert.ParamByName('SEQOLD').AsString := cdsItens.FieldByName('AUTINC').AsString;
              qryInsert.ParamByName('SEQGER').AsString := strAutInc;
              qryInsert.ParamByName('CODEMP').AsString := frmPlanoDeRecebimentoDesmembra.getDados.FieldByName('ADC_CODEMP').AsString;
              qryInsert.ParamByName('CODFOR').AsString := frmPlanoDeRecebimentoDesmembra.getDados.FieldByName('ADC_CODFOR').AsString;
              qryInsert.ParamByName('ESPDOC').AsString := frmPlanoDeRecebimentoDesmembra.getDados.FieldByName('ADC_ESPDOC').AsString;
              qryInsert.ParamByName('NUMDOC').AsString := frmPlanoDeRecebimentoDesmembra.getDados.FieldByName('ADC_NUMDOC').AsString;
              qryInsert.ParamByName('SERIE_').AsString := frmPlanoDeRecebimentoDesmembra.getDados.FieldByName('ADC_SERIE_').AsString;
              qryInsert.ExecSQL;

              qryInsert.Close;
              qryInsert.SQL.Clear;
              qryInsert.SQL.Add(' UPDATE GERELE SET GER_IDEDIG = :IDEDIG ');
              qryInsert.SQL.Add(' WHERE GER_DOCENT = :DOCENT             ');
              qryInsert.SQL.Add('   AND GER_ESPENT = :ESPENT             ');
              qryInsert.SQL.Add('   AND GER_EMPENT = :EMPENT             ');
              qryInsert.SQL.Add('   AND GER_CODFOR = :CODFOR             ');
              qryInsert.SQL.Add('   AND B07_SERIE  = :SERIE_             ');

              qryInsert.ParamByName('IDEDIG').AsString := strIdeDig;
              qryInsert.ParamByName('EMPENT').AsString := frmPlanoDeRecebimentoDesmembra.getDados.FieldByName('ADC_CODEMP').AsString;
              qryInsert.ParamByName('CODFOR').AsString := frmPlanoDeRecebimentoDesmembra.getDados.FieldByName('ADC_CODFOR').AsString;
              qryInsert.ParamByName('ESPENT').AsString := frmPlanoDeRecebimentoDesmembra.getDados.FieldByName('ADC_ESPDOC').AsString;
              qryInsert.ParamByName('DOCENT').AsString := frmPlanoDeRecebimentoDesmembra.getDados.FieldByName('ADC_NUMDOC').AsString;
              qryInsert.ParamByName('SERIE_').AsString := frmPlanoDeRecebimentoDesmembra.getDados.FieldByName('ADC_SERIE_').AsString;
              qryInsert.ExecSQL;

            End;

            frmPlanoDeRecebimentoDesmembra.getDados.Next;
          End;

          qryInsert.Close;
          qryInsert.SQL.Clear;
          qryInsert.SQL.Text := 'DELETE FROM AGEITE WHERE AIT_SEQGER = :SEQGER';
          qryInsert.ParamByName('SEQGER').AsString := cdsItens.FieldByName('AUTINC').AsString;
          qryInsert.ExecSQL;

          fCommit;

          objLock.fLock_Unlock('PLANO_RECEBIMENTO_' + cdsItens.FieldByName('AUTINC').AsString, False, False);

          fMensagem('', 'Documento(s) desmembrado com sucesso!', ['&OK']);

          edtPlaca_.Clear;
          edtIdeDig.Text := cdsItens.FieldByName('IDEDIG').AsString;
          strIdeDig := cdsItens.FieldByName('IDEDIG').AsString;
          strAdcSeqGer := cdsItens.FieldByName('ADC_SEQGER').AsString;
          fMostraItens(edtIdeDig.Text, False);

        Finally
          FreeAndNil(qryInsert);
          FreeAndNil(qryConsulta);
        End;
      Except
        On E: Exception Do
        Begin
          fRollback;
          pMensagensErro(e.Message, 'TfrmPlanoDeRecebimento.btnDesmembraClick');
        End;
      End;
    End;

  Finally
    FreeAndNil(frmPlanoDeRecebimentoDesmembra);
  End;

end;

procedure TfrmPlanoDeRecebimento.btnImprimirClick(Sender: TObject);
var strIdeDigLocal: String;
   strPlacaLoca: String;
begin
  If (Not blnImprimeEtqAntesConfer) And (cdsItens.FieldByName('QTDCON').AsFloat = 0) Then
  Begin
    pMensagemOk('Este item não tem quantidade conferida e sua etiqueta para endereçamento  não poderá ser impressa!');
    Exit;
  End;

  Try
    cdsItens.AfterScroll := Nil;
    If Not blnModCub Then
    Begin
      pImprimirEtiquetasPadrao;
      cdsItens.AfterScroll := pFiltraSugestaoCds;
      Exit;
    End;
    If fTemQueGravarParaImprimir Then
      If fPergunta('Nenhum item foi marcado como cubagem automática ou manual, para prosseguir é precisso efetivar o movimento fiscal. Serão impressas apenas as etiquetas de Picking, Prosseguir?') Then
      Begin
        Try
          blnConfirmacaoPelaImpressao := True;
          strIdeDigLocal := edtIdeDig.Text;
          strPlacaLoca := edtPlaca_.Text;
          btnConfirma.Click;
          edtIdeDig.Text := strIdeDigLocal;
          edtPlaca_.Text := strPlacaLoca;
          fMostraItens(IIF(strIdeDigLocal ='', strPlacaLoca, strIdeDigLocal),  True);
          btnAlterar.Click;
          FBlnReabrindoPlanoPelaConfirmacao := True;
          If pnlEtiquetasID.Visible Then
            pSetFocus(cxgEtiqueta)
          Else
            pSetFocus(cxgItens);
        Finally
          If cdsItens.RecordCount > 0 Then
            cdsItens.EnableControls;
        End;
      End;

    pImprimirEtiquetasCubagemAutomaticaOuManual('A',False,  Not blnConfirmacaoPelaImpressao);
    If (Not blnAlterando) And (blnTemCubagemManual) Then
      pImprimirEtiquetasCubagemAutomaticaOuManual('M', True, Not blnConfirmacaoPelaImpressao);


    If Not blnConfirmacaoPelaImpressao Then
    Begin
      If blnTodasModCubPreenchidas And (Not qryEtique.IsEmpty) Then
      Begin
        cdsItens.Filter := 'MODCUB = ''A''';
        cdsItens.Filtered := True;
      End;
    End
    Else
    Begin
      cdsItens.Filtered := True;
      cdsItens.Filter := '';
    End
  Finally
    If blnConfirmacaoPelaImpressao Then
    Begin
      btnAlterar.Click;
      cdsItens.Filtered := False;
      cdsItens.AfterScroll := pFiltraSugestaoCds;
      If cdsItens.RecordCount > 0 Then
        cdsItens.EnableControls;
      chkAllPickClick(Nil);
    End;
    blnConfirmacaoPelaImpressao:= False;
  End;


end;


function TfrmPlanoDeRecebimento.fTemQueGravarParaImprimir: Boolean;
var intRecItens,
    intRecLocSug: Integer;
    blnFilterItens,
    blnFilterSug: Boolean;
    strFilterSug,
    strFilterItens: String;
begin
  Result := False;
  If (Not blnAlterando) And (blnModCub) And ((blnModCub and blnSugestaoViaBanco and (cdsItens.FieldByName('MOVEFE').AsString = 'N'))) Then
  Begin
    intRecLocSug := cdsLocSug.RecNo;
    intRecItens := cdsItens.RecNo;

    strFilterSug := cdsLocSug.Filter;
    blnFilterSug := cdsLocSug.Filtered;

    strFilterItens := cdsItens.Filter;
    blnFilterItens := cdsItens.Filtered;

    cdsItens.DisableControls;
    cdsLocSug.DisableControls;
    Try

      cdsItens.Filtered := False;
      cdsItens.Filter := 'MODCUB <> ' + QuotedStr('');
      cdsItens.Filtered := True;

      cdsLocSug.Filtered := False;
      cdsLocSug.Filter := 'ABPICK = ' + QuotedStr('S') + ' AND SELECE = TRUE';
      cdsLocSug.Filtered := True;

      Result :=  (cdsItens.RecordCount = 0) And (cdsLocSug.RecordCount > 0);


    Finally
      cdsItens.Filtered := False;
      cdsLocSug.Filtered := False;

      cdsLocSug.Filter :=  strFilterSug;
      cdsLocSug.Filtered := blnFilterSug;

      cdsItens.Filter := strFilterItens;
      cdsItens.Filtered := blnFilterItens;

      cdsLocSug.RecNo := intRecLocSug;
      cdsItens.RecNo := intRecItens;


      cdsItens.EnableControls;
      cdsLocSug.EnableControls;
    End;
  End;

End;



procedure TfrmPlanoDeRecebimento.btnImprimirMaisEtiqIDClick(Sender: TObject);
begin
  inherited;
  pImprimirEtiquetasCubagemAutomaticaOuManual('M', True);
end;

procedure TfrmPlanoDeRecebimento.btnLimparEtiquetaClick(Sender: TObject);
var
  qryDel: TUniQuery;
begin
  inherited;

  If Pos('ID_PLANO', qryEtique.FieldByName('CHAVE').AsString) = 0 Then
    Exit;

  If fMensagem('', 'Confirma a limpeza desta Etiqueta ID?', ['&Sim', '&Não']) = 2 Then
    Exit;

  Try
    qryDel := fCriaQuery;
    qryDel.SQL.Add('DELETE    ');
    qryDel.SQL.Add(' ETIRIT    ');
    qryDel.SQL.Add(' FROM     ');
    qryDel.SQL.Add('ETIRIT    ');
    qryDel.SQL.Add('INNER JOIN ETIREC  ');
    qryDel.SQL.Add('  ON ETIREC.AUTOINCREM = ETI_ETIREC ');
    qryDel.SQL.Add('WHERE ETIREC.AUTOINCREM = :AUTINC');
    qryDel.ParamByName('AUTINC').AsString := qryEtique.FieldByName('REC_AUTINC').AsString;
    Try
      fStartTransaction;
      qryDel.ExecSQL;
      fCommit;
    Except On
      E:Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, 'TfrmPlanoDeRecebimento.btnTirarProdutoClick');
      End;
    End;
  Finally
    FreeAndNil(qryDel);
    pProcessarEtiquetasID;
  End;
end;

procedure TfrmPlanoDeRecebimento.btnLimparLocFisicaClick(Sender: TObject);
var
  qryUpd: TUniQuery;
begin
  inherited;

  If Pos('ID_PLANO', qryEtique.FieldByName('CHAVE').AsString) = 0 Then
    Exit;

  If fMensagem('', 'Confirma a exclusão desta localização física?', ['&Sim', '&Não']) = 2 Then
    Exit;

  Try
    qryUpd := fCriaQuery;
    qryUpd.SQL.Add('UPDATE ETIREC SET ETI_LOCFIS = "" WHERE AUTOINCREM = :AUTINC');
    qryUpd.ParamByName('AUTINC').AsString := qryEtique.FieldByName('REC_AUTINC').AsString;
    Try
      fStartTransaction;
      qryUpd.ExecSQL;
      fCommit;
    Except On
      E:Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, 'TfrmPlanoDeRecebimento.pAtualizarLocFisicaEtiquetaID');
      End;
    End;
  Finally
    FreeAndNil(qryUpd);
    qryEtique.Refresh;
  End;
end;

procedure TfrmPlanoDeRecebimento.pReImprimirEtiquetaID(AStrID: String; ABlnDefinirQtd: Boolean = False; AStrLocFis: String = '');
var
  prmDllEtq : TParamDllEtiquetas;
  ArrNomEti : TStringArray;
  strTipEti : String;
  intNumEtiquetasID: Integer;
begin
  inherited;
  cdsItens.Filtered := False;
  If not fEmptyStr(cdsItens.FieldByName('AUTINC').AsString) Then
  Begin
    intNumEtiquetasID := 1;
    If ABlnDefinirQtd Then
    Begin
      If Not TfrmDigQuantidade.fDigQuantidade('Etiquetas', 'Informe a quantidade de etiquetas ID', intNumEtiquetasID, 1, 200) Then
      Begin
        cdsItens.Filter := 'MODCUB = ''A''';
        cdsItens.Filtered := True;
        Exit;
      End;
    End;

    prmDllEtq := TParamDllEtiquetas.Create;
    prmDllEtq.strAutInc := ShortString(cdsItens.FieldByName('AUTINC').AsString);
    prmDllEtq.cdsPlanoRecebimento := fCriaCdsEtiquetasID(intNumEtiquetasID, AStrID, AStrLocFis);

    strTipEti := fCfgSis('PLAREC', varString);

    If strTipEti = 'L' Then
      prmDllEtq.tpeTipEtq := tpePlanoDeRecebimentoEtiquetaIDLaser
    Else
    If strTipEti = 'A' Then
      prmDllEtq.tpeTipEtq := tpePlanoDeRecebimentoEtiquetaIDArgox
    Else
    Begin
      SetLength(ArrNomEti, 0);
      pAddDados(ArrNomEti, 'Laser');
      pAddDados(ArrNomEti, 'Argox');
      Case fGetMenu('Escolha o Modelo:', ArrNomEti, 1, True) Of
        1: prmDllEtq.tpeTipEtq := tpePlanoDeRecebimentoEtiquetaIDLaser;
        2: prmDllEtq.tpeTipEtq := tpePlanoDeRecebimentoEtiquetaIDArgox;
      End;
    End;

    Try
      fImprimeEtiqueta(prmDllEtq, 'fimprimeetiquetas');
    Except

    End;

    FreeAndNil(prmDllEtq.cdsPlanoRecebimento);
    FreeAndNil(prmDllEtq);
  End;
  
  cdsItens.Filtered := True;

end;

procedure TfrmPlanoDeRecebimento.pImprimirEtiquetasCubagemAutomaticaOuManual(AStrModCub: String; ABlnDefinirQtd: Boolean = False; AtualizaDados: Boolean = True);
var
  prmDllEtq : TParamDllEtiquetas;
  ArrNomEti : TStringArray;
  strTipEti : String;
  intNumEtiquetasID: Integer;
begin
  inherited;
  cdsItens.Filtered := False;
  If AStrModCub = 'A' Then
  Begin
    prmDllEtq := TParamDllEtiquetas.Create;
    prmDllEtq.strAutInc := ShortString(cdsItens.FieldByName('AUTINC').AsString);
    prmDllEtq.cdsPlanoRecebimento := TUniClientDataSet.Create(nil);
    prmDllEtq.cdsPlanoRecebimento.Data := cdsItens.Data;
   	prmDllEtq.cdsPlanoRecebimento.Filter := 'MODCUB = ' + QuotedStr('A') + ' OR (MODCUB = ' + QuotedStr('')  + 'AND ABPICK = '+QuotedStr('S')+')' ;
    prmDllEtq.cdsPlanoRecebimento.Filtered := True;
    prmDllEtq.blnAtualizaAgeIteImp := AtualizaDados;
    If prmDllEtq.cdsPlanoRecebimento.isEmpty Then
    	Exit;

    strTipEti := fCfgSis('PLAREC', varString);

    If strTipEti = 'L' Then
      prmDllEtq.tpeTipEtq := tpePlanoRecebWMSLaser
    Else
    If strTipEti = 'A' Then
      prmDllEtq.tpeTipEtq := tpePlanoRecebWMSArgox
    Else
    Begin
      SetLength(ArrNomEti, 0);
      pAddDados(ArrNomEti, 'Laser');
      pAddDados(ArrNomEti, 'Argox');
      Case fGetMenu('Escolha o Modelo:', ArrNomEti, 1, True) Of
        1: prmDllEtq.tpeTipEtq := tpePlanoRecebWMSLaser;
        2: prmDllEtq.tpeTipEtq := tpePlanoRecebWMSArgox;
      End;
    End;

    fImprimeEtiqueta(prmDllEtq, 'fimprimeetiquetas');
    FreeAndNil(prmDllEtq.cdsPlanoRecebimento);
    FreeAndNil(prmDllEtq);
    cdsItens.Filtered := False;
  End
  Else
  If AStrModCub = 'M' Then
  Begin
    intNumEtiquetasID := 1;
    If ABlnDefinirQtd Then
    Begin
      If Not TfrmDigQuantidade.fDigQuantidade('Etiquetas', 'Informe a quantidade de etiquetas ID', intNumEtiquetasID, 1, 200) Then
      Begin
        cdsItens.Filter := 'MODCUB = ''A''';
        cdsItens.Filtered := True;
        Exit;
      End;
    End;

    prmDllEtq := TParamDllEtiquetas.Create;
    prmDllEtq.strAutInc := ShortString(cdsItens.FieldByName('AUTINC').AsString);
    prmDllEtq.cdsPlanoRecebimento := fCriaCdsEtiquetasID(intNumEtiquetasID);

    strTipEti := fCfgSis('PLAREC', varString);

    If strTipEti = 'L' Then
      prmDllEtq.tpeTipEtq := tpePlanoDeRecebimentoEtiquetaIDLaser
    Else
    If strTipEti = 'A' Then
      prmDllEtq.tpeTipEtq := tpePlanoDeRecebimentoEtiquetaIDArgox
    Else
    Begin
      SetLength(ArrNomEti, 0);
      pAddDados(ArrNomEti, 'Laser');
      pAddDados(ArrNomEti, 'Argox');
      Case fGetMenu('Escolha o Modelo:', ArrNomEti, 1, True) Of
        1: prmDllEtq.tpeTipEtq := tpePlanoDeRecebimentoEtiquetaIDLaser;
        2: prmDllEtq.tpeTipEtq := tpePlanoDeRecebimentoEtiquetaIDArgox;
      End;
    End;

    Try
      fImprimeEtiqueta(prmDllEtq, 'fimprimeetiquetas');
      pSalvarEtiquetasID(prmDllEtq.cdsPlanoRecebimento);
    Except

    End;

    FreeAndNil(prmDllEtq.cdsPlanoRecebimento);
    FreeAndNil(prmDllEtq);
  End;
  cdsItens.Filtered := True;
End;

procedure TfrmPlanoDeRecebimento.pSalvarEtiquetasID(ACdsEtiquetas: TUniClientDataSet);
var
  qryIns: TUniQuery;
begin
  If Not fCfgSis('SUGBAN', varBoolean) And (Not blnEtqCon) Then
    Exit;

  Try
    qryIns := fCriaQuery;
    With qryIns, SQL Do
    Begin
      Close;
      Clear;
      Add(' INSERT INTO ETIREC (AUTOINCREM, ETI_CODEMP, ETI_CODREC,  ETI_ETIID_, ETI_STATUS)');
      Add(' VALUES (:AUTINC, :CODEMP, :CODREC,  :ETIID_, ''A'')');

      ACdsEtiquetas.First;
      While Not ACdsEtiquetas.Eof Do
      Begin
        Try
          fStartTransaction;
          ParamByName('AUTINC').AsString  := fRetAutoIncrem('ETIREC', VS_strCodEmp);
          ParamByName('CODEMP').AsString  := VS_strCodEmp;
          ParamByName('CODREC').AsString  := ACdsEtiquetas.FieldByName('CODREC').AsString;
          ParamByName('ETIID_').AsString  := ACdsEtiquetas.FieldByName('ETIQID').AsString;
          ExecSQL;

          fCommit;

          ACdsEtiquetas.Next;
        Except On
          E:Exception Do
          Begin
            fRollBack;
            pMensagensErro(E.Message, 'TfrmPlanoDeRecebimento.pSalvarEtiquetasID');
          End;
        End;
      End;
    End;
  Finally
    FreeAndNil(qryIns);
  End;
end;

function TfrmPlanoDeRecebimento.fCriaCdsEtiquetasID(AIntNumEtiquetasID: Integer; AStrID: String = ''; AStrLocFis: String = ''): TUniClientDataSet;
var
  cdsEtiquetas: TUniClientDataSet;
  strID: String;
  I: Integer;
begin
  Try
    cdsEtiquetas := TUniClientDataSet.Create(Nil);
    cdsEtiquetas.FieldDefs.Add('LOCFIS', ftString, 35);
    cdsEtiquetas.FieldDefs.Add('ETIQID', ftString, 50);
    cdsEtiquetas.FieldDefs.Add('IDEDIG', ftString, 6);
    cdsEtiquetas.FieldDefs.Add('CODREC', ftString, 20);

    cdsItens.Filtered := False;

    cdsEtiquetas.CreateDataSet;

    For I := 1 To AIntNumEtiquetasID Do
    Begin
      If fEmptyStr(AStrID) Then
        strID := 'ID_PLANO_' +
                  VS_strCodEmp +
                  strIdeDig +
                  IntToStr(RandomRange(StrToIntDef(FormatDateTime('hhnnsszzz', fNow), 1) , StrToIntDef(FormatDateTime('hhnnsszzz', fNow), 1) * I))
      Else
        strID := AStrID;

      cdsEtiquetas.Insert;
      cdsEtiquetas.FieldByName('LOCFIS').AsString := 'Localização: '+ AStrLocFis;
      cdsEtiquetas.FieldByName('ETIQID').AsString := strID;
      cdsEtiquetas.FieldByName('IDEDIG').AsString := strIdeDig;
      cdsEtiquetas.FieldByName('CODREC').AsString := strAdcSeqGer;

      cdsEtiquetas.Post;
    End;

    cdsItens.Filtered := True;

    Result := cdsEtiquetas;
  Except On
   E:Exception Do
    Begin
      Result := Nil;
      pMensagensErro(E.Message, 'TfrmPlanoDeRecebimento.fCriaCdsEtiquetasID');
    End;
  End;
end;

procedure TfrmPlanoDeRecebimento.pImprimirEtiquetasPadrao;
var
  prmDllEtq : TParamDllEtiquetas;
  ArrNomEti : TStringArray;
  strTipEti : String;
begin
  inherited;

  If not fEmptyStr(cdsItens.FieldByName('AUTINC').AsString) Then
  Begin
    Try
      prmDllEtq := TParamDllEtiquetas.Create;
      prmDllEtq.strAutInc := ShortString(cdsItens.FieldByName('AUTINC').AsString);
      prmDllEtq.cdsPlanoRecebimento := TUniClientDataSet.Create(nil);
      prmDllEtq.cdsPlanoRecebimento.Data := cdsItens.Data;

      strTipEti := fCfgSis('PLAREC', varString);

      If strTipEti = 'L' Then
        prmDllEtq.tpeTipEtq := tpePlanoRecebWMSLaser
      Else
      If strTipEti = 'A' Then
        prmDllEtq.tpeTipEtq := tpePlanoRecebWMSArgox
      Else
      Begin
        SetLength(ArrNomEti, 0);
        pAddDados(ArrNomEti, 'Laser');
        pAddDados(ArrNomEti, 'Argox');
        Case fGetMenu('Escolha o Modelo:', ArrNomEti, 1, True) Of
          1: prmDllEtq.tpeTipEtq := tpePlanoRecebWMSLaser;
          2: prmDllEtq.tpeTipEtq := tpePlanoRecebWMSArgox;
        End;
      End;

    Finally
        fImprimeEtiqueta(prmDllEtq, 'fimprimeetiquetas');
        FreeAndNil(prmDllEtq.cdsPlanoRecebimento);
        FreeAndNil(prmDllEtq);
    End;
  End;
End;

procedure TfrmPlanoDeRecebimento.btnProcCubClick(Sender: TObject);
begin
  inherited;
  blnCarregandoPlano := False;
  If (Not blnAlterando) And (blnPlanoJaConfirmado) Then
    Exit;

  blnProcessandoCubagem := True;
  pProcessarCubagem;
end;

procedure TfrmPlanoDeRecebimento.btnReimprimirEtiquetaClick(Sender: TObject);
begin
  inherited;
  If (Not qryEtique.isEmpty) And (Pos('ID_PLANO', qryEtique.FieldByName('CHAVE').AsString) = 0) Then
    Exit;

  pReImprimirEtiquetaID(qryEtique.FieldByName('ID').AsString, True, qryEtique.FieldByName('LOCFIS').AsString);
end;

procedure TfrmPlanoDeRecebimento.pProcessarCubagem;
begin
  cdsItens.DisableControls;
  cdsItens.Filter := 'MODCUB = ' + QuotedStr('A');
  cdsItens.Filtered := True;
  cdsLocSug.BeforePost := Nil;
  stlLocExcSelecionados.Clear;
  cdsLocSug.DisableControls;

  If cdsItens.FieldByName('MOVEFE').AsString = 'N' Then
    cdsLocSug.EmptyDataSet;
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fCalculaSugestaoLocalizacaoFisicas;
    frmGravando.lblGravando.Caption := 'Processando cubagem automática...';
    frmGravando.ShowModal;
  Finally
    cdsItens.EnableControls;
    cdsItens.Filtered := False;
    btnImprimir.Enabled := False;//frmGravando.blnConfirma;
    FreeAndNil(frmGravando);
    cdsLocSug.BeforePost := cdsLocSugBeforePost;
    If chkAllPick.Checked Then
      chkAllPick.Checked := False;
    blnProcessandoCubagem := False;
    cdsLocSug.EnableControls;
  End;
end;

procedure TfrmPlanoDeRecebimento.btnSairClick(Sender: TObject);
begin
  inherited;
  blnAlterando := False;
  pResetTela;
  pLimparPreRessuprimento;
end;

procedure TfrmPlanoDeRecebimento.pLimparPreRessuprimento;
var
  qryDel: TUniQuery;
begin
  If Not fCfgSis('SUGBAN', varBoolean) Then
    Exit;

  Try
    qryDel := fCriaQuery;
    Try
      qryDel.SQL.Clear;
      qryDel.SQL.Add('DELETE FROM PRE_RESSUPRIMENTO WHERE IDSESSAO = (SELECT CONNECTION_ID())');
      fStartTransaction;
      qryDel.ExecSQL;
      fCommit;
    Except On E:Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, 'TfrmPlanoDeRecebimento.pLimparPreRessuprimento');
      End;
    End;
  Finally
    FreeAndNil(qryDel)
  End;
end;

procedure TfrmPlanoDeRecebimento.btnTirarProdutoClick(Sender: TObject);
var
  qryUpd: TUniQuery;
begin
  inherited;
  If (Not qryEtique.isEmpty) And (Pos('ID_PLANO', qryEtique.FieldByName('CHAVE').AsString) = 0) Then
    Exit;

  Try
    qryUpd := fCriaQuery;
    qryUpd.SQL.Add('DELETE FROM ETIRIT WHERE AUTOINCREM = :AUTINC');
    qryUpd.ParamByName('AUTINC').AsString := qryEtique.FieldByName('RIT_AUTINC').AsString;
    Try
      fStartTransaction;
      qryUpd.ExecSQL;
      fCommit;
    Except On
      E:Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, 'TfrmPlanoDeRecebimento.btnTirarProdutoClick');
      End;
    End;
  Finally
    FreeAndNil(qryUpd);
    pProcessarEtiquetasID;
  End;
end;

function TfrmPlanoDeRecebimento.fLocalizacaPiking(AStrLocFis: String): Boolean;
begin
  FqryConsulta.SQL.Clear;
  FqryConsulta.SQL.Add('SELECT COUNT(1) AS QTD FROM CADLOC ');
  FqryConsulta.SQL.Add(' WHERE LOC_CODLOC = "'+ AStrLocFis+'"');
  FqryConsulta.SQL.Add('   AND LOC_CODEMP = "'+VS_StrCodEmp+'"');
  FqryConsulta.SQL.Add('   AND LOC_PICKIN = "S"');
  FqryConsulta.Open;

  Result :=    FqryConsulta.FieldByName('QTD').AsInteger > 0;

end;

function TfrmPlanoDeRecebimento.fLocExcJaSelecionada(AStrChave: String): Boolean;
var
  I:Integer;
begin
  Result := False;
  For I := 0 To Pred(stlLocExcSelecionados.Count) Do
  Begin
    If SplitString(stlLocExcSelecionados[I], '$')[0] = AStrChave Then
      Exit(True);
  End;
end;

procedure TfrmPlanoDeRecebimento.cdsLocSugAfterPost(DataSet: TDataSet);
begin
  inherited;
  If blnModCub Then
    btnConfirma.Enabled := True;
end;

procedure TfrmPlanoDeRecebimento.cdsLocSugBeforePost(DataSet: TDataSet);
var
  strChave: String;
  idxIndex: Integer;
begin
  inherited;
  If (blnPriPik) And (DataSet.FieldByName('ABPICK').AsString = 'S') Then
  Begin
    DataSet.FieldByName('SELECE').AsBoolean := True;
    Exit;
  End;

  If DataSet.state in [dsInsert, dsEdit] Then
  Begin
    If Not cdsLocSug.FieldByName('EXCESS').AsBoolean Then
      Exit;

    strChave := DataSet.FieldByName('CHAVE').AsString + '$' + DataSet.FieldByName('LOCFIS').AsString;
    idxIndex := stlLocExcSelecionados.IndexOf(strChave);

    If (fLocExcJaSelecionada(DataSet.FieldByName('CHAVE').AsString)) Then
    Begin
      If (DataSet.FieldByName('SELECE').AsBoolean) Then
        DataSet.FieldByName('SELECE').AsBoolean := False
      Else
        If idxIndex > -1 Then
          stlLocExcSelecionados.Delete(idxIndex);
    End
    Else
    Begin
      If (DataSet.FieldByName('SELECE').AsBoolean) Then
        stlLocExcSelecionados.Add(strChave);
    End;
  End;
End;

procedure TfrmPlanoDeRecebimento.chkAllPickClick(Sender: TObject);
begin
  inherited;
  If chkAllPick.Checked And blnPriPik Then
  Begin
    cdsLocSug.Filtered := False;
    cdsLocSug.AfterScroll := cdsSugestAfterScroll;
    cdsLocSug.Filter   := 'ABPICK = ' + QuotedStr('S');
    cdsLocSug.Filtered := True;
    cdsItens.AfterScroll  := nil;
  End
  Else
  Begin
    cdsItens.AfterScroll  := pFiltraSugestaoCds;
    cdsLocSug.AfterScroll := nil;
    If cdsItens.Active Then
      cdsItens.First;
  End;

  cxgSugestaoTableView.ViewData.Expand(True);
end;

procedure TfrmPlanoDeRecebimento.cdsSugestAfterScroll(DataSet: TDataSet);
var
  blnAfterScroll: Boolean;
Begin
  blnAfterScroll := Assigned(cdsItens.AfterScroll);
  If blnAfterScroll Then
    cdsItens.AfterScroll := nil;

  If cdsItens.Active Then
   cdsItens.Locate('CHAVE;MODCUB', VarArrayOf([cdsLocSug.FieldByName('CHAVE').AsString,'A']), []);

  If blnAfterScroll Then
    cdsItens.AfterScroll := pFiltraSugestaoCds;
End;

procedure TfrmPlanoDeRecebimento.cxgEtiquetaTableViewCanFocusRecord(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
begin
  inherited;
  AAllow := Pos('FORA', VarToStr(Sender.DataController.Values[ARecord.RecordIndex, cxgEtiquetaTableViewCHAVE.Index])) <= 0;
end;

procedure TfrmPlanoDeRecebimento.cxgEtiquetaTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgEtiquetaTableViewSTATUS.Index]) = 'F' Then
  Begin
    ACanvas.Brush.Color := clMoneyGreen;
  End;
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgEtiquetaTableViewSTATUS.Index]) = 'E' Then
  Begin
    ACanvas.Brush.Color := $004080FF;
  End;
  If Pos('PRODUTOS COM QUANTIDADE RESTANTE A SER LIDA', VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgEtiquetaTableViewCHAVE.Index])) > 0 Then
  Begin
    ACanvas.Font.Color := clBlack;
  End
  Else
  If fEmptyStr(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgEtiquetaTableViewID.Index])) Then
  Begin
    ACanvas.Font.Color := clRed;
  End;
end;

procedure TfrmPlanoDeRecebimento.cxgEtiquetaTableViewFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
var
  strStatus: String;
begin
  inherited;
  strStatus := qryEtique.FieldByName('STATUS').AsString;

  btnLimparEtiqueta.Enabled := (Not (strStatus = 'E')) And (qryEtique.FieldByName('ID').AsString <> '');
  btnTirarProduto.Enabled := btnLimparEtiqueta.Enabled;
  btnSugerirLocFisica.Enabled := btnLimparEtiqueta.Enabled;
  btnLimparLocFisica.Enabled := btnLimparEtiqueta.Enabled;
  btnReimprimirEtiqueta.Enabled := qryEtique.FieldByName('ID').AsString <> '';

  cxgEtiquetaTableViewLOCFIS.Options.Editing := strStatus = 'F';
end;

procedure TfrmPlanoDeRecebimento.cxgEtiquetaTableViewKeyPress(Sender: TObject;
  var Key: Char);
Var
    qryTabela : TUniQuery;
    chrKey : Char;
    arrSel : TConsultasArray;
begin
  inherited;

  If pnlPlanoJaFinalizado.Visible Then
    Exit;

  If qryEtique.FieldByName('STATUS').AsString = 'E' Then
    Exit;

  If fEntraCons(Key) Then
  Begin

    If Not( fVerificaAcessoSistema('altLocFisEtiquetaID')) Then
    Begin
      pMensagemOk('Operador sem direito de acesso para alterar esta localização física!');
      Exit;
    End;
    qryTabela := fCriaQuery;
    chrKey := '/';
    If fPesqLocFisica(Self, nil, nil, qryTabela, chrKey, arrSel, True, False, True, False, False, '', True) Then
    Begin
      If fValidaLocalSelecionado(qryTabela.FieldByName('LOC_CODLOC').AsString) Then
      Begin
        pAtualizarLocFisicaEtiquetaID(qryTabela.FieldByName('LOC_CODLOC').AsString);
      End;
    End;
    FreeAndNil(qryTabela);
  End;
end;

procedure TfrmPlanoDeRecebimento.pAtualizarLocFisicaEtiquetaID(AStrLocFis: String);
var
  qryUpd: TUniQuery;
begin
  inherited;
  If (Not qryEtique.isEmpty) And (Pos('ID_PLANO', qryEtique.FieldByName('CHAVE').AsString) = 0) Then
    Exit;

  Try
    qryUpd := fCriaQuery;
    qryUpd.SQL.Add('UPDATE ETIREC SET ETI_LOCFIS = :LOCFIS WHERE AUTOINCREM = :AUTINC');
    qryUpd.ParamByName('LOCFIS').AsString := AStrLocFis;
    qryUpd.ParamByName('AUTINC').AsString := qryEtique.FieldByName('REC_AUTINC').AsString;
    Try
      fStartTransaction;
      qryUpd.ExecSQL;
      fCommit;
    Except On
      E:Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, 'TfrmPlanoDeRecebimento.pAtualizarLocFisicaEtiquetaID');
      End;
    End;
  Finally
    FreeAndNil(qryUpd);
    pProcessarEtiquetasID;
  End;
end;

procedure TfrmPlanoDeRecebimento.cxgItensTableViewABPICKGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  AText := '';
end;

procedure TfrmPlanoDeRecebimento.cxgItensTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    APainter: TcxPainterAccess;
    strCheExc: String;
begin
  inherited;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTableViewIMPETI.Index]) = 'S' Then
  Begin
    ACanvas.Font.Color := clGreen;
  End;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTableViewEXCEDE.Index]) = 'S' Then
  Begin
    ACanvas.Brush.Color := $008080FF;
  End;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTableViewSELECE.Index]) = 'S' Then
  Begin
    ACanvas.Brush.Color := clSkyBlue;
  End;

  If (AViewInfo.Item.Index = cxgItensTableViewCLASSE.Index) Then
  Begin
    If fEmptyStr(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, AViewInfo.Item.Index])) Then
    Begin
      APainter := TcxPainterAccess(TcxViewInfoAcess(AViewInfo).GetPainterClass.Create(ACanvas, AViewInfo));
      With APainter Do
      Begin
        Try
          DrawBorders;
          Canvas.Brush.Color := clRed;
          With AViewInfo.ClientBounds Do
          Begin
            ACanvas.Canvas.Rectangle( Left+1, Top+1, Left+17, Top+17 );
          End;
        Finally
          Free;
        End;
      End;
      ADone := True;
    End
    Else
    Begin
      If blnClaPic Then
      Begin
        strCheExc := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTableViewCLA_CHEEXC.Index]) ;
        Case AnsiIndexStr(strCheExc, ['S','N']) Of
          0: Begin
               ACanvas.Font.Color := clWhite;
               ACanvas.Brush.Color := shpPicExc.Brush.Color;
             End;
          1: Begin
               ACanvas.Font.Color := clWhite;
               ACanvas.Brush.Color := shpClaPic.Brush.Color;
             End;
        End;
      End;
    End;
  End;

end;

procedure TfrmPlanoDeRecebimento.cxgItensTableViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;
  If fCfgSis('MVFEXC', varBoolean) Then
    AAllow := (cdsItens.FieldByName('EXCEDENTE').AsString = 'N') And (cdsItens.FieldByName('QTDEND').AsFloat = 0)
  Else
    AAllow := (cdsItens.FieldByName('QTDEND').AsFloat = 0);

end;

procedure TfrmPlanoDeRecebimento.cxgItensTableViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
var
  strValue: String;
begin
  inherited;
  If cxgItensTableViewCLASSE.Focused Then
  Begin
    strValue := VarToString(AEdit.EditValue);
    If (Key = VK_RETURN) And (Not strValue.isEmpty) Then
    Begin
      pReplicarValorClasse(strValue);
    End;
  End;
end;

procedure TfrmPlanoDeRecebimento.pSelecionarParaCubagem;
var
  intRecNo: Integer;
begin
  intRecNo := cdsItens.RecNo;
  cdsItens.BeforePost := Nil;
  cdsItens.DisableControls;
  Try

    If cdsItens.FieldByName('SELECE').AsString = 'S' Then
    Begin
      If intNumSelecParaCubagem > 1 Then
        Inc(intNumSelecParaCubagem, -1);
    End
    Else
    Begin
      Inc(intNumSelecParaCubagem, 1);
    End;

    cdsItens.Edit;
    cdsItens.FieldByName('SELECE').AsString := IIF(cdsItens.FieldByName('SELECE').AsString = 'S', 'N', 'S');
    cdsItens.Post;
  Finally
    cdsItens.EnableControls;
    cdsItens.BeforePost := pBeforePost;
    cdsItens.RecNo := intRecNo;
  End;
end;

procedure TfrmPlanoDeRecebimento.pReplicarValorClasse(AClasse: String);
var
  intRecBkp: Integer;
  cdsDados: TDataSet;
begin
  If Not fMensagem('', 'Deseja replicar a classe local para todos os itens que ainda estão em branco?', ['&Sim', '&Não']) = 1 Then
    Exit;

  cdsDados := cxgItensTableView.DataController.DataSource.DataSet;
  intRecBkp := cdsDados.RecNo;
  cdsDados.First;

  While Not cdsDados.Eof Do
  Begin
    if Not cdsDados.FieldByName('CLASSE').AsString.isEmpty Then
      cdsDados.Next;

    cdsDados.Edit;
    cdsDados.FieldByName('CLASSE').AsString := AClasse;
    cdsDados.Post;
    cdsDados.Next;
  End;

  cdsDados.RecNo := intRecBkp;
end;

procedure TfrmPlanoDeRecebimento.cxgItensTableViewEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  inherited;

  If (AItem.Index = cxgItensTableViewCLASSE.Index) Then
  Begin
    If (TcxComboBoxProperties(cxgItensTableViewCLASSE.Properties).Items.Count = 0) Then
    Begin
      If fEntraCons(Key) Then
      Begin
        Key := #0;
        postMessage(Self.Handle, WM_GO_TO_CONSULTA, 0, 0);
      End;
    End;
  End;
end;

procedure TfrmPlanoDeRecebimento.cxgItensTableViewFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  inherited;

  If cxgItensTableViewCLASSE.Focused Then
    pPopularComboBoxClasses(cdsItens.FieldByName('CODITE').AsString);
end;

procedure TfrmPlanoDeRecebimento.cxgItensTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If blnModCub Then
  Begin
    If Key = VK_SPACE Then
      pSelecionarParaCubagem;

    If (ssShift in Shift) Then
    Begin
      If (Key = VK_UP) Or (Key = VK_DOWN) Then
        pSelecionarParaCubagem;
    End;
  End;
end;

procedure TfrmPlanoDeRecebimento.cxgItensTableViewMODCUBGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  Case AnsiIndexStr(AText, ['A','M']) oF
    0: AText := 'Automático';
    1: Atext := 'Manual';
  End;
end;

procedure TfrmPlanoDeRecebimento.cxgItensTableViewQTDCONCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTableViewABPICK.Index]) = 'S' Then
    Exit;

  If (AViewInfo.GridRecord.Selected) And (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTableViewCONFER.Index]) <> 'MAIS') Then
  Begin
    ACanvas.Font.Style := [];
    ACanvas.Font.Color := clWhite;
    Exit;
  End;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTableViewCONFER.Index]) = 'MAIS' Then
  Begin
    ACanvas.Font.Style := [fsBold];
    ACanvas.Font.Color := clRed;
  End
  Else
  Begin
    ACanvas.Font.Style := [];
    ACanvas.Font.Color := clBlack;
  End;
end;

procedure TfrmPlanoDeRecebimento.cxgItensTableViewQTDCONPropertiesEditValueChanged(
  Sender: TObject);
var
  objLiberacao        : TLiberacao;
  qryDigEle           : TUniQuery;
begin
  inherited;
  if not cdsItens.Active then
    exit;

  If cdsItens.State = dsEdit then
  begin
     If (fConferenciaAntesDoPlanoDeRecebimento And (AnsiIndexStr(UpperCase(cdsItens.FieldByName('STATUS').AsString), ['CN','EP']) < 0))
     or ((not fConferenciaAntesDoPlanoDeRecebimento) And (cdsItens.FieldByName('STATUS').AsString <> 'CN'))  Then
     begin
       pMensagemOk('Não é possível alterar a quantidade conferida deste plano, pois a conferência ainda não foi finalizada!');
       cdsItens.Cancel;
       exit;
     end;

    If ( TcxCalcEdit(Sender).Value < 0) Then
    begin
      pMensagemOk('A quantidade conferida não pode ser menor que zero!');
      cdsItens.Cancel;
      exit;
    end;

    If (TcxCalcEdit(Sender).Value <  cdsItens.FieldByName('QTDEND').AsFloat) Then
    begin
      pMensagemOk(        'A quantidade conferida não pode ser menor que a quantidade endereçada:'
                  + #13 + 'Quantidade Endereçada: ' + FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), cdsItens.FieldByName('QTDEND').AsFloat));
      cdsItens.Cancel;
      exit;
    end;

    If (cdsItens.FieldByName('QTDDEV').AsFloat > 0) and (TcxCalcEdit(Sender).Value > (cdsItens.FieldByName('QTDITE').AsFloat - cdsItens.FieldByName('QTDDEV').AsFloat)) Then
    begin
      pMensagemOk(        'A quantidade conferida não pode ser maior que a quantidade da nota menos a quantidade devolvida ao fornecedor:'
                  + #13 + 'Quantidade Nota: ' + FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), cdsItens.FieldByName('QTDITE').AsFloat)
                  + #13 + 'Quantidade Devolvida: ' + FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), cdsItens.FieldByName('QTDDEV').AsFloat)
                  + #13 + 'Quantidade Máxima Permitida: ' + FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), cdsItens.FieldByName('QTDITE').AsFloat - cdsItens.FieldByName('QTDDEV').AsFloat));
      cdsItens.Cancel;
      exit;
    end;


    objLiberacao := TLiberacao.Create;
    try
      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'PLACON';
      objLiberacao.strMsgSen    := 'Alteração de quantidade conferida';
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto('Alteração de quantidade conferida');
      objLiberacao.objMsgLibera.pAddSeparador();
      objLiberacao.objMsgLibera.pAddTextoCaption('Sequencial de recebimento', strIdeDig);
      objLiberacao.objMsgLibera.pAddTextoCaption('Item',                      cdsItens.FieldByName('CODITE').AsString + '-' + cdsItens.FieldByName('DESITE').AsString);
      objLiberacao.objMsgLibera.pAddSeparador();
      objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade nota'               , FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), cdsItens.FieldByName('QTDITE').AsFloat) , 29);
      objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade endereçada'         , FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), cdsItens.FieldByName('QTDEND').AsFloat) , 29);
      objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade devolvida'          , FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), cdsItens.FieldByName('QTDDEV').AsFloat) , 29);
      objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade conferida atual'    , FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), cdsItens.FieldByName('QTDCON').AsFloat) , 29);
      objLiberacao.objMsgLibera.pAddSeparador();
      objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade conferida digitada' , FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), TcxCalcEdit(Sender).Value)              , 29);


      If not objLiberacao.fLibera then
      begin
        cdsItens.Cancel;
        Exit;
      end;

    finally
      FreeAndNil(objLiberacao);
    end;

    cdsItens.FieldByName('QTDCON').AsFloat := TcxCalcEdit(Sender).Value;
    cdsItens.Post;

    if cdsItens.FieldByName('QTDCON').AsFloat <> cdsItens.FieldByName('QTDCONOLD').AsFloat then
    begin
      qryDigEle := fCriaQuery();
      try
        qryDigEle.SQL.Add('SELECT                     ');
        qryDigEle.SQL.Add('  *                        ');
        qryDigEle.SQL.Add('FROM                       ');
        qryDigEle.SQL.Add('  DIGELE                   ');
        qryDigEle.SQL.Add('WHERE                      ');
        qryDigEle.SQL.Add('      DIG_IDEDIG = :IDEDIG ');
        qryDigEle.SQL.Add('  AND DIG_CODEMP = :CODEMP ');
        qryDigEle.SQL.Add('  AND DIG_CODITE = :CODITE ');

        qryDigEle.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryDigEle.ParamByName('IDEDIG').AsString := strIdeDig;
        qryDigEle.ParamByName('CODITE').AsString := cdsItens.FieldByName('CODITE').AsString;

        qryDigEle.Open;

        if cdsItens.FieldByName('QTDCON').AsFloat = 0 then
          qryDigEle.Delete
        else begin
          if qryDigEle.isEmpty then
          begin
            qryDigEle.Append;
            qryDigEle.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('DIGELE', VS_strCodEmp);
            qryDigEle.FieldByName('DIG_CODITE').AsString := cdsItens.FieldByName('CODITE').AsString;
            qryDigEle.FieldByName('DIG_IDEDIG').AsString := strIdeDig;
            qryDigEle.FieldByName('DIG_CODEMP').AsString := VS_strCodEmp;
          end
          else
            qryDigEle.Edit;

          qryDigEle.FieldByName('DIG_QTDITE').AsFloat := cdsItens.FieldByName('QTDCON').AsFloat;

          qryDigEle.Post;

        end;
      finally
        FreeAndNil(qryDigEle);
      end;

    end;
  end;
end;

procedure TfrmPlanoDeRecebimento.cxgSugestaoEnter(Sender: TObject);
begin
  inherited;
  cxgSugestaoTableView.OptionsData.Editing := cdsItens.FieldByName('IMPETI').AsString <> 'S';
  lblPesquisa.Visible := cdsItens.FieldByName('IMPETI').AsString <> 'S';

  If blnSugestaoViaBanco Then
  Begin
    cxgSugestaoTableView.OptionsData.Editing := True;
    lblPesquisa.Visible := True;
  End;


end;

procedure TfrmPlanoDeRecebimento.cxgSugestaoExit(Sender: TObject);
begin
  inherited;
  lblPesquisa.Visible := False;
end;

procedure TfrmPlanoDeRecebimento.cxgSugestaoTableViewABPICKCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgSugestaoTableViewABPICK.Index]) = 'S'  Then
  Begin
    ACanvas.Brush.Color := $00FF0080;
    ACanvas.Font.Color := clWhite;
  End;
end;

procedure TfrmPlanoDeRecebimento.cxgSugestaoTableViewABPICKGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  AText := '';
end;

procedure TfrmPlanoDeRecebimento.cxgSugestaoTableViewCanFocusRecord(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
begin
  inherited;
  {}
end;

procedure TfrmPlanoDeRecebimento.cxgSugestaoTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
   If AViewInfo.Item = cxgSugestaoTableViewLocFis Then
   If ((Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgSugestaoTableViewBufVen.Index]) = 'S') And
      ((Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgSugestaoTableViewFISPIC.Index]) =
       (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgSugestaoTableViewLocFis.Index])) Then
     ACanvas.Font.Color := clRed;
end;

procedure TfrmPlanoDeRecebimento.cxgSugestaoTableViewKeyPress(Sender: TObject; var Key: Char);
  Var
    qryTabela : TUniQuery;
    chrKey : Char;
    arrSel : TConsultasArray;
begin
  inherited;

  If cdsItens.FieldByName('IMPETI').AsString = 'S' Then
    Exit;

  If (cxgSugestaoTableViewLocFis.Focused) And fEntraCons(Key) Then
  Begin
    qryTabela := fCriaQuery;
    chrKey := '/';
    If fPesqLocFisica(Self, nil, nil, qryTabela, chrKey, arrSel, True, False, True) Then
    Begin
      If fValidaLocalSelecionado(qryTabela.FieldByName('LOC_CODLOC').AsString) Then
      Begin
        cdsLocSug.Edit;
        cdsLocSug.FieldByName('LOCFIS').AsString := qryTabela.FieldByName('LOC_CODLOC').AsString;
        cdsLocSug.Post;
      End;

    End;

    FreeAndNil(qryTabela);

  End;
end;

procedure TfrmPlanoDeRecebimento.cxgSugestaoTableViewLocFisCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  blnExc: Boolean;
begin
  inherited;
  Try
    blnExc := (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgSugestaoTableViewEXCESS.Index]);
  Except
    blnExc := False;
  End;
  If blnExc Then
  Begin
    ACanvas.Brush.Color := $006F9DFF;
    ACanvas.Font.Color := clBlack;
  End;
end;

procedure TfrmPlanoDeRecebimento.edtIdeDigKeyPress(Sender: TObject; var Key: Char);
  Var
    qryConsulta : TUniQuery;
    arrSel : TConsultasArray;
    strStatus: String;
begin
  inherited;
  If not fEntraCons(Key) Then
    Exit;

  strStatus := '';
  If Not blnEtqCon Then
  Begin
    strStatus := '"CN","EP"';
    If Not fConferenciaAntesDoPlanoDeRecebimento Then
      strStatus := strStatus + ',"EC"';
  End;

  Try
    qryConsulta := fCriaQuery;
    If fPesqAgendamentoEntregaWMS(Self, Nil, qryConsulta, Key, arrSel, True, strStatus) Then
    Begin
      edtIdeDig.Text := qryConsulta.FieldByName('ARC_IDEDIG').Text;
      fValidaCampos(edtIdeDig, True);
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmPlanoDeRecebimento.edtPlaca_KeyPress(Sender: TObject; var Key: Char);
  Var
    qryConsulta : TUniQuery;
    arrSel : TConsultasArray;
    strStatus: String;
begin
  inherited;
  If not fEntraCons(Key) Then
    Exit;

  strStatus := '';
  If Not blnEtqCon Then
  Begin
    strStatus := '"CN","EP"';
    If Not fConferenciaAntesDoPlanoDeRecebimento Then
      strStatus := strStatus + ',"EC"';
  End;

  Try
    qryConsulta := fCriaQuery;
    If fPesqAgendamentoEntregaWMS(Self, Nil, qryConsulta, Key, arrSel, True, strStatus ) Then
    Begin
      edtPlaca_.Text := qryConsulta.FieldByName('ARC_PLACA_').Text;
      edtIdeDig.Text := qryConsulta.FieldByName('ARC_IDEDIG').Text;
      fValidaCampos(edtPlaca_, true);
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;

end;

procedure TfrmPlanoDeRecebimento.pGetQtdeMaxPallet(strCodIte, strSigla: String; var intCxCama, intQtCama, intQtdTot : Integer);
  Var
    qryClaIte : TUniQuery;
begin
  Try
    qryClaIte := fCriaQuery;
    With qryClaIte, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT CIT_QTDTOT,         ');
      Add('        CIT_CXCAMA,         ');
      Add('        CIT_QTCAMA          ');
      Add(' FROM CLAITE                ');
      Add(' WHERE CIT_CODEMP = :CODEMP ');
      Add('   AND CIT_CODITE = :CODITE ');
      Add('   AND CIT_SIGLA_ = :SIGLA_ ');

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('SIGLA_').AsString := strSigla;

      Open;

      intCxCama := FieldByName('CIT_CXCAMA').AsInteger;
      intQtCama := FieldByName('CIT_QTCAMA').AsInteger;
      intQtdTot := FieldByName('CIT_QTDTOT').AsInteger;

      Close;
    End;

  Finally
    FreeAndNil(qryClaIte);
  End;

end;

function TfrmPlanoDeRecebimento.fGetSQLClasseClaPic(ABblnAbPick: Boolean): String;
begin
  Result := '';
  Result := Result + 'IF((LOCATE(ADC_CODFOR, (SELECT GROUP_CONCAT(EMP_FORFIL) FROM CADEMP)) > 0) AND (IFNULL(AIT_CLASSE, "") = ""), ';
  Result := Result + '   fRetClassePickingItemPlano(DET_CODITE, ARC_CODEMP, ' + fGetSQLDET_QTDITE(ABblnAbPick) +', 0, ""), ';
  Result := Result + '   IFNULL(AIT_CLASSE,                                                                 ';
  Result := Result + '          IF(  ( (@QTDNOR = 0) OR (IFNULL(DET_NUMLOT, "A DEFINIR") <> "A DEFINIR") )  ';
  Result := Result + '             , NULL                                                                   ';
  Result := Result + '             , (SELECT AIT_CLASSE FROM AGEITE                                         ';
  Result := Result + '                INNER JOIN AGEREC ON AGEREC.AUTOINCREM = AGEITE.AIT_SEQGER            ';
  Result := Result + '                WHERE AGEITE.AIT_CLASSE IS NOT NULL                                   ';
  Result := Result + '                AND AGEREC.ARC_CODEMP = R.ARC_CODEMP                                  ';
  Result := Result + '                AND AGEITE.AIT_CODITE = DET_CODITE                                    ';
  Result := Result + '                ORDER BY AGEITE.AUTOINCREM DESC                                       ';
  Result := Result + '                LIMIT 1))))                                                           ';
end;

function TfrmPlanoDeRecebimento.fGetSQLDET_QTDITE(ABlnAbPick: Boolean): String;
begin
  If Not ABlnAbPick Then
  Begin
    Result := '';
    Result := Result + ' ABS(IFNULL                                       ';
    Result := Result + '     (IF(DIG_QTDITE < AIT_QTDTOT,                 ';
    Result := Result + '        DIG_QTDITE - IFNULL(AIT_QTDPIK,0),        ';
    Result := Result + '        AIT_QTDTOT - IFNULL(AIT_QTDPIK, 0)),      ';
    Result := Result + '     SUM(DET_QTDITE) - (IFNULL(AIT_QTDPIK, 0))))  ';
  End
  Else
  Begin
    Result := '';
    Result := Result + '  IFNULL((SELECT SUM(IL2.AIL_QTDVEN) FROM AGEILO IL2 WHERE AIL_SEQITE = E.AUTOINCREM AND AIL_PICKNG = "S"), 0) ';
  End;
end;

function TfrmPlanoDeRecebimento.fGetSQL: String;
var cfg_3Dig,
    cfg_Claret,
    cfg_4Dig: string;
begin
  cfg_3Dig :=  '_933';
  cfg_Claret :=  fTransform(fCfgSis('CLARET'), 4);
  cfg_4Dig := '_1922_2922_';
  If Not fCfgSis('MVFEXC', varBoolean) Then
  Begin
    Result := '';
    Result := Result + ' SELECT * FROM (                                    ';
    Result := Result + ' SELECT ARC_CODIGO AS CODIGO,                       ';
    Result := Result + '        R.ARC_IDEDIG,                               ';
    Result := Result + '        ADC_SEQGER,                                 ';
    Result := Result + '        ADC_CODFOR,                                 ';
    Result := Result + '        CAST("N" AS CHAR(1)) AS EXCEDENTE ,         ';
    Result := Result + '        CAST("N" AS CHAR(1)) AS SELECE ,            ';
    Result := Result + '        CAST("N" AS CHAR(1)) AS ABPICK ,            ';
    Result := Result + '        UNI_SIGUNI,                                 ';
    Result := Result + '        AIT_MODCUB AS MODCUB,                       ';
    Result := Result + '        ARC_MOVEFE AS MOVEFE,                       ';
    Result := Result + '        ARC_DESPAL,			                            ';
    Result := Result + '        R.AUTOINCREM AS AUTINC,                     ';
    Result := Result + '        I.ITE_CODITE AS CODITE,                     ';
    Result := Result + '        I.ITE_ATICOM AS ATICOM,                     ';
    Result := Result + '        I.ITE_ITEATI AS ITEATI,                     ';
    Result := Result + '        0 AS QTDITE_POR_ETIQUETA,                   ';
    Result := Result + '        ITE_DESITE AS DESITE,                       ';

    Result := Result + fGetSQLQuantidades(False);

    Result := Result + '        ' + fGetSQLTriEmbala + '  AS EMBALA,                   ';
    If blnSugereLocalizacao then
      Result := Result + ' @CLASSE := AIT_CLASSE AS CLASSE, '
    Else
    Begin
      If blnClaPic Then
      Begin
        Result := Result + ' @CLASSE := ' + fGetSQLClasseClaPic(False) + ' AS CLASSE,                                          ';
        Result := Result + ' fRetClassePickingItemPlano(DET_CODITE, ARC_CODEMP, ' + fGetSQLDET_QTDITE(False) +' , 1,' + fGetSQLClasseClaPic(False) +' ) AS CLA_CHEEXC, ';
      End
      Else
      Begin
        Result := Result + ' @CLASSE := IFNULL(AIT_CLASSE,                                                                     ';
        Result := Result + '                   IF(  ( (@QTDNOR = 0) OR (IFNULL(DET_NUMLOT, "A DEFINIR") <> "A DEFINIR") )      ';
        Result := Result + '                      , NULL                                                                       ';
        Result := Result + '                      , (SELECT AIT_CLASSE FROM AGEITE                                             ';
        Result := Result + '                         INNER JOIN AGEREC ON AGEREC.AUTOINCREM = AGEITE.AIT_SEQGER                ';
        Result := Result + '                         WHERE AGEITE.AIT_CLASSE IS NOT NULL                                       ';
        Result := Result + '                         AND AGEREC.ARC_CODEMP = R.ARC_CODEMP                                      ';
        Result := Result + '                         AND AGEITE.AIT_CODITE = DET_CODITE                                        ';
        Result := Result + '                         ORDER BY AGEITE.AUTOINCREM DESC                                           ';
        Result := Result + '                         LIMIT 1))) AS CLASSE,                                                     ';
      End;
    End;

    Result := Result + '        "N" AS APEPIC,                              ';
    Result := Result + '        IFNULL(CIT_CXCAMA,0) AS CXCAMA,             ';
    Result := Result + '        IFNULL(CIT_QTCAMA,0) AS QTCAMA,             ';
    Result := Result + '        IFNULL(CIT_QTDTOT,0) AS QTDTOT,             ';
    Result := Result + '        ARC_DTAREC AS DTAREC,                       ';
    Result := Result + '        ARC_HRAREC AS HRAREC,                       ';
    Result := Result + '        ARC_OPEREC AS OPEREC,                       ';
    Result := Result + '        ARC_STATUS AS STATUS,                       ';
    Result := Result + '        ARC_IDEDIG AS IDEDIG,                       ';
    Result := Result + '        ARC_NOMMOT AS NOMMOT,                       ';
    Result := Result + '        OPE_NOMOPE AS NOMOPE,                       ';
    Result := Result + '      G.ITE_NIVGIR AS NIVGIR,                       ';

    If blnClaPic Then
      Result := Result + '        IFNULL(AIT_QTDETI, IF(IFNULL('+ fGetSQLClasseClaPic(False) +',"") = "", 0, 1)) AS QTDETI, '
    Else
      Result := Result + '        IFNULL(AIT_QTDETI, IF(IFNULL(@CLASSE,"") = "", 0, 1)) AS QTDETI, ';

    Result := Result + '        IFNULL(AIT_QTDEND, 0) AS QTDEND,            ';
    Result := Result + '        IFNULL(AIT_QTDDEV, 0) AS QTDDEV,            ';
    Result := Result + '        IF( IFNULL(AIT_QTDEND, 0) = 0, 0, IF( IFNULL(AIT_QTDEND, 0) = IFNULL(IFNULL(DIG_QTDITE,0), SUM(DET_QTDITE)), 2, 1 )) AS LEGEND, '; //Legenda do endereçamento 0 nao endereçado, 1 parcialmente, 2 totalmente
    Result := Result + '        AIT_IMPETI AS IMPETI,                       ';
    Result := Result + '        I.ITE_REAEND, ';
    Result := Result + '        IF(E.AUTOINCREM IS NULL, @SEQ := IFNULL(@SEQ,0) + 1, E.AUTOINCREM) AS CHAVE, ';
    Result := Result + '        CAST(IFNULL(DIG_QTDITE,0) - IFNULL(AIT_QTDPIK, 0) AS DECIMAL(12,2)) QTDCON, ';
    Result := Result + '        IFNULL(DIG_QTDITE,0) AS QTDCONORI, ';
    Result := Result + '        CAST(IFNULL(DIG_QTDITE,0) - IFNULL(AIT_QTDPIK, 0) AS DECIMAL(12,2)) QTDCONOLD, ';
    Result := Result + '        IF(R.AUTOINCREM IS NOT NULL  ';
    Result := Result + '           , CASE  ';
    Result := Result + '               WHEN IFNULL(DIG_QTDITE,0) < IFNULL(AIT_QTDTOT,SUM(DET_QTDITE)) THEN "MENOS" ';
    Result := Result + '               WHEN IFNULL(DIG_QTDITE,0) > IFNULL(AIT_QTDTOT,SUM(DET_QTDITE)) THEN "MAIS" ';
    Result := Result + '               WHEN IFNULL(DIG_QTDITE,0) = IFNULL(AIT_QTDTOT,SUM(DET_QTDITE)) THEN "OK" ';
    Result := Result + '               ELSE NULL ';
    Result := Result + '             END ';
    Result := Result + '           , NULL) AS CONFER, ';
    Result := Result + '        DET_NUMLOT AS NUMLOT, ';
    Result := Result + '        IF(E.AUTOINCREM IS NULL, "N","S") AS GRAVADO';
    Result := Result + ' FROM AGEDOC D                                      ';
    Result := Result + '   INNER JOIN AGEREC R ON R.AUTOINCREM = ADC_SEQGER ';
    Result := Result + '   INNER JOIN MOVDET T ON T.DET_NUMDOC = ADC_NUMDOC ';
    Result := Result + '                      AND T.DET_ESPDOC = ADC_ESPDOC ';
    Result := Result + '                      AND T.DET_SERIE_ = ADC_SERIE_ ';
    Result := Result + '                      AND T.DET_CODFOR = ADC_CODFOR ';
    Result := Result + '                      AND T.DET_CODEMP = ADC_CODEMP ';
    Result := Result + '   INNER JOIN MOVTRI M ON M.DET_SEQGER = T.AUTOINCREM';
    Result := Result + '   INNER JOIN CADFOR ON FOR_CODFOR = DET_CODFOR     ';
    Result := Result + '   INNER JOIN AUXMOV  ON AUXMOV.AUX_SEQGER = T.DET_SEQGER ';
    Result := Result + '   LEFT  JOIN AGEITE E ON E.AIT_SEQGER = R.AUTOINCREM';
    Result := Result + '                      AND E.AIT_CODITE = DET_CODITE ';
    Result := Result + '   LEFT  JOIN CADITE I ON I.ITE_CODITE = DET_CODITE ';
    Result := Result + '   LEFT  JOIN ITEGER G ON G.ITE_CODITE = DET_CODITE ';
    Result := Result + '                      AND G.ITE_CODEMP = DET_CODEMP ';
    Result := Result + '   LEFT  JOIN CLASSE C ON C.CLA_SIGLA_ = AIT_CLASSE ';
    Result := Result + '   LEFT  JOIN CLAITE L ON L.CIT_CODITE = E.AIT_CODITE ';
    Result := Result + '                      AND L.CIT_SIGLA_ = E.AIT_CLASSE ';
    Result := Result + '   LEFT  JOIN CADOPE O ON O.OPE_CODOPE = ARC_OPEREC ';
    Result := Result + '   LEFT  JOIN DIGELE DIG ON DIG.DIG_IDEDIG = R.ARC_IDEDIG ';
    Result := Result + '                        AND DIG.DIG_CODITE = T.DET_CODITE ';
    Result := Result + '                        AND DIG.DIG_CODEMP = T.DET_CODEMP ';
    Result := Result + '  LEFT JOIN AGEILO IL ON AIL_SEQITE =  E.AUTOINCREM ';
    Result := Result + '                        AND AIL_PICKNG = "S"';
    Result := Result + '  INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI';

    If blnEtqCon Then
      Result := Result + ' WHERE TRUE '
    Else
    Begin
      If fConferenciaAntesDoPlanoDeRecebimento Then
        Result := Result + ' WHERE ((ARC_STATUS = "CN") OR (ARC_STATUS = "EP")) '
      Else
        Result := Result + ' WHERE ((ARC_STATUS = "CN") OR (ARC_STATUS = "EP") OR (ARC_STATUS = "EC")) ';
    End;

    Result := Result + '   AND ARC_CODEMP = :CODEMP ';

    If fEmptyStr(edtIdeDig.Text) Then
      Result := Result + ' AND ARC_PLACA_ = :CODIGO '
    Else
      Result := Result + ' AND ARC_IDEDIG = :CODIGO ';

    If Not fEmptyStr(cfg_Claret) then
      Result := Result + ' AND NOT(DET_CLARET = 1 AND LOCATE( DET_CLAFIS, "' + cfg_Claret + '"))';

    If Not fEmptyStr(cfg_4Dig) then
        Result := Result + ' AND NOT LOCATE(DET_CLAFIS, "' + cfg_4Dig + '")';

    If Not fEmptyStr(cfg_3Dig) then
        Result := Result + ' AND NOT LOCATE(SUBSTR(DET_CLAFIS, 2,3), "' + cfg_3Dig +'")';

    Result := Result + ' AND  IFNULL(AUXMOV.AUX_MATREV, FOR_MATREV) <> "F" ';
    Result := Result + ' AND IFNULL(I.ITE_REAEND,"N") = "S" ';

    Result := Result + ' GROUP BY IDEDIG, I.ITE_CODITE, APEPIC) ITEM_SEM_PICKING';
    Result := Result + ' WHERE EXIBIR_NO_GRID = "S"';

    If fCfgSis('MODCUB', varString) = '2' Then
    Begin
      Result := Result + ' UNION ALL ';

      Result := Result + 'SELECT';
      Result := Result + '  ARC_CODIGO AS CODIGO,';
      Result := Result + '  R.ARC_IDEDIG AS IDEDIG,';
      Result := Result + '  ADC_SEQGER,';
      Result := Result + '  ADC_CODFOR,';
      Result := Result + '  CAST("N" AS CHAR(1)) AS EXCEDENTE,';
      Result := Result + '  CAST("N" AS CHAR(1)) AS SELECE,';
      Result := Result + '  CAST("S" AS CHAR(1)) AS ABPICK,';
      Result := Result + '  UNI_SIGUNI, ';
      Result := Result + '  "A" AS MODCUB,';
      Result := Result + '  ARC_MOVEFE AS MOVEFE,';
      Result := Result + '  ARC_DESPAL,';
      Result := Result + '  R.AUTOINCREM AS AUTINC,';
      Result := Result + '  I.ITE_CODITE AS CODITE,';
      Result := Result + '        I.ITE_ATICOM AS ATICOM,                     ';
      Result := Result + '        I.ITE_ITEATI AS ITEATI,                     ';
      Result := Result + '  0 AS QTDITE_POR_ETIQUETA,';
      Result := Result + '  ITE_DESITE AS DESITE,';

      Result := Result + fGetSQLQuantidades(True);

      Result := Result + '  ' + fGetSQLTriEmbala + '  AS EMBALA,  ';
      Result := Result + '  @CLASSE := AIT_CLASSE AS CLASSE,';
      If blnClaPic Then
        Result := Result + ' CAST("N" AS CHAR(1)) AS CLA_CHEEXC, ';

      Result := Result + '  "S" AS APEPIC,';
      Result := Result + '  IFNULL(CIT_CXCAMA, 0) AS CXCAMA,';
      Result := Result + '  IFNULL(CIT_QTCAMA, 0) AS QTCAMA,';
      Result := Result + '  IFNULL(CIT_QTDTOT, 0) AS QTDTOT,';
      Result := Result + '  ARC_DTAREC AS DTAREC,';
      Result := Result + '  ARC_HRAREC AS HRAREC,';
      Result := Result + '  ARC_OPEREC AS OPEREC,';
      Result := Result + '  ARC_STATUS AS STATUS,';
      Result := Result + '  ARC_IDEDIG AS IDEDIG,';
      Result := Result + '  ARC_NOMMOT AS NOMMOT,';
      Result := Result + '  OPE_NOMOPE AS NOMOPE,';
      Result := Result + '  G.ITE_NIVGIR AS NIVGIR,';
      Result := Result + '  IFNULL(';
      Result := Result + '    AIT_QTDETI,';

      If blnClaPic Then
        Result := Result + '    IF(IFNULL('+ fGetSQLClasseClaPic(True) +', "") = "", 0, 1)'
      Else
        Result := Result + '    IF(IFNULL(@CLASSE, "") = "", 0, 1)';

      Result := Result + '  ) AS QTDETI,';
      Result := Result + '  IFNULL(AIT_QTDEND, 0) AS QTDEND,';
      Result := Result + '  IFNULL(AIT_QTDDEV, 0) AS QTDDEV,';
      Result := Result + '  IF(';
      Result := Result + '    IFNULL(AIT_QTDEND, 0) = 0,';
      Result := Result + '    0,';
      Result := Result + '    IF(';
      Result := Result + '      IFNULL(AIT_QTDEND, 0) = IFNULL(';
      Result := Result + '        IFNULL(DIG_QTDITE, 0),';
      Result := Result + '        SUM(DET_QTDITE)';
      Result := Result + '      ),';
      Result := Result + '      2,';
      Result := Result + '      1';
      Result := Result + '    )';
      Result := Result + '  ) AS LEGEND,';
      Result := Result + '  AIT_IMPETI AS IMPETI,';
      Result := Result + '  I.ITE_REAEND,';
      Result := Result + '  IF(';
      Result := Result + '    E.AUTOINCREM IS NULL,';
      Result := Result + '    @SEQ := IFNULL(@SEQ, 0) + 1,';
      Result := Result + '    E.AUTOINCREM';
      Result := Result + '  ) AS CHAVE,';
      Result := Result + '  CAST(IF(IFNULL(DIG_QTDITE,0) > 0 AND (IFNULL(DIG_QTDITE,0) > IFNULL(AIT_QTDPIK, 0)), IFNULL(AIT_QTDPIK, 0)  , IFNULL(DIG_QTDITE,0)) AS DECIMAL(12,2)) QTDCON, ';
      Result := Result + '  IFNULL(DIG_QTDITE,0) AS QTDCONORI, ';
      Result := Result + '  IFNULL(DIG_QTDITE,0) AS QTDCONOLD, ';
      If blnEtqCon Then
      Begin
        Result := Result + ' IF(R.AUTOINCREM IS NOT NULL  ';
        Result := Result + '           , CASE  ';
        Result := Result + '               WHEN IFNULL(DIG_QTDITE,0) < IFNULL(AIT_QTDTOT,SUM(DET_QTDITE)) THEN "MENOS" ';
        Result := Result + '               WHEN IFNULL(DIG_QTDITE,0) > IFNULL(AIT_QTDTOT,SUM(DET_QTDITE)) THEN "MAIS" ';
        Result := Result + '               WHEN IFNULL(DIG_QTDITE,0) = IFNULL(AIT_QTDTOT,SUM(DET_QTDITE)) THEN "OK" ';
        Result := Result + '               ELSE NULL ';
        Result := Result + '             END ';
        Result := Result + '           , NULL) AS CONFER, ';
      End
      Else
        Result := Result + '  "OK" CONFER,';
      Result := Result + '  DET_NUMLOT AS NUMLOT,';
      Result := Result + '  IF(E.AUTOINCREM IS NULL, "N", "S") AS GRAVADO';
      Result := Result + ' FROM ';
      Result := Result + '  AGEDOC D';
      Result := Result + '  INNER JOIN AGEREC R';
      Result := Result + '    ON R.AUTOINCREM = ADC_SEQGER';
      Result := Result + '  INNER JOIN MOVDET T';
      Result := Result + '    ON T.DET_NUMDOC = ADC_NUMDOC';
      Result := Result + '    AND T.DET_ESPDOC = ADC_ESPDOC';
      Result := Result + '    AND T.DET_SERIE_ = ADC_SERIE_';
      Result := Result + '    AND T.DET_CODFOR = ADC_CODFOR';
      Result := Result + '    AND T.DET_CODEMP = ADC_CODEMP';
      Result := Result + '   INNER JOIN AUXMOV  ON AUXMOV.AUX_SEQGER = T.DET_SEQGER ';
      Result := Result + '  INNER JOIN MOVTRI M';
      Result := Result + '    ON M.DET_SEQGER = T.AUTOINCREM';
      Result := Result + '   INNER JOIN CADFOR ON FOR_CODFOR = DET_CODFOR     ';
      Result := Result + '  LEFT JOIN AGEITE E';
      Result := Result + '    ON E.AIT_SEQGER = R.AUTOINCREM';
      Result := Result + '    AND E.AIT_CODITE = DET_CODITE';
      Result := Result + '  LEFT JOIN CADITE I';
      Result := Result + '    ON I.ITE_CODITE = DET_CODITE';
      Result := Result + '  LEFT JOIN ITEGER G';
      Result := Result + '    ON G.ITE_CODITE = DET_CODITE';
      Result := Result + '    AND G.ITE_CODEMP = DET_CODEMP';
      Result := Result + '  LEFT JOIN CLASSE C';
      Result := Result + '    ON C.CLA_SIGLA_ = AIT_CLASSE';
      Result := Result + '  LEFT JOIN CLAITE L';
      Result := Result + '    ON L.CIT_CODITE = E.AIT_CODITE';
      Result := Result + '    AND L.CIT_SIGLA_ = E.AIT_CLASSE';
      Result := Result + '  LEFT JOIN CADOPE O';
      Result := Result + '    ON O.OPE_CODOPE = ARC_OPEREC';
      Result := Result + '  LEFT JOIN DIGELE DIG ON DIG.DIG_IDEDIG = R.ARC_IDEDIG';
      Result := Result + '    AND DIG.DIG_CODITE = T.DET_CODITE';
      Result := Result + '    AND DIG.DIG_CODEMP = T.DET_CODEMP';
      Result := Result + '  INNER JOIN AGEILO IL ON AIL_SEQITE =  E.AUTOINCREM AND AIL_PICKNG = "S"';
      Result := ResulT + '  INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI';

      If blnEtqCon Then
        Result := Result + ' WHERE TRUE '
      Else
      Begin
        If fConferenciaAntesDoPlanoDeRecebimento Then
          Result := Result + ' WHERE ((ARC_STATUS = "CN") OR (ARC_STATUS = "EP")) '
        Else
          Result := Result + ' WHERE ((ARC_STATUS = "CN") OR (ARC_STATUS = "EP") OR (ARC_STATUS = "EC")) ';
      End;

      Result := Result + '   AND ARC_CODEMP = :CODEMP ';

      If fEmptyStr(edtIdeDig.Text) Then
        Result := Result + ' AND ARC_PLACA_ = :CODIGO '
      Else
        Result := Result + ' AND ARC_IDEDIG = :CODIGO ';

      If Not fEmptyStr(cfg_Claret) then
        Result := Result + ' AND NOT(DET_CLARET = 1 AND LOCATE( DET_CLAFIS, "' + cfg_Claret + '"))';

      If Not fEmptyStr(cfg_4Dig) then
        Result := Result + ' AND NOT LOCATE(DET_CLAFIS, "' + cfg_4Dig + '")';

      If Not fEmptyStr(cfg_3Dig) then
        Result := Result + ' AND NOT LOCATE(SUBSTR(DET_CLAFIS, 2,3), "' + cfg_3Dig + '")';

      Result := Result + ' AND  IFNULL(AUXMOV.AUX_MATREV, FOR_MATREV) <> "F" ';
      Result := Result + ' AND IFNULL(I.ITE_REAEND,"N") = "S" ';

      Result := Result + ' GROUP BY IDEDIG, I.ITE_CODITE, APEPIC';
    End;
  End
  Else
  Begin
    Result := '';
    Result := Result + ' SELECT                                             ';
    Result := Result + ' IF((SELECT SUM(DIG_QTDITE) FROM DIGELE                               ';
    Result := Result + '   WHERE DIG_IDEDIG = ARC_IDEDIG                                      ';
    Result := Result + '     AND DIG_CODITE = TMP.CODITE)  > 0 AND                            ';
    Result := Result + '                                                                      ';
    Result := Result + ' (SELECT IFNULL(SUM(DET_QTDITE),0)                                    ';
    Result := Result + '    FROM AGEREC                                                       ';
    Result := Result + '   INNER JOIN AGEDOC ON AGEDOC.ADC_SEQGER = AGEREC.AUTOINCREM         ';
    Result := Result + '   INNER JOIN MOVDET T ON T.DET_NUMDOC = ADC_NUMDOC                   ';
    Result := Result + '                      AND T.DET_ESPDOC = ADC_ESPDOC                   ';
    Result := Result + '                      AND T.DET_SERIE_ = ADC_SERIE_                   ';
    Result := Result + '                      AND T.DET_CODFOR = ADC_CODFOR                   ';
    Result := Result + '                      AND T.DET_CODEMP = ADC_CODEMP                   ';
    Result := Result + '   WHERE AGEREC.AUTOINCREM = TMP.AUTINC                               ';
    Result := Result + '     AND T.DET_CODITE =  TMP.CODITE) = 0 , "S", "N") AS EXCEDENTE,    ';
    Result := Result + ' TMP.*                                              ';
    Result := Result +'  FROM (                                             ';
    Result := Result + ' SELECT * FROM (                                    ';
    Result := Result + ' SELECT ARC_CODIGO AS CODIGO,                       ';
    Result := Result + '        R.ARC_IDEDIG,                               ';
    Result := Result + '        ADC_SEQGER,                                 ';
    Result := Result + '        ADC_CODFOR,                                 ';

    Result := Result + '        ARC_MOVEFE AS MOVEFE,                       ';
    Result := Result + '        ARC_DESPAL,			                            ';
    Result := Result + '        CAST("N" AS CHAR(1)) AS SELECE ,            ';
    Result := Result + '        CAST("N" AS CHAR(1)) AS ABPICK ,            ';
    Result := Result + '        UNI_SIGUNI,                                 ';
    Result := Result + '        AIT_MODCUB AS MODCUB,                       ';
    Result := Result + '        R.AUTOINCREM AS AUTINC,                     ';
    Result := Result + '        I.ITE_CODITE AS CODITE,                     ';
    Result := Result + '        I.ITE_ATICOM AS ATICOM,                     ';
    Result := Result + '        I.ITE_ITEATI AS ITEATI,                     ';
    Result := Result + '        0 AS QTDITE_POR_ETIQUETA,                   ';
    Result := Result + '        ITE_DESITE AS DESITE, ';

    Result := Result + fGetSQLQuantidades(False);

    Result := Result + '       ' + fGetSQLTriEmbala + '  AS EMBALA,                   ';
    If blnSugereLocalizacao then
      Result := Result + ' @CLASSE := AIT_CLASSE AS CLASSE, '
    Else
    If blnClaPic Then
    Begin
      Result := Result + ' @CLASSE := ' + fGetSQLClasseClaPic(False) + ' AS CLASSE,                                          ';
      Result := Result + ' fRetClassePickingItemPlano(DET_CODITE, ARC_CODEMP, ' + fGetSQLDET_QTDITE(False) +' , 1,' + fGetSQLClasseClaPic(False) +' ) AS CLA_CHEEXC, ';
    End
    Else
    Begin
      Result := Result + ' @CLASSE := IFNULL(AIT_CLASSE,                                                                     ';
      Result := Result + '                   IF(  ( (@QTDNOR = 0) OR (IFNULL(DET_NUMLOT, "A DEFINIR") <> "A DEFINIR") )      ';
      Result := Result + '                      , NULL                                                                       ';
      Result := Result + '                      , (SELECT AIT_CLASSE FROM AGEITE                                             ';
      Result := Result + '                         INNER JOIN AGEREC ON AGEREC.AUTOINCREM = AGEITE.AIT_SEQGER                ';
      Result := Result + '                         WHERE AGEITE.AIT_CLASSE IS NOT NULL                                       ';
      Result := Result + '                         AND AGEREC.ARC_CODEMP = R.ARC_CODEMP                                      ';
      Result := Result + '                         AND AGEITE.AIT_CODITE = DET_CODITE                                        ';
      Result := Result + '                         ORDER BY AGEITE.AUTOINCREM DESC                                           ';
      Result := Result + '                         LIMIT 1))) AS CLASSE,                                                     ';
    End;

    Result := Result + '        IFNULL(CIT_CXCAMA,0) AS CXCAMA,             ';
    Result := Result + '        IFNULL(CIT_QTCAMA,0) AS QTCAMA,             ';
    Result := Result + '        IFNULL(CIT_QTDTOT,0) AS QTDTOT,             ';
    Result := Result + '        ARC_DTAREC AS DTAREC,                       ';
    Result := Result + '        ARC_HRAREC AS HRAREC,                       ';
    Result := Result + '        ARC_OPEREC AS OPEREC,                       ';
    Result := Result + '        ARC_STATUS AS STATUS,                       ';
    Result := Result + '        ARC_IDEDIG AS IDEDIG,                       ';
    Result := Result + '        ARC_NOMMOT AS NOMMOT,                       ';
    Result := Result + '        OPE_NOMOPE AS NOMOPE,                       ';
    Result := Result + '      G.ITE_NIVGIR AS NIVGIR,                       ';
    Result := Result + '        IFNULL(AIT_QTDETI, IF(IFNULL(@CLASSE,"") = "", 0, 1)) AS QTDETI, ';
    Result := Result + '        IFNULL(AIT_QTDEND, 0) AS QTDEND,            ';
    Result := Result + '        IFNULL(AIT_QTDDEV, 0) AS QTDDEV,            ';
    Result := Result + '        IF( IFNULL(AIT_QTDEND, 0) = 0, 0, IF( IFNULL(AIT_QTDEND, 0) = IFNULL(IFNULL(DIG_QTDITE,0), SUM(DET_QTDITE)), 2, 1 )) AS LEGEND, '; //Legenda do endereçamento 0 nao endereçado, 1 parcialmente, 2 totalmente
    Result := Result + '        AIT_IMPETI AS IMPETI,                       ';
    Result := Result + '        I.ITE_REAEND, ';
    Result := Result + '        IF(E.AUTOINCREM IS NULL, @SEQ := IFNULL(@SEQ,0) + 1, E.AUTOINCREM) AS CHAVE, ';
    Result := Result + '        CAST(IFNULL(DIG_QTDITE,0) - IFNULL(AIT_QTDPIK, 0) AS DECIMAL(12,2)) QTDCON, ';
    Result := Result + '        IFNULL(DIG_QTDITE,0) AS QTDCONORI, ';
    Result := Result + '        CAST(IFNULL(DIG_QTDITE,0) - IFNULL(AIT_QTDPIK, 0) AS DECIMAL(12,2)) QTDCONOLD, ';
    Result := Result + '        IF(R.AUTOINCREM IS NOT NULL  ';
    Result := Result + '           , CASE  ';
    Result := Result + '               WHEN IFNULL(DIG_QTDITE,0) < IFNULL(AIT_QTDTOT,SUM(DET_QTDITE)) THEN "MENOS" ';
    Result := Result + '               WHEN IFNULL(DIG_QTDITE,0) > IFNULL(AIT_QTDTOT,SUM(DET_QTDITE)) THEN "MAIS" ';
    Result := Result + '               WHEN IFNULL(DIG_QTDITE,0) = IFNULL(AIT_QTDTOT,SUM(DET_QTDITE)) THEN "OK" ';
    Result := Result + '               ELSE NULL ';
    Result := Result + '             END ';
    Result := Result + '           , NULL) AS CONFER, ';
    Result := Result + '        DET_NUMLOT AS NUMLOT, ';
    Result := Result + '  "N" AS APEPIC,';
    Result := Result + '        IF(E.AUTOINCREM IS NULL, "N","S") AS GRAVADO';
    Result := Result + ' FROM AGEDOC D                                      ';
    Result := Result + ' INNER JOIN AGEREC R ON R.AUTOINCREM = ADC_SEQGER';
    Result := Result + ' LEFT  JOIN DIGELE DIG ON DIG.DIG_IDEDIG = R.ARC_IDEDIG';
    Result := Result + '                          AND DIG.DIG_CODEMP = ADC_CODEMP';
    Result := Result + ' LEFT JOIN MOVDET T ON T.DET_NUMDOC = ADC_NUMDOC';
    Result := Result + '                    AND T.DET_ESPDOC = ADC_ESPDOC';
    Result := Result + '                    AND T.DET_SERIE_ = ADC_SERIE_';
    Result := Result + '                    AND T.DET_CODFOR = ADC_CODFOR';
    Result := Result + '                    AND T.DET_CODEMP = ADC_CODEMP';
    Result := Result + '                    AND T.DET_CODITE = DIG_CODITE';
    Result := Result + '   INNER JOIN AUXMOV  ON AUXMOV.AUX_SEQGER = T.DET_SEQGER ';
    Result := Result + ' LEFT JOIN MOVTRI M ON M.DET_SEQGER = T.AUTOINCREM';
    Result := Result + '   INNER JOIN CADFOR ON FOR_CODFOR = DET_CODFOR     ';
    Result := Result + ' LEFT  JOIN AGEITE E ON E.AIT_SEQGER = R.AUTOINCREM';
    Result := Result + '                    AND E.AIT_CODITE = DIG_CODITE';
    Result := Result + ' LEFT  JOIN CADITE I ON I.ITE_CODITE = DIG_CODITE';
    Result := Result + ' LEFT  JOIN ITEGER G ON G.ITE_CODITE = DIG_CODITE';
    Result := Result + '                    AND G.ITE_CODEMP = ADC_CODEMP';
    Result := Result + ' LEFT  JOIN CLASSE C ON C.CLA_SIGLA_ = AIT_CLASSE';
    Result := Result + ' LEFT  JOIN CLAITE L ON L.CIT_CODITE = E.AIT_CODITE';
    Result := Result + '                    AND L.CIT_SIGLA_ = E.AIT_CLASSE';
    Result := Result + ' LEFT  JOIN CADOPE O ON O.OPE_CODOPE = ARC_OPEREC';
    Result := Result + ' LEFT  JOIN AGEILO IL ON AIL_SEQITE =  E.AUTOINCREM AND AIL_PICKNG = "S" ';
    Result := Result + '  INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI';

    If blnEtqCon Then
      Result := Result + ' WHERE TRUE '
    Else
    Begin
      If fConferenciaAntesDoPlanoDeRecebimento Then
        Result := Result + ' WHERE ((ARC_STATUS = "CN") OR (ARC_STATUS = "EP")) '
      Else
        Result := Result + ' WHERE ((ARC_STATUS = "CN") OR (ARC_STATUS = "EP") OR (ARC_STATUS = "EC")) ';
    End;

    Result := Result + '   AND ARC_CODEMP = :CODEMP ';

    If fEmptyStr(edtIdeDig.Text) Then
      Result := Result + ' AND ARC_PLACA_ = :CODIGO '
    Else
      Result := Result + ' AND ARC_IDEDIG = :CODIGO ';

    If not femptystr(cfg_Claret) then
      Result := Result + ' AND NOT(DET_CLARET = 1 AND LOCATE( DET_CLAFIS, "' + cfg_Claret + '"))';

    If not femptystr(cfg_4Dig) then
        Result := Result + ' AND NOT LOCATE(DET_CLAFIS, "' + cfg_4Dig + '")';

    If not femptystr(cfg_3Dig) then
        Result := Result + ' AND NOT LOCATE(SUBSTR(DET_CLAFIS, 2,3), "' + cfg_3Dig +'")';
    Result := Result + ' AND  IFNULL(AUXMOV.AUX_MATREV, FOR_MATREV) <> "F" ';
    Result := Result + ' AND IFNULL(I.ITE_REAEND,"N") = "S" ';

    Result := Result + ' GROUP BY IDEDIG, I.ITE_CODITE) ITEM_SEM_PICKING ';
    Result := Result + ' WHERE EXIBIR_NO_GRID = "S"';

    Result := Result + ' UNION ALL ';

    Result := Result + ' SELECT ARC_CODIGO AS CODIGO,                       ';
    Result := Result + '        R.ARC_IDEDIG AS IDEDIG,                     ';
    Result := Result + '        ADC_SEQGER,                                 ';
    Result := Result + '        ADC_CODFOR,                                 ';
    Result := Result + '        ARC_MOVEFE AS MOVEFE,                       ';
    Result := Result + '        ARC_DESPAL,			                            ';
    Result := Result + '        CAST("N" AS CHAR(1)) AS SELECE ,            ';
    Result := Result + '        CAST("N" AS CHAR(1)) AS ABPICK ,            ';
    Result := Result + '        UNI_SIGUNI,                                 ';
    Result := Result + '        "A" AS MODCUB,                              ';
    Result := Result + '        R.AUTOINCREM AS AUTINC,                     ';
    Result := Result + '        I.ITE_CODITE AS CODITE,                     ';
    Result := Result + '        I.ITE_ATICOM AS ATICOM,                     ';
    Result := Result + '        I.ITE_ITEATI AS ITEATI,                     ';
    Result := Result + '        0 AS QTDITE_POR_ETIQUETA,                   ';
    Result := Result + '        ITE_DESITE AS DESITE,                       ';

    Result := Result + fGetSQLQuantidades(False);

    Result := Result + '        '  + fGetSQLTriEmbala + '  AS EMBALA,  ';
    If blnSugereLocalizacao then
      Result := Result + ' @CLASSE := AIT_CLASSE AS CLASSE, '
    Else
    If blnClaPic Then
    Begin
      Result := Result + ' @CLASSE := ' + fGetSQLClasseClaPic(False) + ' AS CLASSE,                                          ';
      Result := Result + ' fRetClassePickingItemPlano(DET_CODITE, ARC_CODEMP, ' + fGetSQLDET_QTDITE(False) +' , 1,' + fGetSQLClasseClaPic(False) +' ) AS CLA_CHEEXC, ';
    End
    Else
    Begin
      Result := Result + ' @CLASSE := IFNULL(AIT_CLASSE,                                                                     ';
      Result := Result + '                   IF(  ( (@QTDNOR = 0) OR (IFNULL(DET_NUMLOT, "A DEFINIR") <> "A DEFINIR") )      ';
      Result := Result + '                      , NULL                                                                       ';
      Result := Result + '                      , (SELECT AIT_CLASSE FROM AGEITE                                             ';
      Result := Result + '                         INNER JOIN AGEREC ON AGEREC.AUTOINCREM = AGEITE.AIT_SEQGER                ';
      Result := Result + '                         WHERE AGEITE.AIT_CLASSE IS NOT NULL                                       ';
      Result := Result + '                         AND AGEREC.ARC_CODEMP = R.ARC_CODEMP                                      ';
      Result := Result + '                         AND AGEITE.AIT_CODITE = DET_CODITE                                        ';
      Result := Result + '                         ORDER BY AGEITE.AUTOINCREM DESC                                           ';
      Result := Result + '                         LIMIT 1))) AS CLASSE,                                                     ';
    End;

    Result := Result + '        IFNULL(CIT_CXCAMA,0) AS CXCAMA,             ';
    Result := Result + '        IFNULL(CIT_QTCAMA,0) AS QTCAMA,             ';
    Result := Result + '        IFNULL(CIT_QTDTOT,0) AS QTDTOT,             ';
    Result := Result + '        ARC_DTAREC AS DTAREC,                       ';
    Result := Result + '        ARC_HRAREC AS HRAREC,                       ';
    Result := Result + '        ARC_OPEREC AS OPEREC,                       ';
    Result := Result + '        ARC_STATUS AS STATUS,                       ';
    Result := Result + '        ARC_IDEDIG AS IDEDIG,                       ';
    Result := Result + '        ARC_NOMMOT AS NOMMOT,                       ';
    Result := Result + '        OPE_NOMOPE AS NOMOPE,                       ';
    Result := Result + '      G.ITE_NIVGIR AS NIVGIR,                       ';
    Result := Result + '        IFNULL(AIT_QTDETI, IF(IFNULL(@CLASSE,"") = "", 0, 1)) AS QTDETI, ';
    Result := Result + '        IFNULL(AIT_QTDEND, 0) AS QTDEND,            ';
    Result := Result + '        IFNULL(AIT_QTDDEV, 0) AS QTDDEV,            ';
    Result := Result + '        IF( IFNULL(AIT_QTDEND, 0) = 0, 0, IF( IFNULL(AIT_QTDEND, 0) = IFNULL(IFNULL(DIG_QTDITE,0), SUM(DET_QTDITE)), 2, 1 )) AS LEGEND, '; //Legenda do endereçamento 0 nao endereçado, 1 parcialmente, 2 totalmente
    Result := Result + '        AIT_IMPETI AS IMPETI,                       ';
    Result := Result + '        I.ITE_REAEND, ';
    Result := Result + '        IF(E.AUTOINCREM IS NULL, @SEQ := IFNULL(@SEQ,0) + 1, E.AUTOINCREM) AS CHAVE, ';
    Result := Result + '        CAST(IFNULL(DIG_QTDITE,0) - IFNULL(AIT_QTDPIK, 0) AS DECIMAL(12,2)) QTDCON, ';
    Result := Result + '        IFNULL(DIG_QTDITE,0) AS QTDCONORI, ';
    Result := Result + '        CAST(IFNULL(DIG_QTDITE,0) - IFNULL(AIT_QTDPIK, 0) AS DECIMAL(12,2)) QTDCONOLD, ';
    Result := Result + '        IF(R.AUTOINCREM IS NOT NULL  ';
    Result := Result + '           , CASE  ';
    Result := Result + '               WHEN IFNULL(DIG_QTDITE,0) < IFNULL(AIT_QTDTOT,SUM(DET_QTDITE)) THEN "MENOS" ';
    Result := Result + '               WHEN IFNULL(DIG_QTDITE,0) > IFNULL(AIT_QTDTOT,SUM(DET_QTDITE)) THEN "MAIS" ';
    Result := Result + '               WHEN IFNULL(DIG_QTDITE,0) = IFNULL(AIT_QTDTOT,SUM(DET_QTDITE)) THEN "OK" ';
    Result := Result + '               ELSE NULL ';
    Result := Result + '             END ';
    Result := Result + '           , NULL) AS CONFER, ';
    Result := Result + '        DET_NUMLOT AS NUMLOT, ';
    Result := Result + '  "S" AS APEPIC,';
    Result := Result + '        IF(E.AUTOINCREM IS NULL, "N","S") AS GRAVADO';
    Result := Result + ' FROM AGEDOC D                                      ';
    Result := Result + ' INNER JOIN AGEREC R ON R.AUTOINCREM = ADC_SEQGER';
    Result := Result + ' LEFT  JOIN DIGELE DIG ON DIG.DIG_IDEDIG = R.ARC_IDEDIG';
    Result := Result + '                          AND DIG.DIG_CODEMP = ADC_CODEMP';
    Result := Result + ' LEFT JOIN MOVDET T ON T.DET_NUMDOC = ADC_NUMDOC';
    Result := Result + '                    AND T.DET_ESPDOC = ADC_ESPDOC';
    Result := Result + '                    AND T.DET_SERIE_ = ADC_SERIE_';
    Result := Result + '                    AND T.DET_CODFOR = ADC_CODFOR';
    Result := Result + '                    AND T.DET_CODEMP = ADC_CODEMP';
    Result := Result + '                    AND T.DET_CODITE = DIG_CODITE';
    Result := Result + '   INNER JOIN AUXMOV  ON AUXMOV.AUX_SEQGER = T.DET_SEQGER ';
    Result := Result + ' LEFT JOIN MOVTRI M ON M.DET_SEQGER = T.AUTOINCREM';
    Result := Result + '   INNER JOIN CADFOR ON FOR_CODFOR = DET_CODFOR     ';
    Result := Result + ' LEFT  JOIN AGEITE E ON E.AIT_SEQGER = R.AUTOINCREM';
    Result := Result + '                    AND E.AIT_CODITE = DIG_CODITE';
    Result := Result + ' LEFT  JOIN CADITE I ON I.ITE_CODITE = DIG_CODITE';
    Result := Result + ' LEFT  JOIN ITEGER G ON G.ITE_CODITE = DIG_CODITE';
    Result := Result + '                    AND G.ITE_CODEMP = ADC_CODEMP';
    Result := Result + ' LEFT  JOIN CLASSE C ON C.CLA_SIGLA_ = AIT_CLASSE';
    Result := Result + ' LEFT  JOIN CLAITE L ON L.CIT_CODITE = E.AIT_CODITE';
    Result := Result + '                    AND L.CIT_SIGLA_ = E.AIT_CLASSE';
    Result := Result + ' LEFT  JOIN CADOPE O ON O.OPE_CODOPE = ARC_OPEREC';
    Result := Result + ' INNER JOIN AGEILO IL ON AIL_SEQITE =  E.AUTOINCREM AND AIL_PICKNG = "S" ';
    Result := Result + ' INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI';

    If fConferenciaAntesDoPlanoDeRecebimento Then
      Result := Result + ' WHERE ((ARC_STATUS = "CN") OR (ARC_STATUS = "EP")) '
    Else
      Result := Result + ' WHERE ((ARC_STATUS = "CN") OR (ARC_STATUS = "EP") OR (ARC_STATUS = "EC")) ';

    Result := Result + '   AND ARC_CODEMP = :CODEMP ';

    If fEmptyStr(edtIdeDig.Text) Then
      Result := Result + ' AND ARC_PLACA_ = :CODIGO '
    Else
      Result := Result + ' AND ARC_IDEDIG = :CODIGO ';

    If not femptystr(cfg_Claret) then
      Result := Result + ' AND NOT(DET_CLARET = 1 AND LOCATE( DET_CLAFIS, "' + cfg_Claret + '"))';

    If not femptystr(cfg_4Dig) then
        Result := Result + ' AND NOT LOCATE(DET_CLAFIS, "' + cfg_4Dig + '")';

    If not femptystr(cfg_3Dig) then
        Result := Result + ' AND NOT LOCATE(SUBSTR(DET_CLAFIS, 2,3), "' + cfg_3Dig +'")';
    Result := Result + ' AND  IFNULL(AUXMOV.AUX_MATREV, FOR_MATREV) <> "F" ';
    Result := Result + ' AND IFNULL(I.ITE_REAEND,"N") = "S" ';

    Result := Result + ' GROUP BY IDEDIG, I.ITE_CODITE) TMP ';

  End;

  //BLOCO B

  Result := Result + '   ORDER BY CODITE, APEPIC';
end;

function TfrmPlanoDeRecebimento.fMostraItens(strCodigo: String; AblnCarregandoPlano: Boolean;AblnAtualizandoPlano: Boolean = False; AblnVindoDoMapeamento: Boolean = False): Boolean;
  Var
    strTrava : String;
    qryConsulta : TUniQuery;
    arrSel : TConsultasArray;
    key : Char;
begin
  Result := False;

  blnAgrupado := False;
  blnCarregandoPlano := AblnCarregandoPlano;
  If AblnCarregandoPlano Then
    chkRepModCubTodos.Checked := False;

  qryEtique.Close;

  If (fPlanoMultIdeDig) Then
  Begin
    cxgItensTableView.DataController.DataSource := Nil;
    fMensagem('', 'Existe mais de um planejamento para essa placa que pode ser alterado, utilize a pesquisa de sequencial para definir o registro desejado!', ['&Ok']);
    pResetTela;
    Result := True;
    pSetFocus(edtIdeDig);
    key := '?';

    Try
      qryConsulta := fCriaQuery;
      If fPesqAgendamentoEntregaWMS(Self, Nil, qryConsulta, Key, arrSel, True, '"CN", "EP"' + IfThen(fConferenciaAntesDoPlanoDeRecebimento,'', ', "EC"'), strCodigo) Then
      Begin
        cxgItensTableView.DataController.DataSource := cdsItens.dtsSource;
        edtIdeDig.Text := qryConsulta.FieldByName('ARC_IDEDIG').Text;
        fValidaCampos(edtIdeDig, True);
      End;
    Finally
      FreeAndNil(qryConsulta);
    End;

    Exit;
  End;

  cdsLocSug.DisableControls;
  Try

    objLock.pDestravarTodos;

    With cdsItens.qryQuery, SQL Do
    Begin
      If Not ABlnVindoDoMapeamento Then
      Begin
        Close;
        Clear;

        Add('SET @SEQ = NULL');
        ExecSql;

        Close;
        Clear;

        Add( fGetSQL );
        ParamByName('CODIGO').AsString := strCodigo;
        ParamByName('CODEMP').AsString := VS_strCodEmp;

        stlLocSel.Clear;

        cdsItens.fAbreClient(True, 'TfrmPlanoDeRecebimento.fMostraItens');
        cdsItens.IndexFieldNames := 'CODITE;MODCUB';
        cdsItens.First;
      End;

      If fCfgSis('CCDPRM', varBoolean) Then
      Begin
        If cdsItens.FieldByName('ARC_DESPAL').AsString = 'F' Then
          chkGerCob.Checked := False;
        If cdsItens.FieldByName('ARC_DESPAL').AsString = 'E' Then
          chkGerCob.Checked := True;
      End
      Else
      Begin
        chkGerCob.Visible := False;
        If strIdeDigBkp <> strIdeDig Then
          pnlLegendaConferencia.Height := pnlLegendaConferencia.Height - chkGerCob.Height - 3;
      End;


      If (Not cdsItens.Active) Then
      Begin
        If blnConfirmacaoAutomatica Then
        Begin
          FFalha := 'Não foi possível carregar os itens do plano de recebimento.';
          Exit(False);
        End
        Else
        Begin
          fMensagem('', 'Não foi possível carregar os itens do plano de recebimento.!', ['&Ok']);
          Exit;
        End;
      End;

      cdsItens.Filtered := False;
      Result := (cdsItens.RecordCount > 0);

      btnAlterar.Enabled := cdsItens.FieldByName('MOVEFE').AsString = 'S';
      cdsItens.Filtered := True;

      strIdeDig := FieldByName('IDEDIG').AsString;
      strAdcSeqGer := FieldByName('ADC_SEQGER').AsString;

      If cdsItens.Filtered Then
        cdsItens.Filtered := False;

      pHabilitarBotoes(True);

      If Result And ( (fConferenciaAntesDoPlanoDeRecebimento And (cdsItens.FieldByName('STATUS').AsString <> 'CN')) or
                    (not fConferenciaAntesDoPlanoDeRecebimento) And (cdsItens.FieldByName('STATUS').AsString = 'CN') ) Then
      Begin
        If Not(AblnCarregandoPlano And blnConfirmacaoPelaImpressao) And (Not AblnAtualizandoPlano) Then
          fMensagem('', 'Plano de Recebimento já confirmado!', ['&Ok']);
        btnConfirma.Enabled    := False;
        btnDesmembra.Enabled   := False;
        btnAlterar.Enabled     := True;
        btnCancela.Enabled     := True;
        btnImprimir.Enabled    := True;
        blnPlanoJaConfirmado   := True;
        pHabilitarBotoes(False);
        pSetFocus(edtIdeDig);
      End
      Else
        If Not blnEtqCon Then
          btnAlterar.Enabled     := False;

      If fTodoPlanoEnderecado(strIdeDig) Then
      Begin
        fMensagem('', ' Este plano de recebimento já possui item(s) endereçado(s), não é possível alterar ou cancelar', ['&Ok']);
        btnCancela.Enabled := False;
        btnAlterar.Enabled := False;
        btnImprimirMaisEtiqID.Enabled := blnModCub;
      End;

      If (fPlanoComEtiquetaPickingJaEnderecada(strIdeDig)) And (fGetQtdItensSemCubagem = 0) Then
      Begin
        fMensagem('', ' Este plano de recebimento já possui item(s) endereçado(s) para localizações picking, não é possível alterar ou cancelar', ['&Ok']);
        btnCancela.Enabled := False;
        btnAlterar.Enabled := False;
        btnImprimirMaisEtiqID.Enabled := blnModCub;
      End;

      strTrava := 'PLANO_RECEBIMENTO_' + cdsItens.FieldByName('AUTINC').AsString;

      If Result And (Not objLock.fLock_Unlock(strTrava, True, False)) Then
      Begin
        fMensagem('', 'Esse plano de recebimento está sendo utilizado em Outra Estação por ' +
                      fGetHostLock(strTrava)  + '!', ['&Ok']);
        Result := False;
        pResetTela;
        Exit;
      End;

      TFloatField(cdsItens.FieldByName('QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
      TFloatField(cdsItens.FieldByName('DET_QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
      TFloatField(cdsItens.FieldByName('QTDCON')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
      TFloatField(cdsItens.FieldByName('QTDEND')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
      TFloatField(cdsItens.FieldByName('QTDDEV')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
      cdsItens.FieldByName('CLASSE').OnChange := pOnDataChangeClasse;

      If Not Result Then
      Begin
        If blnConfirmacaoAutomatica Then
        Begin
          FFalha := 'Recebimento não encontrado!';
          Exit(False);
        End
        Else
          fMensagem('', 'Recebimento não encontrado!', ['&Ok'])
      End
      Else
      Begin
        edtDtaRec.Text := FormatDateTime('dd/mm/yyyy hh:nn:ss', cdsItens.FieldByName('DTAREC').AsDateTime + cdsItens.FieldByName('HRAREC').AsDateTime);
        edtCodOpe.Text := cdsItens.FieldByName('OPEREC').AsString;
        edtNomOpe.Text := cdsItens.FieldByName('NOMOPE').AsString;
        edtNomMot.Text := cdsItens.FieldByName('NOMMOT').AsString;
        cxgItensTableView.ApplyBestFit();
      End;

      btnConfirma.Enabled := Result;
      btnDesmembra.Enabled   := Result And (cdsItens.FieldByName('IMPETI').AsString <> 'S');
      If (Result and blnSugereLocalizacao) Then
      Begin
        Try
          pCriarFormularios(TfrmGravando, frmGravando);
          If  (AblnCarregandoPlano And (cdsItens.FieldByName('MOVEFE').AsString = 'S')) Then
            blnApenasRecarregaAgeilo := True;

          If blnCarregandoPlano Then
            cdsLocSug.EmptyDataSet;

          frmGravando.fExecutarAcao := fCalculaSugestaoLocalizacaoFisicas;
          frmGravando.ShowModal;
        Finally
          blnApenasRecarregaAgeilo := False;
          FreeAndNil(frmGravando);
        End;

        TFloatField(cdsLocSug.FieldByName('QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
        TFloatField(cdsLocSug.FieldByName('QTDVEN')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
        cdsItens.AfterScroll := nil;
        cdsItens.AfterPost := nil;

        If blnModCub Then
        Begin
          cdsItens.AfterPost := pAfterPostItens;
          pAfterPostItens(cdsItens);
        End;

        cdsItens.AfterScroll := nil;
        cdsItens.AfterPost := nil;
        cdsItens.First;
        pFiltraSugestaoCds(cdsItens);
        cdsItens.AfterPost := pAfterPostItens;
        cdsItens.AfterScroll := pFiltraSugestaoCds;


        If blnModCub And fTemCubagemManual Then
          pProcessarEtiquetasID;

        If blnModCub Then
          pAjustarPaineis;

        edtConferido.Text := fCampoTabela('GER_OPECON', 'GERELE', ['GER_IDEDIG'], [strIdeDig]);
        edtConferido.Text := edtConferido.Text + '-' + fRetNomeOperador(edtConferido.Text);
      End;

      If (Not AblnVindoDoMapeamento) And (fCfgSis('OBRPKN', varBoolean)) Then
      Begin
        If Not fValidaMapeamentoDeLocalizacoes Then
        Begin
          Result := False;
          pResetTela;
          Exit;
        End;
      End;

      if Result and (not blnSugereLocalizacao) And (Pos('ENTRADA SIMPLIFICADA', cdsItens.FieldByName('NOMMOT').AsString) > 0) Then
      Begin
        if not fPreencheClasseDeLocalParaProdutosComLoteDefinidosNaEntradaSimplificada Then
        Begin
          Result := False;
          pResetTela;
          Exit;
        End;
      End;

    End;
  Finally
    If blnCarregandoPlano Then
    Begin
//      btnImprimir.Enabled := ( blnTodasModCubPreenchidas And (Not blnTemCubagemAutomatica));
      If (fTemSugestao) And (blnModCub) and (blnPriPik) And (Not (cdsItens.FieldByName('MOVEFE').AsString = 'S')) Then
        btnImprimir.Enabled := True;
      btnImprimirMaisEtiqID.Enabled := pnlEtiquetasID.Visible;
    End;
    cdsLocSug.EnableControls;
  End;

  chkAllPick.Visible := blnPriPik;
  If (chkAllPick.Enabled) And (chkAllPick.Visible) Then
  Begin
    chkAllPick.Checked := fCfgSis('MOSTPK', varBoolean);
    If chkAllPick.CHecked Then
      chkAllPickClick(Nil);
  End;

  pnlLegendas.Visible := True;
  pnlPlanoJaFinalizado.Visible := fTodoPlanoEnderecado(strIdeDig);
  If pnlPlanoJaFinalizado.Visible Then
  Begin
    //pnlLegendas.Visible := False;
    btnConfirma.Enabled := False;
    btnCancela.Enabled := False;
    btnAlterar.Enabled := False;
    btnImprimir.Enabled := False;
    btnImprimirMaisEtiqID.Enabled := False;
  End;

  If blnClaPic Then
  Begin
    Try
      cdsItens.DisableControls;
      cdsItens.First;
      While Not cdsItens.Eof Do
      Begin
        shpClaPic.Visible := Not (fEmptyStr(cdsItens.FieldByName('CLA_CHEEXC').AsString));
        lblClaPic.Visible := shpClaPic.Visible;
        shpPicExc.Visible := shpClaPic.Visible;
        lblPicExc.Visible := shpClaPic.Visible;
        If shpClaPic.Visible Then
          Break;

        cdsItens.Next;
      End;
    Finally
      cdsItens.EnableControls;
    End;
  End;
end;

procedure TFrmPlanoDeRecebimento.pAjustarPaineis;
var
  frmGravando: TFrmGravando;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);

    frmGravando.fExecutarAcao := fAjustarPaineisAux;
    frmGravando.lblGravando.Caption := 'Ajustando tela...';
    frmGravando.pgbStatus.Visible := False;
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;
end;

function TFrmPlanoDeRecebimento.fAjustarPaineisAux(pgbProgresso: TCxProgressBar): Boolean;
var
  blnApenasCubagemManual,
  blnSemCubagemManual,
  blnPlanoSemCubagem,
  blnComAmbasCubagens: Boolean;

  qtdCubagemManual: integer;
  qtdCubagemAutomatica: integer;
  qtdSemCubagem: integer;
  qtdTotalReg: integer;
  intQtdRegComPiking: integer;
begin
  strIdeDigBkp := strIdeDig;

  pCarregaDefinicoesCubagem(qtdCubagemManual, qtdCubagemAutomatica, qtdSemCubagem, qtdTotalReg, intQtdRegComPiking);

  blnApenasCubagemManual :=  (qtdCubagemManual = qtdTotalReg) And (intQtdRegComPiking = 0);
  blnSemCubagemManual :=  qtdCubagemManual = 0;
  blnComAmbasCubagens :=  (qtdCubagemManual > 0)  And (qtdCubagemAutomatica + intQtdRegComPiking  > 0);
  blnPlanoSemCubagem :=  qtdSemCubagem = qtdTotalReg;
  blnTodasModCubPreenchidas := qtdSemCubagem = 0;

  If blnPlanoSemCubagem And (Not blnComAmbasCubagens) Then
  Begin
    pnlGridSuperior.Visible := True;
    pnlEtiquetasID.Visible := False;
    chkAllPick.Visible := True;
    pnlBotoesEtiquetas.Visible := False;
    sptSplitter.Visible := False;
    pnlCtrlModCub.Visible := True;
    pnlLegendaConferencia.Visible := True;
    pnlLegendas.Height := pnlCtrlModCub.Height + pnlLegendaConferencia.Height;
    Exit(True);
  End;

  If blnApenasCubagemManual Then
  Begin
    pnlGridSuperior.Visible := False;
    chkAllPick.Visible := False;
    pnlEtiquetasID.Align := alClient;
    pnlEtiquetasID.Visible := True;
    sptSplitter.Visible := False;
    pnlLegendaConferencia.Visible := False;
    pnlBotoesEtiquetas.Visible := True;
    pnlCtrlModCub.Visible := False;
    pnlLegendas.Height := pnlCtrlModCub.Height - pnlLegendaConferencia.Height;
    Exit(True);
  End;

  If blnSemCubagemManual And (Not (blnComAmbasCubagens And blnPlanoSemCubagem)) Then
  Begin
    pnlGridSuperior.Visible := True;
    chkAllPick.Visible := True;
    pnlEtiquetasID.Align := alBottom;
    sptSplitter.Visible := False;
    pnlEtiquetasID.Visible := False;
    pnlBotoesEtiquetas.Visible := False;
    pnlCtrlModCub.Visible := True;
    pnlLegendaConferencia.Visible := True;
    pnlLegendas.Height := pnlCtrlModCub.Height + pnlLegendaConferencia.Height;
    Exit(True);
  End;

  If blnComAmbasCubagens Then
  Begin
    pnlGridSuperior.Visible := True;
    chkAllPick.Visible := True;
    sptSplitter.Align := alNone;
    sptSplitter.Visible := True;
    pnlEtiquetasID.Align := alBottom;
    pnlEtiquetasID.Visible := True;
    pnlEtiquetasID.Height := Trunc(ClientHeight / 3);
    sptSplitter.Align := alBottom;
    pnlBotoesEtiquetas.Visible := True;
    pnlCtrlModCub.Visible := fPodeExibirPainelCtrModCub;
    pnlLegendaConferencia.Visible := True;
    pnlLegendas.Height := pnlBotoesEtiquetas.Height + pnlLegendaConferencia.Height;
    If pnlCtrlModCub.Visible Then
      pnlLegendas.Height := pnlLegendas.Height + pnlCtrlModCub.Height;
    Exit(True);
  End;

  Result := False;
end;

function TfrmPlanoDeRecebimento.fAtualizaEstoque(strCodIte: String;
  fltQtdIte: Double; strEntSai, strNumLot, strEspecie: String;
  blnFutLot: Boolean): Boolean;
 Var
    strSQL   : String;
    qryGenIte: TUniQuery;
    objCadLot: TCadLot;

begin
  objCadLot := TCadLot.Create(Self);
  Result := True;

  If (strCodIte = fCfgSis('ITESER')) Or (strCodIte = fCfgSis('SERTER')) Or (strCodIte = fCfgSis('ITEFRE')) Then
    Exit;

  Try

    qryGenIte := fCriaQuery(Self);

    Try

      If (blnFutLot = False) Then
      Begin
        If (strEspecie <> 'TA') And (strEspecie <> 'TL') Then
        Begin
          strSQL := '';
          strSQL := strSQL + 'UPDATE ';
          strSQL := strSQL + '  ITEGER ';
          strSQL := strSQL + 'SET ';
          If (strEntSai = 'E') Then
            strSQL := strSQL + '  ITE_SALDOS = ITE_SALDOS + :QTDITE '
          Else
            strSQL := strSQL + '  ITE_SALDOS = ITE_SALDOS - :QTDITE ';

          strSQL := strSQL + 'WHERE ';
          strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
          strSQL := strSQL + '  ITE_CODEMP = :CODEMP ';

          With qryGenIte Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('QTDITE').AsFloat := fltQtdIte;
            ParamByName('CODITE').AsString := strCodIte;
            ParamByName('CODEMP').AsString := VS_strCodEmp;
            ExecSQL;
            Close;
          End;
        End;

        Result := True;

        If Result Then
        Begin
          If fEmptyStr(strNumLot) Then
            strNumLot := objCadLot.fRetArmazemPrincipalVenda(strCodIte);

          If (Not fEmptyStr(strNumLot)) Then
            Result := objCadLot.fAtualizaEstoqueLote(strCodIte, strEntSai, strNumLot, fltQtdIte);
        End;
      End
      Else If (blnFutLot = True) Then
      Begin

        Result := True;

        If strEntSai = 'E' Then
        Begin
          If (Result) And (Not fEmptyStr(strNumLot)) Then
            Result := objCadLot.fAtualizaEstoqueLote(strCodIte, 'E', strNumLot, fltQtdIte);
        End
        Else
        Begin
          If (Result) And (Not fEmptyStr(strNumLot)) Then
            Result := objCadLot.fAtualizaEstoqueLote(strCodIte, 'S', 'A DEFINIR', fltQtdIte);
        End;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fAtualizaEstoque]');
        Result := False;
      End;
    End;

  Finally
    FreeAndNil(qryGenIte);
    FreeAndNil(objCadLot);
  End;

end;

function TfrmPlanoDeRecebimento.fPossuiDevolucaoCompra: Boolean;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;

  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT                              ');
    qryAux.SQL.Add('   COUNT(0) AS QUANTIDADE_DEVOLUCAO  ');
    qryAux.SQL.Add(' FROM                                ');
    qryAux.SQL.Add('   AGEITE                            ');
    qryAux.SQL.Add(' JOIN AGEREC                         ');
    qryAux.SQL.Add('   ON AGEREC.AUTOINCREM = AIT_SEQGER ');
    qryAux.SQL.Add(' WHERE ARC_IDEDIG = :IDEDIG          ');
    qryAux.SQL.Add('       AND AIT_QTDDEV > 0            ');

    qryAux.ParamByName('IDEDIG').AsString := strIdeDig;

    qryAux.Open;

    Result := qryAux.FieldByName('QUANTIDADE_DEVOLUCAO').AsFloat > 0;

  Finally
    FreeAndNil(qryAux);
  End;

end;

function TfrmPlanoDeRecebimento.fPossuiEnderecamento(
  strIdeDig: String): Boolean;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;

  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('   SELECT                               ');
    qryAux.SQL.Add('     COUNT(0) AS QUANTIDADE_ENDERECADA  ');
    qryAux.SQL.Add('   FROM                                 ');
    qryAux.SQL.Add('     AGEITE                             ');
    qryAux.SQL.Add('   JOIN AGEREC                          ');
    qryAux.SQL.Add('     ON AGEREC.AUTOINCREM = AIT_SEQGER  ');
    qryAux.SQL.Add('   WHERE ARC_IDEDIG = :IDEDIG           ');
    qryAux.SQL.Add('         AND AIT_QTDEND > 0             ');

    qryAux.ParamByName('IDEDIG').AsString := strIdeDig;

    qryAux.Open;

    Result := qryAux.FieldByName('QUANTIDADE_ENDERECADA').AsFloat > 0;

  Finally
    FreeAndNil(qryAux);
  End
end;

function TFrmPlanoDeRecebimento.fPossuiEtiquetasIDEnderecadas: Boolean;
begin
  qryEtique.Filter := 'STATUS = ''E''';
  qryEtique.Filtered := True;
  Result := qryEtique.RecordCount > 0;
  qryEtique.Filtered := False;
end;

function TFrmPlanoDeRecebimento.fPodeExibirPainelCtrModCub: Boolean;
var
  qryCons: TUniQuery;
begin
  Try
    qryCons := fCriaQuery;
    qryCons.SQL.Add(' SELECT                                        ');
    qryCons.SQL.Add('   *                                           ');
    qryCons.SQL.Add(' FROM                                          ');
    qryCons.SQL.Add('   ETIRIT                                      ');
    qryCons.SQL.Add('   INNER JOIN ETIREC                           ');
    qryCons.SQL.Add('     ON ETIREC.AUTOINCREM = ETI_ETIREC         ');
    qryCons.SQL.Add('   INNER JOIN AGEREC                           ');
    qryCons.SQL.Add('     ON ETIREC.ETI_CODREC = AGEREC.AUTOINCREM  ');
    qryCons.SQL.Add(' WHERE ARC_IDEDIG = :IDEDIG                    ');
    qryCons.ParamByName('IDEDIG').AsString := strIdeDig;

    qryCons.Open;

    Result := qryCons.IsEmpty And Not fTemEtiquetaSendoBipada;

  Finally
    FreeAndNil(qryCons);
  End;
end;

function TfrmPlanoDeRecebimento.fTodoPlanoEnderecado(strIdeDig: String): Boolean;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;

  Try
    With qryAux, SQL Do
    Begin
      Add('   SELECT                                  ');
      Add('     IF(                                   ');
      Add('        SUM(AIT_QTDTOT) = (SUM(AIT_QTDEND) + SUM(AIT_QTDDEV) + SUM(AIT_DIVEND)),');
      Add('          "S",                             ');
      Add('          "N"                              ');
      Add('        ) AS TUDO_ENDERECADO               ');
      Add('   FROM                                    ');
      Add('     AGEITE                                ');
      Add('   JOIN AGEREC A                           ');
      Add('     ON A.AUTOINCREM = AIT_SEQGER          ');
      Add('   WHERE ARC_IDEDIG = :IDEDIG              ');
      Add('     AND ARC_CODEMP = :CODEMP              ');

      ParamByName('IDEDIG').AsString := strIdeDig;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      Result := qryAux.FieldByName('TUDO_ENDERECADO').AsString = 'S';
    End;

  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmPlanoDeRecebimento.fPreencheClasseDeLocalParaProdutosComLoteDefinidosNaEntradaSimplificada:Boolean;
  Var
    frmCadLoteItens: TfrmCadLoteItens;
    strItensIrregulares : String;
    stlItens : TStringList;
    stlLocalizacoes : TStringList;
    strLocFis : String;
    blnMostraItens : Boolean;
    frmCadClasseLocFis: TfrmCadClasseLocFis;
    strMsg: String;
Begin
  strItensIrregulares := '';
  stlItens := TStringList.Create;
  stlLocalizacoes := TStringList.Create;
  blnMostraItens := False;
  cdsItens.DisableControls;

  Try
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      If (cdsItens.FieldByName('NUMLOT').AsString <> 'A DEFINIR') Then
      Begin
        strLocFis := TCadLot.fLocalizacaoFisicaLoteC(cdsItens.FieldByName('CODITE').AsString, VS_strCodEmp, cdsItens.FieldByName('NUMLOT').AsString);
        If fEmptyStr(strLocFis) Then
        Begin
          stlItens.Add(cdsItens.FieldByName('CODITE').AsString);

          If not fEmptyStr(strItensIrregulares) Then
            strItensIrregulares := strItensIrregulares + #13;

          strItensIrregulares := strItensIrregulares + cdsItens.FieldByName('CODITE').AsString + ' - ' + cdsItens.FieldByName('NUMLOT').AsString;
        End
        Else
        Begin
          cdsItens.Edit;
          cdsItens.FieldByName('CLASSE').AsString := fGetClasseDeLocalDoLote(cdsItens.FieldByName('CODITE').AsString, cdsItens.FieldByName('NUMLOT').AsString);
          cdsItens.Post;

          If fEmptyStr(cdsItens.FieldByName('CLASSE').AsString) Then
          Begin
            stlLocalizacoes.Add(strLocFis);
          End;
        End;

      End;

      cdsItens.Next;
    End;

    Result := fEmptyStr(strItensIrregulares) And (stlLocalizacoes.Count = 0);

    If not Result Then
    Begin
      If not fEmptyStr(strItensIrregulares) Then
      Begin
        strMsg := 'A entrada simplificada definiu o lote de alguns produtos, porém os produtos/lotes abaixo não tem localização física, '+
                     'defina a localização dos lotes para continuar!' + #13 + strItensIrregulares;
        If blnConfirmacaoAutomatica Then
        Begin
          FFalha := strMsg;
          Exit(False);
        End
        Else
          fMensagem('',strMsg, ['&OK']);

        if fVerificaAcessoSistema('frmCadLoteItens') And (Not blnConfirmacaoAutomatica) Then
        Begin
          If (fMensagem('', 'Deseja editar os lotes sem localização física?' + #13 +
                            'Será aberto o cadastro de lotes, e na consulta dos lotes serão exibidos apenas os produtos com problemas!',
                            ['&Sim', '&Não'],2) = 1) Then
          Begin
            pCriarFormularios(TfrmCadLoteItens, frmCadLoteItens);
            frmCadLoteItens.stlItensComLoteSemLocalizacao := stlItens;
            frmCadLoteItens.ShowModal;
            FreeAndNil(frmCadLoteItens);
            blnMostraItens := True;
          End;

        End;
      End;

      If (stlLocalizacoes.Count > 0) Then
      Begin
        strMsg := 'A entrada simplificada definiu o lote de alguns produtos, porém as localizações abaixo não tem classe de local definido, '+
                     'defina a classe para a localização dos lotes para continuar!' + #13 + fCommaText(stlLocalizacoes);
        If blnConfirmacaoAutomatica Then
        Begin
          FFalha := strMsg;
          Exit(False);
        End
        Else
          fMensagem('', strMsg, ['&OK']);

        If fVerificaAcessoSistema('frmCadClasseLocFis') And (Not blnConfirmacaoAutomatica) then
        Begin
          If (fMensagem('', 'Deseja abrir o cadastro de classes de local?', ['&Sim', '&Não'],2) = 1) Then
          Begin
            pCriarFormularios(TfrmCadClasseLocFis, frmCadClasseLocFis);
            frmCadClasseLocFis.ShowModal;
            FreeAndNil(frmCadClasseLocFis);
            blnMostraItens := True;
          End;
        End;
      End;
    End;

  Finally
    cdsItens.First;
    cdsItens.EnableControls;

    FreeAndNil(stlItens);
    FreeAndNil(stlLocalizacoes);

    if blnMostraItens And fEmptyStr(FFalha) Then
    Begin
      if not fEmptyStr(edtIdeDig.Text) Then
        Result := fMostraItens(edtIdeDig.Text, False)
      Else
        Result := fMostraItens(edtPlaca_.Text, False);
    End;
  End;

End;

function TfrmPlanoDeRecebimento.fGeraCobrancaDePalett(var strErro: String): Boolean;
var strNumDoc: String;
    strAutIncFdo: String;
    strCndPag: String;
    strAutInc: String;
    strCODCND: String;
    strIteSer: String;
    strUniSer: String;
    arrDuplic   : TarrDuplicata;
    recServicos : TDadosServicos;
    fltCusSer: Double;
    objOcoCrm : TAtuOcoCrm;
    strFormaPagamento: String;
    strCodMar: String;
begin
  qryTotalPalet.First;
  recServicos.strCodS01 := fCfgSis('CSDPRM');
  fltCusSer := fRetCustoServico(recServicos.strCodS01);
  recServicos.strDesS01 := fRetNomeServico(recServicos.strCodS01);
  Result := True;
  strIteSer := fCfgSis('ITESER');
  strUniSer := fCampoTabela('ITE_CODUNI', 'CADITE', ['ITE_CODITE'], [strIteSer]);
  strCodMar := fCampoTabela('ITE_CODMAR', 'CADITE', ['ITE_CODITE'], [strIteSer]);

  
  While not qryTotalPalet.Eof Do
  Begin
    objOcoCrm := nil;

   { strCFOP := '5933';

    If qryTotalPalet.FieldByName('CID_ESTADO').AsString = 'EX' Then
        strClaSer := '7933'
    Else iF qryTotalPalet.FieldByName('CID_ESTADO').AsString <> fRetUFEmpresa(VS_StrCodEmp) Then
      strClaSer := '6933';
    }



    strNumDoc := fRetSequencialPedido;
    strCODCND := qryTotalPalet.FieldByName('CND_CODCND').AsString;
    strCndPag := qryTotalPalet.FieldByName('CND_CNDPAG').AsString;
    If strCODCND = '' Then
    Begin
      strCODCND :=fCfgSis('CNDAVI');
      strCndPag := fRetConPag(strCODCND);
    End;


    If strCndPag = '01000' Then
      strFormaPagamento := '001'
    Else
      strFormaPagamento := '008';

    If (VS_strHabilitarCRM) And (Not fEmptyStr(fCfgSis('VENORC', varString))) And (Not fEmptyStr(fCfgSis('VENPED', varString))) Then
      objOcoCrm := fAtualizaInformacoesCRM(strNumDoc,'PD',VS_strCodEmp,qryTotalPalet.FieldByName('FOR_CODCLI').AsString,'','',strLoginUsuarioLogado, afcOrcamento);

    //Calculando Serviços

    pDefineAliquotaIss(qryTotalPalet.FieldByName('FOR_CODCLI').AsString,
                       qryTotalPalet.FieldByName('CLI_CODCID').AsString,
                       recServicos.strCodS01,
                       recServicos.fltPerIss,
                       recServicos.fltRedIss);

    recServicos.fltBasIss :=  qryTotalPalet.FieldByName('TOTAL').AsFloat;
    recServicos.fltBasIss := fFormataFloat(recServicos.fltBasIss * (1 - recServicos.fltRedIss / 100), 2);
    recServicos.fltValIss := fCalculaValorIss(recServicos.fltBasIss, recServicos.fltPerIss);

    recServicos.fltValS01 := qryTotalPalet.FieldByName('TOTAL').AsFloat;
    recServicos.fltTotSer := qryTotalPalet.FieldByName('TOTAL').AsFloat;

    FillChar(arrDuplic, Sizeof(arrDuplic) , #0);
    Result := fGravaFatGor(strAutInc,                                                                                                               //  Var strAutInc: String;
                       VS_strCodEmp,                                                                                                                //  strCodEmp,
                       strNumDoc,                                                                                                                   //    strNumDoc,
                       'PD',                                                                                                                        //    strEspDoc,
                       qryTotalPalet.FieldByName('FOR_CODCLI').AsString,                                                                            //    strCodCli,
                       strLoginUsuarioLogado,                                                                                                       //    strCodVen,
                       fCfgSis('TRASUG'),                                                                                                           //    strCodTra,
                       '',                                                                                                                          //    strSerie: String;
                       VS_Date,                                                                                                                     //    dtaDtaEnt,
                       fTime(),                                                                                                                     //    dtaHorEnt: TDateTime;
                       strCndPag,                                                                                                                   //    strConPag,
                       qryTotalPalet.FieldByName('CID_ESTADO').AsString,                                                                            //    strEstado,
                       '',                                                                                                                          //    strNomCom,
                       '',                                                                                                                          //    strEndCon,
                       '',                                                                                                                          //    strBaiCon,
                       '',                                                                                                                          //    strCepCon,
                       '',                                                                                                                          //    strCidCon,
                       '',                                                                                                                          //    strEstCon,
                       '',                                                                                                                          //    strCodAti,
                       '',                                                                                                                          //    strTelCon: String;
                       0,                                                                                                                           //    dtaNasCon: TDate;
                       '',                                                                                                                          //    strCgcCpf,
                       '',                                                                                                                          //    strCgcCon,
                       '',                                                                                                                          //    strIesCon,
                       '',                                                                                                                          //    strCli_Rg: String;
                       0.0,                                                                                                                         //    fltBasSim,
                       0.0,                                                                                                                         //    fltBasIpi,
                       0.0,                                                                                                                         //    fltAlqIpi,
                       0.0,                                                                                                                         //    fltTotIpi,
                       0.0,                                                                                                                         //    fltBasIcm,
                       0.0,                                                                                                                         //    fltAlqIcm,
                       0.0,                                                                                                                         //    fltTotIcm,
                       0.0,                                                                                                                         //    fltTotRet,
                       0.0,                                                                                                                         //    fltAlqRet,
                       0.0,                                                                                                                         //    fltBasRet,
                       0.0,                                                                                                                         //    fltDesEsp,
                       qryTotalPalet.FieldByName('TOTAL').AsFloat,                                                                                  //    fltVlrCon,
                       0,                                                                                                                           //    fltTotPro,
                       fltCusSer,                                                                                                                   //    fltTotCus,
                       0,                                                                                                                           //    fltTotMed: Double;
                       '9',                                                                                                                         //    strTipFre: String;
                       0.0,                                                                                                                         //    fltTotFre,
                       qryTotalPalet.FieldByName('TOTAL').AsFloat,                                                                                  //    fltVPar01,
                       0.0,                                                                                                                         //    fltVPar02,
                       0.0,                                                                                                                         //    fltVPar03,
                       0.0,                                                                                                                         //    fltVPar04,
                       0.0,                                                                                                                         //    fltVPar05,
                       0.0,                                                                                                                         //    fltVPar06,
                       0.0,                                                                                                                         //    fltVPar07,
                       0.0,                                                                                                                         //    fltVPar08,
                       0.0,                                                                                                                         //    fltVPar09,
                       0.0,                                                                                                                         //    fltVPar10,
                       0.0,                                                                                                                         //    fltVPar11,
                       0.0,                                                                                                                         //    fltVPar12,
                       0.0,                                                                                                                         //    fltDesAce,
                       0,                                                                                                                           //    fltPesBru,
                       0,                                                                                                                           //    fltPesLiq,
                       0,                                                                                                                           //    fltVolume: Double;
                       arrDuplic,                                                                                                                   //    arrDuplic: TarrDuplicata;
                       '',                                                                                                                          //    strEspeci,
                       '',                                                                                                                          //    strMarca,
                       '',                                                                                                                          //    strMen001,
                       '',                                                                                                                          //    strMen002: String;
                       False,                                                                                                                       //    blnJaFatu: Boolean;
                       '',                                                                                                                          //    strTipFat,
                       '',                                                                                                                          //    strNumFat,
                       '',                                                                                                                          //    strEmpFat: String;
                       0,                                                                                                                           //    dtaDtaFat: TDateTime;
                       '',                                                                                                                          //    strVenFat,
                       '',                                                                                                                          //    strCndFat: String;
                       0.0,                                                                                                                         //    fltValFat,
                       0.0,                                                                                                                         //    fltPorDes: Double;
                       strLoginUsuarioLogado,                                                                                                       //    strCodDig,
                       strCODCND,                                                                                                                   //    strCodCnd,
                       IIF(fCfgSis('USAFPG', varBoolean), strFormaPagamento, ''),                                                                   //    strCodFpg: String;
                       recServicos,                                                                                                                 //    recServicos: TDadosServicos;
                       'N',                                                                                                                         //    strConEnt: String;
                       VS_Date,                                                                                                                     //    dtaPreVis: TDateTime;
                       0,                                                                                                                           //    fltVPgAnt: Double;
                       VS_Date,                                                                                                                     //    dtaUltAlt: TDateTime;
                       '',                                                                                                                          //    strNTrava,
                       'A',                                                                                                                         //    strTipPed: String;
                       '',                                                                                                                          //    strCliCtt: String;
                       0,                                                                                                                           //    intLibera: Integer;
                       'N',                                                                                                                          //    strEntFat: String;
                       0,                                                                                                                           //    fltDesCon: Double;
                       '',                                                                                                                          //    strTabPre,
                       'N',                                                                                                                         //    strEntFut: String;
                       0.0,                                                                                                                         //    fltMargem: Double;
                       '',                                                                                                                          //    strNumPok: String;
                       '',  // Empresa CD                                                                                                           //       strEmp_CD: String;
                       False,  // Entrega pelo CD                                                                                                   //       blnEnt_CD: Boolean;
                       VS_StrCodEmp,                                                                                                                          //       strOprFlj,
                       '',                                                                                                                          //       strMenExp,
                       '',                                                                                                                          //       strMenEx2,
                       '',                                                                                                                          //       strMenEx3,
                       '',                                                                                                                          //       strMenEx4: String;
                       '',                                                                                                                          //       strNumReg,
                       '',                                                                                                                          //       strPedSit: String;
                       FALSE,                                                                                                                       //       blnPedLib: Boolean;
                       VS_Date,                                                                                                                     //       dtaDtEntr: TDateTime;
                       'N',                                                                                                                         //       strZerTax,
                       'V',                                                                                                                         //       strTipOpe: String;
                       VS_Date,                                                                                                                     //       dtaDtaOri: TDateTime;
                       'P',                                                                                                                         //       strTipFin: String;
                       0,                                                                                                                           //       fltDesFin: Double;
                       '',                                                                                                                          //       strAutEnt,
                       '',                                                                                                                          //       strPerEnt: String;
                       '',                                                                                                                          //       strEmlCon: String;
                       False,                                                                                                                       //       blnLibCom: Boolean;
                       '',                                                                                                                          //       strMotLib: String;
                       Nil,                                                                                                                         //       objFinanc: Pointer;
                       '',                                                                                                                          //       strEmpFor,
                       '',                                                                                                                          //       strEmp_TE: String;
                       0,                                                                                                                           //       dtaHorImp,
                       0,                                                                                                                           //       dtaDtaTra,
                       0,                                                                                                                           //       dtaHorTra: TDateTime;
                       '',                                                                                                                          //       strIndCom: string;
                       objOcoCrm,                                                                                                                   //       objOcoCrm: Pointer;
                       IFThen(((fCfgSis('UTIPEN', VarBoolean))                                                                                      //       strGerPen: String;
                          And (Pos(fCfgSis('TIPEXP'), '3_4_') > 0)), fCfgSis('PENTRA', varString) , ''),  // strgerpen // gera pendencia // grava sugestao// fltFatNot,,
                       0,                                                                                                                                 // fltFreSug: Double;
                       0,                                                                                                                                 // strPtNfMn,
                       '',                                                                                                                                // strTFTNes: String;
                       '',                                                                                                                                // dtaHPrevi: TDateTime;
                       0,                                                                                                                                 // strCodCar: String;
                       '',                                                                                                                                // intQtdPaC: Integer;
                       0,                                                                                                                                 // strFasObr: String;
                       '',                                                                                                                                // strEntUrg: String;
                       '',                                                                                                                                // strSepImp: String;
                       '',                                                                                                                                // strCorte_: String;
                       'N',                                                                                                                               // strNumGui: String = '';
                       '',                                                                                                                                // strOrcOri: String = '';
                       '',                                                                                                                                // strCodTpA: String = '';
                       '',                                                                                                                              //   strPlaVei: String = '';
                       '',                                                                                                                               //  strKm_Vei: String = '';
                       '',                                                                                                                               //  strCodPor: String = '';
                       '',                                                                                                                               // strRelAba: String = '';
                       'S');

    strAutIncFdo := '';
    Result := Result And fGravaFatDor(strAutIncFdo,                                                                // Var strAutInc: String;
                         strAutInc,                                                                                // strSeqGer: String;
                         VS_strCodEmp,                                                                             // strCodEmp,
                         qryTotalPalet.FieldByName('FOR_CODCLI').AsString,                                         // strCodCli,
                         strLoginUsuarioLogado,                                                                    // strCodVen,
                         strIteSer,                                                                                // strCodIte,
                         strCodMar,                                                                                // strCodMar,
                         '',                                                                                       // strCodDiv,
                         strNumDoc,                                                                                // strNumDoc,
                         'PD',                                                                                     // strEspDoc,
                         '',                                                                                       // strSerie: String;
                         VS_Date,                                                                                  // dtaDtaEnt,
                         fTime(),                                                                                  // dtaHorEnt: TDateTime;
                         strCndPag,                                                                                // strConPag,
                         qryTotalPalet.FieldByName('CID_ESTADO').AsString,                                         // strEstado,
                         fRetNomProduto(fCfgSis('ITESER')),                                                        // strDescri,
                         '',                                                                                       // strRefere,
                         strUniSer,                                                                                // strUnidad,
                        qryTotalPalet.FieldByName('FOR_CODFOR').AsString,                                          // strForIte: String;
                        1,                                                                                         // fltQtdIte,
                         qryTotalPalet.FieldByName('TOTAL').AsFloat,                                               // fltUnitar,
                         qryTotalPalet.FieldByName('TOTAL').AsFloat,                                               // fltUniOri,
                         qryTotalPalet.FieldByName('TOTAL').AsFloat,                                               // fltUniVis,
                         qryTotalPalet.FieldByName('TOTAL').AsFloat,                                               // fltTotIte,
                         qryTotalPalet.FieldByName('TOTAL').AsFloat,                                               // fltVlrCon,
                         fltCusSer,                                                                                // fltTotCus,
                         0,                                                                                        // fltTotMed,
                         0.0,                                                                                      // fltDesCon,
                         0.0,                                                                                      // fltTotFre,
                         0.0,                                                                                      // fltDesEsp,
                         0.0,                                                                                      // fltDesAce: Double;
                         strLoginUsuarioLogado,                                                                    // strCodRep,
                         '',                                                                                       // strCodVe2: String;
                         0.0,                                                                                      // fltPerCom,
                         0.0,                                                                                      // fltTotCom,
                         0.0,                                                                                      // fltTotCo2: Double;
                         '933',                                                                                    // strClaFis,
                         '060',                                                                                    // strCodFis: String;
                         0.0,                                                                                      // fltValIpi,
                         0.0,                                                                                      // fltAlqIpi,
                         0.0,                                                                                      // fltBasIpi,
                         0.0,                                                                                      // fltValIcm,
                         0.0,                                                                                      // fltAlqIcm,
                         0.0,                                                                                      // fltBasIcm,
                         0.0,                                                                                      // fltValRet,
                         0.0,                                                                                      // fltAlqRet,
                         0.0,                                                                                      // fltBasRet,
                         0.0,                                                                                      // fltTotPes,
                         0.0,                                                                                      // fltPerBas,
                         0.0,                                                                                      // fltPerRed: Double;
                         False,                                                                                    // blnJaFatu: Boolean;
                         '',                                                                                       // strTipFat,
                         '',                                                                                       // strNumFat,
                         '',                                                                                       // strEmpFat: String;
                         0,                                                                                        // dtaDtaFat: TDateTime;
                         '',                                                                                       // strVenFat,
                         '',                                                                                       // strCndFat: String;
                         0.0,                                                                                      // fltValFat: Double;
                         'NOR',                                                                                    // strIdePro,
                         'N',                                                                                      // strIncPis,
                         strLoginUsuarioLogado,                                                                    // strCodDig,
                         strCODCND,                                                                                // strCodCnd,
                         '',                                                                                       // strProEmb,
                         IIF(fCfgSis('USAFPG', varBoolean), strFormaPagamento, ''),                                // strCodFpg: String;
                         '',                                                                                       // strIteCha,
                         '',                                                                                       // strIteTin,
                         '',                                                                                       // strDesCor,
                         '',                                                                                       // strTipEmb: String;
                         0.0,                                                                                      // fltQtdEmb,
                         0.0,                                                                                      // fltPreEmb: Double;
                         '',                                                                                       // strTipPre: String;
                         0.0,                                                                                      // fltPrvTin,
                         0.0,                                                                                      // fltPrcTin,
                         0.0,                                                                                      // fltFatTin: Double;
                         '',                                                                                       // strIteEmb,
                         '',                                                                                       // strGruEmb: String;
                         0,                                                                                        // intLazQua: Integer;
                         'N',                                                                                      // strPromoc,
                         '',                                                                                       // strSeqTin: String;
                         0.0,                                                                                      // fltQtdPul: Double;
                         -1,                                                                                       // intSeqInd: Integer;
                         0.0,                                                                                      // fltQtdBai,
                         qryTotalPalet.FieldByName('TOTAL').AsFloat,                                               // fltUniDig: Double;
                         '',                                                                                       // strComple: String;
                         0.0,                                                                                      // fltVolPro: Double;
                         '',                                                                                       // strCodAca,
                         '',                                                                                       // strEmpAca: String;
                         FALSE,                                                                                    // blnProAca: Boolean;
                         '',                                                                                       // strTabPre: String;
                         '',                                                                                       // strLinha: String;
                         '',                                                                                       // strCatali: String;
                         '',                                                                                       // strCodDil: String;
                         0.0,                                                                                      // fltPorDil: Double;
                         '',                                                                                       // strDilCon: String;
                         0.0,                                                                                      // fltPorCat: Double;
                         IIf(fCfgSis('TPITEX') = 'T', 'E', fCfgSis('TPITEX')),                                     // strEntRet,
                         '',                                                                                       // strLocRet,
                         'N',                                                                                      // strEntFut,
                         '',                                                                                       // strMotFut: String;
                         VS_date,                                                                                  // dtaDtEntr: TDateTime;
                         fltCusSer,                                                                                // fltTotCu2: Double;
                         0,                                                                                        // fltComRep,
                         0,                                                                                        // fltPerRep: Double;
                         '',                                                                                       // strKey_EP,
                         '', //cdsItens.FieldByName('NUMLOT').AsString,                                            // strNumLot: String;
                         VS_StrCodEmp,                                                                             // strEmpPrd: String;
                         False,                                                                                    // blnBxSbIt: Boolean;
                         VS_strCodEmp,                                                                             // strEmpIte: String;
                         '',                                                                                       // strDocDev,
                         '',                                                                                       // strEspDev,
                         '',                                                                                       // strEmpDev: String;
                         '',                                                                                       // strEmpFor: String;
                         '',                                                                                       // strOrdPro: String;
                         0,                                                                                        // fltFreSug: Double;
                         0,                                                                                        // fltQtdExp: Double;
                         '',                                                                                       // strBarEmb: String;
                         '',                                                                                       // strNumCmp: String;
                         0,                                                                                        // intNItCmp: Integer;
                         '',                                                                                       // strCodMec: String;
                         '',                                                                                       // strSeqRcd: String;
                         0,                                                                                        // intSeqInc: Integer;
                         0,                                                                                        // intOrdIte: Integer;
                         0);                                                                                       // fltPesLiq: Double;
    qryTotalPalet.Next;
  End;
end;

function TfrmPlanoDeRecebimento.fGetClasseDeLocalDoLote(strCodIteP, strNumLotP : String) : String;
  Var
    qryClaLoc : TUniQuery;
Begin
  Try
    qryClaLoc := fCriaQuery;
    qryClaLoc.SQL.Add(' SELECT CLA_SIGLA_                                     ');
    qryClaLoc.SQL.Add(' FROM CADLOT                                           ');
    qryClaLoc.SQL.Add('   INNER JOIN CLALOC ON CLL_CODLOC = LOT_LOCFIS        ');
    qryClaLoc.SQL.Add('                    AND CLL_CODEMP = LOT_CODEMP        ');
    qryClaLoc.SQL.Add('   INNER JOIN CLASSE ON CLASSE.AUTOINCREM = CLL_SEQGER ');
    qryClaLoc.SQL.Add(' WHERE LOT_CODEMP = :CODEMP                            ');
    qryClaLoc.SQL.Add('   AND LOT_CODITE = :CODITE                            ');
    qryClaLoc.SQL.Add('   AND LOT_NUMLOT = :NUMLOT                            ');
    qryClaLoc.SQL.Add('   AND IFNULL(LOT_LOCFIS,"") <> ""                     ');
    qryClaLoc.SQL.Add(' LIMIT 1                                               ');

    qryClaLoc.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryClaLoc.ParamByName('CODITE').AsString := strCodIteP;
    qryClaLoc.ParamByName('NUMLOT').AsString := strNumLotP;

    qryClaLoc.Open;

    Result := qryClaLoc.FieldByName('CLA_SIGLA_').AsString;

    qryClaLoc.Close;

  Finally
    FreeAndNil(qryClaLoc);
  End;
End;

procedure TfrmPlanoDeRecebimento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  If btnConfirma.Enabled and  cdsItens.Active And (cdsItens.RecordCount > 0)  Then
  Begin
    If fMensagem('', 'Deseja cancelar a Digitação do Plano de Recebimento?', ['&Sim', '&Não'], 2) = 1 Then
      pResetTela;

    Action := caNone;
  End
  Else
    objLock.pDestravarTodos;

  pLimparPreRessuprimento;
end;

procedure TfrmPlanoDeRecebimento.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirmacaoAutomatica := False;
  intESTFLJ := StrToIntDef(fCfgSis('ESTFLJ'), 1);
  blnSuprimirMsgEtiquetasID := false;
  FqryConsulta := fCriaQuery;
  blnConfirmacaoPelaImpressao := false;
  blnApenasRecarregaAgeilo  := False;
  blnSugestaoViaBanco := fCfgSis('SUGBAN', varBoolean);
  shpMsgLocExc.Visible := blnSugestaoViaBanco;
  lblMsgLocExc.Visible := blnSugestaoViaBanco;
  cxgSugestaoTableViewSELECE.Visible := blnSugestaoViaBanco;
  cxgSugestaoTableView.OptionsSelection.CellSelect := Not blnSugestaoViaBanco;

  btnDesmembra.Visible := not fConferenciaAntesDoPlanoDeRecebimento;
  blnSugerirPicking := fCfgSis('PLAPIC', varBoolean);
  qryTotalPalet := fCriaQuery;
  blnColVal := fCfgSis('COLVAL', varBoolean);
  stlLocExcSelecionados := TStringList.Create;
  stlLocExcSelecionados.Duplicates := dupIgnore;
  stlLocSel := TStringList.Create;
  stlLocSelSemPicking := TStringList.Create;
  blnSugereLocalizacao := (fCfgSis('TPLREC', varString) = 'L');
  blnModCub := (fCfgSis('MODCUB', varString) = '2') And blnSugereLocalizacao;
  blnPriPik := fCfgSis('PRIPIK', varBoolean) And blnSugereLocalizacao;
  blnClaPic := fCfgSis('CLAPIC', varBoolean) And (fCfgSis('TPLREC', varString) = 'C');
  cxgItensTableViewMODCUB.Visible := blnModCub;
  pnlCtrlModCub.Visible := blnModCub;
  btnConfirma.Enabled := Not blnModCub;

  If Not pnlCtrlModCub.Visible Then
    pnlLegendas.Height := pnlLegendaConferencia.Height
  Else
    pnlLegendas.Height := pnlLegendaConferencia.Height + pnlCtrlModCub.Height;

  lblMsgDtaVal.Visible := blnSugereLocalizacao and blnSugerirPicking;
  shpMsgDtaVal.Visible := blnSugereLocalizacao and blnSugerirPicking;

  pnlLocalizacao.Visible := shpMsgDtaVal.Visible;
  objLock  := TLock.Create;

  objSugLoc := TSugestaoLocalizacaoFisica.Create(opccPlanoDeRecebimento);

  cxgSugestaoTableViewDtaVal.Options.Editing := Not fCfgSis('PRIPIK', varBoolean);

  qryEtique := fCriaQuery;
  qryLocFis := fCriaQuery;
  qryDigVal := fCriaQuery;
  qryClasse := fCriaQuery;
  qryItensCubAutSemSug := fCriaQuery;
  cdsItens := TZClient.Create(Self);
  cxgItensTableView.DataController.DataSource := cdsItens.dtsSource;
  cdsItens.BeforePost := pBeforePost;

  //Se o Plano de recebimento não for por classe de local, não mostra as colunas
  //de classe e mapeamento da classe.
  cxgItensTableViewCLASSE.Visible  := not blnSugereLocalizacao;
  cxgItensTableViewCXCAMA.Visible  := not blnSugereLocalizacao;
  cxgItensTableViewQTCAMA.Visible  := not blnSugereLocalizacao;
  cxgItensTableViewQTDETI.Visible  := not blnSugereLocalizacao;
  cxgItensTableViewLEGEND.Visible  := not blnSugereLocalizacao;
  cxgItensTableViewQTDEND.Visible  := not blnSugereLocalizacao;
  cxgItensTableViewQTDITE_POR_ETIQUETA.Visible := (not blnModCub) And (not blnSugereLocalizacao);

  imgSepPar.Visible := Not blnSugereLocalizacao;
  lblSepPar.Visible := Not blnSugereLocalizacao;

  pnlEndPar.Visible := lblSepPar.Visible;

  lblConferido.Visible := blnSugereLocalizacao;
  edtConferido.Visible := blnSugereLocalizacao;
  cxgSugestao.Visible  := blnSugereLocalizacao;
  pnlGridsPlanoSuge.Visible := blnSugereLocalizacao;
  cxgSugestaoTableViewDtaVal.Visible := blnColVal And blnSugereLocalizacao;

  //manutenção na quantidade conferida
  cxgItensTableViewQTDCON.Options.Focusing := (not blnSugereLocalizacao);

  With qryDigVal, SQL Do
  Begin
    Close;
    Clear;
    If blnSugereLocalizacao And blnColVal Then
    Begin
      Add(' SELECT DIG_CODITE, DIG_QTDITE, DIV_DTAVAL, DIV_QTDITE ');
      Add(' FROM DIGELE                                           ');
      Add('   INNER JOIN DIGVAL ON DIV_SEQELE = DIGELE.AUTOINCREM ');
      Add(' WHERE DIG_IDEDIG = :IDEDIG                            ');
      Add('   AND DIG_CODITE = :CODITE                            ');
      Add('   AND DIG_CODEMP = :CODEMP                            ');
      Add(' ORDER BY DIV_DTAVAL                                   ');
      If Not blnModCub Then
        Add('  DESC   ');
    End
    Else
    Begin
      Add(' SELECT DIG_CODITE, DIG_QTDITE, CURDATE() AS DIV_DTAVAL, DIG_QTDITE AS DIV_QTDITE ');
      Add(' FROM DIGELE                   ');
      Add(' WHERE DIG_IDEDIG = :IDEDIG    ');
      Add('   AND DIG_CODITE = :CODITE    ');
      Add('   AND DIG_CODEMP = :CODEMP    ');
    End;

  End;

  btnImprimirMaisEtiqID.Visible := blnModCub;

  blnNotasDeTransfApenasManual := fCfgSis('TRFEND', varBoolean);

  blnValidaSeConverte := false;

  FTipoValidaItem := tvAmbos;

  blnImprimeEtqAntesConfer := fCfgSis('IMPEAC', varBoolean);

  blnTrvSug := fCfgSis('TRVSUG', varBoolean);
  blnEtqCon := fCfgSis('ETQCON', varBoolean);
end;

procedure TfrmPlanoDeRecebimento.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryLocFis);
  FreeAndNil(FqryConsulta);
  FreeAndNil(qryTotalPalet);


  FreeAndNil(qryEtique);
  FreeAndNil(qryDigVal);
  FreeAndNil(cdsItens);
  FreeAndNil(qryClasse);
  FreeAndNil(stlLocSel);
  FreeAndNil(stlLocExcSelecionados);
  FreeAndNil(stlLocSelSemPicking);

  FreeAndNil(objLock);

  FreeAndNil(objSugLoc);
  FreeAndNil(qryItensCubAutSemSug);
  inherited;
end;

procedure TfrmPlanoDeRecebimento.pSetarModoCubagem(ABlnAutomatica, ABlnTodos, ABlnResetar: Boolean);
var blnFilter: Boolean;
    strFilter: string;
    strFilterBkp: string;
    blnFilteredBkp: Boolean;
    blnAfterScrollSugest: Boolean;
    blnAfterScrollItens: Boolean;
begin
  cdsItens.DisableControls;
  cdsItens.BeforePost := Nil;
  cdsItens.AfterPost := Nil;


  blnAfterScrollSugest :=  Assigned(cdsLocSug.AfterScroll);
  If blnAfterScrollSugest Then
    cdsLocSug.AfterScroll := Nil;

  blnAfterScrollItens := Assigned(cdsItens.AfterScroll);
  If blnAfterScrollItens Then
    cdsItens.AfterScroll := Nil;

  blnFilteredBkp := cdsItens.Filtered;
  strFilterBkp := cdsItens.Filter;

  Try

    If cdsItens.Filtered Then
      cdsItens.Filtered := False;

    If (Not ABlnTodos) And (intNumSelecParaCubagem > 0) Then
    Begin
      ABlnTodos := True;
      cdsItens.Filter := 'SELECE = ' + QuotedStr('S');
      cdsItens.Filtered := True;
    End;

    If ABlnTodos Then
    Begin
      cdsItens.First;
      While Not cdsItens.Eof Do
      Begin
        If cdsItens.FieldByname('APEPIC').AsString = 'S' Then
        Begin
          cdsItens.Next;
          Continue;
        End;
        cdsItens.Edit;
        If Not ABlnResetar Then
          cdsItens.FieldByName('MODCUB').AsString := IIF(ABlnAutomatica, 'A', 'M')
        Else
          cdsItens.FieldByName('MODCUB').AsString := '';

        cdsItens.Post;
        cdsItens.Next;
      End;
    End
    Else
    Begin
      If Not (cdsItens.FieldByname('APEPIC').AsString = 'S') Then
      Begin
        cdsItens.Edit;
        cdsItens.FieldByName('MODCUB').AsString := IIF(ABlnAutomatica, 'A', 'M');
        cdsItens.Post;
      End;
    End;

    // Limpa selecionados
    If cdsItens.Filtered Then
    Begin
      cdsItens.First;
      While Not cdsItens.Eof Do
      Begin
        cdsItens.Edit;
        cdsItens.FieldByName('SELECE').AsString := QuotedStr('N');
        cdsItens.Post;
      End;
      cdsItens.Filtered := False;
      intNumSelecParaCubagem := 0;
    End;

    If ABlnResetar Then
    Begin
      intNumSelecParaCubagem := 0;

      blnFilter := cdsLocSug.Filtered;
      strFilter := cdsLocSug.Filter;
      Try
        cdsLocSug.Filtered := False;
        cdsLocSug.First;
        while not cdsLocSug.Eof Do
        Begin
          If (cdsLocSug.FieldByName('PICKNG').AsString = 'S') Then
            cdsLocSug.Next
          Else
            cdsLocSug.Delete;
        End;
      Finally

        cdsLocSug.Filtered := False;
        cdsLocSug.Filter := strFilter;
        cdsLocSug.Filtered := blnFilter;
      End;
    End;
  finally
    cdsItens.BeforePost := pBeforePost;
    cdsItens.AfterPost := pAfterPostItens;
    cdsItens.Filtered := blnFilteredBkp;
    cdsItens.Filter := strFilterBkp;
    pAfterPostItens(cdsItens);
    cdsItens.EnableControls;

    If blnAfterScrollSugest Then
      cdsLocSug.AfterScroll := cdsSugestAfterScroll;

    If blnAfterScrollItens Then
      cdsItens.AfterScroll := pFiltraSugestaoCds;
  End;

  objLock.fLock_Unlock('CUBALT_PLANO_RECEBIMENTO_' + cdsItens.FieldByName('AUTINC').AsString, True, False);
end;

procedure TfrmPlanoDeRecebimento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
   VK_F3: If btnCubMan.Enabled Then
              btnCubMan.Click;
    VK_F4: If btnCubAut.Enabled Then
             btnCubAut.Click;
    VK_F5: If btnAtualizarEtiqueta.Enabled Then
             btnAtualizarEtiqueta.Click;
    VK_F6: If pnlCtrlModCub.Visible Then
             btnCubReset.Click;
    VK_F7: If (btnProcCub.Enabled) And (btnProcCub.Visible)  Then
             btnProcCub.Click;
    VK_F8: If pnlBotoesEtiquetas.Visible Then
             btnLimparEtiqueta.Click;
    VK_F9: If pnlBotoesEtiquetas.Visible Then
             btnTirarProduto.Click;
    VK_F10: If btnSugerirLocFisica.Enabled Then
             btnSugerirLocFisica.Click;
    VK_F11: If pnlBotoesEtiquetas.Visible Then
             btnReimprimirEtiqueta.Click;
    VK_DELETE: If (btnLimparLocFisica.Enabled) And (ssCtrl in Shift) Then
             btnLimparLocFisica.Click;
  End;
end;

procedure TfrmPlanoDeRecebimento.FormShow(Sender: TObject);
begin
  inherited;
  shpRed.Visible := fCfgSis('MVFEXC', varString) <> 'N';
  lblLegNaoLocalizado.Visible := shpRed.Visible;

  shpAbPick.Visible := blnPriPik;
  lblLegAbPick.Visible := shpAbPick.Visible;

  cxgSugestaoTableViewABPICK.Visible := blnPriPik;
  If Not blnModCub Then
    cxgSugestaoTableViewLOCTIPO.GroupIndex := -1;

  pSetFocus(edtPlaca_);
end;

function TfrmPlanoDeRecebimento.fValidaAgeite(Aidedig: string): Boolean;
var qry: TUniquery;
begin
  qry := fCriaQuery;
  Try
    qry.SQL.Add('SELECT COUNT(1) AS QTD FROM GERELE');
    qry.SQL.Add('INNER JOIN DETELE ON DET_SEQGER = GERELE.AUTOINCREM');
    qry.SQL.Add('INNER JOIN CADITE ON ITE_CODITE = DETELE.DET_CODITE');
    qry.SQL.Add('WHERE GER_IDEDIG = "'+Aidedig+'"');
    qry.SQL.Add(' AND (SELECT COUNT(1) FROM AGEREC');
    qry.SQL.Add('       INNER JOIN AGEITE ON AIT_SEQGER = AGEREC.AUTOINCREM');
    qry.SQL.Add('       WHERE AGEREC.ARC_IDEDIG = GER_IDEDIG');
    qry.SQL.Add('       AND AGEITE.AIT_CODITE = DETELE.DET_CODITE) = 0');
    qry.SQL.Add(' AND LOCATE("ITEM ESPECIAL", CADITE.ITE_DESITE) = 0 ');
    qry.Open;
    Result := qry.FieldByName('QTD').AsInteger = 0;
    If not Result then
      FFalha := 'Falha ao definir plano para todos os itens!'
  finally
    FreeAndNil(qry);
  end;
end;

function TfrmPlanoDeRecebimento.fValidacampoExterno(Sender : TWinControl; blnBuscaPorChave : Boolean): Boolean;
begin
  Result :=  fValidaCampos(Sender, blnBuscaPorChave);
end;

function TfrmPlanoDeRecebimento.fValidaCampos(Sender: TWinControl;  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = edtPlaca_) Then
    Begin
      If not fEmptyStr(ReplaceStr(edtPlaca_.Text,'-', '')) Then
      Begin
        if Length(ReplaceStr(ReplaceStr(edtPlaca_.Text,'-', ''), ' ', '')) <> 7 then
        begin
          pMensagemOk('A placa deve conter 7 dígitos!');
          Result := False;
        end
        else
        begin
          if blnBuscaPorChave then
            edtIdeDig.Clear;

          Result := fMostraItens(edtPlaca_.Text, True);
        end;
      End
      else if blnBuscaPorChave and fEmptyStr(edtIdeDig.Text) and cdsItens.Active And (cdsItens.RecordCount > 0) then
      begin
        pResetTela;
        blnMudarFoco := False;
      end;

    End

    Else
    If (Sender = edtIdeDig) Then
    Begin
      If not fEmptyStr(edtIdeDig.Text) Then
      Begin
        if blnBuscaPorChave then
          edtPlaca_.Clear;

        Result := fMostraItens(edtIdeDig.Text, True);
      End
      else if blnBuscaPorChave and fEmptyStr(ReplaceStr(edtPlaca_.Text,'-', '')) then
      begin
        if not (cdsItens.Active And (cdsItens.RecordCount > 0)) then
          pMensagemOk('É necessário informar a placa ou o sequencial de recebimento para continuar!');

        pResetTela;
        blnMudarFoco := False;
      end;

    End;

    If (((Sender = edtIdeDig) And (not fEmptyStr(edtIdeDig.Text))) Or
        ((Sender = edtPlaca_) And (Not fEmptyStr( ReplaceStr(edtPlaca_.Text,'-',''))))) And Result Then
    Begin
      blnMudarFoco := False;
      pSetFocus(cxgItens);
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmPlanoDeRecebimento.pAfterPostItens(DataSet: TDataSet);
var blnTemPickin: Boolean;
    //filterOri: String;
    //filterdOri: Boolean;
    blnEfetivado: Boolean;
    strFilterBkp: String;
    blnFilteredBkp: Boolean;
    blnComScroll: Boolean;
begin
  blnFilteredBkp := cdsItens.Filtered;
  strFilterBkp := cdsItens.Filter;

  blnComScroll := Assigned(cdsItens.AfterScroll);
  cdsItens.AfterScroll := nil;
  cdsItens.Filtered := False;

  Try
    cdsItens.First;
    blnEfetivado := cdsItens.FieldByName('MOVEFE').AsString = 'S';
    blnTodasModCubPreenchidas := True;
    blnTemCubagemAutomatica := False;
    blnTemCubagemManual := False;
    blnTemPickin := False;
    while not cdsItens.Eof Do
    Begin
      If (cdsItens.FieldByName('MODCUB').AsString = '') And (cdsItens.FieldByName('APEPIC').AsString = 'N') And (blnTodasModCubPreenchidas) Then
        blnTodasModCubPreenchidas := False;
      If (Not blnTemCubagemAutomatica) And (cdsItens.FieldByName('MODCUB').AsString = 'A') Then
        blnTemCubagemAutomatica := True;

      If (Not blnTemPickin) And (cdsItens.FieldByName('ABPICK').AsString = 'S') Then
        blnTemPickin := True;

      If (cdsItens.FieldByName('MODCUB').AsString = 'M')  And (Not blnTemCubagemManual) Then
        blnTemCubagemManual := True;
      cdsItens.Next;
    End;

    btnProcCub.Visible := blnTodasModCubPreenchidas And blnTemCubagemAutomatica;
    If Not blnRestaurouDaAgeilo Then
    begin
      btnImprimir.Enabled := ( blnTodasModCubPreenchidas And (Not blnTemCubagemAutomatica));
      If (blnTemPickin) And (blnModCub) and (blnPriPik) And (Not blnEfetivado) Then
        btnImprimir.Enabled := True;
    End;

    btnConfirma.Enabled := blnTodasModCubPreenchidas;
    cdsItens.Filtered :=  blnFilteredBkp;
    cdsItens.Filter := strFilterBkp;
  Finally
    cdsItens.Filtered :=  blnFilteredBkp;
    cdsItens.Filter := strFilterBkp;
    If blnComScroll Then
      cdsItens.AfterScroll := pFiltraSugestaoCds;
  End;
end;

procedure TfrmPlanoDeRecebimento.pAtualizarPlano;
Var
  qryAgeIlo,
  qryAgeIloUpd,
  qryAux,
  qryUpd : TUniQuery;
  cdsBackup: TUniClientDataSet;
  intSequen,
  intMaxSequen: integer;
  blnBloqueado: Boolean;
  strAutIncPlano,
  strMsgLocfis,
  strMsgAgeIlo,
  strMsgBloqueio: String;
  stlAgeIloPlano,                 //AGEILO existentes no plano antes da atualizacao
  stlAgeIloMantidas: TStringList; //AGEILO atualizadas/inseridas nesta atualizacao

  function fRetQtdCon: Double;
  Begin
    //13.10.2022 - TK: Removido laco While para evitar que a QTDCON ficasse 'dobrada'(x2)
    cdsBackup.Filtered := False;
    cdsBackup.Filter := 'CODITE = ' + QuotedStr(cdsItens.FieldByName('CODITE').AsString);
    cdsBackup.Filtered := True;
    Result := cdsBackup.FieldByName('QTDCONORI').AsFloat;
  End;

  //Req. 470785 - Nao permite trocar a localizacao (AIL_LOCFIS) nem o tipo
  //picking/buffer (AIL_PICKNG) de uma AGEILO ja enderecada ou com conferencia
  //no coletor (AGEETE). Trava a linha (FOR UPDATE) ate o fim da transacao.
  function fPodeAlterarLocalizacao(const strAutIncAgeIlo, strNovoLocfis, strNovoPickng: String): Boolean;
  Var
    strMotivo,
    strPickngAtu,
    strAlteracao: String;
  Begin
    Result := True;
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT L.AIL_LOCFIS, L.AIL_ENDERE, I.AIT_CODITE,     ');
    qryAux.SQL.Add('        IF(L.AIL_PICKNG = "S", "S", "N") AIL_PICKNG,  ');
    qryAux.SQL.Add('        (SELECT COUNT(1) FROM AGEETE E                ');
    qryAux.SQL.Add('          WHERE E.ETE_SEQAIL = L.AUTOINCREM) QTDETE   ');
    qryAux.SQL.Add('   FROM AGEILO L                                      ');
    qryAux.SQL.Add('  INNER JOIN AGEITE I ON I.AUTOINCREM = L.AIL_SEQITE  ');
    qryAux.SQL.Add('  WHERE L.AUTOINCREM = :AUTINC                        ');
    qryAux.SQL.Add('    FOR UPDATE                                        ');
    qryAux.ParamByName('AUTINC').AsString := strAutIncAgeIlo;
    qryAux.Open;

    If (Not qryAux.IsEmpty) And
       ((qryAux.FieldByName('AIL_ENDERE').AsString = 'S') Or
        (qryAux.FieldByName('QTDETE').AsInteger > 0)) Then
    Begin
      strPickngAtu := qryAux.FieldByName('AIL_PICKNG').AsString;
      strAlteracao := '';

      If Trim(qryAux.FieldByName('AIL_LOCFIS').AsString) <> Trim(strNovoLocfis) Then
        strAlteracao := Format('Localização %s -> %s',
                          [Trim(qryAux.FieldByName('AIL_LOCFIS').AsString), Trim(strNovoLocfis)]);

      If strPickngAtu <> strNovoPickng Then
      Begin
        If strAlteracao <> '' Then
          strAlteracao := strAlteracao + ' / ';
        strAlteracao := strAlteracao + Format('Tipo %s -> %s',
                          [IIF(strPickngAtu = 'S', 'Picking', 'Buffer'),
                           IIF(strNovoPickng = 'S', 'Picking', 'Buffer')]);
      End;

      If strAlteracao <> '' Then
      Begin
        If qryAux.FieldByName('AIL_ENDERE').AsString = 'S' Then
          strMotivo := 'endereçada'
        Else
          strMotivo := 'conferida no coletor';

        strMsgLocfis := strMsgLocfis + #13#10 +
                        Format('Item %s - %s (%s)',
                          [qryAux.FieldByName('AIT_CODITE').AsString, strAlteracao, strMotivo]);
        Result := False;
      End;
    End;
    qryAux.Close;
  End;

  //Req. 470785 - UPDATE da AGEILO sem linhas afetadas. No MySQL o RowsAffected
  //tambem retorna 0 quando os valores gravados sao iguais aos atuais, por isso
  //confere no banco se a linha ainda existe e se localizacao/tipo batem.
  procedure pConfereUpdateAgeilo(const strAutIncAgeIlo, strLocfis, strPickng: String);
  Begin
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT AIL_LOCFIS, IF(AIL_PICKNG = "S", "S", "N") AIL_PICKNG ');
    qryAux.SQL.Add('   FROM AGEILO WHERE AUTOINCREM = :AUTINC                ');
    qryAux.ParamByName('AUTINC').AsString := strAutIncAgeIlo;
    qryAux.Open;

    If qryAux.IsEmpty Then
      strMsgAgeIlo := strMsgAgeIlo + #13#10 +
                      Format('Item %s - Localização %s (excluída por outro processo)',
                        [cdsItens.FieldByName('CODITE').AsString, Trim(strLocfis)])
    Else
    If (Trim(qryAux.FieldByName('AIL_LOCFIS').AsString) <> Trim(strLocfis)) Or
       (qryAux.FieldByName('AIL_PICKNG').AsString <> strPickng) Then
      strMsgAgeIlo := strMsgAgeIlo + #13#10 +
                      Format('Item %s - Localização %s -> %s (endereçada/conferida durante a atualiza'#231#227'o)',
                        [cdsItens.FieldByName('CODITE').AsString,
                         Trim(qryAux.FieldByName('AIL_LOCFIS').AsString),
                         Trim(strLocfis)]);
    qryAux.Close;
  End;

  procedure pAtualizaAgeilo;
  Var
    qryGrava: TUniQuery;
    strAutIncAgeIlo,
    strPickng: String;
  Begin
    pFiltraSugestaoCds(cdsItens);
    intSequen := intMaxSequen;
    If blnModCub Then
    Begin
      cdsLocSug.First;
      while not cdsLocSug.Eof do
      Begin
        If (Not cdsLocSug.FieldByName('SELECE').AsBoolean) Then
        Begin
          cdsLocSug.Next;
          Continue;
        End;
        Inc(intSequen);

        //'S' = picking; qualquer outro valor (NULL, '', 'N') = buffer
        strPickng := IIF(cdsLocSug.FieldByName('PICKNG').AsString = 'S', 'S', 'N');
        If strPickng = '' Then
          strPickng := 'N';

        //Req. 470785 - Mantem o AUTOINCREM da AGEILO ja gravada (UPDATE) para nao
        //perder em cascata a AGEETE (conferencia do coletor). Linha nova -> INSERT.
        strAutIncAgeIlo := cdsLocSug.FieldByName('AUTINC').AsString;
        If (strAutIncAgeIlo <> '') And
           (stlAgeIloPlano.IndexOf(strAutIncAgeIlo) >= 0) And
           (stlAgeIloMantidas.IndexOf(strAutIncAgeIlo) < 0) Then
        Begin
          qryGrava := qryAgeIloUpd;

          If Not fPodeAlterarLocalizacao(strAutIncAgeIlo,
                                         cdsLocSug.FieldByName('LOCFIS').AsString,
                                         strPickng) Then
          Begin
            //Mantida para nao ser excluida; a atualizacao sera desfeita no final
            stlAgeIloMantidas.Add(strAutIncAgeIlo);
            cdsLocSug.Next;
            Continue;
          End;
        End
        Else
        Begin
          qryGrava := qryAgeIlo;
          strAutIncAgeIlo := fRetAutoIncrem('AGEILO', VS_strCodEmp);
          qryGrava.ParamByName('SEQITE').AsString := cdsLocSug.FieldByName('CHAVE').AsString;
        End;

        qryGrava.ParamByName('AUTINC').AsString   := strAutIncAgeIlo;
        qryGrava.ParamByName('QTDITE').AsFloat    := cdsLocSug.FieldByName('QTDITE').AsFloat;
        qryGrava.ParamByName('PICKNG').AsString   := strPickng;
        qryGrava.ParamByName('LOCFIS').AsString   := cdsLocSug.FieldByName('LOCFIS').AsString;
        qryGrava.ParamByName('DTAVEN').AsDateTime := cdsLocSug.FieldByName('DTAVAL').AsDateTime;
        qryGrava.ParamByName('QTDVEN').AsFloat    := cdsLocSug.FieldByName('QTDVEN').AsFloat;
        If cdsLocSug.FieldByName('ENDERE').AsString = '' Then
          qryGrava.ParamByName('ENDERE').AsString := 'N'
        Else
          qryGrava.ParamByName('ENDERE').AsString := cdsLocSug.FieldByName('ENDERE').AsString;
        qryGrava.ParamByName('IMPRES').AsString   := cdsLocSug.FieldByName('AIL_IMPRES').AsString;

        If cdsLocSug.FieldByName('SEQUEN').Asinteger > 0 Then
          qryGrava.ParamByName('SEQUEN').AsInteger := cdsLocSug.FieldByName('SEQUEN').Asinteger
        Else
        begin
          inc(intSequen);
          qryGrava.ParamByName('SEQUEN').AsInteger := intSequen;
        End;

        qryGrava.ExecSQL;

        If (qryGrava = qryAgeIloUpd) And (qryGrava.RowsAffected = 0) Then
          pConfereUpdateAgeilo(strAutIncAgeIlo, cdsLocSug.FieldByName('LOCFIS').AsString, strPickng);

        stlAgeIloMantidas.Add(strAutIncAgeIlo);
        cdsLocSug.Next;
      End;
    End;
  End;

    //Req. 470785 - Remonta a AGEETE das AGEILO que sairao do plano, apontando-a
  //para outra AGEILO do mesmo item e do MESMO TIPO (picking/buffer), com saldo
  //livre suficiente (em unidades). Linha enderecada nao pode sair do plano.
  function fRemontaAgeete(var strMsg: String): Boolean;
  Var
    qryDestino,
    qryMove: TUniQuery;
    intIdx: Integer;
    strNaoMantidas,
    strPickng: String;
  Begin
    Result := True;
    strMsg := '';
    If (Not blnModCub) Or (stlAgeIloPlano.Count = 0) Then
      Exit;

    strNaoMantidas := '';
    For intIdx := 0 To stlAgeIloPlano.Count - 1 Do
    Begin
      If stlAgeIloMantidas.IndexOf(stlAgeIloPlano[intIdx]) >= 0 Then
        Continue;
      If strNaoMantidas <> '' Then
        strNaoMantidas := strNaoMantidas + ',';
      strNaoMantidas := strNaoMantidas + QuotedStr(stlAgeIloPlano[intIdx]);
    End;

    If strNaoMantidas = '' Then
      Exit;

    //Linha ja enderecada nao pode sair do plano (com ou sem AGEETE)
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT I.AIT_CODITE, L.AIL_LOCFIS, L.AIL_QTDVEN,     ');
    qryAux.SQL.Add('        IF(L.AIL_PICKNG = "S", "S", "N") AIL_PICKNG   ');
    qryAux.SQL.Add('   FROM AGEILO L                                      ');
    qryAux.SQL.Add('  INNER JOIN AGEITE I ON I.AUTOINCREM = L.AIL_SEQITE  ');
    qryAux.SQL.Add('  WHERE L.AUTOINCREM IN (' + strNaoMantidas + ')');
    qryAux.SQL.Add('    AND L.AIL_ENDERE = "S"                            ');
    qryAux.Open;
    While Not qryAux.Eof Do
    Begin
      strMsg := strMsg + #13#10 + Format('Item %s - %s - Localização %s - Qtd. %s',
                  [qryAux.FieldByName('AIT_CODITE').AsString,
                   IIF(qryAux.FieldByName('AIL_PICKNG').AsString = 'S', 'Picking', 'Buffer'),
                   qryAux.FieldByName('AIL_LOCFIS').AsString,
                   FormatFloat('0.####', qryAux.FieldByName('AIL_QTDVEN').AsFloat)]);
      qryAux.Next;
    End;
    qryAux.Close;

    If strMsg <> '' Then
    Begin
      strMsg := 'Não é possível atualizar o plano de recebimento!' + #13#10 +
                'As localizações abaixo já foram endereçadas e não podem sair do plano:' +
                strMsg;
      Result := False;
      Exit;
    End;

    qryDestino := Nil;
    qryMove    := Nil;
    Try
      qryDestino := fCriaQuery;
      qryMove    := fCriaQuery;

      //AGEILO que sairao do plano e possuem conferencia (ja travadas pelo FOR UPDATE)
      qryAux.SQL.Clear;
      qryAux.SQL.Add(' SELECT L.AUTOINCREM, L.AIL_SEQITE, L.AIL_LOCFIS, L.AIL_SEQUEN,    ');
      qryAux.SQL.Add('        IF(L.AIL_PICKNG = "S", "S", "N") AIL_PICKNG,               ');
      qryAux.SQL.Add('        I.AIT_CODITE, SUM(E.ETE_QTDITE) QTDCON                     ');
      qryAux.SQL.Add('   FROM AGEILO L                                                   ');
      qryAux.SQL.Add('  INNER JOIN AGEITE I ON I.AUTOINCREM = L.AIL_SEQITE               ');
      qryAux.SQL.Add('  INNER JOIN AGEETE E ON E.ETE_SEQAIL = L.AUTOINCREM               ');
      qryAux.SQL.Add('  WHERE L.AUTOINCREM IN (' + strNaoMantidas + ')                   ');
      qryAux.SQL.Add('  GROUP BY L.AUTOINCREM, L.AIL_SEQITE, L.AIL_LOCFIS, L.AIL_SEQUEN, ');
      qryAux.SQL.Add('           L.AIL_PICKNG, I.AIT_CODITE                              ');
      qryAux.Open;

      //Destino obrigatorio: mesmo item, mesmo tipo, ainda NAO enderecado e saldo
      //livre (em unidades, AIL_QTDVEN) >= quantidade conferida movida.
      //Desempate: mesma localizacao, mesma sequencia, maior saldo.
      qryDestino.SQL.Add(' SELECT N.AUTOINCREM                                          ');
      qryDestino.SQL.Add('   FROM AGEILO N                                              ');
      qryDestino.SQL.Add('  WHERE N.AIL_SEQITE = :SEQITE                                ');
      qryDestino.SQL.Add('    AND N.AUTOINCREM NOT IN (' + strNaoMantidas + ')');
      qryDestino.SQL.Add('    AND IF(N.AIL_PICKNG = "S", "S", "N") = :PICKNG            ');
      qryDestino.SQL.Add('    AND IF(N.AIL_ENDERE = "S", "S", "N") = "N"                ');
      qryDestino.SQL.Add('    AND (N.AIL_QTDVEN - COALESCE((SELECT SUM(Y.ETE_QTDITE)    ');
      qryDestino.SQL.Add('                                    FROM AGEETE Y            ');
      qryDestino.SQL.Add('                                   WHERE Y.ETE_SEQAIL = N.AUTOINCREM), 0)) >= :QTDCON');
      qryDestino.SQL.Add('  ORDER BY (COALESCE(N.AIL_LOCFIS, "") = :LOCFIS) DESC,       ');
      qryDestino.SQL.Add('           (N.AIL_SEQUEN = :SEQUEN) DESC,                     ');
      qryDestino.SQL.Add('           (N.AIL_QTDVEN - COALESCE((SELECT SUM(X.ETE_QTDITE) ');
      qryDestino.SQL.Add('                                       FROM AGEETE X         ');
      qryDestino.SQL.Add('                                      WHERE X.ETE_SEQAIL = N.AUTOINCREM), 0)) DESC');
      qryDestino.SQL.Add('  LIMIT 1                                                     ');

      qryMove.SQL.Add(' UPDATE AGEETE SET ETE_SEQAIL = :NOVO WHERE ETE_SEQAIL = :ANTIGO ');

      While Not qryAux.Eof Do
      Begin
        strPickng := qryAux.FieldByName('AIL_PICKNG').AsString;

        qryDestino.Close;
        qryDestino.ParamByName('SEQITE').AsString  := qryAux.FieldByName('AIL_SEQITE').AsString;
        qryDestino.ParamByName('PICKNG').AsString  := strPickng;
        qryDestino.ParamByName('QTDCON').AsFloat   := qryAux.FieldByName('QTDCON').AsFloat;
        qryDestino.ParamByName('LOCFIS').AsString  := qryAux.FieldByName('AIL_LOCFIS').AsString;
        qryDestino.ParamByName('SEQUEN').AsInteger := qryAux.FieldByName('AIL_SEQUEN').AsInteger;
        qryDestino.Open;

        If qryDestino.IsEmpty Then
          strMsg := strMsg + #13#10 + Format('Item %s - %s - Localização %s - Qtd. conferida %s',
                      [qryAux.FieldByName('AIT_CODITE').AsString,
                       IIF(strPickng = 'S', 'Picking', 'Buffer'),
                       qryAux.FieldByName('AIL_LOCFIS').AsString,
                       FormatFloat('0.####', qryAux.FieldByName('QTDCON').AsFloat)])
        Else
        Begin
          qryMove.ParamByName('NOVO').AsString   := qryDestino.FieldByName('AUTOINCREM').AsString;
          qryMove.ParamByName('ANTIGO').AsString := qryAux.FieldByName('AUTOINCREM').AsString;
          qryMove.ExecSQL;
        End;
        qryAux.Next;
      End;
      qryAux.Close;

      If strMsg <> '' Then
      Begin
                strMsg := 'Não é possível atualizar o plano de recebimento!' + #13#10 +
                  'As localizações abaixo possuem conferência no coletor e deixariam de existir no plano.' + #13#10 +
                  'Não há outra localização do item, do mesmo tipo (picking/buffer), ainda não endereçada' +
                  ' e com saldo suficiente para receber a conferência:' + strMsg;

        Result := False;
        Exit;
      End;

      //Sem AGEETE vinculada e sem enderecamento, a exclusao nao perde nada
      qryMove.Close;
      qryMove.SQL.Clear;
      qryMove.SQL.Add(' DELETE FROM AGEILO WHERE AUTOINCREM IN (' + strNaoMantidas + ')');
      qryMove.ExecSQL;
    Finally
      FreeAndNil(qryDestino);
      FreeAndNil(qryMove);
    End;
  End;

    //Req. 470785 - A quantidade conferida (AGEETE, em unidades) nao pode exceder
  //a planejada em unidades (AIL_QTDVEN). AIL_QTDITE esta em embalagens.
  function fValidaQtdConferidaAgeete(var strMsg: String): Boolean;
  Begin
    Result := True;
    strMsg := '';
    If Not blnModCub Then
      Exit;

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT I.AIT_CODITE, L.AIL_LOCFIS, L.AIL_QTDVEN,     ');
    qryAux.SQL.Add('        SUM(E.ETE_QTDITE) QTDCON                      ');
    qryAux.SQL.Add('   FROM AGEITE I                                      ');
    qryAux.SQL.Add('  INNER JOIN AGEILO L ON L.AIL_SEQITE = I.AUTOINCREM  ');
    qryAux.SQL.Add('  INNER JOIN AGEETE E ON E.ETE_SEQAIL = L.AUTOINCREM  ');
    qryAux.SQL.Add('  WHERE I.AIT_SEQGER = :AUTINC                        ');
    qryAux.SQL.Add('  GROUP BY L.AUTOINCREM, I.AIT_CODITE, L.AIL_LOCFIS, L.AIL_QTDVEN');
    qryAux.SQL.Add(' HAVING SUM(E.ETE_QTDITE) > L.AIL_QTDVEN              ');
    qryAux.ParamByName('AUTINC').AsString := strAutIncPlano;
    qryAux.Open;

    While Not qryAux.Eof Do
    Begin
      strMsg := strMsg + #13#10 + Format('Item %s - Localização %s - Planejado %s - Conferido %s',
                  [qryAux.FieldByName('AIT_CODITE').AsString,
                   qryAux.FieldByName('AIL_LOCFIS').AsString,
                   FormatFloat('0.####', qryAux.FieldByName('AIL_QTDVEN').AsFloat),
                   FormatFloat('0.####', qryAux.FieldByName('QTDCON').AsFloat)]);
      qryAux.Next;
    End;
    qryAux.Close;

    If strMsg <> '' Then
    Begin
      strMsg := 'Não é possível atualizar o plano de recebimento!' + #13#10 +
                'A quantidade planejada ficaria menor que a quantidade já conferida no coletor:' +
                strMsg;
      Result := False;
    End;
  End;

Begin
  qryUpd            := Nil;
  qryAgeIlo         := Nil;
  qryAgeIloUpd      := Nil;
  qryAux            := Nil;
  cdsBackup         := Nil;
  stlAgeIloPlano    := Nil;
  stlAgeIloMantidas := Nil;
  strMsgLocfis      := '';
  strMsgAgeIlo      := '';

  cdsLocSug.AfterScroll := Nil;
  cdsLocSug.DisableControls;
  Try
    //Sem nada a gravar: nao abre transacao (antes ficava aberta sem commit/rollback)
    If blnSugereLocalizacao And (Not blnModCub) Then
      Exit;

    qryUpd       := fCriaQuery;
    qryAgeIlo    := fCriaQuery;
    qryAgeIloUpd := fCriaQuery;
    qryAux       := fCriaQuery;
    cdsBackup    := TUniClientDataSet.Create(nil);

    stlAgeIloPlano := TStringList.Create;
    stlAgeIloPlano.Sorted := True;
    stlAgeIloPlano.Duplicates := dupIgnore;

    stlAgeIloMantidas := TStringList.Create;
    stlAgeIloMantidas.Sorted := True;
    stlAgeIloMantidas.Duplicates := dupIgnore;

    strAutIncPlano := cdsItens.FieldByName('AUTINC').AsString;

    qryAgeIlo.SQL.Clear;
    qryAgeIlo.SQL.Add('SELECT MAX(AIL_SEQUEN) MAX_SEQUE FROM AGEILO');
    qryAgeIlo.SQL.Add(' INNER JOIN AGEITE ON AGEITE.AUTOINCREM = AIL_SEQITE');
    qryAgeIlo.SQL.Add(' WHERE AIT_SEQGER = :AUTINC');
    qryAgeIlo.ParamByName('AUTINC').AsString := strAutIncPlano;
    qryAgeIlo.Open;
    intMaxSequen := qryAgeIlo.FieldByName('MAX_SEQUE').AsInteger;
    qryAgeIlo.Close;

    If blnModCub Then
    Begin
      qryAgeIlo.SQL.Clear;
      qryAgeIlo.SQL.Add(' INSERT INTO AGEILO(AUTOINCREM, AIL_SEQITE, AIL_QTDITE, AIL_LOCFIS, AIL_DTAVEN, AIL_QTDVEN, AIL_SEQUEN, AIL_ENDERE, AIL_PICKNG, AIL_IMPRES) ');
      qryAgeIlo.SQL.Add(' VALUES(:AUTINC, :SEQITE, :QTDITE, :LOCFIS, :DTAVEN, :QTDVEN, :SEQUEN, :ENDERE, :PICKNG, :IMPRES) ');

      //AIL_ENDERE nunca retrocede de "S". A troca de AIL_LOCFIS/AIL_PICKNG e
      //validada em fPodeAlterarLocalizacao; o WHERE e uma segunda protecao.
      //Req. 470785 - Em linha enderecada ou com AGEETE, AIL_DTAVEN e AIL_SEQUEN
      //mantem os valores atuais.
      //ATENCAO: no MySQL as atribuicoes do SET sao avaliadas da esquerda para a
      //direita. AIL_DTAVEN e AIL_SEQUEN tem que ficar ANTES de AIL_ENDERE para
      //o IF ler o AIL_ENDERE original do banco, e nao o valor recem-gravado.
      qryAgeIloUpd.SQL.Add(' UPDATE AGEILO SET                                          ');
      qryAgeIloUpd.SQL.Add('   AIL_QTDITE = IF(AIL_ENDERE = "S", AIL_QTDITE, :QTDITE),  ');
      qryAgeIloUpd.SQL.Add('   AIL_LOCFIS = :LOCFIS,                                    ');
      qryAgeIloUpd.SQL.Add('   AIL_DTAVEN = IF(COALESCE(AIL_ENDERE, "N") = "S"          ');
      qryAgeIloUpd.SQL.Add('                   OR EXISTS (SELECT 1 FROM AGEETE          ');
      qryAgeIloUpd.SQL.Add('                               WHERE ETE_SEQAIL = AGEILO.AUTOINCREM), ');
      qryAgeIloUpd.SQL.Add('                   AIL_DTAVEN, :DTAVEN),                    ');
      qryAgeIloUpd.SQL.Add('   AIL_QTDVEN = IF(AIL_ENDERE = "S", AIL_QTDVEN, :QTDVEN),  ');
      qryAgeIloUpd.SQL.Add('   AIL_SEQUEN = IF(COALESCE(AIL_ENDERE, "N") = "S"          ');
      qryAgeIloUpd.SQL.Add('                   OR EXISTS (SELECT 1 FROM AGEETE          ');
      qryAgeIloUpd.SQL.Add('                               WHERE ETE_SEQAIL = AGEILO.AUTOINCREM), ');
      qryAgeIloUpd.SQL.Add('                   AIL_SEQUEN, :SEQUEN),                    ');
      qryAgeIloUpd.SQL.Add('   AIL_ENDERE = IF(AIL_ENDERE = "S", "S", :ENDERE),         ');
      qryAgeIloUpd.SQL.Add('   AIL_PICKNG = :PICKNG,                                    ');
      qryAgeIloUpd.SQL.Add('   AIL_IMPRES = :IMPRES                                     ');
      qryAgeIloUpd.SQL.Add(' WHERE AUTOINCREM = :AUTINC                                 ');
      qryAgeIloUpd.SQL.Add('   AND ((COALESCE(AIL_LOCFIS, "") = :LOCFIS                 ');
      qryAgeIloUpd.SQL.Add('         AND IF(AIL_PICKNG = "S", "S", "N") = :PICKNG)      ');
      qryAgeIloUpd.SQL.Add('        OR (COALESCE(AIL_ENDERE, "N") <> "S"                ');
      qryAgeIloUpd.SQL.Add('            AND NOT EXISTS (SELECT 1 FROM AGEETE            ');
      qryAgeIloUpd.SQL.Add('                             WHERE ETE_SEQAIL = AGEILO.AUTOINCREM))) ');
    End;

    With qryUpd, SQL Do
    Begin
      Clear;
      Add(' UPDATE                      ');
      Add(' DIGELE SET                  ');
      Add('   DIG_QTDITE = :QTDCON      ');
      Add(' WHERE                       ');
      Add('   DIG_IDEDIG = :DIGIDE AND  ');
      Add('   DIG_CODEMP = :CODEMP AND  ');
      Add('   DIG_CODITE = :CODITE;     ');

      Add(' UPDATE                      ');
      Add(' AGEITE SET                  ');
      If Not blnSugereLocalizacao Then
        Add('  AIT_CLASSE  = :CLASSE    ');
      If blnModCub Then
        Add('  AIT_MODCUB  = :MODCUB    ');
      Add(' WHERE                       ');
      Add('   AIT_SEQGER = :AUTINC AND  ');
      Add('   AUTOINCREM = :INCREM AND  ');
      Add('   AIT_CODITE = :CODITE;     ');
    End;

    fStartTransaction;
    Try
      If blnModCub Then
      Begin
        //Req. 470785 - FOR UPDATE: trava as AGEILO do plano ate o commit/rollback.
        //A FK da AGEETE exige lock na AGEILO pai, entao o coletor nao consegue
        //gravar conferencia numa AGEILO que sera excluida em fRemontaAgeete.
        qryAux.SQL.Clear;
        qryAux.SQL.Add(' SELECT AGEILO.AUTOINCREM FROM AGEILO                 ');
        qryAux.SQL.Add('  INNER JOIN AGEITE ON AGEITE.AUTOINCREM = AIL_SEQITE ');
        qryAux.SQL.Add('  WHERE AIT_SEQGER = :AUTINC                          ');
        qryAux.SQL.Add('    FOR UPDATE                                        ');
        qryAux.ParamByName('AUTINC').AsString := strAutIncPlano;
        qryAux.Open;
        While Not qryAux.Eof Do
        Begin
          stlAgeIloPlano.Add(qryAux.FieldByName('AUTOINCREM').AsString);
          qryAux.Next;
        End;
        qryAux.Close;
      End;

      cdsItens.First;
      While not cdsItens.Eof Do
      Begin
        if cdsItens.FieldByName('APEPIC').AsString <> 'S' Then
        Begin
          cdsBackup.Data := cdsItens.Data;
          qryUpd.ParamByName('QTDCON').AsFloat  := fRetQtdCon;
          qryUpd.ParamByName('DIGIDE').AsString := strIdeDig;
          qryUpd.ParamByName('CODEMP').AsString := VS_strCodEmp;
          qryUpd.ParamByName('CODITE').AsString := cdsItens.FieldByName('CODITE').AsString;
          qryUpd.ParamByName('AUTINC').AsString := cdsItens.FieldByName('AUTINC').AsString;
          qryUpd.ParamByName('INCREM').AsString := cdsItens.FieldByName('CHAVE').AsString;

          If Not blnSugereLocalizacao Then
            qryUpd.ParamByName('CLASSE').AsString := cdsItens.FieldByName('CLASSE').AsString
          Else
          Begin
            If blnModCub Then
              qryUpd.ParamByName('MODCUB').AsString := cdsItens.FieldByName('MODCUB').AsString;
          End;

          qryUpd.ExecSQL;
        End
        Else
        If blnModCub Then
          pAtualizaAgeilo;

        cdsItens.Next;
      End;

      blnBloqueado   := False;
      strMsgBloqueio := '';
      If strMsgLocfis <> '' Then
      Begin
        blnBloqueado   := True;
        strMsgBloqueio := 'N'#227'o '#233' poss'#237'vel atualizar o plano de recebimento!' + #13#10 +
                          'N'#227'o '#233' permitido trocar a localiza'#231#227'o ou o tipo (picking/buffer)' +
                          ' de linhas j'#225' endere'#231'adas ou conferidas no coletor:' + strMsgLocfis;
      End
      Else If strMsgAgeIlo <> '' Then
      Begin
        blnBloqueado   := True;
        strMsgBloqueio := 'N'#227'o '#233' poss'#237'vel atualizar o plano de recebimento!' + #13#10 +
                          'As localiza'#231#245'es abaixo foram alteradas por outro processo durante a atualiza'#231#227'o.' + #13#10 +
                          'Recarregue o plano e tente novamente:' + strMsgAgeIlo;
      End
      Else If Not fRemontaAgeete(strMsgBloqueio) Then
        blnBloqueado := True
      Else If Not fValidaQtdConferidaAgeete(strMsgBloqueio) Then
        blnBloqueado := True;

      If blnBloqueado Then
      Begin
        fRollback;
        fMensagem('', strMsgBloqueio, ['&Ok']);
        Exit;
      End;

      If TRAVA_PLANO_RECEBIMENTO_SEM_SUGESTAO And blnModCub And fTemItemCubAutomaticaSemSugestao Then
      begin
        fRollback;
        pMostraItensCubAutomaticaSemSugestao;
        Exit;
      End
      Else
        fCommit;

      btnConfirma.Caption := '&Confirmar';
      fMensagem('', 'Plano de recebimento atualizado com sucesso!', ['&Ok']);
      blnAlterando := False;
      btnAlterar.Enabled := False;
    Except On
      E:Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmPlanoDeRecebimento.pAtualizarPlano]');
      End;
    End;
  Finally
    FreeAndNil(qryUpd);
    FreeAndNil(qryAgeIlo);
    FreeAndNil(qryAgeIloUpd);
    FreeAndNil(qryAux);
    FreeAndNil(cdsBackup);
    FreeAndNil(stlAgeIloPlano);
    FreeAndNil(stlAgeIloMantidas);
    pResetTela;
    cdsLocSug.AfterScroll := cdsSugestAfterScroll;
    cdsLocSug.EnableControls;
  End;
end;

procedure TfrmPlanoDeRecebimento.pBeforePost(DataSet : TDataSet);
Begin
  If (not fEmptyStr(DataSet.FieldByName('CLASSE').AsString)) then
  begin

    If (DataSet.FieldByName('QTDNOR').AsFloat = 0) Then
    begin
      If (DataSet.FieldByName('ITE_REAEND').AsString = 'S') Then
        fMensagem('', 'Não deve ser definida a Classe de Localização para produtos acabados!', ['&OK'])
      Else If (DataSet.FieldByName('ITE_REAEND').AsString = 'N') Then
        fMensagem('', 'Não deve ser definida a Classe de Localização para itens que não faz endereçamento! (ITE_REAEND)', ['&OK']);
      DataSet.FieldByName('CLASSE').AsString := '';
      exit;
    End
    Else if fEmptyStr( fCampoTabela('CLA_SIGLA_', 'CLASSE', ['CLA_SIGLA_', 'CLA_CODEMP'], [ DataSet.FieldByName('CLASSE').AsString, VS_strCodEmp] ) ) Then
    Begin
      fMensagem('', 'Classe de Localização não Cadastrada!', ['&OK']);
      DataSet.FieldByName('CLASSE').AsString := '';
      exit;
    End;
  end;

  if (DataSet.FieldByName('QTDNOR').AsFloat = 0) then
  begin
    if DataSet.FieldByName('QTDETI').AsFloat <> 0 Then
    Begin
      DataSet.FieldByName('QTDETI').AsFloat := 0;
      If (DataSet.FieldByName('ITE_REAEND').AsString = 'S') Then
        fMensagem('', 'A quantidade de etiquetas para produtos acabados deve ser 0!', ['&OK'])
      Else If (DataSet.FieldByName('ITE_REAEND').AsString = 'N') Then
        fMensagem('', 'A quantidade de etiqueta para produto que não faz endereçamento deve ser 0! (ITE_REAEND)', ['&OK']);
    End;

  end
  else if (DataSet.FieldByName('QTDETI').AsFloat < 1) And (DataSet.FieldByName('QTDETI').AsFloat <> 0) Then
  Begin
    DataSet.FieldByName('QTDETI').AsFloat := 1;
    fMensagem('', 'A Quantidade de Etiquetas não pode ser menor que 1!', ['&OK']);
  End;

End;

procedure TfrmPlanoDeRecebimento.pCancelarPlano(strDigIde: String);
Var
  qryAgeDoc,
  qryUpd : TUniQuery;
  strAutIncFatGor,
  strAutIncAgeRec,
  strDocEnd,
  strNumDoc,
  strSerDoc,
  strEspDoc,
  strCodEmp,
  strSeqGer,
  strCodFor,
  strMensagemDosItenSaldoNegativo: String;
  intContador: Integer;

  stlPedCom,
  stlPedComAux,
  stlCodItem: TStringList;
Begin
  stlPedCom := TStringList.Create;
  stlPedCom.Duplicates := dupIgnore;

  stlPedComAux := TStringList.Create;
  stlPedComAux.Duplicates := dupIgnore;

  stlCodItem := TStringList.Create;
  stlCodItem.Duplicates := dupIgnore;

  If fPossuiDevolucaoCompra Then
  Begin
    fMensagem('', 'Não é possível cancelar o plano de recebimento, pois existe devolução compra emitida!', ['&Ok']);
    Exit;
  End;

  If fPossuiEnderecamento(strDigIde) Then
  Begin
    fMensagem('', 'Não é possível cancelar o plano pois há itens com quantidade endereçada!', ['&Ok']);
    Exit;
  End;

  If (blnModCub And fPossuiEtiquetasIDEnderecadas) Then
  Begin
    fMensagem('', 'Não é possível cancelar o plano pois há etiquetas ID já endereçadas!', ['&Ok']);
    Exit;
  End;

  If Not fVerificaSeFicarSaldoNegativoItens(strDigIde, strMensagemDosItenSaldoNegativo) Then
  Begin
    pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
    Try
      frmMensagemExplicativa.Caption := 'Plano de Recebimento - Itens Saldo Negativos';
      frmMensagemExplicativa.Width   := 800;
      frmMensagemExplicativa.Height  := 550;
      frmMensagemExplicativa.RitchObservacao.Visible:= True;
      frmMensagemExplicativa.RitchObservacao.BringToFront;
      frmMensagemExplicativa.RitchObservacao.Font.Name := 'Courier New';
      frmMensagemExplicativa.RitchObservacao.Font.Size := 10;
      frmMensagemExplicativa.RitchObservacao.Lines.Text := strMensagemDosItenSaldoNegativo;

      frmMensagemExplicativa.ShowModal;
    Finally
      pFreeAndNil(frmMensagemExplicativa);
    End;
    Exit;
  End;

  //If chkAllPick.Checked Then
  //  chkAllPick.Checked := False;

  Try
    qryAgeDoc := fCriaQuery;
    qryUpd := fCriaQuery;

    qryAgeDoc.SQL.Clear;
    qryAgeDoc.SQL.Add(' SELECT                            ');
    qryAgeDoc.SQL.Add('   AGEREC.AUTOINCREM,              ');
    qryAgeDoc.SQL.Add('   ADC_NUMDOC,                     ');
    qryAgeDoc.SQL.Add('   ADC_ESPDOC,                     ');
    qryAgeDoc.SQL.Add('   ADC_SERIE_,                     ');
    qryAgeDoc.SQL.Add('   ADC_CODEMP,                     ');
    qryAgeDoc.SQL.Add('   ADC_CODFOR,                     ');
    qryAgeDoc.SQL.Add('   ADC_SEQGER                      ');
    qryAgeDoc.SQL.Add(' FROM                              ');
    qryAgeDoc.SQL.Add('   AGEREC                          ');
    qryAgeDoc.SQL.Add('INNER JOIN                         ');
    qryAgeDoc.SQL.Add('  AGEDOC ON                        ');
    qryAgeDoc.SQL.Add('    ADC_SEQGER = AGEREC.AUTOINCREM ');
    qryAgeDoc.SQL.Add(' WHERE ARC_IDEDIG = :IDEDIG        ');

    qryAgeDoc.ParamByName('IDEDIG').AsString := strDigIde;
    qryAgeDoc.Open;

    qryAgeDoc.First;
    fStartTransaction;
    While Not qryAgeDoc.Eof Do
    Begin
      strNumDoc := qryAgeDoc.FieldByName('ADC_NUMDOC').AsString;
      strSerDoc := qryAgeDoc.FieldByName('ADC_SERIE_').AsString;
      strEspDoc := qryAgeDoc.FieldByName('ADC_ESPDOC').AsString;
      strCodEmp := qryAgeDoc.FieldByName('ADC_CODEMP').AsString;
      strCodFor := qryAgeDoc.FieldByName('ADC_CODFOR').AsString;
      strSeqGer := qryAgeDoc.FieldByName('ADC_SEQGER').AsString;
      strAutIncAgeRec := qryAgeDoc.FieldByName('AUTOINCREM').AsString;

      qryUpd.SQL.Clear;
      qryUpd.SQL.Add(' SELECT                              ');
      qryUpd.SQL.Add('   FATGOR.AUTOINCREM                 ');
      qryUpd.SQL.Add(' FROM                                ');
      qryUpd.SQL.Add('   EXTGOR                            ');
      qryUpd.SQL.Add(' INNER JOIN FATGOR                   ');
      qryUpd.SQL.Add('   ON FATGOR.AUTOINCREM = FGO_SEQFGO ');
      qryUpd.SQL.Add(' WHERE                               ');
      qryUpd.SQL.Add('       FGO_DOCEND = :DOCEND          ');
      qryUpd.SQL.Add('   AND FGO_CODEMP = :CODEMP          ');

      strDocEnd :=  fPadL(strNumDoc , fTamNumDoc)
                          + fPadR(strEspDoc , 02)
                          + fPadR(strSerDoc , 03)
                          + fPadR(strCodEmp , 03)
                          + fPadR(strCodFor , 08)
                          + fPadR('F' , 01);

      qryUpd.ParamByName('DOCEND').AsString  := strDocEnd;
      qryUpd.ParamByName('CODEMP').AsString  := strCodEmp;
      qryUpd.Open;

      strAutIncFatGor := qryUpd.FieldByName('AUTOINCREM').AsString;

      qryUpd.Close;
      qryUpd.SQL.Clear;

      qryUpd.SQL.Add(' SELECT * FROM MOVDET WHERE ');
      qryUpd.SQL.Add(' DET_NUMDOC = :NUMDOC                  ');
      qryUpd.SQL.Add(' AND DET_ESPDOC = :ESPDOC              ');
      qryUpd.SQL.Add(' AND DET_CODEMP = :CODEMP              ');
      qryUpd.SQL.Add(' AND DET_CODFOR = :CODFOR              ');
      qryUpd.SQL.Add(' AND DET_SERIE_ = :SERIE_              ');
      qryUpd.SQL.Add(' AND DET_DTAENT IS NOT NULL            ');
      qryUpd.SQL.Add(' AND DET_FILKAR = FALSE                ');

      qryUpd.ParamByName('NUMDOC').AsString := strNumDoc;
      qryUpd.ParamByName('ESPDOC').AsString := strEspDoc;
      qryUpd.ParamByName('CODEMP').AsString := strCodEmp;
      qryUpd.ParamByName('CODFOR').AsString := strCodFor;
      qryUpd.ParamByName('SERIE_').AsString := strSerDoc;

      qryUpd.Open;

      stlPedCom.Clear;
      stlPedComAux.Clear;

      If Not qryUpd.IsEmpty Then
      Begin
        qryUpd.First;
        While Not qryUpd.eof do
        Begin
          fAtualizaEstoque(qryUpd.FieldByName('DET_CODITE').AsString,
                                     qryUpd.FieldByName('DET_QTDITE').AsFloat,
                                     IIF(LeftStr(qryUpd.FieldByName('DET_CLAFIS').AsString, 1) >= '5', 'E','S'),
                                     qryUpd.FieldByName('DET_NUMLOT').AsString,
                                     strEspDoc,
                                     False);

          pEstornaPedidoCompra(qryUpd.FieldByName('AUTOINCREM').AsString,
                               strNumDoc, strEspDoc, strCodEmp, strCodFor, strSerDoc,
                               qryUpd.FieldByName('DET_PEDCOM').AsString, qryUpd.FieldByName('DET_EMPCOM').AsString,
                               qryUpd.FieldByName('DET_CODITE').AsString,
                               qryUpd.FieldByName('DET_QTDITE').AsFloat,
                               stlPedCom, stlPedComAux);

          stlCodItem.Add(qryUpd.FieldByName('DET_CODITE').AsString);
          qryUpd.Next;
        End;
      End;

      qryUpd.Close;
      qryUpd.SQL.Clear;

      qryUpd.SQL.Add(' UPDATE                     ');
      qryUpd.SQL.Add(' MOVGER SET                 ');
      qryUpd.SQL.Add('   GER_DTAENT = NULL,       ');
      qryUpd.SQL.Add('   GER_HORENT = NULL        ');
      qryUpd.SQL.Add(' WHERE GER_NUMDOC = :NUMDOC ');
      qryUpd.SQL.Add('   AND GER_ESPDOC = :ESPDOC ');
      qryUpd.SQL.Add('   AND GER_SERIE_ = :SERIE  ');
      qryUpd.SQL.Add('   AND GER_CODFOR = :CODFOR ');
      qryUpd.SQL.Add('   AND GER_CODEMP = :CODEMP;');

      qryUpd.SQL.Add(' UPDATE                     ');
      qryUpd.SQL.Add(' MOVDET SET                 ');
      qryUpd.SQL.Add('   DET_DTAENT = NULL,       ');
      qryUpd.SQL.Add('   DET_HORENT = NULL,       ');
      qryUpd.SQL.Add('   DET_FILKAR = "1"         ');
      qryUpd.SQL.Add(' WHERE DET_NUMDOC = :NUMDOC ');
      qryUpd.SQL.Add('   AND DET_ESPDOC = :ESPDOC ');
      qryUpd.SQL.Add('   AND DET_SERIE_ = :SERIE  ');
      qryUpd.SQL.Add('   AND DET_CODFOR = :CODFOR ');
      qryUpd.SQL.Add('   AND DET_CODEMP = :CODEMP;');

      qryUpd.ParamByName('NUMDOC').AsString := strNumDoc;
      qryUpd.ParamByName('ESPDOC').AsString := strEspDoc;
      qryUpd.ParamByName('SERIE').AsString  := strSerDoc;
      qryUpd.ParamByName('CODFOR').AsString := strCodFor;
      qryUpd.ParamByName('CODEMP').AsString := strCodEmp;

      If Not fEmptyStr(strAutIncFatGor) Then
      Begin
        qryUpd.SQL.Add(' DELETE                       ');
        qryUpd.SQL.Add('   FROM FATDOR                ');
        qryUpd.SQL.Add(' WHERE FDO_SEQGER = :AUNTINC; ');

        qryUpd.SQL.Add(' DELETE                       ');
        qryUpd.SQL.Add('   FROM FATGOR                ');
        qryUpd.SQL.Add(' WHERE AUTOINCREM = :AUTINC;  ');

        qryUpd.SQL.Add(' DELETE                       ');
        qryUpd.SQL.Add('  FROM EXTGOR                 ');
        qryUpd.SQL.Add(' WHERE FGO_SEQFGO = :AUTINC;  ');

        qryUpd.SQL.Add(' DELETE                       ');
        qryUpd.SQL.Add('  FROM EXTDOR                 ');
        qryUpd.SQL.Add(' WHERE FDO_SEQFDO = :AUTINC;  ');

        qryUpd.ParamByName('AUTINC').AsString  := strAutIncFatGor;
      End;

      qryUpd.ExecSQL;
      qryAgeDoc.Next;
    End;

    qryUpd.SQL.Clear;
    qryUpd.SQL.Add(' UPDATE                      ');
    qryUpd.SQL.Add(' AGEREC SET                  ');
    If fConferenciaAntesDoPlanoDeRecebimento Then
      qryUpd.SQL.Add('   ARC_STATUS = "CN",        ')
    Else
      qryUpd.SQL.Add('   ARC_STATUS = "EC",        ');
    qryUpd.SQL.Add('   ARC_MOVEFE = "N",         ');
    qryUpd.SQL.Add('   ARC_PARCAN = "N"          ');
    qryUpd.SQL.Add(' WHERE ARC_IDEDIG = :DIGIDE  ');
    qryUpd.SQL.Add('   AND ARC_CODEMP = :CODEMP; ');

    If (Not fConferenciaAntesDoPlanoDeRecebimento) Then
    Begin
      qryUpd.SQL.Add('UPDATE GERELE SET          ');
      qryUpd.SQL.Add('  GER_DTACON = NULL,       ');
      qryUpd.SQL.Add('  GER_HORCON = NULL,       ');
      qryUpd.SQL.Add('  GER_OPECON = NULL,       ');
      qryUpd.SQL.Add('  GER_IDEDIG = NULL        ');
      qryUpd.SQL.Add('WHERE GER_CODEMP = :CODEMP ');
      qryUpd.SQL.Add('  AND GER_IDEDIG = :DIGIDE;');
    End;

    qryUpd.ParamByName('DIGIDE').AsString := strDigIde;
    qryUpd.ParamByName('CODEMP').AsString := strCodEmp;

    If Not fEmptyStr(strAutIncAgeRec) Then
    Begin
      qryUpd.SQL.Add(' DELETE                       ');
      qryUpd.SQL.Add('  FROM AGEITE                 ');
      qryUpd.SQL.Add(' WHERE AIT_SEQGER = :AUTINCAGEREC;  ');

      qryUpd.ParamByName('AUTINCAGEREC').AsString  := strAutIncAgeRec;
    End;

    If blnModCub Then
    Begin
      qryUpd.SQL.Add(' DELETE                               ');
      qryUpd.SQL.Add('  FROM ETIRIT                         ');
      qryUpd.SQL.Add(' WHERE ETI_ETIREC IN                  ');
      qryUpd.SQL.Add('  (SELECT AUTOINCREM FROM             ');
      qryUpd.SQL.Add('   ETIREC WHERE ETI_CODREC = :CODREC);');

      qryUpd.SQL.Add(' DELETE                      ');
      qryUpd.SQL.Add('  FROM ETIREC                ');
      qryUpd.SQL.Add(' WHERE ETI_CODREC = :CODREC  ');

      qryUpd.ParamByName('CODREC').AsString := strAutIncAgeRec;
    End;
    qryUpd.ExecSQL;

    For intContador := 0 To stlCodItem.Count -1 Do
      ReprocessarItem(stlCodItem[intContador], strCodEmp);

    fCommit;
    btnAlterar.Enabled := False;
    btnCancela.Enabled := False;

    If (blnModCub) And (qryEtique.Active) Then
      qryEtique.Refresh;

    fMensagem('', 'Plano de recebimento cancelado com sucesso!', ['&Ok']);

  Except On
    E:Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmPlanoDeRecebimento.pCancelarPlano]');
    End;

  End;

  pResetTela;

  FreeAndNil(qryAgeDoc);
  FreeAndNil(qryUpd);
  If Assigned(stlPedCom) Then FreeAndNil(stlPedCom);
  If Assigned(stlPedComAux) Then FreeAndNil(stlPedComAux);
  If Assigned(stlCodItem) Then FreeAndNil(stlCodItem);
end;

procedure TfrmPlanoDeRecebimento.pCarregaDefinicoesCubagem(var qtdCubagemManual,
  qtdCubagemAutomatica, qtdSemCubagem, qtdTotalReg, qtdRegComPiking: integer;
  blnFiltraSugestaoPiking: Boolean);
begin
  FqryConsulta.SQL.Clear;
  FqryConsulta.SQL.Add('SELECT SUM(IF(AIT_MODCUB ="M", 1, 0))  QTD_MODCUB_MANUAL,');
  FqryConsulta.SQL.Add('       SUM(IF(AIT_MODCUB ="A", 1, 0))  QTD_MODCUB_AUTOMATICA,');
  FqryConsulta.SQL.Add('       SUM(IF(IFNULL(AIT_MODCUB, "") ="", 1, 0))  QTD_MODCUB_INDEFINIDA,');
  FqryConsulta.SQL.Add('       SUM(IF(IFNULL(AIT_MODCUB, "") <>"", 1, 0))  QTD_MODCUB_PREENCHIDA,');
  FqryConsulta.SQL.Add('       SUM(IF(IFNULL(AIT_QTDPIK, 0) >0, 1, 0))  QTD_REC_COM_PIKING,');
  FqryConsulta.SQL.Add('       SUM(1) AS QTDREG');
  FqryConsulta.SQL.Add('');
  FqryConsulta.SQL.Add('FROM AGEREC R');
  FqryConsulta.SQL.Add('LEFT JOIN AGEITE E ON E.AIT_SEQGER = R.AUTOINCREM');
  FqryConsulta.SQL.Add('  WHERE ARC_CODEMP = :CODEMP');
  FqryConsulta.SQL.Add('  AND ARC_IDEDIG = :IDEDIG');
  If blnFiltraSugestaoPiking Then
    FqryConsulta.SQL.Add('  AND AIT_QTDTOT - AIT_QTDPIK > 0');

  FqryConsulta.ParamByName('IDEDIG').AsString := strIdeDig;
  FqryConsulta.ParamByName('CODEMP').AsString := VS_StrCodEmp;

  FqryConsulta.Open;

  qtdCubagemManual := FqryConsulta.FieldByName('QTD_MODCUB_MANUAL').AsInteger;
  qtdCubagemAutomatica := FqryConsulta.FieldByName('QTD_MODCUB_AUTOMATICA').AsInteger;
  qtdSemCubagem := FqryConsulta.FieldByName('QTD_MODCUB_INDEFINIDA').AsInteger;
  qtdTotalReg := FqryConsulta.FieldByName('QTDREG').AsInteger;
  qtdRegComPiking := FqryConsulta.FieldByName('QTD_REC_COM_PIKING').AsInteger;
end;

procedure TfrmPlanoDeRecebimento.pOnDataChangeClasse(Field: TField);
  Var
    intCxCama,
    intQtCama,
    intQtdTot,
    intQtdEti : Integer;
begin
  If Not cdsItens.Active or cdsItens.IsEmpty or (cdsItens.FieldByName('QTDNOR').AsFloat = 0) then
    Exit;

  pGetQtdeMaxPallet(cdsItens.FieldByName('CODITE').AsString, cdsItens.FieldByName('CLASSE').AsString, intCxCama, intQtCama, intQtdTot);

  cdsItens.FieldByName('CXCAMA').AsInteger := intCxCama;
  cdsItens.FieldByName('QTCAMA').AsInteger := intQtCama;
  cdsItens.FieldByName('QTDTOT').AsInteger := intQtdTot;

  If (intQtdTot = 0) And (cdsItens.FieldByName('QTDETI').AsInteger = 0) Then
    cdsItens.FieldByName('QTDETI').AsInteger := 1
  Else If (intQtdTot > 0) Then
  Begin
    intQtdEti := Trunc(cdsItens.FieldByName('QTDITE').AsFloat / intQtdTot);
    If Frac(cdsItens.FieldByName('QTDITE').AsFloat / intQtdTot) > 0 Then
      Inc(intQtdEti);

    cdsItens.FieldByName('QTDETI').AsInteger := intQtdEti;
  End;
end;

procedure TfrmPlanoDeRecebimento.pPopularComboBoxClasses(strCodIte: String);
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;

  TcxComboBoxProperties(cxgItensTableViewCLASSE.Properties).Items.Clear;

  Try
    With qryAux, SQL Do
    Begin
      Clear;
      Add('  SELECT                      ');
      Add('     CIT_SIGLA_               ');
      Add('  FROM                        ');
      Add('    CLAITE                    ');
      Add('  WHERE CIT_CODITE = :CODITE  ');
      Add('    AND CIT_CODEMP = :CODEMP  ');

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;


      // Se o item não tiver classes cadastradas, libera para usuário poder digitar '/' no combobox
      // através do estilo lsEditList, caso contrário trava com lsFixedEditList
      If qryAux.isEmpty Then
        TcxComboBoxProperties(cxgItensTableViewCLASSE.Properties).DropDownListStyle := lsEditList
      Else
        TcxComboBoxProperties(cxgItensTableViewCLASSE.Properties).DropDownListStyle := lsEditFixedList;

      While Not qryAux.Eof Do
      Begin
        TcxComboBoxProperties(cxgItensTableViewCLASSE.Properties).Items.Add(FieldByName('CIT_SIGLA_').AsString);
        Next;
      End;
     End;

    Finally
      FreeAndNil(qryAux);
  End;

end;

function TfrmPlanoDeRecebimento.fQtdeEtiquetas:Boolean;
Begin
  Result := True;

  if blnSugereLocalizacao Then
    Exit;

  Try
    blnTemImpressao := False;
    cdsItens.DisableControls;
    cdsItens.First;

    While not cdsItens.Eof Do
    Begin
      If (cdsItens.FieldByName('ITE_REAEND').AsString = 'S') Then
      Begin
        blnTemImpressao := True;
        Break;
      End;
      cdsItens.Next;
    End;

    While not cdsItens.Eof Do
    Begin
      If ((cdsItens.FieldByName('QTDNOR').AsFloat <> 0) and (cdsItens.FieldByName('QTDETI').AsFloat < 1) ) Then
      Begin
        If (cdsItens.FieldByName('ITE_REAEND').AsString = 'S') Then
        Begin
          Result := False;
          Break;
        end
      End;
      cdsItens.Next;
    End;

    If (Not Result) Then
      fMensagem('', 'A Quantidade Mínima de Etiquetas Deve Ser 1!', ['&Ok'])

  Finally
    cdsItens.First;
    cdsItens.EnableControls;
  End;
End;

function TfrmPlanoDeRecebimento.fQtdItensDistintosEtiquetaID(
  AStrID: String): Integer;
var
  qryCons: TUniQuery;
begin
  Try
    qryCons := fCriaQuery;
    qryCons.SQL.Add(' SELECT                                        ');
    qryCons.SQL.Add('   DISTINCT ETI_CODITE                         ');
    qryCons.SQL.Add(' FROM                                          ');
    qryCons.SQL.Add('   ETIRIT                                      ');
    qryCons.SQL.Add('   INNER JOIN ETIREC                           ');
    qryCons.SQL.Add('     ON ETIREC.AUTOINCREM = ETI_ETIREC         ');
    qryCons.SQL.Add('   INNER JOIN AGEREC                           ');
    qryCons.SQL.Add('     ON ETIREC.ETI_CODREC = AGEREC.AUTOINCREM  ');
    qryCons.SQL.Add('   INNER JOIN AGEITE                           ');
    qryCons.SQL.Add('     ON AIT_CODITE = ETI_CODITE                ');
    qryCons.SQL.Add(' WHERE ARC_IDEDIG = :IDEDIG                    ');
    qryCons.SQL.Add('   AND ETI_ETIID_ = :ETI_ID                    ');
    qryCons.SQL.Add('   AND AIT_MODCUB = "M"                        ');
    qryCons.ParamByName('IDEDIG').AsString := strIdeDig;
    qryCons.ParamByName('ETI_ID').AsString := AStrID;

    qryCons.Open;

    Result := qryCons.RecordCount;
  Finally
    FreeAndNil(qryCons);
  End;
end;

function TfrmPlanoDeRecebimento.fQuantidadePickin(strCodIte: String = ''; saiAoEncontrar: Boolean = false; blnRemoveFilter: Boolean = False): Double;
var
  strFilter: String;
  blnFilter: Boolean;
  intRecNo: Integer;
begin
  Result := 0;
  intRecNo := cdsItens.RecNo;
  strFilter:= cdsLocSug.Filter;
  blnFilter:= cdsLocSug.filtered;
  Try
    If strCodIte <> '' Then
    Begin
      cdsLocSug.filtered := False;
      cdsLocSug.Filter := 'CODITE = ' + QuotedStr(strCodIte);
      cdsLocSug.filtered := True;
    End;

    If blnRemoveFilter Then
      cdsLocSug.filtered := False;

    cdsLocSug.First;

    while not cdsLocSug.Eof do
    Begin
      If (cdsLocSug.FieldByName('ABPICK').AsString = 'S') And
         (cdsLocSug.FieldByName('SELECE').AsBoolean) Then
        Result := Result + cdsLocSug.FieldByName('QTDVEN').AsFloat;

      If saiAoEncontrar and (Result > 0) Then
        Exit(Result);
      cdsLocSug.Next;
    End;
  Finally
    cdsLocSug.filtered := False;
    cdsLocSug.Filter := strFilter;
    cdsLocSug.filtered := blnFilter;
    cdsItens.RecNo := intRecNo;
  End;
end;

function TfrmPlanoDeRecebimento.fVerificaItensConfiguradosPalets(strSeq: String; var strErro: string): Boolean;
  var
    qryConsulta: TUniQuery;
begin
  strErro := '';
  qryConsulta := fCriaQuery;
  Try
     qryConsulta.SQL.Add('SELECT CONCAT(MOVDET.DET_CODITE, " - ",ITE_DESITE) AS ITEM');
     qryConsulta.SQL.Add('  FROM MOVGER');
     qryConsulta.SQL.Add(' INNER JOIN MOVDET ON DET_SEQGER = MOVGER.AUTOINCREM');
     qryConsulta.SQL.Add(' INNER JOIN CADITE ON ITE_CODITE = DET_CODITE');
     qryConsulta.SQL.Add(' INNER JOIN CADFOR ON FOR_CODFOR = GER_CODFOR');
     qryConsulta.SQL.Add('  LEFT JOIN ITEPAL ON PAL_CODITE = DET_CODITE AND PAL_CODFOR = GER_CODFOR');
     qryConsulta.SQL.Add(' INNER JOIN AGEDOC ON GER_NUMDOC = ADC_NUMDOC');
     qryConsulta.SQL.Add('                         AND GER_ESPDOC = ADC_ESPDOC ');
     qryConsulta.SQL.Add('                         AND GER_SERIE_ = ADC_SERIE_');
     qryConsulta.SQL.Add('                         AND GER_CODFOR = ADC_CODFOR');
     qryConsulta.SQL.Add('                         AND GER_CODEMP = ADC_CODEMP');
     qryConsulta.SQL.Add(' WHERE GER_DTAENT IS NULL    ');
     qryConsulta.SQL.Add('   AND ITEPAL.AUTOINCREM IS NULL');
     qryConsulta.SQL.Add('   AND FOR_PALREC = "S" ');
     qryConsulta.SQL.Add('   AND ADC_SEQGER = "'+strSeq+'"');
     qryConsulta.Open;
     strErro := '';
     Result := qryConsulta.IsEmpty;
     While not qryConsulta.Eof do
     Begin
       strErro := strErro + qryConsulta.FieldByName('ITEM').AsString + #$A#$D;
       qryConsulta.Next;
     End;
  Finally
    FreeAndNil(qryConsulta);
  End;
End;

function TfrmPlanoDeRecebimento.fVerificaSeFicarSaldoNegativoItens(
  AstrDigIde: String; out strMensagemItensSaldoNegativo: String): Boolean;
var
  qryAux: TUniQuery;
  fltSaldoFisicoItem,
  fltSaldoFisicoRestante: Double;
  strMensagem: String;
begin
  Result := True;
  qryAux := fCriaQuery;

  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT ');
    qryAux.SQL.Add('   DET_CODITE, ');
    qryAux.SQL.Add('   DET_QTDITE, ');
    qryAux.SQL.Add('   DET_CODEMP, ');
    qryAux.SQL.Add('   IFNULL(DET_NUMLOT, "") AS DET_NUMLOT ');
    qryAux.SQL.Add(' FROM AGEREC ');
    qryAux.SQL.Add('  INNER JOIN AGEDOC ON ADC_SEQGER = AGEREC.AUTOINCREM ');
    qryAux.SQL.Add('  INNER JOIN MOVGER ON ADC_NUMDOC = GER_NUMDOC AND ADC_ESPDOC = GER_ESPDOC AND ADC_CODEMP = GER_CODEMP AND ADC_CODFOR = GER_CODFOR AND ADC_SERIE_ = GER_SERIE_ ');
    qryAux.SQL.Add('  INNER JOIN MOVDET ON MOVGER.AUTOINCREM = MOVDET.DET_SEQGER ');
    qryAux.SQL.Add(' WHERE TRUE ');
    qryAux.SQL.Add('   AND ARC_IDEDIG = :IDEDIG ');
    qryAux.SQL.Add('   AND ARC_CODEMP = :CODEMP ');

    qryAux.ParamByName('IDEDIG').AsString := AstrDigIde;
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryAux.Open;

    If qryAux.IsEmpty Then
      Exit
    Else
    Begin
      strMensagem := '';
      qryAux.First;
      While (Not qryAux.Eof) Do
      Begin
        fltSaldoFisicoItem := fRetSaldosEmpresa(qryAux.FieldByName('DET_CODITE').AsString, // strCodIte,
                                                qryAux.FieldByName('DET_CODEMP').AsString, //strCodEmp: String;
                                                qryAux.FieldByName('DET_NUMLOT').AsString, //strNumLot: String = '';
                                                False                                      //blnIgnorarLote: Boolean = False;
                                                );

        fltSaldoFisicoRestante := fltSaldoFisicoItem - qryAux.FieldByName('DET_QTDITE').AsFloat ;
        If fltSaldoFisicoRestante < 0 Then
        Begin
           strMensagem := strMensagem + Format('Item: %s   Lote: %s   Saldo Físico: %s   Quantidade: %s   Saldo Final: %s%s',
                                                [ qryAux.FieldByName('DET_CODITE').AsString,
                                                  qryAux.FieldByName('DET_NUMLOT').AsString,
                                                  FormatFloat('0.0000', fltSaldoFisicoItem),
                                                  FormatFloat('0.0000', qryAux.FieldByName('DET_QTDITE').AsFloat),
                                                  FormatFloat('0.0000', fltSaldoFisicoRestante),
                                                  sLineBreak ]);
        End;

        qryAux.Next;
      End;

      If Not fEmptyStr(strMensagem) Then
      Begin
        Result := False;
        strMensagemItensSaldoNegativo := 'O PLANO DE RECEBIMENTO COM SEQ. RECEBIMENTO: ' + strIdeDig + sLineBreak +
                                         'NÃO PODE SER CANCELADO, POIS OS ITENS ABAIXO FICARAM COM SALDO NEGATIVO.' + sLineBreak + sLineBreak +
                                         strMensagem;;
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmPlanoDeRecebimento.lblAtualizarSugestoesClick(Sender: TObject);
begin
  inherited;
  pAtualizarSugestoes;
end;

procedure TfrmPlanoDeRecebimento.lblExpandirRecolherEtiquetasIDClick(
  Sender: TObject);
begin
  inherited;
  Case blnAgrupado Of
    True: Begin
            cxgEtiquetaTableView.ViewData.Expand(True);
            blnAgrupado := False;
          End;
   False: Begin
            cxgEtiquetaTableView.ViewData.Collapse(True);
            blnAgrupado := True;
          End;
  End;
end;

procedure TfrmPlanoDeRecebimento.msgAbreConsulta(var Msg: TMessage);
Var
  arrSel : TConsultasArray;
  Key : Char;
begin
  inherited;

  Key := '/';
  If fPesqClasseLocFis(Self, Nil, qryClasse, Key, arrSel) Then
  Begin
    cdsItens.Edit;
    cdsItens.FieldByName('CLASSE').AsString := qryClasse.FieldByName('CLA_SIGLA_').AsString;
    If blnClaPic Then
      fRetClasseCheiaOuVaiExceder;
    cdsItens.Post;
  End;

end;

procedure TfrmPlanoDeRecebimento.pGeraTotalPalet(strSeqGer: string);
begin
  qryTotalPalet.SQL.Clear;
  qryTotalPalet.SQL.Add('SELECT SUM(DET_QTDITE/PAL_QTDITE * PAL_VALPAL) AS TOTAL,');
  qryTotalPalet.SQL.Add('       FOR_CODCLI ,');
  qryTotalPalet.SQL.Add('       FOR_CODFOR, CADCND.CND_CODIGO AS CND_CODCND, CADCND.CND_CNDPAG, CLI_CODCID, CID_ESTADO');
  qryTotalPalet.SQL.Add('  FROM MOVGER');
  qryTotalPalet.SQL.Add(' INNER JOIN MOVDET ON DET_SEQGER = MOVGER.AUTOINCREM');
  qryTotalPalet.SQL.Add(' INNER JOIN CADITE ON ITE_CODITE = DET_CODITE');
  qryTotalPalet.SQL.Add(' INNER JOIN ITEPAL ON PAL_CODITE = DET_CODITE AND PAL_CODFOR = GER_CODFOR');
  qryTotalPalet.SQL.Add(' INNER JOIN CADFOR ON FOR_CODFOR = GER_CODFOR');
  qryTotalPalet.SQL.Add(' INNER JOIN CADCLI ON CLI_CODCLI = FOR_CODCLI');
  qryTotalPalet.SQL.Add(' INNER JOIN CADCID ON CID_CODCID = CLI_CODCID');
  qryTotalPalet.SQL.Add('  LEFT JOIN CLICND ON CND_CODCLI = CLI_CODCLI AND CND_SUGEST = "S"');
  qryTotalPalet.SQL.Add('  LEFT JOIN CADCND ON CND_CODIGO = CND_CODCND');
  qryTotalPalet.SQL.Add(' INNER JOIN AGEDOC ON GER_NUMDOC = ADC_NUMDOC');
  qryTotalPalet.SQL.Add('                         AND GER_ESPDOC = ADC_ESPDOC');
  qryTotalPalet.SQL.Add('                         AND GER_SERIE_ = ADC_SERIE_');
  qryTotalPalet.SQL.Add('                         AND GER_CODFOR = ADC_CODFOR');
  qryTotalPalet.SQL.Add('                         AND GER_CODEMP = ADC_CODEMP');
  qryTotalPalet.SQL.Add('WHERE GER_DTAENT IS NULL');
  qryTotalPalet.SQL.Add('   AND FOR_PALREC = "S" ');
  qryTotalPalet.SQL.Add('AND ADC_SEQGER = "'+strSeqGer+'"');
  qryTotalPalet.SQL.Add('GROUP BY FOR_CODFOR');
  qryTotalPalet.Open;
end;

function TfrmPlanoDeRecebimento.fValidaClassedeLocalOuLocalizacaoFisica:Boolean;
  Var
    intRecNo : Integer;
    blnAMais : boolean;
    blnFilterOriginal: Boolean;
Begin
  Result := True;
  blnFilterOriginal := cdsLocSug.Filtered;
  
  If Assigned(cdsLocSug.AfterScroll) Then
    cdsLocSug.AfterScroll := Nil;
  
  Try
    If blnSugereLocalizacao Then
    Begin
      Try
        cdsItens.DisableControls;
        cdsLocSug.DisableControls;
        cdsItens.First;
        While not cdsItens.Eof Do
          Begin
            If cdsItens.FieldByName('QTDCON').AsFloat = 0 Then
            Begin
              cdsItens.Next;
              Continue;
            End;

            cdsLocSug.First;
            While Not cdsLocSug.Eof Do
            Begin
              If fEmptyStr(cdsLocSug.FieldByName('LOCFIS').AsString) Then
              Begin
                pMensagemOK('É necessário informar todas as localizações, confira as localizações antes de finalizar!');
                Exit(False);
              End;
              cdsLocSug.Next;
            End;

            cdsItens.Next;
          End;
        cdsItens.First;
      Finally
        cdsItens.EnableControls;
        cdsLocSug.EnableControls;
      End;

    End;

    intRecNo := cdsItens.RecNo;
    cdsItens.DisableControls;
    Try
      blnAMais := False;


      cdsItens.First;
      While not cdsItens.Eof Do
      Begin
        If (not blnSugereLocalizacao) and (cdsItens.FieldByName('NUMLOT').AsString = 'A DEFINIR') and (cdsItens.FieldByName('QTDNOR').AsFloat <> 0) and  fEmptyStr(cdsItens.FieldByName('CLASSE').AsString) Then
        Begin
          Result := False;
          Break;
        End
        Else if (not blnAMais) Then
        Begin
          blnAMais := cdsItens.FieldByName('CONFER').AsString = 'MAIS';
        End;

        cdsItens.Next;
      End;


      If (not blnSugereLocalizacao) and (Not Result) Then
        fMensagem('', 'Informe Todas as Classes de Local para Continuar', ['&Ok'])
      else if blnAMais then
        Result := fMensagem('', 'Existem itens com a quantidade conferida maior que a quantidade total dos documentos agendados. O endereçamento irá considerar apenas a quantidade dos documentos, deseja continuar?',['&Sim', '&Não']) = 1 ;

    Finally
      cdsItens.RecNo := intRecNo;
      cdsItens.EnableControls;
    End;
  Finally
     cdsLocSug.Filtered := blnFilterOriginal;
  End;

End;

procedure TfrmPlanoDeRecebimento.pResetTela;
Begin
  cdsItens.Close;
  cdsLocSug.EmptyDataSet;
  edtDtaRec.Clear;
  edtNomMot.Clear;
  edtCodOpe.Clear;
  edtNomOpe.Clear;
  edtPlaca_.Clear;
  edtIdeDig.Clear;
  edtConferido.Clear;
  btnConfirma.Caption := '&Confirmar';
  btnAlterar.Enabled := False;
  btnCancela.Enabled := False;
  btnConfirma.Enabled  := False;
  btnDesmembra.Enabled := False;
  btnImprimir.Enabled := False;

  blnTodasModCubPreenchidas := False;
  blnTemCubagemAutomatica := False;
  blnTemCubagemManual := False;
  blnPlanoJaConfirmado := False;
  blnAgrupado := True;

  FBlnReabrindoPlanoPelaConfirmacao := False;

  strIdeDigBkp := '';

  btnImprimirMaisEtiqID.Enabled := False;

  chkRepModCubTodos.Checked := False;

  pnlEtiquetasID.Visible := False;
  sptSplitter.Visible := False;

  pnlBotoesEtiquetas.Visible := False;

  pHabilitarBotoes(False);

  pnlPlanoJaFinalizado.Visible := False;

  pnlLegendas.Visible := True;

  pSetFocus(edtPlaca_);

  objLock.pDestravarTodos;

  pnlGridSuperior.Visible := True;
  pnlEtiquetasID.Visible := False;
  pnlBotoesEtiquetas.Visible := False;
  sptSplitter.Visible := False;
  pnlCtrlModCub.Visible := blnModCub;
  pnlLegendaConferencia.Visible := True;
  pnlLegendas.Height := pnlCtrlModCub.Height + pnlLegendaConferencia.Height;

  blnAlterando := False;

  shpClaPic.Visible := False;
  lblClaPic.Visible := shpClaPic.Visible;
  shpPicExc.Visible := shpClaPic.Visible;
  lblPicExc.Visible := shpClaPic.Visible;
End;
function TfrmPlanoDeRecebimento.fEfetivaMovFiscal(cxProgressBar : TcxProgressBar) : Boolean;
  Var
    qryDocume : TUniQuery;
    strErro: String;
Begin
  Result := True;
  Try
    Try
      qryDocume := fCriaQuery();
      qryDocume.SQL.Add('SELECT                                         ');
      qryDocume.SQL.Add('  AGEDOC.*,                                    ');
      qryDocume.SQL.Add('  MOVGER.AUTOINCREM AS SEQGER                  ');
      qryDocume.SQL.Add('FROM                                           ');
      qryDocume.SQL.Add('  AGEDOC                                       ');
      qryDocume.SQL.Add('  INNER JOIN MOVGER ON GER_NUMDOC = ADC_NUMDOC ');
      qryDocume.SQL.Add('                   AND GER_ESPDOC = ADC_ESPDOC ');
      qryDocume.SQL.Add('                   AND GER_SERIE_ = ADC_SERIE_ ');
      qryDocume.SQL.Add('                   AND GER_CODFOR = ADC_CODFOR ');
      qryDocume.SQL.Add('                   AND GER_CODEMP = ADC_CODEMP ');
      qryDocume.SQL.Add('WHERE ADC_SEQGER = :AUTINC                     ');
      qryDocume.SQL.Add('  AND GER_DTAENT IS NULL                       ');

      qryDocume.ParamByName('AUTINC').AsString := cdsItens.FieldByName('AUTINC').AsString;
      qryDocume.Open;
      If chkGerCob.Checked Then
      Begin
        If not fVerificaItensConfiguradosPalets(cdsItens.FieldByName('AUTINC').AsString, strItensSemPaletsCadastrado) Then
        Begin
          Result := False;
          Exit;
        End
        Else
          pGeraTotalPalet(cdsItens.FieldByName('AUTINC').AsString);
      End;

      cxProgressBar.pSetMax(qryDocume.RecordCount);

      While (not qryDocume.Eof)  Do
      Begin
        TEfetivaMovimentoFiscal.pEfetiva(qryDocume.FieldByName('ADC_NUMDOC').AsString,
                                         qryDocume.FieldByName('ADC_ESPDOC').AsString,
                                         qryDocume.FieldByName('ADC_SERIE_').AsString,
                                         qryDocume.FieldByName('ADC_CODFOR').AsString,
                                         qryDocume.FieldByName('ADC_CODEMP').AsString,
                                         0,0,0,0,
                                         False); // CONTROLA A TRANSAÇÃO AKI PARA TODOS DOCUMENTOS, NAO PODE ATIVAR APENAS 1 CASO OCORRA ALGUM ERRO!}
        qryDocume.Next;
        cxProgressBar.pStep;
        Application.ProcessMessages;
      End;
      IF chkGerCob.Checked And (Not qryTotalPalet.IsEmpty) Then
        If Not fGeraCobrancaDePalett(strErro) Then
          raise Exception.Create('Falha ao cobrança de descarregamento de pallets. ' + strErro);

      qryDocume.Close;
      qryDocume.SQL.Clear;
      qryDocume.SQL.Add(' UPDATE AGEREC SET ARC_MOVEFE = "S", ARC_STATUS = "EP", ARC_PARCAN = "N" ');
      qryDocume.SQL.Add(' WHERE AUTOINCREM = :AUTINC         ');
      qryDocume.ParamByName('AUTINC').AsString := cdsItens.FieldByName('AUTINC').AsString;
      qryDocume.ExecSQL;

    Except
      On E : Exception Do
      Begin
        fRollBack;
        Result := False;
        pMensagensErro(E.Message, 'TfrmPlanoDeRecebimento.fEfetivaMovFiscal');
      End;
    End;
  Finally
    FreeAndNil(qryDocume);
  End;

End;

function TfrmPlanoDeRecebimento.fCalculaSugestaoLocalizacaoFisicas(cxProgressBar : TcxProgressBar) : Boolean;
  Var
    qryAgeIlo : TUniQuery;
    fltQtdIte : Real;
    fltQtdIteVal : Real;
    fltQtdASugerir: Real;
    blnAgeIloVazia: Boolean;
    strChavesUsadas: String;
    strItensProcessados: String;
    blnJaSugeriuBanco: Boolean;
    dtaVal: TDateTime;
    blnExistemBuffers: Boolean;

    procedure pMontaSugestaoBanco(strCodIte, strLocOri, strLotOri: String;fltQtdIte : Double; dtaVal: TDateTime; blnJaPriorizouPicking: Boolean = False);
    var
      fltQtdMovimentarPck: Double;
      strDigValFilterBkp: String;
      blnDigValFilteredBkp: Boolean;
      fltDigQtdTotal: Double;
      fltQtdInsert: Double;
      fltQtdMov: Double;
      fltQtdTotalMov: double;
      blnFinalizaDistribuicao: Boolean;
    begin
      If Assigned(frmGravando) Then
      Begin
        frmGravando.lblGravando.Caption := IIF(blnJaPriorizouPicking, 'Calculando quantidade restante ...', 'Sugerindo localizações físicas ...');
        Application.ProcessMessages;
      End;

      FQryConsulta := fCriaQuery;

      // Limpa 'lixo' da PRE_RESSUPRIMENTO
      FQryConsulta.SQL.Clear;
      FQryConsulta.SQL.Add('DELETE FROM PRE_RESSUPRIMENTO WHERE LOC_CODITE = :CODITE  AND IDSESSAO = CONNECTION_ID()');
      FQryConsulta.Params[0].AsString := strCodIte;
      FQryConsulta.ExecSQL;

      // Roda procedure para trazer localizações físicas para o item e sua qtd
      FQryConsulta.Close;
      FQryConsulta.SQL.Clear;
      FQryConsulta.SQL.Add('CALL PGERAMAPADISTANCIALOCALIZACAOFISICA(:CODITE, :CODEMP, :QTDITE, :LOCORI, :LOTORI, :PRIPIK, "")');
      FQryConsulta.Params[0].AsString := strCodite;
      FQryConsulta.Params[1].AsString := VS_strCodEmp;
      FQryConsulta.Params[2].AsFloat  := fltQtdIte;
      fltQtdTotalMov :=  fltQtdIte;
      FQryConsulta.Params[3].AsString := strLocOri;
      FQryConsulta.Params[4].AsString := strLotOri;

      If fCfgSis('MODCUB', varString) = '1' Then
      Begin
        FQryConsulta.Params[5].AsString := IIF(blnPriPik, '2', '3');
      End
      Else
      Begin
        if (cdsItens.FieldByName('MOVEFE').AsString = 'N') and blnCarregandoPlano Then
          FQryConsulta.Params[5].AsString := IIF(blnPriPik, '1', '3')
        Else If (cdsItens.FieldByName('MOVEFE').AsString = 'N') Or ((cdsItens.FieldByName('MOVEFE').AsString = 'S') And (fQuantidadePickin(strCodite) = 0)) Then
          FQryConsulta.Params[5].AsString := IIF(blnPriPik, '2', '3')
        Else
          FQryConsulta.Params[5].AsString := '3';
      End;
      FQryConsulta.ExecSQL;

      If not blnvalidouSeConverte Then
      begin
        blnValidaSeConverte := fCampoExiste('PRE_RESSUPRIMENTO','TIPO_CALC');
        blnvalidouSeConverte := True;
      End;

      // Tenta filtro de apenas localizações excesso
      FQryConsulta.Close;
      FQryConsulta.SQL.Clear;
      FQryConsulta.SQL.Add('SELECT                            ');

      If blnValidaSeConverte  then
        FQryConsulta.SQL.Add(' IF(IFNULL(TIPO_CALC, "") = "UN", QUANTIDADE_MOVIMENTA * :EMBALA, (QUANTIDADE_MOVIMENTA/fRetM3ProdutoSaldoEmbalagemFechadaCompra(:CODITE, :CODEMP, -999))  * :EMBALA)  AS QTDMOV, ')
      Else
        FQryConsulta.SQL.Add(' (QUANTIDADE_MOVIMENTA/fRetM3ProdutoSaldoEmbalagemFechadaCompra(:CODITE, :CODEMP, -999))  * :EMBALA  AS QTDMOV, ');
      FQryConsulta.SQL.Add(' PRE_RESSUPRIMENTO.*  ');
      FQryConsulta.SQL.Add('FROM                  ');
      FQryConsulta.SQL.Add(' PRE_RESSUPRIMENTO    ');
      FQryConsulta.SQL.Add('WHERE                 ');
      FQryConsulta.SQL.Add(' LOC_CODITE = :CODITE ');
      FQryConsulta.SQL.Add(' AND IDSESSAO = (SELECT CONNECTION_ID())');
      FQryConsulta.ParambyName('CODITE').AsString := strCodIte;
      FQryConsulta.ParambyName('CODEMP').AsString := VS_strCodEmp;

      FQryConsulta.ParambyName('EMBALA').AsFloat := StrToFloatDef(fCampoTabela('BAR_EMBALA', 'ITEBAR', ['BAR_CODITE', 'BAR_COMPRA'], [strCodIte, '1']), 1);
      FQryConsulta.Open;

      FQryConsulta.First;
      While not FQryConsulta.Eof Do
      Begin
        If FQryConsulta.FieldByName('QTDMOV').AsFloat = 0 Then
        begin
          FQryConsulta.Next;
          Continue;
        End;

        cdsLocSug.Insert;
        cdsLocSug.FieldByName('LOCTIPO').AsString  := IIF(cdsLocSug.FieldByName('EXCESS').AsBoolean, 'Excesso', 'Buffer');
        cdsLocSug.FieldByName('CHAVE').AsString    := cdsItens.FieldByName('CHAVE').AsString;
        cdsLocSug.FieldByName('LOCFIS').AsString   := FQryConsulta.FieldByName('LOC_LOCDES').AsString;
        cdsLocSug.FieldByName('DTAVAL').AsDateTime := dtaVal;
        cdsLocSug.FieldByName('EXCESS').AsBoolean  := FQryConsulta.FieldByName('PIC_PICKIN').AsString = 'E';
        cdsLocSug.FieldByName('QTDITE').AsFloat    := FQryConsulta.FieldByName('QTDMOV').AsFloat / cdsItens.FieldByName('EMBALA').AsFloat;
        cdsLocSug.FieldByName('QTDVEN').AsFloat    := FQryConsulta.FieldByName('QTDMOV').AsFloat;
        cdsLocSug.FieldByName('ENDERE').AsString   := 'N';
        cdsLocSug.FieldByName('SELECE').AsBoolean  := IIF(cdsLocSug.FieldByName('EXCESS').AsBoolean, False, True);
        If (cdsLocSug.FieldByName('EXCESS').AsBoolean) And (FQryConsulta.RecNo = 1) Then    //Seleciona primeira localização de excesso trazida pela procedure
          cdsLocSug.FieldByName('SELECE').AsBoolean  := True;

        cdsLocSug.FieldByName('BUFVEN').AsString   := 'N';

        cdsLocSug.FieldByName('CODITE').AsString   := strCodIte;
        cdsLocSug.FieldByName('DESITE').AsString   := cdsItens.FieldByName('DESITE').AsString;
        cdsLocSug.FieldByName('FISPIC').AsString   := FQryConsulta.FieldByName('PIC_CODLOC').AsString;
        cdsLocSug.FieldByName('EMBREC').AsFloat := cdsLocSug.FieldByName('QTDVEN').AsFloat / cdsLocSug.FieldByName('QTDITE').AsFloat;
        cdsLocSug.Post;

        If Not blnExistemBuffers Then
          blnExistemBuffers := True;

        FQryConsulta.Next;
      End;

      If (Not blnJaPriorizouPicking) And (blnPriPik) Then
      Begin

        If Not fTabelaExiste('PRE_RESSUPRIMENTO_PICKING') Then
          Exit;

        FQryConsulta.Close;
        FQryConsulta.SQL.Clear;
        FQryConsulta.SQL.Add('SELECT * FROM PRE_RESSUPRIMENTO_PICKING WHERE LCI_CODITE = :CODITE AND CONNECTION_ID() = (SELECT CONNECTION_ID())');
        FQryConsulta.Params[0].AsString := strCodIte;
        FQryConsulta.Open;
        FQryConsulta.First;

        strDigValFilterBkp    := qryDigVal.Filter;
        blnDigValFilteredBkp := qryDigVal.Filtered;

        qryDigVal.Filter := 'DIG_CODITE = ' + QuotedStr(strCodIte);
        qryDigVal.Filtered := True;

        fltQtdMov := 0;
        blnFinalizaDistribuicao := False;
        Try

          fltQtdMovimentarPck := 0;

          IF Not FQryConsulta.IsEmpty Then
          Begin
            If fConferenciaAntesDoPlanoDeRecebimento And (Not blnEtqCon) Then
            Begin
              qryDigVal.First;
              while Not qryDigVal.Eof Do
              Begin

                fltDigQtdTotal := qryDigVal.FieldByName('DIV_QTDITE').AsFloat;
                while not FQryConsulta.Eof do
                Begin

                  If fltQtdMovimentarPck = 0 then
                     fltQtdMovimentarPck := FQryConsulta.FieldByName('QUANTIDADE_MOVIMENTAR_PCK').ASFloat;
                  If fltQtdMovimentarPck > 0 Then
                  begin

                    If fltQtdMovimentarPck > fltDigQtdTotal Then
                      fltQtdInsert := fltDigQtdTotal
                    Else
                      fltQtdInsert := fltQtdMovimentarPck;

                    If  (fltQtdMov + fltQtdInsert) >  fltQtdTotalMov then
                    begin
                      fltQtdInsert := fltQtdTotalMov - fltQtdMov;
                      blnFinalizaDistribuicao := True;
                    End;

                    fltQtdMov := fltQtdMov + fltQtdInsert;


                    If fltQtdMov >=  fltQtdTotalMov then
                      blnFinalizaDistribuicao := True;

                    cdsLocSug.Insert;

                    cdsLocSug.FieldByName('LOCFIS').AsString := FQryConsulta.FieldByName('LOC_CODLOC').AsString; // Troca pela localização picking do item
                    cdsLocSug.FieldByName('QTDITE').AsFloat  := fltQtdInsert / cdsItens.FieldByName('EMBALA').AsFloat;
                    cdsLocSug.FieldByName('QTDVEN').AsFloat  := fltQtdInsert;
                    cdsLocSug.FieldByName('ABPICK').AsString := 'S';
                    cdsLocSug.FieldByName('PICKNG').AsString := 'S';
                    cdsLocSug.FieldByName('LOCTIPO').AsString  := 'Picking';
                    cdsLocSug.FieldByName('CHAVE').AsString    := cdsItens.FieldByName('CHAVE').AsString;
                    cdsLocSug.FieldByName('EXCESS').AsBoolean := False;
                    cdsLocSug.FieldByName('SELECE').AsBoolean := True;
                    cdsLocSug.FieldByName('DTAVAL').AsDateTime := qrydigVal.FieldByName('DIV_DTAVAL').AsDateTime;
                    cdsLocSug.FieldByName('CODITE').AsString  := strCodIte;
                    cdsLocSug.FieldByName('DESITE').AsString   := cdsItens.FieldByName('DESITE').AsString;
                    cdsLocSug.FieldByName('EMBREC').AsFloat := cdsLocSug.FieldByName('QTDVEN').AsFloat / cdsLocSug.FieldByName('QTDITE').AsFloat;
                  
                    cdsLocSug.Post;
                    If blnFinalizaDistribuicao then
                      break;

                    fltDigQtdTotal := fltDigQtdTotal - fltQtdInsert;
                    fltQtdMovimentarPck := fltQtdMovimentarPck - fltQtdInsert;

                    If fltDigQtdTotal = 0 then
                    begin
                      qryDigVal.Next;
                      If Not qryDigVal.Eof then
                        fltDigQtdTotal := qryDigVal.FieldByName('DIV_QTDITE').AsFloat;
                    end;
                  End;

                  If fltQtdMovimentarPck = 0 then
                    FQryConsulta.Next;
                End;
                qryDigVal.Next;
                If blnFinalizaDistribuicao then
                  break;
              End;
            End
            Else
            Begin
              fltDigQtdTotal := fltQtdIte;
              while not FQryConsulta.Eof do
              Begin

                If fltQtdMovimentarPck = 0 then
                   fltQtdMovimentarPck := FQryConsulta.FieldByName('QUANTIDADE_MOVIMENTAR_PCK').ASFloat;
                If fltQtdMovimentarPck > 0 Then
                begin

                  If fltQtdMovimentarPck > fltDigQtdTotal Then
                    fltQtdInsert := fltDigQtdTotal
                  Else
                    fltQtdInsert := fltQtdMovimentarPck;

                  If  (fltQtdMov + fltQtdInsert) >  fltQtdTotalMov then
                  begin
                    fltQtdInsert := fltQtdTotalMov - fltQtdMov;
                    blnFinalizaDistribuicao := True;
                  End;

                  fltQtdMov := fltQtdMov + fltQtdInsert;


                  If fltQtdMov >=  fltQtdTotalMov then
                    blnFinalizaDistribuicao := True;

                  cdsLocSug.Insert;

                  cdsLocSug.FieldByName('LOCFIS').AsString := FQryConsulta.FieldByName('LOC_CODLOC').AsString; // Troca pela localização picking do item
                  cdsLocSug.FieldByName('QTDITE').AsFloat  := fltQtdInsert / cdsItens.FieldByName('EMBALA').AsFloat;
                  cdsLocSug.FieldByName('QTDVEN').AsFloat  := fltQtdInsert;
                  cdsLocSug.FieldByName('ABPICK').AsString := 'S';
                  cdsLocSug.FieldByName('PICKNG').AsString := 'S';
                  cdsLocSug.FieldByName('LOCTIPO').AsString  := 'Picking';
                  cdsLocSug.FieldByName('CHAVE').AsString    := cdsItens.FieldByName('CHAVE').AsString;
                  cdsLocSug.FieldByName('EXCESS').AsBoolean := False;
                  cdsLocSug.FieldByName('SELECE').AsBoolean := True;
                  cdsLocSug.FieldByName('DTAVAL').Clear;
                  cdsLocSug.FieldByName('CODITE').AsString  := strCodIte;
                  cdsLocSug.FieldByName('DESITE').AsString   := cdsItens.FieldByName('DESITE').AsString;
                  cdsLocSug.FieldByName('EMBREC').AsFloat := cdsLocSug.FieldByName('QTDVEN').AsFloat / cdsLocSug.FieldByName('QTDITE').AsFloat;

                  cdsLocSug.Post;
                  If blnFinalizaDistribuicao then
                    break;

                  fltDigQtdTotal := fltDigQtdTotal - fltQtdInsert;
                  fltQtdMovimentarPck := fltQtdMovimentarPck - fltQtdInsert;
                End;

                If fltQtdMovimentarPck = 0 then
                  FQryConsulta.Next;
              End;
            End;
          End;
        Finally
          qryDigVal.Filtered := False;
          qryDigVal.Filter    := strDigValFilterBkp;
          qryDigVal.Filtered  := blnDigValFilteredBkp;
        End;
      End;
    end;

Begin
  Try
    Result := True;
    cdsItens.AfterScroll := Nil;
    cdsItens.DisableControls;
    cdsLocSug.DisableControls;
    cdsLocSug.AfterScroll := Nil;
    cdsLocSug.First;
    cdsItens.First;
    blnExistemBuffers := False;

    cdsLocSug.Filtered := False;
    cdsLocSug.Filter := '';

    If (fCfgSis('OBRPKN', varBoolean) And fHaItensSemMapeamento) Then
      Exit(True);

    If (blnNotasDeTransfApenasManual  And fFornecedorFilial(cdsItens.FieldByName('ADC_CODFOR').AsString)) Then
    Begin
      cdsItens.First;
      cdsItens.EnableControls;
      cdsLocSug.EnableControls;
      cdsItens.AfterScroll := pFiltraSugestaoCds;
      cxgSugestaoTableView.ViewData.Expand(True);
      If fCfgSis('MOSTPK', varBoolean) Then
        chkAllPick.Checked := True
      Else
        chkAllPick.Checked := Not blnExistemBuffers;
      Exit(True);
    End;

    If blnProcessandoCubagem Then
    Begin
      while not cdsLocSug.Eof Do
      Begin
        If (cdsLocSug.FieldByName('PICKNG').AsString = 'S') Then
          cdsLocSug.Next
        Else
          cdsLocSug.Delete;
      End;
    End
    Else
      cdsLocSug.EmptyDataSet;


    blnAgeIloVazia := False;
    stlLocExcSelecionados.Clear;

    If Not blnProcessandoCubagem Then
    Begin
      If (cdsItens.FieldByName('GRAVADO').AsString = 'S') Then
      Begin
        Try
          qryAgeIlo := fCriaQuery;
          With qryAgeIlo, SQL Do
          Begin
            Close;
            Clear;
            Add(' SELECT                     ');
            Add(' AGEILO.AUTOINCREM,         ');
            Add('        AIL_SEQITE,         ');
            Add('        AIL_QTDITE,         ');
            Add('        AIL_LOCFIS,         ');
            Add('        AIL_DTAVEN,         ');
            Add('        AIL_ENDERE,         ');
            Add('        AIL_QTDVEN,         ');
            Add('        AIL_PICKNG,         ');
            Add('        AIL_IMPRES,         ');
            Add('        AIL_SEQUEN,         ');
            Add('        LOC_PICKIN          ');
            Add(' FROM AGEILO                ');
            Add(' INNER JOIN CADLOC ON       ');
            Add('   LOC_CODLOC = AIL_LOCFIS  ');
            Add('   AND LOC_CODEMP = "'+VS_StrCodEmp+'"');

            Add(' WHERE AIL_SEQITE = :SEQITE ');


           strChavesUsadas := '';
           strItensProcessados := '';
            While Not cdsItens.Eof Do
            Begin
              Close;
              If pos(cdsItens.FieldByName('CHAVE').AsString, strItensProcessados) > 0 Then
              Begin
                cdsItens.Next;
                Continue;
              End;

              ParamByName('SEQITE').AsString := cdsItens.FieldByName('CHAVE').AsString;
              strItensProcessados := strItensProcessados + ',' + cdsItens.FieldByName('CHAVE').AsString;
              Open;
              blnAgeIloVazia := qryAgeIlo.isEmpty;
              While Not Eof Do
              Begin
                cdsLocSug.Insert;
                cdsLocSug.FieldByName('AUTINC').AsString   := FieldByName('AUTOINCREM').AsString;
                cdsLocSug.FieldByName('CHAVE').AsString    := FieldByName('AIL_SEQITE').AsString;
                cdsLocSug.FieldByName('LOCFIS').AsString   := FieldByName('AIL_LOCFIS').AsString;
                cdsLocSug.FieldByName('DTAVAL').AsDateTime := FieldByName('AIL_DTAVEN').AsDateTime;
                cdsLocSug.FieldByName('QTDITE').AsFloat    := FieldByName('AIL_QTDVEN').AsFloat / cdsItens.FieldByName('EMBALA').AsFloat;
                cdsLocSug.FieldByName('QTDVEN').AsFloat    := FieldByName('AIL_QTDVEN').AsFloat;
                cdsLocSug.FieldByName('ENDERE').AsString   := FieldByName('AIL_ENDERE').AsString;
                cdsLocSug.FieldByName('EXCESS').AsBoolean  := FieldByName('LOC_PICKIN').AsString = 'E';
                If cdsLocSug.FieldByName('EXCESS').AsBoolean Then
                  cdsLocSug.FieldByName('LOCTIPO').AsString := 'Excesso'
                Else
                  cdsLocSug.FieldByName('LOCTIPO').AsString :=  IIF(FieldByName('LOC_PICKIN').AsString = 'S', 'Picking', 'Buffer');
                cdsLocSug.FieldByName('ABPICK').AsString   := IIF(FieldByName('LOC_PICKIN').AsString = 'S', 'S', 'N');
                cdsLocSug.FieldByName('AIL_IMPRES').AsString := FieldByName('AIL_IMPRES').AsString;
                cdsLocSug.FieldByName('SELECE').AsBoolean  := True;
                cdsLocSug.FieldByName('PICKNG').AsString   := FieldByName('AIL_PICKNG').AsString;
                cdsLocSug.FieldByName('CODITE').AsString   := cdsItens.FieldByName('CODITE').AsString;
                cdsLocSug.FieldByName('DESITE').AsString   := cdsItens.FieldByName('DESITE').AsString;
                cdsLocSug.FieldByName('EMBREC').AsFloat := cdsLocSug.FieldByName('QTDVEN').AsFloat / cdsLocSug.FieldByName('QTDITE').AsFloat;
                cdsLocSug.FieldByName('SEQUEN').AsString   := FieldByName('AIL_SEQUEN').AsString;

                cdsLocSug.Post;

                blnRestaurouDaAgeilo := True;

                Next;
              End;
              cdsItens.Next;
            End;
          End;
        Finally

        End;

        If (Not blnAgeIloVazia) And (Not blnProcessandoCubagem) Then
        Begin
          btnImprimir.Enabled := True;
          Exit(True);
        End;
      End;
    End;


    If blnApenasRecarregaAgeilo then
      Exit(true);

    cxProgressBar.pSetMax(cdsItens.RecordCount);

    cdsItens.First;

    blnJaSugeriuBanco := False;

    While not cdsItens.Eof Do
    Begin

      if (cdsItens.FieldByName('QTDNOR').AsFloat <> 0) And  (cdsItens.FieldByName('APEPIC').AsString <> 'S') then
      begin
        If fConferenciaAntesDoPlanoDeRecebimento And (Not blnEtqCon) And ((blnSugereLocalizacao And blnColVal)) Then
        Begin
          qryDigVal.Close;
          qryDigVal.ParamByName('CODEMP').AsString := VS_strCodEmp;
          qryDigVal.ParamByName('IDEDIG').AsString := strIdeDig;
          qryDigVal.ParamByName('CODITE').AsString := cdsItens.FieldByName('CODITE').AsString;
          qryDigVal.Open;
          qryDigVal.First;

          If blnColVal Then
            dtaVal := qryDigVal.FieldByName('DIV_DTAVAL').AsDateTime
          Else
            dtaVal := fNow;

          fltQtdIteVal := 0;
          While (Not qryDigVal.Eof) and (fltQtdIteVal < cdsItens.FieldByName('QTDNOR').AsFloat) Do
          Begin
            fltQtdIteVal := fltQtdIteVal + qryDigVal.FieldByName('DIV_QTDITE').AsFloat;

            if fltQtdIteVal <= cdsItens.FieldByName('QTDNOR').AsFloat then
              fltQtdIte := qryDigVal.FieldByName('DIV_QTDITE').AsFloat
            else
              fltQtdIte := qryDigVal.FieldByName('DIV_QTDITE').AsFloat - (fltQtdIteVal - cdsItens.FieldByName('QTDNOR').AsFloat);

            If blnSugestaoViaBanco Then
            Begin
              fltQtdASugerir := IIF(cdsItens.FieldByName('QTDCON').AsFloat > cdsItens.FieldByName('QTDNOR').AsFloat,
                                                                             cdsItens.FieldByName('QTDNOR').AsFloat,
                                                                             cdsItens.FieldByName('QTDCON').AsFloat);
              If Not blnJaSugeriuBanco Then
              Begin
                pMontaSugestaoBanco(cdsItens.FieldByName('CODITE').AsString, '', '', fltQtdASugerir , dtaVal);
                blnJaSugeriuBanco := True;
              End;
            End
            Else
              objSugLoc.pMontaSugestao(cdsLocSug,
                                       cdsItens.FieldByName('CHAVE').AsString,
                                       cdsItens.FieldByName('CODITE').AsString,
                                       cdsItens.FieldByName('DESITE').AsString,
                                       cdsItens.FieldByName('NUMLOT').AsString,
                                       cdsItens.FieldByName('EMBALA').AsFloat,
                                       fltQtdIte,
                                       qryDigVal.FieldByName('DIV_DTAVAL').AsFloat);

            qryDigVal.Next;
          End;

        End
        Else
        Begin
          qryDigVal.Close;
          qryDigVal.ParamByName('CODEMP').AsString := VS_strCodEmp;
          qryDigVal.ParamByName('IDEDIG').AsString := strIdeDig;
          qryDigVal.ParamByName('CODITE').AsString := cdsItens.FieldByName('CODITE').AsString;
          qryDigVal.Open;

          if fConferenciaAntesDoPlanoDeRecebimento And (qryDigVal.FieldByName('DIG_QTDITE').AsFloat <= cdsItens.FieldByName('QTDNOR').AsFloat) Then
            fltQtdIte := qryDigVal.FieldByName('DIG_QTDITE').AsFloat
          else
            fltQtdIte := cdsItens.FieldByName('QTDNOR').AsFloat;

         If blnSugestaoViaBanco Then
           pMontaSugestaoBanco(cdsItens.FieldByName('CODITE').AsString, '', '', fltQtdIte, qryDigVal.FieldByName('DIV_DTAVAL').AsFloat)
         Else
           objSugLoc.pMontaSugestao(cdsLocSug,
                                    cdsItens.FieldByName('CHAVE').AsString,
                                    cdsItens.FieldByName('CODITE').AsString,
                                    cdsItens.FieldByName('DESITE').AsString,
                                    cdsItens.FieldByName('NUMLOT').AsString,
                                    cdsItens.FieldByName('EMBALA').AsFloat,
                                    fltQtdIte,
                                    0);

        End;
      end;

        cxProgressBar.pStepBy;
        cdsItens.Next;
        blnJaSugeriuBanco := False;
        Application.ProcessMessages;
      End;
  Finally
    cdsItens.First;
    cdsItens.EnableControls;
    cdsLocSug.EnableControls;
    cdsItens.AfterScroll := pFiltraSugestaoCds;
    cxgSugestaoTableView.ViewData.Expand(True);
    chkAllPick.Checked := Not blnExistemBuffers;
  End;
End;

procedure TfrmPlanoDeRecebimento.pFiltraSugestaoCds(DataSet : TDataSet);
Begin
  If blnNotasDeTransfApenasManual Then
    btnCubAut.Enabled := Not (fFornecedorFilial(cdsItens.FieldByName('ADC_CODFOR').AsString));

  If cdsLocSug.isEmpty And (Not cdsLocSug.Filtered) Then
    Exit;

  If blnSugestaoViaBanco Then
  Begin
    cdsLocSug.Filtered := False;
    cdsLocSug.Filter := 'CHAVE = ' + QuotedStr(cdsItens.FieldByName('CHAVE').AsString);
    If fCfgSis('MODCUB', varString) = '2' Then
    Begin
      If cdsItens.FieldByName('APEPIC').AsString = 'S' Then
        cdsLocSug.Filter := cdsLocSug.Filter + ' AND PICKNG = ' + QuotedStr('S');
      //Else
     //   cdsLocSug.Filter := cdsLocSug.Filter + ' AND ((PICKNG = ' + QuotedStr('N') + ') OR (PICKNG = ' + QuotedStr('') + '))';
    End;

    cdsLocSug.Filtered := True;
  End
  Else
  begin
    cdsLocSug.Filtered := False;
    cdsLocSug.Filter := 'CHAVE = ' + QuotedStr(cdsItens.FieldByName('CHAVE').AsString);
    cdsLocSug.Filtered := True;
  End;

  cxgSugestaoTableView.ViewData.Expand(True);
End;

function TfrmPlanoDeRecebimento.fValidaLocalSelecionado(strLocFis : String) : Boolean;
  Var
    qryCadLoc : TUniQuery;
Begin
  Try
    qryCadLoc := fCriaQuery;
    With qryCadLoc, SQL Do
    Begin
      Close;
      Clear;

      Add(' SELECT ITE_DESITE ');
      Add(' FROM CADLOT       ');
      Add(' INNER JOIN CADITE ON ITE_CODITE = LOT_CODITE ');
      Add(' WHERE LOT_CODEMP = :CODEMP ');
      Add('   AND LOT_LOCFIS = :CODLOC ');
      Add('   AND LOT_SALDOS > 0       ');

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODLOC').AsString := strLocFis;

      Open;

      Result := IsEmpty;

      if not Result Then
      Begin
        fMensagem('', 'Localização Física não permitida pois o produto ' + FieldByName('ITE_DESITE').AsString + ' esta alocado nessa localização!', ['&OK']);
      End
      Else
      Begin
        Close;
        Clear;
        Add(' SELECT *                                           ');
        Add(' FROM AGEITE I                                      ');
        Add('   INNER JOIN AGEILO L ON AIL_SEQITE = I.AUTOINCREM ');
        Add('   INNER JOIN AGEREC R ON R.AUTOINCREM = AIT_SEQGER ');
        Add(' WHERE AIL_ENDERE = "N"                             ');
        Add('   AND AIL_LOCFIS = :CODLOC                         ');
        Add('   AND ARC_CODEMP = :CODEMP                         ');

        Open;

        Result := IsEmpty;

        if not Result Then
        Begin
          fMensagem('', 'Localização Física não permitida pois já existe um produto destinado a esta localização!', ['&OK']);
        End;

      End;

      If (Result) And
          (TCadLot.fBloqueiaTranfSaldoLote('', strLocFis, '', VS_strCodEmp)) Then
      Begin
        Result := False;
      End;

      Close;
    End;
  Finally
    FreeAndNil(qryCadLoc);
  End;

End;

procedure TfrmPlanoDeRecebimento.ReimprimirEtiqueta1Click(Sender: TObject);
  Var
    prmDllEtq : TParamDllEtiquetas;
    ArrNomEti : TStringArray;
    strTipEti : String;
begin
  inherited;

  If cdsItens.FindField('GRAVADO') <> Nil Then
  Begin

    if (blnSugereLocalizacao and (Length(cdsLocSug.FieldByName('AUTINC').AsString) <> 20)) or ((not blnSugereLocalizacao) and (cdsItens.FieldByName('GRAVADO').AsString <> 'S')) Then
    Begin
      fMensagem('', 'Só é possível reimprimir a etiqueta depois que o plano foi confirmado!', ['&OK']);
      Exit;
    End;

    Try
      prmDllEtq := TParamDllEtiquetas.Create;
      prmDllEtq.strSeqAgeILo := '';
      prmDllEtq.strCodIte    := '';
      prmDllEtq.cdsPlanoRecebimento := TUniClientDataSet.Create(nil);
      prmDllEtq.cdsPlanoRecebimento.Data := cdsItens.Data;
      prmDllEtq.intQtdEti    := cdsItens.FieldByName('QTDETI').AsInteger;

      prmDllEtq.strAutInc := ShortString(cdsItens.FieldByName('AUTINC').AsString);

      if blnSugereLocalizacao then
        prmDllEtq.strSeqAgeILo := ShortString(cdsLocSug.FieldByName('AUTINC').AsString)
      else
        prmDllEtq.strCodIte := cdsItens.FieldByName('CODITE').AsString;

      strTipEti := fCfgSis('PLAREC', varString);
      If strTipEti = 'L' Then
       prmDllEtq.tpeTipEtq := tpePlanoRecebWMSLaser
      Else
      If strTipEti = 'A' Then
        prmDllEtq.tpeTipEtq := tpePlanoRecebWMSArgox
      Else
      Begin
        SetLength(ArrNomEti, 0);
        pAddDados(ArrNomEti, 'Laser');
        pAddDados(ArrNomEti, 'Argox');
        Case fGetMenu('Escolha o Modelo:', ArrNomEti, 1, True) Of
          1: prmDllEtq.tpeTipEtq := tpePlanoRecebWMSLaser;
          2: prmDllEtq.tpeTipEtq := tpePlanoRecebWMSArgox;
        End;
      End;

      fImprimeEtiqueta(prmDllEtq, 'fimprimeetiquetas');
    Finally
      FreeAndNil(prmDllEtq.cdsPlanoRecebimento);
      FreeAndNil(prmDllEtq);
    End;

  End;

end;

procedure TfrmPlanoDeRecebimento.Splitter1Moved(Sender: TObject);
begin
  inherited;
  pnlGridsPlanoSuge.Repaint;
end;

procedure TfrmPlanoDeRecebimento.sptSplitterMoved(Sender: TObject);
begin
  inherited;
  pnlEtiquetasID.Repaint;
end;

Function TfrmPlanoDeRecebimento.fRetTabelaPreco(strCodCli, strCodVen: String): String;
  Var
    strTabPre,
    strTabSuj,
    strTabCli: String;
Begin
  strTabPre := '1';
  strTabCli := fCampoTabela('CLI_TABPRE', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);

  If fEmptyStr(strTabCli) And fCfgSis('HIETAB', VarBoolean) Then
    strTabCli := fCampoTabela('OPE_TABPRE', 'CADOPE', ['OPE_CODOPE'], [strCodVen], False);

  If (fCfgSis('UTAPTB') <> '0') Then
    strTabPre := fCfgSis('UTAPTB')
  Else If fCfgSis('SUGTBP', varBoolean) Then
  Begin
    strTabSuj := fCfgSis('TBPSUG');

    If strTabSuj <> '0' Then
    Begin
      strTabPre := strTabSuj;
    End
    Else If Not fEmptyStr(strTabCli) Then
      strTabPre := strTabCli
    Else If (fEmptyStr(strTabCli)) Then
    Begin
      If (Not fEmptyStr(fCfgSis('TBPRPD', varString))) Then
        strTabPre := fCfgSis('TBPRPD', varString);
    End;
  End
  Else If Not fEmptyStr(strTabCli) Then
    strTabPre := strTabCli
  Else If (fEmptyStr(strTabCli)) Then
  Begin
    If (Not fEmptyStr(fCfgSis('TBPRPD', varString))) Then
      strTabPre := fCfgSis('TBPRPD', varString);
  End;

  Result := strTabPre;
End;


function TfrmPlanoDeRecebimento.fTemCubagemManual: Boolean;
var
  qtdCubagemManual: integer;
  qtdCubagemAutomatica: integer;
  qtdSemCubagem: integer;
  qtdTotalReg: integer;
  qtdRegComPiking: integer;
begin
  pCarregaDefinicoesCubagem(qtdCubagemManual,
                            qtdCubagemAutomatica,
                            qtdSemCubagem,
                            qtdTotalReg,
                            qtdRegComPiking);

  Result := qtdCubagemManual > 0
end;

function TfrmPlanoDeRecebimento.fTemEtiquetaSendoBipada: Boolean;
var
  intRecNo,
  intRecCn: Integer;
begin
  If qryEtique.RecordCount > 0 Then
  Begin
    blnSuprimirMsgEtiquetasID := True;
    pProcessarEtiquetasID;
  End;

  intRecNo := qryEtique.RecNo;
  qryEtique.DisableControls;

  qryEtique.Filter := 'ID IS NOT NULL';
  qryEtique.Filtered := True;
  intRecCn := qryEtique.RecordCount;
  qryEtique.Filtered := False;

  If intRecCn = 0 Then
    Exit(False);

  qryEtique.First;
  While Not qryEtique.Eof Do
  Begin
    If objLock.fLock_Unlock(qryEtique.FieldByName('ID').AsString, False, False) Then
      Exit(True);

    qryEtique.Next;
  End;

  Result := False;

  qryEtique.RecNo := intRecNo;

  qryEtique.EnableControls;
  qryEtique.Filtered := False;
end;

procedure TfrmPlanoDeRecebimento.pDefineAliquotaIss(strCodCli, strCodCid, strCodSer: String; var fltPerIss: Double; var fltRedIss: Double);
  Var
    intIndSer: Integer;
begin

  fltPerIss := fCampoTabela('CLI_ALQISS','CADCLI', ['CLI_CODCLI'], [strCodCli]);
  fltRedIss := fCampoTabela('CLI_REDISS','CADCLI', ['CLI_CODCLI'], [strCodCli]);

  If (fltPerIss <= 0) And fCfgSis('ISSSER', varBoolean) Then
  Begin
    For intIndSer := 1 To 30 Do
    Begin
      fltPerIss := fCampoTabela('SER_ALQISS','CADSER', ['SER_CODSER'], [strCodSer]);
      fltRedIss := fCampoTabela('SER_REDISS','CADSER', ['SER_CODSER'], [strCodSer]);

      If fltPerIss > 0 Then
        Break;

    End;

  End;

  If (fltPerIss <= 0) Then
  Begin
    fltPerIss := fRetAliquotaIssCidade(strCodCid);
    fltRedIss := fRetReducaoBaseIssCidade(strCodCid);
  End;

  If (fltPerIss <= 0) Then
  Begin
    fltPerIss := fCfgSis('PERISS', varDouble);
    fltRedIss := fCfgSis('REDISS', varDouble);
  End;
end;

procedure TfrmPlanoDeRecebimento.pEstornaPedidoCompra(strAutIncMovDet: String;
                                                      strNumDoc, strEspDoc, strCodEmp, strCodFor, strSerDoc, AstrPEDCOM, AstrEMPCOM, strCODITE: String;
                                                      fltQTDITE: Double;
                                                      Var AstlPedCom, AAstlPedComAux: TStringList);
Var
  strPedCom,
  strEmpCom,
  strSQL,
  strQTDBAI: String;
  blnDefBai,
  blnUsaConferenciaParcial : Boolean;
  qryBuscaPedidosVinculadosANota,
  qryGen: TUniQuery;

  function fRetornaPCG_CODEMP: String;
  var
    qryGen: TUniQuery;
  begin
    qryGen := fCriaQuery;
    Try
      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add('SELECT PCG_CODEMP AS CODEMP FROM MOVGER G');
      qryGen.SQL.Add('LEFT JOIN PCMGER ON PCG_DOCEMI = G.GER_NUMDOC');
      qryGen.SQL.Add('                AND PCG_ESPEMI = G.GER_ESPDOC');
      qryGen.SQL.Add('WHERE GER_NUMDOC = "'+ strNumDoc + '"');
      qryGen.SQL.Add('  AND GER_ESPDOC = "'+ strEspDoc + '"');
      qryGen.SQL.Add('  AND GER_SERIE_ = "'+ strSerDoc + '"');
      qryGen.SQL.Add('  AND GER_CODFOR = "'+ strCodFor + '"');
      qryGen.SQL.Add('  AND GER_CODEMP = "'+ VS_StrCodEmp + '"');
      qryGen.Open;

      Result := IIF(fEmptyStr(qryGen.FieldByName('CODEMP').AsString), VS_StrCodEmp, qryGen.FieldByName('CODEMP').AsString);

    Finally
      FreeAndNil(qryGen);
    End;
  end;
begin
  blnUsaConferenciaParcial := (fCfgSis('USACON', varBoolean)) And (fCfgSis('PERCPA', varBoolean));
  blnDefBai := TDefineBaixaPedido.fEstornaPedidoPorDefinicaoDeBaixa(strAutIncMovDet, blnUsaConferenciaParcial, AAstlPedComAux);

  strPedCom := '';
  strEmpCom := '';

  If AstlPedCom.Count = 0 Then
  Begin
    qryBuscaPedidosVinculadosANota:= fCriaQuery(Self);
    Try
      qryBuscaPedidosVinculadosANota.Close;
      qryBuscaPedidosVinculadosANota.SQL.CLear;
      qryBuscaPedidosVinculadosANota.SQL.Add('SELECT * FROM PCMGER ');
      If Not fEmptyStr(strCodFor) Then
        qryBuscaPedidosVinculadosANota.SQL.Add(' INNER JOIN CADFOR ON FOR_CODFOR = PCG_CODFOR ');
      qryBuscaPedidosVinculadosANota.SQL.Add(' WHERE PCG_DOCEMI = "'+strNumDoc+'" AND ');
      qryBuscaPedidosVinculadosANota.SQL.Add('       PCG_ESPEMI = "'+strEspDoc+'" AND ');
      qryBuscaPedidosVinculadosANota.SQL.Add('       PCG_CODEMP = "'+fRetornaPCG_CODEMP+'" AND ');

      If Not fEmptyStr(strCodFor) Then
      Begin
        qryBuscaPedidosVinculadosANota.SQL.Add('     ((PCG_CODFOR = ' + QuotedStr(strCodFor) + ') OR ' );
        qryBuscaPedidosVinculadosANota.SQL.Add('     (FOR_C_G_C_ LIKE ' +
         QuotedStr(LeftStr(fTiraCaracEspeciaisPonto(fCampoTabela('FOR_C_G_C_', 'CADFOR', ['FOR_CODFOR', 'FOR_CGCCPF'], [strCodFor, '1'])), 8) + '%') +  ')   )');
      End;

      qryBuscaPedidosVinculadosANota.Open;

      If qryBuscaPedidosVinculadosANota.RecordCount > 1 Then
      Begin

        qryBuscaPedidosVinculadosANota.First;

        while Not(qryBuscaPedidosVinculadosANota.eof) do
        Begin
          AstlPedCom.Add(qryBuscaPedidosVinculadosANota.FieldByName('PCG_NUMPED').AsString +
                        '-' + qryBuscaPedidosVinculadosANota.FieldByName('PCG_CODEMP').AsString);
          qryBuscaPedidosVinculadosANota.Next;
        End;

      End
      Else
      Begin
        If (Not FEmptyStr(AstrPEDCOM)) Then
        Begin
          strPedCom := AstrPEDCOM;
          strEmpCom := AstrEMPCOM;
          AstlPedCom.Add(strPedCom + '-' + strEmpCom);
        End;
      End;
    Finally
      FreeAndNil(qryBuscaPedidosVinculadosANota);
    End
  End;

  If (Not blnDefBai) And (Not fEmptyStr(strPedCom)) Then
  Begin

    qryGen := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  PCMDET ';
    strSQL := strSQL + 'SET ';

    strSQL := strSQL + '  PCD_VALFRE = PCD_VALFRE + (@FREUNI:=(PCD_FREBAI / PCD_QTDBAI))* 0, ';
    strSQL := strSQL + '  PCD_DESACE = PCD_DESACE + (@ACEUNI:=(PCD_ACEBAI / PCD_QTDBAI))* 0, ';
    strSQL := strSQL + '  PCD_TOTDAR = PCD_TOTDAR + (@DARUNI:=(PCD_TOTDAR / PCD_QTDITE))* 0, ';

    strSQL := strSQL + '  PCD_BAIXAD = 0, ';

    strQTDBAI := ' (:QTDBAI / IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA)) ';

    If fCfgSis('CNVEMB') <> 'N' Then
      strSQL := strSQL + '  PCD_QTDBAI = IF(PCD_QTDBAI - ' + strQTDBAI + ' < 0, 0, PCD_QTDBAI - ' + strQTDBAI + '), '
    Else
      strSQL := strSQL + '  PCD_QTDBAI = IF(PCD_QTDBAI - :QTDBAI < 0, 0, PCD_QTDBAI - :QTDBAI), ';

    strSQL := strSQL + '  PCD_TOTBAI = (PCD_QTDBAI * (PCD_UNITAR * (1 - IFNULL(PCD_DESUNI, 0) / 100) ';
    strSQL := strSQL + '                                         * (1 - IFNULL(PCD_DESUN2, 0) / 100) ';
    strSQL := strSQL + '                                         * (1 - IFNULL(PCD_DESUN3, 0) / 100) ';
    strSQL := strSQL + '                                         * (1 - IFNULL(PCD_DESUN4, 0) / 100) ';
    strSQL := strSQL + '                                         * (1 - IFNULL(PCD_DESUN5, 0) / 100) ';
    strSQL := strSQL + '                                         * (1 - IFNULL(PCD_DESUN6, 0) / 100) ';
    strSQL := strSQL + '              )), ';

    strSQL := strSQL + '  PCD_FREBAI = ROUND(@FREUNI * PCD_QTDBAI, 2), ';
    strSQL := strSQL + '  PCD_ACEBAI = ROUND(@ACEUNI * PCD_QTDBAI, 2), ';

    strSQL := strSQL + '  PCD_VALFRE = ROUND(@FREUNI * (PCD_QTDITE - PCD_QTDBAI), 2), ';
    strSQL := strSQL + '  PCD_DESACE = ROUND(@ACEUNI * (PCD_QTDITE - PCD_QTDBAI), 2), ';

    strSQL := strSQL + '  PCD_IPIBAI = PCD_TOTBAI * (PCD_PERIPI / 100), ';
    strSQL := strSQL + '  PCD_SUBBAI = PCD_TOTBAI * (PCD_PERSUB / 100), ';
    strSQL := strSQL + '  PCD_FCPBAI = PCD_SUBBAI * (PCD_PERFCP / 100), ';

    strSQL := strSQL + '  PCD_DARBAI = ROUND(@DARUNI * PCD_QTDBAI, 2) ';

    If blnUsaConferenciaParcial Then
    Begin
      If fCfgSis('CNVEMB') <> 'N' Then
        strSQL := strSQL + '  , PCD_QTDCON = IF(PCD_QTDCON + ' + strQTDBAI + ' >= PCD_QTDITE, PCD_QTDITE, PCD_QTDCON + ' + strQTDBAI + ') '
      Else
        strSQL := strSQL + '  , PCD_QTDCON = IF(PCD_QTDCON + :QTDBAI >= PCD_QTDITE, PCD_QTDITE, PCD_QTDCON + :QTDBAI) ';
    End;

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PCD_ESPDOC = "PD"    AND ';
    strSQL := strSQL + '  PCD_NUMCTN = 0       AND ';
    strSQL := strSQL + '  PCD_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCD_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  PCD_CODITE = :CODITE ';

    Try
      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);
      qryGen.ParamByName('CODITE').AsString  := strCODITE;
      qryGen.ParamByName('QTDBAI').AsFloat   := fltQTDITE;
      qryGen.ParamByName('NUMPED').AsString  := strPedCom;
      qryGen.ParamByName('CODEMP').AsString  := strEmpCom;

      pEstornaSaldoPedidoCompra(strPedCom, 'PD', strEmpCom, strCODITE);

      qryGen.ExecSQL;

      pAtualizaSaldoPedidoCompra(strPedCom, 'PD', strEmpCom, strCODITE);

      qryGen.Close;

    Except

      On E: Exception Do
      Begin
        FreeAndNil(qryGen);
        Raise Exception.Create(E.Message);
      End;

    End;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  PCMGER ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  PCG_BAIXAD = 0, ';

    strSQL := strSQL + '  PCG_VALFRE = (SELECT SUM(PCD_VALFRE) FROM PCMDET WHERE PCD_ESPDOC = "PD" ';
    strSQL := strSQL + '                   AND PCD_NUMCTN = 0         ';
    strSQL := strSQL + '                   AND PCD_NUMPED = :NUMPED   ';
    strSQL := strSQL + '                   AND PCD_CODEMP = :CODEMP), ';

    strSQL := strSQL + '  PCG_DESACE = (SELECT SUM(PCD_DESACE) FROM PCMDET WHERE PCD_ESPDOC = "PD" ';
    strSQL := strSQL + '                   AND PCD_NUMCTN = 0         ';
    strSQL := strSQL + '                   AND PCD_NUMPED = :NUMPED   ';
    strSQL := strSQL + '                   AND PCD_CODEMP = :CODEMP) ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '     PCG_ESPDOC = "PD"    ';
    strSQL := strSQL + ' AND PCG_NUMCTN = 0       ';
    strSQL := strSQL + ' AND PCG_NUMPED = :NUMPED ';
    strSQL := strSQL + ' AND PCG_CODEMP = :CODEMP ';

    Try
      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);
      qryGen.ParamByName('NUMPED').AsString  := strPedCom;
      qryGen.ParamByName('CODEMP').AsString  := strEmpCom;

      qryGen.ExecSQL;
      qryGen.Close;

    Except

      On E: Exception Do
      Begin
        FreeAndNil(qryGen);
        Raise Exception.Create(E.Message);
      End;

    End;


    FreeAndNil(qryGen);
  End;

end;

procedure TfrmPlanoDeRecebimento.pProcessarEtiquetasID;
var
  frmGravando: TFrmGravando;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);

    frmGravando.fExecutarAcao := fProcessarEtiquetasIDAux;
    frmGravando.lblGravando.Caption := 'Processando etiquetas ID...';
    frmGravando.pgbStatus.Visible := False;
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;
end;


function TfrmPlanoDeRecebimento.fRetSumAgeilo(AField: String): String;
begin
  Result := '(SELECT SUM('+AField+') FROM AGEILO WHERE AGEILO.AIL_SEQITE = AGEITE.AUTOINCREM)';
End;

function TfrmPlanoDeRecebimento.fGetSQLEtiquetasID: String;
Begin
  Result := '';
  Result := Result + ' SELECT                                         ';
  Result := Result + '   ETI_CODITE AS CODITE,                        ';
  Result := Result + '   ITE_DESITE,                                  ';
  Result := Result + '   ITE_CODBAR,                                  ';
  Result := Result + '   IFNULL(ETI_LOCFIS, "")  AS LOCFIS,           ';
  Result := Result + '   ETIREC.ETI_STATUS AS STATUS,                 ';
  Result := Result + '   ETI_ETIID_ AS ID,                            ';
  Result := Result + '   ITE_CODUNI,                                  ';
  Result := Result + '   ETI_DTAVAL,                                  ';
  Result := Result + '     CONCAT(ETI_ETIID_,                         ';
  Result := Result + '     " Loc. física endereçamento: ",            ';
  Result := Result + '     IFNULL(ETI_LOCFIS, "")                     ';
  Result := Result + '   ) AS CHAVE,                                  ';
  Result := Result + ' @QTDETI := IFNULL(';
  Result := Result + ' (SELECT';
  Result := Result + '   SUM(ETI_QTDITE)';
  Result := Result + ' FROM';
  Result := Result + '   ETIREC R2';   
  Result := Result + '   INNER JOIN ETIRIT E2';
  Result := Result + '     ON E2.ETI_ETIREC = R2.AUTOINCREM';
  Result := Result + ' WHERE R2.ETI_CODREC = AGEREC.AUTOINCREM';
  Result := Result + '   AND E2.ETI_CODITE = CADITE.ITE_CODITE ';
  Result := Result + '   AND R2.AUTOINCREM = ETIRIT.ETI_ETIREC ), 0) ETIQ,';
  Result := Result + '   CAST(@QTDETI AS DECIMAL(12,2)) AS ETI_QTDITE,               ';

  Result := Result + '   ROUND(@QTDETI/' + fGetSQLTriEmbala + ' , 2) AS ETI_QTDEMB, ';
  Result := Result + '   ETIREC.AUTOINCREM AS REC_AUTINC,             ';
  Result := Result + '   ETIRIT.AUTOINCREM AS RIT_AUTINC,             ';
  Result := Result + '   ITE_NIVGIR                                   ';
  Result := Result + ' FROM                                           ';
  Result := Result + '   ETIRIT                                       ';
  Result := Result + '   INNER JOIN ETIREC                            ';
  Result := Result + '     ON ETIREC.AUTOINCREM = ETIRIT.ETI_ETIREC   ';
  Result := Result + '   INNER JOIN AGEREC                            ';
  Result := Result + '     ON ETIREC.ETI_CODREC = AGEREC.AUTOINCREM   ';
  Result := Result + '  INNER JOIN AGEDOC                             ';
  Result := Result + '    ON ADC_SEQGER = AGEREC.AUTOINCREM           ';
  Result := Result + '  INNER JOIN MOVDET T                           ';
  Result := Result + '    ON T.DET_NUMDOC = ADC_NUMDOC                ';
  Result := Result + '    AND T.DET_ESPDOC = ADC_ESPDOC               ';
  Result := Result + '    AND T.DET_SERIE_ = ADC_SERIE_               ';
  Result := Result + '    AND T.DET_CODFOR = ADC_CODFOR               ';
  Result := Result + '    AND T.DET_CODEMP = ADC_CODEMP               ';
  Result := Result + '    AND T.DET_CODITE = ETI_CODITE               ';
  Result := Result + '  INNER JOIN MOVTRI M ON M.DET_SEQGER = T.AUTOINCREM';
  Result := Result + '   INNER JOIN AGEITE                            ';
  Result := Result + '     ON AGEREC.AUTOINCREM = AGEITE.AIT_SEQGER   ';
  Result := Result + '     AND AGEITE.AIT_CODITE = ETIRIT.ETI_CODITE  ';
  Result := Result + '   INNER JOIN CADITE                            ';
  Result := Result + '     ON CADITE.ITE_CODITE = ETI_CODITE          ';
  Result := Result + '   INNER JOIN ITEGER G                          ';
  Result := Result + '     ON G.ITE_CODITE = ETI_CODITE               ';
  Result := Result + '    AND G.ITE_CODEMP = :CODEMP                  ';
  Result := Result + ' WHERE ARC_IDEDIG = :IDEDIG                     ';
  Result := Result + '   AND ARC_CODEMP = :CODEMP                     ';
  Result := Result + '   AND AIT_MODCUB = "M"                         ';
  Result := Result + ' GROUP BY CODITE,ETI_ETIID_                     ';
  Result := Result + ' UNION                                          ';
  Result := Result + ' ALL                                            ';
  Result := Result + ' SELECT                                         ';
  Result := Result + '   CODITE,                                      ';
  Result := Result + '   ITE_DESITE,                                  ';
  Result := Result + '   ITE_CODBAR,                                  ';
  Result := Result + '   LOCFIS,                                      ';
  Result := Result + '   STATUS,                                      ';
  Result := Result + '   ID,                                          ';
  Result := Result + '   ITE_CODUNI,                                  ';
  Result := Result + '   CURDATE(),                                   ';
  Result := Result + '   CHAVE,                                       ';
  Result := Result + '   ETIQ , ';

  Result := Result + '   ETI_QTDITE,                                  ';
  Result := Result + '   ETI_QTDEMB,                                  ';
  Result := Result + '   REC_AUTINC,                                  ';
  Result := Result + '   RIT_AUTINC,                                  ';
  Result := Result + '   ITE_NIVGIR                                   ';
  Result := Result + '   FROM                                         ';
  Result := Result + ' (SELECT                                        ';
  Result := Result + '   AIT_CODITE AS CODITE,                        ';
  Result := Result + '   ITE_DESITE,                                  ';
  Result := Result + '   ITE_CODBAR,                                  ';
  Result := Result + '   "" AS LOCFIS,                                ';
  Result := Result + '   "" AS STATUS,                                ';
  Result := Result + '   "" AS ID,                                    ';
  Result := Result + '   ITE_CODUNI,                                  ';
  Result := Result + '   IF(ABS(IFNULL(SUM(AIT_QTDITE), 0) - IFNULL('+fRetSumAgeilo('AIL_QTDITE') + ', 0)) = 0, "N", "S") AS MOSTRAR, ';
  Result := Result + '   CURDATE(),                                   ';
  Result := Result + '   "PRODUTOS CUBABEM MANUAL AINDA FORA DE ETIQUETAS ID" AS CHAVE , ';


  Result := Result + ' @QTDETI := IFNULL(';
  Result := Result + ' (SELECT';
  Result := Result + '   SUM(ETI_QTDITE)';
  Result := Result + ' FROM';
  Result := Result + '   ETIREC R2';
  Result := Result + '   INNER JOIN ETIRIT E2';
  Result := Result + '     ON E2.ETI_ETIREC = R2.AUTOINCREM';
  Result := Result + ' WHERE R2.ETI_CODREC = AGEREC.AUTOINCREM';
  Result := Result + '   AND E2.ETI_CODITE = CADITE.ITE_CODITE), 0) ETIQ,';

  Result := Result + '   ABS(IF(IFNULL(DIG_QTDITE, DET_QTDITE) < AIT_QTDTOT , IFNULL(DIG_QTDITE, DET_QTDITE) - IFNULL('+fRetSumAgeilo('AIL_QTDVEN') + ', 0), AIT_QTDTOT - IFNULL('+fRetSumAgeilo('AIL_QTDVEN') + ', 0))) AS ETI_QTDITE, ';
  Result := Result + '   ABS(IF(IFNULL(DIG_QTDITE, DET_QTDITE) < AIT_QTDTOT , IFNULL(DIG_QTDITE, DET_QTDITE) - IFNULL('+fRetSumAgeilo('AIL_QTDVEN') + ', 0), AIT_QTDTOT - IFNULL('+fRetSumAgeilo('AIL_QTDVEN') + ', 0)) / ' + fGetSQLTriEmbala + ' ) AS ETI_QTDEMB, ';
  Result := Result + '   0 AS REC_AUTINC,                             ';
  Result := Result + '   0 AS RIT_AUTINC,                             ';
  Result := Result + '   ITE_NIVGIR                                   ';
  Result := Result + ' FROM                                           ';
  Result := Result + '   AGEITE                                       ';
  Result := Result + '   INNER JOIN AGEREC                            ';
  Result := Result + '     ON AIT_SEQGER = AGEREC.AUTOINCREM          ';
  Result := Result + '  INNER JOIN AGEDOC                             ';
  Result := Result + '    ON ADC_SEQGER = AGEREC.AUTOINCREM           ';
  Result := Result + '  INNER JOIN MOVDET T                           ';
  Result := Result + '    ON T.DET_NUMDOC = ADC_NUMDOC                ';
  Result := Result + '    AND T.DET_ESPDOC = ADC_ESPDOC               ';
  Result := Result + '    AND T.DET_SERIE_ = ADC_SERIE_               ';
  Result := Result + '    AND T.DET_CODFOR = ADC_CODFOR               ';
  Result := Result + '    AND T.DET_CODEMP = ADC_CODEMP               ';
  Result := Result + '  INNER JOIN MOVTRI M ON M.DET_SEQGER = T.AUTOINCREM';
  Result := Result + '   LEFT JOIN DIGELE DIG ON DIG.DIG_IDEDIG = ARC_IDEDIG';
	Result := Result + '		    AND DIG.DIG_CODITE = AIT_CODITE         ';
  Result := Result + '        AND DIG.DIG_CODEMP = T.DET_CODEMP       ';
  Result := Result + '   INNER JOIN CADITE                            ';
  Result := Result + '     ON CADITE.ITE_CODITE = AIT_CODITE          ';
  Result := Result + '   INNER JOIN ITEGER G                          ';
  Result := Result + '     ON G.ITE_CODITE = AIT_CODITE               ';
  Result := Result + '    AND G.ITE_CODEMP = :CODEMP                  ';
  Result := Result + ' WHERE ARC_IDEDIG = :IDEDIG                     ';
  Result := Result + '   AND ARC_CODEMP = :CODEMP                     ';
  Result := Result + '   AND AIT_MODCUB = "M"                         ';
  Result := Result + '   AND AIT_CODITE NOT IN                        ';
  Result := Result + '   (SELECT                                      ';
  Result := Result + '     ETI_CODITE                                 ';
  Result := Result + '   FROM                                         ';
  Result := Result + '     ETIRIT                                     ';
  Result := Result + '     INNER JOIN ETIREC                          ';
  Result := Result + '       ON ETIREC.AUTOINCREM = ETIRIT.ETI_ETIREC ';
  Result := Result + '   WHERE ETIREC.ETI_CODREC = AGEREC.AUTOINCREM) ';
  Result := Result + '   GROUP BY AIT_CODITE) PROD_FORA_ETIQUETA      ';
  Result := Result + '  WHERE MOSTRAR = "S"                           ';
  If Not blnEtqCon Then
    Result := Result + '  AND ETI_QTDITE > 0                          ';
  Result := Result + ' UNION                                          ';
  Result := Result + ' ALL                                            ';
  Result := Result + ' SELECT                                         ';
  Result := Result + ' CODITE,                                        ';
  Result := Result + ' ITE_DESITE,                                    ';
  Result := Result + ' ITE_CODBAR,                                    ';
  Result := Result + ' LOCFIS,                                        ';
  Result := Result + ' STATUS,                                        ';
  Result := Result + ' ID,                                            ';
  Result := Result + ' ITE_CODUNI,                                    ';
  Result := Result + ' CURDATE(),                                     ';
  Result := Result + ' CHAVE,                                         ';
  Result := Result + ' ETIQ,                                          ';
  Result := Result + ' ETI_QTDITE,                                    ';
  Result := Result + ' ETI_QTDEMB,                                    ';
  Result := Result + ' REC_AUTINC,                                    ';
  Result := Result + ' RIT_AUTINC,                                    ';
  Result := Result + ' ITE_NIVGIR                                     ';
  Result := Result + ' FROM                                           ';
  Result := Result + ' (SELECT                                        ';
  Result := Result + '   AIT_CODITE AS CODITE,                        ';
  Result := Result + '   ITE_DESITE,                                  ';
  Result := Result + '   ITE_CODBAR,                                  ';
  Result := Result + '   "" AS LOCFIS,                                ';
  Result := Result + '   "" AS STATUS,                                ';
  Result := Result + '   "" AS ID,                                    ';
  Result := Result + '   ITE_CODUNI,                                  ';
  Result := Result + '   CURDATE(),                                   ';
  Result := Result + '   "PRODUTOS COM QUANTIDADE RESTANTE A SER LIDA" AS CHAVE, ';


  Result := Result + '  @QTDETI := IFNULL((SELECT  SUM(ETI_QTDITE) FROM ETIREC R2 ';
  Result := Result + '                   INNER JOIN ETIRIT E2 ON E2.ETI_ETIREC = R2.AUTOINCREM ';
  Result := Result + '                   WHERE R2.ETI_CODREC = AGEREC.AUTOINCREM ';
  Result := Result + '                     AND E2.ETI_CODITE = CADITE.ITE_CODITE) , 0) ETIQ, ';

  Result := Result + '  @QTDITE := (IF(IFNULL(DIG_QTDITE, 0) < AIT_QTDTOT,IFNULL(DIG_QTDITE, 0),AIT_QTDTOT) - IFNULL('+fRetSumAgeilo('AIL_QTDVEN') + ', 0) - CAST(@QTDETI AS DECIMAL(12,2)) ) AS ETI_QTDITE, ';
  Result := Result + '  ROUND(CAST(@QTDITE AS DECIMAL(12,2)) / ' + fGetSQLTriEmbala + ' , 2) AS ETI_QTDEMB, ';
  Result := Result + '   0 AS REC_AUTINC,                             ';
  Result := Result + '   0 AS RIT_AUTINC,                             ';
  Result := Result + '   ITE_NIVGIR                                   ';
  Result := Result + ' FROM                                           ';
  Result := Result + '   AGEITE                                       ';
  Result := Result + '   INNER JOIN AGEREC ON AIT_SEQGER = AGEREC.AUTOINCREM          ';
  Result := Result + '  INNER JOIN AGEDOC                             ';
  Result := Result + '    ON ADC_SEQGER = AGEREC.AUTOINCREM           ';
  Result := Result + '  INNER JOIN MOVDET T                           ';
  Result := Result + '    ON T.DET_NUMDOC = ADC_NUMDOC                ';
  Result := Result + '    AND T.DET_ESPDOC = ADC_ESPDOC               ';
  Result := Result + '    AND T.DET_SERIE_ = ADC_SERIE_               ';
  Result := Result + '    AND T.DET_CODFOR = ADC_CODFOR               ';
  Result := Result + '    AND T.DET_CODEMP = ADC_CODEMP               ';
  Result := Result + '    AND T.DET_CODITE = AIT_CODITE               ';
  Result := Result + '  INNER JOIN MOVTRI M ON M.DET_SEQGER = T.AUTOINCREM ';
  Result := Result + '   INNER JOIN CADITE ON CADITE.ITE_CODITE = AIT_CODITE ';
  Result := Result + '   INNER JOIN ITEGER G ON G.ITE_CODITE = AIT_CODITE ';
  Result := Result + '                      AND G.ITE_CODEMP = :CODEMP ';
  Result := Result + '   INNER JOIN ETIREC ON ETIREC.ETI_CODREC = AGEREC.AUTOINCREM ';
  Result := Result + '   INNER JOIN ETIRIT ON ETIRIT.ETI_ETIREC = ETIREC.AUTOINCREM ';
  Result := Result + '                    AND ETIRIT.ETI_CODITE = CADITE.ITE_CODITE ';
  Result := Result + '   LEFT JOIN DIGELE DIG                         ';
  Result := Result + '    ON DIG.DIG_IDEDIG = ARC_IDEDIG              ';
  Result := Result + '    AND DIG.DIG_CODITE = AIT_CODITE             ';
  Result := Result + '    AND DIG.DIG_CODEMP = T.DET_CODEMP           ';
  Result := Result + ' WHERE ARC_IDEDIG = :IDEDIG                     ';
  Result := Result + '   AND ARC_CODEMP = :CODEMP                     ';
  Result := Result + '   AND AIT_MODCUB = "M"                         ';
  Result := Result + '     GROUP BY AIT_CODITE) TMP                   ';
  Result := Result + '   WHERE ETI_QTDITE > 0                         ';
End;

function TfrmPlanoDeRecebimento.fGetSQLTriEmbala: String;
begin
  Result := 'IF(IFNULL(TRI_EMBALA, 0) <= 0, 1, TRI_EMBALA)';
end;

function TfrmPlanoDeRecebimento.fHaItensSemMapeamento: Boolean;
begin
  Result := False;
  cdsItens.DisableControls;
  Try
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      If fEmptyStr(fCampoTabela('AUTOINCREM', 'LOCITE', ['LCI_CODITE','LCI_CODEMP'], [cdsItens.FieldByName('CODITE').AsString, VS_strCodEmp])) Then
        Exit(True);

      cdsItens.Next;
    End;
  Finally
    cdsItens.First;
    cdsItens.EnableControls;
  End;
end;

function TfrmPlanoDeRecebimento.fProcessarEtiquetasIDAux(pgbProgresso: TCxProgressBar): Boolean;
begin
  cxgEtiquetaTableView.DataController.DataSource := nil;

  If Assigned(qryEtique) Then
    FreeAndNil(qryEtique);

  qryEtique := fCriaQuery;
  qryEtique.Close;
  qryEtique.SQL.Clear;
  qryEtique.SQL.Add(fGetSQLEtiquetasID);
  qryEtique.ParamByName('IDEDIG').AsString := strIdeDig;
  qryEtique.ParamByName('CODEMP').AsString := VS_strCodEmp;

  Try
    qryEtique.DisableControls;
    If qryEtique.Filtered Then
      qryEtique.Filtered := False;

    qryEtique.Open;

    If qryEtique.IsEmpty Then
    Begin
      If Not blnSuprimirMsgEtiquetasID Then
        fMensagem('', 'Não foram encontradas Etiquetas ID para este plano de recebimento.', ['&Ok']);
      Exit(False);
    End;

    dtsEtiquetas.DataSet := qryEtique;
    cxgEtiquetaTableView.DataController.DataSource := dtsEtiquetas;

    cdsItens.AfterScroll := nil;
    cdsItens.Filter := 'MODCUB <> ''M''';
    cdsItens.FIltered := True;

    lblExpandirRecolherEtiquetasIDClick(Self);

    Result := True;
    qryEtique.EnableControls;
    cdsItens.AfterScroll := pFiltraSugestaoCds;
  Except On
    E:Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TfrmPlanoDeRecebimento.fProcessarEtiquetasIDAux');
    End;
  End;
end;


function TfrmPlanoDeRecebimento.fSugerirLocFisicaEtiquetaID: String;
  Var
    fltQtdSugest: Real;
    blnParcial: Boolean;
    fltQtdjaSugerida: Real;

    function fQuantidadeSugeridaParaLocalizacao(strLocFisDes: String): Double;
    begin
      cdsLocSug.First;
      Result := 0;
      While not cdsLocSug.Eof Do
      Begin
        If cdsLocSug.FieldByName('LOCFIS').AsString = strLocFisDes Then
          Result := Result + cdsLocSug.FieldByName('QTDITE').AsFloat;
        cdsLocSug.Next;
      End;
    End;


    function fMontaSugestao(fltQuantidade : Double; dtaValidade : TDateTime): String;
       Var
        strLocFis : String;
        fltQtdTotVal : Double;
        fltQtdMax    : Double;
        fltQtdJaSug  : Double;
        intQtdLoc : Integer;
        intIndex  : Integer;
        strBufVen: String;
    Begin
      fltQtdMax := 0;

      //Quantidade total que precisa ser endereçada por data de validade.
      fltQtdTotVal := Trunc(fltQuantidade / cdsItens.FieldByName('EMBALA').AsFloat);

      //Quantidade que cabe na localização fisica
      Try
        fltQtdMax    := fCampoTabela('IFNULL(BAR_LASTRO,0) * IFNULL(BAR_CAMADA,0) ', 'ITEBAR', ['BAR_CODITE', 'BAR_COMPRA'], [qryEtique.FieldByName('CODITE').AsString, '1']);
      Except
        pMensagemOK('Verifique o cadastro de embalagens do item: ' + qryEtique.FieldByName('CODITE').AsString + ' é necessário ter uma embalagem principal de compras com o lastro e camada configurados');
      End;

      If fltQtdMax <= 0 Then
        fltQtdMax := fltQtdTotVal;

      //Quantidade de Localização necessário para armazenar a quantidade total da validade;
      intQtdLoc := Trunc(fltQtdTotVal / fltQtdMax);
      If (intQtdLoc = 0) then
        intQtdLoc := 1;

      //Se tem resto precisa de outra localização para colocar o resto.
      If (intQtdLoc * fltQtdMax) < fltQtdTotVal Then
        inc(intQtdLoc);

      fltQtdJaSug := 0;
      intIndex := 1;
      strBufVen := 'N';
      while intIndex <= intQtdLoc Do
      Begin
        blnParcial := false;
        If blnSugerirPicking and blnSugereLocalizacao Then
        Begin
          strBufVen := 'N';
          If (fltQtdTotVal - fltQtdJaSug ) > fltQtdMax Then
            fltQtdSugest := fltQtdMax
          Else
            fltQtdSugest := (fltQtdTotVal - fltQtdJaSug);

          strLocFis := objSugLoc.fGetLocalSugestao(fltQtdSugest < fltQtdMax, qryEtique.FieldByName('CODITE').AsString, cdsItens.FieldByName('NUMLOT').AsString);

          If (fltQtdSugest < fltQtdMax) And Assigned(qryPicking) then
          Begin
            qryPicking.First;
            blnParcial := False;
            While not qryPicking.Eof Do
            Begin
              fltQtdjaSugerida := 0;
              fltQtdjaSugerida := fQuantidadeSugeridaParaLocalizacao(qryPicking.FieldByName('LOT_LOCFIS').AsString);
              If (qryPicking.FieldByName('LOT_SALDOS').AsFloat + fltQtdjaSugerida + fltQtdSugest) <= fltQtdMax then
              Begin
                strLocFis := qryPicking.FieldByName('LOT_LOCFIS').AsString;
                strBufVen := IIf(objSugLoc.fVerificaSeTemBufferComDtaDeVencimentoMenor(qryEtique.FieldByName('CODITE').AsString, VS_StrCodEmp, dtaValidade), 'S', 'N');
                break;
              End
              Else
              begin If (qryPicking.FieldByName('LOT_SALDOS').AsFloat + fltQtdjaSugerida + fltQtdSugest) > fltQtdMax then
                If fltQtdSugest - ((qryPicking.FieldByName('LOT_SALDOS').AsFloat + fltQtdjaSugerida + fltQtdSugest) - fltQtdMax) > 0 Then
                Begin
                  strLocFis := qryPicking.FieldByName('LOT_LOCFIS').AsString;
                  fltQtdSugest := fltQtdSugest - ((qryPicking.FieldByName('LOT_SALDOS').AsFloat + fltQtdjaSugerida + fltQtdSugest) - fltQtdMax);
                  strBufVen := IIf(objSugLoc.fVerificaSeTemBufferComDtaDeVencimentoMenor(qryEtique.FieldByName('CODITE').AsString, VS_StrCodEmp, dtaValidade), 'S', 'N');
                  blnParcial := True;
                  break;
                End;
              End;
              qryPicking.Next;
            End;
          End;
        End;

        If blnParcial Then
          fltQtdJaSug := fltQtdJaSug + fltQtdSugest
        Else
        begin
          If (fltQtdTotVal - fltQtdJaSug ) > fltQtdMax Then
            fltQtdJaSug := fltQtdJaSug + fltQtdMax;

          inc(intIndex);
        End;

        If Not fEmptyStr(strLocFis) Then
          stlLocSel.Add(strLocFis);
      End;

      Result := strLocFis;
    End;

    function fMontaSugestaoBanco(strCodIte, strLocOri, strLotOri: String;fltQtdIte : Double; dtaVal: TDateTime): String;
    var
      qryAux: TUniQuery;
    begin
      Try
        qryAux := fCriaQuery;

        // Limpa 'lixo' da PRE_RESSUPRIMENTO
        qryAux.SQL.Clear;
        qryAux.SQL.Add('DELETE FROM PRE_RESSUPRIMENTO WHERE LOC_CODITE = :CODITE  AND IDSESSAO = (SELECT CONNECTION_ID())');
        qryAux.Params[0].AsString := strCodIte;
        qryAux.ExecSQL;

        // Roda procedure para trazer localizações físicas para o item e sua qtd
        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add('CALL pGeraMapaDistanciaLocalizacaoFisica(:CODITE, :CODEMP, :QTDITE, :LOCORI, :LOTORI, :PRIPIK, :ETIID)');
        qryAux.Params[0].AsString := strCodite;
        qryAux.Params[1].AsString := VS_strCodEmp;
        qryAux.Params[2].AsFloat  := fltQtdIte;
        qryAux.Params[3].AsString := strLocOri;
        qryAux.Params[4].AsString := strLotOri;
        qryAux.Params[5].AsString := IIF(blnNotasDeTransfApenasManual, '2', '3');
        qryAux.Params[6].AsString := qryEtique.FieldByName('ID').AsString;
        qryAux.ExecSQL;

        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add('SELECT * FROM PRE_RESSUPRIMENTO          ');
        qryAux.SQL.Add('WHERE LOC_CODITE = :CODITE               ');
        qryAux.SQL.Add('  AND IDSESSAO = (SELECT CONNECTION_ID())');
        //qryAux.SQL.Add('  AND TOT_OCUP_TODOS_PROD = 0            ');
        qryAux.Params[0].AsString := strCodIte;
        qryAux.Open;

        If qryAux.isEmpty Then
        Begin
          pMensagemOk('Não foram localizadas localizações físicas para esta etiqueta ID!');
          Exit('');
        End;

        qryAux.First;
        Result := qryAux.FieldByName('LOC_LOCDES').AsString;

      Finally
        FreeAndNil(qryAux);
      End;
    end;

Begin
  If blnSugestaoViaBanco Then
    Result := fMontaSugestaoBanco(qryEtique.FieldByName('CODITE').AsString, '', '', qryEtique.FieldByName('ETI_QTDITE').AsFloat, qryEtique.FieldByName('ETI_DTAVAL').AsDateTime)
  Else
    Result := fMontaSugestao(qryEtique.FieldByName('ETI_QTDITE').AsFloat, qryEtique.FieldByName('ETI_DTAVAL').AsDateTime);
End;

function TfrmPlanoDeRecebimento.fPlanoComEtiquetaPickingJaEnderecada(AStrIdeDig: String): Boolean;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('   SELECT                                  ');
    qryAux.SQL.Add('    COUNT(1) AS QTD_ETI_END                ');
    qryAux.SQL.Add('   FROM                                    ');
    qryAux.SQL.Add('    AGEITE                                 ');
    qryAux.SQL.Add('   INNER JOIN AGEREC A                     ');
    qryAux.SQL.Add('    ON A.AUTOINCREM = AIT_SEQGER           ');
    qryAux.SQL.Add('   INNER JOIN AGEILO I                     ');
    qryAux.SQL.Add('    ON I.AIL_SEQITE = AGEITE.AUTOINCREM    ');
    qryAux.SQL.Add('   WHERE ARC_IDEDIG = :IDEDIG              ');
    qryAux.SQL.Add('     AND ARC_CODEMP = :CODEMP              ');
    qryAux.SQL.Add('     AND I.AIL_ENDERE = "S"                ');
    qryAux.SQL.Add('     AND I.AIL_PICKNG = "S"                ');

    qryAux.ParamByName('CODEMP').AsString := VS_StrCodEmp;
    qryAux.ParamByName('IDEDIG').AsString := AStrIdeDig;
    qryAux.Open;

    Result := qryAux.FieldByName('QTD_ETI_END').AsInteger > 0;

  Finally
    FreeAndNil(qryAux);
  End;
End;

function TfrmPlanoDeRecebimento.fGetItensPlano: String;
var
  strItens: String;
  intRecNoBackup: Integer;
Begin
  intRecNoBackup := 0;
  Try
    strItens := '';
    If cdsItens.Filtered Then
      cdsItens.Filtered := False;

    intRecNoBackup := cdsItens.RecNo;
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      strItens := strItens + IIF(fEmptyStr(strItens),'',',') + QuotedStr(cdsItens.FieldByName('CODITE').AsString);
      cdsItens.Next;
    End;
    Result := strItens;
  Finally
    cdsItens.RecNo := intRecNoBackup;
  End;
End;

function TFrmPlanoDeRecebimento.fValidaMapeamentoDeLocalizacoes: Boolean;
var
  strItensPlano: String;
begin
  cdsItens.AfterScroll := nil;
  Try
    If Not fHaItensSemMapeamento Then
      Exit(True);

    strItensPlano := fGetItensPlano;

    If fEmptyStr(strItensPlano) Then
      Exit(True);

    Application.CreateForm(TfrmItensSemMapPlanoDeRecebimento, frmItensSemMapPlanoDeRecebimento);
    frmItensSemMapPlanoDeRecebimento.FStrItens := strItensPlano;
    frmItensSemMapPlanoDeRecebimento.fValidarItens;
    Result := frmItensSemMapPlanoDeRecebimento.FBlnValidado;
    Try
      If Not Result Then
        frmItensSemMapPlanoDeRecebimento.ShowModal;
    Finally
      Result := frmItensSemMapPlanoDeRecebimento.FBlnValidado;
      If Result Then
        fMostraItens(strIdeDig, True, False, True);

      FreeAndNil(frmItensSemMapPlanoDeRecebimento);
    End;
  Finally
    cdsItens.AfterScroll := pFiltraSugestaoCds;
  End;
End;

function TFrmPlanoDeRecebimento.fGetQtdItensSemCubagem: Integer;
begin
  Try
    cdsItens.Filter := 'MODCUB <> ''A'' AND MODCUB <> ''M'' ';
    cdsItens.Filtered := True;

    Result := cdsItens.RecordCount;
  Finally
    cdsItens.Filtered := False;
  End;
end;

function TFrmPlanoDeRecebimento.fGetSQLQuantidades(ABlnABPICK: Boolean): String;
Var
 blnTplRecClasse: Boolean;
Begin
  Result := '';
  blnTplRecClasse := fCfgSis('TPLREC', varString) = 'C';
  If Not fCfgSis('MVFEXC', varBoolean) Then
  Begin
    If Not ABlnABPICK Then
    Begin

      Result := Result + ' ABS(';
      Result := Result + ' IFNULL';
      Result := Result + ' (IF(DIG_QTDITE < AIT_QTDTOT, ';
      Result := Result + '    DIG_QTDITE - IFNULL(AIT_QTDPIK,0), ';
      Result := Result + '    AIT_QTDTOT - IFNULL(AIT_QTDPIK, 0)),';
      Result := Result + ' SUM(DET_QTDITE) - (IFNULL(AIT_QTDPIK, 0)))) / ' + fGetSQLTriEmbala + ' AS QTDITE, ';

      Result := Result + 'ABS(IFNULL (IF(DIG_QTDITE < AIT_QTDTOT, DIG_QTDITE,  AIT_QTDTOT), SUM(DET_QTDITE))) AS DET_QTDITE_TOT,';

      Result := Result + ' @DET_QTDITE := '+ fGetSQLDET_QTDITE(AblnABPICK) + 'AS DET_QTDITE, ';

      Result := Result + ' CAST(' + fGetSQLTriEmbala +' AS DECIMAL(12,2)) AS EMBREC, ';

      Result := Result + ' @QTDNOR := ABS(';
      Result := Result + '                 IF(IFNULL(DET_PROACA, "N") = "S" AND (IFNULL(DET_CODACA, "") = "" AND 1 = ' +IntToStr(intESTFLJ) + ') OR (I.ITE_REAEND = "N"),0,';
      Result := Result + '                   IF(DIG_QTDITE < AIT_QTDTOT, ';
      Result := Result + '                     DIG_QTDITE, ';
      Result := Result + '                     SUM(DET_QTDITE)';
      Result := Result + '                 ))) - IFNULL(AIT_QTDPIK, 0) AS QTDNOR,';

      // TEM LOCALIZAÇÃO ( PREFERENCIALMENTE PK) ENDEREÇADA E QTDCON = 0  = NÃO MOSTRA, TUDO FOI ENDEREÇADO!
      Result := Result + ' IF(((CAST(IFNULL(AIT_QTDPIK, 0) AS DECIMAL(12,2)) > 0) AND CAST(' + IIF(blnEtqCon, 'IFNULL(DIG_QTDITE, DET_QTDITE)', 'IFNULL(DIG_QTDITE, 0)') + '- IFNULL(AIT_QTDPIK, 0) AS DECIMAL (12, 2)) = 0) ' + IIf(blnTplRecClasse,'', IIF(blnEtqCon, '', ' OR ((ARC_NOMMOT <> "ENTRADA SIMPLIFICADA") AND IFNULL(ARC_MOVEFE,"N") = "S" AND IFNULL(DIG_QTDITE,0)=0)'))+ ',';
      Result := Result + '   "N", ';
      Result := Result + '   "S") AS EXIBIR_NO_GRID,';
    End
    Else
    Begin
      Result := Result + '  ROUND(IFNULL((SELECT SUM(IL2.AIL_QTDITE) FROM AGEILO IL2 WHERE AIL_SEQITE = E.AUTOINCREM AND AIL_PICKNG = "S") / IF(IFNULL(TRI_EMBALA, 0) <= 0,1, TRI_EMBALA), 0), 2) AS QTDITE, ';

      Result := Result + ' ABS(IFNULL (IF(DIG_QTDITE < AIT_QTDTOT, DIG_QTDITE,  AIT_QTDTOT), SUM(DET_QTDITE))) AS DET_QTDITE_TOT,';

      Result := Result + fGetSQLDET_QTDITE(ABlnABPICK) +' AS DET_QTDITE, ';

      Result := Result + '  CAST(' + fGetSQLTriEmbala + ' AS DECIMAL(12,2)) AS EMBREC, ';

      Result := Result + '  IFNULL((SELECT SUM(IL2.AIL_QTDITE) FROM AGEILO IL2 WHERE AIL_SEQITE = E.AUTOINCREM AND AIL_PICKNG = "S"), 0) AS QTDNOR, ';

      Result := Result + '  CAST("S" AS CHAR(1)) AS EXIBIR_NO_GRID,';
    End;
  End
  Else
  Begin

    Result := Result + ' ABS(';  
    Result := Result + ' IFNULL';
    Result := Result + '    (IF(DIG_QTDITE < AIT_QTDTOT,';
    Result := Result + '        DIG_QTDITE - IFNULL(AIT_QTDPIK,0),';
    Result := Result + '        AIT_QTDTOT - IFNULL(AIT_QTDPIK, 0)),';
    Result := Result + '     SUM(DET_QTDITE) - (IFNULL(AIT_QTDPIK, 0)';
    Result := Result + ' ))) / ' + fGetSQLTriEmbala + '  AS QTDITE, ';

    Result := Result + 'ABS(IFNULL (IF(DIG_QTDITE < AIT_QTDTOT, DIG_QTDITE,  AIT_QTDTOT), SUM(DET_QTDITE))) AS DET_QTDITE_TOT,';

    Result := Result + ' @DET_QTDITE := ABS(';
    Result := Result + '                   IFNULL';
    Result := Result + '                      (IF(DIG_QTDITE < AIT_QTDTOT,';
    Result := Result + '                          DIG_QTDITE - IFNULL(AIT_QTDPIK,0),';
    Result := Result + '                          AIT_QTDTOT - IFNULL(AIT_QTDPIK,0)),';
    Result := Result + '                       SUM(DET_QTDITE) - (IFNULL(AIT_QTDPIK, 0)';
    Result := Result + '                   ))) AS DET_QTDITE,';


    Result := Result + ' CAST(' + fGetSQLTriEmbala+ ' AS DECIMAL(12,2)) AS EMBREC, ';

    Result := Result + ' @QTDNOR := ABS(';
    Result := Result + '                IF(IFNULL(DET_PROACA, "N") = "S" OR (I.ITE_REAEND = "N"),0,';
    Result := Result + '                    IF(DIG_QTDITE < AIT_QTDTOT,';
    Result := Result + '                      DIG_QTDITE,';
    Result := Result + '                      SUM(DET_QTDITE)';
    Result := Result + '                ))) - IFNULL(AIT_QTDPIK, 0) AS QTDNOR,';

    If AblnABPICK Then
      Result := Result + '  CAST("S" AS CHAR(1)) AS EXIBIR_NO_GRID,'
    Else
      Result := Result + '  (IF(IFNULL(ABS(IFNULL(IFNULL(AIT_QTDITE, SUM(DET_QTDITE / ' + fGetSQLTriEmbala + ' )),DIG_QTDITE) - IFNULL(AIT_QTDPIK, 0)),0) = 0 AND IFNULL(@DET_QTDITE,0) = 0 ' + IIf(blnTplRecClasse,'', IIF(blnEtqCon, '',' OR ((ARC_NOMMOT <> "ENTRADA SIMPLIFICADA") AND IFNULL(ARC_MOVEFE,"N") = "S" AND IFNULL(DIG_QTDITE,0)=0)')) +', "N", "S")) AS EXIBIR_NO_GRID, ';
  End;
End;

function TfrmPlanoDeRecebimento.fRetClasseCheiaOuVaiExceder: String;
begin
  FQryConsulta.SQL.Clear;
  FQryConsulta.SQL.Add(' SELECT fRetClassePickingItemPlano(:CODITE, :CODEMP, :QTDITE, :INTOPC, :CLASSE ) AS CLASSE');
  FQryConsulta.ParamByName('CODITE').AsString  := cdsItens.FieldByName('CODITE').AsString;
  FQryConsulta.ParamByName('CODEMP').AsString  := VS_strCodEmp;
  FQryConsulta.ParamByName('QTDITE').AsFloat   := cdsItens.FieldByName('DET_QTDITE').AsFloat;
  FQryConsulta.ParamByName('INTOPC').AsInteger := 1;
  FQryConsulta.ParamByName('CLASSE').AsString  := cdsItens.FieldByName('CLASSE').AsString;

  FQryConsulta.Open;
  Result := FQryConsulta.FieldByName('CLASSE').AsString;
  If cdsItens.State = dsEdit Then
    cdsItens.FieldByName('CLA_CHEEXC').AsString := Result;
end;

Function TfrmPlanoDeRecebimento.fTemItemCubAutomaticaSemSugestao: Boolean;
begin
  qryItensCubAutSemSug.SQL.Clear;
  qryItensCubAutSemSug.SQL.Add('   SELECT                                                                                                        ');
  qryItensCubAutSemSug.SQL.Add('     C.ITE_CODITE, C.ITE_DESITE,                                                                                 ');
  qryItensCubAutSemSug.SQL.Add('     I.AIT_QTDITE - SUM(IFNULL(A.AIL_QTDITE, 0)) AS QTD_FALTANTE, SUM(IFNULL(A.AIL_QTDITE, 0)), I.AIT_QTDITE     ');
  qryItensCubAutSemSug.SQL.Add('   FROM                                                                                                          ');
  qryItensCubAutSemSug.SQL.Add('     AGEREC R                                                                                                    ');
  qryItensCubAutSemSug.SQL.Add('   INNER JOIN AGEITE I  ON AIT_SEQGER = R.AUTOINCREM                                                             ');
  qryItensCubAutSemSug.SQL.Add('   INNER JOIN CADITE C ON C.ITE_CODITE = I.AIT_CODITE                                                            ');
  qryItensCubAutSemSug.SQL.Add('   LEFT JOIN AGEILO A ON AIL_SEQITE = I.AUTOINCREM                                                               ');
  qryItensCubAutSemSug.SQL.Add('   WHERE TRUE                                                                                                    ');
  qryItensCubAutSemSug.SQL.Add('     AND ARC_IDEDIG = :IDEDIG                                                                                    ');
  qryItensCubAutSemSug.SQL.Add('     AND ARC_CODEMP = :CODEMP                                                                                    ');
  qryItensCubAutSemSug.SQL.Add('     AND AIT_MODCUB = "A"                                                                                        ');
  qryItensCubAutSemSug.SQL.Add('   GROUP BY I.AUTOINCREM                                                                                         ');
  qryItensCubAutSemSug.SQL.Add('   HAVING QTD_FALTANTE > 0                                                                                       ');
  qryItensCubAutSemSug.ParamByName('IDEDIG').AsString := strIdeDig;
  qryItensCubAutSemSug.ParamByName('CODEMP').AsString := VS_strCodEmp;

  qryItensCubAutSemSug.Open;
  Result := Not qryItensCubAutSemSug.IsEmpty;
End;

Procedure TfrmPlanoDeRecebimento.pMostraItensCubAutomaticaSemSugestao;
Begin
  pCriarFormularios(TfrmLog, frmLog);
  Try
    frmLog.pAddLinha('Os itens abaixo estão sem sugestão de localização física:');
    qryItensCubAutSemSug.First;
    While Not qryItensCubAutSemSug.Eof Do
    Begin
     frmLog.pAddLinha(qryItensCubAutSemSug.FieldByName('ITE_CODITE').AsString+ ' - ' + qryItensCubAutSemSug.FieldByName('ITE_DESITE').AsString + ' QUANTIDADE: ' + qryItensCubAutSemSug.FieldByName('QTD_FALTANTE').AsString);
     qryItensCubAutSemSug.Next;
    End;
    frmLog.pAddLinha('');
      frmLog.pAddLinha('Obs: defina estes itens como cubagem manual, ou clique ');
      frmLog.pAddLinha('no botão processar cubagem automática para fazer uma nova tentativa de sugestão.');
    frmLog.Caption := 'Itens sem sugestão de localização física';
    frmLog.ShowModal;
  Finally
    FreeAndNil(frmLog);
  End;
End;

function TfrmPlanoDeRecebimento.fPlanoMultIdeDig: Boolean;
var
  strNomCam: String;
begin
  strNomCam := IIF(Not fEmptyStr(edtPlaca_.Text), 'ARC_PLACA_', 'ARC_IDEDIG');
  FQryConsulta.SQL.Clear;
  FQryConsulta.SQL.Add('SELECT * FROM                        ');
  FQryConsulta.SQL.Add(' (SELECT COUNT(1) AS CNT FROM AGEREC ');
  FQryConsulta.SQL.Add('  WHERE TRUE                         ');
  FQryConsulta.SQL.Add('    AND ARC_CODEMP = :CODEMP         ');
  FQryConsulta.SQL.Add('    AND ' + strNomCam +' = :VALOR    ');
  FQryConsulta.SQL.Add(' GROUP BY ' +strNomCam                );
  FQryConsulta.SQL.Add('  ) TMP                              ');
  FQryConsulta.SQL.Add(' WHERE CNT > 1                       ');

  FQryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
  FQryConsulta.ParamByName('VALOR').AsString := IIF(Not fEmptyStr(edtPlaca_.Text), edtPlaca_.Text, edtIdeDig.Text);

  FQryConsulta.Open;
  Result := Not FQryConsulta.isEmpty;
end;

function TfrmPlanoDeRecebimento.fCampoExiste(ATabela, ACampo: String): Boolean;
var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT COUNT(1) AS QTD');
    qryConsulta.SQL.Add('FROM information_schema.COLUMNS');
    qryConsulta.SQL.Add('WHERE TABLE_SCHEMA = ' + QuotedStr(qryConsulta.Connection.DataBase));
    qryConsulta.SQL.Add('  AND TABLE_NAME = ' + QuotedStr(ATabela));
    qryConsulta.SQL.Add('  AND COLUMN_NAME = ' + QuotedStr(ACampo));
    qryConsulta.Open;
    Result := qryConsulta.FieldByName('QTD').AsInteger > 0;
  Finally
    {$IFNDEF LINUX}
      FreeAndNil(qryConsulta);
    {$ENDIF}
  End;
end;

function TfrmPlanoDeRecebimento.fValidarCamposCadIte(var strFalha: String): Boolean;
var
  stlItens: TStringList;
  blnIteAtiN,
  blnAtiComN: Boolean;
begin
  stlItens := TStringList.Create;

  If blnConfirmacaoAutomatica And cdsItens.IsEmpty Then
    Exit(False);

  Try
    cdsItens.DisableControls;
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      blnAtiComN := cdsItens.FieldByName('ATICOM').AsString = 'N';
      blnIteAtiN := cdsItens.FieldByName('ITEATI').AsString = 'N';
      If ((FTipoValidaItem in [tvAmbos, tvAtiCom]) And blnAtiComN) And (cdsItens.FieldByName('NOMMOT').AsString <> 'ENTRADA SIMPLIFICADA') Then
        stlItens.Add('Item ' + cdsItens.FieldByName('CODITE').AsString + '-' + cdsItens.FieldByName('DESITE').AsString + ' não está ATIVO PARA COMPRAS!');

      If blnIteAtiN Then
        stlItens.Add('Item ' + cdsItens.FieldByName('CODITE').AsString + '-' + cdsItens.FieldByName('DESITE').AsString + ' não está ATIVO!');

      cdsItens.Next;
    End;

    Result := stlItens.Count = 0;
    If Not Result Then
    Begin
      If frmModulo.Database.InTransaction Then
        strFalha := stlItens.CommaText
      Else
        TfrmLog.pShowLog('Itens que necessitam de atenção', stlItens);
    End;

  Finally
    cdsItens.EnableControls;
    FreeAndNil(stlItens);
  End;
end;

end.

