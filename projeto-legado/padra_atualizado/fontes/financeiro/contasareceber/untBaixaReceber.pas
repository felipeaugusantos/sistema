{*************************************************}
{* ATENÇÃO: Parem de clonar o cdsCtaRec          *}
{*          em qualquer coisa que for fazer.     *}
{*          Está causando erro de insuficiência  *}
{*          de recursos no SO.                   *}
{*          Veja se o FCloneDatasetMarcados      *}
{*          resolve o problema, mas cuidado      *}
{*          ao utilizá-lo.                       *}
{*************************************************}
unit untBaixaReceber;

interface

uses
  Windows, Classes, Controls, Forms, untPaiSimples, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, Mask, MaskEditFocus, EditFocus, MemoFocus, DateUtils,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGrid, cxGridDBTableView, Uni, UniClientDataSet, untCadRec,
  untReciboCtr, untReciboCtrMeiaFolha, untFastPrintEditor, BitBtnLockedIncrem, untCadChq, cxProgressBar,
  cxLookAndFeels, cxLookAndFeelPainters, untTypesSistema, cxNavigator, untFuncoesSimples, frxClass,
  frxExportCSVTestabilidade, System.Generics.Collections, cxContainer, dxCore,
  cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, untGravaMovCar,
  untTDesmembramentoBaixaReceber, untTBaixaReceber, dxScreenTip, RLTypes, RLReport,untFechamentoFinanceiro,
  dxCustomHint, cxHint, cxDataControllerConditionalFormattingRulesManagerDialog,
  untRomGer, untLiberacao, untTLock,untBaixaBusca, untFrameCentroCustoEditFocus, untValidacaoCredito,
  untReimpressao,untTProrrogacaoDeTitulos,MaskUtils,untTlogLibRec, untTiposPix,untFinDesmRemBanc,
  untTBanctrRepository, untLogBan, untLogMovCtr, untTConfiguracaoGrids, untLogCancelamento;
type
  TDescontoGeral = Record
    strCODCLI: String;
    strNUMDUP: String;
    strPARDUP: String;
    strESPDOC: String;
    strCODEMP: String;
    strNOMCLI: String;
    fltVALDUP: Double;
    fltVALCAL: Double;
    fltVALDES: Double;
    fltVALREC: Double;
    dtaDTAVEN: TDateTime;
    dtaDTACAD: TDateTime;
  End;

  TGravacaoLogCtr = record
    AutoIncremCtr,

    NumeroDuplicata,
    ParcelaDuplicata,
    EspecieDocumento,
    CodigoEmpresa,
    CodigoCliente,

    Descricao,
    Formulario: String;

    SequencialBaixa: Integer;
  End;

  TfrmBaixaReceber = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label20: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    pnlBotoesBaixa: TPanel;
    pnlTotais: TPanel;
    Label7: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    lblDespCob: TLabel;
    edtCodPorBai: TEditFocus;
    edtNomPorBai: TEditFocus;
    edtNosNumBai: TEditFocus;
    edtCodEveBai: TEditFocus;
    edtMedPond: TEditFocus;
    pnlInformativos: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    edtJurosTotal: TEditFocus;
    edtDescontoTotal: TEditFocus;
    edtDespCob: TEditFocus;
    dbgDuplicatasDBTableView1: TcxGridDBTableView;
    dbgDuplicatasLevel1: TcxGridLevel;
    dbgDuplicatas: TcxGrid;
    dbgDuplicatasCTR_NUMDUP: TcxGridDBColumn;
    dbgDuplicatasCTR_ESPDOC: TcxGridDBColumn;
    dbgDuplicatasCTR_NOMCLI: TcxGridDBColumn;
    dbgDuplicatasCTR_CODEMP: TcxGridDBColumn;
    dbgDuplicatasCTR_DTACAD: TcxGridDBColumn;
    dbgDuplicatasCTR_DTAVEN: TcxGridDBColumn;
    dbgDuplicatasCTR_VALSUJ: TcxGridDBColumn;
    dbgDuplicatasCTR_VALCAL: TcxGridDBColumn;
    dbgDuplicatasCTR_MARDES: TcxGridDBColumn;
    dbgDuplicatasCTR_VALJUR: TcxGridDBColumn;
    btnIniBus: TBitBtnLocked;
    btnLocProx: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnRecalculaJuros: TBitBtnLocked;
    BtnSelecionadas: TBitBtnLocked;
    btnMarcarTodas: TBitBtnLocked;
    btnDesmarcarTodas: TBitBtnLocked;
    chkLimFil: TCheckBox;
    Label15: TLabel;
    edtCodRed: TEditFocus;
    edtDesRed: TEditFocus;
    pnlEnvBan: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    edtNomBan: TEditFocus;
    lbl4: TLabel;
    btnLimparDadosRemessa: TBitBtnLocked;
    edtDtaEnv: TEditFocus;
    edtBcoBol: TEditFocus;
    shpMultSel: TShape;
    Label18: TLabel;
    edtNumCooRod: TEditFocus;
    btnMedPond: TBitBtnLocked;
    HintControler: TcxHintStyleController;
    dbgDuplicatasCTR_CODCLI: TcxGridDBColumn;
    btnDescontoGeral: TBitBtnLocked;
    btnAdiantamento: TBitBtnLocked;
    btnProdutos: TBitBtnLocked;
    btnImprimirRecibo: TBitBtnLocked;
    FlwPnlBotoesBaixa: TFlowPanel;
    btnInformacaoCobranca: TBitBtnLocked;
    Panel1: TPanel;
    fraCentroCusto: TfraCentroCustoEditFocus;
    dbgDuplicatasCLI_C_G_C_: TcxGridDBColumn;
    btnDuplicataAgrupada: TBitBtnLocked;
    btnVisualizaDocumentoCompleto: TBitBtnLocked;
    btnSairBaixa: TBitBtnLocked;
    pnlCabecalho2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblNumCoo: TLabel;
    lblRomaneio: TLabel;
    edtNumCoo: TEditFocus;
    edtNosNum: TEditFocus;
    edtDesPortador: TEditFocus;
    edtCodPortador: TEditFocus;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    btnCarrTitulos: TBitBtnLocked;
    edtRomaneio: TEditFocus;
    pnlProjeto: TPanel;
    lblProjeto: TLabel;
    edtDesPrj: TEditFocus;
    edtCodPrj: TEditFocus;
    Label26: TLabel;
    Label25: TLabel;
    mskDtaCadIni: TcxDateEdit;
    mskDtaCadFin: TcxDateEdit;
    Label8: TLabel;
    edtCodven: TEditFocus;
    edtNomVen: TEditFocus;
    btnManutencao: TBitBtnLocked;
    chkFiltrarFiliais: TCheckBox;
    btnEmailPix: TBitBtnLocked;
    dbgDuplicatasCTR_TX_PIX: TcxGridDBColumn;
    pnlLegendas: TPanel;
    grpLegenda: TGroupBox;
    Shape1: TShape;
    Label22: TLabel;
    Shape2: TShape;
    Label24: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Shape3: TShape;
    Label29: TLabel;
    Label30: TLabel;
    pnlhistorico: TPanel;
    Label14: TLabel;
    edtHistor: TMemoFocus;
    spbAmpliar: TSpeedButton;
    gpbGeral: TGroupBox;
    Label6: TLabel;
    Label21: TLabel;
    edtQtdDuplicatas: TEditFocus;
    edtValorTotal: TEditFocus;
    gpbSelecionadas: TGroupBox;
    Label9: TLabel;
    Label23: TLabel;
    edtQtdSelecionadas: TEditFocus;
    edtTotalRecebido: TEditFocus;
    gpbFiltradas: TGroupBox;
    Label33: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    edtQtdDulSel: TEditFocus;
    edtTotVlrOrg: TEditFocus;
    edtTotVlrCorr: TEditFocus;
    dbgDuplicatasDIASATRASO: TcxGridDBColumn;
    edtHistorico: TEditFocus;
    lblHistorico: TLabel;
    btnConfigurarGrid: TBitBtnLocked;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPortadorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgDuplicatasDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnMarcarTodasClick(Sender: TObject);
    procedure btnDesmarcarTodasClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnIniBusClick(Sender: TObject);
    procedure btnLocProxClick(Sender: TObject);
    procedure BtnSelecionadasClick(Sender: TObject);
    procedure btnRecalculaJurosClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairBaixaClick(Sender: TObject);
    procedure edtCodRedKeyPress(Sender: TObject; var Key: Char);
    procedure btnLimparDadosRemessaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure dbgDuplicatasDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodPortadorExit(Sender: TObject);
    procedure edtCodRedExit(Sender: TObject);
    procedure btnCarrTitulosClick(Sender: TObject);
    procedure edtMedPondMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure edtMedPondMouseLeave(Sender: TObject);
    procedure btnMedPondMouseEnter(Sender: TObject);
    procedure btnMedPondMouseLeave(Sender: TObject);
    procedure btnMedPondClick(Sender: TObject);
    procedure btnDescontoGeralClick(Sender: TObject);
    procedure btnAdiantamentoClick(Sender: TObject);
    procedure edtRomaneioKeyPress(Sender: TObject; var Key: Char);
    procedure btnProdutosClick(Sender: TObject);
    procedure btnImprimirReciboClick(Sender: TObject);
    procedure spbAmpliarClick(Sender: TObject);
    procedure btnInformacaoCobrancaClick(Sender: TObject);
    procedure fraCentroCustoedtCodEveExit(Sender: TObject);
    procedure cdsCtaRecCLI_C_G_C_GetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure btnDuplicataAgrupadaClick(Sender: TObject);
    procedure btnVisualizaDocumentoCompletoClick(Sender: TObject);
    procedure edtCodPrjKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPrjExit(Sender: TObject);
    procedure edtCodvenExit(Sender: TObject);
    procedure edtCodvenKeyPress(Sender: TObject; var Key: Char);
    procedure btnManutencaoClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure chkFiltrarFiliaisExit(Sender: TObject);
    procedure btnEmailPixClick(Sender: TObject);
    procedure dbgDuplicatasDBTableView1DataControllerSummaryAfterSummary(
      ASender: TcxDataSummary);
    procedure btnConfigurarGridClick(Sender: TObject);
  private
    { Private declarations }
    blnResult: boolean;
    qryTmpExc: TUniQuery;
    frmBaixaBusca : TfrmBaixaBusca;
    qryConPor: TUniQuery;
    qryConCli: TUniQuery;
    qryConEmp: TUniQuery;
    cdsCtaRec: TUniClientDataSet;
    dtsCtaRec: TDataSource;
    cdsRateio: TUniClientDataSet;
    cdsChqPre: TUniClientDataSet;
    cdsChqVis: TUniClientDataSet;
    cdsRelCtr: TUniClientDataSet;
    objBaixaReceber: TBaixaReceber;
    blnRecalJur: Boolean;
    strAceCtr: String;
    strNumDoc: String;
    strValFil: String;
    strCamFil: String;
    strTipBai: String;
    strDtaRec: String;
    strDtaAnt: String;
    strCliSel: String;
    strPorBai: String;
    strCtaBai: String;
    strDtaLan: String;
    strDocBai: String;
    strHisBai: String;
    strHist02: String;
    strNomFil: String;
    strTipImp: String;
    strEmpCod: String;

    dtaDtaLan : TDateTime;

    dicBaixa  : TDictionary <String,Variant>;
    arrCartoes: TCartoesResumoCaixaArray;

    fltValPag: Double;
    fltValJur: Double;
    fltValDes: Double;
    fltValCal: Double;

    blnSelTod: Boolean;
    blnMostrarMsgRecibo: Boolean;
    FBlnBaiTotal: Boolean;

    intLockCf: Integer;
    intSeqCon: Integer;
    intDCrRec: Integer;
    intDCrRecPor1: Integer;
    intSemaforo: Integer;
    blnBaiUtl: Boolean;

    blnBaixouDup: Boolean;

    blnDescFinanSomenteAteVenc: Boolean;

    editorFast: TFastPrintFileEditor;
    reciboCtr : TReciboCtr;
    reciboCtrMeiaFolha : TReciboCtrMeiaFolha;

    blnMarcandoTodas : Boolean;

    fltCreSel: Double;
    stlDupPro: TStringList;
    fltCreUti: Double;
    fltValCli: Double;

    arrClientes: TConsultasArray;
    arrRede    : TConsultasArray;
    arrEvento  : TConsultasArray;
    arrEmp     : TConsultasArray;
    arrPortador: TConsultasArray;
    arrPrj     : TConsultasArray;
    arrVend    : TConsultasArray;
    blnDiaUtil : Boolean;

    strClientes: String;
    strRede    : String;
    strEvento  : String;
    strEmp     : String;
    strPortador: String;
    strVend    : String;
    objFechamento: TFechamentoFinanceiro;

    blnLiberouUtiCredProf : Boolean;

    objLiberacao : TLiberacao;
    objLock: TLock;
    objProrrogacao : TProrrogacaoDeTitulos;
    strMarcacaoLog: String;

    objLogLibRec : TLogLibRec;

    documento: TDocAdiantamento;
    dadosAdiantamento: TDadosAdiantamento;

    FListaMarcarTodas: TStringList;

    FObjetoPixRecebimento: TDadosRetornoPixConsulta;

    FObjetoPixEmail: TDadosRetornoPixAVista;

    FDuplicatasPix: TUniClientDataset;

    FPixJaGerado: Boolean;

    FLiberadoUtilizacaoCredito: Boolean;
    blnMarcouTodas: Boolean;

    FCloneDatasetMarcados,
    FRelCtrCredito: TUniClientDataset;

    FConfiguracaoGrid: TConfiguracaoGrids;

    fltPercJurosAplicado : Double;

    FLogCancelamento : TLogCancelamento;

    FBaixaIniciada,
    FAtualizarGrid: Boolean;

    FNaoMarcarCreditos: Boolean;
    FValidarCreditosDeMesmoClienteOuRedeLojas: Boolean;

    procedure pTemBaixaTotalBaixaReceber;

    function fRetornaTotalCliente(strCodCli: String;
      cdsGen: TUniClientDataSet): Real;
    procedure pExibeTotais;
    function ExisteDuplicatasSelecionadasNaoExibidasNoGrid: Boolean;
    function fGravaMovBanValoresSeparados(pcdsDups : TUniClientDataSet; pStrCtaBai, pStrPorBai,
      pStrOpeBai: String; pDtaLan, pHraLan: TDateTime; pStrNumDoc, pStrCreDeb,
      pStrCodEmpBai: String; pfltValReceb: Double; pStrHist01, pStrHist02, pStrHistBai,
      pStrCodCli, pstrCodFor, pStrNroDup: String; pIntSeqBai: Integer;
      pStrParDup, pStrCodEmp, pSerie, pStrCodEve, pStrDocBai: String;
      pStrEspDoc: String; pfltValOri, pfltValJur,
      pfltValDes, pfltValDup: Double; pAutoincrem, pTipoBaixa : string): String;
    function fVerificaPlanoContasSeparacaoJurosDesconto: Boolean;
    function fGravaMovCtr(cdsDups : TUniClientDataSet; strAutoIn, strSeqlan, strCodEmp: String): String;

    function fGravaCreditoLancamentosSeparados(pcdsDups: TUniClientDataSet;
      strCfgBaiAna, strCtaBai, strPorBai, strOpeBai: String; dtaLan,
      hraLan: TDateTime; strNumDoc, strCreDeb, strCodEmpBai: String;
      fltValReceb: Double; strHist01, strHist02, strHistBai, strCodCli,
      strCodFor, strNroDup: String; intSeqBai: Integer; strParDup, strCodEmp,
      serie, strCodEve, strDocBai, strEspDoc: String; fltValOri, fltValJur,
      fltValDes, fltValDup: Double; strAutoincrem: String): String;
    function fGravaDescontoLancamentosSeparados(pcdsDups: TUniClientDataSet;
      strCfgBaiAna, strCtaBai, strPorBai, strOpeBai: String; dtaLan,
      hraLan: TDateTime; strNumDoc, strCreDeb, strCodEmpBai: String;
      fltValReceb: Double; strHist01, strHist02, strHistBai, strCodCli,
      strCodFor, strNroDup: String; intSeqBai: Integer; strParDup, strCodEmp,
      serie, strCodEve, strDocBai, strEspDoc: String; fltValOri, fltValJur,
      fltValDes, fltValDup: Double; strAutoincrem: String): String;
    function fGravaJurosLancamentosSeparados(pcdsDups: TUniClientDataSet;
      strCfgBaiAna, strCtaBai, strPorBai, strOpeBai: String; dtaLan,
      hraLan: TDateTime; strNumDoc, strCreDeb, strCodEmpBai: String;
      fltValReceb: Double; strHist01, strHist02, strHistBai, strCodCli,
      strCodFor, strNroDup: String; intSeqBai: Integer; strParDup, strCodEmp,
      serie, strCodEve, strDocBai, strEspDoc: String; fltValOri, fltValJur,
      fltValDes, fltValDup: Double; strAutoincrem: String): String;
    function fVerificaAlteracaoDespesaCobranca(strAutoin: String;
      flVlDescCob: Double): Boolean;

    Type TPonderada = Record
      intDiasAtr: Double;
      fltTotVlr : Double;
      fltTotPon : Double;
    End;

    Type TDadosBaixaParcial = record
      ValorNovaDuplicata,
      JurosNovaDuplicata,
      DescontoNovaDuplicata,
      ValorBaixaDuplicata,
      FatorBaixaDuplicata,
      FatorJurosDuplicata,
      DespesasNovaDuplicata,
      DespesasBaixaDuplicata,
      DescontoBaixaDuplicata: Double;
    End;

    procedure pLimpaInfo;
    procedure pLiberaDupsMarcadas;
    procedure pCarregaCliente;
    procedure pMostraObsCliente;
    procedure pCarregaEvento;
    procedure pCarregaEmpresa;
    procedure pCarregaPortador;
    procedure pCarregaRede;
    procedure pCarregaVendedor;
    procedure pSetaFields(cdsClient: TUniClientDataSet);
    procedure pLimpaDados;
    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);
    procedure pSelecionaDuplicata;
    procedure pSelecionarDuplicata(blnSelTodas : Boolean = False);
    procedure pMarcaDuplicata(blnMarcar: Boolean;
                              strTipBai: String;
                              fltValor,
                              fltValDes,
                              fltValJur: Double;
                              strDtaRec: String;
                              ACalculoBaixaParcial: Double;
                              ADadosParcial: TDadosBaixaParcial;
                              blnRecAut: Boolean = False;
                              fltDesCob: Double = 0;
                              fltValCal: Double = 0);

    procedure pMarcarDuplicata(blnMarcar: Boolean; blnVerTrava: Boolean = True; blnRecAut: Boolean = False; blnSelTodas : Boolean = False);
    function fVerificaDupExiste(strNumDup,
                                strParcel,
                                strEspDoc,
                                strCodEmp,
                                strCodCli: String;
                                intSeqBai: Integer): Boolean;
    function fVerificaDupBaixada(strNumDup,
                                 strParcel,
                                 strEspDoc,
                                 strCodEmp,
                                 strCodCli: String;
                                 intSeqBai: Integer): Boolean;
    procedure pRecalculaJuros;
    procedure pCalculaJuros(fltPerJur, fltPerMul: Double; strAplJur: String);
    function fBaixaDuplicatas(pgbProgresso: TcxProgressBar): Boolean;
//    function fValorCalculado(fltValSuj, fltJuros, fltPerDPo, fltDesCob : Double): Double;
    procedure pRetDupSelecionadas(Var intDupCx: Integer;
                                  Var fltTotCx: Double);
    function fGravaCreditoCliente(fltValCre: Double; intSeqCon: Integer): Boolean;
    function fGravaCheques: Boolean;
    procedure pImprimeRecibo(fltValorAcrescimo: Double = 0;
                             fltValorRecebido: Double = 0);
    function fCriaClientRecibo: TUniClientDataSet;
    function fCriaListaClientes: TStringList;
    function fImprimeReciboLayout(fltValorAcrescimo: Double = 0;
                                  fltValorRecebido: Double = 0): Boolean;
    function fLogChq(cdsLog: TUniClientDataSet; intOpcao: Integer): Boolean;
    function fMarcaDuplics(pgbProgresso: TcxProgressBar): Boolean;
    function TemClientesOuRedeLojasDiferentes: Boolean;
    procedure pAtualizarValorJurosRecalculado;
    procedure pStepStatusSelecao(pgbStatus: TcxProgressBar);
    procedure pCarregaImpostoProporcional(fltValor: Double; out fltValIpi, fltValRet, fltValAce, fltValFre, fltValCbs, fltValIbs, fltVal_Is: Double);

    function fDuplicataTravada(strNumDup,
                               strEspDoc,
                               strCodEmp,
                               strCodCli,
                               strParcel: String;
                               blnMostraInfo : Boolean = False;
                               AExibirMensagem: Boolean = True): Boolean;

    procedure pDestravarParcela(strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel: String);
    function fVerificaDireitoBaixa: Boolean;
    procedure pVerificaDestravarLckProf;
    function LockDuplicatas(pgbProgresso: TcxProgressBar): Boolean;
    function VerificacoesParaBaixa(pgbProgresso: TcxProgressBar): Boolean;
    function fVerificaDuplicatasExcluidas: Boolean;
    function fDuplicatasJaUtilizadasPorOutrosUsuarios: Boolean;
    function  fRetChaveLckProf: String;
    function  fValidaLiberacaoCreditoProfissional: Boolean;
    procedure pDesmarcaDuplicatasCreditoProfissional;
    function fDesmarcarDuplics(pgbProgresso: TcxProgressBar): Boolean;
    procedure pBuscarIni;
    procedure pBuscarProx;
    procedure pFrmDigValores;
    function fMarcarDuplicsValorInformado(pgbProgresso: TcxProgressBar): Boolean;
    procedure pFrmFormaPgto(ACodigoPortador,
                            ACodigoPlanoDeContas: String);
    function fVerificaTemRegCH: Boolean;
    function RestaurarRemessaBancaria(AAutoInc : String):Boolean;
    procedure pMostraDuplicatasSelecionadas;
    function LiberacaoBaixaTotalComDesconto: Boolean;
    function LiberacaoConfirmacaoDaBaixa: Boolean;
    function fField(strName: String): TField;
    function fGetChaveAcessoDocumento: String;
    function fGetNumeroCooDocumento: String;
    function fLiberarDocumentoSemAutorizacaoSefaz: Boolean;
    function fVerificaDocumentoAutorizadoSefaz: Boolean;
    function fExisteCancelamentoPendentePorChaveAcesso: Boolean;
    function fEhMesmoClienteOuMesmaRedeDeLojas(Var blnTemCreditos: Boolean): Boolean;
    function fPodeSelecionarCreditoClienteDiferentes: Boolean;
    function fValidaCreditosVencidos: Boolean;
    function fApagarBoletoAdiantamento: Boolean;
    function fValidaValorBaixa(const fltValor:Double): Boolean;
    function fLiberaBaixaParcialComJuros(fltValInf: Double): Boolean;
    procedure pAplicaDescontoGeral;
    function fZerosAEsquerdaRomaneio(strNumero: string; intTamanho: integer): string;
    function fExisteDataRecebimentoInvalida: Boolean;
    function fLockedByCurrentConnection(strChaLck: String): Boolean;
    function DuplicataDeCreditoLiberada(ANumDup, AParcel, AEspDoc, ACodEmp, ACodCli: string): Boolean;
    function  fValidaDuplicatasDeCredito(ADuplicatas: TArrayDuplicatasCredito): Boolean;
    procedure pDesmarcaDuplicatasDeCredito(ADuplicatas: TArrayDuplicatasCredito);
    function MarcandoTodasDuplicatasELiberado: Boolean;
    procedure pUtilizaRotinaProjeto;
    function fApagarBoletoDeAdiantamentoPedido(): Boolean;
    function fUsaRotinaBoletoAdiantamento(): Boolean;
    function fInfDup(strCampo, strTitulo: String): String;
    function fApenasBoletoAdiantamento(): Boolean;
    function fUtilizaCredEmpresa(): Boolean;
    procedure pChamarManutencaoCtr;
    procedure pAjustarBtnSairBaixa;
    procedure pHabilitaFiltroFiliais;

    function GerarPixDasDuplicatas(pgbProgresso: TcxProgressBar): Boolean;
    function DuplicataComPixGeradoEAtivo: Boolean;
    function ValidarValorPixComDataSetMarcadas(AValorPix: Double;
                                               ADatasetPix: TDataset): Boolean;

    function DeterminaCodigoDoClienteDevedorPix(ADataset: TDataset): String;

    procedure BaixarDuplicatasLendoQRCodePix(ARegistroPix: TUniClientDataSet);

    function TravaDuplicatasParaBaixaDoPix(var ADataset: TUniClientDataset): Boolean;
    function BaixarMaisDeUmaDuplicataPix: Boolean;
    function PermiteGerarPixEmDuplicataComBoletoHibrido: Boolean;

    function ExisteDuplicataDeEspeciePDSelecionada: Boolean;
    procedure pAddLogDtaRet(ALiberacao: TLiberacao);
    function DuplicataJaEmUsoPorOutraEstacao(AChave: String): Boolean;

    procedure CriarClientCreditoGerado(ASequencialControle,
                                       ACodigoEmpresa: String);

    function HabilitaRecebimentoPorBoleto(ADataset: TDataset): Boolean;

    procedure ConfiguraDatasetCtaRec(AHabilitarFuncoes: Boolean);

    procedure IncluiRegistroMarcado;

    procedure GravarLogCtrDuplicatas(AArrayGravacaoLog: Array Of TGravacaoLogCtr;
                                     var pgbProgresso: TcxProgressBar);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pCriaTemporaria;
    procedure pCalculaValorCorrigido;
    procedure pCalculaTotalDuplicatas(edtDesconto, edtJuros, edtTotal, edtQuant: TEditFocus; blnFiltrar: Boolean; ADataset: TDataset);
    function fRetornaMediaPonderadaNova(strCodCli:String;objDados:TUniClientDataSet; blnCalcDiaUtil:Boolean=False):String;
    function fGetClienteSelecionado(var ACodigoClienteSelecionado : String) : Boolean;
    function fTemPermissaoFaturarSemExpedicao(pgbProgresso: TcxProgressBar): Boolean;
  public
    { Public declarations }


    strAutIncManCtr : String;
    strCodOpe: String;
    strNumRom: String;
    stlConjugadas: TStringList;
    recUltDupBaixada : TUltDupBaixada;
    blnApenasImpressaoRecibo: Boolean;

    strDupsGeradasAntec: String; // Duplicartas geradas pela antecipação de recebiveis

    fltValDin   : Double;
    fltValCar   : Double;
    fltValOrd   : Double;
    fltValCqP   : Double;
    fltValCqV   : Double;
    fltValCredito : Double;
    blnCarregaBaixa: Boolean;

    fltValorBaixa: Double;
    strCodPorFix: String;
    dteDtaRecFix: TDateTime;
    arrSeqLan: TStringArray;

    procVisualizaDocumentoReimpressao: TMostraDocumentoReimpressao;
  end;


implementation

uses
  {$IFNDEF LINUX}
    untArredondaParcelasCartoes,
  {$ENDIF LINUX}
  SysUtils, Variants, Graphics, StrUtils, UniDataSetProvider, untConsultas,
  untFatMostraObsCliente, untPesqAux, untBaixaDigValores,
  untFuncoes, untDigValor, untFuncFat, untConstantes,
  untConsDuplicSelec, untCtrRecalculoJuros, untBaixaCtrAnalitica,
  untBaixaSintetica, untFatFormasPagamento, untMovBan, untMovCar,
  untQckReciboCtaReceber, untCfgRel, untWaitWindow, untBaixaCtrDigDtaPag,
  untGravando, untFuncoesConsulta, untRcxTravas, untTCadChqRepository,
  untDuplicatas, untArredondaParcelaImpl,
  untBaixaDescGeral, untFuncoesGenerica, System.Math, System.Generics.Defaults,
  untAdiantamentoCliente, untConsultarAdiantamentos, untMsgLiberacao,
  untRelFatVendasClienteF9, untFuncoesAuxiliares, untModuloSPR,
  untRelRcxReciboCob, untDigEmail, untEnvioEmail, untTEnvioEmail, untMemo,
  untInfCobranca, untAtualizaOcorrenciasCRM, untTypesCRM,
  untRelFatVendasCliente, untFuncoesRel, untFuncoesRel2,untAdiantamentoClienteGenerico,
  untCadCtaReceber, untTFuncoesPixAutcom, untTBaixaReceberEmail, untTIntegracaoPixCitel,
  untIIntegracaoPixCitel, untTFuncoesAuxiliaresPix, untTPixDao,
  untCtrSelecionaOpcaoDuplicataComPix, untConfiguracaoGrids, untPgtOnlineApi;

{$R *.dfm}

function TfrmBaixaReceber.fField(strName: String): TField;
begin
  Result := cdsCtaRec.FieldByName(strName);
end;

function TfrmBaixaReceber.fGetChaveAcessoDocumento: String;
begin
  Result := fRetChaveAcesso(fField('NRODUP'    ).AsString,
                            fField('CTR_ESPDOC').AsString,
                            fField('CTR_CODCLI').AsString,
                            fField('CTR_CODEMP').AsString);
end;

function TfrmBaixaReceber.fGetNumeroCooDocumento: String;
begin
  Result := fRetNumeroCOO(fField('NRODUP'    ).AsString,
                          fField('CTR_ESPDOC').AsString,
                          fField('CTR_CODCLI').AsString,
                          fField('CTR_CODEMP').AsString);
end;

function TfrmBaixaReceber.fLiberaBaixaParcialComJuros(fltValInf: Double): Boolean;
var
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
begin

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddQuebra;
  objLiberacao.objMsgLibera.pAddSeparador(127);
  objLiberacao.objMsgLibera.pAddTexto('LIBERAÇÃO DE BAIXA PARCIAL DE DUPLICATA COM JUROS', alCentro, teAmbos, '',127);


  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'DUPLICATA'     , 21 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'CLIENTE'       , 27 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'DT.CAD.'       , 11 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'DT.VENC.'      , 11 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'VR.ORIGINAL'   , 15 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'VR.CORRIGIDO'  , 14 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'VR.BX.PARCIAL' , 13 , alDireita  , teAutcom);
  objTabela.lstLinhas.Add(objLinha);


  with  cdsCtaRec do
  begin

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.pAddColuna('DUPLICATA'     , fPadR(FieldByName('NRODUP').AsString,12) +
                                          FieldByName('PARDUP').AsString + '-' +
                                          FieldByName('CTR_ESPDOC').AsString + '-' +
                                          FieldByName('CTR_CODEMP').AsString                                , 21 , alEsquerda );
    objLinha.pAddColuna('CLIENTE'       , FieldByName('CTR_NOMCLI').AsString                                , 27 , alEsquerda );
    objLinha.pAddColuna('DT.CAD.'       , FormatDateTime('dd/mm/yyyy',FieldByName('CTR_DTACAD').AsDateTime) , 11 , alCentro   );
    objLinha.pAddColuna('DT.VENC.'      , FormatDateTime('dd/mm/yyyy',FieldByName('CTR_DTAVEN').AsDateTime) , 11 , alCentro   );
    objLinha.pAddColuna('VR.ORIGINAL'   , FloatToStrF(FieldByName('CTR_VALDUP').AsFloat, ffNumber, 9, 2)    , 15 , alDireita  );
    objLinha.pAddColuna('VR.CORRIGIDO'  , FloatToStrF(FieldByName('CTR_VALCAL').AsFloat, ffNumber, 9, 2)    , 14 , alDireita  );
    objLinha.pAddColuna('VR.BX.PARCIAL' , FloatToStrF(fltValInf                        , ffNumber, 9, 2)    , 13 , alDireita  );
    objTabela.lstLinhas.Add(objLinha);
  end;

  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

  objLiberacao.strDirAce := 'BAIDUPJUR';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;
  objLiberacao.objMsgLibera.strTitulo := 'LIBERAÇÃO DE BAIXA PARCIAL DE DUPLICATA COM JUROS';

  Result := objLiberacao.fLibera;

  if Result then
     ObjLoglibRec.pInsereLogLigTMP( objLiberacao, cdsCtaRec.FieldByName('CTR_NUMDUP').AsString, cdsCtaRec.FieldByName('CTR_ESPDOC').AsString, cdsCtaRec.FieldByName('CTR_CODEMP').AsString );

end;

function TfrmBaixaReceber.fLiberarDocumentoSemAutorizacaoSefaz: Boolean;
begin
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Permitir recebimento de duplicatas ( NF/IF ) mesmo sem autorização da SEFAZ');
  objLiberacao.objMsgLibera.pAddTextoCaption('Documento', fField('NRODUP'    ).AsString + '-' +
                                                          fField('CTR_ESPDOC').AsString + '-' +
                                                          fField('CTR_CODEMP').AsString);

  objLiberacao.strDirAce := 'LIBRECNFIFSEMAUTSEFAZ';
  objLiberacao.strMsgSen := 'Permitir recebimento de duplicatas ( NF/IF ) mesmo sem autorização da SEFAZ';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  Result := objLiberacao.fLibera;

  if Result then
     ObjLoglibRec.pInsereLogLigTMP( objLiberacao, fField('NRODUP').AsString, fField('CTR_ESPDOC').AsString, fField('CTR_CODEMP').AsString );

end;

procedure TfrmBaixaReceber.btnDuplicataAgrupadaClick(Sender: TObject);
var
  SCodigoClienteSelecionado : string;
  strNumDoc: String;
begin
  inherited;

  If (cdsCtaRec.IsEmpty) Then
  Begin
    pMensagemOk('É necessário selecionar ao menos uma duplicata para realizar a consulta!');
    Exit;
  End;

  strNumDoc := cdsCtaRec.FieldByName('CTR_NUMDUP').AsString;

  if not fGetClienteSelecionado(SCodigoClienteSelecionado) then
    Exit;

  cdsCtaRec.Locate('CTR_NUMDUP', strNumDoc, []);


  If (cdsCtaRec.FieldByName('CTR_ESPDOC').AsString <> 'AG') Then
  Begin
    pMensagemOk('A Duplicata de Nº: '+cdsCtaRec.FieldByName('CTR_NUMDUP').AsString+' Espécie: '+cdsCtaRec.FieldByName('CTR_ESPDOC').AsString+' não é de agrupamento!');
    Exit;
  End
  Else
  Begin
    pMostraDuplicatasAgrupadas(Copy(cdsCtaRec.FieldByName('CTR_NUMDUP').AsString, 1, 12),
                               cdsCtaRec.FieldByName('CTR_CODEMP').AsString,
                               cdsCtaRec.FieldByName('CTR_CODCLI').AsString,
                               False{nao veio pelo Resumo de Caixa});
  End;


end;

procedure TfrmBaixaReceber.btnEmailPixClick(Sender: TObject);
Var
    LEnviarEmail,
    LEnviarSMS,
    LEnviarWhatsapp,
    LDeveSelecionar: Boolean;

    LEmailPix: TBaixaReceberEmail;

    LDadosEmail: TDadosDisparaEmail;

    LGravando: TfrmGravando;
begin
  If FBaixaIniciada Then
    Exit;

  inherited;

  If Not btnEmailPix.Visible Then
    Exit;

  If Not FPixJaGerado Then
  Begin
    LDeveSelecionar := Not cdsCtaRec.Active;
    If Not LDeveSelecionar THen
    Begin
      LDeveSelecionar := cdsCtaRec.IsEmpty;

      If Not LDeveSelecionar Then
        LDeveSelecionar := Not cdsCtaRec.Locate('CTR_MARDES', 'M', []);
    End;

    if LDeveSelecionar then
    begin
      fMensagem('ATENÇÃO', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
      Exit;
    End;

    If fStrToFloat(edtTotalRecebido.Text) <= 0.00 Then
    Begin
      fMensagem('ATENÇÃO', 'Não é possível utilizar essa função com recebimento menor ou igual a zero!', ['&Ok']);
      Exit;
    End;

    If Not PermiteGerarPixEmDuplicataComBoletoHibrido Then
      Exit;
  end;

  cdsCtaRec.Locate('CTR_MARDES', 'M', []);

  If fClienteConsumidor(fRetNomCliente(fField('CTR_CODCLI').AsString) ,True, True) Then
  Begin
    fMensagem('ATENÇÃO', 'Essa operação não pode ser utilizada para cliente consumidor.', ['&Ok']);
    Exit;
  End;

  LEnviarEmail := TBaixaReceberEmail.DeveEnviarEmail('PX',
                                                     staNenhumaAcao,
                                                     fField('CTR_EMACLI').AsString);
  LEnviarSMS := TBaixaReceberEmail.DeveEnviarSms('PX',
                                                 staNenhumaAcao,
                                                 fField('CLI_CELULA').AsString);
  LEnviarWhatsapp := TBaixaReceberEmail.DeveEnviarWhatsapp('PX',
                                                           staNenhumaAcao,
                                                           fField('CLI_CELULA').AsString);

  If Not TBaixaReceberEmail.PossuiAlgumModeloAEnviarPix(LEnviarEmail, LEnviarSMS, LEnviarWhatsapp) Then
  Begin
    fMensagem('ATENÇÃO', 'Não existe modelo de e-mail/whatsapp/sms ou dados do cliente faltando para o envio do Pix!', ['&Ok']);
    Exit;
  End;

  If ExisteDuplicataDeEspeciePDSelecionada Then
    Exit;

  Try
    Try
      If Not FPixJaGerado Then
      Begin
        pCriarFormularios(TfrmGravando, LGravando);
        LGravando.fExecutarAcao := GerarPixDasDuplicatas;
        LGravando.lblGravando.Caption := 'Aguarde... Gerando Pix da cobrança';
        If fCfgSis('HOMPIX', varBoolean) Then
          LGravando.lblGravando.Caption := LGravando.lblGravando.Caption + ' (homologação)';
        LGravando.lblGravando.Caption := LGravando.lblGravando.Caption + '.';
        LGravando.pgbStatus.Visible := False;
        LGravando.ShowModal;

        If Not LGravando.blnConfirma Then
          Exit;
      End;

      LDadosEmail.strCodCli := DeterminaCodigoDoClienteDevedorPix(FDuplicatasPix);
      LDadosEmail.strEmaCob := fField('CTR_EMACLI').AsString;
      LDadosEmail.QRCodePix := FObjetoPixEmail.TextoQrCode;
      LDadosEmail.LinkCitelPix:= TFuncoesPix.RetornaLinkCitel(FObjetoPixEmail.LinkCitel);
      LDadosEmail.strValDup := FormatFloat(',0.00', FObjetoPixEmail.Valor);

      LEmailPix := TBaixaReceberEmail.Create(LDadosEmail,
                                             FDuplicatasPix,
                                             staNenhumaAcao);

      If LEnviarEmail Then
      Begin
        pCriarFormularios(TfrmGravando, LGravando);
        LGravando.fExecutarAcao := LEmailPix.EnviarEmailBaixaReceberPix;
        LGravando.lblGravando.Caption := 'Aguarde... Enviando o e-mail do Pix ao cliente.';
        LGravando.pgbStatus.Visible := False;
        LGravando.ShowModal;
      End;

      If LEnviarSMS Then
      Begin
        pCriarFormularios(TfrmGravando, LGravando);
        LGravando.fExecutarAcao := LEmailPix.EnviarSMSBaixaReceberPix;
        LGravando.lblGravando.Caption := 'Aguarde... Enviando o SMS do Pix ao cliente.';
        LGravando.pgbStatus.Visible := False;
        LGravando.ShowModal;
      End;

      If LEnviarWhatsapp Then
      Begin
        pCriarFormularios(TfrmGravando, LGravando);
        LGravando.fExecutarAcao := LEmailPix.EnviarWhatsappBaixaReceberPix;
        LGravando.lblGravando.Caption := 'Aguarde... Enviando o Whatsapp do Pix ao cliente.';
        LGravando.pgbStatus.Visible := False;
        LGravando.ShowModal;
      End;

      fMensagem('ATENÇÃO', 'O envio da cobrança Pix ao cliente foi realizado com sucesso!', ['&Ok']);

      btnCarrTitulos.Click;
    Except
      On E: ExceptionAutcom Do
        fMensagem('ERRO', E.Message, ['&Ok']);

      On E: Exception Do
        pMensagensErro('Ocorreu um erro ao enviar o Pix ao cliente.' + #13 +
                       'Erro gerado: ' + E.Message, '[TfrmBaixaReceber.btnEmailPixClick]');
    End;
  Finally
    FreeAndNil(LGravando);

    If Assigned(FDuplicatasPix) Then
      FreeAndNil(FDuplicatasPix);

    If Assigned(LEmailPix) Then
      FreeAndNil(LEmailPix);
  End;
end;

procedure TfrmBaixaReceber.BaixarDuplicatasLendoQRCodePix(ARegistroPix: TUniClientDataSet);
  Var
    LErro,
    LChavePix,
    LRetornoPix: String;

    LQuantidadeDuplicatas: Integer;

    LValorDuplicatas: Double;
begin
  Try
    ConfiguraDatasetCtaRec(False);
    cdsCtaRec.Close;

    cdsCtaRec := fCriaClientDatSet(FDuplicatasPix);
    cdsCtaRec.First;
    FCloneDatasetMarcados := fCriaClientDatSet(FDuplicatasPix);

    If Not TravaDuplicatasParaBaixaDoPix(cdsCtaRec) Then
    Begin
      objLock.pDestravarTodos;

      Exit;
    End;

    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.fExecutarAcao := VerificacoesParaBaixa;
    frmGravando.lblGravando.Caption := 'Aguarde... Preparando Títulos.';
    frmGravando.ShowModal;
    pFreeAndNil(frmGravando);

    If Not blnResult Then
      Exit;

    If Not BaixarMaisDeUmaDuplicataPix Then
      Exit;

    Self.Enabled := False;

    LRetornoPix := TFuncoesPixAutcom.PagarPixViaPorQRCode(ARegistroPix,
                                                          Self.Name,
                                                          True);

    LErro := TFuncoesPix.RetornaMensagemErroRequisicao(LRetornoPix);
    If Not LErro.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO', 'O recebimento do Pix por QR Code não foi realizado.' + #13 +
                           LErro, ['&Ok']);
      Exit;
    End;

    FObjetoPixRecebimento := TFuncoesPix.RetornaDadosDoRetornoPixConsulta(LRetornoPix,
                                                                          ARegistroPix.FieldByName('MPX_JSOENV').AsString);

    If Not TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(FObjetoPixRecebimento) Then
    Begin
      fMensagem('ATENÇÃO', 'O recebimento do Pix por QR Code não foi realizado.', ['&Ok']);
      Exit;
    End;

    FObjetoPixRecebimento.JsonRetorno := LRetornoPix;
    FObjetoPixRecebimento.JSonRequisicao := ARegistroPix.FieldByName('MPX_JSOENV').AsString;
    FObjetoPixRecebimento.AutoIncremChavePix := LChavePix;

    FObjetoPixRecebimento.CodigoEmpresa := ARegistroPix.FieldByName('MPX_CODEMP').AsString;
    FObjetoPixRecebimento.CodigoPortador := ARegistroPix.FieldByName('POR_CODPOR').AsString;
    FObjetoPixRecebimento.AutoIncremMovPix := ARegistroPix.FieldByName('AUTOINCREM').AsString;

    FObjetoPixRecebimento.PlanoDeContas := fCfgSis('CTAPIX', varString, FObjetoPixRecebimento.CodigoEmpresa);
    If FObjetoPixRecebimento.PlanoDeContas.IsEmpty Then
      FObjetoPixRecebimento.PlanoDeContas := fCfgSis('CTAAVI', varString, FObjetoPixRecebimento.CodigoEmpresa);

    strHist02 := '';

    pRetDupSelecionadas(LQuantidadeDuplicatas, LValorDuplicatas);

    //Setando valores que são utilizados na fBaixa
    dicBaixa.AddOrSetValue('intDupCx', LQuantidadeDuplicatas);
    dicBaixa.AddOrSetValue('fltTotCx', LValorDuplicatas);

    cdsCtaRec.First;

    strPorBai := FObjetoPixRecebimento.CodigoPortador;
    strCtaBai := FObjetoPixRecebimento.PlanoDeContas;
    strDtaLan := FormatDateTime('dd/mm/yyyy', VS_Date);
    strDocBai := '';
    strHisBai := 'BAIXA DE DUPLICATAS RECEBIDA POR PIX';
    strHist02 := '';
    blnBaiUtl := fCampoTabela('POR_BAIUTL', 'CADPOR', ['POR_CODPOR'], [FObjetoPixRecebimento.CodigoPortador]) = 'S';

    TryStrToInt(fCampoTabela('POR_DCRREC', 'CADPOR', ['POR_CODPOR'], [FObjetoPixRecebimento.CodigoPortador]), intDCrRecPor1);

    dicBaixa.AddOrSetValue('strPriCli', cdsCtaRec.FieldByName('CTR_CODCLI').AsString);

    cdsChqPre := fCriaClientDataset('SELECT * FROM CADCHQ WHERE FALSE');
    cdsChqVis := fCriaClientDataset('SELECT * FROM CADCHQ WHERE FALSE');

    //Setando valores utilizados na função de baixa.
    dicBaixa.AddOrSetValue('flValCqp', 0.00);
    dicBaixa.AddOrSetValue('fltValCqV', 0.00);
    dicBaixa.AddOrSetValue('fltValDin', 0.00);
    dicBaixa.AddOrSetValue('fltValCar', 0.00);
    dicBaixa.AddOrSetValue('fltValOrd', FObjetoPixRecebimento.ValorPago);
    dicBaixa.AddOrSetValue('fltValFin', 0.00);
    dicBaixa.AddOrSetValue('fltValCre', 0.00);

    dicBaixa.AddOrSetValue('fltCreTot', 0.00);
    dicBaixa.AddOrSetValue('fltRecTot', FObjetoPixRecebimento.ValorPago);

    dicBaixa.AddOrSetValue('blnValCqP', False);
    dicBaixa.AddOrSetValue('blnValCqV', False);
    dicBaixa.AddOrSetValue('blnValDin', False);
    dicBaixa.AddOrSetValue('blnValCar', False);
    dicBaixa.AddOrSetValue('blnValOrd', True);
    dicBaixa.AddOrSetValue('blnValFin', False);

    dicBaixa.AddOrSetValue('strSeqMod', fRetSequencial('MODCTR'));

    dicBaixa.AddOrSetValue('blnConfirma', True);

    dicBaixa.AddOrSetValue('blnHisAut', False);

    dicBaixa.AddOrSetValue('RecebidoPixAvulso', False);

    dicBaixa.AddOrSetValue('RecebidoPorBoleto', False);

    fltValCli := 0.00;

    SetLength(arrCartoes, 0);

    Try
      Application.ProcessMessages;
      pCriarFormularios(TfrmGravando,frmGravando);
      frmGravando.fExecutarAcao := fBaixaDuplicatas;
      frmGravando.lblGravando.Caption := 'Aguarde... Baixando Títulos.';
      frmGravando.ShowModal;
      pFreeAndNil(frmGravando);

      if blnBaixouDup Then
      begin
        if blnMostrarMsgRecibo Then
        Begin
          If fMensagem('', 'Deseja imprimir Recibo?', ['', ''], 2) = 1 Then
            pImprimeRecibo(dicBaixa['fltCreTot'], dicBaixa['fltRecTot']);
        end;
      end;

      if (fltValorBaixa > 0) and (strCodPorFix <> '') then
      begin
        btnSairBaixa.Click;
        Exit;
      end;
    Except
      On E:Exception Do
      Begin
        pMensagensErro(e.Message,'');

        chkLimFil.Checked := True;
        pLimpaDados;
      End;
    End;
  Finally
    objLock.pDestravarTodos;

    ConfiguraDatasetCtaRec(True);
    dtsCtaRec := fCriaDataSource(cdsCtaRec);

    dbgDuplicatasDBTableView1.DataController.DataSource := dtsCtaRec;

    TfrmGravando.fExecutarModal(pCriaTemporaria,'Aguarde... Carregando Títulos','');
  End;

  Self.Enabled := True;
  pSetFocus(edtCodCli);
end;

function TfrmBaixaReceber.BaixarMaisDeUmaDuplicataPix: Boolean;
  Var
    LDuplicatas: String;
begin
  Result := True;

  If FDuplicatasPix.RecordCount <= 1 Then
    Exit;

  FDuplicatasPix.First;

  LDuplicatas := '';
  While Not FDuplicatasPix.Eof Do
  Begin
    LDuplicatas := LDuplicatas + FDuplicatasPix.FieldByName('CTR_NUMDUP').AsString + '-' +
                                 FDuplicatasPix.FieldByName('CTR_ESPDOC').AsString + '-' +
                                 FDuplicatasPix.FieldByName('CTR_CODEMP').AsString + ', ';

    If FDuplicatasPix.RecNo >= 5 Then
    Begin
      LDuplicatas := LeftStr(LDuplicatas, LDuplicatas.Length - 1) + '...';
      Break;
    End;

    FDuplicatasPix.Next;
  End;
  FDuplicatasPix.First;

  If FDuplicatasPix.RecordCount < 5 Then
    LDuplicatas := LeftStr(LDuplicatas, LDuplicatas.Length - 2) + '.';

  Result := fMensagem('ATENÇÃO', 'Esse Pix está vinculado com mais de uma duplicata.' +
                                 'Ao realizar o recebimento, todas as duplicatas serão baixadas.' + #13 +
                                 'Duplicatas: ' + LDuplicatas + #13 +
                                 'Deseja continuar?', ['&Sim', '&Não']) = 1;
end;

procedure TfrmBaixaReceber.btnAdiantamentoClick(Sender: TObject);
begin
  If FBaixaIniciada Then
    Exit;

  inherited;

  If Not fVerificaAcessoSistema('DIRRCXADC', strLoginUsuarioLogado) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Adiantamento de Cliente');

    objLiberacao.strDirAce := 'DIRRCXADC';
    objLiberacao.strMsgSen := 'Adiantamento de Cliente';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;

    If (Not objLiberacao.fLibera) Then
      Exit;
  End;

  TAdiantamento.fRealizarAdiantamentoCliente(Self.Name, strCodOpe, '', '', '', '', 'CTR');
end;

procedure TfrmBaixaReceber.btnCarrTitulosClick(Sender: TObject);
begin
  If FBaixaIniciada Then
    Exit;

  inherited;
  blnBaixouDup := False;

  If Not fVerificaCampos  Then
     Exit;

  TfrmGravando.fExecutarModal(pCriaTemporaria,'Aguarde... Carregando Títulos','');

  If cdsCtaRec.IsEmpty Then
    pSetFocus(edtCodCli)
  Else
    pSetFocus(dbgDuplicatas);
  dbgDuplicatas.Refresh;
  pAtualizaDados(cdsCtaRec);

  fltPercJurosAplicado := fCfgSis('JURATR', varDouble);

  strMarcacaoLog := '';
end;

procedure TfrmBaixaReceber.btnConfigurarGridClick(Sender: TObject);
  Var
    LConfiguracaoGrids: TfrmConfiguracaoGrids;
begin
  inherited;

  pCriarFormularios(TfrmConfiguracaoGrids, LConfiguracaoGrids);

  Try
    LConfiguracaoGrids.ConfiguracaoGridsObj := FConfiguracaoGrid;
    LConfiguracaoGrids.ChaveGrid := Concat(Self.Name, '.', dbgDuplicatasDBTableView1.Name);
    LConfiguracaoGrids.DatasetCampos := dbgDuplicatasDBTableView1.DataController.Dataset;
    LConfiguracaoGrids.WidthAutomaticoCampos := False;
    LConfiguracaoGrids.ShowModal;

    if (LConfiguracaoGrids.Confirmar) Then
      FConfiguracaoGrid.CarregarDadosSalvos(dbgDuplicatasDBTableView1);
  finally
    FreeAndNil(LConfiguracaoGrids);
  end;
end;

procedure TfrmBaixaReceber.btnConfirmaClick(Sender: TObject);
  Var 
    blnBaiAna, blnConfirma : Boolean;
    intDupCx: Integer;
    fltTotCx: Double;
    key: Char;
    frmBaixaSintetica : TfrmBaixaSintetica;
    frmBaixaCtrAnalitica : TfrmBaixaCtrAnalitica;
    strEmpSemAcesso: String;
    fltTotRecebido: Double;
    fltValSel: Double;
begin
  If FBaixaIniciada Then
    Exit;

  Self.Enabled := False;

  inherited;
  Try
    FBaixaIniciada := True;
    btnConfirma.Enabled := False;

    If ExisteDuplicatasSelecionadasNaoExibidasNoGrid Then
    begin
      fMensagem('ATENÇÃO', 'Não é possível prosseguir com a baixa, existe(m) duplicata(s) selecionada(s) ' + #13#10 +
                           'e ocultada(s) por filtros, favor verificar !', ['&Ok']);
      Exit;
    end;

    if (not cdsCtaRec.Active) or (cdsCtaRec.RecordCount = 0) then
    begin
      fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
      Exit;
    end;

    ConfiguraDatasetCtaRec(False);

    strHist02 := '';
    blnBaiAna := fCfgSis('CTR_AS') = 'A';
    blnConfirma := False;

    if fExisteDataRecebimentoInvalida then
      Exit;

    pRetDupSelecionadas(intDupCx, fltTotCx);

    //Setando valores que são utilizados na fBaixa
    dicBaixa.AddOrSetValue('intDupCx', intDupCx);
    dicBaixa.AddOrSetValue('fltTotCx', fltTotCx);

    If (Not blnLiberouUtiCredProf) And (Not fValidaLiberacaoCreditoProfissional) Then
    Begin
      pDesmarcaDuplicatasCreditoProfissional;
      Exit;
    End;

    If StrToIntDef(edtQtdSelecionadas.Text,0) <= 0 Then
    Begin
      fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
      Exit;
    End;

    If Not fSenhaCreditos(cdsCtaRec, 'CTR_VALCAL') Then
     Exit;

    If Not fValidaCreditosVencidos Then
      Exit;

    If Not fApagarBoletoAdiantamento Then
      Exit;

    If Not LiberacaoConfirmacaoDaBaixa Then
      Exit;

    If Not cdsCtaRec.IsEmpty Then
    Begin
      pCriarFormularios(TfrmGravando,frmGravando);
      frmGravando.fExecutarAcao := VerificacoesParaBaixa;
      frmGravando.lblGravando.Caption := 'Aguarde... Preparando Títulos.';
      frmGravando.ShowModal;
      pFreeAndNil(frmGravando);

      If Not blnResult Then
        Exit;

      If(fCfgSis('RECPEN', varBoolean)) And
        (VS_strTipExp = '2') And
        (fCfgSis('CXAEXP') = '2') Then
      Begin

        pCriarFormularios(TfrmGravando,frmGravando);
        frmGravando.fExecutarAcao := fTemPermissaoFaturarSemExpedicao;
        frmGravando.lblGravando.Caption := 'Aguarde... Verificando documentos com expedição pendente.';
        frmGravando.ShowModal;
        pFreeAndNil(frmGravando);

        If Not blnResult Then
          Exit;
      End;


      If fUtilizaCredEmpresa Then
      Begin
        fMensagem('ATENÇÃO!', 'O(s) crédito(s) selecionado(s) pertence(m) a(s) empresa(s) '+ strEmpCod + #13 +
                              'e o mesmo só poderá ser utilizado na empresa de origem.', ['&OK']);
        Exit;
      End;

      //Limite de valor de lançamentos se a tela for chamada pela nova
      //tela de conciliação bancária
      if (fltValorBaixa > 0) and (strCodPorFix <> '') then
      begin
        fltValSel := 0;
        if edtTotalRecebido.Text <> '' then
           fltValSel := fStrToFloat(edtTotalRecebido.Text);

        if  RoundTo(fltValSel, -2) <> RoundTo(fltValorBaixa, -2) then
        begin
          pMensagemOk('Não é possível efetuar a baixa, o valor recebido é diferente do valor para baixa.' + #13 + #13 +
                      'Valor para baixa: ' + FormatFloat('###,###,##0.00', fltValorBaixa) + #13 +
                      'Valor recebido: ' + edtTotalRecebido.Text);
          Exit;
        end;
      end;

      pTemBaixaTotalBaixaReceber;

      If blnBaiAna Then
      Begin
        Try
          pCriarFormularios(TfrmBaixaCtrAnalitica, frmBaixaCtrAnalitica);

          if strCodPorFix <> '' then
          begin
            frmBaixaCtrAnalitica.edtPorBai.Text := strCodPorFix;
            key := #13;
            frmBaixaCtrAnalitica.edtPorBaiKeyPress(nil, key);
            frmBaixaCtrAnalitica.edtPorBai.Enabled := False;
          end;
          {*******************************************}
          {* SE CTRHIS FOR <> DE HISTÓRICO DIGITADO  *}
          {***************09/03/2018**Req. 66000**WS**}
          If fCfgSis('CTRHIS') <> '2' Then
          Begin
            frmBaixaCtrAnalitica.edtHist02.Visible := False;
            frmBaixaCtrAnalitica.lblHist2.Visible := False;
          End;

          frmBaixaCtrAnalitica.blnVemCtr := True;

          fltTotRecebido :=  (StrToFloat(AnsiReplaceStr(edtTotalRecebido.Text, '.', '')));
          frmBaixaCtrAnalitica.FTotRecZero := (fltTotRecebido = 0);
          frmBaixaCtrAnalitica.FBaixaTotal := FBlnBaiTotal;

          frmBaixaCtrAnalitica.ShowModal;

          strCtaBai     := frmBaixaCtrAnalitica.strCtaBai;
          strPorBai     := frmBaixaCtrAnalitica.strPorBai;

          If fCfgSis('CTRHIS') <> '2' Then
          Begin
            //Transfere o HistBai para o Hist02
            strHist02 := frmBaixaCtrAnalitica.strHisBai;
          End
          Else
          Begin
            strHisBai := frmBaixaCtrAnalitica.strHisBai;
            strHist02 := frmBaixaCtrAnalitica.strHist02;
          End;

          intDCrRecPor1 := frmBaixaCtrAnalitica.intDCrRecPor1;
          blnBaiUtl     := frmBaixaCtrAnalitica.blnBaiUtl;
          blnConfirma   := frmBaixaCtrAnalitica.blnConfirma;
          dicBaixa.AddOrSetValue('blnHisAut', fEmptyStr(strHisBai));

        Except
          On E: Exception Do
          Begin
            strCtaBai := '';
            strPorBai := '';
            strHisBai := '';
            strHist02 := '';
            pMensagensErro(E.Message,'');

          End;
        End;

        pFreeAndNil(frmBaixaCtrAnalitica);
      End

      Else
      Begin
        Try
          pCriarFormularios(TfrmBaixaSintetica, frmBaixaSintetica);

          frmBaixaSintetica.dtaDtaBai := VS_Date;
          frmBaixaSintetica.blnVemCtr := True;
          frmBaixaSintetica.cdsCadRec_VerificaData := cdsCtaRec;
          frmBaixaSintetica.cdsCadRec_VerificaData.First;

          if strCodPorFix <> '' then
          begin
            frmBaixaSintetica.edtPorBai.Text := strCodPorFix;
            key := #13;
            frmBaixaSintetica.edtPorBaiKeyPress(nil, key);
            frmBaixaSintetica.edtPorBai.Enabled := False;
            frmBaixaSintetica.mskDtaLan.text :=  FormatDateTime('dd/mm/yyyy', dteDtaRecFix);
            frmBaixaSintetica.mskDtaLan.Enabled := false;
          end;

          fltTotRecebido :=  (StrToFloat(AnsiReplaceStr(edtTotalRecebido.Text, '.', '')));
          frmBaixaSintetica.FTotRecZero := (fltTotRecebido = 0);
          frmBaixaSintetica.FBaixaTotal := FBlnBaiTotal;
          frmBaixaSintetica.ShowModal;

          strPorBai     := frmBaixaSintetica.strPorBai;
          strCtaBai     := frmBaixaSintetica.strCtaBai;
          strDtaLan     := frmBaixaSintetica.strDtaLan;
          strDocBai     := frmBaixaSintetica.strDocBai;
          strHisBai     := frmBaixaSintetica.strHisBai;
          strHist02     := frmBaixaSintetica.strHist02;
          intDCrRecPor1 := frmBaixaSintetica.intDCrRecPor1;
          blnConfirma   := frmBaixaSintetica.blnConfirma;
          blnBaiUtl     := frmBaixaSintetica.blnBaiUtl;
        Except
          On E: Exception Do
          Begin
            strPorBai := '';
            strCtaBai := '';
            strDtaLan := '';
            strDocBai := '';
            strHisBai := '';
            strHist02 := '';
            pMensagensErro(E.Message,'');
          End
        End;

        pFreeAndNil(frmBaixaSintetica);

      End;

      If (Not blnConfirma) Then
      Begin
        Exit;
      End;

      {*REQ*145940**********RP*}
      If Not fEmptyStr(strPorBai) Then
      Begin
        If Not fEmpresasTemAcessoPortador(strPorBai, cdsCtaRec, 'CTR_CODEMP', strEmpSemAcesso, 'CTR_MARDES = ''M''') Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa(s) sem acesso ao cadastro do Portador informado: '+ strEmpSemAcesso +'. Operação abortada!', ['&OK']);
          Exit;
        End;
      End;

      {***********************************}
      {* REALIZA A VERIFICAÇÃO DO CADCBI *}
      {********************************AF*}
      If Not objBaixaReceber.fAnalizaCadCbiCtr Then
      Begin
        Exit;
      End;

      pFrmFormaPgto(strPorBai,
                    strCtaBai);

      blnConfirma := dicBaixa['blnConfirma'];

      If  blnConfirma Then
      Begin
        Try
          Application.ProcessMessages;
          pCriarFormularios(TfrmGravando,frmGravando);
          frmGravando.fExecutarAcao := fBaixaDuplicatas;
          frmGravando.lblGravando.Caption := 'Aguarde... Baixando Títulos.';
          frmGravando.ShowModal;
          pFreeAndNil(frmGravando);

          if blnBaixouDup Then
          begin
            if blnMostrarMsgRecibo Then
            Begin
              If fMensagem('', 'Deseja imprimir Recibo?', ['', ''], 2) = 1 Then
              Begin
                pImprimeRecibo(dicBaixa['fltCreTot'], dicBaixa['fltRecTot']);
              End;
            end;
          end;

          FCloneDatasetMarcados.First;

          While Not FCloneDatasetMarcados.Eof Do
          Begin
            objLock.fLock_Unlock('CADREC' +
                     FCloneDatasetMarcados.FieldByName('NRODUP').AsString +
                     FCloneDatasetMarcados.FieldByName('CTR_ESPDOC').AsString +
                     FCloneDatasetMarcados.FieldByName('CTR_CODEMP').AsString +
                     FCloneDatasetMarcados.FieldByName('CTR_CODCLI').AsString +
                     FCloneDatasetMarcados.FieldByName('PARDUP').AsString, False);

            objLock.fLock_Unlock('CADREC' +
                     FCloneDatasetMarcados.FieldByName('NRODUP').AsString +
                     FCloneDatasetMarcados.FieldByName('CTR_ESPDOC').AsString +
                     FCloneDatasetMarcados.FieldByName('CTR_CODEMP').AsString +
                     FCloneDatasetMarcados.FieldByName('CTR_CODCLI').AsString, False);

            FCloneDatasetMarcados.Next;
          End;

          If chkLimFil.Checked Then
            pLimpaDados
          Else
            TfrmGravando.fExecutarModal(pCriaTemporaria,'Aguarde... Carregando Títulos','');

          if (fltValorBaixa > 0) and (strCodPorFix <> '') then
          begin
            btnSairBaixa.Click;
            Exit;
          end;
        Except
          On E:Exception Do
          Begin
            pMensagensErro(e.Message,'');

            chkLimFil.Checked := True;
            pLimpaDados;
          End;
        End;
      End;
    End;
  Finally
    FBaixaIniciada := False;
    btnConfirma.Enabled := True;

    ConfiguraDatasetCtaRec(True);

    Self.Enabled := True;
    pSetFocus(edtCodCli);

    If Not fEmptyStr(strAutIncManCtr) Then
      Close;
  End;
end;

procedure TfrmBaixaReceber.btnDescontoGeralClick(Sender: TObject);
  Var
    blnConfirma: Boolean;
begin
  inherited;

  If cdsCtaRec.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhuma duplicata carregada!', ['&Ok']);
    Exit;
  End;

  If (Not FCloneDatasetMarcados.IsEmpty) And fApenasBoletoAdiantamento Then
  Begin
    fMensagem('ATENÇÃO!','Não é permitido dar desconto para duplicatas de espécie PD cujos boletos foram emitidos!', ['&Ok']);
    Exit;
  End;

  Application.ProcessMessages;
  Try
    ConfiguraDatasetCtaRec(False);
    Try
      pCriarFormularios(TfrmBaixaDescGeral, frmBaixaDescGeral);
      Try
        frmBaixaDescGeral.cdsDuplicatas := FCloneDatasetMarcados;
        frmBaixaDescGeral.blnCtaReceber := True;
        frmBaixaDescGeral.ShowModal;
      Except
        On E: Exception Do
        Begin
          pMensagensErro('Ocorreu um erro ao acessar a rotina de Desconto Geral do Contas a Receber.' +
                         'Erro gerado: ' + E.Message, '[TfrmBaixaReceber.btnDescontoGeralClick]');

          Exit;
        End;
      End;
      blnConfirma := frmBaixaDescGeral.blnConfirma;
      dicBaixa.AddOrSetValue('strDescGer'  , FloatToStr(frmBaixaDescGeral.fltValDes));
      dicBaixa.AddOrSetValue('strValBaiTot', FloatToStr(frmBaixaDescGeral.fltValBaiTot));
      dicBaixa.AddOrSetValue('blnConfirma' , blnConfirma);
    Finally
      pFreeAndNil(frmBaixaDescGeral);
    End;

    If blnConfirma Then
      TfrmGravando.fExecutarModal(pAplicaDescontoGeral,'Aguarde... Aplicando desconto.','')
    Else
      pSetFocus(dbgDuplicatas);
  Finally
    ConfiguraDatasetCtaRec(True);
  End;
end;

procedure TfrmBaixaReceber.btnDesmarcarTodasClick(Sender: TObject);
begin
  If FBaixaIniciada Then
    Exit;

  inherited;
  If cdsCtaRec.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;


  If StrToIntDef(edtQtdSelecionadas.Text,0) <= 0 Then
  Begin
    fMensagem('','É necessário selecionar ao menos uma duplicata para desmarcar!',['&O K']);
    Exit;
  End;

  FListaMarcarTodas.Clear;

  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fDesmarcarDuplics;
  frmGravando.lblGravando.Caption := 'Aguarde... Desmarcando Títulos.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);

  If Pos('F8_', strMarcacaoLog) <= 0 Then
    strMarcacaoLog := strMarcacaoLog + 'F8_';

  objLock.DestravarListaDuplicatas(FListaMarcarTodas);
  edtMedPond.Text := fRetornaMediaPonderadaNova(cdsCtaRec.FieldByName('CTR_CODCLI').AsString, cdsCtaRec, False);
end;

procedure TfrmBaixaReceber.btnVisualizaDocumentoCompletoClick(Sender: TObject);
var
  SCodigoClienteSelecionado : string;
  strNumDoc: String;
begin
  inherited;

  If (cdsCtaRec.IsEmpty) Then
  Begin
    pMensagemOk('É necessário selecionar ao menos uma duplicata para realizar a consulta!');
    Exit;
  End;

  strNumDoc := cdsCtaRec.FieldByName('CTR_NUMDUP').AsString;

  if not fGetClienteSelecionado(SCodigoClienteSelecionado) then
    Exit;

  cdsCtaRec.Locate('CTR_NUMDUP', strNumDoc, []);

  TfrmRelFatVendasCliente.pMostraDocumentosVendas(LeftStr(cdsCtaRec.FieldByName('CTR_NUMDUP').AsString, 12),
                                                  cdsCtaRec.FieldByName('CTR_ESPDOC').AsString,
                                                  cdsCtaRec.FieldByName('CTR_CODEMP').AsString,
                                                  procVisualizaDocumentoReimpressao);
end;

function TfrmBaixaReceber.fVerificaDireitoBaixa: Boolean;
Begin
  If Not (Pos(LeftStr(fField('CTR_CODEMP').AsString,3), strAceCtr) > 0) Then
    Result:= False
  Else
    Result:= True;
End;

function TfrmBaixaReceber.fVerificaDocumentoAutorizadoSefaz: Boolean;
begin
  Result := True;
  If fCfgSis('PRSATS', VarBoolean) Then
  Begin
    If (Pos(fField('CTR_ESPDOC').AsString, 'NF_EL_') > 0) And fCfgSis('NFEUSA', VarBoolean) Then
    Begin
      If fEmptyStr(fGetChaveAcessoDocumento) And (Not fLiberarDocumentoSemAutorizacaoSefaz) Then
        Result := False;
    End
    Else If (Pos(fField('CTR_ESPDOC').AsString, 'IF_') > 0) Then
    Begin
      If (fCfgSis('USNFCE', VarBoolean) Or fUsaSat) Then
      Begin
        If fEmptyStr(fGetChaveAcessoDocumento) And (Not fLiberarDocumentoSemAutorizacaoSefaz) Then
          Result := False;
      End
      Else If fEmptyStr(fGetNumeroCooDocumento) And (Not fLiberarDocumentoSemAutorizacaoSefaz) Then
        Result := False;
    End;
  End;
end;

function TfrmBaixaReceber.fExisteCancelamentoPendentePorChaveAcesso: Boolean;
begin
  Result := False;
  If (Pos(fField('CTR_ESPDOC').AsString, 'NF_EL_NV_IF_IV_') > 0) And (FLogCancelamento.fExisteCancelamentoPendentePorChaveAcesso(fGetChaveAcessoDocumento)) Then
  Begin
    Result := True;
    pMensagemOK('Documento Fiscal se encontra em processo de cancelamento (LOGCAN)!')
  End;
end;

procedure TfrmBaixaReceber.btnImprimirReciboClick(Sender: TObject);
  Var
    strNomeFila: String;
    strTipImp  : String;
    strSenha   : String;
    cdsGenRec  : TUniClientDataSet;
    LfrmRelRcxReciboCob : TfrmRelRcxReciboCob;
    prcScroll  : TPrcScroll;
    intRecNo   : Integer;
    stlClientes: TStringList;
    intCont    : Integer;
    blnPersonalizavel : Boolean;
    qryGenCli: TUniQuery;
    FPais      : TPais;
    procedure pCarregarCliente(strCodCli : String);
      var
        strSQL : String;
    begin
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADCLI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';

      qryGenCli.Close;
      qryGenCli.SQL.Clear;
      qryGenCli.SQL.Add(strSQL);
      qryGenCli.ParamByName('CODCLI').AsString := strCodCli;
      qryGenCli.Open;
    End;

Begin
  blnPersonalizavel := True;
  FPais := fSetaPais;
  If StrToIntDef(edtQtdSelecionadas.Text,0) <= 0 Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  If (ffrmSenha(strSenha, 'Imprimir Recibo')) Then
  Begin
    If (strSenha = fCfgSis('SENREC')) Then
    Begin
      cdsGenRec := TUniClientDataSet.Create(Nil);

      With cdsGenRec, FieldDefs Do
      Begin
        With AddFieldDef Do Begin Name := 'CODCLI'; DataType := ftString; Size := 008; End;
        With AddFieldDef Do Begin Name := 'NUMDUP'; DataType := ftString; Size := 020; End;
        With AddFieldDef Do Begin Name := 'CODEMP'; DataType := ftString; Size := 003; End;
        With AddFieldDef Do Begin Name := 'DTAEMI'; DataType := ftDate; End;
        With AddFieldDef Do Begin Name := 'DTAVEN'; DataType := ftDate; End;
        With AddFieldDef Do Begin Name := 'VALORI'; DataType := ftFloat;   End; //12,2
        With AddFieldDef Do Begin Name := 'VALJUR'; DataType := ftFloat;   End; //12,2
        With AddFieldDef Do Begin Name := 'DESCON'; DataType := ftFloat;   End; //12,2
        With AddFieldDef Do Begin Name := 'VALTOT'; DataType := ftFloat;   End; //12,2

        cdsGenRec.FieldDefs.Add('NOMCLI',ftString,200);
        cdsGenRec.FieldDefs.Add('ENDCLI',ftString,100);
        cdsGenRec.FieldDefs.Add('CIDCLI',ftString,100);
        cdsGenRec.FieldDefs.Add('CGCCLI',ftString,15);
        cdsGenRec.FieldDefs.Add('FONCLI',ftString,20);
        cdsGenRec.FieldDefs.Add('BAICLI',ftString,100);
        cdsGenRec.FieldDefs.Add('CEPCLI',ftString,15);
        cdsGenRec.FieldDefs.Add('IRGCLI',ftString,20);
        cdsGenRec.FieldDefs.Add('FONCLI2',ftString,20);

        CreateDataSet;
        Open;
      End;

      With cdsCtaRec Do
      Begin
        intRecNo := RecNo;
        pDisableControls(cdsCtaRec, prcScroll);
        First;
        qryGenCli := fCriaQuery(Nil);
        While Not Eof Do
        Begin

          If FieldByName('CTR_MARDES').AsString = 'M' Then
          Begin
            pCarregarCliente(FieldByName('CTR_CODCLI').AsString);
            cdsGenRec.Insert;
            cdsGenRec.FieldByName('CODCLI').AsString   := FieldByName('CTR_CODCLI').AsString;
            cdsGenRec.FieldByName('NUMDUP').AsString   := FieldByName('CTR_NUMDUP').AsString + ' - ' +
                                                          FieldByName('CTR_PARCEL').AsString;
            cdsGenRec.FieldByName('CODEMP').AsString   := FieldByName('CTR_CODEMP').AsString;
            cdsGenRec.FieldByName('DTAEMI').AsDateTime := FieldByName('CTR_DTACAD').AsDateTime;
            cdsGenRec.FieldByName('DTAVEN').AsDateTime := FieldByName('CTR_DTAVEN').AsDateTime;
            cdsGenRec.FieldByName('VALORI').AsFloat    := FieldByName('CTR_VALORI').AsFloat;
            cdsGenRec.FieldByName('VALJUR').AsFloat    := FieldByName('CTR_VALJUR').AsFloat;
            cdsGenRec.FieldByName('DESCON').AsFloat    := FieldByName('CTR_VALDES').AsFloat;
            cdsGenRec.FieldByName('VALTOT').AsFloat    := FieldByName('CTR_VALREC').AsFloat;


            cdsGenRec.FieldByName('NOMCLI').AsString   := qryGenCli.FieldByName('CLI_NOMCLI').AsString;
            cdsGenRec.FieldByName('ENDCLI').AsString   := qryGenCli.FieldByName('CLI_ENDERE').AsString + IIF(Not fEmptyStr(qryGenCli.FieldByName('CLI_ENDNUM').AsString), ', ' +
                                                          qryGenCli.FieldByName('CLI_ENDNUM').AsString, '');

            cdsGenRec.FieldByName('CIDCLI').AsString   := fRetNomCidade(qryGenCli.FieldByName('CLI_CODCID').AsString);
            cdsGenRec.FieldByName('CGCCLI').AsString   := FormatMaskText(IIF(qryGenCli.FieldByName('CLI_CGCCPF').AsString = '1', fRetMascaraC_G_C_(FPais, C_G_C_), fRetMascaraC_G_C_(FPais, C_P_F_)),
                                                                             qryGenCli.FieldByName('CLI_C_G_C_').AsString);
            cdsGenRec.FieldByName('FONCLI').AsString   := fFormataFone(qryGenCli.FieldByName('CLI_FONE01').AsString);
            cdsGenRec.FieldByName('BAICLI').AsString   := qryGenCli.FieldByName('CLI_BAIRRO').AsString;
            cdsGenRec.FieldByName('CEPCLI').AsString   := FormatMaskText('99999-999;0;_', qryGenCli.FieldByName('CLI_C_E_P_').AsString);
            cdsGenRec.FieldByName('IRGCLI').AsString   := qryGenCli.FieldByName('CLI_I_E_S_').AsString;
            cdsGenRec.FieldByName('FONCLI2').AsString  := fFormataFone(qryGenCli.FieldByName('CLI_FONE02').AsString);

            cdsGenRec.Post;
          End;

          Next;
        End;

        RecNo := intRecNo;
        pEnableControls(cdsCtaRec, prcScroll);
      End;

      With cdsGenRec Do
      Begin
        If Not IsEmpty Then
        Begin
          Try
            FCloneDatasetMarcados.IndexFieldNames := 'CTR_CODCLI';
            stlClientes := fCriaListaClientes;
            pCriarFormularios(TfrmRelRcxReciboCob,LfrmRelRcxReciboCob);

            For intCont := 0 To stlClientes.Count -1 Do
            Begin
              If Not LfrmRelRcxReciboCob.fImprimirReciboCobranca(cdsGenRec,stlClientes[intCont]) Then
              Begin
                blnPersonalizavel := False;
                Break;
              End
            End;

            If Not blnPersonalizavel Then
            Begin
              pCarregaConfImpr(qryCfgRel, 'frmBaixaReceber');
              fPreImpressao(qryCfgRel, strNomeFila,strTipImp,False);

              LfrmRelRcxReciboCob.frxDBReciboCobranca.DataSet := cdsGenRec;
              LfrmRelRcxReciboCob.frxReciboCobranca.DotMatrixReport             := False;
              LfrmRelRcxReciboCob.frxReciboCobranca.PrintOptions.PrintMode      := pmScale;
              LfrmRelRcxReciboCob.frxReciboCobranca.PrintOptions.PrintOnSheet   := 9;
              LfrmRelRcxReciboCob.frxReciboCobranca.PrintOptions.ShowDialog := True;

              If VerImpressoraONLINE(strNomeFila) <> 0 Then
                fMensagem('ATENÇÃO!', 'Impressora "' + strNomeFila + '" está OFFLINE! Selecione outra!', ['&OK'])
              Else If Not strNomeFila.IsEmpty Then
              Begin
                LfrmRelRcxReciboCob.frxReciboCobranca.PrintOptions.ShowDialog := False;
                LfrmRelRcxReciboCob.frxReciboCobranca.PrintOptions.Printer := AnsiReplaceText(strNomeFila, '\\' + fRetNomeRede + '\', '');
              End;

              If LfrmRelRcxReciboCob.frxReciboCobranca.PrepareReport Then
              Begin
                If (fEmptyStr(strNomeFila)) Then
                  pPreviewReport('TfrmBaixaReceber.btnImprimirReciboClick',
                                 'Recibo de cobrança',
                                 LfrmRelRcxReciboCob.frxReciboCobranca)
                Else
                  pPrintReport('TfrmBaixaReceber.btnImprimirReciboClick',
                               'Recibo de cobrança',
                               strNomeFila,
                               LfrmRelRcxReciboCob.frxReciboCobranca);
              End;
            End;

          Except
            On E: Exception Do
            Begin
              pMensagensErro(E.Message, '[TfrmBaixaReceber.btnImprimirRecibo]');
            End;
          End;

          FreeAndNil(LfrmRelRcxReciboCob);
        End;

        cdsGenRec.Close;
        FreeAndNil(cdsGenRec);
        FreeAndNil(qryGenCli);

        FCloneDatasetMarcados.IndexFieldNames := 'AUTOINCREM';
      End;

    End
    Else
      fMensagem('', 'Senha Incorreta!', ['&OK']);
  End;
end;

procedure TfrmBaixaReceber.btnInformacaoCobrancaClick(Sender: TObject);
  Var
    SCodigoClienteSelecionado : string;
    frmInfCobranca : TfrmInfCobranca;
begin
  if not fGetClienteSelecionado(SCodigoClienteSelecionado) then
    Exit;

  Try
    pCriarFormularios(TfrmInfCobranca, frmInfCobranca);
    frmInfCobranca.edtCodCli.Text := SCodigoClienteSelecionado;
    frmInfCobranca.edtNomCli.Text := fRetNomCliente(SCodigoClienteSelecionado);
    frmInfCobranca.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmBaixaReceber.btnInformacaoCobrancaClick]');
  End;

  pFreeAndNil(frmInfCobranca);
end;

procedure TfrmBaixaReceber.btnIniBusClick(Sender: TObject);
begin
  If FBaixaIniciada Then
    Exit;

  inherited;
  If cdsCtaRec.IsEmpty Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;
  Try
    pCriarFormularios(TfrmBaixaBusca, frmBaixaBusca);
    frmBaixaBusca.ShowModal;
    TfrmGravando.fExecutarModal(pBuscarIni,'Aguarde... Localizando Título.','');
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  pSetFocus(dbgDuplicatas);
  pFreeAndNil(frmBaixaBusca);
end;

procedure TfrmBaixaReceber.btnLimparDadosRemessaClick(Sender: TObject);
begin
  inherited;

  If Not pnlEnvBan.Visible Then
    Exit;

  If Not btnLimparDadosRemessa.Enabled Then
    Exit;

  If cdsCtaRec.IsEmpty Then
  begin
    fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  end;

  If cdsCtaRec.FieldByName('CTR_DTAENV').IsNull Then
    Exit;

  If fMensagem('', 'Deseja limpar as informações ' +
                   'de remessa bancária da duplicata ' +
                   cdsCtaRec.FieldByName('CTR_NUMDUP').AsString +' ?', ['&Não', '&Sim']) = 2 Then
  Begin
    If RestaurarRemessaBancaria(cdsCtaRec.FieldByName('AUTOINCREM').AsString) Then
    Begin
      cdsCtaRec.Edit;
      cdsCtaRec.FieldByName('CTR_DTAENV').Value := Null;
      cdsCtaRec.FieldByName('CTR_BCOENV').Value := Null;
      cdsCtaRec.FieldByName('CTR_NOMBCO').Value := Null;
      cdsCtaRec.Post;
    End;
  End;

  pAtualizaDados(cdsCtaRec);
end;

procedure TfrmBaixaReceber.btnLocProxClick(Sender: TObject);
begin
  If FBaixaIniciada Then
    Exit;

  inherited;
  If cdsCtaRec.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  TfrmGravando.fExecutarModal(pBuscarProx,'Aguarde... Localizando Título.','');
  pSetFocus(dbgDuplicatas);
end;

procedure TfrmBaixaReceber.btnManutencaoClick(Sender: TObject);
begin
  If FBaixaIniciada Then
    Exit;

  inherited;
  If cdsCtaRec.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  If fVerificaAcessoSistema('frmCadCtaReceber') Then
    pChamarManutencaoCtr
  Else
    pMensagemOk('Operador sem direito de acesso!');

end;

procedure TfrmBaixaReceber.btnMarcarTodasClick(Sender: TObject);
    Var
    intOpcao  : Integer;
    frmBaixaCtrDigDtaPag : TfrmBaixaCtrDigDtaPag;
    lLiberacao: TLiberacao;
Begin
  If FBaixaIniciada Then
    Exit;

  inherited;
  If cdsCtaRec.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  FNaoMarcarCreditos := False;
  If FValidarCreditosDeMesmoClienteOuRedeLojas Then
  Begin
    If TemClientesOuRedeLojasDiferentes Then
    Begin
      If fMensagem('ATENÇÃO!', 'Só é permitido selecionar duplicatas de crédito '+
                               'com duplicatas do mesmo cliente ou mesma rede de lojas.'+#13#13+
                               'Deseja continuar sem marcar os créditos?', ['&Sim', '&Não']) = 1 Then
        FNaoMarcarCreditos := True
      Else
        Exit;
    End;
  End;

  If StrToIntDef(edtQtdSelecionadas.Text,0) > 0 Then
    btnDesmarcarTodas.Click;

  FListaMarcarTodas.Clear;

  FLiberadoUtilizacaoCredito := False;

  Try
    ConfiguraDatasetCtaRec(False);

    Try
      intOpcao := fGetMenu('Selecione a opção', ['Todas as duplicatas', 'Informar o valor selecionado', 'Cancelar'], 1);

      pCriarFormularios(TfrmBaixaCtrDigDtaPag, frmBaixaCtrDigDtaPag);

     If Not Assigned(frmBaixaCtrDigDtaPag.cdsDupSel) Then
        frmBaixaCtrDigDtaPag.cdsDupSel := TUniClientDataSet.Create(Nil);

      frmBaixaCtrDigDtaPag.cdsDupSel.Data := FCloneDataSetMarcados.Data;
      frmBaixaCtrDigDtaPag.cdsDupSel.Filtered := False;

      blnMarcandoTodas := True;

      If intOpcao = 2 Then
      Begin

        pCriarFormularios(TfrmDigValor, frmDigValor);
        frmDigValor.ShowModal;
        If frmDigValor.ModalResult = mrOk  Then
        Begin
          dicBaixa.AddOrSetValue('blnConfirma', True);

          frmBaixaCtrDigDtaPag.cdsCadRec_VerificaData := cdsCtaRec;
          frmBaixaCtrDigDtaPag.cdsCadRec_VerificaData.First;

          if (strCodPorFix <> '') and (fltValorBaixa <> 0) then
          begin
            frmBaixaCtrDigDtaPag.mskDtaPag.Text    := DateToStr(dteDtaRecFix);
            frmBaixaCtrDigDtaPag.mskDtaPag.Enabled := False;
            pSetFocus(frmBaixaCtrDigDtaPag.btnConfirmaDados);
          end;

          frmBaixaCtrDigDtaPag.ShowModal;

          dicBaixa.AddOrSetValue('fltValInf',frmDigValor.edtValor.Text);
          dicBaixa.AddOrSetValue('dtaDtaPag', frmBaixaCtrDigDtaPag.dtaDtaPag);

          //FECHAMENTO FINANCEIRO
          if objFechamento.FechamentoFinanceiroJaRealizado(VS_strCodEmp, frmBaixaCtrDigDtaPag.dtaDtaPag) then
          begin
            FreeAndNil(frmDigValor);
            FreeAndNil(frmBaixaCtrDigDtaPag);
            Exit;
          end;

          If frmBaixaCtrDigDtaPag.dtaDtaPag > 0 Then
          Begin
            pCriarFormularios(TfrmGravando,frmGravando);
            frmGravando.fExecutarAcao := fMarcarDuplicsValorInformado;
            frmGravando.lblGravando.Caption := 'Aguarde... Marcando Títulos.';
            frmGravando.ShowModal;
            pFreeAndNil(frmGravando);

            If Pos('F7VS_', strMarcacaoLog) <= 0 Then
              strMarcacaoLog := strMarcacaoLog + 'F7VS_';
          End;
        End;

      End;

      If intOpcao = 1 Then
      Begin
        frmBaixaCtrDigDtaPag.cdsCadRec_VerificaData := cdsCtaRec;
        frmBaixaCtrDigDtaPag.cdsCadRec_VerificaData.First;
        if (strCodPorFix <> '') and (fltValorBaixa <> 0) then
        begin
          frmBaixaCtrDigDtaPag.mskDtaPag.Text    := DateToStr(dteDtaRecFix);
          frmBaixaCtrDigDtaPag.mskDtaPag.Enabled := False;
          pSetFocus(frmBaixaCtrDigDtaPag.btnConfirmaDados);
        end;

        frmBaixaCtrDigDtaPag.ShowModal;

        If frmBaixaCtrDigDtaPag.dtaDtaPag = 0 Then
        Begin
          FreeAndNil(frmDigValor);
          FreeAndNil(frmBaixaCtrDigDtaPag);
          Exit;
        End;

        dicBaixa.AddOrSetValue('dtaDtaPag', frmBaixaCtrDigDtaPag.dtaDtaPag);

        //FECHAMENTO FINANCEIRO
        if objFechamento.FechamentoFinanceiroJaRealizado(VS_strCodEmp, frmBaixaCtrDigDtaPag.dtaDtaPag) then
        begin
          FreeAndNil(frmDigValor);
          FreeAndNil(frmBaixaCtrDigDtaPag);
          Exit;
        end;

        If frmBaixaCtrDigDtaPag.dtaDtaPag > 0 Then
        Begin
          pCriarFormularios(TfrmGravando,frmGravando);
          frmGravando.fExecutarAcao := fMarcaDuplics;
          frmGravando.lblGravando.Caption := 'Aguarde... Marcando Títulos.';
          frmGravando.ShowModal;
          pFreeAndNil(frmGravando);

          pCriarFormularios(TfrmGravando,frmGravando);
          frmGravando.fExecutarAcao := LockDuplicatas;
          frmGravando.lblGravando.Caption := 'Aguarde... Verificando Títulos.';
          frmGravando.ShowModal;
          pFreeAndNil(frmGravando);


          If Pos('F7T_', strMarcacaoLog) <= 0 Then
            strMarcacaoLog := strMarcacaoLog + 'F7T_';
        End;
      End;
    Except
      On E: Exception Do
      Begin
       pMensagensErro(E.Message, '');
      End;
    End;


    If frmBaixaCtrDigDtaPag.LibDtaRet then
    Begin
      lLiberacao := frmBaixaCtrDigDtaPag.Liberacao;

      If Not objLogLibRec.pExisteTabela Then
        objLogLibRec.CriaTabelaTemporaria();

      pAddLogDtaRet(lLiberacao);
    End;

    blnMarcouTodas := True;
    blnMarcandoTodas := False;
    pCalculaTotalDuplicatas(edtDescontoTotal, edtJurosTotal, edtTotalRecebido, edtQtdSelecionadas, True, FCloneDatasetMarcados);
    edtMedPond.Text := fRetornaMediaPonderadaNova(cdsCtaRec.FieldByName('CTR_CODCLI').AsString, cdsCtaRec, False);
    FreeAndNil(frmDigValor);
    FreeAndNil(frmBaixaCtrDigDtaPag);

    FListaMarcarTodas.Clear;

    If Not LiberacaoBaixaTotalComDesconto Then
    Begin
      btnDesmarcarTodas.Click;
    End;
  Finally
    ConfiguraDatasetCtaRec(True);
  End;
end;

procedure TfrmBaixaReceber.btnMedPondClick(Sender: TObject);
begin
  if not cdsCtaRec.Active then
    exit;
  edtMedPond.Text := fRetornaMediaPonderadaNova(cdsCtaRec.FieldByName('CTR_CODCLI').AsString, cdsCtaRec, not blnDiaUtil);

  blnDiautil := not blnDiautil;

  btnMedPondMouseEnter(btnMedPond);

end;

procedure TfrmBaixaReceber.btnMedPondMouseEnter(Sender: TObject);
Var msg:String;
begin

  if blnDiaUtil then
    msg := 'Recalcular com Dias Corridos'
  else
    msg := 'Recalcular com Dias Úteis';

  HintControler.ShowHint(Self.Left + btnMedPond.Left + btnMedPond.Width,
                         Self.Top  + btnMedPond.Top  + btnMedPond.Height + btnMedPond.Parent.Top, 'Média Ponderada', msg);
end;

procedure TfrmBaixaReceber.btnMedPondMouseLeave(Sender: TObject);
begin
  HintControler.HideHint;
end;

procedure TfrmBaixaReceber.btnProdutosClick(Sender: TObject);
var
  frmRelFatVendasClienteF9: TfrmRelFatVendasClienteF9;
  SCodigoClienteSelecionado,
  strNumDoc: String;
Begin
  inherited;
  If cdsCtaRec.IsEmpty Then
  begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  end;

  strNumDoc := cdsCtaRec.FieldByName('CTR_NUMDUP').AsString;

  if not fGetClienteSelecionado(SCodigoClienteSelecionado) then
    Exit;

  cdsCtaRec.Locate('CTR_NUMDUP', strNumDoc, []);


  If Not cdsCtaRec.IsEmpty Then
  Begin
    If (cdsCtaRec.FieldByName('CTR_ESPDOC').AsString = 'AG') AND (Not(btnDuplicataAgrupada.Visible)) Then
    Begin
      pMostraDuplicatasAgrupadas(LeftStr(cdsCtaRec.FieldByName('CTR_NUMDUP').AsString, fTamDocCadRec),
                                 LeftStr(cdsCtaRec.FieldByName('CTR_CODEMP').AsString, 3),
                                 cdsCtaRec.FieldByName('CTR_CODCLI').AsString,
                                 False,
                                 False);
    End
    Else
    Begin
      Try
        pCriarFormularios(TfrmRelFatVendasClienteF9, frmRelFatVendasClienteF9);
        frmRelFatVendasClienteF9.dtsRelVenCli.DataSet := frmModuloSPR.qryRelatorio;
        frmRelFatVendasClienteF9.blnMosVenMtl := fCfgSis('VENMTL', varBoolean);
        frmRelFatVendasClienteF9.blnMosPromoc := False;

        With frmRelFatVendasClienteF9 Do
        Begin
          pMostrarProdutos(
            LeftStr(cdsCtaRec.FieldByName('CTR_NUMDUP').AsString, fTamDocCadRec),
            cdsCtaRec.FieldByName('CTR_ESPDOC').AsString,
            LeftStr(cdsCtaRec.FieldByName('CTR_CODEMP').AsString, 3),
            False,
            cdsCtaRec.FieldByName('CTR_CODCLI').AsString);

            If cdsRel.IsEmpty Then
            Begin
              pMensagemOk('Não há dados para gerar a consulta!');
              pFreeAndNil(frmRelFatVendasClienteF9);
              Exit;
            End
            Else
              ShowModal;
        End;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[btnProdutosClick]');
        End;
      End;

      pFreeAndNil(frmRelFatVendasClienteF9);
    End;
  End;
end;

procedure TfrmBaixaReceber.btnRecalculaJurosClick(Sender: TObject);
  Var
    frmCtrRecalculoJuros : TfrmCtrRecalculoJuros;
begin
  If FBaixaIniciada Then
    Exit;

  inherited;
  If cdsCtaRec.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  Application.ProcessMessages;
  Screen.Cursor := crHourGlass;

  Try
    pCriarFormularios(TfrmCtrRecalculoJuros, frmCtrRecalculoJuros);
    frmCtrRecalculoJuros.blnPerMulta := True;
    frmCtrRecalculoJuros.ShowModal;
    blnRecalJur := True;
    dicBaixa.AddOrSetValue('fltPerJur', frmCtrRecalculoJuros.edtPerJur.Text);
    dicBaixa.AddOrSetValue('strAplJur', frmCtrRecalculoJuros.edtAplJur.Text);
    dicBaixa.AddOrSetValue('fltPerMul', frmCtrRecalculoJuros.edtPerMul.Text);
    dicBaixa.AddOrSetValue('blnConfirma', frmCtrRecalculoJuros.blnConfirma);

    pFreeAndNil(frmCtrRecalculoJuros);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;

  TfrmGravando.fExecutarModal(pRecalculaJuros,'Aguarde... Recalculando Juros.','');
end;

procedure TfrmBaixaReceber.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmBaixaReceber.BtnSelecionadasClick(Sender: TObject);
begin
  If FBaixaIniciada Then
    Exit;

  inherited;
  If cdsCtaRec.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;
  TfrmGravando.fExecutarModal(pMostraDuplicatasSelecionadas,'Aguarde... Carregandos Títulos.','');
end;

procedure TfrmBaixaReceber.cdsCtaRecCLI_C_G_C_GetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if cdsCtaRec.FieldByName('CLI_CGCCPF').AsInteger = 1 Then
    Text := FormatFloat( '0#"."###"."###"/"####"-"##', StrToFloatDef(Sender.AsString, 0) )
  else
    Text := FormatFloat( '0##"."###"."###"-"##', StrToFloatDef(Sender.AsString, 0) )
end;

procedure TfrmBaixaReceber.chkFiltrarFiliaisExit(Sender: TObject);
begin
  inherited;
  pHabilitaFiltroFiliais;
end;

procedure TfrmBaixaReceber.ConfiguraDatasetCtaRec(AHabilitarFuncoes: Boolean);
begin
  FAtualizarGrid := False;

  If Not AHabilitarFuncoes Then
  Begin
    cdsCtaRec.AfterScroll := Nil;
    cdsCtaRec.DisableControls;
    strCamFil := EmptyStr;
    cdsCtaRec.AggregatesActive := False;
  End
  Else
  Begin
    FAtualizarGrid := True;

    cdsCtaRec.AfterScroll := pAtualizaDados;
    cdsCtaRec.EnableControls;
    dtsCtaRec.DataSet := cdsCtaRec;
  End;
end;

procedure TfrmBaixaReceber.CriarClientCreditoGerado(ASequencialControle,
  ACodigoEmpresa: String);
  Var
    LSQL: String;

    LConsulta: TUniQuery;

    LNomeCliente: String;
begin
  LConsulta := fCriaQuery(Nil);

  LSQL := '';
  LSQL := LSQL + '   SELECT                                   ';
  LSQL := LSQL + '   CTR_OPEBAI,                              ';
  LSQL := LSQL + '   CTR_PORBAI,                              ';
  LSQL := LSQL + '   CTR_HISBAI,                              ';
  LSQL := LSQL + '   CTR_CODCLI,                              ';
  LSQL := LSQL + '   CTR_NUMDUP,                              ';
  LSQL := LSQL + '   CTR_PARCEL,                              ';
  LSQL := LSQL + '   CTR_ESPDOC,                              ';
  LSQL := LSQL + '   CTR_CODEMP,                              ';
  LSQL := LSQL + '   CTR_DTACAD,                              ';
  LSQL := LSQL + '   CTR_DTAVEN,                              ';
  LSQL := LSQL + '   CTR_SEQBAI,                              ';
  LSQL := LSQL + '   CTR_SEQCON,                              ';
  LSQL := LSQL + '   CTR_NOSNUM,                              ';
  LSQL := LSQL + '   CTR_VALORI AS CTR_VALDUP,                ';
  LSQL := LSQL + '   CTR_JURSUJ,                              ';
  LSQL := LSQL + '   CTR_DESCOB,                              ';
  LSQL := LSQL + '   CTR_DESSUJ,                              ';
  LSQL := LSQL + '   CTR_VALORI,                              ';
  LSQL := LSQL + '   CTR_VALJUR,                              ';
  LSQL := LSQL + '   CTR_VALCOB,                              ';
  LSQL := LSQL + '   CTR_VALDES,                              ';
  LSQL := LSQL + '   CTR_VALREC,                              ';
  LSQL := LSQL + '   CTR_CODCTA,                              ';
  LSQL := LSQL + '   CLI_CODCLI,                              ';
  LSQL := LSQL + '   CLI_NOMCLI,                              ';
  LSQL := LSQL + '   CLI_FANSOB,                              ';
  LSQL := LSQL + '   CLI_ENDERE,                              ';
  LSQL := LSQL + '   CLI_ENDNUM,                              ';
  LSQL := LSQL + '   CLI_ENDCOM,                              ';
  LSQL := LSQL + '   CLI_BAIRRO,                              ';
  LSQL := LSQL + '   CLI_C_E_P_,                              ';
  LSQL := LSQL + '   CLI_CODCID,                              ';
  LSQL := LSQL + '   CLI_C_G_C_,                              ';
  LSQL := LSQL + '   CLI_FONE01,                              ';
  LSQL := LSQL + '   CTR_VALANT,                              ';
  LSQL := LSQL + '   CTR_HIST01,                              ';
  LSQL := LSQL + '   CTR_HIST02                               ';
  LSQL := LSQL + ' FROM                                       ';
  LSQL := LSQL + '   LOGCTR                                   ';
  LSQL := LSQL + '   INNER JOIN CADCLI                        ';
  LSQL := LSQL + '     ON CLI_CODCLI = CTR_CODCLI             ';
  LSQL := LSQL + ' WHERE CTR_SEQCON = ' + ASequencialControle ;
  LSQL := LSQL + '   AND CTR_CODEMP = "' + ACodigoEmpresa + '" ';
  LSQL := LSQL + '   AND CTR_ESPDOC = "CC"  AND CTR_DESCRI LIKE "INCLUSÃO%"';

  Try
    LConsulta.Close;
    LConsulta.SQL.Text := LSQL;
    LConsulta.Open;

    LConsulta.First;
    While Not LConsulta.Eof Do
    Begin
      FRelCtrCredito.Insert;
      FRelCtrCredito.FieldByName('HIST01').AsString   := LConsulta.FieldByName('CTR_HIST01').AsString;
      FRelCtrCredito.FieldByName('HIST02').AsString   := LConsulta.FieldByName('CTR_HIST02').AsString;
      FRelCtrCredito.FieldByName('CODCLI').AsString   := LConsulta.FieldByName('CTR_CODCLI').AsString;
      FRelCtrCredito.FieldByName('DESCRI').AsString   := LConsulta.FieldByName('CTR_CODCLI').AsString + '-' + LConsulta.FieldByName('CLI_NOMCLI').AsString;
      FRelCtrCredito.FieldByName('NUMDOC').AsString   := LConsulta.FieldByName('CTR_NUMDUP').AsString;
      FRelCtrCredito.FieldByName('PARCEL').AsString   := LConsulta.FieldByName('CTR_PARCEL').AsString;
      FRelCtrCredito.FieldByName('ESPDOC').AsString   := LConsulta.FieldByName('CTR_ESPDOC').AsString;
      FRelCtrCredito.FieldByName('CODEMP').AsString   := LConsulta.FieldByName('CTR_CODEMP').AsString;
      FRelCtrCredito.FieldByName('DTACAD').AsDateTime := LConsulta.FieldByName('CTR_DTACAD').AsDateTime;
      FRelCtrCredito.FieldByName('DTAVEN').AsDateTime := LConsulta.FieldByName('CTR_DTAVEN').AsDateTime;
      FRelCtrCredito.FieldByName('DTAREC').AsDateTime := VS_Date;
      FRelCtrCredito.FieldByName('HORREC').AsDateTime := fTime();
      FRelCtrCredito.FieldByName('CODVEN').AsString   := fBuscaVendedorDup(LConsulta.FieldByName('CTR_NUMDUP').AsString,
                                                                           LConsulta.FieldByName('CTR_PARCEL').AsString,
                                                                           LConsulta.FieldByName('CTR_ESPDOC').AsString,
                                                                           LConsulta.FieldByName('CTR_CODCLI').AsString,
                                                                           LConsulta.FieldByName('CTR_CODEMP').AsString);
      FRelCtrCredito.FieldByName('SEQBAI').AsInteger := LConsulta.FieldByName('CTR_SEQBAI').AsInteger;
      FRelCtrCredito.FieldByName('SEQCON').AsInteger := LConsulta.FieldByName('CTR_SEQCON').AsInteger;

      if fEmptyStr(LConsulta.FieldByName('CTR_NOSNUM').AsString) then
        FRelCtrCredito.FieldByName('NOSNUM').AsString  := fTrazNosNumDupZero(LConsulta.FieldByName('CTR_NUMDUP').AsString,
                                                                             LConsulta.FieldByName('CTR_PARCEL').AsString,
                                                                             LConsulta.FieldByName('CTR_ESPDOC').AsString,
                                                                             LConsulta.FieldByName('CTR_CODCLI').AsString,
                                                                             LConsulta.FieldByName('CTR_CODEMP').AsString)
      else
        FRelCtrCredito.FieldByName('NOSNUM').AsString  := LConsulta.FieldByName('CTR_NOSNUM').AsString;

      FRelCtrCredito.FieldByName('VALDOC').AsFloat   := LConsulta.FieldByName('CTR_VALDUP').AsFloat -
                                                        LConsulta.FieldByName('CTR_JURSUJ').AsFloat -
                                                        LConsulta.FieldByName('CTR_DESCOB').AsFloat +
                                                        LConsulta.FieldByName('CTR_DESSUJ').AsFloat;

      FRelCtrCredito.FieldByName('VALORI').AsFloat  := LConsulta.FieldByName('CTR_VALORI').AsFloat;

      If (LConsulta.FieldByName('CTR_VALJUR').AsFloat - LConsulta.FieldByName('CTR_VALDES').AsFloat = 0) Then
        FRelCtrCredito.FieldByName('VALJUR').AsFloat  := 0
      else
        FRelCtrCredito.FieldByName('VALJUR').AsFloat  := LConsulta.FieldByName('CTR_VALJUR').AsFloat;


      FRelCtrCredito.FieldByName('VALCOB').AsFloat  := LConsulta.FieldByName('CTR_VALCOB').AsFloat;
      FRelCtrCredito.FieldByName('VALDES').AsFloat  := LConsulta.FieldByName('CTR_VALDES').AsFloat;
      FRelCtrCredito.FieldByName('DESCOB').AsFloat  := LConsulta.FieldByName('CTR_DESCOB').AsFloat;
      FRelCtrCredito.FieldByName('VALREC').AsFloat  := LConsulta.FieldByName('CTR_VALREC').AsFloat;

      LNomeCliente := fRetNomCliente(LConsulta.FieldByName('CTR_CODCLI').AsString);
      FRelCtrCredito.FieldByName('CODCLI').AsString := LConsulta.FieldByName('CTR_CODCLI').AsString;
      FRelCtrCredito.FieldByName('NOMCLI').AsString := LNomeCliente;
      FRelCtrCredito.FieldByName('FANSOB').AsString := LConsulta.FieldByName('CLI_FANSOB').AsString;
      FRelCtrCredito.FieldByName('ENDERE').AsString := LConsulta.FieldByName('CLI_ENDERE').AsString;
      FRelCtrCredito.FieldByName('ENDNUM').AsString := LConsulta.FieldByName('CLI_ENDNUM').AsString;
      FRelCtrCredito.FieldByName('ENDCMP').AsString := LConsulta.FieldByName('CLI_ENDCOM').AsString;
      FRelCtrCredito.FieldByName('BAIRRO').AsString := LConsulta.FieldByName('CLI_BAIRRO').AsString;
      FRelCtrCredito.FieldByName('C_E_P_').AsString := LConsulta.FieldByName('CLI_C_E_P_').AsString;
      FRelCtrCredito.FieldByName('CIDADE').AsString := fRetNomCidade(LConsulta.FieldByName('CLI_CODCID').AsString);
      FRelCtrCredito.FieldByName('ESTADO').AsString := fRetUFCliente(LConsulta.FieldByName('CTR_CODCLI').AsString);
      FRelCtrCredito.FieldByName('C_G_C_').AsString := LConsulta.FieldByName('CLI_C_G_C_').AsString;
      FRelCtrCredito.FieldByName('FONE01').AsString := LConsulta.FieldByName('CLI_FONE01').AsString;
      FRelCtrCredito.FieldByName('VALREC').AsFloat := LConsulta.FieldByName('CTR_VALREC').AsFloat;
      FRelCtrCredito.FieldByName('CTR_ABERTO').AsFloat := fRetornaReceberAberto(LConsulta.FieldByName('CTR_CODCLI').AsString);
      FRelCtrCredito.FieldByName('CTR_TOTBLT').AsFloat := fRetornaReceberTotalBoletosEmAberto(LConsulta.FieldByName('CTR_CODCLI').AsString);
      FRelCtrCredito.FieldByName('CTR_TOTCRD').AsFloat := fRetornaReceberTotalCrediarioEmAberto(LConsulta.FieldByName('CTR_CODCLI').AsString);
      FRelCtrCredito.FieldByName('CTR_TOTCHD').AsFloat := fRetornaReceberTotalChequesDevolvidosEmAberto(LConsulta.FieldByName('CTR_CODCLI').AsString);

      If (Pos('CONSUMIDOR', LNomeCliente) > 0) Or
         (Pos('BALCAO', LNomeCliente) > 0)     Or
         (Pos('BALCÃO', LNomeCliente) > 0)     Then
      Begin
        FRelCtrCredito.FieldByName('NOMCLI').AsString := fRetCliConsumidor(LConsulta.FieldByName('CTR_CODCLI').AsString,
                                                                           LConsulta.FieldByName('CTR_NUMDUP').AsString,
                                                                           LConsulta.FieldByName('CTR_ESPDOC').AsString,
                                                                           LConsulta.FieldByName('CTR_CODEMP').AsString);
        FRelCtrCredito.FieldByName('DESCRI').AsString := LConsulta.FieldByName('CTR_CODCLI').AsString + '-' + FRelCtrCredito.FieldByName('NOMCLI').AsString;
      End;
      FRelCtrCredito.FieldByName('NOMCON').AsString := FRelCtrCredito.FieldByName('NOMCLI').AsString;

      FRelCtrCredito.FieldByName('CODCTA').AsString   := LConsulta.FieldByName('CTR_CODCTA').AsString;
      FRelCtrCredito.FieldByName('DESCTA').AsString   := fRetNomeConta(LConsulta.FieldByName('CTR_CODCTA').AsString);

      FRelCtrCredito.Post;

      LConsulta.Next;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[CriarClientCreditoGerado]');
    End;
  End;
end;

procedure TfrmBaixaReceber.dbgDuplicatasDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);

  function fGetValue(strField: String): Variant;
  begin
    Result := Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasDBTableView1.GetColumnByFieldName(strField).Index];
  end;

  Var
    strMarDes: String;
    fltValJur: Double;
begin
  inherited;
  If Not FAtualizarGrid Then
    Exit;

  If (AViewInfo.Item.Caption = 'Vlr. Corrigido') Then
  Begin
    //fltValJur := Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasCTR_VALJUR.Index];
    fltValJur := Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasCTR_VALCAL.Index] -
    Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasCTR_VALSUJ.Index];
    If (fltValJur > 0) Then
      ACanvas.Font.Color := clRed;
  End;

  strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasCTR_MARDES.Index]);
  If (cdsCtaRec.IsEmpty) Or fEmptyStr(strMarDes) Then
    Exit;

  If Not VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasCTR_TX_PIX.Index]).IsEmpty Then
    ACanvas.Font.Color := clGreen;

  If (strMarDes = 'M') Then
  Begin
    If (Not AViewInfo.Selected) Then
      ACanvas.Font.Color := clBlue
    Else
      ACanvas.Font.Color := clLime;
  End

  Else

  If (AViewInfo.Item.Caption = 'Dt. Vencimento') And
    (VarToDateTime(fGetValue('CTR_DTAVEN')) < VS_Date) Then
  Begin
    ACanvas.Font.Color  := clRed;
    ACanvas.Font.Style  := [fsBold];
    ACanvas.FillRect(AViewInfo.Bounds);
  End;

end;

function TfrmBaixaReceber.ExisteDuplicatasSelecionadasNaoExibidasNoGrid: Boolean;
  Var
    LMarcados : Integer;
begin
  Try
    LMarcados := FCloneDatasetMarcados.RecordCount;

    If Not fEmptyStr(dbgDuplicatasDBTableView1.DataController.Filter.FilterText) Then
    Begin
      FCloneDatasetMarcados.Filter   := dbgDuplicatasDBTableView1.DataController.Filter.FilterText;
      FCloneDatasetMarcados.Filtered := True;
    End;

    Result := (LMarcados > FCloneDatasetMarcados.RecordCount);

  Finally
    FCloneDatasetMarcados.Filtered := False;
  End;
end;

procedure TfrmBaixaReceber.dbgDuplicatasDBTableView1DataControllerSummaryAfterSummary(
  ASender: TcxDataSummary);
begin
  inherited;
  pExibeTotais;
end;

procedure TfrmBaixaReceber.pExibeTotais;
var
  LVar: Variant;
begin
  With  dbgDuplicatasDBTableView1 Do
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

procedure TfrmBaixaReceber.dbgDuplicatasDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Try
    Self.Enabled := False;
    If (Key = VK_RETURN) And (Not CdsCtaRec.IsEmpty) Then
    Begin
      if Not fEmpresaTemAcessoPortador(cdsCtaRec.FieldByName('CTR_CODPOR').AsString,VS_strCodEmp) Then
      Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Exit;
      End;

      if TValidacoesPagamentoOnline.fAgrupamentoPossuiLinkPagamento(
          cdsCtaRec.FieldByName('NRODUP').AsString,
          cdsCtaRec.FieldByName('CTR_ESPDOC').AsString,
          cdsCtaRec.FieldByName('CTR_CODEMP').AsString,
          cdsCtaRec.FieldByName('CTR_CODCLI').AsString) then
      begin
        fMensagem('ATENÇÃO!', 'Não será possível baixar esta duplicata pois existe link de pagamento! ', ['&O K']);
        Exit;
      end;

      if cdsCtaRec.FieldByName('CTR_TX_PIX').AsString.IsEmpty Then
        pFrmDigValores;

      TfrmGravando.fExecutarModal(pSelecionaDuplicata,'Aguarde... Atualizando Dados.','');
    End;
  Finally
    Self.Enabled := True;
    If Not cdsCtaRec.IsEmpty Then
      pSetFocus(dbgDuplicatas)
    Else
      pSetFocus(edtCodCli);
  End;

end;

function TfrmBaixaReceber.DeterminaCodigoDoClienteDevedorPix(ADataset: TDataset): String;
begin
  ADataset.First;

  Result := ADataset.FieldByName('CTR_CODCLI').AsString;

  ADataset.Next;
  While Not ADataset.Eof Do
  Begin
    If Result <> ADataset.FieldByName('CTR_CODCLI').AsString Then
    Begin
      Result := '';
      Break;
    End;

    ADataset.Next;
  End;

  ADataset.First;
end;

function TfrmBaixaReceber.DuplicataComPixGeradoEAtivo: Boolean;
  Var
    LDatasetPix: TUniClientDataset;
begin
  If cdsCtaRec.FieldByName('CTR_TX_PIX').AsString.IsEmpty Then
    Exit(False);

  Result := True;

  LDatasetPix := TPixDao.RetornaDadosDoPix(cdsCtaRec.FieldByName('CTR_TX_PIX').AsString,
                                           cdsCtaRec.FieldByName('CTR_EMPPIX').AsString);

  If Not MatchStr(LDatasetPix.FieldByName('MPX_STATUS').AsString, STATUS_PIX_ATIVO) Then
  Begin
    fMensagem('ATENÇÃO', 'Essa duplicata possui Pix gerado mas não está ativo.' + #13#10 +
                         'Recarregue o filtro selecionado.', ['&Ok']);

    FreeAndNil(LDatasetPix);

    Exit;
  End;

  If LDatasetPix.FieldByName('MPX_CODEMP').AsString <> VS_strCodEmp Then
  Begin
    fMensagem('ATENÇÃO', 'Essa duplicata não pode ser marcada pois possui Pix gerado pela empresa ' +
                         LDatasetPix.FieldByName('MPX_CODEMP').AsString + '.' + #13#10 +
                         'Para que possa selecionar as opções dessa duplicata, entre na empresa geradora do Pix.', ['&Ok']);

    FreeAndNil(LDatasetPix);

    Exit;
  End;

  If Not TFuncoesPixAutcom.RealizaValidacoesUsoDoPixNoReceber(strLoginUsuarioLogado,
                                                              '',
                                                              False) Then
  Begin
    fMensagem('ATENÇÃO', 'Essa duplicata não pode ser marcada pois possui um Pix vinculado.' + #13 +
                         'Verifique as configurações e permissões para o uso do Pix.', ['&Ok']);

    Exit;
  End;

  If fMensagem('ATENÇÃO', 'Essa duplicata possui Pix gerado e ativo.' + #13#10 +
                          'Deseja escolher as opções para essa duplicata?', ['&Sim', '&Não']) = 2 Then
  Begin
    FreeAndNil(LDatasetPix);

    Exit;
  End;

  Try
    FPixJaGerado := True;

    pCriarFormularios(TfrmCtrSelecionaOpcaoDuplicataComPix, frmCtrSelecionaOpcaoDuplicataComPix);
    frmCtrSelecionaOpcaoDuplicataComPix.ShowModal;

    FDuplicatasPix := RetornaDuplicatasDosPixJaGerado(cdsCtaRec.FieldByName('CTR_TX_PIX').AsString,
                                                      cdsCtaRec.FieldByName('CTR_EMPPIX').AsString);

    If frmCtrSelecionaOpcaoDuplicataComPix.OpcaoSelecionada = tpoReceberPix Then
      BaixarDuplicatasLendoQRCodePix(LDatasetPix)
    else
    Begin
      FObjetoPixEmail := TFuncoesPix.RetornaDadosDoRetornoPixAVista(LDatasetPix.FieldByName('MPX_JSOENV').AsString,
                                                                    LDatasetPix.FieldByName('MPX_JSOREC').AsString,
                                                                    LDatasetPix.FieldByName('MPX_SEQPIX').AsString,
                                                                    LDatasetPix.FieldByName('MPX_USASHP').AsString = 'S');

      btnEmailPix.Click;
    End;
  Finally
    FPixJaGerado := False;

    FreeAndNil(LDatasetPix);

    FreeAndNil(frmCtrSelecionaOpcaoDuplicataComPix);
  End;
end;

function TfrmBaixaReceber.DuplicataDeCreditoLiberada(ANumDup, AParcel, AEspDoc, ACodEmp, ACodCli: string): Boolean;
var
  FDuplicatas: TArrayDuplicatasCredito;
  FDuplicata: TDuplicatasCredito;
begin
  Result := True;

  if pos(AEspDoc, 'NF_DV') = 0 then
    Exit;

  FDuplicata.NumDup := ANumDup;
  FDuplicata.Parcel := AParcel;
  FDuplicata.EspDoc := AEspDoc;
  FDuplicata.CodEmp := ACodEmp;
  FDuplicata.CodCli := ACodCli;

  SetLength(FDuplicatas, Length(FDuplicatas)+1);

  FDuplicatas[High(FDuplicatas)] := FDuplicata;

  Result := fDuplicataCreditoLiberada(FDuplicatas);

  SetLength(FDuplicatas, 0);
end;

function TfrmBaixaReceber.DuplicataJaEmUsoPorOutraEstacao(AChave: String): Boolean;
begin
  Result := False;

  If Not fEmptyStr(fGetHostLock(AChave)) Then
  Begin
    If Not fLockedByCurrentConnection(AChave) Then
      Result := True;
  End;
end;

procedure TfrmBaixaReceber.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtNomCli, arrClientes, Nil, fRetNomCliente, 'do Cliente');
  pHabilitaFiltroFiliais;
end;

procedure TfrmBaixaReceber.edtCodCliKeyPress(Sender: TObject; var Key: Char);
begin
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaReceber.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmp, fRetNomeEmpresa, Nil, 'da Empresa');
end;

procedure TfrmBaixaReceber.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp, False) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

{******************************************************************}
{* PROCEDURE ALTERADO PARA CHAMADA DA NOVA CONSULTA DE PORTADORES *}
{***************************************************************JU*}
procedure TfrmBaixaReceber.edtCodPortadorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPortador, edtDesPortador, arrPortador, Nil, fRetNomPortador, 'do Portador');
end;

procedure TfrmBaixaReceber.edtCodPortadorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Begin

    if fPesqPortador(conSimples,
                     Self,
                     edtCodPortador,
                     edtDesPortador,
                     nil,
                     Key,
                     arrPortador,
                     False,
                     'Consulta de Portadores',
                     '',
                     False,
                     False,
                     edtCodEmp.Text) then
    Begin
      If (fValidaCampos(edtCodPortador, True)) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmBaixaReceber.edtCodPrjExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPrj, edtDesPrj, arrPrj, fRetNomeProjeto, Nil, 'do Projeto');
end;

procedure TfrmBaixaReceber.edtCodPrjKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqProjetos(Self, edtCodPrj, edtDesPrj, nil, Key, arrPrj,False) Then
  Begin
    If fValidaCampos(edtCodPrj, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaReceber.edtCodRedExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRed,edtDesRed,arrRede,nil,fRetNomeRedeLoja,'da rede', 5);
end;

procedure TfrmBaixaReceber.edtCodRedKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqRedeLojas(Self, edtCodRed, edtDesRed, Nil, Key, arrRede, False) Then
  Begin
    If fValidaCampos(edtCodRed, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaReceber.edtMedPondMouseLeave(Sender: TObject);
begin
  inherited;
  pLimpaInfo;
end;

procedure TfrmBaixaReceber.edtMedPondMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  pnlInfo.Caption := 'MÉD. POND. = SOMATÓRIO(Vlr.Original * (Dt.Atual-Dt.Cadastro)) / SOMATÓRIO(Vlr.Original)';
end;

procedure TfrmBaixaReceber.edtRomaneioKeyPress(Sender: TObject; var Key: Char);
  Var
    qryConGen : TUniQuery;
    arrSel    : TConsultasArray;

begin
  inherited;

  qryConGen := fCriaQuery;

  If fPesqRomaneio(Self, edtRomaneio, qryConGen, Key, arrSel, 'CADREC') Then
  Begin
    If (fValidaCampos(edtRomaneio, True)) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;

  FreeAndNil(qryConGen);
end;

function TfrmBaixaReceber.ExisteDuplicataDeEspeciePDSelecionada: Boolean;
begin
  Result := FCloneDatasetMarcados.Locate('CTR_ESPDOC', 'PD', []);

  If Result Then
    fMensagem('ATENÇÃO', 'Não é possível gerar Pix para duplicatas com espécie PD.', ['&Ok']);
end;

procedure TfrmBaixaReceber.edtCodvenExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodven, edtNomVen, arrVend, fRetNomVendRep, nil, 'do Vendedor');
end;

procedure TfrmBaixaReceber.edtCodvenKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodven, edtNomVen, nil, Key, arrVend, False) Then
  Begin
    If fValidaCampos(edtCodven, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmBaixaReceber.fApagarBoletoAdiantamento: Boolean;
  Var
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
begin
  Result := True;
  If Not fApenasBoletoAdiantamento Then
    Exit;
  Try
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddSeparador(105);
    objLiberacao.objMsgLibera.pAddTexto('***  BAIXA DUPLICATA/INCLUSAO DE ADIANTAMENTO (BAIXA MANUAL - BOLETO DE ADIANTAMENTO)  ***', alCentro, teAutcom, '', 105);
    objLiberacao.objMsgLibera.pAddSeparador(105);

    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'DUPLICATA' , 13 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'EMP'       , 4  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'CLIENTE'   , 39 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'DT.CAD.'   , 11 , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'DT.VENC.'  , 11 , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'VR.DUPLIC', 14 , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);


    cdsCtaRec.First;
    While Not cdsCtaRec.Eof Do
    Begin
      If (fField('CTR_MARDES').AsString = 'M') Then
      Begin

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('DUPLICATA' , fField('NRODUP').AsString + fField('PARDUP').AsString               , 13 , alEsquerda);
        objLinha.pAddColuna('EMP'       , fField('CTR_CODEMP').AsString                                       , 4  , alCentro  );
        objLinha.pAddColuna('CLIENTE'   , fField('CTR_CODCLI').AsString + '-' + fField('CTR_NOMCLI').AsString , 39 , alEsquerda);
        objLinha.pAddColuna('DT.CAD.'   , FormatDateTime('dd/MM/yyyy', fField('CTR_DTACAD').AsDateTime)       , 11 , alCentro  );
        objLinha.pAddColuna('DT.VENC.'  , FormatDateTime('dd/MM/yyyy', fField('CTR_DTAVEN').AsDateTime)       , 11 , alCentro  );
        objLinha.pAddColuna('VR.DUPLIC', FormatFloat('#,##0.00', fField('CTR_VALDUP').AsFloat)               , 14 , alDireita );
        objTabela.lstLinhas.Add(objLinha);

        Result := False;
      End;
      cdsCtaRec.Next;
    End;
    cdsCtaRec.First;

    If Result Then
      FreeAndNil(objTabela)
    else
    begin
      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      objLiberacao.strDirAce := 'RECMANUALBOLADT';
      objLiberacao.strMsgSen := 'Receber duplicatas de espécie PD cujos boletos foram emitidos, nas rotinas de baixa de contas a receber e resumo de caixa.';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;

      Result := objLiberacao.fLibera;

      if Result then
         objLogLibRec.pInsereLogLigTMP( objLiberacao, cdsCtaRec.FieldByName('CTR_NUMDUP').AsString, cdsCtaRec.FieldByName('CTR_ESPDOC').AsString, cdsCtaRec.FieldByName('CTR_CODEMP').AsString );

    end;
  Finally

  End;
end;


function TfrmBaixaReceber.fApagarBoletoDeAdiantamentoPedido: Boolean;
begin
  Result := False;

  If Not cdsCtaRec.FieldByName('CTR_ESPDOC').AsString.Equals('PD') Then
    Exit;

  If Not fUsaRotinaBoletoAdiantamento() Then
    Exit;

  If fExisteDocumentoEmitidoParaPedido(cdsCtaRec.FieldByName('NRODUP').AsString,
                                       cdsCtaRec.FieldByName('CTR_ESPDOC').AsString,
                                       cdsCtaRec.FieldByName('CTR_CODEMP').AsString) Then
    Exit;

  Result := True;

end;

function TfrmBaixaReceber.fApenasBoletoAdiantamento: Boolean;
  Var
    LTemDuplicataMarcada: Boolean;
begin
  Result := True;

  If Not fCfgSis('RECADT', VarBoolean) Then
  Begin
    Result := False;
    Exit;
  End;

  Try
    LTemDuplicataMarcada := Not FCloneDatasetMarcados.IsEmpty;

    FCloneDatasetMarcados.Filter   := ' (FGO_BOLADT =  ' + QuotedStr('0,00') + ' OR FGO_BOLADT IS NULL)';
    FCloneDatasetMarcados.Filtered := True;

    If (FCloneDatasetMarcados.RecordCount >= 1) Then
      Result := False
    Else If (Not LTemDuplicataMarcada) And Not(cdsCtaRec.FieldByName('FGO_BOLADT').AsFloat > 0.00) Then
      Result := False;
  Finally
    FCloneDatasetMarcados.Filtered := False;
  End;
end;

function TfrmBaixaReceber.fVerificaPlanoContasSeparacaoJurosDesconto() : Boolean;
Begin

  Result := True;

  If fEmptyStr( fCfgSis('PLJURM') ) Then
  Begin
     pMensagemOk('O plano de contas para utilização na separação de juros, não está configurado!.' + #10#13 +
                 'Informe o plano de contas na "CFG_PLJURM" para realizar essa operação!');
     Result := False;
  End;

  If fEmptyStr( fCfgSis('PLDESM') ) Then
  Begin
     pMensagemOk('O plano de contas para utilização na separação de desconto, não está configurado!.' + #10#13 +
                 'Informe o plano de contas na "CFG_PLDESM" para realizar essa operação!');
     Result := False;
  End;

End;

Function TfrmBaixaReceber.fGravaMovBanValoresSeparados( pcdsDups : TUniClientDataSet;
                                                        pStrCtaBai,
                                                        pStrPorBai,
                                                        pStrOpeBai : String;
                                                        pDtaLan,
                                                        pHraLan : TDateTime;
                                                        pStrNumDoc,
                                                        pStrCreDeb,
                                                        pStrCodEmpBai : String;
                                                        pfltValReceb : Double;
                                                        pStrHist01,
                                                        pStrHist02,
                                                        pStrHistBai : String;
                                                        pStrCodCli,
                                                        pstrCodFor,
                                                        pStrNroDup : String;
                                                        pIntSeqBai : Integer;
                                                        pStrParDup,
                                                        pStrCodEmp,
                                                        pSerie,
                                                        pStrCodEve,
                                                        pStrDocBai : String;
                                                        pStrEspDoc : String;
                                                        pfltValOri,
                                                        pfltValJur,
                                                        pfltValDes,
                                                        pfltValDup : Double;
                                                        pAutoincrem,
                                                        pTipoBaixa : String
                                                       ) : String;
Var
    cfgBaiAna,
    strSeqLanPrinc : String;
    lstBanCtrN : TBanCtrRepository;
    blnOk : boolean;
    fltTot,
    fltValLan : Real;
    strTipBai : String;
    blnGravamovBan : Boolean;
    blnTemCredito  : Boolean;
Begin
    cfgBaiAna      := fCfgSis('CTR_AS');
    blnOk          := False;
    blnGravamovBan := False;
    blnTemCredito  := False;
    strTipBai      := '';
    fltValLan      := 0;
    strSeqLanPrinc := '';

    Try

      lstBanCtrN := TBanCtrRepository.Create;

      If (cfgBaiAna = 'S') And (pcdsDups <> Nil) Then
      Begin
          fltTot := 0;

          pcdsDups.First;
          While Not pcdsDups.Eof Do
          Begin

            //*** VERIFICA SE É BAIXA PARCIAL OU TOTAL ***//
            If pcdsDups.fieldByName('CTR_ESPDOC').AsString <> 'CC' Then
            Begin

              strTipBai := pcdsDups.fieldByName('CTR_TIPBAI').AsString;

              If strTipBai = 'T' Then
              Begin
                 If pcdsDups.fieldByName('CTR_SEQBAI').AsInteger = 0 Then
                    fltValLan := pcdsDups.fieldByName('CTR_VALDUP').AsFloat + pcdsDups.fieldByName('CTR_DESCOB').AsFloat
                 Else
                    fltValLan := (pcdsDups.fieldByName('CTR_VALREC').AsFloat - pfltValDes) - pfltValJur;
              End
              Else
              If strTipBai = 'P' Then
                 fltValLan := (pcdsDups.fieldByName('CTR_VALREC').AsFloat - pcdsDups.fieldByName('CTR_VALDES').AsFloat) - pcdsDups.fieldByName('CTR_VALJUR').AsFloat;
                 //fltValLan := (pcdsDups.fieldByName('CTR_VALREC').AsFloat - pfltValDes) - pfltValJur;

              lstBanCtrN.fAdd(pcdsDups.fieldByName('NRODUP'    ).AsString,
                              pcdsDups.fieldByName('PARDUP'    ).AsString,
                              pcdsDups.fieldByName('CTR_ESPDOC').AsString,
                              pcdsDups.fieldByName('CTR_CODEMP').AsString,
                              pcdsDups.fieldByName('CTR_CODCLI').AsString,
                              pcdsDups.fieldByName('CTR_HIST01').AsString,
                              pcdsDups.fieldByName('CTR_HIST02').AsString,
                              pcdsDups.fieldByName('CTR_SEQBAI').AsInteger,
                              fltValLan,
                              0,
                              0,
                              fltValLan);

              fltTot := fltTot + fltValLan;

              blnGravamovBan := True;

            End
            Else
              blnTemCredito := True;

            pcdsDups.Next;

          End;

      End
      Else
      Begin

          fltTot := 0;

          strTipBai := pTipoBaixa;

          //*** VERIFICA SE É BAIXA PARCIAL OU TOTAL ***//
          If pStrEspDoc <> 'CC' Then
          Begin

            fltValLan := ((pfltValReceb + pfltValDes) - pfltValJur);

            lstBanCtrN.fAdd(pStrNroDup,
                            pStrParDup,
                            pStrEspDoc,
                            pStrCodEmp,
                            pStrCodCli,
                            pStrHist01,
                            pStrHist02,
                            pIntSeqBai,
                            fltValLan,
                            0,
                            0,
                            fltValLan);

             fltTot := fltValLan;

             blnGravamovBan := True;

          End
          Else
            blnTemCredito := True;

      End;

      // *** GRAVA MOVBAN DO DOCUMENTO COM O VALOR SEM JUROS E SEM DESCONTO ***;
      If blnGravamovBan Then
      Begin
         strSeqLanPrinc := fGravaMovBan( pStrCtaBai,          // Centro de Custo
                                         pStrPorBai,          // Portador da Baixa
                                         pStrOpeBai,          // Operador da Baixa
                                         pDtaLan,             // Data do Lançamento
                                         pHraLan,             // Hora do Lançamento
                                         pStrNumDoc,          // Numero do Documento
                                         pStrCreDeb,          // Credito / Debito
                                         pStrCodEmpBai,       // Empresa da Baixa
                                         fltTot,              // IIf(pTipoBaixa = 'T', pfltValOri, pfltValReceb), //
                                         pStrHistBai,         // Histórico de baixa
                                         pStrHist02,          // Histórico 2
                                         pStrCodCli,          // Cliente da Duplicata
                                         pstrCodFor,          // Fornecedor da Duplicata
                                         pStrNroDup,          // Número da Duplicata
                                         pIntSeqBai,          // Sequencial de Baixa
                                         pStrParDup,          // Parcela da Duplicata
                                         pStrCodEmp,          // Empresa da Duplicata
                                         pSerie,              // Série
                                         pStrCodEve,          // Codigo do Evento
                                         pStrDocBai,          // Documento da Baixa
                                         lstBanCtrN.fGetlist  // Log Bancário
                                       );

         If Not fEmptyStr(strSeqLanPrinc) Then
            blnOk := (fGravaMovCtr(pcdsDups,
                                   pAutoincrem,
                                   strSeqLanPrinc,
                                   pStrCodEmpBai) <> '');  //pstrCodEmp

      End;

    Finally

      If Assigned(lstBanCtrN) Then
         FreeAndNil(lstBanCtrN);

    End;

    If BlnOk Then
    Begin

      If (pfltValJur > 0) Then  // *** JUROS *** //
      Begin
        fGravaJurosLancamentosSeparados(pcdsDups,
                                        cfgBaiAna,
                                        pStrCtaBai,
                                        pStrPorBai,
                                        pStrOpeBai,
                                        pDtaLan,
                                        pHraLan,
                                        pStrNumDoc,
                                        pStrCreDeb,
                                        pStrCodEmpBai,
                                        pfltValReceb,
                                        pStrHist01,
                                        pStrHist02,
                                        pStrHistBai,
                                        pStrCodCli,
                                        pstrCodFor,
                                        pStrNroDup,
                                        pIntSeqBai,
                                        pStrParDup,
                                        pStrCodEmp,
                                        pSerie,
                                        pStrCodEve,
                                        pStrDocBai,
                                        pStrEspDoc,
                                        pfltValOri,
                                        pfltValJur,
                                        pfltValDes,
                                        pfltValDup,
                                        pAutoincrem );
      End;

      If (pfltValDes > 0) Then // *** DESCONTO *** //
      Begin
         fGravaDescontoLancamentosSeparados( pcdsDups,
                                             cfgBaiAna,
                                             pStrCtaBai,
                                             pStrPorBai,
                                             pStrOpeBai,
                                             pDtaLan,
                                             pHraLan,
                                             pStrNumDoc,
                                             pStrCreDeb,
                                             pStrCodEmpBai,
                                             pfltValReceb,
                                             pStrHist01,
                                             pStrHist02,
                                             pStrHistBai,
                                             pStrCodCli,
                                             pstrCodFor,
                                             pStrNroDup,
                                             pIntSeqBai,
                                             pStrParDup,
                                             pStrCodEmp,
                                             pSerie,
                                             pStrCodEve,
                                             pStrDocBai,
                                             pStrEspDoc,
                                             pfltValOri,
                                             pfltValJur,
                                             pfltValDes,
                                             pfltValDup,
                                             pAutoincrem );
      End;

      Result := strSeqLanPrinc;

    End;

    // ********* GRAVA CREDITOS UTILIZADOS ***********
    If blnTemCredito Then
    Begin

        result := fGravaCreditoLancamentosSeparados(pcdsDups,
                                                    cfgBaiAna,
                                                    pStrCtaBai,
                                                    pStrPorBai,
                                                    pStrOpeBai,
                                                    pDtaLan,
                                                    pHraLan,
                                                    pStrNumDoc,
                                                    pStrCreDeb,
                                                    pStrCodEmpBai,
                                                    pfltValReceb,
                                                    pStrHist01,
                                                    pStrHist02,
                                                    pStrHistBai,
                                                    pStrCodCli,
                                                    pstrCodFor,
                                                    pStrNroDup,
                                                    pIntSeqBai,
                                                    pStrParDup,
                                                    pStrCodEmp,
                                                    pSerie,
                                                    pStrCodEve,
                                                    pStrDocBai,
                                                    pStrEspDoc,
                                                    pfltValOri,
                                                    pfltValJur,
                                                    pfltValDes,
                                                    pfltValDup,
                                                    pAutoincrem );

    End;

End;

function TfrmBaixaReceber.fGravaJurosLancamentosSeparados( pcdsDups  : TUniClientDataSet;
                                                           strCfgBaiAna,
                                                           strCtaBai,
                                                           strPorBai,
                                                           strOpeBai : String;
                                                           dtaLan,
                                                           hraLan : TDateTime;
                                                           strNumDoc,
                                                           strCreDeb,
                                                           strCodEmpBai : String;
                                                           fltValReceb : Double;
                                                           strHist01,
                                                           strHist02,
                                                           strHistBai : String;
                                                           strCodCli,
                                                           strCodFor,
                                                           strNroDup : String;
                                                           intSeqBai : Integer;
                                                           strParDup,
                                                           strCodEmp,
                                                           serie,
                                                           strCodEve,
                                                           strDocBai : String;
                                                           strEspDoc : String;
                                                           fltValOri,
                                                           fltValJur,
                                                           fltValDes,
                                                           fltValDup : Double;
                                                           strAutoincrem : String
                                                          ) : String;
Var
    strPlConta_juros,
    strseqlan,
    strTipoLancCreDeb : String;
    lstBanCtrN : TBanCtrRepository;
    blnGravamovBan,
    blnOk : Boolean;
Begin
    Result         := '';
    blnGravamovBan := False;
    blnOk          := False;

    Try
      lstBanCtrN       := TBanCtrRepository.Create;
      strPlConta_juros := fCfgSis('PLJURM');

      If (strCfgBaiAna = 'S') And (pcdsDups <> Nil) Then
      Begin

         pcdsDups.First;
         While Not pcdsDups.Eof Do
         Begin

           If pcdsDups.fieldByName('CTR_ESPDOC').AsString <> 'CC' Then
           Begin

              If pcdsDups.fieldByName('CTR_VALJUR').AsFloat > 0 Then
              Begin
                 lstBanCtrN.fAdd(pcdsDups.fieldByName('NRODUP'    ).AsString,
                                 pcdsDups.fieldByName('PARDUP'    ).AsString,
                                 pcdsDups.fieldByName('CTR_ESPDOC').AsString,
                                 pcdsDups.fieldByName('CTR_CODEMP').AsString,
                                 pcdsDups.fieldByName('CTR_CODCLI').AsString,
                                 pcdsDups.fieldByName('CTR_HIST01').AsString,
                                 pcdsDups.fieldByName('CTR_HIST02').AsString,
                                 pcdsDups.fieldByName('CTR_SEQBAI').AsInteger,
                                 pcdsDups.fieldByName('CTR_VALJUR').AsFloat,
                                 0,
                                 0,
                                 pcdsDups.fieldByName('CTR_VALJUR').AsFloat);

                 blnGravamovBan := True;
              End;

           End;

           pcdsDups.Next;
         End;

      End
      Else
      Begin

         If strEspDoc <> 'CC' Then
         Begin
            lstBanCtrN.fAdd(StrNroDup,
                            StrParDup,
                            StrEspDoc,
                            StrCodEmp,
                            StrCodCli,
                            StrHist01,
                            StrHist02,
                            IntSeqBai,
                            fltValJur,
                            0,
                            0,
                            fltValJur);

            blnGravamovBan := True;
         End;

      End;

      If blnGravamovBan Then
      Begin
          strTipoLancCreDeb := 'C';
          strSeqLan := fGravaMovBan(strPlConta_juros,           // Centro de Custo
                                    strPorBai,                  // Portador da Baixa
                                    strOpeBai,                  // Operador da Baixa
                                    DtaLan,                     // Data do Lançamento
                                    HraLan,                     // Hora do Lançamento
                                    strNumDoc,                  // Numero do Documento
                                    strTipoLancCreDeb,          // Credito / Debito
                                    strCodEmpBai,               // Empresa da Baixa
                                    fltValJur,                  // Valor Do Lançamento
                                    'REF. JUROS ' + strHistBai, // Histórico de Baixa
                                    strHist02,                  // Histórico 2
                                    strCodCli,                  // Cliente da Duplicata
                                    strCodFor,                  // Fornecedor da Duplicata
                                    strNroDup,                  // Número da Duplicata
                                    IntSeqBai,                  // Sequencial de Baixa
                                    strParDup,                  // Parcela da Duplicata
                                    strCodEmp,                  // Empresa da Duplicata
                                    serie,                      // Série
                                    strCodEve,                  // Codigo do Evento
                                    strDocBai,                  // Documento da Baixa
                                    lstBanCtrN.fGetList         // Log Bancário
                                   );

          If Not fEmptyStr(strSeqLan) Then
             blnOk := (fGravaMovCtr(pcdsDups, strAutoincrem, strSeqlan, strCodEmpBai) <> '');

          If blnOk Then
             Result := strSeqLan;

      End;

    Finally
       If Assigned(lstBanCtrN) Then
          FreeAndNil(lstBanCtrN);
    End;

End;

function TfrmBaixaReceber.fGravaDescontoLancamentosSeparados( pcdsDups  : TUniClientDataSet;
                                                              strCfgBaiAna,
                                                              strCtaBai,
                                                              strPorBai,
                                                              strOpeBai : String;
                                                              dtaLan,
                                                              hraLan : TDateTime;
                                                              strNumDoc,
                                                              strCreDeb,
                                                              strCodEmpBai : String;
                                                              fltValReceb : Double;
                                                              strHist01,
                                                              strHist02,
                                                              strHistBai : String;
                                                              strCodCli,
                                                              strCodFor,
                                                              strNroDup : String;
                                                              intSeqBai : Integer;
                                                              strParDup,
                                                              strCodEmp,
                                                              serie,
                                                              strCodEve,
                                                              strDocBai : String;
                                                              strEspDoc : String;
                                                              fltValOri,
                                                              fltValJur,
                                                              fltValDes,
                                                              fltValDup : Double;
                                                              strAutoincrem : String
                                                            ) : String;
Var
    strPlConta_desc,
    strseqlan,
    strTipoLancCreDeb : String;
    lstBanCtrN : TBanCtrRepository;
    blnGravamovBan,
    blnOk      : Boolean;
Begin
      Result         := '';
      blnOk          := False;

      // ********************
      // ** GRAVA DESCONTO **
      // ********************
      If (fltValDes > 0) Then // *** DESCONTO ***
      Begin

          strPlConta_desc := fCfgSis('PLDESM');
          blnGravamovBan  := False;

          Try
             lstBanCtrN := TBanCtrRepository.Create;

              If (strCfgBaiAna = 'S') And (pcdsDups <> Nil) Then
              Begin

                 pcdsDups.First;
                 While Not pcdsDups.Eof Do
                 Begin

                   //** verifica se é credito do cliente **
                   If pcdsDups.fieldByName('CTR_ESPDOC').AsString <> 'CC' Then
                   Begin

                     lstBanCtrN.fAdd(pcdsDups.fieldByName('NRODUP').AsString,
                                     pcdsDups.fieldByName('PARDUP').AsString,
                                     pcdsDups.fieldByName('CTR_ESPDOC').AsString,
                                     pcdsDups.fieldByName('CTR_CODEMP').AsString,
                                     pcdsDups.fieldByName('CTR_CODCLI').AsString,
                                     pcdsDups.fieldByName('CTR_HIST01').AsString,
                                     pcdsDups.fieldByName('CTR_HIST02').AsString,
                                     pcdsDups.fieldByName('CTR_SEQBAI').AsInteger,
                                     pcdsDups.fieldByName('CTR_VALDES').AsFloat,
                                     0,
                                     0,
                                     pcdsDups.fieldByName('CTR_VALDES').AsFloat);

                     blnGravamovBan := True;

                   End;
                   pcdsDups.Next;

                 End;

              End
              Else
              Begin

                If StrEspDoc <> 'CC' Then
                Begin

                   lstBanCtrN.fAdd(strNroDup,
                                   strParDup,
                                   strEspDoc,
                                   strCodEmp,
                                   strCodCli,
                                   strHist01,
                                   strHist02,
                                   inTSeqBai,
                                   fltValDes,
                                   0,
                                   0,
                                   fltValDes);

                    blnGravamovBan := True;
                End;

              End;

              If blnGravamovBan Then
              Begin

                  strTipoLancCreDeb := 'D';
                  strSeqLan := fGravaMovBan(strPlConta_desc,              // Centro de Custo
                                            strPorBai,                    // Portador da Baixa
                                            strOpeBai,                    // Operador da Baixa
                                            DtaLan,                       // Data do Lançamento
                                            HraLan,                       // Hora do Lançamento
                                            strNumDoc,                    // Numero do Documento
                                            strTipoLancCreDeb,            // Credito / Debito
                                            strCodEmpBai,                 // Empresa da Baixa
                                            fltValDes,                    // Valor Do Lançamento
                                            'REF. DESCTO. ' + StrHistBai, // Histórico de Baixa
                                            strHist02,                    // Histórico 2
                                            strCodCli,                    // Cliente da Duplicata
                                            strCodFor,                    // Fornecedor da Duplicata
                                            strNroDup,                    // Número da Duplicata
                                            intSeqBai,                    // Sequencial de Baixa
                                            strParDup,                    // Parcela da Duplicata
                                            strCodEmp,                    // Empresa da Duplicata
                                            serie,                        // Série
                                            strCodEve,                    // Codigo do Evento
                                            strDocBai,                    // Documento da Baixa
                                            lstBanCtrN.fGetList           // Log Bancário
                                           );

                If Not fEmptyStr(strSeqLan) Then
                   blnOk := (fGravaMovCtr(pcdsDups, strAutoincrem, strSeqlan, StrCodEmpBai) <> '');

                If BlnOk Then
                   Result := strSeqLan;

              End;

          Finally
            If Assigned(lstBanCtrN) Then
               FreeAndNil(lstBanCtrN);
          End;

      End;

End;

function TfrmBaixaReceber.fGravaMovCtr(cdsDups   : TUniClientDataSet;
                                       strAutoIn : String;             // AutoIncrem Contas a receber
                                       strSeqlan : String;             // Seqlan da Movban
                                       strCodEmp : String              // Empresa da MovBan
                                      ): String;
  Var
    strSQL    : String;
    qryAux : TUniQuery;
    strAutInc : String;
begin
  Result    := '';
  strAutInc := '';

  qryAux := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'INSERT INTO MOVCTR ';
  strSQL := strSQL + '( ';
  strSQL := strSQL + '  AUTOINCREM,  ';
  strSQL := strSQL + '  MOV_AUTCTR,  ';
  strSQL := strSQL + '  MOV_SEQCTB,  ';
  strSQL := strSQL + '  MOV_EMPCTB ) ';
  strSQL := strSQL + 'VALUES ( ';
  strSQL := strSQL + '  :AUTOINCREM,  ';
  strSQL := strSQL + '  :MOV_AUTCTR,  ';
  strSQL := strSQL + '  :MOV_SEQCTB,  ';
  strSQL := strSQL + '  :MOV_EMPCTB ) ';

  Try

    If (fcfgsis('CTR_AS') = 'S') And (cdsDups <> nil) Then
    Begin

      cdsDups.First;
      While Not cdsDups.Eof Do
      Begin

         strAutInc := fRetAutoIncrem('MOVCTR', strCodEmp);
         strAutoIn := cdsDups.fieldByName('AUTOINCREM').AsString;

         With qryAux Do
         Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('AUTOINCREM').AsString   := strAutInc;
            ParamByName('MOV_AUTCTR').AsString   := strAutoIn;
            ParamByName('MOV_SEQCTB').AsString   := strSeqlan;
            ParamByName('MOV_EMPCTB').AsString   := strCodEmp; //cdsDups.fieldByName('CTR_CODEMP').AsString;
            ExecSQL;
         End;

         fGravaLogMovCtr( strAutInc, 'BAIXA RECEBER SINTETICA', self.name, '');

         cdsDups.Next;

      End;

      Result := strAutInc;

    End
    Else
    Begin

      strAutInc := fRetAutoIncrem('MOVCTR', strCodEmp);

      With qryAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('AUTOINCREM').AsString := strAutInc;
        ParamByName('MOV_AUTCTR').AsString := strAutoIn;
        ParamByName('MOV_SEQCTB').AsString := strSeqlan;
        ParamByName('MOV_EMPCTB').AsString := strCodEmp;
        ExecSQL;

        fGravaLogMovCtr( strAutInc, 'BAIXA RECEBER ANALITICA', self.name, '');

        Result := strAutInc;
      End;

    End;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('[TfrmBaixaReceber.fGravaMovCtr] - ' + E.Message);
      Result := '';
    End;
  End;

  FreeAndNil(qryAux);
end;

function TfrmBaixaReceber.fGravaCreditoLancamentosSeparados( pcdsDups  : TUniClientDataSet;
                                                             strCfgBaiAna,
                                                             strCtaBai,
                                                             strPorBai,
                                                             strOpeBai : String;
                                                             dtaLan,
                                                             hraLan : TDateTime;
                                                             strNumDoc,
                                                             strCreDeb,
                                                             strCodEmpBai : String;
                                                             fltValReceb : Double;
                                                             strHist01,
                                                             strHist02,
                                                             strHistBai : String;
                                                             strCodCli,
                                                             strCodFor,
                                                             strNroDup : String;
                                                             intSeqBai : Integer;
                                                             strParDup,
                                                             strCodEmp,
                                                             serie,
                                                             strCodEve,
                                                             strDocBai : String;
                                                             strEspDoc : String;
                                                             fltValOri,
                                                             fltValJur,
                                                             fltValDes,
                                                             fltValDup : Double;
                                                             strAutoincrem : String
                                                           ) : String;
Var
    strseqlan,
    strTipoLancCreDeb : String;
    lstBanCtrN : TBanCtrRepository;
    blnOk : boolean;
    fltTot    : Real;
    blnGravamovBan : Boolean;
Begin

    // *****************************************************
    // ** GRAVA CREDITOS UTILIZADOS PELO CLIENTE NA BAIXA **
    // *****************************************************
    Try
      lstBanCtrN     := TBanCtrRepository.Create;
      fltTot         := 0;
      blnOk          := false;
      blnGravamovBan := false;

      If (strCfgBaiAna = 'S') And (pcdsDups <> Nil) Then
      Begin

         pcdsDups.First;
         While Not pcdsDups.Eof Do
         Begin

           If pcdsDups.fieldByName('CTR_ESPDOC').AsString = 'CC' Then
           Begin
             lstBanCtrN.fAdd(pcdsDups.fieldByName('NRODUP'    ).AsString,
                             pcdsDups.fieldByName('PARDUP'    ).AsString,
                             pcdsDups.fieldByName('CTR_ESPDOC').AsString,
                             pcdsDups.fieldByName('CTR_CODEMP').AsString,
                             pcdsDups.fieldByName('CTR_CODCLI').AsString,
                             pcdsDups.fieldByName('CTR_HIST01').AsString,
                             pcdsDups.fieldByName('CTR_HIST02').AsString,
                             pcdsDups.fieldByName('CTR_SEQBAI').AsInteger,
                             Abs(pcdsDups.fieldByName('CTR_VALREC').AsFloat),
                             0,
                             0,
                             pcdsDups.fieldByName('CTR_VALREC').AsFloat);

             fltTot := fltTot + pcdsDups.fieldByName('CTR_VALREC').AsFloat;

             blnGravamovBan := True;
           End;

           pcdsDups.Next;
         End;

      End
      Else
      Begin

         If StrEspDoc = 'CC' Then
         Begin
            lstBanCtrN.fAdd(StrNroDup,
                            StrParDup,
                            StrEspDoc,
                            StrCodEmp,
                            StrCodCli,
                            StrHist01,
                            StrHist02,
                            IntSeqBai,
                            abs(fltValReceb),
                            0,
                            0,
                            fltValReceb);

            fltTot := fltValReceb;

            blnGravamovBan := True;
         End;

      End;

      If blnGravamovBan Then
      Begin
          strTipoLancCreDeb := 'D';
          strSeqLan := fGravaMovBan(strCtaBai,                // Centro de Custo
                                    StrPorBai,                // Portador da Baixa
                                    StrOpeBai,                // Operador da Baixa
                                    DtaLan,                   // Data do Lançamento
                                    HraLan,                   // Hora do Lançamento
                                    StrNumDoc,                // Numero do Documento
                                    strTipoLancCreDeb,        // Credito / Debito
                                    StrCodEmpBai,             // Empresa da Baixa
                                    fltTot,                   // Valor Do Lançamento
                                    'REF. CC ' + StrHistBai,  // Histórico de Baixa
                                    StrHist02,                // Histórico 2
                                    StrCodCli,                // Cliente da Duplicata
                                    strCodFor,                // Fornecedor da Duplicata
                                    StrNroDup,                // Número da Duplicata
                                    IntSeqBai,                // Sequencial de Baixa
                                    StrParDup,                // Parcela da Duplicata
                                    StrCodEmp,                // Empresa da Duplicata
                                    Serie,                    // Série
                                    StrCodEve,                // Codigo do Evento
                                    StrDocBai,                // Documento da Baixa
                                    lstBanCtrN.fGetList       // Log Bancário
                                   );

          If Not fEmptyStr(strSeqLan) Then
             blnOk := (fGravaMovCtr(pcdsDups, strAutoincrem, strSeqlan, strCodEmpBai) <> '');

          If blnOk Then
             result := strSeqLan;

      End;

    Finally
       If Assigned(lstBanCtrN) Then
          FreeAndNil(lstBanCtrN);
    End;

End;

function TfrmBaixaReceber.fBaixaDuplicatas(pgbProgresso: TcxProgressBar): Boolean;
  Var
    blnBaiAna   : Boolean;
    blnConfirma : Boolean;
    strSeqLan   : String;
    strCreDeb   : String;
    strSeqMod   : String;
    fltValRec   : Double;
    intSeqBai   : Integer;
    intContador : Integer;
    intDupCx    : Integer;
    intContCopia: Integer;
    intContador2: Integer;
    intRecNoCtr : Integer;
    strHisCar   : String;
    strFilAnt   : String;
    prcScroll   : TprcScroll;

    strAutIncNov: String;

    fltTotCx    : Double;

    fltValFin   : Double;
    fltValCre   : Double;
    blnValCqP   : Boolean;
    blnValCqV   : Boolean;
    blnValDin   : Boolean;
    blnValCar   : Boolean;
    blnValOrd   : Boolean;
    blnValFin   : Boolean;

    fltValIpiCar,
    fltValRetCar,
    fltValAceCar,
    fltValFreCar: Double;

    fltNovoValDup: Double;
    fltNovoValOri: Double;
    fltDifOri    : Double;
    dtaDtaVen    : TDateTime;


    fltTotJurSep: Double;
    fltTotDesSep: Double;
    fltTotDocSep: Double;

    intQtdDup  : Integer;
    strDocume  : String;
    intSeqPar  : Integer;
    strPriCli  : String;
    bkmPosGri  : TBookmark;
    blnHisAut  : Boolean;
    strManVen  : String;
    blnGraVDp  : Boolean;
    blnTemRegCH: Boolean;

    arrDuplicCarIpi,
    arrDuplicCarRet,
    arrDuplicCarAce,
    arrDuplicCarFre,
    arrDuplicCarCbs,
    arrDuplicCarIbs,
    arrDuplicCar_Is,
    arrDuplicFat,
    arrDuplicata   : TArrDigDuplicArray;

    blnGerouLogLib : Boolean;
    LDataCadastroCartao: TDateTime;

    lstBanCtr : TBanCtrRepository;

    objArredondaParcela: IArredondaParcela;

    LRecebidoPorPix,
    LFormularioBaixa: String;

    LDataBaseCartao: TDateTime;
    LTipoParcelamento: String;

    blnDescCobFoiAlterada: Boolean;

    LContadorLog: Integer;

    LArrayGravacaoLog: Array Of TGravacaoLogCtr;

    fltTotCqP,
    fltTotCqV,
    fltTotDin,
    fltTotCar,
    fltTotOrd,
    fltTotFin,

    fltAuxCqP,
    fltAuxCqV,
    fltAuxDin,
    fltAuxCar,
    fltAuxOrd,
    fltAuxFin,

    fltGraCqP,
    fltGraCqV,
    fltGraDin,
    fltGraCar,
    fltGraOrd,
    fltGraFin: Double;

    LDesmembrarBaixaReceber : TDesmembraBaixaReceber;
    LValorDuplicata: Currency;
    LValorEsperadoDuplicata: Currency;

    function fVerificaDuplicatas: Boolean;
      Var
        blnNegat: Boolean;
        blnPosit: Boolean;
    Begin
      FCloneDatasetMarcados.First;
      With FCloneDatasetMarcados Do
      Begin
        blnNegat := False;
        blnPosit := False;

        First;
        While Not Eof Do
        Begin

          If fFormataFloat(FieldByName('CTR_VALREC').AsFloat,2) < 0 Then
            blnNegat := True
          Else If fFormataFloat(FieldByName('CTR_VALREC').AsFloat,2) > 0 Then
            blnPosit := True;

          Next;
        End;

        Result := Not (blnNegat And blnPosit);
      End;
    End;

    procedure pRateiaVariaveisModalidades;
      Var
        fltDiferenca: Double;
    begin
      fltGraCqP := fltValCqP;
      fltGraCqV := fltValCqV;
      fltGraDin := fltValDin;
      fltGraCar := fltValCar;
      fltGraOrd := fltValOrd;
      fltGraFin := fltValFin;

      If (fltValCre > 0) Then
        fltDiferenca := fltValCre
      Else
        fltDiferenca := 0;

      {***************************************}
      {* CASO HAJA CRÉDITO OU TROCO, O VALOR *}
      {* DA DIFERENÇA DEVE SER SUBTRAÍDO DO  *}
      {* VALOR A SER RATEADO ENTRE AS DUPLI- *}
      {* CATAS.                              *}
      {************************************MV*}
      If (fltDiferenca > 0) Then
      Begin
        {***************************************}
        {* VERIFICA SE PODE TIRAR DO DINHEIRO  *}
        {************************************MV*}
        If (fltGraDin >= fltDiferenca) Then
        Begin
          fltGraDin := fltGraDin - fltDiferenca;
        End
        Else
        Begin
          fltGraCqP := fRateioRec(fltTotCx+fltDiferenca, fStrToFloat(edtTotalRecebido.Text), fltValCqP);
          fltGraCqV := fRateioRec(fltTotCx+fltDiferenca, fStrToFloat(edtTotalRecebido.Text), fltValCqV);
          fltGraDin := fRateioRec(fltTotCx+fltDiferenca, fStrToFloat(edtTotalRecebido.Text), fltValDin);
          fltGraCar := fRateioRec(fltTotCx+fltDiferenca, fStrToFloat(edtTotalRecebido.Text), fltValCar);
          fltGraOrd := fRateioRec(fltTotCx+fltDiferenca, fStrToFloat(edtTotalRecebido.Text), fltValOrd);
          fltGraFin := fRateioRec(fltTotCx+fltDiferenca, fStrToFloat(edtTotalRecebido.Text), fltValFin);
        End;
      End;

      fltAuxCqP := fRateioRec(fStrToFloat(edtTotalRecebido.Text), fField('CTR_VALREC').AsFloat, fltGraCqP);
      fltAuxCqV := fRateioRec(fStrToFloat(edtTotalRecebido.Text), fField('CTR_VALREC').AsFloat, fltGraCqV);
      fltAuxDin := fRateioRec(fStrToFloat(edtTotalRecebido.Text), fField('CTR_VALREC').AsFloat, fltGraDin);
      fltAuxCar := fRateioRec(fStrToFloat(edtTotalRecebido.Text), fField('CTR_VALREC').AsFloat, fltGraCar);
      fltAuxOrd := fRateioRec(fStrToFloat(edtTotalRecebido.Text), fField('CTR_VALREC').AsFloat, fltGraOrd);
      fltAuxFin := fRateioRec(fStrToFloat(edtTotalRecebido.Text), fField('CTR_VALREC').AsFloat, fltGraFin);

      fltTotCqP := fltTotCqP + fltAuxCqP;
      fltTotCqV := fltTotCqV + fltAuxCqV;
      fltTotDin := fltTotDin + fltAuxDin;
      fltTotCar := fltTotCar + fltAuxCar;
      fltTotOrd := fltTotOrd + fltAuxOrd;
      fltTotFin := fltTotFin + fltAuxFin;
    end;
begin
  Application.ProcessMessages;
  Try
    blnConfirma := False;
    blnGerouLogLib := False;
    If (fFormataFloat(fStrToFloat(edtTotalRecebido.Text),2) < 0) And (Not fVerificaDuplicatas) Then
    Begin
      pMensagemOk('Não é permitido realizar uma baixa com duplicatas conjugadas positivas e negativas, ficando o valor total negativo por esse módulo!' + #10#13 + 'Para realizar essa operação utilize a baixa do Resumo de Caixa!');
      blnMostrarMsgRecibo := False;
      Result := False;
      Exit;
    End;

    blnMostrarMsgRecibo := True;

    blnTemRegCH := fVerificaTemRegCH;

    intQtdDup := 0;
    strHisCar := '';
    strDocume := '';

    fltValDes := 0;

    fltTotCqP := 0;
    fltTotCqV := 0;
    fltTotDin := 0;
    fltTotCar := 0;
    fltTotOrd := 0;
    fltTotFin := 0;

    fltAuxCqP := 0;
    fltAuxCqV := 0;
    fltAuxDin := 0;
    fltAuxCar := 0;
    fltAuxOrd := 0;
    fltAuxFin := 0;

    //Setando valores
    //funcoes : pFrmDigValores , pFrmFormaPgto
    fltValCqP := fStrToFloat(dicBaixa['flValCqp']);
    fltValCqV := fStrToFloat(dicBaixa['fltValCqV']);
    fltValDin := IIF(fStrToFloat(dicBaixa['fltValDin']) > 0,fStrToFloat(dicBaixa['fltValDin']),fStrToFloat('0'));
    fltValCar := fStrToFloat(dicBaixa['fltValCar']);
    fltValOrd := fStrToFloat(dicBaixa['fltValOrd']);
    fltValFin := fStrToFloat(dicBaixa['fltValFin']);
    fltValCre := fStrToFloat(dicBaixa['fltValCre']);
    fltValCredito := 0;

    SetLength(LArrayGravacaoLog, 0);
    LContadorLog := 0;

    If Not fPermiteModalidadeParaPortador(fltValDin, fltValCar, fltValCqV, fltValCqP, fltValOrd, fltValFin, strPorBai) Then
    Begin
      pMensagemOk('O Portador para baixa não tem permissão para uma ou mais das modalidades informadas!');
      blnMostrarMsgRecibo := False;
      Result := False;
      Exit;
    End;

    intDupCx := StrToInt(dicBaixa['intDupCx']);
    fltTotCx := fStrToFloat(dicBaixa['fltTotCx']);

    intSeqBai := 0;

    blnValCqP := dicBaixa['blnValCqP'];
    blnValCqV := dicBaixa['blnValCqV'];
    blnValDin := dicBaixa['blnValDin'];
    blnValCar := dicBaixa['blnValCar'];
    blnValOrd := dicBaixa['blnValOrd'];
    blnValFin := dicBaixa['blnValFin'];
    strPriCli := dicBaixa['strPriCli'];
    strSeqMod := dicBaixa['strSeqMod'];

    cdsRateio := fCriaCdsRateio(Nil);

    lstBanCtr := TBanCtrRepository.Create;

    fltTotJurSep := 0;
    fltTotDesSep := 0;
    fltTotDocSep := 0;

    Result    := False;
    blnBaiAna := fCfgSis('CTR_AS') = 'A';
    strSeqLan := '';

    intRecNoCtr := cdsCtaRec.RecNo;

    cdsCtaRec.First;
    While (Not cdsCtaRec.Eof) Do
    Begin
      If (Not blnBaiAna) And (fField('CTR_MARDES').AsString = 'M') Then
      Begin
        lstBanCtr.fAdd(fField('NRODUP').AsString,
                       fField('PARDUP').AsString,
                       fField('CTR_ESPDOC').AsString,
                       fField('CTR_CODEMP').AsString,
                       fField('CTR_CODCLI').AsString,
                       fField('CTR_HIST01').AsString,
                       fField('CTR_HIST02').AsString,
                       fField('CTR_SEQBAI').AsInteger,
                       fField('CTR_VALREC').AsFloat,
                       fField('CTR_VALJUR').AsFloat,
                       fField('CTR_VALDES').AsFloat,
                       fField('CTR_VALDUP').AsFloat);

        //totaliza valores

        If fField('CTR_TIPBAI').AsString = 'P' Then
           fltTotDocSep := fltTotDocSep + fField('CTR_VALREC').AsFloat
        Else
           fltTotDocSep := fltTotDocSep + fField('CTR_VALORI').AsFloat;

        fltTotJurSep := fltTotJurSep + fField('CTR_VALJUR').AsFloat;
        fltTotDesSep := fltTotDesSep + fField('CTR_VALDES').AsFloat;

      End;

      cdsCtaRec.Next;
    End;

    cdsCtaRec.First;
    While (Not cdsCtaRec.Eof) Do
    Begin

      If (fField('CTR_MARDES').AsString = 'M') And (fEmptyStr(strPriCli)) Then
      Begin
        strPriCli := fField('CTR_CODCLI').AsString;
        bkmPosGri := cdsCtaRec.GetBookmark;
        Break;
      End;

      cdsCtaRec.Next;
    End;

    cdsCtaRec.First;

    If Not dicBaixa['blnConfirma'] Then
    Begin
      cdsChqPre.EmptyDataSet;
      cdsChqVis.EmptyDataSet;
      Self.Enabled := True;
      Exit;
    End;

    {*************************************************}
    {* DEVE SER CHAMADO ANTES DA TRANSACAO PRINCIPAL *}
    {*********************************************JC**}
    intSeqCon := StrToInt(fRetRcxCon);

    {*************************************************}
    {* DEVE SER CHAMADO ANTES DA TRANSACAO PRINCIPAL *}
    {*********************************************JC**}
    fRetSequencialMovCar('MOVCAR', VS_strCodEmp, arrCartoes);

    LRecebidoPorPix := IIF(dicBaixa['RecebidoPixAvulso'], 'S', 'N');
    If Assigned(FObjetoPixRecebimento) Then
    Begin
      If TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(FObjetoPixRecebimento) Then
        LRecebidoPorPix := 'S';
    End;

    fStartTransaction;

    Try

      Result := True;

      With cdsCtaRec Do
      Begin

        If Not blnBaiAna Then
        Begin
          If fltTotCx <> 0.0 Then
          Begin

            If blnBaiUtl Then
              dtaDtaLan := fAcertaDataParaDiaUtil(StrToDate(strDtaLan)+intDCrRecPor1)
            Else
              dtaDtaLan := StrToDate(strDtaLan)+intDCrRecPor1;

            strCreDeb := IIF(fltTotCx > 0, 'C', 'D');
            fltTotCx  := IIF(fltTotCx > 0, fltTotCx, -fltTotCx);

            If (fCfgSis('JURSEP') = 'N') Then
            Begin

                strSeqLan := fGravaMovBan(strCtaBai,                          // Centro de Custo
                                          strPorBai,                          // Portador da Baixa
                                          strLoginUsuarioLogado,              // Operador da Baixa
                                          dtaDtaLan, // Data do Lançamento
                                          fTime(),                            // Hora do Lançamento
                                          strDocBai,                          // Numero do Documento
                                          strCreDeb,                          // Credito / Debito
                                          VS_strCodEmp,                       // Empresa da Baixa
                                          fltTotCx,                           // Valor Do Lançamento
                                          strHisBai,                          // Histórico 1
                                          strHist02,                                 // Histórico 2
                                          '',                                 // Cliente da Duplicata
                                          '',                                 // Fornecedor da Duplicata
                                          '',                                 // Número da Duplicata
                                          0,                                  // Sequencial de Baixa
                                          '',                                 // Parcela da Duplicata
                                          '',                                 // Empresa da Duplicata
                                          '',                                 // Série
                                          '',                                 // Codigo do Evento
                                          '',                                 // Documento Bancário
                                          lstBanCtr.fGetList                  // Log Bancário
                                         );

            End
            Else
            Begin

              // *** VERIFICA SE OS PLANOS DE CONTAS ESTÃO CONFIGURADOS NAS CGFS ***
              If Not fVerificaPlanoContasSeparacaoJurosDesconto() Then
              Begin
                 Result := False;
                 Exit;
              End;

              strSeqLan := fGravaMovBanValoresSeparados( FCloneDatasetMarcados,
                                                         strCtaBai,                                   // Centro de Custo
                                                         strPorBai,                                   // Portador da Baixa
                                                         strLoginUsuarioLogado,                       // Operador da Baixa
                                                         dtaDtaLan,                                   // Data do Lançamento
                                                         fTime(),                                     // Hora do Lançamento
                                                         strDocBai,                                   // Numero do Documento
                                                         strCreDeb,                                   // Credito / Debito
                                                         VS_strCodEmp,                                // Empresa da Baixa
                                                         fltTotCx,                                    // Valor Do Lançamento
                                                         '',                                          // Histórico 1
                                                         strHist02,                                   // Histórico 2
                                                         strHisBai,                                   // Histórico de Baixa
                                                         '',                                          // Cliente da Duplicata
                                                         '',                                          // Fornecedor da Duplicata
                                                         '',                                          // Número da Duplicata
                                                         0,                                           // Sequencial de Baixa
                                                         '',                                          // Parcela da Duplicata
                                                         '',                                          // Empresa da Duplicata
                                                         '',                                          // Série
                                                         '',                                          // Codigo do Evento
                                                         '',                                          // Documento da Baixa
                                                         '',                                          // Especie do Documento
                                                         fltTotDocSep,                                // Valor Original
                                                         fltTotJurSep,                                // Valor Juros
                                                         fltTotDesSep,                                // Valor Desconto
                                                         0,
                                                         '',                                          // Autoincrem
                                                         ''                                           // tipo da baixa - parcial ou total;
                                                        );

            End;

            If (fEmptyStr(strSeqLan)) Then
            Begin
              Result := False;

              cdsChqPre.EmptyDataSet;
              cdsChqVis.EmptyDataSet;

              fRollback;

              fMensagem('','Não foi possível gravar o movimento bancário.' +#13+#10+
                           'Verifique se o portador informado é válido e ' +#13+#10+
                           'se a data do saldo inicial deste é igual ou '  +#13+#10+
                           'posterior à data de lançamento informada.', ['&Ok']);

              blnMostrarMsgRecibo := False;

              Exit;
            End;

            If Not (fEmptyStr(strSeqLan)) Then
            Begin
              If (fltValorBaixa <> 0) and (strCodPorFix <> '') then
              Begin
                SetLength(arrSeqLan, Length(arrSeqLan) + 1);
                arrSeqLan[Length(arrSeqLan)-1] := strSeqLan;
              End;
            End;

            recUltDupBaixada.strSeqLan := strSeqLan;
            recUltDupBaixada.strCodCta := strCtaBai;
            recUltDupBaixada.strPagCon := IntToStr(0);
            recUltDupBaixada.strPagCta := IntToStr(0) + strCtaBai;
          End;
        End;

        LDesmembrarBaixaReceber := TDesmembraBaixaReceber.Create;

        First;
        pgbProgresso.Position := 0;
        pgbProgresso.Properties.Max := RecordCount;
        cdsCtaRec.AfterScroll    := Nil;
        While Not Eof Do
        Begin
          pStepStatusSelecao(pgbProgresso);
          If FieldByName('CTR_MARDES').AsString = 'M' Then
          Begin

            If FieldByName('CTR_TIPBAI').AsString = 'T' Then
            Begin

              LValorDuplicata := fFormataFloat(fField('CTR_VALDUP').AsCurrency,2);
              LValorEsperadoDuplicata := fFormataFloat(fField('CTR_VALREC').AsCurrency, 2);

              if fFormataFloat(fField('CTR_VALJUR').AsCurrency,2) <> 0 then
                LValorEsperadoDuplicata := LValorEsperadoDuplicata - fFormataFloat(fField('CTR_VALJUR').AsCurrency, 2);

              if fFormataFloat(fField('CTR_DESCOB').AsCurrency, 2) <> 0 then
                LValorEsperadoDuplicata := LValorEsperadoDuplicata - fFormataFloat(fField('CTR_DESCOB').AsCurrency, 2);

              if fFormataFloat(fField('CTR_VALDES').AsCurrency, 2) <> 0 then
                LValorEsperadoDuplicata := LValorEsperadoDuplicata + fFormataFloat(fField('CTR_VALDES').AsCurrency, 2);

              If LValorDuplicata <> LValorEsperadoDuplicata Then
              Begin
                cdsChqPre.EmptyDataSet;
                cdsChqVis.EmptyDataSet;

                fRollback;

                fMensagem('AVISO','Valor recebido considerado juros e desconto está divergente ao valor do título. '+#13+#10
                                 +'Verifique a duplicata: ' + fField('CTR_NUMDUP').AsString +#13+#10
                                 +'Valor esperado: ' + FloatToStr(LValorDuplicata) +#13+#10
                                 +'Valor encontrado: ' + FloatToStr(LValorEsperadoDuplicata) , ['&Ok']);

                Exit;
              End;
            End;

            // Armazena na variavel se teve alteração/ inclusão/ remoção da desp. de cobrança;
            blnDescCobFoiAlterada := fVerificaAlteracaoDespesaCobranca(
              cdsCtaRec.FieldByName('AUTOINCREM').AsString,
              cdsCtaRec.FieldByName('CTR_DESCOB').AsFloat );

            strHisCar := strHisCar + FieldByName('NRODUP').AsString +
                                     FieldByName('PARDUP').AsString + '-' +
                                     FieldByName('CTR_ESPDOC').AsString + '-' +
                                     FieldByName('CTR_CODEMP').AsString + '/';
            If blnBaiAna Then
            Begin

              If (dicBaixa['blnHisAut']) Or (fCfgSis('CTRHIS') = '1') Then
                strHisBai := 'Rec. ' +
                  {*************************************************************}
                  {* COMENTEI A LINHA ABAIXO POIS fField('CTR_NOMCLI').AsSring *}
                  {* JÁ ESTÁ TRAZENDO O CÓDIGO DO CLIENTE NA FRENTE DO NOME    *}
                  {*********************************09/03/2018**Req. 66000**WS**}
//                             fField('CTR_CODCLI').AsString + ' - ' +
                             fField('CLI_NOMCLI').AsString;

              If FieldByName('CTR_VALREC').AsFloat < 0 Then
              Begin
                fltValRec := -FieldByName('CTR_VALREC').AsFloat; // Valor negativo
                strCreDeb := 'D';
              End
              Else
              Begin
                fltValRec := FieldByName('CTR_VALREC').AsFloat;
                strCreDeb := 'C';
              End;

              intSeqBai := fRetSeqBaiCadRec(FieldByName('NRODUP').AsString,
                                            FieldByName('PARDUP').AsString,
                                            FieldByName('CTR_CODEMP').AsString,
                                            FieldByName('CTR_ESPDOC').AsString,
                                            FieldByName('CTR_CODCLI').AsString);
              Inc(intQtdDup);

              intDCrRec := intDCrRecPor1;

              If fltValRec <> 0.0 Then
              Begin
                lstBanCtr.pClear;
                lstBanCtr.fAdd(FieldByName('NRODUP').AsString,
                               FieldByName('PARDUP').AsString,
                               FieldByName('CTR_ESPDOC').AsString,
                               FieldByName('CTR_CODEMP').AsString,
                               FieldByName('CTR_CODCLI').AsString,
                               FieldByName('CTR_HIST01').AsString,
                               FieldByName('CTR_HIST02').AsString,
                               FieldByName('CTR_SEQBAI').AsInteger,
                               fltValRec,
                               FieldByName('CTR_VALJUR').AsFloat,
                               FieldByName('CTR_VALDES').AsFloat,
                               FieldByName('CTR_VALDUP').AsFloat);

                If blnBaiUtl Then
                  dtaDtaLan := fAcertaDataParaDiaUtil(FieldByName('CTR_DTAREC').AsDateTime + intDCrRecPor1)
                Else
                  dtaDtaLan := FieldByName('CTR_DTAREC').AsDateTime + intDCrRecPor1;

                If (fCfgSis('JURSEP') = 'N') Then
                Begin

                  strSeqLan := fGravaMovBan(strCtaBai,                                        // Centro de Custo
                                            strPorBai,                                        // Portador da Baixa
                                            strLoginUsuarioLogado,                            // Operador da Baixa
                                            dtaDtaLan, // Data do Lançamento
                                            fTime(),                                          // Hora do Lançamento
                                            FieldByName('CTR_NUMDUP').AsString,               // Numero do Documento
                                            strCreDeb,                                        // Credito / Debito
                                            VS_strCodEmp,                                     // Empresa da Baixa
                                            fltValRec,                                        // Valor Do Lançamento
                                            strHisBai,                                        // Histórico 1
                                            strHist02,                                               // Histórico 2
                                            FieldByName('CTR_CODCLI').AsString,               // Cliente da Duplicata
                                            '',                                               // Fornecedor da Duplicata
                                            FieldByName('NRODUP').AsString,                   // Número da Duplicata
                                            intSeqBai + 1,                                    // Sequencial de Baixa
                                            FieldByName('PARDUP').AsString,                   // Parcela da Duplicata
                                            FieldByName('CTR_CODEMP').AsString,               // Empresa da Duplicata
                                            '',                                               // Série
                                            //'',                                             // Sequencial de Lançamento
                                            FieldByName('CTR_CODEVE').AsString,               // Codigo do Evento
                                            '',                                               // Documento da Baixa
                                            lstBanCtr.fGetList                                // Log Bancário
                                           );

                End
                Else
                Begin

                  // *** VERIFICA SE OS PLANOS DE CONTAS ESTÃO CONFIGURADOS NAS CGFS ***
                  If Not fVerificaPlanoContasSeparacaoJurosDesconto() Then
                  Begin
                     Result := False;
                     Exit;
                  End;

                  strSeqLan := fGravaMovBanValoresSeparados( Nil,
                                                             strCtaBai,                                   // Centro de Custo
                                                             strPorBai,                                   // Portador da Baixa
                                                             strLoginUsuarioLogado,                       // Operador da Baixa
                                                             dtaDtaLan,                                   // Data do Lançamento
                                                             fTime(),                                     // Hora do Lançamento
                                                             FieldByName('CTR_NUMDUP').AsString,          // Numero do Documento
                                                             strCreDeb,                                   // Credito / Debito
                                                             VS_strCodEmp,                                // Empresa da Baixa
                                                             fltValRec,                                   // Valor Do Lançamento
                                                             FieldByName('CTR_HIST01').AsString,          // Histórico 1
                                                             strHist02,                                   // Histórico 2
                                                             strHisBai,                                   // Histórico de Baixa
                                                             FieldByName('CTR_CODCLI').AsString,          // Cliente da Duplicata
                                                             '',                                          // Fornecedor da Duplicata
                                                             FieldByName('NRODUP').AsString,              // Número da Duplicata
                                                             intSeqBai + 1,                               // Sequencial de Baixa
                                                             FieldByName('PARDUP').AsString,              // Parcela da Duplicata
                                                             FieldByName('CTR_CODEMP').AsString,          // Empresa da Duplicata
                                                             '',                                          // Série
                                                             FieldByName('CTR_CODEVE').AsString,          // Codigo do Evento
                                                             '',                                          // Documento da Baixa
                                                             FieldByName('CTR_ESPDOC').AsString,          // Especie do Documento
                                                             FieldByName('CTR_VALORI').AsFloat,           // Valor Original
                                                             FieldByName('CTR_VALJUR').AsFloat,           // Valor Juros
                                                             FieldByName('CTR_VALDES').AsFloat,           // Valor Desconto
                                                             FieldByName('CTR_VALDUP').AsFloat,           // Valor Duplicata
                                                             FieldByName('AUTOINCREM').AsString,          // Autoincrem
                                                             FieldByName('CTR_TIPBAI').AsString           // tipo da baixa - parcial ou total;
                                                            );

                End;

                If (fEmptyStr(strSeqLan)) Then
                Begin
                  Result := False;

                  cdsChqPre.EmptyDataSet;
                  cdsChqVis.EmptyDataSet;

                  fRollback;

                  fMensagem('','Não foi possível gravar o movimento bancário.' +#13+#10+
                               'Verifique se o portador informado é válido e ' +#13+#10+
                               'se a data do saldo inicial deste é igual ou '  +#13+#10+
                               'posterior à data de lançamento informada.', ['&Ok']);

                  blnMostrarMsgRecibo := False;

                  Exit;
                End;

                If Not (fEmptyStr(strSeqLan)) Then
                Begin
                  If (fltValorBaixa <> 0) and (strCodPorFix <> '') then
                  Begin
                    SetLength(arrSeqLan, Length(arrSeqLan) + 1);
                    arrSeqLan[Length(arrSeqLan)-1] := strSeqLan;
                  End;
                End;

                recUltDupBaixada.strSeqLan := strSeqLan;
                recUltDupBaixada.strCodCta := strCtaBai;
                recUltDupBaixada.strPagCon := IntToStr(0);
                recUltDupBaixada.strPagCta := IntToStr(0) + strCtaBai;
              End;
            End;

            If FieldByName('CTR_TIPBAI').AsString = 'T' Then
            Begin
              pRateiaVariaveisModalidades;

              blnGraVDp := fFormataFloat(fltValCqV + fltValCqP + fltValDin + fltValCar + fltValOrd + fltValFin, 2) <= 0;

              If Not blnGraVDp Then
                pGravaRateio(cdsRateio,
                             0,
                             FieldByName('NRODUP').AsString, FieldByName('PARDUP').AsString,
                             FieldByName('CTR_ESPDOC').AsString, FieldByName('CTR_CODEMP').AsString,
                             FieldByName('CTR_CODCLI').AsString, FieldByName('CTR_VALREC').AsFloat,
                             fltValDin - fltValCre, fltValCqV, fltValCqP, fltValCar, fltValOrd, fltValFin);


              Result := fBaixaTotal(fField('NRODUP').AsString,       // Duplicata
                                    fField('PARDUP').AsString,       // Parcela
                                    fField('CTR_ESPDOC').AsString,   // Espécie
                                    fField('CTR_CODEMP').AsString,   // Empresa
                                    fField('CTR_CODCLI').AsString,   // Cliente
                                    fField('CTR_VALDUP').AsFloat,    // Valor da Duplicata
                                    fField('CTR_VALREC').AsFloat,    // Valor Recebido
                                    fField('CTR_VALJUR').AsFloat,    // Valor de Juros
                                    fField('CTR_VALDES').AsFloat,    // Valor de Desconto
                                    fltAuxCqP,                                      // Valor de CHQ VISTA (rateado)
                                    fltAuxCqV,                                      // Valor de CHQ PRAZO (rateado)
                                    IIF((fltAuxDin < 0) Or (blnGraVDp), fField('CTR_VALREC').AsFloat, fltAuxDin), // Valor de dinheiro (rateado)
                                    fltAuxCar,                                      // Valor de cartao (rateado)
                                    fltAuxOrd,                                      // Valor da Ordem de Pagamento (rateado)
                                    fltAuxFin,
                                    fField('CTR_DTAREC').AsDateTime, // Data de Recebimento
                                    strSeqLan,                                      // Sequencial de Lancamento(MOVBAN)
                                    strHisBai,                                      // Histórico da Baixa
                                    strCtaBai,                                      // Coentro de Custo
                                    strPorBai,                                      // Portador da Baixa
                                    strLoginUsuarioLogado,                          // Operador da Baixa
                                    StrToInt(strSeqMod),
                                    blnValCqP,
                                    blnValCqV,
                                    IIF(blnGraVDp, True, blnValDin),
                                    blnValCar,
                                    blnValOrd,
                                    blnValFin,
                                    0,                                          // Recebido pelo res. caixa?
                                    intSeqCon,                                   // Sequencial de Controle
                                    dtaDtaLan,
                                    fField('CTR_RECAUT').AsString,
                                    '',
                                    '',
                                    '',
                                    '',
                                    False,
                                    {**Req. 86252**16/04/2018**WS**}
                                    fField('CTR_DESCOB').AsFloat,    // Valor de Despesa de Cobrança
                                    'S',
                                    LRecebidoPorPix);

              strDocume := FieldByName('NRODUP').AsString + '-' +
                           FieldByName('PARDUP').AsString + '-' +
                           FieldByName('CTR_ESPDOC').AsString + '-' +
                           FieldByName('CTR_CODEMP').AsString + '-' +
                           fStrZero(intSeqBai,3);

              If VS_strHabilitarCRM And (Not fEmptyStr(fCfgSis('OCOFIN', varString)))  Then
              Begin
                TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(fField('NRODUP').AsString,
                                                         fField('CTR_ESPDOC').AsString,
                                                         fField('CTR_CODEMP').AsString,
                                                         fField('CTR_CODCLI').AsString,
                                                         fField('PARDUP').AsString,
                                                         strLoginUsuarioLogado,
                                                         fRetCgcCpf(fField('CTR_CODCLI').AsString),
                                                         afcBaixaTotal, True);
              End;

              If Not fCfgSis('PERHBD', VarBoolean) Then
                BaixaAutomaticaAgendamentosEmAberto(fField('NRODUP').AsString,
                                                    fField('CTR_ESPDOC').AsString,
                                                    fField('CTR_CODEMP').AsString,
                                                    fField('CTR_CODCLI').AsString,
                                                    fField('PARDUP').AsString);


              If fApagarBoletoDeAdiantamentoPedido() Then
              Begin
                fApagaDuplicataContasReceber(cdsCtaRec,'AUTBAN: BAIXA DUPLICATA/INCLUSAO DE ADIANTAMENTO (REMESSA AUTOMATICA - BOLETO DE ADIANTAMENTO)');

                FillChar(documento, SizeOf(documento), #0);
                FillChar(dadosAdiantamento, SizeOf(dadosAdiantamento), #0);

                documento.strNumDoc := cdsCtaRec.FieldByName('NRODUP').AsString;
                documento.strEspDoc := cdsCtaRec.FieldByName('CTR_ESPDOC').AsString;
                documento.strCodEmp := cdsCtaRec.FieldByName('CTR_CODEMP').AsString;
                documento.strCodCli := cdsCtaRec.FieldByName('CTR_CODCLI').AsString;
                documento.fltValLan := cdsCtaRec.FieldByName('CTR_VALREC').AsFloat;

                documento.fltValLan := IIF(documento.fltValLan > cdsCtaRec.FieldByName('CTR_VALDUP').AsFloat,
                                           cdsCtaRec.FieldByName('CTR_VALDUP').AsFloat,
                                           documento.fltValLan);

                dadosAdiantamento.AddDocumento(documento);

                dadosAdiantamento.strDescri :=
                  'AUTBAN: BAIXA DUPLICATA/INCLUSAO DE ADIANTAMENTO ' + fInfDup('NRODUP', 'Docto.') +
                                                                        fInfDup('CTR_ESPDOC', 'Esp.') +
                                                                        fInfDup('PARDUP', 'Parc.') +
                                                                        fInfDup('CTR_CODEMP', 'Emp.') +
                                                                        fInfDup('CTR_NOSNUM', 'Nosso Nº') +
                                                                        fInfDup('CTR_DTABOL', 'Emiss.') +
                                                                        fInfDup('CTR_BCOBOL', 'Banco') +
                                                                        fInfDup('CTR_CARTEI', 'Cartei.') +
                                                                        fInfDup('CTR_BCOENV', 'Bco Envio') +
                                                                        fInfDup('CTR_DTAENV', 'Dta Envio') +
                                                                        fInfDup('CTR_LINDIG', 'Lin.Digit.');

                dadosAdiantamento.strParcel := cdsCtaRec.FieldByName('PARDUP').AsString;
                dadosAdiantamento.strNosNum := cdsCtaRec.FieldByName('CTR_NOSNUM').AsString;
                dadosAdiantamento.strDtaBol := cdsCtaRec.FieldByName('CTR_DTABOL').AsString;
                dadosAdiantamento.strBcoBol := cdsCtaRec.FieldByName('CTR_BCOBOL').AsString;
                dadosAdiantamento.strBcoEnv := cdsCtaRec.FieldByName('CTR_BCOENV').AsString;
                dadosAdiantamento.strDtaEnv := cdsCtaRec.FieldByName('CTR_DTAENV').AsString;
                dadosAdiantamento.strCartei := cdsCtaRec.FieldByName('CTR_CARTEI').AsString;
                dadosAdiantamento.strLinDig := cdsCtaRec.FieldByName('CTR_LINDIG').AsString;
                dadosAdiantamento.strCodCed := cdsCtaRec.FieldByName('CTR_CODCED').AsString;
                dadosAdiantamento.strOrigem := 'CTR';
                dadosAdiantamento.strTipLan := 'C';
                dadosAdiantamento.dtaDtaLan := VS_Date;
                dadosAdiantamento.horHorLan := fTime();
                dadosAdiantamento.strCodPor := strPorBai;
                dadosAdiantamento.strCodCta := strCtaBai;
                dadosAdiantamento.strOpeLan := strLoginUsuarioLogado;
                dadosAdiantamento.strEmpLan := VS_strCodEmp;
                dadosAdiantamento.intSeqCon := intSeqCon;
                dadosAdiantamento.fltValDin := IIF((fltValDin < 0) Or (blnGraVDp), fField('CTR_VALREC').AsFloat, fltAuxDin);
                dadosAdiantamento.fltValChV := fltAuxCqV;
                dadosAdiantamento.fltValChP := fltAuxCqP;
                dadosAdiantamento.fltValCar := fltAuxCar;
                dadosAdiantamento.fltValOrd := fltAuxOrd;
                dadosAdiantamento.fltValCre := 0.00;
                dadosAdiantamento.fltValLan := documento.fltValLan;
                dadosAdiantamento.RecebidoPorPix := LRecebidoPorPix = 'S';

                TAdiantamentoGenerico.fGravaAdiantamentoCliente(dadosAdiantamento);

                TAdiantamentoGenerico.pAtualizaValorBoletosAdiantamentoDoPedido(documento.strNumDoc,
                  documento.strEspDoc, documento.strCodEmp, documento.strCodCli);
              End;


              If (Not Result) Then
              Begin
                cdsChqPre.EmptyDataSet;
                cdsChqVis.EmptyDataSet;

                fRollback;

                Exit;
              End;

            End
            Else
            Begin

              fltNovoValDup := fField('VALORNOVADUPLICATA').AsFloat;

              fltNovoValOri := (fField('CTR_VALDUP').AsFloat);

              fltDifOri := fField('CTR_CALORI').AsFloat;


              If blnDescFinanSomenteAteVenc Then
              Begin
                If (fField('CTR_DTAREC').AsDateTime <= fField('CTR_DTAVEN').AsDateTime +
                                                                      fField('CTR_QTDDAV').AsInteger) Then
                  fltDifOri := fltDifOri - (fField('CTR_VALDUP').AsFloat +
                                            fField('CTR_JURSUJ').AsFloat +
                                            fField('CTR_DESCOB').AsFloat -
                                            fField('CTR_DESSUJ').AsFloat)
                Else
                  fltDifOri := fltDifOri - (fField('CTR_VALDUP').AsFloat +
                                            fField('CTR_JURSUJ').AsFloat +
                                            fField('CTR_DESCOB').AsFloat );
              End
              Else
                fltDifOri := fltDifOri - (fField('CTR_VALDUP').AsFloat +
                                          fField('CTR_JURSUJ').AsFloat +
                                          fField('CTR_DESCOB').AsFloat -
                                          fField('CTR_DESSUJ').AsFloat);

              If fField('CTR_VALCAL').AsFloat < 0 Then
                fltDifOri := 0;

              strManVen := fCfgSis('MANVEN');

              If (fField('CTR_DTAVEN').AsDateTime > VS_Date) Then
                dtaDtaVen := fField('CTR_DTAVEN').AsDateTime
              Else
              Begin
                If (strManVen = 'S') Then
                  dtaDtaVen := fField('CTR_DTAVEN').AsDateTime
                Else
                  dtaDtaVen := fField('CTR_DTAREC').AsDateTime;
              End;

              pRateiaVariaveisModalidades;

              blnGraVDp := fFormataFloat(fltValCqV + fltValCqP + fltValDin + fltValCar + fltValOrd + fltValFin, 2) <= 0;

              If Result Then
                Result := fBaixaParcial(fField('NRODUP').AsString,        // Duplicata
                                        fField('PARDUP').AsString,        // Parcela
                                        fField('CTR_CODEMP').AsString,    // Empresa
                                        fField('CTR_ESPDOC').AsString,    // Espécie
                                        fField('CTR_CODCLI').AsString,    // Cliente
                                        fField('CTR_VALREC').AsFloat,     // Valor Recebido
                                        fField('CTR_VALJUR').AsFloat,     // Valor do Juros
                                        fField('CTR_VALDES').AsFloat,     // Valor do Desconto
                                        fField('CTR_DTAREC').AsDateTime,  // Data do Recebimento
                                        dtaDtaVen,                                                        // Data de Vencimento
                                        strPorBai,                                                        // Portador de Baixa
                                        strHisBai,                                                        // Histórico de Baixa
                                        strCtaBai,                                                        // Centro de Custo da Baixa
                                        strLoginUsuarioLogado,                                            // Operador da Baixa
                                        strSeqLan,                                                        // Sequencial de Lancamento (MOVBAN)
                                        fltNovoValOri,                                                    // Novo Valor Original
                                        fltNovoValDup,                                                    // Novo Valor da Duplicata
                                        fltAuxCqP,                                                        // Valor de CHQ VISTA
                                        fltAuxCqV,                                                        // Valor de CHQ PRAZO
                                        IIF((fltValDin < 0) Or (blnGraVDp), FieldByName('CTR_VALREC').AsFloat, fltAuxDin),                                                        // Valor de dinheiro
                                        fltAuxCar,                                                        // Valor de cartao
                                        fltAuxOrd,                                                        // Valor da ordem de pagamento
                                        fltAuxFin,
                                        0,                                                                // Veio do Resumo de Caixa?
                                        StrToInt(strSeqMod),
                                        blnValCqP,
                                        blnValCqV,
                                        IIF(blnGraVDp, True, blnValDin),
                                        blnValCar,
                                        blnValOrd,
                                        blnValFin,
                                        intSeqPar,
                                        strAutIncNov,
                                        intSeqCon,                                                       // Sequencial de Controle
                                        fField('CTR_VALIPI').AsFloat,
                                        fField('CTR_VALRET').AsFloat,
                                        fField('CTR_VALACE').AsFloat,
                                        fField('CTR_VALFRE').AsFloat,
                                        fField('CTR_VALFCP').AsFloat,
                                        fltDifOri,
                                        dtaDtaLan,
                                        fField('VALORBAIXADUPLICATA').AsFloat,
                                        fField('JUROSNOVADUPLICATA').AsFloat,
                                        fField('FATORBAIXADUPLICATA').AsFloat,
                                        fField('FATORJUROSDUPLICATA').AsFloat,
                                        fField('DESCONTONOVADUPLICATA').AsFloat,
                                        fField('CTR_CALORI').AsFloat,
                                        fField('CTR_RECAUT').AsString,
                                        '',
                                        untCadrec.fGetValOriDuplicata(fField('NRODUP').AsString,
                                                                      fField('CTR_ESPDOC').AsString,
                                                                      fField('CTR_CODEMP').AsString,
                                                                      fField('PARDUP').AsString,
                                                                      fField('CTR_CODCLI').AsString),
                                        '',
                                        '',
                                        '',
                                        LRecebidoPorPix,
                                        fField('DESPESASBAIXADUPLICATA').AsFloat,
                                        fField('DESPESASNOVADUPLICATA').AsFloat,
                                        fField('CTR_VALCBS').AsFloat,
                                        fField('CTR_VALIBS').AsFloat,
                                        fField('CTR_VAL_IS').AsFloat);

              If VS_strHabilitarCRM And (Not fEmptyStr(fCfgSis('OCOFIN', varString)))  Then
              Begin
                TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(fField('NRODUP').AsString,
                                                         fField('CTR_ESPDOC').AsString,
                                                         fField('CTR_CODEMP').AsString,
                                                         fField('CTR_CODCLI').AsString,
                                                         fField('PARDUP').AsString,
                                                         strLoginUsuarioLogado,
                                                         fRetCgcCpf(fField('CTR_CODCLI').AsString),
                                                         afcBaixaParcial,
                                                         False,
                                                         False,
                                                         False,
                                                         '',
                                                         fField('VALORBAIXADUPLICATA').AsFloat
                                                         );
              End;

              If Not blnGraVDp Then
                pGravaRateio(cdsRateio,
                             intSeqPar,
                             FieldByName('NRODUP').AsString, FieldByName('PARDUP').AsString,
                             FieldByName('CTR_ESPDOC').AsString, FieldByName('CTR_CODEMP').AsString,
                             FieldByName('CTR_CODCLI').AsString, FieldByName('CTR_VALREC').AsFloat,
                             //IIF(fltValDin < 0, FieldByName('CTR_VALREC').AsFloat, fltValDin), fltValCqV, fltValCqP, fltValCar, fltValOrd, fltValFin);
                             fltValDin - fltValCre, fltValCqV, fltValCqP, fltValCar, fltValOrd, fltValFin);

              strDocume := FieldByName('NRODUP').AsString + '-' +
                           FieldByName('PARDUP').AsString + '-' +
                           FieldByName('CTR_ESPDOC').AsString + '-' +
                           FieldByName('CTR_CODEMP').AsString + '-' +
                           fStrZero(intSeqPar,3);

              If (Not Result) Then
              Begin
                cdsChqPre.EmptyDataSet;
                cdsChqVis.EmptyDataSet;

                fRollback;

                Exit;
              End;

            End;

            If Assigned(objProrrogacao) Then
            Begin
              If (fField('CTR_MARDES').AsString = 'M') And (fField('CTR_DTAVEN').AsDateTime < VS_DATE) Then
              Begin
                objProrrogacao.pAdicionarDuplicataNoArrayProrrogacao(cdsCtaRec,cdsCtaRec.RecNo);
              End;
            End;

            {****************}
            {* GRAVA LOGCTR *}
            {*************JS*}
            If Result Then
            Begin
              LFormularioBaixa := Self.Name + IIF(fEmptyStr(strMarcacaoLog), '', ' [' + strMarcacaoLog + ']');
              If dicBaixa['RecebidoPorBoleto'] Then
                LFormularioBaixa := 'frmPrincipal';

              If blnDescCobFoiAlterada Then
              Begin
                pGravaLogCtr(FieldByName('NRODUP').AsString,
                             FieldByName('CTR_ESPDOC').AsString,
                             FieldByName('CTR_CODCLI').AsString,
                             FieldByName('CTR_CODEMP').AsString,
                             FieldByName('PARDUP').AsString,
                             0,
                             'ALTERAÇÃO DE DESP. COBRANÇA',
                             Self.Name,
                             FieldByName('CTR_DESCOB').AsFloat);
              End;

              Inc(LContadorLog);
              SetLength(LArrayGravacaoLog, LContadorLog);
              LArrayGravacaoLog[LContadorLog - 1].AutoIncremCtr := cdsCtaRec.FieldByName('AUTOINCREM').AsString;
              LArrayGravacaoLog[LContadorLog - 1].Descricao := IIF(FieldByName('CTR_TIPBAI').AsString = 'T', 'BAIXA TOTAL ', 'BAIXA PARCIAL ');
              LArrayGravacaoLog[LContadorLog - 1].Formulario := LFormularioBaixa;

              If FieldByName('CTR_TIPBAI').AsString = 'P' Then
              Begin
                Inc(LContadorLog);
                SetLength(LArrayGravacaoLog, LContadorLog);
                LArrayGravacaoLog[LContadorLog - 1].NumeroDuplicata := cdsCtaRec.FieldByName('NRODUP').AsString;
                LArrayGravacaoLog[LContadorLog - 1].ParcelaDuplicata := cdsCtaRec.FieldByName('PARDUP').AsString;
                LArrayGravacaoLog[LContadorLog - 1].EspecieDocumento := cdsCtaRec.FieldByName('CTR_ESPDOC').AsString;
                LArrayGravacaoLog[LContadorLog - 1].CodigoEmpresa := cdsCtaRec.FieldByName('CTR_CODEMP').AsString;
                LArrayGravacaoLog[LContadorLog - 1].CodigoCliente := cdsCtaRec.FieldByName('CTR_CODCLI').AsString;
                LArrayGravacaoLog[LContadorLog - 1].SequencialBaixa := 0;
                LArrayGravacaoLog[LContadorLog - 1].Descricao := 'ALTERAÇÃO DE BAIXA';
                LArrayGravacaoLog[LContadorLog - 1].Formulario := Self.Name;
              End;
            End;

            If (Result) And (Not blnMarcouTodas) Then
            Begin

               objLogLibRec.pGravarLogLib( FieldByName('NRODUP').AsString, FieldByName('CTR_ESPDOC').AsString, FieldByName('CTR_CODEMP').AsString,'' );
            End;

            LDesmembrarBaixaReceber.AdicionarDuplicata(fField('AUTOINCREM').AsString, strSeqLan);
          End;
          // Valor de Crédito recebido.
          If FieldByName('CTR_VALREC').AsFloat < 0 Then
          Begin
            fltValCredito := fltValCredito + fField('CTR_VALREC').AsFloat;
          End;

          Next;
        End; {While Not Eof Do}

        If (Not fAcertaRateio(cdsRateio, 0, (fFormataFloat(fltTotCx,2) <= fFormataFloat((fltValCredito * -1),2)))) Then
        Begin
          cdsChqPre.EmptyDataSet;
          cdsChqVis.EmptyDataSet;

          fRollback;

          Exit;
        End;

        GravarLogCtrDuplicatas(LArrayGravacaoLog,
                               pgbProgresso);

        cdsCtaRec.GotoBookmark(bkmPosGri);
        If fFormataFloat(fltValCre,2) > 0 Then
        Begin
          If (Not fGravaCreditoCliente(fltValCre, intSeqCon)) Then
          Begin
            cdsChqPre.EmptyDataSet;
            cdsChqVis.EmptyDataSet;

            fRollback;

            Exit;
          End;
        End;

        //Aqui sera feito o desmembramento do titulo por especies de pagamento
        LDesmembrarBaixaReceber.ProcessarDesmembramentos(fltValDin,
                                                         fltValCar,
                                                         fltValCqP,
                                                         fltValCqV,
                                                         fltValOrd,
                                                         '',
                                                         fltValCre);
      End;

      FCloneDatasetMarcados.IndexFieldNames := cdsCtaRec.IndexFieldNames;
      FCloneDatasetMarcados.First;
      
      If (fCfgSis('USACTC', varBoolean)) And (Length(arrCartoes) > 0) Then
      Begin

        pgbProgresso.Position := 0;
        pgbProgresso.Properties.Max := Length(arrCartoes);

        strHisCar := Copy(strHisCar, 1, Length(strHisCar) - 1);
        If Pos('/', strHisCar) <= 0 Then
          strHisCar := 'REF. AO DOC. ' + Copy(strHisCar, 1, 250 - Length('REF. AO DOC. '))
        Else
          strHisCar := 'REF. AOS DOCS. ' + Copy(strHisCar, 1, 250 - Length('REF. AOS DOCS. '));

        For intContador := 0 To Length(arrCartoes) -1 Do
        Begin
          LTipoParcelamento := '';

          {$IFNDEF LINUX}
            LTipoParcelamento := fCampoTabela('CAR_ARRPAR', 'CADCAR', ['CAR_CODCAR'], [arrCartoes[intContador].strCodCar]);

            If (arrCartoes[intContador].strTipCar = 'POS') And (LTipoParcelamento <> 'N') Then
              objArredondaParcela := TArredondaParCartaoPos.fArredondamentoParcelas(arrCartoes[intContador].strCodCar)
            Else
              objArredondaParcela := fArredondamentoParcelas(arrCartoes[intContador].strCodCar);
          {$ELSE}
            objArredondaParcela := fArredondamentoParcelas(arrCartoes[intContador].strCodCar);
          {$ENDIF LINUX}

          Try
            LDataCadastroCartao := StrToDate(strDtaRec);
          Except
            LDataCadastroCartao := VS_Date;
          End;


          LDataBaseCartao := RetornaDataBaseCartao(LDataCadastroCartao, arrCartoes[intContador].dtaDtaTra);

          fDigDuplicVar(arrCartoes[intContador].strCndPag, 0, arrCartoes[intContador].fltValDig, False, False, False, LDataBaseCartao, False, arrDuplicata, 0, 'N', False, False, 0, objArredondaParcela);
          SetLength(arrDuplicFat, Length(arrDuplicata));

          pgbProgresso.Position := 0;
          pgbProgresso.Properties.Max := Length(arrDuplicata);
          For intContCopia := 0 To Length(arrDuplicata) - 1 Do
          Begin
            arrDuplicFat[intContCopia] := arrDuplicata[intContCopia];
            pStepStatusSelecao(pgbProgresso);
          End;

          fDigDuplicVar(arrCartoes[intContador].strCndPag, 0, arrCartoes[intContador].fltValDes, False, False, False, LDataBaseCartao, False, arrDuplicata   , 0, 'N', False, False, 0, objArredondaParcela);
          fDigDuplicVar(arrCartoes[intContador].strCndPag, 0, arrCartoes[intContador].fltValIpi, False, False, False, LDataBaseCartao, False, arrDuplicCarIpi, 0, 'N', False, False, 0, objArredondaParcela);
          fDigDuplicVar(arrCartoes[intContador].strCndPag, 0, arrCartoes[intContador].fltValRet, False, False, False, LDataBaseCartao, False, arrDuplicCarRet, 0, 'N', False, False, 0, objArredondaParcela);
          fDigDuplicVar(arrCartoes[intContador].strCndPag, 0, arrCartoes[intContador].fltValAce, False, False, False, LDataBaseCartao, False, arrDuplicCarAce, 0, 'N', False, False, 0, objArredondaParcela);
          fDigDuplicVar(arrCartoes[intContador].strCndPag, 0, arrCartoes[intContador].fltValFre, False, False, False, LDataBaseCartao, False, arrDuplicCarFre, 0, 'N', False, False, 0, objArredondaParcela);
          fDigDuplicVar(arrCartoes[intContador].strCndPag, 0, arrCartoes[intContador].fltValCbs, False, False, False, LDataBaseCartao, False, arrDuplicCarCbs, 0, 'N', False, False, 0, objArredondaParcela);
          fDigDuplicVar(arrCartoes[intContador].strCndPag, 0, arrCartoes[intContador].fltValIbs, False, False, False, LDataBaseCartao, False, arrDuplicCarIbs, 0, 'N', False, False, 0, objArredondaParcela);
          fDigDuplicVar(arrCartoes[intContador].strCndPag, 0, arrCartoes[intContador].fltVal_Is, False, False, False, LDataBaseCartao, False, arrDuplicCar_Is, 0, 'N', False, False, 0, objArredondaParcela);

          intContador2 := 0;
          pgbProgresso.Position := 0;
          pgbProgresso.Properties.Max := Length(arrDuplicata);
          While (intContador2 < Length(arrDuplicata))                 And
                (Not fEmptyStr(arrDuplicata[intContador2].strSequen)) Do
          Begin
            Result := fGravaMovCar(Self.Name,
                                   'INCLUSÃO',
                                   arrCartoes[intContador].strNumDup,
                                   FCloneDatasetMarcados.FieldByName('CTR_CODCLI').AsString,
                                   arrDuplicata[intContador2].strSequen,
                                   VS_strCodEmp,
                                   arrCartoes[intContador].strCodCar,
                                   LDataCadastroCartao,
                                   StrToDate(arrDuplicata[intContador2].dtaDtaVen),
                                   arrDuplicata[intContador2].curValor,
                                   arrDuplicata[intContador2].curValor,
                                   arrCartoes[intContador].strObsCar,
                                   strHisCar,
                                   arrCartoes[intContador].strCndPag,
                                   0,
                                   0.0,
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   arrCartoes[intContador].fltPerDes,
                                   arrDuplicFat[intContador2].curValor,
                                   arrDuplicFat[intContador2].curValor - arrDuplicata[intContador2].curValor,
                                   arrCartoes[intContador].strNumCcd,
                                   IIF(intQtdDup > 1,'DIVERSOS',strDocume),
                                   '',
                                   intSeqCon,
                                   VS_strCodEmp,
                                   strLoginUsuarioLogado,
                                   False,
                                   '',
                                   'B',
                                   '',
                                   arrCartoes[intContador].strTipCar,
                                   arrDuplicCarIpi[intContador2].curValor,
                                   arrDuplicCarRet[intContador2].curValor,
                                   arrDuplicCarAce[intContador2].curValor,
                                   arrDuplicCarFre[intContador2].curValor,
                                   arrCartoes[intContador].strNumNsu,
                                   '',
                                   arrCartoes[intContador].dtaDtaTra,
                                   0,
                                   0,
                                   0,
                                   '',
                                   False,
                                   '',
                                   '',
                                   'N',
                                   0,
                                   False,
                                   '',
                                   '',
                                   '',
                                   0,
                                   '',
                                   '',
                                   '',
                                   arrDuplicCarCbs[intContador2].curValor,
                                   arrDuplicCarIbs[intContador2].curValor,
                                   arrDuplicCar_Is[intContador2].curValor);

            Inc(intContador2);
            pStepStatusSelecao(pgbProgresso);

            If (Not Result) Then
            Begin
              fRollBack;
              SetLength(arrCartoes,0);
              FCloneDatasetMarcados.IndexFieldNames := 'AUTOINCREM';
              Exit;
            End;

          End;

        End;

        SetLength(arrCartoes,0);
      End;
      FCloneDatasetMarcados.IndexFieldNames := 'AUTOINCREM';

      If (Not cdsChqPre.IsEmpty) Or (Not cdsChqVis.IsEmpty) Then
      Begin
        pgbProgresso.Position := 0;
        pgbProgresso.Properties.Max := 1;
        Result := fGravaCheques;
        pStepStatusSelecao(pgbProgresso);

        cdsChqPre.EmptyDataSet;
        cdsChqVis.EmptyDataSet;

        If (Not Result) Then
        Begin
          fRollBack;
          Exit;
        End;

      End;

      {****************************}
      {* GRAVANDO/BAIXANDO O PIX  *}
      {*************************AJ*}
      If Assigned(FObjetoPixRecebimento) Then
      Begin
        If TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(FObjetoPixRecebimento) Then
        Begin
          FObjetoPixRecebimento.SeqConRecebimento := intSeqCon;
          FObjetoPixRecebimento.CriadoPelo := 'FINANCEIRO';
          FObjetoPixRecebimento.RecebidoPeloF11 := 'N';

          If Not FPixJaGerado Then
          Begin
            TFuncoesPixAutcom.GravarRegistroPixBaixado(FObjetoPixRecebimento,
                                                       False,
                                                       False,
                                                       strLoginUsuarioLogado,
                                                       Self.Name);

            Result := True;
          End
          Else
          Begin
            If MatchStr(TPixDao.RetornaStatusSePedidoPossuirPix(FObjetoPixRecebimento.CodigoEmpresa, FObjetoPixRecebimento.TxId), STATUS_PIX_PAGO) Then
              Raise ExceptionAutCom.Create('A cobrança Pix QRCode dessa duplicata já foi recebida pelo Autcom.' + #13 +
                                           'Recarregue-a para atualizar os dados.');

            TPixDao.Create.AtualizaDadosRetornoConcluidoPix(FObjetoPixRecebimento,
                                                            FObjetoPixRecebimento.SeqConRecebimento,
                                                            Self.Name,
                                                            True);

            Result := True;
          End;

          If (Not Result) Then
          Begin
            fRollBack;
            Exit;
          End;
        End;
      End;

      If blnMarcouTodas Then
        objLogLibRec.pGravarLogLib(fField('NRODUP').AsString, fField('CTR_ESPDOC').AsString, fField('CTR_CODEMP').AsString,'' );

      fCommit;

      blnBaixouDup := True;
      objLock.pDestravarTodos;
      If Assigned(objProrrogacao) Then
      Begin
        objProrrogacao.pInativarClientePorProrrogacao;
        objProrrogacao.pLimparArrays;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;

        cdsChqPre.EmptyDataSet;
        cdsChqVis.EmptyDataSet;

        fRollBack;
        if (Pos('não foi possível gravar a movimentação bancária', LowerCase(E.Message)) > 0) then
          fMensagem('',E.Message, ['&Ok'])
        Else If E Is ExceptionAutcom Then
          fMensagem('ATENÇÃO',E.Message, ['&Ok'])
        else
          pMensagensErro(E.Message, '');
      End;

    End;

    If blnConfirma Then
      cdsCtaRec.RecNo := intRecNoCtr;

  Finally
    blnLiberouUtiCredProf := False;
    cdsCtaRec.FreeBookMark(bkmPosGri);

    SetLength(LArrayGravacaoLog, 0);

    If Assigned(lstBanCtr) Then
      FreeAndNil(lstBanCtr);

    strMarcacaoLog := '';
    objLogLibRec.pLimpaTmpLogLib();
    blnMarcouTodas := False;

    If Assigned(LDesmembrarBaixaReceber) Then
      FreeAndNil(LDesmembrarBaixaReceber);
  End;
end;

function TfrmBaixaReceber.fRetornaTotalCliente( strCodCli: String; cdsGen : TUniClientDataSet ): Real;
 Var fltTotCli : Real;
Begin

   fltTotCli := 0;

   FCloneDatasetMarcados.First;
   while Not FCloneDatasetMarcados.Eof do
   begin
     if (strCodCli = FCloneDatasetMarcados.FieldByName('CTR_CODCLI').AsString) then
        fltTotCli := fltTotCli + FCloneDatasetMarcados.FieldByName('CTR_VALREC').AsFloat;
     FCloneDatasetMarcados.Next;
   end;

   result := fltTotCli;
End;

function TfrmBaixaReceber.fTemPermissaoFaturarSemExpedicao(pgbProgresso: TcxProgressBar): Boolean;
  Var
    objLiberacao : TLiberacao;
    objTabela : TRegistroMsgLiberaTabela;
    objLinha : TLinhaMsgLibera;
    blnDocSemExp:Boolean;
    blnListouDocumentos: Boolean;

    LNumDup,
    LEspDoc,
    LCodEmp  : String;
Begin

  LNumDup := '';
  LEspDoc := '';
  LCodEmp := '';

  objLiberacao := TLiberacao.Create;
  pgbProgresso.Position := 0;
  pgbProgresso.Properties.Max := FCloneDatasetMarcados.RecordCount;
  Result := True;

  try
    With FCloneDatasetMarcados Do
    Begin
      objLiberacao.objMsgLibera.pAddTexto('RECEBIMENTO DE DOCUMENTO COM EXPEDIÇÃO PENDENTE');
      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.objMsgLibera.pAddSeparador(105, teAutcom);
      objLiberacao.objMsgLibera.pAddTexto('RECEBIMENTO DE DOCUMENTO COM EXPEDIÇÃO PENDENTE',alCentro, teAmbos, '', 105);

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna('', 'DOCUMENTO'    , 17 , alEsquerda , teAutcom);
      objLinha.pAddColuna('', 'EMP'          , 3  , alCentro   , teAutcom);
      objLinha.pAddColuna('', 'CLIENTE'      , 41 , alEsquerda , teAutcom);
      objLinha.pAddColuna('', 'DT.VENC.'     , 9  , alCentro   , teAutcom);
      objLinha.pAddColuna('', 'DT.CAD.'      , 9  , alCentro   , teAutcom);
      objLinha.pAddColuna('', 'VR.DUPLICATA' , 13 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      blnDocSemExp := False;
      blnListouDocumentos := False;

      While Not Eof Do
      Begin
        If ((FieldByName('CTR_DTLBEX').IsNull) And
           (Pos(FieldByName('CTR_ESPDOC').AsString, ESPCTR_TRAVA) > 0)) And
           (FieldByName('CTR_ENTFUT').AsString = 'N') And
           (FieldByName('CTR_VALDUP').AsFloat >= 0) Then
        Begin
          If fVerificaCtrManual(FieldByName('NRODUP').AsString,
                                FieldByName('CTR_ESPDOC').AsString,
                                FieldByName('CTR_CODEMP').AsString,
                                FieldByName('CTR_CODCLI').AsString) Then
          Begin
            {**********************************************}
            { SOMENTE LISTAR OS DOCUMENTOS QUE ESTEJAM EM  }
            { MOVGER OU NOTGER.                            }
            {**********************************************}

            LNumDup := FCloneDatasetMarcados.FieldByName('CTR_NUMDUP').AsString;
            LEspDoc := FCloneDatasetMarcados.FieldByName('CTR_ESPDOC').AsString;
            LCodEmp := FCloneDatasetMarcados.FieldByName('CTR_CODEMP').AsString;


            objLinha := TLinhaMsgLibera.Create;
            objLinha.enuTipoLinha := tlValor;
            objLinha.pAddColuna('DOCUMENTO'    , FieldByName('NRODUP').AsString +
                                                 FieldByName('PARDUP').AsString +
                                                 FieldByName('CTR_ESPDOC').AsString                              , 17 , alEsquerda );
            objLinha.pAddColuna('EMP'          , FieldByName('CTR_CODEMP').AsString                              , 3  , alCentro   );
            objLinha.pAddColuna('CLIENTE'      , FieldByName('CTR_NOMCLI').AsString                              , 41 , alEsquerda );
            objLinha.pAddColuna('DT.VENC.'     , FormatDateTime('dd/mm/yy',FieldByName('CTR_DTAVEN').AsDateTime) , 9  , alCentro   );
            objLinha.pAddColuna('DT.CAD.'      , FormatDateTime('dd/mm/yy',FieldByName('CTR_DTACAD').AsDateTime) , 9  , alCentro   );
            objLinha.pAddColuna('VR.DUPLICATA' , FloatToStrF(FieldByName('CTR_VALDUP').AsFloat, ffNumber, 9, 2)  , 13 , alDireita  );
            objTabela.lstLinhas.Add(objLinha);
            blnDocSemExp := True;

            if not blnListouDocumentos then
              blnListouDocumentos := True;
          End;
        End;
        pStepStatusSelecao(pgbProgresso);
        Next;
      End;

      if blnListouDocumentos then
      Begin
        First;
        pgbProgresso.Position := 0;
        pgbProgresso.Properties.Max := FCloneDatasetMarcados.RecordCount;

        While Not Eof Do
        Begin
          {******************************************************}
          { CASO FOR UTILIZADO CRÉDITO, LISTAR INCLUSIVE O DOCTO }
          { DO CRÉDITO JUNTO COM OS DOCUMENTOS PAGOS             }
          {*REQ.102525***************************************CH**}

          If (Pos(FieldByName('CTR_ESPDOC').AsString, 'CC') > 0) Then
          Begin
            objLinha := TLinhaMsgLibera.Create;
            objLinha.enuTipoLinha := tlValor;
            objLinha.pAddColuna('DOCUMENTO'    , FieldByName('NRODUP').AsString +
                                                 FieldByName('PARDUP').AsString +
                                                 FieldByName('CTR_ESPDOC').AsString                              , 17 , alEsquerda );
            objLinha.pAddColuna('EMP'          , FieldByName('CTR_CODEMP').AsString                              , 3  , alCentro   );
            objLinha.pAddColuna('CLIENTE'      , fRetNomCliente(FieldByName('CTR_CODCLI').AsString)              , 41 , alEsquerda );
            objLinha.pAddColuna('DT.VENC.'     , FormatDateTime('dd/mm/yy',FieldByName('CTR_DTAVEN').AsDateTime) , 9  , alCentro   );
            objLinha.pAddColuna('DT.CAD.'      , FormatDateTime('dd/mm/yy',FieldByName('CTR_DTACAD').AsDateTime) , 9  , alCentro   );
            objLinha.pAddColuna('VR.DUPLICATA' , FloatToStrF(FieldByName('CTR_VALDUP').AsFloat, ffNumber, 9, 2)  , 13 , alDireita  );
            objTabela.lstLinhas.Add(objLinha);

            blnDocSemExp := True;
          End;
          pStepStatusSelecao(pgbProgresso);
          Next;
        End;
      End;

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
    End;

    If blnDocSemExp Then
    begin
      objLiberacao.strDirAce := 'RECCTREXPPEN';
      objLiberacao.strMsgSen := 'Permitir baixar duplicata com expedição pendente';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      Result := objLiberacao.fLibera;

      If Result Then
        objLogLibRec.pInsereLogLigTMP(objLiberacao, LNumDup,
                                                    LEspDoc,
                                                    LCodEmp);
    end
    Else
      Result := True;
  finally
    FreeAndNil(objLiberacao);
    blnResult := Result;
  end;
End;

function TfrmBaixaReceber.fUsaRotinaBoletoAdiantamento: Boolean;
begin
  Result := False;

  If fCfgSis('BOLADT', VarBoolean) Then
    Exit(True);

  If TAdiantamentoGenerico.fPedidoTemBoletoAdiantamento(
      cdsCtaRec.FieldByName('CTR_NUMDUP').AsString,
      cdsCtaRec.FieldByName('CTR_ESPDOC').AsString,
      cdsCtaRec.FieldByName('CTR_CODEMP').AsString) Then
    Exit(True);
end;

function TfrmBaixaReceber.fUtilizaCredEmpresa(): Boolean;
  Var
    strAuxEmp: String;
begin
  Result := False;

  If Not fCfgSis('EMPORI', VarBoolean) Then
    Exit;

  Try
    FCloneDatasetMarcados.IndexFieldNames := 'CTR_CODEMP';

    strEmpCod := '';
    strAuxEmp := '';

    FCloneDatasetMarcados.First;
    While Not FCloneDatasetMarcados.Eof Do
    Begin
      If ((FCloneDatasetMarcados.FieldByName('CTR_ESPDOC').AsString = 'CC') Or (FCloneDatasetMarcados.FieldByName('CTR_VALDUP').AsFloat < 0)) And
         (VS_strCodEmp <> FCloneDatasetMarcados.FieldByName('CTR_CODEMP').AsString) Then
      Begin
        Result := True;

        If strAuxEmp <> FCloneDatasetMarcados.FieldByName('CTR_CODEMP').AsString Then
        Begin
          strEmpCod := strEmpCod + FCloneDatasetMarcados.FieldByName('CTR_CODEMP').AsString + ', ';
          strAuxEmp := FCloneDatasetMarcados.FieldByName('CTR_CODEMP').AsString;
        End;
      End;

      FCloneDatasetMarcados.Next;
    End;

    strEmpCod := Copy(strEmpCod, 1, Length(strEmpCod) - 2); // Para remover a vírgula adicional do final

  Finally
    FCloneDatasetMarcados.IndexFieldNames := 'AUTOINCREM';
  End;
end;

function TfrmBaixaReceber.fCriaClientRecibo: TUniClientDataSet;
  Var
    qryGen: TUniQuery;
    dspGen: TUniDataSetProvider;
    cdsGen: TUniClientDataSet;
    strDesHisBai,
    strDesPorbai,
    strDesOpeBai : String;
begin
  strDesHisBai := '';
  strDesPorbai := '';
  strDesOpeBai := '';

  Result := fCriaClientDatasetReciboCTR;

  cdsGen := TUniClientDataSet.Create(Self);
  With cdsGen Do
  Begin
    Data := FCloneDatasetMarcados.Data;

    IndexFieldNames := 'CTR_CODCLI';

    DisableControls;
    First;
    While Not cdsGen.Eof Do
    Begin
      If fEmptyStr(strDesPorbai) Then
      Begin
        strDesHisBai := strHisBai ;
        strDesPorbai := strPorBai + ' - ' + fRetNomPortador(strPorBai);
        strDesOpeBai := strLoginUsuarioLogado + ' - ' + fRetNomeOperador(strLoginUsuarioLogado);
      End;
      cdsGen.Next;
    End;

    First;
    While Not Eof Do
    Begin
      Result.Append;
      Result.FieldByName('NUMDOC').AsString := FieldByName('NRODUP').AsString ;
      Result.FieldByName('PARCEL').AsString := FieldByName('CTR_PARCEL').AsString ;
      Result.FieldByName('CODEMP').AsString := FieldByName('CTR_CODEMP').AsString ;
      Result.FieldByName('ESPDOC').AsString := FieldByName('CTR_ESPDOC').AsString ;
      Result.FieldByName('HIST01').AsString := FieldByName('CTR_HIST01').AsString;
      Result.FieldByName('HIST02').AsString := FieldByName('CTR_HIST02').AsString;
      Result.FieldByName('NOSNUM').AsString := FieldByName('CTR_NOSNUM').AsString;
      Result.FieldByName('DTAVEN').AsDateTime := FieldByName('CTR_DTAVEN').AsDateTime;
      Result.FieldByName('DTAREC').AsDateTime := FieldByName('CTR_DTAREC').AsDateTime;
      Result.FieldByName('HORREC').AsDateTime := fTime();
      Result.FieldByName('DTACAD').AsDateTime := FieldByName('CTR_DTACAD').AsDateTime;
      Result.FieldByName('VALDOC').AsFloat := FieldByName('CTR_VALDUP').AsFloat;
      Result.FieldByName('VALREC').AsFloat := FieldByName('CTR_VALREC').AsFloat;
      Result.FieldByName('VALORI').AsFloat := FieldByName('CTR_VALORI').AsFloat;
      Result.FieldByName('VALJUR').AsFloat := FieldByName('CTR_VALJUR').AsFloat;
      Result.FieldByName('VALCOB').AsFloat := FieldByName('CTR_VALCOB').AsFloat;
      Result.FieldByName('VALDES').AsFloat := FieldByName('CTR_VALDES').AsFloat;
      Result.FieldByName('DESCOB').AsFloat := FieldByName('CTR_DESCOB').AsFloat;
      Result.FieldByName('COBANT').AsFloat := FieldByName('CTR_DESCOB').AsFloat;
      Result.FieldByName('GRVORI').AsFloat := FieldByName('CTR_VALORI').AsFloat;
      Result.FieldByName('VALOR2').AsFloat := FieldByName('CTR_VALORI').AsFloat;
      Result.FieldByName('VALRES').AsFloat := FieldByName('CTR_VALDUP').AsFloat +
                                              FieldByName('CTR_VALJUR').AsFloat -
                                              FieldByName('CTR_VALDES').AsFloat -
                                              FieldByName('CTR_DESCOB').AsFloat -
                                              FieldByName('CTR_VALREC').AsFloat;

      Result.FieldByName('OPEBAI').AsString   := strLoginUsuarioLogado;
      Result.FieldByName('DTABAI').AsDateTime := VS_Date;

      Result.FieldByName('DESCRI').AsString   :=
                  FieldByName('CTR_CODCLI').AsString + '-' +
                  fRetNomCliente(FieldByName('CTR_CODCLI').AsString);

      Result.FieldByName('CODCTA').AsString   := FieldByName('CTR_CODCTA').AsString;
      Result.FieldByName('DESCTA').AsString   := fRetNomeConta(FieldByName('CTR_CODCTA').AsString);

      Result.FieldByName('CODCLI').AsString := FieldByName('CTR_CODCLI').AsString;
      Result.FieldByName('NOMCLI').AsString := FieldByName('CTR_NOMCLI').AsString;
      Result.FieldByName('FANSOB').AsString := FieldByName('CTR_FANSOB').AsString;
      Result.FieldByName('FONE01').AsString := FieldByName('CLI_FONE01').AsString;
      Result.FieldByName('F_A_X_').AsString := FieldByName('CLI_F_A_X_').AsString;
      Result.FieldByName('ENDERE').AsString := FieldByName('CLI_ENDERE').AsString;
      Result.FieldByName('ENDNUM').AsString := FieldByName('CLI_ENDNUM').AsString;
      Result.FieldByName('ENDCMP').AsString := FieldByName('CLI_ENDCOM').AsString;
      Result.FieldByName('BAIRRO').AsString := FieldByName('CLI_BAIRRO').AsString;
      Result.FieldByName('C_E_P_').AsString := FieldByName('CLI_C_E_P_').AsString;
      Result.FieldByName('C_G_C_').AsString := FieldByName('CLI_C_G_C_').AsString;
      Result.FieldByName('CIDADE').AsString := FieldByName('CID_NOMCID').AsString;
      Result.FieldByName('ESTADO').AsString := FieldByName('CID_ESTADO').AsString;
      Result.FieldByName('SEQBAI').AsInteger := FieldByName('CTR_SEQBAI').AsInteger;
      Result.FieldByName('SEQCON').AsInteger := intSeqCon;

      Result.FieldByName('RECPIX').AsString := IIF(dicBaixa['RecebidoPixAvulso'], 'S', 'N');
      If Assigned(FObjetoPixRecebimento) Then
      Begin
        If TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(FObjetoPixRecebimento) Then
          Result.FieldByName('RECPIX').AsString := 'S';
      End;

      Result.FieldByName('CTR_DINHEI').AsFloat  := fltValDin;
      Result.FieldByName('CTR_CHQAVI').AsFloat  := fltValCqV;
      Result.FieldByName('CTR_CHQPRE').AsFloat  := fltValCqP;
      Result.FieldByName('CTR_CARTAO').AsFloat  := fltValCar;
      Result.FieldByName('CTR_ORDPAG').AsFloat  := fltValOrd;
      Result.FieldByName('CTR_CREDITO').AsFloat := fltValCredito;
      Result.FieldByName('CTR_VALCRE').AsFloat  := fltValCli;

      Result.FieldByName('CTR_ABERTO').AsFloat :=  fRetornaReceberAberto(FieldByName('CTR_CODCLI').AsString);
      Result.FieldByName('CTR_TOTBLT').AsFloat :=  fRetornaReceberTotalBoletosEmAberto(FieldByName('CTR_CODCLI').AsString);
      Result.FieldByName('CTR_TOTCRD').AsFloat :=  fRetornaReceberTotalCrediarioEmAberto(FieldByName('CTR_CODCLI').AsString);
      Result.FieldByName('CTR_TOTCHD').AsFloat :=  fRetornaReceberTotalChequesDevolvidosEmAberto(FieldByName('CTR_CODCLI').AsString);
      Result.FieldByName('NOMCON').AsString := fRetCliConsumidor(FieldByName('CTR_CODCLI').AsString, FieldByName('NRODUP').AsString,
                                                                 FieldByName('CTR_ESPDOC').AsString, FieldByName('CTR_CODEMP').AsString);
      Result.FieldByName('TOTCLI').AsFloat  := fRetornaTotalCliente( FieldByName('CTR_CODCLI').AsString, cdsGen );
      Result.FieldByName('DESCOPEBAI').AsString :=  strDesOpeBai;
      Result.FieldByName('DESCPORBAI').AsString :=  strDesPorBai;
      Result.FieldByName('DESCHISBAI').AsString :=  strDesHisBai;

      Result.FieldByName('CTR_SALDO').AsFloat :=  fRetornaSaldoAbertoCliente(FieldByName('CTR_CODCLI').AsString);

      If dicBaixa['RecebidoPorBoleto'] Then
        Result.FieldByName('VALOR_BOLETO').AsFloat  := fltValdin
      Else
        Result.FieldByName('DINHEIRO_SEM_BOLETO').AsFloat  := fltValdin;

      Application.ProcessMessages;
      Next;
    End;
  End;

  Result.SetProvider(nil);
  FreeAndNil(dspGen);
  FreeAndNil(qryGen);
  FreeAndNil(cdsGen);
end;

function TfrmBaixaReceber.fCriaListaClientes: TStringList;
begin
  Result := TStringList.Create;

  FCloneDatasetMarcados.First;

  While Not FCloneDatasetMarcados.Eof Do
  Begin

    If Result.IndexOf(FCloneDatasetMarcados.FieldByName('CTR_CODCLI').AsString) < 0 then
      Result.Add(FCloneDatasetMarcados.FieldByName('CTR_CODCLI').AsString);

    FCloneDatasetMarcados.Next;
  End;

  FCloneDatasetMarcados.First;
end;

function TfrmBaixaReceber.fDuplicataTravada(strNumDup,
                                            strEspDoc,
                                            strCodEmp,
                                            strCodCli,
                                            strParcel: String;
                                            blnMostraInfo: Boolean = False;
                                            AExibirMensagem: Boolean = True): Boolean;
  Var
    strChaLck: String;
    strInfDup: String;
begin
  Result := False;

  strChaLck := 'CADREC' +
               strNumDup +
               strEspDoc +
               strCodEmp +
               strCodCli;

  If blnMostraInfo Then
  Begin
    strInfDup := ' - ' + strNumDup + '-' +
                         strEspDoc + '-' +
                         strCodEmp;
  End
  Else
    strInfDup := '';


  If (Not fLockedByCurrentConnection(strChaLck)) Then
  Begin
    If DuplicataJaEmUsoPorOutraEstacao(strChaLck) Or
       Not objLock.fLock_Unlock(strChaLck, True, False, False, '',True,'') Then
    Begin
      If Assigned(frmWaitWindow) Then
        frmWaitWindow.Hide;

      If AExibirMensagem Then
        fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strChaLck) + strInfDup, ['&OK']);

      Result := True;
      Exit;
    End;
  End;

  strChaLck := strChaLck + strParcel;
  If DuplicataJaEmUsoPorOutraEstacao(strChaLck) Or
     Not objLock.fLock_Unlock(strChaLck, True, False, False, '',True,'') Then
  Begin

    If Assigned(frmWaitWindow) Then
      frmWaitWindow.Hide;

    If Not fEmptyStr(strInfDup) Then
      strInfDup := strInfDup + ' Parc: ' + strParcel;

    If AExibirMensagem Then
      fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strChaLck) + strInfDup, ['&OK']);

    Result := True;
    Exit;
  End;
end;

procedure TfrmBaixaReceber.pCarregaImpostoProporcional(fltValor: Double; Out fltValIpi, fltValRet, fltValAce, fltValFre, fltValCbs, fltValIbs, fltVal_Is: Double);
  Var
    intRec: Integer;
    fltProporcao, fltValDup, fltValRec, fltTotRec, fltTotIpi, fltTotRet, fltTotAce, fltTotFre, fltTotCbs, fltTotIbs, fltTot_Is: Double;
begin
  intRec := FCloneDatasetMarcados.RecNo;

  Try
    fltTotRec := 0;
    fltTotIpi := 0;
    fltTotRet := 0;
    fltTotAce := 0;
    fltTotFre := 0;
    fltTotCbs := 0;
    fltTotIbs := 0;
    fltTot_Is := 0;

    FCloneDatasetMarcados.First;
    While Not FCloneDatasetMarcados.Eof Do
    Begin
      If FCloneDatasetMarcados.FieldByName('CTR_MARDES').AsString <> 'M' Then
      Begin
        FCloneDatasetMarcados.Next;
        Continue;
      End;

      fltTotRec := fltTotRec + FCloneDatasetMarcados.FieldByName('CTR_VALREC').AsFloat;

      fltValDup := FCloneDatasetMarcados.FieldByName('CTR_VALDUP').AsFloat;
      fltValRec := FCloneDatasetMarcados.FieldByName('CTR_VALREC').AsFloat - FCloneDatasetMarcados.FieldByName('CTR_VALJUR').AsFloat
                                                                           + FCloneDatasetMarcados.FieldByName('CTR_VALDES').AsFloat;

      If fltValDup = 0 Then
        fltProporcao := 0
      Else
        fltProporcao := fltValRec / fltValDup;

      fltTotIpi := fltTotIpi + FCloneDatasetMarcados.FieldByName('CTR_VALIPI').AsFloat * fltProporcao;
      fltTotRet := fltTotRet + FCloneDatasetMarcados.FieldByName('CTR_VALRET').AsFloat * fltProporcao;
      fltTotAce := fltTotAce + FCloneDatasetMarcados.FieldByName('CTR_VALACE').AsFloat * fltProporcao;
      fltTotFre := fltTotFre + FCloneDatasetMarcados.FieldByName('CTR_VALFRE').AsFloat * fltProporcao;
      fltTotCbs := fltTotCbs + FCloneDatasetMarcados.FieldByName('CTR_VALCBS').AsFloat * fltProporcao;
      fltTotIbs := fltTotIbs + FCloneDatasetMarcados.FieldByName('CTR_VALIBS').AsFloat * fltProporcao;
      fltTot_Is := fltTot_Is + FCloneDatasetMarcados.FieldByName('CTR_VAL_IS').AsFloat * fltProporcao;

      FCloneDatasetMarcados.Next;
    End;

    If fltTotRec = 0 Then
    Begin
      fltValIpi := 0;
      fltValRet := 0;
      fltValAce := 0;
      fltValFre := 0;
      fltValCbs := 0;
      fltValIbs := 0;
      fltVal_Is := 0;
    End
    Else
    Begin
      fltValIpi := (fltValor / fltTotRec) * fltTotIpi;
      fltValRet := (fltValor / fltTotRec) * fltTotRet;
      fltValAce := (fltValor / fltTotRec) * fltTotAce;
      fltValFre := (fltValor / fltTotRec) * fltTotFre;
      fltValCbs := (fltValor / fltTotRec) * fltTotCbs;
      fltValIbs := (fltValor / fltTotRec) * fltTotIbs;
      fltVal_Is := (fltValor / fltTotRec) * fltTot_Is;
    End;

  Finally
    FCloneDatasetMarcados.RecNo := intRec;
  End;
End;

function TfrmBaixaReceber.fGravaCheques: Boolean;
  Var
    fltValIpi, fltValRet, fltValAce, fltValFre, fltValCbs, fltValIbs, fltVal_Is: Double;
Begin
  Try
    Result := True;

    With cdsChqPre Do
    Begin
      DisableControls;
      If Assigned(cdsChqPre) And (Active) And (Not IsEmpty) Then
      Begin

        First;
        While (Not Eof) Do
        Begin
          Application.ProcessMessages;

          If untCadChq.fExisteCheque(FieldByName('CHQ_CODBCO').AsString,
                                     FieldByName('CHQ_NUMAGE').AsString,
                                     FieldByName('CHQ_CONCOR').AsString,
                                     FieldByName('CHQ_NUMCHQ').AsString) Then
          Begin
            fMensagem('ATENÇÃO!',     'O Cheque digitado de nº: ' + FieldByName('CHQ_NUMCHQ').AsString +
                                      ' já existe no cadastro. Operação cancelada.', ['&Ok']);
            Result := False;
            Exit;
          End;

          pCarregaImpostoProporcional(FieldByName('CHQ_VALCHQ').AsFloat, fltValIpi, fltValRet, fltValAce, fltValFre, fltValCbs, fltValIbs, fltVal_Is);

          Result := Result And
                    fGravaCheque(FieldByName('CHQ_CODBCO').AsString,
                                 FieldByName('CHQ_NUMAGE').AsString,
                                 FieldByName('CHQ_CONCOR').AsString,
                                 FieldByName('CHQ_NUMCHQ').AsString,
                                 FieldByName('CHQ_CODCLI').AsString,
                                 FieldByName('CHQ_NOMEMI').AsString,
                                 FieldByName('CHQ_ENDERE').AsString,
                                 FieldByName('CHQ_TELEMI').AsString,
                                 FieldByName('CHQ_CGCCPF').AsString,
                                 FieldByName('CHQ_C_G_C_').AsString,
                                 FieldByName('CHQ_HIST01').AsString,
                                 FieldByName('CHQ_HIST02').AsString,
                                 FieldByName('CHQ_CTADEP').AsString,
                                 FieldByName('CHQ_DOCDEP').AsString,
                                 FieldByName('CHQ_CODPOR').AsString,
                                 FieldByName('CHQ_CODCTA').AsString,
                                 FieldByName('CHQ_MOTDEV').AsString,
                                 FieldByName('CHQ_FORREP').AsString,
                                 FieldByName('CHQ_OBSREP').AsString,
                                 FieldByName('CHQ_CODEMP').AsString,
                                 FieldByName('CHQ_NUMNOT').AsString,
                                 FieldByName('CHQ_PORCUS').AsString,
                                 IfThen(FieldByName('CHQ_DOCUME').AsString = 'DIVERSOS', FieldByName('CHQ_DOCUME').AsString + '-PRZ', FieldByName('CHQ_DOCUME').AsString),
                                 FieldByName('CHQ_INCCTR').AsString,
                                 FieldByName('CHQ_DTACAD').AsDateTime,
                                 FieldByName('CHQ_DTAVEN').AsDateTime,
                                 FieldByName('CHQ_DTADEP').AsDateTime,
                                 FieldByName('CHQ_DTADEV').AsDateTime,
                                 FieldByName('CHQ_DTARDP').AsDateTime,
                                 FieldByName('CHQ_DTAREP').AsDateTime,
                                 FieldByName('CHQ_DTACUS').AsDateTime,
                                 FieldByName('CHQ_VALCHQ').AsFloat,
                                 '',
                                 intSeqCon,
                                 VS_strCodEmp,
                                 0,
                                 FieldByName('CHQ_TELCHE').AsString,
                                 FieldByName('CHQ_TELNUM').AsString,
                                 FieldByName('CHQ_CODOPE').AsString,
                                 FieldByName('CHQ_CODCMC').AsString,
                                 fltValIpi,
                                 fltValRet,
                                 fltValAce,
                                 fltValFre,
                                 FieldByName('CHQ_PORCHQ').AsString,
                                 Self.Name,
                                 FieldByName('CHQ_NAODEP').AsString,
                                 FieldByName('CHQ_CODCID').AsString,
                                 '', '', '',
                                 fltValCbs,
                                 fltValIbs,
                                 fltVal_Is);

            {********************}
            {* GRAVA LOGCHQ     *}
            {*****************JU*}
            If Result Then Result := fLogChq(cdsChqPre, 1);

            If Assigned(objProrrogacao) Then
            Begin
              objProrrogacao.pAdicionarChequeNoArrayProrrogacao(cdsChqPre,cdsChqPre.RecNo);
            End;

          Next;
        End;

      End;
      EnableControls;
    End;

    With cdsChqVis Do
    Begin
      DisableControls;
      If Assigned(cdsChqVis) And (Active) And (Not IsEmpty) Then
      Begin

        First;

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          If untCadChq.fExisteCheque(FieldByName('CHQ_CODBCO').AsString,
                                     FieldByName('CHQ_NUMAGE').AsString,
                                     FieldByName('CHQ_CONCOR').AsString,
                                     FieldByName('CHQ_NUMCHQ').AsString) Then
          Begin
            fMensagem('ATENÇÃO!',     'O Cheque digitado de nº: ' + FieldByName('CHQ_NUMCHQ').AsString +
                                      ' já existe no cadastro. Operação cancelada.', ['&Ok']);
            Result := False;
            Exit;
          End;

          pCarregaImpostoProporcional(FieldByName('CHQ_VALCHQ').AsFloat, fltValIpi, fltValRet, fltValAce, fltValFre, fltValCbs, fltValIbs, fltVal_Is);

          Result := Result And
                    fGravaCheque(FieldByName('CHQ_CODBCO').AsString,
                                 FieldByName('CHQ_NUMAGE').AsString,
                                 FieldByName('CHQ_CONCOR').AsString,
                                 FieldByName('CHQ_NUMCHQ').AsString,
                                 FieldByName('CHQ_CODCLI').AsString,
                                 FieldByName('CHQ_NOMEMI').AsString,
                                 FieldByName('CHQ_ENDERE').AsString,
                                 FieldByName('CHQ_TELEMI').AsString,
                                 FieldByName('CHQ_CGCCPF').AsString,
                                 FieldByName('CHQ_C_G_C_').AsString,
                                 FieldByName('CHQ_HIST01').AsString,
                                 FieldByName('CHQ_HIST02').AsString,
                                 FieldByName('CHQ_CTADEP').AsString,
                                 FieldByName('CHQ_DOCDEP').AsString,
                                 FieldByName('CHQ_CODPOR').AsString,
                                 FieldByName('CHQ_CODCTA').AsString,
                                 FieldByName('CHQ_MOTDEV').AsString,
                                 FieldByName('CHQ_FORREP').AsString,
                                 FieldByName('CHQ_OBSREP').AsString,
                                 FieldByName('CHQ_CODEMP').AsString,
                                 FieldByName('CHQ_NUMNOT').AsString,
                                 FieldByName('CHQ_PORCUS').AsString,
                                 IfThen(FieldByName('CHQ_DOCUME').AsString = 'DIVERSOS', FieldByName('CHQ_DOCUME').AsString + '-AVI', FieldByName('CHQ_DOCUME').AsString),
                                 FieldByName('CHQ_INCCTR').AsString,
                                 FieldByName('CHQ_DTACAD').AsDateTime,
                                 FieldByName('CHQ_DTAVEN').AsDateTime,
                                 FieldByName('CHQ_DTADEP').AsDateTime,
                                 FieldByName('CHQ_DTADEV').AsDateTime,
                                 FieldByName('CHQ_DTARDP').AsDateTime,
                                 FieldByName('CHQ_DTAREP').AsDateTime,
                                 FieldByName('CHQ_DTACUS').AsDateTime,
                                 FieldByName('CHQ_VALCHQ').AsFloat,
                                 '',
                                 intSeqCon,
                                 VS_strCodEmp,
                                 0,
                                 FieldByName('CHQ_TELCHE').AsString,
                                 FieldByName('CHQ_TELNUM').AsString,
                                 FieldByName('CHQ_CODOPE').AsString,
                                 FieldByName('CHQ_CODCMC').AsString,
                                 fltValIpi,
                                 fltValRet,
                                 fltValAce,
                                 fltValFre,
                                 FieldByName('CHQ_PORCHQ').AsString,
                                 Self.Name,
                                 FieldByName('CHQ_NAODEP').AsString,
                                 FieldByName('CHQ_CODCID').AsString,
                                 '', '', '',
                                 fltValCbs,
                                 fltValIbs,
                                 fltVal_Is);

            {******************}
            {* GRAVA O LOGCHQ *}
            {***************JU*}
            If Result Then Result := fLogChq(cdsChqVis, 2);

          Next;
        End;
        EnableControls;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
      Result := False;
    End;
  End;
end;

function TfrmBaixaReceber.fGravaCreditoCliente(fltValCre: Double; intSeqCon: Integer): Boolean;
  Var
    strNumDup  : String;
    strPortador: String;
    lstBanCtr : TBanCtrRepository;
    dtaDtaBan : TDateTime;
    strSeqLan : String;
    strSeqRec : String;
    LRecebidoPorPix: String;
    dtaCad: String;
begin
  Try
    LRecebidoPorPix := IIF(dicBaixa['RecebidoPixAvulso'], 'S', 'N');
    If Assigned(FObjetoPixRecebimento) Then
    Begin
      If TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(FObjetoPixRecebimento) Then
        LRecebidoPorPix := 'S';
    End;

    strPortador := fRetornaPortadorCliente(fField('CTR_CODCLI').AsString);

    If fEmptyStr(strPortador) Then
      strPortador := strPorBai;

    strNumDup := fRetSequencial('PROCCO', VS_strCodEmp, fTamDocCadRec);

    if -fltValCre < 0 Then
      dtaCad:=strDtaRec
    Else
      dtaCad:=DateToStr(VS_Date);

    Result := fGravaCadRec(strSeqRec,
                           Self.Name,
                           'INCLUSÃO',
                           strNumDup,                                                          // Duplicata
                           'A',                                                                // Parcela
                           0,                                                                  // Sequencial de Baixa
                           'CC',                                                               // Espécie
                           fField('CTR_CODCLI').AsString,      // Cliente
                           VS_strCodEmp,                                                       // Empresa
                           fField('CTR_CODVEN').AsString,      // Vendedor
                           fField('CTR_CODDIG').AsString,      // Digitador
                           strPortador,                                                        // Portador
                           StrToDate(dtaCad),                                        // Data de Cadastro
                           VS_Date,                                                            // Data de Vencimento
                           -fltValCre,                                                         // Valor da Duplicata
                           -fltValCre,                                                         // Valor Original
                           0.0,                                                                // Despesa de Cobrança
                           'N',                                                                // Desconto
                           'REF. LANC. CREDITO',                                               // Histórico 1
                           '',                                                                 // Histórico 2
                           '',                                                                 // Portador da Baixa
                           '',                                                                 // Centro de Custo da Baixa
                           '',                                                                 // Operador da Baixa
                           '',                                                                 // Documento da Baixa
                           0.0,                                                                // Valor do Recebimento
                           0,                                                                  // Data do Recebimento
                           'N',
                           '',                                                                 // Código do Evento
                           '',                                                                 // Código Velho (CONVERSÃO)
                           '',                                                                 // Tipo de Fora (Condição de Pagamento)
                           '',                                                                 // Código da Condição de Pagamento
                           False,
                           IIF(fEmptyStr(fCfgSis('CTR_CC')),'',fCfgSis('CTR_CC')),             // Codigo do Plano de Contas
                           intSeqCon,
                           0,
                           '',                                                                 // Observação de Agrupamento 1
                           '',                                                                 // Observação de Agrupamento 2
                           '',                                                                 // Observação de Agrupamento 3
                           '',
                           0,
                           0,
                           0,
                           0,
                           '',
                           '',
                           '',
                           '',
                           '',
                           '',
                           0,
                           0,
                           '',
                           0,
                           0,
                           'N',
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           '',
                           0,
                           0,
                           0,
                           '',
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           '',
                           0,
                           'INCLUSÃO',
                           '',
                           '',
                           '',
                           LRecebidoPorPix);

    If (Not Result) Then
      Exit;

    intDCrRec := intDCrRecPor1;

    lstBanCtr := TBanCtrRepository.Create;
    lstBanCtr.fAdd(strNumDup,
                   'A',
                   'CC',
                   VS_strCodEmp,
                   fField('CTR_CODCLI').AsString,
                   'REF. LANC. CREDITO',
                   '',
                   0,
                   fltValCre);

    If blnBaiUtl Then
       dtaDtaBan:= fAcertaDataParaDiaUtil(IIF(fEmptyStr(strDtaLan), VS_Date, StrToDateDef(strDtaLan, 0)) + intDCrRec)
    Else
       dtaDtaBan:= IIF(fEmptyStr(strDtaLan), VS_Date, StrToDateDef(strDtaLan, 0)) + intDCrRec;

    if fltValCre> 0 Then dtaDtaBan:=StrToDate(strDtaRec);

    strSeqLan:= fGravaMovBan(strCtaBai,                                                                   // Centro de Custo
                             strPorBai,                                                                   // Portador da Baixa
                             strLoginUsuarioLogado,                                                       // Operador da Baixa
                             dtaDtaBan,                                                                   // Data do Lançamento
                             fTime(),                                                                     // Hora do Lançamento
                             fField('CTR_NUMDUP').AsString,                                               // Numero do Documento
                             'C',                                                                         // Credito / Debito
                             VS_strCodEmp,                                                                // Empresa da Baixa
                             fltValCre,                                                                   // Valor Do Lançamento
                             'REF. LANC. CREDITO',                                                        // Histórico 1
                             '',                                                                          // Histórico 2
                             fField('CTR_CODCLI').AsString,                                               // Cliente da Duplicata
                             '',                                                                          // Fornecedor da Duplicata
                             fField('NRODUP').AsString,                                                   // Número da Duplicata
                             0,                                                                           // Sequencial de Baixa
                             fField('PARDUP').AsString,                                                   // Parcela da Duplicata
                             fField('CTR_CODEMP').AsString,                                               // Empresa da Duplicata
                             '',                                                                          // Série
                             fField('CTR_CODEVE').AsString,                                               // Codigo do Evento
                             '',                                                                          // Documento da Baixa
                             lstBanCtr.fGetList                                                           // Log Bancário
                            );

    pAtualizarSequencialMovBanInclusaoCredito(strSeqRec, strSeqLan);

    If Not (fEmptyStr(strSeqLan)) Then
    Begin
      If (fltValorBaixa <> 0) and (strCodPorFix <> '') then
      Begin
        SetLength(arrSeqLan, Length(arrSeqLan) + 1);
        arrSeqLan[Length(arrSeqLan)-1] := strSeqLan;
      End;
    End;
    FreeAndNil(lstBanCtr);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
      Result := False;
    End;
  End;
end;

function TfrmBaixaReceber.fImprimeReciboLayout(fltValorAcrescimo: Double = 0;
                                               fltValorRecebido: Double = 0): Boolean;
Var
  strRecctr : String;
  blnEmpty : Boolean;
begin
  cdsRelCtr   := fCriaClientRecibo;
  FRelCtrCredito := fCriaClientDatasetReciboCTR;

  CriarClientCreditoGerado(intSeqcon.ToString,
                           VS_strCodEmp);

  editorFast := TFastPrintFileEditor.Create(Nil);
  try
    if strNomFil <> '' Then
      editorFast.pSelectFil(Self.Name, strNomFil, fRetNomeRede);

    strRecctr := fCfgSis('RECCTR');

    If strRecctr = 'N' Then
    begin
      reciboCtr  := TReciboCtr.CreateInstance(cdsRelCtr, fltValorAcrescimo, fltValorRecebido, FRelCtrCredito);
      editorFast.pSetFastPrintFile(reciboCtr);
      blnEmpty := reciboCtr.IsEmpty;
      reciboCtr.pSetFastType(strTipImp);
    end
    else
    begin
      reciboCtrMeiaFolha  := TReciboCtrMeiaFolha.CreateInstance(cdsRelCtr);
      editorFast.pSetFastPrintFile(reciboCtrMeiaFolha);
      blnEmpty := reciboCtrMeiaFolha.IsEmpty;
    end;

    Result := False;

    If Not blnEmpty Then
    Begin

      If editorFast.fLoadReport Then
      Begin
        editorFast.intNumeroVias := IIf(strRecctr = 'N', fCfgSis('CTRVIA', varInteger), 1);
        editorFast.pSelectFil(Self.Name, strNomFil, fRetNomeRede);
        editorFast.pPrint;
        Result := True;
      End;

    End;
  finally
    if Assigned(editorFast) then
      FreeAndNil(editorFast);
  end;
end;

function TfrmBaixaReceber.fInfDup(strCampo, strTitulo: String): String;
begin
  If Not fEmptyStr(cdsCtaRec.FieldByName(strCampo).AsString) Then
    Result := ' - ' + strTitulo + ': ' + cdsCtaRec.FieldByName(strCampo).AsString;
end;

function TfrmBaixaReceber.fLockedByCurrentConnection(
  strChaLck: String): Boolean;
  Var
    LIPConnectionLock : String;
begin
  LIPConnectionLock := fGetIPConnectionLock(strChaLck);

  Result := (fGetIdConnectionLock(strChaLck) = fGetConnectionID) And
            ((LIPConnectionLock = GetIPAddressAsString) Or
             (LIPConnectionLock = VS_IPAddressAsString)) ;
end;

function TfrmBaixaReceber.fLogChq(cdsLog: TUniClientDataSet; intOpcao: Integer): Boolean;
  Var
    strHisLog: String;
    repCadChq: TCadChqRepository;
begin

  Try
    Result := True;
    strHisLog := IIF(intOpcao = 1, 'CHQ. PRE.', 'CHQ. VIS.');

    repCadChq := TCadChqRepository.Create;
    With cdsLog Do
    Begin
      repCadChq.pGravaLog(FieldByName('CHQ_CODBCO').AsString, FieldByName('CHQ_NUMAGE').AsString,
                          FieldByName('CHQ_CONCOR').AsString, FieldByName('CHQ_NUMCHQ').AsString,
                          'INSERINDO ' + strHisLog + '(frmBaixaReceber.fLogChq)');
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
  FreeAndNil(repCadChq);

end;


function TfrmBaixaReceber.fMarcaDuplics(pgbProgresso: TcxProgressBar): Boolean;
  Var
    fltDesSuj : Double;
    fltValCal : Double;
    fltValJur : Double;
    FDuplicatas: TArrayDuplicatasCredito;
    FDuplicata: TDuplicatasCredito;

    LFiltroAnterior: String;

    LDuplicatasComPixGerados: Boolean;
begin
  fltDesSuj := 0.00;
  fltValJur := 0.00;
  SetLength(FDuplicatas, 0);

  //Primeiro desmarca todas as duplicatas (para desmarcar os creditos selecionados)
  If FValidarCreditosDeMesmoClienteOuRedeLojas Then
  Begin
    fDesmarcarDuplics(pgbProgresso);
  End;

  LDuplicatasComPixGerados := False;

  With cdsCtaRec Do
  Begin
    Edit;
    blnSelTod := True;

    LFiltroAnterior := Filter;
    Filter   := dbgDuplicatasDBTableView1.DataController.Filter.FilterText;
    Filtered := Not Filter.IsEmpty;

    First;

    pgbProgresso.Position := 0;
    pgbProgresso.Properties.Max := RecordCount;

    While Not Eof Do
    Begin
      If (FNaoMarcarCreditos) And (FieldByName('CTR_VALDUP').AsFloat < 0) Then
      Begin
        Next;
        Continue;
      End;

      If (FieldByName('CTR_MARDES').AsString <> 'M') Then
      Begin
        if not fValidaValorBaixa(FieldByName('CTR_VALCAL').AsFloat) then
        begin
          Next;
          Continue;
        end;

        If Not FieldByName('CTR_TX_PIX').AsString.IsEmpty Then
        Begin
          LDuplicatasComPixGerados := True;

          Next;
          Continue;
        End;

        {****************************************************************}
        {* VERIFICA SE O PORTADOR TEM PERMISSÃO PARA BAIXAR A DUPLICATA *}
        {****************************************************************}
        If FieldByName('POR_BAICTF').AsString = 'N' Then
        Begin
           Next;
           Continue;
        End;

        if pos(FieldByName('CTR_ESPDOC').AsString, 'NF_DV') > 0 then
        begin
          if  FieldByName('CTR_VAlDUP').AsFloat < 0 then
          begin
             FDuplicata.NumDup := FieldByName('NRODUP').AsString;
             FDuplicata.Parcel := FieldByName('PARDUP').AsString;
             FDuplicata.EspDoc := FieldByName('CTR_ESPDOC').AsString;
             FDuplicata.CodEmp := FieldByName('CTR_CODEMP').AsString;
             FDuplicata.CodCli := FieldByName('CTR_CODCLI').AsString;

             SetLength(FDuplicatas, Length(FDuplicatas)+1);

             FDuplicatas[High(FDuplicatas)] := FDuplicata;
          end;
        end;

        pMarcarDuplicata(False,True,False,True);
        pSelecionarDuplicata(True);

        If FieldByName('CTR_MARDES').AsString = 'M' Then
          FListaMarcarTodas.Add(Concat(fField('NRODUP').AsString, '|',
                                       fField('CTR_ESPDOC').AsString, '|',
                                       fField('CTR_CODEMP').AsString, '|',
                                       fField('CTR_CODCLI').AsString, '|',
                                       fField('PARDUP').AsString));

        Edit;

        If (FieldByName('CTR_VALCAL').AsFloat >= FieldByName('CTR_VALDUP').AsFloat) Then
        Begin
          If ((FieldByName('CTR_JURSUJ').AsFloat <> 0)  Or
              (FieldByName('CTR_DESCOB').AsFloat <> 0)) Or
              (FieldByName('CTR_DESSUJ').AsFloat <> 0)   Then
          Begin
            If (FieldByName('CTR_VALCAL').AsFloat = (FieldByName('CTR_VALDUP').AsFloat + FieldByName('CTR_JURSUJ').AsFloat + FieldByName('CTR_DESCOB').AsFloat - FieldByName('CTR_DESSUJ').AsFloat)) Then
            Begin
              FieldByName('CTR_VALJUR').AsFloat := FieldByName('CTR_JURSUJ').AsFloat;
              fltValJur := FieldByName('CTR_VALJUR').AsFloat;
              fltDesSuj := FieldByName('CTR_DESSUJ').AsFloat;
            End
            Else If (FieldByName('CTR_VALCAL').AsFloat < (FieldByName('CTR_VALDUP').AsFloat + FieldByName('CTR_JURSUJ').AsFloat + FieldByName('CTR_DESCOB').AsFloat - FieldByName('CTR_DESSUJ').AsFloat)) Then
            Begin
              FieldByName('CTR_VALJUR').AsFloat := FieldByName('CTR_JURSUJ').AsFloat -
                          ((FieldByName('CTR_VALDUP').AsFloat + FieldByName('CTR_JURSUJ').AsFloat + FieldByName('CTR_DESCOB').AsFloat - FieldByName('CTR_DESSUJ').AsFloat) -
                (FieldByName('CTR_VALCAL').AsFloat));
              fltDesSuj := FieldByName('CTR_DESSUJ').AsFloat;
            End
            Else If (FieldByName('CTR_VALCAL').AsFloat > (FieldByName('CTR_VALDUP').AsFloat + FieldByName('CTR_JURSUJ').AsFloat + FieldByName('CTR_DESCOB').AsFloat - FieldByName('CTR_DESSUJ').AsFloat)) Then
            Begin
              fltValCal := FieldByName('CTR_VALDUP').AsFloat + FieldByName('CTR_JURSUJ').AsFloat + FieldByName('CTR_DESCOB').AsFloat - FieldByName('CTR_DESSUJ').AsFloat;

              if blnRecalJur then
              begin
                pAtualizarValorJurosRecalculado;
              end
              else
              begin
                fltValJur := fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                             FormatDateTime('dd/mm/yyyy', TDateTime(dicBaixa['dtaDtaPag'])),
                             fltValCal);

                FieldByName('CTR_VALJUR').AsFloat := FieldByName('CTR_JURSUJ').AsFloat +
                                                     fltValJur;
                fltValJur := FieldByName('CTR_VALJUR').AsFloat;
              End;

              If blnDescFinanSomenteAteVenc Then
              Begin
                If (TDateTime(dicBaixa['dtaDtaPag'])<= fField('CTR_DTAVEN').AsDateTime + fField('CTR_QTDDAV').AsInteger) Then
                Begin
                  fltDesSuj := FieldByName('CTR_DESSUJ').AsFloat;
                End
                Else
                Begin
                  fltDesSuj := 0;
                End;
              End
              Else
              Begin
                fltDesSuj := FieldByName('CTR_DESSUJ').AsFloat;
              End;

            End;
          End
          Else
          Begin
            FieldByName('CTR_VALJUR').AsFloat := FieldByName('CTR_VALCAL').AsFloat - FieldByName('CTR_VALDUP').AsFloat;
            fltValCal := FieldByName('CTR_VALDUP').AsFloat + FieldByName('CTR_JURSUJ').AsFloat + FieldByName('CTR_DESCOB').AsFloat - FieldByName('CTR_DESSUJ').AsFloat;

            if blnRecalJur then
            begin
              pAtualizarValorJurosRecalculado;
            end
            else
            begin
              fltValJur := fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                               FormatDateTime('dd/mm/yyyy', TDateTime(dicBaixa['dtaDtaPag'])),
                                               fltValCal);

              FieldByName('CTR_VALJUR').AsFloat := FieldByName('CTR_JURSUJ').AsFloat +
                                                   fltValJur;
              fltValJur := FieldByName('CTR_VALJUR').AsFloat;
            end;

            If blnDescFinanSomenteAteVenc Then
            Begin
              If (TDateTime(dicBaixa['dtaDtaPag']) <= fField('CTR_DTAVEN').AsDateTime + fField('CTR_QTDDAV').AsInteger) Then
              Begin
                fltDesSuj := FieldByName('CTR_DESSUJ').AsFloat;
              End
              Else
              Begin
                fltDesSuj := 0;
              End;
            End
            Else
            Begin
              fltDesSuj := FieldByName('CTR_DESSUJ').AsFloat;
            End;
          End;
        End
        Else
        Begin
          fltValCal := FieldByName('CTR_VALDUP').AsFloat + FieldByName('CTR_JURSUJ').AsFloat + FieldByName('CTR_DESCOB').AsFloat - FieldByName('CTR_DESSUJ').AsFloat;

          if blnRecalJur then
          begin
            pAtualizarValorJurosRecalculado;
          end
          else
          begin
            fltValJur := fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                             FormatDateTime('dd/mm/yyyy', TDateTime(dicBaixa['dtaDtaPag'])),
                                             fltValCal);

            FieldByName('CTR_VALJUR').AsFloat := FieldByName('CTR_JURSUJ').AsFloat +
                                                 fltValJur;
            fltValJur := FieldByName('CTR_VALJUR').AsFloat;
          end;

          If blnDescFinanSomenteAteVenc Then
          Begin
            If (TDateTime(dicBaixa['dtaDtaPag']) <= fField('CTR_DTAVEN').AsDateTime + fField('CTR_QTDDAV').AsInteger) Then
            Begin
              fltDesSuj := FieldByName('CTR_DESSUJ').AsFloat;
            End
            Else
            Begin
              fltDesSuj := 0;
            End;
          End
          Else
          Begin
            fltDesSuj := FieldByName('CTR_DESSUJ').AsFloat;
          End;

        End;

        if blnRecalJur then
          FieldByName('CTR_VALREC').AsFloat    := FieldByName('CTR_VALCAL').AsFloat
        else
          FieldByName('CTR_VALREC').AsFloat    := FieldByName('CTR_VALDUP').AsFloat + FieldByName('CTR_DESCOB').AsFloat + fltValJur - fltDesSuj;

        FieldByName('CTR_VALDES').AsFloat    := fltDesSuj;

        If (FieldByName('CTR_VALDUP').AsFloat = FieldByName('CTR_VALREC').AsFloat) AND
           (fltValJur = 0) and (fltDesSuj = 0) THEN
        Begin
          FieldByName('CTR_VALJUR').AsFloat  := FieldByName('CTR_VALCAL').AsFloat - FieldByName('CTR_VALREC').AsFloat;
          FieldByName('CTR_VALDES').AsFloat  := FieldByName('CTR_VALCAL').AsFloat - FieldByName('CTR_VALREC').AsFloat;
        End;

        FieldByName('CTR_VALRES').AsFloat    := 0;
        FieldByName('CTR_BAIPAR').AsString   := 'N';
        FieldByName('CTR_TIPBAI').AsString   := 'T';
        FieldByName('CTR_DTAREC').AsDateTime := TDateTime(dicBaixa['dtaDtaPag']);
        Post;
      End;

      If fField('CTR_MARDES').AsString = 'M' Then
        IncluiRegistroMarcado
      Else
      Begin
        If FCloneDatasetMarcados.Locate('AUTOINCREM', fField('AUTOINCREM').AsString, []) Then
          FCloneDatasetMarcados.Delete;
      End;

      pStepStatusSelecao(pgbProgresso);
      Next;

      If cdsCtaRec.RecNo Mod 500 = 0 Then
        pTrimAppMemorySize;
    End;

    objLogLibRec.pLimpaTmpLogLib();

    Filter   := LFiltroAnterior;
    Filtered := Not LFiltroAnterior.IsEmpty;

    First;

    pCalculaTotalDuplicatas(edtDescontoTotal, edtJurosTotal, edtTotalRecebido, edtQtdSelecionadas, True, FCloneDatasetMarcados);

    If (Not fValidaLiberacaoCreditoProfissional) Then
      pDesmarcaDuplicatasCreditoProfissional;

    If (Not fValidaDuplicatasDeCredito(FDuplicatas)) Then
      pDesmarcaDuplicatasDeCredito(FDuplicatas);

    blnMarcandoTodas := False;
  End;

  If LDuplicatasComPixGerados Then
    fMensagem('ATENÇÃO', 'Algumas duplicatas não foram marcadas pois possui Pix ativo gerado.', ['&Ok']);

  Result := True;
End;


procedure TfrmBaixaReceber.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodCli);
end;

procedure TfrmBaixaReceber.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(qryConPor);
  FreeAndNil(qryConCli);
  FreeAndNil(qryConEmp);
  FreeAndNil(stlDupPro);
  FreeAndNil(dicBaixa);
  FreeAndNil(cdsChqVis);
  FreeAndNil(cdsChqPre);
  FreeAndNil(cdsCtaRec);
  FreeAndNil(objLock);

  FCloneDatasetMarcados.Close;
  FreeAndNil(FCloneDatasetMarcados);

  FreeAndNil(objLogLibRec);

  FreeAndNil(FListaMarcarTodas);

  If Assigned(objProrrogacao) Then
    FreeAndNil(objProrrogacao);

  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  If Assigned(FRelCtrCredito) Then
    FreeAndNil(FRelCtrCredito);

  If Assigned(objBaixaReceber) Then
    FreeAndNil(objBaixaReceber);

  If Assigned(FConfiguracaoGrid) Then
    FreeAndNil(FConfiguracaoGrid);

  FreeAndNil(FLogCancelamento);
end;

procedure TfrmBaixaReceber.FormCreate(Sender: TObject);
begin
  inherited;
  objBaixaReceber := TBaixaReceber.Create(Nil);
  objLiberacao := TLiberacao.Create;
  objLock := TLock.Create;

  FBaixaIniciada := False;

  objLogLibRec := TLogLibRec.Create;

  If fCfgSis('CTRPRO', varBoolean) Then
    objProrrogacao := TProrrogacaoDeTitulos.Create(ttChqPre);
  blnApenasImpressaoRecibo := False;

  intLockCf := -1;
  strCliSel := '';
  strDtaRec := DateToStr(VS_Date);
  strDtaAnt := EmptyStr;
  fltCreSel := 0;
  stlDupPro := TStringList.Create;
  intSemaforo := -1;
  blnBaixouDup := False;

  fltValorBaixa :=  0;
  strCodPorFix  := '';
  SetLength(arrSeqLan, 0);

  qryConPor := fCriaQuery(Nil);
  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  dicBaixa  := TDictionary <String,Variant>.Create;

  cdsCtaRec := TUniClientDataSet.Create(Self);
  cdsCtaRec.OnFilterRecord := pFilterRecord;
  dtsCtaRec := fCriaDataSource(cdsCtaRec);

  cdsChqPre := fCriaCdsCheques(Nil);
  cdsChqVis := fCriaCdsCheques(Nil);

  dbgDuplicatasDBTableView1.DataController.DataSource := dtsCtaRec;

  blnDescFinanSomenteAteVenc := (fCfgSis('UTDEFN') = '2');

  blnLiberouUtiCredProf := False;

  blnCarregaBaixa := False;

  SetLength(arrLogLib, 0);
  SetLength(arrLogAvi, 0);

  FillChar(recUltDupBaixada, SizeOf(recUltDupBaixada), #0);

  FListaMarcarTodas := TStringList.Create;

  FLiberadoUtilizacaoCredito := False;

  strDupsGeradasAntec := '';

  FObjetoPixRecebimento := Nil;
  FObjetoPixEmail := Nil;

  FCloneDatasetMarcados := TUniClientDataSet.Create(Nil);

  FAtualizarGrid := True;

  FValidarCreditosDeMesmoClienteOuRedeLojas := fCfgSis('SBCCMC', VarBoolean);

  FNaoMarcarCreditos := False;
  FLogCancelamento := TLogCancelamento.Create;
end;

procedure TfrmBaixaReceber.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Escape) Then
  Begin
    if cdsCtaRec.IsEmpty then
      Close;

    If InterlockedIncrement(intSemaforo) = 0 Then
    Begin
      Try
        pLimpaDados;
        objLock.pDestravarTodos;
        pSetFocus(edtCodCli);
      Finally
        InterlockedDecrement(intSemaforo);
      End;
    End
    Else
     InterlockedDecrement(intSemaforo);
  End
  Else If (Key = VK_F2) Then
  Begin
    btnlimparDadosRemessa.Click;
  End
  Else If (Key = VK_F10) Then
  Begin
    if btnConfirma.Visible then
      btnConfirma.Click
    else
      btnImprimirRecibo.Click
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
    btnSelecionadas.Click;
  End
  Else If (KEy = VK_F11) Then
  Begin
    btnRecalculaJuros.Click;
  End
  Else If (Key = VK_F12) And (Shift = [ssAlt]) Then
  Begin
    btnDescontoGeral.Click;
  End
  Else If (Key = VK_F12) Then
  Begin
    btnManutencao.Click;
  End
  Else If (Key = Ord('D')) And (Shift = [ssCtrl]) Then
  Begin
    if btnDuplicataAgrupada.Visible then
      btnDuplicataAgrupada.Click;
  End
  Else If (Key = Ord('L')) And (Shift = [ssCtrl]) Then
  Begin
    if btnVisualizaDocumentoCompleto.Visible then
      btnVisualizaDocumentoCompleto.Click;
  End
  Else If (Shift = [ssCtrl]) then
  Begin
    If Key = Ord('A') Then
    Begin
      btnAdiantamento.Click;
    End
    Else If Key = Ord('P') Then
    Begin
      if btnProdutos.Visible then
        btnProdutos.Click;
    End
    Else If Key = Ord('E') Then
      btnEmailPix.Click;
  End
  Else If (Key = VK_F4) Then
  Begin
    btnInformacaoCobrancaClick(sender);
  End
end;

procedure TfrmBaixaReceber.FormResize(Sender: TObject);
begin
  inherited;
  pAjustarBtnSairBaixa;
end;

procedure TfrmBaixaReceber.FormShow(Sender: TObject);
  Var
    LConsulta: TUniQuery;

    LConsultaPrv: TUniDataSetProvider;
begin
  inherited;

  if fCfgSis('LBXCTR', varString)= '1' Then
    chkLimFil.Checked:=True
  Else If fCfgSis('LBXCTR', varString)= '2' Then
    chkLimFil.Checked:=False;


  strAceCtr:= fCampoTabela('OPE_EMPCTR', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]);

  fltJur         := -1;

  If (Assigned(stlConjugadas)) And
     (stlConjugadas.Count > 0) Then
  Begin
    fValidaCampos(edtNosNum, True);
    pSetFocus(dbgDuplicatas);
  End
  Else
  Begin
    if fEmptyStr(edtCodEmp.Text) then
    begin
      edtCodEmp.Text := VS_strCodEmp;
      edtNomEmp.Text := untFuncoesSimples.fRetNomeEmpresa;
    end
    else
    begin
      edtNomEmp.Text := untFuncoesSimples.fRetNomeEmpresa(edtCodEmp.Text);
    end;
  End;

  If (Not fEmptyStr(strDupsGeradasAntec)) And (fCfgSis('CTRARC') = 'S') Then
  Begin
     btnCarrTitulos.Click;
     pSetFocus(dbgDuplicatas);
  End;

  pnlEnvBan.Visible := fVerificaAcessoSistema('REMCTR');
  blnMarcandoTodas := False;

  edtRomaneio.Visible := fCfgSis('RCXROM') = 'S';
  lblRomaneio.Visible := edtRomaneio.Visible;

  if blnCarregaBaixa then
  begin
    btnCarrTitulos.Click;
    pSetFocus(dbgDuplicatas);
  end;

  btnEmailPix.Visible := TFuncoesPixAutcom.RealizaValidacoesUsoDoPixNoReceber(strLoginUsuarioLogado,
                                                                              '',
                                                                              False);

  if (fltValorBaixa > 0) and (strCodPorFix <> '') then
    strDtaRec := DateToStr(dteDtaRecFix);

  if blnApenasImpressaoRecibo then
  begin
    btnConfirma.Visible := False;
    btnImprimirRecibo.Visible := True;
    btnLimparDadosRemessa.Visible := false;
    btnAdiantamento.Visible := False;
    btnDuplicataAgrupada.Visible := False;
    btnVisualizaDocumentoCompleto.Visible := False;
    btnEmailPix.Visible := False;
    btnProdutos.Left := btnAdiantamento.Left;
  end;

  procVisualizaDocumentoReimpressao := pMostraDocumentoReimpressao;

  strMarcacaoLog := '';
  pUtilizaRotinaProjeto;
  pAjustarBtnSairBaixa;

  LConsulta := fCriaQuery(Self);
  LConsultaPrv := TUniDataSetProvider.Create(Self);

  If Not cdsCtaRec.Active Then
  Begin
    LConsultaPrv.DataSet := LConsulta;
    cdsCtaRec.SetProvider(LConsultaPrv);
    LConsulta.SQL.Text := untCadRec.RetornaSQLCamposTabelasTemporaria(False, '', '') +
                          ' WHERE FALSE';
    LConsulta.Open;

    pSetaClient(LConsulta);
    cdsCtaRec.Open;

    cdsCtaRec.SetProvider(Nil);
  End;

  fltPercJurosAplicado := fCfgSis('JURATR', varDouble);

  FConfiguracaoGrid := TConfiguracaoGrids.Create(dbgDuplicatas,
                                                 dbgDuplicatasDBTableView1,
                                                 Concat(Self.Name, '.', dbgDuplicatasDBTableView1.Name),
                                                 ['CTR_MARDES', 'CTR_VALJUR', 'CTR_TX_PIX']);

  FreeAndNil(LConsultaPrv);
  FreeAndNil(LConsulta);
end;

function TfrmBaixaReceber.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodCli) Then
    Begin
      If (Not fEmptyStr(edtCodCli.Text)) Then
      Begin
        If Not SameText(edtCodCli.Text, '00000000') Then
        Begin
          SetLength(arrClientes, 0);
          strClientes := '';

          pCarregaCliente;
          If fEmptyStr(edtNomCli.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Cliente não está cadastrado!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else
      Begin
        edtNomCli.Clear;
      End;
      If Result And blnBuscaPorChave And fCfgSis('EXOBCR', varBoolean) Then
        pMostraObsCliente;
    End

    Else If (Sender = fraCentroCusto.edtCodEve) Then
    Begin
      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        If Not SameText(fraCentroCusto.edtCodEve.Text, '00000') Then
        Begin
          SetLength(arrEvento, 0);
          strEvento := '';

          pCarregaEvento;
          If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&O k']);
            Result := False;
          End
          Else If (fRetTipoEvento(fraCentroCusto.edtCodEve.Text)='P') Then
          Begin
            fMensagem('ATENÇÃO', 'Esse Centro de Custos pode ser aplicado somente às contas a pagar!',['&OK']);
            Result := False;
          End;
        End;
      End
      Else
      Begin
        fraCentroCusto.edtDesEve.Clear;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If (fEmptyStr(edtCodEmp.Text)) Then
      Begin
        edtNomEmp.Clear;
      End
      Else
      Begin
        If Not SameText(edtCodEmp.Text, '000') Then
        Begin
          SetLength(arrEmp, 0);
          strEmp := '';

          pCarregaEmpresa;
          If fEmptyStr(edtNomEmp.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
            Result := False;
          End
          Else If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a esta empresa!', ['&Ok']);
            Result := False;
          End;
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

    Else If (Sender = edtCodPortador) Then
    Begin
      If (fEmptyStr(edtCodPortador.Text)) Then
      Begin
        edtDesPortador.Clear;
      End
      Else
      Begin
        If Not SameText(edtCodPortador.Text, '00000') Then
        Begin
          SetLength(arrPortador, 0);
          strPortador := '';

          pCarregaPortador;
          If (qryConPor.FieldByName('POR_CODPOR').IsNull) Then
          Begin
            fMensagem('ATENÇÃO!', 'Portador não está cadastrado!', ['&Ok']);
            Result := False;
          End
          {*REQ*145940**********RP*}
          Else If (High(arrEmp) > 0) Then
          Begin
              If Not fEmpresaTemAcessoPortador(edtCodPortador.Text,arrEmp) Then
                Result := False;
          End
          Else If Not fEmpresaTemAcessoPortador(edtCodPortador.Text, edtCodEmp.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End
          Else If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtCodPortador.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos para este portador!', ['&Ok']);
              Result := False;
            End;
          End;
        End;
      End;
    End

    Else If (Sender = edtCodven) Then
    Begin
      If (fEmptyStr(edtCodven.Text)) Then
      Begin
        edtNomVen.Clear;
      End
      Else
      If Not SameText(edtCodven.Text, '000') Then
      Begin
        SetLength(arrVend, 0);
        strVend := '';

        pCarregaVendedor;
        If fEmptyStr(edtNomVen.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Vendedor não está cadastrado!', ['&O k']);
          Result := False;
        End
      End;
    End

    {***********************}
    {* VALIDAÇÃO DE DATAS  *}
    {********************LE*}
    Else
    If (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final de vencimento deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          fMensagem('', 'O campo Data Inicial de vencimento deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
          Begin
            If not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
            Begin
              fMensagem('','A Data Inicial de vencimento deve ser menor que a data final de vencimento!',['&O K']);
              Result := False;
            End;
          End;
        End;
      End;
    End
    Else
    If (Sender = mskDtaCadFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaCadFin.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final do cadastro deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadFin.Text))) And fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) Then
        Begin
          fMensagem('', 'O campo Data Inicial do cadastro deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text))) Then
          Begin
            If not fValidaPeriodo(mskDtaCadIni.Text, mskDtaCadFin.Text) Then
            Begin
              fMensagem('','A Data Inicial do cadastro deve ser menor que a data final do cadastro!',['&O K']);
              Result := False;
            End;
          End;
        End;
      End;

    End
    Else If (Sender = edtCodRed) Then
    Begin
      If Not fEmptyStr(edtCodRed.Text) Then
      Begin
        If Not SameText(edtCodRed.Text, '00000') Then
        Begin
          SetLength(arrRede, 0);
          strRede := '';

          pCarregaRede;
          If fEmptyStr(edtDesRed.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa rede de lojas não está cadastrada!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else
      Begin
        edtDesRed.Clear;
      End;

    End
    Else If (Sender = edtRomaneio) Then
    Begin
      If (Not fEmptyStr(edtRomaneio.Text)) Then
      Begin
         edtRomaneio.Text := fZerosAEsquerdaRomaneio(edtRomaneio.Text, edtRomaneio.MaxLength);
        If (Not fRomaneioExiste(edtRomaneio.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse romaneio não está cadastrado!', ['&Ok']);
          Exit;
        End;

      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmBaixaReceber.fValidaCreditosVencidos: Boolean;
  Var
    intDiasValidadeCredito: Integer;
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
begin
  Result := True;
  Try
    intDiasValidadeCredito := fCfgSis('DIACRE', VarInteger);

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddSeparador(115);
    objLiberacao.objMsgLibera.pAddTexto('***  Utilização de Crédito Expirado  ***', alCentro, teAutcom, '', 115);
    objLiberacao.objMsgLibera.pAddSeparador(115);
    objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade de dias para expirar e solicitar senha para utilização', intDiasValidadeCredito.ToString);

    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'DUPLICATA' , 13 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'EMP'       , 4  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'CLIENTE'   , 39 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'DT.CAD.'   , 11 , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'DT.VENC.'  , 11 , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'VR.CREDITO', 14 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'QTD.DIAS'  , 8  , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);


    cdsCtaRec.First;
    While Not cdsCtaRec.Eof Do
    Begin
      If (fField('CTR_MARDES').AsString = 'M') And
         (fField('CTR_VALDUP').AsFloat < 0)    And
         (DaysBetween(fField('CTR_DTAVEN').AsDateTime, VS_Date) > intDiasValidadeCredito) Then
      Begin

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('DUPLICATA' , fField('NRODUP').AsString + fField('PARDUP').AsString               , 13 , alEsquerda);
        objLinha.pAddColuna('EMP'       , fField('CTR_CODEMP').AsString                                       , 4  , alCentro  );
        objLinha.pAddColuna('CLIENTE'   , fField('CTR_CODCLI').AsString + '-' + fField('CTR_NOMCLI').AsString , 39 , alEsquerda);
        objLinha.pAddColuna('DT.CAD.'   , FormatDateTime('dd/MM/yyyy', fField('CTR_DTACAD').AsDateTime)       , 11 , alCentro  );
        objLinha.pAddColuna('DT.VENC.'  , FormatDateTime('dd/MM/yyyy', fField('CTR_DTAVEN').AsDateTime)       , 11 , alCentro  );
        objLinha.pAddColuna('VR.CREDITO', FormatFloat('#,##0.00', fField('CTR_VALDUP').AsFloat)               , 14 , alDireita );
        objLinha.pAddColuna('QTD.DIAS'  , DaysBetween(fField('CTR_DTAVEN').AsDateTime, VS_Date).ToString      , 8  , alDireita );
        objTabela.lstLinhas.Add(objLinha);

        Result := False;
      End;
      cdsCtaRec.Next;
    End;
    cdsCtaRec.First;

    If Result Then
      FreeAndNil(objTabela)
    else
    begin
      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      objLiberacao.strDirAce := 'LIBRECCREDEXP';
      objLiberacao.strMsgSen := 'Utilização de Crédito Expirado';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;

      Result := objLiberacao.fLibera;

      if Result then
         objLogLibRec.pInsereLogLigTMP( objLiberacao, cdsCtaRec.FieldByName('CTR_NUMDUP').AsString, cdsCtaRec.FieldByName('CTR_ESPDOC').AsString, cdsCtaRec.FieldByName('CTR_CODEMP').AsString );

    end;
  Finally

  End;
end;

function TfrmBaixaReceber.fValidaDuplicatasDeCredito(
  ADuplicatas: TArrayDuplicatasCredito): Boolean;
begin
  Result := fDuplicataCreditoLiberada(ADuplicatas);
end;

{function TfrmBaixaReceber.fValorCalculado(fltValSuj, fltJuros, fltPerDPo, fltDesCob: Double): Double;
var
  fltValDes: Double;
begin

  If (fCfgSis('DESPON', varBoolean)) And (fltPerDpo > 0) Then
    fltValDes := fFormataFloat((fltValSuj * (fltPerDpo/100.00)), 2)
  Else
    fltValDes := 0;

  Result :=(fltJuros + fltValSuj + fltDesCob  - fltValDes);
end;}

function TfrmBaixaReceber.fVerificaDupBaixada(strNumDup,
                                              strParcel,
                                              strEspDoc,
                                              strCodEmp,
                                              strCodCli: String;
                                              intSeqBai: Integer): Boolean;
Var
  strSQL: String;
  qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   CTR_DTAREC ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADREC ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '   CTR_SEQBAI = :SEQBAI ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString  := strNumDup;
      ParamByName('PARCEL').AsString  := strParcel;
      ParamByName('ESPDOC').AsString  := strEspDoc;
      ParamByName('CODEMP').AsString  := strCodEmp;
      ParamByName('CODCLI').AsString  := strCodCli;
      ParamByName('SEQBAI').AsInteger := intSeqBai;
      Open;

      If fEmptyStr(FieldByName('CTR_DTAREC').AsString) Then
        Result := False
      Else
        Result := True;
    End;

  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmBaixaReceber.fVerificaDupExiste(strNumDup, strParcel,
  strEspDoc, strCodEmp, strCodCli: String; intSeqBai: Integer): Boolean;
Var
  strSQL: String;
  qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CTR_DTAREC ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADREC ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '   CTR_SEQBAI = :SEQBAI ';

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDUP').AsString  := strNumDup;
    ParamByName('PARCEL').AsString  := strParcel;
    ParamByName('ESPDOC').AsString  := strEspDoc;
    ParamByName('CODEMP').AsString  := strCodEmp;
    ParamByName('CODCLI').AsString  := strCodCli;
    ParamByName('SEQBAI').AsInteger := intSeqBai;
    Open;

    Result := (Not IsEmpty);
  End;

  FreeAndNil(qryGen);
end;

procedure TfrmBaixaReceber.pHabilitaFiltroFiliais;
begin
  chkFiltrarFiliais.Enabled := Not fEmptyStr(fRetNomCliente(edtCodCli.Text)) And // Cliente Exite
                                   qryConCli.FieldByName('CLI_CGCCPF').AsString.Equals('1'); // Cliente Usa CNPJ

  chkFiltrarFiliais.Checked := (chkFiltrarFiliais.Enabled And chkFiltrarFiliais.Checked);
end;

procedure TfrmBaixaReceber.pAjustarBtnSairBaixa;
begin
  {*********************************************************************************}
  {* MANTÉM O btnSairBaixa SEMPRE ALINHADO COM O ÚLTIMO BOTÃO DA PRIMEIRA FILEIRA, *}
  {* AO ALTERAR O TAMANHO OU ADICIONAR ALGUM BOTÃO, VERIFICAR SE ESTÁ ALINHADO     *}
  {******************************************************************************AM*}
  btnSairBaixa.Top := FlwPnlBotoesBaixa.Height - btnSairBaixa.Height + 2;

  // No Layout novo os botões se perdiam, por isso é feito essa verifcação
  If Not untFuncoesSimples.blnUsuarioLogadoUtilizaModoClassico Then
    btnSairBaixa.Left := FlwPnlBotoesBaixa.Width - btnSairBaixa.Width - 3
  Else
  Begin
    If Self.WindowState = wsMaximized Then
      btnSairBaixa.Left := FlwPnlBotoesBaixa.Width - btnSairBaixa.Width - 10
    Else
      btnSairBaixa.Left := FlwPnlBotoesBaixa.Width - btnSairBaixa.Width - 4;
  End;
end;

procedure TfrmBaixaReceber.pAplicaDescontoGeral;
  Var
    arrDesGer: Array of TDescontoGeral;
    blnConfirma: Boolean;
    strDescGer,
    strValBaiTot : String;
    fltValLiq,
    fltDescGer,
    fltValBaiTot,
    fltValDesc : Double;
    intRecNo   : Integer;
    fltCtrDes,
    fltCtrDe2  : Double;
    blnNivel2  : Boolean;
    strSCtrDe,
    strSenNv2 : String;
    fltPerMax,
    fltValPag,
    fltTmpTotDesc,
    fltValDif: Double;
    blnDigSenha: Boolean;
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;

  function fGetValDes(fltValGer, fltValDup, fltValDes: Double): Double;
  Begin
    Result := RoundTo(fltValDup * fltValDes / fltValGer, -2);
  End;

  procedure pAdicionaLista(fltValDes, fltValRec: Double);
    Var
      intIndex: Integer;
  Begin
    SetLength(arrDesGer, Length(arrDesGer) + 1);
    intIndex := Length(arrDesGer) -1;

    With FCloneDatasetMarcados Do
    Begin
      arrDesGer[intIndex].strCODCLI := FieldByName('CTR_CODCLI').AsString;
      arrDesGer[intIndex].strNOMCLI := FieldByName('CTR_NOMCLI').AsString;
      arrDesGer[intIndex].strNUMDUP := FieldByName('CTR_NUMDUP').AsString;
      arrDesGer[intIndex].strPARDUP := FieldByName('PARDUP').AsString;
      arrDesGer[intIndex].strESPDOC := FieldByName('CTR_ESPDOC').AsString;
      arrDesGer[intIndex].strCODEMP := FieldByName('CTR_CODEMP').AsString;
      arrDesGer[intIndex].fltVALDUP := FieldByName('CTR_VALDUP').AsFloat;
      arrDesGer[intIndex].fltVALCAL := FieldByName('CTR_VALCAL').AsFloat;
      arrDesGer[intIndex].fltVALDES := fltValDes;
      arrDesGer[intIndex].fltVALREC := fltValRec;
      arrDesGer[intIndex].dtaDTAVEN := FieldByName('CTR_DTAVEN').AsDateTime;
      arrDesGer[intIndex].dtaDTACAD := FieldByName('CTR_DTACAD').AsDateTime;
    End;
  End;

  procedure pAplicaDescontoDuplicata(fltDesconto: Double);
    Var
      fltJurOri: Double;
  Begin
    cdsCtaRec.Edit;

    //Juro original
    fltJurOri := cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat - cdsCtaRec.FieldByName('CTR_VALDUP').AsFloat;
    If (fltJurOri > 0) Then
    Begin
      If (RoundTo(fltJurOri, -2) >= fltDesconto) Then
      Begin
        cdsCtaRec.FieldByName('CTR_VALJUR').AsFloat := (fltJurOri - cdsCtaRec.FieldByName('CTR_DESCOB').AsFloat - fltDesconto);
        If cdsCtaRec.FieldByName('CTR_VALJUR').AsFloat < 0 Then
        Begin
          cdsCtaRec.FieldByName('CTR_DESCOB').AsFloat := cdsCtaRec.FieldByName('CTR_DESCOB').AsFloat +cdsCtaRec.FieldByName('CTR_VALJUR').AsFloat;
          cdsCtaRec.FieldByName('CTR_VALJUR').AsFloat := 0.00;
        End;
        fltDesconto := 0;
      End
      Else
      Begin
        fltDesconto := fltDesconto - fltJurOri;
        cdsCtaRec.FieldByName('CTR_VALJUR').AsFloat := 0;
      End;
    End;

    cdsCtaRec.FieldByName('CTR_VALDES').AsFloat := fltDesconto;
    cdsCtaRec.FieldByName('CTR_VALREC').AsFloat := cdsCtaRec.FieldByName('CTR_VALDUP').AsFloat -
                                                   cdsCtaRec.FieldByName('CTR_VALDES').AsFloat +
                                                   cdsCtaRec.FieldByName('CTR_VALJUR').AsFloat +
                                                   cdsCtaRec.FieldByName('CTR_DESCOB').AsFloat;
    cdsCtaRec.Post;

    FCloneDatasetMarcados.Edit;
    FCloneDatasetMarcados.FieldByName('CTR_VALJUR').AsFloat := cdsCtaRec.FieldByName('CTR_VALJUR').AsFloat;
    FCloneDatasetMarcados.FieldByName('CTR_DESCOB').AsFloat := cdsCtaRec.FieldByName('CTR_DESCOB').AsFloat;;
    FCloneDatasetMarcados.FieldByName('CTR_VALDES').AsFloat := fltDesconto;
    FCloneDatasetMarcados.FieldByName('CTR_VALREC').AsFloat := cdsCtaRec.FieldByName('CTR_VALDUP').AsFloat -
                                                               cdsCtaRec.FieldByName('CTR_VALDES').AsFloat +
                                                               cdsCtaRec.FieldByName('CTR_VALJUR').AsFloat +
                                                               cdsCtaRec.FieldByName('CTR_DESCOB').AsFloat;
    FCloneDatasetMarcados.Post;
  End;

  procedure pMontaMensagem;
    Var
      i : Integer;
      fltValOrig,
      fltValDesc,
      fltValRece,
      fltSomValOri,
      fltSomDescon,
      fltSomValRec: Double;
      strCodCli: String;
  Begin
    fltSomValOri  := 0;
    fltSomDescon  := 0;
    fltSomValRec  := 0;
    fltValOrig    := 0;
    fltValDesc    := 0;
    fltValRece    := 0;
    fltTmpTotDesc := 0;
    fltValDif     := 0;
    strCodCli     := '';

    {****************************************************}
    {* FAZ ORDENAÇÃO PELO CÓD CLIENTE E DATA CADASTRO   *}
    {*************************************************FS*}
    TArray.Sort<TDescontoGeral>(arrDesGer , TDelegatedComparer<TDescontoGeral>.Construct(
      function(const Left, Right: TDescontoGeral): Integer
      begin
        Result := TComparer<String>.Default.Compare(Concat(Left.strCODCLI, DateToStr(Left.dtaDTACAD)),
                                                    Concat(Right.strCODCLI, DateToStr(Right.dtaDTACAD)));
      end));

    For i := 0 To Length(arrDesGer) - 1 Do
    Begin
      If (strCodCli <> arrDesGer[i].strCODCLI) Then
      Begin
        strCodCli  := arrDesGer[i].strCODCLI;

        If not objTabela.isEmpty Then
        Begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlTotal;
          objLinha.pAddColuna(''                 , ''                                     , 26 , alDireita , teAutcom);
          objLinha.pAddColuna('VALOR ORIGINAL'  , FloatToStrF(fltValOrig, ffNumber, 9, 2) , 30 , alDireita , teAmbos, True);
          objLinha.pAddColuna('VALOR DESCONTO'  , FloatToStrF(fltValDesc, ffNumber, 9, 2) , 30 , alDireita , teAmbos, True);
          objLinha.pAddColuna('VALOR RECEBIDO'  , FloatToStrF(fltValRece, ffNumber, 9, 2) , 30 , alDireita , teAmbos, True);
          objTabela.lstLinhas.Add(objLinha);

          fltValOrig := 0;
          fltValDesc := 0;
          fltValRece := 0;
        End;
      End;


      if objTabela.isEmpty Then
      Begin

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlCabecalho;
        objLinha.pAddColuna(''  , 'DOCUMENTO'       , 17 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , 'EMP'             , 4  , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , 'CLIENTE'         , 42 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , 'DT.VENC.'        , 9  , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , 'DT.CAD.'         , 9  , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , 'VR.DUPLICATA'    , 13 , alDireita  , teAutcom);
        objLinha.pAddColuna(''  , 'VR.CORRIGIDO(*)' , 16 , alDireita  , teAutcom);
        objTabela.lstLinhas.Add(objLinha);

      End;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('DOCUMENTO'       ,  fPadR(arrDesGer[i].strNUMDUP,12)
                                             + arrDesGer[i].strPARDUP + '-'
                                             + arrDesGer[i].strESPDOC                              , 17 , alEsquerda );
      objLinha.pAddColuna('EMP'             ,  arrDesGer[i].strCODEMP                              , 4  , alCentro   );
      objLinha.pAddColuna('CLIENTE'         ,  arrDesGer[i].strNOMCLI                              , 42 , alEsquerda );
      objLinha.pAddColuna('DT.VENC.'        ,  FormatDateTime('dd/mm/yy',arrDesGer[i].dtaDTAVEN)   , 9  , alCentro   );
      objLinha.pAddColuna('DT.CAD.'         ,  FormatDateTime('dd/mm/yy',arrDesGer[i].dtaDTACAD)   , 9  , alCentro   );
      objLinha.pAddColuna('VR.DUPLICATA'    ,  FloatToStrF(arrDesGer[i].fltVALDUP, ffNumber, 9, 2) , 13 , alDireita  );
      objLinha.pAddColuna('VR.CORRIGIDO(*)' ,  FloatToStrF(arrDesGer[i].fltVALCAL, ffNumber, 9, 2) , 16 , alDireita  );
      objTabela.lstLinhas.Add(objLinha);


      fltValOrig := fltValOrig + arrDesGer[i].fltVALCAL;
      fltValDesc := fltValDesc + arrDesGer[i].fltVALDES;
      fltValRece := fltValRece + arrDesGer[i].fltVALREC;

      fltSomValOri := fltSomValOri + arrDesGer[i].fltVALCAL;
      fltSomDescon := fltSomDescon + arrDesGer[i].fltVALDES;
      fltSomValRec := fltSomValRec + arrDesGer[i].fltVALREC;
    End;

    If (fltValOrig> 0) And (fltValdesc > 0) And (fltValRece > 0) Then
    Begin
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlTotal;
      objLinha.pAddColuna(''                , ''                                      , 26 , alDireita , teAutcom);
      objLinha.pAddColuna('VALOR ORIGINAL'  , FloatToStrF(fltValOrig, ffNumber, 9, 2) , 30 , alDireita , teAmbos, True);
      objLinha.pAddColuna('VALOR DESCONTO'  , FloatToStrF(fltValDesc, ffNumber, 9, 2) , 30 , alDireita , teAmbos, True);
      objLinha.pAddColuna('VALOR RECEBIDO'  , FloatToStrF(fltValRece, ffNumber, 9, 2) , 30 , alDireita , teAmbos, True);
      objTabela.lstLinhas.Add(objLinha);
    End;

    objLiberacao.objMsgLibera.pAddTexto('O valor do desconto é maior que o permitido.');
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor original'           , FormatFloat('#,##0.00', fltSomValOri), 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor desconto concedido' , FormatFloat('#,##0.00', fltSomDescon), 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor recebido'           , FormatFloat('#,##0.00', fltSomValRec), 25);
  End;
begin
  Application.ProcessMessages;
  Screen.Cursor := crHourGlass;
  blnDigSenha   := False;
  blnNivel2     := False;
  blnConfirma   := dicBaixa['blnConfirma'];
  strDescGer    := dicBaixa['strDescGer'];
  strValBaiTot  := dicBaixa['strValBaiTot'];
  intRecNo      := cdsCtaRec.RecNo;
  fltPerMax     := 0;

  Try
    If (blnConfirma) Then
    Begin
      fltDescGer  := fStrToFloat(strDescGer);
      fltValBaiTot:= fStrToFloat(strValBaiTot);

      Try
        FCloneDatasetMarcados.First;
        While Not FCloneDatasetMarcados.Eof Do
        Begin
          {* Se for baixa parcial e/ou Crédito não inclui desconto *}
          If (FCloneDatasetMarcados.FieldByName('CTR_TIPBAI').AsString = 'P') Or
            (FCloneDatasetMarcados.FieldByName('CTR_VALCAL').AsFloat < 0) Then
          Begin
            FCloneDatasetMarcados.Next;
            Continue;
          End;

          fltValLiq := FCloneDatasetMarcados.FieldByName('CTR_VALCAL').AsFloat;
          fltCtrDes := 1 - (fCfgSis('CTRDES', varDouble) / 100);
          fltCtrDe2 := 1 - (fCfgSis('CTRDE2', varDouble) / 100);
          strSCtrDe := fCfgSis('SCTRDE');

          fltValDesc := fGetValDes(fltValBaiTot, fltValLiq, fltDescGer);
          fltTmpTotDesc := fltTmpTotDesc + fltValDesc;

          fltPerMax := fCfgSis('CTRDES', varDouble);
          fltValPag := (FCloneDatasetMarcados.FieldByName('CTR_VALCAL').AsFloat - fltValDesc);

          If (RoundTo(fltValPag, -2) < RoundTo(fltValLiq * fltCtrDes, -2)) Then
          Begin
            pAdicionaLista(fltValDesc, fltValPag);

            If Not blnNivel2 Then
              blnNivel2 := RoundTo(fltValLiq * fltCtrDe2, -2) > RoundTo(fltValPag, -2);

            If fEmptyStr(strSenNv2) Then
              strSenNv2 := fCfgSis('SCTRD2');
          End;

          FCloneDatasetMarcados.Next;
        End;

        {*********************************}
        {* Trata a diferença de centavos *}
        {******************************FS*}
        fltValDif := fltDescGer - fltTmpTotDesc;

        If (Length(arrDesGer) > 0) Then
        Begin
          {* Se tiver diferença, joga a mesma para a primeira duplicata *}
          If (RoundTo(fltValDif, -2) <> 0) Then
          Begin
            arrDesGer[0].fltVALDES := arrDesGer[0].fltVALDES + RoundTo(fltValDif, -2);
            arrDesGer[0].fltVALREC := arrDesGer[0].fltVALREC - RoundTo(fltValDif, -2);
          End;

          objLiberacao.Clear;
          objTabela := TRegistroMsgLiberaTabela.Create;
          pMontaMensagem;
          objLiberacao.objMsgLibera.pAddTextoCaption('Desconto máximo permitido', FormatFloat('#,##0.00', fltPerMax) + '%');
          objLiberacao.objMsgLibera.pAddQuebra;

          objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

          While (not blnDigSenha) Do
          Begin
            objLiberacao.strDirAce := 'CTRDESMAX';
            objLiberacao.strSenLib := fCfgSis('SCTRDE');
            objLiberacao.strMsgSen := 'Desconto Máximo';
            objLiberacao.blnMosMen := True;
            objLiberacao.strCodOpe := strLoginUsuarioLogado;
            objLiberacao.strCodDig := strLoginUsuarioLogado;
            objLiberacao.strDirAceNv2 := 'CTRDESMA2';
            objLiberacao.strSenLibNv2 := strSenNv2;
            objLiberacao.blnNivel2 := blnNivel2;

            If (objLiberacao.fLibera) Then

              Break

            else
              If (fMensagem('', 'Senha Incorreta!', ['&Novamente', '&Desistir']) = 2) Then
                Exit;
          End;
        End;

        {* Aplica o desconto *}
        FCloneDatasetMarcados.First;
        fltTmpTotDesc := 0;
        While Not FCloneDatasetMarcados.Eof Do
        Begin
          {* Se for baixa parcial e/ou Crédito não inclui desconto *}
          If (FCloneDatasetMarcados.FieldByName('CTR_TIPBAI').AsString = 'P') Or
            (FCloneDatasetMarcados.FieldByName('CTR_VALCAL').AsFloat < 0) Then
          Begin
            FCloneDatasetMarcados.Next;
            Continue;
          End;

          fltValDesc := fGetValDes(fltValBaiTot, FCloneDatasetMarcados.FieldByName('CTR_VALCAL').AsFloat, fltDescGer);
          fltTmpTotDesc := fltTmpTotDesc + fltValDesc;

          cdsCtaRec.Locate('AUTOINCREM', FCloneDatasetMarcados.FieldByName('AUTOINCREM').AsString, []);
          pAplicaDescontoDuplicata(fltValDesc);

          FCloneDatasetMarcados.Next;
        End;

        {*********************************}
        {* Trata a diferença de centavos *}
        {******************************FS*}
        fltValDif := fltDescGer - fltTmpTotDesc;

        {* Se tiver diferença, joga a mesma para a primeira duplicata *}
        If (RoundTo(fltValDif, -2) <> 0) Then
        Begin
          FCloneDatasetMarcados.Filter   := 'CTR_TIPBAI=''T'' AND CTR_VALCAL > 0';
          FCloneDatasetMarcados.Filtered := True;
          FCloneDatasetMarcados.First;

          If FCloneDatasetMarcados.RecordCount > 0 Then
          Begin
            fltValDesc := fGetValDes(fltValBaiTot, FCloneDatasetMarcados.FieldByName('CTR_VALCAL').AsFloat, fltDescGer);
            fltValDesc := fltValDesc + RoundTo(fltValDif, -2);

            cdsCtaRec.Locate('AUTOINCREM', FCloneDatasetMarcados.FieldByName('AUTOINCREM').AsString, []);
            pAplicaDescontoDuplicata(fltValDesc);
          End
          Else
            fMensagem('ATENÇÃO', 'Não foi possível aplicar o desconto geral nas duplicatas selecionadas. ' + #13 +
                                 'É necessário selecionar ao menos uma duplicata positiva para baixa total.',
                                 ['&OK'], 0);
        End;
      Except
        On E: Exception Do
        Begin
          blnConfirma := False;
          pMensagensErro(E.message, '');
        End;
      End;
    End;

    If blnConfirma Then
    Begin
      Try
        FCloneDatasetMarcados.Filtered := False;
        pCalculaTotalDuplicatas(nil, nil, edtValorTotal, edtQtdDuplicatas, False, cdsCtaRec);
        pCalculaTotalDuplicatas(edtDescontoTotal, edtJurosTotal, edtTotalRecebido, edtQtdSelecionadas, True, FCloneDatasetMarcados);
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;
    End;
  Finally
    Screen.Cursor      := crDefault;
    FCloneDatasetMarcados.Filtered := False;
    cdsCtaRec.RecNo    := intRecNo;
  End;
end;

procedure TfrmBaixaReceber.pAtualizaDados(DataSet: TDataSet);
begin

  {**********************************************************}
  {* SE CDSCTAREC.DISABLECONTROLS FOR ENABLED VAI ATUALIZAR *}
  {* OS EDITS(EVITANDO DE 'PISCAR' A TELA)                  *}
  {********************************************************LE}

  If (Not cdsCtaRec.ControlsDisabled) And (DataSet.Active) Then
  Begin

    edtCodPorBai.Text := DataSet.FieldByName('CTR_CODPOR').AsString;
    edtNomPorBai.Text := DataSet.FieldByName('POR_NOMPOR').AsString;
    edtCodEveBai.Text := DataSet.FieldByName('CTR_CODEVE').AsString + '  ' + DataSet.FieldByName('EVE_DESEVE').AsString;

    // edtMedPond.Text := fRetornaMediaPonderadaNova(DataSet.FieldByName('CTR_CODCLI').AsString, cdsCtaRec)

    edtNosNumBai.Text := DataSet.FieldByName('CTR_NOSNUM').AsString;
    edtHistor.Texto   := DataSet.FieldByName('CTR_HIST01').AsString;
    edtNumCooRod.Text := DataSet.FieldByName('FIS_NUMCOO').AsString;
    edtDespCob.Text   := FormatFloat(',0.00', DataSet.FieldByName('CTR_DESCOB').AsFloat);

    edtDtaEnv.Text := '';

    If Not DataSet.FieldByName('CTR_DTAENV').IsNull Then
      edtDtaEnv.Text := DataSet.FieldByName('CTR_DTAENV').AsString;

    edtBcoBol.Text := DataSet.FieldByName('CTR_BCOENV').AsString;
    edtNomBan.Text := DataSet.FieldByName('CTR_NOMBCO').AsString;

    btnLimparDadosRemessa.Enabled := Not DataSet.FieldByName('CTR_DTAENV').IsNull;

    edtDespCob.Visible:= fStrToFloat(edtDespCob.Text) > 0;
    lblDespCob.Visible:= fStrToFloat(edtDespCob.Text) > 0;
  End;

end;

procedure TfrmBaixaReceber.pAtualizarValorJurosRecalculado;
var
  LSaldoJuros: Currency;
begin
  if not blnRecalJur then
    Exit;

  LSaldoJuros :=
    fFormataFloat(cdsCtaRec.FieldByName('CTR_VALCAL').AsCurrency, 2) -
    fFormataFloat(cdsCtaRec.FieldByName('CTR_VALDUP').AsCurrency, 2);

  if (not blnDescFinanSomenteAteVenc) or
     (Trunc(cdsCtaRec.FieldByName('CTR_DTAVEN').AsDatetime) >= Trunc(VS_Date)) then
  begin
    if fFormataFloat(cdsCtaRec.FieldByName('CTR_DESSUJ').AsCurrency, 2) <> 0 then
      LSaldoJuros := LSaldoJuros + fFormataFloat(cdsCtaRec.FieldByName('CTR_DESSUJ').AsCurrency, 2);

    if fFormataFloat(cdsCtaRec.FieldByName('CTR_DESCOB').AsCurrency, 2) <> 0 then
      LSaldoJuros := LSaldoJuros - fFormataFloat(cdsCtaRec.FieldByName('CTR_DESCOB').AsCurrency, 2);
  end;

  cdsCtaRec.FieldByName('CTR_VALJUR').AsCurrency := LSaldoJuros;
end;

procedure TfrmBaixaReceber.pCalculaJuros(fltPerJur, fltPerMul: Double; strAplJur: String);
  Var
    fltJuros : Double;
    intRecNo : Integer;

    strIndexFieldNames: String;
begin
  intRecNo := 0;
  With cdsCtaRec Do
  Begin
    If strAplJur = 'T' Then
    Begin
      intRecNo := RecNo;
      strIndexFieldNames := IndexFieldNames;
      IndexFieldNames := 'CTR_NOMCLI;CTR_DTAVEN';
      First;
    End;

    Try
      While Not Eof Do
      Begin
        If Not FieldByName('CTR_TX_PIX').AsString.IsEmpty Then
        Begin
          Next;
          Continue;
        End;

        If FieldByName('CTR_ESPDOC').AsString <> 'CC' Then
        Begin
          fltJuros := fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                          FieldByName('CTR_VALSUJ').AsFloat,
                                          fltPerJur,
                                          fltPerMul);

          Edit;
          FieldByName('CTR_TAXJUR').AsFloat := fltPerJur;
          FieldByName('CTR_VALJUR').AsFloat := fltJuros;
          FieldByName('CTR_PERMUL').AsFloat := fltPerMul;
          FieldByName('CTR_VALCAL').AsFloat := FieldByName('CTR_VALSUJ').AsFloat + fltJuros;
          FieldByName('CTR_VALCAL_ORI').AsFloat := FieldByName('CTR_VALCAL').AsFloat;
          Post;

          fltPercJurosAplicado := fltPerJur;

        End;

        If (strAplJur = 'D') Then
          Break;

        Application.ProcessMessages;
        Next;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;

    If (strAplJur = 'T') Then
    Begin
      IndexFieldNames := strIndexFieldNames;
      RecNo := intRecNo;
    End;
  End;
end;

procedure TfrmBaixaReceber.pCalculaTotalDuplicatas(edtDesconto, edtJuros,
  edtTotal, edtQuant: TEditFocus; blnFiltrar: Boolean; ADataset: TDataset);
  Var
    LValorTotal,
    LValorCreditoSelecionado,
    LValorDesconto,
    LValorJuros: Double;

begin
  Application.ProcessMessages;

  LValorTotal := 0.00;
  LValorCreditoSelecionado := 0.00;
  LValorDesconto := 0.00;
  LValorJuros := 0.00;

  ADataset.First;
  While Not ADataset.Eof Do
  Begin
    LValorTotal := LValorTotal + ADataset.FieldByName(IIF(blnFiltrar, 'CTR_VALREC', 'CTR_VALCAL')).AsFloat;
    LValorCreditoSelecionado := LValorCreditoSelecionado + ADataset.FieldByName('CTR_CREPRO').AsFloat;

    If blnFiltrar Then
    Begin
      LValorDesconto := LValorDesconto + ADataset.FieldByName('CTR_VALDES').AsFloat;
      LValorJuros := LValorJuros + ADataset.FieldByName('CTR_VALJUR').AsFloat;
    End;

    ADataset.Next;
  End;

  If blnFiltrar Then
  Begin
    edtDesconto.Text := FormatFloat(',0.00', LValorDesconto);
    edtJuros.Text := FormatFloat(',0.00', LValorJuros);
  End;

  edtTotal.Text    := FormatFloat(',0.00', LValorTotal);
  fltCreSel        := fFormataFloat(LValorCreditoSelecionado, 2);

  edtQuant.Text    := ADataset.RecordCount.ToString;
end;

procedure TfrmBaixaReceber.pCalculaValorCorrigido;
  Var
    fltJuros, fltValDespon: Double;
    bCreditoGeradoPorDevolucao: Boolean;
begin
  Application.ProcessMessages;
  fltValDespon := 0;

  Try
    Try
      cdsCtaRec.First;
      While Not cdsCtaRec.Eof Do
      Begin
        fltJuros := fCalculaJurosCadCtr(cdsCtaRec.FieldByName('CTR_DTAVEN').AsDateTime,
                                        cdsCtaRec.FieldByName('CTR_VALSUJ').AsFloat,
                                        cdsCtaRec.FieldByName('CTR_TAXJUR').AsFloat,
                                        cdsCtaRec.FieldByName('CTR_PERMUL').AsFloat);

        cdsCtaRec.Edit;


        if (blnDescFinanSomenteAteVenc) then
        begin
          If (cdsCtaRec.FieldByName('CTR_DTAVEN').asDateTime >= VS_Date)  then
            cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat := cdsCtaRec.FieldByName('CTR_VALSUJ').AsFloat + fltJuros
          else
            cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat := cdsCtaRec.FieldByName('CTR_VALSUJ').AsFloat + fltJuros;
        end
        else
        If (cdsCtaRec.FieldByName('CTR_DTAVEN').asDateTime >= VS_Date)  then
          cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat := cdsCtaRec.FieldByName('CTR_VALSUJ').AsFloat + fltJuros
        else
         cdsCtaRec. FieldByName('CTR_VALCAL').AsFloat := cdsCtaRec.FieldByName('CTR_VALSUJ').AsFloat + fltJuros;

        cdsCtaRec.FieldByName('CTR_CALORI').AsFloat := cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat;

        If cdsCtaRec.FieldByName('CTR_ESPDOC').AsString <> 'CC' Then
        Begin
          cdsCtaRec.FieldByName('CTR_VALJUR').AsFloat := fltJuros;

          {******************************************************************************************}
          {* CÁLCULO DE DESCONTO DE PONTUALIDADE QUANDO NÃO TIVER JUROS REFERENTES A DIAS DE ATRASO *}
          {******************************************************************************************}
          IF Not (fltJuros > 0) And Not(cdsCtaRec.FieldByName('FGO_BOLADT').AsFloat > 0.00) Then
          begin
            if (blnDescFinanSomenteAteVenc) then
            begin
              If (fCfgSis('DESPON', varBoolean)) And
                 (VS_Date <= (cdsCtaRec.FieldByName('CTR_DTAVEN').asDateTime + fField('CTR_QTDDAV').AsInteger)) Then
              Begin
                fltValDespon  := fFormataFloat(cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat * ( fField('CTR_PERDPO').AsFloat / 100.00 ),2);
              End;
            end
            else
            begin
              If (fCfgSis('DESPON', varBoolean)) And
                 (VS_Date <= (cdsCtaRec.FieldByName('CTR_DTAVEN').asDateTime - fField('CTR_QTDDAV').AsInteger)) Then
              Begin
                fltValDespon  := fFormataFloat(cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat * ( fField('CTR_PERDPO').AsFloat / 100.00 ),2);
              End;
            end;

            bCreditoGeradoPorDevolucao :=
              (cdsCtaRec.FieldByName('CTR_VALDUP').AsFloat < 0) And
              Not fEmptyStr(cdsCtaRec.FieldByName('GER_NUMDOC').AsString);

            If bCreditoGeradoPorDevolucao or (fltValDespon > 0) then
              cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat := cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat - fltValDespon;
          end;
        End
        Else
          cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat := cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat - fltJuros;

        cdsCtaRec. FieldByName('CTR_VALCAL_ORI').AsFloat := cdsCtaRec. FieldByName('CTR_VALCAL').AsFloat;

        cdsCtaRec.Post;
        cdsCtaRec.Next;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  Finally
    cdsCtaRec.First;
    pAtualizaDados(cdsCtaRec);
  End;
end;

procedure TfrmBaixaReceber.pCarregaCliente;
begin
  If Not fEmptyStr(edtCodCli.Text) Then
  Begin
    edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
    pPesquisaCadCli(qryConCli, qryConCli, edtCodCli.Text);
  End
  Else
    edtNomCli.Clear;
end;

procedure TfrmBaixaReceber.pCarregaEmpresa;
begin
  If Not fEmptyStr(edtCodEmp.Text) Then
  Begin
    edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
    pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  End
  Else
    edtNomEmp.Clear;
end;

procedure TfrmBaixaReceber.pCarregaEvento;
begin
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

procedure TfrmBaixaReceber.pCarregaPortador;
begin
  If Not fEmptyStr(edtCodPortador.Text) Then
  Begin
    edtDesPortador.Text := fRetNomPortador(edtCodPortador.Text);
    pPesquisaCadPor(Nil, qryConPor, edtCodPortador.Text);
  End
  Else
    edtDesPortador.Clear;
end;

procedure TfrmBaixaReceber.pCarregaRede;
begin
  If Not fEmptyStr(edtCodRed.Text) Then
    edtDesRed.Text := fRetNomeRedeLoja(edtCodRed.Text)
  Else
    edtDesRed.Clear;
end;

procedure TfrmBaixaReceber.pCarregaVendedor;
begin
  If Not fEmptyStr(edtCodven.Text) Then
    edtNomVen.Text := fRetNomVendRep(edtCodven.Text)
  Else
    edtNomVen.Clear;
end;

procedure TfrmBaixaReceber.pChamarManutencaoCtr;
Var
  frmCadCtaReceber: TfrmCadCtaReceber;
  qryTmp: TUniQuery;
  strSQL: String;
begin

  If cdsCtaRec.FieldByName('CTR_MARDES').AsString = 'M' Then
  Begin
    pMensagemOk('Para usar essa funcionalidade favor desmarcar a(s) duplicata(s) selecionada(s).');
    Exit;
  End;

  Try
    If fDuplicataTravada(fField('NRODUP').AsString,
                         fField('CTR_ESPDOC').AsString,
                         fField('CTR_CODEMP').AsString,
                         fField('CTR_CODCLI').AsString,
                         fField('PARDUP').AsString,
                         blnMarcandoTodas) Then Exit;

    pCriarFormularios(TfrmCadCtaReceber, frmCadCtaReceber);
    frmCadCtaReceber.strAutoIncrem := cdsCtaRec.FieldByName('AUTOINCREM').AsString;
    frmCadCtaReceber.strOrigem     := 'frmBaixaReceber';
    frmCadCtaReceber.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmBaixaReceber.pChamarManutencaoCtr]');
  End;
  pFreeAndNil(frmCadCtaReceber);

  pDestravarParcela(fField('NRODUP').AsString,
                  fField('CTR_ESPDOC').AsString,
                  fField('CTR_CODEMP').AsString,
                  fField('CTR_CODCLI').AsString,
                  fField('PARDUP').AsString);

  strSQL := 'SELECT CLI_C_G_C_, CLI_NOMCLI, EVE_DESEVE, POR_NOMPOR, R.* ' +
            ' FROM CADREC R                    ' +
            ' LEFT JOIN CADCLI C               ' +
            '   ON C.CLI_CODCLI = R.CTR_CODCLI ' +
            ' LEFT JOIN CADEVE E               ' +
            '   ON E.EVE_CODEVE = R.CTR_CODEVE ' +
            ' LEFT JOIN CADPOR P               ' +
            '   ON P.POR_CODPOR = R.CTR_CODPOR ' +
            ' WHERE R.AUTOINCREM = ' + QuotedStr(cdsCtaRec.FieldByName('AUTOINCREM').AsString)+ ' ';

  qryTmp := fCriarQuery(strSQL, Self);
  qryTmp.Open;

  If qryTmp.IsEmpty Then
  Begin
    {*************************************************}
    {* CASO NÃO ENCONTRAR A DUPLICATA, ASSUME QUE    *}
    {* O USUÁRIO A EXCLUIU NA MANUT. DO CTA. RECEBER *}
    {**********************************************AM*}
    cdsCtaRec.Delete;
  End
  Else
  Begin
    cdsCtaRec.Edit;
    cdsCtaRec.FieldByName('CTR_NUMDUP').AsString   := qryTmp.FieldByName('CTR_NUMDUP').AsString +
                                                      qryTmp.FieldByName('CTR_PARCEL').AsString;
    cdsCtaRec.FieldByName('NRODUP').AsString       := qryTmp.FieldByName('CTR_NUMDUP').AsString;
    cdsCtaRec.FieldByName('PARDUP').AsString       := qryTmp.FieldByName('CTR_PARCEL').AsString;
    cdsCtaRec.FieldByName('CTR_CODEMP').AsString   := qryTmp.FieldByName('CTR_CODEMP').AsString;
    cdsCtaRec.FieldByName('CTR_CODCLI').AsString   := qryTmp.FieldByName('CTR_CODCLI').AsString;
    cdsCtaRec.FieldByName('CLI_NOMCLI').AsString   := qryTmp.FieldByName('CLI_NOMCLI').AsString;
    cdsCtaRec.FieldByName('CTR_ESPDOC').AsString   := qryTmp.FieldByName('CTR_ESPDOC').AsString;
    cdsCtaRec.FieldByName('CTR_SEQBAI').AsString   := qryTmp.FieldByName('CTR_SEQBAI').AsString;
    cdsCtaRec.FieldByName('CTR_DTACAD').AsDateTime := qryTmp.FieldByName('CTR_DTACAD').AsDateTime;
    cdsCtaRec.FieldByName('CTR_VALDUP').AsFloat    := qryTmp.FieldByName('CTR_VALDUP').AsFloat;
    cdsCtaRec.FieldByName('CTR_DESSUJ').AsFloat    := qryTmp.FieldByName('CTR_DESSUJ').AsFloat;
    cdsCtaRec.FieldByName('CTR_JURSUJ').AsFloat    := qryTmp.FieldByName('CTR_JURSUJ').AsFloat;
    cdsCtaRec.FieldByName('CTR_DTAVEN').AsDateTime := qryTmp.FieldByName('CTR_DTAVEN').AsDateTime;
    cdsCtaRec.FieldByName('CTR_DESCOB').AsFloat    := qryTmp.FieldByName('CTR_JURSUJ').AsFloat;
    cdsCtaRec.FieldByName('CTR_DESCON').AsString   := qryTmp.FieldByName('CTR_DESCON').AsString;
    cdsCtaRec.FieldByName('CTR_CODPOR').AsString   := qryTmp.FieldByName('CTR_CODPOR').AsString;
    cdsCtaRec.FieldByName('CTR_CODVEN').AsString   := qryTmp.FieldByName('CTR_CODVEN').AsString;
    cdsCtaRec.FieldByName('CTR_CODEVE').AsString   := qryTmp.FieldByName('CTR_CODEVE').AsString;
    cdsCtaRec.FieldByName('EVE_DESEVE').AsString   := qryTmp.FieldByName('EVE_DESEVE').AsString;
    cdsCtaRec.FieldByName('CTR_HIST01').AsString   := qryTmp.FieldByName('CTR_HIST01').AsString;
    cdsCtaRec.FieldByName('CTR_CODVEL').AsString   := qryTmp.FieldByName('CTR_CODVEL').AsString;
    cdsCtaRec.FieldByName('POR_NOMPOR').AsString   := qryTmp.FieldByName('POR_NOMPOR').AsString;

  End;
  qryTmp.Close;

  FreeAndNil(qryTmp);

  pCalculaTotalDuplicatas(edtDescontoTotal, edtJurosTotal, edtTotalRecebido, edtQtdSelecionadas, True, FCloneDatasetMarcados);
  pAtualizaDados(cdsCtaRec);
  pSetFocus(dbgDuplicatas);
end;

procedure TfrmBaixaReceber.pCriaTemporaria;
  Var
    strSQL   : String;
    strConjug: String;
    intCont  : Integer;
    qryCtaRec: TUniQuery;
    dspCtaRec: TUniDataSetProvider;
    strCodPrj : String;
    FCnpj : String;
begin
  Try

    // Limpa O campo Media Ponderada Obrigatóriamente caso selecione novos registros.
    edtMedPond.Clear;

    If (fCfgSis('DACPOR', varBoolean)) And
       Not (fEmptyStr(edtCodPortador.Text)) Then
    Begin
      If Not fValidaCampos(edtCodPortador) Then
      Begin
        blnMudarFoco := False;
        Exit;
      End;
    End;

    pLiberaDupsMarcadas;
    cdsCtaRec.Filter   := '';
    cdsCtaRec.Filtered := False;
    cdsCtaRec.Close;
    qryCtaRec := fCriaQuery(Nil);
    dspCtaRec := TUniDataSetProvider.Create(Nil);
    dspCtaRec.DataSet := qryCtaRec;
    cdsCtaRec.SetProvider(dspCtaRec);

    FObjetoPixRecebimento := Nil;
    FObjetoPixEmail := Nil;

    strSQL := RetornaSQLCamposTabelasTemporaria(blnDescFinanSomenteAteVenc,
                                                fraCentroCusto.edtCodEve.Text,
                                                edtRomaneio.Text);

    If Not Assigned(stlConjugadas) Then
    Begin
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  R.CTR_DTAREC IS NULL AND ';
      strSQL := strSQL + '  R.CTR_SEQBAI = 0 ';
      strSQL := strSQL + fStrLocate(edtCodPrj, arrPrj, 'IFNULL(AUX_CODPRJ,CTR_CODPRJ)', 'CODPRJ');

      If Not fEmptyStr(edtNosNum.Text) Then
      Begin
        strSQL  := strSQL  + '  AND R.CTR_NOSNUM = :NOSNUM ';
      End
      Else
      Begin

        If Not fEmptyStr(edtCodCli.Text) And (chkFiltrarFiliais.Checked) Then
        Begin
          strSQL := strSQL + '  AND (CTR_CODCLI = :CODCLI ';

          FCnpj :=  fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI','CLI_CGCCPF'], [edtCodCli.Text,'1']);
          If Not fEmptyStr(FCnpj) Then
          Begin
            strSQL := strSQL + '  OR CTR_CODCLI IN (';
            strSQL := strSQL + '     SELECT CLI_CODCLI FROM CADCLI WHERE CLI_C_G_C_ LIKE '+ QuotedStr(LeftStr(FCnpj, 8)+'%')  + ') AND CLI_CGCCPF = ' + QuotedStr('1');
          End;

          strSQL := strSQL + '  ) ';
        End
        Else If Not fEmptyStr(edtCodCli.Text) Then
          strSQL := strSQL + fStrLocate(edtCodCli, arrClientes, 'CTR_CODCLI', 'CODCLI');

        If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
          strSQL := strSQL + fStrLocate(fraCentroCusto.edtCodEve, arrEvento, 'CTR_CODEVE', 'CODEVE');

        If (Not fEmptyStr(edtCodEmp.Text)) Then
          strSQL := strSQL + fStrLocate(edtCodEmp, arrEmp, 'CTR_CODEMP', 'CODEMP')
        Else
          strSQL := strSQL + ' AND LOCATE(CTR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

        If (Not fEmptyStr(edtCodven.Text)) Then
          strSQL := strSQL + fStrLocate(edtCodven, arrVend, 'CTR_CODVEN', 'CODEVEN');

        If Not fEmptyStr(edtHistorico.Text) Then
          strSQL := strSQL + '  AND R.CTR_HIST01 LIKE :HIST01 ';

        If (Not fEmptyStr(edtCodPortador.Text)) Then
          strSQL := strSQL + fStrLocate(edtCodPortador, arrPortador, 'CTR_CODPOR', 'CODPOR')
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          strSQL := strSQL + ' AND (IFNULL(CTR_CODPOR, "") = "" ';
          strSQL := strSQL + ' OR LOCATE(CTR_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
        End;

        If Not fEmptyStr(edtCodRed.Text) Then
          strSQL := strSQL + fStrLocate(edtCodRed, arrRede, 'CLI_CODRED', 'CODRED');

        If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
          strSQL  := strSQL  + '  AND R.CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';

        If Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) Then
          strSQL := strSQL + '  AND R.CTR_DTACAD BETWEEN :DTACADINI AND :DTACADFIN ';
      End;
    End
    Else
    If stlConjugadas.Count > 0 Then
    Begin
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + 'LOCATE(R.AUTOINCREM, ';

      strConjug := '';
      For intCont := 0 To stlConjugadas.Count - 1 Do
      Begin
        strConjug := strConjug + stlConjugadas.Strings[intCont] + '_';
      End;

      strSQL := strSQL + QuotedStr(strConjug) + ')';
    End;

    If (Not fEmptyStr(strDupsGeradasAntec)) And (fCfgSis('CTRARC') = 'S') Then
    Begin
       strSQL := strSQL + ' AND R.AUTOINCREM IN (' + strDupsGeradasAntec + ') ';
    End;


    If Not fEmptyStr(edtNumCoo.Text) Then
      strSQL := strSQL + ' AND FIS_NUMCOO = :NUMCOO ';

    If Not fVerificaAcessoSistema('PEREXICRED') Then
      strSQL := strSQL + '  AND CTR_VALDUP > 0 ';

    If Not fEmptyStr(strAutIncManCtr) Then
      strSQL := strSQL + '  AND R.AUTOINCREM = :AUTINC ';

    If Not fEmptyStr(edtRomaneio.Text) Then
    Begin
      strSQL := strSQL + '  AND MOVGER.GER_NUMROM = :NUMROM  ';
      strSQL := strSQL + '  AND ROMGERX.GER_EMPROM = :EMPROM ';
    End;

    If Not fCfgSis('RECADT', VarBoolean) Then
      strSQL := strSQL + '  AND (IFNULL(FGO_BOLADT, 0.00) = 0.00)  ';

    If Not fEmptyStr(fCfgSis('POOCRE')) Then
      strSQL := strSQL + 'AND IF((CTR_VALDUP < 0),IFNULL(CTR_CODPOR,"") <> '+String(fCfgSis('POOCRE')).QuotedString+',TRUE)';

    strSQL := strSQL + ' GROUP BY R.AUTOINCREM';

    qryCtaRec.Close;
    qryCtaRec.SQL.Clear;
    qryCtaRec.SQL.Add(strSQL);
    pSetaParam(edtCodPrj.Text, arrPrj ,strCodPrj ,'CODPRJ',qryCtaRec);

    If Not fEmptyStr(strAutIncManCtr) Then
      qryCtaRec.ParamByName('AUTINC').AsString := strAutIncManCtr;

    If Not Assigned(stlConjugadas) Then
    Begin

      If Not fEmptyStr(edtNosNum.Text) Then
        qryCtaRec.ParamByName('NOSNUM').AsString := edtNosNum.Text
      Else
      Begin
        If Not fEmptyStr(edtCodCli.Text) Then
          pSetaParam(edtCodCli.Text, arrClientes, strClientes, 'CODCLI', qryCtaRec);

        If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
          pSetaParam(fraCentroCusto.edtCodEve.Text, arrEvento, strEvento, 'CODEVE', qryCtaRec);

        If (Not fEmptyStr(edtCodEmp.Text)) Then
          pSetaParam(edtCodEmp.Text, arrEmp, strEmp, 'CODEMP', qryCtaRec);

        If (Not fEmptyStr(edtCodven.Text)) Then
          pSetaParam(edtCodven.Text, arrVend, strVend, 'CODEVEN', qryCtaRec);

        If Not fEmptyStr(edtHistorico.Text) Then
          qryCtaRec.ParamByName('HIST01').AsString := '%' + edtHistorico.Text + '%';

        If (Not fEmptyStr(edtCodPortador.Text)) Then
          pSetaParam(edtCodPortador.Text, arrPortador, strPortador, 'CODPOR', qryCtaRec);

        If Not fEmptyStr(edtCodRed.Text) Then
          pSetaParam(edtCodRed.Text, arrRede, strRede, 'CODRED', qryCtaRec);

        If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          qryCtaRec.ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
          qryCtaRec.ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
        End;

        If Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) Then
        Begin
          qryCtaRec.ParamByName('DTACADINI').AsDateTime := StrToDateTime(mskDtaCadIni.Text);
          qryCtaRec.ParamByName('DTACADFIN').AsDateTime := StrToDateTime(mskDtaCadFin.Text);
        End;

        If Not fEmptyStr(edtRomaneio.Text) Then
        Begin
          qryCtaRec.ParamByName('NUMROM').AsString := edtRomaneio.Text;
          qryCtaRec.ParamByName('EMPROM').AsString := VS_strCodEmp;
        End;
      End;

    End;

    if not fEmptyStr(edtNumCoo.Text) Then
      qryCtaRec.ParamByName('NUMCOO').AsString := edtNumCoo.Text;

    Try
      qryCtaRec.Open;

      Application.ProcessMessages;

      If Not qryCtaRec.IsEmpty Then
      Begin
        ConfiguraDatasetCtaRec(False);

        pSetaClient(qryCtaRec);
        cdsCtaRec.Open;
        pSetaFields(cdsCtaRec);

        cdsCtaRec.SetProvider(nil);
        FreeAndNil(dspCtaRec);
        qryCtaRec.Close;
        FreeAndNil(qryCtaRec);

        cdsCtaRec.IndexFieldNames := 'CTR_DTAVEN;CTR_CODCLI;CTR_NUMDUP;CTR_CODEMP';

        cdsCtaRec.LogChanges := False;

        pCalculaValorCorrigido;

        FCloneDatasetMarcados := fCriaClientDatSet(cdsCtaRec, True);
        FCloneDatasetMarcados.IndexFieldNames := 'AUTOINCREM';

        pCalculaTotalDuplicatas(nil, nil, edtValorTotal, edtQtdDuplicatas, False, cdsCtaRec);
        pCalculaTotalDuplicatas(edtDescontoTotal, edtJurosTotal, edtTotalRecebido, edtQtdSelecionadas, True, FCloneDatasetMarcados);
        cdsCtaRec.FieldByName('CLI_C_G_C_').OnGetText := cdsCtaRecCLI_C_G_C_GetText;
        cdsCtaRec.First;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Não há duplicatas para serem baixadas!', ['&O k']);
        If chkLimFil.Checked Then
          pLimpaDados;
        blnMudarFoco := False;
        pSetFocus(edtCodCli);
      End;

      strNumDoc := EmptyStr;
      strDtaAnt := EmptyStr;

      If (Assigned(stlConjugadas)) And
         (stlConjugadas.Count > 0) And
         Not(cdsCtaRec.IsEmpty)    Then
        btnMarcarTodas.Click;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  Finally
    Application.ProcessMessages;
    objLock.pDestravarTodos;
    SetLength(arrLogLib, 0);
    SetLength(arrLogAvi, 0);
    strDupsGeradasAntec := '';

    If Assigned(qryCtaRec) Then
    Begin
      cdsCtaRec.SetProvider(nil);
      FreeAndNil(dspCtaRec);
      qryCtaRec.Close;
      FreeAndNil(qryCtaRec);
    End;

    objLogLibRec.CriaTabelaTemporaria();

    ConfiguraDatasetCtaRec(True);
  End;
end;

procedure TfrmBaixaReceber.pDestravarParcela(strNumDup, strEspDoc, strCodEmp,
  strCodCli, strParcel: String);
  Var
    strChaLck : String;
begin
  strChaLck := 'CADREC' +
               strNumDup +
               strEspDoc +
               strCodEmp +
               strCodCli;

  objLock.fLock_Unlock(strChaLck, False);
  objLock.fLock_Unlock(strChaLck + strParcel, False);
end;

function TfrmBaixaReceber.PermiteGerarPixEmDuplicataComBoletoHibrido: Boolean;
  Var
    LFiltroAnterior: String;

    LFiltradoAnterior: Boolean;

    LTotalCorrigido,
    LTotalRecebido: Double;
begin
  LFiltroAnterior := cdsCtaRec.Filter;
  LFiltradoAnterior := cdsCtaRec.Filtered;

  Try
    cdsCtaRec.Filter := 'CTR_MARDES=''M'' AND ' +
                        'CTR_TX_BOL IS NOT NULL AND ' +
                        'CTR_TX_BOL <> '''' ';
    cdsCtaRec.Filtered := True;

    If cdsCtaRec.IsEmpty Then
      Exit(True);

    objLiberacao.Clear;
    objLiberacao.strDirAce := 'PERGERPIXBOLHIBR';
    objLiberacao.objMsgLibera.pAddTexto('***  Permitir gerar Pix QR Code em duplicatas que possuem boletos híbridos (Código de Barras + Pix) emitidos  ***', alCentro, teAmbos, '', 124);
    objLiberacao.objMsgLibera.pAddSeparador(124);
    objLiberacao.objMsgLibera.pAddTexto('ATENÇÃO: Ao gerar o Pix QR Code para a(s) duplicata(s) seleciona(s) e for realizado o pagamento, o(s) boleto(s)', alCentro, teAmbos, '', 124);
    objLiberacao.objMsgLibera.pAddTexto('não será(ão) baixados junto ao banco. O Pix QR Code gerado não terá vínculo com o(s) boleto(s) no banco.', alCentro, teAmbos, '', 124);
    objLiberacao.objMsgLibera.pAddTexto('Caso ainda não esteja(m) baixado(s), será necessário tomar as providências necessárias para a baixa.', alCentro, teAmbos, '', 124);
    objLiberacao.objMsgLibera.pAddTexto(EmptyStr);
    objLiberacao.objMsgLibera.pAddTexto('|--------------------------------------------------------------------------------------------------------------------------|');
    objLiberacao.objMsgLibera.pAddTexto('|                               RESUMO DOS TÍTULOS SELECIONADOS COM BOLETO HÍBRIDO                                         |');
    objLiberacao.objMsgLibera.pAddTexto('|--------------------------------------------------------------------------------------------------------------------------|');
    objLiberacao.objMsgLibera.pAddTexto('| DOCUMENTO        | EMP | CLIENTE                             | DT.VENC.   | DT.CAD.    |   VR.DUPLICATA | VR.CORRIGIDO(*)|');
    objLiberacao.objMsgLibera.pAddTexto('|--------------------------------------------------------------------------------------------------------------------------|');

    cdsCtaRec.First;
    LTotalCorrigido := 0;
    LTotalRecebido := 0;

    While Not cdsCtaRec.Eof Do
    Begin
      objLiberacao.objMsgLibera.pAddTexto( '| ' + fPadR(cdsCtaRec.FieldByName('NRODUP').AsString,12) +
                                                          cdsCtaRec.FieldByName('PARDUP').AsString + '-' +
                                                          cdsCtaRec.FieldByName('CTR_ESPDOC').AsString + ' | ' +
                                                          cdsCtaRec.FieldByName('CTR_CODEMP').AsString + ' | ' +
                                                  fPadR(cdsCtaRec.FieldByName('CTR_NOMCLI').AsString, 35) + ' | ' +
                                                  FormatDateTime('dd/mm/yyyy',cdsCtaRec.FieldByName('CTR_DTAVEN').AsDateTime) + ' | ' +
                                                  FormatDateTime('dd/mm/yyyy',cdsCtaRec.FieldByName('CTR_DTACAD').AsDateTime) + ' | ' +
                                                  fPadL(FloatToStrF(cdsCtaRec.FieldByName('CTR_VALDUP').AsFloat, ffNumber, 9, 2),14) + ' | ' +
                                                  fPadL(FloatToStrF(cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat, ffNumber, 9, 2),14) + ' |');

      LTotalCorrigido := LTotalCorrigido + cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat;
      LTotalRecebido := LTotalRecebido + cdsCtaRec.FieldByName('CTR_VALREC').AsFloat;

      cdsCtaRec.Next;
    End;

    objLiberacao.objMsgLibera.pAddSeparador(124);
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTextoCaption('Total Corrigido'  , 'R$'+FormatFloat('#,###,##0.00',  LTotalCorrigido )  , 19);
    objLiberacao.objMsgLibera.pAddTextoCaption('Total Recebido'    , 'R$'+FormatFloat('#,###,##0.00',  LTotalRecebido)  , 19);
    objLiberacao.objMsgLibera.pAddQuebra;


    objLiberacao.strMsgSen := 'Permitir gerar Pix QR Code em duplicatas que possuem boletos híbridos (Código de Barras + Pix) emitidos';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
    If Result Then
      objLogLibRec.pInsereLogLigTMP(objLiberacao,
                                    cdsCtaRec.FieldByName('CTR_NUMDUP').AsString,
                                    cdsCtaRec.FieldByName('CTR_ESPDOC').AsString,
                                    cdsCtaRec.FieldByName('CTR_CODEMP').AsString);

    objLiberacao.Clear;

  Finally
    cdsCtaRec.Filter := LFiltroAnterior;
    cdsCtaRec.Filtered := LFiltradoAnterior;
  End;
end;

procedure TfrmBaixaReceber.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  If Not fEmptyStr(strCamFil) Then
  Begin
    If Pos('_VALDUP', strCamFil) > 0 Then
         Accept := FloatToStrF(fStrToFloat(strValFil),ffFixed,15,2) = FloatToStrF(DataSet.FieldByName(strCamFil).AsFloat,ffFixed,15,2)
    Else Accept := (Pos(strValFil, DataSet.FieldByName(strCamFil).AsString) > 0);
  End;
end;

procedure TfrmBaixaReceber.pImprimeRecibo(fltValorAcrescimo: Double = 0;
                                          fltValorRecebido: Double = 0);
  Var
    intCont: Integer;
    stlClientes: TStringList;
Begin
  pCarregaConfImpr(qryCfgRel, Self.Name);
  fPreImpressao(qryCfgRel, strNomFil, strTipImp, False);

  If Not fImprimeReciboLayout(fltValorAcrescimo, fltValorRecebido) Then
  Begin

    Try
      FCloneDatasetMarcados.IndexFieldNames := 'CTR_CODCLI';
      stlClientes := fCriaListaClientes;
      cdsRelCtr   := fCriaClientRecibo;
      FCloneDatasetMarcados.IndexFieldNames := 'AUTOINCREM';
      pCriarFormularios(TfrmQckReciboCtaReceber, frmQckReciboCtaReceber);

      For intCont := 0 To stlClientes.Count -1 Do
      Begin
        cdsRelCtr.Filtered := False;
        cdsRelCtr.Filter   := 'CODCLI = ' + QuotedStr(stlClientes[intCont]);
        cdsRelCtr.Filtered := True;

        frmQckReciboCtaReceber.pImprimeRecibo(False,
                                              TCfgRel.VS_blnDlgPri,
                                              Self.Name,
                                              strTipImp,
                                              strNomFil,
                                              IntToStr(intSeqCon),
                                              cdsRelCtr,
                                              fCfgSis('CTRVIA', varInteger),
                                              False,
                                              0,
                                              0,
                                              0,
                                              0,
                                              0,
                                              0,
                                              EmptyStr,
                                              EmptyStr,
                                              Nil,
                                              Nil,
                                              EmptyStr,
                                              strPorBai,
                                              strHist02);
      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;

    pFreeAndNil(frmQckReciboCtaReceber);
    FreeAndNil(stlClientes);
    FreeAndNil(cdsRelCtr);

  End;

end;

procedure TfrmBaixaReceber.pLiberaDupsMarcadas;
begin
  With cdsCtaRec Do
  Begin
    Filtered := False;
    Filter := 'CTR_MARDES = ''M''';
    Filtered := True;

    If Not IsEmpty Then
    Begin
      First;

      While Not Eof Do
      Begin
        objLock.fLock_Unlock('CADREC' +
                 FieldByName('NRODUP').AsString +
                 FieldByName('CTR_ESPDOC').AsString +
                 FieldByName('CTR_CODEMP').AsString +
                 FieldByName('CTR_CODCLI').AsString +
                 FieldByName('PARDUP').AsString, False);

        objLock.fLock_Unlock('CADREC' +
                 FieldByName('NRODUP').AsString +
                 FieldByName('CTR_ESPDOC').AsString +
                 FieldByName('CTR_CODEMP').AsString +
                 FieldByName('CTR_CODCLI').AsString, False);

        Next;
      End;
    End;
  End;
end;

procedure TfrmBaixaReceber.pLimpaDados;
begin
  pLiberaDupsMarcadas;
  cdsCtaRec.Filtered := False;
  cdsCtaRec.Close;

  edtCodPorBai.Clear;
  edtNomPorBai.Clear;
  edtCodEveBai.Clear;
  edtMedPond.Clear;
  edtNosNumBai.Clear;
  edtHistor.Clear;
  edtDespCob.Clear;
  edtDespCob.Visible := False;
  lblDespCob.Visible := False;

  edtDtaEnv.Clear;
  edtBcoBol.Clear;
  edtNomBan.Clear;      

  edtJurosTotal.Clear;
  edtDescontoTotal.Clear;
  edtValorTotal.Clear;
  edtTotalRecebido.Clear;
  edtQtdDuplicatas.Clear;
  edtQtdSelecionadas.Clear;

  mskDtaIni.Clear;
  mskDtaFin.Clear;
  mskDtaCadIni.Clear;
  mskDtaCadFin.Clear;
  edtCodCli.Clear;
  edtNomCli.Clear;
  fraCentroCusto.edtCodEve.Clear;
  fraCentroCusto.edtDesEve.Clear;
  edtCodEmp.Clear;
  edtNomEmp.Clear;
  edtCodPrj.Clear;
  edtDesPrj.Clear;
  edtCodPortador.Clear;
  edtDesPortador.Clear;
  edtCodRed.Clear;
  edtDesRed.Clear;
  edtNosNum.Clear;
  edtNumCoo.Clear;
  edtRomaneio.Clear;
  edtCodven.Clear;
  edtNomVen.Clear;
  edtHistorico.Clear;

  SetLength(arrClientes, 0);
  SetLength(arrRede, 0);
  SetLength(arrEvento, 0);
  SetLength(arrEmp, 0);
  SetLength(arrPortador, 0);
  SetLength(arrVend, 0);
  strClientes := '';
  strRede := '';
  strEvento := '';
  strEmp := '';
  strPortador := '';
  strVend := '';

  stlDupPro.Clear;

  chkFiltrarFiliais.Enabled := False;
  chkFiltrarFiliais.Checked := False;

  FObjetoPixRecebimento := Nil;
  FObjetoPixEmail := Nil;

  If FCloneDatasetMarcados.Active Then
    FCloneDatasetMarcados.EmptyDataSet;

  edtQtdDulSel.Clear;
  edtTotVlrOrg.Clear;
  edtTotVlrCorr.Clear;
end;

procedure TfrmBaixaReceber.pLimpaInfo;
begin
  pnlInfo.Caption := '';
end;

procedure TfrmBaixaReceber.pMarcaDuplicata(blnMarcar: Boolean;
                                           strTipBai: String;
                                           fltValor,
                                           fltValDes,
                                           fltValJur: Double;
                                           strDtaRec: String;
                                           ACalculoBaixaParcial: Double;
                                           ADadosParcial: TDadosBaixaParcial;
                                           blnRecAut: Boolean = False;
                                           fltDesCob: Double = 0;
                                           fltValCal: Double = 0);
  Var
    dtaDtaVen: TDateTime;
    fltTaxJur,
    fltJuros : Double;
    blnBolAdt : Boolean;
begin

  if (not fVerificaDireitoBaixa) then
	begin
    pMensagemOk('Usuário não tem permissão para fazer baixa nesta empresa.');
  	Exit;
	end;

  blnBolAdt := fApenasBoletoAdiantamento;
  If blnMarcar And (((Not blnBolAdt) And (fField('FGO_BOLADT').AsFloat > 0)) Or
                   ((blnBolAdt) And (fField('FGO_BOLADT').AsFloat = 0))) And (Not FCloneDatasetMarcados.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!','Duplicata de espécie PD cujos boletos foram emitidos somente é permitido selecionar '+
                         'com duplicatas de espécie PD cujos boletos foram emitidos!', ['&Ok']);
    Exit;
  End;

  If blnMarcar And fDuplicataTravada(fField('NRODUP').AsString,
                                     fField('CTR_ESPDOC').AsString,
                                     fField('CTR_CODEMP').AsString,
                                     fField('CTR_CODCLI').AsString,
                                     fField('PARDUP').AsString,
                                     blnMarcandoTodas) Then
    Exit;

  dtaDtaVen := fField('CTR_DTAVEN').AsDateTime;
  fltTaxJur := fField('CTR_TAXJUR').AsFloat;
  With   cdsCtaRec Do
  Begin
    Edit;
    FieldByName('CTR_MARDES').AsString := 'D';
    If blnMarcar Then
      FieldByName('CTR_MARDES').AsString := 'M';
    FieldByName('CTR_TIPBAI').AsString := strTipBai;
    FieldByName('CTR_VALREC').AsFloat := fltValor;

    If blnMarcar Then
    Begin
      If fltValCal > 0 Then
         cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat := fltValCal;
      FieldByName('CTR_DESCOB').AsFloat := fltDesCob;
      FieldByName('CTR_RECAUT').AsString := IIF(blnRecAut, 'S', 'N');
      FieldByName('CTR_DTAREC').AsDateTime := StrToDateTime(strDtaRec);

      If (blnDescFinanSomenteAteVenc) And
         (FieldByName('CTR_DTAREC').AsDateTime <= FieldByName('CTR_DTAVEN').AsDateTime) Then
      Begin
        FieldByName('CTR_VALSUJ').AsFloat := FieldByName('CTR_VALSUJ_COM_DESC').AsFloat;
      End;

      fltJuros := cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat - cdsCtaRec.FieldByName('CTR_VALSUJ').AsFloat;

      If ((fltJuros > 0) And (strTipBai = 'P')) Then
      Begin
        if fCfgSis('JURPAR') = 'N' Then
        begin
          if not fLiberaBaixaParcialComJuros(fltValor) then
            blnMarcar :=False;
        end;
      end;

      FieldByName('VALORNOVADUPLICATA').AsFloat     := ADadosParcial.ValorNovaDuplicata;
      FieldByName('JUROSNOVADUPLICATA').AsFloat     := ADadosParcial.JurosNovaDuplicata;
      FieldByName('DESCONTONOVADUPLICATA').AsFloat  := ADadosParcial.DescontoNovaDuplicata;
      FieldByName('DESPESASNOVADUPLICATA').AsFloat  := ADadosParcial.DespesasNovaDuplicata;
      FieldByName('VALORBAIXADUPLICATA').AsFloat    := ADadosParcial.ValorBaixaDuplicata;
      FieldByName('DESPESASBAIXADUPLICATA').AsFloat := ADadosParcial.DespesasBaixaDuplicata;
      FieldByName('FATORBAIXADUPLICATA').AsFloat    := ADadosParcial.FatorBaixaDuplicata;
      FieldByName('FATORJUROSDUPLICATA').AsFloat    := ADadosParcial.FatorJurosDuplicata;

    End
    Else
    Begin
      FieldByName('CTR_RECAUT').AsString := 'N';
      If blnDescFinanSomenteAteVenc Then
        FieldByName('CTR_VALSUJ').AsFloat := FieldByName('CTR_VALSUJ_ORI').AsFloat;

      // carrega valores alterados, feito isso pq os valores podem ter
      // sido alterados devido a alteração da desp. Cob.; verificar se vai influenciar no pagto. parcial;
      If Not blnMarcandoTodas Then
      Begin
        FieldByName('CTR_VALCAL').AsFloat := FieldByName('CTR_VALCAL_ORI').AsFloat;
        FieldByName('CTR_DESCOB').AsFloat := FieldByName('CTR_DESCOB_ORI').AsFloat;
      End;

      FieldByName('CTR_DTAREC').Value   := Null;
      fltValDes := 0.0;
      fltValJur := fCalculaJurosCadCtr(dtaDtaVen, FieldByName('CTR_VALSUJ').AsFloat, fltTaxJur);

      FieldByName('VALORNOVADUPLICATA').AsFloat    := 0.00;
      FieldByName('JUROSNOVADUPLICATA').AsFloat    := 0.00;
      FieldByName('DESCONTONOVADUPLICATA').AsFloat := 0.00;
      FieldByName('DESPESASNOVADUPLICATA').AsFloat  := 0.00;
      FieldByName('VALORBAIXADUPLICATA').AsFloat   := 0.00;
      FieldByName('DESPESASBAIXADUPLICATA').AsFloat := 0.00;
      FieldByName('FATORBAIXADUPLICATA').AsFloat   := 0.000000;
      FieldByName('FATORJUROSDUPLICATA').AsFloat   := 0.000000;
    End;

//    If blnDescFinanSomenteAteVenc Then
//      FieldByName('CTR_VALCAL').AsFloat := fltValJur + FieldByName('CTR_VALSUJ').AsFloat;

    FieldByName('CTR_VALDES').AsFloat  := fltValDes;
    FieldByName('CTR_VALJUR').AsFloat  := fltValJur;

    FieldByName('CALCULOBAIXAPARCIAL').AsFloat  := ACalculoBaixaParcial;

    Post;
  End;

  If blnMarcar Then
    pMarcarDuplicata(True,False)
  Else
    pMarcarDuplicata(False);
end;

procedure TfrmBaixaReceber.pMarcarDuplicata(blnMarcar: Boolean; blnVerTrava: Boolean = True; blnRecAut: Boolean = False; blnSelTodas : Boolean = False);
begin

  if fVerificaDireitoBaixa then
	begin
    cdsCtaRec.Edit;
    If (blnMarcar) Then
    Begin
      Application.ProcessMessages;
      If Not fVerificaDupExiste(fField('NRODUP').AsString,
                                fField('PARDUP').AsString,
                                fField('CTR_ESPDOC').AsString,
                                fField('CTR_CODEMP').AsString,
                                fField('CTR_CODCLI').AsString,
                                fField('CTR_SEQBAI').AsInteger) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esta duplicata não está mais disponível para baixa.' + #13#10 +
                              'Verifique se a mesma foi baixada ou confirmada por outra estação.', ['&Ok']);
        Exit;
      End;

      If blnVerTrava And (Not blnSelTodas) And fDuplicataTravada(fField('NRODUP').AsString,
                                                                 fField('CTR_ESPDOC').AsString,
                                                                 fField('CTR_CODEMP').AsString,
                                                                 fField('CTR_CODCLI').AsString,
                                                                 fField('PARDUP').AsString,
                                                                 blnMarcandoTodas) Then
        Exit;

      fField('CTR_MARDES').AsString := 'M';
      fField('CTR_RECAUT').AsString := IIF(blnRecAut, 'S', 'N');
    End
    Else
    Begin
      pDestravarParcela(fField('NRODUP').AsString,
                        fField('CTR_ESPDOC').AsString,
                        fField('CTR_CODEMP').AsString,
                        fField('CTR_CODCLI').AsString,
                        fField('PARDUP').AsString);

      fField('CTR_MARDES').AsString := 'D';
      fField('CTR_VALREC').AsFloat  := 0.0;
      fField('CTR_VALRES').AsFloat  := 0.0;
      fField('CTR_VALJUR').AsFloat  := 0.0;
      fField('CTR_VALDES').AsFloat  := 0.0;
      fField('CTR_RECAUT').AsString := 'N';

      fField('VALORNOVADUPLICATA').AsFloat     := 0.00;
      fField('VALORBAIXADUPLICATA').AsFloat    := 0.00;
      fField('DESPESASBAIXADUPLICATA').AsFloat := 0.00;
      fField('FATORBAIXADUPLICATA').AsFloat    := 0.000000;
      fField('FATORJUROSDUPLICATA').AsFloat    := 0.000000;
      fField('JUROSNOVADUPLICATA').AsFloat     := 0.00;
      fField('DESCONTONOVADUPLICATA').AsFloat  := 0.00;
      fField('DESPESASNOVADUPLICATA').AsFloat := 0.00;

      pVerificaDestravarLckProf;
    End;

    if blnMarcar And Not fEmpresaTemAcessoPortador(fField('CTR_CODPOR').AsString,
                                                   VS_strCodEmp) Then
    Begin
      fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);

      pDestravarParcela(fField('NRODUP').AsString,
                        fField('CTR_ESPDOC').AsString,
                        fField('CTR_CODEMP').AsString,
                        fField('CTR_CODCLI').AsString,
                        fField('PARDUP').AsString);

      fField('CTR_MARDES').AsString := 'D';
      fField('CTR_VALREC').AsFloat  := 0.0;
      fField('CTR_VALRES').AsFloat  := 0.0;
      fField('CTR_VALJUR').AsFloat  := 0.0;
      fField('CTR_VALDES').AsFloat  := 0.0;
      fField('CTR_RECAUT').AsString := 'N';

      fField('VALORNOVADUPLICATA').AsFloat     := 0.00;
      fField('VALORBAIXADUPLICATA').AsFloat    := 0.00;
      fField('DESPESASBAIXADUPLICATA').AsFloat := 0.00;
      fField('FATORBAIXADUPLICATA').AsFloat    := 0.000000;
      fField('FATORJUROSDUPLICATA').AsFloat    := 0.000000;
      fField('JUROSNOVADUPLICATA').AsFloat     := 0.00;
      fField('DESCONTONOVADUPLICATA').AsFloat  := 0.00;
      fField('DESPESASNOVADUPLICATA').AsFloat  := 0.00;

      pVerificaDestravarLckProf;
    End;
    cdsCtaRec.Post;

    If Not blnMarcandoTodas Then
    Begin
      If fField('CTR_MARDES').AsString = 'M' Then
        IncluiRegistroMarcado
      Else
      Begin
        If FCloneDatasetMarcados.Locate('AUTOINCREM', fField('AUTOINCREM').AsString, []) Then
          FCloneDatasetMarcados.Delete;
      End;

      pCalculaTotalDuplicatas(edtDescontoTotal, edtJurosTotal, edtTotalRecebido, edtQtdSelecionadas, True, FCloneDatasetMarcados);
    End;
  end;
end;

procedure TfrmBaixaReceber.pMostraObsCliente;
begin
  If fEmptyStr(edtCodCli.Text) Or (Not qryConCli.Active) Then
    Exit;

  If (fEmptyStr(qryConCli.FieldByName('CLI_OBSERV').AsString)) Then
    Exit;

  Try
    pCriarFormularios(TfrmFatMostraObsCliente, frmFatMostraObsCliente);
    frmFatMostraObsCliente.memObserv.Text := qryConCli.FieldByName('CLI_OBSERV').AsString;
    frmFatMostraObsCliente.strCodCli      := qryConCli.FieldByName('CLI_CODCLI').AsString;
    frmFatMostraObsCliente.showModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  pFreeAndNil(frmFatMostraObsCliente);
end;

procedure TfrmBaixaReceber.pRecalculaJuros;
  Var
    blnConfirma,
    blnEncMarcado: Boolean;
    strAplJur    : String;
    fltPerJur,
    fltPerMul    : Double;
    intRecNo     : Integer;

    blnNivel2,
    blnNivel3    : Boolean;
    strSenJM2,
    strSenJM3    : String;
    fltJurAnt,
    sumValDup,
    sumValCor    : Double;
    objTabela  : TRegistroMsgLiberaTabela;
    objLinha   : TLinhaMsgLibera;
begin
  Application.ProcessMessages;
  Screen.Cursor := crHourGlass;
  blnConfirma :=  dicBaixa['blnConfirma'];
  strAplJur := dicBaixa['strAplJur'];


  blnEncMarcado := False;
  intRecNo := cdsCtaRec.RecNo;

  if cdsCtaRec.Locate('CTR_MARDES', 'M', []) THEN
    blnEncMarcado := True;

  cdsCtaRec.RecNo := intRecNo;

  Try
    ConfiguraDatasetCtaRec(False);

    If (blnConfirma) Then
    Begin
      If (strAplJur = 'T') And (blnEncMarcado) Then
      Begin
        fMensagem('', 'Para efetuar o recálculo do juros, nenhuma duplicata pode estar selecionada!', ['&Ok']);
        Screen.Cursor := crDefault;
        Exit;
      End
      Else If (strAplJur = 'D') And (fField('CTR_MARDES').AsString = 'M') Then
      Begin
        fMensagem('', 'Para efetuar o recálculo do juros a duplicata não pode estar selecionada!', ['&Ok']);
        Screen.Cursor := crDefault;
        Exit;
      End
      Else If (strAplJur = 'D') Then
      Begin
        If Not cdsCtaRec.FieldByName('CTR_TX_PIX').AsString.IsEmpty Then
        Begin
          fMensagem('ATENÇÃO', 'Não é possível efetuar o recálculo do juros pois a duplicata possui Pix gerado e ativo!', ['&Ok']);
          Screen.Cursor := crDefault;
          Exit;
        End;
      End;

      fltPerJur := fStrToFloat(dicBaixa['fltPerJur']);
      fltPerMul := fStrToFloat(dicBaixa['fltPerMul']);

      fltPercJurosAplicado := fltPerJur;

      Try
        fltJurAnt := fCfgSis('JURATR', varDouble);

        pCalculaJuros(fltPerJur, fltPerMul,  strAplJur);

        With cdsCtaRec Do
        Begin
          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddQuebra;
          objLiberacao.objMsgLibera.pAddSeparador(125);
          If fCfgSis('SENJM1') <> '' Then
            objLiberacao.objMsgLibera.pAddTexto('JUROS MENOR QUE O PERMITIDO', alCentro, teAmbos, '',125)
          else
            objLiberacao.objMsgLibera.pAddTexto('ACESSO AO RECÁLCULO DE JUROS', alCentro, teAmbos, '',125);


          objTabela := TRegistroMsgLiberaTabela.Create;

          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlCabecalho;
          objLinha.pAddColuna(''  , 'DOCUMENTO'       , 17 , alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'EMP'             , 4  , alCentro   , teAutcom);
          objLinha.pAddColuna(''  , 'CLIENTE'         , 42 , alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'DT.VENC.'        , 9  , alCentro   , teAutcom);
          objLinha.pAddColuna(''  , 'DT.CAD.'         , 9  , alCentro   , teAutcom);
          objLinha.pAddColuna(''  , 'VR.DUPLICATA'    , 13 , alDireita  , teAutcom);
          objLinha.pAddColuna(''  , 'VR.CORRIGIDO(*)' , 16 , alDireita  , teAutcom);
          objTabela.lstLinhas.Add(objLinha);

          sumValDup := 0;
          sumValCor := 0;

          If (strAplJur = 'T') Then
            First;

          While Not Eof Do
          Begin
            If Not FieldByName('CTR_TX_PIX').AsString.IsEmpty Then
            Begin
              Next;
              Continue;
            End;

            objLinha  := TLinhaMsgLibera.Create;
            objLinha.enuTipoLinha := tlValor;
            objLinha.pAddColuna('DOCUMENTO'       ,  fPadR(FieldByName('NRODUP').AsString,12)
                                                   + FieldByName('PARDUP').AsString + '-'
                                                   + FieldByName('CTR_ESPDOC').AsString                              , 17 , alEsquerda );
            objLinha.pAddColuna('EMP'             ,  FieldByName('CTR_CODEMP').AsString                              , 4  , alCentro   );
            objLinha.pAddColuna('CLIENTE'         ,  FieldByName('CTR_NOMCLI').AsString                              , 42 , alEsquerda );
            objLinha.pAddColuna('DT.VENC.'        ,  FormatDateTime('dd/mm/yy',FieldByName('CTR_DTAVEN').AsDateTime) , 9  , alCentro   );
            objLinha.pAddColuna('DT.CAD.'         ,  FormatDateTime('dd/mm/yy',FieldByName('CTR_DTACAD').AsDateTime) , 9  , alCentro   );
            objLinha.pAddColuna('VR.DUPLICATA'    ,  FloatToStrF(FieldByName('CTR_VALDUP').AsFloat, ffNumber, 9, 2)  , 13 , alDireita  );
            objLinha.pAddColuna('VR.CORRIGIDO(*)' ,  FloatToStrF(FieldByName('CTR_VALCAL').AsFloat, ffNumber, 9, 2)  , 16 , alDireita  );
            objTabela.lstLinhas.Add(objLinha);

            sumValDup := sumValDup + FieldByName('CTR_VALDUP').AsFloat;
            sumValCor := sumValCor + FieldByName('CTR_VALCAL').AsFloat;

            If (strAplJur = 'T') Then
              Next
            Else
              Break;
          End;

          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlTotal;
          objLinha.pAddColuna(''                , 'TOTAIS'                                , 89 , alDireita, teAutcom );
          objLinha.pAddColuna('VR.DUPLICATA'    ,  FloatToStrF(sumValDup, ffNumber, 9, 2) , 13 , alDireita  );
          objLinha.pAddColuna('VR.CORRIGIDO(*)' ,  FloatToStrF(sumValCor, ffNumber, 9, 2) , 16 , alDireita  );
          objTabela.lstLinhas.Add(objLinha);

          objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);


          objLiberacao.objMsgLibera.pAddTextoCaption('(*)Taxa de Juros aplicada', FloatToStrF(fltPerJur, ffNumber, 3, 2) + '%', 25 , alDireita, teAmbos, '', 6);
          objLiberacao.objMsgLibera.pAddSeparador(125);
        End;

        blnNivel2 := (fltPerJur < fCfgSis('JURMN1', varDouble)) And (fltPerJur >= fCfgSis('JURMN2', varDouble));
        strSenJM2 := fCfgSis('SENJM2');

        blnNivel3 := fltPerJur < fCfgSis('JURMN2', varDouble);
        strSenJM3 := fCfgSis('SENJM3');

        If (fCfgSis('SENJM1') <> '') And (fltPerJur < fCfgSis('JURMN1', varDouble)) Then
        begin
          objLiberacao.strDirAce := 'SENJM1';
          objLiberacao.strSenLib := fCfgSis('SENJM1');
          objLiberacao.strMsgSen := 'Recalcular Juros';
          objLiberacao.strCodOpe := strLoginUsuarioLogado;
          objLiberacao.strDirAceNv2 := 'SENJM2';
          objLiberacao.strSenLibNv2 := strSenJM2;
          objLiberacao.blnNivel2 := blnNivel2;
          objLiberacao.strDirAceNv3 := 'SENJM3';
          objLiberacao.strSenLibNv3 := strSenJM3;
          objLiberacao.blnNivel3 := blnNivel3;
          objLiberacao.objMsgLibera.strTitulo := 'O valor de juros é menor que o permitido.';

          blnConfirma := objLiberacao.fLibera;

          if blnConfirma then
             objLogLibRec.pInsereLogLigTMP( objLiberacao, cdsCtaRec.FieldByName('CTR_NUMDUP').AsString, cdsCtaRec.FieldByName('CTR_ESPDOC').AsString, cdsCtaRec.FieldByName('CTR_CODEMP').AsString );

        end
        Else If (fCfgSis('SENJM1') = '') Or
                ((fCfgSis('JURMN1', varDouble) <= 0) Or
                 (fCfgSis('JURMN1', varString) = '')) Then
        begin

          objLiberacao.strDirAce := 'CTRSJU';
          objLiberacao.strSenLib := fCfgSis('SENJUR');
          objLiberacao.strMsgSen := 'Recalcular Juros';
          objLiberacao.strCodOpe := strLoginUsuarioLogado;
          objLiberacao.objMsgLibera.strTitulo := 'Permitir recálculo de juros no recebimento.';

          blnConfirma := objLiberacao.fLibera;

          If blnConfirma Then
             objLogLibRec.pInsereLogLigTMP( objLiberacao, cdsCtaRec.FieldByName('CTR_NUMDUP').AsString, cdsCtaRec.FieldByName('CTR_ESPDOC').AsString, cdsCtaRec.FieldByName('CTR_CODEMP').AsString );

        end;

        If (Not blnConfirma) Then
          pCalculaJuros(fltJurAnt, fltPerMul, strAplJur);

      Except
        On E: Exception Do
        Begin
          blnConfirma := False;
          pMensagensErro(E.message, '');
        End;
      End;
    End;

    If blnConfirma Then
    Begin
      Try
        pCalculaTotalDuplicatas(nil, nil, edtValorTotal, edtQtdDuplicatas, False, cdsCtaRec);
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;
    End;
  Finally
    cdsCtaRec.RecNo := intRecNo;
    ConfiguraDatasetCtaRec(True);
  End;

  Screen.Cursor := crDefault;
end;

procedure TfrmBaixaReceber.pRetDupSelecionadas(Var intDupCx: Integer;
                                               Var fltTotCx: Double);
begin
  If cdsCtaRec.IsEmpty Then
    Exit;

  intDupCx := FCloneDatasetMarcados.RecordCount;
  fltTotCx := 0;

  Try
    Application.ProcessMessages;

    FCloneDatasetMarcados.First;
    While Not FCloneDatasetMarcados.Eof Do
    Begin
      intDupCx := FCloneDatasetMarcados.RecordCount;
      fltTotCx := fltTotCx + fFormataFloat(FCloneDatasetMarcados.FieldByName('CTR_VALREC').AsFloat, 2);

      FCloneDatasetMarcados.Next;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
end;

procedure TfrmBaixaReceber.pSelecionaDuplicata;
  Var
    BookMark: TBookMark;
    blnRecAut : Boolean;
    strCodDiv: String;
    blnConfirma : Boolean;
    LDadosParcial: TDadosBaixaParcial;
    fltDesCob: Double;
begin
  blnRecAut := False;

  If (InterlockedIncrement(intSemaforo) = 0) Then
  Begin
    If DuplicataComPixGeradoEAtivo Then
    Begin
      InterlockedDecrement(intSemaforo);

      Exit;
    End;

    Try
      BookMark := cdsCtaRec.GetBookmark;
      ConfiguraDatasetCtaRec(False);

      If (fField('CTR_MARDES').AsString <> 'M') Then
      Begin
        blnConfirma := False;
        If fField('CTR_TX_PIX').AsString.IsEmpty Then
          blnConfirma := dicBaixa['blnConfirma'];

        {***************************************************************************************************}
        {* NO CASO DO USUÁRIO SOMENTE CARREGAR O GRID E NESSE MOMENTO A DUPLICATA SOFREU ALGUMA ALTERAÇÃO, *}
        {* QUANDO FOR MARCAR O SISTEMA VERIFICA SE A MESMA FOI ALTERADA. ***********************************}
        {**REQ 144092************************************************************************************MO*}
        If Not (fRetUltimaAlteracaoCadRec(fField('NRODUP').AsString,
                                          fField('CTR_PARCEL').AsString,
                                          fField('CTR_ESPDOC').AsString,
                                          fField('CTR_CODCLI').AsString,
                                          fField('CTR_CODEMP').AsString) < fField('HRAFIL').AsDateTime) Then
        Begin
          fMensagem('ATENÇÃO', 'Não é possível selecionar a duplicata, pois a mesma sofreu uma alteração. Recarregue os títulos novamente.', ['&OK'], 0);
          pDestravarParcela(fField('NRODUP').AsString,
                            fField('CTR_ESPDOC').AsString,
                            fField('CTR_CODEMP').AsString,
                            fField('CTR_CODCLI').AsString,
                            fField('PARDUP').AsString);
          Exit;
        End;

        If (Not fCfgSis('BAIBOL', varBoolean)) And (Not fEmptyStr(fField('CTR_DTAENV').AsString))  Then
        Begin
          If fTravarBaixaDuplicataComBoletoEnviado(fField('NRODUP').AsString,
                                                   fField('CTR_ESPDOC').AsString,
                                                   fField('CTR_CODEMP').AsString,
                                                   fField('CTR_CODCLI').AsString,
                                                   fField('PARDUP').AsString,
                                                   strCodOpe,
                                                   blnRecAut) Then
            Exit;
        End;

        If Not fVerificaDocumentoAutorizadoSefaz Then
          Exit;

        If fExisteCancelamentoPendentePorChaveAcesso Then
          Exit;

        If Not fPodeSelecionarCreditoClienteDiferentes Then
          Exit;

        If (VS_strTipExp = '2')                                     And
           (fCfgSis('CXAEXP') = '2')                                And
           ((fField('CTR_DTLBEX').IsNull)                           And
            (Pos(fField('CTR_ESPDOC').AsString, ESPCTR_TRAVA) > 0)) And
           (fField('CTR_ENTFUT').AsString = 'N')                    And
           (fField('CTR_VALDUP').AsFloat >= 0)                      Then
        Begin
          If ((fField('GER_ENTFAT').AsString = 'N') And
              (fCfgSis('PEDRET', varBoolean)))      Or
             (fField('GER_ENTFAT').AsString <> 'N') Then
          Begin

            If fVerificaCtrManual(fField('NRODUP').AsString,
                                  fField('CTR_ESPDOC').AsString,
                                  fField('CTR_CODEMP').AsString,
                                  fField('CTR_CODCLI').AsString) Then
            Begin
              If (fCfgSis('RECPEN', varBoolean)) Then   // permite recebimento de documentos com expedição pendente?
              Begin
                If dicBaixa['strTipBai'] <> 'T' Then
                Begin
                  fMensagem('ATENÇÃO!', 'Documento com expedição pendente. Permitido apenas baixa total!', ['&Ok']);
                  Exit;
                End;
              End
              Else
              Begin
                fMensagem('ATENÇÃO!', 'Documento com expedição pendente. Permitido baixa somente através do resumo de caixa.', ['&Ok']);
                Exit;
              End;
            End;
          End;
        End;

        If fUtilizaTravaMaxUtilCredProfissional(fltCreSel + fField('CTR_VALDUP').AsFloat) And (Not fEmptyStr(fField('CTR_DOCDIV').AsString)) Then
        Begin

          pDestravaDupCreditoProf;

          If (Not fTravaDupCreditoProf) Then
          Begin
            Exit;
          End;

          stlDupPro.Add(fRetChaveLckProf);

          If Not fVerificaCredProfissionaisMes(fltCreSel + fField('CTR_VALDUP').AsFloat, fltCreUti) Then
          Begin

            strCodDiv := fRetClienteProfissional(fField('CTR_CODCLI').AsString);

            objLiberacao.Clear;
            objLiberacao.objMsgLibera.pAddTexto('O valor do crédito ultrapassa o máximo de utilização de crédito dentro do mês corrente.');
            objLiberacao.objMsgLibera.pAddTextoCaption('Profissional', strCodDiv + '-' + fRetNomeProfissional(strCodDiv), 12);
            objLiberacao.objMsgLibera.pAddTextoCaption('Empresa'     , VS_strCodEmp + '-' + untFuncoesSimples.fRetNomeEmpresa             , 12);

            blnLiberouUtiCredProf := False;

            objLiberacao.strDirAce := 'MAXUCM';
            objLiberacao.strSenLib := fCfgSis('SENUCM');
            objLiberacao.strMsgSen := 'Máximo de utilização de crédito para profissionais';
            objLiberacao.strCodOpe := strLoginUsuarioLogado;
            objLiberacao.strCodDig := strLoginUsuarioLogado;

            If Not objLiberacao.fLibera Then
            Begin
              pVerificaDestravarLckProf;
              Exit;
            End
            Else
              blnLiberouUtiCredProf := True;

          End;
        End;

        if not fValidaValorBaixa(fStrToFloat(dicBaixa['fltValPag'])) then
        begin
           pMensagemOk('Não é possível selecionar esta duplicata, o valor excede o permitido!' + #13 +
                       'Valor para baixa: ' + FormatFloat('###,###,##0.00', fltValorBaixa)+ #13 +
                       'Valor disponível: ' + FormatFloat('###,###,##0.00', fltValorBaixa-fStrToFloat(edtTotalRecebido.Text)));
           Exit;
        end;

        {****************************************************************}
        {* VERIFICA SE O PORTADOR TEM PERMISSÃO PARA BAIXAR A DUPLICATA *}
        {****************************************************************}
        If fField('POR_BAICTF').AsString = 'N' Then
        Begin
          fMensagem('', 'Portador não tem permissão para baixar no controle financeiro!', ['&Ok']);
          Exit;
        End;

        if fField('CTR_VALDUP').AsFloat < 0 then
        begin
          if not Self.DuplicataDeCreditoLiberada(
                    fField('NRODUP').AsString,
                    fField('PARDUP').AsString,
                    fField('CTR_ESPDOC').AsString,
                    fField('CTR_CODEMP').AsString,
                    fField('CTR_CODCLI').AsString) then
          begin
            Exit;
          end;
        end;

        Try

          fltJur := fField('CTR_TAXJUR').AsFloat;

          If blnConfirma Then
          Begin
            Application.ProcessMessages;
            strTipBai := dicBaixa['strTipBai'];
            fltValPag := fStrToFloat(dicBaixa['fltValPag']);
            fltValJur := fStrToFloat(dicBaixa['fltValJur']);
            fltValDes := fStrToFloat(dicBaixa['fltValDes']);
            strDtaRec := dicBaixa['strDtaRec'];
            strDtaAnt := dicBaixa['strDtaAnt'];
            fltDesCob := fStrToFloat(dicBaixa['fltDesCob']);
            fltValCal := fStrToFloat(dicBaixa['fltValCal']);

            LDadosParcial.ValorNovaDuplicata     := fStrToFloat(dicBaixa['ValorNovaDuplicata']);
            LDadosParcial.JurosNovaDuplicata     := fStrToFloat(dicBaixa['JurosNovaDuplicata']);
            LDadosParcial.DescontoNovaDuplicata  := fStrToFloat(dicBaixa['DescontoNovaDuplicata']);
            LDadosParcial.ValorBaixaDuplicata    := fStrToFloat(dicBaixa['ValorBaixaDuplicata']);
            LDadosParcial.FatorBaixaDuplicata    := fStrToFloat(dicBaixa['FatorBaixaDuplicata']);
            LDadosParcial.FatorJurosDuplicata    := fStrToFloat(dicBaixa['FatorJurosDuplicata']);
            LDadosParcial.DespesasNovaDuplicata  := fStrToFloat(dicBaixa['DespesasNovaDuplicata']);
            LDadosParcial.DescontoBaixaDuplicata := fStrToFloat(dicBaixa['DescontoBaixaDuplicata']);
            LDadosParcial.DespesasBaixaDuplicata := fStrToFloat(dicBaixa['DespesasBaixaDuplicata']);

            pMarcaDuplicata(True,
                            strTipBai,
                            fltValPag,
                            fltValDes,
                            fltValJur,
                            strDtaRec,
                            fStrToFloat(dicBaixa['CalculoBaixaParcial']),
                            LDadosParcial,
                            blnRecAut,
                            fltDesCob,
                            fltValCal);

            If Pos('SM_', strMarcacaoLog) <= 0 Then
              strMarcacaoLog := strMarcacaoLog + 'SM_';


          End
          Else
          Begin
            pVerificaDestravarLckProf;
          End;

        Except
          On E: Exception Do
            pMensagensErro(E.Message, '');
        End;

      End
      Else
      Begin

        pMarcaDuplicata(False, '', 0, 0, 0, '', 0.00,LDadosParcial);

        If Pos('DM_', strMarcacaoLog) <= 0 Then
          strMarcacaoLog := strMarcacaoLog + 'DM_';
      End;

    Finally
      cdsCtaRec.GotoBookmark(BookMark);
      cdsCtaRec.FreeBookmark(BookMark);

      edtMedPond.Text := fRetornaMediaPonderadaNova(cdsCtaRec.FieldByName('CTR_CODCLI').AsString, cdsCtaRec, False);

      pCalculaTotalDuplicatas(edtDescontoTotal, edtJurosTotal, edtTotalRecebido, edtQtdSelecionadas, True, FCloneDatasetMarcados);
      pSetFocus(Self);

      ConfiguraDatasetCtaRec(True);

      InterlockedDecrement(intSemaforo);
    End;
  End
  Else
  Begin

    InterlockedDecrement(intSemaforo);
  End;

  {******************************************}
  {* POSICIONA O CURSOR NO PRÓXIMO REGISTRO *}
  {***************************************MO*}
  dbgDuplicatasDBTableView1.NavigatorButtons.Next.Click;

end;

procedure TfrmBaixaReceber.pSelecionarDuplicata(blnSelTodas : Boolean = False);
  Var
    blnMarcar: Boolean;
    strCliSelAnt: String;
    blnRecAut : Boolean;
    blnBolAdt : Boolean;
begin
  strCliSelAnt := strCliSel;
  blnRecAut := False;

  blnMarcar := (fField('CTR_MARDES').AsString <> 'M');

  If (blnMarcar) Then
  Begin

    If (Not fCfgSis('BAIBOL', varBoolean)) And (Not fEmptyStr(fField('CTR_DTAENV').AsString))  Then
    Begin
      If fTravarBaixaDuplicataComBoletoEnviado(fField('NRODUP').AsString,
                                               fField('CTR_ESPDOC').AsString,
                                               fField('CTR_CODEMP').AsString,
                                               fField('CTR_CODCLI').AsString,
                                               fField('PARDUP').AsString,
                                               strCodOpe,
                                               blnRecAut) Then
        Exit;
    End;

    blnBolAdt := fApenasBoletoAdiantamento;
    If blnMarcar And (((Not blnBolAdt) And (fField('FGO_BOLADT').AsFloat > 0)) Or
                     ((blnBolAdt) And (fField('FGO_BOLADT').AsFloat = 0))) And (Not FCloneDatasetMarcados.IsEmpty) Then
    Begin
      fMensagem('ATENÇÃO!','Duplicata de espécie PD cujos boletos foram emitidos somente é permitido selecionar '+
                           'com duplicatas de espécie PD cujos boletos foram emitidos!', ['&Ok']);
      Exit;
    End;


    If Not fCfgSis('SELVCL',varBoolean) Then
    Begin

      If (Not fEmptyStr(strCliSel)) Then
      Begin

        If (strCliSel <> fField('CTR_CODCLI').AsString) Then
        Begin
          fMensagem('', 'Só é permitido selecionar duplicatas do mesmo cliente!', ['&Ok']);
          Exit;
        End;

      End
      Else
      Begin
        strCliSel := fField('CTR_CODCLI').AsString
      End;

    End;

    If (VS_strTipExp = '2')                                     And
       (fCfgSis('CXAEXP') = '2')                                And
       ((fField('CTR_DTLBEX').IsNull)                           And
        (Pos(fField('CTR_ESPDOC').AsString, ESPCTR_TRAVA) > 0)) And
       (fField('CTR_ENTFUT').AsString = 'N')                    And
       (fField('CTR_VALDUP').AsFloat >= 0)                      Then
    Begin
       If ((fField('GER_ENTFAT').AsString = 'N') And (fCfgSis('PEDRET', varBoolean))) Or
           (fField('GER_ENTFAT').AsString <> 'N') Then
      Begin

        If Not (fCfgSis('RECPEN', varBoolean)) And
           fVerificaCtrManual(fField('NRODUP').AsString,
                              fField('CTR_ESPDOC').AsString,
                              fField('CTR_CODEMP').AsString,
                              fField('CTR_CODCLI').AsString) Then
        Begin
          fMensagem('ATENÇÃO!', 'Documento com expedição pendente. Permitido baixa somente através do resumo de caixa.', ['&Ok']);
          Exit;
        End;
      End;
    End;

    If (fField('CTR_VALDUP').AsFloat < 0) Then
    Begin

      If Not fEmptyStr(fCfgSis('RCXCRE')) Then
      Begin
        If Not MarcandoTodasDuplicatasELiberado Then
        Begin
          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto('Acesso a utilização de créditos');

          objLiberacao.strDirAce := 'RCXCRE';
          objLiberacao.strSenLib := fCfgSis('RCXCRE');
          objLiberacao.strMsgSen := 'Utilização de Créditos';
          objLiberacao.strCodOpe := strLoginUsuarioLogado;

          If (Not objLiberacao.fLibera) Then
            Exit;

          FLiberadoUtilizacaoCredito := True;
        End;
      End;

    End;

    If Not fVerificaDocumentoAutorizadoSefaz Then
      Exit;

    If fExisteCancelamentoPendentePorChaveAcesso Then
      Exit;

    If Not fPodeSelecionarCreditoClienteDiferentes Then
      Exit;

    If (fUtilizaTravaMaxUtilCredProfissional(fltCreSel + fField('CTR_VALDUP').AsFloat)) And (Not fEmptyStr(fField('CTR_DOCDIV').AsString)) Then
    Begin
      pDestravaDupCreditoProf;

      If (Not fTravaDupCreditoProf) Then
      Begin
        Exit;
      End;

      stlDupPro.Add(fRetChaveLckProf);
    End;
    
  End
  Else
  Begin
    strCliSel := '';
  End;

  If fVerificaDupBaixada(fField('NRODUP').AsString,
                         fField('PARDUP').AsString,
                         fField('CTR_ESPDOC').AsString,
                         fField('CTR_CODEMP').AsString,
                         fField('CTR_CODCLI').AsString,
                         fField('CTR_SEQBAI').AsInteger) Then
  Begin
    If Not blnSelTod Then
    Begin
      fMensagem('', 'Essa duplicata já está baixada!', ['&Ok']);
      Exit;
    End
    Else
      pMarcarDuplicata(False,True,False,blnSelTodas);
  End
  Else
    pMarcarDuplicata(blnMarcar, True, blnRecAut,blnSelTodas);
end;

procedure TfrmBaixaReceber.pSetaFields(cdsClient: TUniClientDataSet);
begin
  (cdsClient.FieldByName('CTR_VALDUP') As TFloatField).DisplayFormat := ',0.00';
  (cdsClient.FieldByName('CTR_VALSUJ') As TFloatField).DisplayFormat := ',0.00';
  (cdsClient.FieldByName('CTR_VALCAL') As TFloatField).DisplayFormat := ',0.00';
end;

procedure TfrmBaixaReceber.pStepStatusSelecao(pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

procedure TfrmBaixaReceber.pTemBaixaTotalBaixaReceber;
begin
  FCloneDatasetMarcados.First;
  FBlnBaiTotal := False;

  While Not FCloneDatasetMarcados.Eof Do
  Begin
    If Not FBlnBaiTotal Then
    Begin
      FBlnBaiTotal := FCloneDatasetMarcados.FieldByName('CTR_TIPBAI').AsString = 'T';

      If FBlnBaiTotal Then
        Break;
    End;

    FCloneDatasetMarcados.Next;
  End;

  FCloneDatasetMarcados.First;
end;

procedure TfrmBaixaReceber.pUtilizaRotinaProjeto;
begin
  pnlProjeto.Visible := fCfgSis('UTLPRJ', varBoolean);
  pnlCabecalho2.Visible := pnlCabecalho.Visible;
  pnlProjeto.Visible := pnlCabecalho.Visible;
end;

procedure TfrmBaixaReceber.pVerificaDestravarLckProf;
Var
  intIndice: Integer;
Begin
  If (Not Assigned(stlDupPro)) Or
     (stlDupPro.Count <= 0)    Or
     (fEmptyStr(fField('CTR_DOCDIV').AsString)) Then
    Exit;

  intIndice := stlDupPro.IndexOf(fRetChaveLckProf);

  If (intIndice >= 0) Then
    stlDupPro.Delete(intIndice);

  If (stlDupPro.Count <= 0) Then
    pDestravaDupCreditoProf;
End;

function TfrmBaixaReceber.RestaurarRemessaBancaria(AAutoInc : String): Boolean;
  Var
    LTfrmFinDesmRemBanc : TfrmFinDesmRemBanc ;
begin
  If fVerificaAcessoSistema('frmFinDesmRemBanc') Then
  Begin
    Try
      pCriarFormularios(TfrmFinDesmRemBanc, LTfrmFinDesmRemBanc);
      LTfrmFinDesmRemBanc.AutoIncrem := AAutoInc;
      LTfrmFinDesmRemBanc.ShowModal;
      Result := LTfrmFinDesmRemBanc.Confirma;

    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
    FreeAndNil(LTfrmFinDesmRemBanc);
  End
  Else
  Begin
    pMensagemOk('Sem permissão de acesso para restaurar remessa!');
    Result := False;
  End;
end;

procedure TfrmBaixaReceber.IncluiRegistroMarcado;
  Var
    LField: TField;
Begin
  If FCloneDatasetMarcados.Locate('AUTOINCREM', cdsCtaRec.FieldByName('AUTOINCREM').AsString, []) Then
    Exit;

  FCloneDatasetMarcados.Append;

  For LField In cdsCtaRec.Fields Do
    FCloneDatasetMarcados.Fields[LField.Index].Value := cdsCtaRec.Fields[LField.Index].Value;

  FCloneDatasetMarcados.Post;
End;

procedure TfrmBaixaReceber.spbAmpliarClick(Sender: TObject);
begin

  inherited;

  If not cdsCtaRec.Active Then
    exit;

  If fEmptyStr(cdsCtaRec.FieldByName('AUTOINCREM').AsString) then
    exit;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(219, 7731, [],
                        ['AUTINC'],
                        [cdsCtaRec.FieldByName('AUTOINCREM').AsString],
                        Sender,
                        nil,
                        True);
  End;

end;

function TfrmBaixaReceber.TemClientesOuRedeLojasDiferentes: Boolean;
var
  LPossuiCredito,
  LPossuiClientesERedeDiferentes,
  LFiltroAnteriorAtivo: Boolean;

  LFiltroAnterior,
  LClienteAtual,
  LRedeLojaAtual,
  LPrimeiroCliente,
  LPrimeiraRedeLoja: String;
begin
  Result := False;

  If Not cdsCtaRec.Active Then
    Exit;

  LFiltroAnteriorAtivo := cdsCtaRec.Filtered;
  LFiltroAnterior := cdsCtaRec.Filter;
  cdsCtaRec.DisableControls;
  Try
    cdsCtaRec.Filter   := dbgDuplicatasDBTableView1.DataController.Filter.FilterText;
    cdsCtaRec.Filtered := Not cdsCtaRec.Filter.IsEmpty;

    If cdsCtaRec.IsEmpty Then
      Exit;

    cdsCtaRec.First;

    LPrimeiroCliente := cdsCtaRec.FieldByName('CTR_CODCLI').AsString;

    LPrimeiraRedeLoja := '';
    If Not cdsCtaRec.FieldByName('CLI_CODRED').IsNull Then
      LPrimeiraRedeLoja := cdsCtaRec.FieldByName('CLI_CODRED').AsString;

    LPossuiCredito := cdsCtaRec.FieldByName('CTR_VALDUP').AsFloat < 0;

    cdsCtaRec.Next;

    LPossuiClientesERedeDiferentes := False;

    While Not cdsCtaRec.Eof Do
    Begin
      LClienteAtual := cdsCtaRec.FieldByName('CTR_CODCLI').AsString;

      If cdsCtaRec.FieldByName('CTR_VALDUP').AsFloat < 0 Then
        LPossuiCredito := True;

      If (LClienteAtual <> LPrimeiroCliente) Then
      Begin
        LRedeLojaAtual := '';
        If Not cdsCtaRec.FieldByName('CLI_CODRED').IsNull Then
          LRedeLojaAtual := cdsCtaRec.FieldByName('CLI_CODRED').AsString;

        If fEmptyStr(LPrimeiraRedeLoja) Then
          LPossuiClientesERedeDiferentes := True;

        If fEmptyStr(LRedeLojaAtual) Then
          LPossuiClientesERedeDiferentes := True;

        if (LPrimeiraRedeLoja <> LRedeLojaAtual) Then
          LPossuiClientesERedeDiferentes := True;
      End;

      If LPossuiClientesERedeDiferentes And LPossuiCredito Then
        Exit(True);

      cdsCtaRec.Next;
    End;

    Result := LPossuiClientesERedeDiferentes And LPossuiCredito;
  Finally
    cdsCtaRec.Filter   := LFiltroAnterior;
    cdsCtaRec.Filtered := LFiltroAnteriorAtivo;
    cdsCtaRec.EnableControls;
    cdsCtaRec.First;
  End;
end;

function TfrmBaixaReceber.TravaDuplicatasParaBaixaDoPix(
  var ADataset: TUniClientDataset): Boolean;
begin
  Result := True;

  Try
    ADataset.First;

    While Not ADataset.Eof Do
    Begin
      If fDuplicataTravada(ADataset.FieldByName('NRODUP').AsString,
                           ADataset.FieldByName('CTR_ESPDOC').AsString,
                           ADataset.FieldByName('CTR_CODEMP').AsString,
                           ADataset.FieldByName('CTR_CODCLI').AsString,
                           ADataset.FieldByName('PARDUP').AsString,
                           True) Then
        Exit(False);

      ADataset.Edit;
      ADataset.FieldByName('CTR_MARDES').AsString := 'M';
      ADataset.Post;

      ADataset.Next;
    End;

    If Not objLock.fLock_Unlock('CONSULTA_RECEBIMENTO_PIX_' + ADataset.FieldByName('CTR_TX_PIX').AsString, True) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Pix selecionado está sendo utilizado por outra estação: ' +
                             fGetHostLock('CONSULTA_RECEBIMENTO_PIX_' + ADataset.FieldByName('CTR_TX_PIX').AsString), ['&OK']);
      Exit(False);
    End;
  Finally
    ADataset.First;
  End;
end;

function TfrmBaixaReceber.fPodeSelecionarCreditoClienteDiferentes: Boolean;
  Var
    blnTemCreditosSel: Boolean;
begin
  Result := True;

  If Not fCfgSis('SBCCMC', VarBoolean) Then
    Exit;

  If (fField('CTR_VALDUP').AsFloat < 0) Then
  Begin
    If Not fEhMesmoClienteOuMesmaRedeDeLojas(blnTemCreditosSel) Then
    Begin
      Result := False;
      pMensagemOk('Duplicata de crédito somente é permitido selecionar '+
        'com duplicatas do mesmo cliente ou mesma rede de lojas!');
    End;
  End
  Else
  Begin
    If Not fEhMesmoClienteOuMesmaRedeDeLojas(blnTemCreditosSel) And blnTemCreditosSel Then
    Begin
      Result := False;
      pMensagemOk('Já foram selecionadas duplicatas de crédito e somente é permitido selecionar '+
        'com duplicatas do mesmo cliente ou mesma rede de lojas!');
    End;
  End;
end;

procedure TfrmBaixaReceber.fraCentroCustoedtCodEveExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(fraCentroCusto.edtCodEve, fraCentroCusto.edtDesEve, arrEvento, fRetNomEvento, Nil, 'do Centro de Custos');
end;

function TfrmBaixaReceber.fRetChaveLckProf: String;
begin

  Result := 'CADREC' +
            fField('CTR_NUMDUP').AsString +
            fField('CTR_ESPDOC').AsString +
            fField('CTR_CODEMP').AsString +
            fField('CTR_CODCLI').AsString +
            fField('CTR_PARCEL').AsString;

end;

function TfrmBaixaReceber.fRetornaMediaPonderadaNova(strCodCli:String;objDados:TUniClientDataSet; blnCalcDiaUtil:Boolean=False): String;
  function fBuscaProxDiaUtil(data:TDateTime):TDateTime;
    function fExisteFeriado(data:TDateTime):Boolean;
    var
      qryFeriado :TUniQuery;
    begin
      qryFeriado := fCriaQuery(Nil);
      qryFeriado.SQL.Text :=
          ' SELECT COUNT(FER_DTAFER) FROM CADFER WHERE FER_DTAFER = ' +
               QuotedStr(FormatDateTime('YYYY-MM-DD',data));
      qryFeriado.Open;
      Result := qryFeriado.fields[0].AsInteger > 0;
      FreeAndNil(qryFeriado);
    end;
  Var
    dataNova : TDateTime;
  begin

    dataNova := data;

    if DayOfWeek(dataNova) = 1 then
      dataNova := datanova + 1;

    if DayOfWeek(dataNova) = 7 then
      dataNova := datanova + 2;

    while (fExisteFeriado(dataNova)) or (dayOfWeek(dataNova) in [1,7]) do
      dataNova := datanova + 1;

    result := dataNova;
  end;


  Var
    arrPonderada : Array of TPonderada;
    intTamanho   : Integer;
    intPosicao   : Integer;
    fltTotVlr    : Double;
    fltTotPon    : Double;

    dtaDtaVen: TDateTime;
    intAtraso: Double;


    LContador: Integer;
begin
  Result    := '0,00';
  intTamanho:= 1;

  with FCloneDatasetMarcados do
  begin
    First;

    LContador := 0;
    While Not Eof Do
    Begin

      // dtaDtaVen := fBuscaProxDiaUtil(FieldByName('CTR_DTACAD').AsDateTime);
      // FOI SOLICITADO QUE COLOCASSE DATA DE CADASTRO PARA BATER COM A TELA DE INFORMAÇÃO
      // DE BAIXA DE CONTAS A RECEBER.
      // DESCONSIDERAR TAMBEM DIAS UTEIS. A DATA SERA FIXA PELO CAMPO DATA DE CADASTRO.
      // ACERTADO COM DOUGLAS.


      //REQ 67015
      // QUANDO BOTÃO ESPECÍFICO CLICADO, RECALCULAR MEDIA PONDERADA AJUSTANDO VARIAVEL PARA CALCULAR COM
      // DIAS UTEIS.
      // FA
      if blnCalcDiautil then
        dtaDtaVen := fBuscaProxDiaUtil(FieldByName('CTR_DTACAD').AsDateTime)
      else
        dtaDtaVen := FieldByName('CTR_DTACAD').AsDateTime;

      intAtraso := Date - dtaDtaVen;

      SetLength(arrPonderada, intTamanho);

      arrPonderada[intTamanho - 1].intDiasAtr := intAtraso;
      arrPonderada[intTamanho - 1].fltTotVlr  := FieldByName('CTR_VALCAL').AsFloat;
      arrPonderada[intTamanho - 1].fltTotPon  := FieldByName('CTR_VALCAL').AsFloat * intAtraso;

      Inc(intTamanho);

      Next;

      If LContador = 0 Then
        Application.ProcessMessages;

      Inc(LContador);
      If LContador >= 50 Then
        LContador := 0;
    End;
  end;
  fltTotVlr := 0;
  fltTotPon := 0;

  For intPosicao := 0 To High(arrPonderada) Do
  Begin
    fltTotVlr := fltTotVlr + arrPonderada[intPosicao].fltTotVlr;
    fltTotPon := fltTotPon + arrPonderada[intPosicao].fltTotPon;
  End;

  Application.ProcessMessages;

  If fltTotVlr <> 0 Then
  Begin
              // REQ
              // FOI COLOCADO EM FORMA DE STRING POIS O ARREDONDAMENTO CONFLITAVA ENTRE OS EDITFOCUS E O RELATORIO
              // FA 25/11/2016
    Result := FloatToStr(trunc(fltTotPon / fltTotVlr)) + ',' + Copy(FormatFloat('0.00',frac(fltTotPon / fltTotVlr)),3,2);
    // FloatToStrF(fltTotPon / fltTotVlr, ffNumber, 15, 2);
  End;
end;

function TfrmBaixaReceber.fValidaLiberacaoCreditoProfissional: Boolean;
Var
  fltCrePro: Double;
  fltCreMax: Double;
Begin

  Result := True;

  Try

    If (fCfgSis('TCOPRO') <> '2') Or (Not fCfgSis('TRACPR', varBoolean)) Then
      Exit;

    FCloneDatasetMarcados.Filter := ' CTR_DOCDIV <> ' + QuotedStr('') + '';
    FCloneDatasetMarcados.Filtered := True;

    With FCloneDatasetMarcados Do
    Begin
      First;
      fltCrePro := 0;

      While Not Eof Do
      Begin
        fltCrePro := fltCrePro + FieldByName('CTR_VALDUP').AsFloat;
        Next;
      End;
    End;

    If (fltCrePro < 0) Then
      Result := fVerificaCredProfissionaisMes(fltCrePro, fltCreUti);

    If (Not Result) Then
    Begin
      Result := True;

      fltCreMax := fCfgSis('MAXUCM', varDouble);

      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Os valores dos créditos selecionados ultrapassam o valor máximo de utilização de crédito dentro do mês corrente.');
      objLiberacao.objMsgLibera.pAddTextoCaption('Empresa', VS_strCodEmp + '-' + untFuncoesSimples.fRetNomeEmpresa);
      objLiberacao.objMsgLibera.pAddTextoCaption('Valor máximo permitido'           , FormatFloat('#,##0.00', fltCreMax )                                       , 32, alDireita, teAmbos, '', 10);
      objLiberacao.objMsgLibera.pAddTextoCaption('Créditos já utilizados'           , FormatFloat('#,##0.00', Abs(fltCreUti))                                   , 32, alDireita, teAmbos, '', 10);
      objLiberacao.objMsgLibera.pAddTextoCaption('Créditos para liberação'          , FormatFloat('#,##0.00', Abs(fltCrePro))                                   , 32, alDireita, teAmbos, '', 10);
      objLiberacao.objMsgLibera.pAddTextoCaption('Créditos utilizados + liberação'  , FormatFloat('#,##0.00', Abs(fltCreUti) + Abs(fltCrePro))                  , 32, alDireita, teAmbos, '', 10);
      objLiberacao.objMsgLibera.pAddTextoCaption('Diferença'                        , FormatFloat('#,##0.00', Abs(fltCreUti) + Abs(fltCrePro) - Abs(fltCreMax)) , 32, alDireita, teAmbos, '', 10);

      blnLiberouUtiCredProf := False;

      objLiberacao.strDirAce := 'MAXUCM';
      objLiberacao.strSenLib := fCfgSis('SENUCM');
      objLiberacao.strMsgSen := 'Máximo de utilização de crédito para profissionais';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := strLoginUsuarioLogado;

      If Not objLiberacao.fLibera Then
      Begin
        Result := False;
      End
      Else
        blnLiberouUtiCredProf := True;

    End;

  Except
    On E: Exception Do
      pMensagensErro('Houve um erro ao validar a liberação de crédito de profissional', e.message);
  End;

  FCloneDatasetMarcados.Filtered := False;

End;

function TfrmBaixaReceber.fValidaValorBaixa(const fltValor: Double): Boolean;
var
  fltValSel: Double;
begin
  Result := True;
  if (fltValorBaixa > 0) and (strCodPorFix <> '') then
  begin
    pCalculaTotalDuplicatas(edtDescontoTotal, edtJurosTotal, edtTotalRecebido, edtQtdSelecionadas, True, FCloneDatasetMarcados);

    fltValSel := 0;
    if edtTotalRecebido.Text <> '' then
       fltValSel := fStrToFloat(edtTotalRecebido.Text);

    fltValSel := fltValSel + fltValor;
    if  RoundTo(fltValSel, -2) > RoundTo(fltValorBaixa, -2) then
      Result := False;
  end;
end;

function TfrmBaixaReceber.fEhMesmoClienteOuMesmaRedeDeLojas(Var blnTemCreditos: Boolean): Boolean;
  Var
    strCliSel: String;
    strRedSel: String;
begin
  strCliSel := '';
  strRedSel := '';

  blnTemCreditos := False;

  FCloneDatasetMarcados.First;

  While Not FCloneDatasetMarcados.Eof Do
  Begin
    If Pos(FCloneDatasetMarcados.FieldByName('CTR_CODCLI').AsString, strCliSel) <= 0 Then
      strCliSel := strCliSel + FCloneDatasetMarcados.FieldByName('CTR_CODCLI').AsString;

    If Pos(FCloneDatasetMarcados.FieldByName('CLI_CODRED').AsString, strRedSel) <= 0 Then
      strRedSel := strRedSel + FCloneDatasetMarcados.FieldByName('CLI_CODRED').AsString;

    If (FCloneDatasetMarcados.FieldByName('CTR_VALDUP').AsFloat < 0) Then
      blnTemCreditos := True;

    FCloneDatasetMarcados.Next;
  End;

  Result := False;
  //Se nao tem documentos selecionados
  If fEmptyStr(strCliSel) Then Result := True
  //Se for a mesma rede de lojas para todos os clientes selecionados
  Else If (Length(strRedSel) = 5) And (strRedSel <> '00000') Then Result := fField('CLI_CODRED').AsString = strRedSel
  //Se for o mesmo cliente selecionado
  Else If (Length(strCliSel) = 8) Then Result := fField('CTR_CODCLI').AsString = strCliSel;
end;

function TfrmBaixaReceber.fExisteDataRecebimentoInvalida: Boolean;
Var
  intRecNo: Integer;
Begin
  Result := False;

  With cdsCtaRec Do
  Begin
    intRecNo := RecNo;
    First;

    While Not Eof Do
    Begin
      if ((FieldByName('CTR_MARDES').AsString = 'M') And
          (FieldByName('CTR_DTAREC').AsString = '30/12/1899')) Then

      Begin
        pMensagemOk('A data de recebimento para a duplicata abaixo está nula: '+#13+#13+
                     FieldByName('CTR_NUMDUP').AsString+'-'+FieldByName('CTR_ESPDOC').AsString+ '-'+ FieldByName('CTR_CODCLI').AsString + #13 + #13 +
                     'Se o problema persistir entre em contato com a Citel!');

        Result := True;
        Break;
      End;

      Next;
    End;

    RecNo := intRecNo;
  End;
end;

procedure TfrmBaixaReceber.pDesmarcaDuplicatasCreditoProfissional;
Var
  intRecNo: Integer;
  LDadosParcial: TDadosBaixaParcial;
Begin

  Try

    intRecNo := cdsCtaRec.RecNo;
    cdsCtaRec.First;

      While Not cdsCtaRec.Eof Do
      Begin
        If (Not fEmptyStr(cdsCtaRec.FieldByName('CTR_DOCDIV').AsString)) Then
          pMarcaDuplicata(False, '', 0, 0, 0, '', 0.00,LDadosParcial);

        cdsCtaRec.Next;
      End;

      cdsCtaRec.RecNo := intRecNo;

  Except
    On E: Exception Do
      pMensagensErro('Houve um erro ao desmarcar as duplicatas de créditos para profissional', e.message);
  End;
End;

procedure TfrmBaixaReceber.pDesmarcaDuplicatasDeCredito(
  ADuplicatas: TArrayDuplicatasCredito);
Var
  intRecNo: Integer;
  index: Integer;
  LDadosParcial: TDadosBaixaParcial;
Begin
  Try
    for index := 0 to Length(ADuplicatas)-1 do
    begin
      With cdsCtaRec Do
      Begin
        intRecNo := RecNo;
        First;

        While Not Eof Do
        Begin
          If ((FieldByName('NRODUP').AsString = ADuplicatas[index].NumDup) and
              (FieldByName('PARDUP').AsString = ADuplicatas[index].Parcel) and
              (FieldByName('CTR_ESPDOC').AsString = ADuplicatas[index].EspDoc) and
              (FieldByName('CTR_CODEMP').AsString = ADuplicatas[index].CodEmp) and
              (FieldByName('CTR_CODCLI').AsString = ADuplicatas[index].CodCli)) Then
          begin
            pMarcaDuplicata(False, '', 0, 0, 0, '', 0.00,LDadosParcial);
          end;

          Next;
        End;

        RecNo := intRecNo;
      End;

    end;

  Except
    On E: Exception Do
      pMensagensErro('Houve um erro ao desmarcar as duplicatas de créditos', e.message);
  End;

end;

{*****************************************}
{*    DESMARCAR TODAS AS DUPLICATAS       *}
{**************************************LE*}

function TfrmBaixaReceber.fDesmarcarDuplics(pgbProgresso: TcxProgressBar): Boolean;
  Var
    LRecNo: Integer;

    LFiltroAnterior: String;
begin
  Application.ProcessMessages;

  LFiltroAnterior := cdsCtaRec.Filter;
  LRecNo := cdsCtaRec.RecNo;
  Try
    ConfiguraDatasetCtaRec(False);
    Try
      cdsCtaRec.Filter   := 'CTR_MARDES = ' + QuotedStr('M');

      If Not dbgDuplicatasDBTableView1.DataController.Filter.FilterText.IsEmpty Then
        cdsCtaRec.Filter := cdsCtaRec.Filter + ' AND (' +
                            dbgDuplicatasDBTableView1.DataController.Filter.FilterText + ')';

      cdsCtaRec.Filtered := True;
      cdsCtaRec.First;

      Try

       pgbProgresso.Position := 0;
       pgbProgresso.Properties.Max := cdsCtaRec.RecordCount;

        While Not cdsCtaRec.IsEmpty Do
        Begin
          pStepStatusSelecao(pgbProgresso);

          FListaMarcarTodas.Add('CADREC' +
                                cdsCtaRec.FieldByName('NRODUP').AsString +
                                cdsCtaRec.FieldByName('CTR_ESPDOC').AsString +
                                cdsCtaRec.FieldByName('CTR_CODEMP').AsString +
                                cdsCtaRec.FieldByName('CTR_CODCLI').AsString +
                                cdsCtaRec.FieldByName('PARDUP').AsString);

          FListaMarcarTodas.Add('CADREC' +
                                cdsCtaRec.FieldByName('NRODUP').AsString +
                                cdsCtaRec.FieldByName('CTR_ESPDOC').AsString +
                                cdsCtaRec.FieldByName('CTR_CODEMP').AsString +
                                cdsCtaRec.FieldByName('CTR_CODCLI').AsString);

          ObjLogLibRec.pRemoveTmpLogLib(cdsCtaRec.FieldByName('NRODUP').AsString,
                                        cdsCtaRec.FieldByName('CTR_ESPDOC').AsString,
                                        cdsCtaRec.FieldByName('CTR_CODEMP').AsString);


          cdsCtaRec.Edit;
          cdsCtaRec.FieldByName('CTR_MARDES').AsString := 'D';
          cdsCtaRec.FieldByName('CTR_TIPBAI').AsString := '';
          cdsCtaRec.FieldByName('CTR_DTAREC').Value := Null;
          cdsCtaRec.FieldByName('CTR_VALREC').AsFloat := 0;
          cdsCtaRec.FieldByName('CTR_VALDES').AsFloat := 0;

          If FCloneDatasetMarcados.Locate('AUTOINCREM', fField('AUTOINCREM').AsString, []) Then
            FCloneDatasetMarcados.Delete;

          cdsCtaRec.Post;

          cdsCtaRec.Next;
        End;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;

      cdsCtaRec.Filter := LFiltroAnterior;
      cdsCtaRec.Filtered := Not cdsCtaRec.Filter.IsEmpty;
      
      pCalculaTotalDuplicatas(edtDescontoTotal, edtJurosTotal, edtTotalRecebido, edtQtdSelecionadas, True, FCloneDatasetMarcados);
      pSetFocus(Self);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  Finally
    cdsCtaRec.RecNo := LRecNo;
    ConfiguraDatasetCtaRec(True);
  End;

  Result := True;
end;


{*****************************************}
{*      PROCEDURE INICIA A BUSCA         *}
{**************************************LE*}
procedure TfrmBaixaReceber.pBuscarIni;
begin

  If (Not fEmptyStr(frmBaixaBusca.strValorFiltro)) Then
    Begin
      strValFil := frmBaixaBusca.strValorFiltro;
      strCamFil := frmBaixaBusca.strCampoFiltro;
      If Not cdsCtaRec.FindFirst Then
      Begin
        fMensagem('ATENÇÃO!', 'Não há duplicatas para serem baixadas!', ['&O k']);
      End;
    End;

end;


{*****************************************}
{*      PROCEDURE BUSCAR PROXIMA         *}
{**************************************LE*}
procedure TfrmBaixaReceber.pBuscarProx;
begin

  If (Not cdsCtaRec.IsEmpty) And (Not fEmptyStr(strCamFil)) Then
  Begin
    If Not cdsCtaRec.FindNext Then
      fMensagem('ATENÇÃO!', 'Não há duplicatas para serem baixadas!', ['&O k']);
  End
  Else
    fMensagem('ATENÇÃO!', 'A Busca não foi iniciada!', ['&Ok']);


end;


{*****************************************}
{*   CHAMA O FORM  FRMBAIXADIGVALORES    *}
{**************************************LE*}
procedure TfrmBaixaReceber.pFrmDigValores;
  Var
    frmBaixaDigValores : TfrmBaixaDigValores;
begin

  If fField('CTR_MARDES').AsString  = 'D' Then
  Begin
    pCriarFormularios(TfrmBaixaDigValores, frmBaixaDigValores);

    frmBaixaDigValores.blnVemCtr := True;
    frmBaixaDigValores.cdsDupSel := fCriaClientDatset(cdsCtaRec, False, frmBaixaDigValores, True);
    frmBaixaDigValores.dtaDtaCad := fField('CTR_DTACAD').AsDateTime;
    frmBaixaDigValores.dtaDtaVen := fField('CTR_DTAVEN').AsDateTime;
    frmBaixaDigValores.fltValDup := fField('CTR_VALSUJ').AsFloat;

    frmBaixaDigValores.fltValOri := fField('CTR_VALDUP').AsFloat;

    frmBaixaDigValores.fltJurSuj := fField('CTR_JURSUJ').AsFloat;
    frmBaixaDigValores.fltDesSuj := fField('CTR_DESSUJ').AsFloat;
    frmBaixaDigValores.fltValCal := fField('CTR_VALCAL').AsFloat;
    frmBaixaDigValores.fltPerMul := fField('CTR_PERMUL').AsFloat;
    frmBaixaDigValores.fltDesCob := fField('CTR_DESCOB').AsFloat;
    frmBaixaDigValores.fltJurDup := fField('CTR_VALCAL').AsFloat - fField('CTR_VALSUJ').AsFloat;

    frmBaixaDigValores.sNumDup := fField('CTR_NUMDUP').AsString;
    frmBaixaDigValores.sEspDup := fField('CTR_ESPDOC').AsString;
    frmBaixaDigValores.sCodEmp := fField('CTR_CODEMP').AsString;

    frmBaixaDigValores.strAutoIncrem := fField('AUTOINCREM').AsString;
    frmBaixaDigValores.sNomCli := fField('CTR_NOMCLI').AsString;
    frmBaixaDigValores.fltValAnt := fField('CTR_VALORI').AsFloat;
    frmBaixaDigValores.FLogLibRec := objLogLibRec;
    frmBaixaDigValores.CreditoGeradoPorDevolucao :=
      (fField('CTR_VALDUP').AsFloat < 0) And
      Not fEmptyStr(fField('GER_NUMDOC').AsString);

    frmBaixaDigValores.fltPercJuroAplic := fltPercJurosAplicado;

    If blnDescFinanSomenteAteVenc Then
    Begin
      frmBaixaDigValores.blnDescFinanSomenteAteVenc := True;
      frmBaixaDigValores.fltValDupComDescFinan := fField('CTR_VALSUJ_COM_DESC').AsFloat;
    End;

    If fEmptyStr(strDtaAnt) Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(strDtaRec)) Or (StrToDate(strDtaRec) <> VS_Date)) Then
        frmBaixaDigValores.dtaDtaPag := VS_Date
      Else
        frmBaixaDigValores.dtaDtaPag := StrToDate(strDtaRec);
    End
    Else
      frmBaixaDigValores.dtaDtaPag := StrToDate(strDtaAnt);

    fltJur := fField('CTR_TAXJUR').AsFloat;

    If fCfgSis('DESPON', varBoolean) Then
    Begin
      frmBaixaDigValores.fltPerDpo := fField('CTR_PERDPO').AsFloat;
      frmBaixaDigValores.intQtdDav := fField('CTR_QTDDAV').AsInteger;
    End;

    if (strCodPorFix <> '') and (fltValorBaixa <> 0) then
    begin
      frmBaixaDigValores.dtaDtaPag := dteDtaRecFix;
      frmBaixaDigValores.mskDtaPag.Enabled := False;
      frmBaixaDigValores.mskDtaPag.Date    := dteDtaRecFix;
    end;
    frmBaixaDigValores.blnBolAdt := (fField('FGO_BOLADT').AsFloat > 0.00);
    frmBaixaDigValores.ValorCorrigidoSemPontualidade := fField('CTR_CALORI').AsFloat;

    frmBaixaDigValores.ShowModal;

    //Setando valores utilizados na fBaixaDuplicatas
    dicBaixa.AddOrSetValue('blnConfirma', frmBaixaDigValores.blnConfirma);
    dicBaixa.AddOrSetValue('strTipBai',  frmBaixaDigValores.strTipBai);
    dicBaixa.AddOrSetValue('fltValPag',  frmBaixaDigValores.fltValPag);
    dicBaixa.AddOrSetValue('fltValJur',  frmBaixaDigValores.fltValJur);
    dicBaixa.AddOrSetValue('fltValDes',  frmBaixaDigValores.fltValDes);
    If frmBaixaDigValores.blnConfirma Then
    Begin
       dicBaixa.AddOrSetValue('fltDesCob',  frmBaixaDigValores.fltDesCob);
       dicBaixa.AddOrSetValue('fltValCal',  frmBaixaDigValores.fltValCal);
    End;
    dicBaixa.AddOrSetValue('strDtaRec',  frmBaixaDigValores.strDtaRec);
    dicBaixa.AddOrSetValue('strDtaAnt',  frmBaixaDigValores.strDtaRec);
    dicBaixa.AddOrSetValue('CalculoBaixaParcial',  frmBaixaDigValores.CalculoBaixaParcial);
    dicBaixa.AddOrSetValue('strAutoIncrem',  frmBaixaDigValores.strAutoIncrem);
    dicBaixa.AddOrSetValue('LibRet', frmBaixaDigValores.LibRet);

    dicBaixa.AddOrSetValue('ValorNovaDuplicata',     frmBaixaDigValores.ValorNovaDuplicata);
    dicBaixa.AddOrSetValue('JurosNovaDuplicata',     frmBaixaDigValores.JurosNovaDuplicata);
    dicBaixa.AddOrSetValue('DescontoNovaDuplicata',  frmBaixaDigValores.DescontoNovaDuplicata);
    dicBaixa.AddOrSetValue('ValorBaixaDuplicata',    frmBaixaDigValores.ValorBaixaDuplicata);
    dicBaixa.AddOrSetValue('FatorBaixaDuplicata',    frmBaixaDigValores.FatorBaixaDuplicata);
    dicBaixa.AddOrSetValue('FatorJurosDuplicata',    frmBaixaDigValores.FatorJurosDuplicata);
    dicBaixa.AddOrSetValue('DespesasNovaDuplicata',  frmBaixaDigValores.DespesasNovaDuplicata);
    dicBaixa.AddOrSetValue('DespesasBaixaDuplicata', frmBaixaDigValores.DespesasBaixaDuplicata);
    dicBaixa.AddOrSetValue('DescontoBaixaDuplicata', frmBaixaDigValores.DescontoBaixaDuplicata);

    pFreeAndNil(frmBaixaDigValores);

  End Else
  Begin
    ObjLogLibRec.pRemoveTmpLogLib(fField('NRODUP').AsString,
                 fField('CTR_ESPDOC').AsString,
                 fField('CTR_CODEMP').AsString);
  End;
end;

{*****************************************}
{*  FUNÇÃO MARCAR COM O VALOR INFORMADO  *}
{*  OPCAO 2 DO GETMENU                   *}
{**************************************LE*}
function TfrmBaixaReceber.fMarcarDuplicsValorInformado(pgbProgresso: TcxProgressBar): Boolean;
  Var
    fltDesSuj,
    fltValCal,
    fltValJur,
    fltValDespon,
    fltValInf2,
    fltValInf,
    fltJuros  :Double;
    FDuplicatas: TArrayDuplicatasCredito;
    FDuplicata: TDuplicatasCredito;

    LFiltroAnterior: String;

    LDuplicatasComPixGerados: Boolean;

    LValorJuros,
    LValorDesconto,
    LValorDespesas,
    LFatorDescontoDuplicata,
    LFatorDespesasDuplicata: Double;
begin
  //Primeiro desmarca todas as duplicatas (para desmarcar os creditos selecionados)
  If FValidarCreditosDeMesmoClienteOuRedeLojas Then
    fDesmarcarDuplics(pgbProgresso);

  LDuplicatasComPixGerados := False;

  fltValInf  := 0.00;
  SetLength(FDuplicatas, 0);

  Result := True;
  Try
    If dicBaixa['blnConfirma'] Then
      fltValInf := fStrToFloat(dicBaixa['fltValInf']);

    If (fltValInf <= 0) Then
      Exit;

    fltValInf2 := fltValInf;


    With cdsCtaRec Do
    Begin
      blnSelTod := True;

      LFiltroAnterior := Filter;
      Filter   := dbgDuplicatasDBTableView1.DataController.Filter.FilterText;
      Filtered := Not Filter.IsEmpty;

      While (Not Eof) Do
      Begin
        If (fltValInf2 < FieldByName('CTR_VALCAL').AsFloat) And
           (FieldByName('CTR_VALCAL').AsFloat > 0)         Then
          fltValInf2:= 0
        Else
          fltValInf2 := fFormataFloat(fltValInf2 - FieldByName('CTR_VALCAL').AsFloat, 2);

        Next;

        If (fltValInf = 0) Then
          Break;

      End;

      First;
      pgbProgresso.Position := 0;
      pgbProgresso.Properties.Max := RecordCount;

      While Not Eof Do
      Begin
        If (FNaoMarcarCreditos) And (FieldByName('CTR_VALDUP').AsFloat < 0) Then
        Begin
          Next;
          Continue;
        End;

        pStepStatusSelecao(pgbProgresso);
        If (fltValInf > 0) Then
        Begin
          If (FieldByName('CTR_MARDES').AsString <> 'M') Then
          Begin
            if not fValidaValorBaixa(FieldByName('CTR_VALCAL').AsFloat) then
            begin
              Next;
              Continue;
            end;
          End;

          If Not FieldByName('CTR_TX_PIX').AsString.IsEmpty Then
          Begin
            LDuplicatasComPixGerados := True;

            Next;
            Continue;
          End;

          if pos(FieldByName('CTR_ESPDOC').AsString, 'NF_DV') > 0 then
          begin
            if  FieldByName('CTR_VAlDUP').AsFloat < 0 then
            begin
               FDuplicata.NumDup := FieldByName('NRODUP').AsString;
               FDuplicata.Parcel := FieldByName('PARDUP').AsString;
               FDuplicata.EspDoc := FieldByName('CTR_ESPDOC').AsString;
               FDuplicata.CodEmp := FieldByName('CTR_CODEMP').AsString;
               FDuplicata.CodCli := FieldByName('CTR_CODCLI').AsString;

               SetLength(FDuplicatas, Length(FDuplicatas)+1);

               FDuplicatas[High(FDuplicatas)] := FDuplicata;
            end;
          end;

          pMarcarDuplicata(False);
          pSelecionarDuplicata(True);

          If (FieldByName('CTR_MARDES').AsString = 'M') Then
          Begin
            fltJuros := cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat - cdsCtaRec.FieldByName('CTR_VALSUJ').AsFloat;
            If (fltJuros > 0) And (fltValInf < cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat) Then
            Begin
              if fCfgSis('JURPAR') = 'N' Then
              begin
                if not fLiberaBaixaParcialComJuros(fltValInf) then
                begin
                  pMarcarDuplicata(False);
                  fltValInf := 0;

                  Continue;
                end;
              end;
            end;

            If (fltValInf < FieldByName('CTR_VALCAL').AsFloat) And (FieldByName('CTR_VALCAL').AsFloat > 0) Then
            Begin

              If (FieldByName('FGO_BOLADT').AsFloat > 0.00) Then
              Begin
                fMensagem('ATENÇÃO!','Não é possível realizar baixa parcial de duplicatas de espécie PD cujos boletos foram emitidos!', ['&Ok']);
                pMarcarDuplicata(False);
                Next;
                Continue;
              End;

              If fHabilitaBaixaParcial(strCodOpe) And fValidaBaixaParcial(IIF(fEmptyStr(strCodOpe),strLoginUsuarioLogado,strCodOpe), strLoginUsuarioLogado, objLoglibrec ) Then
              Begin

                If (fCfgSis('RECPEN', varBoolean)) Then
                Begin

                  If (VS_strTipExp = '2')                                     And
                     (fCfgSis('CXAEXP') = '2')                                And
                     ((fField('CTR_DTLBEX').IsNull)                           And
                      (Pos(fField('CTR_ESPDOC').AsString, ESPCTR_TRAVA) > 0)) And
                     (fField('CTR_ENTFUT').AsString = 'N')                    And
                     (fField('CTR_VALDUP').AsFloat >= 0)                      Then
                  Begin

                    If fVerificaCtrManual(fField('NRODUP').AsString,
                                          fField('CTR_ESPDOC').AsString,
                                          fField('CTR_CODEMP').AsString,
                                          fField('CTR_CODCLI').AsString) Then
                    Begin
                      fMensagem('ATENÇÃO!', 'Documento com expedição pendente. Permitido apenas baixa total!', ['&Ok']);
                      pMarcarDuplicata(False);
                      Next;
                      Continue;
                    End;
                  End;

                End;

                Edit;
                FieldByName('CTR_VALREC').AsFloat := fltValInf;
                FieldByName('CTR_VALRES').AsFloat := FieldByName('CTR_VALCAL').AsFloat - fltValInf;
                FieldByName('CTR_BAIPAR').AsString:= 'S';
                FieldByName('CTR_TIPBAI').AsString:= 'P';
                FieldByName('CTR_DTAREC').AsDateTime := TDateTime(dicBaixa['dtaDtaPag']);

                LValorDesconto := FieldByName('CTR_DESSUJ').AsFloat;
                LValorDespesas := FieldByName('CTR_DESCOB').AsFloat;
                LValorJuros := (FieldByName('CTR_VALCAL').AsFloat - FieldByName('CTR_VALDUP').AsFloat) + LValorDesconto - LValorDespesas;

                If LValorJuros < 0 Then
                  LValorJuros := 0;

                FieldByName('FATORBAIXADUPLICATA').AsFloat := FieldByName('CTR_VALDUP').AsFloat /
                                                              FieldByName('CTR_VALCAL').AsFloat;

                FieldByName('FATORJUROSDUPLICATA').AsFloat := LValorJuros /
                                                              FieldByName('CTR_VALCAL').AsFloat;

                LFatorDescontoDuplicata := LValorDesconto / FieldByName('CTR_VALCAL').AsFloat;
                LFatorDespesasDuplicata := LValorDespesas / FieldByName('CTR_VALCAL').AsFloat;

                FieldByName('JUROSNOVADUPLICATA').AsFloat := LValorJuros;
                LValorJuros := fFormataFloat(fltValInf * FieldByName('FATORJUROSDUPLICATA').AsFloat, 2);
                FieldByName('JUROSNOVADUPLICATA').AsFloat := FieldByName('JUROSNOVADUPLICATA').AsFloat - LValorJuros;

                FieldByName('DESCONTONOVADUPLICATA').AsFloat := LValorDesconto;
                LValorDesconto := fFormataFloat(fltValInf * LFatorDescontoDuplicata,2);
                FieldByName('DESCONTONOVADUPLICATA').AsFloat := fFormataFloat(FieldByName('DESCONTONOVADUPLICATA').AsFloat -
                                                                              LValorDesconto,2);

                FieldByName('DESPESASNOVADUPLICATA').AsFloat := LValorDespesas;
                LValorDespesas := fFormataFloat(fltValInf * LFatorDespesasDuplicata,2);
                FieldByName('DESPESASNOVADUPLICATA').AsFloat := fFormataFloat(FieldByName('DESPESASNOVADUPLICATA').AsFloat -
                                                                              LValorDespesas,2);

                FieldByName('VALORBAIXADUPLICATA').AsFloat := fFormataFloat(fltValInf *
                                                                            FieldByName('FATORBAIXADUPLICATA').AsFloat, 2);

                FieldByName('VALORNOVADUPLICATA').AsFloat := fFormataFloat(FieldByName('CTR_VALDUP').AsFloat -
                                                                           FieldByName('VALORBAIXADUPLICATA').AsFloat, 2);

                FieldByName('CTR_VALJUR').AsFloat := LValorJuros;
                FieldByName('CTR_VALDES').AsFloat := LValorDesconto;
                FieldByName('CTR_VALCOB').AsFloat := LValorDespesas;

                Post;
              End
              Else
                pMarcarDuplicata(False);

              fltValInf := 0;
            End
            Else
            Begin
              Edit;

              fltDesSuj    := 0.00;
              fltValDespon := 0.00;

              If (FieldByName('CTR_VALCAL').AsFloat >= FieldByName('CTR_VALDUP').AsFloat) Then
              Begin
                If ((FieldByName('CTR_JURSUJ').AsFloat <> 0)  Or
                    (FieldByName('CTR_DESCOB').AsFloat <> 0)) Or
                   (FieldByName('CTR_DESSUJ').AsFloat <> 0)   Then
                Begin
                  If (FieldByName('CTR_VALCAL').AsFloat = (FieldByName('CTR_VALDUP').AsFloat + FieldByName('CTR_JURSUJ').AsFloat + FieldByName('CTR_DESCOB').AsFloat - FieldByName('CTR_DESSUJ').AsFloat)) Then
                  Begin
                    FieldByName('CTR_VALJUR').AsFloat := FieldByName('CTR_JURSUJ').AsFloat;
                    fltDesSuj := FieldByName('CTR_DESSUJ').AsFloat;
                  End
                  Else If (FieldByName('CTR_VALCAL').AsFloat < (FieldByName('CTR_VALDUP').AsFloat + FieldByName('CTR_JURSUJ').AsFloat + FieldByName('CTR_DESCOB').AsFloat - FieldByName('CTR_DESSUJ').AsFloat)) Then
                  Begin
                    FieldByName('CTR_VALJUR').AsFloat := FieldByName('CTR_JURSUJ').AsFloat -
                                ((FieldByName('CTR_VALDUP').AsFloat + FieldByName('CTR_JURSUJ').AsFloat + FieldByName('CTR_DESCOB').AsFloat - FieldByName('CTR_DESSUJ').AsFloat) -
                                 (FieldByName('CTR_VALCAL').AsFloat));
                    fltDesSuj := FieldByName('CTR_DESSUJ').AsFloat;
                  End
                  Else If (FieldByName('CTR_VALCAL').AsFloat > (FieldByName('CTR_VALDUP').AsFloat + FieldByName('CTR_JURSUJ').AsFloat + FieldByName('CTR_DESCOB').AsFloat - FieldByName('CTR_DESSUJ').AsFloat)) Then
                  Begin

                    If blnDescFinanSomenteAteVenc Then
                    Begin
                      If (TDateTime(dicBaixa['dtaDtaPag'])<= fField('CTR_DTAVEN').AsDateTime + fField('CTR_QTDDAV').AsInteger) Then
                      Begin
                        fltValCal := FieldByName('CTR_VALDUP').AsFloat + FieldByName('CTR_JURSUJ').AsFloat + FieldByName('CTR_DESCOB').AsFloat - FieldByName('CTR_DESSUJ').AsFloat;
                        if blnRecalJur then
                        begin
                          pAtualizarValorJurosRecalculado;
                        end
                        else
                        begin
                          fltValJur := fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                                           FormatDateTime('dd/mm/yyyy', TDateTime(dicBaixa['dtaDtaPag'])),
                                                           fltValCal);

                          FieldByName('CTR_VALJUR').AsFloat := FieldByName('CTR_JURSUJ').AsFloat +
                                                               fltValJur;
                        end;

                        fltDesSuj := FieldByName('CTR_DESSUJ').AsFloat;
                      End
                      Else
                      Begin
                        FieldByName('CTR_VALJUR').AsFloat :=
                          FieldByName('CTR_VALCAL').AsFloat -
                          FieldByName('CTR_VALDUP').AsFloat -
                          FieldByName('CTR_DESCOB').AsFloat +
                          fltDesSuj;
                        fltDesSuj := 0;
                      End;
                    End
                    Else
                    Begin
                      fltValCal := FieldByName('CTR_VALDUP').AsFloat + FieldByName('CTR_JURSUJ').AsFloat + FieldByName('CTR_DESCOB').AsFloat - FieldByName('CTR_DESSUJ').AsFloat;

                      if blnRecalJur then
                      begin
                        pAtualizarValorJurosRecalculado;
                      end
                      else
                      begin
                        fltValJur := fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                                         FormatDateTime('dd/mm/yyyy', TDateTime(dicBaixa['dtaDtaPag'])),
                                                         fltValCal);

                        FieldByName('CTR_VALJUR').AsFloat := FieldByName('CTR_JURSUJ').AsFloat + fltValJur;
                      end;

                      fltDesSuj := FieldByName('CTR_DESSUJ').AsFloat;
                    End;

                  End;
                End
                Else
                Begin
                  FieldByName('CTR_VALJUR').AsFloat := FieldByName('CTR_VALCAL').AsFloat - FieldByName('CTR_VALDUP').AsFloat;

                  If blnDescFinanSomenteAteVenc Then
                  Begin
                    If (TDateTime(dicBaixa['dtaDtaPag']) <= fField('CTR_DTAVEN').AsDateTime + fField('CTR_QTDDAV').AsInteger) Then
                    Begin
                      fltValCal := FieldByName('CTR_VALDUP').AsFloat + FieldByName('CTR_JURSUJ').AsFloat + FieldByName('CTR_DESCOB').AsFloat - FieldByName('CTR_DESSUJ').AsFloat;

                      if blnRecalJur then
                      begin
                        pAtualizarValorJurosRecalculado;
                      end
                      else
                      begin
                        fltValJur := fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                                         FormatDateTime('dd/mm/yyyy', TDateTime(dicBaixa['dtaDtaPag'])),
                                                         fltValCal);

                        FieldByName('CTR_VALJUR').AsFloat := FieldByName('CTR_JURSUJ').AsFloat + fltValJur;
                      end;

                      fltDesSuj := FieldByName('CTR_DESSUJ').AsFloat;
                    End
                    Else
                    Begin
                      FieldByName('CTR_VALJUR').AsFloat :=
                        FieldByName('CTR_VALCAL').AsFloat -
                        FieldByName('CTR_DESCOB').AsFloat -
                        FieldByName('CTR_VALDUP').AsFloat +
                        fltDesSuj;
                      fltDesSuj := 0;
                    End;
                  End
                  Else
                  Begin
                    fltValCal := FieldByName('CTR_VALDUP').AsFloat + FieldByName('CTR_JURSUJ').AsFloat + FieldByName('CTR_DESCOB').AsFloat - FieldByName('CTR_DESSUJ').AsFloat;

                    if blnRecalJur then
                    begin
                      pAtualizarValorJurosRecalculado;
                    end
                    else
                    begin
                      fltValJur := fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                                       FormatDateTime('dd/mm/yyyy', TDateTime(dicBaixa['dtaDtaPag'])),
                                                       fltValCal);

                      FieldByName('CTR_VALJUR').AsFloat := FieldByName('CTR_JURSUJ').AsFloat +
                                                           fltValJur;
                    end;

                    fltDesSuj := FieldByName('CTR_DESSUJ').AsFloat;
                  End;
                End;
              End
              Else
              Begin

                If blnDescFinanSomenteAteVenc Then
                Begin
                  If (fCfgSis('DESPON', varBoolean)) And
                     (VS_Date <= (FieldByName('CTR_DTAVEN').asDateTime + fField('CTR_QTDDAV').AsInteger)) Then
                  Begin
                    fltValDespon  := fFormataFloat(FieldByName('CTR_VALDUP').AsFloat * ( fField('CTR_PERDPO').AsFloat / 100.00 ),2);
                  End;

                  If (TDateTime(dicBaixa['dtaDtaPag']) <= fField('CTR_DTAVEN').AsDateTime + fField('CTR_QTDDAV').AsInteger) Then
                  Begin
                    fltValCal := FieldByName('CTR_VALDUP').AsFloat + FieldByName('CTR_JURSUJ').AsFloat + FieldByName('CTR_DESCOB').AsFloat - FieldByName('CTR_DESSUJ').AsFloat;

                    if blnRecalJur then
                    begin
                      pAtualizarValorJurosRecalculado;
                    end
                    else
                    begin
                      fltValJur := fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                                       FormatDateTime('dd/mm/yyyy', TDateTime(dicBaixa['dtaDtaPag'])),
                                                       fltValCal);

                      FieldByName('CTR_VALJUR').AsFloat := FieldByName('CTR_JURSUJ').AsFloat + fltValJur;
                    end;

                    fltDesSuj := FieldByName('CTR_DESSUJ').AsFloat;
                  End
                  Else
                  Begin
                    FieldByName('CTR_VALJUR').AsFloat :=
                      FieldByName('CTR_VALCAL').AsFloat -
                      FieldByName('CTR_VALDUP').AsFloat +
                      fltDesSuj;
                    fltDesSuj := 0;
                  End;
                End
                Else
                Begin
                  If (fCfgSis('DESPON', varBoolean)) And
                     (VS_Date <= (FieldByName('CTR_DTAVEN').asDateTime - fField('CTR_QTDDAV').AsInteger)) Then
                  Begin
                    fltValDespon  := fFormataFloat(FieldByName('CTR_VALDUP').AsFloat * ( fField('CTR_PERDPO').AsFloat / 100.00 ),2);
                  End;

                  fltValCal := FieldByName('CTR_VALDUP').AsFloat + FieldByName('CTR_JURSUJ').AsFloat + FieldByName('CTR_DESCOB').AsFloat - FieldByName('CTR_DESSUJ').AsFloat;

                  if blnRecalJur then
                  begin
                    pAtualizarValorJurosRecalculado;
                  end
                  else
                  begin
                    fltValJur := fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                                     FormatDateTime('dd/mm/yyyy', TDateTime(dicBaixa['dtaDtaPag'])),
                                                     fltValCal);

                    FieldByName('CTR_VALJUR').AsFloat := FieldByName('CTR_JURSUJ').AsFloat +
                                                         fltValJur;
                  end;

                  fltDesSuj := FieldByName('CTR_DESSUJ').AsFloat;
                End;

              End;

              FieldByName('CTR_VALREC').AsFloat := FieldByName('CTR_VALCAL').AsFloat;
              FieldByName('CTR_VALRES').AsFloat := 0;
              FieldByName('CTR_BAIPAR').AsString:= 'N';
              FieldByName('CTR_TIPBAI').AsString:= 'T';
              fltValInf := fFormataFloat(fltValInf - FieldByName('CTR_VALCAL').AsFloat, 2);
              FieldByName('CTR_VALDES').AsFloat := fltValDespon + fltDesSuj;
              FieldByName('CTR_DTAREC').AsDateTime := TDateTime(dicBaixa['dtaDtaPag']);
              Post;
            End;
          End;
        End
        Else
          pMarcarDuplicata(False);

        If fField('CTR_MARDES').AsString = 'M' Then
          IncluiRegistroMarcado
        Else
        Begin
          If FCloneDatasetMarcados.Locate('AUTOINCREM', fField('AUTOINCREM').AsString, []) Then
            FCloneDatasetMarcados.Delete;
        End;

        If (fltValInf = 0)Then
          Break;

        Next;
      End;

      If (Not fValidaDuplicatasDeCredito(FDuplicatas)) Then
         pDesmarcaDuplicatasDeCredito(FDuplicatas);

      Filter   := LFiltroAnterior;
      Filtered := Not Filter.IsEmpty;

      objLogLibRec.pLimpaTmpLogLib();

      pCalculaTotalDuplicatas(edtDescontoTotal, edtJurosTotal, edtTotalRecebido, edtQtdSelecionadas, True, FCloneDatasetMarcados);

      If LDuplicatasComPixGerados Then
        fMensagem('ATENÇÃO', 'Algumas duplicatas não foram marcadas pois possui Pix ativo gerado.', ['&Ok']);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[]');
    End;
  End;
  cdsCtaRec.First;

end;

{*****************************************}
{*   CHAMA FORM DE FORMA DE PAGAMENTO    *}
{**************************************LE*}

procedure TfrmBaixaReceber.pFrmFormaPgto(ACodigoPortador,
  ACodigoPlanoDeContas: String);
  Var
    strPriCli, strNumDoc, strSeqMod : String;
    blnTemRegCH  : Boolean;
    blnConfirma : Boolean;
    fltValIpiCar, fltValRetCar, fltValAceCar, fltValFreCar, fltValCbsCar, fltValIbsCar, fltVal_IsCar : Double;
    intContador : Integer;
    frmFatFormasPagamento : TfrmFatFormasPagamento;
begin

  blnTemRegCH := fVerificaTemRegCH;
  Try
    Application.ProcessMessages;

    FCloneDatasetMarcados.IndexFieldNames := cdsCtaRec.IndexFieldNames;

    If FCloneDatasetMarcados.RecordCount = 1 Then
      strNumDoc := FCloneDatasetMarcados.FieldByName('NRODUP').AsString +
                   FCloneDatasetMarcados.FieldByName('PARDUP').AsString +
                   FCloneDatasetMarcados.FieldByName('CTR_ESPDOC').AsString +
                   FCloneDatasetMarcados.FieldByName('CTR_CODEMP').AsString
    Else
      strNumDoc := 'DIVERSOS';

    pCriarFormularios(TfrmFatFormasPagamento,frmFatFormasPagamento);
    frmFatFormasPagamento.cdsCtrSel := FCloneDatasetMarcados;
    frmFatFormasPagamento.blnVeiodeCH := blnTemRegCH;
    frmFatFormasPagamento.strCodOpe := strLoginUsuarioLogado;
    frmFatFormasPagamento.blnCtaRec := True;
    frmFatFormasPagamento.fltValTot := fStrToFloat(edtTotalRecebido.Text);
    frmFatFormasPagamento.fltValRecExt := fltValorBaixa;
    frmFatFormasPagamento.strCodPorExt := strCodPorFix;
    frmFatFormasPagamento.edtFaturado.Enabled := False;
    frmFatFormasPagamento.edtFaturado.Visible := False;
    frmFatFormasPagamento.lblFaturado.Visible := False;
    frmFatFormasPagamento.edtFinanc.Visible := False;
    frmFatFormasPagamento.lblFinanc.Visible := False;
    frmFatFormasPagamento.cdsChqPre           := cdsChqPre;
    frmFatFormasPagamento.cdsChqVis           := cdsChqVis;
    frmFatFormasPagamento.strDocume           := strNumDoc;
    frmFatFormasPagamento.strPorBai           := strPorBai;
    frmFatFormasPagamento.Height := 269;

    frmFatFormasPagamento.chkPixAvulso.Visible := True;

    frmFatFormasPagamento.PortadorBaixaCtr := ACodigoPortador;
    frmFatFormasPagamento.PlanoDeContasBaixaCtr := ACodigoPlanoDeContas;

    If (frmFatFormasPagamento.fltValTot < 0.0) Then
    Begin
      frmFatFormasPagamento.edtChqVista.Enabled    := False;
      frmFatFormasPagamento.edtChqVista.Visible    := False;
      frmFatFormasPagamento.lblChequeVista.Visible := False;

      frmFatFormasPagamento.edtChqPre.Enabled    := False;
      frmFatFormasPagamento.edtChqPre.Visible    := False;
      frmFatFormasPagamento.lblChequePre.Visible := False;

      frmFatFormasPagamento.edtCartao.Enabled := False;
      frmFatFormasPagamento.edtCartao.Visible := False;
      frmFatFormasPagamento.lblCartao.Visible := False;

      frmFatFormasPagamento.edtFaturado.Enabled := False;
      frmFatFormasPagamento.edtFaturado.Visible := False;
      frmFatFormasPagamento.lblFaturado.Visible := False;

      frmFatFormasPagamento.edtOrdPag.Enabled := False;
      frmFatFormasPagamento.edtOrdPag.Visible := False;
      frmFatFormasPagamento.lblOrdPag.Visible := False;

      frmFatFormasPagamento.chkPixAvulso.Visible := False;

      frmFatFormasPagamento.Height := 179;
    End
    Else
    Begin
      frmFatFormasPagamento.Height := 283;
      frmFatFormasPagamento.lblValorRestante.Visible := True;
      frmFatFormasPagamento.pnlValDig.Height := 41;

      frmFatFormasPagamento.pnlBoleto.Visible := True;
      frmFatFormasPagamento.pnlBoleto.Left := 253;
      frmFatFormasPagamento.pnlBoleto.Top := frmFatFormasPagamento.edtFaturado.Top;
      frmFatFormasPagamento.pnlBoleto.Enabled := HabilitaRecebimentoPorBoleto(FCloneDatasetMarcados);
    End;

    {***************************************}
    {* ALTERADO PARA TRAZER CLIENTE APENAS *}
    {* SE AS DUPLICATAS FOREM DO MESMO     *}
    {************************************AJ*}
    FCloneDatasetMarcados.First;
    While (Not FCloneDatasetMarcados.Eof) Do
    Begin
      If (FCloneDatasetMarcados.FieldByName('CTR_MARDES').AsString = 'M') Then
      Begin
        If fEmptyStr(frmFatFormasPagamento.strCliente) Then
          frmFatFormasPagamento.strCliente := FCloneDatasetMarcados.FieldByName('CTR_CODCLI').AsString
        Else
        Begin
          If frmFatFormasPagamento.strCliente <> FCloneDatasetMarcados.FieldByName('CTR_CODCLI').AsString Then
          Begin
            frmFatFormasPagamento.strCliente := '';
            Break;
          End;
        End;
      End;
      FCloneDatasetMarcados.Next;
    End;
    FCloneDatasetMarcados.First;

    dicBaixa.AddOrSetValue('strPriCli', strPriCli);

    If (frmFatFormasPagamento.fltValTot = 0.0) Or (frmFatFormasPagamento.ShowModal = mrOK) Then
      blnConfirma := True
    Else
      blnConfirma := False;

    If frmFatFormasPagamento.fltValCre <> 0 Then
    Begin
      blnConfirma := (blnConfirma) And
                     ((fCfgSis('RCXPCC', varBoolean)) Or
                      (Not FCloneDatasetMarcados.Locate('CLI_STATUS;CTR_MARDES',
                                                         VarArrayOf(['I', 'M']), [])));
      If Not blnConfirma Then
        fMensagem('ATENÇÃO', 'Não é permitido gerar Crédito (CC) para clientes inativos.', ['&OK'], 1);
    End;

    // Verifica prazo medio para recebimento de cheque pré.
    If (frmFatFormasPagamento.cdsChqPre.recordCount > 0) then
    Begin
       If (fCfgSis('PRZREC', varInteger) <> 999) Then
           blnConfirma := fVerificaPrazoMedio_RecebimentoChequePre( frmFatFormasPagamento.cdsChqPre );
    End;

    cdsChqPre := frmFatFormasPagamento.cdsChqPre;
    cdsChqVis := frmFatFormasPagamento.cdsChqVis;

    FObjetoPixRecebimento := frmFatFormasPagamento.ObjetoPixRecebimento;

    If blnConfirma Then
    Begin
      //Setando valores utilizados na função de baixa.
      dicBaixa.AddOrSetValue('flValCqp', frmFatFormasPagamento.fltChqPre);
      dicBaixa.AddOrSetValue('fltValCqV', frmFatFormasPagamento.fltChqVis);
      dicBaixa.AddOrSetValue('fltValDin', fFormataFloat(frmFatFormasPagamento.fltDinhei +
                                                        frmFatFormasPagamento.ValorBoleto, 2));
      dicBaixa.AddOrSetValue('fltValCar', frmFatFormasPagamento.fltCartao);
      dicBaixa.AddOrSetValue('fltValOrd', frmFatFormasPagamento.fltOrdPag);
      dicBaixa.AddOrSetValue('fltValFin', frmFatFormasPagamento.fltValFin);
      dicBaixa.AddOrSetValue('fltValCre', frmFatFormasPagamento.fltValCre);

      dicBaixa.AddOrSetValue('fltCreTot', frmFatFormasPagamento.fltValCre);
      dicBaixa.AddOrSetValue('fltRecTot', frmFatFormasPagamento.fltRecTot);

      dicBaixa.AddOrSetValue('blnValCqP', frmFatFormasPagamento.fltChqPre > 0);
      dicBaixa.AddOrSetValue('blnValCqV', frmFatFormasPagamento.fltChqVis > 0);
      dicBaixa.AddOrSetValue('blnValDin', fFormataFloat(frmFatFormasPagamento.fltDinhei +
                                                        frmFatFormasPagamento.ValorBoleto, 2) > 0);
      dicBaixa.AddOrSetValue('blnValCar', frmFatFormasPagamento.fltCartao > 0);
      dicBaixa.AddOrSetValue('blnValOrd', frmFatFormasPagamento.fltOrdPag > 0);
      dicBaixa.AddOrSetValue('blnValFin', frmFatFormasPagamento.fltValFin > 0);

      dicBaixa.AddOrSetValue('RecebidoPixAvulso', frmFatFormasPagamento.chkPixAvulso.Checked);

      dicBaixa.AddOrSetValue('RecebidoPorBoleto', fFormataFloat(frmFatFormasPagamento.ValorBoleto, 2) > 0);

      fltValCli := frmFatFormasPagamento.fltValCre;

      SetLength(arrCartoes,Length(frmFatFormasPagamento.arrCartoes));
      For intContador := 0 To Length(frmFatFormasPagamento.arrCartoes)-1 Do
      Begin
        arrCartoes[intContador] := frmFatFormasPagamento.arrCartoes[intContador];

        pCarregaImpostoProporcional(arrCartoes[intContador].fltValDig, fltValIpiCar, fltValRetCar, fltValAceCar, fltValFreCar, fltValCbsCar, fltValIbsCar, fltVal_IsCar);

        arrCartoes[intContador].fltValIpi := fltValIpiCar;
        arrCartoes[intContador].fltValRet := fltValRetCar;
        arrCartoes[intContador].fltValAce := fltValAceCar;
        arrCartoes[intContador].fltValFre := fltValFreCar;
        arrCartoes[intContador].fltValCbs := fltValCbsCar;
        arrCartoes[intContador].fltValIbs := fltValIbsCar;
        arrCartoes[intContador].fltVal_Is := fltVal_IsCar;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message,'');
    End;
  End;

  FCloneDatasetMarcados.IndexFieldNames := 'AUTOINCREM';
  pFreeAndNil(frmFatFormasPagamento);

  If blnConfirma Then
    strSeqMod := fRetSequencial('MODCTR');

  If fEmptyStr(strSeqMod) Then
    blnConfirma := False;

  dicBaixa.AddOrSetValue('strSeqMod', strSeqMod);
  dicBaixa.AddOrSetValue('blnConfirma', blnConfirma);

  If Not blnConfirma Then
    Exit;

end;

function TfrmBaixaReceber.fGetClienteSelecionado(var ACodigoClienteSelecionado : String) : Boolean;
begin
  Result := True;

  If cdsCtaRec.IsEmpty Then
  Begin
    fMensagem('', 'É necessário carregar ao menos uma duplicata!', ['&Ok']);
    Exit(False);
  End;

  cdsCtaRec.DisableControls;
  cdsCtaRec.First;

  ACodigoClienteSelecionado := '';
  while not(cdsCtaRec.eof) do
    begin
      if (cdsCtaRec.FieldByName('CTR_MARDES').AsString = 'M') then
        begin
          if ACodigoClienteSelecionado = '' then
            ACodigoClienteSelecionado := cdsCtaRec.FieldByName('CTR_CODCLI').AsString
          else
          if ACodigoClienteSelecionado <> cdsCtaRec.FieldByName('CTR_CODCLI').AsString then
            begin
              fMensagem('', 'É necessário selecionar duplicatas de somente um cliente entre as '+
                'marcadas!', ['&Ok']);
              cdsCtaRec.First;
              cdsCtaRec.EnableControls;
              Exit(False);
            end;
        end;

      cdsCtaRec.Next;
    end;

  if ACodigoClienteSelecionado = '' then
    begin
      fMensagem('', 'É necessário selecionar ao menos uma duplicata entre as carregadas!', ['&Ok']);
      cdsCtaRec.First;
      cdsCtaRec.EnableControls;
      Exit(False);
    end;

  cdsCtaRec.First;
  cdsCtaRec.EnableControls;
end;

function TfrmBaixaReceber.fVerificaTemRegCH: Boolean;
begin
  Result := False;

  FCloneDatasetMarcados.First;
  While Not FCloneDatasetMarcados.Eof Do
  Begin

    If FCloneDatasetMarcados.FieldByName('CTR_ESPDOC').AsString = 'CH' Then
    Begin
      Result := True;
      Break;
    End;

    FCloneDatasetMarcados.Next;
  End;

  FCloneDatasetMarcados.First;
end;


function TfrmBaixaReceber.fZerosAEsquerdaRomaneio(strNumero: string;
  intTamanho: integer): string;
var
  I: integer;
begin
  Result := '';
  for I := 0 to (intTamanho - Length(strNumero)) - 1 do
  begin
    Result := Result + '0';
  end;
  Result := Result + strNumero;
end;

function TfrmBaixaReceber.GerarPixDasDuplicatas(
  pgbProgresso: TcxProgressBar): Boolean;
  Var
    LRequisicaoPix: IRequisicoesPix;

    LDadosRequisicao: TDadosRequisicaoPixAVista;

    LDadosResposta: TDadosRetornoPixAVista;

    LPixDao: TPixDao;

    LErro,
    LRequsicaoJson,
    LRetornoJson,
    LCodigoCliente,
    LAutoIncremChavePix: String;

    CriaObjetoRequisicoesPix: function(AAutoIncremPix: String): IRequisicoesPix; StdCall;
begin
  Result := False;

  LAutoIncremChavePix := fCfgSis('CHAPIX');
  if TPixDao.ChavePixUtilizaTefScope(LAutoIncremChavePix) = 'S' then
  begin
    fMensagem('ATENÇÃO',
              'A configuração CFG_CHAPIX está ativa (Pix via TEF Scope).' + #13 +
              'Esta modalidade aceita somente Pix presencial.',
              ['&Ok']);
    Exit;
  end;

  pgbProgresso.Visible := False;

  FDuplicatasPix := TUNiClientDataset.Create(Nil);
  FDuplicatasPix.Data := FCloneDatasetMarcados.Data;
  FDuplicatasPix.Open;

  LCodigoCliente := DeterminaCodigoDoClienteDevedorPix(FDuplicatasPix);
  If LCodigoCliente.IsEmpty Then
    Raise ExceptionAutcom.Create('Para utilizar essa função, as duplicatas devem pertencer ao mesmo cliente!');

  If Not ValidarValorPixComDataSetMarcadas(fStrToFloat(edtTotalRecebido.Text), FDuplicatasPix) Then
  Begin
    fMensagem('ATENÇÃO', 'O valor a receber das duplicatas selecionadas na tela não bate com o valor do Pix que será gerado.' + #13 +
                         'Recarregue as duplicatas e selecione os registros novamente.' + #13 +
                         'Caso a divergência persista, entre em contato com a Citel!', ['&Ok']);

    Exit;
  End;

  If fMensagem('ATENÇÃO', 'Deseja realmente ' + IIF(FPixJaGerado, ' enviar o Pix', ' gerar e enviar o Pix') +
                          ' por e-mail/sms ao cliente?', ['&Sim', '&Não']) = 2 Then
    Exit;

  LErro := EmptyStr;

  LDadosRequisicao := Nil;
  LDadosResposta := Nil;
  LPixDao := Nil;
  Try
    TFuncoesPixAutcom.CarregaLibIntegracaoPixCitel;

    CriaObjetoRequisicoesPix  := GetProcAddress(TFuncoesPixAutcom.FHandlePixCitel, 'CriaObjetoRequisicoesPix');
    LRequisicaoPix := CriaObjetoRequisicoesPix(LAutoIncremChavePix);

    LDadosRequisicao := TFuncoesPixAutcom.RetornaDadosRequisicaoReceber(FDuplicatasPix,
                                                                        fStrToFloat(edtTotalRecebido.Text),
                                                                        LCodigoCliente);

    LDadosRequisicao.ChavePix := LRequisicaoPix.GetChavePix;

    Try
      LDadosRequisicao.TextoItemShipay := LDadosRequisicao.SolicitacaoPagador;
      LDadosRequisicao.UtilizaShipay := TPixDao.ChavePixUtilizaShipay(LAutoIncremChavePix);
      LDadosRequisicao.UtilizaTefScope := TPixDao.ChavePixUtilizaTefScope(LAutoIncremChavePix);
      LDadosRequisicao.TipoCobranca := 'variavel';

      LRequsicaoJson := TFuncoesPix.RetornaJsonDadosRequisicao(LDadosRequisicao);

      LRetornoJson := LRequisicaoPix.CriarCobranca(LRequsicaoJSON);

      LErro := TFuncoesPix.RetornaMensagemErroRequisicao(LRetornoJson);
      If Not LErro.IsEmpty Then
        Raise ExceptionAutcom.Create(LErro);

      LDadosResposta := TFuncoesPix.RetornaDadosDoRetornoPixAVista(LRequsicaoJson,
                                                                   LRetornoJson,
                                                                   LAutoIncremChavePix,
                                                                   LDadosRequisicao.UtilizaShipay = 'S',
                                                                   LDadosRequisicao.UtilizaTefScope = 'S');

      LDadosResposta.CriadoPelo := 'FINANCEIRO';

      If LDadosResposta.UtilizaShipay = 'S' Then
      Begin
        LDadosResposta.JsonRequisicao := LRequisicaoPix.GetRequisicaoPixAtualizadaShipay;
        LDadosResposta.OrderRef := TFuncoesPix.RetornaOrderRefShipay(LDadosResposta.JsonRequisicao);
        LDadosResposta.SolicitacaoPagador := LDadosRequisicao.SolicitacaoPagador;
      End;

      LPixDao := TPixDao.Create;

      fStartTransaction;
      If LPixDao.InserirCobrancaPixAVista(LDadosResposta, Self.Name) Then
      Begin
        FObjetoPixEmail := TFuncoesPix.RetornaDadosDoRetornoPixAVista(LRequsicaoJson,
                                                                      LRetornoJson,
                                                                      LAutoIncremChavePix,
                                                                       LDadosRequisicao.UtilizaShipay = 'S',
                                                                       LDadosRequisicao.UtilizaTefScope = 'S');

        AtualizarCADRECEmailPix(FDuplicatasPix,
                                LDadosResposta.Txid,
                                Self.Name);
      End;
      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;

        If LErro.IsEmpty Then
          LErro := TFuncoesPix.RetornaMensagemErroRequisicao(E.Message);

        Raise ExceptionAutCom.Create(IIF(LErro.IsEmpty, E.Message, LErro));
      End;
    End;

    Result := True;
  Finally
    If LDadosRequisicao <> Nil Then
      FreeAndNil(LDadosRequisicao);

    If LDadosResposta <> Nil Then
      FreeAndNil(LDadosResposta);

    TFuncoesPixAutcom.LiberaObjetosIntegracaoPix(LRequisicaoPix);

    If Assigned(LPixDao) Then
      FreeAndNil(LPixDao);

    If Not LErro.IsEmpty Then
      Raise ExceptionAutCom.Create('Ocorreu um erro ao gerar o Pix da Venda.' + #13 +
                                   LErro);
  End;
end;

procedure TfrmBaixaReceber.GravarLogCtrDuplicatas(
  AArrayGravacaoLog: array of TGravacaoLogCtr; var pgbProgresso: TcxProgressBar);
  Var
    LDuplicata: TGravacaoLogCtr;
begin
  If Length(AArrayGravacaoLog) = 0 THen
    Exit;

  Try
    pgbProgresso.Properties.Max := Length(AArrayGravacaoLog);
    pgbProgresso.Position := 0;

    For LDuplicata In AArrayGravacaoLog Do
    Begin
      If Not LDuplicata.AutoIncremCtr.IsEmpty Then
        untCadRec.pGravaLogCtr(LDuplicata.AutoIncremCtr,
                               LDuplicata.Descricao,
                               LDuplicata.Formulario)
      Else
        untCadRec.pGravaLogCtr(LDuplicata.NumeroDuplicata,
                               LDuplicata.EspecieDocumento,
                               LDuplicata.CodigoCliente,
                               LDuplicata.CodigoEmpresa,
                               LDuplicata.ParcelaDuplicata,
                               LDuplicata.SequencialBaixa,
                               LDuplicata.Descricao,
                               LDuplicata.Formulario);

      pStepStatusGravacao(pgbProgresso, 'Aguarde... Gravando histórico das duplicatas.');
    End;
  Except
    Raise;
  End;
end;

function TfrmBaixaReceber.HabilitaRecebimentoPorBoleto(
  ADataset: TDataset): Boolean;
  Var
    LFiltroAnterior: String;
begin
  Result := Not ADataset.Locate('CTR_TIPBAI', 'P', []);

  If Result Then
  Begin
    Try
      LFiltroAnterior := ADataset.Filter;

      ADataset.Filter := 'CTR_MARDES=''M'' AND CTR_VALREC<0';
      ADataset.Filtered := True;

      Result := ADataset.IsEmpty;
    Finally
      ADataset.Filter := LFiltroAnterior;
      ADataset.Filtered := Not ADataset.Filter.IsEmpty;
    End;
  End;
end;

function TfrmBaixaReceber.LiberacaoBaixaTotalComDesconto: Boolean;
  Var
    LTotalCorrigido: Double;
    LTotalRecebido: Double;
begin

  objLiberacao.Clear;
  objLiberacao.strDirAce := 'CTRBXTOTCDESC';
  objLiberacao.objMsgLibera.pAddTexto('***  PERMITE BAIXA TOTAL COM DESCONTO  ***', alCentro, teAmbos, '', 124);
  objLiberacao.objMsgLibera.pAddSeparador(124);
  objLiberacao.objMsgLibera.pAddTexto('|--------------------------------------------------------------------------------------------------------------------------|');
  objLiberacao.objMsgLibera.pAddTexto('|                                                  RESUMO DOS TÍTULOS SELECIONADOS                                         |');
  objLiberacao.objMsgLibera.pAddTexto('|--------------------------------------------------------------------------------------------------------------------------|');
  objLiberacao.objMsgLibera.pAddTexto('| DOCUMENTO        | EMP | CLIENTE                             | DT.VENC.   | DT.CAD.    |   VR.DUPLICATA | VR.CORRIGIDO(*)|');
  objLiberacao.objMsgLibera.pAddTexto('|--------------------------------------------------------------------------------------------------------------------------|');

  cdsCtaRec.First;
  LTotalCorrigido := 0;
  LTotalRecebido := 0;

  While Not cdsCtaRec.Eof Do
  Begin
    If cdsCtaRec.FieldByName('CTR_MARDES').AsString.Equals('M') And cdsCtaRec.FieldByName('CTR_TIPBAI').AsString.Equals('T')  Then
    Begin
      If fFormataFloat(cdsCtaRec.FieldByName('CTR_VALREC').AsFloat,2) < fFormataFloat(cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat,2) Then
      Begin
        objLiberacao.objMsgLibera.pAddTexto( '| ' + fPadR(cdsCtaRec.FieldByName('NRODUP').AsString,12) +
                                                            cdsCtaRec.FieldByName('PARDUP').AsString + '-' +
                                                            cdsCtaRec.FieldByName('CTR_ESPDOC').AsString + ' | ' +
                                                            cdsCtaRec.FieldByName('CTR_CODEMP').AsString + ' | ' +
                                                      fPadR(cdsCtaRec.FieldByName('CTR_NOMCLI').AsString, 35) + ' | ' +
                                                      FormatDateTime('dd/mm/yyyy',cdsCtaRec.FieldByName('CTR_DTAVEN').AsDateTime) + ' | ' +
                                                      FormatDateTime('dd/mm/yyyy',cdsCtaRec.FieldByName('CTR_DTACAD').AsDateTime) + ' | ' +
                                                      fPadL(FloatToStrF(cdsCtaRec.FieldByName('CTR_VALDUP').AsFloat, ffNumber, 9, 2),14) + ' | ' +
                                                      fPadL(FloatToStrF(cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat, ffNumber, 9, 2),14) + ' |');

        LTotalCorrigido := LTotalCorrigido + cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat;
        LTotalRecebido := LTotalRecebido + cdsCtaRec.FieldByName('CTR_VALREC').AsFloat;
      End;
    End;
    cdsCtaRec.Next;
  End;

  cdsCtaRec.First;

  If LTotalCorrigido = 0 Then
    Exit(True);

  objLiberacao.objMsgLibera.pAddSeparador(124);
  objLiberacao.objMsgLibera.pAddQuebra;
  objLiberacao.objMsgLibera.pAddTextoCaption('Total Corrigido'  , 'R$'+FormatFloat('#,###,##0.00',  LTotalCorrigido )  , 19);
  objLiberacao.objMsgLibera.pAddTextoCaption('Total Recebido'    , 'R$'+FormatFloat('#,###,##0.00',  LTotalRecebido)  , 19);
  objLiberacao.objMsgLibera.pAddQuebra;


  objLiberacao.strMsgSen := 'Baixa total com desconto.';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;

  Result := objLiberacao.fLibera;
  If Result Then
     objLogLibRec.pInsereLogLigTMP( objLiberacao, cdsCtaRec.FieldByName('CTR_NUMDUP').AsString, cdsCtaRec.FieldByName('CTR_ESPDOC').AsString, cdsCtaRec.FieldByName('CTR_CODEMP').AsString );

  objLiberacao.Clear;

end;

function TfrmBaixaReceber.LiberacaoConfirmacaoDaBaixa: Boolean;
begin
  Result := False;

  If fVerificaAcessoSistema('BAIXACTRBTNCONFIRMA') Then
    Exit(True);

  fMensagem('ATENÇÃO!', 'Operador sem direito de acesso para confirmar a baixa!', ['&Ok']);
End;

function TfrmBaixaReceber.LockDuplicatas(pgbProgresso: TcxProgressBar): Boolean;
  Var
  intRecNo  : Integer;

  LDadosDuplicata: TArray<String>;
  LDuplicataAtual: String;
  LDuplicataEmUso : Boolean;
begin
  //Result := False;
  Result := True;
  LDuplicataEmUso := False;

  If FListaMarcarTodas.Count = 0 Then
    Exit;

  pgbProgresso.Position := 0;
  pgbProgresso.Properties.Max := FListaMarcarTodas.Count;

  intRecNo := cdsCtaRec.RecNo;


  For LDuplicataAtual In FListaMarcarTodas Do
  Begin

    LDadosDuplicata := LDuplicataAtual.Split(['|']);

    If fDuplicataTravada(LDadosDuplicata[0],
                         LDadosDuplicata[1],
                         LDadosDuplicata[2],
                         LDadosDuplicata[3],
                         LDadosDuplicata[4],
                         blnMarcandoTodas,
                         False) Then
    Begin
      cdsCtaRec.Locate('NRODUP;CTR_ESPDOC;CTR_CODEMP;CTR_CODCLI;PARDUP',
                       VarArrayOf([LDadosDuplicata[0],
                                   LDadosDuplicata[1],
                                   LDadosDuplicata[2],
                                   LDadosDuplicata[3],
                                   LDadosDuplicata[4]]), []);

      cdsCtaRec.Edit;
      cdsCtaRec.FieldByName('CTR_MARDES').AsString := 'D';
      cdsCtaRec.Post;
      LDuplicataEmUso := True;
    End;

    pStepStatusSelecao(pgbProgresso);
  End;

  cdsCtaRec.RecNo := intRecNo;

  If fInTransaction Then
    fCommit;

  If LDuplicataEmUso Then
    fMensagem('ATENÇÃO!', 'Duplicatas não marcadas estão sendo utilizadas por outra estação!', ['&OK']);

end;

function TfrmBaixaReceber.MarcandoTodasDuplicatasELiberado: Boolean;
begin
  Result := blnMarcandoTodas;

  If Result Then
    Result := FLiberadoUtilizacaoCredito;
end;

{*****************************************}
{*   CHAMA FORM DE SELECIONADAS          *}
{**************************************LE*}
procedure TfrmBaixaReceber.pMostraDuplicatasSelecionadas;
begin
  frmConsDuplicSelec.pMostraDuplicatasSelecionadas('CADREC', cdsCtaRec);
end;

function TfrmBaixaReceber.fDuplicatasJaUtilizadasPorOutrosUsuarios: Boolean;
Begin
  Result := False;

  objBaixaReceber.pCarregaListSelecionada(FCloneDatasetMarcados.FieldByName('AUTOINCREM').AsString);

  If fVerificaDupBaixada(FCloneDatasetMarcados.FieldByName('NRODUP').AsString,
                         FCloneDatasetMarcados.FieldByName('PARDUP').AsString,
                         FCloneDatasetMarcados.FieldByName('CTR_ESPDOC').AsString,
                         FCloneDatasetMarcados.FieldByName('CTR_CODEMP').AsString,
                         FCloneDatasetMarcados.FieldByName('CTR_CODCLI').AsString,
                         FCloneDatasetMarcados.FieldByName('CTR_SEQBAI').AsInteger) Then
  Begin
    Result := True;
  End;
End;

function TfrmBaixaReceber.fVerificaDuplicatasExcluidas: Boolean;
  Var
    strSQL: String;
Begin
  Result := True;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   COUNT(*) AS QTD ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + ' CADREC ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CTR_NUMDUP = :NRODUP AND ';
  strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '   CTR_PARCEL = :PARDUP     ';

  qryTmpExc.Params.Clear;
  qryTmpExc.SQL.Clear;
  qryTmpExc.SQL.Add(strSQL);
  qryTmpExc.ParamByName('NRODUP').AsString := FCloneDatasetMarcados.FieldByName('NRODUP').AsString;
  qryTmpExc.ParamByName('ESPDOC').AsString := FCloneDatasetMarcados.FieldByName('CTR_ESPDOC').AsString;
  qryTmpExc.ParamByName('CODEMP').AsString := FCloneDatasetMarcados.FieldByName('CTR_CODEMP').AsString;
  qryTmpExc.ParamByName('CODCLI').AsString := FCloneDatasetMarcados.FieldByName('CTR_CODCLI').AsString;
  qryTmpExc.ParamByName('PARDUP').AsString := FCloneDatasetMarcados.FieldByName('PARDUP').AsString;

  qryTmpExc.Open;

  If Not qryTmpExc.IsEmpty Then
  Begin
    If qryTmpExc.FieldByName('QTD').AsInteger = 0 Then
    begin
      Result := False;
    end;
  End
  Else
  begin
    Result := False;
  end;
End;

function TfrmBaixaReceber.ValidarValorPixComDataSetMarcadas(AValorPix: Double;
  ADatasetPix: TDataset): Boolean;
  Var
    LValorPix: String;

    LValorTotalDuplicatas: Double;
begin
  LValorPix := FormatFloat(',0.00', AValorPix);

  LValorTotalDuplicatas := 0;
  ADatasetPix.First;
  While Not ADatasetPix.Eof Do
  Begin
    LValorTotalDuplicatas := LValorTotalDuplicatas + fFormataFloat(ADatasetPix.FieldByName('CTR_VALREC').AsFloat, 2);

    ADatasetPix.Next;
  End;

  Result := LValorPix.Equals(FormatFloat(',0.00', LValorTotalDuplicatas));
end;

function TfrmBaixaReceber.VerificacoesParaBaixa(pgbProgresso: TcxProgressBar): Boolean;
Begin
  Result := True;
  blnResult := Result;
  qryTmpExc := fCriaQuery;
  FCloneDatasetMarcados.First;

  pgbProgresso.Position := 0;
  pgbProgresso.Properties.Max := FCloneDatasetMarcados.RecordCount;
  objBaixaReceber.pLimparListSelecionada;
  While Not FCloneDatasetMarcados.Eof Do
  Begin
    If fDuplicatasJaUtilizadasPorOutrosUsuarios Then
    Begin
      fMensagem('ATENÇÃO!', 'Existem duplicatas que estão sendo baixadas e as mesma foram utilizadas por outro usuário. Realize a pesquisa novamente para efetuar as baixas corretamente!', ['&OK']);
      blnResult := False;
      Exit;
    End;

    {********************************************************************}
    {* REALIZADO ESSE TRATAMENTO DEVIDO AO DESAGRUPAMENTO DE DUPLICATAS *}
    {********************************************************************}
    If Not fVerificaDuplicatasExcluidas Then
    Begin
      fMensagem('ATENÇÃO!', 'Existem duplicatas que foram excluídas por outro usuário. Realize a pesquisa novamente para efetuar as baixas corretamente!', ['&OK']);
      blnResult:= False;
      Exit;
    End;
    pStepStatusSelecao(pgbProgresso);
    FCloneDatasetMarcados.Next;
  End;
  pFreeAndNil(qryTmpExc);
End;

procedure TfrmBaixaReceber.pAddLogDtaRet(ALiberacao: TLiberacao);
begin
  With cdsCtaRec Do
  Begin
    if blnMarcouTodas then
      First;

    objLogLibRec.pInsereLogLigTMP(ALiberacao,
                                  FieldByName('NRODUP').AsString,
                                  FieldByName('CTR_ESPDOC').AsString,
                                  FieldByName('CTR_CODEMP').AsString);
  End;
end;

function TfrmBaixaReceber.fVerificaAlteracaoDespesaCobranca(strAutoin: String; flVlDescCob : Double): Boolean;
Var
  strSQL: String;
  qryGen: TUniQuery;
Begin

  Result := False;

  Application.ProcessMessages;
  qryGen := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CTR_DESCOB ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADREC ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   AUTOINCREM = :AUTOINC ';

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('AUTOINC').AsString  := strAutoIn;
    Open;

    If (Not IsEmpty) Then
       Result := (qryGen.FieldByName('CTR_DESCOB').AsFloat <> flVlDescCob);

  End;

  FreeAndNil(qryGen);
end;

end.
