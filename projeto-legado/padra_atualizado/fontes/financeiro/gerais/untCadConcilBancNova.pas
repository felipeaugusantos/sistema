unit untCadConcilBancNova;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,untTBatchSQL.Helper, untTBatchSQL,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,Json,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxButtons, cxGroupBox, EditFocus,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, Data.DB,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxPC, dxDockControl, dxDockPanel, Math,
  dxGDIPlusClasses, System.ImageList, Vcl.ImgList, Datasnap.DBClient,
  cxImageComboBox, cxTextEdit, cxVGrid, cxDBVGrid, cxInplaceContainer,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGridCitel, MemDS, DBAccess,
  Uni, untLeitorOFXClass, cxCurrencyEdit, System.Types, Vcl.ComCtrls, dxCore, cxDateUtils, DateUtils,
  cxCheckBox, cxMaskEdit, cxDropDownEdit, cxCalendar, dxScreenTip, dxCustomHint,
  cxHint, UniClientDataSet, AdvMenus, untFuncoesSimples, untFuncoesRel, untFuncoesRel2,
  cxButtonEdit, System.Actions, Vcl.ActnList, untTypesSistema, StrUtils,untTLock,
  untGravandoObs, untSubjectIntf, untSubjectClass, System.Generics.Collections, untExtratoBaseClass,cxLabel,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxImageList, untLiberacao, untFechamentoFinanceiro,
  untMsgLiberacao,cxProgressBar, frxDBSet, frxExportPDF, Vcl.Mask,
  MaskEditFocus {$I skins.inc};

type
  TArrSelIDX = TArray<String>;

  TfrmCadConcilBancNova = class(TfrmPai)
    Label1: TLabel;
    btnFechar: TcxButton;
    cxGroupBox1: TcxGroupBox;
    btnSelecionarArquivo: TcxButton;
    cxGroupBox2: TcxGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtDataInicial: TEditFocus;
    edtDataFinal: TEditFocus;
    edtCodAge: TEditFocus;
    edtCodCCa: TEditFocus;
    edtPortador: TEditFocus;
    imglDiversas16: TcxImageList;
    imglPendentes: TcxImageList;
    dsPendentes: TDataSource;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    dsExtrato: TDataSource;
    cxStyle5: TcxStyle;
    cxStyle6: TcxStyle;
    btnIgnorarlan: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    HintControler: TcxHintStyleController;
    dxDockingManager1: TdxDockingManager;
    Panel4: TPanel;
    btnOpcoes: TBitBtnLocked;
    dsLancConcil: TDataSource;
    dsLanPend: TDataSource;
    grpExtrato: TcxGroupBox;
    dxDockSite1: TdxDockSite;
    dxLayoutDockSite3: TdxLayoutDockSite;
    dxLayoutDockSite1: TdxLayoutDockSite;
    dckpnlExtrato: TdxDockPanel;
    cxGroupBox4: TcxGroupBox;
    Panel3: TPanel;
    Image1: TImage;
    Label8: TLabel;
    Image2: TImage;
    Label9: TLabel;
    Image3: TImage;
    Label10: TLabel;
    grdExtrato: TcxGrid;
    grdExtratoDBTableView1: TcxGridDBTableView;
    grdExtratoDBTableView1EXT_SITUAC: TcxGridDBColumn;
    grdExtratoDBTableView1EXT_DTALAN: TcxGridDBColumn;
    grdExtratoDBTableView1EXT_CREDEB: TcxGridDBColumn;
    grdExtratoDBTableView1EXT_VALLAN: TcxGridDBColumn;
    grdExtratoDBTableView1EXT_HISTOR: TcxGridDBColumn;
    grdExtratoLevel1: TcxGridLevel;
    dckpnlPendentes: TdxDockPanel;
    cxGroupBox8: TcxGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    dtaPenIni: TcxDateEdit;
    dtaPenFin: TcxDateEdit;
    chkLancSimilares: TcxCheckBox;
    btnPesqPend: TBitBtnLocked;
    grdLancPendentes: TcxGrid;
    grdLancPendentesDBTableView1: TcxGridDBTableView;
    grdLanpenDBCTB_DTALAN: TcxGridDBColumn;
    grdLanpenDBCTB_CREDEB: TcxGridDBColumn;
    grdLanpenDBCTB_VALLAN: TcxGridDBColumn;
    grdLanpenDBCTB_HIST01: TcxGridDBColumn;
    grdLanpenDBAUTOINCREM: TcxGridDBColumn;
    grdLanpenDBCTB_SEQLAN: TcxGridDBColumn;
    grdLancPendentesLevel1: TcxGridLevel;
    cxGroupBox6: TcxGroupBox;
    btnVincular: TcxButton;
    dckpnlConcil: TdxDockPanel;
    grdLancConcil: TcxGrid;
    grdLancConcilTableView1: TcxGridDBTableView;
    grdLancConcilTableView1CTB_DTALAN: TcxGridDBColumn;
    grdLancConcilTableView1CTB_CREDEB: TcxGridDBColumn;
    grdLancConcilTableView1CTB_VALLAN: TcxGridDBColumn;
    grdLancConcilTableView1CTB_HIST01: TcxGridDBColumn;
    grdLancConcilLevel1: TcxGridLevel;
    cxGroupBox7: TcxGroupBox;
    btnDesvincular: TcxButton;
    Panel2: TPanel;
    Label16: TLabel;
    btnConfigPainel: TcxButton;
    AdvMenuStyler1: TAdvMenuStyler;
    mmnExporta: TAdvPopupMenu;
    ExportarparaPDF2: TMenuItem;
    ExportarparaExcel2: TMenuItem;
    svdConfigPanel: TSaveDialog;
    opdConfigPanel: TOpenDialog;
    btnConciliarLan: TBitBtnLocked;
    ppTelasConsulta: TAdvPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    cxStyle7: TcxStyle;
    cxGroupBox9: TcxGroupBox;
    btnAtualizarPend: TcxButton;
    cxStyle8: TcxStyle;
    btnAConciliar: TBitBtnLocked;
    cxGroupBox3: TcxGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    dtaIniExt: TcxDateEdit;
    dtaFinExt: TcxDateEdit;
    chkConciliados: TcxCheckBox;
    btnPesqExt: TBitBtnLocked;
    grpTotais: TcxGroupBox;
    Panel5: TPanel;
    Label7: TLabel;
    btnExpand: TcxButton;
    grdTotais: TcxGrid;
    grdTotaisLevel1: TcxGridLevel;
    dsTotais: TDataSource;
    grdTotaisDBBandedTableViewCitel1: TcxGridDBBandedTableView;
    grdTotaisDBBandedTableViewCitel1Column1: TcxGridDBBandedColumn;
    grdTotaisDBBandedTableViewCitel1Column2: TcxGridDBBandedColumn;
    grdTotaisDBBandedTableViewCitel1Column3: TcxGridDBBandedColumn;
    grdTotaisDBBandedTableViewCitel1Column4: TcxGridDBBandedColumn;
    grdTotaisDBBandedTableViewCitel1Column5: TcxGridDBBandedColumn;
    grdTotaisDBBandedTableViewCitel1Column6: TcxGridDBBandedColumn;
    grdTotaisDBBandedTableViewCitel1Column7: TcxGridDBBandedColumn;
    grdTotaisDBBandedTableViewCitel1Column8: TcxGridDBBandedColumn;
    grdTotaisDBBandedTableViewCitel1Column9: TcxGridDBBandedColumn;
    grdTotaisDBBandedTableViewCitel1Column10: TcxGridDBBandedColumn;
    cxStyle9: TcxStyle;
    Label11: TLabel;
    edtSalPor: TEditFocus;
    grdTotaisDBBandedTableViewCitel1Column11: TcxGridDBBandedColumn;
    grdTotaisDBBandedTableViewCitel1Column12: TcxGridDBBandedColumn;
    dxVertContainerDockSite1: TdxVertContainerDockSite;
    grdLancConcilTableView1AUTOINCREM: TcxGridDBColumn;
    grdExtratoDBTableView1AUTOINCREM: TcxGridDBColumn;
    cxButton2: TcxButton;
    cxButton3: TcxButton;
    btnRecomporLan: TBitBtnLocked;
    cxButton4: TcxButton;
    PopupMenu1: TPopupMenu;
    LanamentosdeDbito1: TMenuItem;
    pnlFundo: TPanel;
    cxStyle10: TcxStyle;
    mmnConfigPaineis: TAdvPopupMenu;
    ConfiguraesdosPainis1: TMenuItem;
    este1: TMenuItem;
    Exportarlay1: TMenuItem;
    ImportarLayout1: TMenuItem;
    RedefinirConfiguraes1: TMenuItem;
    N1: TMenuItem;
    Vinculoporhistrico1: TMenuItem;
    grdTotaisDBBandedTableViewCitel1Column13: TcxGridDBBandedColumn;
    cxLabel1: TLabel;
    edtTotalSelecionadoMB: TEditFocus;
    cxGroupBox5: TcxGroupBox;
    cxLabel2: TLabel;
    edtSelecionado: TEditFocus;
    grdPendBanco: TcxDBVerticalGrid;
    grdPendBancoCodBco: TcxDBEditorRow;
    grdPendBancoNomBco: TcxDBEditorRow;
    grdPendBancoQtdPendentes: TcxDBEditorRow;
    grdPendBancoMarcado: TcxDBEditorRow;
    btnIgnLancMB: TcxButton;
    grdLanpenDBCTB_IGNORA: TcxGridDBColumn;
    grdLanpenDBCTB_PAGCON: TcxGridDBColumn;
    grdLanpenDBCTB_ORIGEM: TcxGridDBColumn;
    grdLanpenDBCTB_CODEMP: TcxGridDBColumn;
    actPadrao: TActionList;
    ChamaTelaDetalhesPendentes: TAction;
    ChamaTelaDetalhesRelacionados: TAction;
    cxLabel3: TLabel;
    edtTotalRelacionadoMB: TEditFocus;
    btnLanAju: TcxButton;
    tmrCarregarRegistros: TTimer;
    grdExtratoDBTableView1EXT_ARQIMP: TcxGridDBColumn;
    frxExtratoBancario: TfrxReport;
    frxPDFExport1: TfrxPDFExport;
    dtsRelExtBan: TDataSource;
    frxRelExtBan: TfrxDBDataset;
    btnPrintExtBan: TcxButton;
    grdLanpenDBCTB_CODCTA: TcxGridDBColumn;
    lblCentroCusto: TLabel;
    mskCodCta: TMaskEditFocus;
    edtDesCta: TEditFocus;
    btnIgnorados: TBitBtnLocked;
    btnIgnoradosLanPen: TcxButton;
    btnImportacaoAutomatica: TcxButton;
    procedure btnFecharClick(Sender: TObject);
    procedure btnSelecionarArquivoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSairExtClick(Sender: TObject);
    procedure grdExtratoDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnPesqPendClick(Sender: TObject);
    procedure dsExtratoDataChange(Sender: TObject; Field: TField);
    procedure FormResize(Sender: TObject);
    procedure dckpnlPendentesAutoHideChanged(Sender: TdxCustomDockControl);
    procedure dckpnlConcilAutoHideChanged(Sender: TdxCustomDockControl);
    procedure dckpnlPendentesDock(Sender, Site: TdxCustomDockControl;
      ADockType: TdxDockingType; AIndex: Integer);
    procedure dckpnlConcilDock(Sender, Site: TdxCustomDockControl;
      ADockType: TdxDockingType; AIndex: Integer);
    procedure Exportarlay1Click(Sender: TObject);
    procedure este1Click(Sender: TObject);
    procedure ImportarLayout1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RedefinirConfiguraes1Click(Sender: TObject);
    procedure grdExtratoDBTableView1DragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure grdExtratoDBTableView1StartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure grdLancPendentesDBTableView1StartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure grdExtratoDBTableView1EndDrag(Sender, Target: TObject; X,
      Y: Integer);
    procedure btnOpcoesClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure grdLancPendentesDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure grdLancConcilTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnDesvincularClick(Sender: TObject);
    procedure btnVincularClick(Sender: TObject);
    procedure btnAtualizarPendClick(Sender: TObject);
    procedure grdPendBancoDblClick(Sender: TObject);
    procedure grdExtratoExit(Sender: TObject);
    procedure grdLancPendentesExit(Sender: TObject);
    procedure btnPesqExtClick(Sender: TObject);
    procedure btnIgnorarlanClick(Sender: TObject);
    procedure btnExpandClick(Sender: TObject);
    procedure btnAConciliarClick(Sender: TObject);
    procedure btnConciliarLanClick(Sender: TObject);
    procedure grdLancPendentesDBTableView1CellClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure grdLancConcilTableView1CellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure grdTotaisDBBandedTableViewCitel1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure btnImportacaoAutomaticaClick(Sender: TObject);
    procedure btnRecomporLanClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxButton4Click(Sender: TObject);
    procedure grdPendBancoStylesGetContentStyle(Sender: TObject;
      AEditProp: TcxCustomEditorRowProperties; AFocused: Boolean;
      ARecordIndex: Integer; var AStyle: TcxStyle);
    procedure Vinculoporhistrico1Click(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);
    procedure btnIgnoradosClick(Sender: TObject);
    procedure grdLancPendentesDBTableView1SelectionChanged(
      Sender: TcxCustomGridTableView);
    procedure grdExtratoDBTableView1SelectionChanged(
      Sender: TcxCustomGridTableView);
    procedure FormShow(Sender: TObject);
    procedure btnIgnLancMBClick(Sender: TObject);
    procedure ChamaTelaDetalhesPendentesExecute(Sender: TObject);
    procedure grdLanpenDBColumn5PropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure ChamaTelaDetalhesRelacionadosExecute(Sender: TObject);
    procedure grdLancConcilTableView1Column2PropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure btnLanAjuClick(Sender: TObject);
    procedure tmrCarregarRegistrosTimer(Sender: TObject);
    procedure btnPrintExtBanClick(Sender: TObject);
    procedure mskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure btnIgnoradosLanPenClick(Sender: TObject);
    function frxExtratoBancarioUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    { Private declarations }
    blnHisBan   : Boolean;
    FDragView: TcxGridDBTableView;
    FEndDragging: Boolean;
    qryExtrato: TUniQuery;
    qryLanCon: TUniQuery;
    qryLanPen: TUniQuery;
    qryPenden: TUniQuery;
    qryTotais: TUniQuery;

    strCCusto   : String;
    arrCCusto   : TConsultasArray;

    FExtBancario: TExtratoBancario;
    FBatchSQL: TBatchSQL;
    FLock: TLock;
    strGridPerdeuFoco: String;
    fltValTol: Double;

    intLancamentosSelecionados: Integer;
    dblTotalRelacionado : Double;

    ExibirMensagem: Boolean;
    objLiberacao : TLiberacao;
    AComita: Boolean;
    AFechamentoRealizado: Boolean;
    ObjFechamentoFinanceiro: TFechamentoFinanceiro;

    FMovBanAtualizado: TStringList;
    stlDetalhesDosSelecionados : TStringList;

    FSQLInsertLogCba : String;
    FVinculandoAutomaticamente: Boolean;

    function fGetNomeArquivoConfig: String;
    function TravarLancamentosExtrato: Boolean;
    procedure LimparTudoECancelar;
    function fGetNomeArquivoConfigPadrao: String;
    function fGetSql(blnCarregaArq: Boolean = True;
      blnCarregaData: Boolean =  False; blnConcil: Boolean = False; blnCarregaPeriodo: Boolean = False): String;
    function fGetSQLTotais: String;
    function fGravaExtrato(Arquivo: TOFX; strCodPor, strTipImp,
      strNomeArquivo: String): Boolean;
    function fImportaOFX(strNomeArquivo: String; strTipImp: String): Boolean;
    function fPodeSoltar(objDestino: TObject): Boolean;
    function fRetornaAutoincremMovBan(strSeqLan: String): String;
    function fRetornaPortadorCCA(var strCodCta, strAgen:String;
      strCodBco, ADigitoConta: String): String;
    function fPermiteVincular: Boolean;
    function fRetornaIndiceMarcados(ADragView: TcxGridDBTableView): TArrSelIDX;

    function fTravaIgnorarLanc: Boolean;
    function fTravaIgnorarLancMovBan: Boolean;
    function fTravaRecompLanc: Boolean;
    function fRetornaColunaValLan(ADragView: TcxGridDBTableView): TcxGridDBColumn;
    function fRetornaColunaCreDeb(ADragView: TcxGridDBTableView): TcxGridDBColumn;
    {function fVerificaExtatoImportado(Arquivo: TOFX; strNomeArquivo,
      strCodPor: String): Boolean;}
    function fVinculaExtMovBan(strAutoIncMovBan: String;
                               strAutoIncExtBan: String;
                               AQuoted: Boolean;
                               strParameter: Array of String;
                               FSubject: ISubject_ = Nil;
                               AExecute: Boolean = True;
                               pgbStatus: TcxProgressBar = nil): Boolean;
    procedure VincularLancamentos;
    function VinculandoLancamentos(pgbStatus: TcxProgressBar): Boolean;
    procedure pAtualizaTotais;
    procedure pCarregaExtrato(AExtratoBancario: TExtratoBancario);
    procedure pCarregaLanConcil;
    procedure pCarregaPendente(const dtaIni, dtaFin: TDate;
      const strCodPor: String; const fltValLan: Double = 0;
      const strCreDeb: String = '');
    procedure pCarregaRegistros;
    procedure pChamarTelaDetalhe(strSeqLan, strOrigem: String);
    function fVerificaLancamentos(const strCodPor: String; Arquivo: TOfx): TOfx;

    procedure pInserirLancamentoExtBan(Arquivo: TOFX; ofxLancamento: TOFXItem; strNomeArquivo: String; strTipImp, strCodPor: String);

    procedure AtualizandoRegistros;
    procedure pVerificaSeLancamentoAindaEstaRelacionado;
    procedure pConciliarRegistros(strExtInc: String; dteDataCon: TDate; AstrNomeArquivoImportacao: String);
    procedure pLimpaEdits;
    procedure ImportacaoOfxAutomatica;
    procedure pSelecinaLancExtratos;
    procedure pSelecionaCartoes;
    procedure pSelecionaContasReceber;
    procedure pVerificaConcilConclusao;
    function fTotalizaSelecionados(ADragView: TcxGridDBTableView): Double;
    function fTotalizaRegistros(ADragView: TcxGridDBTableView): Double;
    //Procedimentos que tentam localizar o lançamento do extrato na movimentação bancária
    //Busca as baixas autómáticas do Autban(inicialmente quando tem a tarifa configurada)
    //Na busca por boletos, primeiro procuro recebimentos análiticos no extrato(1 recebimento por boleto)
    procedure pVerificarBaixaBoletoAutbanAnalitico(const dtaIni, dtaFin: TDate; const strCodPor: String);
    //Depois busco de Forma sintética(1 recebimento para Todos os boletos
    procedure pVerificarBaixaBoletoAutbanSintetico(const dtaIni, dtaFin: TDate; const strCodPor: String);
    //Busca por histórico vinculado
    procedure pVerificarHistoricoExtrato(const dtaIni, dtaFin: TDate; const strCodPor: String);
    //Busca o lançamento por tipo/data/valor, é última que deve acontecer
    procedure pVerificarLancamentoExtrato(const dtaIni, dtaFin: TDate; const strCodPor: String;blnMarcaSomenteSimilares: Boolean = False);
    //Busca o lançamento por tipo/data/valor, é última que deve acontecer - Busca Por PagCon
    procedure pVerificarLancamentoExtratoPagCon(const dtaIni, dtaFin: TDate; const strCodPor: String;blnMarcaSomenteSimilares: Boolean = False);
    //Busca os cartões recebidos pelo pagcon da baixa
    procedure pVerificarRecCarExtrato(const dtaIni, dtaFin: TDate; const strCodPor: String);

    function ConciliarRegistrosMarcados(pgbStatus: TcxProgressBar): Boolean;
    function DesvinculandoRegistros(pgbStatus: TcxProgressBar): Boolean;
    procedure DesvincularRegistros;
    function AtualizaSituacaoExtBan(AAutoIncrems, ASituacao: String): Boolean;
    procedure ConciliaExtBanDeTodosRegistrosVinculados(AAutoIncremsMovBan, AAutoIncremExtBanSelecionado: String);

    function RetornaAutoIncremExtBan(AAutoIncremMovBan: String): String;
    function ExtratoRelacionadoComSucesso(AAutoIncren:String): Boolean;

    procedure ValidaInsercaoProInc;

    function FechamentoFinanceiroRealizado(AAutoIncrems: String; ADataConciliacao: TDateTime): Boolean;
    procedure pImprimirExtratoBancario;
    function ExisteLancamentosJaRelacionados: Boolean;

    function PortadoresDosLancamentosSaoDiferentes(AAutoIncremsMovban, AAutoIncremsExtban: String): Boolean;
    function LancamentosJaVinculados(AAutoIncremsMovban: String; AAutoincremExtBan: String): Boolean;

    function fVerificaRegistrosMarcados(pgbStatus: TcxProgressBar): Boolean;
    function fChamaSenhaVariavel(stlText: TStringList; strDirAce, strMsgSen: String): Boolean;
    function fDetalhaLancamentosSelecionados:Boolean;
    procedure pGuardaDetalhesSelecionados(strExtInc: String; dteDataCon: TDate);
    function LancamentoAjuste(var AValorAjuste: Double; var ADataLancamento: TDate; out ADatasDivergentes: Boolean): Boolean;
    function DatasSelecionadasDivergentes(AGrid: TcxGridDBTableView;
      ACampoData: String; out AData: TDate): Boolean;
    function fIdentificarExtBanSimilares(AProgressBar: TcxProgressBar): Boolean;
    function fQuantidadeMovBanSimilarPendente: Integer;
    function fQuantidadeExtBanSimilar(ACreditoDebito, ADtaLancamento, AVlrLancamento: string): Integer;
    function fTemMultiplosExtBanParaUnicoMovBan(ACreditoDebito, ADtaLancamento, AVlrLancamento: string; out AQtdMovBanPendente: Integer): Boolean;
    procedure pAtualizarExtBanSimilares;
  public
    { Public declarations }
    class procedure pMostraCarregandoExtrato(AExtratoBancario: TExtratoBancario);

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;

  End;


implementation

{$R *.dfm}

uses untGravando, untCadCtaPagar, untCadCtaReceber,
  untCadCheques, untCadMovBancario, untConsExtBanPen, untFuncoes, untConsultas,
  untOpcoesLancExtrato, untFuncFat, untInfoExt,
  untLogCba, untRelacionaHist, untDigOcorrencia, untModulo, VirtualUI_SDK,
  untMovBan, untFuncoesConsulta, untConsMovBanIgnorados,
  untFuncoesInicializarLibContasBancarias;

{*****************}
{* VALIDA CAMPOS *}
{**************RL*}
function tfrmCadConcilBancNova.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited  fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = mskCodCta) Then
    Begin
      pEdtCodSelectExit(mskCodCta, edtDesCta, arrCCusto, fRetDescCentroCusto, Nil, 'do Plano de Contas');

      If Length(arrCCusto) = 1 Then
        mskCodCta.EditMask := '99.99.999;0;_'
      Else
        mskCodCta.EditMask := '';

      If fEmptyStr(edtDesCta.Text) Then
        Result := False;
    End;
  End;


  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadConcilBancNova.btnSelecionarArquivoClick(Sender: TObject);
var
  opdArquivo: TOpenDialog;
  strNomeArquivo: String;
begin
  inherited;
  dsExtrato.OnDataChange := nil;
  strNomeArquivo := '';
  opdArquivo     := TOpenDialog.Create(nil);

  Try
    With opdArquivo Do
    Begin
      InitialDir := ExtractFileDir(Application.ExeName);
      Filter     := 'Arquivos do Tipo OFX (*.OFX)|*.ofx';
      If Execute Then
        strNomeArquivo := FileName;
    End;
  Finally
    FreeAndNil(opdArquivo);
  End;

  If strNomeArquivo <> '' Then
    fImportaOFX(strNomeArquivo, 'M')
  Else
    fMensagem('', 'Nenhum arquivo selecionado!', ['&O k']);

  dsExtrato.OnDataChange := dsExtratoDataChange;
end;

procedure TfrmCadConcilBancNova.btnConciliarLanClick(Sender: TObject);
  Var
    LGravando: TfrmGravando;
    blnTemAcesso: Boolean;
begin
  inherited;

  If grdExtratoDBTableView1.DataController.GetSelectedCount = 0 Then
  Begin
    fMensagem('Aviso', 'É necessário selecionar ao menos um lançamento para efetuar a conciliação!', ['&O k']);
    Exit;
  End;

  If fMensagem('Atenção', 'Os lançamentos selecionados serão conciliados, deseja continuar?', ['&Sim', '&Não']) = 2 Then
    Exit;

  blnTemAcesso := fVerificaAcessoSistema('CONBANOFX');

  If (Not blnTemAcesso) Then
  Begin
    If Not fDetalhaLancamentosSelecionados Then
    Begin
      pMensagemOk('Nenhum Registro Selecionado!');
      Exit;
    End;

    blnTemAcesso := fChamaSenhaVariavel(stlDetalhesDosSelecionados,
                                        'CONBANOFX',
                                        'Usuário sem acesso para efetivação da Conciliação Bancária OFX.');
  End;

  If (blnTemAcesso) Then
  Begin
    pCriarFormularios(TfrmGravando, LGravando);
    LGravando.fExecutarAcao := ConciliarRegistrosMarcados;
    LGravando.lblGravando.Caption := 'Aguarde... Conciliando registros.';
    LGravando.ShowModal;

    FreeAndNil(LGravando);
  End;

end;

procedure TfrmCadConcilBancNova.btnImportacaoAutomaticaClick(Sender: TObject);
begin
  inherited;
  ImportacaoOfxAutomatica;
end;

procedure TfrmCadConcilBancNova.cxButton2Click(Sender: TObject);
begin
  inherited;
  ApplicationEvents.OnMessage := Nil;
  pMensagemOk(' A vinculação de lançamentos da movimentação bancária, com ' +
              'lançamentos do extrato bancário, só pode ocorrer quando: ' + #13 + #13 +
              ' A soma dos lançamentos selecionados da movimentação bancária, for igual a soma dos ' +
              'lançamentos selecionados do extrato bancário.');

  ApplicationEvents.OnMessage := ApplicationEventsMessage;
end;

procedure TfrmCadConcilBancNova.cxButton3Click(Sender: TObject);
begin
  inherited;
  ApplicationEvents.OnMessage := Nil;
  pMensagemOkAltPer(' A vinculação de lançamentos do extrato bancário, com ' +
                    'lançamentos da movimentação bancária, só pode ocorrer quando:' + #13 + #13 +
                    ' A soma dos lançamentos selecionados do extrato bancário, for igual a soma dos ' +
                    'lançamentos selecionados da movimentação bancária.');

  ApplicationEvents.OnMessage := ApplicationEventsMessage;
end;

procedure TfrmCadConcilBancNova.cxButton4Click(Sender: TObject);
begin
  inherited;
  ApplicationEvents.OnMessage := Nil;

  frmInfoExt := tfrmInfoExt.Create(nil);

  frmInfoExt.ShowModal;

  FreeAndNil(frmInfoExt);

  ApplicationEvents.OnMessage := ApplicationEventsMessage;

end;

procedure TfrmCadConcilBancNova.cxButton5Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCadConcilBancNova.btnRecomporLanClick(Sender: TObject);
var
  i: Integer;
  qryAtualizar: TUniQuery;
  strAutoincrem: String;
  arrIdxSel: TArrSelIDX;
begin
  inherited;
  If grdExtratoDBTableView1.DataController.GetSelectedCount > 0 Then
  Begin
    If (grdExtratoDBTableView1.DataController.GetSelectedCount = 1)  And (grdExtratoDBTableView1.DataController.DataSet.FieldValues['EXT_SITUAC'] <> 'I')  Then
    Begin
      fMensagem('Aviso', 'Não é possível recompor lançamentos que não foram ignorados!', ['&O k']);
      Exit;
    End;

    strAutoincrem := '';
    SetLength(arrIdxSel, 0);

    arrIdxSel :=  fRetornaIndiceMarcados(grdExtratoDBTableView1);
    If fMensagem('Atenção', 'Lançamentos selecionados serão recompostos, Deseja continuar?', ['&S i m', '&N ã o']) = 1 Then
    Begin
      If fTravaRecompLanc Then
        Exit;
      dsExtrato.OnDataChange := Nil;
      for I := 0 to Length(arrIdxSel)-1 do
      Begin
        if (arrIdxSel[i] <> '') then
        Begin
          If (grdExtratoDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdExtratoDBTableView1EXT_SITUAC.Index] = 'I') Then
            strAutoincrem    := strAutoincrem + '"' + grdExtratoDBTableView1.DataController.GetRecordId(arrIdxSel[i].ToInteger())+ '",';
        End;
      End;

      strAutoincrem := Copy(strAutoincrem, 1, Length(strAutoincrem)-1);
      If strAutoincrem <> '' Then
      Begin
        qryAtualizar := fCriaQuery;
        With qryAtualizar Do
        Begin
          Sql.Text := 'UPDATE EXTBAN SET EXT_SITUAC = "N" WHERE AUTOINCREM IN ('+strAutoincrem+')';

          ExecSQL;
        End;
        FreeAndNil(qryAtualizar);
        qryExtrato.Refresh;
        pCarregaRegistros;
        btnAtualizarPend.Click;
        pAtualizaTotais;
        pVerificaConcilConclusao;
      End;
      dsExtrato.OnDataChange := dsExtratoDataChange;
    End;
  End
  Else
    fMensagem('Aviso', 'É necessário selecionar ao menos um lançamento!', ['&O k']);

end;

procedure TfrmCadConcilBancNova.btnSairExtClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCadConcilBancNova.btnPesqExtClick(Sender: TObject);
begin
  inherited;

  If Assigned(FExtBancario) Then
  Begin
    dsExtrato.OnDataChange := nil;
    qryExtrato.Close;
    qryExtrato.Sql.Clear;
    If FExtBancario.Arquivo <> '' Then
    Begin
      qryExtrato.Sql.Text := fGetSql(True, True, chkConciliados.Checked);
      qryExtrato.ParamByName('DTAINI').AsDateTime := dtaIniExt.Date;
      qryExtrato.ParamByName('DTAFIN').AsDateTime := dtaFinExt.Date;
      qryExtrato.ParamByName('ARQIMP').Value := FExtBancario.Arquivo;
      qryExtrato.ParamByName('CODBCO').Value := FExtBancario.CodBco;
      qryExtrato.ParamByName('CODPOR').Value := FExtBancario.CodPor;

    End
    Else
    Begin
      qryExtrato.Sql.Text := fGetSql(False, True, chkConciliados.Checked);
      qryExtrato.ParamByName('DTAINI').AsDateTime := dtaIniExt.Date;
      qryExtrato.ParamByName('DTAFIN').AsDateTime := dtaFinExt.Date;
      qryExtrato.ParamByName('CODBCO').Value      := FExtBancario.CodBco;
      qryExtrato.ParamByName('CODPOR').Value      := FExtBancario.CodPor;
    End;

    qryExtrato.Open;


    If chkConciliados.Checked Then
    Begin
      btnVincular.Visible := False;
      btnVincular.Enabled := False;
      btnDesvincular.Visible := False;
      btnDesvincular.Enabled := False;
      btnConciliarLan.Enabled := False;
    End
    Else
    Begin
      btnVincular.Visible := True;
      btnVincular.Enabled := True;
      btnDesvincular.Visible := True;
      btnDesvincular.Enabled := True;
      btnConciliarLan.Enabled := True;
    End;

    pCarregaRegistros;

    dsExtrato.OnDataChange := dsExtratoDataChange;

    if not TravarLancamentosExtrato then
    begin
      LimparTudoECancelar;
      Exit;
    end;
  End
  Else
  Begin
    ApplicationEvents.OnMessage := Nil;
    fMensagem('Aviso', 'É necessário carregar um extrato bancário para executar esse filtro!', ['&O k']);
    ApplicationEvents.OnMessage := ApplicationEventsMessage;
  End;
end;

procedure TfrmCadConcilBancNova.btnPesqPendClick(Sender: TObject);
begin
  inherited;
  If Not qryExtrato.IsEmpty Then
  Begin
    If (dtaPenIni.Date > dtaPenFin.Date) Then
    Begin
      fMensagem('Aviso', 'Data Inicial não pode ser maior do que a Data Final do Período!', ['&O k']);
      Exit;
    End;

    pCarregaPendente(dtaPenIni.Date,
                     dtaPenFin.Date,
                     qryExtrato.FieldByName('EXT_CODPOR').AsString,
                     qryExtrato.FieldByName('EXT_VALLAN').AsFloat,
                     qryExtrato.FieldByName('EXT_CREDEB').AsString);
  End
  Else
  Begin
    ApplicationEvents.OnMessage := Nil;
    fMensagem('Aviso', 'Sem lançamentos pendentes para o filtro informado!', ['&O k']);
    ApplicationEvents.OnMessage := ApplicationEventsMessage;
  End;
end;

procedure TfrmCadConcilBancNova.btnPrintExtBanClick(Sender: TObject);
begin
  inherited;

  If Not Assigned(dsExtrato.DataSet) Or dsExtrato.DataSet.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'È necessário selecionar ao menos um Extrato Bancário!', ['&O k']);
    Exit;
  End;

  TfrmGravando.fExecutarModalA(pImprimirExtratoBancario, 'Aguarde, Gerando Relatório ...', '');
end;

procedure TfrmCadConcilBancNova.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  inherited;
  case Msg.Message of
    WM_KEYDOWN:
    Begin
      If (Msg.wParam = VK_ESCAPE) Then
      Begin
        Msg.wParam := 0;
        Close;
      End;
    End;
  End;
end;

procedure TfrmCadConcilBancNova.AtualizandoRegistros;
var
  CountExtrato: Integer;
begin
  If (qryExtrato.RecordCount = 0) or (qryLanCon.IsEmpty) Then
  Begin
    ExibirMensagem := False;
    fMensagem('Aviso', 'É necessário ter ao menos um lançamento para selecionar!', ['&O k']);
    Exit;
  End;

  CountExtrato := qryExtrato.Recordcount;
  ExibirMensagem := True;
  qryLanCon.Refresh;
  qryExtrato.Refresh;

  if qryExtrato.Recordcount < CountExtrato then
    pCarregaRegistros;
end;

function TfrmCadConcilBancNova.AtualizaSituacaoExtBan(AAutoIncrems,
  ASituacao: String): Boolean;
  Var
    LAtualizacao: TUniQuery;
begin
  LAtualizacao := fCriaQuery;
  Try
    LAtualizacao.SQL.Text := 'UPDATE EXTBAN SET EXT_SITUAC="' + ASituacao + '" ' +
                             ' WHERE AUTOINCREM IN (' + AAutoIncrems + ')';
    LAtualizacao.ExecSQL;
    Result := True;
  Finally
    FreeAndNil(LAtualizacao);
  End;
end;

procedure TfrmCadConcilBancNova.btnAConciliarClick(Sender: TObject);
begin

  inherited;

  If edtPortador.Text <> '' Then
  Begin

    ApplicationEvents.OnMessage := Nil;

    self.Hide;

    If Assigned(prcExecutaRelatorio) Then
    begin
      prcExecutaRelatorio(168, 7300, [],
                          ['CODPOR'],
                          [Copy(edtPortador.Text, 1, 5)],
                          Sender,
                          nil,
                          True);
    End;

    self.Show;

    ApplicationEvents.OnMessage := ApplicationEventsMessage;

  End
  Else
  Begin

    ApplicationEvents.OnMessage := Nil;
    fMensagem('Aviso', 'É necessário carregar um extrato bancário para visualizar os lançamentos pendentes do portador!', ['&O k']);
    ApplicationEvents.OnMessage := ApplicationEventsMessage;

  End;
end;

procedure TfrmCadConcilBancNova.btnAtualizarPendClick(Sender: TObject);
Var
  strSQL: String;
  FExtBelEmpLogada: Boolean;
begin
  inherited;
  FExtBelEmpLogada := (fCfgSis('EXTBEL') = 'EL'); //Empresa logada

  strSQL := '';
  strSQL := strSQL + ' SELECT DISTINCT ';
  strSQL := strSQL + '   CONCAT(COUNT(E.EXT_CODBCO), " Lançamento(s)") AS QTDREG, ';
  strSQL := strSQL + '   E.EXT_CODBCO, B.BCO_NOMBCO AS NOMBCO , "N" AS MARCADO, ';
  strSQL := strSQL + '   IF(E.EXT_CODBCO IN("001", "237", "033", "748", "341", "104", "756", "041"), E.EXT_CODBCO, "000") AS BCOIMG ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   EXTBAN E ';
  strSQL := strSQL + ' JOIN CADBCO B ON B.BCO_CODBCO = E.EXT_CODBCO  ';

  If FExtBelEmpLogada Then
  Begin
    strSQL := strSQL + ' JOIN CADPOR P ON P.POR_CODPOR = E.EXT_CODPOR     ';
    strSQL := strSQL + ' JOIN CADCCA C ON C.AUTOINCREM = P.POR_CCAAUT     ';
  End;

  strSQL := strSQL + ' WHERE E.EXT_DTACON IS NULL ';
  strSQL := strSQL + ' AND E.EXT_SITUAC <> "I" ';

  If FExtBelEmpLogada Then
    strSQL := strSQL + ' AND C.CCA_CODEMP = :CODEMP ';

  strSQL := strSQL + ' GROUP BY E.EXT_CODBCO ';

  qryPenden.Close;
  qryPenden.SQL.Clear;
  qryPenden.SQL.Add(strSQL);

  If FExtBelEmpLogada Then
    qryPenden.ParamByName('CODEMP').AsString := VS_strCodEmp;

  qryPenden.Open;

  If Assigned(FExtBancario) Then
  Begin
    If qryPenden.Locate('EXT_CODBCO', FExtBancario.CodBco,[]) Then
    Begin
      qryPenden.Edit;
      qryPenden.FieldByName('MARCADO').AsString := 'S';
      qryPenden.Post;
    End;
  End;
end;

procedure TfrmCadConcilBancNova.btnVincularClick(Sender: TObject);
begin
  inherited;
  ApplicationEvents.OnMessage := Nil;

  If Not fPermiteVincular then
  Begin
    pMensagemOk(' Só é possível vincular lançamentos quando:' + #13 + #13 +
                ' A soma dos lançamentos selecionados da movimentação bancária, for igual a soma dos' +
                ' lançamentos selecionados do extrato bancário.');

    Exit;
  End Else If ExisteLancamentosJaRelacionados Then
  Begin
    pMensagemOk('Foi selecionado lançamento(s) no extrato bancário já com vínculo em uma movimentação, '+
                ' desmarque o(s) mesmo(s) ou realize o desvinculo para continuar.');
    Exit;
  End;

  qryLanPen.DisableControls;
  VincularLancamentos;
  qryLanPen.EnableControls;

  ApplicationEvents.OnMessage := ApplicationEventsMessage;
end;

procedure TfrmCadConcilBancNova.ChamaTelaDetalhesPendentesExecute(Sender: TObject);
begin
  inherited;
  pChamarTelaDetalhe(qryLanPen.FieldByName('CTB_SEQLAN').AsString,
                     qryLanPen.FieldByName('CTB_ORIGEM').AsString);
end;

procedure TfrmCadConcilBancNova.ChamaTelaDetalhesRelacionadosExecute(
  Sender: TObject);
begin
  inherited;
  pChamarTelaDetalhe(qryLanCon.FieldByName('CTB_SEQLAN').AsString,
                     qryLanCon.FieldByName('CTB_ORIGEM').AsString);
end;

procedure TfrmCadConcilBancNova.ConciliaExtBanDeTodosRegistrosVinculados(
  AAutoIncremsMovBan, AAutoIncremExtBanSelecionado: String);
  Var
    LAutoIncremsExtBan: String;

    LAtualiza: TUniQuery;
begin
  LAtualiza := fCriaQuery;

  Try
    LAutoIncremsExtBan := RetornaAutoIncremExtBan(AAutoIncremsMovBan);

    LAtualiza.SQL.Text := 'UPDATE EXTBAN SET EXT_DTACON = :DTACON, EXT_OPECON = :OPECON, EXT_HORCON = :HORCON ' +
                          ' WHERE AUTOINCREM IN (' + LAutoIncremsExtBan + ') ' +
                          '   AND EXT_DTACON IS NULL';

    LAtualiza.ParamByName('DTACON').AsDateTime := VS_Date;
    LAtualiza.ParamByName('HORCON').AsString   := FormatDateTime('hh:nn:ss', fTime());
    LAtualiza.ParamByName('OPECON').AsString   := strLoginUsuarioLogado;

    LAtualiza.ExecSQL;
  Finally
    FreeAndNil(LAtualiza);
  End;
end;

function TfrmCadConcilBancNova.ConciliarRegistrosMarcados(
  pgbStatus: TcxProgressBar): Boolean;
  var
    LConciliado: Integer;

    LDataConciliacao: TDateTime;

    LDataAtualConciliacao: Boolean;

    LRegistros: TArrSelIDX;

    LRegistroAtual: String;
    LExisteLancamentosSemVinculo: Boolean;
begin
  FMovBanAtualizado := TStringList.Create;
  FMovBanAtualizado.Delimiter := ',';
  FMovBanAtualizado.StrictDelimiter := True;
  LExisteLancamentosSemVinculo := False;

  AComita := True;
  AFechamentoRealizado := False;

  Result := False;

  Try
    LConciliado := 0;
    SetLength(LRegistros, 0);
    LRegistros := fRetornaIndiceMarcados(grdExtratoDBTableView1);

    LDataAtualConciliacao := (fCfgSis('DTACCB') <> 'S');

    LDataConciliacao := VS_Date;

    pVerificaSeLancamentoAindaEstaRelacionado;

    pgbStatus.Properties.Max := Length(LRegistros);
    pgbStatus.Position := 0;

    Try
      fStartTransaction;

      for LRegistroAtual In LRegistros do
      Begin
        if AFechamentoRealizado Then
          Break;

        if (LRegistroAtual <> '') then
        Begin
          If grdExtratoDBTableView1.DataController.Values[LRegistroAtual.ToInteger(), grdExtratoDBTableView1EXT_SITUAC.Index] = 'R' Then
          Begin

            If Not LancamentosJaVinculados('',grdExtratoDBTableView1.DataController.GetRecordId(LRegistroAtual.ToInteger())) Then
            Begin
              LExisteLancamentosSemVinculo := True;
              AComita := False;
              Break;
            End;

            Inc(LConciliado);

            If Not LDataAtualConciliacao Then
              LDataConciliacao := grdExtratoDBTableView1.DataController.Values[LRegistroAtual.ToInteger(), grdExtratoDBTableView1EXT_DTALAN.Index];

            pConciliarRegistros(grdExtratoDBTableView1.DataController.GetRecordId(LRegistroAtual.ToInteger()),
                                LDataConciliacao,
                                grdExtratoDBTableView1.DataController.Values[LRegistroAtual.ToInteger(),
                                                                             grdExtratoDBTableView1EXT_ARQIMP.Index]);

            pStepStatusGravacao(pgbStatus);
          End;
        End;
      End;

      if AComita then
      begin
        fCommit;
        qryExtrato.Refresh;
        pCarregaRegistros;
        btnAtualizarPend.Click;
        pAtualizaTotais;
        If LConciliado > 0 Then
          fMensagem('Aviso', 'Lançamentos conciliados com sucesso!', ['&O k'])
        Else
          fMensagem('Aviso', 'Não Foram encontrados lançamentos relacionados para conciliar!', ['&O k']);

        pVerificaConcilConclusao;
      end
      Else
      begin
        fRollBack;

        If LExisteLancamentosSemVinculo Then
          fMensagem('ATENÇÃO', 'Não é possível realizar a conciliação pois há lançamentos que já foram desvinculados em outra estação.' + #13 +
                               'Recarregue os dados e tente novamente.', ['&O k']);

        if AFechamentoRealizado Then
          fMensagem('ATENÇÃO!','Não será possível fazer movimentação financeira, pois existe fechamento financeiro para a empresa.', ['&Ok']);
      end;
    Except
      On e: Exception Do
      Begin
        fRollBack;
        pMensagensErro('Ocorreu o seguinte erro ao conciliar os lançamentos.' + #13 +
                       'Erro gerado: ' + e.Message, '[TfrmCadConcilBancNova.btnConciliarLanClick]');
      End;
    End;
  Finally
    FreeAndNil(FMovBanAtualizado);
  End;
end;

procedure TfrmCadConcilBancNova.btnIgnLancMBClick(Sender: TObject);
var
  i: Integer;
  qryAtualizar: TUniQuery;
  strAutoincrem,
  strMotIgn: String;
  arrIdxSel: TArrSelIDX;
begin
  inherited;
  If grdLancPendentesDBTableView1.DataController.GetSelectedCount > 0 Then
  Begin
    If (grdLancPendentesDBTableView1.DataController.GetSelectedCount = 1)  And (grdLancPendentesDBTableView1.DataController.DataSet.FieldValues['CTB_IGNORA'] = 'S') Then
    Begin
      fMensagem('Aviso', 'Lançamento já ignorado!', ['&O k']);
      Exit;
    End;

    SetLength(arrIdxSel, 0);
    strAutoincrem := '';

    arrIdxSel :=  fRetornaIndiceMarcados(grdLancPendentesDBTableView1);
    If fMensagem('Atenção', 'Lançamentos selecionados da movimentação bancária serão ignorados, Deseja continuar?', ['&S i m', '&N ã o']) = 1 Then
    Begin
      If fTravaIgnorarLancMovBan Then
        Exit;

      for I := 0 to Length(arrIdxSel)-1 do
      Begin
        if (arrIdxSel[i] <> '') then
        Begin
          If (grdLancPendentesDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdLanPenDBCTB_IGNORA.index] <> 'S') Then
            strAutoincrem := strAutoincrem + '"' + grdLancPendentesDBTableView1.DataController.GetRecordId(arrIdxSel[i].ToInteger())+ '",';
        End;
      End;

      strMotIgn := '';
      Try
        pCriarFormularios(TfrmDigOcorrencia, frmDigOcorrencia);
        frmDigOcorrencia.edtHisCom.Visible := False;

        If (frmDigOcorrencia.ShowModal = mrOk) Then
        Begin
          strMotIgn := (frmDigOcorrencia.strCodOco);
        End;
      Finally
        FreeAndNil(frmDigOcorrencia);
      End;

      if strMotIgn.IsEmpty then
      begin
        fMensagem('Aviso', 'É necessário informar um código de ocorrência para o ' + #13 +
                           ' motivo do(s) lançamento(s) serem ignorado(s)!', ['&O k']);
        Exit;
      end;

      strAutoincrem := Copy(strAutoincrem, 1, Length(strAutoincrem)-1);
      If strAutoincrem <> '' Then
      Begin
        qryAtualizar := fCriaQuery;
        With qryAtualizar Do
        Begin
          Sql.Text := ' UPDATE ' +
                      '   MOVBAN ' +
                      ' SET ' +
                      '   CTB_DTACON = :DTACON, ' +
                      '   CTB_HORCON = :HORCON, ' +
                      '   CTB_OPECON = :OPECON, ' +
                      '   CTB_IGNORA = "S",     ' +
                      '   CTB_OCOIGN = :OCOIGN  ' +
                      ' WHERE ' +
                      '   CTB_DTACON IS NULL AND ' +
                      '   AUTOINCREM IN ('+strAutoIncrem+')';

          ParamByName('DTACON').AsDateTime := VS_Date;
          ParamByName('HORCON').AsString   := FormatDateTime('hh:nn:ss', fTime());
          ParamByName('OPECON').AsString   := strLoginUsuarioLogado;
          ParamByName('OCOIGN').AsString   := strMotIgn;

          ExecSQL;

          If RowsAffected > 0 Then
          Begin
            //GRAVANDO LOG
            Close;
            Sql.Clear;
            Sql.Text := 'SELECT AUTOINCREM, CTB_SEQLAN, CTB_CODEMP FROM MOVBAN WHERE AUTOINCREM IN ('+strAutoIncrem+')';
            Open;

            If Not IsEmpty Then
            Begin
              While Not Eof Do
              Begin
                untLogCba.GravaLogCba(FieldByName('AUTOINCREM').AsString, 'IGNOROU LANÇAMENTO', self.Name);

                Next;
              End;
            End;

            Close;
          End;


        End;
        FreeAndNil(qryAtualizar);
        qryLanPen.Refresh;
        btnAtualizarPend.Click;
        pAtualizaTotais;
        pVerificaConcilConclusao;
      End;
    End;
  End
  Else
    fMensagem('Aviso', 'É necessário selecionar ao menos um lançamento!', ['&O k']);
end;

procedure TfrmCadConcilBancNova.btnIgnoradosClick(Sender: TObject);
var
  ExtBanc: TExtratoBancario;
begin
  inherited;
  Self.Hide;
  dsExtrato.OnDataChange := Nil;
  ApplicationEvents.OnMessage := Nil;
  ExtBanc := TfrmConsExtBanPen.fMostraCarregandoBanco('', '', true, true);
  ApplicationEvents.OnMessage := ApplicationEventsMessage;

  If Assigned(ExtBanc) Then
  Begin
    FreeAndNil(FExtBancario);
    FExtBancario := ExtBanc;
  End;

  If Assigned(FExtBancario) Then
  Begin
    qryExtrato.Close;
    qryExtrato.Sql.Clear;
    qryExtrato.Sql.Text := 'SELECT * FROM EXTBAN WHERE FALSE ';
    qryExtrato.Open;

    btnVincular.Visible    := True;
    btnVincular.Enabled    := True;
    btnDesvincular.Visible := True;
    btnDesvincular.Enabled := True;
    chkConciliados.Checked := False;
    btnConciliarLan.Enabled := True;

    pCarregaExtrato(FExtBancario);
    pCarregaRegistros;
    pAtualizaTotais;
  End;

  dsExtrato.OnDataChange := dsExtratoDataChange;

  Self.Show;
end;

procedure TfrmCadConcilBancNova.btnIgnoradosLanPenClick(Sender: TObject);
Var
  frmConsMovBanIgnorados: TfrmConsMovBanIgnorados;
begin
  If (qryExtrato.IsEmpty) Then
  Begin
    fMensagem('Aviso', 'Nenhum extrato selecionado!', ['&O k']);
    Exit;
  End;

  If (fEmptyStr(dtaPenIni.Text)) Then
  Begin
    fMensagem('Aviso', 'Informe a Data Inicial do Período!', ['&O k']);
    Exit;
  End;

  If (fEmptyStr(dtaPenFin.Text)) Then
  Begin
    fMensagem('Aviso', 'Informe a Data Final do Período!', ['&O k']);
    Exit;
  End;

  If (dtaPenIni.Date > dtaPenFin.Date) Then
  Begin
    fMensagem('Aviso', 'Data Inicial não pode ser maior do que a Data Final do Período!', ['&O k']);
    Exit;
  End;

  pCriarFormularios(TfrmConsMovBanIgnorados, frmConsMovBanIgnorados);

  Try
    Self.Hide;
    frmConsMovBanIgnorados.dtaIni := dtaPenIni.Date;
    frmConsMovBanIgnorados.dtaFin := dtaPenFin.Date;
    frmConsMovBanIgnorados.ShowModal;
  Finally
    Self.Show;
    btnPesqPend.Click;
    FreeAndNil(frmConsMovBanIgnorados);
  End;
end;

procedure TfrmCadConcilBancNova.btnIgnorarlanClick(Sender: TObject);
var
  i: Integer;
  qryAtualizar: TUniQuery;
  strAutoincrem: String;
  arrIdxSel: TArrSelIDX;
  LAutoincremExtrato : String;
  LRelacionado: Boolean;
begin
  inherited;

  LAutoincremExtrato := '';
  LRelacionado := False;

  If grdExtratoDBTableView1.DataController.GetSelectedCount > 0 Then
  Begin
    If (grdExtratoDBTableView1.DataController.GetSelectedCount = 1)  And (Pos(grdExtratoDBTableView1.DataController.DataSet.FieldValues['EXT_SITUAC'], 'R_I_') > 0)  Then
    Begin
      fMensagem('Aviso', 'Não é possível ignorar lançamentos relacionados ou já ignorados!', ['&O k']);
      Exit;
    End;
    strAutoincrem := '';
    SetLength(arrIdxSel, 0);

    arrIdxSel := fRetornaIndiceMarcados(grdExtratoDBTableView1);
    If fMensagem('Atenção', 'Lançamentos selecionados serão ignorados, Deseja continuar?', ['&S i m', '&N ã o']) = 1 Then
    Begin
      If fTravaIgnorarLanc Then
        Exit;

      dsExtrato.OnDataChange := nil;
      for I := 0 to Length(arrIdxSel)-1 do
      Begin
        if (arrIdxSel[i] <> '') then
        Begin
          LAutoincremExtrato := grdExtratoDBTableView1.DataController.GetRecordId(arrIdxSel[i].ToInteger());

          If ExtratoRelacionadoComSucesso(LAutoincremExtrato) Then
          Begin
            LRelacionado := True;
            Continue;
          End;

          If (Pos(grdExtratoDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdExtratoDBTableView1EXT_SITUAC.index], 'R_I_') <=  0) Then
             strAutoincrem := strAutoincrem + '"' + LAutoincremExtrato + '",';
        End;
      End;

      strAutoincrem := Copy(strAutoincrem, 1, Length(strAutoincrem)-1);
      If strAutoincrem <> '' Then
      Begin
        qryAtualizar := fCriaQuery;
        With qryAtualizar Do
        Begin
          Sql.Text := 'UPDATE EXTBAN SET EXT_SITUAC = "I" WHERE AUTOINCREM IN ('+strAutoincrem+')';

          ExecSQL;
        End;
        FreeAndNil(qryAtualizar);
        qryExtrato.Refresh;
        pCarregaRegistros;
        btnAtualizarPend.Click;
        pAtualizaTotais;
        pVerificaConcilConclusao;
      End;
      dsExtrato.OnDataChange := dsExtratoDataChange;
    End;
  End
  Else
    fMensagem('Aviso', 'É necessário selecionar ao menos um lançamento!', ['&O k']);

  If LRelacionado Then
  Begin
    fMensagem('Aviso', 'Lançamentos já relacionados não foram ignorados!', ['&O k']);
  End;

end;

procedure TfrmCadConcilBancNova.btnLanAjuClick(Sender: TObject);
var
  arrSeqLan: TStringArray;
begin
  inherited;
  If Assigned(FExtBancario) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Permitir efetuar lançamento de ajuste de saldo para o portador do extrato:');
    objLiberacao.objMsgLibera.pAddTexto(edtPortador.Text);

    objLiberacao.strDirAce := 'CONEXLANAJUPOR';
    objLiberacao.strMsgSen := 'Efetuar lançamento de ajuste de saldo para o portador do extrato';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    If objLiberacao.fLibera Then
    Begin
      self.Hide;
      ApplicationEvents.OnMessage := Nil;
      TfrmCadMovBancario.pMostraIniciandoCadastro(0, 'LANÇAMENTO DE AJUSTE DE SALDO', IncDay(qryExtrato.FieldByName('EXT_DTAINI').AsDateTime, -1), qryExtrato.FieldByName('EXT_CODPOR').AsString,
                                                  '', arrSeqLan, True);
      ApplicationEvents.OnMessage := ApplicationEventsMessage;
      self.Show;

      edtSalPor.Text := FormatFloat('R$ ###,###,##0.00', fRetSaldoAnterior(qryExtrato.FieldByName('EXT_CODPOR').AsString, qryExtrato.FieldByName('EXT_DTAINI').AsDateTime-1));
    End;
  End
  Else
  Begin
    ApplicationEvents.OnMessage := Nil;
    fMensagem('Aviso', 'É necessário carregar um extrato bancário!', ['&O k']);
    ApplicationEvents.OnMessage := ApplicationEventsMessage;
  End;
end;

procedure TfrmCadConcilBancNova.btnDesvincularClick(Sender: TObject);
begin
  inherited;
  DesvincularRegistros;
end;

procedure TfrmCadConcilBancNova.btnDesmarcaTodosClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  If grdExtratoDBTableView1.DataController.GetSelectedCount > 0 Then
  Begin
    With grdExtratoDBTableView1 Do
    Begin
      BeginUpdate();
      Controller.ClearSelection;

      For I := 0 To ViewData.RecordCount - 1 Do
        ViewData.Records[I].Selected := False;

      EndUpdate();
    End;
  End
  Else
    fMensagem('Aviso', 'Não existem lançamentos para desmarcar!', ['&O k']);

end;

procedure TfrmCadConcilBancNova.btnExpandClick(Sender: TObject);
begin
  inherited;
  If grpTotais.Height = 34 Then
  Begin
    grpTotais.Height := 120;
    btnExpand.OptionsImage.ImageIndex := 24;
    btnExpand.Caption := '&Ocultar';
  End
  Else
  Begin
    grpTotais.Height := 34;
    btnExpand.OptionsImage.ImageIndex := 25;
    btnExpand.Caption := '&Exibir';
  End;
end;

procedure TfrmCadConcilBancNova.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCadConcilBancNova.btnMarcaTodosClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  If grdExtratoDBTableView1.DataController.RecordCount > 0 Then
  Begin
    With grdExtratoDBTableView1 Do
    Begin
      BeginUpdate();

      For I := 0 To ViewData.RecordCount - 1 Do
      Begin
        if ViewData.Records[I].Expandable then
        Begin
          if ViewData.Records[I].Expanded then
            ViewData.Records[I].Selected := True;
        End
        Else ViewData.Records[I].Selected := True;

      End;

      EndUpdate();
    End;
  End
  Else
    fMensagem('Aviso', 'Não existem lançamentos para serem marcados!', ['&O k']);
end;

procedure TfrmCadConcilBancNova.btnOpcoesClick(Sender: TObject);
var
  blnEncontrouRelacionado: Boolean;
  fltValLan: Double;
  strCreDeb,
  strHistor: String;
  dteDtaLan,
  dteDtaVen: TDate;
  i, j: Integer;
  arrSeqLan: TStringArray;
  arrRecIdx: TArray<String>;
  FGravando : IObserver_;
  FSubject  : ISubject_;
  strParameter: Array of String;
  LAutoIncremExtrato:String;
  LValorAjuste: Double;
  LDataAjuste: TDate;
  LCreDebAjuste: String;
  LDatasDivergentes: Boolean;
  arrRecSelMovBan: TArray<String>;
  LAutoIncremMovBanPendentes:String;
  LUtilizouAjuste: Boolean;
begin
  FVinculandoAutomaticamente := True;
  Try
    Try
      LCreDebAjuste := EmptyStr;
      LValorAjuste := 0;
      LDataAjuste := 0;
      LUtilizouAjuste := False;

      SetLength(arrSeqLan, 0);

      If qryExtrato.RecordCount = 0 Then
      Begin
        fMensagem('Aviso', 'É necessário selecionar ao menos um lançamento!', ['&O k']);
        Exit;
      End;


      dsExtrato.OnDataChange := nil;
      If grdExtratoDBTableView1.DataController.GetSelectedCount > 0 Then
      Begin
        blnEncontrouRelacionado := False;
        fltValLan := 0;
        dteDtaLan := 0;
        dteDtaVen := 0;
        strCreDeb := '';

        SetLength(arrRecIdx, 0);
        SetLength(arrSeqLan, 0);
        SetLength(arrRecSelMovBan, 0);
        arrRecIdx := fRetornaIndiceMarcados(grdExtratoDBTableView1);
        arrRecSelMovBan := fRetornaIndiceMarcados(grdLancPendentesDBTableView1);
        for i:=0 to Length(arrRecIdx)-1 do
        Begin
          If  (Pos(grdExtratoDBTableView1.DataController.Values[arrRecIdx[i].ToInteger(), grdExtratoDBTableView1EXT_SITUAC.Index], 'I|R') > 0 ) And ( Not blnEncontrouRelacionado ) Then
          Begin
            blnEncontrouRelacionado := True;
            Break;
          End;

          If grdExtratoDBTableView1.DataController.Values[arrRecIdx[i].ToInteger(), grdExtratoDBTableView1EXT_CREDEB.Index] = 'C' Then
          Begin
            fltValLan := fltValLan + grdExtratoDBTableView1.DataController.Values[arrRecIdx[i].ToInteger(), grdExtratoDBTableView1EXT_VALLAN.Index];
          End
          Else
            fltValLan := fltValLan - grdExtratoDBTableView1.DataController.Values[arrRecIdx[i].ToInteger(), grdExtratoDBTableView1EXT_VALLAN.Index];

          If dteDtaLan = 0 Then
            dteDtaLan := grdExtratoDBTableView1.DataController.Values[arrRecIdx[i].ToInteger(), grdExtratoDBTableView1EXT_DTALAN.Index]
          Else
            If dteDtaLan > grdExtratoDBTableView1.DataController.Values[arrRecIdx[i].ToInteger(), grdExtratoDBTableView1EXT_DTALAN.Index] Then
              dteDtaLan := grdExtratoDBTableView1.DataController.Values[arrRecIdx[i].ToInteger(), grdExtratoDBTableView1EXT_DTALAN.Index];

          If dteDtaVen = 0 Then
            dteDtaVen := grdExtratoDBTableView1.DataController.Values[arrRecIdx[i].ToInteger(), grdExtratoDBTableView1EXT_DTALAN.Index]
          Else
            If dteDtaVen < grdExtratoDBTableView1.DataController.Values[arrRecIdx[i].ToInteger(), grdExtratoDBTableView1EXT_DTALAN.Index] Then
              dteDtaVen := grdExtratoDBTableView1.DataController.Values[arrRecIdx[i].ToInteger(), grdExtratoDBTableView1EXT_DTALAN.Index];

          If Pos(grdExtratoDBTableView1.DataController.Values[arrRecIdx[i].ToInteger(), grdExtratoDBTableView1EXT_HISTOR.Index], strHistor)  <= 0 Then
            strHistor := grdExtratoDBTableView1.DataController.Values[arrRecIdx[i].ToInteger(), grdExtratoDBTableView1EXT_HISTOR.Index] + ' / ' + strHistor;
        End;
        SetLength(arrRecIdx, 0);

        If blnEncontrouRelacionado Then
        Begin
           fMensagem('Aviso', 'Não é possível criar nenhum novo documento para lançamentos Totalmente relacionados ou ignorados!', ['&O k']);
           Exit;
        End;

        If fltValLan < 0  Then
        Begin
          strCreDeb := 'D';
          fltValLan := fltValLan * (-1);
        End
        Else
          strCreDeb := 'C';

        if LancamentoAjuste(LValorAjuste, LDataAjuste, LDatasDivergentes) then
        begin
          if LValorAjuste < 0.00 then
          begin
            LCreDebAjuste := 'D';
            LValorAjuste := Abs(LValorAjuste);
          end
          else
            LCreDebAjuste := 'C';
        end;

        self.Hide;
        ApplicationEvents.OnMessage := Nil;
        If grdExtratoDBTableView1.DataController.GetSelectedCount = 1 Then
        Begin
          TfrmOpcoesLancExtrato.pMostraComOpcoes(qryExtrato.FieldByName('EXT_CREDEB').Value,
                                                 qryExtrato.FieldByName('EXT_VALLAN').Value,
                                                 qryExtrato.FieldByName('EXT_HISTOR').Value,
                                                 qryExtrato.FieldByName('EXT_DTALAN').Value,
                                                 qryExtrato.FieldByName('EXT_CODPOR').Value,
                                                 dteDtaLan,
                                                 dteDtaLan,
                                                 arrSeqLan,
                                                 LUtilizouAjuste,
                                                 LValorAjuste,
                                                 LDataAjuste,
                                                 LDatasDivergentes,
                                                 LCreDebAjuste);
        End
        Else
        Begin
          TfrmOpcoesLancExtrato.pMostraComOpcoes(strCreDeb,
                                                 fltValLan,
                                                 Copy(strHistor, 1 , Length(strHistor)-1),
                                                 dteDtaLan,
                                                 qryExtrato.FieldByName('EXT_CODPOR').Value,
                                                 dteDtaLan,
                                                 dteDtaVen,
                                                 arrSeqLan,
                                                 LUtilizouAjuste,
                                                 LValorAjuste,
                                                 LDataAjuste,
                                                 LDatasDivergentes,
                                                 LCreDebAjuste);

        End;
        ApplicationEvents.OnMessage := ApplicationEventsMessage;

        self.Show;

        pAtualizarExtBanSimilares;

        If Length(arrSeqLan) > 0 Then
        Begin
          If ((grdExtratoDBTableView1.DataController.GetSelectedCount  = 1) And  (Length(arrSeqLan) >= 1)) or
             ((grdExtratoDBTableView1.DataController.GetSelectedCount >= 1) And  (Length(arrSeqLan) = 1)) Then
          Begin
            SetLength(arrRecIdx, 0);
            arrRecIdx := fRetornaIndiceMarcados(grdExtratoDBTableView1);

            FGravando := TGravandoObs.Create;
            FSubject  := TSubject.Create;
            FSubject.pAddObserver(FGravando);
            SetLength(strParameter, 4);

            //Preparando array de parametros que será responsavel pelas Notificações com o objeto observador.
            SetLength(strParameter,4);
            strParameter[0] := 'TcxProgressBar';
            strParameter[1] := IntToStr(Length(arrRecIdx));
            strParameter[2] := 'Vinculando lançamentos...';

            //Enviando Notificação que vai atualizar os observadores.
            FSubject.pNotify(strParameter);

            grdExtratoDBTableView1.DataController.DataSet.DisableControls;
            for i:=0 to Length(arrRecIdx)-1 do
            Begin
              //Atualizando os observadores
              strParameter[2] := 'Vinculando lançamentos...';
              strParameter[3] := IntToStr(i+1);
              FSubject.pNotify(strParameter);
              LAutoIncremExtrato :=  grdExtratoDBTableView1.DataController.GetRecordId(arrRecIdx[i].ToInteger());

              if arrRecIdx[i] <> '' then
              Begin
                For j:= 0 To Length(arrSeqLan)-1 Do
                Begin
                  If arrSeqLan[j] <> '' Then
                    fVinculaExtMovBan(fRetornaAutoincremMovBan(arrSeqLan[j]),LAutoIncremExtrato, True, []);

                  Application.ProcessMessages;
                End;

                // ajuste
                If ((LUtilizouAjuste) And (LValorAjuste <> 0.00)) Then
                Begin
                  For j:= 0 To Length(arrRecSelMovBan)-1 Do
                  Begin
                    If arrRecSelMovBan[j] <> '' Then
                    Begin
                      LAutoIncremMovBanPendentes := grdLancPendentesDBTableView1.DataController.GetRecordId(arrRecSelMovBan[j].ToInteger());
                      fVinculaExtMovBan(LAutoIncremMovBanPendentes,LAutoIncremExtrato, True, []);
                    End;

                    Application.ProcessMessages;
                  End;
                End;

                If qryExtrato.Locate('AUTOINCREM', LAutoIncremExtrato, []) Then
                Begin
                  If ExtratoRelacionadoComSucesso(qryExtrato.FieldByName('AUTOINCREM').AsString) Then
                  Begin
                    qryExtrato.Edit;
                    qryExtrato.FieldByName('EXT_SITUAC').AsString := 'R';
                    qryExtrato.Post;
                  End;
                End;
              End;

              grdExtratoDBTableView1.DataController.DataSet.EnableControls;

              Application.ProcessMessages;
            End;
          End;
        End;

        pVerificarBaixaBoletoAutbanAnalitico(qryExtrato.FieldByName('EXT_DTALAN').Value, qryExtrato.FieldByName('EXT_DTALAN').Value, qryExtrato.FieldByName('EXT_CODPOR').Value);
        pVerificarBaixaBoletoAutbanSintetico(qryExtrato.FieldByName('EXT_DTALAN').Value, qryExtrato.FieldByName('EXT_DTALAN').Value, qryExtrato.FieldByName('EXT_CODPOR').Value);
        pVerificarRecCarExtrato(qryExtrato.FieldByName('EXT_DTALAN').Value, qryExtrato.FieldByName('EXT_DTALAN').Value, qryExtrato.FieldByName('EXT_CODPOR').Value);
        pVerificarHistoricoExtrato(qryExtrato.FieldByName('EXT_DTALAN').Value, qryExtrato.FieldByName('EXT_DTALAN').Value, qryExtrato.FieldByName('EXT_CODPOR').Value);
        pVerificarLancamentoExtratoPagCon(qryExtrato.FieldByName('EXT_DTALAN').Value, qryExtrato.FieldByName('EXT_DTALAN').Value, qryExtrato.FieldByName('EXT_CODPOR').Value);
        pVerificarLancamentoExtrato(qryExtrato.FieldByName('EXT_DTALAN').Value, qryExtrato.FieldByName('EXT_DTALAN').Value, qryExtrato.FieldByName('EXT_CODPOR').Value);

        pAtualizaTotais;

        pCarregaRegistros;
      End
      Else
        fMensagem('Aviso', 'É necessário selecionar ao menos um lançamento!', ['&O k']);

      dsExtrato.OnDataChange := dsExtratoDataChange;
    Except
      On E: Exception Do
      Begin
        pMensagensErro('Ocorreu um erro ao vincular. ' + #13 + 'Erro gerado: ' + E.Message, '[TfrmCadConcilBancNova.btnOpcoesClick]');

        grdExtratoDBTableView1.DataController.DataSet.EnableControls;
        dsExtrato.OnDataChange := dsExtratoDataChange;
      End;
    End;
  Finally
    FVinculandoAutomaticamente := False;
  End;
end;

procedure TfrmCadConcilBancNova.dckpnlConcilAutoHideChanged(
  Sender: TdxCustomDockControl);
begin
  inherited;
  If Not dckpnlConcil.AutoHide Then
    dckpnlExtrato.Width :=  dckpnlConcil.Width+20
  Else
    dckpnlExtrato.Width :=  grpExtrato.Width-40;
end;

procedure TfrmCadConcilBancNova.dckpnlConcilDock(Sender,
  Site: TdxCustomDockControl; ADockType: TdxDockingType; AIndex: Integer);
begin
  inherited;
  If ADockType = dtBottom Then
  Begin
    dckpnlConcil.Height  := Trunc(dckpnlExtrato.Height/2);
    grdLancConcil.Margins.Top := 0;
  End;

  If ADockType = dtRight Then
  Begin
    dckpnlConcil.Width  := Trunc(dckpnlExtrato.Width/2);
    grdLancConcil.Margins.Top := 38;
  End;
end;

procedure TfrmCadConcilBancNova.dckpnlPendentesAutoHideChanged(
  Sender: TdxCustomDockControl);
begin
  inherited;
  If Not dckpnlPendentes.AutoHide Then
    dckpnlExtrato.Width :=  dckpnlPendentes.Width+20
  Else
    dckpnlExtrato.Width :=  grpExtrato.Width-40;
end;

procedure TfrmCadConcilBancNova.dckpnlPendentesDock(Sender,
  Site: TdxCustomDockControl; ADockType: TdxDockingType; AIndex: Integer);
begin
  inherited;
  If ADockType = dtBottom Then
    dckpnlPendentes.Height  := Trunc(dckpnlExtrato.Height/2);

  If ADockType = dtRight Then
    dckpnlPendentes.Width  := Trunc(dckpnlExtrato.Width/2);
end;

function TfrmCadConcilBancNova.DesvinculandoRegistros(
  pgbStatus: TcxProgressBar): Boolean;
var
  qryExclusao: TUniQuery;
  i: Integer;
  blnGravar : Boolean;
  AAutoincremRelacionado: TStringBuilder;

  LAutoIncremsExtBan: String;
begin
  inherited;

  Result := True;
  blnGravar := False;

  If ((qryExtrato.RecordCount = 0) or (qryLanCon.IsEmpty)) Then
  Begin
    fMensagem('Aviso', 'É necessário ter ao menos um lançamento para selecionar!', ['&O k']);
    Exit;
  End;

  If grdLancConcilTableView1.DataController.GetSelectedCount <= 0 Then
  Begin
    fMensagem('Aviso', 'É necessário selecionar ao menos um lançamento!', ['&Ok']);
    Exit;
  End;

  If not qryExtrato.FieldByName('EXT_DTACON').IsNull Then
  Begin
    fMensagem('Aviso', 'Este registro já foi conciliado.', ['&Ok']);
    Exit;
  End;

  dsExtrato.OnDataChange := nil;
  AAutoincremRelacionado := TStringBuilder.Create;

  Try
    If Not qryLanCon.IsEmpty Then
    Begin
      qryLanPen.DisableControls;

      pgbStatus.Properties.Max := grdLancConcilTableView1.DataController.DataSet.RecordCount;
      pgbStatus.Position := 0;


      If fMensagem('Atenção', 'Confirma a desvinculação dos lançamentos selecionados?', ['&S i m', '&N ã o']) = 1 Then
      Begin
        TfrmGravando.fExecutarModal(AtualizandoRegistros, 'Aguarde... Atualizando Registros.', '');

        blnGravar := True;
        If ((qryExtrato.RecordCount = 0) or (qryLanCon.IsEmpty)) And (ExibirMensagem) Then
        Begin
          fMensagem('Aviso', 'É necessário ter ao menos um lançamento para selecionar!', ['&O k']);
          Exit;
        End
        Else If grdLancConcilTableView1.DataController.GetSelectedCount <= 0 Then
        Begin
          fMensagem('Aviso', 'É necessário selecionar ao menos um lançamento!', ['&Ok']);
          Exit;
        End;

        for I := 0 to grdLancConcilTableView1.DataController.DataSet.RecordCount - 1 do
        begin
          if AAutoincremRelacionado.Length > 0 then
            AAutoincremRelacionado.Append(', ');

          AAutoincremRelacionado.Append(QuotedStr(
           grdLancConcilTableView1.DataController.Values[i, grdLancConcilTableView1AUTOINCREM.Index]
           ));

          pStepStatusGravacao(pgbStatus);
        end;

        qryExclusao := fCriaQuery;

        pgbStatus.Properties.Max := 3;
        pgbStatus.Position := 0;

        LAutoIncremsExtBan := RetornaAutoIncremExtBan(AAutoincremRelacionado.ToString); // #1
        pStepStatusGravacao(pgbStatus);

        fStartTransaction;
        Try
          AtualizaSituacaoExtBan(LAutoIncremsExtBan, 'N'); // #2
          pStepStatusGravacao(pgbStatus);

          qryExclusao.Sql.Clear;
          qryExclusao.Sql.Text := 'DELETE FROM BANEXR WHERE EXR_BANINC IN ( '+ AAutoincremRelacionado.ToString + ' ) ';  // #3
          qryExclusao.ExecSql;
          pStepStatusGravacao(pgbStatus);

        Except
          On e: Exception Do
          Begin
            blnGravar := False;
            fRollBack;
            pMensagensErro('Ocorreu o seguinte erro ao desvincular os lançamentos: '+#13+'Erro:'+e.Message, '[TfrmCadConcilBancNova.btnDesvincularClick]');
          End;
        End;

        FreeAndNil(qryExclusao);

        If blnGravar then
          fCommit
         else
          Exit;

        qryExtrato.Refresh;
        pVerificarLancamentoExtrato(qryExtrato.FieldByName('EXT_DTALAN').Value, qryExtrato.FieldByName('EXT_DTALAN').Value, qryExtrato.FieldByName('EXT_CODPOR').Value, True);

        pAtualizarExtBanSimilares;

        pCarregaRegistros;
        pAtualizaTotais;
      End;

      qryLanPen.EnableControls;
    End;
  Finally
    dsExtrato.OnDataChange := dsExtratoDataChange;

    if blnGravar then
      fMensagem('Aviso', 'Lançamentos desvinculados com sucesso!', ['&O k']);

    FreeAndNil(AAutoincremRelacionado);
  End;
end;

procedure TfrmCadConcilBancNova.DesvincularRegistros;
  Var
    LGravando : TfrmGravando;
begin
  pCriarFormularios(TfrmGravando, LGravando);
  Try
    LGravando.fExecutarAcao := DesvinculandoRegistros;
    LGravando.lblGravando.Caption := 'Aguarde... Desvinculando Lançamentos.';
    LGravando.ShowModal;
  Finally
    FreeAndNil(LGravando);
  End;
end;

procedure TfrmCadConcilBancNova.dsExtratoDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  tmrCarregarRegistros.Enabled := False;
  tmrCarregarRegistros.Enabled := True;
end;

procedure TfrmCadConcilBancNova.este1Click(Sender: TObject);
begin
  inherited;
  Try
    dxDockingManager1.SaveLayoutToIniFile(fGetNomeArquivoConfig);
  Except
    On e: Exception Do
    Begin
      fMensagem('Aviso', 'Ocorreu o seguinte erro ao tentar salvar o layout dos painéis!'+#13+'Erro: '+ e.Message, ['O k']);
      Exit;
    End;
  End;

  fMensagem('Aviso', 'Configuração do layout dos painéis salva com sucessos!', ['O k']);
end;

function TfrmCadConcilBancNova.ExisteLancamentosJaRelacionados: Boolean;
var
  i: Integer;
  arrRecIdx: TArray<String>;
begin
  inherited;
  Result := False;

  SetLength(arrRecIdx, 0);

  arrRecIdx := fRetornaIndiceMarcados(grdExtratoDBTableView1);

  For I := 0 To Length(arrRecIdx)-1 Do
  Begin
    if (arrRecIdx[i] <> '') then
    Begin
      If grdExtratoDBTableView1.DataController.Values[arrRecIdx[i].ToInteger, grdExtratoDBTableView1EXT_SITUAC.Index] = 'R' Then
        Result := True;
    End;
  End;

end;

procedure TfrmCadConcilBancNova.Exportarlay1Click(Sender: TObject);
begin
  inherited;
  With svdConfigPanel Do
  Try
    Filter   := 'Ini Files (*.ini)|*.ini';
    FileName := 'Paineis_Config_'+ strLoginUsuarioLogado+'.ini';
    If Execute Then
    Begin
      Try
        dxDockingManager1.SaveLayoutToIniFile(FileName);
      Except
        On e: Exception Do
        Begin
          fMensagem('Aviso', 'Ocorreu o seguinte erro ao tentar exportar o layout dos painéis!'+ #13 + 'Erro: '+ e.Message, ['O k']);
          Exit;
        End;
      End;
      fMensagem('Aviso', 'Layout dos painéis exportado com sucesso!', ['O k']);
    End
  Finally
    Free;
  End;
end;

function TfrmCadConcilBancNova.FechamentoFinanceiroRealizado(
  AAutoIncrems: String; ADataConciliacao: TDateTime): Boolean;
  Var
    LRegistros: TUniQuery;
begin
  Result := False;

  If AAutoIncrems.IsEmpty Then
    Exit;

  Try
    LRegistros := fCriarQuery('SELECT CTB_CODEMP ' +
                              ' FROM MOVBAN ' +
                              ' WHERE AUTOINCREM IN (' + AAutoIncrems + ') ' +
                              ' GROUP BY CTB_CODEMP');

    LRegistros.Open;

    While Not LRegistros.Eof Do
    Begin
      Result := objFechamentoFinanceiro.FechamentoFinanceiroJaRealizado(LRegistros.FieldByName('CTB_CODEMP').AsString,
                                                                        ADataConciliacao,
                                                                        False);

      If Result Then
        Break;

      LRegistros.Next;
    End;
  Finally
    FreeAndNil(LRegistros);
  End;

end;

function TfrmCadConcilBancNova.ExtratoRelacionadoComSucesso(
  AAutoIncren: String): Boolean;
  Var
    LBanExr : TUniQuery;
begin
  Result := False;
  Try
    Try
      LBanExr := fCriaQuery(Nil);
      LBanExr.Close;
      LBanExr.Sql.Clear;
      LBanExr.Sql.Add('SELECT EXR_EXTINC FROM BANEXR WHERE EXR_EXTINC = :EXTINC ');
      LBanExr.ParamByName('EXTINC').AsString := AAutoIncren;
      LBanExr.Open;
      Result := Not LBanExr.IsEmpty;
    Except
      On E : Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LBanExr);
  End;
end;

function TfrmCadConcilBancNova.fGetNomeArquivoConfig: String;
begin
  Result := ExtractFilePath(Application.exeName) + '\'+Self.Name+'_'+'Paineis_Config_'+ strLoginUsuarioLogado+'.ini';
end;

function TfrmCadConcilBancNova.fGetNomeArquivoConfigPadrao: String;
begin
  Result := ExtractFilePath(Application.exeName) + '\'+Self.Name+'_'+'Paineis_Config_Padrao.ini';
end;

function TfrmCadConcilBancNova.fGetSql(blnCarregaArq: Boolean = True;
  blnCarregaData: Boolean =  False; blnConcil: Boolean = False;
  blnCarregaPeriodo: Boolean = False): String;
begin
  If Not blnCarregaPeriodo Then
  Begin
    If blnCarregaData  And Not blnCarregaArq Then
    Begin
      Result := 'SELECT                               '+
                '  (SELECT                            '+
                '    MIN(EXT_DTALAN)                  '+
                '  FROM                               '+
                '    EXTBAN                           '+
                '  WHERE EXT_CODBCO = :CODBCO         '+
                '    AND EXT_CODPOR = :CODPOR         '+
                '    AND EXT_DTALAN BETWEEN :DTAINI   '+
                '    AND :DTAFIN) AS EXT_DTAINI,      '+
                '  (SELECT                            '+
                '    MAX(EXT_DTALAN)                  '+
                '  FROM                               '+
                '    EXTBAN                           '+
                '  WHERE EXT_CODBCO = :CODBCO         '+
                '    AND EXT_CODPOR = :CODPOR         '+
                '    AND EXT_DTALAN BETWEEN :DTAINI   '+
                '    AND :DTAFIN) AS EXT_DTAFIN,      '+
                '  EXTBAN.*                           '+
                'FROM                                 '+
                '  EXTBAN                             '+
                'WHERE EXT_CODBCO = :CODBCO           '+
                '  AND EXT_CODPOR = :CODPOR           '+
                ' AND                                 ';
    End
    Else
      Result := ' SELECT               ' +
                '   (SELECT MIN(EXT_DTALAN) FROM EXTBAN WHERE EXT_ARQIMP = :ARQIMP) AS EXT_DTAINI,  ' +
                '   (SELECT MAX(EXT_DTALAN) FROM EXTBAN WHERE EXT_ARQIMP = :ARQIMP) AS EXT_DTAFIN,  ' +
                '   EXTBAN.*           ' +
                ' FROM                 ' +
                '   EXTBAN             ' +
                ' WHERE EXT_CODBCO = :CODBCO AND EXT_CODPOR = :CODPOR AND ' ;
  End
  Else
  Begin
    Result := ' SELECT               ' +
              '   (SELECT MIN(EXT_DTALAN) FROM EXTBAN WHERE EXT_DTALAN IN (DTALAN_)) AS EXT_DTAINI,  ' +
              '   (SELECT MAX(EXT_DTALAN) FROM EXTBAN WHERE EXT_DTALAN IN (DTALAN_)) AS EXT_DTAFIN,  ' +
              '   EXTBAN.*           ' +
              ' FROM                 ' +
              '   EXTBAN             ' +
              ' WHERE EXT_CODBCO = :CODBCO AND EXT_CODPOR = :CODPOR AND ' ;
  End;

  If blnCarregaArq Then
     Result := Result + '  EXT_ARQIMP = :ARQIMP ';

  If blnCarregaPeriodo Then
  Begin
    If blnCarregaArq Then
      Result := Result + ' AND ';

    Result := Result + '  EXT_DTALAN IN (DTALAN_) ';
  End
  Else If blnCarregaData Then
  Begin
    If blnCarregaArq Then
      Result := Result + ' AND ';

    Result := Result + '  EXT_DTALAN BETWEEN :DTAINI AND :DTAFIN ';
  End;

  If blnConcil Then
  Begin
    If blnCarregaArq or blnCarregaData Or blnCarregaPeriodo Then
      Result := Result + ' AND ';

    Result := Result + '  EXT_DTACON IS NOT NULL   '
  End
  Else
  Begin
    If blnCarregaArq or blnCarregaData Or blnCarregaPeriodo Then
      Result := Result + ' AND ';

    Result := Result + '  EXT_DTACON IS NULL ';
  End;

  Result := Result + ' ORDER BY EXT_DTALAN ASC ';
end;

function TfrmCadConcilBancNova.fGetSQLTotais: String;
begin
  Result := ' SELECT  ' +
            '   (SUM(IF((EXT_SITUAC = "R") AND (EXT_DTACON IS NULL), If(EXT_CREDEB = "C", EXT_VALLAN, -EXT_VALLAN), 0))) AS REL_TOTAL, ' +
            '   (SUM((EXT_SITUAC = "R") AND (EXT_DTACON IS NULL))) AS REL_QTDE, ' +
            '   (SUM(IF((EXT_SITUAC = "R") AND (EXT_DTACON IS NOT NULL), If(EXT_CREDEB = "C", EXT_VALLAN, -EXT_VALLAN), 0))) AS CON_TOTAL, ' +
            '   (SUM((EXT_SITUAC = "R") AND (EXT_DTACON IS NOT NULL))) AS CON_QTDE, ' +
            '   (SUM(IF(EXT_SITUAC IN ("S", "A"), If(EXT_CREDEB = "C", EXT_VALLAN, -EXT_VALLAN), 0))) AS SIM_TOTAL, ' +
            '   (SUM(EXT_SITUAC IN ("S", "A"))) AS SIM_QTDE, ' +
            '   (SUM(IF(EXT_SITUAC = "N", If(EXT_CREDEB = "C", EXT_VALLAN, -EXT_VALLAN), 0))) AS NRL_TOTAL, ' +
            '   (SUM(EXT_SITUAC = "N")) AS NRL_QTDE, ' +
            '   (SUM(IF(EXT_SITUAC = "I", If(EXT_CREDEB = "C", EXT_VALLAN, -EXT_VALLAN), 0))) AS IGN_TOTAL, ' +
            '   (SUM(EXT_SITUAC = "I")) AS IGN_QTDE, ' +
            '   (SUM(IF(EXT_CREDEB = "C", EXT_VALLAN, -EXT_VALLAN))) AS EXT_TOTAL, ' +
            '   (COUNT(AUTOINCREM)) AS EXT_QTDE,  ' +
            '    0.00 As Saldo_Total ' +
            ' FROM EXTBAN ';
end;

function TfrmCadConcilBancNova.fGravaExtrato(Arquivo: TOFX;
  strCodPor, strTipImp, strNomeArquivo: String): Boolean;
var
 Item: TOFXItem;
 i: Integer;
 FGravando : IObserver_;
 FSubject  : ISubject_;
 strParameter : Array of String;
 ofxArqNor: TOFX;
begin
  Result := False;
  If Assigned(Arquivo) Then
  Begin
    i := 1;
    FGravando := TGravandoObs.Create;
    FSubject  := TSubject.Create;
    FSubject.pAddObserver(FGravando);
    SetLength(strParameter, 4);

    //Preparando array de parametros que será responsavel pelas Notificações com o objeto observador.
    SetLength(strParameter,4);
    strParameter[0] := 'TcxProgressBar';
    strParameter[1] := IntToStr(Arquivo.Movimentacoes.Count);
    strParameter[2] := 'Salvando Informações do Arquivo OFX...';

    //Enviando Notificação que vai atualizar os observadores.
    FSubject.pNotify(strParameter);

    //Caso o extrato seja referente a um período já importado, comparo os lançamentos
    //um a um, para que sejam importados apenas lançamentos que não existiam no
    //extrato anterior.
    ofxArqNor := fVerificaLancamentos(strCodPor, Arquivo);

    If Assigned(ofxArqNor) Then
      Arquivo := OfxArqNor;

    fStartTransaction;

    Try
      If Arquivo.Movimentacoes.Count > 0 Then
      Begin
        With Arquivo Do
        Begin
          For Item in Movimentacoes Do
          Begin
            //Atualizando os observadores
            strParameter[3] := IntToStr(i);
            FSubject.pNotify(strParameter);

            pInserirLancamentoExtBan(Arquivo, Item, strNomeArquivo, strTipImp, strCodPor);

            Inc(i);
          End;
        End;

        fCommit;

        Finalize(strParameter);
        Result := True;
      End
      Else
      Begin
        fRollBack;
        Finalize(strParameter);
        fMensagem('Aviso', 'Arquivo sem movimentação ou lançamentos já importados!', ['&O k']);
      End;
    Except
      On e: Exception Do
      Begin
        fRollBack;
        Finalize(strParameter);
        pMensagensErro('Não foi possível salvar os dados do extrato! '+ #13+ 'Erro: ' + e.Message, '[TfrmCadConcilBancNova.fGravaExtrato]');
      End;
    End;
  End;
end;

function TfrmCadConcilBancNova.fImportaOFX(strNomeArquivo: String; strTipImp: String): Boolean;
var
  strCodPor, strCodCta, strAgen, strMensagem: String;
  LeitorOFX: TLeitorOFX;
  blnGravouExtrato: Boolean;
  LChaveLckImp: String;
  LLockImportacao: TLock;
begin
  Result := False;
  If strNomeArquivo <> '' Then
  Begin
    LeitorOFX  := TLeitorOFX.Create;
    dsExtrato.OnDataChange := nil;
    FVinculandoAutomaticamente := True;
    LLockImportacao := Nil;
    Try
      Try
        pnlFundo.Enabled  := False;
        pnlBotoes.Enabled := False;
        If LeitorOFX.fProcessarArquivo(strNomeArquivo) Then
        Begin
          With  LeitorOFX.Arquivo Do
          Begin
            qryExtrato.Close;
            qryExtrato.Sql.Clear;
            qryExtrato.Sql.Text := 'SELECT * FROM EXTBAN WHERE FALSE ';
            qryExtrato.Open;

            qryLanCon.Close;
            qryLanPen.Close;
            qryTotais.Close;

            btnVincular.Visible    := True;
            btnVincular.Enabled    := True;
            btnDesvincular.Visible := True;
            btnDesvincular.Enabled := True;
            chkConciliados.Checked := False;
            btnConciliarLan.Enabled := True;

            strCodPor := '';
            strCodCta := ContaPelaChaveOFX;
            strAgen   := AgenciaID;
            strCodPor := fRetornaPortadorCCA(strCodCta, strAgen, BancoID, DigitoContaID);

            If fEmptyStr(strCodPor) Then
            Begin
              If strAgen <> '' Then
                 StrMensagem := ' a agência ' + strAgen + ' e ';

              StrMensagem := StrMensagem + ' conta ' + strCodCta;

              fMensagem('Aviso', 'Para ' + strMensagem + ' do(a) '+ fRetNomBanco(BancoID) +'('+BancoID+')'+ ' do arquivo selecionado, não foi encontrado portador vinculado!', ['&O k']);
              pnlFundo.Enabled  := True;
              pnlBotoes.Enabled := True;

              Self.BringToFront;
              Exit;
            End;

            LLockImportacao := TLock.Create;
            LChaveLckImp := 'IMPORTACAO_OFX_' + BancoID + '_' + strAgen + '_' + strCodCta;
            If Not LLockImportacao.fLock_Unlock(LChaveLckImp, True, False, False, '', False, '') Then
            Begin
              fMensagem('ATENÇÃO',
                'Já existe uma importação de extrato em andamento para o banco ' +
                BancoID + ', agência ' + strAgen + ', conta ' + strCodCta + '.' + sLineBreak +
                'Estação responsável: ' + fGetHostLock(LChaveLckImp) + '.' + sLineBreak +
                'Aguarde a finalização antes de importar novamente.',
                ['&Ok']);
              LChaveLckImp := '';
              pnlFundo.Enabled  := True;
              pnlBotoes.Enabled := True;
              Self.BringToFront;
              Exit;
            End;

            ContaId   := strCodCta;
            AgenciaID := strAgen;

            If Assigned(FExtBancario) Then
              FreeAndNil(FExtBancario);

            FExtBancario := TExtratoBancario.Create;

            FExtBancario.DataInicial :=  LeitorOFX.Arquivo.DataInicial;
            FExtBancario.DataFinal   :=  LeitorOFX.Arquivo.DataFinal;
            FExtBancario.CodBco      :=  LeitorOFX.Arquivo.BancoID;
            FExtBancario.Arquivo     :=  ExtractFilename(strNomeArquivo);
            FExtBancario.CodPor      :=  strCodpor;

            blnGravouExtrato := fGravaExtrato(LeitorOFX.Arquivo, strCodPor, strTipImp, ExtractFilename(strNomeArquivo));

            pCarregaExtrato(FExtBancario);
          End;

          If blnGravouExtrato Then
          Begin
            //Verificar sempre lançamentos agrupados(Cartão, Boleto), os que sobrarem procuro pela regra padrão
            pVerificarBaixaBoletoAutbanAnalitico(LeitorOFX.Arquivo.DataInicial, LeitorOFX.Arquivo.DataFinal, strCodPor);
            pVerificarBaixaBoletoAutbanSintetico(LeitorOFX.Arquivo.DataInicial, LeitorOFX.Arquivo.DataFinal, strCodPor);
            pVerificarRecCarExtrato(LeitorOFX.Arquivo.DataInicial, LeitorOFX.Arquivo.DataFinal, strCodPor);
            pVerificarHistoricoExtrato(LeitorOFX.Arquivo.DataInicial, LeitorOFX.Arquivo.DataFinal, strCodPor);
            pVerificarLancamentoExtratoPagCon(LeitorOFX.Arquivo.DataInicial, LeitorOFX.Arquivo.DataFinal, strCodPor);
            pVerificarLancamentoExtrato(LeitorOFX.Arquivo.DataInicial, LeitorOFX.Arquivo.DataFinal, strCodPor);
          End;

          pCarregaRegistros;

          If blnGravouExtrato Then
          Begin
            RenameFile(strNomeArquivo,StringReplace(strNomeArquivo.ToUpper, '.OFX', '.IMP', []));
            fMensagem('Aviso', 'Extrato Bancário Importado Com Sucesso!', ['&O K']);
          End;

          Result := True;
        End;
        pnlFundo.Enabled  := True;
        pnlBotoes.Enabled := True;

        Self.BringToFront;
      Except
        On e: Exception Do
        Begin
          pnlFundo.Enabled  := True;
          pnlBotoes.Enabled := True;
          Self.BringToFront;
          pMensagensErro('Ocorreu o seguinte erro ao tentar ler o arquivo OFX: ' + #13 + 'Erro: ' + e.Message, '[TfrmCadConcilBancNova.fImportaOFX]');
        End;
      End;
    Finally
      If Assigned(LLockImportacao) Then
      Begin
        LLockImportacao.pDestravaChave(LChaveLckImp);
        FreeAndNil(LLockImportacao);
      End;
      FVinculandoAutomaticamente := False;
      dsExtrato.OnDataChange := dsExtratoDataChange;
      FreeAndNil(LeitorOFX);
    End;
  End;
  btnAtualizarPend.Click;
  pAtualizaTotais;
  pnlFundo.Enabled  := True;
  pnlBotoes.Enabled := True;

  Self.BringToFront;
end;

procedure TfrmCadConcilBancNova.FormActivate(Sender: TObject);
begin
  inherited;

  If Not untFuncoesSimples.blnUsuarioLogadoUtilizaModoClassico Then //MF: 298369 - 04/08/23
    Self.Top := 0;
end;

procedure TfrmCadConcilBancNova.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  if Assigned(FLock) then
    FLock.pDestravarTodos;

  If Assigned(FExtBancario) Then
    FreeAndNil(FExtBancario);

  If Assigned(FBatchSQL) Then
    FreeAndNil(FBatchSQL);

  If Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  FreeAndNil(qryExtrato);
  FreeAndNil(stlDetalhesDosSelecionados);

  if Assigned(FLock) then
    FreeAndNil(FLock);
end;

procedure TfrmCadConcilBancNova.FormCreate(Sender: TObject);
begin
  inherited;
  ActivateClassGroup(TControl);
  blnHisBan := (fCfgSis('HISBAN') = 'S');
  pRedimensionarTelaSeguindoMenuIniciar(self);
  //Para resolver problemas com redomensionamento ao usar goglobal
  If Self.Height < 200 Then
  Begin
    Self.Height := Screen.Height - 40;
    Self.Top    := 0;
  End;


  If Not FileExists(fGetNomeArquivoConfigPadrao) Then
    dxDockingManager1.SaveLayoutToIniFile(fGetNomeArquivoConfigPadrao);

  qryExtrato := fCriaQuery();
  qryLanCon  := fCriaQuery();
  qryLanPen  := fCriaQuery();
  FBatchSQL  := TBatchHelper.CreateBatchSQL(Nil);

  fltValTol  := fCfgSis('VALTOL', varDouble);

  qryPenden  := fCriaQuery();
  qryPenden.CachedUpdates := True;
  qryPenden.Options.SetFieldsReadOnly := False;

  qryTotais  := fCriaQuery();
  qryTotais.CachedUpdates := True;
  qryTotais.Options.SetFieldsReadOnly := False;

  qryExtrato.CachedUpdates := False;
  qryExtrato.Options.FullRefresh := True;

  dsExtrato.DataSet    := qryExtrato;
  dsLancConcil.DataSet := qryLanCon;
  dsLanPend.DataSet    := qryLanPen;
  dsPendentes.DataSet  := qryPenden;
  dsTotais.DataSet     := qryTotais;

  objLiberacao := TLiberacao.Create;
  stlDetalhesDosSelecionados := TStringList.Create;

  ValidaInsercaoProInc;

  If FileExists(fGetNomeArquivoConfig) Then
    dxDockingManager1.LoadLayoutFromIniFile(fGetNomeArquivoConfig);

  If blnHisBan Then
  Begin
    grdLanpenDBCTB_HIST01.DataBinding.FieldName := 'HISBAN';
    grdLancConcilTableView1CTB_HIST01.DataBinding.FieldName := 'HISBAN';
  End;

  grdLanpenDBCTB_SEQLAN.DataBinding.FieldName := 'CTB_SEQLAN';

  frxExtratoBancario.AddFunction('function fTime(AForceTime: Boolean) : TDateTime');
  FVinculandoAutomaticamente := False;
  FLock := TLock.Create;
end;

procedure TfrmCadConcilBancNova.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
    btnConciliarLan.Click
  Else If Key = VK_F6 Then
    btnOpcoes.Click
  Else If Key = VK_F7 Then
    btnMarcaTodos.Click
  Else If Key = VK_F8 Then
    btnDesmarcaTodos.Click
  Else If Key = VK_F11 Then
    btnIgnorarlan.Click
  Else If Key = VK_F12 Then
    btnRecomporLan.Click;
end;

procedure TfrmCadConcilBancNova.FormResize(Sender: TObject);
begin
  inherited;
  dckpnlExtrato.Width    := grpExtrato.Width-40;
  dckpnlExtrato.Height   := grpExtrato.Height;
  dckpnlPendentes.Width  := Trunc(dckpnlExtrato.Width/2);
  dckpnlConcil.Height    := Trunc(dckpnlExtrato.Height/2);
end;

procedure TfrmCadConcilBancNova.FormShow(Sender: TObject);
begin
  inherited;
  btnAtualizarPend.Click;
  AComita := True;
  AFechamentoRealizado := False;

  If Not fVerificaAcessoSistema('CONPVSANT') Then
  Begin
     label11.visible := False;
     edtSalPor.visible := False;
     btnLanAju.visible := False;
  End;

end;

function TfrmCadConcilBancNova.fPermiteVincular: Boolean;
var
  fltValSelExt,
  fltValSelBan,
  fltValDif: Double;
begin
  fltValSelExt := fTotalizaSelecionados(grdExtratoDBTableView1);
  fltValSelBan := fTotalizaSelecionados(grdLancPendentesDBTableView1);
  fltValDif    := fltValSelExt - fltValSelBan;

  If fltValDif < 0 Then
    fltValDif := fltValDif *(-1);

  Result := (grdExtratoDBTableView1.DataController.GetSelectedCount > 0) And
            (grdLancPendentesDBTableView1.DataController.GetSelectedCount > 0) And
            ((fFormataFloat(fltValSelExt, 2) = fFormataFloat(fltValSelBan, 2)) Or
             (fFormataFloat(fltValDif, 2) <= fFormataFloat(fltValTol, 2))) ;
end;

function TfrmCadConcilBancNova.fPodeSoltar(objDestino: TObject): Boolean;
var
  AGridView: TcxCustomGridView;
begin
  AGridView := nil;
  If objDestino is TcxGridSite Then
    AGridView := TcxGridSite(objDestino).GridView;

  Result := ((AGridView <> nil) And
             (AGridView <> FDragView.Site.GridView));
end;

function TfrmCadConcilBancNova.fRetornaAutoincremMovBan(
  strSeqLan: String): String;
var
  qryCons: TUniQuery;
begin
  Result := '';
  If strSeqLan <> '' Then
  Begin
    qryCons := fCriaQuery();
    With qryCons Do
    Begin
      Sql.Clear;
      Sql.Text := 'SELECT AUTOINCREM FROM MOVBAN WHERE CTB_SEQLAN = :SEQLAN';
      ParamByName('SEQLAN').AsString := strSeqLan;

      Open;

      If Not IsEmpty Then
        Result := FieldByName('AUTOINCREM').AsString;

      Close;
    End;
    FreeAndNil(qryCons);
  End;
end;

function TfrmCadConcilBancNova.fRetornaColunaCreDeb(
  ADragView: TcxGridDBTableView): TcxGridDBColumn;
begin
  Result := Nil;
  if ADragView = grdExtratoDBTableView1 then
    Result := grdExtratoDBTableView1EXT_CREDEB
  Else if ADragView = grdLancPendentesDBTableView1 then
    Result := grdLanpenDBCTB_CREDEB
  Else if ADragView = grdLancConcilTableView1 then
    Result := grdLancConcilTableView1CTB_CREDEB
end;

function TfrmCadConcilBancNova.fRetornaColunaValLan(
  ADragView: TcxGridDBTableView): TcxGridDBColumn;
begin
  Result := Nil;
  if ADragView = grdExtratoDBTableView1 then
    Result := grdExtratoDBTableView1EXT_VALLAN
  Else if ADragView = grdLancPendentesDBTableView1 then
    Result := grdLanpenDBCTB_VALLAN
  Else if ADragView = grdLancConcilTableView1 then
    Result := grdLancConcilTableView1CTB_VALLAN
end;

function TfrmCadConcilBancNova.fRetornaIndiceMarcados(
  ADragView: TcxGridDBTableView): TArrSelIDX;
var
  strSelIDX: String;
  i,
  ARowIndex,
  ARecordIndex: Integer;
begin
  SetLength(Result, 0);
  strSelIDX := '';

  For I := 0 To ADragView.DataController.GetSelectedCount - 1 Do
  Begin
    ARowIndex    := ADragView.DataController.GetSelectedRowIndex(i);
    ARecordIndex := ADragView.Controller.SelectedRecords[i].RecordIndex;

    If ADragView.DataController.GetRowInfo(ARowIndex).Level = ADragView.DataController.Groups.GroupingItemCount Then
      ARecordIndex     := ADragView.DataController.GetRowInfo(ARowIndex).RecordIndex;

    if Pos(Formatfloat('0000000', ARecordIndex)+'_', strSelIDX) <= 0  then
      strSelIDX := Formatfloat('0000000', ARecordIndex) + '_' + strSelIDX;
  End;

  Result := strSelIDX.Split(['_']);
end;

function TfrmCadConcilBancNova.fRetornaPortadorCCA(var strCodCta, strAgen: String;
  strCodBco, ADigitoConta: String): String;
var
  qryCons: TUniQuery;
  strSql: String;
begin
  qryCons := fCriaQuery();

  With qryCons Do
  Begin
    Sql.Clear;

    strSql   := ' SELECT P.POR_CODPOR, C.* FROM CADPOR P ' +
                ' JOIN CADCCA C ON C.AUTOINCREM = P.POR_CCAAUT ' +
                ' WHERE  C.CCA_CODBCO = :CODBCO  ' +
                      '  AND POR_CONOFX = "S"    ' +
                      '  AND C.CCA_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ')';

    if Pos('-', strCodCta) > 0   then
      strCodCta := Copy(strCodCta, 1,  Pos('-', strCodCta)-1);

    strSql := strSql + ' AND C.CCA_CODCTA LIKE "%'+strCodCta+'%" ';

    If strAgen <> '' Then
    Begin
      if Pos('-', strAgen) > 0   then
        strAgen  := Copy(strAgen, 1,  Pos('-', strAgen)-1)
      else
        strAgen  := strAgen;

      strSql := strSql + ' AND C.CCA_AGENCI LIKE "%'+strAgen+'%" ';
    End;

    Sql.Text := strSql;
    ParamByName('CODBCO').AsString  := strCodBco;

    Open;

    If Not IsEmpty  Then
    Begin

      If (qryCons.RecordCount > 1) Then
        qryCons.Locate('CCA_DIGCTA', VarArrayOf([ADigitoConta]),[]);

      Result    := FieldByName('POR_CODPOR').AsString;

      strCodCta := FieldByName('CCA_CODCTA').AsString;
      If FieldByName('CCA_DIGCTA').AsString <> '' Then
        strCodCta :=  strCodCta + '-'+ FieldByName('CCA_DIGCTA').AsString;

      strAgen := FieldByName('CCA_AGENCI').AsString;
      If FieldByName('CCA_DIGAGE').AsString <> '' Then
        strAgen :=  strAgen + '-' + FieldByName('CCA_DIGAGE').AsString;
    End
    Else
      Result := '';

    Close;
  End;

  FreeAndNil(qryCons);
end;

function TfrmCadConcilBancNova.frxExtratoBancarioUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  inherited;
  If (SameText(MethodName, 'fTime')) Then
    Result := fTime(Params[0]);
end;

function TfrmCadConcilBancNova.fTotalizaRegistros(
  ADragView: TcxGridDBTableView): Double;
var
  i : Integer;
  fltTotLan: Double;
begin
  inherited;
  fltTotLan := 0;
  For I := 0 To ADragView.DataController.DataSet.RecordCount - 1 Do
  Begin
    If ADragView.DataController.Values[i, fRetornaColunaCreDeb(ADragView).Index] = 'C' Then
      fltTotLan := fltTotLan + ADragView.DataController.Values[i, fRetornaColunaValLan(ADragView).Index]
    Else
      fltTotLan := fltTotLan - ADragView.DataController.Values[i, fRetornaColunaValLan(ADragView).Index]
  End;

  Result := fltTotLan;
end;
function TfrmCadConcilBancNova.fTotalizaSelecionados(
  ADragView: TcxGridDBTableView): Double;
var
  i: Integer;
  fltTotLan: Double;
  arrRecIdx: TArray<String>;
begin
  inherited;
  SetLength(arrRecIdx, 0);

  arrRecIdx := fRetornaIndiceMarcados(ADragView);
  fltTotLan := 0;
  for I := 0 to Length(arrRecIdx)-1 do
  Begin
    if (arrRecIdx[i] <> '') then
    Begin
      If ADragView.DataController.Values[arrRecIdx[i].ToInteger, fRetornaColunaCreDeb(ADragView).Index] = 'C' Then
        fltTotLan := fltTotLan + ADragView.DataController.Values[arrRecIdx[i].ToInteger, fRetornaColunaValLan(ADragView).Index]
      Else
        fltTotLan := fltTotLan - ADragView.DataController.Values[arrRecIdx[i].ToInteger, fRetornaColunaValLan(ADragView).Index]
    End;
  End;

  Result := fltTotLan;
end;

function TfrmCadConcilBancNova.fTravaIgnorarLanc: Boolean;
var
  i: Integer;
  fltTotIgn   : Double;
  blnEncontrou: Boolean;
  objTabela   : TRegistroMsgLiberaTabela;
	objLinha    : TLinhaMsgLibera;
  arrIdxSel   : TArrSelIDX;
begin
  inherited;
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('PERMITIR IGNORAR LANÇAMENTOS DO EXTRATO BANCÁRIO', alCentro, teAmbos, '', 92);
  objLiberacao.objMsgLibera.pAddSeparador(92);
  blnEncontrou := False;

  objTabela := TRegistroMsgLiberaTabela.Create;

  SetLength(arrIdxSel, 0);
  fltTotIgn := 0;

  arrIdxSel :=  fRetornaIndiceMarcados(grdExtratoDBTableView1);
  for I := 0 to Length(arrIdxSel)-1 do
  Begin
    if (arrIdxSel[i] <> '') then
    Begin
      If (Pos(grdExtratoDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdExtratoDBTableView1EXT_SITUAC.Index], 'I|R') <= 0 ) Then
      Begin
        blnEncontrou := True;
        If grdExtratoDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdExtratoDBTableView1EXT_CREDEB.Index] = 'C' Then
          fltTotIgn := fltTotIgn + grdExtratoDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdExtratoDBTableView1EXT_VALLAN.Index]
        Else
          fltTotIgn := fltTotIgn - grdExtratoDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdExtratoDBTableView1EXT_VALLAN.Index];

        if objTabela.isEmpty then
        begin
          objLiberacao.objMsgLibera.pAddTexto('LANÇAMENTOS PARA IGNORAR', alCentro, teAmbos, '', 92);
          objLiberacao.objMsgLibera.pAddSeparador(92);
          objLiberacao.objMsgLibera.pAddTextoCaption('Agência'        , edtCodAge.Text   , 14);
          objLiberacao.objMsgLibera.pAddTextoCaption('Conta Corrente' , edtCodCCa.Text   , 14);
          objLiberacao.objMsgLibera.pAddTextoCaption('Portador'       , edtPortador.Text , 14);
          objLiberacao.objMsgLibera.pAddSeparador(92);

          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlCabecalho;
          objLinha.pAddColuna(''  , 'DATA'           , 10 , alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'CRÉDITO/DÉBITO' , 15 , alCentro   , teAutcom);
          objLinha.pAddColuna(''  , 'HISTÓRICO'      , 38 , alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'VALOR'          , 20 , alDireita  , teAutcom);
          objTabela.lstLinhas.Add(objLinha);
        end;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('DATA'           , grdExtratoDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdExtratoDBTableView1EXT_DTALAN.Index]                              , 10 , alEsquerda);
        objLinha.pAddColuna('CRÉDITO/DÉBITO' , grdExtratoDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdExtratoDBTableView1EXT_CREDEB.Index]                              , 15 , alCentro  );
        objLinha.pAddColuna('HISTÓRICO'      , grdExtratoDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdExtratoDBTableView1EXT_HISTOR.Index]                              , 38 , alEsquerda);
        objLinha.pAddColuna('VALOR'          , FloatToStrF(grdExtratoDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdExtratoDBTableView1EXT_VALLAN.Index], ffFixed, 11, 2) , 20 , alDireita );
        objTabela.lstLinhas.Add(objLinha);

      End;
    End;
  End;

  If Not blnEncontrou Then
  Begin
    FreeAndNil(objTabela);
    fMensagem('Aviso', 'Não Foram encontrados lançamentos para ignorar!', ['&O k']);
    Result := False;
  End
  else
  begin
    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlTotal;
    objLinha.pAddColuna(''      , 'TOTAL'                                , 67 , alDireita, teAutcom);
    objLinha.pAddColuna('VALOR' , FloatToStrF(fltTotIgn, ffFixed, 11, 2) , 20 , alDireita );
    objTabela.lstLinhas.Add(objLinha);

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    ApplicationEvents.OnMessage := Nil;

    objLiberacao.strDirAce := 'CONEXIGNLAN';
    objLiberacao.strMsgSen := 'Permitir ignorar lançamentos';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := Not objLiberacao.fLibera;
    ApplicationEvents.OnMessage := ApplicationEventsMessage;

  end;
end;

function TfrmCadConcilBancNova.fTravaIgnorarLancMovBan: Boolean;
var
  i: Integer;
  fltTotIgn,
  fltTotIgnPos,
  fltTotIgnNeg: Double;
  blnEncontrou: Boolean;
  objTabela   : TRegistroMsgLiberaTabela;
	objLinha    : TLinhaMsgLibera;
  strHist01   : String;
  arrIdxSel: TArrSelIDX;
begin
  inherited;
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('PERMITIR IGNORAR LANÇAMENTOS DA MOVIMENTAÇÃO BANCÁRIA', alCentro, teAmbos, '', 92);
  objLiberacao.objMsgLibera.pAddSeparador(92);
  blnEncontrou := False;

  objTabela := TRegistroMsgLiberaTabela.Create;

  SetLength(arrIdxSel, 0);
  fltTotIgnPos := 0;
  fltTotIgnNeg := 0;

  arrIdxSel :=  fRetornaIndiceMarcados(grdLancPendentesDBTableView1);
  for I := 0 to Length(arrIdxSel)-1 do
  Begin
    if (arrIdxSel[i] <> '') then
    Begin
      If grdLancPendentesDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdLanpenDBCTB_IGNORA.Index] <> 'S' Then
      Begin
        blnEncontrou := True;
        If grdLancPendentesDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdLanpenDBCTB_CREDEB.Index] = 'C' Then
          fltTotIgnPos := fltTotIgnPos + grdLancPendentesDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdLanpenDBCTB_VALLAN.Index]
        Else
          fltTotIgnNeg := fltTotIgnNeg - grdLancPendentesDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdLanpenDBCTB_VALLAN.Index];

        if objTabela.isEmpty then
        begin
          objLiberacao.objMsgLibera.pAddTexto('LANÇAMENTOS PARA IGNORAR DA MOVIMENTAÇÃO BANCÁRIA', alCentro, teAmbos, '', 92);
          objLiberacao.objMsgLibera.pAddSeparador(92);
          objLiberacao.objMsgLibera.pAddTextoCaption('Agência'        , edtCodAge.Text   , 14);
          objLiberacao.objMsgLibera.pAddTextoCaption('Conta Corrente' , edtCodCCa.Text   , 14);
          objLiberacao.objMsgLibera.pAddTextoCaption('Portador'       , edtPortador.Text , 14);
          objLiberacao.objMsgLibera.pAddSeparador(92);

          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlCabecalho;
          objLinha.pAddColuna(''  , 'DATA'           , 10 , alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'CRÉDITO/DÉBITO' , 15 , alCentro   , teAutcom);
          objLinha.pAddColuna(''  , 'HISTÓRICO'      , 38 , alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'VALOR'          , 20 , alDireita  , teAutcom);
          objTabela.lstLinhas.Add(objLinha);
        end;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;

        if grdLancPendentesDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdLanpenDBCTB_HIST01.Index] <> null then
          strHist01 := grdLancPendentesDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdLanpenDBCTB_HIST01.Index]
        else
          strHist01 := '';

        objLinha.pAddColuna('DATA'           , grdLancPendentesDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdLanpenDBCTB_DTALAN.Index]                              , 10 , alEsquerda);
        objLinha.pAddColuna('CRÉDITO/DÉBITO' , grdLancPendentesDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdLanpenDBCTB_CREDEB.Index]                              , 15 , alCentro  );
        objLinha.pAddColuna('HISTÓRICO'      , strHist01                                                                                                                  , 38 , alEsquerda);
        objLinha.pAddColuna('VALOR'          , FloatToStrF(grdLancPendentesDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdLanpenDBCTB_VALLAN.Index], ffFixed, 11, 2) , 20 , alDireita );
        objTabela.lstLinhas.Add(objLinha);

      End;
    End;
  End;

  If Not blnEncontrou Then
  Begin
    FreeAndNil(objTabela);
    fMensagem('Aviso', 'Não Foram encontrados lançamentos para ignorar!', ['&O k']);
    Result := False;
    Exit;
  End;

  //Feito isso por causa de erros de float Req: 140297
  fltTotIgn := fFormataFloat(fltTotIgnPos, 2) + fFormataFloat(fltTotIgnNeg, 2);
  if fltTotIgn <> 0 then
  begin
    fMensagem('Aviso', 'Só é permitido ignorar lançamentos da movimentação bancária,' + #13+
                       'em situação de estorno, sendo necessário que a soma dos lançamentos ' + #13 +
                       'a ignorar seja igual a 0!', ['&O k']);
    Result := True;
    Exit;
  end;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlTotal;
  objLinha.pAddColuna(''      , 'TOTAL'                                , 67 , alDireita, teAutcom);
  objLinha.pAddColuna('VALOR' , FloatToStrF(fltTotIgn, ffFixed, 11, 2) , 20 , alDireita );
  objTabela.lstLinhas.Add(objLinha);

  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

  ApplicationEvents.OnMessage := Nil;

  objLiberacao.strDirAce := 'CONEXIGNLANMB';
  objLiberacao.strMsgSen := 'Permitir ignorar lançamentos da movimentação bancária';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  Result := Not objLiberacao.fLibera;
  ApplicationEvents.OnMessage := ApplicationEventsMessage;

end;

function TfrmCadConcilBancNova.fTravaRecompLanc: Boolean;
var
  i: Integer;
  fltTotIgn : Double;
  blnEncontrou: Boolean;
  objTabela   : TRegistroMsgLiberaTabela;
  objLinha    : TLinhaMsgLibera;
  arrIdxSel: TArrSelIDX;
begin
  inherited;
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('PERMITIR RECOMPOR LANÇAMENTOS DO EXTRATO BANCÁRIO', alCentro, teAmbos, '', 92);
  objLiberacao.objMsgLibera.pAddSeparador(92);
  blnEncontrou := False;

  objTabela := TRegistroMsgLiberaTabela.Create;

  SetLength(arrIdxSel, 0);
  fltTotIgn := 0;

  arrIdxSel :=  fRetornaIndiceMarcados(grdExtratoDBTableView1);
  for I := 0 to Length(arrIdxSel)-1 do
  Begin
    if (arrIdxSel[i] <> '') then
    Begin
      If (grdExtratoDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdExtratoDBTableView1EXT_SITUAC.Index] = 'I') Then
      Begin
        blnEncontrou := True;
        If grdExtratoDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdExtratoDBTableView1EXT_CREDEB.Index] = 'C' Then
          fltTotIgn := fltTotIgn + grdExtratoDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdExtratoDBTableView1EXT_VALLAN.Index]
        Else
          fltTotIgn := fltTotIgn - grdExtratoDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdExtratoDBTableView1EXT_VALLAN.Index];

        if objTabela.isEmpty then
        begin
          objLiberacao.objMsgLibera.pAddTexto('LANÇAMENTOS PARA RECOMPOR', alCentro, teAmbos, '', 92);
          objLiberacao.objMsgLibera.pAddSeparador(92);
          objLiberacao.objMsgLibera.pAddTextoCaption('Agência'        , edtCodAge.Text   , 14);
          objLiberacao.objMsgLibera.pAddTextoCaption('Conta Corrente' , edtCodCCa.Text   , 14);
          objLiberacao.objMsgLibera.pAddTextoCaption('Portador'       , edtPortador.Text , 14);
          objLiberacao.objMsgLibera.pAddSeparador(92);

          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlCabecalho;
          objLinha.pAddColuna(''  , 'DATA'           , 10 , alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'CRÉDITO/DÉBITO' , 15 , alCentro   , teAutcom);
          objLinha.pAddColuna(''  , 'HISTÓRICO'      , 38 , alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'VALOR'          , 20 , alDireita  , teAutcom);
          objTabela.lstLinhas.Add(objLinha);
        end;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('DATA'           , grdExtratoDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdExtratoDBTableView1EXT_DTALAN.Index]                              , 10 , alEsquerda);
        objLinha.pAddColuna('CRÉDITO/DÉBITO' , grdExtratoDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdExtratoDBTableView1EXT_CREDEB.Index]                              , 15 , alCentro  );
        objLinha.pAddColuna('HISTÓRICO'      , grdExtratoDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdExtratoDBTableView1EXT_HISTOR.Index]                              , 38 , alEsquerda);
        objLinha.pAddColuna('VALOR'          , FloatToStrF(grdExtratoDBTableView1.DataController.Values[arrIdxSel[i].ToInteger(), grdExtratoDBTableView1EXT_VALLAN.Index], ffFixed, 11, 2) , 20 , alDireita );
        objTabela.lstLinhas.Add(objLinha);
      End;
    End;
  End;

  If Not blnEncontrou Then
  Begin
    FreeAndNil(objTabela);
    fMensagem('Aviso', 'Não Foram encontrados lançamentos para recompor!', ['&O k']);
    Result := False;
    Exit;
  end
  else
  begin
    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlTotal;
    objLinha.pAddColuna(''      , 'TOTAL'                                , 67 , alDireita, teAutcom);
    objLinha.pAddColuna('VALOR' , FloatToStrF(fltTotIgn, ffFixed, 11, 2) , 20 , alDireita );
    objTabela.lstLinhas.Add(objLinha);

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    ApplicationEvents.OnMessage := Nil;

    objLiberacao.strDirAce := 'CONEXIGNLAN';
    objLiberacao.strMsgSen := 'Permitir recompor lançamentos';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := Not objLiberacao.fLibera;
    ApplicationEvents.OnMessage := ApplicationEventsMessage;

  end;
end;

{function TfrmCadConcilBancNova.fVerificaExtatoImportado(Arquivo: TOFX; strNomeArquivo, strCodPor: String): Boolean;
var
 qryConsulta: TUniQuery;
begin
  Result := False;
  If Assigned(Arquivo) Then
  Begin
    qryConsulta := fCriaQuery;
    With qryConsulta do
    Begin
      Sql.Clear;
      Sql.Text := ' SELECT          ' +
                  '   AUTOINCREM    ' +
                  ' FROM            ' +
                  '   EXTBAN        ' +
                  ' WHERE           ' +
                  '   (EXT_CODPOR = :CODPOR AND                 ' +
                  '   EXT_DTALAN BETWEEN :DTAINI AND :DTAFIN) OR ' +
                  '   EXT_ARQIMP = :ARQIMP                      ' ;

      ParamByName('DTAINI').AsDateTime := Arquivo.DataInicial;
      ParamByName('DTAFIN').AsDateTime := Arquivo.DataFinal;
      ParamByName('CODPOR').AsString   := strCodPor;
      ParamByName('ARQIMP').AsString   := strNomeArquivo;

      Open;

      Result := Not IsEmpty;

      Close;
    End;
    FreeAndNil(qryConsulta);
  End;
end;}

function TfrmCadConcilBancNova.fVerificaLancamentos(const strCodPor: String;
  Arquivo: TOfx): TOfx;
Var
  qryCons: TUniQuery;
  objOFXItem: TOFXItem;
begin
  Result := Nil;
  If Assigned(Arquivo) Then
  Begin
    qryCons := fCriaQuery;
    qryCons.Options.SetFieldsReadOnly := False;
    With qryCons Do
    Begin
      Sql.Clear;
      CachedUpdates := True;
      Sql.Text := ' SELECT EXTBAN.*, "N" AS ENCONTROU FROM EXTBAN WHERE EXT_CODPOR = :CODPOR AND EXT_DTALAN BETWEEN :DTAINI AND :DTAFIN ';
      ParamByName('DTAINI').AsDateTime := Arquivo.DataInicial;
      ParamByName('DTAFIN').AsDateTime := Arquivo.DataFinal;
      ParamByName('CODPOR').AsString   := strCodPor;

      Open;

      If Not IsEmpty then
      Begin
        Result              := TOfx.Create;
        Result.BancoID      := Arquivo.BancoID;
        Result.ContaID      := Arquivo.ContaID;
        Result.AgenciaID    := Arquivo.AgenciaID;
        Result.Organizacao  := Arquivo.Organizacao;
        Result.TipoConta    := Arquivo.TipoConta;
        Result.ValorInicial := Arquivo.ValorInicial;
        Result.ValorFinal   := Arquivo.ValorFinal;
        Result.DataInicial  := Arquivo.DataInicial;
        Result.DataFinal    := Arquivo.DataFinal;

        For objOFXItem in Arquivo.Movimentacoes Do
        Begin
          Filtered := False;
          Filter   := ' EXT_DTALAN = ' + QuotedStr(FormatDateTime('yyyy-mm-dd', objOFXItem.Data)) + ' AND ' +
                      ' EXT_CREDEB = ' + QuotedStr(Copy(objOFXItem.Tipo, 1, 1).ToUpper)           + ' AND ' +
                      ' EXT_VALLAN = ' + QuotedStr(objOFXItem.Valor.ToString)                     + ' AND ' +
                      ' EXT_HISTOR = ' + QuotedStr(objOFXItem.Descricao.ToUpper)                  + ' AND ' +
                      ' ENCONTROU  = ' + QuotedStr('N');
          Filtered := True;

          If Not IsEmpty Then
          Begin
            Edit;
            FieldByName('ENCONTROU').AsString := 'S';
            Post;

            Continue;
          End;

          Result.Movimentacoes.Add(objOFXItem);
        End;

      End
      Else
        Result := Nil;
    End;
  End;
end;

function TfrmCadConcilBancNova.fVinculaExtMovBan(strAutoIncMovBan: String;
                                                 strAutoIncExtBan: String;
                                                 AQuoted: Boolean;
                                                 strParameter: Array of String;
                                                 FSubject: ISubject_ = Nil;
                                                 AExecute: Boolean = True;
                                                 pgbStatus: TcxProgressBar = nil): Boolean;
  Var
    LRegistrosParaInserir: TStringBuilder;

    LContadorDeRegistros: Integer;

    LConsulta: TUniQuery;
    LAutExr: String;
    LQueryExecute: TUniQuery;
    LSql: String;
begin
  Application.ProcessMessages;
  Result := False;
  try
    If (strAutoIncMovBan.IsEmpty) Then
      Exit;

    If (strAutoIncExtBan.IsEmpty) Then
      Exit;

    If fEmptyStr(fRetAutoIncrem('BANEXR', VS_strCodEmp)) Then
      Exit;

    If AQuoted Then
    Begin
      strAutoIncMovBan :=  fRetStrToSQLIn(strAutoIncMovBan,',');
      strAutoIncExtBan :=  fRetStrToSQLIn(strAutoIncExtBan,',');
    End;

    If PortadoresDosLancamentosSaoDiferentes(strAutoIncMovBan,
                                             strAutoIncExtBan) Then
      Raise Exception.Create('Não é possível realizar o vínculo pois os lançamentos são de portadores diferentes.' + #13 +
                             'Recarregue os dados e tente novamente.');

    LConsulta := fCriaQuery();
    LQueryExecute :=  fCriaQuery();
    LRegistrosParaInserir := TStringBuilder.Create;
    LConsulta.SQL.Text := 'SELECT E.AUTOINCREM AS AUTEXT, ' +
                          '       B.AUTOINCREM AS AUTMOV, ' +
                          '       E.EXT_SITUAC AS SITUAC ' +
                          '       FROM EXTBAN E ' +
                          '       CROSS JOIN (SELECT * FROM MOVBAN WHERE AUTOINCREM IN ('+ strAutoIncMovBan + ')) B ' +
                          '       WHERE E.AUTOINCREM IN (' + strAutoIncExtBan + ')';
    LConsulta.Open;
    FBatchSQL.Clear;

    FBatchSQL.OnProgress :=
      procedure(Sender: TObject; ALote, ATotalLotes: Integer)
      begin
        if Assigned(pgbStatus) then
        begin
          pgbStatus.Position := ALote;
          pgbStatus.Properties.Max := ATotalLotes;
          pStepStatusGravacao(pgbStatus);
        end;
      end;

    LRegistrosParaInserir.Clear;
    LContadorDeRegistros  := 0;

    If FSubject <> Nil Then
      strParameter[1] := IntToStr(LConsulta.RecordCount);

    LAutExr := fRetAutoIncremInterno('BANEXR', VS_strCodEmp,LConsulta.RecordCount);

    If Assigned(pgbStatus) Then
    Begin
      pgbStatus.Position := 0;
      pgbStatus.Properties.Max := LConsulta.RecordCount;
    End;

    While Not LConsulta.Eof Do
    Begin
      If (FVinculandoAutomaticamente) And (LConsulta.FieldByName('SITUAC').AsString = 'A') Then // Não vincular registros extban similares automaticamente
      Begin
        LConsulta.Next;
        Continue;
      End;

      LRegistrosParaInserir.Append('("' + LAutExr + '",' +
                                   '"' + LConsulta.FieldByName('AUTEXT').AsString + '",' +
                                   '"' + LConsulta.FieldByName('AUTMOV').AsString + '"),');

      LAutExr := fNextAutoIncremInt64(LAutExr);

      Inc(LContadorDeRegistros);

      LConsulta.Next;

      If (LContadorDeRegistros >= 25) Or (LConsulta.Eof) Then
      Begin
        LSql := 'INSERT INTO BANEXR       ' +
                 '            (AUTOINCREM,  ' +
                 '             EXR_EXTINC,  ' +
                 '             EXR_BANINC ) ' +
                 ' VALUES ' + LeftStr(LRegistrosParaInserir.ToString, LRegistrosParaInserir.ToString.Length - 1);

        FBatchSQL
         .BeginCommand(LSql)
         .EndCommand;

        LRegistrosParaInserir.Clear;
        LContadorDeRegistros  := 0;

        If FSubject <> Nil Then
        Begin
          strParameter[2] := 'Vinculando lançamentos...';
          strParameter[3] := IntToStr(LConsulta.RecNo);
          FSubject.pNotify(strParameter);
        End;

        If Assigned(pgbStatus) Then
          pStepStatusGravacao(pgbStatus);
      End;
    End;

    Result := True;

    If AExecute Then
    Begin
      Result := FBatchSQL.Execute(LQueryExecute);
    End;

    FreeAndNil(LConsulta);
    FreeAndNil(LQueryExecute);
    FreeAndNil(LRegistrosParaInserir);
  Except
    On e: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TfrmCadConcilBancNova.VincularLancamentos;
  Var
    LGravando : TfrmGravando;
begin
  pCriarFormularios(TfrmGravando, LGravando);
  Try
    LGravando.fExecutarAcao := VinculandoLancamentos;
    LGravando.lblGravando.Caption := 'Aguarde... Vinculando Lançamentos.';
    LGravando.ShowModal;
  Finally
    FreeAndNil(LGravando);
  End;
end;

procedure TfrmCadConcilBancNova.grdExtratoDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  strValor: String;
begin
  inherited;
   If AViewInfo.GridRecord.Selected Then
   Begin
     ACanvas.Brush.Color := clNavy;
     ACanvas.Font.Color  := clWhite;
   End;

  strValor := VarAsType(grdExtratoDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ grdExtratoDBTableView1EXT_CREDEB.Index], varString);

  If strValor = 'D' Then
    ACanvas.Font.Color  := clRed;

  strValor := VarAsType(grdExtratoDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ grdExtratoDBTableView1EXT_SITUAC.Index], varString);

//  If ((strValor = 'S') And (not AViewInfo.GridRecord.Selected)) Then
 //   ACanvas.Brush.Color  := $0093FFFF;

//  If ((strValor = 'R') And (not AViewInfo.GridRecord.Selected)) Then
//    ACanvas.Brush.Color  := $00FFE4D5;

  If (strValor = 'I')  Then
  Begin
    ACanvas.Font.Color   := clMedGray;
    ACanvas.Font.Style   := [fsStrikeOut, fsBold];
  End;
end;

procedure TfrmCadConcilBancNova.grdExtratoDBTableView1DragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  intQtdSelPen,
  intQtdSelExt: Integer;
begin
  inherited;
  intQtdSelPen := grdLancPendentesDBTableView1.DataController.GetSelectedCount;
  intQtdSelExt := grdExtratoDBTableView1.DataController.GetSelectedCount;

  Accept := (FDragView <> nil) And
            (intQtdSelPen  >= 1) And
            (intQtdSelExt  >= 1) And
            fPermiteVincular;
end;

procedure TfrmCadConcilBancNova.grdExtratoDBTableView1EndDrag(Sender,
  Target: TObject; X, Y: Integer);
begin
  If Not (Target is TWinControl) Then exit;

  If fPodeSoltar(Target) Then
  Begin
    qryLanPen.DisableControls;
    VincularLancamentos;
    qryLanPen.EnableControls;
  End;

  FDragView := nil;
end;

procedure TfrmCadConcilBancNova.grdExtratoDBTableView1SelectionChanged(
  Sender: TcxCustomGridTableView);
begin
  inherited;
  edtSelecionado.Text := FormatFloat('R$ ###,###,##0.00',
                                     fTotalizaSelecionados(grdExtratoDBTableView1));
end;

procedure TfrmCadConcilBancNova.grdExtratoDBTableView1StartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  inherited;
  FDragView := grdExtratoDBTableView1;
end;

procedure TfrmCadConcilBancNova.grdExtratoExit(Sender: TObject);
begin
  inherited;
  strGridPerdeuFoco :=  'grdExtrato';
end;

procedure TfrmCadConcilBancNova.grdLancConcilTableView1CellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If Not qryLanCon.IsEmpty Then
    pSelecinaLancExtratos;
end;

procedure TfrmCadConcilBancNova.grdLancConcilTableView1Column2PropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  ChamaTelaDetalhesRelacionados.Execute;
end;

procedure TfrmCadConcilBancNova.grdLancConcilTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  strValor: String;
begin
  inherited;
 If AViewInfo.GridRecord.Selected Then
 begin
    ACanvas.Brush.Color := clNavy;
    ACanvas.Font.Color  := clWhite;
 end;

  strValor := VarAsType(grdLancConcilTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[grdLancConcilTableView1CTB_CREDEB.Index], varString);

  If strValor = 'D' Then
    ACanvas.Font.Color  := clRed;
end;

procedure TfrmCadConcilBancNova.grdLancPendentesDBTableView1CellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pSelecionaCartoes;
  pSelecionaContasReceber;

  System.SysUtils.Abort;
end;

procedure TfrmCadConcilBancNova.grdLancPendentesDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  strValor: String;
begin
 inherited;
  If AViewInfo.GridRecord.Selected Then
  begin
    ACanvas.Brush.Color := clNavy;
    ACanvas.Font.Color  := clWhite;
  end;

  strValor := VarAsType(grdLancPendentesDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[grdLanpenDBCTB_CREDEB.Index], varString);

  If strValor = 'D' Then
    ACanvas.Font.Color  := clRed;
end;

procedure TfrmCadConcilBancNova.grdLancPendentesDBTableView1SelectionChanged(
  Sender: TcxCustomGridTableView);
begin
  edtTotalSelecionadoMB.Text := FormatFloat('R$ ###,###,##0.00',
                                       fTotalizaSelecionados(grdLancPendentesDBTableView1));
end;

procedure TfrmCadConcilBancNova.grdLancPendentesDBTableView1StartDrag(
  Sender: TObject; var DragObject: TDragObject);
begin
  inherited;
  FDragView := grdLancPendentesDBTableView1;
end;

procedure TfrmCadConcilBancNova.grdLancPendentesExit(Sender: TObject);
begin
  inherited;
  strGridPerdeuFoco :=  'grdLancPendentes';
end;

procedure TfrmCadConcilBancNova.grdLanpenDBColumn5PropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  ChamaTelaDetalhesPendentes.Execute;
end;

procedure TfrmCadConcilBancNova.grdPendBancoDblClick(Sender: TObject);
var
  intRecNo: Integer;
  ExtBanc: TExtratoBancario;
  blnAlterou: Boolean;
begin
  inherited;
  If qryPenden.RecordCount > 0 Then
  Begin
    FVinculandoAutomaticamente := True;
    Try
      Self.Hide;
      blnAlterou := False;
      ApplicationEvents.OnMessage := Nil;
      ExtBanc := TfrmConsExtBanPen.fMostraCarregandoBanco(qryPenden.FieldByName('EXT_CODBCO').AsString, '', true);
      ApplicationEvents.OnMessage := ApplicationEventsMessage;

      If Assigned(ExtBanc) Then
      Begin
        FreeAndNil(FExtBancario);
        FExtBancario := ExtBanc;
        blnAlterou   := True;
      End;

      If blnAlterou Then
      Begin
        intRecNo :=  qryPenden.RecNo;

        qryPenden.DisableControls;

        If qryPenden.Locate('MARCADO', 'S',[]) Then
        Begin
          qryPenden.Edit;
          qryPenden.FieldByName('MARCADO').AsString := 'N';
          qryPenden.Post;
        End;

        qryPenden.RecNo := intRecNo;
        qryPenden.EnableControls;

        qryExtrato.Close;
        qryExtrato.Sql.Clear;
        qryExtrato.Sql.Text := 'SELECT * FROM EXTBAN WHERE FALSE ';
        qryExtrato.Open;

        btnVincular.Visible    := True;
        btnVincular.Enabled    := True;
        btnDesvincular.Visible := True;
        btnDesvincular.Enabled := True;
        chkConciliados.Checked := False;
        btnConciliarLan.Enabled := True;

        qryPenden.Edit;
        qryPenden.FieldByName('MARCADO').AsString := 'S';
        qryPenden.Post;

        pCarregaExtrato(FExtBancario);

        If Not qryExtrato.IsEmpty Then
        Begin
          pCarregaRegistros;
          pAtualizaTotais;

          edtSalPor.Text := FormatFloat('R$ ###,###,##0.00', fRetSaldoAnterior(qryExtrato.FieldByName('EXT_CODPOR').AsString, qryExtrato.FieldByName('EXT_DTAINI').AsDateTime-1));
        End;
      End;

      Self.Show;
    Finally
      FVinculandoAutomaticamente := False;
    End;
  End;
  mskCodCta.Clear;
  edtDesCta.Clear;
end;

procedure TfrmCadConcilBancNova.grdPendBancoStylesGetContentStyle(
  Sender: TObject; AEditProp: TcxCustomEditorRowProperties; AFocused: Boolean;
  ARecordIndex: Integer; var AStyle: TcxStyle);
begin
  inherited;
  If grdPendBanco.DataController.Values[ARecordIndex, grdPendBancoMarcado.Index] = 'S' Then
    AStyle := cxStyle10
  Else
    AStyle := cxStyle8;
end;

procedure TfrmCadConcilBancNova.grdTotaisDBBandedTableViewCitel1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If AViewInfo.GridRecord.Selected Then
  Begin
     ACanvas.Brush.Color := clWhite;
     ACanvas.Font.Color  := clNavy;
  End;
end;

procedure TfrmCadConcilBancNova.ImportacaoOfxAutomatica;
var
  LJSONDadosExtratoBancario: String;
  LJSONObject: TJSONObject;
begin
  LJSONDadosExtratoBancario := untFuncoesInicializarLibContasBancarias.
                                TLibContasBancarias.
                                 ImportarExtratoBancario;

  If fEmptyStr(LJSONDadosExtratoBancario) Then
    Exit;

  try
    LJSONObject := TJSONObject.ParseJSONValue(LJSONDadosExtratoBancario) as TJSONObject;

    if Assigned(LJSONObject) then
    begin
      try
        if Assigned(FExtBancario) then
          FreeAndNil(FExtBancario);

        FExtBancario := TExtratoBancario.Create;

        FExtBancario.CodBco := LJSONObject.GetValue('CodigoBanco').Value;
        FExtBancario.CodPor := LJSONObject.GetValue('CodigoPortador').Value;
        FExtBancario.DataInicial := StrToDate(LJSONObject.GetValue('DataInicial').Value);
        FExtBancario.DataFinal := StrToDate(LJSONObject.GetValue('DataFinal').Value);

        pCarregaExtrato(FExtBancario);

        pVerificarBaixaBoletoAutbanAnalitico(FExtBancario.DataInicial, FExtBancario.DataFinal, FExtBancario.CodPor);
        pVerificarBaixaBoletoAutbanSintetico(FExtBancario.DataInicial, FExtBancario.DataFinal, FExtBancario.CodPor);
        pVerificarRecCarExtrato(FExtBancario.DataInicial, FExtBancario.DataFinal, FExtBancario.CodPor);
        pVerificarHistoricoExtrato(FExtBancario.DataInicial, FExtBancario.DataFinal, FExtBancario.CodPor);
        pVerificarLancamentoExtratoPagCon(FExtBancario.DataInicial, FExtBancario.DataFinal, FExtBancario.CodPor);
        pVerificarLancamentoExtrato(FExtBancario.DataInicial, FExtBancario.DataFinal, FExtBancario.CodPor);

        pCarregaRegistros;
      finally
        LJSONObject.Free;
      end;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;

end;

procedure TfrmCadConcilBancNova.ImportarLayout1Click(Sender: TObject);
begin
  inherited;
  With opdConfigPanel Do
  Begin
    Filter   := 'Ini Files (*.ini)|*.ini';
    If Execute Then
    Begin
      If FileName <> '' Then
      Begin
        Try
          dxDockingManager1.LoadLayoutFromIniFile(FileName);
          dxDockingManager1.SaveLayoutToIniFile(fGetNomeArquivoConfig);
        Except
          On e: Exception Do
          Begin
            fMensagem('Aviso', 'Ocorreu o seguinte erro ao tentar importar o arquivo de configuração do layout dos painéis!'+#13+'Erro: ' + e.Message, ['O k']);
            Exit;
          End;
        End;
        fMensagem('Aviso', 'Layout dos painéis importado com sucesso!', ['O k']);
      End;
    End
  End;

end;

function TfrmCadConcilBancNova.LancamentoAjuste(var AValorAjuste: Double;
                                                var ADataLancamento: TDate;
                                                out ADatasDivergentes: Boolean): Boolean;
var
  LSelecionadosMovBan, LSelecionadosExtrato: TArray<String>;
  LTotalMovBan, LTotalExtrato: Double;
  LDataMovBan, LDataExtrato: TDate;
begin
  Result := False;
  AValorAjuste := 0.00;
  LDataMovBan := 0;
  LDataExtrato := 0;
  try
    try
      LSelecionadosMovBan := fRetornaIndiceMarcados(grdLancPendentesDBTableView1);
      LSelecionadosExtrato := fRetornaIndiceMarcados(grdExtratoDBTableView1);

      if (Length(LSelecionadosMovBan) = 0) or (Length(LSelecionadosExtrato) = 0) then
        Exit;

      LTotalMovBan := fTotalizaSelecionados(grdLancPendentesDBTableView1);
      LTotalExtrato := fTotalizaSelecionados(grdExtratoDBTableView1);

      if LTotalMovBan - LTotalExtrato = 0 then
        Exit;

      if DatasSelecionadasDivergentes(grdLancPendentesDBTableView1, 'CTB_DTALAN', LDataMovBan) or
         DatasSelecionadasDivergentes(grdExtratoDBTableView1, 'EXT_DTALAN', LDataExtrato) then
      begin
        ADatasDivergentes := True;
      end;

      if (LDataMovBan = LDataExtrato) then
      begin
        AValorAjuste := RoundTo(LTotalExtrato - LTotalMovBan, -2);
        ADataLancamento := LDataMovBan;
        Result := True;
      end;
    finally
      SetLength(LSelecionadosMovBan, 0);
      SetLength(LSelecionadosExtrato, 0);
    end;
  except
    on E: Exception do
      raise Exception.Create('Erro ao verificar lançamento de ajuste: ' + E.Message);
  end;
end;

function TfrmCadConcilBancNova.DatasSelecionadasDivergentes(AGrid: TcxGridDBTableView; ACampoData: String;
                                                            out AData: TDate): Boolean;
var
  LListaIndicesSelecionados: TArray<string>;
  LContador: Integer;
  LPrimeiraData, LDataAtual: TDate;
begin
  Result := False;
  LPrimeiraData := 0;
  try
    LListaIndicesSelecionados := fRetornaIndiceMarcados(AGrid);
    for LContador := 0 to Pred(Length(LListaIndicesSelecionados)) do
    begin
      if LListaIndicesSelecionados[LContador] = '' then
        Continue;

      LDataAtual := AGrid.DataController.Values[LListaIndicesSelecionados[LContador].ToInteger,
                                                AGrid.GetColumnByFieldName(ACampoData).Index];

      if LContador = 0 then
        LPrimeiraData := LDataAtual
      else if LPrimeiraData <> LDataAtual then
        Exit(True);
    end;

    if (Length(LListaIndicesSelecionados) > 0) and (LPrimeiraData <> 0) then
      AData := LPrimeiraData;
  except
    On E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TfrmCadConcilBancNova.LancamentosJaVinculados(
  AAutoIncremsMovban: String; AAutoincremExtBan: String): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT                  '+
                          '  *                     '+
                          'FROM                    '+
                          '  BANEXR                '+
                          'WHERE                   ';

    If Not fEmptyStr(AAutoIncremsMovban) Then
      LConsulta.SQL.Text := LConsulta.SQL.Text +' EXR_BANINC IN ('+AAutoIncremsMovban+')  '
    Else
      LConsulta.SQL.Text := LConsulta.SQL.Text +' EXR_EXTINC = ' + AAutoincremExtBan.QuotedString;

    LConsulta.Open;

    Result := LConsulta.Recordcount > 0;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmCadConcilBancNova.mskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, mskCodCta, edtDesCta, Nil, Key, arrCCusto, False) Then
  begin
    if fValidaCampos(mskCodCta, True) then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmCadConcilBancNova.pAtualizarExtBanSimilares;
var
  LfrmGravando: TfrmGravando;
begin
  pCriarFormularios(TfrmGravando, LfrmGravando);
  try
    LfrmGravando.fExecutarAcao := fIdentificarExtBanSimilares;
    LfrmGravando.lblGravando.Caption := 'Aguarde... Identificando registros similares no extrato bancário.';
    LfrmGravando.ShowModal;
  finally
    pFreeAndNil(LfrmGravando);
  end;
end;

procedure TfrmCadConcilBancNova.pAtualizaTotais;
begin
  If Assigned(FExtBancario) Then
  Begin
    With qryTotais Do
    Begin
      Close;
      Sql.Clear;
      Sql.Text := fGetSQLTotais;
      If FExtBancario.Arquivo <> '' Then
      Begin
        Sql.Text := Sql.Text + ' WHERE EXT_ARQIMP = :ARQIMP AND EXT_CODPOR = :CODPOR ';
        ParamByName('ARQIMP').AsString := FExtBancario.Arquivo;
        ParamByName('CODPOR').AsString := FExtBancario.CodPor;
      End
      Else
      Begin
        If Not fEmptyStr(FExtBancario.Periodo)  Then
        Begin
          Sql.Text := Sql.Text + ' WHERE EXT_CODBCO = :CODBCO AND EXT_CODPOR = :CODPOR AND ' +
                                 '       EXT_DTALAN IN (DTALAN_) ';

          Sql.Text := StringReplace(Sql.Text, 'DTALAN_', FExtBancario.Periodo, [rfReplaceAll]);
          ParamByName('CODBCO').Value      := FExtBancario.CodBco;
          ParamByName('CODPOR').AsString   := FExtBancario.CodPor;
        End
        Else
        Begin
          Sql.Text := Sql.Text + ' WHERE EXT_CODBCO = :CODBCO AND EXT_CODPOR = :CODPOR AND ' +
                                 '       EXT_DTALAN BETWEEN :DTAINI AND :DTAFIN ';

          ParamByName('DTAINI').AsDateTime := FExtBancario.DataInicial;
          ParamByName('DTAFIN').AsDateTime := FExtBancario.DataFinal;
          ParamByName('CODBCO').Value      := FExtBancario.CodBco;
          ParamByName('CODPOR').AsString   := FExtBancario.CodPor;
        End;
      End;

      Open;

      If Not isEmpty Then
      Begin
        If Assigned(FExtBancario) Then
        Begin
          Edit;
          QryTotais.FieldByName('Saldo_Total').AsFloat := fRetSaldoAnterior(qryExtrato.FieldByName('EXT_CODPOR').AsString, FExtBancario.DataInicial-1) +
                                                                            QryTotais.FieldByName('CON_TOTAL').AsFloat+
                                                                            QryTotais.FieldByName('REL_TOTAL').AsFloat+
                                                                            QryTotais.FieldByName('SIM_TOTAL').AsFloat+
                                                                            QryTotais.FieldByName('NRL_TOTAL').AsFloat;
          Post;
        End;
      End;
    End;
  End;
end;

procedure TfrmCadConcilBancNova.pCarregaExtrato(
  AExtratoBancario: TExtratoBancario);
begin
  pLimpaEdits;
  If Assigned(AExtratoBancario) Then
  Begin
    With qryExtrato Do
    Begin
      Close;
      Sql.Clear;
      If AExtratoBancario.Arquivo <> '' Then
      Begin
        Sql.Text := fGetSql;
        ParamByName('ARQIMP').AsString := AExtratoBancario.Arquivo;
        ParamByName('CODBCO').AsString := AExtratoBancario.CodBco;
        ParamByName('CODPOR').AsString := AExtratoBancario.CodPor;
      End
      Else
      Begin
        If AExtratoBancario.Periodo <> '' Then
        Begin
          Sql.Text := fGetSql(False, False, False, True);
          Sql.Text := StringReplace(Sql.Text, 'DTALAN_', AExtratoBancario.Periodo, [rfReplaceAll]);
          ParamByName('CODBCO').AsString   := AExtratoBancario.CodBco;
          ParamByName('CODPOR').AsString   := AExtratoBancario.CodPor;
        End
        Else
        Begin
          Sql.Text := fGetSql(False, True);
          ParamByName('DTAINI').AsDateTime := AExtratoBancario.DataInicial;
          ParamByName('DTAFIN').AsDateTime := AExtratoBancario.DataFinal;
          ParamByName('CODBCO').AsString   := AExtratoBancario.CodBco;
          ParamByName('CODPOR').AsString   := AExtratoBancario.CodPor;
        End;
      End;

      Open;

      If Not IsEmpty Then
      Begin
        edtDataInicial.Text := qryExtrato.FieldByName('EXT_DTAINI').AsString;
        edtDataFinal.Text   := qryExtrato.FieldByName('EXT_DTAFIN').AsString;
        edtCodAge.Text      := qryExtrato.FieldByName('EXT_AGENCI').AsString;
        edtCodCCa.Text      := qryExtrato.FieldByName('EXT_CODCTA').AsString;
        edtPortador.Text    := qryExtrato.FieldByName('EXT_CODPOR').AsString + ' - ' + fRetNomPortador(qryExtrato.FieldByName('EXT_CODPOR').AsString);
        edtSalPor.Text      := FormatFloat('R$ ###,###,##0.00', fRetSaldoAnterior(qryExtrato.FieldByName('EXT_CODPOR').AsString, qryExtrato.FieldByName('EXT_DTAINI').AsDateTime-1));
        dtaIniExt.Date      := qryExtrato.FieldByName('EXT_DTAINI').AsDateTime;
        dtaFinExt.Date      := qryExtrato.FieldByName('EXT_DTAFIN').AsDateTime;
        dtaPenIni.Date      := qryExtrato.FieldByName('EXT_DTAINI').AsDateTime;
        dtaPenFin.Date      := qryExtrato.FieldByName('EXT_DTAFIN').AsDateTime;
      End;
    End;

    if not TravarLancamentosExtrato then
    begin
      LimparTudoECancelar;
      Exit;
    end;

    pAtualizarExtBanSimilares;
  End;
end;

procedure TfrmCadConcilBancNova.pCarregaLanConcil;
var
  strSQL: String;
begin
  If Not qryExtrato.isEmpty Then
  Begin
    qryLanCon.Close;
    qryLanCon.SQL.Clear;
    If qryExtrato.FieldByName('AUTOINCREM').AsString <> '' Then
    Begin
      strSQL := ' SELECT      '+
                '   MOVBAN.*  ';

      If blnHisBan Then
        strSQL := strSQL + ', CONCAT(IFNULL(CTB_HIST01,"")," ",IFNULL(CTB_HIST02,"")) AS HISBAN';

      strSQL := strSQL + ' FROM              ' +
                         '   MOVBAN          ' +
                         ' WHERE             ' +
                         '   AUTOINCREM IN   ' +
                         '   ( SELECT        ' +
                         '       EXR_BANINC  ' +
                         '     FROM          ' +
                         '       BANEXR      ' +
                         '     WHERE         ' +
                         '       EXR_EXTINC = :EXTINC)';

      qryLanCon.Sql.Text := strSQL;

      qryLanCon.ParamByName('EXTINC').AsString := qryExtrato.FieldByName('AUTOINCREM').AsString;

      qryLanCon.Open;
    End;
  End;
  edtTotalRelacionadoMB.Text := FormatFloat('R$ ###,###,##0.00',
                                            fTotalizaRegistros(grdLancConcilTableView1));
  btnDesvincular.Visible :=
    (grdLancConcilTableView1.DataController.RecordCount > 0) And
    (Not qryExtrato.IsEmpty) And
    qryExtrato.FieldByName('EXT_DTACON').IsNull;

  btnDesvincular.Enabled := btnDesvincular.Visible;
end;

procedure TfrmCadConcilBancNova.pCarregaPendente(const dtaIni, dtaFin: TDate;
  const strCodPor: String; const fltValLan: Double; const strCreDeb: String);
var
  strSQL: String;
begin
  If Not qryExtrato.isEmpty Then
  Begin
    qryLanPen.Close;

    With qryLanPen Do
    Begin
      Sql.Clear;

      strSQL :=     ' SELECT   ' +
                    '   M.*    ' +
      IIF(blnHisBan,' ,CONCAT(IFNULL(CTB_HIST01,"")," ",IFNULL(CTB_HIST02,"")) AS HISBAN',' ') +
                    ' FROM     ' +
                    '   MOVBAN M ' +
                    ' LEFT JOIN BANEXR E ON E.EXR_BANINC = M.AUTOINCREM' +
                    ' WHERE  ' +
                    '   M.CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN AND (CTB_IGNORA IS NULL OR CTB_IGNORA <> "S") ' +
                    '   AND M.CTB_DTACON IS NULL AND E.EXR_BANINC IS NULL ';

      If Not fEmptyStr(edtDesCta.Text) Then
        strSQL := strSQL + fStrLocate(mskCodCta, arrCCusto, 'M.CTB_CODCTA', 'CODCTA');

      If strCodPor  <> '' Then
        strSQL := strSQL + '   AND CTB_CODPOR = :CODPOR ';

      If (fltValLan <> 0) And (chkLancSimilares.Checked) Then
        strSQL := strSQL + '   AND CTB_VALLAN = :VALLAN ';

      If(strCreDeb <> '') And (chkLancSimilares.Checked) Then
        strSQL := strSQL + '   AND CTB_CREDEB = :CREDEB ';

      If fCfgSis('USAAUT', varBoolean) Then
        strSQL := strSQL + ' AND M.CTB_TRFLIB<>"N" ';

      Sql.Text := strSQL;
      ParamByName('DTAINI').AsDate := dtaIni;
      ParamByName('DTAFIN').AsDate := dtaFin;

      pSetaParam(mskCodCta.Text, arrCCusto, strCCusto, 'CODCTA', qryLanPen);

      If strCodPor  <> '' Then
        ParamByName('CODPOR').AsString := strCodPor;

      If (fltValLan <> 0) And (chkLancSimilares.Checked) Then
        ParamByName('VALLAN').AsFloat  := fltValLan;

      If (strCreDeb <> '') And (chkLancSimilares.Checked) Then
        ParamByName('CREDEB').AsString := strCreDeb;

      Open;
    End;

  End;
end;

procedure TfrmCadConcilBancNova.pCarregaRegistros;
begin
  qryLanCon.Close;

  If (Assigned(qryExtrato.FindField('EXT_SITUAC'))) and
     (qryExtrato.FieldByName('EXT_SITUAC').AsString = 'R') Then
    pCarregaLanConcil;

  qryLanPen.Close;
  If qryExtrato.FieldByName('EXT_SITUAC').AsString = 'N' Then
  Begin
    pCarregaPendente(dtaIniExt.Date,
                     dtaFinExt.Date,
                     qryExtrato.FieldByName('EXT_CODPOR').AsString);

    pCarregaLanConcil;

    dtaPenIni.Date := dtaIniExt.Date;
    dtaPenFin.Date := dtaFinExt.Date;
    chkLancSimilares.Checked := False;
  End;

  If MatchStr(qryExtrato.FieldByName('EXT_SITUAC').AsString, ['S', 'A']) Then
  Begin
    dtaPenIni.Date := qryExtrato.FieldByName('EXT_DTALAN').AsDateTime;
    dtaPenFin.Date := qryExtrato.FieldByName('EXT_DTALAN').AsDateTime;
    chkLancSimilares.Checked := True;
    btnPesqPend.Click;
  End;
end;

procedure TfrmCadConcilBancNova.pChamarTelaDetalhe(strSeqLan,strOrigem: String);
begin
  ApplicationEvents.OnMessage := Nil;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(78, 5338, [5339,5340,5341,5342,5343],
                        ['SEQLAN'],
                        [strSeqLan],
                        nil,
                        nil,
                        True);
  End;

  ApplicationEvents.OnMessage := ApplicationEventsMessage;
end;

procedure TfrmCadConcilBancNova.pConciliarRegistros(strExtInc: String; dteDataCon: TDate; AstrNomeArquivoImportacao: String);
  Var
    LAutoIncrems,
    LMovBanAtual: String;

    LAtualiza: TUniQuery;
begin
  If strExtInc.IsEmpty Then
    Exit;

  LAutoIncrems := '';

  Try
    LAtualiza := fCriaQuery;
    LAtualiza.SQL.Text := ' SELECT    ' +
                          '  B.*      ' +
                          ' FROM      ' +
                          '  BANEXR B ' +
                          ' WHERE    ' +
                          '  B.EXR_EXTINC = "' + strExtInc + '"';

    If FMovBanAtualizado.Count > 0 Then
    Begin
      For LMovBanAtual In FMovBanAtualizado Do
        LAutoIncrems := LAutoIncrems + '"' + LMovBanAtual + '",';

      LAutoIncrems := LeftStr(LAutoIncrems, LAutoIncrems.Length - 1);

      LAtualiza.SQL.Add(' AND EXR_BANINC NOT IN (' + LAutoIncrems + ')');
    End;

    LAtualiza.Open;

    LAutoIncrems := '';
    While Not LAtualiza.Eof Do
    Begin
      FMovBanAtualizado.Add(LAtualiza.FieldByName('EXR_BANINC').AsString);

      LAutoIncrems := LAutoIncrems + '"' + LAtualiza.FieldByName('EXR_BANINC').AsString + '",';

      LAtualiza.Next;
    End;
    LAutoIncrems := LeftStr(LAutoIncrems, LAutoIncrems.Length - 1);

    LAtualiza.Close;

    If FechamentoFinanceiroRealizado(LAutoIncrems, dteDataCon) Then
    Begin
      AComita := False;
      AFechamentoRealizado := True;
      Exit;
    End;

    //Atualizando a EXTBAN
    LAtualiza.Close;
    LAtualiza.SQL.Text := 'UPDATE EXTBAN SET EXT_DTACON = :DTACON, EXT_OPECON = :OPECON, EXT_HORCON = :HORCON ' +
                          ' WHERE AUTOINCREM = :AUTOINC AND EXT_DTACON IS NULL';

    LAtualiza.ParamByName('DTACON').AsDateTime := VS_Date;
    LAtualiza.ParamByName('HORCON').AsString   := FormatDateTime('hh:nn:ss', fTime());
    LAtualiza.ParamByName('OPECON').AsString   := strLoginUsuarioLogado;
    LAtualiza.ParamByName('AUTOINC').AsString  := strExtInc;

    LAtualiza.ExecSQL;

    //Atualizando a MOVBAN
    If Not LAutoIncrems.IsEmpty Then
    Begin

      untMovBan.GravaLogCbaRegistrosConciliados(strExtInc,
                                                AstrNomeArquivoImportacao,
                                               'CONCILIOU LANÇAMENTO',
                                                Self.Name,
                                                dteDataCon,
                                                FormatDateTime('hh:nn:ss', fTime()),
                                                strLoginUsuarioLogado,
                                                FSQLInsertLogCba);

      LAtualiza.Close;
      LAtualiza.SQL.Text := 'UPDATE                                                '+
                            '  MOVBAN                                              '+
                            '  JOIN                                                '+
                            '    (SELECT                                           '+
                            '      M.AUTOINCREM                                    '+
                            '    FROM                                              '+
                            '      BANEXR                                          '+
                            '      JOIN MOVBAN M                                   '+
                            '        ON M.AUTOINCREM = EXR_BANINC                  '+
                            '    WHERE EXR_EXTINC = :EXTINC) AS TMP                '+
                            '    ON TMP.AUTOINCREM = MOVBAN.AUTOINCREM             '+
                            '    SET CTB_DTACON = :DTACON,                         '+
                            '        CTB_HORCON = :HORCON,                         '+
                            '        CTB_OPECON = :OPECON                          '+
                            'WHERE CTB_DTACON IS NULL                              ';


      LAtualiza.ParamByName('DTACON').AsDateTime := dteDataCon;
      LAtualiza.ParamByName('HORCON').AsString   := FormatDateTime('hh:nn:ss', fTime());
      LAtualiza.ParamByName('OPECON').AsString   := strLoginUsuarioLogado;
      LAtualiza.ParamByName('EXTINC').AsString   := strExtInc;
      LAtualiza.ExecSQL;

      If LAtualiza.RowsAffected > 0 Then
      Begin
        //Faz o update em todos os registros da EXTBAN, mesmo que não esteja selecionado no grid REQ 172308
        ConciliaExtBanDeTodosRegistrosVinculados(LAutoIncrems, strExtInc);
      End;

    End;

    FreeAndNil(LAtualiza);
  Except
    On E: Exception Do
      raise Exception.Create(E.Message);
  End;
end;

function TfrmCadConcilBancNova.fIdentificarExtBanSimilares(AProgressBar: TcxProgressBar): Boolean;
var
  LListaAdicionarSimilares,
  LListaRemocaoSimilares: TStringList;
  LDataSetExtBan: TDataset;
  LBackupExtBanRecNo: Integer;
  LAutoIncremento,
  LCreditoDebito,
  LDtaLancamento,
  LVlrLancamento: String;
  LQtdMovBanPendente: Integer;
begin
//  Lancamento similar "A":
//  Quando houver mais de um EXTBAN(Crédito/Débito;Data;Valor) não relacionado para um único MOVBAN.

//  Lancamento similar "S":
//  Quando houver mais de um MOVBAN(Crédito/Débito;Data;Valor) não relacionado para um único EXTBAN.

  Result := True;

  LDataSetExtBan := dsExtrato.Dataset;

  if (LDataSetExtBan.IsEmpty) then
    Exit;

  LDataSetExtBan.DisableControls;
  LListaAdicionarSimilares := TStringList.Create;
  LListaRemocaoSimilares := TStringList.Create;
  LBackupExtBanRecNo := LDataSetExtBan.RecNo;
  try
    try
      LDataSetExtBan.First;

      LListaAdicionarSimilares.Delimiter := ',';
      LListaRemocaoSimilares.Delimiter := ',';

      AProgressBar.Properties.Max := LDataSetExtBan.RecordCount;
      AProgressBar.Position := 0;

      while not LDataSetExtBan.Eof do
      begin
        if not MatchStr(LDataSetExtBan.FieldByName('EXT_SITUAC').AsString, ['N', 'A', 'S']) then
        begin
          pStepStatusGravacao(AProgressBar);
          LDataSetExtBan.Next;
          Continue;
        end;

        LAutoIncremento := QuotedStr(LDataSetExtBan.FieldByName('AUTOINCREM').AsString);
        LCreditoDebito := QuotedStr(LDataSetExtBan.FieldByName('EXT_CREDEB').AsString);
        LDtaLancamento := QuotedStr(FormatDateTime('dd-mm-yyyy', LDataSetExtBan.FieldByName('EXT_DTALAN').AsDatetime));
        LVlrLancamento := QuotedStr(fFloatToStrVirgula(LDataSetExtBan.FieldByName('EXT_VALLAN').AsFloat, 15, 2));
        LQtdMovBanPendente := -1;

        if fTemMultiplosExtBanParaUnicoMovBan(LCreditoDebito, LDtaLancamento, LVlrLancamento, LQtdMovBanPendente) then
        begin
          if (LDataSetExtBan.FieldByName('EXT_SITUAC').AsString = 'N') then
          begin
            LDataSetExtBan.Edit;
            LDataSetExtBan.FieldByName('EXT_SITUAC').AsString := 'A';
            LDataSetExtBan.Post;

            LListaAdicionarSimilares.Add(LAutoIncremento);
          end;
        end
        else if LDataSetExtBan.FieldByName('EXT_SITUAC').AsString = 'A' then
        begin
          LDataSetExtBan.Edit;
          LDataSetExtBan.FieldByName('EXT_SITUAC').AsString := 'N';
          LDataSetExtBan.Post;

          LListaRemocaoSimilares.Add(LAutoIncremento);
        end
        else if LDataSetExtBan.FieldByName('EXT_SITUAC').AsString = 'S' then
        begin
          if LQtdMovBanPendente < 0 then
            LQtdMovBanPendente := fQuantidadeMovBanSimilarPendente;

          if LQtdMovBanPendente in [0,1] then
          Begin
            LDataSetExtBan.Edit;
            LDataSetExtBan.FieldByName('EXT_SITUAC').AsString := 'N';
            LDataSetExtBan.Post;

            LListaRemocaoSimilares.Add(LAutoIncremento);
          end;
        end;

        pStepStatusGravacao(AProgressBar);
        LDataSetExtBan.Next;
      end;
    except
      on e: Exception do
      Begin
        Result := False;
        LListaAdicionarSimilares.Clear;
        LListaRemocaoSimilares.Clear;
        pMensagensErro('Ocorreu um erro ao identificar lançamentos similares no extrato bancário:' + #13 +
                       'Erro gerado: ' + e.Message, '[TfrmCadConcilBancNova.pIdentificarExtBanSimilares]');
      End;
    end;

    if not Result then
      Exit;

    if not fStartTransaction then
      Exit(False);

    try
      if (LListaAdicionarSimilares.Count > 0) then
        AtualizaSituacaoExtBan(LListaAdicionarSimilares.DelimitedText, 'A');

      if (LListaRemocaoSimilares.Count > 0) then
        AtualizaSituacaoExtBan(LListaRemocaoSimilares.DelimitedText, 'N');

      fCommit;
    except
      on e: Exception do
      begin
        Result := False;
        fRollback;
        Try
          LDataSetExtBan.Refresh;
        Except
          // dataset permanecerá desatualizado até próximo reload
        End;
        pMensagensErro('Ocorreu um erro ao gravar lançamentos similares no extrato bancário:' + #13 +
                       'Erro gerado: ' + e.Message, '[TfrmCadConcilBancNova.pIdentificarExtBanSimilares]');
      end;
    end;
  finally
    FreeAndNil(LListaAdicionarSimilares);
    FreeAndNil(LListaRemocaoSimilares);
    LDatasetExtBan.RecNo := LBackupExtBanRecNo;
    LDatasetExtBan.EnableControls;
  end;
end;

function TfrmCadConcilBancNova.fTemMultiplosExtBanParaUnicoMovBan(
  ACreditoDebito,
  ADtaLancamento,
  AVlrLancamento: string;
  out AQtdMovBanPendente: Integer): Boolean;
var
  LQtdExtBanSimilar: Integer;
begin
  Result := False;
  AQtdMovBanPendente := -1;

  LQtdExtBanSimilar := fQuantidadeExtBanSimilar(ACreditoDebito, ADtaLancamento, AVlrLancamento);

  if LQtdExtBanSimilar <= 1 then
    Exit;

  AQtdMovBanPendente := fQuantidadeMovBanSimilarPendente;

  if AQtdMovBanPendente > 0 then
    Result := LQtdExtBanSimilar > AQtdMovBanPendente;
end;

function TfrmCadConcilBancNova.fQuantidadeMovBanSimilarPendente: Integer;
var
  LDatasetExtBan,
  LDatasetMovBan: TDataset;
begin
  LDatasetMovBan := dsLanPend.Dataset;
  LDatasetExtBan := dsExtrato.Dataset;
  try
    LDatasetMovBan.DisableControls;
    chkLancSimilares.Checked := True;
    pCarregaPendente(LDatasetExtBan.FieldByName('EXT_DTALAN').AsDatetime,
                     LDatasetExtBan.FieldByName('EXT_DTALAN').AsDatetime,
                     LDatasetExtBan.FieldByName('EXT_CODPOR').AsString,
                     LDatasetExtBan.FieldByName('EXT_VALLAN').AsFloat,
                     LDatasetExtBan.FieldByName('EXT_CREDEB').AsString);

    Result := LDatasetMovBan.RecordCount;
  finally
    LDatasetMovBan.EnableControls;
    LDatasetMovBan.Close;
    chkLancSimilares.Checked := False;
  end;
end;

function TfrmCadConcilBancNova.fQuantidadeExtBanSimilar(ACreditoDebito, ADtaLancamento, AVlrLancamento: string): Integer;
var
  LDatasetExtBan: TDataset;
  LBackupExtBanRecNo: Integer;
begin
  LDatasetExtBan := dsExtrato.Dataset;
  LBackupExtBanRecNo := LDatasetExtBan.RecNo;
  try
    LDatasetExtBan.Filtered := False;
    LDatasetExtBan.Filter :=
      ' EXT_SITUAC NOT IN ("R", "I") AND '+
      ' EXT_CREDEB = '+ACreditoDebito+' AND '+
      ' EXT_DTALAN = '+ADtaLancamento+' AND '+
      ' EXT_VALLAN = '+AVlrLancamento;
    LDatasetExtBan.Filtered := True;

    Result := LDatasetExtBan.RecordCount;
  finally
    LDatasetExtBan.Filtered := False;
    LDatasetExtBan.Filter := '';
    LDatasetExtBan.RecNo := LBackupExtBanRecNo;
  end;
end;


procedure TfrmCadConcilBancNova.pImprimirExtratoBancario;
   Var
     LCodBan : String;
     LVideo  : Boolean;
     qryCfgRel : TUniQuery;
     strNomImp : String;
     strTipImp : String;
     LRecNo: Integer;
     LFilter : String;
     LFiltered : Boolean;
begin

  LRecNo    := dsExtrato.DataSet.RecNo;
  LFilter   := dsExtrato.DataSet.Filter;
  LFiltered := dsExtrato.DataSet.Filtered;

  Try
    LVideo :=  (fMensagem('','Saída',['&Vídeo','&Imprimir']) = 1);
    qryCfgRel := fCriaQuery(Nil);
    strNomImp := '';
    strTipImp := '';

    Try

      If Not LVideo Then
      Begin
        pCarregaConfImpr(qryCfgRel, Self.Name);
        strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
        strTipImp := 'J';

        If fEmptyStr(strNomImp) Then
          fPreImpressao(qryCfgRel, strNomImp, strTipImp, False);

        If VerImpressoraONLINE(strNomImp) <> 0 Then
          strNomImp := ' ';

        If Not fEmptyStr(strNomImp) Then
        Begin
          frxExtratoBancario.PrintOptions.ShowDialog := False;
          frxExtratoBancario.PrintOptions.Printer    := strNomImp;
        End;

      End;

      dtsRelExtBan.DataSet := dsExtrato.DataSet;
      dsExtrato.DataSet.DisableControls;

      dtsRelExtBan.DataSet.Filtered := False;
      dtsRelExtBan.DataSet.Filter   := grdExtratoDBTableView1.DataController.Filter.FilterText;
      dtsRelExtBan.DataSet.Filtered := True;

      LCodBan := dtsRelExtBan.DataSet.FieldByName('EXT_CODBCO').AsString;
      frxExtratoBancario.Script.Variables['EMPRESA']  := fRetNomeEmpresa;
      frxExtratoBancario.Script.Variables['DTAINI']   := FormatDateTime('dd/MM/yyyy',StrToDate(edtDataInicial.Text));
      frxExtratoBancario.Script.Variables['DTAFIN']   := FormatDateTime('dd/MM/yyyy',StrToDate(edtDataFinal.Text));
      frxExtratoBancario.Script.Variables['AGENCIA']  := edtCodAge.Text;
      frxExtratoBancario.Script.Variables['CONTA']    := edtCodCCa.Text;
      frxExtratoBancario.Script.Variables['PORTADOR'] := edtPortador.Text;
      frxExtratoBancario.Script.Variables['BANCO']    := LCodBan +' - ' + fRetNomeBancoSelec(LCodBan);
      TfrxMemoView(frxExtratoBancario.FindObject('mmoDetalhe')).Highlight.Color := fCfgSis('CORZEB');

      If frxExtratoBancario.PrepareReport Then
      Begin
        If Not LVideo Then
          pPrintReport(Self.Name, Self.Caption + ' (Extrato)', strNomImp, frxExtratoBancario)
        Else
          pPreviewReport(Self.Name, Self.Caption + ' (Extrato)', frxExtratoBancario);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[pImprimirExtratoBancario]');
      End;
    End;
  Finally
    FreeAndNil(qryCfgRel);
    dsExtrato.DataSet.Filtered := False;
    dsExtrato.DataSet.Filter   := LFilter;
    dsExtrato.DataSet.Filtered := LFiltered;
    dsExtrato.DataSet.RecNo    := LRecNo;
    dsExtrato.DataSet.EnableControls;
  End;
end;

procedure TfrmCadConcilBancNova.pInserirLancamentoExtBan(Arquivo: TOFX;
  ofxLancamento: TOFXItem; strNomeArquivo, strTipImp, strCodPor: String);
Var
  qryExtrato: TUniQuery;
begin
  qryExtrato := Nil;
  Try
    qryExtrato := fCriaQuery();
    With  qryExtrato Do
    Begin
      Sql.Clear;
      Sql.Text := ' INSERT INTO  '  +
                  '   EXTBAN     '  +
                  ' SET          '  +
                  '   AUTOINCREM = :AUTOIN, ' +
                  '   EXT_SITUAC = "N",     ' +
                  '   EXT_CODPOR = :CODPOR, ' +
                  '   EXT_CODEMP = :CODEMP, ' +
                  '   EXT_CODCTA = :CODCTA, ' +
                  '   EXT_AGENCI = :AGENCI, ' +
                  '   EXT_CODBCO = :CODBCO, ' +
                  '   EXT_CREDEB = :CREDEB, ' +
                  '   EXT_VALLAN = :VALLAN, ' +
                  '   EXT_DTALAN = :DTALAN, ' +
                  '   EXT_AUTORI = :AUTORI, ' +
                  '   EXT_HISTOR = :HISTOR, ' +
                  '   EXT_OPEIMP = :OPEIMP, ' +
                  '   EXT_DTAIMP = :DTAIMP, ' +
                  '   EXT_TIPIMP = :TIPIMP, ' +
                  '   EXT_ARQIMP = :ARQIMP, ' +
                  '   EXT_DOCOFX = :DOCOFX, ' +
                  '   EXT_HORIMP = :HORIMP  ';

      ParamByName('AUTOIN').AsString := fRetAutoIncrem('EXTBAN', VS_strCodEmp);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODPOR').AsString := strCodPor;
      ParamByName('CODCTA').AsString := Arquivo.ContaID;
      ParamByName('AGENCI').AsString := Arquivo.AgenciaID;
      ParamByName('CODBCO').AsString := Arquivo.BancoID;
      ParamByName('CREDEB').AsString := Copy(ofxLancamento.Tipo, 1, 1).ToUpper;
      ParamByName('VALLAN').AsFloat  := ofxLancamento.Valor;
      ParamByName('DTALAN').AsDate   := ofxLancamento.Data;
      ParamByName('AUTORI').AsString := ofxLancamento.Documento;
      ParamByName('HISTOR').AsString := ofxLancamento.Descricao.ToUpper;
      ParamByName('OPEIMP').AsString := strLoginUsuarioLogado;
      ParamByName('DTAIMP').AsDate   := VS_Date;
      ParamByName('TIPIMP').AsString := strTipImp;
      ParamByName('ARQIMP').AsString := strNomeArquivo;
      ParamByName('DOCOFX').AsString := ofxLancamento.CheckNum;
      ParamByName('HORIMP').AsTime   := fTime;

      ExecSQL;
    End;
  Finally
    FreeAndNil(qryExtrato);
  End;
end;

procedure TfrmCadConcilBancNova.pLimpaEdits;
begin
  edtDataInicial.Clear;
  edtDataFinal.Clear;
  edtCodAge.Clear;
  edtCodCCa.Clear;
  edtPortador.Clear;
  edtSalPor.Clear;
  dtaIniExt.Date := fNow;
  dtaFinExt.Date := fNow;
  dtaPenIni.Date := fNow;
  dtaPenFin.Date := fNow;
end;

class procedure TfrmCadConcilBancNova.pMostraCarregandoExtrato(
  AExtratoBancario: TExtratoBancario);
  Var
    frmCadConcilBancNova: TfrmCadConcilBancNova;
begin
  frmCadConcilBancNova := TfrmCadConcilBancNova.Create(nil);

  With frmCadConcilBancNova Do
  Begin
    If Assigned(AExtratoBancario) Then
    Begin
      dsExtrato.OnDataChange := nil;
      qryExtrato.Close;
      qryExtrato.Sql.Clear;
      qryExtrato.Sql.Text := 'SELECT * FROM EXTBAN WHERE FALSE ';
      qryExtrato.Open;

      pCarregaExtrato(AExtratoBancario);
      pCarregaRegistros;
      pAtualizaTotais;

      dsExtrato.OnDataChange  := dsExtratoDataChange;

      {if not qryExtrato.isEmpty then
      begin
        if qryPenden.Locate('EXT_CODBCO', AExtratoBancario.CodBco,[]) then
        begin
          qryPenden.Edit;
          qryPenden.FieldByName('MARCADO').AsString := 'S';
          qryPenden.Post;
        end;
      end;}

      FExtBancario := AExtratoBancario;
    end;
    ShowModal;
  end;

  FreeAndNil(frmCadConcilBancNova);
end;

function TfrmCadConcilBancNova.PortadoresDosLancamentosSaoDiferentes(
  AAutoIncremsMovban, AAutoIncremsExtban: String): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT CTB_CODPOR AS PORTADOR ' +
                          'FROM MOVBAN ' +
                          'WHERE AUTOINCREM IN (' + AAutoIncremsMovban + ') ' +
                          'GROUP BY CTB_CODPOR ' +
                          'UNION ' +
                          'SELECT EXT_CODPOR AS PORTADOR ' +
                          'FROM EXTBAN ' +
                          'WHERE AUTOINCREM IN (' + AAutoIncremsExtban + ') ' +
                          'GROUP BY EXT_CODPOR ';
    LConsulta.Open;

    Result := LConsulta.Recordcount > 1;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmCadConcilBancNova.pSelecinaLancExtratos;
var
  qryConsulta: TUniQuery;
  i: Integer;
begin
  If Not qryLanCon.IsEmpty Then
  Begin
    qryConsulta := fCriaQuery;
    With qryConsulta Do
    Begin
      Sql.Clear;
      Sql.Text := 'SELECT * FROM BANEXR WHERE EXR_BANINC = :BANINC';
      ParamByName('BANINC').AsString := qryLanCon.FieldByName('AUTOINCREM').AsString;

      Open;

      If RecordCount > 0 Then
      Begin
        With grdExtratoDBTableView1 Do
        Begin
          BeginUpdate();
          Controller.ClearSelection;

          For I := 0 To ViewData.RecordCount - 1 Do
            ViewData.Records[I].Selected := False;

          EndUpdate();
        End;

        grdExtratoDBTableView1.BeginUpdate();
        grdExtratoDBTableView1.Controller.SelectAllColumns();
        While Not eof Do
        Begin
          With grdExtratoDBTableView1 Do
          Begin
            For I := 0 To ViewData.RecordCount - 1 Do
            Begin
              If FieldByName('EXR_EXTINC').AsString =  ViewData.Records[I].Values[grdExtratoDBTableView1AUTOINCREM.Index] Then
              Begin
                ViewData.Records[I].Selected := True;
                Break;
              End;
            End;
          End;
          Next;
        End;
       grdExtratoDBTableView1.EndUpdate();
      End;
    End;
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmCadConcilBancNova.pSelecionaCartoes;
var
  i: Integer;
  strCodEmp,
  strPagCon: String;
begin
  If ((Not qryLanPen.IsEmpty) and (grdLancPendentesDBTableView1.ViewData.RecordCount > 0) and (grdLancPendentesDBTableView1.DataController.GetSelectedCount = 1)) Then
  Begin
    If qryLanPen.FieldByName('CTB_ORIGEM').AsString = 'MCA' Then
    Begin
      strCodEmp := qryLanPen.FieldByName('CTB_CODEMP').AsString;
      strPagCon := qryLanPen.FieldByName('CTB_PAGCON').AsString;

      If fEmptyStr(strPagCon) Then
        Exit;

      With grdLancPendentesDBTableView1 Do
      Begin
        BeginUpdate();
        Controller.ClearSelection;

        For I := 0 To ViewData.RecordCount - 1 Do
          ViewData.Records[I].Selected := False;

        EndUpdate();
      End;
  
      With grdLancPendentesDBTableView1 Do
      Begin
        BeginUpdate();
        For I := 0 To ViewData.RecordCount - 1 Do
        Begin
          IF ((ViewData.Records[I].Values[grdLanpenDBCTB_PAGCON.Index] = strPagCon) And
              (ViewData.Records[I].Values[grdLanpenDBCTB_CODEMP.Index] = strCodEmp) And
              (ViewData.Records[I].Values[grdLanpenDBCTB_ORIGEM.Index] = 'MCA')) Then
          Begin
            ViewData.Records[I].Selected := True;
          End;
        End;

        EndUpdate();
      End;
    End;
  End;
end;

procedure TfrmCadConcilBancNova.pVerificaConcilConclusao;
begin
  If Not qryExtrato.IsEmpty Then
  Begin
    dsExtrato.OnDataChange := nil;
    With qryExtrato Do
    Begin
      DisableControls;
      Filtered := False;
      Filter   := 'EXT_SITUAC <> "I" AND EXT_SITUAC <> "C"';
      Filtered := True;

      If IsEmpty Then
      Begin
        pLimpaEdits;
        pCarregaRegistros;
        pAtualizaTotais;
        FreeAndNil(FExtBancario);
        btnAtualizarPend.Click;
        qryLanCon.Close;
        qryLanPen.Close;
        qryTotais.Close;
        qryExtrato.Close;
        pMensagemOk('Extrato bancário conciliado com sucesso!');
      End;
      dsExtrato.OnDataChange := dsExtratoDataChange;

      Filtered := False;
      Filter   := '';
      EnableControls;
    End;
  End;
end;

procedure TfrmCadConcilBancNova.pVerificarBaixaBoletoAutbanAnalitico(const dtaIni,
  dtaFin: TDate; const strCodPor: String);
var
 qryMovBan,
 qryTarifa: TUniQuery;
 strSQL: String;
 intRecNo, j: Integer;
 FGravando : IObserver_;
 FSubject  : ISubject_;
 strParameter: Array of String;
 arrSeqLan: TArray<String>;
 fltValDif: Double;
begin
  Try
    qryMovBan := fCriaQuery;

    With qryMovBan Do
    Begin
      Sql.Clear;
      strSQL :=   ' SELECT ' +
                  '   *    ' +
                  ' FROM   ' +
                  '   MOVBAN M ' +
                  ' LEFT JOIN BANEXR B ON B.EXR_BANINC = M.AUTOINCREM ' +
                  ' WHERE  ' +
                  '   M.CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN ' +
                  '   AND CTB_DTACON IS NULL AND CTB_SERIE_ = "BLT" AND CTB_HIST01 LIKE "%Ref. ao pagamento de tarifas%"  AND B.AUTOINCREM IS NULL ';

      If strCodPor  <> '' Then
        strSQL := strSQL + '   AND CTB_CODPOR = :CODPOR ';


      Sql.Text := strSQL;
      ParamByName('DTAINI').AsDate := dtaIni;
      ParamByName('DTAFIN').AsDate := dtaFin;

      If strCodPor  <> '' Then
        ParamByName('CODPOR').AsString := strCodPor;

      Open;
    End;

    If Not qryMovBan.IsEmpty Then
    Begin
      qryExtrato.DisableControls;
      intRecNo := qryExtrato.RecNo;
      qryExtrato.First;

      FGravando := TGravandoObs.Create;
      FSubject  := TSubject.Create;
      FSubject.pAddObserver(FGravando);
      SetLength(strParameter, 4);

      //Preparando array de parametros que será responsavel pelas Notificações com o objeto observador.
      SetLength(strParameter,4);
      strParameter[0] := 'TcxProgressBar';
      strParameter[1] := IntToStr(qryExtrato.RecordCount);
      strParameter[2] := 'Verificando lançamentos...';

      //Enviando Notificação que vai atualizar os observadores.
      FSubject.pNotify(strParameter);

      While Not qryExtrato.Eof Do
      Begin
        Application.ProcessMessages;
        If qryExtrato.FieldByName('EXT_SITUAC').AsString <>  'R' Then
        Begin
          //Atualizando os observadores
          strParameter[2] := 'Verificando lançamentos...';
          strParameter[3] := IntToStr(qryExtrato.RecNo);
          FSubject.pNotify(strParameter);

          qryMovBan.Filtered := False;
          qryMovBan.Filter   := ' CTB_DTALAN = "' + FormatDateTime('yyyy-mm-dd', qryExtrato.FieldByName('EXT_DTALAN').AsDateTime) + '" AND ' +
                                ' CTB_CREDEB = "' + qryExtrato.FieldByName('EXT_CREDEB').AsString + '"';
          qryMovBan.Filtered := True;

          If (qryMovBan.RecordCount >= 1) Then
          Begin
            fExecutaSQL('SET SESSION group_concat_max_len = 65535');

            While Not qryMovBan.Eof Do
            Begin
              qryTarifa := fCriaQuery;

              Application.ProcessMessages;
              With qryTarifa Do
              Begin
                Sql.Clear;
                Sql.Text := ' SELECT ' +
                            '   SUM(R.CTR_VALREC- P.CTP_VALPAG) AS VALLAN, ' +
                            '   GROUP_CONCAT(R.CTR_DOCBAI) AS SEQLAN ' +
                            ' FROM ' +
                            '   CADPAG P ' +
                            ' JOIN CADREC R ON R.CTR_AUTCTP = P.AUTOINCREM ' +
                            ' WHERE P.CTP_SEQCON = :SEQCON AND P.CTP_EMPBAI = :EMPBAI ' +
                            ' GROUP BY P.CTP_SEQCON ';

                ParamByName('SEQCON').Value := qryMovBan.FieldByName('CTB_PAGCON').Value;
                ParamByName('EMPBAI').Value := qryMovBan.FieldByName('CTB_EMPDUP').Value;

                Open;

                If Not IsEmpty Then
                Begin
                  fltValDif := FieldByName('VALLAN').AsFloat - qryExtrato.FieldByName('EXT_VALLAN').AsFloat;
                  If fltValDif < 0 Then
                      fltValDif := fltValDif *(-1);

                  If ((FieldByName('VALLAN').AsFloat = qryExtrato.FieldByName('EXT_VALLAN').AsFloat) Or
                      (fFormataFloat(fltValDif, 2) <= fFormataFloat(fltValTol, 2))) Then
                  Begin
                    arrSeqLan := FieldByName('SEQLAN').AsString.Split([',']);
                    For j:= 0 To Length(arrSeqLan)-1 Do
                    Begin

                      //Atualizando os observadores
                      strParameter[2] := 'Vinculando lançamentos...';
                      FSubject.pNotify(strParameter);

                      If fRetornaAutoincremMovBan(arrSeqLan[j]) <> '' Then
                         fVinculaExtMovBan(fRetornaAutoincremMovBan(arrSeqLan[j]), qryExtrato.FieldByName('AUTOINCREM').AsString, True, []);

                      Application.ProcessMessages;
                    End;

                    fVinculaExtMovBan(qryMovBan.FieldByName('AUTOINCREM').Value, qryExtrato.FieldByName('AUTOINCREM').AsString, True, []);

                    If ExtratoRelacionadoComSucesso(qryExtrato.FieldByName('AUTOINCREM').AsString) Then
                    Begin
                      qryExtrato.Edit;
                      qryExtrato.FieldByName('EXT_SITUAC').AsString :=  'R';
                      qryExtrato.Post;
                    End;

                  End;
                End;
              End;
              FreeAndNil(qryTarifa);
              qryMovBan.Next;
            End;

            fExecutaSQL('SET SESSION group_concat_max_len = 3072');
          End;
        End;

        qryExtrato.Next;
      End;

      qryExtrato.RecNo := intRecNo;
      qryExtrato.EnableControls;
    End;

    FreeAndNil(qryMovBan);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TfrmCadConcilBancNova.pVerificarBaixaBoletoAutbanSintetico(
  const dtaIni, dtaFin: TDate; const strCodPor: String);
var
 qryMovBan,
 qryTarifa: TUniQuery;
 strSQL: String;
 intRecNo, j: Integer;
 FGravando : IObserver_;
 FSubject  : ISubject_;
 strParameter: Array of String;
 arrSeqLan: TArray<String>;
 strPagCon: String;
 fltValDif: Double;
begin
  Try
    qryMovBan := fCriaQuery;

    With qryMovBan do
    Begin
      Sql.Clear;
      strSQL :=   ' SELECT ' +
                  '   *    ' +
                  ' FROM   ' +
                  '   MOVBAN M ' +
                  ' LEFT JOIN BANEXR B ON B.EXR_BANINC = M.AUTOINCREM ' +
                  ' WHERE  ' +
                  '   M.CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN ' +
                  '   AND CTB_DTACON IS NULL AND CTB_SERIE_ = "BLT" AND CTB_HIST01 LIKE "%Ref. ao pagamento de tarifas%" AND B.AUTOINCREM IS NULL ';

      If strCodPor  <> '' Then
        strSQL := strSQL + '   AND CTB_CODPOR = :CODPOR ';


      Sql.Text := strSQL;
      ParamByName('DTAINI').AsDate := dtaIni;
      ParamByName('DTAFIN').AsDate := dtaFin;

      If strCodPor  <> '' Then
        ParamByName('CODPOR').AsString := strCodPor;

      Open;
    End;

    If Not qryMovBan.IsEmpty Then
    Begin
      qryExtrato.DisableControls;
      intRecNo := qryExtrato.RecNo;
      qryExtrato.First;

      FGravando := TGravandoObs.Create;
      FSubject  := TSubject.Create;
      FSubject.pAddObserver(FGravando);
      SetLength(strParameter, 4);

      //Preparando array de parametros que será responsavel pelas Notificações com o objeto observador.
      SetLength(strParameter,4);
      strParameter[0] := 'TcxProgressBar';
      strParameter[1] := IntToStr(qryExtrato.RecordCount);
      strParameter[2] := 'Verificando lançamentos...';

      //Enviando Notificação que vai atualizar os observadores.
      FSubject.pNotify(strParameter);

      While Not qryExtrato.Eof do
      Begin
        Application.ProcessMessages;
        If qryExtrato.FieldByName('EXT_SITUAC').AsString <>  'R' Then
        Begin
          //Atualizando os observadores
          strParameter[2] := 'Verificando lançamentos...';
          strParameter[3] := IntToStr(qryExtrato.RecNo);
          FSubject.pNotify(strParameter);

          qryMovBan.Filtered := False;
          qryMovBan.Filter   := ' CTB_DTALAN = "' + FormatDateTime('yyyy-mm-dd', qryExtrato.FieldByName('EXT_DTALAN').AsDateTime) + '"';
          qryMovBan.Filtered := True;

          If (qryMovBan.RecordCount >= 1) Then
          Begin
            strPagCon := '';
            While Not qryMovBan.Eof do
            Begin
              Application.ProcessMessages;
              strPagCon := strPagCon+ qryMovBan.FieldByName('CTB_PAGCON').AsString + ',';

              qryMovBan.Next;
            End;

            strPagCon := Copy(strPagCon, 1, Length(strPagCon)-1);

            fExecutaSQL('SET SESSION group_concat_max_len = 65535');

            qryTarifa := fCriaQuery;

            With qryTarifa do
            Begin
              Sql.Clear;
              Sql.Text := ' SELECT ' +
                          '   SUM(R.CTR_VALREC- P.CTP_VALPAG) AS VALLAN, ' +
                          '   GROUP_CONCAT(R.CTR_DOCBAI) AS SEQLAN ' +
                          ' FROM ' +
                          '   CADPAG P ' +
                          ' JOIN CADREC R ON R.CTR_AUTCTP = P.AUTOINCREM ' +
                          ' JOIN MOVBAN M ON M.CTB_PAGCON = P.CTP_SEQCON ' +
                          ' WHERE P.CTP_SEQCON IN ('+strPagCon+') AND ' +
                          '       P.CTP_EMPBAI = :EMPBAI' ;

              ParamByName('EMPBAI').AsString := VS_strCodEmp;

              Open;

              If Not IsEmpty Then
              Begin
                fltValDif := FieldByName('VALLAN').AsFloat - qryExtrato.FieldByName('EXT_VALLAN').AsFloat;
                If fltValDif < 0 Then
                    fltValDif := fltValDif *(-1);

                If ((FieldByName('VALLAN').AsFloat = qryExtrato.FieldByName('EXT_VALLAN').AsFloat) Or
                    (fFormataFloat(fltValDif, 2) <= fFormataFloat(fltValTol, 2))) Then
                Begin
                  arrSeqLan := FieldByName('SEQLAN').AsString.Split([',']);
                  For j:= 0 To Length(arrSeqLan)-1 do
                  Begin
                    //Atualizando os observadores
                    strParameter[2] := 'Vinculando lançamentos...';
                    FSubject.pNotify(strParameter);

                    If fRetornaAutoincremMovBan(arrSeqLan[j]) <> '' Then
                      fVinculaExtMovBan(fRetornaAutoincremMovBan(arrSeqLan[j]), qryExtrato.FieldByName('AUTOINCREM').AsString, True, []);

                    Application.ProcessMessages;
                  End;

                  qryMovBan.First;
                  While Not qryMovBan.eof do
                  Begin
                    fVinculaExtMovBan(qryMovBan.FieldByName('AUTOINCREM').Value, qryExtrato.FieldByName('AUTOINCREM').AsString, True, []);

                    qryMovBan.Next;

                    Application.ProcessMessages;
                  End;

                  If ExtratoRelacionadoComSucesso(qryExtrato.FieldByName('AUTOINCREM').AsString) Then
                  Begin
                    qryExtrato.Edit;
                    qryExtrato.FieldByName('EXT_SITUAC').AsString :=  'R';
                    qryExtrato.Post;
                  End;

                End;
              End;
            End;
            FreeAndNil(qryTarifa);

            fExecutaSQL('SET SESSION group_concat_max_len = 3072');
          End;
        End;

        qryExtrato.Next;
      End;

      qryExtrato.RecNo := intRecNo;
      qryExtrato.EnableControls;
    End;

    FreeAndNil(qryMovBan);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TfrmCadConcilBancNova.pVerificarHistoricoExtrato(const dtaIni,
  dtaFin: TDate; const strCodPor: String);
var
 qryMovBan,
 qryExtHis: TUniQuery;
 strSQL: String;
 intRecNo: Integer;
 FGravando : IObserver_;
 FSubject  : ISubject_;
 strParameter : Array of String;
 fltValDif : Double;
begin
  Try
    qryMovBan := fCriaQuery;

    With qryMovBan do
    Begin
      Sql.Clear;
      strSQL :=   ' SELECT ' +
                  '   *    ' +
                  ' FROM   ' +
                  '   MOVBAN M ' +
                  ' LEFT JOIN BANEXR B ON B.EXR_BANINC = M.AUTOINCREM ' +
                  ' WHERE  ' +
                  '   M.CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN ' +
                  '   AND CTB_DTACON IS NULL  AND B.AUTOINCREM IS NULL ';

      If strCodPor  <> '' Then
        strSQL := strSQL + '   AND CTB_CODPOR = :CODPOR ';


      Sql.Text := strSQL;
      ParamByName('DTAINI').AsDate := dtaIni;
      ParamByName('DTAFIN').AsDate := dtaFin;

      If strCodPor  <> '' Then
        ParamByName('CODPOR').AsString := strCodPor;

      Open;
    End;

    If Not qryMovBan.IsEmpty Then
    Begin
      qryExtrato.DisableControls;
      intRecNo := qryExtrato.RecNo;
      qryExtrato.First;

      FGravando := TGravandoObs.Create;
      FSubject  := TSubject.Create;
      FSubject.pAddObserver(FGravando);
      SetLength(strParameter, 4);

      //Preparando array de parametros que será responsavel pelas Notificações com o objeto observador.
      SetLength(strParameter,4);
      strParameter[0] := 'TcxProgressBar';
      strParameter[1] := IntToStr(qryExtrato.RecordCount);
      strParameter[2] := 'Verificando lançamentos...';

      //Enviando Notificação que vai atualizar os observadores.
      FSubject.pNotify(strParameter);

      While Not qryExtrato.Eof do
      Begin
        qryExtHis := fCriaQuery;
        qryExtHis.Sql.Clear;
        qryExtHis.Sql.Text := ' SELECT * FROM EXTHIS WHERE EXT_CODPOR = :CODPOR AND EXT_HISTOR = :HISTOR ';
        qryExtHis.ParamByName('CODPOR').AsString := qryExtrato.FieldByName('EXT_CODPOR').AsString;
        qryExtHis.ParamByName('HISTOR').AsString := qryExtrato.FieldByName('EXT_HISTOR').AsString;

        qryExtHis.Open;

        Application.ProcessMessages;
        If qryExtHis.RecordCount > 0 Then
        Begin
          If qryExtrato.FieldByName('EXT_SITUAC').AsString <>  'R' Then
          Begin
            //Atualizando os observadores
            strParameter[2] := 'Verificando lançamentos...';
            strParameter[3] := IntToStr(qryExtrato.RecNo);
            FSubject.pNotify(strParameter);

            qryMovBan.Filtered := False;
            qryMovBan.Refresh;

            qryMovBan.Filter   := ' CTB_DTALAN = "' + FormatDateTime('yyyy-mm-dd', qryExtrato.FieldByName('EXT_DTALAN').AsDateTime) + '" AND ' +
                                  ' CTB_CREDEB = "' + qryExtrato.FieldByName('EXT_CREDEB').AsString + '" AND ' +
                                  ' CTB_HIST01 = "' + qryExtHis.FieldByName('EXT_BANHIS').AsString +'"';
            qryMovBan.Filtered := True;

            qryMovBan.First;

            While not qryMovBan.Eof Do
            Begin
              Application.ProcessMessages;
              fltValDif := qryMovBan.FieldByName('CTB_VALLAN').AsFloat - qryExtrato.FieldByName('EXT_VALLAN').AsFloat;
              If fltValDif < 0 Then
                fltValDif := fltValDif *(-1);

              If ((qryMovBan.FieldByName('CTB_VALLAN').AsFloat = qryExtrato.FieldByName('EXT_VALLAN').AsFloat) Or
                  (fFormataFloat(fltValDif, 2) <= fFormataFloat(fltValTol, 2))) Then
              Begin
                //Atualizando os observadores
                strParameter[2] := 'Vinculando lançamentos...';
                FSubject.pNotify(strParameter);
                fVinculaExtMovBan(qryMovBan.FieldByName('AUTOINCREM').AsString, qryExtrato.FieldByName('AUTOINCREM').AsString, True, []);

                If ExtratoRelacionadoComSucesso(qryExtrato.FieldByName('AUTOINCREM').AsString) Then
                Begin
                  qryExtrato.Edit;
                  qryExtrato.FieldByName('EXT_SITUAC').AsString :=  'R';
                  qryExtrato.Post;
                End;

              End;

              qryMovBan.Next;
            End;
          End;
        End;

        qryExtrato.Next;
      End;

      qryExtrato.RecNo := intRecNo;
      qryExtrato.EnableControls;
    End;

    FreeAndNil(qryMovBan);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TfrmCadConcilBancNova.pVerificarLancamentoExtrato(const dtaIni,
  dtaFin: TDate; const strCodPor: String;blnMarcaSomenteSimilares: Boolean);
var
 qryMovBan: TUniQuery;
 strSQL: String;
 intRecNo: Integer;
 FGravando : IObserver_;
 FSubject  : ISubject_;
 strParameter : Array of String;
 blnVincul : Boolean;
 fltValDif : Double;
begin
  Try
    qryMovBan := fCriaQuery;

    With qryMovBan do
    Begin
      Sql.Clear;
      strSQL :=   ' SELECT ' +
                  '   M.*    ' +
                  ' FROM   ' +
                  '   MOVBAN M ' +
                  ' LEFT JOIN BANEXR B ON B.EXR_BANINC = M.AUTOINCREM ' +
                  ' WHERE  ' +
                  '   M.CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN ' +
                  '   AND CTB_DTACON IS NULL  AND B.AUTOINCREM IS NULL ';

      If strCodPor  <> '' Then
        strSQL := strSQL + '   AND CTB_CODPOR = :CODPOR ';

      Sql.Text := strSQL;
      ParamByName('DTAINI').AsDate := dtaIni;
      ParamByName('DTAFIN').AsDate := dtaFin;

      If strCodPor  <> '' Then
        ParamByName('CODPOR').AsString := strCodPor;

      Open;
    End;

    If Not qryMovBan.IsEmpty Then
    Begin
      qryExtrato.DisableControls;
      intRecNo := qryExtrato.RecNo;
      qryExtrato.First;

      FGravando := TGravandoObs.Create;
      FSubject  := TSubject.Create;
      FSubject.pAddObserver(FGravando);
      SetLength(strParameter, 4);

      //Preparando array de parametros que será responsavel pelas Notificações com o objeto observador.
      SetLength(strParameter,4);
      strParameter[0] := 'TcxProgressBar';
      strParameter[1] := IntToStr(qryExtrato.RecordCount);
      strParameter[2] := 'Verificando lançamentos...';

      //Enviando Notificação que vai atualizar os observadores.
      FSubject.pNotify(strParameter);

      While Not qryExtrato.Eof do
      Begin
        Application.ProcessMessages;
        If qryExtrato.FieldByName('EXT_SITUAC').AsString <>  'R' Then
        Begin
          //Atualizando os observadores
          strParameter[2] := 'Verificando lançamentos...';
          strParameter[3] := IntToStr(qryExtrato.RecNo);
          FSubject.pNotify(strParameter);

          qryMovBan.Filtered := False;
          qryMovBan.Refresh;
          qryMovBan.Filter   := ' CTB_DTALAN = "' + FormatDateTime('yyyy-mm-dd', qryExtrato.FieldByName('EXT_DTALAN').AsDateTime) + '" AND ' +
                                ' CTB_VALLAN =  ' + qryExtrato.FieldByName('EXT_VALLAN').AsFloat.ToString + ' AND ' +
                                ' CTB_CREDEB = "' + qryExtrato.FieldByName('EXT_CREDEB').AsString + '" ';
          qryMovBan.Filtered := True;

          If (qryMovBan.RecordCount = 1) And (not blnMarcaSomenteSimilares) Then
          Begin
            //Atualizando os observadores
            strParameter[2] := 'Vinculando lançamentos...';
            FSubject.pNotify(strParameter);
            fVinculaExtMovBan(qryMovBan.FieldByName('AUTOINCREM').AsString, qryExtrato.FieldByName('AUTOINCREM').AsString, True, []);

            If ExtratoRelacionadoComSucesso(qryExtrato.FieldByName('AUTOINCREM').AsString) Then
            Begin
              qryExtrato.Edit;
              qryExtrato.FieldByName('EXT_SITUAC').AsString :=  'R';
              qryExtrato.Post;
            End;

            qryExtrato.Next;

            Continue;
          End;

          blnVincul := False;
          If fltValTol > 0 Then
          Begin
            If not blnMarcaSomenteSimilares Then
            Begin
              qryMovBan.Filtered := False;
              qryMovBan.First;
              While not qryMovBan.Eof Do
              Begin
                Application.ProcessMessages;
                If ((qryMovBan.FieldByName('CTB_CREDEB').AsString   = qryExtrato.FieldByName('EXT_CREDEB').AsString) And
                    (qryMovBan.FieldByName('CTB_DTALAN').AsDateTime = qryExtrato.FieldByName('EXT_DTALAN').AsDateTime))Then
                Begin
                  fltValDif := qryMovBan.FieldByName('CTB_VALLAN').AsFloat - qryExtrato.FieldByName('EXT_VALLAN').AsFloat;
                  If fltValDif < 0 Then
                      fltValDif := fltValDif *(-1);

                  If ((qryMovBan.FieldByName('CTB_VALLAN').AsFloat = qryExtrato.FieldByName('EXT_VALLAN').AsFloat) Or
                      (fFormataFloat(fltValDif, 2) <= fFormataFloat(fltValTol, 2))) Then
                  Begin
                    //Atualizando os observadores
                    strParameter[2] := 'Vinculando lançamentos...';
                    FSubject.pNotify(strParameter);
                    fVinculaExtMovBan(qryMovBan.FieldByName('AUTOINCREM').AsString, qryExtrato.FieldByName('AUTOINCREM').AsString, True, []);

                    If ExtratoRelacionadoComSucesso(qryExtrato.FieldByName('AUTOINCREM').AsString) Then
                    Begin
                      qryExtrato.Edit;
                      qryExtrato.FieldByName('EXT_SITUAC').AsString :=  'R';
                      qryExtrato.Post;
                    End;

                    blnVincul := True;

                    Break;
                  End;

                End;

                qryMovBan.Next;
              End;
            End;
          End;

          If not blnVincul Then
          Begin
            qryMovBan.Filtered := False;
            qryMovBan.Filter   := ' CTB_DTALAN = "' + FormatDateTime('yyyy-mm-dd', qryExtrato.FieldByName('EXT_DTALAN').AsDateTime) + '" AND ' +
                                  ' CTB_VALLAN =  ' + qryExtrato.FieldByName('EXT_VALLAN').AsFloat.ToString + ' AND ' +
                                  ' CTB_CREDEB = "' + qryExtrato.FieldByName('EXT_CREDEB').AsString + '" ';
            qryMovBan.Filtered := True;

            If qryMovBan.RecordCount > 1 Then
            Begin
              qryExtrato.Edit;
              qryExtrato.FieldByName('EXT_SITUAC').AsString :=  'S';
              qryExtrato.Post;
            End;
          End;
        End;

        qryExtrato.Next;
      End;

      qryExtrato.RecNo := intRecNo;
      qryExtrato.EnableControls;
    End;

    FreeAndNil(qryMovBan);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;
procedure TfrmCadConcilBancNova.pVerificarLancamentoExtratoPagCon(const dtaIni,
  dtaFin: TDate; const strCodPor: String; blnMarcaSomenteSimilares: Boolean);
var
 qryMovBan: TUniQuery;
 strSQL: String;
 intRecNo: Integer;
 FGravando : IObserver_;
 FSubject  : ISubject_;
 strParameter : Array of String;
 arrAutInc: TArray<String>;
 j: Integer;
 blnVincul : Boolean;
 fltValDif : Double;
begin

  Try
    qryMovBan := fCriaQuery;

    fExecutaSQL('SET SESSION group_concat_max_len = 65535');

    With qryMovBan do
    Begin
      Sql.Clear;
      strSQL :=   ' SELECT ' +
                  '   SUM(M.CTB_VALLAN) AS CTB_VALLAN,    ' +
                  '   GROUP_CONCAT(M.AUTOINCREM) AS AUTOINCREM,    ' +
                  '   M.CTB_DTALAN '+
                  ' FROM   ' +
                  '   MOVBAN M ' +
                  ' LEFT JOIN BANEXR B ON B.EXR_BANINC = M.AUTOINCREM ' +
                  ' WHERE  ' +
                  '   M.CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN ' +
                  '   AND M.CTB_DTACON IS NULL  AND M.CTB_CREDEB = "D" AND B.AUTOINCREM IS NULL ';

      If strCodPor  <> '' Then
        strSQL := strSQL + '   AND M.CTB_CODPOR = :CODPOR ';

      strSQL := strSQL  + '   GROUP BY M.CTB_PAGCON, M.CTB_DTALAN, M.CTB_CODEMP ';
      strSQL := strSQL  + '   ORDER BY M.CTB_PAGCON ';

      Sql.Text := strSQL;
      ParamByName('DTAINI').AsDate := dtaIni;
      ParamByName('DTAFIN').AsDate := dtaFin;

      If strCodPor  <> '' Then
        ParamByName('CODPOR').AsString := strCodPor;

      Open;
    End;

    If Not qryMovBan.IsEmpty Then
    Begin
      qryExtrato.DisableControls;
      intRecNo := qryExtrato.RecNo;
      qryExtrato.First;

      FGravando := TGravandoObs.Create;
      FSubject  := TSubject.Create;
      FSubject.pAddObserver(FGravando);
      SetLength(strParameter, 4);

      //Preparando array de parametros que será responsavel pelas Notificações com o objeto observador.
      SetLength(strParameter,4);
      strParameter[0] := 'TcxProgressBar';
      strParameter[1] := IntToStr(qryExtrato.RecordCount);
      strParameter[2] := 'Verificando lançamentos...';

      //Enviando Notificação que vai atualizar os observadores.
      FSubject.pNotify(strParameter);

      While Not qryExtrato.Eof do
      Begin
        Application.ProcessMessages;
        If (qryExtrato.FieldByName('EXT_SITUAC').AsString <> 'R') And (qryExtrato.FieldByName('EXT_CREDEB').AsString = 'D') Then
        Begin
          //Atualizando os observadores
          strParameter[2] := 'Verificando lançamentos...';
          strParameter[3] := IntToStr(qryExtrato.RecNo);
          FSubject.pNotify(strParameter);

          qryMovBan.Filtered := False;
          qryMovBan.Refresh;
          qryMovBan.Filter   := ' CTB_DTALAN = "' + FormatDateTime('yyyy-mm-dd', qryExtrato.FieldByName('EXT_DTALAN').AsDateTime) + '" AND ' +
                                ' CTB_VALLAN =  ' + qryExtrato.FieldByName('EXT_VALLAN').AsFloat.ToString;
          qryMovBan.Filtered := True;

          If (qryMovBan.RecordCount = 1) And (not blnMarcaSomenteSimilares) Then
          Begin
            arrAutInc := qryMovBan.FieldByName('AUTOINCREM').AsString.Split([',']);
            For j:= 0 To Length(arrAutInc)-1 do
            Begin
              Application.ProcessMessages;
              //Atualizando os observadores
              strParameter[2] := 'Vinculando lançamentos...';
              FSubject.pNotify(strParameter);

              fVinculaExtMovBan(arrAutInc[j], qryExtrato.FieldByName('AUTOINCREM').AsString, True, []);
            End;

            If ExtratoRelacionadoComSucesso(qryExtrato.FieldByName('AUTOINCREM').AsString) Then
            Begin
              qryExtrato.Edit;
              qryExtrato.FieldByName('EXT_SITUAC').AsString :=  'R';
              qryExtrato.Post;
            End;

            qryExtrato.Next;

            Continue;
          End;

          blnVincul := False;
          If fltValTol > 0 Then
          Begin
            If not blnMarcaSomenteSimilares Then
            Begin
              qryMovBan.Filtered := False;
              qryMovBan.First;
              While not qryMovBan.Eof Do
              Begin
                Application.ProcessMessages;
                If qryMovBan.FieldByName('CTB_DTALAN').AsDateTime = qryExtrato.FieldByName('EXT_DTALAN').AsDateTime Then
                Begin
                  fltValDif := qryMovBan.FieldByName('CTB_VALLAN').AsFloat - qryExtrato.FieldByName('EXT_VALLAN').AsFloat;
                  If fltValDif < 0 Then
                      fltValDif := fltValDif *(-1);

                  If ((qryMovBan.FieldByName('CTB_VALLAN').AsFloat = qryExtrato.FieldByName('EXT_VALLAN').AsFloat) Or
                      (fFormataFloat(fltValDif, 2) <= fFormataFloat(fltValTol, 2))) Then
                  Begin
                    //Atualizando os observadores
                    strParameter[2] := 'Vinculando lançamentos...';
                    FSubject.pNotify(strParameter);
                    fVinculaExtMovBan(qryMovBan.FieldByName('AUTOINCREM').AsString, qryExtrato.FieldByName('AUTOINCREM').AsString, True, []);

                    If ExtratoRelacionadoComSucesso(qryExtrato.FieldByName('AUTOINCREM').AsString) Then
                    Begin
                      qryExtrato.Edit;
                      qryExtrato.FieldByName('EXT_SITUAC').AsString :=  'R';
                      qryExtrato.Post;
                    End;

                    blnVincul := True;

                    Break;
                  End;
                End;

                qryMovBan.Next;
              End;
            End;
          End;

          If Not blnVincul Then
          Begin
            qryMovBan.Filtered := False;
            qryMovBan.Filter   := ' CTB_DTALAN = "' + FormatDateTime('yyyy-mm-dd', qryExtrato.FieldByName('EXT_DTALAN').AsDateTime) + '" AND ' +
                                  ' CTB_VALLAN =  ' + qryExtrato.FieldByName('EXT_VALLAN').AsFloat.ToString;
            qryMovBan.Filtered := True;

            If qryMovBan.RecordCount > 1 Then
            Begin
              qryExtrato.Edit;
              qryExtrato.FieldByName('EXT_SITUAC').AsString :=  'S';
              qryExtrato.Post;
            End;
          End;
        End;

        qryExtrato.Next;
      End;

      qryExtrato.RecNo := intRecNo;
      qryExtrato.EnableControls;
    End;

    FreeAndNil(qryMovBan);

    fExecutaSQL('SET SESSION group_concat_max_len = 3072');
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TfrmCadConcilBancNova.pVerificarRecCarExtrato(const dtaIni,
  dtaFin: TDate; const strCodPor: String);
var
 qryMovBan: TUniQuery;
 strSQL, strAutoIncrem: String;
 arrAutoIncrem: TArray<String>;
 intRecNo, i: Integer;
 FGravando : IObserver_;
 FSubject  : ISubject_;
 strParameter : Array of String;
begin
  Self.Enabled := False;
  try
    qryMovBan := fCriaQuery;
    try
      Try
        SetLength(arrAutoIncrem, 0);
        fExecutaSQL('SET SESSION group_concat_max_len = 65535');

        strSQL := EmptyStr;
        strSQL := strSQL + ' SELECT ' ;
        strSQL := strSQL + '   M.CTB_PAGCON, ' ;
        strSQL := strSQL + '   M.CTB_DTALAN, ' ;
        strSQL := strSQL + '   M.CTB_CREDEB, ' ;
        strSQL := strSQL + '   SUM(        ' ;
        strSQL := strSQL + '       If(M.CTB_CREDEB = "C", ' ;
        strSQL := strSQL + '          M.CTB_VALLAN,       ' ;
        strSQL := strSQL + '          -M.CTB_VALLAN)      ' ;
        strSQL := strSQL + '          ) AS CTB_VALLAN,  ' ;
        strSQL := strSQL + '   GROUP_CONCAT('+QuotedStr('"')+', M.AUTOINCREM, '+QuotedStr('"')+ ') AS AUTOINCREM ' ;
        strSQL := strSQL + ' FROM   ' ;
        strSQL := strSQL + '   MOVBAN M ' ;
        strSQL := strSQL + ' LEFT JOIN BANEXR B ON B.EXR_BANINC = M.AUTOINCREM ' ;
        strSQL := strSQL + ' WHERE  ' ;
        strSQL := strSQL + '   M.CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN AND ' ;
        strSQL := strSQL + '   M.CTB_DTACON IS NULL AND   ' ;
        strSQL := strSQL + '   M.CTB_ORIGEM = "MCA" AND   ' ;
        strSQL := strSQL + '   ((M.CTB_CREDEB = "C") OR   ' ;
        strSQL := strSQL + '    (M.CTB_CREDEB = "D" AND M.CTB_CODFOR IS NOT NULL)) AND ' ;
        strSQL := strSQL + '   M.CTB_HIST01 NOT LIKE "%Est.%" AND ' ;
        strSQL := strSQL + '   M.CTB_CODCLI IS NOT NULL AND B.AUTOINCREM IS NULL ';

        If not fEmptyStr(strCodPor) Then
          strSQL := strSQL + '   AND CTB_CODPOR = ' + QuotedStr(strCodPor);

        strSQL := strSQL +  '   GROUP BY M.CTB_PAGCON, M.CTB_DTALAN  ';

        qryMovBan.Sql.Clear;
        qryMovBan.Sql.Text := strSQL;
        qryMovBan.ParamByName('DTAINI').AsDate := dtaIni;
        qryMovBan.ParamByName('DTAFIN').AsDate := dtaFin;
        qryMovBan.Open;

        If Not qryMovBan.IsEmpty Then
        Begin
          qryExtrato.DisableControls;
          intRecNo := qryExtrato.RecNo;
          qryExtrato.First;

          FGravando := TGravandoObs.Create;
          FSubject  := TSubject.Create;
          FSubject.pAddObserver(FGravando);
          SetLength(strParameter, 4);

          //Preparando array de parametros que será responsavel pelas Notificações com o objeto observador.
          SetLength(strParameter,4);
          strParameter[0] := 'TcxProgressBar';
          strParameter[1] := IntToStr(qryExtrato.RecordCount);
          strParameter[2] := 'Verificando lançamentos...';

          //Enviando Notificação que vai atualizar os observadores.
          FSubject.pNotify(strParameter);

          While Not qryExtrato.Eof do
          Begin
            Application.ProcessMessages;
            //Atualizando os observadores
            strParameter[2] := 'Verificando lançamentos...';
            strParameter[3] := IntToStr(qryExtrato.RecNo);
            FSubject.pNotify(strParameter);

            qryMovBan.Filtered := False;
            qryMovBan.Filter   := ' CTB_DTALAN = "' + FormatDateTime('yyyy-mm-dd', qryExtrato.FieldByName('EXT_DTALAN').AsDateTime) + '" AND ' +
                                  ' CTB_VALLAN =  ' + qryExtrato.FieldByName('EXT_VALLAN').AsFloat.ToString + ' AND ' +
                                  ' CTB_CREDEB = "' + qryExtrato.FieldByName('EXT_CREDEB').AsString + '" ';
            qryMovBan.Filtered := True;

            If qryMovBan.RecordCount = 1 Then
            Begin
              strAutoIncrem := StringReplace(qryMovBan.FieldByName('AUTOINCREM').AsString, '"', '', [rfReplaceAll]);
              arrAutoIncrem := strAutoIncrem.Split([',']);

              //Atualizando os observadores
              strParameter[2] := 'Vinculando lançamentos...';
              FSubject.pNotify(strParameter);

              For i := 0 To Length(arrAutoIncrem) -1 do
              Begin
                Application.ProcessMessages;
                fVinculaExtMovBan(arrAutoIncrem[i], qryExtrato.FieldByName('AUTOINCREM').AsString, True, []);
              End;

              If Length(arrAutoIncrem) > 0 Then
              Begin
                If ExtratoRelacionadoComSucesso(qryExtrato.FieldByName('AUTOINCREM').AsString) Then
                Begin
                  qryExtrato.Edit;
                  qryExtrato.FieldByName('EXT_SITUAC').AsString :=  'R';
                  qryExtrato.Post;
                End;
              End;

              SetLength(arrAutoIncrem, 0);
            End;

            qryExtrato.Next;
          End;

          Finalize(strParameter);
          qryExtrato.RecNo := intRecNo;
          qryExtrato.EnableControls;
        End;

        fExecutaSQL('SET SESSION group_concat_max_len = 3072');
      Except
        On E: Exception Do
          Raise Exception.Create(E.Message);
      End;
    finally
      FreeAndNil(qryMovBan);
    end;
  finally
    Self.Enabled := True;
  end;
end;

procedure TfrmCadConcilBancNova.pVerificaSeLancamentoAindaEstaRelacionado;
  var
    intCountRelacionado: Integer;
begin
  intCountRelacionado := qryLanCon.Recordcount;
  qryLanCon.Close;
  qryLanCon.Open;
  qryExtrato.Refresh;

  if qryLanCon.Recordcount < intCountRelacionado then
    pCarregaRegistros;
end;

procedure TfrmCadConcilBancNova.RedefinirConfiguraes1Click(Sender: TObject);
begin
  inherited;
  If FileExists(fGetNomeArquivoConfigPadrao) Then
  Begin
    If fMensagem('Aviso', 'As configurações de layout atuais serão perdidas! Deseja continuar?', ['S i m', 'N ã o']) = 1 Then
    Begin
      Try
        DeleteFile(fGetNomeArquivoConfig);
        dxDockingManager1.LoadLayoutFromIniFile(fGetNomeArquivoConfigPadrao);
        dckpnlExtrato.Width    := grpExtrato.Width-40;
        dckpnlExtrato.Height   := grpExtrato.Height;
        dckpnlPendentes.Width  := Trunc(dckpnlExtrato.Width/2);
        dckpnlConcil.Height    := Trunc(dckpnlExtrato.Height/2);
      except
        on e: Exception do
          fMensagem('Aviso', 'Ocorreu o seguinte erro ao tentar restaurar as configurações de layout dos painéis' + #13+'Erro:'+e.Message, ['O k'])
      end;
    end;
  end;
end;

function TfrmCadConcilBancNova.RetornaAutoIncremExtBan(
  AAutoIncremMovBan: String): String;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    fExecutaSQL('SET SESSION group_concat_max_len = 65535');

    LConsulta.SQL.Text := 'SELECT GROUP_CONCAT(DISTINCT CONCAT(''"'', EXR_EXTINC, ''"'')) AS AUTOINCREMS ' +
                          ' FROM BANEXR WHERE EXR_BANINC IN ( '+ AAutoIncremMovBan +')';
    LConsulta.Open;

    Result := LConsulta.FieldByName('AUTOINCREMS').AsString;

    fExecutaSQL('SET SESSION group_concat_max_len = 3072');
  Finally
    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmCadConcilBancNova.tmrCarregarRegistrosTimer(Sender: TObject);
begin
  inherited;
  tmrCarregarRegistros.Enabled := False;

  pCarregaRegistros;
end;

procedure TfrmCadConcilBancNova.LimparTudoECancelar;
begin
  // Destrava todos os grupos
  FLock.pDestravarTodos;

  // Limpa a query do extrato
  qryExtrato.Close;
  qryExtrato.Sql.Clear;
  qryExtrato.Sql.Text := 'SELECT * FROM EXTBAN WHERE 1=0';
  qryExtrato.Open;

  // Limpa os campos da tela
  edtDataInicial.Clear;
  edtDataFinal.Clear;
  edtCodAge.Clear;
  edtCodCCa.Clear;
  edtPortador.Clear;
  edtSalPor.Clear;

  // Limpa os grids relacionados
  qryLanCon.Close;
  qryLanPen.Close;
  qryTotais.Close;

  // Limpa os dates dos filtros
  dtaIniExt.Date := Date;
  dtaFinExt.Date := Date;
  dtaPenIni.Date := Date;
  dtaPenFin.Date := Date;

end;

function TfrmCadConcilBancNova.TravarLancamentosExtrato: Boolean;
var
  LBookmark: TBookmark;
  LPortador: string;
  LDataLancamento: TDate;
  LChave: string;
  LGruposProcessados: TDictionary<string, Boolean>;
begin

  if qryExtrato.IsEmpty then
  begin
    Result := True;
    Exit;
  end;

  FLock.pDestravarTodos;

  LGruposProcessados := TDictionary<string, Boolean>.Create;
  try
    LBookmark := qryExtrato.Bookmark;
    try
      qryExtrato.DisableControls;
      qryExtrato.First;

      while not qryExtrato.Eof do
      begin
        LPortador := qryExtrato.FieldByName('EXT_CODPOR').AsString;
        LDataLancamento := qryExtrato.FieldByName('EXT_DTALAN').AsDateTime;

        if (not LPortador.IsEmpty) and (LDataLancamento > 0) then
        begin
          LChave := Format('CONCILIACAO_OFX_%s_%s', [
                            LPortador,
                            FormatDateTime('YYYYMMDD', LDataLancamento)
                          ]);

          if not LGruposProcessados.ContainsKey(LChave) then
          begin
            LGruposProcessados.Add(LChave, True);

            if Not FLock.fLock_Unlock(LChave,True, False, False, '',True,'') then
            begin
              fMensagem('ATENÇÃO',
                'Já existe uma conciliação em andamento para o dia ' +
                DateToStr(LDataLancamento) + ' do portador ' + LPortador + ' - ' + fRetNomPortador(LPortador) +  sLineBreak +
                ' na estação: ' + fGetHostLock(LChave) + '.' + sLineBreak +
                'Selecione outro período para conciliação.',
                ['&Ok']);

              FLock.pDestravarTodos;

              Result := False;
              Exit;
            end;
          end;
        end;

        qryExtrato.Next;
      end;
      Result := True;

    finally
      if qryExtrato.BookmarkValid(LBookmark) then
        qryExtrato.GotoBookmark(LBookmark);
      qryExtrato.EnableControls;
    end;

  finally
    LGruposProcessados.Free;
  end;
end;

procedure TfrmCadConcilBancNova.ValidaInsercaoProInc;
  Var
    LInsert: TUniQuery;
begin
  If fCampoTabela('PRO_NOMARQ', 'PROINC', ['PRO_NOMARQ'], ['BANEXR']) <> '' Then
    Exit;

  LInsert := fCriaQuery;

  LInsert.SQL.Text := 'SELECT * FROM PROINC WHERE PRO_NOMARQ = "BANEXR"';
  LInsert.Open;
  If LInsert.IsEmpty Then
  Begin
    LInsert.Insert;
    LInsert.FieldByName('PRO_NOMARQ').AsString  := 'BANEXR';
    LInsert.FieldByName('PRO_AUTINC').AsString  := '1';
    LInsert.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('PROCOD',VS_strCodEmp);
    LInsert.Post;
  End;

  FreeAndNil(LInsert);
end;

function TfrmCadConcilBancNova.VinculandoLancamentos(
  pgbStatus: TcxProgressBar): Boolean;
var
  I, intRecNo: Integer;
  blnVinculou: Boolean;
  arrIdxPen: TArrSelIDX;
  arrIdxExt: TArrSelIDX;

  AAutoincremEXTBAN: TStringBuilder;
  AAutoincremMOVBAN: TStringBuilder;
  LQueryExecute: TUniQuery;
begin
  Result := False;

  blnVinculou := False;

  intRecNo := 1;
  AAutoincremEXTBAN := TStringBuilder.Create;
  AAutoincremMOVBAN := TStringBuilder.Create;

  Try
    try
      FEndDragging := True;

      arrIdxPen := fRetornaIndiceMarcados(grdLancPendentesDBTableView1);
      arrIdxExt := fRetornaIndiceMarcados(grdExtratoDBTableView1);

      if (Length(arrIdxPen) > 0) And (Length(arrIdxExt) > 0) then
      begin
        if fMensagem('Aviso', 'Vincular os lançamentos selecionados?', ['&S i m', 'N ã o']) = 2 then
          Exit;
      end;

      dsExtrato.OnDataChange := nil;
      LQueryExecute :=  fCriaQuery();

      qryExtrato.DisableControls;
      intRecNo := qryExtrato.RecNo;

      AAutoincremEXTBAN.Clear;
      pgbStatus.Position := 0;
      pgbStatus.Properties.Max := Length(arrIdxExt);

      for I := 0 to Length(arrIdxExt)-1 do
      begin
        if AAutoincremEXTBAN.Length > 0 then
          AAutoincremEXTBAN.Append(', ');

        AAutoincremEXTBAN.Append(QuotedStr(
         grdExtratoDBTableView1.DataController.Values[arrIdxExt[I].ToInteger(), grdExtratoDBTableView1AUTOINCREM.Index]
        ));

        pStepStatusGravacao(pgbStatus);
      end;

      AAutoincremMOVBAN.Clear;
      pgbStatus.Position := 0;
      pgbStatus.Properties.Max := Length(arrIdxPen);
      for I := 0 to Length(arrIdxPen)-1 do
      begin
        if AAutoincremMOVBAN.Length > 0 then
          AAutoincremMOVBAN.Append(', ');

        AAutoincremMOVBAN.Append(QuotedStr(
         grdLancPendentesDBTableView1.DataController.Values[arrIdxPen[I].ToInteger(), grdLanpenDBAUTOINCREM.Index]
        ));

        pStepStatusGravacao(pgbStatus);
      end;

      if AAutoincremEXTBAN.Length = 0 then
        AAutoincremMOVBAN.Append('""');

      if AAutoincremMOVBAN.Length = 0 then
        AAutoincremMOVBAN.Append('""');

      If LancamentosJaVinculados(AAutoincremMOVBAN.ToString,'') Then
      Begin
        fMensagem('ATENÇÃO', 'Não é possível realizar o vínculo pois há lançamentos que já foram vinculados em outra estação.' + #13 +
                             'Recarregue os dados e tente novamente.', ['&O k']);
        Exit(False);
      End;

      blnVinculou := fVinculaExtMovBan(AAutoincremMOVBAN.ToString,
                                       AAutoincremEXTBAN.ToString,
                                       False,
                                       [],
                                       nil,
                                       False,
                                       pgbStatus);

      fStartTransaction;

      blnVinculou := FBatchSQL.Execute(LQueryExecute);

      If blnVinculou Then
        blnVinculou := AtualizaSituacaoExtBan(AAutoIncremEXTBAN.ToString, 'R');

      if blnVinculou then
        fCommit
      else
      Begin
        fRollBack;
        Exit;
      End;

      Result := True;
    except
      on e: Exception do
      begin
        if frmModulo.GetCurrentConnection.InTransaction then
          fRollBack;

        pMensagensErro('Ocorreu o seguinte erro ao vincular os lançamentos:!'+#13+e.MESSAGE, '[TfrmCadConcilBancNova.fVincularLancamentos]');
      end;
    end;
  Finally
    qryExtrato.Refresh;
    FreeAndNil(LQueryExecute);
    FreeAndNil(AAutoincremEXTBAN);
    FreeAndNil(AAutoincremMOVBAN);

    qryExtrato.RecNo := intRecNo;
    qryExtrato.EnableControls;

    pCarregaRegistros;

    if blnVinculou then
    begin
      pAtualizarExtBanSimilares;
      fMensagem('Aviso', 'Lançamentos vinculados com sucesso!', ['&O k']);
    end;

    FEndDragging := False;
    pAtualizaTotais;
    dsExtrato.OnDataChange := dsExtratoDataChange;
  End;
end;

procedure TfrmCadConcilBancNova.Vinculoporhistrico1Click(Sender: TObject);
begin
  if Assigned(FExtBancario) then
  begin
    ApplicationEvents.OnMessage := Nil;
    frmRelacionaHist  := TfrmRelacionaHist.Create(nil);
    frmRelacionaHist.strCodPor := Copy(edtPortador.Text, 1, 5);
    try
      self.Hide;
      frmRelacionaHist.ShowModal;
      self.Show;
    finally
      FreeAndNil(frmRelacionaHist);
    end;
    ApplicationEvents.OnMessage := ApplicationEventsMessage;
    pVerificarLancamentoExtrato(qryExtrato.FieldByName('EXT_DTALAN').Value, qryExtrato.FieldByName('EXT_DTALAN').Value, qryExtrato.FieldByName('EXT_CODPOR').Value);
  end
  else
    pMensagemOk('É preciso selecionar um extrato bancário para continuar!');
end;

function TfrmCadConcilBancNova.fChamaSenhaVariavel(stlText: TStringList; strDirAce, strMsgSen: String): Boolean;
var
 strLinha: String;
begin
  While (True) Do
  Begin
    Try
      objLiberacao.Clear;
      objLiberacao.strDirAce     := strDirAce;
      objLiberacao.strMsgSen     := strMsgSen;
      objLiberacao.blnMosMen     := True;
      objLiberacao.strCodOpe     := strLoginUsuarioLogado;
      objLiberacao.strCodDig     := strLoginUsuarioLogado;

      For strLinha In stlText Do
       objLiberacao.objMsgLibera.pAddTexto(strLinha);

      If objLiberacao.fLibera Then
      Begin
        Exit(True);
      End;

      If (fMensagem('', 'Senha Incorreta!', ['&Novamente', '&Desistir']) = 2) Then
      Begin
        Exit(False);
      End;

    Finally
      objLiberacao.Clear;
    End;
  End;
end;

function TfrmCadConcilBancNova.fDetalhaLancamentosSelecionados: Boolean;
Var
    LGravando: TfrmGravando;
Begin
  intLancamentosSelecionados := 0;
  dblTotalRelacionado := 0.00;

  stlDetalhesDosSelecionados.Clear;

  stlDetalhesDosSelecionados.Add('Usuário sem acesso para efetivação da Conciliação Bancária OFX.');
  stlDetalhesDosSelecionados.Add('Data Inicial: ' + edtDataInicial.Text);
  stlDetalhesDosSelecionados.Add('Data Final..: ' + edtDataFinal.Text);
  stlDetalhesDosSelecionados.Add('Portador....: ' + edtPortador.Text);
  stlDetalhesDosSelecionados.Add('Lançamentos selecionados que serão "conciliados":');
  stlDetalhesDosSelecionados.Add(Format('%-10s | %-7s | %14s | %-15s | %s', ['Data', 'Empresa', 'Débito/Crédito', 'Valor', 'Histórico' ]));

  pCriarFormularios(TfrmGravando, LGravando);
  LGravando.fExecutarAcao := fVerificaRegistrosMarcados;
  LGravando.lblGravando.Caption := 'Aguarde... Verificando registros.';
  LGravando.ShowModal;

  FreeAndNil(LGravando);

  stlDetalhesDosSelecionados.Add('');
  stlDetalhesDosSelecionados.Add('Quantidade Lançamentos Relacionados: ' + IntToStr(intLancamentosSelecionados));
  stlDetalhesDosSelecionados.Add('Total Relacionado: ' + FormatFloat('R$ ###,###,##0.00', dblTotalRelacionado));

  stlDetalhesDosSelecionados.Add('');

  Result := intLancamentosSelecionados > 0;
End;

procedure TfrmCadConcilBancNova.pGuardaDetalhesSelecionados(strExtInc: String; dteDataCon: TDate);
Var
   qryDetalhes: TUniQuery;
   qryFechamento: TUniQuery;
   strAutoIncrems: String;
   strMovBanAtual: String;
Begin
  If strExtInc.IsEmpty Then
    Exit;

  strAutoIncrems := '';
  Try
    qryFechamento := fCriaQuery;
    Try
      qryFechamento.SQL.Text := ' SELECT    ' +
                                '  B.*      ' +
                                ' FROM      ' +
                                '  BANEXR B ' +
                                ' WHERE    ' +
                                '  B.EXR_EXTINC = "' + strExtInc + '"';

      If FMovBanAtualizado.Count > 0 Then
      Begin
        For strMovBanAtual In FMovBanAtualizado Do
          strAutoIncrems := strAutoIncrems + '"' + strMovBanAtual + '",';
        strAutoIncrems := LeftStr(strAutoIncrems, strAutoIncrems.Length - 1);
        qryFechamento.SQL.Add(' AND EXR_BANINC NOT IN (' + strAutoIncrems + ')');
      End;

      qryFechamento.Open;

      strAutoIncrems := '';

      While Not qryFechamento.Eof Do
      Begin
        FMovBanAtualizado.Add(qryFechamento.FieldByName('EXR_BANINC').AsString);
        strAutoIncrems := strAutoIncrems + '"' + qryFechamento.FieldByName('EXR_BANINC').AsString + '",';
        qryFechamento.Next;
      End;

      strAutoIncrems := LeftStr(strAutoIncrems, strAutoIncrems.Length - 1);
      qryFechamento.Close;

    Finally
      FreeAndNil(qryFechamento);
    End;

    If FechamentoFinanceiroRealizado(strAutoIncrems, dteDataCon) Then
    Begin
      intLancamentosSelecionados := 0;
      AComita := False;
      AFechamentoRealizado := True;
      Exit;
    End;

    If (Not fEmptyStr(strAutoIncrems)) Then
    Begin
      qryDetalhes := fCriaQuery;
      Try
        qryDetalhes.Sql.Text := ' SELECT                                                               ' +
                                '   M.*, E.EXT_HISTOR AS HISTORICO                                     ' +
                                ' FROM                                                                 ' +
                                '   MOVBAN M                                                           ' +
                                ' LEFT JOIN BANEXR B ON B.EXR_BANINC = M.AUTOINCREM                    ' +
                                ' LEFT JOIN EXTBAN E ON E.AUTOINCREM = B.EXR_EXTINC                    ' +
                                ' WHERE                                                                ' +
                                '   M.AUTOINCREM IN (' + strAutoIncrems + ') AND M.CTB_DTACON IS NULL  ' +
                                ' ORDER BY M.CTB_DTACON                                                ';

        qryDetalhes.Open;
        While Not qryDetalhes.Eof Do
        Begin
          stlDetalhesDosSelecionados.Add(Format('%-10s | %-7s | %-14s | %15s | %-s', [
                                         DateToStr(qryDetalhes.FieldByName('CTB_DTALAN').Value),
                                         qryDetalhes.FieldByName('CTB_CODEMP').AsString,
                                         IIF(qryDetalhes.FieldByName('CTB_CREDEB').AsString = 'D', 'Débito', 'Crédito'),
                                         FormatFloat('#,##0.00', qryDetalhes.FieldByName('CTB_VALLAN').Value),
                                         qryDetalhes.FieldByName('HISTORICO').AsString ]));
          If (qryDetalhes.FieldByName('CTB_CREDEB').AsString = 'C') Then
            dblTotalRelacionado := dblTotalRelacionado + qryDetalhes.FieldByName('CTB_VALLAN').Value
          Else
            dblTotalRelacionado := dblTotalRelacionado - qryDetalhes.FieldByName('CTB_VALLAN').Value;
          Inc(intLancamentosSelecionados);
          qryDetalhes.Next;
        End;
        qryDetalhes.Close;
      Finally
        FreeAndNil(qryDetalhes);
      End;
    End;
  Except
    On E: Exception Do
      raise Exception.Create(E.Message);
  End;
End;

function TfrmCadConcilBancNova.fVerificaRegistrosMarcados(pgbStatus: TcxProgressBar): Boolean;
  Var
    LDataConciliacao: TDateTime;
    LDataAtualConciliacao: Boolean;
    LRegistros: TArrSelIDX;
    LRegistroAtual: String;
Begin
  Result := True;

  AFechamentoRealizado := False;

  FMovBanAtualizado := TStringList.Create;
  FMovBanAtualizado.Delimiter := ',';
  FMovBanAtualizado.StrictDelimiter := True;

  Try

    SetLength(LRegistros, 0);
    LRegistros := fRetornaIndiceMarcados(grdExtratoDBTableView1);

    LDataAtualConciliacao := (fCfgSis('DTACCB') <> 'S');

    LDataConciliacao := VS_Date;

    pVerificaSeLancamentoAindaEstaRelacionado;

    pgbStatus.Properties.Max := Length(LRegistros);
    pgbStatus.Position := 0;

    Try
      For LRegistroAtual In LRegistros Do
      Begin
        If AFechamentoRealizado Then
          Break;

        If (LRegistroAtual <> '') Then
        Begin
          If grdExtratoDBTableView1.DataController.Values[LRegistroAtual.ToInteger(), grdExtratoDBTableView1EXT_SITUAC.Index] = 'R' Then
          Begin
            If Not LDataAtualConciliacao Then
              LDataConciliacao := grdExtratoDBTableView1.DataController.Values[LRegistroAtual.ToInteger(), grdExtratoDBTableView1EXT_DTALAN.Index];

            pGuardaDetalhesSelecionados(grdExtratoDBTableView1.DataController.GetRecordId(LRegistroAtual.ToInteger()),
                                        LDataConciliacao);

            pStepStatusGravacao(pgbStatus);
          End;
        End;
      End;

    if AFechamentoRealizado Then
      fMensagem('ATENÇÃO!','Não será possível fazer movimentação financeira, pois existe fechamento financeiro para a empresa.', ['&Ok']);

    Except
      On e: Exception Do
      Begin
        pMensagensErro('Ocorreu o seguinte erro ao verificar os lançamentos.' + #13 +
                       'Erro gerado: ' + e.Message, '[TfrmCadConcilBancNova.fVerificaRegistrosMarcados]');
      End;
    End;

  Finally
    FreeAndNil(FMovBanAtualizado);
  End;

End;


procedure TfrmCadConcilBancNova.pSelecionaContasReceber;
var
  LContador: Integer;
  LConsultaContasReceber: TUniQuery;
  LSequencialControleBaixa,
  LEmpresaBaixa,
  LDocumentoBaixa: String;
  LDataBaixa: TDateTime;
  LListaDocumentoBaixa: TStringList;
begin
  LConsultaContasReceber := nil;
  LListaDocumentoBaixa := nil;

  if not ((not qryLanPen.IsEmpty) and
          (grdLancPendentesDBTableView1.ViewData.RecordCount > 0) and
          (grdLancPendentesDBTableView1.DataController.GetSelectedCount = 1)) then
    Exit;

  If qryLanPen.FieldByName('CTB_ORIGEM').AsString = 'CTR' Then
  Begin
    LDocumentoBaixa := qryLanPen.FieldByName('CTB_SEQLAN').AsString;

    if fEmptyStr(LDocumentoBaixa) then
      Exit;


    LListaDocumentoBaixa := TStringList.Create;
    try
      LConsultaContasReceber := fCriaQuery;
      LConsultaContasReceber.SQL.Text :=
        '  SELECT                                    '+
        '    CTR_SEQCON,                             '+
        '    CTR_EMPBAI,                             '+
        '    CTR_DTABAI                              '+
        '  FROM                                      '+
        '    BANCTR B                                '+
        '    JOIN CADREC C                           '+
        '      ON C.CTR_NUMDUP = B.CTR_NUMDUP        '+
        '      AND C.CTR_PARCEL = B.CTR_PARCEL       '+
        '      AND C.CTR_ESPDOC = B.CTR_ESPDOC       '+
        '      AND C.CTR_CODCLI = B.CTR_CODCLI       '+
        '      AND C.CTR_CODEMP = B.CTR_CODEMP       '+
        '      AND C.CTR_DOCBAI = B.CTB_SEQLAN       '+
        '  WHERE B.CTB_SEQLAN = :DOCBAI              ';

      LConsultaContasReceber.ParamByName('DOCBAI').AsString := LDocumentoBaixa;
      LConsultaContasReceber.Open;

      if LConsultaContasReceber.IsEmpty then
        Exit;

      LSequencialControleBaixa := LConsultaContasReceber.FieldByName('CTR_SEQCON').AsString;
      LEmpresaBaixa := LConsultaContasReceber.FieldByName('CTR_EMPBAI').AsString;
      LDataBaixa    := LConsultaContasReceber.FieldByName('CTR_DTABAI').AsDateTime;

      LConsultaContasReceber.Close;
      LConsultaContasReceber.SQL.Text :=  ' SELECT CTR_DOCBAI ' +
                          ' FROM CADREC ' +
                          ' WHERE CTR_SEQCON = :SEQCON ' +
                          '   AND CTR_EMPBAI = :EMPBAI ' +
                          '   AND CTR_DTABAI = :DTABAI ';

      LConsultaContasReceber.ParamByName('SEQCON').AsString := LSequencialControleBaixa;
      LConsultaContasReceber.ParamByName('EMPBAI').AsString := LEmpresaBaixa;
      LConsultaContasReceber.ParamByName('DTABAI').AsDateTime := Trunc(LDataBaixa);
      LConsultaContasReceber.Open;

      while not LConsultaContasReceber.Eof do
      begin
        LListaDocumentoBaixa.Add(LConsultaContasReceber.FieldByName('CTR_DOCBAI').AsString);
        LConsultaContasReceber.Next;
      end;

      if LListaDocumentoBaixa.Count = 0 then
        Exit;

      grdLancPendentesDBTableView1.BeginUpdate;

      try
        grdLancPendentesDBTableView1.Controller.ClearSelection;

        for LContador := 0 to grdLancPendentesDBTableView1.ViewData.RecordCount - 1 do
        begin
          if VarToStr(grdLancPendentesDBTableView1.ViewData.Records[LContador].Values[grdLanpenDBCTB_ORIGEM.Index]) = 'CTR' then
          begin
            if LListaDocumentoBaixa.IndexOf(
                 VarToStr(grdLancPendentesDBTableView1.ViewData.Records[LContador].Values[grdLanpenDBCTB_SEQLAN.Index])
               ) >= 0 then
            begin
              grdLancPendentesDBTableView1.ViewData.Records[LContador].Selected := True;
            end;
          end;
        end;

      finally
        grdLancPendentesDBTableView1.EndUpdate;
      end;

    finally
      FreeAndNil(LListaDocumentoBaixa);
      FreeAndNil(LConsultaContasReceber);
    end;
  end;
end;

end.
