unit untCadAbreviacaoFiscal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask, untGeraExcel,
  DBCtrls, DBEditFocus, Grids, DBGridCitel, DBGrids, EditFocus, ComboBoxFocus, Uni, DB,
  DBClient, BitBtnLockedIncrem, ComCtrls, cxStyles, untExcel, UniClientDataSet,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView, strUtils,
  cxGridDBBandedTableView, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridDBTableView, cxGrid, Gauges, cxCurrencyEdit, untFuncoesSimples, cxProgressBar,
  CheckLst, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade, cxButtons,
  untPreenchimentoAutomatizadoAbreviacaoICMS,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxTextEdit,
  dxScreenTip, dxCustomHint, cxHint, cxPropertiesStore, cxEditRepositoryItems, untTypesTabelaPreco,
  iMendes.TProcessoAutcom;

type
  TOpcSelecao = (opcMarcar, opcDesmarcar, opcMarcarVenda, opcInverter);

  TfrmCadAbreviacaoFiscal = class(TfrmPai)
    pnlFundo: TPanel;
    pnlHeader: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtCodAbf: TEditFocus;
    edtDescri: TEditFocus;
    btnIncluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    btnPesquisa: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    pgcAbfIcm: TPageControl;
    tbsAlterar: TTabSheet;
    pnlDadosAbrev: TPanel;
    grpEntrada: TGroupBox;
    lbl3: TLabel;
    lbl7: TLabel;
    edtBasIcm: TEditFocus;
    edtAlqIcm: TEditFocus;
    grpMensagens: TGroupBox;
    edtMens01: TEditFocus;
    edtMens02: TEditFocus;
    chkRepEst: TCheckBox;
    grp2: TGroupBox;
    edtMsgIte: TEditFocus;
    btnAdicionarEstado: TBitBtnLocked;
    btnCancelaEstado: TBitBtnLocked;
    grpST: TGroupBox;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    edtIVA_ST: TEditFocus;
    edtAlqRet: TEditFocus;
    edtBasRet: TEditFocus;
    pnl2: TPanel;
    tbsGeral: TTabSheet;
    cmbTipAbf: TComboBoxFocus;
    lbl8: TLabel;
    cxgAbfGeral: TcxGrid;
    cxgAbfGeralTableView: TcxGridDBBandedTableView;
    cxgGridDBAbfGerColUF: TcxGridDBBandedColumn;
    cxgGridDBAbfGerColUF_: TcxGridDBBandedColumn;
    cxgGridDBAbfGerColPEIMPG: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPEF_CST: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPEF_BASICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPEF_ALQICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPEF_BASRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPEF_ALQRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPEF_IVAST: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPEJ_CST: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPEJ_BASICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPEJ_ALQICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPEJ_BASRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPEJ_ALQRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPEJ_IVAST: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPER_CST: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPER_BASICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPER_ALQICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPER_BASRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPER_ALQRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPER_IVAST: TcxGridDBBandedColumn;

    cxGridDBAbfGerColPES_CST: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPES_BASICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPES_ALQICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPES_BASRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPES_ALQRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPES_IVAST: TcxGridDBBandedColumn;

    cxGridDBAbfGerColPSI_CST: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPSI_BASICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPSI_ALQICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPSI_BASRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPSI_ALQRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPSI_IVAST: TcxGridDBBandedColumn;

    cxGridDBAbfGerColPII_CST: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPII_BASICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPII_ALQICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPII_BASRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPII_ALQRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPII_IVAST: TcxGridDBBandedColumn;

    cxGridDBAbfGerColNCO_CST: TcxGridDBBandedColumn;
    cxGridDBAbfGerColNCO_BASICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColNCO_ALQICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColNCO_BASRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColNCO_ALQRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColNCO_IVAST: TcxGridDBBandedColumn;
    cxGridDBAbfGerColCCO_CST: TcxGridDBBandedColumn;
    cxGridDBAbfGerColCCO_BASICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColCCO_ALQICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColCCO_BASRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColCCO_ALQRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColCCO_IVAST: TcxGridDBBandedColumn;
    cxGridDBAbfGerColCNC_CST: TcxGridDBBandedColumn;
    cxGridDBAbfGerColCNC_BASICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColCNC_ALQICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColCNC_BASRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColCNC_ALQRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColCNC_IVAST: TcxGridDBBandedColumn;
    cxGridDBAbfGerColCTA_CST: TcxGridDBBandedColumn;
    cxGridDBAbfGerColCTA_BASICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColCTA_ALQICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColCTA_BASRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColCTA_ALQRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColCTA_IVAST: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPRU_CST: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPRU_BASICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPRU_ALQICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPRU_BASRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPRU_ALQRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPRU_IVAST: TcxGridDBBandedColumn;
    cxGridDBAbfGerColIND_CST: TcxGridDBBandedColumn;
    cxGridDBAbfGerColIND_BASICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColIND_ALQICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColIND_BASRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColIND_ALQRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColIND_IVAST: TcxGridDBBandedColumn;
    cxGridDBAbfGerColTRS_CST: TcxGridDBBandedColumn;
    cxGridDBAbfGerColTRS_BASICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColTRS_ALQICM: TcxGridDBBandedColumn;
    cxGridDBAbfGerColTRS_BASRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColTRS_ALQRET: TcxGridDBBandedColumn;
    cxGridDBAbfGerColTRS_IVAST: TcxGridDBBandedColumn;

    cxGridLevelAbfGeral: TcxGridLevel;
    cxgAbrev: TcxGrid;
    cxgAbrevTableView: TcxGridDBBandedTableView;
    cxgAbrevDBColUF: TcxGridDBBandedColumn;
    cxgAbrevDBColCodSit: TcxGridDBBandedColumn;
    cxgAbrevDBColBasIcm: TcxGridDBBandedColumn;
    cxgAbrevDBColAlqIcm: TcxGridDBBandedColumn;
    cxgAbrevDBColBasRet: TcxGridDBBandedColumn;
    cxgAbrevDBColAlqRet: TcxGridDBBandedColumn;
    cxgAbrevDBColIVA_ST: TcxGridDBBandedColumn;
    cxgAbrevDBColAlqEfO: TcxGridDBBandedColumn;
    cxgAbrevLevel: TcxGridLevel;
    cxStyle: TcxStyleRepository;
    cxsENT_PEF: TcxStyle;
    cxsENT_PEJ: TcxStyle;
    cxsENT_PER: TcxStyle;
    cxsENT_PES: TcxStyle;
    cxsENT_PSI: TcxStyle;
    cxsENT_PII: TcxStyle;
    cxsSAI_NCO: TcxStyle;
    cxsSAI_CCO: TcxStyle;
    cxsSAI_CNC: TcxStyle;
    cxsSAI_SNA: TcxStyle;
    cxsSAI_CTA: TcxStyle;
    cxsSAI_PRU: TcxStyle;
    cxsSAI_IND: TcxStyle;
    cxsSAI_TRS: TcxStyle;
    grp3: TGroupBox;
    lblEstAtu: TLabel;
    edtEstAtu: TEditFocus;
    lblCodSit: TLabel;
    edtCodSit: TEditFocus;
    edtDesSit: TEditFocus;
    cxsSelecionado: TcxStyle;
    pnlProgresso: TPanel;
    lblInformacao: TLabel;
    chkRepAll: TCheckBox;
    tbsImpPag: TTabSheet;
    cxgImpPag: TcxGrid;
    cxgImpPagDBTableView: TcxGridDBBandedTableView;
    cxGridDBBandedColumn1: TcxGridDBBandedColumn;
    cxGridDBBandedColumn3: TcxGridDBBandedColumn;
    cxgImpPagLevel: TcxGridLevel;
    pnl1: TPanel;
    btnGeraExcel: TSpeedButton;
    pbProgresso: TProgressBar;
    chkLstRepAll: TCheckListBox;
    btnHeranca: TBitBtnLocked;
    chkRepTot: TCheckBox;
    btnHlpLin: TBitBtnLocked;
    btnHlpEst: TBitBtnLocked;
    btnHlpGru: TBitBtnLocked;
    grpDifal: TGroupBox;
    Label3: TLabel;
    lblBasDifalDestino: TLabel;
    edtAlqEfO: TEditFocus;
    edtBasDifalDestino: TEditFocus;
    cxgAbrevDBColBaseDifalOri: TcxGridDBBandedColumn;
    cxgAbrevDBColBaseDifalDes: TcxGridDBBandedColumn;
    cxgAbrevDBColAlqFCP: TcxGridDBBandedColumn;
    edtAlqIED: TEditFocus;
    Label5: TLabel;
    cxgAbrevDBColAlqIED: TcxGridDBBandedColumn;
    GroupBox2: TGroupBox;
    edtAlqFCP: TEditFocus;
    Label4: TLabel;
    grbMensagemCFOP: TGroupBox;
    lblclbCFOP: TLabel;
    rdgCFOP: TRadioGroup;
    popCFOP: TPopupMenu;
    MarcarTodos1: TMenuItem;
    DesmarcarTodos1: TMenuItem;
    MarcarSomenteCFOPdeVenda1: TMenuItem;
    InverterSeleo1: TMenuItem;
    cdsCFOPMensagem: TUniClientDataSet;
    dtsCFOPMensagem: TDataSource;
    cdsCFOPMensagemMARCADO: TBooleanField;
    cdsCFOPMensagemCFOP: TStringField;
    gridCFOPMensagem: TcxGrid;
    gridCFOPMensagemDB: TcxGridDBTableView;
    gridCFOPMensagemLevel1: TcxGridLevel;
    gridCFOPMensagemDBMarcado: TcxGridDBColumn;
    gridCFOPMensagemDBCFOP: TcxGridDBColumn;
    cmbTipoCalculoST: TComboBox;
    lblTipoCalculoST: TLabel;
    btnPreenchimentoAutomatizado: TBitBtnLocked;
    grpCodBen: TGroupBox;
    edtCodBen: TEditFocus;
    chkRIcmPR: TCheckBox;
    chkDefinirRICMSPR: TCheckBox;
    edtAliquotaRICMSPR: TEditFocus;
    lblRICMS: TLabel;
    tmrAtualizar: TTimer;
    cxgAbfGeralENT_PEF_O: TcxGridDBBandedColumn;
    cxgAbfGeralENT_PEJ_O: TcxGridDBBandedColumn;
    cxgAbfGeralENT_PER_O: TcxGridDBBandedColumn;
    cxgAbfGeralENT_PES_O: TcxGridDBBandedColumn;
    cxgAbfGeralENT_PSI_O: TcxGridDBBandedColumn;
    cxgAbfGeralENT_PII_O: TcxGridDBBandedColumn;
    HintControler: TcxHintStyleController;
    cxProperties: TcxEditRepository;
    edtValorDoisDecimais: TcxEditRepositoryCurrencyItem;
    edtValorTresDecimais: TcxEditRepositoryCurrencyItem;
    edtValorQuatroDecimais: TcxEditRepositoryCurrencyItem;
    cxgAbrevDBColCodSitOrigem: TcxGridDBBandedColumn;
    lblCodSitOrigem: TLabel;
    edtCodSitOrigem: TEditFocus;
    edtDesSitOrigem: TEditFocus;
    edtTextoCentralizado: TcxEditRepositoryTextItem;
    cxGridDBAbfGerColPEF_AFCP: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPEJ_AFCP: TcxGridDBBandedColumn;
    cxGridDBAbfGerColCNC_AFCP: TcxGridDBBandedColumn;
    cxGridDBAbfGerColCCO_AFCP: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPER_AFCP: TcxGridDBBandedColumn;
    cxGridDBAbfGerColCTA_AFCP: TcxGridDBBandedColumn;
    cxGridDBAbfGerColIND_AFCP: TcxGridDBBandedColumn;
    cxGridDBAbfGerColNCO_AFCP: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPRU_AFCP: TcxGridDBBandedColumn;
    cxGridDBAbfGerColSNA_AFCP: TcxGridDBBandedColumn;
    cxGridDBAbfGerColTRS_AFCP: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPES_AFCP: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPSI_AFCP: TcxGridDBBandedColumn;
    cxGridDBAbfGerColPII_AFCP: TcxGridDBBandedColumn;
    cxGridDBAbfGerColCTA_BASDOR: TcxGridDBBandedColumn;
    cxGridDBAbfGerColCTA_BASDDS: TcxGridDBBandedColumn;
    cxGridDBAbfGerColCTA_ALQIED: TcxGridDBBandedColumn;
    cxGridDBAbfGerColCTA_ALQEFO: TcxGridDBBandedColumn;
    cxGridDBAbfGerColNCO_ALQEFO: TcxGridDBBandedColumn;
    cxGridDBAbfGerColNCO_BASDOR: TcxGridDBBandedColumn;
    cxGridDBAbfGerColNCO_BASDDS: TcxGridDBBandedColumn;
    cxGridDBAbfGerColNCO_ALQIED: TcxGridDBBandedColumn;
    chkALQCLI: TCheckBox;
    btnDetReducao: TSpeedButton;
    edtImpostoImportacao: TEditFocus;
    lblImpostoImportacao: TLabel;
    edtAlqRed: TEditFocus;
    lblAlqRed: TLabel;
    cxgAbrevDBColAlqRed: TcxGridDBBandedColumn;
    grpPerPre: TGroupBox;
    edtPerPre: TEditFocus;
    grpCodPre: TGroupBox;
    edtCodPre: TEditFocus;
    lblPrecoDinamico: TLabel;
    edtIcmPrd: TEditFocus;
    cxgAbrevDBColIcmPrd: TcxGridDBBandedColumn;
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaEstadoClick(Sender: TObject);
    procedure btnAdicionarEstadoClick(Sender: TObject);
    procedure edtCodSitKeyPress(Sender: TObject; var Key: Char);
    procedure edtBasIcmEnter(Sender: TObject);
    procedure edtAlqIcmEnter(Sender: TObject);
    procedure edtBasIcmExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxgAbrevEnter(Sender: TObject);
    procedure cxgAbrevExit(Sender: TObject);
    procedure edtIVA_STEnter(Sender: TObject);
    procedure cxgAbrevTableViewDblClick(Sender: TObject);
    procedure cmbTipAbfChange(Sender: TObject);
    procedure chkRepEstClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure pgcAbfIcmChange(Sender: TObject);
    procedure cxGridDBBandedColumn3PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure edtCodSitExit(Sender: TObject);
    procedure btnGeraExcelClick(Sender: TObject);
    procedure chkRepAllClick(Sender: TObject);
    procedure btnHerancaClick(Sender: TObject);
    procedure chkRepTotClick(Sender: TObject);
    procedure btnHlpLinClick(Sender: TObject);
    procedure rdgCFOPClick(Sender: TObject);
    procedure lblclbCFOPClick(Sender: TObject);
    procedure MarcarTodos1Click(Sender: TObject);
    procedure DesmarcarTodos1Click(Sender: TObject);
    procedure MarcarSomenteCFOPdeVenda1Click(Sender: TObject);
    procedure InverterSeleo1Click(Sender: TObject);
    procedure cmbTipoCalculoSTKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmrAtualizarTimer(Sender: TObject);
    procedure btnPreenchimentoAutomatizadoClick(Sender: TObject);
    procedure chkRIcmPRClick(Sender: TObject);
    procedure chkDefinirRICMSPRClick(Sender: TObject);
    procedure edtAliquotaRICMSPRChange(Sender: TObject);
    procedure btnDetReducaoClick(Sender: TObject);
    procedure cxgAbfGeralENT_PEF_OGetCellHint(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; ACellViewInfo: TcxGridTableDataCellViewInfo;
      const AMousePos: TPoint; var AHintText: TCaption;
      var AIsHintMultiLine: Boolean; var AHintTextRect: TRect);
    procedure edtIcmPrdEnter(Sender: TObject);
  private
    { Private declarations }
    qryConTrD: TUniQuery;

    dicSitTrib: TDicionario;

    blnDarRor: Boolean;

    strEstEmp : String;

    cdsGridLog: TUniClientDataSet;
    cdsLogABF : TUniClientDataSet;

    FFrmAutomatizado: TfrmPreenchimentoAutomatizadoAbreviacaoICMS;

    blnPreenchimentoAutomatizado: Boolean;
    blnPesquisa: Boolean;

    procedure pFormatarCampos;

    function GetEditProperties(AFieldName: String): TcxEditRepositoryItem;

    function fGetColunaFocadaGeral: String;
    Function fRICMPREntrada(strTipAbf: String): Boolean;
    function fSetaIndiceParaAlterarGeral: Boolean;

    function fGravarAbreviacao(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fGravaLogChanges: Boolean;

    procedure pPreenchimentoAutomatizado;

    function fTemCodigoOrigem(strTipAbf: String): Boolean;
    function fTemAlteracaoQuePreciseFazerRecalculo: boolean;

    procedure pCarregaAbreviacao(strCodAbf: String);
    procedure pCarregaAbreviacaoAux;
    procedure pCriaAbreviacoes(strCodAbf: String);
    procedure pOnStateChange(intOpcao: Integer);
    procedure pCarregaSitTri;
    procedure pLimpaEdits(blnAll: Boolean);
    procedure pAfterScroll(Dataset: TDataset);
    procedure pCriaClientGrid;
    procedure pCarregaAbrevAlteracao;
    function  fValidaCodAbf(strCodAbf: String): Boolean;
    function  fValidaSitTributaria(Var strErrSit: String) : Boolean;
    function  fValidaSitTributariaOrigem(Var strErrSit: String) : Boolean;
    function  fValidaGruposTributarios(Var strErrSit: String): Boolean;
    function  fValidaAlteracaoGrupoSAI_CCO: Boolean;
    procedure pImprimeFiltros(Excel: TExcel; Dados: TDataSet; Campos: TCampos; Filtros: array of String);
    procedure pImpTitColuna(Excel: TExcel; Campos: TCampos);
    procedure pPreparaMsgRelicacao;
    procedure pPreparaHintsIntrucoes;
    procedure pAbreTelaHelp(Sender: TObject);
    function  fNenhumGrupoSelecionado: Boolean;
    function  fValidaGruposSelecionados: Boolean;
    procedure pBloquearProdutosParaVenda(strCodAbf: String);
    procedure pCarregaLstCFOP;
    procedure pExecutarSelecao(Opcao: TOpcSelecao);
    procedure pMarcaDesmarca(Opcao: Boolean);
    procedure pInverteSelecao;
    procedure pMarcaVendaCFOP;
    procedure pGravaCFOPMensagem(strAutoInc: string);
    procedure pBuscaCFOPMensagem(strAutoInc: string);
    procedure pHabilitaFormaCalculoST;
    procedure pCriaClientLogABF;
    procedure pOnChangeField(Sender: TField);
    procedure pAdicionarEstado();
    procedure pAtualizaCheckRICMPR(ATipoAbreviacao : String);
    procedure pAtualizarEditsAbreviacao;
    procedure pEscreveAtualizandoEditsAbrevicao;
    procedure pAjustaColunasDareRoraima;
    procedure pAjustaDareRoraimaEdicao(blnAtivar: Boolean);
    function fConfirmaHeranca(blnPergunta: Boolean): Boolean;
    function fHabilitaMsgItem_CodBeneficioFiscal(strTipAbf: string): Boolean;
    procedure pExibeImpImportacao(strEstado: String);

    procedure pSetarComboboxTipoCalculoSt(const strTipAbf: String);
    procedure pSetarDadosDaComboboxTipoCalculoSt(const strTipo: String);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnNovo : Boolean;

    cdsGrid  : TUniClientDataSet;
    cdsGridBackup : TUniClientDataSet;
    dtsGrid  : TDataSource;
    strAbrExterna: String;
  end;

Const
  MSG_REPEST = 'Replicar valores do estado selecionado para todos os estados do mesmo perfil';
  MSG_REPALL = 'Replicar valores do estado selecionado para o mesmo estado, em outros grupos da abreviação ( selecione os grupos abaixo )';
  MSG_REPTOT = 'Replicar valores do grupo selecionado para outros grupos da abreviação ( selecione os grupos abaixo )';

implementation

uses untConstantes, untPesqAux, untFuncoesConsulta, untTypesSistema,
  untConsultas, untGravando, untMensagemExplicativa,
  untAbfIcmDetalheAliquotaCargaMedia, untCalculaComposicaoCusto,
  untSelModoRecalculo, untMsgRecalcAbreviacao;

{$R *.dfm}

function TfrmCadAbreviacaoFiscal.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O CODIGO DA ABREVIAÇÃO         *}
    {**************************************MV*}
    If (Sender = edtCodAbf) Then
    Begin
      If (fEmptyStr(edtCodAbf.Text)) And (edtCodAbf.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Abreviação Fiscal deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If fValidaCodAbf(edtCodAbf.Text) and (blnBuscaPorChave) Then
        Begin
          If cdsGrid.IsEmpty Then
            pCriaAbreviacoes(edtCodAbf.Text);

          cxgAbrevTableView.DataController.Refresh;
          cxgAbfGeralTableView.DataController.Refresh;
          cxgImpPagDBTableView.DataController.Refresh;
          blnMudarFoco := True;
        End
        Else If (blnBuscaPorChave) Then
        Begin
          fMensagem('ATENÇÃO!', 'Já existe o cadastro da Abreviação Fiscal com esse código!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA A DESCRIÇÃO DA ABREVIAÇÃO      *}
    {**************************************MV*}
    Else If (Sender = edtDescri) Then
    Begin
      If fEmptyStr(edtDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição da Abreviação Fiscal deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        blnMudarFoco := False;
        pgcAbfIcm.ActivePage := tbsAlterar;
        pSetFocus(cxgAbrev);
      End;
    End

    {*****************************************}
    {* VALIDA A SITUAÇÃO TRIBUTARIA          *}
    {**************************************MV*}
    Else If (Sender = edtCodSit) Then
    Begin
      If fEmptyStr(edtCodSit.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Situação Tributária (CST) deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaSitTri;
        If qryConTrD.FieldByName('TRI_CODTRI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Situação Tributária não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
          blnMudarFoco := True;

        If Result Then
          pHabilitaFormaCalculoST;

      End;
    End

    Else If (Sender = edtCodSitOrigem) And (Not blnPreenchimentoAutomatizado) Then
    Begin

      If edtCodSitOrigem.Visible Then
      Begin

        If fEmptyStr(edtCodSitOrigem.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Situação Tributária (CST Origem) deve ser preenchida!', ['&Ok']);
          Result := False;
        End
        Else
        Begin

          edtDesSitOrigem.Text := fRetSitTributaria(edtCodSitOrigem.Text);

          If fEmptyStr(edtDesSitOrigem.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa Situação Tributária (CST Origem) não está cadastrada!', ['&Ok']);
            Result := False;
          End
          Else
            blnMudarFoco := True;
        End;

      End;

    End

    {*******************}
    {* VALIDA A BASE   *}
    {****************MV*}
    Else If (Sender = edtBasIcm) Or
            (Sender = edtBasRet) Then
    Begin
      If fEmptyStr((Sender As TEditFocus).Text) Then
      Begin
        (Sender As TEditFocus).Text := '0';
      End
      Else If (fStrToFloat((Sender As TEditFocus).Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual da Base deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtPerPre) And grpPerPre.Visible Then
    Begin
      If fEmptyStr((Sender As TEditFocus).Text) Then
      Begin
        (Sender As TEditFocus).Text := '0';
      End
      Else If (fStrToFloat((Sender As TEditFocus).Text) < 0)   Or
              (fStrToFloat((Sender As TEditFocus).Text) > 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual de crédito presumido inválido!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtBasDifalDestino) Then
    Begin
      If fEmptyStr((Sender As TEditFocus).Text) Then
      Begin
        (Sender As TEditFocus).Text := '0';
      End
      Else If (fStrToFloat((Sender As TEditFocus).Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Percentual de base Difal inválido!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtAlqIcm) Or
            (Sender = edtIcmPrd) Or
            (Sender = edtAlqEfO) Or
            (Sender = edtAlqIED) Or
            (Sender = edtAlqFCP) Or
            (Sender = edtAlqRed) Or
            (Sender = edtAlqRet) Then
    Begin
      If fEmptyStr((Sender As TEditFocus).Text) Then
      Begin
        (Sender As TEditFocus).Text := '0';
      End
      Else If (fStrToFloat((Sender As TEditFocus).Text) < 0)   Or
              (fStrToFloat((Sender As TEditFocus).Text) > 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'Percentual de aliquota inválido!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtIVA_ST) Then
    Begin
      If fEmptyStr((Sender As TEditFocus).Text) Then
      Begin
        (Sender As TEditFocus).Text := '0';
      End
      Else If (fStrToFloat((Sender As TEditFocus).Text) < 0) Or
              (fStrToFloat((Sender As TEditFocus).Text) > 5) Then
      Begin
        fMensagem('ATENÇÃO!', 'Fator de IVA deve estar entre 0,0000 e 5,0000!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtAliquotaRICMSPR) Then
    Begin
      If fEmptyStr((Sender As TEditFocus).Text) Then
      Begin
        (Sender As TEditFocus).Text := '0';
      End
      Else If (fStrToFloat((Sender As TEditFocus).Text) < 0) Or
              (fStrToFloat((Sender As TEditFocus).Text) > 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O % da aliquota para redução RICMS/PR deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtImpostoImportacao) Then
    Begin
      If fEmptyStr((Sender As TEditFocus).Text) Then
      Begin
        (Sender As TEditFocus).Text := '0';
      End
      Else If (fStrToFloat((Sender As TEditFocus).Text) < 0) Or
              (fStrToFloat((Sender As TEditFocus).Text) > 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O % do Imposto de Importação deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadAbreviacaoFiscal.pAjustaDareRoraimaEdicao(blnAtivar: Boolean);
Begin
  blnAtivar := blnAtivar And blnDarRor;

  lblCodSitOrigem.Visible := blnAtivar;
  edtCodSitOrigem.Visible := blnAtivar;
  edtDesSitOrigem.Visible := blnAtivar;
  cxgAbrevDBColCodSitOrigem.Visible := blnAtivar;

  If blnAtivar Then
  Begin
     lblCodSit.Top := 18;
     edtCodSit.Top := 14;
     edtDesSit.Top := 14;

     lblCodSitOrigem.Top := 41;
     edtCodSitOrigem.Top := 37;
     edtDesSitOrigem.Top := 37;
  End Else
  Begin
    lblCodSit.Top := 32;
    edtCodSit.Top := 28;
    edtDesSit.Top := 28;
  End;

End;

procedure TfrmCadAbreviacaoFiscal.FormShow(Sender: TObject);
begin
  inherited;

  blnDarRor := fCfgSis('DARROR', varBoolean);

  pAjustaDareRoraimaEdicao(False);
  pAjustaColunasDareRoraima;

  qryConTrD := fCriarQuery('SELECT * FROM CADTRI WHERE FALSE');
  pCriaClientGrid;
  pCriaClientLogABF;
  chkRepEst.Checked := False;
  chkRepAll.Checked := False;
  chkRepTot.Checked := False;
  blnNovo := False;
  pOnStateChange(1);
  pgcAbfIcm.ActivePage := tbsAlterar;
  btnAdicionarEstado.Enabled := False;
  btnCancelaEstado.Enabled   := False;
  cxgAbrevTableView.DataController.Refresh;
  cxgAbfGeralTableView.DataController.Refresh;
  cxgImpPagDBTableView.DataController.Refresh;

  If fCfgSis('IMPPAG', varInteger) <> 1 Then
  Begin
    tbsGeral.Caption := '&2 - Geral';
    tbsImpPag.TabVisible := False;
    cxgGridDBAbfGerColPEIMPG.Visible := False;
  End;

  If not fCfgSis('BASDFL', varBoolean) Then
  Begin
    lblBasDifalDestino.Visible := False;
    edtBasDifalDestino.Visible := False;

    cxgAbrevDBColBaseDifalDes.Visible   := False;
    cxgAbrevDBColBaseDifalOri.Visible   := False;
    cxGridDBAbfGerColCTA_BASDOR.Visible := False;
    cxGridDBAbfGerColCTA_BASDDS.Visible := False;
    cxGridDBAbfGerColNCO_BASDOR.Visible := False;
    cxGridDBAbfGerColNCO_BASDDS.Visible := False;
  End;

  lblPrecoDinamico.Visible := (fCfgSis('ICMSEP', varString) = 'S') Or (fCfgSis('UASCCR', varString) = 'S');
  edtIcmPrd.Visible := lblPrecoDinamico.Visible;
  cxgAbrevDBColIcmPrd.Visible := lblPrecoDinamico.Visible;

  grpCodBen.Visible := fCfgSis('OBRBEN', varBoolean);
  grpCodPre.Visible := False;
  grpPerPre.Visible := False;

  If fCfgSis('CREPRE', varBoolean) Then
  Begin
    grpCodBen.Visible := True;
    grpCodPre.Visible := True;
    grpPerPre.Visible := True;
  End;

  fExecutarModal(pCarregaLstCFOP, 'Carregando lista de CFOP, Aguarde ...', '');

  pPreparaMsgRelicacao;
  pPreparaHintsIntrucoes;

  fExecutarModal(pCarregaAbreviacaoAux, 'Carregando lista de CFOP, Aguarde ...', '');

  If fCfgSis('UASCCR', varBoolean) Then
  Begin
    lblPrecoDinamico.Caption := '% Alíquota Custo';
    cxgAbrevDBColIcmPrd.Caption := '% Alíquota Custo';
  End;

  chkDefinirRICMSPR.Visible  := fCfgSis('RICMAP',varBoolean);
  edtAliquotaRICMSPR.Visible := chkDefinirRICMSPR.Visible;
  lblRICMS.Visible           := chkDefinirRICMSPR.Visible;

  fExecutarModal(pFormatarCampos, 'Preparando grids para exibição, Aguarde ...', '');
  If strAbrExterna <> '' then
    btnCancela.Click;
end;

procedure TfrmCadAbreviacaoFiscal.pAjustaColunasDareRoraima;
Begin
  If Not blnDarRor Then
  Begin
    cxgAbfGeralENT_PEF_O.Visible := False;
    cxgAbfGeralENT_PEJ_O.Visible := False;
    cxgAbfGeralENT_PER_O.Visible := False;
    cxgAbfGeralENT_PES_O.Visible := False;
    cxgAbfGeralENT_PSI_O.Visible := False;
    cxgAbfGeralENT_PII_O.Visible := False;
  End;
End;

procedure TfrmCadAbreviacaoFiscal.pOnChangeField(Sender: TField);
begin
  If (blnNovo)
     Or (Pos(Sender.FieldName, 'ABF_CODABF,ABF_DESABF,ABF_CODEMP,AUTOINCREM,ABF_ESTADO') > 0)
     Or (Not cdsGridLog.FindKey([cdsGrid.FieldByName('ABF_ESTADO').AsString])) Then
    Exit;

  If cdsLogABF.FindKey([cdsGrid.FieldByName('ABF_ESTADO').AsString,Sender.FieldName]) Then
  Begin
    If Sender.Value = cdsGridLog.FieldValues[Sender.FieldName] Then
    Begin
      cdsLogABF.Delete;
    End
    Else
    Begin
      cdsLogABF.Edit;
      cdsLogABF.FieldByName('LOG_VALATU').Value := Sender.Value;
      cdsLogABF.Post;
    End;
  End
  Else If Sender.Value <> cdsGridLog.FieldValues[Sender.FieldName] Then
  Begin
    cdsLogABF.AppendRecord([cdsGrid.FieldByName('ABF_ESTADO').AsString, Sender.FieldName,
                            cdsGridLog.FieldByName(Sender.FieldName).AsString, Sender.Value]);
  End;
end;

procedure TfrmCadAbreviacaoFiscal.pOnStateChange(intOpcao: Integer);
begin
  If intOpcao = 0 Then
  Begin
    btnIncluir.Enabled := False;
    btnSair.Enabled    := False;
    btnPesquisa.Enabled    := False;
    btnGravar.Enabled  := True;
    btnCancela.Enabled := True;
    btnExcluir.Enabled := False;
    btnPreenchimentoAutomatizado.Enabled := True;

    btnAdicionarEstado.Enabled := True;
    btnCancelaEstado.Enabled   := True;
    btnHeranca.Enabled := True;
  End
  Else
  Begin
    btnIncluir.Enabled := True;
    btnSair.Enabled    := True;
    btnPesquisa.Enabled:= True;
    btnGravar.Enabled  := False;
    btnCancela.Enabled := False;
    btnExcluir.Enabled := True;
    btnPreenchimentoAutomatizado.Enabled := False;

    btnAdicionarEstado.Enabled := False;
    btnCancelaEstado.Enabled   := False;
    btnHeranca.Enabled := False;
  End;

end;

procedure TfrmCadAbreviacaoFiscal.pPreparaHintsIntrucoes;
begin
  btnHlpLin.Hint := 'Clique aqui para exibir a intrução sobre este campo...';
  btnHlpEst.Hint := btnHlpLin.Hint;
  btnHlpGru.Hint := btnHlpLin.Hint;

  btnHlpLin.ShowHint := True;
  btnHlpEst.ShowHint := True;
  btnHlpGru.ShowHint := True;
end;

procedure TfrmCadAbreviacaoFiscal.pPreparaMsgRelicacao;
begin
  chkRepEst.Caption := MSG_REPEST;
  chkRepAll.Caption := MSG_REPALL;
  chkRepTot.Caption := MSG_REPTOT;
end;

procedure TfrmCadAbreviacaoFiscal.pSetarComboboxTipoCalculoSt(
  const strTipAbf: String);
begin
  Try
    cmbTipoCalculoST.ItemIndex := 0;
    If (Pos(strTipAbf, 'CCO_PRU_') <= 0) Then
      Exit;

    If (Not fEmptyStr(cdsGrid.fieldbyname('ABF_CAL_ST_SAI_' + strTipAbf).AsString)) Then
      cmbTipoCalculoST.ItemIndex := IIF(cdsGrid.fieldbyname('ABF_CAL_ST_SAI_' + strTipAbf).AsString = '1',0,1)
  Finally
    pHabilitaFormaCalculoST;
  End;
end;

procedure TfrmCadAbreviacaoFiscal.pSetarDadosDaComboboxTipoCalculoSt(
  const strTipo: String);
begin
  If (Pos(strTipo, '_SAI_CCO_SAI_PRU') <= 0) Then
    Exit;

  cdsGrid.fieldbyname('ABF_CAL_ST' + strTipo).AsString := IIF(cmbTipoCalculoST.ItemIndex = 0, '1', '2');
  pOnChangeField(cdsGrid.fieldbyname('ABF_CAL_ST' + strTipo));
end;

procedure TfrmCadAbreviacaoFiscal.rdgCFOPClick(Sender: TObject);
begin
  inherited;
  grbMensagemCFOP.Enabled := rdgCFOP.ItemIndex = 1;
end;

procedure TfrmCadAbreviacaoFiscal.btnIncluirClick(Sender: TObject);
begin
  If fOperadorLimitado(Trim(strLoginUsuarioLogado)) Then
    Exit;

  inherited;

  pLimpaEdits(True);
  pnlHeader.Enabled := True;
  pnlDadosAbrev.Enabled := True;
  cdsGrid.Open;
  cdsGrid.EmptyDataSet;
  blnNovo := True;
  pOnStateChange(0);
  cxgAbrev.Enabled := True;
  cxgAbfGeral.Enabled := True;
  pgcAbfIcm.ActivePage := tbsAlterar;
  pSetFocus(edtCodAbf);
end;

procedure TfrmCadAbreviacaoFiscal.pCarregaSitTri;
begin
  pPesquisaCadTri(qryConTrD, qryConTrD, edtCodSit.Text);
  edtDesSit.Text := qryConTrD.FieldByName('TRI_DESC01').AsString;
end;

procedure TfrmCadAbreviacaoFiscal.pLimpaEdits(blnAll: Boolean);
Begin
  If blnAll Then
  Begin
    edtCodAbf.Clear;
    edtDescri.Clear;
  End;

  edtEstAtu.Clear;
  edtCodSit.Clear;
  edtDesSit.Clear;

  edtCodSitOrigem.Clear;
  edtDesSitOrigem.Clear;

  edtBasIcm.Clear;
  edtBasRet.Clear;
  chkALQCLI.Checked := False;
  edtAlqIcm.Clear;
  edtAlqEfO.Clear;
  edtAlqIED.Clear;
  edtAlqFCP.Clear;
  edtAlqRet.Clear;
  edtAlqRed.Clear;
  edtIcmPrd.Clear;
  edtIVA_ST.Clear;
  edtMens01.Clear;
  edtMens02.Clear;
  edtMsgIte.Clear;
  edtBasDifalDestino.Clear;
  edtAliquotaRICMSPR.Clear;
  edtImpostoImportacao.Clear;
  chkRIcmPR.Checked := False;
  chkDefinirRICMSPR.Checked := False;
  cmbTipoCalculoST.ItemIndex := 0;
End;

procedure TfrmCadAbreviacaoFiscal.pMarcaDesmarca(Opcao: Boolean);
begin
  if (cdsCFOPMensagem.Active) and (cdsCFOPMensagem.RecordCount > 0) then
  begin
    cdsCFOPMensagem.DisableControls;
    cdsCFOPMensagem.First;
    while not cdsCFOPMensagem.Eof do
    begin
      cdsCFOPMensagem.Edit;
      cdsCFOPMensagemMARCADO.AsBoolean := Opcao;
      cdsCFOPMensagem.Post;
      cdsCFOPMensagem.Next;
    end;
    cdsCFOPMensagem.First;
    cdsCFOPMensagem.EnableControls;
  end;
end;

procedure TfrmCadAbreviacaoFiscal.pMarcaVendaCFOP;
var
  strClaVen: string;
begin
  if (cdsCFOPMensagem.Active) and (cdsCFOPMensagem.RecordCount > 0) then
  begin
    strClaVen := fCfgSis('CLAVEN', varString);
    cdsCFOPMensagem.DisableControls;
    cdsCFOPMensagem.First;
    while not cdsCFOPMensagem.Eof do
    begin
      cdsCFOPMensagem.Edit;
      if (Pos(cdsCFOPMensagemCFOP.AsString, strClaVen) > 0) then
      begin
        cdsCFOPMensagemMARCADO.AsBoolean := True;
      end
      else
      begin
        cdsCFOPMensagemMARCADO.AsBoolean := False;
      end;
      cdsCFOPMensagem.Post;
      cdsCFOPMensagem.Next;
    end;
    cdsCFOPMensagem.First;
    cdsCFOPMensagem.EnableControls;
  end;
end;

procedure TfrmCadAbreviacaoFiscal.edtAliquotaRICMSPRChange(Sender: TObject);
begin
  inherited;
  if StrToFloat(edtAliquotaRICMSPR.Text) > 0 then
  begin
    chkRIcmPR.checked         := False;
    chkDefinirRICMSPR.Checked := True;
  end;
end;

procedure TfrmCadAbreviacaoFiscal.edtAlqIcmEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'No campo "%ALíQUOTA" deve ser informado o percentual da alíquota de ICMS';
end;

procedure TfrmCadAbreviacaoFiscal.edtBasIcmEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'No campo "% Base Icms" deve ser informado o percentual de base de cálculo do ICMS, ou seja 100% ' +
                     'menos percentual de redução de base de cálculo do ICMS.';
end;

procedure TfrmCadAbreviacaoFiscal.edtBasIcmExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption  := '';
end;

procedure TfrmCadAbreviacaoFiscal.edtCodSitExit(Sender: TObject);
  Var
    strTipAbf: String;
begin
  inherited;
  strTipAbf := AnsiLeftStr(cmbTipAbf.Text,3);

  If (Pos(edtCodSit.Text, CST_SUBSTITUICAO + '_' + CST_ANTECIPACAO_ICMS) <= 0) And
     ((strEstEmp <> 'ES') Or (Pos(strTipAbf, 'PEF_PEJ_PER_PES_PSI_PII') <= 0)) Then
  Begin
    edtBasRet.Text := '0,000';
    chkALQCLI.Checked := False;
    edtAlqRet.Text := '0,00';
    edtAlqRed.Text := '0,00';
    edtIVA_ST.Text := '0,00';
    grpST.Enabled  := False;
  End
  Else
    grpST.Enabled  := True;

  pHabilitaFormaCalculoST;

  chkRIcmPR.Enabled := ( (Pos(strTipAbf, 'CNC_SNA_IND_TRS') > 0) or (fRICMPREntrada(strTipAbf)) ) And (strEstEmp = edtEstAtu.Text) And fCfgSis('RICMPR',varBoolean);

  chkDefinirRICMSPR.Enabled  := chkRIcmPR.Enabled and fCfgSis('RICMAP',varBoolean);
  edtAliquotaRICMSPR.Enabled := chkDefinirRICMSPR.Enabled;
  lblRICMS.Enabled           := chkDefinirRICMSPR.Enabled;

  grpDifal.Enabled  := (Pos(strTipAbf, 'PEF_PEJ_PER_PSI_PII_PES_CNC_') <= 0);
end;

procedure TfrmCadAbreviacaoFiscal.edtCodSitKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSitTrib: TConsultasArray;
begin
  inherited;
  {************************************}
  {* NOVA CONSULTA DE SIT. TRIBUTÁRIA *}
  {*********************************RV*}
  If fPesqSitTributaria(Self, TEditFocus(Sender), Nil, Nil, Key, arrSitTrib) Then
  Begin
    If fValidaCampos(TEditFocus(Sender)) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadAbreviacaoFiscal.edtIcmPrdEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'No campo "% Preço Dinâm." deve ser informado o percentual da alíquota de ICMS de Preço Dinâmico';
end;

procedure TfrmCadAbreviacaoFiscal.edtIVA_STEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'Informar o IVA para produtos Sub.Tributária';
end;

procedure TfrmCadAbreviacaoFiscal.pFormatarCampos;
Var
  I: Integer;
begin
  For I := 0 To cxgAbrevTableView.ColumnCount -1 Do
    cxgAbrevTableView.Columns[I].RepositoryItem :=
      GetEditProperties(cxgAbrevTableView.Columns[I].DataBinding.FieldName);

  For I := 0 To cxgImpPagDBTableView.ColumnCount -1 Do
    cxgImpPagDBTableView.Columns[I].RepositoryItem :=
      GetEditProperties(cxgImpPagDBTableView.Columns[I].DataBinding.FieldName);

  For I := 0 To cxgAbfGeralTableView.ColumnCount -1 Do
    cxgAbfGeralTableView.Columns[I].RepositoryItem :=
      GetEditProperties(cxgAbfGeralTableView.Columns[I].DataBinding.FieldName);
end;

function TfrmCadAbreviacaoFiscal.GetEditProperties(AFieldName: String): TcxEditRepositoryItem;
begin
  Result := nil;

  If AFieldName.Contains('ABF_BASICM_') Then
    Result := edtValorDoisDecimais;

  If AFieldName.Contains('ABF_ALQICM_') Then
    Result := edtValorDoisDecimais;

  If AFieldName.Contains('ABF_ICMPRD_') Then
    Result := edtValorDoisDecimais;

  If AFieldName.Contains('ABF_ALQEFO_') Then
    Result := edtValorDoisDecimais;

  If AFieldName.Contains('ABF_ALQIED_') Then
    Result := edtValorDoisDecimais;

  If AFieldName.Contains('ABF_ALQFCP_') Then
    Result := edtValorDoisDecimais;

  If AFieldName.Contains('ABF_BASRET_') Then
    Result := edtValorQuatroDecimais;

  If AFieldName.Contains('ABF_ALQRET_') Then
    Result := edtValorDoisDecimais;

  If AFieldName.Contains('ABF_ALQRED_') Then
    Result := edtValorDoisDecimais;

  If AFieldName.Contains('ABF_IVA_ST_') Then
    Result := edtValorQuatroDecimais;

  If AFieldName.Contains('ABF_BASDOR_') Then
    Result := edtValorDoisDecimais;

  If AFieldName.Contains('ABF_BASDDS_') Then
    Result := edtValorQuatroDecimais;

  If AFieldName.Contains('ABF_PEIMPG') Then
    Result := edtValorDoisDecimais;

  If AFieldName.Contains('ABF_CODSIT') Then
    Result := edtTextoCentralizado;

  If AFieldName.Contains('ABF_ESTADO') Then
    Result := edtTextoCentralizado;
end;

procedure TfrmCadAbreviacaoFiscal.pgcAbfIcmChange(Sender: TObject);
begin
  inherited;
  If pgcAbfIcm.ActivePage = tbsAlterar Then pSetFocus(cxgAbrev);
  If pgcAbfIcm.ActivePage = tbsImpPag  Then pSetFocus(cxgImpPag);
  If pgcAbfIcm.ActivePage = tbsGeral   Then pSetFocus(cxgAbfGeral);
end;

function TfrmCadAbreviacaoFiscal.fGravaLogChanges: Boolean;
  Var
    qryLogABF: TUniQuery;
    intRecNo: Integer;
    strSQLLog: String;
    intCount: Integer;
    strAutoIncremLog: String;
begin
  Result := True;
  intCount := cdsLogABF.RecordCount;
  If intCount <= 0 Then
    Exit;

  cdsLogABF.First;
  intRecNo := cdsLogABF.RecNo;

  strAutoIncremLog := fRetAutoIncrem('LOGABF', VS_strCodEmp, intCount);
  If fEmptyStr(strAutoIncremLog) Then
    Exit;

  strSQLLog := 'INSERT INTO LOGABF (AUTOINCREM, LOG_DTAALT, LOG_HORALT, LOG_CODOPE, LOG_CODEMP, '+
               'LOG_CODABF, LOG_ESTADO, LOG_NOMCAM, LOG_VALANT, LOG_VALATU) VALUES ';

  qryLogABF := fCriaQuery();
  Try
    Try
      While Not cdsLogABF.Eof Do
      Begin
        If cdsLogABF.RecNo <> intRecNo Then
          strSQLLog := strSQLLog + ', ';

        strSQLLog := strSQLLog + '('+QuotedStr(strAutoIncremLog)+', CURRENT_DATE, CURRENT_TIME, '+
                     QuotedStr(strLoginUsuarioLogado)+', '+QuotedStr(VS_strCodEmp)+', '+
                     QuotedStr(edtCodAbf.Text)+', '+
                     QuotedStr(cdsLogABF.FieldByName('LOG_ESTADO').AsString)+', '+
                     QuotedStr(cdsLogABF.FieldByName('LOG_NOMCAM').AsString)+', '+
                     QuotedStr(cdsLogABF.FieldByName('LOG_VALANT').AsString)+', '+
                     QuotedStr(cdsLogABF.FieldByName('LOG_VALATU').AsString)+')';
        strAutoIncremLog := fNextAutoIncrem(strAutoIncremLog);

        cdsLogABF.Next;
      End;
      qryLogABF.SQL.Text := strSQLLog+';';
      qryLogABF.ExecSQL;

      pCarregaAbreviacao(edtCodAbf.Text);
    Except
      On E: Exception Do
      begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmCadAbreviacaoFiscal.fGravaLogChanges]')
      end;
    End;
  Finally
    FreeAndNil(qryLogABF);
  End
end;

procedure TfrmCadAbreviacaoFiscal.pGravaCFOPMensagem(strAutoInc: string);
var
  qryMsgCFOP: TUniQuery;
  strAutoincrem, strComando: String;
begin
  if (cdsCFOPMensagem.Active) and (cdsCFOPMensagem.RecordCount > 0) then
  begin
    try
      try
        fStartTransaction();
        qryMsgCFOP := fCriaQuery();

        qryMsgCFOP.Close;
        qryMsgCFOP.SQL.Clear;
        qryMsgCFOP.SQL.Add('DELETE FROM MSGCFO WHERE CFO_SEQABF = :SEQABF');
        qryMsgCFOP.ParamByName('SEQABF').AsString := strAutoInc;
        qryMsgCFOP.ExecSQL;

        qryMsgCFOP.Close;
        qryMsgCFOP.SQL.Clear;
        qryMsgCFOP.SQL.Add('INSERT INTO MSGCFO(AUTOINCREM, CFO_SEQABF, CFO_CFOPMS)');
        qryMsgCFOP.SQL.Add('VALUES');
        cdsCFOPMensagem.DisableControls;
        cdsCFOPMensagem.Filtered := False;
        cdsCFOPMensagem.Filter := 'MARCADO = TRUE';
        cdsCFOPMensagem.Filtered := True;
        strAutoincrem := fRetAutoIncrem('MSGCFO', VS_strCodEmp, cdsCFOPMensagem.RecordCount);

        cdsCFOPMensagem.First;
        while not cdsCFOPMensagem.Eof do
        begin
          if cdsCFOPMensagemMARCADO.AsBoolean = True then
          begin
           strComando := '("' + strAutoincrem + '","'+ strAutoInc + '","' + cdsCFOPMensagemCFOP.AsString + '")'
          end;
          pIncrementaAutoIncrem(strAutoincrem);

          cdsCFOPMensagem.Next;
          If not cdsCFOPMensagem.Eof then
            qryMsgCFOP.SQL.Add(strComando + ',')
          Else
            qryMsgCFOP.SQL.Add(strComando)
        end;
        If cdsCFOPMensagem.RecordCount > 0 Then
          qryMsgCFOP.ExecSQL;

        cdsCFOPMensagem.Filtered := False;
        cdsCFOPMensagem.Filter := '';


        cdsCFOPMensagem.First;
        cdsCFOPMensagem.EnableControls;
        fCommit();
      except
        fRollBack();
        cdsCFOPMensagem.First;
        cdsCFOPMensagem.EnableControls;
      end;
    finally
      FreeAndNil(qryMsgCFOP);
    end;
  end;
end;

procedure TfrmCadAbreviacaoFiscal.pAbreTelaHelp(Sender: TObject);
Var
  strMensag: String;
begin
  If (Sender = btnHlpLin) Then
    strMensag := 'Quando selecionada esta opção, os valores do estado selecionado no grid com a linha azul, ' +
                 'serão replicados para todos os estados do perfil que se encontra, não alterando nenhum outro grupo.'
  Else If (Sender = btnHlpEst) Then
    strMensag := 'Quando selecionada esta opção, os valores do estado selecionado no grid com a linha azul, '+
                 'serão replicados para o mesmo estado, para os grupos escolhidos.'
  Else
    strMensag := 'Quando selecionada esta opção, todos os valores do grupo atual serão replicados ' +
                 'para os grupos escolhidos.';

  Try
    pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
    frmMensagemExplicativa.Caption := 'Instrução';
    frmMensagemExplicativa.mmoInstru.Lines.Add(strMensag);
    frmMensagemExplicativa.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmCadAbreviacaoFiscal.pAbreTelaHelp]')
  End;

  pFreeAndNil(frmMensagemExplicativa);

end;

function TfrmCadAbreviacaoFiscal.fTemAlteracaoQuePreciseFazerRecalculo: boolean;
var strPerfil : string;
    i: integer;
begin
  Result := False;
  cdsGrid.First;

  while not cdsGrid.Eof Do
  Begin
    If cdsGridLog.FindKey([cdsGrid.FieldByName('ABF_ESTADO').AsString]) Then
    Begin
      For i := 0 to 4 do
      begin
        case i of
          0 : strPerfil := '_ENT_PEF';
          1 : strPerfil := '_ENT_PEJ';
          2 : strPerfil := '_ENT_PER';
          3 : strPerfil := '_ENT_PES';
          4 : strPerfil := '_ENT_PII';
        end;

        If (cdsGridLog.FieldByName('ABF_ALQRET' + strPerfil).Value <> cdsGrid.FieldByName('ABF_ALQRET' + strPerfil).Value) or
           (cdsGridLog.FieldByName('ABF_CODSIT' + strPerfil).Value <> cdsGrid.FieldByName('ABF_CODSIT' + strPerfil).Value) or
           (cdsGridLog.FieldByName('ABF_BASICM' + strPerfil).Value <> cdsGrid.FieldByName('ABF_BASICM' + strPerfil).Value) or
           (cdsGridLog.FieldByName('ABF_ALQICM' + strPerfil).Value <> cdsGrid.FieldByName('ABF_ALQICM' + strPerfil).Value) or
           (cdsGridLog.FieldByName('ABF_ICMPRD' + strPerfil).Value <> cdsGrid.FieldByName('ABF_ICMPRD' + strPerfil).Value) or
           (cdsGridLog.FieldByName('ABF_BASRET' + strPerfil).Value <> cdsGrid.FieldByName('ABF_BASRET' + strPerfil).Value) or
           (cdsGridLog.FieldByName('ABF_ALQFCP' + strPerfil).Value <> cdsGrid.FieldByName('ABF_ALQFCP' + strPerfil).Value) or
           (cdsGridLog.FieldByName('ABF_IVA_ST' + strPerfil).Value <> cdsGrid.FieldByName('ABF_IVA_ST' + strPerfil).Value) Then
          Exit(True);

      End;
    End;
    cdsGrid.Next;

  End;


end;

Function TfrmCadAbreviacaoFiscal.fTemCodigoOrigem(strTipAbf: String): Boolean;
Begin
  Result := Pos(strTipAbf, '_ENT_PEF-_ENT_PEJ-_ENT_PER-_ENT_PES-_ENT_PII-') > 0;
End;

procedure TfrmCadAbreviacaoFiscal.pAfterScroll(Dataset: TDataset);
begin
  If Dataset.ControlsDisabled Then
    Exit;

  pEscreveAtualizandoEditsAbrevicao;
  tmrAtualizar.Enabled := False;
  tmrAtualizar.Enabled := True;
end;

procedure TfrmCadAbreviacaoFiscal.tmrAtualizarTimer(Sender: TObject);
begin
  inherited;
  pAtualizarEditsAbreviacao;
end;

procedure TfrmCadAbreviacaoFiscal.pAtualizarEditsAbreviacao;
Var
  strTipAbf: String;
  blnEhENT_: Boolean;
begin
  tmrAtualizar.Enabled := False;
  cdsGridBackup.Data := cdsGrid.Data;

  With cdsGrid Do
  Begin
    pFormatarCampos;

    strTipAbf := AnsiLeftStr(cmbTipAbf.Text,3);

    chkALQCLI.Visible := False;
    btnDetReducao.Visible  := False;
    If fCfgsis('URSTCL', varBoolean) And  (Pos(strTipAbf, '_PEF_PEJ_PER_PES_PSI_PII') > 0) Then
    Begin
      chkALQCLI.Visible := True;
      btnDetReducao.Visible  := True;
    End;

    pSetarComboboxTipoCalculoSt(strTipAbf);

    If Pos(strTipAbf, 'PEF_PEJ_PER_PES_PSI_PII_') > 0 Then
      strTipAbf := '_ENT_' + strTipAbf
    Else
      strTipAbf := '_SAI_' + strTipAbf;

    edtCodSit.Text := fieldbyname('ABF_CODSIT' + strTipAbf).AsString;

    If Assigned(FindField('ABF_CODSIT' + strTipAbf + '_O')) Then
      edtCodSitOrigem.Text := Fieldbyname('ABF_CODSIT' + strTipAbf + '_O').AsString
    Else
      edtCodSitOrigem.Text := '';

    grpDifal.Enabled  := (Pos(strTipAbf, 'PEF_PEJ_PER_PES_PSI_PII_CNC_') <= 0);

    If dicSitTrib[edtCodSit.Text] = Null Then
      dicSitTrib[edtCodSit.Text] := fRetSitTributaria(fieldbyname('ABF_CODSIT' + strTipAbf).AsString);

    edtDesSit.Text := dicSitTrib[edtCodSit.Text];

    If (dicSitTrib[edtCodSitOrigem.Text] = Null) And fTemCodigoOrigem(strTipAbf) Then
      If Assigned(FindField('ABF_CODSIT' + strTipAbf + '_O')) Then
        dicSitTrib[edtCodSitOrigem.Text] := fRetSitTributaria(fieldbyname('ABF_CODSIT' + strTipAbf + '_O').AsString);

    If (dicSitTrib[edtCodSitOrigem.Text] = Null) Then
      edtDesSitOrigem.Text := ''
    Else
      edtDesSitOrigem.Text := dicSitTrib[edtCodSitOrigem.Text];

    edtBasIcm.Text            := FormatFloat('#,##0.00',fieldbyname('ABF_BASICM' + strTipAbf).AsFloat);
    edtAlqIcm.Text            := FormatFloat('#,##0.00',fieldbyname('ABF_ALQICM' + strTipAbf).AsFloat);
    edtIcmPrd.Text            := FormatFloat('#,##0.00',fieldbyname('ABF_ICMPRD' + strTipAbf).AsFloat);
    edtIcmPrd.Text            := FormatFloat('#,##0.00',fieldbyname('ABF_ICMPRD' + strTipAbf).AsFloat);
    edtAlqEfO.Text            := FormatFloat('#,##0.00',fieldbyname('ABF_ALQEFO' + strTipAbf).AsFloat);
    edtAlqIED.Text            := FormatFloat('#,##0.00',fieldbyname('ABF_ALQIED' + strTipAbf).AsFloat);
    edtAlqFCP.Text            := FormatFloat('#,##0.00',fieldbyname('ABF_ALQFCP' + strTipAbf).AsFloat);
    edtBasRet.Text            := FormatFloat('#,##0.0000',fieldbyname('ABF_BASRET' + strTipAbf).AsFloat);
    If Pos('_ENT_', strTipAbf) > 0 Then
    chkALQCLI.Checked := IIf(fieldbyname('ABF_ALQCLI' + strTipAbf).AsInteger = 1, True, False);
    edtAlqRet.Text            := FormatFloat('#,##0.00',fieldbyname('ABF_ALQRET' + strTipAbf).AsFloat);
    edtAlqRed.Text            := FormatFloat('#,##0.00',FieldByName('ABF_ALQRED' + strTipAbf).AsFloat);
    edtBasDifalDestino.Text   := FormatFloat('#,##0.0000',fieldbyname('ABF_BASDDS' + strTipAbf).AsFloat);
    edtImpostoImportacao.Text := FormatFloat('#,##0.00',fieldbyname('ABF_ALQIMP' + strTipAbf).AsFloat);

    edtIVA_ST.Text := FormatFloat('#,##0.0000',fieldbyname('ABF_IVA_ST' + strTipAbf).AsFloat);

    blnEhENT_ := (Pos('ENT_', strTipAbf) > 0);
    If (blnEhENT_) and (not fHabilitaMsgItem_CodBeneficioFiscal(strTipAbf)) Then
    Begin
      edtMens01.Clear;
      edtMens02.Clear;
      edtMsgIte.Clear;
      edtCodBen.Clear;
      edtCodPre.Clear;
      edtPerPre.Clear;
      rdgCFOP.ItemIndex := 0;

      edtMens01.Enabled       := False;
      edtMens02.Enabled       := False;
      edtMsgIte.Enabled       := False;
      edtCodBen.Enabled       := False;
      edtCodPre.Enabled       := False;
      edtPerPre.Enabled       := False;
      rdgCFOP.Enabled         := False;

      rdgCFOPClick(rdgCFOP);
    End
    Else
    Begin
      edtMsgIte.Text    := FieldByName('ABF_MSGITE' + strTipAbf).AsString;
      edtCodBen.Text    := FieldByName('ABF_CODBEN' + strTipAbf).AsString;
      edtCodPre.Text    := FieldByName('ABF_CODPRE' + strTipAbf).AsString;
      edtPerPre.Text    := FormatFloat('#,##0.00',fieldbyname('ABF_PERPRE' + strTipAbf).AsFloat);

      if blnEhEnt_ then
      begin
        edtMens01.Clear;
        edtMens02.Clear;
        rdgCFOP.ItemIndex := 0;
      end
      else
      begin
        edtMens01.Text    := FieldByName('ABF_MENS01' + strTipAbf).AsString;
        edtMens02.Text    := FieldByName('ABF_MENS02' + strTipAbf).AsString;
        rdgCFOP.ItemIndex := FieldByName('ABF_IMPMSG').AsInteger;
        pBuscaCFOPMensagem(FieldByName('AUTOINCREM').AsString);
      end;

      edtMens01.Enabled       := not blnEhEnt_;
      edtMens02.Enabled       := not blnEhEnt_;
      edtMsgIte.Enabled       := True;
      edtCodBen.Enabled       := True;
      edtCodPre.Enabled       := True;
      edtPerPre.Enabled       := True;
      rdgCFOP.Enabled         := not blnEhEnt_;

      rdgCFOPClick(rdgCFOP);
    End;

    edtEstAtu.Text := fieldbyname('ABF_ESTADO').AsString;

    pExibeImpImportacao(edtEstAtu.Text);

    edtCodSitExit(nil);//Desabilita dados ST quando CST nao for de Substituicao

    pAtualizaCheckRICMPR(strTipAbf);
  End;
end;

procedure TfrmCadAbreviacaoFiscal.pEscreveAtualizandoEditsAbrevicao;
begin
  edtCodSit.Text := '';
  edtCodSitOrigem.Text := '';
  edtDesSit.Text := 'Atualizando ...';
  edtDesSitOrigem.Text := 'Atualizando ...';
  edtBasIcm.Text := '0,00';
  edtAlqIcm.Text := '0,00';
  edtIcmPrd.Text := '0,00';
  edtAlqEfO.Text := '0,00';
  edtAlqIED.Text := '0,00';
  edtAlqFCP.Text := '0,00';
  edtBasRet.Text := '0,00';
  chkALQCLI.Checked := False;
  edtAlqRet.Text := '0,00';
  edtAlqRed.Text := '0,00';
  edtBasDifalDestino.Text := '0,00';
  edtIVA_ST.Text := '0,0000';
  edtMens01.Text := 'Atualizando ...';
  edtMens02.Text := 'Atualizando ...';
  edtMsgIte.Text := 'Atualizando ...';
  edtCodBen.Text := '';
  edtCodPre.Text := '';
  edtPerPre.Text := '0,00';
  edtEstAtu.Text := '';
  edtImpostoImportacao.Text := '0,00';
end;

procedure TfrmCadAbreviacaoFiscal.pAtualizaCheckRICMPR(ATipoAbreviacao : String);
begin
  chkRIcmPR.Enabled := ( (Pos(ATipoAbreviacao, '_SAI_CNC') > 0) or
                         (Pos(ATipoAbreviacao, '_SAI_IND') > 0) or
                         (Pos(ATipoAbreviacao, '_SAI_SNA') > 0) or
                         (Pos(ATipoAbreviacao, '_SAI_TRS') > 0) or
                         (fRICMPREntrada(ATipoAbreviacao))
                        ) And
                        (strEstEmp = edtEstAtu.Text) And
                         fCfgSis('RICMPR',varBoolean);

  chkDefinirRICMSPR.Enabled  := chkRIcmPR.Enabled and fCfgSis('RICMAP',varBoolean);
  edtAliquotaRICMSPR.Enabled := chkDefinirRICMSPR.Enabled;
  lblRICMS.Enabled           := chkDefinirRICMSPR.Enabled;

  If chkRIcmPR.Enabled Then
  Begin
    If fRICMPREntrada(ATipoAbreviacao) Then
    Begin
      If (ATipoAbreviacao = '_ENT_PEF') Or (ATipoAbreviacao = 'PEF') Then
      Begin
        chkRIcmPR.Checked         := IIF(cdsGrid.FieldByName('ABF_RICMPR_ENT_PEF').AsString = 'S', True, False);
        chkDefinirRICMSPR.Checked := cdsGrid.FieldByName('ABF_ALQRIC_ENT_PEF').AsFloat > 0;
        edtAliquotaRICMSPR.Text   := FormatFloat('#,##0.00', cdsGrid.FieldByName('ABF_ALQRIC_ENT_PEF').AsFloat);
      End
      Else If (ATipoAbreviacao = '_ENT_PEJ') Or (ATipoAbreviacao = 'PEJ') Then
      Begin
        chkRIcmPR.Checked         := IIF(cdsGrid.FieldByName('ABF_RICMPR_ENT_PEJ').AsString = 'S', True, False);
        chkDefinirRICMSPR.Checked := cdsGrid.FieldByName('ABF_ALQRIC_ENT_PEJ').AsFloat > 0;
        edtAliquotaRICMSPR.Text   := FormatFloat('#,##0.00', cdsGrid.FieldByName('ABF_ALQRIC_ENT_PEJ').AsFloat);
      End
      Else If (ATipoAbreviacao = '_ENT_PER') Or (ATipoAbreviacao = 'PER') Then
      Begin
        chkRIcmPR.Checked         := IIF(cdsGrid.FieldByName('ABF_RICMPR_ENT_PER').AsString = 'S', True, False);
        chkDefinirRICMSPR.Checked := cdsGrid.FieldByName('ABF_ALQRIC_ENT_PER').AsFloat > 0;
        edtAliquotaRICMSPR.Text   := FormatFloat('#,##0.00', cdsGrid.FieldByName('ABF_ALQRIC_ENT_PER').AsFloat);
      End
      Else If (ATipoAbreviacao = '_ENT_PES') Or (ATipoAbreviacao = 'PES') Then
      Begin
        chkRIcmPR.Checked         := IIF(cdsGrid.FieldByName('ABF_RICMPR_ENT_PES').AsString = 'S', True, False);
        chkDefinirRICMSPR.Checked := cdsGrid.FieldByName('ABF_ALQRIC_ENT_PES').AsFloat > 0;
        edtAliquotaRICMSPR.Text   := FormatFloat('#,##0.00', cdsGrid.FieldByName('ABF_ALQRIC_ENT_PES').AsFloat);
      End
      Else If (ATipoAbreviacao = '_ENT_PSI') Or (ATipoAbreviacao = 'PSI') Then
      Begin
        chkRIcmPR.Checked         := IIF(cdsGrid.FieldByName('ABF_RICMPR_ENT_PSI').AsString = 'S', True, False);
        chkDefinirRICMSPR.Checked := cdsGrid.FieldByName('ABF_ALQRIC_ENT_PSI').AsFloat > 0;
        edtAliquotaRICMSPR.Text   := FormatFloat('#,##0.00', cdsGrid.FieldByName('ABF_ALQRIC_ENT_PSI').AsFloat);
      End
      Else If (ATipoAbreviacao = '_ENT_PII') Or (ATipoAbreviacao = 'PII') Then
      Begin
        chkRIcmPR.Checked         := IIF(cdsGrid.FieldByName('ABF_RICMPR_ENT_PII').AsString = 'S', True, False);
        chkDefinirRICMSPR.Checked := cdsGrid.FieldByName('ABF_ALQRIC_ENT_PII').AsFloat > 0;
        edtAliquotaRICMSPR.Text   := FormatFloat('#,##0.00', cdsGrid.FieldByName('ABF_ALQRIC_ENT_PII').AsFloat);
      End

      Else
      Begin
        chkRIcmPR.Checked         := False;
        chkDefinirRICMSPR.Checked := False;
        edtAliquotaRICMSPR.Clear;
      End;
      {}
    End
    Else
    Begin
      if (Pos(ATipoAbreviacao, '_SAI_CNC') > 0) then
      Begin
        chkRIcmPR.Checked         := IIF(cdsGrid.FieldByName('ABF_RICMPR_SAI_CNC').AsString = 'S', True, False);
        chkDefinirRICMSPR.Checked := cdsGrid.FieldByName('ABF_ALQRIC_SAI_CNC').AsFloat > 0;
        edtAliquotaRICMSPR.Text   := FormatFloat('#,##0.00', cdsGrid.FieldByName('ABF_ALQRIC_SAI_CNC').AsFloat);
      End
      else if (Pos(ATipoAbreviacao, '_SAI_SNA') > 0) then
      Begin
        chkRIcmPR.Checked         := IIF(cdsGrid.FieldByName('ABF_RICMPR_SAI_SNA').AsString = 'S', True, False);
        chkDefinirRICMSPR.Checked := cdsGrid.FieldByName('ABF_ALQRIC_SAI_SNA').AsFloat > 0;
        edtAliquotaRICMSPR.Text   := FormatFloat('#,##0.00', cdsGrid.FieldByName('ABF_ALQRIC_SAI_SNA').AsFloat);
      End
      else if (Pos(ATipoAbreviacao, '_SAI_IND') > 0) then
      begin
        chkRIcmPR.Checked         := IIF(cdsGrid.FieldByName('ABF_RICMPR_SAI_IND').AsString = 'S', True, False);
        chkDefinirRICMSPR.Checked := cdsGrid.FieldByName('ABF_ALQRIC_SAI_IND').AsFloat > 0;
        edtAliquotaRICMSPR.Text   := FormatFloat('#,##0.00', cdsGrid.FieldByName('ABF_ALQRIC_SAI_IND').AsFloat);
      end
      else if (Pos(ATipoAbreviacao, '_SAI_TRS') > 0) then
      begin
        chkRIcmPR.Checked         := IIF(cdsGrid.FieldByName('ABF_RICMPR_SAI_TRS').AsString = 'S', True, False);
        chkDefinirRICMSPR.Checked := cdsGrid.FieldByName('ABF_ALQRIC_SAI_TRS').AsFloat > 0;
        edtAliquotaRICMSPR.Text   := FormatFloat('#,##0.00', cdsGrid.FieldByName('ABF_ALQRIC_SAI_TRS').AsFloat);
      end;
    End;
  End
  Else
  Begin
    chkRIcmPR.Checked         := False;
    chkDefinirRICMSPR.Checked := False;
    edtAliquotaRICMSPR.Clear;
  End;
end;

procedure TfrmCadAbreviacaoFiscal.pBloquearProdutosParaVenda(strCodAbf: String);
  Var
    qryUpdAbf : TUniQuery;
begin
  qryUpdAbf := fCriaQuery(Self);
  Try
    qryUpdAbf.Close;
    qryUpdAbf.SQL.Clear;
    qryUpdAbf.SQL.Add(' UPDATE ITEGER G ');
    qryUpdAbf.SQL.Add('   JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ');
    qryUpdAbf.SQL.Add('    SET G.ITE_PEFAVE = "N" ');
    qryUpdAbf.SQL.Add('  WHERE TRUE ');

    If fCfgSis('TIPABF') = '1' Then
      qryUpdAbf.SQL.Add('  AND I.ITE_CODABF = :CODABF ')
    Else
      qryUpdAbf.SQL.Add('  AND G.ITE_CODABF = :CODABF ');

    qryUpdAbf.ParamByName('CODABF').AsString := strCodAbf;
    qryUpdAbf.ExecSQL;
  Finally
    FreeAndNil(qryUpdAbf);
  End;
end;

procedure TfrmCadAbreviacaoFiscal.pBuscaCFOPMensagem(strAutoInc: string);
var
  qryCFOPMsg: TUniQuery;
begin
  if (cdsCFOPMensagem.Active) and (cdsCFOPMensagem.RecordCount > 0) then
  begin
    try
      qryCFOPMsg := fCriaQuery();
      qryCFOPMsg.Close;
      qryCFOPMsg.SQL.Clear;
      qryCFOPMsg.SQL.Add('SELECT CFO_CFOPMS FROM MSGCFO WHERE CFO_SEQABF = :SEQABF');
      qryCFOPMsg.ParamByName('SEQABF').AsString := strAutoInc;
      qryCFOPMsg.Open;
      if not qryCFOPMsg.IsEmpty then
      begin
        cdsCFOPMensagem.DisableControls;
        pMarcaDesmarca(False);
        while not qryCFOPMsg.Eof do
        begin
          if cdsCFOPMensagem.Locate('CFOP', qryCFOPMsg.FieldByName('CFO_CFOPMS').AsString, []) then
          begin
            cdsCFOPMensagem.Edit;
            cdsCFOPMensagemMARCADO.AsBoolean := True;
            cdsCFOPMensagem.Post;
          end;
          qryCFOPMsg.Next;
        end;
        cdsCFOPMensagem.First;
        cdsCFOPMensagem.EnableControls;
      end;
    finally
      FreeAndNil(qryCFOPMsg);
    end;
  end;
end;

procedure TfrmCadAbreviacaoFiscal.pCriaClientLogABF;
begin
  cdsLogABF := fCriaCdsLogAbreviacao(Self);
end;

procedure TfrmCadAbreviacaoFiscal.pCriaClientGrid;
Begin
  {*********************************}
  {* CRIA O CLIENTDATASET DO GRID  *}
  {******************************LU*}
  cdsGrid := fCriaCdsAbreviacao(Self);
  cdsGridBackup := TUniClientDataSet.Create(Self);

  dtsGrid := fCriaDataSource(cdsGrid);

  cxgAbrevTableView.DataController.DataSource := dtsGrid;
  cxgAbfGeralTableView.DataController.DataSource := dtsGrid;
  cxgImpPagDBTableView.DataController.DataSource := dtsGrid;

  cdsGrid.Close;
  cdsGrid.Open;

  cdsGrid.AfterScroll := pAfterScroll;

  cmbTipAbfChange(nil);
End;

procedure TfrmCadAbreviacaoFiscal.pExecutarSelecao(Opcao: TOpcSelecao);
begin
  case Opcao of
    opcMarcar: pMarcaDesmarca(True);
    opcDesmarcar: pMarcaDesmarca(False);
    opcMarcarVenda: pMarcaVendaCFOP;
    opcInverter: pInverteSelecao;
  end;
end;

procedure TfrmCadAbreviacaoFiscal.pExibeImpImportacao(strEstado: String);
begin
  If strEstado = 'EX' Then
  Begin
    edtImpostoImportacao.Visible := True;
    lblImpostoImportacao.Visible := True;
  End
  Else Begin
    edtImpostoImportacao.Visible := False;
    lblImpostoImportacao.Visible := False;
    edtImpostoImportacao.Text := '0,00';
  End;

end;

procedure TfrmCadAbreviacaoFiscal.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrAbf: TConsultasArray;
begin
  {*****************************}
  {* CONSULTA DE ABREV. FISCAL *}
  {**************************RV*}
  chrKey := '/';
  If fPesqAbrevFiscal(Self, edtCodAbf, edtDescri, qryTabela, chrKey, arrAbf) Then
  Begin
    blnPesquisa := True;
    pCarregaAbreviacao(edtCodAbf.Text);
    blnNovo := False;
    pOnStateChange(0);
    pgcAbfIcm.ActivePage := tbsAlterar;
    pnlDadosAbrev.Enabled := True;
    pSetFocus(cxgAbrev);
  End;
end;

procedure TfrmCadAbreviacaoFiscal.btnPreenchimentoAutomatizadoClick(
  Sender: TObject);
begin
  inherited;
  If Not btnPreenchimentoAutomatizado.Enabled Then
    Exit;

  If Not fVerificaSubControl(pnlHeader) Then
    Exit;

  pgcAbfIcm.ActivePage := tbsAlterar;

  fExecutarModal(pPreenchimentoAutomatizado, 'Aguarde, Realizando preenchimento automatizado ...', '');
end;

procedure TfrmCadAbreviacaoFiscal.pPreenchimentoAutomatizado;
Var
  strUFOri: String;
  strUFDes, strUfsSelecionados, strTipAbf: String;
  intPerfil, intUf: Integer;
  fltIVAAjustado: Double;
  qryMatIcm: TUniQuery;
  qryMatFcp: TUniQuery;

  qryMatBasDif: TUniQuery;
  strEstadoGrd: String;

  function fCalculaIVAAjustado(fltIVAOriginal, fltAlqInterestadual, fltAlqInterna, fltAlqFCP: Double): Double;
  begin
    Result := ( ( ( ( 1 + ( fltIVAOriginal / 100 ) ) * ( 1 - ( fltAlqInterestadual / 100 ) ) / ( 1 - ( (fltAlqInterna + fltAlqFCP) / 100 ) ) ) -1 ) * 100 );
    Result := 1 + Result / 100;
  end;

begin
  If Not Assigned(FFrmAutomatizado) Then
  Begin
    pCriarFormularios(TfrmPreenchimentoAutomatizadoAbreviacaoICMS, FFrmAutomatizado);
    FFrmAutomatizado.chkPerfis.Items.Text := cmbTipAbf.Items.Text;
  End;

  Try
    If FFrmAutomatizado.ShowModal <> MrOk Then
      Exit;

    blnPreenchimentoAutomatizado := True;

    If Assigned(FFrmAutomatizado.cdsAbreviacoesPlanilha) Then
    Begin
      if not FFrmAutomatizado.cdsAbreviacoesPlanilha.IsEmpty then
      begin
        For intPerfil := 0 To cmbTipAbf.Items.Count -1 Do
        Begin
          strTipAbf := AnsiLeftStr(cmbTipAbf.Items.Strings[intPerfil], 3);

          FFrmAutomatizado.cdsAbreviacoesPlanilha.Filter := 'PERFIL = ' + QuotedStr(strTipAbf);
          FFrmAutomatizado.cdsAbreviacoesPlanilha.Filtered := True;

          if FFrmAutomatizado.cdsAbreviacoesPlanilha.IsEmpty then
            Continue;

          cmbTipAbf.ItemIndex := intPerfil;

          cmbTipAbfChange(nil);

          cdsGrid.First;
          While Not cdsGrid.Eof Do
          Begin
            Try
              If not FFrmAutomatizado.cdsAbreviacoesPlanilha.Locate('UF', cdsGrid.FieldByName('ABF_ESTADO').AsString, []) Then
                Continue;

              Application.ProcessMessages;
              btnCancelaEstado.Click;

              pCarregaAbrevAlteracao;

              if not FFrmAutomatizado.cdsAbreviacoesPlanilha.FieldByName('CST').IsNull then
                edtCodSit.Text := FFrmAutomatizado.cdsAbreviacoesPlanilha.FieldByName('CST').AsString;

              If Not fValidaCampos(edtCodSit, True) Then
                Continue;

              edtCodSitExit(nil);

              if not FFrmAutomatizado.cdsAbreviacoesPlanilha.FieldByName('BASEICMS').IsNull then
                edtBasIcm.Text := FFrmAutomatizado.cdsAbreviacoesPlanilha.FieldByName('BASEICMS').AsString;

              if not FFrmAutomatizado.cdsAbreviacoesPlanilha.FieldByName('ALIQUOTAICMS').IsNull then
                edtAlqIcm.Text := FFrmAutomatizado.cdsAbreviacoesPlanilha.FieldByName('ALIQUOTAICMS').AsString;

              if not FFrmAutomatizado.cdsAbreviacoesPlanilha.FieldByName('FCP').IsNull then
                edtAlqFCP.Text := FFrmAutomatizado.cdsAbreviacoesPlanilha.FieldByName('FCP').AsString;

              If grpST.Enabled Then
              Begin
                if not FFrmAutomatizado.cdsAbreviacoesPlanilha.FieldByName('BASEST').IsNull then
                  edtBasRet.Text := FFrmAutomatizado.cdsAbreviacoesPlanilha.FieldByName('BASEST').AsString;

                if not FFrmAutomatizado.cdsAbreviacoesPlanilha.FieldByName('ALIQINTERNAST').IsNull then
                  edtAlqRet.Text := FFrmAutomatizado.cdsAbreviacoesPlanilha.FieldByName('ALIQINTERNAST').AsString;

                if not FFrmAutomatizado.cdsAbreviacoesPlanilha.FieldByName('IVAST').IsNull then
                  edtIVA_ST.Text := FFrmAutomatizado.cdsAbreviacoesPlanilha.FieldByName('IVAST').AsString;
              End;

              If grpDifal.Enabled Then
              Begin
                if not FFrmAutomatizado.cdsAbreviacoesPlanilha.FieldByName('ALIQEFETIVAORIGEMDIFAL').IsNull then
                  edtAlqEfO.Text := FFrmAutomatizado.cdsAbreviacoesPlanilha.FieldByName('ALIQEFETIVAORIGEMDIFAL').AsString;

                if not FFrmAutomatizado.cdsAbreviacoesPlanilha.FieldByName('ALIQINTERNAESTADODESTINODIFAL').IsNull then
                  edtAlqIED.Text := FFrmAutomatizado.cdsAbreviacoesPlanilha.FieldByName('ALIQINTERNAESTADODESTINODIFAL').AsString;

                If edtBasDifalDestino.Visible Then
                  if not FFrmAutomatizado.cdsAbreviacoesPlanilha.FieldByName('BASEDESTINODIFAL').IsNull then
                    edtBasDifalDestino.Text := FFrmAutomatizado.cdsAbreviacoesPlanilha.FieldByName('BASEDESTINODIFAL').AsString;
              End;

              if grpCodBen.Visible then
                edtCodBen.Text := FFrmAutomatizado.cdsAbreviacoesPlanilha.FieldByName('CODBEN').AsString;

              pAdicionarEstado;
            Finally
              cdsGrid.Next;
            End;
          End;
        end;

        cdsGrid.Close;
        cdsGrid.Open;

        pFormatarCampos;

        Exit;
      end;
    end;

    qryMatIcm := fCriaQuery(nil);
    qryMatFcp := fCriaQuery(nil);

    qryMatIcm.Close;
    qryMatIcm.SQL.Text := 'SELECT * FROM ICMALQ WHERE ICM_CODMAT = :CODMAT';
    qryMatIcm.ParamByName('CODMAT').AsString := FFrmAutomatizado.edtMatIcm.Text;
    qryMatIcm.Open;
    qryMatIcm.IndexFieldNames := 'ICM_UF_ORI;ICM_UF_DES';

    qryMatFcp.Close;
    qryMatFcp.SQL.Text := 'SELECT * FROM FCPALQ WHERE FCP_CODMAT = :CODMAT';
    qryMatFcp.ParamByName('CODMAT').AsString := FFrmAutomatizado.edtMatFcp.Text;
    qryMatFcp.Open;
    qryMatFcp.IndexFieldNames := 'FCP_UF_DES';

    If edtBasDifalDestino.Visible Then
    Begin
      qryMatBasDif := fCriaQuery(nil);
      qryMatBasDif.SQL.Text := 'SELECT * FROM DIFBAS WHERE DIF_CODMAT = :CODMAT';
      qryMatBasDif.ParamByName('CODMAT').AsString := FFrmAutomatizado.edtCodMatBasDif.Text;
      qryMatBasDif.Open;
      qryMatBasDif.IndexFieldNames := 'DIF_ESTADO';
    End;

    strUfsSelecionados := EmptyStr;
    For intUf := 0 To FFrmAutomatizado.chkUfs.Items.Count - 1 Do
      If FFrmAutomatizado.chkUfs.Checked[intUf] Then
        strUfsSelecionados := strUfsSelecionados + '_' + FFrmAutomatizado.chkUfs.Items.Strings[intUf];

    For intPerfil := 0 To cmbTipAbf.Items.Count -1 Do
    Begin
      If Not FFrmAutomatizado.chkPerfis.Checked[intPerfil] Then
        Continue;

      cmbTipAbf.ItemIndex := intPerfil;

      cmbTipAbfChange(nil);

      cdsGrid.First;
      While Not cdsGrid.Eof Do
      Begin
        Try
          If Pos(cdsGrid.FieldByName('ABF_ESTADO').AsString, strUfsSelecionados) = 0 Then
            Continue;

          Application.ProcessMessages;
          btnCancelaEstado.Click;

          If Pos(LeftStr(cmbTipAbf.Text, 3), 'PEF_PEJ_PER_PES_PSI_PII_') > 0 Then
          Begin
            strUFOri := cdsGrid.FieldByName('ABF_ESTADO').AsString;
            strUFDes := strEstEmp;
          End
          Else
          Begin
            strUFOri := strEstEmp;
            strUFDes := cdsGrid.FieldByName('ABF_ESTADO').AsString;
          End;

          strEstadoGrd := cdsGrid.FieldByName('ABF_ESTADO').AsString;

          pCarregaAbrevAlteracao;

          If strUFOri = strUFDes Then
            edtCodSit.Text := FFrmAutomatizado.edtCodSitDentro.Text
          Else
            edtCodSit.Text := FFrmAutomatizado.edtCodSitFora.Text;

          If Not fValidaCampos(edtCodSit, True) Then
            Continue;

          edtCodSitExit(nil);

          edtBasIcm.Text := FFrmAutomatizado.edtBasIcm.Text;

          If qryMatIcm.Locate('ICM_UF_ORI;ICM_UF_DES', VarArrayOf([strUFOri, strUFDes]), []) Then
            edtAlqIcm.Text := qryMatIcm.FieldByName('ICM_ALQICM').AsString;

          If qryMatFcp.Locate('FCP_UF_DES', strUFDes, []) Then
            edtAlqFCP.Text := qryMatFcp.FieldByName('FCP_ALQFCP').AsString;

          If grpST.Enabled Then
          Begin
            edtBasRet.Text := FFrmAutomatizado.edtBasRet.Text;
            
            If qryMatIcm.Locate('ICM_UF_ORI;ICM_UF_DES', VarArrayOf([strUFDes, strUFDes]), []) Then
              edtAlqRet.Text := qryMatIcm.FieldByName('ICM_ALQICM').AsString;

            If fStrToFloat(FFrmAutomatizado.edtIvaOri.Text) <= 0 Then
              fltIVAAjustado := 0.0000
            Else
              fltIVAAjustado := fCalculaIVAAjustado(fStrToFloat(FFrmAutomatizado.edtIvaOri.Text),
                                                    fStrToFloat(edtAlqIcm.Text),
                                                    fStrToFloat(edtAlqRet.Text),
                                                    IIF(strUFOri = strUFDes, 0, fStrToFloat(edtAlqFCP.Text)));

            edtIVA_ST.Text := FormatFloat(edtIVA_ST.EditFormat, fltIVAAjustado);
          End;


          If grpDifal.Enabled Then
          Begin
            edtAlqEfO.Text := FFrmAutomatizado.edtAlqEfO.Text;

            If qryMatIcm.Locate('ICM_UF_ORI;ICM_UF_DES', VarArrayOf([strUFDes, strUFDes]), []) Then
              edtAlqIED.Text := qryMatIcm.FieldByName('ICM_ALQICM').AsString;

            If edtBasDifalDestino.Visible Then
              If qryMatBasDif.Locate('DIF_ESTADO', strEstadoGrd, []) Then
                edtBasDifalDestino.Text := qryMatBasDif.FieldByName('DIF_DESPER').AsString;

          End;

          If edtMens01.Enabled Then
          Begin
            edtMens01.Text := FFrmAutomatizado.edtMens01.Text;
            edtMens02.Text := FFrmAutomatizado.edtMens02.Text;
          End;

          If (strUFOri = strUFDes) And
             (Pos(edtCodSit.Text, CST_SUBSTITUICAO) > 0) And
             (Pos(LeftStr(cmbTipAbf.Text, 3), 'PEF_PEJ_PER_PES_PSI_PII') <= 0) And
             (FFrmAutomatizado.chkZerarParaCstStDentroEstado.Checked) Then
          Begin
            edtBasIcm.Text := '0,00';
            edtAlqIcm.Text := '0,00';
            edtIcmPrd.Text := '0,00';
            edtBasRet.Text := '0,00';
            chkALQCLI.Checked := False;
            edtAlqRet.Text := '0,00';
            edtAlqRed.Text := '0,00';
            edtIVA_ST.Text := '0,00';
            edtAlqEfO.Text := '0,00';
            edtAlqIED.Text := '0,00';
            edtBasDifalDestino.Text := '0,00';
          End;

          if grpCodBen.Visible then
            edtCodBen.Text := FFrmAutomatizado.edtCodBen.Text;

          pAdicionarEstado;
        Finally
          cdsGrid.Next;
        End;
      End;

    End;

    cdsGrid.Close;
    cdsGrid.Open;

    pFormatarCampos;
  Finally
    blnPreenchimentoAutomatizado := False;

    If Assigned(qryMatIcm) Then
      FreeAndNil(qryMatIcm);

    If Assigned(qryMatBasDif) Then
      FreeAndNil(qryMatBasDif);

    If Assigned(qryMatFcp) Then
      FreeAndNil(qryMatFcp);
  End;
end;

procedure TfrmCadAbreviacaoFiscal.pCarregaAbreviacao(strCodAbf: String);
Var
  strSQL   : String;
  qryGen   : TUniQuery;
  intField : Integer;
Begin

  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   ABFICM.* ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   ABFICM ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   ABF_CODABF = :CODABF ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODABF').AsString := strCodAbf;
      Open;
    End;

    qryGen.First;

    edtCodAbf.Text := qryGen.fieldbyname('ABF_CODABF').AsString;
    edtDescri.Text := qryGen.fieldbyname('ABF_DESABF').AsString;

    pFormatarCampos;

    cdsGrid.EmptyDataSet;
    cdsGrid.DisableControls;

    While Not qryGen.Eof Do
    Begin
      Application.ProcessMessages;
      {****************************}
      {* CARREGA O CLIENT DO GRID *}
      {*************************LU*}

      cdsGrid.Insert;

      For intField := 0 To cdsGrid.FieldCount - 1 Do
        If qryGen.FindField(cdsGrid.Fields[intField].FieldName) <> Nil  Then
          cdsGrid.Fields[intField].Value := qryGen.FindField(cdsGrid.Fields[intField].FieldName).Value;

      cdsGrid.Post;

      qryGen.Next;
    End;

    cdsGrid.EnableControls;

    If cdsGrid.RecordCount > 0 Then
    Begin
      cdsGrid.Edit;
      cdsGrid.Post;
    End;

    pCloneDataSet(cdsGridLog, cdsGrid);
    cdsGridLog.IndexFieldNames := 'ABF_ESTADO';
    cdsLogABF.EmptyDataSet;

    cxgAbrevTableView.DataController.Refresh;
    cxgAbfGeralTableView.DataController.Refresh;
    cxgImpPagDBTableView.DataController.Refresh;

    pAfterScroll(cdsGrid);
  Finally
    FreeAndNil(qryGen);
  End;
End;

procedure TfrmCadAbreviacaoFiscal.pCarregaAbreviacaoAux;
begin
  Application.ProcessMessages;
  If Not fEmptyStr(strAbrExterna) Then
  Begin
    pCarregaAbreviacao(strAbrExterna);
    blnNovo := False;
    pOnStateChange(0);
    pgcAbfIcm.ActivePage := tbsAlterar;
    pSetFocus(cxgAbrev);
  End;
end;

procedure TfrmCadAbreviacaoFiscal.pCarregaLstCFOP;
var
  qryCFOP: TUniQuery;
begin
  try
    qryCFOP := fCriaQuery;
    qryCFOP.Close;
    qryCFOP.SQL.Clear;
    qryCFOP.SQL.Add('SELECT CFO_CODCFO FROM CADCFO');
    qryCFOP.Open;

    cdsCFOPMensagem.CreateDataSet;
    cdsCFOPMensagem.DisableControls;

    while not qryCFOP.Eof do
    begin
      cdsCFOPMensagem.Append;
      cdsCFOPMensagemMARCADO.AsBoolean := True;
      cdsCFOPMensagemCFOP.AsString := qryCFOP.FieldByName('CFO_CODCFO').AsString;
      cdsCFOPMensagem.Post;
      qryCFOP.Next;
    end;
    cdsCFOPMensagem.First;
    cdsCFOPMensagem.EnableControls;
  finally
    FreeAndNil(qryCFOP);
  end;
end;

procedure TfrmCadAbreviacaoFiscal.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pnlHeader.Enabled := False;
  pnlDadosAbrev.Enabled := False;
  If blnNovo Then
    pLimpaEdits(True);
  blnNovo := False;
  blnPesquisa := False;
  pOnStateChange(1);
end;

procedure TfrmCadAbreviacaoFiscal.btnGeraExcelClick(Sender: TObject);
  Var
    intColIndex: Integer;
    objGeraExcel: TGeraExcel;
    prcScroll: TPrcScroll;
begin
  inherited;

  Try
    pDisableControls(cdsGrid, prcScroll);

    pnlProgresso.Visible := True;
    lblInformacao.Caption := 'GERANDO ARQUIVO EXCEL DA ABREVIAÇÃO FISCAL, AGUARDE...';

    objGeraExcel := TGeraExcel.Create(cdsGrid, pbProgresso);

    objGeraExcel.strNomRel := UpperCase(fTiraCaracEspeciais(Self.Caption))       + ' ( ' +
                              UpperCase(edtCodAbf.Text + ' - ' + edtDescri.Text) + ' ) ' ;

    For intColIndex := 0 To cxgAbfGeralTableView.ColumnCount -1 Do
      If cxgAbfGeralTableView.Columns[intColIndex].Visible Then
        objGeraExcel.AddCampo(cxgAbfGeralTableView.Columns[intColIndex].DataBinding.FieldName,
                              cxgAbfGeralTableView.Columns[intColIndex].Caption);

    objGeraExcel.OnImpFiltros := pImprimeFiltros;
    objGeraExcel.OnImpTitColuna := pImpTitColuna;
    objGeraExcel.blnDefinirBordas := False;
    objGeraExcel.blnCongelarPaineis := False;

    If objGeraExcel.fGerarRelatorio Then
      pMensagemOK('Arquivo gerado com sucesso!');

  Finally
    pnlProgresso.Visible := False;
    pEnableControls(cdsGrid, prcScroll);

    If Assigned(objGeraExcel) Then
      FreeAndNil(objGeraExcel);
  End;

end;

procedure TfrmCadAbreviacaoFiscal.pImpTitColuna(Excel: TExcel; Campos: TCampos);
begin
  With Excel, Campos.Colunas Do
  Begin
    CorFundo('A' + IntToStr(LinhaAtual -1), fGetLetraAlfa(Count) + IntToStr(LinhaAtual), Verde_Mar);
    CorFonte('A' + IntToStr(LinhaAtual -1), fGetLetraAlfa(Count) + IntToStr(LinhaAtual), Branco);
  End;
end;

procedure TfrmCadAbreviacaoFiscal.pInverteSelecao;
begin
  if (cdsCFOPMensagem.Active) and (cdsCFOPMensagem.RecordCount > 0) then
  begin
    cdsCFOPMensagem.DisableControls;
    cdsCFOPMensagem.First;
    while not cdsCFOPMensagem.Eof do
    begin
      cdsCFOPMensagem.Edit;
      if cdsCFOPMensagemMARCADO.AsBoolean = True then
      begin
        cdsCFOPMensagemMARCADO.AsBoolean := False;
      end
      else
      begin
        cdsCFOPMensagemMARCADO.AsBoolean := True;
      end;
      cdsCFOPMensagem.Post;
      cdsCFOPMensagem.Next;
    end;
    cdsCFOPMensagem.First;
    cdsCFOPMensagem.EnableControls;
  end;
end;

procedure TfrmCadAbreviacaoFiscal.pImprimeFiltros(Excel: TExcel; Dados: TDataSet;
  Campos: TCampos; Filtros: Array Of String);
  Var
    intBand: Integer;
    strTipAbf: String;
begin
  With Excel, Campos, cxgAbfGeralTableView Do
  Begin
    PintarTudo(Branco);
    ProximaLinha;

    DefinirFonte('A1', 'A' + IntToStr(LinhaAtual -1), CourierNew, 15);

    For intBand := 0 To Bands.Count -1 Do
    Begin
      strTipAbf := LeftStr(Bands[intBand].Caption, 3);

      If fEmptyStr(strTipAbf) Then
        Continue;

      If Pos(strTipAbf, 'PEF_PEJ_PER_PES_PSI_PII_') > 0 Then
        strTipAbf := '_ENT_' + strTipAbf
      Else
        strTipAbf := '_SAI_' + strTipAbf;

      Negrito(LinhaAtual, ColunaPorNome['ABF_CODSIT' + strTipAbf].Coluna, True);

      Mesclar(fGetLetraAlfa(ColunaPorNome['ABF_CODSIT' + strTipAbf].Coluna) + IntToStr(LinhaAtual),
              fGetLetraAlfa(ColunaPorNome['ABF_ALQFCP' + strTipAbf].Coluna) + IntToStr(LinhaAtual));

      Alinhamento(LinhaAtual, ColunaPorNome['ABF_CODSIT' + strTipAbf].Coluna, Centro);
      Escrever   (LinhaAtual, ColunaPorNome['ABF_CODSIT' + strTipAbf].Coluna, Bands[intBand].Caption);

      Bordas(fGetLetraAlfa(ColunaPorNome['ABF_CODSIT' + strTipAbf].Coluna) + IntToStr(LinhaAtual),
             fGetLetraAlfa(ColunaPorNome['ABF_ALQFCP' + strTipAbf].Coluna) + IntToStr(LinhaAtual + cdsGrid.RecordCount + 1), True, True, True, True);
    End;

    CongelarPaines('B' + IntToStr(LinhaAtual + 2));
  End;
end;

procedure TfrmCadAbreviacaoFiscal.btnGravarClick(Sender: TObject);
  Var
    strErrSit: String;
    blnSavNovo : Boolean;
    ModoRecalculo: TOpcRecalculoTabelas;
    blnRecalculo: Boolean;


  function fGravar: Boolean;
  begin
    Try
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.fExecutarAcao := fGravarAbreviacao;
      frmGravando.ShowModal;
      Result := frmGravando.blnConfirma;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '');
      End;
    End;
    pFreeAndNil(frmGravando);
  end;

begin
  If fOperadorLimitado(Trim(strLoginUsuarioLogado)) Then
    Exit;

  inherited;

  blnSavNovo := blnNovo;

  If Not cdsGrid.IsEmpty Then
  Begin
    If Not blnPesquisa Then
    Begin
      If (fMensagem('', 'Confirma gravação da Abreviação Fiscal?', ['&Sim', '&Não']) = 2) Then
      Begin
        Exit;
      End;
    End;

    If Not fValidapanel(pnlHeader) Then
      Exit;

    If Not fValidaSitTributaria(strErrSit) Then
    Begin
      fMensagem('', strErrSit, ['&O k']);
      Exit;
    End;

    If blnDarRor And Not fValidaSitTributariaOrigem(strErrSit) Then
    Begin
      fMensagem('', strErrSit, ['&O k']);
      Exit;
    End;

    If Not fValidaGruposTributarios(strErrSit) Then
    Begin
      fMensagem('', strErrSit, ['&O k']);
      Exit;
    End;

    If (Not blnNovo) And (Not fValidaAlteracaoGrupoSAI_CCO) And (Not fEmptyStr(cdsGrid.FieldByName('ABF_CODABF').AsString)) And
       (Not fEmptyStr(cdsGrid.FieldByName('AUTOINCREM').AsString)) Then
    Begin
      If fMensagem('', MSG_ALTERACAO_PRECO_VENDA_DINAMICA, ['&Sim', '&Não'], 1) = 2 Then
        Exit
      Else
        pBloquearProdutosParaVenda(cdsGrid.Fieldbyname('ABF_CODABF').AsString);
    End;

    blnRecalculo := False;
    If (Not blnSavNovo) And fCfgSis('TABPRF', varBoolean) And fCfgSis('TABPRD', varBoolean) then
      blnRecalculo := fTemAlteracaoQuePreciseFazerRecalculo ;


    If Not fGravar Then
      Exit;

    If blnRecalculo then
    begin
      pCriarForm(TfrmMsgRecalcAbreviacao, frmMsgRecalcAbreviacao);
      Try
        ModoRecalculo.TipoCalculoMargemPreven := tcmNaoDefinido;
        while ModoRecalculo.TipoCalculoMargemPreven = tcmNaoDefinido  do
        begin
          ModoRecalculo := TfrmSelModoRecalculo.fSelecionaModoRecalculo;
          If ModoRecalculo.TipoCalculoMargemPreven = tcmNaoDefinido Then
            pMensagemOk('É preciso selecionar o modo de cálculo para reprocessar os itens.');
        End;
        TCalculaComposicaoCusto.fCalculaAlteracaoGeral('Abreviação Fiscal', cdsGrid.FieldbyName('ABF_CODABF').AsString, '',ModoRecalculo, True, nil);
      Finally
        FreeAndNil(frmMsgRecalcAbreviacao);
      End;

    End;
  End;

  pCarregaAbreviacao(edtCodAbf.Text);

  pnlHeader.Enabled := False;
  blnNovo := False;
  pOnStateChange(1);
  blnPesquisa := False;
end;

function TfrmCadAbreviacaoFiscal.fConfirmaHeranca(blnPergunta: Boolean): Boolean;
begin
  Result := True;
  If blnPergunta Then
     Result := fMensagem('ATENÇÃO!', 'Esta operação irá sobrepor todas os dados desta Abreviação que está '+
                                     'sendo alterada, pelos dados da abreviação escolhida na herança. '+
                                     'Confirma a operação ?', ['&Sim', '&Não']) = 1;
end;

procedure TfrmCadAbreviacaoFiscal.btnHerancaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrAbf: TConsultasArray;
    strCodAbf: String;
    strDescri: String;
    intField : Integer;
    intFieldQ: Integer;
    qryAux:    TUniQuery;
begin
  If fConfirmaHeranca(not blnNovo) Then
  Begin
    strCodAbf := edtCodAbf.Text;
    strDescri := edtDescri.Text;
    {*****************************}
    {* CONSULTA DE ABREV. FISCAL *}
    {**************************RV*}
    chrKey := '/';
    If btnHeranca.Enabled And fPesqAbrevFiscal(Self, edtCodAbf, edtDescri, qryTabela, chrKey, arrAbf) Then
    Begin
      If (Not blnNovo) Then
      Begin
        qryAux := fCriaQuery(nil);
        qryAux.Sql.Text := 'SELECT * FROM ABFICM WHERE ABF_CODABF = "'+edtCodAbf.Text+'"';
        qryAux.Open;
        edtCodAbf.Text := strCodAbf;
        edtDescri.Text := strDescri;
        cdsGrid.First;
        cdsGrid.DisableControls;
        While Not cdsGrid.Eof Do
        Begin
          qryAux.Filter := 'ABF_ESTADO = "'+cdsGrid.FieldByName('ABF_ESTADO').AsString+'"';
          qryAux.Filtered := True;
          If Not qryAux.isEmpty Then
          Begin
            cdsGrid.Edit;

            For intField := 0 To cdsGrid.Fields.Count - 1 Do
            Begin
              If cdsGrid.FindField(cdsGrid.Fields[intField].FieldName) <> Nil Then
              Begin
                If Pos(cdsGrid.Fields[intField].FieldName, 'AUTOINCREM_ABF_CODABF_ABF_DESABF') = 0 Then
                Begin
                  For intFieldQ := 0 To qryAux.Fields.Count - 1 Do
                  Begin
                    If (cdsGrid.Fields[intField].FieldName = qryAux.Fields[intFieldQ].FieldName) Then
                      cdsGrid.Fields[intField].Value := qryAux.Fields[intFieldQ].Value;
                  End;
                End;
              End;
            End;

            cdsGrid.Post;
          End;
          cdsGrid.Next;
        End;
        cdsGrid.EnableControls;
        FreeAndNil(qryAux);
        btnGravar.Click;
      End
      Else
      Begin
        pCarregaAbreviacao(edtCodAbf.Text);
        edtCodAbf.Clear;
        edtDescri.Clear;
        blnNovo := True;
        If (blnPesquisa) Then
        Begin
          edtCodAbf.Text := strCodAbf;
          edtDescri.Text := strDescri;
        End;
        pOnStateChange(0);
      End;
      pgcAbfIcm.ActivePage := tbsAlterar;
      pSetFocus(edtCodAbf);
    End;
  End;
end;

procedure TfrmCadAbreviacaoFiscal.btnHlpLinClick(Sender: TObject);
begin
  inherited;
  pAbreTelaHelp(Sender);
end;

function TfrmCadAbreviacaoFiscal.fGravarAbreviacao(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    qryGen   : TUniQuery;
    strSQL   : String;
    intRecNo : Integer;
    intField : Integer;
    prcScroll: TPrcScroll;
    intInc: Integer;
begin
  Result := False;
  intRecNo := cdsGrid.RecNo;

  Try
    If Not fStartTransaction Then
      Exit;

    pDisableControls(cdsGrid, prcScroll);

    chkRepEst.Checked := False;
    chkRepAll.Checked := False;
    chkRepTot.Checked := False;
    qryGen := fCriaQuery;

    If blnNovo Then
      intInc := 0
    Else
      intInc := 1;

//    pnlProgresso.Visible  := True;
    pbProgresso.Position := 0;
    pbProgresso.Max := cdsGrid.RecordCount + intInc;

    If Assigned(pgbStatus) Then
      pgbStatus.properties.Max := cdsGrid.RecordCount + intInc;

    cdsGrid.First;
    While Not cdsGrid.Eof Do
    Begin
      If (blnNovo) Then
      Begin
        strSQL := '';
        strSQL := strSQL + ' INSERT INTO ABFICM ( ';

        For intField := 0 To cdsGrid.FieldCount - 1 Do
        Begin
          strSQL := strSQL + cdsGrid.Fields[intField].FieldName;
          If intField < (cdsGrid.FieldCount - 1) Then
            strSQL := strSQL + ', ';
        End;

        strSQL := strSQL + ' ) ';
        strSQL := strSQL + ' VALUES ( ';

        For intField := 0 To cdsGrid.FieldCount - 1 Do
        Begin
          If cdsGrid.Fields[intField].FieldName = 'AUTOINCREM' Then
            strSQL := strSQL + ':AUTINC '
          Else
            strSQL := strSQL + AnsiReplaceStr(cdsGrid.Fields[intField].FieldName, 'ABF_', ':');

          If intField < (cdsGrid.FieldCount - 1) Then
            strSQL := strSQL + ', ';
        End;

        strSQL := strSQL + ' ) ';
      End
      Else
      Begin
        strSQL := '';
        strSQL := strSQL + ' UPDATE ';
        strSQL := strSQL + '   ABFICM ';
        strSQL := strSQL + ' SET ';

        For intField := 0 To cdsGrid.FieldCount - 1 Do
        Begin
          If cdsGrid.Fields[intField].FieldName <> 'AUTOINCREM' Then
          Begin
            strSQL := strSQL + cdsGrid.Fields[intField].FieldName + ' = ' +
                AnsiReplaceStr(cdsGrid.Fields[intField].FieldName, 'ABF_', ':');

            If intField < (cdsGrid.FieldCount - 1) Then
              strSQL := strSQL + ', ';
          End;
        End;

        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '   AUTOINCREM = :AUTINC ';
      End;

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        If (blnNovo) Then
        Begin
          ParamByName('AUTINC').AsString := fRetAutoIncrem('ABFICM', VS_strCodEmp);

          // Atribui o autoincrem no caso do usuário alterar antes de recarregar a abreviação.
          cdsGrid.Edit;
          cdsGrid.Fieldbyname('AUTOINCREM').AsString := ParamByName('AUTINC').AsString;
          cdsGrid.Post;
        End
        Else
          ParamByName('AUTINC').AsString := cdsGrid.Fieldbyname('AUTOINCREM').AsString;

        For intField := 0 To Params.Count - 1 Do
          If cdsGrid.FindField('ABF_' + Params[intField].Name) <> Nil Then
            Params[intField].Value := cdsGrid.FindField('ABF_' + Params[intField].Name).Value;

        ParamByName('CODABF').AsString := edtCodAbf.Text;
        ParamByName('DESABF').AsString := edtDescri.Text;
        ParamByName('CODEMP').AsString := VS_strCodEmp;

        If (blnNovo) Then
          lblInformacao.Caption := 'AGUARDE, INSERINDO ABREVIAÇÃO FISCAL - ' + cdsGrid.Fieldbyname('ABF_ESTADO').AsString
        Else
          lblInformacao.Caption := 'AGUARDE, ATUALIZANDO ABREVIAÇÃO FISCAL - ' + cdsGrid.Fieldbyname('ABF_ESTADO').AsString;

        If Assigned(pgbStatus) And (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
        Begin
          TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := lblInformacao.Caption;
        End;

        pbProgresso.Position := cdsGrid.RecNo;

        If Assigned(pgbStatus) Then
          pgbStatus.Position := cdsGrid.RecNo;

        Application.ProcessMessages;

        ExecSQL;
      End;

      cdsGrid.Next;

    End;

    If Not blnNovo Then
    Begin
      lblInformacao.Caption := 'AGUARDE, INSERINDO LOG DA ABREVIAÇÃO FISCAL';

      If Assigned(pgbStatus) And (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
      Begin
        TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := lblInformacao.Caption;
      End;

      pbProgresso.Position := pbProgresso.Position + 1;

      If Assigned(pgbStatus) Then
        pgbStatus.Position := pgbStatus.Position + 1;

      Application.ProcessMessages;

      Result := fGravaLogChanges;
      If Not Result Then
        Exit;

      If fCfgSis('USASAN', varBoolean) Then
        TProcessaImendesRetorno.pRefazResultadoApiSaneamento(edtCodAbf.Text);
    End;

    Result := fCommit;
  Finally
    If Not Result Then
      fRollBack;

    FreeAndNil(qryGen);

    Try
      cdsGrid.RecNo := intRecNo;
    Except
      cdsGrid.Last;
    End;

//    pnlProgresso.Visible  := False;

    pEnableControls(cdsGrid, prcScroll);
    blnNovo := False;
  End;

end;

function TfrmCadAbreviacaoFiscal.fHabilitaMsgItem_CodBeneficioFiscal(strTipAbf: string): Boolean;
begin
  Result := False;

  If (Pos('_PEF', strTipAbf) > 0) Then
    Exit(True);

  If (Pos('_PEJ', strTipAbf) > 0) Then
    Exit(True);

  If (Pos('_PER', strTipAbf) > 0) Then
    Exit(True);

  If (Pos('_PES', strTipAbf) > 0) Then
    Exit(True);
end;

function TfrmCadAbreviacaoFiscal.fNenhumGrupoSelecionado: Boolean;
Var
  intIndex: Integer;
begin

  Result := True;

  For intIndex := 0 To chkLstRepAll.Items.Count -1 Do
  Begin
    If chkLstRepAll.Checked[intIndex] Then
    Begin
      Result := False;
      Break;
    End;
  End;

end;

procedure TfrmCadAbreviacaoFiscal.pCriaAbreviacoes(strCodAbf: String);
Var
  intContador: Integer;
  intField: Integer;
Begin

  cdsGrid.DisableControls;
  cdsGrid.EmptyDataSet;

  {**********************************************}
  {* INSERE UM REGISTRO PARA CADA ESTADO        *}
  {*******************************************LU*}
  With cdsGrid Do
  Begin

    For intContador := 0 To 27 Do
    Begin
      Insert;
      FieldByName('ABF_ESTADO').AsString := String(ESTADOS[intContador]);

      For intField := 0 To Fields.Count - 1 Do
        If Fields[intField].DataType = ftFloat Then
          Fields[intField].AsFloat := 0

        Else If Fields[intField].DataType = ftString Then
          If Fields[intField].IsNull Then
            Fields[intField].AsString := EmptyStr;
      Post;
    End;

  End;

  cdsGrid.First;
  cdsGrid.EnableControls;

End;

procedure TfrmCadAbreviacaoFiscal.pCarregaAbrevAlteracao;
  Var
    strTipAbf: String;
    blnEhENT_: Boolean;
Begin
  pAtualizarEditsAbreviacao;
  pnlHeader.Enabled := True;
  pnlDadosAbrev.Enabled := True;
  pOnStateChange(0);

  strTipAbf := AnsiLeftStr(cmbTipAbf.Text,3);

  grpDifal.Enabled := (Pos(strTipAbf, 'PEF_PEJ_PER_PES_PSI_PII_CNC_') <= 0);

  chkALQCLI.Visible := False;
  btnDetReducao.Visible  := False;
  If fCfgsis('URSTCL', varBoolean) And  (Pos(strTipAbf, 'PEF_PEJ_PER_PES_PSI_PII_') > 0) Then
  Begin
    chkALQCLI.Visible := True;
    btnDetReducao.Visible  := True;
  End;

  If Pos(strTipAbf, 'PEF_PEJ_PER_PES_PSI_PII_') > 0 Then
    strTipAbf := '_ENT_' + strTipAbf
  Else
    strTipAbf := '_SAI_' + strTipAbf;

  grpDifal.Enabled := (Pos(strTipAbf, 'PEF_PEJ_PER_PES_PSI_PII_CNC_') <= 0);

  With cdsGrid Do
  Begin
    edtCodSit.Text := Fieldbyname('ABF_CODSIT' + strTipAbf).AsString;

    If (fTemCodigoOrigem(strTipAbf)) And (Assigned(FindField('ABF_CODSIT' + strTipAbf + '_O'))) Then
      edtCodSitOrigem.Text := Fieldbyname('ABF_CODSIT' + strTipAbf + '_O').AsString;

    edtBasIcm.Text            := FormatFloat('#,##0.00',fieldbyname('ABF_BASICM' + strTipAbf).AsFloat);
    edtAlqIcm.Text            := FormatFloat('#,##0.00',fieldbyname('ABF_ALQICM' + strTipAbf).AsFloat);
    edtAlqEfO.Text            := FormatFloat('#,##0.00',fieldbyname('ABF_ALQEFO' + strTipAbf).AsFloat);
    edtAlqIED.Text            := FormatFloat('#,##0.00',fieldbyname('ABF_ALQIED' + strTipAbf).AsFloat);
    edtAlqFCP.Text            := FormatFloat('#,##0.00',fieldbyname('ABF_ALQFCP' + strTipAbf).AsFloat);
    edtBasRet.Text            := FormatFloat('#,##0.0000',fieldbyname('ABF_BASRET' + strTipAbf).AsFloat);
    If Pos('_ENT_', strTipAbf) > 0 Then
      chkALQCLI.Checked := IIf(fieldbyname('ABF_ALQCLI' + strTipAbf).AsInteger = 1, True, False);
    edtAlqRet.Text            := FormatFloat('#,##0.00',fieldbyname('ABF_ALQRET' + strTipAbf).AsFloat);
    edtAlqRed.Text            := FormatFloat('#,##0.00',FieldByName('ABF_ALQRED' + strTipAbf).AsFloat);
    edtIVA_ST.Text            := FormatFloat('#,##0.0000',fieldbyname('ABF_IVA_ST' + strTipAbf).AsFloat);
    edtBasDifalDestino.Text   := FormatFloat('#,##0.0000',fieldbyname('ABF_BASDDS' + strTipAbf).AsFloat);
    edtImpostoImportacao.Text := FormatFloat('#,##0.00',fieldbyname('ABF_ALQIMP' + strTipAbf).AsFloat);

    blnEhENT_ := (Pos('ENT_', strTipAbf) > 0);
    If (blnEhENT_) and (not fHabilitaMsgItem_CodBeneficioFiscal(strTipAbf)) Then
    Begin
      edtMens01.Clear;
      edtMens02.Clear;
      edtMsgIte.Clear;
      edtCodBen.Clear;
      edtCodPre.Clear;
      edtPerPre.Clear;
      rdgCFOP.ItemIndex := 0;

      edtMens01.Enabled       := False;
      edtMens02.Enabled       := False;
      edtMsgIte.Enabled       := False;
      edtCodBen.Enabled       := False;
      edtCodPre.Enabled       := False;
      edtPerPre.Enabled       := False;
      rdgCFOP.Enabled         := False;

      rdgCFOPClick(rdgCFOP);
    End
    Else
    Begin
      edtMsgIte.Text    := FieldByName('ABF_MSGITE' + strTipAbf).AsString;
      edtCodBen.Text    := FieldByName('ABF_CODBEN' + strTipAbf).AsString;
      edtCodPre.Text    := FieldByName('ABF_CODPRE' + strTipAbf).AsString;
      edtPerPre.Text    := FormatFloat('#,##0.00',fieldbyname('ABF_PERPRE' + strTipAbf).AsFloat);

      if blnEhEnt_ then
      begin
        edtMens01.Clear;
        edtMens02.Clear;
        rdgCFOP.ItemIndex := 0;
      end
      else
      begin
        edtMens01.Text    := FieldByName('ABF_MENS01' + strTipAbf).AsString;
        edtMens02.Text    := FieldByName('ABF_MENS02' + strTipAbf).AsString;
        rdgCFOP.ItemIndex := FieldByName('ABF_IMPMSG').AsInteger;
        pBuscaCFOPMensagem(FieldByName('AUTOINCREM').AsString);
      end;

      edtMens01.Enabled       := not blnEhEnt_;
      edtMens02.Enabled       := not blnEhEnt_;
      edtMsgIte.Enabled       := True;
      edtCodBen.Enabled       := True;
      edtCodPre.Enabled       := True;
      edtPerPre.Enabled       := True;
      rdgCFOP.Enabled         := not blnEhEnt_;

      rdgCFOPClick(rdgCFOP);
    End;

    pAtualizaCheckRICMPR(strTipAbf);

    edtCodSitExit(nil);//Desabilita dados ST quando CST nao for de Substituicao

  End;

  cxgAbrev.Enabled := True;
  cxgAbfGeral.Enabled := True;

  pgcAbfIcm.ActivePage := tbsAlterar;
  pSetFocus(edtCodSit);
End;

procedure TfrmCadAbreviacaoFiscal.FormCreate(Sender: TObject);
begin
  inherited;
  edtCodAbf.MaxLength := fTamCodAbfIcm;
  edtCodAbf.TamCampo := fTamCodAbfIcm;
  dicSitTrib := TDicionario.Create;
  chkLstRepAll.OnKeyDown := pOnKeyDown;
  strEstEmp := fCadEmp('ESTADO');
  cdsGridLog := TUniClientDataSet.Create(nil);
end;

procedure TfrmCadAbreviacaoFiscal.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(FFrmAutomatizado) Then
    FreeAndNil(FFrmAutomatizado);

  FreeAndNil(qryConTrD);
  FreeAndNil(dicSitTrib);
  FreeAndNil(cdsGridLog);
  FreeAndNil(cdsLogABF);
  FreeAndNil(cdsGridBackup);
end;

function TfrmCadAbreviacaoFiscal.fGetColunaFocadaGeral: String;
  Var
    intCol: Integer;
begin
  For intCol := 0 To cxgAbfGeralTableView.ColumnCount -1 Do
    If cxgAbfGeralTableView.Columns[intCol].Focused Then
      Result := cxgAbfGeralTableView.Columns[intCol].DataBinding.FieldName;
end;

function TfrmCadAbreviacaoFiscal.fRICMPREntrada(strTipAbf: String): Boolean;
begin
  If Length(strTipAbf) > 3 Then
    strTipAbf := Copy(strTipAbf, length(strTipAbf) -3, 3) ;
  Result := Pos(strTipAbf, '_PEF_PEJ_PER_PES_PII_PSI') > 0
end;

function TfrmCadAbreviacaoFiscal.fSetaIndiceParaAlterarGeral: Boolean;
  Var
    intIndex: Integer;
begin
  Result := False;
  If fCheckParent(ActiveControl, cxgAbfGeral) And Not fEmptyStr(fGetColunaFocadaGeral) Then
  Begin
    For intIndex := 0 To cmbTipAbf.Items.Count -1 Do
      If Pos('_' + LeftStr(cmbTipAbf.Items[intIndex], 3), fGetColunaFocadaGeral) > 0 Then
      Begin
        cmbTipAbf.ItemIndex := intIndex;
        cmbTipAbfChange(nil);
        Result := True;        
        Break;
      End;
  End;
end;

procedure TfrmCadAbreviacaoFiscal.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Assigned(ActiveControl) And (fCheckParent(ActiveControl, cxgAbrev) Or
                                  fCheckParent(ActiveControl, cxgAbfGeral)) Then
  Begin
    Case Key Of
      VK_Return:Begin
                  If Not fSetaIndiceParaAlterarGeral Then
                    pCarregaAbrevAlteracao;
                End;

      VK_Escape:Begin
                  If cdsGrid.IsEmpty Then
                    Close
                  Else
                    btnCancela.Click;
                End;

      VK_F2: If pgcAbfIcm.ActivePage = tbsGeral Then
             Begin
               btnGeraExcel.Click;
             End;
    End;
  End
  Else
  Begin
    Case Key Of
      VK_Escape: Begin
                   If btnSair.Enabled Then
                   Begin
                     Key := 0;
                     btnSair.Click;
                   End
                   Else
                   Begin
                     Key := 0;
                     btnCancela.Click;
                   End;
                 End;

      VK_F2: If pgcAbfIcm.ActivePage = tbsGeral Then
             Begin
               btnGeraExcel.Click;
             End;
    End;
  End;

end;

procedure TfrmCadAbreviacaoFiscal.FormPaint(Sender: TObject);
begin
  inherited;
  btnSair.Left := (pnlBotoes.Width-(btnSair.Width+10));
end;

{*******************************************}
{* VERIFICA SE O CODIGO DA ABREV É VALIDO  *}
{****************************************LU*}
function TfrmCadAbreviacaoFiscal.fValidaCodAbf(strCodAbf: String): Boolean;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
begin
  qryTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  ABF_CODABF ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ABFICM ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ABF_CODABF = :CODABF ';

  With qryTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODABF').AsString := strCodAbf;
    Open;
    If IsEmpty Then
      Result := True
    Else
      Result := False;
    Close;
  End;

  FreeAndNil(qryTmp);
end;

function TfrmCadAbreviacaoFiscal.fValidaGruposSelecionados: Boolean;
begin
  Result := True;

  If (chkRepAll.Checked Or chkRepTot.Checked) And (fNenhumGrupoSelecionado) Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO!', 'Quando estiver marcado o campo "' + IfThen(chkRepAll.Checked, MSG_REPALL, MSG_REPTOT) + '", é obrigatório selecionar pelo menos um grupo', ['&O k'])
  End;
end;

function TfrmCadAbreviacaoFiscal.fValidaAlteracaoGrupoSAI_CCO: Boolean;
  Var
    prcScroll: TPrcScroll;
    qryAbfCco: TUniQuery;
    strIndex : String;
begin
  Result := True;

  If Not fCfgSis('CLPVDI', varBoolean) Then
    Exit;

  qryAbfCco := fCriaQuery(Self);
  pDisableControls(cdsGrid, prcScroll);
  strIndex := cdsGrid.IndexFieldNames;
  Try
    qryAbfCco.Close;
    qryAbfCco.SQL.Clear;
    qryAbfCco.SQL.Add(' SELECT ABF_ESTADO, ABF_IVA_ST_SAI_CCO, ABF_ALQICM_SAI_CCO, ABF_CODSIT_SAI_CCO, ABF_ICMPRD_SAI_CCO ');
    qryAbfCco.SQL.Add('   FROM ABFICM ');
    qryAbfCco.SQL.Add('  WHERE ABF_CODABF = :CODABF ');
    qryAbfCco.ParamByName('CODABF').AsString := cdsGrid.FieldByName('ABF_CODABF').AsString;
    qryAbfCco.Open;

    pnlProgresso.Visible  := True;
    pbProgresso.Position := 0;
    pbProgresso.Max := qryAbfCco.RecordCount;

    cdsGrid.IndexFieldNames := 'ABF_ESTADO';

    qryAbfCco.First;
    While Not qryAbfCco.Eof Do
    Begin
      pbProgresso.Position := qryAbfCco.RecNo;
      lblInformacao.Caption := 'AGUARDE... GERANDO PENDÊNCIAS DOS PRODUTOS.';
      Application.ProcessMessages;

      If cdsGrid.FindKey([qryAbfCco.FieldByName('ABF_ESTADO').AsString]) Then
      Begin
        If (cdsGrid.FieldByName('ABF_IVA_ST_SAI_CCO').AsFloat <> qryAbfCco.FieldByName('ABF_IVA_ST_SAI_CCO').AsFloat) Then
        Begin
          Result := False;
          Break;
        End;

        If (cdsGrid.FieldByName('ABF_ALQICM_SAI_CCO').AsFloat <> qryAbfCco.FieldByName('ABF_ALQICM_SAI_CCO').AsFloat) Then
        Begin
          Result := False;
          Break;
        End;

        If (cdsGrid.FieldByName('ABF_ICMPRD_SAI_CCO').AsFloat <> qryAbfCco.FieldByName('ABF_ICMPRD_SAI_CCO').AsFloat) Then
        Begin
          Result := False;
          Break;
        End;

        If (cdsGrid.FieldByName('ABF_CODSIT_SAI_CCO').AsString <> qryAbfCco.FieldByName('ABF_CODSIT_SAI_CCO').AsString) Then
        Begin
          Result := False;
          Break;
        End;
      End;

      qryAbfCco.Next;
    End;

    qryAbfCco.Close;
  Finally
    FreeAndNil(qryAbfCco);
    cdsGrid.IndexFieldNames := strIndex;
    pnlProgresso.Visible  := False;
    pEnableControls(cdsGrid, prcScroll);
  End;
end;

function TfrmCadAbreviacaoFiscal.fValidaGruposTributarios(
  var strErrSit: String): Boolean;
  Var
    intIndex: Integer;
    strTipAbf: String;
    prcScroll: TPrcScroll;
begin
  With cdsGrid Do
  Begin
    Try
      pDisableControls(cdsGrid, prcScroll);

      pnlProgresso.Visible  := True;
      pbProgresso.Position := 0;
      pbProgresso.Max := cmbTipAbf.Items.Count;
      strErrSit := '';

      For intIndex := 0 To cmbTipAbf.Items.Count -1 Do
      Begin
        pbProgresso.Position := Succ(intIndex);
        lblInformacao.Caption := 'AGUARDE, VALIDANDO GRUPOS..';
        Application.ProcessMessages;

        strTipAbf := LeftStr(cmbTipAbf.Items[intIndex], 3);

        If Pos(strTipAbf, 'PEF_PEJ_PER_PES_PII_PSI_') > 0 Then
          strTipAbf := 'ENT_' + strTipAbf
        Else
          strTipAbf := 'SAI_' + strTipAbf;

        Filtered := False;
        Filter   := 'ABF_CODSIT_' + strTipAbf + ' = ' + QuotedStr('');
        Filtered := True;

        If Not IsEmpty Then
          strErrSit := strErrSit + LeftStr(cmbTipAbf.Items[intIndex], 3) + ',';
      End;

      If Not fEmptyStr(strErrSit) Then
      Begin
        If strErrSit[Length(strErrSit)] = ',' Then
        Begin
           strErrSit[Length(strErrSit)] := ' ';
           strErrSit := Trim(strErrSit);
        End;

        strErrSit := 'Os grupos (' + strErrSit + ') não foram cadastrados.' + #13#10 +
                     'Favor realizar o cadastro ou replicar as informações de um grupo já cadastrado.';
      End;

      Result := fEmptyStr(strErrSit);
    Finally
      Filtered := False;
      Filter   := EmptyStr;
      Filtered := True;
      pnlProgresso.Visible  := False;
      pEnableControls(cdsGrid, prcScroll);
    End;
  End;
end;

procedure TfrmCadAbreviacaoFiscal.btnExcluirClick(Sender: TObject);
  Var
    qryGen: TUniQuery;
    strSQL: String;
begin
  If fOperadorLimitado(Trim(strLoginUsuarioLogado)) Then
    Exit;

  inherited;

  If cdsGrid.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 1 Then
  Begin
    Try
      fStartTransaction();

      qryGen := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + ' DELETE FROM ';
      strSQL := strSQL + '   ABFICM ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   ABF_CODABF = :CODABF ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODABF').AsString := edtCodAbf.Text;
        ExecSQL;
      End;

      fCommit();

      FreeAndNil(qryGen);
      If btnIncluir.CanFocus Then
        pSetFocus(btnIncluir)

      Else If btnPesquisa.CanFocus Then
        pSetFocus(btnPesquisa);

      pCarregaAbreviacao('');
      pLimpaEdits(True);

    Except
      On E: Exception Do
      Begin
        fRollBack();
        FreeAndNil(qryGen);
        pMensagensErro(E.Message,'[TfrmCadAbreviacaoFiscal.btnExcluirClick]');
      End;
    End;
  End;
end;

procedure TfrmCadAbreviacaoFiscal.btnCancelaEstadoClick(Sender: TObject);
begin
  inherited;
  pLimpaEdits(False);

  pgcAbfIcm.ActivePage := tbsAlterar;
  pSetFocus(cxgAbrev);
end;

procedure TfrmCadAbreviacaoFiscal.btnDetReducaoClick(Sender: TObject);
begin
  TfrmAbfIcmDetalheAliquotaCargaMedia.pExibirAliquotaCargaMedia(cdsGridBackup ,
                                                                AnsiLeftStr(cmbTipAbf.Text,3) ,
                                                                chkALQCLI.Checked,
                                                                edtEstAtu.Text,
                                                                StrToFloat(edtAlqRet.Text),
                                                                StrToFloat(edtBasRet.Text),
                                                                StrToFloat(edtIVA_ST.Text));
end;

procedure TfrmCadAbreviacaoFiscal.btnAdicionarEstadoClick(Sender: TObject);
begin
  fExecutarModal(pAdicionarEstado, 'Atualizando dados (' + edtEstAtu.Text  + '), Aguarde ...', '');
end;

procedure TfrmCadAbreviacaoFiscal.pAdicionarEstado();
  Var
    intRecNo: Integer;
    intIndex: Integer;
    strTipAbf: String;
    strTipAtu: String;
    strEstAtu: String;
    prcScroll: TprcScroll;

  procedure pAlteraDadosAbreviacao(strTipo: String; blnRepGru: Boolean = False; strTipAtu: String = '');
  begin
    With cdsGrid Do
    Begin
      Edit;

      If (blnRepGru) Then
      Begin
        FieldByName('ABF_CODSIT' + strTipo).AsString := FieldByName('ABF_CODSIT' + strTipAtu).AsString;

        If Pos('ENT_', strTipo + strTipAtu) <= 0 Then
        Begin
          FieldByName('ABF_MENS01' + strTipo).AsString := FieldByName('ABF_MENS01' + strTipAtu).AsString;
          FieldByName('ABF_MENS02' + strTipo).AsString := FieldByName('ABF_MENS02' + strTipAtu).AsString;
          FieldByName('ABF_MENPR1' + strTipo).AsString := FieldByName('ABF_MENPR1' + strTipAtu).AsString;
          FieldByName('ABF_MENPR2' + strTipo).AsString := FieldByName('ABF_MENPR2' + strTipAtu).AsString;
        End;

        If Assigned(FindField('ABF_CODSIT' + strTipo + '_O')) Then
        Begin
          If Not ((Pos('SAI_', strTipAtu) > 0 ) And (Pos('ENT_', strTipo) > 0)) Then
          Begin
            If fTemCodigoOrigem(strTipo) Then
              If Assigned(FindField('ABF_CODSIT' + strTipAtu + '_O')) Then
                FieldByName('ABF_CODSIT' + strTipo + '_O').AsString := FieldByName('ABF_CODSIT' + strTipAtu + '_O').AsString
            Else
                FieldByName('ABF_CODSIT' + strTipo + '_O').Clear;
          End;
        End;

        FieldByName('ABF_BASICM' + strTipo).AsFloat  := FieldByName('ABF_BASICM' + strTipAtu).AsFloat;
        FieldByName('ABF_ALQICM' + strTipo).AsFloat  := FieldByName('ABF_ALQICM' + strTipAtu).AsFloat;
        FieldByName('ABF_ICMPRD' + strTipo).AsFloat  := FieldByName('ABF_ICMPRD' + strTipAtu).AsFloat;
        FieldByName('ABF_ALQEFO' + strTipo).AsFloat  := FieldByName('ABF_ALQEFO' + strTipAtu).AsFloat;
        FieldByName('ABF_ALQIED' + strTipo).AsFloat  := FieldByName('ABF_ALQIED' + strTipAtu).AsFloat;
        FieldByName('ABF_ALQFCP' + strTipo).AsFloat  := FieldByName('ABF_ALQFCP' + strTipAtu).AsFloat;
        FieldByName('ABF_BASRET' + strTipo).AsFloat  := FieldByName('ABF_BASRET' + strTipAtu).AsFloat;
        FieldByName('ABF_ALQRET' + strTipo).AsFloat  := FieldByName('ABF_ALQRET' + strTipAtu).AsFloat;
        FieldByName('ABF_ALQRED' + strTipo).AsFloat  := FieldByName('ABF_ALQRED' + strTipAtu).AsFloat;
        If (Pos('_ENT_', strTipo) > 0) And (cdsGrid.FindField('ABF_ALQCLI' + strTipAtu) <> NIL) And (cdsGrid.FindField('ABF_ALQCLI' + strTipo) <> NIL) Then
          FieldByName('ABF_ALQCLI' + strTipo).AsInteger := FieldByName('ABF_ALQCLI' + strTipAtu).AsInteger;
        FieldByName('ABF_IVA_ST' + strTipo).AsFloat  := FieldByName('ABF_IVA_ST' + strTipAtu).AsFloat;
        FieldByName('ABF_BASDOR' + strTipo).AsFloat  := FieldByName('ABF_BASDOR' + strTipAtu).AsFloat;
        FieldByName('ABF_BASDDS' + strTipo).AsFloat  := FieldByName('ABF_BASDDS' + strTipAtu).AsFloat;

      End
      Else
      Begin
        FieldByName('ABF_CODSIT' + strTipo).AsString := edtCodSit.Text;

        If (fTemCodigoOrigem(strTipo)) And (cdsGrid.FindField('ABF_CODSIT' + strTipo + '_O') <> Nil) Then
          If Not ((Pos('SAI_', strTipAtu) > 0 ) And (Pos('ENT_', strTipo) > 0)) Then
            FieldByName('ABF_CODSIT' + strTipo + '_O').AsString := edtCodSitOrigem.Text;

        If Pos('ENT_', strTipo) <= 0 Then
        Begin
          FieldByName('ABF_MENS01' + strTipo).AsString := edtMens01.Text;
          FieldByName('ABF_MENS02' + strTipo).AsString := edtMens02.Text;
          FieldByName('ABF_MSGITE' + strTipo).AsString := edtMsgIte.Text;
          FieldByName('ABF_CODBEN' + strTipo).AsString := edtCodBen.Text;
          FieldByName('ABF_CODPRE' + strTipo).AsString := edtCodPre.Text;
          FieldByName('ABF_PERPRE' + strTipo).AsFloat  := fStrToFloat(edtPerPre.Text);
          FieldByName('ABF_IMPMSG').AsInteger := rdgCFOP.ItemIndex;
          pOnChangeField(FieldByName('ABF_IMPMSG'));
          if rdgCFOP.ItemIndex = 1 then
          begin
            pGravaCFOPMensagem(FieldByName('AUTOINCREM').AsString);
          end;
        End
        Else If (fHabilitaMsgItem_CodBeneficioFiscal(strTipAbf)) then
        Begin
          FieldByName('ABF_MSGITE' + strTipo).AsString := edtMsgIte.Text;
          FieldByName('ABF_CODBEN' + strTipo).AsString := edtCodBen.Text;
          FieldByName('ABF_CODPRE' + strTipo).AsString := edtCodPre.Text;
          FieldByName('ABF_PERPRE' + strTipo).AsFloat  := fStrToFloat(edtPerPre.Text);
        End;

        FieldByName('ABF_BASICM' + strTipo).AsFloat  := fStrToFloat(edtBasIcm.Text);
        FieldByName('ABF_ALQICM' + strTipo).AsFloat  := fStrToFloat(edtAlqIcm.Text);
        FieldByName('ABF_ICMPRD' + strTipo).AsFloat  := fStrToFloat(edtIcmPrd.Text);
        FieldByName('ABF_ALQEFO' + strTipo).AsFloat  := fStrToFloat(edtAlqEfO.Text);
        FieldByName('ABF_ALQIED' + strTipo).AsFloat  := fStrToFloat(edtAlqIED.Text);
        FieldByName('ABF_ALQFCP' + strTipo).AsFloat  := fStrToFloat(edtAlqFCP.Text);
        FieldByName('ABF_BASRET' + strTipo).AsFloat  := fStrToFloat(edtBasRet.Text);
        If (Pos('_ENT_', strTipAbf) > 0) And (Assigned(cdsGrid.FindField('ABF_ALQCLI' + strTipo))) Then
          FieldByName('ABF_ALQCLI' + strTipo).AsInteger := IIf(chkALQCLI.Checked, 1, 0);

        FieldByName('ABF_ALQRET' + strTipo).AsFloat  := fStrToFloat(edtAlqRet.Text);
        FieldByName('ABF_ALQRED' + strTipo).AsFloat  := fStrToFloat(edtAlqRed.Text);
        FieldByName('ABF_IVA_ST' + strTipo).AsFloat  := fStrToFloat(edtIVA_ST.Text);
        FieldByName('ABF_BASDDS' + strTipo).AsFloat  := fStrToFloat(edtBasDifalDestino.Text);
        FieldByName('ABF_ALQIMP' + strTipo).AsFloat  := fStrToFloat(edtImpostoImportacao.Text);

        If (cdsGrid.FieldByName('ABF_ESTADO').AsString = strEstEmp) And (strTipo='_SAI_CNC') Then
        Begin
          FieldByName('ABF_RICMPR_SAI_CNC').AsString := IIF(chkRIcmPR.Checked, 'S', 'N');
          pOnChangeField(FieldByName('ABF_RICMPR_SAI_CNC'));

          FieldByName('ABF_ALQRIC_SAI_CNC').AsFloat := fStrToFloat(edtAliquotaRICMSPR.Text);
          pOnChangeField(FieldByName('ABF_ALQRIC_SAI_CNC'));
        End;

        If (cdsGrid.FieldByName('ABF_ESTADO').AsString = strEstEmp) And (strTipo='_SAI_IND') Then
        Begin
          FieldByName('ABF_RICMPR_SAI_IND').AsString := IIF(chkRIcmPR.Checked, 'S', 'N');
          pOnChangeField(FieldByName('ABF_RICMPR_SAI_IND'));

          FieldByName('ABF_ALQRIC_SAI_IND').AsFloat := fStrToFloat(edtAliquotaRICMSPR.Text);
          pOnChangeField(FieldByName('ABF_ALQRIC_SAI_IND'));
        End;

        If (cdsGrid.FieldByName('ABF_ESTADO').AsString = strEstEmp) And (strTipo='_SAI_SNA') Then
        Begin
          FieldByName('ABF_RICMPR_SAI_SNA').AsString := IIF(chkRIcmPR.Checked, 'S', 'N');
          pOnChangeField(FieldByName('ABF_RICMPR_SAI_SNA'));

          FieldByName('ABF_ALQRIC_SAI_SNA').AsFloat := fStrToFloat(edtAliquotaRICMSPR.Text);
          pOnChangeField(FieldByName('ABF_ALQRIC_SAI_SNA'));
        End;

        If (cdsGrid.FieldByName('ABF_ESTADO').AsString = strEstEmp) And (strTipo='_SAI_TRS') Then
        Begin
          FieldByName('ABF_RICMPR_SAI_TRS').AsString := IIF(chkRIcmPR.Checked, 'S', 'N');
          pOnChangeField(FieldByName('ABF_RICMPR_SAI_TRS'));

          FieldByName('ABF_ALQRIC_SAI_TRS').AsFloat := fStrToFloat(edtAliquotaRICMSPR.Text);
          pOnChangeField(FieldByName('ABF_ALQRIC_SAI_TRS'));
        End;

        If (cdsGrid.FieldByName('ABF_ESTADO').AsString = strEstEmp) And (strTipo='_ENT_PEF') Then
        Begin
          FieldByName('ABF_RICMPR_ENT_PEF').AsString := IIF(chkRIcmPR.Checked, 'S', 'N');
          pOnChangeField(FieldByName('ABF_RICMPR_ENT_PEF'));

          FieldByName('ABF_ALQRIC_ENT_PEF').AsFloat := fStrToFloat(edtAliquotaRICMSPR.Text);
          pOnChangeField(FieldByName('ABF_ALQRIC_ENT_PEF'));
        End;

        If (cdsGrid.FieldByName('ABF_ESTADO').AsString = strEstEmp) And (strTipo='_ENT_PEJ') Then
        Begin
          FieldByName('ABF_RICMPR_ENT_PEJ').AsString := IIF(chkRIcmPR.Checked, 'S', 'N');
          pOnChangeField(FieldByName('ABF_RICMPR_ENT_PEJ'));

          FieldByName('ABF_ALQRIC_ENT_PEJ').AsFloat := fStrToFloat(edtAliquotaRICMSPR.Text);
          pOnChangeField(FieldByName('ABF_ALQRIC_ENT_PEJ'));
        End;
        If (cdsGrid.FieldByName('ABF_ESTADO').AsString = strEstEmp) And (strTipo='_ENT_PSI') Then
        Begin
          FieldByName('ABF_RICMPR_ENT_PSI').AsString := IIF(chkRIcmPR.Checked, 'S', 'N');
          pOnChangeField(FieldByName('ABF_RICMPR_ENT_PSI'));

          FieldByName('ABF_ALQRIC_ENT_PSI').AsFloat := fStrToFloat(edtAliquotaRICMSPR.Text);
          pOnChangeField(FieldByName('ABF_ALQRIC_ENT_PSI'));
        End;
        If (cdsGrid.FieldByName('ABF_ESTADO').AsString = strEstEmp) And (strTipo='_ENT_PII') Then
        Begin
          FieldByName('ABF_RICMPR_ENT_PII').AsString := IIF(chkRIcmPR.Checked, 'S', 'N');
          pOnChangeField(FieldByName('ABF_RICMPR_ENT_PII'));

          FieldByName('ABF_ALQRIC_ENT_PII').AsFloat := fStrToFloat(edtAliquotaRICMSPR.Text);
          pOnChangeField(FieldByName('ABF_ALQRIC_ENT_PII'));
        End;

        If (cdsGrid.FieldByName('ABF_ESTADO').AsString = strEstEmp) And (strTipo='_ENT_PER') Then
        Begin
          FieldByName('ABF_RICMPR_ENT_PER').AsString := IIF(chkRIcmPR.Checked, 'S', 'N');
          pOnChangeField(FieldByName('ABF_RICMPR_ENT_PER'));

          FieldByName('ABF_ALQRIC_ENT_PER').AsFloat := fStrToFloat(edtAliquotaRICMSPR.Text);
          pOnChangeField(FieldByName('ABF_ALQRIC_ENT_PER'));
        End;

        If (cdsGrid.FieldByName('ABF_ESTADO').AsString = strEstEmp) And (strTipo='_ENT_PES') Then
        Begin
          FieldByName('ABF_RICMPR_ENT_PES').AsString := IIF(chkRIcmPR.Checked, 'S', 'N');
          pOnChangeField(FieldByName('ABF_RICMPR_ENT_PES'));

          FieldByName('ABF_ALQRIC_ENT_PES').AsFloat := fStrToFloat(edtAliquotaRICMSPR.Text);
          pOnChangeField(FieldByName('ABF_ALQRIC_ENT_PES'));
        End;

        pSetarDadosDaComboboxTipoCalculoSt(strTipo);
      End;
      pOnChangeField(FieldByName('ABF_CODSIT' + strTipo));
      pOnChangeField(FieldByName('ABF_PEIMPG'));
      If (Pos('ENT_', strTipo + strTipAtu) <= 0) Or (Pos('ENT_', strTipo) <= 0) Then
      Begin
        pOnChangeField(FieldByName('ABF_MENS01' + strTipo));
        pOnChangeField(FieldByName('ABF_MENS02' + strTipo));
        pOnChangeField(FieldByName('ABF_MENPR1' + strTipo));
        pOnChangeField(FieldByName('ABF_MENPR2' + strTipo));
      End;

      pOnChangeField(FieldByName('ABF_BASICM' + strTipo));
      pOnChangeField(FieldByName('ABF_ALQICM' + strTipo));
      pOnChangeField(FieldByName('ABF_ICMPRD' + strTipo));
      pOnChangeField(FieldByName('ABF_ALQEFO' + strTipo));
      pOnChangeField(FieldByName('ABF_ALQIED' + strTipo));
      pOnChangeField(FieldByName('ABF_ALQFCP' + strTipo));
      pOnChangeField(FieldByName('ABF_BASRET' + strTipo));
      pOnChangeField(FieldByName('ABF_ALQRET' + strTipo));
      pOnChangeField(FieldByName('ABF_ALQRED' + strTipo));
      pOnChangeField(FieldByName('ABF_IVA_ST' + strTipo));
      pOnChangeField(FieldByName('ABF_BASDOR' + strTipo));
      pOnChangeField(FieldByName('ABF_BASDDS' + strTipo));

      Post;
    End;
  end;

  procedure pSetaVarTipoAbf;
  begin
    If Pos(strTipAbf, 'PEF_PEJ_PER_PES_PSI_PII_') > 0 Then
      strTipAbf := '_ENT_' + strTipAbf
    Else
      strTipAbf := '_SAI_' + strTipAbf;
  end;

begin
  inherited;
  Try
    cxgAbrevTableView.DataController.DataSource := nil;
    cxgAbfGeralTableView.DataController.DataSource := nil;
    cxgImpPagDBTableView.DataController.DataSource := nil;

    pDisableControls(cdsGrid, prcScroll);

    If (Not fValidaGruposSelecionados) Then
    Begin
      Exit;
    End;

    If Not (fVerificaSubControl(pnlHeader) And fVerificaSubControl(pnlDadosAbrev)) Then
    Begin
      blnMudarFoco := True;
      Exit;
    End;

    With cdsGrid Do
    Begin
      intRecNo := RecNo;

      strTipAbf := AnsiLeftStr(cmbTipAbf.Text,3);
      pSetaVarTipoAbf;
      strTipAtu := strTipAbf;
      strEstAtu := FieldByName('ABF_ESTADO').AsString;

      // ALTERA UM UNICO ESTADO
      pAlteraDadosAbreviacao(strTipAbf);

      // ALTERA TODOS OS ESTADOS
      If chkRepEst.Checked Then
      Begin
        First;
        While Not Eof Do
        Begin
          pAlteraDadosAbreviacao(strTipAbf);
          Next;
        End;
      End

      // // REPLICA O ESTADO ATUAL PARA OS GRUPOS SELECIONADOS
      Else If chkRepAll.Checked Then
      Begin
        First;
        While Not Eof Do
        Begin
          For intIndex := 0 To chkLstRepAll.Items.Count -1 Do
          Begin
            If chkLstRepAll.Checked[intIndex] Then
            Begin
              If (strEstAtu = FieldByName('ABF_ESTADO').AsString) Then
              Begin
                strTipAbf := AnsiLeftStr(chkLstRepAll.Items[intIndex],3);
                pSetaVarTipoAbf;
                pAlteraDadosAbreviacao(strTipAbf, False, strTipAtu);
              End;
            End;
          End;
          Next;
        End;
      End

      // REPLICA O GRUPO ATUAL PARA OS GRUPOS SELECIONADOS
      Else If chkRepTot.Checked Then
      Begin
        First;
        While Not Eof Do
        Begin
          For intIndex := 0 To chkLstRepAll.Items.Count -1 Do
          Begin
            If chkLstRepAll.Checked[intIndex] Then
            Begin
              strTipAbf := AnsiLeftStr(chkLstRepAll.Items[intIndex],3);
              pSetaVarTipoAbf;

              If (strTipAbf <> strTipAtu) Then
                pAlteraDadosAbreviacao(strTipAbf, True, strTipAtu);
            End;
          End;
          Next;
        End;
      End;

      If Not blnPreenchimentoAutomatizado Then
      Begin
        cdsGrid.Close;
        cdsGrid.Open;
      End;

      RecNo := intRecNo;

      pEnableControls(cdsGrid, prcScroll);


    End;

    chkRepEst.Checked := False;
    chkRepAll.Checked := False;
    chkRepTot.Checked := False;
    pgcAbfIcm.ActivePage := tbsAlterar;
    cxgAbrevTableView.DataController.DataSource := dtsGrid;
    cxgAbfGeralTableView.DataController.DataSource := dtsGrid;
    cxgImpPagDBTableView.DataController.DataSource := dtsGrid;


    cxgAbrevTableView.DataController.Refresh;
    cxgAbfGeralTableView.DataController.Refresh;
    cxgImpPagDBTableView.DataController.Refresh;
    pSetFocus(cxgAbrev);

  Finally
    cxgAbrevTableView.DataController.DataSource := dtsGrid;
    cxgAbfGeralTableView.DataController.DataSource := dtsGrid;
    cxgImpPagDBTableView.DataController.DataSource := dtsGrid;
    pEnableControls(cdsGrid, prcScroll);
  End;
end;

{*****************************************************}
{* VERIFICA SE TODOS OS ABF_CODSIT ESTAO PREENCHIDOS *}
{**************************************************JB*}
function TfrmCadAbreviacaoFiscal.fValidaSitTributaria(Var strErrSit: String) : Boolean;
  Var
    intIndex: Integer;
    strTipAbf,
    strTipAbfSel: String;
    prcScroll: TPrcScroll;
begin
  With cdsGrid Do
  Begin
    Try
      pDisableControls(cdsGrid, prcScroll);

      pnlProgresso.Visible  := True;
      pbProgresso.Position := 0;
      pbProgresso.Max := cmbTipAbf.Items.Count;
      strTipAbfSel := LeftStr(cmbTipAbf.Text, 3);
      strErrSit    := '';

      For intIndex := 0 To cmbTipAbf.Items.Count -1 Do
      Begin
        pbProgresso.Position := Succ(intIndex);
        lblInformacao.Caption := 'AGUARDE, VALIDANDO CST (' + cmbTipAbf.Items[intIndex] + ')';
        Application.ProcessMessages;

        strTipAbf    := LeftStr(cmbTipAbf.Items[intIndex], 3);

        If Pos(strTipAbf, 'PEF_PEJ_PER_PES_PSI_PII_') > 0 Then
          strTipAbf := 'ENT_' + strTipAbf
        Else
          strTipAbf := 'SAI_' + strTipAbf;

        Filtered := False;
        Filter   := 'ABF_CODSIT_' + strTipAbf + ' = ' + QuotedStr('');
        Filtered := True;

        While Not Eof Do
        Begin
          strErrSit := strErrSit + IIF(fEmptyStr(strErrSit), Fieldbyname('ABF_ESTADO').AsString, ', ' + Fieldbyname('ABF_ESTADO').AsString);
          Next;
        End;

        strErrSit := cmbTipAbf.Items[intIndex] + #13#10 +
          'É necessário preencher a Situação Tributária (' + strErrSit + ')!';

        If (Not IsEmpty) And (strTipAbfSel = LeftStr(cmbTipAbf.Items[intIndex], 3)) Then
        Begin
          cmbTipAbf.ItemIndex := intIndex;
          cmbTipAbfChange(nil);
          Break;
        End
        Else
          strErrSit := '';
      End;

      Result := fEmptyStr(strErrSit);
    Finally
      Filtered := False;
      Filter   := EmptyStr;
      Filtered := True;
      pnlProgresso.Visible  := False;
      pEnableControls(cdsGrid, prcScroll);
    End;
  End;

end;

function TfrmCadAbreviacaoFiscal.fValidaSitTributariaOrigem(Var strErrSit: String) : Boolean;
  Var
    intIndex: Integer;
    strTipAbf: String;
    prcScroll: TPrcScroll;
begin
  With cdsGrid Do
  Begin
    Try
      pDisableControls(cdsGrid, prcScroll);

      pnlProgresso.Visible  := True;
      pbProgresso.Position := 0;
      pbProgresso.Max := cmbTipAbf.Items.Count;
      strErrSit    := '';

      For intIndex := 0 To cmbTipAbf.Items.Count -1 Do
      Begin
        pbProgresso.Position := Succ(intIndex);
        lblInformacao.Caption := 'AGUARDE, VALIDANDO CST (' + cmbTipAbf.Items[intIndex] + ')';
        Application.ProcessMessages;

        strTipAbf    := LeftStr(cmbTipAbf.Items[intIndex], 3);

        If Pos(strTipAbf, 'PEF_PEJ_PER_PES_PSI_PII_') > 0 Then
          strTipAbf := 'ENT_' + strTipAbf
        Else
          strTipAbf := 'SAI_' + strTipAbf;

        If Not fTemCodigoOrigem(strTipAbf) Then
          Continue;

        Filtered := False;
        Filter   := '(ABF_CODSIT_' + strTipAbf + '_O = ' + QuotedStr('') + ') OR ' +
                    '(ABF_CODSIT_' + strTipAbf + '_O IS NULL)';
        Filtered := True;

        While Not Eof Do
        Begin
          strErrSit := strErrSit + IIF(fEmptyStr(strErrSit), Fieldbyname('ABF_ESTADO').AsString, ', ' + Fieldbyname('ABF_ESTADO').AsString);
          Next;
        End;

        If (Not IsEmpty) Then
        Begin
          strErrSit := cmbTipAbf.Items[intIndex] + #13#10 +
            'É necessário preencher a Situação Tributária Origem (' + strErrSit + ')!';

          cmbTipAbf.ItemIndex := intIndex;
          cmbTipAbfChange(nil);
          Break;
        End;

      End;

      Result := fEmptyStr(strErrSit);
    Finally
      Filtered := False;
      Filter   := EmptyStr;
      Filtered := True;
      pnlProgresso.Visible  := False;
      pEnableControls(cdsGrid, prcScroll);
    End;
  End;

end;

procedure TfrmCadAbreviacaoFiscal.InverterSeleo1Click(Sender: TObject);
begin
  inherited;
  pExecutarSelecao(opcInverter);
end;

procedure TfrmCadAbreviacaoFiscal.lblclbCFOPClick(Sender: TObject);
begin
  inherited;
  popCFOP.Popup(Mouse.CursorPos.X + 2, Mouse.CursorPos.Y + 2);
end;

procedure TfrmCadAbreviacaoFiscal.MarcarSomenteCFOPdeVenda1Click(
  Sender: TObject);
begin
  inherited;
  pExecutarSelecao(opcMarcarVenda);
end;

procedure TfrmCadAbreviacaoFiscal.MarcarTodos1Click(Sender: TObject);
begin
  inherited;
  pExecutarSelecao(opcMarcar);
end;

procedure TfrmCadAbreviacaoFiscal.chkDefinirRICMSPRClick(Sender: TObject);
begin
  inherited;
  if chkDefinirRICMSPR.checked then
  Begin
    chkRIcmPR.checked := False;
    if fStrToFloat(edtAliquotaRICMSPR.Text) = 0 then
      edtAliquotaRICMSPR.Text := FloatToStr(CONST_PERCENTUAL_DIFERIMENTO_RICMS);
  End
  Else
  Begin
    edtAliquotaRICMSPR.Clear;
  End;
end;

procedure TfrmCadAbreviacaoFiscal.chkRepAllClick(Sender: TObject);
  Var
    intIndex: Integer;
begin
  inherited;
  If Not chkRepAll.Checked Then
  Begin
    chkLstRepAll.Enabled := False;
    For intIndex := 0 To chkLstRepAll.Items.Count -1 Do
      chkLstRepAll.Checked[intIndex] := False;
  End
  Else
  Begin
    chkRepEst.Checked    := False;
    chkRepTot.Checked    := False;
    chkLstRepAll.Enabled := True;
  End;
end;

procedure TfrmCadAbreviacaoFiscal.chkRepEstClick(Sender: TObject);
begin
  inherited;
  If chkRepEst.Checked Then
  Begin
    chkRepAll.Checked := False;
    chkRepTot.Checked := False;
  End;
end;

procedure TfrmCadAbreviacaoFiscal.chkRepTotClick(Sender: TObject);
  Var
    intIndex: Integer;
begin
  inherited;
  If Not chkRepTot.Checked Then
  Begin
    chkLstRepAll.Enabled := False;
    For intIndex := 0 To chkLstRepAll.Items.Count -1 Do
      chkLstRepAll.Checked[intIndex] := False;
  End
  Else
  Begin
    chkRepEst.Checked    := False;
    chkRepAll.Checked := False;
    chkLstRepAll.Enabled := True;
  End;
end;

procedure TfrmCadAbreviacaoFiscal.chkRIcmPRClick(Sender: TObject);
begin
  inherited;
  if chkRIcmPR.checked then
  Begin
    chkDefinirRICMSPR.checked  := False;
    edtAliquotaRICMSPR.Clear;
  End;

  edtAliquotaRICMSPR.Enabled := chkDefinirRICMSPR.checked;
  lblRICMS.Enabled           := chkDefinirRICMSPR.checked;
end;

procedure TfrmCadAbreviacaoFiscal.cmbTipAbfChange(Sender: TObject);
  Var
    strTipAbf: String;
    intIndex : Integer;
    prcScroll: TprcScroll;

  function fGetStyle: TcxStyle;
  begin
    Result := Nil;
    If strTipAbf = '_ENT_PEJ' Then Result := cxsENT_PEJ;
    If strTipAbf = '_ENT_PER' Then Result := cxsENT_PER;
    If strTipAbf = '_ENT_PEF' Then Result := cxsENT_PEF;
    If strTipAbf = '_ENT_PES' Then Result := cxsENT_PES;
    If strTipAbf = '_ENT_PSI' Then Result := cxsENT_PSI;
    If strTipAbf = '_ENT_PII' Then Result := cxsENT_PII;
    If strTipAbf = '_SAI_NCO' Then Result := cxsSAI_NCO;
    If strTipAbf = '_SAI_CCO' Then Result := cxsSAI_CCO;
    If strTipAbf = '_SAI_CNC' Then Result := cxsSAI_CNC;
    If strTipAbf = '_SAI_SNA' Then Result := cxsSAI_SNA;
    If strTipAbf = '_SAI_CTA' Then Result := cxsSAI_CTA;
    If strTipAbf = '_SAI_PRU' Then Result := cxsSAI_PRU;
    If strTipAbf = '_SAI_IND' Then Result := cxsSAI_IND;
    If strTipAbf = '_SAI_TRS' Then Result := cxsSAI_TRS;
  end;

begin
  inherited;

  Try
    pDisableControls(cdsGrid, prcScroll);

    strTipAbf := AnsiLeftStr(cmbTipAbf.Text,3);

    pSetarComboboxTipoCalculoSt(strTipAbf);

    If Pos(strTipAbf, 'PEF_PEJ_PER_PES_PSI_PII') > 0 Then
      strTipAbf := '_ENT_' + strTipAbf
    Else
      strTipAbf := '_SAI_' + strTipAbf;

    cxgAbrevDBColCodSit.DataBinding.FieldName := 'ABF_CODSIT' + strTipAbf;

    If Assigned(cdsGrid.FindField('ABF_CODSIT' + strTipAbf + '_O')) Then
      cxgAbrevDBColCodSitOrigem.DataBinding.FieldName := 'ABF_CODSIT' + strTipAbf + '_O';

    cxgAbrevDBColBasIcm.DataBinding.FieldName := 'ABF_BASICM' + strTipAbf;
    cxgAbrevDBColAlqIcm.DataBinding.FieldName := 'ABF_ALQICM' + strTipAbf;
    cxgAbrevDBColIcmPrd.DataBinding.FieldName := 'ABF_ICMPRD' + strTipAbf;
    cxgAbrevDBColAlqEfO.DataBinding.FieldName := 'ABF_ALQEFO' + strTipAbf;
    cxgAbrevDBColAlqIED.DataBinding.FieldName := 'ABF_ALQIED' + strTipAbf;
    cxgAbrevDBColAlqFCP.DataBinding.FieldName := 'ABF_ALQFCP' + strTipAbf;
    cxgAbrevDBColBasRet.DataBinding.FieldName := 'ABF_BASRET' + strTipAbf;
    cxgAbrevDBColAlqRet.DataBinding.FieldName := 'ABF_ALQRET' + strTipAbf;
    cxgAbrevDBColAlqRed.DataBinding.FieldName := 'ABF_ALQRED' + strTipAbf;
    cxgAbrevDBColIVA_ST.DataBinding.FieldName := 'ABF_IVA_ST' + strTipAbf;
    cxgAbrevDBColBaseDifalOri.DataBinding.FieldName := 'ABF_BASDOR' + strTipAbf;
    cxgAbrevDBColBaseDifalDes.DataBinding.FieldName := 'ABF_BASDDS' + strTipAbf;

    cxgAbrevDBColCodSit.Styles.Content := fGetStyle;
    cxgAbrevDBColCodSitOrigem.Styles.Content := fGetStyle;
    cxgAbrevDBColBasIcm.Styles.Content := fGetStyle;
    cxgAbrevDBColAlqIcm.Styles.Content := fGetStyle;
    cxgAbrevDBColIcmPrd.Styles.Content := fGetStyle;
    cxgAbrevDBColAlqEfO.Styles.Content := fGetStyle;
    cxgAbrevDBColAlqIED.Styles.Content := fGetStyle;
    cxgAbrevDBColAlqFCP.Styles.Content := fGetStyle;
    cxgAbrevDBColBasRet.Styles.Content := fGetStyle;
    cxgAbrevDBColAlqRet.Styles.Content := fGetStyle;
    cxgAbrevDBColAlqRed.Styles.Content := fGetStyle;
    cxgAbrevDBColIVA_ST.Styles.Content := fGetStyle;
    cxgAbrevDBColBaseDifalOri.Styles.Content := fGetStyle;
    cxgAbrevDBColBaseDifalDes.Styles.Content := fGetStyle;

    cxgAbrevTableView.DataController.Refresh;
    cxgAbfGeralTableView.DataController.Refresh;
    cxgImpPagDBTableView.DataController.Refresh;

    If cdsGrid.RecordCount > 0 Then
      pCarregaAbrevAlteracao
    Else
      pLimpaEdits(False);

    chkRepEst.Checked := False;

    chkLstRepAll.Clear;
    For intIndex := 0 To cmbTipAbf.Items.Count -1 Do
      If cmbTipAbf.ItemIndex <> intIndex Then
        chkLstRepAll.Items.Add(cmbTipAbf.Items[intIndex]);

    pAjustaDareRoraimaEdicao(fTemCodigoOrigem(strTipAbf));

  Finally
    pEnableControls(cdsGrid, prcScroll);
  End;
end;

procedure TfrmCadAbreviacaoFiscal.cmbTipoCalculoSTKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
    Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadAbreviacaoFiscal.cxgAbfGeralENT_PEF_OGetCellHint(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  ACellViewInfo: TcxGridTableDataCellViewInfo; const AMousePos: TPoint;
  var AHintText: TCaption; var AIsHintMultiLine: Boolean;
  var AHintTextRect: TRect);
begin
  inherited;

  AHintText := 'CST que vem na Nota Fiscal do Fornecedor do Produto. Utilizada para cálculo do DARE';
end;

procedure TfrmCadAbreviacaoFiscal.cxgAbrevEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'Tecle ENTER para alterar a abreviacao deste Estado';
end;

procedure TfrmCadAbreviacaoFiscal.cxgAbrevExit(Sender: TObject);
begin
  inherited;
  pnlStatus.Height := 16;
  pnlInfo.Caption := '';
  HintControler.HideHint;
end;

procedure TfrmCadAbreviacaoFiscal.cxgAbrevTableViewDblClick(Sender: TObject);
begin
  inherited;
  If cdsGrid.RecordCount > 0 Then
  Begin
    blnPesquisa := True;
    If Not fSetaIndiceParaAlterarGeral Then
      pCarregaAbrevAlteracao;
  End;
end;

procedure TfrmCadAbreviacaoFiscal.cxGridDBBandedColumn3PropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  If fEmptyStr(VarToStr(DisplayValue)) Then
  Begin
    DisplayValue := '0';
    Error := False;
  End
  Else If (fStrToFloat(VarToStr(DisplayValue)) < 0)   Or
          (fStrToFloat(VarToStr(DisplayValue)) > 100) Then
  Begin
    fMensagem('ATENÇÃO!', 'Percentual de "Imposto Pago" inválido!', ['&Ok']);
    DisplayValue := '0';    
    Error := False;
  End;

end;

procedure TfrmCadAbreviacaoFiscal.DesmarcarTodos1Click(Sender: TObject);
begin
  inherited;
  pExecutarSelecao(opcDesmarcar);
end;

procedure TfrmCadAbreviacaoFiscal.pHabilitaFormaCalculoST;
var strTipAbf: String;
Begin
  strTipAbf := AnsiLeftStr(cmbTipAbf.Text,3);
  cmbTipoCalculoST.Enabled := (grpST.Enabled And (fCfgSis('CAL_ST', varBoolean) And
                                                  ((strTipAbf = 'CCO') Or (strTipAbf = 'PRU'))));
End;

end.






