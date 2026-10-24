{**************************}
{* qryConCli -> CADCLI    *}
{***********************JB*}
unit untRcxResumoCaixa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, MaskEditFocus, untfuncoesSimples, Menus, DateUtils,
  RLFilters, RLDraftFilter, StrUtils, RLTypes, DB, Uni, Printers,
  frxClass, AppEvnts, untFuncFat, UniClientDataSet, UITypes, Math,
  untCadRec, untCadChq, untTypesSistema, BitBtnLockedIncrem, untGravaMovCar,
  untTefRecebimento, untFastPrintEditor, untReciboCtr, untReciboCtrMeiaFolha, untFatConfOrcamentos,
  untFuncoesGenerica, frxExportCSVTestabilidade, untRcxRecbBaixDocs, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, WinSpool,
  System.Generics.Collections, untReciboCTP, untMetaCentroCustoPedido,untAuditoriaGravacaoResumoCaixa,
  untFuncoesRel, untLiberacao,
  untTLock, untRcxTResumoDeCaixa, untRcxTrasfValores, untFechamentoFinanceiro,untTProrrogacaoDeTitulos,
  untInterfaceTefCitel, untFatGor, untTiposPix, untTLogLibRec, cxProgressBar, untTPixDao,
  dxScreenTip, cxClasses, dxCustomHint, cxHint, untTefCitelUtil,
  untReciboCtpMeiaFolha,untTDesmembramentoBaixaReceber;

Const
  RCX_GRAVA_NORMAL   = 1;
  RCX_GRAVA_DESCONTO = 2;
  RCX_GRAVA_JUROS    = 3;
  RCX_GRAVA_DESPCOBR = 4;

  PENDENCIA_PDV_CHEQUE = 1;

type
  TTransfOperador = class
  private
    FOperador:     String;
    FPorTrans:     String;

    FDinheiro:     Double;
    FChqAVista:    Double;
    FChqAPrazo:    Double;
    FCartao:       Double;
    FOrdPag:       Double;
    FFinanc:       Double;
    FPixRec:       Double;

    FDinheiro2:    Double;
    FFinanc2:      Double;
    FChqAVista2:   Double;
    FCartao2:      Double;
    FOrdPag2:      Double;
    FChqAPrazo2:   Double;
    FPixRec2:      Double;

    FFundoDeCaixa: Double;

  public
    constructor Create(strOperador: String);
    property strOperador:  String read FOperador  write FOperador;
    property strPorTrans:  String read FPorTrans  write FPorTrans;

    property fltDinheiro:  Double read FDinheiro  write FDinheiro;
    property fltChqAVista: Double read FChqAVista write FChqAVista;
    property fltChqAPrazo: Double read FChqAPrazo write FChqAPrazo;
    property fltCartao:    Double read FCartao    write FCartao;
    property fltOrdPag:    Double read FOrdPag    write FOrdPag;
    property fltFinanc:    Double read FFinanc    write FFinanc;
    property PixRec:       Double read FPixRec    write FPixRec;

    property fltDinheiro2:  Double read FDinheiro2  write FDinheiro2;
    property fltChqAVista2: Double read FChqAVista2 write FChqAVista2;
    property fltChqAPrazo2: Double read FChqAPrazo2 write FChqAPrazo2;
    property fltCartao2:    Double read FCartao2    write FCartao2;
    property fltOrdPag2:    Double read FOrdPag2    write FOrdPag2;
    property fltFinanc2:    Double read FFinanc2    write FFinanc2;
    property PixRec2:       Double read FPixRec2    write FPixRec2;

    property fltFundoDeCaixa: Double read FFundoDeCaixa write FFundoDeCaixa;
  end;

  TfrmRcxResumoCaixa = class(TfrmPaiSimples)
    btnGravar: TBitBtnLocked;
    btnFecharCaixa: TBitBtnLocked;
    btnCancFec: TBitBtnLocked;
    pnlCentral: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtCodOpe: TEditFocus;
    edtNomOpe: TEditFocus;
    mskDiaAbe: TMaskEdit;
    edtSalIni: TEditFocus;
    pnlDocumento: TPanel;
    lblValRec: TLabel;
    Label7: TLabel;
    edtValDoc: TEditFocus;
    edtDescri: TEditFocus;
    pnlModalidades: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label20: TLabel;
    edtDinRec: TEditFocus;
    edtCarRec: TEditFocus;
    edtChqRec: TEditFocus;
    edtChqPre: TEditFocus;
    edtValJur: TEditFocus;
    edtValDes: TEditFocus;
    edtTroco: TEditFocus;
    pgcDadosGerais: TPageControl;
    tbsLancamentos: TTabSheet;
    tbsRecebimentos: TTabSheet;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    Label5: TLabel;
    edtNumDoc: TEditFocus;
    lsvLancamentos: TListView;
    edtDesOpc: TEditFocus;
    btnHisDeb: TBitBtnLocked;
    btnRelatorio: TBitBtnLocked;
    btnFormaPagamento: TBitBtnLocked;
    btnConfirmaCupons: TBitBtnLocked;
    btnBaixaCtaPagar: TBitBtnLocked;
    btnDepoCheque: TBitBtnLocked;
    mnuRelatorio: TPopupMenu;
    mnuRelatorio1: TMenuItem;
    mnuRomaneio: TMenuItem;
    btnRomaneio: TBitBtnLocked;
    btnAbreGaveta: TBitBtnLocked;
    edtRomaneio: TEditFocus;
    lblRomaneio: TLabel;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    Label4: TLabel;
    edtOrdRec: TEditFocus;
    btnLiberacao: TBitBtnLocked;
    btnInfDoc: TBitBtnLocked;
    Label21: TLabel;
    edtSqFcRx: TEditFocus;
    btnConfOrcamentos: TBitBtnLocked;
    btnTitRec: TBitBtnLocked;
    chkDuplicatasVista: TCheckBox;
    lblClienteCC: TLabel;
    edtClienteCC: TEditFocus;
    btnCapturarGT: TBitBtnLocked;
    lblFinanc: TLabel;
    edtFinanc: TEditFocus;
    btnBusContrato: TSpeedButton;
    btnImprDAV: TBitBtnLocked;
    btnAutTR: TBitBtnLocked;
    chkSaldoInicial: TCheckBox;
    lblNomMoe: TLabel;
    lblCredito: TLabel;
    btnConfCupSimplificada: TBitBtnLocked;
    btnBaixaEntFutura: TBitBtnLocked;
    btnConfFFSimplificada: TBitBtnLocked;
    btnAtalhos: TBitBtnLocked;
    popEstornos: TPopupMenu;
    btnEstorno: TMenuItem;
    btnEstornoPG: TMenuItem;
    btnAcompanhaServ: TBitBtnLocked;
    btnCancelamentoPDV: TSpeedButton;
    tmrCancelamentos: TTimer;
    edtCodRed: TEditFocus;
    edtDescRed: TEditFocus;
    Label6: TLabel;
    btnFatPromocaoBrindes: TBitBtnLocked;
    btnAdiantamento: TBitBtnLocked;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    btnRelAltFormaPag: TBitBtnLocked;
    btnCancelaCC: TBitBtnLocked;
    btnEntFutCD: TBitBtnLocked;
    btnLeituraX: TBitBtnLocked;
    lblVrRestante: TLabel;
    lblCaixa: TLabel;
    edtCodigoCaixa: TEditFocus;
    edtDescricaoCaixa: TEditFocus;
    btnReceberPix: TBitBtnLocked;
    chkPixAvulso: TCheckBox;
    HintControler: TcxHintStyleController;
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtDinRecEnter(Sender: TObject);
    procedure edtDinRecExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnFecharCaixaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancFecClick(Sender: TObject);
    procedure edtDescriEnter(Sender: TObject);
    procedure tbsLancamentosShow(Sender: TObject);
    procedure tbsRecebimentosShow(Sender: TObject);
    procedure lsvLancamentosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lsvLancamentosEnter(Sender: TObject);
    procedure btnHisDebClick(Sender: TObject);
    function fGravaCheques(intSeqBai: Integer): Boolean;
    function fChequePre(strValor: String; blnPagarVencido: Boolean = False): Boolean;
    function fChequeVis(strValor: String): Boolean;
    function fChequesCadastrados(fltValor: Double; blnPrazo: Boolean): Boolean;
    procedure btnRelatorioClick(Sender: TObject);
    procedure pImprimeRecibo(intOpcao: Integer);
    procedure edtCodCliChange(Sender: TObject);
    procedure btnFormaPagamentoClick(Sender: TObject);
    procedure btnConfirmaCuponsClick(Sender: TObject);
    procedure btnBaixaCtaPagarClick(Sender: TObject);
    procedure btnDepoChequeClick(Sender: TObject);
    procedure btnRomaneioClick(Sender: TObject);
    procedure btnAbreGavetaClick(Sender: TObject);
    procedure edtRomaneioKeyPress(Sender: TObject; var Key: Char);
    procedure edtRomaneioExit(Sender: TObject);
    procedure edtRomaneioChange(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtTrocoChange(Sender: TObject);
    procedure btnLiberacaoClick(Sender: TObject);
    procedure btnInfDocClick(Sender: TObject);
    procedure btnConfOrcamentosClick(Sender: TObject);
    procedure btnTitRecClick(Sender: TObject);
    procedure pgcDadosGeraisChange(Sender: TObject);
    procedure edtCodCliExit(Sender: TObject);
    procedure btnCapturarGTClick(Sender: TObject);
    procedure btnBusContratoClick(Sender: TObject);
    procedure btnImprDAVClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnAutTRClick(Sender: TObject);
    procedure btnConfCupSimplificadaEnter(Sender: TObject);
    procedure btnConfCupSimplificadaExit(Sender: TObject);
    procedure btnConfCupSimplificadaClick(Sender: TObject);
    procedure btnBaixaEntFuturaClick(Sender: TObject);
    procedure btnConfFFSimplificadaEnter(Sender: TObject);
    procedure btnConfFFSimplificadaExit(Sender: TObject);
    procedure btnConfFFSimplificadaClick(Sender: TObject);
    procedure btnAtalhosClick(Sender: TObject);
    procedure btnEstornoClick(Sender: TObject);
    procedure btnEstornoPGClick(Sender: TObject);
    procedure btnAcompanhaServClick(Sender: TObject);
    procedure btnCancelamentoPDVClick(Sender: TObject);
    procedure tmrCancelamentosTimer(Sender: TObject);
    procedure edtCodRedKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnFatPromocaoBrindesClick(Sender: TObject);
    procedure btnAdiantamentoClick(Sender: TObject);
    procedure btnEntFutCDClick(Sender: TObject);
    procedure cxDateEdit1PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure btnRelAltFormaPagClick(Sender: TObject);
    procedure btnCancelaCCClick(Sender: TObject);
    procedure btnLeituraXClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtOrdRecChange(Sender: TObject);
    procedure btnReceberPixClick(Sender: TObject);
    procedure pgcDadosGeraisChanging(Sender: TObject; var AllowChange: Boolean);
    procedure chkPixAvulsoClick(Sender: TObject);
  private
    { Private declarations }
    cdsTmpResumoCaixa: TUniClientDataSet;
    dtsTmpResumoCaixa: TDataSource;
    fltValChq: Double;
    strEspLancamentos: String;

    qryRecNBai: TUniQuery;
    strEmpSav: String;
    qryConCli: TUniQuery;
    FQryCnd15V: TUniQuery;

    FPais: TPais;

    strSeqRcx: String; //autoincrem da gravacao do resumo de caixa

    fltTotRec: Double; //Total recebido (Duplicatas)
    fltValDoc: Double;
    fltValJur: Double;
    fltDesRec: Double;
    fltValCob: Double;
    fltTotCre: Double;
    fltTotLiq: Double;
    intQtdSel: Integer;

    fltValCre: Double;
    fltDifCre: Double;

    fltTotDinSav: Double;

    fltTotRea   : Double;
    fltTotGua   : Double;
    fltTotDol   : Double;
    fltTotEur   : Double;
    fltTotPes   : Double;

    fltTotRea2  : Double;
    fltTotGua2  : Double;
    fltTotDol2  : Double;
    fltTotEur2  : Double;
    fltTotPes2  : Double;

    blnEdiCam  : Boolean;
    blnQuitacao: Boolean;
    blnRcxRom  : Boolean;
    blnFecham  : Boolean;

    blnTroChq  : Boolean;
    blnTroCar  : Boolean;
    blnLibTroco : Boolean;
    blnLibDin: Boolean;
    blnLibCar: Boolean;
    blnLibChv: Boolean;
    blnLibChp: Boolean;
    blnLibOrd: Boolean;

    blnLibRecCH: Boolean;
    blnVeiodeCH: Boolean;

    blnDescFinanSomenteAteVenc: Boolean;

    strFpgSelPD: String;
    strCodCarSelPD: String;
    intQtdPaCSelPD: Integer;

    FUtilizaContabilidade: Boolean;

    strEspDoc: String;
    strCliCco: String;
    strCodFor: String;
    strCta_Pg: String;
    strDescri: String;
    strVeioNF: String;
    strJus_Pg: String;

    strMotDes: String;

    strCodEve: String;

    fltUltFec: Double;
    dtaDtaFec: TDateTime;
    dtaDtaCai: TDateTime;

    strNumDupPG: String;

    intSeqCon: Integer;
    intLckTel: Integer;
    intConfirma: Integer;

    arrCartoes: TCartoesResumoCaixaArray;
    strCodCliTip: String; //Código do cliente caso usa Tipo de Cliente
    stlForPag: TStringList; // Formas de Pagamento para Tipo de Cliente
    stlCndPag: TStringList; // Condição de Pagamento para Tipo de Cliente

    blnChamaCadastro: Boolean;

    cdsChqVis: TUniClientDataSet;
    cdsChqPre: TUniClientDataSet;

    stlContratos: TStringList;

    blnExecutouOnShow: Boolean;

    objTefRecebimento: ITefRecebimento;

    cdsImpRec : TUniClientDataSet;
    cdsImpRecCG : TUniClientDataSet;
    cdsImpPag : TUniClientDataSet;
    editorFast: TFastPrintFileEditor;
    reciboCtr : TReciboCtr;
    reciboCtrMeiaFolha : TReciboCtrMeiaFolha;
    reciboCtp : TReciboCtp;
    reciboCtpMeiaFolha  : TReciboCtpMeiaFolha;

    oblTransfOperadores: TObjectList<TTransfOperador>;
    objLiberacao:  TLiberacao;
    objLock: TLock;
    strSessaoTef : String;

    strTipoFechamentoCaixa: String;

    FAuditoriaResumoCaixa: IAuditoriaGravacaoResumoCaixa;
    objFechamento: TFechamentoFinanceiro;
    objProrrogacao : TProrrogacaoDeTitulos;

    documento: TDocAdiantamento;
    dadosAdiantamento: TDadosAdiantamento;


    objResumoDeCaixa: TResumoDeCaixa;

    FDadosPixRecebimento,
    FDadosPixRequisicao,
    FAutoIncremChavePix: String;

    FObjetoPixRecebimento: TDadosRetornoPixConsulta;

    strTpParc: String;

    blnChqPreLiberado : Boolean;
    blnRecAVencerChqPreLiberado : Boolean;

    FLiberadoCartCred : Boolean;
    FLiberadoCartCredaVencer : Boolean;

    strCodClienteCredSel : String;

    arrClientes: TConsultasArray;

    blnRetirouTrocoDinheiro : boolean;

    procedure pShowHint(const AedtEdit: TCustomEdit; const AstrTitulo: String);
    procedure pHideHint;

    procedure pVerificaDireitosBotoes;
    procedure pCriarClientCreditoGerado(intSeqCon: Integer);
    procedure log(s: String);

    function fDigMoedas(fltTotalDin: Double): Boolean;
    function fChamaTelaDocumentos(strCodEmp: String; strNumDoc: String = ''; strEspDoc: String = '';
      blnBuscaContratos: Boolean = False; blnDocsAVistaOrigLoja: Boolean = False): Boolean;
    function fConfirmaResumoCaixa(fltDinRec, fltCarRec, fltChqRec, fltChqPre, fltOrdRec, fltValTroco_ : Double): Boolean;
    function fPedePortadorCreditoCliente(var strPortador, strEvento: String): String;
    function RetornaPortadorCredito: String;
    function PagamentoEmUmaModalidade: Boolean;
    function fGravaCreditoCliente(intOpcao: Integer;
                                  strPortad: String;
                                  intSeqCon: Integer;
                                  out strAutIncCadRecCredito : String;
                                  strEvento: String = '';
                                  ARecebidoPorPix: String = 'N'): Boolean;

    function fCartoesCadastrados(fltValor: Double): Boolean;
    function fVerificaPedidosPendentesDeFaturamento:Boolean;
    function fValidaValorMod(fltValRec, fltValDoc: Double): Boolean;
    function fGravaResCai(intOpcao: Integer; const strAutIncCadRecCredito : String; stlSeqBai: TStringList = Nil; strCodOpe: String = ''; fltFundoDeCaixa: Double = 0.00): Boolean;
    function fVerificaMeta(dtaMeta: TDateTime;strCodCta, strCodEmp, strCodFor: String;fltValLan: Double): Boolean;

    function fGravar: Boolean;

    function PermiteLancamentoNoCaixaAtual (const AEspecieDocumento : String; const ATipoFechamento : String): Boolean;

    function fFecharCaixa: Boolean;
    function fCancelaFechamento: Boolean;

    function fDigitacaoCartoes(fltValor: Double): Boolean;
    function fRetornaDocumentosTraDoc: TArrayInfoTraDoc ;

    function fValidaFormaPagamento(Const intTipCli: Integer): Boolean;

    function fGravaLogControle(Var strMsgDif: String; Const intSeqCon: Integer; blnAnalisar: Boolean = False): Boolean;

    function fSenhaSomenteCreditos(fltTotRec, fltTotCre: Double): Boolean;

    Procedure pTrocaSinalMoedas(fltDinRec: Double);
    function fGravaReciboTransferencia(ASeqResumo, ACodEmp, ARecibo: String): Boolean;

    Procedure pHabilitaClienteCC(blnHabilita: Boolean);

    procedure pRetornaUsuarioCaixa;

    procedure pChamaClienteCredito;
    function fDigDadosPagamentos: Boolean;
    function fDadosDoPagamentoValidos: Boolean;

    procedure pVerificaSobraCredito;
    procedure pSelecionaDupNaoQuitacao;

    procedure pIniciaValoresPadrao;
    procedure pCarregaCliente(strCodCli: String);

    procedure pZeraVariaveisResumo;
    function ValidarEmpresaAcesso: Boolean;

    procedure pEditaCamposModalidades;
    procedure pLimpaCampos;
    procedure pFocarElemento;

    procedure pPreparaParaConfirmarFF(objVenda: TFatVenda);

    procedure pDocumentosTrocaFormaPagamento;
    Procedure pPosChamaTelaDocumentos;
    function fDireitoAcessoLancamentos(strEspDoc, strDesOpc: String): Boolean;
    procedure pVoltaSeqFechamentoParcial;
    procedure pMostraObsCliente;
    function fImprimirCarnePagamentos: Boolean;
    procedure pCancelarTefDeCartoesJaConfirmados;
    procedure pGarantirCancelamentoTefRecebimento(strArquivo: String);

    procedure pImprimirSangria(fltDinhei, fltCartao, fltChqAvi, fltChqPre,
      fltOrdPag: Double);
    procedure pImprimirSuprimento(fltDinhei, fltCartao, fltChqAvi, fltChqPre,
      fltOrdPag: Double);
    function fDefineModalidadeEcf(strCodFpg: String): String;
    function fVerificaFormasDePagamentoNoEcf: Boolean;
    function fImprimeReciboLayout(arrCodCli: Array of TRcxDadosCliente;
                                  intOpcao: Integer;
                                  vltCreditoTroco: Double;
                                  vltTotalRecebido: Double;
                                  strNomFil: String = '';
                                  strTipImp : String = ''): Boolean;
    function fLogChq(qryLog: TDataset; intOpcao: Integer; blnTransf: Boolean = False): Boolean;overload;
    function fLogChq(AAutoIncrem: String; intOpcao: Integer; blnTransf: Boolean = False): Boolean; overload;
    procedure pMensagemCuponsMuitoVelhosSemImprimir;
    procedure pCarregaImpostoProporcional(fltValor: Double; Out fltValIpi, fltValRet, fltValAce, fltValFre, fltValCbs, fltValIbs, fltVal_Is: Double);
    function fGetCliIFOrDocs(strNumDoc, strCodEmp, strEspDoc: String): String;
    function fTemCancelamentosPDV: Boolean;
    function fTemDocumentosPendentesPDV: Boolean; overload;
    function fTemDocumentosPendentesPDV(dtaDtaMov: TDateTime): Boolean; overload;
    function fNumeroDuplicataCTPValido: Boolean;

    function fTemNFCePendente: Boolean;
    procedure pMostraNFCePendentes;

    function fTemPendenciaChequesPDV: Boolean;
    procedure pVerificaPendenciaChequesPDV;

    procedure pCarregaRede;
    function fExistDuplicNaoBai: Boolean;
    function fExisteDocumentosAbertosCnd15Vencidos: Boolean;
    function fLiberaCaixaDocumentosAbertosCnd15Vencidos(): Boolean;

    procedure pEscPressionado(Sender: TWinControl);

    procedure pExecutarConfOrcamentos;

    function fVerificaAndamentoLancamento: Boolean;
    function fValidaCtaCtr(strCodCta: String): Boolean;
    function fAnalisaFechamentoOperadoresCaixa: Boolean;
    function AnalisaFechamentoOperadoresCaixaZerado: Boolean;
    function fGetTitulosSelecionados: TArrDupSel;
    function fGetModalidadesDigitadas: TArrModalidade;
    function fVerificaTemCreditos(): Boolean;
    function fDocumentoExiste(strNomeTabela, strAutoInc: String): Boolean;
    function fBaixaDeComissaoParaProfissional: Boolean;

    procedure pBuscaCtrsParaImpressao(intSeqCon: Integer);
    procedure pCalculaVrRestante;
    function ValidaValorDigitado(AEdit: TEdit): Boolean;
    function fMensagemDocumentosPDV: Boolean;
    function fSomentePOS: Boolean;
    procedure pImprimeTermoDeFechamentoComDivergencia;
    function GetTotalRecebidoBruto: Double;
    function fRetornaTotalCliente(strCodCli, strSql: String): Real;
    function fVerificaTefCitelPendente : Boolean;
    procedure pGaranteCancelamentoTefCitel;
    function fApagarBoletoDeAdiantamentoPedido(): Boolean;
    function fUsaRotinaBoletoAdiantamento(): Boolean;
    function fInfDup(strCampo, strTitulo: String): String;

    function DuplicataComissaoProfissional: Boolean;
    function fVerificaTitulosVencidosSelecionados(): Boolean;
    function fVerificaTitulosAVencerSelecionados(): Boolean;
    function fEhMultiLojaComAlgumaEmpresaTefDesligado(): Boolean;

    procedure AbreTelaParaPagamentoDoPix;
    function ValidarSeExistePixRecebidoSemConfirmacao: Boolean;

    procedure AdicionarDadosDasDuplicatas(var ALiberacao: TLiberacao);
    function CalculaValorRestante: Double;
    function fLiberarRecebChqPre: Boolean;
    function fLiberarRecebChqPreAVencer: Boolean;
    procedure pAddDupVencidas;
    procedure pAddDupAVencer;
    function fGetClienteSelCredito: String;
    function fRetornaStrClienteDocs(ArrDupSel: TArrDupSel): String;
    function fRetSQLClienteSelCredito: String;

    procedure pExecutaTransferencia;
    function ExisteSaldoVinculadoATransferir: Boolean;
    function VerificarSeExisteSaldoVinculadoATransferirAntesDoFechamento: Boolean;
    function TodosOsPlanosDeContasTransferenciaCadastrados: Boolean;
    procedure pMostraOperadoresESaldosPendentes();
    function fCodOpeTransf(frmRcxTrasfValores: TfrmRcxTrasfValores): String;
    procedure pSeparaOperadores(frmRcxTrasfValores: TfrmRcxTrasfValores;
                                ATFPixAvulso: Boolean);
    function fGetDescricaoTransferencia(strTipoTF: String): String;

    function ValidaSaldoOrdemPagamentoPix(APixAvulso: Boolean;
                                          ASaldoTransferido: Double): Boolean;

    function LancamentoDeTransferenciaSemMovBan(ASequecial: Integer): Boolean;

    function EstaRealizandoRecebimentoF1F2: Boolean;

    function fVerificaAlteracaoDespesaCobranca(strAutoin: String; flVlDescCob : Double): Boolean;

    function fGravaCreditoClienteTroco(fltValorTrc: Double;
                                       strPortad: String;
                                       intSeqCon: Integer;
                                       strContaBai: string;
                                       strCodEvento: string = '';
                                       ARecebidoPorPix: String = 'N'): Boolean;
   function TravaMovimentoCaixaEmFechamento : Boolean;
  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnFecharForm: Boolean;
    blnF11: Boolean;
  end;

implementation

uses
  {$IFNDEF LINUX}
    untArredondaParcelasCartoes,
  {$ENDIF LINUX}
  untPesqAux,untFuncoes, untRcxSelDocumentos, untRcxDigCliente,
  untRcxDigPagamento, untPai, untRcxFecCaixa, untRcxCancFechamento,
  untRcxDigCartoes, untRcxMostraCartoes, untCadCheques,
  untRelRcxResumoCaixa, untConsultas,untFiscal,
  untRcxSelDocsFpg, untRcxConfCupom, untFatEmitirEntFutEmpCD,
  untBaixaCtaPagar, untConstantes, untBaixaCheques,
  untRcxReimpTransfer,
  untFuncoesAuxiliares, TypesRel, untFuncoesFiscais,
  untQckRcxReciboCB, untRcxLiberacaoExpedicao, untEstornoReceber,
  untRcxDigDocumento, untQckRcxRecBai40cB,
  untRcxMostraCheques, untPrincipal, untFuncoesRel2,
  untRcxTransferenciaImpr, untFatMostraObsCliente, untEnviaImpCheque,
  untBaixaAnalitica, untQckReciboCtaReceber, MaskUtils,
  untConsultaServicosAutocenter, untCancelaPedidosPendentes, untMovCar,
  untMovBan, untCadPag, untCfgRel, untCadRcxx, untRomGer,
  untPafCadIniECF, untCarnePagto, untRcxDocumentosDAV, untFunTef,
  untRcxDigMoedas, untRcxTrasfValoresPar, untConfCupom,
  untPanelCxClientes, untPnlDadosCliente, untFatBaixaEntregaFutura,
  untConfDocs, untParCalculaPrecoCusto, untAdiantamentoCliente,
  untConsultaServicosAutocenterVendas, untFatCancelamentosPDV,
  untRcxNFCePendentes, untLibNfe, untImportaPAFECFCheques,
  untQckRcxReciboBai2Fast, untValorPorExtenso, untFatPromocaoBrindes,
  untEstornoPagar, untRcxTravas, untTBanCtpRepository,
  untValidaTitulosFxCaixa, untGravando,
  untRcxCancelaCC, untPafGerais, untDuplicatas, untQckRcxRecCredPenCli,
  untLogMca,
  untArredondaParcelaImpl, untMsgLiberacao,
  untLiberacaoFactory, untModulo, untImportaMovimentoPAFECF,
  Shared.Functions.Types, untRelRcxResumoCaixaMod, untAtualizaOcorrenciasCRM, untTypesCRM,
  untDocumento, untIDocumento, untTBanTrf, untMovTef,
  untAdiantamentoClienteGenerico, untTFuncoesPixAutcom, untTFuncoesAuxiliaresPix,
  untCalculadorNotaFiscalEspecialTintometricoBasesColorantes,
  untCalculadorNotaFiscalEspecialTintometricoProdutoAcabado,
  untITelaGravandoExecucao, untRcxSelClienteCred, untTravaCaixa,
  untDigPortador, untMostraDebCtrChq2, untLogCba, untLogChq;

{$R *.dfm}

procedure TfrmRcxResumoCaixa.btnSairClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Procedure TfrmRcxResumoCaixa.pPosChamaTelaDocumentos;
Begin
  If fCfgSis('ABRGAV', varBoolean) Then
    btnAbreGaveta.Click;

  If (Not edtValDoc.Enabled) Then
  Begin
    If (edtDescri.Enabled) Then
    Begin
      pSetFocus(edtDescri);
    End
    Else If (pnlModalidades.Enabled) Then
    Begin
      If      edtDinRec.Enabled Then pSetFocus(edtDinRec)
      Else If edtCarRec.Enabled Then pSetFocus(edtCarRec)
      Else If edtOrdRec.Enabled Then pSetFocus(edtOrdRec)
      Else If edtChqRec.Enabled Then pSetFocus(edtChqRec)
      Else If edtChqPre.Enabled Then pSetFocus(edtChqPre);
    End
    Else
    Begin
      pSetFocus(btnGravar);
    End;
    blnMudarFoco := False;
  End;
End;

function TfrmRcxResumoCaixa.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    fltCarRec: Double;
    fltSalFec: Double;
    strDescri: String;

    LCaixaJaFechado: Boolean;

    LDataLancamento: TDateTime;
    LChqPreVencido: Boolean;
    LChqPreAVencer: Boolean;

  function fVeiodeCH: Boolean;
    Var
      objTabela : TRegistroMsgLiberaTabela;
      objLinha  : TLinhaMsgLibera;
      strContCli : String;
  Begin


    If blnLibRecCH Then
    Begin
      Result := True;
      Exit;
    End;

    objLiberacao.Clear;

    objLiberacao.objMsgLibera.pAddTexto('Recebimento de documento proveniente de cheque.');
    objLiberacao.objMsgLibera.pAddTexto('Existem duplicatas com espécie CH, ou seja, documento proveniente de um cheque transformado em contas a receber. ');
    objLiberacao.objMsgLibera.pAddTexto('Não é permitido receber nessa modalidade (Cheque/Cartão).');
    objLiberacao.objMsgLibera.pAddQuebra;

    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'CÓDIGO - NOME CLIENTE' , 55 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'NOME FANTASIA'         , 30 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'CNPJ/CPF'              , 14 , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , ' '             , 1  , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'DUPLICATA'     , 14 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'ESPÉCIE'       , 7  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'EMPRESA'       , 7  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'VALOR'         , 18 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'DT. CADASTRO'  , 14 , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'DT. VENCIMENTO', 14 , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'PORTADOR'      , 14 , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);


    strContCli := '';
    With cdsTmpResumoCaixa Do
    Begin
      First;
      While Not Eof Do
      Begin
        IF (FieldByName('CTR_MARDES').AsString = 'M') and (FieldByName('CTR_ESPDOC').AsString = 'CH') then begin

          if strContCli <>  FieldByName('CTR_NOMCLI').AsString then begin
            strContCli := FieldByName('CTR_NOMCLI').AsString;

            objLinha  := TLinhaMsgLibera.Create;
            objLinha.enuTipoLinha := tlValor;
            objLinha.pAddColuna('CÓDIGO - NOME CLIENTE' , FieldByName('CTR_NOMCLI').AsString , 55 , alEsquerda);
            objLinha.pAddColuna('NOME FANTASIA'         , FieldByName('CLI_FANSOB').AsString , 30 , alEsquerda);
            objLinha.pAddColuna('CNPJ/CPF'              , FieldByName('CLI_C_G_C_').AsString , 14 , alDireita );
            objTabela.lstLinhas.Add(objLinha);
          end;

          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna(''              ,' '                                                                , 1  , alEsquerda , teAutcom);
          objLinha.pAddColuna('DUPLICATA'     , FieldByName('CTR_DUPPAR').AsString                                , 14 , alEsquerda           );
          objLinha.pAddColuna('ESPÉCIE'       , FieldByName('CTR_ESPDOC').AsString                                , 7  , alCentro             );
          objLinha.pAddColuna('EMPRESA'       , FieldByName('CTR_CODEMP').AsString                                , 7  , alCentro             );
          objLinha.pAddColuna('VALOR'         , FormatFloat('0.00', FieldByName('CTR_VALDUP').AsFloat)            , 18 , alDireita            );
          objLinha.pAddColuna('DT. CADASTRO'  , FormatDatetime('dd/mm/yyyy',FieldByName('CTR_DTACAD').AsDatetime) , 14 , alCentro             );
          objLinha.pAddColuna('DT. VENCIMENTO', FormatDatetime('dd/mm/yyyy',FieldByName('CTR_DTAVEN').AsDatetime) , 14 , alCentro             );
          objLinha.pAddColuna('PORTADOR'      , FieldByName('CTR_CODPOR').AsString                                , 14 , alDireita            );
          objTabela.lstLinhas.Add(objLinha);
        End;
        Next;
      End;
    End;

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
    objLiberacao.objMsgLibera.pAddQuebra;

    objLiberacao.objMsgLibera.pAddTexto('Modalidade(s) de Pagamento', alCentro, teAmbos, '', 106);
    objLiberacao.objMsgLibera.pAddSeparador(106);

    objLiberacao.objMsgLibera.pAddTextoCaption('Dinheiro'           , FloatToStrF(fStrToFloat(edtDinRec.Text), ffFixed, 12, 2) , 20, alDireita, teAmbos, '', 18);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cheque a Vista'     , FloatToStrF(fStrToFloat(edtChqRec.Text), ffFixed, 12, 2) , 20, alDireita, teAmbos, '', 18);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cartão'             , FloatToStrF(fStrToFloat(edtCarRec.Text), ffFixed, 12, 2) , 20, alDireita, teAmbos, '', 18);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cheque Pre'         , FloatToStrF(fStrToFloat(edtChqPre.Text), ffFixed, 12, 2) , 20, alDireita, teAmbos, '', 18);
    objLiberacao.objMsgLibera.pAddTextoCaption('Ordem de Pagamento' , FloatToStrF(fStrToFloat(edtOrdRec.Text), ffFixed, 12, 2) , 20, alDireita, teAmbos, '', 18);
    If (Not fEmptyStr(edtFinanc.text)) Then
      objLiberacao.objMsgLibera.pAddTextoCaption('Financiamento'    , FloatToStrF(fStrToFloat(edtFinanc.Text), ffFixed, 12, 2) , 20, alDireita, teAmbos, '', 18);

    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTextoCaption('Operador'           , edtCodOpe.text + ' - ' + edtNomOpe.text, 10);

    objLiberacao.strDirAce := 'CTRCHQ';
    objLiberacao.strMsgSen := 'Recebimento de documento proveniente de cheque';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;

    blnLibRecCH := Result;

  End;

begin

  Result := True;

  LChqPreVencido := False;
  LChqPreAVencer := False;
  objResumoDeCaixa.fRetornaUltimoFechamento(fltSalFec, dtaDtaFec, edtCodigoCaixa.Text);

  If (Sender <> edtCodCli) Then
  Begin
    LCaixaJaFechado := (dtaDtaFec >= dtaDtaCai);
    If (strTipoFechamentoCaixa = 'C') Then
    Begin
      LCaixaJaFechado := dtaDtaCai < VS_Date;

      If LCaixaJaFechado Then
        LCaixaJaFechado := objResumoDeCaixa.fNecessitaFecharCaixa(False, LDataLancamento, edtCodigoCaixa.Text, False, VS_strCodEmp);
    End;

    If LCaixaJaFechado Then
    Begin
      pFocarElemento;
      fMensagem('', 'O fechamento referente ao dia: ' + mskDiaAbe.Text + ' já foi efetuado!', ['&Ok']);
      Result := False;
      Exit;
    End;
  End;

  If (Sender = edtNumDoc) Then
  Begin
    {***************************************************************************}
    {* CASO SEJA PAGAMENTO, CONFIGURADO NÃO PARA A CONFIG CFG_PGSEQ_ E   *******}
    {* O CAMPO DE DOCUMENTO ESTIVER PREENCHIDO, SERÁ VERIFICADO SE O DOCUMENTO *}
    {* INFORMADO É VÁLIDO PARA SER GRAVADO NA CADPAG ***************************}
    {**REQ*107074************************************************************MO*}
    If (strEspDoc = 'PG') and
       (Not (fCfgSis('PGSEQ_', varBoolean))) and
       (Not fEmptyStr(edtNumDoc.Text)) Then
    Begin
      if Not fNumeroDuplicataCTPValido then
      begin
        fMensagem('ATENÇÃO!', 'O número de duplicata informado já existe para esse fornecedor nessa empresa, corrija!', ['&Ok']);
        Result := False;
      end;
    end;

  End

  Else If (Sender = edtCodRed) Then
  Begin
    If (Not fEmptyStr(edtCodRed.Text)) Then
      pCarregaRede
    Else
      edtDescRed.Text := 'TODOS';

    If fEmptyStr(edtDescRed.Text) And (Not fEmptyStr(edtCodRed.Text))  Then
    Begin
      fMensagem('AVISO','Código da rede não encontrado.', ['&O K']);
      edtCodRed.Clear;
      pSetFocus(edtCodCli);
    End;
  End

  Else If (Sender = edtCodCli) Then
  Begin

      If (Not fEmptyStr(edtCodCli.Text)) Then
      Begin
        If Not SameText(edtCodCli.Text, '00000000') Then
        Begin
          SetLength(arrClientes, 0);

          pCarregaCliente(edtCodCli.Text);
          If (qryConCli.FieldByName('CLI_CODCLI').IsNull) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Cliente não está cadastrado!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else
      Begin
        edtNomCli.Text := 'TODOS';
      End;
      If Result And blnBuscaPorChave And fCfgSis('EXOBCR', varBoolean) And (Length(arrClientes) < 2) Then
        pMostraObsCliente;

  End

  Else If (Sender = mskDtaIni) Then
  Begin

    If ((fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And ((fEmptyStr(edtCodCli.Text)) And (fEmptyStr(edtRomaneio.Text)))) Or
      ((Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
    Begin
      fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = mskDtaFin) Then
  Begin

    If ((fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And ((fEmptyStr(edtCodCli.Text)) And (fEmptyStr(edtRomaneio.Text)))) Or
      ((Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
    Begin
      fMensagem('ATENÇÃO!', 'A data final deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If Not mskDtaFin.ValidateEdit(False) Then
    Begin
      Result := False;
    End
    Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A data inicial deve ser menor que a data final!', ['&Ok']);
      Result := False;
    End
    Else If (Not fValidaCampos(mskDtaIni, True)) Then
    Begin
      Result := False;
    End
    Else
    Begin

      If (blnBuscaPorChave) Then
      Begin

        Try

          If InterlockedIncrement(intLckTel) = 0 Then
          Begin
            If EstaRealizandoRecebimentoF1F2 Then
              Exit(False);

            Result := fChamaTelaDocumentos(edtCodEmp.Text);
          End
          Else
            InterlockedDecrement(intLckTel);

        Except
          pZeraVariaveisResumo;
          Result := False;
        End;
        InterlockedDecrement(intLckTel);

        If (Result) Then
        Begin

          pPosChamaTelaDocumentos;

        End;

        If strTipoFechamentoCaixa <> 'C' Then
          edtSqFcRx.Text := fStrZero(VarToStr(fCfgSisL('SQFCRX')), 3);

      End;

    End;

  End

  Else If (Sender = edtValDoc) Then
  Begin
    If (edtValDoc.Enabled) Then
    Begin

      If (fEmptyStr(edtValDoc.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor do documento deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (fStrToFloat(edtValDoc.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor do documento deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        fltTotLiq := fStrToFloat(edtValDoc.Text);
        fltValDoc := fltTotLiq;
      End;

    End;
  End
  Else If (Sender = edtDescri) Then
  Begin
    pEditaCamposModalidades;
    If (Not fEmptyStr(strEspDoc) Or (Not cdsTmpResumoCaixa.IsEmpty)) Then
    Begin
      pnlModalidades.Enabled := True;
    End;
  End
  Else If (Sender = edtDinRec) Then
  Begin
    If (fEmptyStr(edtDinRec.Text)) Then
    Begin
      edtDinRec.Text := '0,00';
      fltTotGua      := 0;
      fltTotDol      := 0;
      fltTotEur      := 0;
      fltTotPes      := 0;
      fltTotRea      := 0;
      fltTotDinSav   := 0;
    End;

    If (edtDinRec.Enabled) Then
      Result := fValidaValorMod(fStrToFloat(edtDinRec.Text), fltValDoc);

    {*******************************************}
    {* VALIDAÇÃO CASO USE TIPO DE CLIENTE      *}
    {****************************************MV*}
    If (Result) And (fCfgSis('USATPC', varBoolean)) And (fStrToFloat(edtDinRec.Text) > 0.0) And
      (Not blnLibDin) Then
    Begin
      Result := fValidaFormaPagamento(TPC_DINHEIRO);
      If (Not Result) Then
        fMensagem('ATENÇÃO!', 'Modalidade (DINHEIRO) não permitida para esse cliente!', ['&Ok'])
      Else
        blnLibDin := True;
    End

    Else If (FPais = opcParaguai) And (fStrToFloat(edtDinRec.Text) > 0) Then
    Begin

      If ((ActiveControl) = edtDinRec) Then
      Begin

        Result := Result And fDigMoedas(fStrToFloat(edtDinRec.Text));

        If edtChqRec.CanFocus Then
        Begin
          pSetFocus(edtChqRec);
          blnMudarFoco := FALSE;
        End;

      End;

    End
    Else
    Begin
      fltTotGua := 0;
      fltTotDol := 0;
      fltTotEur := 0;
      fltTotPes := 0;
      fltTotRea := 0;
    End;

    If Result And (fStrToFloat(edtDinRec.Text) > 0.0) And (Not fPermiteModalidadeParaPortador(fCfgSis('PORRCX'), 'MODDIN')) Then
    Begin
      fMensagem('','O Portador para baixa não tem permissão para esta modalidade!',['&OK']);
      Result := False;
    End;

  End
  Else If (Sender = edtCarRec) Then
  Begin
    pHideHint ;
    If (fEmptyStr(edtCarRec.Text)) Then
    Begin
      pCancelarTefDeCartoesJaConfirmados;
      edtCarRec.Text := '0,00';
      SetLength(arrCartoes, 0);
    End;

    If (edtCarRec.Enabled) Then
      Result := fValidaValorMod(fStrToFloat(edtCarRec.Text), fltValDoc);

    {*******************************************}
    {* VALIDAÇÃO CASO USE TIPO DE CLIENTE      *}
    {****************************************MV*}
    If (Result) And (fCfgSis('USATPC', varBoolean)) And (fStrToFloat(edtCarRec.Text) > 0.0) And
      (Not blnLibCar) Then
    Begin
      Result := fValidaFormaPagamento(TPC_CARTAO);
      If (Not Result) Then
        fMensagem('ATENÇÃO!', 'Modalidade (CARTAO) não permitida para esse cliente!', ['&Ok'])
      Else
        blnLibCar := True;
    End;

    If Result Then
      Result := ValidaValorDigitado(edtCarRec);

    {*************************************************}
    {*                                               *}
    {* VERIFICA SE EXISTE ALGUM DOCUMENTO MARCADO    *}
    {* COM ESPÉCIE CH, O QUE SIGNIFICA QUE O MESMO   *}
    {* VEIO DE UMA DEVOLUÇÃO DEFINITIVA OU TRANFERIU *}
    {* O CHEQUE PARA O CTR.                          *}
    {* CASO SEJA ISSO DEVE SER SOLICITADO UMA SENHA  *}
    {* DE LIBERAÇÃO PARA O MESMO                     *}
    {*                                               *}
    {**24/02/2015**REQ:30058***********************AF*}
    If Result And blnVeiodeCH And (fStrToFloat(edtCarRec.Text) <> 0.0) Then
    Begin
      If Not fVeiodeCH Then
      Begin
        Result := False;
        edtCarRec.Text := '0,00';
      End;
    End;

    If Result And (fStrToFloat(edtCarRec.Text) > 0.0) And (Not fPermiteModalidadeParaPortador(fCfgSis('PORRCX'), 'MODCAR')) Then
    Begin
      fMensagem('','O Portador para baixa não tem permissão para esta modalidade!',['&OK']);
      Result := False;
    End;

    If (fStrToFloat(edtCarRec.Text) = 0.0) And FLiberadoCartCred Then
    begin
      pRemoveLiberacao('PRDVCCCHP','001');
      FLiberadoCartCred := False;
    end;

    If (fStrToFloat(edtCarRec.Text) = 0.0) And FLiberadoCartCredAVencer Then
    begin
      pRemoveLiberacao('DIRRCXRECDUPAVCCCH','001');
      FLiberadoCartCredAVencer := False;
    end;
    
    If (Result) Then
    Begin
      fltCarRec := fStrToFloat(edtCarRec.Text);

      If (blnBuscaPorChave) And
         ( fEmptyStr( strEspDoc ) Or (Pos(strEspDoc, 'LC_CC_') > 0)) Then
      Begin
        If fCfgSis('DIGCAR') = 'S' Then
          Result := fDigitacaoCartoes(fltCarRec)
        Else
          Result := True;
      End;
    End;

  End
  Else If (Sender = edtChqRec) Then
  Begin

    If (fEmptyStr(edtChqRec.Text)) Then
      edtChqRec.Text := '0,00';

    If (edtChqRec.Enabled) Then
      Result := fValidaValorMod(fStrToFloat(edtChqRec.Text), fltValDoc);

    {*******************************************}
    {* VALIDAÇÃO CASO USE TIPO DE CLIENTE      *}
    {****************************************MV*}
    If (Result) And (fCfgSis('USATPC', varBoolean)) And (fStrToFloat(edtChqRec.Text) > 0.0) And
      (Not blnLibChv) Then
    Begin
      Result := fValidaFormaPagamento(TPC_CHEQUE_VISTA);
      If (Not Result) Then
        fMensagem('ATENÇÃO!', 'Modalidade (CHEQUE A VISTA) não permitida para esse cliente!', ['&Ok'])
      Else
        blnLibChv := True;
    End;

    {*************************************************}
    {*                                               *}
    {* VERIFICA SE EXISTE ALGUM DOCUMENTO MARCADO    *}
    {* COM ESPÉCIE CH, O QUE SIGNIFICA QUE O MESMO   *}
    {* VEIO DE UMA DEVOLUÇÃO DEFINITIVA OU TRANFERIU *}
    {* O CHEQUE PARA O CTR.                          *}
    {* CASO SEJA ISSO DEVE SER SOLICITADO UMA SENHA  *}
    {* DE LIBERAÇÃO PARA O MESMO                     *}
    {*                                               *}
    {**24/02/2015**REQ:30058***********************AF*}
    If Result And blnVeiodeCH And (fStrToFloat(edtChqRec.Text) <> 0.0) Then
    Begin
      If Not fVeiodeCH Then
      Begin
        Result := False;
        edtChqRec.Text := '0,00';
      End;
    End;

    If Result And (fStrToFloat(edtChqRec.Text) > 0.0) And (Not fPermiteModalidadeParaPortador(fCfgSis('PORRCX'), 'MODCHV')) Then
    Begin
      fMensagem('','O Portador para baixa não tem permissão para esta modalidade!',['&OK']);
      Result := False;
    End;

    {*******************************}
    {* SE ESTIVER CONFIGURADO PARA *}
    {* CADASTRAR CHEQUES A VISTA   *}
    {****************************AF*}
    If (Result) And (fStrToFloat(edtChqRec.Text) <> 0.0) And (fCfgSis('CHQVIS', varBoolean)) And
       ( fEmptyStr( strEspDoc ) Or (Pos(strEspDoc, 'LC_CC_') > 0)) Then
      Result := fChequeVis(edtChqRec.Text);

  End

  Else If (Sender = edtChqPre) Then
  Begin

    If (fEmptyStr(edtChqPre.Text)) Then
      edtChqPre.Text := '0,00';

    If (edtChqPre.Enabled) Then
      Result := fValidaValorMod(fStrToFloat(edtChqPre.Text), fltValDoc);

    {*******************************************}
    {* VALIDAÇÃO CASO USE TIPO DE CLIENTE      *}
    {****************************************MV*}
    If (Result) And (fCfgSis('USATPC', varBoolean)) And (fStrToFloat(edtChqPre.Text) > 0.0) And
      (Not blnLibChp) Then
    Begin
      Result := fValidaFormaPagamento(TPC_CHEQUE_PRE);
      If (Not Result) Then
        fMensagem('ATENÇÃO!', 'Modalidade (CHEQUE PRE) não permitida para esse cliente!', ['&Ok'])
      Else
        blnLibChp := True;
    End;

    {*************************************************}
    {*                                               *}
    {* VERIFICA SE EXISTE ALGUM DOCUMENTO MARCADO    *}
    {* COM ESPÉCIE CH, O QUE SIGNIFICA QUE O MESMO   *}
    {* VEIO DE UMA DEVOLUÇÃO DEFINITIVA OU TRANFERIU *}
    {* O CHEQUE PARA O CTR.                          *}
    {* CASO SEJA ISSO DEVE SER SOLICITADO UMA SENHA  *}
    {* DE LIBERAÇÃO PARA O MESMO                     *}
    {*                                               *}
    {**24/02/2015**REQ:30058***********************AF*}
    If Result And blnVeiodeCH And (fStrToFloat(edtChqPre.Text) <> 0.0) Then
    Begin
      If Not fVeiodeCH Then
      Begin
        Result := False;
        edtChqPre.Text := '0,00';
      End;
    End;

    If Result And (fStrToFloat(edtChqPre.Text) > 0.0) And (Not fPermiteModalidadeParaPortador(fCfgSis('PORRCX'), 'MODCHP')) Then
    Begin
      fMensagem('','O Portador para baixa não tem permissão para esta modalidade!',['&OK']);
      Result := False;
    End;

    If (fStrToFloat(edtChqPre.Text) = 0.0) And blnChqPreLiberado Then
    begin
      pRemoveLiberacao('PRDVCCCHP','002');
      pRemoveLiberacao('CHQPENFIN');
    end;

    If (fStrToFloat(edtChqPre.Text) = 0.0) And blnRecAvencerChqPreLiberado Then
    begin
      pRemoveLiberacao('DIRRCXRECDUPAVCCCH','002');
      pRemoveLiberacao('CHQPENFIN');
    end;


    If (Result) And (fStrToFloat(edtChqPre.Text) > 0.0) And (fVerificaTitulosVencidosSelecionados) And (Not fCfgSis('RECVCD', varBoolean) )
    And ( fEmptyStr(strEspDoc) ) And (Not blnChqPreLiberado) Then
    Begin
       Result := fLiberarRecebChqPre;
       LChqPreVencido :=  Result;
    End;

    If (Result) And (fStrToFloat(edtChqPre.Text) > 0.0) And (fVerificaTitulosAVencerSelecionados) And (Not fCfgSis('PERCCV', varBoolean) )
    And ( fEmptyStr(strEspDoc) ) And (Not blnRecAvencerChqPreLiberado) Then
    Begin
       Result := fLiberarRecebChqPreAVencer;
       LChqPreAVencer :=  Result;
    End;

    If (Result) And (fStrToFloat(edtChqPre.Text) <> 0.0) And
       ( fEmptyStr( strEspDoc ) Or (Pos(strEspDoc, 'LC_CC_') > 0)) Then
    Begin
  	  Result := fChequePre(edtChqPre.Text, LChqPreVencido);
	  	If LChqPreVencido And (Not Result) Then
	    Begin
	      pRemoveLiberacao('PRDVCCCHP','002');
	      pRemoveLiberacao('CHQPENFIN');
	    End;

	  	If LChqPreAVencer And (Not Result) Then
	    Begin
	      pRemoveLiberacao('DIRRCXRECDUPAVCCCH','002');
	      pRemoveLiberacao('CHQPENFIN');
	    End;
	  End;

    blnRecAvencerChqPreLiberado := Result and LChqPreAVencer;
    blnChqPreLiberado := Result and LChqPreVencido;
  End
  Else If (Sender = edtOrdRec) Then
  Begin
    If (fEmptyStr(edtOrdRec.Text)) Then
      edtOrdRec.Text := '0,00';

    If (edtOrdRec.Enabled) Then
      Result := fValidaValorMod(fStrToFloat(edtOrdRec.Text), fltValDoc);

    {*******************************************}
    {* VALIDAÇÃO CASO USE TIPO DE CLIENTE      *}
    {****************************************MV*}
    If (Result) And (fCfgSis('USATPC', varBoolean)) And (fStrToFloat(edtOrdRec.Text) > 0.0) And
      (Not blnLibOrd) Then
    Begin
      Result := fValidaFormaPagamento(TPC_ORDEM_PAGAMENTO);
      If (Not Result) Then
        fMensagem('ATENÇÃO!', 'Modalidade (ORDEM DE PAGAMENTO) não permitida para esse cliente!', ['&Ok'])
      Else
        blnLibOrd := True;
    End;

    If Result And (fStrToFloat(edtOrdRec.Text) > 0.0) And (Not fPermiteModalidadeParaPortador(fCfgSis('PORRCX'), 'MODORD')) Then
    Begin
      fMensagem('','O Portador para baixa não tem permissão para esta modalidade!',['&OK']);
      Result := False;
    End;

    if blnBuscaPorChave And Result And (fStrToFloat(edtOrdRec.Text) > 0.0) Then
    Begin
      strDescri := edtDescri.Text;
      If InputQuery('Recebimento', 'Digite uma Descrição (Opcional)', strDescri ) then
        edtDescri.Text := UpperCase(strDescri);

      If btnReceberPix.Visible Then
      Begin
        If btnReceberPix.Enabled Then
          pSetFocus(edtOrdRec);
      End
      Else If chkPixAvulso.Enabled Then
        pSetFocus(edtOrdRec);
    End;
  End

  Else If (Sender = edtFinanc) Then
  Begin
    If (fEmptyStr(edtFinanc.Text)) Then
      edtFinanc.Text := '0,00';

    If (fStrToFloat(edtFinanc.Text) > 0.0) And (Not fPermiteModalidadeParaPortador(fCfgSis('PORRCX'), 'MODFIN')) Then
    Begin
      fMensagem('','O Portador para baixa não tem permissão para esta modalidade!',['&OK']);
      Result := False;
    End;
  End

  Else If (Sender = edtValJur) Then
  Begin
    If (fEmptyStr(edtValJur.Text)) Then
      edtValJur.Text := '0,00';

    If (Not edtValJur.ReadOnly) Then
      fltValJur := fStrToFloat(edtValJur.Text);

  End
  Else If (Sender = edtValDes) Then
  Begin
    If (fEmptyStr(edtValDes.Text)) Then
      edtValDes.Text := '0,00';

    If (Not edtValDes.ReadOnly) Then
      fltDesRec := fStrToFloat(edtValDes.Text);

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmRcxResumoCaixa.fValidaCtaCtr(strCodCta: String): Boolean;
  Var
    qryCta: TUniQuery;
    strSQL: String;
begin

  qryCta := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT                 ';
  strSQL := strSQL + '   COUNT(*) AS QTD      ';
  strSQL := strSQL + ' FROM                   ';
  strSQL := strSQL + '   CADCTA               ';
  strSQL := strSQL + ' WHERE                  ';
  strSQL := strSQL + '   CTA_CODCTA = :CODCTA ';

  With qryCta Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCTA').AsString := strCodCta;
    Open;

    Result := FieldByName('QTD').AsInteger > 0;
  End;

  FreeAndNil(qryCta);

end;

procedure TfrmRcxResumoCaixa.FormCreate(Sender: TObject);
begin
  inherited;
  strSessaoTef := '';
  objLiberacao  := TLiberacao.Create;
  objLock := TLock.Create;
  edtNumDoc.TamCampo  := fTamDocCadRec;
  edtNumDoc.MaxLength := fTamDocCadRec;

  blnVeiodeCH := False;

  cdsImpRec := fCriaClientDatasetReciboCTR;
  cdsImpRecCG := fCriaClientDatasetReciboCTR;
  blnExecutouOnShow := False;

  btnConfOrcamentos.Visible := True;

  If fUsaRotinaWMS And (fCfgSis('ESPCFO') <> 'PD') Then
    btnConfOrcamentos.Visible := False;

  blnDescFinanSomenteAteVenc := False;

  blnTroChq := (fCfgSis('TROCHQ', varBoolean)); // Troco para cheque;
  blnTroCar := (fCfgSis('TROCAR', varBoolean)); // Troco para Cartão;

  FUtilizaContabilidade := fCfgSis('UTICON', VarBoolean);

  intLckTel := -1;
  intConfirma := -1;

  FAuditoriaResumoCaixa := TAuditoriaGravacaoResumoCaixa.New;

  strEmpSav := VS_strCodEmp;

  fltTotDinSav := 0;
  fltTotGua    := 0;
  fltTotDol    := 0;
  fltTotEur    := 0;
  fltTotPes    := 0;
  fltTotRea    := 0;

  cdsChqVis    := fCriaCdsCheques(Self);
  cdsChqPre    := fCriaCdsCheques(Self);

  blnFecharForm := False;

  objResumoDeCaixa := TResumoDeCaixa.Create();

  If (fEmptyStr(fCfgSis('PORPGR'))) Then
  Begin
    fMensagem('Informação', 'Configurações -> Resumo de Caixa -> Portador para Pagamento (PG).' + #13#10 + 'Favor configurar antes de prosseguir !', ['&O K']);
    blnFecharForm := True;
    Exit;
  End;

  If fCfgSis('SSNECF', varBoolean) And Assigned(VS_objFiscal) Then
  Begin
    If Not fVerificaFormasDePagamentoNoEcf Then
    Begin
      blnFecharForm := True;
      Exit;
    End;
  End;

  If objResumoDeCaixa.TransferenciaOrdemPagamentoAutomatica Then
  Begin
    If fEmptyStr(fCfgSis('PORORD', varString)) Then
    Begin
      fMensagem('ATENÇÃO', 'Deve ser realizadas as seguintes configurações para utilizar o Resumo de Caixa:' + #13#10 +
                           'Configurações -> Resumo de Caixa -> Portadores para transferência de valores - Ordem de Pagamento.',
               ['&OK']);
      blnFecharForm := True;
      Exit;
    End;

    If fEmptyStr(fCfgSis('CTTROP', varString)) Then
    Begin
      fMensagem('ATENÇÃO', 'Deve ser realizadas as seguintes configurações para utilizar o Resumo de Caixa:' + #13#10 +
                           'Configurações -> Resumo de Caixa -> Plano de Contas para transferência de valores - Ordem de Pagamento.',
               ['&OK']);
      blnFecharForm := True;
      Exit;
    End;
  End;

  cdsTmpResumoCaixa := TUniClientDataSet.Create(Self);
  dtsTmpResumoCaixa := TDataSource.Create(Self);
  dtsTmpResumoCaixa.DataSet := cdsTmpResumoCaixa;

  {*******************************************}
  {* ADICIONA OS AGGREGATES DO CLIENT        *}
  {* PS. TO REGASSSANDO O RESUMO DE CAIXAAAA *}
  {****************************************AF*}
  cdsTmpResumoCaixa.AggregatesActive := True;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_VALCOR';
    FieldName     := 'TOT_VALCOR';
    DataSet       := cdsTmpResumoCaixa;
    Expression    := 'SUM(CTR_VALCOR)';
    DisplayFormat := '#,##0.00';
    Active        := True;
  End;

  blnChamaCadastro := True;

  strTipoFechamentoCaixa := objResumoDeCaixa.strTipoFechamento;

  mskDiaAbe.Text          := DateToStr(VS_Date);
  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);

  strEspLancamentos := 'CC_LC_LD_PG_TF_';

  pIniciaValoresPadrao;

  cdsChqPre.EmptyDataSet;

  strCodCliTip := '';
  stlForPag    := TStringList.Create;
  stlForPag.Sorted := True;
  stlForPag.Duplicates := dupIgnore;

  stlCndPag            := TStringList.Create;
  stlCndPag.Sorted     := True;
  stlCndPag.Duplicates := dupIgnore;

  blnRcxRom := fCfgSisL('RCXROM', varBoolean);
  If (blnRcxRom) Then
  Begin
    edtRomaneio.Visible := True;
    lblRomaneio.Visible := True;
    btnRomaneio.Enabled := True;
  End;

  If fCfgSisL('RCXLOJ', varBoolean) Then
    edtCodEmp.Text := VS_strCodEmp
  Else
    edtCodEmp.Text := '';

  btnAutTR.Visible := fCfgSisL('UALCCL', varBoolean);

  edtCodEmpExit(Sender);

  stlContratos := TStringList.Create;
  stlContratos.Sorted := True;
  stlContratos.Duplicates := dupIgnore;
  blnF11 := False;

  btnConfFFSimplificada.Visible := fPermiteEmissaoEspecie('FF');

  If (btnAutTR.Visible) Then
    btnAutTR.Visible := fPermiteEmissaoEspecie('DV') And fPermiteEmissaoEspecie('TR');

  pConfiguraPopup(btnTitRec);

  If fCfgSis('CTRPRO', varBoolean) Then
    objProrrogacao := TProrrogacaoDeTitulos.Create(ttChqPre);

  FDadosPixRecebimento := '';
  FDadosPixRequisicao := '';
  FObjetoPixRecebimento := Nil;
  blnChqPreLiberado := False;
end;

procedure TfrmRcxResumoCaixa.FormDestroy(Sender: TObject);
begin
  Try
    lsvLancamentos.Items.Clear;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmRcxResumoCaixa.FormDestroy]');
  End;

  FreeAndNil(cdsChqVis);
  FreeAndNil(cdsChqPre);
  FreeAndNil(cdsTmpResumoCaixa);
  FreeAndNil(dtsTmpResumoCaixa);
  FreeAndNil(qryConCli);

  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  FreeAndNil(objLock);

  If Assigned(objResumoDeCaixa) Then
    FreeAndNil(objResumoDeCaixa);
  inherited;
end;

function TfrmRcxResumoCaixa.fVerificaAndamentoLancamento: Boolean;
begin
  Result := ValidarSeExistePixRecebidoSemConfirmacao;

  If Result Then
  begin
    pHideHint ;
    Result := fMensagem('', 'Deseja cancelar a gravação desse registro?', ['&Sim', '&Não'], 2) = 1;
  end ;
end;

function TfrmRcxResumoCaixa.fVerificaFormasDePagamentoNoEcf: Boolean;
  Var
    qryAux: TUniQuery;
    strPatIni: String;
    strCodEcf: String;
begin
  strPatIni := fCfgSis('DIRINI');
  strCodEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA'   , '', strPatIni + '/opcoes_fiscal.ini' );

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT');
  qryAux.SQL.Add('  COUNT(*) AS QTD ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  FPGECF ');
  qryAux.SQL.Add('  JOIN CADECF ON CADECF.ECF_CODECF = FPGECF.ECF_CODECF ');
  qryAux.SQL.Add('             AND CADECF.ECF_CODEMP = FPGECF.ECF_CODEMP ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  FPGECF.ECF_CODECF = :CODECF AND ');
  qryAux.SQL.Add('  FPG_CODIGO IN ("001", "007", "006", "002", "012") ');

  qryAux.ParamByName('CODECF').AsString := strCodEcf;
  qryAux.Open;

  Result := True;
  If qryAux.FieldByName('QTD').AsInteger <> 5 Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO', 'É necessário relacionar as formas de pagto. do Autcom com as modalidades do ECF.' + #13#10 +
                         'Formas de pagto. obrigatórias: 001, 002, 006, 007 e 012.', ['&Ok']);
  End;


  FreeAndNil(qryAux);
end;

function TfrmRcxResumoCaixa.fVerificaMeta(dtaMeta: TDateTime; strCodCta,
  strCodEmp, strCodFor: String; fltValLan: Double): Boolean;
  Var
    objMetaCusto: TMetaCentroCustoPedido;
begin
  Result := True;

  If (fCfgSis('METPED') <> '2') and (fCfgSis('METPED') <> '4') And
    (fCfgSis('METPED') <> '5') and (fCfgSis('METPED') <> '6') Then
    Exit;

  If Pos(strCodFor, fRetForFilialTodos) > 0 Then
    Exit;

  TLiberacaoFactory.pSetLiberacao( TLiberacao.Create );
  objMetaCusto := TMetaCentroCustoPedido.Create(Self);
  objMetaCusto.pInicializa;
  objMetaCusto.strCodFor := strCodFor;
  objMetaCusto.strAutIncCTP := fStrZero('0', 20);

  If Not objMetaCusto.fCarregaMetas(dtaMeta,
                                    strCodEmp,
                                    strCodCta,
                                    '',
                                    '01.001',
                                    fltValLan) Then
    Result := objMetaCusto.fPedeSenha;

  FreeAndNil(objMetaCusto);
end;

function TfrmRcxResumoCaixa.fVerificaTefCitelPendente: Boolean;
begin
  Result := Length(arrCartoes) > 0;
end;

function TfrmRcxResumoCaixa.fVerificaTemCreditos: Boolean;
var
  cdsAuxTemp : TUniClientDataSet;
begin
  cdsAuxTemp := TUniClientDataSet.Create(Nil);
  Try
    cdsAuxTemp.Data := cdsTmpResumoCaixa.Data;

    With cdsAuxTemp Do
    Begin
      Filter   := ' CTR_MARDES = ' + QuotedStr('M') + ' AND CTR_VALDUP < 0 ';
      Filtered := True;

      Result := Active And (RecordCount > 0);
    End;
  Finally
    FreeAndNil(cdsAuxTemp);
  End;
end;

procedure TfrmRcxResumoCaixa.pCarregaCliente(strCodCli: String);
begin
  pPesquisaCadCli(qryConCli, qryConCli, strCodCli, True, False, edtCodOpe.Text);
  With qryConCli Do
  Begin
    edtNomCli.Text := FieldByName('CLI_NOMCLI').AsString;
  End;
end;

procedure TfrmRcxResumoCaixa.pCarregaImpostoProporcional(fltValor: Double; Out fltValIpi, fltValRet, fltValAce, fltValFre, fltValCbs, fltValIbs, fltVal_Is: Double);
  Var
    intRec: Integer;
    fltProporcao, fltValDup, fltValRec, fltTotRec, fltTotIpi, fltTotRet, fltTotAce, fltTotFre, fltTotCbs, fltTotIbs, fltTot_Is: Double;
begin
  intRec := 0;

  Try
    fltTotRec := 0;
    fltTotIpi := 0;
    fltTotRet := 0;
    fltTotAce := 0;
    fltTotFre := 0;
    fltTotCbs := 0;
    fltTotIbs := 0;
    fltTot_Is := 0;

    If Not cdsTmpResumoCaixa.Active Then
      Exit;

    intRec := cdsTmpResumoCaixa.RecNo;

    cdsTmpResumoCaixa.First;
    While Not cdsTmpResumoCaixa.Eof Do
    Begin
      If cdsTmpResumoCaixa.FieldByName('CTR_MARDES').AsString <> 'M' Then
      Begin
        cdsTmpResumoCaixa.Next;
        Continue;
      End;

      fltTotRec := fltTotRec + cdsTmpResumoCaixa.FieldByName('CTR_VALREC').AsFloat;

      fltValDup := cdsTmpResumoCaixa.FieldByName('CTR_VALDUP').AsFloat;
      fltValRec := cdsTmpResumoCaixa.FieldByName('CTR_VALREC').AsFloat - cdsTmpResumoCaixa.FieldByName('CTR_VALJUR').AsFloat
                                                                       + cdsTmpResumoCaixa.FieldByName('CTR_VALDES').AsFloat;
      If fltValDup = 0 Then
        fltProporcao := 0
      Else
        fltProporcao := fltValRec / fltValDup;

      fltTotIpi := fltTotIpi + cdsTmpResumoCaixa.FieldByName('CTR_VALIPI').AsFloat * fltProporcao;
      fltTotRet := fltTotRet + cdsTmpResumoCaixa.FieldByName('CTR_VALRET').AsFloat * fltProporcao;
      fltTotAce := fltTotAce + cdsTmpResumoCaixa.FieldByName('CTR_VALACE').AsFloat * fltProporcao;
      fltTotFre := fltTotFre + cdsTmpResumoCaixa.FieldByName('CTR_VALFRE').AsFloat * fltProporcao;
      fltTotCbs := fltTotCbs + cdsTmpResumoCaixa.FieldByName('CTR_VALCBS').AsFloat * fltProporcao;
      fltTotIbs := fltTotIbs + cdsTmpResumoCaixa.FieldByName('CTR_VALIBS').AsFloat * fltProporcao;
      fltTot_Is := fltTot_Is + cdsTmpResumoCaixa.FieldByName('CTR_VAL_IS').AsFloat * fltProporcao;

      cdsTmpResumoCaixa.Next;
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
    If cdsTmpResumoCaixa.Active Then
      cdsTmpResumoCaixa.RecNo := intRec;
  End;
end;

procedure TfrmRcxResumoCaixa.pIniciaValoresPadrao;
begin
  mskDtaIni.Date := VS_Date;
  mskDtaFin.Date := VS_Date;
end;

function TfrmRcxResumoCaixa.fChamaTelaDocumentos(strCodEmp: String;
  strNumDoc: String = ''; strEspDoc: String = ''; blnBuscaContratos: Boolean = False;
  blnDocsAVistaOrigLoja: Boolean = False): Boolean;
  Var
    strDirAcesso: String;
    frmRcxSelDocumentos: TfrmRcxSelDocumentos;

  function fTravaCaixa : Boolean;
    var
      strNomeTrava  : String;
  begin
    Result := False;
    strNomeTrava := 'RCXF7_' + VS_strCodEmp;

    If (fCfgSis('TPFCCX') = 'T') And
       (Not objLock.fLock_Unlock(strNomeTrava, True, False)) Then
    Begin
      pMensagemOk(objLock.fParseMensagemTrava(strNomeTrava,
                                              'O fechamento do caixa da empresa #EMP_CODEMP está sendo '+
                                              'feito pelo operador #LCK_CODOPE - #OPE_NOMOPE e '+
                                              'por isso, o F2 não pode ser utilizado. Entre em '+
                                              'contato com esse operador e depois, tente novamente.'));
      Exit(True);
    End
    Else
      objLock.fLock_Unlock(strNomeTrava, False);
  end;

begin
  strDirAcesso := 'DIRRCXREC';

  If Not fVerificaAcessoSistema(strDirAcesso, edtCodOpe.Text) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Recebimentos (Resumo de Caixa)');

    objLiberacao.strDirAce := strDirAcesso;
    objLiberacao.strSenLib := fCfgSis('RCXREC');
    objLiberacao.strMsgSen := 'Recebimentos';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := edtCodOpe.Text;
    objLiberacao.strCodDig := edtCodOpe.Text;

    If (Not objLiberacao.fLibera) Then
    Begin
      Result := False;
      Exit;
    End;
  End;

  If fTravaCaixa Then
    Exit(False);

  fltValDoc         := 0.0;
  Screen.Cursor     := crHourGlass;
  mskDtaFin.Enabled := False;
  btnBusContrato.Enabled := False;

  Result := True;

  Try
    pZeraVariaveisResumo;

    pCriarFormularios(TfrmRcxSelDocumentos, frmRcxSelDocumentos);

    blnDescFinanSomenteAteVenc := (fCfgSis('UTDEFN') = '2');

    frmRcxSelDocumentos.blnBuscaContratos := blnBuscaContratos;

    frmRcxSelDocumentos.blnDescFinanSomenteAteVenc := blnDescFinanSomenteAteVenc;
    frmRcxSelDocumentos.blnF11    := blnF11;
    frmRcxSelDocumentos.strCodEmp := strCodEmp;
    frmRcxSelDocumentos.strCodOpe := edtCodOpe.Text;
    frmRcxSelDocumentos.blnDuplicatasVista := chkDuplicatasVista.Visible And
                                              chkDuplicatasVista.Checked;
    frmRcxSelDocumentos.ADataCaixa := dtaDtaCai;

    frmRcxSelDocumentos.strCodigoCaixa   := edtCodigoCaixa.Text;
    frmRcxSelDocumentos.objResumoDeCaixa := objResumoDeCaixa;

    If blnDocsAVistaOrigLoja Then
    Begin
      frmRcxSelDocumentos.blnDuplicatasVista := True;
      frmRcxSelDocumentos.dtaDtaIni := VS_Date;
      frmRcxSelDocumentos.dtaDtaFin := VS_Date;
      frmRcxSelDocumentos.strCodEmp := '';
      frmRcxSelDocumentos.strEmpOri := VS_strCodEmp;
    End

    Else If fEmptyStr(strNumDoc) Then
    Begin
      frmRcxSelDocumentos.arrClientesSel := arrClientes;
      frmRcxSelDocumentos.strCodCli := edtCodCli.Text;
      frmRcxSelDocumentos.strNumRom := edtRomaneio.Text;
      frmRcxSelDocumentos.strCodRed := edtCodRed.Text;

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        frmRcxSelDocumentos.dtaDtaIni    := mskDtaIni.Date;

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        frmRcxSelDocumentos.dtaDtaFin    := mskDtaFin.Date;
    End Else
    Begin
      frmRcxSelDocumentos.arrClientesSel := Nil;
      frmRcxSelDocumentos.strCodCli := '';
      frmRcxSelDocumentos.strNumRom := '';
      frmRcxSelDocumentos.dtaDtaIni := 0;
      frmRcxSelDocumentos.dtaDtaFin := 0;

      frmRcxSelDocumentos.edtNumDoc.ReadOnly := TRUE;
      frmRcxSelDocumentos.edtNumDoc.TabStop  := FALSE;
      frmRcxSelDocumentos.edtEspDoc.ReadOnly := TRUE;
      frmRcxSelDocumentos.edtEspDoc.TabStop  := FALSE;

      frmRcxSelDocumentos.edtNumDoc.Text := strNumDoc;
      frmRcxSelDocumentos.edtEspDoc.Text := strEspDoc;
    End;

    frmRcxSelDocumentos.pAtualizaTemporaria(False);

    log('Apagando as temporarias de cheque!');
    If Assigned(cdsChqPre) Then cdsChqPre.EmptyDataSet;
    If Assigned(cdsChqVis) Then cdsChqVis.EmptyDataSet;
    log('Apagou!!! As temporarias de cheque!');

    If Not Assigned(frmRcxSelDocumentos.cdsDadosTemp) Then
    Begin
      Screen.Cursor := crDefault;
      Result        := False;
    End
    Else If (frmRcxSelDocumentos.cdsDadosTemp.IsEmpty) Then
    Begin
      fMensagem('', 'Não encontrei movimento a ser baixado!', ['&Ok']);
      Screen.Cursor := crDefault;
      Result        := False;
    End;

    If (Result) Then
      frmRcxSelDocumentos.ShowModal;

    Result := frmRcxSelDocumentos.blnConfirma;
    If (Result) Then
    Begin
      fltTotRec    := fFormataFloat(frmRcxSelDocumentos.fltTotRec, 2);
      fltValDoc    := fFormataFloat(frmRcxSelDocumentos.fltValDoc, 2);
      fltValJur    := fFormataFloat(frmRcxSelDocumentos.fltValJur, 2);
      fltValCob    := fFormataFloat(frmRcxSelDocumentos.fltDesCob, 2);
      fltDesRec    := fFormataFloat(frmRcxSelDocumentos.fltDesRec, 2);
      fltTotCre    := fFormataFloat(frmRcxSelDocumentos.fltTotCre, 2);
      fltTotLiq    := fFormataFloat(frmRcxSelDocumentos.fltTotLiq, 2);
      intQtdSel    := StrToInt(frmRcxSelDocumentos.edtQtdSel.Text);
      blnEdiCam    := frmRcxSelDocumentos.blnEdiCam;
      strFpgSelPD  := frmRcxSelDocumentos.strFpgSelPD;
      strCodCarSelPD := frmRcxSelDocumentos.strCodCarSelPD;
      intQtdPaCSelPD := frmRcxSelDocumentos.intQtdPaCSelPD;
      blnQuitacao  := frmRcxSelDocumentos.blnQuitacao;
      strMotDes    := Trim(frmRcxSelDocumentos.strMotDes);
      cdsTmpResumoCaixa.Data := frmRcxSelDocumentos.cdsDadosTemp.Data;
      blnVeiodeCH  := frmRcxSelDocumentos.blnVeiodeCH;

    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fChamaTelaDocumentos]');
    End;
  End;

  pFreeAndNil(frmRcxSelDocumentos);

  cdsTmpResumoCaixa.First;
  While (Not cdsTmpResumoCaixa.Eof) Do
  Begin
    If (cdsTmpResumoCaixa.FieldByName('CTR_MARDES').AsString = 'M') Then
    begin
      objLock.fLock_Unlock('CADREC' +
                   cdsTmpResumoCaixa.FieldByName('CTR_NUMDUP').AsString +
                   cdsTmpResumoCaixa.FieldByName('CTR_ESPDOC').AsString +
                   cdsTmpResumoCaixa.FieldByName('CTR_CODEMP').AsString +
                   cdsTmpResumoCaixa.FieldByName('CTR_CODCLI').AsString +
                   cdsTmpResumoCaixa.FieldByName('CTR_PARCEL').AsString,
                   True,
                   False);
    end;
    cdsTmpResumoCaixa.Next;
  end;

  mskDtaFin.Enabled := True;
  btnBusContrato.Enabled := True;

  If (Not Result) Then
  Begin
    log('Não encontrei nenhum documento a ser baixado...');
    If cdsTmpResumoCaixa.Active Then
      cdsTmpResumoCaixa.EmptyDataSet;
    pSetFocus(mskDtaFin);

    If blnF11 Then
    Begin
      blnFecharForm := True;
      Close;
    End;
  End
  Else
  Begin

    If (Not fSenhaSomenteCreditos(fltTotRec, fltTotCre)) Then
    Begin
      log('Sem direitos para devolver dinheiro ao cliente...');
      If cdsTmpResumoCaixa.Active Then
      Begin
        cdsTmpResumoCaixa.EmptyDataSet;
        objLock.pDestravarTodos;
      End;
      pSetFocus(mskDtaFin);
      Result := False;

      If blnF11 Then
      Begin
        blnFecharForm := True;
        Close;
      End;
    End
    Else
    Begin
      log('Encontrei documentos');
      lblVrRestante.Visible := True;
      edtValDoc.Enabled := False;
      edtValDoc.Text    := FloatToStrF(fltValDoc, ffFixed, 12, 2);

      If (fltTotCre < 0.0) Then
      Begin
        edtDinRec.Text := FloatToStrF(fltValDoc, ffFixed, 12, 2);

        If (Abs(fltTotCre) >= Abs(fltTotRec)) Or (Not blnQuitacao) Then
        Begin
          lblCredito.Caption := 'CRÉDITO: R$ ' + FloatToStrF(Abs(fltTotCre),ffNumber,12,2);
          lblCredito.Visible := True;
        End;
      End;
      {*******************************************}
      {* HABILITA / DESABILITA CAMPOS MODALIDADE *}
      {****************************************MV*}
      pEditaCamposModalidades;

      If blnBuscaContratos Then
      Begin
        cdsTmpResumoCaixa.First;

        While (Not cdsTmpResumoCaixa.Eof) Do
        Begin
          If (cdsTmpResumoCaixa.FieldByName('CTR_MARDES').AsString = 'M') Then
            stlContratos.Add(cdsTmpResumoCaixa.FieldByName('CTR_BARCON').AsString);

          cdsTmpResumoCaixa.Next;
        End;

        cdsTmpResumoCaixa.First;
      End
      Else
        stlContratos.Clear;

      {*******************************************}
      {* CASO USE TIPO DE CLIENTE                *}
      {****************************************MV*}
      If (fCfgSis('USATPC', varBoolean)) Then
      Begin

        cdsTmpResumoCaixa.First;
        While (Not cdsTmpResumoCaixa.Eof) Do
        Begin

          If (cdsTmpResumoCaixa.FieldByName('CTR_MARDES').AsString <> 'M') Then
          Begin
            cdsTmpResumoCaixa.Next;
            Continue;
          End;

          strCodCliTip := cdsTmpResumoCaixa.FieldByName('CTR_CODCLI').AsString;
          Break;

        End;
        cdsTmpResumoCaixa.First;
        pCarregaFormasPagto(strCodCliTip, stlForPag, stlCndPag);
      End;
    End;

  End;

end;

procedure TfrmRcxResumoCaixa.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    //arrClientes: TConsultasArray;
    objfrmPnl : TPanelCxClientes;
begin
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fEntraCons(Key) Then
  Begin
    objfrmPnl := TPanelCxClientes.Create(TfrmPnlDadosCliente);
    If fPesqCliente(conCliCompleta, Self, edtCodCli, edtNomCli, nil, Key, arrClientes, False, objfrmPnl, False, '', '', True, edtCodOpe.Text) Then
    Begin
      If fValidaCampos(edtCodCli, True) Then
        SelectNext(ActiveControl, True, True);
    End;
    FreeAndNil(objfrmPnl);
  End;
end;

procedure TfrmRcxResumoCaixa.pChamaClienteCredito;
  Var
    blnConfirma: Boolean;
    frmRcxDigCliente : TfrmRcxDigCliente;
begin

  strCliCco := '';
  Try
    pCriarFormularios(TfrmRcxDigCliente, frmRcxDigCliente);
    frmRcxDigCliente.strCodOpe := edtCodOpe.Text;
    frmRcxDigCliente.ShowModal;

    blnConfirma := frmRcxDigCliente.blnConfirma;
    If (blnConfirma) Then
    Begin
      //Verifica se a criação de CC para Cliente inativo é permitida
      blnConfirma := (fCfgSis('RCXPCC', varBoolean)) Or
                     (frmRcxDigCliente.strStatus = 'A');

      If blnConfirma Then
      Begin
        lsvLancamentos.Enabled := False;
        strCliCco      := frmRcxDigCliente.edtCodCli.Text;
        edtDescri.Text := 'LANC. CRED. REF. A ';

        pHabilitaClienteCC(True);
        edtClienteCC.Text := frmRcxDigCliente.edtCodCli.Text + '-' + frmRcxDigCliente.edtNomCli.Text;

        pSetFocus(edtValDoc);
      End
      Else
        fMensagem('ATENÇÃO', 'Não é permitido gerar Crédito (CC) para clientes inativos!', ['&OK'], 1);

    End;
  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '[pChamaClienteCredito]');
    End;
  End;

  pFreeAndNil(frmRcxDigCliente);

  If (Not blnConfirma) Then
  Begin
    pHabilitaClienteCC(FALSE);
    lsvLancamentos.Enabled := True;
    edtNumDoc.Enabled := True;
    mskDtaIni.Enabled := True;
    mskDtaFin.Enabled := True;
    edtCodCli.Enabled := True;
    strEspDoc := '';
  End;

end;

procedure TfrmRcxResumoCaixa.pCriarClientCreditoGerado(intSeqCon: Integer);
  Var
    strSQL   : String;
    qryPesq: TUniQuery;
    strNomCli : String;
begin

  qryPesq := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + '   SELECT                                   ';

  strSQL := strSQL + '   CTR_OPEBAI,                              ';
  strSQL := strSQL + '   CTR_PORBAI,                              ';
  strSQL := strSQL + '   CTR_HISBAI,                              ';

  strSQL := strSQL + '   CTR_CODCLI,                              ';
  strSQL := strSQL + '   CTR_NUMDUP,                              ';
  strSQL := strSQL + '   CTR_PARCEL,                              ';
  strSQL := strSQL + '   CTR_ESPDOC,                              ';
  strSQL := strSQL + '   CTR_CODEMP,                              ';
  strSQL := strSQL + '   CTR_DTACAD,                              ';
  strSQL := strSQL + '   CTR_DTAVEN,                              ';
  strSQL := strSQL + '   CTR_SEQBAI,                              ';
  strSQL := strSQL + '   CTR_SEQCON,                              ';
  strSQL := strSQL + '   CTR_NOSNUM,                              ';
  strSQL := strSQL + '   CTR_VALORI AS CTR_VALDUP,                ';
  strSQL := strSQL + '   CTR_JURSUJ,                              ';
  strSQL := strSQL + '   CTR_DESCOB,                              ';
  strSQL := strSQL + '   CTR_DESSUJ,                              ';
  strSQL := strSQL + '   CTR_VALORI,                              ';
  strSQL := strSQL + '   CTR_VALJUR,                              ';
  strSQL := strSQL + '   CTR_VALCOB,                              ';
  strSQL := strSQL + '   CTR_VALDES,                              ';
  strSQL := strSQL + '   CTR_VALREC,                              ';
  strSQL := strSQL + '   CTR_CODCTA,                              ';
  strSQL := strSQL + '   CLI_CODCLI,                              ';
  strSQL := strSQL + '   CLI_NOMCLI,                              ';
  strSQL := strSQL + '   CLI_ENDERE,                              ';
  strSQL := strSQL + '   CLI_ENDNUM,                              ';
  strSQL := strSQL + '   CLI_ENDCOM,                              ';
  strSQL := strSQL + '   CLI_BAIRRO,                              ';
  strSQL := strSQL + '   CLI_C_E_P_,                              ';
  strSQL := strSQL + '   CLI_CODCID,                              ';
  strSQL := strSQL + '   CLI_C_G_C_,                              ';
  strSQL := strSQL + '   CLI_FONE01,                              ';
  strSQL := strSQL + '   CTR_VALANT,                              ';
  strSQL := strSQL + '   CTR_HIST01,                              ';
  strSQL := strSQL + '   CTR_HIST02,                              ';
  strSQL := strSQL + '   CLI_FANSOB,                              ';
  strSQL := strSQL + '   CTR_RECPIX,                              ';
  strSQL := strSQL + '   CTR_COBANT,                              ';
  strSQL := strSQL + '   CTR_GRVORI                               ';
  strSQL := strSQL + ' FROM                                       ';
  strSQL := strSQL + '   CADREC                                   ';
  strSQL := strSQL + '   INNER JOIN CADCLI                        ';
  strSQL := strSQL + '     ON CLI_CODCLI = CTR_CODCLI             ';
  strSQL := strSQL + '   LEFT JOIN CADRCXX                        ';
  strSQL := strSQL + '     ON CTR_NUMDUP = RCX_NUMDOC             ';
  strSQL := strSQL + '     AND CTR_CODCLI = RCX_CODCLI            ';
  strSQL := strSQL + '     AND CTR_CODEMP = RCX_CODEMP            ';
  strSQL := strSQL + '     AND CTR_PARCEL = RCX_PARCEL            ';
  strSQL := strSQL + '     AND CTR_ESPDOC = RCX_ESPDOC            ';
  strSQL := strSQL + ' WHERE RCX_SEQCON = ' + IntToStr(intSeqCon);
  strSQL := strSQL + '   AND RCX_CODEMP = ' + QuotedStr(VS_strCodEmp);
  strSQL := strSQL + '   AND RCX_ESPDOC = "CC"  AND CTR_OPEBAI IS NULL';

  cdsImpRecCG := fCriaClientDatasetReciboCTR;

  Try
    qryPesq.Close;
    qryPesq.SQL.Clear;
    qryPesq.SQL.Add(strSQL);
    qryPesq.Open;

    With qryPesq Do
    Begin

      First;
      While Not Eof Do
      Begin
        cdsImpRecCG.Insert;
        cdsImpRecCG.FieldByName('HIST01').AsString   := FieldByName('CTR_HIST01').AsString;
        cdsImpRecCG.FieldByName('HIST02').AsString   := FieldByName('CTR_HIST02').AsString;
        cdsImpRecCG.FieldByName('CODCLI').AsString   := FieldByName('CTR_CODCLI').AsString;
        cdsImpRecCG.FieldByName('DESCRI').AsString   := FieldByName('CTR_CODCLI').AsString + '-' + FieldByName('CLI_NOMCLI').AsString;
        cdsImpRecCG.FieldByName('NUMDOC').AsString   := FieldByName('CTR_NUMDUP').AsString;
        cdsImpRecCG.FieldByName('PARCEL').AsString   := FieldByName('CTR_PARCEL').AsString;
        cdsImpRecCG.FieldByName('ESPDOC').AsString   := FieldByName('CTR_ESPDOC').AsString;
        cdsImpRecCG.FieldByName('CODEMP').AsString   := FieldByName('CTR_CODEMP').AsString;
        cdsImpRecCG.FieldByName('DTACAD').AsDateTime := FieldByName('CTR_DTACAD').AsDateTime;
        cdsImpRecCG.FieldByName('DTAVEN').AsDateTime := FieldByName('CTR_DTAVEN').AsDateTime;
        cdsImpRecCG.FieldByName('DTAREC').AsDateTime := VS_Date;
        cdsImpRecCG.FieldByName('HORREC').AsDateTime := fTime();
        cdsImpRecCG.FieldByName('CODVEN').AsString   := fBuscaVendedorDup(FieldByName('CTR_NUMDUP').AsString,
                                                                        FieldByName('CTR_PARCEL').AsString,
                                                                        FieldByName('CTR_ESPDOC').AsString,
                                                                        FieldByName('CTR_CODCLI').AsString,
                                                                        FieldByName('CTR_CODEMP').AsString);
        cdsImpRecCG.FieldByName('SEQBAI').AsInteger := FieldByName('CTR_SEQBAI').AsInteger;
        cdsImpRecCG.FieldByName('SEQCON').AsInteger := FieldByName('CTR_SEQCON').AsInteger;

        if fEmptyStr(FieldByName('CTR_NOSNUM').AsString) then
          cdsImpRecCG.FieldByName('NOSNUM').AsString  := fTrazNosNumDupZero(FieldByName('CTR_NUMDUP').AsString,
                                                                          FieldByName('CTR_PARCEL').AsString,
                                                                          FieldByName('CTR_ESPDOC').AsString,
                                                                          FieldByName('CTR_CODCLI').AsString,
                                                                          FieldByName('CTR_CODEMP').AsString)
        else
          cdsImpRecCG.FieldByName('NOSNUM').AsString  := FieldByName('CTR_NOSNUM').AsString;

        cdsImpRecCG.FieldByName('VALDOC').AsFloat   := FieldByName('CTR_VALDUP').AsFloat -
                                                     FieldByName('CTR_JURSUJ').AsFloat -
                                                     FieldByName('CTR_DESCOB').AsFloat +
                                                     FieldByName('CTR_DESSUJ').AsFloat;

        cdsImpRecCG.FieldByName('VALORI').AsFloat  := FieldByName('CTR_VALORI').AsFloat;
        cdsImpRecCG.FieldByName('COBANT').AsFloat  := FieldByName('CTR_COBANT').AsFloat;
        cdsImpRecCG.FieldByName('VALOR2').AsFloat  := FieldByName('CTR_GRVORI').AsFloat;

        If (FieldByName('CTR_VALJUR').AsFloat - FieldByName('CTR_VALDES').AsFloat = 0) Then
          cdsImpRecCG.FieldByName('VALJUR').AsFloat  := 0
        else
          cdsImpRecCG.FieldByName('VALJUR').AsFloat  := FieldByName('CTR_VALJUR').AsFloat;


        cdsImpRecCG.FieldByName('VALCOB').AsFloat  := FieldByName('CTR_VALCOB').AsFloat;
        cdsImpRecCG.FieldByName('VALDES').AsFloat  := FieldByName('CTR_VALDES').AsFloat;
        cdsImpRecCG.FieldByName('DESCOB').AsFloat  := FieldByName('CTR_DESCOB').AsFloat;
        cdsImpRecCG.FieldByName('VALREC').AsFloat  := FieldByName('CTR_VALREC').AsFloat;

        strNomCli := fRetNomCliente(FieldByName('CTR_CODCLI').AsString);
        cdsImpRecCG.FieldByName('CODCLI').AsString := FieldByName('CTR_CODCLI').AsString;
        cdsImpRecCG.FieldByName('NOMCLI').AsString := strNomCli;
        cdsImpRecCG.FieldByName('FANSOB').AsString := FieldByName('CLI_FANSOB').AsString;
        cdsImpRecCG.FieldByName('ENDERE').AsString := FieldByName('CLI_ENDERE').AsString;
        cdsImpRecCG.FieldByName('ENDNUM').AsString := FieldByName('CLI_ENDNUM').AsString;
        cdsImpRecCG.FieldByName('ENDCMP').AsString := FieldByName('CLI_ENDCOM').AsString;
        cdsImpRecCG.FieldByName('BAIRRO').AsString := FieldByName('CLI_BAIRRO').AsString;
        cdsImpRecCG.FieldByName('C_E_P_').AsString := FieldByName('CLI_C_E_P_').AsString;
        cdsImpRecCG.FieldByName('CIDADE').AsString := fRetNomCidade(FieldByName('CLI_CODCID').AsString);
        cdsImpRecCG.FieldByName('ESTADO').AsString := fRetUFCliente(FieldByName('CTR_CODCLI').AsString);
        cdsImpRecCG.FieldByName('C_G_C_').AsString := FieldByName('CLI_C_G_C_').AsString;
        cdsImpRecCG.FieldByName('FONE01').AsString := FieldByName('CLI_FONE01').AsString;
        cdsImpRecCG.FieldByName('VALREC').AsFloat := FieldByName('CTR_VALREC').AsFloat;
        cdsImpRecCG.FieldByName('CTR_ABERTO').AsFloat := fRetornaReceberAberto(FieldByName('CTR_CODCLI').AsString);
        cdsImpRecCG.FieldByName('CTR_TOTBLT').AsFloat := fRetornaReceberTotalBoletosEmAberto(FieldByName('CTR_CODCLI').AsString);
        cdsImpRecCG.FieldByName('CTR_TOTCRD').AsFloat := fRetornaReceberTotalCrediarioEmAberto(FieldByName('CTR_CODCLI').AsString);
        cdsImpRecCG.FieldByName('CTR_TOTCHD').AsFloat := fRetornaReceberTotalChequesDevolvidosEmAberto(FieldByName('CTR_CODCLI').AsString);
        cdsImpRecCG.FieldByName('CTR_CARTAO').AsFloat := fStrToFloat(edtCarRec.Text);
        cdsImpRecCG.FieldByName('CTR_CHQPRE').AsFloat := fStrToFloat(edtChqPre.Text);
        cdsImpRecCG.FieldByName('CTR_CHQAVI').AsFloat := fStrToFloat(edtChqRec.Text);
        cdsImpRecCG.FieldByName('CTR_DINHEI').AsFloat := fStrToFloat(edtDinRec.Text);
        cdsImpRecCG.FieldByName('CTR_ORDPAG').AsFloat := fStrToFloat(edtOrdRec.Text);

        If (Pos('CONSUMIDOR', strNomCli) > 0) Or
           (Pos('BALCAO', strNomCli) > 0)     Or
           (Pos('BALCÃO', strNomCli) > 0)     Then
        Begin
          cdsImpRecCG.FieldByName('NOMCLI').AsString := fRetCliConsumidor(FieldByName('CTR_CODCLI').AsString,
                                                                        FieldByName('CTR_NUMDUP').AsString,
                                                                        FieldByName('CTR_ESPDOC').AsString,
                                                                        FieldByName('CTR_CODEMP').AsString);
          cdsImpRecCG.FieldByName('DESCRI').AsString := FieldByName('CTR_CODCLI').AsString + '-' + cdsImpRecCG.FieldByName('NOMCLI').AsString;
        End;
        cdsImpRecCG.FieldByName('NOMCON').AsString := cdsImpRecCG.FieldByName('NOMCLI').AsString;

        cdsImpRecCG.FieldByName('CODCTA').AsString   := FieldByName('CTR_CODCTA').AsString;
        cdsImpRecCG.FieldByName('DESCTA').AsString   := fRetNomeConta( FieldByName('CTR_CODCTA').AsString );

        cdsImpRecCG.FieldByName('TOTCLI').AsFloat  := fRetornaTotalCliente( FieldByName('CTR_CODCLI').AsString, qryPesq.SQL.Text );
        cdsImpRecCG.FieldByName('RECPIX').AsString := FieldByName('CTR_RECPIX').AsString;
        cdsImpRecCG.Post;

        Next;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCriarClientCreditoGerado]');
    End;
  End;

end;

procedure TfrmRcxResumoCaixa.pExecutaTransferencia;
  Const
    DINHEIRO = 0;
    CHEQUE_AVI = 1;
    CHEQUE_PRE = 2;
    CARTAO = 3;
    ORDEM_PAG = 4;
    FINANCIAMENTO = 5;
  Var
    blnConfirma : Boolean;
    fltSalFec   : Double;
    fltDinhei   : Double;
    fltChqAvi   : Double;
    fltChqPre   : Double;
    fltCartao   : Double;
    fltOrdPag   : Double;
    fltValFin   : Double;
    fltDinhe2   : Double;
    fltChqAv2   : Double;
    fltChqPr2   : Double;
    fltCarta2   : Double;
    fltOrdPa2   : Double;
    fltValFi2   : Double;
    strSQL      : String;
    strSeqLan   : String;
    strCodPor   : String;
    strCtaTra   : String;
    strMsgFpg   : String;

    LPixRec,
    LPixRec2: Double;

    intContador : Integer;
    intQtdImp   : Integer;

    strImpressao: String;
    strImpRecibo: String;
    strPorTrans : String;
    strSQL1     : String;
    qryUpd      : TUniQuery;

    strChqAvi   : String;
    strChqPre   : String;
    strCartao   : String;

    strDifVal   : String;

    blnImpTF    : Boolean;
    blnImpChq   : Boolean;
    blnImpCar   : Boolean;
    LOrdenacao  : Integer;

    fltGuaranie: Double;
    fltDolar   : Double;
    fltEuro    : Double;
    fltPeso    : Double;
    fltReal    : Double;

    fltFundoDeCaixa: Double;

    qryLogChq   : TUniQuery;

    LBanTrf: TBanTrfDS;

    LListaBanTrf: TListaBanTrf;

    LTransferenciaLiberada: String;

    LTFPixAvulso: Boolean;

    objTrOpe: TTransfOperador;
    strCodErrosAuditoria: String;

    frmRcxTrasfValores     : TfrmRcxTrasfValores;
    frmRcxTrasfValoresPar  : TfrmRcxTrasfValoresPar;
    frmRcxTransferenciaImpr: TfrmRcxTransferenciaImpr;

    LDataMovimentacaoBancaria: TDateTime;

    LCartoes: TDataset;

    LAutoIncremsCartoes,
    LAutoIncremsChequesAVista,
    LAutoIncremsChequesPre: TStringList;

    LAutoIncremDocumento: String;

    function fPerguntaImpressao: Boolean;
    begin

      blnImpTF   := False;
      blnImpChq  := False;
      blnImpCar  := False;
      LOrdenacao := 0;
      Result     := False;

      Try
        pCriarFormularios(TfrmRcxTransferenciaImpr, frmRcxTransferenciaImpr);
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmRcxResumoCaixa.fPerguntaImpressao]');
        End;
      End;

      If frmRcxTransferenciaImpr.ShowModal = mrOk Then
      Begin
        Result    := True;
        blnImpTF  := frmRcxTransferenciaImpr.chkImpTf.Checked;
        blnImpChq := frmRcxTransferenciaImpr.chkImpChq.Checked;
        blnImpCar := frmRcxTransferenciaImpr.chkImpCar.Checked;
        LOrdenacao := frmRcxTransferenciaImpr.rdgOrdenacao.ItemIndex;
      End;

      pFreeAndNil(frmRcxTransferenciaImpr);
    end;

    function fImpressaoMod(intModalidade: Integer; strCodPor: String; fltValor: Double): String;
    Begin
      Result := '';
      Result := Result + fPadR('PORTADOR: ' + strCodPor + '-' + fRetNomPortador(strCodPor), 39) + #13#10;
      Result := Result +       'VALOR...: ' + fPadL(FloatToStrF(fltValor, ffFixed, 12, 2), 12) + #13#10;

      If intModalidade = CHEQUE_AVI Then
        Result := Result + '<<CHEQUE_AVI>>'
      Else If intModalidade = CHEQUE_PRE Then
        Result := Result + '<<CHEQUE_PRE>>'
      Else If intModalidade = CARTAO Then
        Result := Result + '<<CARTAO>>';
    End;

    function fLancaMovBan(intModalidade: Integer; strCodOpe: String; fltValor: Double): Boolean;
    Begin
      Result := True;

      {***************************************************************}
      {* VALIDO A CONFIGURAÇÃO DO CENTRO DE CUSTO PARA TRANFERÊNCIAS *}
      {*REQ-29572-21/01/2015***************************************JU*}
      If Not fValidaCtaCtr(strCtaTra) Then
      Begin
        fRollBack;
        Case intModalidade Of
          0: strMsgFpg := 'Dinheiro';
          1: strMsgFpg := 'Cheque a vista';
          2: strMsgFpg := 'Cheque pré-datado';
          3: strMsgFpg := 'Cartão';
          4: strMsgFpg := 'Ordem de pagamento';
          5: strMsgFpg := 'Financiamento';
        end;

        fMensagem('', 'A configuração "Plano de Contas para transferência de valores - '+ strMsgFpg + '" não está preenchida corretamente, corrija!', ['&Ok']);
        Result := False;
        Exit;
      End;

      LBanTrf := TBanTrfDS.Create;
      LBanTrf.strCodOpe := edtCodOpe.Text;
      LBanTrf.strCodEmp := VS_strCodEmp;
      LBanTrf.strDescri := strDescri;
      LBanTrf.fltValDoc := fltValor;
      LBanTrf.fltDinRec := IIF(intModalidade = DINHEIRO,      fltValor, 0);
      LBanTrf.fltChqAvi := IIF(intModalidade = CHEQUE_AVI,    fltValor, 0);
      LBanTrf.fltChqPre := IIF(intModalidade = CHEQUE_PRE,    fltValor, 0);
      LBanTrf.fltCarRec := IIF(intModalidade = CARTAO,        fltValor, 0);
      LBanTrf.fltOrdRec := IIF(intModalidade = ORDEM_PAG,     fltValor, 0);
      LBanTrf.fltValFin := IIF(intModalidade = FINANCIAMENTO, fltValor, 0);

      LListaBanTrf := TListaBanTrf.Create;
      LListaBanTrf.Add(LBanTrf);

      {*******************************************}
      {* REALIZA GRAVAÇÃO DO MOVBAN              *}
      {****************************************AF*}
      strSeqLan := fGravaMovBan(strCtaTra,                                         // Centro de Custo
                                strCodPor,                                         // Portador da Baixa
                                strCodOpe,                                         // Operador da Baixa
                                LDataMovimentacaoBancaria,                        // Data do Lançamento
                                fTime(),                                           // Hora do Lançamento
                                '',                                                // Numero do Documento
                                'C',                                               // Credito / Debito
                                VS_strCodEmp,                                      // Empresa da Baixa
                                fltValor,                                          // Valor Do Lançamento
                                strDescri,                                         // Histórico 1
                                '',                                                // Histórico 2
                                '',                                                // Cliente da Duplicata
                                '',                                                // Fornecedor da Duplicata
                                '',                                                // Número da Duplicata
                                0,                                                 // Sequencial de Baixa
                                'A',                                               // Parcela da Duplicata
                                VS_strCodEmp,                                      // Empresa da Duplicata
                                '',                                                // Série
                                '',                                                // Codigo do Evento
                                '',                                                // Documento da Baixa
                                Nil,                                               // Log Bancário
                                intSeqCon,                                         // Sequencial de Transf.
                                0,
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                1,
                                True,
                                LListaBanTrf,
                                '',
                                LTransferenciaLiberada);

      If (fEmptyStr(strSeqLan)) Then
      Begin
        fRollBack;
        blnConfirma := False;
        pMensagensErro('Ocorreu um erro na gravação do MOVBAN!!!','Resumo de caixa - [gravaçao do movban]');
        Result := False;
        Exit;
      End;

      untLogCba.GravaLogCba(fCampoTabela('AUTOINCREM', 'MOVBAN', ['CTB_SEQLAN'], [strSeqLan]),
                            'INCLUSÃO - TRANSFERÊNCIA',
                            Self.Name,
                            '',
                            Nil,
                            edtCodOpe.Text);

      FreeAndNil(LBanTrf);
      FreeAndNil(LListaBanTrf);
    End;

begin

  If (strEspDoc <> 'TF') Then
    Exit;

  blnFecham := False;
  intSeqCon := StrToInt(fRetRcxCon);
  strChqAvi := '';
  strChqPre := '';
  strCartao := '';
  strDifVal := '';

  LTransferenciaLiberada := 'S';
  If fCfgSis('USAAUT', varBoolean) Then
  Begin
    If objResumoDeCaixa.TransferenciaVinculada Then
      LTransferenciaLiberada := 'N';
  End;

  objResumoDeCaixa.AtualizaTipoDeDataDeTransferencia;
  LDataMovimentacaoBancaria := VS_Date;
  If objResumoDeCaixa.TipoDataTFCaixa = tdtfDataMovimentoCaixa Then
    LDataMovimentacaoBancaria := dtaDtaCai;

  btnGravar.Enabled := False;

  If Not TodosOsPlanosDeContasTransferenciaCadastrados Then
  Begin
    fMensagem('','Configure TODOS os plano de contas para transferência de valores!',['&OK']);
    Exit;
  End;

  fltSalFec := 0.0;

  LAutoIncremsCartoes := TStringList.Create;
  LAutoIncremsChequesAVista := TStringList.Create;
  LAutoIncremsChequesPre := TStringList.Create;
  qryUpd := Nil;
  qryLogChq := Nil;
  Try
    Try
      LTFPixAvulso := False;

      If (FPais = opcParaguai) Then
      Begin
        pCriarFormularios(TfrmRcxTrasfValoresPar, frmRcxTrasfValoresPar);

        If (Concat(objResumoDeCaixa.strTipoFechamento, objResumoDeCaixa.TipoSaldoCaixa).Equals('CO')) Or
           (objResumoDeCaixa.OperadorTransferenciaDeveSerLogadoCaixa) Then
          frmRcxTrasfValoresPar.edtCodVendedor.Text := edtCodOpe.Text;

        frmRcxTrasfValoresPar.ShowModal;

        lblFinanc.Visible := True;
        edtFinanc.Visible := True;
        edtFinanc.Text    := '0,00';

        chkPixAvulso.Visible := False;
        chkPixAvulso.Checked := False;

        blnConfirma := (frmRcxTrasfValoresPar.ModalResult = mrOK);

        If blnConfirma Then
          blnConfirma := fPerguntaImpressao;
      End
      Else
      Begin
        pCriarFormularios(TfrmRcxTrasfValores, frmRcxTrasfValores);

        If (Concat(objResumoDeCaixa.strTipoFechamento, objResumoDeCaixa.TipoSaldoCaixa).Equals('CO')) Or
           (objResumoDeCaixa.OperadorTransferenciaDeveSerLogadoCaixa) Or
           (objResumoDeCaixa.TransferenciaCega) Then
          frmRcxTrasfValores.edtCodVendedor.Text := edtCodOpe.Text;

        frmRcxTrasfValores.strCodOpe        := edtCodOpe.Text;
        frmRcxTrasfValores.strCodigoCaixa   := edtCodigoCaixa.Text;
        frmRcxTrasfValores.objResumoDeCaixa := objResumoDeCaixa;

        frmRcxTrasfValores.ShowModal;

        lblFinanc.Visible := True;
        edtFinanc.Visible := True;
        edtFinanc.Text    := '0,00';
        fltSalFec         := 0.00;

        chkPixAvulso.Visible := False;
        chkPixAvulso.Checked := False;

        blnConfirma := (frmRcxTrasfValores.ModalResult = mrOK);

        LTFPixAvulso := frmRcxTrasfValores.TransferenciaPixAvulso;

        LAutoIncremsCartoes.AddStrings(frmRcxTrasfValores.AutoIncremsCartoes);
        LAutoIncremsChequesAVista.AddStrings(frmRcxTrasfValores.AutoIncremsChequesAVista);
        LAutoIncremsChequesPre.AddStrings(frmRcxTrasfValores.AutoIncremsChequesPre);

        If blnConfirma Then
          blnConfirma := fPerguntaImpressao;
      End;

      If (blnConfirma) And (FPais <> opcParaguai) Then
      Begin
        {*************************************************}
        {* DEVE SER CHAMADO ANTES DA TRANSACAO PRINCIPAL *}
        {*********************************************JC**}
        intSeqCon := StrToInt(fRetRcxCon);
        pSeparaOperadores(frmRcxTrasfValores,
                          LTFPixAvulso);

        fltOrdPag := frmRcxTrasfValores.fltOrdPag;
        fltOrdPa2 := frmRcxTrasfValores.fltOrdPa2;

        If Not ValidaSaldoOrdemPagamentoPix(LTFPixAvulso,
                                            fltOrdPag + fltOrdPa2) Then
        Begin
          FreeAndNil(frmRcxTrasfValores);
          Exit;
        End;

        fStartTransaction;

        lsvLancamentos.Enabled := False;
        fltDinhei := frmRcxTrasfValores.fltDinhei;
        fltChqAvi := frmRcxTrasfValores.fltChqVis;
        fltChqPre := frmRcxTrasfValores.fltChqPre;
        fltCartao := frmRcxTrasfValores.fltCartao;
        fltOrdPag := frmRcxTrasfValores.fltOrdPag;
        fltValFin := frmRcxTrasfValores.fltValFin;

        fltDinhe2 := frmRcxTrasfValores.fltDinhe2;
        fltChqAv2 := frmRcxTrasfValores.fltChqVi2;
        fltChqPr2 := frmRcxTrasfValores.fltChqPr2;
        fltCarta2 := frmRcxTrasfValores.fltCarta2;
        fltOrdPa2 := frmRcxTrasfValores.fltOrdPa2;
        fltValFi2 := frmRcxTrasfValores.fltValFi2;

        fltValDoc := frmRcxTrasfValores.fltValDig + frmRcxTrasfValores.fltValDi2;
        blnFecham := frmRcxTrasfValores.chkFechamento.Checked;

        fltFundoDeCaixa := fFormataFloat(fStrToFloat(frmRcxTrasfValores.edtFundoDeCaixaAtualizado.Text), 2);
        If (Not objResumoDeCaixa.TransferenciaCega) And
           (fltDinhei + fltDinhe2 > 0) Then
        Begin
          If objResumoDeCaixa.strTipoFechamento.Equals('C') Then
          Begin
            fltFundoDeCaixa := objResumoDeCaixa.fRetornaSaldoCaixaCampo('RCX_DINREC',
                                                                        edtCodigoCaixa.Text);

            fltFundoDeCaixa := fltFundoDeCaixa - (fltDinhei + fltDinhe2);
          End;
        End;

        strImpressao := '';
        strImpRecibo := '';
        strDescri    := '';
        strPorTrans  := '';

        If fltDinhei > 0 Then
        Begin
          strImpressao := strImpressao + 'TRANSF. DE CAIXA ( DINHEIRO )' + #13#10;
          strImpressao := strImpressao + fImpressaoMod(DINHEIRO, frmRcxTrasfValores.edtCodPorDin.Text, fltDinhei);
        End;

        If fltChqAvi > 0 Then
        Begin
          strImpressao := strImpressao + 'TRANSF. DE CAIXA ( CHEQUE A VISTA )' + #13#10;
          strImpressao := strImpressao + fImpressaoMod(CHEQUE_AVI, frmRcxTrasfValores.edtCodPorChv.Text, fltChqAvi);
        End;

        If fltChqPre > 0 Then
        Begin
          strImpressao := strImpressao + 'TRANSF. DE CAIXA ( CHEQUE PRE )' + #13#10;
          strImpressao := strImpressao + fImpressaoMod(CHEQUE_PRE, frmRcxTrasfValores.edtCodPorChp.Text, fltChqPre);
        End;

        If fltCartao > 0 Then
        Begin
          strImpressao := strImpressao + 'TRANSF. DE CAIXA ( CARTAO )' + #13#10;
          strImpressao := strImpressao + fImpressaoMod(CARTAO, frmRcxTrasfValores.edtCodPorCrt.Text, fltCartao);
        End;

        If fltOrdPag > 0 Then
        Begin
          strImpressao := strImpressao + 'TRANSF. DE CAIXA ( ORDEM DE PAGAMENTO )' + #13#10;
          strImpressao := strImpressao + fImpressaoMod(ORDEM_PAG, frmRcxTrasfValores.edtCodPorOrd.Text, fltOrdPag);
        End;

        If fltValFin > 0 Then
        Begin
          strImpressao := strImpressao + 'TRANSF. DE CAIXA ( FINANCIAMENTO )' + #13#10;
          strImpressao := strImpressao + fImpressaoMod(FINANCIAMENTO, frmRcxTrasfValores.edtCodPorFin.Text, fltValFin);
        End;

        For objTrOpe in oblTransfOperadores Do
        Begin
          If objTrOpe.fltDinheiro > 0 Then
          Begin
            strDescri := fGetDescricaoTransferencia('DIN') + frmRcxTrasfValores.edtCodPorDin.Text + '-' + frmRcxTrasfValores.edtDesPortadorDin.Text;
            strCodPor := frmRcxTrasfValores.edtCodPorDin.Text;
            strCtaTra := fConverteCentroCusto(fCfgSisL('CTATRA'));
            objTrOpe.strPorTrans := objTrOpe.strPorTrans + strCodPor + '/';

            If blnFecham Then
              strDescri := 'TF FECHAMENTO DE CAIXA ' + IIF(fEmptyStr(edtCodigoCaixa.Text), EmptyStr, edtCodigoCaixa.Text + ' ') + '- DIN';

            If Not fLancaMovBan(DINHEIRO, fCodOpeTransf(frmRcxTrasfValores), objTrOpe.fltDinheiro) Then
              Exit;
          End;

          If objTrOpe.fltChqAVista > 0 Then
          Begin
            strDescri := fGetDescricaoTransferencia('CHV') + frmRcxTrasfValores.edtCodPorChv.Text + '-' + frmRcxTrasfValores.edtDesPortadorChv.Text;
            strCodPor := frmRcxTrasfValores.edtCodPorChv.Text;
            strCtaTra := fConverteCentroCusto(fCfgSisL('CTTRCV'));
            objTrOpe.strPorTrans := objTrOpe.strPorTrans + strCodPor + '/';
            If Not fLancaMovBan(CHEQUE_AVI, objTrOpe.strOperador, objTrOpe.fltChqAVista) Then
              Exit;
          End;

          If objTrOpe.fltChqAPrazo > 0 Then
          Begin
            strDescri := fGetDescricaoTransferencia('CHP') + frmRcxTrasfValores.edtCodPorChp.Text + '-' + frmRcxTrasfValores.edtDesPortadorChp.Text;
            strCodPor := frmRcxTrasfValores.edtCodPorChp.Text;
            strCtaTra := fConverteCentroCusto(fCfgSisL('CTTRCP'));
            objTrOpe.strPorTrans := objTrOpe.strPorTrans + strCodPor + '/';
            If Not fLancaMovBan(CHEQUE_PRE, objTrOpe.strOperador, objTrOpe.fltChqAPrazo) Then
              Exit;
          End;

          If objTrOpe.fltCartao > 0 Then
          Begin
            strDescri := fGetDescricaoTransferencia('CAR') + frmRcxTrasfValores.edtCodPorCrt.Text + '-' + frmRcxTrasfValores.edtDesPortadorCrt.Text;
            strCodPor := frmRcxTrasfValores.edtCodPorCrt.Text;
            strCtaTra := fConverteCentroCusto(fCfgSisL('CTTRCR'));
            objTrOpe.strPorTrans := objTrOpe.strPorTrans + strCodPor + '/';
            If Not fLancaMovBan(CARTAO, objTrOpe.strOperador, objTrOpe.fltCartao) Then
              Exit;
          End;

          If objTrOpe.fltOrdPag > 0 Then
          Begin
            strDescri := fGetDescricaoTransferencia('OP') + frmRcxTrasfValores.edtCodPorOrd.Text + '-' + frmRcxTrasfValores.edtDesPortadorOrd.Text;
            strCodPor := frmRcxTrasfValores.edtCodPorOrd.Text;
            strCtaTra := fConverteCentroCusto(fCfgSisL('CTTROP'));
            objTrOpe.strPorTrans := objTrOpe.strPorTrans + strCodPor + '/';
            If Not fLancaMovBan(ORDEM_PAG, fCodOpeTransf(frmRcxTrasfValores), objTrOpe.fltOrdPag) Then
              Exit;
          End;

          If objTrOpe.PixRec > 0 Then
          Begin
            strDescri := 'TF CAIXA (OP-PIX) - ' + frmRcxTrasfValores.edtCodPorOrd.Text + '-' + frmRcxTrasfValores.edtDesPortadorOrd.Text;
            strCodPor := frmRcxTrasfValores.edtCodPorOrd.Text;
            strCtaTra := fConverteCentroCusto(fCfgSisL('CTTROP'));

            If objTrOpe.fltOrdPag = 0 Then
              objTrOpe.strPorTrans := objTrOpe.strPorTrans + strCodPor + '/';

            If Not fLancaMovBan(ORDEM_PAG, fCodOpeTransf(frmRcxTrasfValores), objTrOpe.PixRec) Then
              Exit;
          End;

          If objTrOpe.fltFinanc > 0 Then
          Begin
            strDescri := fGetDescricaoTransferencia('FIN') + frmRcxTrasfValores.edtCodPorFin.Text + '-' + frmRcxTrasfValores.edtDesPortadorFin.Text;
            strCodPor := frmRcxTrasfValores.edtCodPorFin.Text;
            strCtaTra := fConverteCentroCusto(fCfgSisL('CTTRFI'));
            objTrOpe.strPorTrans := objTrOpe.strPorTrans + strCodPor + '/';
            If Not fLancaMovBan(FINANCIAMENTO, fCodOpeTransf(frmRcxTrasfValores), objTrOpe.fltFinanc) Then
              Exit;
          End;
        End;

        {*******************************************}
        {* GRAVA O CAIXA 2                         *}
        {****************************************AF*}
        For intContador := 0 To 5 Do
        Begin

          If intContador = 0 Then
          Begin
            fltSalFec := fltDinhe2;
            strSQL    := 'TRANSF. DE CAIXA ( DINHEIRO )';
            strDescri := fGetDescricaoTransferencia('DIN') + frmRcxTrasfValores.edtCodPorDin.Text + '-' + frmRcxTrasfValores.edtDesPortadorDin.Text;
            strCodPor := frmRcxTrasfValores.edtCodPorDin.Text;
            strCtaTra := fConverteCentroCusto(fCfgSisL('CTATRA'));
          End

          Else If intContador = CHEQUE_AVI Then
          Begin
            fltSalFec := fltChqAv2;
            strSQL    := 'TRANSF. DE CAIXA ( CHEQUE A VISTA )';
            strDescri := fGetDescricaoTransferencia('CHV') + frmRcxTrasfValores.edtCodPorChv.Text + '-' + frmRcxTrasfValores.edtDesPortadorChv.Text;
            strCodPor := frmRcxTrasfValores.edtCodPorChv.Text;
            strCtaTra := fConverteCentroCusto(fCfgSisL('CTTRCV'));
          End

          Else If intContador = CHEQUE_PRE Then
          Begin
            fltSalFec := fltChqPr2;
            strSQL    := 'TRANSF. DE CAIXA ( CHEQUE PRE )';
            strDescri := fGetDescricaoTransferencia('CHP') + frmRcxTrasfValores.edtCodPorChp.Text + '-' + frmRcxTrasfValores.edtDesPortadorChp.Text;
            strCodPor := frmRcxTrasfValores.edtCodPorChp.Text;
            strCtaTra := fConverteCentroCusto(fCfgSisL('CTTRCP'));
          End

          Else If intContador = CARTAO Then
          Begin
            fltSalFec := fltCarta2;
            strSQL    := 'TRANSF. DE CAIXA ( CARTAO )';
            strDescri := fGetDescricaoTransferencia('CAR') + frmRcxTrasfValores.edtCodPorCrt.Text + '-' + frmRcxTrasfValores.edtDesPortadorCrt.Text;
            strCodPor := frmRcxTrasfValores.edtCodPorCrt.Text;
            strCtaTra := fConverteCentroCusto(fCfgSisL('CTTRCR'));
          End

          Else If intContador = 4 Then
          Begin
            fltSalFec := fltOrdPa2;
            strSQL    := 'TRANSF. DE CAIXA ( ORDEM DE PAGAMENTO )';
            strDescri := fGetDescricaoTransferencia('OP')+ frmRcxTrasfValores.edtCodPorOrd.Text + '-' + frmRcxTrasfValores.edtDesPortadorOrd.Text;
            strCodPor := frmRcxTrasfValores.edtCodPorOrd.Text;
            strCtaTra := fConverteCentroCusto(fCfgSisL('CTTROP'));
          End

          Else If intContador = FINANCIAMENTO Then
          Begin
            fltSalFec := fltValFi2;
            strSQL    := 'TRANSF. DE CAIXA ( FINANCIAMENTO )';
            strDescri := fGetDescricaoTransferencia('FIN') + frmRcxTrasfValores.edtCodPorFin.Text + '-' + frmRcxTrasfValores.edtDesPortadorFin.Text;
            strCodPor := frmRcxTrasfValores.edtCodPorFin.Text;
            strCtaTra := fConverteCentroCusto(fCfgSisL('CTTRFI'));
          End;

          If fltSalFec > 0 Then
          Begin
            strPorTrans := strPorTrans + strCodPor + '/';

            strImpressao := strImpressao + strSQL + #13#10;
            strImpressao := strImpressao + fPadR('PORTADOR: ' + strCodPor + '-' + fRetNomPortador(strCodPor),39) + #13#10;
            strImpressao := strImpressao +       'VALOR...: ' + fPadL(FloatToStrF(fltSalFec,ffFixed,12,2),12) + #13#10 + #13#10;

            {***************************************************************}
            {* VALIDO A CONFIGURAÇÃO DO CENTRO DE CUSTO PARA TRANFERÊNCIAS *}
            {*REQ-29572-21/01/2015***************************************JU*}
            If Not fValidaCtaCtr(strCtaTra) Then
            Begin
              fRollBack;
              Case intContador Of
                0: strMsgFpg := 'Dinheiro';
                1: strMsgFpg := 'Cheque a vista';
                2: strMsgFpg := 'Cheque pré-datado';
                3: strMsgFpg := 'Cartão';
                4: strMsgFpg := 'Ordem de pagamento';
                5: strMsgFpg := 'Financiamento';
              end;

              fMensagem('', 'A configuração "Plano de Contas para transferência de valores - '+ strMsgFpg + '" não está preenchida corretamente, corrija!', ['&Ok']);
              Exit;
            End;

            LBanTrf := TBanTrfDS.Create;
            LBanTrf.strCodOpe := edtCodOpe.Text;
            LBanTrf.strCodEmp := VS_strCodEmp;
            LBanTrf.strDescri := strDescri;
            LBanTrf.fltValDoc := fltSalFec;
            LBanTrf.fltDinRec := IIF(intContador = 0, fltSalFec, 0);
            LBanTrf.fltChqAvi := IIF(intContador = CHEQUE_AVI, fltSalFec, 0);
            LBanTrf.fltChqPre := IIF(intContador = CHEQUE_PRE, fltSalFec, 0);
            LBanTrf.fltCarRec := IIF(intContador = CARTAO, fltSalFec, 0);
            LBanTrf.fltOrdRec := IIF(intContador = 4, fltSalFec, 0);
            LBanTrf.fltValFin := IIF(intContador = FINANCIAMENTO, fltSalFec, 0);

            LListaBanTrf := TListaBanTrf.Create;
            LListaBanTrf.Add(LBanTrf);

            Try
              {*******************************************}
              {* REALIZA GRAVAÇÃO DO MOVBAN              *}
              {****************************************AF*}
              strSeqLan := fGravaMovBan(strCtaTra,                                         // Centro de Custo
                                        strCodPor,                                         // Portador da Baixa
                                        fCodOpeTransf(frmRcxTrasfValores),                 // Operador da Baixa
                                        LDataMovimentacaoBancaria,                         // Data do Lançamento
                                        fTime(),                                           // Hora do Lançamento
                                        '',                                                // Numero do Documento
                                        'C',                                               // Credito / Debito
                                        VS_strCodEmp,                                      // Empresa da Baixa
                                        fltSalFec,                                         // Valor Do Lançamento
                                        strDescri,                                         // Histórico 1
                                        '',                                                // Histórico 2
                                        '',                                                // Cliente da Duplicata
                                        '',                                                // Fornecedor da Duplicata
                                        '',                                                // Número da Duplicata
                                        0,                                                 // Sequencial de Baixa
                                        'A',                                               // Parcela da Duplicata
                                        VS_strCodEmp,                                      // Empresa da Duplicata
                                        '',                                                // Série
                                        //'',                                              // Sequencial de Lançamento
                                        '',                                                //
                                        '',                                                // Documento da Baixa
                                        Nil,                                // Log Bancário
                                        intSeqCon,
                                        0,
                                        '',
                                        '',
                                        '',
                                        '',
                                        '',
                                        '',
                                        1,
                                        True,
                                        LListaBanTrf);

              If (fEmptyStr(strSeqLan)) Then
              Begin
                fRollBack;
                blnConfirma := False;
                Raise Exception.Create('Ocorreu um erro na gravação do MOVBAN!!!' + #13 +
                                       'Resumo de caixa - [gravação do movban]');
              End;
            Finally
              FreeAndNil(LBanTrf);
              FreeAndNil(LListaBanTrf);
            End;
          End;

        End;

        If Not blnConfirma Then
        Begin
          fRollBack;
          Exit;
        End;

        If RightStr(strPorTrans, 1) = '/' Then
          strPorTrans := Copy(strPorTrans, 1, Length(strPorTrans)-1);

        For objTrOpe in oblTransfOperadores Do
        Begin
          edtDinRec.Text := FloatToStrF(objTrOpe.fltDinheiro  + objTrOpe.fltDinheiro2,  ffFixed, 12, 2);
          edtChqRec.Text := FloatToStrF(objTrOpe.fltChqAVista + objTrOpe.fltChqAVista2, ffFixed, 12, 2);
          edtChqPre.Text := FloatToStrF(objTrOpe.fltChqAPrazo + objTrOpe.fltChqAPrazo2, ffFixed, 12, 2);
          edtCarRec.Text := FloatToStrF(objTrOpe.fltCartao    + objTrOpe.fltCartao2,    ffFixed, 12, 2);
          edtOrdRec.Text := FloatToStrF(objTrOpe.fltOrdPag    + objTrOpe.fltOrdPag2,    ffFixed, 12, 2);

          chkPixAvulso.Checked := False;

          If LTFPixAvulso Then
          Begin
            edtOrdRec.Text := FloatToStrF(objTrOpe.PixRec + objTrOpe.PixRec2,    ffFixed, 12, 2);
            chkPixAvulso.Checked := fFormataFloat(objTrOpe.PixRec + objTrOpe.PixRec2, 2) <> 0;
          End;

          edtFinanc.Text := FloatToStrF(objTrOpe.fltFinanc    + objTrOpe.FFinanc2,      ffFixed, 12, 2);

          edtValDoc.Text := FloatToStrF(fStrToFloat(edtDinRec.Text) +
                                        fStrToFloat(edtOrdRec.Text) +
                                        fStrToFloat(edtFinanc.Text) +
                                        fStrToFloat(edtCarRec.Text) +
                                        fStrToFloat(edtChqRec.Text) +
                                        fStrToFloat(edtChqPre.Text),
                                        ffFixed, 12, 2);

          fltValDoc := fStrToFloat(edtValDoc.Text);

          strDescri      := 'REF. TRANSF. CX./PORT: ' + objTrOpe.strPorTrans;

          If blnFecham Then
          Begin
            If edtDinRec.Text <> '0,00' Then
              strDescri := 'TF FECHAMENTO DE CAIXA ' + IIF(fEmptyStr(edtCodigoCaixa.Text), EmptyStr, edtCodigoCaixa.Text + ' ') + '- DIN';
          End;

          If (strEspDoc <> 'TF') Then
          Begin
            blnConfirma := False;
            fRollback;
            fMensagem('', 'Espécie do documento não é de transferência. Operação cancelada.', ['&Ok']);
            Exit;
          End;

          If Not fGravaResCai(RCX_GRAVA_NORMAL, '', Nil, objTrOpe.strOperador, fltFundoDeCaixa) Then
            blnConfirma := False;
        End;

        If blnConfirma Then
        Begin
          If objResumoDeCaixa.strTipoFechamento = 'C' Then
            objResumoDeCaixa.EnviaMensagemLiberacaoUsuariosTransferencia(intSeqCon.ToString,
                                                                         VS_strCodEmp,
                                                                         edtCodigoCaixa.Text,
                                                                         dtaDtaCai);

          pImprimirSangria(fltDinhei, fltCartao, fltChqAvi, fltChqPre, fltOrdPag);

          strImpRecibo := strImpressao;

          {**************************************************************}
          {* CASO SEJA TRANSFERENCIA NÃO LIBERADA - COM DOCS VINCULADOS *}
          {***********************************************************LU*}
          If objResumoDeCaixa.TransferenciaVinculada Then
          Begin

            Try
              qryUpd := fCriaQuery;

              {**************************************************************}
              {* CHEQUE A VISTA - ATUALIZA TABELA CADCHQ (CHQ_DTATRA)       *}
              {***********************************************************LU*}
              If (LAutoIncremsChequesAVista.Count > 0) And (fltChqAvi <> 0) Then
              Begin

                strChqAvi := strChqAvi + fReplicatorStr('-', 39) + #13#10 +
                                         fPadR('BCO', 3) + ' | ' +
                                         fPadR('AGE.', 5) + ' | ' +
                                         fPadR('CONTA', 12) + ' | ' +
                                         fPadR('Nro. CHQ.', 10) + #13#10 +
                                         fPadR('VENC.', 10) + ' | ' +
                                         fPadR('CLIENTE', 8)+ ' | ' +
                                         fPadL('VALOR', 10) + #13#10 +
                                         fReplicatorStr('-', 39) + #13#10;

                For LAutoIncremDocumento In LAutoIncremsChequesAVista Do
                Begin
                  frmRcxTrasfValores.cdsChqAVi.Locate('AUTOINCREM', LAutoIncremDocumento, []);

                  If Not fDocumentoExiste('CADCHQ', LAutoIncremDocumento) Then
                  Begin
                    fRollBack;
                    blnConfirma := False;
                    fMensagem('', 'O cheque ' +
                                  'Bn: ' + frmRcxTrasfValores.cdsChqAVi.FieldByName('BANCO').AsString + ' / ' +
                                  'Ag: ' + frmRcxTrasfValores.cdsChqAVi.FieldByName('AGENCIA').AsString + ' / ' +
                                  'Cc: ' + frmRcxTrasfValores.cdsChqAVi.FieldByName('CONTA').AsString + ' / ' +
                                  'Nm: ' + frmRcxTrasfValores.cdsChqAVi.FieldByName('NUMERO').AsString + ' / ' +
                                  'Vl: ' + FloatToStrF(frmRcxTrasfValores.cdsChqAVi.FieldByName('VALOR').AsFloat, ffNumber, 12, 2) +
                                  ' não existe mais no módulo de cheques.' + #13#10 + 'Operação cancelada.',
                                  ['&Ok']);
                    Exit;
                  End;

                  strChqAvi := strChqAvi + fPadR(frmRcxTrasfValores.cdsChqAVi.FieldByName('BANCO').AsString, 3) + ' | ' +
                                           fPadR(frmRcxTrasfValores.cdsChqAVi.FieldByName('AGENCIA').AsString, 5) + ' | ' +
                                           fPadR(frmRcxTrasfValores.cdsChqAVi.FieldByName('CONTA').AsString, 12) + ' | ' +
                                           fPadR(frmRcxTrasfValores.cdsChqAVi.FieldByName('NUMERO').AsString, 10) + #13#10 +
                                           fPadR(frmRcxTrasfValores.cdsChqAVi.FieldByName('DTAVEN').AsString, 10) + ' | ' +
                                           fPadR(frmRcxTrasfValores.cdsChqAVi.FieldByName('CODCLI').AsString, 8)+ ' | ' +
                                           fPadL(FloatToStrF(frmRcxTrasfValores.cdsChqAVi.FieldByName('VALOR').AsFloat, ffNumber, 12, 2), 10) + #13#10;

                  strSQL1 := '';
                  strSQL1 := strSQL1 + ' UPDATE ';
                  strSQL1 := strSQL1 + '   CADCHQ ';
                  strSQL1 := strSQL1 + ' SET ';
                  strSQL1 := strSQL1 + '   CHQ_DTATRA = :DTATRA, ';
                  strSQL1 := strSQL1 + '   CHQ_SEQTRF = :SEQTRF, ';
                  strSQL1 := strSQL1 + '   CHQ_PORCHQ = :PORCHQ, ';
                  strSQL1 := strSQL1 + '   CHQ_CTACHQ = :CTACHQ, ';
                  strSQL1 := strSQL1 + '   CHQ_TRFLIB = :TRFLIB ';
                  strSQL1 := strSQL1 + ' WHERE ';
                  strSQL1 := strSQL1 + '   AUTOINCREM = :AUTINC ';

                  qryUpd.Close;
                  qryUpd.SQL.Text := strSQL1;
                  qryUpd.ParamByName('DTATRA').AsDateTime := LDataMovimentacaoBancaria;
                  qryUpd.ParamByName('SEQTRF').AsInteger  := intSeqCon;
                  qryUpd.ParamByName('PORCHQ').AsString   := frmRcxTrasfValores.edtCodPorChv.Text;
                  qryUpd.ParamByName('CTACHQ').AsString   := fConverteCentroCusto(fCfgSisL('CTTRCV'));
                  qryUpd.ParamByName('TRFLIB').AsString   := LTransferenciaLiberada;

                  qryUpd.ParamByName('AUTINC').AsString   := LAutoIncremDocumento;
                  qryUpd.ExecSQL;

                  fLogChq(LAutoIncremDocumento, 1, True);
                End;

                strChqAvi := strChqAvi + #13#10;

                strImpRecibo := AnsiReplaceStr(strImpRecibo, '<<CHEQUE_AVI>>', strChqAvi);

                If blnImpChq Then
                  strImpressao := AnsiReplaceStr(strImpressao, '<<CHEQUE_AVI>>', strChqAvi)
                Else
                  strImpressao := AnsiReplaceStr(strImpressao, '<<CHEQUE_AVI>>', '')
              End;

              {**************************************************************}
              {* CHEQUE PRE - ATUALIZA TABELA CADCHQ (CHQ_DTATRA)           *}
              {***********************************************************LU*}
              If (LAutoIncremsChequesPre.Count > 0) And (fltChqPre <> 0) Then
              Begin

                strChqPre := strChqPre + fReplicatorStr('-', 39) + #13#10 +
                                         fPadR('BCO', 3) + ' | ' +
                                         fPadR('AGE.', 5) + ' | ' +
                                         fPadR('CONTA', 12) + ' | ' +
                                         fPadR('Nro. CHQ.', 10) + #13#10 +
                                         fPadR('VENC.', 10) + ' | ' +
                                         fPadR('CLIENTE', 8)+ ' | ' +
                                         fPadL('VALOR', 10) + #13#10 +
                                         fReplicatorStr('-', 39) + #13#10;

                For LAutoIncremDocumento In LAutoIncremsChequesPre Do
                Begin
                  frmRcxTrasfValores.cdsChqPre.Locate('AUTOINCREM', LAutoIncremDocumento, []);

                  If Not fDocumentoExiste('CADCHQ', LAutoIncremDocumento) Then
                  Begin
                    fRollBack;
                    blnConfirma := False;
                    fMensagem('', 'O cheque ' +
                                  'Bn: ' + frmRcxTrasfValores.cdsChqPre.FieldByName('BANCO').AsString + ' / ' +
                                  'Ag: ' + frmRcxTrasfValores.cdsChqPre.FieldByName('AGENCIA').AsString + ' / ' +
                                  'Cc: ' + frmRcxTrasfValores.cdsChqPre.FieldByName('CONTA').AsString + ' / ' +
                                  'Nm: ' + frmRcxTrasfValores.cdsChqPre.FieldByName('NUMERO').AsString + ' / ' +
                                  'Vl: ' + FloatToStrF(frmRcxTrasfValores.cdsChqPre.FieldByName('VALOR').AsFloat, ffNumber, 12, 2) +
                                  ' não existe mais no módulo de cheques.' + #13#10 + 'Operação cancelada.',
                                  ['&Ok']);
                    Exit;
                  End;

                  strChqPre := strChqPre + fPadR(frmRcxTrasfValores.cdsChqPre.FieldByName('BANCO').AsString, 3) + ' | ' +
                                           fPadR(frmRcxTrasfValores.cdsChqPre.FieldByName('AGENCIA').AsString, 5) + ' | ' +
                                           fPadR(frmRcxTrasfValores.cdsChqPre.FieldByName('CONTA').AsString, 12) + ' | ' +
                                           fPadR(frmRcxTrasfValores.cdsChqPre.FieldByName('NUMERO').AsString, 10) + #13#10 +
                                           fPadR(frmRcxTrasfValores.cdsChqPre.FieldByName('DTAVEN').AsString, 10) + ' | ' +
                                           fPadR(frmRcxTrasfValores.cdsChqPre.FieldByName('CODCLI').AsString, 8)+ ' | ' +
                                           fPadL(FloatToStrF(frmRcxTrasfValores.cdsChqPre.FieldByName('VALOR').AsFloat, ffNumber, 12, 2), 10) + #13#10;

                  strSQL1 := '';
                  strSQL1 := strSQL1 + ' UPDATE ';
                  strSQL1 := strSQL1 + '   CADCHQ ';
                  strSQL1 := strSQL1 + ' SET ';
                  strSQL1 := strSQL1 + '   CHQ_DTATRA = :DTATRA, ';
                  strSQL1 := strSQL1 + '   CHQ_SEQTRF = :SEQTRF, ';
                  strSQL1 := strSQL1 + '   CHQ_PORCHQ = :PORCHQ, ';
                  strSQL1 := strSQL1 + '   CHQ_CTACHQ = :CTACHQ, ';
                  strSQL1 := strSQL1 + '   CHQ_TRFLIB = :TRFLIB  ';
                  strSQL1 := strSQL1 + ' WHERE ';
                  strSQL1 := strSQL1 + '   AUTOINCREM = :AUTINC ';

                  qryUpd.Close;
                  qryUpd.SQL.Text := strSQL1;
                  qryUpd.ParamByName('DTATRA').AsDateTime := LDataMovimentacaoBancaria;
                  qryUpd.ParamByName('SEQTRF').AsInteger  := intSeqCon;
                  qryUpd.ParamByName('PORCHQ').AsString   := frmRcxTrasfValores.edtCodPorChp.Text;
                  qryUpd.ParamByName('CTACHQ').AsString   := fConverteCentroCusto(fCfgSisL('CTTRCP'));
                  qryUpd.ParamByName('TRFLIB').AsString   := LTransferenciaLiberada;

                  qryUpd.ParamByName('AUTINC').AsString   := LAutoIncremDocumento;
                  qryUpd.ExecSQL;

                  fLogChq(LAutoIncremDocumento, 2, True);
                End;

                strChqPre := strChqPre + #13#10;

                strImpRecibo := AnsiReplaceStr(strImpRecibo, '<<CHEQUE_PRE>>', strChqPre);

                If blnImpChq Then
                  strImpressao := AnsiReplaceStr(strImpressao, '<<CHEQUE_PRE>>', strChqPre)
                Else
                  strImpressao := AnsiReplaceStr(strImpressao, '<<CHEQUE_PRE>>', '')
              End;

              If (LAutoIncremsCartoes.Count > 0) And (fltCartao <> 0) Then
              Begin

                strCartao := strCartao + fReplicatorStr('-', 39) + #13#10 +
                                         fPadR('CARTAO', 6) + ' | ' +
                                         fPadR('NUM. LIBERACAO', 20) + #13#10 +
                                         fPadR('VENC.', 10) + ' | ' +
                                         fPadR('CLIENTE', 8)+ ' | ' +
                                         fPadL('VALOR', 10) + #13#10 +
                                         fReplicatorStr('-', 39) + #13#10;

                {************************************************************}
                {* CARTAO - ATUALIZA TABELA MOVCAR (MCA_DTATRA, MCA_RESCAI) *}
                {*********************************************************LU*}
                For LAutoIncremDocumento In LAutoIncremsCartoes Do
                Begin

                  If frmRcxTrasfValores.cdsCarCre.Locate('AUTOINCREM', LAutoIncremDocumento, []) Then
                  Begin

                    If Not fDocumentoExiste('MOVCAR', LAutoIncremDocumento) Then
                    Begin
                      fRollBack;
                      blnConfirma := False;

                      fMensagem('', 'O cartão ' +
                                    'Núm.: ' + frmRcxTrasfValores.cdsCarCre.FieldByName('CODCAR').AsString + ' / ' +
                                    'Lib.: ' + frmRcxTrasfValores.cdsCarCre.FieldByName('NUMCCD').AsString + ' / ' +
                                    'Val.: ' + FloatToStrF(frmRcxTrasfValores.cdsCarCre.FieldByName('VALOR').AsFloat, ffNumber, 12, 2) +
                                    ' não existe mais no módulo de cartões.' + #13#10 + 'Operação cancelada.',
                                    ['&Ok']);
                      Exit;
                    End;

                    strCartao := strCartao + fPadR(frmRcxTrasfValores.cdsCarCre.FieldByName('CODCAR').AsString, 6) + ' | ' +
                                             fPadR(frmRcxTrasfValores.cdsCarCre.FieldByName('NUMCCD').AsString, 20) + #13#10 +
                                             fPadR(frmRcxTrasfValores.cdsCarCre.FieldByName('DTAVEN').AsString, 10) + ' | ' +
                                             fPadR(frmRcxTrasfValores.cdsCarCre.FieldByName('CODCLI').AsString, 8) + ' | ' +
                                             fPadL(FloatToStrF(frmRcxTrasfValores.cdsCarCre.FieldByName('VALOR').AsFloat, ffNumber, 12, 2), 10) + #13#10;
                  End;

                  {*****************************************}
                  {* ATENÇÃO: ESSE UPDATE IRÁ ATUALIZAR VÁ-*}
                  {* RIOS CARTÕES AO MESMO TEMPO, DEVIDO A *}
                  {* ALTERAÇÃO DE SINTETIZAR OS CARTÕES.   *}
                  {**************************************MV*}
                  strSQL1 := '';
                  strSQL1 := strSQL1 + ' UPDATE ';
                  strSQL1 := strSQL1 + '   MOVCAR ';
                  strSQL1 := strSQL1 + ' SET ';
                  strSQL1 := strSQL1 + '   MCA_DTATRA = :DTATRA, ';
                  strSQL1 := strSQL1 + '   MCA_SEQTRF = :SEQTRF,  ';
                  strSQL1 := strSQL1 + '   MCA_PORCAR = :PORCAR, ';
                  strSQL1 := strSQL1 + '   MCA_CTACAR = :CTACAR, ';
                  strSQL1 := strSQL1 + '   MCA_TRFLIB = :TRFLIB ';
                  strSQL1 := strSQL1 + ' WHERE ';
                  strSQL1 := strSQL1 + '   AUTOINCREM=:AUTINC ';

                  qryUpd.Close;
                  qryUpd.SQL.Text := strSQL1;

                  qryUpd.ParamByName('DTATRA').AsDateTime := LDataMovimentacaoBancaria;
                  qryUpd.ParamByName('SEQTRF').AsInteger  := intSeqCon;
                  qryUpd.ParamByName('PORCAR').AsString   := frmRcxTrasfValores.edtCodPorCrt.Text;
                  qryUpd.ParamByName('CTACAR').AsString   := fConverteCentroCusto(fCfgSisL('CTTRCR'));
                  qryUpd.ParamByName('TRFLIB').AsString   := LTransferenciaLiberada;

                  qryUpd.ParamByName('AUTINC').AsString   := LAutoIncremDocumento;
                  qryUpd.ExecSQL;

                  untLogMca.GravaLogMca(LAutoIncremDocumento, 'TRANSF. VALORES', Self.Name);
                end;

                strCartao := strCartao + #13#10;

                strImpRecibo := AnsiReplaceStr(strImpRecibo, '<<CARTAO>>', strCartao);

                If blnImpCar Then
                  strImpressao := AnsiReplaceStr(strImpressao, '<<CARTAO>>', strCartao)
                Else
                  strImpressao := AnsiReplaceStr(strImpressao, '<<CARTAO>>', '')

              End;

            Except
              On E: Exception Do
              Begin
                fRollBack;
                pMensagensErro(E.Message, '[pExecutaTransferencia]');
                Exit;
              End;
            End;
          End
          Else
          Begin
            strImpressao := AnsiReplaceStr(strImpressao, '<<CHEQUE_AVI>>', '');
            strImpressao := AnsiReplaceStr(strImpressao, '<<CHEQUE_PRE>>', '');
            strImpressao := AnsiReplaceStr(strImpressao, '<<CARTAO>>', '');

            strImpRecibo := AnsiReplaceStr(strImpRecibo, '<<CHEQUE_AVI>>', '');
            strImpRecibo := AnsiReplaceStr(strImpRecibo, '<<CHEQUE_PRE>>', '');
            strImpRecibo := AnsiReplaceStr(strImpRecibo, '<<CARTAO>>', '');
          End;

          If Not fGravaReciboTransferencia(strSeqRcx, VS_strCodEmp, strImpRecibo) Then
            Exit;

          pGeraLogLiberacao('', '', '');

          {***********************************************************************************************************************************************}
          {* CASO CONFIGURADO 'S' CFG_UTAUCX SIGNIFICA QUE EXISTE UMA FUNCTION NO BANCO DE DADOS DO CLIENTE COM O NOME F_AUDITORIA_GRAVACAO_RESUMO_CAIXA *}
          {* ESSA FUNÇÃO IRÁ EXECUTAR UMA AUDITORIA PARA GRAVAÇÃO DO RESUMO DE CAIXA, CASO PASSE PELA AUDITORIA AI SIM COMMITA A ROTINA. *****************}
          {* ISSO GARANTE QUE A CADRCXX FIQUE CERTA NO BANCO DO CLIENTE. NESSE CASO EVITA QUE A 'TF' DUPLIQUE COM DESCRIÇÃO EM BRANCO ********************}
          {*REQ 128284 ********************************************************************************************************************************MO*}
          if not FAuditoriaResumoCaixa.ValidouTodas(strCodErrosAuditoria) then
          begin
            fRollBack;
            pMostraErrosAuditoria(strCodErrosAuditoria);
            Exit;
          end
          Else
            fCommit;

          If fCfgSis('IMPCPT', varBoolean) And (blnImpTF) Then
          Begin
            intQtdImp := fCfgSis('QTDVTR');

            If (intQtdImp = 1) Then
              fGetMenu('Qtd. Vias', [IntToStr(intQtdImp) + ' Via',' '], 1)
            Else
              fGetMenu('Qtd. Vias', [IntToStr(intQtdImp) + ' Vias',' '], 1);

            pImprimeTransferencia(intSeqCon,
                                  VS_strCodEmp,
                                  dtaDtaCai,
                                  intQtdImp,
                                  frmRcxTrasfValores.edtCodPorDin.Text,
                                  frmRcxTrasfValores.edtCodPorOrd.Text,
                                  frmRcxTrasfValores.edtCodPorChv.Text,
                                  frmRcxTrasfValores.edtCodPorChp.Text,
                                  frmRcxTrasfValores.edtCodPorCrt.Text,
                                  frmRcxTrasfValores.edtCodPorFin.Text,
                                  frmRcxTrasfValores.fltDinhei,
                                  frmRcxTrasfValores.fltOrdPag,
                                  frmRcxTrasfValores.fltChqVis,
                                  frmRcxTrasfValores.fltChqPre,
                                  frmRcxTrasfValores.fltCartao,
                                  frmRcxTrasfValores.fltValFin,
                                  frmRcxTrasfValores.cdsChqAVi,
                                  frmRcxTrasfValores.cdsChqPre,
                                  frmRcxTrasfValores.cdsCarCre,
                                  blnImpChq, blnImpCar, False,
                                  strImpressao,
                                  edtCodOpe.Text, 'I',
                                  edtCodigoCaixa.Text,
                                  LOrdenacao);

          End;

          {*****************************************************}
          {* FORÇANDO A LIMPAR AS VARIÁVEIS ANTES DO fMensagem *}
          {* SE A MENSAGEM APARECE ATRAS DO AUTCOM E O USUÁRIO *}
          {* CLICAR EM CONFIRMAR, GERA UM OUTRO REGISTRO DE    *}
          {* TRANSFERÊNCIA SEM DESCRIÇÃO - REQ 109166          *}
          {**************************************************AJ*}
          tbsLancamentosShow(edtNumDoc);
          strEspDoc      := '';
          edtDesOpc.Text := '';

          fMensagem('','Transferência efetuada com sucesso!',['&OK']);
        End
        Else
        Begin
          fRollBack;
        End;

      End

      Else If (blnConfirma) Then
      Begin
        {*************************************************}
        {* DEVE SER CHAMADO ANTES DA TRANSACAO PRINCIPAL *}
        {*********************************************JC**}
        intSeqCon := StrToInt(fRetRcxCon);

        fStartTransaction;

        lsvLancamentos.Enabled := False;
        fltDinhei := frmRcxTrasfValoresPar.fltDinhei;
        fltChqAvi := frmRcxTrasfValoresPar.fltChqVis;
        fltChqPre := frmRcxTrasfValoresPar.fltChqPre;
        fltCartao := frmRcxTrasfValoresPar.fltCartao;
        fltOrdPag := frmRcxTrasfValoresPar.fltOrdPag;
        fltValFin := frmRcxTrasfValoresPar.fltValFin;

        fltTotGua := frmRcxTrasfValoresPar.fltGuaranie;
        fltTotDol := frmRcxTrasfValoresPar.fltDolar;
        fltTotEur := frmRcxTrasfValoresPar.fltEuro;
        fltTotPes := frmRcxTrasfValoresPar.fltPeso;
        fltTotRea := frmRcxTrasfValoresPar.fltReal;

        fltDinhe2 := frmRcxTrasfValoresPar.fltDinhe2;
        fltChqAv2 := frmRcxTrasfValoresPar.fltChqVi2;
        fltChqPr2 := frmRcxTrasfValoresPar.fltChqPr2;
        fltCarta2 := frmRcxTrasfValoresPar.fltCarta2;
        fltOrdPa2 := frmRcxTrasfValoresPar.fltOrdPa2;
        fltValFi2 := frmRcxTrasfValoresPar.fltValFi2;

        fltTotGua2 := frmRcxTrasfValoresPar.fltGuaranie2;
        fltTotDol2 := frmRcxTrasfValoresPar.fltDolar2;
        fltTotEur2 := frmRcxTrasfValoresPar.fltEuro2;
        fltTotPes2 := frmRcxTrasfValoresPar.fltPeso2;
        fltTotRea2 := frmRcxTrasfValoresPar.fltReal2;

        fltValDoc := frmRcxTrasfValoresPar.fltValDig + frmRcxTrasfValoresPar.fltValDi2;

        strImpressao := '';
        strImpRecibo := '';
        strDescri    := '';

        strPorTrans := '';
        For intContador := 0 To 5 Do
        Begin

          If intContador = 0 Then
          Begin
            fltSalFec := fltTotGua;
            strSQL    := 'TRANSF. DE CAIXA ( GUARANIE )';
            strDescri := 'TF CAIXA (GUA) - ' + frmRcxTrasfValoresPar.edtCodPorGua.Text + '-' + frmRcxTrasfValoresPar.edtDesPortadorGua.Text;
            strCodPor := frmRcxTrasfValoresPar.edtCodPorGua.Text;
          End

          Else If intContador = 1 Then
          Begin
            fltSalFec := fltTotDol;
            strSQL    := 'TRANSF. DE CAIXA ( DOLAR )';
            strDescri := 'TF CAIXA (DOL) - ' + frmRcxTrasfValoresPar.edtCodPorDol.Text + '-' + frmRcxTrasfValoresPar.edtDesPortadorDol.Text;
            strCodPor := frmRcxTrasfValoresPar.edtCodPorDol.Text;
          End

          Else If intContador = 2 Then
          Begin
            fltSalFec := fltTotEur;
            strSQL    := 'TRANSF. DE CAIXA ( EURO )';
            strDescri := 'TF CAIXA (EUR) - ' + frmRcxTrasfValoresPar.edtCodPorEur.Text + '-' + frmRcxTrasfValoresPar.edtDesPortadorEur.Text;
            strCodPor := frmRcxTrasfValoresPar.edtCodPorEur.Text;
          End

          Else If intContador = 3 Then
          Begin
            fltSalFec := fltTotPes;
            strSQL    := 'TRANSF. DE CAIXA ( PESO )';
            strDescri := 'TF CAIXA (PES) - ' + frmRcxTrasfValoresPar.edtCodPorPes.Text + '-' + frmRcxTrasfValoresPar.edtDesPortadorPes.Text;
            strCodPor := frmRcxTrasfValoresPar.edtCodPorPes.Text;
          End

          Else If intContador = 4 Then
          Begin
            fltSalFec := fltTotRea;
            strSQL    := 'TRANSF. DE CAIXA ( REAL )';
            strDescri := 'TF CAIXA (REA) - ' + frmRcxTrasfValoresPar.edtCodPorRea.Text + '-' + frmRcxTrasfValoresPar.edtDesPortadorRea.Text;
            strCodPor := frmRcxTrasfValoresPar.edtCodPorRea.Text;
          End

          Else If intContador = 5 Then
          Begin
            fltSalFec := fltChqAvi;
            strSQL    := 'TRANSF. DE CAIXA ( CHEQUE A VISTA )';
            strDescri := 'TF CAIXA (CHV) - ' + frmRcxTrasfValoresPar.edtCodPorChv.Text + '-' + frmRcxTrasfValoresPar.edtDesPortadorChv.Text;
            strCodPor := frmRcxTrasfValoresPar.edtCodPorChv.Text;
          End

          Else If intContador = 6 Then
          Begin
            fltSalFec := fltChqPre;
            strSQL    := 'TRANSF. DE CAIXA ( CHEQUE PRE )';
            strDescri := 'TF CAIXA (CHP) - ' + frmRcxTrasfValoresPar.edtCodPorChp.Text + '-' + frmRcxTrasfValoresPar.edtDesPortadorChp.Text;
            strCodPor := frmRcxTrasfValoresPar.edtCodPorChp.Text;
          End

          Else If intContador = 7 Then
          Begin
            fltSalFec := fltCartao;
            strSQL    := 'TRANSF. DE CAIXA ( CARTAO )';
            strDescri := 'TF CAIXA (CAR) - ' + frmRcxTrasfValoresPar.edtCodPorCrt.Text + '-' + frmRcxTrasfValoresPar.edtDesPortadorCrt.Text;
            strCodPor := frmRcxTrasfValoresPar.edtCodPorCrt.Text;
          End

          Else If intContador = 8 Then
          Begin
            fltSalFec := fltOrdPag;
            strSQL    := 'TRANSF. DE CAIXA ( ORDEM DE PAGAMENTO )';
            strDescri := 'TF CAIXA (OP) - ' + frmRcxTrasfValoresPar.edtCodPorOrd.Text + '-' + frmRcxTrasfValoresPar.edtDesPortadorOrd.Text;
            strCodPor := frmRcxTrasfValoresPar.edtCodPorOrd.Text;
          End

          Else If intContador = 9 Then
          Begin
            fltSalFec := fltValFin;
            strSQL    := 'TRANSF. DE CAIXA ( FINANCIAMENTO )';
            strDescri := 'TF CAIXA (FIN) - ' + frmRcxTrasfValoresPar.edtCodPorFin.Text + '-' + frmRcxTrasfValoresPar.edtDesPortadorFin.Text;
            strCodPor := frmRcxTrasfValoresPar.edtCodPorFin.Text;
          End;

          If fltSalFec > 0 Then
          Begin
            strPorTrans := strPorTrans + strCodPor + '/';

            strImpressao := strImpressao + strSQL + #13#10;
            strImpressao := strImpressao + fPadR('PORTADOR: ' + strCodPor + '-' + fRetNomPortador(strCodPor),39) + #13#10;
            strImpressao := strImpressao +       'VALOR...: ' + fPadL(FloatToStrF(fltSalFec,ffFixed,12,2),12) + #13#10;

            If intContador = CHEQUE_AVI Then
              strImpressao := strImpressao + '<<CHEQUE_AVI>>'
            Else If intContador = CHEQUE_PRE Then
              strImpressao := strImpressao + '<<CHEQUE_PRE>>'
            Else If intContador = CARTAO Then
              strImpressao := strImpressao + '<<CARTAO>>';

            LBanTrf := TBanTrfDS.Create;
            LBanTrf.strCodOpe := edtCodOpe.Text;
            LBanTrf.strCodEmp := VS_strCodEmp;
            LBanTrf.strDescri := strDescri;
            LBanTrf.fltValDoc := fltSalFec;
            LBanTrf.fltDinRec := IIF(intContador = 0, fltSalFec, 0);
            LBanTrf.fltChqAvi := IIF(intContador = CHEQUE_AVI, fltSalFec, 0);
            LBanTrf.fltChqPre := IIF(intContador = CHEQUE_PRE, fltSalFec, 0);
            LBanTrf.fltCarRec := IIF(intContador = CARTAO, fltSalFec, 0);
            LBanTrf.fltOrdRec := IIF(intContador = 4, fltSalFec, 0);
            LBanTrf.fltValFin := IIF(intContador = FINANCIAMENTO, fltSalFec, 0);

            LListaBanTrf := TListaBanTrf.Create;
            LListaBanTrf.Add(LBanTrf);

            {*******************************************}
            {* REALIZA GRAVAÇÃO DO MOVBAN              *}
            {****************************************AF*}
            strSeqLan := fGravaMovBan(strCtaTra,                                         // Centro de Custo
                                      strCodPor,                                         // Portador da Baixa
                                      edtCodOpe.Text,                                    // Operador da Baixa
                                      LDataMovimentacaoBancaria,                         // Data do Lançamento
                                      fTime(),                                           // Hora do Lançamento
                                      '',                                                // Numero do Documento
                                      'C',                                               // Credito / Debito
                                      VS_strCodEmp,                                      // Empresa da Baixa
                                      fltSalFec,                                         // Valor Do Lançamento
                                      strDescri,                                         // Histórico 1
                                      '',                                                // Histórico 2
                                      '',                                                // Cliente da Duplicata
                                      '',                                                // Fornecedor da Duplicata
                                      '',                                                // Número da Duplicata
                                      0,                                                 // Sequencial de Baixa
                                      'A',                                               // Parcela da Duplicata
                                      VS_strCodEmp,                                      // Empresa da Duplicata
                                      '',                                                // Série
                                      //'',                                              // Sequencial de Lançamento
                                      '',                                                // Codigo do Evento
                                      '',                                                // Documento da Baixa
                                      Nil,                                               // Log Bancário
                                      intSeqCon,                                         // Sequencial de Transf.
                                      0,
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      1,
                                      True,
                                      LListaBanTrf);

            If (fEmptyStr(strSeqLan)) Then
            Begin
              fRollBack;
              pMensagensErro('Ocorreu um erro na gravação do MOVBAN!!!','Resumo de caixa - [gravaçao do movban]');
              Break;
            End;

            FreeAndNil(LBanTrf);
            FreeAndNil(LListaBanTrf);

          {**************************************************}
          {* AQUI GRAVAVA NA MOVBAN(X) UM LANÇAMENTO (C/D)  *}
          {* REFERENTE AO DEPÓSITO DO CHEQUE A VISTA QUANDO *}
          {* CONFIGURAÇÃO CFG_RCXTCC ESTVA = LIBERADA NÃO   *}
          {* VINCULADA E ERA INFORMADO QUE O CHEQUE ESTAVA  *}
          {* DEPOSITADO. SEGUNDO O RONALDO TODOS OS CLIENTES*}
          {* NA VERSÃO 379.48.02 DEVEM SE IMPLANTADOS COMO  *}
          {* TRANSFERÊNCIA VINCULADA AOS DOCUMENTOS         *}
          {*REQ-29572-21/01/2015**************************JU*}
          End;

        End;

        {*******************************************}
        {* GRAVA O CAIXA 2                         *}
        {****************************************AF*}
        For intContador := 0 To 5 Do
        Begin

          If intContador = 0 Then
          Begin
            fltSalFec := fltTotGua2;
            strSQL    := 'TRANSF. DE CAIXA ( GUARANIE )';
            strDescri := 'TF CAIXA (GUA) - ' + frmRcxTrasfValoresPar.edtCodPorGua.Text + '-' + frmRcxTrasfValoresPar.edtDesPortadorGua.Text;
            strCodPor := frmRcxTrasfValoresPar.edtCodPorGua.Text;
          End

          Else If intContador = 1 Then
          Begin
            fltSalFec := fltTotDol2;
            strSQL    := 'TRANSF. DE CAIXA ( DOLAR )';
            strDescri := 'TF CAIXA (DOL) - ' + frmRcxTrasfValoresPar.edtCodPorDol.Text + '-' + frmRcxTrasfValoresPar.edtDesPortadorDol.Text;
            strCodPor := frmRcxTrasfValoresPar.edtCodPorDol.Text;
          End

          Else If intContador = 2 Then
          Begin
            fltSalFec := fltTotEur2;
            strSQL    := 'TRANSF. DE CAIXA ( EURO )';
            strDescri := 'TF CAIXA (EUR) - ' + frmRcxTrasfValoresPar.edtCodPorEur.Text + '-' + frmRcxTrasfValoresPar.edtDesPortadorEur.Text;
            strCodPor := frmRcxTrasfValoresPar.edtCodPorEur.Text;
          End

          Else If intContador = 3 Then
          Begin
            fltSalFec := fltTotPes2;
            strSQL    := 'TRANSF. DE CAIXA ( PESO )';
            strDescri := 'TF CAIXA (PES) - ' + frmRcxTrasfValoresPar.edtCodPorPes.Text + '-' + frmRcxTrasfValoresPar.edtDesPortadorPes.Text;
            strCodPor := frmRcxTrasfValoresPar.edtCodPorPes.Text;
          End

          Else If intContador = 4 Then
          Begin
            fltSalFec := fltTotRea2;
            strSQL    := 'TRANSF. DE CAIXA ( REAL )';
            strDescri := 'TF CAIXA (REA) - ' + frmRcxTrasfValoresPar.edtCodPorRea.Text + '-' + frmRcxTrasfValoresPar.edtDesPortadorRea.Text;
            strCodPor := frmRcxTrasfValoresPar.edtCodPorRea.Text;
          End

          Else If intContador = 5 Then
          Begin
            fltSalFec := fltChqAv2;
            strSQL    := 'TRANSF. DE CAIXA ( CHEQUE A VISTA )';
            strDescri := 'TF CAIXA (CHV) - ' + frmRcxTrasfValoresPar.edtCodPorChv.Text + '-' + frmRcxTrasfValoresPar.edtDesPortadorChv.Text;
            strCodPor := frmRcxTrasfValoresPar.edtCodPorChv.Text;
          End

          Else If intContador = 6 Then
          Begin
            fltSalFec := fltChqPr2;
            strSQL    := 'TRANSF. DE CAIXA ( CHEQUE PRE )';
            strDescri := 'TF CAIXA (CHP) - ' + frmRcxTrasfValoresPar.edtCodPorChp.Text + '-' + frmRcxTrasfValoresPar.edtDesPortadorChp.Text;
            strCodPor := frmRcxTrasfValoresPar.edtCodPorChp.Text;
          End

          Else If intContador = 7 Then
          Begin
            fltSalFec := fltCarta2;
            strSQL    := 'TRANSF. DE CAIXA ( CARTAO )';
            strDescri := 'TF CAIXA (CAR) - ' + frmRcxTrasfValoresPar.edtCodPorCrt.Text + '-' + frmRcxTrasfValoresPar.edtDesPortadorCrt.Text;
            strCodPor := frmRcxTrasfValoresPar.edtCodPorCrt.Text;
          End

          Else If intContador = 8 Then
          Begin
            fltSalFec := fltOrdPa2;
            strSQL    := 'TRANSF. DE CAIXA ( ORDEM DE PAGAMENTO )';
            strDescri := 'TF CAIXA (OP) - ' + frmRcxTrasfValoresPar.edtCodPorOrd.Text + '-' + frmRcxTrasfValoresPar.edtDesPortadorOrd.Text;
            strCodPor := frmRcxTrasfValoresPar.edtCodPorOrd.Text;
          End

          Else If intContador = 9 Then
          Begin
            fltSalFec := fltValFi2;
            strSQL    := 'TRANSF. DE CAIXA ( FINANCIAMENTO )';
            strDescri := 'TF CAIXA (FIN) - ' + frmRcxTrasfValoresPar.edtCodPorFin.Text + '-' + frmRcxTrasfValoresPar.edtDesPortadorFin.Text;
            strCodPor := frmRcxTrasfValoresPar.edtCodPorFin.Text;
          End;

          If fltSalFec > 0 Then
          Begin
            strPorTrans := strPorTrans + strCodPor + '/';

            strImpressao := strImpressao + strSQL + #13#10;
            strImpressao := strImpressao + fPadR('PORTADOR: ' + strCodPor + '-' + fRetNomPortador(strCodPor),39) + #13#10;
            strImpressao := strImpressao +       'VALOR...: ' + fPadL(FloatToStrF(fltSalFec,ffFixed,12,2),12) + #13#10 + #13#10;

            LBanTrf := TBanTrfDS.Create;
            LBanTrf.strCodOpe := edtCodOpe.Text;
            LBanTrf.strCodEmp := VS_strCodEmp;
            LBanTrf.strDescri := strDescri;
            LBanTrf.fltValDoc := fltSalFec;
            LBanTrf.fltDinRec := IIF(intContador = 0, fltSalFec, 0);
            LBanTrf.fltChqAvi := IIF(intContador = CHEQUE_AVI, fltSalFec, 0);
            LBanTrf.fltChqPre := IIF(intContador = CHEQUE_PRE, fltSalFec, 0);
            LBanTrf.fltCarRec := IIF(intContador = CARTAO, fltSalFec, 0);
            LBanTrf.fltOrdRec := IIF(intContador = 4, fltSalFec, 0);
            LBanTrf.fltValFin := IIF(intContador = FINANCIAMENTO, fltSalFec, 0);

            LListaBanTrf := TListaBanTrf.Create;
            LListaBanTrf.Add(LBanTrf);

            {*******************************************}
            {* REALIZA GRAVAÇÃO DO MOVBAN              *}
            {****************************************AF*}
            strSeqLan := fGravaMovBan(strCtaTra,                                         // Centro de Custo
                                      strCodPor,                                         // Portador da Baixa
                                      edtCodOpe.Text,                                    // Operador da Baixa
                                      LDataMovimentacaoBancaria,                         // Data do Lançamento
                                      fTime(),                                           // Hora do Lançamento
                                      '',                                                // Numero do Documento
                                      'C',                                               // Credito / Debito
                                      VS_strCodEmp,                                      // Empresa da Baixa
                                      fltSalFec,                                         // Valor Do Lançamento
                                      strDescri,                                         // Histórico 1
                                      '',                                                // Histórico 2
                                      '',                                                // Cliente da Duplicata
                                      '',                                                // Fornecedor da Duplicata
                                      '',                                                // Número da Duplicata
                                      0,                                                 // Sequencial de Baixa
                                      'A',                                               // Parcela da Duplicata
                                      VS_strCodEmp,                                      // Empresa da Duplicata
                                      '',                                                // Série
                                      //'',                                              // Sequencial de Lançamento
                                      '',                                                // Codigo do Evento
                                      '',
                                      Nil,                                               // Log Bancário
                                      intSeqCon,                                         // Sequencial de Transf.
                                      0,
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      1,
                                      True,
                                      LListaBanTrf);

            If (fEmptyStr(strSeqLan)) Then
            Begin
              fRollBack;
              pMensagensErro('Ocorreu um erro na gravação do MOVBAN!!!','Resumo de caixa - [gravaçao do movban]');
              Break;
            End;

            FreeAndNil(LBanTrf);
            FreeAndNil(LListaBanTrf);
          {**************************************************}
          {* AQUI GRAVAVA NA MOVBAN(X) UM LANÇAMENTO (C/D)  *}
          {* REFERENTE AO DEPÓSITO DO CHEQUE A VISTA QUANDO *}
          {* CONFIGURAÇÃO CFG_RCXTCC ESTVA = LIBERADA NÃO   *}
          {* VINCULADA E ERA INFORMADO QUE O CHEQUE ESTAVA  *}
          {* DEPOSITADO. SEGUNDO O RONALDO TODOS OS CLIENTES*}
          {* NA VERSÃO 379.48.02 DEVEM SE IMPLANTADOS COMO  *}
          {* TRANSFERÊNCIA VINCULADA AOS DOCUMENTOS         *}
          {*REQ-29572-21/01/2015**************************JU*}
          End;

        End;

        If RightStr(strPorTrans, 1) = '/' Then
          strPorTrans := Copy(strPorTrans, 1, Length(strPorTrans)-1);

        edtDinRec.Text := FloatToStrF(fltDinhei + fltDinhe2,ffFixed,12,2);
        edtCarRec.Text := FloatToStrF(fltCartao + fltCarta2,ffFixed,12,2);
        edtChqRec.Text := FloatToStrF(fltChqAvi + fltChqAv2,ffFixed,12,2);
        edtChqPre.Text := FloatToStrF(fltChqPre + fltChqPr2,ffFixed,12,2);
        edtOrdRec.Text := FloatToStrF(fltOrdPag + fltOrdPa2,ffFixed,12,2);
        edtFinanc.Text := FloatToStrF(fltValFin + fltValFi2,ffFixed,12,2);

        edtValDoc.Text := FloatToStrF(fltValDoc,ffFixed,12,2);
        strDescri      := 'REF. TRANSF. CX./PORT: ' + strPorTrans;

        blnConfirma := fGravaResCai(RCX_GRAVA_NORMAL, '');

        If blnConfirma Then
        Begin
          If Not fGravouCaixaCorreto(strDifVal, intSeqCon) Then
          Begin
            blnConfirma := False;
            log('Houve um problema com a análise de fGravouCorretoCaixa(strDifVal, intSeqCon)');
            fRollBack;

            pMensagemOk('Ocorreu uma inconsistência na gravação dos valores!' + #13#10 +
                        strDifVal + #13#10 + 'Feche o Resumo de Caixa e tente novamente! Se o problema persistir entre em contato com a Citel!');

          End;
        End;

        If blnConfirma Then
        Begin
          If objResumoDeCaixa.strTipoFechamento = 'C' Then
            objResumoDeCaixa.EnviaMensagemLiberacaoUsuariosTransferencia(intSeqCon.ToString,
                                                                         VS_strCodEmp,
                                                                         edtCodigoCaixa.Text,
                                                                         dtaDtaCai);

          pImprimirSangria(fltDinhei, fltCartao, fltChqAvi, fltChqPre, fltOrdPag);

          strImpRecibo := strImpressao;

          {**************************************************************}
          {* CASO SEJA TRANSFERENCIA NÃO LIBERADA - COM DOCS VINCULADOS *}
          {***********************************************************LU*}
          If objResumoDeCaixa.TransferenciaVinculada Then
          Begin

            Try
              qryUpd := fCriaQuery;
              qryLogChq := fCriaQuery;

              With qryUpd Do
              Begin

                {**************************************************************}
                {* CHEQUE A VISTA - ATUALIZA TABELA CADCHQ (CHQ_DTATRA)       *}
                {***********************************************************LU*}
                If (Not frmRcxTrasfValoresPar.cdsChqAVi.IsEmpty) And (fltChqAvi <> 0) Then
                Begin

                  strChqAvi := strChqAvi + fReplicatorStr('-', 39) + #13#10 +
                                           fPadR('BCO', 3) + ' | ' +
                                           fPadR('AGE.', 5) + ' | ' +
                                           fPadR('CONTA', 12) + ' | ' +
                                           fPadR('Nro. CHQ.', 10) + #13#10 +
                                           fPadR('VENC.', 10) + ' | ' +
                                           fPadR('CLIENTE', 8)+ ' | ' +
                                           fPadL('VALOR', 10) + #13#10 +
                                           fReplicatorStr('-', 39) + #13#10;

                  frmRcxTrasfValoresPar.cdsChqAVi.First;

                  While Not frmRcxTrasfValoresPar.cdsChqAVi.Eof Do
                  Begin

                    strChqAvi := strChqAvi + fPadR(frmRcxTrasfValoresPar.cdsChqAVi.FieldByName('BANCO').AsString, 3) + ' | ' +
                                             fPadR(frmRcxTrasfValoresPar.cdsChqAVi.FieldByName('AGENCIA').AsString, 5) + ' | ' +
                                             fPadR(frmRcxTrasfValoresPar.cdsChqAVi.FieldByName('CONTA').AsString, 12) + ' | ' +
                                             fPadR(frmRcxTrasfValoresPar.cdsChqAVi.FieldByName('NUMERO').AsString, 10) + #13#10 +
                                             fPadR(frmRcxTrasfValoresPar.cdsChqAVi.FieldByName('DTAVEN').AsString, 10) + ' | ' +
                                             fPadR(frmRcxTrasfValoresPar.cdsChqAVi.FieldByName('CODCLI').AsString, 8)+ ' | ' +
                                             fPadL(FloatToStrF(frmRcxTrasfValoresPar.cdsChqAVi.FieldByName('VALOR').AsFloat, ffNumber, 12, 2), 10) + #13#10;

                    strSQL1 := '';
                    strSQL1 := strSQL1 + ' UPDATE ';

                    strSQL1 := strSQL1 + ' ' + frmRcxTrasfValoresPar.cdsChqAVi.fieldbyname('NOMTBL').AsString + ' ';

                    strSQL1 := strSQL1 + ' SET ';
                    strSQL1 := strSQL1 + '   CHQ_DTATRA = :DTATRA, ';
                    strSQL1 := strSQL1 + '   CHQ_SEQTRF = :SEQTRF, ';
                    strSQL1 := strSQL1 + '   CHQ_PORCHQ = :PORCHQ, ';
                    strSQL1 := strSQL1 + '   CHQ_CTACHQ = :CTACHQ, ';
                    strSQL1 := strSQL1 + '   CHQ_TRFLIB = :TRFLIB, ';
                    strSQL1 := strSQL1 + ' WHERE ';
                    strSQL1 := strSQL1 + '   AUTOINCREM = :AUTINC ';

                    Close;
                    SQL.Clear;
                    SQL.Add(strSQL1);
                    ParamByName('DTATRA').AsDateTime := LDataMovimentacaoBancaria;
                    ParamByName('AUTINC').AsString   := frmRcxTrasfValoresPar.cdsChqAVi.fieldbyname('AUTOINCREM').AsString;
                    ParamByName('SEQTRF').AsInteger  := intSeqCon;
                    ParamByName('PORCHQ').AsString   := frmRcxTrasfValoresPar.edtCodPorChv.Text;
                    ParamByName('CTACHQ').AsString   := fConverteCentroCusto(fCfgSisL('CTTRCV'));
                    ParamByName('TRFLIB').AsString   := LTransferenciaLiberada;
                    ExecSQL;

                    {****************************************}
                    {* INSERE VALORES NO ARRAY DO CADCHQ(X) *}
                    {*************************************JU*}

                    With qryLogChq Do
                    Begin
                      Close;
                      SQL.Clear;
                      SQL.Add(' SELECT * FROM ' +
                                frmRcxTrasfValores.cdsChqAVi.fieldbyname('NOMTBL').AsString +
                              ' WHERE AUTOINCREM = :AUTINC');
                      ParamByName('AUTINC').AsString := frmRcxTrasfValores.cdsChqAVi.fieldbyname('AUTOINCREM').AsString;
                      Open;

                      fLogChq(qryLogChq, 1, True);
                    End;

                    frmRcxTrasfValores.cdsChqAVi.Next;

                    frmRcxTrasfValoresPar.cdsChqAVi.Next;
                  End;

                  strChqAvi := strChqAvi + #13#10;

                  strImpRecibo := AnsiReplaceStr(strImpRecibo, '<<CHEQUE_AVI>>', strChqAvi);

                  If blnImpChq Then
                    strImpressao := AnsiReplaceStr(strImpressao, '<<CHEQUE_AVI>>', strChqAvi)
                  Else
                    strImpressao := AnsiReplaceStr(strImpressao, '<<CHEQUE_AVI>>', '')
                End;

                {**************************************************************}
                {* CHEQUE PRE - ATUALIZA TABELA CADCHQ (CHQ_DTATRA)           *}
                {***********************************************************LU*}
                If (Not frmRcxTrasfValoresPar.cdsChqPre.IsEmpty) And (fltChqPre <> 0) Then
                Begin

                  strChqPre := strChqPre + fReplicatorStr('-', 39) + #13#10 +
                                           fPadR('BCO', 3) + ' | ' +
                                           fPadR('AGE.', 5) + ' | ' +
                                           fPadR('CONTA', 12) + ' | ' +
                                           fPadR('Nro. CHQ.', 10) + #13#10 +
                                           fPadR('VENC.', 10) + ' | ' +
                                           fPadR('CLIENTE', 8)+ ' | ' +
                                           fPadL('VALOR', 10) + #13#10 +
                                           fReplicatorStr('-', 39) + #13#10;

                  frmRcxTrasfValoresPar.cdsChqPre.First;

                  While Not frmRcxTrasfValores.cdsChqPre.Eof Do
                  Begin

                    strChqPre := strChqPre + fPadR(frmRcxTrasfValoresPar.cdsChqPre.FieldByName('BANCO').AsString, 3) + ' | ' +
                                             fPadR(frmRcxTrasfValoresPar.cdsChqPre.FieldByName('AGENCIA').AsString, 5) + ' | ' +
                                             fPadR(frmRcxTrasfValoresPar.cdsChqPre.FieldByName('CONTA').AsString, 12) + ' | ' +
                                             fPadR(frmRcxTrasfValoresPar.cdsChqPre.FieldByName('NUMERO').AsString, 10) + #13#10 +
                                             fPadR(frmRcxTrasfValoresPar.cdsChqPre.FieldByName('DTAVEN').AsString, 10) + ' | ' +
                                             fPadR(frmRcxTrasfValoresPar.cdsChqPre.FieldByName('CODCLI').AsString, 8)+ ' | ' +
                                             fPadL(FloatToStrF(frmRcxTrasfValoresPar.cdsChqPre.FieldByName('VALOR').AsFloat, ffNumber, 12, 2), 10) + #13#10;

                    strSQL1 := '';
                    strSQL1 := strSQL1 + ' UPDATE ';

                    strSQL1 := strSQL1 + ' ' + frmRcxTrasfValoresPar.cdsChqPre.fieldbyname('NOMTBL').AsString + ' ';

                    strSQL1 := strSQL1 + ' SET ';
                    strSQL1 := strSQL1 + '   CHQ_DTATRA = :DTATRA, ';
                    strSQL1 := strSQL1 + '   CHQ_SEQTRF = :SEQTRF, ';
                    strSQL1 := strSQL1 + '   CHQ_PORCHQ = :PORCHQ, ';
                    strSQL1 := strSQL1 + '   CHQ_CTACHQ = :CTACHQ, ';
                    strSQL1 := strSQL1 + '   CHQ_TRFLIB = :TRFLIB  ';
                    strSQL1 := strSQL1 + ' WHERE ';
                    strSQL1 := strSQL1 + '   AUTOINCREM = :AUTINC ';

                    Close;
                    SQL.Clear;
                    SQL.Add(strSQL1);
                    ParamByName('DTATRA').AsDateTime := LDataMovimentacaoBancaria;
                    ParamByName('AUTINC').AsString   := frmRcxTrasfValoresPar.cdsChqPre.fieldbyname('AUTOINCREM').AsString;
                    ParamByName('SEQTRF').AsInteger  := intSeqCon;
                    ParamByName('PORCHQ').AsString   := frmRcxTrasfValoresPar.edtCodPorChp.Text;
                    ParamByName('CTACHQ').AsString   := fConverteCentroCusto(fCfgSisL('CTTRCP'));
                    ParamByName('TRFLIB').AsString   := LTransferenciaLiberada;
                    ExecSQL;

                    {****************************************}
                    {* INSERE VALORES NO ARRAY DO CADCHQ(X) *}
                    {*************************************JU*}

                    With qryLogChq Do
                    Begin
                      Close;
                      SQL.Clear;
                      SQL.Add(' SELECT * FROM ' +
                                frmRcxTrasfValores.cdsChqPre.fieldbyname('NOMTBL').AsString +
                              ' WHERE AUTOINCREM = :AUTINC');
                      ParamByName('AUTINC').AsString := frmRcxTrasfValores.cdsChqPre.fieldbyname('AUTOINCREM').AsString;
                      Open;

                      fLogChq(qryLogChq, 2, True);
                    End;

                    frmRcxTrasfValoresPar.cdsChqPre.Next;
                  End;

                  strChqPre := strChqPre + #13#10;

                  strImpRecibo := AnsiReplaceStr(strImpRecibo, '<<CHEQUE_PRE>>', strChqPre);

                  If blnImpChq Then
                    strImpressao := AnsiReplaceStr(strImpressao, '<<CHEQUE_PRE>>', strChqPre)
                  Else
                    strImpressao := AnsiReplaceStr(strImpressao, '<<CHEQUE_PRE>>', '')
                End;

              End;

              If (Not frmRcxTrasfValoresPar.cdsCarCre.IsEmpty) And (fltCartao <> 0) Then
              Begin

                strCartao := strCartao + fReplicatorStr('-', 39) + #13#10 +
                                         fPadR('CARTAO', 6) + ' | ' +
                                         fPadR('NUM. LIBERACAO', 20) + #13#10 +
                                         fPadR('VENC.', 10) + ' | ' +
                                         fPadR('CLIENTE', 8)+ ' | ' +
                                         fPadL('VALOR', 10) + #13#10 +
                                         fReplicatorStr('-', 39) + #13#10;

                {************************************************************}
                {* CARTAO - ATUALIZA TABELA MOVCAR (MCA_DTATRA, MCA_RESCAI) *}
                {*********************************************************LU*}
                frmRcxTrasfValoresPar.cdsCarCre.First;
                While Not frmRcxTrasfValoresPar.cdsCarCre.Eof Do
                Begin

                  strCartao := strCartao + fPadR(frmRcxTrasfValoresPar.cdsCarCre.FieldByName('CODCAR').AsString, 6) + ' | ' +
                                           fPadR(frmRcxTrasfValoresPar.cdsCarCre.FieldByName('NUMCCD').AsString, 20) + #13#10 +
                                           fPadR(frmRcxTrasfValoresPar.cdsCarCre.FieldByName('DTAVEN').AsString, 10) + ' | ' +
                                           fPadR(frmRcxTrasfValoresPar.cdsCarCre.FieldByName('CODCLI').AsString, 8) + ' | ' +
                                           fPadL(FloatToStrF(frmRcxTrasfValoresPar.cdsCarCre.FieldByName('VALOR').AsFloat, ffNumber, 12, 2), 10) + #13#10;

                  {*****************************************}
                  {* ATENÇÃO: ESSE UPDATE IRÁ ATUALIZAR VÁ-*}
                  {* RIOS CARTÕES AO MESMO TEMPO, DEVIDO A *}
                  {* ALTERAÇÃO DE SINTETIZAR OS CARTÕES.   *}
                  {**************************************MV*}
                  strSQL1 := '';
                  strSQL1 := strSQL1 + ' UPDATE ';
                  strSQL1 := strSQL1 + '   ' + frmRcxTrasfValoresPar.cdsCarCre.fieldbyname('NOMTBL').AsString + ' ';
                  strSQL1 := strSQL1 + ' SET ';
                  strSQL1 := strSQL1 + '   MCA_DTATRA = :DTATRA, ';
                  strSQL1 := strSQL1 + '   MCA_SEQTRF = :SEQTRF, ';
                  strSQL1 := strSQL1 + '   MCA_TRFLIB = :TRFLIB ';
                  strSQL1 := strSQL1 + ' WHERE ';
                  strSQL1 := strSQL1 + '   MCA_NUMDUP = :NUMDUP AND ';
                  strSQL1 := strSQL1 + '   MCA_CODCLI = :CODCLI AND ';
                  strSQL1 := strSQL1 + '   MCA_EMPRCX = :CODEMP ';

                  qryUpd.Close;
                  qryUpd.SQL.Text := strSQL1;

                  qryUpd.ParamByName('DTATRA').AsDateTime := LDataMovimentacaoBancaria;
                  qryUpd.ParamByName('NUMDUP').AsString   := frmRcxTrasfValores.cdsCarCre.fieldbyname('AGENCIA').AsString;
                  qryUpd.ParamByName('CODCLI').AsString   := frmRcxTrasfValores.cdsCarCre.fieldbyname('CODCLI').AsString;
                  qryUpd.ParamByName('SEQTRF').AsInteger  := intSeqCon;
                  qryUpd.ParamByName('CODEMP').AsString   := VS_strCodEmp;
                  qryUpd.ParamByName('PORCAR').AsString   := frmRcxTrasfValores.edtCodPorCrt.Text;
                  qryUpd.ParamByName('CTACAR').AsString   := fConverteCentroCusto(fCfgSisL('CTTRCR'));
                  qryUpd.ParamByName('TRFLIB').AsString   := LTransferenciaLiberada;

                  qryUpd.ExecSQL;

                  // Grava o log para todas as parcelas do cartão
                  LCartoes := untMovcar.RetornaDatasetCartoesTransferidos(frmRcxTrasfValores.cdsCarCre.fieldbyname('AGENCIA').AsString,
                                                                          frmRcxTrasfValores.cdsCarCre.fieldbyname('CODCLI').AsString,
                                                                          frmRcxTrasfValores.cdsCarCre.fieldbyname('CODEMP').AsString,
                                                                          frmRcxTrasfValores.cdsCarCre.fieldbyname('DTACAD').AsDateTime);

                  While Not LCartoes.Eof Do
                  Begin
                    untLogMca.GravaLogMca(LCartoes.FieldByName('AUTOINCREM').AsString,
                                          'TRANSF. VALORES',
                                          Self.Name);

                    LCartoes.Next;
                  End;

                  LCartoes.Close;
                  FreeAndNil(LCartoes);

                  frmRcxTrasfValoresPar.cdsCarCre.Next;
                End;

                strCartao := strCartao + #13#10;

                strImpRecibo := AnsiReplaceStr(strImpRecibo, '<<CARTAO>>', strCartao);

                If blnImpCar Then
                  strImpressao := AnsiReplaceStr(strImpressao, '<<CARTAO>>', strCartao)
                Else
                  strImpressao := AnsiReplaceStr(strImpressao, '<<CARTAO>>', '')


              End;

            Except
              On E: Exception Do
              Begin
                fRollBack;
                pMensagensErro(E.Message, '[pExecutaTransferencia]');
                Exit;
              End;
            End;
          End
          Else
          Begin
            strImpressao := AnsiReplaceStr(strImpressao, '<<CHEQUE_AVI>>', '');
            strImpressao := AnsiReplaceStr(strImpressao, '<<CHEQUE_PRE>>', '');
            strImpressao := AnsiReplaceStr(strImpressao, '<<CARTAO>>', '');

            strImpRecibo := AnsiReplaceStr(strImpRecibo, '<<CHEQUE_AVI>>', '');
            strImpRecibo := AnsiReplaceStr(strImpRecibo, '<<CHEQUE_PRE>>', '');
            strImpRecibo := AnsiReplaceStr(strImpRecibo, '<<CARTAO>>', '');
          End;

          If Not fGravaReciboTransferencia(strSeqRcx, VS_strCodEmp, strImpRecibo) Then
            Exit;

          {***********************************************************************************************************************************************}
          {* CASO CONFIGURADO 'S' CFG_UTAUCX SIGNIFICA QUE EXISTE UMA FUNCTION NO BANCO DE DADOS DO CLIENTE COM O NOME F_AUDITORIA_GRAVACAO_RESUMO_CAIXA *}
          {* ESSA FUNÇÃO IRÁ EXECUTAR UMA AUDITORIA PARA GRAVAÇÃO DO RESUMO DE CAIXA, CASO PASSE PELA AUDITORIA AI SIM COMMITA A ROTINA. *****************}
          {* ISSO GARANTE QUE A CADRCXX FIQUE CERTA NO BANCO DO CLIENTE. NESSE CASO EVITA QUE A 'TF' DUPLIQUE COM DESCRIÇÃO EM BRANCO ********************}
          {*REQ 128284 ********************************************************************************************************************************MO*}
          if not FAuditoriaResumoCaixa.ValidouTodas(strCodErrosAuditoria) then
          begin
            fRollBack;
            pMostraErrosAuditoria(strCodErrosAuditoria);
            Exit;
          end
          Else
            fCommit;

          If fCfgSis('IMPCPT', varBoolean) And (blnImpTF) Then
          Begin
            intQtdImp := fCfgSis('QTDVTR');

            If (intQtdImp = 1) Then
              fGetMenu('Qtd. Vias', [IntToStr(intQtdImp) + ' Via',' '], 1)
            Else
              fGetMenu('Qtd. Vias', [IntToStr(intQtdImp) + ' Vias',' '], 1);

            pImprimeTransferenciaPar(strSeqRcx,
                                     intQtdImp,
                                     frmRcxTrasfValoresPar.edtCodPorGua.Text,
                                     frmRcxTrasfValoresPar.edtCodPorDol.Text,
                                     frmRcxTrasfValoresPar.edtCodPorEur.Text,
                                     frmRcxTrasfValoresPar.edtCodPorPes.Text,
                                     frmRcxTrasfValoresPar.edtCodPorRea.Text,
                                     frmRcxTrasfValoresPar.edtCodPorOrd.Text,
                                     frmRcxTrasfValoresPar.edtCodPorChv.Text,
                                     frmRcxTrasfValoresPar.edtCodPorChp.Text,
                                     frmRcxTrasfValoresPar.edtCodPorCrt.Text,
                                     frmRcxTrasfValoresPar.edtCodPorFin.Text,
                                     frmRcxTrasfValoresPar.fltGuaranie,
                                     frmRcxTrasfValoresPar.fltDolar,
                                     frmRcxTrasfValoresPar.fltEuro,
                                     frmRcxTrasfValoresPar.fltPeso,
                                     frmRcxTrasfValoresPar.fltReal,
                                     frmRcxTrasfValoresPar.fltOrdPag,
                                     frmRcxTrasfValoresPar.fltChqVis,
                                     frmRcxTrasfValoresPar.fltChqPre,
                                     frmRcxTrasfValoresPar.fltCartao,
                                     frmRcxTrasfValoresPar.fltValFin,
                                     frmRcxTrasfValoresPar.cdsChqAVi,
                                     frmRcxTrasfValoresPar.cdsChqPre,
                                     frmRcxTrasfValoresPar.cdsCarCre,
                                     blnImpChq,
                                     blnImpCar,
                                     False,
                                     strImpressao);

          End;

          {*****************************************************}
          {* FORÇANDO A LIMPAR AS VARIÁVEIS ANTES DO fMensagem *}
          {* SE A MENSAGEM APARECE ATRAS DO AUTCOM E O USUÁRIO *}
          {* CLICAR EM CONFIRMAR, GERA UM OUTRO REGISTRO DE    *}
          {* TRANSFERÊNCIA SEM DESCRIÇÃO - REQ 109166          *}
          {**************************************************AJ*}
          tbsLancamentosShow(edtNumDoc);
          strEspDoc      := '';
          edtDesOpc.Text := '';

          fMensagem('','Transferência efetuada com sucesso!',['&OK']);

        End
        Else
        Begin
          fRollBack;
        End;

      End;

    Except
      On E: Exception Do
      Begin
        fRollBack;

        If Pos('DR0610BR', E.Message) > 0 Then
          fMensagem('','Erro ao tentar gravar dados do ECF, repita a operação!', ['&Ok'])
        Else
          pMensagensErro(E.Message, '[pExecutaTransferencia]');
        End;
    End;
  Finally
    If fInTransaction Then
    Begin
      fRollback;
      pMensagensErro('A operação de transferência não foi gravada. Tente novamente!', '[pExecutaTransferencia]');
    End;

    FreeAndNil(qryUpd);
    FreeAndNil(qryLogChq);

    tbsLancamentosShow(edtNumDoc);

    If strTipoFechamentoCaixa <> 'C' Then
      edtSqFcRx.Text := fStrZero(VarToStr(fCfgSisL('SQFCRX')), 3);

    lblFinanc.Visible := False;
    edtFinanc.Visible := False;
    edtFinanc.Text    := '0,00';

    chkPixAvulso.Visible := True;
    chkPixAvulso.Enabled := False;
    chkPixAvulso.Checked := False;

    If (FPais = opcParaguai) Then
      pFreeAndNil(frmRcxTrasfValoresPar)
    Else
      pFreeAndNil(frmRcxTrasfValores);

    FreeAndNil(LAutoIncremsCartoes);
    FreeAndNil(LAutoIncremsChequesAVista);
    FreeAndNil(LAutoIncremsChequesPre);
  End;

End;

function TfrmRcxResumoCaixa.fDadosDoPagamentoValidos: Boolean;
var
  LSaiuDaTelaSemConfirmar: Boolean;
  LMensagem: String;
begin
  repeat
    LSaiuDaTelaSemConfirmar := False;
    LMensagem := '';

    if fEmptyStr(strCodFor) Then
      LMensagem := 'Selecione o fornecedor para lançar o pagamento.'
    else if fEmptyStr(strCta_Pg) then
      LMensagem := 'Selecione o plano de contas para lançar o pagamento.'
    else if fCfgSis('CTPOBE', varBoolean) and fEmptyStr(strCodEve) then
      LMensagem := 'Selecione o centro de custos para lançar o pagamento.'
    else if fCfgSis('JUSPGT', varBoolean) And fEmptyStr(strJus_Pg) then
      LMensagem := 'A justificativa deve ser preenchida para lançar o pagamento.';

    Result := fEmptyStr(LMensagem);

    if not Result then
    begin
      fMensagem('Atenção!', LMensagem + #13 + 'Preencha os dados do pagamento corretamente e confirme.', ['&Ok']);
      LSaiuDaTelaSemConfirmar := not fDigDadosPagamentos;
    end;

  until Result or LSaiuDaTelaSemConfirmar;
end;

function TfrmRcxResumoCaixa.fDigDadosPagamentos: Boolean;
  Var
    frmRcxDigPagamento : TfrmRcxDigPagamento;
begin
  strCodFor := '';
  strCta_Pg := '';
  strCodEve := '';
  strJus_Pg := '';
  Result := False;

  Try
    Try
      pCriarFormularios(TfrmRcxDigPagamento, frmRcxDigPagamento);
      frmRcxDigPagamento.blnValidaDespesasEventos:= (fCfgSis('METPED', varString) = '5') Or
                                                    (fCfgSis('METPED', varString) = '6');
      frmRcxDigPagamento.blnResCx := True;
      frmRcxDigPagamento.ShowModal;

      Result := frmRcxDigPagamento.blnConfirma;
      If (Result) Then
      Begin
        lsvLancamentos.Enabled := False;
        strCodFor := frmRcxDigPagamento.edtCodFor.Text;
        strCta_Pg := frmRcxDigPagamento.fraPlanoDeContas.mskCodCta.Text;
        strCodEve := frmRcxDigPagamento.fraCentroCusto.edtCodEve.Text;
        strJus_Pg := frmRcxDigPagamento.edtJustificativa.Text;

        pSetFocus(edtNumDoc);
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[frmRcxResumoCaixa.fDigDadosPagamentos]');
    End;
  Finally
    pFreeAndNil(frmRcxDigPagamento);

    If (Not Result) Then
    Begin
      pFocarElemento;
      edtCodCli.Enabled := True;
      mskDtaIni.Enabled := True;
      mskDtaFin.Enabled := True;
    End;
  End;
end;

{*********************************************}
{* VALIDA O VALOR DIGITADO EM UMA MODALIDADE *}
{******************************************MV*}
function TfrmRcxResumoCaixa.fValidaValorMod(fltValRec,
  fltValDoc: Double): Boolean;
begin
  Result := True;

  If (fltValDoc < 0.0) And (fltValRec > 0.0) Then
  Begin
    fMensagem('', 'O valor do recebimento deve ser negativo!', ['&Ok']);
    Result := False;
  End
  Else If (fltValDoc > 0.0) And (fltValRec < 0.0) Then
  Begin
    fMensagem('', 'O valor do recebimento deve ser positivo!', ['&Ok']);
    Result := False;
  End;

  pCalculaVrRestante;

end;

procedure TfrmRcxResumoCaixa.pCalculaVrRestante;
var fltTotRest: Double;
begin
  If lblVrRestante.Visible Then
  Begin
    fltTotRest := fStrToFloat(edtValDoc.Text);
    fltTotRest := fltTotRest - fStrToFloat(edtDinRec.Text);
    fltTotRest := fltTotRest - fStrToFloat(edtCarRec.Text);
    fltTotRest := fltTotRest - fStrToFloat(edtOrdRec.Text);
    fltTotRest := fltTotRest - fStrToFloat(edtChqRec.Text);
    fltTotRest := fltTotRest - fStrToFloat(edtChqPre.Text);
    fltTotRest := fltTotRest - fStrToFloat(edtFinanc.Text);

    lblVrRestante.Caption := 'Vr. Restante R$ ' + FloatToStrF(Abs(fltTotRest),ffNumber,12,2);

  End;
end;

Procedure TfrmRcxResumoCaixa.pHabilitaClienteCC(blnHabilita: Boolean);
Begin
  lblClienteCC.Visible := blnHabilita;
  edtClienteCC.Visible := blnHabilita;
  edtClienteCC.Clear;
End;

procedure TfrmRcxResumoCaixa.pHideHint;
begin
  HintControler.HideHint ;
end;

procedure TfrmRcxResumoCaixa.pEditaCamposModalidades;
begin

  edtDinRec.Enabled      := blnEdiCam;
  edtCarRec.Enabled      := blnEdiCam;
  edtChqRec.Enabled      := blnEdiCam;
  edtChqPre.Enabled      := blnEdiCam;
  edtOrdRec.Enabled      := blnEdiCam;
  pnlModalidades.Enabled := blnEdiCam;

  If fCfgSis('SFPGPD', VarBoolean) And Not fEmptyStr(strFpgSelPD) And blnEdiCam Then
  Begin

    edtDinRec.Enabled := True;

    If fCfgSis('LIBFPB', VarBoolean) then
    begin

      edtCarRec.Enabled    := ((strFpgSelPD = '007') or (strFpgSelPD = '006') or (strFpgSelPD = '002'));
      edtChqRec.Enabled    := ((strFpgSelPD = '006') or (strFpgSelPD = '002'));
      edtChqPre.Enabled    := strFpgSelPD = '002';
      edtOrdRec.Enabled    := strFpgSelPD = '012';

      if (strFpgSelPD = '002') then
        pnlInfo.Caption := 'Será permitido receber em cheque a prazo, cheque à vista, cartão e dinheiro!';

      if (strFpgSelPD = '006')then
        pnlInfo.Caption := 'Será permitido receber em cheque á vista, cartão e dinheiro!';

      if (strFpgSelPD = '007') then
        pnlInfo.Caption := 'Será permitido receber em cartão e dinheiro!';

    end
    Else
    If (strFpgSelPD = '008') Then
    Begin
      edtCarRec.Enabled    := False;
      edtChqRec.Enabled    := True;
      edtChqPre.Enabled    := False;
      edtOrdRec.Enabled    := True;
    End
    Else
    If fPos(strFpgSelPD, '001_002_006_007_012_') Then
    Begin
      edtCarRec.Enabled    := strFpgSelPD = '007';
      edtChqRec.Enabled    := strFpgSelPD = '006';
      edtChqPre.Enabled    := strFpgSelPD = '002';
      edtOrdRec.Enabled    := strFpgSelPD = '012';
    End;

  End;

  pCalculaVrRestante;

end;

function TfrmRcxResumoCaixa.PermiteLancamentoNoCaixaAtual(const AEspecieDocumento : String; const ATipoFechamento : String): Boolean;
var
  LUltimoFechamentoFloat: Double;
  LUltimoFechamentoDate: TDateTime;
begin
  Result := True;

  if ATipoFechamento.Equals('C') then
    Exit;

  if Trim(AEspecieDocumento) <> 'FC' then
  begin
    pRetornaUltimoFechamento(LUltimoFechamentoFloat, LUltimoFechamentoDate );

    If (LUltimoFechamentoDate = VS_Date) Then
    Begin
      Result := False;
      fMensagem('', 'O caixa está fechado no dia de hoje. Não é possível realizar o Lançamento!', ['&Ok']);
      Exit;
    End;
  end;
end;

function TfrmRcxResumoCaixa.fGravar: Boolean;
  Var
    fltValTra: Double;
    fltTotGerTmp: Double;

    blnConfirma : Boolean;

    fltDinRec: Double;
    fltCarRec: Double;
    fltChqRec: Double;
    fltChqPre: Double;
    fltOrdRec: Double;
    fltDifVal: Double;
    fltTotInf: Double;
    fltValTroco : Double;

    strDescriOp: String;
    arrModalidades: TArrModalidade;
    intCnt : integer;

    LCaixaJaFechado : Boolean;
    LSaldoFechamento : Double;
    LDataLancamento: TDateTime;

    {*****************************************}
    {* VERIFICA SE A DUPLICATA EXISTE NO     *}
    {* CADREC/X. MOTIVO: PODE TER SIDO CONF. *}
    {**************************************AF*}
    function fDuplicataCtrExiste(strNumDup,
                                 strParcel,
                                 strEspDoc,
                                 strCodEmp,
                                 strCodCli: String;
                                 intSeqBai: Integer): Boolean;
      Var
        strSQL: String;
        qryGenRec: TUniQuery;

    begin
      Try

        qryGenRec := fCriaQuery;

        Result := False;
        strSQL := '';
        strSQL := strSQL + 'SELECT ';
        strSQL := strSQL + '  CTR_DTAREC AS DTAREC ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  CADREC ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
        strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
        strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
        strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
        strSQL := strSQL + '  CTR_SEQBAI = :SEQBAI ';

        With qryGenRec Do
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

          If Not IsEmpty Then
            Result := True;

          Close;
        End;

      Except
        On E: Exception Do
        Begin
          FreeAndNil(qryGenRec);
          Raise Exception.Create(e.Message);
        End;
      End;

      FreeAndNil(qryGenRec);
    end;

begin
  inherited;

  Result := False;

  If (pgcDadosGerais.ActivePage = tbsLancamentos) And (Not fEmptyStr(strEspDoc)) And (strEspDoc <> 'TF') Then
  Begin
    Result := fVerificaAcessoSistema('DIRRCX' + strEspDoc, edtCodOpe.Text);

    {*****************************************}
    {* CASO O OPERADOR ATUAL NÃO TENHA DIREI-*}
    {* TO, PEDE SENHA.                       *}
    {**************************************MV*}
    If (Not Result) And (Not fEmptyStr(fCfgSis('SELCRC'))) Then
    Begin
      arrModalidades := fGetModalidadesDigitadas;

      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Lançamentos no resumo de caixa. (' + strEspDoc + ')');
      objLiberacao.objMsgLibera.pAddSeparador(90);
      objLiberacao.objMsgLibera.pAddTexto(strEspDoc + '-' + edtDesOpc.Text, alCentro, teAmbos, '', 90);
      objLiberacao.objMsgLibera.pAddSeparador(90);
      objLiberacao.objMsgLibera.pAddTextoCaption('Documento'         , edtNumDoc.Text                                                    , 18);
      objLiberacao.objMsgLibera.pAddTextoCaption('Valor'             , 'R$ ' + FloatToStrF(fStrToFloat(edtValDoc.Text), ffNumber, 12, 2) , 18);

      For intCnt := Low(arrModalidades) To High(arrModalidades) Do
      Begin
        If intCnt = Low(arrModalidades) Then
          objLiberacao.objMsgLibera.pAddTextoCaption('Mod.de Pagamento', fPadR(arrModalidades[intCnt].strDesmod + ':', 20) + FloatToStrF(arrModalidades[intCnt].fltValMod, ffFixed, 11, 2), 18)
        Else
          objLiberacao.objMsgLibera.pAddTextoCaption('                ', fPadR(arrModalidades[intCnt].strDesmod + ':', 20) + FloatToStrF(arrModalidades[intCnt].fltValMod, ffFixed, 11, 2), 18);
      End;

      objLiberacao.objMsgLibera.pAddTextoCaption('Histórico'         ,  edtDescri.Text                                                   , 18);
      If (strEspDoc = 'PG') Then
      Begin
        objLiberacao.objMsgLibera.pAddTextoCaption('Fornecedor:'     ,  strCodFor +'-'+ fRetNomFornecedor(strCodFor)                     , 18);
        objLiberacao.objMsgLibera.pAddTextoCaption('Plano de Contas:',  strCta_Pg +'-'+ fRetNomeConta(strCta_Pg)                         , 18);
        objLiberacao.objMsgLibera.pAddTextoCaption('Centro de Custos:', strCodEve +'-'+ fRetNomEvento(strCodEve)                         , 18);
        If (fCfgSis('JUSPGT') = 'S') Then
           objLiberacao.objMsgLibera.pAddTextoCaption('Justificativa:', strJus_Pg                                                           , 18);
      End;
      objLiberacao.objMsgLibera.pAddTextoCaption('Operador do Caixa' ,  edtCodOpe.Text + '-' + edtNomOpe.Text                           , 18);
      objLiberacao.objMsgLibera.pAddSeparador(90);

      objLiberacao.strDirAce := 'DIRRCX' + strEspDoc;
      objLiberacao.strSenLib := fCfgSis('SELCRC');
      objLiberacao.strMsgSen := 'Lançamentos no resumo de caixa. (' + strEspDoc + ')';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := edtCodOpe.Text;
      objLiberacao.strCodDig := edtCodOpe.Text;

      If (Not objLiberacao.fLibera) Then
      Begin
        Result := False;
      End
      Else
        Result := True;
    End;

    If (Not Result) Then
    Begin
      fMensagem('ATENÇÃO!', 'Você não tem direitos para usar essa espécie!', ['&Ok']);
      Exit;
    End;
  End;

  If TFuncoesPixAutcom.DeveReceberOrdemDePagamentoComQRCodePix(fStrToFloat(edtOrdRec.Text),
                                                               FObjetoPixRecebimento) Then
  Begin
    fMensagem('ATENÇÃO', 'Recebimento do QRCode Pix é obrigatório na utilização da modalidade Ordem de Pagamento.', ['&Ok']);
    Exit;
  End;

  pHabilitaClienteCC(FALSE);

  btnGravar.Enabled := False;

  try
    If (pgcDadosGerais.ActivePage = tbsRecebimentos) Then
    Begin
      If (Not cdsTmpResumoCaixa.Active) Or (cdsTmpResumoCaixa.IsEmpty) Then
      Begin
        fMensagem('', 'É necessário selecionar uma ou mais duplicatas para prosseguir!', ['&Ok']);
        log('É necessário selecionar uma ou mais duplicatas para prosseguir');
        pFocarElemento;
        Exit;
      End;
    End
    Else If (pgcDadosGerais.ActivePage = tbsLancamentos) Then
    Begin
      If (fEmptyStr(strEspDoc)) Then
      Begin
        fMensagem('', 'É necessário selecionar uma espécie para prosseguir!', ['&Ok']);
        log('É necessário selecionar uma espécie para prosseguir!');
        pFocarElemento;
        Exit;
      End;

      strDescri := edtDescri.Text;
    End;

    If (Not fVerificaCampos) Then
    Begin
      log('entrou no If Not VerificaCampos do botao Gravar');
      Exit;
    End;

    If (edtChqRec.Text <> '0,00') And (fCfgSis('CHQRCX', varBoolean)) And (fCfgSis('CHQVIS', varBoolean)) Then
    Begin

      log('Cheque a vista preenchido....');
      If Not cdsChqVis.IsEmpty Then
      Begin
        If Not fChequesCadastrados(fStrToFloat(edtChqRec.Text), False) Then
        Begin
          fMensagem('','O valor dos cheques a vista cadastrados difere do valor digitado!!!',['&OK']);
          log('O valor dos cheques a vista cadastrados difere do valor digitado!!!');
          pSetFocus(edtChqRec);
          Exit;
        End;
      End
      Else If (Pos(strEspDoc, 'LD_PG') <= 0) Then
      Begin
        fMensagem('','É necessário digitar os cheques!',['&OK']);
        log('É necessário digitar os cheques!');
        pSetFocus(edtChqRec);
        Exit;
      End;

    End;

    If (edtChqPre.Text <> '0,00') And (fCfgSis('CHQRCX', varBoolean)) Then
    Begin
      log('Cheque pre preenchido...');
      If Not cdsChqPre.IsEmpty Then
      Begin
        If Not fChequesCadastrados(fStrToFloat(edtChqPre.Text), True) Then
        Begin
          fMensagem('','O valor dos cheques a prazo cadastrados difere do valor digitado!!!',['&OK']);
          log('O valor dos cheques a prazo cadastrados difere do valor digitado!!!');
          pSetFocus(edtChqPre);
          Exit;
        End;
      End
      Else If (Pos(strEspDoc, 'LD_PG') <= 0) Then
      Begin
        fMensagem('','É necessário digitar os cheques!',['&OK']);
        log('É necessário digitar os cheques!');
        pSetFocus(edtChqPre);
        Exit;
      End;

    End;

    If fCfgSis('DIGCAR') = 'S' Then
    Begin
      If (edtCarRec.Text <> '0,00') Then
      Begin
        log('Cartão preenchido...');

        If (Pos(strEspDoc, 'LD_PG') <= 0)                         And
           (Not fCartoesCadastrados(fStrToFloat(edtCarRec.Text))) Then
        Begin
          fMensagem('','O valor dos cartões cadastrados difere do valor digitado!!!',['&OK']);
          log('O valor dos cartões cadastrados difere do valor digitado!!!');
          pSetFocus(edtCarRec);
          Exit;
        End;

      End;

    End;

    blnChamaCadastro := False;

    If (Not fValidaCampos(edtDinRec, True)) Then
    Begin
      log('Entrou no If (Not fValidaCampos(edtDinRec, True)) Then');
      Exit;
    End;

    If (Not fValidaCampos(edtCarRec, True)) Then
    Begin
      log('Entrou no If (Not fValidaCampos(edtCarRec, True)) Then');
      Exit;
    End;

    If (Not fValidaCampos(edtChqRec, True)) Then
    Begin
      log('Entrou no If (Not fValidaCampos(edtChqRec, True)) Then');
      Exit;
    End;

    If (Not fValidaCampos(edtChqPre, True)) Then
    Begin
      log('Entrou no If (Not fValidaCampos(edtChqPre, True)) Then');
      Exit;
    End;

    If (Not fValidaCampos(edtOrdRec, False)) Then
    Begin
      log('Entrou no If (Not fValidaCampos(edtOrdRec, False)) Then');
      Exit;
    End;

    If fStrToFloat(edtChqRec.Text) = 0 Then
        If cdsChqVis.Active Then cdsChqVis.EmptyDataSet;

    If fStrToFloat(edtChqPre.Text) = 0 Then
      If cdsChqPre.Active Then cdsChqPre.EmptyDataSet;

    blnChamaCadastro := True;

    fltDinRec := fStrToFloat(edtDinRec.Text);
    fltCarRec := fStrToFloat(edtCarRec.Text);
    fltChqRec := fStrToFloat(edtChqRec.Text);
    fltChqPre := fStrToFloat(edtChqPre.Text);
    fltOrdRec := fStrToFloat(edtOrdRec.Text);

    fltDifVal := 0.0;
    fltValCre := 0.0;
    fltValTroco := 0.0;

    fltValTra    := IIF(fltValDoc < 0.0, -fltValDoc, fltValDoc);
    fltTotGerTmp := fltDinRec + fltCarRec + fltChqRec + fltChqPre + fltOrdRec;
    If (strEspDoc = 'PG') Then
    Begin
      fltTotGerTmp := fltTotGerTmp + fltValJur + fltValCob - fltDesRec;
    End;

    If (fFormataFloat(fltTotGerTmp, 2) <> fFormataFloat(fltValTra, 2)) Then
    Begin

      log('Valor digitado difere do total...');
      {*******************************************}
      {* CASO NÃO TENHA ITENS NA TEMPORARIA      *}
      {****************************************MV*}
      If (cdsTmpResumoCaixa.IsEmpty) Then
      Begin

        If (fFormataFloat(fltTotGerTmp, 2) <> fFormataFloat(fltValTra, 2)) Then
        Begin
          log('Temporaria não tem itens....');
          fMensagem('ATENÇÃO!', 'A soma dos valores digitados tem que ser ' + #13#10 +
                                'igual ao valor do documento!' + #13#10 +
                                'Valor do Documento: ' + FloatToStrF(fltValDoc, ffFixed, 12, 2) + #13#10 +
                                'Valor digitado: ' + FloatToStrF(fltTotGerTmp, ffFixed, 12, 2), ['&Ok']);
          If (edtDinRec.Enabled) And (pnlModalidades.Enabled) Then
          Begin
            pSetFocus(edtDinRec);
          End;
          Exit;
        End;

      End
      Else
      Begin
        log('Temporaria tem itens....!!!!');
        If (fFormataFloat(fltTotGerTmp, 2) < fFormataFloat(fltValTra, 2)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A soma dos valores digitados tem que ser ' + #13#10 +
                                'maior ou igual ao valor do documento!' + #13#10 +
                                'Valor do Documento: ' + FloatToStrF(fltValDoc, ffFixed, 12, 2) + #13#10 +
                                'Valor digitado: ' + FloatToStrF(fltTotGerTmp, ffFixed, 12, 2), ['&Ok']);
          If (edtDinRec.Enabled) And (pnlModalidades.Enabled) Then
          Begin
            pSetFocus(edtDinRec);
          End;
          Exit;
        End;

        {*******************************************}
        {* VALORES DIGITADOS ESTÃO OK!             *}
        {****************************************MV*}
        fltDifVal := fFormataFloat(fltTotGerTmp, 2) - fFormataFloat(fltValTra, 2);

        If fVerificaAcessoSistema('DIRRCXCCREC', edtCodOpe.Text) And (fMensagem('', 'Crédito?', ['&Sim', '&Não'], 2) = 1)Then
        Begin
          //Verifica se é permidigo gerar crédito para clientes inativos
          If (Not fCfgSis('RCXPCC', varBoolean)) And
             (Not cdsTmpResumoCaixa.IsEmpty)     And
             (cdsTmpResumoCaixa.Locate('CLI_STATUS;CTR_MARDES',
                                       VarArrayOf(['I', 'M']), [])) Then
          Begin
            fmensagem('ATENÇÃO', 'Não é permitido gerar Crédito (CC) para clientes inativos.', ['&OK'], 1);
            pFocarElemento;
            Exit;
          End;

          If (fCfgSis('CRELIB', varBoolean)) Then
          Begin
            If fTravarCreditoPorRecebimentoAMaior(edtCodOpe.Text,
                                                  fGetTitulosSelecionados,
                                                  True,
                                                  fltDifVal,
                                                  fGetModalidadesDigitadas) Then
            Begin
              pFocarElemento;
              Exit;
            End;
          End;

          If ((fltChqRec > 0) or (fltChqPre > 0)) Then
          Begin

             If Not fEmptyStr(edtCodRed.Text) Then
             Begin

                strCodClienteCredSel := fGetClienteSelCredito();

             End;

          End;

          log('Está dando um crédito para o cliente....');
          fltValCre := fltDifVal;
        End
        Else
        Begin

          if not (((fltChqRec+fltChqPre+fltCarRec) < fltValTra) And (fltDinRec > 0)) then
          Begin
            blnLibTroco := False;
            If (fltChqRec > 0 ) Or (fltChqPre > 0) Then
            Begin
              If Not blnTroChq Then
              Begin
                fMensagem('ATENÇÃO!', ' Troco não permitido quando utilizado a modalidade Cheque. ' + #13#10  +
                  ' A soma do valor das modalidades "' +
                  FormatFloat('#.#,0',fltTotGerTmp) +
                  '", não pode ser maior que o valor total dos documentos "' +
                  FormatFloat('#.#,0',fltValTra)+'"', ['&O k']);
                pSetFocus(edtChqRec);
                Exit;
              End
              Else
              Begin
                If (fCfgSis('TRORCX', varBoolean)) Then
                Begin
                  If fTravarTrocoUtlCartaoOuCheque(edtCodOpe.Text,
                                                   fGetTitulosSelecionados,
                                                   True,
                                                   fltDifVal,
                                                   fGetModalidadesDigitadas) Then
                  Begin
                    pFocarElemento;
                    Exit;
                  End
                  Else
                    blnLibTroco := True;
                End;
              End;
            End;

            If (fltCarRec > 0 ) Then
            Begin
              If Not blnTroCar Then
              Begin
                fMensagem('ATENÇÃO!', ' Troco não permitido quando utilizado a modalidade Cartão. ' + #13#10  +
                  ' A soma do valor das modalidades "' +
                  FormatFloat('#.#,0',fltTotGerTmp) +
                  '", não pode ser maior que o valor total dos documentos "' +
                  FormatFloat('#.#,0',fltValTra)+'"', ['&O k']);
                pSetFocus(edtCarRec);
                Exit;
              End
              Else
              Begin
                If (fCfgSis('TRORCX', varBoolean)) And Not blnLibTroco Then
                Begin
                  If fTravarTrocoUtlCartaoOuCheque(edtCodOpe.Text,
                                                   fGetTitulosSelecionados,
                                                   True,
                                                   fltDifVal,
                                                   fGetModalidadesDigitadas) Then
                  Begin
                    pFocarElemento;
                    Exit;
                  End;
                End;
              End;
            End;
          End;

          if (fFormataFloat(fltDifVal, 2) > fFormataFloat(objResumoDeCaixa.fRetornaSaldoCaixaCampo('RCX_DINREC', edtCodigoCaixa.Text), 2)) Then
          Begin
            fMensagem('', 'Saldo em caixa insuficiente para esse valor de troco!', ['&Ok']);
            Exit;
          End;

          log('Está dando um troco para o cliente!!!');
          {*******************************************}
          {* ABATE VALOR DO TROCO!                   *}
          {****************************************MV*}
          blnRetirouTrocoDinheiro := False;
          fltValTroco := fltDifVal;

          if (fltDinRec > 0) Then
          Begin
             If (fltDinRec > fltDifVal) Then
             Begin
                fltDinRec := fltDinRec - fltDifVal;
                blnRetirouTrocoDinheiro := True;
             End;
          End
          Else
             fltDinRec := 0;

        End;

      End;

      edtDinRec.Text := FloatToStrF(fltDinRec, ffFixed, 12, 2);
      edtCarRec.Text := FloatToStrF(fltCarRec, ffFixed, 12, 2);
      edtChqRec.Text := FloatToStrF(fltChqRec, ffFixed, 12, 2);
      edtChqPre.Text := FloatToStrF(fltChqPre, ffFixed, 12, 2);
      edtOrdRec.Text := FloatToStrF(fltOrdRec, ffFixed, 12, 2);

      edtTroco.Text  := FloatToStrF(fltDifVal, ffFixed, 12, 2);
    End;

    if strEspDoc = 'PG' then
      strDescriOp := 'pagamento(s)'
    else if strEspDoc = 'LD' then
     strDescriOp := 'lançamento de débito'
    else if strEspDoc = 'LC' then
      strDescriOp := 'lançamento de crédito';

    If ((strEspDoc = 'PG') or (strEspDoc = 'LD') or (strEspDoc = 'LC')) And
       (Not objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDoFechamento(edtCodigoCaixa.Text), True, False)) Then
    Begin
      pMensagemOk('Não será possível efetuar '+strDescriOp+' agora pois outra estação está realizando o fechamento do caixa!');
      Exit;
    End
    Else
      objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDoFechamento(edtCodigoCaixa.Text), False);

    If ((strEspDoc = 'PG') or (strEspDoc = 'LD') or (strEspDoc = 'LC')) And
       (Not objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDaTransferencia(edtCodigoCaixa.Text), True, False)) Then
    Begin
      pMensagemOk('Não será possível efetuar '+strDescriOp+' agora pois outra estação está realizando transferência!');
      Exit;
    End
    Else
      objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDaTransferencia(edtCodigoCaixa.Text), False);

    If ((strEspDoc = 'PG') or (strEspDoc = 'LD')) And
       (fFormataFloat(fltDinRec, 2) > fFormataFloat(objResumoDeCaixa.fRetornaSaldoCaixaCampo('RCX_DINREC', edtCodigoCaixa.Text), 2)) Then
    Begin
      fMensagem('', 'Saldo em caixa insuficiente para este '+strDescriOp+'!', ['&Ok']);
      Exit;
    End;

    If (strEspDoc = 'CC') Or
       (strEspDoc = 'LC') Or
       (pgcDadosGerais.ActivePage = tbsRecebimentos) Then
    Begin
      If Not objResumoDeCaixa.fVerificaSaldoMaximo(fltDinRec, edtCodOpe.Text, edtCodigoCaixa.Text) Then
        Exit;
    End;

    If ((-fltTotCre < fltTotRec) And (Not blnQuitacao)) Or
       ((-fltTotCre >= fltTotRec) And (fltTotRec <> 0)) Then
    Begin
      edtDinRec.Text := '0,00';
    End;

    If (fltTotCre < 0) And (fltTotRec = 0) And (FPais = opcParaguai) Then
    Begin

      fltTotDinSav := 0;
      fltTotGua := 0;
      fltTotDol := 0;
      fltTotEur := 0;
      fltTotPes := 0;
      fltTotRea := 0;

      If fDigMoedas(fltTotCre) Then
      Begin

        If fltTotGua > 0 Then
          fltTotGua := - fltTotGua;

        If fltTotDol > 0 Then
          fltTotDol := - fltTotDol;

        If fltTotEur > 0 Then
          fltTotEur := - fltTotEur;

        If fltTotPes > 0 Then
          fltTotPes := - fltTotPes;

        If fltTotRea > 0 Then
          fltTotRea := - fltTotRea;

      End
      Else
        Exit;

    End

    Else If (fltTotDinSav <> fStrToFloat(edtDinRec.Text)) And
            (FPais = opcParaguai)                         And
            (Not fDigMoedas(fStrToFloat(edtDinRec.Text))) Then
           Exit;

    If (fltDifVal > 0) And (FPais = opcParaguai) Then
    Begin

      fltTotInf := fltTotGua +
                   fConvertePrecos(fltTotEur, moeEuro) +
                   fConvertePrecos(fltTotRea, moeReal) +
                   fConvertePrecos(fltTotDol, moeDolar) +
                   fConvertePrecos(fltTotPes, moePeso);


      fltTotGua := fltTotGua + fltDinRec - fltTotInf;

    End;

    blnConfirma := fltTotGerTmp > 0;

    If Not blnConfirma Then
      blnConfirma := fltTotCre <> 0;

    log('Pergunta: Confirma?');
    If (blnConfirma) And (fMensagem('', 'Confirma?', ['&Sim', '&Não']) = 1) Then
    Begin
      if not PermiteLancamentoNoCaixaAtual(strEspDoc, objResumodeCaixa.strTipoFechamento) then
        Exit;

      If cdsTmpResumoCaixa.Active Then
      begin
        If VerificaExclusaoOuAlteracaoDeDuplicatasNoCaixa(cdsTmpResumoCaixa) Then
        Begin
          edtDinRec.Text := '0,00';
          edtCarRec.Text := '0,00';
          edtChqRec.Text := '0,00';
          edtChqPre.Text := '0,00';

          If (Not Assigned(FObjetoPixRecebimento)) Or (Not MatchStr(FObjetoPixRecebimento.Status, STATUS_PIX_PAGO)) Then
            edtOrdRec.Text := '0,00'
          Else
          Begin
            edtOrdRec.Enabled := False;
            btnReceberPix.Enabled := False;
          End;

          edtValJur.Text := '0,00';
          edtValDes.Text := '0,00';
          edtTroco.Text  := '0,00';

          If edtDinRec.Enabled Then
            pSetFocus(edtDinRec);

          pEscapePressed;

          Exit;
        End;

        cdsTmpResumoCaixa.First;
        While (Not cdsTmpResumoCaixa.Eof) Do
        Begin
          If (cdsTmpResumoCaixa.FieldByName('CTR_MARDES').AsString = 'M') Then
          begin
            objLock.fLock_Unlock('CADREC' +
                         cdsTmpResumoCaixa.FieldByName('CTR_NUMDUP').AsString +
                         cdsTmpResumoCaixa.FieldByName('CTR_ESPDOC').AsString +
                         cdsTmpResumoCaixa.FieldByName('CTR_CODEMP').AsString +
                         cdsTmpResumoCaixa.FieldByName('CTR_CODCLI').AsString +
                         cdsTmpResumoCaixa.FieldByName('CTR_PARCEL').AsString,
                         False);
          end;
          cdsTmpResumoCaixa.Next;
        end;
      end;

      objResumoDeCaixa.fRetornaUltimoFechamento(LSaldoFechamento, dtaDtaFec, edtCodigoCaixa.Text);

      LCaixaJaFechado := (dtaDtaFec >= dtaDtaCai);
      If (strTipoFechamentoCaixa = 'C') Then
      Begin
        LCaixaJaFechado := dtaDtaCai < VS_Date;

        If LCaixaJaFechado Then
          LCaixaJaFechado := objResumoDeCaixa.fNecessitaFecharCaixa(False, LDataLancamento, edtCodigoCaixa.Text, False, VS_strCodEmp);
      End;

      If LCaixaJaFechado Then
      Begin
        pFocarElemento;
        fMensagem('', 'O fechamento referente ao dia: ' + mskDiaAbe.Text + ' já foi efetuado!', ['&Ok']);
        Result := False;
        Exit;
      End;

      objResumoDeCaixa.fRetornaUltimoFechamento(LSaldoFechamento, dtaDtaFec, edtCodigoCaixa.Text);

      LCaixaJaFechado := (dtaDtaFec >= dtaDtaCai);
      If (strTipoFechamentoCaixa = 'C') Then
      Begin
        LCaixaJaFechado := dtaDtaCai < VS_Date;

        If LCaixaJaFechado Then
          LCaixaJaFechado := objResumoDeCaixa.fNecessitaFecharCaixa(False, LDataLancamento, edtCodigoCaixa.Text, False, VS_strCodEmp);
      End;

      If LCaixaJaFechado Then
      Begin
        pFocarElemento;
        fMensagem('', 'O fechamento referente ao dia: ' + mskDiaAbe.Text + ' já foi efetuado!', ['&Ok']);
        Result := False;
        Exit;
      End;

      if TravaMovimentoCaixaEmFechamento then
        Exit;

      log('Confirmou, vamos começar a gravação!!');
      If fConfirmaResumoCaixa(fltDinRec,fltCarRec,fltChqRec,fltChqPre,fltOrdRec,fltValTroco) Then
      Begin
        log('Gravou Legal!');
        pLimpaCampos;
        lsvLancamentos.Enabled := True;
        pFocarElemento;

        If cdsTmpResumoCaixa.Active Then
          cdsTmpResumoCaixa.EmptyDataSet;

        strEspDoc := '';
        pCancelarTefDeCartoesJaConfirmados;
        SetLength(arrCartoes, 0);
        lblCredito.Visible := False;
        log('Fim de uma operação!!!!!');
        log('========================');
        log('');
        Result := True;
        pZeraVariaveisResumo;

        If blnF11 Then
        Begin
          blnFecharForm := True;
          Close;
        End;
      End;
    End
    Else
    Begin
      log('Cancelou... não vai gravar!');
      edtDinRec.Text := '0,00';
      edtCarRec.Text := '0,00';
      edtChqRec.Text := '0,00';
      edtChqPre.Text := '0,00';

      If (Not Assigned(FObjetoPixRecebimento)) Or (Not MatchStr(FObjetoPixRecebimento.Status, STATUS_PIX_PAGO)) Then
        edtOrdRec.Text := '0,00'
      Else
      Begin
        edtOrdRec.Enabled := False;
        btnReceberPix.Enabled := False;
      End;

      edtValJur.Text := '0,00';
      edtValDes.Text := '0,00';
      edtTroco.Text  := '0,00';
      lblCredito.Visible := False;

      fltTotGua := 0;
      fltTotDol := 0;
      fltTotEur := 0;
      fltTotPes := 0;
      fltTotRea := 0;
      fltTotDinSav := 0;

      If edtDinRec.Enabled Then
        pSetFocus(edtDinRec);
    End;

    strCodEve := '';
    log('Apagando as temporarias de cheque!');
    cdsChqPre.EmptyDataSet;
    cdsChqVis.EmptyDataSet;
    log('Apagou!!! As temporarias de cheque!');

    fltTotDinSav := 0;
    fltTotGua := 0;
    fltTotDol := 0;
    fltTotEur := 0;
    fltTotPes := 0;
    fltTotRea := 0;
  finally
    btnGravar.Enabled := True;
  end;
end;

function TfrmRcxResumoCaixa.fGetCliIFOrDocs(strNumDoc, strCodEmp, strEspDoc: String): String;

  function fGetSQLCliIFOrDocs(strTabela: String): String;
  begin
    Result :=          '  SELECT GER_CODCLI '  ;
    Result := Result + '    FROM ' + strTabela ;
    Result := Result + '   WHERE GER_NUMDOC = :NUMDOC ' ;
    Result := Result + '     AND GER_ESPDOC = :ESPDOC ' ;
    Result := Result + '     AND GER_CODEMP = :CODEMP ' ;
  end;

  Var
    qryCupom : TUniQuery;
    intCnt   : Integer;
  Const
    arrMovNot: Array [1..2] Of String = ('MOVGER', 'NOTGER');
begin
  qryCupom := fCriaQuery(Nil);

  With qryCupom Do
  Begin
    For intCnt := Low(arrMovNot) To High(arrMovNot) Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLCliIFOrDocs(arrMovNot[intCnt]));
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('ESPDOC').AsString := strEspDoc;
      Open;

      Result := FieldByName('GER_CODCLI').AsString;

      If Not fEmptyStr(Result) Then
        Break;
    End;
    Close;
  End;

  FreeAndNil(qryCupom);
end;

function TfrmRcxResumoCaixa.fGetDescricaoTransferencia(strTipoTF: String): String;
  Var
    strCodigoCaixa : String;
begin
  strCodigoCaixa := '';
  Result := 'TF CAIXA ('+strTipoTF+') - ';
  If (strTipoFechamentoCaixa = 'C') Then
  Begin
    strCodigoCaixa := Trim(edtCodigoCaixa.Text);
    Result := 'TF CAIXA '+strCodigoCaixa+' ('+strTipoTF+') - '
  End;
end;

{************************************}
{* GRAVA CHEQUES CARREGADOS NA TEMP *}
{*********************************AF*}
function TfrmRcxResumoCaixa.fGravaCheques(intSeqBai: Integer): Boolean;
  Var
    fltValIpi,
    fltValRet,
    fltValAce,
    fltValFre,
    fltValCbs,
    fltValIbs,
    fltVal_Is: Double;
Begin
  Try

    Result := True;

    If cdsChqPre.Locate('CHQ_CODBCO;CHQ_NUMAGE;CHQ_CONCOR;CHQ_NUMCHQ',
      VarArrayOf([cdsChqVis.FieldByName('CHQ_CODBCO').AsString,
                  cdsChqVis.FieldByName('CHQ_NUMAGE').AsString,
                  cdsChqVis.FieldByName('CHQ_CONCOR').AsString,
                  cdsChqVis.FieldByName('CHQ_NUMCHQ').AsString]), []) Then
    Begin
      fMensagem('ATENÇÃO!', 'O mesmo cheque está sendo cadastrado para o Cheque a Vista e para o Cheque Pré.', ['&Ok']);
      Result := False;
      Exit;
    End;

    With cdsChqPre Do
    Begin

      If (Active) And (Not IsEmpty) Then
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
                                 untCadRcxx.strDocChq + 'PRZ',
                                 'N',
                                 FieldByName('CHQ_DTACAD').AsDateTime,
                                 FieldByName('CHQ_DTAVEN').AsDateTime,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 FieldByName('CHQ_VALCHQ').AsFloat,
                                 '',
                                 intSeqCon,
                                 VS_strCodEmp,
                                 1,
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
                                 edtCodigoCaixa.Text,
                                 '',
                                 '',
                                 fltValCbs,
                                 fltValIbs,
                                 fltVal_Is);

          {******************}
          {* GRAVA O LOGCHQ *}
          {***************JU*}
          If Result Then
            Result := fLogChq(cdsChqPre, 1);

          If Assigned(objProrrogacao) Then
          Begin
            objProrrogacao.pAdicionarChequeNoArrayProrrogacao(cdsChqPre,cdsChqPre.RecNo);
          End;
          Next;
        End;

      End;

    End;

   {************************************}
   {* CHEQUE A VISTA                   *}
   {*********************************AF*}
    With cdsChqVis Do
    Begin

      If (Active) And (Not IsEmpty) Then
      Begin

        cdsChqVis.First;

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
                    fGravaCheque( FieldByName('CHQ_CODBCO').AsString,
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
                                  untCadRcxx.strDocChq + 'AVI',
                                  'N',
                                  FieldByName('CHQ_DTACAD').AsDateTime,
                                  FieldByName('CHQ_DTAVEN').AsDateTime,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  FieldByName('CHQ_VALCHQ').AsFloat,
                                  '',
                                  intSeqCon,
                                  VS_strCodEmp,
                                  1,
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
                                  edtCodigoCaixa.Text,
                                  '',
                                  '',
                                  fltValCbs,
                                  fltValIbs,
                                  fltVal_Is);

            {******************}
            {* GRAVA O LOGCHQ *}
            {***************JU*}
            If Result Then
              Result := fLogChq(cdsChqVis, 2);

          Next;
        End;

      End;

    End;

  Except
    On E: Exception Do
    Begin
      log('Erro ao gravar o cheque: ' + E.Message);
      pMensagensErro(E.Message, '[fGravaCheques]');
      Result := False;
    End;
  End;

End;

procedure TfrmRcxResumoCaixa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If Assigned(cdsImpRecCG) Then
    FreeAndNil(cdsImpRecCG);

  pCancelarTefDeCartoesJaConfirmados;

  If Not ValidarSeExistePixRecebidoSemConfirmacao Then
  Begin
    Action := CaNone;
    Exit;
  End;

  If Assigned(cdsImpRec) Then
    FreeAndNil(cdsImpRec);

  If (Assigned(cdsChqVis)) And (cdsChqVis.Active) Then
    cdsChqVis.EmptyDataSet;

  If (Assigned(cdsChqPre)) And (cdsChqPre.Active) Then
    cdsChqPre.EmptyDataSet;

  If (Assigned(cdsTmpResumoCaixa)) And (cdsTmpResumoCaixa.Active) Then
    cdsTmpResumoCaixa.EmptyDataSet;

  If Assigned(stlContratos) Then
    FreeAndNil(stlContratos);

  FreeAndNil(stlForPag);
  FreeAndNil(stlCndPag);

  if Assigned(qryRecNBai) then
    FreeAndNil(qryRecNBai);

  If Assigned(FQryCnd15V) Then
    FreeAndNil(FQryCnd15V);

  If Assigned(objProrrogacao) Then
    FreeAndNil(objProrrogacao);

  VS_strCodigoOperadorLogadoCaixa := '';

  FreeAndNil(objResumoDeCaixa);
end;

procedure TfrmRcxResumoCaixa.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if not fVerificaTefCitelPendente then
    CanClose := True
  else
  begin
    CanClose := False;
    pHideHint ;
    if fMensagem('', 'Deseja cancelar os cartões ja confirmados?', ['&Sim', '&Não'], 2) = 1 then
    begin
      CanClose := True;
      If Not fVerificaAcessoSistema('RCXCANCTEF', edtCodOpe.Text) Then
      Begin
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddTexto('Cancelamento de cartões já confirmados no F2- Recebimento.');

        objLiberacao.strDirAce := 'RCXCANCTEF';
        objLiberacao.strMsgSen := 'Cancelamento de cartões';
        objLiberacao.blnMosMen := True;
        objLiberacao.strCodOpe := edtCodOpe.Text;
        objLiberacao.strCodDig := edtCodOpe.Text;


        If (Not objLiberacao.fLibera) Then
          CanClose := False;
      End;
    end;
  end;
end;

procedure TfrmRcxResumoCaixa.pEscapePressed;
begin
  pEscPressionado(ActiveControl);
end;

procedure TfrmRcxResumoCaixa.pEscPressionado(Sender: TWinControl);
begin
  log('Pressionou Esc...');
  If (Assigned(Sender)) And (Assigned(Sender.Parent)) And (Sender.Parent = pnlModalidades) Then
  Begin
    log('Estava em cima do pnlModalidades');

    edtDinRec.Text := '0,00';
    edtCarRec.Text := '0,00';
    edtChqRec.Text := '0,00';
    edtChqPre.Text := '0,00';

    If (Not Assigned(FObjetoPixRecebimento)) Or (Not MatchStr(FObjetoPixRecebimento.Status, STATUS_PIX_PAGO)) Then
      edtOrdRec.Text := '0,00'
    Else
    Begin
      edtOrdRec.Enabled := False;
      btnReceberPix.Enabled := False;
    End;

    edtValJur.Text := '0,00';
    edtValDes.Text := '0,00';
    edtTroco.Text  := '0,00';

    fltTotGua := 0;
    fltTotDol := 0;
    fltTotEur := 0;
    fltTotPes := 0;
    fltTotRea := 0;
    fltTotDinSav := 0;

    stlContratos.Clear;

    pZeraVariaveisResumo;

    pnlDocumento.Enabled   := True;
    lsvLancamentos.Enabled := True;
    pHabilitaClienteCC(FALSE);
    pFocarElemento;
  End
  Else If (Assigned(Sender)) And (Sender = edtNumDoc) Then
  Begin
    log('estava em cima do edtNumDoc');
    lsvLancamentos.Enabled := True;
    pHabilitaClienteCC(FALSE);
    pSetFocus(lsvLancamentos);
    pZeraVariaveisResumo;
  End
  Else If (Assigned(Sender)) And (Assigned(Sender.Parent)) And (Sender.Parent = pnlDocumento) Then
  Begin
    log('estava em cima do pnlDocumento');
    lsvLancamentos.Enabled := True;
    pHabilitaClienteCC(FALSE);
    pSetFocus(lsvLancamentos);
    pZeraVariaveisResumo;
  End
  Else
  Begin
    inherited;
  End;
end;

procedure TfrmRcxResumoCaixa.edtDinRecEnter(Sender: TObject);
begin
  inherited;
  pnlDocumento.Enabled := False;
  if (TEditFocus(Sender) = edtCarRec) and (fStrToFloat(edtCarRec.Text) = 0.00) then
    pShowHint(edtCarRec, 'Em caso de um ou mais cartões, sempre informar o valor total!') ;
end;

procedure TfrmRcxResumoCaixa.edtDinRecExit(Sender: TObject);
begin
  inherited;
  pnlDocumento.Enabled := True;
  if TEditFocus(Sender) = edtCarRec then
    pHideHint ;
end;

procedure TfrmRcxResumoCaixa.edtOrdRecChange(Sender: TObject);
  Var
    LValorValido: Boolean;
begin
  inherited;
  LValorValido := Not fEmptyStr(edtOrdRec.Text);
  If LValorValido Then
  Begin
    LValorValido := fStrToFloat(edtOrdRec.Text) > 0;

    If LValorValido Then
      LValorValido := MatchStr(strEspDoc, ['', 'CC', 'LC']);
  End;

  chkPixAvulso.Enabled := LValorValido;
  If Not chkPixAvulso.Enabled Then
    chkPixAvulso.Checked := False;

  If btnReceberPix.Visible Then
  Begin
    If Not chkPixAvulso.Checked Then
      btnReceberPix.Enabled := LValorValido;
  End;
end;

function TfrmRcxResumoCaixa.fCodOpeTransf(frmRcxTrasfValores: TfrmRcxTrasfValores): String;
begin
  Result := edtCodOpe.Text;
  If objResumoDeCaixa.TransferenciaVinculada Then
  Begin
    if Assigned(frmRcxTrasfValores) Then
    Begin
      If (Not fEmptyStr(frmRcxTrasfValores.edtCodVendedor.Text)) Then
        Result := frmRcxTrasfValores.edtCodVendedor.Text;
    End;
  End;
end;

function TfrmRcxResumoCaixa.fConfirmaResumoCaixa(fltDinRec, fltCarRec, fltChqRec, fltChqPre, fltOrdRec, fltValTroco_: Double): Boolean;
  Var
    strCodCli: String;
    strDifVal: String;

    strSeqLan: String;
    strNumDoc: String;
    fltValAux: Double;
    fltValCtb: Double;
    fltValAba: Double;
    fltNovoValOri: Double;
    fltDifOri: Double;
    strHisCar: String;
    strCtaBai: String;
    strTipCta: String;

    blnGraVDp: Boolean;
    blnParcia: Boolean;

    strCodCar: String;
    strDesCar: String;
    fltValTot: Double;
    strConPag: String;
    strNumCcd: String;
    strHisTor: String;
    fltPerCar: Double;
    fltValDes: Double;
    dtaDatTra: TDateTime;

    intContador1: Integer;
    intContador2: Integer;
    intContCopia: Integer;
    intQtdPar   : Integer;

    strPortadorCred: String;
    strEventoCred: String;

    intSeqBai: Integer;

    dtaDtaVen: TDateTime;
    {***************************************}
    {* VARIÁVEL C/ O SEQBAI DE CADA DUPLIC.*}
    {************************************MV*}
    stlSeqBai: TStringList;

    fltGraCqP,
    fltGraCqV,
    fltGraDin,
    fltGraCar,
    fltGraOrd,

    fltGrCqP2,
    fltGrCqV2,
    fltGrDin2,
    fltGrCar2,
    fltGrOrd2,

    fltTotCqP,
    fltTotCqV,
    fltTotDin,
    fltTotCar,
    fltTotOrd,

    fltAuxCqP,
    fltAuxCqV,
    fltAuxDin,
    fltAuxCar,
    fltAuxOrd,

    fltCarIpi,
    fltCarRet,
    fltCarAce,
    fltCarFre,
    fltCarCbs,
    fltCarIbs,
    fltCar_Is: Double;
    strNumDup    : String;

    arrDuplicCarIpi,
    arrDuplicCarRet,
    arrDuplicCarAce,
    arrDuplicCarFre,
    arrDuplicCarCbs,
    arrDuplicCarIbs,
    arrDuplicCar_Is,
    arrDuplOri,
    arrDuplicata   : TArrDigDuplicArray;

    cdsRateio: TUniClientDataSet;
    intQtdDup   : Integer;
    intTotDup   : Integer;

    //strNumDup    : String;
    strTipCar    : String;
    strNumNsu    : String;
    strAutIncNov : String;
    blnGerouLib  : Boolean;
    strCodCliCartao: String;
    strUltIndice : String;

    fltValorCalculado: Double;
    fltJurosCalculado: Double;

    lstBanCtp : TBanCtpRepository;

    strInfConfCar : String;

    objArredondaParcela: IArredondaParcela;

    strNumSer : String;
    blnErroConfirmacao : Boolean;

    strChaPix : String;
    strPixS_N : String;
    strCodigoCarteiraDigital : String;
    LstrControle: String ;

    QryTefTra : TUniQuery;

    LPlanoDeContasComissaoProfissionais: String;

    LDadosPagamentoPix: TDadosRetornoPixConsulta;

    LRecebidoPorPix: String;

    LGravarRegistroPix: Boolean;

    LSeqConTransferenciaOrdPgto : Integer;

    strCodCliMB : String;
    blnCliDif   : boolean;
    LPortadorTFAutomatica : String;

    LDataBaseCartao: TDateTime;
    LTipoParcelamento: String;

    blnDescCobFoiAlterada: Boolean;

    LPortadorCadRec: String;

    AAutoIncremStr: String;

    LblnGravouCartaoTEF: Boolean ;

    APortadorTfDesmembCadRec : String;
    LPixDao: TPixDao;
    LDesmembrarBaixaReceber : TDesmembraBaixaReceber;
    LSomaModalidades : Double;
    strAutIncCadRecCredito : String;

    LOperadorFechamento: String;
    LDataHoraInicioBaixa: TDateTime;

    procedure pRateiaVariaveisModalidades;
      Var
        fltDiferenca: Double;
    begin
      fltGraCqP := fltChqPre;
      fltGraCqV := fltChqRec;
      fltGraDin := fltDinRec;
      fltGraCar := fltCarRec;
      fltGraOrd := fltOrdRec;

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
          fltGraCqP := fRateioRec(fltTotRec+fltDiferenca, fStrToFloat(edtValDoc.Text), fltChqPre);
          fltGraCqV := fRateioRec(fltTotRec+fltDiferenca, fStrToFloat(edtValDoc.Text), fltChqRec);
          fltGraDin := fRateioRec(fltTotRec+fltDiferenca, fStrToFloat(edtValDoc.Text), fltDinRec);
          fltGraCar := fRateioRec(fltTotRec+fltDiferenca, fStrToFloat(edtValDoc.Text), fltCarRec);
          fltGraOrd := fRateioRec(fltTotRec+fltDiferenca, fStrToFloat(edtValDoc.Text), fltOrdRec);
        End;
      End;

      With cdsTmpResumoCaixa Do
      Begin
        fltAuxCqP := fRateioRec(fStrToFloat(edtValDoc.Text), FieldByName('CTR_VALREC').AsFloat, fltGraCqP);
        fltAuxCqV := fRateioRec(fStrToFloat(edtValDoc.Text), FieldByName('CTR_VALREC').AsFloat, fltGraCqV);
        fltAuxDin := fRateioRec(fStrToFloat(edtValDoc.Text), FieldByName('CTR_VALREC').AsFloat, fltGraDin);
        fltAuxCar := fRateioRec(fStrToFloat(edtValDoc.Text), FieldByName('CTR_VALREC').AsFloat, fltGraCar);
        fltAuxOrd := fRateioRec(fStrToFloat(edtValDoc.Text), FieldByName('CTR_VALREC').AsFloat, fltGraOrd);
      End;

      fltTotCqP := fltTotCqP + fltAuxCqP;
      fltTotCqV := fltTotCqV + fltAuxCqV;
      fltTotDin := fltTotDin + fltAuxDin;
      fltTotCar := fltTotCar + fltAuxCar;
      fltTotOrd := fltTotOrd + fltAuxOrd;
    end;

begin
  strAutIncCadRecCredito := '';
  strCodigoCarteiraDigital := '' ;
  LstrControle := '' ;
  Result := True;
  blnGerouLib := False;

  cdsRateio     := fCriaCdsRateio(Nil);
  LDesmembrarBaixaReceber := TDesmembraBaixaReceber.Create;

  fltNovoValOri := 0;

  fltTotCqP := 0;
  fltTotCqV := 0;
  fltTotDin := 0;
  fltTotCar := 0;
  fltTotOrd := 0;

  fltAuxCqP := 0;
  fltAuxCqV := 0;
  fltAuxDin := 0;
  fltAuxCar := 0;
  fltAuxOrd := 0;
  strNumDoc := '';
  strNumDup := '';
  LPortadorTFAutomatica := '';
  LSomaModalidades := 0;

  LSeqConTransferenciaOrdPgto := 0;

  strCodCliMB := '';
  blnCliDif   := False;
  AAutoIncremStr := '';

  {****************************************************}
  {* VERIFICA SE O CLIENTE P\ GRAVACAO DE CARTAO (LC) *}
  {* ESTA CADASTRADO NA CONFIGURACAO                  *}
  {*************************************************JB*}
  If (Pos(strEspDoc, 'LC_') > 0) And
     ( fEmptyStr(fCfgSisL('CLIRCX')) Or fEmptyStr(fRetNomCliente(fCfgSisL('CLIRCX'))) ) And
     (fltCarRec > 0)                Then
  Begin
    fMensagem('ATENÇÃO!', 'Por favor, para concluir essa operação cadastre um cliente para gravação de cartão (LC) na configuração (RESUMO DE CAIXA)!', ['&Ok']);
    Result := False;
    Exit;
  End;

  If (fStrToFloat(edtCarRec.Text) > 0.0) And
     (VS_strUsaTef = 'S') And
     (fCfgSis('USACTC', varBoolean)) And
     (fCfgSis('PAFECF', varBoolean)) And
     (Assigned(VS_objFiscal)) and
     (not fSomentePOS) Then
  Begin
    If (Not VS_objFiscal.fValidaSerieECFEmpresa(strNumSer)) Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', 'O número de série "' + strNumSer + '" não foi encontrado nos dados da ECF na empresa "' + VS_strCodEmp + '".', ['&OK']);
      Exit;
    End;
  End;

  If (strEspDoc = 'CC') And
     (Not fEmptyStr(strCliCco)) And
     (fCfgSis('CRELIB', varBoolean)) Then
  Begin
    If fTravarCreditoDireto(strCliCco,
                            fStrToFloat(edtValDoc.Text),
                            edtCodOpe.Text,
                            True,
                            fGetModalidadesDigitadas) Then
    Begin
      Result := False;
      Exit;
    End;
  End;

  //Carrega o Portador Para Gravar o Credito do cliente
  If (strEspDoc = 'CC') Or (fltValCre > 0.0) Then
  Begin
    strPortadorCred := RetornaPortadorCredito;

    fPedePortadorCreditoCliente( strPortadorCred, strEventoCred );

    If fEmptyStr(strPortadorCred) Then
    Begin
      fMensagem('ATENÇÃO!', 'O portador deve ser informado para gravação de crédito!', ['&Ok']);
      Result := False;
      Exit;
    End
    {*REQ*145940**********RP*}
    Else If Not fEmpresaTemAcessoPortador(strPortadorCred) Then
    Begin
      fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
      Result := False;
      Exit;
    End;

    If objResumoDeCaixa.CaixaJaFoiFechado(dtaDtaCai) Then
    Begin
      Result := False;
      Exit;
    End;
  End;

  stlSeqBai := TStringList.Create;

  Try
    LDataHoraInicioBaixa := fRetDtaHraServidor;

    intSeqBai := 0;

    {*************************************************}
    {* DEVE SER CHAMADO ANTES DA TRANSACAO PRINCIPAL *}
    {*********************************************JC**}
    intSeqCon := StrToInt(fRetRcxCon);

    {*************************************************}
    {* DEVE SER CHAMADO ANTES DA TRANSACAO PRINCIPAL *}
    {*********************************************JC**}
    fRetSequencialMovCar('MOVCAR', VS_strCodEmp, arrCartoes);

    LGravarRegistroPix := False;

    LDadosPagamentoPix := TFuncoesPix.RetornaDadosDoRetornoPixConsulta(FDadosPixRecebimento,
                                                                       FDadosPixRequisicao);
    LRecebidoPorPix := IIF(chkPixAvulso.Checked, 'S', 'N');
    If TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(LDadosPagamentoPix) Then
    Begin
      LRecebidoPorPix := 'S';

      LGravarRegistroPix := True;

      FObjetoPixRecebimento.SeqConTransferencia := StrToInt(fRetRcxCon);
    End;


    If (Not LGravarRegistroPix) And (fFormataFloat(fltOrdRec, 2) > 0.0) And (objResumoDeCaixa.TransferenciaOrdemPagamentoAutomatica) Then
    Begin
      LPortadorTFAutomatica := objResumoDeCaixa.RetornaPortadorTFAutomatica(False,strPortadorCred);

      If fEmptyStr(LPortadorTFAutomatica) Then
      Begin
        fMensagem('ATENÇÃO!', 'O portador deve ser informado para gravação da transferência automática!', ['&Ok']);
        Result := False;
        Exit;
      End;

      LSeqConTransferenciaOrdPgto := StrToInt(fRetRcxCon);
    End;

    LSomaModalidades := fFormataFloat(fltChqPre + fltChqRec + fltDinRec + fltCarRec + fltOrdRec + Abs(fltTotCre), 2);

    LPortadorCadRec := fCfgSis('PORRCX');
    If fltOrdRec > 0 Then
      LPortadorCadRec :=  objResumoDeCaixa.RetornaPortadorCADRECNoResumoDeCaixa(FAutoIncremChavePix,
                                                                                LPortadorCadRec,
                                                                                LPortadorTFAutomatica,
                                                                                fltOrdRec,
                                                                                LSomaModalidades,
                                                                                LGravarRegistroPix,
                                                                                True);

    If (strEspDoc = 'PG') Then
    Begin
      if not fVerificaMeta(dtaDtaCai,
                           strCta_Pg,
                           VS_strCodEmp,
                           strCodFor,
                           fltValDoc) then
      begin
        log('Houve um problema na hora de validar a meta do plano de contas...');
        Exit;
      end;

      if Not (fCfgSis('PGSEQ_', varBoolean)) Then
      Begin
        if not fValidaCampos(edtNumDoc, False) then
          Exit;

        if fEmptyStr(edtNumDoc.Text) then
        Begin
          strNumDoc := fAtualizaProCod('CADPAG', 'CTP_NUMDUP', '', 1, Nil,
            function (const AValue: String) : String
            begin
              Result := fPadL(AValue, 12, '0');
            end
          );
        End
        Else
          strNumDoc := edtNumDoc.Text;
      end
      else
      Begin
        strNumDoc := fAtualizaProCod('CADPAG', 'CTP_NUMDUP', '', 1, Nil,
            function (const AValue: String) : String
            begin
              Result := fPadL(AValue, 12, '0');
            end
          );
      End;

      strVeioNF := 'S';
      If fCfgSis('PG_DUP') = 'S' Then
      Begin
        If fMensagem('', 'Com duplicata?', ['&Sim', '&Não'], 2) = 2 Then
        Begin
          strVeioNF := 'N';
        End;
      End;
    end;

    fStartTransaction;
    log('Estou na fConfirmaResumoCaixa e ja iniciei a transação!');

    {*******************************************}
    {* GRAVA CONTA CORRENTE DO CLIENTE         *}
    {* -> CC - CRÉDITO DE CLIENTE              *}
    {****************************************MV*}
    If (strEspDoc = 'CC') Or (fltValCre > 0.0) Then
    Begin

      If (fltValCre > 0.0) Then
      Begin
        Result := fGravaCreditoCliente(1, strPortadorCred, intSeqCon, strAutIncCadRecCredito, strEventoCred, LRecebidoPorPix);
      End
      Else
      Begin
        Result := fGravaCreditoCliente(2, strPortadorCred, 0, strAutIncCadRecCredito, strEventoCred, LRecebidoPorPix);
      End;

      If (Result) Then
        blnGerouLib := True;

      If (Not Result) Then
      Begin
        log('Houve um problema na hora de gravar o crédito para o cliente...');
        fRollBack;
        Exit;
      End;

    End;

    {***************************************************}
    {* GRAVA CREDITO PARA O CLIENTE, POREM JA BAIXADO  *}
    {* -> REFERENTE AO TROCO                           *}
    {************************************************MV*}
    If (fltValTroco_ > 0.0) Then
    Begin

      strCtaBai := fCfgSis('CTARCX');

      Result := fGravaCreditoClienteTroco(fltValTroco_, LPortadorCadRec, intSeqCon, strCtaBai, '', LRecebidoPorPix);

      If (Not Result) Then
      Begin
        log('Houve um problema na hora de gravar o crédito referente ao troco para o cliente...');
        fRollBack;
        Exit;
      End;

    End;

    If (strEspDoc = 'PG') Then
    Begin

      If Not fDadosDoPagamentoValidos Then
      Begin
        fRollBack;
        Exit(False);
      End;

      fltValAux := 0.0;
      If (Not fEmptyStr(edtDinRec.Text)) Then
        fltValAux := fltValAux + fStrToFloat(edtDinRec.Text);

      If (Not fEmptyStr(edtCarRec.Text)) Then
        fltValAux := fltValAux + fStrToFloat(edtCarRec.Text);

      If (Not fEmptyStr(edtChqRec.Text)) Then
        fltValAux := fltValAux + fStrToFloat(edtChqRec.Text);

      If (Not fEmptyStr(edtChqPre.Text)) Then
        fltValAux := fltValAux + fStrToFloat(edtChqPre.Text);

      If (Not fEmptyStr(edtOrdRec.Text)) Then
        fltValAux := fltValAux + fStrToFloat(edtOrdRec.Text);

      fltValCtb := fltValAux * IIF(fltValAux < 0.0, -1, 1);

      strDescri := edtDescri.Text;

      {*******************************************}
      {* REALIZA GRAVAÇÃO DO MOVBAN              *}
      {****************************************MV*}
      If fCfgSis('CTBPAG', varBoolean) Then
      Begin
        lstBanCtp := TBanCtpRepository.Create;
        lstBanCtp.fAdd(strNumDoc,
                       'A',
                       '',
                       VS_strCodEmp,
                       strCodFor,
                       'REF. PG. RESUMO DE CAIXA DOC. ' + edtNumDoc.Text,
                       strDescri,
                       strCta_Pg,
                       VS_strCodEmp,
                       0,
                       fltValCtb,
                       fStrToFloat(edtDinRec.Text),
                       fStrToFloat(edtChqRec.Text),
                       fStrToFloat(edtChqPre.Text),
                       fStrToFloat(edtOrdRec.Text));

        strSeqLan := fGravaMovBan(strCta_Pg,                                         // Centro de Custo
                                  fCfgSis('PORPGR'),                                 // Portador da Baixa
                                  edtCodOpe.Text,                                    // Operador da Baixa
                                  dtaDtaCai,                                         // Data do Lançamento
                                  fTime(),                                           // Hora do Lançamento
                                  strNumDoc,                                         // Numero do Documento
                                  IIF(fltValAux < 0, 'C', 'D'),                      // Credito / Debito
                                  VS_strCodEmp,                                      // Empresa da Baixa
                                  fltValCtb,                                         // Valor Do Lançamento
                                  'REF. PG. RESUMO DE CAIXA DOC. ' + edtNumDoc.Text, // Histórico 1
                                  strDescri,                                         // Histórico 2
                                  '',                                                // Cliente da Duplicata
                                  strCodFor,                                         // Fornecedor da Duplicata
                                  strNumDoc,                                         // Número da Duplicata
                                  0,                                                 // Sequencial de Baixa
                                  'A',                                               // Parcela da Duplicata
                                  VS_strCodEmp,                                      // Empresa da Duplicata
                                  '',                                                // Série
                                  //'',                                                // Sequencial de Lançamento
                                  '',                                                // Codigo do Evento
                                  '',
                                  lstBanCtp.fGetList,                                // Log Bancário
                                  0,
                                  intSeqCon);

        If (fEmptyStr(strSeqLan)) Then
        Begin
          FreeAndNil(lstBanCtp);
          fRollBack;
          log('Houve um problema para gravar o movban!');
          Result := False;
          Exit;
        End;

        FreeAndNil(lstBanCtp);
      End
      Else strSeqLan := '';

      {*******************************************}
      {* REALIZA GRAVAÇÃO DO CADPAG (BAIXADO)    *}
      {****************************************MV*}
      if (fEmptyStr(edtNumDoc.Text)) or
         (fCfgSis('PGSEQ_', varBoolean)) then
      begin
        if strNumDoc = EmptyStr then
        Begin
          strNumDup := fAtualizaProCod('CADPAG', 'CTP_NUMDUP', '', 1, Nil,
            function (const AValue: String) : String
            begin
              Result := fPadL(AValue, 12, '0');
            end
          );
        End
        Else
          strNumDup := strNumDoc;
      end
      else
      begin
        if fEmptyStr(strNumDup) then
          strNumDup := edtNumDoc.Text;
      end;
      strNumDupPG := strNumDup;
      Result := fGravaCadPag('frmRcxResumoCaixa',                               // Nome do Form - LogCtp
                             'BAIXA - RESUMO DE CAIXA (PG)',                    // Descrição LOGCTP
                             strCodFor,                                         // Fornecedor
                             strNumDup,                                         // Documento
                             'A',                                               // Parcela
                             VS_strCodEmp,                                      // Empresa
                             strCta_Pg,                                         // Centro de Custo
                             '',                                                // Série
                             0,                                                 // Sequencial de Baixa
                             dtaDtaCai,                                         // Data de Cadastro
                             dtaDtaCai,                                         // Data de Vencimento
                             0,                                                 // Valor da Duplicata
                             fltValDoc,                                         // Valor Original
                             'N',                                               // Previsão?
                             'N',                                               // Veio boleto?
                             'N',                                               // Deposito
                             strDescri,                                         // Histórico 1
                             '',                                                // Histórico 2
                             'REF. PG. RESUMO DE CAIXA DOC. ' + edtNumDoc.Text, // Histórico da Baixa
                             fCfgSis('PORPGR'),                                 // Portador da Baixa
                             strCta_Pg,                                         // Centro de Custo da Baixa
                             strSeqLan,                                         // Documento de Baixa
                             edtCodOpe.Text,                                    // Operador da Baixa
                             dtaDtaCai,                                         // Data de Pagamento
                             fltValDoc,                                         // Valor de pagamento
                             fltValJur,                                         // Juros
                             fltDesRec,                                         // Desconto
                             VS_strCodEmp,                                      // Empresas Gerais
                             strCodEve,                                         // Evento
                             '',
                             fCfgSis('PORRES'),                                 // Portador
                             edtNumDoc.Text,                                    // Numero do Documento
                             0.0,
                             0.0,
                             fRetCtpCon,
                             True,                                             // Feito pelo Resumo de Caixa PG
                             intSeqCon,                                       // Sequencial de Controle de Resumo de Caixa
                             '',0,
                             strVeioNF,                                         // Veio NF?
                             '','','','','','','','','','','','','','',
                             fltDinRec,
                             fltChqRec + fltChqPre);

      If (Not Result) Then
      Begin
        log('Houve um problema ao gravar o CadPag...');
        fRollBack;
        Exit;
      End;

    End;

    LPlanoDeContasComissaoProfissionais := '';
    strCtaBai := fCfgSis('CTARCX');
    strTipCta := '';

    If fBaixaDeComissaoParaProfissional Then
    Begin
      LPlanoDeContasComissaoProfissionais := fCfgSis('COMRCX');

      strTipCta := '(Comissão de Profissional)';
    End;

    {*******************************************}
    {* TRAVA SE QUALQUER UMA DAS CONFIGURAÇÕES *}
    {* ABAIXO ESTIVER VAZIA OU INCORRETA       *}
    {****************************************JU*}
    If fEmptyStr(fRetDescCentroCusto(strCtaBai)) Then
    Begin
      fRollBack;
      fMensagem('', 'A configuração Plano de Contas para baixa do Contas a Receber do grupo Resumo de Caixa está vazia ou preenchida incorretamente, corrija!', ['&Ok']);
      Result := False;
      Exit;
    End;

    If strTipCta = '(Comissão de Profissional)' Then
    Begin
      If fEmptyStr(fRetDescCentroCusto(LPlanoDeContasComissaoProfissionais)) Then
      Begin
        fRollBack;
        fMensagem('', 'A configuração Plano de Contas para baixa do Contas a Receber' + #13#10 + strTipCta + ' do grupo Resumo de Caixa está vazia ou preenchida incorretamente, corrija!', ['&Ok']);
        Result := False;
        Exit;
      End;
    End;

    If fEmptyStr(fRetNomPortador(fCfgSis('PORRCX'))) Then
    Begin
      fRollBack;
      fMensagem('', 'A configuração Portador para baixa do Contas a Receber do grupo Resumo de Caixa está vazia ou preenchida incorretamente, corrija!', ['&Ok']);
      Result := False;
      Exit;
    End;

    If Not fPermiteModalidadeParaPortador(fltDinRec, fltCarRec, fltChqRec, fltChqPre, fltOrdRec, 0, fCfgSis('PORRCX')) Then
    Begin
      fRollBack;
      fMensagem('', 'O Portador para baixa não tem permissão para uma ou mais das modalidades informadas, corrija!', ['&Ok']);
      Result := False;
      Exit;
    End;

    {*******************************************}
    {* VERIFICA SOBRA DE CRÉDITO               *}
    {****************************************MV*}
    pVerificaSobraCredito;
    log('Verifcou sobra de crédito!');

    {*******************************************}
    {* SE NAO FOR QUITÃÇÃO, DEIXA SELECIONADAS *}
    {* SOMENTE AS DUPLICATAS CUJO CRÉDITO SEJA *}
    {* SUFICIENTE PARA A BAIXA                 *}
    {****************************************MV*}
    If (Not blnQuitacao) Then
    Begin
      pSelecionaDupNaoQuitacao;
      log('Selecionou duplicatas de não quitação!');
    End;

    strHisCar := '';

    {********************************************}
    {* CASO TENHA CREÉDITO, ABATE NAS DUPLICATAS*}
    {*****************************************MV*}
    If (Not cdsTmpResumoCaixa.IsEmpty) And
       (intQtdSel > 0)                 And
       (fltTotCre < 0.0)               Then
    Begin

      If (fltTotRec > 0.0) And (fltTotRec + fltTotCre < 0.0) Then
      Begin
        fltValAba := fltTotRec;
      End
      Else
      Begin
        fltValAba := -fltTotCre;
      End;

      With cdsTmpResumoCaixa Do
      Begin

        DisableControls;
        First;

        {*********************************************}
        {* ALTERADA A ORDEM PARA BAIXA DE DUPLICATAS *}
        {* ABATENDO CRÉDITOS                         *}
        {******************************************AJ*}
        strUltIndice    := IndexFieldNames;
        IndexFieldNames := 'CTR_VALDUP';
        Last;
        While (Not Bof) Do
        Begin

          If (FieldByName('CTR_MARDES').AsString <> 'M') Then
          Begin
            Prior;
            Continue;
          End;

          If (FieldByName('CTR_VALREC').AsFloat > 0.0) Then
          Begin
            Prior;
            Continue;
          End;

          strHisCar := Trim(Copy(strHisCar + FieldByName('CTR_NUMDUP').AsString + FieldByName('CTR_PARCEL').AsString + '-' + FieldByName('CTR_ESPDOC').AsString + '-' + FieldByName('CTR_CODEMP').AsString + '/', 1, 250));

          If (fFormataFloat(-FieldByName('CTR_VALREC').AsFloat, 2) > fFormataFloat(fltValAba, 2)) Then
          Begin
            Edit;
            FieldByName('CTR_VALREC').AsFloat := -fltValAba;
            FieldByName('CTR_VALRES').AsFloat := fFormataFloat(FieldByName('CTR_VALDUP').AsFloat - FieldByName('CTR_VALREC').AsFloat, 2);
            Post;
          End;

          blnParcia := False;
          If (fFormataFloat(FieldByName('CTR_VALRES').AsFloat, 02) <> fFormataFloat(0.0, 2)) Then
          Begin
            blnParcia := True;
          End;

          If (blnParcia) Then
          Begin
            if (FieldByName('CTR_VALREC').AsFloat < 0) then
            begin
              Edit;
              FieldByName('VALORBAIXADUPLICATA').AsFloat := FieldByName('CTR_VALREC').AsFloat;
              Post;
            end;

            dtaDtaVen := FieldByName('CTR_DTAVEN').AsDateTime;
            If dtaDtaVen < VS_Date Then
            Begin
              {*******************************************}
              {* SE FOR RECEBIMENTO PARCIAL E ESTIVER    *}
              {* CONFIGURADO PARA MANTER A DATA DO       *}
              {* VENCIMENTO, GRAVA A DATA DE VENCIMENTO  *}
              {* REAL, SENÃO GRAVA A DATA DO RECEBIMENTO.*}
              {****************************************PZ*}
              If (fCfgSis('MANVEN') = 'S') Then
                dtaDtaVen := FieldByName('CTR_DTAVEN').AsDateTime
              Else
                dtaDtaVen := VS_Date;
            End;

            {*********************************}
            {* RATEIO DOS VALORES RECEBIDOS  *}
            {******************************RV*}
            pRateiaVariaveisModalidades;

            fltGrCqP2 := fltGraCqP;
            fltGrCqV2 := fltGraCqV;
            fltGrDin2 := fltGraDin;
            fltGrCar2 := fltGraCar;
            fltGrOrd2 := fltGraOrd;

            blnGraVDp := fFormataFloat(fltDinRec + fltChqRec + fltChqPre + fltCarRec + fltOrdRec, 2) = 0;

            If fFormataFloat(fltChqPre + fltChqRec + fltDinRec + fltCarRec + fltOrdRec,2) <> 0 Then
            Begin
              fltGraCqP := (fltNovoValOri/(fltChqPre + fltChqRec + fltDinRec + fltCarRec + fltOrdRec)) * fltChqPre;
              fltGraCqV := (fltNovoValOri/(fltChqPre + fltChqRec + fltDinRec + fltCarRec + fltOrdRec)) * fltChqRec;
              fltGraDin := (fltNovoValOri/(fltChqPre + fltChqRec + fltDinRec + fltCarRec + fltOrdRec)) * fltDinRec;
              fltGraCar := (fltNovoValOri/(fltChqPre + fltChqRec + fltDinRec + fltCarRec + fltOrdRec)) * fltCarRec;
              fltGraOrd := (fltNovoValOri/(fltChqPre + fltChqRec + fltDinRec + fltCarRec + fltOrdRec)) * fltOrdRec;
            End
            Else
            Begin
              fltGraCqP := 0;
              fltGraCqV := 0;
              fltGraDin := -fltValAba;
              fltGraCar := 0;
              fltGraOrd := 0;
            End;

            fltJurosCalculado := fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                                     FieldByName('CTR_VALSUJ').AsFloat,
                                                     fCfgSis('JURATR', varDouble));

            fltValorCalculado := FieldByName('CTR_VALSUJ').AsFloat + fltJurosCalculado;

            fltDifOri := FieldByName('CTR_VALCOR').AsFloat - FieldByName('CTR_VALDUP').AsFloat;

            If fltValorCalculado < 0 Then
              fltDifOri := 0;

            If Result Then
              Result := fBaixaParcial(FieldByName('CTR_NUMDUP').AsString,                      // Duplicata
                                      FieldByName('CTR_PARCEL').AsString,                      // Parcela
                                      FieldByName('CTR_CODEMP').AsString,                      // Empresa
                                      FieldByName('CTR_ESPDOC').AsString,                      // Espécie
                                      FieldByName('CTR_CODCLI').AsString,                      // Cliente
                                      FieldByName('CTR_VALREC').AsFloat,                       // Valor Recebido
                                      0.0,                                                     // Valor Recebido
                                      0.0,                                                     // Valor do Desconto
                                      dtaDtaCai,                                               // Data do Recebimento
                                      dtaDtaVen,                                               // Data do Vencimento
                                      LPortadorCadRec,                                       // Portador da Baixa
                                      IIF( fEmptyStr(edtDescri.Text),'', edtDescri.Text + ' ') + 'REF. CLIENTE ' + FieldByName('CTR_CODCLI').AsString,    // Histórico da Baixa
                                      IIF(Not DuplicataComissaoProfissional, strCtaBai, LPlanoDeContasComissaoProfissionais), // Centro de Custo da Baixa
                                      edtCodOpe.Text,                                          // Operador da Baixa
                                      strSeqLan,                                               // Doucmento de Baixa(MOVBAN)
                                      FieldByName('CTR_DUPORI').AsFloat,                       // Novo Valor Original
                                      FieldByName('CTR_VALRES').AsFloat,                       // Novo Valor da Duplicata
                                      fltGraCqP,
                                      fltGraCqV,
                                      IIF(blnGraVDp, FieldByName('CTR_VALREC').AsFloat, fltGraDin),
                                      fltGraCar,
                                      fltGraOrd,
                                      0,
                                      1,                                                       // vem do Resumo de Caixa
                                      0,
                                      fltGraCqP <> 0,
                                      fltGraCqV <> 0,
                                      IIF(blnGraVDp, True, fltGraDin <> 0),
                                      fltGraCar <> 0,
                                      fltGraOrd <> 0,
                                      False,
                                      intSeqBai,
                                      strAutIncNov,
                                      intSeqCon,
                                      FieldByName('CTR_VALIPI').AsFloat,
                                      FieldByName('CTR_VALRET').AsFloat,
                                      FieldByName('CTR_VALACE').AsFloat,
                                      FieldByName('CTR_VALFRE').AsFloat,
                                      FieldByName('CTR_VALFCP').AsFloat,
                                      fltDifOri,
                                      0,
                                      FieldByName('VALORBAIXADUPLICATA').AsFloat,
                                      FieldByName('JUROSNOVADUPLICATA').AsFloat,
                                      FieldByName('FATORBAIXADUPLICATA').AsFloat,
                                      FieldByName('FATORJUROSDUPLICATA').AsFloat,
                                      FieldByName('DESCONTONOVADUPLICATA').AsFloat,
                                      FieldByName('CTR_CALORI').AsFloat,
                                      FieldByName('CTR_RECAUT').AsString,
                                      '',
                                      untCadRec.fGetValOriDuplicata(FieldByName('CTR_NUMDUP').AsString,
                                                                    FieldByName('CTR_ESPDOC').AsString,
                                                                    FieldByName('CTR_CODEMP').AsString,
                                                                    FieldByName('CTR_PARCEL').AsString,
                                                                    FieldByName('CTR_CODCLI').AsString),
                                      '',
                                      '',
                                      '',
                                      LRecebidoPorPix,
                                      FieldByName('DESPESASBAIXADUPLICATA').AsFloat,
                                      FieldByName('DESPESASNOVADUPLICATA').AsFloat,
                                      FieldByName('CTR_VALCBS').AsFloat,
                                      FieldByName('CTR_VALIBS').AsFloat,
                                      FieldByName('CTR_VAL_IS').AsFloat);

            If Not blnGraVDp Then
              pGravaRateio(cdsRateio,
                           intSeqBai,
                           FieldByName('CTR_NUMDUP').AsString,
                           FieldByName('CTR_PARCEL').AsString,
                           FieldByName('CTR_ESPDOC').AsString,
                           FieldByName('CTR_CODEMP').AsString,
                           FieldByName('CTR_CODCLI').AsString,
                           FieldByName('CTR_VALREC').AsFloat,
                           fltDinRec - fltValCre,
                           fltChqRec,
                           fltChqPre,
                           fltCarRec,
                           fltOrdRec,
                           0);

            If (Not Result) Then
            Begin
              fRollback;
              Exit;
            End;

            stlSeqBai.Values[FieldByName('CTR_NUMDUP').AsString +
                             FieldByName('CTR_PARCEL').AsString +
                             FieldByName('CTR_CODEMP').AsString +
                             FieldByName('CTR_ESPDOC').AsString +
                             FieldByName('CTR_CODCLI').AsString] := IntToStr(intSeqBai);


            {**********************}
            {* GRAVA LOG DA BAIXA *}
            {*******************JS*}
            If (Result) Then
            Begin
              pGravaLogCtr(FieldByName('CTR_NUMDUP').AsString,
                           FieldByName('CTR_ESPDOC').AsString,
                           FieldByName('CTR_CODCLI').AsString,
                           FieldByName('CTR_CODEMP').AsString,
                           FieldByName('CTR_PARCEL').AsString,
                           fRetSeqBaicadRec(cdsTmpResumoCaixa.FieldByName('CTR_NUMDUP').AsString,
                                            cdsTmpResumoCaixa.FieldByName('CTR_PARCEL').AsString,
                                            cdsTmpResumoCaixa.FieldByName('CTR_CODEMP').AsString,
                                            cdsTmpResumoCaixa.FieldByName('CTR_ESPDOC').AsString,
                                            cdsTmpResumoCaixa.FieldByName('CTR_CODCLI').AsString),
                           'BAIXA PARCIAL', Self.Name);

              pGravaLogCtr(FieldByName('CTR_NUMDUP').AsString,
                           FieldByName('CTR_ESPDOC').AsString,
                           FieldByName('CTR_CODCLI').AsString,
                           FieldByName('CTR_CODEMP').AsString,
                           FieldByName('CTR_PARCEL').AsString, 0,
                           'ALTERAÇÃO DE BAIXA', Self.Name);
            End;

          End
          Else
          Begin

            {*******************************************}
            {* TRAVA SE QUALQUER UMA DAS CONFIGURAÇÕES *}
            {* ABAIXO ESTIVER VAZIA OU INCORRETA       *}
            {****************************************JU*}
            If fEmptyStr(fRetDescCentroCusto(strCtaBai)) Then
            Begin
              fRollBack;
              fMensagem('', 'A configuração Plano de Contas para baixa do Contas a Receber' + #13#10 + strTipCta + ' do grupo Resumo de Caixa está vazia ou preenchida incorretamente, corrija!', ['&Ok']);
              Result := False;
              Exit;
            End;

            If fEmptyStr(fRetNomPortador(fCfgSis('PORRCX'))) Then
            Begin
              fRollBack;
              fMensagem('', 'A configuração Portador para baixa do Contas a Receber do grupo Resumo de Caixa está vazia ou preenchida incorretamente, corrija!', ['&Ok']);
              Result := False;
              Exit;
            End;

            If (fltTotRec - fltValAba = 0) And (Not fPermiteCreditoDebitoPortador(fCfgSis('PORRCX'))) Then
            Begin
              fRollBack;
              fMensagem('', 'Não é permitido utilizar o portador para baixa com utilização de credito zerada', ['&Ok']);
              Result := False;
              Exit;
            End;

            {*********************************}
            {* RATEIO DOS VALORES RECEBIDOS  *}
            {******************************RV*}
            pRateiaVariaveisModalidades;

            blnGraVDp := fFormataFloat(fltDinRec + fltChqRec + fltChqPre + fltCarRec + fltOrdRec, 2) = 0;

            If Not blnGraVDp Then
              pGravaRateio(cdsRateio,
                           0,
                           FieldByName('CTR_NUMDUP').AsString, FieldByName('CTR_PARCEL').AsString,
                           FieldByName('CTR_ESPDOC').AsString, FieldByName('CTR_CODEMP').AsString,
                           FieldByName('CTR_CODCLI').AsString, FieldByName('CTR_VALREC').AsFloat,
                           fltDinRec - fltValCre, fltChqRec, fltChqPre, fltCarRec, fltOrdRec, 0);

            If Result Then
              Result := fBaixaTotal(FieldByName('CTR_NUMDUP').AsString,                   // Duplicata
                                    FieldByName('CTR_PARCEL').AsString,                   // Parcela
                                    FieldByName('CTR_ESPDOC').AsString,                   // Espécie
                                    FieldByName('CTR_CODEMP').AsString,                   // Empresa
                                    FieldByName('CTR_CODCLI').AsString,                   // Cliente
                                    FieldByName('CTR_DUPORI').AsFloat,                    // Valor da Duplicata
                                    FieldByName('CTR_VALREC').AsFloat,                    // Valor Recebido
                                    FieldByName('CTR_VALJUR').AsFloat,                    // Valor Juros
                                    FieldByName('CTR_VALDES').AsFloat,                    // Valor Desconto
                                    fltAuxCqP,
                                    fltAuxCqV,
                                    IIF(blnGraVDp, FieldByName('CTR_VALREC').AsFloat, fltAuxDin),
                                    fltAuxCar,
                                    fltAuxOrd,
                                    0,
                                    dtaDtaCai,                                            // Data Recebimento
                                    strSeqLan,                                            // Sequencial de Baixa(MOVBAN)
                                    IIF( fEmptyStr(edtDescri.Text),'', edtDescri.Text + ' ') + 'REF. CLIENTE ' + FieldByName('CTR_CODCLI').AsString, // Histórico Baixa
                                    IIF(Not DuplicataComissaoProfissional, strCtaBai, LPlanoDeContasComissaoProfissionais), // Centro de Custo Baixa
                                    LPortadorCadRec,                                    // Portador Baixa
                                    edtCodOpe.Text,                                       // Operador Baixa
                                    0,
                                    fltAuxCqP <> 0,
                                    fltAuxCqV <> 0,
                                    IIF(blnGraVDp, True, fltAuxDin > 0),
                                    fltAuxCar <> 0,
                                    fltAuxOrd <> 0,
                                    False,
                                    1,                                                    // Vem do resumo de caixa?
                                    intSeqCon,                                            // Sequencial de Controle
                                    0,
                                    FieldByName('CTR_RECAUT').AsString,
                                    '',
                                    '',
                                    '',
                                    '',
                                    False,
                                    {**Req. 86252**18/04/2018**WS**}
                                    FieldByName('CTR_DESCOB').AsFloat,    // Valor de Despesa de Cobrança
                                    'S',
                                    LRecebidoPorPix);


            If (Not Result) Then
            Begin
              fRollBack;
              Exit;
            End;

            stlSeqBai.Values[FieldByName('CTR_NUMDUP').AsString +
                             FieldByName('CTR_PARCEL').AsString +
                             FieldByName('CTR_CODEMP').AsString +
                             FieldByName('CTR_ESPDOC').AsString +
                             FieldByName('CTR_CODCLI').AsString] := '0';

            {**********************}
            {* GRAVA LOG DA BAIXA *}
            {*******************JS*}
            If (Result) Then
            Begin
              pGravaLogCtr(FieldByName('CTR_NUMDUP').AsString,
                           FieldByName('CTR_ESPDOC').AsString,
                           FieldByName('CTR_CODCLI').AsString,
                           FieldByName('CTR_CODEMP').AsString,
                           FieldByName('CTR_PARCEL').AsString, 0,
                           'BAIXA TOTAL', Self.Name);
            End;

          End;

          fltValAba := fltValAba + FieldByName('CTR_VALREC').AsFloat;

          If (Not blnGerouLib) Then
          Begin
            pGeraLogLiberacao(FieldByName('CTR_NUMDUP').AsString,
                              FieldByName('CTR_ESPDOC').AsString,
                              FieldByName('CTR_CODEMP').AsString);
            blnGerouLib := True;
          End;

          LDesmembrarBaixaReceber.AdicionarDuplicata(cdsTmpResumoCaixa.FieldByName('AUTOINCREM').AsString);

          Prior;

        End;

        IndexFieldNames := strUltIndice;

        EnableControls;

      End;

    End;


    {*******************************************}
    {* TRAVA SE QUALQUER UMA DAS CONFIGURAÇÕES *}
    {* ABAIXO ESTIVER VAZIA OU INCORRETA       *}
    {****************************************JU*}
    If fEmptyStr(fRetDescCentroCusto(strCtaBai)) Then
    Begin
      fRollBack;
      fMensagem('', 'A configuração Plano de Contas para baixa do Contas a Receber do grupo Resumo de Caixa está vazia ou preenchida incorretamente, corrija!', ['&Ok']);
      Result := False;
      Exit;
    End;

    If strTipCta = '(Comissão de Profissional)' Then
    Begin
      If fEmptyStr(fRetDescCentroCusto(LPlanoDeContasComissaoProfissionais)) Then
      Begin
        fRollBack;
        fMensagem('', 'A configuração Plano de Contas para baixa do Contas a Receber' + #13#10 + strTipCta + ' do grupo Resumo de Caixa está vazia ou preenchida incorretamente, corrija!', ['&Ok']);
        Result := False;
        Exit;
      End;
    End;

    If fEmptyStr(fRetNomPortador(fCfgSis('PORRCX'))) Then
    Begin
      fRollBack;
      fMensagem('', 'A configuração Portador para baixa do Contas a Receber do grupo Resumo de Caixa está vazia ou preenchida incorretamente, corrija!', ['&Ok']);
      Result := False;
      Exit;
    End;

    With cdsTmpResumoCaixa Do
    Begin
      AAutoIncremStr := '';

      DisableControls;
      If (Active) Then
        First;

      If (Active) Then
        First;

      While (Not Eof) Do
      Begin

        If (FieldByName('CTR_MARDES').AsString <> 'M') Then
        Begin
          Next;
          Continue;
        End;

        If (FieldByName('CTR_VALREC').AsFloat < 0.0) Then
        Begin
          Next;
          Continue;
        End;

        AAutoIncremStr := IIF( fEmptyStr(AAutoIncremStr), '"' + FieldByName('AUTOINCREM').AsString + '"', (AAutoIncremStr + ',' +  '"' + FieldByName('AUTOINCREM').AsString + '"') );

        // Armazena na variavel se teve alteração/ inclusão/ remoção da desp. de cobrança;
        blnDescCobFoiAlterada := fVerificaAlteracaoDespesaCobranca( FieldByName('AUTOINCREM').AsString, FieldByName('CTR_DESCOB').AsFloat );

        strHisCar := Trim(Copy(strHisCar + FieldByName('CTR_NUMDUP').AsString + FieldByName('CTR_PARCEL').AsString + '-' + FieldByName('CTR_ESPDOC').AsString + '-' + FieldByName('CTR_CODEMP').AsString + '/', 1, 250));
        strCodCli := FieldByName('CTR_CODCLI').AsString;

        If (strCodCliMB = '') And (Not blnCliDif) Then
           strCodCliMB := FieldByName('CTR_CODCLI').AsString
        Else
        Begin
           If strCodCliMB <> FieldByName('CTR_CODCLI').AsString Then
           Begin
              blnCliDif   := True;
              strCodCliMB := '';
           End;
        End;

        blnParcia := False;
        If (fFormataFloat(FieldByName('CTR_VALRES').AsFloat, 02) > fFormataFloat(0.0, 2)) Then
        Begin
          blnParcia := True;
        End;

        If (blnParcia) Then
        Begin

          fltNovoValOri := (FieldByName('CTR_VALDUP').AsFloat);

          fltJurosCalculado := fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                                   FieldByName('CTR_VALSUJ').AsFloat,
                                                   fCfgSis('JURATR', varDouble));

          fltValorCalculado := FieldByName('CTR_VALSUJ').AsFloat + fltJurosCalculado;

          fltDifOri := FieldByName('CTR_VALCOR').AsFloat - FieldByName('CTR_VALDUP').AsFloat;

          If fltValorCalculado < 0 Then
            fltDifOri := 0;

          dtaDtaVen := FieldByName('CTR_DTAVEN').AsDateTime;
          If dtaDtaVen < VS_Date Then
          Begin
            {*******************************************}
            {* SE FOR RECEBIMENTO PARCIAL E ESTIVER    *}
            {* CONFIGURADO PARA MANTER A DATA DO       *}
            {* VENCIMENTO, GRAVA A DATA DE VENCIMENTO  *}
            {* REAL, SENÃO GRAVA A DATA DO RECEBIMENTO.*}
            {****************************************PZ*}
            If(fCfgSis('MANVEN') = 'S') Then
              dtaDtaVen := FieldByName('CTR_DTAVEN').AsDateTime
            Else
              dtaDtaVen := VS_Date;
          End;

          {*******************************************}
          {* TRAVA SE QUALQUER UMA DAS CONFIGURAÇÕES *}
          {* ABAIXO ESTIVER VAZIA OU INCORRETA       *}
          {****************************************JU*}
          If fEmptyStr(fRetDescCentroCusto(strCtaBai)) Then
          Begin
            fRollBack;
            fMensagem('', 'A configuração Plano de Contas para baixa do Contas a Receber' + #13#10 + strTipCta + ' do grupo Resumo de Caixa está vazia ou preenchida incorretamente, corrija!', ['&Ok']);
            Result := False;
            Exit;
          End;

          If fEmptyStr(fRetNomPortador(fCfgSis('PORRCX'))) Then
          Begin
            fRollBack;
            fMensagem('', 'A configuração Portador para baixa do Contas a Receber do grupo Resumo de Caixa está vazia ou preenchida incorretamente, corrija!', ['&Ok']);
            Result := False;
            Exit;
          End;

          {*********************************}
          {* RATEIO DOS VALORES RECEBIDOS  *}
          {******************************RV*}

          pRateiaVariaveisModalidades;

          blnGraVDp := fFormataFloat(fltAuxCqP + fltAuxCqV + fltAuxDin + fltAuxCar + fltAuxOrd, 2) = 0;

          If blnDescCobFoiAlterada Then
             pAtualizaDespesaCobranca(FieldByName('AUTOINCREM').AsString, FieldByName('CTR_DESCOB').AsFloat);

          If Result Then
            Result := fBaixaParcial(FieldByName('CTR_NUMDUP').AsString,                      // Duplicata
                                    FieldByName('CTR_PARCEL').AsString,                      // Parcela
                                    FieldByName('CTR_CODEMP').AsString,                      // Empresa
                                    FieldByName('CTR_ESPDOC').AsString,                      // Espécie
                                    FieldByName('CTR_CODCLI').AsString,                      // Cliente
                                    FieldByName('CTR_VALREC').AsFloat,                       // Valor Recebido
                                    FieldByName('CTR_VALJUR').AsFloat,                       // Valor Juros
                                    FieldByName('CTR_VALDES').AsFloat,                       // Valor do Desconto
                                    dtaDtaCai,                                               // Data do Recebimento
                                    dtaDtaVen,                                               // Data do Vencimento
                                    LPortadorCadRec,                                       // Portador da Baixa
                                    IIF( fEmptyStr(edtDescri.Text),'', edtDescri.Text + ' ') + 'REF. CLIENTE ' + FieldByName('CTR_CODCLI').AsString,    // Histórico da Baixa
                                    strCtaBai,                                               // Centro de Custo da Baixa
                                    edtCodOpe.Text,                                          // Operador da Baixa
                                    strSeqLan,                                               // Doucmento de Baixa(MOVBAN)
                                    fltNovoValOri,                                           // Novo Valor Original
                                    FieldByName('VALORNOVADUPLICATA').AsFloat,               // Novo Valor da Duplicata
                                    fltAuxCqP,
                                    fltAuxCqV,
                                    IIF(blnGraVDp, FieldByName('CTR_VALREC').AsFloat, fltAuxDin),
                                    fltAuxCar,
                                    fltAuxOrd,
                                    0,
                                    1,                                                       // Resumo de Caixa
                                    0,
                                    fltAuxCqP > 0,
                                    fltAuxCqV > 0,
                                    IIF(blnGraVDp, True, fltAuxDin > 0),
                                    fltAuxCar > 0,
                                    fltAuxOrd > 0,
                                    False,
                                    intSeqBai,
                                    strAutIncNov,
                                    intSeqCon,                                               // Sequencial de Controle
                                    FieldByName('CTR_VALIPI').AsFloat,
                                    FieldByName('CTR_VALRET').AsFloat,
                                    FieldByName('CTR_VALACE').AsFloat,
                                    FieldByName('CTR_VALFRE').AsFloat,
                                    FieldByName('CTR_VALFCP').AsFloat,
                                    fltDifOri,
                                    0,
                                    FieldByName('VALORBAIXADUPLICATA').AsFloat,
                                    FieldByName('JUROSNOVADUPLICATA').AsFloat,
                                    FieldByName('FATORBAIXADUPLICATA').AsFloat,
                                    FieldByName('FATORJUROSDUPLICATA').AsFloat,
                                    FieldByName('DESCONTONOVADUPLICATA').AsFloat,
                                    FieldByName('CTR_CALORI').AsFloat,
                                    FieldByName('CTR_RECAUT').AsString,
                                    '',
                                    untCadRec.fGetValOriDuplicata(FieldByName('CTR_NUMDUP').AsString,
                                                                  FieldByName('CTR_ESPDOC').AsString,
                                                                  FieldByName('CTR_CODEMP').AsString,
                                                                  FieldByName('CTR_PARCEL').AsString,
                                                                  FieldByName('CTR_CODCLI').AsString),
                                    '',
                                    '',
                                    '',
                                    LRecebidoPorPix,
                                    FieldByName('DESPESASBAIXADUPLICATA').AsFloat,
                                    FieldByName('DESPESASNOVADUPLICATA').AsFloat,
                                    FieldByName('CTR_VALCBS').AsFloat,
                                    FieldByName('CTR_VALIBS').AsFloat,
                                    FieldByName('CTR_VAL_IS').AsFloat);

          If Not blnGraVDp Then
            pGravaRateio(cdsRateio,
                         intSeqBai,
                         FieldByName('CTR_NUMDUP').AsString, FieldByName('CTR_PARCEL').AsString,
                         FieldByName('CTR_ESPDOC').AsString, FieldByName('CTR_CODEMP').AsString,
                         FieldByName('CTR_CODCLI').AsString, FieldByName('CTR_VALREC').AsFloat,
                         fltDinRec - fltValCre, fltChqRec, fltChqPre, fltCarRec, fltOrdRec, 0);

          If (Not Result) Then
          Begin
            fRollBack;
            Exit;
          End;


          stlSeqBai.Values[FieldByName('CTR_NUMDUP').AsString +
                           FieldByName('CTR_PARCEL').AsString +
                           FieldByName('CTR_CODEMP').AsString +
                           FieldByName('CTR_ESPDOC').AsString +
                           FieldByName('CTR_CODCLI').AsString] := IntToStr(intSeqBai);

          If (Not Result) Then
          Begin
            fRollBack;
            Exit;
          End;

          If fFormataFloat(fltChqPre + fltChqRec + fltDinRec + fltCarRec + fltOrdRec,2) <> 0 Then
          Begin
            fltGraCqP := (fltNovoValOri/(fltChqPre + fltChqRec + fltDinRec + fltCarRec + fltOrdRec)) * fltChqPre;
            fltGraCqV := (fltNovoValOri/(fltChqPre + fltChqRec + fltDinRec + fltCarRec + fltOrdRec)) * fltChqRec;
            fltGraDin := (fltNovoValOri/(fltChqPre + fltChqRec + fltDinRec + fltCarRec + fltOrdRec)) * fltDinRec;
            fltGraCar := (fltNovoValOri/(fltChqPre + fltChqRec + fltDinRec + fltCarRec + fltOrdRec)) * fltCarRec;
            fltGraOrd := (fltNovoValOri/(fltChqPre + fltChqRec + fltDinRec + fltCarRec + fltOrdRec)) * fltOrdRec;
          End
          Else
          Begin
            fltGraCqP := 0;
            fltGraCqV := 0;
            fltGraDin := fltNovoValOri;
            fltGraCar := 0;
            fltGraOrd := 0;
          End;

          {**********************}
          {* GRAVA LOG DA BAIXA *}
          {*******************JS*}
          If (Result) Then
          Begin

            If blnDescCobFoiAlterada Then
            Begin
              pGravaLogCtr(FieldByName('CTR_NUMDUP').AsString,
                           FieldByName('CTR_ESPDOC').AsString,
                           FieldByName('CTR_CODCLI').AsString,
                           FieldByName('CTR_CODEMP').AsString,
                           FieldByName('CTR_PARCEL').AsString,
                           0,
                           'ALTERAÇÃO DE DESP. COBRANÇA',
                           Self.Name,
                           FieldByName('CTR_DESCOB').AsFloat);
            End;

            pGravaLogCtr(FieldByName('CTR_NUMDUP').AsString,
                         FieldByName('CTR_ESPDOC').AsString,
                         FieldByName('CTR_CODCLI').AsString,
                         FieldByName('CTR_CODEMP').AsString,
                         FieldByName('CTR_PARCEL').AsString,
                         fRetSeqBaicadRec(cdsTmpResumoCaixa.FieldByName('CTR_NUMDUP').AsString,
                                          cdsTmpResumoCaixa.FieldByName('CTR_PARCEL').AsString,
                                          cdsTmpResumoCaixa.FieldByName('CTR_CODEMP').AsString,
                                          cdsTmpResumoCaixa.FieldByName('CTR_ESPDOC').AsString,
                                          cdsTmpResumoCaixa.FieldByName('CTR_CODCLI').AsString),
                         'BAIXA PARCIAL', Self.Name);

            pGravaLogCtr(FieldByName('CTR_NUMDUP').AsString,
                         FieldByName('CTR_ESPDOC').AsString,
                         FieldByName('CTR_CODCLI').AsString,
                         FieldByName('CTR_CODEMP').AsString,
                         FieldByName('CTR_PARCEL').AsString, 0,
                         'ALTERAÇÃO DE BAIXA', Self.Name);

            If VS_strHabilitarCRM And (Not fEmptyStr(fCfgSis('OCOFIN', varString)))  Then
            Begin
              TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(FieldByName('CTR_NUMDUP').AsString,
                                                       FieldByName('CTR_ESPDOC').AsString,
                                                       FieldByName('CTR_CODEMP').AsString,
                                                       FieldByName('CTR_CODCLI').AsString,
                                                       FieldByName('CTR_PARCEL').AsString,
                                                       strLoginUsuarioLogado,
                                                       fRetCgcCpf(FieldByName('CTR_CODCLI').AsString),
                                                       afcBaixaParcial);
            End;
          End;
        End
        Else
        Begin
          {*********************************}
          {* RATEIO DOS VALORES RECEBIDOS  *}
          {******************************RV*}
          pRateiaVariaveisModalidades;

          If blnDescCobFoiAlterada Then
             pAtualizaDespesaCobranca(FieldByName('AUTOINCREM').AsString, FieldByName('CTR_DESCOB').AsFloat);

          blnGraVDp := fFormataFloat(fltChqPre + fltChqRec + fltDinRec + fltCarRec + fltOrdRec, 2) = 0;

          If Not blnGraVDp Then
            pGravaRateio(cdsRateio,
                         0,
                         FieldByName('CTR_NUMDUP').AsString, FieldByName('CTR_PARCEL').AsString,
                         FieldByName('CTR_ESPDOC').AsString, FieldByName('CTR_CODEMP').AsString,
                         FieldByName('CTR_CODCLI').AsString, FieldByName('CTR_VALREC').AsFloat,
                         fltDinRec - fltValCre, fltChqRec, fltChqPre, fltCarRec, fltOrdRec, 0);

          If Result Then
            Result := fBaixaTotal(FieldByName('CTR_NUMDUP').AsString,                   // Duplicata
                                  FieldByName('CTR_PARCEL').AsString,                   // Parcela
                                  FieldByName('CTR_ESPDOC').AsString,                   // Espécie
                                  FieldByName('CTR_CODEMP').AsString,                   // Empresa
                                  FieldByName('CTR_CODCLI').AsString,                   // Cliente
                                  FieldByName('CTR_DUPORI').AsFloat,                    // Valor da Duplicata
                                  FieldByName('CTR_VALREC').AsFloat,                    // Valor Recebido
                                  FieldByName('CTR_VALJUR').AsFloat,                    // Valor Juros
                                  FieldByName('CTR_VALDES').AsFloat,                    // Valor Desconto
                                  fltAuxCqP,
                                  fltAuxCqV,
                                  IIF(blnGraVDp, FieldByName('CTR_VALREC').AsFloat, fltAuxDin),
                                  fltAuxCar,
                                  fltAuxOrd,
                                  0,
                                  dtaDtaCai,                                            // Data Recebimento
                                  strSeqLan,                                            // Sequencial de Baixa(MOVBAN)
                                  IIF( fEmptyStr(edtDescri.Text),'', edtDescri.Text + ' ') + 'REF. CLIENTE ' + FieldByName('CTR_CODCLI').AsString, // Histórico Baixa
                                  strCtaBai,                                            // Centro de Custo Baixa
                                  LPortadorCadRec,                                    // Portador Baixa
                                  edtCodOpe.Text,                                       // Operador Baixa
                                  0,
                                  fltAuxCqP > 0,
                                  fltAuxCqV > 0,
                                  IIF(blnGraVDp, True, fltAuxDin > 0),
                                  fltAuxCar > 0,
                                  fltAuxOrd > 0,
                                  False,
                                  1,
                                  intSeqCon,                                            // Sequencial de Controle
                                  0,
                                  FieldByName('CTR_RECAUT').AsString,
                                  '',
                                  '',
                                  '',
                                  '',
                                  False,
                                  {**Req. 86252**18/04/2018**WS**}
                                  FieldByName('CTR_DESCOB').AsFloat,    // Valor de Despesa de Cobrança
                                  'S',
                                  LRecebidoPorPix);

          If (Not Result) Then
          Begin
            fRollBack;
            Exit;
          End;

          stlSeqBai.Values[FieldByName('CTR_NUMDUP').AsString +
                           FieldByName('CTR_PARCEL').AsString +
                           FieldByName('CTR_CODEMP').AsString +
                           FieldByName('CTR_ESPDOC').AsString +
                           FieldByName('CTR_CODCLI').AsString] := '0';

          {**********************}
          {* GRAVA LOG DA BAIXA *}
          {*******************JS*}
          If (Result) Then
          Begin

            If blnDescCobFoiAlterada Then
            Begin
              pGravaLogCtr(FieldByName('CTR_NUMDUP').AsString,
                           FieldByName('CTR_ESPDOC').AsString,
                           FieldByName('CTR_CODCLI').AsString,
                           FieldByName('CTR_CODEMP').AsString,
                           FieldByName('CTR_PARCEL').AsString,
                           0,
                           'ALTERAÇÃO DE DESP. COBRANÇA',
                           Self.Name,
                           fltValCob);
            End;

            pGravaLogCtr(FieldByName('CTR_NUMDUP').AsString,
                         FieldByName('CTR_ESPDOC').AsString,
                         FieldByName('CTR_CODCLI').AsString,
                         FieldByName('CTR_CODEMP').AsString,
                         FieldByName('CTR_PARCEL').AsString, 0,
                         'BAIXA TOTAL', Self.Name);

            If VS_strHabilitarCRM And (Not fEmptyStr(fCfgSis('OCOFIN', varString)))  Then
            Begin
              TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(FieldByName('CTR_NUMDUP').AsString,
                                                       FieldByName('CTR_ESPDOC').AsString,
                                                       FieldByName('CTR_CODEMP').AsString,
                                                       FieldByName('CTR_CODCLI').AsString,
                                                       FieldByName('CTR_PARCEL').AsString,
                                                       strLoginUsuarioLogado,
                                                       fRetCgcCpf(FieldByName('CTR_CODCLI').AsString),
                                                       afcBaixaTotal, True);
            End;

            If Not fCfgSis('PERHBD', VarBoolean) Then
              BaixaAutomaticaAgendamentosEmAberto(FieldByName('CTR_NUMDUP').AsString,
                                                  FieldByName('CTR_ESPDOC').AsString,
                                                  FieldByName('CTR_CODEMP').ASString,
                                                  FieldByName('CTR_CODCLI').AsString,
                                                  FieldByName('CTR_PARCEL').AsString);

            If fApagarBoletoDeAdiantamentoPedido() Then
            Begin
              fApagaDuplicataContasReceber(cdsTmpResumoCaixa,'BAIXA DUPLICATA/INCLUSAO DE ADIANTAMENTO (REMESSA AUTOMATICA - BOLETO DE ADIANTAMENTO)');

              FillChar(documento, SizeOf(documento), #0);
              FillChar(dadosAdiantamento, SizeOf(dadosAdiantamento), #0);

              documento.strNumDoc := cdsTmpResumoCaixa.FieldByName('CTR_NUMDUP').AsString;
              documento.strEspDoc := cdsTmpResumoCaixa.FieldByName('CTR_ESPDOC').AsString;
              documento.strCodEmp := cdsTmpResumoCaixa.FieldByName('CTR_CODEMP').AsString;
              documento.strCodCli := cdsTmpResumoCaixa.FieldByName('CTR_CODCLI').AsString;
              documento.fltValLan := cdsTmpResumoCaixa.FieldByName('CTR_VALREC').AsFloat;

              documento.fltValLan := IIF(documento.fltValLan > cdsTmpResumoCaixa.FieldByName('CTR_VALDUP').AsFloat,
                                         cdsTmpResumoCaixa.FieldByName('CTR_VALDUP').AsFloat,
                                         documento.fltValLan);

              dadosAdiantamento.AddDocumento(documento);

              dadosAdiantamento.strDescri :=
                'BAIXA DUPLICATA/INCLUSAO DE ADIANTAMENTO ' + fInfDup('CTR_NUMDUP', 'Docto.') +
                                                              fInfDup('CTR_ESPDOC', 'Esp.') +
                                                              fInfDup('CTR_NUMDUP', 'Parc.') +
                                                              fInfDup('CTR_CODEMP', 'Emp.') +
                                                              fInfDup('CTR_NOSNUM', 'Nosso Nº') +
                                                              fInfDup('CTR_DTABOL', 'Emiss.') +
                                                              fInfDup('CTR_BCOBOL', 'Banco') +
                                                              fInfDup('CTR_CARTEI', 'Cartei.') +
                                                              fInfDup('CTR_BCOENV', 'Bco Envio') +
                                                              fInfDup('CTR_DTAENV', 'Dta Envio') +
                                                              fInfDup('CTR_LINDIG', 'Lin.Digit.');

              dadosAdiantamento.strParcel := cdsTmpResumoCaixa.FieldByName('CTR_PARCEL').AsString;
              dadosAdiantamento.strNosNum := cdsTmpResumoCaixa.FieldByName('CTR_NOSNUM').AsString;
              dadosAdiantamento.strDtaBol := cdsTmpResumoCaixa.FieldByName('CTR_DTABOL').AsString;
              dadosAdiantamento.strBcoBol := cdsTmpResumoCaixa.FieldByName('CTR_BCOBOL').AsString;
              dadosAdiantamento.strBcoEnv := cdsTmpResumoCaixa.FieldByName('CTR_BCOENV').AsString;
              dadosAdiantamento.strDtaEnv := cdsTmpResumoCaixa.FieldByName('CTR_DTAENV').AsString;
              dadosAdiantamento.strCartei := cdsTmpResumoCaixa.FieldByName('CTR_CARTEI').AsString;
              dadosAdiantamento.strLinDig := cdsTmpResumoCaixa.FieldByName('CTR_LINDIG').AsString;
              dadosAdiantamento.strCodCed := cdsTmpResumoCaixa.FieldByName('CTR_CODCED').AsString;
              dadosAdiantamento.strOrigem := 'RCX';
              dadosAdiantamento.strTipLan := 'C';
              dadosAdiantamento.dtaDtaLan := VS_Date;
              dadosAdiantamento.horHorLan := fTime();
              dadosAdiantamento.strCodPor := fCfgSis('PORRCX');
              dadosAdiantamento.strCodCta := strCtaBai;
              dadosAdiantamento.strOpeLan := strLoginUsuarioLogado;
              dadosAdiantamento.strEmpLan := VS_strCodEmp;
              dadosAdiantamento.intSeqCon := intSeqCon;
              dadosAdiantamento.fltValDin := IIF(blnGraVDp, FieldByName('CTR_VALREC').AsFloat, fltAuxDin);
              dadosAdiantamento.fltValChV := fltAuxCqv;
              dadosAdiantamento.fltValChP := fltAuxCqP;
              dadosAdiantamento.fltValCar := fltAuxCar;
              dadosAdiantamento.fltValOrd := fltAuxOrd;
              dadosAdiantamento.fltValCre := 0.00;
              dadosAdiantamento.fltValLan := documento.fltValLan;

              TAdiantamentoGenerico.fGravaAdiantamentoCliente(dadosAdiantamento);

              TAdiantamentoGenerico.pAtualizaValorBoletosAdiantamentoDoPedido(documento.strNumDoc,
                documento.strEspDoc, documento.strCodEmp, documento.strCodCli);
            End;

          End;

        End;

        If (Result) And (Not blnGerouLib) Then
        Begin
          pGeraLogLiberacao(FieldByName('CTR_NUMDUP').AsString,
                            FieldByName('CTR_ESPDOC').AsString,
                            FieldByName('CTR_CODEMP').AsString);
          blnGerouLib := True;
        End;

        If Assigned(objProrrogacao) Then
        Begin
          If(cdsTmpResumoCaixa.FieldByName('CTR_MARDES').AsString = 'M') And
            (cdsTmpResumoCaixa.FieldByName('CTR_DTAVEN').AsDateTime < VS_DATE) Then
          Begin
            objProrrogacao.pAdicionarDuplicataNoArrayProrrogacao(cdsTmpResumoCaixa,cdsTmpResumoCaixa.RecNo,True,dtaDtaCai);
          End;
        End;

        LDesmembrarBaixaReceber.AdicionarDuplicata(cdsTmpResumoCaixa.FieldByName('AUTOINCREM').AsString);

        Next;

      End;

      EnableControls;

    End;

    {*******************************************}
    {* FAZ O ACERTO DO RATEIO                  *}
    {****************************************RV*}
    If (Not fAcertaRateio(cdsRateio, 0, (fFormataFloat(fltTotRec,2) <= fFormataFloat((fltTotCre * -1),2)))) Then
    Begin
      fRollBack;
      cdsTmpResumoCaixa.EnableControls;
      Exit;
    End;



    APortadorTfDesmembCadRec := LPortadorTFAutomatica;
    If (LRecebidoPorPix = 'S') And Assigned(FObjetoPixRecebimento) Then
    Begin
      LPixDao := TPixDao.Create;
      Try
        APortadorTfDesmembCadRec := LPixDao.RetornaPortadorChavePix(FObjetoPixRecebimento.AutoIncremChavePix);
      Finally
        FreeAndNil(LPixDao);
      End;
    End;

    //Aqui sera feito o desmembramento do titulo por especies de pagamento
    LDesmembrarBaixaReceber.ProcessarDesmembramentos(fltDinRec,
                                                     fltCarRec,
                                                     fltChqPre,
                                                     fltChqRec,
                                                     fltOrdRec,
                                                     APortadorTfDesmembCadRec,
                                                     fltValCre);

    {*********************************************************************************}
    {* VERIFICAR TRANSAÇÃO ANTES DE GRAVAR O RESUMO DE CAIXA. ************************}
    {* QUANDO ACONTECIA ALGUM ERRO ESTAVA DANDO ROLLBACK SOMENTE DAQUI PRA CIMA. *****}
    {* DESSA FORMA É GARANTIDO QUE EXECUTA O ROLLBACK EM TUDO OU COMITA NA TRANSAÇÃO *}
    {**REQ*111275******************************************************************MO*}
    If Not (frmModulo.GetCurrentConnection.InTransaction) Then
      Result := False;

    {*******************************************}
    {* EFETUA GRAVAÇÃO DO CAIXA NORMAL         *}
    {****************************************MV*}
    If Result Then
      Result := fGravaResCai(RCX_GRAVA_NORMAL, strAutIncCadRecCredito, stlSeqBai);

    If (Not Result) Then
    Begin
      log('houve um problema ao gravar o cadrcxx RCX_GRAVA_NORMAL');
      fRollBack;
      Exit;
    End;

    If pgcDadosGerais.ActivePage = tbsLancamentos Then
    Begin
      If LancamentoDeTransferenciaSemMovBan(intSeqCon) Then
      Begin
        fRollBack;

        fMensagem('ATENÇÃO', 'Há uma inconsistência na gravação do lançamento de transferência.' + #13 +
                             'Feche o Resumo de Caixa e realize o lançamento novamente.', ['&Ok']);

        Exit;
      End;
    End;

    {*******************************************}
    {* GRAVA QUANDO HOUVER DESCONTO            *}
    {****************************************MV*}
    If (fFormataFloat(fltDesRec, 2) > 0.0) Then
    Begin

      If Result Then
        Result := fGravaResCai(RCX_GRAVA_DESCONTO, '');
      If (Not Result) Then
      Begin
        log('houve um problema ao gravar o cadrcxx RCX_GRAVA_DESCONTO');
        fRollBack;
        Exit;
      End;

    End;

    If (fFormataFloat(fltValJur, 2) > 0.0) Then
    Begin

      If Result Then
        Result := fGravaResCai(RCX_GRAVA_JUROS, '');
      If (Not Result) Then
      Begin
        log('houve um problema ao gravar o cadrcxx RCX_GRAVA_JUROS');
        fRollBack;
        Exit;
      End;

    End;

    {*******************************************}
    {* GRAVA QUANDO HOUVER DESPESA DE COBRANÇA *}
    {*****************Req.86252**18/04/2018**WS*}
    If (fFormataFloat(fltValCob, 2) > 0.0) Then
    Begin

      If Result Then
        Result := fGravaResCai(RCX_GRAVA_DESPCOBR, '');
      If (Not Result) Then
      Begin
        log('houve um problema ao gravar o cadrcxx RCX_GRAVA_DESPCOBR');
        fRollBack;
        Exit;
      End;

    End;

    log('gravou os cadrecs...');

    {***********************************************************}
    {* REALIZA GRAVAÇÃO DA MOVBAN DA ORDEM DE PAGTO.            }
    {* CASO A CFG 'CXMVTP' SEJA = 2 E NÃO SEJA RECEBIMENTO PIX *}
    {***********************************************************}
    If (Result) And (fFormataFloat(fltOrdRec, 2) > 0.0) And (Not LGravarregistropix) And (objResumoDeCaixa.TransferenciaOrdemPagamentoAutomatica) Then
    Begin

      If objResumoDeCaixa.RecebimentoFoiLancadoNaCADRCXX(intSeqcon,
                                                         VS_strCodEmp,
                                                         dtaDtaCai,
                                                         edtCodigoCaixa.Text) Then
      Begin
        Result := objResumoDeCaixa.InserirRegistroTFOrdemPagtoCaixa(edtCodOpe.Text,
                                                                    VS_strCodEmp,
                                                                    dtaDtaCai,
                                                                    fltOrdRec,
                                                                    edtCodigoCaixa.Text,
                                                                    LSeqConTransferenciaOrdPgto,
                                                                    intSeqCon,
                                                                    LRecebidoPorPix,
                                                                    LPortadorTFAutomatica);
        If Result Then
          Result := objResumoDeCaixa.InserirRegistroTFOrdemPagtoNaMOVBAN(edtCodOpe.Text,
                                                                         VS_strCodEmp,
                                                                         dtaDtaCai,
                                                                         fltOrdRec,
                                                                         edtCodigoCaixa.Text,
                                                                         strCodCliMB,
                                                                         LSeqConTransferenciaOrdPgto,
                                                                         LPortadorTFAutomatica,
                                                                         Self.Name,
                                                                         strSeqRcx,
                                                                         AAutoIncremStr);

        If (Not Result) Then
        Begin
          log('houve um problema ao gravar o registro de ordem de pagamento o caixa e a transferência');
          fRollBack;
          Exit;
        End;
      End;

    End;

    {*******************************************}
    {* REALIZA GRAVAÇÃO DO CARTÃO              *}
    {****************************************MV*}
    LblnGravouCartaoTEF := False ;
    If ((fltCarRec > 0.0) And (fCfgSis('USACTC', varBoolean))        And
       (( Pos( strEspDoc, strEspLancamentos ) <= 0 ) Or (Pos(strEspDoc, 'LC_CC') > 0)) And
       (fCfgSis('DIGCAR') = 'S')) Then
    Begin
      If Length(arrCartoes) > 0 Then
      Begin
        strHisCar := Copy(strHisCar, 1, Length(strHisCar) - 1);
        If (Pos('/', strHisCar) = 0) Then
          strHisCar := 'REF. AO DOC. ' + Copy(strHisCar, 1, 250 - Length('REF. AO DOC. '))
        Else
          strHisCar := 'REF. AOS DOCS. ' + Copy(strHisCar, 1, 250 - Length('REF. AOS DOCS. '));
      End;

      For intContador1 := 0 To Length(arrCartoes) -1 Do
      Begin

        strCodCar := arrCartoes[intContador1].strCodCar;
        strDesCar := arrCartoes[intContador1].strDesCar;
        fltValTot := arrCartoes[intContador1].fltValDig;
        strConPag := arrCartoes[intContador1].strCndPag;
        strNumCcd := arrCartoes[intContador1].strNumCcd;
        strHisTor := arrCartoes[intContador1].strObsCar;
        fltPerCar := arrCartoes[intContador1].fltPerDes;
        fltValDes := arrCartoes[intContador1].fltValDes;
        strTipCar := arrCartoes[intContador1].strTipCar;
        dtaDatTra := arrCartoes[intContador1].dtaDtaTra;

        fltCarIpi := arrCartoes[intContador1].fltValIpi;
        fltCarRet := arrCartoes[intContador1].fltValRet;
        fltCarAce := arrCartoes[intContador1].fltValAce;
        fltCarFre := arrCartoes[intContador1].fltValFre;
        fltCarCbs := arrCartoes[intContador1].fltValCbs;
        fltCarIbs := arrCartoes[intContador1].fltValIbs;
        fltCar_Is := arrCartoes[intContador1].fltVal_Is;
        If Not fEmptyStr(arrCartoes[intContador1].strNumNsu) Then
          strNumNsu := fPadL(arrCartoes[intContador1].strNumNsu, 14, '0')
        Else
          strNumNsu := '';

        strPixS_N := arrCartoes[intContador1].strPixS_N;
        strChaPix := arrCartoes[intContador1].strChaPix;
        strCodigoCarteiraDigital := arrCartoes[intContador1].strCodigoCarteiraDigital;
        LstrControle := arrCartoes[intContador1].strControle;

        intQtdPar := fCfgSis('PARCAR', varInteger);

        LTipoParcelamento := '';

        {$IFNDEF LINUX}
          LTipoParcelamento := fCampoTabela('CAR_ARRPAR', 'CADCAR', ['CAR_CODCAR'], [strCodCar]);

          If (strTipCar = 'POS') And (LTipoParcelamento <> 'N') Then
            objArredondaParcela := TArredondaParCartaoPos.fArredondamentoParcelas(strCodCar)
          Else
            objArredondaParcela := fArredondamentoParcelas(strCodCar);
        {$ELSE}
          objArredondaParcela := fArredondamentoParcelas(strCodCar);
        {$ENDIF LINUX}

        LDataBaseCartao := RetornaDataBaseCartao(VS_Date, dtaDatTra);

        fDigDuplicVar(strConPag, 0, fltValTot, False, False, False, LDataBaseCartao, False, arrDuplicata, 0, 'N', False, False, 0, objArredondaParcela);
        SetLength(arrDuplOri, Length(arrDuplicata));

        For intContCopia := 0 To intQtdPar - 1 Do
        Begin
          If (intContCopia <= Length(arrDuplicata) - 1) Then
            arrDuplOri[intContCopia] := arrDuplicata[intContCopia]
          Else
            Break;
        End;

        fDigDuplicVar(strConPag, 0, fltValDes, False, False, False, LDataBaseCartao, False, arrDuplicata   , 0, 'N', False, False, 0, objArredondaParcela);
        fDigDuplicVar(strConPag, 0, fltCarIpi, False, False, False, LDataBaseCartao, False, arrDuplicCarIpi, 0, 'N', False, False, 0, objArredondaParcela);
        fDigDuplicVar(strConPag, 0, fltCarRet, False, False, False, LDataBaseCartao, False, arrDuplicCarRet, 0, 'N', False, False, 0, objArredondaParcela);
        fDigDuplicVar(strConPag, 0, fltCarAce, False, False, False, LDataBaseCartao, False, arrDuplicCarAce, 0, 'N', False, False, 0, objArredondaParcela);
        fDigDuplicVar(strConPag, 0, fltCarFre, False, False, False, LDataBaseCartao, False, arrDuplicCarFre, 0, 'N', False, False, 0, objArredondaParcela);
        fDigDuplicVar(strConPag, 0, fltCarCbs, False, False, False, LDataBaseCartao, False, arrDuplicCarCbs, 0, 'N', False, False, 0, objArredondaParcela);
        fDigDuplicVar(strConPag, 0, fltCarIbs, False, False, False, LDataBaseCartao, False, arrDuplicCarIbs, 0, 'N', False, False, 0, objArredondaParcela);
        fDigDuplicVar(strConPag, 0, fltCar_Is, False, False, False, LDataBaseCartao, False, arrDuplicCar_Is, 0, 'N', False, False, 0, objArredondaParcela);

        strCodCliCartao := IIF(Pos(strEspDoc, 'LC_') > 0, fCfgSis('CLIRCX'), IIF(Pos(strEspDoc, 'CC_') > 0, strCliCco, strCodCli));

        Result := False;
        For intContador2 := 0 to Length(arrDuplicata) - 1 Do
        Begin
          If (Not fEmptyStr(arrDuplicata[intContador2].strSequen)) Then
            Result := True;
        End;

        If (Result) And (Not fEmptyStr(strCodCliCartao)) Then
        Begin

          intContador2 := 0;
          While (intContador2 < Length(arrDuplicata)) Do
          Begin

            If (Not fEmptyStr(arrDuplicata[intContador2].strSequen)) And (Result) Then
            Begin
              If fFormataFloat(arrDuplOri[intContador2].curValor, 2) > 0 Then
                Result := fGravaMovCar(Self.Name,
                                       'INCLUSÃO',
                                       arrCartoes[intContador1].strNumDup,
                                       strCodCliCartao,
                                       arrDuplicata[intContador2].strSequen,
                                       VS_strCodEmp,
                                       strCodCar,
                                       VS_Date,
                                       StrToDate(arrDuplicata[intContador2].dtaDtaVen),
                                       arrDuplicata[intContador2].curValor,
                                       arrDuplicata[intContador2].curValor,
                                       strHisTor,
                                       strHisCar,
                                       strConPag,
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
                                       fltPerCar,
                                       arrDuplOri[intContador2].curValor,
                                       arrDuplOri[intContador2].curValor - arrDuplicata[intContador2].curValor,
                                       strNumCcd,
                                       untCadRcxx.strDocume +
                                         IIF(untCadRcxx.strDocume <> 'DIVERSOS', '-' + fStrZero(intSeqBai,3),''),
                                       '',
                                       intSeqCon,
                                       VS_strCodEmp,
                                       edtCodOpe.Text,
                                       True,
                                       '',
                                       'B',
                                       '',
                                       strTipCar,
                                       arrDuplicCarIpi[intContador2].curValor,
                                       arrDuplicCarRet[intContador2].curValor,
                                       arrDuplicCarAce[intContador2].curValor,
                                       arrDuplicCarFre[intContador2].curValor,
                                       strNumNsu,
                                       '',
                                       dtaDatTra,
                                       0,
                                       0,
                                       0,
                                       edtCodigoCaixa.Text,
                                       false,
                                       '',
                                       strChaPix,
                                       strPixS_N,
                                       0,
                                       False,
                                       strCodigoCarteiraDigital,
                                       LstrControle,
                                       '',
                                       0,
                                       '',
                                       '',
                                       '',
                                       arrDuplicCarCbs[intContador2].curValor,
                                       arrDuplicCarIbs[intContador2].curValor,
                                       arrDuplicCar_Is[intContador2].curValor);
            End;

            Inc(intContador2);

            If (Not Result) Then
            Begin
              fRollBack;
              Exit;
            End;

          End;
        End
        Else
        Begin
          If fEmptyStr(strCodCliCartao) Then
            strDifVal := 'O código do cliente está vazio.';

          fRollBack;
          pMensagemOk('Ocorreu uma inconsistência na gravação do(s) cartão(ões)!' + #13#10 +
                strDifVal + #13#10 + 'Feche o Resumo de Caixa e tente novamente! Se o problema persistir entre em contato com a Citel!');
          Exit;
        End;

        Result := fGravaMovTef(intSeqCon, VS_strCodEmp, arrCartoes[intContador1].strNumDup,
              VS_strCodEmp, strCodCliCartao, arrCartoes[intContador1].strConteudoArquivo, strTpParc);

        pLog('arrCartoes[intContador1].strTipCar = '+arrCartoes[intContador1].strTipCar);
      End;
      LblnGravouCartaoTEF := True ;
    End;

    log('gravou os cartões...');

    {*******************************************}
    {* REALIZA GRAVAÇÃO DOS CHEQUES            *}
    {****************************************MV*}
    If ((Not cdsChqPre.IsEmpty) Or (Not cdsChqVis.IsEmpty)) Or
       (strEspDoc = 'LC') Then
    Begin
      log('Vamos gravar os cheques...');
      If Result Then
        Result := fGravaCheques(intSeqBai);

      If (Not Result) Then
      Begin
        log('Houve um problema para gravar o cheque...');
        fRollBack;
        Exit;
      End;

    End;

    {*******************************************}
    {* REALIZA GRAVAÇÃO E TRANSFERÊNCIA DO PIX *}
    {****************************************AJ*}
    If LGravarRegistroPix Then
    Begin
      FObjetoPixRecebimento.SeqConRecebimento := intSeqCon;
      FObjetoPixRecebimento.DataCaixa := dtaDtaCai;

      TFuncoesPixAutcom.GravarRegistroPixBaixado(FObjetoPixRecebimento,
                                                 True,
                                                 True,
                                                 edtCodOpe.Text,
                                                 Self.Name);

      If (objResumoDeCaixa <> nil) And (Not fEmptyStr(AAutoIncremStr) ) Then
      Begin
         If fCampoTabela('POR_BAIUTL', 'CADPOR', ['POR_CODPOR'], [FObjetoPixRecebimento.CodigoPortador]) = 'S' Then
            objResumoDeCaixa.pAtualizaDataLanctoCadRec(AAutoIncremStr, fAcertaDataParaDiaUtil(VS_Date) );
      End;

    End;

    {*******************************}
    {* ANALISA GRAVAÇÃO            *}
    {*26/02/2015*REQ:22285*******AF*}
    If Not fGravaLogControle(strDifVal, intSeqCon, True) Then
    Begin
      log('Houve um problema com a análise de fGravaLogControle(intSeqCon, True)');
      fRollBack;

      pMensagemOk('Ocorreu uma inconsistência na gravação dos valores!' + #13#10 +
                  strDifVal + #13#10 + 'Feche o Resumo de Caixa e tente novamente! Se o problema persistir entre em contato com a Citel!');

      Exit;
    End;

    {*******************************}
    {* ANALISA GRAVAÇÃO DO CAIXA   *}
    {*15/04/2015*REQ:32610*******AF*}
    If (fEmptyStr(strEspDoc) Or (Pos(strEspDoc, 'LC_CC_') > 0)) Then
    Begin

      If Not fVerificaGrvCartaoCheque(strDifVal, intSeqCon, VS_strCodEmp) Then
      Begin
        Result := False;
        fRollBack;

        pMensagemOk('Ocorreu uma inconsistência na gravação dos valores do caixa com cartões/cheques!' + #13#10 +
                    strDifVal + #13#10 + 'Tente realizar a gravação novamente! Se o problema persistir entre em contato com a Citel!');

        Exit;
      End;

    End;

    If Not blnGerouLib Then
      pGeraLogLiberacao('', '', '');

    If objResumoDeCaixa.CaixaFoiFechadoNoMeioDaBaixa(dtaDtaCai, LDataHoraInicioBaixa, edtCodigoCaixa.Text, LOperadorFechamento) Then
    Begin
      fRollBack;

      fMensagem('ATENÇÃO', 'Recebimento não confirmado.' + sLineBreak + sLineBreak +
                           'O caixa foi fechado pelo operador ' + LOperadorFechamento + ' enquanto a operação estava em andamento.' + sLineBreak +
                           IIF(objResumoDeCaixa.strTipoFechamento.Equals('C'),
                               'Confirme novamente o recebimento.',
                               'Cancele o fechamento do caixa e confirme novamente.'), ['&Ok']);

      FreeAndNil(LDesmembrarBaixaReceber);
      FreeAndNil(stlSeqBai);
      FreeAndNil(cdsRateio);

      Exit(False);
    End;

    fCommit;
    objLock.pDestravarTodos;
    If Assigned(objProrrogacao) Then
    Begin
      objProrrogacao.pInativarClientePorProrrogacao;
      objProrrogacao.pLimparArrays;
    End;

    Try
      If (fStrToFloat(edtCarRec.Text) > 0.0) And (fCfgSis('USACTC', varBoolean)) Then
      Begin

        if LblnGravouCartaoTEF then
        begin
          For intContador1 := 0 To Length(arrCartoes) -1 Do
          Begin
            if VS_blnTefCitel then
            begin
              if fVerificaUtilizouTEFCitel(arrCartoes[intContador1].strViaCli, arrCartoes[intContador1].strViaLoj) then
              begin
                if arrCartoes[intContador1].blnTefCnf then
                begin
                  pAtualizaDadosFaturamentoTef(
                    '',
                    '',
                    IntToStr(intSeqCon),
                    arrCartoes[intContador1].strViaCli,
                    arrCartoes[intContador1].strViaLoj,
                    arrCartoes[intContador1].strNumDoc,
                    arrCartoes[intContador1].strDtaTra);
                  arrCartoes[intContador1].strStatusCartao := 'FC';
                end
                else
                begin
                  if fFinalizaCartao(arrCartoes[intContador1].strNumDoc,
                                     arrCartoes[intContador1].strDtaTra,
                                     arrCartoes[intContador1].strHraTra,
                                     arrCartoes[intContador1].strViaCli,
                                     arrCartoes[intContador1].strViaLoj,
                                     arrCartoes[intContador1].strNumNsu,
                                     '',
                                     '',
                                     arrCartoes[intContador1].fltValDig,
                                     arrCartoes[intContador1].strViaCli +#13+ arrCartoes[intContador1].strViaLoj,
                                     IntToStr(intSeqCon),
                                     arrCartoes[intContador1].strControle) then
                  begin
                    arrCartoes[intContador1].strStatusCartao := 'F';
                  end;
                end;
              end;
            end;
          end ;
        end ;

        blnErroConfirmacao := False;
        If (Not objTefRecebimento.fConfirmaCartoes(strInfConfCar)) Then
        Begin
          blnErroConfirmacao := True;
        End;

        If (blnErroConfirmacao) Then
        Begin
          log('Houve um problema na confirmação do TEF de Recebimento...' + sLineBreak +
              strInfConfCar );

          fMensagem('Atenção!', 'Ocorreu um problema na confirmação do TEF.' + sLineBreak +
                                'Favor verificar se os cartões foram confirmados.' + sLineBreak +
                                strInfConfCar, ['&OK']);
        End;

      End;

      If Pos(strEspDoc,'LD_PG_') > 0 Then
        pImprimirSangria(fltDinRec, fltCarRec, fltChqRec, fltChqPre, fltOrdRec)
      Else If Pos(strEspDoc,'LC_CC_') > 0 Then
        pImprimirSuprimento(fltDinRec, fltCarRec, fltChqRec, fltChqPre, fltOrdRec);

      {*****************************************}
      {* CASO USE IMPRESSORA DE CHEQUES, ENVIA *}
      {* OS CHEQUES.                           *}
      {**************************************MV*}
      If fCfgSis('USAICH', varBoolean) Then
      Begin
        pEnviaChequesImpChq(cdsChqVis, cdsChqPre);
      End;

      If (Not fImprimirCarnePagamentos) Then
      Begin
        If ((strEspDoc = 'LC') And (fCfgSis('RCXIMPLC') = 'S')) Or
           ((strEspDoc = 'PG') And (fCfgSis('RCXIMPPG') = 'S')) Or
           ((strEspDoc = 'LD') And (fCfgSis('RCXIMPLD') = 'S')) Or
           (Pos(strEspDoc, 'LC_PG_LD_') = 0) Then
        Begin
          If fMensagem('','Imprimir Recibo ?',['&Sim','&Não'], IIF(fCfgSis('SUGREC', varBoolean), 1, 2)) = 1 Then
          Begin
            If Pos(strEspDoc,strEspLancamentos) > 0 Then
              pImprimeRecibo(1)
            Else
              pImprimeRecibo(2);
          End;
        End;
      End;

      If fVerificaTemCreditos Then
      begin
        If (fCfgSis('IMPCPC') = 'S') Then
        Begin
          If (fMensagem('', 'Deseja imprimir o recibo de créditos pendentes do cliente?', ['&Sim', '&Não']) = 1) Then
            TfrmQckRcxRecCredPenCli.pImprimeRcxRecCredPenCli(edtCodCli.Text, Self.Name);
        End;
      end;
    Finally
      If cdsTmpResumoCaixa.Active Then
        cdsTmpResumoCaixa.EmptyDataSet;

      If Assigned(LDesmembrarBaixaReceber) Then
        FreeAndNil(LDesmembrarBaixaReceber);

      cdsChqVis.EmptyDataSet;
      cdsChqPre.EmptyDataSet;
    End;

    fGravaLogControle(strDifVal, intSeqCon);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[fConfirmaResumoCaixa]');
      Result := False;
    End;
  End;

  FreeAndNil(stlSeqBai);
  FreeAndNil(cdsRateio);

  if blnChqPreLiberado then 
    blnChqPreLiberado := False;
end;

procedure TfrmRcxResumoCaixa.pVerificaPendenciaChequesPDV;
  Var
    qryCheque: TUniQuery;
begin
  qryCheque := fCriaQuery(Nil);
  qryCheque.SQL.Add('SELECT * FROM PAF_CHEQUES WHERE CHQ_DUPLIC = 1 AND CHQ_CODEMP = :CODEMP ');
  qryCheque.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryCheque.Open;

  If (Not qryCheque.IsEmpty) Then
  Begin
    While (Not qryCheque.Eof) Do
    Begin
      pCriarFormularios(TfrmImportaPAFECFCheques, frmImportaPAFECFCheques);
      Try
        frmImportaPAFECFCheques.strIdLoc := qryCheque.FieldByName('CHQ_ID_LOC').AsString;
        frmImportaPAFECFCheques.strIdDoc := qryCheque.FieldByName('CHQ_ID_DOC').AsString;
        frmImportaPAFECFCheques.strCodBco := qryCheque.FieldByName('CHQ_CODBCO').AsString;
        frmImportaPAFECFCheques.strNumAge := qryCheque.FieldByName('CHQ_NUMAGE').AsString;
        frmImportaPAFECFCheques.strConCor := qryCheque.FieldByName('CHQ_CONCOR').AsString;
        frmImportaPAFECFCheques.strNumChq := qryCheque.FieldByName('CHQ_NUMCHQ').AsString;
        frmImportaPAFECFCheques.ShowModal;
      Finally
        pFreeAndNil(frmImportaPAFECFCheques);
      End;

      qryCheque.Next;
    End;
  End
  Else
  Begin
    pMensagemOk('Não há mais cheques para corrigir.');
  End;

  FreeAndNil(qryCheque);
end;

procedure TfrmRcxResumoCaixa.pVerificaSobraCredito;
  Var
    fltValPar        : Double;
    blnLibOut        : Boolean;
    strIndiceAnterior: String;
begin

  Try

    blnLibOut := False;

    If (cdsTmpResumoCaixa.IsEmpty) Then
      Exit;

    fltValPar := fltValDoc;
    {*****************************************}
    {* Apura diferença de crédito x recebido *}
    {* para gravar a CADRCXX corretamente    *}
    {**************************************JS*}
    fltDifCre := 0;
    If (fltTotRec + fltTotCre < 0.0) Then
      fltDifCre := fltTotRec + fltTotCre;

    If (blnQuitacao) And (fltTotRec + fltTotCre > 0.0) Then
      fltValPar := -fltTotCre;

    If (fltValDoc = 0.0) And (fltTotCre < 0.0) Then
      fltValPar := -fltTotCre;

    If (fltValPar = 0.0) Then
      Exit;

    strIndiceAnterior                 := cdsTmpResumoCaixa.IndexFieldNames;
    cdsTmpResumoCaixa.IndexFieldNames := 'CTR_VALDUP';

    cdsTmpResumoCaixa.DisableControls;
    cdsTmpResumoCaixa.Last;

    While (Not cdsTmpResumoCaixa.Bof) Do
    Begin

      If (cdsTmpResumoCaixa.FieldByName('CTR_MARDES').AsString <> 'M') Or
         (cdsTmpResumoCaixa.FieldByName('CTR_VALREC').AsFloat > 0.0) Then
      Begin
        cdsTmpResumoCaixa.Prior;
        Continue;
      End;

      cdsTmpResumoCaixa.Edit;
      If (blnLibOut) Then
      Begin
        cdsTmpResumoCaixa.FieldByName('CTR_MARDES').AsString := 'D';
        cdsTmpResumoCaixa.Post;
        cdsTmpResumoCaixa.Prior;

        Continue;
      End;

      If ((cdsTmpResumoCaixa.FieldByName('CTR_VALREC').AsFloat * -1) >= fFormataFloat(fltValPar,2)) Then
      Begin
        cdsTmpResumoCaixa.FieldByName('CTR_SOBCRE').AsFloat := -fltValPar;
        blnLibOut := True;
      End
      Else
      Begin
        cdsTmpResumoCaixa.FieldByName('CTR_SOBCRE').AsFloat := cdsTmpResumoCaixa.FieldByName('CTR_VALREC').AsFloat;
        fltValPar := fFormataFloat(fltValPar + cdsTmpResumoCaixa.FieldByName('CTR_VALREC').AsFloat,2);
      End;
      cdsTmpResumoCaixa.Post;

      cdsTmpResumoCaixa.Prior;
    End;

    cdsTmpResumoCaixa.IndexFieldNames := strIndiceAnterior;

    cdsTmpResumoCaixa.EnableControls;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('[pVerificaSobraCredito] - ' + E.Message);
    End;
  End;

end;

{*******************************************}
{* SE NAO FOR QUITACAO DEIXA SELECIONADAS  *}
{* SOMENTE AS DULICATAS CUJO CREDITO SEJA  *}
{* SUFICIENTE PARA A BAIXA                 *}
{****************************************MV*}
procedure TfrmRcxResumoCaixa.pSelecionaDupNaoQuitacao;
  Var
    fltValAba: Double;
    LValorDesconto,
    LValorDespesas,
    LValorJuros,
    LFatorDescontoDuplicata,
    LFatorDespesasDuplicata,
    LDiferenca: Double;
    LTotalRecebido:Double;
begin
  LTotalRecebido := 0;
  Try
    If (cdsTmpResumoCaixa.IsEmpty) Then
    Begin
      Exit;
    End;

    If (fltTotCre = 0.0) Then
    Begin
      Exit;
    End;

    fltValAba := fltValDoc;

    If (fltValAba = 0.0) Then
    Begin
      Exit;
    End;

    fltDesRec := 0.0;
    fltValJur := 0.0;

    With cdsTmpResumoCaixa Do
    Begin

      DisableControls;
      First;

      While (Not Eof) Do
      Begin

        If (FieldByName('CTR_MARDES').AsString <> 'M') Then
        Begin
          Next;
          Continue;
        End;

        If (FieldByName('CTR_VALDUP').AsFloat < 0.0) Then
        Begin
          Next;
          Continue;
        End;

        If (fFormataFloat(fltValAba,2) = 0.0) Then
        Begin
          Edit;
          FieldByName('CTR_MARDES').AsString := 'D';
          Post;
          Next;
          Continue;
        End;

        If (fltValAba > FieldByName('CTR_VALREC').AsFloat) Then
        Begin
          fltValAba := fltValAba - FieldByName('CTR_VALREC').AsFloat;

          fltValJur := fltValJur + FieldByName('CTR_VALJUR').AsFloat;
          fltDesRec := fltDesRec + FieldByName('CTR_VALDES').AsFloat;
        End
        Else
        Begin
          Edit;
          FieldByName('CTR_VALRES').AsFloat := FieldByName('CTR_VALREC').AsFloat - fltValAba;
          FieldByName('CTR_VALREC').AsFloat := fltValAba;

          LValorJuros    := (FieldByName('CTR_VALCOR').AsFloat - FieldByName('CTR_DUPORI').AsFloat);
          LValorJuros    := LValorJuros +
                            FieldByName('CTR_DESSUJ').AsFloat -
                            FieldByName('CTR_DESCOB').AsFloat;

          LValorDesconto := FieldByName('CTR_DESSUJ').AsFloat;
          LValorDespesas := FieldByName('CTR_DESCOB').AsFloat;

          FieldByName('FATORBAIXADUPLICATA').AsFloat := FieldByName('CTR_DUPORI').AsFloat / FieldByName('CTR_VALCOR').AsFloat;
          FieldByName('FATORJUROSDUPLICATA').AsFloat := LValorJuros / FieldByName('CTR_VALCOR').AsFloat;
          LFatorDescontoDuplicata := LValorDesconto/FieldByName('CTR_VALCOR').AsFloat;
          LFatorDespesasDuplicata := LValorDespesas / FieldByName('CTR_VALCOR').AsFloat;

          FieldByName('DESPESASBAIXADUPLICATA').AsFloat := fFormataFloat(FieldByName('CTR_VALREC').AsFloat *
                                                                         LFatorDespesasDuplicata, 2);

          FieldByName('JUROSNOVADUPLICATA').AsFloat := LValorJuros;
          LValorJuros := fFormataFloat(FieldByName('CTR_VALREC').AsFloat * FieldByName('FATORJUROSDUPLICATA').AsFloat, 2);
          FieldByName('JUROSNOVADUPLICATA').AsFloat := FieldByName('JUROSNOVADUPLICATA').AsFloat - LValorJuros;

          FieldByName('DESCONTONOVADUPLICATA').AsFloat := LValorDesconto;
          LValorDesconto := fFormataFloat(FieldByName('CTR_VALREC').AsFloat * LFatorDescontoDuplicata, 2);
          FieldByName('DESCONTONOVADUPLICATA').AsFloat := FieldByName('DESCONTONOVADUPLICATA').AsFloat - LValorDesconto;

          FieldByName('DESPESASNOVADUPLICATA').AsFloat := LValorDespesas;
          LValorDespesas := fFormataFloat(FieldByName('CTR_VALREC').AsFloat * LFatorDespesasDuplicata, 2);
          FieldByName('DESPESASNOVADUPLICATA').AsFloat := FieldByName('DESPESASNOVADUPLICATA').AsFloat - LValorDespesas;

          FieldByName('VALORBAIXADUPLICATA').AsFloat := fFormataFloat(FieldByName('CTR_VALREC').AsFloat *
                                                                      FieldByName('FATORBAIXADUPLICATA').AsFloat, 2);

          LDiferenca := fFormataFloat(FieldByName('CTR_VALREC').AsFloat -
                                      (FieldByName('VALORBAIXADUPLICATA').AsFloat +
                                       LValorJuros +
                                       LValorDespesas -
                                       LValorDesconto),2);

          FieldByName('VALORBAIXADUPLICATA').AsFloat := FieldByName('VALORBAIXADUPLICATA').AsFloat + (LDiferenca);

          FieldByName('VALORNOVADUPLICATA').AsFloat := fFormataFloat(FieldByName('CTR_DUPORI').AsFloat -
                                                                     FieldByName('VALORBAIXADUPLICATA').AsFloat, 2);

          FieldByName('CTR_VALJUR').AsFloat := LValorJuros;
          FieldByName('CTR_VALDES').AsFloat := LValorDesconto;

          Post;

          //fltTotRec := fltTotRec - FieldByName('CTR_VALRES').AsFloat;

          fltValAba := 0.0;

        End;

        LTotalRecebido := LTotalRecebido + FieldByName('CTR_VALREC').AsFloat;
        Next;
      End;

      fltTotRec := fFormataFloat(LTotalRecebido,2);
      EnableControls;

    End;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('[pSelecionaDupNaoQuitacao] - ' + E.Message);
    End;
  End

end;

procedure TfrmRcxResumoCaixa.pSeparaOperadores(frmRcxTrasfValores: TfrmRcxTrasfValores;
  ATFPixAvulso: Boolean);
  Var
    LOperadorAtual: String;

  function fOpeInserido(strCodOpe: String): TTransfOperador;
  var
    objTrOpeIn: TTransfOperador;
  Begin
    Result := nil;
    For objTrOpeIn in oblTransfOperadores Do
    Begin
      if objTrOpeIn.strOperador = strCodOpe Then
      Begin
        Result := objTrOpeIn;
        Break;
      End;
    End;

    If Not Assigned(Result) Then
    Begin
      Result := TTransfOperador.Create(strCodOpe);
      oblTransfOperadores.Add(Result);
    End;
  End;

  procedure pAddValores(strCodOpe: String; intModalidade: Integer; fltValor, fltValor2: Double; APixAvulso: Boolean);
  var
    objTrOpe: TTransfOperador;
  Begin
    {********************************************}
    {* CASO NÃO EXISTA VALOR NÃO INSERE OPERADO *}
    {*REQ*77773*******************************MO*}
    if (fltValor > 0) or (fltValor2 > 0) then
    begin
      objTrOpe := fOpeInserido(strCodOpe);
      Case intModalidade Of
        0: Begin
             objTrOpe.fltDinheiro  := objTrOpe.fltDinheiro + fltValor;
             objTrOpe.fltDinheiro2 := objTrOpe.fltDinheiro2 + fltValor2;
           End;
        1: Begin
             objTrOpe.fltChqAVista  := objTrOpe.fltChqAVista + fltValor;
             objTrOpe.fltChqAVista2 := objTrOpe.fltChqAVista2 + fltValor2;
           End;
        2: Begin
             objTrOpe.fltChqAPrazo  := objTrOpe.fltChqAPrazo + fltValor;
             objTrOpe.fltChqAPrazo2 := objTrOpe.fltChqAPrazo2 + fltValor2;
           End;
        3: Begin
             objTrOpe.fltCartao  := objTrOpe.fltCartao + fltValor;
             objTrOpe.fltCartao2 := objTrOpe.fltCartao2 + fltValor2;
           End;
        4: Begin
             If APixAvulso Then
             Begin
               objTrOpe.PixRec  := objTrOpe.PixRec + fltValor;
               objTrOpe.PixRec2 := objTrOpe.PixRec2 + fltValor2;

               objTrOpe.fltOrdPag  := 0.00;
               objTrOpe.fltOrdPag2 := 0.00;
             End
             Else
             Begin
               objTrOpe.fltOrdPag  := objTrOpe.fltOrdPag + fltValor;
               objTrOpe.fltOrdPag2 := objTrOpe.fltOrdPag2 + fltValor2;

               objTrOpe.PixRec  := 0.00;
               objTrOpe.PixRec2 := 0.00;
             End;
           End;
        5: Begin
             objTrOpe.fltFinanc  := objTrOpe.fltFinanc + fltValor;
             objTrOpe.fltFinanc2 := objTrOpe.fltFinanc2 + fltValor2;
           End;
      End;
    end;
  End;

begin
  If Not Assigned(oblTransfOperadores) Then
    oblTransfOperadores := TObjectList<TTransfOperador>.Create();

  oblTransfOperadores.Clear;

  LOperadorAtual := fCodOpeTransf(frmRcxTrasfValores);

  pAddValores(LOperadorAtual, 0, frmRcxTrasfValores.fltDinhei, frmRcxTrasfValores.fltDinhe2, False);
  pAddValores(LOperadorAtual, 4, frmRcxTrasfValores.fltOrdPag, frmRcxTrasfValores.fltOrdPa2, ATFPixAvulso);
  pAddValores(LOperadorAtual, 5, frmRcxTrasfValores.fltValFin, frmRcxTrasfValores.fltValFi2, False);

  If objResumoDeCaixa.TransferenciaVinculada Then
  Begin
    LOperadorAtual := VS_strCodigoOperadorLogadoCaixa;

    If frmRcxTrasfValores.cdsChqAVi.Active Then
    Begin
      frmRcxTrasfValores.cdsChqAVi.First;
      While Not frmRcxTrasfValores.cdsChqAVi.Eof Do
      Begin
        If objResumoDeCaixa.OperadorTransferenciaVinculadaDeveSerDaVenda Then
          LOperadorAtual := frmRcxTrasfValores.cdsChqAVi.FieldByName('RCX_CODOPE').AsString;

        pAddValores(LOperadorAtual,
                    1,
                    frmRcxTrasfValores.cdsChqAVi.FieldByName('VALOR').AsFloat, 0, False);

        frmRcxTrasfValores.cdsChqAVi.Next;
      End;
    End;

    If frmRcxTrasfValores.cdsChqPre.Active Then
    Begin
      frmRcxTrasfValores.cdsChqPre.First;
      While Not frmRcxTrasfValores.cdsChqPre.Eof Do
      Begin
        If objResumoDeCaixa.OperadorTransferenciaVinculadaDeveSerDaVenda Then
          LOperadorAtual := frmRcxTrasfValores.cdsChqPre.FieldByName('RCX_CODOPE').AsString;

        pAddValores(LOperadorAtual,
                    2,
                    frmRcxTrasfValores.cdsChqPre.FieldByName('VALOR').AsFloat, 0, False);

        frmRcxTrasfValores.cdsChqPre.Next;
      End;
    End;

    If frmRcxTrasfValores.cdsCarCre.Active Then
    Begin
      frmRcxTrasfValores.cdsCarCre.First;
      While Not frmRcxTrasfValores.cdsCarCre.Eof Do
      Begin
        If objResumoDeCaixa.OperadorTransferenciaVinculadaDeveSerDaVenda Then
          LOperadorAtual := frmRcxTrasfValores.cdsCarCre.FieldByName('RCX_CODOPE').AsString;

        pAddValores(LOperadorAtual,
                    3,
                    frmRcxTrasfValores.cdsCarCre.FieldByName('VALOR').AsFloat, 0, False);

        frmRcxTrasfValores.cdsCarCre.Next;
      End;
    End;
  End
  Else
  Begin
    pAddValores(LOperadorAtual, 1, frmRcxTrasfValores.fltChqVis, frmRcxTrasfValores.fltChqVi2, False);
    pAddValores(LOperadorAtual, 2, frmRcxTrasfValores.fltChqPre, frmRcxTrasfValores.fltChqPr2, False);
    pAddValores(LOperadorAtual, 3, frmRcxTrasfValores.fltCartao, frmRcxTrasfValores.fltCarta2, False);
  End;
end;

procedure TfrmRcxResumoCaixa.pShowHint(const AedtEdit: TCustomEdit; const AstrTitulo: String);
begin
  HintControler.ShowHint(Self.Left + AedtEdit.Left + AedtEdit.Width,
                         pnlModalidades.Top + 15 + Self.Top + AedtEdit.Top + AedtEdit.Height, AstrTitulo, AedtEdit.Hint);
end;

function TfrmRcxResumoCaixa.fGravaResCai(intOpcao: Integer; const strAutIncCadRecCredito : String;
  stlSeqBai: TStringList = Nil; strCodOpe: String = ''; fltFundoDeCaixa: Double = 0.00): Boolean;
  Var
    strNumDup: String;
    fltFator: Double;
    fltValDocTmp: Double;

    fltDinRec: Double;
    fltCarRec: Double;
    fltChqRec: Double;
    fltChqPre: Double;
    fltValCre: Double;
    fltOrdRec: Double;
    fltValFin: Double;

    fltValJurTmp: Double;
    fltDesRecTmp: Double;

    strJurDes: String;

    strNumRom: String;

    blnPriReg: Boolean;
    blnDocCre: Boolean;

    intSeqBai: Integer;
    intIdeCai: Integer;

    LRecebidoPorPix: String;

    bck_fltDinRec: Double;
    bck_fltCarRec: Double;
    bck_fltChqRec: Double;
    bck_fltChqPre: Double;
    bck_fltOrdRec: Double;
    bck_fltValFin: Double;

    blnGravouValoresEsp : boolean;
begin

  Try
    FAuditoriaResumoCaixa.Limpar;
    If blnRcxRom And (edtRomaneio.Text <> '') Then
      strNumRom := edtRomaneio.Text
    Else
      strNumRom := '';

    fltDinRec := fStrToFloat(edtDinRec.Text);
    fltCarRec := fStrToFloat(edtCarRec.Text);
    fltChqRec := fStrToFloat(edtChqRec.Text);
    fltChqPre := fStrToFloat(edtChqPre.Text);
    fltOrdRec := fStrToFloat(edtOrdRec.Text);
    fltValFin := fStrToFloat(edtFinanc.Text);

    bck_fltDinRec := fltDinRec;
    bck_fltCarRec := fltCarRec;
    bck_fltChqRec := fltChqRec;
    bck_fltChqPre := fltChqPre;
    bck_fltOrdRec := fltOrdRec;
    bck_fltValFin := fltValFin;

    blnGravouValoresEsp := False;

    fltValJurTmp := 0.0;
    fltDesRecTmp := 0.0;
    fltValDocTmp := 0.0;

    intIdeCai := 2;
    If (strEspDoc = 'PG') Then
    Begin
      fltValJurTmp := fStrToFloat(edtValJur.Text);
      fltDesRecTmp := fStrToFloat(edtValDes.Text);
      intIdeCai    := 1;
    End;

    {******************************************}
    {* Caso não tenha baixado todo o crédito, *}
    {* desconta a diferença do valor final    *}
    {***************************************JS*}
    fltValCre := fltTotCre - fltDifCre;

    fltFator     := IIF(Pos(strEspDoc, 'PG_LD_TF_') > 0, -1, 1);
    blnPriReg    := True;

    With cdsTmpResumoCaixa Do
    Begin

      If (strEspDoc <> 'TF') And (Not IsEmpty) Then
      Begin

        DisableControls;

        First;

        Result := True;

        untCadRcxx.intContaReg := 0;
        While (Not Eof) Do
        Begin

          strJurDes    := '';
          fltValDocTmp := 0.0;

          If (FieldByName('CTR_MARDES').AsString <> 'M') Then
          Begin
            Next;
            Continue;
          End;

          Inc(untCadRcxx.intContaReg);

          If (intOpcao = RCX_GRAVA_DESCONTO) And (FieldByName('CTR_VALDES').AsFloat <= 0) Then
          Begin
            Next;
            Continue;
          End;

          If (intOpcao = RCX_GRAVA_DESPCOBR) And (FieldByName('CTR_DESCOB').AsFloat <= 0) Then
          Begin
            Next;
            Continue;
          End;

          If (intOpcao = RCX_GRAVA_DESPCOBR) And (FieldByName('CTR_BAIPAR').AsString = 'S') Then
          Begin
            Next;
            Continue;
          End;

          If (intOpcao = RCX_GRAVA_DESCONTO) And (fFormataFloat(FieldByName('CTR_VALRES').AsFloat, 02) > fFormataFloat(0.0, 2)) Then
          Begin
            Next;
            Continue;
          End;

          If (intOpcao = RCX_GRAVA_JUROS) Then
          Begin

            If (FieldByName('CTR_VALJUR').AsFloat <= 0) Then
            Begin
              Next;
              Continue;
            End;

            If (FieldByName('CTR_VALRES').AsFloat > 0) Then
            Begin
              Next;
              Continue;
            End;

          End;

          If (Pos(strEspDoc, 'PG_LC_LD_') <= 0) Then
          Begin

            If (intOpcao = RCX_GRAVA_NORMAL) Then
            Begin
              {*******************************************}
              {* CÓDIGO - NOME DO CLIENTE                *}
              {****************************************MV*}
              If Not fEmptyStr(FieldByName('CTR_NOMCLI').AsString) Then
                strDescri := FieldByName('CTR_NOMCLI').AsString
              Else If FindField('CTR_CLIORI') <> Nil Then
                strDescri := FieldByName('CTR_CLIORI').AsString;
            End
            Else If (intOpcao = RCX_GRAVA_DESCONTO) Then
            Begin
              strDescri := 'REF. A DESCONTO ' + FieldByName('CTR_ESPDOC').AsString + ' No. ' + FieldByName('CTR_NUMDUP').AsString;
            End
            Else If (intOpcao = RCX_GRAVA_JUROS) Then
            Begin
              strDescri := 'REF. A JUROS ' + FieldByName('CTR_ESPDOC').AsString + ' No. ' + FieldByName('CTR_NUMDUP').AsString;
            End
            Else If (intOpcao = RCX_GRAVA_DESPCOBR) Then
            Begin
              strDescri := 'REF. A DESP. COB. ' + FieldByName('CTR_ESPDOC').AsString + ' No. ' + FieldByName('CTR_NUMDUP').AsString;
            End;

          End;

          blnDocCre := False;

          If (FieldByName('CTR_VALREC').AsFloat < 0.0) Then
          Begin
            blnDocCre := True;
          End;

          strNumDup := FieldByName('CTR_NUMDUP').AsString;
          If (blnDocCre) Then
          Begin
            If (intOpcao = RCX_GRAVA_DESCONTO) Or
               (intOpcao = RCX_GRAVA_JUROS)    Or
               (intOpcao = RCX_GRAVA_DESPCOBR) Then
            Begin
              Next;
              Continue;
            End;

            fltValDocTmp := FieldByName('CTR_SOBCRE').AsFloat;
          End
          Else
          Begin

            If (intOpcao = RCX_GRAVA_NORMAL) Then
            Begin

              fltValDocTmp := (( FieldByName('CTR_VALDUP').AsFloat  -
                                 FieldByName('CTR_JURSUJ').AsFloat  -
                                 FieldByName('CTR_DESCOB').AsFloat) +
                                 FieldByName('CTR_DESSUJ').AsFloat) ;

              If (FieldByName('CTR_VALRES').AsFloat > 0.0) Then
                fltValDocTmp := FieldByName('CTR_VALREC').AsFloat;

            End
            Else If (intOpcao = RCX_GRAVA_DESCONTO) Then
            Begin
              fltValDocTmp := FieldByName('CTR_VALDES').AsFloat;
            End
            Else If (intOpcao = RCX_GRAVA_JUROS) Then
            Begin
              fltValDocTmp := FieldByName('CTR_VALJUR').AsFloat;
            End
            Else If (intOpcao = RCX_GRAVA_DESPCOBR) Then
            Begin
              fltValDocTmp := FieldByName('CTR_DESCOB').AsFloat;
            End;

          End;

          If (intOpcao = RCX_GRAVA_NORMAL) Then
          Begin

            If (blnDocCre) Then
            Begin

              If (fltTotRec = 0) And (fltTotCre < 0) Then
              Begin
                fltDinRec := fltValDocTmp * fltFator;
              End;

            End
            Else
            Begin

              If (blnPriReg) Then
              Begin

                If (fltValDocTmp = 0.0) Then
                Begin
                  fltDinRec := (fltDinRec * fltFator);
                  fltCarRec := (fltCarRec * fltFator);
                  fltChqRec := (fltChqRec * fltFator);
                  fltChqPre := (fltChqPre * fltFator);
                  fltOrdRec := (fltOrdRec * fltFator);
                  fltValCre := (fltValCre * fltFator);
                  fltValFin := (fltValFin * fltFator);
                End;

              End;

              blnPriReg := False;

            End;

          End
          Else If (intOpcao = RCX_GRAVA_DESCONTO) And Not (blnDocCre) Then
          Begin
            strJurDes    := 'D';
            fltValDocTmp := fltValDocTmp * IIF(Pos(strEspDoc, 'PG_LD_') > 0, 1, -1);
            fltDinRec := 0.0;
            fltCarRec := 0.0;
            fltChqRec := 0.0;
            fltChqPre := 0.0;
            fltOrdRec := 0.0;
            fltValCre := 0.0;
            fltValFin := 0.0;
          End
          Else If (intOpcao = RCX_GRAVA_JUROS) And Not (blnDocCre) Then
          Begin
            strJurDes := 'J';
            fltValDocTmp := FieldByName('CTR_VALJUR').AsFloat * fltFator;
            fltDinRec := 0.0;
            fltCarRec := 0.0;
            fltChqRec := 0.0;
            fltChqPre := 0.0;
            fltOrdRec := 0.0;
            fltValCre := 0.0;
            fltValFin := 0.0;

          End
          Else If (intOpcao = RCX_GRAVA_DESPCOBR) And Not (blnDocCre) Then
          Begin
            strJurDes := 'C';
            fltValDocTmp := FieldByName('CTR_DESCOB').AsFloat * fltFator;
            fltDinRec := 0.0;
            fltCarRec := 0.0;
            fltChqRec := 0.0;
            fltChqPre := 0.0;
            fltOrdRec := 0.0;
            fltValCre := 0.0;
            fltValFin := 0.0;
          End;

          intSeqBai := 0;
          If (intOpcao = RCX_GRAVA_NORMAL) And (Assigned(stlSeqBai)) Then
          Begin
            intSeqBai := StrToInt(stlSeqBai.Values[FieldByName('CTR_NUMDUP').AsString +
                                                   FieldByName('CTR_PARCEL').AsString +
                                                   FieldByName('CTR_CODEMP').AsString +
                                                   FieldByName('CTR_ESPDOC').AsString +
                                                   FieldByName('CTR_CODCLI').AsString]);
          End;

          pTrocaSinalMoedas(fltDinRec);

          LRecebidoPorPix := IIF(chkPixAvulso.Checked, 'S', 'N');
          If Assigned(FObjetoPixRecebimento) Then
          Begin
            If TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(FObjetoPixRecebimento) Then
              LRecebidoPorPix := 'S';
          End;

          If ((intOpcao = RCX_GRAVA_NORMAL) And (FieldByName('CTR_ESPDOC').AsString = 'CC') And
              (FieldByName('CTR_VALREC').AsFloat < 0.0)) And
           Not ((fltTotRec = 0.0) And (fltTotCre < 0.0))  Then
          Begin
            fltDinRec := 0;
            fltChqRec := 0;
            fltChqPre := 0;
            fltCarRec := 0;
            fltOrdRec := 0;
            fltValFin := 0;
          End
           Else
            blnGravouValoresEsp := True;

          Result := fGravaCadRcx(strSeqRcx,                              //autoincrem
                                 FieldByName('CTR_CODCLI').AsString,     //Código do Cliente
                                 IIF(strCodOpe <> '',
                                     strCodOpe,
                                     edtCodOpe.Text),                    //Operador
                                 FieldByName('CTR_NUMDUP').AsString,     //Documento
                                 FieldByName('CTR_ESPDOC').AsString,     //Espécie
                                 VS_strCodEmp,                           //Empresa
                                 dtaDtaCai,                              //Data de Cadastro
                                 fTime(),                                //Hora de Cadastro
                                 FieldByName('CTR_NUMDUP').AsString,     //Duplicata
                                 FieldByName('CTR_PARCEL').AsString,     //Parcela
                                 strDescri,                              //Descrição
                                 strJurDes,                              //Juros / Dessconto
                                 '',                                     //Identificação de Fechamento
                                 '',                                     //Forma de Pagamento
                                 fltValDocTmp,                           //Valor do Documento
                                 fltDesRecTmp,                           //Desconto Recebido
                                 fltValJurTmp,                           //Juros Recebido
                                 fltDinRec,                              //Valor em dinheiro
                                 fltChqRec,                              //Valor em Cheque à Vista
                                 fltChqPre,                              //Valor em Cheque Pré
                                 fltCarRec,                              //Valor em Cartão
                                 fltOrdRec,                              //Valor em Ordem de Pagamento
                                 fltValCre,                              //Valor de Crédito de Cliente
                                 fltValFin,                                    //Valor em Financiamento
                                 0.0,                                    //Valor em outras modalidades
                                 0.0,                                    //Valor de venda a prazo
                                 StrNumRom,                              //Num. do Romaneio
                                 intSeqCon,                              //Sequencial de Controle
                                 intSeqBai,                              //Sequencial de Baixa da Duplicata
                                 fCfgSisL('SQFCRX'),                     //Sequencial de Fechamento parcial de caixa
                                 FieldByName('CTR_CODEMP').AsString,
                                 IIF(fEmptyStr(Trim(strMotDes)), Trim(FieldByName('CTR_MOTDES').AsString), Trim(strMotDes)),  //Motivo do desconto
                                 1,                                      // Identificação do Caixa
                                 fltTotGua,
                                 fltTotDol,
                                 fltTotEur,
                                 fltTotPes,
                                 fltTotRea,
                                 'N',
                                 '',
                                 edtCodigoCaixa.Text,
                                 '',
                                 0.00,
                                 False,
                                 0.00,
                                 '',
                                 0,
                                 LRecebidoPorPix);

          If (Not Result) Then
            Break;

          FAuditoriaResumoCaixa.Adicionar(strSeqRcx, 'CADRCXX');
          Next;

          {*******************************************}
          {* ZERA VARIÁVEIS DE MODALIDADE            *}
          {****************************************MV*}
          fltDinRec := 0.0;
          fltCarRec := 0.0;
          fltChqRec := 0.0;
          fltChqPre := 0.0;
          fltOrdRec := 0.0;
          fltValCre := 0.0;
          fltValFin := 0.0;

          fltTotGua := 0;
          fltTotDol := 0;
          fltTotEur := 0;
          fltTotPes := 0;
          fltTotRea := 0;
          fltTotDinSav := 0;

          If (Not blnGravouValoresEsp) Then
          Begin
            fltDinRec := bck_fltDinRec;
            fltCarRec := bck_fltCarRec;
            fltChqRec := bck_fltChqRec;
            fltChqPre := bck_fltChqPre;
            fltOrdRec := bck_fltOrdRec;
            fltValFin := bck_fltValFin;
          End;

        End;

      End
      Else
      Begin

        If (Pos(strEspDoc, strEspLancamentos) <= 0) Then
        Begin

          If (intOpcao = RCX_GRAVA_NORMAL) Then
          Begin
            strDescri    := 'REF. A ' + strEspDoc + ' Nro. ' + strEspDoc;
          End
          Else If (intOpcao = RCX_GRAVA_DESCONTO) Then
          Begin
            strDescri    := 'REF. A DESC. ' + strEspDoc + ' Nro. ' + strEspDoc;
          End
          Else If (intOpcao = RCX_GRAVA_JUROS) Then
          Begin
            strDescri    := 'REF. A JUROS. ' + strEspDoc + ' Nro. ' + strEspDoc;
          End
          Else If (intOpcao = RCX_GRAVA_DESPCOBR) Then
          Begin
            strDescri    := 'REF. A DESP. COB. ' + strEspDoc + ' Nro. ' + strEspDoc;
          End;

          If fEmptyStr(strEspDoc) Then
          Begin
            Result := True;
            Exit;
          End;

        End;

        If (intOpcao = RCX_GRAVA_NORMAL) Then
        Begin
          strJurDes    := '';
          fltValDocTmp := (fltValDoc * fltFator);
          fltDinRec    := (fltDinRec * fltFator);
          fltCarRec    := (fltCarRec * fltFator);
          fltChqRec    := (fltChqRec * fltFator);
          fltChqPre    := (fltChqPre * fltFator);
          fltOrdRec    := (fltOrdRec * fltFator);
          fltValCre    := (fltValCre * fltFator);
          fltValFin    := (fltValFin * fltFator);
        End
        Else If (intOpcao = RCX_GRAVA_DESCONTO) Then
        Begin
          strJurDes    := 'D';
          fltValDocTmp := (fltDesRec * fltFator);
          fltDinRec    := 0.0;
          fltCarRec    := 0.0;
          fltChqRec    := 0.0;
          fltChqPre    := 0.0;
          fltOrdRec    := 0.0;
          fltValCre    := 0.0;
          fltValFin    := 0.0;
        End
        Else If (intOpcao = RCX_GRAVA_JUROS) Then
        Begin
          strJurDes    := 'J';
          fltValDocTmp := (fltValJur * fltFator);
          fltDinRec    := 0.0;
          fltCarRec    := 0.0;
          fltChqRec    := 0.0;
          fltChqPre    := 0.0;
          fltOrdRec    := 0.0;
          fltValCre    := 0.0;
          fltValFin    := 0.0;
        End
        Else If (intOpcao = RCX_GRAVA_DESPCOBR) Then
        Begin
          strJurDes    := 'C';
          fltValDocTmp := (fltValCob * fltFator);
          fltDinRec    := 0.0;
          fltCarRec    := 0.0;
          fltChqRec    := 0.0;
          fltChqPre    := 0.0;
          fltOrdRec    := 0.0;
          fltValCre    := 0.0;
          fltValFin    := 0.0;
        End;

        pTrocaSinalMoedas(fltDinRec);

        LRecebidoPorPix := IIF(chkPixAvulso.Checked, 'S', 'N');
        If Assigned(FObjetoPixRecebimento) Then
        Begin
          If TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(FObjetoPixRecebimento) Then
            LRecebidoPorPix := 'S';
        End;

        Result := fGravaCadRcx(strSeqRcx,                                         //autoincrem
                               IIF(strEspDoc = 'CC', strCliCco, edtCodCli.Text),  //Código do Cliente
                               IIF(strCodOpe <> '',
                                   strCodOpe,
                                   edtCodOpe.Text),                               //Operador
                               edtNumDoc.Text,                                    //Documento
                               strEspDoc,                                         //Espécie
                               VS_strCodEmp,                                      //Empresa
                               dtaDtaCai,                                         //Data de Cadastro
                               fTime(),                                           //Hora de Cadastro
                               IfThen(strEspDoc = 'PG', strNumDupPG, ''),           //Duplicata {**Req. 97805**20/04/2018**WS**}
                               IfThen(strEspDoc = 'PG', 'A', ''),                 //Parcela   {**Req. 97805**20/04/2018**WS**}
                               strDescri,                                         //Descrição
                               strJurDes,                                         //Juros / Dessconto
                               IIF(((strEspDoc = 'LC') And (chkSaldoInicial.Checked)) Or
                                   ((strEspDoc = 'TF') And (blnFecham)),'S',''),  //Identificação de Fechamento
                               '',                                                //Forma de Pagamento
                               fltValDocTmp,                                      //Valor do Documento
                               fltDesRecTmp,                                      //Desconto Recebido
                               fltValJurTmp,                                      //Juros Recebido
                               fltDinRec,                                         //Valor em dinheiro
                               fltChqRec,                                         //Valor em Cheque à Vista
                               fltChqPre,                                         //Valor em Cheque Pré
                               fltCarRec,                                         //Valor em Cartão
                               fltOrdRec,                                         //Valor em Ordem de Pagamento
                               fltValCre,                                         //Valor de Crédito de Cliente
                               fltValFin,                                         //Valor em Financiamento
                               0.0,                                               //Valor em outras modalidades
                               0.0,                                               //Valor de venda a prazo
                               '',                                                //Num. do Romaneio
                               intSeqCon,                                         //Sequencial de Controle
                               0,                                                 //Sequencial de Baixa (Duplicata)
                               fCfgSisL('SQFCRX'),                                 //Sequencial de Fechamento parcial de caixa
                               VS_strCodEmp,                                      //Empresa da duplicata
                               Trim(strMotDes),                                         //Motivo do desconto
                               intIdeCai,                                         //Identificação do Caixa
                               fltTotGua,
                               fltTotDol,
                               fltTotEur,
                               fltTotPes,
                               fltTotRea,
                               'N',
                               '',
                               edtCodigoCaixa.Text,
                               '',
                               fltFundoDeCaixa,
                               False,
                               0.00,
                               '',
                               0,
                               LRecebidoPorPix,
                               0,
                               Trim(strJus_Pg),
                               False,
                               IIF(strEspDoc = 'CC', strAutIncCadRecCredito, ''));

        If Result Then
          FAuditoriaResumoCaixa.Adicionar(strSeqRcx, 'CADRCXX');
      End;

      EnableControls;

    End;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('[fGravaResCai] - ' + E.Message);
      Result := False;
    End;
  End;

  edtFinanc.Text := '0,00';
end;

function TfrmRcxResumoCaixa.fPedePortadorCreditoCliente(var strPortador, strEvento : String  ): String;
  Var
    frmBaixaAnalitica : TfrmBaixaAnalitica;
begin
  Result := '';

  Try
    pCriarFormularios(TfrmBaixaAnalitica,frmBaixaAnalitica);
    Try

      frmBaixaAnalitica.blnChmCX := True;

      frmBaixaAnalitica.Panel1.Visible := False;

      frmBaixaAnalitica.edtPorDeb.Visible  := False;
      frmBaixaAnalitica.edtPorDeb.Enabled  := False;
      frmBaixaAnalitica.lblPorDeb.Visible  := False;
      frmBaixaAnalitica.edtCodPorDeb.Enabled := False;
      frmBaixaAnalitica.edtCodPorDeb.Visible := False;
      frmBaixaAnalitica.blnFrmRcxResumoCaixa := True;

      If fCfgSis('POFXCC', varBoolean) Then
      Begin
        frmBaixaAnalitica.Portador := strPortador;
        frmBaixaAnalitica.BloquearEdicaoPortador := True;
      End
      Else
      Begin
        frmBaixaAnalitica.Portador := '';
        frmBaixaAnalitica.BloquearEdicaoPortador := False;
      End;


      frmBaixaAnalitica.fraPlanoDeContasCre.lblPlaContas.Visible := False;
      frmBaixaAnalitica.fraPlanoDeContasCre.MskCodCta.Visible    := False;
      frmBaixaAnalitica.fraPlanoDeContasCre.edtDesCta.Visible    := False;

      frmBaixaAnalitica.pnlFundo.Height := frmBaixaAnalitica.edtPorBai.Top + frmBaixaAnalitica.edtPorBai.Height + 15;
      frmBaixaAnalitica.Height := frmBaixaAnalitica.pnlFundo.Height + frmBaixaAnalitica.pnlConfirma.Height + frmBaixaAnalitica.pnlStatus.Height + 35;
      frmBaixaAnalitica.pnlFundo.Align := alClient;

      frmBaixaAnalitica.ShowModal;

      If frmBaixaAnalitica.blnConfirma And (Not fEmptyStr(frmBaixaAnalitica.edtPorBai.Text)) Then
      Begin

         strEvento   := frmBaixaAnalitica.strCodEve;

         strPortador := frmBaixaAnalitica.strPorBai;

         Result := frmBaixaAnalitica.strPorBai;

      End
      Else
        strPortador := '';
    Finally
      If Assigned(frmBaixaAnalitica) Then
        pFreeAndNil(frmBaixaAnalitica);
    End;

  Except
    On E: Exception Do
    Begin
      strPortador := '';
      pMensagensErro(E.Message,'[fGravaCreditoCliente - frmBaixaAnalitica]');
    End;
  End;

end;

function TfrmRcxResumoCaixa.fGravaCreditoCliente(intOpcao: Integer;
                                                 strPortad: String;
                                                 intSeqCon: Integer;
                                                 out strAutIncCadRecCredito : String;
                                                 strEvento : String = '';
                                                 ARecebidoPorPix: String = 'N'): Boolean;
  Var
    fltValGra: Double;
    strCliGra: String;
    strNumDup: String;

    fltDinhei: Double;
    fltCartao: Double;
    fltChqVis: Double;
    fltChqPre: Double;
    fltOrdPag: Double;

    LTotalPago: Double;
    LPercentualRepasseDinheiro: Double;
    LPercentualRepasseCartao: Double;
    LPercentualRepasseChequeAvista: Double;
    LPercentualRepasseChequePre: Double;
    LPercentualRepasseOrdemPagamento: Double;
    LDiferenca: Double;
    LTotalDistribuido: Double;

    LIndiceMaiorValor : Integer;
    LIndice : Integer;
    LEspeciesRecebimento: array of TEspeciesGerCC;

    LHist01: String;
    strSeqRec : String;
begin
  strAutIncCadRecCredito := '';

  If fEmptyStr(strPortad) Then
  Begin
    Result := False;
    Exit;
  End;

  fltDinhei := fStrToFloat(edtDinRec.Text);
  fltCartao := fStrToFloat(edtCarRec.Text);
  fltChqVis := fStrToFloat(edtChqRec.Text);
  fltChqPre := fStrToFloat(edtChqPre.Text);
  fltOrdPag := fStrToFloat(edtOrdRec.Text);

  LTotalDistribuido := 0;

  Try

    fltValGra := IIF(intOpcao = 1, fltValCre, fltValDoc);
    strCliGra := strCliCco;

    strNumDup := RetornaSequencialCreditoCliente;
    LHist01 := IIF(intOpcao = RCX_GRAVA_NORMAL, 'REF. LANC. CREDITO', strDescri);
    edtNumDoc.Text := strNumDup;

    If (intOpcao = 1)                      And
       (cdsTmpResumoCaixa.Active) Then
    Begin

      With cdsTmpResumoCaixa Do
      Begin

        DisableControls;
        First;

        While (Not Eof) Do
        Begin

          If (FieldByName('CTR_MARDES').AsString <> 'M') Then
          Begin
            Next;
            Continue;
          End;

          strCliGra := FieldByName('CTR_CODCLI').AsString;
          Break;
        End;

        EnableControls;

      End;

      //*************************************************************
      //* Pega o cliente selecionado quando o pagamento for cheque  *
      //* e estiver usando a  rede de lojas no filtro               *
      //*************************************************************
      If Not fEmptyStr(strCodClienteCredSel) Then
         strCliGra := strCodClienteCredSel;

      LHist01 := Concat(LHist01,' - ','CLIENTE: ', cdsTmpResumoCaixa.FieldByName('CTR_NOMCLI').AsString);
    End;

    If (fEmptyStr(strCliGra)) Then
    Begin
      Raise Exception.Create('Não foi possivel determinar o cliente para gravação do crédito!');
    End;

    pGeraLogLiberacao(strNumDup, 'CC', VS_strCodEmp);

    Result := fGravaCadRec(strSeqRec,
                 Self.Name,
                 'INCLUSÃO',
                 strNumDup,                                                          // Duplicata
                 'A',                                                                // Parcela
                 0,                                                                  // Sequencial de Baixa
                 'CC',                                                               // Espécie
                 strCliGra,                                                          // Cliente
                 VS_strCodEmp,                                                       // Empresa
                 edtCodOpe.Text,                                                     // Vendedor
                 edtCodOpe.Text,                                                     // Digitador
                 strPortad,                                                          // Portador
                 VS_Date,                                                            // Data de Cadastro
                 VS_Date,                                                            // Data de Vencimento
                 -fltValGra,                                                         // Valor da Duplicata
                 -fltValGra,                                                         // Valor Original
                 0.0,                                                                // Despesa de Cobrança
                 'N',                                                                // Desconto
                 LHist01,                                                            // Histórico 1
                 '',                                                                 // Histórico 2
                 '',                                                                 // Portador da Baixa
                 '',                                                                 // Centro de Custo da Baixa
                 '',                                                                 // Operador da Baixa
                 '',                                                                 // Documento da Baixa
                 0.0,                                                                // Valor do Recebimento
                 0,                                                                  // Data do Recebimento
                 'N',
                 strEvento,                                                          // Código do Evento
                 '',                                                                 // Código Velho (CONVERSÃO)
                 '',                                                                 // Tipo de Fora (Condição de Pagamento)
                 '',                                                                 // Código da Condição de Pagamento
                 False,
                 IIF(fEmptyStr(fCfgSis('CTR_CC')),'',fCfgSis('CTR_CC')),             // Codigo do Centro de Custo
                 intSeqCon,                                                          // Sequencial de Controle
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
                 ARecebidoPorPix);

    If (Result) Then
      strAutIncCadRecCredito := strSeqRec;

    If (Not Result) Then
    Begin
      fRollBack;
      Exit;
    End;

    If (intOpcao = 1) Then
    Begin

      LTotalPago := fltDinhei + fltCartao + fltChqVis + fltChqPre + fltOrdPag;

      SetLength(LEspeciesRecebimento, 0);

      if fFormataFloat(fltDinhei, 2) > 0 then
      begin
        LPercentualRepasseDinheiro := fFormataFloat(fltDinhei / LTotalPago, 2);

        fltDinhei := fFormataFloat(fltValGra * LPercentualRepasseDinheiro, 2);
        edtDinRec.Text := FloatToStrF(fStrToFloat(edtDinRec.Text) - fltDinhei, ffFixed, 12, 2);
        LTotalDistribuido := LTotalDistribuido + fltDinhei;

        SetLength(LEspeciesRecebimento, length(LEspeciesRecebimento)+1);
        LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].StrEspecie    := 'CTR_DINHEI';
        LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltValor      := -fltDinhei;
        LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltPercPgto   := LPercentualRepasseDinheiro;
        LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltVlrCredito :=  -fltDinhei;
        LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltCreditoCalc := -fltDinhei;
      end;

      if fFormataFloat(fltCartao, 2) > 0 then
      begin
        LPercentualRepasseCartao := fFormataFloat(fltCartao / LTotalPago, 2);

        fltCartao := fFormataFloat(fltValGra * LPercentualRepasseCartao, 2);
        edtCarRec.Text := FloatToStrF(fStrToFloat(edtCarRec.Text) - fltCartao, ffFixed, 12, 2);
        LTotalDistribuido := LTotalDistribuido + fltCartao;

        SetLength(LEspeciesRecebimento, length(LEspeciesRecebimento)+1);
        LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].StrEspecie    := 'CTR_CARTAO';
        LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltValor      := -fltCartao;
        LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltPercPgto   := LPercentualRepasseCartao;
        LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltVlrCredito :=  -fltCartao;
        LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltCreditoCalc := -fltCartao;
      end;

      if fFormataFloat(fltChqVis, 2) > 0 then
      begin
        LPercentualRepasseChequeAvista := fFormataFloat(fltChqVis / LTotalPago, 2);

        fltChqVis := fFormataFloat(fltValGra * LPercentualRepasseChequeAvista, 2);
        edtChqRec.Text := FloatToStrF(fStrToFloat(edtChqRec.Text) - fltChqVis, ffFixed, 12, 2);
        LTotalDistribuido := LTotalDistribuido + fltChqVis;

        SetLength(LEspeciesRecebimento, length(LEspeciesRecebimento)+1);
        LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].StrEspecie    := 'CTR_CHQAVI';
        LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltValor      := -fltChqVis;
        LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltPercPgto   := LPercentualRepasseChequeAvista;
        LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltVlrCredito :=  -fltChqVis;
        LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltCreditoCalc := -fltChqVis;
      end;

      if fFormataFloat(fltChqPre, 2) > 0 then
      begin
        LPercentualRepasseChequePre := fFormataFloat(fltChqPre / LTotalPago, 2);

        fltChqPre := fFormataFloat(fltValGra * LPercentualRepasseChequePre, 2);
        edtChqPre.Text := FloatToStrF(fStrToFloat(edtChqPre.Text) - fltChqPre, ffFixed, 12, 2);
        LTotalDistribuido := LTotalDistribuido + fltChqPre;

        SetLength(LEspeciesRecebimento, length(LEspeciesRecebimento)+1);
        LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].StrEspecie    := 'CTR_CHQPRE';
        LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltValor      := -fltChqPre;
        LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltPercPgto   := LPercentualRepasseChequePre;
        LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltVlrCredito :=  -fltChqPre;
        LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltCreditoCalc := -fltChqPre;
      end;

      if fFormataFloat(fltOrdPag, 2) > 0 then
      begin
        LPercentualRepasseOrdemPagamento := fFormataFloat(fltOrdPag / LTotalPago, 2);

        fltOrdPag := fFormataFloat(fltValGra * LPercentualRepasseOrdemPagamento, 2);
        edtOrdRec.Text := FloatToStrF(fStrToFloat(edtOrdRec.Text) - fltOrdPag, ffFixed, 12, 2);
        LTotalDistribuido := LTotalDistribuido + fltOrdPag;

        SetLength(LEspeciesRecebimento, length(LEspeciesRecebimento)+1);
        LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].StrEspecie    := 'CTR_ORDPAG';
        LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltValor      := -fltOrdPag;
        LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltPercPgto   := LPercentualRepasseOrdemPagamento;
        LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltVlrCredito :=  -fltOrdPag;
        LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltCreditoCalc := -fltOrdPag;
      end;

      LDiferenca := fFormataFloat(fltValGra - LTotalDistribuido, 2);
      if fFormataFloat(LDiferenca, 2) <> 0 then
      begin
        LIndiceMaiorValor := 0;
        for LIndice := 0 to Length(LEspeciesRecebimento) - 1 do
        begin
          if LEspeciesRecebimento[LIndice].fltValor > LEspeciesRecebimento[LIndiceMaiorValor].fltValor then
            LIndiceMaiorValor := LIndice;
        end;

        LEspeciesRecebimento[LIndiceMaiorValor].fltValor := LEspeciesRecebimento[LIndiceMaiorValor].fltValor + fFormataFloat(LDiferenca, 2);

        case AnsiIndexStr(LEspeciesRecebimento[LIndiceMaiorValor].StrEspecie, ['CTR_DINHEI', 'CTR_CARTAO', 'CTR_CHQAVI', 'CTR_CHQPRE', 'CTR_ORDPAG'] ) of
          0 :Begin
               edtDinRec.Text := FloatToStrF(fStrToFloat(edtDinRec.Text) - LDiferenca, ffFixed, 12, 2);
               fltDinhei :=  fFormataFloat(fltDinhei - (LDiferenca * -1),2);
             End;
          1 :Begin
               edtCarRec.Text := FloatToStrF(fStrToFloat(edtCarRec.Text) - LDiferenca, ffFixed, 12, 2);
               fltCartao := fFormataFloat(fltCartao -  (LDiferenca * -1), 2);
             End;
          2 :Begin
               edtChqRec.Text := FloatToStrF(fStrToFloat(edtChqRec.Text) - LDiferenca, ffFixed, 12, 2);
               fltChqVis :=  fFormataFloat(fltChqVis -  (LDiferenca * -1), 2);
             End;
          3 :Begin
               edtChqPre.Text := FloatToStrF(fStrToFloat(edtChqPre.Text) - LDiferenca, ffFixed, 12, 2);
               fltChqPre  := fFormataFloat(fltChqPre -  (LDiferenca * -1), 2);
             End;
          4 :Begin
               edtOrdRec.Text := FloatToStrF(fStrToFloat(edtOrdRec.Text) - LDiferenca, ffFixed, 12, 2);
               fltOrdPag := fFormataFloat(fltOrdPag - (LDiferenca * -1), 2);
             End;
        end;
      end;

      pTrocaSinalMoedas(fltDinhei);

      Result := fGravaCadRcx(strSeqRcx,
                             strCliGra,                  // Cliente
                             edtCodOpe.Text,             // Operador
                             strNumDup,                  // Documento
                             'CC',                       // Espécie
                             VS_strCodEmp,               // Empresa
                             dtaDtaCai,                  // Data de Cadastro
                             fTime(),                    // Hora de Cadastro
                             strNumDup,                  // Duplicata
                             'A',                        // Parcela
                             'REF. A CRED. DE CLIENTE',  // Descrição
                             '',                         // Juros / Desconto
                             '',                         // Identificação de Fechamento
                             '',                         // Forma de Pagamento
                             fltValCre,                  // Valor do Documento
                             0.0,                        // Valor do Desconto
                             0.0,                        // Valor do Juros
                             fltDinhei,                  // Dinheiro recebido
                             fltChqVis,                  // Cheque a vista
                             fltChqPre,                  // Cheque pre datado
                             fltCartao,                  // Valor em Cartã
                             fltOrdPag,                  // Valor em Ordem de Pagamento
                             fltValCre,                  // Valor do Crédito
                             0.0,                        // Valor em Financiamento
                             0.0,                        // Valor de outros
                             0.0,                        // Venda a prazo
                             '',                         //Num. do Romaneio
                             intSeqCon,                  //Sequencial de Controle
                             0,                          //Sequencial de Baixa (Duplicata)
                             fCfgSisL('SQFCRX'),          //Sequencial de Fechamento parcial de caixa
                             VS_strCodEmp,               //Empresa da Duplicata
                             Trim(strMotDes),                  //Motivo do desconto
                             2,                          // Identificação do Caixa
                             fltTotGua,
                             fltTotDol,
                             fltTotEur,
                             fltTotPes,
                             fltTotRea,
                             'N',
                             '',
                             edtCodigoCaixa.Text,
                             '',
                             0.00,
                             False,
                             0.00,
                             '',
                             0,
                             ARecebidoPorPix,
                             0,
                             '',
                             False,
                             strSeqRec);

      If (Not Result) Then
      Begin
        fRollBack;
        Exit;
      End;

    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fGravaCreditoCliente]');
      Result := False;
    End;
  End;
end;

procedure TfrmRcxResumoCaixa.pRetornaUsuarioCaixa;
begin
  objResumoDeCaixa.fRetornaUltimoFechamento(fltUltFec,
                                            dtaDtaFec,
                                            edtCodigoCaixa.Text);


  mskDiaAbe.Text := IIF(dtaDtaFec = 0, '', DateToStr(dtaDtaFec));
  edtSalIni.Text := FloatToStrF(fltUltFec, ffFixed, 12, 2);
end;

procedure TfrmRcxResumoCaixa.FormShow(Sender: TObject);
  procedure pAddItemLsvLancamentos(strSigla, strDescricao: String);
  begin
    With lsvLancamentos.Items.Add Do
    Begin
      Caption := strSigla;
      SubItems.Add(strDescricao)
    End;
  end;
var
  intRetQtdPedidos: Integer;
begin
  inherited;

  If lsvLancamentos.Items.Count = 0 Then
  Begin
    lsvLancamentos.Items.BeginUpdate;
    Try
      pAddItemLsvLancamentos('CC', 'Crédito Cliente');
      pAddItemLsvLancamentos('LC', 'Lanc. Crédito');
      pAddItemLsvLancamentos('LD', 'Lanc. Débito');
      pAddItemLsvLancamentos('PG', 'Pagamento');
      pAddItemLsvLancamentos('TF', 'Transferência');
    Finally
      lsvLancamentos.Items.EndUpdate;
    End;
  End;

  If blnExecutouOnShow Then
    Exit;

  SetLength(arrLogLib, 0);
  SetLength(arrLogAvi, 0);

  If Not blnF11 Then
    pMensagemCuponsMuitoVelhosSemImprimir;

  FPais := fSetaPais;

  If (FPais = opcParaguai) Then
  Begin
    lblValRec.Caption := 'Valor G$:';
    lblNomMoe.Visible := True;
  End;

  lblCaixa.Visible          := strTipoFechamentoCaixa = 'C';
  edtCodigoCaixa.Visible    := strTipoFechamentoCaixa = 'C';
  edtDescricaoCaixa.Visible := strTipoFechamentoCaixa = 'C';

  btnEntFutCD.Visible := (fCfgSis('PEF_CD') = 'S') And
                         (fCfgSis('ENT_CD') = 'S') And
                         (fCfgSis('EMP_CD') = VS_strCodEmp);

  btnBusContrato.Visible := fCfgSis('SISCRE', varBoolean);

  btnTitRec.Visible := fVerificaAcessoSistema(frmPrincipal.mnuRelCtrAnalCredito.Hint, edtCodOpe.Text);

  pgcDadosGerais.ActivePage := tbsRecebimentos;

  objResumoDeCaixa.pCriarRegistroInicial(edtCodOpe.Text,
                                         edtCodigoCaixa.Text);

  pRetornaUsuarioCaixa;
  objResumoDeCaixa.fNecessitaFecharCaixa(False,
                                         dtaDtaCai,
                                         edtCodigoCaixa.Text);

  edtSqFcRx.Visible := strTipoFechamentoCaixa <> 'C';
  Label21.Visible   := strTipoFechamentoCaixa <> 'C';

  If edtSqFcRx.Visible Then
    edtSqFcRx.Text := fStrZero(VarToStr(fCfgSisL('SQFCRX')), 3);

  pVerificaDireitosBotoes;


  If (Not fCfgSis('USACUP', varBoolean)) Or (fCfgSis('PAFECF', varBoolean)) Then
  Begin
    If (Not fCfgSis('USNFCE', varBoolean)) And (Not fUsaSat) Then
    Begin
      btnRelatorio.Left     := btnBaixaCtaPagar.Left;
      btnBaixaCtaPagar.Left := btnConfirmaCupons.Left;
      btnConfirmaCupons.Visible := False;
    End;
  End;

  If (fCfgSis('USNFCE', varBoolean)) Then
  Begin
    btnConfirmaCupons.Caption := 'F8 - NFCe';
    btnCapturarGT.Visible := False;
  End;

  If fUsaSat Then
  Begin
    btnConfirmaCupons.Caption := 'F8 - SAT-CFe';
    btnCapturarGT.Visible := False;
  End;

  btnFormaPagamento.Visible := fCfgSis('USAFPG', varBoolean);

  If (VS_strTipExp <> '2') Then
    btnLiberacao.Visible := False
  Else
    btnLiberacao.Visible := fCfgSis('CXAEXP') = '1';

  chkDuplicatasVista.Visible := fCfgSis('DUPVIS', varBoolean);

  pCarregaRede;
  pSetFocus(edtCodCli);

  If blnRcxRom Then
    pSetFocus(edtRomaneio);

  btnImprDAV.Visible := (VS_strUsaPaf = 'S');

  objTefRecebimento := fCriarTefRecebimento(VS_objTef);

  btnBaixaEntFutura.Visible := fVerificaAcessoSistema('BXENTF', edtCodOpe.Text );

  btnAcompanhaServ.Visible := fCfgSis('AUTCEN', varBoolean);
  btnAcompanhaServ.Enabled := fVerificaAcessoSistema('ACEACOSERRCX');
  btnCancelaCC.Visible     := fVerificaAcessoSistema('DIRCANCELACC', edtCodOpe.Text);

  btnLeituraX.Visible := fCfgSis('USACUP', varBoolean);

  If btnLeituraX.Visible Then
    btnLeituraX.Visible := (Not fCfgSis('USNFCE', varBoolean)) And (Not fCfgSis('PAFECF', varBoolean)) And (Not fUsaSat);

  If btnLeituraX.Visible Then
    btnLeituraX.Visible := fVerificaAcessoSistema('frmGerImpFiscais', edtCodOpe.Text);

  tmrCancelamentosTimer(tmrCancelamentos);

  blnExecutouOnShow := True;

  If blnF11 Then
  Begin
    btnConfOrcamentos.Enabled := False;

    If fValidaCampos(edtCodCli) Then
      If fValidaCampos(mskDtaIni) Then
        If Not fValidaCampos(mskDtaFin) Then
          blnFecharForm := True;
  End;

  intRetQtdPedidos := fRetQtdPedidosEntFutCD(VS_strCodEmp);
  if intRetQtdPedidos > 0 then
  begin
    btnEntFutCD.Font.Color := clBlue;
    btnEntFutCD.Caption := '[Ctrl+E] Ent.Fut.pelo CD ('+ IntToStr(intRetQtdPedidos) +')';
  end
  else
    btnEntFutCD.Font.Color := clBlack;

  FAutoIncremChavePix := TPixDao.RetornaAutoIncremChavePixDoCaixa(edtCodigoCaixa.Text);

  btnReceberPix.Visible := TFuncoesPixAutcom.RealizaValidacoesUsoDoPixNoCaixa(edtCodOpe.Text,
                                                                              FAutoIncremChavePix,
                                                                              True);

  chkPixAvulso.Visible := fCfgSis('RCXORD', varString) = 'A';

  If Not btnReceberPix.Visible Then
    chkPixAvulso.Left := btnReceberPix.Left;
end;

function TfrmRcxResumoCaixa.fFecharCaixa: Boolean;
  Var
    strSQL      : String;
    dtaDtaFec   : TDateTime;
    fltSalFec   : Double;
    fltDinheiFec: Double;
    fltCartaoFec: Double;
    fltChqPreFec: Double;
    fltChqAviFec: Double;
    fltOrdPagFec: Double;
    fltValFinFec: Double;
    blnTemValor1: Boolean;
    blnTemValor2: Boolean;
    blnConfirma : Boolean;
    qryGenRcx   : TUniQuery;
    qryGenRc2   : TUniQuery;

    fltEuro,
    fltReal,
    fltDolar,
    fltGuaranie,
    fltPeso: Double;

    strNome: String;
    frmRcxFecCaixa : TfrmRcxFecCaixa;

    LMensagem,
    strLacreDoFechamento,
    strOperadorPermissao: String;

    fltFundoDeCaixa,
    fltTolerancia,
    fltDiferenca   : Double;

    blnDivergencia,
    blnLancouDiferencas,
    LUsaControleDivergencias: Boolean;

    dtaDataPermissao: TDateTime;

    LUltimoFechamento: TDataset;

    procedure pFinalizar;
    Begin
      objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDoFechamento(edtCodigoCaixa.Text), False);
      FreeAndNil(qryGenRcx);
      FreeAndNil(qryGenRc2);
      Result := False;
    End;

begin
  Result := false;

  blnTemValor1 := False;
  blnTemValor2 := False;

  fltDinheiFec := 0;
  fltCartaoFec := 0;
  fltChqPreFec := 0;
  fltChqAviFec := 0;
  fltOrdPagFec := 0;
  fltValFinFec := 0;
  fltGuaranie  := 0;
  fltDolar     := 0;
  fltEuro      := 0;
  fltPeso      := 0;
  fltReal      := 0;

  fltDiferenca    := 0;
  fltTolerancia   := 0;

  blnDivergencia := False;

  strOperadorPermissao := '';
  dtaDataPermissao     := 0;

  LUsaControleDivergencias := (strTipoFechamentoCaixa = 'C') And
                              (fCfgSis('RCXDIV', varBoolean));

  objResumoDeCaixa.fRetornaUltimoFechamento(fltSalFec, dtaDtaFec, edtCodigoCaixa.Text);

  If Not objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDaTransferencia(edtCodigoCaixa.Text), True, False) Then
  Begin
    pMensagemOk('Não será possível efetuar o fechamento agora pois outra estação está realizando transferência!');
    Result := False;
    Exit;
  End
  Else
    objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDaTransferencia(edtCodigoCaixa.Text), False);

  If Not objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDoContasAPagar(edtCodigoCaixa.Text), True, False) Then
  Begin
    pMensagemOk('Não será possível efetuar o fechamento agora pois outra estação está realizando baixa de contas a pagar!');
    Result := False;
    Exit;
  End
  Else
    objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDoContasAPagar(edtCodigoCaixa.Text), False);

  If Not objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDoFechamento(edtCodigoCaixa.Text), True, False, False, '', False) Then
  Begin
    pMensagemOk('Não será possível efetuar o fechamento, pois outra estação está fazendo o fechamento!');
    Result := False;
    Exit;
  End;

  Try
    Try
      If (strTipoFechamentoCaixa <> 'C') And (dtaDtaFec = dtaDtaCai) Then
      Begin
        fMensagem('', 'O fechamento referente ao dia: ' + mskDiaAbe.Text + ' já foi efetuado!', ['&Ok']);
        Result := False;
        Exit;
      End
      Else If Not objResumoDeCaixa.fCupomFiscalImpresso(edtCodigoCaixa.Text, dtaDtaCai) Then
      Begin
        fMensagem('ATENÇÃO', 'Existem Cupons não impressos para esse dia. Caixa não poderá ser fechado!', ['&Ok']);
        Result := False;
        Exit;
      End
      Else
      Begin
        {*****************************************}
        {* VERIFICA PENDENCIAS DE NFE.           *}
        {**************************************PZ*}
        If (fCfgSis('NFEUSA', varBoolean)) Then
        Begin
          If Not TLibNfe.fVerificaCancelamentosPendentesPainel Then
          Begin
            If fCfgSis('POSNAB') = 'T' Then
            Begin
              fMensagem('ATENÇÃO!','Existe(m) envio(s) pendente(s) no Painel NFE.' + #13#10 +
                                   'O fechamento do caixa não pode ser realizado!',['&O k']);
              Exit;
            End
            Else
            Begin
              If fMensagem('ATENÇÃO!','Existe(m) envio(s) pendente(s) no Painel NFE.' + #13#10 +
                                      'Deseja continuar mesmo assim?', ['&Sim', '&Não'], 2) = 2 Then
              Begin
                Exit;
              End;
            End;
          End;
        End;

        If (fCfgSis('USNFCE', varBoolean)) Or fUsaSat Then
        Begin
          strNome := 'NFCe';
          If fUsaSat Then
          Begin
            strNome := 'SAT-CFe';
          End;

          If fTemNFCePendente Then
          Begin
            If fCfgSis('POSNAB') = 'T' Then
            Begin
              fMensagem('ATENÇÃO!','Existe(m) envio(s) pendente(s) de ' + strNome + '.' + #13#10 +
                                   'O fechamento do caixa não pode ser realizado! Utilize o F8 - ' + strNome + ' para resolver.',['&O k']);
              Exit;
            End
            Else
            Begin
              If fMensagem('ATENÇÃO!','Existe(m) envio(s) pendente(s) de ' + strNome + '.' + #13#10 +
                                      'Deseja continuar mesmo assim?', ['&Sim', '&Não'], 2) = 2 Then
              Begin
                Exit;
              End;
            End;
          End;
        End;

        qryGenRcx := fCriaQuery(Nil);
        qryGenRc2 := fCriaQuery(Nil);

        If Not objResumoDeCaixa.fCaixaTemMovimento(edtCodigoCaixa.Text, dtaDtaFec + 1, qryGenRc2) Then
        Begin
          LMensagem := 'Não existe nenhum movimento referente ao dia: ' + DateToStr(dtaDtaCai) +
                       ' para ser fechado!';

          If (strTipoFechamentoCaixa = 'C') And (dtaDtaFec = dtaDtaCai) Then
          Begin
            LUltimoFechamento := objResumoDeCaixa.fRetornaDadosUltimoFechamento(edtCodigoCaixa.Text, VS_strCodEmp);

            LMensagem := LMensagem + #13 + #13 +
                         'Último fechamento em ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', LUltimoFechamento.FieldByName('RCX_DTAGRV').AsDateTime) +
                         ' por ' + LUltimoFechamento.FieldByName('RCX_CODOPE').AsString + '-' +
                         fRetNomeOperador(LUltimoFechamento.FieldByName('RCX_CODOPE').AsString) + '.';

            FreeAndNil(LUltimoFechamento);
          End;

          fMensagem('ATENÇÃO', LMensagem, ['&Ok']);

          FreeAndNil(qryGenRcx);
          FreeAndNil(qryGenRc2);
          Result := False;
          Exit;
        End;

      End;

      //Mesmo dando zero no retorno da função, estava entrando no If comparando como double
      If Not MatchStr(FormatFloat(',0.00', objResumoDeCaixa.RetornaValorDePixSemTransferir(dtaDtaCai, edtCodigoCaixa.Text)), ['0.00', '0,00']) Then
      Begin
        fMensagem('ATENÇÃO', 'Não é possível efetuar o fechamento de caixa com recebimentos em Pix avulsos a serem transferidos!', ['&Ok']);
        pFinalizar;
        Exit(False);
      End;

      If Not objResumoDeCaixa.VerificaSeArquivoPAFFoiCriado(dtaDtaCai) Then
      Begin
        pFinalizar;
        Exit(False);
      End;

      {*******************************************}
      {* PEGA VALOR DAS MODALIDADES ANTERIORES   *}
      {****************************************MV*}
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  RCX_CODOPE, ';
      strSQL := strSQL + '  RCX_DINREC, ';
      strSQL := strSQL + '  RCX_CARREC, ';
      strSQL := strSQL + '  RCX_CHQAVI, ';
      strSQL := strSQL + '  RCX_CHQPRE, ';
      strSQL := strSQL + '  RCX_ORDREC, ';
      strSQL := strSQL + '  RCX_VALCRE, ';
      strSQL := strSQL + '  RCX_VALFIN, ';
      strSQL := strSQL + '  RCX_TOTEUR, ';
      strSQL := strSQL + '  RCX_TOTGUA, ';
      strSQL := strSQL + '  RCX_TOTREA, ';
      strSQL := strSQL + '  RCX_TOTDOL, ';
      strSQL := strSQL + '  RCX_TOTPES  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADRCXX ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  RCX_IDEFEC = "X" AND ';
      strSQL := strSQL + '  RCX_CODEMP = :CODEMP ';
      If strTipoFechamentoCaixa = 'C' Then
        strSQL := strSQL + ' AND RCX_CODCAX = "' + edtCodigoCaixa.Text + '" ';
      strSQL := strSQL + 'ORDER BY ';
      strSQL := strSQL + '  RCX_IDEFEC DESC, RCX_DTACAD DESC, RCX_DTAGRV DESC ';
      strSQL := strSQL + 'LIMIT 1 ';

      With qryGenRcx Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        Open;

        fltDinheiFec := fFormataFloat(FieldByName('RCX_DINREC').AsFloat, 2);
        fltCartaoFec := fFormataFloat(FieldByName('RCX_CARREC').AsFloat, 2);
        fltChqPreFec := fFormataFloat(FieldByName('RCX_CHQPRE').AsFloat, 2);
        fltChqAviFec := fFormataFloat(FieldByName('RCX_CHQAVI').AsFloat, 2);
        fltOrdPagFec := fFormataFloat(FieldByName('RCX_ORDREC').AsFloat, 2);
        fltValFinFec := fFormataFloat(FieldByName('RCX_VALFIN').AsFloat, 2);

        If (objResumoDeCaixa.TransferenciaCega) Then
        Begin

          If fltCartaoFec <> 0 Then
            blnTemValor1 := True;

          If fltChqPreFec <> 0 Then
            blnTemValor1 := True;

          If fltChqAviFec <> 0 Then
            blnTemValor1 := True;

          If fltOrdPagFec <> 0 Then
            blnTemValor1 := True;

          If fltValFinFec <> 0 Then
            blnTemValor1 := True;
        End;

        fltReal      := FieldByName('RCX_TOTREA').AsFloat;
        fltPeso      := FieldByName('RCX_TOTPES').AsFloat;
        fltDolar     := FieldByName('RCX_TOTDOL').AsFloat;
        fltGuaranie  := FieldByName('RCX_TOTGUA').AsFloat;
        fltEuro      := FieldByName('RCX_TOTEUR').AsFloat;

      End;

      {*******************************************}
      {* CALCULA SALDO PARA FECHAMENTO DO CAIXA  *}
      {****************************************MV*}
      While (Not qryGenRc2.Eof) Do
      Begin
        fltSalFec    := fFormataFloat(fltSalFec, 2)    + fFormataFloat(qryGenRc2.FieldByName('RCX_VALDOC').AsFloat, 2);
        fltDinheiFec := fFormataFloat(fltDinheiFec, 2) + fFormataFloat(qryGenRc2.FieldByName('RCX_DINREC').AsFloat, 2);
        fltCartaoFec := fFormataFloat(fltCartaoFec, 2) + fFormataFloat(qryGenRc2.FieldByName('RCX_CARREC').AsFloat, 2);
        fltChqPreFec := fFormataFloat(fltChqPreFec, 2) + fFormataFloat(qryGenRc2.FieldByName('RCX_CHQPRE').AsFloat, 2);
        fltChqAviFec := fFormataFloat(fltChqAviFec, 2) + fFormataFloat(qryGenRc2.FieldByName('RCX_CHQAVI').AsFloat, 2);
        fltOrdPagFec := fFormataFloat(fltOrdPagFec, 2) + fFormataFloat(qryGenRc2.FieldByName('RCX_ORDREC').AsFloat, 2);
        fltValFinFec := fFormataFloat(fltValFinFec, 2) + fFormataFloat(qryGenRc2.FieldByName('RCX_VALFIN').AsFloat, 2);

        fltGuaranie  := fltGuaranie + qryGenRc2.FieldByName('RCX_TOTGUA').AsFloat;
        fltDolar     := fltDolar    + qryGenRc2.FieldByName('RCX_TOTDOL').AsFloat;
        fltEuro      := fltEuro     + qryGenRc2.FieldByName('RCX_TOTEUR').AsFloat;
        fltPeso      := fltPeso     + qryGenRc2.FieldByName('RCX_TOTPES').AsFloat;
        fltReal      := fltReal     + qryGenRc2.FieldByName('RCX_TOTREA').AsFloat;

        qryGenRc2.Next;
      End;

      qryGenRc2.Close;

      If fltCartaoFec > 0 Then
        blnTemValor2 := True;

      If fltChqPreFec > 0 Then
        blnTemValor2 := True;

      If fltChqAviFec > 0 Then
        blnTemValor2 := True;

      If fltOrdPagFec > 0 Then
        blnTemValor2 := True;

      If fltValFinFec > 0 Then
        blnTemValor2 := True;

      If (strTipoFechamentoCaixa = 'C') Then
      Begin
        fltTolerancia   := fFormataFloat(fCfgSis('RCXTOL', varDouble), 2);

        If objResumoDeCaixa.FechamentoDeveSerZerado Then
        Begin
          fltDiferenca    := fFormataFloat(fltSalFec, 2);

          blnDivergencia  := (Not objResumoDeCaixa.fBetween(fltSalFec, fltTolerancia * (-1), fltTolerancia));
        End;
      End
      Else
      Begin
        If (fFormataFloat(fltSalFec, 2) <> 0) And objResumoDeCaixa.FechamentoDeveSerZerado Then
        Begin
          fMensagem('ATENÇÃO', 'O Sistema está configurado para permitir fechamento do caixa somente com saldo final zero.' + Chr(13) +
                               'Transfira as modalidades de pagamento na sua totalidade, para liberar o fechamento do caixa.', ['&OK']);
          pFinalizar;
          Exit;
        End;
      End;

      If (fltCartaoFec < 0) then
      begin
          fMensagem('ATENÇÃO', 'Não é possível realizar o fechamento do caixa com saldo de cartão negativo.' + Chr(13) +
                               'Verifique as movimentações do Caixa, para liberar o fechamento do caixa.', ['&OK']);
          pFinalizar;
          Exit;
      end;

      If (objResumoDeCaixa.TransferenciaCega) Then
      Begin

        If (blnTemValor1 or blnTemValor2) then
        Begin
          fMensagem('ATENÇÃO', 'O Sistema está configurado para transferência cega, portanto a(s) modalidade(s) a seguir deve(m)' + Chr(13) +
                               'estar com saldo final zero. Transfira as modalidades de pagamento na sua totalidade, para liberar' + Chr(13) +
                               'o fechamento do caixa.', ['&OK']);
        End;

        If blnTemValor1 then
        Begin

          If Assigned(prcExecutaRelatorio) Then
          begin
            prcExecutaRelatorio(165, 7295, [],
                                ['TIPFEC','CODEMP','CODCAX'],
                                [strTipoFechamentoCaixa,
                                VS_strCodEmp,
                                edtCodigoCaixa.Text],
                                nil,
                                nil,
                                True);
          End;

          pFinalizar;
          Exit;

        End;

        If blnTemValor2 then
        Begin

          If (strTipoFechamentoCaixa <> 'C') then
          Begin

            If Assigned(prcExecutaRelatorio) Then
            begin
              prcExecutaRelatorio(166, 7296, [],
                                ['TIPFEC','CODEMP','CODCAX','DTACAI'],
                                [strTipoFechamentoCaixa,
                                VS_strCodEmp,
                                edtCodigoCaixa.Text,
                                DateToStr(dtaDtaFec + 1)],
                                nil,
                                nil,
                                True);
            End;

            pFinalizar;
            Exit;

          End
          Else
          Begin

            If Assigned(prcExecutaRelatorio) Then
            begin
              prcExecutaRelatorio(167, 7297, [],
                                ['TIPFEC','CODEMP','CODCAX','DTACAI'],
                                [strTipoFechamentoCaixa,
                                VS_strCodEmp,
                                edtCodigoCaixa.Text,
                                DateToStr(dtaDtaFec)],
                                nil,
                                nil,
                                True);
            End;

            pFinalizar;
            Exit;

          End;

        End;

      End;

      {******************************}
      {* VALIDA TOLERANCIA DE CAIXA *}
      {***************************AJ*}
      If (strTipoFechamentoCaixa = 'C') And
         (Not blnDivergencia) Then
      Begin
        fltFundoDeCaixa := objResumoDeCaixa.fRetornaFundoDeCaixaInformadoNaTransferencia(edtCodigoCaixa.Text,
                                                                                         dtaDtaCai);

        fltDiferenca := fFormataFloat(fltDinheiFec - fltFundoDeCaixa, 2);

        blnDivergencia  := (Not objResumoDeCaixa.fBetween(fltDinheiFec - fltFundoDeCaixa, fltTolerancia * (-1), fltTolerancia));
      End;

      If (blnDivergencia) Then
      Begin
        If (objResumoDeCaixa.TransferenciaCega) Then
        Begin
          If fMensagem('ATENÇÃO', 'O fechamento de caixa possui divergência de valores.' + #13 +
                                  'No fechamento deverá ser informado o Fundo de Caixa atual.' + #13 +
                                  'Deseja continuar?', ['&Sim', '&Não']) = 2 Then
          Begin
            pFinalizar;
            Exit;
          End;
        End
        Else If (objResumoDeCaixa.FechamentoDeveSerZerado) Then
        Begin
          fMensagem('ATENÇÃO', 'O Sistema está configurado para permitir fechamento do caixa somente com saldo final zero.' + #13 +
                               'Transfira as modalidades de pagamento na sua totalidade, para liberar o fechamento do caixa.', ['&OK']);

          pFinalizar;
          Exit;
        End
        Else
        Begin
          blnDivergencia := False;
          fltDiferenca := 0.00;
        End;
      End;

      Try
        pCriarFormularios(TfrmRcxFecCaixa, frmRcxFecCaixa);

        frmRcxFecCaixa.fltSalFec        := fFormataFloat(fltSalFec, 2);
        frmRcxFecCaixa.dteDtaFechamento := dtaDtaCai;
        frmRcxFecCaixa.strCodigoCaixa   := edtCodigoCaixa.Text;
        frmRcxFecCaixa.Divergencia      := blnDivergencia;
        frmRcxFecCaixa.objResumoDeCaixa := objResumoDeCaixa;

        frmRcxFecCaixa.ShowModal;
        blnConfirma := frmRcxFecCaixa.blnConfirma;
      Except
        On E: Exception Do
        Begin
          blnConfirma := False;
          pMensagensErro('Erro na criação do form. Tente novamente.' + #13#10 + E.Message,
            '[fFecharCaixa]');
        End;
      End;
    Except
      On E: Exception Do
      Begin
        blnConfirma := False;
        pMensagensErro('Erro no fechamento do Caixa. Tente novamente.' + #13#10 + E.Message,
          '[fFecharCaixa]');
      End;
    End;

    if blnConfirma Then
    Begin
      If (blnDivergencia) Then
      Begin
        fltFundoDeCaixa := fStrToFloat(frmRcxFecCaixa.edtFundoDeCaixa.Text);

        fltDiferenca := fFormataFloat(fltDinheiFec - fltFundoDeCaixa, 2);

        If (LUsaControleDivergencias) Then
        Begin
          blnDivergencia  := (Not objResumoDeCaixa.fBetween(fltDinheiFec - fltFundoDeCaixa, fltTolerancia * (-1), fltTolerancia));

          If blnDivergencia Then
          Begin
            objLiberacao.Clear;
            objLiberacao.objMsgLibera.pAddTexto('Permitir realizar o fechamento de caixa com divergência de valores.');
            objLiberacao.objMsgLibera.pAddTexto('Código do caixa: ' + edtCodigoCaixa.Text);

            objLiberacao.objMsgRemota.pAddTexto('Saldo do fechamento : ' + FormatFloat(',0.00', fltSalFec));
            objLiberacao.objMsgRemota.pAddTexto('Saldo em dinheiro   : ' + FormatFloat(',0.00', fltDinheiFec));
            objLiberacao.objMsgRemota.pAddTexto('Fundo de caixa      : ' + FormatFloat(',0.00', fltFundoDeCaixa));
            objLiberacao.objMsgRemota.pAddTexto('Valor divergente    : ' + FormatFloat(',0.00', fltDiferenca));
            objLiberacao.objMsgRemota.pAddTexto('Lançamento de acerto: ' + FormatFloat(',0.00', fltDiferenca * (-1)));

            objLiberacao.strDirAce := 'LIBLANRCXDIV';
            objLiberacao.strMsgSen := 'Permitir realizar o fechamento de caixa com divergência de valores.';
            objLiberacao.strCodOpe := strLoginUsuarioLogado;
            objLiberacao.strCodDig := strLoginUsuarioLogado;

            blnConfirma := (fMensagem('CONFIRMAÇÃO', 'O saldo do caixa ainda está com divergência de valores. Deseja realmente continuar com o fechamento?', ['&Sim', '&Não'], 2) = 1) And
                           (objLiberacao.fLibera);

            strOperadorPermissao := objLiberacao.strOperador;
            dtaDataPermissao     := fNow;
          End;
        End;
      End;
    End;

    strLacreDoFechamento := frmRcxFecCaixa.edtNumeroLacre.Text;
    pFreeAndNil(frmRcxFecCaixa);

    If (Not blnConfirma) Then
    Begin
      pFinalizar;
      Exit;
    End;

    If (fMensagem('CONFIRMAÇÃO', 'Confirma fechamento?', ['&Sim', '&Não']) = 2) Then
    Begin
      pFinalizar;
      Exit;
    End;

    If Not FormatFloat(',0.00', objResumoDeCaixa.fRetornaSaldoCaixa(edtCodigoCaixa.Text, dtaDtaCai))
                                                  .Equals(FormatFloat(',0.00',fltSalFec)) Then
    Begin
      If fCfgSis('RCXTCC', varString) = '2' Then
      Begin
        fMensagem('ATENÇÃO', 'Houveram alterações no saldo do caixa desde o momento do início do fechamento.' + #13 +
                             'Clique em OK e tente realizar o fechamento novamente.', ['&Ok']);
        pFinalizar;
        Exit;
      End;
    End;

    if VerificarSeExisteSaldoVinculadoATransferirAntesDoFechamento Then
    Begin
      pFinalizar;
      Exit;
    End;

    If (fltCartaoFec < 0) then
    begin
        fMensagem('ATENÇÃO', 'Não é possível realizar o fechamento do caixa com saldo de cartão negativo.' + Chr(13) +
                             'Verifique as movimentações do Caixa, para liberar o fechamento do caixa.', ['&OK']);
        pFinalizar;
        Exit;
    end;

    If (objResumoDeCaixa.TransferenciaCega) Then
    Begin
      If strTipoFechamentoCaixa.Equals('C') Then
      Begin
        blnLancouDiferencas := True;
        If fFormataFloat(fltDiferenca, 2) <> 0.00 Then
          blnLancouDiferencas := objResumoDeCaixa.fLancaDiferencaNoCaixa(edtCodigoCaixa.Text,
                                                                         edtCodOpe.Text,
                                                                         fltDiferenca,
                                                                         dtaDtaCai);
      End
      Else
        blnLancouDiferencas := fAnalisaFechamentoOperadoresCaixa;

      If Not blnLancouDiferencas Then
      Begin
        pFinalizar;
        Exit;
      End;

      objResumoDeCaixa.fRetornaUltimoFechamento(fltSalFec, dtaDtaFec, edtCodigoCaixa.Text);
      objResumoDeCaixa.fCaixaTemMovimento(edtCodigoCaixa.Text, dtaDtaFec + 1, qryGenRc2);
      With qryGenRcx Do
      Begin
        fltDinheiFec := FieldByName('RCX_DINREC').AsFloat;
        fltCartaoFec := FieldByName('RCX_CARREC').AsFloat;
        fltChqPreFec := FieldByName('RCX_CHQPRE').AsFloat;
        fltChqAviFec := FieldByName('RCX_CHQAVI').AsFloat;
        fltOrdPagFec := FieldByName('RCX_ORDREC').AsFloat;
        fltValFinFec := FieldByName('RCX_VALFIN').AsFloat;

        fltReal      := FieldByName('RCX_TOTREA').AsFloat;
        fltPeso      := FieldByName('RCX_TOTPES').AsFloat;
        fltDolar     := FieldByName('RCX_TOTDOL').AsFloat;
        fltGuaranie  := FieldByName('RCX_TOTGUA').AsFloat;
        fltEuro      := FieldByName('RCX_TOTEUR').AsFloat;

        Close;
      End;

      {********************************************}
      {* RECALCULA SALDO PARA FECHAMENTO DO CAIXA *}
      {*****************************************AF*}
      While (Not qryGenRc2.Eof) Do
      Begin
        fltSalFec    := fltSalFec    + qryGenRc2.FieldByName('RCX_VALDOC').AsFloat;
        fltDinheiFec := fltDinheiFec + qryGenRc2.FieldByName('RCX_DINREC').AsFloat;
        fltCartaoFec := fltCartaoFec + qryGenRc2.FieldByName('RCX_CARREC').AsFloat;
        fltChqPreFec := fltChqPreFec + qryGenRc2.FieldByName('RCX_CHQPRE').AsFloat;
        fltChqAviFec := fltChqAviFec + qryGenRc2.FieldByName('RCX_CHQAVI').AsFloat;
        fltOrdPagFec := fltOrdPagFec + qryGenRc2.FieldByName('RCX_ORDREC').AsFloat;
        fltValFinFec := fltValFinFec + qryGenRc2.FieldByName('RCX_VALFIN').AsFloat;

        fltGuaranie  := fltGuaranie + qryGenRc2.FieldByName('RCX_TOTGUA').AsFloat;
        fltDolar     := fltDolar    + qryGenRc2.FieldByName('RCX_TOTDOL').AsFloat;
        fltEuro      := fltEuro     + qryGenRc2.FieldByName('RCX_TOTEUR').AsFloat;
        fltPeso      := fltPeso     + qryGenRc2.FieldByName('RCX_TOTPES').AsFloat;
        fltReal      := fltReal     + qryGenRc2.FieldByName('RCX_TOTREA').AsFloat;

        qryGenRc2.Next;
      End;

    End;

    If blnConfirma Then
    Begin
      blnConfirma := objResumoDeCaixa.PermitidoFecharOCaixaComOSaldoAtual(fltSalFec);

      If Not blnConfirma Then
      Begin
        pFinalizar;
        Exit;
      End;
    End;

    pTrocaSinalMoedas(fltDinheiFec);

    Try
      fStartTransaction;

      If (Not fGravaCadRcx(strSeqRcx,
                           '',                      // Cliente
                           edtCodOpe.Text,          // Operador
                           '',                      // Documento
                           'FC',                    // Espécie
                           VS_strCodEmp,            // Empresa
                           dtaDtaCai,               // Data de Cadastro
                           fTime(),                 // Hora de Cadastro
                           '',                      // Duplicata
                           '',                      // Parcela
                           'FECHAMENTO DE CAIXA',   // Descrição
                           '',                      // Juros / Desconto
                           'X',                     // Identificação de Fechamento
                           '',                      // Formade Pagamento
                           fltSalFec,               // Valor do Documento
                           0.0,                     // Valor do Desconto
                           0.0,                     // Valor do Juros
                           fltDinheiFec,            // Dinheiro recebido
                           fltChqAviFec,            // Cheque a vista
                           fltChqPreFec,            // Cheque pre datado
                           fltCartaoFec,            // Valor em Cartão
                           fltOrdPagFec,            // Valor em Ordem de Pagamento
                           0,                       // Valor do Crédito
                           fltValFinFec,            // Valor em Financiamento
                           0.0,                     // Valor de outros
                           0.0,                     // Venda a prazo
                           '',                      // Num. do Romaneio
                           0,                       // Sequencial de Controle
                           0,                       // Sequencial de Baixa (Duplicata)
                           fCfgSisL('SQFCRX'),       //Sequencial de Fechamento parcial de caixa
                           '',                      //Empresa da duplicata
                           Trim(strMotDes),               //Motivo do desconto
                           2,
                           fltGuaranie,
                           fltDolar,
                           fltEuro,
                           fltPeso,
                           fltReal,
                           'N',
                           '',
                           edtCodigoCaixa.Text,
                           strLacreDoFechamento,
                           0.00,
                           blnDivergencia,
                           fltDiferenca,
                           strOperadorPermissao,
                           dtaDataPermissao)) Then
      Begin
        fRollBack;
        FreeAndNil(qryGenRcx);
        FreeAndNil(qryGenRc2);
        Result := False;
        Exit;
      End
      ELse
      begin
        If strTipoFechamentoCaixa <> 'C' Then
          fAtuCfgSis('SQFCRX', '1')
        Else
          objResumoDeCaixa.pAtualizaRegistrosDoCaixaParaFechados(edtCodigoCaixa.Text,
                                                                 VS_strCodEmp,
                                                                 dtaDtaCai,
                                                                 strLacreDoFechamento);


        pGeraLogLiberacao('', '', '');

        fCommit;

        If (blnDivergencia) And
           (LUsaControleDivergencias) Then
          pImprimeTermoDeFechamentoComDivergencia;

        fMensagem('AVISO', 'Resumo de caixa fechado com sucesso!', ['&Ok']);
        objResumoDeCaixa.fNecessitaFecharCaixa(False, dtaDtaCai, edtCodigoCaixa.Text);
        mskDiaAbe.Text := DateToStr(dtaDtaCai);
        pRetornaUsuarioCaixa;
        Result := True;
      end;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[fFecharCaixa]');
        Exit;
      End;
    end;

    FreeAndNil(qryGenRcx);
    FreeAndNil(qryGenRc2);
  Finally
    objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDoFechamento(edtCodigoCaixa.Text), False);
  End;
end;

{*******************************************}
{* ANALIZA O FECHAMENTO DO CAIXA SE HOUVER *}
{* VALORES EM DINHEIRO DIFERENTE DE 0,00   *}
{* IRÁ GERAR LC/LD PARA ACERTAR O CAIXA    *}
{*24/02/2015*REQ:30980*******************AF*}
function TfrmRcxResumoCaixa.fAnalisaFechamentoOperadoresCaixa: Boolean;
  Var
    qryAnalisa: TUniQuery;
    strSQL: String;
    intFat: Integer;

    fltUltimoFechamento,
    fltValorDoAcerto   : Double;

    LSomaDinheiro,
    LSomaAnterior,
    LDiferencaSaldo,
    LAjusteZerar,
    LSomaAcertos: Double;

    LDatasetAnalisa: TUniClientDataSet;

    LDadosUltimoFechamento: TDataset;

    LCaixaFecharZerado,
    LPossuiOperadorNegativo: Boolean;
Begin
  If Not objResumoDeCaixa.strTipoFechamento.Equals('C') Then
  Begin
    If fCfgSis('CEGZER', varBoolean) Then
      Exit(AnalisaFechamentoOperadoresCaixaZerado);
  End;

  LCaixaFecharZerado := fCfgSis('FECZER', varBoolean);

  LPossuiOperadorNegativo := False;

  Try
    qryAnalisa := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT                      ';
    strSQL := strSQL + '  RCX_CODOPE AS CODOPE,     ';
    strSQL := strSQL + '  SUM(RCX_DINREC) AS VALDIN,';
    strSQL := strSQL + '  0.00 AS VALOR_AJUSTE      ';
    strSQL := strSQL + 'FROM                        ';
    strSQL := strSQL + '  CADRCXX                   ';
    strSQL := strSQL + 'WHERE                       ';
    strSQL := strSQL + '  RCX_DTACAD = :DTACAI AND  ';
    strSQL := strSQL + '  RCX_CODEMP = :CODEMP AND  ';

    If Not fEmptyStr(edtCodigoCaixa.Text) Then
    Begin
      strSQL := strSQL + '  RCX_CODCAX = "' + edtCodigoCaixa.Text + '" AND  ';
      strSQL := strSQL + '  RCX_LANFEC <> "S" AND   ';
    End;

    strSQL := strSQL + '  RCX_ESPDOC <> "FC"        ';
    strSQL := strSQL + 'GROUP BY RCX_CODOPE         ';
    strSQL := strSQL + 'ORDER BY VALDIN DESC        ';

    qryAnalisa.SQL.Text := strSQL;
    qryAnalisa.ParamByName('DTACAI').AsDateTime := dtaDtaCai;
    qryAnalisa.ParamByName('CODEMP').AsString   := VS_strCodEmp;
    qryAnalisa.Open;

    LDatasetAnalisa := fCriaClientDatSet(qryAnalisa);
    LDatasetAnalisa.Open;

    qryAnalisa.Close;
    FreeAndNil(qryAnalisa);

    Try

      If Not fEmptyStr(edtCodigoCaixa.Text) Then
        LDadosUltimoFechamento := objResumoDeCaixa.fRetornaDadosUltimoFechamento(edtCodigoCaixa.Text, VS_strCodEmp)
      Else
        LDadosUltimoFechamento := untCadRcxx.fRetornaDadosUltimoFechamento(VS_strCodEmp);

      fltUltimoFechamento := LDadosUltimoFechamento.FieldByName('RCX_DINREC').AsFloat;


      LSomaAcertos := 0;

      LAjusteZerar := 0;
      LSomaDinheiro := 0;
      LDatasetAnalisa.First;
      While Not LDatasetAnalisa.Eof Do
      Begin
        LSomaDinheiro := LSomaDinheiro + LDatasetAnalisa.FieldByName('VALDIN').AsFloat;

        LDatasetAnalisa.Next;
      End;

      LSomaAnterior := LSomaDinheiro;
      LDiferencaSaldo := fltUltimoFechamento + LSomaDinheiro;
      If (fltUltimoFechamento <> 0) And (LSomaDinheiro < 0) Then
        LDiferencaSaldo := LSomaDinheiro;

      If Not LCaixaFecharZerado Then
        LAjusteZerar := LDiferencaSaldo;

      If LAjusteZerar < 0 Then
      Begin
        If fltUltimoFechamento + LSomaDinheiro < 0 Then
          LAjusteZerar := -fltUltimoFechamento;
      End;

      //Calcular Valor Saldo
      LDatasetAnalisa.First;
      While Not LDatasetAnalisa.Eof Do
      Begin
        If (fFormataFloat(Abs(LDatasetAnalisa.FieldByName('VALDIN').AsFloat),2) = 0.00) Then
        Begin
          LDatasetAnalisa.Next;

          Continue;
        End;

        intFat := -1;
        If fFormataFloat(LDatasetAnalisa.FieldByName('VALDIN').AsFloat,2) < 0 Then
        Begin
          intFat := 1;
          LPossuiOperadorNegativo := True;
        End;

        fltValorDoAcerto := Abs(LDatasetAnalisa.FieldByName('VALDIN').AsFloat) * intFat;

        LDatasetAnalisa.Edit;
        LDatasetAnalisa.FieldByName('VALOR_AJUSTE').AsFloat := fltValorDoAcerto;
        LDatasetAnalisa.Post;

        LSomaAcertos := LSomaAcertos + fltValorDoAcerto;

        LDatasetAnalisa.Next;
      End;

      Result := True;

      If (LSomaDinheiro > 0) And (Not LPossuiOperadorNegativo) Then
        Exit;

      fStartTransaction;

      LDatasetAnalisa.First;
      While Not LDatasetAnalisa.Eof Do
      Begin
        If (fFormataFloat(Abs(LDatasetAnalisa.FieldByName('VALOR_AJUSTE').AsFloat),2) = 0.00) Then
        Begin
          LDatasetAnalisa.Next;

          Continue;
        End;

        fltValorDoAcerto := LDatasetAnalisa.FieldByName('VALOR_AJUSTE').AsFloat;

        If fltValorDoAcerto > 0 Then
        Begin
          If LAjusteZerar < 0 Then
            fltValorDoAcerto := fltValorDoAcerto + LAjusteZerar
          Else If  LAjusteZerar > 0 Then
            fltValorDoAcerto := fltValorDoAcerto + LSomaAnterior;

          LAjusteZerar := 0;
        End;

        If fFormataFloat(fltValorDoAcerto, 2) = 0.00 Then
        Begin
          LDatasetAnalisa.Next;

          Continue;
        End;

        If (Not fGravaCadRcx(strSeqRcx,
                             '',                                                     // Cliente
                             LDatasetAnalisa.FieldByName('CODOPE').AsString,              // Operador
                             '',                                                     // Documento
                             IIF(fFormataFloat(fltValorDoAcerto,2) < 0, 'LD', 'LC'), // Espécie
                             VS_strCodEmp,                                           // Empresa
                             dtaDtaCai,                                              // Data de Cadastro
                             fTime(),                                                // Hora de Cadastro
                             '',                                                     // Duplicata
                             '',                                                     // Parcela
                             'ACERTO AUT. DIFERENÇA FECHAMENTO CAIXA',               // Descrição
                             '',                                                     // Juros / Desconto
                             '',                                                     // Identificação de Fechamento
                             '',                                                     // Formade Pagamento
                             fltValorDoAcerto,                                       // Valor do Documento
                             0.0,                                                    // Valor do Desconto
                             0.0,                                                    // Valor do Juros
                             fltValorDoAcerto,                                       // Dinheiro recebido
                             0.0,                                                    // Cheque a vista
                             0.0,                                                    // Cheque pre datado
                             0.0,                                                    // Valor em Cartão
                             0.0,                                                    // Valor em Ordem de Pagamento
                             0.0,                                                    // Valor do Crédito
                             0.0,                                                    // Valor em Financiamento
                             0.0,                                                    // Valor de outros
                             0.0,                                                    // Venda a prazo
                             '',                                                     // Num. do Romaneio
                             0,                                                      // Sequencial de Controle
                             0,                                                      // Sequencial de Baixa (Duplicata)
                             fCfgSisL('SQFCRX'),                                     // Sequencial de Fechamento parcial de caixa
                             '',                                                     // Empresa da duplicata
                             '',                                                     // Motivo do desconto
                             2,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             'N',
                             '',
                             edtCodigoCaixa.Text)) Then
        Begin
          Raise Exception.Create('Não foi possível fazer o acerto do caixa! Favor entrar em contato com a Citel!');
          Break;
        End;

        LDatasetAnalisa.Next;
      End;

      fCommit;
    Finally
      LDatasetAnalisa.Close;
      FreeAndNil(LDatasetAnalisa);

      FreeAndNil(LDadosUltimoFechamento);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollback;
      pMensagensErro(E.message,'');
    End;
  End;
End;

function TfrmRcxResumoCaixa.fApagarBoletoDeAdiantamentoPedido: Boolean;
begin
  Result := False;

  If Not cdsTmpResumoCaixa.FieldByName('CTR_ESPDOC').AsString.Equals('PD') Then
    Exit;

  If Not fUsaRotinaBoletoAdiantamento() Then
    Exit;

  If fExisteDocumentoEmitidoParaPedido(cdsTmpResumoCaixa.FieldByName('CTR_NUMDUP').AsString,
                                       cdsTmpResumoCaixa.FieldByName('CTR_ESPDOC').AsString,
                                       cdsTmpResumoCaixa.FieldByName('CTR_CODEMP').AsString) Then
    Exit;

  Result := True;
end;

function TfrmRcxResumoCaixa.fBaixaDeComissaoParaProfissional: Boolean;
  Var
    LClone: TUniClientDataSet;
begin
  If Not Assigned(cdsTmpResumoCaixa) Then
    Exit(False);

  If cdsTmpResumoCaixa.IsEmpty Then
    Exit(False);

  LClone := fCriaClientDatSet(cdsTmpResumoCaixa);

  LClone.Filter := 'CTR_MARDES=''M'' AND CTR_ESPDOC=''CC'' AND  ' +
                   'CTR_DOCDIV IS NOT NULL AND CTR_DOCDIV<>'''' ';
  LClone.Filtered := True;
  LClone.Open;

  Result := (fltTotCre < 0) And
            (Not LClone.IsEmpty);

  FreeAndNil(LClone);
end;

function TfrmRcxResumoCaixa.fEhMultiLojaComAlgumaEmpresaTefDesligado: Boolean;
var
  LarrDups : TArrDupSel;
  LintCont : Integer;
  LblnTefLigadoOutraEmpresa : Boolean ;
begin
  Result := False ;

  If Not fCfgSis('EMPFAT', varBoolean) Then
    Exit;

  if not fUsaTef then
    Exit ;

  if fCfgSis('MLOTEF', varString) = '1' then
    Exit ;

  If cdsTmpResumoCaixa.Active Then
  Begin

    LarrDups := fGetTitulosSelecionados();

    if (length(LarrDups) > 0) then
    Begin
      For LintCont := Low(LarrDups) To High(LarrDups) Do
      Begin
          If LarrDups[LintCont].strCodEmp <> VS_strCodEmp Then
          Begin
             LblnTefLigadoOutraEmpresa := MatchStr(fCfgSis('TEFCIT', varString, LarrDups[LintCont].strCodEmp), [OPCAO_CLISITEF, OPCAO_NCR]) ;
             if not LblnTefLigadoOutraEmpresa then
                Exit(True) ;
          End;
      End;
    End;

  End;

end;

function TfrmRcxResumoCaixa.fExistDuplicNaoBai: Boolean;
  Var
    strSQL: String;
Begin

  Result := False;

  if not Assigned(qryRecNBai) then
    qryRecNBai := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CONCAT(CTR_NUMDUP,CTR_PARCEL,"-",CTR_ESPDOC) AS NUMDUP, ';
  strSQL := strSQL + '  CTR_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  CTR_CODVEN AS CODVEN, ';
  strSQL := strSQL + '  CONCAT(CTR_CODCLI,"-",CLI_NOMCLI) AS CODCLI, ';
  strSQL := strSQL + '  CTR_HIST01 AS HISTOR, ';
  strSQL := strSQL + '  CTR_VALDUP AS VALDUP  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADREC LEFT JOIN CADCLI ON CLI_CODCLI = CTR_CODCLI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTR_DTACAD = ' + fCurrentDate + ' AND ';
  strSQL := strSQL + '  CTR_DTACAD = CTR_DTAVEN AND ';
  strSQL := strSQL + '  CTR_DTAREC IS NULL AND ';
  strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  LOCATE(CTR_ESPDOC,"CC_TR_DV_") <= 0 ';

  With qryRecNBai Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

    If Not IsEmpty Then Result := True;

  End;
End;

function TfrmRcxResumoCaixa.fExisteDocumentosAbertosCnd15Vencidos: Boolean;
Var
  LSql: String;
begin
  Try
    If Not Assigned(FQryCnd15V) Then
      FQryCnd15V := fCriaQuery;

    LSql := '';
    LSql := LSql + '  SELECT        ';
    LSql := LSql + '  CONCAT(CTR_NUMDUP,CTR_PARCEL,"-",CTR_ESPDOC) AS NUMDUP, ';
    LSql := LSql + '  CTR_CODEMP AS CODEMP, ';
    LSql := LSql + '  CTR_CODVEN AS CODVEN, ';
    LSql := LSql + '  CONCAT(CTR_CODCLI,"-",CLI_NOMCLI) AS CODCLI, ';
    LSql := LSql + '  CTR_HIST01 AS HISTOR, ';
    LSql := LSql + '  CTR_VALDUP AS VALDUP, ';
    LSql := LSql + '  CTR_DTAVEN AS DTAVEN  ';
    LSql := LSql + '  FROM          ';
    LSql := LSql + '    CADREC      ';
    LSql := LSql + '  JOIN CADCND ON      ';
    LSql := LSql + '    CND_CODIGO = CTR_CODCND   ';
    LSql := LSql + '  JOIN CADCLI ON      ';
    LSql := LSql + '    CLI_CODCLI = CTR_CODCLI   ';
    LSql := LSql + '  WHERE TRUE    ';
    LSql := LSql + '    AND CTR_DTAREC IS NULL    '; //DOCUMENTOS ABERTOS
    LSql := LSql + '    AND CTR_DTAVEN < ' + fCurrentDate + ' '; //VENCIDOS
    LSql := LSql + '    AND CND_CODFPG = "015"    '; //15 - A RECEBER

    FQryCnd15V.Close;
    FQryCnd15V.SQL.Clear;
    FQryCnd15V.SQL.Add(LSql);
    FQryCnd15V.Open;

    Result := Not FQryCnd15V.IsEmpty;
  Finally
    //
  End;
end;

procedure TfrmRcxResumoCaixa.btnFatPromocaoBrindesClick(Sender: TObject);
  Var
    frmFatPromocaoBrindes : TfrmFatPromocaoBrindes;
begin
  inherited;

  If Not fVerificaAcessoSistema('DIRRCXPBR', edtCodOpe.Text) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Promoção de Brindes por Produtos Vendidos (Resumo de Caixa)');

    objLiberacao.strDirAce := 'DIRRCXPBR';
    objLiberacao.strMsgSen := 'Promoção de Brindes';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := edtCodOpe.Text;
    objLiberacao.strCodDig := edtCodOpe.Text;

    If (Not objLiberacao.fLibera) Then
    Begin
      Exit;
    End;
  End;

  Try
    pCriarFormularios(TfrmFatPromocaoBrindes, frmFatPromocaoBrindes);
    frmFatPromocaoBrindes.strOperador := edtCodOpe.Text;
    frmFatPromocaoBrindes.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  pFreeAndNil(frmFatPromocaoBrindes);
end;

procedure TfrmRcxResumoCaixa.btnFecharCaixaClick(Sender: TObject);
var
  objTabela                           : TRegistroMsgLiberaTabela;
  objLinha                            : TLinhaMsgLibera;
  blnExisteTintProdutoAcabadoPendente : Boolean;
  blnExisteTintBaseColorantePendente  : Boolean;
  dtaInicialFechamento                : TDateTime;
  dtaUltimoLancamento                 : TDateTime;
  strPedidos                          : String;
begin
  inherited;

  if not fMensagemDocumentosPDV then
    Exit;

  If (strTipoFechamentoCaixa <> 'C') And (fTemCancelamentosPDV) Then
  Begin
    pMensagemOk('Há documentos do PDV pendentes de finalização de cancelamento.');
    tmrCancelamentosTimer(tmrCancelamentos);
    Exit;
  End;

  If (strTipoFechamentoCaixa <> 'C') And (fTemDocumentosPendentesPDV) Or (fTemDocumentosPendentesPDV(IncDay(VS_Date, -5))) Then
  Begin
    if (fCfgSis('PAFECF', varBoolean)) then
    begin
      pDestravaLockForcado('IMPORTACAO_PAF_' + VS_strCodEmp, 0);

      if (fMensagem('', 'Há documentos do PDV pendentes de importação, deseja processar esses documentos agora?', ['&Sim', '&Não'], 1) = 1) then
      begin
        pCriarForm(TfrmImportaMovimentoPAFECF);
      end;

      if ((fTemDocumentosPendentesPDV) Or (fTemDocumentosPendentesPDV(IncDay(VS_Date, -5)))) then
      begin
        pMensagemOk('Aguarde o robô do PDV importar todos os documentos e tente novamente.');
        Exit;
      end;
    end
    else
    begin
      pMensagemOk('Há documentos do PDV pendentes de importação. Clique no menu ' +
        'Util -> Reiniciar robô de importação PDVCitel, aguarde alguns minutos e tente novamente.');
      Exit;
    end;
  End;

  If EstaRealizandoRecebimentoF1F2 Then
    Exit;

  If (strTipoFechamentoCaixa <> 'C') And (fTemTransfEstoque(fCfgSis('TOLETE', VarInteger))) Then
  Begin
    pMensagemOk('Existem documentos pendentes na Entrada de Mercadorias Simplificada fora do prazo de ' +
                'tolerância de ' + fCfgSis('TOLETE') + ' dias. Tais documentos precisam ser efetivados ' +
                'para liberação do fechamento do caixa. Entre em contato com o responsável pelo setor de Compras.');
    Exit;
  End;

  If (strTipoFechamentoCaixa <> 'C') And (not TfrmValidaTitulosFxCaixa.fValidar) Then
    Exit;

  pRetornaUltimoLancamento(dtaUltimoLancamento, strCodEmp);

  If (btnEntFutCD.Visible) And (TfrmFatEmitirEntFutEmpCD.fTemPedidosEntFuturaParaFaturarEmpCD(strPedidos, dtaUltimoLancamento, True)) Then
  Begin
    pMensagemOk('Existem pedidos de entrega futura pelo CD para serem faturados. ' + #13#10 +
                'É necessário emitir a Nota Fiscal ' +
                'destes pedidos para liberação do fechamento de caixa!'+#10+#13+ strPedidos);
    Exit;
  End;

  If Not fVerificaPedidosPendentesDeFaturamento Then
    Exit;

  If (not fCfgSis('FCXDPE', varBoolean)) And fExistDuplicNaoBai Then
  Begin
    If ( fMensagem('','Existem documentos emitidos não baixados, Deseja continuar mesmo assim?',['&Sim', '&Não'], 2) = 1) Then
    Begin

      objLiberacao.Clear;

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'Documento'  , 20  , alEsquerda  , teAutcom);
      objLinha.pAddColuna(''  , 'Cliente'    , 50  , alEsquerda  , teAutcom);
      objLinha.pAddColuna(''  , 'Ven'        , 3   , alEsquerda  , teAutcom);
      objLinha.pAddColuna(''  , 'Valor'      , 13  , alEsquerda  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      With qryRecNBai Do
      Begin
        First;
        While Not Eof Do
        Begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna('Documento'  , FieldByName('NUMDUP').AsString                        , 20  , alEsquerda );
          objLinha.pAddColuna('Cliente'    , FieldByName('CODCLI').AsString                        , 50  , alEsquerda );
          objLinha.pAddColuna('Ven'        , FieldByName('CODVEN').AsString                        , 3   , alEsquerda );
          objLinha.pAddColuna('Valor'      , FormatFloat('#,##0.00',FieldByName('VALDUP').AsFloat) , 13  , alEsquerda );
          objTabela.lstLinhas.Add(objLinha);

          Next;
        End;

      End;

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      objLiberacao.strDirAce := 'FCXDPE';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := edtCodOpe.Text;
      objLiberacao.strCodDig := edtCodOpe.Text;

      If (Not objLiberacao.fLibera) Then
        Exit;

    End
    Else
      Exit;
  End;

  If Not fLiberaCaixaDocumentosAbertosCnd15Vencidos Then
    Exit;

  if VerificarSeExisteSaldoVinculadoATransferirAntesDoFechamento Then
    Exit;

  if (fCfgSis('NESTIN', varBoolean)) and
     (not fCfgSis('CXNETI', varBoolean)) then
  begin
     dtaInicialFechamento := StrToDate(mskDiaAbe.Text)+1;
     if dtaInicialFechamento > VS_Date then
       dtaInicialFechamento := VS_Date;

      blnExisteTintProdutoAcabadoPendente :=
        TCalculadorNotaFiscalEspecialTintometricoProdutoAcabado
          .Create(nil, dtaInicialFechamento, 0, nil, nil, nil)
          .fExisteNFTintometricoPendente;

      blnExisteTintBaseColorantePendente :=
        TCalculadorNotaFiscalEspecialTintometricoBasesColorantes
          .Create(nil, dtaInicialFechamento, 0, nil, nil, nil)
          .fExisteNFTintometricoPendente;

    if blnExisteTintProdutoAcabadoPendente or blnExisteTintBaseColorantePendente then
    begin
      pMensagemOk('Existe nota fiscal pendente de tintometria para ser emitida. '+
                  'Realize a emissão antes de fechar o caixa, para destravar este bloqueio ( CFG_CXNETI ).');

      Exit;
    end;
  end;

  log('Pressionou F7');
  pZeraVariaveisResumo;
  pLimpaCampos;
  fFecharCaixa;
  pnlDocumento.Enabled   := True;
  pnlModalidades.Enabled := False;
  lsvLancamentos.Enabled := True;
  pHabilitaClienteCC(FALSE);
  pFocarElemento;
  log('Fim do F7');
end;

procedure TfrmRcxResumoCaixa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var
    LPodeAlterar: Boolean;
begin
  inherited;

  If (Key = VK_F1) And (fValidaCampos(Self, True)) Then
  Begin
    LPodeAlterar := True;

    pgcDadosGerais.OnChanging(pgcDadosGerais, LPodeAlterar);

    If Not LPodeAlterar Then
      Exit;

    pnlDocumento.Enabled := True;
    pgcDadosGerais.ActivePageIndex := tbsLancamentos.PageIndex;
    pLimpaCampos;
    pFocarElemento;
  End

  Else If (Key = VK_F2) And (Shift <> [ssAlt]) And (fValidaCampos(Self, True)) Then
  Begin
    LPodeAlterar := True;

    pgcDadosGerais.OnChanging(pgcDadosGerais, LPodeAlterar);

    If Not LPodeAlterar Then
      Exit;

    pnlDocumento.Enabled := True;
    pgcDadosGerais.ActivePageIndex := tbsRecebimentos.TabIndex;
    pLimpaCampos;
    pFocarElemento;
  End

  Else If (Key = VK_F2) And (Shift = [ssAlt]) Then
    btnAcompanhaServ.Click

  Else If (Key = Ord('T')) And (Shift = [ssAlt]) Then
    btnAtalhos.Click

  Else If (Key = VK_F3) Then
  Begin
    If ssAlt in Shift Then
      btnTitRec.Click
    Else
      btnFormaPagamento.Click;
  End

  Else If (Key = VK_F4) Then
  Begin
    btnCancFec.Click;
  End

  Else If (Key = VK_F5) Then
  Begin
    btnDepoCheque.Click;
  End

  Else If (Key = VK_F6) And btnHisDeb.Enabled Then
  Begin
    btnHisDeb.Click;
  End

  Else If (Key = VK_F7) Then
  Begin
    btnFecharCaixa.Click;
  End

  Else If (Key = VK_F8) Then
  Begin
    If btnConfirmaCupons.Visible Then
      btnConfirmaCupons.Click;
  End

  Else If (Key = VK_F9) Then
  Begin
    btnBaixaCtaPagar.Click;
  End

  Else If (Key = VK_F10) Then
  Begin
    btnRelatorio.Click;
  End

  Else If (Key = VK_F11) Then
  Begin
    If (btnConfOrcamentos.Visible) And (btnConfOrcamentos.Enabled) Then
      btnConfOrcamentos.Click;
  End

  Else If (Key = VK_F12) Then
  Begin
    If (btnAbreGaveta.Visible) And (btnAbreGaveta.Enabled) Then
      btnAbreGavetaClick(Sender);
  End

  Else If (Key = VK_ESCAPE) Then
  Begin
    If Not fEmptyStr(edtValDoc.Text) Then
    Begin
      If fStrToFloat(edtValDoc.Text) <> 0 Then
      Begin
        If Not blnF11 Then
        Begin
          If fVerificaAndamentoLancamento Then
          Begin
            If cdsTmpResumoCaixa.Active Then
            begin
              cdsTmpResumoCaixa.First;
              While (Not cdsTmpResumoCaixa.Eof) Do
              Begin
                If (cdsTmpResumoCaixa.FieldByName('CTR_MARDES').AsString = 'M') Then
                begin
                  objLock.fLock_Unlock('CADREC' +
                                cdsTmpResumoCaixa.FieldByName('CTR_NUMDUP').AsString +
                                cdsTmpResumoCaixa.FieldByName('CTR_ESPDOC').AsString +
                                cdsTmpResumoCaixa.FieldByName('CTR_CODEMP').AsString +
                                cdsTmpResumoCaixa.FieldByName('CTR_CODCLI').AsString +
                                cdsTmpResumoCaixa.FieldByName('CTR_PARCEL').AsString,
                                False);
                end;
                cdsTmpResumoCaixa.Next;
              end;
            end;
            pLimpaCampos;
          end
          Else
            Key := 0;
        End
        Else
          btnSairClick(Sender);
      End
      Else
        btnSairClick(Sender);
    End
    Else
      btnSairClick(Sender);
  End

  Else If (Shift = [ssCtrl]) then
  Begin
    If Key = Ord('A') Then
    Begin
      btnAdiantamento.Click;
    End
    Else If Key = Ord('E') Then
    Begin
      btnEntFutCD.Click;
    End
    Else If Key = Ord('F') Then
    Begin
      btnConfFFSimplificada.Click;
    End
    Else If (Key = Ord('L')) And btnLeituraX.Visible Then
    Begin
      btnLeituraX.Click;
    End
    Else If Key = Ord('P') Then
    Begin
      btnFatPromocaoBrindes.Click;
    End
    Else If (Key = Ord('R')) And (btnCancelaCC.Visible) Then
    Begin
      btnCancelaCC.Click;
    End;
  End

  Else If (Shift = [ssAlt]) then
  Begin

    If Key = Ord('A') Then
    Begin
      btnAutTR.Click;
    End

    Else If Key = Ord('L') Then
    Begin
      btnLiberacao.Click;
    End

    Else If Key = Ord('P') Then
    Begin
      btnEstornoPG.Click;
    End

    Else If Key = Ord('D') Then
    Begin
      btnInfDoc.Click;
    End

    Else If Key = Ord('E') Then
    Begin
      btnEstorno.Click;
    End

    Else If Key = Ord('F') Then
    Begin
      btnConfCupSimplificada.Click;
    End

    Else If Key = Ord('C') Then
    Begin
      btnCapturarGT.Click;
    End

    Else If Key = Ord('H') Then
    Begin
      btnRelAltFormaPag.Click;
    End

    Else If Key = Ord('R') And (fCfgSis('RCXROM', varBoolean)) Then
    Begin
      btnRomaneio.Click;
    End

    Else If Key = Ord('V') Then
    Begin
      btnImprDAV.Click;
    End
    Else If (Key = Ord('B')) and (btnBaixaEntFutura.Visible) Then
    Begin
      btnBaixaEntFutura.Click;
    End;

  End;

end;

procedure TfrmRcxResumoCaixa.FormPaint(Sender: TObject);
begin
  inherited;
  If blnFecharForm Then
  Begin
    Self.Close;
  End;
end;

procedure TfrmRcxResumoCaixa.pLimpaCampos;
begin
  edtNumDoc.Clear;
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtDescri.Clear;
  edtDescri.MaxLength := 50;

  stlContratos.Clear;

  mskDtaIni.Date := VS_Date;
  mskDtaFin.Date := VS_Date;

  edtValDoc.Clear;
  If (pgcDadosGerais.ActivePage = tbsLancamentos) Then
     edtValDoc.Enabled := True
   Else
     edtValDoc.Enabled := False;

  lblVrRestante.Visible := False;
  lblCredito.Visible    := False;

  edtDinRec.Text := '0,00';
  edtCarRec.Text := '0,00';
  edtChqRec.Text := '0,00';
  edtChqPre.Text := '0,00';
  edtOrdRec.Text := '0,00';
  edtValJur.Text := '0,00';
  edtValDes.Text := '0,00';
  edtTroco.Text  := '0,00';

  fltTotGua := 0;
  fltTotDol := 0;
  fltTotEur := 0;
  fltTotPes := 0;
  fltTotRea := 0;
  fltTotDinSav := 0;

  blnLibRecCH := False;

  objTefRecebimento := fCriarTefRecebimento(VS_objTef);

  SetLength(arrLogLib, 0);
  SetLength(arrLogAvi, 0);

  pCalculaVrRestante;

  strSessaoTef := '';

  FDadosPixRecebimento := '';
  FDadosPixRequisicao := '';
  FObjetoPixRecebimento := Nil;
  btnReceberPix.Enabled := False;
  blnChqPreLiberado := False;

  chkPixAvulso.Enabled := False;
  chkPixAvulso.Checked := False;
end;

function TfrmRcxResumoCaixa.fLiberaCaixaDocumentosAbertosCnd15Vencidos: Boolean;
Var
  LObjTabela                           : TRegistroMsgLiberaTabela;
  LObjLinha                            : TLinhaMsgLibera;
begin
  If fCfgSis('FCX15V', VarBoolean) Then
    Exit(True);

  If Not fExisteDocumentosAbertosCnd15Vencidos Then
    Exit(True);

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Permitir fechar o caixa com documentos na condição de pagamento [015] vencidos');
  LObjTabela := TRegistroMsgLiberaTabela.Create;
  LObjLinha  := TLinhaMsgLibera.Create;
  LObjLinha.enuTipoLinha := tlCabecalho;
  LObjLinha.pAddColuna(''  , 'Documento'  , 20  , alEsquerda  , teAutcom);
  LObjLinha.pAddColuna(''  , 'Cliente'    , 50  , alEsquerda  , teAutcom);
  LObjLinha.pAddColuna(''  , 'Ven'        , 3   , alEsquerda  , teAutcom);
  LObjLinha.pAddColuna(''  , 'Valor'      , 13  , alEsquerda  , teAutcom);
  LObjLinha.pAddColuna(''  , 'Dta. Vencimento'  , 16  , alEsquerda  , teAutcom);
  LObjTabela.lstLinhas.Add(LObjLinha);

  FQryCnd15V.First;

  While Not FQryCnd15V.Eof Do
  Begin
    LObjLinha  := TLinhaMsgLibera.Create;
    LObjLinha.enuTipoLinha := tlValor;
    LObjLinha.pAddColuna('Documento'  , FQryCnd15V.FieldByName('NUMDUP').AsString                        , 20  , alEsquerda );
    LObjLinha.pAddColuna('Cliente'    , FQryCnd15V.FieldByName('CODCLI').AsString                        , 50  , alEsquerda );
    LObjLinha.pAddColuna('Ven'        , FQryCnd15V.FieldByName('CODVEN').AsString                        , 3   , alEsquerda );
    LObjLinha.pAddColuna('Valor'      , FormatFloat('#,##0.00',FQryCnd15V.FieldByName('VALDUP').AsFloat) , 13  , alEsquerda );
    LObjLinha.pAddColuna('Dta. Vencimento'      , DateToStr(FQryCnd15V.FieldByName('DTAVEN').AsDateTime) , 16  , alEsquerda );
    LObjTabela.lstLinhas.Add(LObjLinha);
    FQryCnd15V.Next;
  End;

  objLiberacao.objMsgLibera.lstRegistros.Add(LObjTabela);
  objLiberacao.strDirAce := 'FCX15V';
  objLiberacao.blnMosMen := True;
  objLiberacao.strMsgSen := 'Permitir fechar o caixa com documentos na condição de pagamento [015] vencidos';
  objLiberacao.strCodOpe := edtCodOpe.Text;
  objLiberacao.strCodDig := edtCodOpe.Text;

  Result := objLiberacao.fLibera;
end;

function TfrmRcxResumoCaixa.fLiberarRecebChqPre: Boolean;
begin
  try
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('');
    objLiberacao.objMsgLibera.pAddTexto('RECEBIMENTO DE DOCUMENTO VENCIDO COM CHEQUE PRÉ      ', alCentro   , teAutcom);
    objLiberacao.objMsgLibera.pAddQuebra;

    pAddDupVencidas;

    objLiberacao.strDirAce := 'PRDVCCCHP';
    objLiberacao.strSenLib := fCfgSis('RECVCD');
    objLiberacao.strMsgSen := 'Receb. doc. vencido c/ cheque pré';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;
    objLiberacao.strCodIte := '002'; //Parametrizar a diferença no Log entre CC e CHQ.

    Result := objLiberacao.fLibera;

  except on E: Exception do
    begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmRcxResumoCaixa.fLiberarRecebCartCredito]');
    end;
  end;
end;

function TfrmRcxResumoCaixa.fLiberarRecebChqPreAVencer: Boolean;
begin
  try
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('');
    objLiberacao.objMsgLibera.pAddTexto('RECEBIMENTO DE DOCUMENTO Á VENCER COM CHEQUE PRÉ      ', alCentro   , teAutcom);
    objLiberacao.objMsgLibera.pAddQuebra;

    pAddDupAVencer;

    objLiberacao.strDirAce := 'DIRRCXRECDUPAVCCCH';
    objLiberacao.strSenLib := fCfgSis('PERCCV');
    objLiberacao.strMsgSen := 'Receb. doc. á vencer c/ cheque pré';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;
    objLiberacao.strCodIte := '002'; //Parametrizar a diferença no Log entre CC e CHQ.

    Result := objLiberacao.fLibera;

  except on E: Exception do
    begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmRcxResumoCaixa.fLiberarRecebChqPreAVencer]');
    end;
  end;
end;

function TfrmRcxResumoCaixa.fLogChq(AAutoIncrem: String; intOpcao: Integer;
  blnTransf: Boolean): Boolean;
  Var
    strHist: String;
begin

  Try
    strHist := 'INSERINDO CHQ. ' + IIF(intOpcao = 1, 'PRE. ', 'VIS. ') + '(frmRcxResumoCaixa.fLogChq)';
    If blnTransf Then
      strHist := 'TRANSFERENCIA CHQ. ' + IIF(intOpcao = 1, 'VIS. ', 'PRE. ') + '(frmRcxResumoCaixa.fLogChq)';

    untLogChq.GravaLogChq(AAutoIncrem,
                          strHist,
                          Self.Name);

    Result := True;
  Except
    On E: Exception Do
      Raise;
  End;
end;

function TfrmRcxResumoCaixa.fLogChq(qryLog: TDataset; intOpcao: Integer; blnTransf: Boolean = False): Boolean;
  Var
     strHist: String;
 begin
 
  Try
    strHist := 'INSERINDO CHQ. ' + IIF(intOpcao = 1, 'PRE. ', 'VIS. ') + '(frmRcxResumoCaixa.fLogChq)';
    If blnTransf Then
      strHist := 'TRANSFERENCIA CHQ. ' + IIF(intOpcao = 1, 'VIS. ', 'PRE. ') + '(frmRcxResumoCaixa.fLogChq)';
 
    If Not qryLog.FieldByName('AUTOINCREM').AsString.IsEmpty Then
      untLogChq.GravaLogChq(qryLog.FieldByName('AUTOINCREM').AsString,
                            strHist,
                            Self.Name)
    Else
      untLogChq.GravaLogChq(qryLog.FieldByName('CHQ_CODBCO').AsString,
                            qryLog.FieldByName('CHQ_NUMAGE').AsString,
                            qryLog.FieldByName('CHQ_CONCOR').AsString,
                            qryLog.FieldByName('CHQ_NUMCHQ').AsString,
                            strHist,
                            Self.Name);
 
    Result := True;
  Except
    On E: Exception Do
    Begin
     Raise;
    End;
  End;
end;

function TfrmRcxResumoCaixa.fMensagemDocumentosPDV: Boolean;
begin
  if (fCfgSis('PAFECF', varBoolean)) then
    Result := (fMensagem('Atenção', 'Verifique se todos os documentos emitidos pelo PDVCitel foram processados antes de prosseguir!'+#13+
                                    'Feche o programa PDVCitel para garantir a exportação dos documentos!'+#13+
                                    'Essa verificação é necessária para que nenhum cupom fique de fora do fechamento do caixa,'+#13+
                                    'Deseja prosseguir com o fechamento?', ['&Sim', '&Não'], 1) = 1)
  else
    Result := True;
end;

function TfrmRcxResumoCaixa.fNumeroDuplicataCTPValido: Boolean;
Var
  qryAux: TUniQuery;
begin
  // FUNÇÃO PARA VERIFICAR SE O NUMERO DA DUPLICATA É VALIDO PARA GRAVAÇÃO
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add(' SELECT COUNT(AUTOINCREM) AS QUANTIDADE ');
  qryAux.SQL.Add(' FROM CADPAG ');
  qryAux.SQL.Add(' WHERE CTP_NUMDUP = :NUMDUP ');
  qryAux.SQL.Add('   AND CTP_CODFOR = :CODFOR ');
  qryAux.SQL.Add('   AND CTP_CODEMP = :CODEMP ');
  qryAux.ParamByName('NUMDUP').AsString := edtNumDoc.Text;
  qryAux.ParamByName('CODFOR').AsString := strCodFor;
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.Open;

  if qryAux.FieldByName('QUANTIDADE').AsString = '0' then
    Result := True
  else
    Result := False;

  FreeAndNil(qryAux);
end;

procedure TfrmRcxResumoCaixa.pMostraNFCePendentes;
begin
  pCriarFormularios(TfrmRcxNFCePendentes, frmRcxNFCePendentes);
  Try 
    If fUsaSat Then
    Begin
      frmRcxNFCePendentes.Caption := 'SAT-CFe pendentes';
      frmRcxNFCePendentes.strNome := 'SAT-CFe';
    End;

    frmRcxNFCePendentes.intTempoEmSegundosPendente := 30;
    pCarregaNFCePendente(frmRcxNFCePendentes.qryNFCe, frmRcxNFCePendentes.intTempoEmSegundosPendente);

    frmRcxNFCePendentes.ShowModal;
  Finally
    pFreeAndNil(frmRcxNFCePendentes);
  End;
end;

procedure TfrmRcxResumoCaixa.pMostraObsCliente;
begin
  If fEmptyStr(edtCodCli.Text) Or (Not qryConCli.Active) Then
    Exit;

  {*****************************************}
  {* SE ESTIVER TUDO EM BRANCO, SAI        *}
  {**************************************MV*}
  If (fEmptyStr(qryConCli.FieldByName('CLI_OBSERV').AsString)) Then
    Exit;

  Try
    pCriarFormularios(TfrmFatMostraObsCliente, frmFatMostraObsCliente);
    frmFatMostraObsCliente.memObserv.Text := qryConCli.FieldByName('CLI_OBSERV').AsString;
    frmFatMostraObsCliente.strCodCli := qryConCli.FieldByName('CLI_CODCLI').AsString;
    frmFatMostraObsCliente.showModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[pMostraObsCliente]');
  End;

  pFreeAndNil(frmFatMostraObsCliente);
end;

procedure TfrmRcxResumoCaixa.pMostraOperadoresESaldosPendentes;
var
  fltUltFec: Double;
  dtaDtaFec: TDateTime;
begin

  objResumoDeCaixa.fRetornaUltimoFechamento(fltUltFec, dtaDtaFec, edtCodigoCaixa.Text);

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(147, 6785, [],
                        ['DTACAD','CODEMP','CODOPE'],
                        [DateToStr(dtaDtaFec), VS_strCodEmp, edtCodigoCaixa.Text],
                        nil,
                        nil,
                        True);
  End;

end;

function TfrmRcxResumoCaixa.fCancelaFechamento: Boolean;
  Var
    strSQL     : String;
    fltUltFec  : Double;
    dtaUltFec  : TDateTime;
    blnConfirma: Boolean;
    qryGenRcx  : TUniQuery;
    frmRcxCancFechamento : TfrmRcxCancFechamento;

begin
  qryGenRcx := fCriaQuery(Nil);

  objResumoDeCaixa.fRetornaUltimoFechamento(fltUltFec, dtaUltFec, edtCodigoCaixa.Text);

  If (dtaDtaFec = dtaDtaCai) Then
  Begin

    Try
      pCriarFormularios(TfrmRcxCancFechamento, frmRcxCancFechamento);
      frmRcxCancFechamento.dtaDtaFec := dtaDtaCai;
      frmRcxCancFechamento.ShowModal;

      blnConfirma := frmRcxCancFechamento.blnConfirma;
    Except
      On E: Exception Do
      Begin
        blnConfirma := False;
        pMensagensErro(E.Message, '[fCancelaFechamento]');
      End;
    End;

    pFreeAndNil(frmRcxCancFechamento);

    If (Not blnConfirma) Then
    Begin
      Result := False;
      Exit;
    End;

    If (fMensagem('', 'Confirma?', ['&Não', '&Sim']) = 1) Then
    Begin
      Result := False;
      Exit;
    End;

    Try

      fStartTransaction;

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM ';
      strSQL := strSQL + '  CADRCXX ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  RCX_ESPDOC = "FC" AND ';
      strSQL := strSQL + '  RCX_DTACAD = :DTACAD AND ';
      strSQL := strSQL + '  RCX_CODEMP = :CODEMP ';

      If strTipoFechamentoCaixa = 'C' Then
      Begin
        strSQL := strSQL + '  AND RCX_CODCAX = ' + QuotedStr(edtCodigoCaixa.Text);
        strSQL := strSQL + '  AND AUTOINCREM = ' + objResumoDeCaixa.fRetornaDadosUltimoFechamento(edtCodigoCaixa.Text,
                                                                                                  VS_strCodEmp)
                                                   .FieldByName('AUTOINCREM').AsString.QuotedString;
      End;

      With qryGenRcx Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('DTACAD').AsDateTime := dtaDtaCai;
        ParamByName('CODEMP').AsString   := VS_strCodEmp;
        ExecSQL;
        Close;
      End;

      If strTipoFechamentoCaixa <> 'C' Then
        pVoltaSeqFechamentoParcial
      Else
        objResumoDeCaixa.pAtualizaRegistrosDoCaixaParaAbertos(edtCodigoCaixa.Text,
                                                              VS_strCodEmp,
                                                              dtaDtaCai);

      fCommit;
      Result := True;
      fMensagem('AVISO', 'Cancelamento efetuado com sucesso!', ['&Ok']);

      objResumoDeCaixa.fNecessitaFecharCaixa(False, dtaDtaCai, edtCodigoCaixa.Text);
      pRetornaUsuarioCaixa;

    Except
      On E: Exception Do
      Begin
        fRollBack;

        pMensagensErro(E.Message, '[TfrmRcxResumoCaixa.fCancelaFechamento]');

        Result := False;
      End;
    End;

  End
  Else
  Begin
    fMensagem('', 'Não existe fechamento referente ao dia ' + DateToStr(dtaDtaCai), ['&Ok']);
    Result := False;
  End;

  FreeAndNil(qryGenRcx);

end;

procedure TfrmRcxResumoCaixa.btnCancelaCCClick(Sender: TObject);
  Var
    frmRcxCancelaCC: TfrmRcxCancelaCC;
begin
  inherited;
  If (Not btnCancelaCC.Visible) Then
    Exit;

  If EstaRealizandoRecebimentoF1F2 Then
    Exit;

  Try
    pCriarFormularios(TfrmRcxCancelaCC, frmRcxCancelaCC);
    frmRcxCancelaCC.strCodigoCaixa   := edtCodigoCaixa.Text;
    frmRcxCancelaCC.objResumoDeCaixa := objResumoDeCaixa;
    frmRcxCancelaCC.ShowModal;
  Finally
    FreeAndNil(frmRcxCancelaCC);
  End;
end;

procedure TfrmRcxResumoCaixa.btnCancelamentoPDVClick(Sender: TObject);
begin
  inherited;
  If btnCancelamentoPDV.Tag = PENDENCIA_PDV_CHEQUE Then
  Begin
    pVerificaPendenciaChequesPDV;
    tmrCancelamentosTimer(tmrCancelamentos);
  End
  Else
  Begin
    pCriarForm(TfrmFatCancelamentosPDV, frmFatCancelamentosPDV);
  End;
end;

procedure TfrmRcxResumoCaixa.btnCancFecClick(Sender: TObject);
begin
  inherited;
  If EstaRealizandoRecebimentoF1F2 Then
    Exit;

  log('Pressionou F4');
  pZeraVariaveisResumo;
  pLimpaCampos;
  fCancelaFechamento;
  pnlDocumento.Enabled   := True;
  pnlModalidades.Enabled := False;
  lsvLancamentos.Enabled := True;
  pHabilitaClienteCC(FALSE);
  cdsChqVis.EmptyDataSet;
  cdsChqPre.EmptyDataSet;
  pFocarElemento;
  log('Fim do F4');
end;

procedure TfrmRcxResumoCaixa.btnCapturarGTClick(Sender: TObject);
begin
  inherited;
  If Not btnCapturarGT.Visible Then
  Begin
    Exit;
  End;

  If Assigned(VS_objFiscal) Then
  Begin
    If fMensagem('ATENÇÃO!', 'Confirma capturar o GT e número de série do ECF?',
      ['&Sim', '&Não']) = 1 Then
    Begin
      Screen.Cursor := crHourGlass;
      pCriarFormularios(TfrmPafCadIniECF, frmPafCadIniECF);
      frmPafCadIniECF.btnExtrairDados.Click;
      frmPafCadIniECF.btnConfirmaDados.Click;
      FreeAndNil(frmPafCadIniECF);
      Screen.Cursor := crDefault;

      fMensagem('', 'GT e número de série capturados com sucesso!', ['&Ok']);
    End;
  End
  Else
  Begin
    fMensagem('ATENÇÃO!', 'PAF-ECF não configurado corretamente. Favor verificar.', ['&Ok']);
  End;
end;

procedure TfrmRcxResumoCaixa.edtDescriEnter(Sender: TObject);
begin
  inherited;
  pnlModalidades.Enabled := False;
end;

function TfrmRcxResumoCaixa.fDigitacaoCartoes(fltValor: Double): Boolean;
  Var
    fltTotCar,
    fltValIpi,
    fltValRet,
    fltValAce,
    fltValFre,
    fltValCbs,
    fltValIbs,
    fltVal_Is: Double;
    intTamMat: Integer;
    intContador: Integer;
    intContador2: Integer;
    intContador3: Integer;

    strCodCar: String;
    strDesCar: String;
    fltValDig: Double;
    dtaDatTra: TDateTime;
    fltValDes: Double;
    fltPerDes: Double;
    strCndPag: String;
    strObsCar: String;
    strNumCcd: String;
    strNumNsu: String;
    strArquivoTef: String;
    strTipCar: String;
    strViaCli: String;
    strViaLoj: String;
    strNumDoc: String;
    strDtaTra: String;
    strHraTra: String;
    strStatusCartao: String;
    strChaPix: String;
    strPixS_N: String;
    strCodigoCarteiraDigital: String;
    strCodigoTipoOperacaoCartao: String;
    strCodigoBandeira: String;
    LstrControle: String;

    blnSaiFor: Boolean;

    stlDeletados: TStringList;
    frmRcxMostraCartoes : TfrmRcxMostraCartoes;
    frmRcxDigCartoes : TfrmRcxDigCartoes;
    LarrTraDoc: TArrayInfoTraDoc ;
    LblnMultiLojaComAlgumaEmpresaTefDesligado: Boolean ;
begin

  Result := True;

  If (Not blnChamaCadastro) Then
    Exit;

  If (fltValor = 0.0) Then
  Begin
    pCancelarTefDeCartoesJaConfirmados;
    SetLength(arrCartoes, 0);
    Exit;
  End;

  fltTotCar := 0.0;
  fltValDig := 0.0;
  fltValDes := 0.0;
  fltPerDes := 0.0;
  dtaDatTra := 0;


  For intContador := 0 To Length(arrCartoes) -1 Do
  Begin
    fltTotCar := fltTotCar + arrCartoes[intContador].fltValDig;
  End;

  If (fltTotCar = fltValor) Then
  Begin

    Try
      pCriarFormularios(TfrmRcxMostraCartoes, frmRcxMostraCartoes);

      For intContador := 0 To Length(arrCartoes) -1 Do
      Begin
        frmRcxMostraCartoes.lsvCartoes.AddItem(arrCartoes[intContador].strCodCar + ' - ' +
                                               arrCartoes[intContador].strDesCar, Nil);
        frmRcxMostraCartoes.lsvCartoes.Items[intContador].SubItems.Add(FloatToStrF(arrCartoes[intContador].fltValDig, ffFixed, 12, 2));
        frmRcxMostraCartoes.lsvCartoes.Items[intContador].SubItems.Add(IntToStr(arrCartoes[intContador].intCodSeq));
      End;
      frmRcxMostraCartoes.lsvCartoes.Columns[2].Width := 0;

      frmRcxMostraCartoes.ShowModal;

      stlDeletados := frmRcxMostraCartoes.stlDeletados;

      For intContador := 0 To stlDeletados.Count -1 Do
      Begin

        blnSaiFor := False;

        For intContador2 := 0 To Length(arrCartoes) -1 Do
        Begin

          If (arrCartoes[intContador2].intCodSeq = StrToInt(stlDeletados[intContador])) Then
          Begin

            pGarantirCancelamentoTefRecebimento(arrCartoes[intContador2].strArqTef);

            if fRetTipoCartao(arrCartoes[intContador2].strCodCar) = 'C' then
              pRemoveLiberacao('PRDVCCCHP','001');

            For intContador3 := intContador2 To Length(arrCartoes) - 2 Do
            Begin
              arrCartoes[intContador3] := arrCartoes[intContador3+1];
            End;
            SetLength(arrCartoes, Length(arrCartoes)-1);
            blnSaiFor := True;

          End;

          If (blnSaiFor) Then
            Break;

        End;

      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fDigitacaoCartoes]');
      End;
    End;

    pFreeAndNil(frmRcxMostraCartoes);

  End;

  fltTotCar := 0.0;
  For intContador := 0 To Length(arrCartoes) -1 Do
  Begin
    fltTotCar := fltTotCar + arrCartoes[intContador].fltValDig;
  End;

  If fltValor < fltTotCar Then
  Begin
    fltTotCar := 0.0;
    pCancelarTefDeCartoesJaConfirmados;
    SetLength(arrCartoes,0);
  End;
  LarrTraDoc := fRetornaDocumentosTraDoc ;
  While ((fFormataFloat(fltTotCar, 2)) < (fFormataFloat(fltValor, 2))) Do
  Begin

    LblnMultiLojaComAlgumaEmpresaTefDesligado := fEhMultiLojaComAlgumaEmpresaTefDesligado ;
    Try
      pCriarFormularios(TfrmRcxDigCartoes, frmRcxDigCartoes);
      frmRcxDigCartoes.blnTemDupsVencidas := fVerificaTitulosVencidosSelecionados();
      frmRcxDigCartoes.blnTemDupsAVencer := fVerificaTitulosAVencerSelecionados();
      frmRcxDigCartoes.MultiLojaComAlgumaEmpresaTefDesligado := LblnMultiLojaComAlgumaEmpresaTefDesligado ;
      frmRcxDigCartoes.blnRcxResumoCaixa := True;
      frmRcxDigCartoes.fltTotDig := fltTotCar;
      frmRcxDigCartoes.fltTotGer := fltValor;
      frmRcxDigCartoes.fltMaxDig := (fltValor - fltTotCar);
      frmRcxDigCartoes.objTefRecebimento := objTefRecebimento;
      frmRcxDigCartoes.blnTefRcx := fCfgSis('TEFREC', varBoolean);
      frmRcxDigCartoes.blnTipPOS := (Not frmRcxDigCartoes.blnTefRcx) Or (VS_strUsaTEF <> 'S') or LblnMultiLojaComAlgumaEmpresaTefDesligado;
      frmRcxDigCartoes.arrCartoes := arrCartoes;
      frmRcxDigCartoes.strSessaoTef := strSessaoTef;
      frmRcxDigCartoes.strRcxCodOpe := edtCodOpe.Text;
      frmRcxDigCartoes.strOpcDoc    := 'RX';
      frmRcxDigCartoes.CdsTemp.Data := CdsTmpResumoCaixa.Data;
      frmRcxDigCartoes.Liberacao := ObjLiberacao;
      frmRcxDigCartoes.arrDocCartoes := LarrTraDoc ;

      If (frmRcxDigCartoes.fVaiExibirPerguntaTefPos) Then
        frmRcxDigCartoes.blnPermiteDigitarDados := False;

      If Not fEmptyStr(strCodCarSelPD) Then
      Begin
        frmRcxDigCartoes.strCodCar := strCodCarSelPD;
        frmRcxDigCartoes.intQtdPar := intQtdPaCSelPD;

        If (Not fVerificaAcessoSistema('F11ALTCAR', edtCodOpe.Text)) and (not fTefHabilitado) Then
        Begin
          frmRcxDigCartoes.edtCodCar.ReadOnly := True;
          frmRcxDigCartoes.edtQtdPar.ReadOnly := True;
        End;
      End;

      frmRcxDigCartoes.ShowModal;

      strCodCar := frmRcxDigCartoes.edtCodCar.Text;
      strDesCar := frmRcxDigCartoes.edtDesCar.Text;
      fltValDig := frmRcxDigCartoes.fltValDig;
      dtaDatTra := frmRcxDigCartoes.dtaDatTra;
      fltValDes := frmRcxDigCartoes.fltValDes;
      strCndPag := frmRcxDigCartoes.mskCndPag.Text;
      strNumCcd := frmRcxDigCartoes.edtNumCcd.Text;
      strNumNsu := fPadL(frmRcxDigCartoes.edtNumNsu.Text, 14, '0');
      strObsCar := frmRcxDigCartoes.edtObsCar.Text;
      fltPerDes := frmRcxDigCartoes.fltPerDes;
      strArquivoTef := frmRcxDigCartoes.strArquivoTef;
      strTipCar := IIF(frmRcxDigCartoes.blnTipPOS, 'POS', 'TEF');
      strTpParc := frmRcxDigCartoes.strTpParc;
      strViaCli := frmRcxDigCartoes.strArqViaCliente;
      strViaLoj := frmRcxDigCartoes.strArqViaLojista;
      strNumDoc := frmRcxDigCartoes.strNumDoc;
      strDtaTra := frmRcxDigCartoes.strDtaTra;
      strHraTra := frmRcxDigCartoes.strHraTra;
      strStatusCartao := 'P';
      strChaPix := frmRcxDigCartoes.strChaPix;
      strPixS_N := frmRcxDigCartoes.strPixS_N;
      strCodigoCarteiraDigital := frmRcxDigCartoes.strCodigoCarteiraDigital;
      strCodigoTipoOperacaoCartao := frmRcxDigCartoes.strCodigoTipoOperacaoCartao;
      strCodigoBandeira := frmRcxDigCartoes.strCodigoBandeira;
      LstrControle := frmRcxDigCartoes.strControle;
      FLiberadoCartCred := frmRcxDigCartoes.LiberadoCartCred;
      FLiberadoCartCredAVencer := frmRcxDigCartoes.LiberadoCartCredVencer;

      Result    := frmRcxDigCartoes.blnConfirma;

      if Result then
      begin
        if (Not VS_blnTefCitel) and ((strTipCar = 'TEF') and (fEmptyStr(strArquivoTef))) then
        begin
          Result := False;
          pMensagemOk('A modalidade selecionada utiliza "TEF", ' +
                      'porém não foi encontrado o arquivo que c' +
                      'onfirma a transação TEF. ' +
                      'Entre em contato com a CITEL para solução do problema!');
        end;
      end;

      if FLiberadoCartCred and (not Result) then
        pRemoveLiberacao('PRDVCCCHP','001');

      if FLiberadoCartCredaVencer and (not Result) then
        pRemoveLiberacao('DIRRCXRECDUPAVCCCH','001');

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fDigitacaoCartoes_1]');
      End;
    End;

    pFreeAndNil(frmRcxDigCartoes);

    If (Result) Then
    Begin
      pCarregaImpostoProporcional(fltValDig, fltValIpi, fltValRet, fltValAce, fltValFre, fltValCbs, fltValIbs, fltVal_Is);

      intTamMat := Length(arrCartoes);
      SetLength(arrCartoes, intTamMat+1);
      arrCartoes[intTamMat].intCodSeq := intTamMat;
      arrCartoes[intTamMat].strCodCar := strCodCar;
      arrCartoes[intTamMat].strDesCar := strDesCar;
      arrCartoes[intTamMat].fltValDig := fltValDig;
      arrCartoes[intTamMat].strCndPag := strCndPag;
      arrCartoes[intTamMat].strObsCar := strObsCar;
      arrCartoes[intTamMat].fltValDes := fltValDes;
      arrCartoes[intTamMat].strNumCcd := strNumCcd;
      arrCartoes[intTamMat].fltPerDes := fltPerDes;
      arrCartoes[intTamMat].strArqTef := strArquivoTef;
      arrCartoes[intTamMat].strTipCar := strTipCar;
      arrCartoes[intTamMat].dtaDtaTra := dtaDatTra;

      arrCartoes[intTamMat].fltValIpi := fltValIpi;
      arrCartoes[intTamMat].fltValRet := fltValRet;
      arrCartoes[intTamMat].fltValAce := fltValAce;
      arrCartoes[intTamMat].fltValFre := fltValFre;
      arrCartoes[intTamMat].fltValCbs := fltValCbs;
      arrCartoes[intTamMat].fltValIbs := fltValIbs;
      arrCartoes[intTamMat].fltVal_Is := fltVal_Is;

      If (Assigned(VS_objTef)) And (strTipCar = 'TEF') And (not VS_blnTefCitel) Then
      begin
        arrCartoes[intTamMat].strNumNsu := fPadL(VS_objTef.strNumNsu, 14, '0');
        arrCartoes[intTamMat].strPixS_N := VS_objTef.StrPixS_N;
        arrCartoes[intTamMat].strChaPix := VS_objTef.StrChaPix;
        arrCartoes[intTamMat].strCodigoCarteiraDigital := '' ;
        arrCartoes[intTamMat].strControle := '' ;
      end
      Else
      begin
        arrCartoes[intTamMat].strNumNsu := fPadL(strNumNsu, 14, '0');
        arrCartoes[intTamMat].strPixS_N := strPixS_N;
        arrCartoes[intTamMat].strChaPix := strChaPix;
        arrCartoes[intTamMat].strCodigoCarteiraDigital := strCodigoCarteiraDigital ;
        arrCartoes[intTamMat].strControle := LstrControle ;
      end;

      arrCartoes[intTamMat].strConteudoArquivo := '';
      If Not fEmptyStr(strArquivoTef) Then
      Begin
        If (VS_blnTefCitel) Then
          arrCartoes[intTamMat].strConteudoArquivo := strArquivoTef
        Else
          arrCartoes[intTamMat].strConteudoArquivo := fLerConteudoArquivo(strArquivoTef);
      End;

      if VS_blnTefCitel then
      begin
        arrCartoes[intTamMat].strViaCli := strViaCli;
        arrCartoes[intTamMat].strViaLoj := strViaLoj;
        arrCartoes[intTamMat].strNumDoc := strNumDoc;
        arrCartoes[intTamMat].strDtaTra := strDtaTra;
        arrCartoes[intTamMat].strHraTra := strHraTra;
        arrCartoes[intTamMat].strStatusCartao := strStatusCartao;
        arrCartoes[intTamMat].blnTefCnf := False;
        if fAutoConfirmaTransacaoPendenteEstaAtivada then
        begin
          arrCartoes[intTamMat].strCodigoTipoOperacaoCartao := strCodigoTipoOperacaoCartao;
          arrCartoes[intTamMat].strCodigoBandeira := strCodigoBandeira;
          arrCartoes[intTamMat].blnTefCnf := fAutoConfirmarTransacaoTef(arrCartoes[intTamMat]);
          if arrCartoes[intTamMat].blnTefCnf then
            arrCartoes[intTamMat].strStatusCartao := 'F';
        end;
      end;

      fltTotCar := 0.0;
      For intContador := 0 To Length(arrCartoes) -1 Do
      Begin
        fltTotCar := fltTotCar + arrCartoes[intContador].fltValDig;
      End;

    End
    Else
    Begin
      pGarantirCancelamentoTefRecebimento(strArquivoTef);
      pCancelarTefDeCartoesJaConfirmados;
      SetLength(arrCartoes, 0);
      Break;
    End;

  End;

end;

procedure TfrmRcxResumoCaixa.tbsLancamentosShow(Sender: TObject);
begin
  inherited;

  edtDinRec.Text := '0,00';
  edtCarRec.Text := '0,00';
  edtChqRec.Text := '0,00';
  edtChqPre.Text := '0,00';
  edtOrdRec.Text := '0,00';
  edtValJur.Text := '0,00';
  edtValDes.Text := '0,00';
  edtTroco.Text  := '0,00';

  fltTotGua := 0;
  fltTotDol := 0;
  fltTotEur := 0;
  fltTotPes := 0;
  fltTotRea := 0;
  fltTotDinSav := 0;

  pZeraVariaveisResumo;
  edtValDoc.Enabled := True;
  edtDescri.Enabled := True;
  lsvLancamentos.Enabled := True;
  pSetFocus(lsvLancamentos);
  If (lsvLancamentos.Items.Count > 0) Then
  Begin
    lsvLancamentos.ItemIndex   := 0;
    lsvLancamentos.Selected    := lsvLancamentos.Items[0];
    lsvLancamentos.ItemFocused := lsvLancamentos.Items[0];
  End;

  If strTipoFechamentoCaixa <> 'C' Then
    edtSqFcRx.Text := fStrZero(VarToStr(fCfgSisL('SQFCRX')), 3);

  pHabilitaClienteCC(FALSE);
  
end;

procedure TfrmRcxResumoCaixa.tbsRecebimentosShow(Sender: TObject);
begin
  inherited;

  edtDinRec.Text := '0,00';
  edtCarRec.Text := '0,00';
  edtChqRec.Text := '0,00';
  edtChqPre.Text := '0,00';
  edtOrdRec.Text := '0,00';
  edtValJur.Text := '0,00';
  edtValDes.Text := '0,00';
  edtTroco.Text  := '0,00';

  fltTotGua := 0;
  fltTotDol := 0;
  fltTotEur := 0;
  fltTotPes := 0;
  fltTotRea := 0;
  fltTotDinSav := 0;

  pZeraVariaveisResumo;
  edtValDoc.Enabled := False;
  edtDescri.Enabled := False;
  pSetFocus(edtCodCli);

  If strTipoFechamentoCaixa <> 'C' Then
    edtSqFcRx.Text := fStrZero(VarToStr(fCfgSisL('SQFCRX')), 3);
end;

procedure TfrmRcxResumoCaixa.tmrCancelamentosTimer(Sender: TObject);
begin
  inherited;
  If Not fCfgSis('PAFECF', varBoolean) Then
  Begin
    Exit;
  End;

  btnCancelamentoPDV.Tag := 0;
  btnCancelamentoPDV.Caption := 'Clique aqui para concluir o cancelamento do PDV';
  If fTemPendenciaChequesPDV Then
  Begin
    btnCancelamentoPDV.Visible := True;
    btnCancelamentoPDV.Tag := PENDENCIA_PDV_CHEQUE;
    btnCancelamentoPDV.Caption := 'Há possíveis cheques duplicados vindos do PDV.';
  End
  Else
  Begin
    btnCancelamentoPDV.Visible := fTemCancelamentosPDV;
  End;
end;

function TfrmRcxResumoCaixa.TodosOsPlanosDeContasTransferenciaCadastrados: Boolean;
begin
  Result := True;

  If fEmptyStr(fConverteCentroCusto(fCfgSisL('CTATRA'))) Then
    Exit(False);

  If fEmptyStr(fConverteCentroCusto(fCfgSisL('CTTRCV'))) Then
    Exit(False);

  If fEmptyStr(fConverteCentroCusto(fCfgSisL('CTTRCP'))) Then
    Exit(False);

  If fEmptyStr(fConverteCentroCusto(fCfgSisL('CTTRCR'))) Then
    Exit(False);

  If fEmptyStr(fConverteCentroCusto(fCfgSisL('CTTROP'))) Then
    Exit(False);

  If fEmptyStr(fConverteCentroCusto(fCfgSisL('CTTRFI'))) Then
    Exit(False);
end;

function TfrmRcxResumoCaixa.TravaMovimentoCaixaEmFechamento: Boolean;
var
  strNomeTrava  : String;
begin
  Result := False;
  strNomeTrava := 'RCXF7_' + VS_strCodEmp;

  If (fCfgSis('TPFCCX') = 'T') And
     (Not objLock.fLock_Unlock(strNomeTrava, True, False)) Then
  Begin
    pMensagemOk(objLock.fParseMensagemTrava(strNomeTrava,
                                            'O fechamento do caixa da empresa #EMP_CODEMP está sendo '+
                                            'feito pelo operador #LCK_CODOPE - #OPE_NOMOPE e '+
                                            'por isso, o F2 não pode ser utilizado. Entre em '+
                                            'contato com esse operador e depois, tente novamente.'));
    Exit(True);
  End
  Else
    objLock.fLock_Unlock(strNomeTrava, False);
end;

function TfrmRcxResumoCaixa.ValidarEmpresaAcesso: Boolean;
begin
  Result := True;

  If Not fCfgSis('EMPACE', varBoolean) Then
    Exit(True);

  If fEmptyStr(edtCodEmp.Text) Then
    Exit(True);

  If fEmptyStr(edtCodOpe.Text) Then
    Exit(True);

  If (Pos(edtCodEmp.Text, fRetEmpAcessoUsuario(edtCodOpe.Text)) <= 0) Then
    Exit(False);
end;

function TfrmRcxResumoCaixa.ValidarSeExistePixRecebidoSemConfirmacao: Boolean;
begin
  Result := Not Assigned(FObjetoPixRecebimento);

  If Result Then
    Exit;

  Result := Not TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(FObjetoPixRecebimento);

  If Not Result Then
  Begin
    Result := fMensagem('ATENÇÃO', 'O recebimento em andamento possui um Pix que já foi recebido.' + #13 +
                                   'Se continuar, o sistema não gravará o registro do pagamento desse Pix.' + #13 +
                                   'Deseja realmente continuar?', ['&Sim', '&Não'], 2) = 1;

    If Not Result Then
      Exit;

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Permitir cancelar recebimento do Resumo de Caixa com um Pix já recebido');

    AdicionarDadosDasDuplicatas(objLiberacao);

    objLiberacao.strDirAce := 'PERCANCRCXPIXREC';
    objLiberacao.strMsgSen := 'Permitir cancelar recebimento do Resumo de Caixa com um Pix já recebido';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := edtCodOpe.Text;
    objLiberacao.strCodDig := edtCodOpe.Text;

    Result := objLiberacao.fLibera;
  End;
end;

function TfrmRcxResumoCaixa.ValidaSaldoOrdemPagamentoPix(APixAvulso: Boolean;
  ASaldoTransferido: Double): Boolean;
  Var
    LSaldoAtual: Double;
begin
  If fFormataFloat(ASaldoTransferido, 2) <= 0 Then
    Exit(True);

  LSaldoAtual := objResumoDeCaixa.fRetornaSaldoCaixaCampo('RCX_ORDREC',
                                                          edtCodigoCaixa.Text,
                                                          VS_strCodEmp,
                                                          '',
                                                          APixAvulso,
                                                          APixAvulso,
                                                          Not APixAvulso);

  Result := fFormataFloat(LSaldoAtual, 2) > 0;
  If Not Result Then
  Begin
    fMensagem('ATENÇÃO', 'Não existe saldo suficiente para a transferência da modalidade ' + IIF(APixAvulso, 'Pix Avulso', 'Ordem de Pagamento') + '.' + #13 +
                         'Tente realizar a transferência novamente.', ['&Ok']);
    Exit;
  End;

  Result := fFormataFloat(LSaldoAtual, 2) >= fFormataFloat(ASaldoTransferido, 2);
  If Not Result Then
  Begin
    fMensagem('ATENÇÃO', 'Não existe saldo suficiente para a transferência da modalidade ' + IIF(APixAvulso, 'Pix Avulso', 'Ordem de Pagamento') + '.' + #13 +
                         'Tente realizar a transferência novamente.', ['&Ok']);
    Exit;
  End;
end;

function TfrmRcxResumoCaixa.ValidaValorDigitado(AEdit: TEdit): Boolean;
  Var
    LValorDigitado: Double;
    LValorRestante: Double;
begin
  Result := True;

  If Not AEdit.Enabled Then Exit;

  If MatchStr(strEspDoc, ['CC', 'LC']) Then
  Begin
    LValorDigitado := fFormataFloat(fStrToFloat(AEdit.Text),2);
    LValorRestante := fFormataFloat(CalculaValorRestante + LValorDigitado,2); // valor restante sem a modalidade digitada.

    If LValorDigitado = 0 Then
      Exit;

    If (LValorDigitado >  LValorRestante)  Then
    Begin
      fMensagem('ATENÇÃO', 'Não é permitido realizar o recebimento de um valor ' +
                           'maior ao valor do documento para esse tipo de lançamento.', ['&Ok']);
      Exit(False);
    End;
  End;
end;

function TfrmRcxResumoCaixa.fVerificaPedidosPendentesDeFaturamento: Boolean;

  Var LCancelaPedidosPendentes : TfrmCancelaPedidosPendentes;
begin
  Result := True;

   If Not fCfgSis('RCXPDP', varBoolean) Then
     Exit;

  Try
    pCriarFormularios(TfrmCancelaPedidosPendentes, LCancelaPedidosPendentes);

    If LCancelaPedidosPendentes.ExitePedidosPendentes Then
    Begin
      pMensagemOk('Existem pedidos de venda pendentes para faturamento nesta loja. ' + #13#10 +
                  'O fechamento do caixa não será autorizado sem que estes pedidos sejam resolvidos. '+  #13#10 +
                  'Eles deverão ser faturados ou cancelados.');

      LCancelaPedidosPendentes.Operador := edtCodOpe.Text;
      LCancelaPedidosPendentes.ShowModal;
    End;

    If LCancelaPedidosPendentes.ExitePedidosPendentes Then
      Result := False;

  Finally
    FreeAndNil(LCancelaPedidosPendentes);
  End;
end;

function TfrmRcxResumoCaixa.fTemCancelamentosPDV: Boolean;
  Var
    qryCancelamentos: TUniQuery;
begin
  qryCancelamentos := fCriaQuery(Self);
  Try
    qryCancelamentos.SQL.Clear;
    qryCancelamentos.SQL.Add('SELECT ');
    qryCancelamentos.SQL.Add('  COUNT(*) AS QTD ');
    qryCancelamentos.SQL.Add('FROM ');
    qryCancelamentos.SQL.Add('  PAF_CANCELAMENTOS ');
    qryCancelamentos.SQL.Add('WHERE ');
    qryCancelamentos.SQL.Add('  CAN_CODEMP = :CODEMP AND ');
    qryCancelamentos.SQL.Add('  CAN_CANCEL = 0 ');

    qryCancelamentos.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCancelamentos.Open;

    Result := (qryCancelamentos.FieldByName('QTD').AsInteger > 0);
  Finally
    FreeAndNil(qryCancelamentos);
  End;
end;

function TfrmRcxResumoCaixa.fTemDocumentosPendentesPDV(
  dtaDtaMov: TDateTime): Boolean;
  Var
    qryMovGer: TUniQuery;
begin
  qryMovGer := fCriaQuery(Self);
  Try
    qryMovGer.SQL.Clear;
    qryMovGer.SQL.Add(' SELECT COUNT(*) AS QTD ');
    qryMovGer.SQL.Add('   FROM MOVGER ');
    qryMovGer.SQL.Add('  WHERE GER_CODEMP = :CODEMP ');
    qryMovGer.SQL.Add('    AND GER_DTAENT >= :DTAMOV ');
    qryMovGer.SQL.Add('    AND GER_NUMDOC LIKE "F%" ');
    qryMovGer.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryMovGer.ParamByName('DTAMOV').AsDateTime := dtaDtaMov;
    qryMovGer.Open;

    Result := (qryMovGer.FieldByName('QTD').AsInteger > 0);
  Finally
    FreeAndNil(qryMovGer);
  End;
end;

function TfrmRcxResumoCaixa.fTemDocumentosPendentesPDV: Boolean;
  Var
    qryPafPrincipal: TUniQuery;
begin
  qryPafPrincipal := fCriaQuery(Self);
  Try
    qryPafPrincipal.SQL.Clear;
    qryPafPrincipal.SQL.Add('SELECT ');
    qryPafPrincipal.SQL.Add('  COUNT(*) AS QTD ');
    qryPafPrincipal.SQL.Add('FROM ');
    qryPafPrincipal.SQL.Add('  PAF_PRINCIPAL ');
    qryPafPrincipal.SQL.Add('WHERE ');
    qryPafPrincipal.SQL.Add('  PAF_CODEMP = :CODEMP AND ');
    qryPafPrincipal.SQL.Add('  PAF_EXPORT = 0 ');

    qryPafPrincipal.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryPafPrincipal.Open;

    Result := (qryPafPrincipal.FieldByName('QTD').AsInteger > 0);
  Finally
    FreeAndNil(qryPafPrincipal);
  End;
end;

function TfrmRcxResumoCaixa.fTemNFCePendente: Boolean;
  Var
    qryNFCe: TUniQuery;
begin
  qryNFCe := fCriaQuery(Nil);
  pCarregaNFCePendente(qryNFCe);
  Result := Not qryNFCe.IsEmpty;
  FreeAndNil(qryNFCe);
end;

function TfrmRcxResumoCaixa.fTemPendenciaChequesPDV: Boolean;
  Var
    qryCheque: TUniQuery;
begin
  qryCheque := fCriaQuery(Nil);
  qryCheque.SQL.Add('SELECT COUNT(*) AS QTD FROM PAF_CHEQUES WHERE CHQ_DUPLIC = 1 AND CHQ_CODEMP = :CODEMP ');
  qryCheque.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryCheque.Open;

  Result := (qryCheque.FieldByName('QTD').AsInteger > 0);

  FreeAndNil(qryCheque);
end;

function TfrmRcxResumoCaixa.fUsaRotinaBoletoAdiantamento: Boolean;
begin
  Result := False;

  If fCfgSis('BOLADT', VarBoolean) Then
    Exit(True);

  If TAdiantamentoGenerico.fPedidoTemBoletoAdiantamento(
      cdsTmpResumoCaixa.FieldByName('CTR_NUMDUP').AsString,
      cdsTmpResumoCaixa.FieldByName('CTR_ESPDOC').AsString,
      cdsTmpResumoCaixa.FieldByName('CTR_CODEMP').AsString) Then
    Exit(True);

end;

procedure TfrmRcxResumoCaixa.pZeraVariaveisResumo;
begin
  {*******************************************}
  {* SEMPRE QUE ESCOLHER UMA ESPÉCIE, ZERO   *}
  {* AS VARIÁVEIS DO RESUMO DE CAIXA         *}
  {****************************************MV*}
  log('Zerou variaveis do resumo');

  fltValDoc   := 0.0;
  fltValJur   := 0.0;
  fltDesRec   := 0.0;
  fltTotCre   := 0.0;
  fltTotLiq   := 0.0;
  fltDifCre   := 0.0;
  intQtdSel   := 0;

  blnEdiCam   := True;
  blnQuitacao := True;
  blnEdiCam   := True;

  strFpgSelPD := '';
  strCodCarSelPD := '';
  intQtdPaCSelPD := 0;

  strEspDoc   := '';
  strCliCco   := '';
  strCodFor   := '';
  strCta_Pg   := '';
  strJus_Pg   := '';

  strCodClienteCredSel := '';

  edtValDoc.Text := '0,00';
  edtNumDoc.Clear;
  edtDescri.Clear;

  If cdsTmpResumoCaixa.Active Then
    cdsTmpResumoCaixa.EmptyDataSet;

  edtCodCli.Enabled  := True;
  mskDtaIni.Enabled  := True;
  mskDtaFin.Enabled  := True;
  If (pgcDadosGerais.ActivePage = tbsLancamentos) Then
    edtValDoc.Enabled  := True;

  edtValJur.ReadOnly := True;
  edtValJur.TabStop  := False;
  edtValDes.ReadOnly := True;
  edtValDes.TabStop  := False;

  edtCarRec.ReadOnly := False;
  edtCarRec.TabStop  := True;

  edtChqRec.ReadOnly := False;
  edtChqRec.TabStop  := True;

  edtChqPre.ReadOnly := False;
  edtChqPre.TabStop  := True;

  edtOrdRec.ReadOnly := False;
  edtOrdRec.TabStop  := True;

  edtFinanc.ReadOnly := False;
  edtFinanc.TabStop  := True;

  If strTipoFechamentoCaixa <> 'C' Then
    edtSqFcRx.Text := fStrZero(VarToStr(fCfgSisL('SQFCRX')), 3);

  objLock.pDestravarTodos;
  pCancelarTefDeCartoesJaConfirmados;

  SetLength(arrCartoes, 0);

  lblCredito.Visible := False;

  blnLibDin := False;
  blnLibCar := False;
  blnLibChv := False;
  blnLibChp := False;
  blnLibOrd := False;
end;

function TfrmRcxResumoCaixa.RetornaPortadorCredito: String;
  Var
    LPixDao: TPixDao;
begin
  Result := '';

  If fCfgSis('PRCXCC', varBoolean) Then
    Result := fCfgSis('PORRES');

  If Not PagamentoEmUmaModalidade Then
    Exit;

  If fStrToFloat(edtDinRec.Text) > 0 Then
  Begin
    Result := fCfgSis('PORRCX');
  End
  Else If Assigned(FObjetoPixRecebimento) Then
  Begin
    If TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(FObjetoPixRecebimento) Then
    Begin
      LPixDao := TPixDao.Create;
      Try
        Result := LPixDao.RetornaPortadorChavePix(FObjetoPixRecebimento.AutoIncremChavePix);
      Finally
        FreeAndNil(LPixDao);
      End;
    End;
  End;
end;

procedure TfrmRcxResumoCaixa.lsvLancamentosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_Return) Then
  Begin
    Key := 0;

    chkSaldoInicial.Visible := False;

    If (Not fValidaCampos(Self, True)) Then
      Exit;

    If (lsvLancamentos.Selected = Nil) Then
      lsvLancamentos.ItemIndex := 0;

    If fEmptyStr(fCfgSis('SELCRC')) Then
    Begin
      If Not fDireitoAcessoLancamentos(lsvLancamentos.Selected.Caption,
                                       'Resumo de Caixa - [ F1 ] Lançamentos (' +
                                       lsvLancamentos.Selected.Caption + ' - ' +
                                       lsvLancamentos.Selected.SubItems.Strings[0] + ')') Then
      Begin
        fMensagem('ATENÇÃO!', 'Você não tem direitos para usar essa espécie!', ['&Ok']);
        Exit;
      End;
    End;

    If lsvLancamentos.Selected.Caption = 'TF' Then
    Begin
      If Not fDireitoAcessoLancamentos(lsvLancamentos.Selected.Caption,
                                       'Resumo de Caixa - [ F1 ] Lançamentos (' +
                                       lsvLancamentos.Selected.Caption + ' - ' +
                                       lsvLancamentos.Selected.SubItems.Strings[0] + ')') Then
      Begin
        fMensagem('ATENÇÃO!', 'Você não tem direitos para usar essa espécie!', ['&Ok']);
        Exit;
      End;
    End;

    strEspDoc      := lsvLancamentos.Selected.Caption;
    edtDesOpc.Text := lsvLancamentos.Selected.SubItems.Strings[0];

    edtValJur.ReadOnly := True;
    edtValJur.TabStop  := False;
    edtValDes.ReadOnly := True;
    edtValDes.TabStop  := False;

    edtNumDoc.Enabled := True;
    If (strEspDoc = 'CC') Then
    Begin
      edtNumDoc.Enabled := False;
      edtDescri.MaxLength := 100;
      pChamaClienteCredito;
    End
    Else If (strEspDoc = 'LD') Then
    Begin

      If objResumoDeCaixa.TransferenciaVinculada Then
      Begin
        edtCarRec.ReadOnly := True;
        edtCarRec.TabStop  := False;

        edtChqRec.ReadOnly := True;
        edtChqRec.TabStop  := False;

        edtChqPre.ReadOnly := True;
        edtChqPre.TabStop  := False;

        edtOrdRec.ReadOnly := True;
        edtOrdRec.TabStop  := False;

        edtFinanc.ReadOnly := True;
        edtFinanc.TabStop  := False;
      End;

      edtDescri.MaxLength := 100;
      lsvLancamentos.Enabled := False;
      pSetFocus(edtNumDoc);
    End
    Else If (strEspDoc = 'PG') Then
    Begin
      edtValJur.ReadOnly := True;
      edtValJur.TabStop  := False;
      edtValDes.ReadOnly := True;
      edtValDes.TabStop  := False;

      edtDescri.MaxLength := 100;

      edtCarRec.ReadOnly := True;
      edtCarRec.TabStop  := False;

      edtOrdRec.ReadOnly := True;
      edtOrdRec.TabStop  := False;

      If objResumoDeCaixa.TransferenciaVinculada Then
      Begin

        edtChqRec.ReadOnly := True;
        edtChqRec.TabStop  := False;

        edtChqPre.ReadOnly := True;
        edtChqPre.TabStop  := False;
      End;

      //FECHAMENTO FINANCEIRO
      if objFechamento.FechamentoFinanceiroJaRealizado(VS_strCodEmp, dtaDtaCai) then
        Exit;

      fDigDadosPagamentos;
    End
    Else If (strEspDoc = 'LC') Then
    Begin
      If Length(arrCartoes) > 0 Then
        arrCartoes := Nil;

      If objResumoDeCaixa.TransferenciaVinculada Then
      Begin
        edtCarRec.Text := '0,00';
        edtCarRec.ReadOnly := True;
        edtCarRec.TabStop  := False;

        edtChqRec.Text := '0,00';
        edtChqRec.ReadOnly := True;
        edtChqRec.TabStop  := False;

        edtChqPre.Text := '0,00';
        edtChqPre.ReadOnly := True;
        edtChqPre.TabStop  := False;

        edtOrdRec.Text := '0,00';
        edtOrdRec.ReadOnly := True;
        edtOrdRec.TabStop  := False;

        edtFinanc.Text := '0,00';
        edtFinanc.ReadOnly := True;
        edtFinanc.TabStop  := False;
      End;

      edtDescri.MaxLength := 100;

      chkSaldoInicial.Checked := False;
      chkSaldoInicial.Visible := True;
      lsvLancamentos.Enabled := False;
      pSetFocus(edtNumDoc);
    End
    Else If (strEspDoc = 'TF') Then
    Begin
      Try
        If Not objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDoFechamento(edtCodigoCaixa.Text), True, False) Then
        Begin
          pMensagemOk('Não será possível efetuar a transferência agora pois outra estação está realizando o fechamento do caixa!');
          Exit;
        End
        Else
          objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDoFechamento(edtCodigoCaixa.Text), False);

        If Not objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDoContasAPagar(edtCodigoCaixa.Text), True, False) Then
        Begin
          pMensagemOk('Não será possível efetuar a transferência agora pois outra estação está realizando baixa de contas a pagar!');
          Exit;
        End
        Else
          objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDoContasAPagar(edtCodigoCaixa.Text), False);

        If objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDaTransferencia(edtCodigoCaixa.Text),
                                True,
                                False,
                                False,
                                '',
                                False) Then
        Begin
          TfrmGravando.fExecutarModal(pExecutaTransferencia, 'Executando a transferência...', '');
          btnGravar.Enabled := True;
          objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDaTransferencia(edtCodigoCaixa.Text), False);
          strEspDoc      := '';
          edtDesOpc.Text := '';
        End
        Else
        Begin
          fMensagem('', 'A tela de transferências está sendo utilizada em outro terminal!', ['&Ok']);
          Exit;
        End;
      Except
        On E: Exception Do
        Begin
          objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDaTransferencia(edtCodigoCaixa.Text), False);
          pMensagensErro(E.Message, '[lsvLancamentosKeyDown (TF)]');
        End;
      End;
    End
    Else
    Begin
      lsvLancamentos.Enabled := False;
      pSetFocus(edtNumDoc);
    End;

    If strEspDoc <> 'CC' Then
      pHabilitaClienteCC(False);
  End;

  inherited;

end;

procedure TfrmRcxResumoCaixa.pFocarElemento;
begin
  pnlDocumento.Enabled := True;

  If (pgcDadosGerais.ActivePage = tbsLancamentos) Then
  Begin
    If (lsvLancamentos.Enabled) Then
      pSetFocus(lsvLancamentos);
  End
  Else If (pgcDadosGerais.ActivePage = tbsRecebimentos) Then
  Begin
    pSetFocus(edtCodCli);
  End;
end;

procedure TfrmRcxResumoCaixa.lsvLancamentosEnter(Sender: TObject);
begin
  inherited;
  edtDesOpc.Clear;
  chkSaldoInicial.Checked := False;
  chkSaldoInicial.Visible := False;
end;

procedure TfrmRcxResumoCaixa.btnHisDebClick(Sender: TObject);
  Var
    documento: IDocumento;
Begin
  inherited;
  log('Apertou F6');

  documento := TDocumento.Create;

  TfrmMostraDebCtrChq2.pMostraContaCorrente('','',TRUE,{veio pelo resumo de caixa}
                                            False,False,'',documento);


end;

function TfrmRcxResumoCaixa.fChequePre(strValor: String; blnPagarVencido: Boolean): Boolean;
  Var
    fltValTot: Double;
    bkmPosicao: TBookmark;
Begin

  Result := True;

  If (Not blnChamaCadastro) Then
    Exit;

  If Not Assigned(cdsChqPre) Then cdsChqPre := fCriaCdsCheques(Self);

  With cdsChqPre Do
  Begin
    First;

    fltValTot := fStrToFloat(strValor);

    If cdsChqPre.RecordCount > 0 Then
    Begin
      Try
        pCriarFormularios(TfrmRcxMostraCheques,frmRcxMostraCheques);
        frmRcxMostraCheques.dsCheques.DataSet := cdsChqPre;
        frmRcxMostraCheques.ShowModal;

        // ***** Verifica prazo medio para recebimento de cheque pré. ***** //
        Result := fVerificaPrazoRecebimentoChequePre( cdsChqPre );
        If Not Result Then
           cdsChqPre.EmptyDataSet;

        fltValChq := frmRcxMostraCheques.fltValTot;

      Except
        On E: Exception Do
        Begin
          fltValChq := 0.0;
          pMensagensErro(E.Message, '[fChequePre]');
        End;
      End;

      pFreeAndNil(frmRcxMostraCheques);

      edtChqPre.Text := FormatFloat('#,##0.00',fltValChq);

      If fFormataFloat(fltValChq, 2) <> fFormataFloat(fltValTot, 2) Then
      Begin
        Try
          pCriarFormularios(TfrmCadCheques,frmCadCheques);
          frmCadCheques.blnTroChq  := blnTroChq;
          frmCadCheques.strCodOpe  := edtCodOpe.Text;
          frmCadCheques.blnResumida := True;
          frmCadCheques.blnResCai  := True;
          frmCadCheques.blnGravacaoFisica := False;
          frmCadCheques.fltValTot  := fltValTot;
          frmCadCheques.cdsChqRcx  := cdsChqPre;
          frmCadCheques.blnPrazo   := True;

          frmCadCheques.cdsChqOutroTip.Data := cdsChqVis.Data;

          frmCadCheques.RotinaChamada := 'RESUMO DE CAIXA';

          frmCadCheques.blnJaIncluiu      := True;
          frmCadCheques.edtTotDig.Text := FormatFloat('#,##0.00',fltValChq);
          frmCadCheques.edtTotGer.Text := FormatFloat('#,##0.00',fltValTot);

          If (pgcDadosGerais.ActivePage = tbsRecebimentos) Then
          Begin
          bkmPosicao := cdsTmpResumoCaixa.GetBookmark;
          cdsTmpResumoCaixa.First;

          {***************************************}
          {* ALTERADO PARA TRAZER CLIENTE APENAS *}
          {* SE AS DUPLICATAS FOREM DO MESMO     *}
          {************************************AJ*}
          While (Not cdsTmpResumoCaixa.Eof) Do
          Begin
            If (cdsTmpResumoCaixa.FieldByName('CTR_MARDES').AsString = 'M') Then
            Begin
              If fEmptyStr(frmCadCheques.strCliente) Then
                frmCadCheques.strCliente := cdsTmpResumoCaixa.FieldByName('CTR_CODCLI').AsString
              Else
              Begin
                If frmCadCheques.strCliente <> cdsTmpResumoCaixa.FieldByName('CTR_CODCLI').AsString Then
                Begin
                  frmCadCheques.strCliente := '';
                  Break;
                End;
              End;
            End;
            cdsTmpResumoCaixa.Next;
          End;

            cdsTmpResumoCaixa.First;
            While (Not cdsTmpResumoCaixa.Eof) Do
            Begin
              If (cdsTmpResumoCaixa.FieldByName('CTR_MARDES').AsString = 'M') Then
              Begin
                If fEmptyStr(frmCadCheques.strDocume) Then
                  frmCadCheques.strDocume := cdsTmpResumoCaixa.FieldByName('CTR_NUMDUP').AsString +
                                             cdsTmpResumoCaixa.FieldByName('CTR_PARCEL').AsString +
                                             cdsTmpResumoCaixa.FieldByName('CTR_ESPDOC').AsString +
                                             cdsTmpResumoCaixa.FieldByName('CTR_CODEMP').AsString +
                                             'PRZ'
                Else
                  frmCadCheques.strDocume := 'DIVERSOS-PRZ';

                frmCadCheques.pAddCtrBaixando(cdsTmpResumoCaixa.FieldByName('CTR_NUMDUP').AsString,
                                              cdsTmpResumoCaixa.FieldByName('CTR_ESPDOC').AsString,
                                              cdsTmpResumoCaixa.FieldByName('CTR_CODEMP').AsString,
                                              cdsTmpResumoCaixa.FieldByName('CTR_CODCLI').AsString,
                                              cdsTmpResumoCaixa.FieldByName('CTR_PARCEL').AsString);
              End;
              cdsTmpResumoCaixa.Next;
            End;

            If (bkmPosicao <> Nil) Then
              cdsTmpResumoCaixa.GotoBookmark(bkmPosicao);

          End
          Else
            frmCadCheques.strCliente := strCliCco;

          {**************************************************}
          {* SE fCfgSis('CHQRCX', varBoolean)               *}
          {* ENTAO EXECUTAÇÃO DIGITAÇÃO DO CHEQUE           *}
          {***********************************************AC*}
          If (fCfgSis('CHQRCX', varBoolean)) Then
          Begin
            frmCadCheques.ShowModal;

            cdsChqPre.Data := frmCadCheques.cdsTabela.Data;

            If IsEmpty Or (Not frmCadCheques.blnConfima) Then
            Begin
              Result := False;
            End;

            if Result then
            Begin
               // ***** Verifica prazo medio para recebimento de cheque pré. ***** //
               Result := fVerificaPrazoRecebimentoChequePre( cdsChqPre );
               if Not Result then
                  cdsChqPre.EmptyDataSet;
            End;

          End;

        Except
          On E: Exception Do
          Begin
            Result := False;
            pMensagensErro(E.Message, '[fChequePre_1]');
          End;
        End;

        pFreeAndNil(frmCadCheques);
        edtChqPre.Text := FormatFloat('#,##0.00',fltValTot);

      End;

    End
    Else
    Begin

      Try
        pCriarFormularios(TfrmCadCheques,frmCadCheques);
        frmCadCheques.blnTroChq  := blnTroChq;
        frmCadCheques.strCodOpe  := edtCodOpe.Text;
        frmCadCheques.blnResCai  := True;
        frmCadCheques.blnResumida := True;
        frmCadCheques.blnGravacaoFisica := False;
        frmCadCheques.fltValTot  := fltValTot;
        frmCadCheques.blnPrazo   := True;
        frmCadCheques.cdsChqRcx  := cdsChqPre;

        frmCadCheques.cdsChqOutroTip.Data := cdsChqVis.Data;

        frmCadCheques.RotinaChamada := 'RESUMO DE CAIXA';

        If (pgcDadosGerais.ActivePage = tbsRecebimentos) Then
        Begin
            bkmPosicao := cdsTmpResumoCaixa.GetBookmark;
            cdsTmpResumoCaixa.First;

            {***************************************}
            {* ALTERADO PARA TRAZER CLIENTE APENAS *}
            {* SE AS DUPLICATAS FOREM DO MESMO     *}
            {************************************AJ*}
            While (Not cdsTmpResumoCaixa.Eof) Do
            Begin
              If (cdsTmpResumoCaixa.FieldByName('CTR_MARDES').AsString = 'M') Then
              Begin
                If fEmptyStr(frmCadCheques.strCliente) Then
                  frmCadCheques.strCliente := cdsTmpResumoCaixa.FieldByName('CTR_CODCLI').AsString
                Else
                Begin
                  If frmCadCheques.strCliente <> cdsTmpResumoCaixa.FieldByName('CTR_CODCLI').AsString Then
                  Begin
                    frmCadCheques.strCliente := '';
                    Break;
                  End;
                End;
              End;
              cdsTmpResumoCaixa.Next;
            End;

          cdsTmpResumoCaixa.First;
          While (Not cdsTmpResumoCaixa.Eof) Do
          Begin
            If (cdsTmpResumoCaixa.FieldByName('CTR_MARDES').AsString = 'M') Then
            Begin
              If fEmptyStr(frmCadCheques.strDocume) Then
                frmCadCheques.strDocume := cdsTmpResumoCaixa.FieldByName('CTR_NUMDUP').AsString +
                                           cdsTmpResumoCaixa.FieldByName('CTR_PARCEL').AsString +
                                           cdsTmpResumoCaixa.FieldByName('CTR_ESPDOC').AsString +
                                           cdsTmpResumoCaixa.FieldByName('CTR_CODEMP').AsString +
                                           'PRZ'
              Else
                frmCadCheques.strDocume := 'DIVERSOS-PRZ';

              frmCadCheques.pAddCtrBaixando(cdsTmpResumoCaixa.FieldByName('CTR_NUMDUP').AsString,
                                            cdsTmpResumoCaixa.FieldByName('CTR_ESPDOC').AsString,
                                            cdsTmpResumoCaixa.FieldByName('CTR_CODEMP').AsString,
                                            cdsTmpResumoCaixa.FieldByName('CTR_CODCLI').AsString,
                                            cdsTmpResumoCaixa.FieldByName('CTR_PARCEL').AsString);
            End;
            cdsTmpResumoCaixa.Next;
          End;

          If (bkmPosicao <> Nil) Then
            cdsTmpResumoCaixa.GotoBookmark(bkmPosicao);

        End
        Else
          frmCadCheques.strCliente := strCliCco;

        {**************************************************}
        {* SE fCfgSis('CHQRCX', varBoolean)               *}
        {* ENTAO EXECUTAÇÃO DIGITAÇÃO DO CHEQUE           *}
        {***********************************************AC*}
        If (fCfgSis('CHQRCX', varBoolean)) Then
        Begin
          frmCadCheques.ShowModal;

          cdsChqPre.Data := frmCadCheques.cdsTabela.Data;          

          If IsEmpty Or (Not frmCadCheques.blnConfima) Then
          Begin
            Result := False;
          End;

          if Result then
          Begin
             // ***** Verifica prazo medio para recebimento de cheque pré. ***** //
             Result := fVerificaPrazoRecebimentoChequePre( cdsChqPre );
             if Not Result then
                cdsChqPre.EmptyDataSet;
          End;

        End;

      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, '[fChequePre_2]');
        End;
      End;

      pFreeAndNil(frmCadCheques);
    End;

  End;


End;

function TfrmRcxResumoCaixa.fChequeVis(strValor: String): Boolean;
  Var
    fltValTot: Double;
    bkmPosicao: TBookmark;
Begin
  Result := True;

  If (Not blnChamaCadastro) Then
    Exit;

  If Not Assigned(cdsChqVis) Then cdsChqVis := fCriaCdsCheques(Self);

  With cdsChqVis Do
  Begin
    First;

    fltValTot := fStrToFloat(strValor);

    If cdsChqVis.RecordCount > 0 Then
    Begin
      Try
        pCriarFormularios(TfrmRcxMostraCheques,frmRcxMostraCheques);
        frmRcxMostraCheques.dsCheques.DataSet := cdsChqVis;
        frmRcxMostraCheques.ShowModal;

        fltValChq := frmRcxMostraCheques.fltValTot;

      Except
        On E: Exception Do
        Begin
          fltValChq := 0.0;
          pMensagensErro(E.Message, '[fChequeVis]');
        End;
      End;

      pFreeAndNil(frmRcxMostraCheques);

      edtChqRec.Text := FormatFloat('#,##0.00',fltValChq);

      If fFormataFloat(fltValChq, 2) <> fFormataFloat(fltValTot, 2) Then
      Begin

        Try
          pCriarFormularios(TfrmCadCheques,frmCadCheques);
          frmCadCheques.blnTroChq         := blnTroChq;
          frmCadCheques.strCodOpe         := edtCodOpe.Text;
          frmCadCheques.blnResumida       := True;
          frmCadCheques.blnResCai         := True;
          frmCadCheques.blnGravacaoFisica := False;
          frmCadCheques.fltValTot  := fltValTot;
          frmCadCheques.blnPrazo          := False;
          frmCadCheques.cdsChqRcx         := cdsChqVis;
          frmCadCheques.dbeDtaCad.Enabled := False;
          frmCadCheques.dbeDtaCad.TabStop := False;
          frmCadCheques.dbeDtaVen.Enabled := False;
          frmCadCheques.dbeDtaVen.TabStop := False;

          frmCadCheques.cdsChqOutroTip.Data := cdsChqPre.Data;

          frmCadCheques.RotinaChamada := 'RESUMO DE CAIXA';

          frmCadCheques.blnJaIncluiu      := True;
          frmCadCheques.edtTotDig.Text := FormatFloat('#,##0.00',fltValChq);
          frmCadCheques.edtTotGer.Text := FormatFloat('#,##0.00',fltValTot);

          If (pgcDadosGerais.ActivePage = tbsRecebimentos) Then
          Begin
          bkmPosicao := cdsTmpResumoCaixa.GetBookmark;
          cdsTmpResumoCaixa.First;

          {***************************************}
          {* ALTERADO PARA TRAZER CLIENTE APENAS *}
          {* SE AS DUPLICATAS FOREM DO MESMO     *}
          {************************************AJ*}
          While (Not cdsTmpResumoCaixa.Eof) Do
          Begin
            If (cdsTmpResumoCaixa.FieldByName('CTR_MARDES').AsString = 'M') Then
            Begin
              If fEmptyStr(frmCadCheques.strCliente) Then
                frmCadCheques.strCliente := cdsTmpResumoCaixa.FieldByName('CTR_CODCLI').AsString
              Else
              Begin
                If frmCadCheques.strCliente <> cdsTmpResumoCaixa.FieldByName('CTR_CODCLI').AsString Then
                Begin
                  frmCadCheques.strCliente := '';
                  Break;
                End;
              End;
            End;
            cdsTmpResumoCaixa.Next;
          End;

            cdsTmpResumoCaixa.First;
            While (Not cdsTmpResumoCaixa.Eof) Do
            Begin
              If (cdsTmpResumoCaixa.FieldByName('CTR_MARDES').AsString = 'M') Then
              Begin
                If fEmptyStr(frmCadCheques.strDocume) Then
                  frmCadCheques.strDocume := cdsTmpResumoCaixa.FieldByName('CTR_NUMDUP').AsString +
                                             cdsTmpResumoCaixa.FieldByName('CTR_PARCEL').AsString +
                                             cdsTmpResumoCaixa.FieldByName('CTR_ESPDOC').AsString +
                                             cdsTmpResumoCaixa.FieldByName('CTR_CODEMP').AsString +
                                             'AVI'
                Else
                  frmCadCheques.strDocume := 'DIVERSOS-AVI';

                frmCadCheques.pAddCtrBaixando(cdsTmpResumoCaixa.FieldByName('CTR_NUMDUP').AsString,
                                              cdsTmpResumoCaixa.FieldByName('CTR_ESPDOC').AsString,
                                              cdsTmpResumoCaixa.FieldByName('CTR_CODEMP').AsString,
                                              cdsTmpResumoCaixa.FieldByName('CTR_CODCLI').AsString,
                                              cdsTmpResumoCaixa.FieldByName('CTR_PARCEL').AsString);
              End;
              cdsTmpResumoCaixa.Next;
            End;

            If (bkmPosicao <> Nil) Then
              cdsTmpResumoCaixa.GotoBookmark(bkmPosicao);

          End
          Else
            frmCadCheques.strCliente := strCliCco;

          {**************************************************}
          {* SE fCfgSis('CHQRCX', varBoolean)               *}
          {* ENTAO EXECUTAÇÃO DIGITAÇÃO DO CHEQUE           *}
          {***********************************************AC*}
          If (fCfgSis('CHQRCX', varBoolean)) Then
          Begin
            frmCadCheques.ShowModal;

            cdsChqVis.Data := frmCadCheques.cdsTabela.Data;            

            If IsEmpty Or (Not frmCadCheques.blnConfima) Then
            Begin
              Result := False;
            End;

          End;

        Except
          On E: Exception Do
          Begin
            Result := False;
            pMensagensErro(E.Message, '[fChequeVis_1]');
          End;
        End;

        pFreeAndNil(frmCadCheques);
        edtChqRec.Text := FormatFloat('#,##0.00',fltValTot);

      End;
    End
    Else
    Begin

      Try
        pCriarFormularios(TfrmCadCheques,frmCadCheques);
        frmCadCheques.blnTroChq         := blnTroChq;
        frmCadCheques.strCodOpe         := edtCodOpe.Text;
        frmCadCheques.blnResumida       := True;
        frmCadCheques.blnResCai         := True;
        frmCadCheques.blnGravacaoFisica := False;
        frmCadCheques.fltValTot         := fltValTot;
        frmCadCheques.blnPrazo          := False;
        frmCadCheques.cdsChqRcx         := cdsChqVis;
        frmCadCheques.dbeDtaCad.Enabled := False;
        frmCadCheques.dbeDtaCad.TabStop := False;
        frmCadCheques.dbeDtaVen.Enabled := False;
        frmCadCheques.dbeDtaVen.TabStop := False;

        frmCadCheques.cdsChqOutroTip.Data := cdsChqPre.Data;

        frmCadCheques.RotinaChamada := 'RESUMO DE CAIXA';

        If (pgcDadosGerais.ActivePage = tbsRecebimentos) Then
        Begin
            bkmPosicao := cdsTmpResumoCaixa.GetBookmark;
            cdsTmpResumoCaixa.First;

            {***************************************}
            {* ALTERADO PARA TRAZER CLIENTE APENAS *}
            {* SE AS DUPLICATAS FOREM DO MESMO     *}
            {************************************AJ*}
            While (Not cdsTmpResumoCaixa.Eof) Do
            Begin
              If (cdsTmpResumoCaixa.FieldByName('CTR_MARDES').AsString = 'M') Then
              Begin
                If fEmptyStr(frmCadCheques.strCliente) Then
                  frmCadCheques.strCliente := cdsTmpResumoCaixa.FieldByName('CTR_CODCLI').AsString
                Else
                Begin
                  If frmCadCheques.strCliente <> cdsTmpResumoCaixa.FieldByName('CTR_CODCLI').AsString Then
                  Begin
                    frmCadCheques.strCliente := '';
                    Break;
                  End;
                End;
              End;
              cdsTmpResumoCaixa.Next;
            End;

          cdsTmpResumoCaixa.First;
          While (Not cdsTmpResumoCaixa.Eof) Do
          Begin
            If (cdsTmpResumoCaixa.FieldByName('CTR_MARDES').AsString = 'M') Then
            Begin
              If fEmptyStr(frmCadCheques.strDocume) Then
                frmCadCheques.strDocume := cdsTmpResumoCaixa.FieldByName('CTR_NUMDUP').AsString +
                                           cdsTmpResumoCaixa.FieldByName('CTR_PARCEL').AsString +
                                           cdsTmpResumoCaixa.FieldByName('CTR_ESPDOC').AsString +
                                           cdsTmpResumoCaixa.FieldByName('CTR_CODEMP').AsString +
                                           'AVI'
              Else
                frmCadCheques.strDocume := 'DIVERSOS-AVI';

              frmCadCheques.pAddCtrBaixando(cdsTmpResumoCaixa.FieldByName('CTR_NUMDUP').AsString,
                                            cdsTmpResumoCaixa.FieldByName('CTR_ESPDOC').AsString,
                                            cdsTmpResumoCaixa.FieldByName('CTR_CODEMP').AsString,
                                            cdsTmpResumoCaixa.FieldByName('CTR_CODCLI').AsString,
                                            cdsTmpResumoCaixa.FieldByName('CTR_PARCEL').AsString);
            End;
            cdsTmpResumoCaixa.Next;
          End;

          If (bkmPosicao <> Nil) Then
            cdsTmpResumoCaixa.GotoBookmark(bkmPosicao);

        End
        Else
          frmCadCheques.strCliente := strCliCco;

        {**************************************************}
        {* SE fCfgSis('CHQRCX', varBoolean)               *}
        {* ENTAO EXECUTAÇÃO DIGITAÇÃO DO CHEQUE           *}
        {***********************************************AC*}
        If (fCfgSis('CHQRCX', varBoolean)) Then
        Begin
          frmCadCheques.ShowModal;

          cdsChqVis.Data := frmCadCheques.cdsTabela.Data;          

          If IsEmpty Or (Not frmCadCheques.blnConfima) Then
          Begin
            Result := False;
          End;

        End;

      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, '[fChequeVis_2]');
        End;
      End;

      pFreeAndNil(frmCadCheques);
    End;

  End;

End;

procedure TfrmRcxResumoCaixa.btnReceberPixClick(Sender: TObject);
begin
  inherited;

  If fMensagem('ATENÇÃO', 'Deseja realizar o recebimento do valor ' + FormatFloat(',0.00', fStrToFloat(edtOrdRec.Text)) +
                          ' através do QR Code Pix?', ['&Sim', '&Não'], 1) = 2 Then
  Begin
    pSetFocus(edtOrdRec);
    SelectNext(ActiveControl, True, True);
    Exit;
  End;

  If dtaDtaCai <> VS_Date Then
  Begin
    fMensagem('ATENÇÃO', 'Não é possível receber por Pix com o caixa do dia anterior em aberto.', ['&Ok']);
    pSetFocus(edtOrdRec);
    Exit;
  End;

  If MatchStr(strEspDoc, ['CC', 'LC']) Then
  Begin
    If CalculaValorRestante < 0.00 Then
    Begin
      fMensagem('ATENÇÃO', 'Não é permitido realizar o recebimento de um valor maior ao valor do documento para esse tipo de lançamento.', ['&Ok']);
      pSetFocus(edtOrdRec);
      Exit;
    End;
  End;

  Try
    AbreTelaParaPagamentoDoPix;
  Except
    On E: ExceptionAutcom Do
    Begin
      fMensagem('ERRO', E.Message, ['&Ok']);
      Exit;
    End;
  End;
end;

procedure TfrmRcxResumoCaixa.btnRelAltFormaPagClick(Sender: TObject);
begin
  inherited;
  log('Apertou Alt+H');

  If Not btnRelAltFormaPag.Visible Then
    Exit;

  If Not fVerificaAcessoSistema('DIRRelAltFormaPag', edtCodOpe.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'Você não tem direito de usar esse recurso!', ['&Ok']);
    Exit;
  End;

  If fMensagem('','Escolha a Opção:',['&Grid','&Impressora'])= 1 Then
  Begin

    If Assigned(prcExecutaRelatorio) Then
    begin
      prcExecutaRelatorio(184, 7454, [],
                          [],
                          [],
                          Sender,
                          nil,
                          False);
    End;

  End
  Else
  Begin

    If Assigned(prcExecutaRelatorio) Then
    begin
      prcExecutaRelatorio(183, 7452, [],
                          [],
                          [],
                          Sender,
                          nil,
                          False);
    End;

  End;

end;

procedure TfrmRcxResumoCaixa.btnRelatorioClick(Sender: TObject);
  Var
    frmRelRcxResumoCaixa: TfrmRelRcxResumoCaixa;
begin
  If EstaRealizandoRecebimentoF1F2 Then
    Exit;

  inherited;
  log('Apertou F10');

  if not fCfgSis('RCXEDI', varBoolean) then
  begin
    If fVerificaAcessoSistema('RELRCX', edtCodOpe.Text) Then
    Begin
      pCriarFormularios(TfrmRelRcxResumoCaixa, frmRelRcxResumoCaixa);
      If Not fEmptyStr(edtCodigoCaixa.Text) Then
        frmRelRcxResumoCaixa.edtCodigoCaixa.Text := edtCodigoCaixa.Text;
      frmRelRcxResumoCaixa.ShowModal;
      FreeAndNil(frmRelRcxResumoCaixa);
    End
    Else
    Begin
      fMensagem('', 'Você não tem direitos para acessar este relatório!', ['&Ok']);
    End;
  end
  else
    if Assigned(prcExecutaRelatorio) then
      prcExecutaRelatorio(230, 10311, [10311,10331], [], [], Sender, Nil, False, True, 'RELRCX');

end;

function TfrmRcxResumoCaixa.GetTotalRecebidoBruto: Double;
begin
  Result := 0;
  Result := Result + fStrToFloat(edtDinRec.Text);
  Result := Result + fStrToFloat(edtCarRec.Text);
  Result := Result + fStrToFloat(edtOrdRec.Text);
  Result := Result + fStrToFloat(edtChqRec.Text);
  Result := Result + fStrToFloat(edtChqPre.Text);
  Result := Result + fStrToFloat(edtFinanc.Text);
  Result := Result + fStrToFloat(edtTroco.Text);
end;

function TfrmRcxResumoCaixa.LancamentoDeTransferenciaSemMovBan(ASequecial: Integer): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  If Not MatchStr(strEspDoc.Trim, [EmptyStr, 'TF']) Then
    Exit(False);

  LConsulta := fCriaQuery;
  Try
    LConsulta.SQL.Text := 'SELECT CTB_SEQLAN ' +
                          'FROM MOVBAN ' +
                          'WHERE CTB_DTALAN=:DTALAN ' +
                          '  AND CTB_CODEMP=:CODEMP ' +
                          '  AND CTB_SEQTRF=:SEQTRF ';

    LConsulta.ParamByName('DTALAN').AsDateTime := VS_Date;
    LConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LConsulta.ParamByName('SEQTRF').AsInteger := ASequecial;

    LConsulta.Open;

    Result := LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

{****************************************}
{* IMPRIME RECIBO DE ACORDO COM A OPCAO *}
{* SE OPCAO = 1 ENTAO CC,PG,LD,LC       *}
{*************************************AF*}
procedure TfrmRcxResumoCaixa.pImprimeRecibo(intOpcao: Integer);
  Var
    strSQL      : String;
    strNomPro   : String;
    strNomFil   : String;
    strTipImp   : String;
    strRecRcx   : String;
    strNomCli   : String;
    arrCodCli   : Array Of TRcxDadosCliente;
    intContador : Integer;
    intContador2: Integer;
    blnAchou    : Boolean;
    blnImprimiu : Boolean;
    qryAuxImp   : TUniQuery;
    recValRec   : TRcxValoresReceb;
Begin
  Try
    If intOpcao = 1 Then
      strRecRcx := 'L'
    Else
      strRecRcx := fCfgSis('RECRCX');

    If Not cdsImpRec.Active Then
      cdsImpRec.Open;

    cdsImpRec.EmptyDataSet;
    cdsImpRec.Filter   := '';
    cdsImpRec.Filtered := FALSE;

    If intOpcao = 1 Then
    Begin

      qryAuxImp := fCriaQuery(Nil);

      With cdsImpRec Do
      Begin
        Insert;

        If strEspDoc = 'PG' Then
        Begin
          strSQL := '';
          strSQL := strSQL + ' SELECT SQL_NO_CACHE           ';
          strSQL := strSQL + '   FOR_ENDERE,                 ';
          strSQL := strSQL + '   FOR_ENDNUM,                 ';
          strSQL := strSQL + '   FOR_ENDCOM,                 ';
          strSQL := strSQL + '   FOR_BAIRRO,                 ';
          strSQL := strSQL + '   FOR_C_E_P_,                 ';
          strSQL := strSQL + '   FOR_CODCID,                 ';
          strSQL := strSQL + '   FOR_C_G_C_,                 ';
          strSQL := strSQL + '   FOR_FONE01,                 ';
          strSQL := strSQL + '   CID_ESTADO                  ';
          strSQL := strSQL + ' FROM                          ';
          strSQL := strSQL + '   CADFOR,                     ';
          strSQL := strSQL + '   CADCID                      ';
          strSQL := strSQL + ' WHERE                         ';
          strSQL := strSQL + '   FOR_CODFOR = :CODFOR        ';
          strSQL := strSQL + '   AND CID_CODCID = FOR_CODCID ';

          With qryAuxImp Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('CODFOR').AsString := strCodFor;
            Open;
          End;

          FieldByName('CODCLI').AsString := strCodFor;
          FieldByName('DESCRI').AsString := strDescri;
          FieldByName('NOMCLI').AsString := fRetNomFornecedor(FieldByName('CODCLI').AsString);
          FieldByName('ENDERE').AsString := qryAuxImp.FieldByName('FOR_ENDERE').AsString;
          FieldByName('ENDNUM').AsString := qryAuxImp.FieldByName('FOR_ENDNUM').AsString;
          FieldByName('ENDCMP').AsString := qryAuxImp.FieldByName('FOR_ENDCOM').AsString;
          FieldByName('BAIRRO').AsString := qryAuxImp.FieldByName('FOR_BAIRRO').AsString;
          FieldByName('C_E_P_').AsString := qryAuxImp.FieldByName('FOR_C_E_P_').AsString;
          FieldByName('CIDADE').AsString := fRetNomCidade(qryAuxImp.FieldByName('FOR_CODCID').AsString);
          FieldByName('ESTADO').AsString := qryAuxImp.FieldByName('CID_ESTADO').AsString;
          FieldByName('C_G_C_').AsString := qryAuxImp.FieldByName('FOR_C_G_C_').AsString;
          FieldByName('FONE01').AsString := qryAuxImp.FieldByName('FOR_FONE01').AsString;
          FieldByName('SEQCON').AsString := IntToStr(intSeqCon);
          strNomCli := FieldByName('NOMCLI').AsString + ' - ';
        End
        Else
        Begin
          strSQL := '';
          strSQL := strSQL + ' SELECT SQL_NO_CACHE           ';
          strSQL := strSQL + '   CLI_ENDERE,                 ';
          strSQL := strSQL + '   CLI_ENDNUM,                 ';
          strSQL := strSQL + '   CLI_ENDCOM,                 ';
          strSQL := strSQL + '   CLI_BAIRRO,                 ';
          strSQL := strSQL + '   CLI_C_E_P_,                 ';
          strSQL := strSQL + '   CLI_CODCID,                 ';
          strSQL := strSQL + '   CLI_C_G_C_,                 ';
          strSQL := strSQL + '   CLI_FONE01,                 ';
          strSQL := strSQL + '   CLI_FANSOB                  ';
          strSQL := strSQL + ' FROM                          ';
          strSQL := strSQL + '   CADCLI                      ';
          strSQL := strSQL + ' WHERE                         ';
          strSQL := strSQL + '   CLI_CODCLI = :CODCLI        ';

          If strEspDoc = 'CC' Then
            strDescri := strCliCco
          Else If Not fEmptyStr(edtCodCli.Text) Then
            strDescri := edtCodCli.Text;

          With qryAuxImp Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('CODCLI').AsString := LeftStr(strDescri,8);
            Open;
          End;

          FieldByName('CODCLI').AsString := LeftStr(strDescri,8);
          FieldByName('ESTADO').AsString := fRetUFCliente(LeftStr(strDescri,8));
          FieldByName('DESCRI').AsString := fRetNomCliente(FieldByName('CODCLI').AsString) + ' - ' + strDescri;
          FieldByName('NOMCLI').AsString := fRetNomCliente(FieldByName('CODCLI').AsString);
          FieldByName('FANSOB').AsString := qryAuxImp.FieldByName('CLI_FANSOB').AsString;
          FieldByName('ENDERE').AsString := qryAuxImp.FieldByName('CLI_ENDERE').AsString;
          FieldByName('ENDNUM').AsString := qryAuxImp.FieldByName('CLI_ENDNUM').AsString;
          FieldByName('ENDCMP').AsString := qryAuxImp.FieldByName('CLI_ENDCOM').AsString;
          FieldByName('BAIRRO').AsString := qryAuxImp.FieldByName('CLI_BAIRRO').AsString;
          FieldByName('C_E_P_').AsString := qryAuxImp.FieldByName('CLI_C_E_P_').AsString;
          FieldByName('CIDADE').AsString := fRetNomCidade(qryAuxImp.FieldByName('CLI_CODCID').AsString);
          FieldByName('C_G_C_').AsString := qryAuxImp.FieldByName('CLI_C_G_C_').AsString;
          FieldByName('FONE01').AsString := qryAuxImp.FieldByName('CLI_FONE01').AsString;
        End;

        FieldByName('NUMDOC').AsString   := edtNumDoc.Text;
        FieldByName('ESPDOC').AsString   := strEspDoc;
        FieldByName('PARCEL').AsString   := 'A'; // EDUARDO
        FieldByName('CODEMP').AsString   := VS_strCodEmp;
        FieldByName('DTACAD').AsDateTime := VS_Date;
        FieldByName('DTAVEN').AsDateTime := VS_Date;
        FieldByName('DTAREC').AsDateTime := VS_Date;
        FieldByName('HORREC').AsDateTime := fTime();
        FieldByName('CODVEN').AsString   := fBuscaVendedorDup(edtNumDoc.Text,'A',strEspDoc,LeftStr(strDescri,8),VS_strCodEmp);
        FieldByName('VALJUR').AsFloat    := fStrToFloat(edtValJur.Text);
        FieldByName('VALDES').AsFloat    := fStrToFloat(edtValDes.Text);
        FieldByName('VALDOC').AsFloat    := fStrToFloat(edtValDoc.Text);
        FieldByName('VALREC').AsFloat    := fStrToFloat(edtValDoc.Text);
        FieldByName('VALORI').AsFloat    := fStrToFloat(edtValDoc.Text);
        FieldByName('CODCTA').AsString   := strCta_Pg;
        FieldByName('DESCTA').AsString   := fRetDescCentroCusto(strCta_Pg);
        FieldByName('RCX_DESCRI').AsString   := edtDescri.Text;

        FieldByName('VALRES').AsFloat    := 0.00;
        FieldByName('GRVORI').AsFloat    := fStrToFloat(edtValDoc.Text);

        If Not fEmptyStr(edtCodigoCaixa.Text) Then
          FieldByName('RCX_CAIXA').AsString := 'CAIXA: ' + edtCodigoCaixa.Text;

        FieldByName('NOMCTA').AsString   := strCta_Pg + ' - ' + fRetDescCentroCusto(strCta_Pg);
        FieldByName('NOMEVE').AsString   := strCodEve + ' - ' + fRetNomEvento(strCodEve);

        FieldByName('DESCOPEBAI').AsString := edtCodOpe.Text + ' - ' + fRetNomeOperador(edtCodOpe.Text);

        If Assigned(FObjetoPixRecebimento) Then
        Begin
          If TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(FObjetoPixRecebimento) Then
            FieldByName('RECPIX').AsString   := 'S';
        End;

        Post;
      End;

      qryAuxImp.Close;
      FreeAndNil(qryAuxImp);

    End
    Else
    Begin
      pBuscaCtrsParaImpressao(intSeqCon);

      With cdsImpRec Do
      Begin
        IndexFieldnames := 'CODCLI; NUMDOC; PARCEL';
        First;

        //*************************************************//
        // CARREGA OS DADOS DO PRIMEIRO CLIENTE            //
        //**********************************************ED*//
        intContador := -1;
        SetLength(arrCodCli, 0);
        While Not Eof Do
        Begin
          If (Length(arrCodCli) = 0) Or (arrCodCli[intContador].strCodCli <> FieldByName('CODCLI').AsString) Then
          Begin

            blnAchou := False;
            For intContador2 := 0 To Length(arrCodCli) -1 Do
            Begin

              If (arrCodCli[intContador2].strCodCli = FieldByName('CODCLI').AsString) Then
              Begin
                blnAchou := True;
                Break;
              End;

            End;

            If (Not blnAchou) Then
            Begin
              Inc(intContador);
              SetLength(arrCodCli, intContador + 1);
              intContador2 := intContador;
            End;

            strNomCli := fRetNomCliente(FieldByName('CODCLI').AsString);
            arrCodCli[intContador2].strCodCli := FieldByName('CODCLI').AsString;
            arrCodCli[intContador2].strNomCli := FieldByName('CODCLI').AsString + ' - ' + strNomCli;
            pCarregaCliente(FieldByName('CODCLI').AsString);
            arrCodCli[intContador2].strEndCli := qryConCli.FieldByName('CLI_ENDERE').AsString+', ' +
                                                 qryConCli.FieldByName('CLI_ENDNUM').AsString+' - '+
                                                 qryConCli.FieldByName('CLI_BAIRRO').AsString;
            arrCodCli[intContador2].strCepCli := qryConCli.FieldByName('CLI_C_E_P_').AsString;
            arrCodCli[intContador2].strCidCli := fRetNomCidade(qryConCli.FieldByName('CLI_CODCID').AsString)+'-'+
                                                 fRetNomCidade(qryConCli.FieldByName('CLI_CODCID').AsString, 2);

            If (blnAchou) Then
              arrCodCli[intContador2].fltValRec := arrCodCli[intContador2].fltValRec +
                                                   IIF(FieldByName('DUPLICATA_TROCO').AsString.Equals('N'),
                                                       FieldByName('VALREC').AsFloat,
                                                       0)
            Else
              arrCodCli[intContador2].fltValRec := IIF(FieldByName('DUPLICATA_TROCO').AsString.Equals('N'),
                                                       FieldByName('VALREC').AsFloat,
                                                       0);

          End
          Else
            arrCodCli[intContador].fltValRec := arrCodCli[intContador].fltValRec +
                                                IIF(FieldByName('DUPLICATA_TROCO').AsString.Equals('N'),
                                                    FieldByName('VALREC').AsFloat,
                                                    0);

          Next;
        End;
      End;
    End;

    With cdsImpRec Do
    Begin

      If Not IsEmpty Then
      Begin
        //Alteração para impressão de LC.
        If (Pos('LC', strEspDoc) > 0) Then
        Begin
          pCarregaConfImpr(qryCfgRel, 'frmRcxResumoCaixa_LC');
          If qryCfgRel.IsEmpty Then
            pCarregaConfImpr(qryCfgRel, 'frmRcxResumoCaixa');
        End
        Else
          pCarregaConfImpr(qryCfgRel, 'frmRcxResumoCaixa');

        fPreImpressao(qryCfgRel, strNomFil, strTipImp, False);

        strNomPro := qryCfgRel.FieldByName('REL_NOMPRO').AsString;

        If fEmptyStr(strNomPro) Then
          strNomPro := 'frmRcxResumoCaixa';

        {**************************************************}
        {* IMPRESSAO DO RECIBO CUSTOMIZADO DO FAST REPORT *}
        {***********************************************JU*}
        blnImprimiu := fImprimeReciboLayout(arrCodCli,
                                            intOpcao,
                                            fStrToFloat(edtTroco.Text),
                                            GetTotalRecebidoBruto,
                                            strNomFil,
                                            strTipImp);

        If Not blnImprimiu Then
        Begin
          If (((Pos('LC', strEspDoc) > 0) And (fCfgSis('RCXRECPD') = 'S')) Or
              ((Pos('PG', strEspDoc) > 0) And (fCfgSis('RCXRCPDP') = 'S')) Or
              ((Pos('LD', strEspDoc) > 0) And (fCfgSis('RCXRCPDL') = 'S'))) Or
             (Not blnImprimiu) Then
          Begin

            If (intOpcao = 1) And ((strEspDoc = 'PG') Or (strEspDoc = 'LC') Or (strEspDoc = 'LD')) Then
            Begin
              Edit;
              FieldByName('DESCRI').AsString := IIF((strEspDoc = 'PG') Or (strEspDoc = 'LD'),
                                                fRetNomFornecedor(FieldByName('CODCLI').AsString),
                                                fRetNomCliente(FieldByName('CODCLI').AsString))
                                                + ' - ' + strDescri;
              Post;
            End;

            recValRec.strDinRec:=edtDinRec.Text;
            recValRec.strCarRec:=edtCarRec.Text;
            recValRec.strChqPre:=edtChqPre.Text;
            recValRec.strChqVis:=edtChqRec.Text;
            recValRec.strOrdRec:=edtOrdRec.Text;
            recValRec.strCreRec:= FloatToStr(fFormataFloat(fltTotCre,2));

            blnCalculaTotais := False;  //mudar isso na refatoração dos recibos

            pImpRecBaiDoc(cdsImpRec,
                          strRecRcx,
                          intSeqCon,
                          edtCodOpe.Text,
                          arrCodCli,
                          recValRec,
                          cdsChqPre,
                          cdsChqVis,
                          strNomPro,
                          strNomFil,
                          strTipImp,
                          ((intOpcao = 1) And (fCfgSis('RECRCX') = 'B')),
                          strEspDoc,
                          strCta_Pg,
                          strNomCli);

          End;
        End;
      End;
    End;

    cdsImpRec.EmptyDataSet;

  Except
    On E: Exception Do
    Begin
      fMensagem('',E.Message,['&OK']);
    End;
  End;

End;

procedure TfrmRcxResumoCaixa.pImprimeTermoDeFechamentoComDivergencia;
  Var
    cdsFechamento: TDataset;
    qryCadEmp    : TUniQuery;

    frmRelRcxResumoCaixaMod: TfrmRelRcxResumoCaixaMod;

    strNomFil,
    strTipImp: String;

    frxRelatorio: TfrxReport;
begin
  Try
    qryCfgRel := fCriaQuery;
    pCarregaConfImpr(qryCfgRel, 'impressao_fechamento_rcx');
    fPreImpressao(qryCfgRel, strNomFil, strTipImp, False);

    pCriarFormularios(TfrmRelRcxResumoCaixaMod, frmRelRcxResumoCaixaMod);

    If fCfgSis('FECRCX') = '1' Then
      frxRelatorio := frmRelRcxResumoCaixaMod.frxTermoFechamento
    Else
      frxRelatorio := frmRelRcxResumoCaixaMod.frxTermoFechamento40c;

    objResumoDeCaixa.fAbrirLayoutTermoDeFechamento(frxRelatorio, strTipImp, fCfgSis('FECRCX'));

    cdsFechamento := objResumoDeCaixa.fRetornaDadosUltimoFechamento(edtCodigoCaixa.Text, VS_strCodEmp);

    qryCadEmp := fCriarQuery('SELECT *, CID_NOMCID AS EMP_NOMCID, CID_ESTADO AS EMP_ESTADO FROM CADEMP ' +
                             ' LEFT JOIN CADCID ON CID_CODCID=EMP_CODCID WHERE EMP_CODEMP=' + VS_strCodEmp.QuotedString);

    frmRelRcxResumoCaixaMod.frxDataSetEmpresa.Dataset := qryCadEmp;
    frmRelRcxResumoCaixaMod.frxDataSetFechamentoCaixa.Dataset := cdsFechamento;

    If fCfgSis('AVLTDV', varBoolean) Then
    Begin
       If frxRelatorio.FindObject('mmExibeValorDiv') <> Nil Then
          TfrxMemoView(frxRelatorio.FindObject('mmExibeValorDiv')).Text := 'Valor da Divergência: R$ [<frxDataSetFechamentoCaixa."RCX_VALDIV">]';
    End;

    If strNomFil.IsEmpty Then
    Begin
      frxRelatorio.PrintOptions.ShowDialog := True;
      pPreviewReport('impressao_fechamento_rcx', 'Resumo de Caixa - Termo de Fechamento com divergência', frxRelatorio);
    End
    Else
    Begin
      frxRelatorio.PrintOptions.Printer := AnsiReplaceStr(strNomFil,'\\' + fRetNomeRede + '\','');
      frxRelatorio.PrepareReport();
      pPrintReport('impressao_fechamento_rcx', 'Resumo de Caixa - Termo de Fechamento com divergência', strNomFil, frxRelatorio);
    End;
  Finally
    FreeAndNil(frxRelatorio);
    FreeAndNil(frmRelRcxResumoCaixaMod);
    FreeAndNil(cdsFechamento);
    FreeAndNil(qryCadEmp);
  End;
end;

procedure TfrmRcxResumoCaixa.edtCodCliChange(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtCodCli.Text) Then
  Begin
    mskDtaIni.Text := '';
    mskDtaFin.Text := '';
  End
  Else
  Begin
    mskDtaIni.Date := VS_Date;
    mskDtaFin.Date := VS_Date;
  End;

end;

function TfrmRcxResumoCaixa.fChequesCadastrados(fltValor: Double; blnPrazo: Boolean): Boolean;
  Var
    fltTotal: Double;
    cdsTemp: TUniClientDataSet;
Begin
  fltTotal := 0.00;

  If blnPrazo Then cdsTemp := cdsChqPre Else cdsTemp := cdsChqVis;

  With cdsTemp Do
    If Assigned(cdsTemp) And (Not IsEmpty) Then
      fltTotal := TAggregateField(FieldByName('TOT_VALCHQ')).Value;

  Result := (fFormataFloat(fltValor, 2) = fFormataFloat(fltTotal, 2));
End;

procedure TfrmRcxResumoCaixa.pDocumentosTrocaFormaPagamento;
  Var
    dtaDtaCad: TDateTime;
    fltUltFec: Double;
    frmRcxSelDocsFpg : TfrmRcxSelDocsFpg;
begin

  If (Not fCfgSis('USAFPG', varBoolean)) Then
  Begin
    Exit;
  End;

  If Not objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDaTransferencia(edtCodigoCaixa.Text), True, False) Then
  Begin
    pMensagemOk('Não será possível efetuar alteração de formas de pagamento agora, pois outra estação está realizando transferência!');
    Exit;
  End
  Else
    objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDaTransferencia(edtCodigoCaixa.Text), False);

  If Not objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDoFechamento(edtCodigoCaixa.Text), True, False) Then
  Begin
    pMensagemOk('Não será possível efetuar alteração de formas de pagamento agora, pois outra estação está realizando o fechamento do caixa!');
    Exit;
  End
  Else
    objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDoFechamento(edtCodigoCaixa.Text), False);

  objResumoDeCaixa.fRetornaUltimoFechamento(fltUltFec, dtaDtaCad, edtCodigoCaixa.Text);

  Try
    pCriarFormularios(TfrmRcxSelDocsFpg, frmRcxSelDocsFpg);
    frmRcxSelDocsFpg.dtaDtaRef := dtaDtaCad;
    frmRcxSelDocsFpg.strCodOpe := edtCodOpe.Text;
    frmRcxSelDocsFpg.dbgDocumentos.DataSource := dtsTmpResumoCaixa;
    frmRcxSelDocsFpg.objResumoDeCaixa := objResumoDeCaixa;
    frmRcxSelDocsFpg.strCodigoCaixa   := edtCodigoCaixa.Text;

    frmRcxSelDocsFpg.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pDocumentosTrocaFormaPagamento]');
    End;
  End;

  pFreeAndNil(frmRcxSelDocsFpg);

end;

procedure TfrmRcxResumoCaixa.btnFormaPagamentoClick(Sender: TObject);
begin
  inherited;

  If Not btnFormaPagamento.Visible Then
    Exit;

  If Not fDireitoAcessoLancamentos('FPG',
                                   'Resumo de Caixa - [ F3 ] Forma Pag.') Then
  Begin
    fMensagem('ATENÇÃO!', 'Você não tem direito de usar esse recurso!', ['&Ok']);
    Exit;
  End;

  If EstaRealizandoRecebimentoF1F2 Then
    Exit;

  log('Apertou F3');
  pDocumentosTrocaFormaPagamento;
  pZeraVariaveisResumo;
end;

procedure TfrmRcxResumoCaixa.btnGravarClick(Sender: TObject);
begin
  inherited;

  Try
    If InterlockedIncrement(intConfirma) = 0 Then
      fGravar
    Else
      InterlockedDecrement(intConfirma);
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;
  InterlockedDecrement(intConfirma);

  If (Assigned(FObjetoPixRecebimento)) And (MatchStr(FObjetoPixRecebimento.Status, STATUS_PIX_PAGO)) Then
  Begin
    edtOrdRec.Enabled := False;
    btnReceberPix.Enabled := False;
  End;
end;

procedure TfrmRcxResumoCaixa.btnConfirmaCuponsClick(Sender: TObject);
begin
  inherited;

  If (fCfgSis('USNFCE', varBoolean)) Or fUsaSat Then
  Begin
    pMostraNFCePendentes;
    Exit;
  End;

  If fVerificaAcessoSistema('IMPCF8') Then
  Begin
    log('Pressionou F8');
    If (Not fCfgSis('USACUP', varBoolean)) Or (fCfgSis('PAFECF', varBoolean)) Then
      Exit;

    If EstaRealizandoRecebimentoF1F2 Then
      Exit;

    pZeraVariaveisResumo;
    pLimpaCampos;

    Try
      pCriarFormularios(TfrmRcxConfCupom, frmRcxConfCupom);

      frmRcxConfCupom.strOpeCai      := edtCodOpe.Text;
      frmRcxConfCupom.strCodigoCaixa := edtCodigoCaixa.Text;

      If Not frmRcxConfCupom.fCriaTemporaria Then
        fMensagem('', 'Não foi encontrado nenhum documento para emissão de Cupom Fiscal!', ['&Ok'])
      Else
        frmRcxConfCupom.showModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[btnConfirmaCuponsClick]');
      End;
    End;

    pFreeAndNil( frmRcxConfCupom );

    log('Pressionou F8');
  End
  Else
    fMensagem('', 'Você não tem direitos para acessar a confirmação de cupons!', ['&Ok']);

end;

procedure TfrmRcxResumoCaixa.pPreparaParaConfirmarFF(objVenda: TFatVenda);
begin
  If ((fCfgSis('USACUP', varBoolean)) Or (fCfgSis('USNFCE', varBoolean)) Or fUsaSat) And
     (Not fCfgSis('PAFECF', varBoolean)) And
     ((Not objVenda.blnVendaPresencial) Or (objVenda.blnVendaPresencial And objVenda.fFaturamentoDentroDoEstado)) Then
  Begin   
    objVenda.strEspDoc := 'IF';

    If (Not fPermiteEmitirCupomParaForaDoEstado(objVenda, True)) Then
    Begin                                          
      objVenda.strEspDoc := 'NF'                                          
    End;

    If (Not fPermiteEmitirCupom(objVenda, True)) Then
    Begin                                          
      objVenda.strEspDoc := 'NF'                                          
    End;
  End
  Else
    objVenda.strEspDoc := 'NF';
end;

procedure TfrmRcxResumoCaixa.btnConfFFSimplificadaClick(Sender: TObject);
  Var
    strMsg   : String;
    strNum_FF: String;
    strCli_FF: String;
    strVen_FF: String;
    strRep_FF: String;
    strOri_FF: String;
    dtaDataFF: TDateTime;
    objConfFF: TConfirmacaoDocumentos;
    blnDupVis : Boolean;

    LSaldoUltimFechamento: Double;

    LDataUltimoFechamento: TDateTime;
begin
  inherited;

  If Not btnConfFFSimplificada.Visible Then
    Exit;

  If fVerificaSeImpNFAvulsa('NF', teConfirmacaoDoc) Then
    Exit;

  If EstaRealizandoRecebimentoF1F2 Then
    Exit;

  objResumoDeCaixa.fRetornaUltimoFechamento(LSaldoUltimFechamento, LDataUltimoFechamento, edtCodigoCaixa.Text);

  If Not strTipoFechamentoCaixa.Equals('C') Then
  Begin
    If LDataUltimoFechamento = VS_Date Then
    Begin
      fMensagem('', 'O caixa está fechado no dia de hoje. Não é possível realizar a confirmação de FF simplificada!', ['&Ok']);
      Exit;
    End;
  End;

  If Not fVerificaAcessoSistema('DIRRCXCFF', edtCodOpe.Text) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Confirmação FF Simplificada [CTRL+F] (Resumo de Caixa)');

    objLiberacao.strDirAce := 'DIRRCXCFF';
    objLiberacao.strMsgSen := 'Conf. FF Simplificada';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := edtCodOpe.Text;
    objLiberacao.strCodDig := edtCodOpe.Text;

    If (Not objLiberacao.fLibera) Then
    Begin
      Exit;
    End;

  End;

  If Not objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDaTransferencia(edtCodigoCaixa.Text), True, False) Then
  Begin
    pMensagemOk('Não será possível efetuar a confirmação de FF simplicada agora pois outra estação está realizando transferência!');
    Exit;
  End
  Else
    objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDaTransferencia(edtCodigoCaixa.Text), False);

  If Not objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDoFechamento(edtCodigoCaixa.Text), True, False) Then
  Begin
    pMensagemOk('Não será possível efetuar a confirmação de FF simplificada agora pois outra estação está realizando o fechamento do caixa!');
    Exit;
  End
  Else
    objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDoFechamento(edtCodigoCaixa.Text), False);

  pZeraVariaveisResumo;

  Try
    pCriarFormularios(TfrmRcxDigDocumento, frmRcxDigDocumento);

    frmRcxDigDocumento.edtEspDoc.Text := 'FF';
    frmRcxDigDocumento.edtCodEmp.Text := VS_strCodEmp;
    frmRcxDigDocumento.edtDesEmp.Text := fRetNomeEmpresa(VS_strCodEmp);

    frmRcxDigDocumento.edtEspDoc.Enabled := False;
    frmRcxDigDocumento.edtCodEmp.Enabled := (fCfgSis('CFFMAT', varBoolean));

    If (frmRcxDigDocumento.ShowModal = mrOk) Then
      strNum_FF := frmRcxDigDocumento.edtNumDoc.Text;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[btnConfFFSimplificada.Click]');
    End;
  End;

  If (Not fEmptyStr(strNum_FF)) Then
  Begin
    If (fVerificaVendaExiste(strNum_FF, 'FF', frmRcxDigDocumento.edtCodEmp.Text, strCli_FF, strVen_FF, strRep_FF, strOri_FF, dtaDataFF)) Then
    Begin
      objConfFF := TConfirmacaoDocumentos.Create(Nil);

      objConfFF.blnFiltrarEmp := True;
      If (frmRcxDigDocumento.edtCodEmp.Enabled) Then
        objConfFF.strEmpDoc := frmRcxDigDocumento.edtCodEmp.Text;

      objConfFF.strCodCli := strCli_FF;

      objConfFF.pSetaClienteDocs(fGetCliIFOrDocs(frmRcxDigDocumento.edtNumDoc.Text,
                                                 frmRcxDigDocumento.edtCodEmp.Text,
                                                 frmRcxDigDocumento.edtEspDoc.Text));

      objConfFF.strNumDoc := strNum_FF;
      objConfFF.strEspDoc := 'FF';

      objConfFF.pPreparaDocumentoParaConfirmar := pPreparaParaConfirmarFF;

      objConfFF.pCriaTemporariaConfirmacao;

      If Not objConfFF.blnSemDocumentosParaConfirmar Then
      Begin
        objConfFF.objFatVenda.strCodOpe := edtCodOpe.Text;
        objConfFF.objFatVenda.strCodVen := edtCodOpe.Text;                   // Vendedor      - Codigo
        objConfFF.objFatVenda.strCodDig := edtCodOpe.Text;                   // Digitador     - Codigo
        objConfFF.objFatVenda.strNomVen := fRetNomVendRep(edtCodOpe.Text);   // Vendedor      - Nome
        objConfFF.objFatVenda.strNomDig := fRetNomVendRep(edtCodOpe.Text);   // Digitador     - Nome

        objConfFF.objFatVenda.blnConfirmacaoDoCaixa := True;
        objConfFF.objFatVenda.pCarregaDadosClienteBaixa(strCli_FF);

        If objConfFF.fMarcaDocumento(True, strMsg) And
           objConfFF.fCarregaItensConfirmacaoDocumentos And
           objConfFF.fConfirmarDocumentos Then
        Begin
          fMensagem('ATENÇÃO!', 'Confirmação da FF (' + objConfFF.strNumDoc + ') ' +
                                'concluida com sucesso!', ['&Ok']);

          If fTemDuplicatasEmAberto(objConfFF.objFatVenda.strNumDoc,
                                    objConfFF.objFatVenda.strEspDoc,
                                    frmRcxDigDocumento.edtCodEmp.Text) Then
          Begin
            If (objConfFF.objFatVenda.strEspDoc = 'IF') And (Not fCfgSis('USNFCE', varBoolean)) And (Not fUsaSat) Then
            Begin
              fMensagem('ATENÇÃO!', Format('Realize a impressão e posteriormente o recebimento do %s !',
                   [objConfFF.objFatVenda.strEspDoc + '-' + objConfFF.objFatVenda.strNumDoc]), ['&Ok']);
            End
            Else
            Begin
              If fMensagem('', Format('Deseja realizar o recebimento do documento %s ?',
                [objConfFF.objFatVenda.strEspDoc + '-' + objConfFF.objFatVenda.strNumDoc]), ['&Sim', '&Não'], 1) = 1 Then
              Begin
                Try
                  blnDupVis := chkDuplicatasVista.Checked;
                  chkDuplicatasVista.Checked := False;
                  Try
                    If fChamaTelaDocumentos(frmRcxDigDocumento.edtCodEmp.Text,
                                            objConfFF.objFatVenda.strNumDoc,
                                            objConfFF.objFatVenda.strEspDoc) Then
                      pPosChamaTelaDocumentos;
                  Finally
                    chkDuplicatasVista.Checked := blnDupVis;
                  End;
                Except
                  pZeraVariaveisResumo;
                End;
              End;
            End;
          End;
        End;
      End
      Else
        fMensagem('ATENÇÃO!', 'Não há FF para confirmar com este número!', ['&Ok']);

      FreeAndNil(objConfFF);
    End
    Else
      fMensagem('ATENÇÃO!', 'Documento ' + strNum_FF + '-FF não foi encontrado no sistema!', ['&Ok']);
  End
  Else
    fMensagem('ATENÇÃO!', 'O número da FF deve ser informado!', ['&Ok']);

  pFreeAndNil(frmRcxDigDocumento);
end;

procedure TfrmRcxResumoCaixa.btnConfFFSimplificadaEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := btnConfFFSimplificada.Hint;
end;

procedure TfrmRcxResumoCaixa.btnConfFFSimplificadaExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmRcxResumoCaixa.btnAcompanhaServClick(Sender: TObject);
begin
  inherited;
  If btnAcompanhaServ.Visible And (btnAcompanhaServ.Enabled) Then
  Begin
    If fCfgSis('ACOSER') = '1' Then
      pCriarForm(TfrmConsultaServicosAutocenter)
    Else
      pCriarForm(TfrmConsultaServicosAutocenterVendas);
  End;
end;

procedure TfrmRcxResumoCaixa.btnAdiantamentoClick(Sender: TObject);
  Var
    fltSalFec: Double;
    dtaDtaFec,
    dtaDtaLan: TDateTime;
begin
  inherited;
  If EstaRealizandoRecebimentoF1F2 Then
    Exit;

  pZeraVariaveisResumo;
  pLimpaCampos;

  If (fCfgSis('USAFPG', varBoolean)) And
     (fCfgSis('USARCX', varBoolean)) And
     (Not objResumoDeCaixa.fNecessitaFecharCaixa(True, dtaDtaLan, edtCodigoCaixa.Text)) Then
  Begin
    Exit;
  End
  Else
  Begin
   //FECHAMENTO FINANCEIRO
    if objFechamento.FechamentoFinanceiroJaRealizado(VS_strCodEmp, dtaDtaCai) then
      Exit;

    objResumoDeCaixa.fRetornaUltimoFechamento(fltSalFec, dtaDtaFec, edtCodigoCaixa.Text);
    If (strTipoFechamentoCaixa <> 'C') And
       (dtaDtaFec = dtaDtaCai) Then
    Begin
      pMensagemOk('O fechamento referente ao dia: ' + mskDiaAbe.Text + ' já foi efetuado!');
      Exit;
    End;
  End;

  If Not fVerificaAcessoSistema('DIRRCXADC', edtCodOpe.Text) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Adiantamento de Cliente (Resumo de Caixa)');

    objLiberacao.strDirAce := 'DIRRCXADC';
    objLiberacao.strMsgSen := 'Adiantamento de Cliente';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := edtCodOpe.Text;
    objLiberacao.strCodDig := edtCodOpe.Text;

    If (Not objLiberacao.fLibera) Then
    Begin
      Exit;
    End;
  End;

  TAdiantamento.fRealizarAdiantamentoCliente(Self.Name,
                                             edtCodOpe.Text,
                                             edtCodigoCaixa.Text,
                                             '',
                                             '',
                                             '',
                                             'RCX',
                                             False,
                                             '',
                                             1,
                                             objResumoDeCaixa);
end;

procedure TfrmRcxResumoCaixa.btnAtalhosClick(Sender: TObject);
  Var
    point: TPoint;
begin
  inherited;
  point.X := btnAtalhos.Left + (btnAtalhos.Width DIV 2) ;
  point.Y := btnAtalhos.Top + pnlCentral.Height + (btnAtalhos.Height DIV 2) ;
  point := ClientToScreen(point) ;

  popEstornos.Popup( point.X, point.Y);
end;

procedure TfrmRcxResumoCaixa.btnAutTRClick(Sender: TObject);
  Var
    frmRcxSelDocumentos : TfrmRcxSelDocumentos;
begin
  inherited;

  If Not btnAutTR.Visible Then Exit;

  If EstaRealizandoRecebimentoF1F2 Then
    Exit;

  If Not fVerificaAcessoSistema('DIRRCXTRDV', edtCodOpe.Text) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Autenticação para liberar crédito para o cliente.');

    objLiberacao.strDirAce := 'DIRRCXTRDV';
    objLiberacao.strMsgSen := 'Autenticação para liberar crédito para o cliente.';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := edtCodOpe.Text;
    objLiberacao.strCodDig := edtCodOpe.Text;

    If (Not objLiberacao.fLibera) Then
    Begin
      Exit;
    End;

  End;

  Try
    pCriarFormularios(TfrmRcxSelDocumentos, frmRcxSelDocumentos);
    frmRcxSelDocumentos.strCodEmp := VS_strCodEmp;
    frmRcxSelDocumentos.strCodOpe := edtCodOpe.Text;
    frmRcxSelDocumentos.blnDuplicatasVista := False;
    frmRcxSelDocumentos.blnAutTrDv := True;

    frmRcxSelDocumentos.strCodCli := '';
    frmRcxSelDocumentos.strNumRom := '';
    frmRcxSelDocumentos.dtaDtaIni := 0;
    frmRcxSelDocumentos.dtaDtaFin := 0;

    frmRcxSelDocumentos.pAtualizaTemporaria(False);

    If (frmRcxSelDocumentos.cdsDadosTemp.IsEmpty) Then
    Begin
      fMensagem('', 'Não há dados para serem autenticados!', ['&Ok']);
      Screen.Cursor := crDefault;
    End
    Else
    Begin
      frmRcxSelDocumentos.pnlValores.Visible        := False;
      frmRcxSelDocumentos.btnImpressao.Visible      := False;
      frmRcxSelDocumentos.btnRecalculaJuros.Visible := False;
      frmRcxSelDocumentos.btnDupAgrupadas.Visible   := False;
      frmRcxSelDocumentos.btnSelecTodos.Visible     := False;

      frmRcxSelDocumentos.btnPesquisa.Left   := frmRcxSelDocumentos.btnConfirma.Left + frmRcxSelDocumentos.btnConfirma.Width + 2;
      frmRcxSelDocumentos.btnProdutos.Left   := frmRcxSelDocumentos.btnPesquisa.Left + frmRcxSelDocumentos.btnPesquisa.Width + 2;

      frmRcxSelDocumentos.ShowModal;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[fChamaTelaDocumentos-AUT]');
  End;
  pFreeAndNil(frmRcxSelDocumentos);

end;

procedure TfrmRcxResumoCaixa.btnBaixaCtaPagarClick(Sender: TObject);
 Var
    fltUltFech: Double;
    dtaUltFech: TDateTime;
    frmBaixaCtaPagar : TfrmBaixaCtaPagar;
begin
  inherited;
  If EstaRealizandoRecebimentoF1F2 Then
    Exit;

  objResumoDeCaixa.fRetornaUltimoFechamento(fltUltFech, dtaUltFech, edtCodigoCaixa.Text);

  If (strTipoFechamentoCaixa <> 'C') And
     (dtaUltFech = VS_Date) Then
  Begin
    fMensagem('', 'O caixa está fechado no dia de hoje. Não é possível realizar baixas de contas a pagar!', ['&Ok']);
    Exit;
  End;
  If (dtaDtaCai <> VS_Date) Then
  Begin
    fMensagem('ATENÇÃO', 'O caixa deve estar na data atual para realizar baixas de contas a pagar!', ['&Ok']);
    Exit;
  End;

  If Not fVerificaAcessoSistema('DIRRCXCTP', edtCodOpe.Text) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Baixa de Contas a Pagar (Resumo de Caixa)');

    objLiberacao.strDirAce := 'DIRRCXCTP';
    objLiberacao.strSenLib := fCfgSis('BAICTP');
    objLiberacao.strMsgSen := 'Baixa de Contas a Pagar';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := edtCodOpe.Text;
    objLiberacao.strCodDig := edtCodOpe.Text;

    If (Not objLiberacao.fLibera) Then
      Exit;

  End;

  If Not objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDaTransferencia(edtCodigoCaixa.Text), True, False) Then
  Begin
    pMensagemOk('Não será possível efetuar baixa de contas a pagar agora pois outra estação está realizando transferência!');
    Exit;
  End
  Else
    objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDaTransferencia(edtCodigoCaixa.Text), False);

  If Not objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDoFechamento(edtCodigoCaixa.Text), True, False) Then
  Begin
    pMensagemOk('Não será possível efetuar baixa de contas a pagar agora pois outra estação está realizando o fechamento do caixa!');
    Exit;
  End
  Else
    objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDoFechamento(edtCodigoCaixa.Text), False);

  log('Apertou F9');

  pZeraVariaveisResumo;

  If Not objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDoContasAPagar(edtCodigoCaixa.Text), True, False) Then
  Begin
    pMensagemOk('Não será possível efetuar baixa de contas a pagar agora pois outra estação está realizando a baixa!');
    Exit;
  End;

  pCriarFormularios(TfrmBaixaCtaPagar, frmBaixaCtaPagar);

  Try
    Try
      frmBaixaCtaPagar.blnResumoCaixa   := True;
      frmBaixaCtaPagar.strOpeCaixa      := edtCodOpe.Text;
      frmBaixaCtaPagar.strChamada       := '[frmRcxResumoCaixa.btnBaixaCtaPagarClick]';
      frmBaixaCtaPagar.strCodigoCaixa   := edtCodigoCaixa.Text;
      frmBaixaCtaPagar.objResumoDeCaixa := objResumoDeCaixa;
      frmBaixaCtaPagar.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[btnBaixaCtaPagarClick]');
      End;
    End;

  Finally
    objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDoContasAPagar(edtCodigoCaixa.Text), False);
    pFreeAndNil(frmBaixaCtaPagar);
  End;
end;

procedure TfrmRcxResumoCaixa.btnBusContratoClick(Sender: TObject);
  var
    blnResult: Boolean;
begin
  inherited;

  If btnBusContrato.Visible And btnBusContrato.Enabled Then
  Begin
    If EstaRealizandoRecebimentoF1F2 Then
      Exit;

    pLimpaCampos;

    Try
      blnResult := fChamaTelaDocumentos(edtCodEmp.Text, '', '', True);
    Except
      pZeraVariaveisResumo;
      blnResult := False;
    End;

    If (blnResult) Then
    Begin
      pPosChamaTelaDocumentos;
    End;

    If strTipoFechamentoCaixa <> 'C' Then
      edtSqFcRx.Text := fStrZero(VarToStr(fCfgSisL('SQFCRX')), 3);

  End;

end;

function TfrmRcxResumoCaixa.fValidaFormaPagamento(Const intTipCli: Integer): Boolean;
  Var
    strCodFpg: String;
begin

  If (fCfgSis('TPCBRC', varBoolean)) Then
  Begin
    Result := True;
    Exit;
  End;

  Case (intTipCli) Of

    TPC_DINHEIRO     :Begin
                        strCodFpg := '001';
                      End;

    TPC_CHEQUE_PRE   :Begin
                        strCodFpg := '002';
                      End;

    TPC_CHEQUE_VISTA :Begin
                        strCodFpg := '006';
                      End;

    TPC_CARTAO       :Begin
                        strCodFpg := '007';
                      End;

    TPC_ORDEM_PAGAMENTO :Begin
                           strCodFpg := '012';
                         End;

  End;

  Result := True;
  If (pgcDadosGerais.ActivePage = tbsRecebimentos) Then
    Result := (stlForPag.IndexOf(strCodFpg) >= 0);

  If Not Result Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Forma de pagamento não permitida');
    objLiberacao.objMsgLibera.pAddTexto(strCodFpg + '-' + fRetDesFpg(strCodFpg));

    objLiberacao.strDirAce := 'FPGSEN';
    objLiberacao.strSenLib := fCfgSis('FPGSEN');
    objLiberacao.strMsgSen := 'Forma pagamento não permitida';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
  End;

end;

procedure TfrmRcxResumoCaixa.btnDepoChequeClick(Sender: TObject);
  Var
    frmBaixaCheques : TfrmBaixaCheques;
begin
  inherited;

  If EstaRealizandoRecebimentoF1F2 Then
    Exit;

  If Not fVerificaAcessoSistema('DIRRCXDPC', edtCodOpe.Text) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Depósito de Cheques (Resumo de Caixa)');

    objLiberacao.strDirAce := 'DIRRCXDPC';
    objLiberacao.strSenLib := fCfgSis('RCXDPC');
    objLiberacao.strMsgSen := 'Depósito de Cheques';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := edtCodOpe.Text;
    objLiberacao.strCodDig := edtCodOpe.Text;

    If (Not objLiberacao.fLibera) Then
    Begin
      Exit;
    End;

  End;

  log('Pressionou F5');
  pZeraVariaveisResumo;

  Try
    pCriarFormularios(TfrmBaixaCheques, frmBaixaCheques);
    frmBaixaCheques.blnResCai := True;
    frmBaixaCheques.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[btnDepoChequeClick]');
    End;
  End;

  pFreeAndNil(frmBaixaCheques);

  log('Fim do F5');

end;

//***************************************//
// IMPRIMIR RELATÓRIO DE ROMANEIO        //
//************************************RL*//
procedure TfrmRcxResumoCaixa.btnRomaneioClick(Sender: TObject);
begin
  inherited;
  log('Apertou F11');

    If Assigned(prcExecutaRelatorio) Then
        begin
          prcExecutaRelatorio(200, 7576, [],
                              [],
                              [],
                              Sender,
                              [],
                              False);
        End;


end;

procedure TfrmRcxResumoCaixa.btnConfCupSimplificadaClick(Sender: TObject);
  Var
    objConfCupom: TConfirmacaoCupom;

    LDataUltimoFechamento: TDateTime;

    LSaldoUltimFechamento: Double;
begin
  inherited;

  If fVerificaSeImpNFAvulsa('NF', teConfirmacaoIF) Then
    Exit;

  If EstaRealizandoRecebimentoF1F2 Then
    Exit;

  objResumoDeCaixa.fRetornaUltimoFechamento(LSaldoUltimFechamento, LDataUltimoFechamento, edtCodigoCaixa.Text);

  If Not strTipoFechamentoCaixa.Equals('C') Then
  Begin
    If LDataUltimoFechamento = VS_Date Then
    Begin
      fMensagem('', 'O caixa está fechado no dia de hoje. Não é possível realizar a confirmação de cupons!', ['&Ok']);
      Exit;
    End;
  End;

  If Not fVerificaAcessoSistema('DIRRCXCCS', edtCodOpe.Text) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Confirmação Cupom Simplificada [Alt+F] (Resumo de Caixa)');

    objLiberacao.strDirAce := 'DIRRCXCCS';
    objLiberacao.strSenLib := fCfgSis('RCXCCS');
    objLiberacao.strMsgSen := 'Conf. Cupom Simplificada';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := edtCodOpe.Text;
    objLiberacao.strCodDig := edtCodOpe.Text;

    If (Not objLiberacao.fLibera) Then
    Begin
      Exit;
    End;

  End;

  If (fEmptyStr(fCfgSis('CLACIF'))) Then
  Begin
    pMensagemOk('Configure a Classificação fiscal para confirmação de cupons.');
    Exit;
  End;

  If Not objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDaTransferencia(edtCodigoCaixa.Text), True, False) Then
  Begin
    pMensagemOk('Não será possível efetuar a confirmação de cupons agora pois outra estação está realizando transferência!');
    Exit;
  End
  Else
    objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDaTransferencia(edtCodigoCaixa.Text), False);

  If Not objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDoFechamento(edtCodigoCaixa.Text), True, False) Then
  Begin
    pMensagemOk('Não será possível efetuar a confirmação de cupons agora pois outra estação está realizando o fechamento do caixa!');
    Exit;
  End
  Else
    objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDoFechamento(edtCodigoCaixa.Text), False);

  pZeraVariaveisResumo;  

  Try
    pCriarFormularios(TfrmRcxDigDocumento, frmRcxDigDocumento);

    frmRcxDigDocumento.edtEspDoc.Text := 'IF';
    frmRcxDigDocumento.edtCodEmp.Text := VS_strCodEmp;
    frmRcxDigDocumento.edtDesEmp.Text := fRetNomeEmpresa(VS_strCodEmp);

    frmRcxDigDocumento.edtEspDoc.Enabled := False;
    frmRcxDigDocumento.edtCodEmp.Enabled := False;

    If (frmRcxDigDocumento.ShowModal = mrOk) Then
    Begin
      If (Not fEmptyStr(frmRcxDigDocumento.edtNumDoc.Text)) Then
      Begin
        objConfCupom := TConfirmacaoCupom.Create(Nil);

        objConfCupom.strNumeroCupom := frmRcxDigDocumento.edtNumDoc.Text;
        objConfCupom.strEspecieCupom := frmRcxDigDocumento.edtEspDoc.Text;
        objConfCupom.blnCarregarCupomEspecial := True;
        objConfCupom.strCodigoCliente := fGetCliIFOrDocs(frmRcxDigDocumento.edtNumDoc.Text,
                                                         frmRcxDigDocumento.edtCodEmp.Text,
                                                         frmRcxDigDocumento.edtEspDoc.Text);
        objConfCupom.pSetaClienteCupom(objConfCupom.strCodigoCliente);

        objConfCupom.pCriaTemporariaConfirmacao;

        If Not objConfCupom.blnSemCuponsParaConfirmar Then
        Begin
          objConfCupom.objFatVenda.strCodOpe := edtCodOpe.Text;
          objConfCupom.objFatVenda.strCodVen := edtCodOpe.Text;                   // Vendedor      - Codigo
          objConfCupom.objFatVenda.strCodDig := edtCodOpe.Text;                   // Digitador     - Codigo
          objConfCupom.objFatVenda.strNomVen := fRetNomVendRep(edtCodOpe.Text);   // Vendedor      - Nome
          objConfCupom.objFatVenda.strNomDig := fRetNomVendRep(edtCodOpe.Text);   // Digitador     - Nome

          objConfCupom.objFatVenda.blnConfirmacaoDoCaixa := True;
          objConfCupom.objFatVenda.pCarregaDadosClienteBaixa(objConfCupom.strCodigoCliente);

          If objConfCupom.fMarcaDocumento(True) And
             objConfCupom.fCarregaItensConfirmacaoCupomFiscal And
             objConfCupom.fConfirmarCupomFiscalEmNota Then
          Begin
            fMensagem('ATENÇÃO!', 'Confirmação do Cupom Fiscal (' + objConfCupom.strNumeroCupom + ') ' +
                                  'concluida com sucesso!', ['&Ok']);

            If fTemDuplicatasEmAberto(objConfCupom.objFatVenda.strNumDoc,
                                      objConfCupom.objFatVenda.strEspDoc,
                                      VS_strCodEmp) Then
            Begin
              If fMensagem('', Format('Deseja realizar o recebimento do documento %s ?',
                [objConfCupom.objFatVenda.strEspDoc + '-' + objConfCupom.objFatVenda.strNumDoc]), ['&Sim', '&Não'], 1) = 1 Then
              Begin
                Try
                  If fChamaTelaDocumentos(VS_strCodEmp,
                                          objConfCupom.objFatVenda.strNumDoc,
                                          objConfCupom.objFatVenda.strEspDoc) Then
                    pPosChamaTelaDocumentos;
                Except
                  pZeraVariaveisResumo;
                End;
              End;
            End;
          End;
        End
        Else
          fMensagem('ATENÇÃO!', 'Não há cupom para confirmar com este número!', ['&Ok']);

        FreeAndNil(objConfCupom);
      End
      Else
        fMensagem('ATENÇÃO!', 'O número do cupom fiscal deve ser informado!', ['&Ok']);
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmRcxResumoCaixa.btnInfDocClick]');
    End;
  End;

  pFreeAndNil(frmRcxDigDocumento);

end;

procedure TfrmRcxResumoCaixa.btnConfCupSimplificadaEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := btnConfCupSimplificada.Hint;
end;

procedure TfrmRcxResumoCaixa.btnConfCupSimplificadaExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmRcxResumoCaixa.btnBaixaEntFuturaClick(Sender: TObject);
  Var
    frmFatBaixaEntregaFutura: TfrmFatBaixaEntregaFutura;
begin
  inherited;
  If EstaRealizandoRecebimentoF1F2 Then
    Exit;

  If fTemCFOPBaixaEntregaFutura(TRUE) And
     fTemTransportadoraPadrao(TRUE) Then
  Begin
    pCriarFormularios(TfrmFatBaixaEntregaFutura, frmFatBaixaEntregaFutura);
    frmFatBaixaEntregaFutura.strCodigoCaixa := edtCodigoCaixa.Text;
    frmFatBaixaEntregaFutura.ShowModal;
    FreeAndNil(frmFatBaixaEntregaFutura);
  End;

end;

procedure TfrmRcxResumoCaixa.AbreTelaParaPagamentoDoPix;
  Var
    LErro,
    LRetornoPix,
    LDadosPagamento,
    LCodigoCliente,
    LChaveDuplicata: String;

    LDadosRequisicaoPixAVista: TDadosRequisicaoPixAVista;
begin
  Try
    LCodigoCliente := EmptyStr;

    If strEspdoc.IsEmpty Then
    Begin
      LDadosRequisicaoPixAVista := TFuncoesPixAutcom.RetornaDadosRequisicaoCaixa(cdsTmpResumoCaixa,
                                                                                 fStrToFloat(edtOrdRec.Text),
                                                                                 edtCodCli.Text);

      LCodigoCliente := edtCodCli.Text;
      LChaveDuplicata := TFuncoesPixAutcom.RetornaChaveDaDuplicata(cdsTmpResumoCaixa, Self.Caption);

      LDadosPagamento := 'Pagamento referente a baixa de duplicatas';
    End
    Else
    Begin
      LCodigoCliente := EmptyStr;

      LDadosPagamento := 'Pagamento referente a ';
      If strEspdoc.Equals('CC') Then
      Begin
        LCodigoCliente := strCliCco;
        LDadosPagamento :=  LDadosPagamento + 'geração de crédito ao cliente'
      End
      Else
        LDadosPagamento :=  LDadosPagamento + 'lançamento de crédito';

      LChaveDuplicata := Concat(edtNumDoc.Text, '-' ,
                                strEspDoc, '-A-',
                                VS_strCodEmp,
                                '|001 duplicata(s)|',
                                Self.Caption);

      LDadosRequisicaoPixAVista := TFuncoesPixAutcom.RetornaDadosRequisicaoCaixa(LDadosPagamento,
                                                                                 fStrToFloat(edtOrdRec.Text),
                                                                                 LCodigoCliente);
    End;

    LDadosRequisicaoPixAVista.TextoItemShipay := LDadosPagamento;
    LDadosRequisicaoPixAVista.UtilizaShipay := TPixDao.ChavePixUtilizaShipay(FAutoIncremChavePix);
    LDadosRequisicaoPixAVista.UtilizaTefScope := TPixDao.ChavePixUtilizaTefScope(FAutoIncremChavePix);
    LDadosRequisicaoPixAVista.TipoCobranca := 'instantanea';

    FDadosPixRequisicao := TFuncoesPix.RetornaJsonDadosRequisicao(LDadosRequisicaoPixAVista);

    LRetornoPix := TFuncoesPixAutcom.PagarPixViaQRCodeGerandoNovoPix(FAutoIncremChavePix,
                                                                     FDadosPixRequisicao,
                                                                     FDadosPixRecebimento,
                                                                     LCodigoCliente,
                                                                     False,
                                                                     LChaveDuplicata,
                                                                     fStrToFloat(edtValDoc.Text));

    LErro := TFuncoesPix.RetornaMensagemErroRequisicao(LRetornoPix);
    If Not LErro.IsEmpty Then
      Raise ExceptionAutcom.Create(LErro);

    FDadosPixRecebimento := LRetornoPix;

    FObjetoPixRecebimento := TFuncoesPix.RetornaDadosDoRetornoPixConsulta(LRetornoPix,
                                                                          FDadosPixRequisicao);

    If TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(FObjetoPixRecebimento) Then
    Begin
      edtOrdRec.Text := FormatFloat(',0.00', FObjetoPixRecebimento.ValorPago);
      edtOrdRec.Enabled := False;
      btnReceberPix.Enabled := False;

      chkPixAvulso.Enabled := False;
      chkPixAvulso.Checked := False;

      FObjetoPixRecebimento.JsonRetorno := FDadosPixRecebimento;
      FObjetoPixRecebimento.JSonRequisicao := FDadosPixRequisicao;
      FObjetoPixRecebimento.AutoIncremChavePix := FAutoIncremChavePix;
      FObjetoPixRecebimento.PlanoDeContas := fCfgSis('CTAPIX');
      If FObjetoPixRecebimento.PlanoDeContas.IsEmpty Then
        FObjetoPixRecebimento.PlanoDeContas := fCfgSis('CTATRA');
      FObjetoPixRecebimento.RecebidoPeloF11 := 'N';

      FObjetoPixRecebimento.CodigoDoCaixa := edtCodigoCaixa.Text;

      If FObjetoPixRecebimento.SolicitacaoPagador.IsEmpty Then
      Begin
        FObjetoPixRecebimento.SolicitacaoPagador := LDadosRequisicaoPixAVista.SolicitacaoPagador;
        FObjetoPixRecebimento.NomeDevedor := LDadosRequisicaoPixAVista.NomeDevedor;
        FObjetoPixRecebimento.CPFCNPJDevedor := LDadosRequisicaoPixAVista.CPFCNPJDevedor;
      End;
    End
    Else
    Begin
      fMensagem('ATENÇÃO', 'O recebimento do Pix por QR Code não foi realizado. ' + #13 + 'Assim o registro do Pix não foi gerado.', ['&Ok']);

      edtOrdRec.Text := '0,00';
      pCalculaVrRestante;
    End;
  Except
    On E: ExceptionAutcom Do
      Raise ExceptionAutcom.Create(E.Message);
  End;
end;

procedure TfrmRcxResumoCaixa.AdicionarDadosDasDuplicatas(
  var ALiberacao: TLiberacao);
  Var
    LDataset: TUniClientDataset;

    LTabela: TRegistroMsgLiberaTabela;

    LLinha: TLinhaMsgLibera;

    LTotalDuplicatas,
    LTotalRecebido: Double;
begin
  ALiberacao.objMsgLibera.pAddTexto('');

  If Not strEspdoc.IsEmpty Then
  Begin
    ALiberacao.objMsgLibera.pAddTexto('Inclusão de ' + strEspDoc + ' pelo Resumo de Caixa');
    ALiberacao.objMsgLibera.pAddTexto('Documento: ' + edtNumDoc.Text + 'A-' + strEspdoc + '-' + VS_strCodEmp);
    ALiberacao.objMsgLibera.pAddTexto('Valor do documento: ' + edtValDoc.Text);
    ALiberacao.objMsgLibera.pAddTexto('Valor do Pix: ' + edtOrdRec.Text);
    Exit;
  End;

  ALiberacao.objMsgLibera.pAddTexto('Valor do Pix: ' + edtOrdRec.Text);
  ALiberacao.objMsgLibera.pAddTexto('');

  LTotalDuplicatas := 0;
  LTotalRecebido := 0;

  LTabela := TRegistroMsgLiberaTabela.Create;
  LLinha  := TLinhaMsgLibera.Create;
  LLinha.enuTipoLinha := tlCabecalho;
  LLinha.pAddColuna(''  , 'TÍTULO'    , 24 , alEsquerda , teAutcom);
  LLinha.pAddColuna(''  , 'DT.CAD.'   , 11 , alCentro   , teAutcom);
  LLinha.pAddColuna(''  , 'DT.VENC.'  , 11 , alCentro   , teAutcom);
  LLinha.pAddColuna(''  , 'CLIENTE'   , 39 , alEsquerda , teAutcom);
  LLinha.pAddColuna(''  , 'VR.TÍTULO' , 21 , alDireita  , teAutcom);
  LLinha.pAddColuna(''  , 'VR.RECEB.' , 21 , alDireita  , teAutcom);
  LTabela.lstLinhas.Add(LLinha);

  LDataset := fCriaClientDatSet(cdsTmpResumoCaixa);
  LDataset.Filter := 'CTR_MARDES=''M'' ';
  LDataset.Filtered := True;

  LDataset.First;
  While Not LDataset.Eof Do
  Begin
    LLinha  := TLinhaMsgLibera.Create;
    LLinha.enuTipoLinha := tlValor;
    LLinha.pAddColuna('TÍTULO'    ,  LDataset.FieldByName('CTR_NUMDUP').AsString +
                                     LDataset.FieldByName('CTR_PARCEL').AsString + '-' +
                                     LDataset.FieldByName('CTR_ESPDOC').AsString + '-' +
                                     LDataset.FieldByName('CTR_CODEMP').AsString                                 , 24 , alEsquerda);
    LLinha.pAddColuna('DT.CAD.'   ,  FormatDateTime('dd/MM/yyyy', LDataset.FieldByName('CTR_DTACAD').AsDateTime) , 11 , alCentro  );
    LLinha.pAddColuna('DT.VENC.'  ,  FormatDateTime('dd/MM/yyyy', LDataset.FieldByName('CTR_DTAVEN').AsDateTime) , 11 , alCentro  );
    if (POS(LDataset.FieldByName('CTR_CODCLI').AsString, LDataset.FieldByName('CTR_NOMCLI').AsString) <= 0) then
      LLinha.pAddColuna('CLIENTE' ,  LDataset.FieldByName('CTR_CODCLI').AsString + '-' +
                                     LDataset.FieldByName('CTR_NOMCLI').AsString                                 , 39 , alEsquerda)
    else
      LLinha.pAddColuna('CLIENTE' ,  LDataset.FieldByName('CTR_NOMCLI').AsString                                 , 39 , alEsquerda);

    LLinha.pAddColuna('VR.TÍTULO' ,  FormatFloat('#,##0.00', LDataset.FieldByName('CTR_VALDUP').AsFloat)         , 21 , alDireita );
    LLinha.pAddColuna('VR.RECEB.' ,  FormatFloat('#,##0.00', LDataset.FieldByName('CTR_VALREC').AsFloat)         , 21 , alDireita );
    LTabela.lstLinhas.Add(LLinha);

    LTotalDuplicatas := LTotalDuplicatas + fFormataFloat(LDataset.FieldByName('CTR_VALDUP').AsFloat, 2);
    LTotalRecebido := LTotalRecebido + fFormataFloat(LDataset.FieldByName('CTR_VALREC').AsFloat, 2);

    LDataset.Next;
  End;

  LLinha  := TLinhaMsgLibera.Create;
  LLinha.enuTipoLinha := tlTotal;
  LLinha.pAddColuna(''          , 'TOTAIS'                                 , 91, alDireita, teAutcom);
  LLinha.pAddColuna('Descrição' , FormatFloat('#,##0.00', LTotalDuplicatas), 21, alDireita, teAmbos);
  LLinha.pAddColuna('Descrição' , FormatFloat('#,##0.00', LTotalRecebido)  , 21, alDireita, teAmbos);
  LTabela.lstLinhas.Add(LLinha);

  ALiberacao.objMsgLibera.lstRegistros.Add(LTabela);
end;

function TfrmRcxResumoCaixa.AnalisaFechamentoOperadoresCaixaZerado: Boolean;
  Var
    LConsulta: TUniQuery;

    LSQL: String;

    LFator: Integer;
Begin
  Result := False;

  Try
    LConsulta := fCriaQuery;

    LSQL := '';
    LSQL := LSQL + 'SELECT                      ';
    LSQL := LSQL + '  RCX_CODOPE AS CODOPE,     ';
    LSQL := LSQL + '  SUM(RCX_DINREC) AS VALDIN ';
    LSQL := LSQL + 'FROM                        ';
    LSQL := LSQL + '  CADRCXX                   ';
    LSQL := LSQL + 'WHERE                       ';
    LSQL := LSQL + '  RCX_DTACAD = :DTACAI AND  ';
    LSQL := LSQL + '  RCX_CODEMP = :CODEMP AND  ';
    LSQL := LSQL + '  RCX_ESPDOC <> "FC"        ';
    LSQL := LSQL + 'GROUP BY RCX_CODOPE         ';

    Try
      LConsulta.SQL.Text := LSQL;
      LConsulta.ParamByName('DTACAI').AsDateTime := dtaDtaCai;
      LConsulta.ParamByName('CODEMP').AsString   := VS_strCodEmp;
      LConsulta.Open;

      While Not LConsulta.Eof Do
      Begin
        If fFormataFloat(Abs(LConsulta.FieldByName('VALDIN').AsFloat),2) <> 0.00 Then
        Begin

          LFator := 1;
          If fFormataFloat(LConsulta.FieldByName('VALDIN').AsFloat,2) > 0 Then
            LFator := -1;

          If Not fGravaCadRcx(strSeqRcx,
                             '',                                                     // Cliente
                             LConsulta.FieldByName('CODOPE').AsString,               // Operador
                             '',                                                     // Documento
                             IIF(fFormataFloat(LConsulta.FieldByName('VALDIN').AsFloat,2) > 0, 'LD', 'LC'), // Espécie
                             VS_strCodEmp,                                           // Empresa
                             dtaDtaCai,                                              // Data de Cadastro
                             fTime(),                                                // Hora de Cadastro
                             '',                                                     // Duplicata
                             '',                                                     // Parcela
                             'ACERTO AUT. DIFERENÇA FECHAMENTO CAIXA',               // Descrição
                             '',                                                     // Juros / Desconto
                             '',                                                     // Identificação de Fechamento
                             '',                                                     // Formade Pagamento
                             Abs(LConsulta.FieldByName('VALDIN').AsFloat) * LFator,  // Valor do Documento
                             0.0,                                                    // Valor do Desconto
                             0.0,                                                    // Valor do Juros
                             Abs(LConsulta.FieldByName('VALDIN').AsFloat) * LFator,  // Dinheiro recebido
                             0.0,                                                    // Cheque a vista
                             0.0,                                                    // Cheque pre datado
                             0.0,                                                    // Valor em Cartão
                             0.0,                                                    // Valor em Ordem de Pagamento
                             0.0,                                                    // Valor do Crédito
                             0.0,                                                    // Valor em Financiamento
                             0.0,                                                    // Valor de outros
                             0.0,                                                    // Venda a prazo
                             '',                                                     // Num. do Romaneio
                             0,                                                      // Sequencial de Controle
                             0,                                                      // Sequencial de Baixa (Duplicata)
                             fCfgSisL('SQFCRX'),                                     // Sequencial de Fechamento parcial de caixa
                             '',                                                     // Empresa da duplicata
                             '',                                                     // Motivo do desconto
                             2,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             'N',
                             '',
                             EmptyStr,
                             '',
                             0.00,
                             False,
                             0.00,
                             '',
                             0,
                             'N',
                             0,
                             '',
                             True) Then
          Begin
            Raise Exception.Create('Não foi possível fazer o acerto do caixa! Favor entrar em contato com a Citel!');
            Break;
          End;

        End;

        LConsulta.Next;
      End;

      Result := True;
    Finally
      LConsulta.Close;

      FreeAndNil(LConsulta);
    End;

  Except
    On E: Exception Do
      Raise E;
  End;
end;

procedure TfrmRcxResumoCaixa.btnAbreGavetaClick(Sender: TObject);
  Var
    strPatIni: String;
    strCodEcf: String;
    strModEcf: String;
    strPorta : String;
    strCodErr: String;
    ecfFiscal: TUntFiscal;
begin
  inherited;
  log('Apertou F12');

  if fCfgSis('AB2GAV') = 'S' then
  begin
    pAbrirGavetaImpressoraNaoFiscal ;
  end
  else If (fCfgSis('USNFCE') = 'S') Or fUsaSat Then
  Begin
    pAbrirGavetaNFCeSAT(fLerImpressora, fLerImpConfGaveta);
  End
  Else
  Begin
    strPatIni := fCfgSis('DIRINI');
    strCodEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA'   , '', strPatIni + '/opcoes_fiscal.ini' );
    strModEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'MODELO'       , '', strPatIni + '/opcoes_fiscal.ini' );
    strPorta  := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'PORTA'        , '', strPatIni + '/opcoes_fiscal.ini' );

    ecfFiscal := TUntFiscal.Create;

    If Not ecfFiscal.pSetModEcf( strModEcf ) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não foi possivel setar o Modelo da Impressora Fiscal ao tentar abrir a Gaveta. Verifique o Modelo Configurado!', ['&Ok']);
    End
    Else If Not ecfFiscal.fIniciaEcf( strCodErr, strPatIni, strPorta ) Then
    Begin
      fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
    End
    Else If Not ecfFiscal.fRetImpLigada( strCodErr ) Then
    Begin
      fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
    End
    {*******************************************}
    {* ABRE GAVETA                             *}
    {****************************************MV*}
    Else If (Not ecfFiscal.fAbreGaveta(strCodErr)) Then
    Begin
      fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
    End;

    ecfFiscal.fFinalizaEcf( strCodErr );
    ecfFiscal.Free;
  End;
end;

procedure TfrmRcxResumoCaixa.edtRomaneioKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryConGen : TUniQuery;
    arrSel    : TConsultasArray;

begin
  inherited;

  qryConGen := fCriaQuery;

  If fPesqRomaneio(Self, edtRomaneio, qryConGen, Key, arrSel, 'CADREC') Then
  Begin
    SelectNext(ActiveControl, True, True);
  End;

  FreeAndNil(qryConGen)
end;

procedure TfrmRcxResumoCaixa.edtRomaneioExit(Sender: TObject);
begin
  inherited;

  If (Not fEmptyStr(edtRomaneio.Text)) Then
  Begin

    If (Not fRomaneioExiste(edtRomaneio.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse romaneio não está cadastrado!', ['&Ok']);
      pSetFocus(edtRomaneio);
      Exit;
    End;

  End;

end;

procedure TfrmRcxResumoCaixa.edtRomaneioChange(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtRomaneio.Text) Then
  Begin
    mskDtaIni.Text := '';
    mskDtaFin.Text := '';
  End
  Else
  Begin
    mskDtaIni.Date := VS_Date;
    mskDtaFin.Date := VS_Date;
  End;

end;

procedure TfrmRcxResumoCaixa.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRcxResumoCaixa.edtCodRedKeyPress(Sender: TObject; var Key: Char);
var
    arrSel: TConsultasArray;
begin
  If (fPesqRedeLojas(Self, edtCodRed, edtDescRed, Nil, Key, arrSel)) then
  Begin
    If fValidaCampos(edtCodRed, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRcxResumoCaixa.edtCodEmpExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodEmp.Text) Then
    edtDesEmp.Text := 'TODOS'
  Else
    edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

  If fEmptyStr(edtDesEmp.Text) And (Not fEmptyStr(edtCodEmp.Text))  Then
  Begin
    fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
    edtCodEmp.Clear;
    pSetFocus(edtCodEmp);
  End
  Else If Not ValidarEmpresaAcesso Then
  Begin
    fMensagem('ATENÇÃO!', 'Operador sem permissão de acesso a essa empresa!', ['&Ok']);
    edtCodEmp.Clear;
    pSetFocus(edtCodEmp);
  End;
end;

{******************************************************}
{* ATENÇÃO: NO FATURAMENTO TAMBÉM TEM UMA TRAVA DESTA *}
{***************************************************AF*}
function TfrmRcxResumoCaixa.fGravaLogControle(Var strMsgDif: String; const intSeqCon: Integer; blnAnalisar: Boolean = False): Boolean;
  Var
    txtArq: TextFile;
begin

  Result := fGravouCaixaCorreto(strMsgDif, intSeqCon);

  If (Not Result) And (Not blnAnalisar) Then
  Begin

    fMensagem('>>>>>> ATENÇÃO <<<<<<', 'Houve uma inconsistência na gravação dos dados do Resumo de Caixa.' + #13#10 +
                                       'Por favor, entre em contato com a Citel imediatamente.', ['&Ok']);

    AssignFile(txtArq, 'RCX' + IntToStr(intSeqCon) + '.txt');
    Rewrite(txtArq);
    WriteLn(txtArq, 'MODALIDADE: ' + IIF(pgcDadosGerais.ActivePage = tbsRecebimentos, 'RECEBIMENTO', strEspDoc));
    WriteLn(txtArq, '');
    WriteLn(txtArq, 'edtValDoc');
    WriteLn(txtArq, 'Text = ' + edtValDoc.Text);
    WriteLn(txtArq, 'ReadOnly = ' + IIF(edtValDoc.ReadOnly, 'True', 'False'));
    WriteLn(txtArq, 'Habilitado = ' + IIF(edtValDoc.Enabled, 'True', 'False'));
    WriteLn(txtArq, '');
    WriteLn(txtArq, 'edtDinRec');
    WriteLn(txtArq, 'Text = ' + edtDinRec.Text);
    WriteLn(txtArq, 'ReadOnly = ' + IIF(edtDinRec.ReadOnly, 'True', 'False'));
    WriteLn(txtArq, 'Habilitado = ' + IIF(edtDinRec.Enabled, 'True', 'False'));

    WriteLn(txtArq, 'edtCarRec');
    WriteLn(txtArq, 'Text = ' + edtCarRec.Text);
    WriteLn(txtArq, 'ReadOnly = ' + IIF(edtCarRec.ReadOnly, 'True', 'False'));
    WriteLn(txtArq, 'Habilitado = ' + IIF(edtCarRec.Enabled, 'True', 'False'));

    WriteLn(txtArq, 'edtChqRec');
    WriteLn(txtArq, 'Text = ' + edtChqRec.Text);
    WriteLn(txtArq, 'ReadOnly = ' + IIF(edtChqRec.ReadOnly, 'True', 'False'));
    WriteLn(txtArq, 'Habilitado = ' + IIF(edtChqRec.Enabled, 'True', 'False'));

    WriteLn(txtArq, 'edtChqPre');
    WriteLn(txtArq, 'Text = ' + edtChqPre.Text);
    WriteLn(txtArq, 'ReadOnly = ' + IIF(edtChqPre.ReadOnly, 'True', 'False'));
    WriteLn(txtArq, 'Habilitado = ' + IIF(edtChqPre.Enabled, 'True', 'False'));

    WriteLn(txtArq, 'edtOrdRec');
    WriteLn(txtArq, 'Text = ' + edtOrdRec.Text);
    WriteLn(txtArq, 'ReadOnly = ' + IIF(edtOrdRec.ReadOnly, 'True', 'False'));
    WriteLn(txtArq, 'Habilitado = ' + IIF(edtOrdRec.Enabled, 'True', 'False'));

    WriteLn(txtArq, 'edtFinanc');
    WriteLn(txtArq, 'Text = ' + edtFinanc.Text);
    WriteLn(txtArq, 'ReadOnly = ' + IIF(edtFinanc.ReadOnly, 'True', 'False'));
    WriteLn(txtArq, 'Habilitado = ' + IIF(edtFinanc.Enabled, 'True', 'False'));

    WriteLn(txtArq, 'edtValJur');
    WriteLn(txtArq, 'Text = ' + edtValJur.Text);
    WriteLn(txtArq, 'ReadOnly = ' + IIF(edtValJur.ReadOnly, 'True', 'False'));
    WriteLn(txtArq, 'Habilitado = ' + IIF(edtValJur.Enabled, 'True', 'False'));

    WriteLn(txtArq, 'edtValDes');
    WriteLn(txtArq, 'Text = ' + edtValDes.Text);
    WriteLn(txtArq, 'ReadOnly = ' + IIF(edtValDes.ReadOnly, 'True', 'False'));
    WriteLn(txtArq, 'Habilitado = ' + IIF(edtValDes.Enabled, 'True', 'False'));

    WriteLn(txtArq, 'edtTroco');
    WriteLn(txtArq, 'Text = ' + edtTroco.Text);
    WriteLn(txtArq, 'ReadOnly = ' + IIF(edtTroco.ReadOnly, 'True', 'False'));
    WriteLn(txtArq, 'Habilitado = ' + IIF(edtTroco.Enabled, 'True', 'False'));
    Flush(txtArq);
    CloseFile(txtArq);
  End;

end;

procedure TfrmRcxResumoCaixa.edtTrocoChange(Sender: TObject);
begin
  inherited;
  Try
    If fStrToFloat(edtTroco.Text) > 0 Then
    Begin
      edtTroco.Color := $008080FF;
    End
    Else Begin
      edtTroco.Color := $00FFDFB8;
    End;
  Except

  End;
end;

function TfrmRcxResumoCaixa.EstaRealizandoRecebimentoF1F2: Boolean;
begin
  Result := Not fEmptyStr(edtValDoc.Text);
  If Result Then
    Result := fFormataFloat(fStrToFloat(edtValDoc.Text), 2) <> 0.00;

  If Not Result Then
    Result := fFormataFloat(fStrToFloat(edtDinRec.Text) +
                            fStrToFloat(edtCarrec.Text) +
                            fStrToFloat(edtOrdRec.Text) +
                            fStrToFloat(edtChqRec.Text) +
                            fStrToFloat(edtChqPre.Text) +
                            fStrToFloat(edtFinanc.Text), 2) <> 0.00;

  If Result Then
    fMensagem('ATENÇÃO', 'Para utilizar essa função, é necessário confirmar ou cancelar o recebimento atual.', ['&Ok']);
end;

function TfrmRcxResumoCaixa.ExisteSaldoVinculadoATransferir: Boolean;
begin
  Result := False;

  If Not objResumoDeCaixa.TransferenciaVinculada Then
    Exit;

  If objResumoDeCaixa.fRetornaSaldoCaixaCampo('RCX_CHQAVI', edtCodigoCaixa.Text) > 0 Then
    Exit(True);

  If objResumoDeCaixa.fRetornaSaldoCaixaCampo('RCX_CHQPRE', edtCodigoCaixa.Text) > 0 Then
    Exit(True);

  If objResumoDeCaixa.fRetornaSaldoCaixaCampo('RCX_CARREC', edtCodigoCaixa.Text) > 0 Then
    Exit(True);
end;

function TfrmRcxResumoCaixa.VerificarSeExisteSaldoVinculadoATransferirAntesDoFechamento: Boolean;
Begin
  Result := False;

  if ExisteSaldoVinculadoATransferir Then
  Begin
    If (objResumoDeCaixa.TransferenciaCega) Then
      pMensagemOk('O caixa atual possui saldo em cheque ou cartão de um ou mais operadores para ser transferido. ' +
                  'Portanto não será permitido realizar o fechamento enquanto não forem ' +
                  'transferidos os cheques e os cartões pendentes.')
    Else
    Begin
      pMensagemOk('O caixa atual possui saldo em cheque e cartão' +
                  '. Nesse caso não será permitido realizar o fechamento enquanto não forem ' +
                  'transferidos os cheques e cartões pendentes.' + #13 +
                  ' A seguir serão listados os operadores ' +
                  'e saldos em cartão, cheque à vista e cheque-pré pendentes.');
      pMostraOperadoresESaldosPendentes;
    End;
    Exit(True);
  End;
End;

procedure TfrmRcxResumoCaixa.log(s: String);
begin
//  stlLog.Add(DateToStr(VS_Date) + ' ' + TimeToStr(fTime()) + ' ' + s);
end;

{********************************************}
{* VERIFICA SE OS CARTÕES ESTÃO CADASTRADOS *}
{*****************************************AF*}
function TfrmRcxResumoCaixa.fCartoesCadastrados(fltValor: Double): Boolean;
  Var
    intContador: Integer;
    fltValTot  : Double;
Begin

  Result    := False;
  fltValTot := 0;

  For intContador := 0 To Length(arrCartoes) -1 Do
    fltValTot := fltValTot + arrCartoes[intContador].fltValDig;

  If fFormataFloat(fltValTot,2) = fFormataFloat(fltValor,2) Then
    Result := True;

End;

procedure TfrmRcxResumoCaixa.btnLeituraXClick(Sender: TObject);
begin
  inherited;
  pLeituraX;
end;

procedure TfrmRcxResumoCaixa.btnLiberacaoClick(Sender: TObject);
begin
  inherited;

  If (Not btnLiberacao.Visible) Then
    Exit;

  pCriarForm(TfrmRcxLiberacaoExpedicao, frmRcxLiberacaoExpedicao);
end;

procedure TfrmRcxResumoCaixa.btnEntFutCDClick(Sender: TObject);
Var
  frmFatEmitirEntFutEmpCDAux : TfrmFatEmitirEntFutEmpCD;
begin
  inherited;

  If Not btnEntFutCD.Visible Then
    Exit;

  If Not TfrmFatEmitirEntFutEmpCD.fTemPedidosEntFuturaParaFaturarEmpCD Then
  Begin
    pMensagemOk('Não existem pedidos de entrega futura pelo CD para serem faturados!');
    Exit;
  End;

  If Not fVerificaAcessoSistema('DIRRCXPEF', edtCodOpe.Text) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Entrega Futura pelo CD (Resumo de Caixa)');

    objLiberacao.strDirAce := 'DIRRCXPEF';
    objLiberacao.strMsgSen := 'Ent. Futura CD';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := edtCodOpe.Text;
    objLiberacao.strCodDig := edtCodOpe.Text;

    If (Not objLiberacao.fLibera) Then
    Begin
      Exit;
    End;
  End;

  pCriarFormularios(TfrmFatEmitirEntFutEmpCD, frmFatEmitirEntFutEmpCDAux);

  Try
    frmFatEmitirEntFutEmpCDAux.strCodigoCaixa := edtCodigoCaixa.Text;
    frmFatEmitirEntFutEmpCDAux.ShowModal;
  Finally
    pFreeAndNil(frmFatEmitirEntFutEmpCDAux);
  End;
end;

procedure TfrmRcxResumoCaixa.btnEstornoClick(Sender: TObject);
  Var
    frmEstornoReceber : TfrmEstornoReceber;
begin
  inherited;

  If EstaRealizandoRecebimentoF1F2 Then
    Exit;

  Try
    pCriarFormularios(TfrmEstornoReceber, frmEstornoReceber);
    frmEstornoReceber.blnResCai := True;
    frmEstornoReceber.strCodOpe := edtCodOpe.Text;
    frmEstornoReceber.dtaDtaRcx := dtaDtaCai;

    frmEstornoReceber.strCodigoCaixa   := edtCodigoCaixa.Text;
    frmEstornoReceber.objResumoDeCaixa := objResumoDeCaixa;
    frmEstornoReceber.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmRcxResumoCaixa.btnEstornoClick]');
    End;
  End;
  pFreeAndNil(frmEstornoReceber);

end;

procedure TfrmRcxResumoCaixa.btnImprDAVClick(Sender: TObject);
  Var
    strEspDav: String;
    intOpcMsg: Integer;
begin
  inherited;
  If Not btnImprDAV.Visible Then
    Exit;

  Try
    strEspDav := fCfgSis('ESPDAV');

    If fEmptyStr(strEspDav) Then
    Begin
      intOpcMsg := fMensagem('', 'Escolha a espécie:', ['ORÇAMENTO', 'PEDIDO']);
      strEspDoc := IIF(intOpcMsg = 1, 'OR', 'PD');
    End
    Else
      strEspDoc := strEspDav;

    pCriarFormularios(TfrmRcxDocumentosDAV, frmRcxDocumentosDAV);
    frmRcxDocumentosDAV.strEspDoc := strEspDoc;
    frmRcxDocumentosDAV.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[btnImprDAVClick]');
  End;

  strEspDoc := '';  
  pFreeAndNil(frmRcxDocumentosDAV);
end;

procedure TfrmRcxResumoCaixa.btnInfDocClick(Sender: TObject);
begin
  inherited;

  If EstaRealizandoRecebimentoF1F2 Then
    Exit;

  If Not fVerificaAcessoSistema('DIRRCXIFD', edtCodOpe.Text) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Informar Documento (Resumo de Caixa)');

    objLiberacao.strDirAce := 'DIRRCXIFD';
    objLiberacao.strSenLib := fCfgSis('RCXIFD');
    objLiberacao.strMsgSen := 'Informar Documento';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := edtCodOpe.Text;
    objLiberacao.strCodDig := edtCodOpe.Text;

    If (Not objLiberacao.fLibera) Then
    Begin
      Exit;
    End;

  End;             

  Try
    pCriarFormularios(TfrmRcxDigDocumento, frmRcxDigDocumento);

    frmRcxDigDocumento.btnDocsAviOriLoj.Visible := fVerificaAcessoSistema('DIRRCXIFDF1', edtCodOpe.Text);

    If frmRcxDigDocumento.ShowModal = mrOk Then
    Begin
      Try
        If fChamaTelaDocumentos(frmRcxDigDocumento.edtCodEmp.Text,
                                frmRcxDigDocumento.edtNumDoc.Text,
                                frmRcxDigDocumento.edtEspDoc.Text,
                                False,
                                frmRcxDigDocumento.blnDocsAVistaOrigLoja) Then
        Begin
          pPosChamaTelaDocumentos;
        End;
      Except
        pZeraVariaveisResumo;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmRcxResumoCaixa.btnInfDocClick]');
    End;
  End;

  pFreeAndNil(frmRcxDigDocumento);

end;

function TfrmRcxResumoCaixa.fDireitoAcessoLancamentos(
  strEspDoc, strDesOpc: String): Boolean;
begin
  Result := fVerificaAcessoSistema('DIRRCX' + strEspDoc, edtCodOpe.Text);

  {*****************************************}
  {* CASO O OPERADOR ATUAL NÃO TENHA DIREI-*}
  {* TO, PEDE SENHA. *}
  {**************************************MV*}
  If (Not Result) And (Not fEmptyStr(fCfgSis('SELCRC'))) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto(strDesOpc);

    objLiberacao.strDirAce := 'DIRRCX' + strEspDoc;
    objLiberacao.strSenLib := fCfgSis('SELCRC');
    objLiberacao.strMsgSen := strDesOpc;
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := edtCodOpe.Text;
    objLiberacao.strCodDig := edtCodOpe.Text;

    If (Not objLiberacao.fLibera) Then
    Begin
      Result := False;
    End
    Else
      Result := True;

  End;
end;

function TfrmRcxResumoCaixa.fDocumentoExiste(strNomeTabela,
  strAutoInc: String): Boolean;
Var
  qryPesq: TUniQuery;
begin
  qryPesq := fCriaQuery();
  Try
    With qryPesq Do
    Begin
      SQL.Text := 'SELECT * FROM ' + strNomeTabela + ' WHERE AUTOINCREM = :AUTOINC';
      ParamByName('AUTOINC').AsString := strAutoInc;
      Open;

      Result := Not IsEmpty;
    End;
  Finally
    FreeAndNil(qryPesq);
  End;
end;

procedure TfrmRcxResumoCaixa.pVoltaSeqFechamentoParcial;
  Var
    qryAux: TUniQuery;
    intSeqFec: Integer;
begin
  qryAux := fCriaQuery(Nil);

  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  MAX(RCX_SQFCRX) AS MAIOR ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  CADRCXX ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  RCX_DTACAD = :DTACAD ');

  qryAux.ParamByName('DTACAD').AsDateTime := dtaDtaCai;
  qryAux.Open;

  intSeqFec := qryAux.FieldByName('MAIOR').AsInteger;

  qryAux.Close;
  FreeAndNIl(qryAux);

  fAtuCfgSis('SQFCRX', IntToStr(intSeqFec));
end;

procedure TfrmRcxResumoCaixa.btnConfOrcamentosClick(Sender: TObject);
begin
  inherited;
  If Not blnF11 Then
  Begin
    If EstaRealizandoRecebimentoF1F2 Then
      Exit;

    TfrmGravando.fExecutarModal(pExecutarConfOrcamentos, 'Aguarde, Executando [F11] ...', '');
  End;
end;

procedure TfrmRcxResumoCaixa.pExecutarConfOrcamentos;
  Var
    dtaDtaLan: TDateTime;
    blnApenasPrazo: Boolean;
    frmFatConfOrcamentos : TfrmFatConfOrcamentos;

  function fTravaCaixa : Boolean;
    var
      objTravaCaixa : TTravaCaixa;
      strNomeTrava  : String;
  begin
    strNomeTrava := 'RCXF7_' + VS_strCodEmp;

    If (fCfgSis('TPFCCX') = 'T') And
       (Not objLock.fLock_Unlock(strNomeTrava, True, False)) Then
    Begin
      pMensagemOk(objLock.fParseMensagemTrava(strNomeTrava,
                                              'O fechamento do caixa da empresa #EMP_CODEMP está sendo '+
                                              'feito pelo operador #LCK_CODOPE - #OPE_NOMOPE e '+
                                              'por isso, o F11 não pode ser utilizado. Entre em '+
                                              'contato com esse operador e depois, tente novamente.'));
      Exit(True);
    End
    Else
      objLock.fLock_Unlock(strNomeTrava, False);

    Result := False;

    blnApenasPrazo := False;
    objTravaCaixa  := TTravaCaixa.New('', False, dtaDtaCai, edtCodigoCaixa.Text);

    Try

      If (objTravaCaixa.blnTravar) Then
        Exit(True);

      blnApenasPrazo := objTravaCaixa.blnApenasEmissaoDeDocumentosAPrazo;

      If (fCfgSis('USAFPG', varBoolean)) And
         (fCfgSis('USARCX', varBoolean)) And
         (Not objResumoDeCaixa.fNecessitaFecharCaixa(True, dtaDtaLan, edtCodigoCaixa.Text)) Then
        Exit(True);

    Finally
      FreeAndNil(objTravaCaixa);
    End;

  end;

begin
  inherited;

  If Not fVerificaAcessoSistema('RCXF11', edtCodOpe.Text) Then
  Begin
    fMensagem('', 'Você não tem direitos para acessar Confirmação de Orçamentos!', ['&Ok']);
    Exit;
  End;

  If fTravaAliquota Then
    Exit;

  If fTravaCaixa Then
    Exit;

  {**************************************}
  {* VALIDAÇÕES DE FORMAS DE PAGAMENTO  *}
  {* ESTÃO NO FORMCREATE. PASSADO ASSIM *}
  {* PARA VALIDAR A CHAVE PIX DO CAIXA  *}
  {***********************************AJ*}
  VS_CodigoCaixaF11 := edtCodigoCaixa.Text;
  pCriarFormularios(TfrmFatConfOrcamentos, frmFatConfOrcamentos);
  Try
    Try

      frmFatConfOrcamentos.strCodOpe        := edtCodOpe.Text;
      frmFatConfOrcamentos.blnApenasPrazo   := blnApenasPrazo;
      frmFatConfOrcamentos.strCodigoCaixa   := edtCodigoCaixa.Text;
      frmFatConfOrcamentos.objResumoDeCaixa := objResumoDeCaixa;
      {********************************************************}
      { Se estiver configurado para alterar/faturar orçamentos }
      { de outras lojas                                        }
      {*****************************************************RV*}
      If (fCfgSis('ALTLOJ') = 'S') Then
      Begin
        frmFatConfOrcamentos.edtCodEmp.Visible := True;
        frmFatConfOrcamentos.edtCodEmp.Text    := VS_strCodEmp;

        If (fCfgSis('EMPF11') = EMPRESA_EM_BRANCO) Then
          frmFatConfOrcamentos.edtCodEmp.Clear;
      End;

      frmFatConfOrcamentos.ShowModal;

      Self.Visible := True;

      pSetaEmpresaLogada(strEmpSav);

      {****************************************************}
      { Se estiver configurado para fechar automaticamente }
      {*************************************************RV*}
      If fCfgSis('F11SAI', varBoolean) Then
      Begin
        If (frmFatConfOrcamentos.ModalResult = mrOk) Then
          Close;
      End;
    Except
      On E: Exception Do
      Begin
        pSetaEmpresaLogada(strEmpSav);
        pMensagensErro(E.Message, '[frmRcxResumoCaixa.btnConfOrcamentosClick]');
      End;
    End;
  Finally
    pFreeAndNil(frmFatConfOrcamentos);
  End;

  {***************************************************************************}
  {* TENTATIVA DE EVITAR O ERRO AO CRIAR O FORMULARIO "frmFatConfOrcamentos" *}
  {***************************************************************************}
  {* A component named frmFatConfOrcamentos already exists EComponentError.  *}
  {***********************************************************************JC**}
  While Assigned(frmFatConfOrcamentos) Do
  Begin
    Application.ProcessMessages;
    Sleep(500);
  End;

  pSetaEmpresaLogada(strEmpSav);
end;

procedure TfrmRcxResumoCaixa.btnTitRecClick(Sender: TObject);
begin
  inherited;
  If Not btnTitRec.Visible Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
    prcExecutaRelatorio(5, 393, [393,394,395,396,397,398,399,400,401,402,403,404,405],
                        [],
                        [],
                        Sender);
end;

function TfrmRcxResumoCaixa.CalculaValorRestante: Double;
begin
  Result := fStrToFloat(edtValDoc.Text);
  Result := Result - fStrToFloat(edtDinRec.Text);
  Result := Result - fStrToFloat(edtCarRec.Text);
  Result := Result - fStrToFloat(edtOrdRec.Text);
  Result := Result - fStrToFloat(edtChqRec.Text);
  Result := Result - fStrToFloat(edtChqPre.Text);
  Result := Result - fStrToFloat(edtFinanc.Text);

  Result := fFormataFloat(Result, 2);
end;

procedure TfrmRcxResumoCaixa.chkPixAvulsoClick(Sender: TObject);
begin
  inherited;
  If Not btnReceberPix.Visible Then
    Exit;

  If Not chkPixAvulso.Enabled Then
    Exit;

  btnReceberPix.Enabled := Not chkPixAvulso.Checked;
end;

procedure TfrmRcxResumoCaixa.cxDateEdit1PropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

  If Error Then
    pMensagemOk('Data Invalida');

end;

function TfrmRcxResumoCaixa.DuplicataComissaoProfissional: Boolean;
begin
  If fltTotCre >= 0 Then
    Exit(False);

  If cdsTmpResumoCaixa.FieldByName('CTR_ESPDOC').AsString <> 'CC' Then
    Exit(False);

  Result := Not fEmptyStr(cdsTmpResumoCaixa.FieldByName('CTR_DOCDIV').AsString);
end;

function TfrmRcxResumoCaixa.fGravaReciboTransferencia(ASeqResumo, ACodEmp, ARecibo: String): Boolean;
Var
  LConsulta : TUniQuery;
  LFalhaInsertCADRCXX: Boolean;
begin
  Result := False;
  LConsulta := Nil;

  If fEmptyStr(ASeqResumo) Then
  Begin
    fRollback;
    fMensagem('Atenção', 'Erro ao tentar gravar registro de transferência, repita a operação!', ['&Ok']);
    Exit;
  End;

  Try
    LConsulta := fCriaQuery(Nil);
    Try
      LConsulta.SQL.Add('INSERT INTO CADRTF('+
                          'AUTOINCREM, '+
                          'RTF_SEQRCX, '+
                          'RTF_CODEMP, '+
                          'RTF_RECIBO, '+
                          'RTF_CODOPE, '+
                          'RTF_RCXCON) '+
                        'VALUES('+
                          ':AUTINC, '+
                          ':SEQRCX, '+
                          ':CODEMP, '+
                          ':RECIBO, '+
                          ':CODOPE, '+
                          ':RCXCON)');

      LConsulta.ParamByName('AUTINC').AsString := fRetAutoIncrem('CADRTF', VS_strCodEmp);
      LConsulta.ParamByName('SEQRCX').AsString := ASeqResumo;
      LConsulta.ParamByName('CODEMP').AsString := ACodEmp;
      LConsulta.ParamByName('RECIBO').AsString := ARecibo;
      LConsulta.ParamByName('CODOPE').AsString := edtCodOpe.Text;
      LConsulta.ParamByName('RCXCON').AsInteger := intSeqCon;
      LConsulta.ExecSQL;

      Result := True;
    Except
      On E: Exception Do
      Begin
        fRollback;

        LFalhaInsertCADRCXX := E.Message.ToLower.Contains('foreign key constraint fails') And
                               E.Message.ToLower.Contains('rtf_seqrcx');

        If LFalhaInsertCADRCXX Then
          fMensagem('Atenção', 'Erro ao tentar gravar registro de transferência, repita a operação!', ['&Ok'])
        Else
          pMensagensErro(E.Message, '[fGravaReciboTransferencia]');
      End;
    End;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TfrmRcxResumoCaixa.fSenhaSomenteCreditos(fltTotRec,
  fltTotCre: Double): Boolean;
  Var
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
begin

  Result := True;

  If (fltTotRec = 0.0) And (fltTotCre < 0.0) And (Not fEmptyStr(fCfgSis('SENDCL'))) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddSeparador(115);
    objLiberacao.objMsgLibera.pAddTexto('***  Devolução de dinheiro ao cliente  ***', alCentro, teAmbos, '', 115);

    objTabela := TRegistroMsgLiberaTabela.Create;
    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'TÍTULO'    , 20 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'DT.CAD.'   , 11 , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'DT.VENC.'  , 11 , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'CLIENTE'   , 39 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'VR.TÍTULO' , 23 , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    With cdsTmpResumoCaixa do
    Begin
      First;
      While Not Eof Do
      Begin
        If (FieldByName('CTR_MARDES').AsString = 'M') And
           (FieldByName('CTR_VALDUP').AsFloat < 0) Then
        Begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna('TÍTULO'    ,  FieldByName('CTR_NUMDUP').AsString + '-'
                                           + FieldByName('CTR_PARCEL').AsString + '-'
                                           + FieldByName('CTR_ESPDOC').AsString + '-'
                                           + FieldByName('CTR_CODEMP').AsString                                 , 20 , alEsquerda);
          objLinha.pAddColuna('DT.CAD.'   ,  FormatDateTime('dd/MM/yyyy', FieldByName('CTR_DTACAD').AsDateTime) , 11 , alCentro  );
          objLinha.pAddColuna('DT.VENC.'  ,  FormatDateTime('dd/MM/yyyy', FieldByName('CTR_DTAVEN').AsDateTime) , 11 , alCentro  );
          if (POS(FieldByName('CTR_CODCLI').AsString, FieldByName('CTR_NOMCLI').AsString) <= 0) then
            objLinha.pAddColuna('CLIENTE' ,  FieldByName('CTR_CODCLI').AsString + '-'
                                           + FieldByName('CTR_NOMCLI').AsString                                 , 39 , alEsquerda)

          else
            objLinha.pAddColuna('CLIENTE' ,  FieldByName('CTR_NOMCLI').AsString                                 , 39 , alEsquerda);

          objLinha.pAddColuna('VR.TÍTULO' ,  FormatFloat('#,##0.00', FieldByName('CTR_VALDUP').AsFloat)         , 23 , alDireita );
          objTabela.lstLinhas.Add(objLinha);
        End;
        Next;
      End;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlTotal;
      objLinha.pAddColuna(''          , 'TOTAL'                            , 87 , alDireita  , teAutcom);
      objLinha.pAddColuna('Descrição' , FormatFloat('#,##0.00', fltTotCre) , 23 , alDireita  , teAmbos);
      objTabela.lstLinhas.Add(objLinha);
    End;

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    objLiberacao.strDirAce := 'RCXDINCLI';
    objLiberacao.strSenLib := fCfgSis('SENDCL');
    objLiberacao.strMsgSen := 'Devolução de dinheiro ao cliente.';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := edtCodOpe.Text;
    objLiberacao.strCodDig := edtCodOpe.Text;
    objLiberacao.objMsgLibera.strTitulo := 'Devolução de dinheiro ao cliente.';


    If (Not objLiberacao.fLibera) Then
    Begin
      Result := False;
    End;
  End;
end;

function TfrmRcxResumoCaixa.fSomentePOS: Boolean;
var
  intContador: Integer;
begin
  For intContador := 0 To Length(arrCartoes) -1 Do
  begin
    if (arrCartoes[intContador].strTipCar <> 'POS') then
    begin
      Result := False;
      Exit;
    end;
  end;
  Result := True;
end;

procedure TfrmRcxResumoCaixa.pgcDadosGeraisChange(Sender: TObject);
begin
  inherited;

  (fValidaCampos(Self, True));
  pLimpaCampos;
end;

procedure TfrmRcxResumoCaixa.pgcDadosGeraisChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
  AllowChange := Not EstaRealizandoRecebimentoF1F2;
end;

procedure TfrmRcxResumoCaixa.btnEstornoPGClick(Sender: TObject);
  Var
    frmEstornoPagar : TfrmEstornoPagar;

    fltValorFechamento: Double;

    dtaDataFechamento: TDateTime;
 begin
   inherited;

  pRetornaUltimoFechamento(fltValorFechamento, dtaDataFechamento);

  If (strTipoFechamentoCaixa <> 'C') And (dtaDataFechamento = dtaDtaCai) Then
  Begin
    fMensagem('ATENÇÃO', 'O caixa do dia ' + FormatDateTime('dd/mm/yyyy', dtaDataFechamento) + ' já foi fechado!', ['&OK']);
    Exit;
  End;

  If EstaRealizandoRecebimentoF1F2 Then
    Exit;

  If Not fVerificaAcessoSistema('DIRRCXEPG', edtCodOpe.Text) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Estorno PG (Resumo de Caixa)');

    objLiberacao.strDirAce := 'DIRRCXEPG';
    objLiberacao.strSenLib := fCfgSis('RCXEPG');
    objLiberacao.strMsgSen := 'Estorno PG';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := edtCodOpe.Text;
    objLiberacao.strCodDig := edtCodOpe.Text;

    If (Not objLiberacao.fLibera) Then
    Begin
      Exit;
    End;

  End;

  Try
    pCriarFormularios(TfrmEstornoPagar, frmEstornoPagar);
    frmEstornoPagar.blnResCai := True;
    frmEstornoPagar.strOpeRcx := edtCodOpe.Text;
    frmEstornoPagar.dtaDtaCai := dtaDtaCai;
    frmEstornoPagar.strChamada := '[frmRcxResumoCaixa]';

    frmEstornoPagar.strCodigoCaixa   := edtCodigoCaixa.Text;
    frmEstornoPagar.objResumoDeCaixa := objResumoDeCaixa;

    frmEstornoPagar.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[frmRcxResumoCaixa.btnEstornoPGClick]');
  End;

  pFreeAndNil(frmEstornoPagar);

end;

procedure TfrmRcxResumoCaixa.edtCodCliExit(Sender: TObject);
begin
  inherited;
  (fValidaCampos(edtCodCli, True));
end;

{**************************************************}
{* IMPRESSAO DO RECIBO CUSTOMIZADO DO FAST REPORT *}
{***********************************************JU*}
function TfrmRcxResumoCaixa.fImprimeReciboLayout(arrCodCli: Array of TRcxDadosCliente;
                                                 intOpcao: Integer;
                                                 vltCreditoTroco: Double;
                                                 vltTotalRecebido: Double;
                                                 strNomFil: String = '';
                                                 strTipImp : String = ''): Boolean;
  Var
    intContador : Integer;
    intQtdVias  : Integer;
    intContVia  : Integer;
begin

  editorFast := TFastPrintFileEditor.Create(Nil);
  try
    If (Pos('PG', strEspDoc) <= 0) Then
    Begin
      If fCfgSis('RECCTR') = 'N' Then
      begin
        reciboCtr  := TReciboCtr.CreateInstance(cdsImpRec, vltCreditoTroco, vltTotalRecebido,cdsImpRecCG);
        editorFast.pSetFastPrintFile(reciboCtr);
        reciboCtr.pSetFastType(strTipImp);
      end
      else
      begin
        reciboCtrMeiaFolha  := TReciboCtrMeiaFolha.CreateInstance(cdsImpRec);
        editorFast.pSetFastPrintFile(reciboCtrMeiaFolha);
      end;

    End
    Else
    Begin

      intQtdVias := 1;
      If (fCfgSis('RECCTP') = 'S') And (fCfgSis('RECCPV', varInteger) > 1) Then
      Begin
        cdsImpPag  := fCriaClientDatasetReciboCTP_MF;
        intQtdVias := fCfgSis('RECCPV', varInteger);

        If (intQtdvias <= 0) Then
          intQtdVias := 1;
      End
      Else
        cdsImpPag  := fCriaClientDatasetReciboCTP;

      For intContVia := 1 To intQtdVias Do
      Begin
        With cdsImpRec do
        Begin
          First;
          While Not Eof Do
          Begin
            cdsImpPag.Insert;
            cdsImpPag.FieldByName('CTP_CODFOR').AsString   := FieldByName('CODCLI').AsString;
            cdsImpPag.FieldByName('CTP_DESCRI').AsString   := FieldByName('DESCRI').AsString;
            cdsImpPag.FieldByName('CTP_NOMCTA').AsString   := FieldByName('NOMCTA').AsString;
            cdsImpPag.FieldByName('CTP_CTABAI').ASString   := FieldByName('NOMCTA').AsString;
            cdsImpPag.FieldByName('CTP_NOMEVE').AsString   := FieldByName('NOMEVE').AsString;
            cdsImpPag.FieldByName('CTP_NOMFOR').AsString   := FieldByName('CODCLI').AsString +' - '+ fRetNomFornecedor(FieldByName('CODCLI').AsString);
            cdsImpPag.FieldByName('CTP_HIST01').AsString   := FieldByName('DESCRI').AsString;
            cdsImpPag.FieldByName('CTP_HISBAI').AsString   := 'REF. ' + IIF(Pos('LC', strEspDoc) > 0, 'LC.', 'PG.') +
                                                              ' RESUMO DE CAIXA DOC. ' + FieldByName('NUMDOC').AsString;
            cdsImpPag.FieldByName('FOR_NOMFOR').AsString   := FieldByName('NOMCLI').AsString;
            cdsImpPag.FieldByName('FOR_ENDERE').AsString   := FieldByName('ENDERE').AsString;
            cdsImpPag.FieldByName('FOR_ENDNUM').AsString   := FieldByName('ENDNUM').AsString;
            cdsImpPag.FieldByName('FOR_ENDCMP').AsString   := FieldByName('ENDCMP').AsString;
            cdsImpPag.FieldByName('FOR_BAIRRO').AsString   := FieldByName('BAIRRO').AsString;
            cdsImpPag.FieldByName('FOR_C_E_P_').AsString   := FieldByName('C_E_P_').AsString;
            cdsImpPag.FieldByName('FOR_CIDADE').AsString   := FieldByName('CIDADE').AsString;
            cdsImpPag.FieldByName('FOR_ESTADO').AsString   := FieldByName('ESTADO').AsString;
            cdsImpPag.FieldByName('FOR_C_G_C_').AsString   := FieldByName('C_G_C_').AsString;
            cdsImpPag.FieldByName('FOR_FONE01').AsString   := FieldByName('FONE01').AsString;
            cdsImpPag.FieldByName('NRODUP').AsString       := FieldByName('NUMDOC').AsString;
            cdsImpPag.FieldByName('ESPDOC').AsString       := FieldByName('ESPDOC').AsString;
            cdsImpPag.FieldByName('PARDUP').AsString       := FieldByName('PARCEL').AsString;
            cdsImpPag.FieldByName('CTP_CODEMP').AsString   := FieldByName('CODEMP').AsString;
            cdsImpPag.FieldByName('CTP_DTACAD').AsDateTime := dtaDtaCai;
            cdsImpPag.FieldByName('CTP_DTAVEN').AsDateTime := FieldByName('DTAVEN').AsDateTime;
            cdsImpPag.FieldByName('CTP_DTAREC').AsDateTime := dtaDtaCai;
            cdsImpPag.FieldByName('CTP_HORREC').AsDateTime := FieldByName('HORREC').AsDateTime;
            cdsImpPag.FieldByName('CTP_DTAPAG').AsDateTime := dtaDtaCai;
            cdsImpPag.FieldByName('CTP_VALJUR').AsFloat    := FieldByName('VALJUR').AsFloat;
            cdsImpPag.FieldByName('CTP_VALDES').AsFloat    := FieldByName('VALDES').AsFloat;
            cdsImpPag.FieldByName('CTP_VALDUP').AsFloat    := FieldByName('VALDOC').AsFloat;
            cdsImpPag.FieldByName('CTP_VALPAG').AsFloat    := FieldByName('VALREC').AsFloat;
            cdsImpPag.FieldByName('CTP_VALORI').AsFloat    := FieldByName('VALORI').AsFloat;
            cdsImpPag.FieldByName('CTP_CODCTA').AsString   := FieldByName('CODCTA').AsString;
            cdsImpPag.FieldByName('CTA_DESCTA').AsString   := FieldByName('DESCTA').AsString;
            cdsImpPag.FieldByName('CTP_FORMAS').AsString   := '';
            cdsImpPag.FieldByName('CTP_DINHEI').AsFloat    := fStrToFloat(edtDinRec.Text);
            If (edtDinRec.Text <> '0,00') Then
              cdsImpPag.FieldByName('CTP_FORMAS').AsString   := cdsImpPag.FieldByName('CTP_FORMAS').AsString
              + fPadL('DINHEIRO', 23) + ' - ' + fPadL(edtDinRec.Text, 14) + #13#10;
            If (edtCarRec.Text <> '0,00') Then
              cdsImpPag.FieldByName('CTP_FORMAS').AsString   := cdsImpPag.FieldByName('CTP_FORMAS').AsString
              + fPadL('CARTÃO', 23) + ' - ' + fPadL(edtCarRec.Text, 14) + #13#10;
            If (edtOrdRec.Text <> '0,00') Then
              cdsImpPag.FieldByName('CTP_FORMAS').AsString   := cdsImpPag.FieldByName('CTP_FORMAS').AsString
              + fPadL('ORDEM PGTO.', 23) + ' - ' + fPadL(edtOrdRec.Text, 14) + #13#10;
            If (edtChqRec.Text <> '0,00') Then
              cdsImpPag.FieldByName('CTP_FORMAS').AsString   := cdsImpPag.FieldByName('CTP_FORMAS').AsString
              + fPadL('CHEQUE À VISTA', 23) + ' - ' + fPadL(edtChqRec.Text, 14) + #13#10;
            If (edtChqPre.Text <> '0,00') Then
              cdsImpPag.FieldByName('CTP_FORMAS').AsString   := cdsImpPag.FieldByName('CTP_FORMAS').AsString
              + fPadL('CHEQUE PRÉ', 23) + ' - ' + fPadL(edtChqPre.Text, 14) + #13#10;

            cdsImpPag.FieldByName('CTP_NUMDUP').AsString := fCampoTabela('CONCAT(CTP_NUMDUP,CTP_PARCEL)', 'CADPAG',
                                                                         ['CTP_CODEMP', 'CTP_CODFOR', 'CTP_RESCAI', 'CTP_NUMDOC', 'CTP_DTAPAG'],
                                                                         [FieldByName('CODEMP').AsString, FieldByName('CODCLI').AsString, '1', FieldByName('NUMDOC').AsString, FormatDateTime('yyyy-mm-dd', dtaDtaCai)],
                                                                         True,
                                                                         '',
                                                                         Nil,
                                                                         True);

            If Not fEmptyStr(edtCodigoCaixa.Text) Then
              cdsImpPag.FieldByName('RCX_CAIXA').AsString   := 'CAIXA: ' + edtCodigoCaixa.Text;

            cdsImpPag.FieldByName('CTP_OPEBAI').AsString   := FieldByName('DESCOPEBAI').AsString;

            If (fCfgSis('RECCTP') = 'S') And (fCfgSis('RECCPV', varInteger) > 1) Then
            Begin
              cdsImpPag.FieldByName('CTP_VIAIMP').AsInteger := intContVia;
              cdsImpPag.FieldByName('CTP_QTVIAS').AsInteger := intQtdVias;
            End;

            cdsImpPag.Post;

            Next;
          End;
        End;
      End;

      If (fCfgSis('RECCTP') = 'S') And (fCfgSis('RECCPV', varInteger) > 1) Then
      Begin
        reciboCtpMeiaFolha  := TReciboCtpMeiaFolha.CreateInstance(cdsImpPag);
        editorFast.pSetFastPrintFile(reciboCtpMeiaFolha);
      End
      Else
      Begin
        reciboCtp  := TReciboCtp.CreateInstance(cdsImpPag);
        editorFast.pSetFastPrintFile(reciboCtp);
      End;

    End;

    //Abrindo impressora selecionada no autcom
    if strNomFil <> '' Then
      editorFast.pSelectFil(Self.Name, strNomFil, fRetNomeRede);

    Result := False;

    If (Pos('LC', strEspDoc) > 0) Then
      editorFast.intNumeroVias := fCfgSis('VIASLC', varInteger)
    Else If (Pos('PG', strEspDoc) > 0) Then
      editorFast.intNumeroVias := fCfgSis('VIASPG', varInteger)
    Else If (Pos('LD', strEspDoc) > 0) Then
      editorFast.intNumeroVias := fCfgSis('VIASLD', varInteger)
    Else
    begin
      If fCfgSis('RECCTR') = 'N' Then
        editorFast.intNumeroVias := fCfgSis('VIAREC', varInteger)
      else
        editorFast.intNumeroVias :=1;
    end;



    If (pgcDadosGerais.ActivePage = tbsRecebimentos) Or
       (Pos(strEspDoc,strEspLancamentos) > 0) Then
    Begin
      If editorFast.fLoadReport Then
      Begin
        Result := True;

        If intOpcao <> 1 Then
        Begin
          For intContador := 0 To Length(arrCodCli) - 1 Do
          Begin

            If Assigned(reciboCtrMeiaFolha) Then
            Begin
              With cdsImpRec Do
              Begin
                Filtered := False;
                Filter   := 'CODCLI = ' + QuotedStr(arrCodCli[intContador].strCodCli);
                Filtered := True;

                If Not IsEmpty Then
                  editorFast.pPrint;

              End;
            End
            Else
            Begin
              reciboCtr.pFiltraCds( 'CODCLI = ' + QuotedStr(arrCodCli[intContador].strCodCli) );
              editorFast.pPrint;
            End;

          End;

        End
        Else
        Begin
          If Not cdsImpRec.IsEmpty Then
            editorFast.pPrint;
        End;
      End;
    End
    Else
    If (pgcDadosGerais.ActivePage = tbsLancamentos) And
    (Pos('PG',strEspDoc) > 0) Then
    Begin
      If editorFast.fLoadReport Then
      Begin
        Result := True;

        If intOpcao <> 1 Then
        Begin
          For intContador := 0 To Length(arrCodCli) - 1 Do
          Begin

            With cdsImpRec Do
            Begin
              Filtered := False;
              Filter   := 'CTP_CODFOR = ' + QuotedStr(arrCodCli[intContador].strCodCli);
              Filtered := True;

              If Not IsEmpty Then
                editorFast.pPrint;
            End;

          End;

        End
        Else
        Begin
          If Not cdsImpRec.IsEmpty Then
            editorFast.pPrint;
        End;

      End;

    End;
  finally
    FreeAndNil(editorFast);
    reciboCtr           := nil;
    reciboCtrMeiaFolha  := nil;
    reciboCtp           := nil;
    reciboCtpMeiaFolha  := nil;

    if Assigned(cdsImpPag) then
    begin
      cdsImpPag.Close;
      FreeAndNil(cdsImpPag);
    end;
  end;
end;

function TfrmRcxResumoCaixa.fImprimirCarnePagamentos: Boolean;
  var
    intContador: Integer;
    objCarnePagto: TCarnePagamento;
begin
  Result := False;

  If (stlContratos.Count > 0) And fCfgSis('IMPCAR', VarBoolean) Then
  Begin
    For intContador := 0 To stlContratos.Count -1 Do
    Begin
      objCarnePagto := TCarnePagamento.Create(Self, stlContratos[intContador]);

      Result := objCarnePagto.fImprimirCarneRecibo;

      FreeAndNil(objCarnePagto);

      If Not Result Then
        Break;
    End;
  End;

  stlContratos.Clear;

end;

function TfrmRcxResumoCaixa.fInfDup(strCampo, strTitulo: String): String;
begin
  If Not fEmptyStr(cdsTmpResumoCaixa.FieldByName(strCampo).AsString) Then
    Result := ' - ' + strTitulo + ': ' + cdsTmpResumoCaixa.FieldByName(strCampo).AsString;
end;

procedure TfrmRcxResumoCaixa.pImprimirSangria(fltDinhei, fltCartao, fltChqAvi,
  fltChqPre, fltOrdPag: Double);

  Var
    strNumSer : String;

  procedure pSangrar(fltValor: Double);
  begin
    If fltValor > 0 Then
      VS_objFiscal.fSangria(fltValor);
  end;
begin
  If (Not fCfgSis('SSNECF', varBoolean)) Then
    Exit;

  If (fUtilizaImpressaoDeSangriaNoPDV) Then
  Begin
    strNumSer := fNumeroSerieImpressora(VS_strCodEmp);

    If Not fEmptyStr(strNumSer) Then
    Begin
      If fFormataFloat(fltDinhei, 2) <> 0 Then
        pGerarSangriaSuprimento(strNumSer, 'DINHEIRO', fltDinhei, intSeqCon, 'D');

      If fFormataFloat(fltCartao, 2) <> 0 Then
        pGerarSangriaSuprimento(strNumSer, 'CARTAO', fltCartao, intSeqCon, 'D');

      If fFormataFloat(fltChqAvi, 2) <> 0 Then
        pGerarSangriaSuprimento(strNumSer, 'CHEQUE VISTA', fltChqAvi, intSeqCon, 'D');

      If fFormataFloat(fltChqPre, 2) <> 0 Then
        pGerarSangriaSuprimento(strNumSer, 'CHEQUE PRE', fltChqPre, intSeqCon, 'D');

      If fFormataFloat(fltOrdPag, 2) <> 0 Then
        pGerarSangriaSuprimento(strNumSer, 'ORDEM PAGTO', fltOrdPag, intSeqCon, 'D');
    End;

    Exit;
  End;

  If (Not Assigned(VS_objFiscal)) Then
    Exit;

  pSangrar(fltDinhei);
  pSangrar(fltCartao);
  pSangrar(fltChqAvi);
  pSangrar(fltChqPre);
  pSangrar(fltOrdPag);
end;

procedure TfrmRcxResumoCaixa.pImprimirSuprimento(fltDinhei, fltCartao, fltChqAvi,
  fltChqPre, fltOrdPag: Double);

  Var
    strNumSer : String;

  procedure pEnviarSuprimento(fltValor: Double; strModalidade: String);
  begin
    If fltValor > 0 Then
      VS_objFiscal.fSuprimento(fltValor, strModalidade);
  end;
begin
  If (Not fCfgSis('SSNECF', varBoolean)) Then
    Exit;

  If (fUtilizaImpressaoDeSangriaNoPDV) Then
  Begin
    strNumSer := fNumeroSerieImpressora(VS_strCodEmp);

    If Not fEmptyStr(strNumSer) Then
    Begin
      If fFormataFloat(fltDinhei, 2) <> 0 Then
        pGerarSangriaSuprimento(strNumSer, 'DINHEIRO', fltDinhei, intSeqCon, 'C');

      If fFormataFloat(fltCartao, 2) <> 0 Then
        pGerarSangriaSuprimento(strNumSer, 'CARTAO', fltCartao, intSeqCon, 'C');

      If fFormataFloat(fltChqAvi, 2) <> 0 Then
        pGerarSangriaSuprimento(strNumSer, 'CHEQUE VISTA', fltChqAvi, intSeqCon, 'C');

      If fFormataFloat(fltChqPre, 2) <> 0 Then
        pGerarSangriaSuprimento(strNumSer, 'CHEQUE PRE', fltChqPre, intSeqCon, 'C');

      If fFormataFloat(fltOrdPag, 2) <> 0 Then
        pGerarSangriaSuprimento(strNumSer, 'ORDEM PAGTO', fltOrdPag, intSeqCon, 'C');
    End;

    Exit;
  End;

  If (Not Assigned(VS_objFiscal)) Then
    Exit;

  pEnviarSuprimento(fltDinhei, fDefineModalidadeEcf('001'));
  pEnviarSuprimento(fltCartao, fDefineModalidadeEcf('007'));
  pEnviarSuprimento(fltChqAvi, fDefineModalidadeEcf('006'));
  pEnviarSuprimento(fltChqPre, fDefineModalidadeEcf('002'));
  pEnviarSuprimento(fltOrdPag, fDefineModalidadeEcf('012'));

end;

function TfrmRcxResumoCaixa.fDefineModalidadeEcf(strCodFpg: String): String;
  Var
    qryAux: TUniQuery;
    strPatIni: String;
    strCodEcf: String;
begin
  strPatIni := fCfgSis('DIRINI');
  strCodEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA'   , '', strPatIni + '/opcoes_fiscal.ini' );

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT');
  qryAux.SQL.Add('  ECF_DESMOD ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  ECFMOD ');
  qryAux.SQL.Add('  JOIN FPGECF ON FPGECF.ECF_CODMOD = ECFMOD.ECF_CODMOD AND ');
  qryAux.SQL.Add('                 FPGECF.ECF_CODECF = ECFMOD.ECF_CODECF ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  ECFMOD.ECF_CODECF = :CODECF AND ');
  qryAux.SQL.Add('  FPGECF.FPG_CODIGO = :CODFPG ');

  qryAux.ParamByName('CODECF').AsString := strCodEcf;
  qryAux.ParamByName('CODFPG').AsString := strCodFpg;
  qryAux.Open;

  Result := qryAux.FieldByName('ECF_DESMOD').AsString;

  FreeAndNil(qryAux);
end;

function TfrmRcxResumoCaixa.fRetornaTotalCliente( strCodCli: String; strSql : String ): Real;
 Var qryTot : TUniQuery;
 Var fltTotCli : Real;
Begin

  Try

   qryTot := fCriaQuery();
   qryTot.sql.Text := strSql;
   qryTot.open;

   fltTotCli := 0;

   qryTot.First;
   while Not qryTot.Eof do
   begin
     if (strCodCli = qryTot.FieldByName('CTR_CODCLI').AsString) then
        fltTotCli := fltTotCli + qryTot.FieldByName('CTR_VALREC').AsFloat;
     qryTot.Next;
   end;

   result := fltTotCli;

  Finally
    FreeAndNil(qryTot);
  End;

End;

procedure TfrmRcxResumoCaixa.pAddDupVencidas;
var
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
begin
  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'DOCUMENTO'     , 16 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'EMP'           , 3  , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'CLIENTE'       , 40 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'ESPÉCIE'       , 7  , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'DT. CAD.'      , 10 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'DT. VENC.'     , 10 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'VR. ORIGINAL'  , 15 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'VR. DUPLICATA' , 15 , alDireita  , teAutcom);
  objTabela.lstLinhas.Add(objLinha);

  With cdsTmpResumoCaixa Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin

      If (FieldByName('CTR_MARDES').AsString = 'M') And (FieldByName('CTR_DTAVEN').AsDateTime < VS_Date) Then
      Begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('DOCUMENTO'     , FieldByName('CTR_DUPPAR').AsString                                , 16 , alEsquerda );
        objLinha.pAddColuna('EMP'           , FieldByName('CTR_CODEMP').AsString                                , 3  , alCentro   );
        objLinha.pAddColuna('CLIENTE'       , FieldByName('CTR_NOMCLI').AsString                                , 40 , alEsquerda );
        objLinha.pAddColuna('ESPÉCIE'       , FieldByName('CTR_ESPDOC').AsString                                , 7  , alCentro   );
        objLinha.pAddColuna('DT. CAD.'      , FormatDatetime('dd/mm/yyyy',FieldByName('CTR_DTACAD').AsDatetime) , 10 , alCentro   );
        objLinha.pAddColuna('DT. VEN.'      , FormatDatetime('dd/mm/yyyy',FieldByName('CTR_DTAVEN').AsDatetime) , 10 , alCentro   );
        objLinha.pAddColuna('VR. ORIGINAL'  , FormatFloat('###,##0.00', FieldByName('CTR_VALORI').AsFloat)      , 15 , alDireita  );
        objLinha.pAddColuna('VR. DUPLICATA' , FormatFloat('###,##0.00', FieldByName('CTR_VALDUP').AsFloat)      , 15 , alDireita  );
        objTabela.lstLinhas.Add(objLinha);

      End;
      Next;
    End;
    EnableControls;
  End;

  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
  objLiberacao.objMsgLibera.pAddQuebra;
end;

function TfrmRcxResumoCaixa.PagamentoEmUmaModalidade: Boolean;
  Var
    LModalidadesAtivas: Integer;
begin
  LModalidadesAtivas := 0;

  if fStrToFloat(edtDinRec.Text) > 0 then
    Inc(LModalidadesAtivas);

  if fStrToFloat(edtCarRec.Text) > 0 then
    Inc(LModalidadesAtivas);

  if fStrToFloat(edtChqRec.Text) > 0 then
    Inc(LModalidadesAtivas);

  if fStrToFloat(edtChqPre.Text) > 0 then
    Inc(LModalidadesAtivas);

  if fStrToFloat(edtOrdRec.Text) > 0 then
    Inc(LModalidadesAtivas);

  Result := LModalidadesAtivas = 1;
end;

procedure TfrmRcxResumoCaixa.pAddDupAVencer;
var
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
begin
  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'DOCUMENTO'     , 16 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'EMP'           , 3  , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'CLIENTE'       , 40 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'ESPÉCIE'       , 7  , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'DT. CAD.'      , 10 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'DT. VENC.'     , 10 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'VR. ORIGINAL'  , 15 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'VR. DUPLICATA' , 15 , alDireita  , teAutcom);
  objTabela.lstLinhas.Add(objLinha);

  With cdsTmpResumoCaixa Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin

      If (FieldByName('CTR_MARDES').AsString = 'M') And (FieldByName('CTR_DTAVEN').AsDateTime > VS_Date) Then
      Begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('DOCUMENTO'     , FieldByName('CTR_DUPPAR').AsString                                , 16 , alEsquerda );
        objLinha.pAddColuna('EMP'           , FieldByName('CTR_CODEMP').AsString                                , 3  , alCentro   );
        objLinha.pAddColuna('CLIENTE'       , FieldByName('CTR_NOMCLI').AsString                                , 40 , alEsquerda );
        objLinha.pAddColuna('ESPÉCIE'       , FieldByName('CTR_ESPDOC').AsString                                , 7  , alCentro   );
        objLinha.pAddColuna('DT. CAD.'      , FormatDatetime('dd/mm/yyyy',FieldByName('CTR_DTACAD').AsDatetime) , 10 , alCentro   );
        objLinha.pAddColuna('DT. VEN.'      , FormatDatetime('dd/mm/yyyy',FieldByName('CTR_DTAVEN').AsDatetime) , 10 , alCentro   );
        objLinha.pAddColuna('VR. ORIGINAL'  , FormatFloat('###,##0.00', FieldByName('CTR_VALORI').AsFloat)      , 15 , alDireita  );
        objLinha.pAddColuna('VR. DUPLICATA' , FormatFloat('###,##0.00', FieldByName('CTR_VALDUP').AsFloat)      , 15 , alDireita  );
        objTabela.lstLinhas.Add(objLinha);

      End;
      Next;
    End;
    EnableControls;
  End;

  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
  objLiberacao.objMsgLibera.pAddQuebra;
end;

procedure TfrmRcxResumoCaixa.pBuscaCtrsParaImpressao(
  intSeqCon: Integer);
Var
  qryPesq: TUniQuery;
  strNomCli,
  strSQL: String;
  intRecNo: Integer;
  fltValCredito : Double;

  strHisBai,
  strPorbai,
  strOpeBai : String;
begin
  fltValCredito := 0;

  strHisBai := '';
  strPorbai := '';
  strOpeBai := '';

  strSQL := '';
  strSQL := strSQL + 'SELECT                       ';

  strSQL := strSQL + '   CTR_OPEBAI,               ';
  strSQL := strSQL + '   CTR_PORBAI,               ';
  strSQL := strSQL + '   CTR_HISBAI,               ';

  strSQL := strSQL + '  CTR_CODCLI,                ';
  strSQL := strSQL + '  CTR_NUMDUP,                ';
  strSQL := strSQL + '  CTR_PARCEL,                ';
  strSQL := strSQL + '  CTR_ESPDOC,                ';
  strSQL := strSQL + '  CTR_CODEMP,                ';
  strSQL := strSQL + '  CTR_DTACAD,                ';
  strSQL := strSQL + '  CTR_DTAVEN,                ';
  strSQL := strSQL + '  CTR_SEQBAI,                ';
  strSQL := strSQL + '  CTR_SEQCON,                ';
  strSQL := strSQL + '  CTR_NOSNUM,                ';
  strSQL := strSQL + '  SUM(CTR_VALORI) AS CTR_VALDUP,  ';
  strSQL := strSQL + '  SUM(CTR_JURSUJ) AS CTR_JURSUJ,  ';
  strSQL := strSQL + '  SUM(CTR_DESCOB) AS CTR_DESCOB,  ';
  strSQL := strSQL + '  SUM(CTR_DESSUJ) AS CTR_DESSUJ,  ';
  strSQL := strSQL + '  SUM(CTR_VALORI) AS CTR_VALORI,  ';
  strSQL := strSQL + '  SUM(CTR_VALJUR) AS CTR_VALJUR,  ';
  strSQL := strSQL + '  SUM(CTR_VALCOB) AS CTR_VALCOB,  ';
  strSQL := strSQL + '  SUM(CTR_VALDES) AS CTR_VALDES,  ';
  strSQL := strSQL + '  SUM(CTR_VALREC) AS CTR_VALREC,  ';
  strSQL := strSQL + '  CTR_GRVORI AS CTR_GRVORI,  ';
  strSQL := strSQL + '  CTR_CODCTA,                ';
  strSQL := strSQL + '  CLI_CODCLI,                ';
  strSQL := strSQL + '  CLI_NOMCLI,                ';
  strSQL := strSQL + '  CLI_ENDERE,                ';
  strSQL := strSQL + '  CLI_ENDNUM,                ';
  strSQL := strSQL + '  CLI_ENDCOM,                ';
  strSQL := strSQL + '  CLI_BAIRRO,                ';
  strSQL := strSQL + '  CLI_C_E_P_,                ';
  strSQL := strSQL + '  CLI_CODCID,                ';
  strSQL := strSQL + '  CLI_C_G_C_,                ';
  strSQL := strSQL + '  CLI_FONE01,                ';
  strSQL := strSQL + '  CTR_VALANT,                ';
  strSQL := strSQL + '  CTR_HIST01,                ';
  strSQL := strSQL + '  CTR_HIST02,                ';
  strSQL := strSQL + '  CTR_RECPIX,                ';
  strSQL := strSQL + '  CLI_FANSOB,                ';
  strSQL := strSQL + '  CTR_COBANT                 ';
  strSQL := strSQL + 'FROM                         ';
  strSQL := strSQL + '  CADREC                     ';
  strSQL := strSQL + 'INNER JOIN CADCLI            ';
  strSQL := strSQL + '  ON CLI_CODCLI = CTR_CODCLI ';
  strSQL := strSQL + 'WHERE CTR_SEQCON = ' + IntToStr(intSeqCon);
  strSQL := strSQL + '  AND CTR_EMPBAI = ' + QuotedStr(VS_strCodEmp) + ' ';
  strSQL := strSQL + 'GROUP BY CTR_NUMDUP, CTR_PARCEL, CTR_ESPDOC, CTR_CODEMP, CTR_CODCLI, CTR_SEQCON, CTR_EMPBAI ';

  qryPesq := fCriaQuery();
  Try
    With qryPesq Do
    Begin
      SQL.Text := strSQL;
      Open;

      qryPesq.First;
      While Not qryPesq.Eof Do
      Begin
        If (qryPesq.FieldByName('CTR_VALREC').AsFloat < 0) And
         Not fEmptyStr(qryPesq.FieldByName('CTR_OPEBAI').AsString) Then
          fltValCredito := fltValCredito + qryPesq.FieldByName('CTR_VALREC').AsFloat;

        If fEmptyStr(strPorbai) Then
        Begin
          strHisBai := qryPesq.FieldByName('CTR_HISBAI').AsString ;
          strPorbai := qryPesq.FieldByName('CTR_PORBAI').AsString + ' - ' + fRetNomPortador(qryPesq.FieldByName('CTR_PORBAI').AsString);
          strOpeBai := qryPesq.FieldByName('CTR_OPEBAI').AsString + ' - ' + fRetNomeOperador(qryPesq.FieldByName('CTR_OPEBAI').AsString);
        End;

        qryPesq.Next;
      End;

      First;
      While Not Eof Do
      Begin
        cdsImpRec.Insert;
        cdsImpRec.FieldByName('HIST01').AsString   := FieldByName('CTR_HIST01').AsString;
        cdsImpRec.FieldByName('HIST02').AsString   := FieldByName('CTR_HIST02').AsString;
        cdsImpRec.FieldByName('CODCLI').AsString   := FieldByName('CTR_CODCLI').AsString;
        cdsImpRec.FieldByName('DESCRI').AsString   := FieldByName('CTR_CODCLI').AsString + '-' + FieldByName('CLI_NOMCLI').AsString;
        cdsImpRec.FieldByName('NUMDOC').AsString   := FieldByName('CTR_NUMDUP').AsString;
        cdsImpRec.FieldByName('PARCEL').AsString   := FieldByName('CTR_PARCEL').AsString;
        cdsImpRec.FieldByName('ESPDOC').AsString   := FieldByName('CTR_ESPDOC').AsString;
        cdsImpRec.FieldByName('CODEMP').AsString   := FieldByName('CTR_CODEMP').AsString;
        cdsImpRec.FieldByName('DTACAD').AsDateTime := FieldByName('CTR_DTACAD').AsDateTime;
        cdsImpRec.FieldByName('DTAVEN').AsDateTime := FieldByName('CTR_DTAVEN').AsDateTime;
        cdsImpRec.FieldByName('DTAREC').AsDateTime := VS_Date;
        cdsImpRec.FieldByName('HORREC').AsDateTime := fTime();
        cdsImpRec.FieldByName('DTABAI').AsDateTime := VS_Date;
        cdsImpRec.FieldByName('OPEBAI').AsString   := strLoginUsuarioLogado;
        cdsImpRec.FieldByName('CODVEN').AsString   := fBuscaVendedorDup(FieldByName('CTR_NUMDUP').AsString,
                                                                        FieldByName('CTR_PARCEL').AsString,
                                                                        FieldByName('CTR_ESPDOC').AsString,
                                                                        FieldByName('CTR_CODCLI').AsString,
                                                                        FieldByName('CTR_CODEMP').AsString);
        cdsImpRec.FieldByName('SEQBAI').AsInteger := FieldByName('CTR_SEQBAI').AsInteger;
        cdsImpRec.FieldByName('SEQCON').AsInteger := FieldByName('CTR_SEQCON').AsInteger;

        if fEmptyStr(FieldByName('CTR_NOSNUM').AsString) then
          cdsImpRec.FieldByName('NOSNUM').AsString  := fTrazNosNumDupZero(FieldByName('CTR_NUMDUP').AsString,
                                                                          FieldByName('CTR_PARCEL').AsString,
                                                                          FieldByName('CTR_ESPDOC').AsString,
                                                                          FieldByName('CTR_CODCLI').AsString,
                                                                          FieldByName('CTR_CODEMP').AsString)
        else
          cdsImpRec.FieldByName('NOSNUM').AsString  := FieldByName('CTR_NOSNUM').AsString;

        cdsImpRec.FieldByName('VALDOC').AsFloat   := FieldByName('CTR_VALDUP').AsFloat -
                                                     FieldByName('CTR_JURSUJ').AsFloat -
                                                     FieldByName('CTR_DESCOB').AsFloat +
                                                     FieldByName('CTR_DESSUJ').AsFloat;

        cdsImpRec.FieldByName('VALORI').AsFloat  := FieldByName('CTR_VALORI').AsFloat;
        cdsImpRec.FIeldByName('VALOR2').AsFloat  := FieldByName('CTR_GRVORI').AsFloat;
        cdsImpRec.FieldByName('COBANT').AsFloat  := FieldByName('CTR_COBANT').AsFloat;

        If (FieldByName('CTR_VALJUR').AsFloat - FieldByName('CTR_VALDES').AsFloat = 0) Then
          cdsImpRec.FieldByName('VALJUR').AsFloat  := 0
        else
          cdsImpRec.FieldByName('VALJUR').AsFloat  := FieldByName('CTR_VALJUR').AsFloat;

        intRecNo := cdsTmpResumoCaixa.RecNo;

        cdsTmpResumoCaixa.Filtered := False;
        cdsTmpResumoCaixa.Filter := 'CTR_NUMDUP = ' + QuotedStr(FieldByName('CTR_NUMDUP').AsString) + ' AND '  +
                                    'CTR_ESPDOC = ' + QuotedStr(FieldByName('CTR_ESPDOC').AsString) + ' AND '  +
                                    'CTR_CODCLI = ' + QuotedStr(FieldByName('CTR_CODCLI').AsString) + ' AND '  +
                                    'CTR_CODEMP = ' + QuotedStr(FieldByName('CTR_CODEMP').AsString) + ' AND '  +
                                    'CTR_PARCEL = ' + QuotedStr(FieldByName('CTR_PARCEL').AsString) + ' ';

        cdsTmpResumoCaixa.Filtered := True;

        if ((cdsImpRec.FieldByName('VALJUR').AsFloat = 0) and
            (fCfgSis('RECRCX') = 'B') and
            (cdsImpRec.FieldByName('SEQBAI').AsInteger > 0)) then
        begin
          if (cdsTmpResumoCaixa.FieldByName('CTR_VALCOR').AsFloat <> FieldByName('CTR_VALANT').AsFloat) then
          begin
            cdsImpRec.FieldByName('VALJUR').AsFloat := fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                                                           FieldByName('CTR_VALANT').AsFloat,
                                                                           fCfgSis('JURATR', varDouble));
          end;

          cdsImpRec.FieldByName('VALDOC').AsFloat := FieldByName('CTR_VALANT').AsFloat;
        end;

        cdsTmpResumoCaixa.Filtered := False;
        cdsTmpResumoCaixa.Filter := '';
        cdsTmpResumoCaixa.RecNo := intRecNo;

        cdsImpRec.FieldByName('VALCOB').AsFloat  := FieldByName('CTR_VALCOB').AsFloat;
        cdsImpRec.FieldByName('VALDES').AsFloat  := FieldByName('CTR_VALDES').AsFloat;
        cdsImpRec.FieldByName('DESCOB').AsFloat  := FieldByName('CTR_DESCOB').AsFloat;
        cdsImpRec.FieldByName('VALREC').AsFloat  := FieldByName('CTR_VALREC').AsFloat;

        cdsImpRec.FieldByName('VALRES').AsFloat := cdsTmpResumoCaixa.FieldByName('CTR_VALRES').asFloat;
        cdsImpRec.FieldByName('GRVORI').AsFloat := FieldByName('CTR_GRVORI').AsFloat;

        strNomCli := fRetNomCliente(FieldByName('CTR_CODCLI').AsString);
        cdsImpRec.FieldByName('CODCLI').AsString := FieldByName('CTR_CODCLI').AsString;
        cdsImpRec.FieldByName('NOMCLI').AsString := strNomCli;
        cdsImpRec.FieldByName('FANSOB').AsString := FieldByName('CLI_FANSOB').AsString;
        cdsImpRec.FieldByName('ENDERE').AsString := FieldByName('CLI_ENDERE').AsString;
        cdsImpRec.FieldByName('ENDNUM').AsString := FieldByName('CLI_ENDNUM').AsString;
        cdsImpRec.FieldByName('ENDCMP').AsString := FieldByName('CLI_ENDCOM').AsString;
        cdsImpRec.FieldByName('BAIRRO').AsString := FieldByName('CLI_BAIRRO').AsString;
        cdsImpRec.FieldByName('C_E_P_').AsString := FieldByName('CLI_C_E_P_').AsString;
        cdsImpRec.FieldByName('CIDADE').AsString := fRetNomCidade(FieldByName('CLI_CODCID').AsString);
        cdsImpRec.FieldByName('ESTADO').AsString := fRetUFCliente(FieldByName('CTR_CODCLI').AsString);
        cdsImpRec.FieldByName('C_G_C_').AsString := FieldByName('CLI_C_G_C_').AsString;
        cdsImpRec.FieldByName('FONE01').AsString := FieldByName('CLI_FONE01').AsString;
        cdsImpRec.FieldByName('VALREC').AsFloat := FieldByName('CTR_VALREC').AsFloat;
        cdsImpRec.FieldByName('CTR_ABERTO').AsFloat := fRetornaReceberAberto(FieldByName('CTR_CODCLI').AsString);
        cdsImpRec.FieldByName('CTR_TOTBLT').AsFloat := fRetornaReceberTotalBoletosEmAberto(FieldByName('CTR_CODCLI').AsString);
        cdsImpRec.FieldByName('CTR_TOTCRD').AsFloat := fRetornaReceberTotalCrediarioEmAberto(FieldByName('CTR_CODCLI').AsString);
        cdsImpRec.FieldByName('CTR_TOTCHD').AsFloat := fRetornaReceberTotalChequesDevolvidosEmAberto(FieldByName('CTR_CODCLI').AsString);
        cdsImpRec.FieldByName('CTR_CARTAO').AsFloat := fStrToFloat(edtCarRec.Text);
        cdsImpRec.FieldByName('CTR_CHQPRE').AsFloat := fStrToFloat(edtChqPre.Text);
        cdsImpRec.FieldByName('CTR_CHQAVI').AsFloat := fStrToFloat(edtChqRec.Text);
        cdsImpRec.FieldByName('CTR_DINHEI').AsFloat := fStrToFloat(edtDinRec.Text);
        cdsImpRec.FieldByName('CTR_ORDPAG').AsFloat := fStrToFloat(edtOrdRec.Text);

        cdsImpRec.FieldByName('DESCOPEBAI').AsString :=  strOpeBai;
        cdsImpRec.FieldByName('DESCPORBAI').AsString :=  strPorBai;
        cdsImpRec.FieldByName('DESCHISBAI').AsString :=  strHisBai;
        cdsImpRec.FieldByName('CTR_CREDITO').AsFloat := fltValCredito;

        If (Pos('CONSUMIDOR', strNomCli) > 0) Or
           (Pos('BALCAO', strNomCli) > 0)     Or
           (Pos('BALCÃO', strNomCli) > 0)     Then
        Begin
          cdsImpRec.FieldByName('NOMCLI').AsString := fRetCliConsumidor(FieldByName('CTR_CODCLI').AsString,
                                                                        FieldByName('CTR_NUMDUP').AsString,
                                                                        FieldByName('CTR_ESPDOC').AsString,
                                                                        FieldByName('CTR_CODEMP').AsString);
          cdsImpRec.FieldByName('DESCRI').AsString := FieldByName('CTR_CODCLI').AsString + '-' + cdsImpRec.FieldByName('NOMCLI').AsString;
        End;
        cdsImpRec.FieldByName('NOMCON').AsString := cdsImpRec.FieldByName('NOMCLI').AsString;

        cdsImpRec.FieldByName('CODCTA').AsString   := FieldByName('CTR_CODCTA').AsString;
        cdsImpRec.FieldByName('DESCTA').AsString   := fRetNomeConta( FieldByName('CTR_CODCTA').AsString );

        If Not fEmptyStr(edtCodigoCaixa.Text) Then
          cdsImpRec.FieldByName('RCX_CAIXA').AsString := 'CAIXA: ' + edtCodigoCaixa.Text;

        cdsImpRec.FieldByName('TOTCLI').AsFloat  := fRetornaTotalCliente( FieldByName('CTR_CODCLI').AsString, qryPesq.SQL.Text );

        cdsImpRec.FieldByName('RECPIX').AsString := FieldByName('CTR_RECPIX').AsString;

        cdsImpRec.FieldByName('CTR_SALDO').AsFloat := fRetornaSaldoAbertoCliente(FieldByName('CTR_CODCLI').AsString);

        cdsImpRec.FieldByName('DUPLICATA_TROCO').AsString := untReciboCtr.DuplicataCreditoReferenteATroco(cdsImpRec);
        If cdsImpRec.FieldByName('DUPLICATA_TROCO').AsString.Equals('S') Then
          cdsImpRec.FieldByName('VALOR_TROCO').AsFloat := Abs(FieldByName('CTR_VALREC').AsFloat);

        cdsImpRec.Post;

        Next;
      End;
    End;
  Finally
    FreeAndNil(qryPesq);
  End;
  If Not cdsImpRec.IsEmpty Then
    pCriarClientCreditoGerado(intSeqCon);
end;

procedure TfrmRcxResumoCaixa.pCancelarTefDeCartoesJaConfirmados;
  Var
    cartao: TCartoesResumoCaixa;
begin
  Self.Enabled := False;

  if (VS_blnTefCitel) then
  begin
    pGaranteCancelamentoTefCitel;
  end
  Else
  Begin
    For cartao In arrCartoes Do
    Begin
      If (FileExists(cartao.strArqTef)) Then
      Begin
        pGarantirCancelamentoTefRecebimento(cartao.strArqTef);
      End;

    End;
  End;

  Self.Enabled := True;
end;

procedure TfrmRcxResumoCaixa.pGaranteCancelamentoTefCitel;
var
  intContCartao : Integer;
begin
  for intContCartao := 0 to  Length(arrCartoes) - 1 do
  begin
    if fVerificaUtilizouTEFCitel(arrCartoes[intContCartao].strViaCli, arrCartoes[intContCartao].strViaLoj) then
    begin
      if arrCartoes[intContCartao].strStatusCartao = 'P' then
      begin
        pEstornaTransacaoPendente(False,
                                  arrCartoes[intContCartao].strDtaTra,
                                  arrCartoes[intContCartao].strHraTra,
                                  arrCartoes[intContCartao].strNumDoc,
                                  '');

        arrCartoes[intContCartao].strStatusCartao := 'C';

        pGravaTransacaoEstornada(arrCartoes[intContCartao].strNumDoc,
                                 arrCartoes[intContCartao].strNumNsu,
                                 arrCartoes[intContCartao].strDtaTra,
                                 arrCartoes[intContCartao].strHraTra,
                                 '',
                                 '',
                                 arrCartoes[intContCartao].fltValDig,
                                 arrCartoes[intContCartao].strControle);
      end
      else if fAutoConfirmaTransacaoPendenteEstaAtivada and
        (arrCartoes[intContCartao].strStatusCartao = 'F') then
      begin
        if fCancelaTransacaoEfetivada(
          fAjustaIdentificadorEstornoTef(arrCartoes[intContCartao]),
          arrCartoes[intContCartao].fltValDig,
          arrCartoes[intContCartao].strDtaTra,
          arrCartoes[intContCartao].strCodigoCarteiraDigital,
          arrCartoes[intContCartao].strCodigoTipoOperacaoCartao,
          arrCartoes[intContCartao].strCodigoBandeira) then
        begin
          arrCartoes[intContCartao].strStatusCartao := 'C';
        end;
      end;
    end;
  end;
end;

procedure TfrmRcxResumoCaixa.pGarantirCancelamentoTefRecebimento(strArquivo: String);
  Var
    blnVoltarEnabled: Boolean;
begin
  blnVoltarEnabled := Self.Enabled;
  Self.Enabled := False;
  While (Not objTefRecebimento.fCancelarRecebimento(strArquivo)) Do
  Begin
    Application.ProcessMessages;
  End;

  If blnVoltarEnabled Then
    Self.Enabled := True;

end;

function TfrmRcxResumoCaixa.fDigMoedas(fltTotalDin: Double): Boolean;
Begin
  Result := TRUE;

  frmRcxDigMoedas := TfrmRcxDigMoedas.Create(Application);

  With frmRcxDigMoedas Do
  Begin
    edtDinheiro.Text := FloatToStrF(fltTotalDin, ffFixed, 12, 2);
    edtGuarani.Text  := FloatToStrF(fltTotGua, ffFixed, 12, 2);
    edtDolar.Text    := FloatToStrF(fltTotDol, ffFixed, 12, 2);
    edtEuro.Text     := FloatToStrF(fltTotEur, ffFixed, 12, 2);
    edtPeso.Text     := FloatToStrF(fltTotPes, ffFixed, 12, 2);
    edtReal.Text     := FloatToStrF(fltTotRea, ffFixed, 12, 2);

    frmRcxDigMoedas.ShowModal;

    If frmRcxDigMoedas.blnConfirma Then
    Begin
      fltTotGua := fStrToFloat(edtGuarani.Text);
      fltTotDol := fStrToFloat(edtDolar.Text);
      fltTotEur := fStrToFloat(edtEuro.Text);
      fltTotPes := fStrToFloat(edtPeso.Text);
      fltTotRea := fStrToFloat(edtReal.Text);

      fltTotDinSav := fStrToFloat(edtDinRec.Text);
    End

    Else
      Result := FALSE;

  End;

  FreeAndNil(frmRcxDigMoedas);
End;

Procedure TfrmRcxResumoCaixa.pTrocaSinalMoedas(fltDinRec: Double);
Begin
  If fltDinRec < 0 Then
  Begin
    If fltTotGua > 0 Then
      fltTotGua := - fltTotGua;

    If fltTotDol > 0 Then
      fltTotDol := - fltTotDol;

    If fltTotEur > 0 Then
      fltTotEur := - fltTotEur;

    If fltTotPes > 0 Then
      fltTotPes := - fltTotPes;

    If fltTotRea > 0 Then
      fltTotRea := - fltTotRea;
  End;
End;

procedure TfrmRcxResumoCaixa.pMensagemCuponsMuitoVelhosSemImprimir;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  COUNT(*) QTD ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  MOVGER ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  GER_DTAENT <= DATE_SUB(CURRENT_DATE, INTERVAL 5 DAY) AND ');
  qryAux.SQL.Add('  GER_ESPDOC IN ("IF", "IV") AND ');
  qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  GER_IMPRES = 0 ');

  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.Open;

  If qryAux.FieldByName('QTD').AsInteger > 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'Há cupons não impressos, emitidos no Autcom a mais de 5 dias.'+  #13#10 +
      'Por favor imprima esses cupons no ECF ou cancele os documentos.', ['&Ok']);
  End;

  FreeAndNil(qryAux);
end;

procedure TfrmRcxResumoCaixa.pCarregaRede;
begin
  If Not fEmptyStr(edtCodRed.Text) Then
    edtDescRed.Text := fRetNomeRedeLoja(edtCodRed.Text)
  Else
    edtDescRed.text := 'TODOS';
end;

function TfrmRcxResumoCaixa.fGetModalidadesDigitadas: TArrModalidade;
begin
  FillChar(Result, SizeOf(Result), #0);

  If fStrToFloat(edtDinRec.Text) <> 0.00 Then
  Begin
    SetLength(Result, Length(Result) + 1);
    Result[Length(Result) - 1].strDesMod := 'DINHEIRO';
    Result[Length(Result) - 1].fltValMod := fStrToFloat(edtDinRec.Text);
  End;

  If fStrToFloat(edtCarRec.Text) <> 0.00 Then
  Begin
    SetLength(Result, Length(Result) + 1);
    Result[Length(Result) - 1].strDesMod := 'CARTÃO';
    Result[Length(Result) - 1].fltValMod := fStrToFloat(edtCarRec.Text);
  End;

  If fStrToFloat(edtOrdRec.Text) <> 0.00 Then
  Begin
    SetLength(Result, Length(Result) + 1);
    Result[Length(Result) - 1].strDesMod := 'ORDEM DE PAGAMENTO';
    Result[Length(Result) - 1].fltValMod := fStrToFloat(edtOrdRec.Text);
  End;

  If fStrToFloat(edtChqRec.Text) <> 0.00 Then
  Begin
    SetLength(Result, Length(Result) + 1);
    Result[Length(Result) - 1].strDesMod := 'CHEQUE A VISTA';
    Result[Length(Result) - 1].fltValMod := fStrToFloat(edtChqRec.Text);
  End;

  If fStrToFloat(edtChqPre.Text) <> 0.00 Then
  Begin
    SetLength(Result, Length(Result) + 1);
    Result[Length(Result) - 1].strDesMod := 'CHEQUE PRÉ';
    Result[Length(Result) - 1].fltValMod := fStrToFloat(edtChqPre.Text);
  End;

  If fStrToFloat(edtFinanc.Text) <> 0.00 Then
  Begin
    SetLength(Result, Length(Result) + 1);
    Result[Length(Result) - 1].strDesMod := 'FINANCIAMENTO';
    Result[Length(Result) - 1].fltValMod := fStrToFloat(edtFinanc.Text);
  End;
end;

function TfrmRcxResumoCaixa.fGetTitulosSelecionados: TArrDupSel;
begin
  FillChar(Result, SizeOf(Result), #0);

  cdsTmpResumoCaixa.First;
  While Not cdsTmpResumoCaixa.Eof Do
  Begin
    If cdsTmpResumoCaixa.FieldByName('CTR_MARDES').AsString = 'M' Then
    Begin
      SetLength(Result, Length(Result) + 1);

      Result[Length(Result) - 1].strNumDoc := cdsTmpResumoCaixa.FieldByName('CTR_NUMDUP').AsString;
      Result[Length(Result) - 1].strSeqBai := cdsTmpResumoCaixa.FieldByName('CTR_SEQBAI').AsString;
      Result[Length(Result) - 1].strCodCli := cdsTmpResumoCaixa.FieldByName('CTR_CODCLI').AsString;
      Result[Length(Result) - 1].strParcel := cdsTmpResumoCaixa.FieldByName('CTR_PARCEL').AsString;
      Result[Length(Result) - 1].strEspDoc := cdsTmpResumoCaixa.FieldByName('CTR_ESPDOC').AsString;
      Result[Length(Result) - 1].strCodEmp := cdsTmpResumoCaixa.FieldByName('CTR_CODEMP').AsString;
      Result[Length(Result) - 1].dtaDtaCad := cdsTmpResumoCaixa.FieldByName('CTR_DTACAD').AsDateTime;
      Result[Length(Result) - 1].dtaDtaVen := cdsTmpResumoCaixa.FieldByName('CTR_DTAVEN').AsDateTime;
      Result[Length(Result) - 1].fltVlrRec := cdsTmpResumoCaixa.FieldByName('CTR_VALREC').AsFloat;
    End;
    cdsTmpResumoCaixa.Next;
  End;
end;

function TfrmRcxResumoCaixa.fVerificaTitulosVencidosSelecionados(): Boolean;
  Var
      arrDups : TArrDupSel;
      intCont : Integer;
Begin

  Result := False;

  If cdsTmpResumoCaixa.Active Then
  Begin

    arrDups := fGetTitulosSelecionados();

    if (length(arrDups) > 0) then
    Begin
      For intCont := Low(arrDups) To High(arrDups) Do
      Begin
          If (arrDups[intCont].dtaDtaVen < VS_Date) Then
          Begin
             Result := True;
             Break;
          End;
      End;
    End;

  End;

End;

function TfrmRcxResumoCaixa.fVerificaTitulosAVencerSelecionados(): Boolean;
  Var
      arrDups : TArrDupSel;
      intCont : Integer;
Begin

  Result := False;

  If cdsTmpResumoCaixa.Active Then
  Begin

    arrDups := fGetTitulosSelecionados();

    if (length(arrDups) > 0) then
    Begin
      For intCont := Low(arrDups) To High(arrDups) Do
      Begin
          If (arrDups[intCont].dtaDtaVen > VS_Date) Then
          Begin
             Result := True;
             Break;
          End;
      End;
    End;

  End;

End;

function TfrmRcxResumoCaixa.fRetornaDocumentosTraDoc: TArrayInfoTraDoc;
var
  LrecTraDoc: TInfoTraDoc ;
  LarrTraDoc: TArrayInfoTraDoc ;
begin
  Result := Nil ;
  if not cdsTmpResumoCaixa.Active then
    Exit ;

  if cdsTmpResumoCaixa.IsEmpty then
    Exit ;

  cdsTmpResumoCaixa.First ;
  SetLength(LarrTraDoc, 0) ;
  while not cdsTmpResumoCaixa.Eof do
  begin
    If (cdsTmpResumoCaixa.FieldByName('CTR_MARDES').AsString = 'M') Then
    begin
      FillChar(LrecTraDoc, SizeOf(LrecTraDoc), #0);
      LrecTraDoc.CodEmp := VS_strCodEmp ;
      LrecTraDoc.DtaTra := Date ;
      LrecTraDoc.NumDup := cdsTmpResumoCaixa.FieldByName('CTR_NUMDUP').AsString ;
      LrecTraDoc.EspDoc := cdsTmpResumoCaixa.FieldByName('CTR_ESPDOC').AsString ;
      LrecTraDoc.Parcel := cdsTmpResumoCaixa.FieldByName('CTR_PARCEL').AsString ;
      LrecTraDoc.EmpDoc := cdsTmpResumoCaixa.FieldByName('CTR_CODEMP').AsString ;
      SetLength(LarrTraDoc, Length(LarrTraDoc)+1) ;
      LarrTraDoc[High(LarrTraDoc)] := LrecTraDoc ;
    end ;
    cdsTmpResumoCaixa.Next ;
  end ;
  Result := LarrTraDoc ;
end;

function TfrmRcxResumoCaixa.fRetornaStrClienteDocs(ArrDupSel : TArrDupSel) : String;
  Var Str : String;
      intContador : Integer;
Begin

    Str := '';
    For intContador := 0 To Length(ArrDupSel) -1 Do
      Str := Str + '"' + ArrDupSel[intContador].strCodCli + '"' +
                         IIF(intContador < Length(ArrDupSel) - 1, ',', ' ');

    Result := Str;

End;

function TfrmRcxResumoCaixa.fRetSQLClienteSelCredito() : String;
Var
    strSql,
    strInClientes : String;
Begin
  strSql        := '';
  strInClientes := '';

  strInClientes := fRetornaStrClienteDocs( fGetTitulosSelecionados() );

  strSql := strSql + ' SELECT ';
  strSql := strSql + '  AUTOINCREM, CLI_CODCLI, CLI_NOMCLI,  ';
  strSQL := strSQL + '  IF (CLI_CGCCPF = 1, CONCAT(SUBSTRING(CLI_C_G_C_,1,2),".", ';
  strSQL := strSQL + '                             SUBSTRING(CLI_C_G_C_,3,3),".", ';
  strSQL := strSQL + '                             SUBSTRING(CLI_C_G_C_,6,3),"/", ';
  strSQL := strSQL + '                             SUBSTRING(CLI_C_G_C_,9,4),"-", ';
  strSQL := strSQL + '                             SUBSTRING(CLI_C_G_C_,13,2)),   ';
  strSQL := strSQL + '                      CONCAT(SUBSTRING(CLI_C_G_C_,1,3),".", ';
  strSQL := strSQL + '                             SUBSTRING(CLI_C_G_C_,4,3),".", ';
  strSQL := strSQL + '                             SUBSTRING(CLI_C_G_C_,7,3),"/", ';
  strSQL := strSQL + '                             SUBSTRING(CLI_C_G_C_,10,2))) AS CLI_C_G_C_  ';
  strSql := strSql + ' FROM ';
  strSql := strSql + '   CADCLI ';
  strSql := strSql + ' WHERE ';
  strSql := strSql + '   CLI_CODCLI IN ('+ strInClientes +') ';

  result := strSql;

End;

function TfrmRcxResumoCaixa.fGetClienteSelCredito() : String;
 Var
     frmRcxSelClienteCred: TfrmRcxSelClienteCred;
begin

  Try

    result := '';

    pCriarFormularios(TfrmRcxSelClienteCred, frmRcxSelClienteCred);
    frmRcxSelClienteCred.qryCredCli.Close;
    frmRcxSelClienteCred.qryCredCli.SQL.Add( fRetSQLClienteSelCredito );
    frmRcxSelClienteCred.qryCredCli.Open;

    frmRcxSelClienteCred.cdsCadCli.Open;

    If (frmRcxSelClienteCred.qryCredCli.RecordCount > 1) Then
    Begin
        frmRcxSelClienteCred.ShowModal;

        If frmRcxSelClienteCred.blnConfirma Then
           result := frmRcxSelClienteCred.cdsCadCli.FieldByName('CLI_CODCLI').AsString;

    End
    Else
    If (frmRcxSelClienteCred.qryCredCli.RecordCount = 1) Then
        result := frmRcxSelClienteCred.cdsCadCli.FieldByName('CLI_CODCLI').AsString;

  Finally

    If Assigned(frmRcxSelClienteCred) Then
       FreeAndNil(frmRcxSelClienteCred);

  End;

end;

constructor TTransfOperador.Create(strOperador: String);
Begin
  Inherited Create();

  FOperador     := strOperador;
  FPorTrans     := '';

  FDinheiro     := 0.0;
  FChqAVista    := 0.0;
  FChqAPrazo    := 0.0;
  FCartao       := 0.0;
  FOrdPag       := 0.0;
  FFinanc       := 0.0;

  FDinheiro2    := 0.0;
  FFinanc2      := 0.0;
  FChqAVista2   := 0.0;
  FCartao2      := 0.0;
  FOrdPag2      := 0.0;
  FChqAPrazo2   := 0.0;
End;

procedure TfrmRcxResumoCaixa.pVerificaDireitosBotoes;
begin
  If Not fVerificaAcessoSistema('ACEF6_', strLoginUsuarioLogado) Then
    btnHisDeb.Enabled := False
  Else
    btnHisDeb.Enabled := True;

end;

function TfrmRcxResumoCaixa.fVerificaAlteracaoDespesaCobranca(strAutoin: String; flVlDescCob : Double): Boolean;
  Var
    qryAux: TUniQuery;
begin

  Result := False;

  qryAux := fCriaQuery(Nil);

  qryAux.SQL.Add(' SELECT ');
  qryAux.SQL.Add('   CTR_DESCOB ');
  qryAux.SQL.Add(' FROM ');
  qryAux.SQL.Add('   CADREC ');
  qryAux.SQL.Add(' WHERE ');
  qryAux.SQL.Add('   AUTOINCREM = :AUTOINC ');

  qryAux.ParamByName('AUTOINC').AsString := strAutoIn;
  qryAux.Open;

  If (Not qryAux.IsEmpty) Then
      Result := (qryAux.FieldByName('CTR_DESCOB').AsFloat <> flVlDescCob);

  FreeAndNil(qryAux);

end;

function TfrmRcxResumoCaixa.fGravaCreditoClienteTroco(fltValorTrc: Double;
                                                      strPortad: String;
                                                      intSeqCon: Integer;
                                                      strContaBai: string;
                                                      strCodEvento: string = '';
                                                      ARecebidoPorPix: String = 'N'): Boolean;
  Var
    fltValGra: Double;
    strCliGra: String;
    strNumDup: String;

    fltDinhei: Double;
    fltCartao: Double;
    fltChqVis: Double;
    fltChqPre: Double;
    fltOrdPag: Double;
    LHist01: String;

    LTotalPago: Double;
    LPercentualRepasseDinheiro: Double;
    LPercentualRepasseCartao: Double;
    LPercentualRepasseChequeAvista: Double;
    LPercentualRepasseChequePre: Double;
    LPercentualRepasseOrdemPagamento: Double;
    LDiferenca: Double;
    LTotalDistribuido: Double;

    LIndiceMaiorValor : Integer;
    LIndice : Integer;
    LEspeciesRecebimento: array of TEspeciesGerCC;

    qryUpd : TUniQuery;
    strSQL : String;
begin

  If fEmptyStr(strPortad) Then
  Begin
    Result := False;
    Exit;
  End;

  fltDinhei := fStrToFloat(edtDinRec.Text);
  fltCartao := fStrToFloat(edtCarRec.Text);
  fltChqVis := fStrToFloat(edtChqRec.Text);
  fltChqPre := fStrToFloat(edtChqPre.Text);
  fltOrdPag := fStrToFloat(edtOrdRec.Text);

  LTotalDistribuido := 0;

  Try

    fltValGra := fltValorTrc;

    strNumDup := RetornaSequencialCreditoCliente;
    LHist01   := 'REF. LANC. CREDITO';
    edtNumDoc.Text := strNumDup;

    With cdsTmpResumoCaixa Do
    Begin

      DisableControls;
      First;

      While (Not Eof) Do
      Begin

        If (FieldByName('CTR_MARDES').AsString <> 'M') Then
        Begin
          Next;
          Continue;
        End;

        strCliGra := FieldByName('CTR_CODCLI').AsString;
        Break;
      End;

      EnableControls;

    End;

    LHist01 := Concat(LHist01,' - ','CLIENTE: ', cdsTmpResumoCaixa.FieldByName('CTR_NOMCLI').AsString);

    If (fEmptyStr(strCliGra)) Then
    Begin
      fMensagem('', 'Não foi possivel determinar o cliente para gravação do crédito!', ['&Ok']);
      Result := False;
      Exit;
    End;

    LTotalPago := fltDinhei + fltCartao + fltChqVis + fltChqPre + fltOrdPag;

    SetLength(LEspeciesRecebimento,0);

    if fFormataFloat(fltDinhei, 2) > 0 then
    begin
      If blnRetirouTrocoDinheiro Then
        Exit(True); // se o troco for em dinheiro não grava;

      LPercentualRepasseDinheiro := fFormataFloat(fltDinhei / LTotalPago, 2);

      fltDinhei := fFormataFloat(fltValGra * LPercentualRepasseDinheiro, 2);
      edtDinRec.Text := FloatToStrF(fStrToFloat(edtDinRec.Text) - fltDinhei, ffFixed, 12, 2);
      LTotalDistribuido := LTotalDistribuido + fltDinhei;

      SetLength(LEspeciesRecebimento, length(LEspeciesRecebimento)+1);
      LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].StrEspecie    := 'CTR_DINHEI';
      LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltValor      := -fltDinhei;
      LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltPercPgto   := LPercentualRepasseDinheiro;
      LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltVlrCredito :=  -fltDinhei;
      LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltCreditoCalc := -fltDinhei;
    end;

    if fFormataFloat(fltCartao, 2) > 0 then
    begin
      LPercentualRepasseCartao := fFormataFloat(fltCartao / LTotalPago, 2);

      fltCartao := fFormataFloat(fltValGra * LPercentualRepasseCartao, 2);
      edtCarRec.Text := FloatToStrF(fStrToFloat(edtCarRec.Text) - fltCartao, ffFixed, 12, 2);
      LTotalDistribuido := LTotalDistribuido + fltCartao;

      SetLength(LEspeciesRecebimento, length(LEspeciesRecebimento)+1);
      LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].StrEspecie    := 'CTR_CARTAO';
      LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltValor      := -fltCartao;
      LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltPercPgto   := LPercentualRepasseCartao;
      LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltVlrCredito :=  -fltCartao;
      LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltCreditoCalc := -fltCartao;
    end;

    if fFormataFloat(fltChqVis, 2) > 0 then
    begin
      LPercentualRepasseChequeAvista := fFormataFloat(fltChqVis / LTotalPago, 2);

      fltChqVis := fFormataFloat(fltValGra * LPercentualRepasseChequeAvista, 2);
      edtChqRec.Text := FloatToStrF(fStrToFloat(edtChqRec.Text) - fltChqVis, ffFixed, 12, 2);
      LTotalDistribuido := LTotalDistribuido + fltChqVis;

      SetLength(LEspeciesRecebimento, length(LEspeciesRecebimento)+1);
      LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].StrEspecie    := 'CTR_CHQAVI';
      LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltValor      := -fltChqVis;
      LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltPercPgto   := LPercentualRepasseChequeAvista;
      LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltVlrCredito :=  -fltChqVis;
      LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltCreditoCalc := -fltChqVis;
    end;

    if fFormataFloat(fltChqPre, 2) > 0 then
    begin
      LPercentualRepasseChequePre := fFormataFloat(fltChqPre / LTotalPago, 2);

      fltChqPre := fFormataFloat(fltValGra * LPercentualRepasseChequePre, 2);
      edtChqPre.Text := FloatToStrF(fStrToFloat(edtChqPre.Text) - fltChqPre, ffFixed, 12, 2);
      LTotalDistribuido := LTotalDistribuido + fltChqPre;

      SetLength(LEspeciesRecebimento, length(LEspeciesRecebimento)+1);
      LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].StrEspecie    := 'CTR_CHQPRE';
      LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltValor      := -fltChqPre;
      LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltPercPgto   := LPercentualRepasseChequePre;
      LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltVlrCredito :=  -fltChqPre;
      LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltCreditoCalc := -fltChqPre;
    end;

    if fFormataFloat(fltOrdPag, 2) > 0 then
    begin
      LPercentualRepasseOrdemPagamento := fFormataFloat(fltOrdPag / LTotalPago, 2);

      fltOrdPag := fFormataFloat(fltValGra * LPercentualRepasseOrdemPagamento, 2);
      edtOrdRec.Text := FloatToStrF(fStrToFloat(edtOrdRec.Text) - fltOrdPag, ffFixed, 12, 2);
      LTotalDistribuido := LTotalDistribuido + fltOrdPag;

      SetLength(LEspeciesRecebimento, length(LEspeciesRecebimento)+1);
      LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].StrEspecie    := 'CTR_ORDPAG';
      LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltValor      := -fltOrdPag;
      LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltPercPgto   := LPercentualRepasseOrdemPagamento;
      LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltVlrCredito :=  -fltOrdPag;
      LEspeciesRecebimento[Length(LEspeciesRecebimento)-1].fltCreditoCalc := -fltOrdPag;
    end;

    LDiferenca := fFormataFloat(fltValGra - LTotalDistribuido, 2);
    if fFormataFloat(LDiferenca, 2) <> 0 then
    begin
      LIndiceMaiorValor := 0;
      for LIndice := 0 to Length(LEspeciesRecebimento) - 1 do
      begin
        if LEspeciesRecebimento[LIndice].fltValor > LEspeciesRecebimento[LIndiceMaiorValor].fltValor then
          LIndiceMaiorValor := LIndice;
      end;

      LEspeciesRecebimento[LIndiceMaiorValor].fltValor := LEspeciesRecebimento[LIndiceMaiorValor].fltValor + fFormataFloat(LDiferenca, 2);

      case AnsiIndexStr(LEspeciesRecebimento[LIndiceMaiorValor].StrEspecie, ['CTR_DINHEI', 'CTR_CARTAO', 'CTR_CHQAVI', 'CTR_CHQPRE', 'CTR_ORDPAG'] ) of
        0 :Begin
             edtDinRec.Text := FloatToStrF(fStrToFloat(edtDinRec.Text) - LDiferenca, ffFixed, 12, 2);
             fltDinhei :=  fFormataFloat(fltDinhei - (LDiferenca * -1),2);
           End;
        1 :Begin
             edtCarRec.Text := FloatToStrF(fStrToFloat(edtCarRec.Text) - LDiferenca, ffFixed, 12, 2);
             fltCartao := fFormataFloat(fltCartao -  (LDiferenca * -1), 2);
           End;
        2 :Begin
             edtChqRec.Text := FloatToStrF(fStrToFloat(edtChqRec.Text) - LDiferenca, ffFixed, 12, 2);
             fltChqVis :=  fFormataFloat(fltChqVis -  (LDiferenca * -1), 2);
           End;
        3 :Begin
             edtChqPre.Text := FloatToStrF(fStrToFloat(edtChqPre.Text) - LDiferenca, ffFixed, 12, 2);
             fltChqPre  := fFormataFloat(fltChqPre -  (LDiferenca * -1), 2);
           End;
        4 :Begin
             edtOrdRec.Text := FloatToStrF(fStrToFloat(edtOrdRec.Text) - LDiferenca, ffFixed, 12, 2);
             fltOrdPag := fFormataFloat(fltOrdPag - (LDiferenca * -1), 2);
           End;
      end;

    end;

    pTrocaSinalMoedas(fltDinhei);

    Result := fGravaCadRec(Self.Name,
                           'INCLUSÃO',
                           strNumDup,                                                          // Duplicata
                           'A',                                                                // Parcela
                           0,                                                                  // Sequencial de Baixa
                           'CC',                                                               // Espécie
                           strCliGra,                                                          // Cliente
                           VS_strCodEmp,                                                       // Empresa
                           edtCodOpe.Text,                                                     // Vendedor
                           edtCodOpe.Text,                                                     // Digitador
                           strPortad,                                                          // Portador
                           VS_Date,                                                            // Data de Cadastro
                           VS_Date,                                                            // Data de Vencimento
                           0.00,                                                               // Valor da Duplicata
                           -fltValGra,                                                         // Valor Original
                           0.0,                                                                // Despesa de Cobrança
                           'N',                                                                // Desconto
                           LHist01,                                                            // Histórico 1
                           '',                                                                 // Histórico 2
                           strPortad,                                                          // Portador da Baixa
                           strContaBai,                                                        // Centro de Custo da Baixa
                           edtCodOpe.Text,                                                     // Operador da Baixa
                           strNumDup,                                                          // Documento da Baixa
                           -fltValGra,                                                         // Valor do Recebimento
                           VS_Date,                                                            // Data do Recebimento
                           'N',
                           strCodEvento,                                                       // Código do Evento
                           '',                                                                 // Código Velho (CONVERSÃO)
                           '',                                                                 // Tipo de Fora (Condição de Pagamento)
                           '',                                                                 // Código da Condição de Pagamento
                           False,
                           IIF(fEmptyStr(fCfgSis('CTR_CC')),'',fCfgSis('CTR_CC')),             // Codigo do Centro de Custo
                           intSeqCon,                                                          // Sequencial de Controle
                           0,
                           '',                                                                 // Observação de Agrupamento 1
                           '',                                                                 // Observação de Agrupamento 2
                           '',                                                                 // Observação de Agrupamento 3
                           '',
                           0,
                           1,
                           0,
                           0,
                           VS_strCodEmp,
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
                           -fltValGra,
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
                           ARecebidoPorPix);

    If (Not Result) Then
    Begin
      fRollBack;
      Exit;
    End;

    If Result Then
    Begin
      Try
        Try
          qryUpd := fCriaQuery(nil);
          strSQL := strSQL + ' UPDATE CADREC ';
          strSQL := strSQL + '    SET CTR_SEQCON = :SEQCON ';
          strSQL := strSQL + '  WHERE ';
          strSQL := strSQL + '      CTR_NUMDUP = :NUMDUP ';
          strSQL := strSQL + '  AND CTR_ESPDOC = :ESPDOC ';
          strSQL := strSQL + '  AND CTR_CODCLI = :CODCLI ';
          strSQL := strSQL + '  AND CTR_PARCEL = :PARCEL ';
          strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP ';

          qryUpd.Close;
          qryUpd.SQL.Text := strSQL;
          qryUpd.ParamByName('SEQCON').AsInteger := intSeqCon;
          qryUpd.ParamByName('NUMDUP').AsString  := strNumDup;
          qryUpd.ParamByName('ESPDOC').AsString  := 'CC';
          qryUpd.ParamByName('CODCLI').AsString  := strCliGra;
          qryUpd.ParamByName('PARCEL').AsString  := 'A';
          qryUpd.ParamByName('CODEMP').AsString  := VS_strCodEmp;
          qryUpd.ExecSQL;
        Except
          fRollBack;
          Raise;
        End;
      Finally
        If Assigned(qryUpd) Then
          FreeAndNil(qryUpd);
      End;
    End;

    //**************************************************//
    // LANCA VALOR POSITIVO NO CAIXA REFERENTE AO TROCO //
    //**************************************************//
      Result := fGravaCadRcx(strSeqRcx,
                             strCliGra,                  // Cliente
                             edtCodOpe.Text,             // Operador
                             strNumDup,                  // Documento
                             'CC',                       // Espécie
                             VS_strCodEmp,               // Empresa
                             dtaDtaCai,                  // Data de Cadastro
                             fTime(),                    // Hora de Cadastro
                             strNumDup,                  // Duplicata
                             'A',                        // Parcela
                             'REF. A CRED. DE CLIENTE',  // Descrição
                             '',                         // Juros / Desconto
                             '',                         // Identificação de Fechamento
                             '',                         // Forma de Pagamento
                             fltValGra,                  // Valor do Documento
                             0.0,                        // Valor do Desconto
                             0.0,                        // Valor do Juros
                             fltDinhei,                  // Dinheiro recebido
                             fltChqVis,                  // Cheque a vista
                             fltChqPre,                  // Cheque pre datado
                             fltCartao,                  // Valor em Cartã
                             fltOrdPag,                  // Valor em Ordem de Pagamento
                             0.0,                        // Valor do Crédito
                             0.0,                        // Valor em Financiamento
                             0.0,                        // Valor de outros
                             0.0,                        // Venda a prazo
                             '',                         //Num. do Romaneio
                             intSeqCon,                  //Sequencial de Controle
                             0,                          //Sequencial de Baixa (Duplicata)
                             fCfgSisL('SQFCRX'),         //Sequencial de Fechamento parcial de caixa
                             VS_strCodEmp,               //Empresa da Duplicata
                             Trim(strMotDes),            //Motivo do desconto
                             2,                          // Identificação do Caixa
                             fltTotGua,
                             fltTotDol,
                             fltTotEur,
                             fltTotPes,
                             fltTotRea,
                             'N',
                             '',
                             edtCodigoCaixa.Text,
                             '',
                             0.00,
                             False,
                             0.00,
                             '',
                             0,
                             ARecebidoPorPix);

      If (Not Result) Then
      Begin
        fRollBack;
        Exit;
      End;

      //**************************************************//
      // LANCA VALOR NEGATIVO NO CAIXA REFERENTE AO TROCO //
      //**************************************************//
      Result := fGravaCadRcx(strSeqRcx,
                             strCliGra,                  // Cliente
                             edtCodOpe.Text,             // Operador
                             strNumDup,                  // Documento
                             'LD',                       // Espécie
                             VS_strCodEmp,               // Empresa
                             dtaDtaCai,                  // Data de Cadastro
                             fTime(),                    // Hora de Cadastro
                             strNumDup,                  // Duplicata
                             'A',                        // Parcela
                             'REF. A TROCO DE CLIENTE',  // Descrição
                             '',                         // Juros / Desconto
                             '',                         // Identificação de Fechamento
                             '',                         // Forma de Pagamento
                             -fltValGra,                 // Valor do Documento
                             0.0,                        // Valor do Desconto
                             0.0,                        // Valor do Juros
                             -fltValGra,                 // Dinheiro recebido
                             0.0,                        // Cheque a vista
                             0.0,                        // Cheque pre datado
                             0.0,                        // Valor em Cartã
                             0.0,                        // Valor em Ordem de Pagamento
                             0.0,                        // Valor do Crédito
                             0.0,                        // Valor em Financiamento
                             0.0,                        // Valor de outros
                             0.0,                        // Venda a prazo
                             '',                         //Num. do Romaneio
                             intSeqCon,                  //Sequencial de Controle
                             0,                          //Sequencial de Baixa (Duplicata)
                             fCfgSisL('SQFCRX'),         //Sequencial de Fechamento parcial de caixa
                             VS_strCodEmp,               //Empresa da Duplicata
                             Trim(strMotDes),            //Motivo do desconto
                             2,                          // Identificação do Caixa
                             fltTotGua,
                             fltTotDol,
                             fltTotEur,
                             fltTotPes,
                             fltTotRea,
                             'N',
                             '',
                             edtCodigoCaixa.Text,
                             '',
                             0.00,
                             False,
                             0.00,
                             '',
                             0,
                             ARecebidoPorPix);

      If (Not Result) Then
      Begin
        fRollBack;
        Exit;
      End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fGravaCreditoClienteTroco]');
      Result := False;
    End;
  End;

end;

end.


