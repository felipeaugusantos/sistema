{***************************}
{* qryConFor -> CADFOR     *}
{* qryConEmp -> CADEMP     *}
{* qryConPor -> CADPOR     *}
{************************JB*}
unit untBaixaCtaPagar;

interface

uses
  Windows, Classes, Controls, StdCtrls, untPaiSimples, Grids, DBGridCitel, DBGrids, Mask,
  MaskEditFocus, EditFocus, ComCtrls, Buttons, ExtCtrls, DB, Menus, Uni, frxClass,
  frxDMPExport, frxDBSet, AppEvnts, UniClientDataSet, untFuncoesSimples,
  CurrencyEditFocus, untReciboCtp, untFastPrintEditor, cxStyles, Math,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, BitBtnLockedIncrem, cxLookAndFeels,
  cxLookAndFeelPainters, untTypesSistema, cxNavigator, frxExportCSVTestabilidade, cxProgressBar,
  Forms, System.Generics.Collections, untTMovBan, untTMovBanRepository,
  cxContainer, cxTextEdit, cxCurrencyEdit,Generics.Defaults,
  dxCore, cxDateUtils, cxMaskEdit, cxDropDownEdit, cxCalendar,
  untTCadPag, untTCadPagRepository, MemoFocus, untAltValor,
  cxDataControllerConditionalFormattingRulesManagerDialog, untLiberacao, untTLock, untBaixaCtpBusca,
  untFrameCentroCustoEditFocus, untFuncoesRel, untFuncoesRel2, untRcxTResumoDeCaixa,
  untFramePlanoDeContasMaskEdit, untMsgLiberacao, untLogLibCtp, untTConfiguracaoGrids,
  untReciboCtpMeiaFolha,  Winapi.ShellAPI;


type

  TSaidaImpressao = (tsiVideo, tsiImpressao);

  TCtpInfo = record
    strCodFor: String;
    strHist01: String;
    strHist02: String;
  End;

  TModal = Record
    fltDin: Double;
    fltCqV: Double;
    fltOrd: Double;
    fltRep: Double;
    fltTot: Double;
  End;

  TDescontoGeral = Record
    fltValDes: Double;
    fltValBxa: Double;
    blnConfir: Boolean;
    strTipDes: String
  End;

  TfrmBaixaCtaPagar = class(TfrmPaiSimples)
    pnlAux1: TPanel;
    pnlBotoesBaixa: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    pnlTotais: TPanel;
    Label7: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label8: TLabel;
    Label13: TLabel;
    edtCodCtaBai: TEditFocus;
    edtDesCtaBai: TEditFocus;
    edtDtaCad: TEditFocus;
    edtSerie: TEditFocus;
    edtCodEveBai: TEditFocus;
    edtDesEveBai: TEditFocus;
    pnlInformativos: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    edtJurosTotal: TEditFocus;
    edtDescontoTotal: TEditFocus;
    lblCodEmp: TLabel;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    edtCodVel: TEditFocus;
    Label20: TLabel;
    frxReciboM: TfrxReport;
    frxReciboJ: TfrxReport;
    frxDataset: TfrxDBDataset;
    frxGen: TfrxUserDataSet;
    chkLimFil: TCheckBox;
    lblTotVendor: TLabel;
    edtTotVendor: TEditFocus;
    edtVendorTotal: TEditFocus;
    lblVendorTotal: TLabel;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    Label24: TLabel;
    dbgDuplicatasView: TcxGridDBTableView;
    dbgDuplicatasLevel1: TcxGridLevel;
    dbgDuplicatas: TcxGrid;
    dbgDuplicatasCTP_NUMDUP: TcxGridDBColumn;
    dbgDuplicatasCTP_CODEMP: TcxGridDBColumn;
    dbgDuplicatasCTP_CODFOR: TcxGridDBColumn;
    dbgDuplicatasCTP_DTAVEN: TcxGridDBColumn;
    dbgDuplicatasCTP_USACHQ: TcxGridDBColumn;
    dbgDuplicatasCTP_DESSUJ: TcxGridDBColumn;
    dbgDuplicatasCTP_JURSUJ: TcxGridDBColumn;
    dbgDuplicatasCTP_MULSUJ: TcxGridDBColumn;
    dbgDuplicatasCTP_VENDOR: TcxGridDBColumn;
    dbgDuplicatasTOTDUP: TcxGridDBColumn;
    dbgDuplicatasCTP_MARDES: TcxGridDBColumn;
    dbgDuplicatasFOR_NOMFOR: TcxGridDBColumn;
    btnIniBus: TBitBtnLocked;
    btnLocProx: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnManutencao: TBitBtnLocked;
    btnMarcarTodas: TBitBtnLocked;
    BtnSelecionadas: TBitBtnLocked;
    btnBordero: TBitBtnLocked;
    dbgDuplicatasCTP_VEIOBO: TcxGridDBColumn;
    rdgVeioBo: TRadioGroup;
    shpMultSel: TShape;
    dbgDuplicatasCTP_CODPOR: TcxGridDBColumn;
    btnDesmarcarTodas: TBitBtnLocked;
    rdgLiberados: TRadioGroup;
    edtHistor: TMemoFocus;
    btnAlterarValor: TBitBtnLocked;
    frxDatasetChqEmi: TfrxDBDataset;
    dbgDuplicatasCTP_DTACAD: TcxGridDBColumn;
    pnlCTREmAberto: TPanel;
    Label27: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    edtEmAbertoVenc: TEditFocus;
    edtEmAbertoCred: TEditFocus;
    edtEmAbertoAVenc: TEditFocus;
    edtEmAbertoTotal: TEditFocus;
    btnSairBaixa: TBitBtnLocked;
    btnDescontoGeral: TBitBtnLocked;
    FlwPnlBotoesBaixa: TFlowPanel;
    Panel1: TPanel;
    dbgDuplicatasViewCTP_OUTENT: TcxGridDBColumn;
    Label33: TLabel;
    edtOutrasEntidades: TEditFocus;
    edtOutEnt: TEditFocus;
    dbgDuplicatasCTP_VEIONF: TcxGridDBColumn;
    dbgDuplicatasPREVISAO: TcxGridDBColumn;
    fraCentroCusto: TfraCentroCustoEditFocus;
    btnDupAgrup: TBitBtnLocked;
    dbgDuplicatasCTP_SERIE_AG: TcxGridDBColumn;
    dbgDuplicatasCTP_NUMDUP_AG: TcxGridDBColumn;
    dbgDuplicatasCTP_CODEMP_AG: TcxGridDBColumn;
    dbgDuplicatasCTP_CODFOR_AG: TcxGridDBColumn;
    dbgDuplicatasCTP_C_G_C: TcxGridDBColumn;
    pnlCabecalho2: TPanel;
    Label2: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    Label11: TLabel;
    Label26: TLabel;
    Label25: TLabel;
    edtVlrIni: TCurrencyEditFocus;
    edtVlrFin: TCurrencyEditFocus;
    btnConsultar: TBitBtnLocked;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    mskDtaCadIni: TcxDateEdit;
    mskDtaCadFin: TcxDateEdit;
    pnlProjeto: TPanel;
    lblProjeto: TLabel;
    edtDesPrj: TEditFocus;
    edtCodPrj: TEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    dbgDuplicatasCTP_VALANT: TcxGridDBColumn;
    chkFiltrarFiliais: TCheckBox;
    dbgDuplicatasCTA_DESCTA: TcxGridDBColumn;
    gpbGeral: TGroupBox;
    Label6: TLabel;
    edtQtdDuplicatas: TEditFocus;
    Label21: TLabel;
    edtValorTotal: TEditFocus;
    Label5: TLabel;
    edtTotDesconto: TEditFocus;
    Label18: TLabel;
    edtTotJuros: TEditFocus;
    gpbSelecionadas: TGroupBox;
    Label9: TLabel;
    edtQtdSelecionadas: TEditFocus;
    Label23: TLabel;
    edtTotalPago: TEditFocus;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    edtQtdDulSel: TEditFocus;
    Label22: TLabel;
    edtTotVlrOrg: TEditFocus;
    Label28: TLabel;
    edtTotVlrCorr: TEditFocus;
    edtMultaTotal: TEditFocus;
    lblMulSujTotal: TLabel;
    edtTotMulta: TEditFocus;
    Label10: TLabel;
    dbgDuplicatasLIBERADO: TcxGridDBColumn;
    btnConfigurarGrid: TBitBtnLocked;
    dbgDuplicatasANTECIPACAO: TcxGridDBColumn;
    Label35: TLabel;
    edtCompet: TEditFocus;
    Label4: TLabel;
    edtPreVis: TEditFocus;
    procedure btnSairBaixaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnIniBusClick(Sender: TObject);
    procedure btnLocProxClick(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure btnMarcarTodasClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure pImprimeBordero(blnNaoBai: Boolean = False; strCodBco: String = ''; strNumAge: String = ''; strConCor: String = ''; strNumChq: String = ''; strCodPor: String = ''; fltValChq: Double = 0);
    procedure BtnSelecionadasClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure frxGenGetValue(const VarName: String; var Value: Variant);
    function frxReciboMUserFunction(const MethodName: String;
      var Params: Variant): Variant;
    procedure FormDestroy(Sender: TObject);
    procedure btnBorderoClick(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure dbgDuplicatasViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgDuplicatasViewDblClick(Sender: TObject);
    procedure dbgDuplicatasViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnDesmarcarTodasClick(Sender: TObject);
    procedure btnAlterarValorClick(Sender: TObject);
    procedure btnManutencaoClick(Sender: TObject);
    procedure btnDescontoGeralClick(Sender: TObject);
    procedure fraCentroCustoedtCodEveExit(Sender: TObject);
    procedure btnDupAgrupClick(Sender: TObject);
    procedure cdsCtaPagFor_C_G_C_GetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure edtCodPrjExit(Sender: TObject);
    procedure edtCodPrjKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasMskCodCtaExit(Sender: TObject);
    procedure chkFiltrarFiliaisExit(Sender: TObject);
    procedure dbgDuplicatasViewDataControllerSummaryAfterSummary(
      ASender: TcxDataSummary);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure dbgDuplicatasViewMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pAjustaCamposProjeto;
    procedure btnConfigurarGridClick(Sender: TObject);
  private
    { Private declarations }
    frmBaixaCtpBusca : TfrmBaixaCtpBusca;
    stlSeqCon: TStringList;
    qryConEmp: TUniQuery;
    qryConFor: TUniQuery;
    qryCadPag: TUniQuery;
    qryConCta: TUniQuery;
    qryConPor: TUniQuery;
    cdsCtaPag: TUniClientDataSet;
    cdsGenCtp: TUniClientDataSet;
    dtsCtaPag: TDataSource;
    blnResult: Boolean;
    cdsClone: TUniClientDataSet;
    qryTmp   : TUniQuery;
    strAceCtp: String;
    strTipBai: String;
    strTipDes: String;
    fltValPag: Double;
    dtaDtaPag: TDateTime;
    fltValDes: Double;
    fltValJur: Double;
    fltValMul: Double;
    fltVendor: Double;
    fltOutEnt: Double;

    fltDinRec: Double;
    fltChqVis: Double;
    fltOrdPag: Double;
    fltRepChq: Double;

    strPorBai: String;
    strCtaBai: String;
    strDtaLan: String;
    strDocBai: String;
    strHist01: String;
    strHist02: String;
    strCodBco: String;
    strNumAge: String;
    strNumChq: String;
    strDtaBom: String;
    strDtaEmi: String;
    strFavore: String;
    strConCor: String;

    strCodEmpAG : String;
    strNumAgrAG : String;
    strCodForAG : String;

    dicChqEmi: TDictionary<String,TChequeEmitido>;
    dicChqRep: TDictionary<String,TChequeRepassado>;

    stlCodFor: TStringList;

    strValorFiltro : String;
    strCampoFiltro : String;

    strNomFil  : String;
    strTipImp  : String;
    intQtdReg  : Integer;

    editorFast : TFastPrintFileEditor;
    FArquivoBorderoPDF: String;
    reciboCtp  : TReciboCtp;
    reciboCtpMeiaFolha : TReciboCtpMeiaFolha;

    arrEmp: TConsultasArray;
    arrFornec: TConsultasArray;
    arrEvento: TConsultasArray;
    arrPortador: TConsultasArray;
    arrCentCusto: TConsultasArray;
    arrPrj     : TConsultasArray;

    strEmp: String;
    strFornec: String;
    strEvento: String;
    strPortador: String;
    strCentCusto: String;
    strPortadorBaixaZeradaCTP: String;
    FUtilizaLiberacaoPendenteBaixa : Boolean;

    blnGravaMovBanSemDesmembrar : Boolean;

    blnBaiChqAna,
    blnBaixaZeradaCTP : Boolean;

    dtaChqMovBan :TDateTime;

    lstFornecedor:TStringList;
    recDescontoGeral: TDescontoGeral;

    intOpcao: Integer;
    fltValInf: Double;

    objLiberacao  : TLiberacao;
    objLock: TLock;

    FImprimeBordero,
    FExibeHistoricoBordero,
    FExibeDetalhamentoPagamentoBordero : Boolean;
    FSaidaDaImpressa : TSaidaImpressao;

    blnUsaLiberacaoDePrevisao: Boolean;
    strMarcacaoLog: String;

    blnMarcarTodas: Boolean;

    objLogLibCtp: TLogLibCtp;
    FControlFoco: TWinControl;
    strAutoIncremTodas: String;

    blnDuploClickGrid : Boolean;

    FConfiguracaoGrid: TConfiguracaoGrids;

    blnUsaTravaMsgPagtoAntecipado: Boolean;

    procedure pLiberaDupsMarcadas;

    procedure pqryCadPagCTP_DTACADSetText(Sender: TField; const Text: String);
    procedure pRetDupSelecionadas(Var intDupCx: Integer;  Var fltTotCx: Double);
    procedure pCarregaFornecedor;
    procedure pCarregaEventos;
    procedure pCarregaCentroCusto;
    procedure pCarregaPortador;
    procedure pSelecionaDuplicata(pSelComCtrlMouse : Boolean = false);
    procedure pMarcaDuplicata(blnMarcar: Boolean);
    procedure pMarcaFornecedor(chave, marcaDesmarca:String);
    procedure pLimpaEdits;
    procedure pLimpaEditsDuplicata;
    procedure pGravaNumChqSequencialPortador(strCodPor, strCodEmp, strNumAge, strCodBco, strNumCco, strNumChq: String);
    procedure pCarregaEmpresa;
    procedure pLimpaCTRemAberto;
    procedure pChamarManutencaoCtp;

    function  fBaixaDuplicatas(blnNaoBai: Boolean = False): Boolean;
    function  fRetornaFornecedor: String;
    function  fRetornaEmpresa: String;

    function  fImprimeReciboLayout: Boolean;
    function  fFormataFoneInterna(strFone: String): String;
    function RetornaDatasetCamposCadPag(AAutoIncremCadPag: String): TUniClientDataSet;
    function fRetListFormasPagto(out dinheiro,
                                 chequeVista,
                                 chequeRepasse,
                                 deposito: Double;
                                 ADatasetCadPag: TDataset): String;
    function fRetListPortadores(blnAddInfoCheques: Boolean;
                                ADatasetCadPag: TDataset): String;
    function fRetDataEmissaoCheque(ADatasetBanChq: TDataset): String;

    function  fVerificaDireitoBaixa: Boolean;
    function  fGetEmpAceCtp: String;
    procedure pMarcarDuplicataTela;
    function  fDesmarcarTodos(pgbProgresso: TcxProgressBar): Boolean;
    function  fMarcarTodos(pgbProgresso: TcxProgressBar): Boolean;
    procedure pConcluiBusca;
    procedure pLocalizaProximaDup;
    function  fAcertaRateioPag(cdsRateio: TUniClientDataSet): Boolean;
    function  fCriaCdsRateioPag(AOwner: TComponent): TUniClientDataSet;
    function  fRateioPag(fltTotGer, fltTotDup, fltValPag: Double): Double;
    function  fVerificaDupBaixada(strNumDup,
                                 strParcel,
                                 strSerie_,
                                 strCodEmp,
                                 strCodFor: String;
                                 intSeqBai: Integer;
                                 fltTotDup: Double): Boolean;
    procedure pGravaRateioPag(cdsRateio: TUniClientDataSet; intSeqBai: Integer;
      strNumDup, strParcel, strCodEmp, strSerie_, strCodFor: String; fltValPag,
      fltValDin, fltValCqV, fltValOrd, fltRepChq: Double);
    function  fAcertaRateioChqEmi(fltChqEmi: Double; cdsRateio: TUniClientDataSet): Boolean;
    procedure pProcessaCloneCtaPag(var cdsClone: TUniClientDataSet);
    function  fRetornaFornecedorUnico: String;
    function fVerificacoesParaBaixa(pgbProgresso: TcxProgressBar): Boolean;
    function fDuplicatasJaUtilizadasPorOutrosUsuarios: Boolean;
    function fVerificaDuplicatasExcluidas : Boolean;
    function  fCriaClientCheque(strCodBco, strNumAge, strNumChq, strFavore,strDtaEmi,strConCor : String; fltValChq :Double):TUniClientDataSet;
    procedure GravaLogCtp(strNumeroDup, strParcela: String;
                          intSeqBai: Integer;
                          strCodEmp, strCodFor, strSerie_, strDescricaoLog: String;
                          ADataLiberacao: TDateTime = 0);
    procedure pDestravaCheques;
    function fValidaValorBaixa(const fltValor:Double): Boolean;
    procedure pGravaBanChq(strCodBco, strCodEmp, strConCor, strNomEmi, strNumAge, strNumChq: String; fltValChq: Double; strSeqLan: String);
    procedure pAplicaDescontoGeral;
    procedure pStepStatusSelecao(pgbStatus: TcxProgressBar);
    function fLiberaBaixaContasPagarResumoCaixa(cdsSelecionadas : TUniClientDataSet) : Boolean;
    procedure pHabilitaFiltroFiliais;
    procedure pExibeTotais;
    function ExisteDuplicatasSelecionadasNaoExibidasNoGrid: Boolean;

    function RetornaFiltroDoPlanoDeContas(ATexto: String;
                                          AArrayPesquisa: TConsultasArray): String;
  protected
    intSeqCon: Integer;

    procedure pAtualizaTemporaria;
    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);
    procedure pCalculaTotalDuplicatas(edtDesconto, edtJuros, edtMulta, edtTotal, edtQuant, edtVendor, edtOutrasEntidades: TEditFocus; blnFiltrar: Boolean);
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fAtualizaPorBai: Boolean;
    function fVerificaChqExiste(strCodBco, strNumAge, strConCor, strNumChq: String): Boolean;
    function fOrdenaDictionaryKey(dictionary: TDictionary<String, TChequeEmitido>): TArray<String>;
    function fComparaKey(const L, R: String): Integer;
    function fAcertaAbatimentoPag(cdsAbatimento: TUniClientDataSet): Boolean;
    function fExisteCTRPag(strAutoIncrem: String): Boolean;
    procedure pVerificaCTAReceber(strCodFor, strCodEmp : string);
    procedure pUtilizaRotinaProjeto;
  public
    { Public declarations }
    blnResumoCaixa: Boolean;
    strAutIncManCtp: String;
    strOpeCaixa: String;
    recUltDupBaixada : TUltDupBaixada;
    strChamada: String;
    fornecedorDuplicatas:String;

    fltValorBaixa: Double;
    strCodPorFix: String;
    dteDtaPagFix: TDateTime;
    arrSeqLan: TStringArray;

    blnCarregaBaixa: Boolean;

    strCodigoCaixa  : String;
    objResumoDeCaixa: TResumoDeCaixa;

    procedure pImprimeRecibo(cdsGenCtaPag: TUniClientDataSet; frmGen: TForm); //Overload;
    function  fGetLstFornecedor:TStringList;
    function fVerificaDupChqEmi(strCodFor, strNumDup, strParcel, strCodEmp, strSerie: String) : Boolean;
  end;


implementation

uses SysUtils, Variants, Graphics, StrUtils, untFuncoes, UniDataSetProvider,
  untPesqAux, untConsultas, untBaixaDigValores, untBaixaSintetica,
  untFuncoesGenerica, untBaixaCtpAnalitica, untPai,
  untCtpFormasPagamento, untQckCtpBordero, untConsDuplicSelec, untCnfBoleto,
  untConstantes, untCtpDigData, untFuncoesConsulta, untQckCopiaCheque, untCadChq,
  untMovBan, untCadPag, untCfgRel, untCadRcxx, untDigValor, untFuncFat,
  untGravando, untTCadChqRepository,
  untTChqEmi, untTChqEmiRepository, untObjectManager, untTBanCtpRepository,
  untLogBan, untTBanChqRepository, untEnviaImpCheque, untLogCtp, untTBanChq,
  untCadCtaPagar, untBaixaDescGeral, untConfiguracaoGrids;

{$R *.dfm}

{ TfrmBaixaCtaPagar }

procedure TfrmBaixaCtaPagar.pImprimeBordero(blnNaoBai: Boolean = False; strCodBco: String = ''; strNumAge: String = ''; strConCor: String = ''; strNumChq: String = ''; strCodPor: String = ''; fltValChq: Double = 0);
  Var
    frmQckCtpBordero : TfrmQckCtpBordero;
begin
  Try
    pCriarFormularios(TfrmQckCtpBordero, frmQckCtpBordero);
    If blnNaoBai Then
      frmQckCtpBordero.frxReport.FindObject('memoDataBaixa').Visible := False
    Else
      frmQckCtpBordero.frxReport.FindObject('memoDataBaixa').Visible := True;

    frmQckCtpBordero.strNumChq := strNumChq;
    frmQckCtpBordero.strCodBco := strCodBco;
    frmQckCtpBordero.strNumAge := strNumAge;
    frmQckCtpBordero.strConCor := strConCor;
    frmQckCtpBordero.strCodPor := strCodPor;
    frmQckCtpBordero.fltValChq := fltValChq;
    frmQckCtpBordero.strNomPor := fRetNomPortador(strCodPor);
    frmQckCtpBordero.strDtaBom := strDtaBom;
    frmQckCtpBordero.strDtaEmi := strDtaEmi;

      {************************************}
      {* LINHAS COMENTADAS PARA FUNCIONAR *}
      {* TAMBÉM COM CTP_AS = 'A'          *}
      {********08/03/2018**Req. 93054**WS**}
//    blnImpDetalhePagto := False;
//    if fCfgSis('CTP_AS') = 'S' then

    If FSaidaDaImpressa = tsiVideo Then
      frmQckCtpBordero.pImprimeBordero(stlSeqCon, 'V', FExibeHistoricoBordero, False, FExibeDetalhamentoPagamentoBordero, False, blnNaoBai, FArquivoBorderoPDF)
    Else
      frmQckCtpBordero.pImprimeBordero(stlSeqCon, 'I', FExibeHistoricoBordero, False, FExibeDetalhamentoPagamentoBordero, False, blnNaoBai, FArquivoBorderoPDF);

    pFreeAndNil(frmQckCtpBordero);
  Finally

  End;
end;

function TfrmBaixaCtaPagar.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O CÓDIGO DO FORNECEDOR         *}
    {**************************************MV*}

    If (Sender = edtCodFor) Then
    Begin
      If (Not fEmptyStr(edtCodFor.Text)) Then
      Begin

        If edtCodFor.Text <> '00000000' Then
           pCarregaFornecedor;

        If fEmptyStr(edtNomFor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse fornecedor não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
        edtNomFor.Clear;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO EVENTO             *}
    {**************************************LB*}
    Else If (Sender = fraCentroCusto.edtCodEve) Then
    Begin
      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin

        If fraCentroCusto.edtCodEve.Text <> '00000' Then
           pCarregaEventos;

        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (fRetTipoEvento(fraCentroCusto.edtCodEve.Text)='R') Then
        Begin
          fMensagem('ATENÇÃO', 'Esse Centro de Custos pode ser aplicado somente às contas a receber!',['&OK']);
          Result := False;
        End;
      End
      Else
      Begin
        fraCentroCusto.edtDesEve.Clear;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin

      If fEmptyStr(edtCodEmp.Text) Then
        edtNomEmp.Clear
      Else
      Begin

        If edtCodEmp.Text <> '000' Then
           pCarregaEmpresa;

        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If (Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0) And (edtNomEmp.Text <> '+1') Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a esta empresa!', ['&Ok']);
          Result := False;
        End
        Else If (Pos(LeftStr(edtCodEmp.Text,3), strAceCtp) <= 0) And (edtNomEmp.Text <> '+1') Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão no Baixa contas a pagar desta empresa!', ['&Ok']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = edtCodPrj) And pnlProjeto.Visible  Then
    Begin
      If Not fEmptyStr(edtCodPrj.Text) Then
      Begin
        If (edtCodPrj.Text <> '000000') Then
          edtDesPrj.Text := fRetNomeProjeto(edtCodPrj.Text);

        If fEmptyStr(edtDesPrj.Text) Then
        Begin
          fMensagem('', 'Projeto não encontrado !', ['&Ok']);
          Result := False;
          edtDesPrj.Clear;
        End;
      End
      Else
        edtDesPrj.Clear;
    End

    {*****************************************}
    {* VALIDA AS DATAS INICIAIS              *}
    {**************************************MV*}
    Else If (Sender = mskDtaIni) Then
    Begin
      if strCodPorFix = '' then
         mskDtaFin.Clear;
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        mskDtaFin.Enabled := False;
      End
      Else
      Begin
        mskDtaFin.Enabled := True;
      End;
    End
    Else If (Sender = MskDtaCadIni) Then
    Begin
      if strCodPorFix = '' then
         mskDtaCadFin.Clear;
      If fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) Then
      Begin
        mskDtaCadFin.Enabled:= False;
      End
      Else
      Begin
        mskDtaCadFin.Enabled:= True;
      End
    End


    {*****************************************}
    {* VALIDA AS DATAS FINAIS                *}
    {**************************************MV*}
    Else If (Sender = mskDtaFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result := False;
        End;
      End;

    End
    Else if (Sender = mskDtaCadFin) Then
    Begin

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaCadFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final de cadastro deve ser preenchida!', ['&O k']);
          Result:=False;
        End
        Else If Not fValidaPeriodo(mskDtaCadIni.Text, mskDtaCadFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final de cadastro deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result:=False;
        End
      End;
    End
    Else If (Sender = edtVlrIni) Then
    Begin

      edtVlrFin.Value := 0;

    End
    Else If (Sender = edtVlrFin) Then
    Begin

      If (edtVlrFin.Value = 0) And (edtVlrIni.Value <> 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor Final deve ser informado!', ['&O k']);
        Result := False;
      End
      Else If (edtVlrFin.Value < edtVlrIni.Value) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor Final deve ser maior ou igual ao Valor Inicial!', ['&O k']);
        Result := False;
      End
      Else If (edtCodEmp.Text <> '000') And (edtNomEmp.Text <> '+1') And (Not fEmptyStr(edtCodEmp.Text))
        And (not (Pos(LeftStr(edtCodEmp.Text,3), strAceCtp) > 0)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a esta empresa!', ['&Ok']);
        Result := False;
      End;
    End
    {***************************************}
    {* VALIDA CENTRO DE CUSTO              *}
    {************************************JU*}
    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text)) Then
      Begin

        If fraPlanoDeContas.MskCodCta.Text = '0000000' Then
          Exit;

        pCarregaCentroCusto;

        if fEmptyStr(fraPlanoDeContas.edtDesCta.Text) Then
        Begin
           fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
           Result := False;
        End
        else if(fCampoTabela('CTA_PERPAG', 'CADCTA', ['CTA_CODCTA'], [fraPlanoDeContas.MskCodCta.Text], False) <> 'S') then
        Begin
           fMensagem('ATENÇÃO!', 'Esse Plano de Contas não é permitido na baixa contas a pagar!', ['&O k']);
           Result := False;
        End;
      End
      Else
      Begin
        fraPlanoDeContas.edtDesCta.Clear;
      End;
    End
    {**************************************}
    {* VALIDA O CÓDIGO DO PORTADOR        *}
    {***********************************JU*}
    Else If (Sender = edtCodPor) Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) Then
      Begin

        If edtCodPor.Text <> '00000' Then
           pCarregaPortador;

       if fEmptyStr(EdtDesPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          {*REQ*145940**********RP*}
          If (High(arrEmp) > 0) Then
          Begin
            If Not fEmpresaTemAcessoPortador(edtCodPor.Text,arrEmp) Then
              Result := False;
          End
          Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text, edtCodEmp.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End

          Else If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Você não tem permissão para utilizar este portador!', ['&O k']);
              Result := False;
            End;
          End;

        End;

      End
      Else
        edtDesPor.Clear;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmBaixaCtaPagar.fVerificaChqExiste(strCodBco, strNumAge, strConCor, strNumChq: String): Boolean;
  Var
    qryTmpChq: TUniQuery;
    strSQL   : String;
begin

  Result := False;

  qryTmpChq := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + ' SELECT COUNT(*) AS QTDREG  ';
  strSQL := strSQL + ' FROM                       ';
  strSQL := strSQL + '   CHQEMI                   ';
  strSQL := strSQL + ' WHERE                      ';
  strSQL := strSQL + '   EMI_CODBCO = :CODBCO     ';
  strSQL := strSQL + '   AND EMI_NUMAGE = :NUMAGE ';
  strSQL := strSQL + '   AND EMI_CONCOR = :CONCOR ';
  strSQL := strSQL + '   AND EMI_NUMCHQ = :NUMCHQ ';

  With qryTmpChq Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODBCO').AsString := strCodBco;
    ParamByName('NUMAGE').AsString := strNumAge;
    ParamByName('CONCOR').AsString := strConCor;
    ParamByName('NUMCHQ').AsString := strNumChq;
    Open;
  End;

  If qryTmpChq.IsEmpty Then
  Begin
    fMensagem('', 'Já existe um cheque emitido com estes dados Banco: ' + strCodBco +
                  ' Agência: ' + strNumAge + ' Conta: ' + strConCor + ' Cheque: ' + strNumChq + '!',
                  ['&O k']);
    Result := True;
  End;

end;

function TfrmBaixaCtaPagar.fVerificacoesParaBaixa(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := True;
  cdsClone.First;
  qryTmp := fCriaQuery;
  pgbProgresso.Position := 0;
  pgbProgresso.Properties.Max := cdsClone.RecordCount;
  pCalculaTotalDuplicatas(edtDescontoTotal, edtJurosTotal, edtMultaTotal, edtTotalPago, edtQtdSelecionadas, edtVendorTotal, edtOutEnt, True);

  While Not cdsClone.Eof Do
  Begin

    If (cdsClone.FieldByName('HRAFIL').AsDateTime < fRetornaUltimaAlteracaoDuplicataCTP(cdsClone.FieldByName('NRODUP').AsString,
                                                                                        cdsClone.FieldByName('PARDUP').AsString,
                                                                                        cdsClone.FieldByName('CTP_SERIE_').AsString,
                                                                                        cdsClone.FieldByName('CTP_CODFOR').AsString,
                                                                                        cdsClone.FieldByName('CTP_CODEMP').AsString)) Then
    Begin
      pMensagemOk('A duplicata '+cdsClone.FieldByName('CTP_NUMDUP').AsString+' sofreu uma alteração posterior a pesquisa realizada.' + #13 +
                  'Para manter a integridade das informações recarregue a consulta!');
      FreeAndNil(cdsClone);
      Result:=False;
      Break;
    End;

    If fDuplicatasJaUtilizadasPorOutrosUsuarios Then
    Begin
      fMensagem('ATENÇÃO!', 'Existem duplicatas que estão sendo baixadas e as mesmas foram utilizadas por outro usuário. Realize a pesquisa novamente para efetuar as baixas corretamente!', ['&OK']);
      FreeAndNil(cdsClone);
      Result:= False;
      Break;
    End;
    {********************************************************************}
    {* REALIZADO ESSE TRATAMENTO DEVIDO AO DESAGRUPAMENTO DE DUPLICATAS *}
    {********************************************************************}
    If Not fVerificaDuplicatasExcluidas Then
    Begin
      fMensagem('ATENÇÃO!', 'Existem duplicatas que foram excluídas por outro usuário. Realize a pesquisa novamente para efetuar as baixas corretamente!', ['&OK']);
      FreeAndNil(cdsClone);
      Result:=False;
      Break;
    End;

    cdsClone.Next;
    pStepStatusSelecao(pgbProgresso);
  End;

  {****************************************************************************************}
  {*VERIFICAR PERMISSÃO PARA BAIXA DO CONTAS A PAGAR VINDO DO RESUMO DE CAIXA (DIRCXCTPRC)*}
  {***************************************************************************KM-REQ 188418}
  if fLiberaBaixaContasPagarResumoCaixa(cdsClone) = False then
  begin
    FreeAndNil(cdsClone);
    Result:=False;
  end;

  blnResult := Result;
  pFreeAndNil(qryTmp);
end;

function TfrmBaixaCtaPagar.fVerificaDireitoBaixa: Boolean;
begin
  Result:= True;
  if not (Pos(LeftStr(cdsCtaPag.FieldByName('CTP_CODEMP').AsString,3), strAceCtp) > 0) then
  begin
    Result:= False;
  End;
end;

function TfrmBaixaCtaPagar.fVerificaDupBaixada(strNumDup, strParcel, strSerie_,
  strCodEmp, strCodFor: String; intSeqBai: Integer; fltTotDup: Double): Boolean;
Var
  strSQL: String;
  qryGen: TUniQuery;
Begin
  Try
   qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   CTP_DTAPAG, ';
    strSQL := strSQL + '  (CTP_VALDUP + IFNULL(CTP_JURSUJ,0) + IFNULL(CTP_MULSUJ,0) + IFNULL(CTP_VENDOR,0) + IFNULL(CTP_OUTENT,0)) -IFNULL(CTP_DESSUJ,0) AS VALORTOTAL ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADPAG ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CTP_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '   CTP_PARCEL = :PARCEL AND ';

    IF fEmptyStr(strSerie_) THEN
      strSQL := strSQL + '   (CTP_SERIE_ = :SERIE_ OR  CTP_SERIE_ IS NULL) AND '
    ELSE
      strSQL := strSQL + '   CTP_SERIE_ = :SERIE_ AND ';

    strSQL := strSQL + '   CTP_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   CTP_CODFOR = :CODFOR AND ';
    strSQL := strSQL + '   CTP_SEQBAI = :SEQBAI ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString  := strNumDup;
      ParamByName('PARCEL').AsString  := strParcel;
      ParamByName('SERIE_').AsString  := strSerie_;
      ParamByName('CODEMP').AsString  := strCodEmp;
      ParamByName('CODFOR').AsString  := strCodFor;
      ParamByName('SEQBAI').AsInteger := intSeqBai;
      Open;

      If fEmptyStr(FieldByName('CTP_DTAPAG').AsString) Then
      begin
        If FieldByName('VALORTOTAL').AsFloat <> fltTotDup Then
          Result := True
        Else
          Result := False;
      end
      Else
      begin
        Result := True;
      end;
    End;

  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmBaixaCtaPagar.fVerificaDupChqEmi(strCodFor, strNumDup, strParcel,
  strCodEmp, strSerie: String) : Boolean;
  Var
    qryTmpChq: TUniQuery;
    strSQL   : String;
begin

  Result := False;

  qryTmpChq := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + ' SELECT COUNT(*) AS QTDREG  ';
  strSQL := strSQL + ' FROM                       ';
  strSQL := strSQL + '   CHQEMI                   ';
  strSQL := strSQL + ' WHERE                      ';
  strSQL := strSQL + '   EMI_CODFOR     = :CODFOR ';
  strSQL := strSQL + '   AND EMI_NUMDUP = :NUMDUP ';
  strSQL := strSQL + '   AND EMI_PARCEL = :PARCEL ';
  strSQL := strSQL + '   AND EMI_CODEMP = :CODEMP ';
  strSQL := strSQL + '   AND EMI_SERIE_ = :SERIE ';
  strSQL := strSQL + '   AND EMI_SEQBAI = 0 ';

  With qryTmpChq Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODFOR').AsString := strCodFor;
    ParamByName('NUMDUP').AsString := strNumDup;
    ParamByName('PARCEL').AsString := strParcel;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('SERIE').AsString := strSerie;
    Open;
  End;

  If qryTmpChq.FieldByName('QTDREG').AsInteger > 0 Then
  Begin
    fMensagem('', 'Já existe cheque emitido com estes dados Fornecedor: ' + strCodFor +
                  ' Duplicata: ' + strNumDup + ' Parcela: ' + strParcel +
                  ' Empresa: ' + strCodEmp + ' Série: ' + strSerie + '!',
                  ['&O k']);
    Result := True;
  End;

end;

function TfrmBaixaCtaPagar.fVerificaDuplicatasExcluidas: Boolean;
  Var
    strSQL   : String;
Begin
  Result := True;
  With cdsClone Do
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   COUNT(*) AS QTD ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + FieldByName('TABELA').AsString;
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   AUTOINCREM = :AUTINC';

    qryTmp.Params.Clear;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add(strSQL);
    qryTmp.ParamByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
    qryTmp.Open;

    If Not qryTmp.IsEmpty Then
    Begin
      If qryTmp.FieldByName('QTD').AsInteger = 0 Then
      begin
        Result := False;
      end;
    End
    Else
    begin
      Result := False;
    end;
  End;
End;

function TfrmBaixaCtaPagar.fValidaValorBaixa(const fltValor:Double): Boolean;
var
  fltValSel: Double;
begin
  Result := True;
  if (fltValorBaixa > 0) and (strCodPorFix <> '') then
  begin
    fltValSel := 0;
    if edtTotalPago.Text <> '' then
       fltValSel := fStrToFloat(edtTotalPago.Text);

    fltValSel := fltValSel + fltValor;
    if  RoundTo(fltValSel, -2) > RoundTo(fltValorBaixa, -2) then
      Result := False;
  end;
end;

procedure TfrmBaixaCtaPagar.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryConFor, qryConFor, edtCodFor.Text);
  With qryConFor Do
  Begin
    edtNomFor.Text := FieldByName('FOR_NOMFOR').AsString;
  End;
end;

procedure TfrmBaixaCtaPagar.pCarregaPortador;
begin
  pPesquisaCadPor(qryConPor, qryConPor, edtCodPor.Text);
  With qryConPor Do
  Begin
    edtDesPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmBaixaCtaPagar.pAtualizaTemporaria;
  Var
    strSQL: String;
    qryCtaPag: TUniQuery;
    dspCtaPag: TUniDataSetProvider;
    strCodPrj: String;
    FCnpj : String;
begin

  If (fCfgSis('DACPOR', varBoolean)) And
     Not (fEmptyStr(edtCodPor.Text)) Then
  Begin
    If Not fValidaCampos(edtCodPor) Then
    Begin
      blnMudarFoco := False;
      Exit;
    End;
  End;

  pLiberaDupsMarcadas;

  cdsCtaPag.Filtered := False;
  cdsCtaPag.Close;
  qryCtaPag := fCriaQuery(Self);
  dspCtaPag := TUniDataSetProvider.Create(Self);
  dspCtaPag.DataSet := qryCtaPag;
  cdsCtaPag.SetProvider(dspCtaPag);

  Try
    strSQL := untCadPag.RetornaSQLCamposTabelaTemporaria;

    strSQL := strSQL + 'WHERE ';
    {**************************************}
    {* DEVIDO À ALTERAÇÃO DA MINAS TINTAS *}
    {* CRIANDO DIREITO DE ACESSO PARA     *}
    {* PODER OU NÃO ALTERAR O VALOR DA    *}
    {* DUPLICATA AGORA VÃO EXISTIR        *}
    {* REGISTROS NO CADPAG COM VALDUP = 0 *}
    {* E QUE NÃO PODEM SER BAIXADOS       *}
    {*06/07/2012************************JU*}
    strSQL := strSQL + '  (P.CTP_VALDUP + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_MULSUJ,0) + IFNULL(P.CTP_VENDOR,0) + IFNULL(CTP_OUTENT,0)) -IFNULL(P.CTP_DESSUJ,0) <> 0 AND ';

    If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      strSQL := strSQL + '  P.CTP_CODEVE = V.EVE_CODEVE AND ';

    Case rdgVeioBo.ItemIndex Of
      0: strSQL := strSQL + '  P.CTP_VEIOBO = "S" AND ';
      1: strSQL := strSQL + '  (P.CTP_VEIOBO = "N" OR P.CTP_VEIOBO IS NULL OR P.CTP_VEIOBO = "") AND ';
    End;

    If (rdgLiberados.Visible) Then
    Begin
      Case rdgLiberados.ItemIndex Of
        0: strSQL := strSQL + '  P.CTP_DTALIB IS NOT NULL AND ';
        1: strSQL := strSQL + '  P.CTP_DTALIB IS NULL AND ';
      End;
    End;

    strSQL := strSQL + '  P.CTP_DTAPAG IS NULL AND ';
    strSQL := strSQL + '  P.CTP_SEQBAI = 0 ';

    strSQL := strSQL + fStrLocate(edtCodPrj, arrPrj, 'CTP_CODPRJ', 'CODPRJ');

    If Not fEmptyStr(edtCodFor.Text) And (chkFiltrarFiliais.Checked)  Then
    Begin
      strSQL := strSQL + ' AND ( P.CTP_CODFOR = :CODFOR  ';

      FCnpj :=  fCampoTabela('FOR_C_G_C_', 'CADFOR', ['FOR_CODFOR','FOR_CGCCPF'], [edtCodFor.Text,'1']);
      If Not fEmptyStr(FCnpj) Then
      Begin
        strSQL := strSQL + '  OR P.CTP_CODFOR IN (';
        strSQL := strSQL + '     SELECT FOR_CODFOR FROM CADFOR WHERE FOR_C_G_C_ LIKE  '+ QuotedStr(LeftStr(FCnpj, 8)+'%')  + ') AND FOR_CGCCPF = ' + QuotedStr('1');
      End;
      strSQL := strSQL + '  ) ';
    End
    Else If Not fEmptyStr(edtCodFor.Text) Then
      strSQL := strSQL + fStrLocate(edtCodFor, arrFornec, 'P.CTP_CODFOR', 'CODFOR');

    strSQL := strSQL + fStrLocate(fraCentroCusto.edtCodEve, arrEvento, 'P.CTP_CODEVE', 'CODEVE');

    strSQL := strSQL + fStrLocate(edtCodEmp, arrEmp, 'P.CTP_CODEMP', 'CODEMP');

    If fEmptyStr(strAutIncManCtp) Then
      strSQL := strSQL + '  AND LOCATE(P.CTP_CODEMP, ' + QuotedStr(strAceCtp) + ') > 0 ';

    If (Not fEmptyStr(edtCodPor.Text)) Then
        strSQL := strSQL + fStrLocate(edtCodPor,arrPortador, 'P.CTP_CODPOR', 'CODPOR')

    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + '  AND (IFNULL(P.CTP_CODPOR, "") = "" ';
      strSQL := strSQL + '  OR LOCATE(P.CTP_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      strSQL := strSQL + '  AND P.CTP_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';

    strSQL := strSQL + '  AND P.CTP_DTACAD IS NOT NULL ';
    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) Then
      strSQL := strSQL + '  AND P.CTP_DTACAD BETWEEN :CADINI AND :CADFIN ';

    If edtVlrFin.Value <> 0 Then
      strSQL := strSQL + '  AND P.CTP_VALORI BETWEEN :VALINI AND :VALFIN ';

    strSQL := strSQL + RetornaFiltroDoPlanoDeContas(fraPlanoDeContas.MskCodCta.Text, arrCentCusto);

    If Not fEmptyStr(strAutIncManCtp) Then
      strSQL := strSQL + '  AND P.AUTOINCREM = :AUTINC ';

    If Not fCfgSis('PRECTP', varBoolean) Then
      strSQL := strSQL +  ' AND CTP_PREVIS <> "S" ';

    With qryCtaPag Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(strAutIncManCtp) Then
        ParamByName('AUTINC').AsString := strAutIncManCtp;

      pSetaParam(edtCodPrj.Text, arrPrj ,strCodPrj ,'CODPRJ',qryCtaPag);
      pSetaParam(edtCodFor.Text, arrFornec,strFornec,'CODFOR',qryCtaPag);
      pSetaParam(fraCentroCusto.edtCodEve.Text, arrEvento,strEvento,'CODEVE',qryCtaPag);
      pSetaParam(edtCodEmp.Text, arrEmp, strEmp, 'CODEMP', qryCtaPag);
      pSetaParam(edtCodPor.Text, arrPortador,strPortador, 'CODPOR' ,qryCtaPag);

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text)
      End;

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) Then
      Begin
        ParamByName('CADINI').AsDateTime := StrToDate(mskDtaCadIni.Text);
        ParamByName('CADFIN').AsDateTime := StrToDate(mskDtaCadFin.Text);
      End;

      If edtVlrFin.Value <> 0 Then
      Begin
        ParamByName('VALINI').AsFloat := edtVlrIni.Value;
        ParamByName('VALFIN').AsFloat := edtVlrFin.Value;
      End;

      pSetaParam(fraPlanoDeContas.MskCodCta.Text, arrCentCusto ,strCentCusto ,'CODCTA',qryCtaPag);

      Open;

      Application.ProcessMessages;

      If Not IsEmpty Then
      Begin
        pSetaClient(qryCtaPag);
        cdsCtaPag.Open;
        With cdsCtaPag Do
        Begin
          (FieldByName('CTP_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('CTP_DESSUJ') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('CTP_JURSUJ') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('CTP_MULSUJ') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('CTP_VENDOR') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('CTP_OUTENT') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('TOTDUP')     As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('CTP_GRVORI') As TFloatField).DisplayFormat := '#,##0.00';
          IndexFieldNames := 'CTP_DTAVEN;CTP_CODFOR;CTP_NUMDUP;CTP_CODEMP';
          cdsCtaPag.FieldByName('FOR_C_G_C_').OnGetText := cdsCtaPagFor_C_G_C_GetText;
          First;
          Application.ProcessMessages;
          pCalculaTotalDuplicatas(edtTotDesconto, edtTotJuros,edtTotMulta, edtValorTotal, edtQtdDuplicatas, edtTotVendor, edtOutrasEntidades, False);

          Application.ProcessMessages;
          pCalculaTotalDuplicatas(edtDescontoTotal, edtJurosTotal,edtMultaTotal, edtTotalPago, edtQtdSelecionadas, edtVendorTotal, edtOutEnt, True);
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Não há duplicatas para serem baixadas!', ['&O k']);
        If (chkLimFil.Checked) Then
          pLimpaEdits;
        pLimpaEditsDuplicata;
        blnMudarFoco := False;
        FControlFoco := edtCodFor;
      End;

      Close;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmBaixaCtaPagar.pAtualizaTemporaria]');
    End;
  End;

  Application.ProcessMessages;
  objLock.pDestravarTodos;
  cdsCtaPag.SetProvider(nil);
  FreeAndNil(dspCtaPag);
  FreeAndNil(qryCtaPag);
end;

{*****************************************}
{* SOMA O TOTAL DE DUPLICATAS DISPONÍ -  *}
{* VEIS PARA A BAIXA                     *}
{**************************************MV*}
procedure TfrmBaixaCtaPagar.pCalculaTotalDuplicatas(edtDesconto, edtJuros, edtMulta, edtTotal, edtQuant, edtVendor, edtOutrasEntidades: TEditFocus; blnFiltrar: Boolean);
  Var
    cdsGen: TUniClientDataSet;
    fld001,
    fld002,
    fld003,
    fld004,
    fld005,
    fld006: TAggregateField;
begin
  cdsGen := TUniClientDataSet.Create(Self);

  fld001 := TAggregateField.Create(Self);
  With fld001 Do
  Begin
    FieldName := 'FLD001';
    DataSet := cdsGen;
    DisplayFormat := '#,##0.00';
    Expression := 'SUM(CTP_' + IIF(blnFiltrar, 'VALDES', 'DESSUJ') + ')';
    Active := True;
  End;

  fld002 := TAggregateField.Create(Self);
  With fld002 Do
  Begin
    FieldName := 'FLD002';
    DataSet := cdsGen;
    DisplayFormat := '#,##0.00';
    Expression := 'SUM(CTP_' + IIF(blnFiltrar, 'VALJUR', 'JURSUJ') + ')';
    Active := True;
  End;

  fld003 := TAggregateField.Create(Self);
  With fld003 Do
  Begin
    FieldName := 'FLD003';
    DataSet := cdsGen;
    DisplayFormat := '#,##0.00';
    Expression := 'SUM(' + IIF(blnFiltrar, 'CTP_VALPAG', 'TOTDUP') + ')';
    Active := True;
  End;

  fld004 := TAggregateField.Create(Self);
  With fld004 Do
  Begin
    FieldName := 'FLD004';
    DataSet := cdsGen;
    DisplayFormat := '#,##0.00';
    Expression := 'SUM(CTP_VENDOR)';
    Active := True;
  End;

  fld005 := TAggregateField.Create(Self);
  With fld005 Do
  Begin
    FieldName := 'FLD005';
    DataSet := cdsGen;
    DisplayFormat := '#,##0.00';
    Expression := 'SUM(CTP_OUTENT)';
    Active := True;
  End;

  fld006 := TAggregateField.Create(Self);
  With fld006 Do
  Begin
    FieldName := 'FLD006';
    DataSet := cdsGen;
    DisplayFormat := '#,##0.00';
    Expression := 'SUM(CTP_' + IIF(blnFiltrar, 'VALMUL', 'MULSUJ') + ')';
    Active := True;
  End;

  With cdsGen Do
  Begin
    Data := cdsCtaPag.Data;

    If blnFiltrar Then
    Begin
      Filtered := False;
      Filter := 'CTP_MARDES = ' + QuotedStr('M');
      Filtered := True;
    End;

    AggregatesActive := True;

    If Not IsEmpty Then
    Begin
      edtDesconto.Text        := FormatFloat('#,##0.00', fld001.Value);
      edtJuros.Text           := FormatFloat('#,##0.00', fld002.Value);
      edtTotal.Text           := FormatFloat('#,##0.00', fld003.Value);
      edtVendor.Text          := FormatFloat('#,##0.00', fld004.Value);
      edtOutrasEntidades.Text := FormatFloat('#,##0.00', fld005.Value);
      edtMulta.Text           := FormatFloat('#,##0.00', fld006.Value);
      edtQuant.Text           := IntToStr(RecordCount);
    End
    Else
    Begin
      edtDesconto.Text        := '0,00';
      edtJuros.Text           := '0,00';
      edtMulta.Text           := '0,00';
      edtTotal.Text           := '0,00';
      edtVendor.Text          := '0,00';
      edtOutrasEntidades.Text := '0,00';
      edtQuant.Text           := '0';
    End;
  End;

  FreeAndNil(fld001);
  FreeAndNil(fld002);
  FreeAndNil(fld003);
  FreeAndNil(fld004);
  FreeAndNil(fld005);
  FreeAndNil(fld006);
  FreeAndNil(cdsGen);
end;

procedure TfrmBaixaCtaPagar.pAplicaDescontoGeral;
  Var
    fltValDes: Double;
    intRecNo: Integer;
    fltTmpTotDesc,
    fltValDif: Double;

  function fGetValDes(fltValGer, fltValDup, fltValDes: Double): Double;
  Begin
    Result := RoundTo(fltValDup * fltValDes / fltValGer, -2);
  End;

  procedure pAplicaDescontoDuplicata(fltDesconto: Double);
    Var
      fltJurOri: Double;
      fltMulOri: Double;
  Begin
    With cdsCtaPag Do
    Begin
      Edit;
      //Juro original
      fltJurOri := (FieldByName('TOTDUP').AsFloat - FieldByName('CTP_MULSUJ').AsFloat) - FieldByName('CTP_VALDUP').AsFloat;
      //Multa Original
      fltMulOri := (FieldByName('TOTDUP').AsFloat - FieldByName('CTP_JURSUJ').AsFloat) - FieldByName('CTP_VALDUP').AsFloat;

      If (fltJurOri > 0) Then
      Begin
        If (RoundTo(fltJurOri, -2) >= fltDesconto) Then
        Begin
          FieldByName('CTP_VALJUR').AsFloat := (fltJurOri - fltDesconto);
          fltDesconto := 0;
        End
        Else
        Begin
          fltDesconto := fltDesconto - fltJurOri;
          FieldByName('CTP_VALJUR').AsFloat := 0;
        End;
      End
      Else If (fltMulOri > 0) Then
      Begin
        If (RoundTo(fltMulOri, -2) >= fltDesconto) Then
        Begin
          FieldByName('CTP_VALMUL').AsFloat := (fltMulOri - fltDesconto);
          fltDesconto := 0;
        End
        Else
        Begin
          fltDesconto := fltDesconto - fltMulOri;
          FieldByName('CTP_VALMUL').AsFloat := 0;
        End;
      End;

      FieldByName('CTP_TIPDES').AsString := recDescontoGeral.strTipDes;
      FieldByName('CTP_VALDES').AsFloat := fltDesconto;
      FieldByName('CTP_VALPAG').AsFloat := FieldByName('CTP_VALDUP').AsFloat -
                                           FieldByName('CTP_VALDES').AsFloat +
                                           FieldByName('CTP_VALJUR').AsFloat +
                                           FieldByName('CTP_VALMUL').AsFloat ;
      Post;
    End;
  End;
begin
  Application.ProcessMessages;
  Screen.Cursor := crHourGlass;
  intRecNo      := cdsCtaPag.RecNo;
  fltTmpTotDesc := 0;

  Try
    If (recDescontoGeral.blnConfir) Then
    Begin
      Try
        With cdsCtaPag Do
        Begin
          DisableControls;
          Filtered := False;
          Filter   := 'CTP_MARDES = '+ QuotedStr('M');
          Filtered := True;

          While Not Eof Do
          Begin
            {* Se for baixa parcial e/ou Crédito não inclui desconto *}
            If (FieldByName('CTP_TIPBAI').AsString = 'P') Or
              (FieldByName('TOTDUP').AsFloat < 0) Then
            Begin
              Next;
              Continue;
            End;

            fltValDes     := fGetValDes(recDescontoGeral.fltValBxa, FieldByName('CTP_VALDUP').AsFloat, recDescontoGeral.fltValDes);
            fltTmpTotDesc := fltTmpTotDesc + fltValDes;

            pAplicaDescontoDuplicata(fltValDes);

            Next;
          End;

          {*********************************}
          {* Trata a diferença de centavos *}
          {******************************FS*}
          fltValDif := recDescontoGeral.fltValDes - fltTmpTotDesc;

          {* Se tiver diferença, joga a mesma para a primeira duplicata *}
          If (RoundTo(fltValDif, -2) <> 0) Then
          Begin
            First;
            pAplicaDescontoDuplicata(FieldByName('CTP_VALDES').AsFloat + RoundTo(fltValDif, -2));
          End;
        End;
      Except
        On E: Exception Do
        Begin
          recDescontoGeral.blnConfir := False;
          pMensagensErro(E.message, '');
        End;
      End;
    End;

    If recDescontoGeral.blnConfir Then
    Begin
      Try
        pCalculaTotalDuplicatas(edtDescontoTotal, edtJurosTotal,edtMultaTotal,edtTotalPago, edtQtdSelecionadas, edtVendorTotal, edtOutrasEntidades, True);
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;
    End;
  Finally
    Screen.Cursor      := crDefault;
    cdsCtaPag.Filtered := False;
    cdsCtaPag.Filter   := '';
    cdsCtaPag.RecNo    := intRecNo;
    cdsCtaPag.EnableControls;
  End;
end;

procedure TfrmBaixaCtaPagar.pAtualizaDados(DataSet: TDataSet);
begin
  If (Not DataSet.ControlsDisabled) And (DataSet.Active) Then
  Begin
    With DataSet Do
    Begin
      edtCodEveBai.Text := FieldByName('CTP_CODEVE').AsString;
      edtDesEveBai.Text := FieldByName('EVE_DESEVE').AsString;
      edtCodCtaBai.Text := FieldByName('CTP_CODCTA').AsString;
      edtDesCtaBai.Text := FieldByName('CTA_DESCTA').AsString;
      edtDtaCad.Text    := FieldByName('CTP_DTACAD').AsString;
      edtHistor.Texto   := FieldByName('CTP_HIST01').AsString;
      edtCodVel.Text    := FieldByName('CTP_CODVEL').AsString;
      edtCompet.Text    := FieldByName('CTP_COMPET').AsString;

      pVerificaCTAReceber(FieldByName('CTP_CODFOR').AsString, FieldByName('CTP_CODEMP').AsString);

      If FieldByName('CTP_PREVIS').AsString = 'S' Then
        edtPrevis.Text  := 'SIM'
      Else
        edtPrevis.Text  := 'NÃO';

      edtSerie.Text := FieldByName('CTP_SERIE_').AsString;

      If (FieldByName('CTP_PREVIS').AsString = 'S') And
         (fVerificaAcessoSistema('CTPALTVLR', strLoginUsuarioLogado)) Then
        btnAlterarValor.Enabled := True
      Else
        btnAlterarValor.Enabled := False;
    End;
  End;
end;

{*****************************************}
{* SELECIONA UMA DUPLICATA               *}
{**************************************MV*}
procedure TfrmBaixaCtaPagar.pSelecionaDuplicata(pSelComCtrlMouse : Boolean = false);
  Var
    frmBaixaDigValores : TfrmBaixaDigValores;
begin
  If cdsCtaPag.IsEmpty Then
    Exit;

  If cdsCtaPag.FieldByName('CTP_MARDES').AsString <> 'M' Then
  Begin
    Try
      if ((fCfgSis('CTPLBB', varBoolean) And (cdsCtaPag.FieldByName('CTP_DTALIB').IsNull)) And Not fCfgSis('CTPBDP', varBoolean)) then
      begin
        pMensagemOk('Esta duplicata ainda não foi liberada para baixa.');
        Exit;
      end;

      If (blnUsaLiberacaoDePrevisao) And (cdsCtaPag.FieldByName('CTP_PREVIS').AsString = 'S') Then
      Begin
        fMensagem('AVISO', 'Essa duplicata não pode ser baixada, pois é necessário realizar a liberação de previsionamento!', ['&O k']);
        pSetFocus(dbgDuplicatas);
        Exit;
      End;

      If blnUsaTravaMsgPagtoAntecipado And FornecedorPossuiPagamentosAntecipados(cdsCtaPag.FieldByName('CTP_CODFOR').AsString) Then
      Begin
        If (fMensagem('ATENÇÃO', 'O fornecedor '+ cdsCtaPag.FieldByName('CTP_CODFOR').AsString + '-' + cdsCtaPag.FieldByName('FOR_NOMFOR').AsString +
                                ' possui pagamento(s) antecipado(s) para ser(em) utilizado(s), deseja continuar?', ['&Sim', '&Não'], 1) = 2) Then
            Exit;
      End;

      if Not fEmpresaTemAcessoPortador(cdsCtaPag.FieldByName('CTP_CODPOR').AsString,VS_strCodEmp) Then
      Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Exit;
      End;

      If fDescontoMaiorQueDuplicata(cdsCtaPag.FieldByName('CTP_DESSUJ').AsFloat,
                                    cdsCtaPag.FieldByName('CTP_VALORI').AsFloat,
                                    cdsCtaPag.FieldByName('TOTDUP').AsFloat) Then
      Begin
        pMensagemOk('Esta duplicata está com desconto superior ao valor do documento. ' + #13 +
                    'Corrija o documento na manutenção de contas a pagar.');
        Exit;
      End;

      {*****************************************}
      {* CHAMA O FORM DE DIGITAÇÃO             *}
      {**************************************MV*}
      pCriarFormularios(TfrmBaixaDigValores, frmBaixaDigValores);
      frmBaixaDigValores.tibTipBai := tbCtaPagar;
      frmBaixaDigValores.dtaDtaCad := cdsCtaPag.FieldByName('CTP_DTACAD').AsDateTime;
      frmBaixaDigValores.fltValDup := cdsCtaPag.FieldByName('CTP_VALDUP').AsFloat;
      frmBaixaDigValores.fltVendor := cdsCtaPag.FieldByName('CTP_VENDOR').AsFloat;
      frmBaixaDigValores.fltOutEnt := cdsCtaPag.FieldByName('CTP_OUTENT').AsFloat;
      frmBaixaDigValores.fltMulSuj := cdsCtaPag.FieldByName('CTP_MULSUJ').AsFloat;
      frmBaixaDigValores.fltValJur := cdsCtaPag.FieldByName('CTP_JURSUJ').AsFloat;
      frmBaixaDigValores.fltValMul := cdsCtaPag.FieldByName('CTP_MULSUJ').AsFloat;
      frmBaixaDigValores.fltValDes := cdsCtaPag.FieldByName('CTP_DESSUJ').AsFloat;
      frmBaixaDigValores.fltJurSuj := cdsCtaPag.FieldByName('CTP_JURSUJ').AsFloat;
      frmBaixaDigValores.fltMulSuj := cdsCtaPag.FieldByName('CTP_MULSUJ').AsFloat;
      frmBaixaDigValores.fltDesSuj := cdsCtaPag.FieldByName('CTP_DESSUJ').AsFloat;
      frmBaixaDigValores.fltValCal := cdsCtaPag.FieldByName('TOTDUP').AsFloat;
      frmBaixaDigValores.strNumDup := cdsCtaPag.FieldByName('CTP_NUMDUP').AsString;
      frmBaixaDigValores.strSerie  := cdsCtaPag.FieldByName('CTP_SERIE_').AsString;
      frmBaixaDigValores.strCodEmp := cdsCtaPag.FieldByName('CTP_CODEMP').AsString;
      frmBaixaDigValores.strNomFor := cdsCtaPag.FieldByName('CTP_NOMFOR').AsString;
      frmBaixaDigValores.dtaDtaVen := cdsCtaPag.FieldByName('CTP_DTAVEN').AsDateTime;
      frmBaixaDigValores.fltDesCob := 0;
      frmBaixaDigValores.strAutoIncrem :=  cdsCtaPag.FieldByName('AUTOINCREM').AsString;
      frmBaixaDigValores.FLiberacaoPendente := (fCfgSis('CTPLBB', varBoolean) And (cdsCtaPag.FieldByName('CTP_DTALIB').IsNull)) And fCfgSis('CTPBDP', varBoolean);
      frmBaixaDigValores.objLogLibCtp := objLogLibCtp;
      frmBaixaDigValores.BaixaCTPZerado := (fCfgSis('CTP_AS') = 'S') And
                                           (Not blnResumoCaixa);

      frmBaixaDigValores.blnDupAnt := (cdsCtaPag.FieldByName('CTP_PAGANT').AsString = 'S');
      frmBaixaDigValores.Position := poScreenCenter;

      frmBaixaDigValores.blnChmCaixa := blnResumoCaixa;

      If dtaDtaPag = 0 then
        frmBaixaDigValores.dtaDtaPag := VS_Date
      Else
        frmBaixaDigValores.dtaDtaPag := dtaDtaPag;

      if (strCodPorFix <> '') and (fltValorBaixa <> 0) then
      begin
        frmBaixaDigValores.mskDtaPag.Enabled := False;
        frmBaixaDigValores.mskDtaPag.Date    := dtaDtaPag;
      end;

      if (pSelComCtrlMouse) then
      begin
        frmBaixaDigValores.Show;
        frmBaixaDigValores.hide;
        frmBaixaDigValores.btnConfirmaDados.Click;
      end
      else
        frmBaixaDigValores.ShowModal;

      If (frmBaixaDigValores.blnConfirma) Then
      Begin

        strTipDes := frmBaixaDigValores.strTipDes;
        strTipBai := frmBaixaDigValores.strTipBai;
        fltValPag := frmBaixaDigValores.fltValPag;
        fltValJur := frmBaixaDigValores.fltValJur;
        fltValMul := frmBaixaDigValores.fltValMul;
        fltVendor := frmBaixaDigValores.fltVendor;
        fltOutEnt := frmBaixaDigValores.fltOutEnt;
        fltValDes := frmBaixaDigValores.fltValDes;
        dtaDtaPag := StrToDate(frmBaixaDigValores.strDtaRec);

        if not fValidaValorBaixa(fltValPag) then
        begin
           pMensagemOk('Não é possível selecionar esta duplicata, o valor excede o permitido!' + #13 +
                       'Valor para baixa: ' + FormatFloat('###,###,##0.00', fltValorBaixa)+ #13 +
                       'Valor disponível: ' + FormatFloat('###,###,##0.00', fltValorBaixa-fStrToFloat(edtTotalPago.Text)));
           Exit;
        end;

        If (strTipBai = 'P') And (fExisteCTRPag(cdsCtaPag.FieldByName('AUTOINCREM').AsString)) Then
        Begin
           If Not fVerificaAcessoSistema('CTPBXPARCFUNC', strLoginUsuarioLogado) Then
           Begin
              fMensagem('Aviso', 'Documento com origem pelas rotinas da folha de pagamento não permite baixa parcial!', ['&O k']);
              Exit;
           End;
        End;

        {*****************************************}
        {* MARCA A DUPLICATA E ATUALIZA A TELA   *}
        {**************************************MV*}
        pMarcarDuplicataTela;
        If Pos('SM_', strMarcacaoLog) <= 0 Then
          strMarcacaoLog := strMarcacaoLog + 'SM_';
      End
      Else
      Begin
        ObjLogLibCtp.pRemoveLogLib(cdsCtaPag.FieldByName('AUTOINCREM').AsString);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmBaixaCtaPagar.pSelecionaDuplicata]');
      End;
    End;

    pFreeAndNil(frmBaixaDigValores);
    pSetFocus(Self);

  End
  Else
  Begin
    ObjLogLibCtp.pRemoveLogLib(cdsCtaPag.FieldByName('AUTOINCREM').AsString);
    pMarcaDuplicata(False);
    pCalculaTotalDuplicatas(edtDescontoTotal, edtJurosTotal,edtMultaTotal,edtTotalPago, edtQtdSelecionadas, edtVendorTotal, edtOutrasEntidades, True);
    If Pos('DM_', strMarcacaoLog) <= 0 Then
      strMarcacaoLog := strMarcacaoLog + 'DM_';
  End;

  {******************************************}
  {* POSICIONA O CURSOR NO PRÓXIMO REGISTRO *}
  {***************************************ER*}
  dbgDuplicatasView.NavigatorButtons.Next.Click;
end;

procedure TfrmBaixaCtaPagar.pStepStatusSelecao(pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

procedure TfrmBaixaCtaPagar.pUtilizaRotinaProjeto;
begin
  pnlProjeto.Visible := fCfgSis('UTLPRJ', varBoolean);
  pnlCabecalho2.Visible := pnlCabecalho.Visible;
  pnlProjeto.Visible := pnlCabecalho.Visible;
end;

procedure TfrmBaixaCtaPagar.pVerificaCTAReceber(strCodFor, strCodEmp: string);
Var
  strSQL      : string;
  qryCtaReceb : TUniQuery;
begin
  qryCtaReceb := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + 'SELECT  ';
  strSQL := strSQL + '(SELECT IFNULL(SUM(CTR_VALDUP),0) VALDUP_VENC  ';
  strSQL := strSQL + 'FROM CADREC R, CADFOR F  ';
  strSQL := strSQL + 'WHERE F.FOR_CODFOR = :CODFOR AND CTR_DTAREC IS NULL AND CTR_DTAVEN < CURDATE() AND CTR_VALDUP > 0  ';
  strSQL := strSQL + '      AND CTR_SEQBAI = 0  ';
  strSQL := strSQL + '      AND CTR_CODEMP = :CODEMP ';
  strSQL := strSQL + '      AND CTR_CODCLI = F.FOR_CODCLI) AS VALDUP_VENC, ';
  strSQL := strSQL + '(SELECT IFNULL(SUM(CTR_VALDUP),0) VALDUP_AVENC ';
  strSQL := strSQL + 'FROM CADREC R, CADFOR F ';
  strSQL := strSQL + 'WHERE F.FOR_CODFOR = :CODFOR AND CTR_DTAREC IS NULL AND CTR_DTAVEN >= CURDATE() AND CTR_VALDUP > 0 ';
  strSQL := strSQL + '      AND CTR_SEQBAI = 0 ';
  strSQL := strSQL + '      AND CTR_CODEMP = :CODEMP ';
  strSQL := strSQL + '      AND CTR_CODCLI = F.FOR_CODCLI) AS VALDUP_AVENC, ';
  strSQL := strSQL + '(SELECT IFNULL(SUM(CTR_VALDUP),0) VALDUP_CRED ';
  strSQL := strSQL + 'FROM CADREC R, CADFOR F ';
  strSQL := strSQL + 'WHERE F.FOR_CODFOR = :CODFOR AND CTR_DTAREC IS NULL AND CTR_VALDUP < 0 ';
  strSQL := strSQL + '      AND CTR_SEQBAI = 0 ';
  strSQL := strSQL + '      AND CTR_CODEMP = :CODEMP ';
  strSQL := strSQL + '      AND CTR_CODCLI = F.FOR_CODCLI) AS VALDUP_CRED, ';
  strSQL := strSQL + '(SELECT IFNULL(SUM(CTR_VALDUP),0) VALDUP_TOT ';
  strSQL := strSQL + 'FROM CADREC R, CADFOR F ';
  strSQL := strSQL + 'WHERE F.FOR_CODFOR = :CODFOR AND CTR_DTAREC IS NULL ';
  strSQL := strSQL + '      AND CTR_SEQBAI = 0 ';
  strSQL := strSQL + '      AND CTR_CODEMP = :CODEMP ';
  strSQL := strSQL + '      AND CTR_CODCLI = F.FOR_CODCLI) AS VALDUP_TOT ';

  With qryCtaReceb Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODFOR').AsString  := strCodFor;
    ParamByName('CODEMP').AsString  := strCodEmp;
    Open;

    If RecordCount > 0 Then
    Begin
      edtEmAbertoAVenc.Text := FormatFloat('#,##0.00', FieldByName('VALDUP_AVENC').AsFloat);
      edtEmAbertoVenc.Text  := FormatFloat('#,##0.00', FieldByName('VALDUP_VENC').AsFloat);
      edtEmAbertoCred.Text  := FormatFloat('#,##0.00', FieldByName('VALDUP_CRED').AsFloat);
      edtEmAbertoTotal.Text := FormatFloat('#,##0.00', FieldByName('VALDUP_TOT').AsFloat);
    End
    Else
      pLimpaCTRemAberto;;

    Close;
  End;

  FreeAndNil(qryCtaReceb);
end;

function TfrmBaixaCtaPagar.RetornaDatasetCamposCadPag(
  AAutoIncremCadPag: String): TUniClientDataSet;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;
  Try
    LConsulta.SQL.Text := 'SELECT CTP_DINHEI, CTP_CHQAVI, CTP_ORDPAG, CTP_REPCHQ, ' +
                          '       CTP_EMPBAI, CTP_DTAPAG, CTP_CODFOR, CTP_SEQCON ' +
                          'FROM CADPAG ' +
                          'WHERE AUTOINCREM=:AUTOINC';

    LConsulta.ParamByName('AUTOINC').AsString := AAutoIncremCadPag;
    LConsulta.Open;
  Finally
    Result := fCriaClientDatSet(LConsulta);
    Result.Open;

    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

function TfrmBaixaCtaPagar.RetornaFiltroDoPlanoDeContas(ATexto: String;
  AArrayPesquisa: TConsultasArray): String;
  Var
    LConsultas: TConsultas;

    LSQLLike,
    LSQLIn: String;
begin
  Result := EmptyStr;

  If Length(AArrayPesquisa) > 1 THen
  Begin
    LSQLLike := EmptyStr;
    LSQLIn := EmptyStr;

    For LConsultas In AArrayPesquisa Do
    Begin
      If RightStr(LConsultas.strCodigo, 5) = '00000' Then
        LSQLLike := LSQLLike + ' (P.CTP_CODCTA LIKE "' + LeftStr(LConsultas.strCodigo, 2) + '%") OR '
      Else If RightStr(LConsultas.strCodigo, 3) = '000' Then
        LSQLLike := LSQLLike + ' (P.CTP_CODCTA LIKE "' + LeftStr(LConsultas.strCodigo, 4) + '%") OR '
      Else
        LSQLIn := LSQLIn + '"' + LConsultas.strCodigo + '",';
    End;

    Result := '(';
    If Not LSQLIn.IsEmpty Then
      Result := Result + ' P.CTP_CODCTA IN (' + LeftStr(LSQLIn, LSQLIn.Length - 1) + ') OR ';
    Result := Result + LSQLLike;
    Result := LeftStr(Result, Result.Length-4) + ')';
  End
  Else If Not ATexto.IsEmpty Then
  Begin
    Result := 'P.CTP_CODCTA ';

    If RightStr(ATexto, 5) = '00000' Then
      Result := Result + ' LIKE "' + LeftStr(ATexto, 2) + '%" '
    Else If RightStr(ATexto, 3) = '000' Then
      Result := Result + ' LIKE "' + LeftStr(ATexto, 4) + '%" '
    Else
      Result := Result + ' = "' + ATexto + '"';
  End;

  Result := IIF(Result.IsEmpty, EmptyStr, ' AND ' + Result);
end;

procedure TfrmBaixaCtaPagar.pMarcarDuplicataTela;
begin
  pMarcaDuplicata(True);
  pCalculaTotalDuplicatas(edtDescontoTotal, edtJurosTotal,edtMultaTotal,edtTotalPago, edtQtdSelecionadas, edtVendorTotal, edtOutrasEntidades, True);
end;

procedure TfrmBaixaCtaPagar.pProcessaCloneCtaPag(
  var cdsClone: TUniClientDataSet);
begin
  cdsClone.Filter := '';
  cdsClone.Filtered := True;
  cdsClone.First;
  While Not cdsClone.Eof Do
  Begin
    If (cdsClone.FieldByName('CTP_MARDES').AsString <> 'M') Then
    Begin
      cdsClone.Delete;
      Continue;
    End;
    cdsClone.Next;
  End;
end;

{*****************************************}
{* MARCA UMA DUPLICATA A SER BAIXADA     *}
{**************************************MV*}
procedure TfrmBaixaCtaPagar.pMarcaDuplicata(blnMarcar: Boolean);
begin

  if (not fVerificaDireitoBaixa) then
	begin
    pMensagemOk('Usuário não tem permissão para fazer baixa nesta empresa.');
  	Exit;
	end;

  With cdsCtaPag Do
  Begin
    If blnMarcar Then
    Begin
      If fDescontoMaiorQueDuplicata(cdsCtaPag.FieldByName('CTP_DESSUJ').AsFloat,
                                    cdsCtaPag.FieldByName('CTP_VALORI').AsFloat,
                                    cdsCtaPag.FieldByName('TOTDUP').AsFloat) Then
      Begin
        pMensagemOk(Format('A duplicata %s está com desconto superior ou igual ao valor do documento. ', [FieldByName('CTP_NUMDUP').AsString]) +#13 +
                    'Corrija o documento na manutenção de contas a pagar.');
        Exit;
      End;

      If (cdsCtaPag.FieldByName('HRAFIL').AsDateTime < fRetornaUltimaAlteracaoDuplicataCTP(FieldByName('NRODUP').AsString,
                                                                                           FieldByName('PARDUP').AsString,
                                                                                           FieldByName('CTP_SERIE_').AsString,
                                                                                           FieldByName('CTP_CODFOR').AsString,
                                                                                           FieldByName('CTP_CODEMP').AsString)) Then
      Begin
        pMensagemOk('A duplicata que está sendo marcada sofreu uma alteração posterior a pesquisa realizada.' + #13 +
                    'Recarregue as duplicatas e tente novamente.');
        Exit;
      End;

      If Not objLock.fLock_Unlock(FieldByName('TABELA').AsString + FieldByName('AUTOINCREM').AsString, True, False) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esta duplicata está sendo utilizada por outra estação: ' + fGetHostLock(FieldByName('TABELA').AsString + FieldByName('AUTOINCREM').AsString), ['&Ok']);
        Exit;
      End;
    End
    Else
      objLock.fLock_Unlock(FieldByName('TABELA').AsString + FieldByName('AUTOINCREM').AsString, False);

    Edit;
    FieldByName('CTP_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
    FieldByName('CTP_TIPDES').AsString := strTipDes;
    FieldByName('CTP_TIPBAI').AsString := strTipBai;
    FieldByName('CTP_VALPAG').AsFloat  := fltValPag;

    If blnMarcar Then
    Begin
      FieldByName('CTP_DTAPAG').AsDateTime := dtaDtaPag;
      FieldByName('CTP_JURSUJ').AsFloat    := fltValJur; //MF: 290852 - 30/06/23
      FieldByName('TOTDUP').AsFloat        := fltValPag; //MF: 290852 - 30/06/23
      FieldByName('CTP_DESSUJ').AsFloat    := fltValDes;//MF: 290852 - 30/06/23
    End
    Else
    Begin
      FieldByName('CTP_DTAPAG').Value   := Null;
      FieldByName('CTP_JURSUJ').AsFloat := FieldByName('CTP_JURORI').AsFloat; //MF: 290852 - 30/06/23
      FieldByName('TOTDUP').AsFloat     := FieldByName('TOTORI').AsFloat; //MF: 290852 - 30/06/23
      FieldByName('CTP_DESSUJ').AsFloat := FieldByName('CTP_DESORI').AsFloat; //MF: 290852 - 30/06/23
    End;

    FieldByName('CTP_VALDES').AsFloat := fltValDes;
    FieldByName('CTP_VALJUR').AsFloat := fltValJur;

    FieldByName('CTP_VALMUL').AsFloat := fltValMul;
    FieldByName('CTP_VENDOR').AsFloat := fltVendor;
    FieldByName('CTP_OUTENT').AsFloat := fltOutEnt;

    if blnMarcar And Not fEmpresaTemAcessoPortador(FieldByName('CTP_CODPOR').AsString,VS_strCodEmp) Then
    Begin
      fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);

      FieldByName('CTP_MARDES').AsString := 'D';
      FieldByName('CTP_TIPDES').AsString := strTipDes;
      FieldByName('CTP_TIPBAI').AsString := strTipBai;
      FieldByName('CTP_VALPAG').AsFloat  := fltValPag;
      FieldByName('CTP_DTAPAG').Value    := Null;
      FieldByName('CTP_VALDES').AsFloat  := fltValDes;
      FieldByName('CTP_VALJUR').AsFloat  := fltValJur;
      FieldByName('CTP_VALMUL').AsFloat  := fltValMul;
      FieldByName('CTP_VENDOR').AsFloat  := fltVendor;
      FieldByName('CTP_OUTENT').AsFloat  := fltOutEnt;
    End;

    Post;
    pMarcaFornecedor(FieldByName('AUTOINCREM').AsString+'|'+FieldByName('CTP_CODFOR').AsString,IIF(blnMarcar, 'M', 'D'));
  End;

end;

procedure TfrmBaixaCtaPagar.pMarcaFornecedor(chave, marcaDesmarca:String);
  Var
    i: integer;
begin

  if marcaDesmarca = 'M' then
    lstFornecedor.Add(chave)
  else
  begin
    for i:= 0 to lstFornecedor.count -1 do
      if chave = lstFornecedor[i] then
      begin
        lstFornecedor.Delete(i);
        Break;
      end;
  end;
//
end;

procedure TfrmBaixaCtaPagar.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmBaixaCtaPagar.fAtualizaPorBai: Boolean;
  Var
    intRecNo: Integer;
Begin
  Result   := True;
  intRecNo := 0;

  With cdsCtaPag Do
  Begin
    Try
      cdsCtaPag.OnFilterRecord := nil;
      DisableControls;
      intRecNo := RecNo;

      Filtered := False;
      Filter := 'CTP_MARDES = ' + QuotedStr('M');
      Filtered := True;
      First;

      While Not Eof Do
      Begin
        Edit;
        FieldByName('CTP_PORBAI').AsString := strPorBai;
        FieldByName('POR_NOMPOR').AsString := fRetNomPortador(strPorBai);
        Post;
        Next;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message,'[TfrmBaixaCtaPagar.fAtualizaPorBai]');
      End;
    End;

    Filtered := False;
    Filter := '';
    RecNo := intRecNo;
    EnableControls;
    OnFilterRecord := pFilterRecord;
  End;
End;

{*****************************************}
{* BAIXA AS DUPLICATAS SELECIONADAS      *}
{**************************************MV*}
function TfrmBaixaCtaPagar.fBaixaDuplicatas(blnNaoBai: Boolean = False): Boolean;
  Var
    blnGraVDp: Boolean;
    blnBaiAna: Boolean;
    blnConfirma: Boolean;
    strSeqLan: String;
    strCreDeb: String;
    fltValRec: Double;
    intSeqBai: Integer;
    fltVlDesm: Double; // valor das contas desmembradas
    fltJrDesm: Double;
    fltMulSujDesm: Double;
    fltDsDesm: Double;

    intDupCx: Integer;
    fltTotCx: Double;
    strNroDupCx: String;
    strParDupCx: String;
    intCountDup: Integer;

    strPorDin: String;
    strPorChV: String;
    strPorOrd: String;
    strPorRep: String;

    strForRep: String;
    strObsRep: String;
    stlChqEmi: TStringList;
    intContCh: Integer;
    intSeqRCH: Integer;

    strSeqDep: String;
    strChave : String;
    strSQL   : String;
    qryGen   : TUniQuery;
    strSeqRcx: String;
    strCpDcBa: String;
    intCtpCx : Longint;
    intCtpCon: Longint;
    strCodFor: String; // Código do Fonecedor
    strCodEmp: String;
    strHisBaiSint : String;

    fltTotChqRep : Double;
    fltTotDesm: Double;
    fltValSel: Double;

    cdsRateio: TUniClientDataSet;
    cdsRatChqEmi: TUniClientDataSet;
    repCadChq: TCadChqRepository;
    cdsCloneCtaPag: TUniClientDataSet;
    cdsTmpPag: TUniClientDataSet;
    Key: Char;

    keyArray : TArray<String>;  // Chaves ordenadas

    lstBanCtp : TBanCtpRepository;
    lstBanChq : TBanChqRepository;
    dicChqCtp : TDictionary<String,TCtpInfo>;
    recCtpInfo : TCtpInfo;

    strTmpChave : String;
    strTmpCodFor : String;
    strTmpHist01 : String;
    strTmpHist02 : String;
    strMsgInconsistencia: String;
    prcScroll: TprcScroll;

    blnDepRep: Boolean;
    frmBaixaCtpAnalitica : TfrmBaixaCtpAnalitica;
    frmCtpFormasPagamento: TfrmCtpFormasPagamento;
    frmBaixaSintetica : TfrmBaixaSintetica;
    strEmpSemAcesso: String;
    strListCodEmp: TStringList;
    
  function fRetFornecedorResumoCaixa: String;
    Var
      cdsGen: TUniClientDataSet;
  Begin
    {*******************************}
    {* VALIDA SE EXISTE DUPLICATAS *}
    {* COM FORNECEDORES DIFERENTES *}
    {****************************AN*}
    cdsGen := TUniClientDataSet.Create(Self);
    With cdsGen Do
    Begin
      Data := cdsCtaPag.Data;

      Filtered := False;
      Filter := 'CTP_MARDES = ' + QuotedStr('M');
      Filtered := True;
      First;

      Result := FieldByName('FOR_NOMFOR').AsString;
      If RecordCount > 1 Then
      Begin
        Filtered := False;
        Filter := 'CTP_MARDES = ' + QuotedStr('M') + ' AND FOR_NOMFOR <> ' + QuotedStr(Result);
        Filtered := True;

        If Not IsEmpty Then
          Result := 'FORNECEDORES DIVERSOS';
      End;
    End;
    FreeAndNil(cdsGen);
  End;

  function fValorChqEmiRateado(fltValPagEmi, fltTotalPago, fltValChq: Double): Double;
  Begin
    Result := (fltValPagEmi / fltTotalPago) * fltValChq;
  End;

  function fGravaMovBanSinteticoPorModalidade(strCodPor, strCodCta : String ; fltValor : Double; lstLogBan: TList<TLogBan>; dtaDtaLan: TDateTime = 0.0; strNumDoc: String = ''): String;
  Begin
    Result := fGravaMovBan( strCodCta,             // Centro de Custo
                            strCodPor,             // Portador da Baixa
                            strLoginUsuarioLogado, // Operador da Baixa
                            IIF(dtaDtaLan > 0.0, dtaDtaLan, StrToDate(strDtaLan)),  // Data do Lançamento
                            fTime(),               // Hora do Lançamento
                            IIF(Not fEmptyStr(strNumDoc), strNumDoc, strDocBai),             // Numero do Documento
                            strCreDeb,             // Credito / Debito
                            VS_strCodEmp,          // Empresa da Baixa
                            IIF(fltValor < 0,-fltValor,fltValor),              // Valor Do Lançamento
                            strHist01,             // Histórico 1
                            strHist02,             // Histórico 2
                            '',                    // Cliente da Duplicata
                            '',                    // Fornecedor da Duplicata
                            '',                    // Número da Duplicata
                            0,                     // Sequencial de Baixa
                            '',                    // Parcela da Duplicata
                            '',                    // Empresa da Duplicata
                            '',                    // Série
                            '',                    // Codigo do Evento
                            strDocBai,             // Documento da Baixa
                            lstLogBan,             // Log Bancário
                            0,
                            intCtpCon);

    recUltDupBaixada.strSeqLan := Result;
    recUltDupBaixada.strCodCta := strCodCta;
    recUltDupBaixada.strPagCon := IntToStr(intCtpCon);
    recUltDupBaixada.strPagCta := IntToStr(intCtpCon) + strCodCta;
  End;

  procedure pClonaDuplicatasMarcadas;
  Begin
    If Not Assigned(cdsClone) Then
      cdsClone := TUniClientDataSet.Create(Self);

    pCloneDataSet(cdsClone, cdsCtaPag);

    With cdsClone Do
    Begin
      Filtered := False;
      Filter := 'CTP_MARDES = '+ QuotedStr('M');
      Filtered := True;
    End;
  End;

begin

  strHisBaiSint := '';
  strHist01   := '';
  strHist02   := '';
  strForRep := '';
  strObsRep := '';
  fltDinRec := 0.0;
  fltChqVis := 0.0;
  fltOrdPag := 0.0;
  fltRepChq := 0.0;
  intSeqBai := 0;
  intCtpCon := 0;
  blnDepRep := False;
  fltJrDesm := 0;
  fltMulSujDesm := 0;

  blnBaiAna := fCfgSis('CTP_AS') = 'A';
  strSeqLan := '';
  strCtaBai := '';

  strNroDupCx := '';
  strParDupCx := '';
  intCountDup := 0;

  cdsRateio := fCriaCdsRateioPag(Self);

  Result      := False;
  blnConfirma := False;

  pClonaDuplicatasMarcadas;

  pRetDupSelecionadas(intDupCx, fltTotCx);

  {******************************************}
  {* DOCUMENTO A SER GRAVADO NO MOVBAN:     *}
  {* 1) DUPLICATA                           *}
  {* 2) DOCUMENTO DIGITADO (CHEQUE).        *}
  {***************************************MV*}
  strCpDcBa := fCfgSis('CPDCBA');

  //Limite de valor de lançamentos se a tela for chamada pela nova
  //tela de conciliação bancária
  if (fltValorBaixa > 0) and (strCodPorFix <> '') then
  begin
    fltValSel := 0;
    if edtTotalPago.Text <> '' then
       fltValSel := fStrToFloat(edtTotalPago.Text);

    if  RoundTo(fltValSel, -2) <> RoundTo(fltValorBaixa, -2) then
    begin
      pMensagemOk('Não é possível efetuar a baixa, o valor pago é diferente do valor para baixa.' + #13 + #13 +
                  'Valor para baixa: ' + FormatFloat('###,###,##0.00', fltValorBaixa) + #13 +
                  'Valor pago: ' + edtTotalPago.Text);
      Exit;
    end;
  end;

  //***************************************************//
  //* CASO NÃO VENHA DO RESUMO DE CAIXA, OU SE FOR    *//
  //* RESUMO DE CAIXA E A VARIÁVEL E A FUNÇÃO         *//
  //* fCfgSis('CTBPAG') FOR TRUE, ENTÃO, GRAVA MOVBAN *//
  //************************************************RL*//
  If (Not blnResumoCaixa) or ((blnResumoCaixa) and (fCfgSis('CTBPAG', varBoolean))) Then
  Begin
    If blnBaiAna Then
    Begin
      {******************************************}
      {* ...CHAMA A TELA DE BAIXA ANALÍTICA...  *}
      {***************************************MV*}
      Try
        pCriarFormularios(TfrmBaixaCtpAnalitica, frmBaixaCtpAnalitica);
        frmBaixaCtpAnalitica.blnResumoCaixa := blnResumoCaixa;
        frmBaixaCtpAnalitica.fltValPag := fltTotCx;
        frmBaixaCtpAnalitica.dtaDtaBai := dtaDtaPag;
        frmBaixaCtpAnalitica.cdsCtaPag := cdsCtaPag;
        frmBaixaCtpAnalitica.edtEmiCheque.Visible := Not blnResumoCaixa;
        frmBaixaCtpAnalitica.lblEmiCheque.Visible := Not blnResumoCaixa;

        frmBaixaCtpAnalitica.Position := poScreenCenter;

        If fCfgSis('CTPHIS') <> '3' Then
        Begin
          frmBaixaCtpAnalitica.edtHist02.Visible := False;
          frmBaixaCtpAnalitica.lblHist2.Visible := False;
        End;

        if strCodPorFix <> '' then
        begin
          frmBaixaCtpAnalitica.edtPorBai.Text := strCodPorFix;
          key := #13;
          frmBaixaCtpAnalitica.edtPorBaiKeyPress(nil, key);
          If Not strChamada.Equals('[frmCalculaComissaoProfissionais.btnConfirmaClick]') Then
            frmBaixaCtpAnalitica.edtPorBai.Enabled := False;
        end;

        frmBaixaCtpAnalitica.ShowModal;

        strPorBai   := frmBaixaCtpAnalitica.strPorBai;
        strDocBai   := frmBaixaCtpAnalitica.strDocBai;
        strCodBco   := frmBaixaCtpAnalitica.strCodBco;
        strNumAge   := frmBaixaCtpAnalitica.strNumAge;
        strNumChq   := frmBaixaCtpAnalitica.strNumChq;

        If fCfgSis('CTPHIS') <> '3' Then
        Begin
          //É assim mesmo hist1 no hist2
          strHist02 := frmBaixaCtpAnalitica.strHist01;
        End
        Else
        Begin
          strHist01 := frmBaixaCtpAnalitica.strHist01;
          strHist02 := frmBaixaCtpAnalitica.strHist02;
        End;

        If fEmptyStr(fTiraCaracEspeciais(frmBaixaCtpAnalitica.strDtaBom)) Then
          strDtaBom := ''
        Else
          strDtaBom := frmBaixaCtpAnalitica.strDtaBom;

        If fEmptyStr(fTiraCaracEspeciais(frmBaixaCtpAnalitica.strDtaEmi)) Then
          strDtaEmi := ''
        Else
          strDtaEmi := frmBaixaCtpAnalitica.strDtaEmi;

        strFavore   := frmBaixaCtpAnalitica.strFavore;
        strConCor   := frmBaixaCtpAnalitica.strConCor;
        blnConfirma := frmBaixaCtpAnalitica.blnConfirma;

        If ((Not fEmptyStr(strCodBco)) And
            (Not fEmptyStr(strNumAge)) And
            (Not fEmptyStr(strNumChq)) And
            (fStrToFloat(edtTotalPago.Text) <> 0.0)) Then
        Begin
          fltDinRec := 0;
          fltChqVis := frmBaixaCtpAnalitica.fltValPag;
        End;

      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[fBaixaDuplicatas]');
      End;

      pFreeAndNil(frmBaixaCtpAnalitica);
    End
    Else
    Begin
      {*****************************************}
      {* ...CASO SEJA SINTÉTICA, CHAMA TELA DE *}
      {* BAIXA SINTÉTICA, E ATRIBUI OS VALORES *}
      {* QUE SERÃO ATRIBUIDOS PARA TODAS AS    *}
      {* DUPLICATAS E PARA O ÚNICO MOVBAN      *}
      {**************************************MV*}
      Try
        pDisableControls(cdsCtaPag, prcScroll);
        pCriarFormularios(TfrmBaixaSintetica, frmBaixaSintetica);
        frmBaixaSintetica.blnVemCtr := False;

        frmBaixaSintetica.blnResumoCaixa := blnResumoCaixa;
        frmBaixaSintetica.blnCtaPag := True;

        frmBaixaSintetica.fltValPag := fltTotCx;
        frmBaixaSintetica.dtaDtaBai := dtaDtaPag;

        strCodFor := fRetornaFornecedor;
        frmBaixaSintetica.strCodFor := strCodFor;
        strCodEmp := fRetornaEmpresa;
        frmBaixaSintetica.strCodEmp := strCodEmp;
        frmBaixaSintetica.blnCadPag := Not blnResumoCaixa;
        frmBaixaSintetica.edtHisBai.Text := fRetornaFornecedorUnico;
        frmBaixaSintetica.cdsCadRec_VerificaData := cdsCtaPag;

        frmBaixaSintetica.Position := poScreenCenter;

        if (strCodPorFix <> '') and (fltValorBaixa <> 0) then
        begin
          frmBaixaSintetica.edtPorBai.Text := strCodPorFix;
          Key := #13;
          frmBaixaSintetica.edtPorBaiKeyPress(nil, Key);
          frmBaixaSintetica.edtPorBai.Enabled := false;
          frmBaixaSintetica.dtaDtaBai      :=  dteDtaPagFix;
          frmBaixaSintetica.mskDtaLan.Text :=  DateToStr(dteDtaPagFix);
          frmBaixaSintetica.mskDtaLan.Enabled := false;
        end;

        If blnBaixaZeradaCTP Then
        Begin
          frmBaixaSintetica.blnBaixaZeradaCTP := True;
          frmBaixaSintetica.edtPorBai.Text    := strPortadorBaixaZeradaCTP;
          frmBaixaSintetica.edtPorBai.Enabled := True;
        End;

        frmBaixaSintetica.ShowModal;

        strCtaBai   := frmBaixaSintetica.strCtaBai;
        strPorBai   := frmBaixaSintetica.strPorBai;
        strDtaLan   := frmBaixaSintetica.strDtaLan;
        strDocBai   := frmBaixaSintetica.strDocBai;
        strHist01   := frmBaixaSintetica.strHisBai;
        strHist02   := frmBaixaSintetica.strHist02;
        strCodBco   := frmBaixaSintetica.strCodBco;
        strNumAge   := frmBaixaSintetica.strNumAge;
        strNumChq   := frmBaixaSintetica.strNumChq;
        pEnableControls(cdsCtaPag, prcScroll, True);

        If fEmptyStr(fTiraCaracEspeciais(frmBaixaSintetica.strDtaBom)) Then
          strDtaBom := ''
        Else
          strDtaBom := frmBaixaSintetica.strDtaBom;

        If fEmptyStr(fTiraCaracEspeciais(frmBaixaSintetica.strDtaEmi)) Then
          strDtaEmi := ''
        Else
          strDtaEmi := frmBaixaSintetica.strDtaEmi;

        strFavore   := frmBaixaSintetica.strFavore;
        strConCor   := frmBaixaSintetica.strConCor;
        strCodFor   := frmBaixaSintetica.strCodFor;
        blnConfirma := frmBaixaSintetica.blnConfirma;

      Except
        On E: Exception Do
        Begin
          blnConfirma := False;
          pMensagensErro(E.Message, '[frmBaixaCtaPagar.fBaixaDuplicatas]');
        End;
      End;

      pFreeAndNil(frmBaixaSintetica);

    End;
  End
  Else
  Begin
    If blnResumoCaixa And (fEmptyStr(fCfgSis('PORPGR')) Or fEmptyStr(fCfgSis('CTAGCP'))) Then
    Begin
      pMensagemOK('As configurações "CFG_PORPGR - Portador para Pagamento (PG) / Baixa de Contas a pagar no caixa (F9)" e ' +
                  '"CFG_CTAGCP - Plano de Contas para Baixa de Contas a pagar no caixa (F9)" devem estar preenchidas para ' +
                  'realizar essa baixa.');
      blnConfirma := False;
    End
    Else
      blnConfirma := True;

    If blnResumoCaixa And blnConfirma Then
    Begin
      strPorBai := fCfgSis('PORPGR');
      strCtaBai := fCfgSis('CTAGCP');
    End;
  End;

  {*****************************************}
  {* CASO CANCELAR, SAI                    *}
  {**************************************MV*}
  If Not blnConfirma Then
    Exit;

  {*REQ*145940**********RP*}
  If Not fEmptyStr(strPorBai) Then
  Begin
    If Not fEmpresasTemAcessoPortador(strPorBai, cdsCtaPag, 'CTP_CODEMP', strEmpSemAcesso, 'CTP_MARDES = '+ QuotedStr('M')) Then
    Begin
      fMensagem('ATENÇÃO!', Format('Empresa(s) sem acesso ao cadastro do Portador informado (%s): %s. Operação abortada!', [strPorBai, strEmpSemAcesso]), ['&OK']);
      pSetFocus(dbgDuplicatas);
      Exit;
    End;
  End;

  If (Not blnBaiAna) Or (blnResumoCaixa) Then
  Begin
    If Assigned(dicChqEmi) Then FreeAndNil(dicChqEmi);
    If Assigned(dicChqRep) Then FreeAndNil(dicChqRep);

    dicChqEmi := TDictionary<String,TChequeEmitido>.Create;
    dicChqRep := TDictionary<String,TChequeRepassado>.Create;

    Try
      pCriarFormularios(TfrmCtpFormasPagamento, frmCtpFormasPagamento);

      If blnResumoCaixa Or (fStrToFloat(edtTotalPago.Text) < 0) Then
      Begin
        frmCtpFormasPagamento.Height := 175;

        frmCtpFormasPagamento.lblChqVista.Visible     := False;
        frmCtpFormasPagamento.edtChqVista.Visible     := False;
        frmCtpFormasPagamento.btnAltValChqEmi.Visible := False;
        frmCtpFormasPagamento.lblPorBaiChV.Visible    := False;
        frmCtpFormasPagamento.edtPorBaiChV.Visible    := False;
        frmCtpFormasPagamento.edtDesPorChV.Visible    := False;

        frmCtpFormasPagamento.lblOrdPag.Visible := False;
        frmCtpFormasPagamento.lblRepChq.Visible := False;
        frmCtpFormasPagamento.edtOrdPag.Visible := False;
        frmCtpFormasPagamento.edtRepChq.Visible := False;
        frmCtpFormasPagamento.btnSelChAvi.Visible := False;

        frmCtpFormasPagamento.lblPorBaiOrd.Visible := False;
        frmCtpFormasPagamento.edtPorBaiOrd.Visible := False;
        frmCtpFormasPagamento.edtDesPorOrd.Visible := False;

        frmCtpFormasPagamento.lblPorBaiRep.Visible := False;
        frmCtpFormasPagamento.edtPorBaiRep.Visible := False;
        frmCtpFormasPagamento.edtDesPorRep.Visible := False;

        If blnResumoCaixa Then
        Begin
          frmCtpFormasPagamento.edtPorBaiDin.Text := strPorBai;
          frmCtpFormasPagamento.edtDesPorDin.Text := fRetNomPortador(strPorBai);

          if blnBaiAna Then
          begin
            frmCtpFormasPagamento.edtPorBaiDin.Enabled := False;
            frmCtpFormasPagamento.edtDinheiro.Enabled  := True;
          end;
        End;
      End;

      frmCtpFormasPagamento.Position := poScreenCenter;
      cdsCloneCtaPag := TUniClientDataSet.Create(Self);
      pCloneDataSet(cdsCloneCtaPag, cdsCtaPag);
      pProcessaCloneCtaPag(cdsCloneCtaPag);

      frmCtpFormasPagamento.strCodPorFix := strCodPorFix;

      frmCtpFormasPagamento.dicChqEmi := dicChqEmi;
      frmCtpFormasPagamento.dicChqRep := dicChqRep;
      frmCtpFormasPagamento.strDtaLan := strDtaLan;
      frmCtpFormasPagamento.cdsCloneCtaPag := cdsCloneCtaPag;
      frmCtpFormasPagamento.fltValTot := fStrToFloat(edtTotalPago.Text);
      frmCtpFormasPagamento.lstFornecedor := fGetLstFornecedor;


      If (fStrToFloat(edtTotalPago.Text) <> 0) Then
        blnConfirma := (frmCtpFormasPagamento.ShowModal = mrOk)
      Else
        blnConfirma := True;

      FreeAndNil(cdsCloneCtaPag);

      If (blnConfirma) Then
      Begin
        fltDinRec := frmCtpFormasPagamento.fltDinhei;
        fltChqVis := frmCtpFormasPagamento.fltChqEmi;
        fltOrdPag := frmCtpFormasPagamento.fltOrdPag;
        fltRepChq := frmCtpFormasPagamento.fltRepChq;

        strPorDin := frmCtpFormasPagamento.edtPorBaiDin.Text;
        strPorChV := frmCtpFormasPagamento.edtPorBaiChV.Text;
        strPorOrd := frmCtpFormasPagamento.edtPorBaiOrd.Text;
        strPorRep := frmCtpFormasPagamento.edtPorBaiRep.Text;

        strForRep := frmCtpFormasPagamento.strForRep;
        strObsRep := frmCtpFormasPagamento.strObsRep;

        {*REQ*145940**********RP*}
        cdsCtaPag.Filtered := False;
        cdsCtaPag.Filter   := 'CTP_MARDES = '+ QuotedStr('M');
        cdsCtaPag.Filtered := True;

        strListCodEmp := fDatasetDistinctField(cdsCtaPag, 'CTP_CODEMP');

        cdsCtaPag.Filtered := False;

        If Not fEmptyStr(strPorDin) Then
        Begin
          If Not fEmpresasTemAcessoPortador(strPorDin, strListCodEmp, strEmpSemAcesso) Then
          Begin
            fMensagem('ATENÇÃO!', Format('Empresa(s) sem acesso ao cadastro do [Portador Dinheiro] informado (%s): %s. Operação abortada!', [strPorDin, strEmpSemAcesso]), ['&OK']);
            pSetFocus(dbgDuplicatas);
            strListCodEmp.Free;
            Exit;
          End;
        End;

        If Not fEmptyStr(strPorChV) Then
        Begin
          If Not fEmpresasTemAcessoPortador(strPorChV, strListCodEmp, strEmpSemAcesso) Then
          Begin
            fMensagem('ATENÇÃO!', Format('Empresa(s) sem acesso ao cadastro do [Portador Cheque] informado (%s): %s. Operação abortada!', [strPorChV, strEmpSemAcesso]), ['&OK']);
            pSetFocus(dbgDuplicatas);
            strListCodEmp.Free;
            Exit;
          End;
        End;

        If Not fEmptyStr(strPorOrd) Then
        Begin
          If Not fEmpresasTemAcessoPortador(strPorOrd, strListCodEmp, strEmpSemAcesso) Then
          Begin
            fMensagem('ATENÇÃO!', Format('Empresa(s) sem acesso ao cadastro do [Portador Depósito] informado (%s): %s. Operação abortada!', [strPorOrd, strEmpSemAcesso]), ['&OK']);
            pSetFocus(dbgDuplicatas);
            strListCodEmp.Free;
            Exit;
          End;
        End;

        If Not fEmptyStr(strPorRep) Then
        Begin
          If Not fEmpresasTemAcessoPortador(strPorRep, strListCodEmp, strEmpSemAcesso) Then
          Begin
            fMensagem('ATENÇÃO!', Format('Empresa(s) sem acesso ao cadastro do [Portador Cheque Terceiros] informado (%s): %s. Operação abortada!', [strPorRep, strEmpSemAcesso]), ['&OK']);
            pSetFocus(dbgDuplicatas);
            strListCodEmp.Free;
            Exit;
          End;
        End;

        strListCodEmp.Free;
        {************************}
      End
      Else
      Begin
        pDestravaCheques;
      End;
    Except
      On E: Exception Do
      Begin
        blnConfirma := False;
        pMensagensErro(E.Message, '[frmBaixaCtaPagar.fBaixaDuplicatas_1]');
      End;
    End;
    pFreeAndNil(frmCtpFormasPagamento);

  End;

  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fVerificacoesParaBaixa;
  frmGravando.lblGravando.Caption := 'Aguarde... Verificando Títulos.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);

  If Not blnResult Then
    Exit;

  {*****************************************}
  {* CASO CANCELAR, SAI                    *}
  {**************************************MV*}
  If Not blnConfirma Then
    Exit;

  {***********************************************************}
  {* TIREI ESSE BLOCO DA TRANSAÇÃO PORQUE AGORA SEMPRE GRAVA *}
  {* CHEQUE EMITIDO, TANTO NA BAIXA QUANTO NO F11            *}
  {*18/07/2014*********************************************JU*}

  If blnNaoBai then
  Begin

    With cdsCtaPag Do
    Begin
      DisableControls;
      Filtered := False;
      Filter   := 'CTP_MARDES = '+ QuotedStr('M');

      strCampoFiltro := 'CTP_MARDES';
      strValorFiltro := 'M';

      Filtered := True;

      If Not IsEmpty Then
      Begin
        First;
        While Not Eof Do
        Begin

          {**********************************************}
          {* GRAVA OS CHEQUES EMITIDOS SE ESTÁ NA BAIXA *}
          {*******************************************AC*}
          If (Not fEmptyStr(strCodBco))                                           And
             (Not fEmptyStr(strNumAge))                                           And
             (Not fEmptyStr(strNumChq)                                            And
             (fStrToFloat(edtTotalPago.Text) <> 0.0))                             And
             (Not fVerificaChqExiste(strCodBco, strNumAge, strConCor, strNumChq)) Then
          Begin
            If Not fGravaChequeEmitido( strCodBco,                           //Codigo do Banco
                                        strNumAge,                           //Numero da Agencia
                                        strNumChq,                           //Numero do Cheque
                                        FieldByName('CTP_CODFOR').AsString,  //Codigo do Fornecedor
                                        FieldByName('NRODUP').AsString,      //Numero da Duplicata
                                        FieldByName('PARDUP').AsString,      //Parcela da Duplicata
                                        FieldByName('CTP_SERIE_').AsString,  //Série
                                        FieldByName('CTP_CODEMP').AsString,  //Codigo da Empresa
                                        intSeqBai,                           //Sequencial da Baixa
                                        strLoginUsuarioLogado,               //Operador da Baixa
                                        VS_Date,                             //Data Baixa
                                        FieldByName('CTP_VALPAG').AsFloat,   //Valor do Lancamento
                                        'A',                                 //Analitico ou Sintetico
                                        FieldByName('CTP_NUMDUP').AsString,  //Numero do Documento
                                        strHist01,                           //Histórico 1
                                        strConCor,                           //Conta Corrente
                                        strDtaBom,                           //Bom Para
                                        strFavore,                           //Favorecido
                                        strDtaEmi,                           //Data de Emissão
                                        strPorBai) Then                      //Portador

            Begin
              EnableControls;
              Exit;
            End
            Else
            Begin
              {******************************************************}
              {* ATUALIZA A TABELA DE CHEQUES EMITIDOS DO PORTADOR  *}
              {***************************************************RN*}
              pGravaNumChqSequencialPortador(strPorBai,                                // Portador
                                             VS_strCodEmp,                             // Código Empresa
                                             strNumAge,                                // Numero Agência
                                             strCodBco,                                // Código Banco
                                             strConCor,                                // Conta Corrente
                                             strNumChq);                               // Numero do Cheque

            End;
          End;

          Next;
        End;
      End;


      Filter   := '';
      Filtered := False;
      EnableControls;

    End;

  End;

  {***************************************************************}
  {* CASO O VALOR TOTAL DAS DUPLICATAS FOREM 0, NÃO GRAVA SEQCON *}
  {************************************************************MO*}
  If RoundTo(fltTotCx, -2) = 0 Then
  Begin
    intSeqCon := 0;
  End
  Else
  Begin
    intSeqCon := StrToInt(fRetRcxCon);
  End;

  If (Assigned(dicChqRep)) And (dicChqRep.Count > 0) Then
    intSeqRCH := fRetSeqRCH
  Else
    intSeqRCH := 0;

  FImprimeBordero                    := False;
  FExibeHistoricoBordero             := False;
  FExibeDetalhamentoPagamentoBordero := False;
  If fCfgSis('CTPBOR', varBoolean) Then
  begin
    if Not blnNaoBai then
      FImprimeBordero := fMensagem('', 'Deseja imprimir borderô para pagamentos?', ['&Sim', '&Não']) = 1;

    if ((Not blnNaoBai) and (FImprimeBordero)) or
      (blnNaoBai) then
    begin
      FExibeHistoricoBordero             := (fMensagem('ATENÇÃO', 'Deseja Exibir o Histórico no Borderô?', ['&Sim', '&Não'], 2) = 1);
      FExibeDetalhamentoPagamentoBordero := (fMensagem('ATENÇÃO', 'Deseja Exibir o Detalhamento do(s) Pagamento(s)?', ['&Sim', '&Não'], 2) = 1);

      if fMensagem('','Saída',['&Video','&Imprimir']) = 1 Then
        FSaidaDaImpressa := tsiVideo
      else
        FSaidaDaImpressa := tsiImpressao;
    end;
  end;

  fStartTransaction;

  lstBanCtp := TBanCtpRepository.Create;
  lstBanChq := TBanChqRepository.Create;
  dicChqCtp := TDictionary<String,TCtpInfo>.Create;

  Try
    Try
      intCtpCx := 0;
      stlSeqCon.Clear;

      fAtualizaPorBai;

      With cdsCtaPag Do
      Begin
        DisableControls;
        First;
        While Not Eof Do
        Begin
          If FieldByName('CTP_MARDES').AsString = 'M' Then
          Begin

            If intCtpCx = 0 Then
            Begin
              intCtpCx := fRetCtpCon;
              stlSeqCon.Add(VS_strCodEmp + FieldByName('CTP_CODEMP').AsString  + IntToStr(intCtpCx));
            End;

            intCtpCon := intCtpCx;

            {**Req. 97805**23/04/2018**WS**}
            strNroDupCx := FieldByName('NRODUP').AsString;
            strParDupCx := FieldByName('PARDUP').AsString;
            Inc(intCountDup);

            intSeqBai := fRetSeqBaicadPag(FieldByName('NRODUP').AsString,
                                          FieldByName('PARDUP').AsString,
                                          FieldByName('CTP_CODEMP').AsString,
                                          FieldByName('CTP_CODFOR').AsString,
                                          FieldByName('CTP_SERIE_').AsString);

            If FieldByName('CTP_TIPBAI').AsString = 'P' Then
              Inc(intSeqBai)

            Else If FieldByName('CTP_TIPBAI').AsString = 'T' Then
              intSeqBai := 0;

            {*************************************************************}
            {* MUDOU NOVAMENTE, AGORA ANALÍTICO É DIFERENTE DE SINTETICO *}
            {*23/07/2015**************************************************}
            {***********************************************************}
            {* TIREI ESSE BLOCO DA VERIFICAÇÃO (ANALÍTICO-SINTÉTICO  ) *}
            {* PORQUE COMO CONVERSEI COM O RONALDO CADA CHEQUE EMITIDO *}
            {* DEVE TER PELO MENOS UM REGISTRO VINCULADO NO CADPAG(X)  *}
            {*18/07/2014*********************************************JU*}
            {**********************************************}
            {* GRAVA OS CHEQUES EMITIDOS SE ESTÁ NA BAIXA *}
            {*******************************************AC*}
            If blnBaiAna Then
            Begin
              If (Not fEmptyStr(strCodBco))                                           And
                 (Not fEmptyStr(strNumAge))                                           And
                 (Not fEmptyStr(strNumChq)                                            And
                 (fStrToFloat(edtTotalPago.Text) <> 0.0))                             And
                 (Not fVerificaChqExiste(strCodBco, strNumAge, strConCor, strNumChq)) Then
              Begin
                If Not fGravaChequeEmitido( strCodBco,                           //Codigo do Banco
                                            strNumAge,                           //Numero da Agencia
                                            strNumChq,                           //Numero do Cheque
                                            FieldByName('CTP_CODFOR').AsString,  //Codigo do Fornecedor
                                            FieldByName('NRODUP').AsString,      //Numero da Duplicata
                                            FieldByName('PARDUP').AsString,      //Parcela da Duplicata
                                            FieldByName('CTP_SERIE_').AsString,  //Série
                                            FieldByName('CTP_CODEMP').AsString,  //Codigo da Empresa
                                            intSeqBai,                           //Sequencial da Baixa
                                            strLoginUsuarioLogado,               //Operador da Baixa
                                            VS_Date,                             //Data Baixa
                                            FieldByName('CTP_VALPAG').AsFloat,   //Valor do Lancamento
                                            'A',                                 //Analitico ou Sintetico
                                            FieldByName('CTP_NUMDUP').AsString,  //Numero do Documento
                                            strHist01,                           //Histórico 1
                                            strConCor,                           //Conta Corrente
                                            strDtaBom,                           //Bom Para
                                            strFavore,                           //Favorecido
                                            strDtaEmi,                           //Data de Emissão
                                            strPorBai) Then                      //Portador

                Begin
                  EnableControls;
                  fRollBack;
                  Exit;
                End
                Else
                Begin
                  {******************************************************}
                  {* ATUALIZA A TABELA DE CHEQUES EMITIDOS DO PORTADOR  *}
                  {***************************************************RN*}
                  pGravaNumChqSequencialPortador(strPorBai,                                // Portador
                                                 VS_strCodEmp,                             // Código Empresa
                                                 strNumAge,                                // Numero Agência
                                                 strCodBco,                                // Código Banco
                                                 strConCor,                                // Conta Corrente
                                                 strNumChq);                               // Numero do Cheque

                End;
              End;

            End
            Else
            Begin
              // Baixa Sintética: Adiciona Duplicatas
              lstBanCtp.fAdd(FieldByName('NRODUP').AsString,
                             FieldByName('PARDUP').AsString,
                             FieldByName('CTP_SERIE_').AsString,
                             FieldByName('CTP_CODEMP').AsString,
                             FieldByName('CTP_CODFOR').AsString,
                             FieldByName('CTP_HIST01').AsString,
                             FieldByName('CTP_HIST02').AsString,
                             FieldByName('CTP_CODCTA').AsString,
                             VS_strCodEmp,
                             FieldByName('CTP_SEQBAI').AsInteger,
                             FieldByName('CTP_VALPAG').AsFloat,
                             fltDinRec,
                             fltChqVis,
                             fltRepChq,
                             fltOrdPag,
                             FieldByName('CTP_VALJUR').AsFloat,
                             FieldByName('CTP_VALMUL').AsFloat,
                             FieldByName('CTP_VALDES').AsFloat,
                             FieldByName('CTP_VALDUP').AsFloat);

              If (Assigned(dicChqEmi)) And (dicChqEmi.Count > 0) Then
              Begin

                keyArray :=  fOrdenaDictionaryKey(dicChqEmi);

                For strChave In keyArray Do
                Begin
                  recCtpInfo.strCodFor := FieldByName('CTP_CODFOR').AsString;
                  recCtpInfo.strHist01 := FieldByName('CTP_HIST01').AsString;
                  recCtpInfo.strHist02 := FieldByName('CTP_HIST02').AsString;

                  If Not fGravaChequeEmitido(dicChqEmi[strChave].strCodBco,       //Codigo do Banco
                                             dicChqEmi[strChave].strNumAge,       //Numero da Agencia
                                             dicChqEmi[strChave].strNumChq,       //Numero do Cheque
                                             FieldByName('CTP_CODFOR').AsString,  //Codigo do Fornecedor
                                             FieldByName('NRODUP').AsString,      //Numero da Duplicata
                                             FieldByName('PARDUP').AsString,      //Parcela da Duplicata
                                             FieldByName('CTP_SERIE_').AsString,  // Série
                                             FieldByName('CTP_CODEMP').AsString,  //Codigo da Empresa
                                             intSeqBai,                           //Sequencial da Baixa
                                             strLoginUsuarioLogado,               //Operador da Baixa
                                             FieldByName('CTP_DTAPAG').AsDateTime,//Data Baixa
                                             fValorChqEmiRateado(FieldByName('CTP_VALPAG').AsFloat, fStrToFloat(edtTotalPago.Text), dicChqEmi[strChave].fltValChq), //Valor do Lancamento
                                             'A',                                 //Analitico ou Sintetico
                                             FieldByName('CTP_NUMDUP').AsString,  //Numero do Documento
                                             strHist01,                           //Histórico 1
                                             dicChqEmi[strChave].strConCor,       //Conta Corrente
                                             dicChqEmi[strChave].strDtaBom,       //Bom Para
                                             dicChqEmi[strChave].strFavore,       //Favorecido
                                             dicChqEmi[strChave].strDtaEmi,       //Data de Emissão
                                             strPorChV) Then                      //Portador
                  Begin
                    EnableControls;
                    fRollBack;
                    Exit;
                  End
                  Else
                  Begin
                    {******************************************************}
                    {* ATUALIZA A TABELA DE CHEQUES EMITIDOS DO PORTADOR  *}
                    {***************************************************RN*}
                    pGravaNumChqSequencialPortador(strPorChV,                      // Portador
                                                   VS_strCodEmp,                   // Código Empresa
                                                   dicChqEmi[strChave].strNumAge,  // Numero Agência
                                                   dicChqEmi[strChave].strCodBco,  // Código Banco
                                                   dicChqEmi[strChave].strConCor,  // Conta Corrente
                                                   dicChqEmi[strChave].strNumChq); // Numero do Cheque

                  End;

                End;
              End;

              If (Assigned(dicChqRep)) And (dicChqRep.Count > 0) And (Not blnDepRep) Then
              Begin

                For strChave In dicChqRep.Keys Do
                Begin
                  recCtpInfo.strCodFor := FieldByName('CTP_CODFOR').AsString;
                  recCtpInfo.strHist01 := FieldByName('CTP_HIST01').AsString;
                  recCtpInfo.strHist02 := FieldByName('CTP_HIST02').AsString;

                  dicChqCtp.AddOrSetValue(dicChqRep[strChave].strCodBco+
                                          dicChqRep[strChave].strNumAge+
                                          dicChqRep[strChave].strConCor+
                                          dicChqRep[strChave].strNumChq,
                                          recCtpInfo);

                  pRepassaCheque(dicChqRep[strChave].strCodBco,
                                 dicChqRep[strChave].strNumAge,
                                 dicChqRep[strChave].strConCor,
                                 dicChqRep[strChave].strNumChq,
                                 VS_strCodEmp,
                                 strForRep,
                                 StrToDate(strDtaLan),
                                 strObsRep,
                                 intSeqRCH);

                  pDepositaCheque(dicChqRep[strChave].strCodBco,
                                  dicChqRep[strChave].strNumAge,
                                  dicChqRep[strChave].strConCor,
                                  dicChqRep[strChave].strNumChq,
                                  VS_strCodEmp,
                                  dicChqRep[strChave].strCtaDep,
                                  StrToDate(strDtaLan),
                                  '',
                                  strPorRep,
                                  strCtaBai,
                                  dicChqRep[strChave].strHistor,
                                  strPorRep,
                                  strCtaBai,
                                  0,
                                  strSeqDep);

                  repCadChq := TCadChqRepository.Create;
                  repCadChq.pGravaLog(dicChqRep[strChave].strCodBco, dicChqRep[strChave].strNumAge,
                                      dicChqRep[strChave].strConCor, dicChqRep[strChave].strNumChq,
                                      'BAIXA REPASSE (frmBaixaCtaPagar.fBaixaDuplicatas)');

                  FreeAndNil(repCadChq);
                End;
                blnDepRep := True;
              End;
            End;

            {*****************************************}
            {* ...GRAVANDO O MOVBAN CASO SEJA GRAVA- *}
            {* ÇÃO ANALÍTICA OU...                   *}
            {**************************************MV*}
            If blnBaiAna Or blnBaixaZeradaCTP Then
            Begin

              strCtaBai := IIF(blnBaiAna,FieldByName('CTP_CODCTA').AsString,strCtaBai);

              If fCfgSis('CTPHIS') = '2' Then
                strHist01 := AnsiReplaceStr(FieldByName('CTP_HIST01').AsString,'<<csq>>',' ')

              Else If fCfgSis('CTPHIS') = '1' Then
              Begin
                strHist01 := 'Pag. ' +
                              FieldByName('CTP_CODFOR').AsString + ' - ' +
                              FieldByName('FOR_NOMFOR').AsString;
              End;

              If FieldByName('CTP_VALPAG').AsFloat < 0 Then
                strCreDeb := 'C'
              Else
                strCreDeb := 'D';

               fltValRec := FieldByName('CTP_VALPAG').AsFloat;

              {***********************************}
              {* LOCALIZA AS CONTAS DESMEMBRADAS *}
              {********************************LU*}
              strSQL := '';
              strSQL := ' SELECT ';
              strSQL := strSQL + '   * ';
              strSQL := strSQL + ' FROM ';
              strSQL := strSQL + '   CTPDET ';
              strSQL := strSQL + ' WHERE ';
              strSQL := strSQL + '   CTP_NUMDUP = ' + QuotedStr(FieldByName('NRODUP').AsString) + ' AND ';
              strSQL := strSQL + '   CTP_PARCEL = ' + QuotedStr(FieldByName('PARDUP').AsString) + ' AND ';
              strSQL := strSQL + '   CTP_CODFOR = ' + QuotedStr(FieldByName('CTP_CODFOR').AsString) + ' AND ';
              strSQL := strSQL + '   CTP_EMPORI = ' + QuotedStr(FieldByName('CTP_CODEMP').AsString) + ' AND ';
              strSQL := strSQL + '   IFNULL(CTP_SERIE_,"") = ' + QuotedStr(FieldByName('CTP_SERIE_').AsString);// + ' AND ';

              qryGen := fCriaQuery(Self);
              qryGen.Close;
              qryGen.SQL.Add(strSQL);
              qryGen.Open;

              {*******************************************}
              {* CASO TENHA CTPDET(DESMENBRAMENTO), GRAVA*}
              {* O MOVBAN DESMEMBRADO. CASO CONTRÁRIA,   *}
              {* GRAVA O MOVBAN SIMPLES.                 *}
              {***24/04/2008***************************MV*}
              If (Not qryGen.IsEmpty) And (not blnGravaMovBanSemDesmembrar) And
                 (blnBaiAna) Then
              Begin
                fltTotDesm := 0;
                While Not qryGen.Eof Do
                Begin
                  intSeqBai := fRetSeqBaiCadPag(FieldByName('NRODUP').AsString,
                                                FieldByName('PARDUP').AsString,
                                                FieldByName('CTP_CODEMP').AsString,
                                                FieldByName('CTP_CODFOR').AsString,
                                                FieldByName('CTP_SERIE_').AsString);

                  If FieldByName('CTP_TIPBAI').AsString = 'P' Then
                  Begin
                    Inc(intSeqBai);
                  End
                  Else If FieldByName('CTP_TIPBAI').AsString = 'T' Then
                  Begin
                    intSeqBai := 0;
                  End;

                  {*************************************************}
                  {* SÓ VAI GRAVAR MOVBAN DA BAIXA EM 3 SITUAÇÕES: *}
                  {* 1ª: SE A BAIXA NÃO FOR PELO RESUMO DE CAIXA E *}
                  {*     O VALOR PAGO FOR DIFERENTE DE ZERO        *}
                  {* 2ª: SE A BAIXA NÃO FOR PELO RESUMO DE CAIXA,  *}
                  {*     A BAIXA FOR ANALÍTICA, A QUANTIDADE DE    *}
                  {*     DOCUMENTOS SELECIONADOS FOR MAIOR QUE 1 E *}
                  {*     A SOMA DO PAGAMENTO FOR IGUAL A ZERO      *}
                  {* 3ª: SE A BAIXA FOR PELO RESUMO DE CAIXA E A   *}
                  {*     CONFIGURAÇÃO "CTBPAG" ESTIVER COMO SIM.   *}
                  {*************************************KP-117882***}
                  If ((Not blnResumoCaixa) And (fStrToFloat(edtTotalPago.Text) <> 0.0)) or
                     ((Not blnResumoCaixa) And (fStrToFloat(edtTotalPago.Text)  = 0.0) And (blnBaiAna) And (StrToIntDef(edtQtdSelecionadas.Text, 0) > 1)) Or
                     ((blnResumoCaixa)     And (fCfgSis('CTBPAG', varBoolean))) Then
                  Begin
                    fltVlDesm := fltValRec * qryGen.fieldbyname('CTP_FATCAL').AsFloat;

                    If qryGen.FieldByName('CTP_DEBCRE').AsString.Equals('D') Then
                       fltVlDesm := (fltVlDesm * -1);

                    fltVlDesm := fFormataFloat(fltVlDesm, 2);

                    fltTotDesm := fltTotDesm +  fltVlDesm;
                    if qryGen.RecNo = qryGen.RecordCount then
                    begin
                      if fltTotDesm <> fltValRec then
                         fltVlDesm := fltValRec - (fltTotDesm-fltVlDesm);
                    end;

                    If FieldByName('CTP_VALJUR').Value > 0 Then
                    Begin
                      fltJrDesm := fltJrDesm * qryGen.fieldbyname('CTP_FATCAL').AsFloat;

                      If qryGen.FieldByName('CTP_DEBCRE').AsString.Equals('D') Then
                        fltJrDesm := (fltJrDesm * -1);
                    End
                    Else
                      fltJrDesm := 0;

                    If FieldByName('CTP_VALMUL').Value > 0 Then
                    Begin
                      fltMulSujDesm := fltMulSujDesm * qryGen.fieldbyname('CTP_FATCAL').AsFloat;

                      If qryGen.FieldByName('CTP_DEBCRE').AsString.Equals('D') Then
                        fltMulSujDesm := (fltMulSujDesm * -1);
                    End
                    Else
                      fltMulSujDesm := 0;

                    If FieldByName('CTP_VALDES').Value > 0 Then
                    Begin
                      fltDsDesm := fltJrDesm * qryGen.fieldbyname('CTP_FATCAL').AsFloat;

                      If qryGen.FieldByName('CTP_DEBCRE').AsString.Equals('D') Then
                        fltDsDesm := (fltDsDesm * -1);
                    End
                    Else
                      fltDsDesm := 0;

                    If (fltVlDesm < 0) Then
                    Begin
                      fltVlDesm := fltVlDesm * -1;
                        strCreDeb := 'C';
                    End
                    Else
                      strCreDeb := 'D';

                    If fltVlDesm > 0 Then
                    Begin
                      lstBanCtp.pClear;
                      lstBanCtp.fAdd(qryGen.FieldByName('CTP_NUMDUP').AsString,
                                     qryGen.FieldByName('CTP_PARCEL').AsString,
                                     qryGen.FieldByName('CTP_SERIE_').AsString,
                                     qryGen.FieldByName('CTP_EMPORI').AsString,
                                     qryGen.FieldByName('CTP_CODFOR').AsString,
                                     FieldByName('CTP_HIST01').AsString,
                                     FieldByName('CTP_HIST02').AsString,
                                     qryGen.FieldByName('CTP_CODCTA').AsString,
                                     VS_strCodEmp,
                                     intSeqBai,
                                     IIF(strCreDeb.EQuals('C'), -fltVlDesm,fltVlDesm),
                                     0,
                                     0,
                                     0,
                                     0,
                                     fltJrDesm,
                                     fltMulSujDesm,
                                     fltDsDesm,
                                     IIF(strCreDeb.Equals('C'), -fltVlDesm,fltVlDesm));

                      strSeqLan := fGravaMovBan(qryGen.fieldbyname('CTP_CODCTA').AsString,// Centro de Custo
                                                strPorBai,                                // Portador da Baixa
                                                strLoginUsuarioLogado,                    // Operador da Baixa
                                                FieldByName('CTP_DTAPAG').AsDateTime,     // Data do Lançamento
                                                fTime(),                                  // Hora do Lançamento

                                                IIF(strCpDcBa = '1',
                                                    FieldByName('NRODUP').AsString,       // Numero do Documento
                                                    strDocBai),

                                                strCreDeb,                                // Credito / Debito
                                                VS_strCodEmp,                             // Empresa da Baixa
                                                fltVlDesm,                                // Valor Do Lançamento
                                                strHist01,                                // Histórico 1
                                                strHist02,                                // Histórico 2
                                                '',                                       // Cliente da Duplicata
                                                FieldByName('CTP_CODFOR').AsString,       // Fornecedor da Duplicata
                                                FieldByName('NRODUP').AsString,           // Número da Duplicata
                                                intSeqBai,                                // Sequencial de Baixa
                                                FieldByName('PARDUP').AsString,           // Parcela da Duplicata
                                                qryGen.FieldByName('CTP_CODEMP').AsString, // Empresa da Duplicata
                                                FieldByName('CTP_SERIE_').AsString,       // Série
                                                IIF(fEmptyStr(qryGen.FieldByName('CTP_CODEVE').AsString),FieldByName('CTP_CODEVE').AsString,
                                                                                                  qryGen.FieldByName('CTP_CODEVE').AsString),// Codigo do Evento
                                                strDocBai,                                // Documento da Baixa
                                                lstBanCtp.fGetList,                       // Log Bancário
                                                0,
                                                intCtpCon,
                                                FieldByName('CTP_COMPET').AsString,
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                1,
                                                True,
                                                nil,
                                                '',
                                                'S',
                                                '',
                                                FieldByName('CTP_PAGANT').AsString = 'S');

                      recUltDupBaixada.strSeqLan := strSeqLan;
                      recUltDupBaixada.strCodCta := qryGen.FieldByName('CTP_CODCTA').AsString;
                      recUltDupBaixada.strPagCon := IntToStr(intCtpCon);
                      recUltDupBaixada.strPagCta := IntToStr(intCtpCon) + qryGen.FieldByName('CTP_CODCTA').AsString;

                      If (fEmptyStr(strSeqLan)) Then
                      Begin
                        EnableControls;
                        FreeAndNil(qryGen);
                        fRollBack;
                        Exit;
                      End;

                      if (fltValorBaixa <> 0) and (strCodPorFix <> '') then
                      begin
                        SetLength(arrSeqLan, Length(arrSeqLan) + 1);
                        arrSeqLan[Length(arrSeqLan)-1] := strSeqLan;
                      end;
                    End;
                  End;
                  qryGen.Next;
                End;

                FreeAndNil(qryGen);
              End
              Else
              Begin
                FreeAndNil(qryGen);
                {*********************************************}
                {* BAIXA A CONTA ÚNICA - SEM DESMEMBRAMENTOS *}
                {******************************************LU*}
                intSeqBai := fRetSeqBaicadPag(FieldByName('NRODUP').AsString,
                                              FieldByName('PARDUP').AsString,
                                              FieldByName('CTP_CODEMP').AsString,
                                              FieldByName('CTP_CODFOR').AsString,
                                              FieldByName('CTP_SERIE_').AsString);

                If FieldByName('CTP_TIPBAI').AsString = 'P' Then
                Begin
                  Inc(intSeqBai);
                End
                Else If FieldByName('CTP_TIPBAI').AsString = 'T' Then
                Begin
                  intSeqBai := 0;
                End;

                {*************************************************}
                {* SÓ VAI GRAVAR MOVBAN DA BAIXA EM 3 SITUAÇÕES: *}
                {* 1ª: SE A BAIXA NÃO FOR PELO RESUMO DE CAIXA E *}
                {*     O VALOR PAGO FOR DIFERENTE DE ZERO        *}
                {* 2ª: SE A BAIXA NÃO FOR PELO RESUMO DE CAIXA,  *}
                {*     A BAIXA FOR ANALÍTICA, A QUANTIDADE DE    *}
                {*     DOCUMENTOS SELECIONADOS FOR MAIOR QUE 1 E *}
                {*     A SOMA DO PAGAMENTO FOR IGUAL A ZERO      *}
                {* 3ª: SE A BAIXA FOR PELO RESUMO DE CAIXA E A   *}
                {*     CONFIGURAÇÃO "CTBPAG" ESTIVER COMO SIM.   *}
                {*************************************KP-117882***}
                If ((Not blnResumoCaixa) And (fStrToFloat(edtTotalPago.Text) <> 0.0)) or
                   ((Not blnResumoCaixa) And (fStrToFloat(edtTotalPago.Text)  = 0.0) And (blnBaiAna) And (StrToIntDef(edtQtdSelecionadas.Text, 0) > 1)) Or
                   ((blnResumoCaixa)     And (fCfgSis('CTBPAG', varBoolean))) Or
                   blnBaixaZeradaCTP Then
                Begin
                  lstBanCtp.pClear;
                  lstBanCtp.fAdd(FieldByName('NRODUP').AsString,
                                 FieldByName('PARDUP').AsString,
                                 FieldByName('CTP_SERIE_').AsString,
                                 FieldByName('CTP_CODEMP').AsString,
                                 FieldByName('CTP_CODFOR').AsString,
                                 FieldByName('CTP_HIST01').AsString,
                                 FieldByName('CTP_HIST02').AsString,
                                 FieldByName('CTP_CODCTA').AsString,
                                 VS_strCodEmp,
                                 intSeqBai,
                                 fltValRec,
                                 0,
                                 0,
                                 0,
                                 0,
                                 FieldByName('CTP_VALJUR').AsFloat,
                                 FieldByName('CTP_VALMUL').AsFloat,
                                 FieldByName('CTP_VALDES').AsFloat,
                                 FieldByName('CTP_VALDUP').AsFloat);

                  strSeqLan := fGravaMovBan(IIF(blnBaixaZeradaCTP,strCtaBai,FieldByName('CTP_CODCTA').AsString),       // Centro de Custo
                                            strPorBai,                                // Portador da Baixa
                                            strLoginUsuarioLogado,                    // Operador da Baixa
                                            FieldByName('CTP_DTAPAG').AsDateTime,     // Data do Lançamento
                                            fTime(),                                  // Hora do Lançamento

                                            IIF(strCpDcBa = '1',
                                                FieldByName('NRODUP').AsString,       // Numero do Documento
                                                strDocBai),

                                            strCreDeb,                                // Credito / Debito
                                            VS_strCodEmp,                             // Empresa da Baixa
                                            IIF(fltValRec < 0, -fltValRec,fltValRec), // Valor Do Lançamento
                                            strHist01,                                // Histórico 1
                                            strHist02,                                // Histórico 2
                                            '',                                       // Cliente da Duplicata
                                            FieldByName('CTP_CODFOR').AsString,       // Fornecedor da Duplicata
                                            FieldByName('NRODUP').AsString,           // Número da Duplicata
                                            intSeqBai,                                // Sequencial de Baixa
                                            FieldByName('PARDUP').AsString,           // Parcela da Duplicata
                                            FieldByName('CTP_CODEMP').AsString,       // Empresa da Duplicata
                                            FieldByName('CTP_SERIE_').AsString,       // Série
                                            FieldByName('CTP_CODEVE').AsString,       // Codigo do Evento
                                            strDocBai,                                // Documento da Baixa
                                            lstBanCtp.fGetList,                       // Log Bancário
                                            0,
                                            intCtpCon,
                                            FieldByName('CTP_COMPET').AsString,
                                            '',
                                            '',
                                            '',
                                            '',
                                            '',
                                            1,
                                            True,
                                            nil,
                                            '',
                                            'S',
                                            '',
                                            FieldByName('CTP_PAGANT').AsString = 'S');

                {************************************************}
                {* CASO TENHA EMITIDO CHEQUE, GRAVA REGISTRO DE *}
                {* ESTORNO NA TABELA BANCHQ                     *}
                {********************08/03/2018**Req. 93054**WS**}
                  If (Not fEmptyStr(strCodBco))                                           And
                     (Not fEmptyStr(strNumAge))                                           And
                     (Not fEmptyStr(strNumChq)                                            And
                     (fStrToFloat(edtTotalPago.Text) <> 0.0))                             Then
                  Begin
                    pGravaBanChq(strCodBco, FieldByName('CTP_CODEMP').AsString,
                                 strConCor, fRetNomeEmpresaSelec(VS_strCodEmp),
                                 strNumAge, strNumChq,
                                 FieldByName('CTP_VALPAG').AsFloat, strSeqLan)
                  End;

                  recUltDupBaixada.strSeqLan := strSeqLan;
                  recUltDupBaixada.strCodCta := FieldByName('CTP_CODCTA').AsString;
                  recUltDupBaixada.strPagCon := IntToStr(intCtpCon);
                  recUltDupBaixada.strPagCta := IntToStr(intCtpCon) + FieldByName('CTP_CODCTA').AsString;

                  If (fEmptyStr(strSeqLan)) Then
                  Begin
                    EnableControls;
                    fRollBack;
                    Exit;
                  End;

                  if (fltValorBaixa <> 0) and (strCodPorFix <> '') then
                  begin
                    SetLength(arrSeqLan, Length(arrSeqLan) + 1);
                    arrSeqLan[Length(arrSeqLan)-1] := strSeqLan;
                  end;

                End;
              End;

            End;

            If Not blnBaiAna  Then
            Begin
              If Not fEmptyStr(strPorDin) Then
                strPorBai := strPorDin
              Else
              If Not fEmptyStr(strPorChV) Then
                strPorBai := strPorChV
              Else
              If Not fEmptyStr(strPorOrd) Then
                strPorBai := strPorOrd
              Else
              If Not fEmptyStr(strPorRep) Then
                strPorBai := strPorRep;

              intSeqBai := fRetSeqBaicadPag(FieldByName('NRODUP').AsString,
                                            FieldByName('PARDUP').AsString,
                                            FieldByName('CTP_CODEMP').AsString,
                                            FieldByName('CTP_CODFOR').AsString,
                                            FieldByName('CTP_SERIE_').AsString);

              If FieldByName('CTP_TIPBAI').AsString = 'P' Then
                Inc(intSeqBai)

              Else If FieldByName('CTP_TIPBAI').AsString = 'T' Then
                intSeqBai := 0;

            End;

            blnGraVDp := fFormataFloat(fltChqVis + fltDinRec + fltOrdPag + fltRepChq, 2) <= 0;


            if fVerificaDupBaixada(cdsCtaPag.FieldByName('NRODUP').AsString,
                                   cdsCtaPag.FieldByName('PARDUP').AsString,
                                   cdsCtaPag.FieldByName('CTP_SERIE_').AsString,
                                   cdsCtaPag.FieldByName('CTP_CODEMP').AsString,
                                   cdsCtaPag.FieldByName('CTP_CODFOR').AsString,
                                   cdsCtaPag.FieldByName('CTP_SEQBAI').AsInteger,
                                   cdsCtaPag.FieldByName('TOTORI').AsFloat) then
            begin
              fRollback;
              EnableControls;
              fMensagem('ATENÇÃO', Format('Não é possível prosseguir com a baixa, existe(m) duplicata(s) selecionada(s) ' + #13#10 +
                                          'já baixadas anteriormente: %s, favor verificar!', [cdsCtaPag.FieldByName('NRODUP').AsString]), ['&Ok']);
              Exit;
            end;

            {*****************************************}
            {* AGORA, GRAVA O CADPAG                 *}
            {**************************************MV*}
            If FieldByName('CTP_TIPBAI').AsString = 'T' Then
            Begin
              If Not blnGraVDp Then
                pGravaRateioPag(cdsRateio, 0, FieldByName('NRODUP').AsString,
                                FieldByName('PARDUP').AsString, FieldByName('CTP_CODEMP').AsString, FieldByName('CTP_SERIE_').AsString,
                                FieldByName('CTP_CODFOR').AsString, FieldByName('CTP_VALPAG').AsFloat,
                                IIF(fltDinRec < 0, FieldByName('CTP_VALPAG').AsFloat, fltDinRec), fltChqVis, fltOrdPag, fltRepChq);

              pBaixaTotal(FieldByName('NRODUP').AsString,            // Duplicata
                          FieldByName('PARDUP').AsString,            // Parcela
                          FieldByName('CTP_CODEMP').AsString,        // Empresa
                          FieldByName('CTP_CODFOR').AsString,        // Fornecedor
                          FieldByName('CTP_SERIE_').AsString,        // Série
                          FieldByName('CTP_VALDUP').AsFloat,         // Valor da Duplicata
                          FieldByName('CTP_VALPAG').AsFloat,         // Valor Pago
                          FieldByName('CTP_DTAPAG').AsDateTime,      // Data de Pagamento
                          strPorBai,                                 // Portador da Baixa
                          strHist01,                                 // Histórico da Baixa
                          FieldByName('CTP_HIST02').AsString + '<<csq>>' + strHist02, // Histórico 02
                          strSeqLan,                                 // Documento da Baixa(MOVBAN)
                          strCtaBai,                                 // Centro de Custo da Baixa
                          strLoginUsuarioLogado,                     // Operador da Baixa
                          strDocBai,
                          FieldByName('CTP_TIPDES').AsString,
                          intCtpCon,
                          FieldByName('CTP_VENDOR').AsFloat,         // VENDOR
                          IIF(blnResumoCaixa, 1, 0),
                          intSeqCon,
                          intSeqRCH,
                          IIF(fStrToFloat(edtTotalPago.Text) = 0, IIF( fStrToFloat(edtTotalPago.Text) = 0, FieldByName('CTP_VALPAG').AsFloat, fltDinRec ), IIF(blnGraVDp, FieldByName('CTP_VALPAG').AsFloat, fltDinRec)), //IIF(blnGraVDp, FieldByName('CTP_VALPAG').AsFloat, fltDinRec),
                          fltChqVis,
                          fltOrdPag,
                          fltRepChq,
                          FieldByName('CTP_VALJUR').AsFloat,
                          FieldByName('CTP_VALDES').AsFloat,
                          FieldByName('CTP_OUTENT').AsFloat,
                          FieldByName('CTP_VALMUL').AsFloat);
            End
            Else
            Begin
              If Not blnGraVDp Then
                pGravaRateioPag(cdsRateio, intSeqBai, FieldByName('NRODUP').AsString,
                                FieldByName('PARDUP').AsString, FieldByName('CTP_CODEMP').AsString, FieldByName('CTP_SERIE_').AsString,
                                FieldByName('CTP_CODFOR').AsString, FieldByName('CTP_VALPAG').AsFloat,
                                IIF(fltDinRec < 0, FieldByName('CTP_VALPAG').AsFloat, fltDinRec), fltChqVis, fltOrdPag, fltRepChq);

              pBaixaParcial(Self.Name,                                // Nome Form LOGCTP
                            'BAIXA PARCIAL' + strChamada,             // Descrição LOGCTP
                            FieldByName('NRODUP').AsString,           // Duplicata
                            FieldByName('PARDUP').AsString,           // Parcela
                            FieldByName('CTP_CODEMP').AsString,       // Empresa
                            FieldByName('CTP_CODFOR').AsString,       // Fornecedor
                            FieldByName('CTP_SERIE_').AsString,       // Serie
                            FieldByName('CTP_DTAPAG').AsDateTime,     // Data de Pagament
                            FieldByName('CTP_VALPAG').AsFloat,        // Valor Pago
                            strPorBai,                                // Portador da Baixa
                            strHist01,                                // Histórico da Baixa
                            FieldByName('CTP_HIST02').AsString + '<<csq>>' + strHist02, // Histórico 02
                            strSeqLan,                                // Documento da Baixa
                            strCtaBai,                                // Centro de Custo
                            strLoginUsuarioLogado,                    // Operador da Baixa
                            strDocBai,
                            FieldByName('CTP_TIPDES').AsString,
                            intCtpCon,
                            IIF(blnResumoCaixa, 1, 0),
                            intSeqCon,
                            intSeqRCH,
                            IIF(fStrToFloat(edtTotalPago.Text) = 0, IIF( fStrToFloat(edtTotalPago.Text) = 0, FieldByName('CTP_VALPAG').AsFloat, fltDinRec ), IIF(blnGraVDp, FieldByName('CTP_VALPAG').AsFloat, fltDinRec)), //IIF(blnGraVDp, FieldByName('CTP_VALPAG').AsFloat, fltDinRec),
                            fltChqVis,
                            fltOrdPag,
                            fltRepChq,
                            FieldByName('CTP_OUTENT').AsFloat,
                            fGetValOriDuplicata(FieldByName('NRODUP').AsString,
                                                FieldByName('CTP_SERIE_').AsString,
                                                FieldByName('CTP_CODEMP').AsString,
                                                FieldByName('PARDUP').AsString,
                                                FieldByName('CTP_CODFOR').AsString)
                            );
            End;

            If Not blnBaiAna Then
            Begin
              if fEmptyStr(strHisBaiSint) Then
                strHisBaiSint := 'Pag. ' + FieldByName('CTP_CODFOR').AsString + ' - ' + FieldByName('FOR_NOMFOR').AsString
              Else
              If (strHisBaiSint <> 'Pag. ' + FieldByName('CTP_CODFOR').AsString + ' - ' + FieldByName('FOR_NOMFOR').AsString) Then
                strHisBaiSint := 'Pgto. Fornecedores Diversos';

              If FieldByName('CTP_VALPAG').AsFloat < 0 Then
              Begin
                strCreDeb := 'C';
              End
              Else

              Begin
                strCreDeb := 'D';
              End;
            End;

            If Not blnMarcarTodas Then
              objLogLibCtp.pGravarlogLib(cdsCtaPag.FieldByName('AUTOINCREM').AsString);


          End;

          Next;
        End;

        {*********************************************}
        {* EM CASO DE ESTORNO DE DUPLICATAS E DEPOIS *}
        {* SER EFETUADO UM 'ABATIMENTO'  ESTAVA      *}
        {* MANTENDO MODALIDADES DA BAIXA ANTERIOR    *}
        {*******************************************LE}
        blnGraVDp := fFormataFloat(fltChqVis + fltDinRec + fltOrdPag + fltRepChq, 2) <= 0;
        If blnGraVDp Then
          fAcertaAbatimentoPag(cdsCtaPag);

        If (Not fAcertaRateioPag(cdsRateio)) Then
        Begin
          fRollback;
          EnableControls;
          Exit;
        End;

        If (Not fAcertaRateioChqEmi(fltChqVis, cdsRateio)) Then
        Begin
          fRollback;
          EnableControls;
          Exit;
        End;

        cdsTmpPag := TUniClientDataSet.Create(Self);
        With cdsTmpPag Do
        Begin
          Data := cdsCtaPag.Data;
          Filtered := False;
          Filter := 'CTP_MARDES = ''M''';
          Filtered := True;
          IndexFieldNames := cdsCtaPag.IndexFieldNames;
          First;
        End;

        //Aqui sera feito o desmembramento do titulo por especies de pagamento
        While Not cdsTmpPag.Eof Do
        Begin
          DesmembraDuplicatasPagarPorEspecie( cdsTmpPag.FieldByName('AUTOINCREM').AsString );
          cdsTmpPag.Next;
        End;
        FreeAndNil(cdsTmpPag);

        {*****************************************}
        {* AGORA, GRAVA O MOVBAN DA BAIXA SIN-   *}
        {* TÉTICA                                *}
        {**************************************MV*}
        If Not blnBaiAna Then
        Begin

          If fEmptyStr(strHist01) Then
            strHist01 := strHisBaiSint;

          {*****************************************}
          {* MOVBAN DO CAIXA 1                     *}
          {**************************************MV*}
          If fltTotCx <> 0.0 Then
          Begin

            strCreDeb := IIF(fltTotCx > 0, 'D', 'C');
            fltTotCx  := IIF(fltTotCx > 0, fltTotCx, -fltTotCx);

            {************************************************}
            {* CASO NÃO VENHA DO RESUMO DE CAIXA, OU SE FOR *}
            {* RESUMO DE CAIXA E A VARIÁVEL E A FUNÇÃO      *}
            {* fCfgSis('CTBPAG') FOR TRUE, ENTÃO, GRAVA MOVBAN*}
            {*********************************************MV*}
            If ((Not blnResumoCaixa) And (fStrToFloat(edtTotalPago.Text) <> 0.0)) or ((blnResumoCaixa) and (fCfgSis('CTBPAG', varBoolean))) Then
            Begin
              {************************************}
              {* GRAVA PARA A MODALIDADE DINHEIRO *}
              {*24/07/2015*******************JU*AF*}
              If fltDinRec <> 0 Then
              Begin
                strSeqLan := fGravaMovBanSinteticoPorModalidade(strPorDin, strCtaBai, fltDinRec, lstBanCtp.fGetListClone);
                If (fEmptyStr(strSeqLan)) Then
                Begin
                  fRollback;
                  Exit;
                End;

                if (fltValorBaixa <> 0) and (strCodPorFix <> '') then
                begin
                  SetLength(arrSeqLan, Length(arrSeqLan) + 1);
                  arrSeqLan[Length(arrSeqLan)-1] := strSeqLan;
                end;
              End;

              {******************************************}
              {* GRAVA PARA A MODALIDADE CHEQUE EMITIDO *}
              {*24/07/2015*************************JU*AF*}
              If (fltChqVis > 0) And (Assigned(dicChqEmi)) And (dicChqEmi.Count > 0) Then
              Begin

                For strChave In keyArray Do
                Begin

                  strTmpChave := dicChqEmi[strChave].strCodBco+
                                 dicChqEmi[strChave].strNumAge+
                                 dicChqEmi[strChave].strConCor+
                                 dicChqEmi[strChave].strNumChq;

                  If dicChqCtp.ContainsKey(strTmpChave) Then
                  Begin
                    strTmpCodFor := dicChqCtp[strTmpChave].strCodFor;
                    strTmpHist01 := dicChqCtp[strTmpChave].strHist01;
                    strTmpHist02 := dicChqCtp[strTmpChave].strHist02;
                  End
                  Else
                  Begin
                    strTmpCodFor := '';
                    strTmpHist01 := '';
                    strTmpHist02 := '';
                  End;

                  lstBanChq.pClear;
                  lstBanChq.fAdd(dicChqEmi[strChave].strCodBco,
                                 dicChqEmi[strChave].strNumAge,
                                 dicChqEmi[strChave].strConCor,
                                 dicChqEmi[strChave].strNumChq,
                                 '',
                                 fRetNomeEmpresaSelec(VS_strCodEmp),
                                 strTmpHist01,
                                 strTmpHist02,
                                 VS_strCodEmp,
                                 strTmpCodFor,
                                 dicChqEmi[strChave].fltValChq);

                  lstBanChq.pMerge([lstBanCtp.fGetListClone]);

                  {******************************************}
                  {* CHEQUE AVISTA NÃO TEM 'BOM PARA'       *}
                  {*REQ45014******************************LE*}
                  dtaChqMovBan := 0;
                  If fEmptyStr(dicChqEmi[strChave].strDtaBom)  Then
                    dtaChqMovBan := StrToDate(dicChqEmi[strChave].strDtaEmi)
                  Else
                    dtaChqMovBan := StrToDate(dicChqEmi[strChave].strDtaBom);

                  strSeqLan := fGravaMovBanSinteticoPorModalidade(strPorChV, strCtaBai, dicChqEmi[strChave].fltValChq,
                                                                  lstBanChq.fGetList, dtaChqMovBan, dicChqEmi[strChave].strNumChq);
                  If (fEmptyStr(strSeqLan)) Then
                  Begin
                    fRollback;
                    Exit;
                  End;

                  if (fltValorBaixa <> 0) and (strCodPorFix <> '') then
                  begin
                    SetLength(arrSeqLan, Length(arrSeqLan) + 1);
                    arrSeqLan[Length(arrSeqLan)-1] := strSeqLan;
                  end;
                End;

              End;

              {*********************************************}
              {* GRAVA PARA A MODALIDADE DEPÓSITO BANCÁRIO *}
              {*24/07/2015****************************JU*AF*}
              If fltOrdPag <> 0 Then
              Begin
                strSeqLan := fGravaMovBanSinteticoPorModalidade(strPorOrd, strCtaBai, fltOrdPag, lstBanCtp.fGetListClone);
                If (fEmptyStr(strSeqLan)) Then
                Begin
                  fRollback;
                  Exit;
                End;

                if (fltValorBaixa <> 0) and (strCodPorFix <> '') then
                begin
                  SetLength(arrSeqLan, Length(arrSeqLan) + 1);
                  arrSeqLan[Length(arrSeqLan)-1] := strSeqLan;
                end;
              End;

              {***********************************************}
              {* GRAVA PARA A MODALIDADE CHEQUE DE TERCEIROS *}
              {*24/07/2015******************************JU*AF*}
              If (fltRepChq > 0) And (Assigned(dicChqRep)) And (dicChqRep.Count > 0) Then
              Begin
                fltTotChqRep := 0;
                lstBanChq.pClear;

                For strChave In dicChqRep.Keys Do
                Begin
                  strTmpChave := dicChqRep[strChave].strCodBco+
                                 dicChqRep[strChave].strNumAge+
                                 dicChqRep[strChave].strConCor+
                                 dicChqRep[strChave].strNumChq;

                  If dicChqCtp.ContainsKey(strTmpChave) Then
                  Begin
                    strTmpCodFor := dicChqCtp[strTmpChave].strCodFor;
                    strTmpHist01 := dicChqCtp[strTmpChave].strHist01;
                    strTmpHist02 := dicChqCtp[strTmpChave].strHist02;
                  End
                  Else
                  Begin
                    strTmpCodFor := '';
                    strTmpHist01 := '';
                    strTmpHist02 := '';
                  End;

                  If (blnBaiChqAna) Then
                     lstBanChq.pClear;

                  lstBanChq.fAdd(dicChqRep[strChave].strCodBco,
                                 dicChqRep[strChave].strNumAge,
                                 dicChqRep[strChave].strConCor,
                                 dicChqRep[strChave].strNumChq,
                                 '',
                                 fRetNomCliente(dicChqRep[strChave].strCodCli),
                                 strTmpHist01,
                                 strTmpHist02,
                                 VS_strCodEmp,
                                 strTmpCodFor,
                                 dicChqRep[strChave].fltValChq);

                  lstBanChq.pMerge([lstBanCtp.fGetListClone]);

                  fltTotChqRep := fltTotChqRep + dicChqRep[strChave].fltValChq;

                  If (blnBaiChqAna) Or (dicChqRep.Count = 1) Then
                  Begin
                     strSeqLan := fGravaMovBanSinteticoPorModalidade(strPorRep, strCtaBai, dicChqRep[strChave].fltValChq,
                                                                    lstBanChq.fGetList, 0, dicChqRep[strChave].strNumChq);
                     If (fEmptyStr(strSeqLan)) Then
                     Begin
                       fRollback;
                       Exit;
                     End;

                     if (fltValorBaixa <> 0) and (strCodPorFix <> '') then
                     begin
                       SetLength(arrSeqLan, Length(arrSeqLan) + 1);
                       arrSeqLan[Length(arrSeqLan)-1] := strSeqLan;
                     end;
                  End;

                End;

                If Not ((blnBaiChqAna) Or (dicChqRep.Count = 1)) Then
                Begin
                  strSeqLan := fGravaMovBanSinteticoPorModalidade(strPorRep, strCtaBai, fltTotChqRep, lstBanChq.fGetList, 0, '');
                  If (fEmptyStr(strSeqLan)) Then
                  Begin
                    fRollback;
                    Exit;
                  End;

                  if (fltValorBaixa <> 0) and (strCodPorFix <> '') then
                  begin
                    SetLength(arrSeqLan, Length(arrSeqLan) + 1);
                    arrSeqLan[Length(arrSeqLan)-1] := strSeqLan;
                  end;
                End;

              End;
            End;
          End;
        End;
        EnableControls;
      End;

      If (blnResumoCaixa And (fStrToFloat(edtTotalPago.Text) <> 0.0)) Then
      Begin
        {****************************************************************}
        {* TRAVA PARA GARANTIR QUE AS MODALIDADES NÃO FIQUEM DIFERENTES *}
        {* DO TOTAL PAGO ANTES DE GRAVAR O CAIXA ************************}
        {*REQ*99985***************************************************MO*}
        If -fStrToFloat(edtTotalPago.Text) <> ((-fltDinRec) + (-fltChqVis)) Then
        Begin
          strMsgInconsistencia := 'Ocorreu uma inconsistência na gravação dos valores do caixa!' + #13#10 +
                                  'Tente realizar a baixa novamente! Se o problema persistir, entre em contato com a Citel!';
          fRollBack;
          pMensagemOk(strMsgInconsistencia);
          Exit;
        End
        Else
        Begin
          {**Req. 97805**23/04/2018**WS**}
          If intCountDup > 1 Then
          Begin
            strNroDupCx := 'Diversos';
            strParDupCx := '';
          End;

          blnConfirma := fGravaCadRcx(strSeqRcx,
                                      '',                              // Cliente
                                      strOpeCaixa,                     // Operador
                                      '',                              // Documento
                                      'LD',                            // Especie
                                      VS_strCodEmp,                    // Empresa
                                      VS_Date,                         // Data de Cadastro
                                      fTime(),                         // Hora de Cadastro
                                      strNroDupCx,                     // Duplicata {**Req. 97805**23/04/2018**WS**}
                                      strParDupCx,                     // Parcela   {**Req. 97805**23/04/2018**WS**}
                                      'BAIXA CT. PAG ' + fRetFornecedorResumoCaixa,       // Descrição
                                      '',                              // Juros / Desconto
                                      '',                              // Identificação de Fechamento
                                      '',                              // Forma de Pagamento
                                      -fStrToFloat(edtTotalPago.Text), // Valor do Documento
                                      0.0,                             // Valor de Desconto
                                      0.0,                             // Valor de Juros
                                      -fltDinRec,                      // Valor em Dinheiro
                                      -fltChqVis,                      // Valor em Cheque a Vista
                                      0.0,                             // Valor em Cheque Pre
                                      0.0,                             // Valor em Cartão
                                      0.0,                             // Valor em Ordem de Pagamento
                                      0.0,                             // Valor de Crédito
                                      0.0,                             // Velor em Financiamento
                                      0.0,                             // Valor em Outros
                                      0.0,                             // Valor de Venda a Prazo
                                      '',                              // Num. do Romaneio
                                      intSeqCon,                       // Sequencial de Controle
                                      0,                               // Sequencial de Baixa (Duplicata)
                                      fCfgSisL('SQFCRX'),              // Sequencial de Fechamento parcial de caixa
                                      '',                              // Empresa da Duplicata
                                      '',                              // MotDes
                                      1,
                                      0,
                                      0,
                                      0,
                                      0,
                                      0,                               // Identificação do Caixa
                                      'N',
                                      '',
                                      strCodigoCaixa);

          If (Not blnConfirma) Then
          Begin
            fRollBack;
            Exit;
          End;
        End;
      End;

      If Not blnNaoBai Then
      begin

        If blnMarcarTodas Then
        Begin
          objLogLibCtp.pGravarlogLib(strAutoIncremTodas);
          blnMarcarTodas := False;
          strAutoIncremTodas := '';
        End;

        fCommit;
        {****************}
        {* GRAVA LOGCTP *}
        {*47667**********}
        With cdsCtaPag Do
        Begin
          dtsCtaPag.Dataset.DisableControls;
          First;
          While Not Eof Do
          begin
            If FieldByName('CTP_MARDES').AsString = 'M' Then
            Begin
              intSeqBai := IIF(FieldByName('CTP_TIPBAI').AsString = 'T',
                               0,
                               fRetSeqBaicadPag(FieldByName('NRODUP').AsString,
                                                FieldByName('PARDUP').AsString,
                                                FieldByName('CTP_CODEMP').AsString,
                                                FieldByName('CTP_CODFOR').AsString,
                                                FieldByName('CTP_SERIE_').AsString));

              GravaLogCtp(FieldByName('NRODUP').AsString,
                          FieldByName('PARDUP').AsString,
                          intSeqBai,
                          FieldByName('CTP_CODEMP').AsString,
                          FieldByName('CTP_CODFOR').AsString,
                          FieldByName('CTP_SERIE_').AsString,
                          IIF(FieldByName('CTP_TIPBAI').AsString = 'T', 'BAIXA TOTAL ' + strChamada, 'BAIXA PARCIAL ' + strChamada),
                          FieldByName('CTP_DTALIB').AsDateTime);
            end;
            Next;
          end;
          First;
          dtsCtaPag.Dataset.EnableControls;
          strMarcacaoLog := '';
        end;
      end;

      Result := True;
      If Assigned(cdsClone) Then
      Begin
        With cdsClone Do
        Begin
          DisableControls;
          First;

          While Not Eof Do
          Begin
            objLock.fLock_Unlock(FieldByName('TABELA').AsString + FieldByName('AUTOINCREM').AsString, False);
            Next;
          End;
          EnableControls;
        End;

        FreeAndNil(cdsClone);
      End;
      pDestravaCheques;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[pBaixaTotal]');
        fRollBack;
      End;
    End;
  Finally
    FreeAndNil(lstBanCtp);
    FreeAndNil(lstBanChq);
    FreeAndNil(dicChqCtp);
  End;

  //SE BAIXOU A DUPLICATA AI SIM IMPRIME O CHEQUE
  If Not blnNaoBai Then
  Begin
    {*****************************************}
    {* CASO USE IMPRESSORA DE CHEQUES, ENVIA *}
    {* OS CHEQUES.                           *}
    {**************************************LE*}
    If fCfgSis('USAICH', varBoolean) And
       (Not fEmptyStr(strCodBco)) And
       (Not fEmptyStr(strNumAge)) And
       (Not fEmptyStr(strNumChq) And
       (fStrToFloat(edtTotalPago.Text) <> 0.0)) Then
        pEnviaChequesImpChq(fCriaClientCheque(strCodBco, strNumAge, strNumChq, strFavore,strDtaEmi,strConCor,fStrToFloat(edtTotalPago.Text)));

    {*******************************************}
    {* SE AS VARIAVEIS ESTIVEREM PREENCHIDAS   *}
    {* É PQ O CLINTE NA HORA DA BAIXA OPTOU    *}
    {* POR EMITIR O CHEQUE.                    *}
    {* IMPRIME TAMBEM A COPIA DO CHEQUE        *}
    {* EM UMA OUTRA FILA CONFIGURAVEL          *}
    {****************************************AC*}
    If (Not fEmptyStr(strCodBco)) And (Not fEmptyStr(strNumAge)) And (Not fEmptyStr(strNumChq) And (fStrToFloat(edtTotalPago.Text) <> 0.0)) Then
    Begin
      pImprimeCheque(strCodBco, strNumAge, strNumChq, strConCor, strFavore, strDtaBom, strPorBai, Self.Name, strDtaEmi);
      pImprimeCopiaCheque(strCodBco, strNumAge, strNumChq, strConCor, Self.Name);
    End
    Else If Assigned(dicChqEmi) And (dicChqEmi.Count > 0) Then
    Begin
      stlChqEmi := TStringList.Create;
      For strChave In keyArray Do stlChqEmi.Add(strChave);

      stlChqEmi.Sort;

      For intContCh := 0 To stlChqEmi.Count - 1 Do
      Begin
        strChave := stlChqEmi.Strings[intContCh];

        pImprimeCheque(dicChqEmi[strChave].strCodBco, dicChqEmi[strChave].strNumAge, dicChqEmi[strChave].strNumChq,  dicChqEmi[strChave].strConCor,
                       dicChqEmi[strChave].strFavore, dicChqEmi[strChave].strDtaBom, strPorChV, Self.Name, dicChqEmi[strChave].strDtaEmi);
        pImprimeCopiaCheque(dicChqEmi[strChave].strCodBco, dicChqEmi[strChave].strNumAge, dicChqEmi[strChave].strNumChq,  dicChqEmi[strChave].strConCor, Self.Name);
      End;
    End;


    If fCfgSis('CTPBOR', varBoolean) and (FImprimeBordero) Then
        pImprimeBordero(False, strCodBco, strNumAge, strConCor, strNumChq, strPorBai, fltTotCx)
  End
  Else
  If fCfgSis('CTPBOR', varBoolean) Then
    pImprimeBordero(True, strCodBco, strNumAge, strConCor, strNumChq, strPorBai, fltTotCx);

  If blnNaoBai Then
    fRollBack;

  objLogLibCtp.pLimparLogLib;

end;

function TfrmBaixaCtaPagar.fFormataFoneInterna(strFone: String): String;
begin
  Result := fFormataFone(strFone);
end;

procedure TfrmBaixaCtaPagar.pGravaBanChq(strCodBco, strCodEmp, strConCor,
  strNomEmi, strNumAge, strNumChq: String; fltValChq: Double;
  strSeqLan: String);
  Var
    strSQL: String;
    qryBanChq : TUniQuery;
begin
  Try
    qryBanChq := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO ';
    strSQL := strSQL + ' BANCHQ ( ';
    strSQL := strSQL + ' AUTOINCREM, ';
    strSQL := strSQL + ' CHQ_CODBCO, ';
    strSQL := strSQL + ' CHQ_CODEMP, ';
    strSQL := strSQL + ' CHQ_CONCOR, ';
    strSQL := strSQL + ' CHQ_NOMEMI, ';
    strSQL := strSQL + ' CHQ_NUMAGE, ';
    strSQL := strSQL + ' CHQ_NUMCHQ, ';
    strSQL := strSQL + ' CHQ_VALCHQ, ';
    strSQL := strSQL + ' CTB_SEQLAN) ';
    strSQL := strSQL + 'VALUES ( ';
    strSQL := strSQL + ' :AUTINC, ';
    strSQL := strSQL + ' :CODBCO, ';
    strSQL := strSQL + ' :CODEMP, ';
    strSQL := strSQL + ' :CONCOR, ';
    strSQL := strSQL + ' :NOMEMI, ';
    strSQL := strSQL + ' :NUMAGE, ';
    strSQL := strSQL + ' :NUMCHQ, ';
    strSQL := strSQL + ' :VALCHQ, ';
    strSQL := strSQL + ' :SEQLAN) ';

    With qryBanChq Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTINC').AsString := fRetAutoIncrem('BANCHQ', strCodEmp);
      ParamByName('CODBCO').AsString := strCodBco;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CONCOR').AsString := strConCor;
      ParamByName('NOMEMI').AsString := strNomEmi;
      ParamByName('NUMAGE').AsString := strNumAge;
      ParamByName('NUMCHQ').AsString := strNumChq;
      ParamByName('VALCHQ').AsFloat  := fltValChq;
      ParamByName('SEQLAN').AsString := strSeqLan;

      ExecSQL;
      Close;
    End;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

  FreeAndNil(qryBanChq);
end;

procedure TfrmBaixaCtaPagar.GravaLogCtp(strNumeroDup, strParcela: String;
                                        intSeqBai: Integer;
                                        strCodEmp, strCodFor, strSerie_, strDescricaoLog: String;
                                        ADataLiberacao: TDateTime = 0);
  Var
    LAutoIncrem: String;
begin
  Try
    LAutoIncrem := fCampoTabela('AUTOINCREM',
                                'CADPAG',
                                ['CTP_NUMDUP', 'CTP_PARCEL', 'CTP_CODEMP', 'CTP_CODFOR', 'IFNULL(CTP_SERIE_, "")', 'CTP_SEQBAI'],
                                [strNumeroDup, strParcela, strCodEmp, strCodFor, strSerie_, intSeqBai],
                                True);

    untLogCtp.GravaLogCtp(LAutoIncrem,
                          strDescricaoLog,Self.Name + IIF(fEmptyStr(strMarcacaoLog), '', ' [' + strMarcacaoLog + ']'));

    If (fCfgSis('CTPLBB', varBoolean) And (ADataLiberacao = 0)) And fCfgSis('CTPBDP', varBoolean) Then
      untLogCtp.GravaLogCtp(LAutoIncrem,'LIBERAÇÃO PENDENTE',Self.Name + IIF(fEmptyStr(strMarcacaoLog), '', ' [' + strMarcacaoLog + ']'));
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[frmBaixaCtaPagar.GravaLogCtp]');
  End;
End;

function TfrmBaixaCtaPagar.fImprimeReciboLayout: Boolean;
  Var
    intCont : Integer;
    cdsAux  : TUniClientDataSet;
    repMovBan: TMovBanRepository;
    repCadPag: TCadPagRepository;
    intSeqBai: Integer;
    dblDinheiro, dblChequeVista, dblChequeRepasse, dblDeposito: Double;
    qryChq_Emi_Baixa, qryChq_Rep_Baixa: TUniQuery;
    strSQL: string;
    tslChqEmi  : TStringList;
    tslChqRep  : TStringList;
    intQtdVias : Integer;
    intContVia : Integer;

    LDatasetCadPag: TUniClientDataSet;

  function fRetChequesRep: TStringList;
  begin
    result := tstringlist.create;
    if not qryChq_Rep_Baixa.isEmpty then
    begin
      result.Add(qryChq_Rep_Baixa.fieldbyname('CTB_CODPOR').asstring);
      result.Add(qryChq_Rep_Baixa.fieldbyname('POR_NOMPOR').asstring);
      result.Add(qryChq_Rep_Baixa.fieldbyname('CHQ_CODBCO').asstring);
      result.Add(qryChq_Rep_Baixa.fieldbyname('CHQ_CONCOR').asstring);
      result.Add(qryChq_Rep_Baixa.fieldbyname('CHQ_NUMAGE').asstring);
      result.Add(qryChq_Rep_Baixa.fieldbyname('CHQ_NUMCHQ').asstring);
      result.Add(qryChq_Rep_Baixa.fieldbyname('CHQ_VALCHQ').asstring);
      result.Add(qryChq_Rep_Baixa.fieldbyname('CHQ_NOMEMI').asstring);
      result.Add(qryChq_Rep_Baixa.fieldbyname('CHQ_DTAVEN').asstring);
      result.Add(qryChq_Rep_Baixa.fieldbyname('CHQ_DTAREP').asstring);
    end
    else
    begin
      result.Add('');
      result.Add('');
      result.Add('');
      result.Add('');
      result.Add('');
      result.Add('');
      result.Add('0');
      result.Add('');
      result.Add('');
      result.Add('');
    end;
  end;

    

    function fRetHisBai: String;
      Var
        objCadPag: TCadPag;
    begin
      objCadPag := repCadPag.fRetDuplicata(cdsGenCtp.FieldByName('NRODUP').AsString,cdsGenCtp.FieldByName('PARDUP').AsString,
                                           intSeqBai,cdsGenCtp.FieldByName('CTP_CODEMP').AsString,
                                           cdsGenCtp.FieldByName('CTP_CODFOR').AsString,cdsGenCtp.FieldByName('CTP_SERIE_').AsString);

      frwk.objDBManager.Refresh(objCadPag);
      Result := objCadPag.strHisBai.Value;
    end;

    function fRetChequesEmi: TStringList;
    begin
      result := tstringlist.create;
      if not qryChq_Emi_Baixa.isEmpty then
      begin
        result.Add(qryChq_Emi_Baixa.fieldbyname('CTB_CODPOR').asstring);
        result.Add(qryChq_Emi_Baixa.fieldbyname('POR_NOMPOR').asstring);
        result.Add(qryChq_Emi_Baixa.fieldbyname('EMI_CODBCO').asstring);
        result.Add(qryChq_Emi_Baixa.fieldbyname('EMI_CONCOR').asstring);
        result.Add(qryChq_Emi_Baixa.fieldbyname('EMI_NUMAGE').asstring);
        result.Add(qryChq_Emi_Baixa.fieldbyname('EMI_NUMCHQ').asstring);
        result.Add(qryChq_Emi_Baixa.fieldbyname('CHQ_VALCHQ').asstring);
      end
      else
      begin
        result.Add('');
        result.Add('');
        result.Add('');
        result.Add('');
        result.Add('');
        result.Add('');
        result.Add('0');
      end;
    end;
begin
  Result := False;

  Try

    intQtdVias := 1;
    If (fCfgSis('RECCTP') = 'S') And (fCfgSis('RECCPV', varInteger) > 1) Then
    Begin
      cdsAux  := fCriaClientDatasetReciboCTP_MF;
      intQtdVias := fCfgSis('RECCPV', varInteger);

      If (intQtdvias <= 0) Then
        intQtdVias := 1;
    End
    Else
      cdsAux  := fCriaClientDatasetReciboCTP;

    qryChq_Emi_Baixa := fCriaQuery(nil);
    qryChq_Rep_Baixa := fCriaQuery(nil);


    For intCont := 0 To stlCodFor.Count - 1 Do
    Begin
      With cdsGenCtp Do
      Begin
        Filtered := False;
        Filter := 'CTP_MARDES = '+ QuotedStr('M') +'  AND CTP_CODFOR = ' + QuotedStr(stlCodFor[intCont]);
        Filtered := True;

        If Not cdsAux.IsEmpty Then
          cdsAux.EmptyDataSet;

        For intContVia := 1 To intQtdVias Do //MF: 294776 - 30/08/23
        Begin

          First;

          repMovBan := TMovBanRepository.Create;
          repCadPag := TCadPagRepository.Create;



          dblDinheiro      := 0;
          dblDeposito      := 0;
          dblChequeVista   := 0;
          dblChequeRepasse := 0;

          While Not Eof Do
          Begin

            {**************************************************}
            {* PEGO O SEQBAI PARA QUE CASO SEJA BAIXA PARCIAL *}
            {* IMPRIMA NO RECIBO OS DADOS CORRESPONDENTES À   *}
            {* ÚLTIMA BAIXA PARCIAL                           *}
            {*07/12/2015**REQ.45357*************************JU*}
            intSeqBai := fRetSeqBaiCadPag(FieldByName('NRODUP').AsString,
                                          FieldByName('PARDUP').AsString,
                                          FieldByName('CTP_CODEMP').AsString,
                                          FieldByName('CTP_CODFOR').AsString,
                                          FieldByName('CTP_SERIE_').AsString);

            LDatasetCadPag := RetornaDatasetCamposCadPag(FieldByName('AUTOINCREM').AsString);

            cdsAux.Append;
            cdsAux.FieldByName('CTP_NUMDUP').AsString   := FieldByName('CTP_NUMDUP').AsString;
            cdsAux.FieldByName('NRODUP').AsString       := FieldByName('NRODUP').AsString;
            cdsAux.FieldByName('CTP_CODEMP').AsString   := FieldByName('CTP_CODEMP').AsString;
            cdsAux.FieldByName('CTP_USACHQ').AsString   := FieldByName('CTP_USACHQ').AsString;
            cdsAux.FieldByName('CTP_CODEVE').AsString   := FieldByName('CTP_CODEVE').AsString;
            cdsAux.FieldByName('CTP_NOMEVE').AsString   := FieldByName('CTP_CODEVE').AsString + ' - ' + fRetNomEvento(FieldByName('CTP_CODEVE').AsString);
            cdsAux.FieldByName('CTP_NOMCTA').AsString   := FieldByName('CTP_CODCTA').AsString + ' - ' + fRetDescCentroCusto(FieldByName('CTP_CODCTA').AsString);
            cdsAux.FieldByName('CTP_CTABAI').AsString   := strCtaBai + ' - ' + fRetDescCentroCusto(strCtaBai);
            cdsAux.FieldByName('CTP_PORBAI').AsString   := FieldByName('CTP_PORBAI').AsString;
            cdsAux.FieldByName('CTP_SERIE_').AsString   := FieldByName('CTP_SERIE_').AsString;
            cdsAux.FieldByName('CTP_VALJUR').AsFloat    := FieldByName('CTP_VALJUR').AsFloat;
            cdsAux.FieldByName('CTP_VALMUL').AsFloat    := FieldByName('CTP_VALMUL').AsFloat;
            cdsAux.FieldByName('CTP_VALDES').AsFloat    := FieldByName('CTP_VALDES').AsFloat;
            cdsAux.FieldByName('CTP_VALDUP').AsFloat    := FieldByName('CTP_VALDUP').AsFloat;
            cdsAux.FieldByName('CTP_VALPAG').AsFloat    := FieldByName('CTP_VALPAG').AsFloat;
            cdsAux.FieldByName('CTP_VALORI').AsFloat    := FieldByName('CTP_VALORI').AsFloat;
            cdsAux.FieldByName('CTP_TIPDOC').AsFloat    := FieldByName('CTP_TIPDOC').AsFloat;
            cdsAux.FieldByName('CTP_DESSUJ').AsFloat    := FieldByName('CTP_DESSUJ').AsFloat;
            cdsAux.FieldByName('CTP_JURSUJ').AsFloat    := FieldByName('CTP_JURSUJ').AsFloat;
            cdsAux.FieldByName('CTP_MULSUJ').AsFloat    := FieldByName('CTP_MULSUJ').AsFloat;
            cdsAux.FieldByName('CTP_VENDOR').AsFloat    := FieldByName('CTP_VENDOR').AsFloat;
            cdsAux.FieldByName('CTP_OUTENT').AsFloat    := FieldByName('CTP_OUTENT').AsFloat;
            cdsAux.FieldByName('TOTDUP').AsFloat        := FieldByName('TOTDUP').AsFloat;
            cdsAux.FieldByName('CTP_CODFOR').AsString   := FieldByName('CTP_CODFOR').AsString;
            cdsAux.FieldByName('FOR_NOMFOR').AsString   := FieldByName('FOR_NOMFOR').AsString;
            cdsAux.FieldByName('CTP_NOMFOR').AsString   := FieldByName('CTP_NOMFOR').AsString;
            cdsAux.FieldByName('EVE_DESEVE').AsString   := FieldByName('EVE_DESEVE').AsString;
            cdsAux.FieldByName('CTP_CODCTA').AsString   := FieldByName('CTP_CODCTA').AsString;
            cdsAux.FieldByName('CTP_DTAPAG').AsDateTime := FieldByName('CTP_DTAPAG').AsDateTime;
            cdsAux.FieldByName('CTP_DTAVEN').AsDateTime := FieldByName('CTP_DTAVEN').AsDateTime;
            cdsAux.FieldByName('CTP_DTAPAG').AsDateTime := FieldByName('CTP_DTAPAG').AsDateTime;
            cdsAux.FieldByName('CTP_DTACAD').AsDateTime := FieldByName('CTP_DTACAD').AsDateTime;
            cdsAux.FieldByName('CTA_DESCTA').AsString   := FieldByName('CTA_DESCTA').AsString;
            cdsAux.FieldByName('CTP_HIST01').AsString   := FieldByName('CTP_HIST01').AsString;
            cdsAux.FieldByName('CTP_DESCRI').AsString   := FieldByName('CTP_HIST01').AsString;
            cdsAux.FieldByName('CTP_HIST02').AsString   := FieldByName('CTP_HIST02').AsString;
            cdsAux.FieldByName('CTP_HISBAI').AsString   := fRetHisBai;
            cdsAux.FieldByName('FOR_FONE01').AsString   := FieldByName('FOR_FONE01').AsString;
            cdsAux.FieldByName('FOR_F_A_X_').AsString   := FieldByName('FOR_F_A_X_').AsString;
            cdsAux.FieldByName('FOR_C_G_C_').AsString   := FieldByName('FOR_C_G_C_').AsString;
            cdsAux.FieldByName('CTP_CODVEL').AsString   := FieldByName('CTP_CODVEL').AsString;
            cdsAux.FieldByName('CTP_PREVIS').AsString   := FieldByName('CTP_PREVIS').AsString;
            cdsAux.FieldByName('CTP_VEIOBO').AsString   := FieldByName('CTP_VEIOBO').AsString;
            cdsAux.FieldByName('CTP_MARDES').AsString   := FieldByName('CTP_MARDES').AsString;
            cdsAux.FieldByName('CTP_TIPBAI').AsString   := FieldByName('CTP_TIPBAI').AsString;
            cdsAux.FieldByName('CTP_TIPDES').AsString   := FieldByName('CTP_TIPDES').AsString;
            cdsAux.FieldByName('EMP_NOMEMP').AsString   := FieldByName('EMP_NOMEMP').AsString;
            cdsAux.FieldByName('POR_NOMPOR').AsString   := FieldByName('POR_NOMPOR').AsString;
            cdsAux.FieldByName('POR_LISTAR').Text       := fRetListPortadores(False,
                                                                              LDatasetCadPag);

            cdsAux.FieldByName('CTP_CHQAVI').AsFloat    := fltChqVis;
            cdsAux.FieldByName('CTP_DINHEI').AsFloat    := fltDinRec;
            cdsAux.FieldByName('CTP_ORDPAG').AsFloat    := fltOrdPag;
            cdsAux.FieldByName('CTP_REPCHQ').AsFloat    := fltRepChq;

            If (blnResumoCaixa) Then
              cdsAux.FieldByName('RCX_CAIXA').AsString := objResumoDeCaixa.fRetornaDadosLancamentosCaixaSeqCon(intSeqCon.ToString,
                                                                                                               VS_strCodEmp,
                                                                                                               FieldByName('CTP_DTAPAG').AsDateTime)
                                                                          .FieldByName('RCX_CODCAX').AsString;

            {Este campo apresenta as informações do cheque Banco-Agência-Conta-Data de Emissão}
            cdsAux.FieldByName('POR_LISTAR2').Text      := fRetListPortadores(True,
                                                                              LDatasetCadPag);

            cdsAux.FieldByName('CTP_FORMAS').Text       := fRetListFormasPagto(dblDinheiro,
                                                                               dblChequeVista,
                                                                               dblChequeRepasse,
                                                                               dblDeposito,
                                                                               LDatasetCadPag);

            strSQL := '';
            strSQL := strSQL + 'SELECT MOVBAN.CTB_CODPOR, CHQEMI.EMI_CODBCO, CHQEMI.EMI_CONCOR,   ';
            strSQL := strSQL + '       CHQEMI.EMI_NUMAGE, CHQEMI.EMI_NUMCHQ, BANCHQ.CHQ_VALCHQ,   ';
            strSQL := strSQL + '       CADPOR.POR_NOMPOR                                          ';
            strSQL := strSQL + 'FROM CADPAG                                                       ';
            strSQL := strSQL + 'INNER JOIN MOVBAN ON (MOVBAN.CTB_PAGCON = CADPAG.CTP_SEQCON)      ';
            strSQL := strSQL + 'INNER JOIN CADPOR ON (CADPOR.POR_CODPOR = MOVBAN.CTB_CODPOR)      ';
            strSQL := strSQL + 'INNER JOIN BANCHQ ON (BANCHQ.CTB_SEQLAN = MOVBAN.CTB_SEQLAN)      ';
            strSQL := strSQL + 'INNER JOIN CHQEMI ON (CHQEMI.EMI_CODBCO = BANCHQ.CHQ_CODBCO AND   ';
            strSQL := strSQL + '                      CHQEMI.EMI_NUMAGE = BANCHQ.CHQ_NUMAGE AND   ';
            strSQL := strSQL + '                      CHQEMI.EMI_CONCOR = BANCHQ.CHQ_CONCOR AND   ';
            strSQL := strSQL + '                      CHQEMI.EMI_NUMCHQ = BANCHQ.CHQ_NUMCHQ)      ';
            strSQL := strSQL + 'WHERE ';
            strSQL := strSQL + '  MOVBAN.CTB_CODEMP = ' + QuotedStr(VS_strCodEmp)+' AND ';
            strSQL := strSQL + '  CADPAG.CTP_NUMDUP = '+QuotedStr(FieldByName('NRODUP').AsString)    +' AND ';
            strSQL := strSQL + '  CADPAG.CTP_PARCEL = '+QuotedStr(FieldByName('PARDUP').AsString)    +' AND ';
            strSQL := strSQL + '  CADPAG.CTP_CODEMP = '+QuotedStr(FieldByName('CTP_CODEMP').AsString)+' AND ';
            strSQL := strSQL + '  CADPAG.CTP_CODFOR = '+QuotedStr(FieldByName('CTP_CODFOR').AsString)+' AND ';
            if fEmptyStr(FieldByName('CTP_SERIE_').AsString) then
              strSQL := strSQL + '  ((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = "")) '
            Else
              strSQL := strSQL + '  CTP_SERIE_ = '+QuotedStr(FieldByName('CTP_SERIE_').AsString)+' ';
            strSQL := strSQL + 'GROUP BY MOVBAN.CTB_CODPOR, CHQEMI.EMI_CODBCO, CHQEMI.EMI_CONCOR, ';
            strSQL := strSQL + '         CHQEMI.EMI_NUMAGE, CHQEMI.EMI_NUMCHQ, BANCHQ.CHQ_VALCHQ  ';


            qryChq_Emi_Baixa.Close;
            qryChq_Emi_Baixa.sql.clear;
            qryChq_Emi_Baixa.sql.Add(strSQL);
            qryChq_Emi_Baixa.open;

            tslChqEmi := fRetChequesEmi;

            cdsAux.FieldByName('CTB_CODPOR').AsString := tslChqEmi.Strings[0];
            cdsAux.FieldByName('EMI_NOMPOR').AsString := tslChqEmi.Strings[1];
            cdsAux.FieldByName('EMI_CODBCO').AsString := tslChqEmi.Strings[2];
            cdsAux.FieldByName('EMI_CONCOR').AsString := tslChqEmi.Strings[3];
            cdsAux.FieldByName('EMI_NUMAGE').AsString := tslChqEmi.Strings[4];
            cdsAux.FieldByName('EMI_NUMCHQ').AsString := tslChqEmi.Strings[5];
            cdsAux.FieldByName('EMI_VALCHQ').AsFloat  := fStrToFloat(tslChqEmi.Strings[6]);

            qryChq_Rep_Baixa.Close;
            qryChq_Rep_Baixa.sql.clear;
            qryChq_Rep_Baixa.sql.Add(strSQL);
            qryChq_Rep_Baixa.open;

            strSQL := 'SELECT MOVBAN.CTB_CODPOR, CADCHQ.CHQ_CODBCO, CADCHQ.CHQ_CONCOR,   ';
            strSQL := strSQL + '       CADCHQ.CHQ_NUMAGE, CADCHQ.CHQ_NUMCHQ, CADCHQ.CHQ_VALCHQ,   ';
            strSQL := strSQL + '       CADPOR.POR_NOMPOR, CADCHQ.CHQ_NOMEMI, CADCHQ.CHQ_DTAVEN,   ';
            strSQL := strSQL + '       CADCHQ.CHQ_DTAREP                                          ';
            strSQL := strSQL + 'FROM CADPAG                                                       ';
            strSQL := strSQL + 'INNER JOIN MOVBAN ON (MOVBAN.CTB_PAGCON = CADPAG.CTP_SEQCON)      ';
            strSQL := strSQL + 'INNER JOIN CADPOR ON (CADPOR.POR_CODPOR = MOVBAN.CTB_CODPOR)      ';
            strSQL := strSQL + 'INNER JOIN BANCHQ ON (BANCHQ.CTB_SEQLAN = MOVBAN.CTB_SEQLAN)      ';
            strSQL := strSQL + 'INNER JOIN CADCHQ ON (CADCHQ.CHQ_CODBCO = BANCHQ.CHQ_CODBCO AND   ';
            strSQL := strSQL + '                      CADCHQ.CHQ_NUMAGE = BANCHQ.CHQ_NUMAGE AND   ';
            strSQL := strSQL + '                      CADCHQ.CHQ_CONCOR = BANCHQ.CHQ_CONCOR AND   ';
            strSQL := strSQL + '                      CADCHQ.CHQ_NUMCHQ = BANCHQ.CHQ_NUMCHQ)      ';
            strSQL := strSQL + 'WHERE ';
            strSQL := strSQL + '      MOVBAN.CTB_CODEMP = ' + QuotedStr(VS_strCodEmp)+' AND ';
            strSQL := strSQL + '  CADPAG.CTP_NUMDUP = '+QuotedStr(FieldByName('NRODUP').AsString)    +' AND ';
            strSQL := strSQL + '  CADPAG.CTP_PARCEL = '+QuotedStr(FieldByName('PARDUP').AsString)    +' AND ';
            strSQL := strSQL + '  CADPAG.CTP_CODEMP = '+QuotedStr(FieldByName('CTP_CODEMP').AsString)+' AND ';
            strSQL := strSQL + '  CADPAG.CTP_CODFOR = '+QuotedStr(FieldByName('CTP_CODFOR').AsString)+' AND ';
            if fEmptyStr(FieldByName('CTP_SERIE_').AsString) then
              strSQL := strSQL + '  ((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = "")) '
            Else
              strSQL := strSQL + '  CTP_SERIE_ = '+QuotedStr(FieldByName('CTP_SERIE_').AsString)+' ';
            strSQL := strSQL + 'GROUP BY MOVBAN.CTB_CODPOR, CADCHQ.CHQ_CODBCO, CADCHQ.CHQ_CONCOR, ';
            strSQL := strSQL + '         CADCHQ.CHQ_NUMAGE, CADCHQ.CHQ_NUMCHQ, CADCHQ.CHQ_VALCHQ  ';


            qryChq_Rep_Baixa.Close;
            qryChq_Rep_Baixa.sql.clear;
            qryChq_Rep_Baixa.sql.Add(strSQL);
            qryChq_Rep_Baixa.open;

            tslChqRep := fRetChequesRep;

            cdsAux.FieldByName('CTB_CODPOR').AsString   := tslChqRep.Strings[0];
            cdsAux.FieldByName('CHQ_NOMPOR').AsString   := tslChqRep.Strings[1];
            cdsAux.FieldByName('CHQ_CODBCO').AsString   := tslChqRep.Strings[2];
            cdsAux.FieldByName('CHQ_CONCOR').AsString   := tslChqRep.Strings[3];
            cdsAux.FieldByName('CHQ_NUMAGE').AsString   := tslChqRep.Strings[4];
            cdsAux.FieldByName('CHQ_NUMCHQ').AsString   := tslChqRep.Strings[5];
            cdsAux.FieldByName('CHQ_VALCHQ').AsFloat    := fStrToFloat(tslChqRep.Strings[6]);
            cdsAux.FieldByName('CHQ_NOMEMI').AsString   := tslChqRep.Strings[7];
            if tslChqRep.Strings[8] <> '' then
              cdsAux.FieldByName('CHQ_DTAVEN').AsDateTime := strtodatedef(tslChqRep.Strings[8],0);
            if tslChqRep.Strings[9] <> '' then
            cdsAux.FieldByName('CHQ_DTAREP').AsDateTime := strtodatedef(tslChqRep.Strings[9],0);

            If (fCfgSis('RECCTP') = 'S') And (fCfgSis('RECCPV', varInteger) > 1) Then
            Begin
              cdsAux.FieldByName('CTP_VIAIMP').AsInteger := intContVia;
              cdsAux.FieldByName('CTP_QTVIAS').AsInteger := intQtdVias;
            End;

            cdsAux.Post;

            Next;
          End;
        End;
      End;

      FreeAndNil(repMovBan);
      FreeAndNil(repCadPag);

      editorFast := TFastPrintFileEditor.Create(Self);

      If (fCfgSis('RECCTP') = 'S')  And (fCfgSis('RECCPV', varInteger) > 1) Then
      Begin
        reciboCtpMeiaFolha  := TReciboCtpMeiaFolha.CreateInstance(cdsAux);
        editorFast.pSetFastPrintFile(reciboCtpMeiaFolha);
      End
      Else
      Begin
        reciboCtp  := TReciboCtp.CreateInstance(cdsAux);
        editorFast.pSetFastPrintFile(reciboCtp);
      End;

      editorFast.pSelectFil(Self.Name, strNomFil, fRetNomeRede);

      If editorFast.fLoadReport Then
      Begin

        If Not Result Then
          Result := True;

        If Not cdsAux.IsEmpty Then
          editorFast.pPrint;

      End;

      FreeAndNil(editorFast);
    End;

    FreeAndNil(cdsAux);

    If Assigned(LDatasetCadPag) Then
      FreeAndNil(LDatasetCadPag);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmBaixaCtaPagar.fImprimeReciboLayout]');
    End;
  End;
end;

function TfrmBaixaCtaPagar.fRetListFormasPagto(out dinheiro, chequeVista, chequeRepasse, deposito: Double;
  ADatasetCadPag: TDataset): String;
begin
  Result := EmptyStr;

  Try
    If fFormataFloat(ADatasetCadPag.FieldByName('CTP_DINHEI').AsFloat, 2) <> 0.00 Then
    Begin
      dinheiro := dinheiro + fFormataFloat(ADatasetCadPag.FieldByName('CTP_DINHEI').AsFloat, 2);

      Result := Result + fPadL('DINHEIRO', 19) + ' - ' +
                         fPadL(FloatToStrF(dinheiro, ffFixed, 12, 2), 10) + #13#10;
    End;

    If fFormataFloat(ADatasetCadPag.FieldByName('CTP_CHQAVI').AsFloat, 2) <> 0.00 Then
    Begin
      chequeVista := chequeVista + fFormataFloat(ADatasetCadPag.FieldByName('CTP_CHQAVI').AsFloat, 2);

      Result := Result + fPadL('CHEQUE EMITIDO', 19) + ' - ' +
                         fPadL(FloatToStrF(chequeVista, ffFixed, 12, 2), 10) + #13#10;
    End;

    If fFormataFloat(ADatasetCadPag.FieldByName('CTP_ORDPAG').AsFloat, 2) <> 0.00 Then
    Begin
      deposito := deposito + fFormataFloat(ADatasetCadPag.FieldByName('CTP_ORDPAG').AsFloat, 2);

      Result := Result + fPadL('DEPÓSITO BANCÁRIO', 19) + ' - ' +
                         fPadL(FloatToStrF(deposito, ffFixed, 12, 2), 10) + #13#10;
    End;

    If fFormataFloat(ADatasetCadPag.FieldByName('CTP_REPCHQ').AsFloat, 2) <> 0.00 Then
    Begin
      chequeRepasse := chequeRepasse + fFormataFloat(ADatasetCadPag.FieldByName('CTP_REPCHQ').AsFloat, 2);

      Result := Result + fPadL('CHEQUE DE TERCEIROS', 19) + ' - ' +
                         fPadL(FloatToStrF(chequeRepasse, ffFixed, 12, 2), 10) + #13#10;
    End;
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao trazer as infomrações da duplicata na impressão do recibo.' +
                             'Erro gerado: ' + E.Message);
  End;
end;

function TfrmBaixaCtaPagar.fRetListPortadores(blnAddInfoCheques: Boolean; ADatasetCadPag: TDataset): String;
  Var
    strDadosChq: String;
    intPosPipe: integer;
    strDatas: string;

    LConsultaChq,
    LConsultaCtb : TUniQuery;
Begin
  Result := EmptyStr;

  LConsultaChq := fCriaQuery;
  LConsultaCtb := fCriaQuery;
  Try
    LConsultaCtb.SQL.Text := 'SELECT M.CTB_SEQLAN, M.CTB_CODPOR, M.CTB_VALLAN, P.POR_NOMPOR ' +
                             'FROM MOVBAN M ' +
                             'JOIN CADPOR P ON P.POR_CODPOR=M.CTB_CODPOR ' +
                             'WHERE M.CTB_CODEMP=:EMPBAI ' +
                             '  AND M.CTB_PAGCON=:SEQCON ' +
                             '  AND M.CTB_DTALAN>=:DTAPAG ';
    If fCfgSis('CTP_AS') = 'A' Then
    Begin
      LConsultaCtb.SQL.Add('  AND M.CTB_CODFOR=:CODFOR');
      LConsultaCtb.ParamByName('CODFOR').AsString := ADatasetCadPag.FieldByName('CTP_CODFOR').AsString;
    End;

    LConsultaCtb.ParamByName('EMPBAI').AsString := ADatasetCadPag.FieldByName('CTP_EMPBAI').AsString;
    LConsultaCtb.ParamByName('SEQCON').AsInteger := ADatasetCadPag.FieldByName('CTP_SEQCON').AsInteger;
    LConsultaCtb.ParamByName('DTAPAG').AsDateTime := ADatasetCadPag.FieldByName('CTP_DTAPAG').AsDateTime;

    LConsultaCtb.Open;

    While Not LConsultaCtb.Eof Do
    Begin
      Result := Result +
                LConsultaCtb.FieldByName('CTB_CODPOR').AsString + '-' +
                fPadR(LConsultaCtb.FieldByName('POR_NOMPOR').AsString,69) +
                fPadL(FloatToStrF(LConsultaCtb.FieldByName('CTB_VALLAN').AsFloat,ffFixed,12,2), 10) + #13#10;

      if (blnAddInfoCheques) then
      begin
        strDadosChq := '';

        LConsultaChq.SQL.Text := 'SELECT * FROM BANCHQ WHERE CTB_SEQLAN=:SEQLAN';
        LConsultaChq.ParamByName('SEQLAN').AsString := LConsultaCtb.FieldByName('CTB_SEQLAN').AsString;
        LConsultaChq.Open;

        if Not LConsultaChq.IsEmpty then
        begin
          strDatas   := fRetDataEmissaoCheque(LConsultaChq);

          intPosPipe := Pos('|', strDatas);

          strDadosChq := 'Chq: '      + LConsultaChq.FieldByName('CHQ_NUMCHQ').AsString + ' ' +
                         'Bco: '      + LConsultaChq.FieldByName('CHQ_CODBCO').AsString +
                         ' AG: '      + LConsultaChq.FieldByName('CHQ_NUMAGE').AsString +
                         ' CC: '      + LConsultaChq.FieldByName('CHQ_CONCOR').AsString +
                         IIF( intPosPipe > 0, ' Vcto: ' + Copy( strDatas, 1, intPosPipe-1 )+' '+
                                              ' Emit: ' + Copy( strDatas, intPosPipe+1, intPosPipe ),
                                              ' Emit: ' + strDatas);
        end;

        if (strDadosChq <> '') then
          Result := Result + fPadR(strDadosChq, 85) + #13#10;

      end;

      LConsultaCtb.Next;
    End;
  Finally
    LConsultaChq.Close;
    LConsultaCtb.Close;

    FreeAndNil(LConsultaChq);
    FreeAndNil(LConsultaCtb);
  End;
End;

function TfrmBaixaCtaPagar.fRetDataEmissaoCheque(ADatasetBanChq: TDataset): String;
  var
    qryChqEmi : TUniQuery;
    strSQL    : String;

    LCompleto: Boolean;
begin

  Result := '';

  if ADatasetBanChq.IsEmpty then
    Exit;

  LCompleto := Not ADatasetBanChq.FieldByName('CHQ_NUMCHQ').AsString.IsEmpty;
  If LCompleto Then
  Begin
    LCompleto := Not ADatasetBanChq.FieldByName('CHQ_CODBCO').AsString.IsEmpty;

    If LCompleto Then
    Begin
      LCompleto := Not ADatasetBanChq.FieldByName('CHQ_NUMAGE').AsString.IsEmpty;

      If LCompleto Then
        LCompleto := Not ADatasetBanChq.FieldByName('CHQ_CONCOR').AsString.IsEmpty;
    End;
  End;

  If Not LCompleto Then
    Exit;

  strSQL := 'SELECT EMI_BOMPAR, EMI_DTAEMI FROM CHQEMI WHERE ';
  strSQL := strSQL + 'EMI_NUMCHQ = ' + QuotedStr(ADatasetBanChq.FieldByName('CHQ_NUMCHQ').AsString) + ' AND ';
  strSQL := strSQL + 'EMI_CODBCO = ' + QuotedStr(ADatasetBanChq.FieldByName('CHQ_CODBCO').AsString) + ' AND ';
  strSQL := strSQL + 'EMI_NUMAGE = ' + QuotedStr(ADatasetBanChq.FieldByName('CHQ_NUMAGE').AsString) + ' AND ';
  strSQL := strSQL + 'EMI_CONCOR = ' + QuotedStr(ADatasetBanChq.FieldByName('CHQ_CONCOR').AsString);

  qryChqEmi := fCriaQuery(Self);

  try

    qryChqEmi.SQL.Text := strSQL;
    qryChqEmi.Open;

    if not qryChqEmi.IsEmpty then
    begin
      Result := qryChqEmi.FieldByName('EMI_DTAEMI').AsString;
      if not qryChqEmi.FieldByName('EMI_BOMPAR').isNull then
        Result := qryChqEmi.FieldByName('EMI_BOMPAR').asString+'|'+qryChqEmi.FieldByName('EMI_DTAEMI').AsString;
    end;

  finally
    FreeAndNil(qryChqEmi);
  end;
end;

procedure TfrmBaixaCtaPagar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pLiberaDupsMarcadas;
  If Assigned(dicChqEmi)     Then FreeAndNil(dicChqEmi);
  If Assigned(dicChqRep)     Then FreeAndNil(dicChqRep);
  If Assigned(objLogLibCtp) Then FreeAndNil(objLogLibCtp);

  If Assigned(FConfiguracaoGrid) Then
    FreeAndNil(FConfiguracaoGrid);
end;

procedure TfrmBaixaCtaPagar.FormCreate(Sender: TObject);
begin
  inherited;
  If (Assigned(frwk)) And
     (Assigned(frwk.objDBManager)) then
    frwk.objDBManager.Clear;

  lstFornecedor := TStringList.Create;
  strAceCtp:= fGetEmpAceCtp;
  strChamada := '';

  objLiberacao := TLiberacao.create;
  objLock := TLock.Create;

  fltValorBaixa :=  0;
  strCodPorFix  := '';
  SetLength(arrSeqLan, 0);
  SetLength(arrLogLib, 0);

  intSeqCon := 0;
  blnResumoCaixa := False;

  stlSeqCon := TStringList.Create;
  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryConPor := fCriarQuery('SELECT * FROM CADPOR WHERE FALSE', Self);

  qryCadPag := fCriarQuery('SELECT * FROM CADPAG WHERE FALSE', Self);
  qryCadPag.FieldByName('CTP_DTACAD').OnSetText := pqryCadPagCTP_DTACADSetText;
  qryCadPag.Open;

  cdsCtaPag := TUniClientDataSet.Create(Self);
  cdsCtaPag.AfterScroll := pAtualizaDados;
  cdsCtaPag.OnFilterRecord := pFilterRecord;
  dtsCtaPag := fCriaDataSource(cdsCtaPag);
  dbgDuplicatasView.DataController.DataSource := dtsCtaPag;

  frxReciboJ.AddFunction('function fFormataFoneInterna(strFone: String): String');
  frxReciboM.AddFunction('function fFormataFoneInterna(strFone: String): String');

  frxReciboM.AddFunction('procedure pDecrementaQtdReg');
  frxReciboJ.AddFunction('procedure pDecrementaQtdReg');

  pCriarFormularios(TfrmQckCopiaCheque, frmQckCopiaCheque);

  blnGravaMovBanSemDesmembrar := (fCfgSis('PRBAMB', varInteger) = 2);

  FillChar(recUltDupBaixada, SizeOf(recUltDupBaixada), #0);

  blnBaiChqAna := (fCfgSis('CHQ_AS', varString) = 'A');
  btnBordero.Visible := fCfgSis('CTPBOR', varBoolean);
  blnCarregaBaixa := False;
  btnAlterarValor.Enabled := fVerificaAcessoSistema('CTPALTVLR', strLoginUsuarioLogado);

  blnUsaLiberacaoDePrevisao := fCfgSis('CTPPRE', varBoolean);

  blnUsaTravaMsgPagtoAntecipado := fCfgSis('MBXANT', varBoolean);

  strCodigoCaixa := '';
  objLogLibCtp := TLogLibCtp.Create;
  strAutoIncremTodas := '';
  blnMarcarTodas    := False;
  blnDuploClickGrid := False;
end;

procedure TfrmBaixaCtaPagar.pqryCadPagCTP_DTACADSetText(Sender: TField; const Text: String);
begin
  If (fEmptyStr(fTiraCaracEspeciais(Text))) Then
    TDateField(Sender).AsVariant := Null
  Else
    TDateField(Sender).AsVariant := Text;
end;

procedure TfrmBaixaCtaPagar.btnAlterarValorClick(Sender: TObject);
Var
  fltNovoValor: Double;
  strSQL: String;
  qryAux: TUniQuery;
  frmAltValor : TfrmAltValor;
begin
  inherited;

  fltNovoValor := 0;
  qryAux := fCriaQuery(Nil);

  If not btnAlterarValor.Enabled Then
    Exit;

  If cdsCtaPag.IsEmpty Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  If cdsCtaPag.FieldByName('CTP_MARDES').AsString = 'M' Then
  Begin
    fMensagem('', 'Este título está marcado para baixa e não pode ter seu valor alterado. '+
                  'Caso deseje alterar o valor do mesmo, desmarque-o!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmAltValor, frmAltValor);
    frmAltValor.Position := poScreenCenter;
    frmAltValor.edtValAtual.Text := FormatFloat('#,##0.00', cdsCtaPag.FieldByName('CTP_VALDUP').AsFloat);
    frmAltValor.ShowModal;
    If frmAltValor.ModalResult = mrOk Then
      fltNovoValor := fFormataFloat(fStrToFloat(frmAltValor.edtNovoValor.Text), 2);

    If fltNovoValor <> 0 Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  CADPAG ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  CTP_VALDUP = :VALDUP, ';
      strSQL := strSQL + '  CTP_VALORI = :VALDUP ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
      strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';
      strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
      strSQL := strSQL + '  IFNULL(CTP_SERIE_,"") = :SERIE_ AND ';
      strSQL := strSQL + '  CTP_SEQBAI = :SEQBAI ';

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(strSQL);
      qryAux.ParamByName('VALDUP').AsFloat   := fltNovoValor;
      qryAux.ParamByName('NUMDUP').AsString  := cdsCtaPag.FieldByName('NRODUP').AsString;
      qryAux.ParamByName('CODEMP').AsString  := cdsCtaPag.FieldByName('CTP_CODEMP').AsString;
      qryAux.ParamByName('CODFOR').AsString  := cdsCtaPag.FieldByName('CTP_CODFOR').AsString;
      qryAux.ParamByName('SERIE_').AsString  := cdsCtaPag.FieldByName('CTP_SERIE_').AsString;
      qryAux.ParamByName('PARCEL').AsString  := cdsCtaPag.FieldByName('PARDUP').AsString;
      qryAux.ParamByName('SEQBAI').AsInteger := cdsCtaPag.FieldByName('CTP_SEQBAI').AsInteger;
      qryAux.ExecSQL;

      GravaLogCtp(cdsCtaPag.FieldByName('NRODUP').AsString,
                  cdsCtaPag.FieldByName('PARDUP').AsString,
                  cdsCtaPag.FieldByName('CTP_SEQBAI').AsInteger,
                  cdsCtaPag.FieldByName('CTP_CODEMP').AsString,
                  cdsCtaPag.FieldByName('CTP_CODFOR').AsString,
                  cdsCtaPag.FieldByName('CTP_SERIE_').AsString,
                  'ALTERAÇÃO DO VALDUP: DE '+ FormatFloat('#,##0.00', cdsCtaPag.FieldByName('CTP_VALDUP').AsFloat) + ' PARA ' + frmAltValor.edtNovoValor.Text);

      btnConsultar.Click;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[]');
    End;
  End;

  pFreeAndNil(frmAltValor);
  pFreeAndNil(qryAux);
end;

procedure TfrmBaixaCtaPagar.btnBorderoClick(Sender: TObject);
begin
  inherited;
  FArquivoBorderoPDF := '';
  If not btnBordero.Enabled Then
    Exit;

  If (StrToIntDef(edtQtdSelecionadas.Text, 0) <= 0) Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;
  If (Not fEmptyStr(edtTotalPago.Text)) Then
  Begin

  	If Not fVerificaAcessoSistema('CTPEMITBORDERO', strLoginUsuarioLogado) Then
 		Begin
      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'CTPEMITBORDERO';
      objLiberacao.strSenLib    := fCfgSis('CTPBRD');
      objLiberacao.strMsgSen    := 'Emissão de Borderô';
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto('Emitir Borderô Antes de Efetuar Baixa');

      If not objLiberacao.fLibera then
      	Exit;
    End;
    If fBaixaDuplicatas(True) Then
    Begin

      If pnlCabecalho.Visible Then
      Begin

        If chkLimFil.Checked Then
        Begin
          pLimpaEdits;
          blnMudarFoco := False;
          pSetFocus(edtCodFor);
        End
        Else
        Begin
          TfrmGravando.fExecutarModal(pAtualizaTemporaria, 'Aguarde... Carregando Títulos', '');
          If (Not dbgDuplicatasView.DataController.DataSource.Dataset.Active) Or
           (dbgDuplicatasView.DataController.DataSource.Dataset.RecordCount = 0) Then
          pLimpaEdits;
        End;

      End
      Else
        TfrmGravando.fExecutarModal(pAtualizaTemporaria, 'Aguarde... Carregando Títulos', '');

    End;
  End;
  pSetFocus(Self);

  If Not fEmptyStr(FArquivoBorderoPDF) Then
    ShellExecute(Handle, nil, PChar(FArquivoBorderoPDF), nil, nil, SW_SHOWMAXIMIZED);
end;

procedure TfrmBaixaCtaPagar.btnConfigurarGridClick(Sender: TObject);
  Var
    LConfiguracaoGrids: TfrmConfiguracaoGrids;
begin
  inherited;

  pCriarFormularios(TfrmConfiguracaoGrids, LConfiguracaoGrids);

  Try
    LConfiguracaoGrids.ConfiguracaoGridsObj := FConfiguracaoGrid;
    LConfiguracaoGrids.ChaveGrid := Concat(Self.Name, '.', dbgDuplicatasView.Name);
    LConfiguracaoGrids.DatasetCampos := dbgDuplicatasView.DataController.Dataset;
    LConfiguracaoGrids.WidthAutomaticoCampos := False;
    LConfiguracaoGrids.ShowModal;

    if (LConfiguracaoGrids.Confirmar) Then
      FConfiguracaoGrid.CarregarDadosSalvos(dbgDuplicatasView);
  finally
    FreeAndNil(LConfiguracaoGrids);
  end;
end;

procedure TfrmBaixaCtaPagar.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  FControlFoco := Self;

  If ExisteDuplicatasSelecionadasNaoExibidasNoGrid Then
  begin
    fMensagem('ATENÇÃO', 'Não é possível prosseguir com a baixa, existe(m) duplicata(s) selecionada(s) ' + #13#10 +
                         'e ocultada(s) por filtros, favor verificar !', ['&Ok']);
    Exit;
  end;

  blnBaixaZeradaCTP := (fCfgSis('CTP_AS') = 'S') And
                       (Not blnResumoCaixa) And
                       (fStrToFloat(edtTotalPago.Text) = 0) And
                       ((StrToIntDef(edtQtdSelecionadas.Text, 0) > 1) Or
                        (fStrToFloat(edtDescontoTotal.Text) > 0));

  If (StrToIntDef(edtQtdSelecionadas.Text, 0) <= 0) Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  if (blnResumoCaixa and
     (Not fEmptyStr(edtTotalPago.Text)) and
     (Round(fStrToFloat(edtTotalPago.Text) * 100) > Round(objResumoDeCaixa.fRetornaSaldoCaixaCampo('RCX_DINREC', strCodigoCaixa) * 100))) then
  Begin
    fMensagem('', 'Saldo em caixa insuficiente para esta baixa!', ['&Ok']);
    Exit;
  End;

  If (Not fEmptyStr(edtTotalPago.Text)) Then
  Begin
    Try
      Self.Enabled :=  False;

      If fBaixaDuplicatas Then
      Begin

        If fMensagem('', 'Deseja imprimir Recibo?', ['', ''], 2) = 1 Then
        Begin
          pImprimeRecibo(cdsCtaPag, Self);
        End;

        pLimpaCTRemAberto;

        If pnlCabecalho.Visible Then
        Begin

          If chkLimFil.Checked Then
          Begin
            pLimpaEdits;
            blnMudarFoco := False;
            FControlFoco := edtCodFor;
          End
          Else
            pAtualizaTemporaria;

        End
        Else
        Begin
          btnSairBaixa.Click;
          Exit;
        End;

        if (fltValorBaixa > 0) and (strCodPorFix <> '') then
        begin
          btnSairBaixa.Click;
          Exit;
        end;

      End;

    Finally
      Self.Enabled := True;
    End;

  End;
  pSetFocus(FControlFoco);
end;

procedure TfrmBaixaCtaPagar.btnConsultarClick(Sender: TObject);
begin
  inherited;

  If Not fValidaCampos(edtCodPor) Then
    pSetFocus(edtCodPor)
  Else If Not fValidaCampos(mskDtaCadFin) Then
    pSetFocus(mskDtaCadFin)
  Else If Not fValidaCampos(mskDtaFin) Then
    pSetFocus(mskDtaFin)
  Else
  Begin
    FControlFoco := dbgDuplicatas;
    TfrmGravando.fExecutarModal(pAtualizaTemporaria, 'Aguarde... Carregando Títulos.', '');
    If pnlCabecalho.Visible Then
      pSetFocus(FControlFoco);
  End;
  strMarcacaoLog := '';
End;

procedure TfrmBaixaCtaPagar.btnDescontoGeralClick(Sender: TObject);
begin
  inherited;

  If (StrToIntDef(edtQtdSelecionadas.Text, 0) <= 0) Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  Application.ProcessMessages;
  Try
    pCriarFormularios(TfrmBaixaDescGeral, frmBaixaDescGeral);

    Try
      frmBaixaDescGeral.Position := poScreenCenter;
      frmBaixaDescGeral.blnCtaPagar   := True;
      frmBaixaDescGeral.cdsDuplicatas := cdsCtaPag;
      frmBaixaDescGeral.ShowModal;
    Except
    End;

    recDescontoGeral.fltValDes := frmBaixaDescGeral.fltValDes;
    recDescontoGeral.fltValBxa := frmBaixaDescGeral.fltValBaiTot;
    recDescontoGeral.blnConfir := frmBaixaDescGeral.blnConfirma;
    recDescontoGeral.strTipDes := frmBaixaDescGeral.strTipDes;
  Finally
    pFreeAndNil(frmBaixaDescGeral);
  End;

  If recDescontoGeral.blnConfir Then
    TfrmGravando.fExecutarModal(pAplicaDescontoGeral,'Aguarde... Aplicando desconto.','')
  Else
    pSetFocus(dbgDuplicatas);
end;

procedure TfrmBaixaCtaPagar.btnDesmarcarTodasClick(Sender: TObject);
begin
  inherited;
  If cdsCtaPag.IsEmpty Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  If Not btnDesmarcarTodas.Enabled Then
    Exit;

  If cdsCtaPag.IsEmpty Then
    Exit;

  If (Not btnDesmarcarTodas.Enabled) Then
    Exit;

  pCriarFormularios(TfrmGravando,frmGravando);
  Try
    frmGravando.fExecutarAcao := fDesmarcarTodos;
    frmGravando.lblGravando.Caption := 'Aguarde... Desmarcando Títulos.';
    frmGravando.ShowModal;
  Finally
    pFreeAndNil(frmGravando);
  End;

  If Pos('F8_', strMarcacaoLog) <= 0 Then
    strMarcacaoLog := strMarcacaoLog + 'F8_';
end;

procedure TfrmBaixaCtaPagar.btnDupAgrupClick(Sender: TObject);
begin

  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(82, 5367, [],
                        ['NUMAGR','CODEMP','CODFOR'],
                        [strNumAgrAG,
                        strCodEmpAG,
                        strCodForAG],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmBaixaCtaPagar.pLiberaDupsMarcadas;
begin
  With cdsCtaPag Do
  Begin
    Filtered := False;
    Filter := 'CTP_MARDES = '+ QuotedStr('M');
    Filtered := True;

    If Not IsEmpty Then
    Begin
      First;

      While Not Eof Do
      Begin
        objLock.fLock_Unlock(FieldByName('TABELA').AsString + FieldByName('AUTOINCREM').AsString, False);
        Next;
      End;
    End;
  End;

  pDestravaCheques;
end;

procedure TfrmBaixaCtaPagar.pLimpaEdits;
begin
  pLimpaEditsDuplicata;

  edtNomFor.Clear;
  fraPlanoDeContas.edtDesCta.Clear;
  fraCentroCusto.edtDesEve.Clear;
  edtNomEmp.Clear;
  edtDesPor.Clear;

  mskDtaIni.Clear;
  mskDtaFin.Clear;
  mskDtaCadIni.Clear;
  mskDtaCadFin.Clear;
  fraPlanoDeContas.MskCodCta.Clear;
  edtCodFor.Clear;
  fraCentroCusto.edtCodEve.Clear;
  edtCodEmp.Clear;
  edtCodPor.Clear;
  edtCodPrj.Clear;
  edtDesPrj.Clear;
  edtVlrIni.Value := 0;
  edtVlrFin.Value := 0;
  rdgLiberados.ItemIndex := 0;
  rdgVeioBo.ItemIndex := 2;

  chkFiltrarFiliais.Enabled := False;
  chkFiltrarFiliais.Checked := False;

  cdsCtaPag.AfterScroll := nil;
  Try
    pLiberaDupsMarcadas;
    cdsCtaPag.Filtered := False;
    cdsCtaPag.Close;
    pLimpaCTRemAberto;
  Finally
    cdsCtaPag.AfterScroll := pAtualizaDados;
  End;
end;

procedure TfrmBaixaCtaPagar.pLimpaEditsDuplicata;
begin
  edtQtdDuplicatas.Clear;
  edtQtdSelecionadas.Clear;
  edtTotalPago.Clear;
  edtValorTotal.Clear;
  edtTotDesconto.Clear;
  edtTotJuros.Clear;
  edtTotVendor.Clear;
  edtOutEnt.Clear;

  edtCodEveBai.Clear;
  edtDesEveBai.Clear;
  edtCodCtaBai.Clear;
  edtDesCtaBai.Clear;
  edtDtaCad.Clear;
  edtCodVel.Clear;
  edtPrevis.Clear;
  edtSerie.Clear;
  edtCompet.Clear;

  edtDescontoTotal.Clear;
  edtJurosTotal.Clear;
  edtVendorTotal.Clear;
  edtHistor.Clear;
  edtOutrasEntidades.Clear;
end;

procedure TfrmBaixaCtaPagar.btnIniBusClick(Sender: TObject);
begin
  inherited;
  If Not btnIniBus.Visible Then
    Exit;

  If cdsCtaPag.IsEmpty Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmBaixaCtpBusca, frmBaixaCtpBusca);
    frmBaixaCtpBusca.Position := poScreenCenter;
    if frmBaixaCtpBusca.ShowModal = mrOk then
      pConcluiBusca;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmBaixaCtaPagar.btnIniBusClick]');
    End;
  End;

  pFreeAndNil(frmBaixaCtpBusca);
  pSetFocus(Self);
end;

procedure TfrmBaixaCtaPagar.pConcluiBusca;
begin
  If fEmptyStr(frmBaixaCtpBusca.objFiltro.strValor) Then
    exit;

  cdsCtaPag.Filter := '';
  strValorFiltro := frmBaixaCtpBusca.objFiltro.strValor;
  strCampoFiltro := frmBaixaCtpBusca.objFiltro.strCampo;
  If Not cdsCtaPag.FindFirst Then
    fMensagem('ATENÇÃO!', 'Não há duplicatas para serem baixadas!', ['&O k']);

end;

procedure TfrmBaixaCtaPagar.pDestravaCheques;
  Var
    strChave : String;
begin
  If (Assigned(dicChqRep)) And (dicChqRep.Count > 0) Then
  Begin
    For strChave In dicChqRep.Keys Do
      objLock.fLock_Unlock('CADCHQ' + dicChqRep[strChave].strAutInc, False);
  End;
end;

procedure TfrmBaixaCtaPagar.btnLocProxClick(Sender: TObject);
begin
  inherited;

  If Not btnLocProx.Enabled Then
    Exit;

  If cdsCtaPag.IsEmpty Then
  Begin
    fMensagem('AVISO', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  If (Not cdsCtaPag.IsEmpty) And (Not fEmptyStr(strCampoFiltro)) Then
  Begin
    pLocalizaProximaDup;
  End
  Else
    fMensagem('ATENÇÃO!', 'A Busca não foi iniciada!', ['&Ok']);
end;

procedure TfrmBaixaCtaPagar.pLocalizaProximaDup;
begin
  If Not cdsCtaPag.FindNext Then
    fMensagem('ATENÇÃO!', 'Não há duplicatas para serem baixadas!', ['&O k']);
end;

procedure TfrmBaixaCtaPagar.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  If Not fEmptyStr(strCampoFiltro) Then
  begin
    if CompareText(strCampoFiltro, 'TOTDUP') = 0 then
      Accept := CompareText(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) = 0
    else
      Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
  end;
end;

procedure TfrmBaixaCtaPagar.pGravaNumChqSequencialPortador(strCodPor, strCodEmp, strNumAge, strCodBco, strNumCco, strNumChq: String);
  Var
    qryTmp : TUniQuery;
begin
  qryTmp := fCriaQuery(Self);

  Try
    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT *');
      SQL.Add('  FROM PORCHQ ');
      SQL.Add(' WHERE CHQ_CODPOR = :CODPOR ');
      SQL.Add('   AND CHQ_CODEMP = :CODEMP ');
      ParamByName('CODPOR').AsString := strCodPor;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      If RecordCount = 0 Then
      Begin
        Insert;
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PORCHQ', strCodemp);
        FieldByName('CHQ_CODPOR').AsString := strCodPor;
        FieldByName('CHQ_CODEMP').AsString := strCodEmp;
      End
      Else
      Begin
        Edit;
      End;

      FieldByName('CHQ_CODBCO').AsString := strCodBco;
      FieldByName('CHQ_NUMAGE').AsString := strNumAge;
      FieldByName('CHQ_NUMCCO').AsString := strNumCco;
      FieldByName('CHQ_NUMCHQ').AsString := strNumChq;
      Post;
      Close;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmBaixaCtaPagar.pGravaNumChqSequencialPortador]');
  End;

  FreeAndNil(qryTmp);
end;

procedure TfrmBaixaCtaPagar.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrFornec, fRetNomFornecedor, Nil, 'do Fornecedor');
  pHabilitaFiltroFiliais;
end;

procedure TfrmBaixaCtaPagar.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaCtaPagar.edtCodPorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPor, edtDesPor, arrPortador, Nil, fRetNomPortador, 'do Portador');
end;

procedure TfrmBaixaCtaPagar.edtCodPorKeyPress(Sender: TObject; var Key: Char);

begin
  inherited;

  If fPesqPortador(conSimples,
                   Self,
                   edtCodPor,
                   edtDesPor,
                   nil,
                   Key,
                   arrPortador,
                   False,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   edtCodEmp.Text) Then
    If fValidaCampos(edtCodPor) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmBaixaCtaPagar.edtCodPrjExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPrj, edtDesPrj, arrPrj, fRetNomeProjeto, Nil, 'do Projeto');
end;

procedure TfrmBaixaCtaPagar.edtCodPrjKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqProjetos(Self, edtCodPrj, edtDesPrj, nil, Key, arrPrj,False) Then
  Begin
    If fValidaCampos(edtCodPrj, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaCtaPagar.dbgDuplicatasViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  With cdsCtaPag Do
  Begin
    {*****************************************}
    {* CASO A TABELA ESTEJA FECHADA, SAI     *}
    {**************************************MV*}
    If Not Active Then
      Exit;

    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasCTP_MARDES.Index]) = 'M' Then
    Begin
      If AViewInfo.Selected Then
        ACanvas.Font.Color := clLime
      Else
        ACanvas.Font.Color := clBlue;
    End;

    If AViewInfo.Item.Caption = 'Liberado?' Then
    Begin
      if FUtilizaLiberacaoPendenteBaixa Then
      Begin
        If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasLIBERADO.Index]) = 'NÃO' Then
          ACanvas.Font.Color := clRed;
      End;
    End;;


    If AViewInfo.Item.Caption = 'Cheque?' Then
    Begin
      If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasCTP_USACHQ.Index]) = 'NÃO' Then
        ACanvas.Font.Color := clRed
      Else
      If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasCTP_USACHQ.Index]) = 'SIM' Then
      Begin
        If AViewInfo.Selected Then
          ACanvas.Font.Color := 13703910
        Else
          ACanvas.Font.Color := 5966692;
      End;
    End;

    If AViewInfo.Item.Caption = 'Veio Boleto?' Then
    Begin
      If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasCTP_VEIOBO.Index]) = 'NÃO' Then
        ACanvas.Font.Color := clRed
      Else
      If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasCTP_VEIOBO.Index]) = 'SIM' Then
      Begin
        If AViewInfo.Selected Then
          ACanvas.Font.Color := 13703910
        Else
          ACanvas.Font.Color := 5966692;
      End;
    End;

    If AViewInfo.Item.Caption = 'Previsão?' Then
    Begin
      If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasPREVISAO.Index]) = 'NÃO' Then
        ACanvas.Font.Color := clRed
      Else
      If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasPREVISAO.Index]) = 'SIM' Then
      Begin
        If AViewInfo.Selected Then
          ACanvas.Font.Color := 13703910
        Else
          ACanvas.Font.Color := 5966692;
      End;
    End;

    If AViewInfo.Item.Caption = 'Veio NF?' Then
    Begin
      If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasCTP_VEIONF.Index]) = 'NÃO' Then
        ACanvas.Font.Color := clRed
      Else
      If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasCTP_VEIONF.Index]) = 'SIM' Then
      Begin
        If AViewInfo.Selected Then
          ACanvas.Font.Color := 13703910
        Else
          ACanvas.Font.Color := 5966692;
      End;
    End;

    If AViewInfo.Item.Caption = 'Antecipação?' Then
    Begin
      If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasANTECIPACAO.Index]) = 'NÃO' Then
        ACanvas.Font.Color := clRed
      Else
      If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasANTECIPACAO.Index]) = 'SIM' Then
      Begin
        If AViewInfo.Selected Then
          ACanvas.Font.Color := 13703910
        Else
          ACanvas.Font.Color := 5966692;
      End;
    End;

    If AViewInfo.Selected Then
    Begin
      If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasCTP_SERIE_AG.Index]) = 'AG' Then
      Begin
        strCodEmpAG := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasCTP_CODEMP_AG.Index]);
        strNumAgrAG := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasCTP_NUMDUP_AG.Index]);
        strCodForAG := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasCTP_CODFOR_AG.Index]);
        btnDupAgrup.Visible := True;
      End
      Else
        btnDupAgrup.Visible := False;
  End;
  End;
end;

procedure TfrmBaixaCtaPagar.dbgDuplicatasViewDataControllerSummaryAfterSummary(
  ASender: TcxDataSummary);
begin
  inherited;
  pExibeTotais;
end;

procedure TfrmBaixaCtaPagar.dbgDuplicatasViewDblClick(Sender: TObject);
begin
  inherited;
  blnDuploClickGrid := True;
end;

procedure TfrmBaixaCtaPagar.dbgDuplicatasViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
    pSelecionaDuplicata;
end;

procedure TfrmBaixaCtaPagar.dbgDuplicatasViewMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  If (ssCtrl in Shift) And (Button = mbLeft) and (not blnDuploClickGrid) then
  begin
    pSelecionaDuplicata(True);
  end
  else if (blnDuploClickGrid) and (not (ssCtrl in Shift)) then
  begin
    pSelecionaDuplicata();
  end;

  blnDuploClickGrid := False;
end;



procedure TfrmBaixaCtaPagar.pRetDupSelecionadas(var intDupCx: Integer; Var fltTotCx: Double);
  Var
    cdsGen: TUniClientDataSet;
    fldTot: TAggregateField;
begin
  cdsGen := TUniClientDataSet.Create(Self);
  cdsGen.AggregatesActive := True;
  fldTot := TAggregateField.Create(Self);
  With fldTot Do
  Begin
    FieldName := 'FLDTOT';
    DataSet := cdsGen;
    DisplayFormat := '#,##0.00';
    Expression := 'SUM(CTP_VALPAG)';
    Active := True;
  End;

  With cdsGen Do
  Begin
    Data := cdsCtaPag.Data;

    intDupCx := 0;
    fltTotCx := 0.0;

    Filtered := False;
    Filter := 'CTP_MARDES = ' + QuotedStr('M');
    Filtered := True;

    If Not IsEmpty Then
    Begin
      intDupCx := RecordCount;
      If fldTot.Value <> Null Then
        fltTotCx := fldTot.Value;
    End;
  End;

  FreeAndNil(fldTot);
  FreeAndNil(cdsGen);
end;

{*******************************************}
{* MARCA TODAS AS DUPLICATAS COMO BAIXA    *}
{* TOTAL                                   *}
{****************************************MV*}
procedure TfrmBaixaCtaPagar.btnManutencaoClick(Sender: TObject);
begin
  inherited;
  If cdsCtaPag.IsEmpty Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  If fVerificaAcessoSistema('frmCadCtaPagar') Then
    pChamarManutencaoCtp
  Else
    pMensagemOk('Operador sem direito de acesso!');
end;

procedure TfrmBaixaCtaPagar.btnMarcarTodasClick(Sender: TObject);
var
  blnConfirma: Boolean;
begin

  inherited;
  If cdsCtaPag.IsEmpty Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  If Not btnMarcarTodas.Enabled Then
    Exit;

  If cdsCtaPag.IsEmpty Then
    Exit;

  If (Not btnMarcarTodas.Enabled) Then
    Exit;

  {***************************************}
  {* Movido para cá, pois foi adicionado *}
  {* Modal de aguarde                    *}
  {************************************FS*}
  intOpcao := fGetMenu('Selecione a opção', ['Todas as duplicatas', 'Informar o valor selecionado', 'Cancelar'], 1);

  If Not (intOpcao In [1,2]) Then Exit;

  fltValInf := 0.0;

  If intOpcao = 2 Then
  begin
    Try
      pCriarFormularios(TfrmDigValor, frmDigValor);
      frmDigValor.Position := poScreenCenter;
      frmDigValor.Caption := 'Pagamento';
      frmDigValor.ShowModal;
      If frmDigValor.ModalResult = mrOk Then
        fltValInf := fFormataFloat(fStrToFloat(frmDigValor.edtValor.Text), 2);
      If Pos('F7VS_', strMarcacaoLog) <= 0 Then
        strMarcacaoLog := strMarcacaoLog + 'F7VS_';
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[]');
      End;
    End;
    pFreeAndNil(frmDigValor);

    If fltValInf <= 0 Then
      Exit;
  end
  Else
  Begin
    If Pos('F7T_', strMarcacaoLog) <= 0 Then
      strMarcacaoLog := strMarcacaoLog + 'F7T_';
  End;

  pCriarFormularios(TfrmCtpDigData, frmCtpDigData);
  Try
    if (strCodPorFix <> '') and (fltValorBaixa <> 0) then
    begin
      dtaDtaPag := dteDtaPagFix;
      frmCtpDigData.BloqueiaData := True;;
      frmCtpDigData.poDtaData := dtaDtaPag;
    End;

    frmCtpDigData.Caption := 'Data de pagamento';
    frmCtpDigData.lblData.Caption := 'Data de pagamento';
   
    If Not Assigned(frmCtpDigData.cdsDupSel) Then
      frmCtpDigData.cdsDupSel := TUniClientDataSet.Create(Self);

    pCloneDataSet(frmCtpDigData.cdsDupSel, cdsCtaPag);
    frmCtpDigData.cdsDupSel.Filtered := False;
    frmCtpDigData.LValorInformadoParaBaixa := fltValInf;

    frmCtpDigData.ShowModal;

    blnConfirma := frmCtpDigData.confirma;

    If blnConfirma Then
    Begin
      dtaDtaPag := StrToDate(frmCtpDigData.mskData.Text);

      If  frmCtpDigData.LibDtaRet Then
      Begin
        blnMarcarTodas := True;
        strAutoIncremTodas := frmCtpDigData.strAutoInc;
      End Else
      Begin
        blnMarcarTodas := False;
        strAutoIncremTodas := '';
      End;
    End Else
    Begin
      With frmCtpDigData.cdsDupSel Do
      Begin
        First;
        ObjLogLibCtp.pRemoveLogLib(FieldByName('AUTOINCREM').AsString);
      End;
    End;


  Finally
    pFreeAndNil(frmCtpDigData);
  End;

  If blnConfirma Then
  Begin
    pCriarFormularios(TfrmGravando,frmGravando);
    Try
      frmGravando.fExecutarAcao := fMarcarTodos;
      frmGravando.lblGravando.Caption := 'Aguarde... Marcando Títulos.';
      frmGravando.ShowModal;
    Finally
      pFreeAndNil(frmGravando);
    End;
  End;
end;

function TfrmBaixaCtaPagar.fMarcarTodos(pgbProgresso: TcxProgressBar):Boolean;
  Var
    blnPossuiDuplicatasSemLiberarPrevisao: Boolean;
    blnPossuiDuplicatasComPagtoAntecipado: Boolean;
    LFornedoresComAntecipacao: String;
Begin
  Result := True;
  LFornedoresComAntecipacao := '';

  strTipBai := 'T';
  fltValJur := 0.0;
  fltValMul := 0.0;
  fltValDes := 0.0;
  fltVendor := 0.0;
  fltOutEnt := 0.0;

  blnPossuiDuplicatasSemLiberarPrevisao := False;
  blnPossuiDuplicatasComPagtoAntecipado := False;

  Application.ProcessMessages;

  Try
    With cdsCtaPag Do
    Begin
      DisableControls;

      First;
      pgbProgresso.Position := 0;
      pgbProgresso.Properties.Max := RecordCount;

      While Not Eof Do
      Begin
        If (blnUsaLiberacaoDePrevisao) And (cdsCtaPag.FieldByName('CTP_PREVIS').AsString = 'S') Then
        Begin
          blnPossuiDuplicatasSemLiberarPrevisao := True;
          cdsCtaPag.Next;
          pStepStatusSelecao(pgbProgresso);
          Continue;
        End;

        If (blnUsaTravaMsgPagtoAntecipado) And
           Not (Pos(cdsCtaPag.FieldByName('CTP_CODFOR').AsString,LFornedoresComAntecipacao) > 0) And
           FornecedorPossuiPagamentosAntecipados(cdsCtaPag.FieldByName('CTP_CODFOR').AsString) Then
        Begin
          blnPossuiDuplicatasComPagtoAntecipado := True;
          LFornedoresComAntecipacao := LFornedoresComAntecipacao + cdsCtaPag.FieldByName('CTP_CODFOR').AsString + ',';
        End;

        if ((Not (fCfgSis('CTPLBB', varBoolean) And (cdsCtaPag.FieldByName('CTP_DTALIB').IsNull))) Or fCfgSis('CTPBDP', varBoolean)) And
           fValidaValorBaixa(FieldByName('CTP_VALDUP').AsFloat) then
        Begin
          pMarcaDuplicata(False);

          strTipBai := 'T';
          fltValDes := 0.0;
          fltValJur := 0.0;
          fltValMul := 0.0;
          fltVendor := 0.0;
          fltOutEnt := 0.0;

          fltValPag := fFormataFloat(FieldByName('TOTDUP').AsFloat, 2);

          If (intOpcao = 2) Then
          Begin

            If fltValInf > 0 Then
            Begin

              If (fltValInf >= fltValPag) Then
              Begin
                fltValInf := fFormataFloat((fltValInf  - fltValPag), 2);
                fltValDes := FieldByName('CTP_DESSUJ').AsFloat;
                fltValJur := FieldByName('CTP_JURSUJ').AsFloat;
                fltValMul := FieldByName('CTP_MULSUJ').AsFloat;
              End
              Else
              Begin
                fltValPag := fltValInf;
                strTipBai := 'P';
                fltValInf := 0;
              End;

              If (strTipBai = 'P') And (fExisteCTRPag(FieldByName('AUTOINCREM').AsString)) Then
                Continue;

              If (strTipBai = 'P') And (FieldByName('CTP_PAGANT').AsString = 'S') Then
                Continue;

              pMarcaDuplicata(True);
            End;

          End
          Else
          Begin
            fltValDes := FieldByName('CTP_DESSUJ').AsFloat;
            fltValJur := FieldByName('CTP_JURSUJ').AsFloat;
            fltValMul := FieldByName('CTP_MULSUJ').AsFloat;
            pMarcaDuplicata(True);
          End;
        End;
        Next;
        pStepStatusSelecao(pgbProgresso);
        Application.ProcessMessages;
      End;
      First;
    End;
  Finally
    cdsCtaPag.EnableControls;
  End;

  pCalculaTotalDuplicatas(edtDescontoTotal, edtJurosTotal,edtMultaTotal,edtTotalPago, edtQtdSelecionadas, edtVendorTotal, edtOutrasEntidades, True);

  If blnPossuiDuplicatasSemLiberarPrevisao Then
    fMensagem('ATENÇÃO', 'Alguma(s) duplicata(s) não foi(ram) marcada(s) pois não foi feita a liberação de previsionamento.', ['&OK']);

  If blnPossuiDuplicatasComPagtoAntecipado Then
  Begin
    LFornedoresComAntecipacao := LeftStr(LFornedoresComAntecipacao, LFornedoresComAntecipacao.Length - 1);
    fMensagem('ATENÇÃO', 'O(s) fornecedor(es) ' + LFornedoresComAntecipacao + ' possui(em) pagamento(s) antecipado(s) para ser(em) utilizado(s), Verifique!', ['&OK']);
  End;


end;

function TfrmBaixaCtaPagar.fDesmarcarTodos(pgbProgresso: TcxProgressBar): Boolean;
Begin
  Result := True;

  Try
    With cdsCtaPag Do
    Begin
      DisableControls;

      First;
      pgbProgresso.Position := 0;
      pgbProgresso.Properties.Max := RecordCount;

      While Not Eof Do
      Begin
        pStepStatusSelecao(pgbProgresso);

        pMarcaDuplicata(False);

        objLogLibCtp.pRemoveLogLib(cdsCtaPag.FieldByName('AUTOINCREM').AsString);
        Next;
        Application.ProcessMessages;
      End;
      First;
    End;

  Finally
    cdsCtaPag.EnableControls;
  End;

  pCalculaTotalDuplicatas(edtDescontoTotal, edtJurosTotal,edtMultaTotal,edtTotalPago, edtQtdSelecionadas, edtVendorTotal, edtOutrasEntidades, True);
End;

function TfrmBaixaCtaPagar.fDuplicatasJaUtilizadasPorOutrosUsuarios: Boolean;
Begin
  Result := False;
  With cdsClone Do
  Begin
    If fVerificaDupBaixada(FieldByName('NRODUP').AsString,
                           FieldByName('PARDUP').AsString,
                           FieldByName('CTP_SERIE_').AsString,
                           FieldByName('CTP_CODEMP').AsString,
                           FieldByName('CTP_CODFOR').AsString,
                           FieldByName('CTP_SEQBAI').AsInteger,
                           FieldByName('TOTORI').AsFloat) Then //MF: 290852 - 03/07/23 FieldByName('TOTDUP').AsFloat) Then
    begin
      Result := True;
    End;
  End;
End;

function TfrmBaixaCtaPagar.fExisteCTRPag(strAutoIncrem: String): Boolean;
Var
  qryConsul: TUniQuery;
begin
  Result := False;
  If strAutoIncrem <> '' Then
  Begin
    qryConsul := fCriaQuery();
    With qryConsul Do
    Begin
      Sql.Clear;
      Sql.Text := 'SELECT * FROM CTRPAG WHERE PAG_AUTCTP = :AUTOINCREM';
      ParamByName('AUTOINCREM').AsString :=  strAutoIncrem;

      Open;

      If Not IsEmpty Then
        Result := True;

      Close;
    End;
    FreeAndNil(qryConsul);
  End;
end;

procedure TfrmBaixaCtaPagar.pCarregaEmpresa;
begin
  If Not fEmptyStr(edtCodEmp.Text) Then
  Begin
    edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
    pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  End
  Else
    edtNomEmp.Clear;
end;

procedure TfrmBaixaCtaPagar.pCarregaEventos;
begin
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

function TfrmBaixaCtaPagar.fGetEmpAceCtp: String;
begin
  Result:= fCampoTabela('OPE_EMPCTP', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]);

  Result := Copy(Result, 0, (Length(Result) -1));

  If Not fEmptyStr(Result) Then
    Result := AnsiReplaceStr(Result,'_', ',');

end;

function TfrmBaixaCtaPagar.fGetLstFornecedor: TStringList;
begin
  Result := lstFornecedor;
end;

procedure TfrmBaixaCtaPagar.FormShow(Sender: TObject);
  Var
    LConsulta: TUniQuery;

    LConsultaPrv: TUniDataSetProvider;
begin
  inherited;

  if fCfgSis('LBXCTP', varString)= '1' Then
    chkLimFil.Checked:=True
  Else If fCfgSis('LBXCTP', varString)= '2' Then
    chkLimFil.Checked:=False;

  strPortadorBaixaZeradaCTP := fCfgSis('PORBAI', varString);
  FUtilizaLiberacaoPendenteBaixa := fCfgSis('CTPLBB', varBoolean);
  dbgDuplicatasLIBERADO.Visible :=  FUtilizaLiberacaoPendenteBaixa;

  If (Not fCfgSis('CTPTUD', varBoolean)) Then
  Begin
    btnMarcarTodas.Enabled := False;
    btnMarcarTodas.Visible := False;
    btnConfirma.Left := btnMarcarTodas.Left;
  End;

  rdgLiberados.Visible := fCfgSis('CTPLBB', varBoolean);

  edtCodEmp.Text := IfThen((Pos(LeftStr(VS_strCodEmp,3), strAceCtp) > 0),VS_strCodEmp, '' ); //VS_strCodEmp;
  edtNomEmp.Text := IfThen((Pos(LeftStr(VS_strCodEmp,3), strAceCtp) > 0),fRetNomeEmpresa, '' ); //fRetNomeEmpresa;

  {*****************************************}
  {* VERIFICA SE UTILIZA O CAMPO VENDOR    *}
  {**************************************RV*}
  lblTotVendor.Visible   := fCfgSis('CTPVND', varBoolean);
  edtTotVendor.Visible   := fCfgSis('CTPVND', varBoolean);
  lblVendorTotal.Visible := fCfgSis('CTPVND', varBoolean);
  edtVendorTotal.Visible := fCfgSis('CTPVND', varBoolean);

  pnlCTREmAberto.Visible := fCfgSis('CLIFOR', varBoolean);

//  If Not fCfgSis('CTPVND', varBoolean) Then
//    edtCodCtaBai.Width := 276;

  edtVlrFin.Value := 0;
  edtVlrIni.Value := 0;

  if (strCodPorFix <> '') then
    dtaDtaPag := dteDtaPagFix;

  if Not pnlCabecalho.Visible Then
    pSetFocus(dbgDuplicatas);

  if blnCarregaBaixa then
  begin
    btnConsultar.Click;
    pSetFocus(dbgDuplicatas);
  end;
  pUtilizaRotinaProjeto;
  pAjustaCamposProjeto();
  strMarcacaoLog := '';

  LConsulta := fCriaQuery(Self);
  LConsultaPrv := TUniDataSetProvider.Create(Self);

  If Not cdsCtaPag.Active Then
  Begin
    LConsultaPrv.DataSet := LConsulta;
    cdsCtaPag.SetProvider(LConsultaPrv);
    LConsulta.SQL.Text := untCadPag.RetornaSQLCamposTabelaTemporaria +
                          ' WHERE FALSE';
    LConsulta.Open;

    pSetaClient(LConsulta);
    cdsCtaPag.Open;

    cdsCtaPag.SetProvider(Nil);
  End;

  FConfiguracaoGrid := TConfiguracaoGrids.Create(dbgDuplicatas,
                                                 dbgDuplicatasView,
                                                 Concat(Self.Name, '.', dbgDuplicatasView.Name),
                                                 ['CTP_MARDES', 'AGRSER', 'NRODUP', 'AGREMP', 'AGRFOR']);

  dbgDuplicatasCTP_VENDOR.Visible := fCfgSis('CTPVND', varBoolean);

  FreeAndNil(LConsultaPrv);
  FreeAndNil(LConsulta);
end;

procedure TfrmBaixaCtaPagar.pAjustaCamposProjeto();
Begin

  If fCfgSis('UTLPRJ', varBoolean) Then
  Begin
     If pnlcabecalho.visible Then
        pnlProjeto.Visible := True
     Else
        pnlProjeto.Visible := False;
  End
  Else
  Begin
     pnlProjeto.Visible := False;
     If pnlcabecalho.visible Then
     Begin
        pnlcabecalho2.top    := pnlcabecalho2.top - pnlProjeto.height;
        dbgDuplicatas.height := dbgDuplicatas.height + pnlProjeto.height;
     End;
  End;

End;

procedure TfrmBaixaCtaPagar.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmp, fRetNomeEmpresa, Nil, 'da Empresa', 0, False, 'Código', True);
end;

procedure TfrmBaixaCtaPagar.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaCtaPagar.pCarregaCentroCusto;
begin
  pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text);
  fraPlanoDeContas.edtDesCta.Text := qryConCta.FieldByName('CTA_DESCTA').AsString;
end;

procedure TfrmBaixaCtaPagar.pImprimeRecibo(cdsGenCtaPag: TUniClientDataSet; frmGen: TForm);
Var
  strCodFor, strSQL : String;
  intCont  : Integer;
  frxRecibo: TfrxReport;
  frxExp   : TfrxDotMatrixExport;
  qryChq_Emi_Baixa : TUniQuery;
  cdsDadosCaixa  : TDataSet;
begin
  {********************************************}
  {* CARREGANDO A CONFIGURACAO DE IMPRESSAO   *}
  {*****************************************AN*}
  pCarregaConfImpr(qryCfgRel, Self.Name);
  strNomFil := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  strTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;

  If fEmptyStr(strNomFil) Then
    fPreImpressao(qryCfgRel, strNomFil, strTipImp, False);

  If strTipImp = 'M' Then
    frxRecibo := frxReciboM
  Else
  Begin
    frxRecibo := frxReciboJ;
    frxRecibo.DotMatrixReport           := False;
    frxRecibo.PrintOptions.PrintMode    := pmScale;
    frxRecibo.PrintOptions.PrintOnSheet := 9; //A4
  End;

  {********************************************}
  {* CARREGANDO UMA LISTA COM OS FORNECEDORES *}
  {*****************************************AN*}
  stlCodFor := TStringList.Create;
  cdsGenCtp := fCriaClientDatasetReciboCTP;
  With cdsGenCtp Do
  Begin
    Data := cdsGenCtaPag.Data;
    IndexFieldNames := 'CTP_CODFOR';
    Filtered := False;
    Filter := 'CTP_MARDES = ' + QuotedStr('M');
    Filtered := True;
    strCodFor := '';
    First;

    While Not Eof Do
    Begin
      If Not SameText(strCodFor, FieldByName('CTP_CODFOR').AsString) Then
      Begin
        strCodFor := FieldByName('CTP_CODFOR').AsString;
        stlCodFor.Add(strCodFor);
      End;

      Next;
    End;

    Filtered := False;
    Filter := '';
  End;

  If Not fImprimeReciboLayout Then
  Begin
    If strTipImp = 'M' Then
      frxExp := TfrxDotMatrixExport.Create(Self);

    {**************************************************************}
    {* FAZENDO A IMPRESSAO DAS DUPLICATAS BAIXADAS POR FORNECEDOR *}
    {***********************************************************AN*}
    If stlCodFor.Count > 0 Then
    Begin
      frxDataset.DataSet := cdsGenCtp;

      For intCont := 0 To stlCodFor.Count-1 Do
      Begin
        With cdsGenCtp Do
        Begin
          Filtered := False;
          Filter := 'CTP_MARDES = '+ QuotedStr('M') + '  AND CTP_CODFOR = ' + QuotedStr(stlCodFor[intCont]);
          Filtered := True;
          First;
          intQtdReg := RecordCount;
        End;

        frxRecibo.Script.Variables['NOMEMP'] := fRetNomeEmpresa;


        If blnResumoCaixa Then
        Begin
          cdsDadosCaixa := objResumoDeCaixa.fRetornaDadosLancamentosCaixaSeqCon(intSeqCon.ToString,
                                                                                VS_strCodEmp,
                                                                                cdsGenCtp.FieldByName('CTP_DTAPAG').AsDateTime);
          if (Not cdsDadosCaixa.IsEmpty) And
             (Not cdsDadosCaixa.FieldByName('RCX_CODCAX').AsString.IsEmpty) Then
            frxRecibo.Script.Variables['CAIXA'] := 'CAIXA: ' + cdsDadosCaixa.FieldByName('RCX_CODCAX').AsString
          Else
            frxRecibo.Script.Variables['CAIXA'] := '';
        End
        Else
          frxRecibo.Script.Variables['CAIXA'] := '';

        {Sintético - Impressão dos cheques vinculados a baixa!}
        if fCfgSis('CTP_AS') = 'S' then
        begin

          qryChq_Emi_Baixa := fCriaQuery(Nil);

          strSQL := '';
          strSQL := strSQL + ' SELECT                    ';
          strSQL := strSQL + '   A.*,               ';
          strSQL := strSQL + '   CONCAT(A.EMI_CODBCO, " - ", (SELECT BCO_NOMBCO FROM CADBCO WHERE BCO_CODBCO = A.EMI_CODBCO)) AS BANCO, ';

          {Devido a demonstração do valor do cheque em relatório e o seu rateio nas baixas em CHQEMI...
           foi necessário "agrupar" os valores}
          strSQL := strSQL + '   (                                  ';
          strSQL := strSQL + '    SELECT                            ';
          strSQL := strSQL + '      SUM(B.EMI_VALBAI)               ';
          strSQL := strSQL + '    FROM                              ';
          strSQL := strSQL + '      CHQEMI B                        ';
          strSQL := strSQL + '    WHERE                             ';
          strSQL := strSQL + '      B.EMI_CODEMP = A.EMI_CODEMP AND ';
          strSQL := strSQL + '      B.EMI_CODBCO = A.EMI_CODBCO AND ';
          strSQL := strSQL + '      B.EMI_NUMAGE = A.EMI_NUMAGE AND ';
          strSQL := strSQL + '      B.EMI_CONCOR = A.EMI_CONCOR AND ';
          strSQL := strSQL + '      B.EMI_NUMCHQ = A.EMI_NUMCHQ AND ';
          strSQL := strSQL + '      B.EMI_CODFOR = A.EMI_CODFOR     ';
          strSQL := strSQL + '   ) AS VALOR_AGRUPADO                ';

          strSQL := strSQL + ' FROM                        ';
          strSQL := strSQL + '   CHQEMI A                  ';
          strSQL := strSQL + ' WHERE                       ';
          strSQL := strSQL + '  A.EMI_CODFOR = :CODFOR AND ';
          strSQL := strSQL + '  A.EMI_NUMDUP = :NUMDUP AND ';
          strSQL := strSQL + '  A.EMI_PARCEL = :PARCEL AND ';
          strSQL := strSQL + '  A.EMI_CODEMP = :CODEMP AND ';
          strSQL := strSQL + '  A.EMI_SEQBAI = :SEQBAI AND ';
          strSQL := strSQL + '  A.EMI_SERIE_ = :SERIE_     ';

          With qryChq_Emi_Baixa Do
          Begin

            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('CODFOR').AsString := cdsGenCtp.FieldByName('CTP_CODFOR').AsString;
            ParamByName('NUMDUP').AsString := cdsGenCtp.FieldByName('NRODUP').AsString;
            ParamByName('PARCEL').AsString := cdsGenCtp.FieldByName('PARDUP').AsString;
            ParamByName('CODEMP').AsString := cdsGenCtp.FieldByName('CTP_CODEMP').AsString;
            ParamByName('SEQBAI').AsString := cdsGenCtp.FieldByName('CTP_SEQBAI').AsString;
            ParamByName('SERIE_').AsString := cdsGenCtp.FieldByName('CTP_SERIE_').AsString;
            Open;

            frxDatasetChqEmi.DataSet := qryChq_Emi_Baixa;
            frxRecibo.FindObject('CUmCheque').Visible      := False;
            frxRecibo.FindObject('CVariosCheques').Visible := True;

          End;

        end
        else
        begin

          {Select "Forçado" para o Fast Report não emitir erros}
          qryChq_Emi_Baixa := fCriaQuery(Nil);
          strSQL := 'SELECT * FROM CHQEMI WHERE FALSE';

          With qryChq_Emi_Baixa Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            Open;
          end;

          frxDatasetChqEmi.DataSet := qryChq_Emi_Baixa;
          frxRecibo.FindObject('CVariosCheques').Visible := False;

          {Analítico - Informações do cheque já atribuidas no momento da baixa!}
          If Not fEmptyStr(strCodBco) Then
          Begin
            frxRecibo.FindObject('CUmCheque').Visible := True;
            frxRecibo.Script.Variables['CODBCO']      := strCodBco + ' - ' + fRetNomBanco(strCodBco);
            frxRecibo.Script.Variables['NUMAGE']      := strNumAge;
            frxRecibo.Script.Variables['CONCOR']      := strConCor;
            frxRecibo.Script.Variables['NUMCHQ']      := strNumChq;
            frxRecibo.Script.Variables['DTABOM']      := strDtaBom;
            frxRecibo.Script.Variables['FAVORE']      := strFavore;
            frxRecibo.Script.Variables['DTAEMI']      := strDtaEmi;
          End
          Else
            frxRecibo.FindObject('CUmCheque').Visible := False;

        end;


        If VerImpressoraONLINE(strNomFil) <> 0 Then
          strNomFil := ' ';

        If Not fEmptyStr(strNomFil) Then
        Begin
          frxRecibo.PrintOptions.ShowDialog := False;
          frxRecibo.PrintOptions.Printer := AnsiReplaceText(strNomFil, '\\' + fRetNomeRede + '\', '');

          If frxRecibo.PrepareReport Then
            pPrintReport(Self.Name, Self.Caption + ' (Recibo)', strNomFil, frxRecibo)
        End
        Else
        Begin
          frxRecibo.PrintOptions.ShowDialog := True;
          pPreviewReport(Self.Name, Self.Caption + ' (Recibo)', frxRecibo);
        End;

        Application.ProcessMessages;
      End;

    End;

  End;

  FreeAndNil(stlCodFor);
  FreeAndNil(cdsGenCtp);

  If Assigned(frxExp) Then
    FreeAndNil(frxExp);
end;

procedure TfrmBaixaCtaPagar.BtnSelecionadasClick(Sender: TObject);
begin
  inherited;

  If Not btnSelecionadas.Enabled Then
    Exit;

  If Not cdsCtaPag.IsEmpty Then
    frmConsDuplicSelec.pMostraDuplicatasSelecionadas('CADPAG', cdsCtaPag)
  Else
   fMensagem('AVISO', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
end;

procedure TfrmBaixaCtaPagar.cdsCtaPagFor_C_G_C_GetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  If cdsCtaPag.FieldByName('FOR_C_G_C_').AsString <> '' Then
  Begin
    If cdsCtaPag.FieldByName('FOR_CGCCPF').AsString = '1' Then
      Text := FormatFloat( '0#"."###"."###"/"####"-"##', StrToFloatDef(Sender.AsString, 0) )
    Else
      Text := FormatFloat( '0##"."###"."###"-"##', StrToFloatDef(Sender.AsString, 0) )
  End;
end;

procedure TfrmBaixaCtaPagar.chkFiltrarFiliaisExit(Sender: TObject);
begin
  inherited;
  pHabilitaFiltroFiliais;
end;

procedure TfrmBaixaCtaPagar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var
    strSenha: String;
begin
  inherited;

  If (Key = VK_Escape) Then
  Begin

    If pnlCabecalho.Visible Then
    Begin
      pLimpaEdits;
      blnMudarFoco := False;
      pSetFocus(edtCodFor);
    End
    Else
      btnSair.Click;

  End
  Else If (Shift = [ssShift]) And (Key = VK_F7) Then
  Begin
    Key := 0;
    If blnLibCnf Then
    Begin
      blnLibCnf            := False;
      pnlBotoesBaixa.Color := clBtnFace;
    End
    Else
    Begin
      If ffrmSenha(strSenha) Then
      Begin
        If strSenha = SEN_CNF Then
        Begin
          blnLibCnf            := True;
          pnlBotoesBaixa.Color := clNavy;
        End;
      End;
    End;
  End
  Else If (Shift = [ssShift]) And (Key = VK_F9) Then
  Begin
    If blnLibCnf Then
    Begin
      Key := 0;

      Try
        pCriarFormularios(TfrmCnfBoleto, frmCnfBoleto);
        frmCnfBoleto.Position := poScreenCenter;
        frmCnfBoleto.blnCnfBol := False;
        frmCnfBoleto.ShowModal;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[frmBaixaCtaPagar.FormKeyDown]');
        End;
      End;

      FreeAndNil(frmCnfBoleto);
    End;
  End
  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End
  Else If (Key = VK_F11) And (Shift = [ssAlt]) Then
  Begin
    If btnDupAgrup.Visible Then
      btnDupAgrup.Click;
  End
  Else If (Key = VK_F11) Then
  Begin
    btnBordero.Click;
  End
  Else If (Key = VK_F12) And (Shift = [ssAlt]) Then
  Begin
    btnDescontoGeral.Click
  End
  Else If (Key = VK_F12) Then
  Begin
    btnManutencao.Click;
  End
  Else If (Key = VK_F4) Then
  Begin
    btnAlterarValor.Click;
  End
  Else If (Key = VK_F5) Then
  Begin
    btnIniBus.Click;
  End
  Else If (Key = VK_F6) Then
  Begin
    btnLocProx.Click;
  End
  Else If (Key = VK_F7) Then
  Begin
    btnMarcarTodas.Click;
  End
  Else If (Key = VK_F8) Then
  Begin
    btnDesmarcarTodas.Click;
  End
  Else If (Key = VK_F9) Then
  Begin
    BtnSelecionadas.Click;
  End;

end;

function TfrmBaixaCtaPagar.fRetornaEmpresa: String;
  Var
    cdsGen: TUniClientDataSet;
begin
  cdsGen := TUniClientDataSet.Create(Self);
  With cdsGen Do
  Begin
    Data := cdsCtaPag.Data;
    Filtered := False;
    Filter := 'CTP_MARDES = ' + QuotedStr('M');
    Filtered := True;

    If Not IsEmpty Then
      Result := FieldByName('CTP_CODEMP').AsString
    Else
      Result := '';
  End;
  FreeAndNil(cdsGen);
end;

function TfrmBaixaCtaPagar.fRetornaFornecedor: String;
  Var
    cdsGen: TUniClientDataSet;
begin
  cdsGen := TUniClientDataSet.Create(Self);
  With cdsGen Do
  Begin
    Data := cdsCtaPag.Data;
    Filtered := False;
    Filter := 'CTP_MARDES = ' + QuotedStr('M');
    Filtered := True;

    If Not IsEmpty Then
      Result := FieldByName('CTP_CODFOR').AsString
    Else
      Result := '';
  End;
  FreeAndNil(cdsGen);
end;

function TfrmBaixaCtaPagar.fRetornaFornecedorUnico: String;
  Var
    cdsCloneCtaPag : TUniClientDataSet;
begin
  cdsCloneCtaPag := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsCloneCtaPag, cdsCtaPag);
  cdsCloneCtaPag.Filtered := False;
  cdsCloneCtaPag.Filter := 'CTP_MARDES = ' + QuotedStr('M');
  cdsCloneCtaPag.Filtered := True;

  Result := '';

  If Not cdsCloneCtaPag.IsEmpty Then
  Begin
    Result := cdsCloneCtaPag.FieldByName('CTP_CODFOR').AsString;

    cdsCloneCtaPag.First;
    While Not cdsCloneCtaPag.Eof Do
    Begin
      If (Result <> cdsCloneCtaPag.FieldByName('CTP_CODFOR').AsString) Then
      Begin
        Result := '';
        Break;
      End;
      cdsCloneCtaPag.Next;
    End;

    If Not fEmptyStr(Result) Then
      Result := fRetNomFornecedor(Result);
  End;

  FreeAndNil(cdsCloneCtaPag);
end;

procedure TfrmBaixaCtaPagar.frxGenGetValue(const VarName: String;
  var Value: Variant);
begin
  inherited;
  If AnsiUpperCase(VarName) = AnsiUpperCase('intQtdReg') Then
  Begin
    Value := intQtdReg;
  End;
end;

function TfrmBaixaCtaPagar.frxReciboMUserFunction(const MethodName: String;
  var Params: Variant): Variant;
begin
  inherited;
  If AnsiUpperCase(MethodName) = AnsiUpperCase('pDecrementaQtdReg') Then
  Begin
    If (strTipImp = 'M') Then
      Dec(intQtdReg, 17)
    Else
      Dec(intQtdReg, 70);
  End
  Else If (SameText(MethodName, 'fFormataFoneInterna')) Then
    Result := fFormataFoneInterna(Trim(Params[0]));
end;

procedure TfrmBaixaCtaPagar.FormDestroy(Sender: TObject);
begin
  pLiberaDupsMarcadas;
  FreeAndNil(objLiberacao);
  FreeAndNil(objLogLibCtp);

  inherited;
  FreeAndNil(stlSeqCon);
  FreeAndNil(objLock);

  pFreeAndNil(frmQckCopiaCheque);
  frmQckCopiaCheque := nil;// Estava destruindo o objeto mas continuava com a referencia de memoria
end;

procedure TfrmBaixaCtaPagar.pGravaRateioPag(cdsRateio: TUniClientDataSet;
  intSeqBai: Integer; strNumDup, strParcel, strCodEmp, strSerie_,
  strCodFor: String; fltValPag, fltValDin, fltValCqV, fltValOrd, fltRepChq: Double);
begin
  Try
    With cdsRateio Do
    Begin
      Insert;
      FieldByName('SEQBAI').AsInteger:= intSeqBai;
      FieldByName('NUMDUP').AsString := strNumDup;
      FieldByName('PARCEL').AsString := strParcel;
      FieldByName('CODEMP').AsString := strCodEmp;
      FieldByName('CODFOR').AsString := strCodFor;
      FieldByName('SERIE_').AsString := strSerie_;
      FieldByName('VALPAG').AsFloat  := fltValPag;
      FieldByName('DINHEI').AsFloat  := fltValDin;
      FieldByName('CHQAVI').AsFloat  := fltValCqV;
      FieldByName('ORDPAG').AsFloat  := fltValOrd;
      FieldByName('REPCHQ').AsFloat  := fltRepChq;
      Post;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TfrmBaixaCtaPagar.pHabilitaFiltroFiliais;
begin
  chkFiltrarFiliais.Enabled := Not fEmptyStr(fRetNomFornecedor(edtCodFor.Text)) And   // Fornecedor Existe
                                   qryConFor.FieldByName('FOR_CGCCPF').AsString.Equals('1'); // Fornecedor usa CNPJ

  chkFiltrarFiliais.Checked := (chkFiltrarFiliais.Enabled And chkFiltrarFiliais.Checked);
end;

function TfrmBaixaCtaPagar.fAcertaRateioPag(cdsRateio: TUniClientDataSet): Boolean;
var
  fltDin: Double;
  fltCqV: Double;
  fltOrd: Double;
  fltRep: Double;
  fltAuxDin: Double;
  fltAuxCqV: Double;
  fltAuxOrd: Double;
  fltAuxRep: Double;
  strSQL: String;
  qryPag: TUniQuery;

  intCont  : Integer;
  fltTotGer: Double;
  fltTotCre: Double;
  arrModal : Array Of TModal;

  function fTemDiferenca: Boolean;
  Begin
    If (cdsRateio.FieldByName('DINHEI').AsFloat + fltTotCre) <> fltDin Then fltDin := (cdsRateio.FieldByName('DINHEI').AsFloat + fltTotCre) - fltDin Else fltDin := 0;
    If cdsRateio.FieldByName('CHQAVI').AsFloat <> fltCqV Then fltCqV := cdsRateio.FieldByName('CHQAVI').AsFloat - fltCqV Else fltCqV := 0;
    If cdsRateio.FieldByName('ORDPAG').AsFloat <> fltOrd Then fltOrd := cdsRateio.FieldByName('ORDPAG').AsFloat - fltOrd Else fltOrd := 0;
    If cdsRateio.FieldByName('REPCHQ').AsFloat <> fltRep Then fltRep := cdsRateio.FieldByName('REPCHQ').AsFloat - fltRep Else fltRep := 0;

    Result := fFormataFloat(Abs(fltDin) + Abs(fltCqV) + Abs(fltOrd) + Abs(fltRep),2) <> 0;
  End;

  procedure pSomaModals;
  Begin
    arrModal[intCont].fltTot := arrModal[intCont].fltDin + arrModal[intCont].fltCqV +
                                arrModal[intCont].fltOrd + arrModal[intCont].fltRep;
  End;
begin
   Result := True;

  If (cdsRateio.IsEmpty) Then
    Exit;

  SetLength(arrModal, cdsRateio.RecordCount);
  qryPag := fCriaQuery;

  Try
    {******************************}
    {* CALCULA TOTAL SEM CREDITOS *}
    {***************************AF*}
    fltTotGer := 0;
    fltTotCre := 0;
    cdsRateio.First;
    While Not cdsRateio.Eof Do
    Begin
      If cdsRateio.FieldByName('VALPAG').AsFloat > 0 Then
        fltTotGer := fltTotGer + cdsRateio.FieldByName('VALPAG').AsFloat
      Else
        fltTotCre := fltTotCre + Abs(cdsRateio.FieldByName('VALPAG').AsFloat);

      cdsRateio.Next;
    End;

    If fltTotGer <= fltTotCre Then
      fltTotCre := 0;

    intCont := 0;
    fltDin  := 0;
    fltCqV  := 0;
    fltOrd  := 0;
    fltRep  := 0;
    cdsRateio.First;
    While Not cdsRateio.Eof Do
    Begin
      arrModal[intCont].fltDin := 0;
      arrModal[intCont].fltCqV := 0;
      arrModal[intCont].fltOrd := 0;
      arrModal[intCont].fltRep := 0;

      If cdsRateio.FieldByName('VALPAG').AsFloat < 0 Then
        arrModal[intCont].fltDin := cdsRateio.FieldByName('VALPAG').AsFloat
      Else
      Begin
        arrModal[intCont].fltDin := fRateioPag(fltTotGer, cdsRateio.FieldByName('VALPAG').AsFloat, cdsRateio.FieldByName('DINHEI').AsFloat);
        arrModal[intCont].fltCqV := fRateioPag(fltTotGer, cdsRateio.FieldByName('VALPAG').AsFloat, cdsRateio.FieldByName('CHQAVI').AsFloat);
        arrModal[intCont].fltOrd := fRateioPag(fltTotGer, cdsRateio.FieldByName('VALPAG').AsFloat, cdsRateio.FieldByName('ORDPAG').AsFloat);
        arrModal[intCont].fltRep := fRateioPag(fltTotGer, cdsRateio.FieldByName('VALPAG').AsFloat, cdsRateio.FieldByName('REPCHQ').AsFloat);

        arrModal[intCont].fltDin := arrModal[intCont].fltDin + fRateioPag(fltTotGer, cdsRateio.FieldByName('VALPAG').AsFloat, fltTotCre);

        fltDin := fltDin + arrModal[intCont].fltDin;
        fltCqV := fltCqV + arrModal[intCont].fltCqV;
        fltOrd := fltOrd + arrModal[intCont].fltOrd;
        fltRep := fltRep + arrModal[intCont].fltRep;
      End;

      pSomaModals;

      Inc(intCont);
      cdsRateio.Next;
    End;

    {*****************************************}
    {* ESSA FUNÇÃO VERIFICA SE TEM DIFERENÇA *}
    {* E JA COLOCA A DIFERENÇA NA VARIAVEL   *}
    {**************************************AF*}
    While fTemDiferenca Do
    Begin
      fltAuxDin := 0;
      fltAuxCqV := 0;
      fltAuxOrd := 0;
      fltAuxRep := 0;

      intCont := 0;
      cdsRateio.First;
      While Not cdsRateio.Eof Do
      Begin

        If fFormataFloat(cdsRateio.FieldByName('VALPAG').AsFloat, 2) > 0 Then
        Begin

          If (fFormataFloat(fltDin,2) <> 0) Then
          Begin
            arrModal[intCont].fltDin := arrModal[intCont].fltDin + fltDin;
            pSomaModals;
            fltDin := 0;
          End;

          If (fFormataFloat(fltCqV,2) <> 0) Then
          Begin
            arrModal[intCont].fltCqV := arrModal[intCont].fltCqV + fltCqV;
            pSomaModals;
            fltCqV := 0;
          End;

          If (fFormataFloat(fltOrd,2) <> 0) Then
          Begin
            arrModal[intCont].fltOrd := arrModal[intCont].fltOrd + fltOrd;
            pSomaModals;
            fltOrd := 0;
          End;

          If (fFormataFloat(fltRep,2) <> 0) Then
          Begin
            arrModal[intCont].fltRep := arrModal[intCont].fltRep + fltRep;
            pSomaModals;
            fltRep := 0;
          End;

        End;

        fltAuxDin := fltAuxDin + arrModal[intCont].fltDin;
        fltAuxCqV := fltAuxCqV + arrModal[intCont].fltCqV;
        fltAuxOrd := fltAuxOrd + arrModal[intCont].fltOrd;
        fltAuxRep := fltAuxRep + arrModal[intCont].fltRep;

        Inc(intCont);
        cdsRateio.Next;
      End;

      fltDin := fltAuxDin + fltTotCre;
      fltCqV := fltAuxCqV;
      fltOrd := fltAuxOrd;
      fltRep := fltAuxRep;
    End;

    intCont := 0;
    cdsRateio.First;
    While Not cdsRateio.Eof Do
    Begin
      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + 'CADPAG ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  CTP_DINHEI = :DINHEI, ';
      strSQL := strSQL + '  CTP_CHQAVI = :CHQAVI, ';
      strSQL := strSQL + '  CTP_ORDPAG = :ORDPAG, ';
      strSQL := strSQL + '  CTP_REPCHQ = :REPCHQ  ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
      strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';
      strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
      strSQL := strSQL + '  IFNULL(CTP_SERIE_,"") = :SERIE_ AND ';
      strSQL := strSQL + '  CTP_SEQBAI = :SEQBAI ';

      qryPag.Close;
      qryPag.SQL.Clear;
      qryPag.SQL.Add(strSQL);
      qryPag.ParamByName('DINHEI').AsFloat   := arrModal[intCont].fltDin;
      qryPag.ParamByName('CHQAVI').AsFloat   := arrModal[intCont].fltCqV;
      qryPag.ParamByName('ORDPAG').AsFloat   := arrModal[intCont].fltOrd;
      qryPag.ParamByName('REPCHQ').AsFloat   := arrModal[intCont].fltRep;
      qryPag.ParamByName('NUMDUP').AsString  := cdsRateio.FieldByName('NUMDUP').AsString;
      qryPag.ParamByName('CODEMP').AsString  := cdsRateio.FieldByName('CODEMP').AsString;
      qryPag.ParamByName('CODFOR').AsString  := cdsRateio.FieldByName('CODFOR').AsString;
      qryPag.ParamByName('SERIE_').AsString  := cdsRateio.FieldByName('SERIE_').AsString;
      qryPag.ParamByName('PARCEL').AsString  := cdsRateio.FieldByName('PARCEL').AsString;
      qryPag.ParamByName('SEQBAI').AsInteger := cdsRateio.FieldByName('SEQBAI').AsInteger;
      qryPag.ExecSQL;

      Inc(intCont);
      cdsRateio.Next;
    End;

    cdsRateio.Filtered := False;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
      Result := False;
    End;
  End;
end;

function TfrmBaixaCtaPagar.fAcertaRateioChqEmi(fltChqEmi: Double; cdsRateio: TUniClientDataSet): Boolean;
  Var
    repCadPag: TCadPagRepository;
    objCadPag: TCadPag;

    repChqEmi: TChqEmiRepository;
    lstChqEmi: TList<TChqEmi>;
    objChqEmi: TChqEmi;

    fltTotGer: Double;
    fltTotMod: Double;
    fltTotAux: Double;
    strChave : String;

  function fTemDiferenca: Boolean;
  Begin
    If objCadPag.fltChqAvi <> fltTotMod Then
      fltTotMod := objCadPag.fltChqAvi - fltTotMod
    Else
      fltTotMod := 0;

    Result := fFormataFloat(fltTotMod,2) <> 0;
  End;

begin
  Result := True;
  If (Assigned(frwk)) And
     (Assigned(frwk.objDBManager)) then
    frwk.objDBManager.Clear;

  If (cdsRateio.IsEmpty) Then Exit;
  If (Not Assigned(dicChqEmi)) Or (dicChqEmi.Count <= 0) Then Exit;

  repCadPag := TCadPagRepository.Create;
  repChqEmi := TChqEmiRepository.Create;

  Try
    {*****************}
    {* CALCULA TOTAL *}
    {**************AF*}
    fltTotGer := fltChqEmi;

    cdsRateio.First;
    While Not cdsRateio.Eof Do
    Begin
      objCadPag := repCadPag.fRetDuplicata(cdsRateio.FieldByName('NUMDUP').AsString,
                                           cdsRateio.FieldByName('PARCEL').AsString,
                                           cdsRateio.FieldByName('SEQBAI').AsInteger,
                                           cdsRateio.FieldByName('CODEMP').AsString,
                                           cdsRateio.FieldByName('CODFOR').AsString,
                                           cdsRateio.FieldByName('SERIE_').AsString);
      frwk.objDBManager.Refresh(objCadPag);

      lstChqEmi := repChqEmi.fRetCheques(cdsRateio.FieldByName('CODFOR').AsString,
                                         cdsRateio.FieldByName('NUMDUP').AsString,
                                         cdsRateio.FieldByName('PARCEL').AsString,
                                         cdsRateio.FieldByName('CODEMP').AsString,
                                         cdsRateio.FieldByName('SERIE_').AsString,
                                         cdsRateio.FieldByName('SEQBAI').AsInteger);

      fltTotMod := 0;
      For objChqEmi In lstChqEmi Do
      Begin
        strChave := objChqEmi.strCodBco + objChqEmi.strNumAge + objChqEmi.strConCor + objChqEmi.strNumChq;

        objChqEmi.fltValBai := fRateioPag(fltTotGer, objCadPag.fltChqAvi, dicChqEmi[strChave].fltValChq);
        fltTotMod := fltTotMod + objChqEmi.fltValBai;
      End;

      {*****************************************}
      {* ESSA FUNÇÃO VERIFICA SE TEM DIFERENÇA *}
      {* E JA COLOCA A DIFERENÇA NA VARIAVEL   *}
      {**************************************AF*}
      While fTemDiferenca Do
      Begin

        fltTotAux := 0;
        For objChqEmi In lstChqEmi Do
        Begin

          If (objCadPag.fltChqAvi > 0) And (fltTotMod <> 0) Then
          Begin
            objChqEmi.fltValBai := objChqEmi.fltValBai + fltTotMod;
            fltTotMod := 0;

            If objChqEmi.fltValBai = 0 Then
              Raise Exception.Create('Ocorreu uma inconsistência na gravação da baixa.' + sLineBreak +
                                     'Esta operação não será realizada.' + sLineBreak +
                                     'Entre em contato com a Citel.');
          End;

          fltTotAux := fltTotAux + objChqEmi.fltValBai;
        End;

        fltTotMod := fltTotAux;
      End;

      frwk.objDBManager.Flush;

      cdsRateio.Next;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
      Result := False;
    End;
  End;

  FreeAndNil(repCadPag);
  FreeAndNil(repChqEmi);
End;

function TfrmBaixaCtaPagar.fCriaCdsRateioPag(AOwner: TComponent): TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(AOwner);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'SEQBAI';
    DataType := ftInteger;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'NUMDUP';
    DataType := ftString;
    Size     := 12;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'PARCEL';
    DataType := ftString;
    Size     := 1;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODEMP';
    DataType := ftString;
    Size     := 3;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'SERIE_';
    DataType := ftString;
    Size     := 3;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODFOR';
    DataType := ftString;
    Size     := 8;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VALPAG';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DINHEI';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CHQAVI';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ORDPAG';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'REPCHQ';
    DataType := ftFloat;
    Required := False;
  End;

  Result.CreateDataSet;
  Result.Open;
end;

procedure TfrmBaixaCtaPagar.fraCentroCustoedtCodEveExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(fraCentroCusto.edtCodEve, fraCentroCusto.edtDesEve, arrEvento, fRetNomEvento, Nil, 'do Centro de Custos');
end;

procedure TfrmBaixaCtaPagar.fraPlanoDeContasMskCodCtaExit(Sender: TObject);
begin
  inherited;
  fraPlanoDeContas.MskCodCtaExit(Sender);
  pEdtCodSelectExit(fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, arrCentCusto, fRetNomeConta, Nil, 'da Conta',7);
end;

procedure TfrmBaixaCtaPagar.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentCusto, False, False, '', False, False, False, True) Then
  Begin
    If (fValidaCampos(fraPlanoDeContas.MskCodCta, True)) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
    If fraPlanoDeContas.MskCodCta.Text <> '0000000' Then
      pCarregaCentroCusto;
  End;

end;

function TfrmBaixaCtaPagar.fRateioPag(fltTotGer, fltTotDup, fltValPag: Double): Double;
begin
  If (fltValPag = 0) Then
    Result := 0
  Else
    Result := fFormataFloat((fltTotDup / fltTotGer) * fltValPag, 2);
end;

{*********************************************}
{*  ORDENANDO KEY EM ORDEM  CRESCENTE        *}
{******************************************LE*}
function TfrmBaixaCtaPagar.fOrdenaDictionaryKey(dictionary: TDictionary<String, TChequeEmitido>): TArray<String>;
  Var
    keyArray: TArray<String>;
    keyCollecttion: TDictionary<String, TChequeEmitido>.TKeyCollection;
begin

  keyCollecttion:= TDictionary<String, TChequeEmitido>.TKeyCollection.Create(dictionary);

  Try

    keyArray:=  dicChqEmi.keys.ToArray;
    TArray.Sort<String>(keyArray, TComparer<String>.Construct(fComparaKey));

  Finally
    keyCollecttion.Free;

  End;

  Result := keyArray;
end;

{*****************************************}
{* COMPARANDO CHAVE PARA ORDENAÇÃO       *}
{**************************************LE*}
function TfrmBaixaCtaPagar.fComparaKey(const L, R: String): Integer;
begin
  Result := CompareText(L, R);
end;



{*****************************************}
{* ABATIMENTO DE DUPLICATA               *}
{**************************************LE*}
function TfrmBaixaCtaPagar.fAcertaAbatimentoPag(cdsAbatimento: TUniClientDataSet): Boolean;
 Var
  cdsAux : TUniClientDataSet;
  qryAux : TUniQuery;
  strSQL : String;
begin
  cdsAux := TUniClientDataSet.Create(Nil);
  qryAux := fCriaQuery;
  Result := False;
  Try
    With cdsAbatimento Do
    Begin
      Filter   := '';
      Filtered := False;
      Filter := 'CTP_MARDES = ' + QuotedStr('M');
      strCampoFiltro := 'CTP_MARDES';
      strValorFiltro := 'M';
      Filtered := True;
      cdsAux.CloneCursor(cdsAbatimento,False,True);
      Filtered := False;
    End;

    With cdsAux Do
    Begin
      First;
      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + 'CADPAG ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  CTP_DINHEI = :DINHEI, ';
      strSQL := strSQL + '  CTP_CHQAVI = :CHQAVI, ';
      strSQL := strSQL + '  CTP_ORDPAG = :ORDPAG, ';
      strSQL := strSQL + '  CTP_REPCHQ = :REPCHQ  ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
      strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';
      strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
      strSQL := strSQL + '  IFNULL(CTP_SERIE_,"") = :SERIE_ AND ';
      strSQL := strSQL + '  CTP_SEQBAI = :SEQBAI ';

      qryAux.SQL.Add(strSQL);
      While Not Eof Do
      Begin

        If (FieldByName('CTP_ORDPAG').AsFloat <> 0) Or (FieldByName('CTP_CHQAVI').AsFloat <> 0)
        Or (FieldByName('CTP_REPCHQ').AsFloat <> 0)  Or (FieldByName('CTP_DINHEI').AsFloat <> 0) Then
        Begin
          qryAux.ParamByName('DINHEI').AsFloat   := 0.00;
          qryAux.ParamByName('CHQAVI').AsFloat   := 0.00;
          qryAux.ParamByName('ORDPAG').AsFloat   := 0.00;
          qryAux.ParamByName('REPCHQ').AsFloat   := 0.00;
          qryAux.ParamByName('NUMDUP').AsString  := cdsAux.FieldByName('NRODUP').AsString;
          qryAux.ParamByName('CODEMP').AsString  := FieldByName('CTP_CODEMP').AsString;
          qryAux.ParamByName('CODFOR').AsString  := FieldByName('CTP_CODFOR').AsString;
          qryAux.ParamByName('SERIE_').AsString  := FieldByName('CTP_SERIE_').AsString;
          qryAux.ParamByName('PARCEL').AsString  := FieldByName('PARDUP').AsString;
          qryAux.ParamByName('SEQBAI').AsInteger := FieldByName('CTP_SEQBAI').AsInteger;
          qryAux.ExecSQL;
        End;

        Next;
      End;
    End;
     If Not cdsAux.IsEmpty Then
       Result := True;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmBaixaCtaPagar.fAcertaAbatimento]');
      FreeAndNil(cdsAux);
      FreeAndNil(qryAux);
    End;

  End;
  FreeAndNil(cdsAux);
  FreeAndNil(qryAux);

end;

{*****************************************}
{* CASO USE IMPRESSORA DE CHEQUES, ENVIA *}
{* OS CHEQUES.                           *}
{**************************************LE*}
function TfrmBaixaCtaPagar.fCriaClientCheque(strCodBco, strNumAge, strNumChq, strFavore,strDtaEmi,strConCor : String; fltValChq :Double):TUniClientDataSet;
  Var
  cdsTemp : TUniClientDataSet;
begin

  Try
    cdsTemp := TUniClientDataSet.Create(Self);

    With cdsTemp Do
    Begin
      FieldDefs.Add('CHQ_CODBCO' , ftString,3);
      FieldDefs.Add('CHQ_NUMAGE' , ftString,5);
      FieldDefs.Add('CHQ_CONCOR' , ftString,12);
      FieldDefs.Add('CHQ_NUMCHQ' , ftString,10);
      FieldDefs.Add('CHQ_NOMFAV' , ftString,40);
      FieldDefs.Add('CHQ_VALCHQ' , ftFloat);
      FieldDefs.Add('CHQ_DTACAD' , ftDate);
      CreateDataSet;

      Append;
      FieldByName('CHQ_CODBCO').AsString := strCodBco;
      FieldByName('CHQ_NUMAGE').AsString := strNumAge;
      FieldByName('CHQ_CONCOR').AsString := strConCor;
      FieldByName('CHQ_NUMCHQ').AsString := strNumChq;
      FieldByName('CHQ_NOMFAV').AsString := strFavore;
      FieldByName('CHQ_VALCHQ').AsFloat  := fltValChq;
      FieldByName('CHQ_DTACAD').Value:= StrToDate(strDtaEmi);
      Post;


    End;

    Result := cdsTemp;
   Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmBaixaCtaPagar.fDictionaryParaClient]');
      cdsTemp := TUniClientDataSet.Create(Self);
      cdsTemp.CreateDataSet;
      Result := cdsTemp;
    End;
  End;


end;

procedure TfrmBaixaCtaPagar.pLimpaCTRemAberto;
begin
  edtEmAbertoAVenc.Text := '0,00';
  edtEmAbertoVenc.Text  := '0,00';
  edtEmAbertoCred.Text  := '0,00';
  edtEmAbertoTotal.Text := '0,00';
end;

procedure TfrmBaixaCtaPagar.pChamarManutencaoCtp;
Var
  frmCadCtaPagar: TfrmCadCtaPagar;

  procedure pAtualizaCamposGrid;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
  begin
      With cdsCtaPag Do
      Begin
        strSQL := 'SELECT CTA_DESCTA, EVE_DESEVE, FOR_NOMFOR, C.* ' +
                  ' FROM CADPAG C                     ' +
                  ' INNER JOIN CADFOR F               ' +
                  '   ON F.FOR_CODFOR = C.CTP_CODFOR  ' +
                  ' LEFT JOIN CADCTA CT               ' +
                  '   ON CT.CTA_CODCTA = C.CTP_CODCTA ' +
                  ' LEFT JOIN CADEVE E                ' +
                  '   ON E.EVE_CODEVE = C.CTP_CODEVE  ' +
                  ' WHERE C.AUTOINCREM = ' + QuotedStr(FieldByName('AUTOINCREM').AsString)+ ' ';
        qryTmp := fCriarQuery(strSQL, Self);
        qryTmp.Open;

        If qryTmp.IsEmpty Then
        Begin
          {**********************************************}
          {* CASO NÃO ENCONTRAR A DUPLICATA, ASSUME QUE *}
          {* O USUÁRIO EXCLUI NA MANUT. DO CTA. PAGAR   *}
          {*******************************************JS*}
          Delete;
        End
        Else
        Begin
          Edit;
          FieldByName('CTP_NUMDUP').AsString   := qryTmp.FieldByName('CTP_NUMDUP').AsString +
                                                  qryTmp.FieldByName('CTP_PARCEL').AsString;
          FieldByName('NRODUP').AsString       := qryTmp.FieldByName('CTP_NUMDUP').AsString;
          FieldByName('PARDUP').AsString       := qryTmp.FieldByName('CTP_PARCEL').AsString;
          FieldByName('CTP_CODEMP').AsString   := qryTmp.FieldByName('CTP_CODEMP').AsString;
          FieldByName('CTP_SERIE_').AsString   := qryTmp.FieldByName('CTP_SERIE_').AsString;
          FieldByName('CTP_CODFOR').AsString   := qryTmp.FieldByName('CTP_CODFOR').AsString;
          FieldByName('CTP_NOMFOR').AsString   := qryTmp.FieldByName('CTP_CODFOR').AsString + '-' +
                                                  qryTmp.FieldByName('FOR_NOMFOR').AsString;
          FieldByName('CTP_COMPET').AsString   := qryTmp.FieldByName('CTP_COMPET').AsString;
          FieldByName('CTP_DTACAD').AsDateTime := qryTmp.FieldByName('CTP_DTACAD').AsDateTime;
          FieldByName('CTP_DTAVEN').AsDateTime := qryTmp.FieldByName('CTP_DTAVEN').AsDateTime;
          FieldByName('CTP_TIPDOC').AsString   := qryTmp.FieldByName('CTP_TIPDOC').AsString;
          FieldByName('CTP_VALDUP').AsFloat    := qryTmp.FieldByName('CTP_VALDUP').AsFloat;
          FieldByName('TOTDUP').AsFloat        := qryTmp.FieldByName('CTP_VALDUP').AsFloat +
                                                  qryTmp.FieldByName('CTP_JURSUJ').AsFloat +
                                                  qryTmp.FieldByName('CTP_VENDOR').AsFloat +
                                                  qryTmp.FieldByName('CTP_OUTENT').AsFloat -
                                                  qryTmp.FieldByName('CTP_DESSUJ').AsFloat;
          FieldByName('CTP_DESSUJ').AsFloat    := qryTmp.FieldByName('CTP_DESSUJ').AsFloat;
          FieldByName('CTP_JURSUJ').AsFloat    := qryTmp.FieldByName('CTP_JURSUJ').AsFloat;
          FieldByName('CTP_MULSUJ').AsFloat    := qryTmp.FieldByName('CTP_MULSUJ').AsFloat;
          FieldByName('CTP_VENDOR').AsFloat    := qryTmp.FieldByName('CTP_VENDOR').AsFloat;
          FieldByName('CTP_OUTENT').AsFloat    := qryTmp.FieldByName('CTP_OUTENT').AsFloat;
          FieldByName('CTP_CODPOR').AsString   := qryTmp.FieldByName('CTP_CODPOR').AsString;
          FieldByName('CTP_NOMPOR').AsString   := IIF(fEmptyStr(qryTmp.FieldByName('CTP_CODPOR').AsString),'',
                                                  qryTmp.FieldByName('CTP_CODPOR').AsString + '-' +
                                                  fCampoTabela('POR_NOMPOR', 'CADPOR', ['POR_CODPOR'], [qryTmp.FieldByName('CTP_CODPOR').AsString]));
          FieldByName('CTP_CODEVE').AsString   := qryTmp.FieldByName('CTP_CODEVE').AsString;
          FieldByName('EVE_DESEVE').AsString   := qryTmp.FieldByName('EVE_DESEVE').AsString;
          FieldByName('CTP_CODCTA').AsString   := qryTmp.FieldByName('CTP_CODCTA').AsString;
          FieldByName('CTA_DESCTA').AsString   := qryTmp.FieldByName('CTA_DESCTA').AsString;
          FieldByName('CTP_HIST01').AsString   := qryTmp.FieldByName('CTP_HIST01').AsString;
          FieldByName('CTP_PREVIS').AsString   := qryTmp.FieldByName('CTP_PREVIS').AsString;
          FieldByName('CTP_CODVEL').AsString   := qryTmp.FieldByName('CTP_CODVEL').AsString;
          FieldByName('CTP_USACHQ').AsString   := IIF(qryTmp.FieldByName('CTP_USACHQ').AsString='S', 'SIM', 'NÃO');
          FieldByName('CTP_VEIOBO').AsString   := IIF(qryTmp.FieldByName('CTP_VEIOBO').AsString='S', 'SIM', 'NÃO');
          FieldByName('CTP_VEIONF').AsString   := IIF(qryTmp.FieldByName('CTP_VEIONF').AsString='S', 'SIM', 'NÃO');
          Post;
        End;

        qryTmp.Close;

        FreeAndNil(qryTmp);
      End;
  end;

begin

  If cdsCtaPag.FieldByName('CTP_MARDES').AsString = 'M' Then
  Begin
    pMensagemOk('Para usar essa funcionalidade favor desmarcar a duplicata selecionada.');
    Exit;
  End;

  Try
    pCriarFormularios(TfrmCadCtaPagar, frmCadCtaPagar);
    {***********************************************}
    {* AO INFORMAR O AUTOINCREM ANTES DO SHOWMODAL *}
    {* IRÁ ABRIR A DUPLICATA AUTOMATICAMENTE       *}
    {********************************************JS*}
    frmCadCtaPagar.Position := poScreenCenter;
    frmCadCtaPagar.strAutoIncrem := cdsCtaPag.FieldByName('AUTOINCREM').AsString;
    frmCadCtaPagar.strOrigem     := 'frmBaixaCtaPagar';
    frmCadCtaPagar.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmBaixaCtaPagar.pChamarManutencaoCtp]');
  End;
  pFreeAndNil(frmCadCtaPagar);

  pAtualizaCamposGrid;

  pCalculaTotalDuplicatas(edtTotDesconto, edtTotJuros,edtTotMulta, edtValorTotal, edtQtdDuplicatas, edtTotVendor, edtOutEnt, False);

  pSetFocus(dbgDuplicatas);
end;


function TfrmBaixaCtaPagar.fLiberaBaixaContasPagarResumoCaixa(cdsSelecionadas : TUniClientDataSet) : Boolean;
Var objTabela     : TRegistroMsgLiberaTabela;
	  objLinha      : TLinhaMsgLibera;
    fltTotSelOrig : Double;
begin
  {****************************************************************************************}
  {*VERIFICAR PERMISSÃO PARA BAIXA DO CONTAS A PAGAR VINDO DO RESUMO DE CAIXA (DIRCXCTPRC)*}
  {***************************************************************************KM-REQ 188418}
  Result := True;
  if blnResumoCaixa then
  begin
    fltTotSelOrig := 0;
    If Not fVerificaAcessoSistema('DIRRCXCTPRC',strLoginUsuarioLogado) Then
    Begin
      objTabela := TRegistroMsgLiberaTabela.Create;


      objLiberacao.Clear;
      objLiberacao.strDirAce := 'DIRRCXCTPRC';
      objLiberacao.strSenLib := fCfgSis('BAICTP');
      objLiberacao.strMsgSen := 'Baixa de Contas a Pagar';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto('Baixa de Contas a Pagar (Resumo de Caixa)');
  	  objLiberacao.objMsgLibera.pAddQuebra;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna('', 'NRO DA DUPLICATA' , 17 , alEsquerda , teAutcom);
      objLinha.pAddColuna('', 'EMPRESA'          , 7  , alEsquerda , teAutcom);
      objLinha.pAddColuna('', 'FORNECEDOR'       , 48 , alEsquerda , teAutcom);
      objLinha.pAddColuna('', 'DT.CAD.'          , 10 , alCentro   , teAutcom);
	    objLinha.pAddColuna('', 'DT.VENC.'         , 10 , alCentro   , teAutcom);
      objLinha.pAddColuna('', 'VR.ORIGINAL'      , 15 , alDireita  , teAutcom);
      objLinha.pAddColuna('', 'VR.PAGAMENTO'     , 15 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);
      With cdsSelecionadas Do
      Begin
        First;
        While Not Eof Do
        Begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna('NRO DA DUPLICATA', FieldByName('CTP_NUMDUP').AsString, 17, alEsquerda );
          objLinha.pAddColuna('EMPRESA',          FieldByName('CTP_CODEMP').AsString, 7, alEsquerda);
          objLinha.pAddColuna('FORNECEDOR',       FieldByName('FOR_NOMFOR').AsString, 48, alEsquerda);
          objLinha.pAddColuna('DT.CAD.',          FormatDateTime('dd/mm/yyyy', FieldByName('CTP_DTACAD').asDateTime ),  10 , alCentro);
          objLinha.pAddColuna('DT.VENC.',         FormatDateTime('dd/mm/yyyy',  FieldByName('CTP_DTAVEN').asDateTime ), 10 , alCentro);
          objLinha.pAddColuna('VR.ORIGINAL',      FormatFloat('#,##0.00',FieldByName('CTP_VALORI').asFloat), 15, alDireita);
          objLinha.pAddColuna('VR.PAGAMENTO',     FormatFloat('#,##0.00',FieldByName('CTP_VALPAG').asFloat), 15, alDireita);
          objTabela.lstLinhas.Add(objLinha);

          fltTotSelOrig := fltTotSelOrig +  FieldByName('CTP_VALORI').asFloat;
          Next;
        End;
        {** TOTAIS **}
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlTotal;
        objLinha.pAddColuna(''            ,'TOTAIS'                              , 100, alDireita,teAutcom);
        objLinha.pAddColuna('VR.ORIGINAL' ,FormatFloat('#,##0.00',fltTotSelOrig) , 15, alDireita);
        objLinha.pAddColuna('VR.PAGAMENTO',edtTotalPago.Text                     , 15, alDireita);
        objTabela.lstLinhas.Add(objLinha);
      end;
   	  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
    End;

    If (Not objLiberacao.fLibera) Then
      Result := False;
  end;
end;

procedure TfrmBaixaCtaPagar.pExibeTotais;
var
  LVar: Variant;
begin
  With  dbgDuplicatasView Do
  Begin
    { Evitar erro de conversão para valor nulo }
    LVar := DataController.Summary.FooterSummaryValues[0];
    If (LVar <> Variants.Null) and (not VarIsNull(LVar)) Then
    Begin
      edtTotVlrOrg.Text := FormatFloat('###,###,##0.00',DataController.Summary.FooterSummaryValues[0]);
      edtTotVlrCorr.Text := FormatFloat('###,###,##0.00',DataController.Summary.FooterSummaryValues[1]);
      edtQtdDulSel.Text := FormatFloat('###,##0',DataController.FilteredRecordCount);
    End;
  End;

end;

function TfrmBaixaCtaPagar.ExisteDuplicatasSelecionadasNaoExibidasNoGrid: Boolean;
  Var
    LCdsTemp  : TUniClientDataSet;
    LMarcados : Integer;
begin
  LCdsTemp := TUniClientDataSet.Create(Self);
  Try
    pCloneDataSet(LCdsTemp, cdsCtaPag);

    LCdsTemp.Filter   := 'CTP_MARDES = ' + QuotedStr('M');
    LCdsTemp.Filtered := True;
    LMarcados := LCdsTemp.RecordCount;

    If Not fEmptyStr(dbgDuplicatasView.DataController.Filter.FilterText) Then
    Begin
      LCdsTemp.Filtered := False;
      LCdsTemp.Filter   := 'CTP_MARDES = ' + QuotedStr('M') + ' AND ' + dbgDuplicatasView.DataController.Filter.FilterText;
      LCdsTemp.Filtered := True;
    End;

    Result := (LMarcados > LCdsTemp.RecordCount);

  Finally
    FreeAndNil(LCdsTemp);
  End;
end;

end.


